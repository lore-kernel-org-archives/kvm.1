Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6643375C5;
	Tue, 16 Jun 2026 00:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570554; cv=none; b=DQT5GSJp1OKmSKak786kXCqB+etcUfGklBaL+UC9rvsbmwbI5drDP+/6s4lBnVUFed5GgYNHkARUzdKlB69B/A6x4f0SGNa2mogdbI3Y4NiaR7t3nkont2ZWlGBpVbMupFqZ/QMlC79mR7HS3lZHJ8y11OqICa9O0Ab9FfA5/qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570554; c=relaxed/simple;
	bh=Ofk7XjGdZe3zA+TQEjI2qphzto1E6uZhHrsnKbSk/EE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHRxKRgZxxJEP2Xc3I4SNcdLBfXf1CMNGARVuJagByjZDS36CHTUvQ/vrfFVZGiA6CkjJvpPDvAekX+dnKOlbN/bcg7J8OUDAh+0tcl1/LbKbUyZAELspTeDZ+noG1ZywyVvvV8AGdmqvnB2uOT0CCFZ2ZzlZtwt/SO/W7UE9xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mawfKENp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mawfKENp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3215E1F000E9;
	Tue, 16 Jun 2026 00:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781570552;
	bh=iG8lmbheWSbsSoNzXf/SgLXZrP2xHsQevX/Bzvi4E/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mawfKENppxaCeHoiZ1sAuzplP2wTRty1IgPiJMD2PIWWHDasW/iKGoUIzSECHREC2
	 cITbl8tzJQibZdEy4/hLMrunyKPqpaX1XZweOo39SjNSyoSWmZLbT9EhxRcA7jitdG
	 20tUkNZlQd844pXJiblMlKFV2xng9bDN8NNBNGICNmrSDXiYsBXIuy9aHKz8InUhj5
	 +AEupY3erVZy+CO87Asgwj02/idakDKo6VVo9WGxHuuhz3x8NNKJ14YB2mPxxA7cPa
	 /1bZw2hYEqy03kD1a9b6vAS4dntnNKg/PiGOpUllb6TbP5sNoLaAt3RZ5sr7mx9tR8
	 Cof1z0JNEdGZg==
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
Subject: [RFC PATCH v2 22/25] KVM: x86/mmu: Refactor kvm_mmu_invlpg() to allow skipping the gva flush
Date: Tue, 16 Jun 2026 00:41:51 +0000
Message-ID: <20260616004155.1435766-23-yosry@kernel.org>
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

Refactor helpers out of kvm_mmu_invalidate_addr() and kvm_mmu_invlpg()
that take in an extra argument to skip the GVA flush.

This will be used when invalidating GVAs in a different context than the
correct one (i.e.  invalidating an L2 GVA from L1), so flushing the
current context would flush the wrong TLB entries.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/mmu/mmu.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 65c35ed8f4a01..3feb75732f7b4 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6615,15 +6615,15 @@ static void kvm_mmu_invalidate_addr_in_root(struct kvm_vcpu *vcpu,
 	write_unlock(&vcpu->kvm->mmu_lock);
 }
 
-void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
-			     u64 addr, unsigned long roots)
+static void __kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
+				      u64 addr, unsigned long roots, bool flush_gva)
 {
 	int i;
 
 	WARN_ON_ONCE(roots & ~KVM_MMU_ROOTS_ALL);
 
 	/* It's actually a GPA for vcpu->arch.guest_mmu.  */
-	if (mmu != &vcpu->arch.guest_mmu) {
+	if (flush_gva && mmu != &vcpu->arch.guest_mmu) {
 		/* INVLPG on a non-canonical address is a NOP according to the SDM.  */
 		if (is_noncanonical_invlpg_address(addr, vcpu))
 			return;
@@ -6642,9 +6642,15 @@ void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 			kvm_mmu_invalidate_addr_in_root(vcpu, mmu, addr, mmu->prev_roots[i].hpa);
 	}
 }
+
+void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
+			       u64 addr, unsigned long roots)
+{
+	__kvm_mmu_invalidate_addr(vcpu, mmu, addr, roots, true);
+}
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_invalidate_addr);
 
-void kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva)
+static void __kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva, bool flush_gva)
 {
 	/*
 	 * INVLPG is required to invalidate any global mappings for the VA,
@@ -6656,11 +6662,16 @@ void kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva)
 	 * be synced when switching to that new cr3, so nothing needs to be
 	 * done here for them.
 	 */
-	kvm_mmu_invalidate_addr(vcpu, vcpu->arch.walk_mmu, gva, KVM_MMU_ROOTS_ALL);
+	__kvm_mmu_invalidate_addr(vcpu, vcpu->arch.walk_mmu, gva,
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
2.54.0.1136.gdb2ca164c4-goog

