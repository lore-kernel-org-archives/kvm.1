Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690853E5566
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 21:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780607480; cv=none; b=gYhg20jC2Ele+R+LOTwjZWwVQ1Xy+MO8q9Zon9NhdumZUkcwU54GhDoWBJ7pOvxYsutsABHSaqi5f1uQVEZJ2hEsBMNQj/b1/vsLm5tUtPm73E8oRBYZEZ/M9//xGNsADkMX2pAShaLzT6VhS6wsGCZw1oi3VAM8Hq0HAUrk5wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780607480; c=relaxed/simple;
	bh=HCH7nmkV3cAshOT62LQ5OBKgU2V2cTi+JY/8vfhZhoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pVSJPAaxSzOq0qTfiJpvW2vwGGwDb7avYFLd4BW+zoQMspslPHzKSrrChD4AvIqmlO6SriiwHlmhWBHA4Kgg/HB7nq6WnHOF7C3KIg8OrUOH3yrvUKHUqdTVqpUap/kFfA5CgepqHIwQssARYRLFdjYyqVaruWwNyHQ17M60M/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXovWRU4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXovWRU4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A811F00893
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 21:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780607475;
	bh=3rVgNw4C014s5+q1Xrmod6YUCzBaQTwSOL48z5g0N5g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=mXovWRU4spW2ild8JLjij+d+7wcrkCeNz1+JbmZYEDb17QvyjAuBmn8ILuoN0x/rm
	 zqZ+41ZsiEbWgBBi1121hRRfY9UY9Af8diE+9T71kZrGsYmFpfkJmWmLI5sLGeeeA2
	 6hxy9vUeqX2M++8b01ZoKwCHBcn9rzlkPe+63NQFJE4xrUE5K+tbDtaCA1HnBWTb6h
	 MEo3+QTFSE1qHeInqqB0SiRVYqxdY+ofJ7sRmRpEqN0RxMgkj74l6iFlMy4zzSksrj
	 39rWMCQ1oYRka/3pWeDNVt3ULeY3B2pNyxuERfT0SPjm0STz3qjQ8bJe3PTBLDz+4X
	 WIbekTlsX2LNA==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bf1141c26ecso176346666b.0
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 14:11:15 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz/MeBUaBa1C1ldJPZwI/QiGMDuvLp2jETLKb3rwo+fVf9KVU+R
	sK1uPoKCqQcxjJBOmzTkdv8WVhDYQ74JU3PHqFMnpW9NmeiX7yAwgoj75YJegk3Ucd0BSR10OAY
	vohu8PkyEirjuA5bldo4YHHktrorOJZk=
X-Received: by 2002:a17:906:f5aa:b0:bec:6c5c:cced with SMTP id
 a640c23a62f3a-bf372159bf0mr20265966b.28.1780607474695; Thu, 04 Jun 2026
 14:11:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604203546.365658-7-yosry@kernel.org> <20260604205007.D004E1F00893@smtp.kernel.org>
In-Reply-To: <20260604205007.D004E1F00893@smtp.kernel.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 4 Jun 2026 14:11:02 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOe+VguHTmLUG8QZM0SgM0OkkZpeA6JpyTCVLo7CtSmag@mail.gmail.com>
X-Gm-Features: AVHnY4LmkHbfspEp4GQlSuCA7uP_fKSciDdzVdXOT-vmNCtSnx2RUW11QwrfqL4
Message-ID: <CAO9r8zOe+VguHTmLUG8QZM0SgM0OkkZpeA6JpyTCVLo7CtSmag@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] KVM: selftests: Drop HORRIFIC_L2_UCALL_CLOBBER_HACK
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 On Thu, Jun 4, 2026 at 1:50=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Removal of the ucall GPR hack causes L2 register corruption in=
 EVMCS nested virtualization tests.
> --
>
> commit 15ef07c71219fb9256d8d4da6427386aaf993fbd
> Author: Yosry Ahmed <yosry@kernel.org>
> KVM: selftests: Drop HORRIFIC_L2_UCALL_CLOBBER_HACK
>
> This commit drops the HORRIFIC_L2_UCALL_CLOBBER_HACK from ucall_arch_do_u=
call(),
> relying on the nVMX test code to preserve L2 GPRs across nested VM-exits.
>
> > diff --git a/tools/testing/selftests/kvm/lib/x86/ucall.c b/tools/testin=
g/selftests/kvm/lib/x86/ucall.c
> > index e7dd5791959ba..38050c60a0670 100644
> > --- a/tools/testing/selftests/kvm/lib/x86/ucall.c
> > +++ b/tools/testing/selftests/kvm/lib/x86/ucall.c
> > @@ -10,36 +10,8 @@
> >
> >  void ucall_arch_do_ucall(gva_t uc)
> >  {
> [ ... ]
> > -                  HORRIFIC_L2_UCALL_CLOBBER_HACK);
> > +     asm volatile("in %[port], %%al"
> > +             : : [port] "d" (UCALL_PIO_PORT), "D" (uc) : "rax", "memor=
y");
>
> [Severity: Medium]
> Does the removal of this hack cause L2 register corruption in Enlightened
> VMX (EVMCS) tests?

This is interesting because:
- Yes, I did forget to handle evmcs_vmlaunch() and evmcs_vmresume().
- Yes, HORRIFIC_L2_UCALL_CLOBBER_HACK was introduced specifically due
to a failure in hyperv_evmcs (according to the changelog of
6783ca4105a7).
- Yes, I did run hyperv_evmcs before sending this patch

...but NO, the test did not fail.

I guess it depends on what registers the compiler ends up using and
how the code is compiled? Not sure.

Looking at the code, it actually seems evmcs_vmlaunch() and
evmcs_vmresume() properly save and restore RBP, RDX, and RDI (the
registers mentioned with HORRIFIC_L2_UCALL_CLOBBER_HACK), so I don't
understand how HORRIFIC_L2_UCALL_CLOBBER_HACK ever made a difference.

All that being said, yes, I need to fix evmcs_vmlaunch() and evmcs_vmresume=
().

>
> While standard nVMX tests preserve GPRs using VMX_SWITCH_GPRS_ASM, it app=
ears
> the EVMCS helpers evmcs_vmlaunch() and evmcs_vmresume() in
> tools/testing/selftests/kvm/include/x86/evmcs.h were not updated.
>
> These functions still use a hardcoded inline assembly sequence that expli=
citly
> clobbers %rbx and %r8-%r15.
>
> If L2 triggers a ucall and an asynchronous event forces a nested VM-Exit
> to L1, wouldn't the L1 compiler clobber L2's GPRs, causing L2 to resume
> with corrupted registers and leading to a test failure?
>
> >  }
> >
> >  void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604203546.36=
5658-1-yosry@kernel.org?part=3D6
