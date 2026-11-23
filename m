Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795432408;
	b=5dbHZegsT4/8br9iGyJ9+tlhXnwC322TApH9SlRMvdfocHJl+s7TJsV+1u6TqncYQqxE
	 Sp6RRIyUC+jWM/3/z4JuKobMujk1eLHE4pMf6KPE/8uW74TGB71zBkG5Zc/vjpK7SG3fR
	 t6Fyt4EITigSIkkjQJuywbtNyZvf0Ntt1JEOvFZGODh89c32TdMZcp2Udd93/xZOxO4bO
	 T+9HK0wwjj1LVXr1YVedJG5woMAVGQ9nls4hhdNj7lfZMEyB+ddjLZpmqwnGUGsv2zJQH
	 ryonwaDX5RlLcTi/qrOdTnkkraC446x1EERcvI89qUgn3p5F4O9U9TbDMsZ8sQSEg7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795432408;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=pdNtJPN+YZ4rri0c8RqM9UiYr5D4vUVV+Oim0b+KOQQ=;
	b=xPXnDjidvB0Dj7nBLru9RzAGTNwsjrINUHcyNdXrTnRXs455+NFP/i7zj8XUh0Lu5izp
	 I5C92BBMc3gIGKRCdsnUMb2K4nm9c2Z0rtCKXDcbS9fMztsG9is21zsASuEL58L4yhi/5
	 1IkXWd8SkT83mKOWhFBKDNwMSBgEXL7EJqC2TOUMYblXwd7WhaFLsw7+KNWDOBGj8NMBr
	 Cv3c3dYnVf2p0ATvG6lmH/wTGcG7JOaBYM3E3u6j+i4Y6ukV1vywYNy6Ony/Q/q9RQH2m
	 k6Eezv1M8wTBhix63/K5jS5JsYzaYoSGQJ0CexPkFoZ1uQgDm4PLMC1mKfbVxfGYmDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=m9Q7jtT3;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE55B606A333;
	Mon, 23 Nov 2026 11:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE55B606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=m9Q7jtT3
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06927143D;
	Mon, 23 Nov 2026 03:13:24 -0800 (PST)
Received: from [10.0.129.12] (Suzukis-MBP.cambridge.arm.com [10.0.129.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DCA73F882;
	Mon, 23 Nov 2026 03:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795432406; bh=oNhrJvzngQdGUdvtf3HwuE2CWgPaaoD7obsB30AVFiY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m9Q7jtT3qHQi3dYcCrefTbgfBfUUxdNLEeSayLg5rbIkTXoB/x4VvOFF+eg0uhNh2
	 T/4lQSmqKOLk+XDumy7kWWFZul9JkoADuqxsEvtsVmmda8EtepGJuohYsvZf+bq7uV
	 Nl/sd5PnvA+c6orhoSiVc+M4ML8dN8BWTlgNNhto=
Message-ID: <3a3c5681-ff1e-47b6-b942-2d5ce64a8d6d@arm.com>
Date: Mon, 23 Nov 2026 11:13:22 +0000
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
Subject: Re: [PATCH v3 01/11] KVM: arm64: guest_memfd: Check mmap support when
 preparing memslot
Content-Language: en-GB
To: Sean Christopherson <seanjc@google.com>
Cc: Steven Price <steven.price@arm.com>, Fuad Tabba <tabba@google.com>,
 Ackerley Tng <ackerleytng@google.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev, Catalin Marinas <catalin.marinas@arm.com>,
 Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
 James Morse <james.morse@arm.com>, Oliver Upton <oliver.upton@linux.dev>,
 Zenghui Yu <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Gavin Shan <gshan@redhat.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 Alper Gun <alpergun@google.com>, "Aneesh Kumar K . V"
 <aneesh.kumar@kernel.org>, Emi Kisanuki <fj0570is@fujitsu.com>,
 Vishal Annapurve <vannapurve@google.com>, WeiLin.Chang@arm.com,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Kohei Enju <enju.kohei@fujitsu.com>
References: <20261116164358.142785-1-steven.price@arm.com>
 <20261116164358.142785-2-steven.price@arm.com>
 <CA+EHjTy5xBmavNWSYPjqU9qXtssV3ZHzsUr1s_4bVOt1GnDLVg@mail.gmail.com>
 <6bb490cd-ebbe-41d7-adf3-d6eaf0e53478@arm.com>
 <b1ef7241-54b0-4a17-83b6-0008e722f2f6@arm.com>
 <8a095a42-662a-416d-a5d7-79e10161201c@arm.com>
 <cc27e6a8-6bfa-4c82-92a7-33175baf6803@arm.com>
 <120ad525-efa5-4129-9d97-fa6fa5db747f@arm.com>
 <av8No1rvJLXwciId@seanjc-mac.roam.internal>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <av8No1rvJLXwciId@seanjc-mac.roam.internal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/11/2026 14:54, Sean Christopherson wrote:
> On Thu, Nov 19, 2026, Suzuki K Poulose wrote:
>> I see, thanks Steven. For context:
>>
>> Arm64 currently (without inplace conversion support) only allows GMEM
>> with MMAP flags only and relies on kvm_slot_gmem_only() to detect that
>> the GMEM has MMAP flag. But, when we enable inplace conversion,
>> we can't reliably reject the slots by kvm_slot_gmem_only(), because
>> all GMEM slots are marked GMEM only with inplace conversion.
>>
>> Also, from the API Documentation,
>>
>> "When the KVM MMU performs a PFN lookup to service a guest fault, the fault
>> will always be consumed from guest_memfd, regardless of whether it is a shared
>> or a private fault (unless in-place conversion is disabled and the backing
>> guest_memfd does not have the GUEST_MEMFD_FLAG_MMAP flag set)."
>>


>> So, in effect, with in-place conversion enabled a KVM_CREATE_GUEST_MEMFD
>> without GUEST_MEMFD_FLAG_MMAP is an error
> 
> It's only an error if (a) the userspace address in the memslot points at the
> gmem fd and 

I don't understand this part. With inplace conversion, we mark the slot
as GMEM_ONLY and always resolve shared faults from the gmem (on arm64
as described by the API). So, isn't it a usage error from the VMM if it
plans to use GUEST_MEMFD_FLAG_MMAP=false with inplace conversion ?

In other words, do you mean to say, passing a non-gmem fd userspace
address is fine with GUEST_MEMFD_FLAG_MMAP=false ? But the API
documentation and the GMEM_ONLY flags contradict the usage.

Now, should we reject that in KVM or not is the secondary question.


(b) something in KVM tries to actually GUP the memslot using the
> userspace virtual address.

Agreed


Suzuki


> 
>> and thats what this patch is trying to fix in arm64 KVM. The question is:
>>
>> 1) Should this be fixed ? How does TDX/SNP support older VMMs with
>> inplace conversion ? What was the conclusion on this breakage ?
> 
> There is no "breakage".  If userspace doesn't point the userspace address at a
> valid VMA, that userspace's problem.  The only thing the early check would do is
> prevent weird use cases that may or may not be valid (and for which KVM doesn't
> care), and error out earlier if KVM guesses right and userspace really did goof.
> 
>> 2) If it should be, then shouldn't it be done in kvm_gmem_create() ?
> 
> No.  As above, I don't see any reason to have the check at all.

