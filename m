Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4EE346797
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 20:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775074355; cv=none; b=SaZ0BjiadY2HP3SVQWNvqdAmr7/kcMHIjDuIPZNZ6d4ThcO7s4VcSAAiHDa94wya4Jf+ntDEJFXKS940j63rJt4pDDxBx25We7x+qSyHaD/UJ3VjmLXyUAQ4jgNjMnL4TZAODCEGt2bqiZCIcpwwp+jVd3aDrS/v2xM53J2DmEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775074355; c=relaxed/simple;
	bh=mzmf/tQAZzg3tkFAS++cse6duFS6+EMTyZUDvfhK15Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=op3jOLU3giWkHymtUg4uaoMCeXZsAkG6B/5NzHixgti1LvKVTf0zvSt1galg2OxdItEuq5B8Dw5vTvBPgkK17CRtyfXBtsFX/EyMe8F4byO0YPnnPUCUfR4Ie6xG5t8Etd8P2GS+BvaQBgMhJJOfZSJVegP34jg+B6wKDMDrkhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gdc+Ofnd; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gdc+Ofnd"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ad9f316d68so353105ad.2
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 13:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775074354; x=1775679154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NcqhMR+RXJk6KO94WYqbTA+Ubd1MxPDKOWjFYBI0Cwk=;
        b=Gdc+Ofndx2j7Ee6xvNKw5uFkTB+8B0Lwoux21DzUvjvTdMLlpGyVl5ytsyZARgxQry
         7xkQHF00ZnHw8zUjwdzFvsFeM+9l5xFuHF8KGB8gYzect/+B76Abv+4FtNQBx1Vp5YQN
         jo0xwKol1gJYkQhcqJm2P2N8qtle5LqvQ/Y1d182iLcnvdAGoCcv2ekmm1Z5zUMB3kw8
         pXY7l1m4djrHZ70Vh4v+a4y28FFkJ2t6NwDfjCiuitvXUeH4/jaXE0XFqZh/H6kSvso2
         HaGf4bREvk3J/OurFoLil19C7MXLXqAvgrxipPEDw5YF7+rVlodFz7LCPK1GcoUI9aiP
         gYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775074354; x=1775679154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NcqhMR+RXJk6KO94WYqbTA+Ubd1MxPDKOWjFYBI0Cwk=;
        b=C8vH0ZUmwGzaOa6gbZGprUg6EgVOZI/+bsBdPEoyjM8ieE6m0JA/PHQL3Psw4mdgVo
         tyYxYlRHFT6LY7usNRnzbko8AKUqgtTdy/6xJUMzqip8d2rbNzKTpbVUZgS0+eL23q7P
         +GsyLxyWHIQYlOyBAbjG6vWV/WMkZIHkpU/7W6pG9f0mKlg32uvrJUrPYnQpTiS96JZX
         Oe7pzx3hPlgNI6hMa3oUpcTYCsNbvp3XKbGhU4nrrBk6w5PCbVkCVADwz9ARpZJ5N2Ef
         ymMzxTWtS0epbH5XSMHV9pDjURbpdj1XV3yYzzxiA99GMuF1aRm/KlirqVQspyzyFNxP
         PdeA==
X-Forwarded-Encrypted: i=1; AJvYcCX62B2h/EiE48FiJx9DsyJg4sjCy45P6S9+IWveNCK0mcywKh+T3gy1VQbXlInllPy1nH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxBM+zeV3TNVqMmwtM2sBXOizPm6vA7as2V0rQqwvmzq4Y0bj3
	nFkNwYb5JwO/zEy32q/i3aySyodaASoAHCa9IMoibQ541U3fqxNwswBqN0Vp/rtwPQ==
X-Gm-Gg: ATEYQzzovi7P99UGQNYoVl5sy4VlYAZ5+j1ZKDIRJW0TCD3kroGhDpPU5QDlQ2RiTbe
	t6Ck5RxsU+hVn3Q53Q5DfE1ekg3/vSa+b5C7wASRx54ITcbv4w1lxML9PPU/ndMqoh7iCprYDHH
	VthnPJg0q9h27+reh5IwbyjBbi69LuD1aSPWrUiar6/LGNeEm31/Ve39pXTkgxNbPPIui2XQrLA
	hISPsx8kYKEMWb3gqNU/xRwZYozwFP+OR0hSKa37EBzqaS5cjfLJis7TG6dqgcV7p1Pr5e8l0dj
	+GYUkFRElcfKac2WNNgTFaVc89Fj5QBcVfBewOjNb4K1duWtJWuoG0dAlbPNC5lwlNKJPXnM5Cx
	KhibtVfwh3a0hh7//6P228aOFvszs3nHBfooJbgU8VDYJjVVR+CYxcm23ITfxmYlkE6WYP3edyJ
	QWqzKqshevLcTtxSga/veLcNDqR2yxrgaHjSxXBEndKBXbsnqW61CnBE3YlxDJVw==
