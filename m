Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792691783;
	b=W2x6DjEwtdX/DvBdCEuk/fE+ZzzaHQcdatWIH6ns06iidit0KLF9R991xA+19vsuGwEC
	 NPAYsW/jVQ2hSF1Mo3r3uNILF/H3cHVY5kzruMQpNry6LvChx8gvxtm8pyaEjL0UqnnXg
	 OAxmVyQZCGPUjcrPZhv6yo+YndECd6U9tFubwZVE88efnpUM6vISzkQ3C2O+jaItYQDiw
	 HNoC8+A+QD6MlispIqsrpebYw+GzAZez/245HEmM5aS6qNnb5m7Bew9CABAq0kl9U2Se9
	 ggIx+su8sjMiUdnjX0nMJgnsB2oEmQnEoDHXgZc4ZJWeuFhBGyqtNZ3ovtsL5XTfizw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792691783;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=/DrQ3iekP1XcE52khQzn+9lpo/N0t7Cvh1IYh3OUbJ4=;
	b=MJ4g7JxfXC2bwAPbI0qGIXm5HpmcTMOkAhh3guPqbquBHyMVC4NFK1HKD5r4x4jCsgr4
	 taDPSwIcoqoG6yrxfIy2rHmoPFNUfWagCJ8DshyNA7XVwLrcDcsYSpuXi8lJn2PfI6l+W
	 QP7/1nrQmo4dpuhMxRqest6hvOjrc07P80JfxAcWWlV0G9jKDGDo2/wWKbgjhmtLuRO/5
	 hCPakCnB4IPva+m26ubFJExqhZMkjicq1tFnGw0e/jg1NE6ItWn5udUho/jDdHCsDr5SU
	 bXkCUiS/jBn0Qv0TFhbv/2yWuz3lko2SRSbY2yYFqYY/oHkSA+jHeLsE+Qv2IDEdmfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=cta1OVwu;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B22606A31A
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 17:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0B22606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=cta1OVwu
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E47471691;
	Thu, 22 Oct 2026 10:56:17 -0700 (PDT)
Received: from [10.57.76.220] (unknown [10.57.76.220])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 614303F673;
	Thu, 22 Oct 2026 10:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792691781; bh=NET5R7K22HicShqh6xqK88Y7xW34rhsaS4821eJfymU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cta1OVwuTk+dz4DR5UUAnm5tSkPwKd0VomVHLF8g3nO00Y2VzYCTegr0RjyQvDyoM
	 BlnbZtbfz85gKKUMSAWpQZXYlAN1lXOl/TiOm+Zyht80O+vADUjoJDRV0zqGCTEgvz
	 rpkWyuJOG5De1FiwaSSAbswqhr2GxMC4xVJiTYmk=
Message-ID: <c28aad8e-c361-4e25-9fee-ea29a018c785@arm.com>
Date: Thu, 22 Oct 2026 18:56:17 +0100
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
Subject: Re: [PATCH kvmtool v3 04/21] arm64: Add GICv5 irqchip device support
To: Sascha Bischoff <sascha.bischoff@arm.com>, will@kernel.org,
 julien.thierry.kdev@gmail.com
Cc: maz@kernel.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 timothy.hayes@arm.com, Peter Maydell <peter.maydell@linaro.org>
References: <20261016153939.913764-1-sascha.bischoff@arm.com>
 <20261016153939.913764-5-sascha.bischoff@arm.com>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <20261016153939.913764-5-sascha.bischoff@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/26 16:39, Sascha Bischoff wrote:
> Add IRQCHIP_GICV5 and create KVM_DEV_TYPE_ARM_VGIC_V5 for it. GICv5
> has no distributor or redistributor MMIO frame, so omit those address
> attributes. Also omit the GICv2 PPI CPU mask from GICv5 interrupt
> specifiers.
> 
> Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
> ---
>  arm64/gic.c             | 19 +++++++++++++++----
>  arm64/include/kvm/gic.h |  1 +
>  2 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/arm64/gic.c b/arm64/gic.c
> index f8371f50..5c8a33b5 100644
> --- a/arm64/gic.c
> +++ b/arm64/gic.c
> @@ -189,6 +189,9 @@ static int gic__create_device(struct kvm *kvm, enum irqchip_type type)
>  		gic_device.type = KVM_DEV_TYPE_ARM_VGIC_V3;
>  		dist_attr.attr  = KVM_VGIC_V3_ADDR_TYPE_DIST;
>  		break;
> +	case IRQCHIP_GICV5:
> +		gic_device.type = KVM_DEV_TYPE_ARM_VGIC_V5;
> +		break;
>  	case IRQCHIP_AUTO:
>  		return -ENODEV;
>  	}
> @@ -208,15 +211,20 @@ static int gic__create_device(struct kvm *kvm, enum irqchip_type type)
>  	case IRQCHIP_GICV3:
>  		err = ioctl(gic_fd, KVM_SET_DEVICE_ATTR, &redist_attr);
>  		break;
> +	case IRQCHIP_GICV5:
> +		break;
>  	case IRQCHIP_AUTO:
>  		return -ENODEV;
>  	}
>  	if (err)
>  		goto out_err;
>  
> -	err = ioctl(gic_fd, KVM_SET_DEVICE_ATTR, &dist_attr);
> -	if (err)
> -		goto out_err;
> +	/* Only set the dist_attr for non-GICv5 */
> +	if (type != IRQCHIP_GICV5) {
> +		err = ioctl(gic_fd, KVM_SET_DEVICE_ATTR, &dist_attr);
> +		if (err)
> +			goto out_err;
> +	}

