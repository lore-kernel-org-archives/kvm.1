Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D9D3C198A;
	Tue, 23 Jun 2026 22:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782252675; cv=none; b=DX4CvZARAJw5nmIftkUD5HA2lBjuPsiyFhNUNm2z4YW7zqd68+ieNfnhszavyp4BANGMYwAt3++NeuIcg3d5MAwdsh1sJREL4fPzb10IfPK5Ix5LiiotXHCuKtE8O3iKB8aHwn6jQfUKuAq5IuZzJBFlgiFCrqtJVKjLdjeDXsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782252675; c=relaxed/simple;
	bh=C6CX7JyhSOyKnLbA4mBI5QfP7/9EKi7ITQD+T/id9fM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MxGBynCrSqiENZj1mg6xtDJvaB3hwe7XOoJhm+DfQP4+V3kCtuzJEOIkkcUbTjJYT/8lm+9aB4QxN/CvPvRRkRrWqiEYgafI1+jmNZ/k0O+Dxa3f/HXkcVSqJrZ6WXydkV/Jt9HRMC1v+ISPZerLbrLDopyHDyQV/VUw9FoqdUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=IIJp9UX7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FO6fvLzn; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="IIJp9UX7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FO6fvLzn"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6952D140008F;
	Tue, 23 Jun 2026 18:11:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 23 Jun 2026 18:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1782252671;
	 x=1782339071; bh=X18SHEo1gUp9Lx6clXwkcErZhNajWNK13kB/IUh+wK4=; b=
	IIJp9UX7hiluWdFh89iYXNpbN5zR09i8L5PmnsWAcAEU/4jlsXqahP7zp/tvUN07
	2P6MWeNFvE5noi2bIBZVuItgCQeWtkGpDbb0MnKSUEJEeuBeO/cBB2PujDoK7F36
	AVr3le3NXNszBNLAl29MA9CfgcUYX1AfVShzDIFTdgZxSBW6eeO/BsxLRGNZ8Pbg
	95JADH56A7hFVYope+kdjDjvVpJCcKLUyUsj2zB+fLdfJc9tVyahCNFic9i3sZTu
	NPT7Vm5FRwrybIhBEt2YxL5vkCwuNmKHveL+1qwUut8CN4IK/FO2sDknN200twl3
	NGjlfTdbe4KpzNOeH/taaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782252671; x=
	1782339071; bh=X18SHEo1gUp9Lx6clXwkcErZhNajWNK13kB/IUh+wK4=; b=F
	O6fvLznPvdpIQim3zUrag+ztK5HGF02dvRbliPGko4eCloFj1bi8VKlaPAfk/yyC
	2GkphLUPKWKS4YCLZT9mpDnYmSDN4HRPh7S76pKc2wPXFRLN0FUAKcoFyvD0fH8R
	p2vioIpSCM05FO4xAJtXseKV8Ni0JbSIICWCKcWgHGZD0/MQ+pjfbBmZNEvOOHVc
	aArflSRw3cmRowd4G7A7Ee7StMJKlzuk/XwA8KETPHuSNzRaMHZkvgYKK6gZUlxk
	pbDsyyWzvdjLoKHV92Aw2vxjpvFtYoy5i5EJx7aw9G6To+h2XIZ/oiDGR0gm7AYl
	iSBkJetgMHn12GFWF2Qdw==
X-ME-Sender: <xms:fgQ7aj3ADADPgWDoTYxdG4BsdR_0lLce9ljFqBhSIf09Bgwcl9l1ZQ>
    <xme:fgQ7av61gHGUAICR8zS_2QwRf4V3lxZTQRjvGMaKh_jVOqmf43RParzPGg-XFsYkX
    Lh9AXxk35HQHsZ1mHfrn3DzFmYly3dq_0fVEGWNonU5D725seAI>
X-ME-Received: <xmr:fgQ7auXmuK6qxOm85kNuBnPmg8Jak0SIsa0-uQIQWLd19iCgDFnQVX0sKvI>
X-ME-Proxy-Cause: dmFkZTEScOgLYk0MfvgSy13XGx7Nr6/3LxprQMRW1YTpQARQUOSkpxT/m7Fn/QPbrirYOk
    OZYuYk070jQ+t/zgFGqVt3cOdx5JiCPt+zjRdUPsm2wuYbTmjUc+cSjtgICuDGgkqnK7vv
    CvcYpoBi15cUX2bAfu0LrNVwF/buweOC9mD/yaBfGjfIt05LNCGIGwaVrFLRiIqGjcuk7Z
    Ly7YaQYW9iD0lSKnabtjz5kfBEbtRoG9+lz6/vOe5Wbn+O5hbpegIL2Dpt9mxRg/lOlhHK
    SV+I/sYy0YG2xar+l5ya6C0X9pYFfXMg5Qv6TU0PqDlVHMZ9aYNkSgKOIp3i1et0oh6oat
    Ky+BHj3KciJElaQHfOLyO6p3Ou8ZL0chonKVQZt7ThKHh1Q1UCd8f6yqcIkOF4lqapXkTo
    bsowho4/Kew4lUee3ioAKivz6cnfHMMhJuzQ4UVYJPOYKu+01tPqtK44FiHq5oQP/uwWWR
    dPiOWMClYeHAXinKGKsiCKs7qhWIc9WgsaGzJuQ4t681KyNDZQyWJA1KKPV4VY8MUn7BYp
    nUCxHnb/hetYoEKxq4kvbjKP2Be3M1ydxSSgofwKBEjv5uRm/tsPKKvNXEzmf+zeY4Y7Q/
    wujnh2AqIAwIAdmMBiLyLvY1Mw3kRxcJ81OR8/nvoDSIoTW8z7Gs6yPWd7xw
