Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95285427F91
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 23:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786057868; cv=pass; b=pEBZ+H2SSo6bVc4LaUEasCvdh38sbNmmypm7tZQlbbSq3G95yNbwuj2KvRjqReCP494I+QfcUUk637MEpu0eNy0ZV1+SyMPrlJwZarE1MqUx2UY55+Fgsn38tIKoc7S8EIE3QF5Rjvow9W36spq/NC/1gWxq4dgC/48NQJ8LP90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786057868; c=relaxed/simple;
	bh=nkXo0xC1vTXR7jZXAE1qrib+Ve4UVXE5cqnW6CmOr6Q=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WkKUx+/ijdXccS+kpIixN5g4aPH7acWG1nWY8jGt0kUapmDUkzbAseWt+cTQVJcuraQlOdfX1s/pJVaoNzpNeSsO737TaSFJl/zivDaHGACvlXYhFY5boZkA9YgyMMDTVJbQhX7WY+Vqz77Ip6GME4kR0/6ztWEgaNgVEot+V0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CD8k4iQm; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CD8k4iQm"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-caf45fc5202so2474048a12.1
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 16:11:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786057865; cv=none;
        d=google.com; s=arc-20260327;
        b=WAdkj+u9O/t/0t78uRgzJOxE6kuad6TeFVu9xp2t1pOBrPueqyW8felNZN4VPEcWl6
         JiHTdd2GPv1JH4ELnyJty9YUQlnTiCJDFRgSZbeELWUFai85xjjn914Iqu7I4jC69B8e
         gMxSGBigRqN3mUf7gpHUYI3WRZ3Dr2MW4zF7ExOmNobKjdYWKAWzK5dZhQNJA7RR0vDi
         vla7wMZ2yo86D9wcSohzjJp8ihKTKXYPz0nzyv+G8GPCr8w5paXlflqY422aDtC1TFyN
         rVZE/HPFrNnomZ9SGCSNSEDkQnZ/LHMUF607oiHYC6TX3/1aLnsEe3EC9beZY/C+Jn4/
         Yn0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=yK7VBLLiEyYXFN6c5UBfVy/7xge4jYybX2MxxbDVCdM=;
        fh=TM79qXTS38WqYE4GkDydJfZzM65HcsLFKEBGfMc47m8=;
        b=cOC4rQD7AIL6iznKbwpRURgau/UW2VviGN4J5RAgmhGcAkX+cei6EE5Xv0SkEkrAgB
         3OUbVq8uh93qAb/iOL4hcUS/tR2TFopcgqx6oNOKgmzUegGekKjm5yYlaiu3Ld5QRz3W
         TZuZHnpAYCl9WGpNQrun5mqx+m68wFbCcsApKpUU8YJhxuLYK9TkToPATaMeHbdD7eTF
         A1Td/whkUqjF75sy47K/gci2qmUZHdKDtjj6YVqfERv2Sl0YKSRQJyTeF5GB1/l5N3O1
         thC/voDAgn3PjMOpE/3h+IAANPJadPKvJJ+LEVnTnPiDGHwSOVDlWS2lntxstoWt6sgG
         VDvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786057865; x=1786662665; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yK7VBLLiEyYXFN6c5UBfVy/7xge4jYybX2MxxbDVCdM=;
        b=CD8k4iQm1pgkjYUjmX8iA3pM025QB2x/qdk/mxLMxI+Bg8H2Abeplw1pIl6u34JFE7
         L+udFGCJbmWEpY2vUVTaMrPsLq00qERHPDrz3JlwLp7/SG7Nwc8FaskLllAzaoVTyoKH
         a1cSupvNe3UzRCg9QuMwRWvKrMvRC1iQnPJ/0KHY64Z2KFu9B5OWLJnvh1rMnkV9LTdJ
         J/Q45IV8M36kV368apqMeY+/p6MDg//cKb/Bhd6755JdP60s9xUoSaKpAB+uL6zDp/Pm
         aQhDN3ZzpaKb7I9HQ8cQoUaPZoez+uIwob3V5eCycNu/n3R8mP9wc7H/Tbcm6BuzaSuC
         ZbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786057865; x=1786662665;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yK7VBLLiEyYXFN6c5UBfVy/7xge4jYybX2MxxbDVCdM=;
        b=sW6UgoWKRkvYnIBGdlB2V29lH7Av1KofhxF8hdjzJkPbTOWhOtGPNRLHpSsAVIj3/o
         9Uf9zw3GzEhKen23xlS8/pzVeG3L6xwNcifi5T5dliiRPVKwtfsBj9TcRLSbZ6acIFkQ
         eSQcsOG8J4meaZ+g+QO0pamNwtLxzne5jA2zjHXF2eCy7SuaZ/nqwbGFTQysO/JunSQ0
         ufYVEZyMRGjvLwwMqFV0VAKxRYbDrk4xAg3NfexhDCLs5OemjGYG9rBsbgvC+Pb3GkAU
         zkpy6od0TtJVWWJ+yqD3O6kjEK0M/7HWIhokuoudHvSgX46WoT5IJYkVJ+WBuQtnDBKg
         0KFQ==
