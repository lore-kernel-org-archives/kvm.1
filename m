Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793788762;
	b=ONxIeaD9YQtt57Udah2cQ0vMnl64dp1ujEZjxUgcnnpMFgJcIClDPOZxkPGWVXoKJT0F
	 2UAiZcFmVqwHcu3kZx8qvoFt0FhU29yo9TasVTUI/ZsiRy3KcP+iRQRx/byKL3HHqoTrS
	 odQqHCsokHDqgxkB6w7U1Z24V5thuU2+gSL+QGjU6LNHysUyGbwk2Y7GWQRPzK5uJ5dLY
	 T49SBkvSwTmjKXo4+B9zZLH0rlr6PV2GurpMTXuu1Hg/Tn6xiFVBbnnx458djq/FjUR78
	 nnHupTKizWj7A87uDgvaaI8WnXdosPgr5CH4VVPO+9R/zvVuUNEs6UxDM7coZ6nGfgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793788762;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=nssP4eGI3zXDuFonBDPkQJxTRjYQwrWbLZScwkFMK9E=;
	b=Uq+x4VL8wVVapKZ/atghB3Dre9sby0nNEq5Thf9opMitxSIVSYRqPBiwsU1Cn6uSpcFl
	 GRIoleWLcy4tJJMQgdafBe7gGxrnoOZlmTZ+lp2wme+qhKyXFnEPhfvj6s6mZBgNOLuED
	 81WgFNTENasfXmAs1dEtSMkL90RwU3SQRVQeidR0xEMY8vjn49UscS28u/nhwQeEMDSc4
	 qBlWbMYIkHbnyDrg/eO2Njcd5npmUF7a1mW3uO0VISp6qSwh5ynm4b8UTAR4zM4KNN5D6
	 Dlh6dngj5EHd5DtCmyWGewDVevSN0X+y/53I7ZVKIamFndBBByIauDkPRqDZlcvNh4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=eDsuvw7f;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D7A606A326;
	Wed,  4 Nov 2026 10:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33D7A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=eDsuvw7f
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 272AB1650;
	Wed,  4 Nov 2026 02:39:17 -0800 (PST)
Received: from [10.2.197.99] (ewhatever.cambridge.arm.com [10.2.197.99])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AE4E3F628;
	Wed,  4 Nov 2026 02:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793788760; bh=uv4Nu83ZWi1bXtWcHnSpsPJ7BG6d6N7mX+McDBYbtuY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eDsuvw7fRB91gXRC27O09DhHBx6xx9ag5Cesox1gcq2YZ8yZGORGZhEXCRlb3OFoZ
	 KitHx/tyq6HfjbQo7e/ec30gUCsMaQyAysA2e+QxXv2XSRh9Vp6SgUEQspDGAzk4lq
	 ZH24ZRdFSyXCgXan1tWqS7NumGlOoCyoWJYBzQhk=
Message-ID: <415f6a96-9ac2-4256-a9b9-e976bd0e73a8@arm.com>
Date: Wed, 4 Nov 2026 10:39:15 +0000
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
Subject: Re: [PATCH 03/11] KVM: arm64: CCA: Check for RMI support at KVM init
To: Kohei Enju <enju.kohei@fujitsu.com>, Steven Price <steven.price@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
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
 Lorenzo Pieralisi <lpieralisi@kernel.org>
References: <20261102141304.126883-1-steven.price@arm.com>
 <20261102141304.126883-4-steven.price@arm.com>
 <ausEnXB1TE_moI0E@FCCLS0092175.localdomain>
 <ausIgejq7Io9VjZL@FCCLS0092175.localdomain>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <ausIgejq7Io9VjZL@FCCLS0092175.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kohei

On 04/11/2026 10:27, Kohei Enju wrote:
> On 11/04 19:23, Kohei Enju wrote:
>> Hi Steven,
>>
>> On 11/02 14:12, Steven Price wrote:
>>> Check if the RMI support is sufficient for using in KVM. Specifically, we
>>> will only support creating realm VMs when KVM is set to 'rmm' mode.
>>>
>>> Signed-off-by: Steven Price <steven.price@arm.com>
>>> ---
>>>   arch/arm64/kvm/Kconfig | 1 +
>>>   arch/arm64/kvm/rmi.c   | 4 +++-
>>>   2 files changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
>>> index cecea0820e52..d067063a3686 100644
>>> --- a/arch/arm64/kvm/Kconfig
>>> +++ b/arch/arm64/kvm/Kconfig
>>> @@ -34,6 +34,7 @@ menuconfig KVM
>>>   	select GUEST_PERF_EVENTS if PERF_EVENTS
>>>   	select KVM_GUEST_MEMFD
>>>   	select KVM_GENERIC_PRE_FAULT_MEMORY
>>> +	select ARM_RMM_RMI
>>>   	help
>>>   	  Support hosting virtualized guest machines.
>>>   
>>> diff --git a/arch/arm64/kvm/rmi.c b/arch/arm64/kvm/rmi.c
>>> index 5ecc8b349869..9d118768550d 100644
>>> --- a/arch/arm64/kvm/rmi.c
>>> +++ b/arch/arm64/kvm/rmi.c
>>> @@ -3,6 +3,7 @@
>>>    * Copyright (C) 2023-2026 ARM Ltd.
>>>    */
>>>   
>>> +#include <linux/arm-rmi-cmds.h>
>>>   #include <linux/kvm_host.h>
>>>   
>>>   #include <asm/virt.h>
>>> @@ -12,7 +13,8 @@ void kvm_init_rmi(void)
>>>   	if (kvm_get_mode() != KVM_MODE_RMM)
>>>   		return;
>>>   
>>> -	/* TODO: Check if the RMI is available */
>>> +	if (!is_rmi_available())
>>> +		return;
>>
>>  From an admin/operator's perspective, kvm_rmi_is_available would
>> silently remain FALSE in either of the following cases:
>> - kvm-arm.mode=rmm is set, but RMI is not available for some reason.

We could add a kvm_info() message for this.

>> - RMI is available, but the admin forgot to set kvm-arm.mode=rmm.

But not this one. We are additionally planning to move the RMM
activation to gate on kvm-arm.mode=rmm. I will send out a patch
soon.

Cheers
Suzuki


