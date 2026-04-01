Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE6B3126DD
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 18:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775069531; cv=none; b=rhehAxZ+q8mw3no9FFYcisdZuKjVNDrROgpGJW2DlJgEJxaFA3b+0n9nNC7ivaGUGmv+WOcSC/7HvtaDrtl45NHVHsykxGqvHs3rzUZv8ukUWWjXUmwQ85BRgNVYb/uqaKPun+zWtwS+KpRIvvf3mvLa+udlmH3grhPXJubl468=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775069531; c=relaxed/simple;
	bh=qgfGohko+APZAaH/7y2fR7nUw6KD1f1uI734TpAydHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6MrnctYUxtyw2uG6M8Lb7mPkLaan3hJyWIC7H5OOnoSNz7ZlMKYOwD68nXlcR0m3ffc2FlLZ/yWzMY1xi8Gu020oRvEBZpHzvhlvkE3pi686wIgIOoV0udJTtyPWLwozOKch3khuNc0fSUMpxuz+xvdBiOMLPardTJbDyDq96Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OPjQ8fzZ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OPjQ8fzZ"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82a67ce6969so66353b3a.1
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 11:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775069530; x=1775674330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tcs/cMuSXrZ4J+WkXbRV1FBy++2l4MW9BpKWgidiJTI=;
        b=OPjQ8fzZMS1ifImedtWklq4J/Lq+/oqhKlrleh+v2VDYjUxbgLe7P8mBcN/Qkn9ceq
         UoD1nP5ELpIUttF5NWJQvn9YeAG4tSC7+IQerr/p7tieNXpFWNiIney76E9Zq8eTYTTH
         HR38oU4b0MD3WNI1ba8bQpa+4zf8CU0yRei6nlcEteB1bUtCkEAJwV0uySk9HTWHU7bf
         Aoiagq7+hfEUy0cmweo8MvHDVBfd3SCv4SW8f8rEQdoa7DqZAwOuMG56liaigyV/9Bdo
         U4Y8h9kcFhoE9dnGb6ml68mQwhLaJ6xj3Bfo1mzK8TrxzHoBgmVLPMI/7WmRzX+GV8X0
         LbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775069530; x=1775674330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tcs/cMuSXrZ4J+WkXbRV1FBy++2l4MW9BpKWgidiJTI=;
        b=Y0v3Bv/t3CE4ca/TTG5DUZgx72GO8GRC73Jqk9tSqTMkAp6+2S50oDT0EmbPxUnjXD
         pBR2H5LH+NctH2wZdhz8Gob2g9oiLEp2RrfPkXda9ssgRxjyt3hNjq1RhGF/zmQmyuPC
         bVpnMakBE00JR/lq5g2enKqyvgqQQvIg6eA7M65Lp3fcKgadx7Xo2MWF7N9wI3hsofTS
         N+zoAl7osfQtzZlgsGWy2zdGy/OAAMevwxh/J//Q6EPaf10W4XLCjzIHXrCr6HBfH6uN
         k135/CdTSvcMuayJVxYuyN1ilLX69R88eEhWXAO3H/3j5yk7qfU9fqeuyLkIbw86T9On
         AuBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUfD3McHMJtmIvfuCm/6SxZLSYUO+4hWWmdSS+pVwt/EQwSW0U2wmvjHaarfhBiqO6wxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRNFDCasqPQjv54+CuU6mXlw/6H4a7vB3MJVGEyIX6GFCA32yO
	/kK4gy25bLYEZ4eGhRs61SWlTh6GrZhwx7tRLYKdwP/nulPoVvYPxLcjY4T4jFdTujGi9FxrDjQ
	Gf50pCQ==
