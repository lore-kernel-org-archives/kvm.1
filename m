Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793894162;
	b=zNP6nVN50abaUnLl2mcc1rwwYVWPiDuJ8w3Y55u+0VRQmFAzMT8mHOHv9I6KqTiStJay
	 tfV7ksPFMUIeP99Axy1gxo5qAG+rX4hY0g6OJh51TRidfOM42i0v5v2BFqQOe+OJDu78+
	 Du6AzcNmA7tu6YsICBNtQZGXlY4R9G22PFA5aybHXau9TCnPiZlwlp88D61MRQkGrQs4v
	 HwC1WkBrdaT3HqIsCDGuUZdLRGTmGkZ0psU2Asr1NRpfDGrwvvhnVYu8U2QN9b7JoYwpe
	 yYFPGRuX6cOoUh1NHdI6g0/Pb223oQPU174V3w17jyODM+tGVlViuxDbL+EYQKPb+AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894162;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+w/qXuZYlkYWda1Xs168VpdBCh2Dw2DrXwv9zMQs/hE=;
	b=WZaVf2Fqe/1/GQszgWLA4Md3E0vTgjNOATaH5SNmumiU8+nza+ctSQ23nYxxBliZYMaU
	 ypc8OYQwM+KJh5EbgtleS9lpzzwxD4Rh+IE0NAEBemL1qQJ7sanwtsAkECWjGysevpMbJ
	 7HvXvPq9lSQEYKy0eJsJs4xqkfMclvrs6S/L7yhrcy5X6dPdBJ0Dg1462y82twLbu+cV6
	 UpQswo6a5ceQne1vg27aEXhcU/ScEYiedbjhge73cJWppzCGoeF8w4QcfHyfsdky0HefX
	 OhCecBzrXuenZHSZdkHSM3bjJ0jzXtPQigA0nUkKTYL6yvt5tm4OaBTABZNyUDaNzmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=pass header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=Tp7vFy+m;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=lWtYIO5u;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E83606CF8A
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 15:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12E83606CF8A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=Tp7vFy+m;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=lWtYIO5u
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 421EC1400044
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 10:56:01 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 05 Nov 2026 10:56:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793894161;
	 x=1793980561; bh=+w/qXuZYlkYWda1Xs168VpdBCh2Dw2DrXwv9zMQs/hE=; b=
	Tp7vFy+ml/J+qoAsN9LR30B9FH0eTmcjDBsCzs7Gtz7KXXOIayDZ3Mw8x7+C4Lqj
	SxxWmB8uDfQAyCh6IdiyBtFU6hMcFqshBxBgzJdgGGO58D2XIfbdiVWzVJ0mnJvB
	9nkBfSHntLRYWfVi4GS6UNzKijwBGO0fVeSVIgTy/ewxQ8pi4Ri8m2/HySpNX6Ur
	Go15IvpdpOtkxOjSbDhaV9SHK/K3pj/TqSnaYZo+dGuz9DUiYpZLdWIzn8JiLNUy
	VTdzqKbEJ943zSlFP7f0hP32uExRVW5Tydm7dFi5ZcvjBmo2Bxktmy5yjtXRR/Yl
	5S9Ta/29t/CKwg/uP+93WA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793894161; x=
	1793980561; bh=+w/qXuZYlkYWda1Xs168VpdBCh2Dw2DrXwv9zMQs/hE=; b=l
	WtYIO5u+p+RS5RW199ijq7wEp1HC3vwa9ey20jbF3rPtwkk8h8VC7GLdS0kOKZbU
	r2LD9u0BEixRC3EZ/4O+6JC+1xs5/UZ9nvHCiZr/b6ldVTGxqdTdCbweGLx0MU41
	uzHkyNwGC/MsOAlMWtHhJuJaOBu7wjWYwGYoVtK/tEodO/YJfHSQrmPoZGak0ZhM
	ffl/IbitJnsdXLcn/p11W83dBSntYB3TvPM+LSwYogAQhCAAyF3f9pqxBCZDodJe
	yUqbBp+toMB49yj/q7j+7Hfbs0ovoD20m1N2NJtAU/Fqp0lbSNaPJmznm8Ak+CiX
	KfBmcqQZzLpJ8w5hp+e0Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793894161; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+; rt=PGt2bUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:mKjYOWh5eLwW5CQ1TgJR5MAN7iTa+qTIghkVeIFHGt9Tqiq
	q7EecmbvWbEGexcw7uay1I6x5qEBLsfh9Vk0B9w0TStOZO/gFL+ptX0DeUQbOaOO
	OPwzqWnMPPTpbIakUOTvl7eP/rp6j5J9J7E/oxR2RVVXe1eMaWZKYCjywL+JLVPa
	yJhwzPFrsx4d4NuPtn60XZz03uVBEtSschrOQUSxw6HOVku7zjVO3IO/q9FPKy4b
	vIn88zFIgR9kI5pYj6S28DVYxbKSJx5EyeN15jI4Fy0OMqSRVDrlTUvnRuaM8k8f
	uIqjKlxyDYRQSSOChMsPRxxUk8kiTcMLuPdx/9A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:QA3IHDmvKSgxkp/sTa87qrbZu/nPmIWtFO2Jb4VWasw=:IlYIUMRd+p2tmJ/4ATkU1O6vMgxes57IUB7wLLb0i6E=;
