Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADFD2D876A
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 19:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783451810; cv=none; b=dsKqA/1UsjiHKalJrHfUbflvhCPASWbK6isRpDjIwOBPSUZ/1Sx8dhXncs6MPylBqU4WweyElRwnUdQY0eKH47l2baoqP+hJOdFfqvQdlQicKGroQJZpQRNudicE0qMY1L/L4ATo68r6HC0l0olSHfqjWToIGAJl0e2KtUDJpQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783451810; c=relaxed/simple;
	bh=Rrr5x5ig8JyhfrhHMWQeKgUULcODUkkp8jUbPOWouu8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AUjueERvki74rAjwPKefNlCIH4VBX/qL1uxJlPf8XadRYUtnuuWDFpsh9Fa9x1APCmS+3ShWwmESxtSOBwsm/z4Hm1ox4BBLo8uYYdSh8Xx/ZO93rvmuIfs7y+0ahGbl8/LDNBtPwDtmgy8u0WWGDm8UFVRkjNSTTIIZYmW5tXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ETqJJpmd; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ETqJJpmd"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c6bbd0afffso95524395ad.0
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 12:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783451809; x=1784056609; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mwyS52Ee+fzpPLsIt5St9y7+nrmgCj0h4goGGRZrAxg=;
        b=ETqJJpmdyeC0qYTGLXXDRdCkC+QbfAEHHDMXbrHzMNmyEwlfZUhE4rrePTNnA6pR46
         +cv8VIVbYipsW+z/uio4pskwbJ5DCST/6QWg5eZHa396wUZ7gxZfBrvnSyCOH8A8SEdb
         EKHbUC0bpeX/NnSTVVEueFzY/J9+AIwT2Hv6AAT7sq6tpzBtHITL2suMlRsqKpIaWJTv
         gqvbrXi62AzRVlwZ7HpCqHoRSe4DcrV/yyQBobhvjJofxOiKgNP1JlDLST2DTKucj2QO
         t4WT/+foyIhNLo0j7RFuNcGd4ZONoOgRgnBqbbh4FBGle/nBXZDu+fnGdYuNVv0k5UbS
         kxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783451809; x=1784056609;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mwyS52Ee+fzpPLsIt5St9y7+nrmgCj0h4goGGRZrAxg=;
        b=BSATV+ZpQSwPEzq4cVL0Ynh7u2/CDPeVnFey01C/AFU2NhoZNyR50p3Kw+WfGmpCtm
         2h8FMB6lDDCgaWZsz8ETeClNIuKzyKL6zpcgr4u65iBPomwLtKLMRpfD68DsNlGIvMK0
         fJ/2niDxzOpEVCU4Clq15qADqub3i646JrgxA23/FXIcJMqJBqz1J/maclJ/f28BMkIO
         CztosQe2uZ3b3GPxRMk73kEVCHTr0E3znvLwvC6PMJkLCY5+0yQ0/wOwXrEdz8uVJnpq
         Y7PQwTOvqQAf3eFlfmbrAPV2uPB4Az66NiH5lk7CSskvQ4yUEgDcdVBGWuejv+JXm9zC
         CS3A==
X-Forwarded-Encrypted: i=1; AHgh+Rq2nomM48QWQmEEIgbNhQDx6+ABuke8R1LUsGq3GYRgAz1yv+m1ElDfIigpmb4vi8gsbUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7nFQhdXVZ4IW3FB/Evd9aVsnCOoKJrSCCcX8+2Liay+ylhMDS
	EsZhVZEqHxVPbvQmOg3h6Z+WGQFUmcE3YLgpm3pG7dWK/fXsXpNAPrfL4eZvmN9pTLxwz0qLVZ7
	aAjpxTg==
X-Received: from plbkf8.prod.google.com ([2002:a17:903:5c8:b0:2bd:40d4:e407])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f60d:b0:2ba:6518:a6d4
 with SMTP id d9443c01a7336-2ccbe7232f3mr60167385ad.20.1783451808480; Tue, 07
 Jul 2026 12:16:48 -0700 (PDT)
