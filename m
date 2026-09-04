Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91F04A2A78
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 13:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788529929; cv=none; b=EFL71cO+N84hLC/NaytFM64JPb+TSrinC2aKlyKxeYIuQmv3cTMZj+rfdEjK+qP2ZsmcdRnU89egyOgUquhCXuSpsgA8ZHUaOsoHw1e6w5pPnp4EM289HLg7aGPMcM2+QIu3CLDy2SXX6rtPB4jfnl+OyKfaTfJnRCEz69RP0nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788529929; c=relaxed/simple;
	bh=jHnLUWIESbcX49x//Q4q7Bwcagr68GVUnUN7YIG+4NE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GB4f+NV/rfYkmvOmDnSwmnT29PbCS968Xu10NfnsYhfVVGocUaWXE6CQjgQJYqmzjWwPLLZwFkaj37vJr/ABS/N+1PPGtOvfiY5FNU4Y4U3jKhZgiBp3ZBD+wGUGhVXRTcB4Jh6V4ck1B10qavN7v5qHx1ArRnd4p0oFpf6PNJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eqlbIxHm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqlbIxHm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788529926;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IhhXcRIecUQqwiCbMDmvIAEilzEU8sFSDbKFkRHxEJU=;
	b=eqlbIxHm1BXgDYYa5qbjXVDwpAZCIO3zsQBsageKCvLuL06OdE6j7jqLWJtazO/+byc1Zd
	J/IoNxy9bHUPEgqeLjJTQQtlD7JhkvCrCb5Mky4DR5R9zQh5NsepCfQAY5R7hEm2cc55uW
	wXXHm197/Wx2KtvonrfTDef70hAzTzY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-vyiEUTrbMBic3BcjUo4GBQ-1; Fri, 04 Sep 2026 09:52:05 -0400
X-MC-Unique: vyiEUTrbMBic3BcjUo4GBQ-1
X-Mimecast-MFC-AGG-ID: vyiEUTrbMBic3BcjUo4GBQ_1788529924
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49554715277so10283345e9.1
        for <kvm@vger.kernel.org>; Fri, 04 Sep 2026 06:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788529924; x=1789134724;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IhhXcRIecUQqwiCbMDmvIAEilzEU8sFSDbKFkRHxEJU=;
        b=RhstLp96kjHecTzqIB47r+hnbKmn1SgxBvTirDA/WLkVPkm8f8stvsc4mnj1pp1PBH
         wZS3qLRG8jbzpEy6IsnNhfhv74S6iOECOLYqzCfPp3/pVZSv9pSEv0p73cgFrY1VMsK1
         gs+Ucjup2bdULApTdUliN97Qo5IT8l7FmmsCaWAWY+WAp8sjaPcmtB4DEWCWkDdaEMZK
         H5KtVE1GVXLFuVP1NtKGyXpeNfT82kGLZBcg/RrciDuNhJBZo2iZnd0R6uYEyGeo7Vaq
         OMdjl8a6O/a7G07e/DKweQAgkvKgXTF4qGjVnlrSPe9TR5PpvvAdu1zaLKJ9zi6DlJDI
         i14w==
X-Forwarded-Encrypted: i=1; AKwUvBxAUdsXpTfCXVnhHa5EeDAQLFfsIBgP76q9EEMDPTSjAfwrMP2PtdWuS/3Y+gFnXq8/KHk=@vger.kernel.org
X-Gm-Message-State: AFuF++nphs5SJyotlkKQdKhqsWqLLHTqRdPSs1/cMzNkz6dnPrs84BDe
	srT2Q9n53hcBFRWcvI0Tb5Qs0QfTOLhDkR08NxlzORpBoIQQONSOtqWRX4NSnngQm1658w2tr2l
	aH4eITPp4ggb6BjhYCrVxHhzg2bolRkst9frFQpVRn14P0xC4Cwii44daW5hyjw==
