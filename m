Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3506F415B7E;
	Mon, 12 Oct 2026 23:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791848215; cv=none; b=NPiVdKFJ+x8Z4QmIlh62fsK19DuVYCCFX+Te5mh2MQR9qJC0ooJwffvlsVAc5JGNSQX3+CFcZ31XYsxsU6y5oJZxkFvu+b+pb2SFPsm/R6NmauMVtJC1fb/6yLF9ZvQTJD2gDFvNg2Rrx6cCR7aBSgBQKyTYafHFm7Be0FhS9UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791848215; c=relaxed/simple;
	bh=5EzStoQRUNYctvKeZY56wS3Abj7zthB6BMMrk6Ao1mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WjvR+wM0WllGPtyWgPO0hnrbwuUbD4Ya1vSBbug1nsbR8gQTJdhl8lEvhordarYW0kNTO9f1k9rN+RSuPQm0aePtbtpqEetlhmQtYVyJmJRgbqkZsTne9QJ0X4noSKw7NrUJAEqI/TeEmGKzcN4FpokiLeQP++phGfs9SledBWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyXZbk0R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyXZbk0R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEAB41F0089B;
	Mon, 12 Oct 2026 23:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791848214;
	bh=FE5QgPVyOfu+/frGQUFtcs7Wi6oCJYO/2Ouifv1gsYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TyXZbk0RP00lm65+fFeqkfkMZgPlCtTm8PwJKn7NEB/dBs0hUwD5U4odKaJIrCbDR
	 csGDfT1eOp9v5TeUCJrd9W8lXR85aIoywkxnnzsRFX1/A38v3SKK6dUW1oHosYK30S
	 Ir/0/imxkg2qKb5H0BCFpNCpUj/oT2sBRTCHHqnuf359Uqnw68RSysQqYrk7PlCenr
	 DgbMKuilPBQIp2LbvKz3UEM2XXNcWz3g6GfvgpoVp25wav88+gMwJHsIpGxNx/m12n
	 LVVJ+Sq9Ad3yoz7jrntWqxa+uJPohDu4OBwaXncqhL9PnkqIRYMkxnwYmnZoQ63Yjk
	 dMWFvft9jFLAA==
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
Subject: [PATCH v3 16/27] KVM: nSVM: Flush both L1 and L2 ASIDs on KVM_REQ_TLB_FLUSH
Date: Mon, 12 Oct 2026 23:36:27 +0000
Message-ID: <20261012233638.2546339-17-yosry@kernel.org>
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
index 780132725bb79..75ada771026b2 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -697,7 +697,6 @@ static void nested_svm_transition_tlb_flush(struct kvm_vcpu *vcpu)
 	 * TODO: optimize unconditional TLB flush/MMU sync.  A partial list of
 	 * things to fix before this can be conditional:
 	 *
-	 *  - Flush TLBs for both L1 and L2 remote TLB flush
 	 *  - Honor L1's request to flush an ASID on nested VMRUN
 	 *  - Sync nested NPT MMU on VMRUN that flushes L2's ASID[*]
 	 *  - Don't crush a pending TLB flush in vmcb02 on nested VMRUN
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 851db95dc3f95..97a5577a25d9f 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4338,6 +4338,8 @@ static void svm_flush_tlb_current(struct kvm_vcpu *vcpu)
 
 static void svm_flush_tlb_all(struct kvm_vcpu *vcpu)
 {
+	struct vcpu_svm *svm = to_svm(vcpu);
+
 	/*
 	 * When running on Hyper-V with EnlightenedNptTlb enabled, remote TLB
 	 * flushes should be routed to hv_flush_remote_tlbs() without requesting
@@ -4348,7 +4350,11 @@ static void svm_flush_tlb_all(struct kvm_vcpu *vcpu)
 	if (WARN_ON_ONCE(svm_hv_is_enlightened_tlb_enabled(vcpu)))
 		hv_flush_remote_tlbs(vcpu->kvm);
 
-	svm_flush_tlb_asid(vcpu);
+	kvm_hv_purge_all_tlb_flush_fifos(vcpu);
+
+	vmcb_set_flush_asid(svm->vmcb01.ptr);
+	if (svm->nested.vmcb02.ptr)
+		vmcb_set_flush_asid(svm->nested.vmcb02.ptr);
 }
 
 static void svm_flush_tlb_guest(struct kvm_vcpu *vcpu)
-- 
2.56.0.385.gd3acb90ef8-goog

