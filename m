Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2813E36C592
	for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 21:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774041559; cv=none; b=kMxo78mp9LRsrF5rJrSk2m6ozAzyPyy3PRGswvf7RSn+QN4fgfc30RimR+HHhGdJGtjtQzBV/aVN6hqoH/h24LXQH/9PoP/gr5uNPctJT6vEjZ48GqwkiXjZkLyCfe1+4C5kbqxRk5+Z2cC/cdbAySvhN2UUm1pOZ4NsdOFUXy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774041559; c=relaxed/simple;
	bh=IoKIv4P2S0xXYB2DOWMDfqHdLgMr5VskhqA3kDH9o3k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RUApmQ2YZciIi00kVvcZsjE3aIsu3ayKeLqekcJzZlY0UPudp8ZqIIu+Ys+vnFwMxgDy3LGH1zY1iosyc2YI8vv+w6bSHKR5LhYF8b9pXuvDx/z4ID0sElJEK+OlNJ3NdPHkiP3kLIen07ZxSskbJ/++ynlG/6q1cKlBKeaANr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=Dzj/pqlH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CO/OzVBN; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="Dzj/pqlH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CO/OzVBN"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id EFA59EC0201;
	Fri, 20 Mar 2026 17:19:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 20 Mar 2026 17:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774041552;
	 x=1774127952; bh=N59ej2FUhwjcx4q2TztOO5SXDzaqQ/y4XswLWNmgHOA=; b=
	Dzj/pqlHImlMiz5yghHVBJfWP6tnvOlBcVK5JkDxxrcTMRvAWd9v0zrq/zyY/P4T
	1oNGDmNGyA7ebBP1upESM3VknqRy0bri1wSmFTSyFZvcyVJQHfDcITCCQPG7YHoH
	gXbEDGzFy2lBT3Tn44Fc9P2Rh1eFqOeezJjA/nmAfdlD0QizbU3Fx3xQxq6cWagE
	kfTCDPg2qTa3uOVtrceOEB0xIwNAEBsdpEOcphWpiE6ukA+GtmqRwu5ojEK8Lksz
	9HqGib7rGrOwpSuyJUuOMRshRrsewtDDfGdXe7p2i8gx8XnjEktQM/X+9L2ClU/1
	iY2lr+Y2rgjE0baVqV7TbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774041552; x=
	1774127952; bh=N59ej2FUhwjcx4q2TztOO5SXDzaqQ/y4XswLWNmgHOA=; b=C
	O/OzVBNYqIBqV5G/DIj8KKaqyXAy69KbpaYTHwCspONoR/5Ad8ujGDFq/BF0s/Y7
	IqXtRkqwuYvwdiyVAZNN63Xk0r8m/uJeox2FvuvX4Ki7Yt0VoXI1W8tWjFvIqmvl
	cRZZXxkW77ara9RY6URy3LSkC9gxX0fiCZLG58K3uqSo0K11z12/MiKDAW4sJyYw
	KOf8g2OfUlG7maUliB4guJNH4cmUEQ6qoUP4FtuitEK7LsJkB2hAtHUuBaAW00PP
	4ZgadsPDiQgb36WGMTZojebaGaykAv8RcDLcOpTPR54yCJ8DUgXP6hLIMA2PV506
	4ujKQkY9ifSit/UrrmYqA==
X-ME-Sender: <xms:0Lm9adkjvea_KDT2jXFpCMRzQcK9pYxgNKzp2aab7QOZCOR2_FnEVg>
    <xme:0Lm9abYZfZmCd7pN5iW0VBZs3BUh6Pdf2KhhaYocshc-B9Vkz3qnVgBcDHKcQHgMq
    XOxthjwOhej3IcwjZQu6pCEEDANCWoBO4d7a_aF9Nz_tWO2iE-UAg>
