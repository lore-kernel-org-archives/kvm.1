Received: from out28-125.mail.aliyun.com (out28-125.mail.aliyun.com [115.124.28.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1C123E330
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 08:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786350674; cv=none; b=ew9E1KtShMWiLD0tvarR2+skVa2jQBuDihUG6NdryFsISLj7xCJxRafLaA47rEtqW3gzas36VSbUR2IZulhnnSMHSVuRtWrfwk2yHSHGJl3mFBPlvBnHxxVeOcDuG/RGFoG8/+OyCDh73R0pWQPkwMB0lF2Z2l/uiPOv94KuAuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786350674; c=relaxed/simple;
	bh=QJMC82/h9TKO6ud28ZUQ9y98zXOfXn+P5yGJbFVejL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJrjSL8J6sAXEpLWsyFDgqPFek1KB/ii9Ei8691swH799tfEGiY6Wj/VLECWHj361KGC+VQp8A/hZ46RuQM5PjpQVP6IFsgxcPYCdK1uRhFBRPJOLdPxuDrGApI1XvrKyY8PjhgZXCIPVXqF5GVPfHW3cavW8Rg0itcR3pBAOtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00967293-0.000767904-0.989559;FP=7743778515548045655|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.iiL7hNB_1786350662;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iiL7hNB_1786350662 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 10 Aug 2026 16:31:02 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Yanjing Zhou <zhouyanjing@hygon.cn>,
	Tina Zhang <zhang_wei@open-hieco.net>
Subject: [PATCH v2 5/9] target/i386/kvm: Use AMD PMU MSR paths for Hygon
Date: Mon, 10 Aug 2026 16:29:52 +0800
Message-ID: <20260810082956.1768042-6-zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260810082956.1768042-1-zhang_wei@open-hieco.net>
References: <20260810082956.1768042-1-zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On SVM, KVM uses the AMD PMU implementation and AMD PMU CPUID/MSR
layout.  Hygon guests that enable PMU and request AMD PMU CPUID
features such as perfctr-core need QEMU's KVM PMU setup and MSR state
paths to use that layout too.

The relevant QEMU KVM PMU paths are currently restricted to
AuthenticAMD guests: host/guest PMU compatibility checks, AMD PMU
information initialization, and AMD PMU MSR save/restore.  For a Hygon
Dhyana guest with pmu=on, the compatibility check reports vPMU as
unsupported solely because the guest vendor is HygonGenuine rather than
AuthenticAMD.  If the VM continues, QEMU still skips AMD PMU setup and
never saves or restores the AMD PMU MSRs for the Hygon guest.

Treat Hygon as using the AMD PMU CPUID/MSR layout for these KVM PMU
paths.  Because the PMU MSR layout is shared, accept both AMD and Hygon
hosts for guests using that layout.  This intentionally allows the PMU
compatibility check to pass for AMD-host/Hygon-guest and
Hygon-host/AMD-guest combinations.

This does not enable PMU, perfctr-core, or perfmon-v2 by default for the
Dhyana CPU model.  On backward migration to older QEMU, Hygon PMU MSR
state may still be dropped because older QEMU did not write that state
back through the AMD PMU MSR KVM paths for Hygon guests.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 target/i386/kvm/kvm.c | 73 +++++++++++++++++++++++++++++++++----------
 1 file changed, 56 insertions(+), 17 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index aa32b74f10..6408254b67 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2166,24 +2166,54 @@ static void kvm_init_pmu_info_amd(struct kvm_cpuid2 *cpuid, X86CPU *cpu)
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
+    if (IS_AMD_CPU(env) || IS_HYGON_CPU(env)) {
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
+    if (g_str_equal(host_vendor, CPUID_VENDOR_AMD) ||
+        g_str_equal(host_vendor, CPUID_VENDOR_HYGON)) {
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
@@ -2211,10 +2241,15 @@ static void kvm_init_pmu_info(struct kvm_cpuid2 *cpuid, X86CPU *cpu)
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
 
@@ -4268,7 +4303,8 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
             kvm_msr_entry_add(cpu, MSR_KVM_POLL_CONTROL, env->poll_control_msr);
         }
 
-        if ((IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env)) && pmu_version > 0) {
+        if (x86_cpu_pmu_vendor(env) == X86_PMU_VENDOR_INTEL &&
+            pmu_version > 0) {
             if (pmu_version > 1) {
                 /* Stop the counter.  */
                 kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
@@ -4300,7 +4336,8 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
             }
         }
 
-        if (IS_AMD_CPU(env) && pmu_version > 0) {
+        if (x86_cpu_pmu_vendor(env) == X86_PMU_VENDOR_AMD &&
+            pmu_version > 0) {
             uint32_t sel_base = MSR_K7_EVNTSEL0;
             uint32_t ctr_base = MSR_K7_PERFCTR0;
             /*
@@ -4846,7 +4883,8 @@ static int kvm_get_msrs(X86CPU *cpu)
         kvm_msr_entry_add(cpu, MSR_KVM_POLL_CONTROL, 1);
     }
 
-    if ((IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env)) && pmu_version > 0) {
+    if (x86_cpu_pmu_vendor(env) == X86_PMU_VENDOR_INTEL &&
+        pmu_version > 0) {
         if (pmu_version > 1) {
             kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
             kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_CTRL, 0);
@@ -4862,7 +4900,8 @@ static int kvm_get_msrs(X86CPU *cpu)
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

