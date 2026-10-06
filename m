Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3072D0614
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 03:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791255672; cv=none; b=V8LUuVuUUvvFz3tTqtcAEHNXI9nzn+5YPlMXEMRvWlkztMjxSo8QvwG2llRi5sOOwW33sHQZoYcqw7gMMSbTEauLjjNSCys4Wj77VQpd5LtaWoVKvW9HI8uIc/uSUrgcZ6shEvAX63etFgECc++o+eOLFHA2O3KqhmKRtma3sSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791255672; c=relaxed/simple;
	bh=zeTZ2+q7/rM4wiP77zJbSjHtDXn20c99SaN/0DOByv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fU+se9mhAexuO64Ycv4r++wkEn/r5KO7BrPB3WTboMq77blBjOeUb17NZN03g4xUtY6yWwtUdRyF1cwW82PHegz8v0uEpN/npiT6xSV47kRkn3O3Hlg9u5rjvYiQsGrIqtv9XGpXoVUO19mj3G5sdd/R+L2Z4XL5kW8jElWsRLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GEPE4eO6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jpXfORsk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GEPE4eO6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jpXfORsk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791255668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fMmY6n/MH6ca3TbNnMvPhVpWJPvoIQVMRX+7sRuvar4=;
	b=GEPE4eO6gmKfNXgr51p+tXm3kZhIWSXD+rJVG8R5p3zhjxvh+blneQOEGe/9fIKX8b0wth
	ZT3CTYH/LyDPWpAxaORanv51nej2Msqo9xNe5YO77G1gv3/0HuOT5mnZD2qyaXVGft+70r
	TszkJ3Tbxds0dAPaj4Q9xSFr4o5rLLM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-6R0SrOcaNHuK6DR7KFARiw-1; Mon, 05 Oct 2026 23:01:07 -0400
X-MC-Unique: 6R0SrOcaNHuK6DR7KFARiw-1
X-Mimecast-MFC-AGG-ID: 6R0SrOcaNHuK6DR7KFARiw_1791255666
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39de4a68f7cso2005896a91.1
        for <kvm@vger.kernel.org>; Mon, 05 Oct 2026 20:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791255666; x=1791860466; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fMmY6n/MH6ca3TbNnMvPhVpWJPvoIQVMRX+7sRuvar4=;
        b=jpXfORskwcYMGzH031ifJKbudMvajbnVdqa9irSSC8ISvEMW3CbDsDbMLTcgBD7cC2
         4b+INF84eLR68V1SrU/lb6sfuynKxPYbCTWz2ZhWU8XQI/J3V82gf9w/Tg4xtcLqgtXk
         trBoUBukipZI706xlMSUIErFBQ8GG29+V5POiHa9sPtdPFe2EFnaORaPCUPdcmZy3JJr
         m/dbEAKTsX4KjCB7KC5DQdWygWT35sdqjxhxb+w9U7bIdJtRg7P1v0SenkGXTBz1rBb7
         6YYKIryNq62KRsBHvZExrkuA+193eEW+Zg+Ueo8jTZ/emakK3yBWjTRxLTs/J+icLjee
         wPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791255666; x=1791860466;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fMmY6n/MH6ca3TbNnMvPhVpWJPvoIQVMRX+7sRuvar4=;
        b=lUsAPrCN8a3JRtSh/i4u2MQqzrxb4QKoFVnwUH+RD9Y6Hd+esqe7sXdgU02oJk8kfO
         qolGrnssad0hK6B01j5uJM5qCGKKXKRzLbH5848oTBZHw3SfWLiGeI6ZczIhaUBrqVbj
         /iCjuqIOGtBKZDbkRkD1O7rmVOXFXp+JGdXY/7dZ9u9YCDzURSh3fcFtedr0agxf8it2
         HaN4rzg+70Eghev+mbTfOAt5HS/zo78Vz/r8EUN8gwu+K2krKhs6X8RI2RNdyPR5l8Dg
         ex8C6U4EOIG1I5pXkDifAGZ8zP76PArEyiTK8vXjo9k9nBOh0+6TlD0zfSz2ymke+2Ms
         ATDQ==
