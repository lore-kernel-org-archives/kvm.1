Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793009979;
	b=oEIicpI8X64ETBUWRs7AoXOIDTalE7E8EO1PK5Zt17RyoTbBIBb1NYZ8tliOv7ZjQ3Jt
	 xgrVJ7IPOkbN/qCKO341Ovi/iTIcgeaId8/Mj63K7aY4QeFsV6jyNxiIdbnNky4ecvL87
	 nf4MRFHXzgfFNphfqNM0ISRXZu8uhOSLrtMxx3CN4Rp/CXiJ9ZXpaCnB7GWMZ+8iw6dgs
	 CcI2ARpqoO9VzdXbX4sj87yEfdfGcGeTFrCvVqY4QQJTgm5MFTBOHNACZfDFYaJwj/ouZ
	 FMj9OVqdc63/sSYJFL6l49KPa+pgXhLa9wBL2BTkW8PY60STg5zaph0a4TF6ftR6Bqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793009979;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 MIME-Version:X-Received:Date:X-Google-Appengine-App-Id:
	 X-Google-Appengine-App-Id-Alias:Message-ID:Subject:From:To:
	 Content-Type;
	bh=kwJJLwF0ZQzoCaj3SgNEjLJM35qmdgWFDmumD/+IktQ=;
	b=484FB0d8KXcv6LKxKLeM6Lze9xSDY31MypgpMzeKsbCXwDebyKHLp0n6aCJpjfKmWdE/
	 Mre0Dhp8d0V5hdtTP1UMxmO6QYXkLd5Eh0OpqyX40MQfl1AH5ZaWCkaKFm6NBYP38J86Q
	 6xFLkO0Plm06S6E1xSf+acNlb6s4PUqlUch2JMJP9vaUsGvsVgQoPFCRvjhXUxTCTSi+l
	 jxClj5SUO1EVXCUDM7kTKKGFh6wkjt+U3ESW241oLTAAJN/3I539570VnyDBi8MdNVQau
	 +RF+oYlRp1mfwfQIi8WX+93Ifk5lBL0UCub8LTBauym30ranNRue+p82Is9F8ucGnlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC73C606A31E
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 10:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC73C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4db3db8687fso4663571b6e.0
        for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 03:19:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793009978; x=1793614778;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kwJJLwF0ZQzoCaj3SgNEjLJM35qmdgWFDmumD/+IktQ=;
        b=O/WsviStzFuSDYdgufI4JN/bG+XuV75DaWnvH4jT99KOGuNYCAEl3oTQqdnEoAIWYP
         mkscDI5IXiWq4xPQ7gbvbMTfMyCoVNu/VGevVSOOSOlucAtu/1ZOjHj2HzBFsNGCj6Ep
         m6zppR0lNRIJ6oPkjO4VNxqrOCDdu7kRiZCTiMJX6EqwVWd22KwOcd84A8DztzY5OIuc
         49Sr1u2r1rgcjUyzOFzYX/Ke17sw0zvYzlKJccEAyXiqy+LO4tYd2pbKOYMGo8gD9XZ0
         1uphkbmVE9jHYApHBohlOTMyXFgfV9lnhPfvYEQepkJoj44kRmGph2yiPO6t6su3o3vi
         CImw==
X-Gm-Message-State: AFq9FYJGczRFLAawDIe4lOVtk4EfGMgmLK73zS9uP4U9TopavGIisHou
	D+BFJ/Q5/WnriMtjIqjaJJ9gKUwVjdmd7ul9fSljy/s0azk9tmKIy3sPnV0fMGTZ95mjzkjUEFc
	pkXt5REJ9Fla/wzbFmARMRA8Qffo5w6jG5sR3fFkMhbw/ErcQYqVONOnGMXw=
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:13c4:b0:4f4:8bec:ace3 with SMTP id
 5614622812f47-55c003741cfmr4175831b6e.57.1793009977838; Mon, 26 Oct 2026
 03:19:37 -0700 (PDT)
Date: Mon, 26 Oct 2026 03:19:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6adf2939.67317f00.38c4bc.00ae.GAE@google.com>
Subject: [syzbot] [kvm?] WARNING: locking bug in __refill_objects_node
From: syzbot <syzbot+f11512d1e5878ba5e60e@syzkaller.appspotmail.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c03c1a14507d Linux 7.3
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=128d8ca5580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=129d675874dbf896
dashboard link: https://syzkaller.appspot.com/bug?extid=f11512d1e5878ba5e60e
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=168d8ca5580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f11512d1e5878ba5e60e@syzkaller.appspotmail.com

=============================
[ BUG: Invalid wait context ]
syzkaller #0 Tainted: G S                 
-----------------------------
syz-executor177/6041 is trying to lock:
ffff88801d040618 (&n->list_lock){-.-.}-{3:3}, at: get_partial_node_bulk mm/slub.c:3831 [inline]
ffff88801d040618 (&n->list_lock){-.-.}-{3:3}, at: __refill_objects_node+0x104/0xab0 mm/slub.c:7279
other info that might help us debug this:
context-{2:2}
locks held by syz-executor177/6041: 1, last CPU#1:
 #0: ffffffff9090b438 (tomoyo_ss){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:198 [inline]
 #0: ffffffff9090b438 (tomoyo_ss){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:305 [inline]
 #0: ffffffff9090b438 (tomoyo_ss){.+.+}-{0:0}, at: tomoyo_read_lock security/tomoyo/common.h:1112 [inline]
 #0: ffffffff9090b438 (tomoyo_ss){.+.+}-{0:0}, at: tomoyo_check_open_permission+0x169/0x3c0 security/tomoyo/file.c:772
