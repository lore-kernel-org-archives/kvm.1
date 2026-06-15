Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED53F38B7AA
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 19:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781551328; cv=none; b=JKwQvn9SdSP+/rPy1/ChiufHTM+VA4phVOcpotQf9gst4KR9dcZCyjK8WvqecGRUGBrRhpha3nGFj3lfM7L1Gz3OLryBf10JTMQJfRNn5noL8jcVo4Z1V+IHLcqQT/uNK32V1sdE02XKduQfss9E5+FsKJ+COz47cKGogjuCxsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781551328; c=relaxed/simple;
	bh=5i4d8xUU0LEBZ0Fk0Xp0weKyNN/NHRZWQOsmriTvg+E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oekbfK/dXR1uKPSr7mIbV9ZB97kfl6qCxQl4sCODaS9K9mH1bJZ9AbKh2S2xkLunRF2FPfQG/8bjlZrUQUSsYEzBe/3bn1c/N38U8D2mVhIMQ7yLd8ov3kXzhonPrXsJm8/eJbL9i9N01zTeFTQcgUKLYv4LPICyJt3HE1yO2Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S/w4DHxk; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S/w4DHxk"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso94954755ad.3
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 12:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781551326; x=1782156126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y7k10tUfFaZEAStRGxgcvcSPRJkvCTKPLLnET1wYWZI=;
        b=S/w4DHxkHh8XdlmIryF1q+ybGVUU/VO+KdCnhuzUKZmuYGqEt9Js+mX0SelcDl2606
         XVanCuNU/OyN+L3H6Pq2KmBqKAZs6F1Xxxd0IC5fwlqqKGUIAEw8waVoPzA8vJyEg4GV
         x6ZNNmN5rtIZLwrN0ryY3BsHMrn08xEyMktxp5fSl9JFvwj18Xv3LAG5i8elCbPZYlWy
         2Vdt7lpl7gI8jXzSDuFGvKR7cQ/txFEyFKJz1w64NKqLuW2hWOnobp13iXtN7cOVMIg9
         hMA6HC7o2Nr+/gQluLiaATbZ3m+fVwMacDIXCmhMa1PwLvm/FYd+/6ZPrJaM0NqtDp88
         YonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781551326; x=1782156126;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y7k10tUfFaZEAStRGxgcvcSPRJkvCTKPLLnET1wYWZI=;
        b=S9FHD76EhkGwA7njnkWEPiw/SnqZB6FCSl4OUBcu1Xn6XymeKIF8H2m/KYOOx98nSa
         qZzsm97pcSCxqUMXHKK6mAGog43jKlJoLjyMMqNphnLtOJGEyh9Hm1YYgOtpHK+rrwAQ
         GIhUWhm0qKB0me1ufMx8ApJAHEettR/MmL1l23IBK3anBtBuC068Pc4POa4GqQstaBhV
         udO8SJPrD/NzO/trfNXXU0CtpjnzIc6YHe0MW/x0+a5jOLTEvQm8gDF6qX94GGJ9ULkg
         FujC7Z5aP26J3he+xU0PV5quDVQ+VoEj3EguHUoEIEI3R9lUCrnqC2eJAeVLish0/w+J
         AliA==
X-Forwarded-Encrypted: i=1; AFNElJ9fEqDCaGHveoZgyJBKkmLATBO5X74G+ykohkO3iRuG0KOd/3mipHlvegWtRLpN7A1PtF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVS6OUnPS53geqoF6FROdrUUd5bhzyXW87E15txco4n3YZTajv
	57Qlc3X+Ujtdc8Va1PKBduys54PCXjteC7+qEuXLpXbM1saTH2xiStuo8VMwlVQOGZ+fVKqMx6V
	N4rGQgg==
