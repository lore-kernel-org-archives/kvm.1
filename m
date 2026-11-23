Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795415094;
	b=guAMmYDd5I4aQE4a6OwKLae2n9tI5efEvD6sZSof/8mYjGkcr/dbvapA6MpcpEecBuKA
	 1nzR5zlPnXpB04f4tcXhfjjrI3lWLyjzCENhiEcAleK7fyWTYOw07IEGVaM5R2NQwt0mE
	 bMNskdeLeQCW1h1O1dWAcdSB5U7QbysiWTN8fwh8O2cPWTApu6UXYCi7k1Asju5FV3Wcv
	 WD5mUYp0kLabeGgJntd9rxXJpBpWbanCzOptg8cVrPiwH95o7yyFkF55RCib0uLIc56oS
	 uT1g7WhkfddzpCVTiPbc4UnPHM2fpsYwJWQ9N5XdVrYRlnTIHH58RO1Qs25nxlIcbQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795415094;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aGCE8n21y7MgDX+w+Vjg5ztPIiM2B1P4mSL2EFDUFA0=;
	b=J/GuLUGg6wdO0vSk5ozFv5RsYrQARCQBwjF9/X3Dd4BeeRKA0+CkJQBkv6WExYDVI9et
	 u2CPlq0QmSbhUMKb4kri+ZnRo8fDQTaWGQKOErYAbdSS6w39inGcuNeI0bW9gJpTjSgfh
	 7a2ahKpSM6VlYoW/vOeI8vs8TaBH02JxpzdMuqGVpiXYn+UMeL8H6RSGBqxZyGhwrcBng
	 ycshwilWhKcd5Z1JeM02CI1dEr40t8pbHUNcrtxowg0BoX/PcrnvpasSa1J/k402V+A49
	 bqzpCBc8kUSzkIwV7z/hZlAvJIYiZrzAe6IF5vVzTA5l4k0RpB3qBL+NIxwDD4aA08A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=elISbiix;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C774F606A327
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 06:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=elISbiix
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0208A1F000CA;
	Mon, 23 Nov 2026 06:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795415094;
	bh=aGCE8n21y7MgDX+w+Vjg5ztPIiM2B1P4mSL2EFDUFA0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=elISbiixqiBnI/h6KD18FG+xZHM2wrBFZVk4OdVOVmnramqYdgsJDmxONoof/LI3U
	 DRExuz4WuXvb0azV3dNe4GUVAZ692nvnZpv+YOvcdOsFtJY2SeK+FoTRZ/3zUBtPTd
	 0nCY53EpoAOKzFIG9oRtQC2Wfee8HgPcQDCx4jap11kGsSr3GCxKSDfDFLpLKo2t2f
	 DtU2KFRSXgpV3plpW3U2pwwNuTjLnVGF+3F9bZoOvOS/dNh0j6trc9MsKD4LIqaBd1
	 Z2CEkCAvk+52mPD0LQUmFDwBiZoQD7JWLk7JjUjTR2bIAAGF/S+SVcNNUlcpAKDroD
	 wvSF6+TAKYb5w==
Message-ID: <sashiko-outbox-228763@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: riscv: Allow rescheduling during G-stage unmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Can Qi" <qican5708@163.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261123055036.1554937-1-qican5708@163.com>
References: <20261123055036.1554937-1-qican5708@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 06:24:53 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] KVM: riscv: redundant TLB flush after
  kvm_riscv_gstage_unmap_range() yield
--

commit 08865a8ca16cac26d3da38f3cc5232bb2fb890ba
Author: Can Qi <qican5708@163.com>

KVM: riscv: Allow rescheduling during G-stage unmap

This commit allows G-stage unmap walks to flush pending TLB invalidations
and yield mmu_lock when rescheduling is needed, and moves freeing of the
VM-owned split-page cache to kvm_arch_destroy_vm().

> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> index be70607a33ea0..ea7a156ec4f3f 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c
> @@ -423,9 +423,20 @@ bool kvm_riscv_gstage_unmap_range(struct kvm_gstage =
*gstage,
>  	bool found_leaf;
>  	unsigned long page_size;
>  	gpa_t addr =3D start, end =3D start + size;
> +	gfn_t last_flush_gfn =3D start >> PAGE_SHIFT;
>  	bool flush =3D false;
> +	bool pending_flush =3D false;
> +
> +	if (!(gstage->flags & KVM_GSTAGE_FLAGS_LOCAL))
> +		lockdep_assert_held_write(&gstage->kvm->mmu_lock);
> =20
>  	while (addr < end) {
> +		/* A concurrent teardown may have freed the root while unlocked. */
> +		if (!(gstage->flags & KVM_GSTAGE_FLAGS_LOCAL) &&
> +		    (!gstage->kvm->arch.pgd ||
> +		     gstage->pgd !=3D gstage->kvm->arch.pgd))
> +			break;
> +
>  		found_leaf =3D kvm_riscv_gstage_get_leaf(gstage, addr, &ptep, &ptep_le=
vel);
>  		ret =3D gstage_level_to_page_size(gstage, ptep_level, &page_size);
>  		if (ret)
> @@ -434,10 +445,11 @@ bool kvm_riscv_gstage_unmap_range(struct kvm_gstage=
 *gstage,
>  		if (!found_leaf) {
>  			addr =3D ALIGN(addr + 1, page_size);
>  		} else {
> -			if (!(addr & (page_size - 1)) && ((end - addr) >=3D page_size))
> -				flush |=3D kvm_riscv_gstage_op_pte(gstage, addr, ptep,
> +			if (!(addr & (page_size - 1)) && ((end - addr) >=3D page_size)) {
> +				pending_flush |=3D kvm_riscv_gstage_op_pte(gstage, addr, ptep,
>  								 ptep_level, GSTAGE_OP_CLEAR);
> -			else {
> +				flush |=3D pending_flush;
> +			} else {
>  				WARN_ONCE(1, "Skip unmap range addr: %#llx, end: %#llx, page_size: %=
#lx\n",
>  						addr, end, page_size);
>  			}
> @@ -448,9 +460,18 @@ bool kvm_riscv_gstage_unmap_range(struct kvm_gstage =
*gstage,
>  		/*
>  		 * If the range is too large, release the kvm->mmu_lock
>  		 * to prevent starvation and lockup detector warnings.
> +		 * Flush first so another invalidator cannot miss cleared PTEs.
>  		 */
> -		if (!(gstage->flags & KVM_GSTAGE_FLAGS_LOCAL) && may_block && addr < e=
nd)
> +		if (!(gstage->flags & KVM_GSTAGE_FLAGS_LOCAL) && may_block && addr < e=
nd &&
> +		    (need_resched() || rwlock_needbreak(&gstage->kvm->mmu_lock))) {
> +			if (pending_flush) {
> +				kvm_flush_remote_tlbs_range(gstage->kvm, last_flush_gfn,
> +							    (addr >> PAGE_SHIFT) - last_flush_gfn);
> +				pending_flush =3D false;
> +			}
> +			last_flush_gfn =3D addr >> PAGE_SHIFT;
>  			cond_resched_rwlock_write(&gstage->kvm->mmu_lock);
> +		}
>  	}
> =20
>  	return flush;

[Severity: Medium]
Should kvm_riscv_gstage_unmap_range() return pending_flush instead of
flush?

When the walk yields mmu_lock, it flushes the cleared PTEs in
[last_flush_gfn, addr >> PAGE_SHIFT) and resets pending_flush to false,
but flush stays latched to true.  Callers such as
kvm_arch_flush_shadow_memslot() and kvm_unmap_gfn_range() check the
return value to decide whether a post-walk TLB flush is needed, so they
will issue a redundant remote TLB shootdown across the entire range even
when all cleared PTEs were already flushed before yielding.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123055036.1554=
937-1-qican5708@163.com?part=3D1