stack backtrace:
CPU: 1 UID: 0 PID: 6041 Comm: syz-executor177 Tainted: G S                  syzkaller #0 PREEMPT(full) 
Tainted: [S]=CPU_OUT_OF_SPEC
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4874 [inline]
 check_wait_context kernel/locking/lockdep.c:4946 [inline]
 __lock_acquire+0xfcc/0x1f40 kernel/locking/lockdep.c:5238
 lock_acquire kernel/locking/lockdep.c:5942 [inline]
 lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:155 [inline]
 _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:181
 get_partial_node_bulk mm/slub.c:3831 [inline]
 __refill_objects_node+0x104/0xab0 mm/slub.c:7279
 refill_objects+0x58/0x410 mm/slub.c:7405
 refill_sheaf mm/slub.c:2885 [inline]
 __pcs_replace_empty_main+0x35e/0x650 mm/slub.c:4774
 alloc_from_pcs mm/slub.c:4850 [inline]
 slab_alloc_node mm/slub.c:4984 [inline]
 __kmalloc_cache_noprof+0x4f4/0x6d0 mm/slub.c:5559
 _kmalloc_noprof include/linux/slab.h:991 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 kvm_async_pf_task_wake arch/x86/kernel/kvm.c:224 [inline]
 __sysvec_kvm_asyncpf_interrupt+0x334/0x610 arch/x86/kernel/kvm.c:338
 instr_sysvec_kvm_asyncpf_interrupt arch/x86/kernel/kvm.c:327 [inline]
 sysvec_kvm_asyncpf_interrupt+0x9e/0xc0 arch/x86/kernel/kvm.c:327
 </IRQ>
 <TASK>
 asm_sysvec_kvm_asyncpf_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:753
RIP: 0010:memcmp+0x156/0x1d0 lib/string.c:665
Code: 0f 86 fb fe ff ff 48 89 d8 48 89 de 48 c1 e8 03 83 e6 07 42 0f b6 14 28 48 8d 43 07 48 89 c1 48 c1 e9 03 40 38 f2 40 0f 9e c6 <84> d2 42 0f b6 0c 29 0f 95 c2 40 84 d6 0f 84 45 ff ff ff be 08 00
RSP: 0018:ffffc90003ab7538 EFLAGS: 00000297
RAX: ffff8880220be413 RBX: ffff8880220be40c RCX: 1ffff11004417c82
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8880220be40c
RBP: ffffffff8c58a940 R08: 0000000000000001 R09: 0000000000000066
R10: 0000000000000066 R11: 0000000000000001 R12: 0000000000000012
R13: dffffc0000000000 R14: dffffc0000000000 R15: 0000000000000000
 strstr+0x109/0x170 lib/string.c:743
 tomoyo_add_entry security/tomoyo/common.c:2157 [inline]
 tomoyo_supervisor+0xf47/0x1340 security/tomoyo/common.c:2238
 tomoyo_audit_path_log security/tomoyo/file.c:169 [inline]
 tomoyo_path_permission security/tomoyo/file.c:592 [inline]
 tomoyo_path_permission+0x270/0x3b0 security/tomoyo/file.c:577
 tomoyo_check_open_permission+0x37f/0x3c0 security/tomoyo/file.c:782
 tomoyo_file_open+0x6b/0x90 security/tomoyo/tomoyo.c:334
 security_file_open+0xb5/0x1e0 security/security.c:2739
 do_dentry_open+0x588/0x14d0 fs/open.c:973
 vfs_open+0x82/0x3f0 fs/open.c:1101
 do_open fs/namei.c:4836 [inline]
 path_openat+0x1a23/0x2450 fs/namei.c:4999
 do_file_open+0x20e/0x430 fs/namei.c:5028
 do_sys_openat2+0x10f/0x1e0 fs/open.c:1417
 do_sys_open fs/open.c:1423 [inline]
 __do_sys_openat fs/open.c:1439 [inline]
 __se_sys_openat fs/open.c:1434 [inline]
 __x64_sys_openat+0x12d/0x210 fs/open.c:1434
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f589f9da7be
Code: 08 0f 85 55 ec ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 90 41 57 41 56 4d 89 c6 41 55 4d 89 cd 41 54 55 53 48 83 ec 08
RSP: 002b:00007f589affe098 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f589affe6c0 RCX: 00007f589f9da7be
RDX: 0000000000000002 RSI: 00007f589affe1a0 RDI: ffffffffffffff9c
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f589affe1a0
R13: 0000000000000001 R14: 00007ffef59973a0 R15: 00007ffef5997488
 </TASK>
----------------
Code disassembly (best guess):
   0:	0f 86 fb fe ff ff    	jbe    0xffffff01
   6:	48 89 d8             	mov    %rbx,%rax
   9:	48 89 de             	mov    %rbx,%rsi
   c:	48 c1 e8 03          	shr    $0x3,%rax
  10:	83 e6 07             	and    $0x7,%esi
  13:	42 0f b6 14 28       	movzbl (%rax,%r13,1),%edx
  18:	48 8d 43 07          	lea    0x7(%rbx),%rax
  1c:	48 89 c1             	mov    %rax,%rcx
  1f:	48 c1 e9 03          	shr    $0x3,%rcx
  23:	40 38 f2             	cmp    %sil,%dl
  26:	40 0f 9e c6          	setle  %sil
* 2a:	84 d2                	test   %dl,%dl <-- trapping instruction
  2c:	42 0f b6 0c 29       	movzbl (%rcx,%r13,1),%ecx
  31:	0f 95 c2             	setne  %dl
  34:	40 84 d6             	test   %dl,%sil
  37:	0f 84 45 ff ff ff    	je     0xffffff82
  3d:	be                   	.byte 0xbe
  3e:	08 00                	or     %al,(%rax)


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
