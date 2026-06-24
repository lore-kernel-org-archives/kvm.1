Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D8C32B9A1
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 08:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782290103; cv=none; b=LqAWMpoa8Oth4/wJrR5ZOD6jk87iB8PLlzV8+XwTjaCsui9LZsVIlPmDczCZ3r38NkNZtoFirS+U4YamhhVNCtqf1rP1Cn04DbvSj0RUfs/jBLyEc8/4bokOPUyJNYle/89sGcMeO6PIzkH06XdLJlN9GCxgoBlWaEE/Vc+nlu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782290103; c=relaxed/simple;
	bh=wF/d9/YZaRdPlKT75060De3bG3Czat0ejfHMPZn5/AE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cvheQ5LxgRGo4jrAe9bgDtgDH/blFZz1Ov0p2NcqGh3l+W4xHi8tleUZG9jqbavAvFLVEZ/i9IrSVqnwwQ1HgUDbl6WEhK9BGb56jyKt1M4yWrOkHRr0/FqnW0ebog+QTHdiT0XCazKE51ZhXXI90Pvrpcp4SQg/YdLNnRreCjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QyYoEPeR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyYoEPeR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23971F00A3D;
	Wed, 24 Jun 2026 08:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782290101;
	bh=d2+pzD8iNDT3Z16X0/IcAVWfFsXJPpvlOC4UiYH3BQI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QyYoEPeRTaEXR4UIzJn4xEfH7Ufoqt15kwkUEwRmY9APSjDrC3qrRkK0SaYTDsoJz
	 zLwuZsuHVraUs3vTW4vscgawqFcNAKEEJf+smJhcOc45yKrWTIrQBSBuHMRAh5o0O3
	 fN2broY5XASOuqbNS5BK12t5xn5LMiVIU15jK0bhzU7K/uYKnorKtE+8jl2XYltnc3
	 KReVTqhlwWchLo/AUmu4fSt00JMCQvPDokwK+6wKwaC0VgXUcqxgzABrlHp0uiaS9F
	 hgWLZiGBBvumF22kFBiE9eOOGP8EDUx5PE2WwfaIOnL6qcPj8TFzHXVv33qCe/NFTf
	 Y3JjObjuciEHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 RESEND 2/5] RISC-V: KVM: Split huge pages when dirty
 logging is enabled
Reply-To: sashiko-reviews@lists.linux.dev
To: wang.yechao255@zte.com.cn
Cc: kvm@vger.kernel.org
In-Reply-To: <20260624160756348x7b5SnXSw0CoFU0bMR692@zte.com.cn>
References: <20260624160054463wcDvJaMoydSggcNOWgcfB@zte.com.cn>
 <20260624160756348x7b5SnXSw0CoFU0bMR692@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 08:35:01 +0000
Message-Id: <20260624083501.B23971F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] `need_topup_split_caches_or_resched` fails to check `rwlock_needbr=
eak(&kvm->mmu_lock)`, causing lock starvation and latency spikes.
--

commit 10d6c81f6c350e7e0a1eeeb75389a0fa2b8dc5f8
Author: Wang Yechao <wang.yechao255@zte.com.cn>

RISC-V: KVM: Split huge pages when dirty logging is enabled

Eagerly split huge pages when enabling dirty logging to avoid faulting on
write-protected pages. This mirrors the approach taken on x86 and arm64
to improve guest performance.

> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 9cf69bc28b9c5..95e83c50addf5 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
[ ... ]
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

[Severity: High]
Does this code need to check rwlock_needbreak() to avoid lock starvation?

When mmu_split_huge_pages() iterates over a memslot with kvm->mmu_lock held
in write mode, preemption is disabled. The need_resched() check alone might
not capture lock contention on kvm->mmu_lock.

If there are no huge pages to split in the memslot, the memory cache will
never deplete. This means the loop could run over large amounts of memory
without ever yielding the lock.

Could this starve other vCPUs waiting to acquire kvm->mmu_lock in read mode?
Perhaps need_topup_split_caches_or_resched() should check
rwlock_needbreak(&kvm->mmu_lock) like other architectures do during eager
page splitting?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624160054463wc=
DvJaMoydSggcNOWgcfB@zte.com.cn?part=3D2
