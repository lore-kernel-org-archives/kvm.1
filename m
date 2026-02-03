Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7028436923C
	for <kvm@vger.kernel.org>; Tue,  3 Feb 2026 18:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770142767; cv=none; b=VUGq7LN01GPshGFAZ81sohZYKJ/BM6I1Y1iQBPEJ0G7O11V6x/uIWrtV6U19wpqFhRK7R/oVVwV+162AdWr26zSDdTazG6tgC5d6O6kXS1ul1Oa2M6+FneM8LcxOnGC5pOWAcH4w8gzdjKyMYuTXv0C0M5te7MvUenY6ZSSBQ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770142767; c=relaxed/simple;
	bh=sVj4mpCE0QOp2zGt4i35GCFNwiVzV9EMvK7yxKqAX4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ka4rY9fXl45oTRpaz9odGiFwhMGUKoxz8DS60JpucjG1WK1PHwb7DSwfrDBrO2ObMb0xkA4iCA7poqCzR0eDyRhB1WcU7XkZ3xgjoGpFgNI3sbssz30pV+hkmWEmC96YMAdWMPrA4rbRSA+u4ISIXRb1m6CL/OFJXOJOxmMm/ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O8415/M3; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O8415/M3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770142767; x=1801678767;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sVj4mpCE0QOp2zGt4i35GCFNwiVzV9EMvK7yxKqAX4c=;
  b=O8415/M3ftzuVYbIhTAfwgjIDKjakkvr6m7UQXg2GR/y7pK/xgiUyUsx
   HjzeFbQJzRhpKL+82jyPKbTyjLU5NVKkzzmyAjwLvaqVJN31NNOZXK/p+
   xAt3K9M4C9nhdDvNzTOI65D3qsJel4MF/a6+z1InI30/fjRVkhZRQeu5E
   0ir5NLb1S4/ELZasCgaotZYQchOZKXXh37CtrCeHcYRj3mKo/1MwUFsru
   iotbK7LC8JwjPxN2zIAgzX38pnn6U6xaYg7SEBUeqiy47w9ND7yRaBSUq
   TTnj6lXWbTajDY7GWb6rw8yM345tr/SpH//U2GIBr/APn1IO825gDE8Pz
   A==;
X-CSE-ConnectionGUID: 3gvQFYXmTne/2Bra+/Awug==
X-CSE-MsgGUID: 6ji4ArUPScmlDI7l+KI63g==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="70523253"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="70523253"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 10:19:24 -0800
X-CSE-ConnectionGUID: u6gU2gasSvmPDf5TpNpDBw==
X-CSE-MsgGUID: O944K3p6Sla8RjqNB5DXqg==
X-ExtLoop1: 1
Received: from khuang2-desk.gar.corp.intel.com (HELO localhost) ([10.124.221.188])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 10:19:24 -0800
From: isaku.yamahata@intel.com
To: qemu-devel@nongnu.org
Cc: isaku.yamahata@intel.com,
	isaku.yamahata@gmail.com,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	kvm@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH 2/2] target/i386/kvm: Advertize tertiary procbased exec control to guest
Date: Tue,  3 Feb 2026 10:19:19 -0800
Message-ID: <bb006e42069cae656ec1e9260a7dd57205e3b6c0.1770116952.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <e41ffc4af96b8b4ee3a65f8da1f52dac7f3f4913.1770116952.git.isaku.yamahata@intel.com>
References: <e41ffc4af96b8b4ee3a65f8da1f52dac7f3f4913.1770116952.git.isaku.yamahata@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Isaku Yamahata <isaku.yamahata@intel.com>

When KVM supports tertiary processor based execution control, advertise
it to the guest.

Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 target/i386/kvm/kvm.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 0c940d4b640c..4f235c211ae8 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -162,6 +162,7 @@ static bool has_msr_core_capabs;
 static bool has_msr_vmx_vmfunc;
 static bool has_msr_ucode_rev;
 static bool has_msr_vmx_procbased_ctls2;
+static bool has_msr_vmx_procbased_ctls3;
 static bool has_msr_perf_capabs;
 static bool has_msr_pkrs;
 static bool has_msr_hwcr;
@@ -2639,6 +2640,9 @@ static int kvm_get_supported_msrs(KVMState *s)
             case MSR_IA32_VMX_PROCBASED_CTLS2:
                 has_msr_vmx_procbased_ctls2 = true;
                 break;
+            case MSR_IA32_VMX_PROCBASED_CTLS3:
+                has_msr_vmx_procbased_ctls3 = true;
+                break;
             case MSR_IA32_PKRS:
                 has_msr_pkrs = true;
                 break;
@@ -3839,6 +3843,13 @@ static void kvm_msr_entry_add_vmx(X86CPU *cpu, FeatureWordArray f)
     if (has_msr_vmx_vmfunc) {
         kvm_msr_entry_add(cpu, MSR_IA32_VMX_VMFUNC, f[FEAT_VMX_VMFUNC]);
     }
+    if (has_msr_vmx_procbased_ctls3 &&
+        /* >> 32 is for high bit. */
+        (f[FEAT_VMX_PROCBASED_CTLS] >> 32) &
+        VMX_CPU_BASED_ACTIVATE_TERTIARY_CONTROLS) {
+        kvm_msr_entry_add(cpu, MSR_IA32_VMX_PROCBASED_CTLS3,
+                          f[FEAT_VMX_TERTIARY_CTLS]);
+    }
 
     /*
      * Just to be safe, write these with constant values.  The CRn_FIXED1
@@ -3852,10 +3863,22 @@ static void kvm_msr_entry_add_vmx(X86CPU *cpu, FeatureWordArray f)
     if (f[FEAT_7_1_EAX] & CPUID_7_1_EAX_FRED) {
         /* FRED injected-event data (0x2052).  */
         kvm_msr_entry_add(cpu, MSR_IA32_VMX_VMCS_ENUM, 0x52);
+    } else if (f[FEAT_VMX_TERTIARY_CTLS] &
+               VMX_TERTIARY_EXEC_APIC_TIMER_VIRT) {
+        /*
+         * APIC timer virtualization:
+         * virtual timer vector (0xa), guest deadline (0x2830), and
+         * guest deadline shadow (0x204e).
+         */
+        kvm_msr_entry_add(cpu, MSR_IA32_VMX_VMCS_ENUM, 0x4e);
     } else if (f[FEAT_VMX_EXIT_CTLS] &
                VMX_VM_EXIT_ACTIVATE_SECONDARY_CONTROLS) {
         /* Secondary VM-exit controls (0x2044).  */
         kvm_msr_entry_add(cpu, MSR_IA32_VMX_VMCS_ENUM, 0x44);
+    } else if (f[FEAT_VMX_PROCBASED_CTLS] &
+               VMX_CPU_BASED_ACTIVATE_TERTIARY_CONTROLS) {
+        /* Tertiary procbased VM-execution controls (0x2034).  */
+        kvm_msr_entry_add(cpu, MSR_IA32_VMX_VMCS_ENUM, 0x34);
     } else if (f[FEAT_VMX_SECONDARY_CTLS] & VMX_SECONDARY_EXEC_TSC_SCALING) {
         /* TSC multiplier (0x2032).  */
         kvm_msr_entry_add(cpu, MSR_IA32_VMX_VMCS_ENUM, 0x32);
-- 
2.45.2

