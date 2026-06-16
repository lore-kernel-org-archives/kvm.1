Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C77D3B7B93;
	Tue, 16 Jun 2026 23:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781651653; cv=none; b=BSZtu8soX75pxa6iEN0MEOxBae+Dd4Y1rX/A/uPgZEuyDr8RtBa4nwImknRdQwhUYQdZp7ykoLql96kIIO4vxCheGVZO8zfyhJ9fVaqWThx8rm5N+yHOiNtcjjVCDRQXV67U34Q2qCb593sYGv89jOQSFkp8+lPU3VBZ4yD1FhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781651653; c=relaxed/simple;
	bh=t7lrRG8AnbocckVZdamOmdWEZ7uQyiGEYq8Rb8StMyU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m3OmZzWQIkiPp0u+Rx+ApOER802dbV1/0AIVKJ3cq83LU2rw8dgb6Tk/5hjh3hTwzU1DCLNjVvdy3XX1URXePlRx4OOwtRlB+5AaaM3dE/+v6efzMugBnrGVtkL+tSbcnQXC1eka1IQEW69vmYLCpGiVCykDUE01PikEpYHiDPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=dbNRF25V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FAr2W3yD; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="dbNRF25V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FAr2W3yD"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 460E7EC02C6;
	Tue, 16 Jun 2026 19:14:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 16 Jun 2026 19:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781651650;
	 x=1781738050; bh=m3KPD6R3/nmzMzGvv8721iLN0Awz55kgwiWWepmj4uo=; b=
	dbNRF25VxKShVi3uhxs1CUIst/VOUic+UzN9eVC7Oo6GWi4iS5pMiOy0O9xBD8Q1
	OKByiZW57XlVlLSwArnKFXsehtzKq1Wa+t4z/fP+ToQbE0Mo3hKpqQh0wyYOQky8
	hZ7o5HMtHKwUcxHy+jdow8xtiowDEk5ASBIpw03Ya5T2nOgXKoajKADVlMcKWrck
	aZWfPbh62D9wkiI/hkgXlhQmlyplNMAqgh9l7aTYvOCC87aUAzEHciN3nL1AiwKv
	n8m27J+x1bqdSUOVBdnxHByDVArj39/OcMkkBm7CbTYm24j8voJPjzrPJps48spx
	DEmsEXw6pgJMUM6LZKVN8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781651650; x=
	1781738050; bh=m3KPD6R3/nmzMzGvv8721iLN0Awz55kgwiWWepmj4uo=; b=F
	Ar2W3yDx3v0pV8k5t9la5ezZm+n4wz/sxAbvINWUWk2iH9gqmUK6/ijGeZbsYhF0
	Zg4WHLd/KjHjVMkYsTZMiutyKHoUcIxMJWQv5pcyRpCT6k00xYARLUHGdXHw7I/e
	iCgBvIEF4Wqw8tV56I+HSW3EYFKUJkv2mXMKK/IvQS1bMVxs2vgMAnF7Wr2Xwd39
	2QaAIbfuEQGyDNqZKJX+ER5q4YzV54SD6leepoR/DtPnEFsO/aIzkubspdss6Gul
	/golDtc2F2cbOpDcXoaWyAmEHpsB5t2k9praDjFb7vm//KTZt1FB9+IwwjNcKGt6
	8nOTOBtkuTCQI0TNuRMhA==
X-ME-Sender: <xms:wdgxagE7cKJLkN4t6HquVSxp2_ZIskIhwCQQWTc-RgrgoBsk4sUjIg>
    <xme:wdgxanIT2BpZlyocZlczh4O7-gX5M1S2PbL2em_MKwvkuK_E30VDzOq9DVO66-B7Y
    xXTjGOm3XKzcYty5ZhV5DVEXL5chaCZZjmhjQ7L4yGOTAlT62YO>
X-ME-Received: <xmr:wdgxaknp0QWbrXIqqPPr9daQ7CFikIlKgYm6wGjtY751hwKI-2USRq1_jEo>
X-ME-Proxy-Cause: dmFkZTFR3XFb24TCv08n/AnzUvv5OGswTNvmuZxAADADCwEcrotlPnOnyy5J+tPCKFqAvi
    u1GHVXWUm0SBNp6QYBUBTY7ixfA6WsOnxOre2I3WeyxL60ZsJR3bFXrmW0FOpm1K65CrnJ
    WyEUrHwXP1U4LV0Z0obtDsIBfi8k/RFR6ailwNByjIkMQLs+lHPE/DlwvpxXVXzVcbjJHU
    T5NBj9i1s86X48OHIiAQrdlvi/e0+FCFswx20wTX6O2/6tnbnP74vjJI5aEO73/LhKxAe+
    f62+N4BQ8njCGJwTs+pGVqaO+LARCwWkMG9hUgeH0V+gDybk9oI2s+ri4Zs3ZrJgehh5rl
    A7vlI1nnAPt1sFWabZKXhJdUj4mA7ulQ4r5M+BM/ErEXn1olIjCm/xOhQ9+QqUKv10jXMX
    VX5kTg0qDZCU7Ma60zeiH85rSnjhYUe7FarOGAHOGuVfaMmi9uFBtfc0limDXw7vUFcX3g
    TDUYppTcSmAas0wlc/jp0iqbyM5LQOKjdG1io2LgRz+Vrkxhv778kiWQu0BA63Ap30fQuD
    0hBsPHPUleSoWJ1cqIMOJkp/RXZbVXPrnBekdufmoKqJrG0Quf/TjxW8sT4X1JVKHWhjRj
    BEgkw4cAI6ySmXA9cqNFz3/duw5NhErbmfxNr8nA1awH6oYoXYBBirayYpVw
