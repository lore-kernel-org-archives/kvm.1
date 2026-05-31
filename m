Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864E42DCC1F
	for <kvm@vger.kernel.org>; Sun, 31 May 2026 10:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780224449; cv=none; b=sY6sODgCDxM15XJxsMxNF5kt1WkDvf5AJYnic4lcAVUq0sSn4RRaR75w5GsUonEJH6Ar0zhTawuihdTndIIgk+rHy1qvWV22rWIYl8gg8s7qF1EeM6GMak/WiHY8EqZ5W99AQFk+Ggc/8e6IeMWYNCiLhpcpc3D9ovhDGICrmBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780224449; c=relaxed/simple;
	bh=37y4+ERDrlyfciBM+vHpLYyMaPoEX0rLaOB6SlWnnX0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TVgTNgsSWyYAAWWanBIFq1P74893zRN3lQfCpn0yBSviNVH57TNiVLFzAfVwCTfv6qerCGj8AmESs7LH+/VWsY8veeCZWUsIOBMJVT1MmoBjq9bNFCZXWIwrDUc3yi02qx6cP2bcvC7kU3XeiM5go4s8hQU63QW8ayjiFi84yHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g751tdfj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g751tdfj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92871F00893;
	Sun, 31 May 2026 10:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780224448;
	bh=BVVlVmGtmDx5ELwH/OIYir30mElwYXCL8/1ijsTZnoQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g751tdfjiRv9LP2XHvZ8tBOb+/pJxPByFHTbW4aN5faMWJ9lpT2e/xvdp+NEBktx1
	 SQlvjgHsHGAvcGT7Wf+Gp29ti6fzp9DIJ3Z7vGwGiMce9LAR7Xhg1FouXF/cNDVqF/
	 OZp2QnOEDBK+fbsoaNnUFraA+fsb8lbZHTtqljNGFzkVm3lk+LICAE9+ffocEuHq8y
	 Igl37OUvob9hNStGc01DN2SvkU/8/75tZ2kCjTFeekQdMIum2MBJ/Bm+0n9fqf1gBa
	 Iprw2XjYruEX9S28CTq2tC0xLHdjNHJ7vWMXXcKA2gJnajuGlVmDnLkCMQ98ZQqRby
	 2It6AbvSJMljw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/9] iommu: direct page-table drivers implement
 iova_to_phys_length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260531093637.3893199-7-guanghuifeng@linux.alibaba.com>
References: <20260531093637.3893199-7-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 10:47:27 +0000
Message-Id: <20260531104727.E92871F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Unmapped IOVAs return fake physical address and length
- [High] viommu_iova_to_phys_length returns non-power-of-two size, corrupti=
ng VFIO unmap
- [Medium] Integer truncation on 32-bit systems defeats unmap optimization

Pre-existing issues:
- [Critical] NULL pointer dereference when querying unmapped IOVAs on s390
--

commit 2222000e24f667e099e4484bdedb23cb1c3c3cfd
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

iommu: direct page-table drivers implement iova_to_phys_length

Implement iova_to_phys_length for all IOMMU drivers with direct page tables.
Each returns the actual PTE mapping size. Also fixes an mtk_iommu_v1
pre-existing bug.

> diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_dom=
ain.c
> index 9664ef9840d2c..48a072074b56c 100644
> --- a/drivers/iommu/fsl_pamu_domain.c
> +++ b/drivers/iommu/fsl_pamu_domain.c
[ ... ]
> +	/*
> +	 * PAMU configures exactly one Primary PAACE entry per LIODN with the
> +	 * Multi-Window (MW) bit cleared and ATM =3D PAACE_ATM_WINDOW_XLATE,
> +	 * WBAL/TWBAL =3D 0. That is, every LIODN is backed by a single hardware
> +	 * mapping window of fixed size (1ULL << 36, i.e. 64GB, see
> +	 * pamu_config_ppaace()) performing an identity translation. The driver
> +	 * does not split this window into SPAACE sub-windows, so the entire
> +	 * aperture is one PAACE "PTE" entry. Return that single entry's size
> +	 * as mapped_length, matching the iova_to_phys_length contract that
> +	 * mapped_length reports the full size of the mapping entry which
> +	 * covers iova (not the remaining bytes from iova to its end).
> +	 */
> +	if (mapped_length)
> +		*mapped_length =3D 1ULL << 36;

