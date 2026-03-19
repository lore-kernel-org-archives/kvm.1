Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8B438A299
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773909742; cv=none; b=aQG+DQo/s2BW8e4vOtx1rFZOt0uiZ1pgD9D6HkQu2sg2UI68a9xs4AdbXxJmCZJWo/ia8zUTNExw/YHdmLf5z+A9IErBsk/fYn9xR2EwMhi6jqNWJoLYn3xJa6xzZMr8dzGABrj5DHwXFD8N3yjWdUF6+KAsiRc/Jdi7vPqo11Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773909742; c=relaxed/simple;
	bh=/IoamEKwB3ryxWlhLz0TgWzA4wQyEXqeJ4hiWk+A7Ks=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JkOqUk3UXvKN3ndgAzFnJ1GsnOhh5Gb0gxf7Mb1RFBTIrhnguQktgQT4MiZj7/9pQMKq414ydhLQqK7V5UlF5rnQEvhJJ9t1kRB0RzrxsHVDI29WqCQCf7NLEZ7EioM6iq7OgrQULg9RazFN134QguCqpkxneTwxa4ZBfFYSQC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=kZARNhP5; arc=none smtp.client-ip=43.163.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="kZARNhP5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1773909731; bh=yFjJrZWFKLqREoWphrcYkKtbPF0MJmuc0pBqycJqK4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kZARNhP5HnofuWWmmuae+HyTzNRGmsAS7wVh2WpYl0jXGdeHsJLkPljvRLpwjURTL
	 INWMYGT/PQ8VRhFIbNbXYPFzcEiJk2B2UcYQFU9h9dZsdXvq+WC42J+2aFnVWp2e6K
	 Mi6LDmVc1iFTEBArK7IEFro75GBWRmAYY7itx+nc=
Received: from zh-pc ([116.128.244.169])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id A3820C3C; Thu, 19 Mar 2026 16:40:56 +0800
X-QQ-mid: xmsmtpt1773909656tbk6x5lu7
Message-ID: <tencent_CD10183239642AB1A7CC9A8D46013F16E209@qq.com>
X-QQ-XMAILINFO: OFwwPG4tTmss6A7mO3wdDqMIX0UbSWk7r+bi+BIXGQVC09tRt/xP/PnJQ1kan6
	 +fqEF8R1K8X/Cexya0wFyN8h3Twb1K205iSGPo68nUTZ0lWAWNU0PeDHM3k/N92x0fuBOPHD4mG1
	 HDWEs/iZ3Ng71iU6UzUvp9PsnvfzhuswoXFhQKm/UbMphS5XbFMdpqEzH+DYgjGmTZqGxcVOTHac
	 HG/7BaMhHFHxTZhI9XO1AyNne+va+TNMT+UmTT5T3JM4jATB4PyD/O94BCvpWSu/VXY7EHKDVOom
	 W3MgfeAEwVBkQG+upnRRcXJbIBZpYUQlqQv+hrL9wXNZgsmk2stUUbaTr1vlIvn0LRQiJkPIH2rj
	 0pJ4fqpljmN+PSw4TFes4hMgkHhQalTfhXp4d49YpXjEKeGvT/A3jpXmF7bJgF2RBlSWxWYh79TX
	 Q+dCBC/BC+NKp8c6jHVJzERmzAc6L2wdJb+F6dvmDkT1Yb/LXTXavD+FUV9QhyO7ac7YiQd5VcOU
	 ULuQ+cXnsbWcG9bg99BT3i5DCddGi9koygKRVcauyyoeCC74E9XzkiPvuzr6DF8P9zrrzD+qTy53
	 aMY+L1b9kAzj19KzhBwUesdrMr5++2Y3Hapniob5yWa2P8WTBHehl3/f50tT6wG8rMP/ijMUp8UZ
	 t2xuomGaQG89LYCOds2MSLsjguI/JKyaxrtPB2wKKKo5A33fNxDuQwoaTYMihlEgv9UHZEVvp4lV
	 ORTn0ua1aQlUmIPn2TKxY6I4YP2aHrU/XDreBhTig7wdg4ic2SFytwrd1H4rC81hOQxirAB7MW1j
	 3h+F9OQCSUgBHpwUbAsZQdX6Wq2V6SI/YhQnd8H5eq8nEVlrctI9Z9IMRRpZt2xuFsVw29RqcOmy
	 lhC6ePn02KZz/ajiDLZBmCrKjjQZKGaFF9I+c1VE277AcGwXoPwCYt7VgjF8jFrnRFbL81EBIUJv
	 RKfnraKgZfPDEfesuHXFTdgfwMxDyfUf4dr5jaA4+zmqtZgJ3egA==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
