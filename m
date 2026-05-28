Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E5D23D7F4
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779984218; cv=none; b=aBwqhzTIiKIaY2TEMPJk5ygKUSWgY1eOvuN6qj07YXC8dZ59tkZ5Z3g3VXKBrWkDQbwAlMIzeGUOkg1KSLAc/qbT9xwntddqkvWdfnMkt65m9vZZs1qgN/eYsgSQQFusrCxfUfJnbRa6CS9DgsRLKWFwrNqNodH8FxeuVnL70w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779984218; c=relaxed/simple;
	bh=SHR5XuyUXUp8gibPaKZDgipVAIHu6cxzwqyCaO6BLAQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dyZtvtx134VmDpVxhGcpZwsRwfv+xwXrDn6E7b3FAzFg1cLLopWj1f9824fqBYHJotlUEH788IqlDWYMAkoCLDzdby69fm8BE32nmrISZ2DDbv/ZttpCXJ82c+tWXfhYtIMADJlejOhU+i9GGpKW8pczQD9/URmn0z9X31u+WVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GP3D4GLf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GP3D4GLf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C431F00A3A;
	Thu, 28 May 2026 16:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779984217;
	bh=0t1kxCzYyqX8Q1nKND35Ow9V7eknmi6skOeGlLvL0sk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GP3D4GLfohOAHF7r1RB712pzSlXkofxr3BgSn9apSYLYTLg5ByvLNubU6rAa73Acm
	 6ZgeK4A7od03B0gkj76NxpxGphvMTZqf6au+ZiOUqKDT+7usswV10MAwOcLgAcdCwE
	 nPk94tq/FXP8/Bjo+fJR1f+WczsxXWyyddIGY4PjOFw4+U2fVfd6MR/16kRjh+4soz
	 arFpCKRet87oAzBkmxJ/gdjUrU+gmUeK1x/JAYATyMOwFLE0DdxMXpwk8PH1exi5FR
	 YMq6/dXWqK1MURqvu3Ns4sLqFY9b3YLZxDX59HnjTYMn+gQbySLaR0w0xwZANWz8Sf
	 c/eH4ociG9EWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 5/7] KVM: s390: Avoid potentially sleeping while
 atomic when zapping pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260528114727.142178-6-imbrenda@linux.ibm.com>
References: <20260528114727.142178-6-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 16:03:36 +0000
Message-Id: <20260528160337.26C431F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] gmap_helper_zap_one_page silently skips discarding swapped pag=
es when the page table lock is contended, leaking memory and breaking guest=
 discard semantics.
--

commit cefa85bd369123cca902b4376ee79221b7451b20
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Avoid potentially sleeping while atomic when zapping pages

This commit factors out try_get_locked_pte() which performs a spin_trylock()
and avoids blocking page table allocations. It modifies gmap page zapping
functions to use this non-blocking helper.

> diff --git a/arch/s390/mm/gmap_helpers.c b/arch/s390/mm/gmap_helpers.c
> index f8789ffcc05ca..7ba15f307bb02 100644
> --- a/arch/s390/mm/gmap_helpers.c
> +++ b/arch/s390/mm/gmap_helpers.c

[ ... ]

> @@ -57,7 +117,7 @@ void gmap_helper_zap_one_page(struct mm_struct *mm, un=
signed long vmaddr)
>  		return;
> =20
>  	/* Get pointer to the page table entry */
> -	ptep =3D get_locked_pte(mm, vmaddr, &ptl);
> +	ptep =3D try_get_locked_pte(mm, vmaddr, &ptl);
>  	if (unlikely(!ptep))
>  		return;

[Severity: Critical]
Does this silent return on lock contention create a guest data corruption
issue or swap leak?

Because try_get_locked_pte() uses spin_trylock() and returns NULL when
the page table lock is contended, this code will now silently skip
discarding the swapped page if there is concurrent activity on the
same PMD.

When a guest uses the ESSA instruction to discard a page, KVM marks it
as logically zero. If the swap entry is never zapped due to lock
contention, the guest might query the state and see it as zero, using
it without initialization.

However, a subsequent access by the guest will cause the host page
fault handler to fetch the old data from the swap device. KVM maps
this non-zero data into the guest, completely violating the guarantee
to supply a zeroed page.

Is there a fallback mechanism to handle the retry when
try_get_locked_pte() fails due to contention rather than a missing
page table?

>  	if (pte_swap(*ptep)) {
>  		ptep_zap_softleaf_entry(mm, softleaf_from_pte(*ptep));
>  		pte_clear(mm, vmaddr, ptep);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528114727.1421=
78-1-imbrenda@linux.ibm.com?part=3D5
