Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F30364024
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 22:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783378041; cv=none; b=DiNMyHPgeHwxXXCpSuG13oC3hA+BwibgjoEq1F9iU1dKtzviCsvxFi+vGQU/ZdUVGpX+7jOWAPj4EbBa+kZpw38e5DLLdGfWi5kDCUwZ0rNgkI91S2P6/2lH4zMdfGy8JbmQ4xftJmDQPnrz75IQOaMCd6SY3BGII5V9RedmUvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783378041; c=relaxed/simple;
	bh=jXTDaEhWRHoMk/Przi3L7PY4KIAFZ58iQthKv5UDUZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MfG3ANT0CGulvWjNgUOd6miFCvUXyzFw3aFZyj6Ja7dk5rm/duIBnGz674A4IhqVOhCjYPFRRc3hawLqVJbVQGUyKuG6M+CicpWHUg+6s3n4AVxvW0+tx1838E/90FrG+M8eM+upzChyhUuI8N9dFnnX63sIgYuO38hjo5mK0KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NZUO9Ug5; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NZUO9Ug5"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-383cb94f742so2024403a91.3
        for <kvm@vger.kernel.org>; Mon, 06 Jul 2026 15:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783378040; x=1783982840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=suhuxO/tRTI7f2bw+z1Hg0Rvsi5wIp5BwW1hDBnSHQM=;
        b=NZUO9Ug5iyDDu8y1zgzJkc+6l2qkMS6AHtaV124tzS4RYa0xYY0kZzpjjy7AXz3EJQ
         D8F3lMn/oA3poRURX5PUo308VpH7NeRzgJA624M/+dFpcYn1sdWim6QxcUpjoGg+lln2
         HbqZWO6qvQcEh5O9QDBHbVljHNRQLLNxjWcJvmcHbq5hWFHiKJKxLrGXI//a5QbPkb3d
         /SRd3nqxanuCfDXx0HcRTBvGnyoMvtcslXKyGJ8pGtjZR8ZSj0OOPGGIPeMFGeaaZNqM
         Kv0PoLVag3IKjWUhIIeZy/bmJW8ysedb/M95fTDOaElqz3GDFfsnAIB/6JuwHWcOqsYQ
         wyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783378040; x=1783982840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=suhuxO/tRTI7f2bw+z1Hg0Rvsi5wIp5BwW1hDBnSHQM=;
        b=U2mbmA7uPCSFk5AX3/kPAn8ScDJcth+Jg4gRVVe4HEJRCwJnwWgKFRSSSrSZqseIIx
         N+eNmubSS06e17DdLgXKpUSqMQrTID85JahCO7zqVvKzgox2/BuV3wvVrTvshas+mwjH
         LL/sFr9AyFM/KZXe1WVm6lunR8clSa0XsHUEf45qJtv1bVwKNZzgSPJ/dp5n4nUaPhHD
         hIiv5/WdJp1DRk+UWkWedjdUsriTPIIpYbhhertOE3fut0kIaM1OfuU5v1LHjzBelteJ
         qI2QQ5sdE2aeLzMlLIm4ejJyaUuYY1dkeFk6IjDbCsjV3BXM0yNfW5pmga5rk6d6WXGX
         KW+g==
X-Forwarded-Encrypted: i=1; AHgh+RpQ/wZ2cFFtMl1pBKcNQO0BI6BlFYGu6E8NZvforxWiugBT+d4tEfgQl+9TpQyo0bvScVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YychNYNEWfjekWMFm+oRcCYinRkZcAYIY+M7S4B41vSNFH0BwK+
	cqgj9LkAD2B+gXy1rWw38MBnnrgumomZs7PQizpoGaqHM3+KIs1+FTMtmOoJzeBJmQ==
X-Gm-Gg: AfdE7cl7SNOfIj9xbHV/HxdAgbPOoYxlfDbgjbZ/bKoWbnMJbumaUcxI6w9q612BNUD
	flhUSM8r0HJKlZHSWV/iTu1E7jPmRN9q7bFUdxuwxVmXA34vqLDrZvM1M/+wP/Rgo5bJC7+AKrS
	ZwXbWuJmKUIij9C7JGftxD4wy13OYh4k/XBbLg8nPRvq9CgW6PGrtCh0KBshj7QRvPWz1Se5Pq/
	JpAuVXQ96TZh10asuvTmCN3NBITp9Lsa/3l8KggOY8VEf1I1+1OPNPX+zKndlMrjHTgRHx/7zVP
	kN3t4sUGt7aRPCuBFMp9xwPbGTThiet0174wVi1HDw0ea7jd9mSzFZRiMV4MXK+ANosHrFLWdDw
	NzTclVsS9w7tPS0OnL+QFP7zTm2f7M4iBltN4HggMELfQaoZaOrTjrdzipQOJ9gF9s1X1qLLwEc
	kXVlF44tGytC1elChITkxXaWSVf5uU6IpB55S2LAOl+SLu+K3k7+I=
X-Received: by 2002:a17:90a:b108:b0:381:5ede:1296 with SMTP id 98e67ed59e1d1-3875547805amr2117566a91.11.1783378039537;
        Mon, 06 Jul 2026 15:47:19 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb72fsm1425915ad.6.2026.07.06.15.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 15:47:18 -0700 (PDT)
Date: Mon, 6 Jul 2026 22:47:15 +0000
From: David Matlack <dmatlack@google.com>
To: Narayana Murty N <nnmlinux@linux.ibm.com>
Cc: alex@shazbot.org, shuah@kernel.org, amastro@fb.com, rananta@google.com,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, vaibhav@linux.ibm.com,
	sbhat@linux.ibm.com, harshpb@linux.ibm.com
Subject: Re: [RFC PATCH 5/6] selftests/vfio: Accept sPAPR errno for DMA range
 overflow
Message-ID: <akwwcxwTojeAQHeW@google.com>
References: <20260703032806.40946-1-nnmlinux@linux.ibm.com>
 <20260703032806.40946-6-nnmlinux@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703032806.40946-6-nnmlinux@linux.ibm.com>

On 2026-07-02 11:28 PM, Narayana Murty N wrote:
> Accept sPAPR errno for DMA range overflow
> 
> The DMA map limit test expects an overflowing IOVA range to fail with
> -EOVERFLOW. That matches the Type1 and iommufd paths.
> 
> On sPAPR TCE v2, the same invalid range is rejected as outside the active
> TCE window and currently returns -ENXIO. Treat that as the expected ppc
> result for this RFC while keeping the existing -EOVERFLOW expectation for
> other backends.
> 
> This keeps the overflow test enabled for sPAPR TCE v2 instead of skipping
> it.
> 
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> ---
>  tools/testing/selftests/vfio/vfio_dma_mapping_test.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
> index 4411fdbd56da..cd2d3276a46c 100644
> --- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
> +++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
> @@ -316,10 +316,18 @@ TEST_F(vfio_dma_map_limit_test, overflow)
>  	region->size = self->mmap_size;
>  
>  	rc = __iommu_map(self->iommu, region);
> +#ifdef __powerpc__
> +	ASSERT_EQ(rc, -ENXIO);
> +#else
>  	ASSERT_EQ(rc, -EOVERFLOW);
> +#endif

This should be based on the IOMMU mode, not __powerpc__, as that is what
actually determines what gets returned.
