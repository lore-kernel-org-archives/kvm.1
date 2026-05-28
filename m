Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E733FB06E
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 17:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779988647; cv=none; b=hLf2SKRPkHVTPuiN66qp8oOly7GM1IEvXTC3b72yQhQvRbeqtMF3+KCRxNEHO86/KNWMAZ6wWNUEwJsukZhnJ3skQAsWhrHudYy4/Lb3mhEswR4AZwIE4Tdzf6B4ZeHi76ONK6PMKXpiF5BOs9TOH+V9iRAfvsMFAl4tIgdW5qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779988647; c=relaxed/simple;
	bh=z7tS3eVzIuaNFiY5YjMeWHxJU1vwWa2oxOz/BcgtUWE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bbct80r3CTsh7drcmpsmDimr7P36JBRssE9i1NYN7bilHVOOl+1mrbLFJnGeuuqZYAOQC8QQXGHO3ZtMzNzBY9XJHcPIVCC4btn5lzYoH4yy9GTLNhNS2vfj4KimoU6sc4cNhrT9PqAQXlb4Ns8DsoyCC7+g2KLWCAmK6vd+iYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqXeQIxO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqXeQIxO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1C01F000E9;
	Thu, 28 May 2026 17:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779988643;
	bh=ZO3v73gK9PcrqotQaZGDFJwxmBTsmutv9hCrbqYAQLA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FqXeQIxOSOZC7qg7LseYVzQ0LdvDehGl/YI1dnV1lqR9S+LHfzcFFB2q067g+tMjA
	 OocxBi9JCwFNriRgv7hLF5wlsrA7ULB5Brp3jODnA2mvunyjMUjCYsQhE9KP2KKYO6
	 PjBKjLZvY7xEJ+nEMmm65jWLqfJnKWRZHb2Whx5u3OlcxDZPwNV8Bhz5MZt+HSohQY
	 CPRbUTbaxAvr0UC8uc5Xpb6VM1TxJ5bRFrILJwu0pONT6fmn0YVnRmpexrWC++9P9o
	 eMHFGW1lHXfaw+XALLEuROk8X6kUiBJOjmr7su2BnjVDcvL2TpIFNK/ahXpOWgHwAW
	 pbQJTYJukzlng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 6/7] KVM: s390: Lock pte when making page secure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260528114727.142178-7-imbrenda@linux.ibm.com>
References: <20260528114727.142178-7-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 17:17:23 +0000
Message-Id: <20260528171723.CC1C01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Lockless host page table walk without mmap_lock or rcu_read_lock c=
an lead to a use-after-free.
- [High] Executing a polling hypercall with preemption disabled creates a s=
oft lockup hazard.
- [High] Infinite loop (livelock) when guest memory is backed by Transparen=
t Huge Pages (THP).

Pre-existing issues:
- [Critical] `_kvm_s390_pv_make_secure` blindly casts KVM-provided PFNs to =
a folio without validating whether the PFN corresponds to a refcounted stru=
ct page.
- [High] Holding a single PTE lock to prevent concurrent GUP during `folio_=
ref_freeze()` is insufficient if the folio is mapped by multiple PTEs.
--

commit 1e05383f44b9d07a44357c266f26898f02b36e27
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Lock pte when making page secure

Make sure _kvm_s390_pv_make_secure() takes the pte lock for the given
address when attempting to make the page secure.

One of the steps in making the page secure is freezing the folio using
folio_ref_freeze(), which temporarily sets the reference count to 0.
Any attempt to get such a folio while frozen will fail and cause a
warning to be printed.

Other users of folio_ref_freeze() make sure that the page is not mapped
while it's being frozen, thus preventing gup functions from being able
to access it. For _kvm_s390_pv_make_secure(), this is not possible,
because the page needs to be mapped in order for the import to succeed.

> By taking the pte lock, gup functions will be blocked until the import
> operation is done, thus avoiding the race.

[Severity: High]
This isn't a bug introduced by this patch, but is holding a single PTE lock
sufficient if the folio is mapped by multiple PTEs?

Userspace can create memory aliases (e.g., via mremap with MREMAP_DONTUNMAP
or multiple mmaps of the same memfd/shmem). If a concurrent thread triggers
GUP on an alias mapping, it would acquire a separate PTE lock.

Could that thread then observe the refcount of 0 temporarily set by KVM's
folio_ref_freeze(), triggering the exact WARN_ON_ONCE this locking strategy
aims to prevent?

> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
>
> diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
> index c2dafd812a3b2..3a7410f6b609c 100644
> --- a/arch/s390/kvm/pv.c
> +++ b/arch/s390/kvm/pv.c

[ ... ]

> @@ -103,17 +105,24 @@ static void _kvm_s390_pv_make_secure(struct guest_f=
ault *f)
>  {
>  	struct pv_make_secure *priv =3D f->priv;
>  	struct folio *folio;
> +	spinlock_t *ptl;	/* pte lock from try_get_locked_pte() */
> +	pte_t *ptep;
> =20
>  	folio =3D pfn_folio(f->pfn);

[Severity: Critical]
This is a pre-existing issue, but is it safe to unconditionally cast
f->pfn to a folio here without checking if f->page is valid?

If a guest issues a secure conversion request on memory backed by
un-refcounted device memory (VM_PFNMAP), __kvm_faultin_pfn() resolves
the PFN but leaves f->page as NULL.

Could this cause folio_trylock(folio) below to access invalid memory and
crash the kernel?

>  	priv->rc =3D -EAGAIN;
> -	if (folio_trylock(folio)) {
> +	if (!folio_trylock(folio))
> +		return;
> +
> +	ptep =3D try_get_locked_pte(priv->kvm->mm, gfn_to_hva(priv->kvm, f->gfn=
), &ptl);

[Severity: High]
Does this call to try_get_locked_pte() require mmap_lock or rcu_read_lock
to be held?

_kvm_s390_pv_make_secure() is called from kvm_s390_faultin_gfn(), which
is documented as running without the mm lock.

Could a concurrent munmap() free the page tables while they are being
walked by try_get_locked_pte(), leading to a use-after-free?

> +	if (ptep) {

[Severity: High]
What happens here if the guest memory is backed by Transparent Huge Pages
(THP)?

try_get_locked_pte() returns NULL for large PMD-mapped pages. If it
returns NULL, this block is skipped entirely, meaning -E2BIG is never
returned and priv->folio is not set.

Will this bypass the fallback logic in kvm_s390_pv_make_secure() that
calls s390_wiggle_split_folio(), causing a permanent livelock that
repeatedly returns -EAGAIN?

>  		priv->rc =3D __kvm_s390_pv_make_secure(f, folio);

[Severity: High]
Could calling __kvm_s390_pv_make_secure() while holding the PTE spinlock
create a soft lockup hazard?

If priv->needs_export is true, the code calls uv_convert_from_secure(),
which eventually issues the Ultravisor hypercall via uv_call().

Does this hypercall execute an unbounded polling loop without cpu_relax()
or cond_resched() while preemption is disabled by the pte lock?

>  		if (priv->rc =3D=3D -E2BIG || priv->rc =3D=3D -EBUSY) {
>  			priv->folio =3D folio;
>  			folio_get(folio);
>  		}
> -		folio_unlock(folio);
> +		pte_unmap_unlock(ptep, ptl);
>  	}
> +	folio_unlock(folio);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528114727.1421=
78-1-imbrenda@linux.ibm.com?part=3D6
