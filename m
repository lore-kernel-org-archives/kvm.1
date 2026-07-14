Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6285379EEF
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 23:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784072354; cv=none; b=I4G/IXhZ8sxtL4qAFOppcUD+Tq56e7C/GjEfBqueCaOf1L5k+79lK37tlx0a6ls9kWoL5mic6aHNLvcfREXQVUpJ4IIa+cGKLNo5VA50LevMFPeHaBtBQ6G0F7cHCYyWE+3tWnOpReUjsn/5rbm+Rphq8VXHGWpQTmZZ16cAXeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784072354; c=relaxed/simple;
	bh=rAVN9EvSYywNq5frELUk8mlOv13cUdFyrtKhjnnne1Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hb/BedcW+Jdaz2d3PUu1tC/8tXMqlDs9CVORx2qpVuA+VwvQLQTfnjsw4Jv+GnPS+T20t0l7i0AS5oi+kvUDE8Ww5mV3E3xw984RHXv06A4ho8n3cufNKTu9/9qeN7x6KKpBMlG0Aj0odjcbtJHgLLNCSzgfRYgVlWvj9II6Swc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KglLsEuW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KglLsEuW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D52E1F000E9;
	Tue, 14 Jul 2026 23:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784072353;
	bh=XCK7/Nf18htIqUtjqfUb606toMNxsEMwfKSrakj16ac=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KglLsEuWU0KuUUQ1Em2tZ2q8xQB7xKQby7iCPzcoEF/VIvc5B9MXYI9n9Xjm9juGb
	 zf1YqEjGcFk5IKz6yVuk6eEZdv0nHu+EXVWUSeVTN79t21++Zf9thhBYMILh1ndQHz
	 XVHA3Zs0AcN8Jce6XMb5wt2e8HRISsFg2+mLGSDVO6T+tj8nw4Ibv1PtZEku0OWlIy
	 r/AZidDCDEC0ZUEDNgfn/tnMMVKsRftEUNdffLllbTIGq0d76s44Z0ituqxaxs579U
	 o2Bl7/B+LTzdbjj5+hRLKOcPPv5xkIkvmIKtf5+CCvpdy7Y4KMZ3yzD5h/wgU0J2Uf
	 go1RYFy1VeDrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/7] KVM: guest_memfd: Fold
 __kvm_gmem_prepare_folio() into its sole caller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260714231015.3337831-5-seanjc@google.com>
References: <20260714231015.3337831-1-seanjc@google.com>
 <20260714231015.3337831-5-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 23:39:13 +0000
Message-Id: <20260714233913.8D52E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] Refactoring `kvm_gmem_prepare_folio()` and `kvm_gmem_make_priv=
ate()` to align `gfn` before computing `index` produces a mismatched and un=
aligned `pfn` if the memslot's `base_gfn` is not aligned to the huge folio =
size. This causes the architecture-specific prepare function to write beyon=
d the bounds of the folio, leading to host physical memory corruption.

Pre-existing issues:
- [High] In SEV-SNP, if large RMP entry preparation fails for a huge folio,=
 KVM will only prepare the base 4K page, causing an incomplete initializati=
on and an infinite page fault loop for subpage accesses.
--

--- Patch [4]: [PATCH v5 4/7] KVM: guest_memfd: Fold __kvm_gmem_prepare_fol=
io() into its sole caller ---
commit ef3a2643968d189a00f8b26552b9b814bf1aa548
Author: Sean Christopherson <seanjc@google.com>

KVM: guest_memfd: Fold __kvm_gmem_prepare_folio() into its sole caller

This commit folds __kvm_gmem_prepare_folio() into its caller, removing the
single-use tail-call helper. It also adjusts the alignment logic to align t=
he
gfn before computing the index, and converts a WARN to WARN_ON_ONCE.

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 28cdcf6007453..f065dedfbba8c 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c

[ ... ]

> @@ -97,11 +85,15 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, st=
ruct kvm_memory_slot *slot,
>  	 * The order will be passed when creating the guest_memfd, and
>  	 * checked when creating memslots.
>  	 */
> -	WARN_ON(!IS_ALIGNED(slot->gmem.pgoff, folio_nr_pages(folio)));
> +	WARN_ON_ONCE(!IS_ALIGNED(slot->gmem.pgoff, folio_nr_pages(folio)));
> +	gfn =3D ALIGN_DOWN(gfn, folio_nr_pages(folio));
>  	index =3D kvm_gmem_get_index(slot, gfn);
> -	index =3D ALIGN_DOWN(index, folio_nr_pages(folio));
> =20
> -	return __kvm_gmem_prepare_folio(kvm, slot, index, folio);
> +	return kvm_arch_gmem_prepare(kvm, gfn, folio_file_pfn(folio, index),
> +				     folio_order(folio));

[Severity: Critical]
Does aligning gfn before computing index cause an unaligned index when
slot->base_gfn is not huge-page aligned?

If a userspace process maps a guest_memfd using KVM_SET_USER_MEMORY_REGION2
with a base_gfn that is not aligned to the huge page size,
kvm_gmem_get_index() could return an unaligned index.

Because folio_file_pfn() applies the index offset to the base PFN:

virt/kvm/guest_memfd.c:folio_file_pfn() {
    return folio_pfn(folio) + (index & (folio_nr_pages(folio) - 1));
}

an unaligned index causes it to return an offset PFN instead of the
folio's base PFN.

Could this lead to host physical memory corruption? The architecture
backend processes the full page count starting from the offset PFN,
which would write beyond the allocated folio boundaries and overwrite
unrelated host physical memory.

It looks like this same alignment pattern is also present in
kvm_gmem_make_private().


[Severity: High]
This isn't a bug introduced by this patch, but could this generic
function incorrectly assume a successful return means the entire
huge folio was prepared?

Looking at sev_gmem_prepare() in arch/x86/kvm/svm/sev.c, if it falls
back to PG_LEVEL_4K for a huge folio:

    } else {
        level =3D PG_LEVEL_4K;
        pfn_aligned =3D pfn;
        gfn_aligned =3D gfn;
    }

    rc =3D rmp_make_private(pfn_aligned, gfn_to_gpa(gfn_aligned), level, se=
v->asid, false);

It appears rmp_make_private() is called only once for the base 4K page,
without looping over the remaining pages in the huge folio.

Since kvm_arch_gmem_prepare() then returns success to this generic code,
are the remaining 511 pages left uninitialized, potentially causing an
infinite page fault loop for subsequent subpage accesses?

> +#else
> +	return 0;
> +#endif
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714231015.3337=
831-1-seanjc@google.com?part=3D4
