Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB38332EA0
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 22:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776898530; cv=none; b=s0ZwBS12+PCOYgFO69qGu4811bi+D8D62DVybtvrmYPd1TdS1+OxapWPpt0wCEPTMKsFoxum5NNuOrLNBWO9ayFRIbcMjrP4sELfU2LIIhEMHJ6RZ6Ni6E52WkeDdrMqAFN7IzLB1rdG0z0+FmzCR/YuKXWJhPQa1rt8KC/xVcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776898530; c=relaxed/simple;
	bh=+u5D+5Sv9jhhyxNFLsazufe9L/dotOsZL5WdG/zfsuQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IuObuqMT2iYNdkY5tg5YgMoxUjELIgWEaRjghh84Bm7NtDjaXH7ug2rRttC9gfsIYmZCFGMKYMIqf/zklQWs1KqnkQrctILvQkJJcIdG+viOBsCzaMB1v/J07yQ4NrRQYmfKZLECwl5ed331au1StYtfaLymYmpYRfPxW9HDUUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SmrGlQN4; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SmrGlQN4"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b24308165dso65598395ad.1
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 15:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776898528; x=1777503328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EJN7orb4YCrM88fTz1p8W9nTGwOq33wwz4HY+GOoxSY=;
        b=SmrGlQN44k1L6Fnj8secLUfEPz4pNZQKm4M8EyEZRYhso83nF/ky5FXE4LYkUF/cM0
         G18Dl/JgMSiOgmbhQ/diNb7Um5fGt/MsTbG/rwY/9HNnDoNeAZkyzBq9DwyCwGzKgGru
         MHXexb+Z3WY2RlG3DQA7eC5XIbC2FdALNaNKRPqTGH/QQe45HwbvAydQtpePlaxgDqn7
         m9cnWIfwtau7vmZ23ws7R8yofGMXHGQTZBLy+9h5/eq7G9kOo7ogHor10g4DDU2DWdqr
         bGaOeStZ/7ehmbzrhXO7htHi2q22uR4w+YH4jxI2z+XUyfYowd7usFM6eDoQG8HcyUrQ
         uoBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776898528; x=1777503328;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EJN7orb4YCrM88fTz1p8W9nTGwOq33wwz4HY+GOoxSY=;
        b=rHiT+D0jvmjPViaeLjmCqvULfKb591/yRVzjJubO8NC7l72Gng9/S6Ne4QOWJGoxPj
         ibPGNzS0iIpoNcJflrtTUMuiHJycSj8x+eHtjLmwzCx3Lpxb9wkasccPu8YE5ppQpAcC
         sT8PlbLHXPpXFPs7gNfDH2PmjkD24YAWi2OFIR//nuKrGTqWi7k+hPgx8b+gtgxPoCt2
         RnPNx31MTPPPPLkdJIO9bXaFtVrIxexqehS/2ys/SLxZme4bnhwkgvwW82nq5scqtfq1
         sXOBuG/IPPnB72e1DLq303nRC+yl+hPQ1WV7w1sxVQV7vV3OEeKse4h1FVFncjSQfsdP
         Kvdg==
X-Forwarded-Encrypted: i=1; AFNElJ/EcVI41XTRhuhnm5yZrDuAYxfBk5F5YTnZta1m+WilUMtMx2Q45TmDHGXwwoTGYbEdxVM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2q6Xv7QkEhJeuz9jxhYIf0ExQv+N4zxGrXUX9oUrRyZOSq7rE
	LADocE11G+fxAVvCn1pGicK6M5a1BGmcGWIz8NA7RnjqGXyXjLj/sxPq3Zcqv/B7Hg3W79706QG
	J5Hc4ng==
