Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792709301;
	b=B8m5zelp/jjvmUrIhH7fvnJXZdv5z3g8EIoUT9hwesG3RdmHKYZPU+I2HMWdd7dbvawX
	 n7Mdq+pUP0fqj7fgC8h5ScfcnRPuaD4rEVAdtNRaVRFgD7D9wqStSO74mChxmFb9KPhv9
	 H5RqVyINwFm3/UZuExI6wfyEZRKcELhTngH1uzcKMfPwNGAGXGQN/GPN6YHOdKEDkCEzz
	 syDN52fklIeihWH/OFeJxWEliGKjEZ07EFEkPeaGrsdSdnY3tNgOQaXqMJFLz40G+GbiT
	 j+IxD6RM8cV8B8E8rsbq+dDn8/Ia2GJyC8eHrh3kgC4krAuUF1GgpuLv72hQHC+JwgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792709301;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SRR5AZJRjY5BhAJtPNriFQ46ubOrRHfSisHWIgLIE8I=;
	b=1stgDdTfDi7x/6yx3aRL+5481Df/rhyF2GIsiZ4FyKJ9ziRMFde4JcmcnbAjcT/Rs/br
	 GhlXa1O9UCL9Jzm3Z0U/AIl6x8+gi31eYVDHcf0/HZUiqAy3/IJhjVOWtIsTlqcE8wCOH
	 CLty39HNFjDwIGfOK0aI+rGIxCPZ6qYaodl68cynL6i4AZ6aAzJ+ohXGH+1rx9zjDJ1L5
	 YnYZu18ov/wDYkNC0KkwNh2d+bg1ggOi3wq++YOqMUd194KtKS9NwxRsCrkpxfaW7GRI9
	 Ct1HXofyGLbRnlmWbXn3s0ncK9mDRmnNgccyFTuIrUPbJkNtfW/V5U0wJDYS9783nYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hJtEUQjE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692B8606A319
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 22:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hJtEUQjE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C098E1F01825;
	Thu, 22 Oct 2026 22:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792709301;
	bh=SRR5AZJRjY5BhAJtPNriFQ46ubOrRHfSisHWIgLIE8I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hJtEUQjEGep9SjjChubrpYjmWkxCp8I0crR3zRULc7thM9JVWliHCAWhdxcnwsVj7
	 OikcJyU9iqASGsudBXRAJpIx+fevgKn8X/jFUsyh3strtBZzbvJDeX9OSJw9ib0UPR
	 DxgqCI9+YlAAbX1Md27X8YW75ekfy7KAWzy9u8yLsKON4wtyG4SRew9GcfwoY2AS20
	 rVgKbJMRnLZ3qNJhVIshkNaw+uzNGpK4kqGS6OFQqtqadWr/xM29Dzb864QTo2DHbf
	 edKfVbfMFCiXGvV3hSBIJBsBX1ca1baltYtVhSO9tfvz7igljfoQiqvgcVoOo7nPIW
	 VP52+PHUR22xQ==
Message-ID: <sashiko-outbox-182134@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] KVM: x86: Recompute EFER.LMA instead of inheriting
 the current value on EFER writes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261022223052.646891-4-seanjc@google.com>
References: <20261022223052.646891-1-seanjc@google.com>
 <20261022223052.646891-4-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 22:48:20 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] KVM: x86: guest-triggerable WARN_ON_ONCE and #GP in set_efer()
--

commit f0c2fa127e8b22e38db4ba12c6a113c1f2ed48a1
Author: Sean Christopherson <seanjc@google.com>

KVM: x86: Recompute EFER.LMA instead of inheriting the current value on EFE=
R writes

This commit recomputes EFER.LMA from EFER.LME, CR0.PG, and CR4.PAE in
set_efer() instead of inheriting the existing EFER.LMA bit from
vcpu->arch.efer. It also adds a WARN_ON_ONCE() check that rejects the write
if the recomputed EFER.LMA differs from the current EFER.LMA in
vcpu->arch.efer.

> diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
> index c3cb1575fe66e..41f3ec6eb2866 100644
> --- a/arch/x86/kvm/msrs.c
> +++ b/arch/x86/kvm/msrs.c
> @@ -638,8 +638,18 @@ static int set_efer(struct kvm_vcpu *vcpu, u64 efer)
>  	    (vcpu->arch.efer & EFER_SVME) && !(efer & EFER_SVME))
>  		return 1;
> =20
> -	efer &=3D ~EFER_LMA;
> -	efer |=3D vcpu->arch.efer & EFER_LMA;
> +	if ((efer & EFER_LME) && is_paging(vcpu) && is_pae(vcpu))
> +		efer |=3D EFER_LMA;
> +	else
> +		efer &=3D ~EFER_LMA;
> +
> +	/*
> +	 * Toggling EFER.LMA on a bare write to EFER should be impossible, as
> +	 * it means KVM allowed architecturally invalid state at some point in
> +	 * the past, i.e. allowed EFER.LMA=3D1 && (!CR0.PG || !CR4.PAE).
> +	 */
> +	if (WARN_ON_ONCE((efer & EFER_LMA) !=3D (vcpu->arch.efer & EFER_LMA)))
> +		return 1;

[Severity: High]
Can a guest or host userspace trigger this WARN_ON_ONCE() and get a spurious
#GP (or failed RSM / KVM_SET_MSRS) via SVM paths that still leave EFER_LMA
in vcpu->arch.efer out of sync with (EFER_LME && CR0.PG && CR4.PAE)?

Earlier in arch/x86/kvm/msrs.c:set_efer(), KVM rejects changing EFER_LME
while paging is enabled:

arch/x86/kvm/msrs.c:set_efer() {
	...
	if (is_paging(vcpu) && (vcpu->arch.efer & EFER_LME) !=3D (efer & EFER_LME))
		return 1;
	...
}

Because of that check, the recomputed EFER_LMA in set_efer() is always equal
to ((vcpu->arch.efer & EFER_LME) && is_paging(vcpu) && is_pae(vcpu)). The n=
ew
WARN_ON_ONCE() therefore triggers whenever a vCPU enters set_efer() with
vcpu->arch.efer & EFER_LMA out of sync with those bits.

There appear to be three SVM paths where that still happens:

1. Nested SVM VMRUN and RSM into L2:

Architecturally on SVM, VMRUN ignores EFER.LMA in the VMCB save area and se=
ts
EFER.LMA from (EFER.LME && CR0.PG) in hardware, so nested_vmcb_check_save()
does not require save->efer & EFER_LMA to match (EFER_LME && CR0.PG):

