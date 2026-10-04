Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9537B36B928
	for <kvm@vger.kernel.org>; Sun,  4 Oct 2026 16:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791131514; cv=none; b=VdQdmSOVr5+5Qb5yKqx+xiNBmI+lIBVMdNCtRM+C2S/2SoeY5Sy/P724kstowq8M4GgtvFnZKKg5/47Rv61fWg2V6YUw/Xrn2sTNAJ8C94O1SpcFE7tVucQx/GeOZ5EFORd+xvDDkmMDQf3fgHuj1fvZc5Er2Q7VjTH3woLRhX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791131514; c=relaxed/simple;
	bh=HR0gOZH/aA7y+ERB4Kf1ZG7rBVA65U8/0NBGiEUkO4g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iZc2a2U779jxxbXv23X4mAFv1fGoG3hyLTQ4xit2DYg5ltrYbEvu4wFjIUHuwDcw+OSE0EnoTNNt9E4RkFAmY35piUfCzj497hDG1xOYhro2SrhvOiYeVblRywqcYelPmzk8YaxugtURw2//JwuPYpSMKwlH4wnMqnUxWW//I+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcDKHkl/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcDKHkl/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509141F000FF;
	Sun,  4 Oct 2026 16:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791131513;
	bh=Sh/CUOOrLV2QB7ceYqkO3gwRYb26yZ4sPKEoNYPmctU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UcDKHkl/i3EGn5zuieQe0046mmFeIdBqjA+jgHF2uDiK8Snk4D38myO7R7NEnN/zv
	 7hGd/vFfeuLhZYi4AaMiGlZZeO4jbPG3cHqTYgvgdNwwXlvHHO5H+NfA3xJX1PRySf
	 avN+JiCrEg9BSajrLpr0IMhjzrL9UCneLhHzcxJ2PP5sNlqejbcSrF/BErs8iZlvTV
	 RKCO4XtY9EnHEYn89DRMl6NrGIOZ+orZuFzMxsw0VVpU0poUsXwad62VASzb6nxO7I
	 U5cTxSom4RfuZ17vWm7yMjC6PzsTCuDt/LlchUdpjUXm/wFwAH5wmoMSHmGp0UuokU
	 vD1utBJU/Aglw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] iommu: Add iommu_get_pci_resv_windows() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261004162213.3787623-2-guanghuifeng@linux.alibaba.com>
References: <20260921115513.GK11599@ziepe.ca>
 <20261004162213.3787623-1-guanghuifeng@linux.alibaba.com>
 <20261004162213.3787623-2-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 16:31:52 +0000
Message-Id: <20261004163153.509141F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] iommu: integer truncation of PCI MMIO window length on 32-bit sy=
stems
--

commit 913f9140edb50fcf9c22ac52938eee20ee68edc7
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

iommu: Add iommu_get_pci_resv_windows() helper

This commit adds a common helper that walks a PCI device's host bridge MMIO
windows and returns them as IOMMU_RESV_RESERVED regions in a list. It
provides a reusable interface for subsystems that need visibility into PCI
host bridge MMIO address ranges, such as iommufd.

> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index b486b8bbd1fcd..be774edef550f 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
[ ... ]
> @@ -945,6 +945,63 @@ iommu_insert_device_resv_regions(struct list_head *d=
ev_resv_regions,
>  	return ret;
>  }
> =20
> +#ifdef CONFIG_PCI
> +/**
> + * iommu_get_pci_resv_windows - collect PCI host bridge MMIO windows as
> + *                               reserved regions
[ ... ]
> +int iommu_get_pci_resv_windows(struct pci_dev *dev, struct list_head *he=
ad)
> +{
> +	struct pci_host_bridge *bridge =3D pci_find_host_bridge(dev->bus);
> +	struct iommu_resv_region *region, *next;
> +	struct resource_entry *window;
> +	LIST_HEAD(resv_windows);
> +	int ret;
> +
> +	if (!bridge)
> +		return -ENODEV;
> +
> +	resource_list_for_each_entry(window, &bridge->windows) {
> +		struct iommu_resv_region tmp =3D {
> +			.type =3D IOMMU_RESV_RESERVED,
> +		};
> +
> +		if (resource_type(window->res) !=3D IORESOURCE_MEM)
> +			continue;
> +
> +		tmp.start =3D window->res->start - window->offset;
> +		tmp.length =3D window->res->end - window->res->start + 1;

[Severity: Medium]
On 32-bit systems with 64-bit physical addressing (e.g. ARM LPAE or x86 PAE=
),
if a PCI host bridge has an MMIO window larger than 4GB, does this implicit=
ly
truncate the 64-bit resource_size_t value into the 32-bit size_t length fie=
ld
of struct iommu_resv_region?

This truncation could allow IOVA allocations to overlap with PCI MMIO windo=
ws,
leading to IOMMU faults, unexpected peer-to-peer routing, and potential mem=
ory
corruption.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004162213.3787=
623-2-guanghuifeng@linux.alibaba.com?part=3D1
