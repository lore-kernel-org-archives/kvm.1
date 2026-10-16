Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A484335E93C
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792169424; cv=none; b=PbrybZSOLfB07GKAgLdeGADsEp3dfxnFwDGo0GOhV/s9X8xZ5aqaeOZ5EQESNA/YGCa99joRA8kx53jL37PUy8NSVVftnTufZiOmZQWq7G4fmPETkoW66/Ibq3K2gnUg95/jYvETWCnFkxJToZXTyPBPZxnRtVEzESSpLrEirYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792169424; c=relaxed/simple;
	bh=dKGK9QzfUtkdrx3e2Lna8zFW8U+rke7oYbRAphr71y0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JbbPxR+V/oedQRi72zkLdfLuRljluR8XFEex7pmAKU3x01XkQscJdd85q1QZsBxrCtC7rbrfitWPgqtzREugBM3kwtJnKt2kMAKW3QMILkjeXxEbNuxhyDhV58ZJBdWe6i2KOZ7mImEj1OGOTwy7IOfoo3YvAEA+j2sdKPc6kY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=GVqpULF6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gLiO+VYV; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="GVqpULF6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gLiO+VYV"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C749A7A00DE
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 12:50:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 16 Oct 2026 12:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792169420;
	 x=1792255820; bh=xgeXQ7QI49qUYlE81VNicEWZ0NBkP0UQ4uYQY/eXcg0=; b=
	GVqpULF6XfeuZGeCHyZcAi3Ds+T/ouQSnDoYbWb/o+nq49tcVDCWVZIbzcaLR7c4
	A6tZ6ckcv76wdaim6+Xy0XqJFzN7diMkelRBTLWUtpywcKkqkZ9+X40cLUNCPwYV
	BeSKaXP/axkEeXSmAEquyhlQE8boDlqf9QJyZhvgGk+9rKymNbRdvGE+okrAmt3U
	2o7t63NHIK+7ar9dqVUBfm53mMbgUmec4GJ6zN8sQCZO3mI+lYX5SK2/kFMfdSrq
	zHwdphlTJ2K+Cwm0fYFx0G6Xo5NGQUx0SQYe3PmDz0f3MD9XgA0B5Pu7oMvVWF91
	5cdTreJ3GaL3e/Jkqh29Og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792169420; x=
	1792255820; bh=xgeXQ7QI49qUYlE81VNicEWZ0NBkP0UQ4uYQY/eXcg0=; b=g
	LiO+VYVOQjz3MC27kNoumQKbB7aM+wIf0fUXWRlpY0g8TXIZVsR7FYkFk0A0tb7i
	ba681COYXYruwAmAZg7OwmNtiu9CMsoYLTDz4yzWAS7BY9GHAvAZhH8/o8N/jnLJ
	YlDtHn7ZpfkmyavHOh1CcI2mOrWS58NAveJKdZmqhinm9KeLucAwSyjXTv2fSvwg
	k1bqSJQS8TjuiUr25iSpnoRHLkPN6KG76uj5TUJQ8z9yPdTYqfMe6joS9OHa0ujc
	Jm5FnOf2j/vGN5gOPhFUMFYfNj7GExGQxikEpGcd7zwb8MUUA9lsnA2Olio2jTc3
	ORJ3nK6Sqn1c4AKsY7xxA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792169420; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+; rt=PGt2bUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:lP10BbLRGEnMJ52CvxIMDzOwPgwPZZLF4ASNqZKMbBWwje5
	CEhMY1h4aHRNsvlQ7x2O9yPgLKJb4rmEDslbTsnMoeFIx+5VPQzKZvTasCzODC//
	HG+inoqNgDJXXxLePstvrYnjqAnOcx8GkgnypWs+c5rlwOiuUejzGHdMhoRJnx0L
	p2BclqvqJlAM/a8aBDvdXMn3x7aWKMXfj9QshKg3Pw9SL4MVFICyImjdUnh/doSK
	AU2FqAUehhIWn3RNmN6V1PUq24cpUr4jMIHcfLK+sK+JPbm5ZwFzIMpkoOnAz2Ql
	qC6sAHTy+K32qO4OzRG/Usa3Y/NmCf/T3SIrN5w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:aY80aroA/i0x89lPnAKZZ2eGbOpuWioNrDLlXsvQzFo=:dKGK9QzfUtkdrx3e2Lna8zFW8U+rke7oYbRAphr71y0=;
X-ME-Sender: <xms:zFXSatIp5PVs_pCkx7ttSi6y4mLQHwVqriryiwOzq0G5uTfhUHeL5w>
    <xme:zFXSavLxUjK-Y7C0hdBYuxqOmeBRdDNOyHRVs4k9nOOA2G2LRSl0iLvF3Jd-f5efx
    VcDowkTlAr-D0hoFAMLATbtaLw8R3AhR8rMzDGsv5Fz95IYnKXks0VV>