X-ME-Proxy: <xmx:fgQ7amBb3kNAEBip2wws1TbySt6ejC2fvzYM7S5QnvthyWkWqBJbSQ>
    <xmx:fgQ7al47MLAmIQQxVGUHfuBBj-534alWh5AHTlJGT_A3Q5mGe2YSoA>
    <xmx:fgQ7apyhtLML1wwVjHwqaBhy2Q_HwBRjTIHyETU9mcn61Wz2EdLuKQ>
    <xmx:fgQ7akyK_bMXYv-m-pcsbQjG6KQs8kbSfrBt6fn5NwlFdfV_4jkD1w>
    <xmx:fwQ7amminaFn1KpKA3tDa_6vIaHzz70SXty1zpTJWU7xtYGUVvTCwNxu>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jun 2026 18:11:10 -0400 (EDT)
Date: Tue, 23 Jun 2026 16:11:08 -0600
From: Alex Williamson <alex@shazbot.org>
To: lirongqing <lirongqing@baidu.com>
Cc: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH][v2] vfio/type1: Sanitize user-supplied inputs to
 prevent undefined __ffs() behavior
Message-ID: <20260623161108.07a708af@shazbot.org>
In-Reply-To: <20260617113251.2535-1-lirongqing@baidu.com>
References: <20260617113251.2535-1-lirongqing@baidu.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jun 2026 19:32:51 +0800
lirongqing <lirongqing@baidu.com> wrote:

> From: Li RongQing <lirongqing@baidu.com>
> 
> The __ffs() function expects a non-zero input. When passed 0, its return
> value is undefined (garbage) but does not trigger a hardware fault.
> Although downstream logic may eventually catch invalid derived values,
> passing unchecked user inputs into __ffs() is a robust-ness and code
> quality issue.
> 
> Fix this by validating user-supplied inputs early in the UNMAP_DMA and
> DIRTY_PAGES ioctl paths before they reach any bit scan operations:
> 
> 1. Reject an empty dirty.flags in vfio_iommu_type1_dirty_pages() to
>    ensure the subsequent __ffs() / __fls() single-bit check is safe.
> 2. Ensure bitmap.pgsize and range.bitmap.pgsize are valid non-zero
>    powers of two before calculating pgshift via __ffs().
> 
> This change improves the overall robustness of the VFIO type1 IOMMU
> driver against erratic or malicious user-space inputs.
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
> Diff with v1: Add the two check in vfio_iommu_type1_dirty_pages
>               and rewrite the commit message
> 
>  drivers/vfio/vfio_iommu_type1.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index c8151ba..b74f56c 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -38,6 +38,7 @@
>  #include <linux/workqueue.h>
>  #include <linux/mm_inline.h>
>  #include <linux/overflow.h>
> +#include <linux/log2.h>
>  #include "vfio.h"
>  
>  #define DRIVER_VERSION  "0.2"
> @@ -2949,6 +2950,9 @@ static int vfio_iommu_type1_unmap_dma(struct vfio_iommu *iommu,
>  		if (!access_ok((void __user *)bitmap.data, bitmap.size))
>  			return -EINVAL;
>  
> +		if (unlikely(!is_power_of_2(bitmap.pgsize)))
> +			return -EINVAL;
> +
>  		pgshift = __ffs(bitmap.pgsize);
>  		ret = verify_bitmap_size(unmap.size >> pgshift,
>  					 bitmap.size);
> @@ -2985,6 +2989,9 @@ static int vfio_iommu_type1_dirty_pages(struct vfio_iommu *iommu,
>  	if (dirty.argsz < minsz || dirty.flags & ~mask)
>  		return -EINVAL;
>  
> +	if (!dirty.flags)
> +		return -EINVAL;
> +
>  	/* only one flag should be set at a time */
>  	if (__ffs(dirty.flags) != __fls(dirty.flags))
>  		return -EINVAL;

If it can't be zero and only has one flag bit set, it seems like both
of these could be collapsed into another single !is_power_of_2() test.

Note that if (__ffs(0) == __fls(0)) this could present as an ABI change
where empty flags fall through as success, but that doesn't seem to be
the case for any of the usual suspects.  Probably worth a note in the
commit log though.

Also the unlikely() hint in the other chunks is inconsistent and
unnecessary, these aren't critical hot paths.  Thanks,

Alex


> @@ -3039,6 +3046,9 @@ static int vfio_iommu_type1_dirty_pages(struct vfio_iommu *iommu,
>  			       range.bitmap.size))
>  			return -EINVAL;
>  
> +		if (unlikely(!is_power_of_2(range.bitmap.pgsize)))
> +			return -EINVAL;
> +
>  		pgshift = __ffs(range.bitmap.pgsize);
>  		ret = verify_bitmap_size(size >> pgshift,
>  					 range.bitmap.size);

