Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8185261B8D
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 19:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775762503; cv=none; b=UNEU0vZui9bLIXR6QS/LdV4bTlTJK4p2JJcWDAznMaReuOiwkZeD7paqijPyRbfXwanK3zifqPKuWXsW2YDK5YgYAEBDZ5iRup/qlx7VyxOqaCxqXCjL5xPJVcIEN0fkirf/Dk+gfOFMkjpvJn8H4+50xKSwT4lM32f3LtbJfI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775762503; c=relaxed/simple;
	bh=0ZUibzMlFt27+qnvFeWEJOE8fSiragqdhD/kE1H1jcg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lIF5jTJloJ7KWCiNlMz+Cu2G3DbL5VnjuLE3j3Vo/RbLhvCu/78iz60+o8eIdJThHPL8CEvx1TVHvWQttt+azT4/qtbt75HovI069irfSqvZl9tBO2fPdZ/nv7aZQ26rpOf3TkW3q5MnTd54gj5yAzK5VelK8ebY4AheuG657GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WicOS2Jr; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WicOS2Jr"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82c9364612fso1441809b3a.2
        for <kvm@vger.kernel.org>; Thu, 09 Apr 2026 12:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775762501; x=1776367301; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S24yd/CVNeZ+2E1UTepdbbCURDcbghCN8cxIVIYnLFg=;
        b=WicOS2JrHuORgIU+9D3tZoXJfE4A+s+9wU9F8m2kMbXbTZ+LNce4w00ONy1R+Opfrf
         JifiIx7QkFSvnhsShb8KcFHQd131d/SzFNkc6E8r4JvzZyGYvvSLct4219qi5M4MQPkA
         OTPP44oMMU2iO8/gfManHc5Zl/bqX9JoFkIjPkK22m4m+rpaIkbCHhFZreOHZPNdLihf
         a0u5yOPHBY3mdhf3xEhTFenRvARIJ1v0p/Zmpx6hoCZLwj2vu/dtJKQdgT14ZNN7CDgs
         2eqedhv8Ps7/wCj+Kh1WwQN4g1dD3CDaSKwT0dTh+PUGAYZJ77DzezUJDPnZjL1T8n4B
         qy7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775762501; x=1776367301;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S24yd/CVNeZ+2E1UTepdbbCURDcbghCN8cxIVIYnLFg=;
        b=LR7MhopiFfMSqi3AtvtluZsBNNr741D3rCX9W/ypQ9t29onGSStgK5AG+aekAhjxRy
         /7pepso7COJjDSc50pS6ev/3nXd0zdbr3722I8sAZ3HC7odIDUWT3mLphCb3u/dTQe58
         xQMtT3qfynekNaLxUQEM1wvAPhbYkNWp45tnaMC9Th+oa7V1e7A+tcfzvO9K4hNJj1lI
         54fkDzaAUHHHy/mgwixGNKHt4nzKKeZCD7YXVl9flvC49cFNED3v6xab+haWWWgOAxNx
         uJjxdVYIuwxK4F3bx/o/KzF15aBXMHAA3aF2RDvWUgH56UOboTZgzKqy1shouGauB5Dg
         JFXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSXSNbrWlVnt5xWFjy+TXzqEFa4yZrclUC1quL7YZbS94Xf3w2nhP1SYT+j5feXEsCnvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVdnnEjt9II16ccwc2IXImoNUuRVI2A2Hg8tWcyBy/diZxgdVA
	k/2lbu4Pp5OMbEUXjsOauUEV1Qu6TOUa7w8K9jO+xxWjrnOek7Kw9WyZKzPAQu2Gk03kaBlnBuh
	vPu10Cg==
X-Received: from pfcg3.prod.google.com ([2002:a05:6a00:23c3:b0:829:8b7d:2b76])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4088:b0:82c:68f6:a18
 with SMTP id d2e1a72fcca58-82f0c29fe5cmr368952b3a.34.1775762500815; Thu, 09
 Apr 2026 12:21:40 -0700 (PDT)
