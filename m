Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E87350A18
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 23:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780960139; cv=none; b=K+5/ZKDLP/DUknXi1t6BnCBNq8FcKL/eD7B/jPFIoZJQ5KpdsFYNapPMUlPP4hy9M6B8RA9j2d2c4EdHSG7z7vockIt+9hTwHCP2v2l6g703s/YEnijgc1uUy9ebuKuqtHqW7u4ZIV21Y2yVbOhtXj1pEmcUVJA+xrUb4MMIs6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780960139; c=relaxed/simple;
	bh=dArw80YZNl4rZ7xbi46yj0nvPX4JDK79vtxoE9hUvzI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A1G1inv7V3L4ITy6j3jZeDjvvIzpyHbw89EU+wLUhpnYOxXdg9TlBzPEWr0Ui1IE4OJAR4c+p1FLdXA3nQ6ABN5ebgrnI84k3Qb0kAQFXkdoR2bRMb3k0ORVqAefTZAt8+lMEyyiDRfe18Byra8dkD8F1lsz9/2VU5TE+ZBnY74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqlbDEIa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqlbDEIa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D6B1F00893;
	Mon,  8 Jun 2026 23:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780960138;
	bh=xGn2nwza4y2IWv3eV3LMq+CViFOi2yzSlVPAGnofWQc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BqlbDEIaQ2jRDY5U3cPGKDPXNh6cRYyzwoqUwLT5zyySmhb6kDuOWO4hiDD7CeRJt
	 butoxlBvzsoW+VeXChwyJXspUsWfL2R4BJq/Z9iaEpk9mv41zdpzCN4rJUPQC15iFK
	 1pU/C43yYmZRAx0XF7W7i15GKf+piQelRBGraJGyhD5UEgz/87bKMFPdLf2uG3jdcl
	 JVyejfJ+awrFQ0ZM85qqhdzZrmjIziZCxLBM7MqU5hJTB2PBRnzJUL+mo/yR8p/coR
	 RNMMYKvaTnQsnJhX9sEBd1DhCYc/AGbBKWvM34AMOcskAeP+gusFqpKTvTwaul5KJk
	 ADJmYI+CA2Fag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 57/60] kvm: sev: Allow for VMPL level specification in
 AP create
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-58-joro@8bytes.org>
References: <20260608144252.351443-58-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 23:08:57 +0000
Message-Id: <20260608230857.D6D6B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

New issues:
- [High] Returning -EINVAL from the complete_userspace_io callback abruptly=
 aborts the entire VM.
- [High] Non-VMPL0 vCPUs are incorrectly permitted to replace their own VMS=
A.
- [High] Processing an `AP_DESTROY` request sets the target vCPU to `KVM_MP=
_STATE_HALTED` instead of `KVM_MP_STATE_UNINITIALIZED` and leaves its VMSA =
PA invalid, exposing the VM to a host crash upon spurious wakeup.
- [Medium] Unsynchronized concurrent access to the shared `target_sev_plane=
->vmsa_features` variable.
- [Low] `#define SVM_SEV_VMPL_MAX 4` improperly redefines an existing enum =
constant as a preprocessor macro.
- [Low] Commented-out lines left over from debugging or refactoring.

Pre-existing issues:
- [Critical] Hardware use-after-free vulnerability due to missing lifetime =
pinning of the VMSA guest_memfd page.
--

commit 5d5c749babe4794fbb4e0c07b6fb01ee70a1da40
Author: Tom Lendacky <thomas.lendacky@amd.com>
Subject: kvm: sev: Allow for VMPL level specification in AP create

This commit updates AP creation to support adding or destroying VMSAs at
levels other than VMPL0. It creates tracking arrays for VMSAs and GHCBs
across different levels to allow running under an SVSM at VMPL1 or lower.

> Additional checks are applied to prevent a non-VMPL0 vCPU from being able
> to perform an AP creation request at VMPL0. Additionally, a vCPU cannot
> replace its own VMSA.

[Severity: High]
Does this logic successfully prevent a non-VMPL0 vCPU from replacing its
own VMSA? As implemented in sev_snp_ap_creation() below, the condition
evaluates to false for any VMPL greater than 0, which entirely bypasses
the target_vcpu check and allows a lower-privileged guest vCPU to
replace its own VMSA.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -4131,8 +4137,26 @@ static void sev_snp_init_protected_guest_state(str=
uct kvm_vcpu *vcpu)

[ ... ]

>  	/* Mark the vCPU as runnable */
> -	kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);
> +	if (svm->sev_es.snp_ap_runnable) {
> +		kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);
> +	} else {
> +		kvm_set_mp_state(vcpu, KVM_MP_STATE_UNINITIALIZED);
> +	}

