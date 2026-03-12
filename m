Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94BD347BD7
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 01:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773278854; cv=none; b=GIXlIltnanzirBdgxK2quYhb4H4lTG28VvSpkKn9lebqUdZBmnwe5ke4cXACyJ5JDyymoh7+RKZ8L/9rq+xHRFT+p4NGphjcFvp8b4GefUglIubLClXG6u4OHtdzLutNCElCrGnbwm+P2Sw8bzymg38VFQ/0+EKMZbYXaa9jViM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773278854; c=relaxed/simple;
	bh=Xgw41s1SIiF3bb8KykFH/x/9dNInqT1j5K/FxSyxsVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fx9X6SCjxp0kAjDRzSrir2PD8Z6z+0bNowPqPHUlV7OQBbuA66yoObvEUa81PzOhuRmEFlidXD1KLuzoqteK1ypNoA4GJbO1QMqV81PHZ34ytZyDHURyx7IfcV6qmzAYnn8lrT7oCjuXvJsOi/RNeWjEoYdS/MhhYylkHscAItQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWSJ1VS1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWSJ1VS1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9FAC19421
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 01:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773278854;
	bh=Xgw41s1SIiF3bb8KykFH/x/9dNInqT1j5K/FxSyxsVo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NWSJ1VS1idXa6DEcs93gwDIfyu7R7tuPmo4FxWqHDzVJrIlYkFUxq3+8pMgh6EZqb
	 o6+sdbKifZDTHaQJJq6Kwnl8AO3XaKj712h6Uaysckny/7zO4Upzdzk+A+YRvoCmz8
	 wvWQUzlLC3J9HTzN4owgtMrBpSr14NtlPc1YJFYNFspEeQtWtfEJ+TOwDyTawKlcCl
	 fVE/DF8eqPvWglvw/G2B7vEMMTmwpcg6sQqsSQdkCMoTyznFdK9rLLGLNsfW1pzhKH
	 xZ2cYO8gTJta1nHspoIie8iMTlam/jVgAF8hv2cZbLJRQJYk1HufI9v+7hjFLwVilp
	 q9G7BjsbJXwCg==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b9358dd7f79so67078266b.1
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 18:27:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUB7OXGuEViwZaI73ZocshsbM84nA5jQSKpRlxzunEmymTuEW1da2Efx1ln/hzlrf3de/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE+EtIdD4K+3xUOEH48F2nln/fWCA61q8PPxoFI+NQZJ7V0nZz
	t/e3VjNdSmY/23Dd/ZP4wz4kGd9VsyOgnXBD7TM0bGrL4zXr1jbkzOJmWwaxeWxxiQEL+oZU969
	FzeXmKYI+kAZ/P6eq5z2E7F2jHvYpQZg=
X-Received: by 2002:a17:907:3e98:b0:b88:5158:d106 with SMTP id
 a640c23a62f3a-b972e5a02f5mr273308266b.52.1773278853411; Wed, 11 Mar 2026
 18:27:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306210900.1933788-2-yosry@kernel.org> <CALMp9eRWwPwUSyQmizy8i2tF1CVO4iLY6x0vX1OoPUiRdCm4NQ@mail.gmail.com>
 <CAO9r8zOhaDeYWq_6TNdPGyEE323o_8xsWTozGdro9Oni8310kA@mail.gmail.com>
 <CALMp9eScswzFak+PMOcaDXM-W+cXtkG7fQ=jadq__+5JeqYcTQ@mail.gmail.com>
 <CAO9r8zOK5+xmkf3FsWRz2wHcUCN30GJ9kfZx-K7DAa1HNGhRVA@mail.gmail.com>
 <aatyIPwz9ePKdzJx@google.com> <CAO9r8zMxk9yUiYoosnDygr_oeeRYHz3f7hWLm23c5Q0m-DXnWA@mail.gmail.com>
 <CAO9r8zNHYswypRmHVT5Qn5hFU9-HU1t=Gs3qAh05xRNn5krPXQ@mail.gmail.com>
 <abHTE5uyEZ4cW-fc@google.com> <CAO9r8zNxtSbHjp6EkQ+QbKavL1hn1WQXgQQ+d2=6AZkW9-mVXA@mail.gmail.com>
 <abH0RdnM29Xyh_4G@google.com> <CAO9r8zOgMWCAHOHGeK-YYbEQ52s-J_OLsc5-KXVb9VNrkzDeBw@mail.gmail.com>
