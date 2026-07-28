Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B64E36B93B;
	Tue, 28 Jul 2026 00:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198975; cv=none; b=OWx4Kd2AUgLy+mxLFffoZgnIu9zQiCW0CWziPqKd8zoYTD3n2bCGQ7M4ICo7zomOTJmaVONN+V3Nv1SQTijNp9krcxMXkSBZn7KP38Tu/NqBQVjRTOfqc3SDKi4MjJPkbAqIcQHFmOyeWCtcTUH8lUR2beB2t3KvQqyj/y0fCcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198975; c=relaxed/simple;
	bh=9FnGG3Ax2sEQLj87MPx0U5fVQFpih92PH5ihG9mmX5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Omw0GP42lnGXEUOdmCJtG12+tjEYa2EpMsYKuhv+gxM/rM0MM5H4BSXLE1bRX2E1zj+W7Y61OpeYWmNaGZ4MEsVhaOmQ/C0URzRb7HQaOsG98Sqr7xVddnIuBMUXv+IbxCLno/W/H8mfkJwmUKPnsleV1dVCPHhAF7+Q1APxo2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTRPPhbr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTRPPhbr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36351F00AC4;
	Tue, 28 Jul 2026 00:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785198974;
	bh=Igmw5MnVXhI+Yteop7AuLRpCW4NWrAYFM6XSOgHPARg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BTRPPhbru2YOLCuF+ECWjbfNim6zFD1ogKZxma6R43+CrFXhrsMEef7w1UOSyR4Ha
	 MyGdbmZgK1RhneFcxDIV/kb5RaLoZ+p7LuTNtU4MekrnznMXNmPblP8T3WwIXoTsqa
	 PphKkCJvrFNXLfJE39WPekaGzbhXv4h95B3xKlvhR2AWcZMnhZo8t02VB+QmBkEKtx
	 zdtlzOLlU/1LR4MFaTruxdEKg87R0SG9yiy929+zvnaYRDgbLkd3UR8/zDaUYb8j8q
	 zlOtVlrl0hwbUKqWNfRemMUTBz7LKl3ZuBC5kTQ1y660xBSzIYD8jQ+Trb6KwjOD/Q
	 wmApFlnyamFsA==
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
Subject: [PATCH v1 21/28] KVM: nSVM: Flush the TLB if L1 changes L2's ASID in vmcb12
Date: Tue, 28 Jul 2026 00:35:50 +0000
Message-ID: <20260728003557.1136583-22-yosry@kernel.org>
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

KVM uses a single ASID for L2 guests per-vCPU. Hence, when L1 changes
L2's ASID in vmcb12 (e.g. due to switching a different L2
vCPU or simply to avoid flushing an existing ASID), KVM needs to flush
the L2 ASID to correctly emulate different ASIDs as different TLB
domains.

Additionally, the nested NPT needs to be resync'd, as the MMU context
is not tagged by ASID, and KVM cannot reuse nested NPT entries across
different L2 ASIDs.

Essentially, L1 switching L2's ASID is treated exactly the same as L1
flushing L2's ASID, which is consistent with the APM:

  Software may effectively flush the guest's TLB entries by allocating a
  new ASID for the guest and not reusing the old ASID until the entire
  TLB has been flushed at least once.

This is similar to nVMX's handling of last_vpid, except that when L1
changes VPID12, KVM does *not* need to resync the nested EPT, because
VMX VPIDs , unlike SVM ASIDs, do not tag guest-physical translations
(i.e. nGPA to GPA translations).

Drop the commentary about vmcb12's ASID being copied around only for the
consistency checks, as they no longer apply, and opportunistically fix
whitespace alignment.

This is currently functionally a noop, as a full flush and sync is
triggered on every nested transition, but is a step toward eliminating
that.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 22 ++++++++++++++++------
 arch/x86/kvm/svm/svm.h    |  2 ++
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 073368ddd207a..f50e21fd363fc 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -553,10 +553,8 @@ void __nested_copy_vmcb_control_to_cache(struct kvm_vcpu *vcpu,
 	to->misc_ctl2		= from->misc_ctl2;
 	to->pause_filter_count  = from->pause_filter_count;
 	to->pause_filter_thresh = from->pause_filter_thresh;
-
-	/* Copy asid here because nested_vmcb_check_controls() will check it */
-	to->asid           = from->asid;
-	to->clean = from->clean;
+	to->asid		= from->asid;
+	to->clean		= from->clean;
 
 #ifdef CONFIG_KVM_HYPERV
 	/* Hyper-V extensions (Enlightened VMCB) */
@@ -688,22 +686,34 @@ static void nested_save_pending_event_to_vmcb12(struct vcpu_svm *svm,
 static void nested_svm_entry_tlb_flush(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
+	bool new_asid = false;
 
 	/* Handle pending Hyper-V TLB flush requests */
 	kvm_hv_nested_transtion_tlb_flush(vcpu, npt_enabled);
 
+	if (svm->nested.ctl.asid != svm->nested.last_asid) {
+		svm->nested.last_asid = svm->nested.ctl.asid;
+		new_asid = true;
+	}
+
 	/*
 	 * If L1 requested a TLB flush for L2, flush L2's TLB on nested entry
 	 * and sync the nested NPT MMU, as TLB_CONTROL also flushes NPT
 	 * guest-physical mappings.
 	 *
+	 * Handle L1 changing L2's ASID12 similarly, as KVM only uses one ASID
+	 * for L2 in hardware (per vCPU), so it must start fresh when L1 changes
+	 * ASID12 to emulate different ASIDs correctly.  Additionally, the MMU
+	 * context is not tagged by the ASID, so the shadow NPTs cannot be
+	 * reused across different L2 ASIDs.
+	 *
 	 * If L1 requested a full TLB flush for all ASIDs (including its own),
 	 * L1's own ASID is also flushed on nested VM-Exit, before running L1.
 	 *
 	 * TLB_CONTROL_FLUSH_ASID and TLB_CONTROL_FLUSH_ASID_LOCAL are handled
 	 * equally for simplicity.
 	 */
-	if (svm->nested.ctl.tlb_ctl != TLB_CONTROL_DO_NOTHING) {
+	if (new_asid || (svm->nested.ctl.tlb_ctl != TLB_CONTROL_DO_NOTHING)) {
 		if (nested_npt_enabled(svm))
 			kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
 		kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
@@ -1885,7 +1895,7 @@ void nested_svm_update_tsc_ratio_msr(struct kvm_vcpu *vcpu)
 	svm_write_tsc_multiplier(vcpu);
 }
 
-/* Inverse operation of nested_copy_vmcb_control_to_cache(). asid is copied too. */
+/* Inverse operation of nested_copy_vmcb_control_to_cache() */
 static void nested_copy_vmcb_cache_to_control(struct vmcb_control_area *dst,
 					      struct vmcb_ctrl_area_cached *from)
 {
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 2e0c9c469ec63..80a6b08fc4003 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -242,6 +242,8 @@ struct svm_nested_state {
 	 * on its side.
 	 */
 	bool force_msr_bitmap_recalc;
+
+	u32 last_asid;
 };
 
 struct vcpu_sev_es_state {
-- 
2.55.0.229.g6434b31f56-goog

