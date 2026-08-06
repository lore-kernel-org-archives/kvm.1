Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431BD47045E;
	Thu,  6 Aug 2026 11:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786017070; cv=none; b=Tilga+stOJZBO4u3xa8bxGkhEqo5GI6sVH+zS4TKtsvRI/lAbSjPlMeIMNiwcSe0VnR6IZiQwyQ5U1NeMslE71ZuKl8hvuqsiFE+lKDSmWxmNFHTqgd7EC4r/Ly3FhB1hLVQqvNqkCnbhtuMQQ0AOdM6A8gnRmjYJu9mVgD/PEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786017070; c=relaxed/simple;
	bh=7Co5UYXoO5lbl+rVZQi/bGU12JJJ75/BSuuZzGSrEd0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ToStzlHFTHsxvsXagYri7YnVsoH8mjGrmhBMJ+iHZCBaxVLQ9ppcuXeC6ejbm9V/D/R5huTRFnIZ+wn4RDTdUy8Saqr/DAzDjh+Bn0bhCU5Cr+jUFPMqqzuBvIxwCEQCDizkkLUr5HZtSkcxdd8yuDrl0Ugswwtpe5vEaPYQy4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8BxHJspdXRq3PkKAA--.11956S3;
	Thu, 06 Aug 2026 19:51:05 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJDxDccodXRqTL4lAA--.6833S2;
	Thu, 06 Aug 2026 19:51:05 +0800 (CST)
Subject: Re: [PATCH v2] LoongArch: KVM: Advertise already-supported
 capabilities
To: Tao Cui <cui.tao@linux.dev>, zhaotianrui@loongson.cn
Cc: chenhuacai@kernel.org, kernel@xen0n.name, kvm@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260805054549.287648-1-cui.tao@linux.dev>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <c1c2ca63-7999-36e3-bfdd-29e0f872c94d@loongson.cn>
Date: Thu, 6 Aug 2026 19:50:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260805054549.287648-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxDccodXRqTL4lAA--.6833S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJrWDJr47ZrWrKF1DAr18Zwc_yoW8Aw4xpr
	W8Ca1qkF48trn2vF97J395Wr4S9wn7JrWIqFyYvryUAw43Kwn5GF10krs0qF4rJw1fWFyI
	qFnYvrnYqFWDJwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jY
	SoJUUUUU=



On 2026/8/5 下午1:45, Tao Cui wrote:
> Several LoongArch KVM features are fully implemented but were never
> reported through their standard KVM_CHECK_EXTENSION probes, so userspace
> cannot discover them.  Advertise the ones that already work and have a
> real consumer:
> 
>    - KVM_CAP_STEAL_TIME: steal time works end-to-end (host-side record
>      plus guest paravirt side), and the probe returns kvm_pvtime_supported().
> 
>    - KVM_CAP_VCPU_ATTRIBUTES: per-vCPU device-attribute ioctls are
>      implemented (CPUCFG, PVTIME control); advertise the discovery cap.
> 
> This adds no new functionality; it only makes existing features
> discoverable via the standard probe.
> 
> Signed-off-by: Tao Cui <cui.tao@linux.dev>
> ---
> Changes in v2:
>    - Drop KVM_CAP_IRQFD_RESAMPLE: the only consumer is VFIO INTx, which
>      needs IOMMU/VFIO not yet available on LoongArch.
>    - Drop KVM_CAP_VM_GPA_BITS: the cap implies a GPA-width setter that
>      LoongArch does not implement.
> 
>   arch/loongarch/kvm/vm.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
> index 1317c718f896..0a51931d6f6e 100644
> --- a/arch/loongarch/kvm/vm.c
> +++ b/arch/loongarch/kvm/vm.c
> @@ -122,6 +122,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>   	case KVM_CAP_IOEVENTFD:
>   	case KVM_CAP_MP_STATE:
>   	case KVM_CAP_SET_GUEST_DEBUG:
> +	case KVM_CAP_VCPU_ATTRIBUTES:
>   		r = 1;
>   		break;
>   	case KVM_CAP_NR_VCPUS:
> @@ -136,6 +137,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>   	case KVM_CAP_NR_MEMSLOTS:
>   		r = KVM_USER_MEM_SLOTS;
>   		break;
> +	case KVM_CAP_STEAL_TIME:
> +		r = kvm_pvtime_supported();
> +		break;
>   	default:
>   		r = 0;
>   		break;
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>

