Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55A658B6AD
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 20:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792095981; cv=none; b=ed5CVZivpSbq9QpMaZDkaE9PmtA+YTnz5ZnBNl5/nmSsuP23gnB9t0cFsQzvgI1c9eWCbiyqL+JicN4t0+nP9aulBxdwtNFecdOvJbyrQonCnHxtIxK45Mzy37Vw3FIjpHpGNe1dWPXkuPZrNFzN5hhNjL9QLqFjkQmgw9QqN/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792095981; c=relaxed/simple;
	bh=x7QwnD24yRUaqKk60dVJEyM7aNVWVX1BjN/KEWCUOus=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJ3mLZ3TnsoW5/8vqE4lRAJjh2Lbgt7dMyU+Q3Klv8SRXSlBGj2qRjnEupxLjN1AdYNhOxqiHaYzRfYr11xeySU3V2teUFL5Mazum3rACFxJn1cPl0PR4IvdYaGMkENkqmDsLAVg4Fro7xWZ5iPSQ1L7nTFLaFwHNNi5TzvZRRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=boGXDps6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IyCELeOP; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="boGXDps6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IyCELeOP"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F19387A00B4
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 16:26:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 15 Oct 2026 16:26:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792095978;
	 x=1792182378; bh=2RRIztZOszEgtU5KRM+EoAHa0heTyt/EU7Fc7IB6D2g=; b=
	boGXDps6z9yIfkCo6VBFj1kB192C1skTP3WndE/BRQm36ETwiSnLg6cRPj7mu2OS
	pRLqpd7r1yNY6PUaRKD64hi2tAC/98B0mf6lQHlNo2MNsud13MtIQ6v5eC+05kYH
	dq9mYRm9lp+hkfQ45R8KBWFdBsgZm476d7lDSAg5o2UG2UzR+fRNh5JNgWkrE8Iz
	CBFapBsoxgYM2nFevj5Kn2r+fkBKH26ucFmILiAnFJoOeNpLZdERRx50271vcPGx
	Nw17UfCHzS4ERg1XmwnU6zF0ncYzpIyZFhgwv948+SYySrKleZqIrlXYuOn/FDbx
	BoXf3qh1ec7mdcP7EIKlbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792095978; x=
	1792182378; bh=2RRIztZOszEgtU5KRM+EoAHa0heTyt/EU7Fc7IB6D2g=; b=I
	yCELeOPCiDRkoOwUTJPxmfeqH8oGbOIq7U4l7Ii73g+rpVMUybKqJG/dFX+kYant
	rVBPOmXQnE6/eXA1kwK4FWZLz30aUkYLlYIxazuKLqZwIEsgkOACwcFqYUOMMy1a
	plHJLFVpYXn5NKspWMIX0q24Lm8n7lMu8qwU9haDmnhxGJgB7jZtH7/26T2x6ahz
	hDiC0Y2fARcIwfvYCdZIZy8DpcZ5hQPh4Gjmd2g5sfJCNjsXW5eLrEvEwALtBKaJ
	YNQqR8uppr8URDjQBgQASLajhmat9oDWHlpR0CesW1wRQCnmScnx4l3iDjUnWsmL
	hqracyR2Ea7B2OblZZLUA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792095978; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+; rt=PGt2bUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:MSlpJ6dUy//j+urC4U30sNYknghKY6nN+GD8Kl5GDzZ5mu6
	uITMtXOp+9U1WaDEY39yt4t45r4k11T32IrDmhDl9lWzMrL1Ngh3QwG5puypxMan
	rdS5u57naLpAEAhaOpsK4qCS0mdNIQSdawjCwvTLKkhH06lMT/NrrXlhGPOrKPO1
	5Aqc60oDuBNOvj3lWYvqoiYRTv/+TNLrCU1pXdNyjGeV+RXvGkorOeS4lu3OBjeD
	XpHpeNektkY2dbHVvWgNTMdYG5+rLKRyMsDBq6vt1lF77WfYzEQo+LtGS/NoDxJU
	mftg0xaEXHbOGx74FO/4X92T7L4opww95xFm+eg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:5d27a61I+Y3ZQRIEAgtTeNjwfjhCV+RAkyi02Z1AxqQ=:x7QwnD24yRUaqKk60dVJEyM7aNVWVX1BjN/KEWCUOus=;
