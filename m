Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B66F3BADA9
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 10:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786359281; cv=none; b=EbjGNk7rNZVQ7/taeQ363G9EpcQOgbdN+QwstD0oMB3P9vVcG+ABMfg45CQvrtwfyYmA0jqE+wo2KF1IwqjX5tMynM2iKRVK7rmE+itPw+jqOgenftw6EvwJ8IZmQUYgktcf/VkKkV2I1d5V0yheEyP5fuPjz3YP1Yv1q1fNWVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786359281; c=relaxed/simple;
	bh=icd0TDSyJFsnC/Zd5d0UYWjNtjuKzkMo/ufKb+B+XTo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j/EWcDyotMkMfzHmk/0YnfWpa/CIh/sIW7sH49GTWqRnYFz2//mZPX1z/PbLrrpcOCmcUD6mmL0e+H1M17Os/6CMihd5CKtm6o4eILm7/c6h+0+rmDmvqYAC+s2sL7PqhRxLLPaiV9+YGs+xVc7YGrxmnHH6sFCRZlCBbe2ohRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRT9WsgP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRT9WsgP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8B01F000E9;
	Mon, 10 Aug 2026 10:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786359279;
	bh=HhFtsmRs/oG/kfHXYgfusPtOZthVH9A8MzQu6CkFnnE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lRT9WsgPynODU+OVoB2S3Hfaa9XR7pAU6wOFpwT5n22qNMVx769OkSCS3lUekR7ui
	 y8pg/P5L4vZtYLy0uhbxk70ZIdjnN3Ds+cvJxN/dmFbOsbaXm3ZxNo49drs302YYWV
	 mfJgQ3muB3QTq8QI8hU7BR3Y32Vqe7sNnS1Snn6M2ZyO1rmfGzL4OoMIiZbhGKiEq+
	 wt4TmFbvPhal3wWUTaJvxhXbCRz1NEJjKgNwAY3Ea67L7F8Em3XScq9kBqG2YuB2fa
	 MgV6FSWRGClTRJXIlgmRs3O9SmfCoHNPaAd4PdlszdfUwAW3NMhEAPLYrLJdLuxSMF
	 OpDZPoKCeJLBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/8] KVM: nSVM: Add support for hardware-switched PMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sandipan Das" <sandipan.das@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <ee1f0eb2aae5f5984b5db33d89937a06a305d0dc.1786345201.git.sandipan.das@amd.com>
References: <cover.1786345201.git.sandipan.das@amd.com>
 <ee1f0eb2aae5f5984b5db33d89937a06a305d0dc.1786345201.git.sandipan.das@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 10:54:38 +0000
Message-Id: <20260810105439.6D8B01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] L1 hypervisor can bypass KVM's PMU event filter for L2 guests.
- [High] KVM's software PMU state is not context-switched between L1 and L2=
, allowing L2 MSR writes to permanently corrupt L1's PMU state and leak sta=
te.
- [Medium] KVM silently breaks PMU functionality for L1 and L2 if L1 enable=
s `V_PMC` but L0 does not use hardware-switched mediated PMU.
--

--- Patch [7]: [PATCH 7/8] KVM: nSVM: Add support for hardware-switched PMU=
 ---
commit 93d914b77cd285073e93f03a803ccbca4c41f03f
Author: Sandipan Das <sandipan.das@amd.com>

KVM: nSVM: Add support for hardware-switched PMU

This commit adds nested support for PMC virtualization. It advertises
X86_FEATURE_PERFCTR_VIRT to allow an L1 hypervisor to use it for L2 guests,
switching PMU state using vmcb02's save area.

> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 3e6c671a8dc26..666f8ca38a928 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
[ ... ]
> @@ -741,6 +742,17 @@ static bool nested_vmcb12_has_lbrv(struct kvm_vcpu *=
vcpu)
>  		(to_svm(vcpu)->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR);
>  }
> =20
> +static bool nested_vmcb12_has_vpmc(struct kvm_vcpu *vcpu)
> +{
> +	/*
> +	 * Since nested AVIC is not supported, L2 PMIs can only be delivered
> +	 * via VNMI, so make it a hard requirement.
> +	 */
> +	return guest_cpu_cap_has(vcpu, X86_FEATURE_PERFCTR_VIRT) &&
> +		nested_vnmi_enabled(to_svm(vcpu)) &&
> +		(to_svm(vcpu)->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_PMC);
> +}

[Severity: Medium]
Will this break PMU functionality if L0 does not use hardware-switched
mediated PMU?

If nested_vmcb12_has_vpmc() returns true because the guest CPUID supports
PERFCTR_VIRT and V_PMC is set in vmcb12, KVM skips the software PMU context
switch in enter_svm_guest_mode() and nested_svm_vmexit().

However, if KVM uses the legacy software PMU
(KVM_MEDIATED_PMU_CAP_HW_SWITCHED is not set), SVM_MISC2_ENABLE_V_PMC is
never set in vmcb02->control.misc_ctl2. Does this result in neither hardware
nor software PMU context switching occurring for both L1 and L2?

[ ... ]
> @@ -1065,6 +1085,9 @@ int enter_svm_guest_mode(struct kvm_vcpu *vcpu, u64=
 vmcb12_gpa, bool from_vmrun)
>  	nested_vmcb02_prepare_control(svm);
>  	nested_vmcb02_prepare_save(svm);
> =20
> +	if (!nested_vmcb12_has_vpmc(vcpu))
> +		svm_pmu_handle_nested_transition(svm);
> +

[Severity: Critical]
By skipping svm_pmu_handle_nested_transition() here, are we omitting the PMU
event filter validation for L2?

The PMU configuration is copied directly from L1's cache into vmcb02 earlier
in nested_vmcb02_prepare_save(). Without calling the transition handler,
kvm_mediated_pmu_refresh_event_filter() is bypassed. Could this allow L1 to
count restricted host events by placing forbidden selectors into vmcb12,
since hardware will load these unvalidated perf_ctl values on VMRUN?

[ ... ]
> @@ -1329,7 +1358,9 @@ void nested_svm_vmexit(struct vcpu_svm *svm)
> =20
>  	/* Exit Guest-Mode */
>  	leave_guest_mode(vcpu);
> -	svm_pmu_handle_nested_transition(svm);
> +
> +	if (!nested_vmcb12_has_vpmc(vcpu))
> +		svm_pmu_handle_nested_transition(svm);
> =20
>  	svm->nested.vmcb12_gpa =3D 0;

[Severity: High]
Since svm_pmu_handle_nested_transition() is skipped here, does KVM fail to
restore L1's software PMU state on nested exit?

Because EVNTSEL MSRs are deliberately excluded from MSR merging, L2 writes
to EVNTSEL MSRs will cause an L0 intercept. This intercept updates KVM's
shared software PMU state. If we do not context switch this software state
back to L1's values upon exiting L2, could L2 MSR writes permanently corrupt
L1's PMU tracking state and leak information?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786345201.gi=
t.sandipan.das@amd.com?part=3D7
