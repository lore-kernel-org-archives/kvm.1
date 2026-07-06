Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D07C3D45D5
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 22:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783378540; cv=none; b=Kwg6lNuUPeM40t0IF+NmRFS3wzo4wYMmSq8HLWhTTeWYbo823zTF4ofmpaEZ69/0bE6m5fx99GdxkrvhB6xW9ypZF7q+G0ljO+gwJfJmgNeS+8++nikcAi0BqyU6uI0vSLFyhTZoD1ELRqfiLnzEsYSR+7HOjdj6zPi0I3yIqUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783378540; c=relaxed/simple;
	bh=kd/NmnH31N0D8otE5LvHAOyKTYQujSGHNm8ko4r/H58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKb9VGILCRrBJi9/8un+P2+uEP9I2pORVc/pGe6r/2enBv7dSLUEniqzWLzhSYau6ZpeGGIldtdfppcIlOS5BfBmdpPYN7uuIHE/ezArRHRSCX7ikSDm2UHM/JJDhQ9EwUYk+vO4xvqyDpRSnzlseLYCRQXIMJbbi6zwOEO7eGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BVf6OsaU; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BVf6OsaU"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38511175ad3so1576246a91.2
        for <kvm@vger.kernel.org>; Mon, 06 Jul 2026 15:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783378539; x=1783983339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AdxFGT9uqY65JqIKV/jaLoXcuduTCOvhsD7I3COIaPY=;
        b=BVf6OsaU+3JKmtwVIE13+MRugv5L74ekybwW7vJRsTf1D1no8fUsJFHAOgo/JS7f45
         nwN8aeft/3ttxjucYL4/BPdNgJixjDjAy/yACQGvOzcJQNiAaJrQx7bKrTZThgnwWt22
         1V9lJ51XfvxvPNyVKKSSfGKcES01NspCKEOfW4+tb2GxuPTUZUrYtTJhO/tZN9aaIlDH
         4vek5JUXr0J41LSkG2qUfGMLMGOxQt2ezC0o4GaCvh0n/qIxzJAZIK1lrhpVeoiUMu/I
         fjH5kERvf4jmyhu22pCVZ6SXkmEVnS/84ZTxVMGPE0bTTYuI6t1/vcvDxvje6B01oA/r
         6Rjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783378539; x=1783983339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AdxFGT9uqY65JqIKV/jaLoXcuduTCOvhsD7I3COIaPY=;
        b=NKqu4fvkKKKdyQWXTML30hcjB+Q/RIcluC8igpte9WXNkboa0z/zqeOhYT9tylQU9F
         vytU+LYb/wGA3rYwL+mUBZK+3XVw+b/MMrrp3gJSOP6gjdjQgVt+IJlV5rNnbLjU4X5O
         GM76vd1M2MTj5crkFEguojQZf5IQsfUDBhZBC1di6O0Ls5epePbDQ9eGNJicjs6BWDFq
         8KPQbBLbIlR3jo/RVArdUK76QtJMFP+f12XQrymOIM2RyAE/jg6tlWJ3J92ioHwxElqF
         83fONeZtJn3wWx2xh6WT5ccRJMoX3ZQvO12lDHrRSQg1JSaOIbK9U7cBDKTuW67CanLy
         E0Zg==
X-Forwarded-Encrypted: i=1; AHgh+Ro+bGh/s9nzwcQ/3ipy7cmo0izbyHjFZBAVOaKHsSyp4dJR9PHTBNY86mqIPUKHPYL2X8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJlw8nHWEtr2Y7SjHVv/q0nnDbVTVL1yVCSwoXDS1bT/xqGZRH
	N7f8lRDqdGbHtZBI197apZW9s894SYTXep10zem5k6y+JFNFcYzSCPkcKIEFCP8SAQ==
X-Gm-Gg: AfdE7cljRj9mRzrnuGYSxL93xNnjFAdyCoWf/a1LR555TDftZmZjOnkjOsaQEgKOLME
	cS/YmFUHBOtED3rSiWlIzFkNHXSYsaa0Gqcqf0rhEiYO3UEXbm9QD+m1+iMLnVVhW0kb3LDd6Df
	bYGPQwEFkXOaGVku1KPutMe6LsE/KmGpPQM05FBiayTbABextrRI4tWcPvs5GIwqze3+zQopaqF
	rBZLxuI69eKooRRFyZ8MrPj31TVT+oLw0/AbchGozQnl04R09QTXTgF3nu+VdJpIV/VPM74yvZz
	QoKy/Bs/3YQ7g6sWmyPeGTIdBfvWsqJjpkqO9/QbgEHrDfhSYoaAHVDmA8w3RsDfPju7IT28Rw0
	GFe28vCqi9xzFebHK85MPeC7ZL9l507lrb36cZ55Lan1zesq8z9MqzxXzeI+jTM1z0HumiUKnmm
	x4hHAUr4P0AgIiIDbX6CO1jpMRX1l4NVxgOUeDXwvUuUExk77/jIJBDGE/JEn39Q==
X-Received: by 2002:a17:90b:2604:b0:381:a766:efcb with SMTP id 98e67ed59e1d1-387565086a8mr2743484a91.4.1783378538265;
        Mon, 06 Jul 2026 15:55:38 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d15f13f1sm87825a91.6.2026.07.06.15.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 15:55:37 -0700 (PDT)
