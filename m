Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557EF2F8EA6
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 04:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779941518; cv=none; b=RKoCtRryn+LfnRgy0iLq+lloZsU9zmg/mz4uxzqZDgh+xSSLfhvggh6AhGgWvHfCX3W8Pcx90Jhj/GX/v3ejiPa2PMsMeDREiY7k/UP8saVa+A6ilOdiHHS5fieoTGLogmvCcxYx6+w1WBFwSeIYx+3SloISZAaXL2AX8tz4waU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779941518; c=relaxed/simple;
	bh=K00yvi/euk36FRL6ZdE/ZZDPD8NHeifXqBgHUNucZmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jHtJ99a7oVbiS02TvhlXPpC15qlEUrpYBq/cj9W4/uR5bZWYL/jSVbxkqcvm57pj30TlITLOT04S6Ai1mdi5mwqM5UNa/Uzq5TBj1LRokT0jsBeO/Kmt6tFQlEClybkKMkWwLH6cvSzW+co3ES8tLRUvqDcH75safq+VSC9qal8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BLXVqWWr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ItqOCYnu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BLXVqWWr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ItqOCYnu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779941516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aWEMGPujLx2YkwfTu/wiSD5CRnNiDpNAFuXhLG9oPIs=;
	b=BLXVqWWr/UOeJdWNCfgAo7X3+eeJdsp/GQpXxCeR4dfc2/YPQsAFftl5/XW0PdAYJLl1LJ
	GRxZXmcHERYvwt36zLc9N6krN+tXPMfj37cT87hVXmt1Fq1FOwJtiV4hlKrVGILTXROBh4
	NlW29QbVITEmv3CgW9Fg9bm9+jHYi8s=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-PU4tB8H3MByUTQMnqcY5mA-1; Thu, 28 May 2026 00:11:54 -0400
X-MC-Unique: PU4tB8H3MByUTQMnqcY5mA-1
X-Mimecast-MFC-AGG-ID: PU4tB8H3MByUTQMnqcY5mA_1779941514
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-368b15eeb3bso22517402a91.2
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 21:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779941514; x=1780546314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aWEMGPujLx2YkwfTu/wiSD5CRnNiDpNAFuXhLG9oPIs=;
        b=ItqOCYnuTo69HcM0md1m4m++CeZx5aqPHHxtuoBudD+djmlUqVPu47D92+PYs9Uzws
         4CdwRTCWUyI7FaG12bJuCGsc1rpJvN1Up4WBWYms33rlwPOO6+Eq1hGxpXPH3c61cOz/
         YTSdiTYszK6GgPJagksK2Di/EMVfL6vsFohyBMXSTuuXzJXK84PNGl56y1k2YfNAoqde
         6EYy0uWR1v+A1p0R5zcbn1xu6NHHzdkmTWSY9KepZdj7/0kAfEEQZ5mQJzCwK5JO/TiU
         RjvC+/dXAoVgiM7f348s2fqbssFXXC0NuaBiSnk/fALMqENLd47+y+WpukX+3uF+Mnfk
         h3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779941514; x=1780546314;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aWEMGPujLx2YkwfTu/wiSD5CRnNiDpNAFuXhLG9oPIs=;
        b=rxMWc7Or748Riq9ki0lOwhUFDv1CPFvVzYA0KrgRK+jRjy3ODj68pm7WhajGXLWa+L
         O1ORC8EHdBwzR9VItDck8WjBhvDSbEaJI1X8jfs3aZZWlvyf4SoyZH9jJiOWqbQjquBI
         uXwmGAxVTuftY48Dc1xHPeNDHERSdiyjru3GDr3sx9VvlzNANZT6JyajbpP1TVP7cA0D
         hCYvjFRmPKRTFqL0USE/otyIBg6aDgF0gUAHxkEu5asGBznoMkiu7UUfXi+nyLN36e2F
         BeZuly/ZidkeSQbQZqNgjaDws0nTSCwHrlfceOaMfG0nP0gvnBWKC2yIKosJ6pkkYQA7
         /O9w==
