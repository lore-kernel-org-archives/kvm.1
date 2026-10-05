Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8918B305674
	for <kvm@vger.kernel.org>; Mon,  5 Oct 2026 17:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791223014; cv=none; b=lRdSMJBjiseMmWjBH/bewElvMJ8iACusThkTO6ipt9eKaA+mhpJSAMmSpNAvTwVShmTbAmwNbbliO6arsoaCafL24qxQKDOUN5Bc14MOriv5xTQGtE88TB85S/26GSH1ckizpTMn234Y+eh4AFLVO/726m7OZhwDH1YrI/pBVp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791223014; c=relaxed/simple;
	bh=Uu2FhubGU+buF6ggP9pzjvGskP9h06Uf3M/64xzZwS0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hGUfRTgXSH3VoVID9azs2ynA1DYvpDH//OsmmmAqEzDiPDwW1oIq9u63G2lOnn7Rmn4S0M8U6nBMfP21n5sQW/Md7gT52G0T4jbHRAtbtaZIoAzJMEulukLCNhjui4yeCW4YvsfXCi+rrtBn4m1rfSMHR5dqOTPRX5mFPeY36kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMDs3nOq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMDs3nOq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C341F000FF;
	Mon,  5 Oct 2026 17:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791223013;
	bh=TRq61kayFmw+XesnJ/L33jNFEPs83KOJgu5ee1b0Vpk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EMDs3nOqfgrgxVc/ipnf1JZl0fdQ1CyRyanq+TpmKY4n8VOL9Tlp0gr6+PiN25BMw
	 1EPbQASerWFyzvDfHIK9mVTKDPLY5e6r3lJg0YpUBnJvHkOfGoupRp6MBt6/T9QpOI
	 h2ECiKKXghFvL0J2aHyLuAbkFBEDSwyRoa1dhd8ZkFxwRR9GSa6RIRzTUhN2NAdEae
	 dXQmjoHKOnc7Q627G0ADDIAWwi9rECATfaTu5HDAnPeKBpVDFNvwTul+ve1A7UfP05
	 +y50ZpzE9lac/0sW9RBmCHSclYSRH/ZjPbVcGAg2om81tepp1RmoDD5mQInWVxSASA
	 XnASvmeRSGVtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/6] x86/virt/tdx: Add extra memory to TDX module for
 the extensions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Yilun" <yilun.xu@linux.intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261006-tdx-module-ext-v3-3-db52cb05b918@linux.intel.com>
References: <20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com>
 <20261006-tdx-module-ext-v3-3-db52cb05b918@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 17:56:52 +0000
Message-Id: <20261005175653.03C341F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] x86/virt/tdx: kzalloc() breaks page alignment for hardware-facing =
struct under debug
--

commit b27e647d007dabaa3a6b0eda05701af51bffc99e
Author: Xu Yilun <yilun.xu@linux.intel.com>

x86/virt/tdx: Add extra memory to TDX module for the extensions

This commit introduces a new SEAMCALL leaf TDH.EXT.MEM.ADD to allocate and
add execution environment memory to the TDX module for extensions. It alloc=
ates
a page-sized structure tdx_hpa_list to pass the physical addresses of the
allocated memory to the hardware.

> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index f08278a47affc..c445359335516 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c

[ ... ]

> +static __init u64 to_hpa_list_info(struct tdx_hpa_list *hpa_list,
> +				   unsigned int nr_pages)
> +{
> +	return FIELD_PREP(HPA_LIST_INFO_FIRST_ENTRY, 0) |
> +	       FIELD_PREP(HPA_LIST_INFO_PFN, PFN_DOWN(__pa(hpa_list))) |

[Severity: High]
If the hpa_list pointer is unaligned due to slab redzones, does this
PFN_DOWN() truncation cause the TDX module to read the redzone metadata
instead of the actual array?

> +	       FIELD_PREP(HPA_LIST_INFO_LAST_ENTRY, nr_pages - 1);
> +}

[ ... ]

> +static __init int tdx_ext_mem_setup(void)
> +{
> +	unsigned int required_pages, added_pages;
> +	struct tdx_sys_info_ext sysinfo_ext;
> +	struct tdx_hpa_list *hpa_list;
> +	struct page *page;
> +	int ret;

[ ... ]

> +	/*
> +	 * Allocate the container page for the HPA_LIST. tdx_hpa_list is
> +	 * guaranteed to be page-sized by static_assert(), so kzalloc()
> +	 * guarantees the page alignment.
> +	 */
> +	hpa_list =3D kzalloc_obj(*hpa_list);

[Severity: High]
Does kzalloc_obj() actually guarantee page alignment when CONFIG_KASAN or
CONFIG_SLUB_DEBUG are enabled?

Since slab redzones offset the object within the page, a PAGE_SIZE allocati=
on
through the slab allocator might not return a page-aligned address under
these debug configurations.

Would it be safer to use the page allocator (e.g. alloc_page() or
get_zeroed_page()) instead of the slab allocator for a structure that requi=
res
strict page alignment when passed to hardware?

> +	if (!hpa_list)
> +		return -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006-tdx-module=
-ext-v3-0-db52cb05b918@linux.intel.com?part=3D3
