Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B881D6DB5
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 16:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781193822; cv=pass; b=JVAYZaLa7b5lIrYtgOp9XV2Lzp5HCkql45iUuQH4sTj7qa9HAJYXZZCn3M2mXDksgOPlhpJLkx+zis7LvMl6MidaOPm9IBnBEoCjrn7g7U8W8Qaa3/TlOWd4djdGsnXVJf4mNQRXkC7LGqOWByhnXmCJRv9nbfeGNAowMlJ90Nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781193822; c=relaxed/simple;
	bh=E/uSsonBxsG2I8HRk/4lpDWc2bqhqamee4qK2DRuzas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GHhIOyBvPppyHEStAR8NzfAm0b46JiwS5DZNOnDe2lTVMPWbQcTL+yOed+gM6WqbYOGY9WSZISyTLqtr9Gomqov9k1N7iujzhYQ9M1SQhOY7xl8CdE6HiYiZu0R5WIxsj0Z2TV60PsP8mxsDpe8ayvYzK1siKXbfbJQRIo/guGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p4wzYIDA; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p4wzYIDA"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-137335bc3caso10513001c88.0
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 09:03:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781193820; cv=none;
        d=google.com; s=arc-20240605;
        b=j4li7FlIqpeT7hR302T+MBRePMrD6UaJS/E//uXbRnIUm5CT5XrViZBk7FLxGMovlb
         c8M77uVwomJ55QahV41AF0bKLI3kk8gYyVbjI1MdTYmlihgFBN2lfuJenCjmwQBLWRg3
         ldFPmcmtSMS5lDQfbqSwfhx2e9PUy2u6k4gPpxiM/xogVnF0+9XpzIskFUWnYkDNDkLR
         EKdmk7kVoC8Y9aR3klBpUSylGAirPxOCuer1OgDvVRmCWAQ/M18w7tmkl+hrfBOTpORG
         j/G24r4bu7yZ94HOYPS+C251DZJgzmmfS1ZrTLMwaulMjisBNXkdciaexeHTGq93sbKl
         JBsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0pcWDynRbSH5YpKeYd1DMK6rF4S1uoY1j6VB0VFhuRk=;
        fh=rFTm1jHhkN2kZVhhUF7vSCmL2rFO437D/Mq1ArX5vK4=;
        b=G4oB5zHyvPBOz9pCjARNqyts7DeuMxPoqD8ta/fjfOhF9qzgc+ZwHC0sD4gPFvLhQz
         v4tx21cQW2XnptAAbEEBcwJ20rV8GFXSO5TvFSMO5b/4C65ocMSJVzTWt0BNAE35SfAT
         tAgVvm5nrgTj/0D1S3N001qNEg+mILZKyhuTvGQvXVHr7eXKwnuIwtsTQSRe/N6xuK4V
         r0fD5X3jKrCHNutVN2adM4AAa9mgAKdDik0wXiNzWlI8vlWYiyv4rp6zMJUqrr+ufOgR
         aZL6wkVvgpCp0Y8bqF9eBwDsrRVJwP6S42XjectV7ppo2X82KkKH4QzHJfKQiCJPmNaS
         Vh2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781193820; x=1781798620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0pcWDynRbSH5YpKeYd1DMK6rF4S1uoY1j6VB0VFhuRk=;
        b=p4wzYIDAHiVyGhFdup5xCgSsv/vOoRAqB4CkQF2Vmdqi/Tjzyf/6yrX0Wc1PRj7hKQ
         yTSaA7BsR2hLMwac6aCkm8PLDTsQ8t1KiSz8/nnh1o6ps7AhTbc33th730lpfn5GPAYa
         RWQeVkSNCrX7iR7Yj7GVoWVqPX88pVoZXfGZW6ByhIC40Ui/1HRu6vftC0G+GUldNw6l
         /q4CjK/1FTOF3vF7UOuAp8tw5ABNVZly8Y9PaIPF77knPLHDU6Gojh0jV4mfXKzdUAVN
         gtZOpkF/MmsngNSRgcuj9noXF45V/YQEMIe2o5IxSzhNRLG37gGyZ8dt9lW/mpNNBXud
         9vLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781193820; x=1781798620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0pcWDynRbSH5YpKeYd1DMK6rF4S1uoY1j6VB0VFhuRk=;
        b=IMAq244cBHPfA5K36+eB2+ESB9vducGXs2psTfpNVhPPd8eKmWUDFk1rAWepUTZvj4
         iZ8KdKxFGa8/wvoLpE9+ZDKR4UnOZ+O6PySm+gMuGTydMPbX8rv7EGMzLZiSOXYI/hE2
         WxW6GQx37GW79YlUiqJqFczSTjM+kAi7AFnmo8O44K7A9lrYaWzIwg+roIiA8EYdfTnH
         Y5ApvabWYuNwdGs0FUmH5YPa7eigmdvOYPGcCM27ENVs9CrPQ/ue7ZznwKSaQn/MfRp3
         OMvWq6bl1c29lhAIE10ISTuDhTIIfJXtx4UV+ywNfdQ8M6V8Jp6nVN7Aon0FMA93S9PZ
         o+kQ==
