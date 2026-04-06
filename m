Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE01538E5E6
	for <kvm@vger.kernel.org>; Mon,  6 Apr 2026 19:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775505207; cv=none; b=Nzsx05ndWN5mo3KNHZuqlkbJhLhFIJlQe9fWyoU8WVJLtRFjB+NxInZrtKwNhnLexuRqUG5ZikQoGCIab6FRhppQRPANkvNVwYLnFHoe4yqQUxZYDeATAHl7jKpUJDYJIblBOyJHwMUW25rDhFFHxTdmAu5x6tWFnpLtbbiJ/k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775505207; c=relaxed/simple;
	bh=JtpGouAhZnkTfaEnmUSfDDU/EVBuuPIz4a2KSs34Be8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jDJ4vdGblPcBNgBD8Y4Pdw+di3eju6b/Jxri4WMza8Jpf12/LwGEUAc46e1Nz7y206Lf8bLxSyZmxSddaZyOLLA0hFRlZK09UO7/sROAvGXO3iNO8kUY1Q9zAAIaBGR7ogMo0FKfxq3JT1D6SjEa7VHKjsJcAaf0nx9vZW2ATEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-67a1e063795so12608787eaf.1
        for <kvm@vger.kernel.org>; Mon, 06 Apr 2026 12:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775505204; x=1776110004;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=72oHUd3+51SuZRl4o5JICdRgp5ZBw+p0R8TfWR8xAAs=;
        b=fDP2LU7enIKbUr2H9tP2v4cWPfUpQQxYR/aRCJo3aifKNoYSX4wUhB9tCNnbpzaGwZ
         HFpszTbJDj1VkeNqTPkETP1cN5cp2pj0c6IcAz+bzWw6qQdkOpJurfLSJmZEwOwbYZTI
         4et8eneglLAzIvHHXv4DJ4WWdSBT/AqBWdyQA6EIontzb2dNf/UTX5f2chLMY3YLikVo
         1vWpDeXf4bDcT+MPgTalifkci7Ffh8s6E2moohVFKQXWKKuMQuXOM9rJosVPujf4gpOx
         TPXiB2n493oebKDlmV+yd239VsT3/Ax9fVVz8PpyXctSJSLA38tVVUiFlHsg1/PoSMfb
         M5TQ==
X-Forwarded-Encrypted: i=1; AJvYcCXk7eurTsWpTaWihD1WAUWPGtp66SudCcKrfOQLXZcw4MiePhQXA0FH6lMgAxve+kZfGLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmhO28LUWgMTD0ZmfOay789Mes2jBetcU+zfMpFCj3D1Daxsv3
	pHd1Bh9cudPx2TZOH2vEE06NBj3l5v+EJp/4Ll4f10JFNWVDQlVGGuxEyPb8ZpDRRST8g6iLUyE
	hN6eYjGk8aQwBpl8Amy4Qf3VxzoUZPi6cESsLzcRdc0tdOuMPLb7IdihAveY=
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:400b:b0:684:2ed4:2c21 with SMTP id
 006d021491bc7-6842ed42e86mr4725126eaf.7.1775505204669; Mon, 06 Apr 2026
 12:53:24 -0700 (PDT)
Date: Mon, 06 Apr 2026 12:53:24 -0700
In-Reply-To: <691afc89.a70a0220.3124cb.009a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69d40f34.050a0220.2dbe29.0032.GAE@google.com>
Subject: Re: [syzbot] [kvm?] INFO: task hung in kvm_swap_active_memslots (2)
From: syzbot <syzbot+5c566b850d6ab6f0427a@syzkaller.appspotmail.com>
To: glider@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pbonzini@redhat.com, seanjc@google.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    591cd656a1bf Linux 7.0-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1480b3da580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=64e78d99d9bf8b4c
dashboard link: https://syzkaller.appspot.com/bug?extid=5c566b850d6ab6f0427a
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a9a302580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=131136ba580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bf0f027c93ec/disk-591cd656.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/60d829be17f4/vmlinux-591cd656.xz
kernel image: https://storage.googleapis.com/syzbot-assets/673c009c7550/bzImage-591cd656.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5c566b850d6ab6f0427a@syzkaller.appspotmail.com

