Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6C535A933
	for <kvm@vger.kernel.org>; Fri,  1 May 2026 21:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777671838; cv=pass; b=NynINxCMX2M9C1THNxfI2UVIURdrPz7kTe4+uTVSJvuYrntu0+no4YisJO1hNXZkthDy6BXuOWq0StukPebPPQxMNvPSu532R109yeU9C8rdh/iVgnVpmiStTWD4dU637dp25yHCbgeqoRFx9BWVAuceH4kkGppCfbR/k96ghKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777671838; c=relaxed/simple;
	bh=J31F2IGsDL1lItUw8x9z5MmepUpd4XF8uOGFHNBzs8U=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CHmBMz0ee0HU63UHz3OCc4CIKMo3mu+mmlthrDd4VRkHXJqM1YjbsxK8BqLal9vgYuUUZG3LCo217afyMwJvGznVn9wwa5bMCIOYLoKRauMbDn8r6rsvHnlWunYwQ68g+r+lOx/bRMcCR+yCibQvColqtJEVNVxaa1si+hkM1vM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wMoL+ZPI; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wMoL+ZPI"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a85b30cd4aso822987e87.0
        for <kvm@vger.kernel.org>; Fri, 01 May 2026 14:43:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777671835; cv=none;
        d=google.com; s=arc-20240605;
        b=gpM3lhMAmj8xrATRlBRebE4gQl/83rKFjwcyHVMgft3rArM9NcDUxEU4Ebo2YiWkff
         RGpU+DWHpOuA006BkSs7T8iINBYT6oVBNtykH42mPHnyg0xv7XTXgIJfM1zYqAsyyHTg
         cGh04mDZgRY98bLOxCr1zegNnOw4zkEczPWHhCWG0QpGinAs7m6JHLXRNOvoIR+6iuk0
         UuI4f4HOcXWek79wZggt+okezdgWasKq9Bwb+fSpyuCvAo4Dv67wTkhb2THSh1vj3G9M
         0GaDzHJ/eqLvZx2qeWuEkVtdwNDxvLj7j4n1/OKCv2rTVZ+I85KhyHFk1A3oKVEyE+ft
         6rNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=fO/jeTefxAw0x3EmSsD4uRtEDGCeTnThINv2cfQuSGU=;
        fh=MIMRWRsC22Zg/dR9N1rosnzuM26+SoYVLegPSG5+nWI=;
        b=FbwNvmb1Ahn5g3gTUFofpF036+V/XdJoubsVLhz+0A1lM51ta6+S2Smi7nNdpac+FD
         dwX6Z8a3ZkztHc8XJwnrwesl0ctusPjyWAZRM0PjbmdnswAdTBpl1l6LUp2jOWyDU7FG
         YeGtyHbTD68j9BECSolt14YxfdIfM35hNVpg4DZc7e/uDwtRK3rcZzeuspP9YNwsZlot
         Ad5kkY56fnEzCWJZqMOWDtJFfpu034gtJX2MK+LztTA7Ghq4DLUOjaF6egmjn4nPqRwA
         5O8kqleD+At304Tc1WlzRsloW2gcmTj7rZ7PwsDHW9BY6sTwdu9bOc3DrlY+uRobOSK0
         ne6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777671835; x=1778276635; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fO/jeTefxAw0x3EmSsD4uRtEDGCeTnThINv2cfQuSGU=;
        b=wMoL+ZPIjD1miTsCeUJ86jo5ZR+ANNoPCP5lsEOFWQrSinvFW25qS13buotgdVJH+T
         7oQLVvN17mB7eVLiyUPB4TMV4Dr+r6xT0HNjr59zXXqJMG7iaRcgylH3rhCWVkym6EIU
         3fpvB2wakypIvJcQRzadeImqHTzOdN9lYOyiu/9UE+56zjrllmY+vR7hFFtKUc50rdNx
         h+zUSeW4XUpqaEUXqhnUNiJOSN5nn57OZRjSco/f8NZqa1A3ygWySFHOzb1RcwXoZmBv
         iUVe4tFy8Etcito0Q+w4GNC13tDgL2WdtnFbXSjM4KbwfHq/p38Kzu2bsjpMJn63mx/Q
         Ycjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777671835; x=1778276635;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fO/jeTefxAw0x3EmSsD4uRtEDGCeTnThINv2cfQuSGU=;
        b=ZieWZ2Qxevmg0GiFqpZZ35YiKwKT60B8LqugJlTmkuTQmkjx/ns3PEWzFBsGxS67Mg
         At+sVWykdzYE57UqwEsy//AprHG7c64EiuNc0mHicqCsmmI3b5HnSSLsLHVF07mBR4R2
         7vbrI+OsbPMzxGeKsIR7uqFsk/XX6fso1Sgfy/+EYsd/CrhtfPdTW3fQX++uEC1GeoJU
         11WcsXiWQzz2ZR0ibItBF1Vs43R4NgAxW2IAXL2b33D8liUGQdIEk8mGp7zf6XgW0adL
         MN435YDYwehEe0tzpPu22iQFuUG8BRl/JoakXKl5OkW/wTru8C3kEbsBl40c4EuV7FcH
         gsWg==
