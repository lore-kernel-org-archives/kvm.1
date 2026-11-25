Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606265;
	b=gQyz07qgdlWhBRySL7ACl2LC/fSC7dNq9sp23Ak/ngcwS7M6Zjkdmrl+u4J60j2IT1ey
	 jcWUdkFN2rGcusfBegKQxNCGiuCeTjmyqnG4byGKbOZ9wxb80saVYZR3/kpr3g4/uOSd/
	 N1kFq0vN2R5NxUr8PXig2/eZhZHD/GyTyZp6iW/fNEwXVcYPpu76RadKI2QulTulS9x/4
	 ZbMem9mqkskFasoepf3uRQwlaHfIlaXSdVAAba0iOuFRquufUKogBpUVCIe2mtx0NDw9D
	 atNrqaeFmOgSpYroQORHQG9cnIZMZZ7DDmGOKh2HCaCD1x5LQ7bdnxWeDW2wgzJffSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606265;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=HetvVdDBuZv6qCUq12I/7l3z/I27Ld6RsejP9SDDZaI=;
	b=PRKpgpH0gGF4PSItkLr4NsvWM9UXSH0q49uaMPVLDfA6gl7yrNeOQBQ5qVSYylQdqUF4
	 DZDRmi6a9rQ1SUlXpM9GB123Qhe3LyNfybFpGKGAfCkoGqX9lAEhlv1rsIAvn7qxRqQwl
	 HpvPpDp7ZTO+yDBosi39So84X9GnRJXX/WX3t7SEQ7mmsepDguTmlcmFcgYCONFE8cW1U
	 YsG2YRTLdK/x/byMhah/D+Oh8u4aoF1JOqPsbcdlUQTkLRIM8dZXJxhXdvjaySQTuf3lN
	 zJ2ZdwH2UzUUqXIR5yv3yW5c47gXM9PReg4iiAMQKXUHJHR4RmNHNhDT3VABovuljyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="HDgERNk/";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7585A606A32C
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 11:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7585A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=HDgERNk/
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDCB2339;
	Wed, 25 Nov 2026 03:31:00 -0800 (PST)
Received: from [10.57.32.107] (unknown [10.57.32.107])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4696E3FA32;
	Wed, 25 Nov 2026 03:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795606263; bh=eVwyG6uWjY55RVZo1vPdDd3h3+Zf4SnysFgvq49w8pg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HDgERNk/7JacD8Jmz50wjI2dmunJipQkBs8Z/zZ20zL1bo75wy3ziWEuLrI+mSFhq
	 IMOQ1D3GfIz0NlU9J07b51Y2Jb97GwTR5klNr+o4AGtAydfunr0mixFc3/mXywVImM
	 YMkkP/fBNRwXT2Z+QDSH8MPNGAwXvuKeN14BUlZk=
Message-ID: <10b37dd6-a32b-46bb-8629-347805edb9d3@arm.com>
Date: Wed, 25 Nov 2026 11:31:00 +0000
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
Subject: Re: [PATCH v4 01/11] KVM: arm64: guest_memfd: Check mmap support when
 preparing memslot
To: Ackerley Tng <ackerleytng@google.com>, sashiko-reviews@lists.linux.dev,
 kvm@vger.kernel.org, kvmarm@lists.linux.dev
Cc: Oliver Upton <oupton@kernel.org>, Marc Zyngier <maz@kernel.org>
References: <20261123104233.95710-1-steven.price@arm.com>
 <20261123104233.95710-2-steven.price@arm.com>
 <sashiko-outbox-229096@kernel.org>
 <CAEvNRgGU+z609edF+Mw8xQ0NDUDKn9jjxJjJWTyUqJ0N2BGEHQ@mail.gmail.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <CAEvNRgGU+z609edF+Mw8xQ0NDUDKn9jjxJjJWTyUqJ0N2BGEHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/11/2026 23:30, Ackerley Tng wrote:
