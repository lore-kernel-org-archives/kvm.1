Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7A133EB01
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 18:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784226989; cv=none; b=XAjvX4gIeB1NU4ZZ8mbxivk4sGm8bLOwjJ/kX7M6q0gezHdSwfme8R8xV6Eba3rDB4Mc4/0s77Ddgc37WYPuKjmpKu5hgtliLiI3zQsBh8hEyuZTAjTHgmknL6kIWfjCk88Df+035PBWy/bt3EDS+YH4Z4nhvLzrBJZYs2L5TEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784226989; c=relaxed/simple;
	bh=4lKZONOYkWxg9ced9szOxDslHuDvFDcJaIOav9EscvY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=psPzEeDlNPJACcFDr7hrHaYFO4CeiO156fEfQvq0GMvL20i6dVBENN6JL+rnBHFE46jE/cVecpEOtWAkHRLes7PRpzek9E8p8GkhjDwMArhB6wxSX3eCCuBkJiRj48CDoF5u+2MkCIvgUXc7BAWR5kxUmGGzzbUeDKTHIdy0qFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foUIvahq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foUIvahq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53ED31F000E9;
	Thu, 16 Jul 2026 18:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784226987;
	bh=uAVnP89Uq3Jprk1F3yILUE4daoG5rDMwVXbU+8f9Nzg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=foUIvahqyaG6EceK9U3TYVjL6w/cVfUkijkpR+0frqqYYj71kmEamKwf2VzqL6iDD
	 6FdHVuvmmGJL029QRayLyIDtdleRGnQBuZmY46TKFrkLfGPBU42VrWn19sxwbci2/b
	 O7zTp2xucdB3jR0/LFl0cLWLE6FMw6CkfbUph01I3y6I+bATJT5U+qC6TdbMZaUEAI
	 cDHBAoxMjRmhZ+uTKznzEv8rPvkWJ8rfr+vXcOD+kpiRhVPTTJ1OEtoxz5/qTTInnA
	 CuwcVgnDL7S8jwQ1tE8C/HGDj0vGe4R362C0aAC1GBohF3Y8WmJZrietqfmigQhQTx
	 OY4PpSX8hxYIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/24] KVM: Introduce a generation number for memory
 attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260716181456.402786-15-pbonzini@redhat.com>
References: <20260716181456.402786-1-pbonzini@redhat.com>
 <20260716181456.402786-15-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 18:36:26 +0000
Message-Id: <20260716183627.53ED31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] xas_next() causes O(N) RCU stalls in kvm_range_has_any_memory_attr=
ibutes()
- [High] Unconditional increment of kvm->mem_attrs.generation causes global=
 cache invalidation
- [Medium] Data race and potential torn read of kvm->mem_attrs.generation
- [Low] Access to mem_attrs outside of #ifdef CONFIG_KVM_GENERIC_MEMORY_ATT=
RIBUTES breaks compilation
--

--- Patch [14]: [PATCH 14/24] KVM: Introduce a generation number for memory=
 attributes ---
commit 1b3b4442db618c511fecddd4a021c24933baeaa1
Author: Nicolas Saenz Julienne <nsaenz@amazon.com>
Subject: KVM: Introduce a generation number for memory attributes

Introduce a generation number to track memory attribute modifications.
This will allow KVM components to invalidate any assumptions they might
have about guest's physical addresses and their permissions when memory
attributes change.

> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 122af87d6f9a5..1fad3eb303c17 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h

[ ... ]

> @@ -2559,29 +2560,49 @@ static inline bool kvm_mem_attributes_may_exec(u6=
4 attrs)
>  	return !(attrs & KVM_MEMORY_ATTRIBUTE_NX);
>  }
> =20
> -static inline bool kvm_memslots_check_gen(struct kvm *kvm, u64 slots_gen=
eration, struct kvm_memslots **p_slots)
> +static inline bool kvm_memslots_check_gen(struct kvm *kvm, u64 slots_gen=
eration,
> +					  u64 attrs_generation, struct kvm_memslots **p_slots)
>  {
>  	struct kvm_memslots *slots =3D *p_slots =3D kvm_memslots(kvm);
> -	return slots->generation =3D=3D slots_generation;
> +	return slots->generation =3D=3D slots_generation && kvm->mem_attrs.gene=
ration =3D=3D attrs_generation;

[Severity: Low]
Does this break compilation when CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES is
disabled? The mem_attrs field in struct kvm is guarded by this config,
but it is accessed unconditionally here. Should this use the
kvm_mem_attributes_generation() helper instead?

[Severity: Medium]
Is there a data race on kvm->mem_attrs.generation here?

kvm_vm_set_mem_attributes() updates the generation counter using
smp_store_release(). Since kvm_memslots_check_gen() reads it concurrently
in lockless fast-paths, a plain C read could lead to torn reads on
some architectures. Would it be safer to use READ_ONCE() or the
kvm_mem_attributes_generation() helper?

>  }

[ ... ]

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 1afaec56ecb37..2fe4087319adf 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c

[ ... ]

> +bool kvm_range_has_any_memory_attributes(struct kvm *kvm, gfn_t start, g=
fn_t end,
> +					unsigned long mask)
> +{
> +	XA_STATE(xas, &kvm->mem_attrs.array, start);
> +	void *entry;
> +
> +	mask &=3D kvm_supported_mem_attributes(kvm);
> +	if (!mask)
> +		return false;
> +
> +	if (end =3D=3D start + 1)
> +		return !!(kvm_get_memory_attributes(kvm, start) & mask);
> +
> +	guard(rcu)();
> +	for (;;) {
> +		do {
> +			entry =3D xas_next(&xas);
> +		} while (xas_retry(&xas, entry));
> +
> +		if (xas.xa_index >=3D end)
> +			break;
> +
> +		if (xa_to_value(entry) & mask)
> +			return true;
> +	}
> +
> +	return false;
> +}

[Severity: High]
Can this loop cause CPU soft lockups and RCU stalls when querying a large,
sparse memory range?

If the requested range is empty, xas_next() will return NULL and increment
the internal array index by 1 step-by-step. For millions of pages, this
will iterate millions of times under guard(rcu)().

Should this use xas_find() or xas_for_each() to skip empty entries in O(1)
time instead?

[ ... ]

> @@ -2594,10 +2645,16 @@ static int kvm_vm_set_mem_attributes(struct kvm *=
kvm, gfn_t start, gfn_t end,
>  		cond_resched();
>  	}
> =20
> +	/* Pairs with acquire in kvm_mem_attributes_generation() */
> +	smp_store_release(&kvm->mem_attrs.generation,
> +			  kvm->mem_attrs.generation + 1);

[Severity: High]
The commit message states: "There shouldn't be any performance loss for
memory attributes that don't require synchronization ... because the
attributes generation will always remain unchanged."

However, kvm->mem_attrs.generation is unconditionally incremented here,
even if the sync flag is false. Will this global increment invalidate all
gfn_to_hva_cache and gfn_to_pfn_cache entries across the entire VM
unnecessarily? Should this be conditional on the sync flag being true?

> +
>  	kvm_handle_gfn_range(kvm, &post_set_range);
> =20
>  out_unlock:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716181456.4027=
86-1-pbonzini@redhat.com?part=3D14
