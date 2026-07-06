Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B57435AB2
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 22:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783377194; cv=none; b=f46d/lWe3vaVgkiBF6Tdye7JPnebxLifmFAmQzs27is4M+ipBOwWw0PZeJ6TnDoL3gbhZW14h2IXhQsJNybEYSws9Az2wXdNL7/0AGBpSjm1iE1HOnI3duQabJkXGZ3GVuux+vhHx4tVXZ+c1r7kobY9G1NTOwngkzGxZkprGfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783377194; c=relaxed/simple;
	bh=6VlEHJJ9RCs0CTWH1mW/aapB6WFc7FGf1VClG202CPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmzjx69Pg76z9xkd28cyo++y/EQ3fjv1Zxuka2RlGzi/+IlaYzPYc/DpRkfG/CKknyOEMG8OPhkz5RtRnYtx/TOaaRT9EjfcjmGNzdh+4GfICr26uBEi0Y1fxYXv3C26xCr8qmPpBp1skpuma8c/LRLI8Bd9wu4jGlyrpQYfoMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aT8dT+pE; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aT8dT+pE"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cad8076b01so45453015ad.2
        for <kvm@vger.kernel.org>; Mon, 06 Jul 2026 15:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783377192; x=1783981992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NLISTG3dFW5I5kNcviXxweIC3TjRqyQCTxs/vtB3b5o=;
        b=aT8dT+pEObDWZGU8JMHEOHF7HaZMc8NjcMRGlCcqKQkPV0LTjPp+QVuCA1kFw7n3oz
         /VI9bhH5xpRIZbmxwHJ/MjWAKBgnQHSsGrt6D0v2/UrB7kslDOsC1LvAOWbVUBQbH8I1
         tU1tcC3aOI5nGJO1P+qtNbBZ0brKmF73LYUcp1/mq5+yExtna9RqXmuo8BAgU4ef9XGN
         TW+Qk7z4Na1gwXEQ8MmHy4Ta5gwaiMqltCtTZBKUsVI2GOjiCUwh78Prp1y1pAimhGCS
         wQz7Ni93rqZGBVx2VVBvR9nK51aVb2qbkhBVbHjT+IlIvdNcPp9UFfLI/YNo61ePYqQQ
         60Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783377192; x=1783981992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NLISTG3dFW5I5kNcviXxweIC3TjRqyQCTxs/vtB3b5o=;
        b=G2hsVAGuxUfg0mBjuP/D/PTJCgymayeIG3C2LDxHaahJ8yoAtZ8P/+7ldUC1VvXJtw
         UlvqsBiNmP0D66E3PVTTl87fmqG0wzE82yTe16NbSsFdXakpmmlzhbhsgqBGDGgz4Vuo
         8MtxBgrouRGO8MN1elDxN7D1E10ihAvPCpr58lLfGm5hzADO/456bj91kLNC9Zq4omHU
         zxg2nP7MIrVcrpGi/2xJboCQi8KOy4cBEm3LNEQgNbxfslkNQXSD0yqtRDo1fQER63wg
         /Foj4xu9Fpn0dsJ3MFkfk3B7NGksKjvw3fUALu21/MnHx7msgudeU4MBAMZYFwJI35QT
         kAyA==
X-Forwarded-Encrypted: i=1; AHgh+Rq5nt+q1Hnb+dtnjeCM5CcUHgO43dj9lgX8s8DAudmKu62kSxVHmDDkYuEFfpgD7u8vuu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNLvlU4b3z6MgBX1E3bBy4Kijn3UeNAX7YevDelwvnyoYtP4Fd
	bmZzp/oqjc2MYSHtmc/rn/x1EgQD+NPP0AtFzuCUn7w9BpE3rdjhxFHjrmVCujIoOg==
