Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590730;
	b=woG8sohuP6LovfSzJeA7aouHhsmTYJE56kboK4s64FdHoekpSI4Ojj95lhHcqwNLKMxb
	 MC9QPxL6TyY22FmUByXM4GdLY4FGLmlSpUoBhNH0+F3NNEYt6c1nHGabD0P1L51rHCviY
	 qy3IZZK+pAaGgJUs25vabKhKP2GnPSa+yc33hvsVmEi2rc9iF3wtR5MGEzZajBtgui0sk
	 VBL6O2Y2Tye3YZAKlMIVwyibi6EWnTOgxRS03dUkNA0JJE/oPMv3XDf0F68B0ILTthXZf
	 LhkIRn0qHNoOHQSd8DJNaNyPuFDD8fFntHgyY+xlxl/1QdxcuM0zqWhwiAYDuHLtryw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590730;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=VRqhLiYHA083I8w4qSXLatZbskX7q7uO1NskiBll704=;
	b=Sqqf3DDrgdUpUVe7T4lWQjD7S36Yse9jMqBa3p4XnZ8MQZDN8+Y1Fbw0XfWyVho8s3M0
	 peG4KQ785t6zkkpbBWDgYrAPj3sj6KMEikuc/l1qdEOwaQBC475CQ4XcNMRaJUFJIDjUm
	 ekcSlbkl3MojxSp+an0i23OqD8AfbsblqOYMNBFxDkPTjTrSlVGyRbi/IFMZ0fHPcWybE
	 fuNYvpw79+XnAdgA/gdTx2FXcGWLgff3gQIRtI2oVihJyqNGu19bJDt7grOQvF2NTEOig
	 8RtHM7WxbmV9eICJPPcoxUf2CNa6lmyhzfSyzp8dRtzFm9ziRbtqQM4Jn1eHSKlMw+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ImJrxHwd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2126079D59;
	Fri, 13 Nov 2026 17:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ImJrxHwd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F341F000C6;
	Fri, 13 Nov 2026 17:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794590730;
	bh=VRqhLiYHA083I8w4qSXLatZbskX7q7uO1NskiBll704=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ImJrxHwdNrhLT5bylFtSH+Fg7WpJTgmnwoCPTohUvCmUP3+ePCW9xSIvHDDN9WGED
	 zd7lfgp7amQt4qqLuACiSYR0B2nXo1Ad1bd2UvWAGuCVfmuXu/CTihfec9DSOt9yi6
	 GZ3SryYXGrf4ks+aOi+8qhORfqQgyJfuAakF0TkNeu6/SKs2UeV/f7S5O1rvsW43Mz
	 Dt9hYKXQTeLsqzPeZqC+POuqiTPq/HYwmgTwueE8IhCMqa0Syr8OKGmeUP03npQ0BB
	 YzLVM/T1cX7ZfCxwMsTGGa9sPv38d/C7h5VW39OHedaRJMVJOK4qu5u/XFWOtzvL+k
	 ByxaYy/XJso+g==
Date: Fri, 13 Nov 2026 17:25:25 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Naveen N Rao <naveen@kernel.org>, 
	Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [PATCH v3] KVM: Skip gfn-based MMU notifier invalidations for
 guest_memfd-only memslots
Message-ID: <avdAIMDfgL_wy1rx@gremlin>
References: <20261113164000.467175-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113164000.467175-1-seanjc@google.com>

