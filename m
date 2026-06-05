Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE382D8DBB
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 06:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780640614; cv=none; b=KEwa+WAZa8KshyZ21t0x+V7UDUuyacCG9PmYYbVLGlz8oENNOoFgngSDxjHA3xbweMkOjyc1LdHtf1uZkFstjFT24a/nnMii5Spxdyw0JDgRA18JC5GJrTIMkq+TFzl0jyUcz+RO4xf9hOn7ymVYdE5JHGsvXoU82tCDmRo41QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780640614; c=relaxed/simple;
	bh=Jhq21R3v+EUqPffc3Ew4pJAwE0ztCLAwYWchnLxGdh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CtwM8gu1xzvDVJkWaDjvmY0JEw7toGvXWc2DQdCTlXN8ttNxany5BFfXsgR0JQ8ybta3wXN65aLMJkD/pdVBDVrw+2uFbMsFeGOKxdnk6RPwU9WYT3DgegsDh4HDYdtfEkv9qbdiFa1vM4XsXaMkvWtuVKdV4g4TjWvHZAp3dQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FXY/jlF6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DuuAKwWv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FXY/jlF6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DuuAKwWv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780640610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a7n4joI34A1IQTHELBcS31h+Hq0GctZL4AOR76MSgrA=;
	b=FXY/jlF6+tA99RcUc/W8Bz/DBL+oTper8H/xtW/qqlO9VHd5ThCmMpM0d8u93PvqZuciaN
	9ABCWBcorlcMCPs/DgR38/WTz9dYUP5Mi5Ry/Nl9xGkPUVIUDKh0gFKFeESaggyl7uAhh2
	7+WhiNY6mB93SDDLBZa75mHzzsjLOrw=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-XEK-Kh5mN8qG8SEXthORdQ-1; Fri, 05 Jun 2026 02:23:29 -0400
X-MC-Unique: XEK-Kh5mN8qG8SEXthORdQ-1
X-Mimecast-MFC-AGG-ID: XEK-Kh5mN8qG8SEXthORdQ_1780640608
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c85a3669a15so951514a12.1
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 23:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780640608; x=1781245408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a7n4joI34A1IQTHELBcS31h+Hq0GctZL4AOR76MSgrA=;
        b=DuuAKwWvJlKuaKmp0c1l+ZYTAkkjcU9buIh6OKS85OgRocOgxUmKv8RROQ3O1/06jE
         ejIvU6+yDxmFncJDiehrSdI2AoONF5GGf3uBB7fhmS7lUiluDOQr41ELN69Q10zj9lBS
         t2NEQOqyD1VDj6hByFcMtTsWcHRYasOKnTzjToC+aR0YEWLksnBc0DCMZ4gcz1W7dYdI
         agoigCrWW3QeVrvfDS9rwGYnQ2w8ARcBtdqhE4j1I61Q5ca2KBwSdpIcvJ0+8UIJm+ze
         d6H0epUy3SAf3vaPP9jFAPqAYzNGgm34sUQQYTOMo0fG2HPp8L2p4w1vyfp0ojVzqzh0
         on5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780640608; x=1781245408;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a7n4joI34A1IQTHELBcS31h+Hq0GctZL4AOR76MSgrA=;
        b=ODjj0YuYq+n/Mxg/M6YfhfQirHEFqKmT1KuujmKZqsQjounqISQPH2Ml/8GpexI9F1
         OeJdRxLrNbLzqYUfWboQ7AiD/+1m2sR3f3k3pWCXJaPTNdDTDuD0OO96tNyWuiGclrGE
         n7rsiq3Ji4DtQ9ZTkkx/K29Fis/OSl7U1GXa5RH20bgWVKxNTzY7C9Cm64aMFUOHsrIB
         1j7T0964sDB8POZ1OuMrghVb6hHDHL0TYvkaU+Hftvi4SpgR5X3kNqce+fEUz1qMImmJ
         JzzBaEfbbwmIKDh7REwd+7CofNttKj3qMRl9jP5UtaF496sfCsNRtoWRHdxxRQympSoE
         iJ2A==
