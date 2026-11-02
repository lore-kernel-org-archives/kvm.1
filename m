Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641418;
	b=eAFCtHOPAOstjU9EiER5kwcI0CCnkFmoLh+NvtwkgkWgHAgLMTVnttqfin4J1NfIMWLS
	 8SVLgefTpoiJeUdTwSzwR1aXjnqjE7GDLz/nlz5ha9y3Cf1uz/BRRAjnKSzy31EXOzfOM
	 8FYIZSj23VAt7hk3g43SYZvXeVY5WUVrApppV/UeaMMIrTQi0bdbOk2lri/E937nEtEUU
	 Kmu8G4kO0iRn2VzNhUryEwh5ETRRDPW3rHAt0kcm1Q6eCsj+BN1EG5xmXVO98t29v+L/Z
	 os5RoaankQAzPu66q6PawIuZke94YDDToJ8M73e/VYRFDzkQ5RNH3k6gs1/e12NT5/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641418;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=raeJlK9yYBGSF7+QYGBqsG5Ux8i2znTMcBRplAhhHPo=;
	b=CO4CX4jCQWpMtif6R6b99RjNjHOfT+Upcc3SG2TqKbDMIhODEnQabl5wkIB5zKvGgrc0
	 lD6wcHu+Y9rnLRz3cSmaASx7y2upRYYpSx1n1oZ8P11WpuO6kNKVnR24+n4LHdlQp/Q7X
	 /ogb4AZd8yB3R3Gc3bV9GLxZM/zY/HQLrUAJis/aV89lUY5GLbloCWrmTWOCxWmRaqFzl
	 NkuVL4cP+/t9zII6fKQcmPrM1/P4bmEUAKjEYnGuGKIQatIWwFQA/Eq0ATK+CoX9ZiTAL
	 ipPGUE7/d7bok1+qUDvgDeC510VuQVpQumBxW5M2vffahqHvyaBTRkWnSN4dp9/pRkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZXoHB5P1;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D85606B1C9
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:43:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28D85606B1C9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZXoHB5P1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e9821ca96fso52967315ad.0
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 09:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793641416; x=1794246216; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=raeJlK9yYBGSF7+QYGBqsG5Ux8i2znTMcBRplAhhHPo=;
        b=ZXoHB5P16CVQnJEKWlY1C+JYQkR9IGnrndtLEV0HUTpNsJGR5cOx1j0chdxtDl0m3c
         l4CCXWO6z+yw/UwSXmykAZXrfUNH0zmmA/WWGjQn2ZLs643b8PnE0q8uOhHOmxGirlIQ
         D1u3EQPHs0HeB/YoqkcLx64+1dqCUl97Oce3r+0LwOlhtqcNV8Nls56QRHYn32a6EHdW
         O1G1aWDP5xVwHbs2m/wnM02zsLOMTjs0DeSjK5yEsF3P0Zc7BOAT5uQPbXCYQWy2uF6m
         zzM8iLuw54yW7eBSsKm4tEx2Zr5UzWhD6NVlgJxoHN/S+1auQpxinQRogfD6/YpCBkkY
         S2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793641416; x=1794246216;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=raeJlK9yYBGSF7+QYGBqsG5Ux8i2znTMcBRplAhhHPo=;
        b=Io+MdcSYX26WsweHr2uMpzQGqHFLZ6jSOIDvDSbnTV6YEch+KA/egEq+auAaTFoEBu
         lX3fbN7j9aUkuMEYb1sdzuOGLTx1ICi35BQm2Sd3axMmmYPvYB49BLW5/G+z+Ul78Pju
         Os64V4xut+ISc7SeDtkBMbNHwMA2Ug8K4g4pF39wK/BNl10Fn5hlz8/0JPYEoJHwivtf
         hYZ89mPhvEZTTZHJujZOHYz9aduaKJAbNBaTymsfbtDQw+VVe8rKWCT2D9m6Su7X1wR4
         U2WDV3mY6M80JssxWkhukdYMaQGpVN42mtoSQA5nii0TAJNR34bixNKlbG8e/JZfpCTj
         GE7g==
