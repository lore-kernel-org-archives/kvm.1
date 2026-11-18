Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795003500;
	b=GTF1ocEHhNqA+HKuXMAkZRn6jASie0rch89Lf3Xv5qLLihDkhVO/rRxZmu3zCsCSw5RT
	 QmLfYEMyVLqWilXwNwhTimWC7o8G6BX/1CLC330CvRWIilvDHKtEHXOzO11LDdttg+8fv
	 uqQrwfQY35oQQJEKP38W2EiSUSj6VXebTdr/Ioog6bpoBaW0ZhsBWo5CbouYkZDQJLYKi
	 WLwlOjuKNMO8ftmSlszWsLolJmhWma/s+hrGuuUVaMVEB4Z4rJ7LKRysHFHg6LqrlKgVH
	 drYKv5wrl5vjDZrzTcsLuUxXb/1/YHD9Z7f1QoWwaBoD3yQT1+I4eGR+Y9zrvPGph7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795003500;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=GjX5dn8YpgvZsZ/ABHgbZazrxQHsHlF3Djrqer5Cp/g=;
	b=aIZsC/KnM8hKh4LCjpfT8uXh6MJYovfhLlvrEHQ5BLo7eO/ohPAb7WxRMO8Bxfo86lm9
	 2+QTgmZXEkb2gK8zfsh2xBZHxXz6g/hFsdrlhtzATlvlt+xDc56lspAb/pqr3rckNMagE
	 RXwX7AGFT6BywIk2q80srblIAVyJEfVewvwi9EZPwkaYIlJAT337kj8M1DkBJAMGbUB8l
	 +YX1kbkd8UVXN1k/kZqfW8bSPtUxCQaqeFnJsd6Ro4fkG2pyE82wxqwDCHSxuvGymxlG4
	 rs535IHFWPC1USyXlcxOrKTZzf4kUI8UID4ddIeUcDafU69Y+BPsj7mJGpjEUFNESzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=TdJ23J5H;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BDB606A31C;
	Wed, 18 Nov 2026 12:04:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11BDB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=TdJ23J5H
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48EC61596;
	Wed, 18 Nov 2026 04:04:55 -0800 (PST)
Received: from [10.57.70.68] (unknown [10.57.70.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F22A3F632;
	Wed, 18 Nov 2026 04:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795003498; bh=SIPpZoSZA3ybF9zdso+NVRICnQ4r/7VsBMwmu7R20j0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TdJ23J5HAp0e6F1wKGMcZcPfGZh5dJ+bBvB6GZi6bwhQwGbVR4N9r8ODtXvfnvSe8
	 d6+rO1GpcHjaT7sQA9mPB+X0/5maRbPRWiK8bAXFymFKFU/1WCvulutHG7fP6pGB1q
	 9XcoU5WUtTax9beMwbIgTHdiauENtEKPcKg4/18I=
Message-ID: <8a095a42-662a-416d-a5d7-79e10161201c@arm.com>
Date: Wed, 18 Nov 2026 12:04:52 +0000
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
To: Steven Price <steven.price@arm.com>, Fuad Tabba <tabba@google.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
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
 <20261116164358.142785-2-steven.price@arm.com>
 <CA+EHjTy5xBmavNWSYPjqU9qXtssV3ZHzsUr1s_4bVOt1GnDLVg@mail.gmail.com>
 <6bb490cd-ebbe-41d7-adf3-d6eaf0e53478@arm.com>
 <b1ef7241-54b0-4a17-83b6-0008e722f2f6@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <b1ef7241-54b0-4a17-83b6-0008e722f2f6@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/11/2026 11:14, Steven Price wrote:
> On 18/11/2026 10:34, Suzuki K Poulose wrote:
>> Hi Steven
>>
>> On 17/11/2026 14:05, Fuad Tabba wrote:
>>> Hi Steven,
>>>
>>> On Mon, 16 Nov 2026 16:43:47 +0000, Steven Price
>>> <steven.price@arm.com> wrote:
>>>> Check the guest_memfd backing file when deciding whether an arm64
>>>> memslot has mappable memory rather than checking whether the slot is
>>>> gmem only. A public helper function is added to be able to reuse the
>>>> static kvm_gmem_supports_mmap() function.
>>>
>>> nit: could the message say why this is needed? It's a no-op until
>>> patch 8 defines kvm_arch_has_private_mem(), which makes every
>>> guest_memfd slot gmem-only.
>>
>> I still don't understand why this is needed. For arm64 we have always
>> prevented guest_memfd without MMAP, in kvm_arch_prepare_memory_region().
> 
> Fuad is correct, this isn't really needed until patch 8. Patch 8 defines
> kvm_arch_has_private_mem() - that means that gmem_in_place_conversion
> becomes true (see include/linux/kvm_host.h). That in turn means that

> every guest_memfd slot is KVM_MEMSLOT_GMEM_ONLY including slots backed
> by a file without mmap support.

But we dont support slots without MMAP anyways even without this series.
  So, does it really matter for arm64 ?

Suzuki

> 
> But regardless the check for kvm_memslot_is_gmem_only() isn't really
> what the code is trying to do. The fact that the memslot is "gmem only"
> isn't really relevant. The thing we care about is the mappability.
> 
> But I agree the commit message could do with improving. I'll expand that.
> 
> Thanks,
> Steve

