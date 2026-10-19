Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE57C4D7974
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 10:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792406146; cv=none; b=K/1NRkxwiVGvvBAq+hzddKtTppUf8rGaRzA6SoHt3fDbVGcn8oSNBKeqSuykqABhw6PwTLXSzg1c9GvxS2ZgnLuYsWR3tL33OMNiTgaMchlptDyWtDQHycBUEFkG3CYcAwsFms0KLIP82ey19ODw13XevCGey3tfXxkAkmgsGvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792406146; c=relaxed/simple;
	bh=vbiSRamytWLO1U5NTquFeMm8lWhPmezop6+BPen9+rA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=itLxBpoMo4HJIMVLiXr9oI6yslSQry84R80wkZ65o98AeJqUE1sC/6zR1hgCZQ45B1ONUGKW9ZzbmJi+k7Dwvg1WoW9jtd+xSWyak86S6P54AcetfTJ/1RyIlnmvvs8hmIHzClX9YFoEpBlwdg0Ob5kSCkI9ptQAhveRKYeWwhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXpG5ckH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXpG5ckH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60AD31F000C4;
	Mon, 19 Oct 2026 10:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792406144;
	bh=fHSwpgaf+ds8OzWnj9BRRLxEY4f8tWO8etbpCdXileA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NXpG5ckHnmLt8eGbpQueQ2zRzROjD/grcXJRQrUyOUIBGvAiOZnaL5QEk7UxiYItb
	 gOHlceefit/6CuDd0oKhKlIdgTp9T0wmnjsNMsRLHrQ9cLd7Q8Cj7TlgULuWKKJMMi
	 rQFLVVmKLAXRNfk7HNUMw+pbb96Q6FRn+R01Es5a6UCrlV+ayV1aIvZjGDJf0qWLOv
	 dxJy22klbEUmaMa8gDAnya5PV6f7oGNPEcKB63ZlzeQMSBb1HjhYhxiUuNSwOrJJuH
	 s1pjivRRBPcGy44YOxIcdmuDCHMpHxmfftsSRG4Fve4IxInGVLXUulropVlGxYuY/k
	 DReEBCqsFQEcA==
Message-ID: <sashiko-outbox-176999@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/5] vfio/spapr_tce: Normalize EEH IOA error
 injection addresses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Narayana Murty N" <nnmlinux@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261019101813.45085-5-nnmlinux@linux.ibm.com>
References: <20261019101813.45085-1-nnmlinux@linux.ibm.com>
 <20261019101813.45085-5-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 10:35:43 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] vfio/spapr_tce: vfio_spapr_ioctl_eeh_pe_op() breaks non-BAR erro=
r injection
- [Medium] vfio/spapr_tce: vfio_spapr_eeh_normalize_addr() matches unset PC=
I BARs
--

commit 02ecc4e02395ee3674eee2a40d451772c566a3ad
Author: Narayana Murty N <nnmlinux@linux.ibm.com>

vfio/spapr_tce: Normalize EEH IOA error injection addresses

This patch normalizes IOA/MMIO error-injection addresses in the sPAPR
VFIO EEH ioctl path before dispatching to eeh_pe_inject_err(), translating
host Linux BAR resource addresses to PCI bus addresses.

> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index 1c0eec228cc6f..dad9ba54bae60 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -774,6 +774,97 @@ static long tce_iommu_create_default_window(struct t=
ce_container *container)
>  	return ret;
>  }
> =20
> +static int vfio_spapr_eeh_normalize_addr(struct eeh_pe *pe,
> +					 unsigned long addr,
> +					 unsigned long mask,
> +					 unsigned long *normalized)
> +{

[ ... ]

> +	pci_lock_rescan_remove();
> +	eeh_pe_for_each_dev(pe, edev, tmp) {
> +		pdev =3D eeh_dev_to_pci_dev(edev);
> +		if (!pdev)
> +			continue;
> +
> +		for (bar =3D 0; bar < PCI_STD_NUM_BARS; bar++) {
> +			res =3D &pdev->resource[bar];
> +
> +			if (!resource_size(res))
> +				continue;
> +
> +			if (!(res->flags & (IORESOURCE_MEM | IORESOURCE_IO)))
> +				continue;
> +
> +			pcibios_resource_to_bus(pdev->bus, &region, res);

[Severity: Medium]
Can vfio_spapr_eeh_normalize_addr() match unassigned or disabled BARs here?

On PowerPC, unassigned BARs in pcibios_fixup_resources() and
alloc_resource() in arch/powerpc/kernel/pci-common.c have res->start =3D 0,
res->end =3D size - 1, and IORESOURCE_UNSET set alongside IORESOURCE_MEM or
IORESOURCE_IO:

arch/powerpc/kernel/pci-common.c:pcibios_fixup_resources() {
    ...
			res->end -=3D res->start;
			res->start =3D 0;
			res->flags |=3D IORESOURCE_UNSET;
    ...
}

Because resource_size(res) is non-zero and IORESOURCE_UNSET is not checked,
vfio_spapr_eeh_normalize_addr() passes res to pcibios_resource_to_bus().
In drivers/pci/host-bridge.c, pcibios_resource_to_bus() calls
resource_contains(window->res, res), which returns false when
IORESOURCE_UNSET is set, leaving offset =3D 0 and setting region.start =3D
res->start.

When a device in the PE has an unassigned standard BAR, wouldn't any
supplied addr in [0, size) match Case 1 on the unassigned BAR, or if an
unassigned BAR retained res->start =3D window->offset from
of_pci_parse_addrs(), cause a valid CPU resource address of a later BAR at
the start of the PHB window to match Case 1 on the unset BAR and skip
translation?

For comparison, eeh_break_device() in arch/powerpc/kernel/eeh.c skips
such resources before matching BARs. Should this loop also skip BARs
where !res->start or res->flags & (IORESOURCE_UNSET | IORESOURCE_DISABLED)?

> +
> +			pci_start =3D region.start;
> +			pci_len =3D resource_size(res);

[ ... ]

> +done:
> +	pci_unlock_rescan_remove();
> +
> +	if (rc)
> +		pr_debug("vfio EEH: addr=3D0x%lx not found in any PCI bus BAR of PE, i=
njection may fail\n",
> +			 addr);
> +	return rc;
> +}
> +
>  static long vfio_spapr_ioctl_eeh_pe_op(struct iommu_group *group,
>  				       unsigned long arg)
>  {
> @@ -818,6 +909,20 @@ static long vfio_spapr_ioctl_eeh_pe_op(struct iommu_=
group *group,
>  		if (copy_from_user(&op, (void __user *)arg, minsz))
>  			return -EFAULT;
> =20
> +		if (op.err.type =3D=3D EEH_ERR_TYPE_32 ||
> +		    op.err.type =3D=3D EEH_ERR_TYPE_64) {
> +			unsigned long normalized;
> +			int ret;
> +
> +			ret =3D vfio_spapr_eeh_normalize_addr(pe, op.err.addr,
> +							    op.err.mask,
> +							    &normalized);
> +			if (ret)
> +				return ret;
> +
> +			op.err.addr =3D normalized;
> +		}
> +
>  		return eeh_pe_inject_err(pe, op.err.type, op.err.func,
>  					 op.err.addr, op.err.mask);
>  	default:

[Severity: Medium]
Does calling vfio_spapr_eeh_normalize_addr() for all EEH_ERR_TYPE_32 and
EEH_ERR_TYPE_64 requests break non-BAR error injections such as DMA and
PCI config-space errors?

In arch/powerpc/include/uapi/asm/eeh.h, EEH_ERR_TYPE_32 and EEH_ERR_TYPE_64
are the only two error types and are used across all op.err.func values
(EEH_ERR_FUNC_MIN through EEH_ERR_FUNC_MAX), including PCI config-space
error functions (EEH_ERR_FUNC_LD_CFG_ADDR, EEH_ERR_FUNC_LD_CFG_DATA,
EEH_ERR_FUNC_ST_CFG_ADDR, EEH_ERR_FUNC_ST_CFG_DATA) and DMA error functions
(EEH_ERR_FUNC_DMA_RD_* and EEH_ERR_FUNC_DMA_WR_*).

When userspace invokes VFIO_EEH_PE_INJECT_ERR for a DMA or config-space
error function with a non-zero op.err.addr (such as an IOVA in the TCE
window or a config offset) or a non-zero op.err.mask,
vfio_spapr_eeh_normalize_addr() searches standard MEM/IO BARs, fails to
find a match, and returns -EINVAL, causing vfio_spapr_ioctl_eeh_pe_op() to
abort before calling eeh_pe_inject_err() (or corrupts op.err.addr if the
DMA address happens to fall within a host BAR range).

Also, notice that the pr_debug() in vfio_spapr_eeh_normalize_addr() says
"injection may fail", whereas vfio_spapr_ioctl_eeh_pe_op() immediately
returns ret (-EINVAL) without attempting injection. Should BAR address
normalization be restricted to MMIO/PIO op.err.func values, or pass the
address through when it is not a BAR-targeted function?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019101813.4508=
5-1-nnmlinux@linux.ibm.com?part=3D4
