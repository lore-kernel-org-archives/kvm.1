Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795635277;
	b=yGCULuztDF5SNL29hkb1iim0/P/nxvdF6EgyoGZIHZFvnqg70he1NondaiNYBxqwKbmt
	 Aq0Xr6W2q2xWpOcefgqEgEBhoi1t4RP2i7pdigT7Jp0EDy0O6RQwpPglUQybf+gwdUu+8
	 tmCKLfOBpvgKE6YumcrBL7KTyxOyHIfbzo706l6SCOcWVO5yh2zdv0gYjHGqI7otP6Ocv
	 2qeovCDTcrOfN6++aVlBYQF+oLzgL/kIZ2lUnhR4kSg9FTSn2ZzURPEKveI0Sk2RM9+oq
	 QfATcgpPYDKLZnkGTllY/I1lfAkcIKeIz/VdvoS4StuWpBgSoaLMT1YNCc8gQx0y2Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795635277;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=MIOa4TwnHJhvDD27WYszz+v5GjQAKjHUzkW+9+PMOZY=;
	b=Iawxm/wkZt5wR65ZNZKHiZG3XLGfhQbv9ieRu1bi1MU3hZLgOEyk2E/PmaJGUPIlafvi
	 hoUgnSXgb5aNhZmbCF72AH1uF9sKR3ivdzULOA8K3DrwMRgjckMMeleC6RbAPsBFHCG9n
	 iPU+snVyacoRVqtiHXQQ2O3StK2Cn5iu8YsGG3JE/DeNvHjcJoLwn+2hwdcUG5aXPTIYC
	 9z/cgoE4B8IckM8VsQp8wOnxG+2lt9nUm4zfM7+5uzx8P//sIrdBynx2xWY06Ksag0oL7
	 Dm6CjOZIvUoYUibir9K8ua7gpILRx76e5TMS6gLPYFDezdVVA28WxwgjuBJPQu8hpzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=pass header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=EtlKUcey;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=m5zyADdU;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5D1606A31E
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 19:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F5D1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=EtlKUcey;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=m5zyADdU
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8FB7B7A0555
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 14:34:35 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 25 Nov 2026 14:34:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795635275;
	 x=1795721675; bh=MIOa4TwnHJhvDD27WYszz+v5GjQAKjHUzkW+9+PMOZY=; b=
	EtlKUceyYMpLSBKNfn4aeaqNlIXXbOfNHQ8D549bAaISW6qpdu3zzkOpeQ0O7yXK
	B5elnsmiN0SYInonTlbYHByY+9J01DFET24ykNaWv5qQSrw9hYvhmLrrZcJiV3Hf
	sTgqjxjWzyftud0R3ajNjQsshg2f3ZELqbL5DlbUyby4geM7sRI0xyFxcXulXRKn
	JbjxibfztvyUfngS6xtDmzKINLebR6ewfYzI2gE2JABUCuBg40XLl7ps+ZieUdpY
	C+bqREZQctUYBWH0bKAhFT5+zShlmbfbnPdH0o4Ks9Ml5oWBZ6Qw7P/3kWEivS0h
	vXQsiZpCckiO3v+o8w+DLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795635275; x=
	1795721675; bh=MIOa4TwnHJhvDD27WYszz+v5GjQAKjHUzkW+9+PMOZY=; b=m
	5zyADdUn+lGJd/2ajV8NFohEIt56Njd91YNgODUICfFAvWI7OlwU9oaDASJJjhAx
	+U6IyOIRZGsHdlvIBVpuYKvqC6S9B0uA4/6MrMxLnEjhI8WHIfjJipEqmkieTNmo
	ZLK8sdDok9yT6gF2uq4zGVzfKTP22VnFFW8c2YMkCvItGkHxbaiHNplbYMUcl7T7
	hPAG3lFdt++ynq+3boOKPkoplBfsOJvStB/OrwfXsrc4tvmrWrgvEW07zZ+aiE/F
	Bl2VdoYeSL/V1X+KLi42arGcYfdAEf9UTOjBVnMfVhiE2Yq3fLDIEzebWWqFC7Ym
	gBom4ezan1npuxOMW4nUw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795635275; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+; rt=PGt2bUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:hskw/TOc6hGXVOyUkoh5rMMgAJoAfeFdLRmc1f08gMbosMZ
	6f/E1gIvTRtiNxuHhKjKnJBEdlyN+2+XKeQOiAyM1woLLOyVfM3HUAJlJkkPxDBM
	MwBMiGxTVOiScEwczG3pceXnDKkSrFLOf2k9JTpG8/vtTDaMw32N5y+C8nzoevjc
	g2sD+iMfoQkAC9fpZkBTjnEYYmazLuikgssBFebVVxXzZLEuB/sctxXZ5e0UIsoN
	6y8SEnebK3n4FmC+WH6NuYekRxPRBU21CU5dmXDOM9bODx6UJl9bZ75cM0JD8ClO
	Dz3io8cLUU20lvZZdyQBx0M+U0BbCN1hKPGE83w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:9xDcrofUdOsg7A2oEWiniyU8nr94TDQT2Zz7VwSioH0=:zd49XZNr+HxBxgHM/VP4Ujh4xwBvsMKzC4k3nsTaESc=;
