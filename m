Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A2843CED6
	for <kvm@vger.kernel.org>; Fri,  6 Feb 2026 19:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770404970; cv=none; b=uwc1zueYU9MgjcIUHuVBKtzgdbFRCfYUOMExx+p+HG3U/zF8wpTOGyZrh+eSTpayvkKQvzAgkqvlMnV9pSyZ/L4b6H6odgfsD3zI1yl4v4YNzdEhuPSW26XtLsIiS149WRNCeyix8cuUPFqOWrafXlSX1ds9DkVuOI3XF4i63bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770404970; c=relaxed/simple;
	bh=LBmchytedw8fx4u5UhBQyRuvwF45htId9tkKO/LIPg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FHI75ctsPaV4kzpeFeqXknrYHGESMHptGO7ps2d8tMEypu1smRsHCxHPgdFoQXL+Ox5Qd8MENJBBzRHjFUbT4dXtTRuGrLLGM8LhGLZD4wlMQP+UV+zrwQ3D2zNG7s0WPHl48mJNhsSgsAHgkLwzdooItfzruimLHywbo3SfARk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YiXZ2o/w; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YiXZ2o/w"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770404968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bEnWTOPvdqvemtyagr/QRJYM/xqwakpjIKYmfE9kKs0=;
	b=YiXZ2o/wpRhck7FpoMwL1kCrsVQpm+X1iNFEEeDv3rmTTmQPjzSawY7rZRPd1WfC9hzmf4
	2O7y1yNy1FHe9N0he801jeALuF+X2vYWufyLXM4DwUtZOBhP4zBpKzrjJxpSvzb94TwkcL
	5k7G8Ro9DF0wiMS4CplUmgBwO05hfzE=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v5 12/26] KVM: nSVM: Call nested_svm_init_mmu_context() before switching to VMCB02
Date: Fri,  6 Feb 2026 19:08:37 +0000
Message-ID: <20260206190851.860662-13-yosry.ahmed@linux.dev>
In-Reply-To: <20260206190851.860662-1-yosry.ahmed@linux.dev>
References: <20260206190851.860662-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In preparation for moving more code that depends on
nested_svm_init_mmu_context() before switching to VMCB02, move the call
outside of nested_vmcb02_prepare_control() into callers, a bit earlier.
nested_svm_init_mmu_context() needs to be called after
enter_guest_mode(), but not after switching to VMCB02.

No functional change intended.

Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 arch/x86/kvm/svm/nested.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index c16b68a07369..77cb98e39fb3 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -803,10 +803,6 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
 	/* Also overwritten later if necessary.  */
 	vmcb02->control.tlb_ctl = TLB_CONTROL_DO_NOTHING;
 
-	/* nested_cr3.  */
-	if (nested_npt_enabled(svm))
-		nested_svm_init_mmu_context(vcpu);
-
 	vcpu->arch.tsc_offset = kvm_calc_nested_tsc_offset(
 			vcpu->arch.l1_tsc_offset,
 			svm->nested.ctl.tsc_offset,
@@ -945,6 +941,9 @@ int enter_svm_guest_mode(struct kvm_vcpu *vcpu, u64 vmcb12_gpa,
 
 	enter_guest_mode(vcpu);
 
+	if (nested_npt_enabled(svm))
+		nested_svm_init_mmu_context(vcpu);
+
 	nested_svm_copy_common_state(svm->vmcb01.ptr, svm->nested.vmcb02.ptr);
 
 	svm_switch_vmcb(svm, &svm->nested.vmcb02);
@@ -1893,6 +1892,10 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	nested_copy_vmcb_control_to_cache(svm, ctl);
 
 	enter_guest_mode(vcpu);
+
+	if (nested_npt_enabled(svm))
+		nested_svm_init_mmu_context(vcpu);
+
 	svm_switch_vmcb(svm, &svm->nested.vmcb02);
 	nested_vmcb02_prepare_control(svm, svm->vmcb->save.rip, svm->vmcb->save.cs.base);
 
-- 
2.53.0.rc2.204.g2597b5adb4-goog