INFO: task syz.0.17:6023 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.17        state:D stack:25752 pid:6023  tgid:6023  ppid:5958   task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5298 [inline]
 __schedule+0xfee/0x6120 kernel/sched/core.c:6911
 __schedule_loop kernel/sched/core.c:6993 [inline]
 schedule+0xdd/0x390 kernel/sched/core.c:7008
 kvm_swap_active_memslots+0x2e0/0x7c0 virt/kvm/kvm_main.c:1627
 kvm_activate_memslot virt/kvm/kvm_main.c:1786 [inline]
 kvm_create_memslot virt/kvm/kvm_main.c:1852 [inline]
 kvm_set_memslot+0xbde/0x1740 virt/kvm/kvm_main.c:1964
 kvm_set_memory_region+0xe1c/0x1570 virt/kvm/kvm_main.c:2120
 kvm_set_internal_memslot+0x9f/0xf0 virt/kvm/kvm_main.c:2143
 __x86_set_memory_region+0x2f6/0x730 arch/x86/kvm/x86.c:13355
 kvm_alloc_apic_access_page+0xc5/0x140 arch/x86/kvm/lapic.c:2861
 vmx_vcpu_create+0x79b/0xb90 arch/x86/kvm/vmx/vmx.c:7830
 kvm_arch_vcpu_create+0x683/0xac0 arch/x86/kvm/x86.c:12803
 kvm_vm_ioctl_create_vcpu virt/kvm/kvm_main.c:4207 [inline]
 kvm_vm_ioctl+0x756/0x4080 virt/kvm/kvm_main.c:5165
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbd53f9c819
RSP: 002b:00007fffae0c01c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fbd54215fa0 RCX: 00007fbd53f9c819
RDX: 0000000000000004 RSI: 000000000000ae41 RDI: 0000000000000003
RBP: 00007fbd54032c91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fbd54215fac R14: 00007fbd54215fa0 R15: 00007fbd54215fa0
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffffffff8e7e7760 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:312 [inline]
 #0: ffffffff8e7e7760 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:850 [inline]
 #0: ffffffff8e7e7760 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x3d/0x184 kernel/locking/lockdep.c:6775
2 locks held by getty/5584:
 #0: ffff8880394da0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000332b2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x419/0x1500 drivers/tty/n_tty.c:2211
2 locks held by syz.0.17/6023:
 #0: ffff8880785f00a8 (&kvm->slots_lock){+.+.}-{4:4}, at: class_mutex_constructor include/linux/mutex.h:253 [inline]
 #0: ffff8880785f00a8 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_alloc_apic_access_page+0x27/0x140 arch/x86/kvm/lapic.c:2855
 #1: ffff8880785f0138 (&kvm->slots_arch_lock){+.+.}-{4:4}, at: kvm_set_memslot+0x34/0x1740 virt/kvm/kvm_main.c:1915
2 locks held by syz.1.18/6062:
 #0: ffff88807cae00a8 (&kvm->slots_lock){+.+.}-{4:4}, at: class_mutex_constructor include/linux/mutex.h:253 [inline]
 #0: ffff88807cae00a8 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_alloc_apic_access_page+0x27/0x140 arch/x86/kvm/lapic.c:2855
 #1: ffff88807cae0138 (&kvm->slots_arch_lock){+.+.}-{4:4}, at: kvm_set_memslot+0x34/0x1740 virt/kvm/kvm_main.c:1915
2 locks held by syz.2.19/6085:
 #0: ffff8880790a00a8 (&kvm->slots_lock){+.+.}-{4:4}, at: class_mutex_constructor include/linux/mutex.h:253 [inline]
 #0: ffff8880790a00a8 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_alloc_apic_access_page+0x27/0x140 arch/x86/kvm/lapic.c:2855
 #1: ffff8880790a0138 (&kvm->slots_arch_lock){+.+.}-{4:4}, at: kvm_set_memslot+0x34/0x1740 virt/kvm/kvm_main.c:1915
2 locks held by syz.3.20/6109:
 #0: ffff88807b3340a8 (&kvm->slots_lock){+.+.}-{4:4}, at: class_mutex_constructor include/linux/mutex.h:253 [inline]
 #0: ffff88807b3340a8 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_alloc_apic_access_page+0x27/0x140 arch/x86/kvm/lapic.c:2855
 #1: ffff88807b334138 (&kvm->slots_arch_lock){+.+.}-{4:4}, at: kvm_set_memslot+0x34/0x1740 virt/kvm/kvm_main.c:1915
