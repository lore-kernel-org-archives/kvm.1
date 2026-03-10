Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74D02D877D
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 16:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773158413; cv=none; b=p61th7WKlL/A3rPRWY4hjrbtEwCXuhxveV9nlWEBOgPBpLTyOm65c9XCp3RKhEqe5i0cyG7khEXVm9VKCNQH7yEg8TWNysgVr2WGgLVjVw6o37clPnclfE6hZdoZA+NYXp7633zsEJBOpnyuauU6C739qEwjlMeQl2oqNQSN6t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773158413; c=relaxed/simple;
	bh=ZtT2SLzKOvoxNfyDZW7Truzlzjzxr0fLHKvNCDOCQ1M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RxH/6byxYR2OM1gDtTDphHuhr2dPwyNQREdpAEvgwnS58rXcnQTa0OdQvkX2NLETNLeBzunmUoSSHnIaFg3iMgDMlbyMcw6FeRKk5qyT7Ce52zknVsoFVQbcqJYFlQndV9IPbfeBiMSM3DYbRhpCXJ3LAGKyxEykY/mZR66+G3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=WfzbtlX7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IqwemPEe; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="WfzbtlX7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IqwemPEe"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0EBB61400245;
	Tue, 10 Mar 2026 12:00:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 10 Mar 2026 12:00:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773158410;
	 x=1773244810; bh=xOammVkKshTPOzAw9LVYlw5z1M5wX3MbriBvgw3YkSk=; b=
	WfzbtlX75ghWVfq/D/8icCMVQN4UFBnqd9NTtwgvZ3XHjrRWPVpIjhmfEG6wrBap
	etx/XrI+5WGroFGex87iH3bijK0LjyCSFY1lUxg6ciQOJFb4r7ZHIrziTkPA1AtN
	ncmmIJF33Q5A3w6qbvwPFrwtJ77jDlbA6LDg91y1fhArsZf7dWKoZ9xu/mHOpJH1
	NeB1TNE/yXir8BBJTIUL+0IySRg6zcxY/Rk+pQgPH5Xt3kjwgNPgXhxFqkoNFBMI
	kFCyPi8UJbfToPXaF07YEAG5CKNlSPgMzgZu0Ocn8yUdtdeo0Nj/yMJHBZR0s5vY
	fX3HDGd9PLkBIwy+W/8Mgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773158410; x=
	1773244810; bh=xOammVkKshTPOzAw9LVYlw5z1M5wX3MbriBvgw3YkSk=; b=I
	qwemPEetD1jWZ0jw87qR18UEV2e4nBIm6Ohj5v0RaiNmAQKL4Swz6URZDoZLo1di
	jlxV2z0qg1Aps0TMdq1CyKn1JH9Sar4sMopEyeJg+5+4cxnHaTUC5syfAxKKdLmk
	DtaifQ9yRS9gNsiisWdQMjkekg3mk1UVwIgRTLn0rUFxQxUVZ/dUwJAJj4NT6oRg
	FduEsi5gDnztmVjR/jqRoICM8CbBkbimPjWdmY5gsZpky/VMsveKEWmrJi1x2tpF
	ZclY4Pxc4qncfoX4rv13OnGmVvX6JULqUvm1+zxoCnjTD0YHqKMq9saBKf41cYR1
	ECvfBY7o8Tt814bLiqCPA==
X-ME-Sender: <xms:CUCwab9WXG5N75IJt-HbojdpA2GFS-LcPTcFfDr2aBH6ca7MdVu0AA>
    <xme:CUCwabZ8GiukMX_mqr18-P5mWS8Qw5dFfuV3sm3_sEPrFuRSg8foaLoAuPPrm8aQe
    wlYgQbg1FDjLBxRdIfzUFrXR5oMs6ScOX84hU_EmpmuTmJDRWRi-Q>
X-ME-Received: <xmr:CUCwaRrrkbk9u5ihlqurehtdiM7pyw2A-fxbJQ66nZyovX8Jaq8XsqqXgFM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedugeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpeegudevhfejueefveduieeuueeifeettdekveekhffgvdetfeelueehgfdt
    heffhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepudegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopeihihhshhgrihhhsehnvhhiughirgdrtghomhdprh
    gtphhtthhopegtlhhgsehrvgguhhgrthdrtghomhdprhgtphhtthhopehpvghtvghrgies
    rhgvughhrghtrdgtohhmpdhrtghpthhtohepjhhgghesnhhvihguihgrrdgtohhmpdhrtg
    hpthhtohepkhhvmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghv
    ihhnrdhtihgrnhesihhnthgvlhdrtghomhdprhgtphhtthhopehjohgrohdrmhdrmhgrrh
    htihhnshesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheplhgvohhnrhhosehnvhhiughi
    rgdrtghomhdprhgtphhtthhopehmrghorhhgsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:CUCwaY290pS1Wh09GFJJJ_pqp-Nvf2R_5DYH5Bb6UlDdOSTCiY99Ww>
    <xmx:CUCwaRnrbdc43EXaq_Vf8MLaxy4hHcAVyFaMGhZkDeG7O0HBum-vhw>
    <xmx:CUCwacbOL4LvkuBjkd07d4brTXJp1EqGysYHM5SBJjJHt6_ZO1h9Iw>
    <xmx:CUCwab-BJJfFyrVNq6SL1s4J3gl0dVfzSSnNaIbJzz4dZ82qbfIhag>
    <xmx:CkCwadRzYKPjKCVJ4YG7BbG4B0xUB4YbBcf9pZfQg60UzdK3jHDAk-EJ>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 12:00:07 -0400 (EDT)
