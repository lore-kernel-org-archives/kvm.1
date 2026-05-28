Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E6B3502A8
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 07:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779952483; cv=pass; b=uAKvNZGkrdXcV3jTZSK6jqWkCfUvvMP0l+zyGKSXrS1/XHiA7SxkmByhyQqFKcXqsGCmvqhMAELJtDhsUqF2XpWQVeT99P/4g/EAYg4BV07JzAVJlH9UcLR5twJFOY9WJST3nYd78RbZUiSzrmlnJj0EyWydo8XI02k++Agtgvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779952483; c=relaxed/simple;
	bh=G1nZiVxK6KsIv3edURQ3ycnOVP2d1ytBjsVMlQu7lDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QYBNyqJ2YpBrTOa4gU+TRTj7VA4zzb23Xf/KDsP6HMwCYEP19HP8EXmc5mXBT3s1ojKnqXO8PxMvftgt2ITut0l6Ca7jy7UUgFe5f08azzbWqvshtLabBrHqWbm3gm9eWGpbrvM760pZuNQhZ9HaL1s1p8vUEEsn6g3+sN7uGfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kpe2MZci; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kpe2MZci"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8cc0ef7c306so99704346d6.3
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 00:14:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779952481; cv=none;
        d=google.com; s=arc-20240605;
        b=loVa7kYc59nVoyScI3fqR2btGRptpMk4xgGSztjZFsrFJUivI68gRg9Rb3fluOy7h8
         jTz9QGqoHvuPgPP284UAhLYSUa+XSc1saJkmsA57hxa58oaxlq7nJfLyUyl3uJbA8j/M
         R/x1XaL1qigDpAIPlgwsB7A8IPryBL5VSHbQlixcBn7PMmLtsMHsFHul18oVE+kO78yA
         8XYxpF/4w5jd23x0NVHMKvbG63lZvRCsOaMf7g94jFzZHv1+GZGv8jxZU2FC48eM3tmg
         tS1tVwfybXPKOVCMalu3/b8xWbjvW1GfJxki1slaiReJyX7ggtxGT/6/koBlFe0BJ68P
         jL8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LGhOSOmxTbuWi+nnww/A8UZLJEjIJIbn4M+RZzE3DR8=;
        fh=fItrUtV5UsY1KSNx1ZNnzv3miYMbODbRRQWQ18AP5Zc=;
        b=V+fHM0q2ZOb1zgXIhGXSY6dtxOJ+9fjwcvJruksggEUDk31dTgcJY+SqeWZWRdDPPH
         uMqIl/GA84kPIt+HaFpHwfSS8ZGrszBZBDBn2fQT7jt5+iVjHCE7TYD9WaY2mbor7YF9
         S8WvE24wRO1AFyEJqg6CtAZhckDzegD2JostTXAQDYmZCCXIoZXkMdvwMbDTjogJnaj+
         JDM1Mlt1P9HDdrDSgRDr8mzD6tiNfVutvPsYn1P9g/YdQ8tKUxx1RQG1CYDSVuw0EYLr
         P/cAkwcmyl4y+gQXGzal3JrVsU43k01dparn2VWok2WyxS//brf+TwqPgrEADVhYuWns
         nBXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779952481; x=1780557281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGhOSOmxTbuWi+nnww/A8UZLJEjIJIbn4M+RZzE3DR8=;
        b=Kpe2MZci0Lj5E4sDGV2FV2sOj7aL/QyBMebRk0T/iuwRn/ZYMpXvLsr6yhdGqw3fUc
         E14NaR3LIS0uP+MLTqzA8J1vrlPGMCdVA0RjNSI4QcS1EypYnqJV7ycSdILcG8nUSCto
         PRzgpPxasX13dQJLewUNIGXp8sxEJIhtuBanHiygQNniZdQVjmIC+MxrpWXuAkpygwah
         IlL35nE1CZgu3jy0FlI6ZJiCXT5cGIPyjSm9e/n310WEKsTviY6Rmn9TptY6VsiPgHOG
         yURidVVRQnkyHWwhN4xhww1KuJCBFiMCItMi0LEVGgRiMT/uFCu7w+8LTdSRkHs13023
         rUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779952481; x=1780557281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LGhOSOmxTbuWi+nnww/A8UZLJEjIJIbn4M+RZzE3DR8=;
        b=sdS9L3ADNxJFPJZk0Czjs1UeLmH+3b+qAh1x1gMZgpW+MCCDMIgsF9eYpptwMogVT6
         cKrI0KHRHxEkhxULIlIrYzp73mf7jAOCMkAEesVMxqmKIwnD7PC66vZeZwVq7/xmujUz
         U1DEPoZTH6DTiznQzy1A8HK6Hiyx4mp2giUERTt6/FiM9v3CP2sd8MwAHL3kTkIyHGbI
         ClwBkjbv8UjmPTKQbJgJFayNtrmhM9vTw3CBoCievGWH4HORQjzhgN/tOiPQVVHM34mq
         loA26m4exWugP31agWd1aTLiqWZidTCzpGqwxm926GQL4+ff5klxnn1kIgDXBvXNNRYk
         GhOA==
X-Gm-Message-State: AOJu0YyQbhjA0jGxGMK7O/kWGK0goOoSc1GgeHV5SAQjs4vR8aE4K0OS
	3iwrPN6nqf63ETjpjYMQNHyc6xT8tXI2ODDA4qSw3UNg4/RxD0ce17bjPaFO//VBg5Rgs6tQ4XU
	J7EjjHZfJz0ldROQzLvU8qjrR4fqzID/rDFuNySE=
