Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792709747;
	b=vQQ4b9t5rORxUTv9+Mg8pkaQt7+mKYnYLbRJY18HoowqQwmoRaoI6hrJecVt8IphmUCh
	 gQ6E1/BYyJVG8FSCXjPV7dsJ+ZZ7/2YibXmE3VGqkR/8aNrI7FAWrEJ+/j1I7/MMTanyZ
	 hf4fJj9Ey4NRLdiLLaxp8PciPdAyzJuz7Cq87kTnVSlbLMayDd6h20XZprW4yrWWjKTGG
	 S6vAzFk1c4DjoCLBtwtLwf30tNFTioJ6u8+qkCvLcCWRfCbqBwO8d3Imm66C78QPv4BDD
	 x2kugOLptwTcPd2rrC1hev4OmkOQ9C7YTnisa9uD+lyf/Sq8aKFaXAxMT1GiXHYY9Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792709747;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jSCtG7IxjvJS4+IQPxTygLHz3YkJirajV2SES94EPV4=;
	b=E9/6P7o9WXcKrmqW8p6tAZeC2+2GeFZvAJZadWsdv4Ou8NSNcYHhTzgDDDHC4E5XWSAc
	 Zdgckj4tG2xNxLUIbA4wLvNek8aSOo6oVqlV3mLRMRhtcSW1PrsnWGqHsNeZfWcQ5GXH2
	 JWX5zJeS0s6PJs+q4EZA3QJo+Vtq6+HGaNQkd5ZyqIUeDZIsbgY2X9gyvSyNVtZovbrLN
	 cIGK7zXsMZV3Cen7IwnwukodLgSTCCU7YnFvmIpLiVvZVHjkgqx5SRXeYPTTQLoB5Xhbg
	 0rufQ6DuJdhj2mSmgFaaH6qbsdrZaS4+sr5fAxT29SH0xj3gYwnktXfYvRb/OsjTEkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B0nL4M17;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB713606A322
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 22:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B0nL4M17
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4951F01829;
	Thu, 22 Oct 2026 22:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792709746;
	bh=jSCtG7IxjvJS4+IQPxTygLHz3YkJirajV2SES94EPV4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B0nL4M17Go7wFegggJ/AKRuN4js1ioVlCC0Uyv5+NzQ0FoNE0cLBjXH8VZC/kNIp9
	 28vDhZ0yg1BHzVaRvqnypKK4Cdz3MBTwGoHf5Azf1H3u8lim/aMLYbFGIHL1ooILlY
	 IPtKYdwMb1DCM1FK7k/YG+6zuP1TtForpElKRYL8jvDh35jH90BqbrJPWrFM1vP/Tl
	 gnOaQwM3FC3X28gnm4EgjaiSqZbwKWRLaDeIhWwDilzVxNs2ATWEFS9ETii2YWDL3e
	 fQKlZN2SHyTKep4e6tChnLuUsuX2NQe51Xd4Q5Gz9La3nUQ8mDiTjib8XtO8boLhlS
	 /lYcObGY9uhpg==
Message-ID: <sashiko-outbox-182138@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: nVMX: Restore L2's DEBUGCTL/BNDCFGS/CET from
 vmcs12 on RSM and nested state restore
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amirmohammad Eftekhar" <amirmohammad.eftekhar@cispa.de>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261022223820.8279-1-amirmohammad.eftekhar@cispa.de>
References: <20261022223820.8279-1-amirmohammad.eftekhar@cispa.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 22:55:45 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] KVM: nVMX: nested_vmx_enter_non_root_mode() clobbers MSRs on neste=
d restore
- [High] KVM: nVMX: nested_vmx_enter_non_root_mode() loads unsynced vmcs12 =
on RSM
- [High] KVM: nVMX: unmasked pre_vmenter_debugctl triggers WARN_ON_ONCE()
- [High] KVM: nVMX: nested_vmx_enter_non_root_mode() loads unvalidated vmcs=
12 state
--

commit 82cdff7353032b10db8c74a6ee8e324f714ba70b
Author: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>

KVM: nVMX: Restore L2's DEBUGCTL/BNDCFGS/CET from vmcs12 on RSM and nested =
state restore

