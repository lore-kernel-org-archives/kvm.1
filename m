Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471FF38DF9
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 12:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785156352; cv=none; b=KCm2hYp+SFmwOeJOKfGxYTVTwXhUi+i4YyHi2pPq0BqGTcWpWNdLrnPqXZnMNIwmyZ6u9AFpKwOJlDA73v6Ljz0KHoPpBNFL4pc3D0gF+ntoTpHyf+HTyNYTFjw58toKPx4utd2psG7EHcuILVEHNVZP3zurn9w2WPoAf3dOLKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785156352; c=relaxed/simple;
	bh=O/orxb3ezxEVaSksPQIYGs89gQlH3GAeQV5N4mFrxCU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FpytK8IOGtoWLq7hcqE69xQpXjZl1zm8NdX8EK4ajkOWnM92DWa/KrEZ/4+RduThHo9oDPE0A7y63HCo2g1Bz92g7xuzUSNl86MOghToCNPwqcka+IW97tPDjRZPlKshqRlBITXOp/YKiWj0MPVPcav2CXmIVa6R4+AUc2DO9PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axWMN4Uz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axWMN4Uz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D821F000E9;
	Mon, 27 Jul 2026 12:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785156351;
	bh=MjLVbFUO/TYVN8W8XaYHl3BhTmh+t9zHsP49jBSl8BY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=axWMN4UzssoQG3fq14dcEvuR4vFue0ygExWlwnokVTZDMb3Eo9oeRPI31/dwOUXVQ
	 blUSnAoJvUIkJPLVkFCLmrpCFTK2DCPY4pOIyCg/+WDpUczVcDRNF8L756sg/zOpAU
	 eChrHkPHcfjZuqrs3pQIkV0sGUaHcoB5ZOVkAwM6W7uHWDbSzP7bq2Lqosk+wHcN8O
	 lHe9Ql2Ss097PrZdz6Z0XZKK4gEKTofJmuB/FThAeeG3sbJxN4t/7Eda+ik+UjXV/l
	 tHLx7IxRoh3+NcWSSecBJru7TGa0yzV6ltvIurdZFeDXkTqkLiMM/gvj0RD8xPrL63
	 +hFBxp0NdR+kA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] riscv: ptdump: Use per-level attribute bits for
 parsing
Reply-To: sashiko-reviews@lists.linux.dev
To: Dylan.Wu <fredwudi0305@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260727123013.118984-3-fredwudi0305@gmail.com>
References: <20260727123013.118984-1-fredwudi0305@gmail.com>
 <20260727123013.118984-3-fredwudi0305@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 12:45:50 +0000
Message-Id: <20260727124550.E8D821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The refactoring is incomplete because `note_page()` and `dump_ad=
dr()` still hardcode `kernel_pg_levels` instead of using the caller-provide=
d `st->pg_level` array.
- [Medium] The `dump_prot()` function retains hardcoded, architecture-speci=
fic logic for specific bitmasks, which is unsafe when processing generic, c=
aller-provided bit arrays.
--

--- Patch [2]: [PATCH v2 2/3] riscv: ptdump: Use per-level attribute bits f=
or parsing ---
commit 1ffa1d459c45da98aa9b8ff61631b9ce3dc228c8
Author: Dylan.Wu <fredwudi0305@gmail.com>

riscv: ptdump: Use per-level attribute bits for parsing

This commit updates the RISC-V page table dumper to use per-level attribute
bits and names passed via the ptdump_pg_state structure. This refactoring is
intended to allow future users, such as KVM, to provide their own protection
bits for parsing.

> diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
> --- a/arch/riscv/mm/ptdump.c
> +++ b/arch/riscv/mm/ptdump.c
> @@ -176,21 +188,21 @@ static void dump_prot(struct ptdump_pg_state *st)
> =20
>  		val =3D st->current_prot & bits[i].mask;
>  		if (val) {
> -			if (pte_bits[i].mask =3D=3D _PAGE_SOFT)
> -				snprintf(s, sizeof(s), pte_bits[i].set, val >> 8);
> +			if (bits[i].mask =3D=3D _PAGE_SOFT)
> +				snprintf(s, sizeof(s), bits[i].set, val >> 8);

[Severity: Medium]
Since the goal of this patch is to support custom caller-provided bit array=
s,
is it safe to retain these hardcoded checks for _PAGE_SOFT (and
_PAGE_MTMASK_SVPBMT below)?

If a future caller (like KVM) provides a custom bitmask that happens to mat=
ch
the value of _PAGE_SOFT, but provides a format string in bits[i].set that
doesn't expect an integer, could this snprintf() cause a crash or output
garbage?

[ ... ]

> @@ -221,7 +233,7 @@ static void dump_addr(struct ptdump_pg_state *st, uns=
igned long addr)
>  	}
> =20
>  	pt_dump_seq_printf(st->seq, "%9lu%c %s", delta, *unit,
> -			   pg_level[st->level].name);
> +			   kernel_pg_levels[st->level].name);
>  }

[Severity: Medium]
Will this ignore the caller's custom level names?

It looks like dump_addr() was updated to hardcode kernel_pg_levels instead
of using the caller-provided st->pg_level[st->level].name.

[ ... ]

> @@ -247,7 +259,7 @@ void note_page(struct ptdump_state *pt_st, unsigned l=
ong addr,
>  	u64 prot =3D 0;
> =20
>  	if (level >=3D 0)
> -		prot =3D val & pg_level[level].mask;
> +		prot =3D val & kernel_pg_levels[level].mask;

[Severity: Medium]
Similar to the issue in dump_addr(), will this ignore the custom bitmasks
provided by the caller?

By hardcoding kernel_pg_levels[level].mask instead of using
st->pg_level[level].mask, it seems this would cause incorrect page table
attribute masking for custom callers.

Additionally, could this cause an out-of-bounds array read if a custom call=
er
uses more levels than the 5 defined in kernel_pg_levels?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727123013.1189=
84-1-fredwudi0305@gmail.com?part=3D2
