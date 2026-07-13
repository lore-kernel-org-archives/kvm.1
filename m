Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B36EEC3
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 01:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783905450; cv=none; b=SaB8fdeJopvmjO7WZ1i1Hl47cLjNuoTUpBtyeCmaM84YP5jhPGP9M2NJWwBEod7zDqDNXfA3QybKNCv4N6OQmLDkOu9vyb31h02z/pxYnmOyBHoVMg7CnB57aADNbnWl9eIjNq6myyw1sD9ebDCN2tobKV/bhcs7Gcpd6wP+ZaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783905450; c=relaxed/simple;
	bh=e4gwhnqiXQgIu4WWFBltJbHoHHm7EoK1TiLiAaqrg6c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=la1bPEPusfTnPz95q13D5Yw9U0W40s7gEasVRE1Z9G82s1Pa3vF8IQ+2TyVoPqAgXLZBg3o2Whf5rLxcAAZ17mLjosGBpCxrJyiuskP8o/3TDXYBB/AW1ZzFQIVGVBYZ3XZrpU5mGcvhJWjAeG3sv8B8pDNDevvskg8a8Ojb2Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6oCFJlq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6oCFJlq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852BF1F000E9;
	Mon, 13 Jul 2026 01:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783905448;
	bh=FP48tnZMo1ZRL0D9QWLiPfiBmvfNI8b5fn1SKEFgc8M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H6oCFJlqfJ2rGvGkbpzbEDLRAXrkNEK6m9TEeYiGbdqkRMBUMJT/nrHuO2LZOEE4Y
	 OIxmj2Q2xdEveCUDK6Oge77ZnKRktDksVbYCsutktS1mPLrWidXyArRIUXq/ubciyf
	 Xs9G3p7MajjXguVZBQoYklhOHpL7mAJz+CL0dOp/2PC1E6hitAFyg14IHvDCegwkeW
	 xfE3baf5LqQDlTGbLlPrkN1/wurD3P1F6rUdWv1ZCvffYmpP7Y0Rs78xd+lR4b0OYp
	 4Vb0dqwA2kMsTgq7PQFt/lvAPE9eJfnb0zUoeka7XsWsyIzVRkGDZHbzzu7GizOHMS
	 IiPD2qC72q3qA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/8] RISC-V: KVM: Allow Zicfiss/Zicfilp extensions
 for Guest/VM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260713010302.303278-4-inochiama@gmail.com>
References: <20260713010302.303278-1-inochiama@gmail.com>
 <20260713010302.303278-4-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 01:17:28 +0000
Message-Id: <20260713011728.852BF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing context switch logic and ONE_REG state management for the =
unbanked `CSR_SSP` register (Zicfiss).
- [High] Missing hardware enablement for Zicfiss (`ENVCFG_SSE`) and Zicfilp=
 (`ENVCFG_LPE`) in the hypervisor's `henvcfg` register.
--

--- Patch [3]: [PATCH v6 3/8] RISC-V: KVM: Allow Zicfiss/Zicfilp extensions=
 for Guest/VM ---
commit e9ffdcbcaf04d693405f356426ae62f60a2aa04c
Author: Inochi Amaoto <inochiama@gmail.com>

RISC-V: KVM: Allow Zicfiss/Zicfilp extensions for Guest/VM

This commit extends the KVM ISA extension array to allow userspace to detect
and enable the Zicfiss and Zicfilp extensions for the guest VM.

> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/=
asm/kvm.h
> index 7bbea8812d927..a27de850fa4cc 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
[ ... ]
> @@ -199,6 +199,8 @@ enum KVM_RISCV_ISA_EXT_ID {
>  	KVM_RISCV_ISA_EXT_ZCLSD,
>  	KVM_RISCV_ISA_EXT_ZILSD,
>  	KVM_RISCV_ISA_EXT_ZALASR,
> +	KVM_RISCV_ISA_EXT_ZICFILP,
> +	KVM_RISCV_ISA_EXT_ZICFISS,
>  	KVM_RISCV_ISA_EXT_MAX,
>  };
> =20
> diff --git a/arch/riscv/kvm/isa.c b/arch/riscv/kvm/isa.c
> index 1132d909cc25c..9852a91fdecc9 100644
> --- a/arch/riscv/kvm/isa.c
> +++ b/arch/riscv/kvm/isa.c
[ ... ]
> @@ -65,6 +65,8 @@ static const unsigned long kvm_isa_ext_arr[] =3D {
>  	KVM_ISA_EXT_ARR(ZICBOP),
>  	KVM_ISA_EXT_ARR(ZICBOZ),
>  	KVM_ISA_EXT_ARR(ZICCRSE),
> +	KVM_ISA_EXT_ARR(ZICFILP),

[Severity: High]
Is hardware enablement for Zicfiss and Zicfilp missing in the hypervisor's
henvcfg register?

KVM populates cfg->henvcfg based on enabled ISA extensions here:

arch/riscv/kvm/vcpu_config.c:kvm_riscv_vcpu_config_ran_once() {
    ...
    if (riscv_isa_extension_available(isa, ZICBOM))
        cfg->henvcfg |=3D (ENVCFG_CBIE | ENVCFG_CBCFE);
    ...
}

If ENVCFG_SSE and ENVCFG_LPE are not delegated to henvcfg, will the guest
kernel's attempts to set senvcfg.SSE and senvcfg.LPE silently fail?

This would leave the fields read-only zero in the guest, preventing the
advertised CFI extensions from being used.

> +	KVM_ISA_EXT_ARR(ZICFISS),

[Severity: High]
Will the guest's CSR_SSP register be corrupted when context switching?

When a guest with Zicfiss enabled sets a valid shadow stack pointer in
CSR_SSP, and a VM exit occurs, the host scheduler may preempt the KVM vCPU
thread.

The host's exception return path overwrites CSR_SSP for the new process, and
upon switching back, the host's exception entry path zeroes CSR_SSP.

Since the C-level CSR context switch logic in
kvm_riscv_vcpu_swap_in_guest_state() and the assembly path in
__kvm_riscv_switch_to() lack save/restore operations for CSR_SSP:

arch/riscv/kvm/vcpu_switch.S:__kvm_riscv_switch_to() {
    ...
    SAVE_HOST_AND_RESTORE_GUEST_CSRS .Lkvm_switch_return
    ...
    SAVE_GUEST_AND_RESTORE_HOST_CSRS
    ...
}

Does this cause the guest to resume with a zeroed CSR_SSP and crash on its
next CFI instruction? Should CSR_SSP also be exposed via the ONE_REG
interface for state management?

>  	KVM_ISA_EXT_ARR(ZICNTR),
>  	KVM_ISA_EXT_ARR(ZICOND),
>  	KVM_ISA_EXT_ARR(ZICSR),

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713010302.3032=
78-1-inochiama@gmail.com?part=3D3
