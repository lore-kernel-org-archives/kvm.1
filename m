Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793636669;
	b=lVo/BYUYNFBld/pHDYVSVwjAYC9tocqN796w7FFig9gJFq2boxVbFllh2BMMzNnyn/c6
	 vXEZSiunPbUnraAWE9y+xx3E58x7aEYYodgnw6iVtfsAcS0CW9g5hXjZusFryrvBrYqJT
	 reqoZZyyiRRWEVo4oZ/0RF06yRU97t89ON5tv9+zWqX/jUbpAechA/J7pGbcUPQimF+DB
	 cFsTyyfN9jkl2Wq3IzBFljxW3IZTyua5nC9ToiUqSN6AXjA0WPcTbNydJkAvoLhTXlkZm
	 goVmJytNH2t9VV5cpKItvyJGOHO9o6oVXWypLcjyDiSBTlVKw9SKUf6HBghFb233KzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793636669;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=i8ppdNIdxqrbzcwXDKOqV5mCDQqBWwlYUQimNYyOKAs=;
	b=HMuPfgyuoenQBPQ0fClhqqGmTf+eLaxQUln9SL7BxMXU9mM4VomucrCui+qSfm/hSaZJ
	 J8X44SK+PtRy0kflbR496ztzyHZP3BCR1XJ3Qy5ovX9lZb5MhQqdowbdfubzwwZukE7iM
	 qGnDRS0n8Szq8OgxLrbtchQPJu66rYLc5lwOAur4h4MXJR1pGvbYDU0ICtY8zSmjLt1mw
	 lvDOhmVjRiCUeRSxgyr8BEvnwE++3/zHgc2V8jCwgXysNV4loaT2XgFel266avvxLbk83
	 +c7DyTi31CQrb7e2KBEuANknjEwwUgb2kKbB5eumFane59IDCxNCnrsv1h6oKONJRSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=SUj+o82S;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84CF608508C
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 16:24:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A84CF608508C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=SUj+o82S
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6C5B1691;
	Mon,  2 Nov 2026 08:24:24 -0800 (PST)
Received: from [10.57.58.9] (unknown [10.57.58.9])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B48703F59E;
	Mon,  2 Nov 2026 08:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793636667; bh=IW6I+BWc2r7Uvn3Hy9ubGbplk7TZAmLObKxp10D6nPM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SUj+o82SX6vNN52jtgSzYnWP2gAV5nUmd0iZBriNPzdhoRLD+7g7NlMGLpBvDXQZz
	 5lDf+V4OLbkL7xKitSv9l1gxqnGCXdb5Y6YteajX4voPgoqZEmtY4KqYxFBuN0nix3
	 9xkSANJUWbIcKVYBk0RIQcTzQ8fS/Y8ul8ZQ3Wgg=
Message-ID: <446aeea8-4b91-4395-847e-c1ad47b18e58@arm.com>
Date: Mon, 2 Nov 2026 16:24:24 +0000
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
Subject: Re: [PATCH 06/11] KVM: arm64: CCA: Add basic infrastructure for
 creating a realm
To: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: Oliver Upton <oupton@kernel.org>, Marc Zyngier <maz@kernel.org>
References: <20261102141304.126883-1-steven.price@arm.com>
 <20261102141304.126883-7-steven.price@arm.com>
 <sashiko-outbox-193628@kernel.org>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <sashiko-outbox-193628@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/11/2026 15:05, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] KVM: arm64: missing realm->ia_bits initialization in kvm_init_realm()
