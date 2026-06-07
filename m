Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EADA2512DE
	for <kvm@vger.kernel.org>; Sun,  7 Jun 2026 17:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780855110; cv=none; b=rMbM8zQ3rWpJGenL5/hh+r8dwPS6qa+jku0iaDCxMqMcmO4qcywICQZQZgkAaQir05RKx1riJf61a7YOk9nivAaXcwC+G0ccqhRWrWEjoUUkhEgVwHhFpEvHVLNYwdIaRMs/szZCpzqEthPrsKdxfXJLDZCUhyEhNb6aPZvt5ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780855110; c=relaxed/simple;
	bh=bY33RCJQEadB1FaV1As+lI256ULbTWOJA7RfVxN/ihQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjMHdJSQaSx+JqZHuPY8PuI1hCtgBTgQukh0M8v/Fb0Fm6LelR+UPXEPufvPsgW31eCTS2PYd/HstIb3JFxn3XgzBbZ0eaKbHAaZDJIzmJLqyK6BsvzT+5bpu6rV5PYbrbPPPnplJuTt0LD/FX942PWD4+XPz6YW0nC6uQiSFUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGfVAcJe; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGfVAcJe"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c0b944f6edso37460475ad.2
        for <kvm@vger.kernel.org>; Sun, 07 Jun 2026 10:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780855109; x=1781459909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c2RDc7vwCs214SZmSr6J53htm9NHLBxoNBLD3OPbxYs=;
        b=GGfVAcJePwPZn9SyZlN5oZB6p60jJqINkxtQkvVjA4JRruGWPBz91LxmLSq1GfXJUP
         OZebArlFAvYjvlz/rVRoWz07QWSGLGO6l/TLHqUHJcIjOmbAsuz2jWvREijwTk7uHoki
         SNcUHa24EK9nJZpCMuanfVEE196SmtP7bWHOWCILCuLavnHuihOKQ6+NPZrrTOwkLiSO
         swiiPamjnmnbd83CzctHxKfw23XDHhBWNpqGuYQXZa1jVBOF1DkfhIHxe1KJVbqQZNkP
         a0BoVaKoUr40qFV6nllTpomwvLlMsbwpyLszRnN4ecfrMGYexDQatppzrFKZjU4eyR7s
         4yFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780855109; x=1781459909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2RDc7vwCs214SZmSr6J53htm9NHLBxoNBLD3OPbxYs=;
        b=hlT2AB2EipzF16MCma1MBqhFMKWME4xWVwr4vP73AFg5kCZ7FzZlNzLq01RnQIgQDR
         FvGk620nvUHbsIpHrSc/saaVzPyunv50Hmy0mxuE0sOGVZGlg6xH7TO0eo0HWdhyqF2h
         Z8yDqXEjsU344mGakOUpDCNAm9mplooqQ7no8VMMKej5MSJ5zX1CB73DcBsZPxxhERQF
         1klYWNNNDlr3UjKpvRXqHE9snpcR5/X6GTzO9h7u0XNfRcfJe6Dcbi83rf4yxKbGGiH7
         EG+cKjZ37o/JEuI7Z/Dw9hhuKmeHEbP2Nrm+uF9oRVRztly6gpahoatWrMbdMZBcP21m
         95+g==
X-Gm-Message-State: AOJu0Yy0TTry7Zkbr7+EYBvqjOCexkAd2tDpixH7lrMGGa31yGsPAuCh
	34Rlcd32MJcyXhIINAEwoFmRJCCAU27gONR1BXcT3WsjkT3EyHeQHXXlVyoouwfTUKXL/w==
X-Gm-Gg: Acq92OFd8dNE18gvU0Vq0flqu6O53r0GQL8xn8HmMLYADKPlfHX8mUN2j5f8i3VO+H4
	OTfOzBRL2CNmIGRQyQHY+sHduZ1I7FjbFTOgYK5std6sYvrC5AEOfzL/FWOHZCbFivVJ4bwoxSq
	gZF77xnA7oQtLjBgLlGu4iX37OwLIGy1NkgqqHk6kX9FRvkJ3E1At8fbTkESxaFOZDyOtXrBSpP
	VDPNr9eYUEYhpT1RUTPpLSnYOUyC2goLUDc2FLXueHkhBH/ZM3e8m2pTtO+tuxKhz9O6xgPNsEt
	r5o/07nDsRdeDMdEdnRhtN0o8q9DfiOmUd47Evi8lRg8yOEV9ubm2pb3BqsuYsjJ+DZ1Lvqj832
	bAJbbn4CnOIbE5yCV1qD5wQGc0TfK832vXcWnsTXZ2xVWq6zvIPQn2DUmkOfCu1zuLjVKmxATSQ
	X3FSjxRbwtyYMQrM2BEFoJ49wOmw07HaGns42j4jc=
X-Received: by 2002:a17:903:8ce:b0:2c0:b4f5:41ea with SMTP id d9443c01a7336-2c1e7e93bf0mr125718445ad.17.1780855108460;
        Sun, 07 Jun 2026 10:58:28 -0700 (PDT)
