Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5787547054
	for <kvm@vger.kernel.org>; Wed,  7 Oct 2026 16:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791389318; cv=none; b=HSlMmqKjpi6zMX2kcLS33IYRQ8EmrbGXx64a+CHHjDePszvvM45mNKwWBh31yMuqpSDFQtxRLj3Inm/qEvP3VjaiJi9xC+X5WxPChxLf4Cm8mKhtdr45Mvfm3Z/AbGLG2NH7A5B5XPdmbbCBO98xCKqTKTdhu9/YxMAhkCkLjdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791389318; c=relaxed/simple;
	bh=MN/w8dk1yNg66LKD0+UPeoTmGsMcRh7Lz3HnBreptkQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g48k4rAEdUWlaIG276oe1r4DNPbkCNkyT/Y9iItsPb03ncdvHi4UTkzfwISwqI0ivLpi0hGUWnLqBpi6Ykap0e2vu000jF61RgruFXPqQgat5HDUOLld8ikr8EC9v1FzlRDSWJk0gg0kWa3hRkrbivefkZFQ+rSgrhBcqfpqfwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hPrDP5GV; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hPrDP5GV"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-88679c4f94cso3144688b3a.0
        for <kvm@vger.kernel.org>; Wed, 07 Oct 2026 09:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791389316; x=1791994116; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uhfTQykgFh+0P3fifwr5LxNhWZvxNmUt6haWMNg4AWA=;
        b=hPrDP5GVbrw2Nh5G/gZrEhXjtpnfFRHvZJbdenqaqCCWiYwm9nTWtQY0CmvsGNqkMT
         yRrPjN41fqha/FS/OSmTLdbRGjvUmnwo3oD214Zn3KUrCcweQpXnvwPTnEDA6RhYSgpI
         2VZwBI0eVzUE/0afaJQOgjj9S9kNJkAFv/34C6wGPtapKxNgUqcfs+zBWATT/wleHHit
         hpeVA/rvf1+8JXsod8kgmQwhFVizMe+M12OeWXGwkFwtTPbMo+4ltk64NeOHcCNjExCN
         +TMztnz3Yb293hPC4mJqV5iV4cmN7ulYsF6+5nf/JhMjgP2P5AEjEaDKLhafk9u+qYMu
         550w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791389316; x=1791994116;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uhfTQykgFh+0P3fifwr5LxNhWZvxNmUt6haWMNg4AWA=;
        b=yJ2/3W4IL9UDxSFRHcg/0F6fo64RJhLWn2y31TmxXD+TWVV2GgEoSQQxrRQ7tg9g4Z
         51wm0rI8+x+JOTvoOM4yg6PfEiJEOAawlNvdmp2euR5kne/23bLa6YzflmskOwGqJyrk
         PvkuzwnB+/dj8DC7aX3otU5jafTLG9EERGj7qg0qUlnjC+o2bc9Z4FPB7pSlSFz6Sjy4
         MnnlPnyNs8ArbZm1EMnYLle5Lqsd6JRwXi9s5JXiEWdM6WtI1iSLS6QuJUkfDlG00iUg
         CzinMxntyRGtkmt3najNKrO5zi6Rns2PAHnC2lGSjxZgo+dCzsRXDvs+qbYN5vYZoLO5
         dGgQ==
X-Forwarded-Encrypted: i=1; AKwUvBz+crZIv7DmmpMhcE4ILmvaOvrU9pa3yemxjLEbKBljazVdcs8yyWoo0lfR0Y1Fw3u744w=@vger.kernel.org
X-Gm-Message-State: AFuF++ncILYUUGZ2HeWY/bbgD6tO3eo6XukaOGB7j3R3m6kC00njRQyj
	1dPwm4YOf/6apIoTlS7uHWGtBVXmQ+qf843gb7D2mQ7cbhYIcfGCm8ppWdoXrxlaB0EjTBIyELL
	KN8bCPw==
X-Received: from pfbbw6.prod.google.com ([2002:a05:6a00:4086:b0:891:74f:5b6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:408f:b0:881:c881:96e8
 with SMTP id d2e1a72fcca58-891b50ce1d2mr2650734b3a.23.1791389316010; Wed, 07
 Oct 2026 09:08:36 -0700 (PDT)
Date: Wed, 7 Oct 2026 09:08:27 -0700
In-Reply-To: <asZdkvDI-zL_yZ-l@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <asUqYEisPp9MJ8mQ@rika.bernkas.tel> <CABgObfah3a03qwB8vsVNA67ffiHAYRHGjgCxydZzgqpWeXqduA@mail.gmail.com>
 <asZdkvDI-zL_yZ-l@google.com>
Message-ID: <asZue2-WuiZZuNZR@google.com>
Subject: Re: [REGRESSION 7.2, BISECTED] KVM: x86: Starting Windows guest
 triggers UBSAN: array-index-out-of-bounds
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: SimonP <simonp.git@mailbox.org>, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 07, 2026, Sean Christopherson wrote:
> On Wed, Oct 07, 2026, Paolo Bonzini wrote:
> > On Tue, Oct 6, 2026 at 7:37=E2=80=AFPM SimonP <simonp.git@mailbox.org> =
wrote:
> > > Hello,
> > >
> > > See subject. Happens in permission_fault() on line:
> > >
> > >         fault =3D (mmu->permissions[index] >> pte_access) & 1;
> > >
> > > Some output from a printk I added, not spammed but keeps happening:
> > >
> > > kvm: permission_fault(): pfec =3D 70, index =3D 35, not_smap =3D 0
> >=20
> > Can you confirm you are using nested virtualization, and if so what is
> > the L1 hypervisor and L2 guest combination? Also what is the processor
> > model?
> >=20
> > The issue is weird; it is caused by the SS bit which is apparently set
> > in the #NPF exitcode; but it shouldn't be unless bit 4 is set in the
> > misc_ctl field, and KVM never sets it. Can you check if the attached
> > patch fixes it (modulo the fact that it shouldn't happen in the first
> > place)?
>=20
> ...
>=20
> > > kvm: permission_fault(): pfec =3D 70, index =3D 35, not_smap =3D 0
> > > kvm: permission_fault(): pfec =3D 70, index =3D 35, not_smap =3D 0
> > > kvm: permission_fault(): pfec =3D 70, index =3D 35, not_smap =3D 0
> > > kvm: permission_fault(): pfec =3D 68, index =3D 34, not_smap =3D 0
> > > kvm: permission_fault(): pfec =3D 68, index =3D 34, not_smap =3D 0
>=20
> It's not just SS, it's also PK (which shouldn't happen either) and RSVD, =
which
> *really* shouldn't happen.  In the page fault path, KVM explicitly clears=
 RSVD
> from error code that becomes @access and then pfec, so I'm completely baf=
fled.
> Nothing in walk_addr_generic() writes to @access, so the only thing I can=
 think
> of is that we're clobbering the stack?
>=20
> 	r =3D FNAME(walk_addr)(&walker, vcpu, fault->addr,
> 			     fault->error_code & ~PFERR_RSVD_MASK);

Paolo pointed out offlist that the printks are in decimal, not hex.  *sigh*

So yeah, 70 =3D 0x46 =3D SS | USER | WRITE.  Which is way more sane than SS=
 | PK | RSVD. :-D

While I'm here, the theory is that hardware is setting the SS bit because t=
he
faulting access really was a userspace shadow stack access.  Which was obvi=
ously
unexpected by us, but might be working as intended?
