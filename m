Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811E74E9C2D
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 14:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743573; cv=pass; b=r5qNwnj5jwvUyDQfjuL8xrr0qMZq9rtH1HFpZ55uRYdrXveJGbfR/z8eV/uORpmQnHwvDPotk+72VCOi+SwuIzPBU0fZ/c3Ez46gqz0ARjvPJ79Vzc89bK/snKwQlINNDboAI31p6tPsjKLAC5p6u6Fj29B0qqDy73NRc3QYXC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743573; c=relaxed/simple;
	bh=9/KuOEAUccINW8RzQoPd+Ke7JmL5bSGUt4d83wOmGis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FC6UE3J3CCLh62XJUre3o06FdDaX3nO6/5VFlTZhCPNqeVM1g1U8DJyemQ9hGifXF0hC1ZBJSj5IdZYKtu/85k05CKwm86lOEIHQdX5P0WUGnlTFKGkta9A4ciEPYedOFivbSTf4gFVSaiD0l4DjiQ0kndwJrjo0O27nbRAnz7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wUbT/9JM; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wUbT/9JM"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c20ce3c118aso124368766b.0
        for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 07:59:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789743569; cv=none;
        d=google.com; s=arc-20260327;
        b=Y4R/jEV/pBk52UPogzEnyIMrymz2ufDoSFIBlgVRFSFnvgJkfww1qPd4EjSzh0UUfn
         7/WC2r2H8D1j0UHoX7biUgCiK2IpNL4DSXmYTPBmX1zd25vOZm7SvpMa1YHHCWBa4miZ
         rlgBcYXv36GL9UrVKOwIZS9ye/26fPvhgM17qmogrMtLHfaoRkg2mJ54wSqJEn7ZLfe7
         T4MRnvW80EBfuImoifkK/Vw6Ai6YIvlj9FA1st3Rs13HFDoybbqLkkhWymJ+gNTxQx6S
         NF0n1xS+15iqPHsR0GYZEj6zEbANiFuFnSexMyiVT9iYTGg0O2utSoCg1NADsQYBWnoi
         txUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YC0PefwLkxVBXTBsKzjOWy/17vdgqLJp4+m26mDaKG8=;
        fh=q6t7KOIjEgk0bpAjRfgK7LF9jWH3BG8uwwt4BKgoN2o=;
        b=jTb+RmvSSb6TtgFNfJ6pT7x5myY+WZSfPTBLGOdJv1TuWdif9McXEg/FjCb9bg/2ar
         HhRauZk2t+JOd4neau0mRL1Tc6aYrk4yQ5Egyh9xUufZwHL1WW71efgp+N+EvrO5PwOb
         woBuUFEHhjBK2JM6i/C/LzYoGeED5iRxZoQ1cZPz7p2OR5lG1O6iVh8MmWJEcBECaRH/
         GOlNXeN2XB02Y/kvfryw1mf8hjxnkxUUvdecIMZ7JWBwvGLHlUPOvVTAXoPZZFkXyec1
         Mzk0bKUFIheobhTT1XH0jDipNj4Tu8iNVRb1jf6sRLiGXifUH8ETMttgC8or21UYE8I0
         zIig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789743569; x=1790348369; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YC0PefwLkxVBXTBsKzjOWy/17vdgqLJp4+m26mDaKG8=;
        b=wUbT/9JM5hL1fagbQzV4/7jP1wqJbD2L9Azs+HO4vU4UJ57uHCGo2NYm6HyRdTYpbp
         TCYXG3bh1O+OVrRV7zfa7UmszO5I/vaAZ58R7+mNyBKuSuCqme6mUxpI0DJ9Pfsd5oyL
         0lBtlDiw9adzJbNUu12jp5faSKDi+OuHRYBDPagmBXJSHFlKrK84jmp6fuMWbPTbTG4f
         JPTw3aceVGDVAyR7o9pRYHJoczSXq5uTFLx0RlBSbRclh74diybb51v0dT1AQfLsqk9i
         ZImA4MxkE1pTVX8gb1xCR9iZmEm9qy2qK5sy7cf0M1wByoHjFxXJbiaIQp52+ViIIuT0
         QZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789743569; x=1790348369;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YC0PefwLkxVBXTBsKzjOWy/17vdgqLJp4+m26mDaKG8=;
        b=pfzAmHt80tNfwn//ktYX5oQbr6RmTL8Xc6FKowOYU+txd4eoVwlkyEgPoEqFvCgsPz
         OimbYywZVeU42v99BiijKdJwimPJAw8FSrQKD69O1uKyINNAtaFpRxqg41YwluxHK6MY
         CofAXLs9cjZ+2pyrJCvVgcWePGTaUHM8EGUoT1tdC9p79L1jC2AGmCsjfFRfYVGMsop8
         AcqqJdEdtHNivPARaQYtTDtLhKkHfxMUGK576U9VyyPtk3sQ3+60sop/yH8A+iBB+86Z
         c5ZElrHW5Bd5CK8zOo9TQT9BODJw7KggiM3Qqhw7wqhEX7scuEoVFRCBKAJPuDxhi9SQ
         bfnQ==
