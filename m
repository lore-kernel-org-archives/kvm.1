Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1E937B3F2;
	Tue, 15 Sep 2026 22:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789511149; cv=none; b=UwupZYs28zWurFXzq7R2gEwkUY+d8BU/YZVRbCASZoJR5IwjZFw99ki15VsXyHpKGuNABuQBIzmJ+x5u7bd2pJ1G+rzV4TLpHs4c0901Ht6oe7plrhmfEfoJPmaaNiqQ12+WfkbElfvZqK9anG4V1O0tTM7KDUx3R9FGjBxayIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789511149; c=relaxed/simple;
	bh=nJSE2gN0CZw1cZj8uKF1OYvku0yx+gjcEg82UND812o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h6ULWV5+pPAqxUF1pz/c/xu/gTmcA83P0QWSeg8dE+SAzB4lv3991D/s+kdZnOnSzgP+u9gfOOrb+lkXq4NaGSwy1dI2rmqvyRFNOfyAPh3Bv0knvX2Zul2Lwm2sPriQJpxlao2wbPkfRSraQh9X6rpb2nDG441VZCnQm0Nma90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=RvL5PXGw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lmk7QY0j; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="RvL5PXGw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lmk7QY0j"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5752E7A013D;
	Tue, 15 Sep 2026 18:25:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 15 Sep 2026 18:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789511145;
	 x=1789597545; bh=9hYTy0EV2R4mqvyjDo61OHwzmweE9REZTzH25IaD0Gc=; b=
	RvL5PXGwQB8vFv3rcAT7kiqcFI0iqITiq8gALbHo3cO628Ctys/LW/ul8Fq5JC85
	oVk0/8bHMU86dNC2dVvz83+t98zx0gu2T9lQ6t2kDdOjN5Z5dRcZimf8Be0E/Ix1
	02eYi7PE7yrOQee6s7iuj3s4S/MJpvWFFahf7F9I/vUdp/lQRSD2j2LuDZnOX49Z
	t+ebva/3oUp2jgovU8jtsDeLitVna0xYn1q/S+MY5qt9uPuAmLnGs4QQEyhcCpw6
	3JhdfclL2eorTveRoN7wNyB8ZJaW62G4qbWcse5C00X/cZQ5Xn6V0TWP0IFks8XL
	xKlW67mkYm3w1p4AwgBoaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789511145; x=
	1789597545; bh=9hYTy0EV2R4mqvyjDo61OHwzmweE9REZTzH25IaD0Gc=; b=L
	mk7QY0jLH/KYK2hvlCeYJ8KHEWVW6/tqYpiC5k4sFggxZgeNwLpS8lzFNfnkQpeb
	EaALg51F4Aw9/U05w3x0TSm+UXcUB1USspYC6M9ipyQnlw9i+4WMJfPcuUwPYznu
	btLAEROSGABaB5DdttNqQ45tRADCKwzsZGS/ALy1tb7+qV4HQAYqHCNC6HfwQww9
	Hjoe51E68+l4XEDdCLatYVCNbUtKs0bX3X5UT2mwPaBb4azRZXEcX1yr3BS8vkjn
	rNDco5qcatk3UmlaSAuKg2ICABenYcPdjAdcpb6chyiCJwxFKXScE8sqM4flFnLs
	2omG96QmFXVQmJTRaoheg==
X-ME-Sender: <xms:6MWpapd1z2JIt2GX7VTh1aGWrsIKTGcccxFN7JivCMYgH4tAb61Rxg>
    <xme:6MWpaggrHLNmFvqw3g71Y2vS9Oq0AAsfYY8YdOI4HV-j5roumRO1xbUI7e29jQA3c
    _AvkXburd_qRloJujJW6BYJl1YReI1VipiubB5wgLRJl2Os0vt93g>
