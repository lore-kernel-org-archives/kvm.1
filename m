Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FC53F327F
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 15:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784735933; cv=none; b=PDo3E6jPOB5tQru8iylJcWNv6uOzP69zg2HWK2Gz0slf3Cogd1ArEodDvvXEa4PKgU4RWOBDRCQcR2229sUku5/wH0XW5ByoGSvk8vAJjoOcV7oqPdaENykThRHkXOm8Hce4MIqLsUErrGhUa6RXk9QqUuJagvwov+AKswA1PuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784735933; c=relaxed/simple;
	bh=V8gEdVqdHWvaKOxxIVHWbQQDTrOhVBk1RSHj/ZnQ+es=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qLPzTrLMmfWwyOt4Wnb5tY8gBWxjo1PfFlmvLiR0JU4Do4koiflVEwRbBjX1/3in2TeQI1UZNBzaLipgyFNz97OQg9UT8q/uexpzWF4nDFghZmovLDzEI4N6QVbewGInAR5vYTJPHpnF973k3R8JLmljvFCoUr9C1i8koQMeWHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGD5w97i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGD5w97i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85FF41F00A3A;
	Wed, 22 Jul 2026 15:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784735929;
	bh=VYML33X00lCUmLsOVxbC13tGB3OqBQVWlwbsJFfU1Qs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JGD5w97ijvOyMQyPSMhj3wIUK6vK6u0f6ynBhjGy6VgtMaE9ACEDLbV7N7Twec23v
	 i0jfe25sczoNSvXlATlAzHaPRAqy2zoPvOCJn1l8pmQMaFxx95vEh8Ph2f7aJi238c
	 dsZdvuqjoRdbyxYOI8btz9nxa9bLMav7eJBOR0XptDqswjhw+rH/goU16RQA6+12UR
	 3f8jhTiGb2E6+D3X4MWs0kfKbYLYNbbgUxooajf3t8HXTdaNehr5sbCvsIwWb24K21
	 PNcGEQXFwmPTykJjtp78OO1kEqVl2azKFZNf3DztDr4OiiJ3KrnlSm6a2R5L7iaJR7
	 /uLjzyl7HZmxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 07/20] mm/pgtable: define
 (pgd|p4d|pud)_offset_lockless() for folded page tables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yeoreum Yun" <yeoreum.yun@arm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260722-dummy_ptxp3-v2-7-d9e4bad31e0a@arm.com>
References: <20260722-dummy_ptxp3-v2-0-d9e4bad31e0a@arm.com>
 <20260722-dummy_ptxp3-v2-7-d9e4bad31e0a@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 15:58:49 +0000
Message-Id: <20260722155849.85FF41F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Use-After-Free in GUP-fast on dynamically folded architectures=
 (RISC-V SV39) due to flawed generic lockless page table offset macros.
--

--- Patch [7]: [PATCH RFC v2 07/20] mm/pgtable: define (pgd|p4d|pud)_offset=
_lockless() for folded page tables ---
commit 235a6b06e94a41ff4c56118e36e869516151cea9
Author: David Hildenbrand (Arm) <david@kernel.org>

mm/pgtable: define (pgd|p4d|pud)_offset_lockless() for folded page tables

The patch provides p4d_offset_lockless(), pmd_offset_lockless(), and
pud_offset_lockless() for static folded page tables to ignore the passed
value and return the pointer. This avoids returning a pointer to the stack
value like the default handlers do.

> diff --git a/include/asm-generic/pgtable-nopud.h b/include/asm-generic/pg=
table-nopud.h
> index 6c9bca78047c4..5a2b0a81ae197 100644
> --- a/include/asm-generic/pgtable-nopud.h
> +++ b/include/asm-generic/pgtable-nopud.h
[ ... ]
> @@ -47,6 +47,13 @@ static inline pud_t *pud_offset(p4d_t *p4d, unsigned l=
ong address)
>  }
>  #define pud_offset pud_offset
> =20
> +static inline pud_t *pud_offset_lockless(p4d_t *p4dp, p4d_t p4d,
> +		unsigned long address)
> +{
> +	return (pud_t *)p4dp;
> +}
> +#define pud_offset_lockless pud_offset_lockless

[Severity: Critical]
This is a pre-existing issue, but does this fix leave dynamically folded
architectures like RISC-V SV39 vulnerable to a use-after-free?

The generic fallback macro in include/linux/pgtable.h still passes the addr=
ess
of a local stack variable:

#define pud_offset_lockless(p4dp, p4d, address) pud_offset(&(p4d), address)

On RISC-V SV39, PUD is folded dynamically in arch/riscv/mm/pgtable.c:

pud_t *pud_offset(p4d_t *p4d, unsigned long address)
{
	if (pgtable_l4_enabled)
		return p4d_pgtable(p4dp_get(p4d)) + pud_index(address);

	return (pud_t *)p4d;
}

Since pgtable_l4_enabled is false on SV39, pud_offset() returns the pointer=
 it
was passed, which is the stack pointer from the generic pud_offset_lockless=
()
macro.

When gup_fast_pud_leaf() in mm/gup.c executes its concurrent modification
check, it reads the stale stack variable instead of the actual page table:

	if (unlikely(pud_val(orig) !=3D pud_val(pudp_get(pudp)))) {
		gup_put_folio(folio, refs, flags);
		return 0;
	}

Because it reads the isolated stack variable, the check trivially passes,
allowing GUP-fast to pin and return a concurrently freed 1GB huge page.

Could a similar lockless override be applied for dynamically folded
architectures to prevent this?

> +
>  #define pud_val(x)				(p4d_val((x).p4d))
>  #define __pud(x)				((pud_t) { __p4d(x) })

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722-dummy_ptxp=
3-v2-0-d9e4bad31e0a@arm.com?part=3D7
