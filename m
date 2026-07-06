Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5571F3EFD0E
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 21:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783372581; cv=none; b=Q49ZXeoxKNF9IQ5BHMMBAefVjnDrDpDFGn0tE7O72YPHnWSYVcam9j5k6dr7BL6f92LyHB7zMmw6I5FpTN+IrFT98CCYhHvrBbNr7qilZJWABZrb/sWDGlW+25YWE4ExnWJ+P5KX+RGNHL3a71fx7UMMHk/CBqIADhoFV4FyAOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783372581; c=relaxed/simple;
	bh=WICdANMRcBggP+LFV7A4kdek+PDiJFQmRUwULQJaBlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0uGwn4mPGLeiFtdYXhWMG+PelNy2ZtPpSgcQo6FCANSIFUmdwPm99KcZp6PpMIJ8uHkKL/TsBlugdILnlmATnp6YGlnhQGDzfcY7/2LlKXc0bNt8uEmxcxD6QmZhKU4sYPnIpUtverXQmTbCMrVZvIyLtYH+CcJEgNUQ7bwfPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kXH/uVWC; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kXH/uVWC"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8482074a000so880432b3a.0
        for <kvm@vger.kernel.org>; Mon, 06 Jul 2026 14:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783372580; x=1783977380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LUYJXxyTVrF/Xf3zdbSU1O7JfO1KsmE4iaB7Xr6SKQY=;
        b=kXH/uVWCoKpYJs8N2TUgVffcqwyzPblElSnGrGttmPuheCvLd1k+PI/VnjjY99s0nO
         KK8S+wFqBpyhoLp3ur4R0IPyPNi9Z9/GIvMa7rEzNBqcsSgSC0xx9ChVFxQDnSu2YQ7L
         f9xdJRHtQ9sO/cUCFmonLUCUWYNzZ8zGcFdG43UE0IbXz8nzqp+mfBbSK8iMoI9/qDUu
         MorNk/pYSTru4hoilNEcpKxgHwXCvAVejyeFfziNKu1jEsXvvKOr7XF8G0Rvd2z6xW06
         q0wIc9zOCsyi+1OYxrtR0gEr2vCFR49dyAFcxgBNo+TQcSk13ttAkQv2yqsL+nqRdci4
         XBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783372580; x=1783977380;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LUYJXxyTVrF/Xf3zdbSU1O7JfO1KsmE4iaB7Xr6SKQY=;
        b=eJvbfuHoP30+R/tLDc00evyj0LAlGha+t//Up2bQUmsrUjnrwezu8KAsGuRGgJIuLX
         kOnLV1ob2t6f0Ztb14ACVDXU9mXc2SrQioazPZp9bcf2Q5UeebVoyW8i5GGySTYoDBeM
         7irYpu9X4Qi/4V/JGGkxUu95XC2UfdRI6Xo+k9lKTR6T6z5JbtY8wxTdwwJdSisls9d1
         npuH4kqKhjfwaEU9ciw3bDkntjgaQjDEkotMb36/HTDz3exVhMIocxqBM2zr8oTIQniH
         /p80LQm54c6qRPyNVgofoY1J8I6hbuDR/5YUYQOWk06/8U5n6eu4LIgrsZ2EwphgGIOP
         eLsQ==
X-Forwarded-Encrypted: i=1; AHgh+RpP0vxKUHZru6wQsywRumUZ2wkIzYH9MPiqySUSdNhlDrJT8DkxhDJJYkVuj69gE6DQ6jY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUCSfZgj8/d/wCKYfhUl7Jsm8nat5CA/mJVsmb7TrduMpVqwhe
	uhmHcdtiAkQYwCK8E7idcQiF5yEjsiydHcJ29/lElkyCJkFrm/CwoVA43PJ7GypjBA==
X-Gm-Gg: AfdE7cnwQRgXvJoun4x+yqZAhRu2fKPjpwB5DRdo7T0GGn20afLOf1kUbqOEEJu8XZH
	1gjeW3Nf5kWRXXfjXkQhzNwRxQcAa9MP+JymWC4oGNUBitVRNCIuhp2E8jXVgtpBNOyhwTZHzeq
	+NGKazpkmGGyehxZnIxjfR3EJ/hcv9AoyARO1iErYPZg05XZq0DtgiZ+749fYjfXxYlu3sArJib
	x48s/8RtiC4d2ej08RtROtFz4qi6V50TuaWgiiO65VWSiuhRm7T1hGvTQOtWUMP8qHC4nFNwd1W
	malehryrEYjaQS7gkqBsOp+hzYOECBSxMAg+tip1SGh7Dzj3At7ajfsfxZtDGb+O3EXBPtNvQ+R
	Yahw0aMEZYOcHUNZR2Xoy6azhIoU25UMGvoksc5OYrmbqhB/EpDlsnHWXuPzY6PLQGMccJg65Xx
	uNqtFba/BQP7Fp57zOCWqxXxvgGFmnhuB6eNgXdJELGvnAXwlA02g=
X-Received: by 2002:a05:6a00:4514:b0:842:5bf3:c53c with SMTP id d2e1a72fcca58-84826c8fb8fmr2436174b3a.2.1783372578727;
        Mon, 06 Jul 2026 14:16:18 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d4edb4sm4354758b3a.33.2026.07.06.14.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 14:16:18 -0700 (PDT)
Date: Mon, 6 Jul 2026 21:16:14 +0000
From: David Matlack <dmatlack@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Vipin Sharma <vipinsh@google.com>,
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Alex Williamson <alex.williamson@nvidia.com>
Subject: Re: [PATCH v2 08/10] selftests/vfio: igb: Factor hardware
 programming into igb_hw_init()
Message-ID: <akwbHgu5iOBlBR8k@google.com>
References: <20260526235417.2058313-1-jrhilke@google.com>
 <20260526235417.2058313-9-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526235417.2058313-9-jrhilke@google.com>

On 2026-05-26 11:54 PM, Josh Hilke wrote:
> From: Alex Williamson <alex.williamson@nvidia.com>
> 
> Split the device register programming out of igb_init() into a new
> igb_hw_init() helper so that the same sequence can be re-run after a
> VFIO_DEVICE_RESET to restore the registers that CTRL.RST clears.  No
> functional change for the initial path.
> 
> igb_init() now performs the one-shot setup: region size assertion, BAR
> mapping, CTRL.RST + IMC mask-all to put the device into a known state,
> and vfio_pci_msix_enable() to set up the kernel-side IRQ trigger.
> igb_hw_init() does the rest: ring pointer setup and IOVA calc,
> CTRL_EXT, PCI bus master, GCR, PHY loopback, descriptor rings, RCTL,
> TCTL, GPIE/EIAC/EIAM/EIMS/IVAR, and driver-state initialization.
> 
> vfio_pci_msix_enable() moves from after RCTL/TCTL to before all
> device-side programming.  Its only side effects are the VFIO kernel
> IRQ trigger setup and the PCI MSI-X capability bits in config space;
> neither has any ordering dependency on the 82576 device register
> writes performed in igb_hw_init().  Performing it once in igb_init()
> keeps igb_hw_init() reusable from the reset recovery path (which uses
> vfio_pci_irq_reenable() to re-arm the existing trigger).
> 
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>

Reviewed-by: David Matlack <dmatlack@google.com>
