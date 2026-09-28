Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B4A28505E;
	Mon, 28 Sep 2026 04:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790568810; cv=none; b=flaa+HjwvLihqyI4p2O1pK1/y5ncU7/axReBekOyV7g2P0na28DVilQ6g7RFrqFcjHdAxpdsJawZaaqlSCpC9KgYnGDSwR3+wWPfTQivmfXkg6zvDSJ5/CcdqpRoST0XMRvk/xLqwZE3FGxWv+zWZLSpg1UUOkFWUqcFZk0m3ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790568810; c=relaxed/simple;
	bh=93DNEAwvSiql5tVYyRBz+VAReMoXOj1afxbwYmmDDR4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=b8Or97Nd4oDS4xRPCE9lZhYmdX79zjiWtsgQfaGMbU3xdi5nj9tDEsHoOlf/gHDq4YliGww542K5mxXJJp3bvhLdxDGG0SgY/pXCvlrE7VzbRbr2Yppkm285twTWuz4I0xsfDCQhwQheYjj6/l9K2Tx3fYIu0Ck2/nODIU53238=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8CxPtNm6blqG2AQAA--.47762S3;
	Mon, 28 Sep 2026 12:13:26 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJAxX89l6blqB_AlAA--.15177S2;
	Mon, 28 Sep 2026 12:13:25 +0800 (CST)
Subject: Re: [PATCH 2/6] LoongArch: KVM: Guard against NULL irqchip in irq
 injection
To: Tao Cui <cui.tao@linux.dev>, gaosong@loongson.cn, zhaotianrui@loongson.cn
Cc: loongarch@lists.linux.dev, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
 nagachaithanya9911@gmail.com, Tao Cui <cuitao@kylinos.cn>
References: <20260927075240.3007947-1-cui.tao@linux.dev>
 <20260927075240.3007947-3-cui.tao@linux.dev>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <4b4aba4a-c609-93f5-51e8-3b70a8baf6ad@loongson.cn>
Date: Mon, 28 Sep 2026 12:14:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260927075240.3007947-3-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxX89l6blqB_AlAA--.15177S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWry5WFW7Jry7urW7ZFW5Arc_yoW5CFy8pF
	W3C390kr4rXryUJr92ga1DWw47Z3s3Xr1SgFy29FyxCFn0qF1rJF18Ar9rZFyUKw48GrWI
	9F4fW3s0v3WDAacCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jz2NtUUUUU=



On 2026/9/27 下午3:52, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> The irqfd injection path dispatches through the irq routing table
> without the kvm_arch_irqchip_in_kernel() gate that protects
> KVM_IRQ_LINE: kvm_set_pic_irq() and kvm_arch_set_irq_inatomic() call
> pch_pic_set_irq(kvm->arch.pch_pic, ...) and pch_msi_set_irq() calls
> eiointc_set_irq(kvm->arch.eiointc, ...) directly, so a routing entry
> that outlives the corresponding in-kernel irqchip dereferences a NULL
> (or, before the previous patch, a freed) device.
> 
> Make pch_pic_set_irq(), eiointc_set_irq() and dmsintc_set_irq()
> tolerate a NULL device.
> 
> Fixes: 1928254c5ccb ("LoongArch: KVM: Add irqfd support")
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>   arch/loongarch/kvm/intc/dmsintc.c | 3 +++
>   arch/loongarch/kvm/intc/eiointc.c | 5 ++++-
>   arch/loongarch/kvm/intc/pch_pic.c | 3 +++
>   3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/loongarch/kvm/intc/dmsintc.c b/arch/loongarch/kvm/intc/dmsintc.c
> index 63072595c01b..e27f448bb54f 100644
> --- a/arch/loongarch/kvm/intc/dmsintc.c
> +++ b/arch/loongarch/kvm/intc/dmsintc.c
> @@ -70,6 +70,9 @@ int dmsintc_set_irq(struct kvm *kvm, u64 addr, int data, int level)
>   	unsigned int irq, cpu;
>   	struct kvm_vcpu *vcpu;
>   
> +	if (!kvm->arch.dmsintc)
> +		return -EINVAL;
> +
There is kvm->arch.dmsintc checking in its caller function 
pch_msi_set_irq().

>   	irq = (addr >> AVEC_IRQ_SHIFT) & AVEC_IRQ_MASK;
>   	cpu = (addr >> AVEC_CPU_SHIFT) & kvm->arch.dmsintc->cpu_mask;
>   	if (cpu >= KVM_MAX_VCPUS)
> diff --git a/arch/loongarch/kvm/intc/eiointc.c b/arch/loongarch/kvm/intc/eiointc.c
> index fe0a1918f26f..c68f9033638a 100644
> --- a/arch/loongarch/kvm/intc/eiointc.c
> +++ b/arch/loongarch/kvm/intc/eiointc.c
> @@ -112,8 +112,11 @@ static inline void eiointc_update_sw_coremap(struct loongarch_eiointc *s,
>   void eiointc_set_irq(struct loongarch_eiointc *s, int irq, int level)
>   {
>   	unsigned long flags;
> -	unsigned long *isr = (unsigned long *)s->isr;
> +	unsigned long *isr;
>   
> +	if (!s)
> +		return;
When is it possible that parameter s is NULL? There is 
kvm_arch_irqchip_in_kernel() checking in kvm_send_userspace_msi().

> +	isr = (unsigned long *)s->isr;
>   	spin_lock_irqsave(&s->lock, flags);
>   	level ? __set_bit(irq, isr) : __clear_bit(irq, isr);
>   	eiointc_update_irq(s, irq, level);
> diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/pch_pic.c
> index 62c09b5f3937..88666425d800 100644
> --- a/arch/loongarch/kvm/intc/pch_pic.c
> +++ b/arch/loongarch/kvm/intc/pch_pic.c
> @@ -48,6 +48,9 @@ void pch_pic_set_irq(struct loongarch_pch_pic *s, int irq, int level)
>   {
>   	u64 mask = BIT(irq);
>   
> +	if (!s)
> +		return;
> +
When is it possible that parameter s is NULL? I think that when in 
kernel irqchip is removed, there is no way to inject line IRQ in kernel 
side.

Regards
Bibo Mao
>   	spin_lock(&s->lock);
>   	if (level)
>   		s->irr |= mask; /* set irr */
> 

