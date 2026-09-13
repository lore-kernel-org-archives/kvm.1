Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F153176EE
	for <kvm@vger.kernel.org>; Sun, 13 Sep 2026 07:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789284349; cv=none; b=ck/vsQL31zhEhwrpyrjEtgR7h4jIIl0Qnyp0Z7yIT41cEilxfutC3Xx5/M3iMAIwzSybcnDB/RKgCfJX29J0yPKFjifLu9NU1Ip57sRCvQ8lIyPh+t/kv3PpGnFCAPrs4BtOsAyYXSUatndaMLl0Wz7Ml0XD8YXQAXQBlfyuA7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789284349; c=relaxed/simple;
	bh=bjty2YYG7hoCIPrZzGpl/b+rjNWSeb4L91CM4/cA830=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J2zmVd/4NQGvLEEIJ+tHMRq4ikS6sTcQbYv0tbxp94aMQouGbl8Z2nmErR/PpQIwuGgj11DNHWSmKr3Xhlu1AlyChAQtNGSe0/XjORALRK8XWKIyHRLwXq31dUtjKl43Y35mlIo7sxOZVgssNcZMhaam2S0kmpUtKVpwUqWv3Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKzk0x+U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKzk0x+U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CC61F000FF;
	Sun, 13 Sep 2026 07:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789284348;
	bh=rhJXi4XEyHhRRVva2SeMl6cO3mPPCSH5o9FvxrcZSSA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BKzk0x+U4aj/OVQOq80esUjPLpwg5pcGy27iNSevP+9F75Mwu052uu43k3Tbb5FTz
	 xV46RlQLuvHCWBd4UtP2CRJDjsaCpbnMeuvl5qjhKWns8JZkyPYuIriyODnV6Oz8cq
	 zlxlOU73HIR+jOdzDtgduFUHKXXhnyRtADi02CnPI12CXuvhEYfz0JcBM0l82zO1WT
	 vlOGLByZBA6ErHAEenXLp242woOUTCQ2updEaDLxJKKR00TadypEZE16EhuYvxU2uT
	 bQFieDZOWxIVAL4jaBtw7FV3NpRtv3IrHr5a/E4nn8OZPjwiyu6rgaJkKtIZFBvwdG
	 2tVpSSzT/LOFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] RISC-V: KVM: Recover gstage huge page mappings
 during disable-dirty-log
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wang Yechao" <wang.yechao255@zte.com.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260913070352.3626956-3-wang.yechao255@zte.com.cn>
References: <20260913070352.3626956-1-wang.yechao255@zte.com.cn>
 <20260913070352.3626956-3-wang.yechao255@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 07:25:47 +0000
Message-Id: <20260913072547.E3CC61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Arithmetic subtraction of pfn_pte(..., 0) corrupts custom memory t=
ype bits (e.g., T-Head PMA) in make_huge_pte().
- [High] Missing congruent alignment check for host page size leads to misa=
ligned guest superpages and guest crashes.
- [Medium] Flawed boundary checks and loop advancement logic prematurely sk=
ip valid memory ranges during huge page recovery.
--

commit 83685cea613e39b130969d813c4ab2e7f3ad286f
Author: Wang Yechao <wang.yechao255@zte.com.cn>

RISC-V: KVM: Recover gstage huge page mappings during disable-dirty-log

When dirty logging is enabled, the gstage mappings are split into
4K pages to track dirty pages. If the migration fails or is canceled,
this patch recovers the gstage huge page mappings when dirty logging is
disabled to keep the VM's performance consistent.

> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> index e5002cb9cbef1..b9414a62c3e04 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c

[ ... ]

> @@ -369,6 +369,73 @@ bool kvm_riscv_gstage_split_huge(struct kvm_gstage *=
gstage,
>  	return need_flush;
>  }
> =20
> +static inline unsigned long make_huge_pte(unsigned long child_pte, int i=
ndex,
> +					  unsigned long child_page_size)
> +{
> +	unsigned long huge_pte =3D child_pte;
> +	unsigned long child_pfn_offset;
> +
> +	child_pfn_offset =3D index * (child_page_size / PAGE_SIZE);
> +	huge_pte -=3D pte_val(pfn_pte(child_pfn_offset, __pgprot(0)));

[Severity: High]
Does subtracting pfn_pte(..., 0) corrupt custom memory type bits on T-Head
CPUs?

On RISC-V platforms with T-Head extensions, pfn_pte() with __pgprot(0)
automatically applies custom memory attribute bits because the initial
protection value is 0. Subtracting this value inadvertently subtracts these
high memory bits from the PTE rather than just the shifted PFN.

Could this corrupt the huge PTE, potentially clearing required attribute bi=
ts
or underflowing into the PFN bits, resulting in an invalid guest mapping?

> +
> +	return huge_pte;
> +}

[ ... ]

> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 6035b5ec95039..8e76187abd89a 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c

[ ... ]

> +static void mmu_recover_huge_pages(struct kvm *kvm, int slot)
> +{

[ ... ]

> +	while (addr < end) {
> +		/*
> +		 * If a very large memslot is mapped exclusively with
> +		 * 4KB host pages, or too many hugepages need to recover,
> +		 * release the kvm->mmu_lock to prevent starvation and
> +		 * lockup detector warnings.
> +		 */
> +		cond_resched_rwlock_write(&kvm->mmu_lock);
> +
> +		if (!kvm->arch.pgd)
> +			break;
> +
> +		hva =3D gfn_to_hva(kvm, addr >> PAGE_SHIFT);
> +		page_size =3D get_hva_mapping_size(kvm, hva);

[Severity: High]
Does the host mapping size need to be validated against the memslot alignme=
nt
before attempting recovery?

The loop fetches the host's mapping size but fails to validate it against
fault_supports_gstage_huge_mapping(..., page_size). If the host mapping is
1GB, KVM accepts this size without re-verifying that the memslot supports 1=
GB
mappings (for example, if GPA and HVA are congruently aligned for 2MB but n=
ot
for 1GB).

Because the size is not validated for congruent alignment, could subtracting
the offset in make_huge_pte() leave a base PFN that is misaligned for the
superpage size, producing an architecturally invalid PTE?

> +		if (page_size =3D=3D PAGE_SIZE) {
> +			addr +=3D page_size;
> +			continue;
> +		}
> +
> +		range_start =3D ALIGN_DOWN(addr, page_size);
> +		range_end =3D range_start + page_size;
> +
> +		/*
> +		 * Make sure the recover range [range_start, range_end)
> +		 * is within the slot range.
> +		 */
> +		if (range_start < start || range_end > end) {
> +			addr =3D range_end;

[Severity: Medium]
If the host mapping size is 1GB but the memslot does not start on a 1GB
boundary, range_start < start evaluates to true. Does advancing addr
unconditionally to range_end entirely skip over valid memory that could have
been recovered with smaller huge pages?

> +			continue;
> +		}
> +
> +		out_size =3D mmu_recover_huge_pages_range(&gstage, page_size,
> +							range_start, range_end);
> +
> +		if (out_size > page_size)
> +			page_size =3D out_size;
> +
> +		addr =3D range_start + page_size;

[Severity: Medium]
If out_size is larger than the original page_size (for instance, 1GB vs 2MB=
),
does adding it to range_start (which was aligned only to the smaller size)
result in a misaligned addr that skips memory in the next loop iteration?

> +	}
> +
> +	write_unlock(&kvm->mmu_lock);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913070352.3626=
956-1-wang.yechao255@zte.com.cn?part=3D2
