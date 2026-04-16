Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A457C37E2FF
	for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 12:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776344083; cv=none; b=WOOgj6vdBTu0ubMIz19wozV9/rHrWOMivR+yZU5eGMn0886hj0G38Wxrd+RgMz/XOTAM7baQrzR96pwlp3JOoQb0PWGv+NjzlsTsH8m8QOSwOYYp0Xc5h5t5eoTWYAr5MWQY6BTQWPmxfiHjIM2Fm3/FmiMcGaLKCS5z9bPfDak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776344083; c=relaxed/simple;
	bh=gQIYCEXJktv7prGlTgLGnPqIMZA7IKUQAgdKfTv2KaI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=H7XiQ5oM3gBWEjH/YpORqDf4XPl5hy1/frWGvbk59T1Ac0cu2R2VzxJMAilo04F7rgjiTy7uMoT17PdXwmH+37gKw67qkCNIUGGxfK2sMuhmhi3XhqBPMGCqjg5amI/2RfycOQM7ufXmndaLIiHRfM2Agi/HNe7gWV1EjWPSK3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-7dc4bfa79aaso7834764a34.3
        for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 05:54:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776344080; x=1776948880;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w5XOdkxROII00878gyVtEWLv8Kszanev0vMqoiB7TZA=;
        b=Tul4YCpBLUnwIko7dW12VOxgzD8zGVpzuFDU4yLMJxmYqXtdsXcztoqBTFBKdzbvtP
         2wHb4/ZIUIQiMtULiDQqU4Omv+fTCK4jl9xHJW+bPSyOssqoO/IelSRBLth9fj/5Hzcw
         +mHcQlSgh5ZjJyb2xoTwr/FtwKgWV3LcOgoY2w9e0UhMxcESCQPuDwHIJmJjlOajzFO3
         cYiRI4g5QIna2fp2zsC2ICQhWJOUzojma0L1r6VNdSwyAvcU5cPEZitlig2SaDpblnLE
         PFNajKQQ0qjA1NHny2Q+Xi6OFDgbM6EkFmsXcA1l8HG4jWxOzMGn7KfzZe/RdOnw6d2N
         YryA==
X-Forwarded-Encrypted: i=1; AFNElJ/wa1CHgCWXnOiCRY8LE9XbjhNXEHu3gAgR+h82OG9YGYP9SGQDBbV1VRWqjscq1IwcmMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJdBGKCy0A4ZRYuYxCnnI4DGAwoi0ZVKUmZ+ykKGlL4m348Lu3
	GRn28bED+GbqFjUjdeZqo3wof7YjkG7m7QM7hcGqeT0EFRW+/xqOwibEj+KHR45rSy2oWi+LRg0
	HPx8OtVsmhbqj9N8ffZ9y2kQg5cnFiOot3lKYzIfCpNfdFDhzB5RzKsrYV1Y=
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2908:b0:689:d8b0:ccd7 with SMTP id
 006d021491bc7-68be596a66amr13776273eaf.12.1776344080584; Thu, 16 Apr 2026
 05:54:40 -0700 (PDT)
Date: Thu, 16 Apr 2026 05:54:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69e0dc10.a00a0220.8f24c.017c.GAE@google.com>
Subject: [syzbot] [kvm?] [kvm-x86?] BUG: sleeping function called from invalid
 context in kvm_xen_set_evtchn_fast
From: syzbot <syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, dwmw2@infradead.org, 
	hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, paul@xen.org, pbonzini@redhat.com, seanjc@google.com, 
	syzkaller-bugs@googlegroups.com, tglx@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e6efabc0afca Add linux-next specific files for 20260414
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14261a6a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5ee3699e4b6706d
dashboard link: https://syzkaller.appspot.com/bug?extid=208f7f3e5f59c11aeb90
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7682fddefc6a/disk-e6efabc0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/82bdc6820c4b/vmlinux-e6efabc0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f48466cb7c13/bzImage-e6efabc0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:231
in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 30, name: ktimers/1
preempt_count: 10001, expected: 0
RCU nest depth: 2, expected: 2
5 locks held by ktimers/1/30:
 #0: ffffffff8e25f260 (local_bh){.+.+}-{1:3}, at: __local_bh_disable_ip+0x3c/0x420 kernel/softirq.c:163
 #1: ffffffff8e3c8100 (rcu_read_lock){....}-{1:3}, at: __local_bh_disable_ip+0x3c/0x420 kernel/softirq.c:163
 #2: ffff8880b8726360 (&base->expiry_lock){+...}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:45 [inline]
 #2: ffff8880b8726360 (&base->expiry_lock){+...}-{3:3}, at: timer_base_lock_expiry kernel/time/timer.c:1502 [inline]
 #2: ffff8880b8726360 (&base->expiry_lock){+...}-{3:3}, at: __run_timer_base+0x120/0x9f0 kernel/time/timer.c:2384
 #3: ffffffff8e3c8100 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #3: ffffffff8e3c8100 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #3: ffffffff8e3c8100 (rcu_read_lock){....}-{1:3}, at: __rt_spin_lock kernel/locking/spinlock_rt.c:50 [inline]
 #3: ffffffff8e3c8100 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0x1e0/0x400 kernel/locking/spinlock_rt.c:57
 #4: ffff88803913dac8 (&kvm->srcu){.?.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:187 [inline]
 #4: ffff88803913dac8 (&kvm->srcu){.?.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:294 [inline]
 #4: ffff88803913dac8 (&kvm->srcu){.?.+}-{0:0}, at: kvm_xen_set_evtchn_fast+0x1c6/0x9a0 arch/x86/kvm/xen.c:1817
