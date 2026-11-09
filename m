Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794234105;
	b=yFtXP+nrVIbMKkYodzwqzDhxX8x6v4LOPOdZZ1lVK3c+wRr6XXk7+KH0m7QRc9Vpe5+X
	 vGhAgadvUZQ9L29H0uJPXCpKzWY2xcPgODbOLYoQo2HSa9qEcJfvNZ3PUjSxDhvRikuc9
	 97mGm6pFTN4S5/t9uLA9USvBDVa2ayrSjZmDf5KotBfG/itGhfBwmxBFzAuXuiMnZmxCm
	 3pLfxEPczAJxWGDdAUTddHss5Cw20Ja0HTByKYZwZqO5eJz7Mkb7tUAqYOqIGzMBb81Uy
	 6gdOWkW2yIFVIh92n4b55WG58QtnBo/9SvPRNYnsXjfC+ab4grhGS3Px1b9JyVwBFsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794234105;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=k6TybH554OLm55RdRjQIliLzitxsqvzSoXpVsCso3cQ=;
	b=prCWBg7cl8/qF5TO6Ro6QKNk2dPEX8pWxKk0lxCVz+POaeBUaSvsxAiW1DX/r2P/92br
	 jYMC3jaP4HKbsieDj6MW/TiCyKeXzMgs226g5tIjaNC5m1V+kVBxrmSZlhSJ0Hd8pexwY
	 l+vrYBSyEVlBOLYkzk0ViAmdSAYD6dmQRIiJiFOfni6RNDWz8gvVaM/ViBsO8gqZxm5Tm
	 c8WkrZwRysMLrvgLOe+6YR++nI21D2lyykQWLmMjNsi7aFHxP0Sxjxph5UAnTxJnCNziH
	 TSU1HZSrBLq8h3owxSNqrTOvoou/MAEIa+56rNL6Cd1AGoJE922R49G5pWB9Doa/6Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=gDVe0Coa;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18191606D825;
	Mon,  9 Nov 2026 14:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18191606D825
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=gDVe0Coa
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 546E21516;
	Mon,  9 Nov 2026 06:21:41 -0800 (PST)
Received: from [10.0.128.239] (Suzukis-MBP.cambridge.arm.com [10.0.128.239])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB5D23F85F;
	Mon,  9 Nov 2026 06:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794234104; bh=TpZUDzpw/Fkw5pr4KuKhr8vO1civAMoJmulkZhsrH8Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gDVe0CoaFdmP7T8+kQjLhtHWBzE50ygSdtVsjHEgcIyqL3A15q3DvXe7Fftqoaztv
	 /sPSztIgv/wTcpBQst51giL9MBRdKjSqzjzZOzIM/DO67jnwblQxNh6KU7jJpXL8C8
	 zxt7rLEMJKjgDeK1EYEZgieMmfZGIn5P49ihW/Jo=
Message-ID: <567f2b66-d59f-4248-92fe-47d1d861e04c@arm.com>
Date: Mon, 9 Nov 2026 14:21:39 +0000
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
Subject: Re: [PATCH 10/11] KVM: arm64: CCA: Support runtime faulting of memory
Content-Language: en-GB
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
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
 Lorenzo Pieralisi <lpieralisi@kernel.org>
References: <20261102141304.126883-1-steven.price@arm.com>
 <20261102141304.126883-11-steven.price@arm.com>
 <fa0ee5a1-4c49-4c1f-bfbb-c270dc4b6301@arm.com>
 <CA+EHjTy970AWnhYoZ5OqxQ8ojCAELeejw60y2NmpDsM_ZMdu4Q@mail.gmail.com>
 <06e52c9c-9026-4279-b8c0-53a54a667dad@arm.com>
 <CA+EHjTzJ1O8=q0rL5CkLKN3CBDr=TkujEw_M-W0H=BJfmrTEzg@mail.gmail.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <CA+EHjTzJ1O8=q0rL5CkLKN3CBDr=TkujEw_M-W0H=BJfmrTEzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/11/2026 13:11, Fuad Tabba wrote:
> Hi Suzuki,
> 
> On Mon, 09 Nov 2026 11:35:31 +0000, Suzuki K Poulose
> <suzuki.poulose@arm.com> wrote:
> [...]
>>> applies as is. Only how the expected state is computed differs: for a
>>> pVM it comes from the per-page share state rather than an IPA bit.
>>
>> When you say, per-page, you mean per-IPA or per "backing page" ? i.e.,
>> can pKVM do something like :
>>
>>      kvm_ipa_is_private(kvm, ipa) ?
>>
>> (similar to Realm) or does it need the struct page backing the "ipa" ?
> 
> Per IPA, so kvm_ipa_is_private(kvm, ipa) would work for pKVM too. A
> pVM's page is private unless the guest has shared it, and that state
> is in its stage-2 PTE at EL2, not in the struct page. The host kernel
> doesn't have a copy today, since EL2 handles the share and unshare
> hypercalls and the new state is only at EL2, so the pKVM side of the
> check, a hypercall or a host-side mirror, is part of pKVM's
> guest_memfd support when that lands.

Perfect, thanks for the clarification. If kvm_ipa_is_private() works for
you, thats good. I was wondering if the host-side mirrors the data
and KVM would only use that (with EL2 enforcing the checks).

I think we could go with that construct and make progress.

Cheers
Suzuki


> 
> Cheers,
> /fuad

