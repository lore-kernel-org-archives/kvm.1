Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3C92F8EBB
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 22:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780958752; cv=none; b=POGD6qji1DsTANfEg4Sp9F0hVQcOkZH7cngG+VvqyQGCreQkNlQumz7a7I+68gRt6m4J/3A5zISpmkx5tXW3oLfp1csV9WqcBq2q3M1Zz+96zKUzSTb+y6AYBLPws63vHLq4DtaNmlM0jzfDSDx5a0D3E3ePuZa40w+O/VKgTZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780958752; c=relaxed/simple;
	bh=0m3o+qhxlgUf+faFpfQ1HekVYOS9BwJh0a2KOX0fLkQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O6oo/hhMDpn0Sb35bb4LFwkh5yh7xtzEbTcmICmDenPSdru/cW+v1Uano9YToaj0U4b007hYtCDksznLIWePM9sRl8aFC8q+FFDjrFigJSCiJhI6GZHF2/0HQ1zALd8Yjg24MIXEbfFrFZQAahAv6RRdagnSbDc0hThNALC7MRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irCbsip6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irCbsip6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F1F31F00893;
	Mon,  8 Jun 2026 22:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780958751;
	bh=C9lqjhNvnY4Qw43NqzN0lOsSO/JFNMp1EjvJfmi6+rw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=irCbsip69ztU9/qXGToZERwTCCNNjz25GHEPIIzDLNNKfvXU6AI0/eeH7ElYulTny
	 q6Wg6A8O7CiUMj+vIFatgaWnCkYrO8UTR20RzL5ZUxFtDbiv+klj6M4Hq8ehFAFfv7
	 KwAonJ3jPayMLWfPj0OKizWbkLiiz2MqKAONsO8Ud9uGdBonkCoXvgKzFW7js46EAf
	 neuX2RcRJ6B8wV/WIG2FvjoYO7gLbabsRLGdqvJhlfmtMo7FfXnvPva5vrIpwFmbdP
	 P5b28RmQg6haaLKH1nO6mAuqQjGy0Zl9CAcGoKaBMEoVCbritJ5M+/4aTA2rrOwsUm
	 vNsOrOCKhFM0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 55/60] kvm: svm: Track vmsa_features per plane
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-56-joro@8bytes.org>
References: <20260608144252.351443-56-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 22:45:51 +0000
Message-Id: <20260608224551.6F1F31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] sev_snp_ap_creation() validates requested vmsa_features against th=
e calling vCPU's plane instead of the target vCPU's plane.
- [High] Secondary planes' vmsa_features are never initialized or migrated,=
 causing silent loss of security features.
--

commit 654ad38ffbc973d598194f49a24442f700bbdaec
Author: Joerg Roedel <joerg.roedel@amd.com>

kvm: svm: Track vmsa_features per plane

Planes can have different set of SEV features enabled. Track the
enabled features per plane instead of per VM.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 374236210ef47..f803afcc3989d 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c

[ ... ]

> @@ -534,11 +534,11 @@ static int __sev_guest_init(struct kvm *kvm, struct=
 kvm_sev_cmd *argp,
> =20
>  	sev->active =3D true;
>  	sev->es_active =3D es_active;
> -	sev->vmsa_features =3D data->vmsa_features;
> +	sev_plane->vmsa_features =3D data->vmsa_features;

[Severity: High]
Does this code only initialize vmsa_features for the first plane? If
secondary planes are allocated via svm_alloc_plane(), will their
vmsa_features remain 0?

>  	sev->ghcb_version =3D data->ghcb_version;
> =20
>  	if (snp_active)
> -		sev->vmsa_features |=3D SVM_SEV_FEAT_SNP_ACTIVE;
> +		sev_plane->vmsa_features |=3D SVM_SEV_FEAT_SNP_ACTIVE;
> =20
>  	ret =3D sev_asid_new(sev, vm_type);
>  	if (ret)

[ ... ]

> @@ -2039,7 +2041,7 @@ static void sev_migrate_from(struct kvm *dst_kvm, s=
truct kvm *src_kvm)
>  	dst->pages_locked =3D src->pages_locked;
>  	dst->enc_context_owner =3D src->enc_context_owner;
>  	dst->es_active =3D src->es_active;
> -	dst->vmsa_features =3D src->vmsa_features;
> +	dst_plane->vmsa_features =3D src_plane->vmsa_features;

[Severity: High]
Does this only migrate vmsa_features for planes[0]? Could this drop
the features for secondary planes during migration?

> =20
>  	src->asid =3D 0;
>  	src->active =3D false;

[ ... ]

> @@ -4162,9 +4164,9 @@ static int sev_snp_ap_creation(struct vcpu_svm *svm)
>  	switch (request) {
>  	case SVM_VMGEXIT_AP_CREATE_ON_INIT:
>  	case SVM_VMGEXIT_AP_CREATE:
> -		if (vcpu->arch.regs[VCPU_REGS_RAX] !=3D sev->vmsa_features) {
> +		if (vcpu->arch.regs[VCPU_REGS_RAX] !=3D sev_plane->vmsa_features) {

[Severity: High]
Does this validate the requested vmsa_features against the calling
vCPU's plane rather than the target vCPU's plane?

If a guest creates an AP on a different plane, and planes can have
different SEV features, will this incorrectly reject a valid request
if the target plane's features differ from the caller's plane?

>  			vcpu_unimpl(vcpu, "vmgexit: mismatched AP sev_features [%#lx] !=3D [%=
#llx] from guest\n",
> -				    vcpu->arch.regs[VCPU_REGS_RAX], sev->vmsa_features);
> +				    vcpu->arch.regs[VCPU_REGS_RAX], sev_plane->vmsa_features);
>  			return -EINVAL;
>  		}

[ ... ]

> @@ -4795,15 +4797,16 @@ void sev_vcpu_after_set_cpuid(struct vcpu_svm *sv=
m)
> =20
>  static void sev_snp_init_vmcb(struct vcpu_svm *svm)
>  {
> -	struct kvm_sev_info *sev =3D &to_kvm_svm(svm->vcpu.kvm)->sev_info;
> +	struct kvm_sev_info_plane *sev_plane =3D &to_kvm_svm_plane(svm->vcpu.pl=
ane)->sev_info_plane;
> =20
>  	/* V_NMI is not supported when Restricted Injection is enabled */
> -	if (sev->vmsa_features & SVM_SEV_FEAT_RESTRICTED_INJECTION)
> +	if (sev_plane->vmsa_features & SVM_SEV_FEAT_RESTRICTED_INJECTION)

[Severity: High]
If secondary planes have their vmsa_features left as 0, will this
security check fail for them and incorrectly leave V_NMI_ENABLE_MASK set?

This seems like it could break Restricted Injection isolation for
secondary plane vCPUs.

>  		svm->vmcb->control.int_ctl &=3D ~V_NMI_ENABLE_MASK;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D55
