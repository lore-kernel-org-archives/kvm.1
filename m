Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B5A3AF643
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 18:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784571644; cv=none; b=G5OomBL0BgEugrHaFIL3CRq+7RUd2fRv7vxOCDsQb5ZOvEQLfKxub2K6+A30IVaSkS4b6gPTJLs6EolFrKm29vg5K1xLOaUyiY3CZ2pdDUCcxiTiXB7c/0NbgIk1QZ8C/tOxXzKzWRg1IlILloqJPeXNfpEOHwKFcI3pazta50A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784571644; c=relaxed/simple;
	bh=JhKtvWMB9wGkWWwCvhqDI+5/UbU/83Z5I8kd8DGWnDA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JsjIU5jzLOWtILzF1hRbU7x0Wx9wEVv3xH0c68mRs1Hy4Y/XBh06+InHxN88Dn4vVmBGIAG0X8adUfYeiR9hqaRXwofndmJsM0vDY5qQeOaXyxFXJSXybj7oHApVVJt4F0Ja6TZ80ufvjpYTBxOvXDxJencHkiAKWCoUAO8RF4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAtb+XBw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAtb+XBw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1731F000E9;
	Mon, 20 Jul 2026 18:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784571642;
	bh=0LgvggfX32HjAcw+LW+wZ9x7dlkRwBCYJNMaEHSGwlY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bAtb+XBwAdyI7yygoQhO6kaB59D7hz+1INq+rvrXpjGhbpBuyUpLjXwp2Kfs3YEvv
	 HDHa2gci5ek+iTPBByrHDwQtfsB3k5WOkaMK0keMp0qjBbDi6PFQQWg6GnTWPwl4Fk
	 fGByjv0UTvePj2LqKvQbKni3uI5+NgAZRK3jsGhseZRgghPecuWpcwcDEelKOO5qFs
	 TdEBgPeT1Hw/CC4aRieT8s4vtb6Lz2IgWPyMmg9CiMM/pFA8P29rvdC6KHGv83ViYy
	 B7N8RDCX2+EuuYE/mTm15YFLw6udJZAS5B+WDdvUvJ+gzin8qDc9QbR2SHnKpl8uP6
	 97zt1HoUZOsow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/20] KVM: VMX: Save guest EGPRs in VCPU cache
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260720171949.498680-3-chang.seok.bae@intel.com>
References: <20260720171949.498680-1-chang.seok.bae@intel.com>
 <20260720171949.498680-3-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 18:20:42 +0000
