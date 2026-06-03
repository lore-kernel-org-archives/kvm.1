Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E86F3D0C0B
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 16:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780502582; cv=none; b=lbcHOlna50ESS+D4yvqmcNr0VrVYMX7UQGRUwqOJvQhLbG3RHjUcPtKSx/w9nj+6to+ikhs0tv9KhWQ31dxoDzQbgGHkEY1MrDKgvMwVR17gxtPi9CLquwNtlx90/3slZIZaOsA9a4pxDr2CcImnePAOgylZmbgJhwzArY88wwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780502582; c=relaxed/simple;
	bh=luZuYRpvO9rtqqTcFihx7iJ2PwuNLABxly+F5WMHiuk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c7MxxF8/Z7E6LZTvTLFBgIOLRFHpfTQtWALgxPtezlWVTC16ACqPpolgQDDpX0qlN334BtZl8Orz9C6LGYp9K43Do6cv4E6R80ishoMAmgEMDiO2pvPmA8hVxE1gOzs3unklo3wR4iRS8PH9LPNMVDeWi4yZizVb5SL8HxsG9mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hi7700KA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hi7700KA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8333E1F00893;
	Wed,  3 Jun 2026 16:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780502580;
	bh=3VMDzoIeBDMJxJre780PNmMq7WY9p2S735zBwOJg3vo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hi7700KAmY/EcpFgbVafUjwkzsgNfMqmh0ZPn16ZSqRM00WKCuAdwydx8DzHVQr2J
	 S90gYVUKbLTwfRxRBxtd1hYtb41cbJTXbgMmOI1IHAYAMCJBvV7xxEBtVYgfObWvyC
	 fsNjj/mazbig2kvPVryKAalf37wIelHTqGmL5O4aGGXAcXu8CZWawQITmDjTDpcNtC
	 xWA/qQRwpGCZgy/6OiC7+4wTopdMn/SsMzHZUMmwcotAssZIBsfq3mBAVFUy9ZYmkB
	 PsOe8nmUOz3C0vxgB88+FUVhQfmKR3vQc81LDTmjWy1vu9HiQ8AoM0zBsVKqBXt21U
	 Cas6r9tdmjJLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 18/32] iommu/s390: implement iova_to_phys_length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260603151804.1963871-19-guanghuifeng@linux.alibaba.com>
References: <20260603151804.1963871-19-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 16:03:00 +0000
Message-Id: <20260603160300.8333E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] NULL Pointer Dereference translating unmapped IOVA in RFX doma=
ins
- [High] Missing Page Offset in Physical Address translation
--

commit bd4ad597aec5185d8df34a68d40de0a381a961b3
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Subject: iommu/s390: implement iova_to_phys_length

This commit implements the iova_to_phys_length callback for the s390 IOMMU
driver. It returns the actual PTE mapping size via the mapped_length
parameter alongside the translated physical address.

> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
[ ... ]
> -static phys_addr_t s390_iommu_iova_to_phys(struct iommu_domain *domain,
> -					   dma_addr_t iova)
> +static phys_addr_t s390_iommu_iova_to_phys_length(struct iommu_domain *d=
omain,
> +						  dma_addr_t iova,
> +						  size_t *mapped_length)
>  {
[ ... ]
>  	if (iova < domain->geometry.aperture_start ||
>  	    iova > domain->geometry.aperture_end)
> -		return 0;
> +		return PHYS_ADDR_MAX;
> =20
>  	rto =3D get_rto_from_iova(s390_domain, iova);

[Severity: High]
This isn't a regression introduced by this patch, but could this code lead =
to
a NULL pointer dereference when querying an unmapped IOVA in an RFX domain?

If the top-level Region First Entry is unmapped, get_rso_from_iova()
returns NULL. However, get_rto_from_iova() appears to immediately
dereference it without checking:

drivers/iommu/s390-iommu.c:get_rto_from_iova() {
        ...
	case ZPCI_TABLE_TYPE_RFX:
	case ZPCI_TABLE_TYPE_RSX:
		rso =3D get_rso_from_iova(domain, iova);
		rsx =3D calc_rsx(iova);
		rse =3D READ_ONCE(rso[rsx]);
        ...
}

>  	if (!rto)
> -		return 0;
> +		return PHYS_ADDR_MAX;
> =20
>  	rtx =3D calc_rtx(iova);
>  	sx =3D calc_sx(iova);
> @@ -1014,8 +1015,11 @@ static phys_addr_t s390_iommu_iova_to_phys(struct =
iommu_domain *domain,
>  		if (reg_entry_isvalid(ste)) {
>  			pto =3D get_st_pto(ste);
>  			pte =3D READ_ONCE(pto[px]);
> -			if (pt_entry_isvalid(pte))
> +			if (pt_entry_isvalid(pte)) {
>  				phys =3D pte & ZPCI_PTE_ADDR_MASK;

[Severity: High]
This isn't a regression introduced by this patch, but does this calculation
drop the intra-page offset from the returned physical address?

By returning the page-aligned PTE address without adding back the offset
(iova & ~PAGE_MASK), callers passing an unaligned IOVA might receive an
incorrectly truncated physical address. The core IOMMU framework's
iommu_iova_to_phys() doesn't add this offset back either.

> +				if (mapped_length)
> +					*mapped_length =3D SZ_4K;
> +			}
>  		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603151804.1963=
871-1-guanghuifeng@linux.alibaba.com?part=3D18
