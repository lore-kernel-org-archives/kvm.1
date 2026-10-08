Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0065D3438BC;
	Thu,  8 Oct 2026 00:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791418489; cv=none; b=CBI4gD9lcuukQfmgezga6uz2Myf9mBJw/cNSuMNSgckhc5d0N01Qfx0YpcFw3vEgs5b4gO7p4mrMIdZ694RBN7QXMRxR6ZcnTbDgTiMZuclX9LweMT4HffDMoVunlD+ssGiwNUvX3qfdL6UowVgUXIm37N5mH+I3BtUNjztJJd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791418489; c=relaxed/simple;
	bh=e8OgrkIo9QmW3YajjuEj9fwNVr+CH6JzNDwXzcQ50F8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cU3Fk96Qgr+zNutdwDOlcWNf09KC3gGrxiM4UBQO+/V7MOd8uHi3VN0HDLtyozFKTbP94HSj5a5bE51K0cQOTJff5Ui4K76B1Jigg7KCq3dOnoBASPHSdj5pgnQIFizGCFajp3EdQ89nYkmIW8p8s24tbkSljU2CKLhDNSQ1HMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EoTnzRfg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoTnzRfg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE311F000FF;
	Thu,  8 Oct 2026 00:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791418487;
	bh=FFbSC2FVHDfeplnvNDmNSJ/PfRV1cDEsLXGacstvhZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EoTnzRfgM3vCv7EO8XNHzHuttEdokinbIaz6oh3tKPvZIJmeWJWYbiryh7bN52ul0
	 nrZ+IakDeZ+X9TiRqFHHD2EEjRMXapciog1yasPlfWl77tIxyt3Jw+3X6QYZVIjX2y
	 rFN7tI2nam6lq7GckzLHsiVltm/DcuXRVwhvBILYo5TkU2OEdefxw7Qsaphm/6agzD
	 +xlEr/CVAYI75OMahWGCHkWOeFEApbcM+kTUGnfDAwwXOypTP8TFVe1UzO/M9e2exq
	 slgLNgOyRSS+Ce2jgOZr1eLc21IWuMAKpuApCCIJoTpntYE+inqaUUGtBZqqMp3Zcv
	 66v4UbJWizmgQ==
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
Subject: [PATCH v2 18/29] KVM: nSVM: Split nested_svm_transition_tlb_flush() into entry/exit fns
Date: Thu,  8 Oct 2026 00:14:14 +0000
Message-ID: <20261008001425.2458927-19-yosry@kernel.org>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
In-Reply-To: <20261008001425.2458927-1-yosry@kernel.org>
References: <20261008001425.2458927-1-yosry@kernel.org>
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
index 27f78228a42d5..efe7a39b53656 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -688,7 +688,7 @@ static void nested_save_pending_event_to_vmcb12(struct vcpu_svm *svm,
 	vmcb12->control.exit_int_info = exit_int_info;
 }
 
-static void nested_svm_transition_tlb_flush(struct kvm_vcpu *vcpu)
+static void nested_svm_entry_tlb_flush(struct kvm_vcpu *vcpu)
 {
 	/* Handle pending Hyper-V TLB flush requests */
 	kvm_hv_nested_transtion_tlb_flush(vcpu, npt_enabled);
@@ -708,6 +708,14 @@ static void nested_svm_transition_tlb_flush(struct kvm_vcpu *vcpu)
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
@@ -858,7 +866,7 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	struct vmcb *vmcb01 = svm->vmcb01.ptr;
 	struct kvm_vcpu *vcpu = &svm->vcpu;
 
-	nested_svm_transition_tlb_flush(vcpu);
+	nested_svm_entry_tlb_flush(vcpu);
 
 	/* Enter Guest-Mode */
 	enter_guest_mode(vcpu);
@@ -1434,7 +1442,7 @@ void nested_svm_vmexit(struct vcpu_svm *svm)
 	svm->vcpu.arch.dr7 = DR7_FIXED_1;
 	kvm_update_dr7(&svm->vcpu);
 
-	nested_svm_transition_tlb_flush(vcpu);
+	nested_svm_exit_tlb_flush(vcpu);
 
 	nested_svm_uninit_mmu_context(vcpu);
 
@@ -1553,7 +1561,7 @@ void svm_leave_nested(struct kvm_vcpu *vcpu)
 		 */
 		__svm_pmu_handle_nested_transition(svm, true);
 
-		nested_svm_transition_tlb_flush(vcpu);
+		nested_svm_exit_tlb_flush(vcpu);
 
 		nested_svm_uninit_mmu_context(vcpu);
 		vmcb_mark_all_dirty(svm->vmcb);
-- 
2.56.0.360.g66cac248cb-goog

