Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E923947B3
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 22:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774649085; cv=none; b=qTXAbIewrsaXJ1tjjebER2PLDltC80exWh3JFCW3LG+yeeKcY1Aqcj8LDi2nc9p1t9sq7GK1+pkhSW50L6Cc7lnbyfYNtU4UT41Q04UNyteYyg+t8rVhh8lraa1uv8fhyMLr4IbdcPr1FreVyNpT3kI2wLJkgEA93U/gXDI/hro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774649085; c=relaxed/simple;
	bh=GQwxsCPR8M9Q+995FFI0Q1eeMcYdZw4hKw95dWbIkVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkxAkTN2OKWC5qxbwEmgFS3kKqRH+PIrdZwk6sXGudu8ySmc8FYLMy+5O50guOJ7uQSfR2AuUHgtjkWDrl/o22Pystrfzv7P6RMzgEe5lQZznROEFTMiflTbYUVaOjdb1opdmvQft4m5ZmoDix/Ikx7rn3IBLrEJp5NHAXfnjwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sfAC/uhx; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sfAC/uhx"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-356337f058aso1553331a91.2
        for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 15:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774649083; x=1775253883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tv6xySEq32idoJ1hIz3yQfX8s88MuxVvezia0x+Hpy8=;
        b=sfAC/uhxxirjStfMAZrlGIzhd+b2nzK9q7Jf5D8PtwCaGyhtq0gqj93mG84bz3AUN2
         /jC9QTqIxN0naBmeoHUb2jFVBUY/kE83YzNsox4u8zVFZ64L2UWi5mRpIKLMvsLeWcqL
         aKmxJjiNuBjlHoS7V/dzSd8/2tg4L9ey7PhOPxovRy1Wky6TY1o16vb5E/otXMOheSwK
         uxZTEiYma4WK55N6WCH8B4ncK7NmKcF9q8Li6hvCicfNKW+q68gNUBoo2s5eMMwGArI9
         fYtJN83WUXvVGBoc7hixFH6MSvqzie1Fyp+3MURidcSxNKQz7KgxBktcNVmGODRRO8GE
         9JaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774649083; x=1775253883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tv6xySEq32idoJ1hIz3yQfX8s88MuxVvezia0x+Hpy8=;
        b=F7j1UUNHy4sDlCnRZ0g+Pyajc5X1x+HCNVrcrvwHdPI/q2hh0bp/iElLH/Tr2aDDYd
         CyXfAPtOf5JhpI1k93ROU6puuQB8LaPH/tv+aN1HzhhVJsmJrHEXBdVQATIPEgT0Lusu
         +ott7KePJjT8y3Yf7Qnuvo/M1A+rd+26Eyskvf6WCcuiEvmw8eVd7Jv8du98oVPbirTf
         6J5EbCYZnvFAyjEGcocwxwt9z85fXiMJ4L1DPaxe/N3PGL1ZxNdA/0cnTLL/1bVl/CPw
         3x7xu9AhtvZjOEd8FQmCWlOETAB5ov4akduk6q+Vd4hu/jsRcJAUeSt7Rm3GF5M0Kzyr
         Yoew==
X-Forwarded-Encrypted: i=1; AJvYcCWMKQM4Sbekddtkv4TGc4PKqsmm616SEUXBD0eVQxRXqxiJPX6sww325jmaeaNpIPPfTCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMTLvwdnR+hYRycuCqNvr3QudMBicIH80vlkQN7c3/HGivG0+b
	9CCE89MGbpz4vyhR5WQ+r/dRiBXzQ2iJ7gRiO2x8agBxnoJ4kVBArZuWuI0AkDAdEg==
X-Gm-Gg: ATEYQzwquNNKIlhijOmhVBvbf1PxSYHTYnq21CjJegEDTWMhEqmbNYo/2hjAAEjmBEU
	V4Zg8Ux7gLo0YZ5NjtcprvEsWUd1as3PZcfTlHQvsiMb/9w0i8f+LFwhoi8Rj++jzIqVXMpnXF2
	N3OAwhmbzCeStSlNrFoosp6aGozI34XgidaaUxy0WlBIaH1KQjJRfNCiflkqXr2KzQ1Dqzf/FOM
	Zc+JSjBHu0IlipZoAHY9XhhgABVxu2vbLqVrUGsGj911WXJXnBURDIs5yhuTc8D0I/5cVZBNwNC
	bJ838DWG6sNJq2bArP+8XCjI3SUhiSUEOazi6lHzZ4PDttpVr9F+PL4gU4hwklEdbrcP8JyzQWP
	eDPvjKgKfxfQ3WVhpWA9Prpm37V7wL4V8dolcavJqaCNzzN0+vTohKqwOPBsHPq2PNZbrx0RxlN
	tSPWBfN4UkbojQdIjC4iIgksBFP1U75788wForZCFOHAp2Wk01xWuLttG75GbV1w==
