Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D86F1A9FB0;
	Mon,  3 Aug 2026 21:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785793637; cv=none; b=Kyi1uEMmotUPvm1eAhy+aUfbBA7lThj+JgWJNWwCee9sSik0Iuf3gmA9dO0Y3gfr4BiUurcSudFn/KcDGzvsyIkzS2yvUvgBJizHUBSZi0M8JdU390fLejOwtpqc8yya1rYYc/ow+HNA4jgt2lHRJBaVwmpJlmKXv/Dx00e0MTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785793637; c=relaxed/simple;
	bh=pGLBXObDQBXE3LNRPQHeXIypv5RqesS9vtoGK10uU+U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cwBbUCJ+UjANBkgDsfD1UJ2A6JrBTtNjB8fS2rx+Oa/uj3mJIBbL0tqDXGOxp6W9RUzVo4GHOIG9d/trLu7KbaSWMmiAxof8jrm3LzSfY17t7X0BpoDSsZEon0tSRk5etT0VP2AWyjPptq0xBiyP1jOZxlCQUR5Arv84hQeYyps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=JLgLF+5t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y5ar56Ab; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="JLgLF+5t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y5ar56Ab"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5A55B7A0108;
	Mon,  3 Aug 2026 17:47:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 03 Aug 2026 17:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785793633;
	 x=1785880033; bh=oNJ0rfPtjl1xN3xTTsJBVqjHnweNIRJqecYsARVAi0U=; b=
	JLgLF+5tTmfkg3XqYT1wffaV5xTQL6hjtCUQazQ4nMR6U50eVlQMMPzMhkAsevvi
	H3/Ap9/MNY17MyUxVafjQqO4T1mrnAJEvDxDfgnVWjQjf4XvuEsEYwVys+hkgncI
	9iYDkDbDSeSrma9rt7aNnxrSmdstWkpuX6PQfC/7daE79FEJKxbm4ehJTGCCHLgn
	2R80An9xY/Tz+k3P+vasnF0/XMMRF1F+B+NmyFEE/Z0zQ3om+JWrw1m4fe8FtbSx
	SqOEdOPA6u5q/i9ZSOY9kvGu9h8T9oZvMkYNyMgt2bt6QjFy92hBuRxUKqMAJHmf
	6A/eqByhVVhqlHByfMgvgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785793633; x=
	1785880033; bh=oNJ0rfPtjl1xN3xTTsJBVqjHnweNIRJqecYsARVAi0U=; b=Y
	5ar56AbXUzD/gYGxI00rFk+2UHjRfSWChRBAo35p5jibZpq8Znvp/Ar+z3mIWUel
	Izwzb3lViaHlpTIz+Mjj9ODWBdto9GMF+vDLPUKn3S66x39+2OyycpN7CtJsxwPJ
	XltmAnld0mcvB2K+3SsxefTfpCDzhWAi5RlVtWFSiK5teqBd9T3dW216O/loGLzx
	NgA3soGyt2xOa3l/FXVzjT9Y0Bh0hu2tBp1wEK7obLQNPteODtEGHDePRyfKpaem
	HGx/dZPRw25EgdHy7i9NWjRZ+0DGHffQk5+z+CRFvdqUWmBWsB5Fb/FjQ0l/Fktp
	7uYNQoUT4KHPyCxe98YZw==
X-ME-Sender: <xms:YAxxagMAn0co8ED8PYDF0u5X6d8VYwWGFwN1IAmckJJoZrZbX3ymUw>
    <xme:YAxxakzBmc4k0RqU8lcti19v8NMnpw-CTToRej9e68Ed1BmIxwgRpBCRDz53FK0Cu
    OVSwDhVW6hACCMeYQfjjUf9Yn988BUh-PoHPP6s8eIWgimOP-yH>
X-ME-Received: <xmr:YAxxahvLcuKeWhQUD7wUj_qZRBDyjkgo5QrtqhnQ3566RZNsuuwWB66PcQuEgg>
X-ME-Proxy-Cause: dmFkZTGx+DlClvpE/KiGowUEhNtBPGnUwftwbpa0/UBuMCA5Q0mdizEZiJZ1uUp2/288Nf
    Jfiygp7kYpP8jasGqh9GiW23UXRwJcR2f97AYv4Ecrg61g44VQm1n08fHqmcefcEXczZ+w
    tUDURw6WSQSqrf+mWdscYxFPeNNQiH3g8tNFmoDlBpZd8q4cqQq92ZFvaRwbPquY1y/b84
    n1FoiWJuNRFh4e59QbRszR4fFuszEn77kznTlGqZCYGOTwMP2+eWO6YLultCRPHanlhlAj
    +V4C1IJYJh26b7sQ1HMsZgL4HuHwiTqjUUBPdGAx0fu6APBFKopIabEp2SwMKVvTikhOI8
    KPh8r5qxTmUQxaWcCCHFlCiGkmHtk2LBFiSgeJ6Y6BpNEi4yXfHJ1akIfawGQbnOXREFN9
    AoWkDEljR1sf+BymmAZsrCnBGY6Cc6I6BeUDJPjr56YW/MudLVREVuvH7Dhh0nFMIlSX8s
    B/E5SQlWJ9xjnc0FhJEsFL0Jft7iURPkmXkKT4mtPW5zX1g903EJ04ghgsbb2cNJkhtiOt
    ViHBkk6M5+QLLI0ZhAtYmSQoSWyTXhD7+JzmQKN2IAvcKwXyjSGJ0B8e3onYb88fY/nl78
    HK4ep2McLRo3z66syjUcz5NmmqQfR1DZ3tFx6Yvaa2rLng8YXxtby0xKlS9Q
