Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E4A435AAF
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 12:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788351554; cv=none; b=KI0+LP4vZhZwA7a2lA6/1AYCXpVkl6NkE3DyJw1YFrm8cPCmuIP34V+lzedqmpjLyxA3q4n3Ah+OyWmjvLLXV+VJz4sxA1xtCQlxahJVmbgot7cO6907pmja+IMpuZuU+xydrHOw4gD+gqRIkVTNp6Hl6ro732pKf33MRW0XDSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788351554; c=relaxed/simple;
	bh=5XCVgWVF/NGmnQtnsuAuGdalf6vNzbCRBCX+3LvZhi4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pufI6OTrudc/wvqSN5y+8F+pu2hEiZgg5VfCxevMOutbUAvzjsmfXSZqDpajSsPcWke2QB2yiEtNBgKl0Fx7sk4vecY0aSMFQMCphQLmXyorLbLbSyB+0mmE4DSJ5/SdggAlXNN9Zoal7jkYyjQ6YhWJGy13FkyXL85Ugz5ARAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNeUnB3R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNeUnB3R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9161F000E9;
	Wed,  2 Sep 2026 12:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788351553;
	bh=Z4Hp01+hxbZvSRi/PMuGRqb1subdJPl1RsNBI8Jzb6U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CNeUnB3RNaAKZsW1lobR/8qeb70W7BhXPrmCD3xIP8NQ5G4lkiC1MlOtm03Ixm27A
	 p9D7jASItY1Oe1lzAfBIaa3clO8WL2FjY7Y95h/G4FCFFbBmO8OfGRuxJcrLjAywEc
	 2DSk/rVTwb4tUYxPw/pybJTvMqxzHq5fufLMV7GlbEmfMEmLW+90F4GgDqxrd94IDG
	 kj5zp2snR7kwDry5tBYYqIk4H5BjLqAj53e3VXeU1xSSiYl46hH68E/nMZeclD6p3y
	 9+fPdSTt169sU5KGAQ9eMsWAUifdXkLAaBqBhz6L+3h0ezX7ji8+nC2N/+Ym4yVsIA
	 88svByEZ9anlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 09/21] loongarch: kvm: remove stack copy address
 of pXd in pXd_offset()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yeoreum Yun" <yeoreum.yun@arm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260902-dummy_ptxp3-v3-9-5d8f5b17c25c@arm.com>
References: <20260902-dummy_ptxp3-v3-0-5d8f5b17c25c@arm.com>
 <20260902-dummy_ptxp3-v3-9-5d8f5b17c25c@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 12:19:12 +0000
Message-Id: <20260902121912.CF9161F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `pud_leaf()` / huge page check before traversing to PMD le=
vel, causing invalid memory dereference on 1GB huge pages.
--

commit 7df2ea4ead6f791e1840ca23d67765ca06e93e1b
Author: Yeoreum Yun <yeoreum.yun@arm.com>

loongarch: kvm: remove stack copy address of pXd in pXd_offset()

This commit refactors host_pfn_mapping_level() to prepare for generic
compile-time folded page tables. It replaces direct uses of stack-based pXd
values with pXd_offset_lockless(), passing the pointers directly.

> diff --git a/arch/loongarch/kvm/mmu.c b/arch/loongarch/kvm/mmu.c
> index e104897aa5328..837b40bb694f4 100644
> --- a/arch/loongarch/kvm/mmu.c
> +++ b/arch/loongarch/kvm/mmu.c
[ ... ]
> @@ -698,19 +698,23 @@ static int host_pfn_mapping_level(struct kvm *kvm, =
gfn_t gfn,
[ ... ]
> -	pud =3D pudp_get(pud_offset(&p4d, hva));
> +	pudp =3D pud_offset_lockless(p4dp, p4d, hva);
> +	pud =3D pudp_get(pudp);
>  	if (pud_none(pud) || !pud_present(pud))
>  		goto out;
> =20
> -	pmd =3D pmdp_get(pmd_offset(&pud, hva));
> +	pmdp =3D pmd_offset_lockless(pudp, pud, hva);
> +	pmd =3D pmdp_get(pmdp);

[Severity: High]
This is a pre-existing issue, but does this code need a check to see if the
PUD is a leaf entry before stepping down to the PMD level?

In arch/loongarch/kvm/mmu.c:host_pfn_mapping_level(), the code reads the PUD
entry and verifies that it is present, but it does not check if it is a 1GB
huge page leaf entry before traversing to the PMD level.

If a guest memory region is backed by a 1GB huge page on the host, the PUD
entry will contain a PFN-encoded value and metadata flags. By unconditional=
ly
passing this to pmd_offset_lockless(), the macro may interpret the PFN enco=
ded
value as a kernel virtual address directory pointer. This produces a bogus
pointer that pmdp_get() will then dereference, causing an invalid memory
dereference and potentially crashing the host.

Could a pud_leaf() or kvm_pte_huge(pud_val(pud)) check be added before the
pmd_offset_lockless() call to prevent this crash when 1GB huge pages are
used?

>  	if (pmd_none(pmd) || !pmd_present(pmd))
>  		goto out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902-dummy_ptxp=
3-v3-0-5d8f5b17c25c@arm.com?part=3D9
