Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4264E403B16
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 16:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781283379; cv=none; b=S/G5TNJaklPLCcr5sdNfWDwGFu9irqPz8hBXlEZuLsbjnx9h3u6cWtx6kFCLL+PuBWiL502T1K2vce+TtBhshhWVfYjWmjbfUb+6G0eh7SfadjNvAEikPdknBLvgh1H/vW82S2TVSVz9ulIou3VXO4T/gkiaf5KkxQapcC/ySwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781283379; c=relaxed/simple;
	bh=v3WiaeTlbY5dH+otynGl1JZQfCqSX3lDNzERYr6DFj4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZR5LqNCzoT/pG2XY2Indpp0t9Xh5AxZCQ9P8nEB7rrkImX6vXbQ4HlQkUlmgPPSCuy62ynR0Xqok7l3Diw36bKn6XTv1D+IFTID26bNk4j5l4MZDShoHvMTQlbmVNJJNPnc/b+x5DCdDdt1iZWoYhBhULL5yqiNA3VmzDp3TxSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=EDxxCUsX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LMeaTFFB; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="EDxxCUsX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LMeaTFFB"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6B998140007D;
	Fri, 12 Jun 2026 12:56:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 12 Jun 2026 12:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781283377;
	 x=1781369777; bh=u4h+BJPAtjjUrlElyWW3zXcraqn5nf9zPyfNGiYuFLw=; b=
	EDxxCUsXyJAaCoTVjpYGY0FXeUdayNMj+n1PR00upyKp1UAErfrpd5uhYU1CM313
	LYonZppSDuymCw+sf/HaIEf1vj4HQtH0a4g23nNjiGIAEyuRvGd8E7vXY2p+Hx79
	z8L5LNe2Ng8qQU1U4S1ADySE3VCSTdI3Bef2ZTZ7yk6hbEDiL+sLAxVRl2JHEJGM
	9haxHvG3ZPz7zsdoO5H0YByw0ir3DLsWMASu8aDYEEjjfsbSPCE1KueUfm7dmqbC
	bIXzd3DcFuO8jEpsoPyEGy2VbSGCREbTz3ZvOYwiD/Va5OWW1IepX/WygDUolZN/
	qUnASR/RrHGyujoqsp5cQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781283377; x=
	1781369777; bh=u4h+BJPAtjjUrlElyWW3zXcraqn5nf9zPyfNGiYuFLw=; b=L
	MeaTFFBU3/z9reKoN4EeuRrS8ZpOQVi0EcjR3zmHwNAHFaV0n22tINpsDocmdEyJ
	LEtRs6wtSTniV8YY+aBC/gs9cIRWjrwZARBtnGcqdBaGj115g/HzUQndYdkIeF6z
	j98NGWJ2VIVvHgDZxQwIwnbIa1pAir938yVStm5Pcva4E8mo8wWw7K1TPqWbI0NJ
	JYewMzvRwIeebvGECp19FHp87fSjoNPjbS92qzJRBpQQv+AQRLO+tqgVYvbnasci
	CejDDti6xusa1JYfalQmzaaGu6t13FeQ2Kul6vsEm4c0t7eW5mfr9Plr78wkz4mk
	bJd/vunDy6Pw7lzONLsww==
X-ME-Sender: <xms:MTosaigNJalPnx2004sA6_47irgSTp02HH8RhXW0FHpdm76gZVob5w>
    <xme:MTosallqLFIJ-qjt64z4AuonDU7QzuHM5WJ7mY7BAP-w5Ij-iUmtEDld8Ofj43b-R
    GHZK9Lrjk4kIOUvQLXiGzJX3JyJAx7Iw0xYK-Krzo9v7UOvfZlc2g>
