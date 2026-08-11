Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343DA36C0D6
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 23:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786490589; cv=none; b=dBB/K5CHR20p1ipPz4hLaeMy8AGXDnTNZnescuqmdbgFRGX+ch7h3UuMhkw9yTVzzUy+fKBr8m/DGtYryJDvNvis3bu4MblVhSNQwpDr1LycRSotDcihgNLOvJfhe52qNbiWhuyUCNJiT7HuWYwP703z85gowqRbzeARvPZLaOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786490589; c=relaxed/simple;
	bh=P/bkgpCedE3AZ+lCCwCdvVVebPAckWJHmcXAM7dbq+M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P8ySKf54FtwPf+if4OhYscGfHwcC+p0MsZngzOyXeJv5z1x9yKN7B8mTwmGE1BVEfHyKW2PGUWRWtT5mfcW4cF3ri4AHKgCBE9cEnp91drchERyfsMsLswcth2WhBWD1Vy9QvwbfgWOr6hNEN1cq5g+na/SJVAeyYXzSRBRRmCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNPgYpdh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNPgYpdh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA56A1F000E9;
	Tue, 11 Aug 2026 23:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786490588;
	bh=l2I36OBUNKGcfeUc3V4o5k2U/JAMJe7I6GRo9NYHhWg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nNPgYpdhnO+++IC6dYSqPwTVmKYt16chUSCsy+QrB3OaY6g2hZhn/pA7wVvg3IHld
	 88HIjKW+77q5XTxV1D1hM2TghKCUXZ+lJCM3ULMW6QmPDD/uAsl9IgIrKJFuR2/v+7
	 GOa8VK1Iy1z6oaFZFjqExptQI85ID0UeLGGFvw+EFmX37Q02fqsBos9BNZtweuCwYP
	 DyjWx1eOxrYWynwz7gTcnJn23JLAlO3ucEEw8wJICfiAcDtJ8iHGfqKU/a6wcGVgNH
	 vxh1YKlsSgMEnvcrjTA/Mxw8oC58UlD99R19qcI0BtLN7zZJrpzJ6ulAYb04vj4wkA
	 qNvMn0xNaUnHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] KVM: riscv: Implement KVM_PRE_FAULT_MEMORY
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinyu Tang" <jinyu.tang@linux.dev>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260811230316.218770-2-jinyu.tang@linux.dev>
References: <20260811230316.218770-1-jinyu.tang@linux.dev>
 <20260811230316.218770-2-jinyu.tang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 23:23:07 +0000
Message-Id: <20260811232307.CA56A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] RISC-V KVM_PRE_FAULT_MEMORY leaks -EAGAIN to userspace on mmu_inva=
lidate_retry or HWPOISON, which violates the ABI and differs from x86.

Pre-existing issues:
- [High] kvm_riscv_gstage_set_pte overwrites a non-leaf PTE with a leaf PTE=
 without freeing the lower-level page table, causing a memory leak on THP c=
ollapse.
--

--- Patch [1]: [PATCH v2 1/3] KVM: riscv: Implement KVM_PRE_FAULT_MEMORY ---
commit 39a9f049be58ef7b5671f786fdc8299c1f217042
Author: Jinyu Tang <jinyu.tang@linux.dev>

KVM: riscv: Implement KVM_PRE_FAULT_MEMORY

The generic KVM_PRE_FAULT_MEMORY ioctl lets userspace populate KVM page
tables before running a vCPU over a GPA range. This commit adds the
RISC-V arch hook and reuses the existing G-stage fault mapping path.

> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> index b0474fcf065aa..ebd1e8a4b9e38 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c

[ ... ]

> @@ -280,6 +280,9 @@ int kvm_riscv_gstage_map_page(struct kvm_gstage *gsta=
ge,
>  						    out_map->level, true);
>  		} else if (ALIGN_DOWN(PFN_PHYS(pte_pfn(ptep_get(ptep))), page_size) =
=3D=3D hpa) {
>  			kvm_riscv_gstage_update_pte_prot(gstage, ptep_level, gpa, ptep, prot);
> +			out_map->addr =3D ALIGN_DOWN(gpa, page_size);
> +			out_map->level =3D ptep_level;
> +			out_map->pte =3D ptep_get(ptep);
>  			return 0;
>  		}
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but does kvm_riscv_gstage_set_pt=
e()
overwrite non-leaf PTEs with leaf PTEs without freeing the lower-level page
table?

When a THP collapse occurs, KVM attempts to map the huge page at level 1.
If the previous 4K leaf PTEs at level 0 were unmapped (e.g., via=20
kvm_riscv_gstage_unmap_range()) but the level-0 page table was left allocat=
ed,
kvm_riscv_gstage_get_leaf() returns false.

This function then falls through and calls kvm_riscv_gstage_set_pte() to
install the level-1 leaf PTE. That appears to blindly overwrite the
level-1 non-leaf PTE with a leaf PTE via set_pte(ptep, map->pte) without
freeing the level-0 page table it pointed to.

Could this lead to a memory leak of level-0 page tables over time?

> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 8a0aa5e0e216e..926b53723e31c 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c

[ ... ]

> @@ -661,6 +661,39 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct =
kvm_memory_slot *memslot,
>  	return ret;
>  }
> =20
> +long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
> +				    struct kvm_pre_fault_memory *range)
> +{

[ ... ]

> +	ret =3D kvm_riscv_mmu_map(vcpu, memslot, range->gpa, hva, false, &out_m=
ap);
> +	if (ret)
> +		return ret;
> +
> +	if (!pte_val(out_map.pte))
> +		return -EAGAIN;

[Severity: High]
Does returning -EAGAIN here leak this internal error code to userspace?

When kvm_riscv_mmu_map() handles a concurrent host MMU invalidation
(mmu_invalidate_retry() returns true) or a HWPOISONed page, it returns 0
but does not populate out_map.pte.

This arch hook then translates the internal !pte_val(out_map.pte) state
into an -EAGAIN return value. Since the generic KVM ioctl loop bubbles
this up, unprivileged userspace VMMs executing the KVM_PRE_FAULT_MEMORY
ioctl concurrently with memory pressure or page migration will receive
an undocumented -EAGAIN error, potentially causing them to fatally abort
VM initialization.

Should this return 0 instead to indicate no progress, or is a different
mechanism needed to avoid breaking the ABI?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811230316.2187=
70-1-jinyu.tang@linux.dev?part=3D1