Date: Mon, 6 Jul 2026 22:55:34 +0000
From: David Matlack <dmatlack@google.com>
To: Narayana Murty N <nnmlinux@linux.ibm.com>
Cc: alex@shazbot.org, shuah@kernel.org, amastro@fb.com, rananta@google.com,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, vaibhav@linux.ibm.com,
	sbhat@linux.ibm.com, harshpb@linux.ibm.com
Subject: Re: [RFC PATCH 0/6] selftests/vfio: Add sPAPR TCE v2 coverage
Message-ID: <akwyZvbv7Fg8mfB2@google.com>
References: <20260703032806.40946-1-nnmlinux@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703032806.40946-1-nnmlinux@linux.ibm.com>

On 2026-07-02 11:28 PM, Narayana Murty N wrote:
> This RFC adds PowerPC sPAPR TCE v2 support to VFIO selftests.

nit: Please use "vfio: selftests: ..." for commit shortlogs.

> The series adds a selftest IOMMU mode for the legacy VFIO container
> backend, adds helpers for default and dynamic DMA windows, and exercises
> the sPAPR DDW path through the DMA mapping tests.

Thanks for sending. Is there anyway I could run these tests on PowerPC,
e.g. with QEMU, to try things out? I don't have access to any hardware.

> sPAPR TCE v2 remains a legacy VFIO container backend. This series does
> not add iommufd or VFIO cdev support for sPAPR.
> 
> The main points are
> 1. add VFIO_SELFTESTS_IOMMU_MODE for selecting a backend
> 2. add vfio_spapr_tce_v2_iommu as the PowerPC VFIO backend
> 3. preserve the platform default DMA window
> 4. create and tear down only selftest-created DDWs
> 5. prepare the DMA window before IOVA allocation
> 6. exercise DDW creation for hugepage DMA mappings
> 7. accept sPAPR-specific errno for invalid DMA ranges
> 
> Example:
> 
> VFIO_SELFTESTS_IOMMU_MODE=vfio_spapr_tce_v2_iommu
> ./vfio_dma_mapping_test <BDF>
> 
> Observed coverage includes anonymous mappings through the default window
> and 2MB hugetlb mappings through a DDW. 1GB hugetlb mappings may skip when
> the platform rejects the requested DDW characteristics.
> 
> Feedback is requested from the VFIO and PowerPC communities on:
> 1. whether the sPAPR TCE v2 helpers should remain in the common VFIO
> selftest library or move into a sPAPR-specific test helper?

Responded in the patch. Let's move to their own file.

> 2. whether DDW setup through hugepage mappings is the right initial
> coverage?

One thing I'm not sure is how much value you get out of exercising the
DDW stuff through that test specifically. Would it make more sense to
have a DDW-specific test so you can test all the edge cases you care
about directly instead? Then vfio_dma_mapping_test can stay generic.

BTW, is that the only test that passes right now? What is the status of
the other VFIO selftests on PowerPC after this series?

> 3. whether the sPAPR-specific overflow errno expectation should be
> accepted, skipped, or hidden behind a backend helper?

Responded in the patch. Let's keep the check but base it off IOMMU mode
not __powerpc__. Also it'd be good to avoid duplicating the code with a
helper function or macro but that's a small thing.

> 4. whether PowerPC should generate only the sPAPR TCE v2 fixture variants,
> or keep the generic IOMMU-mode matrix and skip unsupported modes.

For (4), I think skipping unsupported modes would be a good improvement.
Even on x86 and ARM we would want that feature. e.g. It's possible for
someone to run VFIO selftests on a kernel that has VFIO Type1 IOMMUs
enabled but not IOMMUFD. Today that will cause all the tests to fail.
But ideally it would wouldn't. Tests that just want the default IOMMU
mode should use Type1, and tests that want to replicate across all IOMMU
modes should skip the IOMMUFD variants. Same thing applies to the SPAPR
IOMMU mode.

> 
> TODO: vfio_spapr_tce_v1_iommu yet to be covered.
> 
> Narayana Murty N (6):
>   selftests/vfio: allow selecting IOMMU backend from environment
>   selftests/vfio: add sPAPR TCE v2 IOMMU mode
>   selftests/vfio: add sPAPR TCE v2 DMA window helpers
>   selftests/vfio: Exercise sPAPR DDW path for hugepage DMA mappings
>   selftests/vfio: Accept sPAPR errno for DMA range overflow
>   selftests/vfio: Enable VFIO selftests on ppc64 and ppc64le
> 
>  .../selftests/vfio/lib/include/libvfio.h      |   9 +
>  .../vfio/lib/include/libvfio/iommu.h          |  26 ++
>  tools/testing/selftests/vfio/lib/iommu.c      | 280 +++++++++++++++++-
>  tools/testing/selftests/vfio/lib/libvfio.c    |  37 +++
>  .../selftests/vfio/vfio_dma_mapping_test.c    |  30 ++
>  .../selftests/vfio/vfio_pci_device_test.c     |   4 +-
>  tools/testing/selftests/vfio/Makefile         |   2 +-
>  7 files changed, 382 insertions(+), 6 deletions(-)
> 
> -- 
> 2.51.1
> 
