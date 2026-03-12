Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14083750AE
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 01:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773279539; cv=none; b=trOwVEbLkTXwcXoKXpQfDwWqv/oxHfNsXqw6ceNn348/4RPyswnbvAiCszIKNjliE1a7o2TBEWnsg0yi9Digj8oKeBCEkGyRP9PreaPWJiTbHjep3XiM03PYcW5olGEQT6lDd9t/QpQdGRWahyRRSlKzybJJLK0bW4zAD8ZzF3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773279539; c=relaxed/simple;
	bh=1GQuDVWradza8xPN2LaZWr05cQLHUpagNZLeSdNcgsY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LgoCIKvxUV1dbWepPjVtzENEDmGXp5Lzn3tk7qMrF+X68FVWzaAYK1w2liKVqxvbr0OahZLPrl515sKflTmn/+L5vMvcRh3SfCqtM0o/bObn3HuWis91IDzJrb8N1qa9ap4FDwp9HN0cp/zcEKHN19+zuojpHyq48UH8SEdTQeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PGKwcObg; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PGKwcObg"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae6961bff0so46173365ad.2
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 18:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773279537; x=1773884337; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LeCwL73pHplPeG52pDXKlNx5RXbJpjPHC1r1T5xCdn8=;
        b=PGKwcObgas/XnG+vlKWikvaeOZFLtRO1sPfbLaE+WupzmW0PAR2UvOr2+MpVKXpeiX
         fUQ3tGGcXQbmHEWflEuV+CcgOJkZbYyVKWn1oLlUUt9iJGyzL+UKbwTdf4KUJsS7se9Y
         3OTCF5HZMcL2xI6XrR55OlzM+H8+qc5o6jB+75gILzdZLxWWWh+BT8DugNpZVZulh+p0
         8Go8W6Vg3xYxayRv7WDA9TTw06HTBFGnu+XXviypvDy1tevuQ7RjfqyQR2TUTVeu6Sq8
         0x3cD7ETkoxTRjt5aNr9WkmgY1uy/jRmYUENKDt4GW6wqx9upJ4rYCxK66FCnCk2yXsI
         fdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773279537; x=1773884337;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LeCwL73pHplPeG52pDXKlNx5RXbJpjPHC1r1T5xCdn8=;
        b=qQHqsvCJxO574vhh4xupamzKEtW6515mXRlOz5EGfmOckWrQ7+qF6o+/QkeLjp/iUj
         pn+peF4UPhOaOroLP0YnR7TxQmGbdSb6qFboKoEhbSNh5gjoda+FOPWrS23RkfQJ/7MY
         jiQcIy7HLkyAz5/nKCAJgZYtAB8P2S7H0mkrvIcE1HBxg1SYTdHJhJ8+cn6GVc477sMD
         4ZJw/c2Gzfzc36ZDIBCx43GMwBZ8D6/WOExrYn63dXRsHrgNWGCROR7B7H2e1Ct1Zsh0
         WgUzu8yvMY/uBVq6UECJhON+DQhp5uaH5Ke6YqFrTFrXKXDUBG7VxzkI13K7yIXXUCbk
         vCCA==
X-Forwarded-Encrypted: i=1; AJvYcCXDGVqgW7LGStJEVUTDn7XLrmsq/hokrOmPSTtyoqHxBJkeGVrZS0VUqPyDkXqzX6CHOhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvtK0d6RmdArESAi2s6Y1Gn/1vAvNdw9TEiXx4ej/8fsf45uoM
	Hl+BBx6AeuY0C4F3zK1AiEWBRz/tFEd2d5/GJFaX9T30HDfuvvt1rjPvoPhcFlM7DpSoFMQetcP
	QVin0Yw==
