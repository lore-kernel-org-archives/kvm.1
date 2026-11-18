Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794998065;
	b=me5ZLp/8HdoObg5+g7OuhKntg9zGzJpwKS/3zlHTe/8LJARZNYoAp6/OKml5eSbQkeQ6
	 fHOJQAOHics81826+qWk944WQ4ucJAfakoYdc8/1PadRWSrqf54kSRrvOZ9jewXpfTBDR
	 uYHVfCjPwG8bE+LVtg8ibRih8E1vzEgmcrQr1hFNurINw0xklxYceVHk6t32RcOPrixMt
	 +Z4W2n4Z1UxYim/bXE7QXtLWCeln05R9hQHqByC7MeUGemSstDCNkKx1mAIxU0bOPkofs
	 SFU96h6t410FECcb7o0w+7ymJHMZ9B/nVgiWazX4+HAD8+EbRrXkhm37XMiSkaS5XFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794998065;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=iEnnEuXg2bne+5suSb+pfcSIa1VRJlTnH+FEq31HwCc=;
	b=Hw7yes+F6Yw0QOny5wpSXYrq1ecme+M5c7Xdqu+2WLVKD/uHylPVrlvH3RlZsxinaVvx
	 fJJ4DujJawmJwMdYDL171mGvNkIf4AIRfl3noNrtIbOBtfSgvTNZtOTDKVJTF0t03aJ8A
	 rz8k1PWpRO5xqdpCbMq6Yw+OqoS1pcCUPULc1Zc7ThzK40TGmseTieHnZfVpkOnAtA7Th
	 K4Xm34/F6e4WUfP5ydpC7TQ3dVl2bZUJIXGmCsyz6g6yzZ5dSBYUi7/Qr3bMKQTnlpvX8
	 IF4aIE5MyeysPYOdlvcn6iNM6Dh0RfYL3gPEIeX3QLQuUlPNEoB8L91azI0qk0C636A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="njf/bY16";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2609606A333;
	Wed, 18 Nov 2026 10:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2609606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=njf/bY16
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 316311596;
	Wed, 18 Nov 2026 02:34:21 -0800 (PST)
Received: from [10.57.70.68] (unknown [10.57.70.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 255DD3F632;
	Wed, 18 Nov 2026 02:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794998064; bh=882HlCJQp1tJ2yoxf93aeqGXZo2OFfU4ZGyzNDdoa9s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=njf/bY16PsTTY3pbwuNM0wNOkujnHH5iwftPdKTgBLyhU3zjZcPZWSIVqm0vrsef5
	 2PWeZ3MpAG33IWM+IpnDCgnVCHsSPStO25enry1jwlTwH5gd2N7RI1QPSHakbhu+E2
	 YT0U7VYMJMuAaeESA31deIn37yxmuAa4LcjWoXJM=
Message-ID: <6bb490cd-ebbe-41d7-adf3-d6eaf0e53478@arm.com>
Date: Wed, 18 Nov 2026 10:34:18 +0000
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
To: Fuad Tabba <tabba@google.com>, Steven Price <steven.price@arm.com>
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
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <CA+EHjTy5xBmavNWSYPjqU9qXtssV3ZHzsUr1s_4bVOt1GnDLVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Steven

On 17/11/2026 14:05, Fuad Tabba wrote:
> Hi Steven,
> 
> On Mon, 16 Nov 2026 16:43:47 +0000, Steven Price <steven.price@arm.com> wrote:
>> Check the guest_memfd backing file when deciding whether an arm64
>> memslot has mappable memory rather than checking whether the slot is
>> gmem only. A public helper function is added to be able to reuse the
>> static kvm_gmem_supports_mmap() function.
> 
> nit: could the message say why this is needed? It's a no-op until
> patch 8 defines kvm_arch_has_private_mem(), which makes every
> guest_memfd slot gmem-only.

I still don't understand why this is needed. For arm64 we have always
prevented guest_memfd without MMAP, in kvm_arch_prepare_memory_region().


Suzuki



> 
> Cheers,
> /fuad