Received: from localhost ([116.72.144.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629cf89sm156972585ad.56.2026.06.07.10.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 10:58:28 -0700 (PDT)
Date: Sun, 7 Jun 2026 23:28:25 +0530
From: shaikh kamaluddin <shaikhkamal2012@gmail.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	pbonzini@redhat.com, skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	syzbot+c3178b6b512446632bac@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 0/1] mm/mmu_notifier: Add async OOM cleanup via
 call_srcu()
Message-ID: <aiWxQSlfcAZCZrnw@acer-nitro-anv15-41>
References: <CABgObfZQM0Eq1=vzm812D+CAcjOaE1f1QAUqGo5rTzXgLnR9cQ@mail.gmail.com>
 <20260430141639.10815-1-shaikhkamal2012@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260430141639.10815-1-shaikhkamal2012@gmail.com>

On Thu, Apr 30, 2026 at 07:46:39PM +0530, shaikh.kamal wrote:
> This series implements the after_oom_unregister callback design
> proposed by Paolo in v1 review [1].
> 
> The current OOM notifier path calls synchronize_srcu() inline from
> mmu_notifier_oom_enter(), which can deadlock on PREEMPT_RT when
> locks such as siglock are held. This series moves the cleanup to an
> asynchronous context using call_srcu(), allowing the OOM path to
> proceed without waiting for an SRCU grace period.
> 
> Subscribers opt in via a new after_oom_unregister callback in
> struct mmu_notifier_ops.
> 
> KVM is the first (and currently only) user.
> 
> Changes since v1 [1]:
> - Implement after_oom_unregister callback in struct
>   mmu_notifier_ops as proposed by Paolo
> - Add mmu_notifier_oom_enter() to detach subscriptions and
>   schedule cleanup via call_srcu()
> - Add mmu_notifier_barrier() (srcu_barrier wrapper) so consumers
>   can wait for pending callbacks during teardown
> - Move call site from __oom_kill_process() to __oom_reap_task_mm()
>   to fix KASAN vmalloc-out-of-bounds observed in v1
> - Use hlist_del_init() to keep hlist_unhashed() correct for the
>   kvm_destroy_vm() detection path, avoiding use-after-free on the
>   stack-allocated oom_list head
> - Add KVM after_oom_unregister implementation to clear
>   mn_active_invalidate_count
> - Update kvm_destroy_vm() to detect detached subscriptions via
>   hlist_unhashed() and use mmu_notifier_barrier() + mmdrop()
>   instead of mmu_notifier_unregister()
> - Remove pr_err() on GFP_ATOMIC failure per checkpatch; the
>   trade-off is documented inline
> 
> Testing
> -------
> 
> Developed and tested under virtme-ng with PREEMPT_RT, KASAN, and
> lockdep enabled.
> 
> Test setup:
> - simple_kvm.c: minimal userspace program that opens /dev/kvm,
>   creates a VM, registers memory, creates a vCPU, and sleeps
> - CONFIG_DEBUG_VM-only debugfs interface (not part of this
>   submission) at /sys/kernel/debug/oom_reap_task to invoke
>   __oom_reap_task_mm() on a target task
> 
> Test sequence:
>   $ ./simple_kvm &
>   $ echo $! | sudo tee /sys/kernel/debug/oom_reap_task
> 
> Observed with patch applied:
> - __oom_reap_task_mm() completes
> - mmu_notifier_oom_enter() detaches the KVM subscription
> - call_srcu() callback runs after (SRCU grace period)
> - KVM after_oom_unregister clears mn_active_invalidate_count
> - mmu_notifier_barrier() returns cleanly
> - No KASAN reports, no kernel BUGs, lockdep clean
> 
> Stress runs (20 iterations) showed consistent results.
> 
> Reproducing the syzbot-reported issue
> -------------------------------------
> The issue reported by syzbot is reproducible on an unpatched
> PREEMPT_RT kernel, triggering a "sleeping function called from
> invalid context" warning in kvm_mmu_notifier_invalidate_range_start().
> With this patch applied, the warning is no longer observed..
> 
> 
> Known limitations
> -----------------
> 
> Failure of GFP_ATOMIC allocation in mmu_notifier_oom_enter()
> causes the corresponding after_oom_unregister callback to be
> skipped. The OOM path cannot sleep without reintroducing the
> deadlock this series fixes, and synchronous execution would
> require waiting for SRCU readers. Cleanup still occurs later via
> the normal unregister path. A mempool-backed allocator could
> address this in the future.
>
Hi Paolo, Lorenzo, Sean,

Gentle ping on v2, which implements the after_oom_unregister
approach Paolo suggested on v1:
  https://lore.kernel.org/all/20260430141701.10859-1-shaikhkamal2012@gmail.com/

The one outstanding issue was a build failure on !CONFIG_MMU_NOTIFIER
(arc/hexagon allnoconfig) from the kernel test robot, now fixed by
adding the missing mmu_notifier_oom_enter() stub:
  https://lore.kernel.org/all/20260607152830.8775-1-shaikhkamal2012@gmail.com/

So it builds clean and is ready for review whenever you have bandwidth.

Thanks,
Kamal
> [1] https://lore.kernel.org/all/CABgObfZQM0Eq1=vzm812D+CAcjOaE1f1QAUqGo5rTzXgLnR9cQ@mail.gmail.com
> 
> Reported-by: syzbot+c3178b6b512446632bac@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c3178b6b512446632bac
> Tested-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
> 
> shaikh.kamal (1):
>   mm/mmu_notifier: Add async OOM cleanup via call_srcu()
> 
>  include/linux/mmu_notifier.h |  10 +++
>  mm/mmu_notifier.c            | 123 +++++++++++++++++++++++++++++++++++
>  mm/oom_kill.c                |   3 +
>  virt/kvm/kvm_main.c          |  27 +++++++-
>  4 files changed, 162 insertions(+), 1 deletion(-)
> 
> --
> 2.43.0
> 
