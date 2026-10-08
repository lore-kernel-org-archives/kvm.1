Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A9532572F;
	Thu,  8 Oct 2026 00:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791418488; cv=none; b=Pk6nUMclq5b+sENp1Pfa9FUXnXUd1GwzBjuu/CYzNcui6hTcCz3rEnyvN+51SbNENNWbmzhjj9h7dMt1iAjyr6vfUmEwcv/tI5voGeXGVi/9lW7xhmTtK1yrKPrYDC3fmDSvthVNE4EYanrNnBprDuq4kgAATC0WMb+e4MLzryU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791418488; c=relaxed/simple;
	bh=4cKEni9IeONvuKDfaR2j2fPOBa7RFfsIjpOLCcTTixs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L6Xkq0gmeAq68MYZF5po9qR++PWNuX9TxxWk12wwk54q0Bzcmus5Yl5KdmyozlqC5SkXwT3BJ8WAsDV1F8pIRvD0OX04OOQVidR9Y3uhMbjZczy36AMpQAWFZdTtw/VAbyBlq6cdrCcKMQghOMkZyzPSALUar7pukC5gfPH1kFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMEBCRV2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMEBCRV2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA031F0089B;
	Thu,  8 Oct 2026 00:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791418486;
	bh=d1mn1KfP/SWIYemd/tpX4Mzc7rhemaKpqSsgYxfnM4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dMEBCRV2fIYpaM+rzUDJbZKZsraVyO1n+j5O9I10CuujoheQcp7TGX/aWNz4BmxN/
	 4R7vY382nUB/G2alEDzC3qSo4ijNYD+jzTpIFmtDr6Kcp9BxuUpnIv6cE0ul5A31cI
	 JO9KoaK2+vyblwAO3l0A+rNTeuwV7jYATY2/vLyv1hRRh5A5HLUgQuZKHyFaleumqV
	 anbFDEpuvh0WcxhZsOQjOZCoYu1/vuGS7Tz95XHPnjm6Vykff9+DXxDKV7I5YEtawf
	 cJ2DXoKrjWlYYf64xeCIhRQvY+qSxg9sAIQ2E3r8XKTHqVvfbRTTwgEKMDEY/r+T7I
	 LG7eOBoZ3XOkw==
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
Subject: [PATCH v2 15/29] KVM: x86: hyper-v: Allow purging all TLB flush FIFOs
Date: Thu,  8 Oct 2026 00:14:11 +0000
Message-ID: <20261008001425.2458927-16-yosry@kernel.org>
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
2.56.0.360.g66cac248cb-goog