X-Gm-Gg: ATEYQzzW+M9+PONgR9fKtYOuUBjEK2/HzrUcRLtXOHVoVd3IzKf93ungt6SuUicrH9A
	rS2l/TfcjhvzzRMxtt6ob6VAf93zBX5KrNwF+f9/nBEGIM/D8tlbBY1sQ1FwUklRYgTIaa3PVI+
	+BWrKHWUv5YraN+1A+keP9f80a5xauFodo2sZpgS99tyIPlHddYoJmU0cNvxWNUiddAZMmh1rO6
	sv/55K3+Zqc1jZQhDnVkgs10Ht4ViCk9jo7llCtqQjTmpXoBKpdS+S34sA2Gxe6UXcXPpNv8yV4
	VW3AEy1Qa6qhkzx5stjh7WOwxLY+J9fMFR4FvJvqzUo0H9hXkalQk0QDSoVoNwC0l8JtamYWaWy
	c3EmFc0GxgsOMr5PZcSO2ynM423PyZ+ZxOQG2RZLPRvKXnTO5TU7nC6JfSGYLIvuAn/hKg9eNWF
	msfug3WKgTLhAz+ESrOKzX5lqk86nhT8WWSPw5PNcq1wDKa0WeqezACOmNtxvCHQ==
X-Received: by 2002:a05:6a00:f97:b0:82a:805a:7cc with SMTP id d2e1a72fcca58-82ce88bbc42mr4637886b3a.4.1775069529369;
        Wed, 01 Apr 2026 11:52:09 -0700 (PDT)
Received: from google.com (239.23.105.34.bc.googleusercontent.com. [34.105.23.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b3aaeesm711791b3a.13.2026.04.01.11.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 11:52:07 -0700 (PDT)
Date: Wed, 1 Apr 2026 18:52:03 +0000
From: David Matlack <dmatlack@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Josh Hilke <jrhilke@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org, Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH v2 00/14] KVM: selftests: Link with VFIO selftests lib
 and test device interrupts
Message-ID: <ac1pUx_jYv2yCMnX@google.com>
References: <20260331194033.3890309-1-jrhilke@google.com>
 <ac1hI93pEo-x-7YU@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac1hI93pEo-x-7YU@google.com>

On 2026-04-01 11:17 AM, Sean Christopherson wrote:
> On Tue, Mar 31, 2026, Josh Hilke wrote:

> > This test only supports x86. Testing physical device interrupts (-d argument) is
> > only supported for Intel because there are no VFIO selftest drivers for AMD
> > devices.
> 
> This needs to be expressed in code and human readable error messages to the user.
> I already knew the basic of what the VFIO selfests are doing, and it still took
> me 5+ minutes to find the DSA driver and probing logic.
> 
> Concretely, this code needs to be part of the standard vfio selftests APIs:
> 
> 	device = vfio_pci_device_init(device_bdf, iommu);
> 
> 	has_driver = !!device->driver.ops;
> 
> E.g. have vfio_pci_device_init() explicitly return an error (or NULL) if it can't
> init the device driver.

No. Not every VFIO selftest or user of libvfio needs a driver. A driver
is only needed in tests that want to use the driver, i.e. want to call
one of the very obviously named functions:

 - vfio_pci_driver_send_msi()
 - vfio_pci_driver_memcpy()
 - etc.

Requiring a driver for vfio_pci_device_init() to return non-NULL would
significantly reduce our ability to test VFIO on different platforms and
environments.

> The fixtures in vfio_pci_driver_test.c already blindly assume success, so you
> might not need to do much beyond changing main() in that file.

I don't follow. What is the issue with vfio_pci_driver_test.?

> And then, also as a vfio_pci_device_xxx() API, add a helper to print out what
> devices are supported, e.g. so that KVM selftests can do something like:

Agree this would be nice to have. Is this a blocker for this series?

> struct vfio_pci_device *kvm_vfio_device_init(const char *bdf)
> {
> 	struct vfio_pci_device *device;
> 	struct iommu *iommu;
> 
> 	iommu = iommu_init(default_iommu_mode);
> 
> 	device = vfio_pci_device_init(bdf, iommu);
> 	if (!device) {
> 		vfio_pci_device_print_drivers(stderr);
> 		TEST_FAIL("No driver found for BDF '%s'", bdf);
> 	}
> 	return device;
> }
> 
> Because as is, this requires way too much a priori knowledge and magic for
> upstream.  The user shouldn't have to dig through code just to understand what
> devices are supported.
>
> Ideally, VFIO selftests would also provide a script, utility, and/or helper to
> identify BDFs for devices it has drivers for.  In my experience, binding a device
> to VFIO is trivial.  Finding the device in the first place is more annoying.

Agree this would be nice to have. Is this a blocker for this series?
