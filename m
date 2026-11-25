Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795600304;
	b=5lvU/gDN+zNa0PBS87RvV4KtBvMp+pGBepPW/CS4tigNZ8IJZgTEUEOlQqJsOU2CvS/C
	 J4asX8WlRM9zsdiD9uWgKqlgJHy0qyUBNUABIfYsCTvk24VX9zj9I3iJpiVWoQMdCdZrm
	 /2ckDxtUtcLMT9uxoEFX7OtTso3ykSf9pBCT7nq6JPPW3IQYSrFnqk4+K5HMtr3crhfqD
	 wMqId+XTTautRfUZzFRjOpP3qKo9H6iS7QOVvKjtTt5dfU6+HFBNEg65HgAL0u3qNqlV8
	 XdmFMG+OO+N1NVJBwB7/0hJF8w01AgKgQ7OPAyLxIqc8ANUQ93fCctuXx8cncVWaTyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600304;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=d1DkW7hSxM4zmZB+M7JMw570YuREp3Imf+VPgNwrY+U=;
	b=1CW4QFxs0XLJ/1w0QoTfX+TJMDS0Uz6VdL3KNpfnTOScXKwVissjRtioGgkE3L+fjK7y
	 bfXusJ09iWJc/DAfsaPyErj+HPqFHTf4/8VdTdZUXz4lIrgRYeRGSVaNCh3+gm3mJHrmx
	 zShTOJkGomhri0UGQWXXZu2A1MVO/fXeTlmlTmZZmcXwAdoQhbmY/PxgTU8uUaIl/WKbk
	 WH57ycuq6kqSSPLw/qe7ApYSRmoHM7NXoS2KP3VAjVQGR2DHpNKZZPFer9nzOZUy8c1yC
	 +mHVtZJ4TmZWBD24A4KADHTl+h/4VTTPFp6yMmW6SnlW9m1WWqudDUlOZ3CZuzcSE1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=QvB9JfTb;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A12606A32A;
	Wed, 25 Nov 2026 09:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4A12606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=QvB9JfTb
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9881C339;
	Wed, 25 Nov 2026 01:51:34 -0800 (PST)
Received: from [10.2.197.99] (ewhatever.cambridge.arm.com [10.2.197.99])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DDC93F86F;
	Wed, 25 Nov 2026 01:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795600297; bh=tRDSqd+CGHk3r5D+U05UtW8jtHrhEXkjEro27EFWSG0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=QvB9JfTb0eVj0TNqX1/aisA+sCnq88pRePMzXgvNV5TV++zi35AaZ9JuNCI5IexBi
	 403av+utnLN8jKrvqrVP4VHRBw7vSuqkg1m1uZn6hfyNMVnKla4d3DaHAzdEAc1fZA
	 993f3D2B+tNmlZ4COwetskel25c8xKMzHeI3iH7k=
Message-ID: <70c50c45-c8b9-4096-84b2-ba4b6ecb63ed@arm.com>
Date: Wed, 25 Nov 2026 09:51:32 +0000
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
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>, Zenghui Yu <yuzenghui@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Gouly <joey.gouly@arm.com>, Alexandru Elisei
 <alexandru.elisei@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Gavin Shan <gshan@redhat.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 Alper Gun <alpergun@google.com>, "Aneesh Kumar K . V"
 <aneesh.kumar@kernel.org>, Emi Kisanuki <fj0570is@fujitsu.com>,
 Vishal Annapurve <vannapurve@google.com>, WeiLin.Chang@arm.com,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Kohei Enju <enju.kohei@fujitsu.com>
References: <20261123104233.95710-1-steven.price@arm.com>
 <20261123104233.95710-8-steven.price@arm.com>
 <bc90af1d-068e-4e79-8d5f-f8205beb0a69@arm.com>
