Received: from mail-oi2-f1.google.com (mail-oi2-f1.google.com [74.125.231.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E271EB19B
	for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 14:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788185815; cv=none; b=Q/EFrnt8niSLz/42kp3Z46NaORe3DWZfnF/7Gt0A4zCxxCWfNfRPIJjqQ5iSYhRZ7sVBkmKmHko1GorEieXoG8Qr5MUxKUtDeEzeNn1ZBckjnejGhTIa5OaGW9hob8L2dTy6ZK62rful10wk7y7Rw+40ZnaokkKqo9dur8QFHJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788185815; c=relaxed/simple;
	bh=5J8+h2X+UJ765NJnkaf379tWFSjm61zrbLkTZbYFUz0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=f0kISFwsidr45e/GqVTu7hyt95XsWVyCYYsDat/Su/WUTqeLsiGNLG9q05S9NfLB5N+gTQiSdJYB7o9N/RJ+fYqSVWeKP2e+jfC/NeSncV8oXrWXoBGa/2H6ZahcrAXEu5gVMUEO1nNKPa+GjOeUopgrPum3Rj5JEJi9x37UHVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f1.google.com with SMTP id 5614622812f47-4b379409c74so944199b6e.0
        for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 07:16:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788185813; x=1788790613;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b1EW2CJOojbKHZ9ZhywIovdwExeL64GkrcTsZeJGyWM=;
        b=fYBrnLFAw5yNWeGi4WhhEwsOM1sgA5zkpw87Hq50z6mKFlN4GZNU+HiHX+xl1zckx5
         ZxbXy3Ts5cZVzyOiZtCbw0Jb0bHHSvmbTaUfMJuIib9AtcKAby3DKoFhN7ZjZo7eNci5
         pTDPSJ5Qd8rB5iv5QJM/onBGxE9XbX9/AScsUfNiUoszunmUjSXZQb7gqH7cj7o4niJK
         kI8uinzC+RSCB9SiQr/BOPsgidWVVFw8f7O+inp2gQiWZkYk9UIrLCkIBVRN84rMjrG/
         Jx9pHyufAvlVnk7BouImcEzhrqPHvvob1R7LkzuYpoUwhyfBRkPhSj6iFGCCT9C9EyE1
         nhqQ==
X-Forwarded-Encrypted: i=1; AHgh+RotQnCKZcnffIRSOMw8/xjZhBU/MPlqHpGNsZ8xadC+8xBdLS/haipfP+ztRurYaZSkzL8=@vger.kernel.org
X-Gm-Message-State: AFuF++m08wL9T+wgaq9FiyHIvfpG6RdNN+q0Be7+tKTt9x8TFN42NCjR
	tXZ8y8G9jEYE8oyZsHApD0KF58H0jy0mUleeoyqZX5zKmtPqiRZqW6aCIKNszwjxay1+Ky3TvvV
	aE/1oaflRY15jdeCN7AKei8DlAc2Jqw0N3+LtIVrhsBezRg/7kFPcfsCFeaw=
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:14c4:b0:4a3:fb6c:9adf with SMTP id
 5614622812f47-4b5b8198937mr1343976b6e.12.1788185812994; Mon, 31 Aug 2026
 07:16:52 -0700 (PDT)
Date: Mon, 31 Aug 2026 07:16:52 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a958cd4.a8e469d2.cbf3.561d.GAE@google.com>
Subject: [syzbot] [kvm?] INFO: task hung in kvm_gmem_release
From: syzbot <syzbot+6895ff73d58c59e653ba@syzkaller.appspotmail.com>
To: david@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pbonzini@redhat.com, seanjc@google.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    08dbfad3f504 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12ee0349580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e4e3a0e188a497e
dashboard link: https://syzkaller.appspot.com/bug?extid=6895ff73d58c59e653ba
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1153ee25580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ddff5719ec3b/disk-08dbfad3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4b5e39b20fa5/vmlinux-08dbfad3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/eb1f70eed57f/bzImage-08dbfad3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6895ff73d58c59e653ba@syzkaller.appspotmail.com

INFO: task syz.0.17:6104 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.17        state:D stack:25544 pid:6104  tgid:6104  ppid:5900   task_flags:0x400040 flags:0x00080003
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5520 [inline]
 __schedule+0x17d4/0x5820 kernel/sched/core.c:7270
 __schedule_loop kernel/sched/core.c:7347 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7362
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7419
 __mutex_lock+0
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x7c1/0x1550 kernel/locking/mutex.c:821
 kvm_gmem_release+0xdf/0x3e0 virt/kvm/guest_memfd.c:310
 __fput+0x418/0xa50 fs/file_table.c:512
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 ptrace_notify+0x27c/0x2b0 kernel/signal.c:2524
 ptrace_report_syscall include/linux/ptrace.h:416 [inline]
 ptrace_report_syscall_exit+0x2d/0x50 include/linux/ptrace.h:477
 arch_ptrace_report_syscall_exit include/linux/entry-common.h:233 [inline]
 syscall_exit_work include/linux/entry-common.h:266 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:297 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:334 [inline]
 do_syscall_64+0x4a0/0x520 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f625079e159
RSP: 002b:00007ffd1d739348 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007f6250a27da0 RCX: 00007f625079e159
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f6250a27da0 R08: 0000000000000006 R09: 0000000000000000
R10: 00007f6250a27cb0 R11: 0000000000000246 R12: 00000000000277b3
R13: 00007f6250a2609c R14: 0000000000027546 R15: 00007ffd1d739450
 </TASK>

Showing all locks held in the system:
locks held by pr/ttyS0/16: 2, last CPU#1:
 #0: ffffffff8ec362b8 (console_srcu){....}-{0:0}, at: rcu_try_lock_acquire include/linux/rcupdate.h:314 [inline]
 #0: ffffffff8ec362b8 (console_srcu){....}-{0:0}, at: srcu_read_lock_nmisafe include/linux/srcu.h:439 [inline]
 #0: ffffffff8ec362b8 (console_srcu){....}-{0:0}, at: console_srcu_read_lock+0x30/0x60 kernel/printk/printk.c:291
 #1: ffffffff9ad2f098 (&port_lock_key){-...}-{3:3}, at: __uart_port_lock_irqsave include/linux/serial_core.h:613 [inline]
 #1: ffffffff9ad2f098 (&port_lock_key){-...}-{3:3}, at: univ8250_console_device_lock+0x67/0xc0 drivers/tty/serial/8250/8250_core.c:413
locks held by khungtaskd/32: 1, last CPU#0:
 #0: ffffffff8ed5c6e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffffffff8ed5c6e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8ed5c6e0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6837
locks held by getty/5374: 2, on CPU#0:
 #0: ffff8880325cd0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900032332e8 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x45a/0x1360 drivers/tty/n_tty.c:2211
locks held by syz.0.17/6104: 1, on CPU#1:
 #0: ffff88807bb840a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_gmem_release+0xdf/0x3e0 virt/kvm/guest_memfd.c:310
locks held by syz.0.17/6106: 1, last CPU#0:
 #0: ffff88807bb840a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_vm_set_mem_attributes virt/kvm/kvm_main.c:2566 [inline]
 #0: ffff88807bb840a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_vm_ioctl_set_mem_attributes+0x33c/0x1600 virt/kvm/kvm_main.c:2625
locks held by syz.1.18/6149: 1, on CPU#1:
 #0: ffff8880334a80a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_gmem_release+0xdf/0x3e0 virt/kvm/guest_memfd.c:310
locks held by syz.1.18/6151: 3, last CPU#0:
 #0: ffff8880334a80a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_vm_set_mem_attributes virt/kvm/kvm_main.c:2566 [inline]
 #0: ffff8880334a80a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_vm_ioctl_set_mem_attributes+0x33c/0x1600 virt/kvm/kvm_main.c:2625
 #1: ffffffff8ee8f900 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:316 [inline]
 #1: ffffffff8ee8f900 (fs_reclaim){+.+.}-{0:0}, at: xa_cmpxchg include/linux/xarray.h:697 [inline]
 #1: ffffffff8ee8f900 (fs_reclaim){+.+.}-{0:0}, at: xa_reserve include/linux/xarray.h:1088 [inline]
 #1: ffffffff8ee8f900 (fs_reclaim){+.+.}-{0:0}, at: kvm_vm_set_mem_attributes virt/kvm/kvm_main.c:2577 [inline]
 #1: ffffffff8ee8f900 (fs_reclaim){+.+.}-{0:0}, at: kvm_vm_ioctl_set_mem_attributes+0x3a1/0x1600 virt/kvm/kvm_main.c:2625
 #2: ffffffff8eea5560 (mmu_notifier_invalidate_range_start){+.+.}-{0:0}, at: fs_reclaim_acquire+0x7c/0x100 mm/page_alloc.c:4392
locks held by syz.2.19/6189: 1, on CPU#0:
 #0: ffff88807f99c0a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_gmem_release+0xdf/0x3e0 virt/kvm/guest_memfd.c:310
locks held by syz.2.19/6191: 1, last CPU#0:
 #0: ffff88807f99c0a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_vm_set_mem_attributes virt/kvm/kvm_main.c:2566 [inline]
 #0: ffff88807f99c0a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_vm_ioctl_set_mem_attributes+0x33c/0x1600 virt/kvm/kvm_main.c:2625
locks held by syz.3.20/6228: 1, on CPU#1:
 #0: ffff888035a6c0a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_gmem_release+0xdf/0x3e0 virt/kvm/guest_memfd.c:310
locks held by syz.3.20/6230: 1, last CPU#1:
 #0: ffff888035a6c0a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_vm_set_mem_attributes virt/kvm/kvm_main.c:2566 [inline]
 #0: ffff888035a6c0a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_vm_ioctl_set_mem_attributes+0x33c/0x1600 virt/kvm/kvm_main.c:2625
locks held by syz.4.22/6283: 1, on CPU#0:
 #0: ffff8880781540a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_gmem_release+0xdf/0x3e0 virt/kvm/guest_memfd.c:310
locks held by syz.4.22/6285: 1, last CPU#1:
 #0: ffff8880781540a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_vm_set_mem_attributes virt/kvm/kvm_main.c:2566 [inline]
 #0: ffff8880781540a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_vm_ioctl_set_mem_attributes+0x33c/0x1600 virt/kvm/kvm_main.c:2625
locks held by syz.5.23/6331: 1, on CPU#0:
 #0: ffff88802c2340a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_gmem_release+0xdf/0x3e0 virt/kvm/guest_memfd.c:310
locks held by syz.5.23/6333: 1, last CPU#1:
 #0: ffff88802c2340a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_vm_set_mem_attributes virt/kvm/kvm_main.c:2566 [inline]
 #0: ffff88802c2340a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_vm_ioctl_set_mem_attributes+0x33c/0x1600 virt/kvm/kvm_main.c:2625

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
CPU: 1 UID: 0 PID: 16 Comm: pr/ttyS0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:io_serial_in+0x77/0xc0 drivers/tty/serial/8250/8250_port.c:409
Code: e8 4e e8 55 fc 44 89 f9 d3 e3 49 83 c6 40 4c 89 f0 48 c1 e8 03 42 80 3c 20 00 74 08 4c 89 f7 e8 1f b0 c5 fc 41 03 1e 89 da ec <0f> b6 c0 5b 41 5c 41 5e 41 5f e9 5a cc 74 06 cc 44 89 f9 80 e1 07
RSP: 0018:ffffc900001578b8 EFLAGS: 00000002
RAX: 1ffffffff35a5e00 RBX: 00000000000003fd RCX: 0000000000000000
RDX: 00000000000003fd RSI: 0000000000000000 RDI: 0000000000000020
RBP: dffffc0000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: ffffffff8571cb00 R12: dffffc0000000000
R13: 0000000000000000 R14: ffffffff9ad2f0c0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888124ddc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000557adc994a38 CR3: 00000000772ec000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 serial_in drivers/tty/serial/8250/8250.h:128 [inline]
 serial_lsr_in drivers/tty/serial/8250/8250.h:150 [inline]
 wait_for_lsr+0x184/0x2f0 drivers/tty/serial/8250/8250_port.c:2013
 serial8250_fifo_wait_for_lsr_thre drivers/tty/serial/8250/8250_port.c:3270 [inline]
 __serial8250_console_fifo_write+0xcd/0x3e0 drivers/tty/serial/8250/8250_port.c:3345
 serial8250_console_fifo_write drivers/tty/serial/8250/8250_port.c:3378 [inline]
 __serial8250_console_write drivers/tty/serial/8250/8250_port.c:3429 [inline]
 serial8250_console_write+0xaa1/0x1200 drivers/tty/serial/8250/8250_port.c:3493
 nbcon_emit_next_record+0xef5/0x1a90 kernel/printk/nbcon.c:-1
 nbcon_emit_one kernel/printk/nbcon.c:1157 [inline]
 nbcon_kthread_func+0x679/0x880 kernel/printk/nbcon.c:1271
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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
