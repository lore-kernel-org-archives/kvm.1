Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0240247F2F3
	for <kvm@vger.kernel.org>; Sat, 17 Oct 2026 09:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792230323; cv=none; b=j5pZ6fyzyKPD8CMNRYIdC6frgAvU7ucvGef17wNS+jfUGBWjamyI33Kvfs5iNzcwxgBGeUPBblcdsWJPQAFVp5QMulE1TruLLuQLBxCcy/i4gDzcWF4wzTDV17fKQ+3bH1j1DxG871lrJYkkM6qIIaCNE+CR+XlHPL1VIb3tO+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792230323; c=relaxed/simple;
	bh=c9QRZ2rZvPYasCBKJus9g7au3i7W00QLn+vQEpsARcA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Xv51IV96tnfvI/iqpsZHDeZlp9bG0vR+QCgyAVpzPjyGynAgA27MqAyg88CNQasllJo08qIdiGdnmmDbokQ/UnDmsJT0nsAfVC01gMgFeLL5swDKJNSKf87dJ01x8acStlm8CjprBJyq9xURpM//DLq+oqrZNMeg2XNIZenAEkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4DYs2ka; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4DYs2ka"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A921F000C4;
	Sat, 17 Oct 2026 09:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792230321;
	bh=ncvvse0yeDsjDP/L2tAjvZRN7xp9z4L2ki6Dd42Ul20=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H4DYs2katZkhUrydIhJkIT2NV2U4oELIY92zNfx+C0VP2EEAopLOhIVQMmTHkVtZZ
	 THwUZd5/P8ReDN/jUWLKKKosMHL7LPs1GgVl5KjNg3j5j8WEcLPUb1k6XwtDEWw0jY
	 kzTqlB2MrC3i9Yd3vmXV9DqfXupFCD8bEllQgEl233/W8yzwf9m0nqZDspcN9tsKjV
	 zZSerHhhkgSt6yjuZbuERI1RfFPyiFcy6OrrGmxnFRu0tCzo0vvpFhsG4NvdkBsUR9
	 NDuxV9pds9+eIWS2QeOSVJJG2lbwnWxu2Azx+H0j1dWuUFnzxaDzjUA3s9OcCAHWSw
	 vLnKo5CHhhciQ==
Message-ID: <sashiko-outbox-175448@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: nVMX: Clear nested.smm.guest_mode on a failed
 RSM-to-L2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amirmohammad Eftekhar" <amirmohammad.eftekhar@cispa.de>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261017093016.32348-1-amirmohammad.eftekhar@cispa.de>
References: <20261017093016.32348-1-amirmohammad.eftekhar@cispa.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 09:45:21 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] KVM: nVMX: free_nested() fails to clear nested.smm.guest_mode
--

commit 9761932a71b71304448767969048672413614979
Author: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>

KVM: nVMX: Clear nested.smm.guest_mode on a failed RSM-to-L2

This commit clears vmx->nested.smm.guest_mode before the vmcs12 consistency
check and L2 re-entry in vmx_leave_smm() so that a failed RSM-to-L2 does not
leave nested.smm.guest_mode set after nested.smm.vmxon has been cleared.

> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 612ab07d4100f..b704edab847be 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -8511,6 +8511,18 @@ int vmx_leave_smm(struct kvm_vcpu *vcpu, const uni=
on kvm_smram *smram)
>  	}
> =20
>  	if (vmx->nested.smm.guest_mode) {
> +		/*
> +		 * Clear smm.guest_mode up front so the failure arms below, which
> +		 * triple-fault the vCPU, cannot leave the internal pair
> +		 * (smm.guest_mode=3Dtrue, smm.vmxon=3Dfalse): smm.vmxon was already
> +		 * consumed into nested.vmxon above, and KVM_GET_NESTED_STATE
> +		 * would then serialize SMM_GUEST_MODE without SMM_VMXON, which
> +		 * KVM_SET_NESTED_STATE rejects (-EINVAL), breaking the
> +		 * save/restore round-trip.  The flag has served its only purpose
> +		 * (bringing the vCPU into this re-entry) by now.
> +		 */
> +		vmx->nested.smm.guest_mode =3D false;
> +
>  		/* Triple fault if the state is invalid.  */
>  		if (nested_vmx_check_restored_vmcs12(vcpu) < 0)
>  			return 1;

[Severity: High]
Should free_nested() in arch/x86/kvm/vmx/nested.c also clear
vmx->nested.smm.guest_mode?

As noted in the commit message, free_nested() clears vmx->nested.smm.vmxon
and frees vmx->nested.cached_vmcs12, but leaves vmx->nested.smm.guest_mode
untouched:

arch/x86/kvm/vmx/nested.c:free_nested() {
	...
	vmx->nested.vmxon =3D false;
	vmx->nested.smm.vmxon =3D false;
	vmx->nested.vmxon_ptr =3D INVALID_GPA;
	...
	kfree(vmx->nested.cached_vmcs12);
	vmx->nested.cached_vmcs12 =3D NULL;
	...
}

If a vCPU enters SMM from L2 via vmx_enter_smm() (or has SMM_VMXON |
SMM_GUEST_MODE restored via vmx_set_nested_state()), both
vmx->nested.smm.vmxon and vmx->nested.smm.guest_mode are set to true while
is_guest_mode(vcpu) is false.

If vmx_leave_nested() -> free_nested() is then called while the vCPU is in
SMM -- for example, via vmx_set_nested_state() with vmxon_pa =3D=3D INVALID=
_GPA,
or via a host-initiated write of 0 to MSR_IA32_FEAT_CTL in vmx_set_msr() --
free_nested() sets vmx->nested.smm.vmxon =3D false and frees
vmx->nested.cached_vmcs12 (setting it to NULL), while leaving
vmx->nested.smm.guest_mode =3D true.

When the guest subsequently executes RSM, emulator_leave_smm() ->
vmx_leave_smm() sees vmx->nested.smm.guest_mode =3D=3D true and calls
nested_vmx_check_restored_vmcs12(vcpu), which dereferences a NULL vmcs12:

arch/x86/kvm/vmx/nested.c:nested_vmx_check_restored_vmcs12() {
	enum vm_entry_failure_code ignored;
	struct vmcs12 *vmcs12 =3D get_vmcs12(vcpu);

	if (nested_cpu_has_shadow_vmcs(vmcs12) &&
	...
}

Similarly, leaving SMM via kvm_vcpu_ioctl_x86_set_vcpu_events() calls
kvm_leave_nested() -> vmx_leave_nested() -> free_nested(), or calling
vmx_set_nested_state() to replace an SMM_GUEST_MODE state with an
SMM_VMXON-only state relies on vmx_leave_nested() -> free_nested() to clear
the prior SMM state:

arch/x86/kvm/vmx/nested.c:vmx_set_nested_state() {
	...
	vmx_leave_nested(vcpu);

	if (kvm_state->hdr.vmx.vmxon_pa =3D=3D INVALID_GPA)
		return 0;
	...
	if (kvm_state->hdr.vmx.smm.flags & KVM_STATE_NESTED_SMM_VMXON) {
		vmx->nested.smm.vmxon =3D true;
		vmx->nested.vmxon =3D false;

		if (kvm_state->hdr.vmx.smm.flags & KVM_STATE_NESTED_SMM_GUEST_MODE)
			vmx->nested.smm.guest_mode =3D true;
	}
	...
}

Without clearing vmx->nested.smm.guest_mode in free_nested(), those paths
still leave (smm.guest_mode=3Dtrue, smm.vmxon=3Dfalse) or leak a stale
smm.guest_mode=3Dtrue into the newly restored state, causing either a NULL
pointer dereference in nested_vmx_check_restored_vmcs12() on RSM or the same
KVM_GET_NESTED_STATE / KVM_SET_NESTED_STATE round-trip failure when the gue=
st
later executes VMXON.

> @@ -8520,7 +8532,6 @@ int vmx_leave_smm(struct kvm_vcpu *vcpu, const unio=
n kvm_smram *smram)
>  			return 1;
> =20
>  		vcpu->arch.nested_run_pending =3D KVM_NESTED_RUN_PENDING;
> -		vmx->nested.smm.guest_mode =3D false;
>  	}
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017093016.3234=
8-1-amirmohammad.eftekhar@cispa.de?part=3D1
