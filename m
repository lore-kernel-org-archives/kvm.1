Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A2623ED60;
	Wed, 25 Mar 2026 01:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774403690; cv=none; b=PzlcA3dO6nuwsQy/BX5h+98mU/4QxhDkoCQPBF/yF3lpORbZZYTVGvGl6qQZ2ExHe86lXF1uAGZemR8SMg+8noPiRo6QtP/VL6LcR62T1iNX/3NyjTRivVERc2GaX3U0YeyPxa9oeIdtN/v6ehemXvgP9AnqrsbQIv76NRhMLlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774403690; c=relaxed/simple;
	bh=8WDJIl5koT0xHhXStj1ZYPgZEEfG0k5hGGAeiv0JGk0=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=gZ2dkBcJ/piAxMwSzPckLAL5c1H9zUwrae5NY8LjM+JBYNQa64RFzoSir122lYa26unrhM81aXIgxasQCnTdKfGhKnQ3ymJXlZeM5siCBsH1XxVA9ckANBt1BZt10Rwilwf39BnfLxb7FBgEH7PSrZiHpn2eHCId0VsB6jRMyQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8DxMMBjQMNpG2weAA--.27959S3;
	Wed, 25 Mar 2026 09:54:43 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJCx_8JhQMNp5LJcAA--.46288S3;
	Wed, 25 Mar 2026 09:54:42 +0800 (CST)
Subject: Re: [PATCH] LoongArch: KVM: Set max used FPU type with FPU exception
From: Bibo Mao <maobibo@loongson.cn>
To: Tianrui Zhao <zhaotianrui@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name, kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260323034034.3465072-1-maobibo@loongson.cn>
Message-ID: <d539cf62-c541-ba2e-7810-38ed85c12a62@loongson.cn>
Date: Wed, 25 Mar 2026 09:51:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260323034034.3465072-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCx_8JhQMNp5LJcAA--.46288S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Wr4xWw1UJw17Aw15GF4kGrX_yoW7XFW7pF
	Wxuw4DZa1rGF1Skw17Kw1q9r1jvrZ7WryxXFyava4fGrn0q34rZr40kr98uF98Jw1Fya92
	qFyrury5Cay8JwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-e5UU
	UUU==

another more proactive method is to enabled FPU type with max VM 
supported, rather than ever used.

It is more direct and simpler, FPU none --> LASX, no middle state FPU 
--> LASX or LSX --> LASX.

Regards
Bibo Mao