> sashiko-bot@kernel.org writes:
> 
>> Thank you for your contribution! Sashiko AI review found 1 potential
>> issue to consider:
>> - [Medium] KVM: arm64: kvm_arch_prepare_memory_region() rejects non-mmap
>>   guest_memfd
>> --
>>
>> commit a0665f8dc612d05686ef019cc8462841573fe88c
>> Author: Steven Price <steven.price@arm.com>
>>
>> KVM: arm64: guest_memfd: Check mmap support when preparing memslot
>>
>> This commit introduces kvm_gmem_slot_supports_mmap() and uses it in
>> kvm_arch_prepare_memory_region() to require that all guest_memfd-backed
>> memslots on arm64 come from files created with GUEST_MEMFD_FLAG_MMAP.
>>
>>> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
>>> index 1db10d8d6db73..2825fccd2a197 100644
>>> --- a/arch/arm64/kvm/mmu.c
>>> +++ b/arch/arm64/kvm/mmu.c
>>> @@ -2839,10 +2839,10 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
>>>  		return -EFAULT;
>>>
>>>  	/*
>>> -	 * Only support guest_memfd backed memslots with mappable memory, since
>>> -	 * there aren't any CoCo VMs that support only private memory on arm64.
>>> +	 * All VMs need mappable guest_memfd memory, as the memslot's HVA may be
>>> +	 * used to access shared memory even if guest faults use guest_memfd.
>>>  	 */
>>> -	if (kvm_slot_has_gmem(new) && !kvm_memslot_is_gmem_only(new))
>>> +	if (kvm_slot_has_gmem(new) && !kvm_gmem_slot_supports_mmap(new))
>>>  		return -EINVAL;
>>>
>>>  	/* guest_memfd is incompatible with MTE. */
>>
>> [Severity: Medium]
>> As reported by Suzuki K Poulose on v2 [1], should
>> kvm_arch_prepare_memory_region() drop this guest_memfd check altogether
>> rather than rejecting memslots backed by a guest_memfd created without
>> GUEST_MEMFD_FLAG_MMAP?
>>
>> Both gmem_abort() and realm_gmem_abort() fault in guest_memfd pages via
>> kvm_gmem_get_pfn() without using new->userspace_addr, and
>> kvm_arch_prepare_memory_region() does not verify that new->userspace_addr
>> maps the guest_memfd or any valid VMA.  Requiring GUEST_MEMFD_FLAG_MMAP
>> here fails KVM_SET_USER_MEMORY_REGION2 with -EINVAL for VMs (such as
>> Realms) that bind private-only guest_memfd instances without allowing host
>> userspace mmap, and on v3 the guest_memfd maintainer noted that this check
>> is unnecessary and should be removed rather than exposing
>> kvm_gmem_slot_supports_mmap().
>>
> 
> I agree with Sashiko here. I traced the history of this check:
> 
>     if (kvm_slot_has_gmem(new) && !kvm_memslot_is_gmem_only(new))
>         return -EINVAL;
> 
> In [1], Arm64 guest_memfd enablement, !kvm_memslot_is_gmem_only(new)
> meant "this guest_memfd does not support mmap()". Arm64 had no CoCo
> private-memory VMs yet, so guest_memfd was only usable for shared memory
> where the host VMM needed mmap() to access guest RAM. Rejecting
> non-mappable guest_memfd slots prevented unusable private-only memslots.
> 
> In [2], pKVM support was added. The v1 of [2], [3], says pKVM uses
> anonymous memory. pKVM doesn't really specifically use gmem, so there's
> actually no change, this check doesn't really affect pKVM.
> 
> Conversions [4] made stage 2 faults (mostly on x86), always get memory
> from gmem. On arm, as long as it is a gmem memslot, it already always
> got memory from gmem.
> 
> Now that ARM CCA supports private memory, we should drop this check
> completely, I think David noted that right when it was added [5], and
> that's what Sean means too [6].
> 
> If userspace sets up gmem with a memslot and doesn't set up mmap,
> userspace probably won't be able to set up a running ARM CCA VM, but
> that's userspace's bug imo.
> 
> Imo even back in [1] perhaps the check didn't need to be added, it's
> just a userspace bug to try and set up a memslot with gmem that can't
> really be used.

Ok, thanks for digging through the history. I'm fine with just dropping
the check altogether. I had been trying to avoid changing the behaviour
of non-realm VMs but if we're agreed that the behaviour can be loosened
to allow buggy VMMs to shoot themselves in the foot then that's clearly
much easier to maintain.

Thanks,
Steve

> [1] https://lore.kernel.org/all/20250729225455.670324-21-seanjc@google.com/
> [2] https://lore.kernel.org/all/20260330144841.26181-1-will@kernel.org/
> [3] https://lore.kernel.org/all/20260105154939.11041-1-will@kernel.org/
> [4] https://lore.kernel.org/all/20260910-gmem-inplace-conversion-v13-12-dd6fbf94f4e1@google.com/
> [5] https://lore.kernel.org/all/2195c01b-3a17-46c5-a013-66922e8509bd@redhat.com/
> [6] https://lore.kernel.org/all/av8No1rvJLXwciId@seanjc-mac.roam.internal/
> 
>> [1] https://lore.kernel.org/r/26a29420-8d27-4069-bbd5-28692c9e8542@arm.com
>>
>> --
>> Sashiko AI review · https://sashiko.dev/#/patchset/20261123104233.95710-1-steven.price@arm.com?part=1

