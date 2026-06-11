Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B474D2EA731
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 13:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781183139; cv=none; b=kpO8yUy7GHAttVz8P9gAKT+aAPtXsiGURG5UjgZRTmOrbOY9z++3B1LhJ+HmeFze8CnEdj1tfzJgv3rRZpJ+dips4iVIUUzFX57w84z4DnyU3zIu0UV+XUpReGyt7JWvvzYvIrj1JdipQIwYbK6JwTCafLx3Ny7CWJpJWOerGMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781183139; c=relaxed/simple;
	bh=toylZ1F/AypNVx7jf+8JX7PP6YGbFclPni7FooxC58M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gzxu8kwgSWfgqlNQ4hWnl7ITY0Nyx4AXSYeblRtPXoQhdRI8ptCSaLg/qZH/n57dxaf7xF6DPQVawJfDrjtfCKeM2wIlFZ1Cb6DmrKlT5D1fvNiMJYThpHNq3IoFoLO3BrvyjiOzS8GeMtVBHiYrSFt2SF0Vtqd6OD85l55xabA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIj2tV7G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIj2tV7G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216371F00893;
	Thu, 11 Jun 2026 13:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781183137;
	bh=wY3K3T1IX/7TFU0ad7D4lA6LrtT1Aij1i6C1fP43BDQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EIj2tV7GXyEoivkHDvxG6SkFjjioRm3r+uan5B5a6kxnEFtR3FBZYhd/KJSy9uZOh
	 j2kx6HboZZ/UaOwIsQonbq60pn5go42QTYO2IlAx9FxSZTz0AqE27BVRewjTrTtg1H
	 r96/io4NyFpDQHBR/agQjwFEIrmsrG+ckhBIeRWPwC78k0imImLl9UdXZ3uTKRSg6x
	 nljCDpvQGuQU+V9nO6mFkFUAAnUB8mNALrfNAxsMowUiO3lN2OgVjx+mFb4JwEkruN
	 i1FsNvAetBFYQieH56rBzLnKbHb6ntx2CWb/4x9ipF68t/Pu0uL6TzPVdjwJhv2P0d
	 zhJaoc0ydonxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] kvm: svm: Support guest-provided VMSA for launching
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260611123528.572255-4-joro@8bytes.org>
References: <20260611123528.572255-4-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 13:05:36 +0000
Message-Id: <20260611130537.216371F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Resolving the guest-provided VMSA GPA via `gfn_to_memslot()` occur=
s without holding `kvm->srcu` or `kvm->slots_lock`, violating KVM's memslot=
 locking hierarchy.

Pre-existing issues:
- [Critical] Guest-provided VMSA pages are freed to the host buddy allocato=
r while still in the RMP Firmware state, allowing userspace to trigger a ho=
st kernel panic (Denial of Service).
- [High] KVM-allocated VMSA pages for successfully launched SNP VMs are per=
manently leaked during VM teardown.
--

commit 7ccfa1323e073ebe13797e68f8f429e2d5dfb5ec
Author: Joerg Roedel <joerg.roedel@amd.com>

kvm: svm: Support guest-provided VMSA for launching
   =20
Introduce a way to provide a guest GPA as the initial BSP VMSA and
avoid allocating KVM-managed VMSAs in this case. Only one
guest-provided VMSA is supported at the moment as IGVM also only
supports to set a single VMSA.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 0aa62cb802fe5..0c42af2e62016 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c

[ ... ]

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

[Severity: Critical]
This is a pre-existing issue, but can unprivileged userspace panic the host
kernel by punching a hole in the guest_memfd file backing the guest-provided
VMSA pages?

Guest-provided VMSA pages are placed into the VMSA (Firmware) RMP state.
However, KVM drops its page reference immediately after lookup:

arch/x86/kvm/svm/sev.c:sev_es_vmsa_pa() {
    ...
    kvm_release_page_clean(page);
    ...
}

If userspace triggers a page release, the page is freed by the core MM
subsystem. During freeing, sev_gmem_invalidate() attempts to transition the
page via rmp_make_shared(), which architecturally fails on VMSA-state pages:

arch/x86/kvm/svm/sev.c:sev_gmem_invalidate() {
    ...
    rc =3D rmp_make_shared(pfn, use_2m_update ? PG_LEVEL_2M : PG_LEVEL_4K);
    if (WARN_ONCE(rc, "SEV: Failed to update RMP entry for PFN 0x%llx error=
 %d\n", pfn, rc))
        goto next_pfn;
    ...
}

Because the failure is only logged as a warning, the page is returned to the
buddy allocator in Firmware state. When the host reallocates and accesses
this page, it triggers a fatal RMP #PF and panics the kernel. KVM must
properly reclaim VMSA pages before allowing them to be freed.

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
> +}

[Severity: High]
This is a pre-existing issue, but does KVM permanently leak successfully=20
launched SNP VM VMSA pages during VM teardown?

During normal teardown of an SNP guest, KVM attempts to transition its
allocated VMSA pages to shared state via kvm_rmp_make_shared():

arch/x86/kvm/svm/sev.c:sev_es_vcpu_free_vmsa() {
    ...
    if (kvm_rmp_make_shared(vcpu->kvm, pfn, PG_LEVEL_4K)) {
        pr_err("Failed to make VMSA page shared - leaking it to avoid re-us=
e\n");
        goto out;
    }
    ...
}

kvm_rmp_make_shared() uses the RMPUPDATE instruction, which architecturally
fails on pages that are in the VMSA state. The function detects the failure,
logs the error, and permanently leaks the page. Because VMs are destroyed
routinely, this will eventually exhaust host memory. KVM must use
snp_page_reclaim() instead of kvm_rmp_make_shared() for pages in the VMSA
state.

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

[Severity: High]
Does this code call sev_es_vmsa_pa() without holding kvm->srcu or=20
kvm->slots_lock?

Looking at the execution path immediately following this comment in=20
snp_launch_update_vmsa():

        /* VMSA encrypted - put it into the VMCB */
        svm->vmcb->control.vmsa_pa =3D sev_es_vmsa_pa(vcpu);

arch/x86/kvm/svm/sev.c:sev_es_vmsa_pa() {
    ...
    slot =3D gfn_to_memslot(vcpu->kvm, gfn);
    ...
}

gfn_to_memslot() dereferences the KVM memslots array. Since this is called=
=20
without SRCU or slots_lock, a concurrent thread executing=20
KVM_SET_USER_MEMORY_REGION can swap and free the memslots array while=20
gfn_to_memslot() is accessing it, leading to a use-after-free.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611123528.5722=
55-1-joro@8bytes.org?part=3D3
