Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F78283FDC;
	Tue, 16 Jun 2026 00:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570550; cv=none; b=lKXoyUQRF+WWY7UDrTjw2hGs+p3lKxsxL1ElyhvgRw8g3ZJVO6kRvyZb/R0vues/DMNlm0Bxy1BdznUuLPWfX1EEFY2XHJwtrVe6bMEnP4Ow5r/2JHdpjxPzrxQ3GldZM3IByHxe3F5PEHQnDi8DoeJqre03dAKxnzqdS9oCyq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570550; c=relaxed/simple;
	bh=cQD1uZ7fOr3LnlRnAGeB97QySsdquJXUrA49XpeV+aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QQlSd+aT4wu6b7WfY5W0cx8xrXnr020qvFSOJ6uC4ge8fPz3+eKNugS0mSIa9+8tm+sskPrNUxRf3i+tthI30GOMDyfmwlKMQq1FKA1QE7Rdfx94okOwSvLcLiXN+2vinalhy86/xK0/kSoEr/9/Xm02JxYpchSqH2hyJW1J9bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqiTazx0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqiTazx0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9501F000E9;
	Tue, 16 Jun 2026 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781570549;
	bh=qSpMlUjw3TTsnDCgvyiowASHlf8zT14neQS7XEHEw7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mqiTazx0eCg9KuT0rVkFWUximjU46jlOSQqDb8y/uSN+7B+p7SLykM+MLxtwnXjgZ
	 xt7kfe+9+rYvH67Q1/fjnghTuk1YtilU3khHvEWY8VXhegHRqk8HXOT5XRaujsKaHf
	 FFkCf4pgYppC+umsi08ZDQJ0KTLmcG6gJctiJKu9XgSTmcdT5KkvdSHtibsg7RiKQv
	 jIxx2CcWdAU9OETpSwwdZTOSIhHhR/8qG4wfNOrME7BbGahtTEUGl5woOzHAFrLfmS
	 G2+YcsI7t4z74H6RG0UYFseNJEnZMrIQ+Xyl1Z8szLP4fRXmvPOHNede1ax7LNe4m/
	 hz2kuyRBgC+bQ==
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
Subject: [RFC PATCH v2 15/25] KVM: nSVM: Call nested_svm_transition_tlb_flush() on every VMCB switch
Date: Tue, 16 Jun 2026 00:41:44 +0000
Message-ID: <20260616004155.1435766-16-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
In-Reply-To: <20260616004155.1435766-1-yosry@kernel.org>
References: <20260616004155.1435766-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the calls to nested_svm_transition_tlb_flush() in different
transition code paths to svm_switch_vmcb(). This ensures that TLB
flushes are not missed during switches, and makes it clearer that the
TLB flushes are directly related to the active VMCB.

The ordering currently doesn't matter, but as more TLB handling is added
for nested, requesting the TLB flushes *after* the VMCB switch will
become a requirement.

No functional change intended (for now).

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 24a52aefe94ee..9a917d057aa8e 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -707,8 +707,12 @@ static void nested_svm_transition_tlb_flush(struct kvm_vcpu *vcpu)
 
 static void svm_switch_vmcb(struct vcpu_svm *svm, struct kvm_vmcb_info *target_vmcb)
 {
+	struct kvm_vcpu *vcpu = &svm->vcpu;
+
 	svm->current_vmcb = target_vmcb;
 	svm->vmcb = target_vmcb->ptr;
+
+	nested_svm_transition_tlb_flush(vcpu);
 }
 
 /*
@@ -860,8 +864,6 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	struct vmcb *vmcb01 = svm->vmcb01.ptr;
 	struct kvm_vcpu *vcpu = &svm->vcpu;
 
-	nested_svm_transition_tlb_flush(vcpu);
-
 	/* Enter Guest-Mode */
 	enter_guest_mode(vcpu);
 	svm_pmu_handle_nested_transition(svm);
@@ -1435,8 +1437,6 @@ void nested_svm_vmexit(struct vcpu_svm *svm)
 	svm->vcpu.arch.dr7 = DR7_FIXED_1;
 	kvm_update_dr7(&svm->vcpu);
 
-	nested_svm_transition_tlb_flush(vcpu);
-
 	nested_svm_uninit_mmu_context(vcpu);
 
 	if (nested_svm_load_cr3(vcpu, vmcb01->save.cr3, false, true))
@@ -1556,8 +1556,6 @@ void svm_leave_nested(struct kvm_vcpu *vcpu)
 
 		svm_switch_vmcb(svm, &svm->vmcb01);
 
-		nested_svm_transition_tlb_flush(vcpu);
-
 		nested_svm_uninit_mmu_context(vcpu);
 		vmcb_mark_all_dirty(svm->vmcb);
 
-- 
2.54.0.1136.gdb2ca164c4-goog