irq event stamp: 13772921
hardirqs last  enabled at (13772920): [<ffffffff8b443c23>] __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:187 [inline]
hardirqs last  enabled at (13772920): [<ffffffff8b443c23>] _raw_spin_unlock_irq+0x23/0x50 kernel/locking/spinlock.c:206
hardirqs last disabled at (13772921): [<ffffffff8b40abde>] sysvec_apic_timer_interrupt+0xe/0xc0 arch/x86/kernel/apic/apic.c:1061
softirqs last  enabled at (13772906): [<ffffffff81885eeb>] ksoftirqd_run_end kernel/softirq.c:325 [inline]
softirqs last  enabled at (13772906): [<ffffffff81885eeb>] run_ktimerd+0x8b/0x100 kernel/softirq.c:1153
softirqs last disabled at (13772910): [<ffffffff8192a431>] smpboot_thread_fn+0x541/0xa50 kernel/smpboot.c:160
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 UID: 0 PID: 30 Comm: ktimers/1 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
Call Trace:
 <IRQ>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 __might_resched+0x329/0x480 kernel/sched/core.c:9162
 rt_read_lock+0xa9/0x4b0 kernel/locking/spinlock_rt.c:231
 kvm_xen_set_evtchn_fast+0x1fc/0x9a0 arch/x86/kvm/xen.c:1819
 xen_timer_callback+0x109/0x220 arch/x86/kvm/xen.c:140
 __run_hrtimer kernel/time/hrtimer.c:1930 [inline]
 __hrtimer_run_queues+0x3bc/0xb10 kernel/time/hrtimer.c:1994
 hrtimer_interrupt+0x455/0x950 kernel/time/hrtimer.c:2113
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
 __sysvec_apic_timer_interrupt+0x102/0x430 arch/x86/kernel/apic/apic.c:1067
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1061 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1061
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:__raw_spin_unlock_irq include/linux/spinlock_api_smp.h:188 [inline]
RIP: 0010:_raw_spin_unlock_irq+0x29/0x50 kernel/locking/spinlock.c:206
Code: 90 f3 0f 1e fa 53 48 89 fb 48 83 c7 18 48 8b 74 24 08 e8 8a a9 5c f6 48 89 df e8 c2 35 5d f6 e8 cd e1 88 f6 fb bf 01 00 00 00 <e8> 22 c5 4f f6 65 8b 05 fb 43 77 07 85 c0 74 07 5b c3 cc cc cc cc
RSP: 0018:ffffc90000a4fb30 EFLAGS: 00000206
RAX: 0000000000d22878 RBX: ffff8880b87262c0 RCX: 0000000080000001
RDX: 0000000000000002 RSI: ffffffff8d995925 RDI: 0000000000000001
RBP: ffffc90000a4fcb8 R08: ffffffff8fcf17f7 R09: 1ffffffff1f9e2fe
R10: dffffc0000000000 R11: fffffbfff1f9e2ff R12: ffffc9000668fa20
R13: 1ffff92000149f80 R14: ffff8880b87262c0 R15: ffffc90000a4fc00
 expire_timers kernel/time/timer.c:1798 [inline]
 __run_timers kernel/time/timer.c:2374 [inline]
 __run_timer_base+0x693/0x9f0 kernel/time/timer.c:2386
 run_timer_base kernel/time/timer.c:2395 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2405
 handle_softirqs+0x1de/0x6d0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 run_ktimerd+0x69/0x100 kernel/softirq.c:1151
 smpboot_thread_fn+0x541/0xa50 kernel/smpboot.c:160
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

