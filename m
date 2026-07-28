Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C35837F00D
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 16:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785256316; cv=none; b=ijvkLoTKR4ipwNBSpS/JuwGzFh64/FL98UC7/RCHb5AYQex4RLrl71sAR7RLbuqH+POeezGPJsXHh3jjUHG/kjD47Zx4kCCLUQUpH4SQJvq98/0+mOz7c/EvCKZ5HkL3RgwQNPEfopxZqbC7esQ0E2c2tGRbkYP0EzAGv9AJTyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785256316; c=relaxed/simple;
	bh=TkH9DMniWm3L0eihT/i9mXKlDHlyAlZywr07pJwbPW0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DIMl38b7vILUwxnSr0SlCwx8Va6kDV4FlO6iwMEKv9OMt8JAYS5NTfL4VSDQReaDXPatzM0bMPJRqdHbAlni3nWx9O1S7TG3Z7XM+2tZwuTiv+aADR5+iov9oqYdPv6nJgTLOQ5zDcUYvRz2sHzLtU1zjDTsC6hizcn/EL9cbDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQNqpbHD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQNqpbHD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD1351F000E9;
	Tue, 28 Jul 2026 16:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785256314;
	bh=gu2o+pNogXsJ4XtjW9zSPBat4H5sjNfVJNd7+foImvs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NQNqpbHD8XfNedqUAdJpZt60SBo9IFQAPsIlzjxCT+sQDL7zAOM9k4UXD1DZtK8pp
	 6JutSX6ZNZbpqc8xigAq4CLfyEjLQ5CKHRlxzedeEQtiG6DbDttMn/1slvI8ODblvl
	 sNetPJ+M0H/wBKsqXftXGN1sS+Us6khC4NpoZiidbZxunhHYXmZev4Mox7nJv7jmXR
	 8UPJKr0ls2UShoPnWfEqYYNumNgbmOGp/5HF3jnfzSfF3JRtq7cVHY9F/yr7A+uZLj
	 grIbZPxYNTpWOH2cCyVLloZurj6kYFx2vIhTEIZlMVNah3XrcWcrTYAJh91tveThr2
	 lerTvrSOeM3XQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] riscv: ptdump: Use per-level attribute bits for
 parsing
Reply-To: sashiko-reviews@lists.linux.dev
To: Dylan.Wu <fredwudi0305@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260728161449.190058-3-fredwudi0305@gmail.com>
References: <3bb2f519-c70b-6c35-c404-6fbfe8adbeb1@kernel.org>
 <20260728161449.190058-1-fredwudi0305@gmail.com>
 <20260728161449.190058-3-fredwudi0305@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 16:31:54 +0000
Message-Id: <20260728163154.AD1351F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incomplete transition to per-instance and per-level page table a=
ttributes in ptdump. The commit introduces a `pg_level` pointer in `struct =
ptdump_pg_state` to allow different callers (like future KVM gstage code) t=
o use their own attribute arrays. However, while `dump_prot()` uses this po=
inter, `note_page()` and `dump_addr()` still hardcode the global `kernel_pg=
_levels` array. Additionally, `ptdump_init()` hardcodes `pte_bits` when cal=
culating masks instead of using the newly added per-level `bits` and `num` =
fields.
--

--- Patch [2]: [PATCH v3 2/3] riscv: ptdump: Use per-level attribute bits f=
or parsing ---
commit 306ba7e65dcddd613da201b658930774a642dd75
Author: Dylan.Wu <fredwudi0305@gmail.com>

riscv: ptdump: Use per-level attribute bits for parsing

This commit renames ptdump structures and adds a pg_level pointer to
ptdump_pg_state. This allows different callers (like future KVM gstage code)
to define and use their own page table attributes rather than relying on a
global array.

> diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
> index d9a955b8a532d..c67fbbf5ff624 100644
> --- a/arch/riscv/mm/ptdump.c
> +++ b/arch/riscv/mm/ptdump.c
[ ... ]
> @@ -221,10 +233,10 @@ static void dump_addr(struct pg_state *st, unsigned=
 long addr)
>  	}
> =20
>  	pt_dump_seq_printf(st->seq, "%9lu%c %s", delta, *unit,
> -			   pg_level[st->level].name);
> +			   kernel_pg_levels[st->level].name);

[Severity: Medium]
Will this print incorrect level names if a caller provides a custom
pg_level array? If the goal is to allow per-instance attribute arrays,
should this use st->pg_level[st->level].name instead of the global
kernel_pg_levels array?

[ ... ]
> @@ -242,12 +254,12 @@ static void note_prot_wx(struct pg_state *st, unsig=
ned long addr)
>  void note_page(struct ptdump_state *pt_st, unsigned long addr,
>  	      int level, u64 val)
>  {
> -	struct pg_state *st =3D container_of(pt_st, struct pg_state, ptdump);
> +	struct ptdump_pg_state *st =3D container_of(pt_st, struct ptdump_pg_sta=
te, ptdump);
>  	u64 pa =3D PFN_PHYS(pte_pfn(__pte(val)));
>  	u64 prot =3D 0;
> =20
>  	if (level >=3D 0)
> -		prot =3D val & pg_level[level].mask;
> +		prot =3D val & kernel_pg_levels[level].mask;

[Severity: Medium]
Does this bypass the custom attributes provided by the caller?

Using the hardcoded kernel_pg_levels array here will mask the PTE values
with the global mask, rather than using st->pg_level[level].mask from the
ptdump_pg_state instance.

[ ... ]
> @@ -410,12 +424,12 @@ static int __init ptdump_init(void)
> =20
>  	kernel_ptd_info.base_addr =3D KERN_VIRT_START;
> =20
> -	pg_level[1].name =3D pgtable_l5_enabled ? "P4D" : "PGD";
> -	pg_level[2].name =3D pgtable_l4_enabled ? "PUD" : "PGD";
> +	kernel_pg_levels[1].name =3D pgtable_l5_enabled ? "P4D" : "PGD";
> +	kernel_pg_levels[2].name =3D pgtable_l4_enabled ? "PUD" : "PGD";
> =20
> -	for (i =3D 0; i < ARRAY_SIZE(pg_level); i++)
> +	for (i =3D 0; i < ARRAY_SIZE(kernel_pg_levels); i++)
>  		for (j =3D 0; j < ARRAY_SIZE(pte_bits); j++)
> -			pg_level[i].mask |=3D pte_bits[j].mask;
> +			kernel_pg_levels[i].mask |=3D pte_bits[j].mask;

[Severity: Medium]
Since kernel_pg_levels[i] now contains its own .bits and .num fields,
should this initialization loop iterate over kernel_pg_levels[i].bits
up to kernel_pg_levels[i].num instead of hardcoding the global pte_bits
array?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728161449.1900=
58-1-fredwudi0305@gmail.com?part=3D2