Date: Tue, 7 Jul 2026 12:16:47 -0700
In-Reply-To: <CALMp9eQ4JZ8E5BTr7Cde5M=djBg1oMNLbfn_ZoVPL62ijna3AQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <0e576fd8d8cd2ed1739cee36eba393fea7745506.camel@redhat.com>
 <f70b4a3b-1ac1-4269-ab7c-0ed1fb42c357@open-hieco.net> <CALMp9eR5jVLGeQck89kro1ocEX5aZcovdGMK+fuzXjqK1NR7kQ@mail.gmail.com>
 <d5645a47-c346-4e63-a5c6-c88bb39a3ee1@open-hieco.net> <akxwt1mX6blSnkxI@google.com>
 <CALMp9eTr0iJ5QgbZJ0YtOZg89XVFSesbyoGGdtkz+f8c60DcDA@mail.gmail.com>
 <ak0QE7mP_TeZmzeS@google.com> <CALMp9eTycB8Z94V8j-xyfDeah5KaJypRrPfFNHfQSUzgrr7FkQ@mail.gmail.com>
 <ak0dRzS4Ap-JREvg@google.com> <CALMp9eQ4JZ8E5BTr7Cde5M=djBg1oMNLbfn_ZoVPL62ijna3AQ@mail.gmail.com>
Message-ID: <ak1Qn5miCXvvRnyF@google.com>
Subject: Re: [PATCH 0/2] KVM: nSVM: Expose DecodeAssists to L1
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Tina Zhang <zhang_wei@open-hieco.net>, mlevitsk@redhat.com, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	zhouyanjing@hygon.cn, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 07, 2026, Jim Mattson wrote:
> On Tue, Jul 7, 2026 at 8:37=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
> >
> > On Tue, Jul 07, 2026, Jim Mattson wrote:
> > > On Tue, Jul 7, 2026 at 7:41=E2=80=AFAM Sean Christopherson <seanjc@go=
ogle.com> wrote:
> > > >
> > > >         insn =3D ctxt->fetch.data;
> > > >         if (ctxt->eip =3D=3D kvm_rip_read(vcpu))
> > > >                 insn_len =3D ctxt->fetch.end - ctxt->fetch.ptr;
> > > >
> > > >         for (len =3D X86_MAX_INSTRUCTION_LENGTH - insn_len; len >=
=3D 0; len--) {
> > > >                 if (!kvm_fetch_guest_virt(vcpu, kvm_rip_read(vcpu) =
+ insn_len,
> > > >                                           &insn[insn_len], len, NUL=
L))
> > > >                         break;
> > > >         }
> > >
> > > This split doesn't bother you?
> >
> > What split?  Do you mean reading some bytes from the emulator, and some=
 at the
> > time of #VMEXIT?  If so: no.  IMO, the most important thing in practice=
 is to
> > capture the actual bytes used to decode the instruction that led to the=
 #NPF.
>=20
> Yes, that was the split I was referring to.
>=20
> > Exactly how and when the "CPU" reads the bytes is a micro-architectural=
 detail,
> > so I don't have any qualms from an architectural-correctness perspectiv=
e.
>=20
> When I requested this feature, I think I made it clear that I wanted
> the actual instruction bytes used to decode the instruction, rather
> than bytes asynchronously fetched through the data path.

FWIW, what I'm suggesting gets us as close to that ideal as is possible, I =
think.
If KVM emulates an instruction in response to an #PF or #NPF exit, then the
emulator will use the information from the VMCB, and so the above code will=
 also
use the code stream that hardware provided.  If hardware provided fewer tha=
n
15 bytes for whatever, KVM will try to fill in the gaps, but KVM can't poss=
ibly
have decoded those bytes, so there's disconnect between what was emulated v=
ersus
what was read later on.

If KVM emulates without information from the VMCB, then the emulator's code=
 fetch
is the "source of truth", and everything else in the above again holds true=
.

> It wasn't until I encountered the Naples erratum that I realized AMD hadn=
't
> implemented the feature as requested.

Yeah.  I've poked AMD folks about this once or twice, the answer is (amusin=
gly)
that plumbing the bytes from fetch+decode all the way to the #VMEXIT is pai=
nful,
and so hardware just reads memory at the time of #VMEXIT.

> Since there is no guarantee that the instruction bytes are actually
> relevant, I concede that 'exactly how and when the "CPU" reads the
> bytes is a micro-architectural detail.'

KVM's emulator would actually be doing better than hardware, because at lea=
st KVM
wouldn't report different bytes than what it emulated :-)
