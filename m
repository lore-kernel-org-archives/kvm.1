Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0449339EF2B
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779806223; cv=none; b=BtBQzEFkx70ekp0vDUivMHh1FOTwF2IqyhcTqWROMHwnxG8X6pYNMR0X52UtQnRRnFTySWa18EDahOtKcAnGZuzW7AMiVpZN3VkO9yUTmTeE4unyU4DOWs4CYFsDNSb8F1DU6+eGArkdhSPdb1Zcaw4wL2Za8E7yxPt84h0zGzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779806223; c=relaxed/simple;
	bh=kAVSMf6XWDU8z7Y3qkiw1ON0KWSSgvy8S2MiUfHl6ZI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pBMQkXRBnDb3ssW1rPljVLV4sEyQtkmEjaJEwHNXi7GY7A7ywkL8TSrapVNAoZ+sFs1PZTV98w3cLqZO8hWk90PUm7uNrbS0/E6NUppi4xEYavbNk5PtRpvmNyLZUcyiEokrk7a4NoPa3HwLkCo77pVeAE+++Q/t50JBaugQQxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fg+K4kpJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fg+K4kpJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893741F000E9;
	Tue, 26 May 2026 14:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779806221;
	bh=Vhs9zM7DhLgqrj8+03QE+Zvl4HdChGc9d7enFWOM6+M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fg+K4kpJ0Ds72+zs4EFsZFYaBqSJybfl5lyxQZOnZrorPi8dxSgC9AirAzZBKWpfO
	 opklJPWRvoE+YnQYf+/Uvox6qVoKYYjKxNJ3AgnZjSgxSmj1sDRaz9vt4xNpu5C00S
	 KtsyqES1Bd1zg3VZX1k9n5WCtgEOHSplyrjWsqe5lZSj5nf0/69hbLEZKVGiUosAAj
	 9auffYLoCsKmfX8vsbdky5pBsIxmJy4vnAYaZP35q9TABwmDE9un87x3trYbGOCNnS
	 CIYM+kemmRfAl7SO8NXZFiSHQtHcJ5OIIPfxVgonrrjZOZNDZTG0CKgPA8+SEdgIhS
	 A3fuuztmQKZ2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 14/18] mm/pagemap: add PAGE_IS_ACCESSED for RWP
 tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kiryl Shutsemau" <kirill@shutemov.name>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260526130509.2748441-15-kirill@shutemov.name>
References: <20260526130509.2748441-15-kirill@shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 14:37:01 +0000
Message-Id: <20260526143701.893741F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Bypass of explicit PM_SCAN_CHECK_WPASYNC abort request for RWP V=
MAs.
--

commit ad3030249d2003121c666af3030236ae064a1680
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

mm/pagemap: add PAGE_IS_ACCESSED for RWP tracking

This commit introduces PAGE_IS_ACCESSED to the PAGEMAP_SCAN UAPI for
differentiating read-write protection (RWP) from write protection (WP) in
userfaultfd. It narrows PAGE_IS_WRITTEN to VM_UFFD_WP VMAs and restricts
the new flag to VM_UFFD_RWP VMAs, providing distinct semantics.

> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 974c5f4aa5331..0db29c3a8639f 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c

[ ... ]

> @@ -2677,6 +2702,18 @@ static int pagemap_scan_test_walk(unsigned long st=
art, unsigned long end,
>  	bool wp_allowed =3D userfaultfd_wp_async(vma) &&
>  	    userfaultfd_wp_use_markers(vma);
> =20
> +	/*
> +	 * PM_SCAN_WP_MATCHING is the atomic read-and-reset flavour of the
> +	 * scan and is implemented for the WP marker only. Silently skip
> +	 * VM_UFFD_RWP VMAs, matching the convention used below for VMAs
> +	 * that lack the WP-async capability. Returning -EINVAL here would
> +	 * abort the walk after preceding VMAs had already been mutated,
> +	 * destroying the atomic read-and-reset guarantee. Re-arming RWP
> +	 * is done with UFFDIO_RWPROTECT(MODE_RWP).
> +	 */
> +	if (userfaultfd_rwp(vma) && (p->arg.flags & PM_SCAN_WP_MATCHING))
> +		return 1;
> +

[Severity: Medium]
Does this early return bypass the user's explicit request to abort via
PM_SCAN_CHECK_WPASYNC?

If a VMA is registered for RWP, it lacks WP-async capability, meaning
wp_allowed is false. By returning 1 here, we skip the VMA instead of reachi=
ng
the PM_SCAN_CHECK_WPASYNC check immediately below, which would normally ret=
urn
-EPERM to honor the user's UAPI request to abort the scan.

>  	if (!wp_allowed) {
>  		/* User requested explicit failure over wp-async capability */
>  		if (p->arg.flags & PM_SCAN_CHECK_WPASYNC)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526130509.2748=
441-1-kirill@shutemov.name?part=3D14
