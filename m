Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BB7208D0
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 00:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782173567; cv=none; b=ayILjDtGZ7qULsD4jGvvXX0G0uDgowAy15DsWkrrEjXOldZn8WsGUYStjYfqxItohACCrXa9DsiCRJncZI+aBC+pLLs23ofNZEPW5Cthfkucw82XGE/vYwHzCIx5qgWOv5Dy5Aznz2/ql+/HGCxTp0G3HQ21RmMivVsA1h7DPi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782173567; c=relaxed/simple;
	bh=3JX4nYAVliQVeKM+RabVp8csLWMdGDORiF8NcAqUsJM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iCm1tpJZQ5K6cT1B0Tc6wo+YuhgHnbLhvFdqGZ8BZmwmI86xvOQMLkAUbRdIaPcvP6NMgzNY2ukWQvGlbBd9xtEI4Y2PYwWn6OiyB8HlWHjvbJNTNKC2xyVmEY4qDmtKFWrXdZfFXJSxUlU7Jpt5wGjLqciifK6ciFpSWfA9+eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q7wWhnkJ; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q7wWhnkJ"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8923722247so7549960a12.2
        for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 17:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782173565; x=1782778365; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vcej4Fap87Zsgcz4ZeHQ+nokonPoLvwOzHQmfnhPAqU=;
        b=q7wWhnkJ32iqKIkz9odmuzvfgno/rfgY+R5Gx3r1ZTbueIk6UbBV1pRRle9EwMREgg
         WtyLzMTfe/PjwFaVCTaklLusdIgy+wC8x7Ael4YmYchpPpABSszvBj+ffLJR5uN1at1C
         oqArtkXz/hmJ+osoG59WTHUyVpnImAGsTN4FHcjXYvYbKmYBikceKT3U/OEQNiz2njaW
         UYtBO8hUcpLtC1N60jUExktgazJ0ZTQWnVswNwpItLAmzS4k0Fti/k+g0Oe3hTZ0UTC3
         aQ34LDDLS7o2vfALfvqB1hG6ushOBqxb3LvjQWkLxMWBmYeCDFjnXpx2RQzHrhbXw5jn
         Bm6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782173565; x=1782778365;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vcej4Fap87Zsgcz4ZeHQ+nokonPoLvwOzHQmfnhPAqU=;
        b=K2b5WrfaCKEmVc4knKNN2ANodMR6W/q2zFL0Os7LHpZYaJd81i658ZXgfazXmLTiE0
         pPugxq9/yOqMYoyz6DBHGYoz1bDPRjwRIjpdIwmaSzuBzI1aqnP0ELdFP2X4fUhSW0ZA
         LIS1zwgvd7rjbAROswEVItwn+0FB3s/2eHpnAhLJINh+757iGog0OeqHHjkzRtPu5CCa
         GVySlDoo/tT7rxFsKtH1y3GjOYK78IM8mLLxFI7qIVloFA2yZAPvz/XM0CdsZyR2OJur
         Xo5mj7nAF2OPofHBmTieGyUe3IV2FZ9rOtfHe5cxfdrhHYV4PE6PjW90kbyxOwVrmxPT
         Hrmw==
X-Forwarded-Encrypted: i=1; AFNElJ/N3DrJGwpMmnmqCF2GkLQNp22cnfDzD3oSYEOOjoXyZ3WHMzrxmBBrn5O16XG+TU5I+34=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKlHjs0s6p7zuAA7OLHMvZ81AW7DU/qNoZaFZn3T5EvpfBiuqD
	4/GEw5vpbd+oFLshTsytnVy1lKb2sDastRoy1HeqvaVjl95Ph1pHIvuHcL6uvNvxYr/AU/N6ImC
	qsE7MPg==
X-Received: from pgfw8.prod.google.com ([2002:a63:c108:0:b0:c89:3021:af25])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a0d:b0:3b3:223f:d3fc
 with SMTP id adf61e73a8af0-3bb34a7cd24mr17598574637.45.1782173564986; Mon, 22
 Jun 2026 17:12:44 -0700 (PDT)
Date: Mon, 22 Jun 2026 17:12:44 -0700
In-Reply-To: <6a396a66.52ae72c2.136ac7.0002.GAE@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <6a396a66.52ae72c2.136ac7.0002.GAE@google.com>
Message-ID: <ajnPfP1Y2sSIEY3F@google.com>
Subject: Re: [syzbot] [kvm-x86?] WARNING in hv_tlb_flush_enqueue
From: Sean Christopherson <seanjc@google.com>
To: syzbot <syzbot+5d2b94b77112148d1744@syzkaller.appspotmail.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	pbonzini@redhat.com, syzkaller-bugs@googlegroups.com, tglx@kernel.org, 
	x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 22, 2026, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8cd8cf7a07e5 Merge tag 'scsi-misc' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1012a7a1580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e69294ccc24d9da
