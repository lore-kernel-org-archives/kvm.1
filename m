Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C73433ADAF
	for <kvm@vger.kernel.org>; Tue,  1 Sep 2026 08:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788250724; cv=none; b=M0xEPrdRTibfFH880lcsyAbPu4VEy8O3VIrKmdxVk05Dkh6I8qNkWqtBXnO/wn7JQyOnNgq7UC8AjYmuF3vykT4j3UEEPjaqlpfCkMmbJ04H0/IsPbfUkjqsBb+C1iY7caUAD1YgAhH/7mxADSoga45BA9F09LmvVyiRrMWR0Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788250724; c=relaxed/simple;
	bh=lyGbjhPe1JXCoWLayoL5UIBYm3k9VZtgYvlnt257nMU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hZQUwqM/gTZ9/c094Wi/RNztvDCAqG+leZV4ebrBfJNWqffo08FMZvN1FYTaTkNCxT//nTDiMZbtxFUFJWLvRIPeDOiQSdP3wmrIq7FfwN75eSP8oJMub/l8BFxZJg2+hlyVtmWXRqs4O3cpEoRV3lIboHaFT3O0W6XoiZjMraI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTUzMO95; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTUzMO95"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA791F000E9;
	Tue,  1 Sep 2026 08:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788250723;
	bh=r0KbaYxcDLaGGbGhIXyx48BPJa6/0yiRheMaba4T8M8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dTUzMO95irxsGi1BwTqMfgSoEL+akC3QAXUpWkjozAtCAy6E89PobRJJtXp8C3u78
	 H8Bdvl5/wFc2emdGCbyKFzdUzgvUE2Ii0LtlLL4ooxPNgkne+dypONcskkkRJDtUy+
	 ovrEJAGiS992elzKPG1wRC3y8hJ9cdPLDsiYYKNXLiXFpJmlo7/Jj8N+zo/lI1KJ6o
	 OnpXi4AMgkij/ELFTZxlXuDVgwEx684xaERnr2IYuKieJazoxLkfh0XYs8rVuiCgmC
	 2uEXmtKBgyahRwkspB2KoQ7U4EgRXZhvQ8nmwTs1Vfv5uN8e7F7eKd2Vph+laoV5Y7
	 Dm+Tjm7blf+UQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] RISC-V: KVM: Preserve LCOFIP when checking pending
 interrupts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260901080610.91993-1-pengpeng@iscas.ac.cn>
References: <20260901080610.91993-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 08:18:42 +0000
Message-Id: <20260901081842.CEA791F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch fixes the LCOFIP bit shift for pending interrupts in `kv=
m_riscv_vcpu_has_interrupts()`, but fails to fix identical shifting bugs in=
 the `sip` CSR user-space accessors (`kvm_riscv_vcpu_general_get_csr` and `=
kvm_riscv_vcpu_general_set_csr`), breaking live migration and state save/re=
store.
--

commit 303435fe5072a60c37b6dc33685536a2c46952a5
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

RISC-V: KVM: Preserve LCOFIP when checking pending interrupts

KVM injects the guest counter-overflow interrupt into HVIP bit 13 and
records the same bit in irqs_pending. The guest enables it through VSIE
LCOFIE, also at bit 13.

> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index 977e36ab83d3f..bdace86686e1a 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -471,12 +471,14 @@ int kvm_riscv_vcpu_unset_interrupt(struct kvm_vcpu =
*vcpu, unsigned int irq)
>  bool kvm_riscv_vcpu_has_interrupts(struct kvm_vcpu *vcpu, u64 mask)
>  {
>  	unsigned long flags;
> -	unsigned long ie;
> +	unsigned long ie, vsie;
>  	bool ret;
> =20
>  	raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
> -	ie =3D ((vcpu->arch.guest_csr.vsie & VSIP_VALID_MASK)
> -		<< VSIP_TO_HVIP_SHIFT) & (unsigned long)mask;
> +	vsie =3D vcpu->arch.guest_csr.vsie & VSIP_VALID_MASK;
> +	ie =3D ((vsie & ~SIP_LCOFIP) << VSIP_TO_HVIP_SHIFT) |
> +	     (vsie & SIP_LCOFIP);
> +	ie &=3D (unsigned long)mask;

[Severity: High]
This is a pre-existing issue, but does the same LCOFIP bit shift bug also
break the sip CSR user-space accessors in arch/riscv/kvm/vcpu_onereg.c?

Looking at kvm_riscv_vcpu_general_get_csr(), the PMU overflow bit
(IRQ_PMU_OVF, bit 13) in hvip is shifted right by VSIP_TO_HVIP_SHIFT (1) to
bit 12, then masked out by VSIP_VALID_MASK which lacks bit 12:

    *out_val =3D (csr->hvip >> VSIP_TO_HVIP_SHIFT) & VSIP_VALID_MASK;
    *out_val |=3D csr->hvip & ~IRQ_LOCAL_MASK;

The subsequent OR with ~IRQ_LOCAL_MASK clears bits 0-13, dropping it
entirely.

Similarly in kvm_riscv_vcpu_general_set_csr(), when userspace restores sip,
the incoming bit 13 is incorrectly shifted left by 1 to bit 14 before being
written to hvip:

    reg_val &=3D VSIP_VALID_MASK;
    reg_val <<=3D VSIP_TO_HVIP_SHIFT;

Can this silently lose or corrupt the guest PMU overflow interrupt state
during VM live migration or state save/restore when userspace calls
KVM_GET_ONE_REG and KVM_SET_ONE_REG?

>  	ie |=3D vcpu->arch.guest_csr.vsie & ~IRQ_LOCAL_MASK &
>  		(unsigned long)mask;
>  	ret =3D vcpu->arch.irqs_pending[0] & ie;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901080610.9199=
3-1-pengpeng@iscas.ac.cn?part=3D1