Date: Thu, 19 Mar 2026 16:40:56 +0800
From: zhanghao <76824143@qq.com>
To: Sean Christopherson <seanjc@google.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org,
	zhanghao <zhanghao1@kylinos.cn>
Subject: Re: [PATCH 2/3] KVM: x86: Skip IN_GUEST_MODE vCPUs in
 kvm_vcpu_on_spin main loop
X-OQ-MSGID: <20260319084056.GA110753@zh-pc>
References: <20260215140402.24659-1-76824143@qq.com>
 <tencent_A1CC0E76805991513AA0C982068255A6A306@qq.com>
 <aZSMFPgRO6s_fUQO@google.com>
 <tencent_AE2873502605DBDD4CD1E810F06C410F0105@qq.com>
 <abNiHqMe0mqKIsML@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <abNiHqMe0mqKIsML@google.com>

On Thu, Mar 12, 2026, Sean Christopherson wrote:
> On Thu, Mar 12, 2026, zhanghao wrote:
> > On Tue, Feb 17, 2026, Sean Christopherson wrote:
> > > On Sun, Feb 15, 2026, 76824143@qq.com wrote:
> > > > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > > > index 476ecdb18bdd..663df3a121c8 100644
> > > > --- a/virt/kvm/kvm_main.c
> > > > +++ b/virt/kvm/kvm_main.c
> > > > @@ -4026,6 +4026,10 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
> > > >  		vcpu = xa_load(&kvm->vcpu_array, idx);
> > > >  		if (!READ_ONCE(vcpu->ready))
> > > >  			continue;
> > > > +
> > > > +		if (READ_ONCE(vcpu->mode) == IN_GUEST_MODE)
> > > > +			continue;
> > > 
> > > This should generally not happen, as vcpu->ready should only be true when a vCPU
> > > is scheduled out.  Although it does look like there's a race in kvm_vcpu_wake_up()
> > > where vcpu->ready could be left %true, e.g. if the task was delyed or preempted
> > > after __kvm_vcpu_wake_up(), before the "WRITE_ONCE(vcpu->ready, true)".  Not sure
> > > how best to handle that scenario.
> > > 
> > > > +
> > > >  		if (kvm_vcpu_is_blocking(vcpu) && !vcpu_dy_runnable(vcpu))
> > > >  			continue;
> > > >  
> > > > -- 
> > > > 2.39.2
> > > >
> > 
> > Thank you for reviewing this patch. As pointed out in the discussion,
> > this addresses a race condition where kvm_vcpu_wake_up() can set
> > "ready=true" while kvm_sched_in() is concurrently setting the vCPU to
> > running state. Without this check, we might attempt to yield to a vCPU
> > that is already running, which is futile.
> 
> Right, but I want to solve this by eliminating the race, not by papering over
> the issue in kvm_vcpu_on_spin().  I don't see a sane way of handling the cross-vCPU
> writes without atomics, and I'd prefer to avoid the complexity that comes with
> that.
> 
> What if instead of having the waker set vcpu->ready, we remove it entirely and
> instead do a best-effort detection of the "vCPU was blocking, is now awake, but
> probably hasn't been scheduled in yet".  We can use a combination of flags to
> detect that, and thanks to vcpu->scheduled_out, I'm pretty sure the false positive
> rate would be on par with the existing vcpu->ready check (for the preempted case).
> 
> The idea is to identify the case where the vCPU is in the blocking sequence, but
> not actually blocking, wants to run, and is scheduled out.
> 
> Compile tested only (and I don't love the name of the helper).
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0b5d48e75b65..ac849d879b73 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10393,7 +10393,7 @@ static void kvm_sched_yield(struct kvm_vcpu *vcpu, unsigned long dest_id)
>  
>         rcu_read_unlock();
>  
> -       if (!target || !READ_ONCE(target->ready))
> +       if (!target || !kvm_vcpu_is_runnable_and_scheduled_out(target))
>                 goto no_yield;
>  
>         /* Ignore requests to yield to self */
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 581b217abc33..70739179af58 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1746,6 +1746,15 @@ static inline bool kvm_vcpu_is_blocking(struct kvm_vcpu *vcpu)
>         return rcuwait_active(kvm_arch_vcpu_get_wait(vcpu));
>  }
>  
> +static inline bool kvm_vcpu_is_runnable_and_scheduled_out(struct kvm_vcpu *vcpu)
> +{
> +       return READ_ONCE(vcpu->preempted) ||
> +              (READ_ONCE(vcpu->scheduled_out) &&
> +               READ_ONCE(vcpu->wants_to_run) &&
> +               READ_ONCE(vcpu->stat.generic.blocking) &&
> +               !kvm_vcpu_is_blocking(vcpu));
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
>         kvm_vcpu_set_in_spin_loop(vcpu, false);
>         kvm_vcpu_set_dy_eligible(vcpu, false);
>         vcpu->preempted = false;
> -       vcpu->ready = false;
>         preempt_notifier_init(&vcpu->preempt_notifier, &kvm_preempt_ops);
>         vcpu->last_used_slot = NULL;
>  
> @@ -3803,7 +3802,6 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_halt);
>  bool kvm_vcpu_wake_up(struct kvm_vcpu *vcpu)
>  {
>         if (__kvm_vcpu_wake_up(vcpu)) {
> -               WRITE_ONCE(vcpu->ready, true);
>                 ++vcpu->stat.generic.halt_wakeup;
>                 return true;
>         }
> @@ -4008,7 +4006,7 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
>                         continue;
>  
>                 vcpu = xa_load(&kvm->vcpu_array, idx);
> -               if (!READ_ONCE(vcpu->ready))
> +               if (!kvm_vcpu_is_runnable_and_scheduled_out(vcpu))
>                         continue;
>                 if (kvm_vcpu_is_blocking(vcpu) && !vcpu_dy_runnable(vcpu))
>                         continue;
> @@ -6393,7 +6391,6 @@ static void kvm_sched_in(struct preempt_notifier *pn, int cpu)
>         struct kvm_vcpu *vcpu = preempt_notifier_to_vcpu(pn);
>  
>         WRITE_ONCE(vcpu->preempted, false);
> -       WRITE_ONCE(vcpu->ready, false);
>  
>         __this_cpu_write(kvm_running_vcpu, vcpu);
>         kvm_arch_vcpu_load(vcpu, cpu);
> @@ -6408,10 +6405,9 @@ static void kvm_sched_out(struct preempt_notifier *pn,
>  
>         WRITE_ONCE(vcpu->scheduled_out, true);
>  
> -       if (task_is_runnable(current) && vcpu->wants_to_run) {
> +       if (task_is_runnable(current) && vcpu->wants_to_run)
>                 WRITE_ONCE(vcpu->preempted, true);
> -               WRITE_ONCE(vcpu->ready, true);
> -       }
> +
>         kvm_arch_vcpu_put(vcpu);
>         __this_cpu_write(kvm_running_vcpu, NULL);
>  }

Thank you for your detailed review and the alternative implementation.
I have tested both approaches and would like to share my findings.

I conducted comprehensive benchmarks using stress-ng memory pressure tests (10 rounds, 60 seconds each)
on a Proxmox VE host with Intel Xeon E5-2680 v4 processors:
  | Version | attempted | successful | Success Rate |
  |---------|-----------|------------|--------------|
  | Native  | 25,413    | 63         | 0.24%        |
  | My patch  | 15,040  | 70         | 0.46%        |
  | Your patch | 19,940 | 9          | 0.05%        |

I have tested repeatedly over multiple rounds; the number of attempts fluctuates, but 
the data is roughly as shown in the table above.

And the memory bandwidth remains consistent across all versions (~48-52 GB/s).

Your approach (removing vcpu->ready), successfully eliminates the race condition. Using 4 READ_ONCE
operations in kvm_vcpu_is_runnable_and_scheduled_out(), which is more robust but the conditions seem
overly strict, resulting in a low success rate. And the number of attempts has not decreased.

Thank you for your valuable feedback and the thorough review.

Best regards,
zhanghao

