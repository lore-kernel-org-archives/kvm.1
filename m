Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793643279;
	b=GPjWexnS2vHJjKJgIQisMZ/uuvsvdslGs3v0vSqx3vVoSv5h6/a/H90KcsvT3Sh92utf
	 lHsiTB4AfRSy5jJai9sYb6ueesfkdCfQE9k39VOn7AUmYnc1AHthUHk9jdmfvRD7mX4qT
	 O5kQbGlsSFp3asEDkctSECd2DFDRkLweUeBHwB2V9vzJ7gQMlcdAvHNUZCvcwaHeCxRME
	 q53X36vh05bTZgt7qx7p/puKpStp/QATVyhQ0oB4fQzpaf/8jhKyb7YPqy5tIIbY0iVee
	 J/15+DUzQMoHYlEZfVbYUlxixSNT7PYWeZP/mL7Sudw45AHcaDNyRt7v4jOP5nG1gJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793643279;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7WZlGFjEmqAKMgFyBnsnquY39F0YxQb555aVgiEe8V8=;
	b=TElhR5yztUeL9onlfQ5AZdlqqsg8TtYNMuZIGOYQa+uiPBqXdz9fUuhv8iR2hqAfUZlr
	 6PACUAFsuzaK1DRjW8coE6F/dqNO/yqG9MN51OADhNyCfilzaGjrKgCkrQ4d2EUf/QokG
	 /G5uAX+C2Pe27NmTVGx/C3FXZ0yV7r6bqTQ6ylGhkbkjbmd45hxh+TrRc8jHXJ3kDZ8Ps
	 hfxC+Zpf9D7XnFuXdm+JCowxl2E+lwHUlOLEkCxTDU34R4NzA/yN8/K06RfH8c4+o+W1h
	 EyHTCxTyLJ6ngEUKyFS9bLfWXuyC27PKblDjEzyoJLurb39DL8WX8jUqOmQjnzrNJSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="k/t5NWqh";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECAF606A329
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 18:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k/t5NWqh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388F61F00A17;
	Mon,  2 Nov 2026 18:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793643278;
	bh=7WZlGFjEmqAKMgFyBnsnquY39F0YxQb555aVgiEe8V8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=k/t5NWqhmaFamFIk+TjvnGtwknYcshRzzLGHc6ca9owpZPUA0NyxWCQoiGVR1fKFx
	 VVv86L/RZWNHlmfQqWesPruQ7eo2Dl6R1B7bUE/UNlcLzXOVO+F6iiSX6vilePCheF
	 kAZRjeWJgz5Qnxralqf+5ynRSE6pCe8w3590ApFM4NCiMRmP/4A92Z9rEBfvqF0R1l
	 CrPugmFoIkpAmd2LUMRnBhaggHTacvi/rTwfFW+R8uB4HIOAg8LA7Ogx0ti0mLKnAW
	 pv8xM9wwvxCUBCixxK8qstC1eR8lPQMMddL+eqisNoRhKMgMKR7kAU4zlTrkFLx4r9
	 XpqjGHc6htyxA==
Message-ID: <sashiko-outbox-193917@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 25/45] KVM: Take memory protections into account for
 accesses with cached gfn->hva
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20261102174512.8903-9-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
 <20261102174512.8903-9-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 18:14:37 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] KVM: redundant mem_attr checks and RO failure in __kvm_get/put_g=
uest()
- [Medium] KVM: unupdated attrs_generation on error in __kvm_gfn_to_hva_cac=
he_init()
- [Medium] KVM: stale ghc->gpa on error in __kvm_gfn_to_hva_cache_init()
--

commit 70e5ce5ddda9132daea8ebdb4ea3879b1bca2fa1
Author: Nicolas Saenz Julienne <nsaenz@amazon.com>

KVM: Take memory protections into account for accesses with cached gfn->hva

This commit adds memory attribute protection checks to __kvm_get_guest(),
__kvm_put_guest(), and __kvm_gfn_to_hva_cache_init(), invalidating and
rejecting gfn_to_hva_cache entries when read or write restrictions apply
to the GPA range.

