Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06EE3AEF37
	for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 12:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774011405; cv=none; b=MLpcOxFTG1ZvRrbF6LLdHR3aWiZxgm2qlogzc6K8C33zVgjKiReM71FzImzchhDCp5fRldvaK6DQ+0/JWdGBiXsaB+F2BJ1ONCs4bK7YgK/S4fFgwjg37b9GebO7XmozuK5gtJ4mZBAR7jLmz9ZhH3KW6JyAthdKFwh7h7LPWck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774011405; c=relaxed/simple;
	bh=4bVZo/d4rOBIhiZ7XAzKCcJgHrXCFeePsl5rOM9yM3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ce0k8IMmciuod/MhTeiJcbxSlYuutlVtOqunitepiHXf4RYMORx1pizUwKl8jpmgtSRGhwJmFhDakCPk6NeAwmOPSXlk5n9D9+CiVvSeDQj2xDwDOmMDhPf9y6Oo0T1uZ3ClA09+bdXYDtz6Btk2HOrIcRwCo/lTyHX73WdoJ6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=JiwAuTdt; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="JiwAuTdt"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-89a000f5adeso10112936d6.3
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 05:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1774011403; x=1774616203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvkndFGKylW8fkh7sz/NV3MjrUD7bcisFfPEBGAPp+8=;
        b=JiwAuTdt6m93CwJThtZ3ETykiWXv2VwJ1VPtSQqg7YXyv6sCthPD9imxPVUJkNhgZI
         ofziGhZ/Bt3ggjwd/Tirv4qGsR0ZRX+xLxXWPxxVWwbQkHh/EhlIhZG2oRUSaxDQYF7y
         lKNrsrZ6i5t2l4OQMNtzuT1CqAvS6yQiNK0OTWVy24KiZGfw3yAxS/029sC9WHgk9uho
         hPoIN8Ns+lWU4RT+8AsEgb7v3VyCtekSNMuFH5vfbvu25YhM+cN/8Xk+3TLDUzbgbnz4
         uwB9aqHT1MjT6ieojj5KkzZMWbQQ/iJGRW89t3MR+Q7KIlFnSsnthBiPTeTpc0LkjniZ
         fR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774011403; x=1774616203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vvkndFGKylW8fkh7sz/NV3MjrUD7bcisFfPEBGAPp+8=;
        b=WfXQFQTTsV8Qp55YaQ9oXWOSXMNmD6Sowga3vdUrsjWGi5jVKv2NCcoluiMJB7YgRG
         eEEG3tm8/ysVAy/8ATMSe1Cxlo6d2jv+9sGv4j7hJRdLxyO99/3qOriHFqHSMe054Wyo
         rrdXXuiLVTFi/aXlrOloWl7Ez6POkIUpXBL6m0jC6Fe/9deeijXuJf8VZw0o1jP2PxdD
         iTo9c1on1pmYmB7S9IRVxb11FSHXCwbJtpudsg5vSpg9IZFg6QOIo1mi66bSWrOy6SuV
         NrSWHoUSE52An/1fntfbQop+1wueBPhu0isHItNhhxx2p/O1ip7AkIoe+wFhCiE+uvWb
         dblA==
X-Gm-Message-State: AOJu0YyyvsT3wIKSFIWBP7IDXsSxDF2165KL6vq3SbBTzpPhaTLaG9us
	4TV9K0G3zC3a6+KqOCh14BFrj4siBbscbmif/iffc8tTetpJa0ZgG6RILzFULHKSS9s=
X-Gm-Gg: ATEYQzwsNvUGybk1lzWNaNah2NPAtBOhcxms35N3hwd9o6B841JofXLQM/2WDURIDRg
	1F05XrJpEsxjEDl7Q/hpdRrKXlwRvsugkcqh+lb+Pp/VCrbW7oYJVlxX0ixIfYzuecEYp97TTUy
	RV0AI0idVrghL+cdlYGNG+7JH5qydcRXMpkKa2gBwV0lVoyeEdYQh6KcBbGM+H1ZSQ07lcJFVuq
	f9LBRQeVTnnxgMRyXz01IVdNWCsjXMN35YzJ4RS3Wohy/U2GmxRo0Yp6oPj3LECY1lVa97l8zPh
	5X4RoTnV1MOkAjQmV1Fu5b/XER0bEUQPrjBy2DuJHAojCkD2f5xZPwYJ8yfA6CSYlIbemi4F2qs
	kQJmlbzn6tqO5UzLrE9cXpEWlcouN4IMMfpeWMg2IcPzqgZv6gIAjRzF73UCdo7Yd57gc7fyLCQ
	qvbws2OMr5/saPJCcbSy3NyrF7+ytdX8zms68v4jxW+qj7vOt7RWn+SUHfuWnqAzPpvQ==
