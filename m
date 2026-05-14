Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9541E1A3D
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 02:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778725885; cv=pass; b=h+PT4tzf0StirFOqegiK6kaXB5uHDa6JH9G45potCCr0cpGnm8ceAOjiuR7KV1SMVqwY39nv7LKBVzeel2uST0IIDCdZPx0b5RWR8a0Yhv69zevpqMwyPsl+zgdqlGeUwXKv3WitvRWQ/aRzxWrZS5nr33SpjsZ6AB/qgV73og4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778725885; c=relaxed/simple;
	bh=tFbqRBEBTPzWEINd3LRnNCewkEs7hjzSRYFHoKAWSpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NrWNqIkVONWs1OuwpmFtLWgztY8ObUCqly3whgF4nJyYy6aDWx/7DrfMd3KUPNHR3hTS34BngWp/kCjQ7XeQb/ybEJJmh3RS+jGmI3h7izgZT88k4i6eFWcAbLtQypAwcyXPt3WtdB7C8q7iL6MOYqWVAvB2B5UAucOdlSyNuVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVNejYqQ; arc=pass smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVNejYqQ"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-91080895355so91553885a.3
        for <kvm@vger.kernel.org>; Wed, 13 May 2026 19:31:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778725883; cv=none;
        d=google.com; s=arc-20240605;
        b=kwyd5vHsq1QMUzkYEmD3fv4Yc9EAIv9Vnh+G0GFh6nekWArB3InQmoyOZxBB8iZCbV
         ziZPSrw2NQEi1HDlhvhAPN6J7FfbAZtBWE4AGdWdS+IOyRSjV/NBnMFW2JfT5TjTo56+
         WI9NdjWaVYIrK8q+8hokUtyVp4LGB2HegPmDHmVIM6CGgWRVgRZiNbUl0YgUfaRy882v
         vXbnsp5026/kJMJKxYr8BB8OXjc57APjzAQDPFV3E8tSr03JuNJ8Bz2NMmjCwsEcLUbU
         2B+o0syduVeP8t4iz24xtqz6bVKkkbOouEOMk6dmSRO7aeNp3/uKWU3PLQYpQdmQ+01w
         lQQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6VVuG0IPzHdWlPPjymaUvbROs+zIcttk9vymiw+b2F8=;
        fh=AFYANiJr35VEFB9FMAtEXLscRj7wZe6d/qiif2QWQjA=;
        b=LiJhZ+Afby/4rf4Z0TN+IDQT5Sef7EHpnvPFVoDmbtxiGch8Exr3jX1Gfb7/TfFiI+
         5j+0eo7njQ9O/8oTZPwL5WFeXbNE24Cm5QdUCQUUEcy+fuj/6pm8cg0TR9zc7yjnBsgq
         y5Kq8dxbyudtUI1g9/1o40rhUYcKy/fdRKICNAjT05sp6sxxkKtLrM7BaUQ9vvdD/tHK
         K1XGgUX+ZhLEPsrEX9OXlAodwN8RCDCSD5axlRgAB5N/yWCdf3mbCxBpCc8/yIjg6Ru1
         NGDCg//56384bLNXajHIdE8F8c8+2gR30K1EE6vhJqgAoChAJ3fr2jBYDNP5IciPSJEc
         DCGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778725883; x=1779330683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6VVuG0IPzHdWlPPjymaUvbROs+zIcttk9vymiw+b2F8=;
        b=cVNejYqQk5Dps8ZTC12fySlG6vyoHeimHvoWKRK+fsVTx6dDsXbWd8Vjxw28LoHptU
         49Vn3uQuPsM77EzSyROwHo1rKjfJCgOxXg4ufHDFEfvAqF06kYLHzcC326V99hf/YgFL
         cXBI/JL8FbRXQr5YN5tyDc2zTgSKeoQ8Tt0purYZrXyX8Fyzyvt4sErimmr+lqPLIXm7
         MvxTimVLq0Wgj0UgtdatRU6KrPrQToJkPMKVGbJgIUL7JIMqDtSE7lsql0zDBgli/qRt
         HomXKba/5GSxM56C8f6pVF/CersUjhhlPuNm5SxmCRdx7F9QGApyfxHe+yYs31I+rpQM
         BQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778725883; x=1779330683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6VVuG0IPzHdWlPPjymaUvbROs+zIcttk9vymiw+b2F8=;
        b=sOkIS0KJELmFSigB8WP92ttPIdEubLqAcMZn12GtsxRLpL1QOnvZcQVW/sx5p6N1wD
         7UbWAz3kRbAUlRyvgp02V+ThGymt3636XV9bG9BwV+TB3muWfr4X1G1iAsRr0hDRvk7V
         9YpIxFJAU0qrYd9z3dYfftSTuaN1iAlSczRyFxhHKcEEmbO4Rpi6PCmWyasmZHv+cyTI
         oXJ6VidewgsyEVIsI0HNSWpB/EwWM1Yw8lLTu7wQF5HRrIWeXjek4Up9Yera1wpcwJQt
         JRcdS37GmeCjpsQ0UAXXiwLaNpOpOGdRmhvTOs47SbjmuemCya74xj1lQftmZ9FrJts/
         9fkg==