X-Received: from pllj1.prod.google.com ([2002:a17:902:7581:b0:2c2:daa2:d34f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1252:b0:2c1:42d2:40a
 with SMTP id d9443c01a7336-2c69a0f5275mr5247775ad.9.1781551326051; Mon, 15
 Jun 2026 12:22:06 -0700 (PDT)
Date: Mon, 15 Jun 2026 12:22:05 -0700
In-Reply-To: <CALzav=fQ5FENWgGNEqQrmb-i_9fWTRhLXj2-jZKC_zjM3Kg6PA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613002031.745413-10-seanjc@google.com> <20260613003501.DD5951F000E9@smtp.kernel.org>
 <CALzav=fsuDxGViwyFmhR1RmQKugR_tcj70gmq-492thdxJTDPg@mail.gmail.com>
 <ajA-5IQ3R5ZO1rSi@google.com> <CALzav=fQ5FENWgGNEqQrmb-i_9fWTRhLXj2-jZKC_zjM3Kg6PA@mail.gmail.com>
Message-ID: <ajBQ3YEAMyKnJWYb@google.com>
Subject: Re: [PATCH v7 09/20] KVM: selftests: Add VFIO device support to
 eventfd IRQ test
From: Sean Christopherson <seanjc@google.com>
To: David Matlack <dmatlack@google.com>
Cc: sashiko-reviews@lists.linux.dev, Marc Zyngier <maz@kernel.org>, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, Oliver Upton <oupton@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026, David Matlack wrote:
> On Mon, Jun 15, 2026 at 11:05=E2=80=AFAM Sean Christopherson <seanjc@goog=
le.com> wrote:
> >
> > On Mon, Jun 15, 2026, David Matlack wrote:
> > > On Fri, Jun 12, 2026 at 5:35=E2=80=AFPM <sashiko-bot@kernel.org> wrot=
e:
> > > > > diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testi=
ng/selftests/kvm/irq_test.c
> > > > > index 9f8895b898214..6888be54ee4a9 100644
> > > > > --- a/tools/testing/selftests/kvm/irq_test.c
> > > > > +++ b/tools/testing/selftests/kvm/irq_test.c
> > > > [ ... ]
> > > > > @@ -55,6 +58,36 @@ static void *vcpu_thread_main(void *arg)
> > > > >       return NULL;
> > > > >  }
> > > > >
> > > > > +static int vfio_setup_msi(struct vfio_pci_device *device)
> > > > > +{
> > > > > +     const int flags =3D MAP_SHARED | MAP_ANONYMOUS;
> > > > > +     const int prot =3D PROT_READ | PROT_WRITE;
> > > > > +     struct dma_region *region;
> > > > > +
> > > > > +     /* A driver is required to generate an MSI. */
> > > > > +     TEST_REQUIRE(device->driver.ops);
> > > > > +
> > > > > +     /* Set up a DMA-able region for the driver to use. */
> > > > > +     region =3D &device->driver.region;
> > > > > +     region->iova =3D 0;
> > > >
> > > > [Severity: Medium]
> > > > Does hardcoding the DMA region's IOVA to 0 cause IOMMU mapping fail=
ures on
> > > > platforms that reserve or restrict IOVA 0?
> > > >
> > > > If IOVA 0 is unsupported, it seems like iommu_map() will fail and t=
rigger a
> > > > test assertion crash instead of running.
> > >
> > > This is probably fine for now given the test is only for x86_64. But
> > > if you are going to send a v8 you can use the VFIO selftests
> > > iova_allocator to fix this, instead of hard-coding.
> >
> > I'm confused, why is this test setting up a DMA-able region in the firs=
t place?
>=20
> There might be some devices with which you can trigger an MSI with
> pure MMIO. But most devices you need to at least set up some
> descriptors in memory that describe what action you want the device to
> take and then use MMIO to poke the device to read the desriptor and
> perform the action. Reading those descriptors is DMA.
>=20
> For Intel DSA specifically, send_msi() works by telling the device to
> perform an 8-byte memcpy and send an interrupt when it's done. The
> driver region contains the descriptor for that memcpy, as well as the
> 8-byte source/destination buffers the device should use.

Ah, gotcha.  For a comment, how's this look?

diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftes=
ts/kvm/irq_test.c
index 6888be54ee4a..9a495fdb52f5 100644
--- a/tools/testing/selftests/kvm/irq_test.c
+++ b/tools/testing/selftests/kvm/irq_test.c
@@ -67,7 +67,12 @@ static int vfio_setup_msi(struct vfio_pci_device *device=
)
        /* A driver is required to generate an MSI. */
        TEST_REQUIRE(device->driver.ops);
=20
-       /* Set up a DMA-able region for the driver to use. */
+       /*
+        * Set up a DMA-able region for the driver to use.   Very few devic=
es
+        * provide a way to arbitrarily send interrupts (MSIs), e.g. by wri=
ting
+        * an MMIO register.  Instead, most devices send MSIs when an actio=
n is
+        * completed, and practically all actions involve DMA of some form.
+        */
        region =3D &device->driver.region;
        region->iova =3D 0;
        region->size =3D SZ_2M;
