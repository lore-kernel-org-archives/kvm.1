Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A06B86329;
	Mon,  1 Jun 2026 13:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321213; cv=none; b=o98WipL0Z0wYR4GGfXqzA7OJTUdBqE7UrSJkgf7yjCMlTgHCnx8R1tV2zr3hxwn5pVdZ7sb6ZARexuA9EjIDnKFGsrF0RAP0L3M378BRbJPWX0J49ojbykdqgj0JC8U9WY2OuItG+3LDRl+E3RAsM4yj38xzuPt7yfHL/XME9J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321213; c=relaxed/simple;
	bh=kT6cFOzMQ9OQHXHcisMCXZgerCzB2m9jo2ExYn809FM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcV/8xgS7lixpxTTLwV0Js9WAP8QlPI+5hLXzYLvnTVBDkHlVog9q5c6vrdMjWl/UbKjBhcVLx6VZhSsm7vcQJITtV0492L0S0X4CazxcMyjeR1HFWzlSgaIgIKgKB2DCNiT6bhWF9+ZNFzRn+l6sreL7rpc9lPEh9h3hsSMYdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mSzFQWD7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R0gW3Q7J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mSzFQWD7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R0gW3Q7J"
Date: Mon, 1 Jun 2026 15:40:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780321210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bweo838MmOU9lUtZ9Hc8rA2psun9I3NyruLIHZ7qYPQ=;
	b=mSzFQWD76J97r+hskBTzsK0hiq53pHddiBGwm/kVwjwNHHRNBibV1CHjB5Dl8urh3BbhiT
	8kJXmj1Cg5PgudA7J7Mp255iINHanHPfQ0aSXtqivzuV9j0dSCifEin7v1bjh4T876cMYV
	cjRRGDIkiN9b6+MYDLBaq5fxl3LSKLehkmvNI7Qr9p+eyyPUC2X1lOqsqMiHC95xMFOCqv
	mybyoeXcH9iQLibGyQnsNy0EjzWsSNud88hrdUapp+hXFLL6+hdGljessMETVoqeVI4wrM
	E3BYxZLfibQKfmXrTUo9WJ/ngGVmcfyQuLM7YTRkVq2C4bqABmNKMDrZQWocfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780321210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bweo838MmOU9lUtZ9Hc8rA2psun9I3NyruLIHZ7qYPQ=;
	b=R0gW3Q7JAOkzh1spwyMeCQym7LDzPwEuCus+oFbO/TYGEVvmNLZzHm1zPX42KiSGamHSa1
	wASOInXcx1VnECCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>, Paul Durrant <paul@xen.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com,
	Carsten Stollmaier <stollmc@amazon.com>
Subject: Re: [PATCH v2 01/20] locking/rt: Use raw_spin_lock_irqsave() in
 __rwbase_read_unlock()
Message-ID: <20260601134008.rllwJtn-@linutronix.de>
References: <20260529193437.GB3568911@noisy.programming.kicks-ass.net>
 <ahnxfACTGeVFbJMk@google.com>
 <20260529201335.GP3493090@noisy.programming.kicks-ass.net>
 <20260529203841.GC3568911@noisy.programming.kicks-ass.net>
 <aho1M7fvK1Qzmiai@google.com>
 <1c3b224f-2780-4347-b72b-783586a9b0e1@redhat.com>
 <58d17a623c1c5c9c09bd91baa30510aaf42f899b.camel@infradead.org>
 <CABgObfYJsacrCDHRouLDsEz_QF0EBQd8pu3g-V_gta6Eac2e+w@mail.gmail.com>
 <14442dbf1e6d758fdd4756f2ed5c8cb2738582fb.camel@infradead.org>
 <787aa26cf62dfd361eea8ed19f384fc517892501.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <787aa26cf62dfd361eea8ed19f384fc517892501.camel@infradead.org>

On 2026-06-01 14:01:07 [+0100], David Woodhouse wrote:
> On Mon, 2026-06-01 at 11:52 +0100, David Woodhouse wrote:
> > On Sat, 2026-05-30 at 16:40 +0200, Paolo Bonzini wrote:
> > > On Sat, May 30, 2026 at 3:04=E2=80=AFPM David Woodhouse <dwmw2@infrad=
ead.org> wrote:
> > > >=20
> > > > On Sat, 2026-05-30 at 12:26 +0200, Paolo Bonzini wrote:
> > > > >=20
> > > > > Yeah, I think so.
> > > > >=20
> > > > > The write side needs kvm->srcu so it would have to be yet another=
 SRCU.
