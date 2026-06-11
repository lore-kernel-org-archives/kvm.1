Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5C01BC2A
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 00:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781137758; cv=none; b=ci51K0hjcij4wRA5QA4fBAp4LD5afAnfcan4Mj5sObXUxLpVgqiQegbmSW0ZKsTfWnY0xwmYjjY1rjDmIYN9NTdjJAj7HpkSM6bt4O8C6SXyYrAvumqFby8T7HMBxA93rKDZiKU7Zf7Uq74DbGWHTOPgSDfG3JAJLeOb4orRM5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781137758; c=relaxed/simple;
	bh=2Kkt9viOsN3O1d4LEosScFmjMs902DuhSOl3IEY1CzA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sOwBM+56/0uE0u11iUz6CBepSfEDxJudT1YCdeeNIY2dJxE1wlAFoEwbwDvUjgUaTkozgQp1aTtK59o9rGvvDwRcsttXPx1KmcCK4XBCIIXMa4Jd+SaUnLL4IhdfzTVKEg7gY1u+ZleKK6ZyDilDPDIVkZsbGPRQO/WLy6HvXmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YnQzWWFM; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YnQzWWFM"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf3636d6c0so76822095ad.2
        for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 17:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781137756; x=1781742556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2NwD8Mf/gk1EKado5QT6nhAxyYIwTLRf2g6c+x86yWU=;
        b=YnQzWWFMjiEPz+kBz3ipcMJUxVwyO2vyEO+yXzaYhHksrkO5XiHegvKFX6WPVuItKh
         uKn7M6u9UDM0ZKqWMcTFcV4SgpDyerFCS0WoC2wF3tSrC/Rtaals9vUCXxvus/99wd8m
         bfFAFr9oMI14T9jWqYPcoOypuAd9S1bU0FO37O/JlU67yqSVYy38A59ggCC5+3HkSl2t
         T8FwO7LAJV8B13TLQ/FC5nJz0JjuZq1WCU9UL4aPMZwDfgtAPdKSJYgxyoBgP3IWS6if
         9KarZNJ/38ICFoviXnADFGCLfULZtSoMedXRiBBOoQQwVs7GFQBv+kYEe+vIzi5wcvJM
         1GOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781137756; x=1781742556;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2NwD8Mf/gk1EKado5QT6nhAxyYIwTLRf2g6c+x86yWU=;
        b=eiCpxHDSCkDrjeEQkNCnFnu56ZCf5X8AmZRscj8xsFtBilMsqYFGq9K8yWjHbEUV3h
         S5stdAuhndaPDFkcHa7neRvVD7OBHNzuQUvMwFpmLk3cs7EDQBfCZ2WRdiDJ6QnStFSl
         I+LFqsPBo4pslKWqfY2gxd3Mvvv/hy6Pu6ogBlm5oaQmWQNqUVXCkS52MCqGQEYiDxke
         lDVbRAVjkoi1loABSOWZTP4rdN7iOh19fbUAft5RfxaHVLBF5OnliZuou7/EeEzN1CAt
         17Bp9uQBbwTMI7fnc7uXvRCCJmUNNATQAj+S6QNwOZkYA7oBjesoCDxHxy6evPkUVubA
         pPWg==
X-Forwarded-Encrypted: i=1; AFNElJ+2kFuFGb81oysupSxQv71+nNClpMInLE/pbrhWG7W6UTVne+DuyalvEziSiRbAr24bkqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMf7OmHzSekMQV7NLob0OQMOX2LN3AxRvk2cdiUfaoNkq71NR/
	jkhdLMp0lURvIWJXgxVdRIT21RinWEQ/Hnukk/UAVqnjFfFFaIisF4/CM1T3e2zbUzAiGigvcR9
	lTXdUTw==