This commit updates nested_vmx_enter_non_root_mode() to snapshot
pre_vmenter_debugctl, pre_vmenter_bndcfgs, and CET state from vmcs12 instead
of vmcs01 when from_vmentry is false.

> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index b252168627408..2847415500c2e 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -3647,19 +3647,38 @@ enum nvmx_vmentry_status nested_vmx_enter_non_roo=
t_mode(struct kvm_vcpu *vcpu,
> =20
>  	kvm_service_local_tlb_flush_requests(vcpu);
> =20
> +	/*
> +	 * Snapshot the state that VM-Enter leaves unchanged when the matching
> +	 * VM_ENTRY_LOAD_* control is clear, so it can be restored into vmcs02.
> +	 * On VM-Enter the active VMCS is vmcs01 and its guest state is what L2
> +	 * inherits.  On the !from_vmentry paths (RSM back into L2, and
> +	 * KVM_SET_NESTED_STATE) the active VMCS is still vmcs01, i.e. holds
> +	 * L1's state, whereas L2's state lives in vmcs12 -- read it from there
> +	 * so that resuming L2 doesn't clobber its DEBUGCTL/BNDCFGS/CET with
> +	 * L1's values.
> +	 */
>  	if (!vcpu->arch.nested_run_pending ||
>  	    !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_DEBUG_CONTROLS))
> -		vmx->nested.pre_vmenter_debugctl =3D vmx_guest_debugctl_read();
> +		vmx->nested.pre_vmenter_debugctl =3D from_vmentry ?
> +			vmx_guest_debugctl_read() : vmcs12->guest_ia32_debugctl;

[Severity: High]
Can assigning the unmasked vmcs12->guest_ia32_debugctl to
vmx->nested.pre_vmenter_debugctl here trigger the host WARN_ON_ONCE() in
vmx_guest_debugctl_write() and write host-owned or unsupported bits into
vmcs02?

In arch/x86/kvm/vmx/vmx.c, vmx_leave_smm() calls
nested_vmx_enter_non_root_mode(vcpu, false) before setting
vcpu->arch.nested_run_pending (and nested_run_pending is also 0 in
vmx_set_nested_state() unless KVM_STATE_NESTED_RUN_PENDING is set):

arch/x86/kvm/vmx/vmx.c:vmx_leave_smm() {
    ...
	if (vmx->nested.smm.guest_mode) {
		vmx->nested.smm.guest_mode =3D false;

		ret =3D nested_vmx_enter_non_root_mode(vcpu, false);
		if (ret !=3D NVMX_VMENTRY_SUCCESS)
			return 1;

		vcpu->arch.nested_run_pending =3D KVM_NESTED_RUN_PENDING;
	}
    ...
}

Because vcpu->arch.nested_run_pending is 0, prepare_vmcs02() in
arch/x86/kvm/vmx/nested.c takes the else branch and passes
vmx->nested.pre_vmenter_debugctl directly to vmx_guest_debugctl_write()
without masking it with vmx_get_supported_debugctl(vcpu, false):

arch/x86/kvm/vmx/nested.c:prepare_vmcs02() {
    ...
	if (vcpu->arch.nested_run_pending &&
	    (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_DEBUG_CONTROLS)) {
		kvm_set_dr(vcpu, 7, vmcs12->guest_dr7);
		vmx_guest_debugctl_write(vcpu, vmcs12->guest_ia32_debugctl &
					       vmx_get_supported_debugctl(vcpu, false));
	} else {
		kvm_set_dr(vcpu, 7, vcpu->arch.dr7);
		vmx_guest_debugctl_write(vcpu, vmx->nested.pre_vmenter_debugctl);
	}
    ...
}

Even when VM_ENTRY_LOAD_DEBUG_CONTROLS is set in vmcs12,
nested_vmx_check_guest_state() permits DEBUGCTLMSR_FREEZE_IN_SMM under
KVM_X86_QUIRK_VMCS12_ALLOW_FREEZE_IN_SMM (enabled by default) and
vmx_is_valid_debugctl() permits DEBUGCTLMSR_BTF and DEBUGCTLMSR_LBR; when
VM_ENTRY_LOAD_DEBUG_CONTROLS is clear, vmcs12->guest_ia32_debugctl is not
checked at all.