Date: Tue, 10 Mar 2026 10:00:02 -0600
From: Alex Williamson <alex@shazbot.org>
To: Yishai Hadas <yishaih@nvidia.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>, Peter Xu
 <peterx@redhat.com>, <jgg@nvidia.com>, <kvm@vger.kernel.org>,
 <kevin.tian@intel.com>, <joao.m.martins@oracle.com>, <leonro@nvidia.com>,
 <maorg@nvidia.com>, <avihaih@nvidia.com>, <liulongfang@huawei.com>,
 <giovanni.cabiddu@intel.com>, <kwankhede@nvidia.com>, alex@shazbot.org
Subject: Re: [PATCH vfio 0/6] Add support for PRE_COPY initial bytes
 re-initialization
Message-ID: <20260310100002.21f00d61@shazbot.org>
In-Reply-To: <51f060d7-a7c3-40f3-b8b9-0c4010153b79@nvidia.com>
References: <20260224082019.25772-1-yishaih@nvidia.com>
	<20260227132327.3e627601@shazbot.org>
	<f74867bd-02b0-40d8-98be-c22a4129320a@redhat.com>
	<b16fc66f-bea8-4b42-ae68-8e37a6d09bda@nvidia.com>
	<4da90bae-c087-4191-9e96-1bd815468a6a@nvidia.com>
	<97e3c514-a434-4cef-8d94-2f3bfd97068b@redhat.com>
	<51f060d7-a7c3-40f3-b8b9-0c4010153b79@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Mar 2026 14:44:04 +0200
Yishai Hadas <yishaih@nvidia.com> wrote:

> On 10/03/2026 12:09, C=C3=A9dric Le Goater wrote:
> > On 3/10/26 10:46, Yishai Hadas wrote: =20
> >> On 01/03/2026 14:43, Yishai Hadas wrote: =20
> >>> On 28/02/2026 8:27, C=C3=A9dric Le Goater wrote: =20
> >>>> Hello,
> >>>>
> >>>> On 2/27/26 21:23, Alex Williamson wrote: =20
> >>>>>
> >>>>> +C=C3=A9dric, +Peter, please see what you think of this approach=20
> >>>>> relative to
> >>>>> QEMU.=C2=A0 The broken uAPI for flags on the PRECOPY_INFO ioctl is
> >>>>> unfortunate, but we need an opt-in for the driver to enable REINIT
> >>>>> reporting anyway.=C2=A0 Thanks,
> >>>>>
> >>>>> Alex =20
> >>>>
> >>>>
> >>>> I took a quick look. The series would be a little cleaner if
> >>>> vfio_check_precopy_ioctl() came first =20
> >>>
> >>> The motivation to introduce that core helper and adapt all the=20
> >>> drivers to use it, was to centralize the common code and ensures that=
=20
> >>> output flags are cleared on entry.
> >>>
> >>> This can be done only after that we have the previous opt-in patch as=
=20
> >>> we would like to keep the V1 behavior for compatibility reasons.
> >>> =20
> >>>> and some parts are little ugly
> >>>> (precopy_info_flags_fix). Will take a closer look when back from PTO.
> >>>> =20
> >>>
> >>> I'm open for any better name, any specific suggestion ? =20
> >>
> >> How about renaming it to precopy_info_v2, which is closer to the=20
> >> feature name ? =20
> >=20
> > I found the prefix '_fix'=C2=A0 confusing and saw no connection with
> > the names of the new flag (VFIO_PRECOPY_INFO_REINIT) or ioctl
> > VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2.
> >=20
> >=20
> > Based on how 'precopy_info_flags_fix' is used in mlx5vf_precopy_ioctl()=
 :
> >=20
> >  =C2=A0 +=C2=A0=C2=A0=C2=A0 /*
> >  =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0 * opt-in for VFIO_DEVICE_FEATURE_MIG_=
PRECOPY_INFOv2 serves
> >  =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0 * as opt-in for VFIO_PRECOPY_INFO_REI=
NIT as well
> >  =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0 */
> >  =C2=A0 +=C2=A0=C2=A0=C2=A0 reinit_state =3D mvdev->core_device.vdev.pr=
ecopy_info_flags_fix &&
> >  =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 migration_state =3D=3D=20
> > MLX5_QUERY_VHCA_MIG_STATE_OPER_MIGRATION_INIT;
> >=20
> >=20
> > a name like 'precopy_reinit_allow' seems appropriate to me. =20
>=20
> The opt-in allows using the 'flags' field not only for the reinit case,=20
> but for any further usage.

Yes.  It started out as an opt-in for reinit, but then the failure to
sanitize flags was discovered and it seemed to make sense that if we're
defining a v2 interface where flags is valid, reinit could be a
fundamental part of the new base v2 protocol.

If a driver doesn't want/need to support reinit, it never needs to
raise that flag.  Userspace can also always choose to ignore the flag
and transition to stop-copy at any point.  It didn't seem worth a
separate opt-in beyond v2, but do comment if you have other ideas.

This could have also gone the route of making a new v2 ioctl, but this
seemed slightly cleaner.  Thanks,

Alex
