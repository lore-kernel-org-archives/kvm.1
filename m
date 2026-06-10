Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD9129D291
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 16:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781108784; cv=none; b=AnkI4Zv5daEvFS4SMTw0EMCr2XMSZSWCOnDCQc3uv4zPdyeG+2yQKjEDx9/danoSHHUu8o9S/2aMeplFikDUkvqQvl2YibP+fNzGmh++PvLdySg/cvYyYgcq3OLEoTg9Z/jvy9+zvPX4YJDbUyQAWtpAVvZKObM60EajjkiBXy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781108784; c=relaxed/simple;
	bh=+GQ3/eCDhBl+eqISMmMv83MWxZXiMSzrWVVHRU8fBC8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hrjRcey2UMW3hTkdZLTwdtCTFE4FHHdmjx+eJIvdVK/uiiJX9cVFha8k8VG3sbb6iJXgZ5MRYUk83nxTcUhOBNVzCKkUtTxB8/M8v2l6Y3qkI5YFVXdr20FKafsrtw5fV9a7ugeBCLot6NkzjfsB8O8f2bkYnFPCkQN+CEvIT5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJaIPZ9x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJaIPZ9x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061BA1F00898;
	Wed, 10 Jun 2026 16:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781108783;
	bh=zSlNFbSCdKzcSNO9IhQMi5ZM3WZ7nDYdpNhBa4jIcyU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AJaIPZ9xKm10uR3ROe9zdf2O2ZgpItk+gKhAxcemogiJ/aaoGyCW7/XQmY1voxytR
	 Rapxh3/53gIU28h7ygdzdn1jwpwo63IMZElaEg+Vq11StQNCHEOD35V1dtZyX5ZxBM
	 eUvKvCE1lTYFY84WwfULQNojJjQCpHmPFJBU7GdqxgKB0fqa0syudM2z6kCzNWkZmI
	 yOxR2g/NBBvJsM4tCaiyvsGhMDboQ/BEQrH57vmR5WrEi6xOntTKPVuQIEFZZzKc0H
	 KPIbK1y0A9FsedYpuwRChDDvgIUqhdAAktZ+Wi/2nW+FI3GvuKFq8ohhx+eXaHIqxp
	 BNdjd7l2NmHkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: SEV: Don't return a still-assigned gmem page to
 the host
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hyunwoo Kim" <imv4bel@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <aimMWzAf5b3luM0b@v4bel>
References: <aimMWzAf5b3luM0b@v4bel>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 16:26:22 +0000
Message-Id: <20260610162623.061BA1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Calling snp_leak_pages() on a pinned guest_memfd folio corrupt=
s the system-wide LRU list by overwriting the folio's LRU pointers.
- [High] Unconditional PAGE_SIZE-stepping PFN iteration on large folios res=
ults in duplicate folio_get() increments on the same folio and failure to t=
rack leaked pages.
--

commit 5d574de6d0d362139fa648b3657e2f24c06fd5ee
Author: Hyunwoo Kim <imv4bel@gmail.com>

KVM: SEV: Don't return a still-assigned gmem page to the host

This commit addresses an issue where guest_memfd frees a page that is
still assigned to the guest. To prevent returning it to the host, the
page is pinned and leaked.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index f59c65abe3cfa..dbde6dce79b76 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
[ ... ]
> @@ -5036,8 +5036,12 @@ void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_=
t end)
> =20
>  		rc =3D rmp_make_shared(pfn, use_2m_update ? PG_LEVEL_2M : PG_LEVEL_4K);
>  		if (WARN_ONCE(rc, "SEV: Failed to update RMP entry for PFN 0x%llx erro=
r %d\n",
> -			      pfn, rc))
> +			      pfn, rc)) {
> +			/* Still assigned to the guest; pin and leak rather than freeing. */
> +			folio_get(page_folio(pfn_to_page(pfn)));
> +			snp_leak_pages(pfn, use_2m_update ? PTRS_PER_PMD : 1);

[Severity: Critical]
Does calling snp_leak_pages() on a pinned guest_memfd folio corrupt the
system-wide LRU list?

Memory allocated by guest_memfd is added to the page cache, which
unconditionally places the memory on the global unevictable LRU list. When
guest_memfd memory is freed, the folio has been removed from the page cache
but is still actively linked in the global LRU list until its reference
count drops to zero.

By calling folio_get() here, the reference count is elevated, keeping the
folio on the LRU list. Then, snp_leak_pages() unconditionally links the
page into a tracking list via list_add_tail(&page->buddy_list, ...).

Because buddy_list and lru share the exact same union inside struct page
and struct folio, modifying buddy_list silently overwrites the lru.next and
lru.prev pointers of the folio, severing the global LRU linked list.

[Severity: High]
Does this code also double-account references and fail to track the leaked
pages when processing large folios?

When guest_memfd allocates a large 2MB PMD-size folio, but the RMP table
has it mapped as 4K entries, use_2m_update will be false and the loop
unconditionally steps by 1 PFN.

Because page_folio(pfn_to_page(pfn)) returns the head folio for any subpage,
folio_get() will be redundantly called up to 512 times on the exact same
head folio.

Furthermore, passing use_2m_update ? PTRS_PER_PMD : 1 (which is 1) to
snp_leak_pages() results in the internal check compound_nr(page) <=3D npages
evaluating to 512 <=3D 1 (false). This causes the entire compound page to be
completely skipped and omitted from the snp_leaked_pages_list.

>  			goto next_pfn;
> +		}
> =20
>  		/*
>  		 * SEV-ES avoids host/guest cache coherency issues through

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/aimMWzAf5b3luM0b@v4=
bel?part=3D1
