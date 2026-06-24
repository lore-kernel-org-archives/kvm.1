Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0DC199EAD;
	Wed, 24 Jun 2026 19:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782328945; cv=none; b=QEaFSVuAtFBxgVM0lqW6+ies9ulaKbP4MEGj9ll3f13AXBj5EKzkgK72jNgqtgk1f0ozxG9Puuz3dUGopzrEswf5Db7LARioicHED/P0ND9TRci6PCP34Jbo0mk45sRuq9kfgdZwiGqePpnpNPUnwlP/UHXbHIICO34imYUK8Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782328945; c=relaxed/simple;
	bh=PgLHDN0VPPW8uqPKBGeGGh1D2Zu5GH1sXK+JBR9Q6dc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eJMM0FXlSJmOlWX358tA7Xsso9pMx80+wFc2k6cC1emzjTPcr0BSh1tWLbKys+8TEnmzY345rfW2AmOlVbHvpjJ1X9brxWCc+DYJe6L180X0RKpXDCggCV5bFRnyRW62A4Y2DbzoxXy9T6aLTETo63GBiEozJRATArea7V9N7YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=HnTFrftn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V+R617WS; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="HnTFrftn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V+R617WS"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 396F2EC02D7;
	Wed, 24 Jun 2026 15:22:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 24 Jun 2026 15:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1782328941;
	 x=1782415341; bh=Pplb0c6RG+err9ogQ5QZrvqqcVjiiPJu8/iILrqXCag=; b=
	HnTFrftnEq9K0DKI4F+W1y1zN709nBc7t/MDf6bdfZUFKrY2bU+l3BkU2BKBtRKK
	4n/ZpoTetHkyLuaJx8z18HroGW8YBFVIFOxCfCxOHqmEs4nIcLMQ+wKXkvDwuO7v
	gMs4OsYit1KKG7rM8cp0YbpytbD21MT/ibsqJZs+ZW6wNLyRInP9eM0QTAVUlZXP
	qiiTBDrDPEFWGgREZ2t2jYGnNG+xJvDXnSu5+6oZg74fDQI+Mjeizw+q5/OZaAHd
	4YbRpmckTebEeSbVjZ+srf58MQ0UndHufb+GQqDMeHXRszjFqUJ0wt1R+uX10/UU
	2VhPjFg6yEzaoBPFKxMZyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782328941; x=
	1782415341; bh=Pplb0c6RG+err9ogQ5QZrvqqcVjiiPJu8/iILrqXCag=; b=V
	+R617WSUq0XawLfNjsEsu/Gwuw7l1VhN0jg8M0fauCZxLxsf/Xbe6oqlvEa65j+R
	PKR4bn0PFQbZ60fjs2BupJ3nimu3Vm4f/BkLvFIe7lSsoKMWgnZtwznTLwsCj3sc
	qaYspi75TtfWfoD/K/azFjGqeKhxgTUl5KPs8zKdP7khVn1THfCdjGfkvSG6xraT
	BmjJgeA2xLur3CG46Khmx3sOaajlzY+pC0fOCUiWXnvOfU3W0hWcIhyeT7YENkSB
	4sI8HCVaiNm6j7p8rfVHc2yRwUmqtUJhnoKAr8wcSTq8un3TUps86Gth0jJ8tM95
	lIM6XlMhtR7jjo+zfU25w==
X-ME-Sender: <xms:bC48ajsXlHlAEcm7xfxSfNivciHUiHAcZHT4XeW70B47MwrC_TKQCw>
    <xme:bC48al8Q8uoJ7f-mE7_x4HR5ns_nbbUBayTOev8t8GPxW9DHTzn0FKY48poo-tWPl
    4gF7m3q9QlzcIq_G-he3cO1pegv8YOJN3ydjji9R8p2Fi0aqDkWKQ>
