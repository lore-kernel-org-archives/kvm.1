Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3A3359A68;
	Tue,  3 Mar 2026 00:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772498077; cv=none; b=tTPBT7HNzHbsLOt8R3syPmu5l0mR9SZ1fRbLKeSrbhCEOHhHA37pE/Bmr+iVKhX/a0AvmRDzItCIWEAZhvJF1Pdw5SLlJ9upFUDhXinTRcH06E+PJrrOHUUqMZYiGnCqGaJNNLez5veKhmPztSmsdblj4+gyYwLiX2voo9a9Ad0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772498077; c=relaxed/simple;
	bh=a3n687SEFo3mGCDwHQ3iI2OjGHE7+i7JTV7SzEfku0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H/Ofpuxm3oghQgamsMsvDOzFdAyNJSuGF2hthWChAcQ3F/zO8THNohgzKjAbUwOeyiN2XhnD+I5J3UgF7zKd9qS5MeH1/0+I2xLcBt7ZpYkuY7rVSgt4wij5k2qXed7ZEOw8mI+9Hn/wKxLuLkfIN0acnrgGKB1Y+tj1JZAqpdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F59rAZ17; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F59rAZ17"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F206C2BCB0;
	Tue,  3 Mar 2026 00:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772498076;
	bh=a3n687SEFo3mGCDwHQ3iI2OjGHE7+i7JTV7SzEfku0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F59rAZ17Q6OEH7RnuJro9aRtyucDsDD/JvLNkW8oeeayY4RJtmKqTLnprOXTHGOgZ
	 l8cJuba4821MRhxf59ePMRPuExtq71IWH/4/Q7fpIjoBaMqKcPf/ZD2+agpC/UI929
	 bHvQli9fHOnkyOPbOMxZQ7LeVJhuliV2Ri7RLNCQ46umL6wgz5VsLCYYqPeXmMhg3T
	 /lcRxjV6ZJZSGUSHxQvCr9Y9uq7HqkBmBxk1IhemQf6QMryBZjSnic77LitQGeWzcE
	 pCRozv4FkUuFXDvCioLCr+gWQvfbtsEamQCUbvNC1K7EFOgtj3nyqEip2ekMdJo+DL
	 X6ngoy8pNHVCg==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v7 13/26] KVM: nSVM: Drop nested_vmcb_check_{save/control}() wrappers
Date: Tue,  3 Mar 2026 00:34:07 +0000
Message-ID: <20260303003421.2185681-14-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260303003421.2185681-1-yosry@kernel.org>
References: <20260303003421.2185681-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The wrappers provide little value and make it harder to see what KVM is
checking in the normal flow. Drop them.

Opportunistically fixup comments referring to the functions, adding '()'
to make it clear it's a reference to a function.

No functional change intended.

Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 36 ++++++++++--------------------------
 1 file changed, 10 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index b66bd9bfce9d8..21e1a43c91879 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -339,8 +339,8 @@ static bool nested_svm_check_bitmap_pa(struct kvm_vcpu *vcpu, u64 pa, u32 size)
 	    kvm_vcpu_is_legal_gpa(vcpu, addr + size - 1);
 }
 
-static bool __nested_vmcb_check_controls(struct kvm_vcpu *vcpu,
-					 struct vmcb_ctrl_area_cached *control)
+static bool nested_vmcb_check_controls(struct kvm_vcpu *vcpu,
+				       struct vmcb_ctrl_area_cached *control)
 {
 	if (CC(!vmcb12_is_intercept(control, INTERCEPT_VMRUN)))
 		return false;
@@ -367,8 +367,8 @@ static bool __nested_vmcb_check_controls(struct kvm_vcpu *vcpu,
 }
 
 /* Common checks that apply to both L1 and L2 state.  */
-static bool __nested_vmcb_check_save(struct kvm_vcpu *vcpu,
-				     struct vmcb_save_area_cached *save)
+static bool nested_vmcb_check_save(struct kvm_vcpu *vcpu,
+				   struct vmcb_save_area_cached *save)
 {
 	if (CC(!(save->efer & EFER_SVME)))
 		return false;
@@ -402,22 +402,6 @@ static bool __nested_vmcb_check_save(struct kvm_vcpu *vcpu,
 	return true;
 }
 
-static bool nested_vmcb_check_save(struct kvm_vcpu *vcpu)
-{
-	struct vcpu_svm *svm = to_svm(vcpu);
-	struct vmcb_save_area_cached *save = &svm->nested.save;
-
-	return __nested_vmcb_check_save(vcpu, save);
-}
-
-static bool nested_vmcb_check_controls(struct kvm_vcpu *vcpu)
-{
-	struct vcpu_svm *svm = to_svm(vcpu);
-	struct vmcb_ctrl_area_cached *ctl = &svm->nested.ctl;
-
-	return __nested_vmcb_check_controls(vcpu, ctl);
-}
-
 /*
  * If a feature is not advertised to L1, clear the corresponding vmcb12
  * intercept.
@@ -469,7 +453,7 @@ void __nested_copy_vmcb_control_to_cache(struct kvm_vcpu *vcpu,
 	to->pause_filter_count  = from->pause_filter_count;
 	to->pause_filter_thresh = from->pause_filter_thresh;
 
-	/* Copy asid here because nested_vmcb_check_controls will check it.  */
+	/* Copy asid here because nested_vmcb_check_controls() will check it */
 	to->asid           = from->asid;
 	to->msrpm_base_pa &= ~0x0fffULL;
 	to->iopm_base_pa  &= ~0x0fffULL;
@@ -1031,8 +1015,8 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 	nested_copy_vmcb_control_to_cache(svm, &vmcb12->control);
 	nested_copy_vmcb_save_to_cache(svm, &vmcb12->save);
 
-	if (!nested_vmcb_check_save(vcpu) ||
-	    !nested_vmcb_check_controls(vcpu)) {
+	if (!nested_vmcb_check_save(vcpu, &svm->nested.save) ||
+	    !nested_vmcb_check_controls(vcpu, &svm->nested.ctl)) {
 		vmcb12->control.exit_code    = SVM_EXIT_ERR;
 		vmcb12->control.exit_info_1  = 0;
 		vmcb12->control.exit_info_2  = 0;
@@ -1878,12 +1862,12 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 
 	ret = -EINVAL;
 	__nested_copy_vmcb_control_to_cache(vcpu, &ctl_cached, ctl);
-	if (!__nested_vmcb_check_controls(vcpu, &ctl_cached))
+	if (!nested_vmcb_check_controls(vcpu, &ctl_cached))
 		goto out_free;
 
 	/*
 	 * Processor state contains L2 state.  Check that it is
-	 * valid for guest mode (see nested_vmcb_check_save).
+	 * valid for guest mode (see nested_vmcb_check_save()).
 	 */
 	cr0 = kvm_read_cr0(vcpu);
         if (((cr0 & X86_CR0_CD) == 0) && (cr0 & X86_CR0_NW))
@@ -1897,7 +1881,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	if (!(save->cr0 & X86_CR0_PG) ||
 	    !(save->cr0 & X86_CR0_PE) ||
 	    (save->rflags & X86_EFLAGS_VM) ||
-	    !__nested_vmcb_check_save(vcpu, &save_cached))
+	    !nested_vmcb_check_save(vcpu, &save_cached))
 		goto out_free;
 
 
-- 
2.53.0.473.g4a7958ca14-goog

