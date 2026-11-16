Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794840922;
	b=5aob2nr6GvkgbMNWtUtLfssJcp6T/hgLv0fvZH/ZlmMU4p+4udgtOltqyBoh1oZ27vPJ
	 rK+h8p8nUex1TIRkJy/ZkGV9K6/2O1VkQ7dr2i5DEcZLMWvq8ESSvu1fhY35T8jdSS7tq
	 PipfnkYcixroc/y8gVcpqKO3m00RQAHJSzP192al02hCZCgISaI2tV6mMeVS6bZygOQcX
	 OAH9RVhdhy9sSIavUNvKV2yA4p9q2PxOGlEcxm7JGpyMiEQD8tSp03sWUAk8PZmXbtu35
	 QZojPQ7sdfhNecfda/z+ZQPt/VGqA/2T/yu4n7dvxwCg9A7qUS2AKwqBsVUJO5Y4f5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794840922;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=dhpNbptHtWGeqwtJDxxu+ZKON7t1aC1UAEhp1vp/RvQ=;
	b=ZHodUaMV7RXKWXxX7y71mBmwpqAOh/YJjnyDFkieb+1OsCp0H0J63ZwU/qlJ5wYOlQEs
	 NhWyuc9+0+ii2Llh/o76dGbveoTX+oNkgtWXyVwZ7KLDCcb5CkGxBr7+K17rkRW5lL/95
	 VNv61Wsvq7lV+VZcco7C47e7WIAgSJ5Igk0yO5mnr/B4njdiP2EGN1nRsjQqpMgN2M89+
	 qMBUNtX5SwYG4Cs43Mr98HQ+ykW+l7tS5Q1CaQEIMEVtHAwS8kdxn1SU7P5obvjLzdSPH
	 mvcmH06iiAXK8iCdiQWr6FUzGWpLJOSnmMIxOrJ6YTkBN9BuVovKCZEyQWMv2mOqFOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=eLtxxtnB;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7C2606A323;
	Mon, 16 Nov 2026 14:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF7C2606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=eLtxxtnB
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B49EA1684;
	Mon, 16 Nov 2026 06:55:16 -0800 (PST)
Received: from [10.57.63.54] (unknown [10.57.63.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 351C43F763;
	Mon, 16 Nov 2026 06:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794840919; bh=Sp7fVwBe+QVG0GBjjUXT43r55ZA8pJUJowv4qnMKltM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eLtxxtnB3kbyPyVxz0I8NYvtZyDlTDjTDBxvVHLHHHSer6CfjCy71wmNwusyXm3sW
	 I6Xhgyi7yKx3n2aBaQxgdY5YDOYZowsl0TAnNIlNChL33P8ExyUXU87DGiZ89ibCxr
	 1Hg/6UdnY43fIPXvNlhhfH4Eig/Ve+4kgTyQ/IGA=
Message-ID: <7446568c-d794-4177-aac5-49746e2f05c9@arm.com>
Date: Mon, 16 Nov 2026 14:55:12 +0000
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
Subject: Re: [PATCH v2 12/12] KVM: arm64: CCA: Add Realm stage-2 MMU
 operations
To: Suzuki K Poulose <suzuki.poulose@arm.com>, kvm@vger.kernel.org,
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
References: <20261111145758.217946-1-steven.price@arm.com>
 <20261111145758.217946-13-steven.price@arm.com>
 <37a57d36-a516-4312-9e4e-fc151ab77c8b@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <37a57d36-a516-4312-9e4e-fc151ab77c8b@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/11/2026 11:46, Suzuki K Poulose wrote:
> On 11/11/2026 14:57, Steven Price wrote:
>> From: Suzuki K Poulose <suzuki.poulose@arm.com>
>>
>> Register the Realm stage-2 MMU operations now that the RMM mapping
>> and unmapping helpers are available. Route unmapping through the
>> RMM, and use the existing fault handler for Realm memory faults.
>>
>> The RMM handles TLB invalidation when stage-2 mappings change, so
>> the host has no separate TLB flush to perform. Realm stage-2 does
>> not support access flags, including for shared IPAs.
>>
>> Dispatch stage-2 destruction according to the VM flavor. Realm
>> teardown destroys non-root RTTs through RMI, so the host frees
>> only the root RTT pages.
> 
> Minor nit: It may be worth splitting the destroy abstraction as a
> separate patch. Otherwise looks good to me.

Good point - I can split that out.

Thanks,
Steve

>>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Signed-off-by: Steven Price <steven.price@arm.com>
>>