X-ME-Received: <xmr:bC48am0PcDKDZgkrx6OzM_izVN5jAArvmigiJJPNNmXNWxvrhx9Urkd4iUQ>
X-ME-Proxy-Cause: dmFkZTFuPGBKf9sxjQ5VIwogFrs6l9mkG6s+bToxr12Z5A0i72NRDHxU3azlAcgp097XQq
    JUs6Jiwj+UQ4mT9ujkOJDYfUGMuosMlksFjOS/aUeMURhA5GpTER7DKx+hhD8JjfWiSMx+
    2ELqZf0Z/XEq2yHsnnhf2xsLNWTlUj0g6Lz6eZTBlJ1/nxjgu7iykh4/hTF6dXQMexHVx8
    7PvBFmvUHQQc9NNgRLJHZxHdBZUktvt05mGQJ+w2aFyOKyrhUnmLTeyvMBy98PQ/35oZNA
    xNEGCFknwgDsxX7l8u7EZX0TttHrexMBV0Pt973LErqU9jBrMMESpJriUAYU2ode9DcHjC
    O9AHrG2pmOW8mKdQopujWBgP1M3YNs73rWAAfbQGTthkg22y33pdww0/dhoQtjRXWfgh1d
    qKnv5NFDle4PNw04WVBjUs2B2SX7EJFfIISB+aUqv2EdWRA+yi0gNzsYZ1vL1n0uze+RlS
    jKYTBAfwgcOH42r+sWr1WMFodO+PhFfD9IqkYeJV242oOEhSpIJmOGxBCJ+5HQnvhA/lmK
    J0VJzT/0MucO2f5kUiOSxoApn6t2d/ulPooLafICW3RwD6DPz9j8XVqqjkIDaWFrtD8IaM
    BE46idPmXHtIFcCOCKnoErzn9Dbv7bjnMMKnI30gBGphv/oOzLdR5/NdYsJg
X-ME-Proxy: <xmx:bC48aiDZCupWyE9r5Bs7qp4OAe4AbJ7afuiTLaAuunsrbBbexXlCFQ>
    <xmx:bC48aqd6aqUHKHI68ytg7uqD1RXcBH80bUuWxUR_6Av4dbOLM6BBYw>
    <xmx:bC48an6E7fM-c0SgsXTNT6icUcaGJ9VzsFMJkzYiSg4sCvcq9rs2og>
    <xmx:bC48alX4FfIEl8G4k-KJg24RHhUhO-nCwF6_A6VUwclObo_RZH1j9A>
    <xmx:bS48amRdyjkxtfMWtgxQJ2QzP_9qAFJRiYw74yWKic7qGn2AisFuGt9e>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 15:22:19 -0400 (EDT)
Date: Wed, 24 Jun 2026 13:22:17 -0600
From: Alex Williamson <alex@shazbot.org>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, alex@shazbot.org,
 lirongqing <lirongqing@baidu.com>
Subject: Re: [PATCH] vfio/type1: validate dirty bitmap page size before use
Message-ID: <20260624132217.7fd42c77@shazbot.org>
In-Reply-To: <20260624191204.3774-1-alhouseenyousef@gmail.com>
References: <20260624191204.3774-1-alhouseenyousef@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jun 2026 21:12:04 +0200
Yousef Alhouseen <alhouseenyousef@gmail.com> wrote:

> The dirty bitmap ioctl paths derive a shift with __ffs() from the
> userspace supplied bitmap page size before comparing it with the IOMMU
> page size. A zero page size has undefined behavior, and a non-power-of-2
> value makes the bitmap size check use a different granularity than the
> page size later accepted by the ioctl.
> 
> Reject invalid bitmap page sizes before using them in shift arithmetic.

Thanks for the patch, this is already being worked:

[v1]https://lore.kernel.org/all/20260616111733.1810-1-lirongqing@baidu.com/
[v2]https://lore.kernel.org/all/20260617113251.2535-1-lirongqing@baidu.com/

Thanks,
Alex

> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index c8151ba54..9499381d0 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -26,6 +26,7 @@
>  #include <linux/fs.h>
>  #include <linux/highmem.h>
>  #include <linux/iommu.h>
> +#include <linux/log2.h>
>  #include <linux/module.h>
>  #include <linux/mm.h>
>  #include <linux/kthread.h>
> @@ -2949,6 +2950,9 @@ static int vfio_iommu_type1_unmap_dma(struct vfio_iommu *iommu,
>  		if (!access_ok((void __user *)bitmap.data, bitmap.size))
>  			return -EINVAL;
>  
> +		if (!is_power_of_2(bitmap.pgsize))
> +			return -EINVAL;
> +
>  		pgshift = __ffs(bitmap.pgsize);
>  		ret = verify_bitmap_size(unmap.size >> pgshift,
>  					 bitmap.size);
> @@ -3039,6 +3043,9 @@ static int vfio_iommu_type1_dirty_pages(struct vfio_iommu *iommu,
>  			       range.bitmap.size))
>  			return -EINVAL;
>  
> +		if (!is_power_of_2(range.bitmap.pgsize))
> +			return -EINVAL;
> +
>  		pgshift = __ffs(range.bitmap.pgsize);
>  		ret = verify_bitmap_size(size >> pgshift,
>  					 range.bitmap.size);

