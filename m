Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC92306742
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 12:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182590; cv=none; b=ukC/zp1ftDBmWx8NSqUAUAHEnkNaRnArFpM8kycVNeIufOBD1NcrsB83UvR9Qt+Ei9rDdzpuMGVM8LycI1L5QjfzAsR0etpDJreuDoP9mQsLio+nhU9BSfQ/bHfkwh5Ip8Rytr8uTrFZfLCkaJkVoeA0Vmi6CXEdlzw8EtrtzwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182590; c=relaxed/simple;
	bh=fA86R+SwqcFNarysZFksfOIzd04AJbSgvtUW+PYSYSk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AwqQzmnLJQXxMTCCXnbuqO97qOekjjQX89KcgxJpIOOt6XnI9MFKoVlzsNCpUjmQI1xbCh5//Dl4qw/5vuw4B80kbDor/NgKUVRxfwVGYitaJcmUjYQ0CxTVCiPLdtnJGXk4PwImzO5NJkOh05XUJ6rjgQ9oAABplCByRIYVrVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXBnIQ3o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXBnIQ3o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61421F00893;
	Thu, 11 Jun 2026 12:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781182588;
	bh=zWUKIfGm5R8Ai9yXMKInzMPXa60jtrXCaZ1n7nypxzY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GXBnIQ3orZa01ZpNy90VC08llYxboc3rFyYJmOOuWlONOv1ruQoO/OhofphGOedla
	 VJ0QEEZaXHGwQWSYOirjbhZlB88Og71Ox+NFflm4O8snV/FPXW0fQXNKsZEb8WL+Yb
	 UhGWILEM9LV0O4UZCsCpsVi8e8Kdb9uuKh045MDiuWvMtZztRzzLp1gwOIIj2CzLTI
	 EzE2XvonfJfCwulwdVz7oyTNxwoXrFIW4eWqtmxdR1FIN3OzWEQ5vtoJVcGg0jjbRX
	 SHNUNDEk1v0ZTRYhLTh7ZWfUnaOmixpYv32PF4hr3mqUp3g3cWD1CjxGLSNd7/Ty28
	 vts70VGblj2/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] kvm: svm: Streamline VMSA setting for VCPUs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260611123528.572255-2-joro@8bytes.org>
References: <20260611123528.572255-2-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 12:56:28 +0000
Message-Id: <20260611125628.C61421F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Dynamically freeing an active initial VMSA page during SNP AP crea=
tion without using SNP_PAGE_RECLAIM triggers an RMP violation, which bug-ha=
lts the VM and leaks memory.

Pre-existing issues:
- [Critical] A malicious SEV-SNP guest can crash the host kernel by punchin=
g a hole in a guest_memfd page that is actively assigned as an AP VMSA.
--

commit dfce748c773ed97c4a6e2b3a1ea5718862d5c1bf
Author: Joerg Roedel <joerg.roedel@amd.com>

kvm: svm: Streamline VMSA setting for VCPUs

This commit streamlines the VMSA setting state of vcpus, allowing a VMSA
to be either KVM-allocated or guest-provided. It consolidates the various
tracking states around VMSAs.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 0c3962647116e..9e00aa7bdca8c 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c

[ ... ]

> @@ -156,6 +159,173 @@ struct enc_region {

[ ... ]

> +static void sev_es_vcpu_free_vmsa(struct kvm_vcpu *vcpu)
> +{
> +	struct vcpu_svm *svm =3D to_svm(vcpu);
> +	void *vmsa_ptr;
> +
> +	switch (svm->sev_es.vmsa.vmsa_state) {
> +	case VMSA_NONE:
> +	case VMSA_GUEST:
> +		break;
> +	case VMSA_PRIVATE:
> +		vmsa_ptr =3D page_address(svm->sev_es.vmsa.vmsa_page);
> +
> +		if (is_sev_snp_guest(vcpu)) {
> +			u64 pfn =3D __pa(vmsa_ptr) >> PAGE_SHIFT;
> +
> +			if (kvm_rmp_make_shared(vcpu->kvm, pfn, PG_LEVEL_4K)) {

[Severity: High]
Does this sequence trigger an RMP violation?=20
   =20
When an SEV-SNP guest provisions an AP and triggers svm_vmgexit_ap_creation=
(),
KVM replaces the initial KVM-managed VMSA with the guest-provided one using
sev_es_set_guest_vmsa(), which eagerly frees the old VMSA via
sev_es_vcpu_free_vmsa().

For SNP guests, the old VMSA page is in the VMSA_PRIVATE state and has been
transitioned to the hardware VMSA state. To transition it back to shared
memory, AMD architecture requires reclaiming the page via snp_page_reclaim()
before issuing an RMPUPDATE.
   =20
Since sev_es_vcpu_free_vmsa() bypasses snp_page_reclaim() and directly calls
kvm_rmp_make_shared(), could this fail with an RMP violation, causing the VM
to bug-halt and leak the physical page?

> +				pr_err("Failed to make VMSA page shared - leaking it to avoid re-use=
\n");
> +				goto out;
> +			}
> +		}
> +
> +		if (vcpu->arch.guest_state_protected)
> +			sev_flush_encrypted_page(vcpu, vmsa_ptr);
> +
> +		fallthrough;

[ ... ]

> +static u64 sev_es_vmsa_pa(struct kvm_vcpu *vcpu)
> +{
> +	struct vcpu_svm *svm =3D to_svm(vcpu);
> +	enum vmsa_state vmsa_state =3D svm->sev_es.vmsa.vmsa_state;
> +	u64 vmsa_pa =3D INVALID_PAGE;
> +
> +	if (vmsa_state =3D=3D VMSA_GUEST) {

[ ... ]

> +		/*
> +		 * The new VMSA will be private memory guest memory, so retrieve the
> +		 * PFN from the gmem backend.
> +		 */
> +		if (kvm_gmem_get_pfn(vcpu->kvm, slot, gfn, &pfn, &page, NULL))
> +			goto out;
> +
> +		vmsa_pa =3D pfn_to_hpa(pfn);
> +
> +		/*
> +		 * gmem pages aren't currently migratable, but if this ever changes
> +		 * then care should be taken to ensure the guest vmsa is pinned
> +		 * through some other means.
> +		 */
> +		kvm_release_page_clean(page);

[Severity: Critical]
This is a pre-existing issue, but does dropping the page reference here all=
ow
a malicious guest to crash the host kernel?

When a guest-provided VMSA is used for an AP, KVM resolves the GPA to a PFN
and immediately drops its page reference here. The physical address is then
programmed into the hardware VMCB.

If a malicious guest issues a Page State Change request to transition this =
VMSA
page back to shared memory, host userspace can handle this by calling
fallocate(PUNCH_HOLE) on the guest_memfd. This would trigger
sev_gmem_invalidate(), which attempts rmp_make_shared().

Because the page is still in the VMSA state, rmp_make_shared() would fail.
sev_gmem_invalidate() only prints a warning and proceeds, freeing the page
back to the buddy allocator while its RMP entry is still guest-restricted.

When the host buddy allocator reallocates and accesses this page, would it
trigger an RMP violation and a host kernel panic?

> +	} else if (vmsa_state =3D=3D VMSA_PRIVATE || vmsa_state =3D=3D VMSA_SHA=
RED) {
> +		vmsa_pa =3D __pa(page_address(svm->sev_es.vmsa.vmsa_page));
> +	}
> +
> +out:
> +	return vmsa_pa;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611123528.5722=
55-1-joro@8bytes.org?part=3D1
