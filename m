Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5541337C933
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 19:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773343475; cv=none; b=BMwqc0AvRyCUB5ts0ZixR/Hd5X9ZG5lcWC/hNQBuv/ysgguX5QIpuv9KL0XNJ4fZqAFlCKUaf5aC4MOcQzLOQ3tEr76NcQPIWbJs04AQ5sJ4JeI9RFLzrEI7ZNIE2kX4NsVSO+CZ0PUGpKCrlwh69JzbFZhaRw141yv3GsKo8Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773343475; c=relaxed/simple;
	bh=xUOE+P8FDO9EGfqDlA45VndK29UzQdfQjftwfdnIkgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUd+HozmZa/11xkvpq4plhgY3AN5TRJDRuU0+1EiIU/AADBSQtHHEwQjLBQjfYWt0Te9oOYwrSczCWk9L/TX8qsT+Q/zr2fhjhRP58sJkDH6Y536ZXeVxx3ycceWzsU6mDNgi2ZaAFKTkIeWdBGOWPLFfcP08Xt32boVp92IIVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnbhL9/1; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnbhL9/1"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so906257a91.0
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 12:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773343474; x=1773948274; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WGesEaqRXeTFjySbmfsSG99nSKH/WuuUlsI/nlH1fCo=;
        b=KnbhL9/1bYZJTKH3kG7tB+++EDXy88E+ouesiCjweeyeTeaS+SGD5NG79tzSXyzIYE
         fHkzUPvrJYz+s14uXzD7dmlR8ujubxi87TdOafhzD5fEhAE30FpEAkuCd8rFEsYGgffD
         6xOjYDaXmqtsNwpvHT6ZGAx3xLtRxdW7ZGj3qhqzGW+6pKP76NBGN9TwzH330LyV7+MV
         dxA0QsbugjQ+wQ6Mty9qJ3ggr55mkv5hpI0SUCXa7R3wyG+EPX8PH+uCaIZcUNxlHN4r
         kdIy6gORiCEoSVOCcoVQMUzLusjjclqBi/6ldTrrARt608ZKH6L1Ob5wBQ142lA/h1wz
         QQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773343474; x=1773948274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WGesEaqRXeTFjySbmfsSG99nSKH/WuuUlsI/nlH1fCo=;
        b=oJJK4o1hTssmMSiyHAJFP7wzMSwTEY7fdKLJCKFGeSXXqsavS3YkJ/c8AVqsW5inQF
         4pHIIX16iscSPkMPU3GFOKRfMFD7NG4k+pWW9L5F5CWBl6YiUX4VvBt6IfBcXzrSrDhw
         oxNKBJC/kJ0kfEpwjXI+hmocSZIUe/VukFCt0QuhozjQBZpTm73w6luGmcMVSP+uiKz2
         39N+Ep0XOGXZzFWrYpmd2r2qTsGW1VGvSW9fxQjtSP3QiwFGalMXH6SchXJqnxgio0I3
         EChpp2hcY/1lLe44CawTMU5qBGagioJk5o2X+7rTADt8rN2X+1XaaZylgx/1JSNyZbXY
         tVKg==
X-Forwarded-Encrypted: i=1; AJvYcCW3re0CayXKmvjAjpXKEwXSGuHJ6nFUgf0wv4B/65F6sqrC8ImSHEyjOUHRrDNHJrtCOqg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw67pWu3xsL7Fncqrym23bwvWcgYFVKn0d2acgutKAfe8GxQY0W
	lBTBvUX/OM6EV+yIlYs+CKZmgVyNRez0YZROnegRCo3WaXK2UdUk0qOj
