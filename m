Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28934398F4
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 18:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784227590; cv=none; b=U04Na7r31WpqvjTrIS+eOuYWh11WUuyaBDAPy6EbPsjRXdXyepJ25V6wd6U7yLyWUOT8fwbF5jCh4LW+UDxJC+oPtmvwlG5Oj0JXUbDN9M/QF1E7LtkxcJHXibpU8R3cydTjtkj6D1u0j/inYFKWxzJzpSKDf6WJz5OAnJIuShI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784227590; c=relaxed/simple;
	bh=1eiecpk9ggKppYTwkxwcLlrlH1rW7xFoBWU6DJoaQ6k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=naq5BQvwT4B5XXNbzB8Cz/qkJpIbAhFSmr3np/kA+HOaeChM4HmYWq9Eh5RAiMwhwVNPtBrAb3kAljuSw5hcAVgYS+vZZfgT8xif9JF+utpnyLyAQS9mOAB3RR3tUmCdymXUr5KbOWmOuxPAWHhM+ZCcR/Zoj7z9bNULTl919nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=haDLei/1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="haDLei/1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5411F000E9;
	Thu, 16 Jul 2026 18:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784227588;
	bh=UcCyUAnRT9KRo0eV3o9BL4WbqROi8VjqZRooVMe5DBE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=haDLei/1eeSQxLvz0GL3BtkGChyyWdtQN8G1hYtYRnhUoJjbRae1w1LA3h+EYB2E1
	 cL//Z/G+LbfPgjG0dsV0FC1UQB98BRAZtn/rqwD8cY+X0RvckROfurO02LxnrtXZf2
	 oXL7LDI3hadNFS1/t71luVMHLgaSSVo+eJs5Zk37fj0iJQdDQIMALaQRcGluuHoegu
	 CZAPno3u02jWtoyYU3Gae/Bqp9IFy/jhTiYOh5bqFq2NsRIeFQiElR8jOGqRlcSV8R
	 QDFkDvkDab2x2L1IuGEK5ZSWdjeRM4lAQ7sRgJMy3zqs4/COE2Wu5OQljq8JLBWnzX
	 tCgwHFIDDh7iA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/24] KVM: Take memory protections into account for
 accesses with cached gfn->hva
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260716181456.402786-16-pbonzini@redhat.com>
References: <20260716181456.402786-1-pbonzini@redhat.com>
 <20260716181456.402786-16-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 18:46:27 +0000
Message-Id: <20260716184628.2C5411F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] gfn_to_pfn_cache (GPC) bypasses memory attribute protections (NR/N=
W).
- [Medium] Redundant memory attribute checks in __kvm_get_guest and __kvm_p=
ut_guest lead to duplicate xarray lookups (performance regression).
- [Low] kvm_memslots_check_gen() causes a build failure when CONFIG_KVM_GEN=
ERIC_MEMORY_ATTRIBUTES is disabled.
--

--- Patch [15]: [PATCH 15/24] KVM: Take memory protections into account for=
 accesses with cached gfn->hva ---
commit 51177f153d521afab2fb1286cac8c924ca7aa90d
Author: Nicolas Saenz Julienne <nsaenz@amazon.com>

KVM: Take memory protections into account for accesses with cached gfn->hva

Account for memory attributes when accessing guest memory through
kvm_get/put_guest().

This requires tracking the memory attributes generation as part of
gfn_to_hva_cache's data, invalidate the cached information if the
generation changes, and failing to refresh the cache if restrictive
memory attributes are found within the GPA range.

> Similar to how gfn_to_hva_cache disallows caching gfns mapped within
> read-only memory slots, gfns marked as read-only by memory attributes
> will also fail to initialize. Unsurprisingly, the same behaviour applies
> to gfns mapped as non-accessible (NR/NW), while non-executable mappings
> are okay.

[Severity: High]
Does gfn_to_pfn_cache (GPC) bypass memory attribute protections (NR/NW) whi=
le
this patch updates gfn_to_hva_cache (GHC)?

In virt/kvm/pfncache.c:__kvm_gpc_refresh():

			gpc->attrs_generation =3D kvm_mem_attributes_generation(kvm);
			gpc->gpa =3D gpa;
			gpc->slots_generation =3D slots->generation;
			gpc->memslot =3D __gfn_to_memslot(slots, gfn);
			gpc->uhva =3D gfn_to_hva_memslot(gpc->memslot, gfn);

The HVA is retrieved without evaluating memory attributes to see if access =
is
actually permitted. KVM can bypass guest memory isolation boundaries, writi=
ng
to memory that the guest expects to be read-only (NW). Should gfn_to_pfn_ca=
che
also validate kvm_mem_attributes_may_write_gfn()?

> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 1fad3eb303c17..71ab2cbecbd12 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
[ ... ]
> @@ -1351,7 +1351,8 @@ int kvm_gfn_to_hva_cache_init(struct kvm *kvm, stru=
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

[Severity: Medium]
Are these memory attribute checks redundant and introducing an unnecessary
xarray lookup on the fast path?

gfn_to_hva() inherently checks memory attributes and fails if not permitted,
rendering these macro checks redundant:

virt/kvm/kvm_main.c:gfn_to_hva() {
    ...
	if (!kvm_mem_attributes_may_write_gfn(kvm, gfn))
		return KVM_HVA_ERR_RO_BAD;
    ...
}

If !kvm_is_error_hva(__addr) is true, the memory is already guaranteed to be
readable and writable.

> @@ -1371,7 +1372,8 @@ int kvm_gfn_to_hva_cache_init(struct kvm *kvm, stru=
ct gfn_to_hva_cache *ghc,
>  	typeof(v) __user *__uaddr =3D (typeof(__uaddr))(__addr + offset);	\
>  	int __ret =3D -EFAULT;						\
>  									\
> -	if (!kvm_is_error_hva(__addr))					\
> +	if (!kvm_is_error_hva(__addr) &&                                \
> +	    kvm_mem_attributes_may_write_gfn(kvm, gfn))		\
>  		__ret =3D put_user(v, __uaddr);				\
>  	if (!__ret)							\
>  		mark_page_dirty(kvm, gfn);				\

[Severity: Medium]
Similar to __kvm_get_guest above, does this inject a redundant xarray lookup
since !kvm_is_error_hva() already confirmed the memory is writable?

[ ... ]
> @@ -2632,6 +2634,12 @@ static inline unsigned long kvm_get_memory_attribu=
tes(struct kvm *kvm, gfn_t gfn
>  {
>  	return 0;
>  }
> +static inline bool kvm_range_has_any_memory_attributes(struct kvm *kvm,
> +						       gfn_t start, gfn_t end,
> +						       unsigned long mask)
> +{
> +	return false;
> +}
>  static inline u64 kvm_mem_attributes_generation(struct kvm *kvm)
>  {
>  	return 0;
>  }

[Severity: Low]
Will kvm_memslots_check_gen() cause a build failure when
CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES is disabled?

kvm_memslots_check_gen() unconditionally accesses kvm->mem_attrs.generation:

include/linux/kvm_host.h:kvm_memslots_check_gen() {
    ...
	return slots->generation =3D=3D slots_generation &&=20
               kvm->mem_attrs.generation =3D=3D attrs_generation;
}

However, the mem_attrs struct member is conditionally compiled under
CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES. Should kvm_memslots_check_gen() use t=
he
kvm_mem_attributes_generation(kvm) wrapper instead, which correctly returns=
 0
when the feature is disabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716181456.4027=
86-1-pbonzini@redhat.com?part=3D15
