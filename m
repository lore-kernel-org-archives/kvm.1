Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CFE157A5A
	for <kvm@vger.kernel.org>; Sun, 31 May 2026 11:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780225289; cv=none; b=tVx5H17INeZ8Gcge4Di7erW9B7pmVMqkd8r++o3InvUp7Axy8kWe6YiMHn34VxfKYtdvyGDFUNcikp+xdCa1G2piFhgxm2Y/+gty791FaGqjVzwjixb2B/5DkZhQDeu7zVZejFUZR4iPgszSQDUmFIUed61WNmTk4QtGbdeQf2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780225289; c=relaxed/simple;
	bh=fMjQ6ztzvStKpQLU/zJAqBXf62u9W4KX93ane4GHo+w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YQ+lHsIUldhj+w73WC0tPQejN6fVbVFekkPsGEy7Q8qaouel7EyPTNoQvrXlvTAm4WLROOHnZhKF7j4iuUvrhfqr632g8ibLrpvEMnQ7Rzelo60ZbTFU9bUifvNq8coM5xUqmdsklCW9b2BxEG5bGPMToJAyjgxXr6NuZSJl+6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJsjKUaK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJsjKUaK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252771F00893;
	Sun, 31 May 2026 11:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780225288;
	bh=p5QmQWdjg2Q3lduEnnpQPbGuJbZbILM3CwpIQvqSs5c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fJsjKUaKHyyBOe2/FkkeK137MyajC3XMA6hJHXaMgMVHlh0OpDSDAaFxxH1Fz2IoI
	 VZQgOZJXGh0YK0OOYjyxA3+Oft6mk+r0qRFW6Mq86SulY8JYFORkRVXsl1uUJGsuw/
	 bfGE8kddT0JbKmAwBur/0+3XJWQmyC5rmTGgsFUclydc8FZqEax6YO01SOluMAIwMR
	 TJEqGMIYRjhTXc1VK36Vqj8PwYG0kYys6rSa9HNpvTO5xtiTIuPoTH+n6WV0aDzfUZ
	 qm7mgvzSEWM7a4oaCtxiIhUBRWlkBBRPnctaSftAU/sJGOyL/fJWAkwlUhoqRODFfS
	 LcppfUdxJ9HVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/9] vfio/iommufd: use iova_to_phys_length for efficient
 unmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260531093637.3893199-8-guanghuifeng@linux.alibaba.com>
References: <20260531093637.3893199-8-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 11:01:27 +0000
Message-Id: <20260531110128.252771F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Missing bounds check in `vfio_unmap_unpin` allows out-of-bound=
s unmap and unpin
--

commit 400f16aa1c5788ec3ad51067e2b226d2e48c53d6
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

vfio/iommufd: use iova_to_phys_length for efficient unmap
   =20
Use iommu_iova_to_phys_length() to get PTE page size, allowing
traversal by actual mapping granularity instead of PAGE_SIZE steps.

> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_ty=
pe1.c
> index c8151ba54de33..393f9e8f1511e 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
[ ... ]
> @@ -1177,25 +1177,41 @@ static long vfio_unmap_unpin(struct vfio_iommu *i=
ommu, struct vfio_dma *dma,
[ ... ]
>  		/*
>  		 * To optimize for fewer iommu_unmap() calls, each of which
>  		 * may require hardware cache flushing, try to find the
>  		 * largest contiguous physical memory chunk to unmap.
> +		 *
> +		 * Calculate remaining contiguous bytes within this PTE from
> +		 * our position, then try to join following physically
> +		 * contiguous PTEs.
>  		 */
> -		for (len =3D PAGE_SIZE; pos + len < dma->size; len +=3D PAGE_SIZE) {
> -			next =3D iommu_iova_to_phys(domain->domain, iova + len);
> +		len =3D pgsize - (iova & (pgsize - 1));

[Severity: Critical]
Is it possible for the hardware PTE size to extend beyond the remaining size
of the logical DMA region?

If the IOMMU driver returns a page size that extends beyond dma->size - pos,
len is never clamped to the remaining size. This would cause len to oversho=
ot
the region boundary.

> +		for (; pos + len < dma->size; ) {
> +			size_t next_pgsize;
> +
> +			next =3D iommu_iova_to_phys_length(domain->domain,
> +							  iova + len,
> +							  &next_pgsize);
>  			if (next !=3D phys + len)
>  				break;
> +			if (!next_pgsize || next_pgsize < PAGE_SIZE)
> +				next_pgsize =3D PAGE_SIZE;
> +			len +=3D next_pgsize;

[Severity: Critical]
Could unconditionally adding next_pgsize to len cause it to overshoot the
region boundary before the loop condition is evaluated?

If the next page size extends beyond the end of the region, len will again
overshoot the target boundary.

When an oversized len is subsequently passed to unmap_unpin_fast(), will it
unmap and drop pin references for physical memory outside the target region?
Dropping pin counts for active adjacent memory regions could corrupt page
refcounts and lead to physical use-after-free conditions.

>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531093637.3893=
199-1-guanghuifeng@linux.alibaba.com?part=3D7