X-ME-Received: <xmr:6MWpapxRfZP7u17n38ad75X34zb3RwYp6ylhqQfyBSOBEOkUki5uEQzTN9UgAw>
X-ME-Proxy-Cause: dmFkZTEY+R1Yzjclo+APlMeV1P6k1TlXHVaz/3mBCyIgWXE8NgYUAya+iGERVf1bRdC/Ff
    pdZw2nO3LdGXOApsYf/YGV4jtV4vjEYVNfBiO7RoitoFazi532a0FFRjS7JGnjTQCYrYre
    h6F88g4BREQc/97I+ITTkwF6dFoBrKd16GgkXqDr0CfcdnDYtXRie1hAS+3UICD0CZCafW
    otD3c8C81T+YOWuTswTJpM2NkSVt74yyUB/dvfFkwjy1g/Mu7yWvHeUFaM8DvFaSDlTAnj
    asOJ0QLm+GXXcJi3rko0N7duhUqHFsoQEoJMBOWoBaIw0kP/C5efJcNpzk/Goo3I8QTWD4
    kil4x/6ZU4EluDJvoPmVsASksxkysHx9h7Lxo37rG0qK58AhMKVjSRipbXJ5L7kUDbyPad
    OeCcwB7t3lM9w36fgfOueNrLuBQfdrV4TPh8gnt9A0lOPbB1/g+m0Diou+ud8YVE1xQa8j
    64SfYdr0JY9TnvB9qmM/MjMkDKzXXrulLzCI4HAAw0VxHI6P3M91VNVMYqFoHCki7++hxJ
    6fFgbkNmjYVkOvYRm5aCbq12Rn5fEUyoezvwwGaxaFweKVddgyVZ6GOesagJ9PZTMux3vw
    uOoXdv/fxReSikj8Ig4FpDnsAR9hn1jkkiuAV69+/2/EY8ZRShIzySAAYkbg
X-ME-Proxy: <xmx:6MWpakMGrnYbVbUDuRaVfXCmLkH454vTpL10qsKTJBG84BFcXrzfGg>
    <xmx:6MWpaiVThc-Nol-fgFNE6Ji0fzf312uwMk0gvx-AIMimN8VicQ08NQ>
    <xmx:6MWpag2pYd8dF_YS6OtADX--xuqFKKdl2-_Hlpy21_mvJSXwV6RtQQ>
    <xmx:6MWpaoqEtuOaDQ4pg4-b_HzaIQRGyAA3vDRjnxCXM1aGXrEnmckEMw>
    <xmx:6cWpaqpGiff6PD7HXqP1-4rnQhg6S1O-sLqFf45q-6onQFDUn_rH6lB0>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Sep 2026 18:25:44 -0400 (EDT)
Date: Tue, 15 Sep 2026 16:25:41 -0600
From: Alex Williamson <alex@shazbot.org>
To: Abdifatah Suruur <suruurism@gmail.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, nipun.gupta@amd.com,
 nikhil.agarwal@amd.com, alex@shazbot.org
Subject: Re: [PATCH] vfio/cdx: prevent read-only region mappings from
 becoming writable
Message-ID: <20260915162541.5781a54f@shazbot.org>
In-Reply-To: <20260819084203.1526-1-suruurism@gmail.com>
References: <20260819084203.1526-1-suruurism@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Aug 2026 11:42:03 +0300
Abdifatah Suruur <suruurism@gmail.com> wrote:

> vfio_cdx_mmap() rejects writable mappings of regions without the WRITE
> flag, but leaves VM_MAYWRITE set.  Userspace can map such a region
> read-only and then upgrade the mapping to writable with mprotect(),
> writing to MMIO regions the device marks read-only.
> 
> Clear VM_MAYWRITE for regions without the WRITE flag, as i915 does for
> its read-only objects and as fixed in drm/vc4 (CVE-2026-68445) and
> drm/panthor (CVE-2024-53071) and ptp: vmclock (commit
> a5edadbae57e2298a56cf7a4e774a027905a331f).
> 
> Fixes: 234489ac56130 ("vfio/cdx: add support for CDX bus")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
> 
> ---
> --- a/drivers/vfio/cdx/main.c
> +++ b/drivers/vfio/cdx/main.c
> @@ -284,5 +284,9 @@
>  	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE) &&
>  	    (vma->vm_flags & VM_WRITE))
>  		return -EPERM;
> 
> +	/* Prevent read-only region mappings from being upgraded with mprotect() */
> +	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE))
> +		vm_flags_clear(vma, VM_MAYWRITE);
> +
>  	return vfio_cdx_mmap_mmio(vdev->regions[index], vma);
>  }
> 

AFAICT, this should have the same acknowledgment as platform and fsl-mc
that this is hardening and unreachable, with stable removed, cdx never
exposes a read-only region.

Also see comments on platform vm_pgoff patch.  Thanks,

Alex
