Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C533237713
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 09:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780304682; cv=none; b=hhKZoqfCMEfZuf5KI/irTNNgUw8mjOZH99i5I0oHw8qL5fueX19wikXnAsnIvf2JpbLd3knfGDFP9O+tk5ZvAmzULr9Nb9+Akc6502gqGY9W76Xa2dDYtC0YObsUcZ3k9PbsAorB16fPnqZP2iYm72Jvk8alqqii4Gg+b3J4Dyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780304682; c=relaxed/simple;
	bh=fUMBwvlZjIo26KyBrr1wzwXbB5TVKHoXVzexco580wA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FrNIzcMRC98ZOLVNVITPdeRekalwrUEPHjYmch3VNY7gdin6Cm6PP2pb6n6HyrGCAyWRb0tN3fumX9ctFaTQOLlAwnU9FKeSlbr+aSKsHnVbCBTizrmMR+IkGEht9qp0XGMtQOWnx4RyMZ40OOIQbhQ5pDCgArsfaubi7+5fqTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZS8ZnaV9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZS8ZnaV9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034771F00893;
	Mon,  1 Jun 2026 09:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780304681;
	bh=xTn4rQjGqiyB6HXUn2OszUQx4q9vHhfHyrR1/kFkcxs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZS8ZnaV9UB0ymPKDbGB9ta5OeNLYFsCWu8d2ZzwxI0h6qkHKrs67+StE7uK4RqPIk
	 dlGLatrVSIzAwbOusB0E+iwpDzKOKk/jdEKksCAFQbKF9tAlV0HdL2dSt/8HQ9n880
	 ehZTjJwN08vAn0/6CspcRzRBHIEg5iI+NYdPNmdkwGuxa4KMDRlcOFSHxtU+IvJMYR
	 t7vri6gLNiwAIu4hPWGSvx4ubrBMbboAOoHschV9RjD7ib1V+YbKgGigNxeh8xFCLt
	 JvfDtI8QEPCy80/sJkzEMhrGehzauR5oAd9G/nrH9Mi52pOycwO4W09tAPLv3Edn3Z
	 2AqE0WNaWgU4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/7] RISC-V: KVM: Add support for Svadu FWFT features
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260601084336.2601675-2-inochiama@gmail.com>
References: <20260601084336.2601675-2-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 09:04:40 +0000
Message-Id: <20260601090441.034771F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] KVM_SET_ONE_REG for FWFT state registers modifies VCPU configurati=
on in memory but fails to set `vcpu->arch.csr_dirty =3D true`, leading to s=
tale hardware CSRs.
- [High] The FWFT support check `kvm_sbi_fwft_pte_ad_hw_updating_supported(=
)` incorrectly disables the toggle when both SVADU and SVADE are present, a=
nd dangerously enables it when only SVADU is present.
- [High] The 'flag' parameter in henvcfg helper functions is 'unsigned long=
', causing truncation of 64-bit flags like ENVCFG_ADUE on 32-bit systems an=
d permanently corrupting guest `henvcfg` state during vCPU reset.
- [High] Dynamically setting the Svadu FWFT feature on RV32 fails to update=
 the physical CPU's `CSR_HENVCFGH` register, leaving the hardware state sta=
le.
- [High] Direct modification of `CSR_HENVCFG` bypasses Nested Acceleration =
(NACL) shared memory, leading to state desynchronization in nested virtuali=
zation.
--

commit df2a6571e0257cf7e8c4ca0758aefd4d6f6c3a32
Author: Inochi Amaoto <inochiama@gmail.com>

RISC-V: KVM: Add support for Svadu FWFT features

This patch adds support for exposing the Svadu extension to guests via the
SBI FWFT interface. It introduces helpers to get, set, and reset henvcfg
flags, specifically for the ADUE bit which controls hardware updating of
PTE A/D bits.

> diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwf=
t.c
> index 2eab15339694f..375269e43c13b 100644
> --- a/arch/riscv/kvm/vcpu_sbi_fwft.c
> +++ b/arch/riscv/kvm/vcpu_sbi_fwft.c

[ ... ]

