Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795183529;
	b=jonCIHac21FqJJ1qdUwLrrUC3Wjw0WYZdSVaNoeNBeXPQRS+UMjUJMsUR70exeLgVSQt
	 oXGyfDCvRR03FZbaD3dnek82DWPnTA6XG6QpjM6keL0wnV2Ud+LrcHleZBimMJ40HHVk0
	 z87bGMilZkRcWFRMV9bBiKwOzzs7VMGqosUkkVF+Y75H1IPYL27w2Es3tT+QM4EGjdocG
	 Mm+nTRshyTsED0WUMRgxPji+M6OCdG1E2d4X1ev7Ncluy42E2/aXL4Rqvirg/+J4X746w
	 Rbt2etRyazML1TaIyt9PRhGH4GNqva6//hKmRSQuJONtjalqBQFsHvujkUcxdjx89rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795183529;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=fKhA2P1ewRK9WeXDzZdZmZPm69l3JUWOOFfVIt+9Bkc=;
	b=kXk8/dgsm5BkIfj4vnQSWsEQVRVUKJmGiAzq6hGIHM2RjDQJDmzv5dsUqpdUCD0PPdyT
	 MlRcGjZIoIEyxOIgBsDnBOF/eFhavPKvBr+9nhy09MuRSl4N1Wmuyq2OTxqw1oo3bEAh9
	 wpL7eGqIR3opZYdWOZpX4FQKQ1ka7+pLQS1k0v4Y6VApcY9KXmFJkCIX6zVTMZ4NqE3th
	 TggKsaaJeFKF+yUM0rZ5Li/FXE73TM0XXSu3r1UMsVYdt4OWYy8P06Mefql2UCfNgt0kG
	 47tcT6tQb6BwPpUY3wilzCK+T01WS/cAJd8eIZXTBEYAjztU0BlQkhG6Z5U3hnRFIgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=mgy+KYAs;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CCD606A320
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 14:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43CCD606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=mgy+KYAs
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4a358881793so468529f8f.0
        for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 06:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795183526; x=1795788326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fKhA2P1ewRK9WeXDzZdZmZPm69l3JUWOOFfVIt+9Bkc=;
        b=mgy+KYAsx2ff/GlyARPQpLRhQzn1hTsj8RK0oyJ0U8IDIi3i2Ekd/L1lS57GTgj9F9
         z6lwEGryBnNdQameZM/LfHBIk/8jIxMAWWq2Z+S+4TpaPKBlrEQ2lY/YnyTEGI6asLeB
         23h1laoP9T4eKxyOErBq0FM+calCa3sB+SuGSJRnbuuGTX+OGqUSWrREi2K77ziAI7f7
         ujfivtk4m6rgNgAVjwUzkCg2MU2wljjLiJ3W2QR3xZnenxfm5X81ksIwkI9yo/AKO1I8
         n46Yb7BUZWimfV5xlZsukbZUxn54wPvDowc7uFuc4mA80QcPmJqX62E1xThV33+zJ39h
         m2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795183526; x=1795788326;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fKhA2P1ewRK9WeXDzZdZmZPm69l3JUWOOFfVIt+9Bkc=;
        b=Ru65yWWoo3EZAqBja20RD2+MVDTmLkp4AYbm2fHJivKbmCRUtRddZvbejImfosMkFc
         8N8iZ3fBo1beWbV2c7j+wpYx2Q9FPmmsxkJPkBVbqiHnvc3Y4fCXozXIryXW9pQqPh7H
         2Dw9JaZy5oqndSHqj+qEZ5vmQsRzhNsnh88zGgzYRAnuBOCJAB7eZbliGgUSJC7R23fl
         9SCwikgy3DHZLW/Dspc3lX/+ntg6QV95j+VftadOGJmnZ/f4ZGFYE8WKcHxNwzsiTHZD
         zhNk3LceoDrH0kdp+WfPgSQwpqTGpLTgEVcbmEFeaje34PCKCS/1zLWGl9UsL3EpOjoa
         i18A==