On 2026/3/23 上午11:40, Bibo Mao wrote:
> With FPU save and restore flow, the cost is the same with different
> FPU width 8/16/32 bytes, whatever from CPU cycle and cache line impaction.
> 
> Here is to enable FPU with max used type, for example if application
> ever uses LASX instrction, enable FPU with LASX type even with FPU
> exeception. So it can avoid possible LSX/LASX exception in future.
> 
> With context switch microbench which may touch FPU and LASX, there is 9%
> improvement when halt_poll_ns is disabled. The command is
> "./context --test=pipe" and source code located at:
>    https://github.com/bibo-mao/context_switch/blob/main/context.c
> 
> Original     Wih patch      improvement
> 75232        82440          9%
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   arch/loongarch/include/asm/kvm_host.h |  1 +
>   arch/loongarch/kvm/exit.c             |  6 +++---
>   arch/loongarch/kvm/vcpu.c             | 25 ++++++++++---------------
>   3 files changed, 14 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
> index 19eb5e5c3984..7d739fd5cda6 100644
> --- a/arch/loongarch/include/asm/kvm_host.h
> +++ b/arch/loongarch/include/asm/kvm_host.h
> @@ -203,6 +203,7 @@ struct kvm_vcpu_arch {
>   	/* Which auxiliary state is loaded (KVM_LARCH_*) */
>   	unsigned int aux_inuse;
>   	unsigned int aux_ldtype;
> +	unsigned int aux_used;
>   
>   	/* FPU state */
>   	struct loongarch_fpu fpu FPU_ALIGN;
> diff --git a/arch/loongarch/kvm/exit.c b/arch/loongarch/kvm/exit.c
> index da0ad89f2eb7..da8e330c8b20 100644
> --- a/arch/loongarch/kvm/exit.c
> +++ b/arch/loongarch/kvm/exit.c
> @@ -754,7 +754,7 @@ static int kvm_handle_fpu_disabled(struct kvm_vcpu *vcpu, int ecode)
>   		return RESUME_HOST;
>   	}
>   
> -	vcpu->arch.aux_ldtype = KVM_LARCH_FPU;
> +	vcpu->arch.aux_ldtype = vcpu->arch.aux_used | KVM_LARCH_FPU;
>   	kvm_make_request(KVM_REQ_AUX_LOAD, vcpu);
>   
>   	return RESUME_GUEST;
> @@ -796,7 +796,7 @@ static int kvm_handle_lsx_disabled(struct kvm_vcpu *vcpu, int ecode)
>   	if (!kvm_guest_has_lsx(&vcpu->arch))
>   		kvm_queue_exception(vcpu, EXCCODE_INE, 0);
>   	else {
> -		vcpu->arch.aux_ldtype = KVM_LARCH_LSX;
> +		vcpu->arch.aux_ldtype = vcpu->arch.aux_used | KVM_LARCH_LSX;
>   		kvm_make_request(KVM_REQ_AUX_LOAD, vcpu);
>   	}
>   
> @@ -816,7 +816,7 @@ static int kvm_handle_lasx_disabled(struct kvm_vcpu *vcpu, int ecode)
>   	if (!kvm_guest_has_lasx(&vcpu->arch))
>   		kvm_queue_exception(vcpu, EXCCODE_INE, 0);
>   	else {
> -		vcpu->arch.aux_ldtype = KVM_LARCH_LASX;
> +		vcpu->arch.aux_ldtype = vcpu->arch.aux_used | KVM_LARCH_LASX;
>   		kvm_make_request(KVM_REQ_AUX_LOAD, vcpu);
>   	}
>   
> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index 8810fcd7e26e..0a111c74a330 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
> @@ -239,23 +239,14 @@ static void kvm_late_check_requests(struct kvm_vcpu *vcpu)
>   		}
>   
>   	if (kvm_check_request(KVM_REQ_AUX_LOAD, vcpu)) {
> -		switch (vcpu->arch.aux_ldtype) {
> -		case KVM_LARCH_FPU:
> -			kvm_own_fpu(vcpu);
> -			break;
> -		case KVM_LARCH_LSX:
> -			kvm_own_lsx(vcpu);
> -			break;
> -		case KVM_LARCH_LASX:
> +		if (vcpu->arch.aux_ldtype & KVM_LARCH_LASX)
>   			kvm_own_lasx(vcpu);
> -			break;
> -		case KVM_LARCH_LBT:
> +		else if (vcpu->arch.aux_ldtype & KVM_LARCH_LSX)
> +			kvm_own_lsx(vcpu);
> +		else if (vcpu->arch.aux_ldtype & KVM_LARCH_FPU)
> +			kvm_own_fpu(vcpu);
> +		else if (vcpu->arch.aux_ldtype == KVM_LARCH_LBT)
>   			kvm_own_lbt(vcpu);
> -			break;
> -		default:
> -			break;
> -		}
> -
>   		vcpu->arch.aux_ldtype = 0;
>   	}
>   }
> @@ -956,6 +947,7 @@ static int kvm_set_one_reg(struct kvm_vcpu *vcpu,
>   			break;
>   		case KVM_REG_LOONGARCH_VCPU_RESET:
>   			vcpu->arch.st.guest_addr = 0;
> +			vcpu->arch.aux_used = 0;
>   			memset(&vcpu->arch.irq_pending, 0, sizeof(vcpu->arch.irq_pending));
>   			memset(&vcpu->arch.irq_clear, 0, sizeof(vcpu->arch.irq_clear));
>   
> @@ -1384,6 +1376,7 @@ void kvm_own_fpu(struct kvm_vcpu *vcpu)
>   
>   	kvm_restore_fpu(&vcpu->arch.fpu);
>   	vcpu->arch.aux_inuse |= KVM_LARCH_FPU;
> +	vcpu->arch.aux_used |= KVM_LARCH_FPU;
>   	trace_kvm_aux(vcpu, KVM_TRACE_AUX_RESTORE, KVM_TRACE_AUX_FPU);
>   }
>   
> @@ -1412,6 +1405,7 @@ int kvm_own_lsx(struct kvm_vcpu *vcpu)
>   
>   	trace_kvm_aux(vcpu, KVM_TRACE_AUX_RESTORE, KVM_TRACE_AUX_LSX);
>   	vcpu->arch.aux_inuse |= KVM_LARCH_LSX | KVM_LARCH_FPU;
> +	vcpu->arch.aux_used |= KVM_LARCH_LSX | KVM_LARCH_FPU;
>   
>   	return 0;
>   }
> @@ -1442,6 +1436,7 @@ int kvm_own_lasx(struct kvm_vcpu *vcpu)
>   
>   	trace_kvm_aux(vcpu, KVM_TRACE_AUX_RESTORE, KVM_TRACE_AUX_LASX);
>   	vcpu->arch.aux_inuse |= KVM_LARCH_LASX | KVM_LARCH_LSX | KVM_LARCH_FPU;
> +	vcpu->arch.aux_used |= KVM_LARCH_LASX | KVM_LARCH_LSX | KVM_LARCH_FPU;
>   
>   	return 0;
>   }
> 
> base-commit: c369299895a591d96745d6492d4888259b004a9e
> 