> - [Medium] KVM: arm64: cca: clamp Realm IPA limit to host limit in kvm_init_ipa_range()
> --
> 
> commit e03ea9b753f8211e9e93f2e5edff9ba91b09d112
> Author: Steven Price <steven.price@arm.com>
> 
> KVM: arm64: CCA: Add basic infrastructure for creating a realm
> 
> This commit introduces the initial functions and state structures for
> creating and destroying a Realm VM, and checks the requested IPA size
> against the RMM's supported Stage-2 address size.
> 
>> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
>> index 1301c563d7052..b049ea67d9af3 100644
>> --- a/arch/arm64/kvm/mmu.c
>> +++ b/arch/arm64/kvm/mmu.c
>> @@ -981,10 +981,14 @@ static struct kvm_pgtable_mm_ops kvm_s2_mm_ops = {
>>  
>>  static int kvm_init_ipa_range(struct kvm_s2_mmu *mmu, unsigned long type)
>>  {
>> +	struct kvm *kvm = kvm_s2_mmu_to_kvm(mmu);
>>  	u32 kvm_ipa_limit = get_kvm_ipa_limit();
>>  	u64 mmfr0, mmfr1;
>>  	u32 phys_shift;
>>  
>> +	if (kvm_vm_is_realm(kvm))
>> +		kvm_ipa_limit = kvm_rmm_ipa_limit();
> 
> [Severity: Medium]
> Should kvm_init_ipa_range() clamp kvm_ipa_limit with min(kvm_ipa_limit,
> kvm_rmm_ipa_limit()) instead of overwriting it?
> 
> In arch/arm64/kvm/rmi.c, rmm_check_features() only rejects the case where
> kvm_lpa2_is_enabled() is true and the RMM lacks RMI_FEATURE_REGISTER_0_LPA2:
> 
> 	if (kvm_lpa2_is_enabled() &&
> 	    !rmi_has_feature(0, RMI_FEATURE_REGISTER_0_LPA2)) {
> 		kvm_err("RMM doesn't support LPA2\n");
> 		return -ENXIO;
> 	}
> 
> It does not prevent running with !kvm_lpa2_is_enabled() when the RMM supports
> LPA2 and reports a 52-bit S2SZ in RMI_FEATURE_REGISTER_0_S2SZ, or when S2SZ
> exceeds the host's sanitised ID_AA64MMFR0_EL1.PARange. Meanwhile,
> kvm_set_ipa_limit() caps get_kvm_ipa_limit() to 48 bits when
> !kvm_lpa2_is_enabled() && PAGE_SIZE != SZ_64K.
> 
> If kvm_rmm_ipa_limit() is larger than get_kvm_ipa_limit(), overwriting
> kvm_ipa_limit allows userspace to create a Realm via
> kvm_arch_init_vm()->kvm_init_stage2_mmu()->kvm_init_ipa_range() with
> phys_shift > get_kvm_ipa_limit(). That causes kvm_get_vtcr() to configure
> VTCR_EL2_T0SZ for 52 bits without VTCR_EL2_DS, kvm_pgtable_stage2_init() to
> attempt allocating 256 concatenated PGD pages, and kvm_handle_guest_abort()
> to inject an address size fault for any fault_ipa >=
> BIT_ULL(get_kvm_ipa_limit()):
> 
> 		/* Beyond sanitised PARange (which is the IPA limit) */
> 		if (fault_ipa >= BIT_ULL(get_kvm_ipa_limit())) {
> 			kvm_inject_size_fault(vcpu);
> 			return 1;
> 		}
> 
> [ ... ]

Valid point - I'm not really convinced the situation will happen in
reality but if for some reason Linux has capped the IPA size it supports
then we don't want to override that just because the RMM supports a
larger size.

>> diff --git a/arch/arm64/kvm/rmi.c b/arch/arm64/kvm/rmi.c
>> index 5b07beff8bc91..45ecbaa467d1d 100644
>> --- a/arch/arm64/kvm/rmi.c
>> +++ b/arch/arm64/kvm/rmi.c
> 
> [ ... ]
> 
>> +int kvm_init_realm(struct kvm *kvm)
>> +{
>> +	struct realm *realm = &kvm->arch.realm;
>> +
>> +	realm->sro = kmalloc_obj(*realm->sro);
>> +	if (!realm->sro)
>> +		return -ENOMEM;
>> +
>> +	return 0;
>> +}
> 
> [Severity: High]
> Where does realm->ia_bits get initialized?
> 
> This patch adds unsigned int ia_bits to struct realm in
> arch/arm64/include/asm/kvm_rmi.h and calls kvm_init_realm() from
> kvm_arch_init_vm() after kvm_init_stage2_mmu() has configured
> kvm->arch.mmu.vtcr, but neither kvm_init_realm() nor kvm_init_ipa_range()
> sets realm->ia_bits (for example to VTCR_EL2_IPA(kvm->arch.mmu.vtcr)).
> 
> Later patches in the series ("KVM: arm64: CCA: Tear down RTTs", "KVM: arm64:
> CCA: Add Realm RTT mapping and invalidation helpers", and "KVM: arm64: CCA:
> Support runtime faulting of memory") read realm->ia_bits in
> get_start_level(), realm_destroy_rtts(), realm_unmap_stage2(),
> realm_unmap_shared_range(), kvm_realm_unmap_range_filter(),
> kvm_realm_is_private_address(), and kvm_gpa_from_fault(). With realm->ia_bits
> left at 0, expressions such as stage2_pgtable_levels(realm->ia_bits),
> (1UL << ia_bits), and BIT(realm->ia_bits - 1) will compute wrong RTT start
> levels, wrong IPA bounds, and undefined shifts.

The assignment of ia_bits is in a later commit (not in this posted
series) as part of realm_create_rd(). But actually it probably makes
more sense done here, so I'll fix that up. Imagine kvm_init_realm() has
the following:

	realm->ia_bits = VTCR_EL2_IPA(kvm->arch.mmu.vtcr);

Thanks,
Steve