X-Forwarded-Encrypted: i=1; AL+hErFHu4P1YGoxAW5TQT5CGyt9w9biDZ9GLiM0YJ9PSMa5fKe5NosjzEh/cKvxrG2+hfO/0Y4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8HsiRt3w0EBvwikC2biy3j56T5MySGQriItV5VfQNNhRkl8r3l
	M2GM5drIAVZ1Qoi7fMW3I7jw8mD3HRIUb2vMicTPV2J201cQPu7QPAchDftiP5SbYKY=
X-Gm-Gg: AZFdTZfaUskqe5K4v8yLHvfynjz7ZNzj4+FwH7/ggkyaybuogC8kYrG4F0+uvnbIwot
	zgNvC5++aPDK9Ni/r7ymhSsulRFzPDzXzEIHR0PWXMhOi2p5y4QYrJIT47ysxx6OLqBpvY7GNDl
	kxcRFQ3RNSGkuZ2smY5LU34CPtgWc0Zc4IuRqe+efTkl3okS4ogQVEyRyLt+976EDphc/+r2eV8
	yN2ozXMbmI3+LnIDibt4qIAYBupT8kmWPB7K5GlwkrVL1nC7sYwI0CrPqkZ8iGtF1rMtI2T1Jom
	oTyP8hjXVLDvISQ3019SEQmdxK1MU7TthrcG3ha+tOH6VAp4vRxJ2JMgg23mfE4Ty4xDlHN0thJ
	uoJU/vnaZke0oBXVc25RlbEHPDNeXT3HTWh28oUFGx+OeJsqWeYStuAIOcaptzKEIQg1j6Y0sDg
	KrlIx0FLPC27yOV2FxJuIiLEMtLFbd2JsN+Lzbgq40CKaaRHiCG0Chxayl6FDjwQe4lWMm1MypG
	aOAU+wt7ClCwzMEkkWGPvzQucyPSsSlcwiZ8viNvnM3Yih3DM5GWB3hY1hGqDc3sd+aobhA7y4i
	ZPMPAahjPcAdu+Fm47OBXLWAX2lyZZlBBLYPSx+7mZh3Qhee1pSHsCg7M4MLCGBzbGADR0NF+Oj
	1PCcRP6dFA1e8A1VKpD5xyu771cLcPW3OsYJPagc=
X-Received: by 2002:a05:6000:29d2:b0:4aa:831a:d0eb with SMTP id ffacd0b85a97d-4abb3c37a50mr4536615f8f.9.1795183526458;
        Fri, 20 Nov 2026 06:05:26 -0800 (PST)
Received: from localhost (p200300f65f19a9041d3eb07d772156f3.dip0.t-ipconnect.de. [2003:f6:5f19:a904:1d3e:b07d:7721:56f3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4ab6c4353d6sm5825284f8f.56.2026.11.20.06.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 06:05:25 -0800 (PST)
Date: Fri, 20 Nov 2026 15:05:24 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
	Tony Krowiak <akrowiak@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, 
	Holger Dengler <dengler@linux.ibm.com>, Alex Williamson <alex@shazbot.org>, 
	Vineeth Vijayan <vneethv@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 04/10] s390/vfio: Allow untainted use of
 driver_override
Message-ID: <awBSb7VOGyCCBDv2@monoceros>
References: <cover.1795171088.git.u.kleine-koenig@baylibre.com>
 <a53e12ad841fb18e45b3cf7a4580846943ed0c6d.1795171088.git.u.kleine-koenig@baylibre.com>
 <8548e9504ec70bec02c6f2cebf69ea91@linux.ibm.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z5kdjss4jszejxnb"
Content-Disposition: inline
In-Reply-To: <8548e9504ec70bec02c6f2cebf69ea91@linux.ibm.com>


--z5kdjss4jszejxnb
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 04/10] s390/vfio: Allow untainted use of
 driver_override
MIME-Version: 1.0