Message-Id: <20260720182042.9D1731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] Guest EGPRs (R16-R31) are saved to `vcpu->arch.regs` on VM-exi=
t but are never synchronized with the guest's XSTATE buffer (`vcpu->arch.gu=
est_fpu`), resulting in complete state loss and data corruption during live=
 migration.
- [Critical] Running KVM C exit handlers with the guest's XCR0 will cause a=
 host #UD panic if the host kernel uses APX instructions and the guest disa=
bles APX.
- [High] Guest EGPRs are left in physical registers during the VM-exit spec=
ulation window, bypassing the existing mitigation that clears other GPRs.
- [High] Leaving host values in EGPRs (r16-r31) on VM-entry when the guest =
has not enabled APX creates a speculative information leak from host to gue=
st.
- [Medium] The patch loads guest EGPRs on VM-entry before restoring the gue=
st's SPEC_CTRL, directly contradicting the commit message's safety rational=
e and breaking the speculation barrier.
--

--- Patch [2]: [PATCH v5 02/20] KVM: VMX: Save guest EGPRs in VCPU cache ---
commit a925787d28df5e47adae8863318b050fa84c23f1
Author: Chang S. Bae <chang.seok.bae@intel.com>

KVM: VMX: Save guest EGPRs in VCPU cache

This commit introduces support for saving and restoring guest EGPRs on
VM exit and entry when the system supports Advanced Performance Extensions
(APX). The registers are explicitly saved and loaded from the
vcpu->arch.regs cache rather than relying on lazy FPU switching.

Link: https://lore.kernel.org/adPRA4ZhnvbaXSn0@google.com

>     The register restore path is placed after SPEC_CTRL is restored, so as
>     to avoid any mis-speculation into EGPR accesses when APX is disabled.

[Severity: Medium]
Does the placement in the code match this description?

Looking at __vmx_vcpu_run() in arch/x86/kvm/vmx/vmenter.S, the EGPR load
sequence is placed before RESTORE_GUEST_SPEC_CTRL_BODY, which contradicts
this statement and could expose the host to speculative execution using
guest EGPR values.

[ ... ]

> diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
> index 00d807505fc88..702d86ade6b1d 100644
> --- a/arch/x86/kvm/vmx/vmenter.S
> +++ b/arch/x86/kvm/vmx/vmenter.S
[ ... ]
> @@ -46,6 +47,16 @@ SYM_FUNC_START(__vmx_vcpu_run)
>  	/* Reload @vmx, _ASM_ARG1 may be modified by vmx_update_host_rsp().  */
>  	mov WORD_SIZE(%_ASM_SP), %_ASM_DI
> =20
> +#ifdef CONFIG_KVM_APX
> +	ALTERNATIVE "jmp .Lload_egprs_done", "", X86_FEATURE_APX
> +	testl	$KVM_ENTER_EGPR_SWITCH, (%_ASM_SP)
> +	jz	.Lload_egprs_done

[Severity: High]
Does taking this jump create a speculative information leak?

If the guest disabled APX, we skip loading guest EGPRs but do not clear
the host's values from the physical registers.

While the guest architecturally cannot read these registers without
triggering a #UD, could it execute an APX instruction speculatively before
the #UD is recognized, potentially exfiltrating sensitive host kernel data?

> +	LOAD_REGS %_ASM_DI, VMX_vcpu_arch_regs, \
> +		  %r16, %r17, %r18, %r19, %r20, %r21, %r22, %r23, \
> +		  %r24, %r25, %r26, %r27, %r28, %r29, %r30, %r31
> +.Lload_egprs_done:
> +#endif
> +
>  	/*
>  	 * Unlike AMD there's no V_SPEC_CTRL here, so do not leave the body
>  	 * out of line.  Clobbers RAX, RCX, RDX, RSI.
[ ... ]
> @@ -193,8 +204,24 @@ SYM_INNER_LABEL_ALIGN(vmx_vmexit, SYM_L_GLOBAL)
>  	mov %_ASM_BX, %_ASM_AX
> =20
>  	/* Pop our saved arguments from the stack */
> -	pop %_ASM_BX
> -	pop %_ASM_BX
> +	pop %_ASM_BX	/* @flags */
> +	pop %_ASM_DI	/* @vmx */
> +
> +#ifdef CONFIG_KVM_APX
> +	ALTERNATIVE "jmp .Lclear_egprs_done", "", X86_FEATURE_APX
> +	test	$KVM_ENTER_EGPR_SWITCH, %_ASM_BX
> +	jz	.Lclear_egprs_done

[Severity: High]
Are guest EGPRs left in physical registers during the VM-Exit speculation
window?

In vmx_vmexit, KVM clears legacy GPRs at .Lclear_regs earlier in the exit p=
ath
to prevent their use in speculative execution.

By deferring the save and clear of EGPRs until here, well after the
speculation barriers (like lfence), are we leaving these 16 guest-controlled
registers accessible during the mitigation execution window?

> +	/*
> +	 * Unlike legacy GPRs, saving could be conditional here on VM-Fail,
> +	 * which however isn't in fastpath. Instead, simply saving EGPRs always.
> +	 */
> +	STORE_REGS %_ASM_DI, VMX_vcpu_arch_regs, \
> +		   %r16, %r17, %r18, %r19, %r20, %r21, %r22, %r23, \
> +		   %r24, %r25, %r26, %r27, %r28, %r29, %r30, %r31
> +	CLEAR_REGS %r16d, %r17d, %r18d, %r19d, %r20d, %r21d, %r22d, %r23d, \
> +		   %r24d, %r25d, %r26d, %r27d, %r28d, %r29d, %r30d, %r31d

[Severity: Critical]
Will this cause data corruption of the EGPR state across live migration?

Because hardware EGPRs are zeroed here, KVM's subsequent host XSAVES in
fpu_swap_kvm_fpstate() will commit zeroes into the guest's FPU state buffer
(vcpu->arch.guest_fpu).

When userspace calls KVM_GET_XSAVE2 to migrate the state, it will copy the
zeroed buffer via fpu_copy_guest_fpstate_to_uabi() since the actual active =
APX
state stored in vcpu->arch.regs is never synchronized.

On the destination, userspace calls KVM_SET_XSAVE, but __vmx_vcpu_run()
ignores the restored FPU buffer for EGPRs and unconditionally loads from the
uninitialized vcpu->arch.regs, completely losing the state.

> +.Lclear_egprs_done:
> +#endif
> =20
>  	/* ... and then the callee-save registers */
>  	pop %_ASM_BX
[ ... ]
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 3681d565f1778..1c86919d14d45 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
[ ... ]
> @@ -991,6 +991,19 @@ unsigned int __vmx_vcpu_enter_flags(struct vcpu_vmx =
*vmx)
>  	    kvm_vcpu_can_access_host_mmio(&vmx->vcpu))
>  		flags |=3D KVM_ENTER_CLEAR_CPU_BUFFERS_FOR_MMIO;
> =20
> +	/*
> +	 * KVM intercepts XSETBV and thus always tracks the guest XCR0. EGPR
> +	 * save/restore is gated by this flag. The resulting behavior is:
> +	 *
> +	 *  - When the guest enables APX, KVM restores EGPRs (initially zeroed).
> +	 *  - When the guest disables APX, EGPRs are preserved in the VCPU cach=
e.
> +	 *  - When APX is re-enabled, the saved state is restored, which matches
> +	 *    architectural expectations.
> +	 */
> +	if (IS_ENABLED(CONFIG_KVM_APX) && cpu_feature_enabled(X86_FEATURE_APX) =
&&
> +	    vmx->vcpu.arch.xcr0 & XFEATURE_MASK_APX)
> +		flags |=3D KVM_ENTER_EGPR_SWITCH;
> +

[Severity: Critical]
Can an unprivileged guest crash the host by clearing XCR0[APX]?

Host XCR0 is restored only after executing a significant amount of
compiler-generated C code. For example, in arch/x86/kvm/x86.c:

vcpu_enter_guest() {
    ...
    exit_fastpath =3D kvm_x86_call(vcpu_run)(vcpu, run_flags);
    ...
    kvm_load_xfeatures(vcpu, false);
    ...
}

If the host kernel is compiled with APX support, the compiler may emit EGPR
instructions in these generic C exit handlers (like vmx_vcpu_run).

If the guest disabled APX, the physical CPU will have APX disabled during
VM-Exit. When the host executes these APX instructions before XCR0 is
restored, won't the CPU immediately raise a #UD and panic the kernel?

>  	return flags;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720171949.4986=
80-1-chang.seok.bae@intel.com?part=3D2
