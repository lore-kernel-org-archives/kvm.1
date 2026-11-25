Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624941;
	b=ObuebPXagSsPxebiE1Lzubg+stpt29kalouqhNJQZ8tDA/xubDyrOGhiNoMuMJNbnlfm
	 ZlO/65aeLkwKtR4lz769nrgH8KUNDlBlRoihFkRnwWnfoHWXjfQSRTe2y2yUt8sBLJYx5
	 fDGbXCH3FM/ceYWJM8rs9u7RpyBzeRM39DcqNgmONpMqltlQVxzY7cL/1s4jYFa+8GJlM
	 RGXMIeRflHWcjgqleMZVggvM64xn082yHeQY77/sVt1/pdNqrBmS9yD/ccUpj8cqHAuBu
	 IXB/Z56u/P8Hnvc9pOcNdHASeyQopJlQq4nI526sxBrzdRYra3kVZ9Mu3SWLj/Vx2jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624941;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=ej3rFQntXuPoH8vhrYecOGevuw9dr5POrf+y7c/G9Zk=;
	b=QHc2y5nh7vW9DBPSTEzVGFiGxgnngStyzCCSLBD2nNHcnUPxOlYBighCpymw66wGc0se
	 CArFFByjA9tX9dNCKn2LkWQiXATrsg13UJGMAeC1AB6V4FZ7SNIyjVetSsgmFepT+O8D3
	 O9GT2Bs3s39bIDNQg8awZ1amnISFcrn4VBJNATFDFYELLMDD9jLcxRW+K+2OLDBoS+tLn
	 TY5CnB1DCmzE9rCfbLtBPpDuYjf1wn677+rvbos7h1i0qdtyYxlerNop/NUMZ+vf21LZ5
	 BHcW+Jo5QiDFwVccJKmpkWeLn3ILb1pmUV3Ne3iZLEHO6iGHEg/GKg50Ap8H9BZtSvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=WwFnfJ7L;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D21E606A321;
	Wed, 25 Nov 2026 16:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D21E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=WwFnfJ7L
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD3932F;
	Wed, 25 Nov 2026 08:42:17 -0800 (PST)
Received: from [10.57.32.107] (unknown [10.57.32.107])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E83383F632;
	Wed, 25 Nov 2026 08:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795624940; bh=SKTswPHzr8rBc1/6nMKHnghgefBWUWYQqZrixcwzN+I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WwFnfJ7LsvuDHGrf9RJkXT6gKAm+PjLazrGgVKRy0f6czqlXxnoMkJnwnFt+tRIdU
	 Sc+BhhxOwDww78oXiF9cRnBSgYVehtI/C4D7BB6pTilTS8zWmSNpemsDJvRn10VU0z
	 V4xvRQmhVmlwI+nuVNknZUvN4NC9mhAuyMoBfwGI=
Message-ID: <19432d85-2923-4037-98fa-cffb664dc342@arm.com>
Date: Wed, 25 Nov 2026 16:42:13 +0000
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
References: <20261123104233.95710-1-steven.price@arm.com>
 <20261123104233.95710-8-steven.price@arm.com>
 <d332948e-48ac-4f84-b620-d39d36992c55@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <d332948e-48ac-4f84-b620-d39d36992c55@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/11/2026 13:32, Suzuki K Poulose wrote:
> On 23/11/2026 10:42, Steven Price wrote:
>> Add the RMI RTT creation and unmap helpers needed by CCA Realm stage-2
>> memory operations. REC exit handling and guest requested RIPAS changes
>> follow in the vCPU series.
>>
>> Signed-off-by: Steven Price <steven.price@arm.com>
>>
> ...
> 
> 
> 
> --8>--
> 
>>   static int realm_destroy_rtts(struct kvm *kvm)
>>   {
>>       struct realm *realm = &kvm->arch.realm;
>>       unsigned int ia_bits = realm->ia_bits;
>>         lockdep_assert_held(&kvm->arch.config_lock);
>> +    if (WARN_ON_ONCE(!realm->stage2_unmapped))
>> +        return -EINVAL;
> 
> minor nit: Does this hunk belong to the previous patch ?

Yes, sorry about that!

Thanks,
Steve
