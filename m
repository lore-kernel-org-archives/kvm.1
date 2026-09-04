Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8098B35201E
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 02:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490187; cv=none; b=nVnvjrMIZrDD8ff0Z5EBVpZxIl4IgrMJVbXRhgL5VMMSBbUj9Ih13dQrxLpz/PlL4jT+gs6PkFqX2L036X8L+NKgjCYVqGkzxo4bUHZbzQXxeXi1owkCels6uAEX8Tgup4Yt/cgRa4hfB8kC3ZccRTWlQ6BAg/iNMkjpSGWfxgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490187; c=relaxed/simple;
	bh=MB2pS5/XemP8X3A7iabOJ8YfQUknnyf2JLMHg1SgsB8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fTR4QPWa+IngjoQJZRko1MrLTa9Jrcwq5Ku9dk/rT9fxLxrF0DX+r31gkzLu1jmJ46jJGifT87pVksG/x+l6Er1mARmva2tPPCOypUH2ZAQ4hDgWc3yuSwBZ4gp1rEo5SedVPzM1mpKTHEyb911iRnyMXXnlfGGqDYSalJ1Ql6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CB4eA6vc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CB4eA6vc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34B81F000E9;
	Fri,  4 Sep 2026 02:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788490186;
	bh=9hUxKIM4Q7v26EVPG6MY/UifuXp927OMrw7M78PTFVg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CB4eA6vcunJSjkKE3N1I/HdNnZr7nTwFbErDg8aJFbx18GTIBivKmsnos0y0CfnwP
	 LSyvykfv/LJtOlRjbfMDwOC6LKoS3KyEk0Piqfo7zqtPhn0e0Wmz1uDwDQI1Cbo5PE
	 uPT0co3EOa7ZY85l6V5fp5GxSO1v6IlD7WVIFW+7M4YozjhKkFm5p5kxa7qC6pNb7F
	 wmCc1YSL9wWohyEzebMeUWZnoamS1C3pSZLn/MI7JOHsx7+c3j24fTP0/zfH0iqQDp
	 OsJ0IYG/Ga+SUibKrud0Eu2iE6uzONEtUpyRZjyVRLbPPlw3jV5BSwIelOZpX8r8fD
	 q1vqezO4CsXQg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC 1/4] KVM: nVMX: Don't copy L2's CET state to L1 if
 VM-entry didn't load it
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhao Liu" <zhao1.liu@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260904023105.1167376-2-zhao1.liu@intel.com>
References: <20260904023105.1167376-1-zhao1.liu@intel.com>
 <20260904023105.1167376-2-zhao1.liu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 02:49:45 +0000
Message-Id: <20260904024945.F34B81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] KVM fails to propagate L2's modified BNDCFGS and PAT to L1 when VM=
_EXIT_CLEAR_BNDCFGS or VM_EXIT_LOAD_IA32_PAT is clear.
--

commit cf134f2b2249852af5c9f30ff344481f932e8567
Author: Zhao Liu <zhao1.liu@intel.com>

KVM: nVMX: Don't copy L2's CET state to L1 if VM-entry didn't load it

On a nested VM-exit that disables VM_EXIT_LOAD_CET_STATE, only copy L2's
CET state from vmcs12 to vmcs01 if VM-entry really loaded that state,
i.e. don't copy when VM-entry fails before loading guest state.

> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 151873407abd3..35f0bf84b373a 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c

[ ... ]

> @@ -4856,12 +4902,13 @@ static void load_vmcs12_host_state(struct kvm_vcp=
u *vcpu,
>  	/*
>  	 * Load CET state from host state if VM_EXIT_LOAD_CET_STATE is set.
>  	 * otherwise CET state should be retained across VM-exit, i.e.,
> -	 * guest values should be propagated from vmcs12 to vmcs01.
> +	 * guest values should be propagated from vmcs12 to vmcs01, but only if
> +	 * L2's CET state is live in hardware.
>  	 */
>  	if (vmcs12->vm_exit_controls & VM_EXIT_LOAD_CET_STATE)
>  		vmcs_write_cet_state(vcpu, vmcs12->host_s_cet, vmcs12->host_ssp,
>  				     vmcs12->host_ssp_tbl);
> -	else
> +	else if (nested_l2_state_is_live(vmcs12, VM_ENTRY_LOAD_CET_STATE, l2_st=
ate))
>  		vmcs_write_cet_state(vcpu, vmcs12->guest_s_cet, vmcs12->guest_ssp,
>  				     vmcs12->guest_ssp_tbl);
> =20

[Severity: High]
This isn't a bug introduced by this patch, but this pre-existing logic error
applies to BNDCFGS and PAT in arch/x86/kvm/vmx/nested.c:load_vmcs12_host_st=
ate()
as well.

If VM_EXIT_CLEAR_BNDCFGS is false, KVM skips updating vmcs01's BNDCFGS:

    /* If not VM_EXIT_CLEAR_BNDCFGS, the L2 value propagates to L1.  */
    if (vmcs12->vm_exit_controls & VM_EXIT_CLEAR_BNDCFGS)
        vmcs_write64(GUEST_BNDCFGS, 0);

This causes L1 to incorrectly resume with its original state rather than
retaining L2's modified state.

Similarly, if VM_EXIT_LOAD_IA32_PAT is false, KVM skips updating vmcs01's P=
AT:

    if (vmcs12->vm_exit_controls & VM_EXIT_LOAD_IA32_PAT) {
        vmcs_write64(GUEST_IA32_PAT, vmcs12->host_ia32_pat);
        vcpu->arch.pat =3D vmcs12->host_ia32_pat;
    }

This causes L1 to incorrectly resume with its original PAT instead of retai=
ning
L2's modified state.

In both cases, a malicious or buggy L1 hypervisor that disables these VM-ex=
it
controls could cause L1 to resume with the wrong state (its pre-VMENTRY sta=
te
instead of L2's state). This breaks the architectural guarantee of state
preservation on VM-exit and leads to guest hypervisor state corruption.

Should we also propagate L2's modified BNDCFGS and PAT to vmcs01 when these
controls are clear, perhaps reusing the new nested_l2_state_is_live() logic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904023105.1167=
376-1-zhao1.liu@intel.com?part=3D1
