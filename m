Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C46E32ED2E
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 19:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775070443; cv=none; b=hEpqneeMqbSZd1OMStMDvnE0GjtVEAuqi7yTEYjsz7v5PPJvBs56ODaxy7nDZK1e/Y4H4fIjnl3CLOv/L/rp6VZIb4HDLkNU7afMSgzT+3+Om8A1UE2PF9r4pktwaCSsWPhIrNwsOEVd8VqP9aQPTth9+a5t/vPe0TLFWMxcnbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775070443; c=relaxed/simple;
	bh=OMdO+tFJ6OLziUdlu33dLXoZ/7vMDQMQWjuAHyb5DSQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iIjh2LjGZrR2iiVSBI1wuvMBuB/AwQJ5zNZtEOh5fYGFT4x2Ehc3K4ZdrTitWeZALQbMElcd2Isk5LOgIywf01qN+5PSAsqXwT59oJ+bb38YOQSr2Xb/G3muL6Q8yOf9uXKDanhMEz3b3AiyVMd6ES7Bef2oMmSs1jIPfbBEllg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ki9yxLOO; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ki9yxLOO"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-354c0234c1fso34088a91.2
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 12:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775070441; x=1775675241; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zvC/ZzJIOCXDarRg/n8zFp8o9/BNtILNk5qQeZwmHBk=;
        b=Ki9yxLOOucbK9voIhyDBndxPq5ZAFL6tndYmKjfijWTvv+qZt3eiMwmikbIkaoNva8
         6LKDSI6KO2TRAx6NPUqwahxalc/s5za6fOS7HBFc6nqS3Cz485gPMNJb08mD7qStPjxi
         JsiiLTuUynlzGIfmiDwLbdtaIjcLtNOBouw+j7PibB+X0cKIMVvDyAE1WX4T3lCtPKT4
         PeuAIufaEcDYLgAH0H2Pu6DqaLF4IAHMzePdufGl+jhLp/aIy+XJJYktyPkDFR1iWng6
         eaxWKEcTiEUu9dVTEOc15dQ/CQXKnljuUMdnuNq6Huf6S9oDO59k4QR4ZopjhPL1HqTh
         +nag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775070441; x=1775675241;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zvC/ZzJIOCXDarRg/n8zFp8o9/BNtILNk5qQeZwmHBk=;
        b=DxeFrWzd3BPT6/fQAD7YDFYcdQDMG9GLIYyTPdzcBBlAVru8ogjeejzFEAkOErpwS1
         ntBLJ0AHArBw6Z/jWt1l4tfpMYoId1UDHQ3V3qv33oLuNtCExgedTixWkXhVqzqN2TUh
         xj8Xg7hGy0KU7t3ykRnMvyl3tQ0w+gQFtvY31tyhDmMEFu0fCdKQn+Rj5qVyZ9uMA2vr
         AKa5T3gqD0AMXFcjcjrkNPF6fllfNz+upWfruC9hTBGZRHfAWl3noGECka4zBwSwbnKv
         atEBoE4qZ7lZVipXafQx/nxAEZYu98zNNDsM8MY6HgyTtAwTFQBbNv29O3z8IonLb3a7
         YZ0w==
X-Forwarded-Encrypted: i=1; AJvYcCWwSmUY56WJagKFyVj+g7fcBbKmUri8iRTxCaX5Ivcun/MdSdGIp5HbSgeRlTwSScQ6Fhw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyte0eOVVYhgwzqknxMUiUoXtBQ4ekHcodSXuQ/+OZicH5oHCy
	AP2b3xEibznM87PeNV9f+gIGJnyttrfu5dVaEZApqq1ATd8/uqPXl58otjjznzo75ZUIifFmCTO
	PvxojwA==
