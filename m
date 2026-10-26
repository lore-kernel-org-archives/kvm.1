Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.108.3.164
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793054605;
	b=m10CU1JKMdS3/Kcd94O/Zz6+AYQGWMXI6CI+CiAMxhGM5ga+Mazc/0nk43pkHwabgZ6Z
	 Cg325kAIvZQEvVhgaM/EiGTBWssPU2sSsxpk0RLS85W1GtBTzrNV3NV6S2KRY0qpEYHuQ
	 2wb4rFosbkx6Gt9JWtNSFd040DjiobFDz1SMVEUvogJlDZ5UOyK8zWvf7jobQIjFfwi7x
	 xhrRsglgQy4nIvtsKfzDqNU7RPIt4RMj5OVcTR8CUQZJ6rXps15tutNvpw5o1VbI09cQH
	 ns/zm4MLN5ZIbObo0f4MrUu0Q5ky9emZPU9MIa2KtDWLV8GNlVJ+TJHH0H3J8z7Show==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793054605;
	h=DMARC-Filter:DKIM-Signature:X-SMAIL-HELO:Received:X-Sender:X-Auth-ID:
	 X-SMAIL-MID:X-SMAIL-UIID:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=f7aSe4Sxv65Zsds/L7MRmIHr8Y4rpVrFO6R+RPKzJVQ=;
	b=1RWc/uJonlgYRYCEL0XhM4/9dQtNkpZbbndLdi/4nB81TlpapSOJui/lsAUBYHPmzvHb
	 uRYPUVOXzKpJxGAIPbDrgcqWU0lHzt3rMi5w8DB8mXuXUwmVnvhCSYE6MCUkPhLPwdMyz
	 wyC7TDqX2dYjrs3uB1UnZJE+uVKscLI2vIWv3TF+/WWauFqVeTti7TISP6WNje6vFftGl
	 GXNJ7tiWfsZjDjvEhezTW7rtSf0vP5v8OMYTx4cI8SUe8gDIm+YMVqs9hEeVmj1UIK5uA
	 8d4ZG7OCEV7vOFq3gJgMjtlcmiMITpnfImiSpQT6/+mk3YPSdaiE846aoggzBbhpeag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sina.com;
	spf=pass smtp.mailfrom=sina.com;
	dkim=pass header.d=sina.com header.i=@sina.com header.a=rsa-sha256 header.s=201208 header.b="M3JW/aMW";
	arc=none smtp.remote-ip=202.108.3.164
Received: from mail3-164.sinamail.sina.com.cn (mail3-164.sinamail.sina.com.cn [202.108.3.164])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5122C606A320
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 22:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5122C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=sina.com header.i=@sina.com header.a=rsa-sha256 header.s=201208 header.b=M3JW/aMW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1793054602;
	bh=f7aSe4Sxv65Zsds/L7MRmIHr8Y4rpVrFO6R+RPKzJVQ=;
	h=From:Subject:Date:Message-ID;
	b=M3JW/aMWQmCBRx/EXnFGkX1icTbjIDq1XmZfHAbZBAFWvJDp0F3AuKcY5mWP9sx64
	 doJMqeNTpwAoHorWGHPWuTHiNbY/Da4asBdpYGCpmpTIN/35g9qhi7xvQfpSfMRR+g
	 64KKAu9bRYDSMcheidZwjIihxdo3HoJnrIMnRTwE=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([221.216.116.161])
	by sina.com (10.54.253.32) with ESMTP
	id 6ADFD782000022EE; Mon, 27 Oct 2026 06:43:18 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7175894456982
X-SMAIL-UIID: F2260DAA33A64767990FCE80BCC0D11E-20261027-064318-1
From: Hillf Danton <hdanton@sina.com>
To: Boqun Feng <boqun@kernel.org>
Cc: syzbot <syzbot+f11512d1e5878ba5e60e@syzkaller.appspotmail.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kvm?] WARNING: locking bug in __refill_objects_node
Date: Tue, 27 Oct 2026 06:43:03 +0800
Message-ID: <20261026224305.1254-1-hdanton@sina.com>
In-Reply-To: <6adf2939.67317f00.38c4bc.00ae.GAE@google.com>
References: 
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ask the locking people to shed light on the warning.

