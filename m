Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162FD242D6B
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 22:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787868084; cv=none; b=aEcI2NF6fIILBXxaFI+udDQhoj4xBhQJhQOTOkAWXiQytrRrxZvZP+7WJEPOU6pDHgvpP/pQ+Vw7yFWSAJ32Oe7K42yz0MYc3sekEmDXrWeCAFy5NuIZ2dEu9vJkfCejLv573uwb3ql2C3zWwiQoeNBGfk7PLJxWx58rJOMivTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787868084; c=relaxed/simple;
	bh=DPd+eVzMOMuFQAgmMb1SXtBbytnIfQ1XCrEh+L3dNuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=czknOdg5AuIn8pL6a/HxqgdedGvGuONV1b+cQwKdzgwclRvamk9IEqIDK98XRfncJPArjaCZF0P6b8r6Bs+Hd5mW8U8/vnAfgStw0ZCb0eMTwdehXO3BGxa5MFSSJDQy4nDkN5Uv398u6P2M5f2rUznCUTEd+sD0JP8AAO5s1lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coD0TSJ1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coD0TSJ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5301F00A3E
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 22:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787868082;
	bh=rvnZ10i2vZpOK7IXbiiXUPeqQUmtUqlB6Yz4vlyegxU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=coD0TSJ1QeZdD8tB9n/3mkcOBVPbwcAiMV0IoYSbE9meU77CgoIu92nymVVnQ2GFU
	 MvoIstREsCITSEjimaiUX36EthxykqcBvEyxgXNJRxSeUrJTNS170jEbVWRN15ylwz
	 ecMvYJtKu8P39ZTfO8t/0JL1BMr+ZCH2jjRJZDt5YTqNNYLod+EXkzxu07QAulffyL
	 9uWuVeqXJ8AtEYxZhC8FZYLlmLfvswDDW50ghA1J0X6D6bEk1/7GmLsmrHQNmbcOnE
	 SdTKn9siTahcF9pl8Vrkex03C81pFtopf/RN6jO0HstxQp8Gn8EgVIUR9fv0KoSJgd
	 KJkkKkz7wOEfg==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a5e971c970so2437234a12.0
        for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 15:01:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqpUkb8BnwMGk9KFsS5VVjDquMQblHQRs6Ae4n2sRVKzEznqnRg2kGBBJxtzOrrc12eydM=@vger.kernel.org
X-Gm-Message-State: AFuF++mRZwh1TjRfxVS3FSix0EYke/5HPsdX+JTzyvxO5uWS3sWTV/32
	c3kHu8lM0iQsaF36afHu130JT+CGkjBrlaXW6yoshvtaBmI/2fa03VOAsLJkLtJVBSKVK1BuFh5
	TI5sLKGDjg23ysgGpZj+M7i/P5omms/0=
X-Received: by 2002:a17:907:1b0e:b0:c1c:2218:f317 with SMTP id
 a640c23a62f3a-c2535eab9b1mr780089466b.2.1787868081629; Thu, 27 Aug 2026
 15:01:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826211844.884951-1-seanjc@google.com> <20260826211844.884951-2-seanjc@google.com>
 <CAO9r8zMnPwXVf6wx_gDMzv4j47xWa7idLD+vVm9DUiB=huiLaw@mail.gmail.com>
 <apA9eLuaMxCLdCmn@google.com> <CAO9r8zNm1QcVh29rTCzAFnYdUCS4y8ZSQOvrs2DD18XASuktoQ@mail.gmail.com>
 <apB1A5Ln_lGTI4oy@google.com> <018f411b-9c7e-4baf-9d55-a153eab64dc4@redhat.com>
In-Reply-To: <018f411b-9c7e-4baf-9d55-a153eab64dc4@redhat.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 27 Aug 2026 15:01:10 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPDvXCdD1oyBmvaXoC+T+ABx-iZ3b9XeNpqUrKqPMcMAw@mail.gmail.com>
X-Gm-Features: AcwNN1U6zWzFtgNdlLz-fDi_cxSGMSNEr_2oGHRQKeI57VzyQGGHDnpEt_34JG8
Message-ID: <CAO9r8zPDvXCdD1oyBmvaXoC+T+ABx-iZ3b9XeNpqUrKqPMcMAw@mail.gmail.com>
Subject: Re: [PATCH 1/4] KVM: nSVM: Reject KVM_SET_NESTED_STATE if L1 has
 EFER.LMA=1 && EFER.LME=0
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 2:42=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On 8/27/26 19:33, Sean Christopherson wrote:
> >>> If anything is wrong, it's the CR0.PG check.  Presumably that got car=
ried forward
> >>> from commit c0725420cfdc ("KVM: SVM: Add helper functions for nested =
SVM").  I
> >>> don't see anything in the APM that requires paging to be enabled, and=
 nothing in
> >>> that ancient series points at concrete documentation either.
> >>
> >> Oh yeah you're right, for some reason I thought it was paging not
> >> protected mode. Well then, it seems like
> >> nested_svm_check_permissions() is also incorrectly checking paging as
> >> well, seems like both checks are incorrect? Also, I don't see anything
> >> in the APM about checking RFLAGS.VM before VMRUN.
> >
> > Presumably it's covered by the !PROTECTED_MODE clause.
> >
> >    IF ((MSR_EFER.SVME =3D=3D 0) || (!PROTECTED_MODE))  // This instruct=
ion can only be executed in protected
> >      EXCEPTION [#UD]                               // mode with SVM ena=
bled
> >
> > Section "1.3.4 Legacy Modes" describes "Protected Mode" and "Virtual-80=
86 Mode"
> > as separate submodes.  And the tables for most instructions differentia=
te between
> > Real, Virtual 8086, and Protected modes when enumerating exceptions.
>
> Right.
>
> As to CR0.PG it does seem incorrect to check it entirely, however note
> that there is this too (15.25.3 Enabling Nested Paging):
>
>         If VMRUN is executed with hCR0.PG cleared to zero and
>         NP_ENABLE set to 1, VMRUN terminates with
>         #VMEXIT(VMEXIT_INVALID)
>
> which would have to be checked in nested_vmcb_check_controls().

Yeah.

>
> >> If the goal here is to keep the checks here consistent with
> >> nested_svm_check_permissions(), aside from the new EFER check, then
> >> maybe we should also check CPL here?
> Perhaps, but nested_svm_check_permissions() is not reached with CPL=3D0
> because the #GP overrides the interception (table 15-7, instruction
> intercepts).  The same should be true about EFLAGS.VM=3D1.

It is reachable in the odd cases where KVM intercepts #GP.

But either way, I think having a CPL check in KVM_SET_NESTED_STATE is
probably the right thing to do.

>
> Paolo
>
>
