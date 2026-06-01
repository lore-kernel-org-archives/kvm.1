Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A953911DD
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 09:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780306355; cv=none; b=Has5MbnkisBUfGRbzP0VocHYnt9QKKOesL2b9yUqaEMxOsxJbM1UaTacrvSdHF7+arhKmHVq7mVrEQzQNL1v01GQjciITdhCri8BEytR1jpOl5O4h8n0Jrvh3i72IkArESJ2Ilb0mdgNFJpEMAibTDMg+vQj2LLYguoEj1RbZB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780306355; c=relaxed/simple;
	bh=/VIGnar9J2G4yB2DsHIx7tFQr8KmA0FAfn+SOMYC8Mg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ypb2QyZmwPjyf5F5bfIri567g1fYZkuXH/kuZ3XXHdju4zUvedLhzcAoMFglx69HoXeZCi+yLO3alVdRQ1b7+4dXfdLJvjUKAHUVU2GMZSR0r2gOu6HV8UdZODQhIYNJUiF8iqbCwh5kLokQeVoO0j+x2dFpBE1+7C6u5VDGOKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlQ3ewxM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlQ3ewxM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868321F00893;
	Mon,  1 Jun 2026 09:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780306353;
	bh=w/WIbWmSEqryr1+SUiuqXB7hxOx4EnQV25ZDjMdlqm4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hlQ3ewxMAn6bXsOxHAxrlQuWjEYCp0W+God19rwUeyymiYnv2kg/Ounvvy0lxS3hd
	 Yx8ORZwruYzM0+13HOX2ekw+losMysTGL/MmIpH/Qze7AuJbktRZ+nqkJjl35BZvw+
	 +a+bKXgh8V12CUymyIcjYiwig8vz7UnLFLimmaFrDVEoV1MZfdzdzL2iIzcmbW98+k
	 DVVt8l0s3AEqFr73nruTLpM1HU6dkx4IdcRiFJEWJ7L9QO5BaJx+xMpuahydbtP8wQ
	 OGP9d13v+U1V+e4t4arTEwYlvf0/xcqGDIhuNa/75coRNxINbmDbPw2nEOOqORhAvg
	 U/BznwuG/7rLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/7] RISC-V: KVM: Only enable Svadu extension when
 Guest/VM requests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260601084336.2601675-4-inochiama@gmail.com>
References: <20260601084336.2601675-4-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 09:32:33 +0000
Message-Id: <20260601093233.868321F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The FWFT reset callback unconditionally clears ENVCFG_ADUE, br=
eaking the required default state.
- [High] The FWFT supported callback for PTE_AD_HW_UPDATING uses inverted l=
ogic, disabling the feature when both extensions are present.
- [High] Modifying FWFT features via KVM_SET_ONE_REG updates vCPU software =
config but fails to set `vcpu->arch.csr_dirty =3D true`, leading to stale h=
ardware CSR state.
- [High] Probing host hardware support for pointer masking modifies a physi=
cal host CSR (CSR_HENVCFG) with preemption enabled, risking hardware state =
corruption.
- [High] kvm_sbi_fwft_env_flag_set_helper fails to update the upper 32 bits=
 of HENVCFG on 32-bit systems when handling SBI_EXT_FWFT_SET.
- [High] Direct CSR writes in FWFT handlers bypass Nested Architecture for =
Confidential Linux (NaCl) shared memory synchronization.
--

commit 9785e1b9e42d11cc65b0f2a69b673df176c4c687
Author: Inochi Amaoto <inochiama@gmail.com>

RISC-V: KVM: Only enable Svadu extension when Guest/VM requests

This commit removes the default startup initialization of the Svadu
extension in KVM, relying instead on the guest or VM requesting it
through the FWFT interface.

> diff --git a/arch/riscv/kvm/vcpu_config.c b/arch/riscv/kvm/vcpu_config.c
> index 238418fed2b9a..b2a1028106d5d 100644
> --- a/arch/riscv/kvm/vcpu_config.c
> +++ b/arch/riscv/kvm/vcpu_config.c

[ ... ]

> @@ -53,10 +53,6 @@ void kvm_riscv_vcpu_config_ran_once(struct kvm_vcpu *v=
cpu)
>  	if (riscv_isa_extension_available(isa, ZICBOZ))
>  		cfg->henvcfg |=3D ENVCFG_CBZE;
> =20
> -	if (riscv_isa_extension_available(isa, SVADU) &&
> -	    !riscv_isa_extension_available(isa, SVADE))
> -		cfg->henvcfg |=3D ENVCFG_ADUE;
> -