Passing the unmasked value to vmx_guest_debugctl_write() in
arch/x86/kvm/vmx/vmx.h:

static inline void vmx_guest_debugctl_write(struct kvm_vcpu *vcpu, u64 val)
{
	WARN_ON_ONCE(val & VMX_HOST_OWNED_DEBUGCTL_BITS);

	val |=3D vcpu->arch.host_debugctl & VMX_HOST_OWNED_DEBUGCTL_BITS;
	vmcs_write64(GUEST_IA32_DEBUGCTL, val);
}

allows an unprivileged guest (via VMWRITE + SMI + RSM) or host userspace
(via KVM_SET_NESTED_STATE) to fire WARN_ON_ONCE(val &
VMX_HOST_OWNED_DEBUGCTL_BITS) and write DEBUGCTLMSR_FREEZE_IN_SMM or
unsupported hardware bits (such as DEBUGCTLMSR_BTF, DEBUGCTLMSR_LBR,
DEBUGCTLMSR_TR, or DEBUGCTLMSR_BTS) into vmcs02's GUEST_IA32_DEBUGCTL.

>  	if (kvm_mpx_supported() &&
>  	    (!vcpu->arch.nested_run_pending ||
>  	     !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_BNDCFGS)))
> -		vmx->nested.pre_vmenter_bndcfgs =3D vmcs_read64(GUEST_BNDCFGS);
> +		vmx->nested.pre_vmenter_bndcfgs =3D from_vmentry ?
> +			vmcs_read64(GUEST_BNDCFGS) : vmcs12->guest_bndcfgs;

[Severity: High]
On the SMI + RSM path, does vmcs12 actually hold L2's live
GUEST_IA32_DEBUGCTL and GUEST_BNDCFGS values in all cases?

When L1 enters L2 via VMLAUNCH or VMRESUME with VM_ENTRY_LOAD_DEBUG_CONTROLS
or VM_ENTRY_LOAD_BNDCFGS clear, prepare_vmcs02() in
arch/x86/kvm/vmx/nested.c propagates L1's vmcs01 value into vmcs02, but
vmcs12->guest_ia32_debugctl and vmcs12->guest_bndcfgs are never updated.

Furthermore, if L2 writes MSR_IA32_DEBUGCTLMSR or MSR_IA32_BNDCFGS,
vmx_set_msr() in arch/x86/kvm/vmx/vmx.c only updates
vmcs12->guest_ia32_debugctl when VM_EXIT_SAVE_DEBUG_CONTROLS is set in
vmcs12->vm_exit_controls, and only updates vmcs12->guest_bndcfgs on explicit
WRMSR when BNDCFGS controls are exposed in vmx->nested.msrs (and not on
VM-Entry inheritance or XRSTORS):

arch/x86/kvm/vmx/vmx.c:vmx_set_msr() {
    ...
	case MSR_IA32_DEBUGCTLMSR:
		...
		if (is_guest_mode(vcpu) && get_vmcs12(vcpu)->vm_exit_controls &
						VM_EXIT_SAVE_DEBUG_CONTROLS)
			get_vmcs12(vcpu)->guest_ia32_debugctl =3D data;

		vmx_guest_debugctl_write(vcpu, data);
    ...
	case MSR_IA32_BNDCFGS:
		...
		if (is_guest_mode(vcpu) &&
		    ((vmx->nested.msrs.entry_ctls_high & VM_ENTRY_LOAD_BNDCFGS) ||
		     (vmx->nested.msrs.exit_ctls_high & VM_EXIT_CLEAR_BNDCFGS)))
			get_vmcs12(vcpu)->guest_bndcfgs =3D data;

		vmcs_write64(GUEST_BNDCFGS, data);
}

When an SMI arrives while L2 is running, vmx_enter_smm() ->
nested_vmx_vmexit() -> sync_vmcs02_to_vmcs12() in arch/x86/kvm/vmx/nested.c
does not save vmcs02's GUEST_IA32_DEBUGCTL or GUEST_BNDCFGS into vmcs12:

arch/x86/kvm/vmx/nested.c:sync_vmcs02_to_vmcs12() {
    ...
	if (vmcs12->vm_exit_controls & VM_EXIT_SAVE_DEBUG_CONTROLS)
		vmcs12->guest_dr7 =3D vcpu->arch.dr7;
    ...
}

When vmx_leave_smm() subsequently calls
nested_vmx_enter_non_root_mode(vcpu, false) on RSM, won't reading
vmcs12->guest_ia32_debugctl and vmcs12->guest_bndcfgs overwrite L2's vmcs02
state with stale values from vmcs12 (including regressing GUEST_BNDCFGS when
VM_ENTRY_LOAD_BNDCFGS and VM_EXIT_CLEAR_BNDCFGS are clear and neither L2 nor
SMM wrote BNDCFGS, where vmcs01 previously preserved L2's inherited value)?

> =20
>  	if (!vcpu->arch.nested_run_pending ||
> -	    !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_CET_STATE))
> -		vmcs_read_cet_state(vcpu, &vmx->nested.pre_vmenter_s_cet,
> -				    &vmx->nested.pre_vmenter_ssp,
> -				    &vmx->nested.pre_vmenter_ssp_tbl);
> +	    !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_CET_STATE)) {
> +		if (from_vmentry) {
> +			vmcs_read_cet_state(vcpu, &vmx->nested.pre_vmenter_s_cet,
> +					    &vmx->nested.pre_vmenter_ssp,
> +					    &vmx->nested.pre_vmenter_ssp_tbl);
> +		} else {
> +			vmx->nested.pre_vmenter_s_cet =3D vmcs12->guest_s_cet;
> +			vmx->nested.pre_vmenter_ssp =3D vmcs12->guest_ssp;
> +			vmx->nested.pre_vmenter_ssp_tbl =3D vmcs12->guest_ssp_tbl;
> +		}
> +	}

[Severity: High]
Won't reading pre_vmenter_debugctl, pre_vmenter_bndcfgs, and
pre_vmenter_{s_cet,ssp,ssp_tbl} from vmcs12 when !from_vmentry cause a
regression on live migration and state restore when userspace calls
KVM_SET_MSRS before KVM_SET_NESTED_STATE?

As documented in struct nested_vmx in arch/x86/kvm/vmx/vmx.h (from commits
764643a6be0744, fa578398a0ba2c, and 5d76b1f8c79309), pre_vmenter_* is
specifically designed to snapshot L2's MSR values from vmcs01 during
KVM_SET_NESTED_STATE when userspace restores MSRs prior to nested state:

arch/x86/kvm/vmx/vmx.h:struct nested_vmx {
    ...
	/*
	 * Used to snapshot MSRs that are conditionally loaded on VM-Enter in
	 * order to propagate the guest's pre-VM-Enter value into vmcs02.  For
	 * emulation of VMLAUNCH/VMRESUME, the snapshot will be of L1's value.
	 * For KVM_SET_NESTED_STATE, the snapshot is of L2's value, _if_
	 * userspace restores MSRs before nested state.  If userspace restores
	 * MSRs after nested state, the snapshot holds garbage, but KVM can't
	 * detect that, and the garbage value in vmcs02 will be overwritten by
	 * MSR restoration in any case.
	 */
	u64 pre_vmenter_debugctl;
	u64 pre_vmenter_bndcfgs;
	u64 pre_vmenter_s_cet;
	u64 pre_vmenter_ssp;
	u64 pre_vmenter_ssp_tbl;
    ...
}

When saving a vCPU running in L2, userspace saves L2's MSRs via KVM_GET_MSRS
(reading vmcs02) and nested state via KVM_GET_NESTED_STATE ->
vmx_get_nested_state() -> sync_vmcs02_to_vmcs12(), which intentionally does
not copy GUEST_IA32_DEBUGCTL or GUEST_BNDCFGS from vmcs02 into vmcs12.

During state restore (for example in vcpu_load_state() in
tools/testing/selftests/kvm/lib/x86/processor.c and VMMs that restore MSRs
before nested state), KVM_SET_MSRS runs while the vCPU is still in root
mode, so vmx_set_msr() writes L2's saved MSRs into vmcs01.

