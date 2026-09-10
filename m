Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9374F36194D
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 19:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067194; cv=pass; b=SPu7vj3fNPuadNpr4tT+67EWkY37C54tQE+rL5Jsn9HOxHwzXSXaBoAC/9twP2TWklLrJkvweIV8tK5JVIonI/8dDLqbLbdYH213xDQHCR+IIJmKBsZS5EQaRBSRhxghK81c/AfJiLOy4f1LUqs3neA4WPHQ+cBp6v6QnkDhLpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067194; c=relaxed/simple;
	bh=p7RzuJYGdHnY3mqs80U7yu9Qn6ww9UEb3p+WQH1n6P0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XDrPBpHQWtZa84LsYFhjsTcuivPKjRQe4daAOsvHyQKZNQxdxQJIvbi+ZORAXsYm7U4wNMBLv03YRbOId8NaqJvqooNsB3SbMerDqZppq1Z0gp8YvauVnciVLvt0Q20Vq6pLhYBWYY3IJxb+3IhWWq4Vws2EaFVWFFX61nMLgD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OBzoWmZf; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OBzoWmZf"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8588583a7c3so187417b3.2
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 12:06:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789067192; cv=none;
        d=google.com; s=arc-20260327;
        b=QMWWXx6k4fK3p0hVwRv8Rj7x8axj0wz6T0hoSj1VBqCdaeZXZONiNoH9D6C9t6H5kM
         0uZFS7jrTLsdJkxh933qN1NONr8bFFzXiYj8T9n+uAiK8l8gedM8c8r5xfRdvcW/G5oO
         gpu6xY98C8flMC3Mpu64UlNt2GScvL1XTk+MSVYxbSrdYsBtqP5102j67x095nX5AWky
         PigYyJ1j8PRR7Q3jqnbH/q8ZyG8cFJUQtCgD2mUN7mIqhSjtRPemABwXSAcCbL48nwTz
         gq2KZE9P1AeVTTiiSu88meyJqK+5j37VXMRlcWD3KgdAqVG+t3IJBOInZ0nhUfAUfynM
         Iepg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hhbPkWTyvpq7C4VmKx5074Xp8YIC7XsOu3FWGtgnxq8=;
        fh=WHKZ04wRKKa/0KCr9SeGoqL4KsPCb8L3Ug6bVhf2NbM=;
        b=avFWoRms3V4lURlp1HKSXN8UtuxDO73IcuLMr9PGK+Dq8BGC0bbL1HD1z6QRuiQYGN
         l+V6EOAd2VxOG0+26IS5TwSVY4JU3pw8+ZzokMeLCTe+wOvZW3yL4Fpm/y9LiBIo0QIQ
         KmY5MNgI6yfS+reo8jkrtg4SmC1h43fx8FJ3x2R71+PWruoqOJMDaPQOXlMABvAIYcb7
         Db3Vs+pKTb3YkK2yoPg+AcGLoKRn6NI7VHF4DQMcGOngHryffc7jIkCe2zAUTWs2Vmxt
         atXEuDcPq8N/hDkuQ56hGD5EiGK8s6uQ2wT3kuZMt9Btk/9Z64JkLHkl59xf7NORcjKs
         3Afw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789067192; x=1789671992; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hhbPkWTyvpq7C4VmKx5074Xp8YIC7XsOu3FWGtgnxq8=;
        b=OBzoWmZfG2xnKQ21vOgPbtSoKlvFZ8OwbP2af6uEP2pvsss+12ziYFwAyd61V7mMYi
         QpWqC6GP5qIjAXeO7/IBaVMfrITbNwmYsikESWH3Y+G/Z+dGmUQ9zrSSNLpt/H0KVTcD
         Wv/VASUIeXTq9qBta10tUzN/pYvAH1cqERw1ex0ZjNP3UltNKm6l589ZVUfbWOy4qNsI
         jIIs5l3hjUAxKRgowy/lYG485+B4s4XcfkL019BXl/tmix7EtJgB7oeKxZ4/WjYV2k8Q
         DJlXqYwgxfL92UagMNjZ48RFxo2YRomv+s9i6bZEb49Ad4CkcEgMkW+Inad2ftFsXrlH
         kW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789067192; x=1789671992;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hhbPkWTyvpq7C4VmKx5074Xp8YIC7XsOu3FWGtgnxq8=;
        b=UPGPkqhtZKKJ7CmA9r8thr18pTe6AhAzYmgtTo8Zf2HEiLmSu6waBHXqyfJUl9p/fg
         LehW7Pq/s/T+32HIooqKA6TcnpCsMZCut6yFxLDCfTXZy/aF1TNgz1cSN0pbuYcc2QtS
         EGpewOZdkOU4/j8bhPQRnSDoH5GmXZMCbYR3yyUwS012jaDFxvZUPNnPNOfp3Of64pZm
         HpamkJYRaKUa1parWaxCtpEj1OoNcwwDU1kUGv+Fdq2UlpP+vV18lf2AUH7Vt4h1pRox
         yy52PpW657rQ0ig3Md4vz4NFSlCk/AhNWAUYjFd79aajNSv5RzIa5oW2R24xkwUWPNAB
         KfQg==
X-Forwarded-Encrypted: i=1; AKwUvBz20qtKc2mq04FJf36gsqopUeqHVrdjHx1bWJTd3ZL+ktYepsUa9lMJECF8G6Y751Ce38g=@vger.kernel.org
X-Gm-Message-State: AFuF++k59DwfPt4iCSqE92y8r48iTS/zQ8TlCTEDua2AUpNM2jN7hPri
	GFOM4dJ/CVnnJ48GAflYFRSBz/rjHwZUoLNVcjvEBnsGgfrchzjNv91isvUTNGoYMVfg/RjTCx+
	VjxF99yQgyqOAVhxv438KakIyuBi/gJUhQwTiRail
