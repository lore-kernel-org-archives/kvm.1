Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DFE405F7
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 20:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783456247; cv=none; b=LuY+1Vmo5mhGlLK1cQF6KGNR0Bqpgl0Jwzvv6sxu6EfooituTak91htmaaytFF33xmzy3590Z4duHcMaC3YB6Rv9OoPWhTTExeIkLNC4orWLToJ65Zm7lB7epDAkXZl4NMiEe2quYqsL25D0OaJ4yT4s3OJBbdCwAV2ndVFNTVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783456247; c=relaxed/simple;
	bh=Y/jnk+wyBpfk7o4Qoc3NWCpiwq+7nNDQXQa0jWwVtI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYsdiFUvJMHvK4aPRFocxsWKdt2GE2R90J1ulMtynXG93zYfPRagc5RptpnmIr2pjHU6BM5QhHbtQd6zXKy14pIquj9ml1NWbIkr9kVvSL1dzeRP764SRU9jy1w+eIb9foK0DLDVb8UEMmWzLzypbraeRzx4hrjQXySEjRJiAs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rrPlDVsh; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rrPlDVsh"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c7cfa17fedso54290595ad.3
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 13:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783456245; x=1784061045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aPqyJBYP65nX65ADi1+0l/HZ4BmkOj2zrvfAu9Kuof0=;
        b=rrPlDVshDeUL0gGDrKqb9mxP+8RbRSKQmwQ6wHPOY7zdG7ll/TFLD4PSmJe1FvQ6vH
         /FJjd+srCrZfNn/OKuACya37i8GlryerxrdWqI9F+Dri3YJfRhy/LVQidL80bZVCNmea
         d4Xz674ILSCvJBV9ujBuEs2+BFYLb4nRPuMWpgJlCQTHyZma6YPk4sziJLGn18By1OHM
         gPG2rqGUcC9CQPrYHypduAVILMGX64rP4u7FXMkQSfgFPcKV6LbI4iPrFH6QpO/uwmNn
         heiEeoc4s1lgg95H9sX0YvsSp6JqX0WDnlI6RvUaPRmTfdEMH0uHWRe+VW8+Tadzc+NO
         d1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783456245; x=1784061045;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aPqyJBYP65nX65ADi1+0l/HZ4BmkOj2zrvfAu9Kuof0=;
        b=G4jE/C3pXZkXoBPKwTrz7FNYVtJVFk/AxPM/za0oU5I06glJIeepaOu5lE+6uG2c1Z
         2EvjvhO+CKbC6YirRw9N67aCJuc5KcJ2pAqbSsf3ggnT6hQTFGnFog4/6JkN2apPXy2M
         3zVtzchTVOlP82MzgoaIeLgcamA/A2EjCO+dcC5gyijvZbBhzYzf2qCZ1b9F9oJttPp1
         FglvQvD9yrFUY5PlwXFd77/g49L5Cuc6vk/Uk4rP0rjBKDIEuv7au6wgWFslW/uE81CL
         R7dbVYjwAhL4/5IJkks13vFzGV6XB/l1k2e5/MFGvizAf0VdYeLpOY7CMQcDXJAjJLTh
         /0Ig==
X-Gm-Message-State: AOJu0YxDcKpnFsz3mEAdC5L1n2yshCEE0n+4drnhm3a0jSMDvPDeVavo
	Hc3CEmn+BCgGQZg6+QyUaHQK+KmbCgtFdQRwUygPpvWoov5tL++KgLXQzOYr7coxTQ==
X-Gm-Gg: AfdE7ckTJtIP8MYsLyHAM3jTK6n/K6efW/M4EAE5DFDUrUyw5VLBkRP9urAylzYsJIq
	qWwWYcg3CoEpTkOcGouMSDGTI9grS/aVTHArPmTBZ8ylIl98xCB93Cvnr22AZXWaH5oseORT+AZ
	ZGab+KfnZYmLdwuBShzVH0qyo91xFlJ4fjMIOI2cCBut7WEv/+dsQXohv5GfFL/uLa7nExbUaRA
	T2WTZha8NsCooWWvgZijzmJlNN5hW4BObfIR0pyguy7R9WTxsus0TrBKL83yBzqT+AXGfUAoQjn
	IozOafg3IJdQl76JBrHje7IJfD3RoVj1vQO1G2C2OMXExrXVuXO4bltKg7oUZKpicn+hiHpnJTs
	weJE7s1I2alfG2+Z8+L+UAhpc5KxHIWKy9Qpf9XhtnNwKD+xVcyPgnjMDN3m0J5XLFBxMJQe4ER
	5jYEs8g5QlhbykcQ/tIVXLIgHunbxCwHr2+RfnUWRuP7Ckmz7UjWE=