X-Received: from plbjb4.prod.google.com ([2002:a17:903:2584:b0:2b4:6c6b:66f4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d505:b0:2b2:4fcc:2687
 with SMTP id d9443c01a7336-2b5f9f50c25mr256471385ad.31.1776898527918; Wed, 22
 Apr 2026 15:55:27 -0700 (PDT)
Date: Wed, 22 Apr 2026 15:55:26 -0700
In-Reply-To: <aRtTKpltYqEAbxHw@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <691afc89.a70a0220.3124cb.009a.GAE@google.com> <CAG_fn=VdnBUX8sZ5bczVw7msbkxb1EuPD-CMs0Bzy1Zng8-jbw@mail.gmail.com>
 <aRtTKpltYqEAbxHw@google.com>
Message-ID: <aelR3sNjxg0AqoOO@google.com>
Subject: Re: [syzbot] [kvm?] INFO: task hung in kvm_swap_active_memslots (2)
From: Sean Christopherson <seanjc@google.com>
To: Alexander Potapenko <glider@google.com>
Cc: syzbot <syzbot+5c566b850d6ab6f0427a@syzkaller.appspotmail.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025, Sean Christopherson wrote:
> On Mon, Nov 17, 2025, Alexander Potapenko wrote:
> > On Mon, Nov 17, 2025 at 11:44=E2=80=AFAM syzbot
> > <syzbot+5c566b850d6ab6f0427a@syzkaller.appspotmail.com> wrote:

...

> > > Showing all locks held in the system:
> > > 1 lock held by khungtaskd/31:
> > >  #0: ffffffff8e3c42e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acqui=
re include/linux/rcupdate.h:331 [inline]
> > >  #0: ffffffff8e3c42e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock =
include/linux/rcupdate.h:867 [inline]
> > >  #0: ffffffff8e3c42e0 (rcu_read_lock){....}-{1:3}, at: debug_show_all=
_locks+0x36/0x1c0 kernel/locking/lockdep.c:6775
> > > 2 locks held by getty/8058:
> > >  #0: ffff88803440d0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_re=
f_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
> > >  #1: ffffc9000e0cd2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_t=
ty_read+0x41b/0x14f0 drivers/tty/n_tty.c:2222
> > > 2 locks held by syz.2.1185/11790:
> > >  #0: ffff888032d640a8 (&kvm->slots_lock){+.+.}-{4:4}, at: class_mutex=
_constructor include/linux/mutex.h:228 [inline]
> > >  #0: ffff888032d640a8 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_alloc_a=
pic_access_page+0x27/0x140 arch/x86/kvm/lapic.c:2782
> > >  #1: ffff888032d64138 (&kvm->slots_arch_lock){+.+.}-{4:4}, at: kvm_se=
t_memslot+0x34/0x1380 virt/kvm/kvm_main.c:1915
> >=20
> > It's worth noting that in addition to upstream this bug has been
> > reported by syzkaller on several other kernel branches.
> > In each report, the task was shown to be holding the same pair of
> > locks: &kvm->slots_arch_lock and &kvm->slots_lock.
>=20
> Ya, though that's not terribly interesting because kvm_swap_active_memslo=
ts()
> holds those locks, and the issue is specifically that kvm_swap_active_mem=
slots()
> is waiting on kvm->mn_active_invalidate_count to go to zero.
>=20
> Paolo even called out this possibility in commit 52ac8b358b0c ("KVM: Bloc=
k memslot
> updates across range_start() and range_end()"):
>=20
>  : Losing the rwsem fairness does theoretically allow MMU notifiers to
>  : block install_new_memslots forever.  Note that mm/mmu_notifier.c's own
>  : retry scheme in mmu_interval_read_begin also uses wait/wake_up
>  : and is likewise not fair.
>=20
> In every reproducer, the "VMM" process is either getting thrashed by recl=
aim, or
> the process itself is generating a constant stream of mmu_notifier invali=
dations.
>=20
> I don't see an easy, or even decent, solution for this.

The new reproducer reminded me: I do have _an_ idea for solving this proble=
m, but
it's pretty awful.  Rather than block memslot updates, KVM "just" needs to =
track
which events are relevant.  If we could guarantee at most one VM is affecte=
d by
an invalidation, then we could shove a flag into the event itself, e.g. to =
avoid
any memory allocations.  Ugly, but easy.

Unfortunately, a process that is running multiple VMs will fall apart :-/  =
The
only way I can think of to track events would be to do so in the VM, and th=
at in
turn requires a memory allocation (and it's still ugly as we'd have to trac=
k
kernel pointers, ugh).