X-ME-Proxy: <xmx:YAxxal4K1YKh1toXO9BxsFw3iLcB_OqU_KvhEYWtKIGuTiR4TrHj5g>
    <xmx:YAxxaoTxmLaC97GH0eURsigo9E4RUYvlUwCdAG5CQHhQbOv4jzlFFg>
    <xmx:YAxxaspT-GB0YOdfmgUMNRz7f0swCyFjHixyxd8UNe6qH1VNt5S4dg>
    <xmx:YAxxauK7TXJSkVRJflf5pi6kWFd8mYK3YmMXM8vbQsLdlpjO7obRnA>
    <xmx:YQxxasoxY_-wGiJAHeKxTwyPViLAHdX2ypJd1FFvzAjH0u9G7ZBqLUwK>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Aug 2026 17:47:12 -0400 (EDT)
Date: Mon, 3 Aug 2026 15:47:07 -0600
From: Alex Williamson <alex@shazbot.org>
To: Samuel Crossley <samuelcrossley@gmail.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH] vfio/type1: conditional rescheduling while unpinning
Message-ID: <20260803154707.71cc0d6b@shazbot.org>
In-Reply-To: <20260723-vfio-v1-1-3b59579916c6@gmail.com>
References: <20260723-vfio-v1-1-3b59579916c6@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 08:20:00 -0700
Samuel Crossley <samuelcrossley@gmail.com> wrote:

> Tearing down a large device-passthrough DMA mapping can unpin tens to
> hundreds of millions of pages in a single VFIO_IOMMU_UNMAP_DMA.
> vfio_unpin_pages_remote() walks the whole contiguous range in one
> uninterrupted pass with no reschedule point:
> 
>   - has_rsvd (reserved / device-memory mappings, e.g. GPU HBM/BAR mapped
>     for peer DMA): a per-page put_pfn() loop, each doing a
>     pfn_valid()/is_invalid_reserved_pfn() section lookup;
>   - otherwise: the batched unpin_user_page_range_dirty_lock() folio walk.
> 
> The existing cond_resched() calls in the unmap path only run between
> regions/chunks, so they cannot break up one giant call.
> 
> Observed on a GPU-passthrough host: unmapping a 128 GiB device-memory
> region (~33.6M reserved 4K pages, has_rsvd) held a CPU 22s in the per-page
> loop and tripped the soft-lockup watchdog, panicking the host:
> 
>   watchdog: BUG: soft lockup - CPU#74 stuck for 22s! [qemu-system-x86]
>    put_pfn / is_invalid_reserved_pfn / pfn_valid
>    vfio_unpin_pages_remote / vfio_sync_unpin / vfio_unmap_unpin
>    vfio_remove_dma / vfio_iommu_type1_ioctl (VFIO_IOMMU_UNMAP_DMA)

This reconstructed backtrace is difficult to parse, seems to reverse
direction in the middle.

> 
> The v6.18 batching series (d10872050ffe, d14de5b92578) optimized only the
> non-reserved folio path, so it does not help this has_rsvd loop. Bound the
> work per iteration and cond_resched() between chunks, mirroring the
> pin-side fix in commit b1779e4f209c ("vfio/type1: conditional
> rescheduling while pinning").
> 
> cond_resched() is safe on this path: the only lock held across
> vfio_unpin_pages_remote() is iommu->lock, a mutex, so sleeping is allowed,
> and it is taken in vfio_dma_do_unmap() and held continuously through
> vfio_remove_dma() without being dropped on this path. No spinlock,
> preempt-disabled, IRQ-disabled or RCU read-side section is held anywhere in
> the type1 unmap path. The loop's callees (put_pfn(),
> unpin_user_page_range_dirty_lock()) drop any transient folio reference and
> folio lock before returning, so only the mutex is held at the reschedule
> point. The path is already demonstrably sleepable: the same unmap chain
> already calls cond_resched() at the region/chunk level, and the
> non-reserved dirty path already takes folio_lock().
> 
> Signed-off-by: Samuel Crossley <samuelcrossley@gmail.com>
> ---
> Signed-off-by: Sam Crossley <samuelcrossley@gmail.com>
> ---

Something is a bit off in your tooling here.

