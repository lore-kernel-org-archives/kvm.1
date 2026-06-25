Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D5B341660
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782395637; cv=none; b=RvgsoIrallqjaZt/4zJ1vQFWtHEGRX+YzVnGC5BfQ+iLsOAb8T2cPanPPuiirby5PRpPvjrrqK4saRnQBFyzv9vNH8/t2UzrJrTo7NsEmxslptpbTKDLb/lyCJPiyXgB6YAO1o3AZJdNpSejHQBFjl1WTanQMKOa/y2c55G+CNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782395637; c=relaxed/simple;
	bh=TEtUb2t7/GatcjTLqxJxCqQNRI+9vBLfCeDeqCkz0R8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AsVVqqm51UDjfE75JiFUO57k2RIs+PwdX5G9ck9sNfz5H0mgBBHLCO1oyTVM0D0dkTYh/3L28jCs+d2vLju67gcE1qDpq/zgiq2rfbDAZMdKVL58ec+JVTkwW4ZJtAnzk65QknFJZPZSO6YqZoKlpRL2MNwcW3B79b3ow3Q0A4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q3VdSQdX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PdBUvoxo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q3VdSQdX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PdBUvoxo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782395634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F2JG4NFwUS2cEMv5rtucKqmVkk7/NshCHssLA8DLWUk=;
	b=Q3VdSQdXUXHg+NwVTXx1uXPwoQzlkZXpvrV6CB9gPyxHCgTrr891+p5I7c35PpF9J2lIYt
	V7JtdeKybqMZrj4nCh4NLV+PsxLo+A0GmW9Al+yETrltGruNiQH7aOIiwMwemhVRl6tWTP
	8u5A5oYudNQPws0k0b16HOne/uUFF6k=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-AKaqqHkMNLmIp5Ga4O-BVQ-1; Thu, 25 Jun 2026 09:53:52 -0400
X-MC-Unique: AKaqqHkMNLmIp5Ga4O-BVQ-1
X-Mimecast-MFC-AGG-ID: AKaqqHkMNLmIp5Ga4O-BVQ_1782395631
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5aa4bb157a9so1735198e87.2
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 06:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782395631; x=1783000431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F2JG4NFwUS2cEMv5rtucKqmVkk7/NshCHssLA8DLWUk=;
        b=PdBUvoxonHtbIAVvkTj7uoQMrNUELQOBAdpcGkBtD4StoBdMzaM2JbmC6uefxPe11G
         rrS0pN/Ko4sZNLsKLIzyV3NcTTLAhVothuYyaPTt8mdbtyz9UcwQ26H9QPknKQg763Y+
         BV/M0NEiQ4IP9ZRoAr76YMnNUf3mjDoHyOlwya3qlGf6ryLfAO18M1URrNI3r4Adir9Q
         xLKeCQJwLP6XtF3NcKNRJaeswwMWcNIUk5RcFqifoZI+453UP1wrWpg/AFooG2SvkrgW
         DmNU+3pm4enyHoEr41E/xnNvZ7/AnlfdMCpTmEFFEkhlIjeSY47htJ/FDzcgSvs0T6as
         NPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782395631; x=1783000431;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F2JG4NFwUS2cEMv5rtucKqmVkk7/NshCHssLA8DLWUk=;
        b=gG1Vnq/2/mcpyeqMN53P8NfNhB85NZYEBYzPK76JXEzCr0fEUJUYMavqKt3q+kG8gT
         E17BI5x5ZvapUjlVx4RYKPgzqekFahS5XwlFR9mlG16BC8HOD4YVUAv9f0dXPw4UgLMF
         hYI9xR3VqcXA7hxw8MYLzzoJUO0+zIdhbQ27l8ulTDU/wHf5vudaePRleSgs8cPY0lmO
         G694+DFInJRzA7UfQCiUaJ6RPDVuDT+GJIO/e3sZQ86KpFUDW3uZ+eGbnUkbBYvDcMN5
         rj8M/DjKvWO4gDksidHt3yXpB93sB6F3Xvs8Z4mbH7Ph3jqQHhOpjAtYXvMQwFS/oCON
         mAeg==
