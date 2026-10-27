Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793109618;
	b=NC7i1I34rvt5UZFGRKFe5O/Uf3l96J+b6ucgw3hnT8ZxIxrDUqkxQs3rUZz6AnUFv/X8
	 KgbFdqkdHNonbRJEHkPed5n24ZCgyE9JUqVJkaQVHTp+N6LP1ShV37Lrw5DXQ+mT3zprK
	 c9FU55UeOuvvZgFT6td3x57l0+icvuYuuWx8ViCGg1aX2CptpdWtIJMoiZSVglx5Lwvs+
	 X8zUUKGw1JAymrIyK/ndFw1TaVFPOWPYmB2nQB4QBm+1MplhuHSXBRBMiPU0W/8zG3jPD
	 FNCzKPS0qyHFt0tGqxG1HRHSMY+t3u7ldNDwpIMUrZBQfnTRF29TcRPs0wsK4J6XLHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109618;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=iAMT5ErMlUqsPBFer4Lu1BUk2YLaErYsWfjiGygyJKk=;
	b=imqETaweTEKsytSWE/0Jl/7Ikqfj7t1JANNomNk3uo5u+gDpRfkHeZh8/WkcYW9qBeYk
	 4yYx6M7byiWyCx3uHU77ZZZT4aWbsaDjBXOSmU7j3r4wFUur96ICrPoGAr9AuxklECEkg
	 jE5hvyiLJYJW8hyoeKzK9MsqbWDYdx1yLv0Fx8YToNUcHugYuYzPnOlnGiItBrpGPYT4u
	 bNz+D9ToecANmGuhiMUDEkrF7JaewUWQUgKh958IsA4ipzCn3i2ddIdZ+aC9Tc2mbO6VO
	 AC2GTl3uFjk1znQgs24QaQlPrQoVhpIA4srPSTqNCyV02ncFkHqgFGkJgSO+O0KAT5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=V9h5asR1;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0C4606A321
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 14:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E0C4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=V9h5asR1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2eaf8ea208bso1180595ad.1
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 07:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793109618; x=1793714418; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iAMT5ErMlUqsPBFer4Lu1BUk2YLaErYsWfjiGygyJKk=;
        b=V9h5asR1n3TGdrsWRGp8bP3hPD2X/EIV6lj8msTCSb8SeKFDBMDZweNynHy2jb7PKb
         Oh1Ma70wGEZDVRVbIMu37gSO8pYBzFhEU65CLUkvlMWuXbTHVmE98ojmHQmU9pZ/Ms99
         UaUH8Lgao1IV3G+RJsInYRAauoHQP5fgM3nBkNSeC1V4laoEMqd86w2pvhKd23pC9pLM
         ba7MDZLcfu4/tyKEHP+fQvks9ly3GuHF1c4vn7lpDh87SLwGsAKdlkrS+5kCC+E2z/ZX
         KXLM2KWK7LLRpwm+lGOsFVodtdtl5VnNIFJ+KK5osoPVHLtis7cd20786TYXC55JLqr0
         6NtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793109618; x=1793714418;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iAMT5ErMlUqsPBFer4Lu1BUk2YLaErYsWfjiGygyJKk=;
        b=J2dWkweqmWR4jW340/Efj3X67FPa0ovqLwrCWMLFyGbTnOI5Gu42ydRDh7Vj1naB+I
         ggM4UgQonZaeGLhPConLmvRsg0apCMJEmNJKTWkaPDUBWTaKL1AspCKtNKKXdHhzGH9l
         L3hObqSCHYbVlGSvGQojSOkj570PJEKbxLq5U1O0yD90XVg05MkvKeNddJmB/fvpUbJZ
         cSY8LryH1W86lfgw+/0Ih0SGw+zsxgedacTX7rLhAt0TN+jYVlwX++KHmbw4MnE19D0P
         FtPRcG/sg+QH77LrQSEl16SyHXT885ogLef/V4TtVcGJyUsF0eCSCgDZD1IqTn/Kd/8q
         Nd4w==
