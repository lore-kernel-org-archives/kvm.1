Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8195C46C4A1
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 20:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784924017; cv=none; b=hAFv69xvWTFOXV8AmOklJJ5VQXwh5ZI2gf43U6rwISj8YstN7pU1v0ZUwAYTkMN7v4okkimbfq7RcvEjk6yrwAUnzVvK4UWMLYBazARdQ65fYQauurSOc4jS7XpKyp9rW8Ez9n5o9wlCTu6jmlWxJO+FJu0mhoVKOY+5WFQI2oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784924017; c=relaxed/simple;
	bh=5TCgqk1F9jIbI06nTdZXZbikejN7aJHVBla8knFF/bg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XBbnGU4ir8E8wBf7UDaukJs/kh7W4brJdwyh9pXK4HsN7YSJqPmR/rG4L9L3KtOUUA0dpV+6veXo1zWLN0QZCLSQGXjuS+zHBi6PQ2gMvgbTUbUj7BVdsclO5ws9nUzzulSqy0u57Awh3zH3LakhWwPfO1WQvylzF4foWE/Eu1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WejnO+dv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WejnO+dv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4231F000E9;
	Fri, 24 Jul 2026 20:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784923998;
	bh=XtVB03nmcIY4EoAr//5MJFlFAngUTXra7cK9iiUzy7o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WejnO+dvqM6ikBco9t9H0GJyIFRVdJ1pvlc7JJv/7EHvekFQS8IGmjC1rw3jRv8+t
	 al4u78EjgIEr0rtI9fPB9WZhLoMbMmCxfMvAx1eMKm6gY9YROseghPVuFMY9Nb7ggj
	 sZZyKu05txWudANx7EnKHiJcIMJazTADpoCMSrdjLuUyP7ZZ/KvvzAzbjAqbfGSURy
	 IYl4ybCrnfDXMZAD+gW6XVi5ljr4wet4v8fR0xuDbXLp/ovTFvsEFmp+GNgE0/aN6n
	 /4eYuCZ/nP/KagVFyZHEtUuD9wTSsA/dC506wHfOirgLl0qCaC8jUc+cnSBORDzjPk
	 mJWDTh+kUKs4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/7] KVM: SVM: Emulate guest accesses to LBR v2 MSRs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivansh Dhiman" <shivansh.dhiman@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260724195040.630468-4-shivansh.dhiman@amd.com>
References: <20260724195040.630468-1-shivansh.dhiman@amd.com>
 <20260724195040.630468-4-shivansh.dhiman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 20:13:18 +0000
Message-Id: <20260724201318.8A4231F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] LBRv2 emulation ignores the `lbrv` module parameter, allowing gues=
t LBRv2 usage even when LBR Virtualization is globally disabled.
- [High] The newly added LBR v2 MSRs are missing from KVM's list of saveabl=
e MSRs, causing them to be silently dropped during live migration.
- [High] Missing nested SVM state synchronization for LBRv2 fields causes s=
tate corruption and cross-tenant information leaks between L2 guests.
--

--- Patch [3]: [PATCH 3/7] KVM: SVM: Emulate guest accesses to LBR v2 MSRs =
---
commit ea17366da9bcd5ccfa5c4c9307a6f68cda7d1255
Author: Shivansh Dhiman <shivansh.dhiman@amd.com>

KVM: SVM: Emulate guest accesses to LBR v2 MSRs
   =20
Back the LBR v2 MSRs with their VMCB save-area fields in
svm_{get,set}_msr(). This is required when guest accesses to these
MSRs are intercepted. This allows the guest to retain the values
of these MSRs on VMRUN/#VMEXIT cycle when vLBR is disabled.

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index ef69a51ab27f9..13ac62604ca05 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c

[ ... ]

> @@ -744,6 +744,12 @@ static void svm_recalc_lbr_msr_intercepts(struct kvm=
_vcpu *vcpu)
>  	svm->lbr_msrs_intercepted =3D intercept;
>  }
> =20
> +static bool svm_lbrv2_supported(struct kvm_vcpu *vcpu)
> +{
> +	return guest_cpu_cap_has(vcpu, X86_FEATURE_AMD_LBR_V2) &&
> +	       kvm_vcpu_has_mediated_pmu(vcpu);
> +}

[Severity: High]
Does this capability check need to respect the global lbrv module parameter?

Unlike the legacy LBR logic which explicitly checks lbrv, this function only
checks the X86_FEATURE_AMD_LBR_V2 capability.=20

Could this allow a local guest to bypass the host administrator's explicit
disablement of LBR Virtualization (when loaded with lbrv=3D0) by directly
accessing LBRv2 MSRs?

[ ... ]

> @@ -2882,6 +2901,21 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, stru=
ct msr_data *msr_info)
>  	case MSR_IA32_LASTINTTOIP:
>  		msr_info->data =3D lbrv ? *svm_vmcb_lbr(svm, msr_info->index) : 0;
>  		break;
> +	case MSR_AMD_DBG_EXTN_CFG:
> +		if (!svm_lbrv2_supported(vcpu))
> +			return KVM_MSR_RET_UNSUPPORTED;
> +		msr_info->data =3D svm->vmcb->save.dbg_extn_cfg;
> +		break;

[Severity: High]
Are these new LBR v2 MSRs missing from KVM's list of saveable MSRs?

Because the new LBRv2 MSRs (MSR_AMD_DBG_EXTN_CFG, MSR_AMD64_LBR_SELECT, and
the MSR_AMD_SAMP_BR_FROM array) are omitted from msrs_to_save_base in
arch/x86/kvm/msrs.c, they won't be returned to the VMM by
KVM_GET_MSR_INDEX_LIST.

Will this cause the LBRv2 state to be silently dropped during live migratio=
n?

[ ... ]

> @@ -3181,6 +3215,40 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, stru=
ct msr_data *msr)
>  		*svm_vmcb_lbr(svm, ecx) =3D data;
>  		vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
>  		break;
> +	case MSR_AMD_DBG_EXTN_CFG:
> +		if (!svm_lbrv2_supported(vcpu))
> +			return KVM_MSR_RET_UNSUPPORTED;
> +
> +		if (data & DBG_EXTN_CFG_RESERVED_BITS)
> +			return 1;
> +
> +		if (svm->vmcb->save.dbg_extn_cfg =3D=3D data)
> +			break;
> +
> +		svm->vmcb->save.dbg_extn_cfg =3D data;
> +		vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
> +		svm_update_lbrv(vcpu);
> +		break;

[Severity: High]
Does nested SVM state synchronization need to be updated for these new LBRv2
fields?

Looking at nested virtualization, L2 guest state is synchronized using
svm_copy_lbrs() in arch/x86/kvm/svm/svm.h, which is called during
nested_vmcb02_prepare_save().

Because svm_copy_lbrs() was not updated to copy the new dbg_extn_cfg,
lbr_select, and lbr array fields, vmcb02 can retain a previous L2 guest's
branch records. When a new L2 guest reads its MSRs, it could observe the pr=
ior
L2 guest's execution trace.

Additionally, upon nested_svm_vmexit(), wouldn't L2 modifications be dropped
because they aren't copied back to L1's vmcb12?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724195040.6304=
68-1-shivansh.dhiman@amd.com?part=3D3
