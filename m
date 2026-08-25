Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F693845CB
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 14:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787667504; cv=none; b=undTOYSty+HGI1jFmFl0DMJS0DouoHtsoC/6cvTRwarpEurQTCQp7obtV1jXHWZk/8LrN7Imkv697KmNHV+iMNzgSJqVuWBQT0yur1FO+TR5O0E/WJ9kPDmgg5ANjOPbI7O+kUYYn4WsDOpglfUDBvJxIp4Su6JMwlmz8nGMgx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787667504; c=relaxed/simple;
	bh=pmxGwqDCRDvFLc9+5LU+Z0MAapnROT6iaAiLrBTEK3M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UNazxvSq5QarNjQ8FuL+A7BUWFwhdaBn1ix1BBCZzosUkrbs8qoAt/YgDlI6rCrMFt/6uLBcVscmrC4foXemfz5TZEFkYyoxUSFWPT/11YGKV2iCfshUHjvlpJva8FB5Ag3VsYFlVTFdjbsTNSYgYUWhWoASauKIxfqJ7Chc9nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKf3mgOJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKf3mgOJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3644B1F000E9;
	Tue, 25 Aug 2026 14:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787667502;
	bh=hpIcAeR4BgJdp8AXp3s9ynT488zfUsZEJYZ9BEE7GZo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mKf3mgOJQO/oSNrCON0Q4zF29lsJebXgAH202633pJMzlaYXsggHsa7KhPuxedEd4
	 pI0Bi7KBxAMQ7B+1UZGY+glswOrMJDA/K/nRNwtRLKkIjydqZiYKKU2bZ4PXgIy1cR
	 EwLze+a4ZbicOiqM8xTRhk+wiGyTcMmGyZfkod9XzmlyS7rLIR263xqMtvSK+dmQSY
	 6BEypzs6n+1hOnbmggAMlvEvQP/wXINJMiAnt23DfZ/fgMLCuX/nFUjKod4jcjUCQa
	 q2h3uwfKKQ5KcBWufir358COAknYQ6xQ+YefkMoW8xpeG2Vr0wBTCa6T8qBgAC1ybY
	 wGILSwZsdZIDQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC] KVM: x86/mmu: Prefetch forward run of pages on TDP page
 faults
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marco Marangoni" <mamarang@amazon.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260825140159.70997-1-mamarang@amazon.com>
References: <20260825140159.70997-1-mamarang@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 14:18:21 +0000
Message-Id: <20260825141822.3644B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Bypassing the mandatory MMU notifier retry protocol during pre=
fetch leads to a Use-After-Free of host pages.
- [High] Unconditional write privileges in prefetch cause unnecessary host =
Copy-On-Write and flood the KVM dirty ring.
--

--- Patch [1]: [RFC] KVM: x86/mmu: Prefetch forward run of pages on TDP pag=
e faults ---
commit e7ef47a2b5ba2806fbad91e89e8ac0b8f9cf602d
Author: Marco Marangoni <mamarang@amazon.com>

    KVM: x86/mmu: Prefetch forward run of pages on TDP page faults

This patch implements a fast GUP forward walk to prefetch up to 512
SPTEs (one guest 2MiB region) during a 4KiB page fault in the TDP MMU.
It aims to reduce EPT violations by resolving adjacent pages without
blocking, stopping at the first already-mapped SPTE or host hole.

> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
[ ... ]
> @@ -1209,6 +1209,99 @@ static int tdp_mmu_link_sp(struct kvm *kvm, struct=
 tdp_iter *iter,
>  static int tdp_mmu_split_huge_page(struct kvm *kvm, struct tdp_iter *ite=
r,
>  				   struct kvm_mmu_page *sp, bool shared);
> =20
> +/*
> + * Prefetch the forward run of host-present pages after the fault, withi=
n the
> + * faulting leaf table (512 pages).  One non-blocking GUP fills the empt=
y SPTEs.
> + * Forward only; capped at the first present SPTE and the first host hol=
e.
> + */
> +static void tdp_mmu_pte_prefetch(struct kvm_vcpu *vcpu,
> +				 struct kvm_page_fault *fault,
> +				 struct tdp_iter *iter)
> +{
> +	struct kvm_mmu_page *sp =3D sptep_to_sp(rcu_dereference(iter->sptep));
> +	struct page **pages =3D vcpu->arch.mmu_prefetch_pages;
> +	struct kvm_memory_slot *slot =3D fault->slot;
> +	unsigned int access =3D sp->role.access;
> +	bool host_writable =3D !(slot->flags & KVM_MEM_READONLY);

[Severity: High]
Does this code unconditionally request write privileges? Since host_writable
is based only on the slot flags, it seems to bypass the original fault inte=
nt
and whether dirty logging is active. When dirty logging is enabled, this
could result in make_spte() marking up to 511 unmodified pages as dirty,
which might flood the KVM dirty ring. Additionally, because the existing
kvm_prefetch_pages() helper unconditionally uses FOLL_WRITE, could this for=
ce
unnecessary host Copy-On-Write for pages the guest only intended to read?

> +	gfn_t start_gfn, slot_end;
> +	int start, count, nr, i;
> +
> +	if (sp_ad_disabled(sp))
> +		return;
> +
> +	/* Mirror (TDX) needs set_external_spte(); gmem pfns aren't in GUP's ta=
bles. */
> +	if (is_mirror_sp(sp) || kvm_slot_has_gmem(slot))
> +		return;
> +
> +	/* Racing invalidation may be stale.  No mmu_seq recheck: GUP is under =
the lock. */
> +	if (unlikely(vcpu->kvm->mmu_invalidate_in_progress))
> +		return;

[Severity: Critical]
Is it safe to bypass the mmu_invalidate_seq retry protocol here?

The TDP MMU operates with mmu_lock held in read mode, which allows
concurrent MMU notifiers like kvm_unmap_gfn_range() to run in parallel.
Could a concurrent host memory unmap free the physical page after
kvm_prefetch_pages() resolves the PFN?

[ ... ]
> +	/* Non-blocking GUP; stops at the first host hole. */
> +	nr =3D kvm_prefetch_pages(slot, start_gfn, pages, count);
> +	if (nr <=3D 0)
> +		return;
> +
> +	vcpu->stat.pf_prefetch_pages +=3D nr;
> +
> +	for (i =3D 0; i < nr; i++) {
> +		u64 *sptep =3D sp->spt + start + i;
> +		u64 old_spte =3D SHADOW_NONPRESENT_VALUE;
> +		gfn_t gfn =3D start_gfn + i;
> +		u64 new_spte;
> +
> +		make_spte(vcpu, sp, slot, access, gfn,
> +			  page_to_pfn(pages[i]), old_spte,
> +			  true /* prefetch */, false, host_writable, &new_spte);
> +
> +		/* cmpxchg from empty is the race check; present/MMIO/frozen fails it.=
 */
> +		if (try_cmpxchg64(sptep, &old_spte, new_spte)) {

[Severity: Critical]
If a concurrent host memory unmap happened during kvm_prefetch_pages(), cou=
ld
this cmpxchg install a valid, writable SPTE to a freed page since there is =
no
re-check of the invalidation sequence?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825140159.7099=
7-1-mamarang@amazon.com?part=3D1