X-ME-Sender: <xms:Eafsal1wc3Yowo0VN7Gaa9xb5VpYRlEG4Rr9sI53NztFzt0xOH4lLg>
    <xme:EafsahAbY2_WoTA46vzl1WLPvvpsd6m5aWGnhlZEAPhMRFDmn7QD9BmNeFVmzltLg
    cnrR_xI6KgmxzDAf21DPo5NVkTBCbQ6DhMsWBtJ7gOd2Fp41p-W3Zj0>
X-ME-Received: <xmr:EafsaqIVw8uf_MhkBJ6jnadbOz8inXaERR2vWU53CjZHMhGa-kjAv5uBLtVizQ>
X-ME-Proxy-Cause: dmFkZTEJhUV9GZq7jdzC1PgG1hjRQjI1vid1nMaRF6RGvBf7WUx3vry9QM7nA0rfpPyMf/
    sEBD95XaWRz4mwDvZqHXIogCQgZM1tHEMOSqY23kipvUMEjh8OIVW6cfaNTqmEzpCn3U0F
    C6Y9pPuN1CmwoY9tvMQUy2h6eSp+j7mB2I7o6JT9zWUFe5MV/vPGe0jWhP8ys9CIhA9feY
    hviLgVlq2yiQXwC7vUlGk6sEz+ztaGL2InuBNu1lxdD6Vr5rjwC6WyTdkkoy0R6JIxYB9r
    EDnaVcHII3u7J3UMZEgVrV0yQGz1yIuz6vNL/upsSBImEXLEmAL6fcUhAwYDqwvs12xRSb
    94/BkP06WB4Z3TM4h6mF9plJaxBmY8bQxyYwEOTtYph3goq1GcLEs/Uw/FqMtGUNhaPd7l
    mkppxuYQ7SYZRlusznAjYIdG1/BSWgA1Y9KOyYkAP68pAmhRiZ//FhnvEOK92+kzeFKO/v
    v7AFP+Z77uEb6pD4tTjNhH7sWFMWEcuIdF+9fvyfq/bHM1RsDjTGpZR13NMLkeGoVNzlh3
    cpF8M7/FP6tH519Hx3RoHkZ7AKouddXvfIwmQiAGIXFmdIFeUHkqffsRHoR11ImVHc7Q6t
    l0kOzaOiIhmz0V1BERuH5mEUOsazzRVNAqXbvA9qnxD8+5+JNoqCL5roMbSg
