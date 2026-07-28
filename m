Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBFF2EA749;
	Tue, 28 Jul 2026 00:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198973; cv=none; b=ljtE6ucHRRZUWdGF7A0UfbtIaDDBgTcMk1aMvSA8V2NoAcKt7fX7OJje2fRZo9/92PVbEj6SA42RzEeMmFc2KyaV1B8o8MA5wJQT2o65I2UYY8syplqTAhGSvvf16g3kJWxnE6MVEpIuPEflSlQ0U0V8j8WPHIjfD8EFgb0DWK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198973; c=relaxed/simple;
	bh=ibrHXeai9I9lVCX4Xl/MW6BxZe57zzWy0XWndlfb6d4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BBzR9ayfdnRPyB9UQ3WYfQAHe6lvgn6phSokxm8zTTWY2XNVm1kBh/CEyearGxcpw6DCaAG2MUFT7GOeXZjFDlRBT/ZyWhbCKrmDIByw0P3l8OpUbNLZ2kC4Bbj8MOz1lEtfg9YxuMUFrg8Ay4/QbnCmXIoxVYVKc7VqZu8CtFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnWC5IPH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnWC5IPH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C1E1F00A3E;
	Tue, 28 Jul 2026 00:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785198971;
	bh=p4nmzw/GaRavMmyRAHGIyiFQ1L0scZTeFIeL02Mz4HY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HnWC5IPH6gFvQWIU8Qp2rREN+/cy+1b47ma3yNV8+SBsYqUErDb3qdQM9qttoyUJ0
	 U1WZ1D2kXAafwGRgkFLJqRMUq34aClA3+iQe6gHOLo+Rvlbz2qo5vDUBhf8gvZEM+u
	 lGAHkzyEJBAcnd1GYQzAmrWQp32IdoxDZG9quYRAJHbJhwT5VN9mSp5C5TSm8Ggjyy
	 xUME2E+yqyIEj7JnOXgUyBb7JbBIwfxbv5kPML8yox83/IlHHgyNERelVXwz8r8C0Z
	 s/H/NlSg9kX8blG+r68vIpNRaURBa3Qi7nergNVKbNNJZ4tZwaulM1Do8aUtUSWGuM
	 eX2osQd1R55kQ==
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
Subject: [PATCH v1 16/28] KVM: nSVM: Flush both L1 and L2 ASIDs on KVM_REQ_TLB_FLUSH
Date: Tue, 28 Jul 2026 00:35:45 +0000
Message-ID: <20260728003557.1136583-17-yosry@kernel.org>
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

Flush both L1 and L2 ASIDs in svm_flush_tlb_all() to appropriately
handle KVM_REQ_TLB_FLUSH by flushing all TLB entries in all contexts
(e.g. for kvm_flush_remote_tlbs()). Since both L1 and L2 currently share
an ASID, this is effectively a noop, but it won't be once L2 has a
separate ASID.

Purge all Hyper-V TLB FIFOs (for both L1 and L2), since both ASIDs are
flushed, and an ASID flush is a superset of Hyper-V's fine-grained
flushing (see comment in svm_flush_tlb_asid()).

Note that if one TLB flush FIFO is purged (e.g. as a result of
KVM_REQ_TLB_FLUSH_CURRENT), it will consume KVM_REQ_HV_TLB_FLUSH, and a
subsequent KVM_REQ_TLB_FLUSH will not flush the other FIFO. This is
alright as flushing both FIFOs is a (newly introduced) optimization
anyway. The other FIFO will be checked after a nested transition, as
KVM_REQ_HV_TLB_FLUSH is always set on nested transitions.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/hyperv.h     | 6 ++++++
 arch/x86/kvm/svm/nested.c | 1 -
 arch/x86/kvm/svm/svm.c    | 8 +++++++-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index a23ef05c1075c..b82f70e6fcea1 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -337,6 +337,11 @@ static inline void kvm_hv_purge_tlb_flush_fifo(struct kvm_vcpu *vcpu)
 		__kvm_hv_purge_tlb_flush_fifo(vcpu, fifo);
 }
 
+static inline void kvm_hv_purge_all_tlb_flush_fifos(struct kvm_vcpu *vcpu)
+{
+	__kvm_hv_purge_tlb_flush_fifo(vcpu, NULL);
+}
+
 static inline bool guest_hv_cpuid_has_l2_tlb_flush(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
@@ -408,6 +413,7 @@ static inline int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 	return HV_STATUS_ACCESS_DENIED;
 }
 static inline void kvm_hv_purge_tlb_flush_fifo(struct kvm_vcpu *vcpu) {}
+static inline void kvm_hv_purge_all_tlb_flush_fifos(struct kvm_vcpu *vcpu) {}
 static inline bool kvm_hv_synic_has_vector(struct kvm_vcpu *vcpu, int vector)
 {
 	return false;
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index a8bf847209618..a6a49a5e0d90a 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -694,7 +694,6 @@ static void nested_svm_transition_tlb_flush(struct kvm_vcpu *vcpu)
 	 * TODO: optimize unconditional TLB flush/MMU sync.  A partial list of
 	 * things to fix before this can be conditional:
 	 *
-	 *  - Flush TLBs for both L1 and L2 remote TLB flush
 	 *  - Honor L1's request to flush an ASID on nested VMRUN
 	 *  - Sync nested NPT MMU on VMRUN that flushes L2's ASID[*]
 	 *  - Don't crush a pending TLB flush in vmcb02 on nested VMRUN
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 991171df83486..1a8dae05f4ab5 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4225,6 +4225,8 @@ static void svm_flush_tlb_current(struct kvm_vcpu *vcpu)
 
 static void svm_flush_tlb_all(struct kvm_vcpu *vcpu)
 {
+	struct vcpu_svm *svm = to_svm(vcpu);
+
 	/*
 	 * When running on Hyper-V with EnlightenedNptTlb enabled, remote TLB
 	 * flushes should be routed to hv_flush_remote_tlbs() without requesting
@@ -4235,7 +4237,11 @@ static void svm_flush_tlb_all(struct kvm_vcpu *vcpu)
 	if (WARN_ON_ONCE(svm_hv_is_enlightened_tlb_enabled(vcpu)))
 		hv_flush_remote_tlbs(vcpu->kvm);
 
-	svm_flush_tlb_asid(vcpu);
+	kvm_hv_purge_all_tlb_flush_fifos(vcpu);
+
+	vmcb_set_flush_asid(svm->vmcb01.ptr);
+	if (svm->nested.vmcb02.ptr)
+		vmcb_set_flush_asid(svm->nested.vmcb02.ptr);
 }
 
 static void svm_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t gva)
-- 
2.55.0.229.g6434b31f56-goog

