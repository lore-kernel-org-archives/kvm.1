Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0610740626F
	for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 13:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781702300; cv=none; b=DloV02l2iXAwIOBtX7wtagfXRykgTMShQaLeloVUMaMieuYq78PF1twfmb4QPJA0rVez1ZTM2lJRvBolfckyCvqs07VKUJhyFQcIrWAmt4fWV+Ueyjey9MLxi97YiLXQKRHZBfLsYodGDHzAst/dJWFYnMJHQ/6hustHvQiIDqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781702300; c=relaxed/simple;
	bh=EP2t/z50uhExgHQOTzwEpCctfQuGNeWwRLj1P4IvBGA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JmaWJKGPaJyfVN9ZpqsaPfWeiwjDbOYdgJDmxNxGvTpFI4rrRvnL7Wy7XzBMUzQbacmBu2erysaZyCtdUgEBcvloaqH+AQozbqE6/MNN3ACfajGROULyt38diy4ZtUmxGq4Boum90dNGH3VTkN0PLZgNyIsn++3Y/hWKCspSEWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYSwmsmO; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYSwmsmO"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-462342ac290so1105814f8f.2
        for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 06:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781702297; x=1782307097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpwQVnxc8WwBtYMRVthywpuSU/L6xp6cei6goRyt1MQ=;
        b=lYSwmsmOxteWSVZLIZcYTWpry9JhRRpobSYQlna1WmZv6oaWltFQjfpTqZQKbXIbau
         RobEFlndRmRvpWZLZahngHxY6b65XVIV3zhjbJp2Y7iqSezXp2LoEMR8A9paWA7to5jF
         2S933DfffyYYFi8LkJ0iTNyUcm8Z8bcmdrGf0jOohesKTAw7uS1XkXcVtMChe1Ik+RMv
         wQBeD4/t39PXMIlvGAvU3oJ6ZHGTiwPpq4vA+UK6zVUQE+iWmIlweop3C4sdi9s3+vcV
         BMzyv9Wi+1BNv85AO2GYis62qlH7yTVExzYd4lEQKetATe3H1PIv2QeUMx16Spq4RQi2
         M3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781702297; x=1782307097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xpwQVnxc8WwBtYMRVthywpuSU/L6xp6cei6goRyt1MQ=;
        b=YOvRyLxHAutSiDnF9Cgqu7cDmo0XvVNN8pszqLDYLQqOBGSB737UvJYCcLWq4jRmR5
         1qDiAmfcUdCxT29dcsN8Du2qk8UkQuFB42t7bunSHmrRdDE5wbsJLVuxmpiFnIfmMo66
         ud81kEly/mh5xHyLZJVr5DmEqzVa3U50cOHZLVNV+YasQuBPfD1pE4RMXTEq1Jaj+GQe
         /fBzSw9iMQnvU34aW8ORxlpiDQPjokgpc9kBW0prQWwPshZeA/aH0J0RBKk9hRVMPEIE
         X8YTu92g8gbebJNBO6ZwsMK6qiS9zWvrCv3KZK3QhAgXLwNSBxf2O6kAUm5Cdfyq7O+u
         Xv5w==
X-Forwarded-Encrypted: i=1; AFNElJ9tUifxZJ7iLUdLZ6BRRFWFDONPhVbqd9hzrTv6VTTiy1aGjsJ/uPprdDP1AFeb3Mkf8rM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdS3GWKO2FtZZY8rrYg6l0tlajHt5e9gqgS5P72skSjqkkYxIl
	AmxZbl/xujKHqs7CARMwx2Q1xBSSqaOj/NP2QjqdHMkVTNUYM/pZaRkS
X-Gm-Gg: AfdE7cnyDmE13OEWHlHD8NX0JlQ3hVzVzvxqq0rk32K1xwi6sewae0RbXT2FggyHGzO
	NLAKN8dGmXs6P07GAoJhndR+WZNcUavEdqyUFtmQWXv+K/bjgrHTh/ViGC/8zjnFgBwtN1QU+wI
	NZVZQqx5TKZcYVwke2vBOz4hKEypFkl+7CrjJb3I+4ol7zNaZByrFSpgZziQ0SQDmciQ9M0Q/7+
	QARUeSv394IPd4q5C6m39b5Ar+G7Dntf/N9su4GWCa8BG4sJgKZ03+Cd7gVZ46WThLTIcIWXm0C
	vqstuOFpxjxYFmjVKOywH1f0gH4lcBi8WwAht2p/dquhrPq+n9XXmqWwCikZmAD+mxxcCf/CDCx
	6Q1OeZPHVbKu5ZoD+aHcUfMbiWAXsHx/TY7+1Ex9MdQbe/jExr/gx03Nn7PvLg3j9audcN6nJVQ
	rqzEf/Rucb5P+mizTpsiP0icb19xfJeZyfAdjUCQw9yn2eyH2z+du6AElCiUBV
X-Received: by 2002:a05:6000:1787:b0:45e:739b:3e3c with SMTP id ffacd0b85a97d-4623bdcc225mr6161005f8f.0.1781702297182;
        Wed, 17 Jun 2026 06:18:17 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f3dcsm50818305f8f.13.2026.06.17.06.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 06:18:16 -0700 (PDT)
Date: Wed, 17 Jun 2026 14:18:15 +0100
From: David Laight <david.laight.linux@gmail.com>
To: lirongqing <lirongqing@baidu.com>
Cc: Alex Williamson <alex@shazbot.org>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][v2] vfio/type1: Sanitize user-supplied inputs to
 prevent undefined __ffs() behavior
Message-ID: <20260617141815.436e8103@pumpkin>
In-Reply-To: <20260617113251.2535-1-lirongqing@baidu.com>
References: <20260617113251.2535-1-lirongqing@baidu.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
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

Unrelated to this change...
There's not a lot of point calling access_ok() there.
All it does is check that bitmap.data isn't a kernel address and then adds
a synchronising instruction (lfence on x86) because of possible speculative
accesses to the kernel address (in the unsave_get/put_user() that is
expected to follow).

The actual copies do use copy_to/from_user() and include the check.

	David



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

