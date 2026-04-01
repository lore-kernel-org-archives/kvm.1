Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4249431F9B8
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 18:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775067430; cv=none; b=jjbI2gxCyZj0NA3ft+XzpYQTwcXb1QaYZ1gHfj0U+fl0SuqdrQlIrTUsVbO59z2E7tG1LtiGQpQTKowi/hapIsZKqmP9dpqyKczf9Zsa0cy3v3VunB1iiC6xvkD0mI4bDS5fMZWjPhjBj9OPwd+8h1EtOiTpHwVJNYpGw2fI6fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775067430; c=relaxed/simple;
	bh=Ga5/kXppr8tHg99F0gwsmidHZ4K9YCHVNDuFh3nru1c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o4XUWQI0uZTo6P5y1Jfno5EPDXBWaB5+pNS/ZiSWiywkFOknZLpWUS9I+kNt6IhqI7TdNiFHLYmQVOnSoeoSAxBtXnEnu7zeJKCMyMsP2qBroKijLoqBnk1diUj0YWEU5N73nYLMiZZ1QlrmjZqDSETeSGSS0YyHhf/HEnRzypo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nR8/JJM8; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nR8/JJM8"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82c1e1a6cfbso35949b3a.0
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 11:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775067428; x=1775672228; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6vWWPhf7ZNdjzCqefkDcQm+0NJ30EIeHJK2BcUqkjjY=;
        b=nR8/JJM8HIeyeA3B7UndMkkj1NqbOuyG8InWWYwWlV7Jz2iheRB8Nd9GMosQIGSHmL
         FtO4LwIdbhY1O5HC3fQ868ZNFRabqucYd9uA567IY2eFpyjEYUoAPmVaFw3rCIyVa4Tg
         XymaWMCZnArmJhtkkLX5/SzyO0FdacnAN9vgtneuV9bjbSHZ61AAqdEoA6DlmOXa3oBh
         OY0qAyJNymFkdfrf+c9xTea8CQHnWTPTiD+CWat601bHN1ObmevE0w/sEGAwCrzhhJ3V
         GeUWvn0EdERGgVQa045ywT1P5v7D+sq379kz4wc2spc1fsW+fyG7wCjLu8BzcMxFzbKt
         0EQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775067428; x=1775672228;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6vWWPhf7ZNdjzCqefkDcQm+0NJ30EIeHJK2BcUqkjjY=;
        b=Q2btVo6YoiK3MgJibIXs5lUyRc1+3qUgtPhf7+n6jqOpbriJhyT6NUX11kV8wsE80z
         LgtQXyY0PLRxJ2E86YDlzfz1FBniHTJCNoRwI6AbWBDyO2lnR0RcCO223AGJeP0+O0re
         rSQ6vEhNNGWdkAPR46iRZN1bdErp9TbTW4CtP8LNZKzd0T95m2IdLVYExwn/Nz0+Wdpo
         ZPnVpBE8yI+/kX6ZIKLkkyxPVegApGtKYr0KQliP6g0qhqQ2C4Dv8uFB5utEdz+U/fRV
         dbrnJFFkvqbCFWk+1hfQbVqRP8oweywJnexe27LdRf2z+l1CpfCBK2PPaU4pCJCuLUMr
         QfIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwdwf3lOQ2Ed5E7BD9/q2lY9A20l7TQH4Unw1Tyxwk4lUyZaH4K3lA/h5fX4hFK5SlL1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqwaHFz2WmILKPZ2b3AyZAa0mheOaVMMSli74vo8qqfHUymljm
	TYiMCk/jgqsXoiXUB8T9ZEBESd1n7kdpKlYUHwWqvpwUPG2TGyjYM7qyzWad1M5WLxlp4EE4Nsn
	67EcnNw==
X-Received: from pfbfb9.prod.google.com ([2002:a05:6a00:2d89:b0:829:874e:d076])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:14c8:b0:82c:e60c:f36d
 with SMTP id d2e1a72fcca58-82ce8b1a446mr5342728b3a.48.1775067428435; Wed, 01
 Apr 2026 11:17:08 -0700 (PDT)