X-ME-Received: <xmr:MTosatsSn6OO7HXe5sExyjmb4utVKCuQhgnrBJiEXSeGuo90paT_8QWuzyE>
X-ME-Proxy-Cause: dmFkZTEaRP/Ls0GEHLkOFYtfj3NUHv09JtU37oHWG0/y/bY+fX0RG7CA31NPk4DE37MbQW
    yEvdAkBtTwIpEOftSvOR8jsc1XJSLt3GFegvBgC9qyUkJ918EapBD4/O/g5g0y5huNjnLr
    iwVcqaiAdT8Eue4hgln16PAGnJMeZSMs/6vvbli7yUuRtQVyA6NGh1lpcSxztU8sR6Nvep
    LXnn6eVdRsXkdZ+pstbUgsuMoz309T2p9ueUFEATBht/aJdeCLa5VoSzijfULf4t+1v2D7
    iyTNahoNNGr/Cfa3P0/tBuQcGVB5+5LKUKZ7eCvOLYw2Uf3j7bzfb55GQZ1NpCjsJaF8tk
    o4AuOVv8VQB6WADV0GPJt9YrGqfdFmkonC5vfLQwN0/WLDq4FbWLar4iMh3dwIBTp8vrbP
    Od1aWIlWajyJOZu13Hg02OLSftUJI+4s17HdNf7qKIwWRGjhKcOKCPS5jpYY10obyLHbs4
    hUn3m0NvROaJg+MHWIOR2KNC0IK5h1kQ+h05FZ1nmcFckLx0t+rpbk1sj0t6OAVl7l3/hl
    zZBZ5jYKsLIsT5L6U40U0/DefdvveQ+vIARQ02hUmTvZuBra8/X/XVmDosy+r+ZUo25eUt
    UL2vY8Kju71k7mPpmsEzoHw4nyW4XXjk6mg93ItlWw7S3iAwfS33hLhgSAqA
X-ME-Proxy: <xmx:MTosarZ-HO-xQVqsPuRNKBnN6n8MzvhFuH_ZN9hm0_CyDgZIZHMRCQ>
    <xmx:MTosalCnQY4zlJYRvkfioie1RXzALzHVcwXQU3VLvbbUyb-dnJFztQ>
    <xmx:MTosaj_Tpz25scnjrnQ80RSreD1crHfAvkepWjkcbzvRH-gfPplToQ>
    <xmx:MTosahSIWjEazcnWpB3uK6WHSUqa5LGIgAZ7ZcYG_Ry65u25aH0dKQ>
    <xmx:MTosatiUu63DSXUqIaRQdXVQ0RpJEb-GsJ0sKMT_INELdPrRg9og8Zdh>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 12:56:16 -0400 (EDT)
Date: Fri, 12 Jun 2026 10:56:14 -0600
From: Alex Williamson <alex@shazbot.org>
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc: jgg@ziepe.ca, yishaih@nvidia.com, skolothumtho@nvidia.com,
 kevin.tian@intel.com, kvm@vger.kernel.org, qat-linux@intel.com, Ahsan Atta
 <ahsan.atta@intel.com>, alex@shazbot.org
Subject: Re: [PATCH] vfio/qat: fix f_pos race in qat_vf_resume_write()
Message-ID: <20260612105614.5c21afea@shazbot.org>
In-Reply-To: <20260608151317.136613-1-giovanni.cabiddu@intel.com>
References: <20260608151317.136613-1-giovanni.cabiddu@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Jun 2026 16:12:57 +0100
Giovanni Cabiddu <giovanni.cabiddu@intel.com> wrote:

> qat_vf_resume_write() checks filp->f_pos before taking migf->lock, but
> copies into the migration-state buffer after taking the lock and
> re-reading the shared file position.
> 
> Two concurrent writers could therefore pass the bounds check with the
> old offset, then have the second writer copy after the first advanced
> f_pos, writing past the end of the migration-state buffer.
> 
> Take migf->lock before doing the boundary checks.
> 
> Fixes: bb208810b1ab ("vfio/qat: Add vfio_pci driver for Intel QAT SR-IOV VF devices")
> Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Reviewed-by: Ahsan Atta <ahsan.atta@intel.com>
> ---
>  drivers/vfio/pci/qat/main.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)

Applied to vfio next branch for v7.2.  Thanks,

Alex