X-Forwarded-Encrypted: i=1; AHgh+RqzPy6SP33tYxdr/Fq1X1cYauoyCJL2Gf+qG3iWS7EymAHAoRg7DcMRTn9FpNGatTL1D5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOexqpQJLu5ychkpsO2U5trGXeCAEW4QWklAerktDSYRuo9oOR
	g65uPZJyvHTwmpnH6eiAkjNuQJuxJOlppwaCUXgLvWQSw+BU6WjynpCoowkjuETl1bF+B8ox81d
	XQ17yMIK5xYtOqToayN8J6WjzlagFCQOa8tmtEDiP
X-Gm-Gg: AR+sD12Wm/BnFelI2WkEGsPa5XlryBue52TiTqC1/LTPRG9JQI5Y1JElQbQV5dPIYts
	ijxRKgiQ/4FQydhxvm1v2UCmbg8Ilu9x1n0P1lRT2BaSDgRcY1q+kDB9J+GV+1X7k+AvMlzrkf4
	634IAF+8qYR7pKjoWr4O3b5kuLjDUKfjlQEvIUp1p1IKKfDX5CMjjZs1NmRHpjLi0/MCM81igGy
	iBeXbJhfdj9G80Gn0ncdBNCNL7P9NVziCQjMj2K+d3dCES+pkhx+mWkN9aavdFUuwNGuO5HhAjR
	12pHa5zPiyKgr0yHqsQ3C00orR+Hea9TSGr0nknxRNsr0ZnP9tMHn/JfEHzXr+vUfkANECKLgkG
	EEpKxoSpZXwEybHXomGA89qAFCR+2lriGSts=
X-Received: by 2002:a05:6a20:7350:b0:3c3:f371:1ea9 with SMTP id
 adf61e73a8af0-3cb85df12fbmr20744921637.10.1786057863909; Thu, 06 Aug 2026
 16:11:03 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Aug 2026 16:11:02 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Aug 2026 16:11:02 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260803134403.80630-30-steven.price@arm.com>
References: <20260803134403.80630-1-steven.price@arm.com> <20260803134403.80630-30-steven.price@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 6 Aug 2026 16:11:02 -0700
X-Gm-Features: AUfX_mzcxBku8HfloGVS7GeuKAhZNlklDoZe3BX8N-NxsuAYB3pCOeCzhnyuF-M
Message-ID: <CAEvNRgFB7xkjFgd38K92orLtvOQVngEYsPRky=DWpZ30BTnNDw@mail.gmail.com>
Subject: Re: [PATCH v16 29/45] KVM: arm64: CCA: Support runtime faulting of memory
To: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org, kvmarm@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>, 
	Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Christoffer Dall <christoffer.dall@arm.com>, 
	Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, Gavin Shan <gshan@redhat.com>, 
	Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun <alpergun@google.com>, 
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Emi Kisanuki <fj0570is@fujitsu.com>, 
	Vishal Annapurve <vannapurve@google.com>, WeiLin.Chang@arm.com, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Steven Price <steven.price@arm.com> writes:

> At runtime if the realm guest accesses memory which hasn't yet been
> mapped then KVM needs to either populate the region or fault the guest.
>
> For memory in the lower (protected) region of IPA a fresh page is
> provided to the RMM which will zero the contents. For memory in the
> upper (shared) region of IPA, the memory from the memslot is mapped
> into the realm VM non secure.
>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Changes since v15:
>  * Handle negative error codes.
> Changes since v13:
>  * Numerous changes due to rebasing.
>  * Fix addr_range_desc() to encode the correct block size.
> Changes since v12:
>  * Switch to RMM v2.0 range based APIs.
> Changes since v11:
>  * Adapt to upstream changes.
> Changes since v10:
>  * RME->RMI renaming.
>  * Adapt to upstream gmem changes.
> Changes since v9:
>  * Fix call to kvm_stage2_unmap_range() in kvm_free_stage2_pgd() to set
>    may_block to avoid stall warnings.
>  * Minor coding style fixes.
> Changes since v8:
>  * Propagate the may_block flag.
>  * Minor comments and coding style changes.
> Changes since v7:
>  * Remove redundant WARN_ONs for realm_create_rtt_levels() - it will
>    internally WARN when necessary.
> Changes since v6:
>  * Handle PAGE_SIZE being larger than RMM granule size.
>  * Some minor renaming following review comments.
> Changes since v5:
>  * Reduce use of struct page in preparation for supporting the RMM
>    having a different page size to the host.
>  * Handle a race when delegating a page where another CPU has faulted on
>    a the same page (and already delegated the physical page) but not yet
>    mapped it. In this case simply return to the guest to either use the
>    mapping from the other CPU (or refault if the race is lost).
>  * The changes to populate_par_region() are moved into the previous
>    patch where they belong.
> Changes since v4:
>  * Code cleanup following review feedback.
>  * Drop the PTE_SHARED bit when creating unprotected page table entries.
>    This is now set by the RMM and the host has no control of it and the
>    spec requires the bit to be set to zero.
> Changes since v2:
>  * Avoid leaking memory if failing to map it in the realm.
>  * Correctly mask RTT based on LPA2 flag (see rtt_get_phys()).
>  * Adapt to changes in previous patches.
> ---
>  arch/arm64/include/asm/kvm_emulate.h |   8 +
>  arch/arm64/include/asm/kvm_rmi.h     |   5 +
>  arch/arm64/kvm/mmu.c                 |  97 ++++++++----
>  arch/arm64/kvm/rmi.c                 | 220 +++++++++++++++++++++++++++
>  4 files changed, 304 insertions(+), 26 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> index 2e69fe494716..8b6f9d26b5d8 100644
> --- a/arch/arm64/include/asm/kvm_emulate.h
> +++ b/arch/arm64/include/asm/kvm_emulate.h
> @@ -712,6 +712,14 @@ static inline bool kvm_realm_is_created(struct kvm *kvm)
>  	return kvm_is_realm(kvm) && kvm_realm_state(kvm) != REALM_STATE_NONE;
>  }
>
> +static inline gpa_t kvm_gpa_from_fault(struct kvm *kvm, phys_addr_t ipa)
> +{
> +	if (!kvm_is_realm(kvm))
> +		return ipa;
> +
> +	return ipa & ~BIT(kvm->arch.realm.ia_bits - 1);
> +}
> +
>  static inline bool vcpu_is_rec(const struct kvm_vcpu *vcpu)
>  {
>  	return kvm_is_realm(vcpu->kvm);
> diff --git a/arch/arm64/include/asm/kvm_rmi.h b/arch/arm64/include/asm/kvm_rmi.h
> index 03f8bd2d13a2..967c0a6e8e9c 100644
> --- a/arch/arm64/include/asm/kvm_rmi.h
> +++ b/arch/arm64/include/asm/kvm_rmi.h
> @@ -6,6 +6,7 @@
>  #ifndef __ASM_KVM_RMI_H
>  #define __ASM_KVM_RMI_H
>
> +#include <asm/kvm_pgtable.h>
>  #include <linux/arm-smccc-rmi.h>
>
>  /**
> @@ -117,6 +118,10 @@ void kvm_realm_unmap_range(struct kvm *kvm,
>  			   unsigned long size,
>  			   bool unmap_private,
>  			   bool may_block);
> +int realm_map_ipa(struct kvm *kvm, phys_addr_t ipa,
> +		  kvm_pfn_t pfn, unsigned long map_size,
> +		  enum kvm_pgtable_prot prot,
> +		  struct kvm_mmu_memory_cache *memcache);
>
>  static inline bool kvm_realm_is_private_address(struct realm *realm,
>  						unsigned long addr)
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index dcc2ab08d0e4..79119cb136b0 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -334,8 +334,15 @@ static void __unmap_stage2_range(struct kvm_s2_mmu *mmu, phys_addr_t start, u64
>
>  	lockdep_assert_held_write(&kvm->mmu_lock);
>  	WARN_ON(size & ~PAGE_MASK);
> -	WARN_ON(stage2_apply_range(mmu, start, end, KVM_PGT_FN(kvm_pgtable_stage2_unmap),
> -				   may_block));
> +
> +	if (kvm_is_realm(kvm)) {
> +		kvm_realm_unmap_range(kvm, start, size, !only_shared,
> +				      may_block);
> +	} else {
> +		WARN_ON(stage2_apply_range(mmu, start, end,
> +					   KVM_PGT_FN(kvm_pgtable_stage2_unmap),
> +					   may_block));
> +	}
>  }
>
>  void kvm_stage2_unmap_range(struct kvm_s2_mmu *mmu, phys_addr_t start,
> @@ -358,7 +365,10 @@ static void stage2_flush_memslot(struct kvm *kvm,
>  	phys_addr_t addr = memslot->base_gfn << PAGE_SHIFT;
>  	phys_addr_t end = addr + PAGE_SIZE * memslot->npages;
>
> -	kvm_stage2_flush_range(&kvm->arch.mmu, addr, end);
> +	if (kvm_is_realm(kvm))
> +		kvm_realm_unmap_range(kvm, addr, end - addr, false, true);
> +	else
> +		kvm_stage2_flush_range(&kvm->arch.mmu, addr, end);
>  }
>
>  /**
> @@ -1137,6 +1147,10 @@ void stage2_unmap_vm(struct kvm *kvm)
>  	struct kvm_memory_slot *memslot;
>  	int idx, bkt;
>
> +	/* For realms this is handled by the RMM so nothing to do here */
> +	if (kvm_is_realm(kvm))
> +		return;
> +
>  	idx = srcu_read_lock(&kvm->srcu);
>  	mmap_read_lock(current->mm);
>  	write_lock(&kvm->mmu_lock);
> @@ -1641,18 +1655,20 @@ static int gmem_abort(const struct kvm_s2_fault_desc *s2fd)
>  	bool perm_fault = kvm_vcpu_trap_is_permission_fault(s2fd->vcpu);
>  	enum kvm_pgtable_walk_flags flags = KVM_PGTABLE_WALK_SHARED;
>  	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_R;
> -	struct kvm_pgtable *pgt = s2fd->vcpu->arch.hw_mmu->pgt;
> +	struct kvm_vcpu *vcpu = s2fd->vcpu;
> +	struct kvm_pgtable *pgt = vcpu->arch.hw_mmu->pgt;
> +	gpa_t gpa = kvm_gpa_from_fault(vcpu->kvm, s2fd->fault_ipa);
>  	unsigned long mmu_seq;
>  	struct page *page;
> -	struct kvm *kvm = s2fd->vcpu->kvm;
> +	struct kvm *kvm = vcpu->kvm;
>  	void *memcache = NULL;
>  	kvm_pfn_t pfn;
>  	gfn_t gfn;
>  	int ret;
>
>  	if (!perm_fault) {
> -		memcache = get_mmu_memcache(s2fd->vcpu);
> -		ret = topup_mmu_memcache(s2fd->vcpu, memcache);
> +		memcache = get_mmu_memcache(vcpu);
> +		ret = topup_mmu_memcache(vcpu, memcache);
>  		if (ret)
>  			return ret;
>  	}
> @@ -1660,10 +1676,10 @@ static int gmem_abort(const struct kvm_s2_fault_desc *s2fd)
>  	if (s2fd->nested)
>  		gfn = kvm_s2_trans_output(s2fd->nested) >> PAGE_SHIFT;
>  	else
> -		gfn = s2fd->fault_ipa >> PAGE_SHIFT;
> +		gfn = gpa >> PAGE_SHIFT;

I've seen a gpa_to_gfn(), not sure if it works for ARM or works here.

>
> -	write_fault = kvm_is_write_fault(s2fd->vcpu);
> -	exec_fault = kvm_vcpu_trap_is_exec_fault(s2fd->vcpu);
> +	write_fault = kvm_is_write_fault(vcpu);
> +	exec_fault = kvm_vcpu_trap_is_exec_fault(vcpu);
>
>  	VM_WARN_ON_ONCE(write_fault && exec_fault);
>
> @@ -1673,7 +1689,7 @@ static int gmem_abort(const struct kvm_s2_fault_desc *s2fd)
>
>  	ret = kvm_gmem_get_pfn(kvm, s2fd->memslot, gfn, &pfn, &page, NULL);
>  	if (ret) {
> -		kvm_prepare_memory_fault_exit(s2fd->vcpu, s2fd->fault_ipa, PAGE_SIZE,
> +		kvm_prepare_memory_fault_exit(vcpu, gpa, PAGE_SIZE,
>  					      write_fault, exec_fault, false);
>  		return ret;
>  	}
> @@ -1693,7 +1709,14 @@ static int gmem_abort(const struct kvm_s2_fault_desc *s2fd)
>  	kvm_fault_lock(kvm);
>  	if (mmu_invalidate_retry(kvm, mmu_seq)) {
>  		ret = -EAGAIN;
> -		goto out_unlock;
> +		goto out_release_page;
> +	}
> +
> +	if (kvm_is_realm(kvm)) {
> +		prot &= ~KVM_PGTABLE_PROT_X;
> +		ret = realm_map_ipa(kvm, s2fd->fault_ipa, pfn,
> +				    PAGE_SIZE, prot, memcache);
> +		goto out_release_page;
>  	}
>
>  	if (perm_fault) {
> @@ -1710,7 +1733,7 @@ static int gmem_abort(const struct kvm_s2_fault_desc *s2fd)
>  							 memcache, flags);
>  	}
>
> -out_unlock:
> +out_release_page:
>  	kvm_release_faultin_page(kvm, page, !!ret, prot & KVM_PGTABLE_PROT_W);
>  	kvm_fault_unlock(kvm);
>
> @@ -1896,7 +1919,7 @@ static int kvm_s2_fault_get_vma_info(const struct kvm_s2_fault_desc *s2fd,
>  	 * mapping size to ensure we find the right PFN and lay down the
>  	 * mapping in the right place.
>  	 */
> -	s2vi->gfn = ALIGN_DOWN(s2fd->fault_ipa, s2vi->vma_pagesize) >> PAGE_SHIFT;
> +	s2vi->gfn = kvm_gpa_from_fault(kvm, ALIGN_DOWN(s2fd->fault_ipa, s2vi->vma_pagesize)) >> PAGE_SHIFT;
>
>  	s2vi->mte_allowed = kvm_vma_mte_allowed(vma);
>
> @@ -2092,12 +2115,15 @@ static int kvm_s2_fault_map(const struct kvm_s2_fault_desc *s2fd,
>  	if (!perm_fault_granule && !s2vi->map_non_cacheable && kvm_has_mte(kvm))
>  		sanitise_mte_tags(kvm, pfn, mapping_size);
>
> -	/*
> -	 * Under the premise of getting a FSC_PERM fault, we just need to relax
> -	 * permissions only if mapping_size equals perm_fault_granule. Otherwise,
> -	 * kvm_pgtable_stage2_map() should be called to change block size.
> -	 */
> -	if (mapping_size == perm_fault_granule) {
> +	if (kvm_is_realm(kvm)) {
> +		ret = realm_map_ipa(kvm, s2fd->fault_ipa, pfn, mapping_size,
> +				    prot, memcache);
> +	} else if (mapping_size == perm_fault_granule) {
> +		/*
> +		 * Under the premise of getting a FSC_PERM fault, we just need to relax
> +		 * permissions only if mapping_size equals perm_fault_granule. Otherwise,
> +		 * kvm_pgtable_stage2_map() should be called to change block size.
> +		 */
>  		/*
>  		 * Drop the SW bits in favour of those stored in the
>  		 * PTE, which will be preserved.
> @@ -2263,6 +2289,13 @@ int kvm_handle_guest_sea(struct kvm_vcpu *vcpu)
>  	return 0;
>  }
>
> +static bool shared_ipa_fault(struct kvm *kvm, phys_addr_t fault_ipa)
> +{
> +	gpa_t gpa = kvm_gpa_from_fault(kvm, fault_ipa);
> +
> +	return (gpa != fault_ipa);

If I understood the intent here I think checking kvm->arch.realm.ia_bits
is more obvious. It'd be actually checking if the address is private or
shared rather than going through kvm_gpa_from_fault() indirectly.

Also perhaps define private_ipa_fault() would be better instead of
defining shared and then checking !shared below.

Actually there's already kvm_realm_is_private_address(), perhaps that
can be reused.

> +}
> +
>  /**
>   * kvm_handle_guest_abort - handles all 2nd stage aborts
>   * @vcpu:	the VCPU pointer
> @@ -2373,8 +2406,9 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
>  		nested = &nested_trans;
>  	}
>
> -	gfn = ipa >> PAGE_SHIFT;
> +	gfn = kvm_gpa_from_fault(vcpu->kvm, ipa) >> PAGE_SHIFT;
>  	memslot = gfn_to_memslot(vcpu->kvm, gfn);
> +
>  	hva = gfn_to_hva_memslot_prot(memslot, gfn, &writable);
>  	write_fault = kvm_is_write_fault(vcpu);
>  	if (kvm_is_error_hva(hva) || (write_fault && !writable)) {
> @@ -2417,7 +2451,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
>  		 * of the page size.
>  		 */
>  		ipa |= FAR_TO_FIPA_OFFSET(kvm_vcpu_get_hfar(vcpu));
> -		ret = io_mem_abort(vcpu, ipa);
> +		ret = io_mem_abort(vcpu, kvm_gpa_from_fault(vcpu->kvm, ipa));
>  		goto out_unlock;
>  	}
>
> @@ -2445,7 +2479,9 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
>  				!write_fault &&
>  				!kvm_vcpu_trap_is_exec_fault(vcpu));
>
> -		if (kvm_slot_has_gmem(memslot))
> +		if (kvm_slot_has_gmem(memslot) &&
> +		    (kvm_memslot_is_gmem_only(memslot) ||
> +		     !shared_ipa_fault(vcpu->kvm, fault_ipa)))
>  			ret = gmem_abort(&s2fd);
>  		else
>  			ret = user_mem_abort(&s2fd);
> @@ -2482,6 +2518,10 @@ bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
>  	if (!kvm->arch.mmu.pgt || kvm_vm_is_protected(kvm))
>  		return false;
>
> +	/* We don't support aging for Realms */
> +	if (kvm_is_realm(kvm))
> +		return true;
> +
>  	return KVM_PGT_FN(kvm_pgtable_stage2_test_clear_young)(kvm->arch.mmu.pgt,
>  						   range->start << PAGE_SHIFT,
>  						   size, true);
> @@ -2498,6 +2538,10 @@ bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
>  	if (!kvm->arch.mmu.pgt || kvm_vm_is_protected(kvm))
>  		return false;
>
> +	/* We don't support aging for Realms */
> +	if (kvm_is_realm(kvm))
> +		return true;
> +
>  	return KVM_PGT_FN(kvm_pgtable_stage2_test_clear_young)(kvm->arch.mmu.pgt,
>  						   range->start << PAGE_SHIFT,
>  						   size, false);

These sound like they should be in a separate patch since it's to do
with aging and not faulting.

> @@ -2677,10 +2721,11 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
>  		return -EFAULT;
>
>  	/*
> -	 * Only support guest_memfd backed memslots with mappable memory, since
> -	 * there aren't any CoCo VMs that support only private memory on arm64.
> +	 * Only support guest_memfd backed memslots with mappable memory,
> +	 * unless the guest is a CCA realm guest.
>  	 */
> -	if (kvm_slot_has_gmem(new) && !kvm_memslot_is_gmem_only(new))
> +	if (kvm_slot_has_gmem(new) && !kvm_memslot_is_gmem_only(new) &&
> +	    !kvm_is_realm(kvm))
>  		return -EINVAL;
>
>  	hva = new->userspace_addr;
> diff --git a/arch/arm64/kvm/rmi.c b/arch/arm64/kvm/rmi.c
> index 4f362fd21477..3ef185bc8210 100644
> --- a/arch/arm64/kvm/rmi.c
> +++ b/arch/arm64/kvm/rmi.c
> @@ -649,6 +649,226 @@ static int realm_data_map_init(struct kvm *kvm, unsigned long ipa,
>  	return ret <= 0 ? ret : -ENXIO;
>  }
>
>
> [...snip...]
>
> +static int realm_map_protected(struct kvm *kvm,
> +			       unsigned long ipa,
> +			       kvm_pfn_t pfn,
> +			       unsigned long map_size,
> +			       struct kvm_mmu_memory_cache *memcache)
> +{
> +	struct realm *realm = &kvm->arch.realm;
> +	phys_addr_t phys = __pfn_to_phys(pfn);
> +	phys_addr_t base_phys = phys;
> +	phys_addr_t rd = virt_to_phys(realm->rd);
> +	phys_addr_t delegated_phys;
> +	unsigned long base_ipa = ipa;
> +	unsigned long ipa_top;
> +	long ret = 0;
> +
> +	if (WARN_ON(!IS_ALIGNED(map_size, PAGE_SIZE) ||
> +		    !IS_ALIGNED(ipa, map_size)))
> +		return -EINVAL;
> +
> +	if (rmi_delegate_range(phys, map_size, &delegated_phys)) {
> +		if (delegated_phys == phys) {
> +			/*
> +			 * It's likely we raced with another VCPU on the same
> +			 * fault. Assume the other VCPU has handled the fault
> +			 * and return to the guest.
> +			 */
> +			return 0;
> +		}
> +		/* Partial delegation - map as much as we can */
> +		map_size = delegated_phys - phys;
> +	}
> +
> +	ipa_top = ipa + map_size;
> +
> +	while (ipa < ipa_top) {
> +		unsigned long flags = RMI_ADDR_TYPE_SINGLE;
> +		unsigned long range_desc = addr_range_desc(phys, ipa_top - ipa,
> +							   RMI_OP_MEM_DELEGATED);
> +		unsigned long out_top;
> +
> +		ret = rmi_rtt_data_map(rd, ipa, ipa_top, flags, range_desc,
> +				       &out_top);
> +		if (ret < 0)
> +			goto err_undelegate;
> +
> +		if (RMI_RETURN_STATUS(ret) == RMI_ERROR_RTT) {
> +			/* Create missing RTTs and retry */
> +			int level = RMI_RETURN_INDEX(ret);
> +
> +			if (WARN_ON(level >= KVM_PGTABLE_LAST_LEVEL))
> +				goto err_undelegate;
> +			ret = realm_create_rtt_levels(realm, ipa, level,
> +						      level + 1,
> +						      memcache);
> +			if (ret)
> +				goto err_undelegate;
> +
> +			continue;
> +		}
> +
> +		if (WARN_ON(ret))
> +			goto err_undelegate;
> +
> +		phys += out_top - ipa;
> +		ipa = out_top;
> +	}
> +
> +	return 0;
> +
> +err_undelegate:
> +	realm_unmap_private_range(kvm, base_ipa, ipa, true);
> +	if (WARN_ON(rmi_undelegate_range(base_phys, map_size))) {
> +		/* Page can't be returned to NS world so is lost */
> +		get_page(phys_to_page(base_phys));

Please see my comment on the other patch about taking a refcount. This
will interfere with conversions.

> +	}
> +	return ret < 0 ? ret : -ENXIO;
> +}
> +
>
> [...snip...]
>
