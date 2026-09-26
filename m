Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9749830C632
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 01:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790384439; cv=none; b=R0KfJ5NZmBwpL7DosPfIFw2ELeZaRY4yvhCDDpqDHvqbtGwDZyi46uafsbUUwLzmB8OAYrbJrfFMpbdgsVhBGJDjDOxLh2X/SPznprHi8T/EppSXwOAtEr1Op4h3/RdAGClLooLdqjdnk+Mfhw5oMFdErWoXS2C+goQ5EbsFubs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790384439; c=relaxed/simple;
	bh=DhHPKhveR8114bmAusLSvpaXgh+HkGNUfZqcI/ifd9s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d1cmnwQIFufQltigiA98409fz9wyVPn/LY789BVU0n2OE1S8nlNeOvkQrEpB9cJx0/H+iy9L7w6Gn1e9x9Ll08Bn8vmczhLC1n2zTuUIKP9ySsE0+nuB52NXRDNNicREyQkFTHFTum6NDkDvfhJrZTr38/sIthjfEg3Jlk9A7N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lx/KjVJ6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lx/KjVJ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41CFA1F00898;
	Sat, 26 Sep 2026 01:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790384438;
	bh=iLCaEH/6hQdbd6iTChq453Yf++PoQdK3p7pQmmENHSo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lx/KjVJ6ynzluk7aI9MPSf1T4P+Xr6bNzbKyTxT8obuitZkhsUTIWYxSB7kZlxy0D
	 eGROy7sOi+5GJDtlhY7iFE2/sccQis1BIS6W2g7brlzup3UC3yD6OmVk1cDDGTNw2Q
	 dugQ+6j56j4rBUHFEceI1etHEfs9wb+/Iw5NOhrIPGMH3ISraxmqjxPiZRGifwLBEQ
	 YIyVjOiHoIwOIf4JTKLKDMInftVQ71AKXkZ579ZHelRZjylN+W27QjrER25LHoNgD9
	 LJDgG6zaBEzbNrntiyLcefIWewPjgbZtc9hnZJ/f/zCmyz3SaF2ysbBdlPBw4C/UUr
	 gNdRodrzII6Sw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 02/17] KVM: guest_memfd: Support provider folio
 allocation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng" <ackerleytng@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260925-gmem-tmpfs-backend-v1-2-d36159822d18@google.com>
References: <20260925-gmem-tmpfs-backend-v1-0-d36159822d18@google.com>
 <20260925-gmem-tmpfs-backend-v1-2-d36159822d18@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 01:00:37 +0000
Message-Id: <20260926010038.41CFA1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mm: kvm_gmem_get_folio() fails to retry on -EEXIST
--

commit 445058fdb485b40ed9956aa2d77439d304e8462d
Author: Ackerley Tng <ackerleytng@google.com>

KVM: guest_memfd: Support provider folio allocation

This commit introduces support for provider folio allocation in guest_memfd.
If created with a provider, guest_memfd uses it to allocate folios and inse=
rts
them into its own filemap.

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -140,10 +155,29 @@ static struct folio *kvm_gmem_get_folio(struct inod=
e *inode, pgoff_t index)
[ ... ]
> +	if (gi->provider_ops) {
> +		folio =3D gmem_provider_alloc_folio(gi, index, policy);
> +		if (!IS_ERR(folio)) {
> +			int r =3D filemap_add_folio(inode->i_mapping, folio,
> +						  index, GFP_KERNEL);
> +			if (r) {
> +				folio_put(folio);
> +				folio =3D ERR_PTR(r);
> +			} else {

[Severity: High]
Does this code handle concurrent faults correctly?  When multiple vCPUs
concurrently fault on the same unmapped guest_memfd page, they will both
attempt to allocate and add a folio to the page cache.

The first one will succeed, but the subsequent ones will receive -EEXIST fr=
om
filemap_add_folio().

Since kvm_gmem_get_folio() traps the -EEXIST error here and converts it
directly into a terminal error rather than triggering a cache lookup retry,
it propagates the -EEXIST error up to KVM's page fault handler.

Can this cause an unexpected failure (KVM_EXIT_MEMORY_FAULT) and crash the =
VM,
allowing an unprivileged guest to trigger a denial of service?

> +				folio_mark_accessed(folio);
> +			}
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-gmem-tmpfs=
-backend-v1-0-d36159822d18@google.com?part=3D2
