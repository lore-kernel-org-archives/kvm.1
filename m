Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B31B2E401
	for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 05:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774415975; cv=none; b=pkPDE4UWQExDfpBaIINNtljL/svfVyzvUN98rkluygOZ1kXOcd8M43OIAXBqaG4Z0nW/36KTlS/H/QNKrS0fIdnf9igJmizOEYxuGIdIBz+G7/l4VgPw72N/Nd9PH0qck6HDiqEXfDZUCp5PnMYl2CfiBzMZKRdTsuEPyqW6jXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774415975; c=relaxed/simple;
	bh=bEt1AYgfM9UBslLunNjznIM4Ki6cn7g2O1ogCW1PRoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGHx78F7SgvVM+aVWMrxqwfCUZKhhgUtn9YOWFnl7bSoKLbsBTXaAi5ec3smo0vv6vcMLC/wolG3kqPwhxgZWuMEdbLosoQ/cjsUNYwYuGBN2+OOa1AdgTNu3/aL44q5Jrgea8IpC62PBmvmlgYKIAUqBNEn3SGoA2pnw7rxLVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GojlcczV; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GojlcczV"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35c124d2613so49595a91.2
        for <kvm@vger.kernel.org>; Tue, 24 Mar 2026 22:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774415973; x=1775020773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iqy+w6sTastVCRcE15RxXg8vVmEuKZ1PwWM3V+SQr/k=;
        b=GojlcczVTl5iAXSYtKfr0fo64KILiIFUuCXHl+yKpWHvQLUc1cputn6f1oWSW8xFt+
         eMBCUEG0JtniTs2nZXqG1TyKkwH6/53WIC2Q98B7vAVJdUNz2dViB3y69c3Nnw5weEln
         k9F2GSkpW1mMmAy7g+YKMnB86MF6lSRTd1UUt3lJD2NfkyrF7+v+o+SYUNB+UFgzDg4r
         u0BIBdlAACZCrpDwOo94GUXtFwtO5L+Uxm3YskdGGpxg3TVuD2Z3SRPQKeNAdfvQQSK7
         8bXt1uPYRa+ZHp+oS5eqgekiLy8f29Zhx070BpzEsTk0qA+tQxJ+yClOb2nIbQI1TWPc
         LaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774415973; x=1775020773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iqy+w6sTastVCRcE15RxXg8vVmEuKZ1PwWM3V+SQr/k=;
        b=LO0DEVQ5hYHyWzBSeeG+U+sonr6GCdMQXFEtG3mr+ljkTo61OjW6/7Ckyl6SzFKllg
         68pMkAmAuESG18Cz+3WSaQ0ugxvgItYvlyvp/jlCq4IVyUma5aem+j91Z3AGFlRZFH8N
         blzgHf8XRovWkreFAlIF7vWOZmEeIO1AiQw0Xcf/ctUQZjB517ahOo6y8D4qyvESwXZU
         kt2gs26tCaF8Zis/0FbFy+cPD5vbjtnr1sEtieWEkS6LtnsrckePNV+Sxh//XhA3uGaX
         BGk3hLYuGXN+IfF0NpFe7loIx4k85Hww6bTz8Aka/NHau65o0i9zPNUQigOb79eruIK7
         +ySA==
X-Forwarded-Encrypted: i=1; AJvYcCVLJOwf9V/nIPeITuqvfDqHe0DX8w+FdWDD6+UfGuxBlGso6lsgxOmA/G6ps6RU5k0HCK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZpSQXumB5dWHCRnvZzwcuPXd7g+d6BYjDSIF2QkWmdyzsoWQ/
	fImdfacP29rT3IreX/8Z6FBUnnGThkyCqRNWGzKZgG5PFT/EUfDWhuXpP3wiN+Db
X-Gm-Gg: ATEYQzyEI7AXCsNU70aNfHIQk2B07uOVIg+bvo5YUxxqLWaIj2PpO1onpCkhCT5wnGo
	5G1wEQ5elc1GoQsf7XsntC2YT8e+SULUM/w/0QiSbIPmMak8TAiBFlvYOhRvyQQHvClH8KPEgbg
	8f1njH5dHQ9td4enGW/l1BCy/9NUMvcSeSLg4Ddj52xiKSsqfltwc3Gm/k4mOaWTw1HciDtecJS
	GcYGk4nYEM2+KhkCRGwmOdmDs4n1qwQ7LMK5/KFD5upq5UflaH/GI/g0BT4z/CgQlmjNMkwEmiw
	eqa0SyEPoVcy/ReFeybn+LunugXaA87hoccR4lqDd3qIG587KaoCW42Iq+xGiKO5jdJ2ATVugxR
	wSshmnbNoSNS6Sp8iMWR6kQXuc+6NYTt0zfaJYQv781G0FpSoRgfgPSrG+piHCm4/Kz/VTmaRr9
	7U4rWwhCYz0eQcbDJb05adHOe9
