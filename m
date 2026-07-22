Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1D941D10C
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 16:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784736910; cv=none; b=cEpQL4d9vldsupyreT0iuUm5sQm8tUj8p/xCcRNfNCX7Q0l5m/0+WhoAysulDW/uMdxMTvtcbau3KxYObZaXsNrnRZ3Vc6WAYlL5eskJxfD1uRYPTr2f/aBdetF1JCtUxL5F+0Du8TZunApr+ON1SkhXhAastz3XACSyO1a7pmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784736910; c=relaxed/simple;
	bh=HbL4MANnoR6zkdDHzU8YC5Yekc7QvD/XC+zw+Y1Meqk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gPWSGzi8aBj0RM4qJL1lm382nHHKCgvi8WP0kd6hlGLHz6KgK3ujBASyZhuhehUdc0aoNI98Lnu8B7wkLpY1jKAY2myd2/J8W3gUP3eLACt/pTufE3mLUBcp6RRypDOqwzVKv3LAx4InkqlImjw3Lc4jYTPyCQcbQGJ0BN6JXzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nodk/dRJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nodk/dRJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC951F000E9;
	Wed, 22 Jul 2026 16:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784736909;
	bh=NLUiyY1M4oWEHOp40+NFKi3//LTgXwQdRnreJ7hNGko=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nodk/dRJeOjRWuayNsfI+KQP2pggDUG259RWuY+CwYuOku1H7xJjMQPXVknIHZ9g1
	 tzGHYnm7pNFlEgSzjQgjelvF7wnxAgvu7TnEXxXnMXoRoQ61rQQD73Sf1AG8ZZRg0k
	 03618jF2yKz6ljB7nZgaaaSMajevc7RF7VtsC05Uu1SLtdpUowizKvA7I84FmfsIm4
	 YEW8JJHT30ESAM6ftsETqNGt6QF6IBukEUq2lDXK1Mhwqg7gm+kD71aOU0JRsmhrNi
	 g9REQFUVqXg9dx+zLbTY6iAEZFYGYYuQd8Rmntqn+BFuoQ+Eo8NuA0tlj5grGOEeQZ
	 Jooc7YmZ1FvBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 15/20] mm/pgtable: optimize pmdp_get() and
 friends for folded pagetable levels
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yeoreum Yun" <yeoreum.yun@arm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260722-dummy_ptxp3-v2-15-d9e4bad31e0a@arm.com>
References: <20260722-dummy_ptxp3-v2-0-d9e4bad31e0a@arm.com>
 <20260722-dummy_ptxp3-v2-15-d9e4bad31e0a@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 16:15:09 +0000
Message-Id: <20260722161509.6CC951F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incorrect parameter name in the newly defined pgdp_get() function.
--

--- Patch [15]: [PATCH RFC v2 15/20] mm/pgtable: optimize pmdp_get() and fr=
iends for folded pagetable levels ---
commit 2c4b6d6a43469a09eb2dcdd35ef29b1bda716b3a
Author: David Hildenbrand (Arm) <david@kernel.org>

mm/pgtable: optimize pmdp_get() and friends for folded pagetable levels

This commit optimizes pmdp_get() and related functions for configurations
with folded page tables. It avoids unnecessary memory reads by returning a
dummy value instead of forcing the compiler to read unused data.

Link: https://lore.kernel.org/all/0019d675-ce3d-4a5c-89ed-f126c45145c9@kern=
el.org/

> diff --git a/include/asm-generic/pgtable-nop4d.h b/include/asm-generic/pg=
table-nop4d.h
> index 019c3f074b771..ab4a826b34048 100644
> --- a/include/asm-generic/pgtable-nop4d.h
> +++ b/include/asm-generic/pgtable-nop4d.h
> @@ -34,6 +34,14 @@ static inline bool pgd_leaf(pgd_t pgd)		{ return false=
; }
>   */
>  #define set_pgd(pgdptr, pgdval)	set_p4d((p4d_t *)(pgdptr), (p4d_t) { pgd=
val })
> =20
> +static inline pgd_t pgdp_get(pgd_t *p4dp)

[Severity: Low]
This isn't a bug, but should the parameter for pgdp_get() here be named pgdp
instead of p4dp?

> +{
> +	pgd_t dummy =3D { 0 };
> +
> +	return dummy;
> +}
> +#define pgdp_get pgdp_get

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722-dummy_ptxp=
3-v2-0-d9e4bad31e0a@arm.com?part=3D15