X-Forwarded-Encrypted: i=1; AKwUvBx6qVBelTkjcaSJNeasAfEOqpMp2A47611pDMjenet7wrjaqF9Ma9Gf5nptdUuD2C/Lxv0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKToydF68+kC5oyJRHStsGQp9A/doAlwQ9zFAUxtceyQl+H6p0N
	b7IXlzxpswbliysAsGVns0K217ZmNGCsN43ocZ+wKctCvPvec4rnCZr7IYxCAUbm4JJDOzDK3Wu
	KR+bzIw==
X-Received: from plvx8.prod.google.com ([2002:a17:902:9a48:b0:2e8:410e:b193])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ecc9:b0:2e6:c39:b25b
 with SMTP id d9443c01a7336-2ea9c6c835cmr77726895ad.14.1793109617334; Tue, 27
 Oct 2026 07:00:17 -0700 (PDT)
Date: Tue, 27 Oct 2026 07:00:16 -0700
In-Reply-To: <20261026224305.1254-1-hdanton@sina.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <6adf2939.67317f00.38c4bc.00ae.GAE@google.com> <20261026224305.1254-1-hdanton@sina.com>
Message-ID: <auCucDdZb8mig7UZ@google.com>
Subject: Re: [syzbot] [kvm?] WARNING: locking bug in __refill_objects_node
From: Sean Christopherson <seanjc@google.com>
To: Hillf Danton <hdanton@sina.com>
Cc: Boqun Feng <boqun@kernel.org>, 
	syzbot <syzbot+f11512d1e5878ba5e60e@syzkaller.appspotmail.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, syzkaller-bugs@googlegroups.com, 
	Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org
Content-Type: text/plain; charset="us-ascii"

+slub folks

On Tue, Oct 27, 2026, Hillf Danton wrote:
> Ask the locking people to shed light on the warning.

get_partial_node_bulk() is waiting on a non-raw spinlock while in hard IRQ context,
and it looks like __refill_objects_node() would do the same later on.  On PREEMPT_RT,
those spinlocks become sleepable locks, which is what triggers the splat.

The alloction coming from KVM-as-a-guest code is GFP_ATOMIC, so I think that wonky
code is fine.