X-Received: from plrx19.prod.google.com ([2002:a17:902:b413:b0:2bd:3dba:a4c5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4d2:b0:2bf:77b2:8b2d
 with SMTP id d9443c01a7336-2c2f334f0b4mr3193155ad.30.1781137755966; Wed, 10
 Jun 2026 17:29:15 -0700 (PDT)
Date: Wed, 10 Jun 2026 17:29:15 -0700
In-Reply-To: <CALzav=fUfhGP-DMsDR=4ZX2Cap=-L=c-1kwxTaUxSdknC_ir5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610005338.2967132-2-seanjc@google.com> <20260610010314.DB8861F00893@smtp.kernel.org>
 <aim4lld49oqLrthg@google.com> <ainFwSTb5-8itT9y@google.com> <CALzav=fUfhGP-DMsDR=4ZX2Cap=-L=c-1kwxTaUxSdknC_ir5Q@mail.gmail.com>
Message-ID: <aioBW3ljMyYhYK_4@google.com>
Subject: Re: [PATCH v6 01/18] KVM: selftests: Build and link
 selftests/vfio/lib into KVM selftests
From: Sean Christopherson <seanjc@google.com>
To: David Matlack <dmatlack@google.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org, 
	Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026, David Matlack wrote:
> On Wed, Jun 10, 2026 at 1:15=E2=80=AFPM David Matlack <dmatlack@google.co=
m> wrote:
> >
> > On 2026-06-10 12:18 PM, Sean Christopherson wrote:
> > > On Wed, Jun 10, 2026, sashiko-bot@kernel.org wrote:
> > > > > diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/tes=
ting/selftests/kvm/Makefile.kvm
> > > > > index e0ddd3ff9472d..14316358fd9fb 100644
> > > > > --- a/tools/testing/selftests/kvm/Makefile.kvm
> > > > > +++ b/tools/testing/selftests/kvm/Makefile.kvm
> > > > > @@ -257,6 +257,7 @@ OVERRIDE_TARGETS =3D 1
> > > > >  # which causes the environment variable to override the makefile=
).
> > > > >  include ../lib.mk
> > > > >  include ../cgroup/lib/libcgroup.mk
> > > > > +include ../vfio/lib/libvfio.mk
> > > >
> > > > [Severity: Low]
> > > > Does including libvfio.mk here break the "make clean all" sequence =
for KVM
> > > > selftests?
> > >
> > > David and/or Josh, can you verify whether Sashiko is hallucinating or=
 has a
> > > legitimate concern?
> >
> > That is a legitimate bug in libvfio.mk. Want me to send a separate patc=
h
> > to fix (see below) or do you want to include as part of your series?

If the bug can be hit without this series, send a separate patch.  If it's =
only
relevant once this series lands, probably makes sense to include it here?

> > diff --git a/tools/testing/selftests/vfio/lib/libvfio.mk b/tools/testin=
g/selftests/vfio/lib/libvfio.mk
> > index 9f47bceed16f..1f1ab180f42d 100644
> > --- a/tools/testing/selftests/vfio/lib/libvfio.mk
> > +++ b/tools/testing/selftests/vfio/lib/libvfio.mk
> > @@ -21,9 +21,12 @@ LIBVFIO_O :=3D $(patsubst %.c, $(LIBVFIO_OUTPUT)/%.o=
, $(LIBVFIO_C))
> >  LIBVFIO_O_DIRS :=3D $(shell dirname $(LIBVFIO_O) | uniq)
> >  $(shell mkdir -p $(LIBVFIO_O_DIRS))
>=20
> (Forgot to delete this line but you get the idea.)
>=20
> >
> > +$(LIBVFIO_O_DIRS):
> > +       mkdir -p $@
> > +
> >  CFLAGS +=3D -I$(LIBVFIO_SRCDIR)/include
> >
> > -$(LIBVFIO_O): $(LIBVFIO_OUTPUT)/%.o : $(LIBVFIO_SRCDIR)/%.c
> > +$(LIBVFIO_O): $(LIBVFIO_OUTPUT)/%.o : $(LIBVFIO_SRCDIR)/%.c $(LIBVFIO_=
O_DIRS)
> >         $(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
> >
> >  EXTRA_CLEAN +=3D $(LIBVFIO_OUTPUT)
> >
