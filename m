Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE5A169AD2
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 15:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784215848; cv=none; b=qJNi67/liMWPjr0z2a0dYnqTKaO17947VmCE5JANDYMbdlGt1xDUsPzPP+ubagunkGVRiCUspHA+fKDEN2VEBo1VRYmVv/p87FsoSerSw3lTjacu2sPQ0gDc17Q6COqJVN9SuO0+H2rXmipYF+qD+sfsMJr2Vm+vTNhkmQBuZgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784215848; c=relaxed/simple;
	bh=AhUppXtDzvX2thtma7035Wo9020VFmDwIc2Nd25KKvc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=obQKuPBHtbmB7AUKuYNm7oj6xY4o2pPzc/PiSPPMaCcdgJc4hzrsTm0WDG5yW1BGRXx9YsCWB5Xm2G54OswYqZqkz8KJ9Pn0LcYKqSIJg/Kb5A8H5Oe4gQyDNtHoJOrpJBahvleuQLLtKTl5MNsrCTTGqmKzQR1OgDdriZWeLAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRlUq5kf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRlUq5kf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E18A1F000E9;
	Thu, 16 Jul 2026 15:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784215847;
	bh=07yxhp+5bCkeFdeS+IkRav3z9De+wdEAuknhGs42foE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iRlUq5kf8Vyre9ur5ZGC/z7NQKrxwoBHMgQtpjKNpprnDn5RQ7I0KIxmY1gBgoowO
	 Gl+4NG7NiQbk8LIsIS42JACajkO9JLviXHEimVdXMWKDFOZy3nyhbswIeQ1KIrW70f
	 OTlJfOAk1SmLl/u3aeG1Kxy4DNYVDs2WBkao7s9wnNB62njr+g42fXBn9myTJcQkMA
	 69KJAdkuQ0GSrAInKCAkl0DfoAOiso0e51y/L7uztUAsKP+ld4mjp94BO9Fg5FZ6PD
	 hvfmsTYmjx1KgsQ28TECqfoebuIl5Df6f3/pQ1vnKMWol96jSZytxNGgzED4x8zPwv
	 rkVwOhunCoZtg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 03/11] KVM: SEV: Remove struct page dependency from
 SNP gmem paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: media-ci@linuxtv.org, kvm@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <f069aec751d2c7f18666efbe213bb0a70dc76b67.1784194290.git.dwmw@amazon.co.uk>
References: <f09647f427565c1789a6979470045aab78661563.1784194290.git.dwmw@amazon.co.uk>
 <f069aec751d2c7f18666efbe213bb0a70dc76b67.1784194290.git.dwmw@amazon.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 15:30:46 +0000
Message-Id: <20260716153047.0E18A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] An unprivileged userspace process can trigger a host kernel warnin=
g in sev_clflush_pfn(), violating KVM subsystem rules.
--

--- Patch [3]: [RFC PATCH 03/11] KVM: SEV: Remove struct page dependency fr=
om SNP gmem paths ---
commit 23550409886d9ce92ccb0c443cb1bc2d231b31b3
Author: Connor Williamson <connordw@amazon.com>

KVM: SEV: Remove struct page dependency from SNP gmem paths

This commit updates KVM SEV-SNP paths to support memory without a struct pa=
ge
by falling back to memremap() instead of relying on kmap_local_page(). It
relaxes RMP helpers and updates cache flush paths to handle page-less PFNs.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 4272293478766..2be9e3b80d85e 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c

[ ... ]

> @@ -5117,6 +5155,28 @@ int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pf=
n, gfn_t gfn, int max_order)
>  	return 0;
>  }
> =20
> +/*
> + * Flush the CPU caches for a guest_memfd PFN.  A PFN from an external
> + * guest_memfd provider may have no direct map alias, so fall back to a
> + * temporary memremap() mapping for the cache flush.
> + */
> +static void sev_clflush_pfn(kvm_pfn_t pfn, size_t size)
> +{
> +	void *va;
> +
> +	if (pfn_valid(pfn)) {
> +		clflush_cache_range(__va(pfn_to_hpa(pfn)), size);
> +		return;
> +	}
> +
> +	va =3D memremap(pfn_to_hpa(pfn), size, MEMREMAP_WB);
> +	if (WARN_ON_ONCE(!va))

[Severity: High]
Is it safe to use WARN_ON_ONCE(!va) here when memremap() fails?

Since userspace can trigger sev_clflush_pfn() during guest_memfd hole-punch=
ing
(via sev_gmem_invalidate()), an unprivileged process might be able to trigg=
er
this warning by inducing memory pressure or vmalloc space exhaustion.

This could result in a host denial of service if panic_on_warn is set.

Should we drop the assertion here to prevent unprivileged userspace from
intentionally triggering host warnings?

> +		return;
> +
> +	clflush_cache_range(va, size);
> +	memunmap(va);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/f09647f427565c1789a=
6979470045aab78661563.1784194290.git.dwmw@amazon.co.uk?part=3D3
