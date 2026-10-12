Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BAE42589C;
	Mon, 12 Oct 2026 23:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791848217; cv=none; b=Dbx1viw0hsapEHBT2jUXZ/MMs43Ydd/mUFor8uRBrB7ViQ2mfTUiwzl5w0oN1SCIUfci488fEZcLBYz1BDptUxxLtow/5OMtZDZuPHXCenp2iT7TqpPx+NK/ipm4iwdoNkuDzXD5/eATqVtbmDWkpRcPvi4q7HeYwahRVjZ47WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791848217; c=relaxed/simple;
	bh=/qyfy3zFQEh8L4DiHpaRYtNd6l5OdIBOzCqT2mCBrdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EV3fftAtrN20ZVQcKJHY1T7/imL7e2V3tvanpvl6IuZ2pFn5zs541ok/DyvErt2n+iFY7RMFMEibiqiW3E9CuZoXCzWPwYBUsl+MNsSg5wDrEisIfTfdtS+1hYF24oRr9/ydmfAL6Oy92EI1s4Mqiqk/cMOWCJDDTd/S8xTgqqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOt08CLY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOt08CLY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F521F008A5;
	Mon, 12 Oct 2026 23:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791848214;
	bh=sBeqwamb3znppYsqlHmKNR3KYMi1wVwXugLI2pJW/mE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aOt08CLYRpLOdqNbdce0mO743YZVXHj+WaKtpVMmcAPghV5RhbdFgPJy1odcLVqmt
	 Ja73JfesrZsnC496+hTSH1Wp3fSYL2K2BBB8FvIrnBmeGNbKK7IAPu5uTPMIK/Ofk8
	 gvpt+SPsk9H3CmTRl1s4tUp18L5WbRI0oJ4yYn3otpzJi9j+q1BUbc9JldzK8+jRXS
	 sK87tfKhfv8DUkMO2Gj2vUxHHSbNHolEVht2wygjlwP9rIr+qFeo0ixGplkHhmUHtq
	 We5GITuUzK6I4CjtR+fPPVyBH9dwAM/FQe+oJTSM1FhbD2p1sdNKIsgbI5eyxeCEh/
	 ffhFY1Gk/B5NQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v3 17/27] KVM: nSVM: Always switch VMCB before leaving guest mode
Date: Mon, 12 Oct 2026 23:36:28 +0000
Message-ID: <20261012233638.2546339-18-yosry@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261012233638.2546339-1-yosry@kernel.org>
References: <20261012233638.2546339-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move svm_switch_vmcb() calls ahead of leave_guest_mode(), as nothing
between the calls depends on svm->vmcb being set to vmcb01. This makes
the nested VM-Exit path consistent with the nested VM-Enter path, and
having the calls to svm_switch_vmcb() and leave_guest_mode() close makes
it easier to reason about incoming changes that depend on both VMCB and
guest_mode context.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 75ada771026b2..27f78228a42d5 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1329,7 +1329,7 @@ void nested_svm_vmexit(struct vcpu_svm *svm)
 	if (nested_svm_vmexit_update_vmcb12(vcpu))
 		kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
 
-	/* Exit Guest-Mode */
+	svm_switch_vmcb(svm, &svm->vmcb01);
 	leave_guest_mode(vcpu);
 	svm_pmu_handle_nested_transition(svm);
 
@@ -1356,8 +1356,6 @@ void nested_svm_vmexit(struct vcpu_svm *svm)
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_ERAPS))
 		vmcb01->control.erap_ctl |= ERAP_CONTROL_CLEAR_RAP;
 
-	svm_switch_vmcb(svm, &svm->vmcb01);
-
 	/*
 	 * Rules for synchronizing int_ctl bits from vmcb02 to vmcb01:
 	 *
@@ -1543,6 +1541,7 @@ void svm_leave_nested(struct kvm_vcpu *vcpu)
 		vcpu->arch.nested_run_pending = 0;
 		svm->nested.vmcb12_gpa = INVALID_GPA;
 
+		svm_switch_vmcb(svm, &svm->vmcb01);
 		leave_guest_mode(vcpu);
 
 		/*
@@ -1554,8 +1553,6 @@ void svm_leave_nested(struct kvm_vcpu *vcpu)
 		 */
 		__svm_pmu_handle_nested_transition(svm, true);
 
-		svm_switch_vmcb(svm, &svm->vmcb01);
-
 		nested_svm_transition_tlb_flush(vcpu);
 
 		nested_svm_uninit_mmu_context(vcpu);
-- 
2.56.0.385.gd3acb90ef8-goog

