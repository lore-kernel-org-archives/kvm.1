Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988C61FCFFC;
	Tue, 28 Jul 2026 00:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198974; cv=none; b=Hw6k4CYKUPNb8Rc+FxPYbCPOIdW9t5/UrvZO6oNYOz/y+NB6ayQl3zjcKpVDhJe1TBiqYNTj0jdk0IpODT3RWa6Lf5XCUb3P36qpIwXlW87+Jmzg0JxYvSrXF61dWwi3AXd4GF2TMjjECC4yasQdmpBZaeczcWdG+SArBmgTmSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198974; c=relaxed/simple;
	bh=Yem9mNep1ID/HLCpW/phEPmBcfywjYQaR6P8BJLPcVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQqClvoQtXL1LRhu8b1PE+UJbY9Oys5uYW1Xje3erIPzYMLNoVz8+phnhsLn1rqu4+duc+Vl+PKU6paz54ZItKUYzd3X9TRjAbLpJEih2LddqSTJ8eygOGKym9iZRo3zqc+MLRiURhLx5w2bVYHyxOFEHPwrOy7iRSqPMMs5OB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoLj4QyI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoLj4QyI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3069E1F00A3F;
	Tue, 28 Jul 2026 00:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785198972;
	bh=Ksb7bLNXD1/IlKRAwcEui4ZS3r8TY9kryDj9mCnBQf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VoLj4QyIPQbXA2r+sS8NTKgvewFjPw4BWHpZZQ2wGo/09cGCLcBOH9E70/gWbYcm9
	 eAXxZAjles9bj91ZaQIu0tsipZKl85RoJzc6iJRgSRg2ltO5nJcWMKnedtzApST0Kc
	 1j+plWghBWmoK68f19+1VWZZMVjg0StbIFzRy1jntrDcIoePgCVrCstIC01jpmObpo
	 nPW6KjGxfsWOqxGaE5zesHs5verQZt2tB5a9J2rl3PAHbrkw0t+UbkSAXeuQTdzT+K
	 LQsoIy9Tudj9GDjWSMaqihjYqicu1qMey5z8pxy8bWZ//vWe03ARf5oBPITiXna0VY
	 91QxEtMXVuYgQ==
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
Subject: [PATCH v1 18/28] KVM: nSVM: Split nested_svm_transition_tlb_flush() into entry/exit fns
Date: Tue, 28 Jul 2026 00:35:47 +0000
Message-ID: <20260728003557.1136583-19-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260728003557.1136583-1-yosry@kernel.org>
References: <20260728003557.1136583-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The handling for the entry and exit TLB flushes will diverge
significantly in the following changes. Instead of adding an 'is_vmenter'
argument like nested_vmx_transition_tlb_flush(), just split the function
into two variants for 'entry' and 'exit'.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 410d0f1aaa63c..57752ad37c2a2 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -685,7 +685,7 @@ static void nested_save_pending_event_to_vmcb12(struct vcpu_svm *svm,
 	vmcb12->control.exit_int_info = exit_int_info;
 }
 
-static void nested_svm_transition_tlb_flush(struct kvm_vcpu *vcpu)
+static void nested_svm_entry_tlb_flush(struct kvm_vcpu *vcpu)
 {
 	/* Handle pending Hyper-V TLB flush requests */
 	kvm_hv_nested_transtion_tlb_flush(vcpu, npt_enabled);
@@ -705,6 +705,14 @@ static void nested_svm_transition_tlb_flush(struct kvm_vcpu *vcpu)
 	kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
 }
 
+static void nested_svm_exit_tlb_flush(struct kvm_vcpu *vcpu)
+{
+	kvm_hv_nested_transtion_tlb_flush(vcpu, npt_enabled);
+
+	kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
+	kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
+}
+
 /*
  * Load guest's/host's cr3 on nested vmentry or vmexit. @nested_npt is true
  * if we are emulating VM-Entry into a guest with NPT enabled.
@@ -857,7 +865,7 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	struct vmcb *vmcb01 = svm->vmcb01.ptr;
 	struct kvm_vcpu *vcpu = &svm->vcpu;
 
-	nested_svm_transition_tlb_flush(vcpu);
+	nested_svm_entry_tlb_flush(vcpu);
 
 	/* Enter Guest-Mode */
 	enter_guest_mode(vcpu);
@@ -1430,7 +1438,7 @@ void nested_svm_vmexit(struct vcpu_svm *svm)
 	svm->vcpu.arch.dr7 = DR7_FIXED_1;
 	kvm_update_dr7(&svm->vcpu);
 
-	nested_svm_transition_tlb_flush(vcpu);
+	nested_svm_exit_tlb_flush(vcpu);
 
 	nested_svm_uninit_mmu_context(vcpu);
 
@@ -1547,7 +1555,7 @@ void svm_leave_nested(struct kvm_vcpu *vcpu)
 		 */
 		__svm_pmu_handle_nested_transition(svm, true);
 
-		nested_svm_transition_tlb_flush(vcpu);
+		nested_svm_exit_tlb_flush(vcpu);
 
 		nested_svm_uninit_mmu_context(vcpu);
 		vmcb_mark_all_dirty(svm->vmcb);
-- 
2.55.0.229.g6434b31f56-goog

