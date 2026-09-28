Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F9C37F723;
	Mon, 28 Sep 2026 23:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790636423; cv=none; b=YQ3KA2yaoLG5OkFbOeyB6ukPuOZjSaTV07f1vHu1U0gx1AyQxadjRa4sTHiZMyKhKBUBQq4zXcwHEaorshcB5NhTvinSsDl75LqDpUIQXMGkDFsDxGpfGy2SrF4TYjNEafJsDA13+FsUuronr8S9rtxv+x8xm1wfk/f+YlcOE6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790636423; c=relaxed/simple;
	bh=LSH5Tw18u9E1E4TC0gVA4npSv8mxU0MzWGv79XHTvlE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=atOaVeFuna07l6lrD3Fiu+hK/LvY4A3VyIVmKxEIldTi0vGbWDzQjcO4FPvkkwB2nqJfHFvE6rXbh2Vk9drTRt7Kjgh4M4A5y6loO4NY6+3Ho8F/VNK+A0nS2eE4L5nUshG3r7xKOT23TV8Skz5FEn46iJitA5H0Tzmmem5lrAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=Svuks7e9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ajEHdX2K; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="Svuks7e9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ajEHdX2K"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 882EA7A016C;
	Mon, 28 Sep 2026 19:00:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 28 Sep 2026 19:00:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790636419;
	 x=1790722819; bh=VjR6tRp2S5WGOOKp2ZiLzAj+L4msxqT6tO0bvFMbuPc=; b=
	Svuks7e9H5uyMomFTrkuIxLZUFWIK76VDR/QbPhA9s5TgaPIUIQIGFnVq8w17V8h
	B6sZ84HHXfzAp7+8Za4VBStphuqhDzhoTXNOGGblSeGeDknTWTIItJf2HE+45SP8
	Axb07iekemwKTeuihzVjzuGJTlaQTlxbTkEtL5rDPqWfwBURwwWGajAquGCtr/nV
	eBcZO52uESqFEQl50n9FOYOcCvMd7UUj79/iCsh2Om5Pk16o+nA4CKF161y9w2mw
	ws8HX1YhguvAQQdXpUnkMvE69NmB2xV3EnDJ4lZ3rRZw7f8CJX9aGYoWEcDA4CaE
	wP5o38Jq/3PO+WRgpDz6NQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790636419; x=
	1790722819; bh=VjR6tRp2S5WGOOKp2ZiLzAj+L4msxqT6tO0bvFMbuPc=; b=a
	jEHdX2KDZnB1Rc/SK4KjSUFBPxWpPFwPDzeOa6G5z6+yQX61Xa21ydoxUBiHJ2xb
	8aKv/MmYJUfo7M/NIGb67ZOliVMHubSSTC0Ng9yLoF12m25ST7MlP050xwJgQg0O
	MM+uQ2YQ4yETXy/mAl8CHwiVEA+/iajDlzKE3oVn0Lcv14SB0k/LawbhRSU1ltiI
	FbGzTV4X/OOKucRJcqHgUB5p2PTwu5i/O7BHgKI1xdOv2/q1rA7jr8xgVaUGsuTS
	NhcFI0AyJsXPJyxKoxVmQcKjlvDuN4hJ8Z/kdCmHUbZZ4N02xSMYSkIyI4lJ2/SL
	6/c4X3lFj6bcU/HIz7q9A==
X-ME-Sender: <xms:g_G6aioQV_vB1NomalQ4FO1pBuutTpDMia9eP6yrdGKiawpqA0IrRQ>
    <xme:g_G6ajufxL_IaYMISu5Uuld1GHQD43qmYKkg_eTbmn664v9S7-vh2hEr2NLQzO08D
    JGqT-JbtWdMfuBkHxB69av8ytM28rSaq7gP7kBTv6oEuS1-l0wjVFs>
