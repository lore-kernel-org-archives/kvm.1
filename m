Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C67835F170
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 16:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784736475; cv=none; b=QwGsv/FuPN8OJRP434ATbPQwddM3NZA90WaK4gjVrxliWX+EU6t1ZO0pIZL31D7vo95AVRNJjplbk7hOyo3KYNyOoweZL6COJa80qkNaNcfqRYblR2ATS+sZWgUt+DbftsgbUsO+x117G8hH2kQjyY9eNh/HJvzaUGpcPPxvBpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784736475; c=relaxed/simple;
	bh=HJvF7DCOoLeBNfnawcyvH0Ph5NxphGu+oiD83IlNoTQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dQXnGf6Kcwv75cHcgjj8Gcl+2d9J8MmzIU7wIPVYAmFE+ht40e60FXmh4UMlJ4KTZKPw5tvVux275E2BahjFj/f74C9WUjw/r6lwMoula1A+ARVPWMEvJ2/Mkyy9X+kovETbdQOTh38r+VZeCL16JAzfoXWjhXPI6H4MxTl7Vco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9ARZHAc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9ARZHAc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48291F000E9;
	Wed, 22 Jul 2026 16:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784736473;
	bh=3tSZMq1TQvE3tHOAqwxcUgNMKUGcfZ8SxsFp8bpRA5M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c9ARZHAcvWmGXA4HGwyCT1C4XGGSL5doISDJiDDrmysbAee6T+C35/s/ER/wKD6bf
	 IPT5ZtbDxc6qWwD5Y1lQoWBW8RFBTeyk5QvPZJIGS0sSLAP55r9hQKip+BNhtkVsYP
	 gzkPPa8Fo4wuL7kprz/HOwAVeBX3seTGnzOjFVGeLShGNg/M+vjzW+LXy2TK4iifps
	 YWsYwlhyWcxxDDyPoTKJYXz3aVgh7p01L2PG/u/Q1tISar2j/BPg8j9uCrjw862MCD
	 peNnOrm8O+wTXxgGtY7s1MzxhiZNWS/gQd2DK1TwzwFgCyKirSrInCYmb9nKVKApyf
	 vPBky/jgMKc3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 13/20] x86: mm: carve out the generic
 compile-time folded pgtable case in effective_prot()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yeoreum Yun" <yeoreum.yun@arm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260722-dummy_ptxp3-v2-13-d9e4bad31e0a@arm.com>
References: <20260722-dummy_ptxp3-v2-0-d9e4bad31e0a@arm.com>
 <20260722-dummy_ptxp3-v2-13-d9e4bad31e0a@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 16:07:53 +0000
Message-Id: <20260722160753.C48291F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] `effective_prot()` incorrectly stores dummy values from folded pag=
e table entries instead of ignoring them, breaking protection inheritance a=
nd silently disabling W+X security checks.
--

--- Patch [13]: [PATCH RFC v2 13/20] x86: mm: carve out the generic compile=
-time folded pgtable case in effective_prot() ---
commit 11eb6cce58717a2c22f41583089bb3b0105af585
Author: David Hildenbrand (Arm) <david@kernel.org>

x86: mm: carve out the generic compile-time folded pgtable case in effectiv=
e_prot()

This commit introduces ptdump_pt_level_first() to identify the first
real page-table level for compile-time folded page tables. It modifies
effective_prot() to skip updating higher_prot for folded or top-level
entries, aiming to ignore dummy values from folded page table levels.

> diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
> index 2afa7a23340e9..4e545988953a0 100644
> --- a/arch/x86/mm/dump_pagetables.c
> +++ b/arch/x86/mm/dump_pagetables.c
[ ... ]
> @@ -254,7 +255,7 @@ static void effective_prot(struct ptdump_state *pt_st=
, int level, u64 val)
>  	pgprotval_t prot =3D val & PTE_FLAGS_MASK;
>  	pgprotval_t effective;
> =20
> -	if (level > 0) {
> +	if (level > st->first_level) {
>  		pgprotval_t higher_prot =3D st->prot_levels[level - 1];
> =20
>  		effective =3D (higher_prot & prot & (_PAGE_USER | _PAGE_RW)) |

[Severity: High]
When dealing with a folded level (where level <=3D st->first_level), the co=
de
falls through to the else branch (effective =3D prot). Since folded levels =
use
a dummy value, prot lacks _PAGE_RW.

When the walker reaches the first real intermediate level, higher_prot reads
this dummy value from st->prot_levels[level - 1]. Since it lacks _PAGE_RW,
won't the bitwise AND clear the _PAGE_RW bit for all subsequent levels?

Could this cause ptdump_check_wx() to evaluate all pages as read-only and
silently pass, hiding W+X security vulnerabilities?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722-dummy_ptxp=
3-v2-0-d9e4bad31e0a@arm.com?part=3D13
