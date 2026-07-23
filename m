Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0ED184
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 00:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784766348; cv=none; b=XTFI5kzyCnmGfK90vUTXrw/IipQ7ezXVDZvXEWJ2E78xep93/s9Qw8ed3+isWjpUSgk6OhB/7KvKARqL5IX3trX0iEYuUWfmpI/NZhuDWCPZJVnF+quuM9gJZqQXwT9dBr4uiIGSAdcsXJg/QdxGlWFSIMUeWQRVnU/sDBAsaig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784766348; c=relaxed/simple;
	bh=+Xw+CMeLltEpRd53XMNbHA+1iq+QYGJJrDOsH5+RZLY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d+Ywkc5adL5tTC+NYI8YVYgShScu1k76XNSJJ8MCQ2XS/n2GHcQRY+y/N2OyDRNA9obXSuAbyni9DuyYfhsOIU5vxBXoG0Wcuys87Ym+wtEjxdn3eLoA9yLKh2ML4dnzJjQxTPaZ9A+o4gqztM6rrQqjdHZdcVqiwRU5NwJaEjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fs3M4KIW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fs3M4KIW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF971F000E9;
	Thu, 23 Jul 2026 00:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784766347;
	bh=Tughn6sVUiWtdcJdq+9jT1CBZT+5jQLfqXegLxvuXCk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fs3M4KIWRd52jMiu9eeowqM27Yl3wRK/dQ0I2SkxAhMdvdUxCRJkzQrlAvvpUyO5x
	 +3fSwfjSY2747abHd/rgzOYh0Q2TloHvoUZgUuInl4ikhcbHLODwvezho0s7K2tJ+D
	 BbwNZEh9XV3KQSYbdPHPKrpEMFfX0qx3idwfTg5qgx8T6u5hc/h+/Z96UiBARQmf97
	 E8KBy6cGu+UQC4YEwJZN3nrq3ICqTePCDXuhOfA/THBj2oSjym6o5sk7bgxd/Fj+/B
	 Vt+zurzj/rbL5/vozaKNmtVJQaTjit48/Z6Q8StGAsEirAlX53ol6QziYp2akCKsNO
	 EFwi8vy4ko1kA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: SEV: Allocate full pages for {DE,EN}CRYPT ops on
 SNP-enabled hosts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260723000715.1235773-1-seanjc@google.com>
References: <20260723000715.1235773-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 00:25:46 +0000
Message-Id: <20260723002547.7BF971F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] kmalloc(PAGE_SIZE) does not guarantee an isolated, page-aligned ph=
ysical page under KASAN/SLUB debug, leading to Host RMP #PF crashes.

Pre-existing issues:
- [High] The PSP driver miscalculates the number of pages to transition to =
firmware-owned state for guest-owned buffers, causing firmware RMP violatio=
ns.
--

--- Patch [1]: [PATCH] KVM: SEV: Allocate full pages for {DE,EN}CRYPT ops o=
n SNP-enabled hosts ---
commit d5055bec1548a3803ac93e35043a743044a123b7
Author: Sean Christopherson <seanjc@google.com>

KVM: SEV: Allocate full pages for {DE,EN}CRYPT ops on SNP-enabled hosts

When {de,en}crypting memory of an SEV or SEV-ES guest on an SNP-enabled host
via a temporary buffer, this commit allocates a full 4KiB page for the buff=
er.
This ensures the page containing the buffer is wholly owned by KVM. It inte=
nds
to prevent concurrent kernel accesses from triggering spurious RMP #PF
violations when firmware temporarily takes ownership of the page.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 74fb15551e83f..e3733ed9d5886 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -1280,6 +1280,17 @@ static void *sev_dbg_crypt_slow_alloc(struct page =
*page, unsigned long __va,
>  	if (WARN_ON_ONCE((*pa & PAGE_MASK) !=3D ((*pa + *nr_bytes - 1) & PAGE_M=
ASK)))
>  		return NULL;
> =20
> +	/*
> +	 * If SNP is enabled, i.e. the RMP is active, allocate a full page to
> +	 * prevent concurrent accesses to the page.  As required by firmware,
> +	 * the PSP driver updates the RMP to temporarily transfer ownership of
> +	 * the page to Firmware while the {DE,EN}CRYPT operation is in-progress,
> +	 * and so concurrent software accesses to the page will encounter
> +	 * seemingly spurious RMP #PF violations
> +	 */
> +	if (cc_platform_has(CC_ATTR_HOST_SEV_SNP))
> +		return kmalloc(PAGE_SIZE, GFP_KERNEL);

[Severity: High]
Does kmalloc(PAGE_SIZE, GFP_KERNEL) guarantee an isolated, page-aligned
physical page when SLUB debugging (e.g., SLAB_RED_ZONE) or KASAN is enabled?

When debugging is enabled, kmalloc(PAGE_SIZE) requires extra metadata, push=
ing
the allocation into a higher-order slab cache (like kmalloc-8k). The result=
ing
buffer is not guaranteed to be page-aligned and shares its underlying physi=
cal
pages with adjacent slab objects, KASAN redzones, and SLUB metadata.

When sev_issue_dbg_cmd() passes this buffer as dst_addr, the PSP driver in
snp_map_cmd_buf_desc() transitions the page to firmware-owned. Concurrent
host kernel accesses to the shared page (e.g., KASAN background checks or
another CPU accessing adjacent objects) will trigger a fatal Host RMP #PF a=
nd
crash the host kernel.

Should this use a page allocation API like __get_free_page(GFP_KERNEL) or
alloc_page() instead to guarantee an exclusive physical page?

[Severity: High]
This is a pre-existing issue, but the PSP driver miscalculates the number of
pages to transition to firmware-owned state for guest-owned buffers in
snp_map_cmd_buf_desc():

drivers/crypto/ccp/sev-dev.c:snp_map_cmd_buf_desc() {
    ...
    npages =3D PAGE_ALIGN(desc->len) >> PAGE_SHIFT;
    if (rmp_mark_pages_firmware(*desc->paddr_ptr, npages, true)) {
    ...
}

Because this calculation ignores the physical address offset
(desc->paddr_ptr & ~PAGE_MASK), an unaligned buffer that crosses a page
boundary but has a total length <=3D PAGE_SIZE evaluates to 1 page instead =
of 2.

If the unaligned buffer from the KASAN-enabled kmalloc() above crosses a pa=
ge
boundary, rmp_mark_pages_firmware() will only transition the first physical
page.

When the SEV firmware accesses the tail of the buffer on the untransitioned
second page, will this trigger a firmware RMP violation and cause the comma=
nd
to fail?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723000715.1235=
773-1-seanjc@google.com?part=3D1
