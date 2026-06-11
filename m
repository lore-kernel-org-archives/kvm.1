Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08523F44F6
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 12:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182695; cv=none; b=G/q5B/esMC5sIISH9SI8+L8pm+O2pWydd5p1XdGJ8DNUeBWUEpb4JDUABRF/MQtzKZrleAdYCJwvtVhOOpcxuaAigfjBdNIQG9OJZyFv388m3WPtT8jb5yv0g65LP5Mq3Wy2UZxAPOK3Bt4+QV4vfqzlE7qzhhDYcOEVJczzx/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182695; c=relaxed/simple;
	bh=sQyWb1dqYl4h2Q30LdxttLhVMy3fw+XDB6f1Zg6+cu8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qaGY8bSVXuQnAnu0Be0bRqdXcgKs+0EK4fj+CXS+TfHK+Y8UP1aksuPnJUCRMWz4wvUgtiAhQiXwjfzj/GeI4SreXt2r/M9aNLMTe9gvG90xEGDzUQjNKYGX2iXaHwaeuX0lYyPubR/THNY6l8vs9dvg9MHVIr0djZ1zknfJleI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FO1E7nO8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FO1E7nO8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9DBD1F00898;
	Thu, 11 Jun 2026 12:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781182693;
	bh=qUIyZ+RxwkeJxBHM3lS70DRZLrXPDp+w5H0vw7Ji4X0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FO1E7nO8Vp+tJQmt/FSA44DjnYwR3+xRILP/oZ7JrPs2gKWvvbwGHCAeC5IsJLYP3
	 zQfrqriocmUeFJEA3e46BAliUHePaTHIJ8joDSbNBHlQIu0LoQDhbp+7nFVGfVh+9p
	 nqlhW8l+pEC8IY2d31sXXTtQDzWaNYf4TnpSZ2V9sgmHfC+cyt8Oo2ydAcT7c1iOzL
	 Pk3OMNGA8ZtCAtG4EOyI0IUIbGKT1qaKRppxqNqPhtL6V/fOxxk/pJWurYd2mwH2mO
	 SAT3+kEz4C3YyCkwz62bvcpzwWeh3dtgrek/lviV6H2Hi6SCYfa1lUsXqr5m526ial
	 ktadcdDtfeMhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] kvm: svm: Defer VMSA allocation to LAUNCH_FINISH
 stage
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260611123528.572255-3-joro@8bytes.org>
References: <20260611123528.572255-3-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 12:58:13 +0000
Message-Id: <20260611125813.A9DBD1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Missing VMSA cleanup on the error path in `snp_init_kvm_vmsa()` =
causes a guest-reachable `WARN_ON_ONCE` upon retry.
- [Medium] Late vCPU creation results in KVM's INVALID_PAGE sentinel being =
passed directly to the hardware PSP firmware when dumping VMCB.
--

commit 31275eaac0590092737efa334c2a33922a5b5fd9
Author: Joerg Roedel <joerg.roedel@amd.com>

kvm: svm: Defer VMSA allocation to LAUNCH_FINISH stage
   =20
Do not allocate a KVM-managed VMSA for all VCPUs on VCPU creation,
defer it to the LAUNCH_FINISH stage of SEV-ES and SEV-SNP. At this
stage the VMSAs get used for the first time.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 9e00aa7bdca8c..0aa62cb802fe5 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c

[ ... ]

> @@ -2689,12 +2700,14 @@ static int snp_launch_update_vmsa(struct kvm *kvm=
, struct kvm_sev_cmd *argp)
> =20
>  	kvm_for_each_vcpu(i, vcpu, kvm) {
>  		struct vcpu_svm *svm =3D to_svm(vcpu);
> -		void *vmsa =3D sev_es_vmsa_ref(vcpu);
> +		void *vmsa;
> =20
>  		ret =3D sev_es_sync_vmsa(svm);
>  		if (ret)
>  			goto out;
> =20
> +		vmsa =3D sev_es_vmsa_ref(vcpu);
> +
>  		ret =3D sev_es_vcpu_vmsa_make_private(vcpu);
>  		if (ret)
>  			goto out;

[Severity: Medium]
Does this error path leak the newly allocated VMSA?

Since sev_es_sync_vmsa() now allocates the VMSA, if
sev_es_vcpu_vmsa_make_private() fails, the code returns via the "out" label
without freeing the VMSA or resetting its state.

If userspace retries the KVM_SEV_SNP_LAUNCH_FINISH ioctl, sev_es_sync_vmsa()
is called again and will trigger the WARN_ON_ONCE() in
sev_es_vcpu_alloc_vmsa() because the state is still VMSA_SHARED:

    if (WARN_ON_ONCE(svm->sev_es.vmsa.vmsa_state !=3D VMSA_NONE))
        return -EINVAL;

Can we add a call to sev_es_vcpu_free_vmsa() on this error path?

[ ... ]

> @@ -4889,22 +4906,11 @@ void sev_init_vmcb(struct vcpu_svm *svm, bool ini=
t_event)
>  int sev_vcpu_create(struct kvm_vcpu *vcpu)
>  {
>  	struct vcpu_svm *svm =3D to_svm(vcpu);
> -	int ret;
> =20
>  	mutex_init(&svm->sev_es.snp_vmsa_mutex);
> =20
> -	if (!is_sev_es_guest(vcpu))
> -		return 0;
> -
> -	/*
> -	 * SEV-ES guests require a separate (from the VMCB) VMSA page used to
> -	 * contain the encrypted register state of the guest.
> -	 */
> -	ret =3D sev_es_vcpu_alloc_vmsa(vcpu);
> -	if (ret)
> -		return ret;
> -
> -	vcpu->arch.guest_tsc_protected =3D snp_is_secure_tsc_enabled(vcpu->kvm);
> +	if (is_sev_es_guest(vcpu))
> +		vcpu->arch.guest_tsc_protected =3D snp_is_secure_tsc_enabled(vcpu->kvm=
);
> =20
>  	return 0;
>  }

[Severity: Medium]
Does removing this allocation lead to KVM's INVALID_PAGE sentinel being pas=
sed
to the PSP firmware?

If userspace creates a vCPU after the SEV-ES or SEV-SNP launch sequence has
completed, the new vCPU's VMSA is never allocated.

When this vCPU is run, sev_es_vmsa_pa() returns KVM's INVALID_PAGE sentinel
(~0ull), which is loaded into the VMCB, triggering an immediate #VMEXIT
(SVM_EXIT_ERR).

If the dump_invalid_vmcb parameter is enabled, KVM handles this by calling
dump_vmcb(), which then calls sev_decrypt_vmsa(). Since sev_es_vmsa_ref()
returns NULL for VMSA_NONE, sev_decrypt_vmsa() erroneously assumes the VMSA
is encrypted and passes the INVALID_PAGE sentinel directly to the PSP
firmware as the source physical address for SEV_CMD_DBG_DECRYPT:

    data.src_addr =3D svm->vmcb->control.vmsa_pa;
    data.len =3D PAGE_SIZE;

    ret =3D sev_issue_cmd(vcpu->kvm, SEV_CMD_DBG_DECRYPT, &data, &argp_err);

Could this direct hardware exposure to an invalid page address risk firmware
hangs or IOMMU faults?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611123528.5722=
55-1-joro@8bytes.org?part=3D2
