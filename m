Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA5A35972
	for <kvm@vger.kernel.org>; Sat, 18 Jul 2026 02:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784340055; cv=none; b=uUTwrGqGojr9ZjHcE4DoBqXosN8YoiYT1Mfsa0BXBWofM6OcZu4HAA1dzJuhRNENs+hR/6hoBwYsRQtxacIHGX3Yk++kaTrfd3bOI/PfkGfLRwzwxV9Bm39i5p9iWN29OG+oh5kEpHjocCh/FP6DV9tu+cCzJNkIHZ8QuYp5OS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784340055; c=relaxed/simple;
	bh=usoOrLfo8Lm+pKNSJS+Kh/yAxhFzAe7sRNoKE5ZDzms=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R57UmHyLQ1x6S0LC3/XszB0loVjPCzPw9PrnqsBcdV9ovesV8qFjnzhf920OfSlsszgq0k9bkjfGOaWcVoRJNRceiOSFi3LFyiKwY1KwLFd+Ot0tbEi/yocKJKYufQVZj2xXRIvtfFgzhNnkyNmvDAGmdjcfIb6NR2s6vhY4LJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/mKJ35f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/mKJ35f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2FC81F000E9;
	Sat, 18 Jul 2026 02:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784340054;
	bh=cLEzsNvA613u3/sX59w520TteTd6hOiHE91c6tmRRFc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K/mKJ35f8wwqLIZkqzpwFxSWLikOqh9bfSv5bLH/9HuT/2LaQbaIieDSU7SxIamTZ
	 PyYLNoiBg071yG+kz2I+io1ZDjJwxe3tAZk4WpUvkmAkmhvwaaWmCpLtBGvc549X5U
	 RKH0JMoqb/d3lTaXvBc2VY+Xz9umUvg8Q7dfNIze8vtycAMHtZPnBf5r2PBpiH0bEE
	 B6hyM2sZy5X9tdkoil5CmlSs5q0IlMxUyPCwLjzetlBHLUJZer8OOG339wY/kuJJ7J
	 BwV+eSsf5EPPVmrBAzDjf8T7nSs8XvJsga0zkVrrbE5GSXDltm2wu/FXRzjB0ry74H
	 422VsjkvTTx1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 11/11] x86/virt/tdx: Optimize tdx_pamt_get/put()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rick Edgecombe" <rick.p.edgecombe@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260718014500.2231262-12-rick.p.edgecombe@intel.com>
References: <20260718014500.2231262-1-rick.p.edgecombe@intel.com>
 <20260718014500.2231262-12-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 02:00:53 +0000
Message-Id: <20260718020053.C2FC81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Using `atomic_dec_and_lock` in `tdx_pamt_put` lacks underflow pr=
otection, causing an unbalanced put (refcount 0) to silently underflow the =
refcount to -1, which breaks future `tdx_pamt_get` calls for that PFN.
--

--- Patch [11]: [PATCH v7 11/11] x86/virt/tdx: Optimize tdx_pamt_get/put() =
---
commit f3bde8ccf9659f8b1e1cedb9b81df0b3b209a9fa
Author: Kiryl Shutsemau <kas@kernel.org>

x86/virt/tdx: Optimize tdx_pamt_get/put()

The Dynamic PAMT get/put helpers use a global spinlock to serialize all
refcount updates and SEAMCALL invocations. This gives correct behavior for
concurrent callers, but leads to contention.

> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index 69834b0d3e602..4394bba7c9a7c 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c

[ ... ]

> @@ -2214,17 +2227,13 @@ void tdx_pamt_put(kvm_pfn_t pfn)
> =20
>  	pamt_refcount =3D tdx_find_pamt_refcount(pfn);
> =20
> -	spin_lock(&pamt_lock);
>  	/*
>  	 * If there is more than 1 reference on the pamt page, don't
>  	 * remove it yet. Just decrement the refcount.
>  	 */
> -	if (atomic_read(pamt_refcount) > 1) {
> -		atomic_dec(pamt_refcount);
> -		goto out_unlock;
> -	}
> +	if (!atomic_dec_and_lock(pamt_refcount, &pamt_lock))
> +		return;

[Severity: Medium]
If an unbalanced put occurs on an un-added PAMT page (where the refcount
is 0), does atomic_dec_and_lock() lack underflow protection and silently
drop the refcount to -1 instead of proceeding to the SEAMCALL failure
warning as the previous logic did?

lib/dec_and_lock.c:atomic_dec_and_lock() {
    /* Subtract 1 from counter unless that drops it to 0 (ie. it was 1) */
    if (atomic_add_unless(atomic, -1, 1))
        return 0;
    ...
}

If the refcount silently becomes -1, would a subsequent call to
tdx_pamt_get() for this PFN incorrectly succeed without adding the PAMT
memory?

arch/x86/virt/vmx/tdx/tdx.c:tdx_pamt_get() {
    ...
    if (atomic_inc_not_zero(pamt_refcount))
        return 0;
    ...
}

Since -1 is not zero, atomic_inc_not_zero() would increment the refcount
to 0 and return true, bypassing the tdh_phymem_pamt_add() SEAMCALL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718014500.2231=
262-1-rick.p.edgecombe@intel.com?part=3D11