> Date: Mon, 26 Oct 2026 03:19:37 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c03c1a14507d Linux 7.3
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> console output: https://syzkaller.appspot.com/x/log.txt?x=128d8ca5580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=129d675874dbf896
> dashboard link: https://syzkaller.appspot.com/bug?extid=f11512d1e5878ba5e60e
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=168d8ca5580000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+f11512d1e5878ba5e60e@syzkaller.appspotmail.com
> 
> =============================
> [ BUG: Invalid wait context ]
> syzkaller #0 Tainted: G S                 
> -----------------------------
> syz-executor177/6041 is trying to lock:
> ffff88801d040618 (&n->list_lock){-.-.}-{3:3}, at: get_partial_node_bulk mm/slub.c:3831 [inline]
> ffff88801d040618 (&n->list_lock){-.-.}-{3:3}, at: __refill_objects_node+0x104/0xab0 mm/slub.c:7279
> other info that might help us debug this:
> context-{2:2}
> locks held by syz-executor177/6041: 1, last CPU#1:
>  #0: ffffffff9090b438 (tomoyo_ss){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:198 [inline]
>  #0: ffffffff9090b438 (tomoyo_ss){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:305 [inline]
>  #0: ffffffff9090b438 (tomoyo_ss){.+.+}-{0:0}, at: tomoyo_read_lock security/tomoyo/common.h:1112 [inline]
>  #0: ffffffff9090b438 (tomoyo_ss){.+.+}-{0:0}, at: tomoyo_check_open_permission+0x169/0x3c0 security/tomoyo/file.c:772
> stack backtrace:
> CPU: 1 UID: 0 PID: 6041 Comm: syz-executor177 Tainted: G S                  syzkaller #0 PREEMPT(full) 
> Tainted: [S]=CPU_OUT_OF_SPEC
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
>  print_lock_invalid_wait_context kernel/locking/lockdep.c:4874 [inline]
>  check_wait_context kernel/locking/lockdep.c:4946 [inline]
>  __lock_acquire+0xfcc/0x1f40 kernel/locking/lockdep.c:5238
>  lock_acquire kernel/locking/lockdep.c:5942 [inline]
>  lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:155 [inline]
>  _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:181
>  get_partial_node_bulk mm/slub.c:3831 [inline]
>  __refill_objects_node+0x104/0xab0 mm/slub.c:7279
>  refill_objects+0x58/0x410 mm/slub.c:7405
>  refill_sheaf mm/slub.c:2885 [inline]
>  __pcs_replace_empty_main+0x35e/0x650 mm/slub.c:4774
>  alloc_from_pcs mm/slub.c:4850 [inline]
>  slab_alloc_node mm/slub.c:4984 [inline]
>  __kmalloc_cache_noprof+0x4f4/0x6d0 mm/slub.c:5559
>  _kmalloc_noprof include/linux/slab.h:991 [inline]
>  _kzalloc_noprof include/linux/slab.h:1312 [inline]
>  kvm_async_pf_task_wake arch/x86/kernel/kvm.c:224 [inline]
>  __sysvec_kvm_asyncpf_interrupt+0x334/0x610 arch/x86/kernel/kvm.c:338
>  instr_sysvec_kvm_asyncpf_interrupt arch/x86/kernel/kvm.c:327 [inline]
>  sysvec_kvm_asyncpf_interrupt+0x9e/0xc0 arch/x86/kernel/kvm.c:327
>  </IRQ>
>  <TASK>
>  asm_sysvec_kvm_asyncpf_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:753
> RIP: 0010:memcmp+0x156/0x1d0 lib/string.c:665
> Code: 0f 86 fb fe ff ff 48 89 d8 48 89 de 48 c1 e8 03 83 e6 07 42 0f b6 14 28 48 8d 43 07 48 89 c1 48 c1 e9 03 40 38 f2 40 0f 9e c6 <84> d2 42 0f b6 0c 29 0f 95 c2 40 84 d6 0f 84 45 ff ff ff be 08 00
> RSP: 0018:ffffc90003ab7538 EFLAGS: 00000297
> RAX: ffff8880220be413 RBX: ffff8880220be40c RCX: 1ffff11004417c82
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8880220be40c
> RBP: ffffffff8c58a940 R08: 0000000000000001 R09: 0000000000000066
> R10: 0000000000000066 R11: 0000000000000001 R12: 0000000000000012
> R13: dffffc0000000000 R14: dffffc0000000000 R15: 0000000000000000
>  strstr+0x109/0x170 lib/string.c:743
>  tomoyo_add_entry security/tomoyo/common.c:2157 [inline]
>  tomoyo_supervisor+0xf47/0x1340 security/tomoyo/common.c:2238
>  tomoyo_audit_path_log security/tomoyo/file.c:169 [inline]
>  tomoyo_path_permission security/tomoyo/file.c:592 [inline]
>  tomoyo_path_permission+0x270/0x3b0 security/tomoyo/file.c:577
>  tomoyo_check_open_permission+0x37f/0x3c0 security/tomoyo/file.c:782
>  tomoyo_file_open+0x6b/0x90 security/tomoyo/tomoyo.c:334
>  security_file_open+0xb5/0x1e0 security/security.c:2739
>  do_dentry_open+0x588/0x14d0 fs/open.c:973
>  vfs_open+0x82/0x3f0 fs/open.c:1101
>  do_open fs/namei.c:4836 [inline]
>  path_openat+0x1a23/0x2450 fs/namei.c:4999
>  do_file_open+0x20e/0x430 fs/namei.c:5028
>  do_sys_openat2+0x10f/0x1e0 fs/open.c:1417
>  do_sys_open fs/open.c:1423 [inline]
>  __do_sys_openat fs/open.c:1439 [inline]
>  __se_sys_openat fs/open.c:1434 [inline]
>  __x64_sys_openat+0x12d/0x210 fs/open.c:1434
>  do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>  do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