X-Forwarded-Encrypted: i=1; AFNElJ81EJ+a7x+WzQkXHwiCDjg6CjFcoV2Hl7f6qmJVpGT8wIpmot+5f5SWqbTDuUzGbcLFOkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YySF6fNNW4rtgZBF/vw9Jdcqk/MloQhEgTpmcBSP/ZsD/BvE8bc
	47AiK+tufOtA5XoAMMcENyHU+yyK1GfRtc1y/+4S9n8RFc6xPimFfF7qDaMgvjN5HTiSiKprrpM
	xYhiQhgPJPWxeLUb70XYSojrpAA8Ln1yYhQaK0WdkcvekCwfzV06lkw==
X-Gm-Gg: Acq92OFrZ6f5ir6E7bbc/dBchXoWsE6vdjWRygL5tWof6NuF7JXpUfSgXLJVxD73sD8
	bgU8GzNSoyHlsxGvvdG3TF1iMfBGYRU55iQ5d4TA9ylqKrC7ewXs/jlug4c+5xhxvm3z6bYObk7
	r8b1DUH0s0REy4p6Bp5wv1lE9pzGqbw1hf1pZ2/3mBmRSxvrsE6ZrygmKjcn5lquTssLnZ71bmf
	Id5wgX1+L1wTpbawozKHZ/L89c6acKnjDRD7nCzGLBrJ5bIdjl9Mwy8EbPVp+n076AA/K9vEK0m
	y5uyM/V7kh56nSJpmohgUD9otMTtW2/LTGcBRM9SVL5GzEyczMFOulPW+G0zKqiZMj0IRgWgfks
	Nsd3VnweIzmES6jrsUoPCSozgvgQ5hJzbp9161LMuAp+0CCQ0tsz6pQ/Qru+DZZjtpo06AihhEw
	Q=
X-Received: by 2002:a17:90b:5447:b0:36b:71e6:3de8 with SMTP id 98e67ed59e1d1-36b71e64033mr3269518a91.24.1779941513628;
        Wed, 27 May 2026 21:11:53 -0700 (PDT)
X-Received: by 2002:a17:90b:5447:b0:36b:71e6:3de8 with SMTP id 98e67ed59e1d1-36b71e64033mr3269490a91.24.1779941513150;
        Wed, 27 May 2026 21:11:53 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36b908e15acsm409862a91.2.2026.05.27.21.11.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 21:11:52 -0700 (PDT)
Message-ID: <58143176-8311-4eb8-85ef-625c5249fd0f@redhat.com>
Date: Thu, 28 May 2026 14:11:41 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 21/44] KVM: arm64: Support timers in realm RECs
To: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, Fuad Tabba <tabba@google.com>,
 linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun
 <alpergun@google.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
 Emi Kisanuki <fj0570is@fujitsu.com>, Vishal Annapurve
 <vannapurve@google.com>, WeiLin.Chang@arm.com, Lorenzo.Pieralisi2@arm.com
References: <20260513131757.116630-1-steven.price@arm.com>
 <20260513131757.116630-22-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260513131757.116630-22-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Steve,

