Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793220896;
	b=WyT7dwh2JpDhBahGPeJPeXZ4NQUQA2IHUGzgIcAhrocErMxtYmUGODo3YzywkjjFjLu5
	 eMSOvyA56hUCmt2lIYwnQYO/3YCfbfT67xni0wHrCTCfHu0DelH2HzWaQwwqNpPvJBl9I
	 dj1NqYBXkwhwleiBGyLWvcLBK6fAkcA0i+/2ZebCbZe7kNhWAd90rnXFH1wxGTS4T319H
	 s6CSwCJxQk/l/SCwu/XD80Y9bar28bv5GQj9mstGsmFNHwokDZ3I3xljRg88elTR83o9A
	 5RIuAAjyfu60+q6kxXfNH9QreTuloqDBFwLgwCaHzJDsCDrhn2Me44b9bzHCl8iaz5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793220896;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LuzkGWE3IQ4C4J3Zh6h1lNPjiX4Zd2TET46ifswf9tc=;
	b=guA2bFT2bPgtrJWI+JHQaI5aNo/7lHtmhfTct/PZXkYB9c9SblES6FxNX2qgUZuNqIRl
	 ++0tO+dTmMzQlx3VZ66wAw6YkPd6V0lMhWaH/Gt28WQ54iaa4ZgMgw7LWKMo9+LYERrC3
	 tmATTwSF2jBh+Ik26etPGWhL267OQxtUxCebjlu1dmVwPB3La7U3Y2J+kd9YPcHmzPp56
	 wsoUpOaYyrBjQPVTbHQ0pmYleKLq0N3KDEfedINjW6APxF4NcbHGy9JTZwqVAm809bdac
	 qQg5YdW0GaeITGYY0lBAYBbOqCnQ88Rsh8PE3o+YJwEqPyEm6qZ1TNfhI3FPkHz31VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EPhsqpip;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB73F606A31A
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 20:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EPhsqpip
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471311F01825;
	Wed, 28 Oct 2026 20:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793220895;
	bh=LuzkGWE3IQ4C4J3Zh6h1lNPjiX4Zd2TET46ifswf9tc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EPhsqpipNKuqxHrIrYn8otwJ5alaBgLeRsM7pHDfskV3x7emtr+Zf/J8wNNB5OJLC
	 Y1csezCsSTp34W9/niuqZZNUnMc05HgVuv3d3KtFJzETB4eEvHX0QzLHf6IQjFYDtj
	 pny1P9sMZ3s1BFCNM7KFnfCyLtvpE7lPJyiIRL2cWMcKwRIz1DZsdNQWeq4k2PEU/8
	 Vj9YjiAOtrZ/zRfInjVedvr441wc8kcSVGgOgJ29BK+yCAVfW29TbXE/4FXEODUktb
	 yUFNv8kEuv8T4klwU12EEd0M0+JCSBdCgAiWCXs/4SibM2/yqXGVnNLaEqq1AcLtBE
	 wY93fff7QnCLQ==
Message-ID: <sashiko-outbox-188454@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] KVM: x86/mmu: Use the generic auto-prefaulting to
 do prefetch for direct MMUs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261028202607.1844883-5-seanjc@google.com>
References: <20261028202607.1844883-1-seanjc@google.com>
 <20261028202607.1844883-5-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 20:54:54 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] kvm: x86/mmu: missing A/D-disabled check in kvm_mmu_auto_prefault(=
) path
- [High] KVM: x86/mmu: auto-prefault invokes error PFN side effects in kvm_=
handle_error_pfn()
- [Medium] KVM: x86/mmu: byte size passed to find_last_bit() in kvm_mmu_aut=
o_prefault()
- [Low] KVM: x86/mmu: lost PTE prefetching for nonpaging_page_fault() direc=
t MMU
--

commit 75be7201988159bdb81f00fdc35e700a7ee104b2
Author: Sean Christopherson <seanjc@google.com>

KVM: x86/mmu: Use the generic auto-prefaulting to do prefetch for direct MM=
Us

This commit removes the custom PTE prefetching path for direct shadow MMUs =
in
direct_map() and enables generic auto-prefaulting via kvm_mmu_auto_prefault=
()
for all direct MMUs using kvm_tdp_page_fault().

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index c56a2eaa46463..7f8beb1b307bf 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c

[ ... ]