X-ME-Proxy: <xmx:Eafsail4eYaOBZymuQNEtFOoESTo5-m_YnEN7kwa5kveTJD2-QJiNA>
    <xmx:Eafsarb7f4BTpsCYrrnEBzgvlOFuThtg55ELeATkxcX6gdSr5a2cOw>
    <xmx:Eafsam-XNwr-3Y972gYt_9Ig3HMYKCMpSBzBXJ-9_RQO9xghbvf7UA>
    <xmx:EafsaiZts5tFDquDe8Vsxu8SLKOu9l-xYU9IcG-u6tPAkMRbEqD76w>
    <xmx:EafsalHCZ-DcDQRxgDVNEn4bboqbz_iP3siSLvNihXqRwcsu4LhAvHf1>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 10:56:00 -0500 (EST)
Date: Thu, 5 Nov 2026 08:55:58 -0700
From: Alex Williamson <alex@shazbot.org>
To: "=?UTF-8?B?UGnDs3Jrb3dza2ks?= Piotr" <piotr.piorkowski@intel.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
Cc: <kvm@vger.kernel.org>, <intel-xe@lists.freedesktop.org>,
 =?UTF-8?B?TWljaGHFgg==?= Winiarski <michal.winiarski@intel.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>, Kevin Tian
 <kevin.tian@intel.com>, alex@shazbot.org
Subject: Re: [RFC PATCH 4/4] vfio/xe: Hide BAR ranges by default per device
 ID
Message-ID: <20261105085558.75666f25@shazbot.org>
In-Reply-To: <20261105153738.1938345-5-piotr.piorkowski@intel.com>
References: <20261105153738.1938345-1-piotr.piorkowski@intel.com>
	<20261105153738.1938345-5-piotr.piorkowski@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Nov 2026 16:37:38 +0100
"Pi=C3=B3rkowski, Piotr" <piotr.piorkowski@intel.com> wrote:

> From: Piotr Pi=C3=B3rkowski <piotr.piorkowski@intel.com>
>=20
> xe-vfio-pci accesses the BARs only through vfio-pci-core, so opt in to
> hidden BAR ranges.
>=20
> Let each entry of the PCI ID table describe the ranges to hide by
> default. The description is always looked up in the static table, so
> binding through new_id or driver_override can't skip them.
>=20
> No device defines any ranges yet.

We don't merge dead code, so the whole series is to justify the
configfs mechanism to introduce excluded ranges without publishing them
to the community?  Hard no.  Thanks,

Alex

