Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793227835;
	b=qs2sCmSacU/Orq6wM5NLPAInorSyHi+qPw/SBwfkZHEbB33CnHnVWbgzp4LflDgy9Wx0
	 V621jmLbJwHMCeYs9PjV4vudoPQoC2d8xkx5+uPO1C2gUU+YAdsWIuezSofybeAn/dMlZ
	 xCvf0GPvGbtMl1Yl5OqYFFWImJ2IV6v3HIIgcWvEoBCR664WUAm5B0MKkGClcIKh5ShqH
	 +M+6S6gqq4kwyO5nJB84NdSV+p+Mv2kiaUzbmz/izTnUwWdntCU2NfTsKmJrj362dBu15
	 D2KW3bWPciHgAi81fFbCRft56WP6xJGn9YD5XfhXJSJehbQVpG/3TZ9X4xF0r1hbM0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793227835;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XywJwhTyjiTDuvcobkXn1J+M3c1jrHTf7aYOSbP2jWQ=;
	b=FoDq+InQ+0fSLhAXPdM4NlMzOzWEA/TWNyaURefvqRxkSEtq2adJ7tIy430txIE0m2HU
	 oUBnYZ2Mfl0DsARlXLC/HL5+Y6mLJFVAJR/z5pa94mSRbEjBgqgom+eHJzrJOnTbhyjpy
	 oPIRvgqH7090qV+y26vPlO6+o8pzbkpW8n+JCCxLwVajZFrWHBmOON4+KkoYQbvQFpGzu
	 OMFgPBKjQ/mZB8UOMMcV0+qbSerWMU56b583tyBODLQGlu5qVo8hDRRxzzOG1DXZ1uSpZ
	 41rpu2n6Kkgn57I5uJSRXd6arwljN39coBQssyQYDDEwn6Ar5qsBw2EABp8Oaw9Z4ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J2NpoMyc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A35606A31C
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 22:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J2NpoMyc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EFA1F01829;
	Wed, 28 Oct 2026 22:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793227834;
	bh=XywJwhTyjiTDuvcobkXn1J+M3c1jrHTf7aYOSbP2jWQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J2NpoMyctmc6UXVvihHbYPybVdk+9I4kf2ZqQkREqhd2knc28boDUmchqh2nTpsRu
	 evuKZpCC8I4ucsHV16V6cURnFJ39wy/tDwqqJR3GLnwmAZ4915xr3RDaNL0vpy9FDT
	 w/ayK1VXFrDnFeyDbD7jzKOcdrFYlJ0mzesGVkC9qIWAuGW4tNPB/oXwHgLTwmMCmu
	 SetFkqhKmDljbkkKAONdMojPMLjrqNFi4chg8hrDY9bgc6XWXbIZwX+saBVxqclPKZ
	 YQtirDQ4wqmROLnYFydJc7at6G+RFJlGFeobY5UKDvhX1bbV1/1Ql50kUurCZgXwfB
	 Rz/Pmu5NONY3w==
Message-ID: <sashiko-outbox-188532@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] KVM: riscv: Eliminate redundancy in get_reg
 function via pointers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paul White" <paul.white.kernel@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <072bcc0994a5d2a0c21778a7a6f9e395395535c6.1793223506.git.paul.white.kernel@gmail.com>
References: <cover.1793223506.git.paul.white.kernel@gmail.com>
 <072bcc0994a5d2a0c21778a7a6f9e395395535c6.1793223506.git.paul.white.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 22:50:34 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] KVM: riscv: runtime math replaces constants in kvm_riscv_vcpu_get_r=
eg_fp()
- [Low] KVM: riscv: magic numbers and untyped math in kvm_riscv_vcpu_get_re=
g_fp()
--

commit 6aba685edaa53c11084934b49cbe82d9d80cee01
Author: Paul White <paul.white.kernel@gmail.com>

KVM: riscv: Eliminate redundancy in get_reg function via pointers

This commit refactors kvm_riscv_vcpu_get_reg_fp() in arch/riscv/kvm/vcpu_fp=
.c
to store floating-point mode parameters in local variables and compute
register addresses using byte-level pointer arithmetic.

