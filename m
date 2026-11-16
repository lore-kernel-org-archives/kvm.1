Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794847502;
	b=UmxMiy9qN/m5z01Dgra1BaKKRY43tRFZYlVxTOjrQk9y2+8EP8br9gKG7oZ8q4WODbpR
	 8efvsLnV8FBaMpAa7r84+zmawWWLHj4KBrnV89YaN6NzPG5Ax3PMA3QYqENf9VmzAPdK2
	 /kjyD8yqGjLLG/HpFGdp82FdUf8R/3PH16IwCb78wfWIUKbqBturw1Pz8Tx26Hyqj3roY
	 7LN+S5unotqi7I7giNh6q3zLB4vzQGuaPXyN36jKLF4zjdbn1nOuovRx3Cvz9k9i3/w8C
	 LiqjLlLqqR6eOeTjhUH30armWyL5oncr9vNH1cHhmRFwHAWKuo8wxabRILFcLhkSPew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794847502;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1WPoqGi2px42pq8l4rck7z63ZyprHNkBWJ3KISFzEnA=;
	b=kvKieDiqI1f9q/NV/WZtpI/Z1OAeyOPcvx2x3rDNu/1vCaaiF/oH1rSgDT3O3wEAQWDL
	 p5mzPBhpKki+XP1tQW2VONIU7ohYubZ4m4MrrhL+OoXh/38+ykWyDUjZqSKjvaWpnhxJG
	 lC9MMMhmtU/ZUA/BHR11ItHhDYPExW+sO3ZrqSBZU5PZhV1X/3TET9axnFpcrvaBjPw9t
	 rWG9S81y0lPeBKd5jjVdnIEXvXKqvvCPcxV/1q38lMrI64xwhOJsnWe815yxTZz/dY/2w
	 LupRSwwWCAU0KioOrR4JUREuXNgok9BquUFQXwIwvu7eGT1Kt5Oh7+Jbb+KbXA+ZajA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=HwUsHvpE;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F6A606A332;
	Mon, 16 Nov 2026 16:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41F6A606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=HwUsHvpE
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAE0E1A25;
	Mon, 16 Nov 2026 08:44:57 -0800 (PST)