X-Gm-Gg: AYBFou3xKSVm4wf/YE7ZPFus4S3yvAlnf8k/+3tprIi/uvX/iK154nXBKmJE7rE03xi
	W/n2VSCoih2jUIT6dgUc5Qn40b+OXCdTe1HCer7kTfwJDtI9h8h8M0TZ6ErwkmpurKVOEWRhFcJ
	iJdWBGzSftp6wY1QPXXR7CEJUhDpLDp/J05PpjFWYWbqWH5/hG1lCoYQ8e3aredk2Q/l8THWX+b
	ZJtBWSM87+o/vVH9w6QReAZIdWnQxcCEu1Qgbj7J2nWazupGsSfA1zFx1EtCImp3EcqoRiYEBpT
	6qgmqj6FLW1u6XE2H+k+r4v4k0BDogjC3God45BZ2FHHU9OOuMaJxq90Yv9iyWgg7GSF9Rth60R
	KYzSxFGWgKRHl5DbVZKguiAq0u4UkIxw3gg==
X-Received: by 2002:a05:600c:8b09:b0:499:b65e:49c9 with SMTP id 5b1f17b1804b1-49cf823f57fmr113368175e9.10.1788529924220;
        Fri, 04 Sep 2026 06:52:04 -0700 (PDT)
X-Received: by 2002:a05:600c:8b09:b0:499:b65e:49c9 with SMTP id 5b1f17b1804b1-49cf823f57fmr113367165e9.10.1788529923865;
        Fri, 04 Sep 2026 06:52:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874? ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee6024a8sm160985535e9.6.2026.09.04.06.52.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 06:52:03 -0700 (PDT)
Message-ID: <882503c8-6993-452a-98e5-2eb72faff58b@redhat.com>
Date: Fri, 4 Sep 2026 15:52:01 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH] vfio/platform: keep logical vm_pgoff in MMIO region mmap
Content-Language: en-US
To: Abdifatah Suruur <suruurism@gmail.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Mostafa Saleh <smostafa@google.com>,
 Pranjal Shrivastava <praan@google.com>, Alex Williamson <alex@shazbot.org>
References: <20260903092927.502-1-suruurism@gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260903092927.502-1-suruurism@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Abdifatah,

On 9/3/26 11:29 AM, Abdifatah Suruur wrote:
> vfio_platform_mmap_mmio() overwrites vma->vm_pgoff with the physical
> frame number of the MMIO region and passes it to remap_pfn_range().
> The VMA is inserted into the device file's mapping->i_mmap interval
> tree keyed by vm_pgoff, which VFIO expects to be the logical file
> offset: the core links every device mmap to the device inode's
> i_mapping precisely so that unmap_mapping_range() can revoke all
> mappings associated with a device (see vfio_device_cdev_open()).
>
> With a raw PFN in vm_pgoff the interval tree entry lands in the wrong
> coordinate space and unmap_mapping_range() cannot find the VMA,
> leaving stale MMIO mappings behind any revocation attempt.  Keep
> vm_pgoff in the logical VFIO offset space, as vfio-pci does, and pass
> the physical PFN to remap_pfn_range() explicitly.
>
> Fixes: fad4d5b1f042a ("vfio/platform: support MMAP of MMIO regions")
> Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
>
> ---
> --- a/drivers/vfio/platform/vfio_platform_common.c
> +++ b/drivers/vfio/platform/vfio_platform_common.c
> @@ -559,6 +559,5 @@
>  	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> -	vma->vm_pgoff = (region.addr >> PAGE_SHIFT) + pgoff;
> -
> -	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
> +	return remap_pfn_range(vma, vma->vm_start,
> +			       (region.addr >> PAGE_SHIFT) + pgoff,
>  			       req_len, vma->vm_page_prot);
>  }
>
While at it, don't you want to fix the same pattern in cdx/main.c,
fsl-mc/vfio_fsl_mc.c?

Thanks

Eric