X-Gm-Gg: Acq92OHbekbJxGlvtyNuYzcrXR91oSsHvGuBz7zeA31C4YBmbAi/jOwupFST/N/55RG
	+dldRTZ+uV275GKaPd/m8jltCF0P7VajOAuT1/nyVbsqk7TN40S0q3oshfGakQit5bv+q2bEqoH
	0x9dnmTLP+4Dn8XnvrxELZyq7X5+0fA69w/Tm8Rgkw14fzahdNzgRJBDwzghaEgCMzFW9BY02v2
	jkNnA8wk5duPnOO3XLxpjFrIPnM+//85V/kL4bXUXdjnXUAydtxwjq1FriTNUcGGkTl8W3UQuCy
	7ujE0MADRAPNIr+9h34z4ygGEF5hnHyl1/VJBVI5DwjJjD0K
X-Received: by 2002:a05:6214:4903:b0:8b3:f7ad:635a with SMTP id
 6a1803df08f44-8cc7b5ddd3emr446095576d6.48.1779952481171; Thu, 28 May 2026
 00:14:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528032234.1322565-6-ewandevelop@gmail.com> <20260528050321.0DD3A1F000E9@smtp.kernel.org>
In-Reply-To: <20260528050321.0DD3A1F000E9@smtp.kernel.org>
From: Ewan Hai <ewandevelop@gmail.com>
Date: Thu, 28 May 2026 15:14:30 +0800
X-Gm-Features: AVHnY4JyDGkvFdQ6mowJdo2OfoTGmXlfxQAeK2554Ypeqb3E5NFpyO9ITINJWwM
Message-ID: <CAG2uPc7uHtGYONp6SxQ4opiAoo4ReVnnSZu84qippzcwP=0YSQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] KVM: x86: Expose Zhaoxin RSA CPUID feature
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 1:03=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] Exposing the RSA big-number arithmetic engine to untrusted guest=
s creates a severe local denial-of-service vulnerability (Instruction Time =
DoS).
> - [Low] The newly added X86_FEATURE_RSA and X86_FEATURE_RSA_EN flags were=
 not synchronized to the tools/ directory.
> --
>
> commit 39b1d23089ffb8d188fc17bb71d4da69fbf1ff4a
> Author: Ewan Hai <ewandevelop@gmail.com>
>
> KVM: x86: Expose Zhaoxin RSA CPUID feature
>
> This patch advertises the Zhaoxin big-number arithmetic engine to guests
> by exposing the RSA and RSA_EN CPUID feature flags. It allows guests to
> use REP XMODEXP and REP MONTMUL2 instructions for accelerating public-key
> operations.
>
> > diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/=
cpufeatures.h
> > index 3702d7a30ae61..a769c83588f7c 100644
> > --- a/arch/x86/include/asm/cpufeatures.h
> > +++ b/arch/x86/include/asm/cpufeatures.h
> > @@ -154,6 +154,8 @@
> >  #define X86_FEATURE_RNG2_EN          ( 5*32+23) /* "rng2_en" RNG2 enab=
led */
> >  #define X86_FEATURE_PHE2             ( 5*32+25) /* "phe2" PadLock Hash=
 Engine v2 */
> >  #define X86_FEATURE_PHE2_EN          ( 5*32+26) /* "phe2_en" PHE2 enab=
led */
> > +#define X86_FEATURE_RSA                      ( 5*32+27) /* "rsa" Big-n=
umber arithmetic */
> > +#define X86_FEATURE_RSA_EN           ( 5*32+28) /* "rsa_en" RSA enable=
d */
>
> [Severity: Low]
> Should these new flags also be synchronized to
> tools/arch/x86/include/asm/cpufeatures.h?
>
> It looks like check-tools-headers might warn during the build if the tool=
s
> header isn't kept in sync with the main cpufeatures.h additions.

I'll fold that into v3.

>
> [ ... ]
>
> > diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> > index 3fb81f7a61076..94ea9abae566d 100644
> > --- a/arch/x86/kvm/cpuid.c
> > +++ b/arch/x86/kvm/cpuid.c
> > @@ -1290,6 +1290,8 @@ void kvm_initialize_cpu_caps(void)
> >               F(RNG2_EN),
> >               F(PHE2),
> >               F(PHE2_EN),
> > +             F(RSA),
> > +             F(RSA_EN),
>
> [Severity: High]
> Does exposing these instructions to untrusted guests risk a denial of
> service?
>
> Since REP XMODEXP and REP MONTMUL2 are unprivileged and support operands =
up
> to 32768 bits, can a guest user-space application force the physical CPU =
core
> into a prolonged computation?
>
> If the hardware doesn't efficiently yield to external host interrupts dur=
ing
> these massive operations, it seems like this could stall the host, delayi=
ng
> interrupts and VM-exits, potentially triggering host RCU stalls or watchd=
og
> lockups.
>

the PadLock spec guarantees these instructions are interruptible:
state is saved on any interrupt/exception and execution resumes
from the saved state on return. We've also empirically observed
mid-instruction preemption on the 1024-bit MONTMUL2 path during
host scheduling tests. KVM's normal VM-exit on host timer/IPI
applies, so a guest can't actually stall the host core beyond a
normal RCU quiesce window. The existing REP XCRYPT/XSHA
(already exposed via word 5) share the same interruptibility model
and have been in guests for years without DoS reports.

> >       );
> >
> >       /*
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528032234.13=
22565-1-ewandevelop@gmail.com?part=3D5