X-ME-Sender: <xms:SjgHa4w7EX7ML4zBRU7YsMQWt9-HKd1DUXycelpDkO5ouqHVWgMkBg>
    <xme:SjgHazIJE5FVhFxKDDCazawJzEEMl00KYuR1wT4Q9rjF1qBZ0jW4ONGg-y-rVqw7p
    qoBE5419dZxbpMq-zvWmNgYyc18KBDNsCDulPG1rErK2d4z8EGjBf0>
X-ME-Received: <xmr:SjgHayppiFh8YeIj-RpD1RZ799EQ9v0dwecS82gcSu_6AHmN1vCkjug9CGe0Cw>
X-ME-Proxy-Cause: dmFkZTFFHlFVOyQia1FWU2yPzedHYe34k5hqXOTLX4loQ90yHIw1C9uxTNqWHB3C2WXPMX
    Rch6ioa3tN5k/1KTmxK7UgWBX3ovRask2GCUHOMTFF+zhf1YYlAkljTbkDUA7voGnvbMD0
    gO3N1xZ+AQbqt+F/oc8bOWutpsP+vT1NOenPpijVK/4M7a79EX9Tg+uIa1bQ8q+Yij3XYV
    NjYt4C9MPHdgFaIgtxABEiGicioYWvK7gcWi6Wg31tkpjCl68XJc+6H2i6/RRMG/fCqvVP
    jY/EgUIp+h4gUyr9Aa0hwl4IxW32q5EmJUT4OErHBT1CWeNOzIvdkfaaZ6Fch2OcHj11F6
    b/GsH6644xWOoi/o+4+m3anbo/R8C0qwhn1PsnS72ad1Zxm0UfuADOneqh1n0V4H0lVOVK
    zeFcUiXOVCp/EVVBNKywUbzVbkBdKyrXDrEU7G5D6w7aJWGkwGqBfaXly1uv3Em0PYzeJg
    B+pUHuipE/o6odgx7EqtlotN887Kxcpsu5yfhWRQcbcABYXAA/qZjs141H2NE2NSmRv/iC
    6kx2O0qQn/E4obxyohL5gkOnKuox2wDpsZ422Grr28d3tggqule4ZxHPYyr8ZDfp3n4Xuz
    XSaeAC6T/fM1RUllv9B0r4yh+pY51XZMx8lsVUqgaIlrV7zrzO7lp5ijKaGw
X-ME-Proxy: <xmx:SjgHayKt6STA6PDK1UekRnpnlphS2l1hG-fWg0DzO8w5hZgVLFVqNQ>
    <xmx:SjgHa3QAefUciZ1Aj7QnS8ji4Y4FUvqI-4quqPE6xbokHWbdwoQz1g>
    <xmx:SjgHaxvD2UGKQLFO81iOFeYHdp1-N6oB27uHEQbD26A-rBC4GZWSig>
    <xmx:SjgHa4acH0x1qAGGP3cuqz4yxH7XFG-9-pHJJ-kuIY2uKDzgJWiz4Q>
    <xmx:SzgHa_lZvL0UMzqiZsVsRKYuCgzO-1lb-SWiluEOH-rBdg0ZaWAQmYow>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 14:34:34 -0500 (EST)
Date: Wed, 25 Nov 2026 12:34:32 -0700
From: Alex Williamson <alex@shazbot.org>
To: Aaron Lewis <aaronlewis@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, kvm@vger.kernel.org,
 dmatlack@google.com, alex@shazbot.org
Subject: Re: [PATCH 0/3] vfio/type1: Fix pin leaks for reserved GUP-pinned
 pages
Message-ID: <20261125123432.353f392d@shazbot.org>
In-Reply-To: <CAAAPnDH=qUXK+Lv75=Ra3XJ-KO++9XX+VYNjxHSQA=qM1d9_Mg@mail.gmail.com>
References: <20261119185659.889654-1-aaronlewis@google.com>
	<20261119202713.GU2245175@nvidia.com>
	<CAAAPnDH=qUXK+Lv75=Ra3XJ-KO++9XX+VYNjxHSQA=qM1d9_Mg@mail.gmail.com>
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

On Fri, 20 Nov 2026 08:59:04 -0800
Aaron Lewis <aaronlewis@google.com> wrote:

> On Thu, Nov 19, 2026 at 12:27=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com>=
 wrote:
> >
> > On Thu, Nov 19, 2026 at 06:56:56PM +0000, Aaron Lewis wrote: =20
> > > vfio/type1 uses PageReserved(), via is_invalid_reserved_pfn(), to gue=
ss
> > > whether a pfn was GUP-pinned or came from a VM_PFNMAP mapping. Reserv=
ed
> > > pfns are assumed to be PFNMAP, so they are not accounted in locked_vm
> > > and are never unpinned. =20
> >
> > Please just use iommufd if you are running into real cases where this
> > doesn't work right :\
> >
> > Jason =20
>=20
> Is there any appetite to at least take patches 1 & 2? Patch 2 fixes a
> real problem with DMA mapping/unmapping where DevDax pages are properly
> refcounted during DMA mapping, but leaked during DMA unmapping. It
> fixes that by tracking whether pages were GUP-pinned or PFNMAP'd, so
> unmapping has the context to do the right thing rather than relying on
> a heuristic that makes its best guess.

While I would endorse using iommufd rather than type1, I don't think we
can entirely write it off for bug fixes yet.

Are you only suggesting 1 & 2 because the RLIMIT enforcement is user
visible in 3?  I'd tend to think we should consider them all, they're
real fixes, even if the usage scope is pretty narrow, currently.

More reviews would of course be welcome.  Thanks,

Alex