X-ME-Sender: <xms:6jbRana52w3L7o3zJF3Ge9ttQSQEQo3Z2-y0NVVBM-pjHRVtqNIiDA>
    <xme:6jbRasZy-HRBwQyyuY7PRo4gwS0z5ASIiYNxSqMEikO1qr3NeAFkZVbsrf_MpqOXl
    0-c_kATvnBRAAbXpr8YnbZvkOQGRcUSB9cNuuAFoBSmzn8JoxZvtAc>
X-ME-Received: <xmr:6jbRakwrLxupMOBm86kbOPch3OcWna0aAVIWBezHqBxQX-OvsCMdDOCmHztvzQ>
X-ME-Proxy-Cause: dmFkZTE1b+N8kGGpUk13ieyPlVE5FAmIlfPgy+YxTXBBm9ekOGZjEXT6yIuYwplMn2dscS
    WLp1YY5w7dgFcPnlXnKeiMRT6HKE8tpI7sfYrftO5G3NK+ZYEHbWgK3C0IuhTPI1vnEHKo
    iHPqsRhiJbD4Vd921Kqyh7t+IybxtF6YFY2CRYEIx3ABwEIwJIzDSdKkBlRJ4qqsDtFgbM
    wkinftxPmJ+5Db7uJy7rxBfKbXhCGIIB0P6CLtvQw1/ilyQAlywhsxZb4vJvpRANnXeOqG
    Ck0Y2N75AJWwe2bj9j7VGyMaG2Y+dwqlXqUDJd3USnV9F0paO2lDDHSE9qEnW4OUdOAhqV
    WVvbyfotMt2ED7PhEO8sjZZPn0bgik8tKTTIV8zEr44vIFoVy9AMrZzuPVmDpRl0ahjjv6
    d7mwjZVMTbRZ0MuKtUDwulmFU9woGU79l5Z7WsBl/dkKkKJTr7opGj0cv4lPtP1jmGhbZJ
    XviqULnYkfff+mgVerf6RVILnMVVVBWnEdmW3i6nuao1k8hjzUKIk6jUOmGDqLDsJkMNcK
    6ioQg6d6NuVN0b764YCSJaIACUjuolDXB76PT/fRH9599KTTgDduyzTxd+pqMwRtmfO0W8
    KkYXsjB+J8t6vjLvVPcYEl2umQ5cUDiz5xCueRuJ6FithsAxHtYZ3FTCLp1w
X-ME-Proxy: <xmx:6jbRagfIfYiydrtja_z5x-8GUX2AWR7gFhRdzhRVhW8tvkPZGnza3g>
    <xmx:6jbRah43MyFseVVH6uqpjenLRG3UpDy28mDWWKd9JZ1mMKw-U-bYHA>
    <xmx:6jbRatLxc1ynLzIERu5IL5va_Ji6LBk02Yub-r8hzqV9NQYHMBBkYQ>
    <xmx:6jbRahzmholD6nmakHVjxCeicEe28Dzo7WaGpND3CU2mhaF3BEid-Q>
    <xmx:6jbRakI1kB02K5nqhaDs6o7cIwH1aMwXqr_aRzslAfk6-B5n4eQKJmSd>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 16:26:17 -0400 (EDT)
Date: Thu, 15 Oct 2026 14:26:16 -0600
From: Alex Williamson <alex@shazbot.org>
To: Satyanarayana K V P <satyanarayana.k.v.p@intel.com>
Cc: kvm@vger.kernel.org, =?UTF-8?B?TWljaGHFgg==?= Winiarski
 <michal.winiarski@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas
 <yishaih@nvidia.com>, Shameer Kolothum <skolothumtho@nvidia.com>, Kevin
 Tian <kevin.tian@intel.com>, intel-xe@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH] vfio/xe: Add CRI and NVL device IDs
Message-ID: <20261015142616.2811a3a7@shazbot.org>
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

LGTM.  Micha=C5=82?  Thanks,

Alex
