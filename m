Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6DC2F8E94
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 18:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780423781; cv=none; b=lrc+YEi77z5mEze48+Ooi6qM/rhCVDG6auWKtVcjjGmOogf/fdfb4SBk2p455pfcYYQc/tOu7wdGDW94VAVmY4hLchV4gacCBBX/EO6yUbdD54VIf2FIJmhTxGxTDGtjz/eB/r5tSidhuVYV2ZYXZr5exozG1QkuNvMze4z7hVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780423781; c=relaxed/simple;
	bh=hHLTYTzTE0H7fWNyKOUUi09aA0sG1evmMzkjn3rxuGs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cIdiy1an+jYc5hlCppEHeGCXy7JGf6orwTHAzS6no46i8f+qeRjmnZ6mH41/ctGb5ik1BT+p/EuT/3Jrsvf1A3ARgBauAr6hXAutDIvB/uNFP9+61aEIYvBCYbLgQBZMdQOM063c1RwU+oJE1osalPuVY6uuXl6F6P1wJbgxt50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnzWxyhV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnzWxyhV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B61E1F00898;
	Tue,  2 Jun 2026 18:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780423780;
	bh=duhkFP2DclUq+4IOGM5KQBeZRzR03RgWZK5rKfCt3+8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CnzWxyhVe6NBAkYD5Lso1fgEZGt/n1mVo/GCA80POBJG1p+qBqGS9HMx8lOObRe5S
	 uJBjKh0jiAYqCtAAD/l9hIOSq2Q12steAeLl8fK6cFsHrUK226KO6BHkBw280ERw21
	 HhKTe2xoXlrGFBch9N7iyfAq9kZPH17QzS/G5W0wqaXWLdUXCzsAq5LFpDM9nR3Ngf
	 30vWQ3KAIuop81+8MvnicoubbIV8w5elXS89782Vu5lSKntLOYgQIJTEFZDzR1yr+5
	 w28K39JqKgrNEcENzISpb7Pgbpd8ZFx2QCzCg2+4zBYW2O9gtQVS8TBaENXz+IKVBO
	 r1iQqKq5ZiTRA==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 03/10] KVM: s390: Avoid potentially sleeping while
 atomic when zapping pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260602174819.255785-4-imbrenda@linux.ibm.com>
References: <20260602174819.255785-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 18:09:39 +0000
Message-Id: <20260602180940.6B61E1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The lockless page table walk in `try_get_locked_pte` is vulner=
able to a Time-of-Check to Time-of-Use (TOCTOU) race when traversing page t=
able directories, leading to wild pointer dereferences and kernel panics.
--

commit 4a478ef198892a577c1dcca6c09a2986ca006e37
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Avoid potentially sleeping while atomic when zapping pages

This commit factors out try_get_locked_pte(), which behaves similarly to
get_locked_pte(), but does not attempt to allocate missing tables and
performs a spin_trylock() instead of blocking.

> diff --git a/arch/s390/mm/gmap_helpers.c b/arch/s390/mm/gmap_helpers.c
> index f8789ffcc05ca..396207163ca6c 100644
> --- a/arch/s390/mm/gmap_helpers.c
> +++ b/arch/s390/mm/gmap_helpers.c
[ ... ]
> @@ -34,6 +34,70 @@ static void ptep_zap_softleaf_entry(struct mm_struct *=
mm, softleaf_t entry)
>  	swap_put_entries_direct(entry, 1);
>  }
> =20
> +/**
> + * try_get_locked_pte() - like get_locked_pte(), but atomic and with try=
lock
[ ... ]
> +pte_t *try_get_locked_pte(struct mm_struct *mm, unsigned long vmaddr, sp=
inlock_t **ptl)
> +{
> +	pmd_t *pmdp, pmd, pmdval;
> +	pud_t *pudp, pud;
> +	p4d_t *p4dp, p4d;
> +	pgd_t *pgdp, pgd;
> +	pte_t *ptep;
> +
> +	pgdp =3D pgd_offset(mm, vmaddr);
> +	pgd =3D pgdp_get(pgdp);
> +	if (pgd_none(pgd) || !pgd_present(pgd))
> +		return NULL;
> +	p4dp =3D p4d_offset(pgdp, vmaddr);
> +	p4d =3D p4dp_get(p4dp);
> +	if (p4d_none(p4d) || !p4d_present(p4d))
> +		return NULL;
> +	pudp =3D pud_offset(p4dp, vmaddr);
> +	pud =3D pudp_get(pudp);
> +	if (pud_none(pud) || pud_leaf(pud) || !pud_present(pud))
> +		return NULL;
> +	pmdp =3D pmd_offset(pudp, vmaddr);

[Severity: Critical]
Does this code introduce a Time-of-Check to Time-of-Use (TOCTOU) race?

When executing try_get_locked_pte() under mmap_read_lock, concurrent page
table zapping operations holding the VMA write lock (e.g., MADV_DONTNEED) c=
an
clear page table entries.

The standard offset macros (p4d_offset, pud_offset, pmd_offset) re-read the
entry from memory. For instance, on s390, pmd_offset is defined as
pmd_offset_lockless(pudp, *pudp, address), which dereferences pudp again.

If a concurrent zap clears the PUD between pudp_get and pmd_offset, the
re-read *pudp will be empty. The offset macro will extract the origin addre=
ss
from the empty entry (evaluating to 0), and return an address based on
physical address 0.

The subsequent pmdp_get_lockless(pmdp) reads garbage from the s390 lowcore.
If this garbage resembles a valid PMD, it can lead to an out-of-bounds PFN
extraction and a kernel panic during spin_trylock().

Should this lockless walk use the _lockless offset variants
(e.g., pmd_offset_lockless(pudp, pud, vmaddr)) to pass the already-validated
local values instead?

> +	pmd =3D pmdp_get_lockless(pmdp);
> +	if (pmd_none(pmd) || pmd_leaf(pmd) || !pmd_present(pmd))
> +		return NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602174819.2557=
85-1-imbrenda@linux.ibm.com?part=3D3
