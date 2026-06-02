Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE8C3C871E;
	Tue,  2 Jun 2026 08:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780390506; cv=none; b=oB4CzvUajKYurDFiZxJDfUrWEXp6EK+63oAbg/M1IgkuWaIQF9YLmSBhxNZONC/HeUkxRNXTPC+rzlsCDvL2G6cl6JxyKOGPhsPhunlinzF2Rbk1edwqb6u0hNLFyiOQ4YZBgIQZbhKg5AecUmaFxxeOg19SF3W20Dw+q2FW3Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780390506; c=relaxed/simple;
	bh=SgGEYYww2u/q8UGtG8LRIzibpWQxVJ0lJkjAO05IWF0=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=meSQSeYek3EdyRxp43NARsoVtTTifL8nZEfVLcN59X5KhysBS9Tgnfw55CuRakwNfz26PJ7ACmaC+sOlH7C4kdtfDeNAtoMkQQ80Wd94ohNwNKfAvG6I4eTRYlziE+0jticdJlnakPLDpNGqOK29NzSds0x7ET+nHkhveKQsxCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Bx+Hhjmh5qb6wPAA--.18938S3;
	Tue, 02 Jun 2026 16:54:59 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJDxzsJimh5qjB6ZAA--.28139S3;
	Tue, 02 Jun 2026 16:54:58 +0800 (CST)
Subject: Re: [PATCH v3 4/4] LoongArch: KVM: Remove KVM_LARCH_LASX and
 KVM_LARCH_LSX
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name, kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260602074316.1647373-1-maobibo@loongson.cn>
 <20260602074316.1647373-5-maobibo@loongson.cn>
Message-ID: <9ea14f0d-eb89-bff0-17b0-023da342cfe4@loongson.cn>
Date: Tue, 2 Jun 2026 16:51:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260602074316.1647373-5-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxzsJimh5qjB6ZAA--.28139S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGryfCw45Ar17Zr48AF4fJFc_yoW5KFWxpF
	srur1Duw4rCFyS9wn7Gr1qqr1jvrZagry2gFyjga45Jrn0qry5ZF4vkrZ09FyDW3Z5Aa92
	qFyF9w1Yka48JwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jn
	UUUUUUUU=



On 2026/6/2 下午3:43, Bibo Mao wrote:
> In kvm_lose_fpu() FPU state will save in vcpu::arch::fpu, its FPU
> state comes from vcpu->arch.aux_inuse. Instead existing API
> vm_guest_has_xxx() can be used also, and bit KVM_LARCH_LASX and
> KVM_LARCH_LSX in arch.aux_inuse are removed. It makes the logic
> simpler than ever.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   arch/loongarch/include/asm/kvm_host.h |  2 --
>   arch/loongarch/kvm/vcpu.c             | 17 +++++++++--------
>   2 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
> index bad16c5f963c..aa2000cfb58a 100644
> --- a/arch/loongarch/include/asm/kvm_host.h
> +++ b/arch/loongarch/include/asm/kvm_host.h
> @@ -158,8 +158,6 @@ enum emulation_result {
>   };
>   
>   #define KVM_LARCH_FPU		(0x1 << 0)
> -#define KVM_LARCH_LSX		(0x1 << 1)
> -#define KVM_LARCH_LASX		(0x1 << 2)
>   #define KVM_LARCH_LBT		(0x1 << 3)
>   #define KVM_LARCH_PMU		(0x1 << 4)
>   #define KVM_LARCH_SWCSR_LATEST	(0x1 << 5)
> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index 53abf7aa61f8..523d4cf88343 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
> @@ -1392,7 +1392,7 @@ int kvm_own_lsx(struct kvm_vcpu *vcpu)
>   	kvm_restore_lsx(&vcpu->arch.fpu);
>   
>   	trace_kvm_aux(vcpu, KVM_TRACE_AUX_RESTORE, KVM_TRACE_AUX_LSX);
> -	vcpu->arch.aux_inuse |= KVM_LARCH_LSX | KVM_LARCH_FPU;
> +	vcpu->arch.aux_inuse |= KVM_LARCH_FPU;
>   
>   	return 0;
>   }
> @@ -1408,7 +1408,7 @@ int kvm_own_lasx(struct kvm_vcpu *vcpu)
>   	kvm_restore_lasx(&vcpu->arch.fpu);
>   
>   	trace_kvm_aux(vcpu, KVM_TRACE_AUX_RESTORE, KVM_TRACE_AUX_LASX);
> -	vcpu->arch.aux_inuse |= KVM_LARCH_LASX | KVM_LARCH_LSX | KVM_LARCH_FPU;
> +	vcpu->arch.aux_inuse |= KVM_LARCH_FPU;
>   
>   	return 0;
>   }
> @@ -1417,31 +1417,32 @@ int kvm_own_lasx(struct kvm_vcpu *vcpu)
>   /* Save context and disable FPU */
>   void kvm_lose_fpu(struct kvm_vcpu *vcpu)
>   {
> +	if (!(vcpu->arch.aux_inuse & KVM_LARCH_FPU))
> +		return;
here is problem with AI review
 
https://sashiko.dev/#/patchset/20260602074316.1647373-1-maobibo@loongson.cn?part=4

kvm_lose_fpu() implies that kvm_lose_lbt(), there is problem returning 
directly without calling kvm_lose_lbt().

Regards
Bibo Mao
> +
>   	preempt_disable();
>   
>   	kvm_check_fcsr_alive(vcpu);
> -	if (vcpu->arch.aux_inuse & KVM_LARCH_LASX) {
> +	if (kvm_guest_has_lasx(&vcpu->arch)) {
>   		kvm_save_lasx(&vcpu->arch.fpu);
> -		vcpu->arch.aux_inuse &= ~(KVM_LARCH_LSX | KVM_LARCH_FPU | KVM_LARCH_LASX);
>   		trace_kvm_aux(vcpu, KVM_TRACE_AUX_SAVE, KVM_TRACE_AUX_LASX);
>   
>   		/* Disable LASX & LSX & FPU */
>   		clear_csr_euen(CSR_EUEN_FPEN | CSR_EUEN_LSXEN | CSR_EUEN_LASXEN);
> -	} else if (vcpu->arch.aux_inuse & KVM_LARCH_LSX) {
> +	} else if (kvm_guest_has_lsx(&vcpu->arch)) {
>   		kvm_save_lsx(&vcpu->arch.fpu);
> -		vcpu->arch.aux_inuse &= ~(KVM_LARCH_LSX | KVM_LARCH_FPU);
>   		trace_kvm_aux(vcpu, KVM_TRACE_AUX_SAVE, KVM_TRACE_AUX_LSX);
>   
>   		/* Disable LSX & FPU */
>   		clear_csr_euen(CSR_EUEN_FPEN | CSR_EUEN_LSXEN);
> -	} else if (vcpu->arch.aux_inuse & KVM_LARCH_FPU) {
> +	} else {
>   		kvm_save_fpu(&vcpu->arch.fpu);
> -		vcpu->arch.aux_inuse &= ~KVM_LARCH_FPU;
>   		trace_kvm_aux(vcpu, KVM_TRACE_AUX_SAVE, KVM_TRACE_AUX_FPU);
>   
>   		/* Disable FPU */
>   		clear_csr_euen(CSR_EUEN_FPEN);
>   	}
> +	vcpu->arch.aux_inuse &= ~KVM_LARCH_FPU;
>   	kvm_lose_lbt(vcpu);
>   
>   	preempt_enable();
> 

