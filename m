Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4873793C6
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 21:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781214841; cv=none; b=qZUZVZs3EN6HhGhG67AosS1lMFjTw+OtG4il2VbVQHPLk17GrLi7eiOlyiESK+Q7HAn/vRhToaJW+qmGXHKLWqfjtbFV22EaKqjGQFn7AXQDgolLJxq+HULCPlqenQ3cSfe0gEX3JV6SkWrYhaf/hQ8gS7OGl0v2Wo56ANnfy4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781214841; c=relaxed/simple;
	bh=BC9UXaD8yqXZbHonHfZB/VZgpuuF3bNPxBzUkTBGNA8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YTIvRZTBzRN+nJEuGuqotO1I9toI0WwbXe/ZjPoUsgDwjqyOE/59UPGpr/OpwfJdj2ueDhSMHon9ikwAzPxmnKQDYY7mKz+xXeokspLcXgxS6vXl9Jx+tKBIAJKtGMP6mr8YX18Bqyd9qqp6Wbe6Ru7KPc9EnpKMPzBIus92sl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAb6MzGj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAb6MzGj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147CE1F00A3A;
	Thu, 11 Jun 2026 21:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781214840;
	bh=frnU4v0PZK9mBtoDKGF3FjF1ZGsXh/3bZSeqGuzL2VA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cAb6MzGjhC6hQAzShd8A0OUk/luXKCelv/RBiPtTXNvQTJLXQ1ZODZDd6BkDxHBMj
	 tGRWVdglWPfv0juh+Wdg6DFBA4Gc0bL9DKoapU71j9r7+yHdrwEcTxRbgalENkid0V
	 YscJ6pgI1Wz1KtJsg+be+5xppVFaK5qC/X5iHUSlLRQwu+fjPaGU9GaZHa3TEqHW5L
	 GCb1vdUAwnzsatJ/4EN8WE327UXihupfxFZ3bUoliGhwY2viep1qcIwfQkkUd5lv+Y
	 mZ2jvx0lXqLbjB0dz5OhUU3oA7gKvxvjF9VG1anUtOeLuxMkybhGFvsVcKPxpqDxpL
	 BpYrNbierX6rA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] vfio/pci: Release the VGA arbiter client on
 register_device() failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Williamson" <alex.williamson@nvidia.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260611213539.4100590-3-alex.williamson@nvidia.com>
References: <20260611213539.4100590-3-alex.williamson@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 21:53:59 +0000
Message-Id: <20260611215400.147CE1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Low] Unconditional assignment of PM callbacks pointer without pm_ptr() w=
rapper.
--

commit 009bb147bb78eda6b9cfb1c508c98573c30df2f1
Author: Alex Williamson <alex.williamson@nvidia.com>

vfio/pci: Release the VGA arbiter client on register_device() failure

This commit adds the required VGA unwind callout to the failure path
of vfio_pci_core_register_device. A previous re-order displaced the VGA
initialization without introducing an unwind.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index 9f71eae0cc947..d2d3fddec6107 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -2254,6 +2254,7 @@ int vfio_pci_core_register_device(struct vfio_pci_c=
ore_device *vdev)
>  		pm_runtime_get_noresume(dev);
> =20
>  	pm_runtime_forbid(dev);

[Severity: Low]
This is a pre-existing issue, but I noticed an unconditional assignment of
the PM callback pointer earlier in vfio_pci_core_register_device() in
drivers/vfio/pci/vfio_pci_core.c:

dev->driver->pm =3D &vfio_pci_core_pm_ops;

Does this code need to use the pm_ptr() wrapper? When CONFIG_PM is disabled,
assigning the callbacks unconditionally can produce dead code because the
functions get linked into the kernel even though they can never execute.

> +	vfio_pci_vga_uninit(vdev);
>  out_vf:
>  	vfio_pci_vf_uninit(vdev);
>  	return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611213539.4100=
590-1-alex.williamson@nvidia.com?part=3D2
