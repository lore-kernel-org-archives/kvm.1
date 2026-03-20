Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0318336C580;
	Fri, 20 Mar 2026 21:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774041562; cv=none; b=UoI56kPObj4X0muv2htDcXSPrHh7NLvkeVctPyOD7MSsKfkAxKJyrTVi2saEdzfPUW3I4iFdPGnInC53xyv6gWzBXdM5yoQDQYg/Tlonh1b1pCoeSQugJ9v7uMVuXW8sl+LWjd6BFbpLVRX9ZJJEykfwJqcpsL+GzdiqZBoA6fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774041562; c=relaxed/simple;
	bh=Gv+f/osuGTcdg0HUByimaCpZw+xh2BXVhZka7/8QQRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IyUueoDkJEnyPJsUvpD2lI6R+t8pOT4Gubuoqr1GBkmCFBztgTfNCtDM//ITLzFDLuNpajkSRROmqbSCOaqUqRISuq3hK0WhJfB8SSdm2YIpGD1kb1C408dBHMldEaNxi1CHoFs7lZVnYNd39e27QH1ryomCD4xVweJQRkevKFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=L4KoFCZ+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hwl3R8Ks; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="L4KoFCZ+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hwl3R8Ks"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1C7891400278;
	Fri, 20 Mar 2026 17:19:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 20 Mar 2026 17:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774041557;
	 x=1774127957; bh=iXoX/CFR2B3qMa6SVmwX+KrAYO2IFEZ9grGwcoppcRE=; b=
	L4KoFCZ+YbTvXXeyHs0Km3+k39LVuQDrDQ+4+m9v+Ecvz4+y1xKgcijKNCQA63bx
	uSVS2ltHwTUkLpgWPSA59YGnGE1RbKsh5bgBYJCk2MhBzL2kORYCDFKtk8rplYw/
	mN8uGTGUiYR+o6mXilG8JMaaW2WwirK1P3qbtLRMX7HjvETigaWEUnkOHImfNTyI
	UHm2GOinqrt94UKwKguvtx5sAlxJlDaMeH2ZOYW1NLBk6tfpN/HYD9/+hJOXRlcL
	xawzDey76MzLC6hZ47nGVgV2OVfHmWNT2Auhb6lh1Qck3DzZ60DBYC8nKHXWeZWr
	W2R8WLDPi2hImAmDFCW5yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774041557; x=
	1774127957; bh=iXoX/CFR2B3qMa6SVmwX+KrAYO2IFEZ9grGwcoppcRE=; b=H
	wl3R8KsOvMUsf2uZPl70e5JPDYspGYdolec8KxzUpFjLLYYraqNAxrbagx5LiI/6
	K3YsdAHfy7OzzYd+AOI4geSm6wBL8eOsvIozoNd+NwO3r0W9sFqqRGsENPIc7NmH
	PMX0iGBk/BBFOb7oGi7EFkTYe3E9NlpsPeAkrUgKMhz5E+Xr7FmFllpvgfgly1Y6
	fqayvUVGwbzL7bmgu+xATq3U49J9uNQNwxhWMatQm5Ix5QdNxlz9Zm/8bqwruJB+
	dsRQGd0hrBn0ZODlaVi+2/sdo4sGaMIswL+/9HfKuna4C/KcGLJDyzr92Esxc8hN
	Tmz7J9YyefHxLRCA9vhrg==
X-ME-Sender: <xms:1Lm9aS7YlJj9YlPnt-44q-ciOoPopQNr-6caBPLHno_dFZebFXLZnQ>
    <xme:1Lm9aZAcFxV3WrpOxdPvwwi8W-2ri_NAyNFguFh6W2HSguPYFdwbmx4FeAuEGgAb_
    V57R6bo6BYAHwHvNEKMa5owkwrfONoduirdn4HIbD59P9Ius9fq7fI>
X-ME-Received: <xmr:1Lm9aQfjPPfYLlJ1mq309Z1FU43kpi0j4_IUy65RTRbzk-nc8bwERD8JwNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefuddtleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpeekheejieetffefueeiteejtdejffdvleelvdeuvdffvdefteeghfevkeeu
    vdefvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhg
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjkh
    hoohhlshhtrhgrseigshegrghllhdrnhhlpdhrtghpthhtohepghhrvghgkhhhsehlihhn
    uhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepkhhvmhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgiesshhhrgiisghothdrohhrgh
X-ME-Proxy: <xmx:1Lm9aQI8kqunAZzfryXZP7VqxBZp6gFkgrrjqPQUKZ7anD7mE_JU3g>
    <xmx:1Lm9aT2adnTJ0H00wUqfeJihItmSTk3VXoPsf7k_xJY_O13tXwW4mA>
    <xmx:1Lm9aajUEYSt_XqRmo1cZtFsFtOCQlnePGARNCmonSLrfDmcvXlATw>
    <xmx:1Lm9aUXrc9-0OFYsYyDe7phEJUOc8DUqP0WHlDW0vPTKn5Adj8scVQ>
    <xmx:1bm9aQVWkFN4VhbSjvCwNMsrQg61ggAPro2Ddfzm7dlNBFp_cBl4o8OE>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 17:19:16 -0400 (EDT)
Date: Fri, 20 Mar 2026 15:18:02 -0600
From: Alex Williamson <alex@shazbot.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kvm@vger.kernel.org
 (open list:VFIO DRIVER), linux-kernel@vger.kernel.org (open list),
 alex@shazbot.org
Subject: Re: [PATCH] vfio: replace vfio->class with a const struct class
Message-ID: <20260320151802.1d4fada0@shazbot.org>
In-Reply-To: <20260306190628.259203-1-jkoolstra@xs4all.nl>
References: <20260306190628.259203-1-jkoolstra@xs4all.nl>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Mar 2026 20:06:28 +0100
Jori Koolstra <jkoolstra@xs4all.nl> wrote:

> The class_create() call has been deprecated in favor of class_register()
> as the driver core now allows for a struct class to be in read-only
> memory. Replace vfio->class with a const struct class and drop the
> class_create() call.
> 
> Compile tested and found no errors/warns in dmesg after enabling
> VFIO_GROUP.
> 
> Link: https://lore.kernel.org/all/2023040244-duffel-pushpin-f738@gregkh/
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  drivers/vfio/group.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)

Applied to vfio next branch for v7.1.  Thanks,

Alex
