Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BA637BE9B
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 22:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775859608; cv=none; b=V6JkdOECulmMGKQPopQ0RfWrbvZolNOBwwIRCOpS7vjBHNb4+Kaz2yVBXhXbgNjoaoQhJtddhCoEsI5FJGyVwVzCDrIsQ6qVM+m+tYx0f1gkvZGBT9DhtmEgymDVA0I5zUBAx7dHNxNGMuP7WhvX8GlI+qnzvWfPa9yYnQTOPQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775859608; c=relaxed/simple;
	bh=umzc0XafQv1gLEfDC6aulFCzYtfdC1CzGb6jfknFwiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3QquwmEKvdkki8ezy2kESj+WpxASen6YYosfzP90sdXXEi7xFfK/zVSOJrT28bKK9oawe2t/sTlMDc3mu40aDCDaVunyBrHkdeClkE92QfoOVgM1NGthcoKVFAMtsNq6jsWwLJ8EwWCELIxhohIBpPakf0mCw5QphcpZ9PYKJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Em7EFzaN; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Em7EFzaN"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2d323567f11so1137697eec.1
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 15:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775859605; x=1776464405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3rAkJY2TMih5tmxyNIs6farkTTXbL/377T44hrHUMZQ=;
        b=Em7EFzaNcEmf5yyrVYvMc0OJh7F9Nt/QN6g+qHXH1yKGaTqVPPRSuWRGgKzMIO8Dkm
         n6Y2+Bt6ylnGmlBEPpfOt8SNueU0HRd4nJ0jjupQzLwU6tjs6/1pvcWEgdZGg4+Nq4To
         CZI6zVrKLpIt5XQorZ+k0V6NtDN2b95dJWzspwsycodcoYso8mHk00FxRtJaDV3LgK1G
         Jwg5Til1l3z8HKMqeccxdRebxX6m7+tRc6/giZeplMPz2Ndy2scBPjHdVGz+aYiGwy5H
         96/yw9i9IDkuajDx5pgQFi2v5AIzAxdd9npN8bKxZzHb/BNir6OdY/0oUibdoSoL4qN+
         fnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775859605; x=1776464405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rAkJY2TMih5tmxyNIs6farkTTXbL/377T44hrHUMZQ=;
        b=SJIl+f9kQkGE2FZ7QxzVg4YAyVsWrXgHaOnSRqp+KDJoZsomX2XJT5f63tEuA6qczz
         J4TXJp4aqFv4+tak02XkvF+EOBNkbPMgj0RjIVMZ7wmDWHkDhBDtQRlPwkUa5k2+Bl3x
         R1kn0nVhrclk9GcLGtWceVJWnb2sq7PTXUNcDA5owrQjq8a3hHVfzK1V0zt0zviS2bnL
         qc39X3VNq668nkKg1S6oTXSV/iKBlw32/wZeoJuoB38+HnIUUqEvKKDerCPPBepTZb+X
         kXH9Z9QNPRP788BtP7FlkxCnqchd15tIV5Zsf7t2p3IiqmYFMjPtyYSrjpXdK6YOTihb
         KT+A==
X-Forwarded-Encrypted: i=1; AJvYcCW/iAM+esbXoLAJnZ9mi/Yu8hpdc5oB2iXqfz4KcVBbEhhJNy16EG1SqwD6EsKdNAta22M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFOpiVhtGw9R1FAzSaVKX+VJN8gZQd2awisxTfKommR7zF8XYm
	OAV8XO5wNdFF+1LEGIppvBVhi3yjHl5jdEnFaHpgOyTr/BieHP7BvSJnxgEO/amsow==
X-Gm-Gg: AeBDievZRgrVAZj/eq+GyKRFvz7w0GCtrPTP9gItuSqdGFIRy4Sow0SF+skYMyt7js7
	YzP8Lfy7VDbH8pRbZI3isXhkDfaI/uYNWCF2Na+HQPqHtAlGAqCsr5ZhWk1bB2yeF2WYJNhWZR3
	gnk0Mdyo+sDZa1ZrytYusmRU1Q9U0bXmj9C9iORb7303pYKgiTcnyd/D9I2nHwIFwwhWT5g3v8F
	VlGDj0f+XWZfG+5nbzsbAGbBc8Qn9q1UV32E+mFE9Ws1f8R6fyaf2O3Y3ibF9AXu5j9jBpL0CRX
	QZSgU7cESjjnUiszM7Wqn/vjtERoTGEVcTkS2YOb7TxDCgKKbEi+5kVsCoSf+OlFFlOZ4G0RhZf
	0PeNHjGfOAIsjUVUJmg6pvQe9XVgI6D48q4jz1pMEgTWDhDImMHTFsH+d+T4D5TIBfbbLbDVuoQ
	+j8jzUVn79q5MzcQR4EY2C6T164Z8bhaZKZOY7rIRWLR+0+/CP6XdPumykxDjSCozhTz4=
