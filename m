Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261AC2D94BA;
	Thu, 12 Mar 2026 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327551; cv=none; b=kQwBJWmUHbMCZD2DtuTipzokCU+SFwBbgzKUvgCVXcLnl4jnF2xFGQ7HCFjp17hbROzQJu17tKf3wwtUVKB1EAwLyitZR8QAkmdK9CA79SonCgUR9IT8TKUb7tkqyk8mjRWI9f5KLC+2OaSOoSVJYi7WErXDqwrwq8SOitSIAeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327551; c=relaxed/simple;
	bh=EuyUo1TKcXFtyurHlAgiSuSwLwCNan0tiL+7LSJo2Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kIUAXfXewAMHjdh/C62fULNq8GBRtCQiqkedglcq+v5iQWaBBQjBXAb4nVGT/PlQFVmW7mzDSbFiUVCdTDia1cGCvyneUBu1lHjj5TTInTmLlT0HAB0VE9zMb/x8vX7hQhsbk0IoLfv0F0hrYBLIO2ppONXTcglRnT1v2/JuyiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=MeXXEUjo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A7vuiihh; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="MeXXEUjo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A7vuiihh"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 13070EC05D2;
	Thu, 12 Mar 2026 10:59:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 12 Mar 2026 10:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773327548;
	 x=1773413948; bh=A7F7+y6YD+3PKjRpmzyhyLPjW9mm6E0QhfopTYFQlZM=; b=
	MeXXEUjoLJOFjGonov/f67VpKENvPSN+pc2m1U0FxThEXVDvBInh8ACEzz+K+xaY
	rupSVJMKzM1x3QYrsZ1RkA0YkSB/UwDFzR+EoXb7VNHuiO6XKMUlUGYGBfPcZ7KH
	167ZREC2r9xcZXupyPJ7VMflyaaLtkLLgppkW1c8ncI3CeJ3lBI7OONpuIzawCm0
	6EE6Rke90LrJiUJyR6A4Le3z9om0uoFU6UQJ+1zZWNiobC44nd+YCnmjHRQ3noec
	xngry662V5miss+n9L4EbqMsJzzA8mak3hzqYuzQssT3Igmd6/yHJjiPh1WNHZiZ
	xLGl9y39GJiclzPfJ+ZwtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773327548; x=
	1773413948; bh=A7F7+y6YD+3PKjRpmzyhyLPjW9mm6E0QhfopTYFQlZM=; b=A
	7vuiihhR0wBA6uxRH92WMQ7bEvxDxkCakmE05irmCtrOEpMR67S+S3TkPuwjhtCt
	mnCvlSwpdcv8+wbKiz5yD9Sm02NsD6Y3nRXCFjvpHPbmP+hcgdHC2lmvvXjO37Mv
	8QE3Abmc9nxbKFIbRDUNN98yqMOM7ean19SH9ZW4XeZXoZv/mi+tuKOGSg7JJTC8
	6VhBQgwlWSWB8Yrbo6YyTAX5QOc7JOZF5g8BlKoh94mjxlM0xloZE92CZ63VB/nB
	gHf5pPKBBVDUNXz8Ij6Sxnsi6nVWxbjntwhHnNBwQMr7W59Or3kHQNE+9zJ/GlM0
	ITPVr8iq3NknWZH5MIaYQ==
X-ME-Sender: <xms:u9SyabiJBgkhOThNNRpCUca151Xth747-aq7Y8NMaHQqBj_nZTvmpg>
    <xme:u9SyadM6pG3f4ClPBY9oNOlNoEDIgd1593Pl44wkAkrcK9BBTR2gg61Jhnfu4Q_pc
    2nTzC3fPoGMFFk3ZMWy6fGgjnX2BV0tSKLVHLBRhWwtn7klmtLKPg>
X-ME-Received: <xmr:u9SyaecltY-_1Kgeld4e_HMYh7irZYuqrXbMZhkoYsLUfQ4oLBl8-BxTu5s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejtdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpeefkeelffehieetuedvhedvgeevieffiefhgeeivdegkeekvdefgeehjeeg
    ieefteenucffohhmrghinhepnhhvihguihgrrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhg
    pdhnsggprhgtphhtthhopedugedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprg
    hnkhhithgrsehnvhhiughirgdrtghomhdprhgtphhtthhopehjghhgsehnvhhiughirgdr
    tghomhdprhgtphhtthhopehvshgvthhhihesnhhvihguihgrrdgtohhmpdhrtghpthhtoh
    epmhhotghhshesnhhvihguihgrrdgtohhmpdhrtghpthhtohepjhhgghesiihivghpvgdr
    tggrpdhrtghpthhtohepshhkohhlohhthhhumhhthhhosehnvhhiughirgdrtghomhdprh
    gtphhtthhopegtjhhirgesnhhvihguihgrrdgtohhmpdhrtghpthhtohepiihhihifsehn
    vhhiughirgdrtghomhdprhgtphhtthhopehkjhgrjhhusehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:u9SyaXzsQNFgnP7U-rg8QRtIQyoiQQmyD7qVcHPkF6cQ6GHqlQZlGQ>
    <xmx:u9SyaT2s59kYcfpRyqXJB8gMClrSFttl-uu7h3-OPthEbtdqxza4Ig>
    <xmx:u9Syaeejf9vrdSqWDf8oKb5bv6yGOVFQmm0Cjh27sDiE0RfJWCJ9IQ>
    <xmx:u9SyaYXkSdDANuwym1xq-yL6OOcgCjBhpu1XGWqU_8ThvHCGKB8aqg>
    <xmx:vNSyaf_vEsTB4s2whIHZlPS1NHsn0zeAEgnnqevbh0yaH1dyTAklDFQf>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 10:59:06 -0400 (EDT)