X-Forwarded-Encrypted: i=1; AFNElJ/n97ZNtozNe6NQM/ylxq+/TjDKtKfALacgQtqAGJhonTg89dGnIMXsgS/6x81bx19VA08=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjnemwCiEL5IofRj9nq8MT0bKSzQUBuL8ombs4p1OOGrJN+7J/
	2P+3Qx0hrcUWeeeUt9C1L2ZJCzzD5XI/ewXl1uHY/WF6pxnsWO97KrgZZb7HV4xiS/Tn7fNAeAK
	81ZH7bgglAp7Xi4i/SuCUFOmrbqJiiAneskzBMdX00ufg9cZt2bRECw==
X-Gm-Gg: Acq92OGTll61zqxUCch4apSJZEwU/3Q4czDHNj283gs0RZBr2cBkra/D2K8Y43H3hiM
	NklCMXBZiCO1ZiXUu8fWiRGts0xciAjleEKgUJEI72oK1mgKP3MLGJbtNKJ8ksViMkbwFndzGAy
	Fw4UaxONZfarIRDc0smgO99lD2n4wUDk52It54dIGy6XMVZxCNrOiZQWxmdRTq8VeCSLdK/phP/
	aelflHGUHS2oCihJB8TEmTZGLSpzcfDMcauTe+/gc+q7fB8qcKx9docCQZfghVtVhiaOkYrm6AK
	0S3kzTawgjWs7QjEKDY+r0uMoKm+d9/GsBqs81t3d9xNFh1mAvgGK+qRgqjBpy1p5zO2IoOQQUe
	y6RyxWtT1rqOrwdkJplkEEeAiXl/w1r+vfAsyWWetYUdLKT8LI4deVAivsATI9Mc4QzW4dmeT9e
	k=
X-Received: by 2002:a05:6a00:2e05:b0:842:3838:cb03 with SMTP id d2e1a72fcca58-842b66eaa54mr1150734b3a.11.1780640608148;
        Thu, 04 Jun 2026 23:23:28 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e05:b0:842:3838:cb03 with SMTP id d2e1a72fcca58-842b66eaa54mr1150694b3a.11.1780640607490;
        Thu, 04 Jun 2026 23:23:27 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282220d1bsm8817560b3a.12.2026.06.04.23.23.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 23:23:26 -0700 (PDT)
Message-ID: <3359f788-07fa-41a1-9ac7-45c58577c1fa@redhat.com>
Date: Fri, 5 Jun 2026 16:23:15 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 29/44] arm64: RMI: Runtime faulting of memory
To: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, Fuad Tabba <tabba@google.com>,
 linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun
 <alpergun@google.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
 Emi Kisanuki <fj0570is@fujitsu.com>, Vishal Annapurve
 <vannapurve@google.com>, WeiLin.Chang@arm.com, Lorenzo.Pieralisi2@arm.com
References: <20260513131757.116630-1-steven.price@arm.com>
 <20260513131757.116630-30-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260513131757.116630-30-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Steve,

