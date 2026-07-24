Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C85279DB6
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 20:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784924263; cv=none; b=irLSgZiXyHZECyvak0nreaW9qcP09lOJU6MkJjaq0ALMWhlWp0rlSrONwQDaFmpHZumsJJkzu8hkI6udMiu7+ETjNvxWZv6ZWyGGkIDNTujuLhPd2mV0iqs4fnrnyNUxjPk7/8dPmCxwpK/n92cQuUte8NMTW9f8NYB0Arvkr3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784924263; c=relaxed/simple;
	bh=g2R3FGiYOAAYrV3DKaBXlUBck0oG1M/hnAK2QbKjIS0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MniTKU60bZFsoOMu6oNQ3KW7BIR/GHBjdkoUmOWIJGAh9o1QqE6viiJiKBMhGZCazTL7fUkiFegY/w4lRMogBJPSMW4ze5JYl/d1UV9VGGCEcos4Xut6osxvrm5tk1EcjFA59IxVplIPLgQWEiS4eWWbqZ7JmsipzUjE6SIY+No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1IhGb8D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1IhGb8D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84851F000E9;
	Fri, 24 Jul 2026 20:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784924261;
	bh=ahtp3zePoY/MnBeBpONPLtmIU6aYI+QhUxBUtj3EJPg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m1IhGb8DzyRPHAO+AEyA9uTC89KmKyRle+BxEHM8Nr/EOWxDPuslt3XHBp4FbrGMg
	 BtEI+xCTee/TxcqC+DsH7JzhxVW1QHVNQglDZhFqUPKlMWakE2ThGO1hqItGj8p2uq
	 jOF9FePyV99pIUaUhYxJ2Nx/AJZvFnUbNUz9gCG8zndLShgYYa4oFsEeww949EWP6y
	 OTHhSysLp6/WxGWawJaPiWqV+KuzSz82eUqpZ577G7/h3kvwt8t679lX1vqNQRaHrf
	 nnWBZ9Zbnl6G8/2LWHq9efk4DnJgRhaE9ezAPOP8TPr0/yvlGbt5y9xGWZ9OVxRHmM
	 GLDtFe9umwh7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/7] KVM: SVM: Enable hardware-assisted LBR v2
 virtualization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivansh Dhiman" <shivansh.dhiman@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260724195040.630468-5-shivansh.dhiman@amd.com>
References: <20260724195040.630468-1-shivansh.dhiman@amd.com>
 <20260724195040.630468-5-shivansh.dhiman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 20:17:41 +0000
Message-Id: <20260724201741.A84851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] LBRv2 MSRs and MSR_AMD_DBG_EXTN_CFG are incorrectly intercepted fo=
r SEV-ES guests, causing a fatal hardware VMRUN error and exposing a KVM_BU=
G_ON to host userspace.
- [High] Nested SVM breaks LBRv2 virtualization due to missing state copyin=
g in `svm_copy_lbrs` and missing MSRPM pass-through in KVM's merge array.
- [High] The patch fails to enumerate AMD LBRv2 in KVM's supported CPUID ca=
pabilities, rendering the feature undiscoverable.
- [High] The new LBRv2 MSRs are not added to KVM's MSR save/restore lists, =
breaking live migration.
- [High] LBRv2 virtualization bypasses the global `lbrv` module parameter, =
allowing guests to enable hardware LBR virtualization even when administrat=
ors have explicitly disabled it.
--

--- Patch [4]: [PATCH 4/7] KVM: SVM: Enable hardware-assisted LBR v2 virtua=
lization ---
commit ee1a6e59c9c7f66112084e471f36296d11c1b93d
Author: Shivansh Dhiman <shivansh.dhiman@amd.com>
Subject: KVM: SVM: Enable hardware-assisted LBR v2 virtualization

This patch enables hardware-assisted LBR v2 virtualization in KVM for AMD S=
VM.
It enables V_LBR to save and restore the guest's LBR v2 state in the VMCB,
and lazily disables interception of the LBR v2 MSRs when the guest enables
branch recording.

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 13ac62604ca05..04e386b838d38 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -750,6 +750,41 @@ static bool svm_lbrv2_supported(struct kvm_vcpu *vcp=
u)
>  	       kvm_vcpu_has_mediated_pmu(vcpu);
>  }

[Severity: High]
Is the F(AMD_LBR_V2) capability missing from kvm_cpu_cap_init()?

It appears F(AMD_LBR_V2) is missing from the initializers in
kvm_cpu_cap_init(CPUID_8000_0022_EAX) in arch/x86/kvm/cpuid.c. Since KVM
explicitly masks the host CPUID against registered capabilities, KVM will n=
ot
report AMD_LBR_V2 as supported, making the feature undiscoverable by standa=
rd
userspace VMMs.

