Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE80B317155
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 15:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780501691; cv=none; b=TYU0NIm/umTE5wDT8fjjHSFwjoq4KsZ0wd0EoqverjiCK46MBmy/WRU4vrsP4iec0ABb8JPGtQh9+xMAETDQB4we9dTY1JIJW8oD6ipPZV2t7vc+QhPLB8OpaEjakgkXtXDGP+xUoqsx6CzOTnfQGl2gaThlfD52WDWVl40ukTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780501691; c=relaxed/simple;
	bh=+rspAt4QRfb9aCvr/tf02JAfOMu5gaKGWf1kSHsNF34=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GPPbnuSl4mgD4aq89ze7LVMPLkU1PPIno7wPxZ+5zGURFJcecBXDpK6tAsZ+ZpsX8AM44KxqGqrD6dgkOE71MRmetkcpGB08pdGS0kBUfqNt3Asx+1bOLOyjzn3dB4VwjjKy9xE7yHmpDiTozGeOfJTGgmwUhV7jwxPU7O5RvZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAFtbmiN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAFtbmiN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616741F00893;
	Wed,  3 Jun 2026 15:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780501689;
	bh=I1WyU1DqUFPonbdXnJSkZaEYGNbVsQ+YLZrYqJkgvm8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZAFtbmiN+xjhjUUXFMAcsBMhJli9qjo5lzBV6cV/0V28m7HTR0VSr8+NxjN9gkLaP
	 52khbiZpI2vSIawtAoB4KecGHTb0OZGub9+ZV145G68xM39uXiTg0Sy8qQKcpZrlwX
	 1iClXdacIPNlEk45TctXYosXbHykh/Fa3E2068Yb6iIwH9qAORLgIRxnz5N4eyjMX3
	 o1j+zwj6znVsY8Ujg8boOFRJmHPbJXzeg3FQq1o9DUbMEANkaBsrq4Ex/QVLhc/v3z
	 nvQyxqyXWOYCiHecsAkBEaO/Cg6sXudwzEdn+hrqGTSPu7tP9MNR7t6OXNu8dU9xM5
	 /w+OY3JYGn+AA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/32] iommu/fsl_pamu: implement iova_to_phys_length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260603151804.1963871-14-guanghuifeng@linux.alibaba.com>
References: <20260603151804.1963871-14-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 15:48:08 +0000
Message-Id: <20260603154809.616741F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] iommufd and vfio misinterpret mapped_length as the remaining c=
ontiguous length, leading to out-of-bounds physical address batching.
- [Critical] Assigning 64GB (`1ULL << 36`) to `size_t *mapped_length` silen=
tly truncates to `0` on 32-bit kernels.
--

commit bd63c934fd433e9c7d21862a31a674fe50af2eae
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

iommu/fsl_pamu: implement iova_to_phys_length

This commit implements the iova_to_phys_length callback for the FSL PAMU
IOMMU driver. It returns the actual PTE mapping size for a given IOVA.

> diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_dom=
ain.c
> index 9664ef9840d2c..60abd497dc639 100644
> --- a/drivers/iommu/fsl_pamu_domain.c
> +++ b/drivers/iommu/fsl_pamu_domain.c
[ ... ]
> @@ -169,12 +169,30 @@ static void attach_device(struct fsl_dma_domain *dm=
a_domain, int liodn, struct d
>  	spin_unlock_irqrestore(&device_domain_lock, flags);
>  }
> =20
> -static phys_addr_t fsl_pamu_iova_to_phys(struct iommu_domain *domain,
> -					 dma_addr_t iova)
> +static phys_addr_t fsl_pamu_iova_to_phys_length(struct iommu_domain *dom=
ain,
> +						dma_addr_t iova,
> +						size_t *mapped_length)
>  {
> +
>  	if (iova < domain->geometry.aperture_start ||
>  	    iova > domain->geometry.aperture_end)
> -		return 0;
> +		return PHYS_ADDR_MAX;
> +
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

[Severity: Critical]
Does this assignment silently truncate to 0 on 32-bit kernels?

Since mapped_length is a size_t pointer, assigning 1ULL << 36 (which is 64G=
B)
will truncate to 0 when size_t is 32-bit, potentially causing caller infini=
te
loops.

[Severity: Critical]
Could this implementation cause out-of-bounds physical address batching in
callers?

The comment mentions that mapped_length reports the full size of the mapping
entry rather than the remaining bytes from iova to its end.

However, callers appear to misinterpret mapped_length as the remaining
contiguous length. For example, in drivers/iommu/iommufd/pages.c,
batch_from_domain() fails to account for the IOVA offset within the PTE:

	npages =3D pgsize / PAGE_SIZE;

Similarly, in drivers/vfio/vfio_iommu_type1.c, vfio_unmap_unpin() directly
uses pgsize without adjusting for the offset:

	len =3D min_t(size_t, pgsize, dma->size - pos);

By returning the full PTE size without adjusting for the offset within the =
PTE,
can this lead to memory corruption when callers over-batch physical pages?

> +
>  	return iova;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603151804.1963=
871-1-guanghuifeng@linux.alibaba.com?part=3D13
