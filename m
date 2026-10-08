Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BD92236FA;
	Thu,  8 Oct 2026 00:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791418491; cv=none; b=V5rrrXw2cgzwFZgl9mq9ih8mfh4y4UqrZrmQsvVqGXb4CBTpFaJakgAPLsvKHuynJeWCjKDIuJXLFD0Sr8svFrOysWLhOEdd8CXKZ7Hj46uxJkpu3i2wybavdLOKTn/ZX647xGZBh8xam9EyxqeJMdKPI4bFip9X3KjToBAXNyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791418491; c=relaxed/simple;
	bh=PwYhY8OJNVo8saFTvkHFTwb6ZSpVdYNNHbvneOmp6no=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SSG3A2nwCE+H3AeULxWFJiA0v+SmsrQLrR42V5HtigYSdlQPPJgYqzPVLNAjkbSTxuxksDDXQwNeQwoqKPbqqy/ZZB88LplAQZKy8haoApPccULZSY9LOyIhnlOsYuV9pzEFlSxKkjTK36Jy3yrahRjlokqShizgnulrmzT9NdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFFrn8XW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFFrn8XW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041CA1F00899;
	Thu,  8 Oct 2026 00:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791418489;
	bh=yZ5H39ZyKWJSusITGWqCDnpu0ytnxezLX7vDAj9PNVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iFFrn8XW88RNXuZd99X0JYi9NZGyjIGoBspckIttXQ2pNakYei+z06QPvCvnbsvdF
	 rDFUov88zizT1ZcppPYxcq3RYBzcNn4HhbHBjSJwZcP40qOynESDi6Id7ida+pAW2M
	 9Gf293X+emI3zS/s55glXuykVNabMg1obeY9BguoeZPFUeaSjHrbvr3MWN2CFlME5E
	 p/AnNnoFj1IM9eMNgtaE5Dv3DcBL9q94VWmGR0j92uxuxArbhGMlsP2N+9h92kBjG6
	 uK5trrvfKJpN4JViQ6bMJxLRys7Gtc9M9NbrFRg+/ziLD7soC75c3rH6zbKiDu7F6u
	 +7RVmAvznmSpQ==
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
Subject: [PATCH v2 21/29] KVM: nSVM: Handle nested TLB flush requests through TLB_CONTROL
Date: Thu,  8 Oct 2026 00:14:17 +0000
Message-ID: <20261008001425.2458927-22-yosry@kernel.org>
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
(unlike VMX, which has separate VPID-based and EPT-based flushing). Sync
all roots, as shadow mappings are not tagged with an ASID, and there
could be translations belonging to the outgoing or flushed ASID in
previous roots.

All TLB_CONTROL values can be handled by KVM regardless of FLUSHBYASID
support on the underlying CPU, so keep advertising FLUSHBYASID to the
guest unconditionally.

Note, TLB_CONTROL_FLUSH_ALL_ASID is never propagated from the vmcb12 to
the vmcb02 (unless FLUSHBYASID is not available), as this gives the
guest the power to flush the entire physical TLB (including translations
for the host and other VMs).

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 31 ++++++++++++++++++++++++++-----
 arch/x86/kvm/svm/svm.c    |  5 ++---
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index e216818f68372..e04cc4f7669ea 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -690,19 +690,34 @@ static void nested_save_pending_event_to_vmcb12(struct vcpu_svm *svm,
 
 static void nested_svm_entry_tlb_flush(struct kvm_vcpu *vcpu)
 {
+	struct vcpu_svm *svm = to_svm(vcpu);
+
 	/* Handle pending Hyper-V TLB flush requests */
 	kvm_hv_nested_transtion_tlb_flush(vcpu, npt_enabled);
 
+	/*
+	 * If L1 requested a TLB flush for L2, flush L2's TLB on nested entry
+	 * and sync the nested NPT MMU, as TLB_CONTROL also flushes NPT
+	 * guest-physical mappings. Sync all roots, since the TLB flush is not
+	 * specific to the currently loaded nCR3.
+	 *
+	 * If L1 requested a full TLB flush for all ASIDs (including its own),
+	 * L1's own ASID is also flushed on nested VM-Exit, before running L1.
+	 *
+	 * TLB_CONTROL_FLUSH_ASID and TLB_CONTROL_FLUSH_ASID_LOCAL are handled
+	 * equally for simplicity.
+	 */
+	if (svm->nested.ctl.tlb_ctl != TLB_CONTROL_DO_NOTHING) {
+		if (nested_npt_enabled(svm))
+			kvm_make_request(KVM_REQ_MMU_SYNC_ALL_ROOTS, vcpu);
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
@@ -710,8 +725,14 @@ static void nested_svm_entry_tlb_flush(struct kvm_vcpu *vcpu)
 
 static void nested_svm_exit_tlb_flush(struct kvm_vcpu *vcpu)
 {
+	struct vcpu_svm *svm = to_svm(vcpu);
+
 	kvm_hv_nested_transtion_tlb_flush(vcpu, npt_enabled);
 
+	/* Flush L1's own ASID if it requested a *full* TLB flush on VMRUN */
+	if (svm->nested.ctl.tlb_ctl == TLB_CONTROL_FLUSH_ALL_ASID)
+		kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
+
 	kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
 	kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
 }
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index a6d14937e7777..f37cba4f34c2b 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5645,9 +5645,8 @@ static __init void svm_set_cpu_caps(void)
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
2.56.0.360.g66cac248cb-goog

