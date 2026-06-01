Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EE53ACA7C
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 09:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780307910; cv=none; b=jEzuGUyOpI//zFmpFwLdUhxeGp2FQBpTXUJp20IWcEVQogmJ6+veTC6R+2f685vprg4O1U05WmlIX3mcC8mqPbiJYcBUS/aer+HMZMeaSPn8JqKP7eSWGQGf1FGNTOuH9zGTqa+TjoQHF0/5E6XDuqoOZodnDqeIV9IrOSBsams=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780307910; c=relaxed/simple;
	bh=p9GbXbyeUZ6Hga2c6m4Z2W6lvANVadmWWij95pgm3RA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=biowxe1aOGw3ogd37yH+O3t/XFoS9eKXE0M1YJMB3HHBj0exC6Y1KvwCcSk1G/R2EmoKVCBn/gdWKTqqZqlHNl0fupTcO2IGo66TlErXIuxJr0V6llbVlG/5TUcb1I9Wc267aAJ47rdMdDwv4/5lkhYzzQwa2nEJBhQz8d/Xw0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dB82l5OP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dB82l5OP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B2C1F00893;
	Mon,  1 Jun 2026 09:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780307900;
	bh=+ePpH6dnXLQhA5XgBaNlXyfUIYbMj9tvu9WbEEgdQQY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dB82l5OPZGXQpFI5BEsoWV+Bn4CqzOm7hqBI8H+CAUC2xliJXbpVPimkprF3wkmmZ
	 wNcTjLehN1i4rlntGkyA7MyhnmZaqqWMVhsMLMuV/cyNb/03HTHHmaTMhslrJp9Tx/
	 nDfjQKHgsO3ut3yyR7APwpGuj7333GQHFC4HwAW+Cise2nyVEerBnYocuKTdZT35HB
	 dUUe0YSVTksxyY3sUJezrX+i4FRjXojCrWY0PKz7nl1M62+x/N3a/74MkWEDch+2Qi
	 Dp3Eb1l3yS+mWL49NHGJ87f5EV5rACflP1mZjHrUpTIls7PuCqY121sBK2fPoUx6ur
	 dEQPXdUbcs93A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/7] RISC-V: KVM: Handle software-check exits for
 VCPU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260601084336.2601675-6-inochiama@gmail.com>
References: <20260601084336.2601675-6-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 09:58:19 +0000
Message-Id: <20260601095820.62B2C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] KVM fails to context-switch the Shadow Stack Pointer (CSR_SSP), le=
ading to cross-VCPU leaks and guest shadow stack corruption.
- [High] KVM fails to propagate the SPELP (Supervisor Previous Expected Lan=
ding Pad) bit when redirecting traps to the guest, breaking guest CFI track=
ing.
- [Medium] KVM unconditionally redirects EXC_SOFTWARE_CHECK to the guest up=
on VM exit, which will inject an un-enumerated exception into guests that h=
ave not negotiated the Zicfilp/Zicfiss extensions.
--

commit bea0e82f22f5523f333dc995d01ccbe77f69b200
Author: Inochi Amaoto <inochiama@gmail.com>

RISC-V: KVM: Handle software-check exits for VCPU

This commit enables the software-check exception for RISC-V KVM, delegating
it to VS mode so CFI violations (Zicfiss/Zicfilp) can be reported to the
guest.

> diff --git a/arch/riscv/kvm/vcpu_config.c b/arch/riscv/kvm/vcpu_config.c
> index b2a1028106d5d..dbe4167ac4f16 100644
> --- a/arch/riscv/kvm/vcpu_config.c
> +++ b/arch/riscv/kvm/vcpu_config.c

[ ... ]

> @@ -65,6 +65,10 @@ void kvm_riscv_vcpu_config_ran_once(struct kvm_vcpu *v=
cpu)
> =20
>  	if (vcpu->guest_debug)
>  		cfg->hedeleg &=3D ~BIT(EXC_BREAKPOINT);
> +
> +	if (riscv_isa_extension_available(isa, ZICFILP) ||
> +	    riscv_isa_extension_available(isa, ZICFISS))
> +		cfg->hedeleg |=3D BIT(EXC_SOFTWARE_CHECK);

[Severity: High]
The Zicfiss extension introduces the CSR_SSP (Shadow Stack Pointer) registe=
r,
which is a user-mode CSR and isn't automatically saved or restored by the
hardware on VM exits.

If KVM does not manually context-switch this register in=20
arch/riscv/kvm/vcpu.c:kvm_riscv_vcpu_context_switch() or during VCPU load/p=
ut
paths, could a new VCPU inherit the previous VCPU's CSR_SSP and leak state
across VMs?

Additionally, when returning to host userspace, won't the host kernel's
exception return code overwrite CSR_SSP with the host process's shadow stack
pointer, leading to an immediate crash upon re-entry to the guest?

>  }

> diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
> index 0bb0c51e3c890..5ab8e87ed248b 100644
> --- a/arch/riscv/kvm/vcpu_exit.c
> +++ b/arch/riscv/kvm/vcpu_exit.c

[ ... ]

> @@ -243,6 +243,9 @@ int kvm_riscv_vcpu_exit(struct kvm_vcpu *vcpu, struct=
 kvm_run *run,
>  		run->exit_reason =3D KVM_EXIT_DEBUG;
>  		ret =3D 0;
>  		break;
> +	case EXC_SOFTWARE_CHECK:
> +		ret =3D vcpu_redirect(vcpu, trap);

[Severity: Medium]
This unconditionally redirects EXC_SOFTWARE_CHECK back to the guest.

If a guest has not negotiated the Zicfilp/Zicfiss extensions, KVM won't
delegate EXC_SOFTWARE_CHECK via hedeleg.

If an unexpected CPU state or hardware issue triggers this exception in
VS-mode and traps to HS-mode, this redirect will inject an un-enumerated
exception into the guest.

Does this code need to verify riscv_isa_extension_available() before
redirecting the trap?

[Severity: High]
When a trap occurs in VS/VU-mode and is taken to HS-mode, the hardware
records the previous Zicfilp ELP state in the host sstatus.SPELP bit, which
KVM subsequently saves into vcpu->arch.guest_context.sstatus.

When vcpu_redirect() is called here, it eventually invokes
kvm_riscv_vcpu_trap_redirect(), which updates the guest's VSSTATUS register:

arch/riscv/kvm/vcpu_exit.c:kvm_riscv_vcpu_trap_redirect() {
    ...
    unsigned long vsstatus =3D ncsr_read(CSR_VSSTATUS);

    vsstatus &=3D ~SR_SPP;
    if (vcpu->arch.guest_context.sstatus & SR_SPP)
        vsstatus |=3D SR_SPP;
   =20
    ncsr_write(CSR_VSSTATUS, vsstatus);
    ...
}

Since kvm_riscv_vcpu_trap_redirect() explicitly copies SPP, SPIE, and SIE
but does not copy the SPELP bit (SR_SPELP), does this cause the guest OS to
lose its Zicfilp CFI tracking state across KVM-injected traps?

> +		break;
>  	default:
>  		break;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601084336.2601=
675-1-inochiama@gmail.com?part=3D5