X-Received: by 2002:a17:903:8c6:b0:2b0:af2f:b25d with SMTP id d9443c01a7336-2b0b0a47a18mr26044955ad.22.1774415973199;
        Tue, 24 Mar 2026 22:19:33 -0700 (PDT)
Received: from localhost ([115.96.19.77])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08351675esm213975185ad.14.2026.03.24.22.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 22:19:32 -0700 (PDT)
Date: Wed, 25 Mar 2026 10:49:30 +0530
From: shaikh kamaluddin <shaikhkamal2012@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, skhan@linuxfoundation.org,
	me@brighamcampbell.com
Subject: Re: [PATCH] KVM: mmu_notifier: make mn_invalidate_lock non-sleeping
 for non-blocking invalidations
Message-ID: <acNwYsm4GfViqiJS@acer-nitro-anv15-41>
References: <20260209161527.31978-1-shaikhkamal2012@gmail.com>
 <20260211120944.-eZhmdo7@linutronix.de>
 <aYyhfvC_2s000P7H@google.com>
 <aactOOfirdVRYfNS@acer-nitro-anv15-41>
 <ae2143b3-ce28-4c87-afcf-1505694246d8@redhat.com>
 <abMS7MALNrmluvh5@acer-nitro-anv15-41>
 <b51de5cb-8198-4664-afcc-7386ecda81a8@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b51de5cb-8198-4664-afcc-7386ecda81a8@redhat.com>

On Sat, Mar 14, 2026 at 08:47:40AM +0100, Paolo Bonzini wrote:
> On 3/12/26 20:24, shaikh kamaluddin wrote:
> > > > Alternatively, if you think this needs to be addressed in
> > > > mmu_notifiers(eg. how non_block_start() is applied), I'm happy to
> > > > redirect my efforts there-Please advise.
> > > 
> > > Have you considered a "OOM entered" callback for MMU notifiers?  KVM's MMU
> > > notifier can just remove itself for example, in fact there is code in
> > > kvm_destroy_vm() to do that even if invalidations are unbalanced.
> > > 
> > > Paolo
> > > 
> > Thanks for the suggestion! That's a much cleaner approach than what I was considering.
> > 
> > If I understand correctly, the idea would be:
> > 1. Add a new MMU notifier callback (e.g., .oom_entered or .release_on_oom)
> > 2. Have KVM implement it to unregister the notifier when OOM reaper starts
> > 3. Leverage the existing kvm_destroy_vm() logic that already handles unbalanced invalidations
> 
> Yes pretty much.  Essentially, move the existing logic to the new callback
> and invoke it from kvm_destroy_vm().
>

Hi Paolo,
Thank you for the suggestion to use an oom_enter callback approach. I've implemented v2 based on your guidance and have successfully validated it.

Implementation Summary:
-------------------------------------
Following your recommendation, I've added a new oom_enter callback to the mmu_notifier_ops structure. The implementation:

1. Added oom_enter callback to struct mmu_notifier_ops in include/linux/mmu_notifier.h
2. Implemented __mmu_notifier_oom_enter() in mm/mmu_notifier.c to invoke registered callbacks
3. Called mmu_notifier_oom_enter(mm) from __oom_kill_process in mm/oom_kill.c before any invalidations
4. As per your suggestion, move existing kvm_destroy_vm() logic that already handles unbalanced invalidation to the new helper function kvm_mmu_notifier_detach() and invoke it from the kvm_destroy_vm()