X-Forwarded-Encrypted: i=1; AKwUvBzRoR5mL2ka0NGVjkwHoofifn0id4NLs/cwa5Uk0udEGw+hMIjoADyfAKZe4fDOzY3mSe0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZVz9iHO0Am/GiSphjOZ1CJCU3H0mkYHh7o3+hX/D4F/43DVGT
	y7XAcFaEVEDZwKf1wGlh/+/IsNAVoUCZICO3nTawfeqfjmnjLfoq+ojsljik+hPakILSNQpv4gk
	2myB0nMsPi6e2JX6Oz7nj2SmA2JM9dba4pxQmBr6hnan4PIkz7x3UlQ==
X-Gm-Gg: AYBFou2HWlig3sup+BqPJtGYaK9n0ClEocW2v748lexclB1XpCAdEH0sSECU9Ho7VVt
	EOlyZ45q7hFs2QMeHNTIj1mYI5LEgYxja6PXfn00fTYixT9GnDI4XhhCTlhLBxOIQCZkZTT8p0F
	Arz2Uhe4dYILj0+9cK1wTXbrB5ey2CRxW6Wz00hQ5nn3/wWhqIGG+9G5lFl9a20PhMdJJ8qLDoF
	qtuwB9JBn76d86YW0CTrjFzP/If0jBN9s+H+BuZhJ31fNdSnJjEwdfHAbNuOhvalKTSrqTAxPd6
	BhvGU+XvvjaMJ953oAKBP33bCxbg5dhaucXdhbSGR1eSNclw66WQ6HbgWK7x0gDqBJEG/gjTM63
	p82bgE/5auyl0znBB5lwBJVqSRq0rx55+l/0pEfYPfg==
X-Received: by 2002:a17:90b:4c4d:b0:3a8:240e:b493 with SMTP id 98e67ed59e1d1-3a8734fcaddmr7230a91.45.1791255666068;
        Mon, 05 Oct 2026 20:01:06 -0700 (PDT)
X-Received: by 2002:a17:90b:4c4d:b0:3a8:240e:b493 with SMTP id 98e67ed59e1d1-3a8734fcaddmr7192a91.45.1791255665438;
        Mon, 05 Oct 2026 20:01:05 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6dd1c308csm8666500a91.2.2026.10.05.20.00.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 20:01:04 -0700 (PDT)
Message-ID: <b6de5d5c-e7e5-4e24-abd6-bdea9bcf8db6@redhat.com>
Date: Tue, 6 Oct 2026 13:00:55 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 11/23] KVM: arm64: Add VM specific callback for S2 MMU
 operations
To: Suzuki K Poulose <suzuki.poulose@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: maz@kernel.org, will@kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 steven.price@arm.com, aneesh.kumar@kernel.org, oupton@kernel.org,
 joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com,
 linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com,
 sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com,
 WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com,
 sudeep.holla@arm.com, jonathan.cameron@oss.qualcomm.com
References: <20261005090754.2140522-1-suzuki.poulose@arm.com>
 <20261005090754.2140522-12-suzuki.poulose@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20261005090754.2140522-12-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/5/26 7:07 PM, Suzuki K Poulose wrote:
> Add VM type specific S2 MMU operation backends which can be initialized per
> VM flavor, to keep the handling cleaner.
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Change since v21:
>   - Define all vm_s2_ops call back. All calls are mandatory.
>   - Define callback for each flavor, disjointing the non-protetcted pKVM and
>     normal KVM (VHE & nVHE) and remove the KVM_PGT_FN() hacks.
>   - Dropped Reviews due to the changes.
>   - Add "no_age_gfn" and "no_stage2_unmap_range" for pKVM callbacks, no_age_*
>     to be also reused by Realms later.
>   - Move kvm_vm_s2_ops field to keep the structure packed
> ---
>   arch/arm64/include/asm/kvm_host.h |  14 +++
>   arch/arm64/kvm/mmu.c              | 173 +++++++++++++++++++++++++-----
>   2 files changed, 160 insertions(+), 27 deletions(-)
> 

