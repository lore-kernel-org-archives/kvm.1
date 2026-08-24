Received: from out28-220.mail.aliyun.com (out28-220.mail.aliyun.com [115.124.28.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BE13624BC
	for <kvm@vger.kernel.org>; Mon, 24 Aug 2026 04:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787547233; cv=none; b=U4UVxiaJEWiwD6uXebJE0Yp0VS/Ttx8oCeFe7Hzpn18JMy3WNZQ4bhjp6YYyMjhVqKWYJPUEDYwNjxxwDN5wfjL6s7SrbN+5Mx/yAJWX6Ii4h66GwUeB1O+hVZ29OBhjgllgVcLaJMUm3vtiuPirYSZdEl+xx6es/IVJxTC0a8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787547233; c=relaxed/simple;
	bh=97QvnuEvfOoWmFKlgIJATWJxRHjRfm7k3/gRvCFCkw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PiNFmwpBWs6DZ6MQRisNp7PysOYp31MdoET7mvp0IsoinVRA2Z5T5MaqX6fq7gkND9bHZkgYrCN2TS+1kX5mYB8tcS8CnGupAV2ELYT8WoPeRDTvyy80TdhsUHDcMjmYYhefHaz7+GISwFNZU2HUQ3PG/FuP0XJw0KhjfRd1/sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00957263-0.000683732-0.989744;FP=7745995268663411031|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033045213054;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.ivXOSqU_1787547222;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.ivXOSqU_1787547222 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 24 Aug 2026 12:53:42 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>
Cc: kvm@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yanjing Zhou <zhouyanjing@hygon.cn>,
	Tina Zhang <zhang_wei@open-hieco.net>
Subject: [PATCH v3 05/10] target/i386/kvm: Classify PMU vendor families
Date: Mon, 24 Aug 2026 12:53:09 +0800
Message-ID: <20260824045314.162941-6-zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260824045314.162941-1-zhang_wei@open-hieco.net>
References: <20260824045314.162941-1-zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Intel and Zhaoxin PMU architectures are compatible, while AMD uses
a separate PMU CPUID/MSR layout.  KVM's PMU initialization, host/guest
compatibility, and MSR save/restore paths open-code these vendor checks
in several places.

Introduce X86PMUVendor and helpers that classify the existing CPU and
host vendors by PMU architecture.  Use the classification consistently
for the compatibility check, PMU initialization, and PMU MSR paths.

This is a refactoring with no functional change.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 target/i386/kvm/kvm.c | 72 +++++++++++++++++++++++++++++++++----------
 1 file changed, 55 insertions(+), 17 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index d1c6dbe636..01fc1d0674 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2166,24 +2166,53 @@ static void kvm_init_pmu_info_amd(struct kvm_cpuid2 *cpuid, X86CPU *cpu)
     }
 }
 
