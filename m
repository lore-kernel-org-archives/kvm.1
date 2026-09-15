Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8704A3863;
	Tue, 15 Sep 2026 22:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789511153; cv=none; b=o23iKEiaqEMRHKslU1QEKaJopdFBv+CXkgdJ/hUascdzV1TsAuj6/D8/QJvvB7VWyCZMonx8ClBPLEGTjAMlprPHCJpJ4aeO/tLUQm43Q358z2DD+DQgQ7V5NJH8s1liixXbV2e5c4vhkRgzdzVmrmQf4tLq46x+0HFN4TpbkgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789511153; c=relaxed/simple;
	bh=dfpVIwfnepVnkoEsRVnLwIbNVApouszgE34IDPAi+HQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PeUtrdFpEOp8T6bBRDV0ucJPySL1HSTtFVKpZu8tMyJbg1eZSVbFDGlbltjXxQgs7EEH4y6frhPgpHXpMdhpdKK5fdKPqSTMMLX354y/T2lNrpYiYt18HI+7NQ0NQfYKkB0DlS+eat/6BYjdBMesGOrnhufLfByMohNtPAaAvKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=FQUBes3G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DK8tiVFD; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="FQUBes3G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DK8tiVFD"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 3FBB31D001A6;
	Tue, 15 Sep 2026 18:25:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 15 Sep 2026 18:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789511148;
	 x=1789597548; bh=jOunFAwFZUGoFoU1e7chmXJPvDEcW+nmOu6n6zbmslY=; b=
	FQUBes3Gz83TaTdD7AjfDQ68T7gyK5djPIsc7ragD7P9rdt0KdYqtxulAupvRJ+3
	WrqSBqCgH8+AEmhheXmtJckqkyQMWde8TDK9VLiu8FW05qLvxTUt7c7c1rYwFH50
	6TsAvzjZwJgSD5K32JU1xRRHheNedkmG64sjV8lJiElAWHZAXBnNMBypLLKScxVr
	RCFWXTzUyxsuTX0v0iSg4/U6FQg5dDDHZJ4zvcaPNetNxSDyrvwt8q7bD6YIoBHz
	J6Z1NbuVVFq8v+59WnMzg/vqo231vw5+zc1pHLorM+f+H1Bq8G1v9QFTsQjXE8Y0
	FwKNoXdlSIzXM2ekZJkueg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789511148; x=
	1789597548; bh=jOunFAwFZUGoFoU1e7chmXJPvDEcW+nmOu6n6zbmslY=; b=D
	K8tiVFDhETHw7wd2sjwxJRzp19wAuc47y81EaSqB6CHmmD6nxfvhmd3MG8HHQEk/
	mYj5gkn7USTHFhRQGF5eHtnaDb5HN0qMJ8RJPq7sGVd28BqDDwFXQxh+PjqXhaml
	KhJPd/5DjWleykrFuxtQG519dG2AW6cDHPviX2A1yKILwdBie7ZZ/aGlJ1kFyQZh
	T9utVw7bpoI0s1uJuGdcwOVZm4gO+c3YRqAmF9tZek1892pRWdq26gyYVdX1NqoC
	1vekz53udc35VRGlL0NAcfbwy/T6b7/MUEsGm43uv+BSyuovZ3b10b4F/AirVcF4
	3MLfSX9zFeyUrUF0/OvPA==
X-ME-Sender: <xms:68WpaqWtT7FtRWqL4ZBGqq2Q0btKMkxvNYE08MpCZEwjPSCBQcxXRQ>
    <xme:68WpanSbus3V7ZYeGvSrlM_LQP3-iacUIz-hh95Np9CTsMk7jYrJl72j925kG7j38
    1ekK1eGrfzc6wes5zS02ecA9wygmgFCW2bJ_QI_PA1agEQsHa0_q98>
X-ME-Received: <xmr:68Wpask8w24aIEyII19oBFiiYYBBevKBuUmZZ2rhTok-NZfd4JozwXIL3b-M6Q>
X-ME-Proxy-Cause: dmFkZTEY+R1Yzjclo+APlMeV1P6k1TlXHVaz/3mBCyIgWXE8NgYUAya+iGERVf1bRdC/Ff
    pdZw2nO3LdGXOApsYf/YGV4jtV4vjEYVNfBiO7RoitoFazi532a0FFRjS7JGnjTQCYrYre
    h6F88g4BREQc/97I+ITTkwF6dFoBrKd16GgkXqDr0CfcdnDYtXRie1hAS+3UICD0CZCafW
    otD3c8C81T+YOWuTswTJpM2NkSVt74yyUB/dvfFkwjy1g/Mu7yWvHeUFaM8DvFaSDlTAnj
    asOJ0QLm+GXXcJi3rko0N7duhUqHFsoQEoJMBOWoBaIw0kP/C5efJcNpzk/Goo3I8QTWat
    S3Ihia49jFWZ8d7jGSqBG5eho6pqVPzsZYnThXTM213oroeNG/g5oQaxAuOUz8H8oRfqqB
    mtthVNrSJkw78Jv1y7v9AXTkot3b6ctqxQ64jx+hUb+q1fYZFSPFE5y34CFwoEYN78ALyk
    MkqjvTSiUCe6z7OQ/tP7gnO4TK9H17iUhdYetAi3pByECUjTeJc4L0rytONvpo9MdLyABg
    /cRrzwgwUVzDhNDMlvc3emEhNiu/VkufoF0+FX86kbFCOULRxX/xul6hE7Lg/eiciwHEaQ
    9Lz038QYU+Rcm3nNTh3nENy2SZy6xyO6ehJOOSo/PZ0JxXpY24qXvtidnRyQ
