Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F732FD1B1;
	Mon, 30 Mar 2026 22:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774911269; cv=none; b=FvRpuSXF3YkXclWAhsbv7tgiPIxMYPEpkUnShSkOeFiilgOaov/lLTl+A/oEoTgQdvQs7d8H2dQc9GuvlENIzi373gH2HnGYdiJ7o4BD1WPohFVSnVWyiP4r0ydj7VAtHSRX/2NbpBzB2tFnYpdMnSYIVKjba5VIoxRvKHlHtQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774911269; c=relaxed/simple;
	bh=XB+uJn26PmfEfJKpVP8DtZjs6bdt6IME2HC6rZ1EWpc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PDuM9m/YkopBVS97sRaBGS6upNJor77rYoXmhWl9pu/Ves2ralN0fWjq990PeqqJBOh5uD6a00pocGzHQJFEiNOhxGV/KMkw/QfXOWde/Az8gdoTfwA2vjPbRwkU3kK9Ton/Q23zDcD7ePDWCwJ2K8qZQAVU+jq27Jxl3A0MqBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=ecIfosvH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zSoVBN2g; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="ecIfosvH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zSoVBN2g"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DB8B7140022E;
	Mon, 30 Mar 2026 18:54:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 30 Mar 2026 18:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774911259;
	 x=1774997659; bh=sCkpUC+NoKdnBDlXEHtHCzIQfMfGf/uroKBhPz5nPGg=; b=
	ecIfosvHryxFBhEdIzeeGEeMsBDzv+PLKzNVt5rxzwHm+a2dz2hzzPmVdgioHHWX
	qezZRiZa/z4ZuiAQY3KJRE2fxkagkF6pL5wgdIvaVUPO0BdUsaWjCI8AEInn2j7u
	xB2sl2+YOT89vqbTNJKbQ8WU0qUIppIAmXnW/VX0f9VNQSYJnGpI/8yJZJ3V60zg
	8HwEkMlDmn9xoTnb1iCXyL32mgM/Il+Tkar1gY5X6B1zeY2S7mWjZY6zq/0ZhR3I
	Ft+8/m7mQmxQr8/g7P75x0eplUkdGb0MjO0Tng76WqBV1v14zYCHuU/u2+Kl01hs
	HAi/V0W7oxaF9idGHY2dMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774911259; x=
	1774997659; bh=sCkpUC+NoKdnBDlXEHtHCzIQfMfGf/uroKBhPz5nPGg=; b=z
	SoVBN2ga/2Uhy/nEx6gHs4VoPH7LfAuEOZRgb8VmLtcRqj5DUcJrKdy++RTjA+Oj
	XOAV25E43vBWetbtZeIypmde5C6/XLUU1t8ERrdPR7JYkx83GLVq1JI3DlTiCD2f
	zApZvMlGbteLkXdwbp/lZZdHJFGYJ6ouh061dz4n/xsbb8y/Y7fSMORIt6zK2Ab/
	Tef+voEsi+t+pYqqizAcRPqhshv+u6AtbPutugmROfP2AR5B9JCY+rTNquSbH8OY
	/fVJT9pHde9dpfvVRU+5SJe0Qkaotm+cVG4f+meAvfhtjXenLLm1AcZse+kXmz/4
	BE4lI5DHYYz1PHxwUyTkg==
X-ME-Sender: <xms:G__KaT55MEGTHEdNzGPMfrZHavwBdCeKTjzpGhdqWha38bcRFrCpxQ>
    <xme:G__KaS5xokwgIH-KJ1ss-WrnnTeb584poe_J7e1auNQtihy5BUq7imTGIghupByXJ
    u8EuCNoeWCoiYk79JahOQsWkMahpngc-co3q_kvwbz9ISbMialJKw>
X-ME-Received: <xmr:G__KaRETgPUqfCQNaIVcPiW0XNL8FxORbRToOTFQtwCdA9m99qyR_BK_bDY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefgedtvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
    veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopegrrhhnugesrghrnhgusgdruggvpdhrtghpthhtohepkhgvvhhinhdrthhirghnsehi
    nhhtvghlrdgtohhmpdhrtghpthhtohepjhhgghesiihivghpvgdrtggrpdhrtghpthhtoh
    epkhhvmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhk
    vghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgiessh
    hhrgiisghothdrohhrghdprhgtphhtthhopehlihhulhhonhhgfhgrnhhgsehhuhgrfigv
    ihdrtghomh
X-ME-Proxy: <xmx:G__KaSViDctjQc7TIn5ENQkZ1cyborywCIDuG6ENzBew7c5QdwB8Xw>
    <xmx:G__KaVVYv41TZdFR7AwlmfCe4t_gjqD-OWgGc-C4QP4AdDxkWEqktg>
    <xmx:G__KaYLa5JodFHng-LFBj7T4lNhayBo0Cc7mZ2ngd-Nujgk8sOsMdQ>
    <xmx:G__KaVCqt0JuL9tQw-EZn4asnMdbts8cLOho6Ri5suteih6gpZaNIw>
    <xmx:G__KafCecm2HLKecrGjY4nh9s0LeSS5t5Y9U9002cAoxNvpc4UR10lPd>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 18:54:18 -0400 (EDT)
Date: Mon, 30 Mar 2026 16:54:17 -0600
From: Alex Williamson <alex@shazbot.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Kevin Tian <kevin.tian@intel.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, alex@shazbot.org, liulongfang@huawei.com
Subject: Re: [PATCH] vfio: unhide vdev->debug_root
Message-ID: <20260330165417.23136f80@shazbot.org>
In-Reply-To: <20260327165521.3779707-1-arnd@kernel.org>
References: <20260327165521.3779707-1-arnd@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Mar 2026 17:55:08 +0100
Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> When debugfs is disabled, the hisilicon driver now fails to build:
> 
> drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c: In function 'hisi_acc_vfio_debug_init':
> drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c:1671:62: error: 'struct vfio_device' has no member named 'debug_root'
>  1671 |         vfio_dev_migration = debugfs_lookup("migration", vdev->debug_root);
>       |                                                              ^~
> 
> The driver otherwise relies on dead-code elimination, but this reference
> fails. The single struct member is not going to make much of a difference
> for memory consumption, so just keep this visible unconditionally.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ----
> This seems to be a new build failure, but I could not pinpoint which
> commit caused it, as both the #ifdef and the the use were introduced
> a while ago.
> ---

They were introduced some time apart, but I'd attribute it to the use
here in the hisi_acc driver, ie. Fixes: b398f91779b8
("hisi_acc_vfio_pci: register debugfs for hisilicon migration driver").
The series introducing debug_root had proper stubs to avoid references.

I'll add that on commit, otherwise LGTM.  Thanks,

Alex


>  include/linux/vfio.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index 50b474334a19..31b826efba00 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -74,13 +74,11 @@ struct vfio_device {
>  	u8 iommufd_attached:1;
>  #endif
>  	u8 cdev_opened:1;
> -#ifdef CONFIG_DEBUG_FS
>  	/*
>  	 * debug_root is a static property of the vfio_device
>  	 * which must be set prior to registering the vfio_device.
>  	 */
>  	struct dentry *debug_root;
> -#endif
>  };
>  
>  /**

