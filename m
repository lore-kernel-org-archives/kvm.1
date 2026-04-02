Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C419D372B21
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 22:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775169624; cv=none; b=Bqm7zd/5dW07FRGluXD9qMNLjbRwIGIrLMLXEN7WC10OCPF05kZ9Q/X4spuFeEp0HCh2dZ7Vc52GDzLs5+QXO9lFirh3RP0ZiM+FGmY7DYP9UE/ES36lSP6ixpfhkP7vwdJKTHW67Ru2tCV6OQVPMhK3tegrFF4Z2keNXCZ8LxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775169624; c=relaxed/simple;
	bh=TTBbmH7yycyXtwPPctRslD8JytpIW3az1YdN78SS3BQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LSm+6b3ByzNJ2RKCdklfAGAmpvNtrWloo014yY0M9IOhgxMSx8rofxY9GIm5h4m/Z/ztjT7mKx9pDd5n7C5glXteCn+lq8NQeFCM9m3bxpjrxNugR+mkPb35G2x4lRtzhb4hlUkj6N/FZpSPd+otQl8v116LnJ20yaLS9nFgmXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QshjwZ26; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QshjwZ26"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82cd9fa609aso802863b3a.3
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 15:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775169623; x=1775774423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p37pwm05j5PB4x1P57X48s+5JksUh7tjxnZdo1TS4sU=;
        b=QshjwZ26Ur9GM7PeVnAcr2fROjZjY6TPkaxspSp8BFcz8xlXFOyxTsJJTj0aJ3cCUo
         Z0OBwimvulBXsZYit2D/6FkY/C6TzcfZfa8osKAl+JIBKY6VNu/nYqNJmtmxxVto72dW
         6Jdh/CvQJ93R8nYN8tHiAWDo/LpB54gUKOms8BsWHN+fCYebqnyAYTiGLY4FEtbljOWo
         +2bPkV5IZcdpPyRcmGzLgH7JTF0Wr0ohHPL9LC8zhe9Ac4NXkHtXFLAVai0XPEaHm895
         OztYUtlRLXtj2QlMZA/v0NV7Zyfx9h1xLgRXdRG5xW0hJaY693mYqNS+SGCgKRMHf7kL
         ak2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775169623; x=1775774423;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p37pwm05j5PB4x1P57X48s+5JksUh7tjxnZdo1TS4sU=;
        b=SGYfKsq2ZFuSALRehquHtGsVvtw2xT+O6dluxyIPLPtXaGPUPo6S2FfIJqeq42M7c/
         25sQFGvxo7S/ahHwGB5SJBHHVtA7SyYPbF4OCrJRvps296UBi35DumGfPigjrHp08jbi
         E5RGByDV+N5P34gw8XzA8JjA5Mt3n0SsPDaYCVNOPzOct1+V1Wp4ZiuVjB2MJnsAqVtN
         aze8l6RYyBcl2q6c6GKwV/NTFQFnmChzwA9ONoj9m/RumGSuU+SYwboZlfhfmagBg6Za
         9utmOa0aHbnMj5kMjDcmDtd36o/PEyCg2IHvZ6LAi5YV8k1+d3l3DsIvprLRPvN9caXO
         kz+A==
X-Forwarded-Encrypted: i=1; AJvYcCVCOfm+CDf8b32dmoo4n2osuIp5iKC4TICmKD0FFYcLA6TR2AYYpkftXn5TBxk6HzVVmbw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy7WUxM+OQpTQaAv3gBH1cuh1HBnThaiCs2fPjS3JeYKVFOtTz
	DN2cyXx0giu91JhtRFwzKc2HzneNAwwNhSSbu7wFJG7SyLlIiexdOKz+mbELl/6+ntWP0gl9XFE
	HQs2/7A==
