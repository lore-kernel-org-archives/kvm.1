Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22ED925785C
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 18:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781546727; cv=none; b=DObhmZPkwOVqraiB3ymkUfqsvcJbqQTivihUOcCKCYs9edY6CGRDE0WIpe1GEWNK4zcdHzOLBpV/9miDut7jUL0Eyg/XhROf+jWcvjB34GzUbVQiOXAyons9pyErk/cGeTefPrq5+Hc+UEnSi6XU8kLpmo8jcA3RdbFdo1WYNC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781546727; c=relaxed/simple;
	bh=Q3hBpHkHVTB3fUN57F2KIk6HWmyph+J7Wwq6o4RRYZQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LIn0zM4OqlJH4AHh6fZTILup1pA7LPFuOFc19l1yBkzLTWzGipswu066Dc2QmAFhprChxI5S2dJDVFniL3An23B756JubRrz20ZoCENqNL9EtcDcBetXqcABZniA2bqg/cSIOMnem7kuLMMq3FHlGGELsyRaR/fd6aDdateeuqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I/EEEGrH; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I/EEEGrH"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8596e4272aso3873308a12.2
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 11:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781546725; x=1782151525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=horNH4nAIVX35HLRYM5nbtwV0BBsxMhLrFNMxatw39I=;
        b=I/EEEGrHdIRp4A+/JxndZk9yVTxtV6ZvgtFxcbCKJuRMmxHPDqp5dFemW7krGqR4Mm
         6RxbyqSYDqJVKQTskcmuFNqGNsHsjWXOYNxciPiHmz2KUqBAwaB3d1WD2ID5UAHxJRI+
         8zZGQriRuB9NFTnb57COWn3IPdHNqCgLgsfNAjQZ3IoXUKBwkNUwKmg2JrMiAzRJp6IC
         H0ipyfvwn14S8t0OFdc1dFYli9ezg8B0rjXtUehTX+fClIKWUyeAZEI2mHq4fn5eg4Q6
         /fwV4yZ1MrM7E94zIWtMf1+gCBVQG8JiLC7PEFN+NBJ4ALyL/EUEo0yec79XFhbnmMBJ
         +k8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781546725; x=1782151525;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=horNH4nAIVX35HLRYM5nbtwV0BBsxMhLrFNMxatw39I=;
        b=IBtt/fffEqEpCIf0OR9Xx44cAUZYZJsi4+B6s4SfD0vO817au4dSVBixXt93/fg2A6
         7XhzGvmyi+W+cspxH+kfbPUJVK9dKDiJKPuXfj4XZL5eWL/U3YxFoHlftJMmcOBjJVOt
         +I20g698cG7TnKqE3+1MJZsQOphVyp1J62tbiVA9KaUQPrE3h5eNfg1m7wkGMQaeTgoY
         Yr0TOtBaxpr6AaRMtBIUDcfQoDRGoL09y1SwnH13pF4y7P9uOm6DsXrXhDbXQUNM59gi
         RGR4QbOEk+MuLJ+tS7GzOJJqFyxIZ6ZjsDLp/Tpjq2oG5rlS94SvTEPMBy/6tJqQqMl0
         JXPA==
X-Forwarded-Encrypted: i=1; AFNElJ9IkqiQS2IEBMVTpS3YLWFer+psoHASE3vHztm3KP8ouko9RShd6CyPL1sAzo8Edp0LQf4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8eofXpqpXyuS+oMNA6cU6GIeqs/c3CrJQSDCNWA2gIgPBrXBY
	eW4NkM5QMjSMvXN+EWR/7bT1IZxI+Kfp4YmqdBC5k4LcfXui2vxK6KG3sfvt0apw/l3J5lY6Z6V
	QvCutFQ==
X-Received: from pgbcs12.prod.google.com ([2002:a05:6a02:418c:b0:c85:61bf:d142])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:438c:b0:398:7256:3c0
 with SMTP id adf61e73a8af0-3b7e47407ddmr231387637.13.1781546725252; Mon, 15
 Jun 2026 11:05:25 -0700 (PDT)
Date: Mon, 15 Jun 2026 11:05:24 -0700
In-Reply-To: <CALzav=fsuDxGViwyFmhR1RmQKugR_tcj70gmq-492thdxJTDPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613002031.745413-10-seanjc@google.com> <20260613003501.DD5951F000E9@smtp.kernel.org>
 <CALzav=fsuDxGViwyFmhR1RmQKugR_tcj70gmq-492thdxJTDPg@mail.gmail.com>
Message-ID: <ajA-5IQ3R5ZO1rSi@google.com>
Subject: Re: [PATCH v7 09/20] KVM: selftests: Add VFIO device support to
 eventfd IRQ test
From: Sean Christopherson <seanjc@google.com>
To: David Matlack <dmatlack@google.com>
Cc: sashiko-reviews@lists.linux.dev, Marc Zyngier <maz@kernel.org>, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, Oliver Upton <oupton@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026, David Matlack wrote:
> On Fri, Jun 12, 2026 at 5:35=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
> > > diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/s=
elftests/kvm/irq_test.c
> > > index 9f8895b898214..6888be54ee4a9 100644
> > > --- a/tools/testing/selftests/kvm/irq_test.c
> > > +++ b/tools/testing/selftests/kvm/irq_test.c
> > [ ... ]
> > > @@ -55,6 +58,36 @@ static void *vcpu_thread_main(void *arg)
> > >       return NULL;
> > >  }
> > >
> > > +static int vfio_setup_msi(struct vfio_pci_device *device)
> > > +{
> > > +     const int flags =3D MAP_SHARED | MAP_ANONYMOUS;
> > > +     const int prot =3D PROT_READ | PROT_WRITE;
> > > +     struct dma_region *region;
> > > +
> > > +     /* A driver is required to generate an MSI. */
> > > +     TEST_REQUIRE(device->driver.ops);
> > > +
> > > +     /* Set up a DMA-able region for the driver to use. */
> > > +     region =3D &device->driver.region;
> > > +     region->iova =3D 0;
> >
> > [Severity: Medium]
> > Does hardcoding the DMA region's IOVA to 0 cause IOMMU mapping failures=
 on
> > platforms that reserve or restrict IOVA 0?
> >
> > If IOVA 0 is unsupported, it seems like iommu_map() will fail and trigg=
er a
> > test assertion crash instead of running.
>=20
> This is probably fine for now given the test is only for x86_64. But
> if you are going to send a v8 you can use the VFIO selftests
> iova_allocator to fix this, instead of hard-coding.

I'm confused, why is this test setting up a DMA-able region in the first pl=
ace?
