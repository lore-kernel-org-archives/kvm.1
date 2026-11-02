Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793620417;
	b=Bu69GwZic5r0x/sgSpyN0+eKsU7f+LEJvzkPWE4OfvM+qKSkYFaIG7f6FL6RLGBWVbXi
	 OPKWUrg0hkynPd5QPHntO+zYRhf5EJZvCm47AOuCATYFcxp95ZfN0pPzxOouABYWFh4rI
	 h5ppnLHvs3GwNw20eyIhPQVqi+bJkCJTt3PilJQMyDeh4QwKEgyBINDyiN3b3yJF7IOFI
	 eZbXDvMmAE/ntV3OLlmoBU/8A5kF38rduSyUBStvMzpD5Gao52jCn+743IWHYIgUyNJ4/
	 kBhy9AkbKCJZxnzgENtg/r6gOQwj5CC7pBO2tsutiilmZ5K6HrMjn9asvyU8s8TLgXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793620417;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dc9ziHs0Bv1h6RnyXdlCQlrDJbJrZoJ9I+NssKBOWt4=;
	b=WmkPe8+bouJ7zFfun/lp0B76X9oaI3UTyMcdNs7vM9FeI/gC/SmiJSOPVHHU/rWjcGRy
	 msMV3DsfLAVIrqWwQJIdncGvpVZkqex3Nhc0wPq4Tw6i6JddzkTt4G+DyZmMryd1yW7sL
	 LRvm9mplf7mlYYr1sdgaJYOSuVWE+TFG9Ua26Wy21K5w2AVzRD3HtQW3olIGf1SaGHlKQ
	 KAY2Ml0f3cBhXr0HCzcfov7tlNEgVHHCWoUR/gpZc+QHvlVlTS6bYtJtVHeMjs4hJkf7u
	 4p2AxW00lcUpU97bjwEtBP5WIxgvbZQ4Typd/CM+mZT6hYnNC5tO0lOIZFyyJdBkxKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OIzMO2iG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06ED606A326
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 11:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OIzMO2iG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611401F00A16;
	Mon,  2 Nov 2026 11:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793620416;
	bh=dc9ziHs0Bv1h6RnyXdlCQlrDJbJrZoJ9I+NssKBOWt4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OIzMO2iGMJ0gK3Qago4kpNYXu1E4VwlgfQGx3HYlObgDZLkoE3wpFifVUjcibbhTM
	 3xmpyPd9ATdbJ4NEZDTi2khBPyDrUiUlUzOrafLrPC/B9a4CsJE377kfszUFYOm4HQ
	 hEjH0t4zEk/AyPQ5AvySPw8HGst10SSgr8TM90K9poaWT3gb2hLvGH5stp8XNv8613
	 JCnzkJv2BP+a9IS6E5l1/I11C/z8HklARE1B2EdKC6KXra/rBJZns56vCT1EwoE+Jy
	 oibcBFgE2sIT5UTA8Lhnm4//Lq74YfXrX26WYXaIsWl2XI4OBrpm8e2YKT82N9ALAe
	 VXfzyMw05OuHg==
Message-ID: <sashiko-outbox-193356@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/8] KVM: SVM: Hold SRCU while reloading guest-owned
 VMSAs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261102114137.1198982-4-joro@8bytes.org>
References: <20261102114137.1198982-1-joro@8bytes.org>
 <20261102114137.1198982-4-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 11:53:36 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] KVM: SVM: redundant nested srcu_read_lock() in __sev_snp_reload_=
vmsa()
--

commit c628b3f34be1a24c7bbd7ced36d3f7d15af73940
Author: Joerg Roedel <joerg.roedel@amd.com>

KVM: SVM: Hold SRCU while reloading guest-owned VMSAs

This commit acquires a KVM SRCU read lock in __sev_snp_reload_vmsa() around
the memslot and guest_memfd lookup through VMCB installation.

