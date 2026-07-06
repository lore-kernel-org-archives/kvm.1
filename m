Received: from out28-3.mail.aliyun.com (out28-3.mail.aliyun.com [115.124.28.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2523B0AED
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 06:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783317694; cv=none; b=IQvhw/IbCw51oQegyj1KujNtT4c6xKGkHbPAGeLEespNoCXUgUSU3E3VLcNGcaEGvF3LSrCr+nOS4R4uV2evT08KDz3+PtyvtCXDLxZByEHzFUf+k44nktGgEa8kY4l4X1xqB1NMkzBMGbrEZkefHlOJiFAg+zh/lkBI0XmoyA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783317694; c=relaxed/simple;
	bh=TygZOO+VtCDv+hjq3MmIE+vJ3oErW5502VVwJiYWXaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j9CuJX8Tsw4gWAYwSqH02+f4/+WcsaMiZx+3p7uHeT1au1vSB+GFm50wF1HUpcZzh6dhIeyQAi8ekq4om+YvdEAOxPhuiCvQ9K1C6Du56EH2h+vwS7L6viThURI7Kg9FA9GjNxtRFfRbPh2d71HCWvWoOjhqhY/NHS4b3EP5gDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436261|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.228352-0.00012945-0.771519;FP=7097510869165867103|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033068005250;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.iEEStrb_1783317365;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iEEStrb_1783317365 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 06 Jul 2026 13:56:06 +0800
From: zhang_wei@open-hieco.net
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Tina Zhang <zhang_wei@open-hieco.net>
Subject: [PATCH v1 5/9] target/i386/kvm: Use AMD PMU MSR paths for Hygon
Date: Mon,  6 Jul 2026 13:55:26 +0800
Message-ID: <20260706055530.1752094-6-zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
References: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tina Zhang <zhang_wei@open-hieco.net>

On SVM, KVM uses the AMD PMU implementation and AMD PMU CPUID/MSR
layout.  Hygon guests that enable PMU and request AMD PMU CPUID
features such as perfctr-core need QEMU's KVM PMU setup and MSR state
paths to use that layout too.

The relevant QEMU KVM PMU paths are currently restricted to
AuthenticAMD guests: host/guest PMU compatibility checks, AMD PMU
information initialization, and AMD PMU MSR save/restore.  As a result,
a Hygon Dhyana guest can be rejected as unsupported because the guest
vendor is HygonGenuine rather than AuthenticAMD.  If the VM continues,
QEMU still skips AMD PMU setup and the AMD PMU MSR get/put paths.

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
 target/i386/kvm/kvm.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 8e2bfbbe1d..215e0c8f03 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2175,6 +2175,21 @@ static void kvm_init_pmu_info_amd(struct kvm_cpuid2 *cpuid, X86CPU *cpu)
     }
 }
 
+/*
+ * KVM exposes the AMD PMU CPUID/MSR layout for Hygon guests, so QEMU must
+ * use the AMD PMU setup and MSR state paths for Hygon too.
+ */
+static bool kvm_pmu_uses_amd_msrs(const CPUX86State *env)
+{
+    return IS_AMD_CPU(env) || IS_HYGON_CPU(env);
+}
+
+static bool host_cpu_uses_amd_pmu_msrs(const char *host_vendor)
+{
+    return g_str_equal(host_vendor, CPUID_VENDOR_AMD) ||
+           g_str_equal(host_vendor, CPUID_VENDOR_HYGON);
+}
+
 static bool is_host_compat_vendor(CPUX86State *env)
 {
     char host_vendor[CPUID_VENDOR_SZ + 1];
@@ -2191,8 +2206,8 @@ static bool is_host_compat_vendor(CPUX86State *env)
         return true;
     }
 
-    return g_str_equal(host_vendor, CPUID_VENDOR_AMD) &&
-           IS_AMD_CPU(env);
+    return host_cpu_uses_amd_pmu_msrs(host_vendor) &&
+           kvm_pmu_uses_amd_msrs(env);
 }
 
 static void kvm_init_pmu_info(struct kvm_cpuid2 *cpuid, X86CPU *cpu)
@@ -2222,7 +2237,7 @@ static void kvm_init_pmu_info(struct kvm_cpuid2 *cpuid, X86CPU *cpu)
 
     if (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env)) {
         kvm_init_pmu_info_intel(cpuid);
-    } else if (IS_AMD_CPU(env)) {
+    } else if (kvm_pmu_uses_amd_msrs(env)) {
         kvm_init_pmu_info_amd(cpuid, cpu);
     }
 }
@@ -4309,7 +4324,7 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
             }
         }
 
-        if (IS_AMD_CPU(env) && pmu_version > 0) {
+        if (kvm_pmu_uses_amd_msrs(env) && pmu_version > 0) {
             uint32_t sel_base = MSR_K7_EVNTSEL0;
             uint32_t ctr_base = MSR_K7_PERFCTR0;
             /*
@@ -4871,7 +4886,7 @@ static int kvm_get_msrs(X86CPU *cpu)
         }
     }
 
-    if (IS_AMD_CPU(env) && pmu_version > 0) {
+    if (kvm_pmu_uses_amd_msrs(env) && pmu_version > 0) {
         uint32_t sel_base = MSR_K7_EVNTSEL0;
         uint32_t ctr_base = MSR_K7_PERFCTR0;
         /*
-- 
2.43.7

