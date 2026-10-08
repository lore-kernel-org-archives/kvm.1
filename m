Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586CB37D114;
	Thu,  8 Oct 2026 00:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791418492; cv=none; b=I53KzKRxDk9gpKgO3le4l4Z4sSGESVdJe/OFc0BeS/9WJgEAwH/4iyfMP5Gd2NOc4jDomcD3pHp+5k+NHy/nQuVICPUvZ3YhlTiaXDgtStTXSiuDw/khBNSuZ0NP3gqaxcAyEHtCObREtjWGir7GI2Rk5I1leHTI8FZu9/OmSWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791418492; c=relaxed/simple;
	bh=p/JHLdJ/2FcqZ4i07VEkcyq+jZG7UT3p/7zwFIbGbSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3Mfb8VqqXrtB16M41QCJWR9QbUFkbEt6YCJpaGJ9iogdy4UrjmBQvhk/JoP6F861xIHI34/PV05WicOS65pScUuK60NgUwhbO6eb+bMlEDm+AQam964Jlju+A/8eoJ5HnLTd5No0/uYqpTSERg5r5I1yOX3UEDEdXcGPcg6Cac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emAGPrDY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emAGPrDY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52A71F0089B;
	Thu,  8 Oct 2026 00:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791418491;
	bh=YWxlI+8uD8m7L0GQ/Idq54KFRyMP2tzsHbXZXRIEqGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=emAGPrDY4X5m2CHTviXpvYDPiuREotrzlr+SCLNdE2h1Lsoonj9NWk+9WGdGf+heq
	 Z08voAY5x1+XWqkmfeFcUen7pb7u9WAgMvdXRxxT+eS4eG2itvQ96jW2KVOHiP+40x
	 z01iWgI4OTNA6+A225KdgN8DZFovE0TfPTYzZsQ048JBQm2TAbteOzkC8mJsMUPhtE
	 yAqtnsXzMUYK45Lm1iDfqHG1qRoxM00VdST3zEYKfBr/BidbJ4CbADJc010ZXF/78S
	 9ynuMP+RcxuuvoYLqToEWj54iRxYf3tQ6hqV8l6oGyzhjw7TC0cPPosI8WduEnMAri
	 EKjnlg50ZSVoQ==
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
Subject: [PATCH v2 25/29] KVM: x86/mmu: Refactor kvm_mmu_invlpg() to allow skipping the GVA flush
Date: Thu,  8 Oct 2026 00:14:21 +0000
Message-ID: <20261008001425.2458927-26-yosry@kernel.org>
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

Refactor helpers out of kvm_mmu_invalidate_addr() and kvm_mmu_invlpg()
that take in an extra argument to skip the GVA flush.

This will be used when invalidating GVAs in a different context than the
current one (i.e.  invalidating an L2 GVA from L1), so flushing the
current context would flush the wrong TLB entries.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/mmu/mmu.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index b3085f409d0de..433ed69b1e1e4 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6769,8 +6769,8 @@ static void kvm_mmu_sync_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 	write_unlock(&vcpu->kvm->mmu_lock);
 }
 
-void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
-			     u64 addr, unsigned long roots)
+static void __kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
+				      u64 addr, unsigned long roots, bool flush_gva)
 {
 	struct kvm_mmu *mmu;
 	int i;
@@ -6783,7 +6783,8 @@ void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 		if (is_noncanonical_invlpg_address(addr, vcpu))
 			return;
 
-		kvm_x86_call(flush_tlb_gva)(vcpu, addr);
+		if (flush_gva)
+			kvm_x86_call(flush_tlb_gva)(vcpu, addr);
 
 		if (tdp_enabled)
 			return;
@@ -6805,9 +6806,15 @@ void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 			kvm_mmu_sync_addr(vcpu, mmu, addr, mmu->prev_roots[i].hpa);
 	}
 }
+
+void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
+			     u64 addr, unsigned long roots)
+{
+	__kvm_mmu_invalidate_addr(vcpu, w, addr, roots, true);
+}
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_invalidate_addr);
 
-void kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva)
+static void __kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva, bool flush_gva)
 {
 	/*
 	 * INVLPG is required to invalidate any global mappings for the VA,
@@ -6819,11 +6826,16 @@ void kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva)
 	 * be synced when switching to that new cr3, so nothing needs to be
 	 * done here for them.
 	 */
-	kvm_mmu_invalidate_addr(vcpu, &vcpu->arch.gva_walk, gva, KVM_MMU_ROOTS_ALL);
+	__kvm_mmu_invalidate_addr(vcpu, &vcpu->arch.gva_walk, gva,
+				  KVM_MMU_ROOTS_ALL, flush_gva);
 	++vcpu->stat.invlpg;
 }
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_invlpg);
 
+void kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva)
+{
+	__kvm_mmu_invlpg(vcpu, gva, true);
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_invlpg);
 
 void kvm_mmu_invpcid_gva(struct kvm_vcpu *vcpu, gva_t gva, unsigned long pcid)
 {
-- 
2.56.0.360.g66cac248cb-goog

