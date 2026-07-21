Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC4B3161BF
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784653519; cv=none; b=JT7z2ACNozs0HgI8jfZJnkmtq/PDzx0o1IglOPu82jm8aGzCvJVG2P6r/nu/KU7OGHZvvdKfzJlpgVOlYc2vkJYilBT2klYw9PZFU4tHnQoA7fTeDEeBgRUNG5TNHqZqMjJ0WIlRugBItidf8McPG9uGUN4X9Ov/ct3EjKRhxsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784653519; c=relaxed/simple;
	bh=86doQxjvvmHu0NHEyunCYya4Z9MmxCNH9DQpD10H/v4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZTiDMBPLKKjNuYkzh3zCLC1NAvrQ4LiyVALoI1u1hi+9C+EhqLk3sC1uEfw9W8GrKeO2gURxsg2hpbpbpUFIhgTAXHB7flv1G6O1Jifd9hVDhH0vF4bXibmUVqh1oJPClP+7Ep8dRnjrfAmSafqsBFK6GuIjjnQwzuC73A7YP14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NXOz20Ch; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NXOz20Ch"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e2237bc43so13271160a91.1
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 10:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784653517; x=1785258317; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GzQBL2aNFImRgoUYSHTdbAgRa66XmOoIgdSc5UWwGek=;
        b=NXOz20Ch5aqo1++LilRRlvrpyu2TAIOqg1hbZAyhRTPOIEkr2INQw6U2BzQlaFaCJz
         pQUwTe7XWDBJEYTOhM2sgqjRyDj9ZppOO7OkODeKiIZ7fcjR3bAeDDXi5gjGm9Lb8pyz
         KGuQBVIauP4rb0Hk2J1bJzuj92ZGh07eHUsRFbUWb1IX37dFPPoVmbEO+hYquvIsTMX4
         ivgzrxu6tJ5y93aOV8fcDAjufljTPkpoAcwgvR9P4OC+ejrQixvKE13xZqHhqa88CpTQ
         gSbAN8G1bIrNQaWBiT7sqKbXjG092WsJLdi5N2ohcTkiJtUq2qg2OsLM8BXYBTXdudKe
         n9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784653517; x=1785258317;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GzQBL2aNFImRgoUYSHTdbAgRa66XmOoIgdSc5UWwGek=;
        b=oql1NVEkmWUlkCJAHiUcYX0Cc6zS3hybSruZjV+cCguiqXPVmMm2IIkvOPR24RMMSO
         ZfJFCinJE61w7YbblT1dqQ5iQ7u4NDBCWeXaQTWMS//tP/mOW+WTMEzFfU8yeMhE+v/s
         6Qj2M+E0gvqhry3vIgGeKe6YyU0WX/uyz44cpSdo1NFZs62ItUyf40g3QiFeqLQ7mum8
         VI1Dwtk6KIYfYRV/dZI8JI76roDpkmqZ3qu/rB+3v4mB9Q1cbzCWteom78zMpvdsvbHa
         +W1AXANTPTgQ3GCH9zWMkW0cxF3iAqo2IElRPJVfglmiITOYG5hPQ0OuKeRCAREcAZk8
         BKPA==
X-Forwarded-Encrypted: i=1; AHgh+RoX9QRbZVUyTtK+yxAFAznupVJJmPlMNyphdRmy50WGla5X98xnnvXWDzY/evRxzRCTRXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqIYHuTAdMWzzj/mJ5nAZQuD9pFxKenRE2YMEtF6JLjNrdu9qG
	uVkiRrDbCRe0i4r1qEY+oxy/ILaAjj1DhR/4/EyycJqt1Vi3T5+NREPNFjfesqu0yghSSu6yFEn
	jWCyCTw==