On 5/13/26 11:17 PM, Steven Price wrote:
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
> Changes since v13:
>   * Numerous changes due to rebasing.
>   * Fix addr_range_desc() to encode the correct block size.
> Changes since v12:
>   * Switch to RMM v2.0 range based APIs.
> Changes since v11:
>   * Adapt to upstream changes.
> Changes since v10:
>   * RME->RMI renaming.
>   * Adapt to upstream gmem changes.
> Changes since v9:
>   * Fix call to kvm_stage2_unmap_range() in kvm_free_stage2_pgd() to set
>     may_block to avoid stall warnings.
>   * Minor coding style fixes.
> Changes since v8:
>   * Propagate the may_block flag.
>   * Minor comments and coding style changes.
> Changes since v7:
>   * Remove redundant WARN_ONs for realm_create_rtt_levels() - it will
>     internally WARN when necessary.
> Changes since v6:
>   * Handle PAGE_SIZE being larger than RMM granule size.
>   * Some minor renaming following review comments.
> Changes since v5:
>   * Reduce use of struct page in preparation for supporting the RMM
>     having a different page size to the host.
>   * Handle a race when delegating a page where another CPU has faulted on
>     a the same page (and already delegated the physical page) but not yet
>     mapped it. In this case simply return to the guest to either use the
>     mapping from the other CPU (or refault if the race is lost).
>   * The changes to populate_par_region() are moved into the previous
>     patch where they belong.
> Changes since v4:
>   * Code cleanup following review feedback.
>   * Drop the PTE_SHARED bit when creating unprotected page table entries.
>     This is now set by the RMM and the host has no control of it and the
>     spec requires the bit to be set to zero.
> Changes since v2:
>   * Avoid leaking memory if failing to map it in the realm.
>   * Correctly mask RTT based on LPA2 flag (see rtt_get_phys()).
>   * Adapt to changes in previous patches.
> ---
>   arch/arm64/include/asm/kvm_emulate.h |   8 ++
>   arch/arm64/include/asm/kvm_rmi.h     |  12 ++
>   arch/arm64/kvm/mmu.c                 | 128 ++++++++++++++++----
>   arch/arm64/kvm/rmi.c                 | 173 +++++++++++++++++++++++++++
>   4 files changed, 301 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> index 2e69fe494716..8b6f9d26b5d8 100644
> --- a/arch/arm64/include/asm/kvm_emulate.h
> +++ b/arch/arm64/include/asm/kvm_emulate.h
> @@ -712,6 +712,14 @@ static inline bool kvm_realm_is_created(struct kvm *kvm)
>   	return kvm_is_realm(kvm) && kvm_realm_state(kvm) != REALM_STATE_NONE;
>   }
>   
> +static inline gpa_t kvm_gpa_from_fault(struct kvm *kvm, phys_addr_t ipa)
> +{
> +	if (!kvm_is_realm(kvm))
> +		return ipa;
> +
> +	return ipa & ~BIT(kvm->arch.realm.ia_bits - 1);
> +}
> +
>   static inline bool vcpu_is_rec(const struct kvm_vcpu *vcpu)
>   {
>   	return kvm_is_realm(vcpu->kvm);
> diff --git a/arch/arm64/include/asm/kvm_rmi.h b/arch/arm64/include/asm/kvm_rmi.h
> index a2b6bc412a22..b65cfec10dee 100644
> --- a/arch/arm64/include/asm/kvm_rmi.h
> +++ b/arch/arm64/include/asm/kvm_rmi.h
> @@ -6,6 +6,7 @@
>   #ifndef __ASM_KVM_RMI_H
>   #define __ASM_KVM_RMI_H
>   
> +#include <asm/kvm_pgtable.h>
>   #include <asm/rmi_smc.h>
>   
>   /**
> @@ -97,6 +98,17 @@ void kvm_realm_unmap_range(struct kvm *kvm,
>   			   unsigned long size,
>   			   bool unmap_private,
>   			   bool may_block);
> +int realm_map_protected(struct kvm *kvm,
> +			unsigned long base_ipa,
> +			kvm_pfn_t pfn,
> +			unsigned long size,
> +			struct kvm_mmu_memory_cache *memcache);
> +int realm_map_non_secure(struct realm *realm,
> +			 unsigned long ipa,
> +			 kvm_pfn_t pfn,
> +			 unsigned long size,
> +			 enum kvm_pgtable_prot prot,
> +			 struct kvm_mmu_memory_cache *memcache);
>   
>   static inline bool kvm_realm_is_private_address(struct realm *realm,
>   						unsigned long addr)
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index ac2a0f0106b0..776ffe56d17e 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -334,8 +334,15 @@ static void __unmap_stage2_range(struct kvm_s2_mmu *mmu, phys_addr_t start, u64
>   
>   	lockdep_assert_held_write(&kvm->mmu_lock);
>   	WARN_ON(size & ~PAGE_MASK);
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
>   }
>   
>   void kvm_stage2_unmap_range(struct kvm_s2_mmu *mmu, phys_addr_t start,
> @@ -358,7 +365,10 @@ static void stage2_flush_memslot(struct kvm *kvm,
>   	phys_addr_t addr = memslot->base_gfn << PAGE_SHIFT;
>   	phys_addr_t end = addr + PAGE_SIZE * memslot->npages;
>   
> -	kvm_stage2_flush_range(&kvm->arch.mmu, addr, end);
> +	if (kvm_is_realm(kvm))
> +		kvm_realm_unmap_range(kvm, addr, end - addr, false, true);
> +	else
> +		kvm_stage2_flush_range(&kvm->arch.mmu, addr, end);
>   }
>   
>   /**
> @@ -1103,6 +1113,10 @@ void stage2_unmap_vm(struct kvm *kvm)
>   	struct kvm_memory_slot *memslot;
>   	int idx, bkt;
>   
> +	/* For realms this is handled by the RMM so nothing to do here */
> +	if (kvm_is_realm(kvm))
> +		return;
> +
>   	idx = srcu_read_lock(&kvm->srcu);
>   	mmap_read_lock(current->mm);
>   	write_lock(&kvm->mmu_lock);
> @@ -1528,6 +1542,29 @@ static bool kvm_vma_mte_allowed(struct vm_area_struct *vma)
>   	return vma->vm_flags & VM_MTE_ALLOWED;
>   }
>   
> +static int realm_map_ipa(struct kvm *kvm, phys_addr_t ipa,
> +			 kvm_pfn_t pfn, unsigned long map_size,
> +			 enum kvm_pgtable_prot prot,
> +			 struct kvm_mmu_memory_cache *memcache)
> +{
> +	struct realm *realm = &kvm->arch.realm;
> +
> +	/*
> +	 * Write permission is required for now even though it's possible to
> +	 * map unprotected pages (granules) as read-only. It's impossible to
> +	 * map protected pages (granules) as read-only.
> +	 */
> +	if (WARN_ON(!(prot & KVM_PGTABLE_PROT_W)))
> +		return -EFAULT;
> +

I'm a bit concerned with this. We don't have KVM_PGTABLE_PROT_W set in @prot
if the stage2 fault is raised due to memory read. With -EFAULT returned to VMM
(e.g. QEMU), the vCPU continuous execution is stopped and system won't be
working any more.

> +	ipa = ALIGN_DOWN(ipa, PAGE_SIZE);
> +	if (!kvm_realm_is_private_address(realm, ipa))
> +		return realm_map_non_secure(realm, ipa, pfn, map_size, prot,
> +					    memcache);
> +
> +	return realm_map_protected(kvm, ipa, pfn, map_size, memcache);
> +}
> +
>   static bool kvm_vma_is_cacheable(struct vm_area_struct *vma)
>   {
>   	switch (FIELD_GET(PTE_ATTRINDX_MASK, pgprot_val(vma->vm_page_prot))) {
> @@ -1604,27 +1641,52 @@ static int gmem_abort(const struct kvm_s2_fault_desc *s2fd)
>   	bool write_fault, exec_fault;
>   	enum kvm_pgtable_walk_flags flags = KVM_PGTABLE_WALK_SHARED;
>   	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_R;
> -	struct kvm_pgtable *pgt = s2fd->vcpu->arch.hw_mmu->pgt;
> +	struct kvm_vcpu *vcpu = s2fd->vcpu;
> +	struct kvm_pgtable *pgt = vcpu->arch.hw_mmu->pgt;
> +	gpa_t gpa = kvm_gpa_from_fault(vcpu->kvm, s2fd->fault_ipa);
>   	unsigned long mmu_seq;
>   	struct page *page;
> -	struct kvm *kvm = s2fd->vcpu->kvm;
> +	struct kvm *kvm = vcpu->kvm;
>   	void *memcache;
>   	kvm_pfn_t pfn;
>   	gfn_t gfn;
>   	int ret;
>   
> -	memcache = get_mmu_memcache(s2fd->vcpu);
> -	ret = topup_mmu_memcache(s2fd->vcpu, memcache);
> +	if (kvm_is_realm(vcpu->kvm)) {
> +		/* check for memory attribute mismatch */
> +		bool is_priv_gfn = kvm_mem_is_private(kvm, gpa >> PAGE_SHIFT);
> +		/*
> +		 * For Realms, the shared address is an alias of the private
> +		 * PA with the top bit set. Thus if the fault address matches
> +		 * the GPA then it is the private alias.
> +		 */
> +		bool is_priv_fault = (gpa == s2fd->fault_ipa);
> +
> +		if (is_priv_gfn != is_priv_fault) {
> +			kvm_prepare_memory_fault_exit(vcpu, gpa, PAGE_SIZE,
> +						      kvm_is_write_fault(vcpu),
> +						      false,
> +						      is_priv_fault);
> +			/*
> +			 * KVM_EXIT_MEMORY_FAULT requires an return code of
> +			 * -EFAULT, see the API documentation
> +			 */
> +			return -EFAULT;
> +		}
> +	}
> +
> +	memcache = get_mmu_memcache(vcpu);
> +	ret = topup_mmu_memcache(vcpu, memcache);
>   	if (ret)
>   		return ret;
>   
>   	if (s2fd->nested)
>   		gfn = kvm_s2_trans_output(s2fd->nested) >> PAGE_SHIFT;
>   	else
> -		gfn = s2fd->fault_ipa >> PAGE_SHIFT;
> +		gfn = gpa >> PAGE_SHIFT;
>   
> -	write_fault = kvm_is_write_fault(s2fd->vcpu);
> -	exec_fault = kvm_vcpu_trap_is_exec_fault(s2fd->vcpu);
> +	write_fault = kvm_is_write_fault(vcpu);
> +	exec_fault = kvm_vcpu_trap_is_exec_fault(vcpu);
>   
>   	VM_WARN_ON_ONCE(write_fault && exec_fault);
>   
> @@ -1634,7 +1696,7 @@ static int gmem_abort(const struct kvm_s2_fault_desc *s2fd)
>   
>   	ret = kvm_gmem_get_pfn(kvm, s2fd->memslot, gfn, &pfn, &page, NULL);
>   	if (ret) {
> -		kvm_prepare_memory_fault_exit(s2fd->vcpu, s2fd->fault_ipa, PAGE_SIZE,
> +		kvm_prepare_memory_fault_exit(vcpu, gpa, PAGE_SIZE,
>   					      write_fault, exec_fault, false);
>   		return ret;
>   	}
> @@ -1654,14 +1716,20 @@ static int gmem_abort(const struct kvm_s2_fault_desc *s2fd)
>   	kvm_fault_lock(kvm);
>   	if (mmu_invalidate_retry(kvm, mmu_seq)) {
>   		ret = -EAGAIN;
> -		goto out_unlock;
> +		goto out_release_page;
> +	}
> +
> +	if (kvm_is_realm(kvm)) {
> +		ret = realm_map_ipa(kvm, s2fd->fault_ipa, pfn,
> +				    PAGE_SIZE, KVM_PGTABLE_PROT_R | KVM_PGTABLE_PROT_W, memcache);
> +		goto out_release_page;
>   	}
>   
>   	ret = KVM_PGT_FN(kvm_pgtable_stage2_map)(pgt, s2fd->fault_ipa, PAGE_SIZE,
>   						 __pfn_to_phys(pfn), prot,
>   						 memcache, flags);
>   
> -out_unlock:
> +out_release_page:
>   	kvm_release_faultin_page(kvm, page, !!ret, prot & KVM_PGTABLE_PROT_W);
>   	kvm_fault_unlock(kvm);
>   
> @@ -1847,7 +1915,7 @@ static int kvm_s2_fault_get_vma_info(const struct kvm_s2_fault_desc *s2fd,
>   	 * mapping size to ensure we find the right PFN and lay down the
>   	 * mapping in the right place.
>   	 */
> -	s2vi->gfn = ALIGN_DOWN(s2fd->fault_ipa, s2vi->vma_pagesize) >> PAGE_SHIFT;
> +	s2vi->gfn = kvm_gpa_from_fault(kvm, ALIGN_DOWN(s2fd->fault_ipa, s2vi->vma_pagesize)) >> PAGE_SHIFT;
>   
>   	s2vi->mte_allowed = kvm_vma_mte_allowed(vma);
>   
> @@ -2056,6 +2124,9 @@ static int kvm_s2_fault_map(const struct kvm_s2_fault_desc *s2fd,
>   		prot &= ~KVM_NV_GUEST_MAP_SZ;
>   		ret = KVM_PGT_FN(kvm_pgtable_stage2_relax_perms)(pgt, gfn_to_gpa(gfn),
>   								 prot, flags);
> +	} else if (kvm_is_realm(kvm)) {
> +		ret = realm_map_ipa(kvm, s2fd->fault_ipa, pfn, mapping_size,
> +				    prot, memcache);
>   	} else {
>   		ret = KVM_PGT_FN(kvm_pgtable_stage2_map)(pgt, gfn_to_gpa(gfn), mapping_size,
>   							 __pfn_to_phys(pfn), prot,

For the case kvm_is_realm(), need we adjust 's2fd->fault_ipa' for the sake of
huge pages. In kvm_s2_fault_map(), @gfn and @pfn may have been adjusted by
transparent_hugepage_adjust() to be aligned with huge page size. If the
adjustment happened in transparent_hugepage_adjust(), we need to align
s2fd->fault_ipa down to the huge page size either.


> @@ -2214,6 +2285,13 @@ int kvm_handle_guest_sea(struct kvm_vcpu *vcpu)
>   	return 0;
>   }
>   
> +static bool shared_ipa_fault(struct kvm *kvm, phys_addr_t fault_ipa)
> +{
> +	gpa_t gpa = kvm_gpa_from_fault(kvm, fault_ipa);
> +
> +	return (gpa != fault_ipa);
> +}
> +
>   /**
>    * kvm_handle_guest_abort - handles all 2nd stage aborts
>    * @vcpu:	the VCPU pointer
> @@ -2324,8 +2402,9 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
>   		nested = &nested_trans;
>   	}
>   
> -	gfn = ipa >> PAGE_SHIFT;
> +	gfn = kvm_gpa_from_fault(vcpu->kvm, ipa) >> PAGE_SHIFT;
>   	memslot = gfn_to_memslot(vcpu->kvm, gfn);
> +
>   	hva = gfn_to_hva_memslot_prot(memslot, gfn, &writable);
>   	write_fault = kvm_is_write_fault(vcpu);
>   	if (kvm_is_error_hva(hva) || (write_fault && !writable)) {
> @@ -2368,7 +2447,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
>   		 * of the page size.
>   		 */
>   		ipa |= FAR_TO_FIPA_OFFSET(kvm_vcpu_get_hfar(vcpu));
> -		ret = io_mem_abort(vcpu, ipa);
> +		ret = io_mem_abort(vcpu, kvm_gpa_from_fault(vcpu->kvm, ipa));
>   		goto out_unlock;
>   	}
>   
> @@ -2396,7 +2475,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
>   				!write_fault &&
>   				!kvm_vcpu_trap_is_exec_fault(vcpu));
>   
> -		if (kvm_slot_has_gmem(memslot))
> +		if (kvm_slot_has_gmem(memslot) && !shared_ipa_fault(vcpu->kvm, fault_ipa))
>   			ret = gmem_abort(&s2fd);
>   		else
>   			ret = user_mem_abort(&s2fd);
> @@ -2433,6 +2512,10 @@ bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
>   	if (!kvm->arch.mmu.pgt || kvm_vm_is_protected(kvm))
>   		return false;
>   
> +	/* We don't support aging for Realms */
> +	if (kvm_is_realm(kvm))
> +		return true;
> +
>   	return KVM_PGT_FN(kvm_pgtable_stage2_test_clear_young)(kvm->arch.mmu.pgt,
>   						   range->start << PAGE_SHIFT,
>   						   size, true);
> @@ -2449,6 +2532,10 @@ bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
>   	if (!kvm->arch.mmu.pgt || kvm_vm_is_protected(kvm))
>   		return false;
>   
> +	/* We don't support aging for Realms */
> +	if (kvm_is_realm(kvm))
> +		return true;
> +
>   	return KVM_PGT_FN(kvm_pgtable_stage2_test_clear_young)(kvm->arch.mmu.pgt,
>   						   range->start << PAGE_SHIFT,
>   						   size, false);
> @@ -2628,10 +2715,11 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
>   		return -EFAULT;
>   
>   	/*
> -	 * Only support guest_memfd backed memslots with mappable memory, since
> -	 * there aren't any CoCo VMs that support only private memory on arm64.
> +	 * Only support guest_memfd backed memslots with mappable memory,
> +	 * unless the guest is a CCA realm guest.
>   	 */
> -	if (kvm_slot_has_gmem(new) && !kvm_memslot_is_gmem_only(new))
> +	if (kvm_slot_has_gmem(new) && !kvm_memslot_is_gmem_only(new) &&
> +	    !kvm_is_realm(kvm))
>   		return -EINVAL;
>   
>   	hva = new->userspace_addr;
> diff --git a/arch/arm64/kvm/rmi.c b/arch/arm64/kvm/rmi.c
> index cae29fd3353c..761b38a4071c 100644
> --- a/arch/arm64/kvm/rmi.c
> +++ b/arch/arm64/kvm/rmi.c
> @@ -597,6 +597,179 @@ static int realm_data_map_init(struct kvm *kvm, unsigned long ipa,
>   	return ret;
>   }
>   
> +static unsigned long addr_range_desc(unsigned long phys, unsigned long size)
> +{
> +	unsigned long out = 0;
> +
> +	switch (size) {
> +	case P4D_SIZE:
> +		out = 3 | (1 << 2);
> +		break;
> +	case PUD_SIZE:
> +		out = 2 | (1 << 2);
> +		break;
> +	case PMD_SIZE:
> +		out = 1 | (1 << 2);
> +		break;
> +	case PAGE_SIZE:
> +		out = 0 | (1 << 2);
> +		break;
> +	default:
> +		/*
> +		 * Only support mapping at the page level granulatity when
> +		 * it's an unusual length. This should get us back onto a larger
> +		 * block size for the subsequent mappings.
> +		 */
> +		out = 0 | ((MIN(size >> PAGE_SHIFT, PTRS_PER_PTE - 1)) << 2);
> +		break;
> +	}
> +
> +	WARN_ON(phys & ~PAGE_MASK);
> +
> +	out |= phys & PAGE_MASK;
> +
> +	return out;
> +}
> +
> +int realm_map_protected(struct kvm *kvm,
> +			unsigned long ipa,
> +			kvm_pfn_t pfn,
> +			unsigned long map_size,
> +			struct kvm_mmu_memory_cache *memcache)
> +{
> +	struct realm *realm = &kvm->arch.realm;
> +	phys_addr_t phys = __pfn_to_phys(pfn);
> +	phys_addr_t base_phys = phys;
> +	phys_addr_t rd = virt_to_phys(realm->rd);
> +	unsigned long base_ipa = ipa;
> +	unsigned long ipa_top = ipa + map_size;
> +	int ret = 0;
> +
> +	if (WARN_ON(!IS_ALIGNED(map_size, PAGE_SIZE) ||
> +		    !IS_ALIGNED(ipa, map_size)))
> +		return -EINVAL;
> +
> +	if (rmi_delegate_range(phys, map_size)) {
> +		/*
> +		 * It's likely we raced with another VCPU on the same
> +		 * fault. Assume the other VCPU has handled the fault
> +		 * and return to the guest.
> +		 */
> +		return 0;
> +	}
> +
> +	while (ipa < ipa_top) {
> +		unsigned long flags = RMI_ADDR_TYPE_SINGLE;
> +		unsigned long range_desc = addr_range_desc(phys, ipa_top - ipa);
> +		unsigned long out_top;
> +
> +		ret = rmi_rtt_data_map(rd, ipa, ipa_top, flags, range_desc,
> +				       &out_top);
> +
> +		if (RMI_RETURN_STATUS(ret) == RMI_ERROR_RTT) {
> +			/* Create missing RTTs and retry */
> +			int level = RMI_RETURN_INDEX(ret);
> +
> +			WARN_ON(level == KVM_PGTABLE_LAST_LEVEL);
> +			ret = realm_create_rtt_levels(realm, ipa, level,
> +						      KVM_PGTABLE_LAST_LEVEL,
> +						      memcache);
> +			if (ret)
> +				goto err_undelegate;
> +
> +			ret = rmi_rtt_data_map(rd, ipa, ipa_top, flags,
> +					       range_desc, &out_top);
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
> +	}
> +	return -ENXIO;
> +}
> +
> +int realm_map_non_secure(struct realm *realm,
> +			 unsigned long ipa,
> +			 kvm_pfn_t pfn,
> +			 unsigned long size,
> +			 enum kvm_pgtable_prot prot,
> +			 struct kvm_mmu_memory_cache *memcache)
> +{
> +	unsigned long attr, flags = 0;
> +	phys_addr_t rd = virt_to_phys(realm->rd);
> +	phys_addr_t phys = __pfn_to_phys(pfn);
> +	unsigned long ipa_top = ipa + size;
> +	int ret;
> +
> +	if (WARN_ON(!IS_ALIGNED(size, PAGE_SIZE) ||
> +		    !IS_ALIGNED(ipa, size)))
> +		return -EINVAL;
> +
> +	switch (prot & (KVM_PGTABLE_PROT_DEVICE | KVM_PGTABLE_PROT_NORMAL_NC)) {
> +	case KVM_PGTABLE_PROT_DEVICE | KVM_PGTABLE_PROT_NORMAL_NC:
> +		return -EINVAL;
> +	case KVM_PGTABLE_PROT_DEVICE:
> +		attr = MT_S2_FWB_DEVICE_nGnRE;
> +		break;
> +	case KVM_PGTABLE_PROT_NORMAL_NC:
> +		attr = MT_S2_FWB_NORMAL_NC;
> +		break;
> +	default:
> +		attr = MT_S2_FWB_NORMAL;
> +	}
> +
> +	flags |= FIELD_PREP(RMI_RTT_UNPROT_MAP_FLAGS_MEMATTR, attr);
> +
> +	if (prot & KVM_PGTABLE_PROT_R)
> +		flags |= FIELD_PREP(RMI_RTT_UNPROT_MAP_FLAGS_S2AP, RMI_S2AP_DIRECT_READ);
> +	if (prot & KVM_PGTABLE_PROT_W)
> +		flags |= FIELD_PREP(RMI_RTT_UNPROT_MAP_FLAGS_S2AP, RMI_S2AP_DIRECT_WRITE);
> +
> +	flags |= RMI_ADDR_TYPE_SINGLE;
> +
> +	while (ipa < ipa_top) {
> +		unsigned long range_desc = addr_range_desc(phys, ipa_top - ipa);
> +		unsigned long out_top;
> +
> +		ret = rmi_rtt_unprot_map(rd, ipa, ipa_top, flags, range_desc,
> +					 &out_top);
> +
> +		if (RMI_RETURN_STATUS(ret) == RMI_ERROR_RTT) {
> +			/* Create missing RTTs and retry */
> +			int level = RMI_RETURN_INDEX(ret);
> +
> +			WARN_ON(level == KVM_PGTABLE_LAST_LEVEL);
> +			ret = realm_create_rtt_levels(realm, ipa, level,
> +						      KVM_PGTABLE_LAST_LEVEL,
> +						      memcache);
> +			if (ret)
> +				return ret;
> +
> +			ret = rmi_rtt_unprot_map(rd, ipa, ipa_top, flags,
> +						 range_desc, &out_top);
> +		}
> +
> +		if (WARN_ON(ret))
> +			return ret;
> +
> +		phys += out_top - ipa;
> +		ipa = out_top;
> +	}
> +
> +	return 0;
> +}
> +
>   static int populate_region_cb(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
>   			      struct page *src_page, void *opaque)
>   {

Thanks,
Gavin

