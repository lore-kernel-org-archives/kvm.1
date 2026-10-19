Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792445478;
	b=Ei8ecNaU9DauIOPncfNyfSSpcHBRefZQ/8gGiz0qlNBCaAoFE7wUAjNcwLlgCFcppQ+4
	 HJp8oMJAQBW8N+nBJ37UFQHtx9bAhPBH7SvHIpsrGmQXYBV+cE+VvtAqdfwQGksksD9Zs
	 F2Os3th9S9K5pHM61sWUEOUKwEnFohMCvxv4zsKBLAZCjeZUaFMilBn4aIFR33+MlJFkE
	 +oQd3ncXENhBOgAX9eduw+ge9XoZuubbBkYEFTnI46e64IyoIA7mw8ZW5o7qYMONXY5eA
	 o3S+644ILDsmY8LwxtqgSrWiPtoeByMpuc/80n062i0gsz/7ATe3uLcOMh3yrMZvGwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792445478;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mq0b6VmA4Xlfa7zM39y7AseSD9/7G9rd1IeBmP2CDrM=;
	b=OmpgQ1ZpbpioWjFWyxvDTZ4bFrjGxPlguya5QUZY/qyP4Frt/5s1Dbqran5lcYe5C6wB
	 RQd0lZOXZ5NvYNCzRYKj1rcs8EiJwbuMvft3jd32TkM5qzrXQlb4VU0gskiPClJgl+8Gn
	 mKUevlqTq2nSbD2cBOfXCjrCeIUKBJ1HREq/b7lYZJUQVMxThmATjyiQHz9Bem2n3Zqlz
	 WyXrOry0hx3RDffDOp4JZg65iEbKwdNUzldwwyK4Wd/7teDpiwL2wEe1Dd7FwLSQbGgN9
	 MMExIcZdSnB3/P2FPHVQrELBTz7R9lD60BQl5USip15FmuVnkZObYbejxNetdNNZmNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bOnuCnon;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C83D606A31B
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 21:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bOnuCnon
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2242E1F000C4;
	Mon, 19 Oct 2026 21:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792445478;
	bh=mq0b6VmA4Xlfa7zM39y7AseSD9/7G9rd1IeBmP2CDrM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bOnuCnonAWz9wYLcht0vn0GvxIgaRC5na/ZLubP2pjH/Xrbw4SZ1rgMkdQWNjwlSw
	 7I5AacWW8+Zipn5/o6MEj8eg6OyrpLm3DIb6JaZlmvQ0pWtHvBPt/7dhUQHd5oQJjk
	 HrEK08RqZxTgTbLkTDrdtntIcd9XJwAWiSQwjUmiS2RDxUAf1RA3qIW3bONg2buuUT
	 PJFbGZosumsMOaIZf6lQ/nu7VIy8szqvQ3lFZiLLAght+ALqxqkVBGmZcpedo27Uqw
	 DtHYIIK7rjMFqoVwJFO8UQjgHZuU7VIwRRJy4A561eXbgtszsfqXsL4LeFdbDrdBKN
	 HeI9uYK7kcsHg==
Message-ID: <sashiko-outbox-178260@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/12] KVM: nSVM: Propagate LBRv2 state across nested
 transitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivansh Dhiman" <shivansh.dhiman@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261019210532.378628-10-shivansh.dhiman@amd.com>
References: <20261019210532.378628-1-shivansh.dhiman@amd.com>
 <20261019210532.378628-10-shivansh.dhiman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 21:31:17 +0000
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
- [High] KVM: nSVM: wrong LBRv2 capability checks in svm_copy_vmrun_state()=
 and nested.c
- [High] KVM: nSVM: missing mediated PMU check for LBRv2 in nested transiti=
ons
- [High] KVM: nSVM: missing svm_update_lbrv() in svm_set_nested_state()
--

commit a61dcc1b0377ffbac74e374ce3dc16b1683a68e0
Author: Shivansh Dhiman <shivansh.dhiman@amd.com>