[Severity: High]
This isn't a bug introduced by this patch, but by removing this default
initialization, does this leave guests without an A/D updating mechanism
at boot?

If a platform has SVADU but no SVADE, hardware A/D updating is the only
mechanism available. The FWFT reset handler unconditionally clears ENVCFG_A=
DUE:

arch/riscv/kvm/vcpu_sbi_fwft.c:kvm_sbi_fwft_reset_pte_ad_hw_updating() {
...
	kvm_sbi_fwft_env_flag_reset_helper(vcpu, ENVCFG_ADUE);
...
}

[Severity: High]
This is a pre-existing issue, but does the FWFT supported callback use
inverted logic?

arch/riscv/kvm/vcpu_sbi_fwft.c:kvm_sbi_fwft_pte_ad_hw_updating_supported() {
...
	return riscv_isa_extension_available(vcpu->arch.isa, SVADU) &&
		!riscv_isa_extension_available(vcpu->arch.isa, SVADE);
...
}

If a platform supports both SVADU and SVADE, it can safely toggle between
hardware updating and page faults.=20

However, this logic returns true only when SVADU is present and SVADE is ab=
sent.
Since this patch relies on FWFT as the sole way to enable SVADU, does this
logic prevent it from working on platforms that can actually toggle it?

[Severity: High]
This is a pre-existing issue, but how does the code interact with the FWFT
handlers updating the vCPU software config without setting the dirty flag?

When KVM_SET_ONE_REG modifies an FWFT feature:

arch/riscv/kvm/vcpu_sbi_fwft.c:kvm_sbi_fwft_env_flag_set_helper() {
...
	else if (value =3D=3D 1)
		cfg->henvcfg |=3D flag;
...
	if (!one_reg_access)
		csr_write(CSR_HENVCFG, vcpu->arch.cfg.henvcfg);
...
}

It updates cfg->henvcfg but doesn't set vcpu->arch.csr_dirty =3D true.
If the vCPU is scheduled on the same physical CPU, the load fast-path skips
hardware state restoration:

arch/riscv/kvm/vcpu.c:kvm_arch_vcpu_load() {
...
	else if (vcpu->arch.last_exit_cpu =3D=3D cpu && !vcpu->arch.csr_dirty)
		goto csr_restore_done;
...
}

Does this result in the hardware running with a stale CSR_HENVCFG value unt=
il
the vCPU migrates?

[Severity: High]
This is a pre-existing issue, but looking at the FWFT initialization, does
testing host pointer masking support risk hardware state corruption?

arch/riscv/kvm/vcpu_sbi_fwft.c:try_to_set_pmm() {
...
	csr_set(CSR_HENVCFG, value);
	return (csr_read_clear(CSR_HENVCFG, ENVCFG_PMM) & ENVCFG_PMM) =3D=3D value;
...
}

If the thread is preempted and migrated to a different physical CPU between
csr_set and csr_read_clear, is the first CPU permanently left with the test
bits set in its physical CSR_HENVCFG?

[Severity: High]
This isn't a bug introduced by this patch, but does the FWFT set helper fail
to update the upper 32 bits of HENVCFG on 32-bit systems?

arch/riscv/kvm/vcpu_sbi_fwft.c:kvm_sbi_fwft_env_flag_set_helper() {
...
	if (!one_reg_access)
		csr_write(CSR_HENVCFG, vcpu->arch.cfg.henvcfg);
...
}

Since ENVCFG_ADUE is located at bit 61, wouldn't the hardware state remain
out-of-sync with vcpu->arch.cfg.henvcfg when a 32-bit guest executes an
SBI FWFT SET call?

[Severity: High]
This is a pre-existing issue, but do direct CSR writes in the FWFT handlers
bypass Nested Architecture for Confidential Linux (NaCl) shared memory?

arch/riscv/kvm/vcpu_sbi_fwft.c:kvm_sbi_fwft_env_flag_set_helper() {
...
		csr_write(CSR_HENVCFG, vcpu->arch.cfg.henvcfg);
...
}

and in kvm_sbi_fwft_set_misaligned_delegation():

arch/riscv/kvm/vcpu_sbi_fwft.c:kvm_sbi_fwft_set_misaligned_delegation() {
...
			csr_set(CSR_HEDELEG, MIS_DELEG);
...
}

Should these be using the ncsr_write() wrapper or nacl_csr_write() to ensure
the nested hypervisor's view remains synchronized?

>  	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SMSTATEEN)) {
>  		cfg->hstateen0 |=3D SMSTATEEN0_HSENVCFG;
>  		if (riscv_isa_extension_available(isa, SSAIA))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601084336.2601=
675-1-inochiama@gmail.com?part=3D3
