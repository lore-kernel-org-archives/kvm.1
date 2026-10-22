Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792693838;
	b=bjphUpNf0TixXDfn5LJ5GOrfinOLZKxvk5Bp+De9lpZU/QmxfLVQbq7qsXtrHL9PyZBj
	 s/EsjuxTNpQ2pILhDcSF+sN2qVyFDGMYmuXWmq+hriyODRWBxK1o8MY2jZ0h14RCBtL9r
	 GL3AM2tG1A1EMB7FISVk7w89GTLeBq3DovYRHls4w+DyW/Umc7f7f1AfVS2eBw5+Kex6M
	 MmcIT66gxLdc9g/O474MQyu3EXG4noxBJqKdMVJi5Z9sWWtL8JSBEiUgb+ngdeIcUXJRx
	 lC2/k0SfY4c8hE00vEzNa53qel06p/UzGmOMfzig3jk6pOb2FRFD2LP/c8qr29nrZ3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693838;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=wCxKDZRVKHU0nhyl1MyEQpBOlgr0Xb2zicSTlTbA3M8=;
	b=ClRmf/UBDfls14mw/1anf2DvhMap+2uZLCz0HDKzHT6FgyBPWoK7GRR1ggzMxcbxxB8o
	 OOkBwsyB+AeEGsa8IEp74FTcIi4mEVGm1qhhutVCNoz5V5PR4XfdBCOt5qHwL6uLsL6FR
	 BGYHwLozK1oE9xYeNcmzNQvVrl0sY8DkaBBQVLK9wdA+zjPo7Uk56UJyUP3ymv6kgCR0Y
	 xTjduxyqiiFamKy+UyhBVxka4gV+QWCdWrLSwVB5e59OyzGD6rwDN8/Sgk5P4x0JvC4Mq
	 vS2jaLe7N25ckdASPWXDdu6JDgj+v4SIlo8fLl9z5NSPgzcczWF5pKp6S1Az8nYV4pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=qpfpTJfm;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCD6606A321
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 18:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DCD6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=qpfpTJfm
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C8781692;
	Thu, 22 Oct 2026 11:30:33 -0700 (PDT)
Received: from [10.57.76.220] (unknown [10.57.76.220])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36E2A3F7B4;
	Thu, 22 Oct 2026 11:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792693836; bh=Ikc6yOUiVYpFyLlT69Xm9dwfB1TIc31tika94aoKgGQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qpfpTJfm+FFdy7KQPHpm1vrm1zNwH9M7/wC3kvxasTdCiTaz80aE7clleHG8sfTdc
	 IaGro8DSjpe5Llt5yXL6Ghzf43dodRy3OeCh0YmqMrH9szAf0yY8xGCjbF4GTFVi/F
	 KXfApXOwSHz06gfy2oXffZWY7MxW5ncpopOtL5hk=
Message-ID: <5ad54e6b-8005-4487-95d8-3dc512d6b32c@arm.com>
Date: Thu, 22 Oct 2026 19:30:33 +0100
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
Subject: Re: [PATCH kvmtool v3 16/21] arm64: Expose the GICv5 irqchip option
To: Sascha Bischoff <sascha.bischoff@arm.com>, will@kernel.org,
 julien.thierry.kdev@gmail.com
Cc: maz@kernel.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 timothy.hayes@arm.com, Peter Maydell <peter.maydell@linaro.org>
References: <20261016153939.913764-1-sascha.bischoff@arm.com>
 <20261016153939.913764-17-sascha.bischoff@arm.com>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <20261016153939.913764-17-sascha.bischoff@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/26 16:39, Sascha Bischoff wrote:
> Allow --irqchip=gicv5 and prefer GICv5 for automatic irqchip selection
> when the kernel supports it. The IRS and guest DT support are now in
> place.
> 
> Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
> ---
>  arm64/gic.c                         | 4 +++-
>  arm64/include/kvm/kvm-config-arch.h | 2 +-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arm64/gic.c b/arm64/gic.c
> index fe6c2059..02e55cd5 100644
> --- a/arm64/gic.c
> +++ b/arm64/gic.c
> @@ -50,6 +50,8 @@ int irqchip_parser(const struct option *opt, const char *arg, int unset)
>  		*type = IRQCHIP_GICV3;
>  	} else if (!strcmp(arg, "gicv3-its")) {
>  		*type = IRQCHIP_GICV3_ITS;
> +	} else if (!strcmp(arg, "gicv5")) {
> +		*type = IRQCHIP_GICV5;
>  	} else {
>  		pr_err("irqchip: unknown type \"%s\"\n", arg);
>  		return -1;
> @@ -293,7 +295,7 @@ int gic__create(struct kvm *kvm, enum irqchip_type type)
>  
>  	switch (type) {
>  	case IRQCHIP_AUTO:
> -		for (try = IRQCHIP_GICV3_ITS; try >= IRQCHIP_GICV2; try--) {
> +		for (try = IRQCHIP_GICV5; try >= IRQCHIP_GICV2; try--) {
>  			err = gic__create(kvm, try);
>  			if (!err)
>  				break;
> diff --git a/arm64/include/kvm/kvm-config-arch.h b/arm64/include/kvm/kvm-config-arch.h
> index d8a8ef7f..46130663 100644
> --- a/arm64/include/kvm/kvm-config-arch.h
> +++ b/arm64/include/kvm/kvm-config-arch.h
> @@ -59,7 +59,7 @@ int sve_vl_parser(const struct option *opt, const char *arg, int unset);
>  			   "transport (Deprecated: Use --virtio-transport "	\
>  			   "option instead)", virtio_transport_parser, kvm),	\
>  	OPT_CALLBACK('\0', "irqchip", &(cfg)->irqchip,				\
> -		     "[gicv2|gicv2m|gicv3|gicv3-its]",				\
> +		     "[gicv2|gicv2m|gicv3|gicv3-its|gicv5]",			\
>  		     "Type of interrupt controller to emulate in the guest",	\
>  		     irqchip_parser, NULL),					\
>  	OPT_U64('\0', "firmware-address", &(cfg)->fw_addr,			\
> -- 2.34.1
> 

FWIW,

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