Received: from e122027.arm.com (unknown [10.57.63.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 802FB3F763;
	Mon, 16 Nov 2026 08:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794847500; bh=Ek5240AP6arZnOi9Llr66ibiBnLBh+imwrZbHHlGrAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HwUsHvpEs7K3NEIOOYtZBaqxEmrjC5iLySuMGLpjtP+isbz6aMl4Jqq82+uX1Aulj
	 oqVb3rgh8obIz/T0xUcoqDb75a2dWV7t3/sb75lp2xfYcBEJT1839i3cfOwUTo05Bm
	 8CPhbgOaiQm+s8iHuvET+5dMzjzkydphA1tGvbmw=
From: Steven Price <steven.price@arm.com>
To: kvm@vger.kernel.org,
	kvmarm@lists.linux.dev
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>,
	James Morse <james.morse@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Joey Gouly <joey.gouly@arm.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	Christoffer Dall <christoffer.dall@arm.com>,
	Fuad Tabba <tabba@google.com>,
	linux-coco@lists.linux.dev,
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
	Gavin Shan <gshan@redhat.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	Alper Gun <alpergun@google.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Emi Kisanuki <fj0570is@fujitsu.com>,
	Vishal Annapurve <vannapurve@google.com>,
	WeiLin.Chang@arm.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kohei Enju <enju.kohei@fujitsu.com>,
	Steven Price <steven.price@arm.com>
Subject: [PATCH v3 08/11] KVM: arm64: CCA: Prevent memslot modifications after Realm creation
Date: Mon, 16 Nov 2026 16:43:54 +0000
Message-ID: <20261116164358.142785-9-steven.price@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116164358.142785-1-steven.price@arm.com>
References: <20261116164358.142785-1-steven.price@arm.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Once the Realm is created, prevent changes to guest_memfd backed
memslots, which can provide private memory. Validate these changes
before KVM invalidates the old memslot, so a rejected deletion leaves
its stage-2 mappings intact. Realm stage-2 faults will also validate
the private memory backing in a later commit.

Require Realm memslots to lie in the lower half of the IPA space, as the
upper, shared half aliases the lower, protected half.

Define kvm_arch_has_private_mem() so generic KVM recognizes Realm VMs
as supporting private memory.

Additionally, similar to pKVM, do not support dirty logging or
read-only memslots.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Steven Price <steven.price@arm.com>

---
Changes since v1:
- Preserve private mappings if KVM invalidates a Realm guest_memfd
  slot before the prepare hook rejects its deletion.
---
 arch/arm64/include/asm/kvm_host.h |  2 ++
 arch/arm64/kvm/mmu.c              | 37 +++++++++++++++++++++++--------
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index aaac97a7461c..2c8cd9a1dd52 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1611,6 +1611,8 @@ struct kvm *kvm_arch_alloc_vm(void);
 
 #define kvm_vm_hyp_is_distrusting(kvm)	((kvm)->arch.vm_flavor >= __VM_DISTRUSTING_HYP)
 
+#define kvm_arch_has_private_mem(kvm) kvm_vm_is_realm(kvm)
+
 #define kvm_has_mte(kvm)					\
 	(system_supports_mte() &&				\
 	 test_bit(KVM_ARCH_FLAG_MTE_ENABLED, &(kvm)->arch.flags))
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 759ac0453828..0db3c293fdd5 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -2858,17 +2858,32 @@ int kvm_arch_validate_memory_region(struct kvm *kvm,
 {
 	lockdep_assert_held(&kvm->slots_lock);
 
-	if (kvm_vm_is_protected(kvm)) {
+	if (kvm_vm_is_protected(kvm) && new &&
+	    (new->flags & (KVM_MEM_LOG_DIRTY_PAGES | KVM_MEM_READONLY)))
+		return -EPERM;
+
+	switch (kvm->arch.vm_flavor) {
+	case VM_PROTECTED_PKVM:
 		/* Cannot modify memslots once a pVM has run. */
 		if (pkvm_hyp_vm_is_created(kvm) &&
-		    (change == KVM_MR_DELETE || change == KVM_MR_MOVE)) {
+		    (change == KVM_MR_DELETE || change == KVM_MR_MOVE))
 			return -EPERM;
-		}
+		break;
+	case VM_REALM:
+		/*
+		 * Once the Realm is created, we cannot modify any slots that
+		 * could be providing private memory. i.e., guest_memfd backed
+		 * slots.
+		 * TODO: Handle trusted device private memory slots
+		 */
+		if (!kvm_realm_is_created(kvm))
+			break;
 
-		if (new &&
-		    new->flags & (KVM_MEM_LOG_DIRTY_PAGES | KVM_MEM_READONLY)) {
+		if (kvm_slot_has_gmem(old) || kvm_slot_has_gmem(new))
 			return -EPERM;
-		}
+		break;
+	default:
+		break;
 	}
 
 	return 0;
@@ -2880,6 +2895,7 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 				   enum kvm_mr_change change)
 {
 	hva_t hva, reg_end;
+	gfn_t ipa_limit;
 	int ret = 0;
 
 	if (change != KVM_MR_CREATE && change != KVM_MR_MOVE &&
@@ -2887,10 +2903,13 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 		return 0;
 
 	/*
-	 * Prevent userspace from creating a memory region outside of the IPA
-	 * space addressable by the KVM guest IPA space.
+	 * Realm shared IPAs alias the corresponding private IPAs, so memslots
+	 * must reside entirely in the canonical lower half of the IPA space.
 	 */
-	if ((new->base_gfn + new->npages) > (kvm_phys_size(&kvm->arch.mmu) >> PAGE_SHIFT))
+	ipa_limit = kvm_phys_size(&kvm->arch.mmu) >> PAGE_SHIFT;
+	if (kvm_vm_is_realm(kvm))
+		ipa_limit >>= 1;
+	if (new->base_gfn + new->npages > ipa_limit)
 		return -EFAULT;
 
 	/*
-- 
2.43.0

