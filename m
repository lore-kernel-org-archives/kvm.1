Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D503A3AB5B2
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781882038; cv=none; b=abmgoyjSG1Sd+X6kRs4YbtziPVH83llzLeJQuaUulm+h+/g8c+KHzf7YW3c1dbwSa/8QqSau2WQaYEZsTr/YhKQVCFig76LS1R8OEpPXwP2/Ubp9lVuLmKM/tkTWB4jKNthVGbB/8KVUHADNKmMYpqHvhqMSJ9RncVd6trvsYo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781882038; c=relaxed/simple;
	bh=7dArzhHm5JN2w2xzSputPd5Cg7SBo1/ENQ+GdmSV7pc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M9l0OljPQqd6hq/ZuHNcmF2aF/tX6/nEQK4WPH8XI+VWwgGwfOA2VOqGJbzjr9FAZR/XtLNgRd7X2AEZ4Ar/a1/42Q6fLebs/TrxSVvQT5l3lXDe2rFP4hgYHTST4Xus87GfyIU+88gd2niWCzZUB/+1zX19MbMSmdlia4ykqrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdagVVHn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdagVVHn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528E31F000E9;
	Fri, 19 Jun 2026 15:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781882037;
	bh=twCMkcNvvo1IX6CubXDQnj8pRmmC+Y2XSe4HQYLYTjQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CdagVVHnmZDol+Ms9vaODmfhLlnVXJ6+1DPMwAwZyAIxaxtxQ6q4zGXaDfezODX+E
	 lQ0CXfVlMK88fremMlD9XnL++j46HjF+ge/L5ewBjc1rcbu7EpRlTuV6p57RKN8P6u
	 Nupi+D8GShdSjruxr1oWQU+DZH8w8TRhg0xkEfcl2zGzgCcIeiMZ+1KvzKDS5V1JsB
	 3WI2ckg3W9W0gobBjfqbFlu8vd7ekdeQ4FhpGxkTwJ3EReLa/PPmjCqRo+JZALhjgf
	 jshL2kAN9fj1nRxj4BHaX6eJm2Upu03Sidqtuh+ii88WFIGUCNhDIbcorOhi4XvmKr
	 1zKXF/Pvdfecg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.10 5.15] vfio/iommu_type1: replace kfree with kvfree
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nikolay Kuratov" <kniv@yandex-team.ru>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260619150206.1719815-1-kniv@yandex-team.ru>
References: <20260619150206.1719815-1-kniv@yandex-team.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 15:13:56 +0000
Message-Id: <20260619151357.528E31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Memory leak in vfio_dma_bitmap_alloc_all error path leading to DoS=
/OOM
- [High] Out-of-bounds user memory access on 32-bit platforms due to incorr=
ect pointer arithmetic in update_user_bitmap
--

commit 40ca6fabb082675b1379a40ebe33b025f5ba2193
Author: Jiacheng Shi <billsjc@sjtu.edu.cn>

vfio/iommu_type1: replace kfree with kvfree

Variables allocated by kvzalloc should not be freed by kfree, because they
may be allocated by vmalloc. This replaces kfree with kvfree for dma->bitma=
p.

Link: https://lore.kernel.org/r/20211212091600.2560-1-billsjc@sjtu.edu.cn

> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_ty=
pe1.c
> index 67e8276389951..65df5bbc71a8b 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -220,7 +220,7 @@ static int vfio_dma_bitmap_alloc(struct vfio_dma *dma=
, size_t pgsize)
> =20
>  static void vfio_dma_bitmap_free(struct vfio_dma *dma)
>  {
> -	kfree(dma->bitmap);
> +	kvfree(dma->bitmap);
>  	dma->bitmap =3D NULL;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but looking at the error path in
vfio_dma_bitmap_alloc_all() which calls this function:

drivers/vfio/vfio_iommu_type1.c:vfio_dma_bitmap_alloc_all() {
        ...
        for (p =3D rb_prev(n); p; p =3D rb_prev(p)) {
                struct vfio_dma *dma =3D rb_entry(n,
                                struct vfio_dma, node);
                vfio_dma_bitmap_free(dma);
        }
        ...
}

Does this code leak the previously allocated dma->bitmap memory?

The loop iterates backward using p, but it extracts the vfio_dma struct
using the failed node n instead of the loop iterator p. This causes the
error path to repeatedly free the failed node while leaking the successful
allocations.

Unprivileged users might be able to trigger this failure repeatedly via the
ioctl, which could exhaust memory.

[Severity: High]
This is a pre-existing issue, but can this pointer arithmetic cause
out-of-bounds user memory accesses on 32-bit platforms?

drivers/vfio/vfio_iommu_type1.c:update_user_bitmap() {
        ...
        unsigned long copy_offset =3D bit_offset / BITS_PER_LONG;
        ...
        if (copy_to_user((void __user *)(bitmap + copy_offset), dma->bitmap,
                         DIRTY_BITMAP_BYTES(nbits + shift)))
        ...
}

If the bitmap parameter is typed as a u64 pointer, advancing it by
copy_offset on 32-bit architectures (where BITS_PER_LONG is 32) will move
the pointer by copy_offset * 8 bytes.

Since copy_offset is bit_offset / 32, this advances the pointer by
bit_offset / 4 bytes instead of the expected bit_offset / 8 bytes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619150206.1719=
815-1-kniv@yandex-team.ru?part=3D1
