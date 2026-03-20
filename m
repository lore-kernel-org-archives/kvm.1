Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3877236AB72;
	Fri, 20 Mar 2026 21:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774041562; cv=none; b=m5mMi+FGFo3sM6pi/YiCLy3yPRfuMSeFmn7Fy42Fca9Gv7gLFwnHSsfwxFNx9XmT0EYgj2FgszTtEx212lIHlIUpIJu6rT3UrH+Yel4ktv5d0ouSdCLflw3rVd1+O4Fi5d4L3tJuASNEGEm7FCmf5rmTAwhoB7UDyb1mHGtWV9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774041562; c=relaxed/simple;
	bh=lYmA3aehpdlr/dJ/XXy/GnLs/QUs7bwzS5vFofn9WMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fYuG/XCbf6Vf7F82uilDYF2xpNnY4/KZwzjLSX41/7OCoAZH/C2+mzZ5U0MJwrKgj190D3AEzo6hVlrBkkHYVkhHi4M2vMRPe6Mm5lxE60kyB37XgJBL6WQOW4XYLjrMgE+mg+4g0n4Fh2ga4XkQ90WzlElhNFmUYk906N2bb2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=FvTqEiLz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1zKbXxeX; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="FvTqEiLz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1zKbXxeX"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F3608140027A;
	Fri, 20 Mar 2026 17:19:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 20 Mar 2026 17:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774041557;
	 x=1774127957; bh=pMPvogdXHAoC/iYQFn8VpG3axK/CiiZqbJ+W+lYLr4k=; b=
	FvTqEiLzTBF88HG0bJQTvGomO5sUaXgeFQYH1cARR3Z6oZy+jjrlb+o6EXA7SGYB
	hNhkhMNebr6kzIZf56oZFx1fVY0Y5PnXt7sYOPwogUerhvRU95H52eA2rz57ONDM
	xoi4aQE/+RpJgr0n0Tc8Y9cjogzN21551xl5dGNdYYQJKbqYgjRwyLdTBVyXtfBk
	OUq3CovyhKAL9uDopgo8sFcPIlpo9UglSvRQLTJlfA0PkfbNJME+x5WYvquYuNmJ
	QFJKnHSFeLL+23yQnQP+9P0JVgq8fbnCZcT5Gg7maG+lOtnI6Ge/4I8ZiLSV4mpK
	YsPP6f4+cfDOOUsiyTHiXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774041557; x=
	1774127957; bh=pMPvogdXHAoC/iYQFn8VpG3axK/CiiZqbJ+W+lYLr4k=; b=1
	zKbXxeX7iJf8bC4OqKV2FIl6/NIC63BpWnViRplEs0+ajDvXu0wY4LasPVfLugaJ
	bQUO/JCiYrl7N2ylp+gvY4ixGvqjvdMtuxf0eDQO8gjxtEb4egaHfg7dZdY8/wZ3
	d9BIJkto7nHR/PAA7S+wJZIU650qVdqQ9i0mLgdeh9rtAWZiLZ4FSpS53Wt9B/Xx
	6sI+cIWpQX2w9Y+WUem/x+FzOdeA8nDyluph9cA+zuTLRqD+UxRcqWdJs9Padvs3
	pk8ehhNw8+g+09xTEW5OZ7wVsO3RwzrYUrF27Tr+6Apac68VfD3JpdIV5PT8R+Df
	3rJACzdARf/WABZEoaibw==
X-ME-Sender: <xms:1bm9ac4bpwzwEb5tJJBys1lx1D7EywaLJqFnpn6GWCjiuRy9cDOmHg>
    <xme:1bm9aXNa969NcRYDew5vJf685o_Y63euNtvwmBUJEn3mZqpmil_DR03LaIPsHJfV2
    ipLdFwP0zECYu2Q6pfaM4kN2jeHItzsjUDoj8fJ4ZAr6gpSS1zIfkQ>
X-ME-Received: <xmr:1bm9aSukDqrTJGedIVThIDTZZcCL5Ry-mikisTruw8quGAV4-mHWcvh96fY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefuddtleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpeekheejieetffefueeiteejtdejffdvleelvdeuvdffvdefteeghfevkeeu
    vdefvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    epudenucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhg
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjkh
    hoohhlshhtrhgrseigshegrghllhdrnhhlpdhrtghpthhtohepghhrvghgkhhhsehlihhn
    uhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepkhifrghnkhhhvgguvgesnh
    hvihguihgrrdgtohhmpdhrtghpthhtohepkhhvmhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegrlhgvgiesshhhrgiisghothdrohhrgh
X-ME-Proxy: <xmx:1bm9aSanjsB4WLtzcctTaN7xBgpCKOq8uFIXEwhxDllfSPxNmNmQSw>
    <xmx:1bm9aczF-T8BaSfYbSZoR3BROLjz8NdqM5KLTX2tKZHoOH2ldu6ZJA>
    <xmx:1bm9aSiE7OMUh7uQOpb7-jIbULyNga-hq6SQ8gx7jLOucq0lCdWjgQ>
    <xmx:1bm9aQkRlPpfjc1M2Sd07M7GSse1CYxIrXNcH0uOzi0Y7KHTDjO2Pg>
    <xmx:1bm9aUtUuYulCbhmJnea5jS7XCt_i0DFzwa8KRVVWx2z5UQQ12_qGH63>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 17:19:17 -0400 (EDT)
Date: Fri, 20 Mar 2026 15:17:54 -0600
From: Alex Williamson <alex@shazbot.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: gregkh@linuxfoundation.org, Kirti Wankhede <kwankhede@nvidia.com>,
 kvm@vger.kernel.org (open list:VFIO MEDIATED DEVICE DRIVERS),
 linux-kernel@vger.kernel.org (open list), alex@shazbot.org
Subject: Re: [PATCH v2] vfio: mdev: replace mtty_dev->vd_class with a const
 struct class
Message-ID: <20260320151754.3cefebec@shazbot.org>
In-Reply-To: <20260308214939.1215682-1-jkoolstra@xs4all.nl>
References: <20260308214939.1215682-1-jkoolstra@xs4all.nl>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  8 Mar 2026 22:49:39 +0100
Jori Koolstra <jkoolstra@xs4all.nl> wrote:

> The class_create() call has been deprecated in favor of class_register()
> as the driver core now allows for a struct class to be in read-only
> memory. Replace mtty_dev->vd_class with a const struct class and drop the
> class_create() call.
> 
> Compile tested and found no errors/warns in dmesg after enabling
> CONFIG_VFIO and CONFIG_SAMPLE_VFIO_MDEV_MTTY.
> 
> Link: https://lore.kernel.org/all/2023040244-duffel-pushpin-f738@gregkh/
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
> v2: undo whitespace reformating of struct mtty_dev
> 
>  samples/vfio-mdev/mtty.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)

Applied to vfio next branch for v7.1.  Thanks,

Alex
