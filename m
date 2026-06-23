Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6920D392C3C
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 21:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782248884; cv=none; b=Tpv7pH5dSJ2Qb48TjPIlMlSwH+ApcsMiVvcEx/jvPF/rqLjeh74ZtkdlwQdUQVf2fvWtlrLLrA9vhNH+SvtrF3CMZYHyAHtJni+N3hVFvErVY468oQIUiVHiVpITnZiuTHLIvP+1pllYHpQAIpvGCgVwiQ8LpWwBMIuBvaIGfKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782248884; c=relaxed/simple;
	bh=C2SRdUlAf7MXfAukddujSvWfrZmPw850dRCRluZEWIU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ejSxCMdbqhbJL6UZQjfhpmDKPD8Ck956WMd/3No3++aIzutHaAkLBeQvCxWPit5a0GmhnQMxQXG8IFUEbXiHyboB/gWkIFkwfkFFsqk+scHZ9HU0Xh1f2b8lQijXIMIP6DwdM3he8OJxFBG90qtJe+rbaY3N8hwUOFbwbfzBcvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NpkUVzlm; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NpkUVzlm"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c7cfa17fe6so3360545ad.3
        for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 14:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782248881; x=1782853681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YqYm5YrSKIdiJxURceFirMcVaOV2ZHmSYEbl3PGhUGc=;
        b=NpkUVzlmm4LierKVdpmroBJ5BNg9x93ZL8yvVkvcPjM/bx/Ggv+mGGhSazz6wecLks
         rnQ4ji1dlI5uiArlq+g5TVNNil+ilVesdmr/e2pDHl/P+FAoSX39sbVQQckyXlldsgZs
         s7Z70QiSzUJY6HX++arCpbqOGfkkvNHcOPsruhyID6eT1h/XAWjUjxP972vW0pUMJvFf
         BVJuVt+yiOsvx3ktoLjQ7tEVJzj0tQvMuVizWXVBysew50CgPKQtibBcWfbIfTRz4aSP
         dQC/T+H3lQC7Ftzy+hyrqm7aVpMcl6VFoXNDGeVhWtGXxHqW357689PISq4jV1g7bHn6
         zdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782248881; x=1782853681;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YqYm5YrSKIdiJxURceFirMcVaOV2ZHmSYEbl3PGhUGc=;
        b=LJAkhNWfjkUEcJBaRsMuRHblrphZOnestCpOTBA0zbI6nBQhj4BwD+WFLjbtebhm4Z
         zPNAQRe96Bk3AGTHEunK0LSPxpTp1pnv82GBl0L3m7zVHEaHaLkJB2TjzaySuZtltgwW
         94M57HZKYrUZubscKzLIWVzc/UTdVP6RwsUWAcF8RIwdw32YePDzmYbYD7tyFSGOfg8k
         I7JRYYMzRmiyyNL7rxQHvKSU+OrHXyEUVtnaH6kVtt9nGsHK43cQvtsvDDn+mEXRFNIU
         hv5qFigSUAproJbwaJvq5BxaAPP1VX6HFujHA6kO+I/cFrG6Rgnnf0p4GD5R252fPwqf
         ybig==
X-Forwarded-Encrypted: i=1; AHgh+RrVkp3Bm5Ys1LGoatGCiPmyvqqAukr8iBtvt9cb+NBIpKpQd6hyDXYIkpaE6Nrot258iGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5RWB2RYvbFiUj3gAgA1qfp4uEQBeBQKL2B3KQ8wI6hj9VVgOA
	8UR/UOVpoOcCE2fKCtPHfskR/jD5Zh1m15VQKBBAC7nbFUcY6cY3jO4x8+lkfLm33KoaEFkxsG9
	f05uLnQ==
X-Received: from plup8.prod.google.com ([2002:a17:903:4b28:b0:2c6:bae2:6ead])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f70e:b0:2c0:a555:80e6
 with SMTP id d9443c01a7336-2c7c758b73dmr51222105ad.6.1782248880445; Tue, 23
 Jun 2026 14:08:00 -0700 (PDT)
Date: Tue, 23 Jun 2026 14:07:59 -0700
In-Reply-To: <20260611123528.572255-4-joro@8bytes.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260611123528.572255-1-joro@8bytes.org> <20260611123528.572255-4-joro@8bytes.org>
Message-ID: <ajr1r-PAiXMnZ7x1@google.com>
Subject: Re: [PATCH 3/4] kvm: svm: Support guest-provided VMSA for launching
From: Sean Christopherson <seanjc@google.com>
To: "=?utf-8?B?SsO2cmcgUsO2ZGVs?=" <joro@8bytes.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, coconut-svsm@lists.linux.dev, 
	Joerg Roedel <joerg.roedel@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026, J=C3=B6rg R=C3=B6del wrote:
> From: Joerg Roedel <joerg.roedel@amd.com>
>=20
> Introduce a way to provide a guest GPA as the initial BSP VMSA and
> avoid allocating KVM-managed VMSAs in this case. Only one
> guest-provided VMSA is supported at the moment as IGVM also only

No.  Design uAPI that makes sense for KVM and is extensible.  If it turns o=
ut
that allowing exactly one VMSA is the simplest, most logical approach, then=
 so
be it.  But "thing X only needs Y" isn't sufficient justification.