X-Forwarded-Encrypted: i=1; AFNElJ/TcEW5yZGknnSEuwzBqe6CCEXWRLcZVyl+3F49bi8XSNP2xR8EwnPOKnoecqVKza0YA+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh9eYMudmdcCHUy9v1RoH/NsYgoxy1bPs3u0/Ds/cYtc5rRepj
	SNhF8sD1m6PnlNeyIKElygGdPrL2jLZWFJxjpR7l6v0tCfvTXaKDrXV3pc0IBOAtET3Dh+Q7fLS
	qofvZhuYXBkDpzDrxp0xwO6C8cfYj/sTE9eC+2zMuI+gPEmMJmqHDW6U1buo=
X-Gm-Gg: AeBDievBewdZLP0bwyq/riM6WQoQLaclEdr11UKebVoQLpTXhocFJOYB7mzuFrXtLH5
	bmyo3anPuERozN2ALCKN1sKMCYTkJVv3nsMUPe0UNJDGnvCAEXzznR8sZaH93HwgDzMyVTTAPLg
	BhTEklLp/RD+TPDk1jslJ4AiukiOajDMnCpGmPDHP6lyaSyRD/gfDhEPXm9HC8BLAj7kK8PGKlR
	kYPlD2nniZ2X1J+cDcDG3ZW6xC9+4Wtx2v8RE39o+m75Z6d4xbJZcD7yG5BO6b25zNHl2N48TDZ
	svnS/Tun6aqVq22Ef6rFjN1mlj+DNtGIw3t03ieQMr+s8nsg2TGNvGvCtmux16zUkq2dq5CN8/k
	dQfL5q40RBwzXOB0=
X-Received: by 2002:a05:6512:2390:b0:5a1:19c4:7a68 with SMTP id
 2adb3069b0e04-5a8631c26b4mr199082e87.36.1777671834299; Fri, 01 May 2026
 14:43:54 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 1 May 2026 14:43:52 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 1 May 2026 14:43:52 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260420154720.29012-6-itazur@amazon.com>
References: <20260420154720.29012-1-itazur@amazon.com> <20260420154720.29012-6-itazur@amazon.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 1 May 2026 14:43:52 -0700
X-Gm-Features: AVHnY4L8BkGxTTItv33mqWebeXHzIB0Hfkcgp2ER-Nu_MPjwRZto8h0tKqbF_pk
Message-ID: <CAEvNRgExV=jdtF4RVpUGJfNDDNAgVbFczRF9O61dPcVX4_5zuQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 5/7] KVM: pfncache: Invalidate on gmem invalidation
 and memattr updates
To: Takahiro Itazuri <itazur@amazon.com>, kvm@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Fuad Tabba <tabba@google.com>, 
	Brendan Jackman <jackmanb@google.com>, David Hildenbrand <david@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <pdurrant@amazon.com>, 
	Nikita Kalyazin <nikita.kalyazin@linux.dev>, Patrick Roy <patrick.roy@campus.lmu.de>, 
	Patrick Roy <patrick.roy@linux.dev>, Derek Manwaring <derekmn@amazon.com>, 
	Alina Cernea <acernea@amazon.com>, Michael Zoumboulakis <zoumboul@amazon.com>, 
	Takahiro Itazuri <zulinx86@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Takahiro Itazuri <itazur@amazon.com> writes:

