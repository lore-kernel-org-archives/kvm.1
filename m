Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571193546CB
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 12:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782218024; cv=none; b=JvgvnrpCIkIg/9kkuZGpUNFyHoBUyr9GS9gOJksVf8/kv7OiEHm0Sb55U9iDLgWWAEJ9OHbkeYfqGrEa94X4hajl3zq904rxbE2eWx3dOoxDzPTEVVreuDMZZYaP8zXIACZvAel2EN01MpFEa86SlTyh4TG1Q9ehRiDiVj/hoIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782218024; c=relaxed/simple;
	bh=t02Lmqh998OTeF+a095KpPhEwm87j4NqMmGmIcwxw24=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iZouA2Fy7dLcAsLNy75TKSSpuRViVzfdLROGBZs7jBUY0B1P9wJ59yZSpcByoMZ9F1LIVvgUA0d35UARmVdY2plK7dO46f4IpHEsWc7JQIWqf568JgUh1gMn8x74VsBJGyJ8h5QpYDZgx+Pqy0inLRFvE6uTz/Bk6TLCsarVfdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9e4GsMt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9e4GsMt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2912F1F00A3A;
	Tue, 23 Jun 2026 12:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782218023;
	bh=YNwuhgMObwqKxRJAO+h6WQyCmgLT0YTCCp41E1xTFbs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E9e4GsMtimAcvJy2bIB2fErQx6PPSn9+C20bNeg56FdFpsI3RYmXj2xxrTEkfko+g
	 FTsstBdLgAPA4xKItgJHLvUfMUGG6gsqxVDAU6AEgqtQooRKgngtc0tuXW/PxjKlIy
	 JhJxcw63koP2Gp4b4qVF6g3gefhR2MhI74YMei2ET9+yotumiKTZg1YKVcslswgvIC
	 0KgVlskmD1ncxQY3wxpALOSBV5W259nVJpip+8C1dFFST12lHqMpMiKRf8G1H8VK2d
	 Wr7I/sUrOI3au4kXhbsFxJGSi9iR6tvmnjn9u0gVCgdRTjn5FqFgpJaygPQzxoj/w/
	 t0/rioEH81iDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] RISC-V: KVM: Split huge pages when dirty logging
 is enabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wang Yechao" <wang.yechao255@zte.com.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260623121332.78514-3-wang.yechao255@zte.com.cn>
References: <20260623121332.78514-1-wang.yechao255@zte.com.cn>
 <20260623121332.78514-3-wang.yechao255@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 12:33:42 +0000
Message-Id: <20260623123343.2912F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Dropping `mmu_lock` to top up the per-VM `pgd_split_page_cache=
` introduces a race with `mmu_notifier_release()`, leading to a Use-After-F=
ree.
- [High] Missing smp_wmb() before linking a newly populated page table to t=
he parent PTE allows hardware walkers to observe uninitialized memory.
--

commit 4aa84b3974bf84dfd6f8f8c1dd2e7b3b61d34417
Author: Wang Yechao <wang.yechao255@zte.com.cn>
Subject: RISC-V: KVM: Split huge pages when dirty logging is enabled

Split huge pages eagerly when enabling dirty logging. The goal is to
avoid doing it while faulting on write-protected pages, which
negatively impacts guest performance.

> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> index c4c3b79567f10..1e980b4a08dc5 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c

[ ... ]

> @@ -337,7 +338,7 @@ int kvm_riscv_gstage_split_huge(struct kvm_gstage *gs=
tage,
> =20
>  		next_ptep =3D kvm_mmu_memory_cache_alloc(pcache);
>  		if (!next_ptep)
> -			return -ENOMEM;
> +			return need_flush;
> =20
>  		for (i =3D 0; i < PTRS_PER_PTE; i++) {
>  			child_pte =3D make_child_pte(huge_pte, i, child_page_size);
> @@ -349,11 +350,13 @@ int kvm_riscv_gstage_split_huge(struct kvm_gstage *=
gstage,
> =20
>  		if (flush)
>  			gstage_tlb_flush(gstage, current_level, addr);

[Severity: High]
Can hardware page table walkers observe an uninitialized or empty page
directory here?

Because RISC-V utilizes a weakly ordered memory model (RVWMO), the CPU
might reorder the stores to the next_ptep array after the store that links
next_ptep into the parent ptep.

Should we add an smp_wmb() before updating the parent PTE to ensure the
child PTEs are fully visible first?

> +		else
> +			need_flush =3D true;
> =20
>  		current_level--;
>  	}

[ ... ]

> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index d69fba7d8e9a6..479f7e9bb8f81 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c

[ ... ]

> @@ -97,6 +97,60 @@ void kvm_riscv_mmu_iounmap(struct kvm *kvm, gpa_t gpa,=
 unsigned long size)
>  					    size >> PAGE_SHIFT);
>  }
> =20
> +static bool need_topup_split_caches_or_resched(struct kvm_mmu_memory_cac=
he *cache,
> +					       int count)
> +{
> +	if (need_resched())
> +		return true;
> +
> +	return kvm_mmu_memory_cache_nr_free_objects(cache) < count;
> +}
> +
> +static bool mmu_split_huge_pages(struct kvm_gstage *gstage,
> +				 phys_addr_t start, phys_addr_t end)
> +{
> +	struct kvm *kvm =3D gstage->kvm;
> +	struct kvm_mmu_memory_cache *pcache =3D &kvm->arch.pgd_split_page_cache;
> +	phys_addr_t addr =3D ALIGN(start, PMD_SIZE);
> +	phys_addr_t last_flush_gfn =3D addr >> PAGE_SHIFT;
> +	int count =3D gstage->pgd_levels;
> +	bool flush =3D false;
> +	int ret;
> +
> +	lockdep_assert_held_write(&kvm->mmu_lock);
> +
> +	while (addr < end) {
> +		if (need_topup_split_caches_or_resched(pcache, count)) {
> +			if (flush) {
> +				kvm_flush_remote_tlbs_range(kvm, last_flush_gfn,
> +					  (addr >> PAGE_SHIFT) - last_flush_gfn);
> +				last_flush_gfn =3D addr >> PAGE_SHIFT;
> +				flush =3D false;
> +			}
> +
> +			write_unlock(&kvm->mmu_lock);
> +			cond_resched();
> +
> +			ret =3D kvm_mmu_topup_memory_cache(pcache, count);

[Severity: Critical]
Does dropping mmu_lock here introduce a race with VM teardown?

If the VMM process terminates concurrently, mmu_notifier_release() could
trigger kvm_riscv_mmu_free_pgd(), which explicitly frees
kvm->arch.pgd_split_page_cache without taking mmu_lock.

Since we call kvm_mmu_topup_memory_cache() on this shared per-VM cache
without holding mmu_lock, could this lead to a use-after-free or memory
corruption on the cache objects array?

> +			if (ret) {
> +				kvm_err("Failed to toup split page cache\n");
> +				write_lock(&kvm->mmu_lock);
> +				return flush;
> +			}
> +			write_lock(&kvm->mmu_lock);
> +		}
> +

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623121332.7851=
4-1-wang.yechao255@zte.com.cn?part=3D2