X-Received: by 2002:a17:90b:3b4f:b0:35c:cba:3453 with SMTP id 98e67ed59e1d1-35c30076fe2mr4060371a91.22.1774649082871;
        Fri, 27 Mar 2026 15:04:42 -0700 (PDT)
Received: from google.com (239.23.105.34.bc.googleusercontent.com. [34.105.23.239])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35d9507dd72sm138872a91.12.2026.03.27.15.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 15:04:41 -0700 (PDT)
Date: Fri, 27 Mar 2026 22:04:37 +0000
From: David Matlack <dmatlack@google.com>
To: Rubin Du <rubind@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 1/2] selftests/vfio: Add NO_SEND_MSI feature flag and
 MSI helper macros
Message-ID: <acb-9VOaA6Ld9BdY@google.com>
References: <20260325214329.464727-1-rubind@nvidia.com>
 <20260325214329.464727-2-rubind@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325214329.464727-2-rubind@nvidia.com>

On 2026-03-25 02:43 PM, Rubin Du wrote:

> diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_driver.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_driver.h
> index e5ada209b1d1..f2cf2608f757 100644
> --- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_driver.h
> +++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_driver.h
> @@ -6,6 +6,8 @@
>  
>  struct vfio_pci_device;
>  
> +#define VFIO_PCI_DRIVER_F_NO_SEND_MSI	(1UL << 0) /* Device cannot trigger MSI */

I don't see any particular reason to add this flag. All of the checks
for...

  device->driver.feature & VFIO_PCI_DRIVER_F_NO_SEND_MSI

can just be rewritten as...

  !device->driver.ops->send_msi

to accomplish the same thing. And the latter is less characters while
still being readable.

> -void vfio_pci_driver_send_msi(struct vfio_pci_device *device)
> +int vfio_pci_driver_send_msi(struct vfio_pci_device *device)
>  {
>  	struct vfio_pci_driver *driver = &device->driver;
>  
> +	if (driver->features & VFIO_PCI_DRIVER_F_NO_SEND_MSI)
> +		return -EOPNOTSUPP;
> +

I think it would be better to just let vfio_pci_driver_send_msi() fail
if send_msi() is NULL.

Tests should not be calling vfio_pci_driver_send_msi() if the driver
does not support send_msi(). Tests that require send_msi() should
explicitly check for it, rather than detect it by trying to send an MSI.

It's also more readable to explicitly check for send_msi() support
rather than silently skipping or exiting if send_msi() returns an error.
The latter reads like it could be due to some problem on the device,
rather than just a lack of support in the driver.

> -#define ASSERT_NO_MSI(_eventfd) do {			\
> -	u64 __value;					\
> -							\
> -	ASSERT_EQ(-1, read(_eventfd, &__value, 8));	\
> -	ASSERT_EQ(EAGAIN, errno);			\
> +#define fcntl_set_msi_nonblock(_self) do {				\
> +	if (!(_self->device->driver.features & VFIO_PCI_DRIVER_F_NO_SEND_MSI)) \
> +		fcntl_set_nonblock(_self->msi_fd);			\
> +} while (0)

I think it may be worthwhile to have the nv_falcon driver still enable
at least one MSI or MSI-x vector on the device and set driver->msi. This
will reduce divergence from other drivers, and simplify this commit down
to just:

diff --git a/tools/testing/selftests/vfio/vfio_pci_driver_test.c b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
index afa0480ddd9b..ebd66d677abb 100644
--- a/tools/testing/selftests/vfio/vfio_pci_driver_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
@@ -175,6 +175,9 @@ TEST_F(vfio_pci_driver_test, send_msi)
 {
        u64 value;

+       if (!self->device->driver.ops->send_msi)
+               SKIP(return, "Driver does not support send_msi()");
+
        vfio_pci_driver_send_msi(self->device);
        ASSERT_EQ(8, read(self->msi_fd, &value, 8));
        ASSERT_EQ(1, value);
@@ -201,6 +204,9 @@ TEST_F(vfio_pci_driver_test, mix_and_match)
                                       self->dst_iova,
                                       self->size);

+               if (!self->device->driver.ops->send_msi)
+                       continue;
+
                vfio_pci_driver_send_msi(self->device);
                ASSERT_EQ(8, read(self->msi_fd, &value, 8));
                ASSERT_EQ(1, value);

>  TEST_F(vfio_pci_driver_test, send_msi)
>  {
>  	u64 value;
>  
> -	vfio_pci_driver_send_msi(self->device);
> +	if (vfio_pci_driver_send_msi(self->device))
> +		SKIP(return, "Device does not support MSI\n");

NV GPUs do support MSI/x though, right? This should probably be:

  SKIP(return, "Driver does not support send_msi()\n");
