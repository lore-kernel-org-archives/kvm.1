Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B63A31E83A;
	Tue, 16 Jun 2026 00:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570552; cv=none; b=SGtdEiKPvwsv0aFPcU0DoimmKCQFbTvEz8VOndw/2iVjFOnmG/5d6qZJEs527u+sHMYQjV3jOXUAViwuSEVmVeDb+SVN5gX1DhdLqiRRa7QuRJM8Mm882x4FohaESY/alArQTV/5RZ5WGfLxa+bGXVw9GT41tlR/cOJyut9U4+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570552; c=relaxed/simple;
	bh=Gpgess5SiarNvbgeT3JHru3TJB9aqnLMq2F936VQx/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fM2idNAgZM2LKESH0G574Ri02UKuLOCu+Fp2ivLUtgfdvxMrjfk3vSbHVKr5DdR6CKbY5uvFK1ZbulzsOG4ynzW6M6YCvQbbty/kKnxVfyHoiivJA4PBhAIBjw8kOnqm1AwntgR04VaBmVTPaLSVdQ83STIv3IwCg72rD+ZY4To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aiw4oEgY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aiw4oEgY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31FDA1F00A3A;
	Tue, 16 Jun 2026 00:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781570550;
	bh=rHxuiMN/Z/jNKW7GB30ro043lJGLWsN0b7/kbcdxjwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Aiw4oEgYfKONaSTXVxHSWizKb53GIFBULRqAsKHfQeRBjmVM9ugzI2++IuMrs8LKW
	 /XPjZulKg+K1i4AB7h5bxp4afMZdk/D1w+az33KPvUQGWXn8v4gnLRCvEU0ODnQUxA
	 SP5hevuT9nWGKzTgMa66H4nj18YR5b7zm3S1dsjvBpDLug3MRD2R9jlRlawx8bqIf1
	 LHTC/YY900gYM9ZRLuIDf20wE7sRbEbgaiTJA+XOcnJQEoYi3FC8B8Shc8x6YJLfSz
	 +RaJwWO02FDdkWsrXuLZ4Raf2eRlPOvUJyGUK9P+VnSjOe005dSiWaHHtTChiIIO1o
	 g+B7D8RvYP+vw==
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
Subject: [RFC PATCH v2 18/25] KVM: nSVM: Handle nested TLB flush requests through TLB_CONTROL
Date: Tue, 16 Jun 2026 00:41:47 +0000
Message-ID: <20260616004155.1435766-19-yosry@kernel.org>
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

Handle L1's requests to flush L2's TLB through the TLB_CONTROL field of
VMCB12.

On nested VM-Enter, flush L2's ASID if any flush is specified in
TLB_CONTROL. This handles TLB_CONTROL_FLUSH_ASID and
TLB_CONTROL_FLUSH_ASID_LOCAL equally for simplicity.

On nested VM-Exit, flush L1's own ASID if L1 requested a *full* TLB
flush (i.e. TLB_CONTROL_FLUSH_ALL_ASID).

Essentially, TLB_CONTROL_FLUSH_ASID[_LOCAL] cause a TLB flush on nested
VM-Enter only, while TLB_CONTROL_FLUSH_ALL_ASID causes a TLB flush on
both nested VM-Enter and nested VM-Exit.

Additionally, sync the nested NPTs on nested VM-Enter on an ASID flush,
as ASID flushes also invalidate guest-physical translations on SVM
(unlike VMX, which has separate VPID-based and EPT-based flushing).

All TLB_CONTROL values can be handled by KVM regardless of FLUSHBYASID
support on the underlying CPU, so keep advertising FLUSHBYASID to the
guest unconditionally.

Note, TLB_CONTROL_FLUSH_ALL_ASID is never propagated from the vmcb12 to
the vmcb02 (unless FLUSHBYASID is not available), as this gives the
guest the power to flush the entire physical TLB (including translations
for the host and other VMs).

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 30 +++++++++++++++++++++++++-----
 arch/x86/kvm/svm/svm.c    |  5 ++---
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 7b19191e0e43f..2c04b12121fb2 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -687,19 +687,33 @@ static void nested_save_pending_event_to_vmcb12(struct vcpu_svm *svm,
 
 static void nested_svm_entry_tlb_flush(struct kvm_vcpu *vcpu)
 {
+	struct vcpu_svm *svm = to_svm(vcpu);
+
 	/* Handle pending Hyper-V TLB flush requests */
 	kvm_hv_nested_transtion_tlb_flush(vcpu, npt_enabled);
 
+	/*
+	 * If L1 requested a TLB flush for L2, flush L2's TLB on nested entry
+	 * and sync the nested NPT MMU, as TLB_CONTROL also flushes NPT
+	 * guest-physical mappings.
+	 *
+	 * If L1 requested a full TLB flush for all ASIDs (including its own),
+	 * L1's own ASID is also flushed on nested VM-Exit, before running L1.
+	 *
+	 * TLB_CONTROL_FLUSH_ASID and TLB_CONTROL_FLUSH_ASID_LOCAL are handled
+	 * equally for simplicity.
+	 */
+	if (svm->nested.ctl.tlb_ctl != TLB_CONTROL_DO_NOTHING) {
+		if (nested_npt_enabled(svm))
+			kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
+		kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
+	}
+
 	/*
 	 * TODO: optimize unconditional TLB flush/MMU sync.  A partial list of
 	 * things to fix before this can be conditional:
 	 *
-	 *  - Honor L1's request to flush an ASID on nested VMRUN
-	 *  - Sync nested NPT MMU on VMRUN that flushes L2's ASID[*]
 	 *  - Don't crush a pending TLB flush in vmcb02 on nested VMRUN
-	 *
-	 * [*] Unlike nested EPT, SVM's ASID management can invalidate nested
-	 *     NPT guest-physical mappings on VMRUN.
 	 */
 	kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
 	kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
@@ -707,8 +721,14 @@ static void nested_svm_entry_tlb_flush(struct kvm_vcpu *vcpu)
 
 static void nested_svm_exit_tlb_flush(struct kvm_vcpu *vcpu)
 {
+	struct vcpu_svm *svm = to_svm(vcpu);
+
 	kvm_hv_nested_transtion_tlb_flush(vcpu, npt_enabled);
 
+	/* Flush L1's own ASID if it request a *full* TLB flush on VMRUN */
+	if (svm->nested.ctl.tlb_ctl == TLB_CONTROL_FLUSH_ALL_ASID)
+		kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
+
 	kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
 	kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
 }
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 14733ff8bcd19..87f82ae51e8b1 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5512,9 +5512,8 @@ static __init void svm_set_cpu_caps(void)
 		kvm_cpu_cap_set(X86_FEATURE_VMCBCLEAN);
 
 		/*
-		 * KVM currently flushes TLBs on *every* nested SVM transition,
-		 * and so for all intents and purposes KVM supports flushing by
-		 * ASID, i.e. KVM is guaranteed to honor every L1 ASID flush.
+		 * KVM handles all TLB_CONTROL values set by L1, even if the
+		 * underlying CPU does not.
 		 */
 		kvm_cpu_cap_set(X86_FEATURE_FLUSHBYASID);
 
-- 
2.54.0.1136.gdb2ca164c4-goog

