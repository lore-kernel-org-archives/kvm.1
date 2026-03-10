Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC1B3ECBC9
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 21:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773179226; cv=none; b=Ad8fF42zU84y5XNclHpukx3FWWM8A9okeHJ/RkVjC7mbEJtotQs7J8zV4QIAb1Myy3O22/zHAKoiefVQuqmzHvhmSMRnfeaLPSotnnarP6/aDV/dtBpZUC0saHwUa8i64zgmZ/2xg/MTC38R0lUxQp30zH4yNkq7zaqsgHYWEio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773179226; c=relaxed/simple;
	bh=8526QoqJKS1zLcrD5V8hkYHwRN+JCTJdADTbBkhzpO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lCfGOTGhAufX+7nlfyQ4YN01TmjtuKToFv3vVChH+PHgc00GAqDp3PWxpbYcvc+NZ95utaIiGpdNLChUQFYKHSVsoiNKNDKi1ovbuSSNCRrylP6OWl4J14KtSDl7G+sD4y3t5Tf+2uBIWpNVlU10jQjkUQ2pn7rdL/SEaGNGles=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CD3N/4AD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CD3N/4AD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D6CC2BCAF
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 21:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773179226;
	bh=8526QoqJKS1zLcrD5V8hkYHwRN+JCTJdADTbBkhzpO4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CD3N/4ADjoXBzmpBpWwKYdc4MLHPYuz2mncJ67Nv4DEAp8LGEToQyDenlz9/DpGQB
	 ZxRutjBd4zyZszaAxKO4Ehj0cCUZH4EiEPME19KM39fKENy/LKzHysVDxJLVgMdf9O
	 4aZVGy7bbDrZYJ9yfqZiZrGoT2micvBeFmwH7J30M/3GyECETyRtDsVGaS6VSeavLd
	 BndWFwj6c2kSwvzfBWKVIcN/O7JrksRCWg2Z4sEaJY/ZJxkH+tS4HuUiIRzg8fwSGX
	 zXiXxWHzKsXtAM1HY21BGHZQCwpFE1Po0NRWNKXLHoyRyHIYuvmSjN6cIPSjEPnuGj
	 muaN9SNRPR96g==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-661d20c9787so5580559a12.0
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 14:47:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWHo473IeKZ5YSWztyKLaq2QW+TLmZN9+4rwMokIn4A4Q1CLfAIKweDT6H6s9QjqJ3p3zE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4AbYwJOHGYLI3+1UmtIvACIVFrAiHj0TMs+y3QfzzZi0qeY3W
	wCMJP8UODH3pzpUdd7ObL03CblddcO/PRWi6E8/GyyqjrmNUrvBuHlJzNXZE82jSH8/jZAC1Gc+
	wvvqc9cDtS1a0Gk1nQ5hIjzDwh4VzRKc=
X-Received: by 2002:a17:906:fd84:b0:b94:1913:77fc with SMTP id
 a640c23a62f3a-b972e5f420emr6614566b.30.1773179224774; Tue, 10 Mar 2026
 14:47:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310202414.406078-1-pbonzini@redhat.com> <20260310202414.406078-3-pbonzini@redhat.com>
 <CAO9r8zOLc030xTsnkYWvp5yUtnzQgVZnXXhvKZWC__1wRSP61A@mail.gmail.com> <abCRA_B2kHp6T7Zn@google.com>
In-Reply-To: <abCRA_B2kHp6T7Zn@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 10 Mar 2026 14:46:53 -0700
X-Gmail-Original-Message-ID: <CAO9r8zN9AdZyzdBHAVbBG1VFn=c5doWUNNPJ7Wp8VYGUy+mO=Q@mail.gmail.com>
X-Gm-Features: AaiRm50aPeii-M5-ztr8u-o-c3IWzYGO-EcgvUjlNIvlSE5IEosX_x5-sVN2Mt0
Message-ID: <CAO9r8zN9AdZyzdBHAVbBG1VFn=c5doWUNNPJ7Wp8VYGUy+mO=Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] KVM: SVM: check validity of VMCB when returning from SMM
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	xinyang@anthropic.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 2:45=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Mar 10, 2026, Yosry Ahmed wrote:
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > > ---
> > >  arch/x86/kvm/svm/nested.c | 12 ++++++++++--
> > >  arch/x86/kvm/svm/svm.c    |  4 ++++
> > >  arch/x86/kvm/svm/svm.h    |  1 +
> > >  3 files changed, 15 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > > index 7b61124051a7..de9906adb73b 100644
> > > --- a/arch/x86/kvm/svm/nested.c
> > > +++ b/arch/x86/kvm/svm/nested.c
> > > @@ -419,6 +419,15 @@ static bool nested_vmcb_check_controls(struct kv=
m_vcpu *vcpu)
> > >         return __nested_vmcb_check_controls(vcpu, ctl);
> > >  }
> > >
> > > +int nested_svm_check_cached_vmcb12(struct kvm_vcpu *vcpu)
> > > +{
> > > +       if (!nested_vmcb_check_save(vcpu) ||
> > > +           !nested_vmcb_check_controls(vcpu))
> > > +               return -EINVAL;
> > > +
> > > +       return 0;
> > > +}
> >
> > Nit: if we make this a boolean we could just do:
> >
> > bool nested_svm_check_cached_vmcb12(struct kvm_vcpu *vcpu)
> > {
> >        return nested_vmcb_check_save(vcpu) && nested_vmcb_check_control=
s(vcpu);
>
> I don't care one way or the other for this particular patch, but once the=
 dust
> settles on nSVM (assuming it ever does) I do think we should align the "n=
ested
> check" return types across nVMX and nSVM (which is likely why Paolo ended=
 up with
> the above; I requested using -EINVAL for the nVMXx) patch.
>
> My fairly strong preference is to use 0/-errno as "return -EINVAL" is mor=
e
> obviously an error than "return true".  But we can bikeshed later :-)

No objections, I was strictly going for more concise code and it
happened to also keep the existing return type (instead of translating
boolean to int).