KVM: nSVM: Propagate LBRv2 state across nested transitions

This commit adds the svm_copy_lbrs_v2() macro and updates nested SVM
transitions (VMRUN, #VMEXIT, and VMCB state caching/copying) to propagate
LBRv2 state between vmcb01, vmcb02, and vmcb12.

> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index af0ef678433d7..b356a091e320c 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -608,6 +608,9 @@ static void __nested_copy_vmcb_save_to_cache(struct v=
mcb_save_area_cached *to,
>  	to->g_pat =3D from->g_pat;
> =20
>  	svm_copy_lbrs(to, from);
> +
> +	if (kvm_cpu_cap_has(X86_FEATURE_AMD_LBR_V2))
> +		svm_copy_lbrs_v2(to, from);
>  }
> =20
>  void nested_copy_vmcb_save_to_cache(struct vcpu_svm *svm,
> @@ -819,8 +822,17 @@ static void nested_vmcb02_prepare_save(struct vcpu_s=
vm *svm)
>  		 */
>  		svm_copy_lbrs(&vmcb02->save, save);
>  		vmcb02->save.dbgctl &=3D svm_get_supported_debugctl(vcpu);
> +
> +		if (guest_cpu_cap_has(vcpu, X86_FEATURE_AMD_LBR_V2)) {
> +			svm_copy_lbrs_v2(&vmcb02->save, save);
> +			vmcb02->save.dbg_extn_cfg &=3D ~DBG_EXTN_CFG_RESERVED_BITS;
> +			vmcb02->save.lbr_select &=3D ~LBR_SELECT_RESERVED_BITS;
> +		}
>  	} else {
>  		svm_copy_lbrs(&vmcb02->save, &vmcb01->save);
> +
> +		if (guest_cpu_cap_has(vcpu, X86_FEATURE_AMD_LBR_V2))
> +			svm_copy_lbrs_v2(&vmcb02->save, &vmcb01->save);
>  	}
>  	vmcb_mark_dirty(vmcb02, VMCB_LBR);
>  	svm_update_lbrv(&svm->vcpu);

[Severity: High]
Should the checks in nested_vmcb02_prepare_save() (as well as
nested_svm_vmexit_update_vmcb12() and nested_svm_vmexit() below) use
svm_lbrv2_supported(vcpu) instead of only checking
guest_cpu_cap_has(vcpu, X86_FEATURE_AMD_LBR_V2)?

In arch/x86/kvm/svm/svm.c, per-vCPU LBRv2 support is gated by
svm_lbrv2_supported(vcpu), which requires both X86_FEATURE_AMD_LBR_V2 and
kvm_vcpu_has_mediated_pmu(vcpu):

arch/x86/kvm/svm/svm.c:svm_lbrv2_supported() {
	return guest_cpu_cap_has(vcpu, X86_FEATURE_AMD_LBR_V2) &&
	       kvm_vcpu_has_mediated_pmu(vcpu);
}

All L1 MSR accesses (svm_get_msr(), svm_set_msr()) and intercept
calculations (svm_lbrv2_active(), svm_recalc_lbrv2_msr_intercepts()) check
svm_lbrv2_supported(vcpu) because hardware LBRv2 requires the mediated PMU
to schedule out host perf contexts via perf_load_guest_context().

If a VM is configured where guest_cpu_cap_has(vcpu, X86_FEATURE_AMD_LBR_V2)
is true in guest CPUID, but kvm_vcpu_has_mediated_pmu(vcpu) is false (for
example, if the PMU is disabled via KVM_CAP_PMU_CAPABILITY with
KVM_PMU_CAP_DISABLE, or when running without an in-kernel irqchip), L1 can
set SVM_MISC2_ENABLE_V_LBR in vmcb12->control.misc_ctl2 and
DBG_EXTN_CFG_LBRV2EN in vmcb12->save.dbg_extn_cfg and execute VMRUN.

nested_vmcb02_prepare_save() will copy save->dbg_extn_cfg, save->lbr_select,
and save->lbr[] into vmcb02->save, and svm_update_lbrv() will enable
SVM_MISC2_ENABLE_V_LBR in vmcb02->control.misc_ctl2. On VMRUN of vmcb02,
hardware will load vmcb02->save.dbg_extn_cfg with DBG_EXTN_CFG_LBRV2EN set
and record branches into the hardware LBR stack while L2 executes, even
though kvm_mediated_pmu_load() did not call perf_load_guest_context() to
switch out host perf LBRv2 state.

> @@ -1236,6 +1248,12 @@ void svm_copy_vmrun_state(struct kvm_vcpu *vcpu, s=
truct vmcb_save_area *to_save,
>  		svm_copy_lbrs(to_save, from_save);
>  		to_save->dbgctl &=3D svm_get_supported_debugctl(vcpu);
>  	}
> +
> +	if (kvm_cpu_cap_has(X86_FEATURE_AMD_LBR_V2)) {
> +		svm_copy_lbrs_v2(to_save, from_save);
> +		to_save->dbg_extn_cfg &=3D ~DBG_EXTN_CFG_RESERVED_BITS;
> +		to_save->lbr_select &=3D ~LBR_SELECT_RESERVED_BITS;
> +	}
>  }

