Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1C848594F
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 11:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792062203; cv=none; b=eOjQY8obn66gw6YvdfG03kbvAVR2BkeK9gftNXzh9nuE6i+wjDb2OZqqMcecWpyx2s45ZLE90mVvMK0Fqg+9SjqsFNEV27xlQomoapa1n3QUVfYSimNmL9k/vljSpR2vF3MH+zaD/LMX6s7RlreHFQx5s/b5vBX1S5OxfrVOTf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792062203; c=relaxed/simple;
	bh=0JVzGiy1ytobry7uN8ST+tMf+tjqeLNw9Tq4DZ/7HD8=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=h93s7Uxm3BFElh2PJ+pt5otT+FRo7tQYiBOaw5dsK6Z8weaVeX9hZOjAa8UocmIqmzPRDflQhBm/m+HKh2QMxagbCu8LL89jIt5qG0UCDBujCAJuiUuKBGA1H2bUIQJBqHH7BGtxnq5gr09oJ2uKJz3c/8EVWg6FwP34WVE2n7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxbiWbQG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxbiWbQG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3221F000C4;
	Thu, 15 Oct 2026 11:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792062201;
	bh=0KkMkLUNOTfMj/EU1ydMGH9FbatWMYyYQdtAVSLNc/Y=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=NxbiWbQGYu/6QNIsm7Wbl2dx7mogFD5ECehnIBoU7HtoQ3PK7hOwLoTvJzsun4VG2
	 7KsIyLK/p1sKBsAV14Tav3WWj3JRnzNORUeD4/X/tfxhEM4mhdzsT44nK4HKxqEa/2
	 Rln37BnHuSEMgGpq22/UB2C33i5oErfYqlBQvIY60LD9pNzwztCa2yrHSmLCT+u9fZ
	 5KGHDtMvFMaIhU4RFRZ9yMT4uiEsXZxsPyDvdooNHZUbIM5qtStIQbQggy9IIJnp1P
	 2642Xm73ncAZPhRxYex7qyr+9Ue1k3AaNGLpQbVv4JG+Q64Thn6FsWToEOSY5BDRkr
	 3Ozh4zu+w6Bvg==
Message-ID: <sashiko-outbox-172711@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/5] KVM: nSVM: Add nested PML emulation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nikunj A Dadhania" <nikunj@amd.com>, kvm@vger.kernel.org
In-Reply-To: <20261015103933.2088307-3-nikunj@amd.com>
References: <20261015103933.2088307-1-nikunj@amd.com>
 <20261015103933.2088307-3-nikunj@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 11:03:21 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm: nSVM: spurious PML_FULL VM-Exit injection on discarded faults
--

commit ac3a6ec9423b67a67c9dfb9dd5ebd698f451f130
Author: Nikunj A Dadhania <nikunj@amd.com>

KVM: nSVM: Add nested PML emulation

This commit emulates Page Modification Logging (PML) for nested SVM guests,
allowing L1 hypervisors to track dirty pages in their L2 guests. KVM emulat=
es
PML in software by write-protecting L2 SPTEs and logging dirty GPAs to L1's
PML buffer.

> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index af0ef678433d7..8251b38d14790 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c

[ ... ]

> @@ -63,7 +64,14 @@ static void nested_svm_inject_npf_exit(struct kvm_vcpu=
 *vcpu,
>  	if (WARN_ON_ONCE(hweight64(fault_stage) !=3D 1))
>  		fault_stage =3D PFERR_GUEST_FINAL_MASK;
> =20
> -	vmcb->control.exit_code =3D SVM_EXIT_NPF;
> +	/*
> +	 * Only the exit code differs for a PML Full; hardware leaves the
> +	 * EXITINFO fields as the nested page fault that filled the buffer
> +	 * would set them.
> +	 */
> +	vmcb->control.exit_code =3D svm->nested.pml_full ? SVM_EXIT_PML_FULL : =
SVM_EXIT_NPF;
> +	svm->nested.pml_full =3D false;
> +
>  	vmcb->control.exit_info_1 =3D fault_stage |
>  				    (fault->error_code & ~PFERR_GUEST_FAULT_STAGE_MASK);
>  	vmcb->control.exit_info_2 =3D fault->address;

[Severity: High]
If L2 triggers a legitimate but unrelated nested page fault (such as a read
fault) after a previous discarded fault left pml_full set, does this blindly
consume the lingering pml_full flag?=20

It looks like this would inject an SVM_EXIT_PML_FULL exit into L1 carrying
the error code of a read fault. Since hardware PML only logs writes, could
this architecturally impossible state crash or confuse the L1 hypervisor?

[ ... ]

> @@ -2169,6 +2200,47 @@ static gpa_t svm_translate_nested_gpa(struct kvm_v=
cpu *vcpu, gpa_t gpa,
>  	return w->gva_to_gpa(vcpu, w, gpa, access, exception);
>  }
> =20
> +static int nested_svm_write_pml_buffer(struct kvm_vcpu *vcpu, gpa_t gpa)
> +{
> +	struct vcpu_svm *svm =3D to_svm(vcpu);
> +	u16 index;
> +	gpa_t dst;
> +
> +	if (WARN_ON_ONCE(!is_guest_mode(vcpu)) || !nested_pml_enabled(svm))
> +		return 0;
> +
> +	/* The flag can be set here if the fault that raised it was discarded. =
*/
> +	if (svm->nested.pml_full)
> +		return 1;
> +
> +	index =3D svm->nested.ctl.pml_index;
> +	if (index >=3D PML_LOG_NR_ENTRIES) {
> +		svm->nested.pml_full =3D true;
> +		return 1;
> +	}

[Severity: High]
If KVM resolves or discards the page fault internally without injecting it
into L1, this leaves the pml_full flag set while L2 execution resumes.

The comment acknowledges that the flag can be left set by discarded faults.
However, is it safe to leave it set if the next fault isn't guaranteed to be
a write?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015103933.2088=
307-1-nikunj@amd.com?part=3D2
