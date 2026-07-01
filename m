Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF973644C6
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 02:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782873049; cv=none; b=Pj/oT/MxuyLPhOZ4j3GMvRJuAkPSdspkVTINgVdEdI6YDDJMUPc7HYoOWzldxhpKd8+Tjldezz/Y+s+2PmIT0ibYK9tj1DdvD7u3Lj9V44uVcF3GGEoIjyVusLRimmrgNZQQN2A5O/hf5AH5WEn471G3whqRmNA8V7FtIg9sUC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782873049; c=relaxed/simple;
	bh=TCNVLGaRrAsH30hPLNTcsdRMyfId4JH62OB0RbBjP3Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hfS6Oe30k1bDo85amNnw70Hbc3qUi2PKC/AbtJhU/wpta4CVc+xZ6bCd67I8aQrgd6j/o0SLgW+Vkyr6E2xLCC2KOgBh01DgJ50rh7y6/FlfxeaSbmKjijznidbL4EwCBocca5GnMkX2yY1t2ztZ/0bruWSspbc/mVI7ktzivkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzmbkaWK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzmbkaWK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155F81F000E9;
	Wed,  1 Jul 2026 02:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782873046;
	bh=4TXEp4mAOSK5Lm5OrhwdFEDYvvbBtpjbpI9UBfBP0ag=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZzmbkaWK021pogc5h6cALlO4En6vRwSpCQvDIhxAT8nJ1DY+HJwQ1zy/hwKavQ7nE
	 IsUOP91H1xXlJ1XrOlExBdxa0uayOlvwyyC1H3gxCTkEHlonjrEIJhlm6U+il11t2W
	 qJrFT/g1TLk02QMDh2Lb/S2kn8NT0UUPcDbeWDV6x/Z3U5JweVRRJ8pi38CTOGLf4A
	 tYDH/idjViiCAbwIyIXXz5H2HyNq0EjIbmYUwTItNlvnCFD0kUgM61NvPA/clwsFcq
	 WBUi0jcZu1Cz/h4rJivbMFXjCyKINCLB3ODMyp+n2oG6wU2udKw/O0IjKm1jp/bqRt
	 6/4tvBkd0hZJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/8] RISC-V: KVM: Add support for Svadu FWFT features
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260701020746.170157-2-inochiama@gmail.com>
References: <20260701020746.170157-1-inochiama@gmail.com>
 <20260701020746.170157-2-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 02:30:45 +0000
Message-Id: <20260701023046.155F81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing Nested Virtualization (NACL) Synchronization in FWFT setter
- [High] State Corruption on Reset for SVADU-only guests
--

commit 3a9bb56abfad9f69ff748e7562ad8693be40c7f9
Author: Inochi Amaoto <inochiama@gmail.com>
RISC-V: KVM: Add support for Svadu FWFT features

This commit adds support for the Svadu FWFT feature in RISC-V KVM.
It exposes the PTE A/D hardware updating feature if both Svadu and Svade
are supported, and adds helper functions to get and set the ISA extension
state for the guest.

> diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwf=
t.c
> index ab39ac464ffd8..7192c229a19e2 100644
> --- a/arch/riscv/kvm/vcpu_sbi_fwft.c
> +++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
[ ... ]
> @@ -94,6 +94,45 @@ static bool kvm_fwft_is_defined_feature(enum sbi_fwft_=
feature_t feature)
>  	return false;
>  }
> =20
> +static void kvm_sbi_fwft_env_flag_reset_helper(struct kvm_vcpu *vcpu,
> +					       u64 flag)
> +{
> +	vcpu->arch.cfg.henvcfg &=3D ~flag;
> +}
> +
> +static long kvm_sbi_fwft_env_flag_set_helper(struct kvm_vcpu *vcpu,
> +					     struct kvm_sbi_fwft_config *conf,
> +					     bool one_reg_access,
> +					     unsigned long value, u64 flag)
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
> +	if (!one_reg_access) {
> +		csr_write(CSR_HENVCFG, vcpu->arch.cfg.henvcfg);
> +		if (IS_ENABLED(CONFIG_32BIT))
> +			csr_write(CSR_HENVCFGH, vcpu->arch.cfg.henvcfg >> 32);
> +	}

[Severity: High]
Will this cause state corruption when KVM nested acceleration (NACL) is
active?

When KVM acts as an L1 hypervisor using NACL, updating the CSR directly
with csr_write() fails to update the NACL shared memory page (nacl_shmem).

When L0 later switches context or resumes the L2 guest, it will reload
CSR_HENVCFG from the unmodified nacl_shmem, silently discarding the L2
guest's FWFT update.

Should this use ncsr_write() instead to ensure safe H-mode CSR
modifications for nested virtualization?

> +
> +	return SBI_SUCCESS;
> +}
[ ... ]
> @@ -137,6 +176,33 @@ static long kvm_sbi_fwft_get_misaligned_delegation(s=
truct kvm_vcpu *vcpu,
>  	return SBI_SUCCESS;
>  }
> =20
> +static bool kvm_sbi_fwft_pte_ad_hw_updating_supported(struct kvm_vcpu *v=
cpu)
> +{
> +	return riscv_isa_extension_available(vcpu->arch.isa, SVADU) &&
> +		riscv_isa_extension_available(vcpu->arch.isa, SVADE);
> +}
> +
> +static void kvm_sbi_fwft_reset_pte_ad_hw_updating(struct kvm_vcpu *vcpu)
> +{
> +	kvm_sbi_fwft_env_flag_reset_helper(vcpu, ENVCFG_ADUE);
> +}

[Severity: High]
Could this break A/D bit updates for SVADU-only guests after a reboot?

A VCPU configured with SVADU but without SVADE requires ENVCFG_ADUE to be
set to 1 to function properly. This is correctly initialized the first
time in kvm_riscv_vcpu_config_ran_once().

However, when the guest initiates a system reset, this reset handler
unconditionally clears ENVCFG_ADUE. Because vcpu->arch.ran_atleast_once
is already true and is not cleared on reset,
kvm_riscv_vcpu_config_ran_once() will not run again.

Does this leave the SVADU-only VCPU resuming with ENVCFG_ADUE cleared,
causing hardware to fail updating A/D bits without SVADE to trap them?

> +
> +static long kvm_sbi_fwft_set_pte_ad_hw_updating(struct kvm_vcpu *vcpu,
> +						struct kvm_sbi_fwft_config *conf,
> +						bool one_reg_access, unsigned long value)
> +{
> +	return kvm_sbi_fwft_env_flag_set_helper(vcpu, conf, one_reg_access,
> +						value, ENVCFG_ADUE);
> +}
> +
> +static long kvm_sbi_fwft_get_pte_ad_hw_updating(struct kvm_vcpu *vcpu,
> +						struct kvm_sbi_fwft_config *conf,
> +						bool one_reg_access, unsigned long *value)
> +{
> +	return kvm_sbi_fwft_env_flag_get_helper(vcpu, conf, one_reg_access,
> +						value, ENVCFG_ADUE);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701020746.1701=
57-1-inochiama@gmail.com?part=3D1
