Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24E125B085;
	Tue, 28 Jul 2026 00:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198977; cv=none; b=KHFf/yAg8nZ6fGFd//ZZUBcWqvGDoLIJKO7OtTBg30djyvuaOu1lvJFrz9OI+4uvFqKxW02DeU6MKvipWbnOsS5eZapxKosbWSeA8raCG8xcL2frOYYsmjfCQzyzIK2993cGkpGrLSF+Kcx5PeFQxyEk/lBPUSd8MaTo/uJ7vvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198977; c=relaxed/simple;
	bh=Z9ofwpY3x5lE65rcIsaX9tK9WPl0byo9wHQ2oqYRgbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DKdRMoly570hFwgsrCoRPP05pSqhvq0oPvkyGFLw1QayAqmAKNLXbzDzK8SK3+TjGZ8n2FaR97rpJu5G1FzK+XgSQCRm3fhY0WG2HRQswk+DandymRFNkI8GIXNDguOSaaq9WS9/8Uui73B4RkRccnyl6PAxC4ziJoVSqvh7GT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ome8MlZW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ome8MlZW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226761F00A3F;
	Tue, 28 Jul 2026 00:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785198975;
	bh=jt2hgf3+6dwBOkWIvWeVpTffT3a21hqN1rSRmTwUP+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ome8MlZW4/z/iYOKRcnmV2y/Uez/hjzdctZTawCvY0P11nJ/d43hr3/JKdMBrJHS8
	 HO9XQ6ZltEeMMIAqzRLLrbXqyX/RZjHiUP6qAZQymPSneEp1osF3e+7wq2aVWe722u
	 O8b3kbximCKcxvdTVn6JfHN0/5FutI3dFB5PDKZpJJQd3SXg8o2E4k7DZYNjJxBxxh
	 4fIUmPN/Lj/Rdsnmu7Pu4JV0xX0LxpjwDn+bWsEPbb3sFWAuuU3J8NWIT5o9W+Hr8y
	 wgsOXZrE3oId/yapxal8M58BI9d7QwnnVlATBGZKANHVBFfeHB4UxNzsoUusiGDzkC
	 M6N4bMhjPaIZw==
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
Subject: [PATCH v1 24/28] KVM: x86/mmu: Refactor kvm_mmu_invlpg() to allow skipping the GVA flush
Date: Tue, 28 Jul 2026 00:35:53 +0000
Message-ID: <20260728003557.1136583-25-yosry@kernel.org>
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
index 1889413759d2e..0d3e3b351b31c 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6664,8 +6664,8 @@ static void kvm_mmu_sync_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 	write_unlock(&vcpu->kvm->mmu_lock);
 }
 
-void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
-			     u64 addr, unsigned long roots)
+static void __kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
+				      u64 addr, unsigned long roots, bool flush_gva)
 {
 	struct kvm_mmu *mmu;
 	int i;
@@ -6678,7 +6678,8 @@ void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 		if (is_noncanonical_invlpg_address(addr, vcpu))
 			return;
 
-		kvm_x86_call(flush_tlb_gva)(vcpu, addr);
+		if (flush_gva)
+			kvm_x86_call(flush_tlb_gva)(vcpu, addr);
 
 		if (tdp_enabled)
 			return;
@@ -6700,9 +6701,15 @@ void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
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
@@ -6714,11 +6721,16 @@ void kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva)
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
2.55.0.229.g6434b31f56-goog

