Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793224305;
	b=Z7LdXPIgqFzyJugQHFIju5KUT1wTT9VpikxzacFKvPm7df1ARIX86H3mWaWSdaAa4HSg
	 SgmphQ6P2NOQwEd3V4G8PRVf4pyTBQpnaLA6B/edsk/Ss3MXQjIBfuRddRRYaJMO5PS7n
	 wSGHbA5IBOZePivO/7FtxO1uUtqc+Ms/trmIBbLsoEfRD8CZJvXOseYzveG2tOOTSM44z
	 NoPs9LoUU5MRkqnmOBWtnbKgj+hxiTPEuEkvjNDLC5kmUeCLPExUMRkho1OLuXVHLAvbl
	 sPivh1DF3Zb7hesQsfEhxyDd5VdBXEmd+7T+ROczzfXchl47K6dLUP6QHRYvkNa47Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793224305;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=w7Bp9dEIJxBru2Yx4Wp3IUe1NzI0zM2Aj6BmYM8tSDQ=;
	b=oAokBmHAgLzMxCNtPR8ZIufw7r66Jx583epUMd6TZyyPpHgqvhUHTyGFuWmUG98jzrvc
	 E1+b0/7+zwnXlxc177Udt0Qb4hnkhCfd4NpnM+QVeWuzg9iays6uzxNk1wc0yOlTuNlTV
	 FDvP/mpLhXzR2ZZruEBicukr2EQdxjgMGqYic0BR95JMyJZY5ghCtgr2xc+SvPhAy/lvf
	 PaH/22PbdDPAGPNZWin3NNUgv8vB9Wuoh8EIYdyH0eCMXPpMjz98ZdJhVrfxwwTkZy/t+
	 ge1LD4O5m2oblEjWeK/fM++zLucocC5y3vQtIHaLjXyI3O1udQ1S6+hiloIg0CmpxqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JYIR2HRf;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5660F606A31A
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 21:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5660F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JYIR2HRf
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ad91787a1aso1030963a91.1
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 14:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793224305; x=1793829105; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w7Bp9dEIJxBru2Yx4Wp3IUe1NzI0zM2Aj6BmYM8tSDQ=;
        b=JYIR2HRfFnGvSU2rQGBW5sxdBR8+2GlH2qjSq/HlD6S1u4eJjR1i/w+as6DToQOKvk
         RSDAri7eQHTr4j9eUTy4Z2DbhxFMnZsVBHmi/fT6/ey6EKp/8L3qtsdyFQVLxeJCqV2D
         xDHqQydzMq9zx1vSYnV5613GpblmNqBGeXypBuGM2MtlhNUGk5n7a7+RZfJmB8WAVcwG
         OaJ+Pp4etwzurozhxQU8jivNTMaWuu+r6eaF5dfVdvCQX4ABCS+ynxCJ0SBmG8elQT07
         HSeIPzYrnw/B3podc0ti5M63QabUaVeyVgEXoLhQhk4NhgCLTvc+yckuVNgToedhZotl
         S6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793224305; x=1793829105;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w7Bp9dEIJxBru2Yx4Wp3IUe1NzI0zM2Aj6BmYM8tSDQ=;
        b=NSqXlfuPLODWGH777TSmKT2QU8tElPd82l454jqRDekkXt6v2wV1jeAf0GbI8X1Wb3
         Z1v7SfSf/Tv0Aw1Go+KlV0hjMjOERn0FNJXZPgoCmE5JZUE1gMQf51EtMccmIpPulgev
         a1LnQ4h+VKkFMoGCP/Je5CKk7+WEq7O/nEZzC48iLoyIUCtZKw2uQcDf7/PMWM6A4Fz3
         YU7AvPswpVsgdntnUkKh9JSuRtG0qaBpXwGj/9/I/2r64RKUXriHYkoIIYKDkOlkna8e
         3QTb9hjLPKk4aU88Sj+4hGlx4tIgApCUQz15hnz3ca9j2VQBLrOp5As4WHsiacJ0lRWS
         gQjQ==
X-Gm-Message-State: AFq9FYKB22rVYgGjGiwn1fl5PjJ714jlpuAEaEuuNhKCVs6lbm5NiGRE
	f7kAaWF73T2JuVOacFZ2YjdSSmjHGQ4ftZvMsHSy8+4NLENQJNbfGy5W+EIR/Al3iXon7gY5tpJ
	sALlBZ0NAXc7P/pUweqmKuQ==
X-Received: from pjbcm5.prod.google.com ([2002:a17:90a:fa05:b0:3ad:ce88:b6b5])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:57e3:b0:3ab:413:49bc with SMTP id 98e67ed59e1d1-3ae58123796mr2472490a91.37.1793224304446;
 Wed, 28 Oct 2026 14:51:44 -0700 (PDT)
