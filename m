Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDF53A1CD
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 10:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309861; cv=none; b=Eqw4wn95mUZthrqyTJN6u7OmdjcFh/uO36Dt31Umxs+HZqu3qY8DyKHQnYc3P1UMCwNwtTa1HoJhTm8n7oA44hP/K4DCFvf8oFkDiyGfW+TwRWtCbTkIUMqO33lyRL703xyYagkE6E0C2MwOQFJ7NMsRT8QBvGQFZS2YdNh6WKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309861; c=relaxed/simple;
	bh=0umK9uFLu6dq3bQOTT9fr2Uc6mrpgWJpIHDI1apPumo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=utpJtU2XsWJ+dlKf5YlbOQVOYkT3VEiLF6A4gogW3IUYceotMCK+ZO0n4ZXxWxQKNNGuXLZWbLUZZ6y+bDyDfW9ludG0B8zvM4iOtS6dNj0Q6iMhC+IuK34jBsZGAT5nlpQcAXDTdS8VM9BPXD3wurwPWqpg0w8wyREwxKMsooA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4gfSNUI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4gfSNUI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60FCF1F00893;
	Mon,  1 Jun 2026 10:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780309859;
	bh=VEKauowzjjB93y/JmGAoaDVAbRF9GbLv2mPDhd7aDZQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j4gfSNUI7Y0k+AJxUtyIfcEwUuIQZSrlRSfZ6BB+Jr8a4tDGpYYfM2dD7YyxBRrog
	 cq5RLIz3OX/q4HIrqD0QYTCMlsPWc2UrhvWg/MRdRg3UxSqrkn+kgHMbHlD3ETEzRA
	 pC/25Ojd73xizDGnqq6l35IZAvZgDyxV47P9kd2vogGedLssra6cG6DH9vqJna3Xp3
	 52oRfmTJ7x6xrMNPfFwE1rNFdzAEfcj+Me8Mw/VKo4+siFRid8GRxzchRiVq5ZBZJu
	 fx+OhaqylIKrH06t1Rav6Id04c2nWlz63SUb9ZKCEhGGZAmFAV6hcUOwFGFwBO3VWw
	 vJlgWLOpKMTaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/7] RISC-V: KVM: Add support for control-flow
 integrity FWFT features
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260601084336.2601675-7-inochiama@gmail.com>
References: <20260601084336.2601675-7-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 10:30:58 +0000
Message-Id: <20260601103059.60FCF1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] KVM fails to context-switch the shadow stack pointer (CSR_SSP) whe=
n exposing ZICFISS to the guest.
- [High] Direct write to `CSR_HENVCFG` bypasses nested acceleration (NaCl) =
shared memory synchronization.
- [High] The `unsigned long flag` argument in `henvcfg` helpers zero-extend=
s and corrupts the upper 32 bits on RV32, and silently truncates 64-bit fla=
gs.
- [High] Guest can bypass VMM ISA restrictions to enable FWFT features due =
to caching at vCPU creation.
- [High] Modifying FWFT features via KVM_SET_ONE_REG updates `vcpu->arch.cf=
g.henvcfg` but fails to mark the CSR as dirty, leading to stale hardware st=
ate execution.
- [Medium] SBI FWFT flags are committed even if the feature value set opera=
tion fails.
--

commit c2d9c5584a3fada7da09588693c511ec3fdbbcf1
Author: Inochi Amaoto <inochiama@gmail.com>
Subject: RISC-V: KVM: Add support for control-flow integrity FWFT features

This commit exposes the Zicfilp and Zicfiss control-flow integrity features
to guests through the SBI FWFT interface. It also allows the VMM to block
access to these features by disabling the corresponding ISA extensions.

> diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwf=
t.c
> index 375269e43c13b..278eb95b97de4 100644
> --- a/arch/riscv/kvm/vcpu_sbi_fwft.c
> +++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
> @@ -163,6 +163,58 @@ static long kvm_sbi_fwft_get_misaligned_delegation(s=
truct kvm_vcpu *vcpu,
[ ... ]
> +static bool kvm_sbi_fwft_landing_pad_supported(struct kvm_vcpu *vcpu)
> +{
> +	return riscv_isa_extension_available(vcpu->arch.isa, ZICFILP);
> +}

[Severity: High]
Does checking the ISA extension at vCPU creation allow the guest to bypass =
VMM
restrictions?

The FWFT framework caches feature availability during kvm_sbi_ext_fwft_init=
()
which executes at vCPU creation. At that time, vcpu->arch.isa typically
contains all default host-supported extensions.

If the VMM later configures the VM by disabling unsupported extensions via
KVM_SET_ONE_REG, the guest can still successfully enable the hardware featu=
res
because the FWFT layer permanently cached conf->supported as true.

[ ... ]
> +static long kvm_sbi_fwft_set_landing_pad(struct kvm_vcpu *vcpu,
> +					 struct kvm_sbi_fwft_config *conf,
> +					 bool one_reg_access, unsigned long value)
> +{
> +	return kvm_sbi_fwft_env_flag_set_helper(vcpu, conf, one_reg_access,
> +						value, ENVCFG_LPE);
> +}

[Severity: High]
Can passing ENVCFG_LPE to this helper cause truncation or zero-extension
issues?

Looking at kvm_sbi_fwft_env_flag_set_helper(), the flag parameter is typed =
as
unsigned long. On RV32, unsigned long is 32 bits, which would truncate 64-b=
it
flags.

Furthermore, when clearing a flag via cfg->henvcfg &=3D ~flag, if flag is 0,
~flag evaluates to the 32-bit 0xFFFFFFFF. Because cfg->henvcfg is a u64,
the 32-bit mask is zero-extended to 0x00000000FFFFFFFFULL.

This zero-extension permanently wipes the entire upper 32 bits of henvcfg a=
nd
corrupts hardware states like Svpbmt and Zicbom on 32-bit KVM hosts.

[Severity: High]
Does modifying FWFT features via KVM_SET_ONE_REG lead to stale hardware sta=
te?

When userspace modifies an FWFT feature via KVM_SET_ONE_REG, one_reg_access=
 is
true. In kvm_sbi_fwft_env_flag_set_helper():

    if (!one_reg_access)
        csr_write(CSR_HENVCFG, vcpu->arch.cfg.henvcfg);

This updates the in-memory vcpu->arch.cfg.henvcfg but skips the immediate C=
SR
write. However, it fails to set vcpu->arch.csr_dirty =3D true.

When vcpu_load() later executes, it evaluates !vcpu->arch.csr_dirty and ski=
ps
kvm_riscv_vcpu_config_load(), causing the guest to run with stale hardware
configurations.

[Severity: High]
Does writing directly to CSR_HENVCFG bypass nested acceleration?

When one_reg_access is false, kvm_sbi_fwft_env_flag_set_helper() directly
writes the hardware CSR using csr_write(CSR_HENVCFG, ...).

When KVM runs as an L1 nested hypervisor with RISC-V nested acceleration
enabled, hardware CSRs must be synchronized with the L0 hypervisor via a
shared memory region.

Bypassing the ncsr_write() wrapper fails to set the dirty bit in the shared
memory bitmap, meaning the L0 hypervisor remains unaware of the change and
will overwrite the hardware CSR with a stale value on the next nested VM en=
try.

[ ... ]
> +static bool kvm_sbi_fwft_shadow_stack_supported(struct kvm_vcpu *vcpu)
> +{
> +	return riscv_isa_extension_available(vcpu->arch.isa, ZICFISS);
> +}

[Severity: High]
Does exposing ZICFISS without context-switching CSR_SSP leak guest state in=
to
the host?

When a guest enables and uses the shadow stack, it writes to the shadow sta=
ck
pointer CSR_SSP. KVM does not currently save or restore CSR_SSP during VCPU
context switches.

Since U-mode CSRs are not automatically banked by the RISC-V hardware betwe=
en
host and guest execution modes, the guest's shadow stack pointer remains ac=
tive
when returning to the host.

When the host's userspace resumes execution, it does so with a corrupted sh=
adow
stack pointer, leading to shadow stack violations and a denial-of-service
crash.

[ ... ]
> @@ -288,6 +340,24 @@ static const struct kvm_sbi_fwft_feature features[] =
=3D {
>  		.set =3D kvm_sbi_fwft_set_misaligned_delegation,
>  		.get =3D kvm_sbi_fwft_get_misaligned_delegation,
>  	},
> +	{
> +		.id =3D SBI_FWFT_LANDING_PAD,
> +		.first_reg_num =3D offsetof(struct kvm_riscv_sbi_fwft, landing_pad.ena=
ble) /
> +				 sizeof(unsigned long),
> +		.supported =3D kvm_sbi_fwft_landing_pad_supported,
> +		.reset =3D kvm_sbi_fwft_reset_landing_pad,
> +		.set =3D kvm_sbi_fwft_set_landing_pad,
> +		.get =3D kvm_sbi_fwft_get_landing_pad,
> +	},

[Severity: Medium]
Are SBI FWFT flags committed even if the set operation fails?

Looking at kvm_sbi_fwft_set(), the flags are assigned before the
feature-specific set callback is executed:

    conf->flags =3D flags;
    return conf->feature->set(vcpu, conf, false, value);

If the set callback fails and returns an error like SBI_ERR_INVALID_PARAM,
the flags are not rolled back.

If the guest request included SBI_FWFT_SET_FLAG_LOCK, the feature becomes
permanently locked into a stale state, preventing subsequent corrections.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601084336.2601=
675-1-inochiama@gmail.com?part=3D6