X-Received: from pjdn90.prod.google.com ([2002:a17:90a:2ce3:b0:37f:acb7:9d81])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d60f:b0:37e:b6a:6cdf
 with SMTP id 98e67ed59e1d1-38e4b538979mr19429131a91.20.1784653516620; Tue, 21
 Jul 2026 10:05:16 -0700 (PDT)
Date: Tue, 21 Jul 2026 10:05:16 -0700
In-Reply-To: <fab46e0b7217e9b712706074189f372f11c7ca19.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260720192221.72912-1-absandze@amazon.de> <f5552576fc749b4b453514f52921332cc104c6a6.camel@infradead.org>
 <al-isty0nYjQEwqH@google.com> <fab46e0b7217e9b712706074189f372f11c7ca19.camel@infradead.org>
Message-ID: <al-mzECrdUsy0ThI@google.com>
Subject: Re: [RFC PATCH 0/2] KVM: x86/pmu: Let userspace disable SW accounting
 of emulated instructions
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Luka Absandze <absandze@amazon.de>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Alexander Graf <graf@amazon.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026, David Woodhouse wrote:
> On Tue, 2026-07-21 at 09:47 -0700, Sean Christopherson wrote:
> > On Tue, Jul 21, 2026, David Woodhouse wrote:
> > > On Mon, 2026-07-20 at 19:22 +0000, Luka Absandze wrote:
> > > > On hosts that run guests with an *emulated* vPMU -- guest PMU MSR
> > > > accesses trap into KVM and each guest counter is backed by a host
> > > > perf_event -- the per-emulated-instruction PMU accounting added by =
commit
> > > > 9cd803d496e7 ("KVM: x86: Update vPMCs when retiring instructions") =
is
> > > > pathologically expensive.
> > >=20
> > > Given that the guest PMU MSR accesses are trapped... is there a reaso=
n
> > > we can't fold a *separate* count of emulated instructions into the
> > > value we return to the guest?
> > >=20
> > > I guess the overflow would come late... but isn't that tolerable?=20
> >=20
> > Like ignoring emulated instructions entirely, it probably depends on th=
e guest.
> >=20
> > > And we could probably impose a limit on how large the addend could be=
 =E2=80=94 even
> > > if we only reprogram the PMU once every 100 times, that's still a win=
?
> >=20
> > Hmm, yeah, that'd be better than ignoring emulated instruction entirely=
, and
> > would give userspace far better control over how shoddy KVM's emulation=
 is.=C2=A0 Off
> > the cuff, the change would be fairly trivial too?=C2=A0 E.g.
> >=20
> > diff --git arch/x86/kvm/pmu.c arch/x86/kvm/pmu.c
> > index 7f777049d328..c5f436c6f83f 100644
> > --- arch/x86/kvm/pmu.c
> > +++ arch/x86/kvm/pmu.c
> > @@ -1084,7 +1084,8 @@ static void kvm_pmu_incr_counter(struct kvm_pmc *=
pmc)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!kvm_vcpu_has_mediated_p=
mu(vcpu)) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 pmc->emulated_counter++;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 kvm_pmu_request_counter_reprogram(pmc);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (pmc->emulated_counter > pmu_something_something_toleran=
ce)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvm_pmu_req=
uest_counter_reprogram(pmc);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
>=20
> We also want to add the same delta when the the guest reads the counter?

Isn't that already handled by pmc_read_counter()?  Or am I misunderstanding=
 the
concern?

  static inline u64 pmc_read_counter(struct kvm_pmc *pmc)
  {
	u64 counter, enabled, running;

	if (kvm_vcpu_has_mediated_pmu(pmc->vcpu))
		return pmc->counter & pmc_bitmask(pmc);

	counter =3D pmc->counter + pmc->emulated_counter;  <=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

	if (pmc->perf_event && !pmc->is_paused)
		counter +=3D perf_event_read_value(pmc->perf_event,
						 &enabled, &running);
	/* FIXME: Scaling needed? */
	return counter & pmc_bitmask(pmc);
  }
