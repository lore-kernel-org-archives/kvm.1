Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F6E5592F0
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 13:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788875870; cv=none; b=TbBuLJnMKPdjHjP1ztgQ1mqWq8wlnD3jjjF+5w1HVEL5Pv+BIIh6jQEbYBTt/5KI+YKJBUEYDirgT1080F794cv6tumpYN0LKV5kqK6P92hnCAyPx9XkEPsq0CI96SGjFO5IPbckB8k/ydbWGsi0VbrPFJc+NG+6Ik9mun6KT7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788875870; c=relaxed/simple;
	bh=tighKdMR8Lgbv/xo3fjP9RI7hKrpgyFmA3ivO5QDzV4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RcfmEU4LYud242OUsbXmfpUYDFURVH3+krdPavrHFgYDohmWrBDLGw+IFZd7nu1PKXcHV9o/b2YLeMZrCsO3xQkIORcuUYioIkIHn+mdpHALQBzISpWVGMcz868HC8qDuAmWUbcuC7qxyayY8nSS/E+swJC2v4e4JZr9VzTvw7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRTnyk8Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRTnyk8Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14C01F00A3A;
	Tue,  8 Sep 2026 13:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788875857;
	bh=fleFc6m3iJVrIMrmIEfOlVn047psFV56wYl75Uo9EAU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GRTnyk8Qs4lHLJIrAGpPidNLIu6lK2vaaNn0tc6aw7SosJpKtBw0XRQmwzkUYPaEG
	 WYeBfHMImPw+h/M1bKc2Boo2p+0PqmDvXHOexN8Csqadiwnw0Vcxs5YKH4FJDaZaSg
	 DJb92lmd9SN28VQM0AFSgXs1A9hb2tCosb3fstVf4IdMMFE5JIYkwkZkwT2TFXnKFo
	 3MnnBhFN/aIlCx1DlLcPedAHuoMSAN7DQOJr5DiNvdAz+Ch439WNJ4KCdYgH8nc+o+
	 49pnaDGmCSumCTP0BKPHKz2LuhW6ddyFh/Z+VdcIcx+e8wOrh8TKc2qBEfWAG2duys
	 cDatNwimu+Dpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: nVMX: Don't flush shadow VMCS12 to guest memory
 during vCPU teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Mattson" <jmattson@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260908132838.2116068-1-jmattson@google.com>
References: <20260908132838.2116068-1-jmattson@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 13:57:36 +0000
Message-Id: <20260908135736.D14C01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Live migration during SMM with an active nested guest overwrit=
es L2 state (e.g. RIP/RSP) with stale data from the hardware shadow VMCS.
- [High] Live migration during SMM with nested shadow VMCS enabled causes a=
 Triple Fault on the destination.
- [High] During vCPU teardown, __nested_vmx_vmexit() unconditionally loads =
L1 host state, triggering a cross-process memory read via load_pdptrs() wit=
h a borrowed active_mm.
--

commit 15d3183acc0011b1c1063bab25d832a346f7a45c
Author: Jim Mattson <jmattson@google.com>

KVM: nVMX: Don't flush shadow VMCS12 to guest memory during vCPU teardown

When a vCPU is destroyed while L2 is active, KVM synthesizes a nested VM-Ex=
it.
During this process exit, the vCPU destruction runs with a borrowed lazy TL=
B=20
active_mm, so skipping the shadow VMCS12 flush prevents __copy_to_user()=20
from corrupting an unrelated task's memory.

> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 151873407abd3..33dc8a07019f8 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -5121,21 +5121,28 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u=
32 vm_exit_reason,
>  	if (likely(!vmx->fail)) {
>  		sync_vmcs02_to_vmcs12(vcpu, vmcs12);
> =20
> -		if (vm_exit_reason !=3D -1)
> +		if (vm_exit_reason !=3D -1) {
>  			prepare_vmcs12(vcpu, vmcs12, vm_exit_reason,
>  				       exit_intr_info, exit_qualification,
>  				       exit_insn_len);
> =20
> -		/*
> -		 * Must happen outside of sync_vmcs02_to_vmcs12() as it will
> -		 * also be used to capture vmcs12 cache as part of
> -		 * capturing nVMX state for snapshot (migration).
> -		 *
> -		 * Otherwise, this flush will dirty guest memory at a
> -		 * point it is already assumed by user-space to be
> -		 * immutable.
> -		 */
> -		nested_flush_cached_shadow_vmcs12(vcpu, vmcs12);
> +			/*
> +			 * Must happen outside of sync_vmcs02_to_vmcs12() as it will
> +			 * also be used to capture vmcs12 cache as part of
> +			 * capturing nVMX state for snapshot (migration).
> +			 *
> +			 * Otherwise, this flush will dirty guest memory at a
> +			 * point it is already assumed by user-space to be
> +			 * immutable.
> +			 *
> +			 * Do not flush when vm_exit_reason =3D=3D -1 (e.g. forced exit
> +			 * on vCPU teardown or SMM entry). On teardown, KVM may run
> +			 * with current->mm =3D=3D NULL on a borrowed lazy TLB mm,
> +			 * where writing guest memory would corrupt an unrelated
> +			 * task. Nothing can observe the flush in that case anyway.
> +			 */
> +			nested_flush_cached_shadow_vmcs12(vcpu, vmcs12);
> +		}
>  	} else {
>  		/*
>  		 * The only expected VM-instruction error is "VM entry with

[Severity: High]
This is a pre-existing issue, but since this patch handles vCPU teardown wi=
th
a borrowed active_mm, does the later call to load_vmcs12_host_state() in
__nested_vmx_vmexit() have a similar issue?

During vCPU teardown, __nested_vmx_vmexit() unconditionally loads L1 host
state:

arch/x86/kvm/vmx/nested.c:__nested_vmx_vmexit() {
    ...
    load_vmcs12_host_state(vcpu, vmcs12);
    ...
}

If the L1 host state uses PAE paging, nested_vmx_load_cr3() triggers the
PDPTR load:

arch/x86/kvm/vmx/nested.c:nested_vmx_load_cr3() {
    ...
    if (reload_pdptrs && !nested_ept && is_pae_paging(vcpu) &&
        CC(!load_pdptrs(vcpu, cr3))) {
    ...
}

This executes a memory read using copy_from_user() in the context of the
borrowed active_mm:

arch/x86/kvm/regs.c:load_pdptrs() {
    ...
    ret =3D kvm_vcpu_read_guest_page(vcpu, gpa_to_gfn(real_gpa), pdpte,
                                   cr3 & GENMASK(11, 5), sizeof(pdpte));
    ...
}

Could this cross-process memory read cause destructive side-effects if it h=
its
a memory-mapped I/O (MMIO) region in the unrelated task?


[Severity: Critical]
This is a pre-existing issue, but does skipping the shadow VMCS12 flush on
SMM entry (where vm_exit_reason =3D=3D -1) cause data corruption during live
migration?

In __nested_vmx_vmexit(), need_vmcs12_to_shadow_sync is prevented from being
set on SMM entry because of the vm_exit_reason check:

arch/x86/kvm/vmx/nested.c:__nested_vmx_vmexit() {
    ...
    if ((vm_exit_reason !=3D -1) &&
        (enable_shadow_vmcs || nested_vmx_is_evmptr12_valid(vmx)))
        vmx->nested.need_vmcs12_to_shadow_sync =3D true;
    ...
}

If live migration is initiated while in SMM, vmx_get_nested_state() treats
the hardware shadow VMCS as authoritative:

arch/x86/kvm/vmx/nested.c:vmx_get_nested_state() {
    ...
    else if (enable_shadow_vmcs)
        copy_shadow_to_vmcs12(vmx);
    ...
}

Since need_vmcs12_to_shadow_sync was not set, doesn't this overwrite the
correctly synced vmcs12 with stale data from the hardware shadow VMCS,
resulting in guest state rollback (e.g., RIP/RSP)?


[Severity: High]
This isn't a bug introduced by this patch, but is there a Triple Fault risk
during live migration in SMM with nested shadow VMCS enabled?

Because is_guest_mode is false in SMM, the shadow_vmcs12 is omitted from the
migration stream:

arch/x86/kvm/vmx/nested.c:vmx_get_nested_state() {
    ...
    if (is_guest_mode(vcpu) &&
        nested_cpu_has_shadow_vmcs(vmcs12) &&
        vmcs12->vmcs_link_pointer !=3D INVALID_GPA)
        kvm_state.size +=3D sizeof(user_vmx_nested_state->shadow_vmcs12);
    ...
}

On the destination, vmx_set_nested_state() skips restoring shadow_vmcs12 and
returns early:

arch/x86/kvm/vmx/nested.c:vmx_set_nested_state() {
    ...
    if (!(kvm_state->flags & KVM_STATE_NESTED_GUEST_MODE))
        return 0;
    ...
}

When the guest leaves SMM, vmx_leave_smm() checks the revision ID of the
zeroed shadow_vmcs12:

arch/x86/kvm/vmx/vmx.c:vmx_leave_smm() {
    ...
    /* Triple fault if the state is invalid.  */
    if (nested_vmx_check_restored_vmcs12(vcpu) < 0)
        return 1;
    ...
}

Could this zeroed buffer fail the revision ID check and induce a Triple Fau=
lt?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908132838.2116=
068-1-jmattson@google.com?part=3D1
