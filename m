Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FB137C922
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 20:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781122593; cv=pass; b=Q16TzoeAIWEepW7hLe9Q9gg2i53u9LSSY/EzmmlelwibHfQ6D6X8UevW+wtkSf2Mp5vgyRDzWFjT1aZyqIsIHe6MGHz2ZLphXpPaZiKdJe2nyDju9Qpb8daB+YIXtuXQPwehY3ixUb+UqWM/By+8rqOah0SXvHhPFTOcW8KjFEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781122593; c=relaxed/simple;
	bh=72mJCZ5KYYsVgkuAU6zlxPtbNTq33Q6bG2i5dEnXg4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k7C+qed3zQzjIpSDO17ijEz3uANN0RSJ7oO1RdxzDzg+xYiRnIG1MiFK9MPJgwYFrez9OnX35MX2jBFPy2YWjm86UZK2iX2zMkJik0J+xFWrjqMnd5JXFQQcjvTwCGaYee0covI+nA3gusGHtcAAoNw9QW1SpjNcNGlpRWSAxqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RDnJ7OhR; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RDnJ7OhR"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-396775c26f9so65727431fa.3
        for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 13:16:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781122590; cv=none;
        d=google.com; s=arc-20240605;
        b=PJv35cfR4uqLxhz+Qkt10l3Gi0RC5tvNCk/pSJ3L0nwvjGXnRZSlc7qKMROgbsV96x
         MO8439izxuoyB/8RMdzmPDVzcBtoUUW2YpBXo7DMQJMqGRrb1RoXVT6i4vCyLx2qvd6i
         57YBzlSeew6RQ/onveJny2DAAbgOWKM6rGEeTUFIhruiIL97k+j0b5BwtNSzEYc6a7Aj
         tPO4W8ZkgRstyDE7Lfz0SkFc5wD+dF8aClPm4nMV3y4OtPBXIUIsrTXSszdQ7UyFVVe3
         yz8ljoQYBzfOuUa5g7ooFocONxQL2bnnGtgBZ6AkSmb7tNj3i725j0MrNN4ypqiEXswb
         KoEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gDuIdBL6V7SP+lBacx19DNCO4e4v3ySUd9kgTjKOFe4=;
        fh=C2xh3YVnUNL6P4i9A8aC68LwT3d9eQJUNliVQqNYElY=;
        b=ATBTIRR2vUDFFoMqhb0isHTUF/7HWXcVd7MrtHCBYp5tua0fNCkWXkjoALluWfbTgf
         BcZTNBBRnbMgfTA1klUMT36xPHDnrjrdt/dBi9DxU2kwv4RklECHpSzv8UxVVS7eXe9G
         0yn5XKo5PrifTS63whZ5NXQbud4jX5KTWb4AQE/GB2iCJKZmmbvKVkozaxH0sPfNLlRo
         k36S+qeq2lo1+4DeMVPOio6TreD58Qo6s83VCOGOsATXkRW1qKoJxCJr/30n9Usxa7aW
         IPU9CXQwqfYJ0DxeY2/cW1EDlmqHIYRR+vj8Tbyc6IXk7hyVxt5KswsEecrz07OHTwDy
         wODg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781122590; x=1781727390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDuIdBL6V7SP+lBacx19DNCO4e4v3ySUd9kgTjKOFe4=;
        b=RDnJ7OhR11kO2ldrzgI5ZPGtzo3VAxKEC0nQ9J+4J6EzrAobJ7j5UgplBSSIPWO0Tq
         wjzcETU9YhfHUKdzqv+WjL+7XOTMjUYsIevpiUUFcGTI5LYb1GhV1VaRXRSbuIze9NMC
         a1YIgfMHlSmipqUdQTJ9dMP7Lzj0uT4ltnTOP7S7FFB4MFF09RfwypbRGCFKG1Mc6jvT
         USVQ9nL//Nzx4rXDr+fFq3VhCYc2skiCimVNtaYMFp+MBCgeHCf/4o5GOZ35JtrD36RS
         xeyvkpflDApd9E5fJs8XIAyZbtlcyZ8ktrd9UykfQQaUUU5rVWScDlodDUE6n+FDwiS0
         WhrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781122590; x=1781727390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gDuIdBL6V7SP+lBacx19DNCO4e4v3ySUd9kgTjKOFe4=;
        b=XrULsEi/CvcfHY737oAgASz90Qrj8suVrwkHyvX7uDRmmT6ZkO/avW0s4JaznFXnrM
         1OVn1FdEVuU3DRMEv/go0TSu0UqXTT8nwfZJGbtBJpzBhcLij7rlv0JaKGLUw0HukV/k
         g8n2iv9ZnSPKVgNi7TIlrDzLrfvpp9s0pYJGyu4I7ibc0Ws2o4y8/Z+F3NcyQ9fphdus
         VbYSJ3cqtLbX15khmHDPUhw2fJ5GJSKi53W320g1jjbyVvuX9QslEIzKj+5qDXUjH17P
         AWdOmilKJhByIq4z2SBHvVyLct+ea2l+HdHABgfXNvEBY6efmAm+s2JgBcyg0+njiH3+
         jxKA==
