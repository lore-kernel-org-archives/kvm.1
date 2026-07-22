Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67211242D89;
	Wed, 22 Jul 2026 01:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784684600; cv=none; b=NVdw9AaEpZ5ue1ue6TtAo9O9Ru5zzgH12zXL3dv2Cr7sjJ3/tIlLRxxUAK292vzOzE06nsyjN6swN1edEvWWLkR6Qjyv6hS7mx3Ef/3NRJJFQaLRwNG6ytS04FPhA5+PdoP30tM4C82cLkIXPNIIeHw4G1p8ONZY0E3JM4CvDvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784684600; c=relaxed/simple;
	bh=HDKnuZB020B1NFw5Aks/rAa/Gx9BkOkDO5X/X00aR7g=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=CwLjUSWwnt36+soLewSHBFQ4xjdjt/0xYP48XB6e7ZZno2uY3sWWtkwzUaCQkM4x20tr/Qd0kgZg0wvambYYeJaDTprMsd9iCTPKAOL4WKqlPeMkGicYwJH3+J8+HZJ4mfpDw3OCUEvrOYH9tC4mDbS6ziJXlOf/4XqM8u7JMvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8CxJOoyIGBq0NgFAA--.21801S3;
	Wed, 22 Jul 2026 09:43:14 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJCxq8QpIGBqpZ0UAA--.56319S2;
	Wed, 22 Jul 2026 09:43:05 +0800 (CST)
Subject: Re: [PATCH] LoongArch: KVM: Implement KVM_GET/SET_SREGS for bulk CSR
 migration
To: Tao Cui <cui.tao@linux.dev>, zhaotianrui@loongson.cn
Cc: chenhuacai@kernel.org, kernel@xen0n.name, kvm@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, cuitao@kylinos.cn
References: <20260721121842.156025-1-cui.tao@linux.dev>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <63410558-e04d-7cbf-4acb-e85619d22236@loongson.cn>
Date: Wed, 22 Jul 2026 09:42:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260721121842.156025-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxq8QpIGBqpZ0UAA--.56319S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3XFyxWFy8tF1UGr4furyUJwc_yoW7Wry3pF
	WUAFZ8WrWrWrn7C34SqFn8ur1Y9397Grs3ua47WrWYyFnFvr15JF18KrWDuFy5uw40gF4I
	9F1Ykw4rCa1qywbCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
	AwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jepB-UUUUU=



On 2026/7/21 下午8:18, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> KVM_GET/SET_SREGS has so far returned -ENOIOCTLCMD with an empty
> struct kvm_sregs, so migrating a vCPU's CSR state takes one
> KVM_GET/SET_ONE_REG ioctl per register -- thousands of syscalls for a
> large VM.
> 
> Define struct kvm_sregs as a flat array of 0x184 entries (the core CSR
> range 0x0-0x183, up to DMWIN3) and implement the two ioctls:
> 
> - get_sregs does a single vcpu_load/put, which also pulls pending
>    interrupts into ESTAT, avoiding the per-register load/put side-effect
>    that made ONE_REG snapshots of ESTAT order-sensitive.
> - set_sregs writes all CSRs via _kvm_setcsr in one pass, propagates
>    _kvm_setcsr errors, and clears KVM_LARCH_HWCSR_USABLE up front so a
>    mid-loop failure still forces the next vcpu_load() to reload from SW,
>    matching KVM_SET_ONE_REG.
> 
> CSRs above 0x183 (debug, breakpoint, PMU) stay on KVM_GET/SET_ONE_REG.
> struct kvm_sregs was empty, so enlarging it -- and the _IOWR-derived
> ioctl number -- breaks no userspace; userspace built against the updated
> UAPI header can adopt the bulk ioctl.
> 
> On a Loongson 3A6000, snapshotting one vCPU's core CSR range drops from
> 388 KVM_GET_ONE_REG calls (~2 ms) to a single KVM_GET_SREGS ioctl
> (~5 us).
Great, I think getting register with bulk method is good.
> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>   arch/loongarch/include/uapi/asm/kvm.h |  3 ++
>   arch/loongarch/kvm/vcpu.c             | 43 +++++++++++++++++++++++++--
>   2 files changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/loongarch/include/uapi/asm/kvm.h b/arch/loongarch/include/uapi/asm/kvm.h
> index cd0b5c11ca9c..dc091f29963d 100644
> --- a/arch/loongarch/include/uapi/asm/kvm.h
> +++ b/arch/loongarch/include/uapi/asm/kvm.h
> @@ -124,7 +124,10 @@ struct kvm_sync_regs {
>   };
>   
>   /* dummy definition */
> +#define KVM_LOONGARCH_NR_SREGS	0x184
> +
>   struct kvm_sregs {
> +	__u64 csr[KVM_LOONGARCH_NR_SREGS];

I think that get/set registers one by one is not so better. There are 
two possible potential problems with this method:
   1. With hard-code size 0x184, there may be compatible issue, in 
future there may be CSR register with index larger than 0x184
   2. There may be order dependency with CSR get or set, such 
timer,interrupt, or feature ctrl registers. Only that there is SW CSR 
shadow CSR register in KVM, so dependency relation disappears with this 
method.

In generic, I think KVM_GET_MSRS/KVM_SET_MSRS is a better method, VMM 
needs know the index and dependency at first, this API can be changed as 
generic and not relative with detailed architecture.

When we submit KVM to community in the beginning, this method was used, 
however the community suggests that new API 
KVM_GET_ONE_REG/KVM_SET_ONE_REG is added, it should be used. Maybe mixed 
of KVM_GET_BULK_REGS/KVM_GET_ONE_REG can be used :)

