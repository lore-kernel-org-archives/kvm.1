Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A709D448D16;
	Wed, 19 Aug 2026 09:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787133286; cv=none; b=Bi5jE4frgSWR4plxsCnMaWQc3PqDqBw/Fyh3HmDmsPAkGcAw/+qj5nyuW3E/xw/4EAR4qzOxMK+TywUSB0nA9tC5tf0T90vNPgkrHnf4bA1Pi0z7dIzgLOhV+DPu2MrwK15Oa7Mkj1AthDcukmkKXifvk+Odwdci9s7F9m1PvRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787133286; c=relaxed/simple;
	bh=RdHnZjcIYeuyO7xWSUVuxu6vGL/Os6voQfl/ZJFuThw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Li2d40R+wdCY9qNNZIJ5PY2S5CVBZa8FtPIIzF7jDxpODRol10iYxhPzurNMlG6TqO+KuvAtWfOOvB9+zW6W567PHcpLHx7D9wA1Oai6Gs4JzlAOs2eKSowMIYQOBDGFYn+0U+Ee06Hf6TxS61Fjkv5u54nZI2lZDkpGGaLe3v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UJRZKwy8; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UJRZKwy8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787133279; x=1818669279;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RdHnZjcIYeuyO7xWSUVuxu6vGL/Os6voQfl/ZJFuThw=;
  b=UJRZKwy8HI10/p/AcAvod8leufAS8wD9pcEha7fui0lExceHtzUp30bS
   HXSuL3WR/l1c5B6+MLtXE5N3iSlzVtHY4gi3VX2hdJhQz2JPCS9aHhdk0
   1kVZSsQOwyWDtQLQRV3AY8yYUooO4bRVuRSL+NQQI/OvmIRc/8IL9UoP6
   mNBFAm4OjtVCkJYiqlfE27u+hboevmSQNYHtwb2/N7ad81L86DKB+13pY
   5js9Nd7qMn1AtaW85Y5TY1G/nHgLCQEi/+f8GB96nG6CltOui7i+8S4+y
   M4GIRukz/TIUmNN44gtAe2WrykhPu3F6xHYF7RkFFu+8b9BbJO4na0pIK
   Q==;
X-CSE-ConnectionGUID: CqE47eb2STe0ZePviwKoNg==
X-CSE-MsgGUID: 8NLculOQSgG9ecUjex21ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87514972"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="87514972"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 02:54:30 -0700
X-CSE-ConnectionGUID: JMAk3LbRQf+dNkC9mIqgqg==
X-CSE-MsgGUID: MeS9+3tfRimZjzLajaonYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="303708886"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.33])
  by orviesa001.jf.intel.com with ESMTP; 19 Aug 2026 02:54:28 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	nik.borisov@suse.com
Subject: [PATCH v4 7/9] KVM: VMX: Make handle_bus_lock_vmexit() a shared helper
Date: Wed, 19 Aug 2026 17:49:01 +0800
Message-ID: <20260819094903.3060020-8-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819094903.3060020-1-xiaoyao.li@intel.com>
References: <20260819094903.3060020-1-xiaoyao.li@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move handle_bus_lock_vmexit() from vmx.c to main.c to make it a shared
helper so that TDX can use it for Bus Lock VM exit handling as well.
Rename it to add vt_ prefix to reflect that it is a helper for both VMX
and TDX.

Cc: stable@vger.kernel.org
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Changes in v4:
- split from next patch
---
 arch/x86/kvm/vmx/common.h |  1 +
 arch/x86/kvm/vmx/main.c   | 11 +++++++++++
 arch/x86/kvm/vmx/vmx.c    | 13 +------------
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/vmx/common.h b/arch/x86/kvm/vmx/common.h
index 7fce1bbabc78..bbeec197a507 100644
--- a/arch/x86/kvm/vmx/common.h
+++ b/arch/x86/kvm/vmx/common.h
@@ -203,5 +203,6 @@ static inline int __vt_handle_notify(struct kvm_vcpu *vcpu,
 }
 
 noinstr void vmx_handle_nmi(struct kvm_vcpu *vcpu);
+int vt_handle_bus_lock_vmexit(struct kvm_vcpu *vcpu);
 
 #endif /* __KVM_X86_VMX_COMMON_H */
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 0ff3230fd95e..6a813c49ca8a 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -876,6 +876,17 @@ static int vt_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn,
 #define vt_op_tdx_only(name) NULL
 #endif /* CONFIG_KVM_INTEL_TDX */
 
+int vt_handle_bus_lock_vmexit(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * Hardware may or may not set the BUS_LOCK_DETECTED flag on BUS_LOCK
+	 * VM-Exits. Unconditionally set the flag here and leave the handling
+	 * to .handle_exit() callback.
+	 */
+	to_vt(vcpu)->exit_reason.bus_lock_detected = true;
+	return 1;
+}
+
 #define VMX_REQUIRED_APICV_INHIBITS				\
 	(BIT(APICV_INHIBIT_REASON_DISABLED) |			\
 	 BIT(APICV_INHIBIT_REASON_ABSENT) |			\
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index d302d0ce47f1..58c001b6cbc5 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6265,17 +6265,6 @@ static int handle_encls(struct kvm_vcpu *vcpu)
 }
 #endif /* CONFIG_X86_SGX_KVM */
 
-static int handle_bus_lock_vmexit(struct kvm_vcpu *vcpu)
-{
-	/*
-	 * Hardware may or may not set the BUS_LOCK_DETECTED flag on BUS_LOCK
-	 * VM-Exits. Unconditionally set the flag here and leave the handling to
-	 * vmx_handle_exit().
-	 */
-	to_vt(vcpu)->exit_reason.bus_lock_detected = true;
-	return 1;
-}
-
 static int handle_notify(struct kvm_vcpu *vcpu)
 {
 	unsigned long exit_qual = vmx_get_exit_qual(vcpu);
@@ -6364,7 +6353,7 @@ static int (*kvm_vmx_exit_handlers[])(struct kvm_vcpu *vcpu) = {
 	[EXIT_REASON_VMFUNC]		      = handle_vmx_instruction,
 	[EXIT_REASON_PREEMPTION_TIMER]	      = handle_preemption_timer,
 	[EXIT_REASON_ENCLS]		      = handle_encls,
-	[EXIT_REASON_BUS_LOCK]                = handle_bus_lock_vmexit,
+	[EXIT_REASON_BUS_LOCK]                = vt_handle_bus_lock_vmexit,
 	[EXIT_REASON_NOTIFY]		      = handle_notify,
 	[EXIT_REASON_SEAMCALL]		      = handle_tdx_instruction,
 	[EXIT_REASON_TDCALL]		      = handle_tdx_instruction,
-- 
2.43.0