X-Forwarded-Encrypted: i=1; AKwUvBx9Lqn3pNMZoTwmv6y2d750yrN63NkDkGdzF14TVDxDBxCrngSFww7yXmrgcr3dkn/vaGA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Wz3abHOO3d05QpshY7mUO/5+KClaUnO0DKqEpTH86epLShnVo
	Fm9/L6SVtd71BeAIWFGOxS4NmzdHFagRp4355mSTiHvbfWaAril0kJPBJbsWPaHATeo7Gx3EsGy
	6P4Y4WQ==
X-Received: from plkg13.prod.google.com ([2002:a17:903:19cd:b0:2e8:1f84:7c18])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea0d:b0:2e8:1d5c:f6f9
 with SMTP id d9443c01a7336-2eb364715ddmr105628745ad.46.1793641416165; Mon, 02
 Nov 2026 09:43:36 -0800 (PST)
Date: Mon, 2 Nov 2026 09:43:35 -0800
In-Reply-To: <20261027163929.2bb28d5b@gandalf.local.home>
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
 <auCucDdZb8mig7UZ@google.com> <auDvUyfzg6nLtVox@thinkstation> <20261027163929.2bb28d5b@gandalf.local.home>
Message-ID: <aujLx1FOc12E72rF@google.com>
Subject: Re: [syzbot] [kvm?] WARNING: locking bug in __refill_objects_node
From: Sean Christopherson <seanjc@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Harry Yoo <harry@kernel.org>, Hillf Danton <hdanton@sina.com>, Boqun Feng <boqun@kernel.org>, 
	syzbot <syzbot+f11512d1e5878ba5e60e@syzkaller.appspotmail.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, syzkaller-bugs@googlegroups.com, 
	Vlastimil Babka <vbabka@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	linux-rt-devel@lists.linux.dev, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

+Paolo

On Tue, Oct 27, 2026, Steven Rostedt wrote:
> On Tue, 27 Oct 2026 18:48:28 +0000
> Harry Yoo <harry@kernel.org> wrote:
> 
> > [+Cc RT folks]
> > 
> > On Tue, Oct 27, 2026 at 07:00:16AM -0700, Sean Christopherson wrote:
> > > +slub folks
> > > 
> > > On Tue, Oct 27, 2026, Hillf Danton wrote:  
> > > > Ask the locking people to shed light on the warning.  
> > > 
> > > get_partial_node_bulk() is waiting on a non-raw spinlock while in hard IRQ context,
> > > and it looks like __refill_objects_node() would do the same later on.  On PREEMPT_RT,
> > > those spinlocks become sleepable locks, which is what triggers the splat.
> > > 
> > > The alloction coming from KVM-as-a-guest code is GFP_ATOMIC, so I think that wonky
> > > code is fine.  
> > 
> > But memory allocation w/ GFP_ATOMIC is fine only on non-RT?
> 
> Correct. GFP_ATOMIC is meaningless on RT. It still cannot be called with
> preemption disabled. Most places that disable preemption in the non-RT case
> do not disable it in the RT case. For example, spin_lock() disables
> preemption on non-RT but does not in RT. Same for interrupt handlers, as in
> RT interrupt handlers are run in task context.
> 
> That is, in RT only "special" places disable preemption for real.

...

