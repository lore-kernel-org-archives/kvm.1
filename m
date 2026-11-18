Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010114;
	b=F4Umdu8+/DhlcVtOsAqSDeCEtAMmWKHspxr05pDxgUF2Vmjtm/urJFU88zJjeezlk2Xb
	 QSuhkDMm+UwoqzA0EHsyWvV2kSvrB/dPnKF5mF5QsxBUjUjFY6ymHOciXEjtDAWl2avhe
	 OUBWOQ9RpuaIeoFhziwm9iYCzLsnYyYnOdHouHcDs4ht4AiOzPZaD+UIqUx74Gn7FSF6w
	 z3/jqZpGJehr55KiHzijffh2uQ6aWyuDx0OMSL6z34Jk0SGSDdTQRUucs1SmUX4sImkZZ
	 c5t8j09m6M+Xxae9DxLe5pGx7xpeMRDTiXFTvulljOknviDTr4ULuP0QpqaMkQqQztg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010114;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PxxKb/fT4JG9lU+6ueEodLwtvzk6Bf3gDfN+CTNaJZg=;
	b=dkoTgiCMyVeoX7/YaHW0sn2eeOuv9iYqK4I5ugZP2XOboxvtDl/83vir5sBsjAgGM/0k
	 zfF7awu1fSl2dIyjZ8CjlZmzItGVCd2n+T6FHOEd6knNIC40+SFR/qvU3v3SlzPWMmJNI
	 wIg9p+LS6f3nKb6Ccg6DhEuMHwor0I6s98elwij6lLv0Y/+8H9lRiivzk8MdzB0i9KtZV
	 1o80XEnSLTHWYKqTxqAJrIPb5xuxVouIEZy+DmLaHTMo39L+3omeUz1YiZ5Ily8bLKGLn
	 PzJXkT9rUFDOkFluLpRX+0ZzQ8x+wbdE76YdgAfS6CYYqgjzGnyni7ZLa6eAmJQeGlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dRWIAIte;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B21606A337
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 13:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dRWIAIte
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4D21F000C4;
	Wed, 18 Nov 2026 13:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795010114;
	bh=PxxKb/fT4JG9lU+6ueEodLwtvzk6Bf3gDfN+CTNaJZg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=dRWIAIte5tvYzgTszudqzz1YFQB1Rz+3auoUbYXXxR9zaMDlB4BHFV5Y2cInyU1ln
	 tHH9H/WtNPxp9XaWhK/9cq1vKmnZKVOa1IdA25ChBj07q0PTZL8gNmZTufBzraJ1Oa
	 qyiYkeY2wiAuo7NtaF1madczaDG/VL+hpEYlGTe5b8zMIQTbtmcn4IWp3Q8yp48cEi
	 UbcOFc8hRnlkuetV+v0jT241FXeWHQ/oYYzK5xHrYRD0lC3Tu3vVLgHMW8EYKstuZm
	 CdC5M6CRP5+m5FzP/cFfi1Rad3qPIy9g0nq4/e9aUzIlOf5ztKjI2ShhqK7PlobTgt
	 SjNpWUsX9oHLw==
Message-ID: <sashiko-outbox-221100@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: nSVM: Reject EVENTINJ of #BR/#OF into a 64-bit L2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manuel Andreas" <manuel.andreas@tum.de>, kvm@vger.kernel.org
In-Reply-To: <20261118133741.1185904-1-manuel.andreas@tum.de>
References: <20261118133741.1185904-1-manuel.andreas@tum.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 13:55:13 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] KVM: nSVM: missing EFER.LMA normalization in
  nested_vmcb02_prepare_save() [1]
--

commit bd07241cd6a52030415a707aa3b0f77f55f74c7c
Author: Manuel Andreas <manuel.andreas@tum.de>

KVM: nSVM: Reject EVENTINJ of #BR/#OF into a 64-bit L2

This commit rejects VMCB12 EVENTINJ of #BR or #OF into a 64-bit L2 guest in
nested_svm_check_cached_vmcb12(), deriving 64-bit mode from EFER.LME,
CR0.PG, CR4.PAE, and CS.L.

> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 1cecb82702e2c..c69d334e3c3c5 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
[ ... ]
> @@ -398,6 +400,31 @@ static bool nested_svm_check_event_inj(struct kvm_vc=
pu *vcpu, u32 event_inj)
>  	return true;
>  }
> =20
> +/*
> + * #BR and #OF are invalid in 64-bit mode, but not in compatibility mode,
> + * hence the CS.L check. VMRUN ignores EFER.LMA and derives
> + * long mode from EFER.LME, CR0.PG and CR4.PAE, so do the same.
> + */
> +static bool nested_svm_check_event_inj_mode(u32 event_inj,
> +					    struct vmcb_save_area_cached *save)
> +{
> +	u32 type =3D event_inj & SVM_EVTINJ_TYPE_MASK;
> +	u8 vector =3D event_inj & SVM_EVTINJ_VEC_MASK;
> +
> +	if (!(event_inj & SVM_EVTINJ_VALID))
> +		return true;
> +
> +	if (!((save->efer & EFER_LME) && (save->cr0 & X86_CR0_PG) &&
> +	     (save->cr4 & X86_CR4_PAE) && (save->cs.attrib & SVM_SELECTOR_L_MAS=
K)))
> +		return true;

[Severity: High]
This problem wasn't introduced by this patch, but since VMRUN ignores
EFER.LMA, can nested_vmcb02_prepare_save() leave EFER_LMA clear in
vcpu->arch.efer [1] when entering a 64-bit L2 whose VMCB12 save area
has EFER_LME=3D1, X86_CR0_PG=3D1, and EFER_LMA=3D0?

arch/x86/kvm/svm/nested.c:nested_vmcb02_prepare_save() {
	...
	/* SVM ignores EFER.LMA if EFER.LME=3D0 (instead of failing VMRUN). */
	if (!(svm->nested.save.efer & EFER_LME))
		svm->nested.save.efer &=3D ~EFER_LMA;

	svm_set_efer(vcpu, svm->nested.save.efer);

	svm_set_cr0(vcpu, svm->nested.save.cr0);
	...
}

arch/x86/kvm/svm/svm.c:svm_set_cr0() {
	...
	if (vcpu->arch.efer & EFER_LME) {
		if (!is_paging(vcpu) && (cr0 & X86_CR0_PG)) {
			vcpu->arch.efer |=3D EFER_LMA;
	...
}

nested_vmcb02_prepare_save() only clears EFER_LMA when EFER_LME is clear,
and svm_set_cr0() only sets EFER_LMA when transitioning from !is_paging().
Because L1 already has paging enabled on VMRUN, is_paging(vcpu) is true
when svm_set_cr0() runs, leaving vcpu->arch.efer with EFER_LMA=3D0.

As a result, KVM miscomputes L2's long mode and MMU role state, and a
subsequent MSR_EFER write via set_efer() triggers WARN_ON_ONCE((efer &
EFER_LMA) !=3D (vcpu->arch.efer & EFER_LMA)) and injects a spurious #GP into
L2.

[1] https://sashiko.dev/#/bug/linux-d0314b95-e275-4bc2-be19-05c208604a98

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118133741.1185=
904-1-manuel.andreas@tum.de?part=3D1
