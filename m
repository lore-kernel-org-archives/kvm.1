Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7876E330D2A;
	Tue, 14 Apr 2026 09:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776157766; cv=none; b=Y3rNugi7N5q4K7+CuNTjvgAirFSJmo/jx5Qlxe+4GlXYe5TWNRfQzWBp9CHY5E/206NXTgmGU8vuw71v25/0qwx4Pj56G82eg6yQi+gIVKzrJDfJMsMwCUoJFDa2dKNGDJj8hKF9bF+gmaEXaufGem5G0VqlXK37fBTRNhGSKSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776157766; c=relaxed/simple;
	bh=H6ZB4ISzMjy4AQ0CTXwJtxaNh2ljpRY/3zyh2r8sGgY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQ2uIZ/VuobOtXMNRAXgNdzBMFWupYrWns2odtyETygzPr688Yse83p9qTK9Bo/WPjCKCQrW7J4k+wdeCE8Sq0+BrXvVmGmaeEmO6eW6nLR3Agh+Wz2ePsIBNUzRajMmjWdljDtAZBxZFv6h9xSK3+G7K/m7kPfQ02NYi0CuDDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=BT9AeUwq; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="BT9AeUwq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1776157757; bh=TLBHUotRa57QkBGDFQ2cZImxoNpNFGzsAJhMazifhn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BT9AeUwqjQx7ozUsi0LsVOnTImj9JtOUAiEiRmxpXQ4fQqmhkKOP0NHFPaSpxFtUB
	 qHCjgJy5F4ZRMdeMZG3yXkQ79vmWoPkRYFFBloLKgKRPMfQsm62kKTr5BTBUu5Z08b
	 9QIEt4jf9Afoo0MmMc19EjjoSho/bxKLKefQqxMY=
Received: from zh-pc ([116.128.244.169])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 24EA4C1E; Tue, 14 Apr 2026 17:09:14 +0800
X-QQ-mid: xmsmtpt1776157754t7x5i9k22
Message-ID: <tencent_510B7687999B510DE0D00238024766980C06@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+2SjFAIPKE1oPuS1/Y7Mag3/IGvDERPNeX3Ox+kL7Tne2P8UXON
	 9UuiT499WQ8xq78QmcPh4R/JfQ6579JR6v0X6l6dBFVRPRxxaXd2xHs5gdmzOhetFmNHV04a3rGz
	 sTDMtNXWpvwe/M2bzKpxbdiJh8SmnNZrztj1dz9yPkY6IM9P2psrHVMpm4I8L87ie+kj+rVRt3Dp
	 Wu7X0g/wE7U4OSONMHjVE+2SoTvg7On74pVER6BGhoIm2Jg/POB8pYWR4xRHyP/59b653G75ZBcK
	 NoC+HriD0aCRBPvLmkDekGdR9seLEl2HbtTLeNtkfZepHRWPC3ThyDMmGJG7D1smwaEkLUyatEUv
	 dMKgtlHGktvxiVAfOAH8Jt7Bes4Qg4dS3jMHZ+KoITM+HW4YZTV5G5WNQ/T9AVNaVsAk2ZcVEIzk
	 DxfA3SUDc5vMpvJpYhhNN3omwLggSvMmq5tXi9hyrc7XLkeQ6QTEDx01lfKKq3VSnjRRC+78+0a3
	 jGdsjUTUr9+4YapBnSC0TMw3zRFovxmsLdGaI/MSa9dt3mzpDFRZO8wi0nfqd86JOXIJDwv7hRx+
	 8JI0wyHQhYarvQ1UREolPe5Z8ElRJYhconXspWqHR+jUB/mUfjoPYy/a1Na3nsZAjXvMgtTxmlBd
	 GkYon7AIZLLCPcE4mL94H5v9NZdBn/86475amIWBwc2pMBEECvar3+LleVJv1P6iJCnN0nDvRr1r
	 juZUmAbGgNMYoyE6iJQ+r2z97DhHMB6ibPAlnK7vuEDK7cNJ+km4p/IydYos5GfdJG+xnxyb20bn
	 eW0eFzoIbdbxetUhSEA3Uoqccw9qYdyvdsua3CxRi60BoiYc2iu6AzWsUiSz0zOKAnjY7DuNsUxi
	 1zzAbsemsrIrk6hGzGSQ1pttRCNXopBasS6uP9+dQy8MGKEJ7s1zWhLio7zU/NkKT7AU9PGFjRW1
	 uOSs+F8lTHyhaHBX8EbjLsWWErDjAlgnPynS2eSVoBAc9z8EifRo0NwCHj8//dVVbjOEFbFV5orv
	 SNCaUIklieajAZzZwdDoXMhW21OhZRBdJ8/s7q08Yo6lUEOHLTRxZKjApNheXlhfBba41Pvg==
X-QQ-XMRINFO: MYTJVxP1dBxwtiABCNfZE0rVJLV6TFYRrQ==
Date: Tue, 14 Apr 2026 17:09:14 +0800
From: zhanghao <76824143@qq.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, zhanghao <zhanghao1@kylinos.cn>,
	Wanpeng Li <kernellwp@gmail.com>
Subject: Re: [PATCH] KVM: Drop kvm_vcpu.ready to squash race where "ready"
 can get stuck "true"
X-OQ-MSGID: <20260414090914.GA148269@zh-pc>
References: <20260409213333.1995382-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260409213333.1995382-1-seanjc@google.com>

