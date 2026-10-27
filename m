Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793126911;
	b=2sqeR5cNS6zY1DZhQ/6PHUBoPKSjZ1jGdn2smDRkTCLXqFm7raRlxmLWqMIyP/xukf9T
	 7udUxVmyh6mBcmSExUR9rdGPg0f1GWWOwlobHBah0RJdz3bgpjv4WeeIevX+5DKc6+sF+
	 bBDWf4GsICQ4PD5xP4p2C+lCHjQntRbakwpOrKXU4tAU3IxncNBNx5qdaSbff7u7HuiL8
	 Smqg2yeb2tyKOFUyZp47KZagxCmT8HVD/TLSSopTDXXfV/GSWtr3K2ReJUSsKLq8LCvSt
	 BcSYEkQSm10ApMBSkdPQ0XKLf+EP3ipJ37dZ04VuHKAGty03BoWX1XLN4Sg1uc8FRUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793126911;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=MSzB1XWASGH+F7ssMzwnZlz8Zn+bsl00gQcZ/N0JfEg=;
	b=R/iaqC4UggPEKCBgc3VgLQU658TnbPmzLVPOULcU0ascLOLeDJfmh0bS1h5Al0AzK+f0
	 TfYhw5TEUrBLllk5/cUGtAaOEbxG2gH0dRiYIss1GhLgsJa3f2UlfTqVpSAAsXtBR1sMz
	 s95VEqXExZBbH9J4RmWdGtf0ch26+840gnjjkfFl9k/TW5FiQTwb76SWlBJovs4xcqnl/
	 G3w96VGycLI9lVM7EKSz4ee5o9/u1DfiQfFGjF3QRJn8qURJkAdHTu9/6sQaJKP490Cgm
	 p75M77P14HBXMQyBzmevVMa4lOnqn4UVyFSeveEJkYYoaPM2+bUOo6DDv3Nx9kNedfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m+FWkWEB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D352B606A323;
	Tue, 27 Oct 2026 18:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m+FWkWEB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0263E1F01828;
	Tue, 27 Oct 2026 18:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793126910;
	bh=MSzB1XWASGH+F7ssMzwnZlz8Zn+bsl00gQcZ/N0JfEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m+FWkWEB/usHjPgd/HeHjF823K6Da1+GalSCzv3haIPJi5KfmpeQJB0ZZL9Bw4yFC
	 GCYznMARAi2DJUTxSqGHOk1FCUCfbAluSRAD+TqgTIQFx9G+JlOAVN32JloPdigHLk
	 PIPOa7QskktQpkB3A7SC3OJthyWaq8LG0k/4YKNoqkQcVO8rJeaS8/USENaAr2ZXRB
	 sUDcRWopH82ZACGF75E9XXpgxKEkzvI97x9s9iser5Jnp/xuyd92sc6BiU/y5WwkNU
	 O/LUPQBHCsY5rp6UXBRpZn5yQw+hO3HoeP6cErD2I84I1gSLeHDo9gariXwMrVxSQh
	 IpGPUzlHwsSEg==
Date: Tue, 27 Oct 2026 18:48:28 +0000
From: Harry Yoo <harry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Hillf Danton <hdanton@sina.com>, Boqun Feng <boqun@kernel.org>, 
	syzbot <syzbot+f11512d1e5878ba5e60e@syzkaller.appspotmail.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, syzkaller-bugs@googlegroups.com, 
	Vlastimil Babka <vbabka@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-rt-devel@lists.linux.dev
Subject: Re: [syzbot] [kvm?] WARNING: locking bug in __refill_objects_node
Message-ID: <auDvUyfzg6nLtVox@thinkstation>
References: <6adf2939.67317f00.38c4bc.00ae.GAE@google.com>
 <20261026224305.1254-1-hdanton@sina.com>
 <auCucDdZb8mig7UZ@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auCucDdZb8mig7UZ@google.com>

[+Cc RT folks]

