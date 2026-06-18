Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67829331213
	for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 20:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781814123; cv=none; b=r11Z45QG8kuzmnUhf4NqJ+R3u18+m6Ew7Jo6Nae0+F7AEvjO6nTZmQOWfjD0gNEzC1rBv5trJUrqsqRWTiVR4nhYiwnxvVGlBs1tzihLiOYPYOa7kqdw3oRbqQncKaXCUZSpEG3I4L5hcXI7ijjWZqf5pKhLt9A04DVTG+sBqr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781814123; c=relaxed/simple;
	bh=oZHAxpIqUFadijIyqON+Dd9Hmvbr+/PPGnzg5RHUNoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uURIurWH6265G9M69SNC42NwKQoc4hkNwc/BBlwkXDY61OR3e2ywBo1rnprWvooCGsBBvKiZeu5WXIwGkzIMqMcd6ZpWa66JLcOCpoxZfGXQRYflmp6K6z7/lyCyfLp6+IoFXIvtt9IU0+hgtBiXrnxzN/tSwRW7RvZOC066tts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ujUaSZ9C; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ujUaSZ9C"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8422871b42dso994870b3a.3
        for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 13:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781814122; x=1782418922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R8xCK89QfRMaVvrkpnB5YO+Fnx8pGynYV6YoyF7gSgA=;
        b=ujUaSZ9CRapWP6uS6U4fa+dmeKf9GDu+09hObA58BmiAQr0YR716EzqrDpXj2W9+Zt
         q5vzucTO5ydIeP2X/E0Fr+dqS4S+f5eb1PB/VOz57hGwOKm7KSn9feqmPjHjo/4WZBD3
         tgCr5rDSmkaAivOFdPtLBonEkzK3tNv5dyQDkL5uhFWEU5IO0Fonw4fNe6VngzPKC2CY
         RfzAu73uleo+sXiTdXPFNbrUauYAgVJeCrkYTj02jDq5y2E4pVI1V0WMDGc/tkegkWoo
         9UvxmbPBHLC2l8tYtPWnmguNI7q87bOZ5upWDU6XHyKqht+AKA878uEovRoTdjvJMbMS
         4APw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781814122; x=1782418922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8xCK89QfRMaVvrkpnB5YO+Fnx8pGynYV6YoyF7gSgA=;
        b=Z9B49J7IY7S5alCiKyE6RcXFXHf/OXMB07sDhO4YcZn5L0LpwbzGVYubv3/QXuvmez
         JFuZMqbTpcHJIBiWzzxabh/bTdx8snXtEEv4r6cEt7cdMPRrB5lfbdCI6l4GJVhyoOyt
         ekDTSZKz4ntGQfz7i7bW7GR4rEaNQDkq4YwsDympRD5GRoIxfgF7kuU1XsrUeG4ZBiMe
         JEapl5P2R3329mjb4WbJpdu/mIbXgaw1CvW60ONS7YrtQXer3xAJtw8ODlPaO0NxKWfs
         8VF5QaSMc6kppvaQKtzh9gJhoWymOXHcKC04pt9x6qLrsyb2M+1cAjLWZcgbH8HkVPL3
         8hwQ==
X-Forwarded-Encrypted: i=1; AFNElJ/MVQncEslblBwASbFKNkCIn1wxWSnLTvXpnErennWYYF345ia++eZNeOuYKcCGnBnUluQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4VaPqg4fTpgJSiuzUzCiuU6mHll+pPzgQC9013JsaFB9BBMOi
	1kfZrG4BOJpb+tlAvc1igYh6ehCbS8A74+0fC69A/Wn5WDBPsleaXd4zYH4CwfxxLA==
X-Gm-Gg: AfdE7cmsPxrBr+7jBMYWeQzH25yJP5Nj3hffYxfCheLDKumegHL19M/oI0qkOEQbjeq
	WPfyZwXwKAuI/MXZDWPQokpuIGT4BXETSeFKgsZJC5huAaBuqKa8dcj+ueO1NVvccZd7jwoKzKU
	3Uc2RLU6MO211VvyGygxY3CylWbIBtVs2Y+jOnPVXF0JsC1xDO7ZuRR8J/BAu9caWNPY+U9jRAA
	vlXwCgeYYjBaKUaWIhOdJeEpMk5d03XUEgOlh6PkIs6QtiPzmzq2qreeY+MRcUKacgvRsOPK3DC
	L2+dR7F3d/IYxxJyEwOY1PompcP47MTuNtK3hWlRhmaFabg3tT+OY1OkPMGIYwMN3639gNvj2xX
	4O1DZ/f/FlZ6/Hpzw3Z+c7A6emN2dG7+Ruk19yKi09lmfwxc5/6YJjT2SeExAP62mdYI8POmSG8
	Ig8u4JCCZs59AU0MwpV5eRdKpYkGfti5LY/+5tRH8zTm4lFD/SlO8=
X-Received: by 2002:a05:6a00:4fd1:b0:845:17a6:5741 with SMTP id d2e1a72fcca58-8455079c80amr485384b3a.1.1781814121017;
        Thu, 18 Jun 2026 13:22:01 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8453a8c9770sm3735614b3a.40.2026.06.18.13.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 13:22:00 -0700 (PDT)
Date: Thu, 18 Jun 2026 20:21:56 +0000
From: David Matlack <dmatlack@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, Josh Hilke <jrhilke@google.com>
Subject: Re: [PATCH v7 09/20] KVM: selftests: Add VFIO device support to
 eventfd IRQ test
Message-ID: <ajRTZNum3u7oVdRa@google.com>
References: <20260613002031.745413-1-seanjc@google.com>
 <20260613002031.745413-10-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613002031.745413-10-seanjc@google.com>

On 2026-06-12 05:20 PM, Sean Christopherson wrote:
> From: David Matlack <dmatlack@google.com>
> 
> Extend the eventfd IRQ test with a '-d' argument that takes a BDF (in the
> format segment:bus:device.function) of an interrupt-capable PCI(e) device
> bound to VFIO, and use said device to trigger interrupts instead of always
> synthesizing interrupts via direct writes to the eventfd.
> 
> Using a VFIO device to trigger interrupts validates the end-to-end delivery
> of IRQs for "real" devices, and when supported by hardware (and KVM), also
> validates interrupt delivery via IRQ bypass, i.e. via device posted IRQs.
> 
> Now that IOMMUFD is a thing, auto-probe IOMMUFD vs. "legacy" VFIO by
> temporarily opening /dev/iommufd, and skip the test if neither IOMMUFD nor
> legacy VFIO is available.  Add a '-t' option to the user override the probe
> logic, e.g. in case IOMMUFD is available but the system is configured for
> legacy usage.
> 
> Note, the device must have a VFIO selftest driver in order to work with
> the test.  A helper script to list supported devices will hopefully be
> available in the near future at
> tools/testing/selftests/vfio/scripts/list_supported_devices.sh[1].

> +static int vfio_setup_msi(struct vfio_pci_device *device)
> +{
> +	const int flags = MAP_SHARED | MAP_ANONYMOUS;
> +	const int prot = PROT_READ | PROT_WRITE;
> +	struct dma_region *region;
> +
> +	/* A driver is required to generate an MSI. */
> +	TEST_REQUIRE(device->driver.ops);

This series is probably going to race with merging another VFIO
selftests patch to make send_msi() optional [1]. Can you add a check for
that here?

  TEST_REQUIRE(device->driver.ops);
  TEST_REQUIRE(device->driver.ops->send_msi);

[1] https://lore.kernel.org/kvm/20260609232855.3808971-4-rubind@nvidia.com/