Content-Language: en-US
In-Reply-To: <bc90af1d-068e-4e79-8d5f-f8205beb0a69@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 24/11/2026 00:20, Suzuki K Poulose wrote:
> On 23/11/2026 10:42, Steven Price wrote:
>> Add the RMI RTT creation and unmap helpers needed by CCA Realm stage-2
>> memory operations. REC exit handling and guest requested RIPAS changes
>> follow in the vCPU series.
>>
>> Signed-off-by: Steven Price <steven.price@arm.com>
>>
>> ---
>> Changes since v3:
>> - Use the VTCR-derived Realm start level for RTT operations.
>>
>> Changes since v2:
>> - Use a local MMU cache during notifier invalidation, handle
>>    failed RTT splits, and validate RMI levels and cache state.
>>
>> Changes since v1:
>> - Rework RTT creation and folding around missing or existing RTTs.
>>    Use a shared RMI block-size helper and handle alignment, partial
>>    progress and errors in range operations.
>> ---
>>   arch/arm64/include/asm/kvm_rmi.h |   8 +
>>   arch/arm64/kvm/rmi.c             | 421 +++++++++++++++++++++++++++++++
>>   drivers/firmware/arm_rmm/rmi.c   |  10 -
>>   include/linux/arm-rmi-cmds.h     |   8 +
>>   4 files changed, 437 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/kvm_rmi.h b/arch/arm64/include/ 
>> asm/kvm_rmi.h
> 
> ...
> 
>> +
>> +static void realm_unmap_shared_range(struct kvm *kvm,
>> +                     unsigned long start,
>> +                     unsigned long end,
>> +                     bool may_block,
>> +                     struct kvm_mmu_memory_cache *mc)
>> +{
>> +    struct realm *realm = &kvm->arch.realm;
>> +    unsigned long rd = realm->rd_phys;
>> +    unsigned long next_addr, addr;
>> +    unsigned long shared_bit = BIT(realm->ia_bits - 1);
>> +
>> +    if (start >= end)
>> +        return;
>> +
>> +    /*
>> +     * Callers may pass either an IPA range or its shared alias. Add the
>> +     * shared bit only for the former. Use addition so an exclusive 
>> end at
>> +     * shared_bit advances to the end of the IPA space.
>> +     */
>> +    if (start < shared_bit) {
>> +        start += shared_bit;
>> +        end += shared_bit;
>> +    }
>> +
>> +    for (addr = start; addr < end; addr = next_addr) {
>> +        long ret;
>> +
>> +        ret = rmi_rtt_unprot_unmap(rd, addr, end, RMI_ADDR_TYPE_NONE,
> 
> ...
> 
>> +        }
>> +
>> +        if (may_block)
>> +            cond_resched_rwlock_write(&kvm->mmu_lock);
>> +    }
>> +
>> +    realm_fold_rtt_level(realm, realm->start_level + 1,
>> +                 start, end);
> 
> See below.
> 
>> +}
>> +
>> +static void realm_unmap_private_range(struct kvm *kvm,
>> +                      unsigned long start,
>> +                      unsigned long end,
>> +                      bool may_block,
>> +                      struct kvm_mmu_memory_cache *mc)
>> +{
>> +    struct realm *realm = &kvm->arch.realm;
>> +    unsigned long rd = realm->rd_phys;
>> +    unsigned long next_addr, addr;
>> +    long ret;
>> +
>> +    for (addr = start; addr < end; addr = next_addr) {
>> +        unsigned long out_range;
>> +        unsigned long flags = RMI_ADDR_TYPE_SINGLE;
>> +        /* TODO: Optimise using RMI_ADDR_TYPE_LIST */
>> +
>> +        ret = rmi_rtt_data_unmap(rd, addr, end, flags, 0,
> 
> ...
> 
>> +        }
>> +
>> +        if (may_block)
>> +            cond_resched_rwlock_write(&kvm->mmu_lock);
>> +    }
>> +
>> +    realm_fold_rtt_level(realm, realm->start_level + 1,
>> +                 start, end);
> 
> 
> If "may_block", we don't take that into account while folding the RTTs ?
> On a bigger range, we might spend too much time, starving the other
> threads.
> 
> Also, there is no point in folding the RTTs if the Realm is dying. So, I
> would rather skip this if the Realm is not ACTIVE.

Having a think about it, I don't think the folding of RTTs in the unmap
case is a good idea. We could leave them as they are, because:

1) As mentioned above, we are holding the write_lock() and doing this
within the lock is bad for contention
2) We do not check if there was any mapping at all that was actually
invalidated. i.e., the tables were already folded and for a big range
we go over it unnecessarily.
3) For fixing up permission faults on shared range, we end up unmapping
the range and then trying to map it. Folding here means, we could end
up in the dance of reclaiming the RTT and then creating it back for
each L3. (This is a rare case though).

Overall, I don't see the benefit of folding outweighing the impact of
it. So, could we please drop this ?


Cheers
Suzuki


> 
> Suzuki

