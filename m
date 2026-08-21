Received: from mta0.migadu.com (out-211.mta0.migadu.com [91.218.175.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BBC42B74B
	for <kvm@vger.kernel.org>; Fri, 21 Aug 2026 08:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787299761; cv=none; b=WzghcknJpHqWhTBguHCzm86nrYLBmesudPUqNTeTTSJAALxx3scYGkEO/ABZTWXV6WzaNvxV+IgQcbaYrYifoW8U4byotrvOW+FosgwxcEMN/N6/DAfsAj/SdzhpD2bLqYj7YZezCjigEjj3Pm8lMvRgOhDlYHw0Rte9kvWzMyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787299761; c=relaxed/simple;
	bh=h371mzvxwW1xSmvYnjHzs8rAmg3ETzWHRE0GajpnGiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fdI7ALcr2N3pEMUeyaCLgZvnZ5SDbCz9wR1toROxTOc7hRE9UFfADLpTi9KLbfzLgAPjqqTxtL472K0wHWGyx1n3SonFJeTfbUtKKKtvkRIUS+Ue+4a2amqjYkalCc1ZLE8OdettlEZ49kDlaMHXhdpU4HdbEP9eGBzdAne7WPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F2FtUDPL; arc=none smtp.client-ip=91.218.175.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F2FtUDPL"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=h371mzvxwW1xSmvYnjHzs8rAmg3ETzWHRE0GajpnGiw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787299757; v=1; x=1787904557;
 b=F2FtUDPLeMw9/z538p5GS3HU1IdZUBpsy2+S+u/I3NjqZRSaALBOwLIchuabEooQwUYR2n+b
 W7n/25ylQsyN5+Oz5zrkm80g+EjYBB4UgF9zQApHz7OWTrOhbbuDoGy8FDiultb9s9q+KzxNIej
 oiWu4LhIx6i6sYtOii0zst/o=
X-Envelope-To: kvm@vger.kernel.org
Received: from mail-lf1-f53.google.com (209.85.167.53)
	by smtp.migadu.com with ESMTPS id 65d3a90e24010530;
	Fri, 21 Aug 2026 08:09:17 +0000
X-Mizu-Trace-ID: 65d3a90e24010530
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b2a73da7e1so7327e87.0
        for <kvm@vger.kernel.org>; Fri, 21 Aug 2026 01:09:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqbKkJNnwZl6zchiMPpPuB1UzZAh8QPfJet2lH2MKrgS7feT3iajZxwhhArq6t1p/i4Q4U=@vger.kernel.org
X-Gm-Message-State: AFuF++l+9V2HwlxfL//ZjAw1Fabj2q95Au6NZ+Bqi1SxbZc9u50gkjl0
	303RGIcfZjusrq7vxnX7wa4/v7/OYZ8HcuY050yb6QQyGoF4LbrNy5ghm467daRxW8vF0L5koZg
	EB9pLTZdbJOxabsQPbTWg2TNOyjCPj2brNB2sr7bQ
X-Received: by 2002:a05:6512:3049:b0:5ae:a4e8:47be with SMTP id
 2adb3069b0e04-5b484abeb3amr138241e87.7.1787299752341; Fri, 21 Aug 2026
 01:09:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820-gmem-no-return-page-v3-0-3bf8f80a7b4d@google.com> <20260820-gmem-no-return-page-v3-4-3bf8f80a7b4d@google.com>
In-Reply-To: <20260820-gmem-no-return-page-v3-4-3bf8f80a7b4d@google.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Fri, 21 Aug 2026 09:08:36 +0100
X-Gmail-Original-Message-ID: <CA+EHjTy7H+W8jdBP8PGo5N=tQiAOJ-if4B0Coi41E5sPpu9tJA@mail.gmail.com>
X-Gm-Features: AcwNN1VmfPiMeck6-pqiLEgEGCVeqg50k8utetAYJRtPaMoYxxtu6kgioBnWdA4
Message-ID: <CA+EHjTy7H+W8jdBP8PGo5N=tQiAOJ-if4B0Coi41E5sPpu9tJA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] KVM: guest_memfd: Stop returning struct page from
 PFN lookup
To: Ackerley Tng <ackerleytng@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Brijesh Singh <brijesh.singh@amd.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, David Hildenbrand <david@kernel.org>, Yan Zhao <yan.y.zhao@intel.com>, 
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, Vishal Annapurve <vannapurve@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Aug 2026 at 00:32, Ackerley Tng <ackerleytng@google.com> wrote:
>
> From: Sean Christopherson <seanjc@google.com>
>
> KVM currently expects guest_memfd PFN lookups to return a refcounted struct
> page, which callers hold across fault handling.
>
> Drop the page's refcount before returning from kvm_gmem_get_pfn() to
> prepare for the in-place conversions series.
>
> CoCo shared-to-private conversion handling must inspect folio refcounts to
> ensure exclusive ownership by guest_memfd. A concurrent guest page fault
> taking a temporary reference on the folio causes conversions to fail due to
> an elevated refcount.
>
> While this refcount is also taken on host userspace page faults, that
> refcount is taken on behalf of the host userspace page tables. This
> refcount will be dropped when conversions unmaps the page. Either way, once
> there's an mmap() or userspace mapping, the pages are open to way more
> refcounts, transient or not. This patch focuses on just dropping refcounts
> before handing KVM a page.
>
> guest_memfd already notifies KVM of page invalidations, so callers within
> KVM only need to respect the MMU invalidation protocol to safely rely on
> guest_memfd for page presence.
>
> Since the page refcounts are dropped, don't return the struct page pointer.
>
> Not returning the struct page from the guest_memfd PFN lookup moves KVM
> closer toward supporting memory backends that are not backed by struct
> page.
>
> Here are some notes on the cleanup in the callers of kvm_gmem_get_pfn():
>
> kvm_release_faultin_page() in ARM's gmem_abort() originally also serves to
> set the page dirty and accessed under some conditions. The dirty and
> accessed flags don't matter for guest_memfd anyway, so it is safe to just
> drop the call to kvm_release_faultin_page().
>
> For ARM's kvm_translate_vncr(), the local page pointer must be initialized
> to NULL so that the shared cleanup path that releases faulted-in pages
> safely no-ops for guest_memfd.
>
> For x86, no additional changes are required in the MMU fault path because
> the page fault tracking structure is zero-initialized at the start of page
> fault handling, ensuring the refcounted page pointer is already NULL.
>
> Reported-by: Yan Zhao <yan.y.zhao@intel.com>
> Closes: https://lore.kernel.org/all/anZ4W9o5pTWIEgMY@yzhao56-desk.sh.intel.com/
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Co-developed-by: Yan Zhao <yan.y.zhao@intel.com>
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Reviewed-by: Michael Roth <michael.roth@amd.com>
> Tested-by: Michael Roth <michael.roth@amd.com>
> Tested-by: Yan Zhao <yan.y.zhao@intel.com>
> Co-developed-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

For the arm64 part: tested under QEMU: guest boots with anonymous
memory and guest_memfd, plus the guest_memfd_test selftest.

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Tested-by: Fuad Tabba < fuad.tabba@linux.dev>

Cheers,
/fuad


> ---
>  arch/arm64/kvm/mmu.c     | 4 +---
>  arch/arm64/kvm/nested.c  | 4 ++--
>  arch/x86/kvm/mmu/mmu.c   | 2 +-
>  arch/x86/kvm/svm/sev.c   | 8 ++------
>  include/linux/kvm_host.h | 6 ++----
>  virt/kvm/guest_memfd.c   | 9 ++-------
>  6 files changed, 10 insertions(+), 23 deletions(-)
>
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 6c941aaa10c63..d5aa197d2cbfd 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -1613,7 +1613,6 @@ static int gmem_abort(const struct kvm_s2_fault_desc *s2fd)
>         enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_R;
>         struct kvm_pgtable *pgt = s2fd->vcpu->arch.hw_mmu->pgt;
>         unsigned long mmu_seq;
> -       struct page *page;
>         struct kvm *kvm = s2fd->vcpu->kvm;
>         void *memcache = NULL;
>         kvm_pfn_t pfn;
> @@ -1641,7 +1640,7 @@ static int gmem_abort(const struct kvm_s2_fault_desc *s2fd)
>         /* Pairs with the smp_wmb() in kvm_mmu_invalidate_end(). */
>         smp_rmb();
>
> -       ret = kvm_gmem_get_pfn(kvm, s2fd->memslot, gfn, &pfn, &page, NULL);
> +       ret = kvm_gmem_get_pfn(kvm, s2fd->memslot, gfn, &pfn, NULL);
>         if (ret) {
>                 kvm_prepare_memory_fault_exit(s2fd->vcpu, s2fd->fault_ipa, PAGE_SIZE,
>                                               write_fault, exec_fault, false);
> @@ -1681,7 +1680,6 @@ static int gmem_abort(const struct kvm_s2_fault_desc *s2fd)
>         }
>
>  out_unlock:
> -       kvm_release_faultin_page(kvm, page, !!ret, prot & KVM_PGTABLE_PROT_W);
>         kvm_fault_unlock(kvm);
>
>         if ((prot & KVM_PGTABLE_PROT_W) && !ret)
> diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
> index fb54f6dad995c..43523bb17621a 100644
> --- a/arch/arm64/kvm/nested.c
> +++ b/arch/arm64/kvm/nested.c
> @@ -1360,7 +1360,7 @@ static int kvm_translate_vncr(struct kvm_vcpu *vcpu, bool *is_gmem)
>         bool write_fault, writable;
>         unsigned long mmu_seq;
>         struct vncr_tlb *vt;
> -       struct page *page;
> +       struct page *page = NULL;
>         u64 va, pfn, gfn;
>         int ret;
>
> @@ -1411,7 +1411,7 @@ static int kvm_translate_vncr(struct kvm_vcpu *vcpu, bool *is_gmem)
>                 if (is_error_noslot_pfn(pfn) || (write_fault && !writable))
>                         return -EFAULT;
>         } else {
> -               ret = kvm_gmem_get_pfn(vcpu->kvm, memslot, gfn, &pfn, &page, NULL);
> +               ret = kvm_gmem_get_pfn(vcpu->kvm, memslot, gfn, &pfn, NULL);
>                 if (ret) {
>                         kvm_prepare_memory_fault_exit(vcpu, vt->wr.pa, PAGE_SIZE,
>                                               write_fault, false, false);
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index c519e8e8d646f..129d403308051 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4604,7 +4604,7 @@ static int kvm_mmu_faultin_pfn_gmem(struct kvm_vcpu *vcpu,
>         }
>
>         r = kvm_gmem_get_pfn(vcpu->kvm, fault->slot, fault->gfn, &fault->pfn,
> -                            &fault->refcounted_page, &max_order);
> +                            &max_order);
>         if (r) {
>                 kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
>                 return r;
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 0375ef709ee2c..0c91c904573cc 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -4016,7 +4016,6 @@ static void __sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
>         struct kvm *kvm = vcpu->kvm;
>         gfn_t gfn = gpa_to_gfn(gpa);
>         unsigned long mmu_seq;
> -       struct page *page;
>         kvm_pfn_t pfn;
>
>         lockdep_assert_held(&svm->sev_es.snp_vmsa_mutex);
> @@ -4060,9 +4059,8 @@ static void __sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
>          * The new VMSA will be private memory guest memory, so retrieve the
>          * PFN from the gmem backend.
>          */
> -       if (kvm_gmem_get_pfn(vcpu->kvm, slot, gfn, &pfn, &page, NULL))
> +       if (kvm_gmem_get_pfn(vcpu->kvm, slot, gfn, &pfn, NULL))
>                 return;
> -       kvm_release_page_clean(page);
>
>         read_lock(&kvm->mmu_lock);
>         /*
> @@ -5003,7 +5001,6 @@ void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code)
>         struct kvm *kvm = vcpu->kvm;
>         int order, rmp_level, ret;
>         unsigned long mmu_seq;
> -       struct page *page;
>         bool assigned;
>         kvm_pfn_t pfn;
>         gfn_t gfn;
> @@ -5033,13 +5030,12 @@ void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code)
>         mmu_seq = kvm->mmu_invalidate_seq;
>         smp_rmb();
>
> -       ret = kvm_gmem_get_pfn(kvm, slot, gfn, &pfn, &page, &order);
> +       ret = kvm_gmem_get_pfn(kvm, slot, gfn, &pfn, &order);
>         if (ret) {
>                 pr_warn_ratelimited("SEV: Unexpected RMP fault, no backing page for private GPA 0x%llx\n",
>                                     gpa);
>                 return;
>         }
> -       kvm_release_page_unused(page);
>
>         ret = snp_lookup_rmpentry(pfn, &assigned, &rmp_level);
>         if (ret || !assigned) {
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 03bfc92864b6e..502465119ca0c 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2586,13 +2586,11 @@ static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
>
>  #ifdef CONFIG_KVM_GUEST_MEMFD
>  int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
> -                    gfn_t gfn, kvm_pfn_t *pfn, struct page **page,
> -                    int *max_order);
> +                    gfn_t gfn, kvm_pfn_t *pfn, int *max_order);
>  #else
>  static inline int kvm_gmem_get_pfn(struct kvm *kvm,
>                                    struct kvm_memory_slot *slot, gfn_t gfn,
> -                                  kvm_pfn_t *pfn, struct page **page,
> -                                  int *max_order)
> +                                  kvm_pfn_t *pfn, int *max_order)
>  {
>         KVM_BUG_ON(1, kvm);
>         return -EIO;
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index b596486d184ca..589762140c3ef 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -751,8 +751,7 @@ static struct folio *__kvm_gmem_get_pfn(struct file *file,
>  }
>
>  int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
> -                    gfn_t gfn, kvm_pfn_t *pfn, struct page **page,
> -                    int *max_order)
> +                    gfn_t gfn, kvm_pfn_t *pfn, int *max_order)
>  {
>         pgoff_t index = kvm_gmem_get_index(slot, gfn);
>         struct folio *folio;
> @@ -780,11 +779,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>  #endif
>
>         folio_unlock(folio);
> -
> -       if (!r)
> -               *page = folio_file_page(folio, index);
> -       else
> -               folio_put(folio);
> +       folio_put(folio);
>
>         return r;
>  }
>
> --
> 2.55.0.766.g2966f0265a-goog
>
