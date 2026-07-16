Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE99D41DDFF
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 18:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784226949; cv=none; b=JRDoZXSO3lAxKJYVHEzl3YJ9OrkoGCiL1fflGcnJ5ANnXnT2X1enPZACnONgnFAuGtoiRdCX3/+bY3xS1XWajozcwWYX4Lc6tsf/Z6SyFjgxjeNFLPQyLR6SbURIWzre1NA7IN/NGZX7p+pqsGuAB7SYwWsdSOnCmQCKpMaObhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784226949; c=relaxed/simple;
	bh=fRmufL5Jl+lVa265LDZTRbv94WSlXrzFM5mUb3K7afo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EXoGypvjvPajd1pddXJJrfwMiUCZkMi9SXCW2UZlt/vUmBSbypmWGPrpmOVdsn5ZvgoWT50y8BoC4aoHRHjFk0tcAbR90Adjfxv0fDfjD/Ca/XSlSVFdnSFAfrPrkSc5KHt02KWKXcRMpdtlfnqAXpintNpiJLAoHwMMeIEC+io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiFvJ0q9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiFvJ0q9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8A21F000E9;
	Thu, 16 Jul 2026 18:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784226947;
	bh=iyAM45gVa2LhPtOXmYhpKJOEFyb2JCQ34/N0exrKjRo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oiFvJ0q9vK7eQST5AYEdLoQ9tZBJ0cnA+Qeytxd69+bigiG/QlkfYOCpmdHwu8BLx
	 HkIdVf8bPptnxqOewo1oEO/KW+nknH+uBFPEZ8+fnzqYtMqUlIKla7UcyPssNtmpGh
	 FjInRl04IybWQxiyKCwW8zWua+3IJq4ZPdggeeernfcMPnp4wOX46Mab0/NTIdlIle
	 67PJkBNmwP9RDV4T81s/DsHmb2IHEeYbUM1Tx2T8oZQRdTcbBt6znQ2+9rli6cllL2
	 GhB/sBvQ10NDTBWtq8ZiLLvPL4nEeEQCZzl/vljQ2BoqIfm1R0t/At61UXOJ+bLcr7
	 RBadbGlH2A+kA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 20/24] KVM: x86/mmu: Do not prefetch sptes on gfns
 backed by memory attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260716181456.402786-21-pbonzini@redhat.com>
References: <20260716181456.402786-1-pbonzini@redhat.com>
 <20260716181456.402786-21-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 18:35:46 +0000
Message-Id: <20260716183547.1B8A21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Skipping SPTE prefetch for pages with memory attributes leaks the =
`struct page` reference.
--

--- Patch [20]: [PATCH 20/24] KVM: x86/mmu: Do not prefetch sptes on gfns b=
acked by memory attributes ---
commit f42ac0f993cf93f62265ecaa532948b8790213ce
Author: Nicolas Saenz Julienne <nsaenz@amazon.com>

KVM: x86/mmu: Do not prefetch sptes on gfns backed by memory attributes
   =20
This commit modifies KVM's MMU prefetching to check for memory attributes on
each GFN. If memory protections are applied to a GFN, the code skips
prefetching the SPTE for that page.

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 59c2a04f5648c..8e85f672a08d5 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3156,6 +3156,9 @@ static bool kvm_mmu_prefetch_sptes(struct kvm_vcpu =
*vcpu, gfn_t gfn, u64 *sptep,
>  		return false;
> =20
>  	for (i =3D 0; i < nr_pages; i++, gfn++, sptep++) {
> +		if (kvm_get_memory_attributes(vcpu->kvm, gfn))
> +			continue;
> +

[Severity: High]
Does this leak the struct page reference?

Earlier in kvm_mmu_prefetch_sptes(), kvm_prefetch_pages() populates the
pages[] array, which elevates the reference count for each page. By using
continue here, the loop skips over the required cleanup call at the bottom
of the loop:

    kvm_release_page_dirty(pages[i]);

Should this code release the page before continuing to the next iteration?

>  		mmu_set_spte(vcpu, slot, sptep, access, gfn,
>  			     page_to_pfn(pages[i]), NULL);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716181456.4027=
86-1-pbonzini@redhat.com?part=3D20