X-Gm-Gg: ATEYQzw9QDae03vevbAZJFgJQZyQTtGaS/n/YtEpZX+fscnu8txRZeXfKl7XxIixvwP
	s9CaSgsVn11caUKRHLQeb1ER6CZiZq1vjt+D9SsMxeFYbPtT1XcCVOByqutlRwUPksmrMYbwB8A
	4wvj2KtRfa6nP1Z1SqwetxgygCqIMZAiMo6qTKipIquCuowrSlwj9BuC2OM7b8UBzvWnv6UqKxn
	satoP6Y6P853ktAkg0FjNLt0u4haoBQpql9TKh0PlQaGxunJWVNIgkKepeogTH2EEfPDAlgPGPp
	WldZvhrqjRP/eOCaGmbJe47UqiAmx5NGgJwtbGqy/eB+2TcFd3NkdGuK0UiaT4G93aPioEvleD8
	5zVgfkbzZ+0bXZXz7ViQbcVIly2nDVMZ9Pcwqvv8+ymLiT831Jdc2j5EDx0saaA9lNV/WTx/sJ1
	+uuGHMmD9v4ej3L7Ab77oY8VQ1OsesexmIgTNm
X-Received: by 2002:a17:90b:1e45:b0:359:f0e1:f8c9 with SMTP id 98e67ed59e1d1-35a21efae49mr641423a91.6.1773343473458;
        Thu, 12 Mar 2026 12:24:33 -0700 (PDT)
