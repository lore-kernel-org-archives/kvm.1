Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792998159;
	b=RrNPoLlf5OBPWIzjZm++CjTWn2+2Tq9k1cGwkzU1u2J3Xc8wY/r38pQ/KgpEBacCu8gF
	 q0wS5pszv6dEyNv3jjBsqwu0/aifEjz58yUqL4r1EoEQe8C3POdxohqUboJwwhbMY3OEj
	 QXfLtnP6GukE5RoW2Y0cwYvU/evnHKX5Dh83jYgK3OOFAmA6IaSD5kIciKQj+J6diBvit
	 y8wW7ScTuoKSNgDAaHrArTzmJji94ir/uzAt6gkpX1puZy3nKjB8yPIDy/4cEfrVk425/
	 jpDHa4faUZJ8G89n+IhNxCI9HZvDeOdg3k9Jpp3gN8DSnfSEhz0vxoxCGDx3oBbts5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792998159;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=98lkEKGyGl7B1hcC7+Xe38NVhpAzjGEtqaUVJQIdbV0=;
	b=IB3JHsVG5ULYtE72Bc7dY6xjYDiL+464TM3hAUgb+g+ZjKevssIlVYTbYQhkdsud2oRL
	 FPpnz/zHSNPymEtC8pKLvw/xFi7SfcFB5Wljz0WSG0qXr5lVbxR57qkDCguxudEiIHg/b
	 zFhSNBlli/GkMiOB9mfK/qjnxyXoM8TG3HPOitYKvuNuYGhkkYIffRklhHBf/0mBEY4FA
	 78CAzrA4hf1DlY3pmx4ZMf8BIGHKqDmfnW2euYl8E7K/HjNohb/sJJ09PqU9fX5n9+olX
	 9BHtigaJ1qOTkAHtni5UVBr741YzgqXXnEVp0+61yiENmxz5l9igXbBaPXp6BzRU8/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="PpUZ/ky+";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191EB606A31A
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 07:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PpUZ/ky+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658D91F01825;
	Mon, 26 Oct 2026 07:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792998158;
	bh=98lkEKGyGl7B1hcC7+Xe38NVhpAzjGEtqaUVJQIdbV0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PpUZ/ky+xEi+O4G03wFnheS7CK0+snjKxOWLC7Yb/+bPiRw5kZhmnJsuQhvbpa8ny
	 NMRl/RnCzzcVHx1psaktmr+ZnC/HilyqDGpEC8HpJoT/qXbq4WXvtnm0ePLnz3KJ4v
	 tJ7iIznSjHRXom9w3orpYw7cd7xIMmLxvZhg7ieB4EWmoGiVAuYTDsfEbXEYpGSMX2
	 052I3lKBBbiyzCWF/d39OPBfN8b5hg8riKOW7hr5y2Jr19njHAaT4r37BAbC9L8Fc4
	 MZDCaMV65VCaAj/5oyxlkfOtmdd3U2YGYGn2LPUapNUNBnFOZrHeOkY99EgeBft3Ql
	 ERda/jenWxi1A==
Message-ID: <sashiko-outbox-184646@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] KVM: riscv: Eliminate redundancy in set_reg
 function via pointers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paul White" <paul.white.kernel@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <073a56efd7e8f5b1e54207f266e1fa972b54a0e2.1792982932.git.paul.white.kernel@gmail.com>
References: <cover.1792982932.git.paul.white.kernel@gmail.com>
 <073a56efd7e8f5b1e54207f266e1fa972b54a0e2.1792982932.git.paul.white.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 07:02:38 +0000
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
- [High] KVM: riscv: wrong FP register size check in kvm_riscv_vcpu_set_reg=
_fp()
--

commit 22c4a5d5b5662dbf020a9f9d6d213a5477e96b0d
Author: Paul White <paul.white.kernel@gmail.com>

KVM: riscv: Eliminate redundancy in set_reg function via pointers

This commit refactors kvm_riscv_vcpu_set_reg_fp() to consolidate the regist=
er
type and bounds checks for single-precision and double-precision floating
point registers using local pointer and offset variables.

