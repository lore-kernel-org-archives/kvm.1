Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792445636;
	b=V3Kl9+Dy9Sxlq2d+Efn0TEoVLxFD27B1j7C0Y7tZes5StuNm01WaHHErheTSDRF/qOfY
	 lsuQFM8BqiUNkW/gYpY8SILUbXIbTrcUWnbu7kH8+7keK54RiaCjFoZvZRYyXAoWBAZxF
	 q4BGuY0vLtFh6//DcBzU7EjTvdiR+S3iFLTjjIHbfc6EU9xUo7dKDOtus2APht+7LE2OC
	 a4KY1BdrEMXFOD0pna42Bl01qjaVx3sMoG8hmVzO6U5ZjHZNfCLui7gbDg6H5YaGG5OPh
	 nvx2Jv0qvjZLRNFJV7cznamtcFuQb/Mr6GOjpfFz0wmkztlmjEBCfjKIXAYeVgY2x3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792445636;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=v6v1wiyonN12LJfyiy5fBKcDv/GOqlgwC7UxfAfltRg=;
	b=yjpyv0AQJ81HmdkEllfmgCPCqpyAsqTjL5OKCRUsAnjxAnaUgH1pGlkORZWeKLVcbaNV
	 s0Cx4T6iAcG3sUqkJI9Qk386C6dbovpsbP3YDCnyhcudgm7RPHmi3+cHNNh1hU5YJwUBx
	 6IyodRrTCNdlFBXFt+ZtzGrWJ0yXHuPrZ2oOVLRRtE38QML0kzlQ6TrprCT0hB0MVHe2o
	 swnvZajD9MtpYfiGS0q8Lvd+Mi07xwD36fwNOxXGApi3vHcW8LVa3SZ594ReDxcYLfy+F
	 4wrLjEaUbOdmvDcQmcD4mDwaw68GmTl6fVhEYru9gVtSys64qqAU1h76n1kwYVQWC+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mPh9bqNr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B58E606A31A
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 21:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mPh9bqNr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D737A1F000C4;
	Mon, 19 Oct 2026 21:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792445636;
	bh=v6v1wiyonN12LJfyiy5fBKcDv/GOqlgwC7UxfAfltRg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mPh9bqNrPD2sMz1ptVvKna2vc55tsv5AETtwtv+P9NGjXQJjTPPjWR+OS03CbSykx
	 mo2MKa7q0Lki4oqw7mFlgWwv+CePb2naENFLA4zpl84hgTddCvw/6H2ITItbUxKgRc
	 YDRzyvomxHP69eQvRJ3dqwjK0ZLMawJ+Cn3lj4ADRzk4QmGkq7uUjvoWKDWlpVxHG3
	 U6fgWsCyaCxzJu+WfFAGmVm6opOoNAkZiYvwXWpmwgcCeQCbLVHVt52A5je1ZpqwHL
	 H7W/O4VuK054HLt3EHlYdumH+VhCGZVf2a3vhlTiIwCmNCUtq5X4tVwf1TTQ9YX/gk
	 SNifOS76gq3Mw==
Message-ID: <sashiko-outbox-178262@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/12] KVM: SVM: Enable hardware-assisted LBRv2
 virtualization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivansh Dhiman" <shivansh.dhiman@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261019210532.378628-5-shivansh.dhiman@amd.com>
References: <20261019210532.378628-1-shivansh.dhiman@amd.com>
 <20261019210532.378628-5-shivansh.dhiman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 21:33:55 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] KVM: SVM: Missing VMCB_LBR dirty mark when toggling V_LBR in svm_u=
pdate_lbrv()
--

commit 46b5fce40fe2fd2edafbeb3ed6f81f7158c27cba
Author: Shivansh Dhiman <shivansh.dhiman@amd.com>

KVM: SVM: Enable hardware-assisted LBRv2 virtualization

This commit enables V_LBR when LBRv2 is active in the guest and passes
the LBRv2 MSRs through to the guest by disabling their intercepts while
branch recording is enabled.

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 428c95d7ef21b..69f9ea746bb6f 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c

[ ... ]

> @@ -897,6 +935,9 @@ static bool svm_need_lbr_virtualization(struct kvm_vc=
pu *vcpu)
>  	if (svm->vmcb->save.dbgctl & (DEBUGCTLMSR_LBR | DEBUGCTLMSR_BUS_LOCK_DE=
TECT))
>  		return true;
> =20
> +	if (svm_lbrv2_active(vcpu))
> +		return true;
> +
>  	return is_guest_mode(vcpu) &&
>  	       (svm->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR);
>  }
> @@ -919,6 +960,7 @@ void svm_update_lbrv(struct kvm_vcpu *vcpu)
>  	 * do, so always recalculate the intercepts here.
>  	 */
>  	svm_recalc_lbr_msr_intercepts(vcpu);
> +	svm_recalc_lbrv2_msr_intercepts(vcpu);
>  }

[Severity: High]
When MSR_AMD_DBG_EXTN_CFG is written and toggles DBG_EXTN_CFG_LBRV2EN,
svm_set_msr() calls svm_update_lbrv():

arch/x86/kvm/svm/svm.c:svm_set_msr() {
	...
	case MSR_AMD_DBG_EXTN_CFG:
		if (!svm_lbrv2_supported(vcpu))
			return KVM_MSR_RET_UNSUPPORTED;

		if (data & DBG_EXTN_CFG_RESERVED_BITS)
			return 1;

		if (svm->vmcb->save.dbg_extn_cfg =3D=3D data)
			break;

		svm->vmcb->save.dbg_extn_cfg =3D data;
		svm_update_lbrv(vcpu);
		break;
	...
}

In svm_update_lbrv(), __svm_enable_lbrv() or __svm_disable_lbrv() toggles
SVM_MISC2_ENABLE_V_LBR in svm->vmcb->control.misc_ctl2, and
svm_recalc_lbr_msr_intercepts() updates the legacy LBR MSR intercepts:

arch/x86/kvm/svm/svm.c:svm_update_lbrv() {
	...
	if (enable_lbrv && !current_enable_lbrv)
		__svm_enable_lbrv(vcpu);
	else if (!enable_lbrv && current_enable_lbrv)
		__svm_disable_lbrv(vcpu);
	...
	svm_recalc_lbr_msr_intercepts(vcpu);
	svm_recalc_lbrv2_msr_intercepts(vcpu);
}

Per the AMD APM, VMCB clean bit 10 (VMCB_LBR) covers the LBR virtualization
enable bit (SVM_MISC2_ENABLE_V_LBR) in addition to DBGCTL and the legacy LBR
MSRs. Unlike the MSR_IA32_DEBUGCTLMSR path in svm_set_msr(), neither the
MSR_AMD_DBG_EXTN_CFG handler nor __svm_enable_lbrv() / __svm_disable_lbrv()
marks VMCB_LBR dirty.

After a previous VMRUN has marked VMCB_LBR clean via vmcb_mark_all_clean()
in svm_vcpu_run(), can toggling DBG_EXTN_CFG_LBRV2EN leave VMCB_LBR clean in
svm->vmcb->control.clean, causing the CPU to use a stale cached value for
SVM_MISC2_ENABLE_V_LBR and DBGCTL on VMRUN while KVM stops manually
switching DEBUGCTL and disables the LBR MSR intercepts?

Should __svm_enable_lbrv() and __svm_disable_lbrv() call
vmcb_mark_dirty(svm->vmcb, VMCB_LBR)?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019210532.3786=
28-1-shivansh.dhiman@amd.com?part=3D4
