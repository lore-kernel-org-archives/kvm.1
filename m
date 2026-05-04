Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A8C3E4C79
	for <kvm@vger.kernel.org>; Mon,  4 May 2026 17:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777916940; cv=none; b=VU6QB7G3R7TBxjRvvPb+ziRJIpihEXPLE1lOk4TTbKzsgBXkcQltyJWw0CAmpKcFUE9bzSNbp6zeX4K+FRcIUvNX/pZHizK7QQA4sRYxu5Cs5jgIK+87JLvk2d7GRk4V4xr6RBubK0HMV8CGgPXf3XyTpWkXXT2gvxfASDbkk5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777916940; c=relaxed/simple;
	bh=aFSWT5+JomGpZyfjwGe0nLTWjmw94/01p995P9goFxk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LTC6lXtICKXbLFJF4DGddYCI7C0S+JQ5IU6x6sqqDNdlzbvWBS9XmY4UzNHDD7xg/dOhIQG0ARBznxyH1F3s8Jo1EGCLVFJwL9mBxaIj3vk9D5sjJhVPUsTBTTgfCJT1NdzSV1nc3KctXZqRcKtLy65aFE0DuTFwNZMGMWLlFuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NLHjvwWq; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NLHjvwWq"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35641c14663so5256308a91.2
        for <kvm@vger.kernel.org>; Mon, 04 May 2026 10:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777916938; x=1778521738; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T5fi3BNpMmV0U3KZiz1FE4mL3eOmPwlwIV/wd+WRs9U=;
        b=NLHjvwWqx3yXmAnuo/uwM6pieNL4OLLyCS9+4DQcqI2SQ1z2ncRwgutx1mMcT3RvjE
         D9Imx0AxNy01fDiKK1S1ot7nnJUm7IwFtATHrNLN4vCSrm2x6rlEjBQl5l6PT4sm2gSZ
         lrnxInG5Ykacs3VI+SY0hV331wXrBrE6r7SJMvA1bMNAWzQWmj5LVnF/4KaUE8clogsk
         +igDTmZvKYIZRLKV7GABZvf4KijrW2TlN/gwGKXLO8SDw0KS7xiE9pxLVmJdiGd15Vm1
         QglRxVzK4j0XkRCeMKh/A+F+xoJ6YDaIQNPMZNsqYgcbFBlK3fsDa9jQfgnAY+0m5z+7
         QhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777916938; x=1778521738;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T5fi3BNpMmV0U3KZiz1FE4mL3eOmPwlwIV/wd+WRs9U=;
        b=Osy4hf9MZS+bRH0NSVDNKx9Inl2iv2Kr4pDBXUbG7xtsVZf0s8mGmEu2CBUSmGkZga
         txcCu8a4/jBwd7EHHeU9MkUuV82MZx4rk44bInW9ElJB7IhDb0edvugDt+nf1QN57dOu
         f6mnLA/h3lM8fNZlokqGUg0a/U6oLZ+06xu48iitOTiBueBiSlzLEAh2zSTnBapszJP/
         4wOyEwZSTmufVZtgAfgFynZ5JttSAmpIAvL5JUF7kHMBkuPe0WAd8TSMe014v/pLE8yv
         zaW4skfC0BHFpHNnjlZXgGEP21bd+T37okEPi8+cWayaFbQJ/MHPVeGZgE1eBDE1YeIX
         GDqQ==
X-Forwarded-Encrypted: i=1; AFNElJ9K50ZSoDTvZhaadDmoDZerF9WRfQDsLDlLnBMd/LGFRSeYEmApCLm4r7Qr5G4h/e4IHyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyWxlAkIiWqR55cQ/Ymn/YkkeQ/dDysrTwEi+/5MuS0Sfqi7rT
	Wt/X/NnXyypgtoO4T7y/zffk7waEXXHZ4KiT9eBVTKHkXckcPUSvkFpsaZew23bIEYpSVxJoezY
	DeU51Tw==
