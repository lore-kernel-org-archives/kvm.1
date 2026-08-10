Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8EE3C1D76;
	Mon, 10 Aug 2026 11:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786361231; cv=none; b=T9btKk6a58KdWOBnMJVi8K3VJatrUHLTIVB3ZRCwYyj4WgErZXT7Kb3elbhpsXTATgp2hhL5knraAhcDG0zQz0xf2thcuMfq4+HKPqQJDLI7npnU1ALPwLNTrjCOaZm1gTaYm03Gwc6O2WrQfbGfJSTFY+O5w4CPnc2+KycB0D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786361231; c=relaxed/simple;
	bh=p6GKA/btOhRn8lRl2AfZpt4naMoFikAxSAGbYNvGGUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mkmifTFHYW9PtqZbuLzgW9P8PVWh7HIKp5yFy9IIWppzarvZJx8aNCpA1m2Q6CULJ69SCQYrMTvV7f9KvcCBHEX+IC3WXlctfL8kcg1cuXnhmMGI/MIDMpyUuLHE2L7SNXrsAKlXL1E3Ytd0+gRfl/0+LdaVQQ/8Haf+hoPMtAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GsAN0Ylf; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GsAN0Ylf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786361230; x=1817897230;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p6GKA/btOhRn8lRl2AfZpt4naMoFikAxSAGbYNvGGUM=;
  b=GsAN0YlfmfWZVq1ofa4R9ylFOmQjMy6tYB/Bv/WqfoLTSkKjfkplbLEq
   EshiInsLON522KIYCxp55mRZPDH7MyYJwIgyGLaFhR/uNrTXmG1tor+A+
   KfpsdxDrQdT4hsPojz0rMXfprFqk4Z5ENFacr73CqgbYEBiER4gxytdGJ
   J6MlCsgEP2vNEUt9xp07tOPJjWfcPtB6bio2MwIK08U5XLb8S3KgZX5F4
   cw2IlCIhE3ENkTYmK5o2of5iq7BOMXGt27nr+W5DPXV433rBuNcyrUHgw
   ZIDj5ze0mz0afact/eWc3bG+P+rNEzQygGQ2LxjyKkzbZ8gTYdQE493Pe
   w==;
X-CSE-ConnectionGUID: juE/MC5DRLqGP6td/71BDA==
X-CSE-MsgGUID: HkiGMPETQqqc6zS1xJ12pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="97221245"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="97221245"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 04:27:09 -0700
X-CSE-ConnectionGUID: M7+t/xeeT06uwTpyC1hnyg==
X-CSE-MsgGUID: qXp1sF9FRQ2dt6kbop4jRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="264999194"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.33])
  by fmviesa004.fm.intel.com with ESMTP; 10 Aug 2026 04:27:07 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
Subject: [PATCH v2 2/3] KVM: TDX: Fix the exit reason handling
Date: Mon, 10 Aug 2026 19:21:59 +0800
Message-ID: <20260810112200.2326727-3-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810112200.2326727-1-xiaoyao.li@intel.com>
References: <20260810112200.2326727-1-xiaoyao.li@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Get and check the exit reason from the low 16 bits of vp_enter_ret, and
store the synthesized/transformed exit reason in the "basic" field.

Some bits in the upper 16 bits in the exit reason have their own meanings
and they might be 1.  When handling the exit reason, only do handling on
the lower 16 bits and keep the upper 16 bits unchanged.  This change
also helps remove the additional check in tdx_failed_vmentry().

Note, due to the synthesized invalid exit reason, -1, is changed to
assigned to the "basic" field, adjust the checking in tdx_get_exit_info()
accordingly.

Fixes: 095b71a03f49 ("KVM: TDX: Add a place holder to handle TDX VM exit")
Fixes: c42856af8f70 ("KVM: TDX: Add a place holder for handler of TDX hypercalls (TDG.VP.VMCALL)")
Cc: stable@vger.kernel.org
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Changes in v2:
 - new patch
---
 arch/x86/kvm/vmx/tdx.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 7338ac0af693..a89885d550c9 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -921,10 +921,10 @@ static __always_inline u32 tdcall_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
 	return EXIT_REASON_TDCALL;
 }
 
-static __always_inline u32 tdx_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
+static __always_inline union vmx_exit_reason tdx_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_tdx *tdx = to_tdx(vcpu);
-	u32 exit_reason;
+	union vmx_exit_reason exit_reason;
 
 	switch (tdx->vp_enter_ret & TDX_SEAMCALL_STATUS_MASK) {
 	case TDX_SUCCESS:
@@ -934,23 +934,33 @@ static __always_inline u32 tdx_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
 	case TDX_NON_RECOVERABLE_TD_WRONG_APIC_MODE:
 		break;
 	default:
-		return -1u;
+		/*
+		 * Synthesize an invalid bogus Exit Reason, as the TDX-Module
+		 * never attempted to run the vCPU, i.e. the Exit Reason is
+		 * undefined, but this is NOT a failed VM-Enter.
+		 */
+		return (union vmx_exit_reason) {
+			.basic = -1,
+		};
 	}
 
-	exit_reason = tdx->vp_enter_ret;
+	exit_reason.full = (u32)tdx->vp_enter_ret;
 
-	switch (exit_reason) {
+	switch (exit_reason.basic) {
 	case EXIT_REASON_TDCALL:
 		if (tdvmcall_exit_type(vcpu))
-			return EXIT_REASON_VMCALL;
-
-		return tdcall_to_vmx_exit_reason(vcpu);
+			exit_reason.basic = EXIT_REASON_VMCALL;
+		else
+			exit_reason.basic = tdcall_to_vmx_exit_reason(vcpu);
+		break;
 	case EXIT_REASON_EPT_MISCONFIG:
 		/*
 		 * Defer KVM_BUG_ON() until tdx_handle_exit() because this is in
 		 * non-instrumentable code with interrupts disabled.
 		 */
-		return -1u;
+		return (union vmx_exit_reason) {
+			.basic = -1,
+		};
 	default:
 		break;
 	}
@@ -967,7 +977,7 @@ static noinstr void tdx_vcpu_enter_exit(struct kvm_vcpu *vcpu)
 
 	tdx->vp_enter_ret = tdh_vp_enter(&tdx->vp, &tdx->vp_enter_args);
 
-	vt->exit_reason.full = tdx_to_vmx_exit_reason(vcpu);
+	vt->exit_reason = tdx_to_vmx_exit_reason(vcpu);
 
 	vt->exit_qualification = tdx->vp_enter_args.rcx;
 	tdx->ext_exit_qualification = tdx->vp_enter_args.rdx;
@@ -981,8 +991,7 @@ static noinstr void tdx_vcpu_enter_exit(struct kvm_vcpu *vcpu)
 
 static bool tdx_failed_vmentry(struct kvm_vcpu *vcpu)
 {
-	return vmx_get_exit_reason(vcpu).failed_vmentry &&
-	       vmx_get_exit_reason(vcpu).full != -1u;
+	return vmx_get_exit_reason(vcpu).failed_vmentry;
 }
 
 static fastpath_t tdx_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
@@ -2144,7 +2153,7 @@ void tdx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
 	struct vcpu_tdx *tdx = to_tdx(vcpu);
 
 	*reason = tdx->vt.exit_reason.full;
-	if (*reason != -1u) {
+	if (tdx->vt.exit_reason.basic != -1) {
 		*info1 = vmx_get_exit_qual(vcpu);
 		*info2 = tdx->ext_exit_qualification;
 		*intr_info = vmx_get_intr_info(vcpu);
-- 
2.43.0