X-Received: by 2002:a05:693c:2d91:b0:2d2:d5a3:e97c with SMTP id 5a478bee46e88-2d40fce99ccmr4758645eec.12.1775859604372;
        Fri, 10 Apr 2026 15:20:04 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d561cd2a4esm7830492eec.16.2026.04.10.15.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 15:20:03 -0700 (PDT)
Date: Fri, 10 Apr 2026 22:19:59 +0000
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@nvidia.com>
Cc: alex@shazbot.org, shuah@kernel.org, Rubin Du <rubind@nvidia.com>,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 4/4] vfio: selftests: Add NVIDIA Falcon driver for
 DMA testing
Message-ID: <adl3j0piontmOQZS@google.com>
References: <20260408225459.3088623-1-alex.williamson@nvidia.com>
 <20260408225459.3088623-5-alex.williamson@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408225459.3088623-5-alex.williamson@nvidia.com>

On 2026-04-08 04:54 PM, Alex Williamson wrote:
> From: Rubin Du <rubind@nvidia.com>
> 
> Add a new VFIO PCI driver for NVIDIA GPUs that enables DMA testing
> via the Falcon (Fast Logic Controller) microcontrollers. This driver
> extracts and adapts the DMA test functionality from NVIDIA's
> gpu-admin-tools project and integrates it into the existing VFIO
> selftest framework.
> 
> Falcons are general-purpose microcontrollers present on NVIDIA GPUs
> that can perform DMA operations between system memory and device
> memory. By leveraging Falcon DMA, this driver allows NVIDIA GPUs to
> be tested alongside Intel IOAT and DSA devices using the same
> selftest infrastructure.
> 
> The driver is named 'nv_falcon' to reflect that it specifically
> controls the Falcon microcontrollers for DMA operations, rather
> than exposing general GPU functionality.
> 
> Reference implementation:
> https://github.com/NVIDIA/gpu-admin-tools
> 
> Signed-off-by: Rubin Du <rubind@nvidia.com>
> Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>

Overall looks close, my comments are mostly nits.

I'm hoping to find a machine with one of the supported GPUs next week
as well so I can test out the new driver.

> +++ b/tools/testing/selftests/vfio/lib/drivers/nv_falcon/hw.h
> @@ -0,0 +1,350 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
> + */
> +#ifndef _NV_FALCON_HW_H_
> +#define _NV_FALCON_HW_H_

Please add #include <linux/types.h> here to avoid depending on header
include ordering.

