Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311663;
	b=PqWARbdbFFUIZny5R4Q/ilHE8mVAlhKy1WfYU97+dIiTm7G5hSIw8W4Y+bys4B4Ik0Zq
	 1Gi/ulQqzD66UTKTO7WWnbO5BHxnT2zFo9OD1W5CnUTYWE7lZgYRE81JgBqRF9PUxxKT8
	 uBzDsLhoKqjEDqaVzqAYUwfyeMc6yrMW2UZntwravQoFmzUhaHSsF618cXwEP3VOQImF2
	 8WgyRmv2ncwD2PZSvf/jkswNIYz4meScEatnpPJgr/OqW3yLKPQL9Cs7m8VSDxhg3Lzw4
	 LauGCGs3O6otu1VQZGmGG6iak8M8ynuOFJuDJlCKhhrnqntm+LFYHNEgMx5fGbMAh1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311663;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=xpa/lg9njdRQQ0b6uyNUAGO+MuLiJ9/osTOM3IJ8JTE=;
	b=DFM+PHxcdT/VkYOeAONc+flhprQka12thZJ6oOF6dAa6inaSJKZ3fiR5ZTYZ4LZeGV9X
	 YSSzerwAXfMGkgN+dJ5VdIdx5X6mqveq2P9V7YLnYmo4c5klItICRJn5WsSX8RglgO9pL
	 099sFtxlKuFTHyxh7UpZqQ8+xYJkHrapZqrRem1dVm3LaEpp9VTAIuVQXWxuC8jfnw8+7
	 5NeTxg6JBrkJ83QrfuyV2osMjplltMJQcOzOWeOYYWC+pcEyDXOS3Dv9QxQ2N2HPc5MY1
	 9+/6m2XOIDqiem+WmQLEuE5rinx/R+plFSC1mqz02nWLSVkNM2x9vKXisrTDhwiSRjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ITjlHVP6;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129E0606A998;
	Tue, 10 Nov 2026 11:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 129E0606A998
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ITjlHVP6
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35E8A14BF;
	Tue, 10 Nov 2026 03:54:19 -0800 (PST)
Received: from [10.2.197.99] (ewhatever.cambridge.arm.com [10.2.197.99])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B54D43F632;
	Tue, 10 Nov 2026 03:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794311662; bh=7Pp0tIVrm11vJlC7ulH2AYa6UOT1xWrcSbC9dxxfAhk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ITjlHVP6O2P61WozfihQOEfxkHjfXrATDkC42kjSKChCmKg2q0nUsHR3oxlVJY3cN
	 LLUdsVldsb//VjfcccwBi4m+wiy47PufgMctazzoNNB8ZVR7+yT8oCQq92ibtztQcM
	 0AheKLHynihg17TZo6MF95c97MHoJPUoKOm+qIbU=
Message-ID: <e9bc3885-4e29-44a0-a186-463337f57d9e@arm.com>
Date: Tue, 10 Nov 2026 11:54:17 +0000
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
Subject: Re: [PATCH 00/11] KVM: arm64: CCA: Prepare Realm memory management
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
 <avLgdqlfUPMAI-r9@FCCLS0092175.localdomain>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <avLgdqlfUPMAI-r9@FCCLS0092175.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kohei

On 10/11/2026 09:24, Kohei Enju wrote:
> On 11/02 14:12, Steven Price wrote:
>> This series adds the memory plumbing for CCA building on the basic
>> plumbing[1] that has just been merged.
>>
>> These patches add the internal realm VM state and RMM feature checks,
>> prepare realm stage-2 setup and teardown, and provide RTT mapping and
>> invalidation helpers. Realm memslots are now contrained to the lower
>> half of the IPA space, because faults treat the protected and shared
>> halves as aliasing. The final patch then connects these helpers to the
>> KVM stage-2 MMU operations.
>>
>> There's also an integration branch[2] that builds on this series and
>> includes the realm descriptor creation, REC entry/exit, activation and
>> the new uAPI. This series by itself is also available as a git
>> branch[3]. However the new code isn't generally active without the full
>> integration branch.
>>
>> [1] https://lore.kernel.org/all/20261007073537.2454351-1-suzuki.poulose@arm.com/
>> [2] https://gitlab.arm.com/linux-arm/linux-cca
>>      branch: cca-host-mm/v1/integration
> 
> Hi Steve, thanks for your work on CCA upstreaming.
> 
> For testing purposes, could you clarify which TF-RMM revision (or commit
> hash) you tested with? Although this MM series itself doesn't seem to be
> particularly sensitive to changes in TF-RMM, testing the integration
> branch could be affected by subtle changes in the RMM.

Tip of both the repositories should work (tf-a and tf-rmm).

Cheers
Suzuki


> 
> It would also be useful to know the TF-A revision, if possible.
> 
> Thanks,
> Kohei

