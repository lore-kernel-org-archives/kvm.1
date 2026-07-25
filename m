Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECF023AE62
	for <kvm@vger.kernel.org>; Sat, 25 Jul 2026 00:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784939726; cv=none; b=JOWG8bRtxTnOoiDrWdkCfyzfN0iAuZWKLV7Qml60FIv/aPsF7uFVW8w0qwPem5RVfGdBqLtAzgWKhft9g7/9nrOwsbnNM4VlbeOY3bmcQFL9BZ6fSA87UVAgd9VqZhLXEtH1Mw7Ytf6kSEZHxKOnda2UPKxl4RAX4M+P5+ty6yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784939726; c=relaxed/simple;
	bh=pl4nw30+YLe817A0jeg0uBIG+NmB5/hCOFHbj0FwjGo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hlvyUSh8HZJ+dz6H8YH6fqqZpIBEhFVE0oS2q6foKJqcSscisNQnP5iApgbhsfyQo5vD7jOaeCY31tElKaGmChKtsa6Iss+wnIqtvlxFSaWXn6DktFTaz6wJslhDtlgS3A4PBvIL2hXLkN3CSLXHx8FnQJ3o18UMWzCO7fY5tvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZA8Iaql; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZA8Iaql"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91EFF1F000E9;
	Sat, 25 Jul 2026 00:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784939724;
	bh=gMfWSHB693nhsnz3AUr/zIbkz3FBDU65oiFD+Fd4sjE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oZA8IaqlqGO5Nbd3di7pOpxkpIC9RMgWbVACotzkA5rdVPs0fXVn+OTsSmXWbzQBz
	 vfeKS55NiQT7THEcmAwIn2A/f8XiGyPCk5o4/zbwFbid3NjpIFlIN2CuJw9LeEs07X
	 o4PYBgNn4JMqQa6z8dkdpmKlz8KP3YPDJGzw0T20Q0ebLcGjF6j71OxHj6Q1vnTnBa
	 tbIP5YSVfHqliCA13W4NJ8ypWe4sc3k67kuRNS17JYW/rNnad4uIGNCT5x81wZRS7a
	 SbLjNQS8cN9UgTLrUFXTV1WPNagSVeawi91DZGRFvMSavGvqdthA+p6/lBTKFaOe4n
	 KIJ/VufS9PmaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 03/11] x86/virt/tdx: Add
 tdx_alloc/free_control_page() helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rick Edgecombe" <rick.p.edgecombe@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260725002302.3337017-4-rick.p.edgecombe@intel.com>
References: <20260725002302.3337017-1-rick.p.edgecombe@intel.com>
 <20260725002302.3337017-4-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 00:35:24 +0000
Message-Id: <20260725003524.91EFF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing PAMT refcounting per 2MB region causes sequential control =
page allocations to fail, breaking TDX VM creation.
--

--- Patch [3]: [PATCH v8 03/11] x86/virt/tdx: Add tdx_alloc/free_control_pa=
ge() helpers ---
commit faccfee65087eb8fde3e33bcf0d4f16f5bd1d870
Author: Kiryl Shutsemau <kas@kernel.org>
Subject: x86/virt/tdx: Add tdx_alloc/free_control_page() helpers

Adds helpers to allocate and free control/S-EPT pages handed to the TDX
module, and handles Dynamic PAMT adjustments for these 4KB pages.

> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c

[ ... ]

> +/* Allocate PAMT memory for the given page */
> +static int tdx_pamt_get(kvm_pfn_t pfn)
> +{
> +	struct page *pamt_pages[TDX_DPAMT_ENTRY_PAGE_CNT];
> +	u64 tdx_status;
> +	int ret;
> +
> +	if (!tdx_supports_dynamic_pamt(&tdx_sysinfo))
> +		return 0;
> +
> +	ret =3D alloc_pamt_array(pamt_pages);
> +	if (ret)
> +		return ret;
> +
> +	tdx_status =3D tdh_phymem_pamt_add(pfn, pamt_pages);
> +	if (tdx_status !=3D TDX_SUCCESS) {
> +		ret =3D -EIO;
> +		goto out_free;
> +	}

[Severity: High]
Will sequential allocations in the same 2MB region fail here?

When allocating multiple control pages sequentially, the buddy allocator
often returns pages in the same 2MB physical region. Since the TDX module
tracks Dynamic PAMT at a 2MB granularity, the first allocation will
successfully add the PAMT, but the second allocation will attempt to add
it again in tdx_pamt_get() in arch/x86/virt/vmx/tdx/tdx.c.

Because there is no refcounting to check if the 2MB region already has
PAMT added, tdh_phymem_pamt_add() will return an error on the second page,
causing the control page allocation to fail and breaking TDX VM creation.

The commit message mentions leaving concurrency issues for future
changes, but could this break even single-threaded sequential allocations?

> +
> +	return 0;
> +
> +out_free:
> +	free_pamt_array(pamt_pages);
> +
> +	return ret;
> +}
> +
> +/* Free PAMT memory for the given page */
> +static void tdx_pamt_put(kvm_pfn_t pfn)
> +{
> +	struct page *pamt_pages[TDX_DPAMT_ENTRY_PAGE_CNT] =3D {};
> +	u64 tdx_status;
> +
> +	if (!tdx_supports_dynamic_pamt(&tdx_sysinfo))
> +		return;
> +
> +	tdx_status =3D tdh_phymem_pamt_remove(pfn, pamt_pages);
> +
> +	/*
> +	 * Don't free pamt_pages as it could hold garbage when
> +	 * tdh_phymem_pamt_remove() fails.  Don't panic/BUG_ON(), as
> +	 * there is no risk of data corruption, but do yell loudly as
> +	 * failure indicates a kernel bug, memory is being leaked, and
> +	 * the dangling PAMT entry may cause future operations to fail.
> +	 */
> +	if (WARN_ON_ONCE(tdx_status !=3D TDX_SUCCESS))
> +		return;

[Severity: High]
Is it safe to unconditionally remove the PAMT for a 2MB region in
tdx_pamt_put()?

Similar to the allocation side, if multiple 4KB pages from the same
2MB region are in use by the TDX module, freeing just one of them will
call tdh_phymem_pamt_remove() unconditionally.

This removes the PAMT for the entire 2MB region while other pages might
still be relying on it.

> +
> +	free_pamt_array(pamt_pages);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725002302.3337=
017-1-rick.p.edgecombe@intel.com?part=3D3
