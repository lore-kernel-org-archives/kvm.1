Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1C8391841
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 23:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780358142; cv=none; b=HZU5lG5uWZMoU0JCHO276MJK/CkFEAawSAcj0nEcM8Fb7Aj3VyKaPHoTmMBJhDjPb9ZifJIuCOlfUn1bKluBe7X9S7T7mFV4vD1manLRYmwVFnvu3VmMY0trNOhy3HqmGMZRm2u/qI9McQRm59Ef+du0KMR8xcXt8JwbDKchlQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780358142; c=relaxed/simple;
	bh=QYiFFm+h4Tlm2jgvHsTxlf0TR3ZTNNGMdqw9lRplD1s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RYNugSPsat/e+JCTO+Hla3qi8w8UWl8cnnj0Um2nthzxze8WhDJK8f7w+ilIpC/r6BNKJ5zjMgHpml50/dCUewIp+n340Ols/qD4hfvX1G9Lqvu65089FQRAAjpcamW3vAdECt+U1g2Sr1iYqX4RsTdN1eGe4XeSF+wd2OQlT44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFcOPRSY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFcOPRSY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C089C1F00893;
	Mon,  1 Jun 2026 23:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780358140;
	bh=VXMORaCRPnPRZCwbR4MwJULSA42wJ3mNpPyn673f4nM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DFcOPRSY8sBtwtZURGIBJUNjIfeG9X3QYcc3MCnbV3Zd/z4zE0a1xfV4kRgMF8jhs
	 asilMbQPj9OxFxGHEfpFFtJe6tqgtsXk0EB3jv1FnFC8IYjAfWjIPB7hPvTPFbvqZi
	 MPs2E/Sl7y5h5MAT4NxS2gPdrUnLoORQI0sB55Dma8meu7WT8wUN541cCeuHOgHx8b
	 20N5vWiX5UX5QJ/kGogUGTHD9e2uiPWh2jEVvZfgPzOM37lNky9fZib5Q8/WCYQonE
	 dy7mZ2R5jvrjggUyfuAxNdo8CUQxfhOEnjLuYWIePCfPrfb81ikNguauC0q4jpuyyV
	 P9ZszX0WenyKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] crypto: ccp: Fix memory leak in SEV INIT_EX path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260601-sev_snp_fixes-v2-4-611891b28a86@meta.com>
References: <20260601-sev_snp_fixes-v2-4-611891b28a86@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 23:55:40 +0000
Message-Id: <20260601235540.C089C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] When SEV-SNP is initialized, `sev_init_ex_buffer` is explicitl=
y transitioned to a firmware-owned state via `rmp_mark_pages_firmware()`. H=
owever, the driver never reclaims this buffer back to a shared state before=
 reading it. Immediately after the `INIT_EX` command completes, `__sev_do_c=
md_locked()` unconditionally calls `sev_write_init_ex_file_if_required()`, =
which invokes `kernel_write()` to read from `sev_init_ex_buffer` and save i=
t to disk. The host CPU's attempt to read firmware-owned pages inside `kern=
el_write()` will trigger an RMP violation (Machine Check Exception or #PF w=
ith RMP bit), causing a fatal host crash.
- [High] The `sev_init_ex_buffer` is allocated without the `__GFP_ZERO` fla=
g. If the NV memory file does not exist (returning `-ENOENT`), or a short r=
ead occurs, `sev_read_init_ex_file()` returns 0 without fully initializing =
the 32KB buffer. This uninitialized kernel memory is passed to the SEV firm=
ware via the `INIT_EX` command. Later, `sev_write_init_ex_file()` writes th=
e entire 32KB buffer back to the host filesystem, resulting in an informati=
on leak of kernel heap data to disk.
--

commit 9089d07a571c9b175950b197e846ef7b16492229
Author: Atish Patra <atishp@meta.com>

crypto: ccp: Fix memory leak in SEV INIT_EX path

This commit fixes a memory leak in the SEV INIT_EX path by freeing
allocated pages and clearing the buffer on failure. It avoids freeing
pages if they have already been converted to firmware-owned memory.

> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -1550,7 +1550,7 @@ static int __sev_platform_init_handle_init_ex_path(=
struct sev_device *sev)
> =20
>  	rc =3D sev_read_init_ex_file();
>  	if (rc)
> -		return rc;
> +		goto err_free;

[Severity: High]
This is a pre-existing issue, but does allocating sev_init_ex_buffer
without zeroing leak kernel memory?

Earlier in __sev_platform_init_handle_init_ex_path(), the buffer is
allocated without the zeroing flag:

page =3D alloc_pages(GFP_KERNEL, get_order(NV_LENGTH));

If the NV memory file does not exist, sev_read_init_ex_file() sets
ret =3D 0 on -ENOENT and returns without initializing the buffer. Short
reads also leave the remainder of the buffer uninitialized.

Later, sev_write_init_ex_file() writes the entire 32KB buffer back to
the host filesystem via kernel_write(). Could this result in an
information leak of uninitialized kernel heap data to disk?

> =20
>  	/* If SEV-SNP is initialized, transition to firmware page. */
>  	if (sev->snp_initialized) {
> @@ -1559,11 +1559,23 @@ static int __sev_platform_init_handle_init_ex_pat=
h(struct sev_device *sev)
>  		npages =3D 1UL << get_order(NV_LENGTH);
>  		if (rmp_mark_pages_firmware(__pa(sev_init_ex_buffer), npages, true)) {
>  			dev_err(sev->dev, "SEV: INIT_EX NV memory page state change failed.\n=
");
> -			return -ENOMEM;
> +			rc =3D -ENOMEM;

[Severity: Critical]
This is a pre-existing issue, but does reading a firmware-owned page
from the host CPU trigger an RMP violation?

When the buffer is explicitly transitioned to a firmware-owned state
via rmp_mark_pages_firmware() here, the driver does not appear to
reclaim this buffer back to a shared state before reading it.

Immediately after the command completes, __sev_do_cmd_locked()
unconditionally calls sev_write_init_ex_file_if_required(), which
invokes kernel_write() to read from sev_init_ex_buffer and save it
to disk.

Will the host CPU's attempt to read firmware-owned pages inside
kernel_write() trigger a fatal page fault or Machine Check Exception,
crashing the host?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601-sev_snp_fi=
xes-v2-0-611891b28a86@meta.com?part=3D4
