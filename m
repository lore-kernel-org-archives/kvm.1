Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF74346AA61
	for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 15:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788189347; cv=none; b=QlBNDVWUkyESAgCAZzrX6Aw8WkKpdX749ffdSrdPLB0JjPqnSk2qPxfy/kepb+5BQVUyB009p/W22oRbUQ/45c9xnFkNpirq8nFxf3rzMS92cA64V+Cnl6/AJN7giB7seIXghzQm3LMSOGLm1cyKx/TULK9VMs79f+X0nUtNAT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788189347; c=relaxed/simple;
	bh=j1E7mflb75lpph093085L4LE7Ellud5W8xweIPGVBz4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=APa9hi7mhRZ3flGD6lH0DFPXb+puHE2sULFp1xfwNzieFpLtV8NcA1GwJH6us7nKUji9LgWj0oQHzjDL2oSP4XnQkz3tGc9w8pmJvHYvbF3CQkRDi6HIJ8VWXIpx7RO54bsKBfx3FDnHwBbbT0vNC1rCY/pAVZT4fUfk4gruF38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kx+dDFHU; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kx+dDFHU"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d6fed0652bso49107155ad.2
        for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 08:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788189345; x=1788794145; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5d+ez/0cSQNA0/hwSCPLC6sLHbw+w7evp/+REziBjCE=;
        b=kx+dDFHUAkMSa2S3EWYgfz7rgs63ueG4zwi8Auvk12yIkmLZfNF/qXpFJxJA2cCFgG
         bKQiFuz300MpImC+O4CJjHcoz4bE8IG5HyaNZSb1bX0Itc1QW4uEmymaL3pRlRKmt8Ll
         DjE5IZoErxj3WpykBvTlBbCJqzrwet3jbsxsjB7s32z0oybF1Sw+GccmIxODGD1Uk3Wp
         Wg4jmMRWGXc207cLpRflRsexLBwiDZgmX8HKtaal4sowV1mLhJNi6jmLzv93cNrqJxEW
         Na9Da/iZzu06n2G2Vm5xodwG/6+h40vlRHXjqJs+FTEzQ368mLOFTvbKZTzWVuTmBnbD
         2UXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788189345; x=1788794145;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5d+ez/0cSQNA0/hwSCPLC6sLHbw+w7evp/+REziBjCE=;
        b=KPV27ODO0wYETase/VqlnO4qOoSPnZrWRnwhEYPqGKpYsDuWheog9l3EOtJU/755Yo
         NZCHP81ySCMloqpfloGYrUmCpJvCd+xgGTdEdnZy3vY8Ft4MI3ixWLsklYGFO7gzflhN
         yTnHMpnL+6uaTHmteUmJ6W7rfwFjfe2uLWfz6bF1V8OkLOwaluXwh9uI9+5b/+KmQ8PZ
         BnMzrNxxbbBJGL4NkvViGyYX35SLS7UaPKHnZSl4cxgIjslz37HOUiaxwyBWFBSJFmEk
         awpW3SjfBDYheQxK/g8XMjnELb3cNxakGGNf216w/6f3DOgGIeajCAMjvIJZY6G88IDB
         VVvg==
X-Forwarded-Encrypted: i=1; AKwUvBwlxLNP6O1nWDL68K92ZMO0JThpTHO4xkoNHWkNqwnEzuXWicTlgmwjo5l+Kpwkui3ym3g=@vger.kernel.org
X-Gm-Message-State: AFuF++k1fF9oe88XpoB8o/1z2ZRvaMC6HXicnZBnHnY40AQGPhehN3dN
	Lb44+WeVkmuHM+NCVdtjU6Z8ghJdiDsP5vXNQYMv9aVFZBraBEcM900+S7XADmVXW+XFj9stuSM
	bgWXpZQ==