X-Gm-Gg: AYBFou2Zru1F1s1VDZW8n8Hv4ZsIkjeD8ZbttHUsJVIet/Tw33WY9GEe66zFMp0I9nf
	CLqs2i1nFkK9jEPc+DahFpCbHFGZjMoSvZ3WRjpKBu9in5uRu15e1ALSHmtIYrifKB5Traj20t0
	P4VaIVzHzi5BjSxyVdwbFJQqaOUP9lGMzodsbegIxD+Jp7SQB32cSJDsDI6uHdO2JZ0qtFAJDCb
	feRj4UoAwK+KOJMcZI5tD52xB6vnoOOACfl4baJNlYtexxQIaehrKxWXxu2MJlXSDlFDKS4caVm
	/qOEusSDMFuMNCKMtiyZHq2RZROXr5I8fstKVCPzXExNnOkZ548OKz5vfS442+eqw8uOulOk/9L
	q611YrWXZOA==
X-Received: by 2002:a05:690c:3347:b0:874:894:9a52 with SMTP id
 00721157ae682-884b5d8d588mr3519787b3.40.1789067191005; Thu, 10 Sep 2026
 12:06:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910162343.4092060-1-elver@google.com> <20260910162343.4092060-3-elver@google.com>
 <aqLbHvD5lqQP8PRd@google.com> <CANpmjNOZPFQ9FcaA6+GH9PZ8DRyEMYW3+FKBO9B3d2CY+2C-5w@mail.gmail.com>
 <aqLuZ9gGzK07R_Ei@google.com>
In-Reply-To: <aqLuZ9gGzK07R_Ei@google.com>
From: Marco Elver <elver@google.com>
Date: Thu, 10 Sep 2026 21:05:52 +0200
X-Gm-Features: AcwNN1V0oYbeLDh86sT0uPw3XpZ9Y8gnfB3S8ZdXuCAMO68mt6oSE3z_9GgR0M4
Message-ID: <CANpmjNMn-i3ZgQgRC8JhhDt5-RFTXCsBrf47MzfXjKG8H1c2sA@mail.gmail.com>
Subject: Re: [PATCH RFC 02/10] KVM: Allow reading memslots while holding slots_arch_lock
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Sept 2026 at 19:52, Sean Christopherson <seanjc@google.com> wrote:
> On Thu, Sep 10, 2026, Marco Elver wrote:
> > On Thu, 10 Sept 2026 at 18:30, Sean Christopherson <seanjc@google.com> wrote:
> > >
> > > On Thu, Sep 10, 2026, Marco Elver wrote:
> > > > kvm_swap_active_memslots() updates kvm->memslots[as_id] while holding both
> > > > kvm->slots_lock and kvm->slots_arch_lock. Holding either lock guarantees
> > > > that memslots cannot be concurrently modified.
> > >
> > > Sure, but that's irrelevant.  The goal of the srcu_dereference_check() is to
> > > ensure that readers see a stable view of the VM's overall memory, not simply that
> > > kvm->memslots can't be written.
> >
> > Functionally, this is irrelevant for readers. But under lockdep it
> > isn't for writers: srcu_dereference_check() (with lockdep) asserts
> > that the srcu reader-lock is held, or the condition 'c' holds, which
> > here is holding any of the writer locks.
>
> No, the rules for writing kvm->memslots is that *both* are held.

Right. But the condition 'c' is only the srcu-less fallback for reads,
which is "any".

> > > > Allow reading memslots in __kvm_memslots() when kvm->slots_arch_lock is
> > > > held.
> > >
> > > Why?
> >
> > Holding any of the writer locks guarantees no concurrent modification;
> > therefore, if any writer lock is held, it's not required that the srcu
> > reader-lock is held. There are few places where only either slots_lock
> > or slots_arch_lock is held, which is sufficient for reading.
>
> Yes, but with caveats.  And more importantly, pure readers really shouldn't be
> taking slots_arch_lock, because either it's overkill and will generate unnecessary
> lock content, or the alleged reader is doing more than just reading.

Pure readers never should, and not what this patch suggested. But
writers (or those about to become writers if they only hold one lock)
can read w/o the srcu reader-lock held.

> Holding just slots_arch_lock *could* be fine, depending on the usage, but those
> details matter, which is why I asked "why".  I want to know exactly why we should
> relax the locking rules.
>
> Ah, poking around the code, I suspect that the motivation is
> kvm_enable_external_write_tracking()?  Which grabs __kvm_memslots() but only
> holds slots_arch_lock, i.e. would get a lockdep splat if someone with KVMGT ran
> with lockdep enabled.

Right.

> That thing isn't a pure reader.  It only reads the actual kvm->memslots pointer,
> but it writes to each of the slots metadata.
>
> So, allowing __kvm_memslots() to be called with just slot_arch_lock is ok in
> this situation, and if my guess is right, necessary to fix a false positive.  But
> I'm on the fence as to whether or not we generally want to allow that, versus
> taking kvm->srcu in kvm_enable_external_write_tracking() even though strictly
> speaking it's unnecessary.

Clarification here would be good. In building up the locking
annotations, this was one inconsistency I found vs. what
srcu_dereference_check() said, so the conclusion was that the fallback
condition 'c' was outdated (or there was a bug).