> diff --git a/arch/riscv/kvm/vcpu_fp.c b/arch/riscv/kvm/vcpu_fp.c
> index bb11e6757d349..da4f83be6b19f 100644
> --- a/arch/riscv/kvm/vcpu_fp.c
> +++ b/arch/riscv/kvm/vcpu_fp.c
> @@ -83,41 +83,51 @@ int kvm_riscv_vcpu_get_reg_fp(struct kvm_vcpu *vcpu,
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
> -			  reg_num <=3D KVM_REG_RISCV_FP_F_REG(f[31])) {
> -			reg_num =3D array_index_nospec(reg_num,
> -					ARRAY_SIZE(cntx->fp.f.f));
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
> -					ARRAY_SIZE(cntx->fp.d.f));
> -			reg_val =3D &cntx->fp.d.f[reg_num];
> -		} else
> -			return -ENOENT;
> -	} else
> +		reg_val =3D fcsr_addr;
> +	} else if ((offical_first_reg <=3D token_reg_num) && (token_reg_num <=
=3D offical_last_reg)) {
> +		if (KVM_REG_SIZE(reg->id) !=3D byte_offset)
> +			return -EINVAL;
> +		token_reg_num =3D array_index_nospec(token_reg_num,
> +						   32);
> +		reg_val =3D (u8 *)f_array_addr + (token_reg_num * byte_offset);

[Severity: Low]
Does this refactoring in kvm_riscv_vcpu_get_reg_fp() actually reduce branch
decisions or improve address calculation when userspace invokes the
KVM_GET_ONE_REG ioctl for F or D extension registers?

In the original code, the KVM_REG_RISCV_FP_F and KVM_REG_RISCV_FP_D branches
are mutually exclusive, so the CPU evaluates the same number of conditional
checks per call. In C, struct member access and typed array indexing such as
&cntx->fp.f.f[reg_num] and &cntx->fp.d.f[reg_num] resolve struct offsets at
compile time and scale the index by a constant power of two.

Moving byte_offset, offical_fcsr_num, offical_first_reg, and offical_last_r=
eg
into runtime local variables replaces compile-time constants (sizeof(u32),
sizeof(u64), and KVM_REG_RISCV_FP_F_REG / KVM_REG_RISCV_FP_D_REG) with
runtime state and variable multiplication (token_reg_num * byte_offset).

> +	} else {
>  		return -ENOENT;
> +	}
> =20
>  	if (copy_to_user(uaddr, reg_val, KVM_REG_SIZE(reg->id)))
>  		return -EFAULT;
> @@ -144,9 +154,9 @@ int kvm_riscv_vcpu_set_reg_fp(struct kvm_vcpu *vcpu,
>  		if (reg_num =3D=3D KVM_REG_RISCV_FP_F_REG(fcsr))
>  			reg_val =3D &cntx->fp.f.fcsr;
>  		else if ((KVM_REG_RISCV_FP_F_REG(f[0]) <=3D reg_num) &&
> -			  reg_num <=3D KVM_REG_RISCV_FP_F_REG(f[31])) {
> +			 reg_num <=3D KVM_REG_RISCV_FP_F_REG(f[31])) {
>  			reg_num =3D array_index_nospec(reg_num,
> -					ARRAY_SIZE(cntx->fp.f.f));
> +						     ARRAY_SIZE(cntx->fp.f.f));
>  			reg_val =3D &cntx->fp.f.f[reg_num];
>  		} else
>  			return -ENOENT;
> @@ -161,7 +171,7 @@ int kvm_riscv_vcpu_set_reg_fp(struct kvm_vcpu *vcpu,
>  			if (KVM_REG_SIZE(reg->id) !=3D sizeof(u64))
>  				return -EINVAL;
>  			reg_num =3D array_index_nospec(reg_num,
> -					ARRAY_SIZE(cntx->fp.d.f));
> +						     ARRAY_SIZE(cntx->fp.d.f));

[Severity: Low]
This isn't a bug, but there are several code quality issues in
arch/riscv/kvm/vcpu_fp.c:

In kvm_riscv_vcpu_get_reg_fp(), sizeof(u32), sizeof(u64), and ARRAY_SIZE()
are replaced with hardcoded magic numbers (4, 8, and 32), and typed array
access is replaced with untyped void * and u8 * pointer arithmetic.

In addition, while offical_first_reg and offical_last_reg are introduced to
abstract the register range check, the array indexing does not subtract
offical_first_reg and hardcodes 32 in array_index_nospec(token_reg_num, 32).
Would (u8 *)f_array_addr + (token_reg_num * byte_offset) compute the wrong
offset if a future floating-point mode has a non-zero first register offset
or a different register count?

Also, the new variable names have a typo (offical_fcsr_num,
offical_first_reg, and offical_last_reg instead of official_*), and this
patch includes unrelated whitespace changes in kvm_riscv_vcpu_set_reg_fp().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793223506.gi=
t.paul.white.kernel@gmail.com?part=3D1