=============================
[ BUG: Invalid wait context ]
syzkaller #0 Tainted: G        W    L     
-----------------------------
ktimers/1/30 is trying to lock:
ffff88803913d4d0 (&gpc->lock){+.+.}-{3:3}, at: kvm_xen_set_evtchn_fast+0x1fc/0x9a0 arch/x86/kvm/xen.c:1819
other info that might help us debug this:
context-{2:2}
5 locks held by ktimers/1/30:
 #0: ffffffff8e25f260 (local_bh){.+.+}-{1:3}, at: __local_bh_disable_ip+0x3c/0x420 kernel/softirq.c:163
 #1: ffffffff8e3c8100 (rcu_read_lock){....}-{1:3}, at: __local_bh_disable_ip+0x3c/0x420 kernel/softirq.c:163
 #2: ffff8880b8726360 (&base->expiry_lock){+...}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:45 [inline]
 #2: ffff8880b8726360 (&base->expiry_lock){+...}-{3:3}, at: timer_base_lock_expiry kernel/time/timer.c:1502 [inline]
 #2: ffff8880b8726360 (&base->expiry_lock){+...}-{3:3}, at: __run_timer_base+0x120/0x9f0 kernel/time/timer.c:2384
 #3: ffffffff8e3c8100 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #3: ffffffff8e3c8100 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #3: ffffffff8e3c8100 (rcu_read_lock){....}-{1:3}, at: __rt_spin_lock kernel/locking/spinlock_rt.c:50 [inline]
 #3: ffffffff8e3c8100 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0x1e0/0x400 kernel/locking/spinlock_rt.c:57
 #4: ffff88803913dac8 (&kvm->srcu){.?.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:187 [inline]
 #4: ffff88803913dac8 (&kvm->srcu){.?.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:294 [inline]
 #4: ffff88803913dac8 (&kvm->srcu){.?.+}-{0:0}, at: kvm_xen_set_evtchn_fast+0x1c6/0x9a0 arch/x86/kvm/xen.c:1817
stack backtrace:
CPU: 1 UID: 0 PID: 30 Comm: ktimers/1 Tainted: G        W    L      syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [W]=WARN, [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
Call Trace:
 <IRQ>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4832 [inline]
 check_wait_context kernel/locking/lockdep.c:4904 [inline]
 __lock_acquire+0xec1/0x2cf0 kernel/locking/lockdep.c:5189
 lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5870
 rt_read_lock+0xcc/0x4b0 kernel/locking/spinlock_rt.c:232
 kvm_xen_set_evtchn_fast+0x1fc/0x9a0 arch/x86/kvm/xen.c:1819
 xen_timer_callback+0x109/0x220 arch/x86/kvm/xen.c:140
 __run_hrtimer kernel/time/hrtimer.c:1930 [inline]
 __hrtimer_run_queues+0x3bc/0xb10 kernel/time/hrtimer.c:1994
 hrtimer_interrupt+0x455/0x950 kernel/time/hrtimer.c:2113
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
 __sysvec_apic_timer_interrupt+0x102/0x430 arch/x86/kernel/apic/apic.c:1067
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1061 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1061
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:__raw_spin_unlock_irq include/linux/spinlock_api_smp.h:188 [inline]
RIP: 0010:_raw_spin_unlock_irq+0x29/0x50 kernel/locking/spinlock.c:206
Code: 90 f3 0f 1e fa 53 48 89 fb 48 83 c7 18 48 8b 74 24 08 e8 8a a9 5c f6 48 89 df e8 c2 35 5d f6 e8 cd e1 88 f6 fb bf 01 00 00 00 <e8> 22 c5 4f f6 65 8b 05 fb 43 77 07 85 c0 74 07 5b c3 cc cc cc cc
RSP: 0018:ffffc90000a4fb30 EFLAGS: 00000206
RAX: 0000000000d22878 RBX: ffff8880b87262c0 RCX: 0000000080000001
RDX: 0000000000000002 RSI: ffffffff8d995925 RDI: 0000000000000001
RBP: ffffc90000a4fcb8 R08: ffffffff8fcf17f7 R09: 1ffffffff1f9e2fe
R10: dffffc0000000000 R11: fffffbfff1f9e2ff R12: ffffc9000668fa20
R13: 1ffff92000149f80 R14: ffff8880b87262c0 R15: ffffc90000a4fc00
 expire_timers kernel/time/timer.c:1798 [inline]
 __run_timers kernel/time/timer.c:2374 [inline]
 __run_timer_base+0x693/0x9f0 kernel/time/timer.c:2386
 run_timer_base kernel/time/timer.c:2395 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2405
 handle_softirqs+0x1de/0x6d0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 run_ktimerd+0x69/0x100 kernel/softirq.c:1151
 smpboot_thread_fn+0x541/0xa50 kernel/smpboot.c:160
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	f3 0f 1e fa          	endbr64
   5:	53                   	push   %rbx
   6:	48 89 fb             	mov    %rdi,%rbx
   9:	48 83 c7 18          	add    $0x18,%rdi
   d:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
  12:	e8 8a a9 5c f6       	call   0xf65ca9a1
  17:	48 89 df             	mov    %rbx,%rdi
  1a:	e8 c2 35 5d f6       	call   0xf65d35e1
  1f:	e8 cd e1 88 f6       	call   0xf688e1f1
  24:	fb                   	sti
  25:	bf 01 00 00 00       	mov    $0x1,%edi
* 2a:	e8 22 c5 4f f6       	call   0xf64fc551 <-- trapping instruction
  2f:	65 8b 05 fb 43 77 07 	mov    %gs:0x77743fb(%rip),%eax        # 0x7774431
  36:	85 c0                	test   %eax,%eax
  38:	74 07                	je     0x41
  3a:	5b                   	pop    %rbx
  3b:	c3                   	ret
  3c:	cc                   	int3
  3d:	cc                   	int3
  3e:	cc                   	int3
  3f:	cc                   	int3


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