> > > > > =============================
> > > > > [ BUG: Invalid wait context ]
> > > > > syzkaller #0 Tainted: G S                 
> > > > > -----------------------------
> > > > > syz-executor177/6041 is trying to lock:
> > > > > ffff88801d040618 (&n->list_lock){-.-.}-{3:3}, at: get_partial_node_bulk mm/slub.c:3831 [inline]
> > > > > ffff88801d040618 (&n->list_lock){-.-.}-{3:3}, at: __refill_objects_node+0x104/0xab0 mm/slub.c:7279
> > > > > other info that might help us debug this:
> > > > > context-{2:2}
> > > > > locks held by syz-executor177/6041: 1, last CPU#1:
> > > > >  #0: ffffffff9090b438 (tomoyo_ss){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:198 [inline]
> > > > >  #0: ffffffff9090b438 (tomoyo_ss){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:305 [inline]
> > > > >  #0: ffffffff9090b438 (tomoyo_ss){.+.+}-{0:0}, at: tomoyo_read_lock security/tomoyo/common.h:1112 [inline]
> > > > >  #0: ffffffff9090b438 (tomoyo_ss){.+.+}-{0:0}, at: tomoyo_check_open_permission+0x169/0x3c0 security/tomoyo/file.c:772
> > > > > stack backtrace:
> > > > > CPU: 1 UID: 0 PID: 6041 Comm: syz-executor177 Tainted: G S                  syzkaller #0 PREEMPT(full) 
> > > > > Tainted: [S]=CPU_OUT_OF_SPEC
> > > > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> > > > > Call Trace:
> > > > >  <IRQ>
> > > > >  __dump_stack lib/dump_stack.c:94 [inline]
> > > > >  dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
> > > > >  print_lock_invalid_wait_context kernel/locking/lockdep.c:4874 [inline]
> > > > >  check_wait_context kernel/locking/lockdep.c:4946 [inline]
> > > > >  __lock_acquire+0xfcc/0x1f40 kernel/locking/lockdep.c:5238
> > > > >  lock_acquire kernel/locking/lockdep.c:5942 [inline]
> > > > >  lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
> > > > >  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:155 [inline]
> > > > >  _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:181
> > > > >  get_partial_node_bulk mm/slub.c:3831 [inline]
> > > > >  __refill_objects_node+0x104/0xab0 mm/slub.c:7279
> > > > >  refill_objects+0x58/0x410 mm/slub.c:7405
> > > > >  refill_sheaf mm/slub.c:2885 [inline]
> > > > >  __pcs_replace_empty_main+0x35e/0x650 mm/slub.c:4774
> > > > >  alloc_from_pcs mm/slub.c:4850 [inline]
> > > > >  slab_alloc_node mm/slub.c:4984 [inline]
> > > > >  __kmalloc_cache_noprof+0x4f4/0x6d0 mm/slub.c:5559
> > > > >  _kmalloc_noprof include/linux/slab.h:991 [inline]
> > > > >  _kzalloc_noprof include/linux/slab.h:1312 [inline]
> > > > >  kvm_async_pf_task_wake arch/x86/kernel/kvm.c:224 [inline]
> 
> Hmm, this part is OK:
> 
>                 if (!dummy) {
>                         raw_spin_unlock(&b->lock);
>                         dummy = kzalloc_obj(*dummy, GFP_ATOMIC);
> 
> As it releases the raw_spin_lock() before calling kzalloc_obj().
> 
> So something else must have disabled preemption/interrupts.

Heh, yeah, the IRQ that kicked all of this off.

> > > > >  __sysvec_kvm_asyncpf_interrupt+0x334/0x610 arch/x86/kernel/kvm.c:338
> 
> DEFINE_IDTENTRY_SYSVEC(sysvec_kvm_asyncpf_interrupt)
> {       
>         struct pt_regs *old_regs = set_irq_regs(regs);
>         u32 token;
>                 
>         apic_eoi();
> 
>         inc_irq_stat(HYPERVISOR_CALLBACK);
> 
>         if (__this_cpu_read(async_pf_enabled)) {
>                 token = __this_cpu_read(apf_reason.token);
>                 kvm_async_pf_task_wake(token);
>                 __this_cpu_write(apf_reason.token, 0);
>                 wrmsrq(MSR_KVM_ASYNC_PF_ACK, 1);
>         }
> 
>         set_irq_regs(old_regs);
> }
> 
> 
> Is that run in hard interrupt context?

Yep.

> If so, we need to make that a thread for RT kernels if you want to call
> kzalloc_obj().

Eww.  I can't imagine there's a sane usecase for memory overcommitting a real-time
guest.  I'd rather just disable PV async #PF support, e.g.

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 6b0a5861ccb8..b14b03720525 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -51,7 +51,7 @@
 
 DEFINE_STATIC_KEY_FALSE_RO(kvm_async_pf_enabled);
 
-static int kvmapf = 1;
+static int kvmapf = !IS_ENABLED(CONFIG_PREEMPT_RT);
 
 static int __init parse_no_kvmapf(char *arg)
 {