X-Forwarded-Encrypted: i=1; AKwUvBysrTE8A9+Gs4gC7CnyH3Iy0UO0n1hxDBaUGplO+wW13UU/XTyu+gE0wgTmKmpf6glqCVs=@vger.kernel.org
X-Gm-Message-State: AFuF++mb4C/1FM9a3W8zSJbhuxUG+X6U29GI3IK0P7BDYQ03KKgoGaBS
	k4LNQo4LvY81nt888rqxpE3t2WD/zAy4QiJWPfgMLVC4RearYmXoYjlDckC95Zz8FINsa36/lYb
	Whfad6FhSkIHgtZ9LMxatUI8Sy3fmf2+hJVIv6Lyk
X-Gm-Gg: AYBFou2+hBClf9QREFSoGkyNzHIKMaoMo2Uz2JsnDHV79wO9Jgc3e1AYFz3WwbnOfjY
	fpa7C4PVGWzSY/5CU6AufKvkElINqtCTDT2Ji/xCG0WUCElLd49x6E2LbNjp68gjbE4QDsI1YkI
	YlMLDP8CeMcJlaIOzWldkmhOS3eZkqfXxP2DFyRO5d5yJRob9D+qsUTVYprHXlh+YP5tVbJ0ylm
	3icRyfCPSkNrBG7uqdFFapMmwABSjhQ5OiY3lhvrsN3r5dKJTYru1j0Uv1Q30NBt2enBGYWz0Md
	JbIhcTbBins0Fo6V3+vxnJbecFjXCRmwzoxUgKI4NOoSmXdS99daR+AQ
X-Received: by 2002:a17:906:ba88:b0:c25:f7dc:2da with SMTP id
 a640c23a62f3a-c29f5473df2mr602164866b.27.1789743568771; Fri, 18 Sep 2026
 07:59:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6-v6-8af36cf7b73f+e2-mlx5st_jgg@nvidia.com> <20260917235245.CAAE41F00898@smtp.kernel.org>
 <20260918115217.GA11142@nvidia.com>
In-Reply-To: <20260918115217.GA11142@nvidia.com>
From: David Matlack <dmatlack@google.com>
Date: Fri, 18 Sep 2026 07:58:58 -0700
X-Gm-Features: AcwNN1X4V2ednysXTROsIDMbW8yLdztMha6mDhRxWrhyVFhdILawxuBGR-T7aI0
Message-ID: <CALzav=f4NTb4Csn2BoK5kk=MckFRvbVnOdO9yiCz8MLXdRMPOg@mail.gmail.com>
Subject: Re: [PATCH v6 06/10] vfio: selftests: Allow drivers to specify
 required region size
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 4:52=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Thu, Sep 17, 2026 at 11:52:45PM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [Medium] selftests: kvm/irq_test overwrites dynamic driver region siz=
e
> > --
> >
> > commit 97ad8ed7fec97be65848236fd1c8afab2ff66a54
> > Author: Jason Gunthorpe <jgg@ziepe.ca>
> >
> > vfio: selftests: Allow drivers to specify required region size
> >
> > This commit adds a region_size field to struct vfio_pci_driver_ops to l=
et
> > drivers declare their required DMA-mapped region size. It updates the c=
ore
> > driver probe and the vfio_pci_driver_test to use this dynamically probe=
d
> > size instead of hardcoding 2MB.
> >
> > > diff --git a/tools/testing/selftests/vfio/vfio_pci_driver_test.c b/to=
ols/testing/selftests/vfio/vfio_pci_driver_test.c
> > > index 761bf117d624f..2bd949aafd731 100644
> > > --- a/tools/testing/selftests/vfio/vfio_pci_driver_test.c
> > > +++ b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
> > > @@ -87,7 +87,8 @@ FIXTURE_SETUP(vfio_pci_driver_test)
> > >     driver =3D &self->device->driver;
> > >
> > >     region_setup(self->iommu, self->iova_allocator, &self->memcpy_reg=
ion, SZ_1G);
> > > -   region_setup(self->iommu, self->iova_allocator, &driver->region, =
SZ_2M);
> > > +   region_setup(self->iommu, self->iova_allocator, &driver->region,
> > > +                driver->region.size);
> >
> > [Severity: Medium]
> > Since this changes the vfio test to use the dynamic driver->region.size
> > instead of SZ_2M, should tools/testing/selftests/kvm/irq_test.c be upda=
ted
> > as well?
> >
> > It looks like vfio_setup_msi() in kvm/irq_test.c still forcefully overw=
rites
> > the dynamically probed size back to 2MB:
> >
> > tools/testing/selftests/kvm/irq_test.c:vfio_setup_msi() {
> >       ...
> >       region =3D &device->driver.region;
> >       region->size =3D SZ_2M;
> >       region->iova =3D iova_allocator_alloc(allocator, region->size);
> >       ...
> > }
> >
> > Will this cause the KVM irq_test to fail with a VFIO_ASSERT_GE during d=
river
> > initialization via vfio_pci_driver_init() when tested with a driver tha=
t
> > requires a larger region, such as the mlx5 driver mentioned in the comm=
it
> > message?
>
> I have no idea, Dave? Did kvm start using this stuff?

Yes, KVM started linking in the VFIO selftests library in 7.3 and
irq_test.c is the first test using it.

Looks like that is also causing the dma_rmb/wmb() redefinition
compiler warning from the kernel-test-robot.