On Fri, Nov 20, 2026 at 12:58:52PM +0100, Harald Freudenberger wrote:
> On 2026-11-20 12:11, Uwe Kleine-K=F6nig wrote:
> > From: Alex Williamson <alex@shazbot.org>
> >=20
> > The vfio_ap and vfio_ccw drivers bind devices through driver_override.
> > With the introduction of the support_driver_override flag in the core
> > driver struct, it's now required for drivers to declare themselves as
> > driver_override compatible, otherwise driver_override bindings will be
> > denied or generate a kernel taint.
> >=20
> > Set the support_driver_override flag on the vfio_ap and vfio_ccw driver
> > structs.
> >=20
> > Signed-off-by: Alex Williamson <alex@shazbot.org>
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> > ---
> >  drivers/s390/cio/vfio_ccw_drv.c   | 1 +
> >  drivers/s390/crypto/vfio_ap_drv.c | 1 +
> >  2 files changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/s390/cio/vfio_ccw_drv.c
> > b/drivers/s390/cio/vfio_ccw_drv.c
> > index 7546bd137e4e..77765cde87f7 100644
> > --- a/drivers/s390/cio/vfio_ccw_drv.c
> > +++ b/drivers/s390/cio/vfio_ccw_drv.c
> > @@ -375,6 +375,7 @@ static struct css_driver vfio_ccw_sch_driver =3D {
> >  	.drv =3D {
> >  		.name =3D "vfio_ccw",
> >  		.owner =3D THIS_MODULE,
> > +		.support_driver_override =3D true,
> >  	},
> >  	.subchannel_type =3D vfio_ccw_sch_ids,
> >  	.irq =3D vfio_ccw_sch_irq,
> > diff --git a/drivers/s390/crypto/vfio_ap_drv.c
> > b/drivers/s390/crypto/vfio_ap_drv.c
> > index 8e69ed286bb9..2d47dc643269 100644
> > --- a/drivers/s390/crypto/vfio_ap_drv.c
> > +++ b/drivers/s390/crypto/vfio_ap_drv.c
> > @@ -62,6 +62,7 @@ static struct ap_driver vfio_ap_drv =3D {
> >  	.on_config_changed =3D vfio_ap_on_cfg_changed,
> >  	.on_scan_complete =3D vfio_ap_on_scan_complete,
> >  	.ids =3D ap_queue_ids,
> > +	.driver.support_driver_override =3D true,
> >  };
> >=20
> >  static void vfio_ap_matrix_dev_release(struct device *dev)
>=20
> Hm, honestly I don' get this...
> The driver_override is a bus thing. So the AP bus has support for
> driver_override.

Yes, and ap_device_probe() calls device_match_driver_override() which
requires .driver.support_driver_override to be true to make the override
work.

> The sysfs functions are in drivers/s390/crypto/ap_queue.c. There exist
> currently
> two drivers which shall be bound to an AP queue: vfio_ap and the default
> driver
> which is the zcrypt driver "cex4queue". It sounds like the driver needs t=
he
> tagging about driver_override support and then similar to the vfio_ap_drv=
=2Ec
> the static struct ap_driver initialization may also need a
> .driver.support_driver_override =3D true line.

Can you please talk in form of a patch? I have difficulties following
your words. (Hint: "the driver" is ambigous if you just talked about two
different ones. Also what is "the static struct ap_driver
initialization"?)

Alternatively something like: "I tested you changes and the xyz driver
fails to bind, this is the respective kernel output: ..." would be
welcome, too.

Best regards
Uwe

--z5kdjss4jszejxnb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsAU6IACgkQj4D7WH0S
/k6tMAf8CzB6okqp49LE9R3aOA1LqPPI2LOhdKWbHnK474C/TId/TESJtb6NeK9a
/TiJzbw0cMmiZBWFX98POZtuxPs/p7E267I4HIiVSkJZbXIMTQLgRtNAwzQ2XHSG
hGC6bCl/mo8FvF7Wgh4UDmKJf0ouYsnKSngydVHdAMge9AWdPLAwV/Mt22qoUPuf
zTO+MmKjQ5gYxdV5B/bA6zHB3m9WhdotEJsK3fJqNr4Ey2gMKsfBSPhfX++rkr2K
rLeBF3pOWEtGt96JPSOKF9uBsbrRdGNL/hRINeFMxcqFG2dqs07zOz+X5FKWSzH3
Ba2MDNVrii6e5LmWPrJUf6CRttkdJw==
=kxW2
-----END PGP SIGNATURE-----

--z5kdjss4jszejxnb--
