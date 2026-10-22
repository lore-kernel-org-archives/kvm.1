Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792637477;
	b=UchLnMzn23eKqdIjlz9RRhZKwkn0oEsvAhLChq2O2sUjhe6gRRBaB3d4E4pym1Cmt+03
	 uDfsil54RLxwnYKakIEOr3b+6QUdFQ58Ts1ckWojAFS9onsv6uhjRWHPZzIgEBxyjA40e
	 vXuqHaODp2XRORI6Fqd0LaYnY9DscA59gAQzM0txSCKaCEN32GzRQv49MDw4w1LXgDWG+
	 Ly6LZV9e01A/XTbO1m23Rcc1BrLjSYIVqTao31DJ6kNiCKe5Mbh5Pwu480XtHos5tbM9h
	 HkGQTVqgOMeZHBfjnYa0NFf+78VPzaCPALGlQmlwI+STXcB4S6DRr8bRyJNSC5+A7ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792637477;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0iB/d7fIfVuq6R3fZv62sOSrHGFLxdqWRueSIgOaols=;
	b=3CqaAEc+fGbnjt4zE2yZBmaFk1Wq1yqvY0vtWLRBEewfPE7G4EGMXcNyUotvqtCo31wT
	 F0mVcx9TQHnXQ8IUUJgldpyZyFvDCIeD4BNm5/seYkIvKCKyQAHP0vluOKZU+G5dtqjf8
	 PPK5DnOmfOXB5kbZ9TWP4lIVda5hGt+rNGlPH4HIkgYU0kO99CZpgehQCAdAy39gFnjpN
	 egtt3qrGvwfCPjo+a+fjRUSyRo58mWr/J6/XogPJ1+GyRpkeNWU2C3/Aqm8jOrBQoc/Of
	 Y9mYGqu39vqGztaneVN152H4HXzoYAm2e0pCpmGykqgQ0b5dyk91Nb2qFBy59l/+W/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MCNEV7Mc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B9E606A319
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 02:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MCNEV7Mc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28CCB1F000C1;
	Thu, 22 Oct 2026 02:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792637476;
	bh=0iB/d7fIfVuq6R3fZv62sOSrHGFLxdqWRueSIgOaols=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MCNEV7Mcj8WLCXgcwJAiv8hOPGR4bi1Sk6S1EqpGSgIPgVq6Rwia9mSGXNFOksNvE
	 +f2Fkih6QwoY6gJnlI0D8RuLaNSii/mvXb+LoJGN5I46kzOyAMdaLJ3Bk+KjmV+lRE
	 DyEJoroh4bJWZh5HfJzHPYhlSkmZV3XpUdqI/N9bZBLDD6BFDiPn48ZGEy3cewExsD
	 fgp6g6VN3JIg5Vgh+pQ7SUd3pE1U6MUqRsNnAhCa/HqPxgizLnkqa3XT0KTIz0+V55
	 lpq272JIbH5uAy5X72uPss+YaoIDrNRFR8KkKi+ZcP0etsQHfV/UeKskPUHPQPm9hy
	 TkCUmqpw1Mqhw==
Message-ID: <sashiko-outbox-180886@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: x86/mmu: WARN and flush TLBs if TDP MMU replaces
 present SPTE with MMIO SPTE
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261022022209.300964-1-seanjc@google.com>
References: <20261022022209.300964-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 02:51:15 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] KVM: x86/mmu: tdp_mmu_map_handle_target_level() flushes untruncate=
d GFN on MMIO overwrite
--

commit 409b2fbe972da1945be9a64a0bcdab640e996156
Author: Sean Christopherson <seanjc@google.com>

KVM: x86/mmu: WARN and flush TLBs if TDP MMU replaces present SPTE with MMI=
O SPTE

This commit adds a warning and remote tlb flush in
tdp_mmu_map_handle_target_level() if a shadow-present spte is replaced with=
 a
non-shadow-present mmio spte due to gfn truncation or wrapping during the
page table walk.

Link: https://lore.kernel.org/all/20260219002241.2908563-1-seanjc@google.com

> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index 44dad106fad19..2735cbb212937 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -1151,6 +1151,7 @@ static int tdp_mmu_map_handle_target_level(struct k=
vm_vcpu *vcpu,
>  		return RET_PF_RETRY;
>  	else if (is_shadow_present_pte(iter->old_spte) &&
>  		 (!is_last_spte(iter->old_spte, iter->level) ||
> +		  WARN_ON_ONCE(!is_shadow_present_pte(new_spte)) ||
>  		  WARN_ON_ONCE(leaf_spte_change_needs_tlb_flush(iter->old_spte, new_sp=
te))))
>  		kvm_flush_remote_tlbs_gfn(vcpu->kvm, iter->gfn, iter->level);

[Severity: High]
When a shadow-present spte mapping a valid memslot gfn is overwritten with a
non-shadow-present mmio spte due to gfn truncation in the tdp iterator, does
flushing iter->gfn via kvm_flush_remote_tlbs_gfn() flush the wrong address
when range-based tlb invalidation is used?

Suppose a guest with a 4-level root first faults in a valid memslot at a
lower gfn (caching that translation in the tlb), and then triggers a fault =
on
an aliased gfn with upper bits set above the root level where fault->slot is
null.

During kvm_tdp_mmu_map(), tdp_iter_restart() and try_step_down() compute
iter->gfn via gfn_round_for_level():

arch/x86/kvm/mmu/mmu_internal.h:gfn_round_for_level() {
	return gfn & -KVM_PAGES_PER_HPAGE(level);
}

which only masks low bits below iter->level and retains the untruncated upp=
er
bits in iter->gfn. Meanwhile, tdp_iter_refresh_sptep() indexes the page tab=
le
by shifting and masking out the upper bits:

arch/x86/kvm/mmu/tdp_iter.c:tdp_iter_refresh_sptep() {
	iter->sptep =3D iter->pt_path[iter->level - 1] +
		SPTE_INDEX((iter->gfn | iter->gfn_bits) << PAGE_SHIFT, iter->level);
}

resolving iter->sptep to the existing spte for the lower gfn.

When tdp_mmu_map_handle_target_level() overwrites iter->old_spte with the
mmio spte and calls kvm_flush_remote_tlbs_gfn(vcpu->kvm, iter->gfn,
iter->level), it passes the untruncated faulting iter->gfn. In
kvm_flush_remote_tlbs_range():

virt/kvm/kvm_main.c:kvm_flush_remote_tlbs_range() {
	if (!kvm_arch_flush_remote_tlbs_range(kvm, gfn, nr_pages))
		return;
	...
	kvm_flush_remote_tlbs(kvm);
}

if range-based flushing is supported and succeeds (for example, via
hv_flush_remote_tlbs_range()), only the untruncated iter->gfn is invalidated
and kvm_flush_remote_tlbs() is skipped.

Because the spte is now a non-shadow-present mmio spte, subsequent mmu
notifier invalidations in tdp_mmu_zap_leafs() will skip it without flushing
tlbs, leaving the cached tlb entry for the original memslot gfn pointing to=
 a
host pfn that can be freed.

Should this path call kvm_flush_remote_tlbs(vcpu->kvm) (or mask iter->gfn to
the root's address space) when !is_shadow_present_pte(new_spte) triggers?

> =20
taker

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022022209.3009=
64-1-seanjc@google.com?part=3D1
