Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369203644C5
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 09:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782896521; cv=none; b=kndgo+yfd4FbRIv2Uzfkl/M/CiM+V7mHSWLdC4rIwA2PEf1gV8e1ojlp6j0NORI7SZ0I120SASz1yDZBcdiZp4n/rDqaY+sY8h9YY2vp50cu6EZvlTiEdFLVjAjFs58uNcfD36/KyiMMwo6e2jBkVhIHCbosKA9Z8MLjS6sj3ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782896521; c=relaxed/simple;
	bh=tjvABtOy9UQFjgYlI/sfPc8RUJxBLIcfNPOGaS6JgKQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j3DyjqmQs2wtb6sEPiRxTiiUZu8vl/noWpB0F6krt8dyO7ESQYH/ETx125cOszt1RQJKv70BvzgaWOg9AZm7r9QqjAOciS+VFo8JZWIG24Vr6o+Ijz+OwbOVtjBSnE6/1BenXxld32HvsFuMk4Vr5JLqMdvp0uGWVJL+LY5NQK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/PXsK4d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/PXsK4d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966781F000E9;
	Wed,  1 Jul 2026 09:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782896519;
	bh=RFLOdTXs7daKOkcY53dIJYvJSRfDAyZpEsMrVnu5lvQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E/PXsK4diMvlOp4KCZWJ3XReXJfRO8B9cqUvauw3u6PdLGbvpPb++o92igQXnSaF7
	 FCny0b5nL/Se14U6sQQOio/a1qgypiefxDpA7CRPejgbY9QR9y/+9E7BXCQM/gWfuK
	 wRAbrhd3snS3Msvm/IZ+E1gwRbvY3Q/hwQBeRfS/booeLT9CFaPV+FHCNWmG6+/WVT
	 U6ukgcy066SpLDG1T03w6Z7DxlAjFTCCzwIaBTC0KKJ29T/Jy6DPiXCrOR7bfyJ7Kx
	 9C42/gPyx8+2DmN7zXSDoz+bsAEnqvgIcSK3FZwotf+s924SVLI2nZWmymHrTc0JDn
	 bNhgPZk7P8hBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] riscv: ptdump: Move pagetable definitions to common
 header
Reply-To: sashiko-reviews@lists.linux.dev
To: Dylan.Wu <fredwudi0305@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260701085030.124579-2-fredwudi0305@gmail.com>
References: <20260701085030.124579-1-fredwudi0305@gmail.com>
 <20260701085030.124579-2-fredwudi0305@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 09:01:59 +0000
Message-Id: <20260701090159.966781F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Uninitialized `bits` and `num` fields in `kernel_pg_levels` comp=
letely suppress page table attribute output in debugfs.
- [Low] Folded PMD levels on 32-bit RISC-V (RV32) will incorrectly display =
as 'PMD' instead of 'PGD'.
--

commit f96cd5eefaf170c680412811c0fe9c407b08f9a0
Author: Dylan.Wu <fredwudi0305@gmail.com>

riscv: ptdump: Move pagetable definitions to common header

Move the pagetable walking state and level definitions to a new
arch/riscv/include/asm/ptdump.h header to allow reuse of the attribute pars=
ing
logic. The attribute parsing logic in dump_prot() is updated to use attribu=
te
bits defined within the pg_level structure rather than a global array.

> diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
> index f4b4a9fcbbd88..7e55656cbbc92 100644
> --- a/arch/riscv/mm/ptdump.c
> +++ b/arch/riscv/mm/ptdump.c

[ ... ]

> @@ -183,52 +152,48 @@ static const struct prot_bits pte_bits[] =3D {
>  	}
>  };
> =20
> -/* Page Level */
> -struct pg_level {
> -	const char *name;
> -	u64 mask;
> -};
> -
> -static struct pg_level pg_level[] =3D {
> +static struct ptdump_pg_level kernel_pg_levels[] =3D {
>  	{ /* pgd */
>  		.name =3D "PGD",
>  	}, { /* p4d */
> -		.name =3D (CONFIG_PGTABLE_LEVELS > 4) ? "P4D" : "PGD",
> +		.name =3D "P4D",
>  	}, { /* pud */
> -		.name =3D (CONFIG_PGTABLE_LEVELS > 3) ? "PUD" : "PGD",
> +		.name =3D "PUD",
>  	}, { /* pmd */
> -		.name =3D (CONFIG_PGTABLE_LEVELS > 2) ? "PMD" : "PGD",
> +		.name =3D "PMD",

[Severity: Low]
For 32-bit RISC-V (RV32) architectures that use a 2-level page table where =
PMD
is folded into PGD, will this cause the top-level entries to incorrectly
display as PMD instead of PGD?

The original code dynamically renamed the PMD level to PGD based on
CONFIG_PGTABLE_LEVELS, but this appears to be omitted from the new code.

>  	}, { /* pte */
>  		.name =3D "PTE",
>  	},
>  };
> =20
> -static void dump_prot(struct pg_state *st)
> +static void dump_prot(struct ptdump_pg_state *st)
>  {
>  	unsigned int i;
> +	const struct ptdump_pg_level *lvl =3D &st->pg_level[st->level];
> +	const struct ptdump_prot_bits *bits =3D lvl->bits;
> =20
> -	for (i =3D 0; i < ARRAY_SIZE(pte_bits); i++) {
> +	for (i =3D 0; i < lvl->num; i++) {

[Severity: Medium]
Will this loop ever execute?

The kernel_pg_levels array is statically initialized without setting the .b=
its
or .num fields. Since .num is implicitly 0, it looks like this loop is enti=
rely
skipped, which will silently discard printing page table protection attribu=
tes
to debugfs.

[ ... ]

> @@ -446,12 +414,12 @@ static int __init ptdump_init(void)
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

Does this dynamic initialization loop need to populate the .bits and .num f=
ields
for kernel_pg_levels as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701085030.1245=
79-1-fredwudi0305@gmail.com?part=3D1
