Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AED30E0EC;
	Thu, 14 May 2026 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776110; cv=none; b=oEcjstfV8O3T3brkyh2oMWvOFFSMtJDBodsha/zDYvU6+MrjU9ULhE4efXvs58o5/HOebmzKbxb8Z+N8Y8Vuw0qrFarM9LHRU917btINezEG2H4HIGlqHGNIGaBAGctOH1HOdJ0bp42aJMJsnL6+r1/OvpfEgSf8M8nCQOj5Oko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776110; c=relaxed/simple;
	bh=OxcSotoXAgAwPL5og6RYJGOkP0ybODZJGRrCIqcvjvs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oY3XlnR4XJpTJyLTV0rhHe0WsAZ/OqqrgZIitkeH954s+xJfUmHWnkH0+6QUTSKe/puJWSOrDsv7oXfLjJlrZTPIXLgIEsi3BUzm32zb8O8wsT9BWb4/9JqMj9Tu+f5WW+k4L3szTcOu6P10yk3HaQrvABsCJU/tbYRsTWEMVoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=Htqtc9zr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v1f3Rz2L; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="Htqtc9zr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v1f3Rz2L"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 7E19BEC00A2;
	Thu, 14 May 2026 12:28:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 14 May 2026 12:28:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778776106;
	 x=1778862506; bh=SjwBOXM5FIDVm9YpfwN9HdBzg59yznbfkQeW+INIUWk=; b=
	Htqtc9zrcIXJRi4Zbu3GvviqV1zRBA1xKjQx1gSVuk6lAaTOvxqWWuE/cZ0Cm8Y7
	F0abf2p/TXlcwO1UtD+HZ8wPgo/PVgsH4aysMe/pvB7A+lpuu8H4W2ivfNcJSnnf
	C1C7UvCUHijucStaq9Z3NgfOVYK/tb1Ya7sekn4Aquj5pkOVk7+LZqcC1qaT8UZT
	N0/UDo0NvxHMQdHwIqFRqG7CLm7UQ3DLDuNDiaaTPi+RCWGlbD5YIYePVq2LBOVu
	R4R0vNj2/SUNllhEa1cOxBzR8kP3zn5VTjTUhI4W35u38W2HU5tXFj9LpP6DXHZh
	9ReVI/+eXbwqanPKKFaKdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778776106; x=
	1778862506; bh=SjwBOXM5FIDVm9YpfwN9HdBzg59yznbfkQeW+INIUWk=; b=v
	1f3Rz2L3xJgviejRgtHFNSEQoXb4VUJQqQKlouYOPHkjJiCE74/uvOw1RRc99NSz
	0xlkVLxPx4MsK1yyykhTRieOoNpOnJBXWo67+6hlMOsRnfk/mGday62mx/3mSQXr
	yiDMF/ynzKFewNpkXppMMzJGoRwzPDhBgTkPE2dHG8KWuWHpf+Kmpxm+ttgBra9+
	sWG0s/fy8XQneOP9lFfpihwNYXU1GDDx0V9FufcREvb43jvcycxtykB+JmxD+0pL
	kJp1rdLlpN90G2D/C7gEoinOT0Vbjpa1nGXY0/ZeefSy5y8OdjjTTWengTeE+dre
	Yz3MmtGUp4+1tzcM+db0g==
X-ME-Sender: <xms:KvgFano6AcdPjEiL8vQzwGMg1Ct7w6GUQ3x4PEHA5sFN5t7UXXbfwQ>
    <xme:KvgFanr5iWMomHr-X6zqpTfegqxzSOeBdkrDeeXXPvmRQc49Y7aZI1Ta2UKDkl7Rc
    Ec6Q73wcNGSh3fzxvxG-1Moeky4xZtNgF-4YiIfiUQTgAlOycdJFA>
