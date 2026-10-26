Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792998159;
	b=bEtf/NBgr0NfGkmfNxSk+gr6FK387XddZ1ByRfvD+yR1WrGGYHQkpgBvtK3vEbh19msd
	 4o5utoZ91emmQMNSybafvl0+Au1Xr1yhmwNkWHEemu6MN2HBTU688odszzirEIN3QQ21v
	 cqfatoB4gHRJ9a0ib03BBuLJPGIjKUBIy1Udiqar9GpDf6jCOrDe4tI1gFVDl2a+lkotF
	 lqWyBSEhjZhHW3hfx1oaulSxXnsOLc6P50vUdzX4sdaZ1WTZqDrCcZcmZxGvJWp4ac/+Z
	 xFVKYNmuhR+IJApGTD+3Ait69wxbJgNJp1AqF6vc/GfgUTEhu2x4wZdkSJZ1NfFOrgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792998159;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VdNZMmw4kfmPhicgn9owTkEU1+M18JeU5DlXOfnaV28=;
	b=WGvco9pap5BD9VSYMC2vlk8uaqMvNJdv5V3IcqxWwNu5MMLCHc3FE83RgAAD4LwIiUqV
	 ZrYNwcVp6zfNos9ahoNt/I/rRyUtTEIsOPiFGUPL7bnXes0uDX9LE6+cEfcocrxuoxnhE
	 Z6z9SOUW1tEaAiHjDsWgoFflLOFXXwQK1d0wWH0RjoMZl7Tn0Mg5uQ8lSBdaj/0AqF9nD
	 E1lyRPqQ03z5ZPj+LZbPyzkd9VWR3N9v45HfgRGEeZseIOqS0M/v72BYl6+fBMC3nj6ZY
	 mx/2l9nNYJqbZtpObQNz1ay1VTICHY4Nqm2l0lCbl8JEP89+/C0NXn2DB3rzMA3VT9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZeavIMFd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C44606A31B
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 07:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZeavIMFd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA3C1F01828;
	Mon, 26 Oct 2026 07:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792998159;
	bh=VdNZMmw4kfmPhicgn9owTkEU1+M18JeU5DlXOfnaV28=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZeavIMFdHJiWj4MXY1psYH/NqWz0ZKfHdJQz9kNKs9z688rbZFnx4yy2tsjuB5M0T
	 daq3hqPjmurTta5Ks8yAYyRtysv7dst/B4ekVkxk3HwCeyLBcqyASNZAy8uB0IBAfS
	 TpRY5WcLOHEtcsdQw/In3lE3A0FR0ObZXBCDU4xGSHybwCHhLFInm+C9YhBM8ZDQdD
	 cz7iR6ahuCUSUvceD0mPImeWOnnJfBTcRe4j7uP9qT+XnAfg4QZ6mBdqxz26hCYrS2
	 BT5ljxjCmYJ2UqjaeHEgP1P2kiZIM1suEJdqs66gP46HdVEk88WsDuJZzEDoW7zjsJ
	 UiQno88S1g27w==
Message-ID: <sashiko-outbox-184647@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] KVM: riscv: Eliminate redundancy in get_reg
 function via pointers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paul White" <paul.white.kernel@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <f7fcf15c1117ce734247cf951c0afff1f5eb54c8.1792982932.git.paul.white.kernel@gmail.com>
References: <cover.1792982932.git.paul.white.kernel@gmail.com>
 <f7fcf15c1117ce734247cf951c0afff1f5eb54c8.1792982932.git.paul.white.kernel@gmail.com>
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
- [High] KVM: riscv: mismatched register size check in kvm_riscv_vcpu_get_r=
eg_fp()
--

commit 0e99059ef6014093a2535ab4ecda318fe5ee3489
Author: Paul White <paul.white.kernel@gmail.com>

KVM: riscv: Eliminate redundancy in get_reg function via pointers

This commit refactors kvm_riscv_vcpu_get_reg_fp() to consolidate the
register lookup and size checks for single-precision and double-precision
floating-point registers using mode-dependent local variables and pointer
offsets.

> diff --git a/arch/riscv/kvm/vcpu_fp.c b/arch/riscv/kvm/vcpu_fp.c
> index bb11e6757d349..16999a5c45dec 100644
> --- a/arch/riscv/kvm/vcpu_fp.c
> +++ b/arch/riscv/kvm/vcpu_fp.c
> @@ -83,41 +83,53 @@ int kvm_riscv_vcpu_get_reg_fp(struct kvm_vcpu *vcpu,
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
>  	if (copy_to_user(uaddr, reg_val, KVM_REG_SIZE(reg->id)))
>  		return -EFAULT;

[Severity: High]
Can this read past the bounds of an element in cntx->fp.f.f[] when userspace
requests a single-precision register with a 64-bit size?

In kvm_riscv_vcpu_get_reg_fp(), the merged size check for floating-point da=
ta
registers allows both sizeof(u32) and sizeof(u64) regardless of whether rty=
pe
is KVM_REG_RISCV_FP_F (where byte_offset is 4 and f_array_addr points to the
32-bit array cntx->fp.f.f) or KVM_REG_RISCV_FP_D (where byte_offset is 8 and
f_array_addr points to the 64-bit array cntx->fp.d.f).

If userspace invokes the vcpu ioctl path:

  kvm_arch_vcpu_ioctl() ->
    kvm_riscv_vcpu_get_reg() ->
      kvm_riscv_vcpu_get_reg_fp()

with rtype =3D=3D KVM_REG_RISCV_FP_F and KVM_REG_SIZE(reg->id) =3D=3D sizeo=
f(u64),
the size check now passes instead of returning -EINVAL. Then copy_to_user()
copies 8 bytes from a 4-byte slot at (u8 *)f_array_addr + (token_reg_num * =
4),
reading into the adjacent element of cntx->fp.f.f[] (or past cntx->fp.f.f[3=
1]
into cntx->fp.f.fcsr). Conversely, requesting a KVM_REG_RISCV_FP_D data
register with sizeof(u32) also passes and copies only 4 bytes instead of
returning -EINVAL.

Should the size check here compare against byte_offset instead:

	if (KVM_REG_SIZE(reg->id) !=3D byte_offset)
		return -EINVAL;

so that the register size must match the width of the selected floating-poi=
nt
mode?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792982932.gi=
t.paul.white.kernel@gmail.com?part=3D1
