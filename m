Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8502F12C534;
	Thu, 14 May 2026 22:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778798932; cv=none; b=YYFb75AX5a4iudsE/o/IJIqbYPSnGSWjOQBkGy9Cp00g6HEw6B5PKVFUQwbuEvOG5AqHK8Tq5B9tD2HmeMqFCB1/0IYtTj74g3Oa/LjETLP4+aKFjN8UXzXd0dbPppEPJrScGZvWNINNueBVKNFu0BqDJF8BJuQw/vK6A5zpxR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778798932; c=relaxed/simple;
	bh=cbDUqUSqAZ/x4RzJMVnzwTPAcUE2gznVh+rdbi/ixJI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hcAXMp9OJ98CU6q+PkDrOU3Aa+8ilpWRom8Vvu96cL++bUR+QCr1iCpAVKp5xlefAkGWNCegLmoOj/niQ2L/mA8moUY/2F5vk7egy6snNrUf7QY2hhXF9Wvse0U7gyHUeudahQ3ehxCS6R4z8tuPWWyYshexYkpfukw0wdY8yFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=tdv7Sg6c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MrnTAh3H; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="tdv7Sg6c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MrnTAh3H"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 583341D00086;
	Thu, 14 May 2026 18:48:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 14 May 2026 18:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778798928;
	 x=1778885328; bh=WYXyNu9jFS2CMozBDaVj8gAOuYnAjaysuUfWh3anrxU=; b=
	tdv7Sg6cFDMKyDZbqQmXbL5ly07xI5hu1N7rScUh3cTuLKORwBL2BTef04zm0gJ5
	FOcOKM6nsZUsrgPnnCRD+uz0mxSMgLt8v+6YgQynD6qNmFP8QeZ/2U8rfq3GVZ4w
	O2OhHFwe31Osx1NsA/ZTFkq19+GuToFuXLRFld5MB/4lTO24fwuIgZjoWnOKFo6C
	vBSTQVUURrV0E2cK6CAC84pE1DNi+xAvrFuf4ZozAI+Me8/E88VplFrxjqTKiAR4
	mmAIlklSOf2iaVG3+UZ8aDQDDR9rCwFx1JylwNiI7N3DWjLWs7K5RASoV/kcNcDM
	VX0NJrr+9+RydYT9gMbTLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778798928; x=
	1778885328; bh=WYXyNu9jFS2CMozBDaVj8gAOuYnAjaysuUfWh3anrxU=; b=M
	rnTAh3HHwypX8HlkOJomT1GQ4MCMl3T4rXEvGIckYglBSk+XdRj+3aZWea4qScpn
	GZAlm+ewKOMPazM30wvXQ95xtcMi/pKXWCZz7I9qChuw3YcSG5T3fQSuI7ymYhTn
	pm1uJ7NUkRcZszyzdLNRk3NFFPx2YXgEevKL4Qe85Ly9RqxtVQtentsbFwU3hYL/
	K29eCXGP80idXwX8Q3u1CHkbSAx0ZtZdk4LdgfJ+JprZF94neTCXtQzKHk3NTrQO
	i/12vnl4Qv6g450h3jaPF0zy86yVWuBuoMJ0Hjo8KA1VTJaThBhnQsfq3QZzge7O
	U9PENf2aO0sWrtzgglocQ==
X-ME-Sender: <xms:T1EGau-ja9FJQlA2Lyuwe_0tySlb9Eljr8RBpTAIyNaJKUcctZWTiA>
    <xme:T1EGakv-cxu63MPlTIGhTC6UdIEZRp68SN2kE_hU-SWtCRZL-vF-iJZs7M_k0Bqr5
    Rd7BX7hty5d45pbJ3XsWszOzVjhb42vFi4fF5Ga0269GNGuKP2mow>
X-ME-Received: <xmr:T1EGau0Qv_HGDiRxQF5FwCaL8u4Pei4tJwey9iIHtnc1KjZebnW7iz880D8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdekjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpeegudevhfejueefveduieeuueeifeettdekveekhffgvdetfeelueehgfdt
    heffhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjrhhhihhlkhgvsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopegumhgrthhlrggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepvhhi
    phhinhhshhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhhgghesnhhvihguihgrrd
    gtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    rghnthhhohhnhidrlhdrnhhguhihvghnsehinhhtvghlrdgtohhmpdhrtghpthhtohepkh
    hvmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghr
    nhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhksh
    gvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:T1EGapQzfXrGY5CbWP8OwImeSoaUhNXC9Sdt7FCtJThwZKgrylzuyw>
    <xmx:T1EGaiewkBF92OSINhhxeZFOPLcl8qgyHgp8tbLPtWFe38pSdPcjZw>
    <xmx:T1EGaqeQShEPVKdIdgNruB2NBi7CnU-H_UTykzI7mHXGmuS0MSOekw>
    <xmx:T1EGas3k933FoQ4AsUcDyCQZilfF85z3Ec-6dD1qaXU3RpbwPsNwiw>
    <xmx:UFEGanophpfIswkozb0M7pqJwJK4UEfJPD4Jd356lZj1ax3IcX8zMOeB>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 May 2026 18:48:46 -0400 (EDT)
Date: Thu, 14 May 2026 16:48:44 -0600
From: Alex Williamson <alex@shazbot.org>
To: Josh Hilke <jrhilke@google.com>
Cc: David Matlack <dmatlack@google.com>, Vipin Sharma <vipinsh@google.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Shuah Khan <shuah@kernel.org>, Tony
 Nguyen <anthony.l.nguyen@intel.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 alex@shazbot.org