Received: from localhost ([115.96.18.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a22cc1c91sm96857a91.1.2026.03.12.12.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 12:24:32 -0700 (PDT)
Date: Fri, 13 Mar 2026 00:54:28 +0530
From: shaikh kamaluddin <shaikhkamal2012@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] KVM: mmu_notifier: make mn_invalidate_lock non-sleeping
 for non-blocking invalidations
Message-ID: <abMS7MALNrmluvh5@acer-nitro-anv15-41>
References: <20260209161527.31978-1-shaikhkamal2012@gmail.com>
 <20260211120944.-eZhmdo7@linutronix.de>
 <aYyhfvC_2s000P7H@google.com>
 <aactOOfirdVRYfNS@acer-nitro-anv15-41>
 <ae2143b3-ce28-4c87-afcf-1505694246d8@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ae2143b3-ce28-4c87-afcf-1505694246d8@redhat.com>

On Fri, Mar 06, 2026 at 07:14:40PM +0100, Paolo Bonzini wrote:
> On 3/3/26 19:49, shaikh kamaluddin wrote:
> > On Wed, Feb 11, 2026 at 07:34:22AM -0800, Sean Christopherson wrote:
> > > On Wed, Feb 11, 2026, Sebastian Andrzej Siewior wrote:
> > > > On 2026-02-09 21:45:27 [+0530], shaikh.kamal wrote:
> > > > > mmu_notifier_invalidate_range_start() may be invoked via
> > > > > mmu_notifier_invalidate_range_start_nonblock(), e.g. from oom_reaper(),
> > > > > where sleeping is explicitly forbidden.
> > > > > 
> > > > > KVM's mmu_notifier invalidate_range_start currently takes
> > > > > mn_invalidate_lock using spin_lock(). On PREEMPT_RT, spin_lock() maps
> > > > > to rt_mutex and may sleep, triggering:
> > > > > 
> > > > >    BUG: sleeping function called from invalid context
> > > > > 
> > > > > This violates the MMU notifier contract regardless of PREEMPT_RT;
> > > 
> > > I highly doubt that.  kvm.mmu_lock is also a spinlock, and KVM has been taking
> > > that in invalidate_range_start() since
> > > 
> > >    e930bffe95e1 ("KVM: Synchronize guest physical memory map to host virtual memory map")
> > > 
> > > which was a full decade before mmu_notifiers even added the blockable concept in
> > > 
> > >    93065ac753e4 ("mm, oom: distinguish blockable mode for mmu notifiers")
> > > 
> > > and even predate the current concept of a "raw" spinlock introduced by
> > > 
> > >    c2f21ce2e312 ("locking: Implement new raw_spinlock")
> > > 
> > > > > RT kernels merely make the issue deterministic.
> > > 
> > > No, RT kernels change the rules, because suddenly a non-sleeping locking becomes
> > > sleepable.
> > > 
> > > > > Fix by converting mn_invalidate_lock to a raw spinlock so that
> > > > > invalidate_range_start() remains non-sleeping while preserving the
> > > > > existing serialization between invalidate_range_start() and
> > > > > invalidate_range_end().
> > > 
> > > This is insufficient.  To actually "fix" this in KVM mmu_lock would need to be
> > > turned into a raw lock on all KVM architectures.  I suspect the only reason there
> > > haven't been bug reports is because no one trips an OOM kill on VM while running
> > > with CONFIG_DEBUG_ATOMIC_SLEEP=y.
> > > 
> > > That combination is required because since commit
> > > 
> > >    8931a454aea0 ("KVM: Take mmu_lock when handling MMU notifier iff the hva hits a memslot")
> > > 
> > > KVM only acquires mmu_lock if the to-be-invalidated range overlaps a memslot,
> > > i.e. affects memory that may be mapped into the guest.
> > > 
> > > E.g. this hack to simulate a non-blockable invalidation
> > > 
> > > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > > index 7015edce5bd8..7a35a83420ec 100644
> > > --- a/virt/kvm/kvm_main.c
> > > +++ b/virt/kvm/kvm_main.c
> > > @@ -739,7 +739,7 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
> > >                  .handler        = kvm_mmu_unmap_gfn_range,
> > >                  .on_lock        = kvm_mmu_invalidate_begin,
> > >                  .flush_on_ret   = true,
> > > -               .may_block      = mmu_notifier_range_blockable(range),
> > > +               .may_block      = false,//mmu_notifier_range_blockable(range),
> > >          };
> > >          trace_kvm_unmap_hva_range(range->start, range->end);
> > > @@ -768,6 +768,7 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
> > >           */
> > >          gfn_to_pfn_cache_invalidate_start(kvm, range->start, range->end);
> > > +       non_block_start();
> > >          /*
> > >           * If one or more memslots were found and thus zapped, notify arch code
> > >           * that guest memory has been reclaimed.  This needs to be done *after*
> > > @@ -775,6 +776,7 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
> > >           */
> > >          if (kvm_handle_hva_range(kvm, &hva_range).found_memslot)
> > >                  kvm_arch_guest_memory_reclaimed(kvm);
> > > +       non_block_end();
> > >          return 0;
> > >   }
> > > 
> > > immediately triggers
> > > 
> > >    BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:241
> > >    in_atomic(): 0, irqs_disabled(): 0, non_block: 1, pid: 4992, name: qemu
> > >    preempt_count: 0, expected: 0
> > >    RCU nest depth: 0, expected: 0
> > >    CPU: 6 UID: 1000 PID: 4992 Comm: qemu Not tainted 6.19.0-rc6-4d0917ffc392-x86_enter_mmio_stack_uaf_no_null-rt #1 PREEMPT_RT
> > >    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
> > >    Call Trace:
> > >     <TASK>
> > >     dump_stack_lvl+0x51/0x60
> > >     __might_resched+0x10e/0x160
> > >     rt_write_lock+0x49/0x310
> > >     kvm_mmu_notifier_invalidate_range_start+0x10b/0x390 [kvm]
> > >     __mmu_notifier_invalidate_range_start+0x9b/0x230
> > >     do_wp_page+0xce1/0xf30
> > >     __handle_mm_fault+0x380/0x3a0
> > >     handle_mm_fault+0xde/0x290
> > >     __get_user_pages+0x20d/0xbe0
> > >     get_user_pages_unlocked+0xf6/0x340
> > >     hva_to_pfn+0x295/0x420 [kvm]
> > >     __kvm_faultin_pfn+0x5d/0x90 [kvm]
> > >     kvm_mmu_faultin_pfn+0x31b/0x6e0 [kvm]
> > >     kvm_tdp_page_fault+0xb6/0x160 [kvm]
> > >     kvm_mmu_do_page_fault+0xee/0x1f0 [kvm]
> > >     kvm_mmu_page_fault+0x8d/0x600 [kvm]
> > >     vmx_handle_exit+0x18c/0x5a0 [kvm_intel]
> > >     kvm_arch_vcpu_ioctl_run+0xc70/0x1c90 [kvm]
> > >     kvm_vcpu_ioctl+0x2d7/0x9a0 [kvm]
> > >     __x64_sys_ioctl+0x8a/0xd0
> > >     do_syscall_64+0x5e/0x11b0
> > >     entry_SYSCALL_64_after_hwframe+0x4b/0x53
> > >     </TASK>
> > >    kvm: emulating exchange as write
> > > 
> > > 
> > > It's not at all clear to me that switching mmu_lock to a raw lock would be a net
> > > positive for PREEMPT_RT.  OOM-killing a KVM guest in a PREEMPT_RT seems like a
> > > comically rare scenario.  Whereas contending mmu_lock in normal operation is
> > > relatively common (assuming there are even use cases for running VMs with a
> > > PREEMPT_RT host kernel).
> > > 
> > > In fact, the only reason the splat happens is because mmu_notifiers somewhat
> > > artificially forces an atomic context via non_block_start() since commit
> > > 
> > >    ba170f76b69d ("mm, notifier: Catch sleeping/blocking for !blockable")
> > > 
> > > Given the massive amount of churn in KVM that would be required to fully eliminate
> > > the splat, and that it's not at all obvious that it would be a good change overall,
> > > at least for now:
> > > 
> > > NAK
> > > 
> > > I'm not fundamentally opposed to such a change, but there needs to be a _lot_
> > > more analysis and justification beyond "fix CONFIG_DEBUG_ATOMIC_SLEEP=y".
> > > 
> > Hi Sean,
> > Thanks for the detailed explanation and for spelling out the border
> > issue.
> > Understood on both points:
> > 	1. The changelog wording was too strong; PREEMPT_RT changes
> > 	spin_lock() semantics, and the splat is fundamentally due to
> > 	spinlocks becoming sleepable there.
> > 	2. Converting only mm_invalidate_lock to raw is insufficient
> > 	since KVM can still take the mmu_lock (and other sleeping locks
> > 	RT) in invalidate_range_start() when the invalidation hits a
> > 	memslot.
> > Given the above, it shounds like "convert locks to raw" is not the right
> > direction without sinificat rework and justification.
> > Would an acceptable direction be to handle the !blockable notifier case
> > by deferring the heavyweight invalidation work(anything that take
> > mmu_lock/may sleep on RT) to a context that may block(e.g. queued work),
> > while keeping start()/end() accounting consisting with memslot changes ?
> > if so, I can protoptype a patch along those lines and share for
> > feedback.
> > 
> > Alternatively, if you think this needs to be addressed in
> > mmu_notifiers(eg. how non_block_start() is applied), I'm happy to
> > redirect my efforts there-Please advise.
> 
> Have you considered a "OOM entered" callback for MMU notifiers?  KVM's MMU
> notifier can just remove itself for example, in fact there is code in
> kvm_destroy_vm() to do that even if invalidations are unbalanced.
> 
> Paolo
>
Thanks for the suggestion! That's a much cleaner approach than what I was considering.

If I understand correctly, the idea would be:
1. Add a new MMU notifier callback (e.g., .oom_entered or .release_on_oom)
2. Have KVM implement it to unregister the notifier when OOM reaper starts
3. Leverage the existing kvm_destroy_vm() logic that already handles unbalanced invalidations

This avoids the whole "convert locks to raw" problem and the complexity of deferring work.

I have questions on Testing part:
------------------------------------
I tried to reproduce the bug scenario using the virtme-ng then running
the stress-ng putting memory pressure on VM, but not able to reproduce
the scenario.
I tried this way ..
vng -v -r ./arch/x86/boot/bzImage
VM is up, then running the stress-ng as below 
stress-ng --vm 2 --vm-bytes 95% --timeout 20s & sleep 5 & dmesg | tail -30 | grep "sleeping function"
OOM Killer is triggered, but exact bug not able to reproduce, Please
suggest how to reproduce this bug, even we need to verify after code
changes which you have suggested.

Shaikh Kamal
