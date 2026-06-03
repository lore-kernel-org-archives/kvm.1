Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0798F394785
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503240; cv=none; b=QW+RDsA2UNtLRRhaq8+UE1jkGvBneQynWK45ZMZm1KBpIhQgn5f9HiH56CnxNgYT8WjurNvAOQk6ZmEdg9T3lDlWJaGmlBvwqgAFnhSMs/9kjDXKVdY0iSOIvJbwZkjwh9Vvihv4BdeQ/Uh1FWwFRTzyCbpK9UDuNb6mxs0KJAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503240; c=relaxed/simple;
	bh=lQI2zKwOabcyreOVRoAiYcczj5cMcAO5/pTqrNzAgjU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=emQ6S15g/1iKwH/qQXtJjRvUgbKeD+03lOJZ/J2XxWdi2iVz/rjF3XVo5zzRIU+10S+bihHMtBmMZmM1qehzfg4HhCwc8+pHCS8KoWmPMKKzeqNt7XLHwStMQE33A4A8vRR0TL1+Vb4f+CZNQWI6MaTVjueoi62GNmv+/mRpv5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7uEYtRg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7uEYtRg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED0C1F00893;
	Wed,  3 Jun 2026 16:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780503238;
	bh=72P88mawBVJAy/FOVe4EdxOHANglZdoSwSEALe1HiFo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h7uEYtRgiOGm4frTUk/lUcSmy3en+hMCfNZYwUnWU507aCrHIm/NzBZ95u/qQIN6R
	 xHVbjlmilroLQ1i6Rpmjc1vFOAKRDDAtsnJKFaiiaGsozoA/xZd/BRW+hvPbZY6UOL
	 OZCpPrXen7yA3TY+58z1wdeUDoiY34L2A5pOx6bHMEG6pT95xqwWaF/VP7zZKOwu9k
	 z1nqrfyxE6TP4UpfUv8cXkFPu8u/AZxn9Yi7ViKfw5pLzVibv2c01eNCh4Y1MA8iE0
	 8OARclmp0rwqQhg9BsisGgols4EnQ3dgbrpjOA5qk/KPZNiE7OWUF3gxfvU/UjTRqk
	 l3lkEwtGpQJ0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 26/32] drm/panfrost: switch to iova_to_phys_length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260603151804.1963871-27-guanghuifeng@linux.alibaba.com>
References: <20260603151804.1963871-27-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 16:13:58 +0000
Message-Id: <20260603161358.8ED0C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent page fault can trigger use-after-free and double-free b=
y acquiring a reference to a mapping whose refcount is already 0.
--

commit b6d0dc27aaa83b48f982d46bb758b6be17d2c8ce
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

[Severity: High]
This isn't a bug introduced by this patch, but can the execution of
panfrost_mmu_unmap() race with a concurrent page fault and trigger a
use-after-free or double-free?

When a mapping's refcount drops to 0, panfrost_gem_mapping_release() calls
panfrost_gem_teardown_mapping(), which executes panfrost_mmu_unmap() while =
the
mapping is still in the mmu->mm tree:

drivers/gpu/drm/panfrost/panfrost_gem.c:panfrost_gem_teardown_mapping() {
	if (mapping->active)
		panfrost_mmu_unmap(mapping);

	spin_lock(&mapping->mmu->mm_lock);
	if (drm_mm_node_allocated(&mapping->mmnode))
		drm_mm_remove_node(&mapping->mmnode);
	spin_unlock(&mapping->mmu->mm_lock);
}

If a GPU page fault occurs concurrently, panfrost_mmu_map_fault_addr() calls
addr_to_mapping(), which finds the mapping in the tree and blindly incremen=
ts
its refcount:

drivers/gpu/drm/panfrost/panfrost_mmu.c:addr_to_mapping() {
			...
			kref_get(&mapping->refcount);
			...
}

Since the refcount is already 0, using kref_get() here seems like it could
cause a use-after-free when the fault handler drops the reference via
panfrost_gem_mapping_put(). Should addr_to_mapping() use
kref_get_unless_zero() instead, or should the mapping be removed from the
tree before unmapping?

>  			WARN_ON(unmapped_page !=3D pgsize * pgcount);
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603151804.1963=
871-1-guanghuifeng@linux.alibaba.com?part=3D26