X-Gm-Gg: AfdE7cnwyIFXrJm2zW1LfpNj86H7ognYyoEb7qPN722mYR4TQ93IZpT46vSfCtiig1a
	AEWS2hiMl6GnW3JnwlC9cc5fLaeZb8tKlkx0K7xrNnAdBWArXeJtJxAb5SSPtDcIAT3jc4p/8Ss
	ONA+v5txUdqcDBGqKXm43LVaQV4Z5DB03qouoQJoHRgiY6wdW0sseK8SOkBpf9CKVJZ45q49WsM
	jHEb+LzyH+DPeh97dhPBNvGIBK+FAQImtTVNS9MHlxbU1TiSDcIrIgvd2H4lEYutovRYcMZldKF
	tJlY5XwcuNw5bRUOrMIs8gbICVH45kJEsPEWizP+5Wd4IBD7YtkTu8GdU32YTILjXUGBvhdjI+e
	am97FauX+aTt9I5mX9kdcxkBwuXsj+KgmaB0ZOQd9xvlUA5jVj1wBwwZUWDgqLY64N6mcXFM72z
	iH0Uvm8f+hWf+61AhI5zHWVh1qfaQoO0hYIc7k++0Q8gI56/BGBKE=
X-Received: by 2002:a17:903:19c7:b0:2c6:a772:7e43 with SMTP id d9443c01a7336-2ccbeb1d9a4mr27892525ad.18.1783377191425;
        Mon, 06 Jul 2026 15:33:11 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb86bsm1300745ad.11.2026.07.06.15.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 15:33:10 -0700 (PDT)
Date: Mon, 6 Jul 2026 22:33:07 +0000
From: David Matlack <dmatlack@google.com>
To: Narayana Murty N <nnmlinux@linux.ibm.com>
Cc: alex@shazbot.org, shuah@kernel.org, amastro@fb.com, rananta@google.com,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, vaibhav@linux.ibm.com,
	sbhat@linux.ibm.com, harshpb@linux.ibm.com
Subject: Re: [RFC PATCH 4/6] selftests/vfio: Exercise sPAPR DDW path for
 hugepage DMA mappings
Message-ID: <akwtI2ixuRBHYCyy@google.com>
References: <20260703032806.40946-1-nnmlinux@linux.ibm.com>
 <20260703032806.40946-5-nnmlinux@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703032806.40946-5-nnmlinux@linux.ibm.com>

