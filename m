Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.142
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794684261;
	b=NTblonRXLCizcuAJRRtqtAwsyZ4NXlwIbz64t18WiCCnPWb88p4U7wwOHVuo/XOf+Y03
	 SoocWohSRsoptt+R/F6mWA5X30olyltEo/zQfbV4CZzfEuxKLtIUlCkHTQTLQoknQF+0i
	 2vscZBiyxEJfMiCsq5QGc3D21Ary+yue5NJU3KLILWr0e1Tpk09exA6Ey9MoZqTbWs45S
	 0U9i852SD8p9L1noFUpieJVbKfF30oLiJ5v/xaQ5oQ3Aymv+gdTRhGeb43JJa84erOyzP
	 j3Kumk1gSv7o+cpakjbmyPv2/K9FsHjPJSWqP6+jDz8Y26b5ILSi3ex8aZuVASkNz7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794684261;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=yvFXCPgCAoParutaFstLpAH76pHHtuAw39SrsRYAS7o=;
	b=aX2RQFQRpsLc4aUs6G9MNn2nUi5bkmRFAKfBNuILp8ZRgxyvRlcAvplvqngWE6Y+oLDQ
	 2WD+FJ6NkbOp1RvewCC6a4I7YhpSx6AqeelnvjoH5cYx+yFg1HgMzsbzlLb7i7ae3YNLZ
	 nHk8u8YiSpaqjTo2lxNxAKEPhjqDB84S27PFtLL9YO1Si21mARg+YD2xSO1P5S3pKoNuD
	 i+IFTLVwlbKmwzxlEUyCZDH/QH1Xryl6l9hPCSBIQKMmLU3641creOtrA3VSP8oZfZhzk
	 X0gj8EbWB+3/9Qi7d0rL/XUzl5jI1UQuVUYrIkQIEcgtroieOjla4vgAvK2WdzCCW0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=pass header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=vcLoqtxq;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hLKCtxgl;
	arc=none smtp.remote-ip=202.12.124.142
Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5E5606A327
	for <kvm@vger.kernel.org>; Sat, 14 Nov 2026 19:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F5E5606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=vcLoqtxq;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hLKCtxgl
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 311E91302A33
	for <kvm@vger.kernel.org>; Sat, 14 Nov 2026 14:24:19 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sat, 14 Nov 2026 14:24:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794684258;
	 x=1794691458; bh=yvFXCPgCAoParutaFstLpAH76pHHtuAw39SrsRYAS7o=; b=
	vcLoqtxqRBeSBh6yz+pb85KZdGSCFRYFeqTbHzgN2g98oS4mfLdD+6VksvdlWT82
	mg8DSQ4gswXmVN29c/bFxNnb0vFIzJ9PCCnOZ+iEL1KwQgHyiJWyGyP5EL7lxqLM
	D1Z7dBSg5XYNgbmivlbGwVbZ5ztwXces9EjBU9aLVUv/Q8cl8K0OMjszVBv3IKoq
	fLHVkWVS4vJEp8TyywzIEXKAtSSQ9mFnM9Usw1EAOSkqL22+n2Rnjw9Uik5InjXF
	ZN5r6wDYsubhP4vScK7KgbapZmuCvyYeye5mCr4xPVIiTIALhOu8a3faG0shOHwx
	/epNQGHQqF4dZeFL1KG2PQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794684258; x=
	1794691458; bh=yvFXCPgCAoParutaFstLpAH76pHHtuAw39SrsRYAS7o=; b=h
	LKCtxglN1Wb/yjAwOzDgvR+3yUCfUBoE3jlJFIDNOtloZbAnPEFzP/BpOwBVqHrb
	JRtPOUTjt0ogK5l8zpnbkWUmVd0uUcf/Nxvm6kBYkxKtf6AsEaEMJE2Yw+yT1DeQ
	5gkUaiVHvPiL8bNqRVCjTCN+8N15eEHBZVRliGhpmNImqR6Tmrngk0gUHbFQPlSb
	0jrUJzl46MTLJtYqMu2rtxDOdPnAvS5vpKmMVbYyNk4TmNQA7hTIQQ9LAqyHSS2d
	KYlIVczJDZo9ZONzROCFNI4sT+bbhcDVS935nVu3P+c19aDIhLa0AJdv/U1HrcCS
	G0I3kKqpCf1NgTYRL7sfA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794684258; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+; rt=PGt2bUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:SiMvSpqhBQx1930qrhIX+arppIOP1D766W6x+hu0fQ3JbH0
	Ntxed4g4El9dk9PHxp7kZu56WDlRDzplW2nVz4sd+4nPBq2lphyfx/65ylS4kvYo
	eUr8B87w3mj+1pji0TA52v+fIpaE+cw7br9IhG1mOUvUCeaHebtsKH8bK+af97hp
	RNQZoDHGC+gYet+y86+MQb06sZjd5kF3riqlmDUukVW3m6zwr1UDlKgytoNvDpu4
	T1IrOrl9mqw1KieztaoU/dgGQosUZBKZs+tn+SHyJQjycxod6OxPnXGkqdF7MbNV
	E3KCY15UqeThGzdis1bPMNjL5v714S96J/8ymvA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Ddgp35+deYgPjeBp6+WU4uaGwW7rAFSB1e90u0WpSVo=:qFTiOKytmbXbuq+/ojEO5pMyhdRgxCuiM0+UxKDxfgY=;
