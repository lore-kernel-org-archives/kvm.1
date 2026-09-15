Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E143F076E
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 08:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789459912; cv=none; b=V1t+D5sV8i9k+EJMg06pGxk8hF7+LHUDshWxUOIafYJiSjkVChYaPyjlhFM1h/52sBOw9VDKiM5Dre9WX1rQMbH7bI/DNov8LamQhKxrrSubm2TB/ca9FCxqOwDBgUf56ZErniYcgsQfd2g3zuPjHGZFdAmzoSpCkMw84S0fnbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789459912; c=relaxed/simple;
	bh=iJeA69Q2i7jeJN6qH768nCY8UPgUK/44RUo1MhIyzEk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iFJFd4iRUUfenGm+GNcyOIlOTa9ZlGFX0B+oZbd4NWfhSoUNd/5WsQiX+UcPtaX7yk60nT5oGTd/x6gIaRHSO6QDgxBs7/PS3cnwe2qIBNF0RC4q86N97N43E0K/zaOS8pK48oQaiLXi9A13wP7gAVyn9dJqZoi/GpaqlLX4rpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIuJTuvf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIuJTuvf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79E21F000FF;
	Tue, 15 Sep 2026 08:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789459911;
	bh=yw359TXjl+9Q13O7++UzJVdD30s8ML5tRIWu9KsEoYo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oIuJTuvfvMHvrI5Wvm+CmTA+yaiwzzU0XwdLy2CvsDtCUBoxoHX7Ti3eDPYT/XTw8
	 OABDQKUDH1QCY9agCAKrA0GmZsDgD09p4g2SpR2mia4gpnbxXRTWB3RmRQ+yUS3x12
	 UPGOiVecfRyhr2gEDW+NNF8pVkxEfD3XB88j8fcMXzXDFjCFKTMaWJ3Fy4HQlteJ1L
	 KOnyiV63NfK6msUuy3127DhvgvZunupA5zbSYdVL/0blKFQ+Sr4iqNOrM6ptHKIoEd
	 LF2cIUV3US4B/pRCtE2DDbu7dkGvzr8Y0oVLazW4wO08b4j9VzDazIKKmIwsQT0kkO
	 wlxfhrP17BSDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] iommu/vt-d: Reserve MSB of domain ID space for TDX
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lu Baolu" <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260915074235.1219183-6-baolu.lu@linux.intel.com>
References: <20260915074235.1219183-1-baolu.lu@linux.intel.com>
 <20260915074235.1219183-6-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 08:11:50 +0000
Message-Id: <20260915081150.D79E21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] iommu: missing TDX teardown and mt_pages leak on IOMMU hot-remove
--

commit 8a16aba70396ddc74c834953ff8123fae8be9bad
Author: Lu Baolu <baolu.lu@linux.intel.com>

iommu/vt-d: Reserve MSB of domain ID space for TDX module

When an Intel IOMMU is enabled for TDX Connect, the VT-d DID namespace
must be split so the TDX module can use the MSB-tagged half for trusted
DMA translations, while the host/VMM uses the lower half.

> diff --git a/drivers/iommu/intel/tdxc.c b/drivers/iommu/intel/tdxc.c
> index b5dfdeeb23dba..1ca03257d4563 100644
> --- a/drivers/iommu/intel/tdxc.c
> +++ b/drivers/iommu/intel/tdxc.c
[ ... ]
> @@ -154,17 +159,27 @@ static int intel_iommu_bringup_tdxc(struct intel_io=
mmu *iommu, unsigned int nr_p
>  		return -EFAULT;
>  	}
> =20
> +	/*
> +	 * Intel TDX Connect Architecture Specification, Section 2.2 Trusted DMA
> +	 *
> +	 * When IOMMU is enabled to support TDX Connect, the IOMMU restricts
> +	 * the VMM=E2=80=99s DID setting, reserving the MSB bit for the TDX mod=
ule. The
> +	 * TDX module always sets this reserved bit on the trusted DMA table.
> +	 */
> +	iommu->max_domain_id =3D ndoms >> 1;
>  	iommu->tdx_iommu_id =3D tdx_iommu_id;
>  	iommu->mt_pages =3D no_free_ptr(iommu_mt);
> =20
> -	/* Bring-up is not complete yet; report as unsupported for now. */
> -	return -EOPNOTSUPP;
> +	pr_info("%s: trusted DMA for TEE/IO initialized\n", iommu->name);
> +
> +	return 0;

[Severity: High]
With TDX bring-up now successfully completing here, if this IOMMU is later
hot-removed, does this leak the TDX metadata pages (iommu->mt_pages) and le=
ave
dangling hardware state in the SEAM firmware?

When ACPI hotplug invokes dmar_iommu_hotplug() with insert=3Dfalse, the IOM=
MU
is destroyed via:

drivers/iommu/intel/iommu.c:dmar_iommu_hotplug() {
    ...
		disable_dmar_iommu(iommu);
		free_dmar_iommu(iommu);
    ...
}

Because this hot-remove path never calls intel_iommu_teardown_tdxc(), it
appears iommu->mt_pages is leaked and tdh_iommu_clear() is never called bef=
ore
the IOMMU structure itself is freed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915074235.1219=
183-1-baolu.lu@linux.intel.com?part=3D5
