Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793650458;
	b=srViXMRewtqHGoIfYxp6e4vIg5IQ5KrWetGg66oU33qXCQL/+DEmoew4XFVItXPCN8WS
	 z9mS7wYIKO7ln6n1V/CeN1frzJz1v/SRbz4isvp9PFxjziupyJ+O3BmUKeyJtQITOwpnj
	 3CCNu9NOQqbbC1vxog6odTA7QB72jcMH402hVqOLddtZl8/mrqQQ/3J6Q3dzaigzenUSm
	 UPYSmbxFpoP+AHwqmetTOOGutOnQL14ImibyXGpDdfxez7nJ4NlcfqV6f4SMi1R/sXYQr
	 9m0WNDbBm88HC6yPOLDE9JDNBZxvJJh5a5u4DCnFjQIwH2L3umGqTc5NTDqFQczKQDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650458;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=yV4gHX4gReP9QDDnhEoPhM7XeCQPJJESkGHWythfJxA=;
	b=y1AZsVyaHdmYLlkUQ9gvbtUk0OLm8HOIV+RObudlw97Bnf0nPfHFhU9vE4cIui9lD26y
	 iAqA8MVbCnXcWB8HLWG48NpfR5q3QoCJJCtJyZ91OAZYjll7ogMC4yJtRHT/kSRMzOhI+
	 yx1Zc20s0BaqNeFUMesfIPkWLx4C6+4YiD5bVgcfbo19iJL3+Cs61vxx7YtN1fA1wsXdM
	 XCU3L++bLqyAQdI+8+fBOQpKGz8txaj3RKjy9xBzkYLDc5qko6y82fjrNPNOX/0gdocmo
	 2BX/ryqUtY7Y91BQmiXpTAshM3Yto+dgj1eOyoYXVcSoiOewaYSzwIdWW4k+9JitFRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=l51KDHrw;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0EF606A327
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 20:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC0EF606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=l51KDHrw
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F94C1691;
	Mon,  2 Nov 2026 12:14:14 -0800 (PST)
Received: from [10.57.89.36] (unknown [10.57.89.36])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F03E13F59E;
	Mon,  2 Nov 2026 12:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793650457; bh=1Hr3ZVUtIeW7dgD+1nWZQR0cyBw0kI0w/o/R3hrCSFw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=l51KDHrwmwrkM4qhYoShz4+k594vXDVvinYdi4cFl7638Y9Sb7hCNWWxBPCc9n9xu
	 BG7M5j+HTAeRY9yOtkHW17m76hlZVJOuKis6UXm2Zny7GElwPaPmdz9HQYoUhR/lsC
	 dUE29kpvaQ0+/no1qvVK/fPIOKjTZ9taEwobcA4I=
Message-ID: <2c6ca334-f188-48fc-8636-c10cacd4c37f@arm.com>
Date: Mon, 2 Nov 2026 20:14:14 +0000
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
To: Vladimir Murzin <vladimir.murzin@arm.com>, will@kernel.org,
 julien.thierry.kdev@gmail.com
Cc: maz@kernel.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 timothy.hayes@arm.com, Peter Maydell <peter.maydell@linaro.org>
References: <20261016153939.913764-1-sascha.bischoff@arm.com>
 <20261016153939.913764-5-sascha.bischoff@arm.com>
 <c28aad8e-c361-4e25-9fee-ea29a018c785@arm.com>
