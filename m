Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ECD5221ED
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 10:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788864577; cv=none; b=Xgue9JPAGPGg4VN9+nSY63m+ykQkqKE/1bfLDEFLqfmriXPsrEdMiprrmWTINJU+pQjr0EdfiwAiLpDSoAUddeFxdb674oPjJgFUjMGMsp0m6xkicbFBDOu3OB7pw6+wTq0RW1wbvtqcoFnkhitRZxQQIWnN/5bkpGPlpyrS4jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788864577; c=relaxed/simple;
	bh=3ESfzKxigBzI7MbibUfUdTFC9HvgFR+KIHgNABQE51c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pykb1gagEhQW73OvdL8jGDPuPwZjo4HeMRMBiAykhcQ1yNioyYAFHiA+BKpldgVcZLxAL9W/vRIXHyF+0GdkQFS3W2pAZHxu9+bCwE7W2o1wR0xM4MD437AQltnCC5WRp2CEnLflJz30u4lmKVUArIKtFcjUfjILN+wXhZQL8aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VerKfno2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VerKfno2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5520B1F00A3A;
	Tue,  8 Sep 2026 10:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788864573;
	bh=OkaR47eVJ9sboA4LyZDdFV1z8oWa7iLII/R9TTKaezs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VerKfno2eHTGP2Lqh52Vntd6Y/9RHPsj7+awgiJ2tEKmUfdVZJNxX3dKMgGcOGlpo
	 f4JuSh643CgHH5rAynVDG/qpislJl3dPWzFH0SviM8f5vRl5J1JGf62udL2P31k2NT
	 3Y7Cc+fyOC5lqPICxYvwEAU+Rha2Bo2eWRi//kaXIrHPvVTxh3ipkVBNSCRkCKOECG
	 DcBd6/zp9ClZj/PuWx/noW2GCIWRXmJRX722OyLalNb0wKoxPSAqMVTMfG4z1PBqWo
	 1l+mG7OxBpnETvJMhTHZ9CXI3zJCPPeAeymqQcppedppJ/TACnNKRqK9tVNCrJ7Kxu
	 1vhmVR0+QpbJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/8] KVM: SEV: Add SNP vCPU state get and set
 commands
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260908103338.427254-7-joro@8bytes.org>
References: <20260908103338.427254-1-joro@8bytes.org>
 <20260908103338.427254-7-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 10:49:28 +0000
Message-Id: <20260908104933.5520B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] KVM_SEV_SNP_GET_VCPU_STATE silently hides the configured VMSA GPA =
during transient MMU invalidations, causing state loss during live migratio=
n.
- [High] KVM_SEV_SNP_SET_VCPU_STATE incorrectly rejects valid 2MB-aligned V=
MSA GPAs.
--

commit ccc907edf743bac6d650ebf0b64bb61800fedfea
Author: Joerg Roedel <joerg.roedel@amd.com>

KVM: SEV: Add SNP vCPU state get and set commands

Add KVM_SEV_SNP_GET_VCPU_STATE and KVM_SEV_SNP_SET_VCPU_STATE as
vCPU-scoped KVM_MEMORY_ENCRYPT_OP commands and advertise
KVM_CAP_SNP_VCPU_STATE.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 7a9ef1bc54e9d..3e0727e251a93 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
[ ... ]
> @@ -2585,6 +2587,89 @@ static int snp_launch_update_vmsa(struct kvm *kvm,=
 struct kvm_sev_cmd *argp)
>  	return ret;
>  }
> =20
> +static int snp_get_vcpu_state(struct kvm_vcpu *vcpu,
> +			      struct kvm_sev_cmd *argp)
> +{
> +	struct vcpu_svm *svm =3D to_svm(vcpu);
> +	struct kvm *kvm =3D vcpu->kvm;
> +	struct kvm_sev_snp_vcpu_state state =3D {};
> +
> +	if (!is_sev_snp_guest(vcpu))
> +		return -ENOTTY;
> +	if (!to_kvm_sev_info(kvm)->snp_context)
> +		return -EINVAL;
> +
> +	guard(mutex)(&svm->sev_es.snp_vmsa_mutex);
> +
> +	if (VALID_PAGE(svm->sev_es.snp_guest_vmsa_gpa) &&
> +	    VALID_PAGE(svm->vmcb->control.vmsa_pa)) {

[Severity: High]
Does this safely handle transient MMU invalidations?

When a concurrent host MMU invalidation (e.g., from page migration) overlaps
with a VMSA reload, __sev_snp_reload_vmsa() will hit the retry path and set
vmsa_pa to INVALID_PAGE while correctly queuing KVM_REQ_VMSA_PAGE_RELOAD.

If userspace queries the state to migrate the VM during this window, this
check evaluates to false because vmsa_pa is INVALID_PAGE. Consequently, it
returns VMSA_VALID =3D 0 even though snp_guest_vmsa_gpa is correctly
configured. Can this cause the configured VMSA GPA to be silently
dropped and lead to state loss on the destination VM?

> +		state.vmsa_gpa =3D svm->sev_es.snp_guest_vmsa_gpa;
> +		state.valid_fields |=3D KVM_SEV_SNP_VCPU_STATE_VMSA_VALID;
> +	}
[ ... ]
> +static int snp_set_vcpu_state(struct kvm_vcpu *vcpu,
> +			      struct kvm_sev_cmd *argp)
> +{
[ ... ]
> +	if (state.valid_fields & KVM_SEV_SNP_VCPU_STATE_VMSA_VALID) {
> +		if (!PAGE_ALIGNED(state.vmsa_gpa) ||
> +		    !page_address_valid(vcpu, state.vmsa_gpa) ||
> +		    IS_ALIGNED(state.vmsa_gpa, PMD_SIZE))

[Severity: High]
Is it intended to reject perfectly valid 4KB-aligned VMSA GPAs if they happ=
en
to fall on a 2MB boundary?

A guest OS or userspace VMM linearly allocating memory might naturally land=
 on
a 2MB-aligned address (e.g., 0x200000). The IS_ALIGNED(state.vmsa_gpa,
PMD_SIZE) condition evaluates to true for these addresses and rejects them
with -EINVAL, which can cause sporadic VM boot or migration failures.

> +			return -EINVAL;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908103338.4272=
54-1-joro@8bytes.org?part=3D6
