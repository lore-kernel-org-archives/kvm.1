Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A9A3EDE59
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 14:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411448; cv=none; b=Z9NH4l0BylOINn4iL8yCctRqin43nnWVkv9alMv8jPUx30yL3RjKiwJUqZ3+mpOTb9B8ymGAOFI+ccrAkrLDaBBqtZxNL0qxA6DWwg9YhfjAgyxcqBxR5G2brbj5NVQmYparUpTUf2BI2BUVXbmXsrOueB36Evtdq7JI4i3m3Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411448; c=relaxed/simple;
	bh=f60BbpfOIzR1+OPJ/IDiTUmCk2Qvjg2fiiLflB20l6Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cFQ8aSPnohDsZNgOj112dsncZ5We8uW6kK6ZGrSDXRWtitSVfTk2I08NGNNi2kwJXAcY1vWJdYULGFt+wbRjgzELw+kDT4ExNimRzduV/ZIYwhYRRSTXEubRObtRlrvSGg8G+26kKcfmZ2CLfuzkitLx3fP6WfGvzMj07BYrJB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SpwKga3o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpwKga3o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0981F00893;
	Tue,  2 Jun 2026 14:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780411447;
	bh=/Q/BHeQKo50/HLyef9f9x5JAfftABw7ODmbS8+rnxpA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SpwKga3oihOlx5nVAtyOQaW3EItD7NBfrKR+76VZR/f29Sd3MSco1UB3xNFO4HmX1
	 8DZMT3fJtxVGtmFpjD1SGPabQDW5i2pdrxdtqZxbDxDR1/5AOkZpTMq+GuTWKDd2YB
	 lCBiXTsrbGHtsD0G5geLRrRZtLD9lVgPQ1S3Pb8Vrn/xfLWfOpyoaxFUHIvPJ/TaeO
	 T6dfU6fv94MzkGycLrIIK6cxR2PJDK8vA0hq6rDrocHjFC8ZKclwLxC0N7FtibT9at
	 CjL9n9u4fxh/5OFe+WMcCOREjlhw4E3VDL1liS2peLFkT2J4uvs89MWZgiB+MesB/b
	 lL4E2APkZTJxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/10] KVM: s390: Lock pte when making page secure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260602142356.169458-8-imbrenda@linux.ibm.com>
References: <20260602142356.169458-8-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 14:44:06 +0000
Message-Id: <20260602144406.CD0981F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] If try_get_locked_pte returns NULL for a THP, the host PTE lock is=
 bypassed. A concurrent split of the THP allows freezing the folio without =
the PTE lock, reintroducing the GUP race the patch intended to fix.

Pre-existing issues:
- [High] Host kernel panic when a PV guest attempts to secure memory backed=
 by raw PFNs (e.g., PFNMAP/VFIO without a struct page).
--

commit aa4d37eba4327b04312028eb0cda26ab49b2e88f
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Lock pte when making page secure

This commit attempts to fix a race with GUP when freezing folios during the
secure page import process by temporarily locking the PTE.

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

[Severity: High]
This is a pre-existing issue, but can this cause a host kernel panic if the
guest attempts to secure memory backed by raw PFNs (e.g., PFNMAP/VFIO)
that lack a struct page?

If kvm_s390_faultin_gfn() resolves the GFN to a raw PFN but leaves
f->page =3D NULL, blindly converting it via pfn_folio() accesses memory
outside the bounds of the vmemmap array, returning a garbage pointer.

Later in __kvm_s390_pv_make_secure(), the code does:

    if (!f->page)
        folio_get(folio);

Would this try to increment the reference count of that garbage pointer?

>  	priv->rc =3D -EAGAIN;
> +
> +	if (!mmap_read_trylock(priv->kvm->mm))
> +		return;
> +
> +	ptep =3D try_get_locked_pte(priv->kvm->mm, gfn_to_hva(priv->kvm, f->gfn=
), &ptl);
> +	if (IS_ERR_VALUE(ptep)) {

[Severity: High]
Since try_get_locked_pte() returns NULL for large PMDs (THPs) or unmapped
entries, and IS_ERR_VALUE(NULL) evaluates to false, does this proceed
with ptep =3D=3D NULL and no PTE lock?

If the memory is a THP and a concurrent operation triggers a THP split
immediately after try_get_locked_pte() returns NULL, the THP becomes
order-0 folios. The KVM thread then successfully locks the newly-split
order-0 folio and freezes it since it bypassed the PTE lock entirely.

Could a concurrent slow GUP on the same address then acquire the PTE lock,
read the PTE, and call try_grab_folio(), triggering a WARN_ON_ONCE because
the folio refcount is 0?

> +		priv->rc =3D PTR_ERR(ptep);
> +		goto out;
> +	}
> +
>  	if (folio_trylock(folio)) {
>  		priv->rc =3D __kvm_s390_pv_make_secure(f, folio);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602142356.1694=
58-1-imbrenda@linux.ibm.com?part=3D7
