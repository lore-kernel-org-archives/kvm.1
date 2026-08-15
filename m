Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C749B35E1AA
	for <kvm@vger.kernel.org>; Sat, 15 Aug 2026 10:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786789339; cv=none; b=a2Kv39EWrpvGn8iTXxFsNi1C/yu5BzLDHt6um+HGJJdvc3fRE0heNvf5RfRSceE7n0OESn/EeF4j4fiqwpGEvR4o8ivTpK0xNOInM2vrGVQN7pkG3vOBthbobjvMED0nQDkNqGaAHhCSt5gTvOzP3w5NxQlCiCCD8gxa4+EZsic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786789339; c=relaxed/simple;
	bh=Zga7CRg3SF8M3cbN0pydVxP/UueM4KHaLLKpIrwE2ns=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eR8T55m8XXshgYw6FonIuTc2N+jFzan1MwKgJ60rQoPwz87H7tcn4UTBrS4iGaeTsBpjypgl1nQY4iLIz/qBJccUb+jmiUeiGuwc7vwRD9khRjYWnyCqaA4tFZknyzxUOzc+XlVFCdeTTJn0K0E1pGsXyWEfC1zxLMruN3Rhv/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sj10kXq6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sj10kXq6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FCC11F000E9;
	Sat, 15 Aug 2026 10:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786789338;
	bh=f8H7zpklYQPV93/pkHsHE8VZUeHJld/6p4Xs8XZLGgg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sj10kXq6SfrZt6sGtw6g8gkPdMORHzX+bSQ4yA+5AFXr6d0CivfwsWe6NIzTcgY75
	 uoV2GYyK2jS9Cquzkj1bONkvtnp22sKL+Dx9kZTw5REiGN/tV3pexicuLJ522QAQFP
	 W8OAH8CD/2I5ddet5yLVE8rwMCxY/8pr3QLHktKnO7bLQhUJDr2dpECSBC6zfrPD6W
	 MJMWMz7gZd/J7HqxWhDNVOb+fJHNn6KEsz9x7eUQodkz05OW9+nTx2XMnd8afMs9GK
	 CVRUDqz9A15mQeMtgqZoXD42VNmo6FLftz6vcl7pLVb/0+ZEBaQkQ66AKUHj5de4ni
	 w0LPfYrtg52Gg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/5] KVM: riscv: Avoid THP adjustment for existing 4K
 G-stage leaves
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinyu Tang" <jinyu.tang@linux.dev>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260815100411.861526-1-jinyu.tang@linux.dev>
References: <20260815095548.860018-1-jinyu.tang@linux.dev>
 <20260815100411.861526-1-jinyu.tang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 10:22:18 +0000
Message-Id: <20260815102218.6FCC11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete bug fix allows an infinite page fault loop when handlin=
g THP-backed memory.
--

--- Patch [2]: [PATCH v4 2/5] KVM: riscv: Avoid THP adjustment for existing=
 4K G-stage leaves ---
commit 6582fbd6641ea5762d156dac1847e91f07decbd7
Author: Jinyu Tang <jinyu.tang@linux.dev>

    KVM: riscv: Avoid THP adjustment for existing 4K G-stage leaves

This commit updates transparent_hugepage_adjust() to check if the original
fault GPA already has a 4K G-stage leaf. If so, it skips THP adjustment and
handles the fault at PAGE_SIZE granularity.

> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index bfd6168ebe308..2fabcd4099919 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
[ ... ]
> @@ -500,10 +500,21 @@ static int get_hva_mapping_size(struct kvm *kvm,
> =20
>  static unsigned long transparent_hugepage_adjust(struct kvm *kvm,
>  						 struct kvm_memory_slot *memslot,
> +						 struct kvm_gstage *gstage,
>  						 unsigned long hva,
>  						 kvm_pfn_t *hfnp, gpa_t *gpa)
>  {
>  	kvm_pfn_t hfn =3D *hfnp;
> +	u32 ptep_level;
> +	pte_t *ptep;
> +
> +	/*
> +	 * Keep the existing split G-stage leaf and update the original
> +	 * faulting 4K page in the vCPU fault path.
> +	 */
> +	if (kvm_riscv_gstage_get_leaf(gstage, *gpa, &ptep, &ptep_level) &&
> +	    !ptep_level)
> +		return PAGE_SIZE;

[Severity: High]
This is a pre-existing issue, but does this fully prevent the infinite page
fault loop when handling THP-backed memory?

This check only validates the unaligned faulting GPA. If the faulting GPA is
unmapped, it proceeds to align the GPA to the PMD base. However, if the PMD
base itself already has a 4K leaf (e.g., from a prior access while dirty
logging was enabled), transparent_hugepage_adjust() will still return
PMD_SIZE.

When called with the aligned GPA (the PMD base), kvm_riscv_gstage_map_page()
will find the 4K leaf at the PMD base:

arch/riscv/kvm/gstage.c:kvm_riscv_gstage_map_page() {
    ...
		} else if (ALIGN_DOWN(PFN_PHYS(pte_pfn(ptep_get(ptep))), page_size) =3D=
=3D hpa) {
			kvm_riscv_gstage_update_pte_prot(gstage, ptep_level, gpa, ptep, prot);
			return 0;
		}
    ...
}

It updates the protection bits of the PMD base leaf and returns success
without mapping the original faulting GPA. Could this leave the originally
faulting GPA unmapped, causing the vCPU to hang in an infinite page fault
loop?

> =20
>  	/*
>  	 * Make sure the adjustment is done only for THP pages. Also make

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815095548.8600=
18-1-jinyu.tang@linux.dev?part=3D2
