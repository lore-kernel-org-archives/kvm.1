Received: from mail-oo2-f7.google.com (mail-oo2-f7.google.com [74.125.231.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B4649482A
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141658; cv=none; b=NSAUvE02lu0hGfAE5AnGTdLahPAYJD4eSO9vSYW7bq/qzwzv/VerQNRmx0DixFgfNvtOUM2cNPRlb/vi0s/8q+S6RBUHfn279HxdwDXucad/OV5zNswk2ly2fEkPcZAK2FZMx0Vp2TKubi1hobCQ5jhCiS6+MFCTHdJmgDak+Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141658; c=relaxed/simple;
	bh=qVLwnzFJuooHxJEhYdpgI0l0kT6jZR5zQ557mIWnQDM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sOyzIzjOHgZskK2hNKfhtzys4J/nEy+ImI5Ove8av/cMfzyR9egkTYCexK7d6kxHTnk5w/9gv/0h1vyH87pPwa/1v1gtyGzKw8rMuClQlh0u6UqUIEgt7Er4Xpsz9LGwZei8QrX1osFcKRKWgEnlWpR4GhEB0zikivNbUgQWlG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo2-f7.google.com with SMTP id 006d021491bc7-6b1bebb3ae8so308642eaf.1
        for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 08:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789141655; x=1789746455;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QM9vuIsLaNesKNf1yNPCJMjrRtXbJZBFGQGVXa3DOY4=;
        b=YxsDkQqbjZge/ehxDrtJCIcJNbvlClnpVuCsULVOPObt+hI4/NprA8wX6OPcBcke7X
         BJa0Kfa5dP70Eo1HIkuwB5yoSoIAP6nFWrapFznQdISTBMlTyvol/P+/kJjXiEGwIu78
         jGlhXmJvL+l6XrqovnF+kAx4vVvBiRK2r5eimIQcXUO/Kk5RN8oO7Tz29/Z+YPGxX2jk
         95iHLKuHw2AQSxuDsi7CxlQUWJhOfQ5/Rm520zr3BmW5zsnd+dafqnpJfHtc/3rL1/gz
         CSnGUzbPDy5kBLjZERwIfQOHwzhEYFiqdo4lK4/gH1R+hiHLCy46YAFfwRMoSaHbgkKS
         iwqg==
X-Forwarded-Encrypted: i=1; AKwUvBy3M1TDIw+8w58NUwQ+3+GyBlGc0qO4CYyhT+A02Qwj4mFxRHLEv5j2YyCTnQ4n4Pj3Nro=@vger.kernel.org
X-Gm-Message-State: AFuF++nmM+W5BrG7wsFZkTy3e+B3sa2EePaRh/ht+TwC3Qw3+EEPB6a9
	9XkcWbgHs4zfK1cK90ZRZCoXSwZ1Q9+/ZZktjSoIA0aMKKs7pKIdsBH4YqYEwGEe6gN6TVWLb3V
	8ucC60d2mHFC2SWs1WPec/M2SoHRpNoUOQWrH2nuRrlNs5TAYbhp0lnvEmm8=
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:8582:20b0:6b1:9f9d:7a00 with SMTP id
 006d021491bc7-6c0b9d512camr4916628eaf.5.1789141655109; Fri, 11 Sep 2026
 08:47:35 -0700 (PDT)
Date: Fri, 11 Sep 2026 08:47:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aa42297.f2639fcc.29487d.002f.GAE@google.com>
Subject: [syzbot] [kvm?] INFO: task hung in kvm_gmem_release (2)
From: syzbot <syzbot+ab6273c58262b9de56d9@syzkaller.appspotmail.com>
To: david@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pbonzini@redhat.com, seanjc@google.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    50d05c7c76c9 Merge tag 'landlock-7.3-rc3' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13db5ef9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e4e3a0e188a497e
dashboard link: https://syzkaller.appspot.com/bug?extid=ab6273c58262b9de56d9
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=143121f9580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/daf497619736/disk-50d05c7c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/748fbd82f647/vmlinux-50d05c7c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e61c59099d07/bzImage-50d05c7c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ab6273c58262b9de56d9@syzkaller.appspotmail.com

INFO: task syz.0.17:5886 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.17        state:D stack:25512 pid:5886  tgid:5886  ppid:5771   task_flags:0x400040 flags:0x08080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5526 [inline]
 __schedule+0x17db/0x58f0 kernel/sched/core.c:7276
 __schedule_loop kernel/sched/core.c:7353 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7368
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7425
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x7c1/0x1550 kernel/locking/mutex.c:821
 kvm_gmem_release+0xdf/0x3e0 virt/kvm/guest_memfd.c:310
 __fput+0x418/0xa50 fs/file_table.c:512
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:70 [inline]
 exit_to_user_mode_loop+0x204/0x770 kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:336 [inline]
 __do_fast_syscall_32+0x437/0x6a0 arch/x86/entry/syscall_32.c:294
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/syscall_32.c:316
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7f660ec
RSP: 002b:00000000ff830cbc EFLAGS: 00000206 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 000000000000001e
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Showing all locks held in the system:
locks held by khungtaskd/32: 1, last CPU#0:
 #0: ffffffff8ed5c8a0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffffffff8ed5c8a0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8ed5c8a0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6871
locks held by getty/5374: 2, on CPU#1:
 #0: ffff88803555b0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000322b2e8 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x45a/0x1360 drivers/tty/n_tty.c:2211
locks held by syz.0.17/5886: 1, on CPU#1:
 #0: ffff8880597c00a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_gmem_release+0xdf/0x3e0 virt/kvm/guest_memfd.c:310
locks held by syz.0.17/5889: 1, last CPU#1:
 #0: ffff8880597c00a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_vm_set_mem_attributes virt/kvm/kvm_main.c:2566 [inline]
 #0: ffff8880597c00a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_vm_ioctl_set_mem_attributes+0x33c/0x1600 virt/kvm/kvm_main.c:2625
locks held by syz.1.20/5950: 1, on CPU#1:
 #0: ffff88807ea780a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_gmem_release+0xdf/0x3e0 virt/kvm/guest_memfd.c:310
locks held by syz.1.20/5952: 1, last CPU#1:
 #0: ffff88807ea780a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_vm_set_mem_attributes virt/kvm/kvm_main.c:2566 [inline]
 #0: ffff88807ea780a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_vm_ioctl_set_mem_attributes+0x33c/0x1600 virt/kvm/kvm_main.c:2625
locks held by syz.2.21/5991: 1, on CPU#0:
 #0: ffff8880291340a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_gmem_release+0xdf/0x3e0 virt/kvm/guest_memfd.c:310
locks held by syz.2.21/5993: 1, last CPU#0:
 #0: ffff8880291340a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_vm_set_mem_attributes virt/kvm/kvm_main.c:2566 [inline]
 #0: ffff8880291340a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_vm_ioctl_set_mem_attributes+0x33c/0x1600 virt/kvm/kvm_main.c:2625
locks held by syz.3.23/6034: 1, on CPU#1:
 #0: ffff88807b7ac0a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_gmem_release+0xdf/0x3e0 virt/kvm/guest_memfd.c:310
locks held by syz.3.23/6036: 1, last CPU#0:
 #0: ffff88807b7ac0a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_vm_set_mem_attributes virt/kvm/kvm_main.c:2566 [inline]
 #0: ffff88807b7ac0a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_vm_ioctl_set_mem_attributes+0x33c/0x1600 virt/kvm/kvm_main.c:2625
locks held by syz.4.24/6081: 1, on CPU#0:
 #0: ffff88807ea480a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_gmem_release+0xdf/0x3e0 virt/kvm/guest_memfd.c:310
locks held by syz.4.24/6083: 2, last CPU#1:
 #0: ffff88807ea480a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_vm_set_mem_attributes virt/kvm/kvm_main.c:2566 [inline]
 #0: ffff88807ea480a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_vm_ioctl_set_mem_attributes+0x33c/0x1600 virt/kvm/kvm_main.c:2625
 #1: ffffffff8ed5c8a0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffffff8ed5c8a0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffffff8ed5c8a0 (rcu_read_lock){....}-{1:3}, at: ieee80211_rx_napi+0xd1/0x3d0 net/mac80211/rx.c:5742
locks held by syz.5.27/6142: 1, on CPU#1:
 #0: ffff888072ba00a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_gmem_release+0xdf/0x3e0 virt/kvm/guest_memfd.c:310
locks held by syz.5.27/6144: 1, last CPU#0:
 #0: ffff888072ba00a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_vm_set_mem_attributes virt/kvm/kvm_main.c:2566 [inline]
 #0: ffff888072ba00a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_vm_ioctl_set_mem_attributes+0x33c/0x1600 virt/kvm/kvm_main.c:2625
locks held by syz.6.28/6190: 1, on CPU#1:
 #0: ffff88807090c0a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_gmem_release+0xdf/0x3e0 virt/kvm/guest_memfd.c:310
locks held by syz.6.28/6192: 1, last CPU#0:
 #0: ffff88807090c0a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_vm_set_mem_attributes virt/kvm/kvm_main.c:2566 [inline]
 #0: ffff88807090c0a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_vm_ioctl_set_mem_attributes+0x33c/0x1600 virt/kvm/kvm_main.c:2625
locks held by syz.7.29/6246: 1, on CPU#1:
 #0: ffff888032ad40a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_gmem_release+0xdf/0x3e0 virt/kvm/guest_memfd.c:310
locks held by syz.7.29/6248: 1, last CPU#1:
 #0: ffff888032ad40a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_vm_set_mem_attributes virt/kvm/kvm_main.c:2566 [inline]
 #0: ffff888032ad40a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_vm_ioctl_set_mem_attributes+0x33c/0x1600 virt/kvm/kvm_main.c:2625

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 32 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x274/0x2d0 lib/nmi_backtrace.c:123
 nmi_trigger_cpumask_backtrace+0x17d/0x390 lib/nmi_backtrace.c:66
 trigger_all_cpu_backtrace include/linux/nmi.h:164 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x135/0x170 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:353 [inline]
 watchdog+0xfd7/0x1030 kernel/hung_task.c:561
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 6083 Comm: syz.4.24 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:__this_cpu_preempt_check+0x0/0x20 lib/smp_processor_id.c:63
Code: f5 48 8b 74 24 20 48 c7 c7 00 9b 6d 8c e8 88 ac 42 f5 e8 23 ab 4d f5 eb ae 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 48 89 fe 48 c7 c7 80 9a 6d 8c e9 0d ff ff ff cc cc cc
RSP: 0018:ffffc90003d27460 EFLAGS: 00000046
RAX: 0000000000000001 RBX: 0000000000000001 RCX: 8000000000000001
RDX: 0000000000000000 RSI: ffff88807ea4a3d0 RDI: ffffffff8e6fe7fc
RBP: 00000000ffffffff R08: ffffc90003d2755f R09: 0000000000000000
R10: ffffc90003d27548 R11: fffff520007a4eac R12: 0000000000000246
R13: ffff8880314c5dc0 R14: ffff88807ea4a3d0 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff888124dd2000(0063) knlGS:00000000f6834b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f71e8c10 CR3: 0000000073d5a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 lockdep_recursion_finish kernel/locking/lockdep.c:470 [inline]
 lock_is_held_type+0xdf/0x150 kernel/locking/lockdep.c:6017
 lock_is_held include/linux/lockdep.h:249 [inline]
 xa_entry include/linux/xarray.h:1227 [inline]
 xas_descend lib/xarray.c:208 [inline]
 xas_load+0x198/0x5a0 lib/xarray.c:246
 __xa_cmpxchg_raw lib/xarray.c:1783 [inline]
 __xa_cmpxchg+0xc3/0x1f0 lib/xarray.c:1769
 xa_cmpxchg include/linux/xarray.h:699 [inline]
 xa_reserve include/linux/xarray.h:1088 [inline]
 kvm_vm_set_mem_attributes virt/kvm/kvm_main.c:2577 [inline]
 kvm_vm_ioctl_set_mem_attributes+0x429/0x1600 virt/kvm/kvm_main.c:2625
 kvm_vm_ioctl+0xb33/0xd30 virt/kvm/kvm_main.c:5356
 kvm_vm_compat_ioctl+0x2b1/0x3a0 virt/kvm/kvm_main.c:5480
 __do_compat_sys_ioctl fs/ioctl.c:695 [inline]
 __se_compat_sys_ioctl fs/ioctl.c:638 [inline]
 __ia32_compat_sys_ioctl+0x5ea/0x950 fs/ioctl.c:638
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:79 [inline]
 __do_fast_syscall_32+0x27a/0x6a0 arch/x86/entry/syscall_32.c:291
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/syscall_32.c:316
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf705f0ec
Code: 90 85 d2 74 0a 89 ce 81 e6 ff 0f 00 00 89 32 85 c0 74 05 c1 e9 0c 89 08 31 c0 5e 5d c3 90 0f 1f 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 58 b8
RSP: 002b:00000000f683450c EFLAGS: 00000206 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 000000004020aed2
RDX: 0000000080000200 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
