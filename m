Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B82EEC3
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 01:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783905476; cv=none; b=UlRZGDpGlCRcTo0274KTJk0RNWm2la9LKoTfgAVTsQt2HIrASXmzMU1ZNMlaZ3nzvbwDee1iFXVLVTj8qB6yfe+lb7wi73lT5S4CB/HGcajz4lhdsDc/peSOzzHllIDQegdzRcK9RqDat5rs9kZuF4wMHeBJEYVFF8jiQoRCpH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783905476; c=relaxed/simple;
	bh=JHF6ObxcyKJoB6TMHmuV3QzoCagwS+zlO3vED69TcaI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=estCymNWj0OhLAuy1Z8+sEKlRwR54IvqzIoK8OzplheYvDn1utHcrRkrXKTSnOxSW1kRrzHMSgLPk29uxfn+3p+ghpd5qjTHRIExMCgKRgNhXg02OCBa8rgOeseSuD8s++iZ9ZawMLUkhhAWcOXnhYYv5+yShpWpUSe9Db721ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3nElant; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3nElant"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 266211F000E9;
	Mon, 13 Jul 2026 01:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783905475;
	bh=uJ7v2GkSR7wQEOcA1+5wvyLJA4ZAqDyNNvu5mqPbOv8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k3nElant1gHFOK6x4MTU07zfkzN8hN7tkxPMcwWkWC8KSOnjMQGRaj54ePLQ9SH1J
	 qXaL2GQBiCxN0mN9aJdhSp90ziPk2fOBB140XqSf7OUoJhm/laOpZZ4V8MNPJvLQ4F
	 IKjZ3p2NBpigpehF7FcjKeqwZeIAuBILAxXgADfBTVHoyawVks4cOVPsboVaqfjXRf
	 XQ4XEYofckWrmUZtM+91QeB58ikLUzi1kPKl7puzoSG1qoX7+sq6ntKD0sya1rDTz9
	 9DE/md+/ZGAwUY0idRk91ZMoT7VL/wBTkZcO5ri6l7x4W6HWwWolg/tQC928EYrWWA
	 OdLpZK910Ba0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/8] RISC-V: KVM: Delegate SPELP bit to VS/VU mode if
 landing pad is enabled.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260713010302.303278-7-inochiama@gmail.com>
References: <20260713010302.303278-1-inochiama@gmail.com>
 <20260713010302.303278-7-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 01:17:54 +0000
Message-Id: <20260713011755.266211F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The guest's Expected Landing Pad (ELP) state is not exposed to the=
 KVM userspace API, causing silent loss of Forward-Edge CFI protection acro=
ss live migrations.
- [High] KVM fails to initialize ENVCFG_LPE and ENVCFG_SSE in vcpu->arch.cf=
g.henvcfg when the Zicfilp/Zicfiss extensions are enabled, rendering the SP=
ELP trap redirection dead code and silently disabling guest CFI protections.
--

--- Patch [6]: [PATCH v6 6/8] RISC-V: KVM: Delegate SPELP bit to VS/VU mode=
 if landing pad is enabled. ---
commit bd73a6254729060ad92677fe490d23fc4aea31a6
Author: Inochi Amaoto <inochiama@gmail.com>

RISC-V: KVM: Delegate SPELP bit to VS/VU mode if landing pad is enabled.

This commit delegates the SPELP bit from the Zicfilp extension to VS/VU
mode when landing pad support is enabled. It clears and updates the guest
SSTATUS.SPELP bit during trap redirection based on the guest context.

> diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
> --- a/arch/riscv/kvm/vcpu_exit.c
> +++ b/arch/riscv/kvm/vcpu_exit.c

[ ... ]

> @@ -154,6 +154,13 @@ void kvm_riscv_vcpu_trap_redirect(struct kvm_vcpu *v=
cpu,
>  	/* Clear Guest SSTATUS.SIE bit */
>  	vsstatus &=3D ~SR_SIE;
> =20
> +	/* Change Guest SSTATUS.SPELP bit */
> +	if (vcpu->arch.cfg.henvcfg & ENVCFG_LPE) {

[Severity: High]
Will this condition ever be true? Looking at the vCPU initialization
code in kvm_riscv_vcpu_config_ran_once(), it appears KVM does not currently
set ENVCFG_LPE or ENVCFG_SSE in henvcfg when the Zicfilp or Zicfiss
extensions are available.

If ENVCFG_LPE is never initialized, this block becomes dead code, and writes
to the guest's SENVCFG CSR for landing pads would be silently ignored by the
hardware. Should the HENVCFG setup be added to
kvm_riscv_vcpu_config_ran_once() so the guest can successfully enable
CFI protections?

> +		vsstatus &=3D ~SR_SPELP;
> +		vsstatus |=3D vcpu->arch.guest_context.sstatus & SR_SPELP;
> +		vcpu->arch.guest_context.sstatus &=3D ~SR_SPELP;

[Severity: High]
Does this new SPELP state need to be exposed to userspace to prevent
losing the landing pad state across live migrations?

When a guest traps to the hypervisor, the hardware saves the active ELP
state, which KVM now stores in vcpu->arch.guest_context.sstatus. However,
when userspace reads the core registers during migration:

arch/riscv/kvm/vcpu_onereg.c:kvm_riscv_vcpu_get_reg_core() {
        ...
        else if (reg_num =3D=3D KVM_REG_RISCV_CORE_REG(mode))
                reg_val =3D (cntx->sstatus & SR_SPP) ?
                                KVM_RISCV_MODE_S : KVM_RISCV_MODE_U;
        ...
}

The SPELP bit is not extracted, meaning the VMM cannot save or restore
the guest's ELP state. If a migration occurs immediately after an indirect
branch in the guest, would resuming on the destination node with ELP=3D0
silently bypass the Zicfilp CFI hardware check?

> +	}
> +
>  	/* Update Guest SSTATUS */
>  	ncsr_write(CSR_VSSTATUS, vsstatus);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713010302.3032=
78-1-inochiama@gmail.com?part=3D6