X-ME-Sender: <xms:YrX4ah2fTfTxm02cvqpivHNXmJtgTtCtWgUoz-egjx0ax4NjE2Kt4A>
    <xme:YrX4avjEjkj1uZxMBaCd0S6YGt5HFcd0rlTQAZ9BlzhyIh_oTC8x7DaC8XCDJsQas
    oDQMGNkXN67Dx_AdrkTUrpwmIq6l1DMYueOC1-FaRqvhJCsbjVBIuY>
X-ME-Received: <xmr:YrX4avS13gLZSq25NHBoSr8yyd_Swm6GodXin7D8XLoQUoPVE4rOJs-c2YOPmg>
X-ME-Proxy-Cause: dmFkZTFsWN6qLkPRJVSLWeiMGhpmNdkikqfNwAs7pltHEzO44B/AYHvu+mBJXMvUKwthwX
    WAwCv9sTnn223q5FeUtWkhT4zD5yGLMHLKn2hP2tSLp97/p1kJPBR2GwG/RYC++XnVq1gB
    VvelTJQsGkGEFEVOPGtgJfgGT4u3ZQXCp5DeV6TwW4K5Ftgx5TI+np8sEKnoOipd9Qckz9
    GFCePDc548z3Y8lVbgiZuD+vui054tQbUGcAru0JKxTF2Z/H6DMpGPPvIBtgxOZ0Af7sys
    CSOTZ/Qm4dxqZX915ouNor6p3lXKPNR0g7Zy73eOpYLp8ijf6Q+92EPWIxhQabvEy52jc8
    92r0ejyjLvfinrw2olYwa7Z6QNDTXlAdG8WAMNPDvJKrfeUH5XoCq3+gxuvn7QL3qnALfO
    B+yJJx0p3jkbHY5f9ZR3GK5ppjX//el4E4RtKKAQXo+ZEgDbLGm6T9cUJqwKcrpHZp1Z0u
    AUT+W/oHxf6yOv4ARiZX3Ts4UwlVD9QcoF+aqNhDIi+mJtRAQij7kmw08AKn8WQY+J1dGT
    X48zlUwl04V3VZzx1IE71qu+56+QSml0Y2Jo+e819QSZMtcgzHuZgjP+XFlp0GI/a7nxnY
    vqUYGSuOqHKwVw7WhfLAdxBvgJ8kUwpunGFHCr7piEBAOIoSK9rjhuIVGakA
X-ME-Proxy: <xmx:YrX4aog0B46ljQk-UNg9YdCDPYiBcudUPOar3rAt4-Z1UTHfCcnklw>
    <xmx:YrX4an4JBbqAhMRAvQACCzTEmtsMN-C-UwwCffJsCrNXJF7Uta1Dqw>
    <xmx:YrX4atC_ZckFoQXZ7y4p4JjwuQEW9K9ad9xFLyk6F-SROYBxxIC4fA>
    <xmx:YrX4amaVOsw3InP4NWwoTpyVqIXK40xrCk3bd_KNw7qlfJtjTLpfmQ>
    <xmx:YrX4ajUZc-l5Q6U9NRQ-mpGplpEeIOaMf7-hLsPE_a8JxQyLWknUT2Dn>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Nov 2026 14:24:17 -0500 (EST)