[Severity: High]
Can gating svm_copy_vmrun_state() (and __nested_copy_vmcb_save_to_cache()
above) on the host capability kvm_cpu_cap_has(X86_FEATURE_AMD_LBR_V2)
instead of svm_lbrv2_supported(vcpu) corrupt L1's HSAVE page on SMM entry
and allow L1 to activate hardware LBRv2 when LBRv2 is not enabled for the
vCPU?

When an SMI arrives while a vCPU without LBRv2 enabled is running L2,
svm_enter_smm() calls svm_copy_vmrun_state():

arch/x86/kvm/svm/svm.c:svm_enter_smm() {
	...
	svm_copy_vmrun_state(vcpu, m_save.map.hva + 0x400, &svm->vmcb01.ptr->save);
	...
}

Because svm_copy_vmrun_state() checks
kvm_cpu_cap_has(X86_FEATURE_AMD_LBR_V2), KVM writes 272 bytes (dbg_extn_cfg
at offset 0x698, lbr[16] at 0xa70..0xb6f, and lbr_select at 0xb70) into L1's
MSR_VM_HSAVE_PA page even when LBRv2 is not exposed to the guest.

Conversely, on RSM in svm_leave_smm() or during KVM_SET_NESTED_STATE in
svm_set_nested_state():

arch/x86/kvm/svm/svm.c:svm_leave_smm() {
	...
	svm_copy_vmrun_state(vcpu, &svm->vmcb01.ptr->save, m_save.map.hva + 0x400);
	...
}

svm_copy_vmrun_state() copies dbg_extn_cfg (including DBG_EXTN_CFG_LBRV2EN),
lbr_select, and lbr[16] from the guest-controlled HSAVE page (or userspace
buffer) into vmcb01->save even when !svm_lbrv2_supported(vcpu). On a
subsequent nested #VMEXIT from L2 to L1, nested_svm_vmexit() skips
svm_copy_lbrs_v2(&vmcb01->save, &vmcb02->save) because
guest_cpu_cap_has(vcpu, X86_FEATURE_AMD_LBR_V2) is false, leaving
DBG_EXTN_CFG_LBRV2EN set in vmcb01->save.dbg_extn_cfg. If L1 then enables
SVM_MISC2_ENABLE_V_LBR (for example, by setting DEBUGCTLMSR_LBR in
MSR_IA32_DEBUGCTLMSR), hardware VMRUN will load vmcb01->save.dbg_extn_cfg
into physical hardware.