Date: Thu, 12 Mar 2026 08:59:04 -0600
From: Alex Williamson <alex@shazbot.org>
To: Ankit Agrawal <ankita@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Matt
 Ochs <mochs@nvidia.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, Shameer Kolothum
 Thodi <skolothumtho@nvidia.com>, Neo Jia <cjia@nvidia.com>, Zhi Wang
 <zhiw@nvidia.com>, Krishnakant Jaju <kjaju@nvidia.com>, Yishai Hadas
 <yishaih@nvidia.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH RFC v2 00/15] Add virtualization support for EGM
Message-ID: <20260312085904.42a98f16@shazbot.org>
In-Reply-To: <SA1PR12MB7199673D9DE79C11DB6B9E33B044A@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20260223155514.152435-1-ankita@nvidia.com>
	<20260305103335.74fb8141@shazbot.org>
	<SA1PR12MB719904F9ED153FF4BA4EFA28B047A@SA1PR12MB7199.namprd12.prod.outlook.com>
	<20260311143706.2095a547@shazbot.org>
	<SA1PR12MB7199673D9DE79C11DB6B9E33B044A@SA1PR12MB7199.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Mar 2026 13:51:20 +0000
Ankit Agrawal <ankita@nvidia.com> wrote:

> >> > nvgrace-gpu is manipulating sysfs
> >> > on devices owned by nvgrace-egm, we don't have mechanisms to manage =
the
> >> > aux device relative to the state of the GPU, we're trying to add a
> >> > driver that can bind to device created by an out-of-tree driver, and
> >> > we're inventing new uAPIs on the chardev for things that already exi=
st
> >> > for vfio regions. =20
> >>
> >> Sorry for the confusion. The nvgrace-egm would not bind to the device
> >> created by the out-of-tree driver. We would have a separate out-of-tree
> >> equivalent of nvgrace-egm to bind to the device by the out-of-tree vfio
> >> driver. Maybe we can consider exposing a register/unregister APIs from
> >> nvgrace-egm where a module (in-tree nvgrace / out-of-tree) can register
> >> a pdev and nvgrace-egm can use to fetch the region info. =20
> >
> > Ok, this wasn't clear to me, but does that also mean that if some GPUs
> > are managed by nvgrace-gpu and others by out-of-tree drivers that the
> > in-kernel and out-of-tree equivalent drivers are both installing
> > chardevs as /dev/egmXX?=C2=A0 Playing in the same space is ugly, but wh=
at
> > happens when the 2 GPUs per socket are split between drivers and they
> > both try to added the same chardev? =20
>=20
> But that would be an unsupported configuration. It is expected that all t=
he
> GPUs on the system and the EGM char devices to be attached to the same
> VM for full functionality. So either all the devices (GPU and EGM chardev)
> would be bound to nvgrace or to the out-of-tree module. Please refer sec =
8.1
> https://docs.nvidia.com/multi-node-nvlink-systems/partition-guide-v1-2.pdf
> Perhaps I should add this information in the commit message.

Just because it can be documented as a policy doesn't make it an
agreeable architecture.

> > However, I'd then ask the question why we're associating EGM to the GPU
> > PCI driver at all.=C2=A0 For instance, why should nvgrace-gpu spawn aux
> > devices to feed into an nvgrace-egm driver, and duplicate that whole
> > thing in an out-of-tree driver, when we could just have one in-kernel
> > platform(?) driver walk ACPI, find these ranges, and expose them as
> > chardev entirely independent of the PCI driver bound to the GPU? =20
>=20
> So a new platform driver to walk through the ACPI and look for EGM proper=
ties
> and create EGM char devs?=20
>=20
> Maybe it is okay, but given that all the 4 EGM properties are under the G=
PU's
> ACPI node and there being no independent ACPI _HID device identity, it so=
unds
> a bit off to me. Do we have a precedent like that?
>=20
> But as I mentioned above, the expectation is that the EGM devices and the=
 GPU
> devices to be assigned to the same VM. So would it not make sense that we
> keep the association between the EGM devices and the GPU devices?

You're telling me that the EGM access is 100% independent of any state
related to the GPU, so why would we tie the lifecycle of these aux
devices to any particular driver for the GPU or re-implement it across
multiple drivers?  That doesn't make sense to me.  Thanks,

Alex
