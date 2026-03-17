Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1734E3E8683
	for <kvm@vger.kernel.org>; Tue, 17 Mar 2026 14:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773758627; cv=none; b=mvYwx49sPthzCZK67RYhqC3ixKaTtIbh9S0MvzC9LRSCX9zhmJThT5huciehZwKAknPoNb4InII0OvSMBt6BTariJeacUlUw1hziflBOHJI+uYcUfYDZFYQvyaLhsdEM+XjZZ02bfhgNVD+ItITmKWKTO4ZeXJFsQifO0iO51Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773758627; c=relaxed/simple;
	bh=CQ+SRpPHH36exOR6dp5WjwMv0N1m/j4DEqcugvMEyG0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NWAJhz43LUpvKW0+7pSTBo1IlDNuzatbEPcufPajmiwSohhRd6yI0WKT9ZYNaA1CgmoAIegI9HLZsqA6Dk+0cHjBxk+fTzWC2/0B17fbCb1fWcWt4hZtmNVu1u5FtZbysHSnfGJb+9PK1PdS2p2KlRtcD3QWdbkwYQ4Jr+CRVCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=rMILFVqr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W0gy8EiR; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="rMILFVqr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W0gy8EiR"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3DA8A140003C;
	Tue, 17 Mar 2026 10:43:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 17 Mar 2026 10:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773758623;
	 x=1773845023; bh=U9M+HkVQBEYKrxCJ9TstEQmfV+0p5tozuQ5lwFDFX1M=; b=
	rMILFVqr1IpYmMQ1rQAMzOMN2QYPYf6LtDM3AeD1/yC8cEXCIxG/Z5Q6zPNckHT5
	Tkxhz65Fi0GXREx9URvc+1b3aXe+2HX6isUOhYXGnbrJ8dx2pmnYGZE0cuv6CgMX
	NbU4rDAng1lVv/T3le210RmNJrd8RzACAsqABbvekC2d4CSmPO+n8L6xm9DFOFLf
	iYJ+5nePmhBSs/KwFR421mxt7uMg/uohHJ0itkC+Nwd3ZudlavLIgllE7vELeuwd
	hQU2wJRfECKdSJ9Hfj4wL9iiYLv3fvIDIcYe+bAfQgj+sYOQutX/4RGjBoR+xuSu
	rI8oD8kFFaUIJYli4iyg9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773758623; x=
	1773845023; bh=U9M+HkVQBEYKrxCJ9TstEQmfV+0p5tozuQ5lwFDFX1M=; b=W
	0gy8EiR8pDQLseBb825jsb/L6yuG/Bi0/eZuGcEzSr/7W15rxrzwlYRiVlL1oG6G
	B45rwMGdiiI6e3BdC0J511jkNal2ZVaH1GxWGyBzA626prK+2tloBYmdrRq+Rlr4
	2as3afSoYR2vKdYJsK0mdudKoEG9UELqvvYQoCXidEHubjyQ4c7dtHrC4ZbO6YB8
	QuVj47+CWoZHam8Ce6HKlYndTGhmQF4xXeWDhXJybnzlhwwyiBwVFU7tIWlgDLrC
	egMl02HS3UYH0nL3k2ylWrRvv1NszfwPZT/jrGNIzrTxWlTPMrS2SfPTAUdCDVtF
	UlO+1aeQXkj3aLA1ERlLQ==
X-ME-Sender: <xms:n2i5aTxlSGXBWVHHBXoi8Pq8Xt0uifqv55qL_vvXQB9lqlt0cl2qCQ>
    <xme:n2i5acwsuAtdZDwXefslUYw90K72WWRKkkbZ1NieUxE2buvI__CAiEKeZ0B0yNQDY
    kJ4XndZYLeqGN2wcxRPPaSqYAd3YsTePnOMEneMbtrtHyYPXlG1C-s>
X-ME-Received: <xmr:n2i5adYX0N6o3-K4D_bXgdgP8UExV-MsfRd7KNufJqYB0UvQjDnrf4nJfvc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdduhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpeegudevhfejueefveduieeuueeifeettdekveekhffgvdetfeelueehgfdt
    heffhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhiohhtrhdrphhiohhrkhhofihskhhisehinhhtvg
    hlrdgtohhmpdhrtghpthhtohepihhnthgvlhdqgigvsehlihhsthhsrdhfrhgvvgguvghs
    khhtohhprdhorhhgpdhrtghpthhtohepkhhvmhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehmihgthhgrlhdrfihinhhirghrshhkihesihhnthgvlhdrtghomhdp
    rhgtphhtthhopegrlhgvgiesshhhrgiisghothdrohhrgh
