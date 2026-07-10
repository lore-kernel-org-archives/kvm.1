Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E10A42A787
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 12:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783688008; cv=none; b=VoJXbqYZCvHLsOExBUFqZIi8Iimxckpxa4NkkCGZHDyVnRWYSLBvJy9rog2bxCL0iOvU5jRWASrtG2FIduwLUfm2pWO9ecJb6bObNFmDgZpWus68aV2YGZ0D0kE2myqCAZt8TPkZUzIpgAVNHxSpVk/Pvchi6W2B47UeZ/TXt0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783688008; c=relaxed/simple;
	bh=rDCXmiuS4OKEeEN/C5vghC+XVuZsf7eWZKIthL9flVA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JaffHZ8h7IBqV3KUjPmw08HFNVVCJVDytcGv0oc65xXQq7MtfJA3ljl6GluMBaQh39ICr0QXjowdAxSsrwzYB8FHqsqrXAVODvSgKRj99rm8kiOxyUfFomq2rcUvDFs3UrhXm7Rhai4UZLT7NdtwiCUy+ADUP6SAV3gIcQPs4Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DY1Jc3c5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=p4e6A66f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DY1Jc3c5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="p4e6A66f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783688005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A796is8L3HyhHQ35rzweG5BKz7iNVXWLCRoCMdbZDUo=;
	b=DY1Jc3c5W4/Wu3PpyeleItAuJntPa83UuP6TtvaJn+JiXhpWmD3V1E2nxfwwwvaJNAU5YU
	7orEqVNOo2EE+OdvuuWLj0XjW0NkvipqStee2hwUzVO3vmQFn+8DaiwUBtefw1UQEIZ/G9
	Z1Gze0A5STSmgzNTeh2ht+hVQomgdqw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-kxuuWBxtN6y38wHMf0CwXw-1; Fri, 10 Jul 2026 08:53:22 -0400
X-MC-Unique: kxuuWBxtN6y38wHMf0CwXw-1
X-Mimecast-MFC-AGG-ID: kxuuWBxtN6y38wHMf0CwXw_1783688001
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-493a7fa8481so10437735e9.1
        for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 05:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783688001; x=1784292801; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A796is8L3HyhHQ35rzweG5BKz7iNVXWLCRoCMdbZDUo=;
        b=p4e6A66fg8sy5VshukPDO0WCQuFTu/7thg3uBEA2dA+BuTcAfHye6AbIYXacxQd1Rt
         xTyMfrE4DVdut7mmsjCbkUG4wkxO7MLFu9oMUIatl7r+NUNyz/Y/9A9INKvVfW2d9bwG
         qTV4+RB2BsFNikeAL0ERuwjV+wHJSuwZ0Q55C7lse4UiMRjQxJ6PRFkM0P12P8ylHo2X
         goYCQ2S+Ar4Ir0rP8XZ4oQRS2IcqM1FVO5aEm1YL9CN3yQtLlLe+u7wr1N8pGPlw76Ma
         niaw0PtRqarZhdbPTXAkbUTGc6zkqt59wt+Tt3J1pDnT3QptOci4SyOQRLodsPhrl4jD
         LpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783688001; x=1784292801;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A796is8L3HyhHQ35rzweG5BKz7iNVXWLCRoCMdbZDUo=;
        b=CR/SNeGH3B+SaydC3jzyt3RyTAvs4c5Ukfh0ZEATCELROZNli+sMhWHV5uljHbcHE9
         v+GI+RQe75j3TOIdfKohNFP9VWwZFX4QbQ4lf8EyER6SpsSOouC37l+F+PmgcbAeBzMh
         PutKS+blp1bElcqW0ty/tg0D7bnn1NHhLc2m7gdDGx2wV7UPhxcucVDh3XN40qC555dq
         xIXnaszSTDLkRO6ja+lbzVwr9tFlz6aFQrDGuwZfdxDNBHcyODAWqRgGj+YsleZRt7BL
         rTIP/4DYNd6OztmS65URhoTG1rnHb8/0sk1CnJPzYbxTpbkp9mX9r+tV0/TUmvyTRzw9
         PVfg==