Date: Wed, 1 Apr 2026 11:17:07 -0700
In-Reply-To: <20260331194033.3890309-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331194033.3890309-1-jrhilke@google.com>
Message-ID: <ac1hI93pEo-x-7YU@google.com>
Subject: Re: [PATCH v2 00/14] KVM: selftests: Link with VFIO selftests lib and
 test device interrupts
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 31, 2026, Josh Hilke wrote:
> I am taking over development of this series from David Matlack. 
> v1: https://lore.kernel.org/kvm/20250912222525.2515416-1-dmatlack@google.com/
> 
> This series is based on the kvm-upstream/queue branch.
> 
> This series introduces vfio_pci_irq_test, which exercises the delivery
> of VFIO device interrupts (MSI/MSI-X) to guest vCPUs, and links the
> VFIO selftests library into KVM selftests to enable testing of VFIO-KVM
> interactions.
> 
> The test requires a PCI device bound to vfio-pci. It can be invoked by
> passing the BDF the VFIO selftests setup script,

-ENOPARSE

> and then running the test with the device BDF:
> 
>   $ ./tools/testing/selftests/vfio/scripts/setup.sh 0000:6a:01.0

IIUC, what this is saying is that to run the test, the device needs to be bound
to VFIO, and _one_ way to do that is to use ./tools/testing/selftests/vfio/scripts/setup.sh
to do the heavy lifting.

>   $ tools/testing/selftests/kvm/vfio_pci_irq_test 0000:6a:01.0
> 
> This test only supports x86. Testing physical device interrupts (-d argument) is
> only supported for Intel because there are no VFIO selftest drivers for AMD
> devices.

This needs to be expressed in code and human readable error messages to the user.
I already knew the basic of what the VFIO selfests are doing, and it still took
me 5+ minutes to find the DSA driver and probing logic.

Concretely, this code needs to be part of the standard vfio selftests APIs:

	device = vfio_pci_device_init(device_bdf, iommu);

	has_driver = !!device->driver.ops;

E.g. have vfio_pci_device_init() explicitly return an error (or NULL) if it can't
init the device driver.

The fixtures in vfio_pci_driver_test.c already blindly assume success, so you
might not need to do much beyond changing main() in that file.

And then, also as a vfio_pci_device_xxx() API, add a helper to print out what
devices are supported, e.g. so that KVM selftests can do something like:

struct vfio_pci_device *kvm_vfio_device_init(const char *bdf)
{
	struct vfio_pci_device *device;
	struct iommu *iommu;

	iommu = iommu_init(default_iommu_mode);

	device = vfio_pci_device_init(bdf, iommu);
	if (!device) {
		vfio_pci_device_print_drivers(stderr);
		TEST_FAIL("No driver found for BDF '%s'", bdf);
	}
	return device;
}

Because as is, this requires way too much a priori knowledge and magic for
upstream.  The user shouldn't have to dig through code just to understand what
devices are supported.

Ideally, VFIO selftests would also provide a script, utility, and/or helper to
identify BDFs for devices it has drivers for.  In my experience, binding a device
to VFIO is trivial.  Finding the device in the first place is more annoying.

> David Matlack (11):
>   KVM: selftests: Build and link sefltests/vfio/lib into KVM selftests
>   KVM: selftests: Add vfio_pci_irq_test

Make this one human friendly, e.g.

 KVM: selftests: Add a test to verify IRQ delivery from assigned VFIO devices

>   KVM: selftests: Add support for random host IRQ affinity
>   KVM: selftests: Allow blocking vCPUs via HLT
>   KVM: selftests: Add support for physical device MSI triggers
>   KVM: selftests: Add option to clear GSI routes
>   KVM: selftests: Make test IRQ count configurable
>   KVM: selftests: Add support for NMI delivery
>   KVM: selftests: Add support for vCPU pinning
>   KVM: selftests: Support testing with multiple vCPUs
>   KVM: selftests: Add xAPIC mode support

And then for these shortlog, explicitly call out what test they are changing.
The "Allow blocking vCPUs via HLT" shortlog in particular was super confusing.
E.g.

 KVM: selftests: Extend VFIO IRQ test to validate waking vCPU from HLT

> Josh Hilke (3):
>   KVM: selftests: Add helper functions for IRQ testing
>   KVM: selftests: Reproduce tests that rely on randomization

Please post this as a separate, standalone patch.  It's a fix that isn't dependent
on this series in any way.

>   KVM: selftests: Make vfio_pci_irq_test timeout configurable
