Received: from out198-30.us.a.mail.aliyun.com (out198-30.us.a.mail.aliyun.com [47.90.198.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D993BE646
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 05:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783317383; cv=none; b=XMpl5BtsMPpI9bbhw4qiw8/D7RWkj4wggoWQLpEcptCPgecUKeP01LHlbYikBnSKi+8Xq21suzWSiE2n/QLOlL9XInN0778PxXV8BixlQX/+NhJ9RtaGsY6TM8H5k2EBYuE19iBiiUiBuxBczPUrAk9YcqLmN3CH/0jjFmhLlvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783317383; c=relaxed/simple;
	bh=DQK3lmeJNtAEIRACtCFMHwYRzZea2Pa8Rfp4fGvQg1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p8C0B4qcYbyfDz1+4T93GWT88hHM83+NTawUdKX9bf8JyN0sKfRynttg7dr5MgFtGtyX44v9i7JAuTShKDzayZtseI/cTKUQZxSBDCgprE+nsjIJ6+1lSSsY22zvNKLQB474Dh525L4b9hnDdoMj4pxhTOro+ULQXrEirTc6b6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=47.90.198.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07468145|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.253112-0.000743695-0.746145;FP=7196585128222115019|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037021130;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.iEEStq6_1783317364;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iEEStq6_1783317364 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 06 Jul 2026 13:56:05 +0800
From: zhang_wei@open-hieco.net
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Tina Zhang <zhang_wei@open-hieco.net>
Subject: [PATCH v1 3/9] target/i386: Hide ARCH_CAPABILITIES for Hygon
Date: Mon,  6 Jul 2026 13:55:24 +0800
Message-ID: <20260706055530.1752094-4-zhang_wei@open-hieco.net>
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

Apply the same ARCH_CAPABILITIES hiding rule to Hygon CPUs when Hygon
vendor ABI fixes are enabled.  Keep arch_cap_always_on as the migration
escape hatch, and keep the old Hygon CPUID/MSR output for pc-11.0 and
older machine types via x-hygon-vendor-abi-fixes=false.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 target/i386/cpu.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f0cad38c94..47f48f4a96 100644
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
+ * Hygon vendor ABI fixes are enabled.
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
  * AMD CPUs define CPUID[0x80000001].EDX aliases for selected CPUID[1].EDX
  * feature bits.  Hygon Dhyana follows the same extended feature alias rules.
-- 
2.43.7