X-ME-Received: <xmr:0Lm9aXRLQ849ZyxTAkhWphAx_SIeP_UgmnZ45WNfqbvRLjYbg5QjoHX3Kf4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefuddtleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
    veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhumhgrnhdrkhhumhgrrhdrtghhrghkrhgrsghorh
    hthiesihhnthgvlhdrtghomhdprhgtphhtthhopehjghhgseiiihgvphgvrdgtrgdprhgt
    phhtthhopeihihhshhgrihhhsehnvhhiughirgdrtghomhdprhgtphhtthhopehskhholh
    hothhhuhhmthhhohesnhhvihguihgrrdgtohhmpdhrtghpthhtohepkhgvvhhinhdrthhi
    rghnsehinhhtvghlrdgtohhmpdhrtghpthhtohepghhiohhvrghnnhhirdgtrggsihguug
    husehinhhtvghlrdgtohhmpdhrtghpthhtohepkhhvmhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehqrghtqdhlihhnuhigsehinhhtvghlrdgtohhmpdhrtghpth
    htoheprghlvgigsehshhgriigsohhtrdhorhhg
X-ME-Proxy: <xmx:0Lm9adsN7nyzWwox_AfHSoORj3c37MwE377EgQJQ1blPHfSlsTWLIg>
    <xmx:0Lm9aRHYMkO0u9lsVYbBLHjv8YbqBi50Y9L4TzQiuE20o_ezqvVb2Q>
    <xmx:0Lm9aWz7Ekr4j3EkSb_H_9_VnsAnZMg9A0gC-GaXmTfhfJK60x_9QQ>
    <xmx:0Lm9aT0Rj9D8b6PGPEmsOqia6YP-g1Nnlor4m8VbZt61LPPcjvqQ_w>
    <xmx:0Lm9aREZEN_CLWUFXEIqBN0Gjdo_m9JY-1TrApAreupfQ1D8nYr2CA2N>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 17:19:12 -0400 (EDT)
Date: Fri, 20 Mar 2026 15:18:35 -0600
From: Alex Williamson <alex@shazbot.org>
To: Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>
Cc: jgg@ziepe.ca, yishaih@nvidia.com, skolothumtho@nvidia.com,
 kevin.tian@intel.com, giovanni.cabiddu@intel.com, kvm@vger.kernel.org,
 qat-linux@intel.com, alex@shazbot.org
Subject: Re: [PATCH] vfio/qat: extend Kconfig dependencies for 420xx and
 6xxx devices
Message-ID: <20260320151835.02563c91@shazbot.org>
In-Reply-To: <20260213091403.72338-1-suman.kumar.chakraborty@intel.com>
References: <20260213091403.72338-1-suman.kumar.chakraborty@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Feb 2026 09:14:03 +0000
Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com> wrote:

> From: Vijay Sundar Selvamani <vijay.sundar.selvamani@intel.com>
> 
> Currently, the QAT VFIO PCI driver can only be configured when the 4xxx
> QAT driver (CRYPTO_DEV_QAT_4XXX) is enabled. This is too restrictive as
> the VFIO driver also supports VFs from the 420xx and 6xxx device
> families, which share a compatible migration interface.
> 
> Extends the Kconfig dependencies to allow configuration when any of the
> supported QAT device families (4xxx, 420xx, or 6xxx) are enabled.
> 
> Signed-off-by: Vijay Sundar Selvamani <vijay.sundar.selvamani@intel.com>
> Signed-off-by: Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>
> Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> ---
>  drivers/vfio/pci/qat/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/qat/Kconfig b/drivers/vfio/pci/qat/Kconfig
> index bf52cfa4b595..83f037d7e9a4 100644
> --- a/drivers/vfio/pci/qat/Kconfig
> +++ b/drivers/vfio/pci/qat/Kconfig
> @@ -2,7 +2,7 @@
>  config QAT_VFIO_PCI
>  	tristate "VFIO support for QAT VF PCI devices"
>  	select VFIO_PCI_CORE
> -	depends on CRYPTO_DEV_QAT_4XXX
> +	depends on CRYPTO_DEV_QAT_4XXX || CRYPTO_DEV_QAT_420XX || CRYPTO_DEV_QAT_6XXX
>  	help
>  	  This provides migration support for Intel(R) QAT Virtual Function
>  	  using the VFIO framework.
> 
> base-commit: b10c62483b324e60e45fb27d7fdc09c9198993d7

Applied to vfio next branch for v7.1, still waiting on a patch that
actually adds support for for 420xx to the variant driver.  Thanks,

Alex
