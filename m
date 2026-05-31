Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE3C3264D8
	for <kvm@vger.kernel.org>; Sun, 31 May 2026 11:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780226248; cv=none; b=Lht6KVpA4yBiNhpvB6pNDUzL6BwE46zfaU0U9N0EHfYdRkEWOe5bED3xyLuBy/uUSC+eczHrmDyiv1TInHbvOM6K+b/amnwiHBfjQruei+ejcl6e45AvSNnHYktOfGle8PHsvDeGg26R8CE4RCGXiFgLV1jgh0yO5Vmi0/Uqmm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780226248; c=relaxed/simple;
	bh=M27N3J0Tb6hQCKcapWpsYijhH69uFvaXUxP8Fu6/uTg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e6Z1ugUg3487pp5/o4ZCoJqU0ghG4PDx5mEDrg6lYIhKX4nRMMR0PcbH9C6GE7SnF+UslXf8QIua8s8Q+32lyIDQiYW0oQL5FbZvchU7GzupyJxWE5dCPeXNjoSA7XxC78PiPZbE/UobPkL1dRLoms6kWzlwjSsqBsqdDARerNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVa6AjQR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVa6AjQR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CAA61F00898;
	Sun, 31 May 2026 11:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780226246;
	bh=vz8wX/FJNIRW4UIBuz+oi5kjUoFlq3alDaDBHExL1ho=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bVa6AjQR8NeXl8f38/Ina5ruLhS2mSd+cQy8m4vFDauLj5q+oTJJZFIZC2KdREPjb
	 Rv9b6H8SZt88fRng/iIx3wtt/eEGxJ/i9XJO+plsALxxIy7mv3KON3OhfhU/vMYKJF
	 e4dBjYrpTp8Lgjz+DmbiS3ZNxP4g2GzSrkoVSPs20m/NnS5ltuplWfkiqhdhyg+ftP
	 /3f9sqV6re3OcHLzUotvSu3sCGSIfeRi6ntKe9A5qp3CqLiDgVLx6cUquT77085I/P
	 WE/+18Qj15HGfgD10eF0IOqVV60Y+Qad8ETZvsjKbZJEfzMJ4ZyF0VBFOqdP4PJKYT
	 gAamjuN6lHq/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 9/9] iommu: remove deprecated iova_to_phys from
 domain_ops and io_pgtable_ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260531093637.3893199-10-guanghuifeng@linux.alibaba.com>
References: <20260531093637.3893199-10-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 11:17:26 +0000
Message-Id: <20260531111726.7CAA61F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Unmigrated driver vsi-iommu.c causes a compilation error because `=
.iova_to_phys` was removed from `struct iommu_domain_ops`.

Pre-existing issues:
- [High] The hardirq handler `vsi_iommu_irq` calls `pm_runtime_resume_and_g=
et()`, which sleeps waiting for the device to resume, causing a kernel pani=
c.
--

commit 6b44c3a91e8a25d542a9e22178e54c5a5807b633
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

iommu: remove deprecated iova_to_phys from domain_ops and io_pgtable_ops

This commit removes the deprecated iova_to_phys interface from both
struct iommu_domain_ops and struct io_pgtable_ops. It cleans up the fallback
logic in iommu_iova_to_phys_length() and removes wrapper functions across
various io-pgtable implementations.

[ ... ]

> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 29c7c042d400d..e95b7491b5aac 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -805,8 +804,6 @@ struct iommu_domain_ops {
>  	int (*cache_invalidate_user)(struct iommu_domain *domain,
>  				     struct iommu_user_data_array *array);
> =20
> -	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain,
> -				    dma_addr_t iova);

[Severity: High]
The commit message states that all drivers implement iova_to_phys_length and
have migrated, but was drivers/iommu/vsi-iommu.c missed?

It looks like this driver still initializes this member:

drivers/iommu/vsi-iommu.c:vsi_iommu_ops {
    .iova_to_phys =3D vsi_iommu_iova_to_phys,
}

Will removing this member cause a build failure for that driver?


[Severity: High]
This is a pre-existing issue, but while looking at drivers/iommu/vsi-iommu.=
c,
can the hardirq handler sleep?

The interrupt is registered as a shared hardirq:

drivers/iommu/vsi-iommu.c:vsi_iommu_probe() {
    ...
    err =3D devm_request_irq(iommu->dev, iommu->irq, vsi_iommu_irq,
                           IRQF_SHARED, dev_name(dev), iommu);
    ...
}

But the handler calls a sleeping function:

drivers/iommu/vsi-iommu.c:vsi_iommu_irq() {
    ...
    if (pm_runtime_resume_and_get(iommu->dev) < 0)
        return IRQ_NONE;
    ...
}

Since pm_runtime_resume_and_get() can block waiting for the device to
resume, will this trigger a system panic or might_sleep() warning when
another device sharing the IRQ line fires?

>  	phys_addr_t (*iova_to_phys_length)(struct iommu_domain *domain,
>  					    dma_addr_t iova,
>  					    size_t *mapped_length);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531093637.3893=
199-1-guanghuifeng@linux.alibaba.com?part=3D9
