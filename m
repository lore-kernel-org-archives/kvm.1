Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793143022;
	b=M+C7wVNf669MOQXv1ZOJDpqeVfHqeSO8fLcYLQFciXQCt3A4bQuXIcfnEnFSPc8AcUWI
	 pBMot4dC7Bn8g3NZq5JlUERzJS9KN5c+A9EF+NZWJCPqVg7ZQ6Er08A4CZksuiFIyuuto
	 sTKli3qxrJZ+bVTi2tFtpgCRm8b4uCX5EiyN+THGEIDhR2zvnfSo+waDbpnhR+TSC0LSG
	 Vg+PhIG1ZKoGYL20vUPhsCgjTsSZB2qaWsLeJ3mp6ovZ9y1KgeHnr8iZvQO4XmY53UlVB
	 nBhPcFz0sz0Jc0HtHTuAUVNOSo9FVgc7Tz135nVG2oAx2mHijCNOflwTvEgr4ouhDyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793143022;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qRhVMaf1rSJj1yr1oMLzr8S4N4fdZyR12NoPdNbj59o=;
	b=GIovsJL/lCAzIckFL/lN7vJiOrC2JNVueOAV4zvqdmlBtF6gXkRevos0CJBa/PNo5yDq
	 2cHC2Dx+acD5E3GYcwbyz0UFsQEusv3VwXJfQ3wTYFJ4otYU73Fk/miTtk/VhWInIpLLp
	 a9Xnkr7GB1fhDn+heicY/x3nK4oeTAPSRv4BZLnxhDJ7i8yhVgfJI7/PnXMt3xPx+rIQC
	 gLyHXXyrupda9wv2pzYkYJW28BugljnKSbNDmJwhE3jOcXYnaHHYR9Un43cl72CF0RIag
	 9N/6+YNP2u4VKhkp8YkZYw/S6vBNnlwbVFjDh2LscB18QcWvx0ehG7YQZrzbtDUItZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MBKSH5CL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDD3606A31D
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 23:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MBKSH5CL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247B01F01825;
	Tue, 27 Oct 2026 23:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793143021;
	bh=qRhVMaf1rSJj1yr1oMLzr8S4N4fdZyR12NoPdNbj59o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MBKSH5CLA3X29omnjWVTKLkDGGnBi84J6yv5/q+6nCqeeY8HDuwcVX2rB34PQjVFw
	 Tl0BMr82n3UfWjDbTjbJEvsEPEe3JD3912rfvDVFh+A0E6KRbx4mbE6dpmjRqacNli
	 zPG9ms25EUgKIRFXxLJa/fScFBELCxsJk97zVJOIAPerAMafg9VBgyCbKNFXdBS2Xq
	 FAF6YBvNVQlfO7oP51WWONHveoGCAOBEs/woGLUBJIzrN4awR2MhaonZ0yIxB0lY6G
	 r9gozAWGHa52nDmpOhYPS6UgGcmrP/5OASf0/IA3fR33iKGNbK395Qb6vu9zfPQEt5
	 E3rioqosWITpQ==
Message-ID: <sashiko-outbox-187201@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] KVM: x86: Recompute EFER.LMA instead of
 inheriting the current value on EFER writes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261027224914.1574319-5-seanjc@google.com>
References: <20261027224914.1574319-1-seanjc@google.com>
 <20261027224914.1574319-5-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 23:17:00 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] kvm: x86: guest- and userspace-reachable WARN_ON_ONCE() in set_efe=
r()
- [High] kvm: x86: missing MMU context reset in set_efer() when EFER_LMA ch=
anges
- [High] KVM: nSVM: guest-reachable WARN_ON_ONCE in set_efer() due to stale=
 EFER.LMA
--

commit d17bdc446bf3834407b9fa79da8f4a4f619465b7
Author: Sean Christopherson <seanjc@google.com>

KVM: x86: Recompute EFER.LMA instead of inheriting the current value on EFE=
R writes