> =20
> +static bool svm_lbrv2_active(struct kvm_vcpu *vcpu)
> +{
> +	struct vcpu_svm *svm =3D to_svm(vcpu);
> +	return svm_lbrv2_supported(vcpu) &&
> +	       (svm->vmcb->save.dbg_extn_cfg & DBG_EXTN_CFG_LBRV2EN);
> +}
> +
> +static void svm_recalc_lbrv2_msr_intercepts(struct kvm_vcpu *vcpu)
> +{
> +	struct vcpu_svm *svm =3D to_svm(vcpu);
> +	bool intercept =3D !svm_lbrv2_active(vcpu);
> +	int i;
> +
> +	if (intercept =3D=3D svm->lbrv2_msrs_intercepted)
> +		return;
> +
> +	for (i =3D 0; i < 32; i++)
> +		svm_set_intercept_for_msr(vcpu, MSR_AMD_SAMP_BR_FROM + i, MSR_TYPE_RW,=
 intercept);
> +
> +	svm_set_intercept_for_msr(vcpu, MSR_AMD64_LBR_SELECT, MSR_TYPE_RW, inte=
rcept);
> +
> +	/*
> +	 * DBG_EXTN_CFG stays permanently intercepted for non-SEV-ES guests so
> +	 * KVM can observe LBRV2EN and lazily toggle V_LBR.  SEV-ES+ guests must
> +	 * delegate LBR virtualization to the processor (per the APM), where
> +	 * intercepting LBR MSRs can be fatal, so toggle it with the rest.  See
> +	 * commit b7e4be0a224f ("KVM: SEV-ES: Delegate LBR virtualization to the
> +	 * processor").
> +	 */
> +	if (is_sev_es_guest(vcpu))
> +		svm_set_intercept_for_msr(vcpu, MSR_AMD_DBG_EXTN_CFG, MSR_TYPE_RW, int=
ercept);
> +
> +	svm->lbrv2_msrs_intercepted =3D intercept;
> +}

[Severity: High]
Can this logic incorrectly force the interception of MSR_AMD_DBG_EXTN_CFG a=
nd
LBRv2 MSRs for SEV-ES guests?

For SEV-ES guests, KVM's shadow copy of dbg_extn_cfg is always 0. Consequen=
tly,
svm_lbrv2_active() evaluates to false, causing svm_recalc_lbrv2_msr_interce=
pts()
to set intercept =3D true.

As documented in commit b7e4be0a224f, intercepting LBR MSRs when V_LBR is
enabled triggers a fatal hardware VMRUN consistency check failure.

Additionally, because MSR_AMD_DBG_EXTN_CFG is intercepted, host userspace c=
an
write to it. Writing a value with LBRv2 disabled invokes svm_update_lbrv(),
which then attempts to disable LBRV and hits a KVM_BUG_ON(is_sev_es_guest(v=
cpu))
in __svm_disable_lbrv().

[ ... ]

> @@ -886,9 +924,11 @@ void svm_update_lbrv(struct kvm_vcpu *vcpu)
>  {
>  	struct vcpu_svm *svm =3D to_svm(vcpu);
>  	bool current_enable_lbrv =3D svm->vmcb->control.misc_ctl2 & SVM_MISC2_E=
NABLE_V_LBR;
> +
>  	bool enable_lbrv =3D (svm->vmcb->save.dbgctl & DEBUGCTLMSR_LBR) ||
>  			    (is_guest_mode(vcpu) && guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV)=
 &&
> -			    (svm->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR));
> +			    (svm->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR)) ||
> +			    svm_lbrv2_active(vcpu);
> =20
>  	if (enable_lbrv && !current_enable_lbrv)
>  		__svm_enable_lbrv(vcpu);

[Severity: High]
Are we bypassing the global lbrv module parameter restriction here?

Legacy LBR virtualization correctly gates enablement behind the global lbrv
parameter.

Because svm_lbrv2_active() checks only the guest state, if a guest sets
LBRV2EN, enable_lbrv evaluates to true. This unconditionally enables hardwa=
re
LBR virtualization via __svm_enable_lbrv(), even when administrators have
explicitly disabled it with the lbrv parameter.

[ ... ]

> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index f62bf19024cc0..01dae3828a7aa 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -363,6 +363,7 @@ struct vcpu_svm {
>  	bool avic_irq_window;
>  	bool x2avic_msrs_intercepted;
>  	bool lbr_msrs_intercepted;
> +	bool lbrv2_msrs_intercepted;
> =20
>  	/* Guest GIF value, used when vGIF is not enabled */
>  	bool guest_gif;

[Severity: High]
Will the omission of the new LBRv2 fields from svm_copy_lbrs() and merge_ms=
rs
break nested SVM?

For nested SVM, svm_copy_lbrs() in arch/x86/kvm/svm/svm.h copies legacy LBR
state but omits the new LBRv2 fields, leading to state loss across nested
transitions.

Furthermore, the new LBRv2 MSRs are absent from the merge_msrs array in
arch/x86/kvm/svm/nested.c, which defeats hardware acceleration by breaking
MSRPM pass-through for L2.

[Severity: High]
Are there missing entries in the MSR save/restore lists required for live
migration?

The new LBRv2 MSRs are missing from msrs_to_save_base or msrs_to_save_pmu
in arch/x86/kvm/msrs.c. Without these entries, they will not be included in
KVM_GET_MSR_INDEX_LIST, which leads to silent data loss of hardware state
across live migrations.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724195040.6304=
68-1-shivansh.dhiman@amd.com?part=3D4