X-Received: from pfbk3.prod.google.com ([2002:a05:6a00:b003:b0:829:72ec:561c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4fc6:b0:82c:dde3:f2ef
 with SMTP id d2e1a72fcca58-82d0dbc1be2mr697107b3a.50.1775169622945; Thu, 02
 Apr 2026 15:40:22 -0700 (PDT)
Date: Thu, 2 Apr 2026 15:40:21 -0700
In-Reply-To: <20260402063612.VVXEy0qn@linutronix.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ac08V4TaM2yh9SY1@google.com> <20260402013102.21951-1-shaikhkamal2012@gmail.com>
 <20260402063612.VVXEy0qn@linutronix.de>
Message-ID: <ac7wVQDWiXvurkZo@google.com>
Subject: Re: [PATCH v2 1/1] KVM: x86/xen: Use trylock for fast path event
 channel delivery
From: Sean Christopherson <seanjc@google.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "shaikh.kamal" <shaikhkamal2012@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Paul Durrant <paul@xen.org>, David Woodhouse <dwmw@amazon.co.uk>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	pbonzini@redhat.com, skhan@linuxfoundation.org, me@brighamcampbell.com, 
	syzbot+919877893c9d28162dc2@syzkaller.appspotmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 02, 2026, Sebastian Andrzej Siewior wrote:
> On 2026-04-02 07:01:02 [+0530], shaikh.kamal wrote:
> =E2=80=A6
> > The function uses read_lock_irqsave() to access two gpc structures:
> > shinfo_cache and vcpu_info_cache. On PREEMPT_RT, these rwlocks are
> > rt_mutex-based and cannot be acquired from hard IRQ context.
> >=20
> > Use read_trylock() instead for both gpc lock acquisitions. If either
> > lock is contended, return -EWOULDBLOCK to trigger the existing slow
> > path: xen_timer_callback() sets vcpu->arch.xen.timer_pending, kicks
> > the vCPU with KVM_REQ_UNBLOCK, and the event gets injected from
> > process context via kvm_xen_inject_timer_irqs().
> >=20
> > This approach works on all kernels (RT and non-RT) and preserves the
> > "fast path" semantics: acquire the lock only if immediately available,
> > otherwise bail out rather than blocking.
>=20
> No. This split into local_irq_save() + trylock is something you must not
> do. The fact that it does not lead to any warnings does not mean it is
> good.
> One problem is that your trylock will record the current task on the CPU
> as the owner of this lock which can lead to odd lock chains if observed
> by other tasks while trying to PI.

Is that a problem with local_irq_save() specifically, or is it a broader pr=
oblem
with doing read_trylock() inside a raw spinlock?  (Or using read_trylock() =
in
the sched_out path in particular?)

I ask because I _think_ David's suggestion was to drop the irq_save stuff
entirely, because if KVM only ever does trylock, there's no risk of deadloc=
king
due to waiting on the lock in atomic context.

> So no.
>=20
> If this is just to shut up syskaller I would suggest to let xen depend
> on !PREEMPT_RT until someone figures out what to do.

Heh, I was considering proposing exactly that, but it doesn't actually chan=
ge
anything in practice, because no one actually use KVM XEN support with PREE=
MPT_RT.
Making the two mutually exclusive would completely prevent the badness, but=
 it
wouldn't fix the more annoying (for me at least) problem, which is that
check_wait_context() fires with CONFIG_PROVE_LOCKING=3Dy irrespective of PR=
EEMPT_RT.
I.e. making CONFIG_KVM_XEN depend on !PREEMPT_RT won't eliminate what are a=
lready
false positives.

More importantly, there's a desire to use the same KVM construct in other c=
ode
that runs inside the shced_out() path and thus attempts to take a non-raw r=
wlock
inside a raw spinlock[*].  And that code isn't mutually exclusive with PREE=
MPT_RT.
So while I'd be happy to punt on XEN, the underlying problem needs to be so=
lved :-/.

https://lore.kernel.org/all/1d6712ed413ea66ef376d1410811997c3b416e99.camel@=
infradead.org