-static bool is_host_compat_vendor(CPUX86State *env)
+typedef enum X86PMUVendor {
+    X86_PMU_VENDOR_UNKNOWN,
+    X86_PMU_VENDOR_INTEL,
+    X86_PMU_VENDOR_AMD,
+} X86PMUVendor;
+
+static X86PMUVendor x86_cpu_pmu_vendor(const CPUX86State *env)
+{
+    if (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env)) {
+        return X86_PMU_VENDOR_INTEL;
+    }
+
+    if (IS_AMD_CPU(env)) {
+        return X86_PMU_VENDOR_AMD;
+    }
+
+    return X86_PMU_VENDOR_UNKNOWN;
+}
+
+static X86PMUVendor x86_host_pmu_vendor(void)
 {
     char host_vendor[CPUID_VENDOR_SZ + 1];
 
     host_cpu_vendor_fms(host_vendor, NULL, NULL, NULL);
 
-    /*
-     * Intel and Zhaoxin are compatible.
-     */
-    if ((g_str_equal(host_vendor, CPUID_VENDOR_INTEL) ||
-         g_str_equal(host_vendor, CPUID_VENDOR_ZHAOXIN1) ||
-         g_str_equal(host_vendor, CPUID_VENDOR_ZHAOXIN2)) &&
-        (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env))) {
-        return true;
+    if (g_str_equal(host_vendor, CPUID_VENDOR_INTEL) ||
+        g_str_equal(host_vendor, CPUID_VENDOR_ZHAOXIN1) ||
+        g_str_equal(host_vendor, CPUID_VENDOR_ZHAOXIN2)) {
+        return X86_PMU_VENDOR_INTEL;
     }
 
-    return g_str_equal(host_vendor, CPUID_VENDOR_AMD) &&
-           IS_AMD_CPU(env);
+    if (g_str_equal(host_vendor, CPUID_VENDOR_AMD)) {
+        return X86_PMU_VENDOR_AMD;
+    }
+
+    return X86_PMU_VENDOR_UNKNOWN;
+}
+
+/*
+ * The guest vPMU can be virtualized only when the host and guest PMU
+ * architectures are compatible.
+ */
+static bool is_host_compat_vendor(CPUX86State *env)
+{
+    X86PMUVendor guest = x86_cpu_pmu_vendor(env);
+
+    return guest != X86_PMU_VENDOR_UNKNOWN && guest == x86_host_pmu_vendor();
 }
 
 static void kvm_init_pmu_info(struct kvm_cpuid2 *cpuid, X86CPU *cpu)
@@ -2211,10 +2240,15 @@ static void kvm_init_pmu_info(struct kvm_cpuid2 *cpuid, X86CPU *cpu)
         return;
     }
 
-    if (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env)) {
+    switch (x86_cpu_pmu_vendor(env)) {
+    case X86_PMU_VENDOR_INTEL:
         kvm_init_pmu_info_intel(cpuid);
-    } else if (IS_AMD_CPU(env)) {
+        break;
+    case X86_PMU_VENDOR_AMD:
         kvm_init_pmu_info_amd(cpuid, cpu);
+        break;
+    case X86_PMU_VENDOR_UNKNOWN:
+        break;
     }
 }
 
@@ -4268,7 +4302,8 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
             kvm_msr_entry_add(cpu, MSR_KVM_POLL_CONTROL, env->poll_control_msr);
         }
 
-        if ((IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env)) && pmu_version > 0) {
+        if (x86_cpu_pmu_vendor(env) == X86_PMU_VENDOR_INTEL &&
+            pmu_version > 0) {
             if (pmu_version > 1) {
                 /* Stop the counter.  */
                 kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
@@ -4300,7 +4335,8 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
             }
         }
 
-        if (IS_AMD_CPU(env) && pmu_version > 0) {
+        if (x86_cpu_pmu_vendor(env) == X86_PMU_VENDOR_AMD &&
+            pmu_version > 0) {
             uint32_t sel_base = MSR_K7_EVNTSEL0;
             uint32_t ctr_base = MSR_K7_PERFCTR0;
             /*
@@ -4846,7 +4882,8 @@ static int kvm_get_msrs(X86CPU *cpu)
         kvm_msr_entry_add(cpu, MSR_KVM_POLL_CONTROL, 1);
     }
 
-    if ((IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env)) && pmu_version > 0) {
+    if (x86_cpu_pmu_vendor(env) == X86_PMU_VENDOR_INTEL &&
+        pmu_version > 0) {
         if (pmu_version > 1) {
             kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
             kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_CTRL, 0);
@@ -4862,7 +4899,8 @@ static int kvm_get_msrs(X86CPU *cpu)
         }
     }
 
-    if (IS_AMD_CPU(env) && pmu_version > 0) {
+    if (x86_cpu_pmu_vendor(env) == X86_PMU_VENDOR_AMD &&
+        pmu_version > 0) {
         uint32_t sel_base = MSR_K7_EVNTSEL0;
         uint32_t ctr_base = MSR_K7_PERFCTR0;
         /*
-- 
2.43.7

