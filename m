Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BF7274B3B
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 04:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783483266; cv=none; b=XVrlurT5tJJCb3T4MZusz8oWI4Iw52/+6+T+B4TEV28YvMv6CgovESiCK1Y4tCkgd9IrXniIU4YAbvdVC7iLyaUp6XQfrI6fnCbHBWeHCqrG3s0sz/Xr2XbX+E0ZaeuRnK2kCmhvgxEnGoPHWvAENd3q76Hy85kEe0oASSZtinQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783483266; c=relaxed/simple;
	bh=ayt+K2L3OzV4PH50t0Ru1xRh2vHW7YH2WXX5pEfiMs0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UEZGi/MXd2fsyR4IY61j81J9XYSbmoXUD6daZK0v1rXVbn/M1VdnoR9CHeHPglIIYScVKlGGVRbHaFOAt1TEebfOygJDUD6pFIzifdDL1wOh2s1HAqND4Ge5xC9qQJyckyPBduM+ltriMvDl+sTWCmscBYnFg6HtY6UN8kU5nW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g34Ffh+C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g34Ffh+C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97AE71F000E9;
	Wed,  8 Jul 2026 04:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783483264;
	bh=/N6kQOqJXTbKvt/iXT0zUSNQ20yTizNgUVO0Ipm2NyE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g34Ffh+CYUwXS5DSmMYQfBQ8R/qM/GVlEOml/FoiCdHZJhGNIfgOv/a1erbtq/ATa
	 iVZRaa5sihids55VN447/IfJldjyKOartV7z+zEkMs+bWK3d4FiakkRffl7+uI2JUu
	 ywxDZmavAky72EDOSq4mcFmPCPhWHxtXuZcdC9FsuOQ86tGLV4xSapwWhIZfLQGqIl
	 pdDc3sVnJntrK8qkVGI5UoI73Zd7sSZ+N/3eJkX7/2qfyzxgWq7rHcf8JSk+9NJZEw
	 sbqMiQvxC1Tp2z6oF1K+RAYQz9DkTDVp9WrILJ6fC6rygJqc400fvOZN23cKvczAX3
	 oK6HmEwM71xyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 16/17] riscv: kexec: Use generated instruction
 headers for kexec relocations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Charlie Jenkins" <thecharlesjenkins@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260707-riscv_insn_table-v3-16-3f8e5f75ba97@gmail.com>
References: <20260707-riscv_insn_table-v3-0-3f8e5f75ba97@gmail.com>
 <20260707-riscv_insn_table-v3-16-3f8e5f75ba97@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 04:01:03 +0000
Message-Id: <20260708040104.97AE71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unaligned memory accesses during instruction patching in kexec cou=
ld cause hardware traps on RISC-V.
--

--- Patch [16]: [PATCH v3 16/17] riscv: kexec: Use generated instruction he=
aders for kexec relocations ---
commit 8214fe744bbe604843e11511b3e732e4ee739dad
Author: Charlie Jenkins <thecharlesjenkins@gmail.com>

riscv: kexec: Use generated instruction headers for kexec relocations

This commit migrates the kexec relocation code to use the generated
instruction headers instead of the hand-written instruction composition
functions.

> diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/m=
achine_kexec_file.c
> index 54e2d9552e930..cad40e4afd867 100644
> --- a/arch/riscv/kernel/machine_kexec_file.c
> +++ b/arch/riscv/kernel/machine_kexec_file.c

[ ... ]

> @@ -197,12 +171,14 @@ int arch_kexec_apply_relocations_add(struct purgato=
ry_info *pi,
> =20
>  		switch (r_type) {
>  		case R_RISCV_BRANCH:
> -			*(u32 *)loc =3D CLEAN_IMM(BTYPE, *(u32 *)loc) |
> -				 ENCODE_BTYPE_IMM(val - addr);
> +			/*
> +			 * For simplicity, use beq as represenative of all
> +			 * branches (they all have the same imm encoding)
> +			 */
> +			riscv_insn_beq_insert_imm((u32 *)loc, val - addr);

[Severity: High]
This is a pre-existing issue, but does casting loc to a u32 pointer here
trigger unaligned memory access traps on strict-alignment hardware?

If the purgatory ELF contains 32-bit instructions aligned on a 2-byte
boundary, which happens frequently due to the RISC-V Compressed extension,
passing this pointer to a function that performs a direct 32-bit
read-modify-write operation could cause a kernel panic during kexec.

>  			break;
>  		case R_RISCV_JAL:
> -			*(u32 *)loc =3D CLEAN_IMM(JTYPE, *(u32 *)loc) |
> -				 ENCODE_JTYPE_IMM(val - addr);
> +			riscv_insn_jal_insert_imm((u32 *)loc, val  - addr);

[Severity: High]
This is also a pre-existing issue, but could this direct u32 pointer cast
cause similar unaligned memory access traps if the location is 2-byte
aligned?

>  			break;

[ ... ]

>  		case R_RISCV_PCREL_HI20:
>  		case R_RISCV_CALL_PLT:
>  		case R_RISCV_CALL:
> -			*(u64 *)loc =3D CLEAN_IMM(UITYPE, *(u64 *)loc) |
> -				 ENCODE_UJTYPE_IMM(val - addr);
> +			riscv_insn_auipc_insert_imm((u32 *)loc, RISCV_CONST_HIGH_PART(val - a=
ddr));
> +			riscv_insn_jalr_insert_imm((u32 *)loc + 1,
> +						   RISCV_CONST_LOW_PART(val - addr));
>  			break;

[Severity: High]
This is a pre-existing issue, but would accessing loc and loc + 1 as u32
pointers lead to unaligned access faults in arch_kexec_apply_relocations_add
if the base instruction is misaligned?

The kernel module loader avoids this problem by correctly using 16-bit acce=
ss
pairs, such as riscv_insn_rmw, for instruction patching.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-riscv_insn=
_table-v3-0-3f8e5f75ba97@gmail.com?part=3D16