On Tue, Oct 27, 2026 at 07:00:16AM -0700, Sean Christopherson wrote:
> +slub folks
> 
> On Tue, Oct 27, 2026, Hillf Danton wrote:
> > Ask the locking people to shed light on the warning.
> 
> get_partial_node_bulk() is waiting on a non-raw spinlock while in hard IRQ context,
> and it looks like __refill_objects_node() would do the same later on.  On PREEMPT_RT,
> those spinlocks become sleepable locks, which is what triggers the splat.
> 
> The alloction coming from KVM-as-a-guest code is GFP_ATOMIC, so I think that wonky
> code is fine.

But memory allocation w/ GFP_ATOMIC is fine only on non-RT?

From the documentation:
https://docs.kernel.org/core-api/real-time/differences.html#memory-allocation
> The memory allocation APIs, such as kmalloc() and alloc_pages(),
> require a gfp_t flag to indicate the allocation context.
> On non-PREEMPT_RT kernels, it is necessary to use GFP_ATOMIC when
> allocating memory from interrupt context or from sections where
> preemption is disabled. This is because the allocator must not
> sleep in these contexts waiting for memory to become available.

Here it mentions GFP_ATOMIC allocations in preemption disabled
contexts on non-RT, and...

> However, this approach does not work on PREEMPT_RT kernels.
> The memory allocator in PREEMPT_RT uses sleeping locks internally,
> which cannot be acquired when preemption is disabled.

it says we shoud not allocate memory in such a context on RT?

> Fortunately,
> this is generally not a problem, because PREEMPT_RT moves most contexts
> that would traditionally run with preemption or interrupts disabled
> into threaded context, where sleeping is allowed.

Not sure if this applies here as I don't understand what's
going in in KVM world.