This commit recomputes EFER.LMA from EFER.LME, CR0.PG, and CR4.PAE on bare
writes to MSR_EFER instead of inheriting the existing EFER.LMA bit from
vcpu->arch.efer, and adds a WARN_ON_ONCE() if EFER.LMA changes.

> diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
> index c3cb1575fe66e..c55402970a345 100644
> --- a/arch/x86/kvm/msrs.c
> +++ b/arch/x86/kvm/msrs.c
> @@ -638,8 +638,17 @@ static int set_efer(struct kvm_vcpu *vcpu, u64 efer)
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
> +	WARN_ON_ONCE((efer & EFER_LMA) !=3D (vcpu->arch.efer & EFER_LMA));

[Severity: High]
Can an unprivileged guest or host userspace trigger this WARN_ON_ONCE() in
arch/x86/kvm/msrs.c:set_efer() by leaving vcpu->arch.efer with a stale
EFER_LMA across nested SVM transitions?

On AMD SVM, VMRUN ignores EFER.LMA in the VMCB save area and computes it
from (EFER.LME && CR0.PG), so arch/x86/kvm/svm/nested.c:nested_vmcb_check_s=
ave()
does not require save->efer's EFER_LMA to match (EFER.LME && CR0.PG).

In arch/x86/kvm/svm/nested.c:nested_vmcb02_prepare_save(), KVM only clears
EFER_LMA when EFER_LME is 0, and relies on svm_set_cr0() to update EFER_LMA
when EFER_LME is 1:

arch/x86/kvm/svm/nested.c:nested_vmcb02_prepare_save() {
	/* SVM ignores EFER.LMA if EFER.LME=3D0 (instead of failing VMRUN). */
	if (!(svm->nested.save.efer & EFER_LME))
		svm->nested.save.efer &=3D ~EFER_LMA;

	svm_set_efer(vcpu, svm->nested.save.efer);

	svm_set_cr0(vcpu, svm->nested.save.cr0);
	svm_set_cr4(vcpu, svm->nested.save.cr4);
}

However, arch/x86/kvm/svm/svm.c:svm_set_cr0() only updates EFER_LMA when
CR0.PG changes relative to the previous vcpu->arch.cr0 (is_paging(vcpu)):

arch/x86/kvm/svm/svm.c:svm_set_cr0() {
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
}

This allows vcpu->arch.efer's EFER_LMA to become out of sync with
(EFER.LME && CR0.PG && CR4.PAE) in several ways:

1. Guest VMRUN (nested_svm_vmrun() -> enter_svm_guest_mode() ->
nested_vmcb02_prepare_save()): L1 must have CR0.PG=3D1 to execute VMRUN, so
is_paging(vcpu) is already true when nested_vmcb02_prepare_save() runs. If
L1 sets vmcb12->save with EFER_LME=3D1, EFER_LMA=3D0, CR0.PG=3D1, CR0.PE=3D=
1, and
CR4.PAE=3D1, svm_set_efer() loads EFER_LMA=3D0 into vcpu->arch.efer (and al=
so
clears EFER_LME in vmcb02->save.efer when !npt_enabled), and svm_set_cr0()
sees !is_paging(vcpu) =3D=3D false and never sets EFER_LMA. L2 is left with
EFER_LME=3D1, EFER_LMA=3D0, CR0.PG=3D1, CR4.PAE=3D1 (which also truncates L=
2's
64-bit RSP and RIP to 32 bits and configures the MMU for 32-bit PAE), and
a subsequent WRMSR(MSR_EFER) in L2 (or KVM_SET_MSRS from userspace)
computes EFER_LMA=3D1 and trips the WARN_ON_ONCE() in set_efer().

2. Guest RSM into L2 (emulator_leave_smm() -> svm_leave_smm() ->
enter_svm_guest_mode() -> nested_vmcb02_prepare_save() ->
rsm_load_state_64()): emulator_leave_smm() clears CR0.PG before calling
svm_leave_smm(), so is_paging(vcpu) is false. If vmcb12->save in guest
memory has EFER_LME=3D1, EFER_LMA=3D1, and CR0.PG=3D0, nested_vmcb02_prepar=
e_save()
does not clear EFER_LMA and svm_set_cr0() sees is_paging(vcpu) =3D=3D false=
 and