Date: Thu, 9 Apr 2026 12:21:39 -0700
In-Reply-To: <20260409142226.2581-1-lei.chen@smartx.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <adVGrJaRlRooO4su@google.com> <20260409142226.2581-1-lei.chen@smartx.com>
Message-ID: <adf8Q1VSeAMMyCa_@google.com>
Subject: Re: [PATCH v2] KVM: x86: Rate-limit global clock updates on vCPU load
From: Sean Christopherson <seanjc@google.com>
To: Lei Chen <lei.chen@smartx.com>
Cc: igor@gooddata.com, jan.cipa@gooddata.com, jaroslav.pulchart@gooddata.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 09, 2026, Lei Chen wrote:
> commit 446fcce2a52b ("Revert "x86: kvm: rate-limit global clock updates"")
> dropped the rate limiting for KVM_REQ_GLOBAL_CLOCK_UPDATE.
> 
> As a result, kvm_arch_vcpu_load() can queue global clock update requests
> every time a vCPU is scheduled when the master clock is disabled or when
> the vCPU is loaded for the first time.
> 
> Restore the throttling with a per-VM ratelimit state and gate
> KVM_REQ_GLOBAL_CLOCK_UPDATE through __ratelimit(), so frequent vCPU
> scheduling does not generate a steady stream of redundant clock update
> requests.
> 
> Fixes: 446fcce2a52b ("Revert "x86: kvm: rate-limit global clock updates"")
> Signed-off-by: Lei Chen <lei.chen@smartx.com>
> Reported-by: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
> Closes: https://lore.kernel.org/all/CAK8fFZ5gY8_Mw2A=iZVFNVKQNrXQzVsn-HTd+Me9K6ZfmdgA+Q@mail.gmail.com/
> ---
> CHANGELOG:
> v2:
> - remove comment of kvmclock_update_rs
> - make sure kvm_arch_vcpu_load make KVM_REQ_CLOCK_UPDATE for this vcpu
> - add RATELIMIT_MSG_ON_RELEASE to kvmclock_update_rs
> 
> v1:
> - initial version(https://lore.kernel.org/all/20260407070046.2336-1-lei.chen@smartx.com/)
> ---
>  arch/x86/include/asm/kvm_host.h |  1 +
>  arch/x86/kvm/x86.c              | 11 +++++++++--
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 5a3bfa293e8b..5e750c49d21e 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1453,6 +1453,7 @@ struct kvm_arch {
>  	bool use_master_clock;
>  	u64 master_kernel_ns;
>  	u64 master_cycle_now;
> +	struct ratelimit_state kvmclock_update_rs;
>  
>  #ifdef CONFIG_KVM_HYPERV
>  	struct kvm_hv hyperv;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 63afdb6bb078..a534e8391611 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5210,8 +5210,13 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
>  		 * On a host with synchronized TSC, there is no need to update
>  		 * kvmclock on vcpu->cpu migration
>  		 */
> -		if (!vcpu->kvm->arch.use_master_clock || vcpu->cpu == -1)
> -			kvm_make_request(KVM_REQ_GLOBAL_CLOCK_UPDATE, vcpu);
> +		if (!vcpu->kvm->arch.use_master_clock || vcpu->cpu == -1) {
> +			if (__ratelimit(&vcpu->kvm->arch.kvmclock_update_rs))
> +				kvm_make_request(KVM_REQ_GLOBAL_CLOCK_UPDATE, vcpu);
> +			else
> +				kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);

What I was trying to call out in my review of v1, is that prior to commit
446fcce2a52b, the effectively ratelimiting applied to *all* instances of
KVM_REQ_GLOBAL_CLOCK_UPDATE.  Which meant that KVM's existing behavior is that
kvm_write_system_time() would be subject to the ratelimiting as well.

That said, I don't see any obvious problems with immediately honoring writes to
MSR_KVM_SYSTEM_TIME{,_NEW}, and it's probably a much better experience for the
guest.  So I'm a-ok with this approach, but we should call out that skipping the
synthetic MSR case is deliberate.  No need for a v3, I'll add a blurb when
applying.

> +		}
> +
>  		if (vcpu->cpu != cpu)
>  			kvm_make_request(KVM_REQ_MIGRATE_TIMER, vcpu);
>  		vcpu->cpu = cpu;
> @@ -13189,6 +13194,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>  	raw_spin_lock_init(&kvm->arch.tsc_write_lock);
>  	mutex_init(&kvm->arch.apic_map_lock);
>  	seqcount_raw_spinlock_init(&kvm->arch.pvclock_sc, &kvm->arch.tsc_write_lock);
> +	ratelimit_state_init(&kvm->arch.kvmclock_update_rs, HZ, 10);
> +	ratelimit_set_flags(&kvm->arch.kvmclock_update_rs, RATELIMIT_MSG_ON_RELEASE);

IIUC, so long was KVM doesn't explicitly invoke ratelimit_state_exit(), setting
RATELIMIT_MSG_ON_RELEASE means we won't get dmesg spam?  To be clear, I'm 100%
in favor of suppressing dmesg output.

>  	kvm->arch.kvmclock_offset = -get_kvmclock_base_ns();
>  
>  	raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
> -- 
> 2.51.0
> 
