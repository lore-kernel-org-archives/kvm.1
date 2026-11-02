Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793643630;
	b=C34y7ih5Wy+mhxpBrMu2fIPTpDwvKimxs1hXOKE3On6QalOOdM8m/sYSJ4+BOdS7WfjB
	 xI2Volv/BPQMTKAW/KmNHJopsZrBdNmldYRBpMrWCf5AtBqIkAXSkgUkGme8/bw1G18Oj
	 KuRQAoAoDm3fmDPPQyg3YyT3eKGK/ChywGBHGT3tVn7/umTiVDQeJJ89lhEqbYzuIPK8A
	 7haxRVJ+V+npAUkSXaXEPJGemMTMAwqsB/cqFJzfLLRjJZKjcAwrSa1Ary0M6qrWck1Yw
	 DCQFxSDWm5VVSKckycsD1cUeBcZKYxSuvb8JytlxlGHkq8+adY/8iTu29DonV8D7v0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793643630;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=c3RvMiH8zEpbb9fLf9ZNY7C5HF4Ghz8wOHw7OfoAcKM=;
	b=4zgNs5WOfgXmG3amxZYgiXxh7og06T9q8C17yBEmrEyH5fH2qjpv8YMr+oqy6sNmpPgJ
	 cykV7qG3EPhrEPUbOQUafomk8lgBPlmACO+ZbZUNIdV0kNln9p4OT0SGRWmrZlE2+raat
	 SJ0una8+YgYVu9eyCFIpvoTqqHAJvG9mNYcVsZSOX9nahDn8K9Ik1/U0DRhEcBXK8guPq
	 pnDSsAH9PrCj8CWzFcL9dzj7qoKEg+wMIdD7Izv7kzQcZiJgP8LkfxQPzRPqGVgLsKrk4
	 b2GgQ44Ji/lgCh6aGrvPm9E0m7lPlq/q/Fjpxti9RHk7+y6fj7A1ke+8U+QPI6H852g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iFNJbTcd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62165606A324
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 18:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iFNJbTcd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4C81F00A16;
	Mon,  2 Nov 2026 18:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793643630;
	bh=c3RvMiH8zEpbb9fLf9ZNY7C5HF4Ghz8wOHw7OfoAcKM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=iFNJbTcdN70llmoXeDpDmgoH5YWfw8VqCJGZHQNIOg1Gfb3+xh617HhChNpTacMqv
	 65N8NiIrXOnFeUblEnrI/aB3oyAt2gW//gjT4bz5WUovyheULQ2PaDEHKeSRxslP9f
	 g92uUdCXrhnoRvyAuk4qyd8Ni4/Lh6YzRd7mvJ0xL3FJiks430KN3/WSwwnDFfGsrv
	 /0bu71VN/00i70PNDYA+YBdJ3skKlzXrVxBZExRuBCE+6bKhPYe/HxVuXbihbxg15u
	 Cn45cV3MHquJPJ3djMCDILM+eiy1LrFomhir7i7VyWWopiTdMf9raXJaI6t92ZQoJb
	 NjGYoV+7cU9iQ==
Message-ID: <sashiko-outbox-193927@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 24/45] KVM: Introduce a generation number for memory
 attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20261102174512.8903-8-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
 <20261102174512.8903-8-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 18:20:29 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] KVM: RCU stall in kvm_range_has_any_vm_memory_attributes() via xas=
_next()
- [Medium] KVM: unconditional generation bump and error-path sync in kvm_se=
t_vm_mem_attributes()
- [Low] KVM: loongarch: missing closing parenthesis in kvm_check_gen() cond=
itions
- [Low] KVM: stale attrs_generation on error in __kvm_gfn_to_hva_cache_init=
()
--

commit c500cbe0be12ea140c87b086c8905238fbefe1ea
Author: Nicolas Saenz Julienne <nsaenz@amazon.com>

KVM: Introduce a generation number for memory attributes

This commit introduces a generation number for VM memory attributes so that
KVM components using gfn_to_hva_cache and gfn_to_pfn_cache can detect memory
attribute updates and synchronize via KVM SRCU when attributes requiring
synchronization are modified.

Link: https://patch.msgid.link/20260918135030.171564-22-pbonzini@redhat.com

> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index c3e71ef983bcb..6301e726a536f 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
> @@ -163,7 +163,8 @@ static void kvm_update_stolen_time(struct kvm_vcpu *v=
cpu)
>  		return;
> =20
>  	gpa &=3D KVM_STEAL_PHYS_MASK;
> -	if (unlikely(!kvm_check_gen(vcpu->kvm, ghc->generation) || gpa !=3D ghc=
->gpa ||
> +	if (unlikely(!kvm_check_gen(vcpu->kvm, ghc->slots_generation, ghc->attr=
s_generation) ||
> +		     gpa !=3D ghc->gpa ||
>  		     kvm_is_error_hva(ghc->hva) || !ghc->memslot) {
>  		if (kvm_gfn_to_hva_cache_init(vcpu->kvm, ghc, gpa, sizeof(*st))) {
>  			ghc->gpa =3D INVALID_GPA;
> @@ -1817,7 +1818,8 @@ static void kvm_vcpu_set_pv_preempted(struct kvm_vc=
pu *vcpu)
> =20
>  	gpa &=3D KVM_STEAL_PHYS_MASK;
>  	ghc =3D &vcpu->arch.st.cache;
> -	if (unlikely(!kvm_check_gen(vcpu->kvm, ghc->generation) || gpa !=3D ghc=
->gpa ||
> +	if (unlikely(!kvm_check_gen(vcpu->kvm, ghc->slots_generation, ghc->attr=
s_generation) ||
> +		     gpa !=3D ghc->gpa ||
>  		     kvm_is_error_hva(ghc->hva) || !ghc->memslot) {

[Severity: Low]
As reported by Sashiko on v2 [1], does this fail to build on LoongArch due =
to
a missing closing parenthesis in both kvm_update_stolen_time() and
kvm_vcpu_set_pv_preempted()?

Both conditions open two parentheses at if (unlikely( before calling
!kvm_check_gen(vcpu->kvm, ghc->slots_generation, ghc->attrs_generation), but
only close one parenthesis after !ghc->memslot before the opening brace.

[ ... ]

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index da12f4d43c911..6aa6a0a55b070 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c

[ ... ]

> @@ -2558,6 +2559,53 @@ bool kvm_range_has_vm_memory_attributes(struct kvm=
 *kvm, gfn_t start, gfn_t end,
>  	return true;
>  }
> =20
> +/*
> + * Returns true if _any_ gfns in the range [@start, @end) have attribute=
s that
> + * match _any_ bit in @mask.
> + */
> +bool kvm_range_has_any_vm_memory_attributes(struct kvm *kvm, gfn_t start=
, gfn_t end,
> +					unsigned long mask)
> +{
> +	XA_STATE(xas, &kvm->mem_attrs.array, start);
> +	void *entry;
> +
> +	mask &=3D kvm_supported_vm_mem_attributes(kvm);
> +	if (!mask)
> +		return false;
> +
> +	if (end =3D=3D start + 1)
> +		return !!(kvm_get_vm_memory_attributes(kvm, start) & mask);
> +
> +	guard(rcu)();
> +	for (;;) {
> +		do {
> +			entry =3D xas_next(&xas);
> +		} while (xas_retry(&xas, entry));
> +
> +		if (xas.xa_node =3D=3D XAS_BOUNDS || xas.xa_index >=3D end)
> +			break;
> +
> +		if (xa_to_value(entry) & mask)
> +			return true;
> +	}

[Severity: High]
Can kvm_range_has_any_vm_memory_attributes() trigger an RCU CPU stall or so=
ft
lockup when userspace invokes KVM_SET_MEMORY_ATTRIBUTES over a large sparse=
 or
unassigned GFN range?

Unassigned GFNs are represented as NULL entries in kvm->mem_attrs.array, wh=
ere
xa_to_value(NULL) is 0, so NULL entries do not match mask and do not termin=
ate
the loop. However, the loop uses xas_next(&xas), which increments xas.xa_in=
dex
by 1 on every call across NULL slots and empty xa_node subtrees whenever the
XArray has an entry at an index >=3D end keeping xas.xa_node from reaching
XAS_BOUNDS.

Because the entire loop runs inside guard(rcu)() without rescheduling,
scanning a large sparse range will step through every empty GFN index one by
one while holding the RCU read lock. Should this use xas_next_entry(&xas,
end - 1) or xas_for_each(&xas, entry, end - 1) to skip empty slots?

> +
> +	return false;
> +}
> +
> +#define KVM_MEMORY_ATTRIBUTE_NEEDS_SYNC_MASK KVM_MEMORY_ATTRIBUTE_PROT
> +
> +static bool kvm_range_memory_attributes_need_sync(struct kvm *kvm,
> +						  gfn_t start, gfn_t end,
> +						  unsigned long attributes)
> +{
> +	u64 mask =3D KVM_MEMORY_ATTRIBUTE_NEEDS_SYNC_MASK;
> +
> +	if (attributes & mask)
> +		return true;
> +
> +	return kvm_range_has_any_vm_memory_attributes(kvm, start, end, mask);
> +}
> +
>  static __always_inline void kvm_handle_gfn_range(struct kvm *kvm,
>  						 struct kvm_mmu_notifier_range *range)
>  {
> @@ -2648,20 +2696,25 @@ static int kvm_set_vm_mem_attributes(struct kvm *=
kvm, gfn_t start, gfn_t end,
>  		.on_lock =3D kvm_mmu_invalidate_end,
>  		.may_block =3D true,
>  	};
> +	bool sync =3D false;
>  	unsigned long i;
>  	void *entry;
>  	int r =3D 0;
> =20
>  	entry =3D attributes ? xa_mk_value(attributes) : NULL;
> =20
> -	trace_kvm_set_vm_mem_attributes(start, end, attributes);
> -
>  	mutex_lock(&kvm->slots_lock);
> =20
>  	/* Nothing to do if the entire range has the desired attributes. */
>  	if (kvm_range_has_vm_memory_attributes(kvm, start, end, ~0, attributes))
>  		goto out_unlock;
> =20
> +	sync =3D kvm_range_memory_attributes_need_sync(kvm, start, end,
> +						     attributes);
> +
> +	trace_kvm_set_vm_mem_attributes(start, end, attributes, sync,
> +					kvm->mem_attrs.generation + 1);
> +
>  	/*
>  	 * Reserve memory ahead of time to avoid having to deal with failures
>  	 * partway through setting the new attributes.  Storing NULL never
> @@ -2684,10 +2737,16 @@ static int kvm_set_vm_mem_attributes(struct kvm *=
kvm, gfn_t start, gfn_t end,
>  		cond_resched();
>  	}
> =20
> +	/* Pairs with acquire in kvm_mem_attributes_generation() */
> +	smp_store_release(&kvm->mem_attrs.generation,
> +			  kvm->mem_attrs.generation + 1);
> +
>  	kvm_handle_gfn_range(kvm, &post_set_range);
> =20
>  out_unlock:
>  	mutex_unlock(&kvm->slots_lock);
> +	if (sync)
> +		synchronize_srcu_expedited(&kvm->srcu);

[Severity: Medium]
Should kvm->mem_attrs.generation only be incremented when sync is true, and
should synchronize_srcu_expedited() be skipped if xa_reserve() fails?

The commit message notes that for memory attributes that do not require
synchronization, the attributes generation will always remain unchanged.
However, kvm_set_vm_mem_attributes() unconditionally increments
kvm->mem_attrs.generation via smp_store_release() even when sync is false,
which invalidates all gfn_to_hva_cache and gfn_to_pfn_cache entries across =
the
VM (and causes non-refreshing cache checks such as
kvm_steal_time_set_preempted() to bail out) when toggling attributes like
KVM_MEMORY_ATTRIBUTE_PRIVATE.

In addition, because sync is computed and trace_kvm_set_vm_mem_attributes()=
 is
called with kvm->mem_attrs.generation + 1 before the xa_reserve() loop:

	for (i =3D start; entry && i < end; i++) {
		r =3D xa_reserve(&kvm->mem_attrs.array, i, GFP_KERNEL_ACCOUNT);
		if (r)
			goto out_unlock;

		cond_resched();
	}

if xa_reserve() fails and jumps to out_unlock while sync is true,
kvm_set_vm_mem_attributes() still runs synchronize_srcu_expedited(&kvm->src=
u)
even though no attributes or generation numbers were updated.

[ ... ]

> @@ -3582,7 +3641,8 @@ int kvm_vcpu_write_guest(struct kvm_vcpu *vcpu, gpa=
_t gpa, const void *data,
>  }
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_write_guest);
> =20
> -static int __kvm_gfn_to_hva_cache_init(struct kvm_memslots *slots,
> +static int __kvm_gfn_to_hva_cache_init(struct kvm *kvm,
> +				       struct kvm_memslots *slots,
>  				       struct gfn_to_hva_cache *ghc,
>  				       gpa_t gpa, unsigned long len)
>  {
> @@ -3592,8 +3652,8 @@ static int __kvm_gfn_to_hva_cache_init(struct kvm_m=
emslots *slots,
>  	gfn_t nr_pages_needed =3D end_gfn - start_gfn + 1;
>  	gfn_t nr_pages_avail;
> =20
> -	/* Update ghc->generation before performing any error checks. */
> -	ghc->generation =3D slots->generation;
> +	/* Update ghc->slots_generation before performing any error checks. */
> +	ghc->slots_generation =3D slots->generation;
> =20
>  	if (start_gfn > end_gfn) {
>  		ghc->hva =3D KVM_HVA_ERR_BAD;
> @@ -3612,6 +3672,8 @@ static int __kvm_gfn_to_hva_cache_init(struct kvm_m=
emslots *slots,
>  			return -EFAULT;
>  	}
> =20
> +	ghc->attrs_generation =3D kvm_mem_attributes_generation(kvm);

[Severity: Low]
Should ghc->attrs_generation be updated alongside ghc->slots_generation bef=
ore
the error checks in __kvm_gfn_to_hva_cache_init()?

ghc->slots_generation is updated before checking start_gfn > end_gfn or
running the gfn_to_hva_many() loop so that when an invalid GPA sets ghc->hva
to KVM_HVA_ERR_BAD, subsequent calls to kvm_read_guest_offset_cached() or
kvm_write_guest_offset_cached() pass kvm_memslots_check_gen() and immediate=
ly
hit the fast-path kvm_is_error_hva(ghc->hva) check.

Because ghc->attrs_generation is only updated after those error returns (wh=
ich
remains the case after the follow-up commit "KVM: Take memory protections i=
nto
account for accesses with cached gfn->hva"), if a cached range fails in the
memslot lookup loop after kvm->mem_attrs.generation has advanced,
ghc->attrs_generation remains stale and every subsequent cached access will
repeatedly fail kvm_memslots_check_gen() and re-run
__kvm_gfn_to_hva_cache_init().

[1] https://lore.kernel.org/r/20260918081543.139871-19-pbonzini@redhat.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102174130.8779=
-1-pbonzini@redhat.com?part=3D24
