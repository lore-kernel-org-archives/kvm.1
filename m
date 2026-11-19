Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795081243;
	b=vuYi0VTd/PnUiPjSSv/BqdhyMbM+2TY3y5eLChSZdoOv7BCweR30kPJiQobZFrFh81LE
	 ZbYPJJEaPoPkciN/E77XrO2ULS7cepnXwWCWhoBg2Ft+QI8gcSQrYDp1kzYymm2pykg9f
	 Pa0p0x6f4zgN0CSmq6ca90SBPo5L3xj47KirVlqkHhEpDp6lrYktTuTeo0eS51sNBs76x
	 prBy2XM+kVPXNqd4G505Ab5r5dy446CxbyCFr+HHq1cpj5TIgjhZVLFEb/FfDkFH0UquW
	 bYRW441MDLUeM7/uXoX9A907TJqgAq8GZ//Ajo3+LgeoVoJO1w/qvtj7c4cI9CadwVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795081243;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=FMkxKUtJmddBDjY85NzCM0i5sDrxXnUOJOgPzj5R0NI=;
	b=MOc/lJ24uTHs2pvoLzQdLsKMIqFAF7BcKV4/bkjSCFsHEUBe2oL5dNg+tnNZZ+MZTZLV
	 Z/BvRPKsqA2L9pmqII7AjD0CCPtCr3AmNQfOH5rZ1/DGZdUxOVs6/DSTVX6l/W0CSRWQ7
	 PCh98Sk3JQ+0Lzendbf8d55mhd1LD2aiZqfvSk0w6EPZ7VFZ0db6esSM1tEN+Lm0Sk0nX
	 +iqV27EfsMV98Z93OAhPKPSdsYg4nbPqpLI4oedA5hteqievHF8wP5WGzJR+m4s/Z3Ost
	 Di2/7viva8oN7D68l+TUsA9t8RdxjnvjiufYkxv2pp25XgBYHvL+ZI7P7fWYoLZa7IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=pEol8JRM;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7D9606A324
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 09:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA7D9606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=pEol8JRM
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16ED81575;
	Thu, 19 Nov 2026 01:40:38 -0800 (PST)
