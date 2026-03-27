Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A1537998A
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 22:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774651088; cv=none; b=QUUaHWOiWlRX4iBArZAID4niOjTX2VARU90CdVY2SKXNykZQgACnj63qZqClTRO92x4KrIWTKXFSp1OFWtFWrfjA2AqVPUH7CHPPSFyH7s3wcdp2tqysEAwfSFjTToM+4Ln/U628YVFpxHZrf6OvceQZjrzUYf2mqruQvAeE+yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774651088; c=relaxed/simple;
	bh=D3prHlADKsKYNGWLMM0GNzmNCFP1LXx9zmEigGv2DSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oO4sj2OsZnQWSV1hdct2NdZxvAxNKuzJzCzvy0foRlEzkIzybKN2LxU+OGGeSm0pTAeEUeLZpYZaPx3KkzxgVGptu+EcI+fCGWRcZt1Oj8NvVlUhhpbxf40Mhn77CjqUAlWUKpPRzNkD0SAWOY1jWJ+Mto43iIE58u+EmwoRjGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nfwmSz+V; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nfwmSz+V"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-829afe24fb5so1863966b3a.0
        for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 15:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774651086; x=1775255886; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wEHJkm4bUHYcdVXZ/JzKNQe+5dIZYRF3+nLXskZSPIc=;
        b=nfwmSz+VmRp4fLDtgkvcnauXOEcsihUvr2vZizQ9VXBYGDUemwxdCDV3bRW+qiwrl6
         9j+y2i3y/vlvizwmF3GPQR8QWPVmGV1hNG7ShUxMyfq5UiU4EyZ2aOndbkY48oagcusm
         /J86rznMJhf6wKi6OYScnK4TD0ZpS++k53XXcuYyOFX6EDIuZwpF6xPgG0q71v+fHeTG
         tmrqY6wc0Smp0hW4CIQDbp8udyZuK1jXALKC6p9Fu/aHCBu89BBlZB5DWtodubv5zTRq
         tw6pQUVOoRc9SRXZ/SXMt4DNgZ7YyFi/UJHUIu8w3K9TAYI4O06E+Mek2Ve5JcRTor4a
         KNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774651086; x=1775255886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wEHJkm4bUHYcdVXZ/JzKNQe+5dIZYRF3+nLXskZSPIc=;
        b=NmtDXr64iu+faYhDrNt//Dv0RNjA2xmYDgakMRyD++X7j5ST4WfHpMzD+DhmdXx30u
         x1naLF9mxHf/fLYHZpP38ZxrHVuZiqIH7HE/p3l1rMbQe5u0c/Ej5+30wMXrNLXx2kGy
         7ickdO4SW5OcMf+uqYOcBz/p7IyRTU3Hn//YDLdik9ctZdR0SM5MpIErtbsyQYElmzki
         BGMZidkYsp3r0slSCb6fho56SCs6mOJKhuSX6sLPHpRClkzokotAV2aS+NPRQR754s3m
         OmEGou8jDJM9VGOqQu8+AUB7YSNpUN0f+bTsZBzzqqwfOg5oSS3NDa7/Wet2wKJoSO57
         94/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUy7Ln2fH3MMehok01BMlRFDZEepOZPLo1BMPuOwKn1vXUAdKhvRffDY6BWCI6vWZZd8/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXwqrhICgEiO8jkrzWLP6LtsVQ+hUvKlKJRyU1h6t0o2XoflEB
	0uiB8OE6l97X/zBM2AdbcC19SjsyF9ehyYh+YG11949RaDgiqjbcpVvYTf1UY37Cbg==
X-Gm-Gg: ATEYQzxgj9/RVHhuvjwGOeNB2Umo/w4mjSH0sp3mw0kdYZaUJTeHvu8T9eGQoi3Kj3T
	5/TiZ6oDojjkAqrqyNs427o4aPMk1gb6X8OhO9zIV/ZQx8VceqOAOKQ13DnXx/JVB3OCbdmX15Y
	PZSMmTTWx/imuiGn5pd9wL7rfCPIMX3/PaldmQ+GH8hRBsnwZU1GdRC11MsCT0AgxJk1Rl8Vcch
	ErNp/vA96P+676Z3Hkzbtd32Kuk20IAX3SE+1efAVKfnf4auFSFK3410iKgp/X0CJzxX/5yF/30
	F2fgO3eSLCQTidPcEqaX6xfeAh7eqT1FaZSGbBvmfN0dzrg1j8wUs7w54PUb26lovrp0x5mQhpF
	LGkA9nR11Q22ovGB/TXB4pHaBQ7ErtSuoGSKQKimk0h6oTDi2xG8P0JFFtq3YEYs0CHVDr9a5/l
	kOpkuaxnDPOxkzctoIN9dG6420ZYAmlZvW924G7xrRPJHj1juFG0s+LXfcPLmgdQ==
