Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E147357D1D
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 11:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780398849; cv=none; b=avHi7OrkxOWT1cTtVOxigsApY3cH6H4CrVVPFLJmpJzj0X/k1PrCEQqOfBL2BEmofNUZRCduco4XQboVjrWse7YW0UuwHjmJWGszOCJfWiNUZtH/nUCzJZwdsRPbLWreKtyx8wiD7tEnQIh0h/A/jTUu6zEt4oPJozoVFoCTkVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780398849; c=relaxed/simple;
	bh=1DRlpsqqwh7MQ+5dIHR70BnIA9LY+tGkbMQDeUQThbU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Km4uKmly+uhO7ZnO9oYzhQsx0mmXhMIdCvk8uDxGusY0HiK3sb5hCgaF6zFTyRYn3U9YeQLYhBwqwiCNF33P77dHwQ0VUpfxHeP68DU7foSNbbMVDKWqXfGmJUovVFM01bj76pm1VMnZDw4cF3+09vHD2lqEm7944m8Ezq/egEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsAD2M0z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsAD2M0z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6C61F00893;
	Tue,  2 Jun 2026 11:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780398848;
	bh=+E8JFY7fkx+aPAe526PTzzDsYFQhEYzfXeDLvM07IsE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IsAD2M0zT4ZMo1rW7RrkDFR2qHwSYI/ZIvCAWj0NoI9UFsSag6n94bxw3rjkbz7Ye
	 hHk6Bz0XKuXjVgm/lmlKh5FG/xGJgY0tr2C9JnS+xh/31By4fxbxvDbAFAPcuIL3MB
	 eMZHkF58v/BVULzOsn2CEPSyO6V1YQhZNfwrMJskJhyudoGO0X1FEx/J4z3F+TNSof
	 N9I58a5ek4WR6dCGI8J/Kw+gIpAGbu/Rqy1b9tqeDTYkaTlWAhMK/ty+0ZvoNeMgsJ
	 tLd09DiG2+cyQOto1IM4v8yud58kDc15PPRro1T/oPv/yHPmcdgE70RX3GDt3a00qr
	 sB1COLXI8wDhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 24/30] drm/panfrost: switch to iova_to_phys_length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260602104637.1219810-25-guanghuifeng@linux.alibaba.com>
References: <20260602104637.1219810-25-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 11:14:07 +0000
Message-Id: <20260602111407.EF6C61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-after-free of panfrost_gem_mapping caused by missing kref_get_=
unless_zero() during page fault handling.
- [High] IOVA aliasing and page table corruption due to the page fault hand=
ler resurrecting purged heap BOs.
--

commit 2c49ad58ab72225d5654336ec80f9da1ce85ee4e
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

drm/panfrost: switch to iova_to_phys_length

Migrate panfrost_mmu to use ops->iova_to_phys_length(ops, iova, NULL)
instead of the deprecated ops->iova_to_phys.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/pa=
nfrost/panfrost_mmu.c
> index 4a3162c3b659f..aa0bc82deaf68 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -514,7 +514,7 @@ void panfrost_mmu_unmap(struct panfrost_gem_mapping *=
mapping)
> =20
>  		if (bo->is_heap)
>  			pgcount =3D 1;
> -		if (!bo->is_heap || ops->iova_to_phys(ops, iova)) {
> +		if (!bo->is_heap || ops->iova_to_phys_length(ops, iova, NULL) !=3D PHY=
S_ADDR_MAX) {
>  			unmapped_page =3D ops->unmap_pages(ops, iova, pgsize, pgcount, NULL);
>  			WARN_ON(unmapped_page !=3D pgsize * pgcount);
>  		}

[Severity: High]
This isn't a bug introduced by this patch, but could this long-running
hardware unmap operation race with page fault handling and cause a
use-after-free?

When a GEM mapping's refcount drops to 0, panfrost_gem_mapping_release()
calls panfrost_gem_teardown_mapping(), which drops the mm_lock during hardw=
are
unmapping:

drivers/gpu/drm/panfrost/panfrost_gem.c:panfrost_gem_teardown_mapping() {
    ...
    if (mapping->active)
        panfrost_mmu_unmap(mapping);

    spin_lock(&mapping->mmu->mm_lock);
    if (drm_mm_node_allocated(&mapping->mmnode))
        drm_mm_remove_node(&mapping->mmnode);
    spin_unlock(&mapping->mmu->mm_lock);
    ...
}

While the mm_lock is dropped, the mmnode remains discoverable in the drm_mm
tree. A concurrent page fault can then find this soon-to-be-freed mapping
and increment its refcount from 0 without checking:

drivers/gpu/drm/panfrost/panfrost_mmu.c:addr_to_mapping() {
    ...
    mapping =3D drm_mm_node_to_panfrost_mapping(node);

    kref_get(&mapping->refcount);
    break;
    ...
}

Once the release function finishes and frees the mapping, the page fault ha=
ndler
would dereference the freed mapping pointer. Does addr_to_mapping() need to
use kref_get_unless_zero() to prevent this?

[Severity: High]
This is a pre-existing issue, but can the page fault handler resurrect a
purged heap BO and cause IOVA aliasing?

When the shrinker purges a heap BO, it frees the IOVA range and drops the
pages before releasing the BO's dma_resv lock:

drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c:panfrost_gem_purge() {
    ...
    panfrost_gem_teardown_mappings_locked(bo);
    drm_gem_shmem_purge_locked(&bo->base);
    ...
}

Concurrently, a page fault handler might have found the mapping via
addr_to_mapping() and blocked waiting for the same dma_resv lock.

Once the shrinker completes and drops the lock, the fault handler wakes up,
acquires the lock, and sees !bo->base.pages. It then blindly allocates new
pages and maps them:

drivers/gpu/drm/panfrost/panfrost_mmu.c:panfrost_mmu_map_fault_addr() {
    ...
    if (!bo->base.pages) {
        bo->sgts =3D kvmalloc_objs(struct sg_table,
                                 bo->base.base.size / SZ_2M,
                                 GFP_KERNEL | __GFP_ZERO);
    ...
}

Since the IOVA range was already freed in the drm_mm allocator by the shrin=
ker,
it could have been assigned to a different BO, leading to hardware page tab=
le
corruption. Should panfrost_mmu_map_fault_addr() verify if the BO was purged
(e.g., by checking if the mmnode is still allocated) before allocating new
pages?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602104637.1219=
810-1-guanghuifeng@linux.alibaba.com?part=3D24
