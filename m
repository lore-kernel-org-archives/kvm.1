Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735FA4F55B3;
	Fri, 25 Sep 2026 20:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790369478; cv=none; b=S06WLH8ywIJkIB7W43+gOAS7Jj7ehmwox4qzktZ1xbHbN4W9oWDvCO9r03cPabYJ6UmDIXnxxfZTKuue2q1XMOKPVUWwFfR4mD+NlXnN0Psi536cpbSGOqnNKIdcZu3BZ6VAu7y8E3eFoCFEtqKxdgfQlKMHmWifGLPXd1UErNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790369478; c=relaxed/simple;
	bh=RIoPdRwTiHH1lN+08xLxvRRPr/CFxxY5ugqYO4YzDpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q7198ASbLICP0VFlrYmPL3U0eKUQccck8gyG6qEZ0kJhlrGwwOle0L2/7uRiwxR+GPQWWd8Np0JENi016MdaSWE3rJ/HjIi6+FG5jMw5GSGEyKWIaGxzRd/90Njybq+0WHTzN0lR5SrIs2Y7sWsIeDhVjI36VdE+hTXkPRapWTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=gBSn4wNc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=afcr6c9C; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="gBSn4wNc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="afcr6c9C"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 71AD3140013D;
	Fri, 25 Sep 2026 16:51:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 25 Sep 2026 16:51:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790369469;
	 x=1790455869; bh=ZNEN+dXoF8P6Ekb3ewN4oyB6/0I/6Vth7Pj0sviOB30=; b=
	gBSn4wNc8HBxBA1HZIcTePQLMorz0TUdwLm/Ys8MC3cDOlfPQ56lpkpmJBRS1dNp
	8Dk3uQSf7IXsYewYa+3Ldyth/714TgMyOL3ERsb5jkszBz+wiHYGJBFVaed+PK2e
	9nSDNxbpfEa3QjS9olTN5CDYeeGRWc1wsvAhqcyhPKImEF12M8TWLlcKUpHBLvTd
	ZeX+hX/j3L+TZ/kAz8Lg0b9YfDomPDE/jhs/9d3SrXT+MVuEDXI+W9w426iirqAb
	tcR303/RiSGpep6TlbBaLlASv5cElq6D28Tbxz7QeiTJfN+MH4QuW8c+l6BP0Mnr
	01k8KvlQS1ho+/kPhTVBDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790369469; x=
	1790455869; bh=ZNEN+dXoF8P6Ekb3ewN4oyB6/0I/6Vth7Pj0sviOB30=; b=a
	fcr6c9CbtHpTpFf+QuTGh/UWjsaNTeYkvi5+Ue+qHkfFLLMYjTitRU74PwLtI2cn
	4dUjgTW4Xdgp814AhbVfv4s6ISgL4vQo7KOeey0P75J5YO1o7rZewFb5jBSt6ouz
	TB+aBSsIevWTfE5S4b1iJZEwlScBTvC1aB0O3/tb1Zvu4ENK3U5rDNOfr7B5Zyqy
	5VLJZYZB6FPIRTt4w2rGY94RuyW+R4p6Mws7QeD7m3ZB4UIw7URifITS4ur//DSm
	cxozmjf+hxJVh5zE3b3aAiRsHMGU8k1fCGa1wWAoeWxDyHIZ5irRuJxZA1D2K2Ot
	yvwNDBJvFLF6GUvV9hNBQ==
X-ME-Sender: <xms:vd62arTMrHUQXJzISkkPCe8q6a_wv6O0uhydgFo7hQd6DnnlrTtDPA>
    <xme:vd62aoMuA3cyNbG4lrbzjWs9gll_NLlKniEThCmR_5vcVit1ElGgrlVQDi7tturi-
    IM20AVEndPFyFW7bxhqveyYJeFhmKwmfjOb-qcAuCOgRrqr6gNNgu4>