On Fri, Nov 13, 2026 at 08:40:00AM -0800, Sean Christopherson wrote:
> From: Alexandru Elisei <alexandru.elisei@arm.com>
>
> Don't invalidate gmem-only memslots when responding to MMU notifier
> invalidations, as the entire point of gmem-only memslots is so that KVM
> doesn't need a VMA to install mappings into KVM's MMU.  Specifically,
> page faults are resolved by going straight to guest_memfd, using the gfn
> and the associated memslot's gmem.file.  I.e. whether or not userspace
> happens to have valid mappings to the same gmem instance is irrelevant,
> as are any invalidations for those mappings.
>
> Note!  The exception is KVM's gfn_to_pfn_cache implementation which isn't
> yet wired up to pull pfns directly from guest_memfd, i.e. still relies on
> userspace mappings/VMAs and thus need to be invalidated, e.g. to ensure KVM
> doesn't retain a kernel mapping+pointer to PRIVATE memory.  However, as of
> commit da260bcb56fe ("KVM: pfncache: use a dedicated invalidation sequence
> for cache refresh"), GPC invalidation no longer relies on memslot lookups,
> because GPCs also support HVA-based mappings.  I.e. KVM *must* be able to
> detect and handle relevant MMU notifier invalidations even if there is *no*
> memslot whatsoever.
>
> In addition to the obvious performance benefits, avoiding unnecessary and
> spurious SPTE zaps and TLB flushes will allow KVM to support features like
> ARM's Statistical Profiling Extension (SPE)[1] and x86's Secure AVIC[2],
> both of which rely on the pages *never* being unmapped from the stage-2
> page tables.
>
> Link: https://lore.kernel.org/all/20260903160623.315525-1-alexandru.elisei@arm.com [1]
> Link: https://lore.kernel.org/all/cover.1783490022.git.naveen@kernel.org [2]
> Cc: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Cc: Naveen N Rao (AMD) <naveen@kernel.org>
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> [sean: rewrite changelog to capture the new gpc behavior]
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Thanks a lot for this Sean + Alex! :)

Though, having local AI do a review pass on it flagged an issue (don't worry my
own analysis - not pasting some slop here :).

I think actually this might need an additional change for x86, since it doesn't
have a gmem-only check for the shadow MMU PTE prefetch:

direct_map()
  -> direct_pte_prefetch()
    -> __direct_pte_prefetch()
      -> direct_pte_prefetch_many()
        -> kvm_mmu_prefetch_sptes()
          -> kvm_prefetch_pages()
            -> get_user_pages_fast_only()

And a VMM that's doing something broken (i.e. trying to take advantage of this
as a vulnerability), could then intentionally set up a gmem-only slot to point
at ordinary anon memory, munmap(), and have a UAF on the underlying folio due to
no MMU notifier invalidation.

Fix would be something like:

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index cf4cb586f140..76350dc55d8f 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3172,6 +3172,9 @@ int kvm_prefetch_pages(struct kvm_memory_slot *slot, gfn_t gfn,
 	unsigned long addr;
 	gfn_t entry = 0;

+	if (kvm_memslot_is_gmem_only(slot))
+		return 0;
+
 	addr = gfn_to_hva_many(slot, gfn, &entry);
 	if (kvm_is_error_hva(addr))
 		return -1;

> ---
>
> v3: v1, but with a different changelog.
>
> v2: https://lore.kernel.org/all/20260714160411.302386-1-alexandru.elisei@arm.com
>
> v1: https://lore.kernel.org/all/20260615155244.183044-1-alexandru.elisei@arm.com
>
>  virt/kvm/kvm_main.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index cf4cb586f140..599dea22afb8 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -601,6 +601,10 @@ static __always_inline kvm_mn_ret_t kvm_handle_hva_range(struct kvm *kvm,
>  			unsigned long hva_start, hva_end;
>
>  			slot = container_of(node, struct kvm_memory_slot, hva_node[slots->node_idx]);
> +
> +			if (kvm_slot_has_gmem(slot) && kvm_memslot_is_gmem_only(slot))
> +				continue;
> +
>  			hva_start = max_t(unsigned long, range->start, slot->userspace_addr);
>  			hva_end = min_t(unsigned long, range->end,
>  					slot->userspace_addr + (slot->npages << PAGE_SHIFT));
>
> base-commit: d21eef2084a9af87ac2a783bc7c2b175ba114e4e
> --
> 2.56.1.703.gf848ed807c-goog
>

--
Cheers, Lorenzo
