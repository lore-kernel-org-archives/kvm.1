Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793663144;
	b=MIBHaeu9X53ip9M3MTFkKiHi7UfYN8ZUYrCQIF/BGgdMAkQqvb4bhlsXYu6mNfp++ms5
	 IYfwjUlH9tke4jUodPF34wReQ3Y+YMzW53WU2GWqGWKUwjqOCEY/YtUVpWLV+46af+1sI
	 eIEEXG+b22p1UHfIixEwAHpTZIuZXMrrcxyTKcw0n1+SFplxiUZEGpdJEACr1fjaC1vmB
	 Ef1/ZQkubK1uyuKb0auOE46WjKRxour+37pMV7XGNCrrJzaQFhC/5WQ5MFTKT7jUjspn1
	 Oc1JiyyDEntaDk4ZGG6od7dM1AK0FMfYEGKlRe6Qu6DtvokaRPRlqeAeRosq3KTgynQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793663144;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cydPqjS7zIpdqX/JZBUqb3TvWHb6Ds1pOCgWILuFeBg=;
	b=Xdm5gMMc9K4343Z/yEDxeDgedEA/R1NP0FVbrqF+ideS2ETrcMLtxMPR6F1kPwfOEndM
	 OTLzmKxuuFOQOrMoKYmF2seVziA7h52Q6mbNU7w4BaIaqbIZEqZOipIWTI88hhW9H9tmL
	 tg0fiQbFZh+KNncoeDP77921mPHGYP9DtMLvJ0pNElKpb6UyPm/r8DAoGCzs8Zd2olNLe
	 CcoSHjRzJtXTxu2ljJYiTHOFq39hk8kb713wB9zF5KlhwAFrvNgFtKbP6k5f1C+21iLba
	 qgBvXOUa3y/lSotMIcAGc+qx8xu8Olc0EmuJfbK8KRusHdkU+kth6ArlKWvrt97r83Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nD9VEwfi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE5E606A324
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 23:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nD9VEwfi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E52E1F00A16;
	Mon,  2 Nov 2026 23:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793663143;
	bh=cydPqjS7zIpdqX/JZBUqb3TvWHb6Ds1pOCgWILuFeBg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=nD9VEwfiZwn0RI/6YTIOI1EFW21xC6bYlPbwp5Ybyam1iX7nexmKZRvmb/UhANItI
	 ddyNMvYBYfkMpp41TgkYLrV3gRnA0F/vy+RATWh9CKi+iRqUcVuBDyGL5hoXkYjgxr
	 puLagiJABC1iQPBXBmceJmbFtJ8pEyw35ps/RzJPyAKrvClAcXxo1v/kIZyWXhxroQ
	 lJpLXrBvFanpUOiy3G+CJ8RDR9BRCW9/DwPXSGoAdqfmd6w3M/vYl7QCf8pvaYIE/o
	 TTIxDx0aCTmBABaMLAnUvbm+WE0ott0rmFjNUAZqoJ50jS04jTG+IgCG/Oj/iLnbje
	 AX8HabNHkPyMA==
Message-ID: <sashiko-outbox-194340@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/7] KVM: nSVM: Check validity of vmcs01 save area
 copied from SMRAM on RSM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20261102231428.13523-2-pbonzini@redhat.com>
References: <20261102231428.13523-1-pbonzini@redhat.com>
 <20261102231428.13523-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 23:45:43 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] KVM: nSVM: missing EFER.LMA =3D=3D EFER.LME check in nested_svm_ch=
eck_vmcb01_save()
- [Medium] KVM: nSVM: svm_leave_smm() clobbers active vmcb01 save area befo=
re validation
--

commit c828fbc1de480891becf95d339311e3eed500e73
Author: Sean Christopherson <seanjc@google.com>

KVM: nSVM: Check validity of vmcs01 save area copied from SMRAM on RSM

This commit factors out a helper to validate the vmcb01 save area and calls
it in svm_leave_smm() after copying L1's state from SMRAM when returning fr=
om
SMM into L2.

> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index af0ef678433d7..07554089ec05b 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -1889,6 +1889,21 @@ static void nested_copy_vmcb_cache_to_control(stru=
ct vmcb_control_area *dst,
>  	/* 'clean' and 'hv_enlightenments' are not changed by KVM */
>  }
> =20
> +bool nested_svm_check_vmcb01_save(struct kvm_vcpu *vcpu,
> +				  struct vmcb_save_area *save)
> +{
> +	struct vmcb_save_area_cached save_cached;
> +
> +	if (!(save->cr0 & X86_CR0_PG) ||
> +	    !(save->cr0 & X86_CR0_PE) ||
> +	    (save->rflags & X86_EFLAGS_VM) ||
> +	    ((save->efer & EFER_LMA) && !(save->efer & EFER_LME)))
> +		return false;

[Severity: High]
Since nested_svm_check_vmcb01_save() requires save->cr0 & X86_CR0_PG to be
set, should this check also reject !(save->efer & EFER_LMA) &&
(save->efer & EFER_LME) (and CS.L=3D1 when EFER_LMA=3D0)?

nested_vmcb_check_save() does not check EFER_LMA against CR0.PG && EFER_LME,
so a vmcb01 save area with CR0.PG=3D1, CR4.PAE=3D1, EFER_LME=3D1, and EFER_=
LMA=3D0
passes nested_svm_check_vmcb01_save() when reached from svm_leave_smm() or
svm_set_nested_state().

When entering L2 with nested NPT enabled, nested_svm_init_mmu_context()
passes svm->vmcb01.ptr->save.efer directly into kvm_init_shadow_npt_mmu():

arch/x86/kvm/svm/nested.c:nested_svm_init_mmu_context() {
	...
	kvm_init_shadow_npt_mmu(vcpu, svm->vmcb01.ptr->save.cr4,
				svm->vmcb01.ptr->save.efer,
				svm->nested.ctl.nested_cr3,
				svm->nested.ctl.misc_ctl);
	...
}

Because kvm_calc_cpu_role() checks EFER_LMA via ____is_efer_lma(regs) rather
than EFER_LME, the nested NPT shadow MMU gets initialized as 32-bit PAE
paging instead of 64-bit 4/5-level paging.

In addition, on a subsequent nested #VMEXIT from L2 to L1,
nested_svm_vmexit() restores vmcb01->save.efer and vmcb01->save.cr0:

arch/x86/kvm/svm/nested.c:nested_svm_vmexit() {
	...
	svm_set_efer(vcpu, vmcb01->save.efer);
	svm_set_cr0(vcpu, vmcb01->save.cr0 | X86_CRCR0_PE);
	svm_set_cr4(vcpu, vmcb01->save.cr4);
	...
}

Since svm_set_cr0() only sets EFER_LMA when transitioning from
!is_paging(vcpu) to CR0.PG=3D1, if L2 had CR0.PG=3D1, L1 is left running wi=
th
CR0.PG=3D1, EFER_LME=3D1, and EFER_LMA=3D0 in vcpu->arch.efer.

[ ... ]

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 136069dfcd44f..e30ee80624b72 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -5223,6 +5223,8 @@ static int svm_leave_smm(struct kvm_vcpu *vcpu, con=
st union kvm_smram *smram)
>  	 */
> =20
>  	svm_copy_vmrun_state(vcpu, &svm->vmcb01.ptr->save, m_save.map.hva + 0x4=
00);
> +	if (!nested_svm_check_vmcb01_save(vcpu, &svm->vmcb01.ptr->save))
> +		return 1;

[Severity: Medium]
Can copying the untrusted HSAVE state directly into svm->vmcb01.ptr->save
before validating it leave vcpu->arch and the active VMCB01 out of sync if
nested_svm_check_vmcb01_save() (or nested_svm_check_cached_vmcb12()) fails?

Before calling svm_leave_smm(), emulator_leave_smm() transitions vcpu->arch
to unpaged real mode while !is_guest_mode(vcpu) and svm->vmcb points to
svm->vmcb01.ptr.

If svm_leave_smm() returns 1 after svm_copy_vmrun_state() has already
overwritten svm->vmcb01.ptr->save, emulator_leave_smm() aborts with
X86EMUL_UNHANDLEABLE and em_rsm() requests KVM_REQ_TRIPLE_FAULT, exiting to
userspace with KVM_EXIT_SHUTDOWN while still in L1.

At that point, vcpu->arch and vcpu->arch.root_mmu reflect unpaged real mode,
while the active svm->vmcb->save holds the rejected HSAVE state (including
segment registers, CR0, CR3, CR4, and EFER). Unlike svm_set_nested_state(),
which validates the temporary save buffer before calling
svm_copy_vmrun_state(), a subsequent KVM_GET_SREGS or KVM_RUN on the vCPU
will see the clobbered vmcb01 save area and copy svm->vmcb->save.cr0 and cr3
into vcpu->arch in svm_vcpu_run().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102231428.1352=
3-1-pbonzini@redhat.com?part=3D1