Content-Language: en-GB
From: Sascha Bischoff <sascha.bischoff@arm.com>
In-Reply-To: <c28aad8e-c361-4e25-9fee-ea29a018c785@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/10/2026 18:56, Vladimir Murzin wrote:
> On 10/16/26 16:39, Sascha Bischoff wrote:
>> Add IRQCHIP_GICV5 and create KVM_DEV_TYPE_ARM_VGIC_V5 for it. GICv5
>> has no distributor or redistributor MMIO frame, so omit those address
>> attributes. Also omit the GICv2 PPI CPU mask from GICv5 interrupt
>> specifiers.
>>
>> Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
>> ---
>>   arm64/gic.c             | 19 +++++++++++++++----
>>   arm64/include/kvm/gic.h |  1 +
>>   2 files changed, 16 insertions(+), 4 deletions(-)
>>
>> diff --git a/arm64/gic.c b/arm64/gic.c
>> index f8371f50..5c8a33b5 100644
>> --- a/arm64/gic.c
>> +++ b/arm64/gic.c
>> @@ -189,6 +189,9 @@ static int gic__create_device(struct kvm *kvm, enum irqchip_type type)
>>   		gic_device.type = KVM_DEV_TYPE_ARM_VGIC_V3;
>>   		dist_attr.attr  = KVM_VGIC_V3_ADDR_TYPE_DIST;
>>   		break;
>> +	case IRQCHIP_GICV5:
>> +		gic_device.type = KVM_DEV_TYPE_ARM_VGIC_V5;
>> +		break;
>>   	case IRQCHIP_AUTO:
>>   		return -ENODEV;
>>   	}
>> @@ -208,15 +211,20 @@ static int gic__create_device(struct kvm *kvm, enum irqchip_type type)
>>   	case IRQCHIP_GICV3:
>>   		err = ioctl(gic_fd, KVM_SET_DEVICE_ATTR, &redist_attr);
>>   		break;
>> +	case IRQCHIP_GICV5:
>> +		break;
>>   	case IRQCHIP_AUTO:
>>   		return -ENODEV;
>>   	}
>>   	if (err)
>>   		goto out_err;
>>   
>> -	err = ioctl(gic_fd, KVM_SET_DEVICE_ATTR, &dist_attr);
>> -	if (err)
>> -		goto out_err;
>> +	/* Only set the dist_attr for non-GICv5 */
>> +	if (type != IRQCHIP_GICV5) {
>> +		err = ioctl(gic_fd, KVM_SET_DEVICE_ATTR, &dist_attr);
>> +		if (err)
>> +			goto out_err;
>> +	}

Hi Valdimir,

> 
> Given that we had two switch statement for irq type above, this if condition
> look like complete surprise to my eye :D. Asking for third switch statement is
> no go - gic__create_device() is already crowded. OTOH, I like approach of
> gic__create_msi_frame(), so what do you think about some refactoring (perhaps
> in separate patch), like
> 
> static int gic__set_cpu_if(enum irqchip_type type)
> {
>          u64 cpu_if_addr = ARM_GIC_CPUI_BASE;
>          struct kvm_device_attr cpu_if_attr = {
>                  .group  = KVM_DEV_ARM_VGIC_GRP_ADDR,
>                  .attr   = KVM_VGIC_V2_ADDR_TYPE_CPU,
>                  .addr   = (u64)(unsigned long)&cpu_if_addr,
>          };
> 
>          switch (type) {
>          case IRQCHIP_GICV2M:
>          case IRQCHIP_GICV2:
>                  return ioctl(gic_fd, KVM_SET_DEVICE_ATTR, &cpu_if_attr);
>          default:        /* No CPUIF needed */
>                  return 0;
>          }
> }
> 
> static int gic__set_redist(enum irqchip_type type)
> {
>          struct kvm_device_attr redist_attr = {
>                  .group  = KVM_DEV_ARM_VGIC_GRP_ADDR,
>                  .attr   = KVM_VGIC_V3_ADDR_TYPE_REDIST,
>                  .addr   = (u64)(unsigned long)&gic_redists_base,
>          };
> 
>          switch (type) {
>          case IRQCHIP_GICV3_ITS:
>          case IRQCHIP_GICV3:
>                  return ioctl(gic_fd, KVM_SET_DEVICE_ATTR, &redist_attr);
>          default:        /* No redist needed */
>                  return 0;
>          }
> }
> 
> static int gic__set_dist(enum irqchip_type type)
> {
>          u64 dist_addr = ARM_GIC_DIST_BASE;
>          struct kvm_device_attr dist_attr = {
>                  .group  = KVM_DEV_ARM_VGIC_GRP_ADDR,
>                  .addr   = (u64)(unsigned long)&dist_addr,
>          };
> 
>          switch (type) {
>          case IRQCHIP_GICV2M:
>          case IRQCHIP_GICV2:
>                  dist_attr.attr  = KVM_VGIC_V2_ADDR_TYPE_DIST;
>                  return ioctl(gic_fd, KVM_SET_DEVICE_ATTR, &dist_attr);
>          case IRQCHIP_GICV3_ITS:
>          case IRQCHIP_GICV3:
>                  dist_attr.attr  = KVM_VGIC_V3_ADDR_TYPE_DIST;
>                  return ioctl(gic_fd, KVM_SET_DEVICE_ATTR, &dist_attr);
>          default:        /* No dist needed */
>                  return 0;
>          }
> }
> 
> static int gic__create_device(struct kvm *kvm, enum irqchip_type type)
> {
> ...
>          gic_fd = gic_device.fd;
> 
>          err = gic__set_cpu_if(type);
>          if (err)
>                  goto out_err;
> 
>          err = gic__set_redist(type);
>          if (err)
>                  goto out_err;
> 
>          err = gic__set_dist(type);
>          if (err)
>                  goto out_err;
> 
>          err = gic__create_msi_frame(kvm, type, gic_msi_base);
>          if (err)
>                  goto out_err;
> ...
> }
> > You might also notice that gic_msi_base is global, so maybe there
> is no point keep it as function argument ;)
> 

