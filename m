Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAF0374E5C;
	Wed, 20 May 2026 21:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779311543; cv=none; b=gbv1gW1fQLrSLafd9TFhgLIDgMr+YpuD8pXQMWwtmK8Z/R0gOSiGzIhEhdB8mvGDNDm90AVK5Tc192QmNXoJAKaDEio7ZdKepK0GlFZzI1u/I0n1dxrJfna76c0JapvCsoyxTRVfRUwZV1XwnKrR4CzFnSIq0+7t4oBx9jf0eJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779311543; c=relaxed/simple;
	bh=ulSfgGyYw7VOUANwRTn1j/EWkbjdRqLJGoV/zxqYayc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j9hbL8vRpTMyZ/ZevtgwTAjn+UBA/aNdMGJMp1XKO/Tv8fdswcPfsVLM7o+ITiDaoSULdQjlm15pwpUfgdbbNzHO/8OjNDB572JfraOMo+MzBepdXhQlxhpZJBgZDLwc353+tE9rJZBgLWkHScxmPKAG9myEXFUmK1gtyIa1k6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=elrZi0qL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TzdSlEuS; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="elrZi0qL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TzdSlEuS"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 271131D00081;
	Wed, 20 May 2026 17:12:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 20 May 2026 17:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779311540;
	 x=1779397940; bh=5k/9jPpWGDGcEMF/bmG/vs8SGE4A/CpYhh7jbzbwZpQ=; b=
	elrZi0qLLLWTDcLQWcUofmO8AYPGiufOCznqatYUBdv4mJEdjkT40faMrIsXxJQo
	LSeyjG8UMZ4C+68Uj929OEsX6LYr+NCboRqhEU4oEDPeBNhp9BC1W8VVt0yUjhum
	+xAKLWt680v8XISil1aSTKDrryVLWuLc5lcuBDeTgj2RDeoflFHWZEzAnsmi9756
	OxIohjscpz3T/VdahL/31WXxMWksY8oE0Jy8Xs37nnR3o5IPtXockkCR1RZrDvpm
	nesNomab9mEac8mkfVjbAzbQXFNtKO4gS20Xonj3qLDIGCUP6qAVx6hnWCsWNHDv
	SfYdx0iOr7B8yWxthoXAPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779311540; x=
	1779397940; bh=5k/9jPpWGDGcEMF/bmG/vs8SGE4A/CpYhh7jbzbwZpQ=; b=T
	zdSlEuSeVGHOr4YbKcguUjPKakTGjRqy/vYnf2KsWxKEAcR/YciBiBgfBo3jEdmd
	QAcXmSyKSQfRsNrVwV6lZ8O43U9gPTN2VSFstfbX/oSX0KRw/yX/XsR7aWW6OX6w
	xqailxjwcwXjM/I492fMeRbQJ/H0iihS3iYzP9MzWy/4HIyHT2QCO2iW3gc3JSHe
	uQRTKr1SvBLraWhsA3mm6kczou/OwbJ0BSI+o4NRn3k1jgoNS+L/1Sb6QCPTg1pj
	jrnY/NdXn6Crhb9hcYboZnpq19gkHbTvy2uus7Gl67Gmt5Vd55Bytk93F4fKqPOH
	HJMKhQU/9UBaEYvcWjF3g==
X-ME-Sender: <xms:syMOakNumz6TT4UOhcJ4y1WWLcxCu1No0V7al2n1EtZrkzDqk64L2A>
    <xme:syMOahWjbF-JVXtFuRFzMVs2dcqXOdHF2hKIVWH0XEB7zvMxZ66xwyMy305S-1pAn
    zksng-NyVrcGh6Cx8W-oicnAdczpf_xbbFSza_xecUrWav6yH_QmG8>
