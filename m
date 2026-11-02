Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793643574;
	b=TFKg/+SoBlPCM5KQ+d3jZeog2XGYMSVKmV7p3z3CRaqeF0/6QHXJXuhIIiKuvFcDomez
	 33o34E6/8/+L5nBiitPDkaGGE0lBki5vaxDHDTO9Y7bRfkw+Q8wPI5LPLi4ZqMu1QyYM/
	 1GTFDITlYob2mH9anOMyVyYKoZ6F0HxQF1HXSwN9sPAgS1KHtGnFtbAwBwnmkSGTO7d9b
	 UVgbOnWP2hJOH3t9JI2JD+NSL6+P4/pfFqdd4WcpZEuEMjom/jovb9MBDUUB8AzlvnCjF
	 pz6kQjH8xGq1ZI7IJmVYZGKXrUzYEZA5114d64sz71LsB3yZrzksgZireky2H1fvA9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793643574;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=z856jg5qZ3rMaoUWtT2kfMxXtvmjXU8jKzTtn2N5zWA=;
	b=YaUQNbRMDiMugEzziWFo1rWM4faNkEtC5ojkH/104fq8hOa8sZVHUZVa5aoiH0NdR8Ey
	 u/STOigQyNEdG1yDZLEXIzu+0tO+A8uH+dapjQ6DANYxhKw8uh/85gDTX87rwVjwuizh/
	 erzPIvfiwsa/Wl1KsrQdEcpNwytTNr+E9klzJuuBm+n5sVNpmXKpC7CEpiMmxfQqBLnup
	 kBZlnDzDdTAaWiQa2K44+46wx0ekr6KwVmxRW2IFgNDBWOlX+2vhBGjvVVrDytVF0nAQh
	 S1qPs4PB0t3y5nMLOW2a3oHsPUzWAlWj7KxxbCg/CkLYZTPCEwqsPTimgMJukkJJdFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VfCehOqd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1234606D802
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 18:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VfCehOqd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C52F1F00A1D;
	Mon,  2 Nov 2026 18:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793643574;
	bh=z856jg5qZ3rMaoUWtT2kfMxXtvmjXU8jKzTtn2N5zWA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=VfCehOqdXQNWkLJmIj7GRIMJlSKNC20agzAWdu0cdX5tctQh4iVvIm9e7l38YE0Dd
	 ku7VDV6IkAzPFdZqFIn8lVEScTjlOBpDUQYdNZSbo47CaOXYokXNyC9/+iAHlrrdPV
	 C3AbZE0V5mkAp6BF209DDBol0+GLh/XtMZZtW6kL3mi1BS47cPyBHgfNIbYmlI6y30
	 dE4gEseKLaYbOq7J9/YGR2p/Dd37FJnKFd79ZnJ900hwBmayJgjQuO3t9SN0Pmdupo
	 TrAhjyoSPOnENIA5yMuOZFtrPsGjdbmXns1y6FWwBro1ooHR5fXFC3udDOJcK7NEUW
	 +J7Ou5N8+ohTw==
Message-ID: <sashiko-outbox-193925@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 34/45] KVM: x86/mmu: Adjust gva_to_gpa to allow
 returning an error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20261102174512.8903-18-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
 <20261102174512.8903-18-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 18:19:33 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] KVM: x86: mismatch between KVM_TRANSLATE docs and -EFAULT handli=
ng
- [Medium] KVM: x86: unconditional gva_to_gpa() walk in kvm_fixup_and_injec=
t_pf_error()
--

commit 914d25167c243b05b87b4e07ce157df3731ce832
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM: x86/mmu: Adjust gva_to_gpa to allow returning an error

This commit changes the gva_to_gpa callback and its helper wrappers to retu=
rn
an int error code while writing the translated guest physical address to an
out parameter, allowing callers to distinguish -EFAULT from INVALID_GPA.

> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.=
rst
> index ac8cd51bdadae..743a738ff8d39 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -521,7 +521,9 @@ data structures.
>  :Architectures: x86
>  :Type: vcpu ioctl
>  :Parameters: struct kvm_translation (in/out)
> -:Returns: 0 on success, -1 on error
> +:Returns: 0 on success, -1 on error.  errno is EFAULT if
> +          the parameter is invalid but also if guest memory
> +          could not be accessed
> =20
>  Translates a virtual address according to the vcpu's current address
>  translation mode.

