Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1646036896E
	for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 21:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774041557; cv=none; b=aYN+fsdd3M3pvhqw0wZY+TbFD8FIdUBl5WH5NjIqVohfMgFxiPJGoXZHvWNQM5P730cPHQsASGk9Xa+Rk1AiJGZ6iuL7vLA9r1OiZwu+iwBct1RJOcxw6FSjeTbSpsIyep+pjiAl33ie9ManAy5NgqdPHV04gUhqZPO7dTGJJi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774041557; c=relaxed/simple;
	bh=7GJAJ0s61jRHU9EivYG157w09xIZmaIBNWGBD1ajLsI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ek+QzixR+QAIBs/KdmcpeckCSqi+PBsjWWS+FYdyZSJVNQPHPSJbDzUp291RXv0tB2BkzCcsQ6OybJpFH6zS6nEjkwwNh/0q7b0xL7CXFzKv2vEBAX2ICznGga+plLd/YIAeQ3+KVbbY1wUY44orkW59H6fNVvkW1z2huItBCSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=ilWx4DvB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3SZlNmsH; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="ilWx4DvB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3SZlNmsH"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C62481400258;
	Fri, 20 Mar 2026 17:19:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 20 Mar 2026 17:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774041551;
	 x=1774127951; bh=myXbYyE2Cn9OsuYG4urOIftEYgRcRyrIOtEJJetownA=; b=
	ilWx4DvBsu1+y68Dfshq1a2nO3R7g5IcQfGYM3eQFRp4V4f2/6NrTjiJiLvzU45w
	QiTCITbYxRTpCrFcl0Q+vwyn+N857IGBjx+5/qRLDcHUqdvUDjCoWoQL4uYAMGwA
	PLUnza3EcTNMb4vf6g4N+0Ex8+08zBubfAelDDlRc1hELsoBES3mNkIhkHJaAgkK
	34I87QqpAZit7CUVNYFEWRiFBhCqDhvwcPFxJmXPTXgXIJ5m0OKqwQiK03+25upS
	6FGmwHBh89gsuPePJFhA5bWLFBEkuz31aMd97Y8zKaOIqo97pqe4/yNWB3oWa2F2
	uZKdCDLyElQQrd9THVXTTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774041551; x=
	1774127951; bh=myXbYyE2Cn9OsuYG4urOIftEYgRcRyrIOtEJJetownA=; b=3
	SZlNmsHA4Fmbr9byjes2VJO8+zXfD2U+CJbrp11HH5me8Zi/2z4r4QtepM7u1Nvr
	if5vWlpAyz9OJWFZArACxQwAaCWh3UmI/Nw2fspTy4n7ZY2i3bZTLSB02xYW1bnq
	tnEUg0ZRFE6PaZgHKwLuoio/Id03Qoxd0m5ER0Z7c7Bv+81w7d8FZLei7LVR59HF
	b+LRNIVzWDzt1sAObZx23583PEyp+1FVhVknDWmu9S4/LP2ey2qM5XliqZ95VBD+
	I7tPPcCaQ4cODTnqn33nHCthvPStoazFw5DoGsaCCqLjYcBLux0WK5RtnmSKmkj8
	MZ1uAhtKnCUxgww4nxFuA==
X-ME-Sender: <xms:z7m9aVHA0HBVqGsnkKCjyS2mHanCQG0TuflT2PZ_ULoTXx8JTSDW_A>
    <xme:z7m9aeCbHLxWQcm9PcAVSHFbjBdDQ-H76vk4rctT__mUHWPk9-QGV7wn0Lh2SmxaC
    v-9HnrNpW_r5UX_zDecTeztV7gvCycWoAFArHu1dIMLUq5Tn2yl2HM>
X-ME-Received: <xmr:z7m9afzrMIbOPRvi9TuDVlIX0gwWoOj31GQK_flD5F-yBG1Re9YEmqjizFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefuddtleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpeekheejieetffefueeiteejtdejffdvleelvdeuvdffvdefteeghfevkeeu
    vdefvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhg
    pdhnsggprhgtphhtthhopedugedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephi
    hishhhrghihhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepjhhgghesnhhvihguihgr
    rdgtohhmpdhrtghpthhtohepkhhvmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehkvghvihhnrdhtihgrnhesihhnthgvlhdrtghomhdprhgtphhtthhopehjohgr
    ohdrmhdrmhgrrhhtihhnshesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheplhgvohhnrh
    hosehnvhhiughirgdrtghomhdprhgtphhtthhopehmrghorhhgsehnvhhiughirgdrtgho
    mhdprhgtphhtthhopegrvhhihhgrihhhsehnvhhiughirgdrtghomhdprhgtphhtthhope
    gtlhhgsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:z7m9accpqVsGG9FU6hQN7lIT2q1d53PdWqZPvcuhKXtckMm_OKiOdw>
    <xmx:z7m9acsbbje0hjDa16jl4BERescWsFPZKSadCyzdb-ztNwHlLkceUw>
    <xmx:z7m9aZB2HM6GK5L7j2fB0dRj7_bjvYl2LlLhKKZcYW_XGlUr6QfiTA>
    <xmx:z7m9acFu32MAT9Wfn35Xo5eHysHOcO7fW7LAwoj_3DUhwjGcFugQCQ>
    <xmx:z7m9aRfYXn7Ww0x494eHaBEfrRes19nhpGdhJPUN7NBQMJClCSIeU7kZ>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 17:19:10 -0400 (EDT)
