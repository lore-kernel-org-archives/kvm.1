Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9A33DCDAB
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780333832; cv=none; b=LtF3LwDg5tzVp+lzVfiGFgLRfGwXVqv9hXlZLra44M6vADhsueC6Gu15GARVU+Pv6mGFUbycP5oREtwr2tudZ8LgrWsvYRsDi9G6vC2SjriulP2IPPdKU7OaQhoSxltUzhsl0cZevZYZjMI9WAxvOhFPeBxplBev6DMvv8dW1O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780333832; c=relaxed/simple;
	bh=DqeyIqg3qnfJO5dAYV8DzNSRB6A6jIsRtDRlZz41WGY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UskQCsCXsJdJjPPD+RL7kSjed/MDX7L0PfaO9wVWFloFjHEEtkw57N6YPJQVmnVFjGIVBAAN9XoFOPpJN3mmQ8suHCyXyJkXBxL624uukHBMYh2XYaRKL7INdCO+O/HYjYdCgwW+5QWuRCRrr4hwO/Tk+W+FVNL5pmSmYKctVPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKf9yxD9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKf9yxD9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9FC21F00893;
	Mon,  1 Jun 2026 17:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780333831;
	bh=RapW96cL/HGQvr+5Cm+5hCL2IoWerb80jL98Cj6Rm5I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GKf9yxD913Fg9AyJYrWFgqQSdBzqX4JIIkswRx+NVsM4eUmeABOMDybFqT1jTU3yn
	 OlPkkJ8FqZJnn93mzFzxtC5/Xcu4ctDv7ZUmN+eVnY+Qh8v+IsSvGf33VVpeH7+OfM
	 J/K91bnpABRv+3CjxJnzrfa3ut3owl1kP9YpjgjFDE3AkT7WA7oprFpyuXNydGcoej
	 DVmXMBbJSiR5lW68lvHT9cBKxPvKeQUSfLyXBz8G6xs1mcrLDy60XCwZ0s6R9tCrm4
	 Fwdx5FtuuGwF16jTnC+tWcfg6dDHsokjwDSvx3GyR2QeZOS2iUSHXWUBy71hfCm0UZ
	 IZdDOhz0WLkzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/8] KVM: s390: Lock pte when making page secure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260601152951.196859-8-imbrenda@linux.ibm.com>
References: <20260601152951.196859-8-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 17:10:30 +0000
Message-Id: <20260601171030.C9FC21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Unconditional conversion of a raw PFN to a folio using `pfn_fo=
lio()` in `_kvm_s390_pv_make_secure()` leads to a host kernel panic when ap=
plied to device memory.
--

commit e0fa339799f284890bdbcc3dd174cd7125deb24a
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Lock pte when making page secure

This commit ensures that _kvm_s390_pv_make_secure() takes the pte lock
for the given address before freezing the folio during Secure Execution
transitions. This prevents concurrent GUP access while the page is mapped.

> diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
> index c2dafd812a3b2..4b865e75351c1 100644
> --- a/arch/s390/kvm/pv.c
> +++ b/arch/s390/kvm/pv.c
[ ... ]
> @@ -103,9 +105,21 @@ static void _kvm_s390_pv_make_secure(struct guest_fa=
ult *f)
>  {
>  	struct pv_make_secure *priv =3D f->priv;
>  	struct folio *folio;
> +	spinlock_t *ptl;	/* pte lock from try_get_locked_pte() */
> +	pte_t *ptep;
> =20
>  	folio =3D pfn_folio(f->pfn);

[Severity: Critical]
This is a pre-existing issue, but can this unconditional conversion of a raw
PFN to a folio cause a host kernel panic when a guest maps device memory?

If a malicious or misconfigured guest maps device memory (e.g., via VFIO PC=
I)
into its address space and attempts to transition it to Secure Execution,
KVM's fault-in logic will return a valid PFN but set f->page =3D NULL for r=
aw
device memory without a vmemmap.

If we unconditionally call pfn_folio(f->pfn) before checking f->page,
pfn_to_page() yields an invalid pointer. The page_folio() wrapper then
immediately dereferences this pointer to read the compound_head field.

Furthermore, even if the PFN is valid but points to a reserved page, the
fallback logic in __kvm_s390_pv_make_secure() could attempt to increment
the refcount of a reserved page:

__kvm_s390_pv_make_secure() {
    ...
    if (!f->page)
        folio_get(folio);
    ...
}

Could this crash the kernel via VM_BUG_ON_FOLIO() on systems with
CONFIG_DEBUG_VM enabled? Should the folio conversion be delayed until
after verifying we have a normal refcounted memory page?

>  	priv->rc =3D -EAGAIN;
> +
> +	if (!mmap_read_trylock(priv->kvm->mm))
> +		return;
> +
> +	ptep =3D try_get_locked_pte(priv->kvm->mm, gfn_to_hva(priv->kvm, f->gfn=
), &ptl);
> +	if (IS_ERR_VALUE(ptep)) {
> +		priv->rc =3D PTR_ERR(ptep);
> +		goto out;
> +	}
> +
>  	if (folio_trylock(folio)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601152951.1968=
59-1-imbrenda@linux.ibm.com?part=3D7