X-ME-Proxy: <xmx:n2i5adXDSGX71jpIY9TDgFc6mkLD8DLBCmDCklscduk_aFhqmJvxew>
    <xmx:n2i5abgHghRB2apanOzQY7E62kGRA3xvKIhjQyMGd_gU2BBkV0d6sw>
    <xmx:n2i5abvaXTNaZNhZQrQiw8iwHmh2w97lkpcuS1CsQ1Oha8oEWzxamQ>
    <xmx:n2i5aU5-oUii-H627S6_sWdppWrVHzdP76kJgWweNC0a2a7jkJzOkw>
    <xmx:n2i5abBcU4A0ZAEjaHbIy9oQddOsM32Y8wgvALg8gnvZi8KDqPoGFrRa>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 10:43:42 -0400 (EDT)
Date: Tue, 17 Mar 2026 08:43:40 -0600
From: Alex Williamson <alex@shazbot.org>
To: "=?UTF-8?B?UGnDs3Jrb3dza2ks?= Piotr" <piotr.piorkowski@intel.com>
Cc: <intel-xe@lists.freedesktop.org>, <kvm@vger.kernel.org>,
 =?UTF-8?B?TWljaGHFgg==?= Winiarski <michal.winiarski@intel.com>,
 alex@shazbot.org
Subject: Re: [PATCH v2 2/2] vfio/xe: Notify PF about VF FLR in reset_prepare
Message-ID: <20260317084340.619c5fad@shazbot.org>
In-Reply-To: <20260309152449.910636-3-piotr.piorkowski@intel.com>
References: <20260309152449.910636-1-piotr.piorkowski@intel.com>
	<20260309152449.910636-3-piotr.piorkowski@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 9 Mar 2026 16:24:49 +0100
"Pi=C3=B3rkowski, Piotr" <piotr.piorkowski@intel.com> wrote:

> From: Piotr Pi=C3=B3rkowski <piotr.piorkowski@intel.com>
>=20
> Hook into the PCI error handler reset_prepare() callback to notify
> the PF about an upcoming VF FLR before reset_done() is executed.
> This enables early FLR_PREPARE signaling and ensures that the PF is
> aware of the reset before the completion wait begins.
>=20
> Signed-off-by: Piotr Pi=C3=B3rkowski <piotr.piorkowski@intel.com>
> Cc: Micha=C5=82 Winiarski <michal.winiarski@intel.com>
> ---
>  drivers/vfio/pci/xe/main.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/drivers/vfio/pci/xe/main.c b/drivers/vfio/pci/xe/main.c
> index fff95b2d5dde..88acfcf840fc 100644
> --- a/drivers/vfio/pci/xe/main.c
> +++ b/drivers/vfio/pci/xe/main.c
> @@ -85,6 +85,19 @@ static void xe_vfio_pci_state_mutex_unlock(struct xe_v=
fio_pci_core_device *xe_vd
>  	spin_unlock(&xe_vdev->reset_lock);
>  }
> =20
> +static void xe_vfio_pci_reset_prepare(struct pci_dev *pdev)
> +{
> +	struct xe_vfio_pci_core_device *xe_vdev =3D pci_get_drvdata(pdev);
> +	int ret;
> +
> +	if (!pdev->is_virtfn)
> +		return;
> +
> +	ret =3D xe_sriov_vfio_flr_prepare(xe_vdev->xe, xe_vdev->vfid);
> +	if (ret)
> +		dev_err(&pdev->dev, "Failed to prepare FLR: %d\n", ret);
> +}
> +
>  static void xe_vfio_pci_reset_done(struct pci_dev *pdev)
>  {
>  	struct xe_vfio_pci_core_device *xe_vdev =3D pci_get_drvdata(pdev);
> @@ -127,6 +140,7 @@ static void xe_vfio_pci_reset_done(struct pci_dev *pd=
ev)
>  }
> =20
>  static const struct pci_error_handlers xe_vfio_pci_err_handlers =3D {
> +	.reset_prepare =3D xe_vfio_pci_reset_prepare,
>  	.reset_done =3D xe_vfio_pci_reset_done,
>  	.error_detected =3D vfio_pci_core_aer_err_detected,
>  };

Looks ok to me, should really have Micha=C5=82's ack as well.  Will this go
in through drm?

Reviewed-by: Alex Williamson <alex@shazbot.org>