X-Forwarded-Encrypted: i=1; AFNElJ/9WO/e1S1EPfWni/BukOIUnKK4AjIJPaAyoxWjI13wWOxg2joWLc88rcpvBdXAmFZ3WQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzcxjIPMLbj0aojWvA5hIP77IjM8lS58KenzZlK//oVfVg+bsf
	0E54rayR0kASt0T2MgLzNlvi/V609axigJgyE3B57MuO9vxID8XS3icgKATC3ZxZWHz1n8Plic1
	2Ea4vYvDeQZprQvSHQO2VQfpVGlqUc2o=
X-Gm-Gg: Acq92OFSgx0YjNlw6ja+dTSVrR+CCARU/uGEkL9H0GFFiEwP/38ZE38umn1HXwj2KH8
	0teh/X5HPkjzeUfdziiFVtFLhQJPeRFFsIISU3hSIeFQykNCqopVVpz1B6wq7a3gfB3hmH6fgCE
	xHnrp8xmnAoVXvDg2cl02SJNF/cnl2p8z9mA9nZAjTyZi1OGX7+Z+J8cIo9LDmC5jKCQmuSQKdB
	BVV6o69QyqpS0tj+x0NUxG3//7skO2HnBPDLBOBpZeoYtZ79gzfu6fNt8lobT4KVRS6Kik8+y5C
	aUyiCMqf
X-Received: by 2002:a05:620a:468d:b0:90d:501c:50 with SMTP id
 af79cd13be357-90faba13b53mr836182785a.26.1778725882829; Wed, 13 May 2026
 19:31:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513093633.1608334-1-ewandevelop@gmail.com>
 <20260513093633.1608334-2-ewandevelop@gmail.com> <2e73a7c5-82db-463f-9665-94280402913a@linux.intel.com>
In-Reply-To: <2e73a7c5-82db-463f-9665-94280402913a@linux.intel.com>
From: Ewan Hai <ewandevelop@gmail.com>
Date: Thu, 14 May 2026 10:31:12 +0800
X-Gm-Features: AVHnY4KVhf43GXYtzr5ZG4CHAoR45ET1XXUtFZMbsjW3JPf0LuwpH1z2v5FsOx4
Message-ID: <CAG2uPc7T5Tkn5RSLzrfJLEZoh0EYJvdJZkmgJNFbe4NPu0UqMA@mail.gmail.com>
Subject: Re: [PATCH 1/5] KVM: x86: Expose Zhaoxin SM2 CPUID feature
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, cobechen@zhaoxin.com, 
	tonywwang@zhaoxin.com, AlanSong@zhaoxin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Binbin Wu <binbin.wu@linux.intel.com> =E4=BA=8E2026=E5=B9=B45=E6=9C=8813=E6=