Date: Fri, 20 Mar 2026 15:17:14 -0600
From: Alex Williamson <alex@shazbot.org>
To: Yishai Hadas <yishaih@nvidia.com>
Cc: <jgg@nvidia.com>, <kvm@vger.kernel.org>, <kevin.tian@intel.com>,
 <joao.m.martins@oracle.com>, <leonro@nvidia.com>, <maorg@nvidia.com>,
 <avihaih@nvidia.com>, <clg@redhat.com>, <peterx@redhat.com>,
 <liulongfang@huawei.com>, <giovanni.cabiddu@intel.com>,
 <kwankhede@nvidia.com>, alex@shazbot.org
Subject: Re: [PATCH V2 vfio 0/6] Add support for PRE_COPY initial bytes
 re-initialization
Message-ID: <20260320151714.7642ed1e@shazbot.org>
In-Reply-To: <20260317161753.18964-1-yishaih@nvidia.com>
References: <20260317161753.18964-1-yishaih@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Mar 2026 18:17:47 +0200
Yishai Hadas <yishaih@nvidia.com> wrote:

> This series introduces support for re-initializing the initial_bytes
> value during the VFIO PRE_COPY migration phase.
> 
> Background
> ==========
> As currently defined, initial_bytes is monotonically decreasing and
> precedes dirty_bytes when reading from the saving file descriptor.
> The transition from initial_bytes to dirty_bytes is unidirectional and
> irreversible.
> 
> The initial_bytes are considered critical data that is highly
> recommended to be transferred to the target as part of PRE_COPY.
> Without this data, the PRE_COPY phase would be ineffective.
> 
> Problem Statement
> =================
> In some cases, a new chunk of critical data may appear during the
> PRE_COPY phase. The current API does not provide a mechanism for the
> driver to report an updated initial_bytes value when this occurs.
> 
> Solution
> ========
> For that, we extend the VFIO_MIG_GET_PRECOPY_INFO ioctl with an output
> flag named VFIO_PRECOPY_INFO_REINIT to allow drivers reporting a new
> initial_bytes value during the PRE_COPY phase.
> 
> However, Currently, existing VFIO_MIG_GET_PRECOPY_INFO implementations
> don't assign info.flags before copy_to_user(), this effectively echoes
> userspace-provided flags back as output, preventing the field from being
> used to report new reliable data from the drivers.
> 
> Reliable use of the new VFIO_PRECOPY_INFO_REINIT flag requires userspace
> to explicitly opt in. For that we introduce a new feature named
> VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2.
> 
> User should opt-in to the above feature with a SET operation, no data is
> required and any supplied data is ignored.
> 
> When the caller opts in:
> - We set info.flags to zero, otherwise we keep v1 behaviour as is for
>   compatibility reasons.
> - The new output flag VFIO_PRECOPY_INFO_REINIT can be used reliably.
> - The VFIO_PRECOPY_INFO_REINIT output flag indicates that new initial
>   data is present on the stream. The initial_bytes value should be
>   re-evaluated relative to the readiness state for transition to
>   STOP_COPY.
> 
> The mlx5 VFIO driver is extended to support this case when the
> underlying firmware also supports the REINIT migration state.
> 
> As part of this series, a core helper function is introduced to provide
> shared functionality for implementing the VFIO_MIG_GET_PRECOPY_INFO
> ioctl, and all drivers have been updated to use it.
> 
> Changes from V1:
> https://patchwork.kernel.org/project/kvm/cover/20260310164006.4020-1-yishaih@nvidia.com/
> 
> Patch #1:
> - Extend the uAPI documentation to refer to the source of new
>   initial_bytes data.

Applied with the fix discussed in 2/ to vfio next branch for v7.1.
Thanks,

Alex