[Severity: Medium]
Will this assignment truncate on 32-bit systems?

On 32-bit architectures like PPC32 (which PAMU supports), size_t is 32 bits.
Assigning 1ULL << 36 to mapped_length will silently truncate to 0. While
callers like VFIO might check for 0 and safely fall back to PAGE_SIZE, does=
n't
this entirely break the performance optimization intended for PAMU?

> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index f148f559ac564..8df98aceb5f72 100644
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
[ ... ]
> @@ -986,8 +986,9 @@ static unsigned long *get_rto_from_iova(struct s390_d=
omain *domain,
>  	}
>  }
> =20
> -static phys_addr_t s390_iommu_iova_to_phys(struct iommu_domain *domain,
> -					   dma_addr_t iova)
> +static phys_addr_t s390_iommu_iova_to_phys_length(struct iommu_domain *d=
omain,
> +						  dma_addr_t iova,
> +						  size_t *mapped_length)
>  {

[Severity: Critical]
This is a pre-existing issue, but does get_rto_from_iova() suffer from a NU=
LL
pointer dereference when queried with unmapped IOVAs?

If the first-level table entry is invalid (which is normal for an unmapped
IOVA), get_rso_from_iova() returns NULL. When get_rto_from_iova() fails to
check this and immediately evaluates READ_ONCE(rso[rsx]), does it cause a
kernel panic?

Since the iova_to_phys_length API is exposed to external callers like VFIO,
could this be triggered by a guest or userspace?

> diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
> index c1a34445d244f..da14574a64308 100644
> --- a/drivers/iommu/sprd-iommu.c
> +++ b/drivers/iommu/sprd-iommu.c
[ ... ]
>  	pa =3D (pa << SPRD_IOMMU_PAGE_SHIFT) + ((iova - start) & (SPRD_IOMMU_PA=
GE_SIZE - 1));
>  	spin_unlock_irqrestore(&dom->pgtlock, flags);
> =20
> +	if (pa && mapped_length)
> +		*mapped_length =3D SPRD_IOMMU_PAGE_SIZE;
> +

[Severity: High]
Does this code assign a fake mapped_length for unmapped IOVAs?

In sprd_iommu_iova_to_phys_length(), if the IOVA is unmapped (PTE is 0) but
not page-aligned, pa is incorrectly evaluated to a non-zero offset. By addi=
ng
this check, does the new API now formally claim a valid 4KB mapping exists?

Could this mislead the IOMMU core into treating unmapped addresses as valid,
potentially leading to memory corruption or undefined behavior in callers
like VFIO?

> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 587fc13197f12..80c9c06a13804 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
[ ... ]
>  	spin_lock_irqsave(&vdomain->mappings_lock, flags);
>  	node =3D interval_tree_iter_first(&vdomain->mappings, iova, iova);
>  	if (node) {
>  		mapping =3D container_of(node, struct viommu_mapping, iova);
>  		paddr =3D mapping->paddr + (iova - mapping->iova.start);
> +		if (mapped_length)
> +			*mapped_length =3D mapping->iova.last -
> +					 mapping->iova.start + 1;

[Severity: High]
Can returning a non-power-of-two size here break API consumers?

virtio-iommu computes mapped_length as the exact interval size, which might=
 not
be a power-of-two (e.g., 3 pages). However, callers like vfio_iommu_type1 r=
ely
on mapped_length being a valid power-of-two PTE size to calculate remaining
contiguous bytes via bitwise math:

    pgsize - (iova & (pgsize - 1))

Does providing a non-power-of-two size produce an invalid bitmask resulting=
 in
garbage offset values? If this causes VFIO to overestimate the contiguous b=
lock
size and unmap adjacent, potentially unrelated memory, could it lead to mem=
ory
corruption?

Additionally, would an identity mapping spanning the 64-bit address space
overflow this calculation to 0?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531093637.3893=
199-1-guanghuifeng@linux.alibaba.com?part=3D6