arch/x86/kvm/svm/nested.c:nested_vmcb_check_save() {
	...
	/*
	 * These checks are also performed by KVM_SET_SREGS,
	 * except that EFER.LMA is not checked by SVM against
	 * CR0.PG && EFER.LME.
	 */
	if ((save->efer & EFER_LME) && (save->cr0 & X86_CR0_PG)) {
		if (CC(!(save->cr4 & X86_CR4_PAE)) ||
		    CC(!(save->cr0 & X86_CR0_PE)) ||
		    CC(!kvm_vcpu_is_legal_cr3(vcpu, save->cr3)))
			return false;
	...
}

However, nested_vmcb02_prepare_save() only clears EFER_LMA when EFER_LME is
0, and relies on svm_set_cr0() to update EFER_LMA:

arch/x86/kvm/svm/nested.c:nested_vmcb02_prepare_save() {
	...
	/* SVM ignores EFER.LMA if EFER.LME=3D0 (instead of failing VMRUN). */
	if (!(svm->nested.save.efer & EFER_LME))
		svm->nested.save.efer &=3D ~EFER_LMA;

	svm_set_efer(vcpu, svm->nested.save.efer);

	svm_set_cr0(vcpu, svm->nested.save.cr0);
	svm_set_cr4(vcpu, svm->nested.save.cr4);
	...
}

And svm_set_cr0() only updates EFER_LMA in vcpu->arch.efer when CR0.PG
transitions relative to the previous vcpu->arch.cr0:

arch/x86/kvm/svm/svm.c:svm_set_cr0() {
	...
	if (vcpu->arch.efer & EFER_LME) {
		if (!is_paging(vcpu) && (cr0 & X86_CR0_PG)) {
			vcpu->arch.efer |=3D EFER_LMA;
			if (!vcpu->arch.guest_state_protected)
				svm->vmcb->save.efer |=3D EFER_LMA | EFER_LME;
		}

		if (is_paging(vcpu) && !(cr0 & X86_CR0_PG)) {
			vcpu->arch.efer &=3D ~EFER_LMA;
			if (!vcpu->arch.guest_state_protected)
				svm->vmcb->save.efer &=3D ~(EFER_LMA | EFER_LME);
		}
	}
	...
}

Because L1 must have CR0.PG=3D1 to execute VMRUN, is_paging(vcpu) is already
true when svm_set_cr0() runs during VMRUN. If vmcb12 has CR0.PG=3D1, CR4.PA=
E=3D1,
EFER.LME=3D1, and EFER.LMA=3D0, svm_set_cr0() never sets EFER_LMA, leaving =
L2
running in 64-bit mode with EFER_LMA=3D0 in vcpu->arch.efer. When L2 execut=
es a
valid WRMSR(MSR_EFER) (for example setting EFER_NX or EFER_SCE) or userspace
calls KVM_SET_MSRS, set_efer() computes EFER_LMA=3D1, triggers WARN_ON_ONCE=
(),
and injects a #GP into L2.

Conversely, during RSM to L2 via emulator_leave_smm() -> svm_leave_smm() ->
enter_svm_guest_mode() -> nested_vmcb02_prepare_save(), emulator_leave_smm()
clears CR0.PG before calling svm_leave_smm(). If vmcb12 has EFER.LME=3D1,
EFER.LMA=3D1, and CR0.PG=3D0, is_paging(vcpu) is already false when svm_set=
_cr0()
runs, leaving EFER_LMA=3D1 with CR0.PG=3D0. When rsm_load_state_64() then c=
alls
__kvm_emulate_msr_write(vcpu, MSR_EFER, smstate->efer & ~EFER_LMA) ->
set_efer(), set_efer() computes EFER_LMA=3D0, triggers WARN_ON_ONCE(), and
aborts RSM with X86EMUL_UNHANDLEABLE.

2. KVM_SET_NESTED_STATE and svm_leave_smm() followed by #VMEXIT:

In arch/x86/kvm/svm/nested.c:svm_set_nested_state(), L1's saved host state =
in
vmcb01->save is only checked for ((save->efer & EFER_LMA) &&
!(save->efer & EFER_LME)) (and svm_leave_smm() copies vmcb01->save from
guest MSR_VM_HSAVE_PA memory without checking EFER_LMA):

arch/x86/kvm/svm/nested.c:svm_set_nested_state() {
	...
	if (!(save->cr0 & X86_CR0_PG) ||
	    !(save->cr0 & X86_CR0_PE) ||
	    (save->rflags & X86_EFLAGS_VM) ||
	    ((save->efer & EFER_LMA) && !(save->efer & EFER_LME)) ||
	    !nested_vmcb_check_save(vcpu, &save_cached, false))
		goto out_free;
	...
}

If vmcb01->save has EFER.LME=3D1, EFER.LMA=3D0, CR0.PG=3D1, and CR4.PAE=3D1=
, then on
nested_svm_vmexit() from a paged L2 (where is_paging(vcpu) is already true),
svm_set_efer() and svm_set_cr0() leave L1 with EFER_LMA=3D0 while EFER_LME=
=3D1,
CR0.PG=3D1, and CR4.PAE=3D1, causing the next WRMSR(MSR_EFER) or KVM_SET_MS=
RS to
trigger the WARN_ON_ONCE() in set_efer().

3. SEV-ES and SEV-SNP write traps:

In arch/x86/kvm/svm/svm.c:cr_trap(), SVM_EXIT_CR0_WRITE_TRAP and
SVM_EXIT_CR4_WRITE_TRAP call svm_set_cr0() and svm_set_cr4() directly witho=
ut
checking consistency between EFER.LMA, CR0.PG, and CR4.PAE:

arch/x86/kvm/svm/svm.c:cr_trap() {
	...
	case 0:
		old_value =3D kvm_read_cr0(vcpu);
		svm_set_cr0(vcpu, new_value);

		kvm_post_set_cr0(vcpu, old_value, new_value);
		break;
	case 4:
		old_value =3D kvm_read_cr4(vcpu);
		svm_set_cr4(vcpu, new_value);

		kvm_post_set_cr4(vcpu, old_value, new_value);
		break;
	...
}

Because svm_set_cr0() sets EFER_LMA without checking is_pae(vcpu) (for
example on an SEV-SNP AP created via SVM_VMGEXIT_AP_CREATE where
sev_snp_init_protected_guest_state() calls kvm_vcpu_reset() and clears
vcpu->arch.cr4 while the VMSA has CR4.PAE=3D1), or if a guest clears CR4.PAE
observed via cr_trap() while EFER_LMA=3D1, a subsequent efer_trap() ->
set_efer() sees EFER_LMA=3D1 with !is_pae(vcpu) and triggers the WARN_ON_ON=
CE()
and #GP.

> =20
>  	r =3D kvm_x86_call(set_efer)(vcpu, efer);
>  	if (r) {

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022223052.6468=
91-1-seanjc@google.com?part=3D3