X-Received: by 2002:a05:6a00:2884:b0:82a:65fa:cecf with SMTP id d2e1a72fcca58-82c95c19600mr3671016b3a.4.1774651085230;
        Fri, 27 Mar 2026 15:38:05 -0700 (PDT)
Received: from google.com (239.23.105.34.bc.googleusercontent.com. [34.105.23.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca84375e3sm279811b3a.2.2026.03.27.15.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 15:38:04 -0700 (PDT)
Date: Fri, 27 Mar 2026 22:38:00 +0000
From: David Matlack <dmatlack@google.com>
To: Rubin Du <rubind@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 2/2] selftests/vfio: Add NVIDIA Falcon driver for DMA
 testing
Message-ID: <accGyPMCOM_Y5VxK@google.com>
References: <20260325214329.464727-1-rubind@nvidia.com>
 <20260325214329.464727-3-rubind@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325214329.464727-3-rubind@nvidia.com>

On 2026-03-25 02:43 PM, Rubin Du wrote:
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

> The driver is named 'nv_falcon' to reflect that it specifically
> controls the Falcon microcontrollers for DMA operations, rather
> than exposing general GPU functionality.

Do you forsee this driver ever expanding to utilize other functionality
on the GPU  other than the Falcon microcontroller, e.g. to add
send_msi() support in the future and/or support asynchronous memcpy?

If so, the name "nv_falcon" could get out of date and maybe "nv_gpu"
would be a better name for this driver?

> Reference implementation:
> https://github.com/NVIDIA/gpu-admin-tools
> 
> Signed-off-by: Rubin Du <rubind@nvidia.com>
> ---
>  .../vfio/lib/drivers/nv_falcons/hw.h          | 365 +++++++++
>  .../vfio/lib/drivers/nv_falcons/nv_falcons.c  | 739 ++++++++++++++++++

Please make the directory and file names match the driver. i.e.
s/nv_falcons/nv_falcon/.

> diff --git a/tools/testing/selftests/vfio/lib/drivers/nv_falcons/hw.h b/tools/testing/selftests/vfio/lib/drivers/nv_falcons/hw.h
> new file mode 100644
> index 000000000000..a92cdcfec63f
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/lib/drivers/nv_falcons/hw.h
> @@ -0,0 +1,365 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
> + */
> +#ifndef _NV_FALCONS_HW_H_
> +#define _NV_FALCONS_HW_H_
> +
> +/* PMC (Power Management Controller) Registers */
> +#define NV_PMC_BOOT_0							0x00000000
> +#define NV_PMC_ENABLE							0x00000200
> +#define NV_PMC_ENABLE_PWR						0x00002000
> +#define NV_PMC_ENABLE_HUB						0x20000000

Please make the alignment of macro values consistent here and below.

> +
> +/* Falcon Base Pages for Different Engines */
> +#define NV_PPWR_FALCON_BASE						0x10a000
> +#define NV_PGSP_FALCON_BASE						0x110000
> +
> +/* Falcon Common Register Offsets (relative to base_page) */
> +#define NV_FALCON_DMACTL_OFFSET					0x010c
> +#define NV_FALCON_CPUCTL_OFFSET					0x0100
> +#define NV_FALCON_ENGINE_RESET_OFFSET			0x03c0
> +
> +/* DMEM Control Register Flags */
> +#define NV_PPWR_FALCON_DMEMC_AINCR_TRUE			0x01000000
> +#define NV_PPWR_FALCON_DMEMC_AINCW_TRUE			0x02000000
> +
> +/* Falcon DMEM port offsets (for port 0) */
> +#define NV_FALCON_DMEMC_OFFSET					0x1c0
> +#define NV_FALCON_DMEMD_OFFSET					0x1c4
> +
> +/* DMA Register Offsets (relative to base_page) */
> +#define NV_FALCON_DMA_ADDR_LOW_OFFSET			0x110
> +#define NV_FALCON_DMA_MEM_OFFSET				0x114
> +#define NV_FALCON_DMA_CMD_OFFSET				0x118
> +#define NV_FALCON_DMA_BLOCK_OFFSET				0x11c
> +#define NV_FALCON_DMA_ADDR_HIGH_OFFSET			0x128

> +struct gpu_device {
> +	enum gpu_arch arch;
> +	void *bar0;
> +	bool is_memory_clear_supported;
> +	const struct falcon *falcon;
> +	u32 pmc_enable_mask;
> +	bool fsp_dma_enabled;
> +
> +	/* Pending memcpy parameters, set by memcpy_start() */
> +	u64 memcpy_src;
> +	u64 memcpy_dst;
> +	u64 memcpy_size;
> +	u64 memcpy_count;
> +};

nit: I would move this to the driver .c file since that's where its used
and this isn't a hardware definition. It will make the driver easier to
read to have this struct definition in the same file.

> diff --git a/tools/testing/selftests/vfio/lib/drivers/nv_falcons/nv_falcons.c b/tools/testing/selftests/vfio/lib/drivers/nv_falcons/nv_falcons.c
> new file mode 100644
> index 000000000000..4b62793570a2
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/lib/drivers/nv_falcons/nv_falcons.c
> @@ -0,0 +1,739 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
> + */
> +#include <stdint.h>
> +#include <strings.h>
> +#include <unistd.h>
> +#include <stdbool.h>
> +#include <string.h>
> +#include <time.h>
> +
> +#include <linux/errno.h>
> +#include <linux/io.h>
> +#include <linux/pci_ids.h>
> +
> +#include <libvfio.h>
> +
> +#include "hw.h"
> +
> +static inline struct gpu_device *to_nv_gpu(struct vfio_pci_device *device)

nit: Please align the naming here. i.e. rename this function to
to_gpu_device() or rename struct gpu_device to struct nv_gpu.

> +{
> +	return device->driver.region.vaddr;
> +}

> +static int gpu_poll_register(struct vfio_pci_device *device,
> +			     const char *name, u32 offset,
> +			     u32 expected, u32 mask, u32 timeout_ms)
> +{
> +	struct gpu_device *gpu = to_nv_gpu(device);
> +	u32 value;
> +	struct timespec start, now;
> +	u64 elapsed_ms;
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
> +
> +		if (elapsed_ms >= timeout_ms)
> +			break;
> +
> +		usleep(1000);
> +	}
> +
> +	dev_err(device,
> +		"Timeout polling %s (0x%x): value=0x%x expected=0x%x mask=0x%x after %llu ms\n",
> +		name, offset, value, expected, mask,
> +		(unsigned long long)elapsed_ms);
> +	return -ETIMEDOUT;

Please fix all the callers of this function that ignore the return
value. Presumably you should be using VFIO_ASSERT_EQ(ret, 0) to bail the
test if something goes wrong (other than during memcpy_wait(), which has
a way to return an error to the caller).

> +static void gpu_enable_bus_master(struct vfio_pci_device *device)
> +{
> +	u16 cmd;
> +
> +	cmd = vfio_pci_config_readw(device, PCI_COMMAND);
> +	vfio_pci_config_writew(device, PCI_COMMAND, cmd | PCI_COMMAND_MASTER);
> +}
> +
> +static void gpu_disable_bus_master(struct vfio_pci_device *device)
> +{
> +	u16 cmd;
> +
> +	cmd = vfio_pci_config_readw(device, PCI_COMMAND);
> +	vfio_pci_config_writew(device, PCI_COMMAND, cmd & ~PCI_COMMAND_MASTER);
> +}

These can be generic to any PCI device so please add them as static
inline helpers in vfio_pci_device.h for other tests to use in the future
(and rename them to something more generic like
vfio_pci_disable_bus_master()).

> +static int nv_gpu_falcon_dma(struct vfio_pci_device *device,
> +			     u64 address,
> +			     u32 size_encoding,
> +			     bool write)
> +{
> +	struct gpu_device *gpu = to_nv_gpu(device);
> +	const struct falcon *falcon = gpu->falcon;
> +	u32 dma_cmd;
> +	int ret;
> +
> +	gpu_write32(gpu, NV_GPU_DMA_ADDR_TOP_BITS_REG,
> +		    (address >> 47) & 0x1ffff);
> +	gpu_write32(gpu, falcon->base_page + NV_FALCON_DMA_ADDR_HIGH_OFFSET,
> +		    (address >> 40) & 0x7f);
> +	gpu_write32(gpu, falcon->base_page + NV_FALCON_DMA_ADDR_LOW_OFFSET,
> +		    (address >> 8) & 0xffffffff);
> +	gpu_write32(gpu, falcon->base_page + NV_FALCON_DMA_BLOCK_OFFSET,
> +		    address & 0xff);
> +	gpu_write32(gpu, falcon->base_page + NV_FALCON_DMA_MEM_OFFSET, 0);
> +
> +	dma_cmd = (size_encoding << NV_FALCON_DMA_CMD_SIZE_SHIFT);
> +
> +	/* Set direction: write (DMEM->mem) or read (mem->DMEM) */
> +	if (write)
> +		dma_cmd |= NV_FALCON_DMA_CMD_WRITE_BIT;
> +
> +	gpu_write32(gpu, falcon->base_page + NV_FALCON_DMA_CMD_OFFSET, dma_cmd);
> +
> +	ret = gpu_poll_register(device, "dma_done",
> +		falcon->base_page + NV_FALCON_DMA_CMD_OFFSET,
> +		NV_FALCON_DMA_CMD_DONE_BIT, NV_FALCON_DMA_CMD_DONE_BIT,
> +		1000);
> +	if (ret)
> +		return ret;
> +
> +	return 0;


nit: This can just be "return ret;" or "return gpu_poll_register(...);".

> +static void nv_gpu_init(struct vfio_pci_device *device)
> +{
> +	struct gpu_device *gpu = to_nv_gpu(device);
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
> +	if (gpu_arch == GPU_ARCH_UNKNOWN) {
> +		dev_err(device, "Unsupported GPU architecture\n");
> +		return;
> +	}
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
> +	falcon_enable(device);
> +
> +	/* Initialize falcon for DMA */
> +	ret = nv_gpu_falcon_dma_init(device);
> +	VFIO_ASSERT_EQ(ret, 0, "Failed to initialize falcon DMA: %d\n", ret);
> +
> +	device->driver.features |= VFIO_PCI_DRIVER_F_NO_SEND_MSI;
> +	device->driver.max_memcpy_size = NV_FALCON_DMA_MAX_TRANSFER_SIZE;
> +	device->driver.max_memcpy_count = NV_FALCON_DMA_MAX_TRANSFER_COUNT;

The small memcpy size is going to be a problem tests that want to DMA to
larger regions. They will have to do chunk up the memcpy in a loop.

One option would be to have this driver expose a larger max_memcpy_size
and implement the loop in the memcpy_start()/wait() callback, which is
actually what you have below.

But I think a better approach would be to just make the loop common
across all drivers so that tests never have to care about
max_memcpy_size when using vfio_pci_driver_memcpy().

Can you add a precursor commit to this series that adds a loop to
vfio_pci_driver_memcpy() so that it performs whatever sized memcpy the
user asks for by chunking it up in to max_memcpy_size or smaller
chunks? In that same commit, please update the vfio_pci_driver_test
so we get coverage of the new chunking logic (get rid of the code that
rounds down self->size fo max_memcpy_size, except for the memcpy_storm
test).

In other words:

 - vfio_pci_driver_memcpy() should allow any size memcpy and will chunk
   it up as necessary depending on what the driver supports.

 - vfio_pci_driver_memcpy_start() semantics don't change. This still
   gives tests direct access to the driver memcpy_start() op and thus
   must obey max_memcpy_size.

This should also allow you to greatly simplify the implementation of
memcpy_wait() down below.

> +static int nv_gpu_memcpy_wait(struct vfio_pci_device *device)
> +{
> +	struct gpu_device *gpu = to_nv_gpu(device);
> +	u64 iteration;
> +	u64 offset;
> +	int ret;
> +
> +	VFIO_ASSERT_NE(gpu->memcpy_count, 0);
> +
> +	for (iteration = 0; iteration < gpu->memcpy_count; iteration++) {

This loop is unnecessary. You set max_memcpy_count to
NV_FALCON_DMA_MAX_TRANSFER_COUNT which is 1. So
vfio_pci_driver_memcpy_start() will guarantee that memcpy_count is at
most 1.

> +		offset = 0;
> +
> +		while (offset < gpu->memcpy_size) {
> +			int chunk_encoding;
> +
> +			chunk_encoding = size_to_dma_encoding(
> +						gpu->memcpy_size - offset);

This loop is also unnecessary. You set max_memcpy_size to
NV_FALCON_DMA_MAX_TRANSFER_SIZE, so vfio_pci_driver_memcpy_start() will
guarantee memcpy_size is at most that.

> +			if (chunk_encoding < 0) {
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +
> +			ret = nv_gpu_memcpy_chunk(device,
> +						  gpu->memcpy_src + offset,
> +						  gpu->memcpy_dst + offset,
> +						  chunk_encoding);
> +			if (ret)
> +				goto out;
> +
> +			offset += 0x4 << chunk_encoding;
> +		}
> +	}
> +
> +	ret = 0;
> +out:
> +	gpu->memcpy_count = 0;
> +
> +	return ret;
> +}
