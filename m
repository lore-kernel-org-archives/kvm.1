Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020566;
	b=R5gc9WKfLclX/UxYwXokOuVzBKtDADWaEaVXCaFWzd5MPNCwlOxkasaxw7PnEO32uRcg
	 OGjl4MCeQPjD89Q04++WTFEl+Na7Q9DSWdcgO65QxRrdD83980pFpvbDtCGbq1FcMQsCC
	 9GqH0aTlu6er62MoYL0JIvj+SYfdCePm1fcHZqW8V6+hxiY3DkUwo51ojqoFgOixRzANN
	 p2m0WAxiUbgARo9OjlkuHVp0kC5H/TW5FuFtdacwTi3v66wIjLUDE/NlylWp3pPUkSgMu
	 zHIwC7sCgFOM4G+slu8Av9BZYDy68+jhblqBJYn6WIX0LyR7VUlGUjqvbpg5stJzf8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020566;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=We1LJjJy1kCPW5EPJlSwLuh9zShR5MvSm97HULZTIo4=;
	b=iELb+coKs8ErA9W4nLlLrIFwdKUWG4z+4aPbxYZeuVa2HcQYNrDPTimMORycqusfr05I
	 47O4JtDJ7Tptf5z9ve1zU9sehWAX+joslzEF1C3TQD4BTQT1Ip1/3FqduTMHn18bO0OOR
	 Yp3epC9KDqSaxcDAJbnmvQqFg7RwDroSUYLD55NVEhuMi+lH7UkZThAuqIP4EK/jTdn0O
	 +Z1M3xlbngDED/ONm+IsFMxjqcPGCxgGmsj81/QXu2pjw3zmqzh8ZNgbzlStqsKOwtMRr
	 pdLBrqGemsSs0DyyQgv5oJ0qWfg76PppyJvBVkzWfsnP/nHyzChp2eUaxxHYKu4LOQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="UAM//OUL";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEA1606A31C;
	Wed, 18 Nov 2026 16:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DEA1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=UAM//OUL
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5AFD143D;
	Wed, 18 Nov 2026 08:49:21 -0800 (PST)
Received: from [10.57.62.206] (unknown [10.57.62.206])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 571CE3F673;
	Wed, 18 Nov 2026 08:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795020564; bh=5DF3UMuuIAB9eEb863SsQyI53Bmrii/ORFqImQUx9Ck=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UAM//OULyFGAv7/1q3GJ435EUNjO1b4O1WG5u+nQr9NMdylc3Fx2uWKh14BhWsVMS
	 TBOFPuGu3IpQ2ztmBBQhLPAMHzdUK8EcCrJCKwYaZFxQATLKRAyFJG0WzAKC4qGTja
	 AegXQAErNCqkoGgBNl0v1dds8/wdY+g3Tusstjj0=
Message-ID: <9b42bb54-97aa-4b2f-94f8-0c887a7f82a2@arm.com>
Date: Wed, 18 Nov 2026 16:49:17 +0000
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
Subject: Re: [PATCH v3 08/11] KVM: arm64: CCA: Prevent memslot modifications
 after Realm creation
To: Fuad Tabba <tabba@google.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>, Zenghui Yu <yuzenghui@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Gouly <joey.gouly@arm.com>, Alexandru Elisei
 <alexandru.elisei@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Gavin Shan <gshan@redhat.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 Alper Gun <alpergun@google.com>, "Aneesh Kumar K . V"
 <aneesh.kumar@kernel.org>, Emi Kisanuki <fj0570is@fujitsu.com>,
 Vishal Annapurve <vannapurve@google.com>, WeiLin.Chang@arm.com,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Kohei Enju <enju.kohei@fujitsu.com>
References: <20261116164358.142785-1-steven.price@arm.com>
 <20261116164358.142785-9-steven.price@arm.com>
 <CA+EHjTzAo+5FhtxfX8mQ4t3k5BhatR15UKNSAQw+CRbxJ=wz7A@mail.gmail.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <CA+EHjTzAo+5FhtxfX8mQ4t3k5BhatR15UKNSAQw+CRbxJ=wz7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/11/2026 14:42, Fuad Tabba wrote:
> On Mon, 16 Nov 2026 16:43:54 +0000, Steven Price <steven.price@arm.com> wrote:
> [...]
>> Define kvm_arch_has_private_mem() so generic KVM recognizes Realm VMs
>> as supporting private memory.
> [...]
>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> [...]
>> @@ -1611,6 +1611,8 @@ struct kvm *kvm_arch_alloc_vm(void);
>>
>>  #define kvm_vm_hyp_is_distrusting(kvm)        ((kvm)->arch.vm_flavor >= __VM_DISTRUSTING_HYP)
>>
>> +#define kvm_arch_has_private_mem(kvm) kvm_vm_is_realm(kvm)
> 
> Could the message say that defining the macro makes
> gmem_in_place_conversion true for every arm64 VM? One visible change
> is that KVM_SET_MEMORY_ATTRIBUTES2 on a non-Realm VM's guest_memfd
> returns -EINVAL instead of -ENOTTY.

True - I'll explicitly mention that the commit message just in case
anyone bisects that in the future.

> [...]
>> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> [...]
>> @@ -2887,10 +2903,13 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
>>                  return 0;
>>
>>          /*
>> -         * Prevent userspace from creating a memory region outside of the IPA
>> -         * space addressable by the KVM guest IPA space.
>> +         * Realm shared IPAs alias the corresponding private IPAs, so memslots
>> +         * must reside entirely in the canonical lower half of the IPA space.
>>           */
>> -        if ((new->base_gfn + new->npages) > (kvm_phys_size(&kvm->arch.mmu) >> PAGE_SHIFT))
>> +        ipa_limit = kvm_phys_size(&kvm->arch.mmu) >> PAGE_SHIFT;
>> +        if (kvm_vm_is_realm(kvm))
>> +                ipa_limit >>= 1;
>> +        if (new->base_gfn + new->npages > ipa_limit)
>>                  return -EFAULT;
> 
> This check still applies to every VM, so I'd keep the old comment and
> add the Realm sentence to it.

Ack.

Thanks,
Steve