X-Received: from plmj1.prod.google.com ([2002:a17:903:2fc1:b0:2ae:b91e:f44d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:dac2:b0:2a0:e5cd:80a1
 with SMTP id d9443c01a7336-2aeae8ab718mr48565785ad.41.1773279536800; Wed, 11
 Mar 2026 18:38:56 -0700 (PDT)
Date: Wed, 11 Mar 2026 18:38:55 -0700
In-Reply-To: <CAO9r8zN=yryp1F8tJDWKasAe8KO30tWH-A98Uy=EhFn8Lg6WcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CALMp9eScswzFak+PMOcaDXM-W+cXtkG7fQ=jadq__+5JeqYcTQ@mail.gmail.com>
 <CAO9r8zOK5+xmkf3FsWRz2wHcUCN30GJ9kfZx-K7DAa1HNGhRVA@mail.gmail.com>
 <aatyIPwz9ePKdzJx@google.com> <CAO9r8zMxk9yUiYoosnDygr_oeeRYHz3f7hWLm23c5Q0m-DXnWA@mail.gmail.com>
 <CAO9r8zNHYswypRmHVT5Qn5hFU9-HU1t=Gs3qAh05xRNn5krPXQ@mail.gmail.com>
 <abHTE5uyEZ4cW-fc@google.com> <CAO9r8zNxtSbHjp6EkQ+QbKavL1hn1WQXgQQ+d2=6AZkW9-mVXA@mail.gmail.com>
 <abH0RdnM29Xyh_4G@google.com> <CAO9r8zOgMWCAHOHGeK-YYbEQ52s-J_OLsc5-KXVb9VNrkzDeBw@mail.gmail.com>
 <CAO9r8zN=yryp1F8tJDWKasAe8KO30tWH-A98Uy=EhFn8Lg6WcQ@mail.gmail.com>
Message-ID: <abIZL9ixxKvSjdg8@google.com>
Subject: Re: [PATCH v2 1/6] KVM: SVM: Use maxphyaddr in emulator RAX check for VMRUN/VMLOAD/VMSAVE
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Mar 11, 2026, Yosry Ahmed wrote:
> > > Hold up, we're getting ahead of ourselves.
> > >
> > > The only legitimate reason the emulator is at all aware of VMSAVE, VMLOAD, and
> > > VMRUN is to deal with #GP due to the RAX check, because hardware checks the GPA
> > > against the host's physical address space.  See commit 82a11e9c6fa2 ("KVM: SVM:
> > > Add emulation support for #GP triggered by SVM instructions").
> > >
> > > The emulator "support" was originally added by commit 01de8b09e606 ("KVM: SVM:
> > > Add intercept checks for SVM instructions"), but AFAICT, for all intents and
> > > purposes that was dead code when it was added, because the emulator doesn't
> > > actually _emulate_ the instructions.  I assume if they aren't intercepted, and
> > > KVM is full on emulating instead of just decoding, they end up at EMULATION_FAILED
> > > and get a #UD or something.
> > >
> > > Outside of forced emulation or code stream rewriting, KVM should _never_ fully
> > > emulate any of the SVM instructions except VMMCALL (and that is a super special
> > > case).  KVM does need to _decode_ the instruction, and it needs to get the
> > > pre-intercept exception checks correct so that KVM correctly injects e.g. #GP
> > > instead of synthesizing a #VMEXIT for the CPL check, but KVM doesn't need to do
> > > *all* of the checks.
> > >
> > > Note, for L2, the SVME check is meaningless, as EFER.SVME has to be set for L2
> > > to be active, i.e. it's L1's responsibility to handle that check.
> > >
> > > Back to the physical address thing, KVM _already_ handles that check in the #GP
> > > path,
> >
> > I guess if KVM is not intercepting #GP, then the hardware injects the
> > #GP and the emulator still doesn't have to worry about it -- because
> > we don't support the case where RAX can be legal from the host's
> > perspective but not the guest's. Makes sense.
> >
> > > it's just wrong too:
> > >
> > >                 /* All SVM instructions expect page aligned RAX */
> > >                 if (svm->vmcb->save.rax & ~PAGE_MASK)
> > >                         goto reinject;
> > >
> > > So I think what we want is to
> > >
> > >   (a) fix the RAX check in gp_interception()
> > >   (b) drop the RAX check in the emulator
> > >   (c) add a CPL check in the emulator (because the intercepted #GP could have
> > >       been due to L2 executing at CPL>0, not due to a bad-but-good RAX).
> 
> Actually, I don't think (c) is needed. In the path where KVM
> intercepts #GP, it doesn't go through the emulation path which ends up
> calling check_svme(), it only uses the emulator to decode the
> instruction.

Oh, dagnabbit, that's stupidly obvious in hindsight.

> AFAICT, we can end up in the emulator only when the CPU does not
> produce a #GP, e.g. when we get a #NPF on the address in RAX. In this
> case, the CPU will have already checked the CPL for us, and the
> validity of the address. The emulator checking EFER.SVME check is
> probably also useless, because with Kevin's patches we should always
> be intercepting VMLOAD/VMSAVE when EFER.SVME is disabled by the guest
> and checking EFER.SVME there anyway.
> 
> Anyway, I want to touch the emulator as little as possible tbh, so I
> will still do (b) because it unblocks this series (removes the wrong
> GPA check that injects #GP), but will defer any further cleanups.

Yeah, works for me.