[Severity: High]
Also, when svm_set_nested_state() calls svm_copy_vmrun_state() to restore
nested state while in guest mode, does svm_set_nested_state() also need a
call to svm_update_lbrv(vcpu)?

During nested state restore in svm_set_nested_state():

arch/x86/kvm/svm/nested.c:svm_set_nested_state() {
	...
	svm_copy_vmrun_state(vcpu, &svm->vmcb01.ptr->save, save);
	nested_copy_vmcb_control_to_cache(svm, ctl);

	svm_switch_vmcb(svm, &svm->nested.vmcb02);

	if (use_separate_l2_pat)
		vmcb_set_gpat(svm->vmcb, kvm_state->hdr.svm.gpat);

	nested_vmcb02_prepare_control(svm);
	...
}

nested_vmcb02_prepare_control() leaves SVM_MISC2_ENABLE_V_LBR to
svm_update_lbrv(), which is normally called at the end of
nested_vmcb02_prepare_save() during VMRUN, but svm_set_nested_state() never
calls nested_vmcb02_prepare_save() or svm_update_lbrv(vcpu).

If userspace restores MSRs via KVM_SET_MSRS before KVM_SET_NESTED_STATE,
svm_set_msr() for MSR_AMD_DBG_EXTN_CFG (with DBG_EXTN_CFG_LBRV2EN) or
MSR_IA32_DEBUGCTLMSR (with DEBUGCTLMSR_LBR) runs while svm->vmcb points to
vmcb01. svm_update_lbrv() sets SVM_MISC2_ENABLE_V_LBR in
vmcb01->control.misc_ctl2 and disables interception of the LBR/LBRv2 MSRs in
svm->msrpm. When svm_set_nested_state() then moves vmcb01->save to
vmcb02->save and switches to vmcb02 without calling svm_update_lbrv(vcpu),
vmcb02->control.misc_ctl2 is left with SVM_MISC2_ENABLE_V_LBR cleared while
the LBR/LBRv2 MSRs remain unintercepted in msrpm01/msrpm02.

Even if KVM_SET_NESTED_STATE is called before KVM_SET_MSRS, if L1 enabled
SVM_MISC2_ENABLE_V_LBR in vmcb12 while L2's dbgctl and dbg_extn_cfg are 0,
svm_set_msr() breaks out early because the save area values are already 0,
leaving SVM_MISC2_ENABLE_V_LBR cleared in vmcb02->control.misc_ctl2.

[ ... ]

> @@ -1305,9 +1323,13 @@ static int nested_svm_vmexit_update_vmcb12(struct =
kvm_vcpu *vcpu)
>  	if (guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS))
>  		vmcb12->control.next_rip  =3D vmcb02->control.next_rip;
> =20
> -	if (svm->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR)
> +	if (svm->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR) {
>  		svm_copy_lbrs(&vmcb12->save, &vmcb02->save);
> =20
> +		if (guest_cpu_cap_has(vcpu, X86_FEATURE_AMD_LBR_V2))
> +			svm_copy_lbrs_v2(&vmcb12->save, &vmcb02->save);
> +	}
> +
>  	vmcb12->control.event_inj	  =3D 0;
>  	vmcb12->control.event_inj_err	  =3D 0;
>  	vmcb12->control.int_ctl           =3D svm->nested.ctl.int_ctl;
> @@ -1384,6 +1406,10 @@ void nested_svm_vmexit(struct vcpu_svm *svm)
> =20
>  	if (!(svm->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR)) {
>  		svm_copy_lbrs(&vmcb01->save, &vmcb02->save);
> +
> +		if (guest_cpu_cap_has(vcpu, X86_FEATURE_AMD_LBR_V2))
> +			svm_copy_lbrs_v2(&vmcb01->save, &vmcb02->save);
> +
>  		vmcb_mark_dirty(vmcb01, VMCB_LBR);
>  	}
> =20

[ ... ]

>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019210532.3786=
28-1-shivansh.dhiman@amd.com?part=3D9
