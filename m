Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76105332628
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 22:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773440763; cv=none; b=aQg1NOskier1aUzuGb5eTyDX2ZX7ixeoFdb5tMd0EnvjLQIe5ZTDcoB83Ifym7aPUW0fXNN9sEhi0ZLJODTpHbBJweoPJc+maVdxkemQE9cL0rxL9wldIh9BGD0S0l7HRlLJNen4yp3gNopTjR9w0F69WZbOJJkxzSGRXOCSxV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773440763; c=relaxed/simple;
	bh=f8S11QEXcUvQJemuHep2fbkN0g5jL1uurHALAi76r7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LR2BXN0nwLb4R5V0euAGeWw1r4y3JiZYHQhyjqVleOO4C5xf3VsYTEToL5TfNM8rrGyZAH/q+y2fEQr4JBY8W94WQS76HgzLyHB73nfIyMf7gVIlWj4ooVabLQXPYEaejxFFNDshYU2HDeGyOd+qh6V35n2lKJSlcsK5YiDcsxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcvkLEV1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcvkLEV1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCA8C4AF09
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 22:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773440763;
	bh=f8S11QEXcUvQJemuHep2fbkN0g5jL1uurHALAi76r7E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FcvkLEV15fwzmDwEryeYLD3B5jWEm0I/vL2APlFH24SsEjrX2OqCMEmu2jkZz95Jl
	 IZuFMBK+eBEYhs0WIIxsYU/pMTanRsOlDdDWokeq8+HZQaJMuh95FAWiBZWVR1cHkT
	 aHP4NOV1K7gwoyDMCuJeB6yGU+wT0XEF5GES1l6SY+6Uzd9+wNgEfeWl+FXZNWEcso
	 y2nKJj8OnUfg70VWfKrxBX+IZPqAgg6NEqs/rHxOCWo+11qeA78aA+RFcnEAJCwsXJ
	 vV4w94ELkoxW3jPD19/HXPpc7xhQNegFWnzfOJmqh7XgMI/gnuJQ3hxpCyQYp1twH9
	 maL7ds55yDUMQ==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b96dc65b886so680120966b.0
        for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 15:26:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUDqk5KcnhiyWCyRnvvBY9nCkLUAf49PVNDDeh7djaPe+EceeyGBMjAtQVxfLUmrWPDjTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuRCANB55azFZrlHkpeIlERj4Kottqb24d1ik1AsXkUlluEg9P
	IzpQVhii5smtye8TQbnX+dGlPDAp+B/qhyWTv1dj4lTTUt2aoUm1jzqTl69tmtbV9uqfhbI1Qdn
	G9vGUb2JuKflG1tM3IxLHBoCp1D+UmQc=
X-Received: by 2002:a17:906:dc94:b0:b97:80be:c9a0 with SMTP id
 a640c23a62f3a-b9780bf0140mr111266566b.28.1773440761753; Fri, 13 Mar 2026
 15:26:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310220414.2569208-1-seanjc@google.com> <CAO9r8zOu=CzDeUi0nxukfvKXeE5m+tn-gOsoTVMJ=rHtncx5cg@mail.gmail.com>
 <abRwSJHJ9yS4XAx7@google.com> <CAO9r8zOaUM+TBcQO=6k2Nt5=VauiDifCU2JvhUpts_VGcPSYKw@mail.gmail.com>
 <abSM4_uF2Px7h-iu@google.com>
In-Reply-To: <abSM4_uF2Px7h-iu@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 13 Mar 2026 15:25:50 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOMfSn53JjZeeO6gMQqb=bs1+4LMtqzrSt-A9OH33AzNw@mail.gmail.com>
X-Gm-Features: AaiRm52P8jbSMsUdEnn59gSurEEEdq5aXkz5gVqTUUAlILbdZ8b--s7-2I0l6kI
Message-ID: <CAO9r8zOMfSn53JjZeeO6gMQqb=bs1+4LMtqzrSt-A9OH33AzNw@mail.gmail.com>
Subject: Re: [PATCH] KVM: SVM: Add a helper to get LBR field pointer to dedup
 MSR accesses
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 3:17=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Fri, Mar 13, 2026, Yosry Ahmed wrote:
> > > Hrm, I was assuming the compiler would be smart to understand the oth=
er cases
> > > are unreachable.  What clang version, and are you doing anything spec=
ial with
> > > your config?
> >
> > Debian clang version 18.1.8 (20+build1)
> >
> > Nothing special with my config AFAICT.
>
> Lame.  Given that it's Friday and I'm about to become a pumpkin, and it d=
oesn't
> really matter if it's compile-timer assert or not, I'm going to sqaush it=
 to this:
>
> static u64 *svm_vmcb_lbr(struct vcpu_svm *svm, u32 msr)
> {
>         switch (msr) {
>         case MSR_IA32_LASTBRANCHFROMIP:
>                 return &svm->vmcb->save.br_from;
>         case MSR_IA32_LASTBRANCHTOIP:
>                 return &svm->vmcb->save.br_to;
>         case MSR_IA32_LASTINTFROMIP:
>                 return &svm->vmcb->save.last_excp_from;
>         case MSR_IA32_LASTINTTOIP:
>                 return &svm->vmcb->save.last_excp_to;
>         default:
>                 break;
>         }
>         KVM_BUG_ON(1, svm->vcpu.kvm);
>         return &svm->vmcb->save.br_from;
> }
>
> Can you double check that kvm-x86/nested builds for you?  In the process =
of
> rebuilding kvm-x86/next...

It builds. Thanks for taking care of this.
