Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5743A3D9043
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 15:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931368; cv=none; b=VLicHWz417rA68M2vNvr7ZgpDQYDOqUKczNLOFFu/h3jyo8mLKwg7dyMl1J8+/CWbn1NSdkK+Vks+PHkEd1GGFdfwopYTsAp8OFITNRnB042l1a0mWfJ8MWYE0N9iEZ6NYCR8ukL18Z5FDQ1oq0q8OS4jDJ6qaL17bkr5hMAocs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931368; c=relaxed/simple;
	bh=F+QMA3/KcS+jWSok4SIooSaDQW+14uDY0i8vC2p6rF0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DDfnwr+iVaQU5sFYIoBjp6OXsf4Vzayilkq6qLmVuq27ot1VZinKiiIXV5TUxRyOIN+S/Qrh2yueX2BpMXsbiolrG4tBnNx26TQDGiE0wVVS7V94/Xfyb7hJBNa5QV53ppN+EyMjw9zmziGFS9LgqLXJVGrXZ29Cipw/ziJ07nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4I1YnkN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4I1YnkN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9531F00893;
	Mon,  8 Jun 2026 15:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780931367;
	bh=mP/TBLNGMEifj1Ac86Ko0a2SVMQ5/zIB9aEwAm+owJ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C4I1YnkNMZslNmX5esQp/YQoHx45wAmj8rnW+cVpRfGtKQrsUndQyhJEv736E46kL
	 FxMe9W6W+G/nmGMnp1w095pVJITcg8pkaX+9S6jFf/0U8TTiq6Zt3JKaeHyr8J5xWa
	 vJOaOm65qu6npMC5/JfOWHSkRAq1bWYQTtv93L6FmPJ3UlCPDgc9RBbti2QDaiVf4Y
	 nolnCza1adKfIN9DK7gx/HlaFGngtmpEjr6NV2XrA1dDAuFHFs4wCieSg/X7cSMjiN
	 8gmJ1gS8Kl3+i0057GmVsbxkDbriyvHxt+RvFXGDFwnc3gij/tPhU8E8Fuh5sDHKTu
	 mJjGFJMwLtO5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/60] KVM: SVM: Add support for the SEV-SNP #HV
 doorbell page NAE event
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-3-joro@8bytes.org>
References: <20260608144252.351443-3-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 15:09:26 +0000
Message-Id: <20260608150926.CA9531F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The SVM_VMGEXIT_HVDB_PAGE NAE event is unconditionally handled for=
 all SEV-SNP guests without verifying if the Restricted Injection feature i=
s active.
--

commit 365a94cc5c8c1fc632b2af221069f82dee7dea53
Author: Melody Wang <huibo.wang@amd.com>

KVM: SVM: Add support for the SEV-SNP #HV doorbell page NAE event

To support Restricted Injection, the SEV-SNP guest must register a doorbell
page for use with #HV. This is done using the #HV doorbell page NAE event.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 62b5befe0eed9..f022be532695a 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -3553,6 +3553,10 @@ static int sev_es_validate_vmgexit(struct vcpu_svm=
 *svm)
>  		    control->exit_info_1 =3D=3D control->exit_info_2)
>  			goto vmgexit_err;
>  		break;
> +	case SVM_VMGEXIT_HVDB_PAGE:
> +		if (!is_sev_snp_guest(vcpu))
> +			goto vmgexit_err;

[Severity: High]
Should this validation also verify that the Restricted Injection feature is
enabled for the vCPU?

If SVM_VMGEXIT_HVDB_PAGE is allowed for all SEV-SNP guests without checking
SVM_SEV_FEAT_RESTRICTED_INJECTION, a guest might successfully register door=
bell
pages on a VM where Restricted Injection was not negotiated. Could this cau=
se
migration to fail if the VM is moved to an older host or one that enforces =
the
feature gate?

> +		break;
>  	default:
>  		reason =3D GHCB_ERR_INVALID_EVENT;
>  		goto vmgexit_err;

[ ... ]

> @@ -4321,6 +4325,65 @@ static int snp_handle_ext_guest_req(struct vcpu_sv=
m *svm, gpa_t req_gpa, gpa_t r
>  	return 1; /* resume guest */
>  }
> =20
> +static int sev_snp_hv_doorbell_page(struct vcpu_svm *svm)
> +{
> +	struct kvm_vcpu *vcpu =3D &svm->vcpu;
> +	struct kvm_host_map hvdb_map;
> +	gpa_t hvdb_gpa;
> +	u64 request;
> +
> +	if (!is_sev_snp_guest(vcpu))
> +		return -EINVAL;

[Severity: High]
Similarly here in sev_snp_hv_doorbell_page(), is it necessary to ensure
the Restricted Injection feature is active?

KVM typically requires new guest-visible behaviors to be explicitly
negotiated. Would checking something like sev_snp_is_rinj_active(vcpu) be
needed here to prevent silently enabling the feature for guests that haven't
requested it?

> +
> +	request =3D svm->vmcb->control.exit_info_1;
> +	hvdb_gpa =3D svm->vmcb->control.exit_info_2;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D2