> diff --git a/arch/riscv/kvm/vcpu_fp.c b/arch/riscv/kvm/vcpu_fp.c
> index 16999a5c45dec..fe49576035192 100644
> --- a/arch/riscv/kvm/vcpu_fp.c
> +++ b/arch/riscv/kvm/vcpu_fp.c
> @@ -144,41 +144,53 @@ int kvm_riscv_vcpu_set_reg_fp(struct kvm_vcpu *vcpu,
>  	struct kvm_cpu_context *cntx =3D &vcpu->arch.guest_context;
>  	unsigned long __user *uaddr =3D
>  			(unsigned long __user *)(unsigned long)reg->addr;
> -	unsigned long reg_num =3D reg->id & ~(KVM_REG_ARCH_MASK |
> +	unsigned long token_reg_num =3D reg->id & ~(KVM_REG_ARCH_MASK |
>  					    KVM_REG_SIZE_MASK |
>  					    rtype);
>  	void *reg_val;
> =20
> +	u32 *fcsr_addr;
> +	void *f_array_addr;
> +	size_t byte_offset =3D 0;
> +	unsigned long offical_fcsr_num =3D 0;
> +	unsigned long offical_first_reg =3D 0;
> +	unsigned long offical_last_reg =3D 0;
> +
>  	if ((rtype =3D=3D KVM_REG_RISCV_FP_F) &&
>  	    riscv_isa_extension_available(vcpu->arch.isa, F)) {
> +		fcsr_addr =3D &cntx->fp.f.fcsr;
> +		f_array_addr =3D &cntx->fp.f.f;
> +		byte_offset =3D 4;
> +		offical_fcsr_num =3D KVM_REG_RISCV_FP_F_REG(fcsr);
> +		offical_first_reg =3D KVM_REG_RISCV_FP_F_REG(f[0]);
> +		offical_last_reg =3D KVM_REG_RISCV_FP_F_REG(f[31]);
> +	} else if  ((rtype =3D=3D KVM_REG_RISCV_FP_D) &&
> +			   riscv_isa_extension_available(vcpu->arch.isa, D)) {
> +		fcsr_addr =3D &cntx->fp.d.fcsr;
> +		f_array_addr =3D &cntx->fp.d.f;
> +		byte_offset =3D 8;
> +		offical_fcsr_num =3D KVM_REG_RISCV_FP_D_REG(fcsr);
> +		offical_first_reg =3D KVM_REG_RISCV_FP_D_REG(f[0]);
> +		offical_last_reg =3D KVM_REG_RISCV_FP_D_REG(f[31]);
> +	} else {
> +		return -ENOENT;
> +	}
> +
> +	if (token_reg_num =3D=3D offical_fcsr_num) {
>  		if (KVM_REG_SIZE(reg->id) !=3D sizeof(u32))
>  			return -EINVAL;
> -		if (reg_num =3D=3D KVM_REG_RISCV_FP_F_REG(fcsr))
> -			reg_val =3D &cntx->fp.f.fcsr;
> -		else if ((KVM_REG_RISCV_FP_F_REG(f[0]) <=3D reg_num) &&
> -			 reg_num <=3D KVM_REG_RISCV_FP_F_REG(f[31])) {
> -			reg_num =3D array_index_nospec(reg_num,
> -						     ARRAY_SIZE(cntx->fp.f.f));
> -			reg_val =3D &cntx->fp.f.f[reg_num];
> -		} else
> -			return -ENOENT;
> -	} else if ((rtype =3D=3D KVM_REG_RISCV_FP_D) &&
> -		   riscv_isa_extension_available(vcpu->arch.isa, D)) {
> -		if (reg_num =3D=3D KVM_REG_RISCV_FP_D_REG(fcsr)) {
> -			if (KVM_REG_SIZE(reg->id) !=3D sizeof(u32))
> -				return -EINVAL;
> -			reg_val =3D &cntx->fp.d.fcsr;
> -		} else if ((KVM_REG_RISCV_FP_D_REG(f[0]) <=3D reg_num) &&
> -			   reg_num <=3D KVM_REG_RISCV_FP_D_REG(f[31])) {
> -			if (KVM_REG_SIZE(reg->id) !=3D sizeof(u64))
> -				return -EINVAL;
> -			reg_num =3D array_index_nospec(reg_num,
> -						     ARRAY_SIZE(cntx->fp.d.f));
> -			reg_val =3D &cntx->fp.d.f[reg_num];
> -		} else
> -			return -ENOENT;
> -	} else
> +		reg_val =3D fcsr_addr;
> +	} else if ((offical_first_reg <=3D token_reg_num) && (token_reg_num <=
=3D offical_last_reg)) {
> +		if ((KVM_REG_SIZE(reg->id) !=3D sizeof(u32)) &&
> +		    (KVM_REG_SIZE(reg->id) !=3D sizeof(u64))) {
> +			return -EINVAL;
> +		}
> +		token_reg_num =3D array_index_nospec(token_reg_num,
> +						   32);
> +		reg_val =3D (u8 *)f_array_addr + (token_reg_num * byte_offset);
> +	} else {
>  		return -ENOENT;
> +	}
> =20
>  	if (copy_from_user(reg_val, uaddr, KVM_REG_SIZE(reg->id)))
>  		return -EFAULT;

[Severity: High]
Can this size check allow an out-of-bounds write to cntx->fp.f.f[] when rty=
pe
is KVM_REG_RISCV_FP_F and userspace passes KVM_REG_SIZE_U64 in reg->id via
KVM_SET_ONE_REG?

Previously, kvm_riscv_vcpu_set_reg_fp() required KVM_REG_SIZE(reg->id) =3D=
=3D
sizeof(u32) for KVM_REG_RISCV_FP_F registers and KVM_REG_SIZE(reg->id) =3D=
=3D
sizeof(u64) for KVM_REG_RISCV_FP_D data registers f[0]..f[31].

With the combined check:

	if ((KVM_REG_SIZE(reg->id) !=3D sizeof(u32)) &&
	    (KVM_REG_SIZE(reg->id) !=3D sizeof(u64))) {
		return -EINVAL;
	}

an 8-byte size is accepted when rtype is KVM_REG_RISCV_FP_F (where
f_array_addr points to cntx->fp.f.f and byte_offset is 4). The subsequent
copy_from_user(reg_val, uaddr, KVM_REG_SIZE(reg->id)) then writes 8 bytes
into a 4-byte element of cntx->fp.f.f[32], overwriting the adjacent register
cntx->fp.f.f[token_reg_num + 1] or overflowing cntx->fp.f.f[] into
cntx->fp.f.fcsr when token_reg_num is 31.

Conversely, when rtype is KVM_REG_RISCV_FP_D (where byte_offset is 8), a
4-byte size is now accepted for f[0]..f[31] instead of returning -EINVAL,
resulting in a partial 4-byte write to cntx->fp.d.f[token_reg_num].

Note that the same check was also introduced in kvm_riscv_vcpu_get_reg_fp()
earlier in this series, where copy_to_user() can similarly read 8 bytes from
a 4-byte element of cntx->fp.f.f[32].

Should both functions check KVM_REG_SIZE(reg->id) !=3D byte_offset for the =
data
registers instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792982932.gi=
t.paul.white.kernel@gmail.com?part=3D2