> dashboard link: https://syzkaller.appspot.com/bug?extid=5d2b94b77112148d1744
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14c0db7a580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13dd001c580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-8cd8cf7a.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/b15ef084e059/vmlinux-8cd8cf7a.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a22f25c3f8ee/bzImage-8cd8cf7a.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+5d2b94b77112148d1744@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> pvqspinlock: lock 0xffff88802c0c8790 has corrupted value 0x0!
> WARNING: kernel/locking/qspinlock_paravirt.h:504 at __pv_queued_spin_unlock_slowpath+0x220/0x2e0 kernel/locking/qspinlock_paravirt.h:504, CPU#0: syz.0.3154/18851
> Modules linked in:
> CPU: 0 UID: 0 PID: 18851 Comm: syz.0.3154 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> RIP: 0010:__pv_queued_spin_unlock_slowpath+0x223/0x2e0 kernel/locking/qspinlock_paravirt.h:504
> Code: fc ff df 48 c1 ea 03 0f b6 14 02 4c 89 e0 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 4d 41 8b 14 24 48 8d 3d 40 00 44 05 4c 89 e6 <67> 48 0f b9 3a e9 2f ff ff ff 48 89 df 48 89 14 24 e8 17 07 e0 f6
> RSP: 0018:ffffc9000c4273a0 EFLAGS: 00010246
> RAX: 0000000000000003 RBX: ffff88802c0c8790 RCX: ffffffff8b99c87f
> RDX: 0000000000000000 RSI: ffff88802c0c8790 RDI: ffffffff90ddc8f0
> RBP: ffff88802c0c8798 R08: 0000000000000000 R09: ffffed10058190f2
> R10: ffff88802c0c8793 R11: 0000000000000000 R12: ffff88802c0c8790
> R13: ffff88802c0c8000 R14: 0000000000000000 R15: ffff88802c0c87d0
> FS:  00007ffaf56696c0(0000) GS:ffff8880d6318000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 000000005645e000 CR4: 0000000000352ef0
> Call Trace:
>  <TASK>
>  __raw_callee_save___pv_queued_spin_unlock_slowpath+0x15/0x40
>  .slowpath+0x9/0x18
>  pv_queued_spin_unlock arch/x86/include/asm/paravirt-spinlock.h:40 [inline]
>  queued_spin_unlock arch/x86/include/asm/paravirt-spinlock.h:72 [inline]
>  do_raw_spin_unlock+0x145/0x1e0 kernel/locking/spinlock_debug.c:142
>  __raw_spin_unlock include/linux/spinlock_api_smp.h:168 [inline]
>  _raw_spin_unlock+0x1e/0x50 kernel/locking/spinlock.c:190
>  spin_unlock include/linux/spinlock.h:390 [inline]
>  hv_tlb_flush_enqueue.isra.0+0x195/0x200 arch/x86/kvm/hyperv.c:1967
>  kvm_hv_flush_tlb+0x17b4/0x1ae0 arch/x86/kvm/hyperv.c:2150
>  kvm_hv_hypercall+0xd0b/0x2350 arch/x86/kvm/hyperv.c:2629
>  kvm_emulate_hypercall+0x115/0x3c0 arch/x86/kvm/x86.c:10510
>  __vmx_handle_exit arch/x86/kvm/vmx/vmx.c:6848 [inline]
>  vmx_handle_exit+0x4d6/0x1ef0 arch/x86/kvm/vmx/vmx.c:6858
>  vcpu_enter_guest arch/x86/kvm/x86.c:11550 [inline]
>  vcpu_run+0x3558/0x5d50 arch/x86/kvm/x86.c:11707
>  kvm_arch_vcpu_ioctl_run+0x5b6/0x1890 arch/x86/kvm/x86.c:12062
>  kvm_vcpu_ioctl+0x730/0x1700 virt/kvm/kvm_main.c:4470
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:597 [inline]
>  __se_sys_ioctl fs/ioctl.c:583 [inline]
>  __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7ffaf479ce59
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffaf5669028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007ffaf4a15fa0 RCX: 00007ffaf479ce59
> RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000006
> RBP: 00007ffaf4832e6f R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffaf4a16038 R14: 00007ffaf4a15fa0 R15: 00007ffcc021d3a8
>  </TASK>
> ----------------
> Code disassembly (best guess), 3 bytes skipped:
>    0:	48 c1 ea 03          	shr    $0x3,%rdx
>    4:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx
>    8:	4c 89 e0             	mov    %r12,%rax
>    b:	83 e0 07             	and    $0x7,%eax
>    e:	83 c0 03             	add    $0x3,%eax
>   11:	38 d0                	cmp    %dl,%al
>   13:	7c 04                	jl     0x19
>   15:	84 d2                	test   %dl,%dl
>   17:	75 4d                	jne    0x66
>   19:	41 8b 14 24          	mov    (%r12),%edx
>   1d:	48 8d 3d 40 00 44 05 	lea    0x5440040(%rip),%rdi        # 0x5440064
>   24:	4c 89 e6             	mov    %r12,%rsi
> * 27:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
>   2c:	e9 2f ff ff ff       	jmp    0xffffff60
>   31:	48 89 df             	mov    %rbx,%rdi
>   34:	48 89 14 24          	mov    %rdx,(%rsp)
>   38:	e8 17 07 e0 f6       	call   0xf6e00754
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

#syz test: https://github.com/sean-jc/linux.git aec262d23f20702b3fd317bf67d470499daba87a
