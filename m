Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BCE3806C6
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 11:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780398648; cv=none; b=Wa7kM98PwjAFE45HJML+Vu5HMBqFVyX7Ytr2yRdmvm7wmaqc8snk29Izy+VxTXvOstDYAat6aP8/EgBryugbaPqjLW5beUqZW+PU8LGY+IqP77sPKgy8ltu5R4xCaa/BwN/sOLQlLfIdHyqOOmI5zhdUa+IS2AnmAbR15zx4yq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780398648; c=relaxed/simple;
	bh=bB/7sRDSPocPlb1asxXjRbgFzmiWIcyDy+WtUTi3dKA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qGdZB8iS3u4/RjpHSg2GXLYI8g47q20ssBJzgFpmeTjLj1/Ow11aNQIAefu8si+cKZZcB2AQEdkZ+3DxFXZANopU4jB3puAYWnHAu/jsUW++lLbgh2wJGaaJ0MhzgfcqCgbRdc7eB9tldIZIAqeGRba0ax6/P/HsHiYPJsLujUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYGkOQNU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYGkOQNU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640DD1F00893;
	Tue,  2 Jun 2026 11:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780398645;
	bh=8EKpiosYXDpdTjF2RO88MV3kQFbGu1pvGiDe6gQVRi0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aYGkOQNUgJQhnWnWp4o4yZufBAZHympKyNY+HN94eqJHgp20DopXfq5sUT1kGUW49
	 GKijQWfG6o2Jr6b4A64ObgLkXopulHyB7lrDSOuHGh54G85k2r6Snq5zZ0Blrd8Pyy
	 sJsTm5d8FpMxkmR+UNWI86a3+7WJdcSH3wC4wpeYiwbA5FYgoMf3N5yH+eZTR/wNCT
	 EhDD9ee18iimrdAxp+iGAO524fkDj1R3GSuif4wXFmLYTBph1i3417w12tMBGHDteL
	 ir2Gji7P/8qHX0JJe3Dj0HOLlx6a1ApqhdGMyPg9sI+Csjrj8SCiGe8ijvLZB2Y4Xq
	 mhp5xi9+C+MQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 18/30] iommu/s390: implement iova_to_phys_length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260602104637.1219810-19-guanghuifeng@linux.alibaba.com>
References: <20260602104637.1219810-19-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 11:10:45 +0000
Message-Id: <20260602111045.640DD1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing Intra-Page Offset in Physical Address Translation
- [High] Null Pointer Dereference in get_rto_from_iova()
--

commit f8957d220cfee6484b5b88e6614c133bcac327ca
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

iommu/s390: implement iova_to_phys_length
   =20
Implement iova_to_phys_length for s390 IOMMU driver,
returning the actual PTE mapping size.

> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index f148f559ac564..b12ed389e1bd9 100644
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
> @@ -986,22 +986,26 @@ static unsigned long *get_rto_from_iova(struct s390=
_domain *domain,
[ ... ]
> -static phys_addr_t s390_iommu_iova_to_phys(struct iommu_domain *domain,
> -					   dma_addr_t iova)
> +static phys_addr_t s390_iommu_iova_to_phys_length(struct iommu_domain *d=
omain,
> +						  dma_addr_t iova,
> +						  size_t *mapped_length)
>  {
[ ... ]
>  	rto =3D get_rto_from_iova(s390_domain, iova);

[Severity: High]
This is a pre-existing issue, but does get_rto_from_iova() safely handle
unmapped IOVAs?

Looking at get_rto_from_iova() in drivers/iommu/s390-iommu.c, it calls
get_rso_from_iova() which can return NULL if the top-level Region First ent=
ry
is invalid. However, the pointer is dereferenced unconditionally:

drivers/iommu/s390-iommu.c:get_rto_from_iova() {
	...
	case ZPCI_TABLE_TYPE_RFX:
	case ZPCI_TABLE_TYPE_RSX:
		rso =3D get_rso_from_iova(domain, iova);
		rsx =3D calc_rsx(iova);
		rse =3D READ_ONCE(rso[rsx]);
	...
}

Would calling iommu_iova_to_phys() on an unmapped IOVA trigger a NULL point=
er
dereference here?

>  	if (!rto)
> -		return 0;
> +		return PHYS_ADDR_MAX;
> =20
>  	rtx =3D calc_rtx(iova);
>  	sx =3D calc_sx(iova);
> @@ -1014,8 +1018,11 @@ static phys_addr_t s390_iommu_iova_to_phys(struct =
iommu_domain *domain,
>  		if (reg_entry_isvalid(ste)) {
>  			pto =3D get_st_pto(ste);
>  			pte =3D READ_ONCE(pto[px]);
> -			if (pt_entry_isvalid(pte))
> +			if (pt_entry_isvalid(pte)) {
>  				phys =3D pte & ZPCI_PTE_ADDR_MASK;

[Severity: High]
This isn't a bug introduced by this patch, but does this physical address
translation truncate the intra-page offset?

The returned physical address is constructed by masking the page table entry
with ZPCI_PTE_ADDR_MASK, but it doesn't incorporate the sub-page offset from
the original IOVA. Since the IOMMU core API iommu_iova_to_phys() expects the
exact physical address corresponding to the byte-level IOVA, could truncati=
ng
the offset cause callers querying unaligned IOVAs to receive incorrect
addresses?

> +				if (mapped_length)
> +					*mapped_length =3D SZ_4K;
> +			}
>  		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602104637.1219=
810-1-guanghuifeng@linux.alibaba.com?part=3D18