Date: Sat, 14 Nov 2026 12:24:14 -0700
From: Alex Williamson <alex@shazbot.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v2 1/2] vfio/pci: fall back to platform ROM when
 pci_map_rom() fails
Message-ID: <20261114122414.788bc88c@shazbot.org>
In-Reply-To: <20261111055054-mutt-send-email-mst@kernel.org>
References: <c5d91752c7bbd40d89f5fce5da8582f1673cdfc3.1792566536.git.mst@redhat.com>
	<20261110165221.7fb75f91@shazbot.org>
	<20261111055054-mutt-send-email-mst@kernel.org>
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

On Wed, 11 Nov 2026 06:02:35 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Nov 10, 2026 at 04:52:21PM -0700, Alex Williamson wrote:
> > On Wed, 21 Oct 2026 04:20:32 -0400
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >  =20
> > > When pci_resource_start() returns non-zero but pci_map_rom() fails
> > > (ROM BAR exists but content is unreadable), the pdev->rom fallback
> > > is unreachable because it's behind an else-if that only triggers
> > > when pci_resource_start() is zero.
> > >=20
> > > Try pdev->rom whenever the ROM BAR didn't produce a mapping, in both
> > > the region info ioctl and the read path. =20
> >=20
> > Here's the crazy thing, users actually update firmware through
> > vfio-pci.  Therefore, what's an invalid ROM image on one check, may be
> > a valid ROM image next round.  If we fall through to a different ROM
> > provider, we might actually be presenting a changing view of the
> > device. =20
>=20
>=20
> This is out of spec anyway. The spec is pretty clear that _ROM if
> present takes precedence over the ROM BAR.  I decided not to change that
> if ROM BAR is valid to reduce the chance of breaking a working setup.
>=20
> From ACPI 6.3, Section A.3.3 "_ROM (Get ROM Data)", page 1123:
>=20
> 	If _ROM is present, it is preferred over the image read through the
> 	standard PCI interface, in order to allow platform runtime firmware to
> 	provide re-configured ROM data via the method.
>=20
>=20
> Would you like me to simply implement the spec? Use _ROM if there
> even if pci rom bar is valid?

The spec goes on to state:

	This method is defined to provide this data as motherboard
	devices typically don=E2=80=99t have a dedicated option ROM.

Your use case falls within the guidance and fits within our existing
fall through model to look for alternate options only if the ROM BAR is
not present or mapped.

A "preference" is also not a mandate that we need to virtualize _ROM as
a ROM BAR.  We fall through to other sources for convenience.  A
cleaner approach might be to expose _ROM as a device specific region
(same with pdev->rom), allowing the VMM to decide how to expose it,
virtualizing the ROM BAR, a BIOS ROM slot, or ACPI _ROM method.

It seems a bit overkill to implement that though when the example
device we're enabling and the spec, both favor that the ROM BAR is
likely not present.  The fall through seems the more conservative
approach that also handles every known case.

> > I believe this is why we intentionally always report the physical ROM
> > BAR when present and mapped, regardless of the contents. =20
>=20
> No such setups should have _ROM, since rombar would then be ignored.
>=20
> > QEMU, of course, has the ability to take the ROM as a file and override
> > whatever is provided through the kernel interface.  This is how I had
> > previously made use of a secondary GPU on a laptop, dumping the ACPI
> > ROM to a file to provide directly to QEMU. =20
>=20
> First we need a way to get the ROM from _ROM.
>=20
> >=20
> > Does your GPU support a ROM BAR?  The v1 patch didn't have this and
> > would have exposed the physical RAM BAR if present, so I'm guessing not.
> > Thanks,
> >=20
> > Alex =20
>=20
> It has a bar but it is not accessible. _ROM overrides that, as per spec, =
and this
> appears to be how nvidia drivers use it and expect to use it.

Without an example where we have both a programmed ROM BAR and a _ROM
method, I'm not inclined to risk changing from one ROM image to another
for existing users.  Allowing the VMM to pick a policy probably means
exposing _ROM via a device specific region.  Thanks,

Alex