On 5/13/26 11:17 PM, Steven Price wrote:
> The RMM keeps track of the timer while the realm REC is running, but on
> exit to the normal world KVM is responsible for handling the timers.
> 
> A later patch adds the support for propagating the timer values from the
> exit data structure and calling kvm_realm_timers_update().
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Changes since v12:
>   * Adapt to upstream changes.
> Changes since v11:
>   * Drop the kvm_is_realm() check from timer_set_offset(). We already
>     ensure that the offset is 0 when calling the function.
> Changes since v10:
>   * KVM_CAP_COUNTER_OFFSET is now already hidden by a previous patch.
> Changes since v9:
>   * No need to move the call to kvm_timer_unblocking() in
>     kvm_timer_vcpu_load().
> Changes since v7:
>   * Hide KVM_CAP_COUNTER_OFFSET for realm guests.
> ---
>   arch/arm64/kvm/arch_timer.c  | 28 +++++++++++++++++++++++++---
>   include/kvm/arm_arch_timer.h |  2 ++
>   2 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
> index cbea4d9ee955..88ed01edc136 100644
> --- a/arch/arm64/kvm/arch_timer.c
> +++ b/arch/arm64/kvm/arch_timer.c
> @@ -470,6 +470,21 @@ static void kvm_timer_update_irq(struct kvm_vcpu *vcpu, bool new_level,
>   			    timer_ctx);
>   }
>   
> +void kvm_realm_timers_update(struct kvm_vcpu *vcpu)
> +{
> +	struct arch_timer_cpu *arch_timer = &vcpu->arch.timer_cpu;
> +	int i;
> +
> +	for (i = 0; i < NR_KVM_EL0_TIMERS; i++) {
> +		struct arch_timer_context *timer = &arch_timer->timers[i];
> +		bool status = timer_get_ctl(timer) & ARCH_TIMER_CTRL_IT_STAT;
> +		bool level = kvm_timer_irq_can_fire(timer) && status;
> +
> +		if (level != timer->irq.level)
> +			kvm_timer_update_irq(vcpu, level, timer);
> +	}
> +}
> +
>   /* Only called for a fully emulated timer */
>   static void timer_emulate(struct arch_timer_context *ctx)
>   {
> @@ -1079,7 +1094,7 @@ static void timer_context_init(struct kvm_vcpu *vcpu, int timerid)
>   
>   	ctxt->timer_id = timerid;
>   
> -	if (!kvm_vm_is_protected(vcpu->kvm)) {
> +	if (!kvm_vm_is_protected(vcpu->kvm) && !kvm_is_realm(vcpu->kvm)) {
>   		if (timerid == TIMER_VTIMER)
>   			ctxt->offset.vm_offset = &kvm->arch.timer_data.voffset;
>   		else

s/!kvm_is_realm(vcpu->kvm)/!vcpu_is_rec(vcpu)

> @@ -1110,7 +1125,7 @@ void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu)
>   		timer_context_init(vcpu, i);
>   
>   	/* Synchronize offsets across timers of a VM if not already provided */
> -	if (!vcpu_is_protected(vcpu) &&
> +	if (!vcpu_is_protected(vcpu) && !kvm_is_realm(vcpu->kvm) &&
>   	    !test_bit(KVM_ARCH_FLAG_VM_COUNTER_OFFSET, &vcpu->kvm->arch.flags)) {
>   		timer_set_offset(vcpu_vtimer(vcpu), kvm_phys_timer_read());
>   		timer_set_offset(vcpu_ptimer(vcpu), 0);

Same as above.

> @@ -1611,6 +1626,13 @@ int kvm_timer_enable(struct kvm_vcpu *vcpu)
>   		return -EINVAL;
>   	}
>   
> +	/*
> +	 * We don't use mapped IRQs for Realms because the RMI doesn't allow
> +	 * us setting the LR.HW bit in the VGIC.
> +	 */
> +	if (vcpu_is_rec(vcpu))
> +		return 0;
> +
>   	get_timer_map(vcpu, &map);
>   
>   	ops = vgic_is_v5(vcpu->kvm) ? &arch_timer_irq_ops_vgic_v5 :
> @@ -1740,7 +1762,7 @@ int kvm_vm_ioctl_set_counter_offset(struct kvm *kvm,
>   	if (offset->reserved)
>   		return -EINVAL;
>   
> -	if (kvm_vm_is_protected(kvm))
> +	if (kvm_vm_is_protected(kvm) || kvm_is_realm(kvm))
>   		return -EINVAL;
>   
>   	mutex_lock(&kvm->lock);
> diff --git a/include/kvm/arm_arch_timer.h b/include/kvm/arm_arch_timer.h
> index bf8cc9589bd0..ffdb90dcad58 100644
> --- a/include/kvm/arm_arch_timer.h
> +++ b/include/kvm/arm_arch_timer.h
> @@ -113,6 +113,8 @@ int kvm_arm_timer_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr);
>   int kvm_arm_timer_get_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr);
>   int kvm_arm_timer_has_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr);
>   
> +void kvm_realm_timers_update(struct kvm_vcpu *vcpu);
> +
>   u64 kvm_phys_timer_read(void);
>   
>   void kvm_timer_vcpu_load(struct kvm_vcpu *vcpu);

Thanks,
Gavin

