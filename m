Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744183BA246;
	Wed, 20 May 2026 17:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297749; cv=none; b=cwAxkIsfD0nA/Ct8I7DbY54fDgg2CP8feA58dZR3j2hd3KuCTqMm7+jJl7UYulw7J31QI9MTOxJvKd4JNSAFsZAJ1H8z5I9/yqc2+WGz3MuNiMvnoxwjLQ1KUbiA6yMX6NGddpK236ygPmqbmWdZUJ60YBH07kDRg5lWdYH62e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297749; c=relaxed/simple;
	bh=35gUX/S2pFYlMFA4BsfLPqjWTpkxjNlRQrkX9bYveKo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SwtPLzvceTCXvqOVNeUf8RrLcYuBx4i3wMjFYdf5pjP3fS69NTOBdivy/TeV5YyE4tPJHDeHCY8oGpv3zGs/KnWAKqwyOC8Cp53vkhCaLYs+/w92cUfCs1sDu46Q9VSdbCqXhx6bhUD9phTkko7E+qyPgkvoPLdLbuUQYctyNro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=xEKejN2M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pyhZSDN/; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="xEKejN2M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pyhZSDN/"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4480D7A0088;
	Wed, 20 May 2026 13:22:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 20 May 2026 13:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779297745;
	 x=1779384145; bh=s5dvkWtEODdyoI8bOKVGpIdgoX0fcCuk5jrlqtqFDrw=; b=
	xEKejN2MNN5XlBB2sNNYbYDhnNkrWsZc/y2/sEaspFQXnhE6F0IYS2uhxR0J0oDY
	08oCuoP0/GOOkWxscEGyujvYH12gw8YPy5JOdLi8oCMD2QE2Ne2Ir/gEpOgrMHlw
	wXPbRZyaZnjolilBTzhPUIbjG11YHeJT6ilEYWwWrXqCd4L8xK+HTecgP7MR0E8W
	7KGQuc7+eq9yvfxdoVLkWswezkMwyBijdhVANgkGID7qzxecI641UPQLHxgDkegB
	eNXWq3X5tejU19ugLJrAZE/x9jyJwwUzW5rml5opLHTTSd5o4yUo9eVdSWUp+RgJ
	WZEas8Ipmh9FLTOqI1aCbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779297745; x=
	1779384145; bh=s5dvkWtEODdyoI8bOKVGpIdgoX0fcCuk5jrlqtqFDrw=; b=p
	yhZSDN/dlAAgS7nL+8nwGrn0furYE39opSQHn+7mhKOtr+PPdKanoY1nqU27kjGx
	QEMWl+p47zmYNB2A5+pOglVRtEZdc9LbfnqDh/d60j9yeo84+VpzSyMaFtnJ7/Ov
	yS5cZ2oAjHEghQXHon0AL+McOe2U2mKTfi4j/+UvfitR+YpSe3Jz+h2Dj7kR/+t8
	pgzHcsdhOKT3GYjhQvguDVNT5nWSxNi+PyvSy4vx896odFJOxtWA7yyuNoVp4me8
	5BXNseW0qK2KmYm60N4bdDuql22doSBgD2c2AGezPGJqVvzlXGwEEaVMiAF7AIF/
	qMo/nUjiZ9onLRelCczDw==
X-ME-Sender: <xms:z-0Nap6uAGhrbWj-yDA9NHLz4V_JRy3eLkB7Cv0t3mXcTaCja4_1_w>
    <xme:z-0NatTLPjWhLfKiToSiSHeOTuYdBuri9V53kVMPWc1W-H_1UVL2swAh2MNcgPwAZ
    nOgNERAwELaXXM9TQNzTcT7UYPEdVr3zGJb41F2Jgsbp4a1zAIY>
