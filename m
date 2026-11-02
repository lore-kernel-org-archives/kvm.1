Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793642745;
	b=q/JcHv2kDoqy0PKVX95qLV79NLFsdUclBRoCNVtwW+4lORAa9Ht8U83ipFTQW4K8vavE
	 EYaMVCtJ/r+QDKvfXIWYXBLZqw3S6hXhu4BpHP/3qtPLOYqfMD/MQUSXurdixNy9si9US
	 LNsd9aYXukTFP/YgagMYZbLytEsBh3ifza/g26gz+GGQZ2KXPemxJM5prbP8mUjDDHUl1
	 lSqTDqDvWh+ZmoypM3MdE/2hae7oGRv9nhX49pooaGaOr54/0RfWjnvuCDFn3e1z06FDb
	 HJci9S5YsehRTIZ5fZif3JPZHPs/seASC6cdMdQkccUBzgzf4pgPCg4U+VOForii+tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793642745;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qnm3r6JWPGBdu1UlSX78d+Us1XMbsmXLiSgOoTCiISw=;
	b=0YKsr+OXnSp/fEkHYqt82ylJxyW1WNOcyWHchHSCn618921B2r9NwhyeaLnTIpqUBsSP
	 8/cf4+yF34LFslRGyu18JjQrpGapv+PExJRMLmEpjJZiQYucuRzPXLbeid2I+VSI9I7pu
	 aPloXUFL2SLnlMAuFcjfgxZVsrAhk3ru+uHYYFN/t4qNeF+KMovRodGI7xR5bmEEkZ0Ae
	 cqiWfDyhV8emVWEQNd6aF+dR35zYfgK45PeEGY5O/IM4MyAI8Dy3FJUUvKO8jAkV0IBl/
	 STrnmSJ+FubDiQm3nlWIVVoKPRSAAcDHDT7QtiAjy0swKEHdIuw4v5lpj96X7pPF4PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HLruAUV2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FDE606A59E
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 18:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HLruAUV2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA17A1F00A16;
	Mon,  2 Nov 2026 18:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793642745;
	bh=qnm3r6JWPGBdu1UlSX78d+Us1XMbsmXLiSgOoTCiISw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=HLruAUV2FBPAMw7baTKaFwLC/ZnptFk8ikehmnt+dgyIFfsydp7pmHVnKTL8lnIm7
	 TRJEqdhCnVLzyKv3L6rpSvFIx79gIRhPcf9bNjMVDfYb1ErJ/coG+yK1RY5s7xSVfL
	 QFmqbZ79A944FQgVnok4vhwvHiTRHYOIjAx2F7rz5mtDBOsqYXS0ymZgBXeffIZOnE
	 7zE+M2Psa0O7ZmgMKHp6FQaMbN7GLe+1dpD65HaSJ71i3o/fXIlR81d/9+ktiAhIsl
	 VcmhmEBirPqe9fXUGHG/MfawGFZ49L+qqrcUujBhg7TBe3QjVgHTOBkG+4yerXH+v4
	 QgqGDmTX5yDTA==
Message-ID: <sashiko-outbox-193903@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/45] KVM: nVMX/nSVM: check unconditionally whether CR3
 is valid
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20261102174130.8779-2-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
 <20261102174130.8779-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 18:05:44 +0000
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
- [High] KVM: nSVM: missing L1 host CR3 check in nested_svm_vmexit() after =
RSM
- [Medium] KVM: nSVM: unvalidated L2 CR3 and dead check in svm_set_nested_s=
tate()
--

commit 111aed734bf3c907c07b30f4fd256e2dd365f8e8
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM: nVMX/nSVM: check unconditionally whether CR3 is valid

This commit moves the CR3 validity check out of nested_svm_load_cr3() and
nested_vmx_load_cr3() into nested_vmcb_check_save() and
nested_vmx_check_guest_state() so that CR3 is checked unconditionally in all
processor modes during guest state validation.

> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index af0ef678433d7..fedddcd1cc964 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c

[ ... ]

