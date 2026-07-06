Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8406443C7B7
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 21:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783371786; cv=none; b=qhN7eejT2FpeT827UPyW34r3oakZ6FstHTBkNgEPkoiJmsEmBtFE/sANkqSnwUuEoiT8ReUxa4R1hAT2q+ddRs4BQ6NuGaf5AB+lDWkxo3K+lhx1DTEoP8UC0iLZswAyndQQ0OQ6yyASq9IVzwN/y//hPRb6NxndlBBgeaAYeuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783371786; c=relaxed/simple;
	bh=fRwVRAmzazXUDn32KSeqZ5ViQIt0hag1CTDsltSIb9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svPeQwMMQXQwxO5OEoYRy4duMXe/UD3alS6et9FfFmd0S+tibUpsAf8ecPF29KN/7qLD0oOSAlGcqDs+js9cue6sOBlnhmNsk/2zPvmQW+Mf6u2foGp3/rMPkPeckud21WQjzD9G50QrWJBjN4Gs3ZtvAf6SBN7qVVtgB0qS7vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MlXmPUlh; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MlXmPUlh"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c7cfa17fedso39712445ad.3
        for <kvm@vger.kernel.org>; Mon, 06 Jul 2026 14:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783371785; x=1783976585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/hCewW54bhoxJS9ZE+EEQyKSlMWHdo4kMqBhJSyC7fA=;
        b=MlXmPUlh7T/7eHjYWGaQKg1x+NzDbGjz4dz7mfnPDvUzomAuE4pxpvcgIlDFgsAYK6
         67hq0dav7zTfuMzXIagQaZ24xabqkLGA8L64j9YFU9YeVItYE6gXDdKY4TvgBw8XlfCE
         Sjhg/1nucr0v6xCG5C5RPZEdVd2N0cdaLUNuR5Cth3w701lKafM6oFM9YUowGtFpZcnb
         NeS+8mtDxJ9lCHNLOlw/KH9sJutei6PUGf2ymiOGQB9+t2FYnwp1g1cmDxnA6n8KUX5t
         PPUTlTtzQiCeIQV0qsdgswIEPzlmgh87rFgrFC2BSPRSmuQdluqUzvntVB4h7vGYVeck
         FKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783371785; x=1783976585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hCewW54bhoxJS9ZE+EEQyKSlMWHdo4kMqBhJSyC7fA=;
        b=rYbQAoB4fHrWYt25aNLcxMKWiMRgTH4SE+51Vmheb4WjBeyzjh8AOBwOJoJX2WCXMy
         85TvcnTDjykVZkffs/VQiOxJPs+iV+egzeK9iVnkpkk6znYvX7Oe6eZEqr367oJSbVge
         yqoJ97YwMV+NIBAPLBnWk2o5qxdAz/lsZaYPjCtyFeVQRIk1U+iPkexgV1loJokXZqX0
         6BQUo/6GmOGY5JlT6Xx0Ey8KDypuamJn03VELSNVvHwhGj5vQOMJdFzIHPE5kkJNsS9r
         Mz0jc+kdknpjhpEsR4Yu/5r31EGbNg1tXqLSFS3m2J7OIYhUtx/59xAND7kGC/pTmDs8
         knLA==
X-Forwarded-Encrypted: i=1; AHgh+RoGpDgJ1TLit1ZefwXT87AmKg0zgtT7HiQgmJZUXm92jIV3wpbWHy5Q1iocE+1Lyv2dt2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlXNdSY5HkQ7/uBqC2qaDmOLIs16s+wvSI8IZmx9QY3R53qeF2
	9Px0ApTfKUU/f50PYzcMJh5ryEE3+ebx2P6gIIE/+jKxnvr9HEahsQI7oQCVPeRN1Q==
X-Gm-Gg: AfdE7ck/FOnQ5RqPkFEOWMq1h5s75B+y21CoaivxXC7Nabs59DHigqV+qQxrYBLtr3k
	2yjhCofSRsNEWoSBr7r9aDy8UbrdQeSlRWWZlJuM60Yc3IoYV2PHz00OKWS5zz5b39uj8MjWCdX
	xXfbXN+qXg4EoF5FOvCyOcH6xIWHiFWchg7otPVZpPQpKbtTaPK9bDxNGHLvTfovFCyM1aKoy05
	8UySPhazyNQH6BfVRBMFEtj8K8nG8kuV62mbdYFCsr1qtd1Q8c3gKNwzxPiGaJtN7XiTjIfyDmi
	qF2EpGXH0gBghEV3xY6Gm5uJ36dWhXgEhUnJ+Y/HstnVhQADMwQND7LaiNZqgR5R+6stmbLqEEZ
	1Qh+QHROvoLDrt9erLf+ydhGpfF3Nukb3QPJNTaAIUgUb6dMK+BRmGxoPttT1ADioJgjbCc1iQG
	4nRFs7Q/ug98ms5f4W90+ZI+yjsQgWwJLPA9WvDFX72MZsE0MLBvM=