With the following nitpicks addressed:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 839f5e9c7c65e..0778c308ce597 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -155,6 +155,19 @@ struct kvm_vcpu_ops {
>   	void (*vcpu_put)(struct kvm_vcpu *vcpu);
>   };
>   
> +struct kvm_gfn_range;
> +
> +struct kvm_vm_s2_ops {
> +	bool (*vm_age_gfn)(struct kvm *kvm, struct kvm_gfn_range *range);
> +	bool (*vm_test_age_gfn)(struct kvm *kvm, struct kvm_gfn_range *range);
> +	int (*vm_flush_remote_tlbs)(struct kvm *kvm);
> +	int (*vm_flush_remote_tlbs_range)(struct kvm *kvm, gfn_t gfn,
> +					  u64 nr_pages);
> +	void (*vm_stage2_unmap_range)(struct kvm_s2_mmu *mmu,
> +				      phys_addr_t start, u64 size,
> +				      bool may_block);
> +};
> +
>   struct kvm_s2_mmu {
>   	struct kvm_vmid vmid;
>   
> @@ -321,6 +334,7 @@ enum kvm_arm_vm_flavor {
>   
>   struct kvm_arch {
>   	struct kvm_s2_mmu mmu;
> +	const struct kvm_vm_s2_ops *vm_s2_ops;
>   
>   	enum kvm_arm_vm_flavor vm_flavor;
>   	/* Mandated version of PSCI */
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 4ae3bb6baef1a..c046c76833876 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -37,6 +37,8 @@ static unsigned long __ro_after_init io_map_base;
>   
>   #define KVM_PGT_FN(fn)		(!is_protected_kvm_enabled() ? fn : p ## fn)
>   
> +static int kvm_vm_init_vm_s2_ops(struct kvm *kvm);
> +
>   static phys_addr_t __stage2_range_addr_end(phys_addr_t addr, phys_addr_t end,
>   					   phys_addr_t size)
>   {
> @@ -166,6 +168,18 @@ static bool memslot_is_logging(struct kvm_memory_slot *memslot)
>   	return memslot->dirty_bitmap && !(memslot->flags & KVM_MEM_READONLY);
>   }
>   
> +static int pkvm_flush_remote_tlbs(struct kvm *kvm)
> +{
> +	kvm_call_hyp_nvhe(__pkvm_tlb_flush_vmid, kvm->arch.pkvm.handle);
> +	return 0;
> +}
> +
> +static int kvm_vm_flush_remote_tlbs(struct kvm *kvm)
> +{
> +	kvm_call_hyp(__kvm_tlb_flush_vmid, &kvm->arch.mmu);
> +	return 0;
> +}
> +
>   /**
>    * kvm_arch_flush_remote_tlbs() - flush all VM TLB entries for v7/8
>    * @kvm:	pointer to kvm structure.
> @@ -174,26 +188,31 @@ static bool memslot_is_logging(struct kvm_memory_slot *memslot)
>    */
>   int kvm_arch_flush_remote_tlbs(struct kvm *kvm)
>   {
> -	if (is_protected_kvm_enabled())
> -		kvm_call_hyp_nvhe(__pkvm_tlb_flush_vmid, kvm->arch.pkvm.handle);
> -	else
> -		kvm_call_hyp(__kvm_tlb_flush_vmid, &kvm->arch.mmu);
> -	return 0;
> +	return kvm->arch.vm_s2_ops->vm_flush_remote_tlbs(kvm);
>   }
>   
> -int kvm_arch_flush_remote_tlbs_range(struct kvm *kvm,
> -				      gfn_t gfn, u64 nr_pages)
> +static int pkvm_flush_remote_tlbs_range(struct kvm *kvm,
> +					gfn_t gfn, u64 nr_pages)
> +{
> +	return pkvm_flush_remote_tlbs(kvm);

No need to have another function call, which causes unnecessary overhead?

	kvm_call_hyp_nvhe(__pkvm_tlb_flush_vmid, kvm->arch.pkvm.handle);
	return 0;

> +}
> +
> +static int kvm_vm_flush_remote_tlbs_range(struct kvm *kvm,
> +					 gfn_t gfn, u64 nr_pages)
>   {
>   	u64 size = nr_pages << PAGE_SHIFT;
>   	u64 addr = gfn << PAGE_SHIFT;
>   
> -	if (is_protected_kvm_enabled())
> -		kvm_call_hyp_nvhe(__pkvm_tlb_flush_vmid, kvm->arch.pkvm.handle);
> -	else
> -		kvm_tlb_flush_vmid_range(&kvm->arch.mmu, addr, size);
> +	kvm_tlb_flush_vmid_range(&kvm->arch.mmu, addr, size);
>   	return 0;
>   }
>  

Since we're here, the local variable 'addr' and 'size' can be dropped by:

	kvm_tlb_flush_vmid_range(&kvm->arch.mmu,
                                  gfn << PAGE_SHIFT,
                                  nr_pages << PAGE_SHIFT);

  
> +int kvm_arch_flush_remote_tlbs_range(struct kvm *kvm,
> +				     gfn_t gfn, u64 nr_pages)
> +{
> +	return kvm->arch.vm_s2_ops->vm_flush_remote_tlbs_range(kvm, gfn, nr_pages);
> +}
> +
>   static void *stage2_memcache_zalloc_page(void *arg)
>   {
>   	struct kvm_mmu_memory_cache *mc = arg;
> @@ -289,6 +308,27 @@ static void invalidate_icache_guest_page(void *va, size_t size)
>   	__invalidate_icache_guest_page(va, size);
>   }
>   
> +static void kvm_vm_stage2_unmap_range(struct kvm_s2_mmu *mmu,
> +				      phys_addr_t start,
> +				      u64 size, bool may_block)
> +{
> +	WARN_ON(stage2_apply_range(mmu, start, start + size,
> +				   kvm_pgtable_stage2_unmap, may_block));
> +}
> +
> +static void pkvm_stage2_unmap_range(struct kvm_s2_mmu *mmu,
> +				    phys_addr_t start,
> +				    u64 size, bool may_block)
> +{
> +	WARN_ON(stage2_apply_range(mmu, start, start + size,
> +				   pkvm_pgtable_stage2_unmap, may_block));
> +}
> +
> +static void no_stage2_unmap_range(struct kvm_s2_mmu *mmu,
> +				  phys_addr_t start, u64 size, bool may_block)
> +{
> +}
> +
>   /*
>    * Unmapping vs dcache management:
>    *
> @@ -329,15 +369,10 @@ void kvm_stage2_unmap_range(struct kvm_s2_mmu *mmu, phys_addr_t start,
>   {
>   	struct kvm *kvm = kvm_s2_mmu_to_kvm(mmu);
>   
> -	if (kvm_vm_is_protected(kvm))
> -		return;
> -
>   	lockdep_assert_held_write(&kvm->mmu_lock);
>   	WARN_ON(size & ~PAGE_MASK);
>   
> -	WARN_ON(stage2_apply_range(mmu, start, start + size,
> -				   KVM_PGT_FN(kvm_pgtable_stage2_unmap),
> -				   may_block));
> +	kvm->arch.vm_s2_ops->vm_stage2_unmap_range(mmu, start, size, may_block);
>   }
>   
>   void kvm_stage2_flush_range(struct kvm_s2_mmu *mmu, phys_addr_t addr, phys_addr_t end)
> @@ -977,6 +1012,12 @@ int kvm_init_stage2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu, unsigned long t
>   	int cpu, err;
>   	struct kvm_pgtable *pgt;
>   
> +	/* Initialize the VM ops for the VM instance for the first time */
> +	if (mmu == &kvm->arch.mmu) {
> +		err = kvm_vm_init_vm_s2_ops(kvm);
> +		if (err)
> +			return err;
> +	}
>   	/*
>   	 * If we already have our page tables in place, and that the
>   	 * MMU context is the canonical one, we have a bug somewhere,
> @@ -2441,34 +2482,68 @@ bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
>   	return false;
>   }
>   
> -bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
> +static bool kvm_vm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
>   {
>   	u64 size = (range->end - range->start) << PAGE_SHIFT;
>   
> -	if (!kvm->arch.mmu.pgt || kvm_vm_is_protected(kvm))
> -		return false;
> -
> -	return KVM_PGT_FN(kvm_pgtable_stage2_test_clear_young)(kvm->arch.mmu.pgt,
> +	return kvm_pgtable_stage2_test_clear_young(kvm->arch.mmu.pgt,
>   						   range->start << PAGE_SHIFT,
>   						   size, true);
> +}
> +
> +static bool pkvm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
> +{
> +	u64 size = (range->end - range->start) << PAGE_SHIFT;
> +
> +	return pkvm_pgtable_stage2_test_clear_young(kvm->arch.mmu.pgt,
> +						    range->start << PAGE_SHIFT,
> +						    size, true);
> +}
> +
> +static bool no_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
> +{
> +	/* The hypervisor doesn't support aging */
> +	return false;
> +}
> +
> +bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
> +{
> +	if (!kvm->arch.mmu.pgt)
> +		return false;
> +
> +	return kvm->arch.vm_s2_ops->vm_age_gfn(kvm, range);
>   	/*
>   	 * TODO: Handle nested_mmu structures here using the reverse mapping in
>   	 * a later version of patch series.
>   	 */
>   }
>   
> -bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
> +static bool kvm_vm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
>   {
>   	u64 size = (range->end - range->start) << PAGE_SHIFT;
>   
> -	if (!kvm->arch.mmu.pgt || kvm_vm_is_protected(kvm))
> -		return false;
> -
> -	return KVM_PGT_FN(kvm_pgtable_stage2_test_clear_young)(kvm->arch.mmu.pgt,
> +	return kvm_pgtable_stage2_test_clear_young(kvm->arch.mmu.pgt,
>   						   range->start << PAGE_SHIFT,
>   						   size, false);
>   }
>   
> +static bool pkvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
> +{
> +	u64 size = (range->end - range->start) << PAGE_SHIFT;
> +
> +	return pkvm_pgtable_stage2_test_clear_young(kvm->arch.mmu.pgt,
> +						    range->start << PAGE_SHIFT,
> +						    size, false);
> +}
> +
> +bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
> +{
> +	if (!kvm->arch.mmu.pgt)
> +		return false;
> +
> +	return kvm->arch.vm_s2_ops->vm_test_age_gfn(kvm, range);
> +}
> +
>   phys_addr_t kvm_mmu_get_httbr(void)
>   {
>   	return __pa(hyp_pgtable->pgd);
> @@ -2790,3 +2865,47 @@ void kvm_toggle_cache(struct kvm_vcpu *vcpu, bool was_enabled)
>   
>   	trace_kvm_toggle_cache(*vcpu_pc(vcpu), was_enabled, now_enabled);
>   }
> +
> +static const struct kvm_vm_s2_ops protected_pkvm_vm_s2_ops = {
> +	.vm_flush_remote_tlbs		= pkvm_flush_remote_tlbs,
> +	.vm_flush_remote_tlbs_range	= pkvm_flush_remote_tlbs_range,
> +	.vm_age_gfn			= no_age_gfn,
> +	.vm_test_age_gfn		= no_age_gfn,
> +	.vm_stage2_unmap_range		= no_stage2_unmap_range,
> +};
> +
> +static const struct kvm_vm_s2_ops pkvm_vm_s2_ops = {
> +	.vm_flush_remote_tlbs		= pkvm_flush_remote_tlbs,
> +	.vm_flush_remote_tlbs_range	= pkvm_flush_remote_tlbs_range,
> +	.vm_age_gfn			= pkvm_age_gfn,
> +	.vm_test_age_gfn		= pkvm_test_age_gfn,
> +	.vm_stage2_unmap_range		= pkvm_stage2_unmap_range,
> +};
> +
> +static const struct kvm_vm_s2_ops kvm_default_vm_s2_ops = {
> +	.vm_flush_remote_tlbs		= kvm_vm_flush_remote_tlbs,
> +	.vm_flush_remote_tlbs_range	= kvm_vm_flush_remote_tlbs_range,
> +	.vm_age_gfn			= kvm_vm_age_gfn,
> +	.vm_test_age_gfn		= kvm_vm_test_age_gfn,
> +	.vm_stage2_unmap_range		= kvm_vm_stage2_unmap_range,
> +};
> +
> +#define KVM_VM_S2_OPS(flavor, ops)		\
> +		[flavor] = &(ops)

s/[flavor]/[(flavor)]

> +
> +static const struct kvm_vm_s2_ops *arm64_vm_s2_ops[] = {
> +	KVM_VM_S2_OPS(VM_VHE, kvm_default_vm_s2_ops),
> +	KVM_VM_S2_OPS(VM_NVHE, kvm_default_vm_s2_ops),
> +	KVM_VM_S2_OPS(VM_PKVM, pkvm_vm_s2_ops),
> +	KVM_VM_S2_OPS(VM_PROTECTED_PKVM, protected_pkvm_vm_s2_ops),
> +};
> +
> +static int kvm_vm_init_vm_s2_ops(struct kvm *kvm)
> +{
> +	BUILD_BUG_ON(ARRAY_SIZE(arm64_vm_s2_ops) != VM_FLAVOR_MAX);
> +
> +	kvm->arch.vm_s2_ops = arm64_vm_s2_ops[kvm->arch.vm_flavor];
> +	if (WARN_ON(!kvm->arch.vm_s2_ops))
> +		return -EINVAL;
> +	return 0;
> +}

Thanks,
Gavin