[ ... ]

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index bb36ca1106e58..53400fda9f44b 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c

[ ... ]

> @@ -9341,19 +9354,24 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu=
 *vcpu,
>  {
>  	unsigned long vaddr =3D tr->linear_address;
>  	gpa_t gpa;
> -	int idx;
> +	int idx, r;
> =20
>  	vcpu_load(vcpu);
> -
>  	idx =3D srcu_read_lock(&vcpu->kvm->srcu);
> -	gpa =3D kvm_mmu_gva_to_gpa_system(vcpu, vaddr, NULL);
> +	r =3D kvm_mmu_gva_to_gpa_system(vcpu, vaddr, &gpa, NULL);
>  	srcu_read_unlock(&vcpu->kvm->srcu, idx);
> +	vcpu_put(vcpu);
> +
> +	if (r) {
> +		if (r !=3D -EFAULT)
> +			return r;
> +		gpa =3D INVALID_GPA;
> +	}
> +
>  	tr->physical_address =3D gpa;
>  	tr->valid =3D gpa !=3D INVALID_GPA;
>  	tr->writeable =3D 1;
>  	tr->usermode =3D 0;
> -
> -	vcpu_put(vcpu);
>  	return 0;
>  }

[Severity: Medium]
Documentation/virt/kvm/api.rst is updated above to state that KVM_TRANSLATE
returns -1 with errno set to EFAULT when guest memory could not be accessed.

However, in kvm_arch_vcpu_ioctl_translate(), when kvm_mmu_gva_to_gpa_system=
()
returns -EFAULT, the error is caught and converted into gpa =3D INVALID_GPA,
causing the ioctl to return 0 with tr->valid =3D 0 instead of returning -EF=
AULT.

Should kvm_arch_vcpu_ioctl_translate() propagate -EFAULT to userspace, or w=
as
the intention to report an invalid translation (tr->valid =3D 0) and the
documentation in api.rst needs to be updated to match?

> @@ -10815,11 +10833,15 @@ int kvm_fixup_and_inject_pf_error(struct kvm_vc=
pu *vcpu, gva_t gva, u16 error_co
>  {
>  	struct kvm_pagewalk *gva_walk =3D &vcpu->arch.gva_walk;
>  	struct x86_exception fault;
> +	gpa_t gpa;
> +	int r;
>  	u64 access =3D error_code &
>  		(PFERR_WRITE_MASK | PFERR_FETCH_MASK | PFERR_USER_MASK);
> =20
> -	if (!(error_code & PFERR_PRESENT_MASK) ||
> -	    gva_walk->gva_to_gpa(vcpu, gva_walk, gva, access, &fault) !=3D INVA=
LID_GPA) {
> +	r =3D gva_walk->gva_to_gpa(vcpu, gva_walk, gva, access, &gpa, &fault);
> +	if (r)
> +		return r;
> +	if (!(error_code & PFERR_PRESENT_MASK) || gpa !=3D INVALID_GPA) {
>  		/*
>  		 * If gva_walk->gva_to_gpa succeeded, the page
>  		 * tables probably do not match the TLB.  Just proceed

[Severity: Medium]
Previously, kvm_fixup_and_inject_pf_error() short-circuited and skipped
calling gva_walk->gva_to_gpa() whenever !(error_code & PFERR_PRESENT_MASK) =
was
true.

With gva_walk->gva_to_gpa() hoisted before the PFERR_PRESENT_MASK check, ev=
ery
non-present page fault reaching kvm_fixup_and_inject_pf_error() (for instan=
ce,
in nested VMX when vmx_need_pf_intercept() causes prepare_vmcs02_rare() to
intercept all L2 page faults) now walks the guest and nested page tables ev=
en
though both gpa and fault are overwritten in the if-block when
PFERR_PRESENT_MASK is clear.

Aside from the extra page-table walk, if a guest PTE was concurrently made
present or upper-level guest PTEs are walked, FNAME(walk_addr_generic)() can
update guest Accessed/Dirty bits or return -EFAULT on a non-present fault.

Should gva_walk->gva_to_gpa() only be called when (error_code &
PFERR_PRESENT_MASK) is set?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102174130.8779=
-1-pbonzini@redhat.com?part=3D34