>     KVM: SVM: Hold SRCU while reloading guest-owned VMSAs
>    =20
>     Take a dedicated KVM SRCU read lock around the guest-owned VMSA memsl=
ot
>     and guest_memfd lookup.  This makes the reload path self-contained and
>     prevents it from racing a userspace memslot replacement.
>    =20
>     Keep the lock through VMCB installation, and release it on all lookup
>     failure paths.
>    =20
>     Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
>=20
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index c0ae34871be90..5bfe23790ba46 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -4057,6 +4057,7 @@ static void __sev_snp_reload_vmsa(struct kvm_vcpu *=
vcpu, gpa_t gpa)
>  	gfn_t gfn =3D gpa_to_gfn(gpa);
>  	unsigned long mmu_seq;
>  	kvm_pfn_t pfn;
> +	int idx;
> =20
>  	lockdep_assert_held(&svm->sev_es.snp_vmsa_mutex);
> =20
> @@ -4088,9 +4089,10 @@ static void __sev_snp_reload_vmsa(struct kvm_vcpu =
*vcpu, gpa_t gpa)
>  	if (!VALID_PAGE(gpa))
>  		return;
> =20
> -	slot =3D gfn_to_memslot(vcpu->kvm, gfn);
> +	idx =3D srcu_read_lock(&kvm->srcu);
> +	slot =3D gfn_to_memslot(kvm, gfn);
>  	if (!slot)
> -		return;
> +		goto out_unlock;
> =20
>  	mmu_seq =3D kvm->mmu_invalidate_seq;
>  	smp_rmb();
> @@ -4099,8 +4101,8 @@ static void __sev_snp_reload_vmsa(struct kvm_vcpu *=
vcpu, gpa_t gpa)
>  	 * The new VMSA will be private memory guest memory, so retrieve the
>  	 * PFN from the gmem backend.
>  	 */
> -	if (kvm_gmem_get_pfn(vcpu->kvm, slot, gfn, &pfn, NULL))
> -		return;
> +	if (kvm_gmem_get_pfn(kvm, slot, gfn, &pfn, NULL))
> +		goto out_unlock;
> =20
>  	read_lock(&kvm->mmu_lock);
>  	/*
> @@ -4115,6 +4117,9 @@ static void __sev_snp_reload_vmsa(struct kvm_vcpu *=
vcpu, gpa_t gpa)
>  	else
>  		svm->vmcb->control.vmsa_pa =3D pfn_to_hpa(pfn);
>  	read_unlock(&kvm->mmu_lock);
> +
> +out_unlock:
> +	srcu_read_unlock(&kvm->srcu, idx);
>  }

[Severity: Medium]
Is taking a dedicated srcu_read_lock(&kvm->srcu) in __sev_snp_reload_vmsa()
necessary, and is the commit message accurate that this path previously rac=
ed
with userspace memslot replacement?

gfn_to_memslot() calls kvm_memslots() -> __kvm_memslots(), which already
requires kvm->srcu (or kvm->slots_lock) to be held:

include/linux/kvm_host.h:__kvm_memslots() {
	return srcu_dereference_check(kvm->memslots[as_id], &kvm->srcu,
			lockdep_is_held(&kvm->slots_lock) ||
			!refcount_read(&kvm->users_count));
}

Looking at all callers of __sev_snp_reload_vmsa(), kvm->srcu is already held
via kvm_vcpu_srcu_read_lock(vcpu):

1. sev_snp_reload_vmsa() is only called from vcpu_enter_guest() when
   servicing KVM_REQ_VMSA_PAGE_RELOAD:

arch/x86/kvm/x86.c:vcpu_enter_guest() {
		if (kvm_check_request(KVM_REQ_UPDATE_PROTECTED_GUEST_STATE, vcpu)) {
			kvm_vcpu_reset(vcpu, true);
			if (vcpu->arch.mp_state !=3D KVM_MP_STATE_RUNNABLE) {
				r =3D 1;
				goto out;
			}
		}
		if (kvm_check_request(KVM_REQ_VMSA_PAGE_RELOAD, vcpu))
			kvm_x86_call(reload_vmsa)(vcpu);
}

2. sev_snp_init_protected_guest_state() is only called from
   sev_init_vmcb(svm, init_event) when init_event is true, which is reached
   via svm_vcpu_reset(vcpu, true) <- kvm_vcpu_reset(vcpu, true) from
   vcpu_enter_guest() (servicing KVM_REQ_UPDATE_PROTECTED_GUEST_STATE) and
   from kvm_apic_accept_events() (all callers of which hold kvm->srcu).

Even in the later commit 58d63c955c7c ("KVM: SEV: Add SNP vCPU state get and
set commands"), snp_set_vcpu_state() introduces its own helper,
sev_snp_install_guest_vmsa(), rather than calling __sev_snp_reload_vmsa().

Could this nested srcu_read_lock() and srcu_read_unlock() in
__sev_snp_reload_vmsa() be dropped, or replaced with an assertion that
kvm->srcu is held?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102114137.1198=
982-1-joro@8bytes.org?part=3D3
