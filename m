Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E943833BBA7
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 23:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780960901; cv=none; b=q3tjElGX9kK/gihAcvRr2KQUDS9ekl0unMAmKJIjtaAUgnD0RmpqVS87w/KP5dqs3dI4OeXh9Ch6fPE4ND4fHAsun6koZuI0y70+53w7bp1ECEbx9mhpTe00Lcx7ORwIOYawC6Y3KiTD8VfwSrdFVRRDxecMlFuZon9wb4g9aQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780960901; c=relaxed/simple;
	bh=f4bFS8D7VoioQ27Rb43CJ+vmZezJOeZM1VcTKPaBg68=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mTsfW5gEV+ZMU+qThR7JntpILXCdzGX4PG4KPiE6EAZd72Vzgj1GF+OAQGRu0oRtRIfsbQwtz7wJEdatBW29gwbfg3sNN/M74YXksrJCOlGMedUP+7SdEKWggVM+izGf6qRaKt3MffHPIIxgcq8ZpU8cCAfHoYYImh1vcVKN8o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJHQfmC4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJHQfmC4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E8F1F00893;
	Mon,  8 Jun 2026 23:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780960899;
	bh=7NeBmDVSRGcBwv6YwY84avh6AEszEyCHvDflgmgybWI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZJHQfmC4o9P+BjVBnQkt5Hw+NZlmJTJW1NlWr9GV9OBjqWvUHEZvcYajbcbdfMeC4
	 TQR+37j4cnULHbHkjHlQLJeIYgFi6QoIw89s4Ui7W6aE8ijb6bmkoE18iQ3TkOILdP
	 3Wb2Eg0c9ncd27Cl/39HmEo0rb/u3w3C1RyZn8OeoskIT6qv9E5r6vgZXaH3GAFONw
	 WKStqVX26cjYd/0Y6b8HF3nGQ/zKAGY+GcO73XN20B553gz88OarJNnW9tIb/AYnK6
	 /sa+qM8uAyy/0WfQw/YfXBUKI8UMb5bCfHiV23l3rLdOq1Y1q4E4YosmHA41WyL19e
	 y/cDSWcQSf00A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 58/60] kvm: svm: Invoke a specified VMPL level VMSA for
 the vCPU
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-59-joro@8bytes.org>
References: <20260608144252.351443-59-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 23:21:39 +0000
Message-Id: <20260608232139.61E8F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The MSR protocol handler for GHCB_MSR_VMPL_REQ propagates `-EINVAL=
` to KVM_RUN when a requested VMPL plane does not exist, causing the VM to =
crash.
- [High] Requesting a switch to the currently active VMPL puts the active v=
CPU plane into the STOPPED state, permanently hanging the vCPU thread.
- [High] Missing array_index_nospec() on guest-controlled VMPL index create=
s a Spectre v1 vulnerability.
--

commit 13abcdff43b65b23c1d479626cab3e83b513a2c8
Author: Tom Lendacky <thomas.lendacky@amd.com>

kvm: svm: Invoke a specified VMPL level VMSA for the vCPU