> > > > > I initially thought that sucks for the code that calls kvm_gpc_ch=
eck(),
> > > > > but maybe not because it simply replaces read_lock/read_unlock.
> > > > >=20
> > > > > By using a seqcount for the data, SRCU only needs to be synchroni=
zed in
> > > > > gpc_unmap().=C2=A0 So, something like this:
> > > >=20
> > > > It isn't just gpc_unmap() which does the invalidation. We also
> > > > invalidate from the MMU notifier in gfn_to_pfn_cache_invalidate_sta=
rt()
> > > > which would also have to synchronize, wouldn't it?
> > >=20
> > > You're right, the write_lock_irq() there drains the readers and that
> > > is needed because khva is not pinned, only kmap()-ed.
> > >=20
> > > That is already broken for the OOM case under PREEMPT_RT, where
> > > rwlock_t becomes sleepable. But using SRCU would break it on
> > > !PREEMPT_RT as well.
> >=20
> > I don't think 'sleepable' is the problem per se, is it? *Why* does the
> > OOM killer use mmu_notifier_invalidate_range_start_nonblock()?
> >=20
> > Commit 93065ac753e4 ("mm, oom: distinguish blockable mode for mmu
> > notifiers") did say:
> >=20
> > =C2=A0=C2=A0=C2=A0 There are several blockable mmu notifiers which migh=
t sleep in
> > =C2=A0=C2=A0=C2=A0 mmu_notifier_invalidate_range_start and that is a pr=
oblem for the
> > =C2=A0=C2=A0=C2=A0 oom_reaper because it needs to guarantee a forward p=
rogress so it cannot
> > =C2=A0=C2=A0=C2=A0 depend on any sleepable locks.
> >=20
> > But that was in 2018, when mmap_lock was an rw_semaphore.
> >=20
> > Is "sleepable" still a problem even when PREEMPT_RT where almost
> > *everything* is now strictly sleepable? Wouldn't that mean drivers
> > aren't even allowed to take their own spinlocks?
=E2=80=A6
 =20
> And then we see it even when taking kvm->mn_invalidate_lock:
>=20
> kvm_mmu_notifier_invalidate_range_start+0xac
> 0xffffffff8132732c is in kvm_mmu_notifier_invalidate_range_start (arch/x8=
6/kvm/../../../virt/kvm/kvm_main.c:745).
> 740		 * adjustments will be imbalanced.
> 741		 *
> 742		 * Pairs with the decrement in range_end().
> 743		 */
> 744		spin_lock(&kvm->mn_invalidate_lock);
> 745		kvm->mn_active_invalidate_count++;
> 746		if (!mmu_notifier_range_blockable(range))
> 747			pr_info("KVM: non-blockable invalidate_range_start, non_block_count=
=3D%d\n", current->non_block_count);
> 748		spin_unlock(&kvm->mn_invalidate_lock);
> 749=09
>=20
>=20
> [  427.919969] mmap: exit_mmap: delaying before mmu_notifier_release for =
kvm_oom_test
> [  429.926972] BUG: sleeping function called from invalid context at kern=
el/locking/spinlock_rt.c:48
> [  429.926978] in_atomic(): 0, irqs_disabled(): 0, non_block: 1, pid: 280=
, name: oom_reaper
> [  429.926982] preempt_count: 0, expected: 0
> [  429.926984] RCU nest depth: 0, expected: 0
> [  429.926986] 4 locks held by oom_reaper/280:
> [  429.926989]  #0: ffff8a61da779cb0 (&mm->mmap_lock){....}-{3:3}, at: oo=
m_reaper+0x150/0x520
> [  429.927006]  #1: ffffffffa0934f20 (mmu_notifier_invalidate_range_start=
){....}-{0:0}, at: zap_vma_for_reaping+0xb7/0x1d0
> [  429.927019]  #2: ffffffffa0934f78 (srcu){....}-{0:0}, at: __mmu_notifi=
er_invalidate_range_start+0xae/0x340
> [  429.927029]  #3: ffff8a6240295360 (&kvm->mn_invalidate_lock){....}-{2:=
2}, at: kvm_mmu_notifier_invalidate_range_start+0xac/0x4b0
> [  429.927044] CPU: 26 UID: 0 PID: 280 Comm: oom_reaper Tainted: G S     =
   I         7.1.0-rc2+ #2460 PREEMPT_{RT,(lazy)}=20
> [  429.927051] Tainted: [S]=3DCPU_OUT_OF_SPEC, [I]=3DFIRMWARE_WORKAROUND
> [  429.927053] Hardware name: Intel Corporation S2600CW/S2600CW, BIOS SE5=
C610.86B.01.01.0008.021120151325 02/11/2015
> [  429.927055] Call Trace:
> [  429.927058]  <TASK>
> [  429.927062]  dump_stack_lvl+0x6e/0xa0
> [  429.927074]  __might_resched.cold+0xeb/0x100
> [  429.927084]  rt_spin_lock+0x6c/0x1a0
> [  429.927092]  ? kvm_mmu_notifier_invalidate_range_start+0xac/0x4b0
> [  429.927102]  kvm_mmu_notifier_invalidate_range_start+0xac/0x4b0
> [  429.927110]  ? sched_update_numa+0xa0/0x270
> [  429.927129]  __mmu_notifier_invalidate_range_start+0x129/0x340

Okay. This complains about non_block:

=E2=80=A6
> [  429.927260] KVM: non-blockable invalidate_range_start, non_block_count=
=3D1

and commit 312364f3534cc ("kernel.h: Add non_block_start/end()") says

|    Peter also asked whether we want to catch spinlocks on top, but Michal
|    said those are less of a problem because spinlocks can't have an indir=
ect
|    dependency upon the page allocator and hence close the loop with the o=
om
|    reaper.

so a lock which becomes sleep-able on RT vs !RT shouldn't be a problem,
right? We also don't complain about about scheduling within a
rcu_read_lock() section if it is part of spin_lock().

Sebastian
