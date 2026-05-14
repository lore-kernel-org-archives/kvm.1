Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60747335568;
	Thu, 14 May 2026 16:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776758; cv=none; b=tVKq/Ei43vnXqzkG78yVwJBLejBdGRZboO/XMzOLlv6r0rBpW+4/R6JB9dsOyO9rOCP2xGXma7sqOa3QZPI28KloCZZRvwGwsAAg1LE6QNY+0U4u1j1KWX9yb9gTR2mELZTb/UqfZqC21pxVY6yYZnZDVGbITJXSMgOc6wBcdrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776758; c=relaxed/simple;
	bh=vtA4sIh++v3UOY4kvPflIjCCSYu+4sL2kS4tIGC5ar0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+OWgXiAGF8gVIBanENebqYR99RupbPCzF3tSiYSYfw9a7nOueHVvWp4TvatEXcJw/mLtEliyG13Z3vqs7B1dSIZTA0Cne1n21YgPssUcfydh8ZCFHnBbV4+83Ezx7nNstWWkZo+2XJNi23Fhv4cmgC7aCYibiEAbGROjpOVlp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=qmseMhdu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mdzz7b8x; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="qmseMhdu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mdzz7b8x"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AFF79140016A;
	Thu, 14 May 2026 12:39:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 14 May 2026 12:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778776755;
	 x=1778863155; bh=1wJ5BqxzR5GOdUlMb41jEqgSMUUMA0drNvjzlbeNHa8=; b=
	qmseMhduWEz3Dg3YGuFyLXy5TLj1A6xYYZQ6kIFhNTqaBWlCqr1YRsPLzayxfrnf
	aPrD4lIufEnIrHY78dbQpVEjE/YFE/6fjN1AQbvSPgJja06ln8UwAxtdDNquJXL7
	9KiP8TaAEDmhTDBbo6b05l8z3uXOtXsEc1Oa41QZYaY4mZAZ65av46kT+lQb26TP
	Jv23Ra+0u6HaM1DGawXBDGriIgcdhNVJF+/RFki3KulIts7wzbYqqKWiLXkTnbIi
	w/wmyZo9OHdgd/zYejhwOCjk7k9dZqsmPevquL1kapAJMKvLHYn/brnLEOv4ueZO
	7W8R/RshlBdNiiJ2OEOX2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778776755; x=
	1778863155; bh=1wJ5BqxzR5GOdUlMb41jEqgSMUUMA0drNvjzlbeNHa8=; b=M
	dzz7b8xUYX31b7kbHMu4IOIBaKneOHPuF7aLcpmYXes2NKR9NwWM9g++x24Ng7z8
	NWYt3bBHhME9nWestWjumzzDi3U+xMyfrRsOjs16VIR3NLMRZf7Ho7jcP6dZfiUp
	lCloMZyTSxze04kjggiJiwq9A+2YCrhLdZDvSktTqD8O71HIWUb0TVEnAlKzH+Vz
	JsZxpmWvVBHPiop/VX3q7Lxd4+DWO94sgGUQmY0GTRlItYVmpa9KR3xkWtNznwjn
	R8y+s0/BkzdjtfyoBmaoR6msxrFsp3qfHL448DAY0KmD6Od/QOk4XAHJiVoVrS8+
	aQNPedsa6Pfxm0bap2pIQ==
X-ME-Sender: <xms:s_oFakiebnX2MVlYogi4ZXzGS-mvL3Rg-8Ujok6PIzv5R_8KmKqwjg>
    <xme:s_oFaq0izpWQOvWSZrlLV1TJ87Q8fqkOivQriS7AyrmHKobqVONtnWHwD7uHc_tK-
    Nj4EYrd-jbm4ARFGlEwvF6xhWN82jERu7eDO2y9CwVD7dg2cjw>
X-ME-Received: <xmr:s_oFamhnqaY-NfZGdLCURVzVuR-DW4BX_GbHRsJUi0N9JTRmbdvpyXIkhVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdektddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpeekheejieetffefueeiteejtdejffdvleelvdeuvdffvdefteeghfevkeeu
    vdefvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhg
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrg
    htthgvvhesmhgvthgrrdgtohhmpdhrtghpthhtohepkhhvmhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegrlhgvgiesshhhrgiisghothdrohhrgh
X-ME-Proxy: <xmx:s_oFaifFfvsqkvzYKcQDwPfVVBgpJrYq4Op_Q_KLQBuuHRlKnhsScQ>
    <xmx:s_oFahkP-hNQs1RMdXVrpdlZF-KGq8thEkuwdGCAcIaCMHouVZB6ww>
    <xmx:s_oFajvKQd8FnIR_1mNgvIE4O9LDaXK5sjY9AvvUnM9G9FCEY9m-tw>
    <xmx:s_oFav-vKmaOrdVniwUhnIguybIX2wGMOuRja2uHmoZDvnMFqQyV6w>
    <xmx:s_oFamYH_PWy1MlQUva2RIckk639Atv3wL_5nbV2hrYgDIbQGlZF6qJU>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 May 2026 12:39:15 -0400 (EDT)
Date: Thu, 14 May 2026 10:38:26 -0600
From: Alex Williamson <alex@shazbot.org>
To: Matt Evans <mattev@meta.com>
Cc: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH] vfio/pci: Make VFIO_PCI_OFFSET_TO_INDEX() return
 unsigned
Message-ID: <20260514103826.1145617c@shazbot.org>
In-Reply-To: <20260511144642.2926799-1-mattev@meta.com>
References: <20260511144642.2926799-1-mattev@meta.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 07:46:42 -0700
Matt Evans <mattev@meta.com> wrote:

> VFIO_PCI_OFFSET_TO_INDEX() is used in several places with a signed
> parameter (e.g. loff_t).  Because it makes no sense for a BAR/resource
> index to be negative, enforce this in the macro.
> 
> This fixes at least one current issue, where vfio_pci_ioeventfd() uses
> this macro with an unvalidated signed loff_t returned into a signed
> type, leading to a possible negative array access.  This instance does
> test against an out-of-bounds positive value, so treating the index as
> unsigned fixes this issue.
> 
> Fixes: 89e1f7d4c66d8 ("vfio: Add PCI device driver")
> Signed-off-by: Matt Evans <mattev@meta.com>
> ---
> 
> This patch follows up on a nearby issue found during review, discussed
> here:
> 
> https://lore.kernel.org/kvm/20260508114552.6f5b99f0@shazbot.org/
> 
>  include/linux/vfio_pci_core.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 2ebba746c18f..89165b769e5c 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -21,7 +21,7 @@
>  #define VFIO_PCI_CORE_H
>  
>  #define VFIO_PCI_OFFSET_SHIFT   40
> -#define VFIO_PCI_OFFSET_TO_INDEX(off)	(off >> VFIO_PCI_OFFSET_SHIFT)
> +#define VFIO_PCI_OFFSET_TO_INDEX(off)	((u64)(off) >> VFIO_PCI_OFFSET_SHIFT)
>  #define VFIO_PCI_INDEX_TO_OFFSET(index)	((u64)(index) << VFIO_PCI_OFFSET_SHIFT)
>  #define VFIO_PCI_OFFSET_MASK	(((u64)(1) << VFIO_PCI_OFFSET_SHIFT) - 1)


Applied to vfio for-linus branch for v7.1-rc.  Thanks,

Alex