X-Forwarded-Encrypted: i=1; AHgh+Rr2uA3Q6cFWjkOZuGk0xdLdyoDjwKuGZTU0PVV4p86j2Z6uuvab+rUWUOltmBtnmBsXvpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQPEnpxdS2UYXKxzr552hWIrTzvCBQ6zFPxaQBZLNqPSHMoWCf
	9L+06bYtXimpAjBNfzpO9ia4+aqckQBPdwkdMriJiqcUkxcovzrQCz4AyT7VP2TPXXoDS/1TbKD
	xpoXUKCf+qSkB7EYbmY/ILhepuYN3BZQKnABJngUduADQTCUPZRMUbA==
X-Gm-Gg: AfdE7cn908MnD9hb+gpgp4qFnjpYmPLcoCFnwrwN7yt/ARyWkVgRO/2rjv/1yMWzNvz
	zaAwN7mkPBn/ayW8NsiLh4vhCMQo0Q5jkr0t5WvGpZhTdrdY4Kt0Rxi/3glei+3icVKNLYzTqCI
	H/VSdJsxBd4wDTxjKCBgO2rQ15mOpPDpZbUo74zNC0ZXKO6AZaVwx27XwC61Em3qHP5hugnPBIq
	rXGnlFurdPB3xqB+sr0hqJlCRR0d48zTQbGnhBu+JT1kx80C5WYgTtEhmeljtq2tLZqgUtO4sXx
	cHRTdabHgpvmUFPWel/3kVoj4fSSgz5aZdRiibfAPeqj0hYJcEzfzL8q+mEyWimXHkN3TR19GiC
	OEz4=
X-Received: by 2002:a05:600c:4858:b0:493:edde:54c8 with SMTP id 5b1f17b1804b1-493f2b2ece3mr19929965e9.8.1783688000884;
        Fri, 10 Jul 2026 05:53:20 -0700 (PDT)
X-Received: by 2002:a05:600c:4858:b0:493:edde:54c8 with SMTP id 5b1f17b1804b1-493f2b2ece3mr19929715e9.8.1783688000382;
        Fri, 10 Jul 2026 05:53:20 -0700 (PDT)