X-Received: from pgab75.prod.google.com ([2002:a63:344e:0:b0:c80:16d6:ed0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1e62:b0:3a8:9dd:75bb
 with SMTP id adf61e73a8af0-3a809dde19fmr5831338637.56.1777916937874; Mon, 04
 May 2026 10:48:57 -0700 (PDT)
Date: Mon, 4 May 2026 10:48:56 -0700
In-Reply-To: <20260503174534.45699-1-mikhail.v.gavrilov@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503174534.45699-1-mikhail.v.gavrilov@gmail.com>
Message-ID: <afjcCBGzuZU2iON9@google.com>
Subject: Re: [PATCH] x86/virt: Fix RCU lockdep splat in emergency virt
 callback path
From: Sean Christopherson <seanjc@google.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Dan Williams <djbw@kernel.org>, Chao Gao <chao.gao@intel.com>, x86@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sun, May 03, 2026, Mikhail Gavrilov wrote:
> x86_virt_invoke_kvm_emergency_callback() reaches rcu_dereference()
> through machine_crash_shutdown() with IRQs disabled but with RCU not
> necessarily watching, which triggers a suspicious RCU usage splat on
> debug kernels (CONFIG_PROVE_RCU=y) during panic/kdump:
> 
> WARNING: suspicious RCU usage
> arch/x86/virt/hw.c:52 suspicious rcu_dereference_check() usage!
> 
> other info that might help us debug this:
> 
> rcu_scheduler_active = 2, debug_locks = 1
> 1 lock held by tee/11119:
>  #0: ffff8881fa32c440 (sb_writers#3){.+.+}-{0:0}, at: ksys_write
> 
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x84/0xd0
>  lockdep_rcu_suspicious.cold+0x37/0x8f
>  x86_virt_invoke_kvm_emergency_callback+0x5f/0x70
>  x86_svm_emergency_disable_virtualization_cpu+0x2a/0x30
>  x86_virt_emergency_disable_virtualization_cpu+0x6b/0x90
>  native_machine_crash_shutdown+0x72/0x170
>  __crash_kexec+0x137/0x280
>  panic+0xce/0xd0
>  sysrq_handle_crash+0x1f/0x20
>  __handle_sysrq.cold+0x192/0x335
>  write_sysrq_trigger+0x8c/0xc0
>  proc_reg_write+0x1c3/0x3c0
>  vfs_write+0x1d0/0xf80
>  ksys_write+0x116/0x250
>  do_syscall_64+0x11c/0x1480
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>  </TASK>
> 
> The RCU usage is correct: writers
> (x86_virt_{register,unregister}_emergency_callback()) serialize via
> rcu_assign_pointer() + synchronize_rcu(), while the reader on the
> emergency path runs with IRQs disabled (the only caller is
> x86_virt_emergency_disable_virtualization_cpu(), which has
> lockdep_assert_irqs_disabled()), which is a valid classic-RCU read-side
> critical section.
> 
> Use rcu_dereference_check() with irqs_disabled() to silence the splat
> without weakening the protection.
> 
> Reproducible on a debug kernel (CONFIG_PROVE_LOCKING=y, CONFIG_PROVE_RCU=y)
> with kvm_amd or kvm_intel loaded by triggering kdump:
> 
>   echo c > /proc/sysrq-trigger
> 
> Fixes: 428afac5a8ea ("KVM: x86: Move bulk of emergency virtualizaton logic to virt subsystem")
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> ---
>  arch/x86/virt/hw.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/virt/hw.c b/arch/x86/virt/hw.c
> index f647557d38ac..57eebc99299d 100644
> --- a/arch/x86/virt/hw.c
> +++ b/arch/x86/virt/hw.c
> @@ -49,7 +49,13 @@ static void x86_virt_invoke_kvm_emergency_callback(void)
>  {
>  	cpu_emergency_virt_cb *kvm_callback;
>  
> -	kvm_callback = rcu_dereference(kvm_emergency_callback);
> +	/*
> +	 * Callers invoke this with IRQs disabled (see
> +	 * x86_virt_emergency_disable_virtualization_cpu()), which is a valid
> +	 * RCU read-side critical section. Tell lockdep so it doesn't complain
> +	 * during panic/reboot paths.
> +	 */
> +	kvm_callback = rcu_dereference_check(kvm_emergency_callback, irqs_disabled());

This feels wrong.  If RCU truly isn't watching this CPU, then isn't RCU allowed
to ignore this CPU when synchronizing?

>  	if (kvm_callback)
>  		kvm_callback();
>  }
> -- 
> 2.54.0
> 
