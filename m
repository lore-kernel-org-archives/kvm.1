Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52954DDCD
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 21:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783631485; cv=none; b=OzMX9AYMNg93PSg7m/N6X3rUg2JSWFIrhaqnUjaexnOs3Ge0WrBYQTpX9tOgHjCRY16r+5qOP4BEqrvEbycWItz4+zgy3wn0RD4zSVbrB1M2cz/kTWk+IGlyTl3d3aESYzkTJYx9dHSpVk9Z1CMBp4a+iHp6Iv0IXz0ShqypNwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783631485; c=relaxed/simple;
	bh=XHsY0ImveobfNtqgX0Ld1E+fT7ODvm8c1D5hqwP/oLM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CuHJC1uC8d7aBvNJvRYORg2zAPhX4POqH2Mkaaf3qVrbwyAKkDfwj0c2QviccG8V8PCvruQYcNec1v8alMJukZQnz0L5FAoqW/4pNHmIfNo80FPNIfjC6g0SAIDqV9UN8PBzHox5XA20FqJIFcMECMXXJfkltERDm3ZMi8tTKs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGirOtpp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGirOtpp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97C91F000E9;
	Thu,  9 Jul 2026 21:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783631484;
	bh=6IHz+qHVzcxCWA4TfRFOBi85emJtQm5/XLyDGUrjHKY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cGirOtpp5TXPAuxlB2vNgryiQBRHg9ARLRH0gYO2ILpQm5xdikN3+Ipt2TknD5NIY
	 FyhH2kmSmPEZX2YEj6eeKeexvmz0vo/H/MBLOGr3d96mCKzFjOCFzMDh1GLUXFa3he
	 cpykPrRJKt2ygyF28e+Pohau3aitVdL0Rb/lSkaxLd9fHunOxzgA+tcD/vdgtiCxVT
	 e5Coe0KWxqjuCS5GY/6m+BCR7t3RMj12lWWspNqFN815p7RXN1p05PMMAdQpcaJs3c
	 IJpK8TtskeWPqNDTYhcA8rnhQfxOSy7bEljA39C+PPMy47gDGnise+FguudREt4fJ4
	 +VkLH7XIVgzbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 15/18] KVM: guest_memfd: Fold
 __kvm_gmem_prepare_folio() into its sole caller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260709204948.1988414-16-seanjc@google.com>
References: <20260709204948.1988414-1-seanjc@google.com>
 <20260709204948.1988414-16-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 21:11:23 +0000
Message-Id: <20260709211123.C97C91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch breaks the GPA alignment for huge folios by passing th=
e original, unaligned faulting `gfn` to `kvm_arch_gmem_prepare()`, resultin=
g in a mismatch between the unaligned GPA and the aligned base PFN of the f=
olio.
--

--- Patch [15]: [PATCH v4 15/18] KVM: guest_memfd: Fold __kvm_gmem_prepare_=
folio() into its sole caller ---
commit 30508b546ec3ffd0655d6bdccee0095661b93a2e
Author: Sean Christopherson <seanjc@google.com>

KVM: guest_memfd: Fold __kvm_gmem_prepare_folio() into its sole caller

This commit folds __kvm_gmem_prepare_folio() into kvm_gmem_prepare_folio(),
extending the #ifdef guard to cover the entirety of the function and
eliminating the tail-call helper.

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c

[ ... ]

> @@ -82,6 +69,7 @@ static int __kvm_gmem_prepare_folio(struct kvm *kvm, st=
ruct kvm_memory_slot *slo
>  static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slo=
t *slot,
>  				  gfn_t gfn, struct folio *folio)
>  {
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
>  	pgoff_t index;
> =20
>  	/*
> @@ -101,7 +89,12 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, st=
ruct kvm_memory_slot *slot,
>  	index =3D kvm_gmem_get_index(slot, gfn);
>  	index =3D ALIGN_DOWN(index, folio_nr_pages(folio));
> =20
> -	return __kvm_gmem_prepare_folio(kvm, slot, index, folio);
> +	return kvm_arch_gmem_prepare(kvm, gfn_to_gpa(gfn),
> +				     folio_file_pfn(folio, index),
> +				     folio_order(folio));

[Severity: Medium]
When folding this helper, did we lose the GFN alignment for huge folios?

In the old __kvm_gmem_prepare_folio() helper, the gfn was recalculated from
the aligned index:

	gfn_t gfn =3D slot->base_gfn + index - slot->gmem.pgoff;

By passing the original, unaligned faulting gfn to kvm_arch_gmem_prepare()
alongside the aligned base PFN from folio_file_pfn(), does this create a
mismatch between the unaligned GPA and the aligned base PFN for huge folios?

While guest_memfd currently restricts allocations to order-0 folios, this w=
ould
pass an offset GPA with a base PFN to the architecture hooks once huge foli=
os
are supported, violating the API contract and potentially corrupting the gu=
est
mapping (e.g., if a backend like SEV-SNP falls back to 4K mappings for a hu=
ge
folio).

> +#else
> +	return 0;
> +#endif
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709204948.1988=
414-1-seanjc@google.com?part=3D15
