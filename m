Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CAD33262A
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 15:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784216577; cv=none; b=QaqUiNqiYrRNNjcx7MvUKyqkYG6u3lHBHwKem6+jDxmnJRPhB0kZ3rs7Edhnc2zaD9EHRoK8W73tB2+jlWrE7V+3ywN2/uxxYrrJi9Nh8CRYcgL56MNMympyeOy7LEtskEmHGEPZh0hbgS/HuICg2/ZgHaBOo4ZagCCY9+ePxEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784216577; c=relaxed/simple;
	bh=+dPZC7/jIFZyrv4JQs/CbAN0PFT8VVbuBY7vnMoXQwM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rcnTrpCXS2fmXYdjUCz8qap76F26uCbzRbmWtPT8BD4rN8hhR5x185iUtzyrBW4pSl9c6ZSFlgyUo+dagjYOdOwGMxmNrZhh1A9akMf7nNhSzAPD4SN2zmgWGQjTm1sUzowRYFVURvFFO+t38W+ZkZGnu/5CxVyj5UHH9pQ686g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLsp3+Wq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLsp3+Wq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928AA1F000E9;
	Thu, 16 Jul 2026 15:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784216573;
	bh=noodKXFHMnBZm8X5cUxZhWEy61ZBT1b+YHqCc971gUU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nLsp3+WqakkVTirZkv70nbftkfwI93r8aqepm9r7Otoqrf3O0N7nkQCLXVYQ0CvCh
	 MwL5EmcWe7LlmNP8wM0oGhe2T4bpeB21P2gtnKkHYU/I1r7966nLShaV8DqlK+WG8V
	 5tMjvvApTqDrNgPhmJ7Hiqi3D5hfOJROtKHvbyoesCQVgmVvNqCtYyI2pA1vMUpEXg
	 hJMbZzZEle6vpuesiZzwwoOrzT8x6uFgCFNFMTyye2xT7X9w7uNdfzTOO7w+/qHTSJ
	 1WLUDqhcCNkunlAoKrIBqtvTcfWXwkKFns9J7RK/W9bQEj9thJ4zoo+2N4m5eXmyse
	 HsIOaJUe4qDvQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 07/11] KVM: guest_memfd: Add ops-driven page
 revocation
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: dri-devel@lists.freedesktop.org, kvm@vger.kernel.org, media-ci@linuxtv.org
In-Reply-To: <05c8944cb77fa68163303cefe1c922ff142ceb07.1784194290.git.dwmw@amazon.co.uk>
References: <f09647f427565c1789a6979470045aab78661563.1784194290.git.dwmw@amazon.co.uk>
 <05c8944cb77fa68163303cefe1c922ff142ceb07.1784194290.git.dwmw@amazon.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 15:42:53 +0000
Message-Id: <20260716154253.928AA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm_gmem_invalidate_range() fails to invalidate GFNs that span mul=
tiple memslots, start in an unmapped hole, or exist in non-zero address spa=
ces, leading to partial invalidation and potential Use-After-Free.
--

--- Patch [7]: [RFC PATCH 07/11] KVM: guest_memfd: Add ops-driven page revo=
cation ---
commit 9715bf20df84962c5cc8863e7f4350b3bcb15273
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: guest_memfd: Add ops-driven page revocation

This commit adds kvm_gmem_invalidate_range() to allow a guest_memfd backing
to zap the guest secondary-MMU mapping for a gfn range. This provides an
implementation-to-KVM path to reclaim pages from a running guest.

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 2b277468a12f0..6c13742de0680 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c

[ ... ]

> @@ -738,6 +738,45 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_crea=
te_guest_memfd *args)
>  	return __kvm_gmem_create(kvm, size, flags);
>  }
> =20
> +/*
> + * Outbound (implementation -> KVM) revocation: an implementation zaps t=
he
> + * guest's secondary MMU mapping for a gfn range so the next guest access
> + * re-faults through ops->get_pfn().  Mirrors __kvm_gmem_invalidate_star=
t()
> + * for a single bound slot, bracketing the unmap with the mmu_invalidate
> + * window so a racing vCPU fault retries rather than installing a stale
> + * mapping.
> + */
> +void kvm_gmem_invalidate_range(struct kvm *kvm, gfn_t start, gfn_t end)
> +{
> +	struct kvm_memory_slot *slot;
> +	bool flush =3D false;
> +	int idx;
> +
> +	idx =3D srcu_read_lock(&kvm->srcu);
> +
> +	slot =3D gfn_to_memslot(kvm, start);
> +	if (slot) {
> +		struct kvm_gfn_range gfn_range =3D {
> +			.slot		=3D slot,
> +			.start		=3D start,
> +			.end		=3D min(end, slot->base_gfn + slot->npages),
> +			.may_block	=3D true,
> +			.attr_filter	=3D KVM_FILTER_SHARED | KVM_FILTER_PRIVATE,
> +		};

[Severity: High]
Does this code fully invalidate the requested range if it spans multiple
memslots or starts in an unmapped hole?

By looking up only the memslot for the start GFN and clamping the end to
slot->base_gfn + slot->npages, it seems any remaining GFNs in the requested
span will be skipped if the range crosses a memslot boundary.

Additionally, if the start GFN happens to fall in an unmapped hole,
gfn_to_memslot() returns NULL and the entire invalidation is bypassed, even
if there are valid mapped memslots further along in the range.

Finally, gfn_to_memslot() only checks Address Space 0. Could this leave
stale SPTEs in alternate address spaces (like SMM), allowing the guest to
access reclaimed host memory?

> +
> +		KVM_MMU_LOCK(kvm);
> +		kvm_mmu_invalidate_start(kvm);
> +		flush =3D kvm_mmu_unmap_gfn_range(kvm, &gfn_range);
> +		if (flush)
> +			kvm_flush_remote_tlbs(kvm);
> +		kvm_mmu_invalidate_end(kvm);
> +		KVM_MMU_UNLOCK(kvm);
> +	}
> +
> +	srcu_read_unlock(&kvm->srcu, idx);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/f09647f427565c1789a=
6979470045aab78661563.1784194290.git.dwmw@amazon.co.uk?part=3D7