On Thu, Apr 09, 2026, Sean Christopherson wrote:
> Drop kvm_vcpu.ready and instead detect the case where a recently awakened
> vCPU is runnable but not yet scheduled in by explicitly, manually checking
> for a target vCPU that is (a) scheduled out, (b) wants to run, (c) is
> marked as blocking in its stat, but (d) not actually flagged as blocking.
> I.e. treat a runnable vCPU that's in the blocking sequence but not truly
> blocking as a candidate for directed yield.
> 
> Keying off vcpu->stat.generic.blocking will yield some number of false
> positives, e.g. if the vCPU is preempted _before_ blocking, but the rate of
> false positives should be roughly the same as the existing approach, as
> kvm_sched_out() would previously mark the vCPU as ready when it's scheduled
> out and runnable.
> 
> Eliminating the write to vcpu->ready in kvm_vcpu_wake_up() fixes a race
> where vcpu->ready could be set *after* the target vCPU is scheduled in,
> e.g. if the task waking the target vCPU is preempted (or otherwise delayed)
> after waking the vCPU, but before setting vcpu->ready.  Hitting the race
> leads to a very degraded state as KVM will constantly attempt to schedule
> in a vCPU that is already running.
> 
> Fixes: d73eb57b80b9 ("KVM: Boost vCPUs that are delivering interrupts")
> Reported-by: zhanghao <zhanghao1@kylinos.cn>
> Closes: https://lore.kernel.org/all/tencent_AE2873502605DBDD4CD1E810F06C410F0105@qq.com
> Cc: stable@vger.kernel.org
> Cc: Wanpeng Li <kernellwp@gmail.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/x86.c       |  2 +-
>  include/linux/kvm_host.h |  9 +++++++++
>  virt/kvm/kvm_main.c      | 10 +++-------
>  3 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0a1b63c63d1a..eebb2eb39ec0 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10399,7 +10399,7 @@ static void kvm_sched_yield(struct kvm_vcpu *vcpu, unsigned long dest_id)
>  
>  	rcu_read_unlock();
>  
> -	if (!target || !READ_ONCE(target->ready))
> +	if (!target || !kvm_vcpu_is_runnable_and_scheduled_out(target))
>  		goto no_yield;
>  
>  	/* Ignore requests to yield to self */
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 7981e9cab2eb..241a976e3410 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1753,6 +1753,15 @@ static inline bool kvm_vcpu_is_blocking(struct kvm_vcpu *vcpu)
>  	return rcuwait_active(kvm_arch_vcpu_get_wait(vcpu));
>  }
>  
> +static inline bool kvm_vcpu_is_runnable_and_scheduled_out(struct kvm_vcpu *vcpu)
> +{
> +	return READ_ONCE(vcpu->preempted) ||
> +	       (READ_ONCE(vcpu->scheduled_out) &&
> +		READ_ONCE(vcpu->wants_to_run) &&
> +		READ_ONCE(vcpu->stat.generic.blocking) &&
> +		!kvm_vcpu_is_blocking(vcpu));
> +}
> +
>  #ifdef __KVM_HAVE_ARCH_INTC_INITIALIZED
>  /*
>   * returns true if the virtual interrupt controller is initialized and
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 9faf70ccae7a..9f71e32daac5 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -455,7 +455,6 @@ static void kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id)
>  	kvm_vcpu_set_in_spin_loop(vcpu, false);
>  	kvm_vcpu_set_dy_eligible(vcpu, false);
>  	vcpu->preempted = false;
> -	vcpu->ready = false;
>  	preempt_notifier_init(&vcpu->preempt_notifier, &kvm_preempt_ops);
>  	vcpu->last_used_slot = NULL;
>  
> @@ -3803,7 +3802,6 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_halt);
>  bool kvm_vcpu_wake_up(struct kvm_vcpu *vcpu)
>  {
>  	if (__kvm_vcpu_wake_up(vcpu)) {
> -		WRITE_ONCE(vcpu->ready, true);
>  		++vcpu->stat.generic.halt_wakeup;
>  		return true;
>  	}
> @@ -4008,7 +4006,7 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
>  			continue;
>  
>  		vcpu = xa_load(&kvm->vcpu_array, idx);
> -		if (!READ_ONCE(vcpu->ready))
> +		if (!kvm_vcpu_is_runnable_and_scheduled_out(vcpu))
>  			continue;
>  		if (kvm_vcpu_is_blocking(vcpu) && !vcpu_dy_runnable(vcpu))
>  			continue;
> @@ -6393,7 +6391,6 @@ static void kvm_sched_in(struct preempt_notifier *pn, int cpu)
>  	struct kvm_vcpu *vcpu = preempt_notifier_to_vcpu(pn);
>  
>  	WRITE_ONCE(vcpu->preempted, false);
> -	WRITE_ONCE(vcpu->ready, false);
>  
>  	__this_cpu_write(kvm_running_vcpu, vcpu);
>  	kvm_arch_vcpu_load(vcpu, cpu);
> @@ -6408,10 +6405,9 @@ static void kvm_sched_out(struct preempt_notifier *pn,
>  
>  	WRITE_ONCE(vcpu->scheduled_out, true);
>  
> -	if (task_is_runnable(current) && vcpu->wants_to_run) {
> +	if (task_is_runnable(current) && vcpu->wants_to_run)
>  		WRITE_ONCE(vcpu->preempted, true);
> -		WRITE_ONCE(vcpu->ready, true);
> -	}
> +
>  	kvm_arch_vcpu_put(vcpu);
>  	__this_cpu_write(kvm_running_vcpu, NULL);
>  }
> 
> base-commit: b89df297a47e641581ee67793592e5c6ae0428f4
> -- 
> 2.53.0.1213.gd9a14994de-goog
>

kvm_vcpu.ready still exists in struct kvm_vcpu, but there are no remaining 
users after this patch, so it looks like a leftover cleanup item.

Best regards,
zhanghao

