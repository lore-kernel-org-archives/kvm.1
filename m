Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795473575;
	b=q03hFPciQEuTmrdwr1rE+7Rxs5Q+eg80JfCMvYcSwZ6Y/3yiKuX29C9qrciSmGAnK6+y
	 k8SwX0l7xQIP6MbDZsyMuLkbMQ+XKb8EQNHNR7UrU8wfFALar1n8x5i89AoFoz30ffOWv
	 1c2xDl56h80TUZS76d4E9FQg9iCEXwxOwzDuLdzOfISDUGaWB3L3rGAf4qgh/cO/60z6N
	 PlNwuo0VP+t7bzwKvRjTeaQyvR81o2wLK6VpA7ses1MCcHH+7RPYCefGsTxrZ27DXix/9
	 GpvQ0XUvLNNDwkhKRLlEQMliZBKCDFUhPziEV6wRU6La5W30b8emfMkeLyBFRiVZjiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795473575;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=69vJ4VVySaqZOEO8Dfc8Vx0YCV5ZJPlMxKK46hGcSm0=;
	b=riPgfGykQgldUGQV4lN1fChJXqzC7meF7a50TwliEfHmK+W0l8t0UaYxN9K+CriW3nsq
	 O8yY+SW/TrjFgPvUoqYTvJEeOAG8Q34G3fc0PBhwaHXFzg4UeRz/c7PD9wIyhX2oid9fp
	 Mf81lzlyxumWO8hienAuxfLHcQhPjMhjtb+qr9fd2ESESGrACIzKStgPXV+YwIoNKsStp
	 P3IrhKLiliF0Pe/UBRm22QojV4YF5TlRrNtlnmuXuKrHNE/6rRnFB7Cjf6MDISS+ilbzL
	 QI1dRXukFaFFZ/iwPxEQsID7fsAeIjolxtpbjinGQNhlyeambv9ZmHYZPIkc1R/5YwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=n8kwKjPY;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE809606A326
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 22:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE809606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=n8kwKjPY
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BC96143D;
	Mon, 23 Nov 2026 14:39:30 -0800 (PST)
Received: from [10.57.72.180] (unknown [10.57.72.180])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 048CB3F632;
	Mon, 23 Nov 2026 14:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795473573; bh=1VpWRwHFymB8MG9HTzIuEjUcbxSYD0gNuCmb6DasP8M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=n8kwKjPYt4EosD7u/3L/3dY+QCFU4aQwFO/bWWePG+zCf3Nq6Wi9fQGz2kkZncbfM
	 pu2vuxQY1aLLOHVYYQ7IpNYDAiZkK/FfDZ0dOaH9Z+m7j+XUCqs9HVjlV+aByW/T61
	 Ymt7MYeV6TUvw5UWg3lknDyRLI38RQeGTnrcLYE0=
Message-ID: <286fc7a1-bbd1-459c-b3cb-fdf96866417b@arm.com>
Date: Mon, 23 Nov 2026 22:39:30 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/11] KVM: arm64: CCA: Add Realm RTT mapping and
 invalidation helpers
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev, Steven Price <steven.price@arm.com>,
 kvm@vger.kernel.org, kvmarm@lists.linux.dev
Cc: Oliver Upton <oupton@kernel.org>, Marc Zyngier <maz@kernel.org>
References: <20261123104233.95710-1-steven.price@arm.com>
 <20261123104233.95710-8-steven.price@arm.com>
 <sashiko-outbox-229102@kernel.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <sashiko-outbox-229102@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/11/2026 11:12, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issues to consider:
