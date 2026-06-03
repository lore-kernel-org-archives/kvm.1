Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026E63D6CDD
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 15:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780501585; cv=none; b=tJMM+iUf8xSW/83nEH5758AGPwwoKFOTyfvx3RZ7lcM+JTZTzn4UNpkksxzdJ48002nat2k+M3/K95oNeQ1u8lc/C1qd9Kj3gNkawYk7lss+pJ7nyA1xeCEGooMOaB6o0c3Vz3TBDUK5srrx6A+5M8FxD+qQLeDBrCBfo7B2BkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780501585; c=relaxed/simple;
	bh=Q5e3dzZ0ea+ebLxzqTDS1+SB4Fg0+RUiHG963NLQWyo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g7ItGkGncfBBMXOg1a8Ls+zSU6lKmEq74ZUzbkxkk7NvjekyMfQW1hKt4tjpooWOqSqFjRqwSSm6+eSkuOmV+ZI4ixQsMGlTzKv/tl9im92RscaXeSwezsymijEBdabEZM3Hazzjz2dsp/bEwTZ3b3T+omK5Kv35dMuiOBdW/rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzIfla0d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzIfla0d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D271F00893;
	Wed,  3 Jun 2026 15:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780501582;
	bh=k3cOKyuaiTUET3xWbz8l2dk5/rBtKdDi29bKDYIlv5o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BzIfla0d4rzA9RsmUPUyJ0j7PpzG8rjLnycJ+XUHPJm5SuGzYOE3aOIDbXQ5UBg5Q
	 dUD3XbI8Zes+XhZoP3SjKf+NLrUm85UK6gF8T7JJxUqeR6vVHM241ppsb9quo+sdyM
	 u49yrGCxk1d+miIKwxxJFHrty0M3GDVYuqSxKG0yRkHXV16ASmRT9OYvoj28qwRPSc
	 NOnB3vboj75kGkSPrqkwU7RDhbeEz9uijV5Rf0LVeau06V4dmLvApR3mVdpYwKEI5d
	 MsR/Bc8ht+AOdaQcG35nQYJhJL/uzp2ObGyAB82hPu8ORDOnb0ZD2bj4arVLWgNBPS
	 2XMvJclyceevA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/32] iommu/exynos: implement iova_to_phys_length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260603151804.1963871-13-guanghuifeng@linux.alibaba.com>
References: <20260603151804.1963871-13-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 15:46:21 +0000
Message-Id: <20260603154622.34D271F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the driver acces=
ses little-endian page table entries using native CPU endianness, leading t=
o corruption and incorrect page table walks on big-endian systems. The func=
tion `exynos_iommu_set_pte()` correctly writes entries as little-endian usi=
ng `cpu_to_le32()`. However, macros like `lv1ent_section` and `lv1ent_page`=
 directly dereference the `sysmmu_pte_t *` pointer (e.g., `*(sent) & 3`), w=
hich evaluates the native 32-bit value. On a big-endian system, this bitwis=
e operation checks the most significant byte of the little-endian value in =
memory, always failing the structure checks. Furthermore, some assignments =
like `domain->pgtable[i] =3D ZERO_LV2LINK;` bypass endian conversion entire=
ly, writing big-endian values that the little-endian hardware will misinter=
pret.
--

commit 097549f5c7fdecb9881aa9c7d6c8964f12985a19
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

iommu/exynos: implement iova_to_phys_length

This commit implements the iova_to_phys_length callback for the Exynos IOMMU
driver. It traverses the page table to return both the physical address and
the actual PTE mapping size for a given IOVA.

> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
[ ... ]
> @@ -1386,13 +1387,20 @@ static phys_addr_t exynos_iommu_iova_to_phys(stru=
ct iommu_domain *iommu_domain,
> =20
>  	if (lv1ent_section(entry)) {
>  		phys =3D section_phys(entry) + section_offs(iova);

[Severity: High]
This is a pre-existing issue, but does exynos_iommu_iova_to_phys_length()
correctly handle endianness on big-endian systems?

The macros like lv1ent_section() and lv1ent_page() directly dereference the
sysmmu_pte_t pointer using native CPU endianness. For example, lv1ent_secti=
on
evaluates to (*(sent) & 3).

Since the hardware uses little-endian page tables, a big-endian CPU
evaluating this bitwise operation will check the most significant byte of
the little-endian value in memory. This will cause the structure checks to
fail, leading to incorrect page table walks and IOMMU translation faults.

While exynos_iommu_set_pte() correctly writes entries using cpu_to_le32(),
the read paths do not seem to do the reverse conversion. Would it be
appropriate to convert the values using le32_to_cpu() when reading these
page table entries to prevent corruption on big-endian architectures?

> +		if (mapped_length)
> +			*mapped_length =3D SECT_SIZE;
>  	} else if (lv1ent_page(entry)) {
>  		entry =3D page_entry(entry, iova);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603151804.1963=
871-1-guanghuifeng@linux.alibaba.com?part=3D12
