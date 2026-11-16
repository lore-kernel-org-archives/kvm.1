Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794829598;
	b=ijAJGhc2dr+fKNhR2X6SF5is0GgYxqR7MaCfqAFAXXDy+5bY+J2X4VcxVI09tqgHb7Ph
	 hhCfveYLEeF4WWio+zq2XC1Q6HWjexzPpw+5wHp8R9zu+tATpUPeTo/mhwx7A8KmyCUto
	 RVtMueTM4Toe0S8AtbWzStHYSjOwvR0qT2WoJL9bjNISFEHuaNK6ko5P3HFDf8b/w+dMi
	 onKIIXcpIHN1qnqo5GgKTZko9NzvEMGMRFTV+w2U6GxNdTZwF4ytp3t1oD7iHkMwIB7dr
	 a93mmm7AELVlOZzW1IU+MLy3qG5GM/5gFXJUxpIrTtLGbSV7RsrHe+kyE8hOnTueFxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794829598;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=7FCAHSMlIJagIxDM1Al7KCUaNaZ/IrEvhQVcqS28GKE=;
	b=gNIIVDXl1jEvwp1q9so1wiGeFX30AWvEfirUockBVpdmWbBr0L9mlheIbtEP3ycr6kFg
	 EUmilj/g0nFLhHExAcEh4GPNnIvatAdXu1t4J8qC20sZOpiWUVw+x9E2wS+NfZtHv4sWH
	 8Tde5IqDVn3ytO8n+2FbYpp1F7EIJYc/rYoqX/bTs+lqHrbFgydcnx8v7vwuJJ1Wpn4DP
	 ggOV3E0sUIRegbb4ZlbMq4adKyI6LOhA48WH4Yo5UlxgO5gy0AlA2RasV6pxeL32wPRh2
	 namma99BHndk2u567oL9ejwwa0kX+iQL3wnEmhckLLD2CuqhpgZxPrrPB3nWS93TzPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Ju8FC3nu;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECAE606A31C;
	Mon, 16 Nov 2026 11:46:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2ECAE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Ju8FC3nu
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88C041713;
	Mon, 16 Nov 2026 03:46:34 -0800 (PST)
Received: from [10.2.197.99] (ewhatever.cambridge.arm.com [10.2.197.99])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E36413F632;
	Mon, 16 Nov 2026 03:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794829597; bh=wXM3hUJrXDy5hrAEupSn/9LmBSDLTT18BTQMQ+4PEks=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ju8FC3nuLWXhWC7WxZGAzcQ4/3trBymnrVn3+i6W5Kz1adJ1BhYg3C+gzVotAyQ0k
	 xkDPaOs5WRM1VAkpmoyDoJqLHgGqzbu0CkJKl/sju45wadsDFjq/vsDTpMCETn3dgt
	 1S4s233KeJBhyneVq0OG+uhwPaqC3jMRxLsY0Wvo=
Message-ID: <37a57d36-a516-4312-9e4e-fc151ab77c8b@arm.com>
Date: Mon, 16 Nov 2026 11:46:32 +0000
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
To: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
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
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20261111145758.217946-13-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/2026 14:57, Steven Price wrote:
> From: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> Register the Realm stage-2 MMU operations now that the RMM mapping
> and unmapping helpers are available. Route unmapping through the
> RMM, and use the existing fault handler for Realm memory faults.
> 
> The RMM handles TLB invalidation when stage-2 mappings change, so
> the host has no separate TLB flush to perform. Realm stage-2 does
> not support access flags, including for shared IPAs.
> 
> Dispatch stage-2 destruction according to the VM flavor. Realm
> teardown destroys non-root RTTs through RMI, so the host frees
> only the root RTT pages.

Minor nit: It may be worth splitting the destroy abstraction as a
separate patch. Otherwise looks good to me.


> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> 
