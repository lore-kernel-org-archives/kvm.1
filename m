Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A676472F6A
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 12:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788351313; cv=none; b=bGUlHOusGnFbOgsX4Peur1ZHlAG/6e4RqNwVAKXfSDwUR24cp3AJ4lXXf59yK5HqhqcSUIiO2EnQcuwpY2l+XCGxtMtSqmSjSdwHeBHBTqoRCRUc928T5CKU9WPLjvy10zj1e8HGzfQrUUBfmwIBtbM/yNTzz9b/6uHsr8sUBXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788351313; c=relaxed/simple;
	bh=LyPwWXtac99SvcIZO8VmS8HOFoqwazOsi5l9vFFCBeA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JO+cg1qdZr7Htv8i0DzI4Zvp7eAJ9SqZkexXU8djhvOhQ9wJ9hdAbyMBqy4qGsFJz49yQaNV+nICOiwnAQqljp7HZ88zLY+ZWvH2PJYZDZM5n/yhllQ4SDKTYRsjkKjTbgrZUJAf4UE8QCNf3odnb5T8M6YZNjgjNxL6rKNfUmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmnePCcw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmnePCcw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765DC1F000E9;
	Wed,  2 Sep 2026 12:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788351310;
	bh=ka+kSBrdZ8lZLRrAVJysjJCuJ+4QdMHnDrGZRMHXo3c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZmnePCcwN+RnpKkLmLL/B+krU1n6FCuIx+K+W2olq/t08bMVlnkzGKSuz4fhtr+v+
	 qZz605Sflhui3wdQ8Wven26gDRH93uyXaF3F+8Z0Gr9uoL65Y5vF9uLaozL7l6I4yl
	 gtZMFeIQGelFxVgOAMR0eetli95DL4xFcO1lkFy6lNO7qkfFnTpVeC27fLwTPJsgrp
	 q0RqYLlaP76erwxFpw++yokFd80htS63iRHnuqvLz23wAuLF0u+sX0Ve5LK9FVTqdi
	 lurIk4mEj8/1O1HKh0F9Xvxvk84HRN5bgck6MgM6Ecu04nNPONco3K3WtD7mVJVy4c
	 a4zlYi1h2rErQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 06/21] mm/pgtable: define (pgd|p4d|pud)_leaf()
 for folded page tables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yeoreum Yun" <yeoreum.yun@arm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260902-dummy_ptxp3-v3-6-5d8f5b17c25c@arm.com>
References: <20260902-dummy_ptxp3-v3-0-5d8f5b17c25c@arm.com>
 <20260902-dummy_ptxp3-v3-6-5d8f5b17c25c@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 12:15:10 +0000
Message-Id: <20260902121510.765DC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch accidentally resurrects the `p4d_ERROR` and `pud_ERROR` m=
acros, which reference a non-existent `pgd_ERROR` macro.
--

commit 1ad6d2e7fa6f4d648ec4866410881fd66f3c3298
Author: David Hildenbrand (Arm) <david@kernel.org>

mm/pgtable: define (pgd|p4d|pud)_leaf() for folded page tables
   =20
Define (pgd|p4d|pud)_leaf(), hard-coding it to "false". Note
that it's missed to define pud_leaf() before, allowing architectures to
unknowingly overwrite it.

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
Does this resurrect a broken macro? pgd_ERROR does not appear to exist in t=
he
codebase anymore, so if a developer attempts to use p4d_ERROR in the future,
would it result in a build failure due to an undefined symbol?

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
Since p4d_ERROR relies on the non-existent pgd_ERROR as noted above, does t=
his
also mean pud_ERROR is broken in the same way?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902-dummy_ptxp=
3-v3-0-5d8f5b17c25c@arm.com?part=3D6