When KVM_SET_NESTED_STATE subsequently invokes vmx_set_nested_state() ->
nested_vmx_enter_non_root_mode(vcpu, false) in arch/x86/kvm/vmx/nested.c
with vcpu->arch.nested_run_pending =3D=3D false, reading from vmcs12 instea=
d of
vmcs01 discards the L2 MSR values restored into vmcs01 by KVM_SET_MSRS and
overwrites vmcs02 in prepare_vmcs02() with stale or zero values from vmcs12
(even when VM_ENTRY_LOAD_DEBUG_CONTROLS, VM_ENTRY_LOAD_BNDCFGS, or
VM_ENTRY_LOAD_CET_STATE is set in vmcs12, since !vcpu->arch.nested_run_pend=
ing
is true).

[Severity: High]
What happens on RSM or KVM_SET_NESTED_STATE when
VM_ENTRY_LOAD_DEBUG_CONTROLS, VM_ENTRY_LOAD_BNDCFGS, or
VM_ENTRY_LOAD_CET_STATE is clear in vmcs12->vm_entry_controls and vmcs12
contains unvalidated values in those guest-state fields?

In nested_vmx_check_guest_state() in arch/x86/kvm/vmx/nested.c (called via
nested_vmx_check_restored_vmcs12() in vmx_leave_smm() and
vmx_set_nested_state()), vmcs12->guest_ia32_debugctl, vmcs12->guest_bndcfgs,
and vmcs12->guest_{s_cet,ssp,ssp_tbl} are only validated when their
corresponding VM_ENTRY_LOAD_* control bit is set in
vmcs12->vm_entry_controls:

arch/x86/kvm/vmx/nested.c:nested_vmx_check_guest_state() {
    ...
	if (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_DEBUG_CONTROLS) {
		u64 debugctl =3D vmcs12->guest_ia32_debugctl;
		...
		if (CC(!kvm_dr7_valid(vmcs12->guest_dr7)) ||
		    CC(!vmx_is_valid_debugctl(vcpu, debugctl, false)))
			return -EINVAL;
	}
    ...
	if ((vmcs12->vm_entry_controls & VM_ENTRY_LOAD_BNDCFGS) &&
	    (CC(is_noncanonical_msr_address(vmcs12->guest_bndcfgs & PAGE_MASK, vcp=
u)) ||
	     CC((vmcs12->guest_bndcfgs & MSR_IA32_BNDCFGS_RSVD))))
		return -EINVAL;

	if (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_CET_STATE) {
		if (nested_vmx_check_cet_state_common(vcpu, vmcs12->guest_s_cet,
						      vmcs12->guest_ssp,
						      vmcs12->guest_ssp_tbl))
			return -EINVAL;

		if (CC(!__is_canonical_address(vmcs12->guest_ssp, max_host_virt_addr_bits=
() + 1)))
			return -EINVAL;
	}
    ...
}

Architecturally, when a VM_ENTRY_LOAD_* control is clear in vmcs12, the
corresponding vmcs12 guest-state fields are ignored on VM-Entry and may
legally hold arbitrary values (such as reserved bits, non-canonical
addresses, or an unaligned SSP).

However, vmcs02 unconditionally enables VM_ENTRY_LOAD_DEBUG_CONTROLS,
VM_ENTRY_LOAD_BNDCFGS (when MPX is supported), and VM_ENTRY_LOAD_CET_STATE
(when CET is enabled in the host) in its hardware VM-Entry controls
(inherited from vmcs01 in prepare_vmcs02_early()).

When nested_vmx_enter_non_root_mode() copies those unchecked vmcs12 fields
into pre_vmenter_* and prepare_vmcs02() writes them into vmcs02, won't the
subsequent physical VM-Entry into L2 fail hardware guest-state checks with
EXIT_REASON_INVALID_STATE (failed_vmentry =3D 1, and trigger a host
WARN_ON_ONCE() when warn_on_missed_cc is enabled) or load unsupported CET
state into hardware?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022223820.8279=
-1-amirmohammad.eftekhar@cispa.de?part=3D1
