Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A761243231C
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 16:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784737109; cv=none; b=ua/ZHtxUlB/N/3N0TuihMr9aVdBN9EuE1/BeJUH85ECiIZ5+WCwS/ItSMEDtT7f5R27S4QNLAJxLfcn/G0SU3+1EeOQf2WQJ97+wk9E6SsunlU9TgiBO6p1VvA5KNWbCQtLqD50nd96s4ctPiEdtJpsy4V6WHof0bB+8f3INjAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784737109; c=relaxed/simple;
	bh=zlz5qO72o8SDFq2Xfxeue7Tbz6D/McTAR1Kh3pT11D4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jBsBp+kx/uroHSDLaBARuE+I7HRq+RgJTTw2Q9Y5hyxNH8TcNlpdLdmOcRblSnHapCHTR6hpP7V/jHAbx2UkQ/l/d3OtdUyrijK/otmP0xBrNGbMpAjKlVOmyXMGY4PBqVQOIQp/0yP8jpOro15atnkDuOrZd8lRvBV/syHHsdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tn+WW4g+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tn+WW4g+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F9F1F000E9;
	Wed, 22 Jul 2026 16:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784737108;
	bh=YfJmXCJkA1u+qaXUgMIpVxP3LXU7dwXzRGewyhYWnNM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tn+WW4g+Cd8Uv3KFZbfhURSwHGakbKNGx6Nn0UJKhsFLbCI4FW7bgodlwi64nmqdn
	 rTQnvswHnNlsmfWEA0IAy9DFL/72uqzXWbQ+2XopvwixzjqUHkigiOE8nPnS0rhagj
	 WufNGAmmkFaCw870OdJje0nily9+F/hGiz9wnLaLCJpS6f7jl9VUeVjvtQaDrSu3fZ
	 kc4WagQDQC6teAywRValxaJedCd6Taro8mWhd7zJchonOeeNfpxkNVMwWHsYeJgS9p
	 yOyAFUTZMeXdhngwf0s9Kn2jWN5lFhf3GGrRo89OMBaRSQkMCk+/ObiEquk9rqZoq7
	 JKM5ltI+dzt5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 14/20] x86: mm: skip pud setup when using generic
 compile-time folded pagetable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yeoreum Yun" <yeoreum.yun@arm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260722-dummy_ptxp3-v2-14-d9e4bad31e0a@arm.com>
References: <20260722-dummy_ptxp3-v2-0-d9e4bad31e0a@arm.com>
 <20260722-dummy_ptxp3-v2-14-d9e4bad31e0a@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 16:18:27 +0000
Message-Id: <20260722161828.22F9F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Incomplete `CONFIG_PGTABLE_LEVELS` check in `collapse_pud_page()` =
fails to skip x86 3-level PAE configurations, exposing them to latent compi=
le-time errors and potential runtime hardware exceptions (RSVD #PF).

Pre-existing issues:
- [High] In `populate_pud()`, an error path during the 'trailing leftover' =
phase silently masks resource allocation failures, skipping necessary clean=
up and causing a system crash (`BUG_ON`) instead of gracefully propagating =
the error.
--

--- Patch [14]: [PATCH RFC v2 14/20] x86: mm: skip pud setup when using gen=
eric compile-time folded pagetable ---
commit 163a3c6228e774c7dcf45c2630763c72ef0ffe3a
Author: Yeoreum Yun <yeoreum.yun@arm.com>

x86: mm: skip pud setup when using generic compile-time folded pagetable

We want to rework how set_pXd() behaves for generic compile-time folded
page tables by disallowing its use and triggering a compile-time error
when it is used improperly, ensuring that the actual first-level set_pXd()
function is used instead.

> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 078689aa7206f..91b33a265a431 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -1346,7 +1346,7 @@ static int collapse_pud_page(pud_t *pud, unsigned l=
ong addr,
>  	pmd_t *pmd, first;
>  	int i;
> =20
> -	if (!direct_gbpages)
> +	if (CONFIG_PGTABLE_LEVELS =3D=3D 2 || !direct_gbpages)

[Severity: High]
Does this check skip 3-level PAE configurations correctly?

If a user boots a 32-bit PAE kernel on a CPU with 1GB page support and
gbpages is enabled, direct_gbpages becomes 1. collapse_pud_page() would then
execute on a folded PUD (PDPTE in PAE) and write a PDPTE entry with the
_PAGE_PSE (bit 7) flag copied from the PMD.

In PAE, bit 7 of the PDPTE is strictly reserved, and setting it causes a
hardware exception (kernel panic).

Should this condition be checking if CONFIG_PGTABLE_LEVELS <=3D 3 to match
the logic added to populate_pud() below?

>  		return 0;
> =20
>  	addr &=3D PUD_MASK;

[ ... ]

> @@ -1730,7 +1730,8 @@ static int populate_pud(struct cpa_data *cpa, unsig=
ned long start, p4d_t *p4d,
>  	/*
>  	 * Map everything starting from the Gb boundary, possibly with 1G pages
>  	 */
> -	while (boot_cpu_has(X86_FEATURE_GBPAGES) && end - start >=3D PUD_SIZE) {
> +	while (CONFIG_PGTABLE_LEVELS > 3 && boot_cpu_has(X86_FEATURE_GBPAGES) &&
> +	       end - start >=3D PUD_SIZE) {
>  		set_pud(pud, pud_mkhuge(pfn_pud(cpa->pfn,
>  				   canon_pgprot(pud_pgprot))));
> =20

[Severity: High]
This is a pre-existing issue, but further down in populate_pud() under the
"Map trailing leftover" section, does the error handler silently mask
allocation failures?

arch/x86/mm/pat/set_memory.c:populate_pud() {
    ...
		tmp =3D populate_pmd(cpa, start, end, cpa->numpages - cur_pages,
				   pud, pgprot);
		if (tmp < 0)
			return cur_pages;
    ...
}

If populate_pmd() fails (e.g., due to OOM) while mapping trailing leftovers,
it returns a negative error code in tmp. Returning cur_pages (which can be =
0)
instead of the error code causes populate_pgd() to assume success.

This skips unmap_pud_range() cleanup, and returns 0 to __change_page_attr().
The top-level __change_page_attr_set_clr() loop updates cpa->numpages =3D 0
and hits BUG_ON(!cpa->numpages), causing a kernel panic.

Should this return tmp instead to properly propagate the error code?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722-dummy_ptxp=
3-v2-0-d9e4bad31e0a@arm.com?part=3D14