But I'm not remotely convinced that hacking in BSP-only support like this i=
s
the way to go.  This entire approach is convoluted, as is the code.  E.g. t=
he
below iterates over all vCPUs, but then only actually does anything for vcp=
u_idx=3D0.
And the ioctl is VM-scoped, but really operates on a vCPU.

At a (very rough) glance, I don't see any reason we can't have a vCPU-scope=
d
ioctl to effectively mimic SVM_VMGEXIT_AP_CREATE.

> supports to set a single VMSA.
>=20
> Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
> ---
>  arch/x86/kvm/svm/sev.c | 62 ++++++++++++++++++++++++++++++------------
>  arch/x86/kvm/svm/svm.h |  1 +
>  2 files changed, 45 insertions(+), 18 deletions(-)
>=20
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 350bb97c32c0..88db83b3ff8e 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -726,6 +726,7 @@ static int __sev_guest_init(struct kvm *kvm, struct k=
vm_sev_cmd *argp,
> =20
>  	INIT_LIST_HEAD(&sev->regions_list);
>  	INIT_LIST_HEAD(&sev->mirror_vms);
> +	sev->initial_vmsa_gpa =3D INVALID_PAGE;
>  	sev->need_init =3D false;
> =20
>  	kvm_set_apicv_inhibit(kvm, APICV_INHIBIT_REASON_SEV);
> @@ -2680,6 +2681,46 @@ static int snp_launch_update(struct kvm *kvm, stru=
ct kvm_sev_cmd *argp)
>  	return 0;
>  }
> =20
> +static int snp_init_guest_vmsa(struct kvm_vcpu *vcpu, gpa_t vmsa_gpa)
> +{
> +	/* Only one initial guest VMSA can exist (per IGVM) - so it belongs to =
the BSP */
> +	if (vcpu->vcpu_idx !=3D 0)
> +		return 0;
> +
> +	/* VMSA already private and encrypted via LAUNCH_UPDATE */
> +	sev_es_set_guest_vmsa(vcpu, vmsa_gpa);
> +
> +	return 0;
> +}
> +
> +static int snp_init_kvm_vmsa(struct kvm_vcpu *vcpu,
> +			     struct sev_data_snp_launch_update *data,
> +			     struct kvm_sev_cmd *argp)
> +{
> +	struct vcpu_svm *svm =3D to_svm(vcpu);
> +	int ret;
> +	void *vmsa;
> +
> +	ret =3D sev_es_sync_vmsa(svm);
> +	if (ret)
> +		return ret;
> +
> +	vmsa =3D sev_es_vmsa_ref(vcpu);
> +
> +	ret =3D sev_es_vcpu_vmsa_make_private(vcpu);
> +	if (ret)
> +		return ret;
> +
> +	/* Issue the SNP command to encrypt the VMSA */
> +	data->address =3D __sme_pa(vmsa);
> +	ret =3D __sev_issue_cmd(argp->sev_fd, SEV_CMD_SNP_LAUNCH_UPDATE,
> +			      data, &argp->error);
> +	if (ret)
> +		sev_snp_vcpu_reclaim_vmsa(vcpu);
> +
> +	return ret;

Separate code movement from new functi0onality.

> +}
> +
>  static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *a=
rgp)
>  {
>  	struct kvm_sev_info *sev =3D to_kvm_sev_info(kvm);
> @@ -2700,28 +2741,13 @@ static int snp_launch_update_vmsa(struct kvm *kvm=
, struct kvm_sev_cmd *argp)
> =20
>  	kvm_for_each_vcpu(i, vcpu, kvm) {
>  		struct vcpu_svm *svm =3D to_svm(vcpu);
> -		void *vmsa;
> =20
> -		ret =3D sev_es_sync_vmsa(svm);
> +		ret =3D VALID_PAGE(sev->initial_vmsa_gpa) ?
> +			snp_init_guest_vmsa(vcpu, sev->initial_vmsa_gpa) :
> +			snp_init_kvm_vmsa(vcpu, &data, argp);
>  		if (ret)
>  			goto out;
> =20
> -		vmsa =3D sev_es_vmsa_ref(vcpu);
> -
> -		ret =3D sev_es_vcpu_vmsa_make_private(vcpu);
> -		if (ret)
> -			goto out;
> -
> -		/* Issue the SNP command to encrypt the VMSA */
> -		data.address =3D __sme_pa(vmsa);
> -		ret =3D __sev_issue_cmd(argp->sev_fd, SEV_CMD_SNP_LAUNCH_UPDATE,
> -				      &data, &argp->error);
> -		if (ret) {
> -			sev_snp_vcpu_reclaim_vmsa(vcpu);
> -
> -			goto out;
> -		}
> -
>  		svm->vcpu.arch.guest_state_protected =3D true;
> =20
>  		/* VMSA encrypted - put it into the VMCB */
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 3d4799f09b23..cc7e84c230bb 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -117,6 +117,7 @@ struct kvm_sev_info {
>  	struct mutex guest_req_mutex; /* Must acquire before using bounce buffe=
rs */
>  	cpumask_var_t have_run_cpus; /* CPUs that have done VMRUN for this VM. =
*/
>  	bool snp_certs_enabled;	/* SNP certificate-fetching support. */
> +	gpa_t initial_vmsa_gpa; /* Optinal GPA of BSP VMSA - SEV-SNP only */
>  };
>  #endif
> =20
> --=20
> 2.53.0
>=20