X-Forwarded-Encrypted: i=1; AFNElJ/npRj/fSc/uNQrJGruVFHZgk81Gx7R+hIwQRTqUgpSm0w/4dcb9vzECipVpxDXHSKT15o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTgXrMdExlPNY4KGuaIICQlyciny5HGpUb+QAFcGohnEleInz8
	StLu+fDkiq3m2ZRPqkfnbZDRwtJx7YZ0Cd6v5crMH8TqSX/8sbWp1kV9f4qtpvKcd0HyXNnsppX
	PdatkJl7O5DcVbT300HZNyRtcwfxbA/5sbpI3VWkD
X-Gm-Gg: Acq92OHseaQQuj1st9JmMQWzbfQ87SwVDQzGDGI+g7YguksthuIqzi7gHz8Y40Gn89K
	XrbTmrfYi3IXXAE+Ld7REv0Z4bJuhI5ueR6urThQwCLvoK7IfJMFYVf0VsPl1tuKisZykpGmze/
	hiAKkxiZwutbxI3aFo6YD2GoyHSe4i4oDVLUkrQI1fw2flpZQRyulxOK9RNVmNhnB+zwnYIiwNN
	Vmq3Tz0mYg4uEj/rlYYHh4aGuxhEYQwEOhbzt/4B2/lvNzJ3xGvoG8Of4LuZozaoPOw7bAPtn/+
	eF8fp+5+P77CtLtTNw==
X-Received: by 2002:a2e:be28:0:b0:394:8fc:8c44 with SMTP id
 38308e7fff4ca-396d05b79d6mr69423151fa.0.1781122589145; Wed, 10 Jun 2026
 13:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610005338.2967132-2-seanjc@google.com> <20260610010314.DB8861F00893@smtp.kernel.org>
 <aim4lld49oqLrthg@google.com> <ainFwSTb5-8itT9y@google.com>
In-Reply-To: <ainFwSTb5-8itT9y@google.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 10 Jun 2026 13:15:38 -0700
X-Gm-Features: AVVi8Ceu1fH4ea1Sf9BGjtK5ZsWJ_KP_7z1Uoi3G2FEJ6paSuzfa9CjW3fkYlgk
Message-ID: <CALzav=fUfhGP-DMsDR=4ZX2Cap=-L=c-1kwxTaUxSdknC_ir5Q@mail.gmail.com>
Subject: Re: [PATCH v6 01/18] KVM: selftests: Build and link
 selftests/vfio/lib into KVM selftests
To: Sean Christopherson <seanjc@google.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org, 
	Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 1:15=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2026-06-10 12:18 PM, Sean Christopherson wrote:
> > On Wed, Jun 10, 2026, sashiko-bot@kernel.org wrote:
> > > > diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testi=
ng/selftests/kvm/Makefile.kvm
> > > > index e0ddd3ff9472d..14316358fd9fb 100644
> > > > --- a/tools/testing/selftests/kvm/Makefile.kvm
> > > > +++ b/tools/testing/selftests/kvm/Makefile.kvm
> > > > @@ -257,6 +257,7 @@ OVERRIDE_TARGETS =3D 1
> > > >  # which causes the environment variable to override the makefile).
> > > >  include ../lib.mk
> > > >  include ../cgroup/lib/libcgroup.mk
> > > > +include ../vfio/lib/libvfio.mk
> > >
> > > [Severity: Low]
> > > Does including libvfio.mk here break the "make clean all" sequence fo=
r KVM
> > > selftests?
> >
> > David and/or Josh, can you verify whether Sashiko is hallucinating or h=
as a
> > legitimate concern?
>
> That is a legitimate bug in libvfio.mk. Want me to send a separate patch
> to fix (see below) or do you want to include as part of your series?
>
> diff --git a/tools/testing/selftests/vfio/lib/libvfio.mk b/tools/testing/=
selftests/vfio/lib/libvfio.mk
> index 9f47bceed16f..1f1ab180f42d 100644
> --- a/tools/testing/selftests/vfio/lib/libvfio.mk
> +++ b/tools/testing/selftests/vfio/lib/libvfio.mk
> @@ -21,9 +21,12 @@ LIBVFIO_O :=3D $(patsubst %.c, $(LIBVFIO_OUTPUT)/%.o, =
$(LIBVFIO_C))
>  LIBVFIO_O_DIRS :=3D $(shell dirname $(LIBVFIO_O) | uniq)
>  $(shell mkdir -p $(LIBVFIO_O_DIRS))

(Forgot to delete this line but you get the idea.)

>
> +$(LIBVFIO_O_DIRS):
> +       mkdir -p $@
> +
>  CFLAGS +=3D -I$(LIBVFIO_SRCDIR)/include
>
> -$(LIBVFIO_O): $(LIBVFIO_OUTPUT)/%.o : $(LIBVFIO_SRCDIR)/%.c
> +$(LIBVFIO_O): $(LIBVFIO_OUTPUT)/%.o : $(LIBVFIO_SRCDIR)/%.c $(LIBVFIO_O_=
DIRS)
>         $(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
>
>  EXTRA_CLEAN +=3D $(LIBVFIO_OUTPUT)
>
