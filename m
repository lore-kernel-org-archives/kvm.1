Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D272C326D;
	Tue, 28 Jul 2026 00:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198972; cv=none; b=cURxzMwLQylsl5kP7hgQ+mxuplBVOVARlTdFAy//lusbppMXuCvLQPdZ/tNBt1hBqwyuvHm2UxQ8D13bYZj3VldAv3utRHMle9N2LtPJu/fltM3mcCycnerZWkdCoJqvqt2QVLaaF+hzJrCMTPRd/BZyUj7wCWytCyGgxzlRsiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198972; c=relaxed/simple;
	bh=nij1/rpNQx+ga9GPkdJiQPJYpuTQug1PfaThTOK6bIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bCtKaLYvZUdvQe69AfAxhpm3Jf/9vBjknPSoLaqzP7M7RDg5YM9eJkPcVwkkaZGQ6q4rBOahcPyVXKOCIjyQE2piQVijWRyz7KIuawkHyuOl/oXiR5sc+z/kbFvQGV9Ds3xH4rtqkGDWTx6qTOLVR6KBPGv/yaS4DmNKicaCfDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlz44p4i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlz44p4i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37FEA1F000E9;
	Tue, 28 Jul 2026 00:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785198970;
	bh=L2TARsW0OlLLtKaPTwFKrHWyvof4W2F/PDusdwnNz4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jlz44p4i3uHi9V7abijXruxMoAFz6pGvEEFuFSxpBRR5cplt2s0KT1oceBrp9eBfF
	 2MMIWjVo1O/8HwBeI8bmuNy664TolhvcNPnvnsbcBwgt52IsooXdgaSs1grdtIJc2O
	 9BD15CyClIQ/llou/nQrPNp0ueCEEd4gjK987AiiPoaCHKMofRBkZD9WUb64IZA0KC
	 HkSmkSIZq2L/c50kGOqmEe575tFAoI8XtjcPe7fKDWNxA7gy3sEe2w4vS6c2GHCSOe
	 hru0679BTAYSeyt2MoMWotzaw9l+H0selOoQ50pPtRbjV51lTM7pXBw9o6QY7n4Kl4
	 7EufMWcpTcPow==
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
Subject: [PATCH v1 14/28] KVM: x86: hyper-v: Allow puring all TLB flush FIFOs
Date: Tue, 28 Jul 2026 00:35:43 +0000
Message-ID: <20260728003557.1136583-15-yosry@kernel.org>
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

Refactor kvm_hv_purge_tlb_flush_fifo() to introduce an inner helper,
__kvm_hv_purge_tlb_flush_fifo(), parameterized by an optional FIFO. If a
FIFO is not passed in, all FIFOs are purged.

Note that KVM_REQ_HV_TLB_FLUSH is consumed by
__kvm_hv_purge_tlb_flush_fifo(), so a selective purge on one FIFO will
render any subsequent non-selective purge useless. This is not a problem
because purging TLB flush FIFOs is an optimization (and there are
currently no users of the non-selective purges).

No functional change intended as a FIFO is always being passed in now.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/hyperv.h | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index 03cc65f8cc52d..a23ef05c1075c 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -312,18 +312,29 @@ static inline struct kvm_vcpu_hv_tlb_flush_fifo *kvm_hv_get_tlb_flush_fifo(struc
 	return &hv_vcpu->tlb_flush_fifo[i];
 }
 
-static inline void kvm_hv_purge_tlb_flush_fifo(struct kvm_vcpu *vcpu)
+/* Purge pending TLB flushes in @fifo, or in all FIFOs if @fifo is NULL */
+static inline void __kvm_hv_purge_tlb_flush_fifo(struct kvm_vcpu *vcpu,
+						 struct kvm_vcpu_hv_tlb_flush_fifo *fifo)
 {
-	struct kvm_vcpu_hv_tlb_flush_fifo *tlb_flush_fifo;
+	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
+	int i;
 
-	if (!kvm_check_request(KVM_REQ_HV_TLB_FLUSH, vcpu))
+	if (!hv_vcpu || !kvm_check_request(KVM_REQ_HV_TLB_FLUSH, vcpu))
 		return;
 
-	tlb_flush_fifo = kvm_hv_get_tlb_flush_fifo(vcpu, is_guest_mode(vcpu));
-	if (!tlb_flush_fifo)
-		return;
+	for (i = 0; i < ARRAY_SIZE(hv_vcpu->tlb_flush_fifo); i++) {
+		if (!fifo || fifo == &hv_vcpu->tlb_flush_fifo[i])
+			kfifo_reset_out(&hv_vcpu->tlb_flush_fifo[i].entries);
+	}
+}
+
+static inline void kvm_hv_purge_tlb_flush_fifo(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_hv_tlb_flush_fifo *fifo;
 
-	kfifo_reset_out(&tlb_flush_fifo->entries);
+	fifo = kvm_hv_get_tlb_flush_fifo(vcpu, is_guest_mode(vcpu));
+	if (fifo)
+		__kvm_hv_purge_tlb_flush_fifo(vcpu, fifo);
 }
 
 static inline bool guest_hv_cpuid_has_l2_tlb_flush(struct kvm_vcpu *vcpu)
-- 
2.55.0.229.g6434b31f56-goog

