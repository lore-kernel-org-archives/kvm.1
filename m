Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA593DB32C
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 11:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780399013; cv=none; b=HpQH/xfsN3uUYP1NSy6R65hsHmtrb9Oqsn8ZRfmbRO55GbJ3oogoMopOInlN5aqHEptZOMMeRYujU7LACMfr1XDK9+eO7kgHWU+yey5jaRa6B7741jsy02wemUXhMlIeqRGAMZ6elPLCzUkic2E168RMHv67kVC87NdqmBIXAmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780399013; c=relaxed/simple;
	bh=35wu14+RjKSwlGcddfNXpgmWNh1Z1dRbqLMJ/qMt67c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i14OsXAWTK5uvd1Bqejuxmqolc6Anv4oCou0xj76wwRbPL06LgwNDyesQOee5U3AD87q8r0Eq190rw1l2JmpdwcJFHT9tfExSmvqmzAWF3ZpZCFhTWQauT1oPjH6a4t63qxd7xxv1ZjlVn+U/QfDWpb5sqxExIXG2FZ9eKjMrY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2jXyTV7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2jXyTV7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853781F00898;
	Tue,  2 Jun 2026 11:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780399004;
	bh=yj/G0z+qQ0uoZUSdy8GUtdnbTp8VHApkQWXoZQvbkfo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D2jXyTV7DKXSSnOpvWCmIYirCP5y7bJjs38Xyq+n68iHkk6sUXEs671bwO2cT6nOY
	 UB99tp8Sqx3/WV/YF7ZiQcKzwwrOWRSm50WmtpsHiCBXqpQXJ0W0tsIaCKeYYLBnk5
	 GtsoT7+A2yzehyaF0UdNQ1f/Pqg5pZ8cT1y2nvcTMBbaeDNnMTur8Zw4zefNmmzKs5
	 wQ5XTn4SfoATw7eaMuIQdPFg/BCmvZM04+la6bezpStYRY+M/Mfhg0+kmVjcjmyiWC
	 u1rk2rAnsi2520IpuJLsinaEklMxtqNrtnt3fsrWupWsTM53mxQqc2hinQqRBuN847
	 l0oR7146HHngw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 30/30] iommu: remove iova_to_phys from domain_ops and
 io_pgtable_ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260602104637.1219810-31-guanghuifeng@linux.alibaba.com>
References: <20260602104637.1219810-31-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 11:16:43 +0000
Message-Id: <20260602111644.853781F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The kerneldoc for `iommu_iova_to_phys_length()` is incorrectly u=
pdated to state it returns `0` on failure, contradicting its implementation=
 and API contract.
- [Low] The commit breaks compilation of `drivers/iommu/vsi-iommu.c` becaus=
e it removes the `.iova_to_phys` field from `struct iommu_domain_ops` but l=
eaves its initialization in `vsi_iommu_ops`.
--

commit e371c2338468e326f04a98ffb8dd1fb18a2872a0
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>
iommu: remove iova_to_phys from domain_ops and io_pgtable_ops

This commit removes the deprecated iova_to_phys interfaces from both
iommu_domain_ops and io_pgtable_ops now that callers are expected to have
migrated to iova_to_phys_length. It drops the fallback path in
iommu_iova_to_phys_length() and updates its kerneldoc.

> Now that all drivers implement iova_to_phys_length and all callers
> have migrated, remove the deprecated interfaces:

[Severity: Low]
Does drivers/iommu/vsi-iommu.c still need to be migrated? It appears to sti=
ll
initialize the removed .iova_to_phys field in vsi_iommu_ops, which would ca=
use
a compilation error:

drivers/iommu/vsi-iommu.c:
static const struct iommu_domain_ops vsi_iommu_ops =3D {
	...
	.iova_to_phys		=3D vsi_iommu_iova_to_phys,
};

> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 1b1aaa53dd16a..84893d4c7c607 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2554,7 +2554,7 @@ EXPORT_SYMBOL_GPL(iommu_detach_group);
>   * Like iommu_iova_to_phys() but additionally returns the page size of t=
he
>   * PTE mapping at @iova through @mapped_length.
>   *
> - * Return: The physical address for the given IOVA, or PHYS_ADDR_MAX if =
no translation.
> + * Return: The physical address for the given IOVA, or 0 if no translati=
on.

[Severity: Medium]
Is this documentation update accurate?

The implementation of iommu_iova_to_phys_length() still returns
PHYS_ADDR_MAX when the domain ops lack the iova_to_phys_length callback:

	if (!domain->ops->iova_to_phys_length)
		return PHYS_ADDR_MAX;

Could misdocumenting this cause future driver authors to return 0 on
failure instead of PHYS_ADDR_MAX, potentially bypassing safety checks and
treating physical address 0 as a valid mapping?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602104637.1219=
810-1-guanghuifeng@linux.alibaba.com?part=3D30
