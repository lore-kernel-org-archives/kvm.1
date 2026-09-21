Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E444249BD6E
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 20:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790023732; cv=none; b=YqzjQj9fqffzu22xvMnBBeHwPY6u03UY4plvZDIJy5UV6V0WGaEQtYoD8MXG2vOrGMVEytt5RrrGkI12cvxpVIjN1g58tj9laxUA5xBKCKAr/lLB3OknXDU0SOqeOI7onCteAHNvm772g6+IPH0mLUMrlSVmXSPGn5MiYz8Y+ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790023732; c=relaxed/simple;
	bh=duuqjqeee1gxRjF5xn4L1VFmmMHLBdcH21nRueFfC6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fodLq14RkGoTPWDiEbua1IAjMSgt/DRA530OfjaAgtzZbXFVIhQPnHyZN5nxh92TUk4SNlZALsRv5DJcmz+4E2UHeqZ8J5azO2kiOgwUYPgmAp2Y+f4ZDE6Aj/oLj+fSDEWYB8BhmUYsLy4r7ykoMYDpvBSYDGyiOXwOyB1qt3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LLimrgB4; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LLimrgB4"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85a4329731cso2673878b3a.3
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 13:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790023730; x=1790628530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9RpdHbEhaZD0mMR4lSv7YIPkc3oHh9/Jw4xKi9A6gsk=;
        b=LLimrgB4OLYrO3yRYyMqbBIfEJcC6vydiVWdt+bN2J00jyw9zmdOhng8dXbnB9YBvL
         KLRo2H/BVeQSZbd5ZKg8NcmFoJGobbU64MSteGWQiMNiucQ/+aFxHhloPlG2589TnOPy
         xuZfAN+uCklXZ7HUwWA2TXCpA7Oc7LjDbTtu8ulilmB+e4rElR0rTkk2836k3CaMYa7N
         cOVUTYqWKJUSB5ma4aDuEohibGmNWNbV0q08YcNfuJ7lpwRgi8WRmXr9ILPCToe6empR
         EDklh5DY4gOVUfGHDEUatpD9Vqp14MRrsJUmBD0Cq5slXZ5Zl60enx8tTaNinsc1dSNz
         W/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790023730; x=1790628530;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9RpdHbEhaZD0mMR4lSv7YIPkc3oHh9/Jw4xKi9A6gsk=;
        b=1vicOA6emfeT/Z/mykFuD0KTuEM7VP5ErxdKLdkSkX9alfMFL+nhwuZoo8rgW5+B3e
         y3zfRhhU6MxxMqml4zmGudTedhP55ysV8JXV1SrLgr2THTT1JypdQChj0UdC5d2AlH7L
         6iQcAUMnLZO70c6kQ6YJF8xKM9UmKM/QjXJliRRV5xuFZZognK0rYYzsXLWQ68xJPR/i
         7RLbgXj9vlwiWIh+j7v+3BGwQrYfmiToxrepNLeH1toC5HTHdYB5Uv3X6WzJ3c0kvHk9
         OCrvPNts7Ee0hzubf5ozxbEFxB62OYv9oOVfaoFTRFPYe8+e1Djte3yFeUVV8+YYPZef
         MgBg==
X-Forwarded-Encrypted: i=1; AKwUvBzVVBskiTtIff0tLfRvPQjPYDG7KijZ8avDyEltBsekUDYFFq3Y8TpAN+ZP5tpRY5+ZExc=@vger.kernel.org
X-Gm-Message-State: AFuF++m+j1I9eua80G7Ll4KgXfwRWAab5d1AUptu6DNXM8n0pX7Rf0wm
	Gw+MadArBtaewFEQ0drPWsDtY/YDr9OY493Ek/j6BsTs3B8V6E9p0L54/BubqxPnp72WYvoSMZB
	EjMaQwQ==