Date: Wed, 28 Oct 2026 21:51:43 +0000
In-Reply-To: <20261028202607.1844883-4-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261028202607.1844883-4-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261028215143.2913059-1-jthoughton@google.com>
Subject: Re: [PATCH 3/4] KVM: x86/mmu: Add automatic prefaulting/prefetching
 for TDP MMU faults
From: James Houghton <jthoughton@google.com>
To: seanjc@google.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mamarang@amazon.com, 
	pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"

On October 28, Sean Christopherson wrote:
> Leverage the prefault code to add "automatic" prefetching of surrounding
> SPTEs when handling TDP MMU page faults.  As pointed out by Marco, the TDP
> MMU doesn't support prefetching SPTEs, which puts the TDP MMU at a severe
> performance disadvantage relative to the shadow MMU when faulting in guest
> memory at 4KiB granularity, and in general is a gap in the TDP MMU.
> 
> Use the prefault flow to prefetch SPTEs instead of the more minimal, custom
> approach used by the shadow MMU.  Reusing the prefault flow sacrifices a
> small amount of performance (the standard page fault path is "heavier"),
> but is vastly simpler, supports backing memory that can't be GUP'd, and
> shares its maintenance burden with KVM_PRE_FAULT_MEMORY.  E.g. multiple
> flaws in x86's prefault code were practically impossible to hit with
> userspace-driven prefaulting, but were hit almost immediately with
> KVM-driven automatic prefetching.
> 
> Provide a writable module param to let userspace control the number of
> pages to prefault, as KVM needs a control of some kind, and letting the
> user choose how aggressively to prefetch is just as easy as hardcoding the
> number of PTEs to prefetch.  I.e. supporting a variety of use cases is all
> but free.  Default to PTE_PREFETCH_NUM as that's been KVM's behavior for
> the shadow MMU for decades, i.e. even if it was arbitrary, it's gotten a
> *lot* of mileage and so presumably is a reasonable default.
> 
> Instead of unconditionally bailing on hugepage faults, skip prefetching if
> the original installed page size covers at least the number of pages the
> user wants to prefetch.  In practice, it's unlikely hugepage prefetching
> will see much, if any, use, but it's practically free to support, and will
> allow for more experimentation and tuning.
> 
> Note!  Check for an incompatible memslot *before* invoking the specific
> page fault handler, and thus before fast page faults are handled, otherwise
> the fast page fault handler can "fix" a fault that never happened and log a
> spurious, non-existent access.
> 
> Do NOT prefetch in response to protection faults, i.e. if there was already
> a shadow-present SPTE, because prefetching in that scenario is unlikely to
> be beneficial.  Note, this would also prevent spurious dirty logging via
> fast page faults, but (obviously) only for writes, i.e. wouldn't block fast
> handling for !PRESENT page faults when A/D bits are disabled.  I.e. the
> aforementioned early check is still necessary to avoid spurious dirty log
> entries (or KVM would need to explicitly treat auto-prefetch "faults" as
> "can't be fast").
> 
> Lastly, don't go down the slow I/O path for auto-prefetch faults, as the
> goal is for auto-prefetching to be light and fast, i.e. to pull in SPTEs
> without significantly increasing the latency of handling page faults.
> 
> For now, use the auto-prefaulting code to the TDP MMU, i.e. defer
> converting direct shadow MMUs to a separate change.
> 
> Reported-by: Marco Marangoni <mamarang@amazon.com>
> Closes: https://lore.kernel.org/all/20260825140159.70997-1-mamarang@amazon.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 64 +++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 60 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 3bd0d921778d..c56a2eaa4646 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -122,8 +122,15 @@ static int max_huge_page_level __read_mostly;
>  static int tdp_root_level __read_mostly;
>  static int max_tdp_level __read_mostly;
>  
> +/*
> + * The exact number of PTEs that can be prefetched for the shadow MMU, and the
> + * default number of pages to prefault/prefetch pages for the TDP MMU.
> + */
>  #define PTE_PREFETCH_NUM		8
>  
> +static unsigned int __read_mostly auto_prefault_nr_pages = PTE_PREFETCH_NUM;
> +module_param(auto_prefault_nr_pages, uint, 0644);
> +
>  #include <trace/events/kvm.h>
>  
>  /* make pte_list_desc fit well in cache lines */
> @@ -4709,10 +4716,12 @@ static int __kvm_mmu_faultin_pfn(struct kvm_vcpu *vcpu,
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
> -	if (fault->pfn != KVM_PFN_ERR_NEEDS_IO)
> +	if (fault->pfn != KVM_PFN_ERR_NEEDS_IO || fault->auto_prefetch)
>  		return RET_PF_CONTINUE;

Hi Sean,

I wasn't sure where to leave this feedback, but Marco's original patch[1]
used fast-only GUP instead of relying on normal GUP + FOLL_NOWAIT. I think
fast-only GUP is better here. (Correct me if I haven't understood this
series correctly.)

With normal GUP, we'll get allocate more pages than absolutely necessary,
and pages that are swapped out with zswap are swapped back in even for
FOLL_NOWAIT. And I'm a little bit concerned that normal GUP (even with
FOLL_NOWAIT) might stall page faults noticeably longer than before.

