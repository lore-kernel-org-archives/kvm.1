Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB3537F000
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 18:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781548363; cv=pass; b=Ou30J3zjYw7XzWT3nbFiFTwTqVyEdB/9UpuduvENgGuvkO/y3YSeqF0jI6pplJ0LuYqGCnH4eumM4lWM1WyoO1IJI8LPwqTVSzrnDPnboBmsFDDh2UAiuyhwOKItx3TFNuVii6spbzZgjZKA6MSKMAGjM57ksF/HROMGU3xwPXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781548363; c=relaxed/simple;
	bh=eUCd4cJRHM4c506P0iJJojFx6MYUj6RH7trS4Dt2rhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N5a68e47nDi9YT6Qs7F2sWvY+4p+UVybP1hzrbMCn4DZAMa6LzVrGP3BPrgGruNW3dN16KnGnPOinaXkhmWpYVJBGm1jG3nHDpqrEHPlIN+c1xZNO7I+1tdehOJiBYj6CQ8BOeIA41I1o9PXKHO223CijvB5EA28hndgngPhXTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RPmB2XKT; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RPmB2XKT"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-13807d2f898so4041442c88.0
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 11:32:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781548359; cv=none;
        d=google.com; s=arc-20240605;
        b=Hdb2XSX0buy09Mfby0SsC879cqaCg7vw1N56tdgJLpWWxoQ6zgkKIo81qIszEoFfMB
         JvCSUvfB6UE6QqgDPpBP1xammMoU7ZbkrI8y/XvhjMOwOPUJMi71CT7k4Qa0nalw/7c5
         HnC+iMf5vUVDOApnNYhlVe+b5FHvFE7+f3by4gKyHLNxAmy22Tg1xDAXBlcFEJJfO/E4
         TE6w8EDMkt4PWOxERklEW1iYlCbHA3suXlMFv7MCPMeUnJTao1nOnBCfG+dNBUJOXrYF
         RvPIzwQI4C4FR9Vg5zZOnC1H8oK2jTSrN5e88IKz9HAnduSWqfuhwN/Gpiq2hjfeP9A0
         iBAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u1m9kOyZU75L8F6PL/t68prlNj72GILewPQGDqJwRY8=;
        fh=B1HKxTKXAgNZkI5UopwIbs67CnTofnGcOEvcSS/0Kgc=;
        b=FuStiUlkdLwG64tkmrD7fDpcpKTv845Zn54MtOLitG0KTyNGXQdgv6mr+Q892GCbVM
         CB+0edE3SENdr6h5iuMi12V77Tmde8Yw4gat8kFV9FbUlF/YYG/umu9mo07egs140Bt7
         P+dQtM9JD1xnt+B17ucNV8zkeEwnjVuCjS/XJk7MENjeXR5SERK0H3yT00UyK1ytSAmI
         irtXX1TtdNfQd4VUhKM+CQTW6zoBTVZY1xcpkpq/J7fH81MOB3eEqk7jCYhhTBkg3IZ2
         AwRSO1oDD8ytj5yeHcuEoeYfLXHVw7bPdLOjmA35hcBC0nrviuQLL3xB+AreZGJZua0X
         IxXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781548359; x=1782153159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1m9kOyZU75L8F6PL/t68prlNj72GILewPQGDqJwRY8=;
        b=RPmB2XKTKvK48w/mw4oQG5cgWKZNxp1++EWNdZS+WTN8R4PX2CykTU9xCWuTrRAWIQ
         63PisDeDZTAUli08XUaJUjYmSWcMxGRMvVWZIJsaKAt9/GUPGaFTg83rCG6KYU9Tjrcd
         EroLs9rsQNEvkvqCDGH8rObK1BvZQF+yR6dqccTk4jVnvwEdGepxFsAJyRmlQ6pIa1n7
         MRZaXju7uiCxbh2TsEe7ijAMf4nwIJ7iSfzn+mcTvV8ztxFOM4Cp2YMV+8iCKg3bUMWL
         Tz3X5i3WM2udP8h2rsQmpntVVagjdPauU9B6JfcfHSwL+JUbFJ4kvyOkCrT7vCVTpB1G
         kwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781548359; x=1782153159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u1m9kOyZU75L8F6PL/t68prlNj72GILewPQGDqJwRY8=;
        b=NdHUvs1aMnk8LS2i635qFIb80pt6wj7qgpQqOe8eCrwSqaGZfPuigtc86x9IQIsBEJ
         XGecHSvMv52hzwxfYCDA3FobIhcnvnv8S4dJPhDfrwdJa86VaqlxbF9u/tfPnn+auuzj
         G/f9iaFlvJqFGyNLQPRHLzYmCsLYpaYmmdmZ2tFbBZxH8jgwajLDeRqmoxv9AkgmrLpF
         N/XkHt8eh3fcWvheUGbNyLe+LMKZU5j5JNn6QbPRQ0mAtZIOM/9JvGZaO4iAScQwtES0
         2j0iVNoONqgWhJktz2+jEMBqfec3Fg0Sq4Jk3ZO2Hl/YRE2NPrd9VB0cZOr96WSL0cM1
         ZwsA==
