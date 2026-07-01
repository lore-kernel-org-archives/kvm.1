Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F25A1FD4
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 02:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782873203; cv=none; b=r+4yP1YeLlNLf1qXnwaQrolRY+D4bSr76UyqxOFX0ijIHwDOKm46xhTC49oj6rlGgeD7G/q9tLCscBSV1YXTrNw/4RcCTtzuY84N/oIlVXrx50MXyzstH99bg7JwoTwZ/TStOrMsglgH4As5ebEJCm53CI3B2zlIKoLgVsY072c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782873203; c=relaxed/simple;
	bh=auwSA7ZKxfIlyPEkggWlHPW1E+fuoiM7JeAhACgEDQ8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FcA6RUOuyydE/RaAnB/NHpxHmkZkKE8CQm8yBDQpHXPzF75mPUlq0qbzzHcGqMinl29Dt1yaLXUdTPvrTzNG3OiZsyphTfO8y/tspIYwU/a0NC/bSw1THak/aNVDQS1Ig30h+LA/bI4ENIOUx1lUwTh2Vun0UG2b4NRFCwRco/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3Ohx9Ii; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3Ohx9Ii"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AAB11F000E9;
	Wed,  1 Jul 2026 02:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782873201;
	bh=QeLOAQJzI0H+gg/XMytSvZAjGWpkB/TBebnimyd2YzY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=o3Ohx9IilbfKYsAPe/mSZdRfReXzNnWKvA9kW+acMuPvYcQ0idqtt2o0sLT0Ldvz6
	 YN5gHwOaeVycQdbwaGM0z4HBzUirzsOX5BCkROydeYdWIJMGVm128tl4a2NpVgJX4T
	 8+GOAp4fnBwQjYPisRHRuZbylKesQOQOoB+HQxoLUwdM/TKaquA/XHVcuPiWVhy7IW
	 it9jhJt0aNILaXnazNBASUF5SDizr/xd3tVedDr3O6t5thry79TI6alJZG1MMt5NFr
	 dI14b6HoVGHcEtb2EJIYpNgKkh5ArA0HjCPbKK43CJxveqo/lK/gjPEwkQElXBKntO
	 fDTKD/h5SUy2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 7/8] RISC-V: KVM: Add support for control-flow
 integrity FWFT features
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260701020746.170157-8-inochiama@gmail.com>
References: <20260701020746.170157-1-inochiama@gmail.com>
 <20260701020746.170157-8-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 02:33:21 +0000
Message-Id: <20260701023321.9AAB11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incorrect usage of EXC_SOFTWARE_CHECK as a direct integer instead =
of a bitmask when configuring hedeleg, causing unintended exception delegat=
ion and un-delegation.
--

commit 061583fda9a0d491f0c4c0df10fbb4b0f97c7b4e
Author: Inochi Amaoto <inochiama@gmail.com>

RISC-V: KVM: Add support for control-flow integrity FWFT features

This commit exposes control-flow integrity features to the guest if
supported by the host, and allows the VMM to configure them via the SBI
FWFT interface.

> diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwf=
t.c
> index 7192c229a19e2..cb9b9721ec882 100644
> --- a/arch/riscv/kvm/vcpu_sbi_fwft.c
> +++ b/arch/riscv/kvm/vcpu_sbi_fwft.c

[ ... ]

> @@ -176,6 +176,95 @@ static long kvm_sbi_fwft_get_misaligned_delegation(s=
truct kvm_vcpu *vcpu,
>  	return SBI_SUCCESS;
>  }
> =20
> +static long kvm_sbi_fwft_set_cfi(struct kvm_vcpu *vcpu,
> +				 struct kvm_sbi_fwft_config *conf,
> +				 bool one_reg_access, unsigned long value,
> +				 u64 flag)
> +{
> +	struct kvm_vcpu_config *cfg =3D &vcpu->arch.cfg;
> +
> +	if (value =3D=3D 0)
> +		cfg->henvcfg &=3D ~flag;
> +	else if (value =3D=3D 1)
> +		cfg->henvcfg |=3D flag;
> +	else
> +		return SBI_ERR_INVALID_PARAM;
> +
> +	if (cfg->henvcfg & (ENVCFG_LPE | ENVCFG_SSE))
> +		cfg->hedeleg |=3D EXC_SOFTWARE_CHECK;
> +	else
> +		cfg->hedeleg &=3D ~EXC_SOFTWARE_CHECK;

[Severity: High]
Does this code modify the correct bits in hedeleg?

EXC_SOFTWARE_CHECK is an exception cause (value 18, or 0x12). When used
directly in bitwise operations like this, it seems to modify bit 1
(instruction access fault) and bit 4 (load address misaligned) rather than
bit 18.

Should this use BIT(EXC_SOFTWARE_CHECK) or (1UL << EXC_SOFTWARE_CHECK)
instead to ensure the software check exception is delegated properly without
corrupting the other delegation states?

> +
> +	if (!one_reg_access) {
> +		csr_write(CSR_HEDELEG, cfg->hedeleg);

[ ... ]

> +static void kvm_sbi_fwft_reset_landing_pad(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_vcpu_config *cfg =3D &vcpu->arch.cfg;
> +
> +	kvm_sbi_fwft_env_flag_reset_helper(vcpu, ENVCFG_LPE);
> +	if ((cfg->henvcfg & (ENVCFG_LPE | ENVCFG_SSE)) =3D=3D 0)
> +		cfg->hedeleg &=3D ~EXC_SOFTWARE_CHECK;
> +}

[Severity: High]
Similar to the question above in kvm_sbi_fwft_set_cfi(), could this
undelegate the wrong exceptions because EXC_SOFTWARE_CHECK is used without
being converted to a bitmask first?

[ ... ]

> +static void kvm_sbi_fwft_reset_shadow_stack(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_vcpu_config *cfg =3D &vcpu->arch.cfg;
> +
> +	kvm_sbi_fwft_env_flag_reset_helper(vcpu, ENVCFG_SSE);
> +	if ((cfg->henvcfg & (ENVCFG_LPE | ENVCFG_SSE)) =3D=3D 0)
> +		cfg->hedeleg &=3D ~EXC_SOFTWARE_CHECK;
> +}

[Severity: High]
Would it be necessary to update this location to use a bitmask as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701020746.1701=
57-1-inochiama@gmail.com?part=3D7
