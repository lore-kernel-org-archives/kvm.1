Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ADC350A35
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 04:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782101901; cv=none; b=RI7XzRnnJGGvy7hs5mDM07NTGKFcQtxtnIghmIF6477R8uXGXBfSHwE2sqpGQYQAbuYXItN/1d6v/biz32r0NAgar/zJ1Ncf+OrbVHwQ8kJFmp61U9tiA99fjgnjrZMLBevY3ZYbiZJ7SP4XH74u0pGAMdjA4R8DczjqkHVMASA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782101901; c=relaxed/simple;
	bh=qfg0eMpKjbMWXKw8DQTuf8zm64vt9yDB4stKnRpknJY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q93LZ0OPp5unoXq51jO7GpwKhG7zE50qqy/PRINuGu5DYAHinvWbJvwy/021HXN33333p64Oj0vxSCLxsv0hxDiMuy2vNxHedPBo5vJxUb1ZQVtxoIurlUWkNLwx4pUgGew7/pe9dpp9U2cyOYj8W+GJ56ZUC3HUxNTAqMzzYsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWxkmRjC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWxkmRjC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0131F000E9;
	Mon, 22 Jun 2026 04:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782101899;
	bh=f3DS63rlLr/9rIbeVEXdC+zShNGc6Gf2g0EYmVIe5pY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jWxkmRjC3YHA5DOrz/yBfK0ZVLoMfGsG1yc5AaCZyfKyKp8dAGZdTrVgL/oziNun5
	 pfRKUEV0un8LRPtbHe6xH5u1Qunzi3mdoA7ex4GdMsEJWKyI0K2rIihjf513iSYaz/
	 FB6qvWL2mE7EjLorRivsIZxYtYzPQvv2t8F46H6OsZIWrmiSzIQlO+WeTY/LoIdsfP
	 iNuvF88N/HQlUp78yfwsFZTUcFWIjuhFKRXxmC4msstThUxa/Mxb27t2r1c6JDZCCw
	 LuQpvlXPWGb0AhrRzwODU/GI3Sh8hzaL3fNIb5tubHBuvb8J4xOAyuzHO/NvIvjYaf
	 CJsPg2WqQQyQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/16] riscv: Use generated instruction headers for
 misaligned loads/stores
Reply-To: sashiko-reviews@lists.linux.dev
To: "Charlie Jenkins via B4 Relay" <devnull+thecharlesjenkins.gmail.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260621-riscv_insn_table-v2-7-7f0810ee2274@gmail.com>
References: <20260621-riscv_insn_table-v2-0-7f0810ee2274@gmail.com>
 <20260621-riscv_insn_table-v2-7-7f0810ee2274@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 04:18:19 +0000
Message-Id: <20260622041819.9F0131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

New issues:
- [Critical] Missing arithmetic right shift and sign-extension in emulated =
scalar misaligned loads corrupts returned data.
- [Critical] Missing +8 register index offset for compressed C-extension st=
ore instructions reads from incorrect registers.
- [High] Removal of CONFIG_64BIT guards causes overlapping RV32 floating-po=
int and RV64 integer compressed instructions to be incorrectly decoded.
- [High] Instruction pointer (`regs->epc`) is left as 0 on unhandled store =
instructions.
- [Medium] Missing validation for reserved encodings in compressed SP-relat=
ive loads allows reserved instructions to be emulated.

Pre-existing issues:
- [High] Emulating misaligned stores with the zero register (x0) leaks the =
instruction pointer (epc) to memory.
- [High] Instruction pointer (`regs->epc`) is not restored when user memory=
 copy fails.
--

commit ebbff49ec30db1d18deced4c1343cfcdd49aef84
Author: Charlie Jenkins <thecharlesjenkins@gmail.com>

riscv: Use generated instruction headers for misaligned loads/stores

This commit migrates the misaligned loads/store code to use the generated
instruction headers instead of the hand-written instruction composition
functions.

> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/tra=
ps_misaligned.c
> index 81b7682e6c6db..4d2a2432e0c45 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
[ ... ]
> @@ -240,68 +219,71 @@ static int handle_scalar_misaligned_load(struct pt_=
regs *regs)
> =20
>  	regs->epc =3D 0;
> =20
> -	if ((insn & INSN_MASK_LW) =3D=3D INSN_MATCH_LW) {
> +	if (riscv_insn_is_lw(insn)) {
>  		len =3D 4;
[ ... ]
> -#if defined(CONFIG_64BIT)
> -	} else if ((insn & INSN_MASK_LD) =3D=3D INSN_MATCH_LD) {
> +		rd =3D riscv_insn_lw_extract_xd(insn);
> +	} else if (riscv_insn_is_ld(insn)) {
>  		len =3D 8;
[ ... ]
> -	} else if ((insn & INSN_MASK_C_LD) =3D=3D INSN_MATCH_C_LD) {
> +		rd =3D riscv_insn_lhu_extract_xd(insn);
> +	} else if (riscv_insn_is_c_ld(insn)) {
>  		len =3D 8;
>  		shift =3D 8 * (sizeof(unsigned long) - len);
> -		insn =3D RVC_RS2S(insn) << SH_RD;

[Severity: High]
Could this incorrectly decode a compressed floating point instruction as an
integer load on 32-bit systems? Since RV64 compressed integer instructions
and RV32 compressed floating-point instructions share the same encoding
bitmasks, removing the bitness guards and checking for RV64 instructions
first might result in a negative shift amount in
handle_scalar_misaligned_load(), leading to an invalid memory read.

> -	} else if ((insn & INSN_MASK_C_LDSP) =3D=3D INSN_MATCH_C_LDSP &&
> -		   ((insn >> SH_RD) & 0x1f)) {
> +	} else if (riscv_insn_is_c_ldsp(insn)) {
>  		len =3D 8;
>  		shift =3D 8 * (sizeof(unsigned long) - len);
> -#endif
> -	} else if ((insn & INSN_MASK_C_LW) =3D=3D INSN_MATCH_C_LW) {
> +		rd =3D riscv_insn_c_ldsp_extract_xd(insn);

[Severity: Medium]
Does this bypass validation for reserved encodings? The specification
dictates that compressed SP-relative loads must have a non-zero destination
register. The previous code enforced this, but the new branch seems to allow
processing reserved instructions as valid loads if the destination register
is zero.

[ ... ]
> @@ -319,11 +301,11 @@ static int handle_scalar_misaligned_load(struct pt_=
regs *regs)
>  	}
> =20
>  	if (!fp)
> -		SET_RD(insn, regs, (long)(val.data_ulong << shift) >> shift);
> +		*(unsigned long *)((unsigned long *)regs + rd) =3D val.data_ulong << s=
hift;

[Severity: Critical]
Does this code miss an arithmetic right shift? For loads smaller than the
native register width in handle_scalar_misaligned_load(), left-shifting the
loaded data into the most significant bits of the register without
arithmetically right-shifting it back leaves the lower bits zeroed out and
fails to sign-extend the value.

[ ... ]
> @@ -351,67 +333,68 @@ static int handle_scalar_misaligned_store(struct pt=
_regs *regs)
> =20
>  	regs->epc =3D 0;
> =20
> -	val.data_ulong =3D GET_RS2(insn, regs);
> -
> -	if ((insn & INSN_MASK_SW) =3D=3D INSN_MATCH_SW) {
> +	if (riscv_insn_is_sw(insn)) {
>  		len =3D 4;
[ ... ]
> -#if defined(CONFIG_64BIT)
> -	} else if ((insn & INSN_MASK_C_SD) =3D=3D INSN_MATCH_C_SD) {
> +		rd =3D riscv_insn_sh_extract_xs2(insn);
> +	} else if (riscv_insn_is_c_sd(insn)) {
>  		len =3D 8;
> -		val.data_ulong =3D GET_RS2S(insn, regs);
> -	} else if ((insn & INSN_MASK_C_SDSP) =3D=3D INSN_MATCH_C_SDSP) {
> +		rd =3D riscv_insn_c_sd_extract_xs2(insn);

[Severity: Critical]
Could this read from the wrong registers? The load handler adds the required
offset of 8 for compressed instructions, but it appears missing here in
handle_scalar_misaligned_store() for all compressed stores.

[ ... ]
> -	} else if ((insn & INSN_MASK_C_SH) =3D=3D INSN_MATCH_C_SH) {
> +	} else if (riscv_insn_is_c_sh(insn)) {
>  		len =3D 2;
> -		val.data_ulong =3D GET_RS2S(insn, regs);
> +		rd =3D riscv_insn_c_sh_extract_xs2(insn);
>  	} else {
> -		regs->epc =3D epc;
>  		return -1;
>  	}

[Severity: High]
Is it intentional to return without restoring regs->epc here? Since regs->e=
pc
is temporarily set to 0 during instruction evaluation, returning -1 without
restoring it might cause the task's instruction pointer in the signal conte=
xt
to be incorrectly reported as 0 when a SIGBUS is delivered.

>  	if (!IS_ENABLED(CONFIG_FPU) && fp)
>  		return -EOPNOTSUPP;
> =20
> +	if (!fp)
> +		val.data_ulong =3D *(unsigned long *)((unsigned long *)regs + rd);

[Severity: High]
This isn't a bug introduced by this patch, but does this leak the instructi=
on
pointer to memory? When a misaligned store uses the hardwired zero register,
the extracted register index is 0. Since struct pt_regs stores the epc at
index 0, the emulator writes the epc value to memory instead of 0.

Also, due to the missing offset for compressed stores mentioned earlier,
reading without the offset might cause the handler to read from kernel state
pointers like epc in pt_regs instead of the correct user registers.

[ ... ]

[Severity: High]
This is a pre-existing issue, but should we restore regs->epc when the user
memory copy fails?

In handle_scalar_misaligned_load() and handle_scalar_misaligned_store():

    if (user_mode(regs)) {
            if (copy_from_user(&val, (u8 __user *)addr, len))
                    return -1;
    }

Returning -1 on memory copy failure while regs->epc is still set to 0 breaks
user-space signal handlers because the program counter in the signal context
will be 0.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621-riscv_insn=
_table-v2-0-7f0810ee2274@gmail.com?part=3D7