X-Received: from pjbcz6.prod.google.com ([2002:a17:90a:d446:b0:35c:f64:bdb0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:17c1:b0:359:8e5e:43de
 with SMTP id 98e67ed59e1d1-35dc6fcbd0cmr4002183a91.22.1775070441207; Wed, 01
 Apr 2026 12:07:21 -0700 (PDT)
Date: Wed, 1 Apr 2026 12:07:19 -0700
In-Reply-To: <ac1pUx_jYv2yCMnX@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331194033.3890309-1-jrhilke@google.com> <ac1hI93pEo-x-7YU@google.com>
 <ac1pUx_jYv2yCMnX@google.com>
Message-ID: <ac1s55_oLEUQx8Hs@google.com>
Subject: Re: [PATCH v2 00/14] KVM: selftests: Link with VFIO selftests lib and
 test device interrupts
From: Sean Christopherson <seanjc@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Josh Hilke <jrhilke@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="us-ascii"

On Wed, Apr 01, 2026, David Matlack wrote:
> On 2026-04-01 11:17 AM, Sean Christopherson wrote:
> > On Tue, Mar 31, 2026, Josh Hilke wrote:
> 
> > > This test only supports x86. Testing physical device interrupts (-d argument) is
> > > only supported for Intel because there are no VFIO selftest drivers for AMD
> > > devices.
> > 
> > This needs to be expressed in code and human readable error messages to the user.
> > I already knew the basic of what the VFIO selfests are doing, and it still took
> > me 5+ minutes to find the DSA driver and probing logic.
> > 
> > Concretely, this code needs to be part of the standard vfio selftests APIs:
> > 
> > 	device = vfio_pci_device_init(device_bdf, iommu);
> > 
> > 	has_driver = !!device->driver.ops;
> > 
> > E.g. have vfio_pci_device_init() explicitly return an error (or NULL) if it can't
> > init the device driver.
> 
> No. Not every VFIO selftest or user of libvfio needs a driver. A driver
> is only needed in tests that want to use the driver, i.e. want to call
> one of the very obviously named functions:
> 
>  - vfio_pci_driver_send_msi()
>  - vfio_pci_driver_memcpy()
>  - etc.
> 
> Requiring a driver for vfio_pci_device_init() to return non-NULL would
> significantly reduce our ability to test VFIO on different platforms and
> environments.

Ah, sorry.  I was speed reading and missed that some (most?) tests don't require
a driver.  Scratch the "make it unconditional", but there still needs to be an
API to up-level binding to a driver.  KVM selftests shouldn't have to manually
check for that.

> > The fixtures in vfio_pci_driver_test.c already blindly assume success, so you
> > might not need to do much beyond changing main() in that file.
> 
> I don't follow. What is the issue with vfio_pci_driver_test.?

What I was trying to say is that if vfio_pci_device_init() were to unconditionally
require a driver, then vfio_pci_driver_test() should Just Work.  But that doesn't
make a whole lot of sense given the above.  Though it could use the new API that
checks for a driver.

> > And then, also as a vfio_pci_device_xxx() API, add a helper to print out what
> > devices are supported, e.g. so that KVM selftests can do something like:
> 
> Agree this would be nice to have. Is this a blocker for this series?

Yes.  KVM selftests need to assert there's a driver before trying to proceed.

> > struct vfio_pci_device *kvm_vfio_device_init(const char *bdf)
> > {
> > 	struct vfio_pci_device *device;
> > 	struct iommu *iommu;
> > 
> > 	iommu = iommu_init(default_iommu_mode);
> > 
> > 	device = vfio_pci_device_init(bdf, iommu);
> > 	if (!device) {
> > 		vfio_pci_device_print_drivers(stderr);
> > 		TEST_FAIL("No driver found for BDF '%s'", bdf);
> > 	}
> > 	return device;
> > }
> > 
> > Because as is, this requires way too much a priori knowledge and magic for
> > upstream.  The user shouldn't have to dig through code just to understand what
> > devices are supported.
> >
> > Ideally, VFIO selftests would also provide a script, utility, and/or helper to
> > identify BDFs for devices it has drivers for.  In my experience, binding a device
> > to VFIO is trivial.  Finding the device in the first place is more annoying.
> 
> Agree this would be nice to have. Is this a blocker for this series?

Yes.  As I mentioned to Josh off-list, I'm not willing to accept a "we pinky-swear
we'll make this stuff user friendly".  It's not that I don't trust you and Josh
(and others), it's that for me, this level of user-friendly behavior isn't nice
to have, it's mandatory for these tests to be usable upstream.

Internally we can squeak by with barebones, unhelpful tests, because the run
commands are often hardcoded somewhere and there is piles of documentation elsewhere.
But for upstream, none of that holds true.

If it were weeks of effort, I would be more open to treating this as nice to have,
but AFAICT writing the code should be less than a days worth of work.
