Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A52244694
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 01:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792027905; cv=none; b=FAouPBQm5j89tlXcpbyEPxk3a1iQLyld6oi7hjETM8LbKMBB1HYAFUxY/fZF/vKzSQM6W2bNUONBM6Odo1RaEwpbndjrEbEqAvtqqY9XKZ9KTSXnqJeIzTgfTxbWsaZKJjwG5BjKuYWlK6mJyxuwwNu1ysTZJIbgncN9yUtscNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792027905; c=relaxed/simple;
	bh=deRXviqqR809X69HO5tgVHyJCOU8qgz7LT5h9O3zsAs=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=isEzDH4xLFQjojKeUIOttTdhcthAN7b+rVjiWsVgeP4XuOsII7n6yq45ocySr979gdW18v2y2wViGv9AIgJgdZ6xPrpuOx7AuANecq91VPXowc3TQSuuIIgVdwB4HjzQXHIf+I9wSZWnmHNXUGmqOYfY771KaXqtajF7QaFKz00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEO1y4m9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEO1y4m9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9221F000C4;
	Thu, 15 Oct 2026 01:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792027903;
	bh=f82+IJ9v1p6UVlMIAQvi27sTyl5oBk/fxzqnhz0KY+o=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=MEO1y4m98g/a3E+mtzdSjBpfwH2RdIMW9M07CDlvLe+gZCyYqFK3R27g2+NWOV4nZ
	 6JLPafWwJzoxre3eK7lIXHWRsuuhoHy+DsTRaVbD1c1xxXALAxm0Y43AUqsx+68cYx
	 1xJn5gmmudcFtLh6acXyL7YA1aRTFkkitOdHBR9JCL2JH5/J+7Ciz9iKCXbRS/rALX
	 J961in7Ae0tEEt9UVcBuHPEH574UKDI+vHhdTy659cmiT4FvIRENWGeAxpdB14Gl28
	 A7g+62jZB4blh/UMRPjmW5faEgbL72Ocp1sOmPnnOfb7oLgSCu170OKNjgzAGtTIjP
	 x11UfZW5aNPxQ==
Message-ID: <sashiko-outbox-172095@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] coco/tdx-host: Initialize trusted DMA on all
 capable IOMMUs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lu Baolu" <baolu.lu@linux.intel.com>, kvm@vger.kernel.org
In-Reply-To: <20261015010705.1973284-5-baolu.lu@linux.intel.com>
References: <20261015010705.1973284-1-baolu.lu@linux.intel.com>
 <20261015010705.1973284-5-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 01:31:43 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] virt/coco/tdx-host: desynchronized host/hardware state on xa_inser=
t failure
--

commit 83cda44603ec97cb10640905999d9a617eced100
Author: Lu Baolu <baolu.lu@linux.intel.com>

coco/tdx-host: Initialize trusted DMA on all capable IOMMUs

Assigning a device to a TD for private memory access requires that DMA
from that device be translated by structures the TDX module controls.
An Intel IOMMU that implements the trusted DMA extension provides a
parallel set of translation and invalidation resources for this purpose.

> diff --git a/drivers/virt/coco/tdx-host/iommu.c b/drivers/virt/coco/tdx-h=
ost/iommu.c
> new file mode 100644
> index 0000000000000..a80e57bf26a12
> --- /dev/null
> +++ b/drivers/virt/coco/tdx-host/iommu.c
[ ... ]
> +static int tdx_iommu_setup(struct dmar_drhd_unit *drhd)
> +{
[ ... ]
> +	state =3D no_free_ptr(iommu_state);
> +	state->drhd =3D drhd;
> +	state->tdx_iommu_id =3D tdx_iommu_id;
> +	state->mt_pages =3D no_free_ptr(iommu_mt);
> +	ret =3D xa_insert(&tdx_iommu_xa, (unsigned long)tdx_iommu_id, state, GF=
P_KERNEL);
> +	if (ret) {
> +		WARN_ON(tdx_iommu_clear(state));
> +		kfree(state);
> +		return ret;
> +	}

[Severity: High]
If xa_insert() fails and tdx_iommu_clear(state) also fails, this code
unconditionally frees state and returns an error. Does this leave the
hardware state desynchronized?

When this function returns an error, the caller dmar_tdxcs_iommu_init_all()=
 in
drivers/iommu/intel/dmar.c restores iommu->max_domain_id to its full un-hal=
ved
range and leaves drhd->tdx_mode =3D false:

	ret =3D setup(drhd);
	...
	if (ret) {
		scoped_guard(mutex, &iommu->did_lock)
			iommu->max_domain_id =3D ndoms;
		...
		return ret;
	}

Because tdx_iommu_clear() failed, the physical hardware is permanently left=
 in
Secure TDX Mode, but the software state now believes it is not. Will this
cause hardware faults or fatal domain ID conflicts when the host attempts to
use domain IDs that now belong exclusively to TDX?

Unlike tdx_iommu_disable_all() which safely detects a clear failure and lea=
ves
tdx_mode true to confine the host to the lower half of the DID space, this
error path completely loses track of the hardware state, breaking isolation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015010705.1973=
284-1-baolu.lu@linux.intel.com?part=3D4