X-Received: by 2002:a17:903:248:b0:2b2:5723:12c3 with SMTP id d9443c01a7336-2b269ccfbfemr47949205ad.43.1775074353331;
        Wed, 01 Apr 2026 13:12:33 -0700 (PDT)
Received: from google.com (239.23.105.34.bc.googleusercontent.com. [34.105.23.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27477c54bsm7811775ad.27.2026.04.01.13.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 13:12:32 -0700 (PDT)
Date: Wed, 1 Apr 2026 20:12:28 +0000
From: David Matlack <dmatlack@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Josh Hilke <jrhilke@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org, Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH v2 00/14] KVM: selftests: Link with VFIO selftests lib
 and test device interrupts
Message-ID: <ac18LHQLalPb4z0-@google.com>
References: <20260331194033.3890309-1-jrhilke@google.com>
 <ac1hI93pEo-x-7YU@google.com>
 <ac1pUx_jYv2yCMnX@google.com>
 <ac1s55_oLEUQx8Hs@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac1s55_oLEUQx8Hs@google.com>

On 2026-04-01 12:07 PM, Sean Christopherson wrote:
> On Wed, Apr 01, 2026, David Matlack wrote:
> > On 2026-04-01 11:17 AM, Sean Christopherson wrote:
> > > On Tue, Mar 31, 2026, Josh Hilke wrote:

> > Agree this would be nice to have. Is this a blocker for this series?
> 
> Yes.  KVM selftests need to assert there's a driver before trying to proceed.

That exists in the new test:

static int setup_msi(struct vfio_pci_device *device, bool use_device_msi)
{
	const int flags = MAP_SHARED | MAP_ANONYMOUS;
	const int prot = PROT_READ | PROT_WRITE;
	struct dma_region *region;

	if (use_device_msi) {
		/* A driver is required to generate an MSI. */
		TEST_REQUIRE(device->driver.ops);

But I think you are also asking to have a helper that prints out the
list of available drivers in this case. That should be trivial to add.

VFIO selftests could expose add a helper that handles checking for
device->driver.ops and, if null, printing an error message and list of
available drivers and exiting with KSFT_SKIP.

One wrinkle here is we are probably going to merge a driver soon that
does not support send_msi():

  https://lore.kernel.org/kvm/20260331172241.50456-1-rubind@nvidia.com/

So we should also have an API for that. e.g. Add 2 helpsers:

  - vfio_pci_has_driver()
  - vfio_pci_has_driver_send_msi()

This test would use the latter.

> > > struct vfio_pci_device *kvm_vfio_device_init(const char *bdf)
> > > {
> > > 	struct vfio_pci_device *device;
> > > 	struct iommu *iommu;
> > > 
> > > 	iommu = iommu_init(default_iommu_mode);
> > > 
> > > 	device = vfio_pci_device_init(bdf, iommu);
> > > 	if (!device) {
> > > 		vfio_pci_device_print_drivers(stderr);
> > > 		TEST_FAIL("No driver found for BDF '%s'", bdf);
> > > 	}
> > > 	return device;
> > > }
> > > 
> > > Because as is, this requires way too much a priori knowledge and magic for
> > > upstream.  The user shouldn't have to dig through code just to understand what
> > > devices are supported.
> > >
> > > Ideally, VFIO selftests would also provide a script, utility, and/or helper to
> > > identify BDFs for devices it has drivers for.  In my experience, binding a device
> > > to VFIO is trivial.  Finding the device in the first place is more annoying.
> > 
> > Agree this would be nice to have. Is this a blocker for this series?
> 
> Yes.  As I mentioned to Josh off-list, I'm not willing to accept a "we pinky-swear
> we'll make this stuff user friendly".  It's not that I don't trust you and Josh
> (and others), it's that for me, this level of user-friendly behavior isn't nice
> to have, it's mandatory for these tests to be usable upstream.
> 
> Internally we can squeak by with barebones, unhelpful tests, because the run
> commands are often hardcoded somewhere and there is piles of documentation elsewhere.
> But for upstream, none of that holds true.
> 
> If it were weeks of effort, I would be more open to treating this as nice to have,
> but AFAICT writing the code should be less than a days worth of work.

Yeah that's fine, I don't think it adds too much extra work, and it's
something I'd like to have anyway. I just wanted to confirm if it should
be part (or merged ahead of this series) or can be separate. Thanks!
