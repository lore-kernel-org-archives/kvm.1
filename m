Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DED23382F1;
	Fri, 24 Apr 2026 16:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049274; cv=none; b=Q0jGgZEE/Bdy0IsgM7A6lb8Q6NTek80wM38LbV6lfLevXDgdDznc/SWXBIT3A6b2o7M1OJsUZ0M+BapD1wvEctiMSUKRPJMpcJcUNB3uB0rP+kzlZZFzeq43Exnnkzs7J6AwaGQylcy6zvhUYSqrJqeY0xmqC2IivZtItjt11mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049274; c=relaxed/simple;
	bh=gENH9TGkQDYl78NenjJMAT0POflf4FdKC1rHTQPBodA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YEXkvTzvuHES0Ub7u4ssZpjOYFR2LXK6HJ+xpWOVDDf4fApuI3fjpN+3Ys1s8CCArbF81GzR1Hu+d/6ttbLH8Ku/ccnD6jwuw7T1OIqtrV8OA+DPV96rN09t3gfAShL5OaIXslpvOUsojsZtNOV9glWihd0rQTJU6uyM0z1e1D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=EoJ/eNa/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BcEsU73p; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="EoJ/eNa/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BcEsU73p"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 51AD51D000BC;
	Fri, 24 Apr 2026 12:47:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 24 Apr 2026 12:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1777049269;
	 x=1777135669; bh=7Jd/Ldgk0Yk4g9VO8dVen6H3KA5tpa2J0W6BFBzbq3c=; b=
	EoJ/eNa/eezbMRB/mnmXbB8jLcH0ZXi22EkoUjlYQBjgNXO8evjCQI0AE5cNPFAr
	oOptOl6e7kyaN8nvmWux+5RijvbUasBpUj66Sk3maNCJfD2lfwd22UFSzg8BSJUU
	9r4pK9moEtH95NKu4qrBMU+QeLvJBvCB2KmmU0ZBJYggenS5H8ox5ORG2pFPgday
	C46rktOgqdwSGnWdVCgfyTpvv7ybycknZaUJgBD+moe2woRNkmzwXsY4JwZ+pnOn
	+9aLaMCwKbQY5/CCe/e7r2Dlzm9fr4kie31jYTcHL5QKzj4LZj6s7DGOA6xs24Rg
	x791a5WTSDyOOOu0Ui4zoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777049269; x=
	1777135669; bh=7Jd/Ldgk0Yk4g9VO8dVen6H3KA5tpa2J0W6BFBzbq3c=; b=B
	cEsU73pEG0Ar6OLfCDdyAkMDmYI1tN81ha1PZv5j+ocOUhrw4mHTYvNWb5NkiNxD
	S61QaE6K82j2ODZ2CqXXuPEu3CzDxutXoa2vaWnPVew9b342I7+HZMNf4GgFHbt4
	KHuTiuiGSOLpkj2sPLzqrw0nwbnuhDM5/ruACzFgS3q6MyIuPQnd+5lsIUMQWTap
	NWZw+jmlSqZmlKVI4KUeU3qTNfijyXXSiNt3LTBVTHs5Jyp9242pk27qL9VbXFLq
	WxyoVe2pNMheeA9kmdxsWV8AM468b0cvshtpbUKVQHzSXbrhnlRH+4Sy4iOM/q3M
	OKip+KveWkzb76OIAaA2g==
X-ME-Sender: <xms:tJ7raRRRyKd1Xi0U5826oESesMsnYK_7ZvB4dkx0mnKTcwoNSzL--g>
    <xme:tJ7raQz1lFh6cWDYmVSQ2rb1KdcWuWulYK5XW6VMY4KypOxMeiIAmOe_5wH3swbZH
    DIciH7a11-bYPmtn2LHwh_esbivTghmGJi9yoPkwxs8csi99sWO0w>
X-ME-Received: <xmr:tJ7raRqHZW61wBt2qcaf6Y686Qn-DTjd_oJhZuojCfImc7ZWdgTpquOHqFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejtdehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfgjfhfogggtgfesthejredtredtvdenucfhrhhomheptehlvgigucgh
    ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
    htvghrnhepvdekfeejkedvudfhudfhteekudfgudeiteetvdeukedvheetvdekgfdugeev
    ueeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hlvgigsehshhgriigsohhtrdhorhhgpdhnsggprhgtphhtthhopedutddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepiihhrghoghhuohhhrghnsehkhihlihhnohhsrdgtnh
    dprhgtphhtthhopehmihgthhgrlhdrfihinhhirghrshhkihesihhnthgvlhdrtghomhdp
    rhgtphhtthhopehkvhhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepih
    hnthgvlhdqgigvsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthht
    ohepjhhgghesiihivghpvgdrtggrpdhrtghpthhtohephihishhhrghihhesnhhvihguih
    grrdgtohhmpdhrtghpthhtohepshhkohhlohhthhhumhhthhhosehnvhhiughirgdrtgho
    mhdprhgtphhtthhopehkvghvihhnrdhtihgrnhesihhnthgvlhdrtghomhdprhgtphhtth
    hopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:tJ7rab3yBRMN8FZR3c60I9sDu4Wmcui2PW7yf2WAwxTjjP-svV4Szg>
    <xmx:tJ7raZzqVKem2nSByBtTXZ6QCLINNq62-Jc4s9bkYcK5hudQTI4QOg>
    <xmx:tJ7raXiSOHwxi15Uh2_kNd2TDDch0jmVPXcL0X2Nee5QRYPbs6V4_A>
    <xmx:tJ7racpwnMVY2ACtaDsoaKQcv7zu5dc709cMzUxbZCAy0SnbZOt_wA>
    <xmx:tZ7raSksUkz3-w8WeL3oi7cIAPpO186vl-7h3E1PVMtTYMPcp5BtUYCp>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Apr 2026 12:47:47 -0400 (EDT)
Date: Fri, 24 Apr 2026 10:47:45 -0600
From: Alex Williamson <alex@shazbot.org>
To: zhaoguohan@kylinos.cn
Cc: =?UTF-8?B?TWljaGHFgg==?= Winiarski <michal.winiarski@intel.com>,
 kvm@vger.kernel.org, intel-xe@lists.freedesktop.org, Jason Gunthorpe
 <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>, Shameer Kolothum
 <skolothumtho@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 linux-kernel@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH] vfio/xe: avoid duplicate reset in
 xe_vfio_pci_reset_done
Message-ID: <20260424104745.03cfcebe@shazbot.org>
In-Reply-To: <20260424091719.58800-1-zhaoguohan@kylinos.cn>
References: <20260424091719.58800-1-zhaoguohan@kylinos.cn>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Apr 2026 17:17:19 +0800
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
> Fixes: 1b81ed612e12 ("vfio/xe: Reorganize the init to decouple migration from reset")

Change looks good to me, but the Fixes: attribution is wrong, this has
been present since the original code in 1f5556ec8b9e ("vfio/xe: Add
device specific vfio_pci driver variant for Intel graphics").  Thanks,

Alex


> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
> ---
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