> - [Medium] KVM: arm64: cca: direct-reclaim allocation in
>    realm_unmap_cache_topup()
> - [Medium] KVM: arm64: cca: stale err_level used after
>    realm_unmap_cache_topup() failure
> - [Low] KVM: arm64: cca: possible RTT creation for unmapped entry in
>    realm_unmap_*()
> --
> 
> commit 4c7e030072ac67c12f0f2603fad3d39821c47426
> Author: Steven Price <steven.price@arm.com>
> 
> KVM: arm64: CCA: Add Realm RTT mapping and invalidation helpers
> 
> This commit adds RMI Realm Translation Table creation, folding, and stage-2
> unmapping helpers for CCA Realms, including filtered range unmapping for
> shared and private memory.
> 
>> diff --git a/arch/arm64/kvm/rmi.c b/arch/arm64/kvm/rmi.c
>> index 435174ac3d87f..b34f5320b50b6 100644
>> --- a/arch/arm64/kvm/rmi.c
>> +++ b/arch/arm64/kvm/rmi.c
> 
> [ ... ]
> 
>> @@ -172,6 +391,208 @@ void kvm_realm_unmap_stage2_all(struct kvm *kvm)
>>   	realm->stage2_unmapped = true;
>>   }
>>   
>> +static bool realm_unmap_cache_topup(struct kvm *kvm,
>> +				    struct kvm_mmu_memory_cache *mc, int needed)
>> +{
>> +	int ret;
>> +
>> +	if (!mc || kvm_mmu_memory_cache_nr_free_objects(mc) >= needed)
>> +		return false;
>> +
>> +	lockdep_assert_held_write(&kvm->mmu_lock);
>> +	write_unlock(&kvm->mmu_lock);
>> +	ret = __kvm_mmu_topup_memory_cache(mc, KVM_PGTABLE_LAST_LEVEL, needed);
>> +	write_lock(&kvm->mmu_lock);
>> +
>> +	return !ret;
>> +}
> 
> [Severity: Medium]
> When __kvm_mmu_topup_memory_cache() fails, does returning false cause
> realm_unmap_shared_range() and realm_unmap_private_range() to pass a stale
> err_level to realm_create_rtt_levels()?
> 
> Because kvm->mmu_lock was dropped and re-acquired, another thread can fold
> the RTT at err_level before the lock is retaken.  The callers only retry
> from addr when realm_unmap_cache_topup() returns true; on failure they fall
> through to realm_create_rtt_levels(realm, addr, err_level, level, mc).
> alloc_rtt() can still succeed from a partially topped-up cache or via
> alloc_delegated_granule()'s GFP_ATOMIC fallback (which sets __GFP_HIGH and
> force-charges memcg), causing realm_rtt_create() at err_level + 1 to fail
> with RMI_ERROR_RTT at an ancestor level < err_level.  That triggers the
> WARN() in realm_create_rtt_levels() and returns -ENXIO, hitting
> WARN_ON(ret != -ENOMEM) in realm_unmap_shared_range() or KVM_BUG_ON(1, kvm)
> in realm_unmap_private_range().
> 
>> +static void realm_unmap_shared_range(struct kvm *kvm,
>> +				     unsigned long start,
>> +				     unsigned long end,
>> +				     bool may_block,
>> +				     struct kvm_mmu_memory_cache *mc)
>> +{
>> +	struct realm *realm = &kvm->arch.realm;
>> +	unsigned long rd = realm->rd_phys;
>> +	unsigned long next_addr, addr;
>> +	unsigned long shared_bit = BIT(realm->ia_bits - 1);
>> +
>> +	if (start >= end)
>> +		return;
>> +
>> +	/*
>> +	 * Callers may pass either an IPA range or its shared alias. Add the
>> +	 * shared bit only for the former. Use addition so an exclusive end at
>> +	 * shared_bit advances to the end of the IPA space.
>> +	 */
>> +	if (start < shared_bit) {
>> +		start += shared_bit;
>> +		end += shared_bit;
>> +	}
>> +
>> +	for (addr = start; addr < end; addr = next_addr) {
>> +		long ret;
>> +
>> +		ret = rmi_rtt_unprot_unmap(rd, addr, end, RMI_ADDR_TYPE_NONE,
>> +					   0, &next_addr, NULL, NULL);
>> +		if (WARN_ON(ret < 0))
>> +			return;
>> +
>> +		switch (RMI_RESULT_STATUS(ret)) {
>> +		case RMI_SUCCESS:
>> +			break;
>> +		case RMI_ERROR_RTT: {
>> +			int err_level = RMI_RESULT_DATA_LEVEL(ret);
>> +			int level = find_map_level(realm, addr, end);
>> +
>> +			if (WARN_ON(err_level < realm->start_level ||
>> +				    err_level > KVM_PGTABLE_LAST_LEVEL))
>> +				return;
>> +
>> +			if (err_level >= level) {
>> +				/* Nothing present, so skip */
>> +				next_addr = ALIGN(addr + 1,
>> +						  kvm_granule_size(err_level));
>> +				break;
>> +			}
> 
> [Severity: Low]
> This question rests on an RMM architectural detail that could not be
> confirmed from the kernel source: can SMC_RMI_RTT_UNPROT_UNMAP or
> SMC_RMI_RTT_DATA_UNMAP return RMI_ERROR_RTT with err_level < level when the
> RTT walk stops at an unassigned ancestor entry (where neither a child RTT
> nor a block mapping is present at err_level), rather than advancing
> next_addr and returning RMI_SUCCESS?
> 
> If so, when unmapping a sub-block range (such as a single page, where
> find_map_level() returns KVM_PGTABLE_LAST_LEVEL) across an unmapped ancestor
> entry, both realm_unmap_shared_range() and realm_unmap_private_range() only
> skip when err_level >= level.  For err_level < level, they treat the entry
> as a block mapping to split, allocating and delegating intermediate RTTs via
> realm_create_rtt_levels() only to fold them back at the end of the function,
> and if that allocation fails in realm_unmap_private_range() (for example
> under GFP_ATOMIC when may_block is false), it hits KVM_BUG_ON(1, kvm) even
> though nothing was mapped.

Indeed, this was observed in my testing and I have raised this with the 
RMM team to get this fixed. RMM must return RMI_SUCCESS if the entry
at err_level is "UNASSIGNED", while also advancing the out_top to
the next possible valid entry.


Suzuki


> 
> [ ... ]
> 
>> +void kvm_realm_unmap_range_filter(struct kvm *kvm, unsigned long start,
>> +				  unsigned long size, bool may_block,
>> +				  enum kvm_gfn_range_filter attr_filter)
>> +{
>> +	/*
>> +	 * MMU notifier callbacks cannot take slots_lock, which protects the
>> +	 * eager split cache. Use a cache owned by this invalidation instead.
>> +	 */
>> +	struct kvm_mmu_memory_cache cache = { .gfp_zero = __GFP_ZERO };
> 
> [Severity: Medium]
> Can topping up this cache from an MMU notifier callback enter direct reclaim
> and trigger a lockdep splat on __mmu_notifier_invalidate_range_start_map?
> 
> When mmu_notifier_invalidate_range_start() invokes
> kvm_mmu_notifier_invalidate_range_start() -> ... ->
> kvm_realm_unmap_range_filter() with may_block set, it holds
> __mmu_notifier_invalidate_range_start_map.  Because cache.gfp_custom is left
> at 0, realm_unmap_cache_topup() -> __kvm_mmu_topup_memory_cache() allocates
> with GFP_KERNEL_ACCOUNT (__GFP_DIRECT_RECLAIM | __GFP_FS), which enters
> fs_reclaim_acquire() and acquires __mmu_notifier_invalidate_range_start_map
> recursively (and risks reclaim recursion deadlock under memory pressure).
> Setting cache.gfp_custom to GFP_NOWAIT | __GFP_ACCOUNT avoids direct reclaim
> in the notifier path.
> 