I think that this is a great suggestion. I've made the change and the 
series is so much better because of it. It is a lot more readable now, 
even if some of these gic__set_x() functions only do one thing, it helps 
to separate them out into something much more readable.

Thank you for suggesting this.

>>   
>>   	err = gic__create_msi_frame(kvm, type, gic_msi_base);
>>   	if (err)
>> @@ -290,6 +298,8 @@ int gic__create(struct kvm *kvm, enum irqchip_type type)
>>   		gic_redists_base = ARM_GIC_DIST_BASE - gic_redists_size;
>>   		gic_msi_base = gic_redists_base - gic_msi_size;
>>   		break;
>> +	case IRQCHIP_GICV5:
>> +		break;
>>   	default:
>>   		return -ENODEV;
>>   	}
>> @@ -440,7 +450,8 @@ u32 gic__get_fdt_irq_cpumask(struct kvm *kvm)
>>   {
>>   	/* Only for GICv2 */
>>   	if (kvm->cfg.arch.irqchip == IRQCHIP_GICV3 ||
>> -	    kvm->cfg.arch.irqchip == IRQCHIP_GICV3_ITS)
>> +	    kvm->cfg.arch.irqchip == IRQCHIP_GICV3_ITS ||
>> +	    kvm->cfg.arch.irqchip == IRQCHIP_GICV5)
>>   		return 0;
> 
> Nitpick: maybe we can take advantage of order of irqchip_type and do
> 
> 	/* Only for GICv2 */
> 	if (kvm->cfg.arch.irqchip >= IRQCHIP_GICV3)
> 		return 0;

Done.

> 
> Thanks
> Vladimir
> 
>>   
>>   	if (kvm->nrcpus > 8)
>> diff --git a/arm64/include/kvm/gic.h b/arm64/include/kvm/gic.h
>> index 8490cca6..630f0bbd 100644
>> --- a/arm64/include/kvm/gic.h
>> +++ b/arm64/include/kvm/gic.h
>> @@ -29,6 +29,7 @@ enum irqchip_type {
>>   	IRQCHIP_GICV2M,
>>   	IRQCHIP_GICV3,
>>   	IRQCHIP_GICV3_ITS,
>> +	IRQCHIP_GICV5,
>>   };
>>   
>>   struct kvm;
>> -- 2.34.1
>>
> 

Thanks,
Sascha
