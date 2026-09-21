Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BE1489FC6;
	Mon, 21 Sep 2026 11:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789989862; cv=none; b=XON7hOsImypTR1a3xrfnh1gsT9sLNeMlND6TkKjIkejfhKA/QMUQ9RTxInxtRm10xdrHiBzmBXN20tGR+xdL6jBwRF1xdbQRzKLc3M+Yk1rW1+85ZU7vao2Ia60IpTUdBPX9uV4OGHFeAkaj9vnTd/Y2k0Dj8O4BXF9B1onYlVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789989862; c=relaxed/simple;
	bh=5sEEOYSy7wj6igo+hrPdpdU/0AEjMQY5y3e2upniJmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QwUSpfm9rLYRBimzIqkDvAhu2Y6AlWvmFNcoorjBaAi6Abm+Jr16DZOd9EG4lzgZY24a3g8udzBYsnkYWICZiRCCTX2Rq4Pa0lBPrBBxp3R3CBnf+dk4JVhmeViL+uVRDsaLzmx3SzcdGVUbRqEuYog7G0t7kVivgFz3LcUItEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=el508ZSX; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="el508ZSX"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A6E1176C;
	Mon, 21 Sep 2026 04:24:12 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A15113F86F;
	Mon, 21 Sep 2026 04:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789989855; bh=5sEEOYSy7wj6igo+hrPdpdU/0AEjMQY5y3e2upniJmA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=el508ZSXkbgzQnJZ8DxHEQq434GiA7nJ9fjmQc0n7HCgG1y51lXdc3wLJTpQzmRfa
	 zVKNuPguBsz12vDPNEAJlqfwumB9cOD/AM+fk0jTDNyavHnTKhVPgxOuc46NMhNTLg
	 fEZJ2UESdLPGoQX2TijJNduSDdamtisU6tiB/39c=
Message-ID: <a82c3113-cee1-4e27-8c10-b7616f860a93@arm.com>
Date: Mon, 21 Sep 2026 12:24:13 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] iommu: Reserve PCI host bridge MMIO windows for
 IOVA
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>, jgg@ziepe.ca,
 kevin.tian@intel.com, alex@shazbot.org, joro@8bytes.org, will@kernel.org
Cc: iommu@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260921070234.897736-1-guanghuifeng@linux.alibaba.com>
 <20260921103922.1113752-1-guanghuifeng@linux.alibaba.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260921103922.1113752-1-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/09/2026 11:39 am, Guanghui Feng wrote:
> The DMA IOVA layer reserves PCI host bridge MMIO windows via
> iova_reserve_pci_windows() to keep IOVA allocations from overlapping
> those address ranges.  As commit fade1ec055dc ("iommu/dma: Avoid PCI
> host bridge windows") explains, a host bridge may interpret addresses
> falling within its MMIO windows as peer-to-peer DMA, leading to
> faults, data corruption, or DMA transactions being misrouted to the
> wrong PCIe device.  This is especially dangerous when a device sits
> behind a PCIe switch and ACS Upstream Forwarding is not fully enabled.
> 
> Passthrough paths that let userspace pick IOVAs did not honour these
> windows: VFIO type1 and iommufd only excluded IOMMU driver-level
> reserved regions (RMRR, unity maps, MSI), not PCI host bridge MMIO
> windows.

This was intentional - I forget where the exact discussion happened, but 
at the time we decided that exposing reserved regions for entire windows 
was the wrong thing to do, as being pessimistically inaccurate might be 
OK for the internal DMA API, but restricting userspace is another 
matter, and I think the consensus was that it wasn't really the IOMMU 
layer's job to get deep into PCI details anyway. Such "accidental" P2P 
can only happen within a group that's assigned to VFIO as a whole, so 
IIRC the conclusion was that users should already have enough 
information at the VFIO level to avoid BAR addresses if they need to.

In fact we did briefly do this once before, and it was explicitly undone 
again by cd2c9fcf5c66 ("iommu/dma: Move PCI window region reservation 
back into dma specific path."). I think there may also have been a 
practical issue with it breaking some standard Qemu setups.

Thanks,
Robin.

> 
> This series closes that gap:
> 
>    Patch 1 adds a common helper, iommu_get_pci_resv_windows(), and
>    reserves PCI host bridge MMIO windows in
>    iommu_get_group_resv_regions() so all group-level consumers (VFIO
>    type1, sysfs reserved_regions) avoid them; iova_reserve_pci_windows()
>    is refactored to reuse the helper.
> 
>    Patch 2 switches iommufd's iopt_table_enforce_dev_resv_regions() to
>    iommu_get_group_resv_regions() so IOMMU_IOAS_IOVA_RANGES also avoids
>    PCI host bridge MMIO windows, aligning iommufd with VFIO type1.
> 
> v1: https://lore.kernel.org/all/20260921070234.897736-1-guanghuifeng@linux.alibaba.com/
> 
> Changes since v1:
> - v1 was a single patch; v2 is a two-patch series.
> - Patch 1: build the reservations with iommu_insert_resv_region()
>    instead of list_add_tail(), so the group reserved list stays sorted
>    by start address and overlapping same-type regions are merged.  The
>    helper now frees its partial list itself on error and leaves the
>    caller's list untouched.
> - Patch 2 (new): reserve PCI host bridge MMIO windows for the iommufd
>    IOAS as well, so IOMMU_IOAS_IOVA_RANGES no longer reports IOVAs that
>    overlap PCI MMIO windows.
> 
> Notes on earlier automated review feedback:
> - The size_t length of each window matches struct iommu_resv_region's
>    existing field type; no new truncation is introduced on 64-bit.
> - An IOMMU group cannot span multiple PCI host bridges:
>    pci_device_group() only groups devices within a single host bridge
>    hierarchy, so scanning the first PCI device of the group is enough.
> 
> Guanghui Feng (2):
>    iommu: Reserve PCI host bridge MMIO windows in group reserved regions
>    iommufd: Reserve PCI host bridge MMIO windows in IOAS reserved regions
> 
>   drivers/iommu/dma-iommu.c            | 17 ++++--
>   drivers/iommu/iommu-priv.h           | 11 ++++
>   drivers/iommu/iommu.c                | 85 ++++++++++++++++++++++++++++
>   drivers/iommu/iommufd/io_pagetable.c | 15 ++++-
>   4 files changed, 121 insertions(+), 7 deletions(-)
> 