Key Design Decision:
------------------------------
Implementation point no 4, while testing, Issue I was encountering is a recursive locking problem with the srcu lock, which is being acquired twice in the same context. This happens during the __mmu_notifier_oom_enter() and __synchronize_srcu() calls, leading to a potential deadlock.
Please find below log snippet while launching the Guest VM
------------------------------------------------------------------------------------------------
OOM_REAPER: START reaping:func:__mmu_notifier_oom_enter
[  399.841599][T10882] OOM_REAPER: START reaping:func:__mmu_notifier_oom_enter
[  399.841608][T10882] KVM: oom_enter callback invoked for VM:kvm_mmu_notifier_oom_enter
[  399.841608][T10882] KVM: oom_enter callback invoked for VM:kvm_mmu_notifier_oom_enter
[  399.841961][T10882]
[  399.841961][T10882]
[  399.841962][T10882] ============================================
[  399.841962][T10882] ============================================
[  399.841964][T10882] WARNING: possible recursive locking detected
[  399.841964][T10882] WARNING: possible recursive locking detected
[  399.841966][T10882] 7.0.0-rc2-00467-g4ae12d8bd9a8-dirty #12 Not tainted
[  399.841966][T10882] 7.0.0-rc2-00467-g4ae12d8bd9a8-dirty #12 Not tainted
[  399.841969][T10882] --------------------------------------------
[  399.841969][T10882] --------------------------------------------
[  399.841971][T10882] qemu-system-x86/10882 is trying to acquire lock:
[  399.841971][T10882] qemu-system-x86/10882 is trying to acquire lock:
[  399.841974][T10882] ffffffff8db05598 (srcu){.+.+}-{0:0}, at: __synchronize_srcu+0x83/0x380
[  399.841974][T10882] ffffffff8db05598 (srcu){.+.+}-{0:0}, at: __synchronize_srcu+0x83/0x380
[  399.841991][T10882]
[  399.841991][T10882] but task is already holding lock:
[  399.841991][T10882]
[  399.841991][T10882] but task is already holding lock:
[  399.841992][T10882] ffffffff8db05598 (srcu){.+.+}-{0:0}, at: __mmu_notifier_oom_enter+0x93/0x1f0
[  399.841992][T10882] ffffffff8db05598 (srcu){.+.+}-{0:0}, at: __mmu_notifier_oom_enter+0x93/0x1f0
[  399.842005][T10882]
[  399.842005][T10882] other info that might help us debug this:
[  399.842005][T10882]
[  399.842005][T10882] other info that might help us debug this:
[  399.842006][T10882]  Possible unsafe locking scenario:
[  399.842006][T10882]
[  399.842006][T10882]  Possible unsafe locking scenario:
[  399.842006][T10882]
[  399.842008][T10882]        CPU0
[  399.842008][T10882]        CPU0
[  399.842009][T10882]        ----
[  399.842009][T10882]        ----
[  399.842010][T10882]   lock(srcu);
[  399.842010][T10882]   lock(srcu);
[  399.842014][T10882]   lock(srcu);
[  399.842014][T10882]   lock(srcu);
[  399.842017][T10882]
[  399.842017][T10882]  *** DEADLOCK ***
[  399.842017][T10882]
[  399.842017][T10882]
[  399.842017][T10882]  *** DEADLOCK ***
[  399.842017][T10882]
[  399.842018][T10882]  May be due to missing lock nesting notation
[  399.842018][T10882]
[  399.842018][T10882]  May be due to missing lock nesting notation

-------------------------------------------------------------------------------------------------------------------
Then defered the kvm_mmu_notifier_detach() using workqueue, then above issue got fixed.


Testing:
-------------
I've validated the v2 approach with:

Kernel: v7.0-rc2 with PREEMPT_RT and DEBUG_ATOMIC_SLEEP enabled
Test: Triggered OOM conditions that killed a QEMU process with active KVM VM
Use these commands for generating scenario:
1. vng -v -r ./arch/x86/boot/bzImage --qemu-opts='-m 2G -cpu EPYC,+svm,+npt,+tsc,+invtsc -s '
After successfully booting the virtme-ng(QEMU) ------> Act Host VM
2. chmod 666 /dev/kvm
3. dmesg -c > /dev/null
4. launching Guest VM using this command $qemu-system-x86_64 -enable-kvm -m 1000M -mem-prealloc \
        -monitor none -serial none -display none -nographic & sleep 10

Results:
-------------------
1. oom_enter callback was successfully invoked
2 No SRCU deadlock warnings
3 No "sleeping function called from invalid context" warnings
4.OOM reaper completed successfully
5. Process was reaped without errors



Question:
Before I send the v2 patch series, I want to confirm this approach aligns with your expectations. Specifically:
Defered this coommon helper kvm_mmu_notifier_detach() for mmu_nottifier_unregister() and unbalanced invalidation using workque is good design?
Are there any specific test cases or scenarios you'd like me to validate?

I can send the complete v2 patch series once you confirm this approach is on the right track.

Thanks again for the guidance!

Shaikh Kamal

> > This avoids the whole "convert locks to raw" problem and the complexity of deferring work.
> > 
> > I have questions on Testing part:
> > ------------------------------------
> > I tried to reproduce the bug scenario using the virtme-ng then running
> > the stress-ng putting memory pressure on VM, but not able to reproduce
> > the scenario.
> > I tried this way ..
> > vng -v -r ./arch/x86/boot/bzImage
> > VM is up, then running the stress-ng as below
> > stress-ng --vm 2 --vm-bytes 95% --timeout 20s & sleep 5 & dmesg | tail -30 | grep "sleeping function"
> > OOM Killer is triggered, but exact bug not able to reproduce, Please
> > suggest how to reproduce this bug, even we need to verify after code
> > changes which you have suggested.
> 
> I don't know, sorry.  But with this new approach there will always be a call
> to the new callback from the OOM killer, so it's easier to test.
> 
> Thanks,
> 
> Paolo
> 