Given that we had two switch statement for irq type above, this if condition
look like complete surprise to my eye :D. Asking for third switch statement is
no go - gic__create_device() is already crowded. OTOH, I like approach of
gic__create_msi_frame(), so what do you think about some refactoring (perhaps
in separate patch), like

static int gic__set_cpu_if(enum irqchip_type type)
{
        u64 cpu_if_addr = ARM_GIC_CPUI_BASE;
        struct kvm_device_attr cpu_if_attr = {
                .group  = KVM_DEV_ARM_VGIC_GRP_ADDR,
                .attr   = KVM_VGIC_V2_ADDR_TYPE_CPU,
                .addr   = (u64)(unsigned long)&cpu_if_addr,
        };

        switch (type) {
        case IRQCHIP_GICV2M:
        case IRQCHIP_GICV2:
                return ioctl(gic_fd, KVM_SET_DEVICE_ATTR, &cpu_if_attr);
        default:        /* No CPUIF needed */
                return 0;
        }
}

static int gic__set_redist(enum irqchip_type type)
{
        struct kvm_device_attr redist_attr = {
                .group  = KVM_DEV_ARM_VGIC_GRP_ADDR,
                .attr   = KVM_VGIC_V3_ADDR_TYPE_REDIST,
                .addr   = (u64)(unsigned long)&gic_redists_base,
        };

        switch (type) {
        case IRQCHIP_GICV3_ITS:
        case IRQCHIP_GICV3:
                return ioctl(gic_fd, KVM_SET_DEVICE_ATTR, &redist_attr);
        default:        /* No redist needed */
                return 0;
        }
}

static int gic__set_dist(enum irqchip_type type)
{
        u64 dist_addr = ARM_GIC_DIST_BASE;
        struct kvm_device_attr dist_attr = {
                .group  = KVM_DEV_ARM_VGIC_GRP_ADDR,
                .addr   = (u64)(unsigned long)&dist_addr,
        };

        switch (type) {
        case IRQCHIP_GICV2M:
        case IRQCHIP_GICV2:
                dist_attr.attr  = KVM_VGIC_V2_ADDR_TYPE_DIST;
                return ioctl(gic_fd, KVM_SET_DEVICE_ATTR, &dist_attr);
        case IRQCHIP_GICV3_ITS:
        case IRQCHIP_GICV3:
                dist_attr.attr  = KVM_VGIC_V3_ADDR_TYPE_DIST;
                return ioctl(gic_fd, KVM_SET_DEVICE_ATTR, &dist_attr);
        default:        /* No dist needed */
                return 0;
        }
}

static int gic__create_device(struct kvm *kvm, enum irqchip_type type)
{
...
        gic_fd = gic_device.fd;

        err = gic__set_cpu_if(type);
        if (err)
                goto out_err;

        err = gic__set_redist(type);
        if (err)
                goto out_err;

        err = gic__set_dist(type);
        if (err)
                goto out_err;

        err = gic__create_msi_frame(kvm, type, gic_msi_base);
        if (err)
                goto out_err;
...
}

You might also notice that gic_msi_base is global, so maybe there
is no point keep it as function argument ;) 

>  
>  	err = gic__create_msi_frame(kvm, type, gic_msi_base);
>  	if (err)
> @@ -290,6 +298,8 @@ int gic__create(struct kvm *kvm, enum irqchip_type type)
>  		gic_redists_base = ARM_GIC_DIST_BASE - gic_redists_size;
>  		gic_msi_base = gic_redists_base - gic_msi_size;
>  		break;
> +	case IRQCHIP_GICV5:
> +		break;
>  	default:
>  		return -ENODEV;
>  	}
> @@ -440,7 +450,8 @@ u32 gic__get_fdt_irq_cpumask(struct kvm *kvm)
>  {
>  	/* Only for GICv2 */
>  	if (kvm->cfg.arch.irqchip == IRQCHIP_GICV3 ||
> -	    kvm->cfg.arch.irqchip == IRQCHIP_GICV3_ITS)
> +	    kvm->cfg.arch.irqchip == IRQCHIP_GICV3_ITS ||
> +	    kvm->cfg.arch.irqchip == IRQCHIP_GICV5)
>  		return 0;

Nitpick: maybe we can take advantage of order of irqchip_type and do

	/* Only for GICv2 */
	if (kvm->cfg.arch.irqchip >= IRQCHIP_GICV3)
		return 0;

Thanks
Vladimir

>  
>  	if (kvm->nrcpus > 8)
> diff --git a/arm64/include/kvm/gic.h b/arm64/include/kvm/gic.h
> index 8490cca6..630f0bbd 100644
> --- a/arm64/include/kvm/gic.h
> +++ b/arm64/include/kvm/gic.h
> @@ -29,6 +29,7 @@ enum irqchip_type {
>  	IRQCHIP_GICV2M,
>  	IRQCHIP_GICV3,
>  	IRQCHIP_GICV3_ITS,
> +	IRQCHIP_GICV5,
>  };
>  
>  struct kvm;
> -- 2.34.1
> 