> +static int gpu_poll_register(struct vfio_pci_device *device,
> +			     const char *name, u32 offset,
> +			     u32 expected, u32 mask, u32 timeout_ms)
> +{
> +	struct gpu_device *gpu = to_gpu_device(device);
> +	struct timespec start, now;
> +	u64 elapsed_ms;
> +	u32 value;
> +
> +	clock_gettime(CLOCK_MONOTONIC, &start);
> +
> +	for (;;) {
> +		value = gpu_read32(gpu, offset);
> +		if ((value & mask) == expected)
> +			return 0;
> +
> +		clock_gettime(CLOCK_MONOTONIC, &now);
> +		elapsed_ms = (now.tv_sec - start.tv_sec) * 1000
> +			     + (now.tv_nsec - start.tv_nsec) / 1000000;

Create a helper to avoid duplicating elapsed_ms below in
fsp_poll_queue().

> +static int fsp_init(struct vfio_pci_device *device)
> +{
> +	int ret;
> +
> +	ret = gpu_poll_register(device, "fsp_boot_complete",
> +				NV_FSP_BOOT_COMPLETE_OFFSET,
> +				NV_FSP_BOOT_COMPLETE_MASK, 0xffffffff, 5000);

Sashiko is wondering if the mask should be something other than
0xffffffff:

  https://sashiko.dev/#/patchset/20260408225459.3088623-1-alex.williamson%40nvidia.com?part=4

> +static void falcon_select_core_falcon(struct vfio_pci_device *device)
> +{
> +	struct gpu_device *gpu = to_gpu_device(device);
> +	const struct falcon *falcon = gpu->falcon;
> +	u32 core_select_reg = falcon->base_page + NV_FALCON_CORE_SELECT_OFFSET;
> +	u32 core_select;
> +
> +	/* Read current value */

nit: Unnecessary comment.

> +static int nv_falcon_dma_init(struct vfio_pci_device *device)
> +{
[...]
> +	if (!falcon->no_outside_reset) {
> +		ret = falcon_reset(device);
> +		if (ret)
> +			return ret;
> +	}

falcon_enable() is called right before nv_falcon_dma_init(). Calling
falcon_reset() here will do falcon_disable() and then falcon_enable()
again. So it seems unnecessary?

> +static int nv_falcon_dma(struct vfio_pci_device *device,
> +			     u64 address,
> +			     u32 size_encoding,
> +			     bool write)

nit: Align with open parenthesis.

> +static int nv_falcon_memcpy_chunk(struct vfio_pci_device *device,
> +				iova_t src,
> +				iova_t dst,
> +				u32 size_encoding)

nit: Align with open parenthesis.

> +{
> +	int ret;
> +
> +	ret = nv_falcon_dma(device, src, size_encoding, false);
> +	if (ret) {
> +		dev_err(device, "Failed DMA read (src=0x%lx, encoding=%u)\n",
> +			src, size_encoding);

nit: Move this and the next dev_err() into nv_falcon_dma().

> +		return ret;
> +	}
> +
> +	ret = nv_falcon_dma(device, dst, size_encoding, true);
> +	if (ret) {
> +		dev_err(device, "Failed DMA write (dst=0x%lx, encoding=%u)\n",
> +			dst, size_encoding);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int nv_falcon_probe(struct vfio_pci_device *device)
> +{
> +	enum gpu_arch gpu_arch;
> +	u32 pmc_boot_0;
> +	void *bar0;
> +	int i;
> +
> +	if (vfio_pci_config_readw(device, PCI_VENDOR_ID) != PCI_VENDOR_ID_NVIDIA)
> +		return -ENODEV;
> +
> +	if (vfio_pci_config_readw(device, PCI_CLASS_DEVICE) >> 8 !=
> +	    PCI_BASE_CLASS_DISPLAY)
> +		return -ENODEV;
> +
> +	/* Get BAR0 pointer for reading GPU registers */
> +	bar0 = device->bars[0].vaddr;
> +	if (!bar0)
> +		return -ENODEV;
> +
> +	/* Read PMC_BOOT_0 register from BAR0 to identify GPU */
> +	pmc_boot_0 = readl(bar0 + NV_PMC_BOOT_0);
> +
> +	/* Look up GPU architecture to verify this is a supported GPU */
> +	gpu_arch = nv_gpu_arch_lookup(pmc_boot_0);
> +	if (gpu_arch == GPU_ARCH_UNKNOWN) {
> +		dev_err(device, "Unsupported GPU architecture for PMC_BOOT_0: 0x%x\n",
> +			pmc_boot_0);
> +		return -ENODEV;
> +	}
> +
> +	/* Check verified GPU map */
> +	for (i = 0; i < VERIFIED_GPU_MAP_SIZE; i++) {
> +		if (verified_gpu_map[i] == pmc_boot_0)
> +			return 0;
> +	}
> +
> +	dev_info(device, "Unvalidated GPU: PMC_BOOT_0: 0x%x, possibly not supported\n",
> +		pmc_boot_0);

nit: Align with open parenthesis.

> +
> +	return 0;
> +}
> +
> +static void nv_falcon_init(struct vfio_pci_device *device)
> +{
> +	struct gpu_device *gpu = to_gpu_device(device);
> +	const struct gpu_properties *props;
> +	enum gpu_arch gpu_arch;
> +	u32 pmc_boot_0;
> +	int ret;
> +
> +	VFIO_ASSERT_GE(device->driver.region.size, sizeof(*gpu));
> +
> +	/* Read PMC_BOOT_0 register from BAR0 to identify GPU */
> +	pmc_boot_0 = readl(device->bars[0].vaddr + NV_PMC_BOOT_0);
> +
> +	/* Look up GPU architecture */
> +	gpu_arch = nv_gpu_arch_lookup(pmc_boot_0);

nit: gpu->arch can just be used to avoid needing extra local variable.

> +	VFIO_ASSERT_NE(gpu_arch, GPU_ARCH_UNKNOWN,
> +		       "Unsupported GPU architecture (PMC_BOOT_0=0x%x)\n", pmc_boot_0);

This assert should already be guaranteed by probe().

> +
> +	props = &gpu_properties_map[gpu_arch];
> +
> +	/* Populate GPU structure */
> +	gpu->arch = gpu_arch;
> +	gpu->bar0 = device->bars[0].vaddr;
> +	gpu->is_memory_clear_supported = props->memory_clear_supported;
> +	gpu->falcon = &falcon_map[props->falcon_type];
> +	gpu->pmc_enable_mask = props->pmc_enable_mask;
> +
> +	ret = falcon_enable(device);
> +	VFIO_ASSERT_EQ(ret, 0, "Failed to enable falcon: %d\n", ret);
> +
> +	/* Initialize falcon for DMA */
> +	ret = nv_falcon_dma_init(device);
> +	VFIO_ASSERT_EQ(ret, 0, "Failed to initialize falcon DMA: %d\n", ret);

Since the init() and remove() callbacks return void, propagating errors
from functions that are only reachable from there is unnecessary.
Consider using VFIO_ASSERT*() and making more functions return void.

Consider this an optional suggestion since will be a lot of churn and
I'm not sure it will be a net improvement.

> +
> +	device->driver.max_memcpy_size = NV_FALCON_DMA_MAX_TRANSFER_SIZE;
> +	device->driver.max_memcpy_count = NV_FALCON_DMA_MAX_TRANSFER_COUNT;
> +}
> +
> +static void nv_falcon_remove(struct vfio_pci_device *device)
> +{
> +	falcon_disable(device);
> +	vfio_pci_cmd_clear(device, PCI_COMMAND_MASTER);
> +}
> +
> +/*
> + * Falcon DMA can only process one transfer at a time,
> + * so the actual work is deferred to memcpy_wait() to conform to the
> + * memcpy_start()/memcpy_wait() contract.
> + */
> +static void nv_falcon_memcpy_start(struct vfio_pci_device *device,
> +				iova_t src, iova_t dst, u64 size, u64 count)

nit: Align with open parenthesis.

> +{
> +	struct gpu_device *gpu = to_gpu_device(device);
> +
> +	VFIO_ASSERT_EQ(gpu->memcpy_count, 0);

gpu->memcpy_count can be removed. The caller
vfio_pci_drvier_memcpy_start() guarantees no memcpys are in-progress. I
guess this was copied from the DSA driver, but that needs to track the
count because that determines what type of completion it needs to wait
on in memcpy_wait().

nv_falcon only supports a single copy, so no need to track the count
across start/wait.

> +static int nv_falcon_memcpy_wait(struct vfio_pci_device *device)
> +{
> +	struct gpu_device *gpu = to_gpu_device(device);
> +	iova_t src = gpu->memcpy_src;
> +	iova_t dst = gpu->memcpy_dst;
> +	u64 remaining = gpu->memcpy_size;
> +	int ret = 0;
> +
> +	VFIO_ASSERT_EQ(gpu->memcpy_count, 1);
> +
> +	/*
> +	 * Falcon DMA supports power-of-2 transfer sizes in [4, 256] and
> +	 * cannot cross 256-byte block boundaries.  Decompose the request
> +	 * into the largest valid chunk at each step.
> +	 */
> +	while (remaining) {
> +		u64 chunk = rounddown_pow_of_two(remaining);
> +
> +		chunk = min(chunk, dma_block_remain(src));
> +		chunk = min(chunk, dma_block_remain(dst));
> +
> +		ret = nv_falcon_memcpy_chunk(device, src, dst,
> +					     size_to_dma_encoding(chunk));

nit: Suggest moving size_to_dma_encoding() all the way down into
nv_falcon_dma()  keep this function simple, avoid the line wrap, and
it's an implementation detail of how the copy operation gets posted to
the device.
