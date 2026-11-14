Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794671323;
	b=cK69Ra9zEZqX9+vCiqUr70em0+ttjxWUIeQe0t0IaD2HWD3szzY8Pgh7xIL6Mi2mt90q
	 x0UCYH8xLhvrqHVyzto6l9ohfxjcQNYpzCwCfPIwSXFV1QGwltndpg/APm7GJQatm2wU1
	 adOdQ75VjsyLvez53854W0eRfuQ5chwVGyLD/mkkMtolhbveMaF3zH9nJRiES9qIrO9Gl
	 Rtg0JfS5pDJoyu/MM1uwPcQ6HqG81V6YRDRkKav/OxFmeMBPmMAUb7CDPvvNkxUmAKmMA
	 f5876TIAAsWV+v/DtvlcGeMMpJVxFemHNucd/oEtVDIOaGJmwTWFZKJHludIbnjlfLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794671323;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=JmaPmls247RMxiNbh9yTGBP02WoOg6woXxKHoqe7rwM=;
	b=sFy/BRgXLURcMUu15P8NxrXZN1PJcsypuZNe5g83XjETT9R2rAGeWYn3qNLyDDQMwFNY
	 UWjwQu7AJmZSv7geAyaTy2CNE5UoCo7HP5bA0C9mDrza5wAK7OVq0jctYobSy76ScR7Ew
	 E2PqgCN4qw9KdX9p5/Je1yucViCYw46WP+FU47jmedHh5QOCYy4hc5OSJiAYymH5X8rly
	 bFsOuROg3qPbQVJzqsWWxrMwa19sraDtWwiAxX12uJoPgJNZEBeE79DLVvwNx2DjluCbE
	 O3Cy5IIlauA5zDpeCCtbMEizMCqOsfuSPLyRhY+rgrNMEpgQVngvqu2dSqjGpIquN5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XUo6X5vk;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825C7606A32D
	for <kvm@vger.kernel.org>; Sat, 14 Nov 2026 15:48:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 825C7606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XUo6X5vk
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b18165dc53so2903417a91.3
        for <kvm@vger.kernel.org>; Sat, 14 Nov 2026 07:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794671322; x=1795276122; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JmaPmls247RMxiNbh9yTGBP02WoOg6woXxKHoqe7rwM=;
        b=XUo6X5vkTHU/VnViw7N34xp+R/Ho90DDumY7KsO9yxTqgCxS6Y4WK5+jj2o+8dWIQd
         E1q5397Ddb3BvwM9BBnXi3WPpHgf9/fJTi0/CNxVeM6bEDwhdtjyrvIZzhYb0zD9PNdq
         5HqKTgSsOzxjW37leKEiCRgYZqsHsNQlFrwD0BJjCEVU5mzLiZcXS9F3foNOasW+MsEs
         0CJtmgWnWjy0swUk3Qhxhuebh3fvokQbdCHSWTkVzbhisk1LDnB/1pYs+5LPqYPo2Fh4
         NVYkx9Klq4WkIG7f4hkzIC1OzyKbJrn+LefXapkpYH3Y1dwunmp+CYwZs2wnd1RMxCAT
         nlBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794671322; x=1795276122;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JmaPmls247RMxiNbh9yTGBP02WoOg6woXxKHoqe7rwM=;
        b=XsAh+BeVuhap/LzrDqOSvk8f4cJXIIhXySu4H00X0IEG3m7Xgv3CJ2ROyfn1kN1OFa
         2Pt9+/FNF49HFm/7IP7jg1CCQs/QtA4AE4tC8z7WjPWGA82UScQfyMjh4uNA4Ovw7Sw7
         o7E8f+k8Jycmk5NpQNMTKpgpJeNqc64dAzJeUuPl8mLas/ha2u05Fva/Ng6RKXuM0tbg
         xqqxagWurYIXYIwizQKkLtd+SWesx+vrK6g81w+HDJokHfZgetmyctM0c2zBxE3FmPC8
         /w2A5HJmZxp8ue7QuswQnPz32cmHDoFD1QMzM2Oz7RCeujzwHHLV6onIUYaDQOunetCG
         fivw==
X-Forwarded-Encrypted: i=1; AL+hErG0yE/6JDMGf1cAwQPsouFtDdJ7yfQZaQ/Fz+IpxsR2u35XyiFj59RgrER6EkGt/Xdy3J0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ON8Y3itTRPNdpFalpvGpAek1ljqX5PWh8/dNZN4ytmVNj9okC
	uU/CktB9os+XiBWMLfdzWEnqx0ujIq9CwuDw9MNl44YCwsZizxt99V0vbfhMVj832eJufvQkvs9
	MhPptog==
X-Received: from pjyd3.prod.google.com ([2002:a17:90a:dfc3:b0:3b1:29ae:3c64])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4acb:b0:3a4:f75d:d194
 with SMTP id 98e67ed59e1d1-3b1b0a20d40mr6307606a91.36.1794671321759; Sat, 14
 Nov 2026 07:48:41 -0800 (PST)
Date: Sat, 14 Nov 2026 07:48:40 -0800
In-Reply-To: <avdAIMDfgL_wy1rx@gremlin>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113164000.467175-1-seanjc@google.com> <avdAIMDfgL_wy1rx@gremlin>
Message-ID: <aviC2OUjvNz_ubZr@google.com>
Subject: Re: [PATCH v3] KVM: Skip gfn-based MMU notifier invalidations for
 guest_memfd-only memslots