>  drivers/vfio/vfio_iommu_type1.c | 36 ++++++++++++++++++++++++++++--------
>  1 file changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index c8151ba54de3..ce7f6051f799 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -814,22 +814,42 @@ static inline void put_valid_unreserved_pfns(unsigned long start_pfn,
>  					 prot & IOMMU_WRITE);
>  }
>  
> +/* Pages to unpin per cond_resched() when tearing down a large mapping. */
> +#define VFIO_UNPIN_RESCHED_PAGES	(16UL * 1024)	/* 64MB @ 4K pages */

Nothing in the commit log or comment describes how this value is
derived.  This makes 2K chunks out of the 128GB BAR, why is this a good
value?

> +
>  static long vfio_unpin_pages_remote(struct vfio_dma *dma, dma_addr_t iova,
>  				    unsigned long pfn, unsigned long npage,
>  				    bool do_accounting)
>  {
>  	long unlocked = 0, locked = vpfn_pages(dma, iova, npage);
> +	unsigned long remaining = npage;
>  
> -	if (dma->has_rsvd) {
> -		unsigned long i;
> +	/*
> +	 * A single unmap of a very large device-passthrough mapping can unpin
> +	 * hundreds of millions of pages here.  Bound the work per iteration and
> +	 * cond_resched() so one VFIO_IOMMU_UNMAP_DMA cannot hold a CPU past the
> +	 * soft-lockup watchdog.  Mirrors the pin-side reschedule in commit
> +	 * edeca59cb88d2 ("vfio/type1: conditional rescheduling while pinning").

This commit ID doesn't exist, I think you're referring to b1779e4f209c.

> +	 */
> +	while (remaining) {
> +		unsigned long batch = min(remaining, VFIO_UNPIN_RESCHED_PAGES);
>  
> -		for (i = 0; i < npage; i++)
> -			if (put_pfn(pfn++, dma->prot))
> -				unlocked++;
> -	} else {
> -		put_valid_unreserved_pfns(pfn, npage, dma->prot);
> -		unlocked = npage;
> +		if (dma->has_rsvd) {
> +			unsigned long i;
> +
> +			for (i = 0; i < batch; i++)
> +				if (put_pfn(pfn++, dma->prot))
> +					unlocked++;
> +		} else {
> +			put_valid_unreserved_pfns(pfn, batch, dma->prot);
> +			unlocked += batch;
> +			pfn += batch;

The commit log describes the reserved pfn side as troublesome, but then
quietly applies chunking to both paths.  What evidence suggests it's
needed on this path too, and if it is, should it be in the mm layer
rather than here?

> +		}
> +
> +		remaining -= batch;
> +		cond_resched();
>  	}
> +
>  	if (do_accounting)
>  		vfio_lock_acct(dma, locked - unlocked, true);
>  
> 

I think there's an optimization we can do here that avoids the overhead
entirely rather than just splitting it into scheduler friendly chunks.

We track whether a vfio_dma has reserved pages, but we don't know if
it's only reserved pages or some mix of reserved and non-reserved
pages, so we iterate per page.  I think that mixed case requires some
atypical userspace behavior and this check is a no-op in the case where
there are only reserved pages.  So (untested), I think we could do
something like this:

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index c8151ba54de3..f7addfbe1aab 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -94,6 +94,7 @@ struct vfio_dma {
        bool                    lock_cap;       /* capable(CAP_IPC_LOCK) */
        bool                    vaddr_invalid;
        bool                    has_rsvd;       /* has 1 or more rsvd pfns */
+       bool                    has_non_rsvd;   /* has 1 or more !rsvd pfns */
        struct task_struct      *task;
        struct rb_root          pfn_list;       /* Ex-user pinned pfn list */
        unsigned long           *bitmap;
@@ -791,6 +792,7 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
 
 out:
        dma->has_rsvd |= rsvd;
+       dma->has_non_rsvd |= !rsvd;
        ret = vfio_lock_acct(dma, lock_acct, false);
 
 unpin_out:
@@ -821,11 +823,13 @@ static long vfio_unpin_pages_remote(struct vfio_dma *dma, dma_addr_t iova,
        long unlocked = 0, locked = vpfn_pages(dma, iova, npage);
 
        if (dma->has_rsvd) {
-               unsigned long i;
+               if (dma->has_non_rsvd) {
+                       unsigned long i;
 
-               for (i = 0; i < npage; i++)
-                       if (put_pfn(pfn++, dma->prot))
-                               unlocked++;
+                       for (i = 0; i < npage; i++)
+                               if (put_pfn(pfn++, dma->prot))
+                                       unlocked++;
+               }
        } else {
                put_valid_unreserved_pfns(pfn, npage, dma->prot);
                unlocked = npage;


Possibly that inner loop could be split to have a cond_resched() at
regular intervals as hardening against softlockup_panic configurations,
but aiui, typical userspace wouldn't hit it.  Thanks,

Alex
