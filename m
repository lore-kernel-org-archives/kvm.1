Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA27841A4F3
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 15:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784735783; cv=none; b=sPDKbfAWAVo1cethXqBx9tsXTKtJ0p9vckishPSLJ5QGAzqH8V8A/OntGGy8kdNza4dXlzo9S+jRCnYT9l2vrN8QVXQS2lEpN+44hggmf+TSClCk1nHxfExk7JcvdCBrwtZl+lP0biWfPchzPFCMZvSdOm600jf6N2dHGYCNkg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784735783; c=relaxed/simple;
	bh=Wj4USkUfIe1CZ9ZEG0b09aSNsMBekufMrYEELLIiS0w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cE7rfl7+8KYTAHYP7ihkNUGewfd1yVYWMcAMHHZ5H/hJUBBIw7Dkj7yzNlbXIZ80xNEIsqmqC0cVhmb0q92wQQ1/djUjUx7OLTjg/KUJIf/clepI6YMFgMRpsb9PzsOTD/sdlZ+tihDeHs98AWAeFPOR3LicqqXRTYgQrEEVsZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLRQucAn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLRQucAn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D071F00A3A;
	Wed, 22 Jul 2026 15:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784735779;
	bh=CwPy9YJyT5uHmM+0cHZiIrL8nDDs8+BHrVP78xCRBzQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MLRQucAnZZ0d2OrCzQKGYwG0352EKjBYWH522JOSLrbArw38Kzkd9FHp1zHgfeWtk
	 rdWM4vtfFhMRAKkXKJB9Drj+sLzaKskVEfAEVO4MfohVudKZ3g09pKvY3Kmh8RtQIk
	 gSbtVu2J596OX8tTfNLseDxwNV/wMFHMWi6nNxM7Uma1/mVg/190s/WvXucK5b/taU
	 f4KAaeo+32dVZJlqq5GaGGyT/tPRmW5K03y4O4oVuB1AYnmGbYP5+7sdGlT69OMCUJ
	 xHgH3J4XwalPgLGTsL3iADFriqAEAX7J25ouUysTBXbeyPk1gCs5NNaGvOD30UJfH7
	 dUgOXDxSipoCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 08/20] mm: vmscan: remove stack copy address of
 pud pass in wallk_pud_range()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yeoreum Yun" <yeoreum.yun@arm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260722-dummy_ptxp3-v2-8-d9e4bad31e0a@arm.com>
References: <20260722-dummy_ptxp3-v2-0-d9e4bad31e0a@arm.com>
 <20260722-dummy_ptxp3-v2-8-d9e4bad31e0a@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 15:56:18 +0000
Message-Id: <20260722155619.51D071F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `pmd_same` concurrency check in `walk_pte_range` is bypassed b=
ecause it receives a pointer to a stack variable (`&val`) instead of the ac=
tual PMD entry.
--

--- Patch [8]: [PATCH RFC v2 08/20] mm: vmscan: remove stack copy address o=
f pud pass in wallk_pud_range() ---
commit 509a7a22f2cecb4a110a42ba30c39b2954f718fe
Author: Yeoreum Yun <yeoreum.yun@arm.com>

mm: vmscan: remove stack copy address of pud pass in wallk_pud_range()

This commit replaces passing the address of a stack copy of a pXd to
walk_pmd_range() with passing the pud pointer directly. This change prepares
the codebase for generic compile-time folded page tables.

> diff --git a/mm/vmscan.c b/mm/vmscan.c
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3727,7 +3727,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned long=
 start, unsigned long end,
>  		if (!pud_present(val) || WARN_ON_ONCE(pud_leaf(val)))
>  			continue;
> =20
> -		walk_pmd_range(&val, addr, next, args);
> +		walk_pmd_range(pud + i, addr, next, args);

[Severity: High]
This is a pre-existing issue, but should walk_pmd_range() in mm/vmscan.c
also be updated to avoid passing a stack copy to walk_pte_range()?

In walk_pmd_range(), a stack copy of the PMD entry is created and its
address is passed to walk_pte_range():

    if (!walk_pte_range(&val, addr, next, args))

Inside walk_pte_range(), this pointer is used for a concurrency check:

    if (unlikely(!pmd_same(pmdval, pmdp_get_lockless(pmd)))) {

Because pmd points to the unchanging stack variable, pmdp_get_lockless(pmd)
reads the frozen value, causing the pmd_same() check to always succeed.

Could this bypass allow the MGLRU walker to iterate over a detached or freed
PTE page table if a concurrent operation like MADV_DONTNEED clears the PMD,
potentially resulting in use-after-free or data corruption when
walk_update_folio() modifies flags on reallocated folios?

> =20
>  		if (need_resched() || walk->batched >=3D MAX_LRU_BATCH) {
>  			end =3D (addr | ~PUD_MASK) + 1;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722-dummy_ptxp=
3-v2-0-d9e4bad31e0a@arm.com?part=3D8
