Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A9C280331;
	Fri, 22 May 2026 22:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779489600; cv=none; b=IZlnC3gr7VjyswzadhjiOAK5UWTUEIp9o2FQTLZsEdCrM0NtVUsYz16m0jq+4BmA+eyY2SM5vT466ZKYGfQpw53mmlWKS83+uI1dHulsM09P8f5A7wHoEmiGWDS46UD0b8OfW2QpjhHB43+/2mgiVrrhqZzJKJMy+uZ1LPOFPn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779489600; c=relaxed/simple;
	bh=SDGPr7Rb2j+kRD6xAnhJGlx2gvNeH0fvGufBg6BHxho=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C2dpLJAbj7T/LNcCYnrsNkztxxlwOWEZEcgKEZqo2fAENnEA60YMbQXIfNj6nvLDNezxe44yMQTNi/9Z91wIcMTg5rAaDcNqhn8F0XWWGSoCrHs8LNw/Oajo0pQahiCUmS2sTR+hWDwb8UfmnwhcIywgiXRRvY2PkHzh02Yu//A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=opdeAwWf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nKYqW8TD; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="opdeAwWf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nKYqW8TD"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 825DEEC01F7;
	Fri, 22 May 2026 18:39:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 22 May 2026 18:39:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779489597;
	 x=1779575997; bh=eqSF3jB5yqkd0qgehm9q9doBWmhsdcYrAlhcRlBWpbA=; b=
	opdeAwWfB47rYcgAs0P3tb4L4G1h1weuwG9xXJQqI27dS8oX/c7tFcQ0mWmn6Kur
	vCkZPE4oqgmZ5azY5FxqI6YyKPHzqufM6JRF/Z72ibHB/5qEczTlXSJ7ONDCZeK4
	BylGKYFjPMYIXdpdLx6yKtg7UBGKua2jePltfIOvZCSXc/urpMo2Iri4EyO1ldie
	V7tvuduGqq+QB2MIMph8VTePEiCgg8J28CGP9ZrfaB92jFRgeXOLmR19/k81ZmkW
	iOjS9WJbg+3iOURqYYpHcMq5BOqARbUKRQl752K1Na4SVYR7kjEUZhadE+Gx5vG9
	f8swXMIY+ym7NdnHb1UEqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779489597; x=
	1779575997; bh=eqSF3jB5yqkd0qgehm9q9doBWmhsdcYrAlhcRlBWpbA=; b=n
	KYqW8TDwj7u3jSpYbvhDY8RquR2onVW2vIrf8SI/hQQjRQ2+z0ZzpDIJ4xzKcapT
	wgm+iDJ6bpX0mLaLGPYBfR5bFoT/8IBwMDzNvFa3EEnRBjTS1Rb/Tcp7zieUOgU2
	VRd5Hjl0DQfry0XUmzArufKgloRZ3ozXzVWn7Lp31ZL/TBx2YjJ7pC8GVsC4Xgmi
	5b16/hs2rFHDAuDa1jx+PeV9ZTyD7M87C0DBNJpbN7l1YDFl8oa8IpOk3+xoF7Nt
	mDiaRlA+yP7svs5TLKjE0/ivoqiWHgjsv4S+2Qn87OZcVwWfg7zFZ0mmmKL+QfT+
	i8SU8Nrv8QQb3AL6YkJlQ==
X-ME-Sender: <xms:PdsQavq_H7jJnefBVYsBH6_MCgMSBJVl7EhjSwthM58Sds8vGHY8zA>
    <xme:PdsQarKDGDguAqv5G1B6BIzgVlHpR1_NvWuVWI2AI8qm1FWPY1byFj6Tcn1Z4Cfot
    JSHrJwcWxv4x2uHAZLrroxWhaueu_eyuInbXe1_DafZbNvfZjceyw>
X-ME-Received: <xmr:PdsQasS77-FSuys0oP5K3SBbo13ctowdsceKCdzHKRXZdR2nrEabt3R_Uwo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduhedufeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpeekheejieetffefueeiteejtdejffdvleelvdeuvdffvdefteeghfevkeeu
    vdefvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhg
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrg
    htthgvvhesmhgvthgrrdgtohhmpdhrtghpthhtohepkhhvmhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehlkhhpsehinhhtvghlrdgtohhmpdhrtghpthhtohep
    rghlvgigsehshhgriigsohhtrdhorhhg
X-ME-Proxy: <xmx:PdsQaitkcarzBB1svU7iw35O722euwfXKPDS2reHi-DxytzogQgRRQ>
    <xmx:PdsQalaQI2q0xh29XntfvqsNvomoqE4rxoWmLZnbFnEj1Adcwz2ZqA>
    <xmx:PdsQagH6ir_PQn-QGuH6o5O3S8BiJ1JmE0osQttlg6-6Kktu3JLDtw>
    <xmx:PdsQahyzeAr1EaFZFTUYWm5j7yvqKhZaYU2XYOTqAQ86EvpwfnDIbQ>
    <xmx:PdsQaqdChEYZPfYVkFP-4I_a3aKcebcOtJLsUDOYxLxd9geK7_7GZjya>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 May 2026 18:39:56 -0400 (EDT)
Date: Fri, 22 May 2026 16:39:56 -0600
From: Alex Williamson <alex@shazbot.org>
To: Matt Evans <mattev@meta.com>
Cc: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, kernel test robot
 <lkp@intel.com>, alex@shazbot.org
Subject: Re: [PATCH] vfio/pci: Fix sparse warning in
 vfio_pci_core_get_iomap()
Message-ID: <20260522163956.3d39bfd6@shazbot.org>
In-Reply-To: <20260522124215.3268565-1-mattev@meta.com>
References: <20260522124215.3268565-1-mattev@meta.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 May 2026 05:42:11 -0700
Matt Evans <mattev@meta.com> wrote:

> Use IOMEM_ERR_PTR() when returning a void __iomem * rather than
> ERR_PTR().  This fixes a sparse warning, "different address spaces".
> 
> Fixes: 859dc0f6253b ("vfio/pci: Replace vfio_pci_core_setup_barmap() with vfio_pci_core_get_iomap()")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202605211601.U1OvmuqY-lkp@intel.com/
> Signed-off-by: Matt Evans <mattev@meta.com>
> ---
>  include/linux/vfio_pci_core.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 7accd0eac457..4fa129fc5c64 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -244,10 +244,10 @@ static inline void __iomem __must_check *
>  vfio_pci_core_get_iomap(struct vfio_pci_core_device *vdev, unsigned int bar)
>  {
>  	if (WARN_ON_ONCE(bar >= PCI_STD_NUM_BARS))
> -		return ERR_PTR(-EINVAL);
> +		return IOMEM_ERR_PTR(-EINVAL);
>  
>  	if (WARN_ON_ONCE(!vdev->barmap[bar]))
> -		return ERR_PTR(-ENODEV);
> +		return IOMEM_ERR_PTR(-ENODEV);
>  
>  	return vdev->barmap[bar];
>  }

Applied to vfio next branch for v7.2.  Thanks,

Alex
