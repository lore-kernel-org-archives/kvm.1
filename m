Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E050836B918;
	Thu,  8 Oct 2026 00:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791418491; cv=none; b=i98iHdgtklG1rgyrv00Q//xlNYxv5MhAFmqyLZLVl9GZo9bH+uvLmWvQERKTSZBLtjFO4abtIT2LUYhIg6a/6C3eAEDVq6hloPg4VbY+buBRf2aSXrxdCx/aU3YQIyh7enSEUlt3bjKRxeBWdEVpmM1Vtcl/q9tpYOFQ4bLmx8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791418491; c=relaxed/simple;
	bh=IFiVrJ+7+LNDx2ZVzZtKFoM6Ozqgo8PgOAs8ekqWQ5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XZ5QcQGFqqgCFN/mgzLeqOtjfcy5DS052QRngahfrmtGH7zogF50gvS0SneCwGsV25HFBBum/UvITM2uekVT6axeqn7BEWdLj3NdIYfzuUB6s6RPTZ9al8xavenn6fJQ0RUX8CSPEXjok3j4PuP3Z5Oe9BP9sBCUJUoVq9ZNz/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbu+riZk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbu+riZk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798AC1F0089A;
	Thu,  8 Oct 2026 00:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791418489;
	bh=ilF3Qk+AqtBMuX6eGiH1pyfgWIizSn3U58HsJctjhuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dbu+riZkSclZ+ADBMqBsqsh/Ns90n/TNmwE1HcE8uzeUstUPpQb4GfNZaOrgNndbm
	 WRt0MxGY1D07C9L1tPk1gXQ9n2Lst4lDhQMSi599Oi4SsQSsSsUKw1bMjh8qCf1AO7
	 dJuXbzAZ8e7mcBkn9UDRkGR7yDaZi6GFzgyZEGha226WcWn7Rbcb7T3zY4FiYn/umt
	 2eG4ijNBlI4NAyEjVivCQjjNJLRR6dZp9g4Hg4WwiTtAVy22DPICxlQ/PBK6rDRiaV
	 VVDeOSAZ6v6xtmmtmtfAtvsZeBBvIoqjvs5R6zBx0fpydE6uIiqzDJrfVpYbHTzewY
	 PrjhSvTjRQk8w==
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
Subject: [PATCH v2 22/29] KVM: nSVM: Flush the TLB if L1 changes L2's ASID in vmcb12
Date: Thu,  8 Oct 2026 00:14:18 +0000
Message-ID: <20261008001425.2458927-23-yosry@kernel.org>
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

KVM uses a single ASID for L2 guests per-vCPU. Hence, when L1 changes
L2's ASID in vmcb12 (e.g. due to switching to a different L2
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
VMX VPIDs, unlike SVM ASIDs, do not tag guest-physical translations
(i.e. nGPA to GPA translations).

Reset last_asid when nested VMRUN fails to force a flush and sync on the
next nested VMRUN. The TLB flush request survives the failure, but the
request to sync the nested NPT does not, as it ends up being serviced in
L1's MMU context after the synthesized VM-Exit.

Drop the commentary about vmcb12's ASID being copied around only for the
consistency checks, as they no longer apply, and opportunistically fix
whitespace alignment.

This is currently functionally a noop, as a full flush and sync is
triggered on every nested transition, but is a step toward eliminating
that.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 29 +++++++++++++++++++++++------
 arch/x86/kvm/svm/svm.h    |  2 ++
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index e04cc4f7669ea..8e4686b0d603a 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -556,10 +556,8 @@ void __nested_copy_vmcb_control_to_cache(struct kvm_vcpu *vcpu,
 	to->nested_cr3          = from->nested_cr3;
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
@@ -691,23 +689,35 @@ static void nested_save_pending_event_to_vmcb12(struct vcpu_svm *svm,
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
 	 * guest-physical mappings. Sync all roots, since the TLB flush is not
 	 * specific to the currently loaded nCR3.
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
 			kvm_make_request(KVM_REQ_MMU_SYNC_ALL_ROOTS, vcpu);
 		kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
@@ -1237,6 +1247,13 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 		svm->vmcb->control.exit_info_1  = 0;
 		svm->vmcb->control.exit_info_2  = 0;
 
+		/*
+		 * Force a flush+sync on the next nested VMRUN. Otherwise,
+		 * pending MMU syncs due to a changed ASID are lost, as
+		 * last_asid was already updated.
+		 */
+		svm->nested.last_asid = 0;
+
 		nested_svm_vmexit(svm);
 	}
 
@@ -1899,7 +1916,7 @@ void nested_svm_update_tsc_ratio_msr(struct kvm_vcpu *vcpu)
 	svm_write_tsc_multiplier(vcpu);
 }
 
-/* Inverse operation of nested_copy_vmcb_control_to_cache(). asid is copied too. */
+/* Inverse operation of nested_copy_vmcb_control_to_cache() */
 static void nested_copy_vmcb_cache_to_control(struct vmcb_control_area *dst,
 					      struct vmcb_ctrl_area_cached *from)
 {
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index ed67c18e2b900..15c4aa3b02c2d 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -244,6 +244,8 @@ struct svm_nested_state {
 	 * on its side.
 	 */
 	bool force_msr_bitmap_recalc;
+
+	u32 last_asid;
 };
 
 struct vcpu_sev_es_state {
-- 
2.56.0.360.g66cac248cb-goog