> > > Date: Mon, 26 Oct 2026 03:19:37 -0700	[thread overview]
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    c03c1a14507d Linux 7.3
> > > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=128d8ca5580000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=129d675874dbf896
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=f11512d1e5878ba5e60e
> > > compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=168d8ca5580000
> > > 
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+f11512d1e5878ba5e60e@syzkaller.appspotmail.com
> > > 
> > > =============================
> > > [ BUG: Invalid wait context ]
> > > syzkaller #0 Tainted: G S                 
> > > -----------------------------
> > > syz-executor177/6041 is trying to lock:
> > > ffff88801d040618 (&n->list_lock){-.-.}-{3:3}, at: get_partial_node_bulk mm/slub.c:3831 [inline]
> > > ffff88801d040618 (&n->list_lock){-.-.}-{3:3}, at: __refill_objects_node+0x104/0xab0 mm/slub.c:7279
> > > other info that might help us debug this:
> > > context-{2:2}
> > > locks held by syz-executor177/6041: 1, last CPU#1:
> > >  #0: ffffffff9090b438 (tomoyo_ss){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:198 [inline]
> > >  #0: ffffffff9090b438 (tomoyo_ss){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:305 [inline]
> > >  #0: ffffffff9090b438 (tomoyo_ss){.+.+}-{0:0}, at: tomoyo_read_lock security/tomoyo/common.h:1112 [inline]
> > >  #0: ffffffff9090b438 (tomoyo_ss){.+.+}-{0:0}, at: tomoyo_check_open_permission+0x169/0x3c0 security/tomoyo/file.c:772
> > > stack backtrace:
> > > CPU: 1 UID: 0 PID: 6041 Comm: syz-executor177 Tainted: G S                  syzkaller #0 PREEMPT(full) 
> > > Tainted: [S]=CPU_OUT_OF_SPEC
> > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> > > Call Trace:
> > >  <IRQ>
> > >  __dump_stack lib/dump_stack.c:94 [inline]
> > >  dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
> > >  print_lock_invalid_wait_context kernel/locking/lockdep.c:4874 [inline]
> > >  check_wait_context kernel/locking/lockdep.c:4946 [inline]
> > >  __lock_acquire+0xfcc/0x1f40 kernel/locking/lockdep.c:5238
> > >  lock_acquire kernel/locking/lockdep.c:5942 [inline]
> > >  lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
> > >  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:155 [inline]
> > >  _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:181
> > >  get_partial_node_bulk mm/slub.c:3831 [inline]
> > >  __refill_objects_node+0x104/0xab0 mm/slub.c:7279
> > >  refill_objects+0x58/0x410 mm/slub.c:7405
> > >  refill_sheaf mm/slub.c:2885 [inline]
> > >  __pcs_replace_empty_main+0x35e/0x650 mm/slub.c:4774
> > >  alloc_from_pcs mm/slub.c:4850 [inline]
> > >  slab_alloc_node mm/slub.c:4984 [inline]
> > >  __kmalloc_cache_noprof+0x4f4/0x6d0 mm/slub.c:5559
> > >  _kmalloc_noprof include/linux/slab.h:991 [inline]
> > >  _kzalloc_noprof include/linux/slab.h:1312 [inline]
> > >  kvm_async_pf_task_wake arch/x86/kernel/kvm.c:224 [inline]
> > >  __sysvec_kvm_asyncpf_interrupt+0x334/0x610 arch/x86/kernel/kvm.c:338
> > >  instr_sysvec_kvm_asyncpf_interrupt arch/x86/kernel/kvm.c:327 [inline]
> > >  sysvec_kvm_asyncpf_interrupt+0x9e/0xc0 arch/x86/kernel/kvm.c:327
> > >  </IRQ>
> > >  <TASK>
> > >  asm_sysvec_kvm_asyncpf_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:753
> > > RIP: 0010:memcmp+0x156/0x1d0 lib/string.c:665
> > > Code: 0f 86 fb fe ff ff 48 89 d8 48 89 de 48 c1 e8 03 83 e6 07 42 0f b6 14 28 48 8d 43 07 48 89 c1 48 c1 e9 03 40 38 f2 40 0f 9e c6 <84> d2 42 0f b6 0c 29 0f 95 c2 40 84 d6 0f 84 45 ff ff ff be 08 00
> > > RSP: 0018:ffffc90003ab7538 EFLAGS: 00000297
> > > RAX: ffff8880220be413 RBX: ffff8880220be40c RCX: 1ffff11004417c82
> > > RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8880220be40c
> > > RBP: ffffffff8c58a940 R08: 0000000000000001 R09: 0000000000000066
> > > R10: 0000000000000066 R11: 0000000000000001 R12: 0000000000000012
> > > R13: dffffc0000000000 R14: dffffc0000000000 R15: 0000000000000000
> > >  strstr+0x109/0x170 lib/string.c:743
> > >  tomoyo_add_entry security/tomoyo/common.c:2157 [inline]
> > >  tomoyo_supervisor+0xf47/0x1340 security/tomoyo/common.c:2238
> > >  tomoyo_audit_path_log security/tomoyo/file.c:169 [inline]
> > >  tomoyo_path_permission security/tomoyo/file.c:592 [inline]
> > >  tomoyo_path_permission+0x270/0x3b0 security/tomoyo/file.c:577
> > >  tomoyo_check_open_permission+0x37f/0x3c0 security/tomoyo/file.c:782
> > >  tomoyo_file_open+0x6b/0x90 security/tomoyo/tomoyo.c:334
> > >  security_file_open+0xb5/0x1e0 security/security.c:2739
> > >  do_dentry_open+0x588/0x14d0 fs/open.c:973
> > >  vfs_open+0x82/0x3f0 fs/open.c:1101
> > >  do_open fs/namei.c:4836 [inline]
> > >  path_openat+0x1a23/0x2450 fs/namei.c:4999
> > >  do_file_open+0x20e/0x430 fs/namei.c:5028
> > >  do_sys_openat2+0x10f/0x1e0 fs/open.c:1417
> > >  do_sys_open fs/open.c:1423 [inline]
> > >  __do_sys_openat fs/open.c:1439 [inline]
> > >  __se_sys_openat fs/open.c:1434 [inline]
> > >  __x64_sys_openat+0x12d/0x210 fs/open.c:1434
> > >  do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
> > >  do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > 

-- 
Cheers,
Harry / Hyeonggon
