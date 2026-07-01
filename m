Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEAB38F259
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 08:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782893441; cv=none; b=H/FvBbbPxMhYsf7GMnlrTXJGoFw50/+i5JwEGeC4Ii4j/4ocaGvZ5qaOdKa+7aQlizMcq3HzSjbvZaedNYuq5XoA6QhALNH1i/Bw7FKFjvL6aKoS9bEXTC0zK4KxN+bjrfE8UOEN5VPzRM+MOr22c03D8A48SK856JsHl36xJP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782893441; c=relaxed/simple;
	bh=AtlvuS3//WNdIMQdJ4WWq8HTLDiwv4m6iAdVOz8QhuE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V6n8DBRU1ZdtqURr8yXKPNtFhVZW+geqmoFOEVjRH/EoG7qwPPSdFWhkjc9VOa7vD4jjqlAvvYN+eFLkFie7Zl/n9b+axOgQdKLJo5+bNuAGAQOqnSxHLXr5gIaOtW33AivfpNB+/ybDK+8SsnRD3AnbLVi/IWdQwOjRCiVKMRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SupUb/PY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SupUb/PY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDFFE1F00A3A;
	Wed,  1 Jul 2026 08:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782893432;
	bh=dMf6w0D7vQKGeOrKjG4EMAME89drd934JDkmXhkdNuA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SupUb/PYCKjaqL20lqhKQxhAVmop4TF7xFTWqHRVnu3Jq/ZrwbiI6QDAx0hoOEFhi
	 pO6+huTiG33BrEDK+/4NWbVlvjRYW2+T6WdItU6EcbFn8iquHSNrC9Dvl6k70sQc57
	 P3TuKFffeMD1hMooKfiy1E9qDNjr6tdQvbAKGwvr3Eo3cq3nOps0sjLjmDA8SRQljE
	 CpAIpAQ5Jd98679tWxMR2cdzvfWAL1nthErWLKr9Ct0iGnU+W4AsvlJyp53lUPzirz
	 8DQZ9hDVv+6j9uUCr1Ji+I7hc7nb5LocXLmQtT1Rzrf8biBq83FkvDuaj1eDeg2Sfk
	 X7V01RxGbS9xw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] riscv: kvm: Skip preventive hfence.gvma for new G-stage
 mappings with Svvptc
Reply-To: sashiko-reviews@lists.linux.dev
To: Dylan.Wu <fredwudi0305@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260701075239.95542-1-fredwudi0305@gmail.com>
References: <20260701075239.95542-1-fredwudi0305@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 08:10:30 +0000
Message-Id: <20260701081031.DDFFE1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `smp_wmb()` before linking newly allocated intermediate pa=
ge tables, exposing uninitialized memory to concurrent hardware page table =
walkers.
- [High] Non-atomic write-protection of G-stage PTEs clobbers hardware Acce=
ss/Dirty bit updates.
--

commit 8c5791358f444706f77027dbaa2cea7abc95b1e0
Author: Dylan.Wu <fredwudi0305@gmail.com>

riscv: kvm: Skip preventive hfence.gvma for new G-stage mappings with Svvptc

For Invalid->Valid G-stage leaf PTE updates, the flush in
kvm_riscv_gstage_set_pte() is preventive. When Svvptc is available, new
valid PTEs become visible to the page-table walker within a bounded
time, so an immediate hfence.gvma is unnecessary. Skip gstage_tlb_flush()
for that case.

> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> index c4c3b79567f10..7b805112d2829 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c

[ ... ]

> @@ -171,8 +173,11 @@ int kvm_riscv_gstage_set_pte(struct kvm_gstage *gsta=
ge,

[Severity: High]
This isn't a bug introduced by this patch, but does
kvm_riscv_gstage_set_pte() need an smp_wmb() before linking a newly
allocated intermediate page table?

When a new page table is allocated during a guest page fault, the setup
looks like this:

	next_ptep =3D kvm_mmu_memory_cache_alloc(pcache);
	if (!next_ptep)
		return -ENOMEM;
	set_pte(ptep, pfn_pte(PFN_DOWN(__pa(next_ptep)),
			      __pgprot(_PAGE_TABLE)));

Without a memory barrier before set_pte(), the zeroing of the newly
allocated page table could be delayed past its publication in the parent
page table.

If a concurrent hardware page table walker follows the pointer to the new
page table and observes uninitialized memory, could it interpret random old
data as valid PTEs and cause wild memory accesses or guest memory
corruption?

>  	}
> =20
>  	if (pte_val(*ptep) !=3D pte_val(map->pte)) {
> +		bool was_invalid =3D !pte_val(*ptep);
>  		set_pte(ptep, map->pte);
> -		if (gstage_pte_leaf(ptep))
> +		if (gstage_pte_leaf(ptep) &&
> +		    !(was_invalid &&
> +		      riscv_has_extension_unlikely(RISCV_ISA_EXT_SVVPTC)))
>  			gstage_tlb_flush(gstage, current_level, map->addr);
>  	}
> =20

[Severity: High]
This is a pre-existing issue, but can the non-atomic write-protection in
kvm_riscv_gstage_op_pte() clobber hardware Access/Dirty bit updates?

During dirty logging, GSTAGE_OP_WP uses a non-atomic read-modify-write
to clear the write bit:

	else if (op =3D=3D GSTAGE_OP_WP)
		set_pte(ptep, __pte(pte_val(ptep_get(ptep)) & ~_PAGE_WRITE));

If the hardware page-table walker asynchronously updates the Access or
Dirty bit between ptep_get() and set_pte(), would that hardware update be
silently overwritten and lost?

Losing a Dirty bit might cause KVM to treat a modified page as clean
during dirty logging. Could this lead to silent data corruption during
live migration since the modified guest data wouldn't be transferred?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701075239.9554=
2-1-fredwudi0305@gmail.com?part=3D1
