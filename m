Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793221093;
	b=fw01SDVpehnfnNXj8qsrHV5yAxCcJOcH1sXwxceXxJ+xhWLUOyyRvWa9BWCzFalkzx4F
	 gVI4nX9fJKTZt5iGkWlparcch6N1I6qcRg8wRcikWq1E6+QtWzyfYA6vWSFxMhv4P2ZOm
	 qlbtZb1WKLmUPzi/G5rBzqZSvjxGrrkylMmdUD60k+dhajq14IAe7uD2EpGqbKeHGoAaq
	 LT+UBbskPYvVmgxHLmTgCr2UHIbgwgT79459tUiVU0g0bfiespjW6+QwWqxOWHxVLNqk6
	 tuvItZr5DdR/VRNTQoUhGczc/+/DR6gOeAsT98/zCkO1Tc+HZ7YaBpdzZEAXhRDLQew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793221093;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wHN8yJWFo5ydE6iIlHHKnzEjk114aZRUUPURK0Z8izw=;
	b=yyXMVEiOrfwS7Y6B/hF3GQ0RAwIeSfEtLx9FFY6If5T0/sLGFdmVLrdXqFi9/BLCh0iH
	 ygKMD8sdiRhujgQhxdCr4uZMNOhTSMK8hoPuhAyusuGB5JFYF5sxN+rZdEk5IetHaAQus
	 jAiyLrtceuJfzII4FcaDaE3hQxmfVFO1MhELKy7VJWqx675QroR0X9LNpVFyHIK7zLYim
	 xJ8MJND7teT4nxQtjzev+rxKxVdsJNi0QZsuyb6Dt8EVHxDHrEC9euvevlIxUrJvayPkh
	 mSeZWzZ8eUsgH5Zg9h+ukoA5ZQ+yBn6b0wKmMXBZ63gRWbenxUMmfPfDww1EVGTjklQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vd8pAb8p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B789606A31A
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 20:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vd8pAb8p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14411F01825;
	Wed, 28 Oct 2026 20:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793221093;
	bh=wHN8yJWFo5ydE6iIlHHKnzEjk114aZRUUPURK0Z8izw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vd8pAb8p0bRcPvYeqwUppXiV903a1e8Gm1bSwCJF6wMeY51PTZI4Plv3PGQVWgpwA
	 LOa5byKdyxqD46H5CDb7YChHBN75F+gJVsU9qyze4I76vFkUfIqF3/f7um8rr+bNlT
	 pRD/FLPUUNexCqpgzINldQK2Bvg+quhpve8b30wlGrKHss44MLFy/Y6AlKIWaMw3bd
	 uI7/8j4nU2PJVKf2mxiZs3vHQwFf0ru8t//wyLW3dIkNGmscyNAB/jDnW/xXWsA5b6
	 BK0wJzVrNaCIQfhE7emjBv2uIDz2lPLWO9BEtuB6L6vJJ/g6GZ7LN8LlUyafHdleAU
	 aPW8HYcHI97Pg==
Message-ID: <sashiko-outbox-188456@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] KVM: x86/mmu: Add automatic prefaulting/prefetching
 for TDP MMU faults
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261028202607.1844883-4-seanjc@google.com>
References: <20261028202607.1844883-1-seanjc@google.com>
 <20261028202607.1844883-4-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 20:58:12 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] kvm: x86/mmu: auto-prefetch error PFNs corrupt vcpu->run and send =
SIGBUS
- [High] KVM: x86/mmu: kvm_mmu_auto_prefault() can cross TDX direct bit bou=
ndary
- [Medium] kvm: x86/mmu: byte size passed to find_last_bit() in kvm_mmu_aut=
o_prefault()
- [Medium] KVM: x86/mmu: fast_page_fault() fixes access-tracked SPTEs on au=
to-prefault
- [Low] kvm: x86/mmu: undocumented auto_prefault_nr_pages module parameter
--

commit 94ac0d9a7745c32c548069768c848dd7ee814f18
Author: Sean Christopherson <seanjc@google.com>

KVM: x86/mmu: Add automatic prefaulting/prefetching for TDP MMU faults

This commit adds automatic prefaulting of surrounding SPTEs when handling T=
DP
MMU page faults by reusing the TDP MMU prefault path. It also introduces a
writable auto_prefault_nr_pages module parameter to control the number of
pages prefetched per fault.

Closes: https://lore.kernel.org/all/20260825140159.70997-1-mamarang@amazon.=
com

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 3bd0d921778df..c56a2eaa46463 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -122,8 +122,15 @@ static int max_huge_page_level __read_mostly;
>  static int tdp_root_level __read_mostly;
>  static int max_tdp_level __read_mostly;
> =20
> +/*
> + * The exact number of PTEs that can be prefetched for the shadow MMU, a=
nd the
> + * default number of pages to prefault/prefetch pages for the TDP MMU.
> + */
>  #define PTE_PREFETCH_NUM		8
> =20
> +static unsigned int __read_mostly auto_prefault_nr_pages =3D PTE_PREFETC=
H_NUM;
> +module_param(auto_prefault_nr_pages, uint, 0644);

