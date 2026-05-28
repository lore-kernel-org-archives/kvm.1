Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6166829E0F6
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 14:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779978030; cv=pass; b=G94cWl2zMAsq8DJNsy3QZR3iTtSagbKXb4uyjE/HEJShh5rKp4JKQWijHU3Ee/OPASkMzvhOGnx+eJyqk2tHMFYsVULMYOTABl4N9m911eFNEArEihCt+VPKsJp5rb+/R+VgDFLxeBwzogG6goTrbwhpAAJ+XU+HKyt4PzeJjoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779978030; c=relaxed/simple;
	bh=XCaJTjjoXzRW0BU+OoHvqtNVu7svIWiaq9STd3qU94A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dSFSZGJOdOx1a1vFTWEPYUU8E3NosuZaM0/+2hciZ0X03ZQDN8RYm8+JRgzb1FyIq2Mly+dbJ2i6NmBDleXgIWZdjdofh4hqLczjdJxEPe2UnysVRuVQKuQZglIazYV1+HwNm+XgTzXrzCBHb3eMOhDN3wXaaxXILFP6IwFn3G4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s1q7QSpD; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s1q7QSpD"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-671588ab0cfso117a12.1
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 07:20:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779978028; cv=none;
        d=google.com; s=arc-20240605;
        b=aR1Hbgzo0ruVr1kAU19Hn6cGDifKIFYpGOJaUdOut3gTd7EANJGbsWc3W2Z5EWgij+
         xnWUdPkJ0FuZDhAAdvUKdBTOU1H18fMDWfJLS0S7M/em9XIm00WTFrgkeTJSJmqosuEP
         i7zZ1bb8pt3Hv0Cg6aBai/bO8ckYhOYG9kCRPnkxWUJI7DPuUU1O3ZMb5+rOYS4b4SGq
         C89Dz1vFUvmFfMGir5vnKJvsks7KiuZn8jLAz9kVQwMb7CpaTl6Y1lRSThUvwgplg02a
         Xa/iFG/cHxBplVitIxXeH9OrOvJ90pVZoKPTbmK2yA9AEzbR4h/R6570Bbd5Bw0hcd5d
         dLXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4/BgxV4r2xUtkfEhT3cv7u/G3AQBhHvkVg6ydW30vSQ=;
        fh=5uhD1opZDt1dnKIbmRIVD98oE3ip50TcrM2wwNurIQ8=;
        b=V73YH9N9QPwcV8ZIxo0XRSESdVYV62vbnNI+r8VmYpBUnajVqV6aFJEQefW/pbCODR
         yJanQh+kXFE1Xa41IcBbNLA03Wk4oFDdi+K9veQQevnmOxY6Tsd/qICb90H66pVaBJyf
         3Q5K5QbTOx3tQLyLzRrbBdKqiEBPxtva4JhnSduV9OYc+adI8t+EvSWNZy4rrKND5pDp
         alQuH6bURDLHawYNTE4nU4PBwJWxZ6ulK2D7GdwwbB/GbNZYwwdTGrEgxCiVydgE1Fvw
         I6s+5TUflO6C7q4W2O960VOlV+lsEgu2pTx5ZQuzYEYKCYSTYTTyUU0CQXtqCL45eEKe
         L0Wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779978028; x=1780582828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/BgxV4r2xUtkfEhT3cv7u/G3AQBhHvkVg6ydW30vSQ=;
        b=s1q7QSpDQri7mMgj/Riom0FOMyE12QMtLVdwNsIfp912AE7G1+522kwTPG2orfR5oH
         zzB5FOZI6NNsn6vgabZFcDdDdrk2fzJEYeqnlinHrssb2hNGxLy3jquZheBMnJT9NLo7
         3LgKJR8VQSAY5ltYEq8wGSdvioZsby1GOYptGrkforMYJ6S8+ogns8pjE69wwUYyjO7O
         jjvAwp1Ikz9H2OyveWdyrFpRdiJWmhPrIxp40is+S4x4x4qisYezix3LBhZ8Q+qrSbzz
         dClFSp3Cr5miG4H7MiNo/YNPQUC/rk7uf0EL//iPvQY9f/L5oAgDr0cC342rUB4CRoK0
         nfkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779978028; x=1780582828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4/BgxV4r2xUtkfEhT3cv7u/G3AQBhHvkVg6ydW30vSQ=;
        b=F+olUa7vVPI3gg8NEPzTwFbOcRJo/gOo9vRubBsxe2J6VujHVrJQB4nLfbCTU9GTW0
         uCBXvBpxLMUqVVSulVuk8VlKg5a8fxwNWvakUqZvzpVOjJlloopucKRUSXiXg13tC90C
         TarGBERfB3bJFwXIj1QP9wrPQcCpNSQetWz6eXEvXqQv7iN754eLX28xPUNhtCBkA/+t
         F2rucLM+fzBQ0bDytTCAvBSjgrw7PZP9DZZpXZTR0pJ66ebFkItesRIXLmblK2F51UTB
         wEw+JWR6xYruSq6eDUPpofNo0ua4T/9JE0kpvCtPyjie3C8njKePhyoUPMQN6hucBiMU
         XO4w==