In-Reply-To: <CAO9r8zOgMWCAHOHGeK-YYbEQ52s-J_OLsc5-KXVb9VNrkzDeBw@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 11 Mar 2026 18:27:21 -0700
X-Gmail-Original-Message-ID: <CAO9r8zN=yryp1F8tJDWKasAe8KO30tWH-A98Uy=EhFn8Lg6WcQ@mail.gmail.com>
X-Gm-Features: AaiRm509wmM8BDEs3tNNOJ7DOWAt7hiSBoKezL4D8Y4jt8cJqI_p54z7YBSfxZ8
Message-ID: <CAO9r8zN=yryp1F8tJDWKasAe8KO30tWH-A98Uy=EhFn8Lg6WcQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] KVM: SVM: Use maxphyaddr in emulator RAX check for VMRUN/VMLOAD/VMSAVE
To: Sean Christopherson <seanjc@google.com>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > Hold up, we're getting ahead of ourselves.
> >
> > The only legitimate reason the emulator is at all aware of VMSAVE, VMLOAD, and
> > VMRUN is to deal with #GP due to the RAX check, because hardware checks the GPA
> > against the host's physical address space.  See commit 82a11e9c6fa2 ("KVM: SVM:
> > Add emulation support for #GP triggered by SVM instructions").
> >
> > The emulator "support" was originally added by commit 01de8b09e606 ("KVM: SVM:
> > Add intercept checks for SVM instructions"), but AFAICT, for all intents and
> > purposes that was dead code when it was added, because the emulator doesn't
> > actually _emulate_ the instructions.  I assume if they aren't intercepted, and
> > KVM is full on emulating instead of just decoding, they end up at EMULATION_FAILED
> > and get a #UD or something.
> >
> > Outside of forced emulation or code stream rewriting, KVM should _never_ fully
> > emulate any of the SVM instructions except VMMCALL (and that is a super special
> > case).  KVM does need to _decode_ the instruction, and it needs to get the
> > pre-intercept exception checks correct so that KVM correctly injects e.g. #GP
> > instead of synthesizing a #VMEXIT for the CPL check, but KVM doesn't need to do
> > *all* of the checks.
> >
> > Note, for L2, the SVME check is meaningless, as EFER.SVME has to be set for L2
> > to be active, i.e. it's L1's responsibility to handle that check.
> >
> > Back to the physical address thing, KVM _already_ handles that check in the #GP
> > path,
>
> I guess if KVM is not intercepting #GP, then the hardware injects the
> #GP and the emulator still doesn't have to worry about it -- because
> we don't support the case where RAX can be legal from the host's
> perspective but not the guest's. Makes sense.
>
> > it's just wrong too:
> >
> >                 /* All SVM instructions expect page aligned RAX */
> >                 if (svm->vmcb->save.rax & ~PAGE_MASK)
> >                         goto reinject;
> >
> > So I think what we want is to
> >
> >   (a) fix the RAX check in gp_interception()
> >   (b) drop the RAX check in the emulator
> >   (c) add a CPL check in the emulator (because the intercepted #GP could have
> >       been due to L2 executing at CPL>0, not due to a bad-but-good RAX).

Actually, I don't think (c) is needed. In the path where KVM
intercepts #GP, it doesn't go through the emulation path which ends up
calling check_svme(), it only uses the emulator to decode the
instruction.

AFAICT, we can end up in the emulator only when the CPU does not
produce a #GP, e.g. when we get a #NPF on the address in RAX. In this
case, the CPU will have already checked the CPL for us, and the
validity of the address. The emulator checking EFER.SVME check is
probably also useless, because with Kevin's patches we should always
be intercepting VMLOAD/VMSAVE when EFER.SVME is disabled by the guest
and checking EFER.SVME there anyway.

Anyway, I want to touch the emulator as little as possible tbh, so I
will still do (b) because it unblocks this series (removes the wrong
GPA check that injects #GP), but will defer any further cleanups.