> @@ -717,9 +717,6 @@ static void nested_svm_transition_tlb_flush(struct kv=
m_vcpu *vcpu)
>  static int nested_svm_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3,
>  			       bool nested_npt, bool reload_pdptrs)
>  {
> -	if (CC(!kvm_vcpu_is_legal_cr3(vcpu, cr3)))
> -		return -EINVAL;
> -

[Severity: High]
Does removing kvm_vcpu_is_legal_cr3() from nested_svm_load_cr3() allow an
unvalidated L1 host CR3 to be loaded on nested #VMEXIT after returning from
SMM?

When an SMI arrives while L2 is running, svm_enter_smm() saves L1's host
state from vmcb01->save into guest memory at MSR_VM_HSAVE_PA + 0x400, where
the SMM handler can modify the saved CR3. On RSM, svm_leave_smm() in
arch/x86/kvm/svm/svm.c copies that HSAVE state back into vmcb01->save, but
only validates vmcb12:

arch/x86/kvm/svm/svm.c:svm_leave_smm() {
	...
	svm_copy_vmrun_state(vcpu, &svm->vmcb01.ptr->save, m_save.map.hva + 0x400);

	/*
	 * Enter the nested guest now
	 */

	vmcb_mark_all_dirty(svm->vmcb01.ptr);

	vmcb12 =3D m.map.hva;
	nested_copy_vmcb_control_to_cache(svm, &vmcb12->control);
	nested_copy_vmcb_save_to_cache(svm, &vmcb12->save);

	if (nested_svm_check_cached_vmcb12(vcpu) < 0)
		return 1;
	...
}

On the subsequent nested #VMEXIT from L2 to L1, nested_svm_vmexit() in
arch/x86/kvm/svm/nested.c reloads vmcb01->save.cr3 via
nested_svm_load_cr3() and expects an invalid CR3 to trigger a triple fault:

arch/x86/kvm/svm/nested.c:nested_svm_vmexit() {
	...
	if (nested_svm_load_cr3(vcpu, vmcb01->save.cr3, false, true))
		kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
	...
}

Without kvm_vcpu_is_legal_cr3() in nested_svm_load_cr3(), if L1 is in
64-bit mode (or 32-bit non-PAE mode) so is_pae_paging(vcpu) is false,
nested_svm_load_cr3() returns 0 and installs the illegal CR3 into
vcpu->arch.cr3. When NPT is enabled, svm_load_mmu_pgd() then writes it into
vmcb01->save.cr3, causing hardware VMRUN of L1 to fail with SVM_EXIT_ERR
(KVM_EXIT_FAIL_ENTRY) instead of injecting KVM_REQ_TRIPLE_FAULT.

Should svm_leave_smm() validate the restored host state in vmcb01->save via
nested_vmcb_check_save() (similar to how vmx_leave_smm() calls
nested_vmx_check_restored_vmcs12()), or should nested_svm_vmexit() still
verify kvm_vcpu_is_legal_cr3()?

[Severity: Medium]
Similarly, in svm_set_nested_state() in arch/x86/kvm/svm/nested.c,
nested_vmcb_check_save() only validates L1's saved host state in
user_vmcb->save (copied into save_cached), while L2's current state is held
in vcpu->arch and checked separately at the top of svm_set_nested_state():

arch/x86/kvm/svm/nested.c:svm_set_nested_state() {
	...
	cr0 =3D kvm_read_cr0(vcpu);
        if (((cr0 & X86_CR0_CD) =3D=3D 0) && (cr0 & X86_CR0_NW))
		goto out_free;

	/*
	 * Validate host state saved from before VMRUN (see
	 * nested_svm_check_permissions). Note that the g_pat field is not
	 * validated, because (a) it may have been clobbered by SMM before
	 * KVM_GET_NESTED_STATE, and (b) it is not loaded at emulated
	 * #VMEXIT.
	 */
	__nested_copy_vmcb_save_to_cache(&save_cached, save);
	if (!(save->cr0 & X86_CR0_PG) ||
	    !(save->cr0 & X86_CR0_PE) ||
	    (save->rflags & X86_EFLAGS_VM) ||
	    ((save->efer & EFER_LMA) && !(save->efer & EFER_LME)) ||
	    !nested_vmcb_check_save(vcpu, &save_cached, false))
		goto out_free;
	...
	ret =3D nested_svm_load_cr3(&svm->vcpu, vcpu->arch.cr3,
				  nested_npt_enabled(svm), false);
	if (ret)
		goto out_free;
	...
}

Because kvm_is_valid_sregs() in arch/x86/kvm/regs.c only checks
kvm_vcpu_is_legal_cr3() when long mode is active, and because userspace may
also update CPUID MAXPHYADDR between KVM_SET_SREGS and
KVM_SET_NESTED_STATE, removing kvm_vcpu_is_legal_cr3() from
nested_svm_load_cr3() leaves L2's vcpu->arch.cr3 unvalidated here. In
addition, because svm_set_nested_state() passes reload_pdptrs =3D false to
nested_svm_load_cr3(), nested_svm_load_cr3() can no longer return a
non-zero value on this path, leaving the if (ret) check dead.

Should svm_set_nested_state() also check kvm_vcpu_is_legal_cr3(vcpu,
vcpu->arch.cr3) alongside the L2 CR0 check?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102174130.8779=
-1-pbonzini@redhat.com?part=3D1