X-Received: by 2002:a05:6214:601b:b0:89c:5f6e:451f with SMTP id 6a1803df08f44-89c85a0fd6fmr39097576d6.26.1774011402754;
        Fri, 20 Mar 2026 05:56:42 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c8525e195sm19110756d6.22.2026.03.20.05.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 05:56:42 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: sonam.sanju@intel.corp-partner.google.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pbonzini@redhat.com,
	seanjc@google.com,
	sonam.sanju@intel.com,
	dmaluka@chromium.org,
	"Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
Subject: Re: [PATCH] KVM: irqfd: fix shutdown deadlock by moving SRCU sync outside resampler_lock
Date: Fri, 20 Mar 2026 08:56:33 -0400
Message-ID: <20260320125633.2290675-1-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162754.3231300-1-sonam.sanju@intel.corp-partner.google.com>
References: <20260317162754.3231300-1-sonam.sanju@intel.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Sonam,

> irqfd_resampler_shutdown() calls synchronize_srcu_expedited() while
> holding kvm->irqfds.resampler_lock.  This can deadlock when multiple
> irqfd_shutdown workers run concurrently on the kvm-irqfd-cleanup
> workqueue during VM teardown (e.g. crosvm shutdown on Android):
> 
>   CPU A (mutex holder)               CPU B/C/D (mutex waiters)
>   irqfd_shutdown()                   irqfd_shutdown()
>    irqfd_resampler_shutdown()         irqfd_resampler_shutdown()
>     mutex_lock(resampler_lock)  <---- mutex_lock(resampler_lock)  // BLOCKED
>     list_del_rcu(...)                     ...blocked...
>     synchronize_srcu_expedited()      // Waiters block workqueue,
>       // waits for SRCU grace            preventing SRCU grace
>       // period which requires            period from completing
>       // workqueue progress          --- DEADLOCK ---

I think we might have this issue in the kvm_irqfd_assign path as well
where synchronize_srcu_expedited is called with the resampler_lock
held. I saw similar lockup during a stress test where VMs were created
and destroyed continously. I could see one task waiting on SRCU GP:

[   T93] task:crosvm_security state:D stack:0     pid:8215  tgid:8215  ppid:1      task_flags:0x400000 flags:0x00080002.
[   T93] Call Trace:
[   T93]  <TASK>
[   T93]  __schedule+0x87a/0xd60
[   T93]  schedule+0x5e/0xe0
[   T93]  schedule_timeout+0x2e/0x130
[   T93]  ? queue_delayed_work_on+0x7f/0xd0
[   T93]  wait_for_common+0xf7/0x1f0
[   T93]  synchronize_srcu_expedited+0x109/0x140
[   T93]  ? __cfi_wakeme_after_rcu+0x10/0x10
[   T93]  kvm_irqfd+0x362/0x5e0
[   T93]  kvm_vm_ioctl+0x706/0x780
[   T93]  ? fd_install+0x2c/0xf0
[   T93]  __se_sys_ioctl+0x7a/0xd0
[   T93]  do_syscall_64+0x61/0xf10
[   T93]  ? arch_exit_to_user_mode_prepare+0x9/0xb0
[   T93]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   T93] RIP: 0033:0x79048f9bdd67
[   T93] RSP: 002b:00007ffc3aa82028 EFLAGS: 00000206.

And another task waiting on the mutex:

[    C0] task:kworker/11:2    state:R  running task     stack:0     pid:25180 tgid:25180 ppid:2      task_flags:0x4208060 flags:0x00080000
[    C0] Workqueue: kvm-irqfd-cleanup irqfd_shutdown
[    C0] Call Trace:
[    C0]  <TASK>
[    C0]  __schedule+0x87a/0xd60
[    C0]  schedule+0x5e/0xe0
[    C0]  schedule_preempt_disabled+0x10/0x20
[    C0]  __mutex_lock+0x413/0xe40
[    C0]  irqfd_resampler_shutdown+0x23/0x150
[    C0]  irqfd_shutdown+0x66/0xc0
[    C0]  process_scheduled_works+0x219/0x450
[    C0]  worker_thread+0x30b/0x450
[    C0]  ? __cfi_worker_thread+0x10/0x10
[    C0]  kthread+0x230/0x270
[    C0]  ? __cfi_kthread+0x10/0x10
[    C0]  ret_from_fork+0xf2/0x150
[    C0]  ? __cfi_kthread+0x10/0x10
[    C0]  ret_from_fork_asm+0x1a/0x30
[    C0]  </TASK>

The work queue was full as well I think:

[    C0]   pwq 46: cpus=11 node=0 flags=0x0 nice=0 active=1024 refcnt=2062

There were other tasks waiting for SRCU GP completion in the resampler
shutdown path. Also, there were other traces showing lockups (mostly in
mm), but I think thats a secondary effect of this lockup and might not
be relevant. I can provide the full logs if needed.

Please have a look and see if this path needs to be handled to fully fix
this issue.

Thanks,
Vineeth