>
> [...snip...]
>
> ---
>  virt/kvm/guest_memfd.c | 50 ++++++++++++++++++++++++++++++++++++++++++
>  virt/kvm/kvm_main.c    | 47 ++++++++++++++++++++++++++++++++++++++-
>  virt/kvm/pfncache.c    | 21 ++++++++++--------
>  3 files changed, 108 insertions(+), 10 deletions(-)
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 79f34dad0c2f..011fd205ac7e 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -215,6 +215,33 @@ static void __kvm_gmem_invalidate_start(struct gmem_file *f, pgoff_t start,
>  	struct kvm *kvm = f->kvm;
>  	unsigned long index;
>
> +	/*
> +	 * Prevent pfncaches from being activated / refreshed using stale PFN
> +	 * resolutions.  To invalidate pfncaches _before_ invalidating the
> +	 * secondary MMUs (i.e. without acquiring mmu_lock), pfncaches must use
> +	 * mn_active_invalidate_count instead of mmu_invalidate_in_progress.
> +	 */
> +	spin_lock(&kvm->mn_invalidate_lock);
> +	kvm->mn_active_invalidate_count++;
> +	spin_unlock(&kvm->mn_invalidate_lock);
> +

I think we should refactor this out into another function and reuse it
in kvm_mmu_notifier_invalidate_range_start().

> +	/*
> +	 * Invalidation of pfncaches must be done using a HVA range.  pfncaches
> +	 * can be either GPA-based or HVA-based, and all pfncaches store uhva
> +	 * while HVA-based pfncaches do not have gpa/memslot context.  Thus,
> +	 * using GFN ranges would miss invalidating HVA-based ones.
> +	 */
> +	xa_for_each_range(&f->bindings, index, slot, start, end - 1) {
> +		pgoff_t pgoff = slot->gmem.pgoff;
> +		gfn_t gfn_start = slot->base_gfn + max(pgoff, start) - pgoff;
> +		gfn_t gfn_end = slot->base_gfn + min(pgoff + slot->npages, end) - pgoff;
> +
> +		unsigned long hva_start = gfn_to_hva_memslot(slot, gfn_start);
> +		unsigned long hva_end = hva_start + (gfn_end - gfn_start) * PAGE_SIZE;
> +
> +		gpc_invalidate_hva_range_start(kvm, hva_start, hva_end);
> +	}
> +

Perhaps refactor this loop into another function? Or perhaps it's time
to refactor the xa_for_each_range()...

>  	xa_for_each_range(&f->bindings, index, slot, start, end - 1) {
>  		pgoff_t pgoff = slot->gmem.pgoff;
>
> @@ -259,12 +286,35 @@ static void __kvm_gmem_invalidate_end(struct gmem_file *f, pgoff_t start,
>  				      pgoff_t end)
>  {
>  	struct kvm *kvm = f->kvm;
> +	bool wake;
>
>  	if (xa_find(&f->bindings, &start, end - 1, XA_PRESENT)) {
>  		KVM_MMU_LOCK(kvm);
>  		kvm_mmu_invalidate_end(kvm);
>  		KVM_MMU_UNLOCK(kvm);
>  	}
> +
> +	/*
> +	 * This must be done after the increment of mmu_invalidate_seq and
> +	 * smp_wmb() in kvm_mmu_invalidate_end() to guarantee that
> +	 * gpc_invalidate_retry() observes either the old (non-zero)
> +	 * mn_active_invalidate_count or the new (incremented) mmu_invalidate_seq.
> +	 */
> +	spin_lock(&kvm->mn_invalidate_lock);
> +	if (!WARN_ON_ONCE(!kvm->mn_active_invalidate_count))
> +		kvm->mn_active_invalidate_count--;
> +	wake = !kvm->mn_active_invalidate_count;
> +	spin_unlock(&kvm->mn_invalidate_lock);
> +
> +	/*
> +	 * guest_memfd invalidation itself doesn't need to block active memslots
> +	 * swap as bindings updates are serialized by filemap_invalidate_lock().
> +	 * However, mn_active_invalidate_count is shared with the MMU notifier
> +	 * path, so the waiter must be woken when mn_active_invalidate_count
> +	 * drops to zero.
> +	 */
> +	if (wake)
> +		rcuwait_wake_up(&kvm->mn_memslots_update_rcuwait);
>  }

There could be some code reuse here too.

>
>  static void kvm_gmem_invalidate_end(struct inode *inode, pgoff_t start,
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index d64e70f8e8e3..b6d0a22fee79 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2583,9 +2583,11 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
>  		.on_lock = kvm_mmu_invalidate_end,
>  		.may_block = true,
>  	};
> +	struct kvm_memslots *slots = kvm_memslots(kvm);
> +	struct kvm_memory_slot *slot;
>  	unsigned long i;
>  	void *entry;
> -	int r = 0;
> +	int r = 0, bkt;
>
>  	entry = attributes ? xa_mk_value(attributes) : NULL;
>
> @@ -2609,6 +2611,34 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
>  		cond_resched();
>  	}
>
> +	/*
> +	 * Prevent pfncaches from being activated / refreshed using stale PFN
> +	 * resolutions.  To invalidate pfncaches _before_ invalidating the
> +	 * secondary MMUs (i.e. without acquiring mmu_lock), pfncaches must use
> +	 * mn_active_invalidate_count instead of mmu_invalidate_in_progress.
> +	 */
> +	spin_lock(&kvm->mn_invalidate_lock);
> +	kvm->mn_active_invalidate_count++;
> +	spin_unlock(&kvm->mn_invalidate_lock);
> +
> +	/*
> +	 * Invalidation of pfncaches must be done using a HVA range.  pfncaches
> +	 * can be either GPA-based or HVA-based, and all pfncaches store uhva
> +	 * while HVA-based pfncaches do not have gpa/memslot info.  Thus,
> +	 * using GFN ranges would miss invalidating HVA-based ones.
> +	 */
> +	kvm_for_each_memslot(slot, bkt, slots) {
> +		gfn_t gfn_start = max(start, slot->base_gfn);
> +		gfn_t gfn_end = min(end, slot->base_gfn + slot->npages);
> +
> +		if (gfn_start < gfn_end) {
> +			unsigned long hva_start = gfn_to_hva_memslot(slot, gfn_start);
> +			unsigned long hva_end = hva_start + (gfn_end - gfn_start) * PAGE_SIZE;
> +
> +			gpc_invalidate_hva_range_start(kvm, hva_start, hva_end);
> +		}
> +	}
> +

Can we reuse kvm_handle_gfn_range()?

>  	kvm_handle_gfn_range(kvm, &pre_set_range);
>
>  	for (i = start; i < end; i++) {
> @@ -2620,6 +2650,21 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
>
>  	kvm_handle_gfn_range(kvm, &post_set_range);
>
> +	/*
> +	 * This must be done after the increment of mmu_invalidate_seq and
> +	 * smp_wmb() in kvm_mmu_invalidate_end() to guarantee that
> +	 * gpc_invalidate_retry() observes either the old (non-zero)
> +	 * mn_active_invalidate_count or the new (incremented) mmu_invalidate_seq.
> +	 *
> +	 * mn_memslots_update_rcuwait does not need to be waked when
> +	 * mn_active_invalidate_count drops to zero because active memslots swap
> +	 * is also done while holding slots_lock.

I see that this invalidate count and waking stuff is done in
kvm_mmu_notifier_invalidate_range_end(), can that function be reused, or
maybe some refactoring will help here

> +	 */
> +	spin_lock(&kvm->mn_invalidate_lock);
> +	if (!WARN_ON_ONCE(!kvm->mn_active_invalidate_count))
> +		kvm->mn_active_invalidate_count--;
> +	spin_unlock(&kvm->mn_invalidate_lock);
> +
>  out_unlock:
>  	mutex_unlock(&kvm->slots_lock);
>
> diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
> index bb4ba3a1b3d9..0e7a0f64e14b 100644
> --- a/virt/kvm/pfncache.c
> +++ b/virt/kvm/pfncache.c
> @@ -144,7 +144,7 @@ static void gpc_unmap(kvm_pfn_t pfn, void *khva)
>  #endif
>  }
>
> -static inline bool mmu_notifier_retry_cache(struct kvm *kvm, unsigned long mmu_seq)
> +static inline bool gpc_invalidate_retry(struct kvm *kvm, unsigned long mmu_seq)

Perhaps this rename can be a separate patch. I think this could be set
up as some renaming/refactoring patches, then a separate patch for
calling those functions from gmem and kvm_vm_set_mem_attributes().

>
> [...snip...]
>