X-Forwarded-Encrypted: i=1; AFNElJ/eA8T8yPWlAjmjuDeU0n9XobKlkm5KUFkj1v9JCK21br9ytApjKNfEftdwb6Er3pqxTio=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx7b16bpODlHmNeUGkCFjNkhyMc7Exv6sL5HWTATY0aT9VrjGd
	ITO+feDRhozGMbEg4FHJqt8cvIPdlc+PQlQguBUPyGtBsRJC7S21VYmtdAZKqpzqLeT4c+TNcwG
	Rq1O99VT2aQoasW2fZTtl8p9XFs+lYaLoEYAGl/ao
X-Gm-Gg: Acq92OFkEt1+gQHOxFiZO6WGIb5qy+4Ksl5mq2AjPh61pLqYDrNcLbxiy1faNvwVUCk
	QZta3HVwO6ITVfREkm+l0ozg/peoKS7jgWc0ZXRsm7VCIiIICgK3GyHmGqftu8nOnWd1XJZOA+x
	wBLJD/d13npHLsSQfqfJZ8iBbVJNN289Q6RUs1R7lvPBYFCM2ltDh3CxDbLIgZx4cvrXR8OIgH4
	xDik0YPeUlfWgZAgLrxpPegbC/rOQxPPCEFkJK14IeVhZUbfoNotlWqVnKmyype36SwMMxr2Meg
	TZYSBNc=
X-Received: by 2002:a05:7022:403:b0:137:64ad:76d0 with SMTP id
 a92af1059eb24-1384211e6admr2000029c88.7.1781193818067; Thu, 11 Jun 2026
 09:03:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610005338.2967132-2-seanjc@google.com> <20260610010314.DB8861F00893@smtp.kernel.org>
 <aim4lld49oqLrthg@google.com> <ainFwSTb5-8itT9y@google.com>
 <CALzav=fUfhGP-DMsDR=4ZX2Cap=-L=c-1kwxTaUxSdknC_ir5Q@mail.gmail.com> <aioBW3ljMyYhYK_4@google.com>
In-Reply-To: <aioBW3ljMyYhYK_4@google.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 11 Jun 2026 09:03:10 -0700
X-Gm-Features: AVVi8CerQa96lyFJIrqKoChRgSwkV-xrLrw7UevCQeX9WtaD36Cu8yeTh5qkMkE
Message-ID: <CALzav=d4q+ckkSUoZKhWWW+LiGpwOE7yAKyDmrLhmGrmh4kLmA@mail.gmail.com>
Subject: Re: [PATCH v6 01/18] KVM: selftests: Build and link
 selftests/vfio/lib into KVM selftests
To: Sean Christopherson <seanjc@google.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org, 
	Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 5:29=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Wed, Jun 10, 2026, David Matlack wrote:
> > On Wed, Jun 10, 2026 at 1:15=E2=80=AFPM David Matlack <dmatlack@google.=
com> wrote:
> > >
> > > On 2026-06-10 12:18 PM, Sean Christopherson wrote:
> > > > On Wed, Jun 10, 2026, sashiko-bot@kernel.org wrote:
> > > > > > diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/t=
esting/selftests/kvm/Makefile.kvm
> > > > > > index e0ddd3ff9472d..14316358fd9fb 100644
> > > > > > --- a/tools/testing/selftests/kvm/Makefile.kvm
> > > > > > +++ b/tools/testing/selftests/kvm/Makefile.kvm
> > > > > > @@ -257,6 +257,7 @@ OVERRIDE_TARGETS =3D 1
> > > > > >  # which causes the environment variable to override the makefi=
le).
> > > > > >  include ../lib.mk
> > > > > >  include ../cgroup/lib/libcgroup.mk
> > > > > > +include ../vfio/lib/libvfio.mk
> > > > >
> > > > > [Severity: Low]
> > > > > Does including libvfio.mk here break the "make clean all" sequenc=
e for KVM
> > > > > selftests?
> > > >
> > > > David and/or Josh, can you verify whether Sashiko is hallucinating =
or has a
> > > > legitimate concern?
> > >
> > > That is a legitimate bug in libvfio.mk. Want me to send a separate pa=
tch
> > > to fix (see below) or do you want to include as part of your series?
>
> If the bug can be hit without this series, send a separate patch.  If it'=
s only
> relevant once this series lands, probably makes sense to include it here?

This bug affects anyone that include libvfio.mk, so
tools/testing/selftests/vfio is also affected. I'll send a separate
patch. Thanks.