> @@ -3301,33 +3301,6 @@ static void __direct_pte_prefetch(struct kvm_vcpu =
*vcpu,
>  		direct_pte_prefetch_many(vcpu, sp, start, spte);
>  }
> =20
> -static void direct_pte_prefetch(struct kvm_vcpu *vcpu, u64 *sptep)
> -{
> -	struct kvm_mmu_page *sp;
> -
> -	sp =3D sptep_to_sp(sptep);
> -
> -	/*
> -	 * Without accessed bits, there's no way to distinguish between
> -	 * actually accessed translations and prefetched, so disable pte
> -	 * prefetch if accessed bits aren't available.
> -	 */
> -	if (sp_ad_disabled(sp))
> -		return;

[Severity: High]
When hardware A/D bits are disabled (!kvm_ad_enabled), does switching from
direct_pte_prefetch() to kvm_mmu_auto_prefault() corrupt access tracking and
page aging on neighboring pages in the prefault window?

Previously, direct_pte_prefetch() checked sp_ad_disabled(sp) and skipped
prefetching when A/D bits were unavailable. With kvm_mmu_auto_prefault(), a
non-present or access-track page fault that returns RET_PF_FIXED triggers
auto-prefaulting across the aligned window via:

  kvm_mmu_auto_prefault()
    kvm_tdp_page_prefault(..., KVM_PREFETCH_AUTO, ...)
      kvm_mmu_do_page_fault()
        kvm_tdp_page_fault()
          direct_page_fault() / kvm_tdp_mmu_page_fault()
            fast_page_fault()

In page_fault_can_be_fast(), fault->prefetch is not checked:

  if (!fault->present)
          return !kvm_ad_enabled;

And in fast_page_fault(), any access-tracked SPTE in the prefault window
(whether installed by an earlier slow-path prefetch with
mark_spte_for_access_track() or aged by MMU notifiers via kvm_age_gfn()) has
its access permissions and shadow_accessed_mask restored:

  if (unlikely(!kvm_ad_enabled) && is_access_track_spte(spte))
          new_spte =3D restore_acc_track_spte(new_spte) |
                     shadow_accessed_mask;

This marks unaccessed neighboring pages as accessed, breaking kvm_age_gfn()
and kvm_test_age_gfn(). Should kvm_mmu_auto_prefault() bail out when
!kvm_ad_enabled (and should page_fault_can_be_fast() also reject
fault->prefetch when !fault->present)?

[ ... ]

> @@ -3594,13 +3567,8 @@ static int direct_map(struct kvm_vcpu *vcpu, struc=
t kvm_page_fault *fault)
>  	if (KVM_BUG_ON(it.level !=3D fault->goal_level, vcpu->kvm))
>  		return -EIO;
> =20
> -	ret =3D mmu_set_spte(vcpu, fault->slot, it.sptep, access,
> -			   base_gfn, fault->pfn, fault);
> -	if (ret =3D=3D RET_PF_SPURIOUS)
> -		return ret;
> -
> -	direct_pte_prefetch(vcpu, it.sptep);
> -	return ret;
> +	return mmu_set_spte(vcpu, fault->slot, it.sptep, access, base_gfn,
> +			    fault->pfn, fault);
>  }

[Severity: Low]
Is it intentional that non-paging direct shadow MMUs (when !tdp_enabled and
the guest runs with CR0.PG =3D 0) lose PTE prefetching here?

When paging is disabled under shadow paging, nonpaging_init_context() sets
vcpu->arch.mmu->page_fault =3D nonpaging_page_fault with root_role.direct =
=3D 1,
which faults through:

  nonpaging_page_fault()
    direct_page_fault()
      direct_map()

Removing direct_pte_prefetch() from direct_map() drops prefetching on this
path, while kvm_mmu_auto_prefault() and kvm_tdp_page_prefault() both check:

  if (vcpu->arch.mmu->page_fault !=3D kvm_tdp_page_fault)

and skip auto-prefaulting for nonpaging_page_fault().