From: Sean Christopherson <seanjc@google.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>, Alexandru Elisei <alexandru.elisei@arm.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Nov 13, 2026, Lorenzo Stoakes (ARM) wrote:
> On Fri, Nov 13, 2026 at 08:40:00AM -0800, Sean Christopherson wrote:
> > From: Alexandru Elisei <alexandru.elisei@arm.com>
> >
> > Don't invalidate gmem-only memslots when responding to MMU notifier
> > invalidations, as the entire point of gmem-only memslots is so that KVM
> > doesn't need a VMA to install mappings into KVM's MMU.  Specifically,
> > page faults are resolved by going straight to guest_memfd, using the gfn
> > and the associated memslot's gmem.file.  I.e. whether or not userspace
> > happens to have valid mappings to the same gmem instance is irrelevant,
> > as are any invalidations for those mappings.
> >
> > Note!  The exception is KVM's gfn_to_pfn_cache implementation which isn't
> > yet wired up to pull pfns directly from guest_memfd, i.e. still relies on
> > userspace mappings/VMAs and thus need to be invalidated, e.g. to ensure KVM
> > doesn't retain a kernel mapping+pointer to PRIVATE memory.  However, as of
> > commit da260bcb56fe ("KVM: pfncache: use a dedicated invalidation sequence
> > for cache refresh"), GPC invalidation no longer relies on memslot lookups,
> > because GPCs also support HVA-based mappings.  I.e. KVM *must* be able to
> > detect and handle relevant MMU notifier invalidations even if there is *no*
> > memslot whatsoever.
> >
> > In addition to the obvious performance benefits, avoiding unnecessary and
> > spurious SPTE zaps and TLB flushes will allow KVM to support features like
> > ARM's Statistical Profiling Extension (SPE)[1] and x86's Secure AVIC[2],
> > both of which rely on the pages *never* being unmapped from the stage-2
> > page tables.
> >
> > Link: https://lore.kernel.org/all/20260903160623.315525-1-alexandru.elisei@arm.com [1]
> > Link: https://lore.kernel.org/all/cover.1783490022.git.naveen@kernel.org [2]
> > Cc: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > Cc: Naveen N Rao (AMD) <naveen@kernel.org>
> > Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > [sean: rewrite changelog to capture the new gpc behavior]
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> 
> Thanks a lot for this Sean + Alex! :)
> 
> Though, having local AI do a review pass on it flagged an issue (don't worry my
> own analysis - not pasting some slop here :).
> 
> I think actually this might need an additional change for x86, since it doesn't
> have a gmem-only check for the shadow MMU PTE prefetch:
> 
> direct_map()
>   -> direct_pte_prefetch()
>     -> __direct_pte_prefetch()
>       -> direct_pte_prefetch_many()
>         -> kvm_mmu_prefetch_sptes()
>           -> kvm_prefetch_pages()
>             -> get_user_pages_fast_only()
> 
> And a VMM that's doing something broken (i.e. trying to take advantage of this
> as a vulnerability), could then intentionally set up a gmem-only slot to point
> at ordinary anon memory, munmap(), and have a UAF on the underlying folio due to
> no MMU notifier invalidation.

Ya, Sashiko flagged this as well.  I was initially planning on adding the check
in kvm_mmu_prefetch_sptes(), but adding the check in kvm_prefetch_pages() is
better since the work-in-progress prefetching for x86's TDP MMU will share some
of the prefetching checks, but will go through the normal fault-in path instead
of using kvm_prefetch_pages().  The return should be -EINVAL or so though.

I'll send a patch on Monday.  Thanks much!

https://lore.kernel.org/all/sashiko-outbox-213282@kernel.org

> 
> Fix would be something like:
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index cf4cb586f140..76350dc55d8f 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -3172,6 +3172,9 @@ int kvm_prefetch_pages(struct kvm_memory_slot *slot, gfn_t gfn,
>  	unsigned long addr;
>  	gfn_t entry = 0;
> 
> +	if (kvm_memslot_is_gmem_only(slot))
> +		return 0;
> +
>  	addr = gfn_to_hva_many(slot, gfn, &entry);
>  	if (kvm_is_error_hva(addr))
>  		return -1;
> 
> > ---
> >
> > v3: v1, but with a different changelog.
> >
> > v2: https://lore.kernel.org/all/20260714160411.302386-1-alexandru.elisei@arm.com
> >
> > v1: https://lore.kernel.org/all/20260615155244.183044-1-alexandru.elisei@arm.com
> >
> >  virt/kvm/kvm_main.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index cf4cb586f140..599dea22afb8 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -601,6 +601,10 @@ static __always_inline kvm_mn_ret_t kvm_handle_hva_range(struct kvm *kvm,
> >  			unsigned long hva_start, hva_end;
> >
> >  			slot = container_of(node, struct kvm_memory_slot, hva_node[slots->node_idx]);
> > +
> > +			if (kvm_slot_has_gmem(slot) && kvm_memslot_is_gmem_only(slot))
> > +				continue;
> > +
> >  			hva_start = max_t(unsigned long, range->start, slot->userspace_addr);
> >  			hva_end = min_t(unsigned long, range->end,
> >  					slot->userspace_addr + (slot->npages << PAGE_SHIFT));
> >
> > base-commit: d21eef2084a9af87ac2a783bc7c2b175ba114e4e
> > --
> > 2.56.1.703.gf848ed807c-goog
> >
> 
> --
> Cheers, Lorenzo
