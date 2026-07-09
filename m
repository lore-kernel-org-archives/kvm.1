Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4203AB47C
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 21:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783631420; cv=none; b=ZEHiZVSmbNr6yqumrPjdsxm1+VR998QZfDRAju98JGmXFw+d+ooKSAiwgJw4XxIOsiDj792gKpvRAocxgMGoiH+PnWH+WlSYBfn4nEcuVd30gPSUx8fJ8/GBDlfBFAWl6dGiPa4ObLQkq3OtwB6OEGzhpB+P8tHpa3BJOurFzbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783631420; c=relaxed/simple;
	bh=vELUuSPTUyQIqNukGmtby/HlF8Zmb7hcR/N6KGH4x2E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hh24AF7eRYsA0sLHGy3qcfWmLOGzaKFUEv/ulBtcixIjLnF6o4K2seq5qYLI17T3CEWcmEnLBM0ZCI2kCQlvsUSBvUxh/czm5YCUtazBpAHop7fb/RLwUQ43RhwZNqnfpAMgLq6qox11rObMPoROT9K96Ofn5LPf9aiRGZz7pQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5vFFtKZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5vFFtKZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D131F000E9;
	Thu,  9 Jul 2026 21:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783631418;
	bh=xlIcX4nLmOAGVLhh39KnIto6gKlHI271Gb8N7wGN3m8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A5vFFtKZi7k6bElwIEEbSPq+dyexL+tP6zu0HRbSwT8iuOfWP9806MGdatdV5hiNq
	 QAgycMloMqEQfcOjDcts/rro4gMi0Kk+DJmDz3GIfcRZ/fKZdBjbwEO3FqKb1CC5WC
	 7xlcCzjKQFMOcO1QlpZkVbvOnkcXyXkjs8t3VsL66t/TdgKdyD4JfwQ5GB0L4vYWgG
	 P54PQHRl2Zw/mbL3hiCNEax50kYCr9B56C1rrB3bJYMdMIznXKoy/ywqke+jjXSXjt
	 ScxoGB9PVPTc9XBkcFnThJiTmghBdZWjrrCg04hm/HkIK9tNuj4v6zJtUCG76lnVyX
	 f7RS3EtxS3Q6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/18] KVM: SEV: Mark vCPU RUNNABLE after AP_CREATE,
 even if VMSA is unusable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260709204948.1988414-4-seanjc@google.com>
References: <20260709204948.1988414-1-seanjc@google.com>
 <20260709204948.1988414-4-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 21:10:17 +0000
Message-Id: <20260709211018.60D131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] KVM incorrectly executes VMRUN with a dummy unmeasured host VMSA i=
nstead of failing KVM_RUN when a vCPU's initial AP_CREATE VMSA load fails.

Pre-existing issues:
- [Critical] sev_snp_reload_vmsa() bypasses the MMU notifier invalidation r=
etry protocol, leading to a Use-After-Free of a physical page if a concurre=
nt guest_memfd invalidation occurs.
--

--- Patch [3]: [PATCH v4 03/18] KVM: SEV: Mark vCPU RUNNABLE after AP_CREAT=
E, even if VMSA is unusable ---
commit ca23b8314664c0ed691814678164a510162e2299
Author: Sean Christopherson <seanjc@google.com>

KVM: SEV: Mark vCPU RUNNABLE after AP_CREATE, even if VMSA is unusable

This commit marks a vCPU as RUNNABLE after responding to an AP_CREATE
request, even if the guest-specified VMSA is unusable. This prevents the
vCPU from hanging in a non-running state and instead allows KVM_RUN to
return an error to userspace. It also enables retrying the VMSA load in
the future.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index d8ed00f76aa31..30792adcfc8e5 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -4028,9 +4028,6 @@ static void sev_snp_reload_vmsa(struct kvm_vcpu *vc=
pu, gpa_t gpa)
>  	svm->sev_es.snp_guest_vmsa_gpa =3D gpa;
>  	svm->vmcb->control.vmsa_pa =3D pfn_to_hpa(pfn);

[Severity: Critical]
This is a pre-existing issue, but does sev_snp_reload_vmsa() bypass the
MMU notifier invalidation retry protocol here?

If a concurrent PUNCH_HOLE occurs on the guest_memfd while
sev_snp_reload_vmsa() fetches and installs a guest VMSA, this could lead
to a use-after-free of the physical page.

sev_snp_reload_vmsa() resolves the PFN via kvm_gmem_get_pfn() and directly
installs it into svm->vmcb->control.vmsa_pa without holding kvm->mmu_lock
or checking mmu_invalidate_retry_gfn(). It then drops the page reference.

If the page is subsequently freed by guest_memfd, KVM would retain the
stale physical address in vmsa_pa, and the hardware could write guest state
to the freed page during VMRUN.

> -	/* Mark the vCPU as runnable */
> -	kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);
> -

[ ... ]

> @@ -4062,6 +4059,15 @@ static void sev_snp_init_protected_guest_state(str=
uct kvm_vcpu *vcpu)
>  	svm->sev_es.snp_pending_vmsa_gpa =3D INVALID_PAGE;
> =20
>  	sev_snp_reload_vmsa(vcpu, gpa);
> +
> +	/*
> +	 * Mark the vCPU as runnable for CREATE requests, indicated by a valid
> +	 * VMSA GPA, even if installing the VMSA failed, so that KVM_RUN will
> +	 * fail instead of blocking indefinitely and hanging the vCPU, e.g. if
> +	 * the backing guest_memfd page is unavailable.
> +	 */
> +	if (VALID_PAGE(gpa))
> +		kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);

[Severity: High]
Does this allow KVM to incorrectly execute VMRUN with a dummy unmeasured
host VMSA when the initial AP_CREATE VMSA load fails?

If a guest issues an AP_CREATE request with an invalid VMSA (such as having
no backing guest_memfd page) for a vCPU that has not yet successfully loaded
a guest VMSA, marking it RUNNABLE is intended to make pre_sev_run() fail
KVM_RUN.

However, because snp_has_guest_vmsa remains false on failure,
sev_es_init_vmcb() overwrites the INVALID_PAGE state with the KVM-allocated
fallback VMSA physical address:

	if (!svm->sev_es.snp_has_guest_vmsa) {
		if (svm->sev_es.vmsa)
			svm->vmcb->control.vmsa_pa =3D __pa(svm->sev_es.vmsa);
		else
			svm->vmcb->control.vmsa_pa =3D INVALID_PAGE;
	}

Because of this, pre_sev_run() will see a valid vmsa_pa and pass:

	if (is_sev_es_guest(vcpu) && !VALID_PAGE(svm->vmcb->control.vmsa_pa))
		return -EINVAL;

Will this result in a hardware RMP violation or guest state corruption when
KVM attempts VMRUN with the dummy VMSA?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709204948.1988=
414-1-seanjc@google.com?part=3D3
