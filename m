Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793101843;
	b=lXk0cmwzZkthSEvC4tD/fRp8cWtsapBOVS1rNrqdokcC3y5Jz/bz6+5eXpM79cvAaESI
	 0HfbgkOV9KunbZUn05j1s6AsIcVwvEU3ZtlSBse8HXDCvxVBBmnq4+6pVMeJqNxLp57lg
	 ZX/MFnFgSd6hvqHkDfWUdm08SQ+TBBmS+4h8ypZ0Q3EDsSjqHIQFfPV33uWAZXCiUAlsM
	 pagRXBXCu5v3kWpWrgnj9reP3jcFeG7fdsaEBf9L32Y6WNrBbea4RO1WUsq7saL0nISoF
	 C4aXriAwleWKS4kMyaXbUFBTpDnWE6nMpfzKq4Vsx4zx8D4++bhtK9MiHMsGJq9WgOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793101843;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OL+KIH/+KpZsrWgVhdXaikKeRWtE5nstS96ioSavevw=;
	b=tggoDvQKOCKQ0F1rXmkJIHod9xeGM/PNGcHCXs/x1mzGu75/WAqcWW0CbxJRM0SmeRdi
	 S0oX+nz1yYwpf03i3yPyuHDXUflnNFldJmZ5vel8scoLUdqbUzklbXRWlvandyYYm9qoC
	 fv3BYH5SrTNwU7Pa0VH4wBZisSIkGYHmZac8fQywQ9MwcFVXcy8O896ySWVi0df4g65MN
	 E+rmirvDQkv6LvkdgZ275fOGj1aq+eoOJk823qpW/WeDNhG5JD6pKofk033IK5KWSdVh/
	 J6BCdfqgO5TYeoaZkas1yDIKAFSp6D++P9dbbwJk8JNCVACEQ1z1co4T5+HBX3jGJuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ggzciCLV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C437A606A31A
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 11:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ggzciCLV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7501F01825;
	Tue, 27 Oct 2026 11:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793101842;
	bh=OL+KIH/+KpZsrWgVhdXaikKeRWtE5nstS96ioSavevw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ggzciCLVF1bSV7EIcrkdA9igBOI41aZlIGCImTtelHYMTxPPV5w3pBWVc3p0poMXO
	 VmyhdJCSGc0RJTINvGhM0/p72LJuTW7HC+r/4FsfJHgmuE2ji/YI1wukAUXFeip4zY
	 LHY6wGraWInHY6eY78gU8EcnI64zQOcZUbBZcqqun65pCNLw8cpAVCW5KBcB2eTXKq
	 ENjWV33Tvoph9lUrrAbNlkCkNY4yYXhXZJTmFQKgbuRPjWTjWEH3ObeN26IobFx6Mt
	 vHPaN1C/iuCbpDHHQfQJB2szIjYw8V8tPtGxgZhaWxzBccEH0bOpnDWbFf2BuoIrdc
	 evfiLKCEHCNQw==
Message-ID: <sashiko-outbox-186480@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] RISC-V: KVM: Fix out-of-bounds index into
 aia_irq2bitpos[]
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wang Yechao" <wang.yechao255@zte.com.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261027114439.699273-1-wang.yechao255@zte.com.cn>
References: <20261027114439.699273-1-wang.yechao255@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 11:50:41 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] riscv: kvm: dead bounds check in aia_get_iprio8() and aia_set_ip=
rio8()
--

commit c874cd5cc69d874febde23d82ec7ecdefc1600f2
Author: Wang Yechao <wang.yechao255@zte.com.cn>

RISC-V: KVM: Fix out-of-bounds index into aia_irq2bitpos[]

This commit adds bounds checks against ARRAY_SIZE(aia_irq2bitpos) in
aia_get_iprio8() and aia_set_iprio8() to prevent an alleged out-of-bounds
array access when emulating per-HART AIA priority registers on RV64.