If you leave prefetching as normal GUP, maybe leave it off by default?

What do you think?

[1] https://lore.kernel.org/all/20260825140159.70997-1-mamarang@amazon.com/

>  
>  	if (!fault->prefetch && kvm_can_do_async_pf(vcpu)) {
> @@ -5072,6 +5081,18 @@ static int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
>  		 */
>  		fault.gfn = gpa_to_gfn(fault.addr) & ~kvm_gfn_direct_bits(vcpu->kvm);
>  		fault.slot = kvm_vcpu_gfn_to_memslot(vcpu, fault.gfn);
> +
> +		if (fault.auto_prefetch) {
> +			r = kvm_check_memslot_usable_for_auto_prefetch(fault.slot, ACC_ALL);
> +			if (r)
> +				return r;
> +		}
> +	} else {
> +		/*
> +		 * Indirect MMUs need to use a dedicated prefetch mechanism, as
> +		 * the associated guest PTE factors into the prefetching.
> +		 */
> +		WARN_ON_ONCE(fault.auto_prefetch);
>  	}
>  
>  	/*
> @@ -6654,11 +6675,44 @@ static int kvm_mmu_write_protect_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
>  	return RET_PF_EMULATE;
>  }
>  
> +static void kvm_mmu_auto_prefault(struct kvm_vcpu *vcpu, gpa_t start,
> +				  u64 error_code, u8 level)
> +{
> +	gfn_t nr_pages = READ_ONCE(auto_prefault_nr_pages);
> +	int nr_pages_msb;
> +	gfn_t i;
> +
> +	if (error_code & (PFERR_RSVD_MASK | PFERR_PRESENT_MASK))
> +		return;
> +
> +	if (!tdp_mmu_enabled || vcpu->arch.mmu->page_fault != kvm_tdp_page_fault)
> +		return;
> +
> +	nr_pages = min(nr_pages, KVM_PAGES_PER_HPAGE(PG_LEVEL_1G));
> +	if (KVM_PAGES_PER_HPAGE(level) >= nr_pages)
> +		return;
> +
> +	nr_pages_msb = find_last_bit((unsigned long *)&nr_pages, sizeof(nr_pages));
> +
> +	start = ALIGN_DOWN(start, gfn_to_gpa(BIT_ULL(nr_pages_msb)));
> +
> +	for (i = 0; i < nr_pages; i += KVM_PAGES_PER_HPAGE(level)) {
> +		gpa_t gpa = start + gfn_to_gpa(i);
> +
> +		if (gpa < start || gpa_to_gfn(gpa) > kvm_mmu_max_gfn())
> +			return;
> +
> +		if (kvm_tdp_page_prefault(vcpu, gpa, error_code, KVM_PREFETCH_AUTO, &level))
> +			return;
> +	}
> +}
> +
>  int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 error_code,
>  		       void *insn, int insn_len)
>  {
>  	int r, emulation_type = EMULTYPE_PF;
>  	bool direct = vcpu->arch.mmu->root_role.direct;
> +	u8 level;
>  
>  	if (WARN_ON_ONCE(!VALID_PAGE(vcpu->arch.mmu->root.hpa)))
>  		return RET_PF_RETRY;
> @@ -6692,7 +6746,7 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
>  
>  		r = kvm_mmu_do_page_fault(vcpu, cr2_or_gpa, error_code,
>  					  KVM_PREFETCH_NONE,
> -					  &emulation_type, NULL);
> +					  &emulation_type, &level);
>  		if (KVM_BUG_ON(r == RET_PF_INVALID, vcpu->kvm))
>  			return -EIO;
>  	}
> @@ -6703,6 +6757,8 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
>  	if (r == RET_PF_WRITE_PROTECTED)
>  		r = kvm_mmu_write_protect_fault(vcpu, cr2_or_gpa, error_code,
>  						&emulation_type);
> +	else if (r == RET_PF_FIXED)
> +		kvm_mmu_auto_prefault(vcpu, cr2_or_gpa, error_code, level);
>  
>  	if (r == RET_PF_FIXED)
>  		vcpu->stat.pf_fixed++;
> -- 
> 2.56.0.313.g2479322e68-goog