[Severity: High]
Will an AP_DESTROY request successfully reach this new state transition?
Earlier in sev_snp_init_protected_guest_state(), there is a check:

	if (!VALID_PAGE(svm->sev_es.snp_vmsa_gpa))
		return;

Since an AP_DESTROY sets snp_vmsa_gpa to INVALID_PAGE, the early return
bypasses this MP state transition. This leaves the vCPU in
KVM_MP_STATE_HALTED with an invalid vmsa_pa, making it susceptible to
standard APIC wakeups that could lead to a #VMEXIT(INVALID) crash.

>  	/*
>  	 * gmem pages aren't currently migratable, but if this ever changes
> @@ -4142,36 +4166,87 @@ static void sev_snp_init_protected_guest_state(st=
ruct kvm_vcpu *vcpu)
>  	kvm_release_page_clean(page);
>  }

[Severity: Critical]
This is a pre-existing issue, but does dropping the software reference
to the VMSA page here expose KVM to a use-after-free? KVM writes the
pfn directly into the hardware VMCB (svm->vmcb->control.vmsa_pa), but
calling kvm_release_page_clean(page) unpins it. If host userspace frees
the physical page, the hardware could continue executing with a VMCB
pointing to freed memory since MMU notifiers won't intercept hardware
VMCB pointers.

> -static int sev_snp_ap_creation(struct vcpu_svm *svm)
> +static unsigned int get_ap_creation_request(struct vcpu_svm *svm)
>  {
> -	struct kvm_sev_info_plane *sev_plane =3D to_kvm_sev_info_plane(svm->vcp=
u.plane);
> -	struct kvm_vcpu *vcpu =3D &svm->vcpu;
> -	struct kvm_vcpu *target_vcpu;
> -	struct vcpu_svm *target_svm;
> -	unsigned int request;
> +//	struct kvm_sev_info_plane *sev_plane =3D to_kvm_sev_info_plane(svm->v=
cpu.plane);
> +//	struct kvm_vcpu *vcpu =3D &svm->vcpu;
> +	unsigned int req =3D lower_32_bits(svm->vmcb->control.exit_info_1);
> +
> +	return req & ~SVM_VMGEXIT_AP_VMPL_MASK;
> +}

[Severity: Low]
Are these commented-out lines intended to be removed?

[ ... ]

> +#define SVM_SEV_VMPL_MAX	4
> +
> +static int sev_snp_ap_creation(struct kvm_vcpu *vcpu)
> +{

[Severity: Low]
Does this macro redefine the SVM_SEV_VMPL_MAX enum constant added
to arch/x86/include/asm/svm.h in this same patch?

[ ... ]

> +	/* Request user-space to create target plane VCPU if it does not exist =
*/
> +	if (!target_plane || !target_vcpu) {
> +		vcpu->arch.complete_userspace_io =3D sev_snp_ap_creation;
> +		return kvm_request_create_plane(vcpu, vmpl, apic_id);
> +	}

[ ... ]

> +	/* VMPL0 can only be replaced by another vCPU running VMPL0 */
> +	if (vmpl =3D=3D SVM_SEV_VMPL0 &&
> +	    (vcpu =3D=3D target_vcpu || vcpu->plane_level !=3D SVM_SEV_VMPL0)) {
> +		vcpu_unimpl(vcpu, "vmgexit: VMPL0 AP action not allowed\n");
> +		return -EINVAL;
> +	}

[Severity: High]
If this validation check (or the ones further down) fails during the
second pass of sev_snp_ap_creation() acting as a complete_userspace_io
callback, does returning -EINVAL abort the entire VM? Since it executes
via kvm_arch_vcpu_ioctl_run, the error isn't intercepted to inject a
guest error code, and instead bubbles up to userspace to terminate the VM.

>  	switch (request) {
>  	case SVM_VMGEXIT_AP_CREATE_ON_INIT:
>  	case SVM_VMGEXIT_AP_CREATE:
> -		if (vcpu->arch.regs[VCPU_REGS_RAX] !=3D sev_plane->vmsa_features) {
> +		/* Initialize target planes SEV features if necessary */
> +		if (target_sev_plane->vmsa_features =3D=3D 0)
> +			target_sev_plane->vmsa_features =3D vcpu->arch.regs[VCPU_REGS_RAX];

[Severity: Medium]
Can this lead to a data race on the shared target_sev_plane structure?
This update modifies a plane-wide shared variable while only protected by
the per-target vCPU mutex (target_svm->sev_es.snp_vmsa_mutex). Multiple
vCPUs executing AP creation concurrently for different targets on the same
uninitialized plane might encounter load/store tearing.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D57
