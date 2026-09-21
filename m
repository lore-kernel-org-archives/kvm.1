Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8ED48B395
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 11:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789989357; cv=none; b=hji/0I+jpovd7LpQQXFkiKzzJLGtfERaos98NJEN9pEkrxczSopG1qUrkZuuS2Rw9Sw7h6NR2ofTB1fLsGd6rwfuJfj4TVXnSsZVr6L3D0ijmuouNX1Wo7cc9hUpTY1X+p7YeHMJTeeM8PYshfm2NoV4Rla7NQeP5RUiNb9H1Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789989357; c=relaxed/simple;
	bh=7tudY6BZDd/ChkJiHcdIfzMwRr1HXCFloGEgOBD6d/I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cvXfRvVs9CS7TLTxflHy8FiSDDPldMzjNzk4Q1hJHMv8wBCS5r1C4v1QH6KdihxTdntnQtg5HkfmPSKI1QeQQos48b24uCWlU3NbEKZSBxmlCC6nJz52+qeDE8EizCEdXI0ZcSYeMCGLimkoNIBUxjpTvUz+PRRLTHoA8y+BgyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Et6AS+Lc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Et6AS+Lc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4561F1F000FF;
	Mon, 21 Sep 2026 11:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789989355;
	bh=zbqKu5M8hUxotpmluaGv4u09URKpX/x6JjZd8ShekyA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Et6AS+LcDx5Kj2jaULSyR654+N47sN1pDa9K3ogr5Po5gdhPlgLpbCHXnfGqQPPzh
	 bhLsLv1sJeXOwYr/mCI2vlKbBB6967TCncJnYwUEhKO+41tKw1++MC8e/oXr1JC27H
	 OreX/SiHMytzWIMp8paUUtJaLMSJn2DjHlHQdBvY+1+xbpcfaUu9E7m9vduQ/oYIeX
	 FCWLB8VSIuOyPIDy0xe5271lfRs+/mBzSIkfikb2QCvuBMxfxsbp22zBzkq8D/MNLa
	 3A6y/+8tZKKySLivsBHgtLHSK9f1bBPdC996NMbHFBaXyvOZi+wc6h+YVhdUBFefFx
	 vUg98bCl/Qk5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/21] mm/pgtable: define (pgd|p4d|pud)_leaf() for
 folded page tables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yeoreum Yun" <yeoreum.yun@arm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260921-dummy_ptxp3-v1-6-cd40cf68242e@arm.com>
References: <20260921-dummy_ptxp3-v1-0-cd40cf68242e@arm.com>
 <20260921-dummy_ptxp3-v1-6-cd40cf68242e@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 11:15:54 +0000
Message-Id: <20260921111555.4561F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] mm: broken macro definitions for p4d_ERROR and pud_ERROR
--

commit b1d94b4085bf94fbd22f26d0b8cf668f45ded666
Author: David Hildenbrand (Arm) <david@kernel.org>

mm/pgtable: define (pgd|p4d|pud)_leaf() for folded page tables

This commit defines pgd_leaf(), p4d_leaf(), and pud_leaf() for folded page
tables, hard-coding them to return false. It updates the functions to use b=
ool
as a return type and ensures pud_leaf() is defined to prevent architectures=
 from
inadvertently overwriting it.

> diff --git a/include/asm-generic/pgtable-nop4d.h b/include/asm-generic/pg=
table-nop4d.h
> index 1cf739ee38aa1..c6a5a43899b50 100644
> --- a/include/asm-generic/pgtable-nop4d.h
> +++ b/include/asm-generic/pgtable-nop4d.h
> @@ -22,6 +22,9 @@ static inline int pgd_none(pgd_t pgd)		{ return 0; }
>  static inline int pgd_bad(pgd_t pgd)		{ return 0; }
>  static inline int pgd_present(pgd_t pgd)	{ return 1; }
>  static inline void pgd_clear(pgd_t *pgd)	{ }
> +static inline bool pgd_leaf(pgd_t pgd)		{ return false; }
> +#define pgd_leaf pgd_leaf
> +#define p4d_ERROR(p4d)				(pgd_ERROR((p4d).pgd))

[Severity: Low]
Is this p4d_ERROR() macro definition correct? It expands to pgd_ERROR(), but
pgd_ERROR() does not appear to exist in the kernel. This could cause a comp=
ile
error if a developer attempts to use p4d_ERROR() in architectures relying on
include/asm-generic/pgtable-nop4d.h.

> =20
>  #define pgd_populate(mm, pgd, p4d)		do { } while (0)
>  #define pgd_populate_safe(mm, pgd, p4d)		do { } while (0)

[ ... ]

> diff --git a/include/asm-generic/pgtable-nopud.h b/include/asm-generic/pg=
table-nopud.h
> index eedee8e3ad68f..6c9bca78047c4 100644
> --- a/include/asm-generic/pgtable-nopud.h
> +++ b/include/asm-generic/pgtable-nopud.h
> @@ -29,6 +29,9 @@ static inline int p4d_none(p4d_t p4d)		{ return 0; }
>  static inline int p4d_bad(p4d_t p4d)		{ return 0; }
>  static inline int p4d_present(p4d_t p4d)	{ return 1; }
>  static inline void p4d_clear(p4d_t *p4d)	{ }
> +static inline bool p4d_leaf(p4d_t p4d)		{ return false; }
> +#define p4d_leaf p4d_leaf
> +#define pud_ERROR(pud)				(p4d_ERROR((pud).p4d))

[Severity: Low]
Does pud_ERROR() propagate the missing macro issue? It expands to p4d_ERROR=
(),
which in turn attempts to use the non-existent pgd_ERROR(). This also appea=
rs
to result in a compile error if code in include/asm-generic/pgtable-nopud.h
attempts to use it.

> =20
>  #define p4d_populate(mm, p4d, pud)		do { } while (0)
>  #define p4d_populate_safe(mm, p4d, pud)		do { } while (0)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-dummy_ptxp=
3-v1-0-cd40cf68242e@arm.com?part=3D6
