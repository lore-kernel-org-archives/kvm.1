Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279E4318BB8
	for <kvm@vger.kernel.org>; Mon,  5 Oct 2026 17:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791223035; cv=none; b=pJcOFxmRGZuHMp6WDV1ODfOCNzKrizOBmu6i04a6JlBe5akmvaabrApwrGVBaEdK/k17ZDXcuTJ60foxY2JGc620eBoqvbmkziqKcczw0EChiFm0uTfjbknNPogfWGKKQSeSP4TK4tJsX9npXOesLCly205tuQZD/IQ4D85xv+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791223035; c=relaxed/simple;
	bh=AN4rzIHIN14p5cWPF2d+YQz3LHLS6fGRmytr9rsm7Mo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RdjOShUI4S9jJMAaj4pJvlbfM75mLvnCsa+AEjc5TthE2WN/TWiupJhLvvGDw0MsB6aDV5vWPjS1YqkIuT+jcoeciJvXxYb1gykWgHg9CvrFKVnjW3kMiJEIg8YM6qR81eTNWNonurUuQZ54Mfr+pw13CsggzjFf23rO/mRQkus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNoqH9GH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNoqH9GH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8701F00893;
	Mon,  5 Oct 2026 17:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791223033;
	bh=LhHCOSU5MJd70+Mrutx/GmqhVWqzTXbOGEiCa5LAhe0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QNoqH9GHhETkk5VCzEV+GqiSLpHp8i6NWO4Be2bQDut3O69SjBNADq5BufQt6swns
	 lo7SX/GUC3rfC6oZmKY2I3mMZINb3aVSKa5RjRjslOLBzs/BFSjg/bVh/M5wVioD2o
	 Sgsry0zKJRrXeZ0sjUYn10lSgWBuCvkP2wMR2oYtwo29sOI9bFxeV1fRXd+8VEhwFD
	 KbTTLURrwgBAnkDT6ZxqoZ558M+hfOgwNpd1LTjeBcmbaaAubdR1Mh8VjYxTBrxYG4
	 DDGCvNpHfJN3pNUu+qgH2Azcfu09mRhLInWlM/Dk+YS1q67t3OABJDGagUwVubs0Fq
	 tULYvJWyPyHtA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/6] x86/virt/tdx: Support DPAMT when adding memory
 for the extensions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Yilun" <yilun.xu@linux.intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261006-tdx-module-ext-v3-6-db52cb05b918@linux.intel.com>
References: <20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com>
 <20261006-tdx-module-ext-v3-6-db52cb05b918@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 17:57:13 +0000
Message-Id: <20261005175713.8B8701F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] tdx: allocator thrashing due to unconditional DPAMT allocations
--

commit 02adad93d9f4243664b0cea8f1ad9c0b433e79a8
Author: Xu Yilun <yilun.xu@linux.intel.com>

x86/virt/tdx: Support DPAMT when adding memory for the extensions

This commit updates the TDX module extension memory setup to install a 4K
Dynamic PAMT (DPAMT) for each page before adding it. It calls tdx_pamt_get()
for each page within the memory chunk.

> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index 5d5f9da1ab028..27a7039ee443c 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -1330,8 +1330,15 @@ static __init int tdx_ext_mem_setup(void)
>  		struct page *chunk =3D page + added_pages;
>  		unsigned int i;
> =20
> -		for (i =3D 0; i < chunk_pages; i++)
> +		for (i =3D 0; i < chunk_pages; i++) {
> +			ret =3D tdx_pamt_get(page_to_pfn(chunk + i), NULL);

[Severity: Medium]
Will calling tdx_pamt_get() sequentially without a DPAMT cache cause severe
allocator thrashing during boot?

Looking at tdx_pamt_get(), providing a NULL cache forces an unconditional=20
allocation of DPAMT backing pages before checking the reference count:

arch/x86/virt/vmx/tdx/tdx.c:tdx_pamt_get() {
    ...
	ret =3D alloc_pamt_array(pamt_pages, cache);
	if (ret)
		return ret;

	dpamt_refcount =3D tdx_find_dpamt_refcount(pfn);

	spin_lock(&dpamt_lock);

	/*
	 * If the DPAMT entry is already added (i.e. refcount >=3D 1),
	 * then just increment the refcount.
	 */
	if (atomic_inc_not_zero(dpamt_refcount))
		goto out_free;
    ...
out_free:
	spin_unlock(&dpamt_lock);
	free_pamt_array(pamt_pages);
    ...
}

Since 511 out of 512 pages in each 2MB block will find the entry already
present, the newly allocated pages are immediately freed. For tens of
megabytes of extensions, this results in thousands of unnecessary allocatio=
ns
and frees. Furthermore, free_pamt_array() performs expensive memory resets,
leading to unnecessary boot delays.

Could a struct tdx_pamt_cache be allocated locally in tdx_ext_mem_setup() a=
nd
passed into tdx_pamt_get() to avoid this thrashing?

> +			if (ret) {
> +				WARN(1, "DPAMT setup error for extensions, stranded all pages\n");
> +				goto out_free_hpa_list;
> +			}
> +
>  			hpa_list->phys[i] =3D page_to_phys(chunk + i);
> +		}
> =20
>  		ret =3D tdx_ext_mem_add(hpa_list, chunk_pages);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006-tdx-module=
-ext-v3-0-db52cb05b918@linux.intel.com?part=3D6