X-ME-Received: <xmr:z-0NastiPVPkiyr4wY44OJk7WgUN3XBmfqc2Ryr5vn-mfIVdW_q9sngPeEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeehvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpeegudevhfejueefveduieeuueeifeettdekveekhffgvdetfeelueehgfdt
    heffhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepuddvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopeiihhgrohhguhhohhgrnheskhihlhhinhhoshdrtg
    hnpdhrtghpthhtohepmhhitghhrghlrdifihhnihgrrhhskhhisehinhhtvghlrdgtohhm
    pdhrtghpthhtohepkhhvmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hinhhtvghlqdigvgeslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphht
    thhopehjghhgseiiihgvphgvrdgtrgdprhgtphhtthhopeihihhshhgrihhhsehnvhhiug
    hirgdrtghomhdprhgtphhtthhopehskhholhhothhhuhhmthhhohesnhhvihguihgrrdgt
    ohhmpdhrtghpthhtohepkhgvvhhinhdrthhirghnsehinhhtvghlrdgtohhmpdhrtghpth
    htoheprhhoughrihhgohdrvhhivhhisehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:z-0Nav8RdxoqD3ErBvEx8eGsZeEWHkWQ-wnqJpF55QzG6z8fcsjcVg>
    <xmx:z-0NalzO25DDQ5AgJps67VEeJrUMzcMwCKyMMcKf2dfapU7_IKTFow>
    <xmx:z-0Nah_Rdzt0SMwunZQdpQr2FewfigOgo7kqD9yCWoOUoPa2of591A>
    <xmx:z-0NajPHZxyM38iyvL05FV1dk5lJB3HVgStAma7xB7pKjbedyzHLsQ>
    <xmx:0e0Nag9IV7Fx8cb0O6p3-2wCg7N27qYmWt3dftVTxmfT2EULehAbvHnC>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 May 2026 13:22:22 -0400 (EDT)
Date: Wed, 20 May 2026 11:22:20 -0600
From: Alex Williamson <alex@shazbot.org>
To: =?UTF-8?B?TWljaGHFgg==?= Winiarski <michal.winiarski@intel.com>
Cc: zhaoguohan@kylinos.cn, kvm@vger.kernel.org,
 intel-xe@lists.freedesktop.org, Jason Gunthorpe <jgg@ziepe.ca>, Yishai
 Hadas <yishaih@nvidia.com>, Shameer Kolothum <skolothumtho@nvidia.com>,
 Kevin Tian <kevin.tian@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Thomas =?UTF-8?B?SGVsbHN0csO2bQ==?= <thomas.hellstrom@linux.intel.com>,
 linux-kernel@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v2] vfio/xe: avoid duplicate reset in
 xe_vfio_pci_reset_done
Message-ID: <20260520112220.274025fa@shazbot.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Apr 2026 09:21:28 +0800
zhaoguohan@kylinos.cn wrote:

> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
>=20
> xe_vfio_pci_reset_done() sets deferred_reset and, when it manages to
> acquire state_mutex itself, hands the cleanup off to
> xe_vfio_pci_state_mutex_unlock().
>=20
> That helper already clears deferred_reset and runs xe_vfio_pci_reset()
> before dropping the mutex. Calling xe_vfio_pci_reset() again right
> afterwards repeats the reset handling unnecessarily.
>=20
> Fixes: 1f5556ec8b9e ("vfio/xe: Add device specific vfio_pci driver varian=
t for Intel graphics")
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
> ---
> v2:
> - Correct the Fixes tag to point to 1f5556ec8b9e


Micha=C5=82, any objection?  I'd prefer to include this with your ack.
Thanks,

Alex
=20
>  drivers/vfio/pci/xe/main.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/vfio/pci/xe/main.c b/drivers/vfio/pci/xe/main.c
> index 4ecadbbfd86e..cbff5af385ef 100644
> --- a/drivers/vfio/pci/xe/main.c
> +++ b/drivers/vfio/pci/xe/main.c
> @@ -135,8 +135,6 @@ static void xe_vfio_pci_reset_done(struct pci_dev *pd=
ev)
>  	}
>  	spin_unlock(&xe_vdev->reset_lock);
>  	xe_vfio_pci_state_mutex_unlock(xe_vdev);
> -
> -	xe_vfio_pci_reset(xe_vdev);
>  }
> =20
>  static const struct pci_error_handlers xe_vfio_pci_err_handlers =3D {

