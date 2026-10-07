Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A8D4A8A23
	for <kvm@vger.kernel.org>; Wed,  7 Oct 2026 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791384992; cv=none; b=r0747xqSGyEp7y9KN7zlemTDvqGBdZsRGZ4J51eiYxTchzyujI2GngYPp5W223ndrKM3WqH4cUQB4ajyqOtF1cENdarjmRvZiaGAzhwwdVzVsI1GTyOmbaPfQjLF8gAfdEOXwzo0+s8havK40N5jK4lcpYozssyA5O905FwWmL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791384992; c=relaxed/simple;
	bh=R/5bGa4Q2au1wlai+ZPkWkYhooTvjXWlvm8d40gU2is=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ICoFDsU1qxJe7tPcboExSm+wSnPDVE3wltNsKhPP1dkH5M+yXBHer6zCDJGq4ovKwvVK12gNSbOy4YUiOCHb+qt6ufzl1fHKmCAYflHDCAuaPZRrVYoU3R1CoDBUGiYZD7JB73GIytMLFvqhGkdJ7FryQusOgOkIyjJj+ksHYkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T8rIIQBl; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T8rIIQBl"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1a439db36so2841552a12.2
        for <kvm@vger.kernel.org>; Wed, 07 Oct 2026 07:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791384987; x=1791989787; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Y1TUq+k2xxt4zZqWjzxaw9Gnfhq5TJ7RCoLJxzMWcv8=;
        b=T8rIIQBleco5SAkHXZ1+7Q8BMFLxTqwfFIUpLdnz8s1sh6SXChPJCkZXtVOMnFD0pd
         hswmp8bheaINss6jOMcYbvEAI8qtij11YRsshUV+L4WyyA+nPPXBTAA84st4SGa6EF82
         EJmNZHgW7PlnaV+cxE+bUOlq7Wwzq9jA4k9Y2ItNDDvtAlV33hKbmK7cgiLk+i1gIqmQ
         77LEu8+8a9MerNKQQ2Vi1yeqIbRLcjJkuAuBESD552M1x4Zzd2dUUyIrMvAS8lFxEnjc
         cITlVHYO7q5iC2gsAX7HQSreUtGg5xonLZfpXf8WasYu9Ma6P0HCaU1zUWp2Wd6T/xaX
         uPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791384987; x=1791989787;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y1TUq+k2xxt4zZqWjzxaw9Gnfhq5TJ7RCoLJxzMWcv8=;
        b=ygRMEDu4QY7n5q8U5lcki/kOXr7TszPjuEez9PT4F1VGagleZzA4DpQhlEnrqx4GdD
         7aHxMdqhe5sjeKLJQT8V0a+IvfPTclQOVTYchyxs+UQiaadXBZgGTiSAUFXOfE3ZqtLL
         U/pRia4D1tFOpvslkMvLb7HSnFyhyQuMABpjahSOqUwnDtiQXhnnI+H+V0G5xNAWr4tm
         if8RlHopoM8kiKLj9Fnm3Gqeng5HC3eIloasXo26roljQYffXnIiEHoFxFnJVhnZ9Woe
         KbEBiGYSY5du9f2VFsyXWAeXdk8cD5IkCYpADN91F4iIF+GuJLgp/THi2BJP64m1vkEr
         3LYA==
X-Forwarded-Encrypted: i=1; AKwUvByhNJfOjYLKc6ofxFhF8jtYrUBJ2brbZZB+ChXwHEPEVK+48h3G0VyWgtJLLRsK6J+N/as=@vger.kernel.org
X-Gm-Message-State: AFq9FYI2fXTozm5Re/h0bCgUTs4SqiAvdX4eWp3hsLjRO1swLUI/PVZ/
	USBtEv6nQkSAbR2Tf1fB1+OUaoX49/XpaLNojEYWpENvGAfenWZP5Vha88uoHpIiQmNj/IwK/0/
	/sUiCBQ==
X-Received: from pghv18.prod.google.com ([2002:a63:f212:0:b0:ccd:4f9e:b577])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:544b:b0:3a6:f1d2:57f7
 with SMTP id 98e67ed59e1d1-3a8a1bab369mr1977476a91.44.1791384987269; Wed, 07
 Oct 2026 07:56:27 -0700 (PDT)
Date: Wed, 7 Oct 2026 07:56:18 -0700
In-Reply-To: <CABgObfah3a03qwB8vsVNA67ffiHAYRHGjgCxydZzgqpWeXqduA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <asUqYEisPp9MJ8mQ@rika.bernkas.tel> <CABgObfah3a03qwB8vsVNA67ffiHAYRHGjgCxydZzgqpWeXqduA@mail.gmail.com>
Message-ID: <asZdkvDI-zL_yZ-l@google.com>
Subject: Re: [REGRESSION 7.2, BISECTED] KVM: x86: Starting Windows guest
 triggers UBSAN: array-index-out-of-bounds
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: SimonP <simonp.git@mailbox.org>, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 07, 2026, Paolo Bonzini wrote:
> On Tue, Oct 6, 2026 at 7:37=E2=80=AFPM SimonP <simonp.git@mailbox.org> wr=
ote:
> > Hello,
> >
> > See subject. Happens in permission_fault() on line:
> >
> >         fault =3D (mmu->permissions[index] >> pte_access) & 1;
> >
> > Some output from a printk I added, not spammed but keeps happening:
> >
> > kvm: permission_fault(): pfec =3D 70, index =3D 35, not_smap =3D 0
>=20
> Can you confirm you are using nested virtualization, and if so what is
> the L1 hypervisor and L2 guest combination? Also what is the processor
> model?
>=20
> The issue is weird; it is caused by the SS bit which is apparently set
> in the #NPF exitcode; but it shouldn't be unless bit 4 is set in the
> misc_ctl field, and KVM never sets it. Can you check if the attached
> patch fixes it (modulo the fact that it shouldn't happen in the first
> place)?

...

> > kvm: permission_fault(): pfec =3D 70, index =3D 35, not_smap =3D 0
> > kvm: permission_fault(): pfec =3D 70, index =3D 35, not_smap =3D 0
> > kvm: permission_fault(): pfec =3D 70, index =3D 35, not_smap =3D 0
> > kvm: permission_fault(): pfec =3D 68, index =3D 34, not_smap =3D 0
> > kvm: permission_fault(): pfec =3D 68, index =3D 34, not_smap =3D 0

It's not just SS, it's also PK (which shouldn't happen either) and RSVD, wh=
ich
*really* shouldn't happen.  In the page fault path, KVM explicitly clears R=
SVD
from error code that becomes @access and then pfec, so I'm completely baffl=
ed.
Nothing in walk_addr_generic() writes to @access, so the only thing I can t=
hink
of is that we're clobbering the stack?

	r =3D FNAME(walk_addr)(&walker, vcpu, fault->addr,
			     fault->error_code & ~PFERR_RSVD_MASK);