X-Received: by 2002:a17:90b:51cf:b0:37f:eda5:5169 with SMTP id 98e67ed59e1d1-38755d40263mr2591393a91.13.1783371784418;
        Mon, 06 Jul 2026 14:03:04 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d3d66036sm146a91.17.2026.07.06.14.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 14:03:03 -0700 (PDT)
Date: Mon, 6 Jul 2026 21:03:01 +0000
From: David Matlack <dmatlack@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Vipin Sharma <vipinsh@google.com>,
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Alex Williamson <alex.williamson@nvidia.com>
Subject: Re: [PATCH v2 07/10] selftests/vfio: Add vfio_pci_irq_reenable()
 helper
Message-ID: <akwYBagw3pFsN0Mt@google.com>
References: <20260526235417.2058313-1-jrhilke@google.com>
 <20260526235417.2058313-8-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526235417.2058313-8-jrhilke@google.com>

On 2026-05-26 11:54 PM, Josh Hilke wrote:
> From: Alex Williamson <alex.williamson@nvidia.com>
> 
> Selftest drivers that recover from a fault by issuing VFIO_DEVICE_RESET
> need to re-arm device interrupts afterwards.  VFIO_DEVICE_RESET tears
> down the kernel-side IRQ trigger so a subsequent VFIO_DEVICE_SET_IRQS
> is required, but the user-side eventfds (and any fd cached in a test
> fixture) are still valid and must be preserved.
> 
> vfio_pci_irq_enable() refuses to be called for vectors that already
> have an eventfd (VFIO_ASSERT_LT), and vfio_pci_irq_disable() closes
> all eventfds before resetting the trigger, so neither is suitable.
> 
> Add vfio_pci_irq_reenable(device, index, vector, count) which asserts
> that the requested range has existing eventfds and re-issues
> VFIO_DEVICE_SET_IRQS using them.  Signature mirrors vfio_pci_irq_enable().
> 
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
> ---
>  .../lib/include/libvfio/vfio_pci_device.h     |  2 ++
>  .../selftests/vfio/lib/vfio_pci_device.c      | 22 +++++++++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
> index 2858885a89bb..a362e2b2bfda 100644
> --- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
> +++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
> @@ -68,6 +68,8 @@ void vfio_pci_config_access(struct vfio_pci_device *device, bool write,
>  void vfio_pci_irq_enable(struct vfio_pci_device *device, u32 index,
>  			 u32 vector, int count);
>  void vfio_pci_irq_disable(struct vfio_pci_device *device, u32 index);
> +void vfio_pci_irq_reenable(struct vfio_pci_device *device, u32 index,
> +			   u32 vector, int count);

Let's add vfio_pci_msi{,x}_reenable() static inline wrappers below
alongside the existing enable/disable wrappers. And use the msix helper
in the next driver patch for consistency.

>  void vfio_pci_irq_trigger(struct vfio_pci_device *device, u32 index, u32 vector);
>  
>  static inline void fcntl_set_nonblock(int fd)
> diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> index fc75e04ef010..7b8394d0ac50 100644
> --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> @@ -106,6 +106,28 @@ void vfio_pci_irq_disable(struct vfio_pci_device *device, u32 index)
>  	vfio_pci_irq_set(device, index, 0, 0, NULL);
>  }
>  
> +/*
> + * Re-issue VFIO_DEVICE_SET_IRQS for an already-enabled vector range using
> + * the existing eventfds.  Intended for drivers that need to re-arm device
> + * interrupts after a VFIO_DEVICE_RESET, which tears down the kernel-side
> + * IRQ trigger but leaves user-side eventfds intact.  Recreating the
> + * eventfds would invalidate any test-fixture cache of the fd, so this
> + * helper deliberately preserves them.
> + */
> +void vfio_pci_irq_reenable(struct vfio_pci_device *device, u32 index,
> +			   u32 vector, int count)
> +{
> +	int i;
> +
> +	check_supported_irq_index(index);
> +
> +	for (i = vector; i < vector + count; i++)
> +		VFIO_ASSERT_GE(device->msi_eventfds[i], 0,
> +			       "vector %d eventfd not allocated\n", i);
> +
> +	vfio_pci_irq_set(device, index, vector, count, device->msi_eventfds + vector);
> +}
> +
>  static void vfio_pci_irq_get(struct vfio_pci_device *device, u32 index,
>  			     struct vfio_irq_info *irq_info)
>  {
> -- 
> 2.54.0.794.g4f17f83d09-goog
> 
