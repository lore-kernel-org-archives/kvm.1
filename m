Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7292A3264DD
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 02:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788400984; cv=none; b=IfxIEB2sUPNSShf6MvHfw+qlY/Djob8roN2Gfsm5NpQZ+XKWSoBSMZKuK7bbfdSRF/F/pM7eHYyAdEke+A7nGRVpiRqEzVbyiQRs/q6t26ibNGi1O+KBl2LyGzpu7kbqr6GZEIcEHEpl0pyoVe8bRqdoOHe4/epK8P3E1rBO1OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788400984; c=relaxed/simple;
	bh=PPUTIUZ7oZL0mZCuCZfnSRgvAH3KC58GhLslS29Jtos=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O6tf3GY0s5ghBLA2YXxYwh6J7o9rY9HmWPIj3S/8CeALYiOtZv8ln43i1mjLI15FOgSTJdfM0iMUatdPGF2borwABOWoKpNqUPo4R7Aie2VPsodrpCRn8X9Si9EEeSKXca/ilOdaOIo58oCKHB4ZzQny6U45qCUq0FrO2wChzMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xwu66LA3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xwu66LA3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349961F000E9;
	Thu,  3 Sep 2026 02:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788400983;
	bh=J6snrl9u83N12Qvm94hm8a+c5KZ56l/B5YKtQdb2gKA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xwu66LA3p2EkAC3RUGDYX10gpVyeVYv4BKUSYCNFXzUVmPNKNz986kASUi/Tke87u
	 Zs/xA+YJgwL1c3sio3xiAAdO0lEjB+ZTyeMSnHxfUtmDwXuGkPCSNQnRr9e09oPE8u
	 /0EjRqlXTB31OwGlCcVrp+KlY7bHzMvk+jXeHw5DsTyCFB/tpMz4wV5I1quG0pAJgX
	 pi6HpGv9mVItbCbkDThgrWU1AdPy9h96zsJ7XoCe+Qs+CWyePJUcoFeDVyp9fQw1Ih
	 mJsum62MgmTuU8+NvkVk8AGI7NRHVcKe3zfP5kvprzzZ5K8M1cEww3xQpyDlOVyZK5
	 re3hnHuz0Y/iw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 05/11] x86/virt/tdx: Handle multiple callers in
 tdx_pamt_get/put()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rick Edgecombe" <rick.p.edgecombe@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260903015113.93343-6-rick.p.edgecombe@intel.com>
References: <20260903015113.93343-1-rick.p.edgecombe@intel.com>
 <20260903015113.93343-6-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 02:03:02 +0000
Message-Id: <20260903020303.349961F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] tdx_find_dpamt_refcount() uses an unchecked PFN to index the dpamt=
_refcounts array, leading to out-of-bounds memory access.
--

commit 413476a1747fac53ffdaf87030c42cb8b25bc668
Author: Rick Edgecombe <rick.p.edgecombe@intel.com>

x86/virt/tdx: Handle multiple callers in tdx_pamt_get/put()

This patch refcounts the dynamic PAMT additions for 2MB regions so multiple
callers can safely share them. It also drops the "__" prefix from the
helpers and exports them for use by KVM.

> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index e8bdeacd989d6..a126e395f5f6a 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -292,7 +292,7 @@ static __init void free_dpamt_refcounts(void)
>  	dpamt_refcounts =3D NULL;
>  }
> =20
> -static __maybe_unused atomic_t *tdx_find_dpamt_refcount(unsigned long pf=
n)
> +static atomic_t *tdx_find_dpamt_refcount(unsigned long pfn)
>  {
>  	/* Find which PMD a PFN is in. */
>  	unsigned long index =3D pfn >> (PMD_SHIFT - PAGE_SHIFT);
>=20
>  	return &dpamt_refcounts[index];

[Severity: High]
Does this index calculation need bounds checking?

If memory is hotplugged after boot, increasing the global max_pfn, and KVM
allocates private guest memory that lands in this hotplugged region (e.g.,
via guest_memfd), the returned PFN could be greater than the boot-time
max_pfn used to size the dpamt_refcounts array. This would lead to an
out-of-bounds pointer being returned here.

[ ... ]

> @@ -2150,41 +2144,59 @@ static int __tdx_pamt_get(kvm_pfn_t pfn)
[ ... ]
>  out_free:
> +	spin_unlock(&dpamt_lock);
>  	free_pamt_array(pamt_pages);
> =20
>  	return ret;
>  }
> +EXPORT_SYMBOL_FOR_KVM(tdx_pamt_get);

[Severity: High]
Is it safe to export this function without adding bounds checking to
tdx_find_dpamt_refcount()?

Exporting this helper allows external callers like KVM to pass in arbitrary
or hotplugged PFNs. If a hotplugged PFN is passed, the resulting
out-of-bounds pointer from tdx_find_dpamt_refcount() will be modified by
atomic_inc_not_zero() and atomic_set() within this function, potentially
causing memory corruption or a host kernel panic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903015113.9334=
3-1-rick.p.edgecombe@intel.com?part=3D5