>     RISC-V: KVM: Fix out-of-bounds index into aia_irq2bitpos[]
>    =20
>     aia_get_iprio8() and aia_set_iprio8() index the 64-entry
>     aia_irq2bitpos[] array with an irq value derived from the
>     guest-controlled VSISELECT register. For RV64:
>    =20
>       first_irq =3D (isel - ISELECT_IPRIO0) * 4
>       nirqs =3D 8
>       isel up to ISELECT_IPRIO15
>    =20
>     so the irq number can reach 67 and aia_irq2bitpos[64..67] is
>     accessed out of bounds. A malicious guest can trigger this,
>     causing host panic under KASAN/UBSAN or undefined behavior
>     otherwise.
>    =20
>     Add an explicit bounds check in both accessors before indexing
>     the table.
>    =20
>     Fixes: 2f4d58f7635a ("RISC-V: KVM: Virtualize per-HART AIA CSRs")
>     Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
>
> diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
> index b3b466e4db337..a51d2db7f3311 100644
> --- a/arch/riscv/kvm/aia.c
> +++ b/arch/riscv/kvm/aia.c
> @@ -286,8 +286,12 @@ static int aia_irq2bitpos[] =3D {
>  static u8 aia_get_iprio8(struct kvm_vcpu *vcpu, unsigned int irq)
>  {
>  	unsigned long hviprio;
> -	int bitpos =3D aia_irq2bitpos[irq];
> +	int bitpos;
> =20
> +	if (irq >=3D ARRAY_SIZE(aia_irq2bitpos))
> +		return 0;
> +
> +	bitpos =3D aia_irq2bitpos[irq];
>  	if (bitpos < 0)
>  		return 0;
> =20
> @@ -319,8 +323,12 @@ static u8 aia_get_iprio8(struct kvm_vcpu *vcpu, unsi=
gned int irq)
>  static void aia_set_iprio8(struct kvm_vcpu *vcpu, unsigned int irq, u8 p=
rio)
>  {
>  	unsigned long hviprio;
> -	int bitpos =3D aia_irq2bitpos[irq];
> +	int bitpos;
> +
> +	if (irq >=3D ARRAY_SIZE(aia_irq2bitpos))
> +		return;

[Severity: Medium]
Can irq actually reach 64..67 in aia_get_iprio8() or aia_set_iprio8()?

Both helpers are static and only called from aia_rmw_iprio() via
kvm_riscv_vcpu_aia_rmw_ireg() when isel is between ISELECT_IPRIO0 (0x30) and
ISELECT_IPRIO15 (0x3f).

In arch/riscv/kvm/aia.c, aia_rmw_iprio() rejects odd isel values on RV64
before computing first_irq:

arch/riscv/kvm/aia.c:aia_rmw_iprio() {
#ifndef CONFIG_32BIT
	if (isel & 0x1)
		return KVM_INSN_ILLEGAL_TRAP;
#endif

	nirqs =3D 4 * (BITS_PER_LONG / 32);
	first_irq =3D (isel - ISELECT_IPRIO0) * 4;
    ...
}

Because ISELECT_IPRIO15 (0x3f) is odd, it returns KVM_INSN_ILLEGAL_TRAP on
RV64. The largest even isel reaching the loop on RV64 is ISELECT_IPRIO14
(0x3e), which gives first_irq =3D (0x3e - 0x30) * 4 =3D 56 and nirqs =3D 8,=
 so
first_irq + i is at most 56 + 7 =3D 63. On RV32, isel can be ISELECT_IPRIO15
(0x3f), which gives first_irq =3D 60 and nirqs =3D 4, so first_irq + i is a=
lso
at most 60 + 3 =3D 63.

Since ARRAY_SIZE(aia_irq2bitpos) is 64, isn't irq already guaranteed to be
in 0..63, making these bounds checks unreachable?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027114439.6992=
73-1-wang.yechao255@zte.com.cn?part=3D1