2 locks held by syz.4.21/6138:
 #0: ffff8880343100a8 (&kvm->slots_lock){+.+.}-{4:4}, at: class_mutex_constructor include/linux/mutex.h:253 [inline]
 #0: ffff8880343100a8 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_alloc_apic_access_page+0x27/0x140 arch/x86/kvm/lapic.c:2855
 #1: ffff888034310138 (&kvm->slots_arch_lock){+.+.}-{4:4}, at: kvm_set_memslot+0x34/0x1740 virt/kvm/kvm_main.c:1915
2 locks held by syz.5.22/6172:
 #0: ffff88802b0e40a8 (&kvm->slots_lock){+.+.}-{4:4}, at: class_mutex_constructor include/linux/mutex.h:253 [inline]
 #0: ffff88802b0e40a8 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_alloc_apic_access_page+0x27/0x140 arch/x86/kvm/lapic.c:2855
 #1: ffff88802b0e4138 (&kvm->slots_arch_lock){+.+.}-{4:4}, at: kvm_set_memslot+0x34/0x1740 virt/kvm/kvm_main.c:1915
2 locks held by syz.6.23/6201:
 #0: ffff88805ead00a8 (&kvm->slots_lock){+.+.}-{4:4}, at: class_mutex_constructor include/linux/mutex.h:253 [inline]
 #0: ffff88805ead00a8 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_alloc_apic_access_page+0x27/0x140 arch/x86/kvm/lapic.c:2855
 #1: ffff88805ead0138 (&kvm->slots_arch_lock){+.+.}-{4:4}, at: kvm_set_memslot+0x34/0x1740 virt/kvm/kvm_main.c:1915
2 locks held by syz.7.24/6230:
 #0: ffff8880582a40a8 (&kvm->slots_lock){+.+.}-{4:4}, at: class_mutex_constructor include/linux/mutex.h:253 [inline]
 #0: ffff8880582a40a8 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_alloc_apic_access_page+0x27/0x140 arch/x86/kvm/lapic.c:2855
 #1: ffff8880582a4138 (&kvm->slots_arch_lock){+.+.}-{4:4}, at: kvm_set_memslot+0x34/0x1740 virt/kvm/kvm_main.c:1915
2 locks held by syz.8.25/6259:
 #0: ffff8880556000a8 (&kvm->slots_lock){+.+.}-{4:4}, at: class_mutex_constructor include/linux/mutex.h:253 [inline]
 #0: ffff8880556000a8 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_alloc_apic_access_page+0x27/0x140 arch/x86/kvm/lapic.c:2855
 #1: ffff888055600138 (&kvm->slots_arch_lock){+.+.}-{4:4}, at: kvm_set_memslot+0x34/0x1740 virt/kvm/kvm_main.c:1915

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 31 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 nmi_cpu_backtrace.cold+0x12d/0x151 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x1d7/0x230 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:161 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x141/0x190 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:346 [inline]
 watchdog+0xd25/0x1050 kernel/hung_task.c:515
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 175 Comm: kworker/u8:6 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
Workqueue: events_unbound nsim_dev_trap_report_work
RIP: 0010:chacha_block_generic+0x102/0x360 lib/crypto/chacha-block-generic.c:80
Code: df 48 89 44 24 38 49 8b 45 08 48 89 44 24 40 49 8b 45 10 48 89 44 24 48 49 8b 45 18 48 89 44 24 50 49 8b 45 20 48 89 44 24 58 <49> 8b 45 28 48 89 44 24 60 49 8b 45 30 48 89 44 24 68 49 8b 45 38
RSP: 0018:ffffc90003067820 EFLAGS: 00000046
RAX: 21eb668f03ac7932 RBX: ffffc90003067940 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000014 RDI: ffffc90003067a70
RBP: ffffc90003067a70 R08: 0000000000000001 R09: 0000000000000000
R10: ffffc90003067aa0 R11: 3a60345ebc2c5805 R12: dffffc0000000000
R13: ffffc90003067a70 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888124340000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000563c2aaa9660 CR3: 000000000e598000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 chacha20_block include/crypto/chacha.h:45 [inline]
 crng_fast_key_erasure+0x1a5/0x260 drivers/char/random.c:319
 crng_make_state+0x1c2/0x6c0 drivers/char/random.c:385
 _get_random_bytes+0x11c/0x220 drivers/char/random.c:399
 nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:846 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:876 [inline]
 nsim_dev_trap_report_work+0x79b/0xd10 drivers/net/netdevsim/dev.c:922
 process_one_work+0xa23/0x19a0 kernel/workqueue.c:3276
 process_scheduled_works kernel/workqueue.c:3359 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3440
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
