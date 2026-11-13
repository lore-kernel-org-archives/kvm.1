Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794593386;
	b=kBPenB0r1gsmFQjo1HEog95mh/VxmrCXEcOOCzbauNYIfaH7AzAk8/xyHMTEEpiPhCJM
	 7t2202mu7l+WuN+ZjOY5d5e8Z/uxvKXG34x5rl3SC3nsJRrML7yrifIFhJ+1EAGnJxz3P
	 XLRBM7gee/tXFQZt5pmAdY1cxc4Fe2qCxDUIoDoBNyyOZYx6COI6Omr8uJzspcBdVdQnY
	 LUF6YvfcuL73GZ4PYLnv96RLTkkTUnext1oOAciTYsSJKG7OAqknf5oxv17eAKCpIga9m
	 s5nNBO6sH2NlOdxWZNh0lX9v2UPl24NCx4a1GeVtiBojvh4T8DRK0ux1BV1mIJCZOVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794593386;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nVjP5GX+3XmXl45D78zcygPv7kUuwRgrwxq54cpdc8c=;
	b=RwhFqTLkGpVWPWPl4wkXGNsISx+Djq7nHJk8PMbI+vhgTl6KLN7s0MOlhNPrAk6LH2Ce
	 lxf6LHcazqfAEkhp5okd/OS+CWpY3Z/Cg5ha7EAzQTB6AE0Fp3puqKZxBDRGa7JTe+nM0
	 qd1mb+3aD29q5H2ob1xW4oxKd7OUu5WVQEcYHxRIqrzGZ2ZrerEb29y+jdXqwqNT3ND0Y
	 CGKWAdPbsfz4dpD4ogorgILIKb0QFRcDemdiLLB3HurQFNfYtUlS0ro2x7pU/YMzSgHuC
	 +VjxiiMbXbTP8EpkeyL8vmBfXoeWctdpDOhtF4fLthfDgZg5PNuhdn8D5U1vZgLaKWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M8xF7Uem;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E57606A32D
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 18:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M8xF7Uem
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC7D1F000C4;
	Fri, 13 Nov 2026 18:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794593386;
	bh=nVjP5GX+3XmXl45D78zcygPv7kUuwRgrwxq54cpdc8c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M8xF7Uem2/M5qUDMzaG02/Sy3gxReDYMHASg3Lft7PvpgbbeKqsDPXtAUd51AU8dO
	 g02ZLRgCm4BOOXtlWu7fQdVOIZ3Vxz/9+QA+x/a+OePH+Pgo92aNNypnl2WM0CUf1u
	 fFKqEaXM4g4IFxDkt+6gH6G0uH24dUkhvqswAvQgVpTvCG2LsAjsLG5ta24kgPVIcY
	 9rBMwjk5lFn0LHBYLf8nPejp1ZYkmqfLWjWfH9vz/IhYZeZIIC/cm/+w57PgR6YXSb
	 hC/EUI55TXFSuiHETCLBVu2/p+6f1qNnZ6scrEpbYNX8ApBnv9PnEQABJei/rCMvg+
	 T73njNxJXiiwg==
Message-ID: <sashiko-outbox-213391@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: x86: Leave nested if vendor specific logic fails
 on RSM to L2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261113172318.482971-1-seanjc@google.com>
References: <20261113172318.482971-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 18:09:45 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] KVM: x86: stale L2 CR/EFER and MMU state on error in
  emulator_leave_smm()
--

commit c1ffe76267a883adcbf36fb63721587d4841653d
Author: Sean Christopherson <seanjc@google.com>

KVM: x86: Leave nested if vendor specific logic fails on RSM to L2

This commit jumps to the exit path in emulator_leave_smm() when the vendor
leave_smm callback fails so that kvm_leave_nested() is called if the vCPU
already entered guest mode.

