Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F2F37BE7D;
	Wed, 20 May 2026 21:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779311549; cv=none; b=gsMtiRKPWfMueNGmKo6Z3yYxlws+jc1sP10LN2wH7eAOn060ST5fdbaFOCHPOmMK2edp9OFkPuGgrhqNxoUbW+jSg251YmLdIoIEX+qaWYGzlEv5DNlQ95YzP8D/4+hKcdIabehXHT+AiSKFMiEyqH4c2/oJm/ftD7BeO8wunIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779311549; c=relaxed/simple;
	bh=7ug+oGNPG0H4oGq7XA6PzTq+xyYmWE6KrA1UyvUEHYI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lv0JsQ4W7ZdSM0U3uosGVEVA3AVgu3M0RcrORejgME5JJhYKuIvIigAHhe54JHdYvetqthZinSUbyhOBuvUhX5o+7jD7PavNr0GkAxWEFfTodREIvTYjCF9BUn/v7W25DdDMwuHvr914F47envXZGEc6/cF9JXpmOHTqtDE2FcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=RIaeMP+I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CuglBUb2; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="RIaeMP+I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CuglBUb2"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 69E7C7A004F;
	Wed, 20 May 2026 17:12:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 20 May 2026 17:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779311547;
	 x=1779397947; bh=SnPadwV8Be4UiWAfjVyZAFjhiHVMSBgNnx4hNSiQFZk=; b=
	RIaeMP+I6wN6PKIPrG1ET/zZVVbhloPPgPr8lDyj3HBtGMxvISwguSGd4yNSRYbw
	WzOeKZ5uW1dpCOwzkP4hqcAjQ/Xt1gkVKE8RM5jKAFEwzQGj14XflAgdXeO3aBtU
	DV6RVjrmCCXDrdkBRLLE7VjjO38fU2vf8SOUrHqMpOleCkK3PjPo4FmnXOMvdu3/
	f8nvpNoLhmytXk2tmFw5oVxYblnr5oPn5PH1nfgcGcxvYrRctWvak/01mt+UMrlY
	zbeLow5EgfTjajR/ZdtV+XJhoCMWSfcA69MzvfPZ43e87oh9TrWmnVrOV0o09CZ+
	j9GqFf1wMtEs3lUDDivC+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779311547; x=
	1779397947; bh=SnPadwV8Be4UiWAfjVyZAFjhiHVMSBgNnx4hNSiQFZk=; b=C
	uglBUb2hHB71Q1x/ikOFZuVQ7iYbBd4VF8EeUMcF6FggsnHNmlYgvnncO7j+OFiB
	FmhYGULZD+0JzH6jPa6Pgsc6NShe6nRbeDXWOPszUfl0aCxicSE3Pu/6EZOXslkF
	z2x6FlYeAbVT2j+YfsEqC68u3wyJ3Oy2krM+cdji/dmy7+UPGqpZH+sEmKomGoBd
	6dbd8YRa2ay6KDC45KWwgSaT1ToalIDB4OC17PiFTIOvWQ0W+nt5h4ezxjcFvLA3
	BWEya1GPMeXmiKUg+Oe5oSKB53Ijhx7pCOrHfQDnCJj1sJ2To4A6vSdQ0PRbY+ik
	do8k6eb8Swi8gk5dckFyg==
X-ME-Sender: <xms:uiMOajkjJ3CECeoL-jL01rOG-oIMxUOBztt_2lw1Iz7einF1SEJCKA>
    <xme:uiMOagKlyLR6Lyna2nDHIy0-enlp_lCtDxM31P0-Cg5X_M8h-BovcoHWOU-lKt1rO
    Y8zRuUE_14V_MaU4_YFzSkmxqBsSe2xaVpvkFOu_PZM8GwrShX5>
X-ME-Received: <xmr:uiMOag7d-33D3NZFjqY5569Kf-mIONCrPnp-4yS6SBzPrhO9zkLzoV1n2M4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeehieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
    veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhhiuhhlohhnghhfrghngheshhhurgifvghirdgtoh
    hmpdhrtghpthhtoheprghlvgigrdifihhllhhirghmshhonhesrhgvughhrghtrdgtohhm
    pdhrtghpthhtohepjhhgghesnhhvihguihgrrdgtohhmpdhrtghpthhtohepkhhvmhesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgiesshhhrgiisghoth
    drohhrgh
X-ME-Proxy: <xmx:uiMOas3R72j7Pv0AARGXJn4ZDrmpAYpqJsP90bMFQY6VskCavjIPJQ>
    <xmx:uiMOauf4nmFdDi1TDs5ciP4_1IscZ2kzXZeCsz51DxGyZZaqwyhZ8Q>
    <xmx:uiMOaqeIESpwL4DWNSlEPysU7WSrikAVHgMZkTI209I4QDncB8yi5Q>
    <xmx:uiMOahwVdWHrUZTYuPKbryruZVZGaJ9otelsZQDk-vmYPrVEau06HQ>
    <xmx:uyMOalqa_p5t5MEs78_s_jfFXLqo1M1UhxrxnhVLpkTB_-UI6M4Cv5do>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 May 2026 17:12:26 -0400 (EDT)
Date: Wed, 20 May 2026 15:11:46 -0600
From: Alex Williamson <alex@shazbot.org>
To: Longfang Liu <liulongfang@huawei.com>
Cc: <alex.williamson@redhat.com>, <jgg@nvidia.com>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH] hisi_acc_vfio_pci: simplify the command for reading
 device information.
Message-ID: <20260520151146.3a5c7500@shazbot.org>
In-Reply-To: <20260514092026.2018844-1-liulongfang@huawei.com>
References: <20260514092026.2018844-1-liulongfang@huawei.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 May 2026 17:20:26 +0800
Longfang Liu <liulongfang@huawei.com> wrote:

> From: Weili Qian <qianweili@huawei.com>
> 
>       The mailbox operation for the Hisi accelerator device now
> provides a new read function that supports direct information retrieval
> by specifying commands, thereby simplifying the related mailbox command
> handling in the driver.
> 
> Signed-off-by: Weili Qian <qianweili@huawei.com>
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 39 ++-----------------
>  1 file changed, 3 insertions(+), 36 deletions(-)

Applied to vfio next branch for v7.2.  Thanks,

Alex