X-ME-Proxy: <xmx:7MWpal7XVjtkigv2RNvOEqQck1On0P_yW4e1_1_BqjrATJSSz5lgBg>
    <xmx:7MWpaqiC-suDwEoFTJgmmrFoOGgW5Slen2EwTM-B0q4PekE-ip7ujQ>
    <xmx:7MWpaqGMVZy-UlJvkfJGMD6sRps0WFmCG-L-cI_4KaF0BTBU7dB4xQ>
    <xmx:7MWpaoREvkKOIOpKrVcUkv_U5nlT72B0hs2J6EhcFVikbNUHNtRJQg>
    <xmx:7MWpasmsMJkMRLgObDLutCsFHV_h1ojQD5RuAtXWY-CHNScqd6J2iPA9>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Sep 2026 18:25:47 -0400 (EDT)
Date: Tue, 15 Sep 2026 16:25:46 -0600
From: Alex Williamson <alex@shazbot.org>
To: Abdifatah Suruur <suruurism@gmail.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Eric Auger
 <eric.auger@redhat.com>, Mostafa Saleh <smostafa@google.com>, Pranjal
 Shrivastava <praan@google.com>, alex@shazbot.org
Subject: Re: [PATCH] vfio/platform: keep logical vm_pgoff in MMIO region
 mmap
Message-ID: <20260915162546.342647aa@shazbot.org>
In-Reply-To: <20260903092927.502-1-suruurism@gmail.com>
References: <20260903092927.502-1-suruurism@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Sep 2026 12:29:27 +0300
Abdifatah Suruur <suruurism@gmail.com> wrote:

> vfio_platform_mmap_mmio() overwrites vma->vm_pgoff with the physical
> frame number of the MMIO region and passes it to remap_pfn_range().
> The VMA is inserted into the device file's mapping->i_mmap interval
> tree keyed by vm_pgoff, which VFIO expects to be the logical file
> offset: the core links every device mmap to the device inode's
> i_mapping precisely so that unmap_mapping_range() can revoke all
> mappings associated with a device (see vfio_device_cdev_open()).
> 
> With a raw PFN in vm_pgoff the interval tree entry lands in the wrong
> coordinate space and unmap_mapping_range() cannot find the VMA,
> leaving stale MMIO mappings behind any revocation attempt.  Keep
> vm_pgoff in the logical VFIO offset space, as vfio-pci does, and pass
> the physical PFN to remap_pfn_range() explicitly.
> 
> Fixes: fad4d5b1f042a ("vfio/platform: support MMAP of MMIO regions")
> Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
> 
> ---
> --- a/drivers/vfio/platform/vfio_platform_common.c
> +++ b/drivers/vfio/platform/vfio_platform_common.c
> @@ -559,6 +559,5 @@
>  	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> -	vma->vm_pgoff = (region.addr >> PAGE_SHIFT) + pgoff;
> -
> -	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
> +	return remap_pfn_range(vma, vma->vm_start,
> +			       (region.addr >> PAGE_SHIFT) + pgoff,
>  			       req_len, vma->vm_page_prot);
>  }

Like the read-only mapping fixes, this is a hygiene issue, none of
platform, fsl-mc, or cdx actually make use of unmap_mapping_range() to
expose such an issue.  That should be noted in the cover letter for
proper scoping.

This also applies to the cdx non-shared mmaps.

Also, please just group all 7 patches you have on the list into a
single series.  They're all hygiene/hardening, they're doing the same
thing through different vfio bus drivers, they're much easier for me to
track as a series.

The Fixes: tags throughout are also somewhat suspect.  It's reasonable
hardening to clear VM_MAYWRITE for a !VFIO_REGION_INFO_FLAG_WRITE
region, but if there are no !VFIO_REGION_INFO_FLAG_WRITE regions, it's
not really fixing anything.

It's more arguable that there's a latent issue here where
unmap_mapping_range() would fail, but even if we consider that worth a
Fixes: tag, the attribution is wrong.  We didn't introduce that shared
namespace until b7c5e64fecfa.  TBH, it's not a reachable issue in the
codebase, I'd drop it.  Thanks,

Alex