> @@ -6685,7 +6653,7 @@ static void kvm_mmu_auto_prefault(struct kvm_vcpu *=
vcpu, gpa_t start,
>  	if (error_code & (PFERR_RSVD_MASK | PFERR_PRESENT_MASK))
>  		return;
> =20
> -	if (!tdp_mmu_enabled || vcpu->arch.mmu->page_fault !=3D kvm_tdp_page_fa=
ult)
> +	if (vcpu->arch.mmu->page_fault !=3D kvm_tdp_page_fault)
>  		return;
> =20
>  	nr_pages =3D min(nr_pages, KVM_PAGES_PER_HPAGE(PG_LEVEL_1G));

[Severity: High]
Can speculative prefaulting in kvm_mmu_auto_prefault() trigger unintended
fault-exit and signal side effects in kvm_handle_error_pfn() when a
neighboring unaccessed page cannot be resolved?

Unlike direct_pte_prefetch(), which used get_user_pages_fast_only() and
silently stopped on unmapped or poisoned neighboring pages,
kvm_mmu_auto_prefault() runs full fault handling with KVM_PREFETCH_AUTO
(fault->auto_prefetch =3D true) via:

  kvm_mmu_auto_prefault()
    kvm_tdp_page_prefault()
      kvm_mmu_do_page_fault()
        kvm_tdp_page_fault()
          direct_page_fault() / kvm_tdp_mmu_page_fault()
            kvm_mmu_faultin_pfn()

In __kvm_mmu_faultin_pfn(), if __kvm_faultin_pfn() with FOLL_NOWAIT returns
KVM_PFN_ERR_NEEDS_IO (for example, when a neighboring page is not yet fault=
ed
into the host MM or is swapped out):

  if (fault->pfn !=3D KVM_PFN_ERR_NEEDS_IO || fault->auto_prefetch)
          return RET_PF_CONTINUE;

this returns RET_PF_CONTINUE with fault->pfn still set to
KVM_PFN_ERR_NEEDS_IO, so kvm_mmu_faultin_pfn() sees is_error_pfn(fault->pfn)
and calls kvm_handle_error_pfn():

  static int kvm_handle_error_pfn(struct kvm_vcpu *vcpu,
                                  struct kvm_page_fault *fault)
  {
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

This leads to three issues on speculative prefaults:

1. For KVM_PFN_ERR_NEEDS_IO or KVM_PFN_ERR_FAULT (as well as private/shared
   attribute mismatches or kvm_mmu_faultin_pfn_gmem() errors in
   kvm_mmu_faultin_pfn()), kvm_mmu_prepare_memory_fault_exit() overwrites
   vcpu->run->exit_reason =3D KVM_EXIT_MEMORY_FAULT and vcpu->run->memory_f=
ault
   for an unaccessed GPA while kvm_mmu_page_fault() still returns
   RET_PF_FIXED (1) to vcpu_run().

2. If an unaccessed neighboring page is poisoned (KVM_PFN_ERR_HWPOISON),
   kvm_handle_error_pfn() sends a synchronous BUS_MCEERR_AR SIGBUS to curre=
nt
   and returns RET_PF_RETRY. If SIGBUS is unblocked, userspace receives an
   action-required MCE signal for a page the guest never touched; if SIGBUS=
 is
   masked or ignored, signal_pending(current) remains false and the retry l=
oop
   in kvm_tdp_page_prefault():

     do {
             ...
             r =3D kvm_mmu_do_page_fault(vcpu, gpa, error_code, prefetch, N=
ULL,
                                       level);
     } while (r =3D=3D RET_PF_RETRY);

   spins indefinitely.

3. For KVM_PFN_ERR_SIGPENDING, kvm_handle_signal_exit() increments
   vcpu->stat.signal_exits during the prefault before vcpu_run() handles the
   pending signal and increments vcpu->stat.signal_exits a second time.

[Severity: Medium]
Also in kvm_mmu_auto_prefault(), right below this hunk:

  nr_pages =3D min(nr_pages, KVM_PAGES_PER_HPAGE(PG_LEVEL_1G));
  if (KVM_PAGES_PER_HPAGE(level) >=3D nr_pages)
          return;

  nr_pages_msb =3D find_last_bit((unsigned long *)&nr_pages, sizeof(nr_page=
s));

  start =3D ALIGN_DOWN(start, gfn_to_gpa(BIT_ULL(nr_pages_msb)));

doesn't find_last_bit() expect its size argument in bits rather than bytes?

Because sizeof(nr_pages) is 8, find_last_bit() only inspects bits 0..7:

  if (small_const_nbits(size)) {
          unsigned long val =3D *addr & GENMASK(size - 1, 0);

          return val ? __fls(val) : size;
  }

When auto_prefault_nr_pages is set to 256 or larger (up to
KVM_PAGES_PER_HPAGE(PG_LEVEL_1G)), bits 8 and above are masked off, returni=
ng
8 when the low byte is zero (or a bit index in 0..7 if any low bit is set)
and misaligning start. In addition, removing !tdp_mmu_enabled exposes this
(unsigned long *)&nr_pages cast on CONFIG_X86_32 where unsigned long is 32
bits while gfn_t is 64 bits. Would fls64(nr_pages) - 1 (or __fls(nr_pages))
avoid both issues?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028202607.1844=
883-1-seanjc@google.com?part=3D4