On 2026-07-02 11:28 PM, Narayana Murty N wrote:
> Prepare the DMA window before IOVA allocation in the DMA mapping tests.
> 
> Anonymous mappings use the default sPAPR DMA window. HugeTLB mappings force
> a DDW with the requested page size, allowing the test to exercise DDW
> creation, mapping, unmapping, and cleanup.
> 
> Skip gracefully when hugepage allocation fails or when the platform does
> not support the requested DDW characteristics. Also skip unmap-all when
> the backend cannot pair it with the sPAPR memory unregister flow.
> 
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> ---
>  .../selftests/vfio/vfio_dma_mapping_test.c    | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
> index 7d0de8c79de1..4411fdbd56da 100644
> --- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
> +++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  #include <stdio.h>
> +#include <string.h>
>  #include <sys/mman.h>
>  #include <unistd.h>
>  
> @@ -119,8 +120,19 @@ FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(anonymous_hugetlb_1gb, SZ_1G, MAP_HUGETLB |
>  
>  FIXTURE_SETUP(vfio_dma_mapping_test)
>  {
> +	const u64 page_size = variant->size ?: getpagesize();
> +	const bool force_dynamic = !!variant->size;

This is kind of arbitrary right? Should we add explicit variants for
dynamic/default windows (see below). But we need some way to skip the dynamic
window tests on non-spapr iommus...

diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
index cd2d3276a46c..b54c529ebedb 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
@@ -103,15 +103,21 @@ FIXTURE_VARIANT(vfio_dma_mapping_test) {
        const char *iommu_mode;
        u64 size;
        int mmap_flags;
+       bool dynamic_window;
 };

-#define FIXTURE_VARIANT_ADD_IOMMU_MODE(_iommu_mode, _name, _size, _mmap_flags) \
-FIXTURE_VARIANT_ADD(vfio_dma_mapping_test, _iommu_mode ## _ ## _name) {               \
-       .iommu_mode = #_iommu_mode,                                            \
-       .size = (_size),                                                       \
-       .mmap_flags = MAP_ANONYMOUS | MAP_PRIVATE | (_mmap_flags),             \
+#define __FIXTURE_VARIANT_ADD_IOMMU_MODE(_iommu_mode, _name, _size, _mmap_flags, _dynamic_window) \
+FIXTURE_VARIANT_ADD(vfio_dma_mapping_test,_iommu_mode ## _ ## _name) {   \
+       .iommu_mode = #_iommu_mode,                                                               \
+       .size = (_size),                                                                          \
+       .mmap_flags = MAP_ANONYMOUS | MAP_PRIVATE | (_mmap_flags),                                \
+       .dynamic_window = _dynamic_window,                                                        \
 }

+#define FIXTURE_VARIANT_ADD_IOMMU_MODE(_iommu_mode, _name, _size, _mmap_flags)  \
+__FIXTURE_VARIANT_ADD_IOMMU_MODE(_iommu_mode, _name, _size, _mmap_flags, false); \
+__FIXTURE_VARIANT_ADD_IOMMU_MODE(_iommu_mode, _name ## _dynamic_window, _size, _mmap_flags, true) \
+
 FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(anonymous, 0, 0);
 FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(anonymous_hugetlb_2mb, SZ_2M, MAP_HUGETLB | MAP_HUGE_2MB);
 FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(anonymous_hugetlb_1gb, SZ_1G, MAP_HUGETLB | MAP_HUGE_1GB);
@@ -121,14 +127,13 @@ FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(anonymous_hugetlb_1gb, SZ_1G, MAP_HUGETLB |
 FIXTURE_SETUP(vfio_dma_mapping_test)
 {
        const u64 page_size = variant->size ?: getpagesize();
-       const bool force_dynamic = !!variant->size;
        int ret;

        self->iommu = iommu_init(variant->iommu_mode);
        self->device = vfio_pci_device_init(device_bdf, self->iommu);

        ret = iommu_prepare_dma_window(self->iommu, page_size, page_size,
-                                      force_dynamic);
+                                      variant->dynamic_window);
        if (ret)
                SKIP(return, "DMA window unavailable: %s (%d)\n",
                     strerror(-ret), -ret);

> +	int ret;
> +
>  	self->iommu = iommu_init(variant->iommu_mode);
>  	self->device = vfio_pci_device_init(device_bdf, self->iommu);
> +
> +	ret = iommu_prepare_dma_window(self->iommu, page_size, page_size,
> +				       force_dynamic);
> +	if (ret)
> +		SKIP(return, "DMA window unavailable: %s (%d)\n",
> +		     strerror(-ret), -ret);
> +
>  	self->iova_allocator = iova_allocator_init(self->iommu);
>  }
>  
> @@ -227,6 +239,7 @@ FIXTURE_SETUP(vfio_dma_map_limit_test)
>  	u64 region_size = getpagesize();
>  	iova_t last_iova;
>  	u32 nranges;
> +	int ret;
>  
>  	/*
>  	 * Over-allocate mmap by double the size to provide enough backing vaddr
> @@ -236,6 +249,13 @@ FIXTURE_SETUP(vfio_dma_map_limit_test)
>  
>  	self->iommu = iommu_init(variant->iommu_mode);
>  	self->device = vfio_pci_device_init(device_bdf, self->iommu);
> +
> +	ret = iommu_prepare_dma_window(self->iommu, region_size, region_size,
> +				       false);
> +	if (ret)
> +		SKIP(return, "DMA window unavailable: %s (%d)\n",
> +		     strerror(-ret), -ret);
> +
>  	region->vaddr = mmap(NULL, self->mmap_size, PROT_READ | PROT_WRITE,
>  			     MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>  	ASSERT_NE(region->vaddr, MAP_FAILED);
> @@ -277,6 +297,8 @@ TEST_F(vfio_dma_map_limit_test, unmap_all)
>  	u64 unmapped;
>  	int rc;
>  
> +	if (!iommu_supports_unmap_all(self->iommu))
> +		SKIP(return, "IOMMU backend does not support unmap-all\n");
>  	iommu_map(self->iommu, region);
>  	ASSERT_EQ(region->iova, to_iova(self->device, region->vaddr));
>  
> -- 
> 2.51.1
> 