Received: from [10.0.154.42] (e121487-lin.cambridge.arm.com [10.0.154.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DEA63F882;
	Thu, 19 Nov 2026 01:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795081241; bh=a3G5hfSBILwd9EwEB9393QV7mSCJMA51FdgnpKmpIQA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pEol8JRMP4xQQYfdi8P7Wvm31nzISRXbi10A8eGYXCYPJAA8nGCmJDH7ujNLkB1FZ
	 VJMXgRyU+XPv5iaLARArCyTunw83EpgkNXTgetkI+VRD/ob8ekkdl0g8F2wDXcjO9i
	 qfTPpuFcCb+86Xq6H4AKfpv55EQ+8yCmBIif1pMQ=
Message-ID: <7eb028fc-b647-49d2-9528-7d79bc4e4f29@arm.com>
Date: Thu, 19 Nov 2026 09:40:37 +0000
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
Subject: Re: [PATCH kvmtool v5 09/23] arm64: Configure the GICv5 IRS
To: Sascha Bischoff <sascha.bischoff@arm.com>, will@kernel.org,
 julien.thierry.kdev@gmail.com
Cc: maz@kernel.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 timothy.hayes@arm.com, Peter Maydell <peter.maydell@linaro.org>
References: <20261118175755.1946977-1-sascha.bischoff@arm.com>
 <20261118175755.1946977-10-sascha.bischoff@arm.com>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <20261118175755.1946977-10-sascha.bischoff@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/26 17:57, Sascha Bischoff wrote:
> Place the IRS CONFIG and SETLPI frames in two 64 KiB regions below the
> guest AXI area, and pass the IRS base to KVM through
> KVM_VGIC_V5_ADDR_TYPE_IRS.
> 
> The GICv5 NR_IRQS attribute counts SPIs without the 32 SGI/PPI lines
> included for earlier GICs. Use that count for GICv5 while retaining
> the existing count for GICv2/v3. Allow zero-based GICv5 IRQ numbers
> when setting the level through KVM_IRQ_LINE.
> 
> Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>
> Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
> ---
>  arm64/gic.c                  | 30 ++++++++++++++++++++++++++++--
>  arm64/include/kvm/kvm-arch.h |  8 ++++++++
>  2 files changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/arm64/gic.c b/arm64/gic.c
> index 58644036..5034b034 100644
> --- a/arm64/gic.c
> +++ b/arm64/gic.c
> @@ -18,6 +18,7 @@
>  static int gic_fd = -1;
>  static u64 gic_redists_base;
>  static u64 gic_redists_size;
> +static u64 gicv5_irs_base;
>  static u64 gic_msi_base;
>  static u64 gic_msi_size = 0;
>  static bool vgic_is_init = false;
> @@ -201,6 +202,22 @@ static int gic__set_redist(enum irqchip_type type)
>  	}
>  }
>  
> +static int gic__set_irs(enum irqchip_type type)
> +{
> +	struct kvm_device_attr irs_attr = {
> +		.group	= KVM_DEV_ARM_VGIC_GRP_ADDR,
> +		.attr	= KVM_VGIC_V5_ADDR_TYPE_IRS,
> +		.addr	= (u64)(unsigned long)&gicv5_irs_base,
> +	};
> +
> +	switch (type) {
> +	case IRQCHIP_GICV5:
> +		return ioctl(gic_fd, KVM_SET_DEVICE_ATTR, &irs_attr);
> +	default:	/* No IRS needed */
> +		return 0;
> +	}
> +}
> +
>  static int gic__set_dist(enum irqchip_type type)
>  {
>  	u64 dist_addr = ARM_GIC_DIST_BASE;
> @@ -291,6 +308,10 @@ static int gic__create_device(struct kvm *kvm, enum irqchip_type type)
>  	if (err)
>  		goto out_err;
>  
> +	err = gic__set_irs(type);
> +	if (err)
> +		goto out_err;
> +
>  	err = gic__set_dist(type);
>  	if (err)
>  		goto out_err;
> @@ -376,6 +397,7 @@ int gic__create(struct kvm *kvm, enum irqchip_type type)
>  		gic_msi_base = gic_redists_base - gic_msi_size;
>  		break;
>  	case IRQCHIP_GICV5:
> +		gicv5_irs_base = ARM_GICV5_IRS_BASE;
>  		break;
>  	default:
>  		return -ENODEV;
> @@ -397,8 +419,9 @@ static int gic__init_gic(struct kvm *kvm)
>  	int ret;
>  
>  	int lines = irq__get_nr_allocated_lines();
> -	u32 nr_irqs = ALIGN(lines, 32) + GIC_SPI_IRQ_BASE;
>  	u32 maint_irq = GIC_PPI_IRQ_BASE + GIC_MAINT_IRQ;
> +	u32 nr_irqs = max(ALIGN(lines, 32), 32);
> +
>  	struct kvm_device_attr nr_irqs_attr = {
>  		.group	= KVM_DEV_ARM_VGIC_GRP_NR_IRQS,
>  		.addr	= (u64)(unsigned long)&nr_irqs,
> @@ -412,6 +435,8 @@ static int gic__init_gic(struct kvm *kvm)
>  		.attr	= KVM_DEV_ARM_VGIC_CTRL_INIT,
>  	};
>  
> +	nr_irqs += gic__get_spi_base();
> +
>  	/*
>  	 * If we didn't use the KVM_CREATE_DEVICE method, KVM will
>  	 * give us some default number of interrupts. The GIC initialization
> @@ -540,12 +565,13 @@ u32 gic__get_fdt_irq_cpumask(struct kvm *kvm)
>  
>  void kvm__irq_line(struct kvm *kvm, int irq, int level)
>  {
> +	int spi_base = gic__get_spi_base();
>  	struct kvm_irq_level irq_level = {
>  		.irq	= KVM_IRQCHIP_IRQ(irq),
>  		.level	= !!level,
>  	};
>  
> -	if (irq < GIC_SPI_IRQ_BASE || irq > GIC_MAX_IRQ)
> +	if (irq < spi_base || irq > GIC_MAX_IRQ)
>  		pr_warning("Ignoring invalid GIC IRQ %d", irq);
>  	else if (ioctl(kvm->vm_fd, KVM_IRQ_LINE, &irq_level) < 0)
>  		pr_warning("Could not KVM_IRQ_LINE for irq %d", irq);
> diff --git a/arm64/include/kvm/kvm-arch.h b/arm64/include/kvm/kvm-arch.h
> index e7dd5269..94140364 100644
> --- a/arm64/include/kvm/kvm-arch.h
> +++ b/arm64/include/kvm/kvm-arch.h
> @@ -57,6 +57,14 @@
>  #define ARM_GIC_CPUI_SIZE	0x20000
>  
>  
> +/* GICv5 IRS CONFIG and SETLPI frames occupy the end of the MMIO area. */
> +#define ARM_GICV5_IRS_BASE		(ARM_AXI_AREA - ARM_GICV5_IRS_SIZE)
> +#define ARM_GICV5_IRS_SIZE		(ARM_GICV5_IRS_CONFIG_SIZE + ARM_GICV5_IRS_SETLPI_SIZE)
> +#define ARM_GICV5_IRS_CONFIG_BASE	ARM_GICV5_IRS_BASE
> +#define ARM_GICV5_IRS_CONFIG_SIZE	0x10000
> +#define ARM_GICV5_IRS_SETLPI_BASE	(ARM_GICV5_IRS_CONFIG_BASE + ARM_GICV5_IRS_CONFIG_SIZE)
> +#define ARM_GICV5_IRS_SETLPI_SIZE	0x10000
> +
>  #define KVM_PCI_CFG_AREA	ARM_AXI_AREA
>  #define ARM_PCI_CFG_SIZE	(1ULL << 28)
>  #define KVM_PCI_MMIO_AREA	(KVM_PCI_CFG_AREA + ARM_PCI_CFG_SIZE)
> -- 2.34.1
> 

FWIW,

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
