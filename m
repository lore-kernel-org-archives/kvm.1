Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0479C377004
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 23:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773271384; cv=none; b=tKLc8VG/Ft+uBtnp5xYNXr45wRkMibPQcuiHHRQeuN+/AKINEOdGM+TK7g+8am8UQmlNy6aCokivkuLDVDTBw7wYwocLTC8/BAgY3uV2q/67Eo1YrvIt6LhK62clhdCfu/UajA+oFmhg1hQb8ArrndEWiUy0Q5NdzMBa0k4Uh4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773271384; c=relaxed/simple;
	bh=KtTD/BBX1Iq7gQXIC6nvkUsAjDJ7TZBskqfTrlq5/uA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bjcUlo5MgsBWLtKN8AdQOsMlgO4Z8a2DRuLnpTDwhtH79nyu5pb40Ypw360vgY2+s2+1VQEF+AicN0C0pCT61EhoAJEAgbiovE1/M1FZ+OCOxwPAOtF3sDEHOSBXtJZobr9zK9gVqZMSOnwPKj+EUDM6L6vza7W/i4lAEXQ0tPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKv0KXb2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKv0KXb2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990E1C116C6
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 23:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773271383;
	bh=KtTD/BBX1Iq7gQXIC6nvkUsAjDJ7TZBskqfTrlq5/uA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DKv0KXb2TBfsPWnay/oxSoip7r1ha2KP+cfqY/YaED4j7fvmCLi0wqJI3pn669zss
	 +VznhJQjMH+AmXosx5tUjtIBY8cKw1zr+tkznd97nDTrwp/i2QhxVYl/6OKzFyb0I6
	 x2hYtQVHSKeTiG6q6pUZtSe3PubLvRq9qknjYnn+YKFFJumNMcmueFi00P6blcDQoG
	 2ZJ9Bvq/t489r98Q/rMmoADpprUyfyNreihJUS4Jswl/95feLJg2c4oBUevoN24T6V
	 pq/JwaEZJj5WhOY++EiDZdZgQ81NVf3a6/NiZkEEaO4WsEPGB4rVmtzNHfJiQOLelw
	 HliojjGuDlR7A==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b941bb3e23cso60009966b.0
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 16:23:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU72p5qoN3tPasJKCKv+Gd3feOjmDmRL/mRBcNBMxCJMyrUbFz2PT7C4UkOEXW1xKPqkm0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy8xMh1WOTCDRg+TBBz9zOSBsjQhMZY1urDRmZTqotTg2xLvTp
	mY9LgJiNYww+cwlfpgz9uP38lQgqoJO55jWvng8iROcJas0+aWKGDQ8ZNb32uLamMrLLmRMrX7n
	3kVT/uSuIB6OOBH3HlCpEVCx1D8RwDLE=
X-Received: by 2002:a17:907:7286:b0:b88:5e32:5357 with SMTP id
 a640c23a62f3a-b972e5ae4e0mr245081366b.59.1773271382437; Wed, 11 Mar 2026
 16:23:02 -0700 (PDT)
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
 <abH0RdnM29Xyh_4G@google.com>
In-Reply-To: <abH0RdnM29Xyh_4G@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 11 Mar 2026 16:22:51 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOgMWCAHOHGeK-YYbEQ52s-J_OLsc5-KXVb9VNrkzDeBw@mail.gmail.com>
X-Gm-Features: AaiRm53b3IJThxEoiIBmkOlgKbt1fjA_96pFLKdVq14RUvuWtZCWUbTkm80RD3Q
Message-ID: <CAO9r8zOgMWCAHOHGeK-YYbEQ52s-J_OLsc5-KXVb9VNrkzDeBw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] KVM: SVM: Use maxphyaddr in emulator RAX check for VMRUN/VMLOAD/VMSAVE
To: Sean Christopherson <seanjc@google.com>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > > Honestly, why bother keeping check_svme_pa()?  Can't we just do the c=
hecks in
> > > svm_check_intercept()?  E.g. vmx_check_intercept() already "injects" =
#UD for RDTSCP.
> >
> > Hmm svm_check_intercept() isn't semantically the right place AFAICT,
>
> Actually, I think it is.  Per the APM:
>
>   Generally, instruction intercepts are checked after simple exceptions (=
such as
>   #GP=E2=80=94when CPL is incorrect=E2=80=94or #UD) have been checked, bu=
t before exceptions
>   related to memory accesses (such as page faults) and exceptions based o=
n
>   specific operand values.
>
> This #GP is operand specific.

Yes, but from KVM's perspective, svm_check_intercept() is meant to
check if the instruction executed by L2 needs to be intercepted by L1.
What this patch is doing is not specific to instructions executed by
L2.

Anyway, that's irrelevant now (see below).

>
> > and more importantly, it's only called if the instruction is executed
> > in guest mode (i.e. in L2+).
>
> Hold up, we're getting ahead of ourselves.
>
> The only legitimate reason the emulator is at all aware of VMSAVE, VMLOAD=
, and
> VMRUN is to deal with #GP due to the RAX check, because hardware checks t=
he GPA
> against the host's physical address space.  See commit 82a11e9c6fa2 ("KVM=
: SVM:
> Add emulation support for #GP triggered by SVM instructions").
>
> The emulator "support" was originally added by commit 01de8b09e606 ("KVM:=
 SVM:
> Add intercept checks for SVM instructions"), but AFAICT, for all intents =
and
> purposes that was dead code when it was added, because the emulator doesn=
't
> actually _emulate_ the instructions.  I assume if they aren't intercepted=
, and
> KVM is full on emulating instead of just decoding, they end up at EMULATI=
ON_FAILED
> and get a #UD or something.
>
> Outside of forced emulation or code stream rewriting, KVM should _never_ =
fully
> emulate any of the SVM instructions except VMMCALL (and that is a super s=
pecial
> case).  KVM does need to _decode_ the instruction, and it needs to get th=
e
> pre-intercept exception checks correct so that KVM correctly injects e.g.=
 #GP
> instead of synthesizing a #VMEXIT for the CPL check, but KVM doesn't need=
 to do
> *all* of the checks.
>
> Note, for L2, the SVME check is meaningless, as EFER.SVME has to be set f=
or L2
> to be active, i.e. it's L1's responsibility to handle that check.
>
> Back to the physical address thing, KVM _already_ handles that check in t=
he #GP
> path,

I guess if KVM is not intercepting #GP, then the hardware injects the
#GP and the emulator still doesn't have to worry about it -- because
we don't support the case where RAX can be legal from the host's
perspective but not the guest's. Makes sense.

> it's just wrong too:
>
>                 /* All SVM instructions expect page aligned RAX */
>                 if (svm->vmcb->save.rax & ~PAGE_MASK)
>                         goto reinject;
>
> So I think what we want is to
>
>   (a) fix the RAX check in gp_interception()
>   (b) drop the RAX check in the emulator
>   (c) add a CPL check in the emulator (because the intercepted #GP could =
have
>       been due to L2 executing at CPL>0, not due to a bad-but-good RAX).

Agree with this (also thanks for pointing out page_address_valid()).
Will add 3 patches doing this at the beginning of the series instead
of this one.