> diff --git a/arch/x86/kvm/smm.c b/arch/x86/kvm/smm.c
> index 656a38dad7e7a..23cb8211ec74e 100644
> --- a/arch/x86/kvm/smm.c
> +++ b/arch/x86/kvm/smm.c
> @@ -639,8 +639,10 @@ int emulator_leave_smm(struct x86_emulate_ctxt *ctxt)
>  	 * reasons), and so nSVM/nVMX would clobber state that is loaded from
>  	 * SMRAM and from the VMCS/VMCB.
>  	 */
> -	if (kvm_x86_call(leave_smm)(vcpu, &smram))
> -		return X86EMUL_UNHANDLEABLE;
> +	if (kvm_x86_call(leave_smm)(vcpu, &smram)) {
> +		ret =3D X86EMUL_UNHANDLEABLE;
> +		goto out;
> +	}
> =20
>  #ifdef CONFIG_X86_64
>  	if (guest_cpu_cap_has(vcpu, X86_FEATURE_LM))
> @@ -661,6 +663,7 @@ int emulator_leave_smm(struct x86_emulate_ctxt *ctxt)
>  	 * the shutdown, so that L1 enters shutdown instead of seeing a VM-Exit
>  	 * that architecturally shouldn't be possible.
>  	 */
> +out:
>  	if (ret !=3D X86EMUL_CONTINUE && is_guest_mode(vcpu))
>  		kvm_leave_nested(vcpu);
>  	return ret;

[Severity: Medium]
Does jumping directly to kvm_leave_nested() when leave_smm() fails on SVM
leave vcpu->arch.{efer,cr0,cr4} with partially loaded vmcb12 state while
switching back to L1?

Before calling leave_smm(), emulator_leave_smm() puts the vCPU into 32-bit
unpaged real mode (CR0.PG=3D0, CR0.PE=3D0, EFER=3D0).  In svm_leave_smm(),
nested_svm_check_cached_vmcb12() only checks kvm_vcpu_is_legal_cr3() when
both EFER_LME and X86_CR0_PG are set in vmcb12.  If vmcb12 has an illegal
CR3 with CR0.PG=3D0, enter_svm_guest_mode() enters guest mode and overwrites
vcpu->arch.{efer,cr0,cr4} before failing in nested_svm_load_cr3():

arch/x86/kvm/svm/nested.c:enter_svm_guest_mode() {
	...
	nested_vmcb02_prepare_control(svm);
	nested_vmcb02_prepare_save(svm);

	ret =3D nested_svm_load_cr3(&svm->vcpu, svm->nested.save.cr3,
				  nested_npt_enabled(svm), from_vmrun);
	if (ret)
		return ret;
	...
}

Because is_paging(vcpu) is false during RSM, nested_vmcb02_prepare_save()
and svm_set_cr0() leave EFER_LMA set in vcpu->arch.efer if vmcb12 has
EFER_LME=3D1, EFER_LMA=3D1, and CR0.PG=3D0.  Jumping to out: skips
rsm_load_state_*(), and svm_leave_nested() switches back to vmcb01 (CPL=3D0)
and clears HF_GUEST_MASK without restoring vcpu->arch.{efer,cr0,cr4} or
resetting the MMU.

When vmcb12 also has CR0.PE=3D0, em_rsm() then fails in
emulator_recalc_and_set_mode() because EFER_LMA=3D1 with CR0.PE=3D0, and
handle_emulation_failure() sees !is_guest_mode(vcpu) and CPL =3D=3D 0 and
exits to userspace with KVM_EXIT_INTERNAL_ERROR instead of
KVM_EXIT_SHUTDOWN.  If CR0.PE=3D1 and userspace ignores KVM_EXIT_SHUTDOWN,
the vCPU runs in L1 with illegal or desynchronized CR/EFER and MMU state
(for example, EFER_LMA=3D1 with CR0.PG=3D0 and CR4.PAE=3D0, which can trigg=
er
the KVM_BUG_ON() in kvm_calc_cpu_role()).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113172318.4829=
71-1-seanjc@google.com?part=3D1