Implement the SNP Run VMPL NAE event and MSR protocol to allow a guest to
request a different VMPL level VMSA be run for the vCPU. This allows the
guest to "call" an SVSM to process an SVSM request.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 0b531eda062f3..70a06769a4100 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
[ ... ]
> @@ -4573,6 +4577,45 @@ static void sev_get_apic_ids(struct vcpu_svm *svm)
>  	kvfree(desc);
>  }
> =20
> +static int __sev_snp_run_vmpl(struct vcpu_svm *svm, unsigned int vmpl)
> +{
> +	struct kvm_vcpu *vcpu =3D &svm->vcpu;
> +	struct kvm_vcpu *target =3D vcpu->common->vcpus[vmpl];
> +	struct vcpu_svm *target_svm =3D to_svm(target);
> +
> +	if (!target)
> +		return -EINVAL;
> +
> +	/* Mark current plane as stopped so it is not selected */
> +	kvm_set_mp_state(target, KVM_MP_STATE_RUNNABLE);
> +	/* In case KVM_REQ_UPDATE_PROTECTED_GUEST_STATE is set - mark the new V=
MSA as runnable */
> +	target_svm->sev_es.snp_ap_runnable =3D true;
> +	kvm_vcpu_set_plane_runnable(target);
> +	kvm_vcpu_set_plane_stopped(vcpu);

[Severity: High]
If a guest requests a switch to the VMPL level it is already executing on,
target and vcpu will point to the same object.  Will this sequence
cause the vCPU to hang?

Since kvm_vcpu_set_plane_runnable(target) is immediately followed by
kvm_vcpu_set_plane_stopped(vcpu), the plane's state would be overwritten
to STOPPED, indefinitely suspending the vCPU.

Should there be an explicit check for target =3D=3D vcpu to handle this?

> +
> +	kvm_make_request(KVM_REQ_PLANE_RESCHED, vcpu);
> +
> +	return 1;
> +}
> +
> +static int sev_snp_run_vmpl(struct vcpu_svm *svm)
> +{
> +	struct ghcb *ghcb =3D svm->sev_es.ghcb;
> +	struct kvm_vcpu *vcpu =3D &svm->vcpu;
> +	unsigned int vmpl;
> +
> +	vmpl =3D lower_32_bits(svm->vmcb->control.exit_info_1);
> +	if (vmpl >=3D SVM_SEV_VMPL_MAX) {
> +		vcpu_unimpl(vcpu, "vmgexit: invalid VMPL level [%u] from guest\n", vmp=
l);
> +		return -EINVAL;
> +	}

[Severity: High]
Since vmpl is guest-controlled and used as an index into the
vcpu->common->vcpus[vmpl] array in __sev_snp_run_vmpl(), is there a risk
of speculative out-of-bounds execution here?

Should vmpl be sanitized with array_index_nospec() after this bounds
check to prevent a potential Spectre v1 vulnerability?

> +
> +	ghcb_set_sw_exit_info_1(ghcb, 0);
> +	ghcb_set_sw_exit_info_2(ghcb, 0);
> +
> +	return __sev_snp_run_vmpl(svm, vmpl);
> +}
> +
[ ... ]
> @@ -4684,6 +4727,27 @@ static int sev_handle_vmgexit_msr_protocol(struct =
vcpu_svm *svm)
> =20
>  		ret =3D snp_begin_psc_msr(svm, control->ghcb_gpa);
>  		break;
> +	case GHCB_MSR_VMPL_REQ: {
> +		unsigned int vmpl;
> +
> +		if (!sev_snp_guest(vcpu->kvm))
> +			goto out_terminate;
> +
> +		vmpl =3D get_ghcb_msr_bits(svm, GHCB_MSR_VMPL_LEVEL_MASK, GHCB_MSR_VMP=
L_LEVEL_POS);
> +
> +		set_ghcb_msr_bits(svm, 0, GHCB_MSR_VMPL_ERROR_MASK, GHCB_MSR_VMPL_ERRO=
R_POS);
> +		set_ghcb_msr_bits(svm, 0, GHCB_MSR_VMPL_RSVD_MASK, GHCB_MSR_VMPL_RSVD_=
POS);
> +		set_ghcb_msr_bits(svm, GHCB_MSR_VMPL_RESP, GHCB_MSR_INFO_MASK, GHCB_MS=
R_INFO_POS);
> +
> +		if (vmpl >=3D SVM_SEV_VMPL_MAX) {
> +			vcpu_unimpl(vcpu, "vmgexit: invalid VMPL level [%u] from guest\n", vm=
pl);
> +			set_ghcb_msr_bits(svm, 1, GHCB_MSR_VMPL_ERROR_MASK, GHCB_MSR_VMPL_ERR=
OR_POS);
> +			break;
> +		}

[Severity: High]
Similar to sev_snp_run_vmpl(), does this guest-controlled vmpl index require
array_index_nospec() after the bounds check to mitigate Spectre v1?

> +
> +		ret =3D __sev_snp_run_vmpl(svm, vmpl);
> +		break;

[Severity: High]
If target =3D=3D NULL inside __sev_snp_run_vmpl(), it returns -EINVAL which
is then assigned to ret here and propagated up.  Will this cause the
KVM_RUN ioctl to return -EINVAL to userspace?

Since QEMU treats negative returns from KVM_RUN as fatal errors and aborts
the VM, could a less privileged guest level (e.g., VMPL3) exploit this to
intentionally crash the VM and disrupt more privileged levels?

Should the MSR handler trap the negative return, set GHCB_MSR_VMPL_ERROR_MA=
SK
in the response, and return 1 to safely resume the guest instead?

> +	}
>  	case GHCB_MSR_TERM_REQ: {
>  		u64 reason_set, reason_code;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D58