> > Date: Mon, 26 Oct 2026 03:19:37 -0700	[thread overview]
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    c03c1a14507d Linux 7.3
> > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > console output: https://syzkaller.appspot.com/x/log.txt?x=128d8ca5580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=129d675874dbf896
> > dashboard link: https://syzkaller.appspot.com/bug?extid=f11512d1e5878ba5e60e
> > compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=168d8ca5580000
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+f11512d1e5878ba5e60e@syzkaller.appspotmail.com
> > 
> > =============================
> > [ BUG: Invalid wait context ]
> > syzkaller #0 Tainted: G S                 
> > -----------------------------
> > syz-executor177/6041 is trying to lock:
> > ffff88801d040618 (&n->list_lock){-.-.}-{3:3}, at: get_partial_node_bulk mm/slub.c:3831 [inline]
> > ffff88801d040618 (&n->list_lock){-.-.}-{3:3}, at: __refill_objects_node+0x104/0xab0 mm/slub.c:7279
> > other info that might help us debug this:
> > context-{2:2}
> > locks held by syz-executor177/6041: 1, last CPU#1:
> >  #0: ffffffff9090b438 (tomoyo_ss){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:198 [inline]
> >  #0: ffffffff9090b438 (tomoyo_ss){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:305 [inline]
> >  #0: ffffffff9090b438 (tomoyo_ss){.+.+}-{0:0}, at: tomoyo_read_lock security/tomoyo/common.h:1112 [inline]
> >  #0: ffffffff9090b438 (tomoyo_ss){.+.+}-{0:0}, at: tomoyo_check_open_permission+0x169/0x3c0 security/tomoyo/file.c:772
> > stack backtrace:
> > CPU: 1 UID: 0 PID: 6041 Comm: syz-executor177 Tainted: G S                  syzkaller #0 PREEMPT(full) 
> > Tainted: [S]=CPU_OUT_OF_SPEC
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> > Call Trace:
> >  <IRQ>
> >  __dump_stack lib/dump_stack.c:94 [inline]
> >  dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
> >  print_lock_invalid_wait_context kernel/locking/lockdep.c:4874 [inline]
> >  check_wait_context kernel/locking/lockdep.c:4946 [inline]
> >  __lock_acquire+0xfcc/0x1f40 kernel/locking/lockdep.c:5238
> >  lock_acquire kernel/locking/lockdep.c:5942 [inline]
> >  lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
> >  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:155 [inline]
> >  _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:181
> >  get_partial_node_bulk mm/slub.c:3831 [inline]
> >  __refill_objects_node+0x104/0xab0 mm/slub.c:7279
> >  refill_objects+0x58/0x410 mm/slub.c:7405
> >  refill_sheaf mm/slub.c:2885 [inline]
> >  __pcs_replace_empty_main+0x35e/0x650 mm/slub.c:4774
> >  alloc_from_pcs mm/slub.c:4850 [inline]
> >  slab_alloc_node mm/slub.c:4984 [inline]
> >  __kmalloc_cache_noprof+0x4f4/0x6d0 mm/slub.c:5559
> >  _kmalloc_noprof include/linux/slab.h:991 [inline]
> >  _kzalloc_noprof include/linux/slab.h:1312 [inline]
> >  kvm_async_pf_task_wake arch/x86/kernel/kvm.c:224 [inline]
> >  __sysvec_kvm_asyncpf_interrupt+0x334/0x610 arch/x86/kernel/kvm.c:338
> >  instr_sysvec_kvm_asyncpf_interrupt arch/x86/kernel/kvm.c:327 [inline]
> >  sysvec_kvm_asyncpf_interrupt+0x9e/0xc0 arch/x86/kernel/kvm.c:327
> >  </IRQ>
> >  <TASK>
> >  asm_sysvec_kvm_asyncpf_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:753
> > RIP: 0010:memcmp+0x156/0x1d0 lib/string.c:665
> > Code: 0f 86 fb fe ff ff 48 89 d8 48 89 de 48 c1 e8 03 83 e6 07 42 0f b6 14 28 48 8d 43 07 48 89 c1 48 c1 e9 03 40 38 f2 40 0f 9e c6 <84> d2 42 0f b6 0c 29 0f 95 c2 40 84 d6 0f 84 45 ff ff ff be 08 00
> > RSP: 0018:ffffc90003ab7538 EFLAGS: 00000297
> > RAX: ffff8880220be413 RBX: ffff8880220be40c RCX: 1ffff11004417c82
> > RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8880220be40c
> > RBP: ffffffff8c58a940 R08: 0000000000000001 R09: 0000000000000066
> > R10: 0000000000000066 R11: 0000000000000001 R12: 0000000000000012
> > R13: dffffc0000000000 R14: dffffc0000000000 R15: 0000000000000000
> >  strstr+0x109/0x170 lib/string.c:743
> >  tomoyo_add_entry security/tomoyo/common.c:2157 [inline]
> >  tomoyo_supervisor+0xf47/0x1340 security/tomoyo/common.c:2238
> >  tomoyo_audit_path_log security/tomoyo/file.c:169 [inline]
> >  tomoyo_path_permission security/tomoyo/file.c:592 [inline]
> >  tomoyo_path_permission+0x270/0x3b0 security/tomoyo/file.c:577
> >  tomoyo_check_open_permission+0x37f/0x3c0 security/tomoyo/file.c:782
> >  tomoyo_file_open+0x6b/0x90 security/tomoyo/tomoyo.c:334
> >  security_file_open+0xb5/0x1e0 security/security.c:2739
> >  do_dentry_open+0x588/0x14d0 fs/open.c:973
> >  vfs_open+0x82/0x3f0 fs/open.c:1101
> >  do_open fs/namei.c:4836 [inline]
> >  path_openat+0x1a23/0x2450 fs/namei.c:4999
> >  do_file_open+0x20e/0x430 fs/namei.c:5028
> >  do_sys_openat2+0x10f/0x1e0 fs/open.c:1417
> >  do_sys_open fs/open.c:1423 [inline]
> >  __do_sys_openat fs/open.c:1439 [inline]
> >  __se_sys_openat fs/open.c:1434 [inline]
> >  __x64_sys_openat+0x12d/0x210 fs/open.c:1434
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
> >  do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
