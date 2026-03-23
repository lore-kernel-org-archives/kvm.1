Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4AA37FF66
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 22:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774306636; cv=none; b=OiZgc4NbmeJXr/3lGGyTeNq2nFzHT5560qTpufkb1BxQZ6Kndie9XQXqwUPeMBEixGblu9x/Lo657wWY6tMrqzzYho31UNt51rT0V1WgzR6tVcppRmFaHNT7E6ew11yxVTtppvk/4G/qMYbM3P5orwFr3aZm1RknYUVMj+lepZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774306636; c=relaxed/simple;
	bh=seTBFg8rB9Czx7yQxM/2Gpea0r4H7iG3/BOhyXP3K2I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JOuUl5GjxSd3mWJ+SbH/HfG5hRG4Ino0rzd6yiyHKYEea++bycppVqS+c47EIcFBpv74b1YgZfFw98fGNx/8uxmv0UEqRhILhHusMljOFWoIGLlCCC58Xg8/+jtcJm+pjQ4pl4lyVFYVnjXLnUSg09NmQqcn0+jzbrsgMekubto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=hxFsPl69; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ID7FphM+; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="hxFsPl69";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ID7FphM+"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0CC3014001A9;
	Mon, 23 Mar 2026 18:57:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 23 Mar 2026 18:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774306633;
	 x=1774393033; bh=FsiblXynK1XrH4CjgdcSCwOyT3ghGrmt5CArjN4kKts=; b=
	hxFsPl692J4MKv6uMH89LD9nxZnfho9ie6yBdfoCV91DLqr9zcPsOn/kUxURgpHX
	wn9LeNy1px9xdAD7trEEOEpMYZM9+gb8khA8fgtvDEB9oGN8JUQjnrWdWmQIukVv
	uSP6hRTqS67SmY/jLPHxyIXRnGjgrJ0KOPvVGi2l7V2qTIfuMz1THjpSWIrswAYq
	zoPbtuCL/FS1h1lZrsPvWtRZXDIYV75r+KaAZJ65lmpL++l9gavXuol5fu5cbfzf
	sP3IyHef2rdwE4fkCodrt+lA+KqnSsYOfewx+LWWg4Okx5Z51x0UJX8PDlBOPmGG
	0+8OJU76dwfg/WUt4MG97A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774306633; x=
	1774393033; bh=FsiblXynK1XrH4CjgdcSCwOyT3ghGrmt5CArjN4kKts=; b=I
	D7FphM+mYWkZzd4TvjiVz6A0IGZ0a3wt6BXo0TjMI3anDj1QXg+QyVyBjVMWfyl8
	xbYTTJVpsAM1vVr6Gjeqk3YdzNiJgK1mrFloHjBw7Z1e8NrV/MyL6vRnvvRd657W
	8DDwn/Ij+UraonPZdmImnXVuqFH2efaaUbzcTswdV3TEBa99RM7Oc5K83t+ZsevX
	gNhbeZ3VEJXpKerPDkENmz/VC89PLPTZReLt7MSB9eBTN+WRASIK5TfDxgvw38Tg
	4YcbLps7eCUKbaaEaOuJqa6s8PtAFp9x4M27feR/MzNpGaPIW0HbNcBxZv+wwD63
	yV5aAvY3rP0vNzP2KzcoQ==
X-ME-Sender: <xms:SMXBablQC365QygvGtqjoubsrApr7P3C7PCfC8fgFg4tLmr9yN9YWQ>
    <xme:SMXBad6PTDz3NkSsosG3bFAprk1SLP3Po0jPgNn31119LY_1_AloB08NgKiQaVxIQ
    g-zW0G0c3M0TjD1eCnEJDSL_-hHAUxb0KT28bcyTn65xH6Bp_9-LA>
X-ME-Received: <xmr:SMXBaX1zDy4sw2-pFoj6RoKWtaN4UojEcGIitQaZ2doJ9cOtTkSVMrLoYRY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudelleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
    veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhiohhvrghnnhhirdgtrggsihguughusehinhhtvg
    hlrdgtohhmpdhrtghpthhtohepjhhgghesiihivghpvgdrtggrpdhrtghpthhtohephihi
    shhhrghihhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepshhkohhlohhthhhumhhthh
    hosehnvhhiughirgdrtghomhdprhgtphhtthhopehkvghvihhnrdhtihgrnhesihhnthgv
    lhdrtghomhdprhgtphhtthhopehkvhhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepqhgrthdqlhhinhhugiesihhnthgvlhdrtghomhdprhgtphhtthhopegrlhgv
    giesshhhrgiisghothdrohhrgh
X-ME-Proxy: <xmx:SMXBaQGYe9B0eAIC9E-X4VpfnkW0Xp9hmEQN2xHqy6aWs4HIN6niNA>
    <xmx:SMXBaegsW_Zd9u9HTvbfgoP_JKfB7uswHVjRhrIpuyfVef9aQ8kG1A>
    <xmx:SMXBabCMwkWL9WaNYb2SOGwJC28joTmvC-4kuiSRI2fcfLqD1E7nAg>
    <xmx:SMXBaYRXP1NlIHIQMOr86R9PqWi3BbxQ79DFnACRrPKX1a3hBd4u8Q>
    <xmx:ScXBaZvmlkY41z1DGYAaNIxgd2e64XDmLbjdnOYrx5z3OlyYFC4NmOks>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 18:57:11 -0400 (EDT)
Date: Mon, 23 Mar 2026 16:57:10 -0600
From: Alex Williamson <alex@shazbot.org>
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc: jgg@ziepe.ca, yishaih@nvidia.com, skolothumtho@nvidia.com,
 kevin.tian@intel.com, kvm@vger.kernel.org, qat-linux@intel.com,
 alex@shazbot.org
Subject: Re: [PATCH] vfio/qat: add support for Intel QAT 420xx VFs
Message-ID: <20260323165710.7f061389@shazbot.org>
In-Reply-To: <20260320213622.88549-2-giovanni.cabiddu@intel.com>
References: <20260320213622.88549-2-giovanni.cabiddu@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Mar 2026 21:35:39 +0000
Giovanni Cabiddu <giovanni.cabiddu@intel.com> wrote:

> Extend the qat_vfio_pci variant driver to support QAT 420xx (GEN 5)
> Virtual Functions (VFs).
> 
> Add the relevant VF device ID to the probe table.
> 
> Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> ---
>  drivers/vfio/pci/qat/main.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/vfio/pci/qat/main.c b/drivers/vfio/pci/qat/main.c
> index b982d4ae666c..7b4d8bb9bed8 100644
> --- a/drivers/vfio/pci/qat/main.c
> +++ b/drivers/vfio/pci/qat/main.c
> @@ -677,6 +677,8 @@ static const struct pci_device_id qat_vf_vfio_pci_table[] = {
>  	{ PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_INTEL, 0x4941) },
>  	{ PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_INTEL, 0x4943) },
>  	{ PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_INTEL, 0x4945) },
> +	/* Intel QAT GEN5 420xx VF device */
> +	{ PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_INTEL, 0x4947) },
>  	/* Intel QAT GEN6 6xxx VF device */
>  	{ PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_INTEL, 0x4949) },
>  	{}
> 
> base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c

Applied to vfio next branch for v7.1.  Thanks,

Alex