There is piece of UAPI with KVM_GET_MSRS/KVM_SET_MSRS.
struct kvm_msr_entry {
         __u32 index;
         __u32 reserved;
         __u64 data;
};

/* for KVM_GET_MSRS and KVM_SET_MSRS */
struct kvm_msrs {
         __u32 nmsrs; /* number of msrs in entries */
         __u32 pad;

         __DECLARE_FLEX_ARRAY(struct kvm_msr_entry, entries);
};

Regards
Bibo Mao
>   };
>   
>   struct kvm_iocsr_entry {
> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index 20c207d80e31..0890b68efa2a 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
> @@ -1001,12 +1001,51 @@ static int kvm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>   
>   int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
>   {
> -	return -ENOIOCTLCMD;
> +	int i;
> +	unsigned long estat, gintc;
> +	struct loongarch_csrs *csr = vcpu->arch.csr;
> +
> +	/*
> +	 * Pull pending interrupts into ESTAT with a single vcpu_load/put so
> +	 * the ESTAT value read below matches the current interrupt state.
> +	 * This also avoids the per-register load/put side-effect that makes
> +	 * the ONE_REG path's ESTAT snapshot order-sensitive.  The SW CSR
> +	 * reads run under vcpu->mutex, which serialises this ioctl.
> +	 */
> +	preempt_disable();
> +	vcpu_load(vcpu);
> +	kvm_deliver_intr(vcpu);
> +	vcpu->arch.aux_inuse &= ~KVM_LARCH_SWCSR_LATEST;
> +	vcpu_put(vcpu);
> +	preempt_enable();
> +
> +	for (i = 0; i < KVM_LOONGARCH_NR_SREGS; i++) {
> +		if (i == LOONGARCH_CSR_ESTAT) {
> +			gintc = kvm_read_sw_gcsr(csr, LOONGARCH_CSR_GINTC) & KVM_GINTC_IRQ_MASK;
> +			estat = kvm_read_sw_gcsr(csr, LOONGARCH_CSR_ESTAT) & ~KVM_ESTAT_EXTI_MASK;
> +			sregs->csr[i] = estat | (gintc << VIP_DELTA);
> +		} else {
> +			sregs->csr[i] = kvm_read_sw_gcsr(csr, i); > +		}
> +	}
> +
> +	return 0;
>   }
>   
>   int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
>   {
> -	return -ENOIOCTLCMD;
> +	int i, ret;
> +
> +	/* Clear first so a failing _kvm_setcsr still forces a HW reload. */
> +	vcpu->arch.aux_inuse &= ~KVM_LARCH_HWCSR_USABLE;
> +
> +	for (i = 0; i < KVM_LOONGARCH_NR_SREGS; i++) {
> +		ret = _kvm_setcsr(vcpu, i, sregs->csr[i]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
>   }
>   
>   int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
> 