X-ME-Proxy: <xmx:wdgxavQ32r36Zvt28XA-NAjeShYnwc8XJ2lR-arGvAsNkTauq4dKiQ>
    <xmx:wdgxamIeCpkJFsU_qJbDjZhKF59DhFXa2v799VaWJasja0kw0ocv0w>
    <xmx:wdgxalDiH1pJmmDgjig0zW14XXJAUr2bOaW9YYJb9dmrDZDtq2VsSg>
    <xmx:wdgxavDOuancdJo-UMkwAdCNqQvMxWDMnlh8fpWol3-mSzOu4xpyiA>
    <xmx:wtgxamHqiM6ob_zYv-ft5eizS3b8zIDIoBDYS7XftHvJvFIk9XlJha-X>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 19:14:09 -0400 (EDT)
Date: Tue, 16 Jun 2026 17:14:07 -0600
From: Alex Williamson <alex@shazbot.org>
To: lirongqing <lirongqing@baidu.com>
Cc: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH] vfio: Validate that bitmap.pgsize is a power-of-2 in
 vfio_iommu_type1_unmap_dma
Message-ID: <20260616171407.54190e05@shazbot.org>
In-Reply-To: <20260616111733.1810-1-lirongqing@baidu.com>
References: <20260616111733.1810-1-lirongqing@baidu.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jun 2026 19:17:33 +0800
lirongqing <lirongqing@baidu.com> wrote:

> From: Li RongQing <lirongqing@baidu.com>
> 
> In vfio_iommu_type1_unmap_dma(), the user-supplied bitmap.pgsize is
> passed directly to __ffs() without sufficient validation.
> 
> If userspace passes bitmap.pgsize == 0, it triggers undefined behavior
> in __ffs(), resulting in an undefined return value. Furthermore,
> passing a non-power-of-2 value (e.g., 3 or 5) results in an incorrect
> pgshift value. In either case, the invalid pgshift miscalculates the
> shifted unmap size (unmap.size >> pgshift), which distorts the
> subsequent verify_bitmap_size() validation logic and allows
> inconsistent user inputs to bypass proper sanitization.
> 
> Fix this by introducing an explicit is_power_of_2() check on
> bitmap.pgsize before processing. This strictly ensures the page size
> conforms to valid IOMMU page size semantics while preventing any
> downstream arithmetic anomalies caused by zero or non-power-of-2
> inputs.

For there to be an actual bug here, __ffs(0) would need to generate a
fault, not just return a garbage value.  If the value gets past
verify_bitmap_size() we call vfio_dma_do_unmap(), where we test
(bitmap->pgsize != pgsize), and pgsize is:

        pgshift = __ffs(iommu->pgsize_bitmap);
        pgsize = (size_t)1 << pgshift;

So, while I agree that we shouldn't be generating and passing around
garbage, the assertion that it allows user input to get past
sanitization isn't true.

The sashiko find is the same pattern, same downstream catch; __ffs()
returns a garbage value that's revalidated before use, never a fault,
so those sites are equally benign.

If you'd still like to pursue it, scope the commit log with the correct
severity, address the matching GET_BITMAP pgsize path, and repost.
Thanks,

Alex


> Fixes: 331e33d2960c8 ("vfio iommu: Update UNMAP_DMA ioctl to get
> dirty bitmap before unmap") Signed-off-by: Li RongQing
> <lirongqing@baidu.com> ---
>  drivers/vfio/vfio_iommu_type1.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c
> b/drivers/vfio/vfio_iommu_type1.c index c8151ba..b05fde8 100644
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
> @@ -2949,6 +2950,9 @@ static int vfio_iommu_type1_unmap_dma(struct
> vfio_iommu *iommu, if (!access_ok((void __user *)bitmap.data,
> bitmap.size)) return -EINVAL;
>  
> +		if (unlikely(!is_power_of_2(bitmap.pgsize)))
> +			return -EINVAL;
> +
>  		pgshift = __ffs(bitmap.pgsize);
>  		ret = verify_bitmap_size(unmap.size >> pgshift,
>  					 bitmap.size);