X-Forwarded-Encrypted: i=1; AFNElJ8u4xHg5T/i0TGaK6RD5uq2g7dH2ELi5pGUknjfvvzMyUlT5S2Gh5Xp0MsESD3x6GITK4s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo1Xx/xSw8pdvkPvqveaU4B5FhRNiklUECiU5JYMFP99yPrnG5
	Ps96pXM73AFBcCgIuY4oL7ZYhU3XvzSjxCnTfSvakTqPsQR3oGelewkIPCwG1+Kq6xNVIuwaVJc
	4OL4gicgk97kBL3xvFUgpX2yezPXdYYpzdWu5sl+y
X-Gm-Gg: Acq92OEMjBr1sNg5+zauRpLQJUYAu4Q+nFdpC5RtPyV4SapHDeZEMuOJ5HuaCRg9yeB
	lORUJIWO8/IvBpj57arSiqwKF1MacQYh1k60EdPNKz0f+Z/39iliToB1fdxJiqOHG/vIvipxr37
	niPOVSyxhCIQV3fP7TUNShrGmU/VHuoC1usXuoxDDSfDQa8GzZ5eYcYueM5DnlO0CwycTnWCMab
	gZ9MRA5E713NUpxQSOXB+OEt8MuottMkpIYva7gqC+Fiorc/UqpZ+4a8xf9h3NqAuMaGHMpZj9U
	JgbJjxMLBQUs8KLAzQ==
X-Received: by 2002:aa7:d655:0:b0:671:4bfd:e074 with SMTP id
 4fb4d7f45d1cf-68b452ef798mr24852a12.9.1779978027233; Thu, 28 May 2026
 07:20:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527174347.2356165-1-jmattson@google.com> <20260527174347.2356165-2-jmattson@google.com>
 <20260528091357.GB343181@noisy.programming.kicks-ass.net>
In-Reply-To: <20260528091357.GB343181@noisy.programming.kicks-ass.net>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 28 May 2026 07:20:15 -0700
X-Gm-Features: AVHnY4JBbRjeobtGGSawQVKaiKB6lyL2sv8vmrUzchZ1xrSrD2h3ZYNrMd9jIgw
Message-ID: <CALMp9eS5xT2PKHW4RWNsY0d9jKpA_xOrOpyZjY8CT6E80W-42w@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] KVM: x86: Consolidate CPUID fault handling for
 emulator and interception logic
To: Peter Zijlstra <peterz@infradead.org>
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	shuah@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, ctpence@google.com, David.Kaplan@amd.com, 
	binbin.wu@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 2:14=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, May 27, 2026 at 10:43:43AM -0700, Jim Mattson wrote:
>
> > [jim: Add EXPORT_STATIC_CALL_GPL(kvm_x86_get_cpl) so that KVM vendor
> > modules can call kvm_is_cpuid_allowed(). Fix typo in commit message.]
>
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 1578c0ecbbd1..72bd3cddb026 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -151,6 +151,7 @@ struct kvm_x86_ops kvm_x86_ops __read_mostly;
> >  #include <asm/kvm-x86-ops.h>
> >  EXPORT_STATIC_CALL_GPL(kvm_x86_get_cs_db_l_bits);
> >  EXPORT_STATIC_CALL_GPL(kvm_x86_cache_reg);
> > +EXPORT_STATIC_CALL_GPL(kvm_x86_get_cpl);
>
> Are you aware of the distinction between EXPORT_STATIC_CALL_GPL() and
> EXPORT_STATIC_CALL_TRAMP_GPL() ?

I am now. :)

> Specifically, the former allows modules to do static_call_update(),
> while the latter does not. Whenever possible use the TRAMP thing, this
> allows modules to *call* the static_call, but not to redirect it.

Sean - Can you fix this up when you apply it, or do you want a v5?