X-Gm-Gg: AYBFou2qhg106qVPPOF94u0gozsRODz/vmkOKjzjqBl2Jr8e8/y4y4ejPqoj8JK9C5P
	pKsYpr0hJXz5bgLJ/VdZiOFaFyyFWOTo+VIE4dA2Sswrnst3KR4qY0quO+6J9CywuPKtEl5oXsk
	myziwFAQgXJop/Fh+ekz/KhLLc4XR/AWvZWnir48etflfbl23gVVek9CgeoDD5teMfK7c/nWNy5
	kb9kke2x6oUM04FLADFWZN8VD29sVXafGLh2VkqCouFXOi1XjxKdW017v7/Li5LyJgSFI412xPv
	y/qY0hf29P/1k+KpgYUNrEW+sv0rM+10xio5pegNTkReoWw/KDMRmFyHmJ5ao7O3laFqw5xaz5S
	F2X2AFXLhe0HnT/XoQ7RidzdCQn6Z9ZtzfsdrP1oWvgthWxoQKXKwf20kJRZ7xphgnHFSk0lUhZ
	FMIcHPBBf7SthfkcyZ0X78Wo28MpdvFksfobh4rB79PJipCpPHKd7JLwP8mkzpDQPQDgXZYKLSR
	Zqr58SNw9+Coah638EMdHn/z7FGSnNkYIOL9w6WSoppWF3buUc=
X-Received: by 2002:a05:6a00:6c97:b0:878:34b8:2320 with SMTP id d2e1a72fcca58-87834b82455mr8559084b3a.40.1790023729351;
        Mon, 21 Sep 2026 13:48:49 -0700 (PDT)
Received: from google.com (192.150.203.35.bc.googleusercontent.com. [35.203.150.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87bf84b6859sm44247b3a.52.2026.09.21.13.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 13:48:48 -0700 (PDT)
Date: Mon, 21 Sep 2026 20:48:45 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org,
	linux-rdma@vger.kernel.org, Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH v6 06/10] vfio: selftests: Allow drivers to specify
 required region size
Message-ID: <arGYLavnr25ZSyuw@google.com>
References: <6-v6-8af36cf7b73f+e2-mlx5st_jgg@nvidia.com>
 <20260917235245.CAAE41F00898@smtp.kernel.org>
 <20260918115217.GA11142@nvidia.com>
 <CALzav=f4NTb4Csn2BoK5kk=MckFRvbVnOdO9yiCz8MLXdRMPOg@mail.gmail.com>
 <20260918200000.GB11142@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918200000.GB11142@nvidia.com>

On 2026-09-18 05:00 PM, Jason Gunthorpe wrote:
> On Fri, Sep 18, 2026 at 07:58:58AM -0700, David Matlack wrote:
> > > >
> > > > [Severity: Medium]
> > > > Since this changes the vfio test to use the dynamic driver->region.size
> > > > instead of SZ_2M, should tools/testing/selftests/kvm/irq_test.c be updated
> > > > as well?
> > > >
> > > > It looks like vfio_setup_msi() in kvm/irq_test.c still forcefully overwrites
> > > > the dynamically probed size back to 2MB:
> > > >
> > > > tools/testing/selftests/kvm/irq_test.c:vfio_setup_msi() {
> > > >       ...
> > > >       region = &device->driver.region;
> > > >       region->size = SZ_2M;
> > > >       region->iova = iova_allocator_alloc(allocator, region->size);
> > > >       ...
> > > > }
> > > >
> > > > Will this cause the KVM irq_test to fail with a VFIO_ASSERT_GE during driver
> > > > initialization via vfio_pci_driver_init() when tested with a driver that
> > > > requires a larger region, such as the mlx5 driver mentioned in the commit
> > > > message?
> > >
> > > I have no idea, Dave? Did kvm start using this stuff?
> > 
> > Yes, KVM started linking in the VFIO selftests library in 7.3 and
> > irq_test.c is the first test using it.
> 
> Okay, so I think this is all that is needed:
> 
> @@ -101,7 +100,6 @@ static int vfio_setup_msi(struct vfio_pci_device *device)
>         allocator = iova_allocator_init(device->iommu);
>  
>         region = &device->driver.region;
> -       region->size = SZ_2M;
>         region->iova = iova_allocator_alloc(allocator, region->size);
>         region->vaddr = kvm_mmap(region->size, prot, flags, -1);
>         TEST_ASSERT(region->vaddr != MAP_FAILED, "mmap() failed\n");
> 
> > Looks like that is also causing the dma_rmb/wmb() redefinition
> > compiler warning from the kernel-test-robot.
> 
> Yeah, for some reason kvm defined them in its private headers instead
> of putting them in the right place :(
> 
> I think I can just delete the kvm definitions.
> 
> I don't have an arm system or userspace cross compiler to test it with
> though..

Wait, really? I can help with building and running the KVM/arm64
selftests if that's what you need.

> Are we good on everything else, can Alex pick it up after I fix this?

Yes all good from my pov after we address this feedback. I am no longer
seeing failures[1] when using the IGB driver with this series applied.

[1] https://lore.kernel.org/all/anzvkibgzTae9eV9@google.com/