Received: from fedora ([91.219.240.20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb70a372sm135247465e9.7.2026.07.10.05.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 05:53:19 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Carlos =?utf-8?Q?L=C3=B3pez?= <clopez@suse.de>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: syzbot+3d5461510f8dc4adfe30@syzkaller.appspotmail.com, Sean
 Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H.
 Peter Anvin" <hpa@zytor.com>, Roman Kagan <rkagan@virtuozzo.com>, Andrey
 Smetanin <asmetanin@virtuozzo.com>
Subject: Re: [PATCH] KVM: x86: hyper-v: Clamp stimer deadline to avoid livelock
In-Reply-To: <20260703205201.2667136-1-clopez@suse.de>
References: <20260703205201.2667136-1-clopez@suse.de>
Date: Fri, 10 Jul 2026 14:53:18 +0200
Message-ID: <87tsq7f1kx.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Carlos L=C3=B3pez <clopez@suse.de> writes:

> Fix an issue where userspace or the guest can program an Hyper-V
> synthetic timer to have a deadline in the past via integer overflow,
> preventing the CPU from making progress and triggering an RCU stall.
>
> Hyper-V's SynIC exposes 4 per-vCPU synthetic timers to the
> guest, which are emulated by KVM. Each is programmed through the
> HV_X64_MSR_STIMERi_CONFIG and HV_X64_MSR_STIMERi_COUNT MSRs. Depending
> on CONFIG, COUNT represents either the absolute expiration time or the
> period of a periodic timer, both expressed in 100ns ticks. These timers
> may be set both by the guest (WRMSR) and the host (KVM_SET_MSRS).
>
> When the timer is enabled, stimer_start() translates COUNT to an
> absolute monotonic deadline and arms an hrtimer. If COUNT is set to a
> value close to U64_MAX, the deadline calculation can overflow.
>
>     ktime_add_ns(ktime_now, 100 * (stimer->exp_time - time_now))
>
> This can result in a CPU livelock. stimer_start() arms the timer
> via hrtimer_start() with a deadline in the past, which causes it to
> immediately fire. The stimer callback then raises KVM_RQ_HV_STIMER, with
> the intention of causing KVM to deliver a synthetic interrupt on the
> next vCPU guest enter.
>
> Then, once userspace issues KVM_RUN, vcpu_enter_guest() consumes the
> request, calling kvm_hv_process_stimers(). This would normally disable
> the timer via stimer_expiration() once the deadline is in the past.
> However, the deadline comparison is done between the KVM reference
> counter and stime->exp_time, which is a big value close to U64_MAX, so
> this never happens for a few thousand years.
>
> kvm_hv_process_timers() then re-arms the timer via stimer_start(), since
> it was not disabled, which again fires immediately. Before entering
> the guest, kvm_vcpu_exit_request() checks kvm_request_pending(),
> which returns true due to the newly raised KVM_REQ_HV_STIMER. Then
> vcpu_enter_guest() aborts the guest entry, returning early into
> vcpu_run(), which loops back again into vcpu_enter_guest(), restarting
> the cycle.
>
> Since there are no manual yields in this loop, a task with SCHED_FIFO
> may starve RCU grace-period kthreads, which exposes the stalls found
> by syzcaller:
>
>     rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>     rcu:    (detected by 1, t=3D10502 jiffies, g=3D14269, q=3D1142 ncpus=
=3D2)
>     rcu: All QSes seen, last rcu_preempt kthread activity 10500 (42949652=
39-4294954739), jiffies_till_next_fqs=3D1, root ->qsmask 0x0
>     rcu: rcu_preempt kthread starved for 10500 jiffies! g14269 f0x2 RCU_G=
P_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
>     rcu:    Unless rcu_preempt kthread gets sufficient CPU time, OOM is n=
ow expected behavior.
>         ( ... )
>     Call Trace:
>      <IRQ>
>      __run_hrtimer kernel/time/hrtimer.c:1773 [inline]
>      __hrtimer_run_queues+0x408/0xc30 kernel/time/hrtimer.c:1841
>      hrtimer_interrupt+0x45b/0xaa0 kernel/time/hrtimer.c:1903
>      local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1045 [inline]
>      __sysvec_apic_timer_interrupt+0x102/0x3e0 arch/x86/kernel/apic/apic.=
c:1062
>      instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [=
inline]
>      sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:10=
56
>      </IRQ>
>      <TASK>
>      asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idten=
try.h:697
>     RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp=
.h:152 [inline]
>     RIP: 0010:_raw_spin_unlock_irqrestore+0xa8/0x110 kernel/locking/spinl=
ock.c:194
>     Code: 74 05 e8 0b f4 5f f6 48 c7 44 24 20 00 00 00 00 9c 8f 44 24 20 =
f6 44 24 21 02 75 4f f7 c3 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> 23 6b 2=
7 f6 65 8b 05 7c 60 5a 07 85 c0 74 40 48 c7 04 24 0e 36
>     RSP: 0018:ffffc900040a7320 EFLAGS: 00000206
>     RAX: 5de15cb931505900 RBX: 0000000000000a06 RCX: 5de15cb931505900
>     RDX: 0000000000000007 RSI: ffffffff8daa9dc3 RDI: 0000000000000001
>     RBP: ffffc900040a73b0 R08: ffffffff8fc3d077 R09: 1ffffffff1f87a0e
>     R10: dffffc0000000000 R11: fffffbfff1f87a0f R12: dffffc0000000000
>     R13: 0000000000000000 R14: ffff8880b8628240 R15: 1ffff92000814e64
>      hrtimer_start include/linux/hrtimer.h:259 [inline]
>      stimer_start arch/x86/kvm/hyperv.c:682 [inline]
>      kvm_hv_process_stimers+0xd0a/0x16a0 arch/x86/kvm/hyperv.c:893
>      vcpu_enter_guest arch/x86/kvm/x86.c:11193 [inline]
>      vcpu_run+0x2240/0x76b0 arch/x86/kvm/x86.c:11639
>      kvm_arch_vcpu_ioctl_run+0x1148/0x1c90 arch/x86/kvm/x86.c:11984
>      kvm_vcpu_ioctl+0x99a/0xed0 virt/kvm/kvm_main.c:4492
>      vfs_ioctl fs/ioctl.c:51 [inline]
>      __do_sys_ioctl fs/ioctl.c:597 [inline]
>      __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
>      do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>      do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
>      entry_SYSCALL_64_after_hwframe+0x77/0x7f
>     RIP: 0033:0x7f635278f749
>     Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 =
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f=
0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
>     RSP: 002b:00007f635365c038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>     RAX: ffffffffffffffda RBX: 00007f63529e5fa0 RCX: 00007f635278f749
>     RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000005
>     RBP: 00007f6352813f91 R08: 0000000000000000 R09: 0000000000000000
>     R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>     R13: 00007f63529e6038 R14: 00007f63529e5fa0 R15: 00007ffd5b219358
>      </TASK>
>
> Fix this by clamping the deadline computation to KTIME_MAX, which
> preserves the intent of arming a timer very far in the future.
> ktime_add_safe() already does this type of clamping, so use it after
> checking that that multiplying by the 100ns time tick also does not
> overflow.
>
> Reported-by: syzbot+3d5461510f8dc4adfe30@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D3d5461510f8dc4adfe30
> Fixes: 1f4b34f825e8 ("kvm/x86: Hyper-V SynIC timers")
> Signed-off-by: Carlos L=C3=B3pez <clopez@suse.de>
> ---
>  arch/x86/kvm/hyperv.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index fd4eb1e561f7..315635d36606 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -626,6 +626,17 @@ static enum hrtimer_restart stimer_timer_callback(st=
ruct hrtimer *timer)
>  	return HRTIMER_NORESTART;
>  }
>=20=20
> +/*
> + * Translate a stimer expiry given in 100ns reference ticks into an
> + * an absolute deadline. Saturates on overflow.
> + */
> +static ktime_t stimer_add_delta(ktime_t now, u64 delta_100ns)
> +{
> +	if (delta_100ns > KTIME_MAX / 100)
> +		return KTIME_MAX;
> +	return ktime_add_safe(now, 100 * delta_100ns);

My Claude believes '>=3D' check would be better and the explanations sounds
somewhat plausible to me:

"=20
  The guard delta_100ns > KTIME_MAX / 100 uses strict >, so the
  boundary value delta_100ns =3D=3D 92233720368547758 passes through. The
  product 9223372036854775800 fits in s64, but adding any real ktime_now
  (always >> 8ns) overflows.

  ktime_add_safe then clamps to ktime_set(KTIME_SEC_MAX, 0) =3D
  9223372036000000000 =E2=80=94 about 854ms less than KTIME_MAX. Two overfl=
ow
  paths, two different saturation values. Fix: change > to >=3D.
"=20

I don't know if someone programming a timer to fire many years from now
would be really disappinted when it fires 854ms early though.

> +}
> +
>  /*
>   * stimer_start() assumptions:
>   * a) stimer->count is not equal to 0
> @@ -635,6 +646,7 @@ static int stimer_start(struct kvm_vcpu_hv_stimer *st=
imer)
>  {
>  	u64 time_now;
>  	ktime_t ktime_now;
> +	ktime_t deadline;
>=20=20
>  	time_now =3D get_time_ref_counter(hv_stimer_to_vcpu(stimer)->kvm);
>  	ktime_now =3D ktime_get();
> @@ -657,10 +669,8 @@ static int stimer_start(struct kvm_vcpu_hv_stimer *s=
timer)
>  					stimer->index,
>  					time_now, stimer->exp_time);
>=20=20
> -		hrtimer_start(&stimer->timer,
> -			      ktime_add_ns(ktime_now,
> -					   100 * (stimer->exp_time - time_now)),
> -			      HRTIMER_MODE_ABS);
> +		deadline =3D stimer_add_delta(ktime_now, stimer->exp_time - time_now);
> +		hrtimer_start(&stimer->timer, deadline, HRTIMER_MODE_ABS);
>  		return 0;
>  	}
>  	stimer->exp_time =3D stimer->count;
> @@ -679,9 +689,9 @@ static int stimer_start(struct kvm_vcpu_hv_stimer *st=
imer)
>  					   stimer->index,
>  					   time_now, stimer->count);
>=20=20
> -	hrtimer_start(&stimer->timer,
> -		      ktime_add_ns(ktime_now, 100 * (stimer->count - time_now)),
> -		      HRTIMER_MODE_ABS);
> +	deadline =3D stimer_add_delta(ktime_now, stimer->count - time_now);
> +	hrtimer_start(&stimer->timer, deadline, HRTIMER_MODE_ABS);
> +
>  	return 0;
>  }
>=20=20
>
> base-commit: 50406d35f5635e1cc523e61409d57e851b5f5df8

With or without '>=3D' fix above,

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

we don't have any stimer tests in KVM selftests but we do have some in
KVM unit tests. It would be great to add something there for the issue.

--=20
Vitaly

