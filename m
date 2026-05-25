Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A3E349CF3
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 21:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779745501; cv=none; b=loUf8S5RJtNGTGCYni0bZ52BSDPG9MDdZ3SNGr1Ci/aITEZRdoVTUp0BRathxMgNlSQeQEy2WOYZ4n56sFDqkr7XMFZ1N9GmpvMbBQqBqu3B23PeGzDvu4WbtXiNxMxj9WUClXdyD0Qxl1A5dTSrEnbH7Mr518I95digGQrj6n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779745501; c=relaxed/simple;
	bh=CR+2PoPmKSqpLItOf6KMgQn3Ik4D/0Ihwd0pNXURAxs=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jfD3I0d4hZcGgkThhwUuz2fuWHkoHvqD07RkQI2u82KV0c1K4bnH8/mCKaMTCT7WgSflqxgDVRY6iDj/v7fF77MZxb/VjuXtdl5NbpWDev6LmnaNmwXgmipvf0edq71elUK12332eo1y2HqcIDXMCsocgOoQ39mE9FEUXptSQwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GtALb0DU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GtALb0DU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5871F000E9
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 21:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779745500;
	bh=73eP7HNDW980rEbv8f2KQie08e/otOVeZhMu0+lU+Ic=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=GtALb0DUAT9DpQhy0Glpy4UF7dtb70x5F7nYIz4msggksPFiQ4wDI2wvWMOZnm2ig
	 7isrO8FaqhmdHGUWwT+n6g7zE3iw+ivHNBcanm73R22XbHPUd7Gf5EkMsvR6eCFSSf
	 KyIrCZKG5V7aYzmBKsgrMz8v57LPC91GL2ChpwxKTPORU0J6IFAtJt/9OYtcHX40ua
	 gM74hVlsdQ3jFlAaHNAzlEL3az/X7/I9K/6iCCLvjvmZ9MK83a6/5Ufnpx/dhvqPkU
	 okU1l60gg1gEqFpqgaMxag+yoO1xB1x96N6s7B4/ehXySVl/tcx8sN7dlnZE8NaMp4
	 L+oCxDlOX6LwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/5] iommufd/tsm: add vdevice TSM bind/unbind ioctl
Reply-To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
In-Reply-To: <20260525154816.1029642-5-aneesh.kumar@kernel.org>
References: <20260525154816.1029642-5-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 21:44:59 +0000
Message-Id: <20260525214500.8A5871F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Silent truncation of `virt_id` from 64-bit to 32-bit when callin=
g `pci_tsm_bind`.
--

commit b7dc3508d5fe2b83fd395c4d50b0951a9d3d243b
Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

iommufd/tsm: add vdevice TSM bind/unbind ioctl

Introduce IOMMU_VDEVICE_TSM_OP to allow userspace to issue TSM bind/unbind
operations for an iommufd vdevice. Also add common TSM helpers in tsm-core
and wire vdevice teardown to unbind the device from TSM state.

> diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
> index e784993353d8f..3870d08ffe0d1 100644
> --- a/drivers/virt/coco/tsm-core.c
> +++ b/drivers/virt/coco/tsm-core.c
[ ... ]
> @@ -108,6 +108,25 @@ void tsm_unregister(struct tsm_dev *tsm_dev)
>  }
>  EXPORT_SYMBOL_GPL(tsm_unregister);
> =20
> +int tsm_bind(struct device *dev, struct kvm *kvm, u64 tdi_id)
> +{
> +	if (!dev_is_pci(dev))
> +		return -EINVAL;
> +
> +	return pci_tsm_bind(to_pci_dev(dev), kvm, tdi_id);

[Severity: Medium]
Does this cause a silent truncation of the virtual ID?

While tsm_bind accepts a u64 tdi_id, it passes this argument directly to
pci_tsm_bind, which expects a u32 tdi_id.

Because iommufd_vdevice_alloc_ioctl allows userspace to supply a 64-bit
virt_id, passing a value larger than 32 bits here will result in a truncate=
d,
incorrect virtual device ID being registered with the TSM layer.

Could this lead to state inconsistency between iommufd and the TSM subsyste=
m?

> +}
> +EXPORT_SYMBOL_GPL(tsm_bind);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525154816.1029=
642-1-aneesh.kumar@kernel.org?part=3D4
