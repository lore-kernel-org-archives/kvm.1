Received: from out28-121.mail.aliyun.com (out28-121.mail.aliyun.com [115.124.28.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B773A7F46
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 08:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786350985; cv=none; b=sTIk7wDfJc9toyGFHVF07cl+cm9RjTuckCk36ccBbaVK3+GsYDU34sRFIXqXkYLMDx1FAGzIHFnzz9vzbxIm9s7AVmMerZ5+no2bThgG+Q3TGrel4LX57nZhhGomUa/BuKwc42MjIYkwhplKIOKPG0heaO9kiUeWdFOLB9fIJtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786350985; c=relaxed/simple;
	bh=qaE14Bvbj3rxGwPSpVMCpfY0GCSTBZJLhFSYXarVjpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cfCQIBbTshlrLVY78J9vrU4uBTneZu/fGv0OM1JJMXYSoJCk+SJkgfBuTyZdlry1Kgpb5nJpAGIpNXlAQdE8i2Drl3w+WLtg80gLaedtMy+vUL6cPRkCTKL0bpY6P3rqawnJUOUMoqu3t26KRx5/5ySXskONBZnQI3HRfTgtr/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07441887|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00345733-0.000296969-0.996246;FP=7196549941702542555|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033037026024;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.iiL7hL8_1786350660;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iiL7hL8_1786350660 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 10 Aug 2026 16:31:01 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Yanjing Zhou <zhouyanjing@hygon.cn>,
	Tina Zhang <zhang_wei@open-hieco.net>
Subject: [PATCH v2 3/9] target/i386: Hide ARCH_CAPABILITIES for Hygon
Date: Mon, 10 Aug 2026 16:29:50 +0800
Message-ID: <20260810082956.1768042-4-zhang_wei@open-hieco.net>
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

IA32_ARCH_CAPABILITIES is an Intel-defined MSR.  KVM can synthesize the
CPUID bit and read-only MSR for non-Intel guests, and QEMU already hides
that interface for AMD CPU models because Windows may not expect it on
AMD-compatible CPUs.

Hygon Dhyana uses the HygonGenuine vendor string, so it currently skips
that AMD filter.  If arch-capabilities=on is requested, QEMU can expose
CPUID.7.0.EDX[ARCH_CAPABILITIES] and the associated MSR feature word to
a Hygon guest.

That creates a vendor-inconsistent CPU ABI: the guest sees an
AMD-compatible vendor and cache/topology interface, but also sees an
Intel-specific architectural capabilities MSR.  Guests that choose CPU
mitigation or feature paths from the vendor can mis-handle that
combination; Windows is known to be sensitive to ARCH_CAPABILITIES on
AMD-compatible CPUs.

Apply the same ARCH_CAPABILITIES hiding rule to Hygon CPUs when the vendor
CPU ABI compat gate is enabled.  Keep arch_cap_always_on as the migration
escape hatch, and keep the old Hygon CPUID/MSR output for pc-11.0 and
older machine types via x-hygon-vendor-abi-fixes=false.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ad94fa755c..569ef785ca 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8209,6 +8209,8 @@ static uint8_t x86_cpu_get_host_avx10_version(void)
     return ebx & 0xff;
 }
 
+static bool x86_cpu_should_hide_arch_capabilities(const X86CPU *cpu);
+
 uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w)
 {
     FeatureWordInfo *wi = &feature_word_info[w];
@@ -8294,15 +8296,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w)
         break;
 
     case FEAT_7_0_EDX:
-        /*
-         * Windows does not like ARCH_CAPABILITIES on AMD machines at all.
-         * Do not show the fake ARCH_CAPABILITIES MSR that KVM sets up,
-         * except if needed for migration.
-         *
-         * When arch_cap_always_on is removed, this tweak can move to
-         * kvm_arch_get_supported_cpuid.
-         */
-        if (cpu && IS_AMD_CPU(&cpu->env) && !cpu->arch_cap_always_on) {
+        if (cpu && x86_cpu_should_hide_arch_capabilities(cpu)) {
             unavail = CPUID_7_0_EDX_ARCH_CAPABILITIES;
         }
         break;
@@ -8608,6 +8602,27 @@ uint32_t cpu_x86_virtual_addr_width(CPUX86State *env)
     }
 }
 
+/*
+ * Windows does not like ARCH_CAPABILITIES on AMD machines at all.
+ * Do not show the fake ARCH_CAPABILITIES MSR that KVM sets up,
+ * except if needed for migration.  Apply the same rule to Hygon CPUs when
+ * the corrected vendor CPU ABI is enabled.
+ *
+ * When arch_cap_always_on is removed, this tweak can move to
+ * kvm_arch_get_supported_cpuid.
+ */
+static bool x86_cpu_should_hide_arch_capabilities(const X86CPU *cpu)
+{
+    const CPUX86State *env = &cpu->env;
+
+    if (cpu->arch_cap_always_on) {
+        return false;
+    }
+
+    return IS_AMD_CPU(env) ||
+           (cpu->hygon_vendor_abi_fixes && IS_HYGON_CPU(env));
+}
+
 /*
  * CPUID leaves 2 and 4 describe Intel cache information.  AMD CPUs use
  * extended cache leaves instead, and Hygon Dhyana follows that AMD/Hygon
-- 
2.43.7