=97=A5=E5=91=A8=E4=B8=89 18:36=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 5/13/2026 5:36 PM, Ewan Hai wrote:
> > Advertise the Zhaoxin SM2 instruction support to guests via CPUID
> > 0xC0000001 EDX bits 0 (SM2) and 1 (SM2_EN).
> >
> > The SM2 instruction (encoding F2 0F A6 C0) implements the SM2
> > elliptic-curve public-key cryptography algorithm specified in
> > GM/T 0003-2012; the hardware-level behavior is documented in the
> > Zhaoxin GMI Instruction Set Reference, chapter 1 ("SM2"). The
> > instruction multiplexes its sub-functions on the RDX[5:0] control
> > word: encryption (subsection 1.1), decryption (1.2), signing (1.3),
> > signature verification (1.4), the three key-exchange sub-operations
> > of section 1.5 (1.5.1 SM2 key-pair generation, which the spec also
> > uses for the initiator's ephemeral key; 1.5.2 responder shared-key
> > derivation; 1.5.3 initiator shared-key derivation), and two
> > preprocess steps for identity and message hashing (1.6.1 and 1.6.2).
> >
> > The instruction is user-mode and available in all CPU modes, with no
> > associated MSR control. The SM2 and SM2_EN bits are redundant by
> > hardware design (set or cleared together) and both serve purely as
> > CPUID-level feature-presence reporting flags requiring no KVM
> > emulation. Both bits are advertised because different software may
> > probe either one when checking for SM2 availability.
> >
> > Signed-off-by: Ewan Hai <ewandevelop@gmail.com>
> > ---
> >  arch/x86/kvm/cpuid.c         | 2 ++
> >  arch/x86/kvm/reverse_cpuid.h | 4 ++++
> >  2 files changed, 6 insertions(+)
> >
> > diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> > index e69156b54cff..1eb4b88aaa80 100644
> > --- a/arch/x86/kvm/cpuid.c
> > +++ b/arch/x86/kvm/cpuid.c
> > @@ -1272,6 +1272,8 @@ void kvm_initialize_cpu_caps(void)
> >               kvm_cpu_cap_set(X86_FEATURE_NULL_SEL_CLR_BASE);
> >
> >       kvm_cpu_cap_init(CPUID_C000_0001_EDX,
> > +             F(SM2),
> > +             F(SM2_EN),
> >               F(XSTORE),
> >               F(XSTORE_EN),
> >               F(XCRYPT),
> > diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.=
h
> > index 657f5f743ed9..7b55110cc046 100644
> > --- a/arch/x86/kvm/reverse_cpuid.h
> > +++ b/arch/x86/kvm/reverse_cpuid.h
> > @@ -76,6 +76,10 @@
> >  #define KVM_X86_FEATURE_TSA_SQ_NO    KVM_X86_FEATURE(CPUID_8000_0021_E=
CX, 1)
> >  #define KVM_X86_FEATURE_TSA_L1_NO    KVM_X86_FEATURE(CPUID_8000_0021_E=
CX, 2)
> >
> > +/* Zhaoxin/Centaur sub-features, CPUID level 0xC0000001 (EDX) */
> > +#define X86_FEATURE_SM2                      KVM_X86_FEATURE(CPUID_C00=
0_0001_EDX, 0)
> > +#define X86_FEATURE_SM2_EN           KVM_X86_FEATURE(CPUID_C000_0001_E=
DX, 1)
>
> Are these new bits really KVM-only feature bits?
>
> KVM_X86_FEATURE() is used for the features either scattered by cpufeature=
s.h
> or features that are 100% KVM-only.
>
> Kernel already has a feature word CPUID_C000_0001_EDX defined for
> CPUID 0xC0000001 (EDX). I think these new feature bits should be put toge=
ther
> with the existing ones (i.e. X86_FEATURE_XSTORE, ..., X86_FEATURE_PMM_EN)=
 in
> cpufeatures.h.
>
> Same for the other patches.
>

Thanks for the review.

Some history that might help. We tried the cpufeatures.h approach
back in April 2023:

https://lore.kernel.org/all/20230414095334.8743-1-TonyWWang-oc@zhaoxin.com/

That didn't go in. The pushback then was that cpufeatures.h
additions should come with an in-kernel user of the feature, not
just to expose a bit. Nothing under drivers/crypto/ or lib/crypto/
calls these instructions, and we don't have a kernel user lined up.
They're unprivileged, and the practical pattern is host/guest user
space probing CPUID directly and calling them inline. OpenSSL's
PadLock engine does exactly this today for XCRYPT/XSHA, and the new
bits would be used the same way.

That's why we ended up in reverse_cpuid.h, reading "no in-kernel
consumer" as the line between the two headers.

If the rule has shifted and you'd rather see these in cpufeatures.h
next to the existing word-5 entries, we can respin as v2.

>
> > +
> >  struct cpuid_reg {
> >       u32 function;
> >       u32 index;
>
