Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643F92D3EE5;
	Fri, 27 Mar 2026 08:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774601381; cv=none; b=YhUQnclPqRqOoIoE97QgLvz31Etfg20fKXvsOARtkP8MrZH+MgX/zqGVXu0omur00Tqt6cJyZthFKuCz6IqMaIIBn3jPu3w9H2O8ppLMiLJ68h2jy9DGI1VA26aaUuBb9CICfIfqSBYPtbmnArsEFN2nqMnqEHOQvix0TOqszzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774601381; c=relaxed/simple;
	bh=Pexv9TpMbhzUb/4Dk8B82YA2sdAT+FiSMIun6H7kW3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NuV+c+T60GOxo1th/Q7tyjXJb3t/iuxlxBtdiZ3ho5S5bTS4Ik6CSeA53JqjA/1O5zcAPZUzp/Z8E+4Hcrap4/H0GaVMpTQ0i0XobQ1Z6FDww22PRlmPcNtnmzTNKy0zZd57XB79iS/WhfzjOGRznWWxNUL6zv77A4xK1TmP1FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjGNBzZK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjGNBzZK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14DCCC19423;
	Fri, 27 Mar 2026 08:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774601381;
	bh=Pexv9TpMbhzUb/4Dk8B82YA2sdAT+FiSMIun6H7kW3M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UjGNBzZKc8pCzxavJ9tJ+qwMtEXA6nzq4zQm/hsKDVydmYNrqgZyW/qnA2LtqWFh4
	 fj5MJTlAaICQvGehIbTvkRzCByLHHF2pcNkbvBbvGVkJYLTstQE0395OibDT1At0rq
	 JgGb28C2+oNzHG6xcc5WX2P5pThVVS9jmIjZi+LwHD8PkDy4qcbu6N7QufD1GgQVkL
	 XxcyUwk9o6bIQsZleDgPgGM1FD3sbH2yfbJGaQE61vGOR84hdSFRcP0553LqzUgUVK
	 W9BpMKSERM3T7WWhn3TClEbpagXkS2EG8yC5QzGIYPsDwQxCvQL4VaSOGeo0SLYkVh
	 nWUM4ITvfQMbQ==
Message-ID: <5bfbe0e4-41ad-4752-bd6f-6eb1b7c84215@kernel.org>
Date: Fri, 27 Mar 2026 09:49:34 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/tdx: Accept hotplugged memory before online
To: Chenyi Qiang <chenyi.qiang@intel.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "bp@alien8.de" <bp@alien8.de>, "kas@kernel.org" <kas@kernel.org>,
 "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
 "x86@kernel.org" <x86@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Bonzini, Paolo" <pbonzini@redhat.com>
References: <20260324-tdx-hotplug-fixes-v1-0-8f29f2c17278@redhat.com>
 <20260324-tdx-hotplug-fixes-v1-2-8f29f2c17278@redhat.com>
 <56190adc345148396ba6b3e52672e662145f7dc7.camel@intel.com>
 <CAMxuvaytU-pM+rviUbNGWMhvbAYutwvaSXW_O=sn+QfOzF35Xw@mail.gmail.com>
 <da98d671-eb7e-4e78-97b0-fedeb9d01f69@intel.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <da98d671-eb7e-4e78-97b0-fedeb9d01f69@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/27/26 04:05, Chenyi Qiang wrote:
> 
> 
> On 3/25/2026 6:29 PM, Marc-André Lureau wrote:
>> Hi
>>
>> On Wed, Mar 25, 2026 at 2:04 AM Edgecombe, Rick P
>> <rick.p.edgecombe@intel.com> wrote:
>>>
>>>
>>> Does this depend on patch 1 somehow?
>>
>> Yes, if I plug, unplug and plug again I get this without PATCH 1:
>> [root@rhel10-server ~]# [ 5707.392231] virtio_mem virtio5: plugged
>> size: 0x80000000
>> [ 5707.395583] virtio_mem virtio5: requested size: 0x0
>>
>> [root@rhel10-server ~]# [ 5714.648501] virtio_mem virtio5: plugged
>> size: 0x2e00000
>> [ 5714.651808] virtio_mem virtio5: requested size: 0x80000000
>> [ 5714.676296] tdx: Failed to accept memory [0x108000000, 0x110000000)
>> [ 5714.683980] tdx: Failed to accept memory [0x110000000, 0x118000000)
>> [ 5714.686997] tdx: Failed to accept memory [0x140000000, 0x148000000)
>> [ 5714.689989] tdx: Failed to accept memory [0x128000000, 0x130000000)
>> [ 5714.694981] tdx: Failed to accept memory [0x148000000, 0x150000000)
>> [ 5714.704064] tdx: Failed to accept memory [0x138000000, 0x140000000)
>> [ 5714.710144] tdx: Failed to accept memory [0x118000000, 0x120000000)
>> [ 5714.722532] tdx: Failed to accept memory [0x130000000, 0x138000000)
>>
>> My understanding is that QEMU should eventually unplug the memory and
>> PUNCH_HOLE then KVM should TDH.MEM.PAGE.REMOVE, but that doesn't seem
>> to happen. 
> 
> I guess it doesn't happen because virtio-mem in QEMU only PUNCH_HOLE the
> shared memory by ram_block_discard_range() but it doesn't touch the private
> memory which should be discarded by ram_block_discard_guest_memfd_range().
> 
> Is this strictly required? According to the specification,

So far nobody specified how virtio-mem should behave in a CoCo environment.

I assume that we need enhancements on the driver and the device side.

In Linux, we should not be accepting memory during memory
onlining/offlining through notifiers, as we might only hot(un)plug parts
of a memory block etc.

We need some explicit calls into the core before we hand hotplugged
memory to the core, and before we hand back unplugged memory to the device.

In QEMU, I would similarly assume that we might have to perform some
additional work when converting memory blocks. *maybe* that would just
be done by the guest that converts memory from private to shared before
unplug etc.

-- 
Cheers,

David