Link: https://patch.msgid.link/20260918135030.171564-23-pbonzini@redhat.com

> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 2c854aaab92a1..de540af1fa244 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1371,7 +1371,8 @@ int kvm_gfn_to_hva_cache_init(struct kvm *kvm, stru=
ct gfn_to_hva_cache *ghc,
>  	typeof(v) __user *__uaddr =3D (typeof(__uaddr))(__addr + offset);	\
>  	int __ret =3D -EFAULT;						\
>  									\
> -	if (!kvm_is_error_hva(__addr))					\
> +	if (!kvm_is_error_hva(__addr) &&                                \
> +	    kvm_mem_attributes_may_read_gfn(kvm, gfn))		\
>  		__ret =3D get_user(v, __uaddr);				\
>  	__ret;								\
>  })
> @@ -1391,7 +1392,8 @@ int kvm_gfn_to_hva_cache_init(struct kvm *kvm, stru=
ct gfn_to_hva_cache *ghc,
>  	typeof(v) __user *__uaddr =3D (typeof(__uaddr))(__addr + offset);	\
>  	int __ret =3D -EFAULT;						\
>  									\
> -	if (!kvm_is_error_hva(__addr))					\
> +	if (!kvm_is_error_hva(__addr) &&                                \
> +	    kvm_mem_attributes_may_write_gfn(kvm, gfn))		\
>  		__ret =3D put_user(v, __uaddr);				\

[Severity: Medium]
Both __kvm_get_guest() and __kvm_put_guest() obtain __addr via
gfn_to_hva(kvm, gfn), which already checks both read and write memory
attributes:

virt/kvm/kvm_main.c:gfn_to_hva() {
	addr =3D gfn_to_hva_many(gfn_to_memslot(kvm, gfn), gfn, NULL);
	if (kvm_is_error_hva(addr))
		return addr;

	if (!kvm_mem_attributes_may_read_gfn(kvm, gfn))
		return KVM_HVA_ERR_BAD;

	if (!kvm_mem_attributes_may_write_gfn(kvm, gfn))
		return KVM_HVA_ERR_RO_BAD;

	return addr;
}

Because both KVM_HVA_ERR_BAD and KVM_HVA_ERR_RO_BAD satisfy
kvm_is_error_hva(__addr), the additional calls to
kvm_mem_attributes_may_read_gfn() and kvm_mem_attributes_may_write_gfn()
in these macros perform a duplicate XArray lookup in kvm->mem_attrs.array
and evaluate the macro arguments kvm and gfn a second time.

Furthermore, because __kvm_get_guest() calls gfn_to_hva() rather than
gfn_to_hva_prot(), any page marked read-only with KVM_MEMORY_ATTRIBUTE_NW
causes gfn_to_hva() to return KVM_HVA_ERR_RO_BAD, failing __kvm_get_guest()
with -EFAULT before kvm_mem_attributes_may_read_gfn() is reached.

Should __kvm_get_guest() use gfn_to_hva_prot(kvm, gfn, NULL) so that
read-only pages remain readable, and drop the redundant attribute check in
__kvm_put_guest()? Also, the commit message mentions that tracking the
memory attributes generation in gfn_to_hva_cache is required for
kvm_get/put_guest(), though kvm_get_guest() and kvm_put_guest() do not use
gfn_to_hva_cache.

[ ... ]

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 6aa6a0a55b070..8283b2415adc2 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -3664,15 +3664,22 @@ static int __kvm_gfn_to_hva_cache_init(struct kvm=
 *kvm,
>  	 * If the requested region crosses two memslots, we still
>  	 * verify that the entire region is valid here.
>  	 */
> -	for ( ; start_gfn <=3D end_gfn; start_gfn +=3D nr_pages_avail) {
> -		ghc->memslot =3D __gfn_to_memslot(slots, start_gfn);
> -		ghc->hva =3D gfn_to_hva_many(ghc->memslot, start_gfn,
> -					   &nr_pages_avail);
> +	for (gfn_t gfn =3D start_gfn ; gfn <=3D end_gfn; gfn +=3D nr_pages_avai=
l) {
> +		ghc->memslot =3D __gfn_to_memslot(slots, gfn);
> +		ghc->hva =3D gfn_to_hva_many(ghc->memslot, gfn, &nr_pages_avail);
>  		if (kvm_is_error_hva(ghc->hva))
>  			return -EFAULT;
>  	}
> =20
> +	/*
> +	 * RW memory attributes are incompatible with GHC. The RW protection
> +	 * check has to happen after storing the generation number.
> +	 */
>  	ghc->attrs_generation =3D kvm_mem_attributes_generation(kvm);

[Severity: Medium]
At the start of __kvm_gfn_to_hva_cache_init(), ghc->slots_generation is
updated before any error checks so that if initialization fails, subsequent
calls to kvm_read_guest_offset_cached() or kvm_write_guest_offset_cached()
within the same generation pass kvm_memslots_check_gen() and immediately
return -EFAULT on kvm_is_error_hva(ghc->hva).

Because ghc->attrs_generation is only updated after the start_gfn > end_gfn
check and the memslot lookup loop, if kvm->mem_attrs.generation changes on
a cache whose GPA fails one of those earlier checks, ghc->attrs_generation
remains stale. Every subsequent call to kvm_read_guest_offset_cached() or
kvm_write_guest_offset_cached() will then fail kvm_memslots_check_gen() and
repeatedly re-run __kvm_gfn_to_hva_cache_init().

Should ghc->attrs_generation =3D kvm_mem_attributes_generation(kvm) be moved
to the top of __kvm_gfn_to_hva_cache_init() alongside ghc->slots_generation?

> +	if (kvm_range_has_rw_memory_protections(kvm, start_gfn, end_gfn + 1)) {
> +		ghc->hva =3D KVM_HVA_ERR_BAD;
> +		return -EFAULT;
> +	}

[Severity: Medium]
When a gfn_to_hva_cache previously initialized to a valid gpa1 is
re-initialized to a new gpa2 that fails
kvm_range_has_rw_memory_protections(), __kvm_gfn_to_hva_cache_init()
updates ghc->slots_generation and ghc->attrs_generation and sets
ghc->hva =3D KVM_HVA_ERR_BAD, but returns -EFAULT before updating ghc->gpa
and ghc->len at the end of the function:

virt/kvm/kvm_main.c:__kvm_gfn_to_hva_cache_init() {
	...
	ghc->gpa =3D gpa;
	ghc->len =3D len;
	return 0;
}

This leaves ghc->hva poisoned with KVM_HVA_ERR_BAD while ghc->gpa still
holds the previous valid gpa1. Callers that guard cache re-initialization
with a GPA comparison, such as nested_vmx_check_vmcs_link_ptr(),
nested_cache_shadow_vmcs12(), and nested_flush_cached_shadow_vmcs12():

arch/x86/kvm/vmx/nested.c:nested_vmx_check_vmcs_link_ptr() {
	if (ghc->gpa !=3D vmcs12->vmcs_link_pointer &&
	    CC(kvm_gfn_to_hva_cache_init(vcpu->kvm, ghc,
					 vmcs12->vmcs_link_pointer, VMCS12_SIZE)))
		return -EINVAL;
}

or callers that keep the previous GPA active when an MSR update to a new
GPA is rejected (such as kvm_lapic_set_pv_eoi() and
kvm_pv_enable_async_pf()), will then see matching generations and fail
valid accesses to gpa1 with -EFAULT.

Would it make sense to update ghc->gpa and ghc->len at the start of
__kvm_gfn_to_hva_cache_init() before the error returns so that a failed
re-initialization does not leave a stale ghc->gpa paired with
KVM_HVA_ERR_BAD?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102174130.8779=
-1-pbonzini@redhat.com?part=3D25