leaves EFER_LMA=3D1 in vcpu->arch.efer while CR0.PG=3D0. Immediately after
svm_leave_smm() returns, arch/x86/kvm/smm.c:rsm_load_state_64() calls
__kvm_emulate_msr_write(vcpu, MSR_EFER, smstate->efer & ~EFER_LMA) ->
set_efer(), which computes EFER_LMA=3D0 and triggers the WARN_ON_ONCE().

3. KVM_SET_NESTED_STATE or SMM HSAVE restoration followed by nested #VMEXIT
(svm_set_nested_state() / svm_leave_smm() -> nested_svm_vmexit()):
arch/x86/kvm/svm/nested.c:svm_set_nested_state() requires CR0.PG=3D1 in L1's
saved host state (vmcb01->save) and rejects (EFER_LMA && !EFER_LME), but
allows EFER_LME=3D1 with EFER_LMA=3D0:

arch/x86/kvm/svm/nested.c:svm_set_nested_state() {
	if (!(save->cr0 & X86_CR0_PG) ||
	    !(save->cr0 & X86_CR0_PE) ||
	    (save->rflags & X86_EFLAGS_VM) ||
	    ((save->efer & EFER_LMA) && !(save->efer & EFER_LME)) ||
	    !nested_vmcb_check_save(vcpu, &save_cached, false))
		goto out_free;
}

When exiting from a paged L2 (is_paging(vcpu) =3D=3D true),
arch/x86/kvm/svm/nested.c:nested_svm_vmexit() calls
svm_set_efer(vcpu, vmcb01->save.efer) followed by
svm_set_cr0(vcpu, vmcb01->save.cr0 | X86_CR0_PE), leaving L1 with
EFER_LME=3D1, EFER_LMA=3D0, CR0.PG=3D1, CR4.PAE=3D1 and triggering the
WARN_ON_ONCE() on the next MSR_EFER write.

4. SEV-SNP AP creation (sev_snp_ap_creation() ->
KVM_REQ_UPDATE_PROTECTED_GUEST_STATE -> kvm_vcpu_reset()): svm_set_cr0()
sets EFER_LMA without checking is_pae(vcpu) while vcpu->arch.cr4 still has
CR4.PAE=3D0, allowing a subsequent trapped EFER write via efer_trap() to
trigger the WARN_ON_ONCE().

> =20
>  	r =3D kvm_x86_call(set_efer)(vcpu, efer);
>  	if (r) {

[Severity: High]
When set_efer() toggles EFER_LMA to restore architectural consistency,
doesn't it also need to reset the MMU context if EFER_LMA changed?

At the end of arch/x86/kvm/msrs.c:set_efer(), KVM only calls
kvm_mmu_reset_context(vcpu) when bits in KVM_MMU_EFER_ROLE_BITS change:

arch/x86/kvm/msrs.c:set_efer() {
	...
	if ((efer ^ old_efer) & KVM_MMU_EFER_ROLE_BITS)
		kvm_mmu_reset_context(vcpu);
}

However, KVM_MMU_EFER_ROLE_BITS in arch/x86/kvm/mmu.h is defined as
(EFER_LME | EFER_NX) and does not include EFER_LMA, even though
arch/x86/kvm/mmu/mmu.c:kvm_calc_cpu_role() computes role.base.level,
role.ext.efer_lma, role.ext.cr4_pke, and role.ext.cr4_la57 from
____is_efer_lma(regs).

Because set_efer() rejects any write that modifies EFER_LME while
is_paging(vcpu) is true, ((efer ^ old_efer) & EFER_LME) is always 0 when
paging is enabled. If EFER_LMA is toggled by set_efer() while EFER_NX is
unchanged, ((efer ^ old_efer) & KVM_MMU_EFER_ROLE_BITS) evaluates to 0 and
kvm_mmu_reset_context(vcpu) is skipped, leaving the vCPU's MMU role and root
level stale relative to the updated vcpu->arch.efer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027224914.1574=
319-1-seanjc@google.com?part=3D4