X-Forwarded-Encrypted: i=1; AHgh+RqzfGa4ac1FKJ68FqlCCliADToN6DcuYUFNB+5fs+nPViCZRe/5+8lvgzFSF35hz5aKRDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIXEIzlQOjYQOZWpsfA8vgu5FxtAEu9ebU6KDRgY4Eg+e8QqR3
	g2dSD+JFVj7vEpAB9JphoBTp0JqtWcPh+NdOuErythIBtdZtYfYUUtWx286KCiD2jVBPGlrvZjj
	9VKklO4lXKmx4kucwtL2/Ovr8KuLUCGerwDizAKpBXVu5e2SIhan5MA==
X-Gm-Gg: AfdE7cnmlYchJMPEP2OmoGGvsUhLgmXfqidFaQE8jI+uTknAspclGSEa0lMgjszH+Zv
	N/Zy0JVW5JEGI6MHdUD0RvNux0+0zyaiWKGTa4bVW4zs9nXkYgcwrPd7V7Irkq38fldNqJHJtlC
	soQmb5XcpJU8shJvt6fmukebeC089U4vVLY7Knv0vDmsZ0F/8vo+KzIxXG7Eup+HD35E13/rY3n
	PM1Nd4OXvlpGoWqF9gjUtmuXvWd82CihLElJONMzCLB4TXVrwjr4gScchSA8YlM06UR9oxMjr7K
	8Y3wXPc33mzNjNBOhDIzN1RBm5e8ODOZA+K+uShOrZ0nx3SHZbPxrBb0oWCvAdUB4HAoCwAERG4
	Lu0vUlSVxpFe/plheIyiXB4GvNesMO27y1fO8N7iVQ6eYxoDMa3FcbQ==
X-Received: by 2002:a05:6512:6805:b0:5a8:86a8:2e09 with SMTP id 2adb3069b0e04-5aea1f40aecmr867686e87.7.1782395630933;
        Thu, 25 Jun 2026 06:53:50 -0700 (PDT)
X-Received: by 2002:a05:6512:6805:b0:5a8:86a8:2e09 with SMTP id 2adb3069b0e04-5aea1f40aecmr867655e87.7.1782395630346;
        Thu, 25 Jun 2026 06:53:50 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad69550febsm2641151e87.25.2026.06.25.06.53.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 06:53:49 -0700 (PDT)
Message-ID: <1e39094f-7fa3-4ef1-be54-53d7a8643506@redhat.com>
Date: Thu, 25 Jun 2026 23:53:32 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 29/44] arm64: RMI: Runtime faulting of memory
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev, Catalin Marinas <catalin.marinas@arm.com>,
 Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
 James Morse <james.morse@arm.com>, Oliver Upton <oliver.upton@linux.dev>,
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
 <3359f788-07fa-41a1-9ac7-45c58577c1fa@redhat.com>
 <aiJ6u83O0nVUtPyv@lpieralisi>
 <ecef952b-e8c6-4102-933b-c99c46f14431@redhat.com>
 <aiLes2ecZSr17UwZ@lpieralisi>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <aiLes2ecZSr17UwZ@lpieralisi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/6/26 12:35 AM, Lorenzo Pieralisi wrote:
> On Fri, Jun 05, 2026 at 06:11:11PM +1000, Gavin Shan wrote:
>> On 6/5/26 5:28 PM, Lorenzo Pieralisi wrote:
>>> On Fri, Jun 05, 2026 at 04:23:15PM +1000, Gavin Shan wrote:
>>>
>>> [...]
>>>
>>>>> +static int realm_map_ipa(struct kvm *kvm, phys_addr_t ipa,
>>>>> +			 kvm_pfn_t pfn, unsigned long map_size,
>>>>> +			 enum kvm_pgtable_prot prot,
>>>>> +			 struct kvm_mmu_memory_cache *memcache)
>>>>> +{
>>>>> +	struct realm *realm = &kvm->arch.realm;
>>>>> +
>>>>> +	/*
>>>>> +	 * Write permission is required for now even though it's possible to
>>>>> +	 * map unprotected pages (granules) as read-only. It's impossible to
>>>>> +	 * map protected pages (granules) as read-only.
>>>>> +	 */
>>>>> +	if (WARN_ON(!(prot & KVM_PGTABLE_PROT_W)))
>>>>> +		return -EFAULT;
>>>>> +
>>>>
>>>> I'm a bit concerned with this. We don't have KVM_PGTABLE_PROT_W set in @prot
>>>> if the stage2 fault is raised due to memory read. With -EFAULT returned to VMM
>>>> (e.g. QEMU), the vCPU continuous execution is stopped and system won't be
>>>> working any more.
>>>>
>>>>> +	ipa = ALIGN_DOWN(ipa, PAGE_SIZE);
>>>>> +	if (!kvm_realm_is_private_address(realm, ipa))
>>>>> +		return realm_map_non_secure(realm, ipa, pfn, map_size, prot,
>>>>> +					    memcache);
>>>>> +
>>>>> +	return realm_map_protected(kvm, ipa, pfn, map_size, memcache);
>>>>> +}
>>>>> +
>>>>>     static bool kvm_vma_is_cacheable(struct vm_area_struct *vma)
>>>>>     {
>>>>>     	switch (FIELD_GET(PTE_ATTRINDX_MASK, pgprot_val(vma->vm_page_prot))) {
>>>>> @@ -1604,27 +1641,52 @@ static int gmem_abort(const struct kvm_s2_fault_desc *s2fd)
>>>>>     	bool write_fault, exec_fault;
>>>>>     	enum kvm_pgtable_walk_flags flags = KVM_PGTABLE_WALK_SHARED;
>>>>>     	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_R;
>>>>> -	struct kvm_pgtable *pgt = s2fd->vcpu->arch.hw_mmu->pgt;
>>>>> +	struct kvm_vcpu *vcpu = s2fd->vcpu;
>>>>> +	struct kvm_pgtable *pgt = vcpu->arch.hw_mmu->pgt;
>>>>> +	gpa_t gpa = kvm_gpa_from_fault(vcpu->kvm, s2fd->fault_ipa);
>>>>>     	unsigned long mmu_seq;
>>>>>     	struct page *page;
>>>>> -	struct kvm *kvm = s2fd->vcpu->kvm;
>>>>> +	struct kvm *kvm = vcpu->kvm;
>>>>>     	void *memcache;
>>>>>     	kvm_pfn_t pfn;
>>>>>     	gfn_t gfn;
>>>>>     	int ret;
>>>>> -	memcache = get_mmu_memcache(s2fd->vcpu);
>>>>> -	ret = topup_mmu_memcache(s2fd->vcpu, memcache);
>>>>> +	if (kvm_is_realm(vcpu->kvm)) {
>>>>> +		/* check for memory attribute mismatch */
>>>>> +		bool is_priv_gfn = kvm_mem_is_private(kvm, gpa >> PAGE_SHIFT);
>>>>> +		/*
>>>>> +		 * For Realms, the shared address is an alias of the private
>>>>> +		 * PA with the top bit set. Thus if the fault address matches
>>>>> +		 * the GPA then it is the private alias.
>>>>> +		 */
>>>>> +		bool is_priv_fault = (gpa == s2fd->fault_ipa);
>>>>> +
>>>>> +		if (is_priv_gfn != is_priv_fault) {
>>>>> +			kvm_prepare_memory_fault_exit(vcpu, gpa, PAGE_SIZE,
>>>>> +						      kvm_is_write_fault(vcpu),
>>>>> +						      false,
>>>>> +						      is_priv_fault);
>>>>> +			/*
>>>>> +			 * KVM_EXIT_MEMORY_FAULT requires an return code of
>>>>> +			 * -EFAULT, see the API documentation
>>>>> +			 */
>>>>> +			return -EFAULT;
>>>>> +		}
>>>>> +	}
>>>>> +
>>>>> +	memcache = get_mmu_memcache(vcpu);
>>>>> +	ret = topup_mmu_memcache(vcpu, memcache);
>>>>>     	if (ret)
>>>>>     		return ret;
>>>>>     	if (s2fd->nested)
>>>>>     		gfn = kvm_s2_trans_output(s2fd->nested) >> PAGE_SHIFT;
>>>>>     	else
>>>>> -		gfn = s2fd->fault_ipa >> PAGE_SHIFT;
>>>>> +		gfn = gpa >> PAGE_SHIFT;
>>>>> -	write_fault = kvm_is_write_fault(s2fd->vcpu);
>>>>> -	exec_fault = kvm_vcpu_trap_is_exec_fault(s2fd->vcpu);
>>>>> +	write_fault = kvm_is_write_fault(vcpu);
>>>>> +	exec_fault = kvm_vcpu_trap_is_exec_fault(vcpu);
>>>>>     	VM_WARN_ON_ONCE(write_fault && exec_fault);
>>>>> @@ -1634,7 +1696,7 @@ static int gmem_abort(const struct kvm_s2_fault_desc *s2fd)
>>>>>     	ret = kvm_gmem_get_pfn(kvm, s2fd->memslot, gfn, &pfn, &page, NULL);
>>>>>     	if (ret) {
>>>>> -		kvm_prepare_memory_fault_exit(s2fd->vcpu, s2fd->fault_ipa, PAGE_SIZE,
>>>>> +		kvm_prepare_memory_fault_exit(vcpu, gpa, PAGE_SIZE,
>>>>>     					      write_fault, exec_fault, false);
>>>>>     		return ret;
>>>>>     	}
>>>>> @@ -1654,14 +1716,20 @@ static int gmem_abort(const struct kvm_s2_fault_desc *s2fd)
>>>>>     	kvm_fault_lock(kvm);
>>>>>     	if (mmu_invalidate_retry(kvm, mmu_seq)) {
>>>>>     		ret = -EAGAIN;
>>>>> -		goto out_unlock;
>>>>> +		goto out_release_page;
>>>>> +	}
>>>>> +
>>>>> +	if (kvm_is_realm(kvm)) {
>>>>> +		ret = realm_map_ipa(kvm, s2fd->fault_ipa, pfn,
>>>>> +				    PAGE_SIZE, KVM_PGTABLE_PROT_R | KVM_PGTABLE_PROT_W, memcache);
>>>>> +		goto out_release_page;
>>>>>     	}
>>>>>     	ret = KVM_PGT_FN(kvm_pgtable_stage2_map)(pgt, s2fd->fault_ipa, PAGE_SIZE,
>>>>>     						 __pfn_to_phys(pfn), prot,
>>>>>     						 memcache, flags);
>>>>> -out_unlock:
>>>>> +out_release_page:
>>>>>     	kvm_release_faultin_page(kvm, page, !!ret, prot & KVM_PGTABLE_PROT_W);
>>>>>     	kvm_fault_unlock(kvm);
>>>>> @@ -1847,7 +1915,7 @@ static int kvm_s2_fault_get_vma_info(const struct kvm_s2_fault_desc *s2fd,
>>>>>     	 * mapping size to ensure we find the right PFN and lay down the
>>>>>     	 * mapping in the right place.
>>>>>     	 */
>>>>> -	s2vi->gfn = ALIGN_DOWN(s2fd->fault_ipa, s2vi->vma_pagesize) >> PAGE_SHIFT;
>>>>> +	s2vi->gfn = kvm_gpa_from_fault(kvm, ALIGN_DOWN(s2fd->fault_ipa, s2vi->vma_pagesize)) >> PAGE_SHIFT;
>>>>>     	s2vi->mte_allowed = kvm_vma_mte_allowed(vma);
>>>>> @@ -2056,6 +2124,9 @@ static int kvm_s2_fault_map(const struct kvm_s2_fault_desc *s2fd,
>>>>>     		prot &= ~KVM_NV_GUEST_MAP_SZ;
>>>>>     		ret = KVM_PGT_FN(kvm_pgtable_stage2_relax_perms)(pgt, gfn_to_gpa(gfn),
>>>>>     								 prot, flags);
>>>>> +	} else if (kvm_is_realm(kvm)) {
>>>>> +		ret = realm_map_ipa(kvm, s2fd->fault_ipa, pfn, mapping_size,
>>>>> +				    prot, memcache);
>>>>>     	} else {
>>>>>     		ret = KVM_PGT_FN(kvm_pgtable_stage2_map)(pgt, gfn_to_gpa(gfn), mapping_size,
>>>>>     							 __pfn_to_phys(pfn), prot,
>>>>
>>>> For the case kvm_is_realm(), need we adjust 's2fd->fault_ipa' for the sake of
>>>> huge pages. In kvm_s2_fault_map(), @gfn and @pfn may have been adjusted by
>>>> transparent_hugepage_adjust() to be aligned with huge page size. If the
>>>> adjustment happened in transparent_hugepage_adjust(), we need to align
>>>> s2fd->fault_ipa down to the huge page size either.
>>>
>>> All of the above + some RMM changes are needed to get QEmu VMM going
>>> with anon pages guest memory backing - currently testing various
>>> configurations in the background.
>>>
>>
>> I tried to rebase Jean's latest QEMU series [1] to upstream QEMU, and found
>> that memory slots backed by THP are broken. With THP disabled on the host and
>> other fixes (mentioned in my prevous replies) applied on the top of this (v14)
>> series, I'm able to boot a realm guest with rebased QEMU series [2], plus more
>> fxies on the top.
>>
>> [1] https://git.codelinaro.org/linaro/dcap/qemu.git  (branch: cca/latest)
>> [2] https://git.qemu.org/git/qemu.git                (branch: cca/gavin)
>>
>> Lorenzo, You may be saying there is someone making QEMU to support ARM/CCA?
> 
> Mathieu and I are working on that yes and with Steven/Suzuki to fix the THP
> issues you pointed out above.
> 
>> If so, I'm not sure if there is a QEMU repository for me to try?
> 
> We should be able to submit patches by end of June - we shall let you know
> whether we can make something available earlier.
> 

Not sure if there are other known issues in this series. It seems the stage2
page fault handling on the shared space isn't working well. In my test, the
vring (struct vring_desc) of virtio-net-pci is updated by the guest, and the
data isn't seen by QEMU, I'm suspecting if the host-page-frame-number is properly
resolved in the s2 page fault handler for shared (unprotected) space.

- I rebased Jean's latest qemu branch to the upstream qemu;

- On the host, which is emulated by qemu/tcg, the THP (transparent huge page) is
   disabled.

- On the guest, I can see the virtio vring (struct vring_desc) is updated. The
   S1 page-table entry looks correct because the corresponding physical address
   0x10046880000 is a sane shared (unprotected) space address.

   [   52.094143] software IO TLB: Memory encryption is active and system is using DMA bounce buffers
   [   52.289746] virtqueue_add_desc_split: desc[0]@0xffff000006880000, [00000100b983f000  00000640  0002  0001]
   [   52.432150] PTE 0x00e8010046880707 at address 0xffff000006880000

- On the host, the s2 page-table-entry is unmapped due to attribute transition (private -> shared).
   A subsequent S2 page fault is raised against the adress and the s2 page-table-entry is built.

   [  109.259077] ====> realm_unmap_shared_range: tracked_unprot_addr=0x10046880000
   [  109.260249] realm_unmap_shared_range: unmapped shared range at 0x10046880000
   [  109.317786] realm_unmap_shared_range: unmapped shared range at 0x10046880000
   [  109.629939] ====> kvm_handle_guest_abort: fault_ipa=0x10046880000, esr=0x92000007
   [  109.630245] realm_map_non_secure: ipa=0x10046880000, pfn=0xb8b59, size=0x1000, prot=0xf
   [  109.630331] realm_map_non_secure: ipa=0x10046880000, ipa_top=0x10046881000, flags=0x1e0001, range_desc=0xb8b59004

- On QEMU, the updated vring (struct vring_desc) at GPA 0x46880000 isn't seen. All the
   data in that adress are zeros.

   ====> virtqueue_split_pop: vdev=<virtio-net>, sz=0x38, queue_index=0x0, vq->vring.num=0x100
   virtqueue_split_pop: last_avail_idx=0x0, head=0x0
   address_space_read_cached_slow: cache@0xffff1c036440, addr=0x0, buf=0xffffeee34880, len=0x10
   address_space_read_cached_slow: cache: ptr=0x0, xlat=0x10046880000, len=0x1000, mrs=<realm-dma-region>, is_write=no
   address_space_read_cached_slow: translated to mr=<mach-virt.ram>, mr_addr=0x6880000, l=0x10
   flatview_read_continue_step: mr=<mach-virt.ram>, host=0xffff23e00000, mr_addr=0x6880000, ram_ptr=0xffff2a680000
   virtqueue_split_pop: desc: 0000000000000000 - 00000000 - 00000000 - 00000000
   qemu-system-aarch64: virtio: zero sized buffers are not allowed


Thanks,
Gavin