X-ME-Received: <xmr:syMOanhvEkY7iJ8asX-Dq08-owllIHkP07K9_lHB0eQvt-0ewD6ugPUKnIE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeehieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
    veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepuddvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopeiihhgrohhguhhohhgrnheskhihlhhinhhoshdrtg
    hnpdhrtghpthhtohepmhhitghhrghlrdifihhnihgrrhhskhhisehinhhtvghlrdgtohhm
    pdhrtghpthhtohepkhhvmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hinhhtvghlqdigvgeslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphht
    thhopehjghhgseiiihgvphgvrdgtrgdprhgtphhtthhopeihihhshhgrihhhsehnvhhiug
    hirgdrtghomhdprhgtphhtthhopehskhholhhothhhuhhmthhhohesnhhvihguihgrrdgt
    ohhmpdhrtghpthhtohepkhgvvhhinhdrthhirghnsehinhhtvghlrdgtohhmpdhrtghpth
    htoheprhhoughrihhgohdrvhhivhhisehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:syMOaqjlDJ6hyjuZhro5JKhpvBa0_C1GMi21Lsl0C8IsXjayfYgodA>
    <xmx:syMOalHDnOFCNz0Un4u_HT7vyxa3zExU7iABb4TH7dDvH1k2-70YXw>
    <xmx:syMOanA7kEFcahGm3d534NKHgycTsvUJ8mSPU6urSWOyAesMs-YNOw>
    <xmx:syMOarDR_eSSyFkYy_Dhmpi616eRY8IE14cfvt6Tgd0TofkrbEQrWw>
    <xmx:tCMOaiildLUJuSCBmWxhe4J44m_-7q_73F24xbKQBwv4a8G13TQnT93A>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 May 2026 17:12:18 -0400 (EDT)
Date: Wed, 20 May 2026 15:11:43 -0600
From: Alex Williamson <alex@shazbot.org>
To: zhaoguohan@kylinos.cn
Cc: =?UTF-8?B?TWljaGHFgg==?= Winiarski <michal.winiarski@intel.com>,
 kvm@vger.kernel.org, intel-xe@lists.freedesktop.org, Jason Gunthorpe
 <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>, Shameer Kolothum
 <skolothumtho@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Thomas =?UTF-8?B?SGVsbHN0csO2bQ==?=
 <thomas.hellstrom@linux.intel.com>, linux-kernel@vger.kernel.org,
 alex@shazbot.org
Subject: Re: [PATCH v2] vfio/xe: avoid duplicate reset in
 xe_vfio_pci_reset_done
Message-ID: <20260520151143.2ca4296f@shazbot.org>
In-Reply-To: <20260427012128.117051-1-zhaoguohan@kylinos.cn>
References: <20260424091719.58800-1-zhaoguohan@kylinos.cn>
	<20260427012128.117051-1-zhaoguohan@kylinos.cn>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Apr 2026 09:21:28 +0800
zhaoguohan@kylinos.cn wrote:

> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
> 
> xe_vfio_pci_reset_done() sets deferred_reset and, when it manages to
> acquire state_mutex itself, hands the cleanup off to
> xe_vfio_pci_state_mutex_unlock().
> 
> That helper already clears deferred_reset and runs xe_vfio_pci_reset()
> before dropping the mutex. Calling xe_vfio_pci_reset() again right
> afterwards repeats the reset handling unnecessarily.
> 
> Fixes: 1f5556ec8b9e ("vfio/xe: Add device specific vfio_pci driver variant for Intel graphics")
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
> ---
> v2:
> - Correct the Fixes tag to point to 1f5556ec8b9e
> 
>  drivers/vfio/pci/xe/main.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/vfio/pci/xe/main.c b/drivers/vfio/pci/xe/main.c
> index 4ecadbbfd86e..cbff5af385ef 100644
> --- a/drivers/vfio/pci/xe/main.c
> +++ b/drivers/vfio/pci/xe/main.c
> @@ -135,8 +135,6 @@ static void xe_vfio_pci_reset_done(struct pci_dev *pdev)
>  	}
>  	spin_unlock(&xe_vdev->reset_lock);
>  	xe_vfio_pci_state_mutex_unlock(xe_vdev);
> -
> -	xe_vfio_pci_reset(xe_vdev);
>  }
>  
>  static const struct pci_error_handlers xe_vfio_pci_err_handlers = {

Applied to vfio next branch for v7.2.  Thanks,

Alex