X-Received: from plce19.prod.google.com ([2002:a17:902:f1d3:b0:2d0:1fb4:d72e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ccd2:b0:2d8:d4d9:ce3b
 with SMTP id d9443c01a7336-2d8d4d9cf90mr243978445ad.22.1788189344726; Mon, 31
 Aug 2026 08:15:44 -0700 (PDT)
Date: Mon, 31 Aug 2026 08:15:44 -0700
In-Reply-To: <6a958cd4.a8e469d2.cbf3.561d.GAE@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <6a958cd4.a8e469d2.cbf3.561d.GAE@google.com>
Message-ID: <apWaoAxpE-fbHG0W@google.com>
Subject: Re: [syzbot] [kvm?] INFO: task hung in kvm_gmem_release
From: Sean Christopherson <seanjc@google.com>
To: syzbot <syzbot+6895ff73d58c59e653ba@syzkaller.appspotmail.com>
Cc: david@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pbonzini@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 31, 2026, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    08dbfad3f504 Merge tag 'for-linus' of git://git.kernel.org..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=12ee0349580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5e4e3a0e188a497e
> dashboard link: https://syzkaller.appspot.com/bug?extid=6895ff73d58c59e653ba
> compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1153ee25580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ddff5719ec3b/disk-08dbfad3.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/4b5e39b20fa5/vmlinux-08dbfad3.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/eb1f70eed57f/bzImage-08dbfad3.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+6895ff73d58c59e653ba@syzkaller.appspotmail.com
> 
> INFO: task syz.0.17:6104 blocked for more than 143 seconds.
>       Not tainted syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz.0.17        state:D stack:25544 pid:6104  tgid:6104  ppid:5900   task_flags:0x400040 flags:0x00080003
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5520 [inline]
>  __schedule+0x17d4/0x5820 kernel/sched/core.c:7270
>  __schedule_loop kernel/sched/core.c:7347 [inline]
>  schedule+0x164/0x2b0 kernel/sched/core.c:7362
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7419
>  __mutex_lock+0
>  __mutex_lock_common kernel/locking/mutex.c:726 [inline]
>  __mutex_lock+0x7c1/0x1550 kernel/locking/mutex.c:821
>  kvm_gmem_release+0xdf/0x3e0 virt/kvm/guest_memfd.c:310
>  __fput+0x418/0xa50 fs/file_table.c:512
>  task_work_run+0x1d9/0x270 kernel/task_work.c:233
>  ptrace_notify+0x27c/0x2b0 kernel/signal.c:2524
>  ptrace_report_syscall include/linux/ptrace.h:416 [inline]
>  ptrace_report_syscall_exit+0x2d/0x50 include/linux/ptrace.h:477
>  arch_ptrace_report_syscall_exit include/linux/entry-common.h:233 [inline]
>  syscall_exit_work include/linux/entry-common.h:266 [inline]
>  syscall_exit_to_user_mode_work include/linux/entry-common.h:297 [inline]
>  syscall_exit_to_user_mode include/linux/entry-common.h:334 [inline]
>  do_syscall_64+0x4a0/0x520 arch/x86/entry/syscall_64.c:89
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f

...

> CPU: 1 UID: 0 PID: 16 Comm: pr/ttyS0 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
> RIP: 0010:io_serial_in+0x77/0xc0 drivers/tty/serial/8250/8250_port.c:409
> Code: e8 4e e8 55 fc 44 89 f9 d3 e3 49 83 c6 40 4c 89 f0 48 c1 e8 03 42 80 3c 20 00 74 08 4c 89 f7 e8 1f b0 c5 fc 41 03 1e 89 da ec <0f> b6 c0 5b 41 5c 41 5e 41 5f e9 5a cc 74 06 cc 44 89 f9 80 e1 07
> RSP: 0018:ffffc900001578b8 EFLAGS: 00000002
> RAX: 1ffffffff35a5e00 RBX: 00000000000003fd RCX: 0000000000000000
> RDX: 00000000000003fd RSI: 0000000000000000 RDI: 0000000000000020
> RBP: dffffc0000000000 R08: 0000000000000003 R09: 0000000000000004
> R10: dffffc0000000000 R11: ffffffff8571cb00 R12: dffffc0000000000
> R13: 0000000000000000 R14: ffffffff9ad2f0c0 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff888124ddc000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000557adc994a38 CR3: 00000000772ec000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  serial_in drivers/tty/serial/8250/8250.h:128 [inline]
>  serial_lsr_in drivers/tty/serial/8250/8250.h:150 [inline]
>  wait_for_lsr+0x184/0x2f0 drivers/tty/serial/8250/8250_port.c:2013
>  serial8250_fifo_wait_for_lsr_thre drivers/tty/serial/8250/8250_port.c:3270 [inline]
>  __serial8250_console_fifo_write+0xcd/0x3e0 drivers/tty/serial/8250/8250_port.c:3345
>  serial8250_console_fifo_write drivers/tty/serial/8250/8250_port.c:3378 [inline]
>  __serial8250_console_write drivers/tty/serial/8250/8250_port.c:3429 [inline]
>  serial8250_console_write+0xaa1/0x1200 drivers/tty/serial/8250/8250_port.c:3493
>  nbcon_emit_next_record+0xef5/0x1a90 kernel/printk/nbcon.c:-1
>  nbcon_emit_one kernel/printk/nbcon.c:1157 [inline]
>  nbcon_kthread_func+0x679/0x880 kernel/printk/nbcon.c:1271
>  kthread+0x38b/0x480 kernel/kthread.c:436
>  ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>

Marking this invalid, as I'm 99.9% certain guest_memfd is an innocent bystander.
CPU1 is stuck on an IN instruction (the actual port I/O), and there are a handful
of identical failures in random subsystems that pop up a few times a month[*].
My guess is the host side of the serial port is going out to lunch intermittently.

[*] https://lore.kernel.org/all/?q=%22io_serial_in%22%20syzkaller

#syz invalid
