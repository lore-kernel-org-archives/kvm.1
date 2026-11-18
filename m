Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795021457;
	b=j7k5JKgB7p40KfuZFrQfpd/qDOa6Q6mvMa95aDZ/9MXRQKGLFulDoyqRd+Ia5L/pxxgu
	 N9xvrYQZ1T2nbZ7JOMAxs/UL3aPgOsA6IuVtu7vCevIKGZVje7J0xHaARg9CF0lQEayJd
	 uI924K9xnv4pfWtm6Nldm7U8Qexa+ot032Boao6IsHv+Jo6Q25ClGg2itcMPCdAmwHxLv
	 5xOuS6EBMZrDQqxpyJdgwl0NoYuPLx4EnqekU2lSYuTRRlQcKVj1vg1BvfzLd423/0C+Y
	 evdEeKtKcxuS7pfHnJWQlWH9IDyu8XoyfTbQmRLp6Q6tGkBKEwY9XHUv233fDsrGbdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795021457;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=nqa+nFQZC5Ig4zRO5uaG7pBGb9F4eWw8/n9HDHKsVu8=;
	b=L8QiF6SPNPn0YlydryE/guF5JACteMYlkLBVjAyi0FuIJb8uVW0vXy0kO5eZ1xhDagop
	 MMaXfqQWokyfmmDOB3kVLCwgrkBp7Aqm9YIr7qEvxEuBdHoGMb5GhnZaAVnPRyaDwkD7q
	 nWgzGRy+rZGxwhweAmtyaW+d5Ed0SzrL6vlNQskpH0kHVwDaxP3QERjm2T4pnv7wg0tcu
	 Be1Xxw980w69nukIBtvVmt2GyauB3moBjcXcUdWH18yGCiiJPm+X8ezAGHUDQGlE6BAfq
	 YsdoEgh9lEpOWMpeOUeBYF42ZRiTXv9qMrs8cl1Ba0vwki2QKJw4JBmyaJXicYOuaag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=exJ4ph+D;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224B560A2612;
	Wed, 18 Nov 2026 17:04:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 224B560A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=exJ4ph+D
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 857D01477;
	Wed, 18 Nov 2026 09:04:13 -0800 (PST)
Received: from [10.57.62.206] (unknown [10.57.62.206])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B0093F632;
	Wed, 18 Nov 2026 09:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795021456; bh=I2MvshInrGGMMQbQbyG1/Vaqm9Vs7/yev/tVH+ZkcRw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=exJ4ph+DI9p6YDddw/RbEaCWCdBiESakD24KDZaQ9BBVT5dMmLGeq0fitTFmMPs2F
	 YoJjhaCe+bldPIcJxHpqXATiIEHCRSVXyL092X7TKi/C/oYh8mvYTHEw8h8PUmqSNF
	 Mk8VyCfh1DGh8TNeIvdNpnHRUslG0h5hp2BhC6RA=
Message-ID: <8b90d6fc-8ddb-4173-9d05-3c8977b4ed5d@arm.com>
Date: Wed, 18 Nov 2026 17:04:11 +0000
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
Subject: Re: [PATCH v3 10/11] KVM: arm64: Dispatch stage-2 destruction by VM
 flavor
To: Fuad Tabba <tabba@google.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org,
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
 <20261116164358.142785-11-steven.price@arm.com>
 <CA+EHjTy-0k08Ukyo+4mmzqVn9UjRnvhy=BQT9kxSj7CBzzwO_Q@mail.gmail.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <CA+EHjTy-0k08Ukyo+4mmzqVn9UjRnvhy=BQT9kxSj7CBzzwO_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/11/2026 15:02, Fuad Tabba wrote:
> Hi Steven,
> 
> On Mon, 16 Nov 2026 16:43:56 +0000, Steven Price <steven.price@arm.com> wrote:
> [...]
>> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> [...]
>>  static void kvm_stage2_destroy(struct kvm_pgtable *pgt)
>>  {
>>          struct kvm *kvm = kvm_s2_mmu_to_kvm(pgt->mmu);
>> -        unsigned int ia_bits = VTCR_EL2_IPA(pgt->mmu->vtcr);
>> -
>> -        /*
>> -         * Realm RTTs are inaccessible to the host and may contain stale data
>> -         * after the RMM has released them. The non-root RTTs are explicitly
>> -         * destroyed through RMI before the RD is destroyed; only the root PGD
>> -         * pages remain to be freed here.
>> -         */
>> -        if (!kvm_vm_is_realm(kvm))
>> -                stage2_destroy_range(pgt, 0, BIT(ia_bits));
> 
> Could this patch go before patch 4? Then patch 4 wouldn't need to add
> this check.

Yes, that's a good idea - I'll make that change.

Thanks,
Steve
