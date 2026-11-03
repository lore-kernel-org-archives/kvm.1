Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706463;
	b=Vw7Mzgp2jEhcM+4KK0xR3vhV/+zIj8xE84YbnaSlJAcHnRsMn5PuslEW1szg1fREkTVt
	 3/wDTF92leuVO4dcUDXHmIFqdgnXvthulHM73Iao4H3IMAmEUIN/vfC2EELFAtkRMlwch
	 rpGQncEqVqFkbN6GmxJJG9Cmsscb8D1G/A7mmtbxt17lFsLWbRxC8kNahlCEDcDV9yYYO
	 hOTBTpGnxNgyEOM9cRmiMrLfS5lzOWmBFaZ3KObq2QPWrcJM7YWO3tOs/NpJyVvRuPSWG
	 sAo3wwWcTwT0ItG1Pnj3zwDHzQjx1SFhCnGVbbgJHiLCPfjGHYqIP3HPb36TeYmOChw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706463;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=YJMeRkCmn9gDBAVzQVXW/T4MGrrHZj9tyHFg1Pygn9A=;
	b=fxH3YbUcvuXMXoI/xHGo7p8Jzlxy4K0im5wCeKfyLBTYBu7Ojw1QGfGh3X10Q0VvDwMF
	 c8A0bK774Ha2+njXN74gBREw0FyNOQ8tmEI8Ox31zThoHvD6ChcgbCPhzif2bMk6nh5pi
	 IG6ZCjpSuSzM0EzRmFf7nkZHQl9SYv9LxnbeuB6i4L4esB/QpTncszKvsvny1FCwVjm6x
	 xWO5UfyIMVlRyxcHu9gF0GIc/emzy2utcqZyIJL3EbnCZUg/VNd9hYS4pahNbGYzouxvk
	 R8d7GGr1WH6H8glac7xJfEyBvry3h7/rkUEiYAQSp6LjhyLsvZRW+sjodd5hByghgPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=VzHG9OPV;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EDD606D804;
	Tue,  3 Nov 2026 11:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31EDD606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=VzHG9OPV
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12C581576;
	Tue,  3 Nov 2026 03:47:39 -0800 (PST)
Received: from [10.57.66.79] (unknown [10.57.66.79])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2825D3F632;
	Tue,  3 Nov 2026 03:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793706462; bh=zSgYiWzcO24ysSZVXSXH948NdVzqg3BzhoQrCEIVTso=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VzHG9OPVGljGbtk8/efCtKN+jXXjyAuI9shD1Hi8lG9XoKy/j+wZrORgQYX3SWvdH
	 TbbrdwV0WQUSkvcAtUMG6jZasRllCf8il54W8y5TJkprOXoSJzMc9YGDLV6rX2V7Dt
	 djZpfn3ciOcg5sMuhjPPTBIf3cbJgogUR7N4zkIU=
Message-ID: <f2cb2959-f56d-414c-b4a5-c0656a44f57d@arm.com>
Date: Tue, 3 Nov 2026 11:47:36 +0000
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
Subject: Re: [PATCH 04/11] KVM: arm64: CCA: Check for LPA2 support and SHA-256
Content-Language: en-GB
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
 Lorenzo Pieralisi <lpieralisi@kernel.org>
References: <20261102141304.126883-1-steven.price@arm.com>
 <20261102141304.126883-5-steven.price@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20261102141304.126883-5-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Steven

On 02/11/2026 14:12, Steven Price wrote:
> If KVM has enabled LPA2 support then check that the RMM also supports
> it. If there is a mismatch then disable support for realm guests as the
> VMM may attempt to create a guest which is incompatible with the RMM.
> 
> Also check for SHA-256 support in the RMM as to begin with we only
> support SHA-256 based measurements. This can be relaxed in the future.


This could be merged with the patch 3.


> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Steven Price <steven.price@arm.com>


> ---
>   arch/arm64/kvm/rmi.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/kvm/rmi.c b/arch/arm64/kvm/rmi.c
> index 9d118768550d..5b07beff8bc9 100644
> --- a/arch/arm64/kvm/rmi.c
> +++ b/arch/arm64/kvm/rmi.c
> @@ -6,8 +6,30 @@
>   #include <linux/arm-rmi-cmds.h>
>   #include <linux/kvm_host.h>
>   
> +#include <asm/kvm_pgtable.h>
>   #include <asm/virt.h>
>   
> +static bool rmi_has_feature(int reg, unsigned long feature)
> +{
> +	return !!u64_get_bits(rmi_feat_reg(reg), feature);
> +}
> +

minor nit: Do we see this useful for others (e.g., DA) ? May be we could
move this to the include/linux/arm-rmi-cmds.h ?

May be we could even make the above a macro, something like


#define rmi_has_feature(reg, feat)
	u64_get_bits(rmi_feat_reg(reg), RMI_FEATURE_REGISTER_#reg _#feat)



Cheers
Suzuki

> +static int rmm_check_features(void)
> +{
> +	if (kvm_lpa2_is_enabled() &&
> +	    !rmi_has_feature(0, RMI_FEATURE_REGISTER_0_LPA2)) {
> +		kvm_err("RMM doesn't support LPA2\n");
> +		return -ENXIO;
> +	}
> +
> +	if (!rmi_has_feature(1, RMI_FEATURE_REGISTER_1_HASH_SHA_256)) {
> +		kvm_err("RMM doesn't support SHA-256 measurements\n");
> +		return -ENXIO;
> +	}
> +
> +	return 0;
> +}
> +
>   void kvm_init_rmi(void)
>   {
>   	if (kvm_get_mode() != KVM_MODE_RMM)
> @@ -16,5 +38,8 @@ void kvm_init_rmi(void)
>   	if (!is_rmi_available())
>   		return;
>   
> +	if (rmm_check_features())
> +		return;
> +
>   	/* Future patch will enable static branch kvm_rmi_is_available */
>   }