X-Forwarded-Encrypted: i=1; AFNElJ+Tq08q+YYlf596HkZvPJtsxtGT/SipWsn/YNVRpaBKgsNMwKxRMmQkzHlXxpC97UEcRy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJXgnt3VfcrDBP2O8qHr55SPH7OoMupzJI+Sqyfn0uVhV5IAGN
	cCquFejyqtn2tPVcvaTJBFukEZyovAid0o83aZ9uvebbykSP/PTKAe/5LJMHi6UZk6QOFNYtU73
	Ybic3jdE7I53LCUyg17SjEm/Y03aQhWyF6yDimT8k
X-Gm-Gg: Acq92OF1wv4xrRUXdxYZBDlPf4UGW0fr8sJC8NRPVA4B3J4Wok1qqSG8x8q1xjECmlF
	6TOPUhtUNBEbKM3dL0RQsiVXuJrHqere+SKZrBi++DW2RJGs5cB/XzYFC11N6Jg8VHgrpLaM3DW
	YjONAfF63ejDoih3up2Z0l8UwTa2+12GIchPLNJG4kVaVQOr8dLWFh7pQpyhjiu5Y62ACOYxAh2
	YvYYqx0HenXs9uFG/RX26XeKCb53yPgkqcM7Oz4uLB2O8yfrEU/t1ol08ub8Si7RjLHlgwFOwfc
	me9Iqp4=
X-Received: by 2002:a05:7022:b9d:b0:137:977e:628a with SMTP id
 a92af1059eb24-1384bb695b3mr6525813c88.24.1781548357704; Mon, 15 Jun 2026
 11:32:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613002031.745413-10-seanjc@google.com> <20260613003501.DD5951F000E9@smtp.kernel.org>
 <CALzav=fsuDxGViwyFmhR1RmQKugR_tcj70gmq-492thdxJTDPg@mail.gmail.com> <ajA-5IQ3R5ZO1rSi@google.com>
In-Reply-To: <ajA-5IQ3R5ZO1rSi@google.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 15 Jun 2026 11:32:11 -0700
X-Gm-Features: AVVi8CeXW89dotygEGvUfQ8kwO0uK3wZRBF_hx_oCn0HZD93ikHved6sUFUl0K0
Message-ID: <CALzav=fQ5FENWgGNEqQrmb-i_9fWTRhLXj2-jZKC_zjM3Kg6PA@mail.gmail.com>
Subject: Re: [PATCH v7 09/20] KVM: selftests: Add VFIO device support to
 eventfd IRQ test
To: Sean Christopherson <seanjc@google.com>
Cc: sashiko-reviews@lists.linux.dev, Marc Zyngier <maz@kernel.org>, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, Oliver Upton <oupton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 11:05=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Mon, Jun 15, 2026, David Matlack wrote:
> > On Fri, Jun 12, 2026 at 5:35=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
> > > > diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing=
/selftests/kvm/irq_test.c
> > > > index 9f8895b898214..6888be54ee4a9 100644
> > > > --- a/tools/testing/selftests/kvm/irq_test.c
> > > > +++ b/tools/testing/selftests/kvm/irq_test.c
> > > [ ... ]
> > > > @@ -55,6 +58,36 @@ static void *vcpu_thread_main(void *arg)
> > > >       return NULL;
> > > >  }
> > > >
> > > > +static int vfio_setup_msi(struct vfio_pci_device *device)
> > > > +{
> > > > +     const int flags =3D MAP_SHARED | MAP_ANONYMOUS;
> > > > +     const int prot =3D PROT_READ | PROT_WRITE;
> > > > +     struct dma_region *region;
> > > > +
> > > > +     /* A driver is required to generate an MSI. */
> > > > +     TEST_REQUIRE(device->driver.ops);
> > > > +
> > > > +     /* Set up a DMA-able region for the driver to use. */
> > > > +     region =3D &device->driver.region;
> > > > +     region->iova =3D 0;
> > >
> > > [Severity: Medium]
> > > Does hardcoding the DMA region's IOVA to 0 cause IOMMU mapping failur=
es on
> > > platforms that reserve or restrict IOVA 0?
> > >
> > > If IOVA 0 is unsupported, it seems like iommu_map() will fail and tri=
gger a
> > > test assertion crash instead of running.
> >
> > This is probably fine for now given the test is only for x86_64. But
> > if you are going to send a v8 you can use the VFIO selftests
> > iova_allocator to fix this, instead of hard-coding.
>
> I'm confused, why is this test setting up a DMA-able region in the first =
place?

There might be some devices with which you can trigger an MSI with
pure MMIO. But most devices you need to at least set up some
descriptors in memory that describe what action you want the device to
take and then use MMIO to poke the device to read the desriptor and
perform the action. Reading those descriptors is DMA.

For Intel DSA specifically, send_msi() works by telling the device to
perform an 8-byte memcpy and send an interrupt when it's done. The
driver region contains the descriptor for that memcpy, as well as the
8-byte source/destination buffers the device should use.