X-ME-Received: <xmr:KvgFavA9G7RTx4yMH9UQw3NWE-BfuIb324_dQp0frGrTMlc9qu8pmfFLkLk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdektddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpeegudevhfejueefveduieeuueeifeettdekveekhffgvdetfeelueehgfdt
    heffhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegumhgrthhlrggtkhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepjhhrhhhilhhkvgesghhoohhglhgvrdgtohhmpdhrtghpthhtohepvhhi
    phhinhhshhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhhgghesnhhvihguihgrrd
    gtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    rghnthhhohhnhidrlhdrnhhguhihvghnsehinhhtvghlrdgtohhmpdhrtghpthhtohepkh
    hvmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghr
    nhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhksh
    gvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:KvgFatsP8ST4CVvUBMSjLB8R0bnpDFr_bTpUrOSeJhjPMaRLvSL4hw>
    <xmx:KvgFamJEQWDuWUURqmIVV5lzNZtzXxmLQg9bHkTEgifFna8HE81Vhw>
    <xmx:KvgFasavCghzIYzAtA3sLfT2LaBVOSlsUX_aqM1J5-khccTxWELxiw>
    <xmx:KvgFagD_Try891aJFIZqhF7y6ba7XB8cF9U4A6wTQWijYedecRAnIg>
    <xmx:KvgFaoGEJrAyVY3yY1io-9iQyGLo7lqrafNuMWehKjwA8NVUNd3uJOOT>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 May 2026 12:28:25 -0400 (EDT)
Date: Thu, 14 May 2026 10:28:24 -0600
From: Alex Williamson <alex@shazbot.org>
To: David Matlack <dmatlack@google.com>, Josh Hilke <jrhilke@google.com>
Cc: Vipin Sharma <vipinsh@google.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Shuah Khan <shuah@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH] vfio: selftests: Add driver for IGB QEMU device
Message-ID: <20260514102824.6be38bf6@shazbot.org>
In-Reply-To: <agUKLmKLoV71Hq6S@google.com>
References: <20260511211839.2781731-1-jrhilke@google.com>
	<agJqAO-RRdjMrUZJ@google.com>
	<CAAdrzjtiiOtw7-YL2COgZC-QSFp6LLwq+jP9V3jPKLUe0w7Y0g@mail.gmail.com>
	<CAAdrzjuf3z-CyWeBRPKmMQxmQZ9U=2Tc0cDAFqdRFRDHKw_K-Q@mail.gmail.com>
	<agUKLmKLoV71Hq6S@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 13 May 2026 23:33:02 +0000
David Matlack <dmatlack@google.com> wrote:

> On 2026-05-13 11:49 AM, Josh Hilke wrote:
> > On Tue, May 12, 2026 at 7:12=E2=80=AFPM Josh Hilke <jrhilke@google.com>=
 wrote: =20
> > > On Mon, May 11, 2026 at 4:45=E2=80=AFPM David Matlack <dmatlack@googl=
e.com> wrote: =20
> > > > On 2026-05-11 09:18 PM, Josh Hilke wrote: =20
>=20
> > > > > +     retries =3D 100;
> > > > > +     while (retries-- > 0) {
> > > > > +             if (rx->wb.status_error & 1)
> > > > > +                     break;
> > > > > +             usleep(10);
> > > > > +     } =20
> > > >
> > > > Why bail after a certain timeout? The test may have kicked off a la=
rge
> > > > count of memcpys. Is this for error detection? =20
> > >
> > > The bailout was intended to detect errors during development.
> > > Shouldn't need it anymore. I'll remove it in v2. =20
> >=20
> > Sorry, I forgot: we need the timeout  to detect DMA errors for the
> > memcpy_from_unmapped_iova test in vfio_pci_driver_test. The test
> > triggers an IOMMU fault because the IOVA is unmapped, and the IOMMU
> > aborts the DMA operation. However, the QEMU IGB implementation does
> > not set an error bit, so timing out is our only method for error
> > detection. =20
>=20
> Hm... that's going to be tricky then. This means we would have to set
> the timeout to longer than the longest possible memcpy duration to avoid
> false negatives? That means we'll have to set the timeout to quite long.

FWIW, I had AI churn on trying to make this work on a physical 82576 as
I have several of these in my local machines as sort of the defacto,
readily available SR-IOV NIC.  The AI got up to 30/35 tests passing but
is currently stuck that the queues stall in the mix-and-match test when
it's trying to DMA from an unmapped IOVA.  So far none of the in-band
methods to kick the queues seem to work, I'm not sure if we'll need to
resort to an FLR.

I'd be happy to send the changes it's made so far if you want to
validate and incorporate, or have any thoughts to kicking it after the
IOMMU fault.  Some of the changes are related to timeouts, where QEMU
loopback is actually faster than bare metal since the physical  queues
run at 1Gbps even in loopback mode.

I'll also plant the seed that if we do have outstanding issues for a
driver that binds to a real world device, but only works on the
emulated version of that device... how do we handle that?  In part, I
think it's emulated in QEMU because it is so ubiquitous.  I'm also
hoping to use the same device for the new SR-IOV selftests.  Thanks,

Alex