Subject: Re: [PATCH] vfio: selftests: Add driver for IGB QEMU device
Message-ID: <20260514164844.2698802c@shazbot.org>
In-Reply-To: <CAAdrzjv7FiYWhXHDJQvK-c71UpKo+uwOu-dnbtka=6p2qj86zQ@mail.gmail.com>
References: <20260511211839.2781731-1-jrhilke@google.com>
	<agJqAO-RRdjMrUZJ@google.com>
	<CAAdrzjtiiOtw7-YL2COgZC-QSFp6LLwq+jP9V3jPKLUe0w7Y0g@mail.gmail.com>
	<CAAdrzjuf3z-CyWeBRPKmMQxmQZ9U=2Tc0cDAFqdRFRDHKw_K-Q@mail.gmail.com>
	<agUKLmKLoV71Hq6S@google.com>
	<20260514102824.6be38bf6@shazbot.org>
	<CAAdrzjv7FiYWhXHDJQvK-c71UpKo+uwOu-dnbtka=6p2qj86zQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 14 May 2026 14:49:28 -0700
Josh Hilke <jrhilke@google.com> wrote:

> On Thu, May 14, 2026 at 9:28=E2=80=AFAM Alex Williamson <alex@shazbot.org=
> wrote:
> >
> > On Wed, 13 May 2026 23:33:02 +0000
> > David Matlack <dmatlack@google.com> wrote:
> > =20
> > > On 2026-05-13 11:49 AM, Josh Hilke wrote: =20
> > > > On Tue, May 12, 2026 at 7:12=E2=80=AFPM Josh Hilke <jrhilke@google.=
com> wrote: =20
> > > > > On Mon, May 11, 2026 at 4:45=E2=80=AFPM David Matlack <dmatlack@g=
oogle.com> wrote: =20
> > > > > > On 2026-05-11 09:18 PM, Josh Hilke wrote: =20
> > > =20
> > > > > > > +     retries =3D 100;
> > > > > > > +     while (retries-- > 0) {
> > > > > > > +             if (rx->wb.status_error & 1)
> > > > > > > +                     break;
> > > > > > > +             usleep(10);
> > > > > > > +     } =20
> > > > > >
> > > > > > Why bail after a certain timeout? The test may have kicked off =
a large
> > > > > > count of memcpys. Is this for error detection? =20
> > > > >
> > > > > The bailout was intended to detect errors during development.
> > > > > Shouldn't need it anymore. I'll remove it in v2. =20
> > > >
> > > > Sorry, I forgot: we need the timeout  to detect DMA errors for the
> > > > memcpy_from_unmapped_iova test in vfio_pci_driver_test. The test
> > > > triggers an IOMMU fault because the IOVA is unmapped, and the IOMMU
> > > > aborts the DMA operation. However, the QEMU IGB implementation does
> > > > not set an error bit, so timing out is our only method for error
> > > > detection. =20
> > >
> > > Hm... that's going to be tricky then. This means we would have to set
> > > the timeout to longer than the longest possible memcpy duration to av=
oid
> > > false negatives? That means we'll have to set the timeout to quite lo=
ng. =20
> >
> > FWIW, I had AI churn on trying to make this work on a physical 82576 as
> > I have several of these in my local machines as sort of the defacto,
> > readily available SR-IOV NIC.  The AI got up to 30/35 tests passing but
> > is currently stuck that the queues stall in the mix-and-match test when
> > it's trying to DMA from an unmapped IOVA.  So far none of the in-band
> > methods to kick the queues seem to work, I'm not sure if we'll need to
> > resort to an FLR.
> >
> > I'd be happy to send the changes it's made so far if you want to
> > validate and incorporate, or have any thoughts to kicking it after the
> > IOMMU fault.  Some of the changes are related to timeouts, where QEMU
> > loopback is actually faster than bare metal since the physical  queues
> > run at 1Gbps even in loopback mode.
> >
> > I'll also plant the seed that if we do have outstanding issues for a
> > driver that binds to a real world device, but only works on the
> > emulated version of that device... how do we handle that?  In part, I
> > think it's emulated in QEMU because it is so ubiquitous.  I'm also
> > hoping to use the same device for the new SR-IOV selftests.  Thanks,
> >
> > Alex =20
>=20
> I'm glad you're interested in this as well!
>=20
> Unfortunately (and ironically) I don't have access to a physical device.
>=20
> Regarding driver support for the real vs. emulated device, I think we
> should prioritize supporting the emulated version. This approach
> unlocks the ability for anyone to run VFIO/Live Update tests without
> needing specific hardware. Once that's done, other folks can add
> patches to update the driver if they want to use the physical device.
> What do you think?
>=20
> I plan to add SR-IOV support to this driver in a separate series after
> the driver merges.

I've got it working now, I'll need to do some cleanup and verification,
but it's not too bad (imo), several places where QEMU emulation only
supports one mode and we don't fully configure the device or don't
account for physical hardware limitations or timing.  The most
significant change is in resolving the issue above, that once the queue
gets wedged from DMA errors, VFIO_DEVICE_RESET unfortunately seems to
be the most straightforward mechanism to get it unstuck.  That may
result in some initialization refactoring and plumbing to restore the
interrupt state. Thanks,

Alex