> @@ -84,6 +84,42 @@ static bool kvm_fwft_is_defined_feature(enum sbi_fwft_=
feature_t feature)
>  	return false;
>  }
> =20
> +static void kvm_sbi_fwft_env_flag_reset_helper(struct kvm_vcpu *vcpu,
> +					       unsigned long flag)
> +{
> +	vcpu->arch.cfg.henvcfg &=3D ~flag;
> +}

[Severity: High]
Does using unsigned long for the flag parameter truncate 64-bit flags
like ENVCFG_ADUE on 32-bit systems?

Since ENVCFG_ADUE is in the upper 32 bits, passing it as unsigned long on
CONFIG_32BIT systems would silently truncate it to 0.=20

When vcpu->arch.cfg.henvcfg &=3D ~flag evaluates with flag as 0, it results
in henvcfg &=3D ~0UL. Because ~0UL is 0xFFFFFFFF, it zero-extends to u64,
resulting in henvcfg &=3D 0x00000000FFFFFFFFULL.

Will this unconditionally wipe out all upper 32-bit extensions like
ENVCFG_STCE and ENVCFG_PBMTE for the guest during vCPU reset?

> +
> +static long kvm_sbi_fwft_env_flag_set_helper(struct kvm_vcpu *vcpu,
> +					     struct kvm_sbi_fwft_config *conf,
> +					     bool one_reg_access,
> +					     unsigned long value, unsigned long flag)
> +{

[Severity: High]
Is this helper also affected by the same unsigned long truncation issue
for the flag parameter?

> +	struct kvm_vcpu_config *cfg =3D &vcpu->arch.cfg;
> +
> +	if (value =3D=3D 0)
> +		cfg->henvcfg &=3D ~flag;
> +	else if (value =3D=3D 1)
> +		cfg->henvcfg |=3D flag;
> +	else
> +		return SBI_ERR_INVALID_PARAM;
> +

[Severity: High]
When one_reg_access is true, does this omit setting vcpu->arch.csr_dirty
to true?

If the VCPU is later scheduled on the same physical CPU, vcpu_load() might
skip calling kvm_riscv_vcpu_config_load() due to the fast-path condition
checking the csr_dirty flag.

Could this cause the guest to run with a stale hardware configuration since
the updated henvcfg is never flushed to the hardware CSR_HENVCFG?

> +	if (!one_reg_access)
> +		csr_write(CSR_HENVCFG, vcpu->arch.cfg.henvcfg);

[Severity: High]
On 32-bit RISC-V systems, does csr_write(CSR_HENVCFG, ...) only write the
lower 32 bits?

Since ENVCFG_ADUE resides in the upper 32 bits, shouldn't there be an
explicit write to CSR_HENVCFGH as well? Without it, the physical CPU's
configuration might not be properly synchronized for upper 32-bit flags.

[Severity: High]
Does directly modifying CSR_HENVCFG bypass Nested Acceleration (NACL)?

When KVM runs as an L1 hypervisor with NACL enabled, it must synchronize
hypervisor CSRs via the shared memory region (nsh) rather than directly
writing to the physical CSRs.

If ncsr_write() is not used here, could the L0 hypervisor miss the update
and overwrite the CSR with a stale value from nsh on subsequent VM entries?

> +
> +	return SBI_SUCCESS;
> +}

[ ... ]

> +static bool kvm_sbi_fwft_pte_ad_hw_updating_supported(struct kvm_vcpu *v=
cpu)
> +{
> +	return riscv_isa_extension_available(vcpu->arch.isa, SVADU) &&
> +		!riscv_isa_extension_available(vcpu->arch.isa, SVADE);
> +}

[Severity: High]
Does this condition behave backward with respect to the SBI FWFT specificat=
ion?

The specification requires that if a VM supports only Svadu, ADUE must be
hardwired to 1. If it supports both Svadu and Svade, the guest can toggle
the feature.

By returning true only when Svadu is present and Svade is absent, does this
disable the toggle for fully capable VMs, and incorrectly allow Svadu-only =
VMs
to set ADUE=3D0?=20

If a Svadu-only VM sets ADUE=3D0, could it silently corrupt its memory sinc=
e the
Svade software fallback is unavailable?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601084336.2601=
675-1-inochiama@gmail.com?part=3D1