>=20
> Cc: Micha=C5=82 Winiarski <michal.winiarski@intel.com>
> Cc: Alex Williamson <alex@shazbot.org>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Yishai Hadas <yishaih@nvidia.com>
> Cc: Shameer Kolothum <skolothumtho@nvidia.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Piotr Pi=C3=B3rkowski <piotr.piorkowski@intel.com>
> ---
>  drivers/vfio/pci/xe/main.c | 60 ++++++++++++++++++++++++++++----------
>  1 file changed, 45 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/vfio/pci/xe/main.c b/drivers/vfio/pci/xe/main.c
> index 7dab3e024aa8a..e63af6123f598 100644
> --- a/drivers/vfio/pci/xe/main.c
> +++ b/drivers/vfio/pci/xe/main.c
> @@ -24,6 +24,16 @@ struct xe_vfio_pci_migration_file {
>  	u8 disabled:1;
>  };
> =20
> +/**
> + * struct xe_vfio_pci_desc - device specific description
> + * @hidden_ranges: BAR ranges hidden from the VFIO user by default
> + * @num_hidden_ranges: number of entries in @hidden_ranges
> + */
> +struct xe_vfio_pci_desc {
> +	const struct vfio_pci_bar_range *hidden_ranges;
> +	unsigned int num_hidden_ranges;
> +};
> +
>  struct xe_vfio_pci_core_device {
>  	struct vfio_pci_core_device core_device;
>  	struct xe_device *xe;
> @@ -543,8 +553,32 @@ static const struct vfio_device_ops xe_vfio_pci_ops =
=3D {
>  	.detach_ioas =3D vfio_iommufd_physical_detach_ioas,
>  };
> =20
> +#define INTEL_PCI_VFIO_DEVICE(_id, _desc) { \
> +	PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_INTEL, (_id)), \
> +	.driver_data =3D (kernel_ulong_t)(_desc), \
> +}
> +
> +static const struct pci_device_id xe_vfio_pci_table[] =3D {
> +	INTEL_BMG_IDS(INTEL_PCI_VFIO_DEVICE, NULL),
> +	INTEL_CRI_IDS(INTEL_PCI_VFIO_DEVICE, NULL),
> +	INTEL_NVLS_IDS(INTEL_PCI_VFIO_DEVICE, NULL),
> +	INTEL_NVLP_IDS(INTEL_PCI_VFIO_DEVICE, NULL),
> +	INTEL_PTL_IDS(INTEL_PCI_VFIO_DEVICE, NULL),
> +	INTEL_WCL_IDS(INTEL_PCI_VFIO_DEVICE, NULL),
> +	{}
> +};
> +MODULE_DEVICE_TABLE(pci, xe_vfio_pci_table);
> +
>  static int xe_vfio_pci_probe(struct pci_dev *pdev, const struct pci_devi=
ce_id *id)
>  {
> +	/*
> +	 * Dynamic IDs added through new_id are matched before the static ones
> +	 * and carry no driver data, look the description up in the static
> +	 * table so that they can't bypass the default hidden ranges.
> +	 */
> +	const struct pci_device_id *match =3D pci_match_id(xe_vfio_pci_table, p=
dev);
> +	const struct xe_vfio_pci_desc *desc =3D
> +		match ? (const void *)match->driver_data : NULL;
>  	struct xe_vfio_pci_core_device *xe_vdev;
>  	int ret;
> =20
> @@ -554,6 +588,17 @@ static int xe_vfio_pci_probe(struct pci_dev *pdev, c=
onst struct pci_device_id *i
>  		return PTR_ERR(xe_vdev);
> =20
>  	dev_set_drvdata(&pdev->dev, xe_vdev);
> +	xe_vdev->core_device.hidden_ranges_supported =3D true;
> +
> +	if (desc) {
> +		ret =3D vfio_pci_core_hide_bar_ranges(&xe_vdev->core_device,
> +						    desc->hidden_ranges,
> +						    desc->num_hidden_ranges);
> +		if (ret) {
> +			vfio_put_device(&xe_vdev->core_device.vdev);
> +			return ret;
> +		}
> +	}
> =20
>  	ret =3D vfio_pci_core_register_device(&xe_vdev->core_device);
>  	if (ret) {
> @@ -572,21 +617,6 @@ static void xe_vfio_pci_remove(struct pci_dev *pdev)
>  	vfio_put_device(&xe_vdev->core_device.vdev);
>  }
> =20
> -#define INTEL_PCI_VFIO_DEVICE(_id) { \
> -	PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_INTEL, (_id)) \
> -}
> -
> -static const struct pci_device_id xe_vfio_pci_table[] =3D {
> -	INTEL_BMG_IDS(INTEL_PCI_VFIO_DEVICE),
> -	INTEL_CRI_IDS(INTEL_PCI_VFIO_DEVICE),
> -	INTEL_NVLS_IDS(INTEL_PCI_VFIO_DEVICE),
> -	INTEL_NVLP_IDS(INTEL_PCI_VFIO_DEVICE),
> -	INTEL_PTL_IDS(INTEL_PCI_VFIO_DEVICE),
> -	INTEL_WCL_IDS(INTEL_PCI_VFIO_DEVICE),
> -	{}
> -};
> -MODULE_DEVICE_TABLE(pci, xe_vfio_pci_table);
> -
>  static struct pci_driver xe_vfio_pci_driver =3D {
>  	.name =3D "xe-vfio-pci",
>  	.id_table =3D xe_vfio_pci_table,

