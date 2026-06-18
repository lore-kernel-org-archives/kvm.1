Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDED14ABE
	for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 21:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781818956; cv=none; b=H+bWbb5ZOXYnKcJGVy7oFFHjb5lX+PqmDNefYnWFqMZ1ajXNWo3ZhOJrx+Cuxten9StN/ZLDEOwUTA+XiqPy3zLzZ4+wgHLBn1LZfPrKZPkKkFqtq+dmUwkwazQPUIYWxEFX/rAPwjGCEx3GGGwNd6I9B0eqGC1afhjC8r/CzAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781818956; c=relaxed/simple;
	bh=erAt7Hebe5cIxFrAXhISXrNJA158nQ36dNCzkxhvulM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JACbinmjnJfrBCo4URkiZlzU0lFpnCrl0qA61hc7uf5UGqjxHq0t43HX4E2nWxiqGhYdxuIgU9prtXF6/+suW4slDidJFIeIx6GNeeLHr9ype6kll7DKfmVSrFA3Ry4xGGm07jjErXJqQYule7LV8LGcM5UNBwu5TLZGvVTNDk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=efNiH//p; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="efNiH//p"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8422f987f2eso2137758b3a.3
        for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 14:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781818955; x=1782423755; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V8j94fpKwfXbxZh5xLHwe7ucGfUmxazlRZU8sB7HYkU=;
        b=efNiH//p9L7qAEeTwRmCwDS7VkNYDD2hnVjyL7LELGostHKh3XUcG9HPLV1C+5siy7
         MmxeATXyLygCPGvjK+6Z6vUlDGm/yoD3bJBmXQunPbBjdemYHRNSnBhf5F0oIOASInGD
         ketJMfUb/ZDwkjqfd5Z+3B8TlRCanugN/E0tWGwhjgKyUIVRbaa+43JKNPGr4ypbqG3F
         LyFZqNaHC/wuExtRIBEdf7IewltVXMYbxqmnE6ROq6ES4Qxg8JQemejgtZ3S1HYM3cWB
         lTCb7wM6spvg40GK1otDOX3wzrOs25pABZgRAllVqydpkeotNGup1QBKSbu+/WNK/PCH
         c/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781818955; x=1782423755;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V8j94fpKwfXbxZh5xLHwe7ucGfUmxazlRZU8sB7HYkU=;
        b=X1mj75gtTZP/LOzqF/ctxGGGF+GIck7T4YdyBnm2I1BHnPvPmR3D5ZVs+MnFyuUdWQ
         hRUZrgzvJhEfHi7dBfsl+QiPzvJSB3oVpGDflUNFBhV4a6BfBPypXVKZqhOfFwzF15gq
         0jNRkWyoXjp7bmCBoY8hN2Oo3iKf7vdF2sIazSfWw94CXhECeNJlIEqus40tN8acKAJW
         ohwsajfLapjgrZRJNbq5qi+aRxpAbJsJqHYO5VEoVAaq3x9p4O03j8g+qooeDgEcyRDJ
         XSi4Q86Uur8pxO/olGUbSX2mZK01YvTpiivUcMotkvdlYpITPy78gROGEB23f6KoDzb8
         2LTg==
X-Forwarded-Encrypted: i=1; AFNElJ/zCWS+p2r1n7Xpa2JE40h/4qkRGn01rsjvXRZIcS5anCK9jhnQFPU+UHbyqa8rSfkWHuA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw26ReJowBoze/LfI5v7MnxqxXaHxFqYdhAt+0V6E7b0JyrgGiq
	TPMWGaMxOGEbd54fk0gjHF5RPcHcwHpsugkxcBPILsq/LvBIGe8wiDBfudI9QkUHZp72YjVscgJ
	rmrUGAA==
X-Received: from pfbjc15.prod.google.com ([2002:a05:6a00:6c8f:b0:82f:20ed:8059])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:6c9c:b0:845:374f:4ee7
 with SMTP id d2e1a72fcca58-845507dabc4mr738565b3a.13.1781818954904; Thu, 18
 Jun 2026 14:42:34 -0700 (PDT)
Date: Thu, 18 Jun 2026 14:42:34 -0700
In-Reply-To: <ajRTZNum3u7oVdRa@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613002031.745413-1-seanjc@google.com> <20260613002031.745413-10-seanjc@google.com>
 <ajRTZNum3u7oVdRa@google.com>
Message-ID: <ajRmStVr-2-QgqGB@google.com>
Subject: Re: [PATCH v7 09/20] KVM: selftests: Add VFIO device support to
 eventfd IRQ test
From: Sean Christopherson <seanjc@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 18, 2026, David Matlack wrote:
> On 2026-06-12 05:20 PM, Sean Christopherson wrote:
> > From: David Matlack <dmatlack@google.com>
> > 
> > Extend the eventfd IRQ test with a '-d' argument that takes a BDF (in the
> > format segment:bus:device.function) of an interrupt-capable PCI(e) device
> > bound to VFIO, and use said device to trigger interrupts instead of always
> > synthesizing interrupts via direct writes to the eventfd.
> > 
> > Using a VFIO device to trigger interrupts validates the end-to-end delivery
> > of IRQs for "real" devices, and when supported by hardware (and KVM), also
> > validates interrupt delivery via IRQ bypass, i.e. via device posted IRQs.
> > 
> > Now that IOMMUFD is a thing, auto-probe IOMMUFD vs. "legacy" VFIO by
> > temporarily opening /dev/iommufd, and skip the test if neither IOMMUFD nor
> > legacy VFIO is available.  Add a '-t' option to the user override the probe
> > logic, e.g. in case IOMMUFD is available but the system is configured for
> > legacy usage.
> > 
> > Note, the device must have a VFIO selftest driver in order to work with
> > the test.  A helper script to list supported devices will hopefully be
> > available in the near future at
> > tools/testing/selftests/vfio/scripts/list_supported_devices.sh[1].
> 
> > +static int vfio_setup_msi(struct vfio_pci_device *device)
> > +{
> > +	const int flags = MAP_SHARED | MAP_ANONYMOUS;
> > +	const int prot = PROT_READ | PROT_WRITE;
> > +	struct dma_region *region;
> > +
> > +	/* A driver is required to generate an MSI. */
> > +	TEST_REQUIRE(device->driver.ops);
> 
> This series is probably going to race with merging another VFIO
> selftests patch to make send_msi() optional [1]. Can you add a check for
> that here?
> 
>   TEST_REQUIRE(device->driver.ops);
>   TEST_REQUIRE(device->driver.ops->send_msi);

Ya, will do.