X-ME-Received: <xmr:vd62akWT04oR_6mVb6LdnnNqyt5GyLxRTKi_VhFdx8iTJWMVKhjcEhGGHjxZ_g>
X-ME-Proxy-Cause: dmFkZTFWklYdqvYQ68I78RbZLhjyaCMouOoOz+Wr3uDGRpJQZ3+VpP0tm4K0UYpW2hgqXE
    vb6etJbG4/DqSHJDqMXjToTnYrKkAnZN62KdIwwQYCVVzOQMTaZ6L3AMXLFwBtnX63Ntst
    NabAi9E1xS1LdeVSPtFTmulXVDmHfM0u+Npm94wFIDoOOI3AOJr3kXWvAwYYayING240zO
    NvRyBW2IQk3FURul+/XaGzJaogOKgjXsorWlvRfNUVU7m8tndfGCEelZyvtF5sNP+1yFjb
    /OgYFxVYj2hkAI2/xegGfLgk4pMBt4XZvSlTbtQ+231niL87re+1O5VJPYKCk4xNJLx1lF
    R15kXQr7u+8h2iEI5pBnQVXCz364iLjXCPdrzASvNY0FTbCCif8962FhnlS2dmWFDSe0Sn
    j93g1hcuFdxqJrztPU2wXOP2d98GlRteSL63QfIFNjt55+reCQLiy78zSEpqixGM0DfWcu
    YuL2khLCjSbubs1nd44sDVxZPjXXHRV+Ur1GKqkSolVOH3U7oCjth0LRcc/VefOtD2H8Kt
    8q09czCEG1prz40FNKH0GrgO5pDzuDYB/d/b+eulNuJUNQxfRMsO1QFl3McSJnA3ocCNWU
    D+tafA0ccpNg6A0XNL9cOFsfKEJsIK1X8pXtKZ390je53Ruu+He1tSzOQnfA
X-ME-Proxy: <xmx:vd62aveYLudcDa1M9lk6_KtuOceqeFZBcmJW4w6K1C9eMe3mrxdObQ>
    <xmx:vd62agueCyXGQsKI_9KFZpdwWyocdOn6vVo07psBCPA4u1zsSgo5hQ>
    <xmx:vd62au9Wtffs7rmvWCLT3HvD_ueb8m9EBAhOOcbClXLYpG4U_27__w>
    <xmx:vd62ar16uv-DhVT6eRfl6Y1hjQtldGy1BkCeOITSivL-8DVy-11SZw>
    <xmx:vd62am1O8na6A-2ITq0OHJ-8T8N4dXMoT5hopt7x78lSftaNrBwszDhc>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 16:51:08 -0400 (EDT)
Date: Fri, 25 Sep 2026 14:49:32 -0600
From: Alex Williamson <alex@shazbot.org>
To: Samuel Crossley <samuelcrossley@gmail.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v2] vfio/type1: avoid walking reserved-only mappings
 while unpinning
Message-ID: <20260925144932.485c2dec@shazbot.org>
In-Reply-To: <20260919-vfio-v2-1-68e7ed355972@gmail.com>
References: <20260919-vfio-v2-1-68e7ed355972@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Sep 2026 15:13:03 -0700
Samuel Crossley <samuelcrossley@gmail.com> wrote:

> Tearing down a large device-passthrough DMA mapping can process tens of
> millions of reserved pfns in a single VFIO_IOMMU_UNMAP_DMA.  A 128 GiB
> reserved mapping holds about 33.6 million 4KiB pfns, and
> vfio_unpin_pages_remote() walks every one of them whenever dma->has_rsvd
> is set, because reserved and non-reserved pfns might be mixed.  For a
> mapping that contains only reserved pfns every put_pfn() is a no-op, but
> each one still pays for the pfn_valid()/PageReserved() classification.
> 
> Seen on GPU-passthrough hosts running 6.13 with the v6.18 type1 series
> backported, where a single VFIO_IOMMU_UNMAP_DMA held a CPU past the
> soft-lockup watchdog (host identification, register dump and module list
> trimmed):
> 
>  watchdog: BUG: soft lockup - CPU#261 stuck for 22s! [qemu-system-x86:134503]
>  RIP: 0010:vfio_unpin_pages_remote+0x139/0x2a0 [vfio_iommu_type1]
>  Code: 90 4c 89 e1 48 c1 e9 34 75 74 4c 89 e1 48 c1 e9 22 75 6b 48 8b 0d f7 6f c2 e3 48 85 c9 74 5f 4c 89 e2 48 c1 ea 16 48 8b 0c d1 <48> 85 c9 74 4f 41 8b 55 30 4c 89 e6 48 c1 ee 0f 83 e6 7f c1 e6 05
>  Call Trace:
>   <IRQ>
>   ? watchdog_timer_fn+0x3d6/0x440
>   ? running_clock+0x10/0x10
>   ? hrtimer_interrupt+0x185/0x580
>   ? __sysvec_apic_timer_interrupt+0x44/0xe0
>   ? sysvec_apic_timer_interrupt+0x6b/0x80
>   </IRQ>
>   <TASK>
>   ? asm_sysvec_apic_timer_interrupt+0x16/0x20
>   ? vfio_unpin_pages_remote+0x139/0x2a0 [vfio_iommu_type1]
>   vfio_sync_unpin+0x96/0xf0 [vfio_iommu_type1]
>   vfio_unmap_unpin+0x324/0x3d0 [vfio_iommu_type1]
>   vfio_remove_dma+0x25/0xa0 [vfio_iommu_type1]
>   vfio_iommu_type1_ioctl+0xcd5/0x1760 [vfio_iommu_type1]
>   ? amd_pmu_v2_enable_all+0xa/0x30
>   ? perf_pmu_sched_task+0xbf/0xf0
>   x64_sys_call+0x282/0x1ac0
>   ? syscall_trace_enter+0x1e5/0x1f0
>   do_syscall_64+0x68/0x130
>   entry_SYSCALL_64_after_hwframe+0x4b/0x53
> 
> RIP is the mem_section root test in pfn_valid(), inlined into put_pfn()
> through is_invalid_reserved_pfn(), so the stall is in the dma->has_rsvd
> per-page loop.  mem_section[] has no root for that pfn, so pfn_valid()
> returns false and put_pfn() does nothing - for every pfn in the mapping.
> 
> Track whether the mapping also contains non-reserved pfns and skip the
> walk entirely for reserved-only mappings.  Mixed mappings keep the
> existing per-pfn walk, and ordinary mappings keep the existing batched
> unpin path.
> 
> Tested on an affected host: reserved-only mappings up to 128 GiB take the
> new path and complete in microseconds.  The ordinary-page path was
> exercised unchanged.
> 
> Suggested-by: Alex Williamson <alex@shazbot.org>
> Link: https://lore.kernel.org/all/20260803154707.71cc0d6b@shazbot.org/
> Signed-off-by: Samuel Crossley <samuelcrossley@gmail.com>
> ---
> This is the reserved-only fast path you suggested on v1, tested on
> the affected hosts. There is indeed no evidence that the non-reserved
> VFIO path needs chunking, and agree any such change to
> unpin_user_page_range_dirty_lock() would belong in mm, so not
> including it in this patch.
> ---
> Changes in v2:
> - Replace v1's cond_resched() chunking with the reserved-only fast path.
> - Tested on an affected host; reserved-only mappings up to 128 GiB now
>   complete in microseconds instead of walking ~33.6M pfns.
> - Link to v1: https://patch.msgid.link/20260723-vfio-v1-1-3b59579916c6@gmail.com
> ---
>  drivers/vfio/vfio_iommu_type1.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index c8151ba54de3..f7addfbe1aab 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -94,6 +94,7 @@ struct vfio_dma {
>  	bool			lock_cap;	/* capable(CAP_IPC_LOCK) */
>  	bool			vaddr_invalid;
>  	bool			has_rsvd;	/* has 1 or more rsvd pfns */
> +	bool			has_non_rsvd;	/* has 1 or more !rsvd pfns */
>  	struct task_struct	*task;
>  	struct rb_root		pfn_list;	/* Ex-user pinned pfn list */
>  	unsigned long		*bitmap;
> @@ -791,6 +792,7 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
>  
>  out:
>  	dma->has_rsvd |= rsvd;
> +	dma->has_non_rsvd |= !rsvd;
>  	ret = vfio_lock_acct(dma, lock_acct, false);
>  
>  unpin_out:
> @@ -821,11 +823,13 @@ static long vfio_unpin_pages_remote(struct vfio_dma *dma, dma_addr_t iova,
>  	long unlocked = 0, locked = vpfn_pages(dma, iova, npage);
>  
>  	if (dma->has_rsvd) {
> -		unsigned long i;
> +		if (dma->has_non_rsvd) {
> +			unsigned long i;
>  
> -		for (i = 0; i < npage; i++)
> -			if (put_pfn(pfn++, dma->prot))
> -				unlocked++;
> +			for (i = 0; i < npage; i++)
> +				if (put_pfn(pfn++, dma->prot))
> +					unlocked++;
> +		}
>  	} else {
>  		put_valid_unreserved_pfns(pfn, npage, dma->prot);
>  		unlocked = npage;
> 
> ---
> base-commit: 4e3c1fc8abcb8eff062150b4340fa4569696d645
> change-id: 20260723-vfio-decd86bf3cf6
> 
> Best regards,
> --  
> Samuel Crossley <samuelcrossley@gmail.com>
> 

Applied to vfio next for v7.4.  Thanks,

Alex