X-ME-Received: <xmr:g_G6ah2mSJ5FdcD-Kh3Id1Pa93Xxofldnhr3mtStgNFg_SIL4vJT7heKMThOMg>
X-ME-Proxy-Cause: dmFkZTF/coOKMFH8WuPHArnjaU0x/RcLHOrmumVANbXRpW8KFkixnWnGFlOuiouIzq3QBA
    TzMhS3t71/WpsHe+WWtrIbBo1KaZFO0baXK0osw9/bXnD3WMFbVOV4CDMizvr1cHRJg/EW
    XGCV9RzM3RydALGHZ9tSP04IS2BBi/LafJsGTcumMvcuNYZ6NEhm7h0FUbgbbJrc0fGEOD
    YJJC9VQSpKCOcuuaDcEPlJ248SBRB17zN7jkYaUPK05GgmQkdThHM3q0y0TxYM+zvgk4R2
    qPDTuzBniNsh6GTaFPOPVAyORLse9cSKLCGma+KphWRd35mvxqi5OqRkBe3460pxrsDWdk
    D0Su+qnZtXEyc2joWdOViYFMj2OCYQPwSA09593o0rVvMxBa1ROyTGwZxeugueG2KgxN4+
    7Sj3xwxjBMlfsxYqp82QpX1xeqghBb+LYnf5dWvfxyyUNxgW1hYEHCR1oMY8YrxFZIRF97
    MkKuFeBCEDQHBymHDFniDrlQjs7OvbT75unAkBqgensCaDHKVuw6pp2V/X/2bp6NBv+4Ee
    v+jZHfL299zMRaLgL5HraY4HdqYUAfrcemeVWoVX2qlTK8L0j6gH5Ghb8WaZO9TJB+LtFV
    YoVx7FYSjOQHdHAAeZntaDjqmoF6xZiFqQoYWWCDRFKu3au86LERskvGlZ6g
X-ME-Proxy: <xmx:g_G6auE_68vmwxB7pcQcDN6s0fkDMv8v96VYuS2Waqaqy4q6LnitgA>
    <xmx:g_G6asvBusMPGsjWBsg_chJOJVDLNR4NYy-eLEHdZf4GNSY2PuOPbQ>
    <xmx:g_G6ahr2NpRyNIaqgTIjRkB08RPBx1Cx-_VOSLMX8t9nzzGPEHqXtg>
    <xmx:g_G6ajXn9HEEJAWR0KbAHQtjB8GoH2Sxpr8lY48Jwoz_SLgEOypc1A>
    <xmx:g_G6au0kQ__D6yYrsXiq2NaQgCnXVi4zWVO46QqpWjhWZcydBYMnOSkV>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 19:00:17 -0400 (EDT)
Date: Mon, 28 Sep 2026 17:00:15 -0600
From: Alex Williamson <alex@shazbot.org>
To: Abdifatah Suruur <suruurism@gmail.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 eric.auger@redhat.com, smostafa@google.com, praan@google.com,
 ioana.ciornei@nxp.com, nipun.gupta@amd.com, nikhil.agarwal@amd.com,
 alex@shazbot.org
Subject: Re: [PATCH 2/7] vfio/fsl-mc: prevent read-only region mappings from
 becoming writable
Message-ID: <20260928170015.5da76223@shazbot.org>
In-Reply-To: <20260921122334.2099-3-suruurism@gmail.com>
References: <20260921122334.2099-1-suruurism@gmail.com>
	<20260921122334.2099-3-suruurism@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 15:23:29 +0300
Abdifatah Suruur <suruurism@gmail.com> wrote:

> vfio_fsl_mc_mmap() rejects writable mappings of regions without the
> WRITE flag, but leaves VM_MAYWRITE set.  Userspace can map such a region
> read-only and then upgrade the mapping to writable with mprotect().
> 
> Clear VM_MAYWRITE for regions without the WRITE flag, as i915 does for
> its read-only objects and as fixed in drm/vc4 (CVE-2026-68445),
> drm/panthor (CVE-2024-53071) and commit a5edadbae57e ("ptp: vmclock:
> prevent read-only mappings from becoming writable").
> 
> Note this is defensive hardening: the fsl-mc bus publishes all device
> regions with the WRITE flag set, so no device can currently reach the
> read-only path.  The guard costs nothing and keeps the mmap() interface
> honest if a read-only region ever appears.
> 
> Fixes: 67247289688d4 ("vfio/fsl-mc: Allow userspace to MMAP fsl-mc device MMIO regions")
> Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
> Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---

There should be a diffstat here, check your git format-patch tooling.

> --- a/drivers/vfio/fsl-mc/vfio_fsl_mc.c
> +++ b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
> @@ -406,7 +406,11 @@
>  	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE)
>  			&& (vma->vm_flags & VM_WRITE))
>  		return -EINVAL;
> 
> +	/* Prevent read-only region mappings from being upgraded with mprotect() */
> +	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE))
> +		vm_flags_clear(vma, VM_MAYWRITE);
> +

Pranjal's suggestion for removing the duplicate flag test on the
platform patch should be applied here, and to the next patch for cdx as
well.  Thanks,

Alex

>  	vma->vm_private_data = mc_dev;
> 
>  	return vfio_fsl_mc_mmap_mmio(vdev->regions[index], vma);
>  }