X-ME-Received: <xmr:zFXSagjZiG07CKYCezwrlFfa8v-dtsE_tWcCEquZlUqgG3aw0390PbP4VT6Dng>
X-ME-Proxy-Cause: dmFkZTEb/AYso0mXeMN4uPzOI2HzYX85Xp44M58HlE7sv9GJphQzlpRb+Ar10TokQ47zK4
    dY0cfzNGkwd8kWFiRBSSQ+b+oNwUN1gQXBPe5b3ILFvYZlUMaolS58TB7gOcQRvpP2FzdZ
    qKC1HPKN7I5J14UK8Mgbuq2PT/GHr4WDq4YgduKqJ8YIdwtlNMWymYO8v0sS5q+c5UMNcQ
    lpEKOpocYGqf6tZBPaVRyshIV3v1A6/9s/yctJvVTEInjlZHqg/YsPrmcZGJhi++IIAJua
    FYxxMMlLtanbckLOFNFWctRHThoGvPZyTxr3fQPBwMxH9zCXuaP2FWVl8/OocESshLaFJN
    OorZwzEm+hMNMG/OA5H/zGUyF+p1A4e2KEFrGEVscJ3CAK+zZLidBQMq/6UuNbC2YIDuUs
    k5JAf3Sy2JgoQQCgmcIoxHCmBeqptu3oCfY5MyFtTghWF+T4ytOGztZ/I36sXdjV8qvHuX
    wMxZo3Wu37hIdOZ6km+BorJ5OGNex+E2TgaQktUazq7zjhZ/WadFP9gHVzNU0SWXmmi2Dh
    K7I2474itoDok6xv8/I+fbwbQDX7T8PbIjVqQYaTytdosuUgdbE6fky3iTGwlK3BcWQ0eA
    u12aMyzmSTFN01Pk6iKI5Y90yL3ucwJdv0Q6k69TSl8KSPX2w5/5sKZBGaAg
X-ME-Proxy: <xmx:zFXSahOpE1yTIR9S1IAfAs1H7om6VrIbmbX3Mg-MehPDawhsmb-s_Q>
    <xmx:zFXSajrRRL-Ex5AQaDagDX4hEdD3bwru8UWHwi3G-zAbe4CM2ELMlQ>
    <xmx:zFXSar63N9SIHYtiZ9z1e7hxQhOIKsOEm2jjXQQjeZlN6RCILhW9OA>
    <xmx:zFXSapgzRIlQKv8Q5XWSZTjHVWYLN46k6sSUvyLXjU1myeBa3p3K3Q>
    <xmx:zFXSap4OV6nFhFBlJ9S2uaAg6I0v-7FYfn9GbeQ9jR3AVtkO3xlOgGkL>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Oct 2026 12:50:19 -0400 (EDT)
Date: Fri, 16 Oct 2026 10:50:14 -0600
From: Alex Williamson <alex@shazbot.org>
To: Satyanarayana K V P <satyanarayana.k.v.p@intel.com>
Cc: kvm@vger.kernel.org, =?UTF-8?B?TWljaGHFgg==?= Winiarski
 <michal.winiarski@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas
 <yishaih@nvidia.com>, Shameer Kolothum <skolothumtho@nvidia.com>, Kevin
 Tian <kevin.tian@intel.com>, intel-xe@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH] vfio/xe: Add CRI and NVL device IDs
Message-ID: <20261016105014.672b05ac@shazbot.org>
In-Reply-To: <20261014131849.157593-2-satyanarayana.k.v.p@intel.com>
References: <20261014131849.157593-2-satyanarayana.k.v.p@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Oct 2026 18:48:50 +0530
Satyanarayana K V P <satyanarayana.k.v.p@intel.com> wrote:

> Crescent Island (CRI), Nova Lake-S (NVL-S) and Nova Lake-P (NVL-P)
> support SR-IOV in the Xe driver. Add their PCI IDs to the xe-vfio-pci
> device table, so that the generated vfio_pci module aliases allow
> userspace to select this variant driver for their VFs.
>=20
> Also reordered the table entries.
>=20
> Signed-off-by: Satyanarayana K V P <satyanarayana.k.v.p@intel.com>
> Cc: Micha=C5=82 Winiarski <michal.winiarski@intel.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Yishai Hadas <yishaih@nvidia.com>
> Cc: Shameer Kolothum <skolothumtho@nvidia.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Alex Williamson <alex@shazbot.org>
> Cc: kvm@vger.kernel.org
> Cc: intel-xe@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/vfio/pci/xe/main.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/vfio/pci/xe/main.c b/drivers/vfio/pci/xe/main.c
> index cbff5af385ef..8f1237751d51 100644
> --- a/drivers/vfio/pci/xe/main.c
> +++ b/drivers/vfio/pci/xe/main.c
> @@ -574,9 +574,12 @@ static void xe_vfio_pci_remove(struct pci_dev *pdev)
>  }
> =20
>  static const struct pci_device_id xe_vfio_pci_table[] =3D {
> +	INTEL_BMG_IDS(INTEL_PCI_VFIO_DEVICE),
> +	INTEL_CRI_IDS(INTEL_PCI_VFIO_DEVICE),
> +	INTEL_NVLS_IDS(INTEL_PCI_VFIO_DEVICE),
> +	INTEL_NVLP_IDS(INTEL_PCI_VFIO_DEVICE),
>  	INTEL_PTL_IDS(INTEL_PCI_VFIO_DEVICE),
>  	INTEL_WCL_IDS(INTEL_PCI_VFIO_DEVICE),
> -	INTEL_BMG_IDS(INTEL_PCI_VFIO_DEVICE),
>  	{}
>  };
>  MODULE_DEVICE_TABLE(pci, xe_vfio_pci_table);

Applied to vfio next branch for v7.4.  Thanks,

Alex