X-Received: by 2002:a17:902:d50f:b0:2c2:bd0d:3cf0 with SMTP id d9443c01a7336-2ccbee2494emr69455105ad.25.1783456244490;
        Tue, 07 Jul 2026 13:30:44 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf8f26sm17732875ad.27.2026.07.07.13.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 13:30:43 -0700 (PDT)
Date: Tue, 7 Jul 2026 20:30:39 +0000
From: David Matlack <dmatlack@google.com>
To: Aaron Lewis <aaronlewis@google.com>
Cc: kvm@vger.kernel.org, alex@shazbot.org, jgg@nvidia.com
Subject: Re: [PATCH 4/4] vfio: selftests: Allow the flag MAP_POPULATE to be
 set on the cmdline
Message-ID: <ak1h748NuhCzVlJ2@google.com>
References: <20260701203311.326798-1-aaronlewis@google.com>
 <20260701203311.326798-5-aaronlewis@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701203311.326798-5-aaronlewis@google.com>

On 2026-07-01 08:33 PM, Aaron Lewis wrote:
> Add a command-line option to vfio_dma_mapping_perf_test to set the
> MAP_POPULATE flag during mmap(). This ensures consistent and accurate DMA
> mapping latency measurements by forcing page prefaulting to occur during
> the mmap() phase, rather than during the DMA mapping ioctl.
> 
> For example, mapping a 32G region without the -p (MAP_POPULATE) flag
> results in:
> 
>   $ ./vfio_dma_mapping_perf_test -b 32G -a "-v vfio_type1_iommu_memfd_hugetlb_1gb"
>   Completed mmap() for memfd in 0.00ms
>   Mapped HVA 0x7f1840000000 (size 32G) at IOVA 0x800000000 in 2887.56ms
> 
> Here, the mmap() call completes instantly, but the ioctl to map the DMA
> region incurs the ~3s cost of prefaulting the pages.
> 
> Running the same test with the -p flag results in:
> 
>   $ ./vfio_dma_mapping_perf_test -p -b 32G -a "-v vfio_type1_iommu_memfd_hugetlb_1gb"
>   Completed mmap() for memfd in 2887.41ms
>   Mapped HVA 0x7f8000000000 (size 32G) at IOVA 0x800000000 in 11.51ms
> 
> By shifting the prefaulting overhead to mmap(), the actual DMA mapping
> latency is isolated and accurately reported as 11.51ms.
> 
> With user-defined mapping sizes and prefaulting in place, this test now
> clearly demonstrates the difference in mapping speeds between VFIO's Type 1
> IOMMU and IOMMUFD (i.e., IOMMU_IOAS_MAP_FILE).
> 
> Running the same configuration with the "iommufd_memfd_hugetlb_1gb" variant
> highlights this difference:
> 
> $ ./vfio_dma_mapping_perf_test -p -b 32G -a "-v iommufd_memfd_hugetlb_1gb"
> Mapped HVA 0x7f4fc0000000 (size 32G) at IOVA 0x800000000 in 0.11ms
> 
> The DMA mapping time drops dramatically from 11.51ms to 0.11ms.
> 
> Signed-off-by: Aaron Lewis <aaronlewis@google.com>

IMO we should either:

 1. Only support the MAP_POPULATE variant since that isolates the VFIO
    and IOMMUFD performance from allocating the backing memory and
    aligns with how a proper userspace should be designed.

 or

 2. Make MAP_POPULATE toggle a test fixture variant so that we
    automatically test both scenarios without needing a command line
    flag. If the user wants to test just one scenario they can do so via
    kselftest harness -t flag.

Either way, we shouldn't need a command line flag for this.

I don't have a strong opinion between the two but lean towards (2)
until we have a compelling reason to care about the performance of VFIO
and IOMMUFD triggering the backing memory allocations.