[Severity: Low]
Should kvm.auto_prefault_nr_pages in arch/x86/kvm/mmu/mmu.c also be
documented in Documentation/admin-guide/kernel-parameters.txt alongside
other KVM x86 MMU parameters such as kvm.tdp_mmu and kvm.nx_huge_pages?

[ ... ]

> @@ -4709,10 +4716,12 @@ static int __kvm_mmu_faultin_pfn(struct kvm_vcpu =
*vcpu,
>  	/*
>  	 * If resolving the page failed because I/O is needed to fault-in the
>  	 * page, then either set up an asynchronous #PF to do the I/O, or if
> -	 * doing an async #PF isn't possible, retry with I/O allowed.  All
> -	 * other failures are terminal, i.e. retrying won't help.
> +	 * doing an async #PF isn't possible, retry with I/O allowed.  Never
> +	 * go down the slow I/O path for automatic prefetching, as the goal is
> +	 * for it to be light and fast.  All other failures are terminal, i.e.
> +	 * retrying won't help.
>  	 */
> -	if (fault->pfn !=3D KVM_PFN_ERR_NEEDS_IO)
> +	if (fault->pfn !=3D KVM_PFN_ERR_NEEDS_IO || fault->auto_prefetch)
>  		return RET_PF_CONTINUE;

[Severity: High]
Can returning RET_PF_CONTINUE from __kvm_mmu_faultin_pfn() when
fault->auto_prefetch is true and fault->pfn is an error PFN corrupt
vcpu->run or send a spurious SIGBUS for an unaccessed neighboring page?

When kvm_mmu_page_fault() fixes a demand fault and calls
kvm_mmu_auto_prefault(), the guest fault has already succeeded and
kvm_mmu_page_fault() will return RET_PF_FIXED so vcpu_run() continues
executing the guest:

arch/x86/kvm/mmu/mmu.c:kvm_mmu_page_fault()
  -> kvm_mmu_auto_prefault()
    -> kvm_tdp_page_prefault(..., KVM_PREFETCH_AUTO, ...)
      -> kvm_mmu_do_page_fault()
        -> kvm_tdp_page_fault()
          -> direct_page_fault()
            -> kvm_mmu_faultin_pfn()

In kvm_mmu_faultin_pfn(), returning RET_PF_CONTINUE with fault->pfn set to
KVM_PFN_ERR_NEEDS_IO (when FOLL_NOWAIT fails on a non-resident neighbor
page) or any other error PFN flows directly into kvm_handle_error_pfn():

arch/x86/kvm/mmu/mmu.c:kvm_mmu_faultin_pfn() {
	...
	if (fault->is_private !=3D kvm_is_private_gfn(kvm, fault->gfn)) {
		kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
		return -EFAULT;
	}
	...
	ret =3D __kvm_mmu_faultin_pfn(vcpu, fault);
	if (ret !=3D RET_PF_CONTINUE)
		return ret;

	if (unlikely(is_error_pfn(fault->pfn)))
		return kvm_handle_error_pfn(vcpu, fault);
}

And kvm_handle_error_pfn() performs side effects meant for fatal demand
faults:

arch/x86/kvm/mmu/mmu.c:kvm_handle_error_pfn() {
	if (is_sigpending_pfn(fault->pfn)) {
		kvm_handle_signal_exit(vcpu);
		return -EINTR;
	}
	...
	if (fault->pfn =3D=3D KVM_PFN_ERR_HWPOISON) {
		kvm_send_hwpoison_signal(fault->slot, fault->gfn);
		return RET_PF_RETRY;
	}

	kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
	return -EFAULT;
}

Specifically:

1. On KVM_PFN_ERR_NEEDS_IO, KVM_PFN_ERR_FAULT, a private/shared attribute
   mismatch in kvm_mmu_faultin_pfn(), or a kvm_mmu_faultin_pfn_gmem()
   failure, kvm_mmu_prepare_memory_fault_exit() overwrites
   vcpu->run->exit_reason with KVM_EXIT_MEMORY_FAULT and populates
   vcpu->run->memory_fault with the unaccessed neighbor GPA while guest
   execution continues.

2. If an unaccessed neighbor page in the prefetch window is hwpoisoned
   (KVM_PFN_ERR_HWPOISON), kvm_handle_error_pfn() sends a synchronous
   BUS_MCEERR_AR SIGBUS via kvm_send_hwpoison_signal() and returns
   RET_PF_RETRY, causing the do { ... } while (r =3D=3D RET_PF_RETRY) loop =
in
   kvm_tdp_page_prefault() to retry faulting the poisoned page in a loop if
   SIGBUS is masked or ignored.

3. If KVM_PFN_ERR_SIGPENDING is encountered during auto_prefetch,
   kvm_handle_signal_exit() sets KVM_EXIT_INTR and increments
   vcpu->stat.signal_exits before vcpu_run() exits and increments
   vcpu->stat.signal_exits a second time.

[ ... ]

> @@ -5072,6 +5081,18 @@ static int kvm_mmu_do_page_fault(struct kvm_vcpu *=
vcpu, gpa_t cr2_or_gpa,
>  		 */
>  		fault.gfn =3D gpa_to_gfn(fault.addr) & ~kvm_gfn_direct_bits(vcpu->kvm);
>  		fault.slot =3D kvm_vcpu_gfn_to_memslot(vcpu, fault.gfn);
> +
> +		if (fault.auto_prefetch) {
> +			r =3D kvm_check_memslot_usable_for_auto_prefetch(fault.slot, ACC_ALL);
> +			if (r)
> +				return r;
> +		}

[Severity: Medium]
When EPT A/D bits are disabled (!kvm_ad_enabled), won't auto-prefault still
enter fast_page_fault() on normal (non-dirty-logged) memslots and mark
already-present access-tracked SPTEs in the prefetch window as accessed?

When !kvm_ad_enabled, aged or prefetched SPTEs have their hardware RWX bits
cleared by mark_spte_for_access_track(). A subsequent guest access to an
access-tracked SPTE generates an EPT violation with exit_qualification RWX
protection bits equal to 0, so __vt_handle_ept_violation() leaves
PFERR_PRESENT_MASK clear in error_code.

After the demand fault is fixed, kvm_mmu_auto_prefault() runs because
PFERR_PRESENT_MASK is 0, and calls kvm_tdp_page_prefault() across the
prefetch window. In kvm_mmu_do_page_fault(),
kvm_check_memslot_usable_for_auto_prefetch() only rejects dirty-logged
memslots. On normal memslots, execution proceeds to kvm_tdp_page_fault() ->
fast_page_fault(), where page_fault_can_be_fast() allows !fault->present
faults when !kvm_ad_enabled:

arch/x86/kvm/mmu/mmu.c:page_fault_can_be_fast() {
	...
	if (!fault->present)
		return !kvm_ad_enabled;
	...
}

And fast_page_fault() restores access-tracked SPTEs and sets
shadow_accessed_mask (as well as PT_WRITABLE_MASK on write faults) without
checking fault->prefetch:

arch/x86/kvm/mmu/mmu.c:fast_page_fault() {
	...
		if (unlikely(!kvm_ad_enabled) && is_access_track_spte(spte))
			new_spte =3D restore_acc_track_spte(new_spte) |
				   shadow_accessed_mask;
	...
}

Whereas the slow path in tdp_mmu_map_handle_target_level() checks
fault->prefetch and returns RET_PF_SPURIOUS without modifying present SPTEs,
fast_page_fault() will mark unaccessed neighbor SPTEs as young (defeating
MMU notifier aging via kvm_age_gfn() / kvm_test_age_gfn()) and increment
vcpu->stat.pf_fast.

In addition, because fast_page_fault() does not update fault->goal_level
from sp->role.level, kvm_mmu_do_page_fault() writes PG_LEVEL_4K back to
*level even when an existing hugepage SPTE was encountered, and if a later
iteration in kvm_mmu_auto_prefault() faults in a 2M hugepage and raises
level back to PG_LEVEL_2M, i +=3D KVM_PAGES_PER_HPAGE(level) advances from =
an
unaligned i.

Should page_fault_can_be_fast() return false when fault->prefetch (or
fault->auto_prefetch) is set?

[ ... ]

> @@ -6654,11 +6675,44 @@ static int kvm_mmu_write_protect_fault(struct kvm=
_vcpu *vcpu, gpa_t cr2_or_gpa,
>  	return RET_PF_EMULATE;
>  }
> =20
> +static void kvm_mmu_auto_prefault(struct kvm_vcpu *vcpu, gpa_t start,
> +				  u64 error_code, u8 level)
> +{
> +	gfn_t nr_pages =3D READ_ONCE(auto_prefault_nr_pages);
> +	int nr_pages_msb;
> +	gfn_t i;
> +
> +	if (error_code & (PFERR_RSVD_MASK | PFERR_PRESENT_MASK))
> +		return;
> +
> +	if (!tdp_mmu_enabled || vcpu->arch.mmu->page_fault !=3D kvm_tdp_page_fa=
ult)
> +		return;
> +
> +	nr_pages =3D min(nr_pages, KVM_PAGES_PER_HPAGE(PG_LEVEL_1G));
> +	if (KVM_PAGES_PER_HPAGE(level) >=3D nr_pages)
> +		return;
> +
> +	nr_pages_msb =3D find_last_bit((unsigned long *)&nr_pages, sizeof(nr_pa=
ges));
> +
> +	start =3D ALIGN_DOWN(start, gfn_to_gpa(BIT_ULL(nr_pages_msb)));

[Severity: Medium]
Does find_last_bit() in kvm_mmu_auto_prefault() receive a byte size instead
of a bit count here?

In include/linux/find.h, find_last_bit() takes size in bits:

include/linux/find.h:find_last_bit() {
	if (small_const_nbits(size)) {
		unsigned long val =3D *addr & GENMASK(size - 1, 0);

		return val ? __fls(val) : size;
	}
	...
}

Because sizeof(nr_pages) is 8, find_last_bit() masks nr_pages with
GENMASK(7, 0) and ignores bits 8..63. Whenever auto_prefault_nr_pages is set
to 256 or larger (which is required for any 2MiB hugepage prefetching since
KVM_PAGES_PER_HPAGE(PG_LEVEL_2M) is 512), a power-of-two nr_pages has a zero
low byte and find_last_bit() returns 8 (aligning start down to 1MiB instead
of the window size), while a value like 513 returns 0 (aligning start down
only to 4KiB). Casting &nr_pages (u64 *) to unsigned long * also mismatches
the word size on 32-bit x86 builds.

Would using __fls(nr_pages) or rounddown_pow_of_two(nr_pages) directly on
nr_pages avoid both the byte-vs-bit issue and the pointer cast?

> +
> +	for (i =3D 0; i < nr_pages; i +=3D KVM_PAGES_PER_HPAGE(level)) {
> +		gpa_t gpa =3D start + gfn_to_gpa(i);
> +
> +		if (gpa < start || gpa_to_gfn(gpa) > kvm_mmu_max_gfn())
> +			return;
> +
> +		if (kvm_tdp_page_prefault(vcpu, gpa, error_code, KVM_PREFETCH_AUTO, &l=
evel))
> +			return;
> +	}
> +}

[Severity: High]
In a TDX VM, can this loop in kvm_mmu_auto_prefault() advance gpa across the
TDX direct bit boundary (kvm_gfn_direct_bits(vcpu->kvm)) while retaining the
original error_code, installing a private guest_memfd PFN into the shared
EPT root?

When nr_pages is not a power of two (for example, auto_prefault_nr_pages =
=3D 12,
where BIT_ULL(nr_pages_msb) is 8 < 12, or when nr_pages > 256 due to the
sizeof(nr_pages) limit above), start is aligned down to a smaller power of
two than nr_pages. If the guest takes a private EPT violation near the top
of the private GPA range (just below kvm_gfn_direct_bits(vcpu->kvm)), later
iterations of the loop advance gpa across the direct bit boundary so the
shared bit becomes set in gpa while error_code still has PFERR_PRIVATE_ACCE=
SS
set. Because kvm_mmu_max_gfn() covers the full host MAXPHYADDR,
gpa_to_gfn(gpa) > kvm_mmu_max_gfn() does not stop the loop.

Inside kvm_mmu_do_page_fault(), fault.gfn strips kvm_gfn_direct_bits()
(wrapping to GFN 0), while fault.is_private remains true and fault.addr
retains the shared direct bit:

arch/x86/kvm/mmu/mmu.c:kvm_mmu_do_page_fault()
  fault.gfn =3D gpa_to_gfn(fault.addr) & ~kvm_gfn_direct_bits(vcpu->kvm);

If GFN 0 is also private in kvm_is_private_gfn(), kvm_mmu_faultin_pfn()
resolves GFN 0's private guest_memfd PFN via kvm_mmu_faultin_pfn_gmem(),
but tdp_mmu_get_root_for_fault() inspects the unmasked fault->addr:

arch/x86/kvm/mmu/tdp_mmu.h:tdp_mmu_get_root_for_fault() {
	if (unlikely(!kvm_is_addr_direct(vcpu->kvm, fault->addr)))
		return root_to_sp(vcpu->arch.mmu->mirror_root_hpa);

	return root_to_sp(vcpu->arch.mmu->root.hpa);
}

Since fault->addr now has the direct bit set, tdp_mmu_get_root_for_fault()
returns the shared EPT root (root.hpa) and installs the non-refcounted
private guest_memfd PFN into the shared EPT tree, where KVM_FILTER_PRIVATE
invalidations (which only zap KVM_MIRROR_ROOTS on TDX) will not zap it when
the guest_memfd folio is freed or converted.

Should kvm_mmu_auto_prefault() bail out if gpa crosses a
kvm_gfn_direct_bits(vcpu->kvm) boundary relative to start?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028202607.1844=
883-1-seanjc@google.com?part=3D3
