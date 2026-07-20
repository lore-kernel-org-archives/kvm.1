Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAA33ACA5A
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 18:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784572426; cv=none; b=elLuGISmezDqQc5ju8ARd4xVFuInJRaWBLRvTJMy3XKspE+iRvyYMOVHerWd8URsqfSvSyqBczY/kvKg7n3EMXA4E1G5iUBclytHfi/KuhlXCxK6rEytVWW77j5VMBpZfnkRS3FTojlrRt2bNOXoYCMb8XI1f4en69jD0I2iHOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784572426; c=relaxed/simple;
	bh=CzRT3xMj8yG5S1v+ToPB3HBCkkmQKdbdC8TM0Ehbm1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uX9qZ/M8s+OlH5AEzh4jIPaBwQWY2WEIf2GNcH9zVR9VR2d8h51Nn4LKdL2ftAS3vhi3k+iJWnUL0XKfsbBAoXaJKsia3130Z5o2LWcXDx5xmlohDMOoUR3L8ZbPEbpT9KqVzVH/4kf7BP0Leotn7JxpV+P9YMCDy9uHl5qOpbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gx0htgTI; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gx0htgTI"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cacef7d299so398415ad.1
        for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 11:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784572424; x=1785177224; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3MZcjKOaWcWRrEDWjms3JoYJ25WsY0RZ3KRMLZHlqLM=;
        b=gx0htgTIDA07teRYmL0nZ8l1iimYqBrv3DT1GK+GMtDgPuuwVeflPfqI2YdqaAR+KI
         3ALE+w0mFAqd/nxVS6akn2LRFdRCucE4C5iddARG52rzT+xAH4BgZbn/pGODPiyHIUqZ
         CEInivJ+FA6U3tkdxQkHRxsWoUjAfpI/WnZ0EWRzVz2S0un17z9WPWnjgVPB+nUEpgpH
         Wvv44tTQfK4PnkO9nYVuF2WATbe2AaJ1FrDZd2Fa7vZliwB3T+8sY+ycuZwDWlHFRqoD
         4Qek8AgDuZBulhsPD5/HHMudcxwktMlYAysSKxR4EbFov1oj9V4WjxCqZUcdoARvKKK+
         AQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784572424; x=1785177224;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3MZcjKOaWcWRrEDWjms3JoYJ25WsY0RZ3KRMLZHlqLM=;
        b=UbkfARX0kWwVRijm7hMNztG99NSdDKsW/quU0Tp0lZNSX0W3oHPSauZzyGqqPIIaP2
         gpurTa4EJQTtYfOAZTP+dn86dkLAzNCM5grOTK5d9UjeDRLlzkxCE5aL8BY5Mc4Mbcs4
         l873zsGev2p3clcQzwtPDZJHg8FJlCseKNY0D5oNHneTs+CnS+M/BSo1gYgKKNX1I+8C
         qu4b9ELF0idVkS1krqdufYJW0IaADJ3pkeppcofod4olZPIWHAp7Ou9TQHFDQx12dKd2
         O4fUGgd6jGiNkYaY0nnwfk5Sk+lum/0Elm8NO3AoJk7ibIVnMEPb4RD2pT8QcXftDOyv
         w1Ow==
X-Gm-Message-State: AOJu0YxuZeVOW2gIuBmIFregADxZ8n/G+DzIfRh3jk9HZdEfSQBGkH6b
	Qm4wFlzAe7mOMP7HcgrxMqBLaTV56Nwj1L8IeGDRXjQJq37MKR3LmFpUUoTKxCUDCc9brnfyxEw
	aFdmfeOYJ
X-Gm-Gg: AR+sD12vex9smLiZft74QCnNhdOGplyF/NHgZTEUnr6B/eQLE85HrqmRVdSQ9t1TI9x
	7KLw2pUWqrBx8UrDE5CpvaHwDQYqtUNXyaPUyFMvmdorP4IAEXy3Es2LUl06pcAn4LsoMO9+MTY
	ucHs64nzxnXLiaRLILcmzZsAu6fyxgzfpeTJlFBduWDUUA3fMwHepFNdg6iNl10euiEuZX62j16
	qPif6/DqyvVNljRiNxecGeqXC/ruwNcLOTOCM/MaC/qpD7G53uXCxZYZa32/Hhh2EaSVDqEnntx
	cJNSstGNCsAO6CSE+NoB5opZKThDp0jw6RqeIm0eCCrcfbsJ9NRpU41i37Qsnf678SjmSO4O6/w
	FZtbFk/62coUU6PxVizKRbee8JlYHNuik7K2ysvyWwAQ3IW2h35a1HBy+pEE46qJ8twrWVQ88kx
	hsmmzMfH55gJVwP9hf1JRo2DlLJLdyFUGCIXOCrTU=
X-Received: by 2002:a17:902:d091:b0:2bd:6dad:7ccd with SMTP id d9443c01a7336-2cf7b6febffmr1448145ad.25.1784572424013;
        Mon, 20 Jul 2026 11:33:44 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3471f42csm61098845ad.61.2026.07.20.11.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 11:33:43 -0700 (PDT)
Date: Mon, 20 Jul 2026 11:33:38 -0700
From: Vipin Sharma <vipinsh@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH v5 20/20] vfio: selftests: Add continuous DMA to
 vfio_pci_liveupdate_kexec_test
Message-ID: <20260720182853.GH1381701.vipinsh@google.com>
References: <20260714151505.3466855-1-vipinsh@google.com>
 <20260714151505.3466855-21-vipinsh@google.com>
 <20260714153740.CBA041F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260714153740.CBA041F000E9@smtp.kernel.org>

On Tue, Jul 14, 2026 at 03:37:40PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Partial initialization of DMA buffers in dma_memcpy_start().
> --
> 
> --- Patch [20]: [PATCH v5 20/20] vfio: selftests: Add continuous DMA to vfio_pci_liveupdate_kexec_test ---
> Note: Due to system recitation restrictions, this report does not use the standard inline diff quoting format. The findings are instead summarized below without quoting the original patch code.
> 
> commit 123ec8cfeb386e8660107c771eabe7ddc5cba029
> Author: David Matlack <dmatlack@google.com>
> 
> vfio: selftests: Add continuous DMA to vfio_pci_liveupdate_kexec_test
> 
> This commit adds a long-running DMA memcpy operation to the VFIO PCI live
> update kexec test. It ensures that active device DMAs during a live update do
> not cause system instability, even though the DMAs are currently expected to
> be dropped.
> 
> [Severity: Medium]
> In tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c, looking at
> the dma_memcpy_start() function, the buffer initialization seems incomplete.
> 
> The code calculates the transfer size and sets the destination pointer, but
> then calls memset() on the source and destination buffers using 'size / 2'
> instead of 'size'. Immediately after, vfio_pci_driver_memcpy_start() is
> kicked off using the full 'size'.
> 
> Does this code unintentionally leave the second half of the DMA buffers
> uninitialized? While the test does not currently verify the transferred data
> since iommufd preservation is unsupported, will this partial initialization
> cause false positives or negatives once the test is expanded to validate the
> completed DMA operations?
> 

It is an issue, even though we are not verifying the copied data yet.

I will fix it in the next version.

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260714151505.3466855-1-vipinsh@google.com?part=20
