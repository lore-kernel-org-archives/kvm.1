Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E31379974
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 01:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784683820; cv=none; b=ZRRixIKR5S2ZbQPWdGSJTH4MH7EP2RHWDryBzXmAa0CvyU/ov99GLHVBQutTNOaIqgfVHPHGzTEGs0wEQGbYZJBuBU0VhrS97sghLHj19LPA5M7ITWgXsGh7Lb6nHdpRz6s6d0Cec9lmbGZqeebaBDQOE8Kz/M0UB4f7i3wXqUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784683820; c=relaxed/simple;
	bh=ZQFPrQrCxysvjQVtLwFLKAxzSgAmkgic3BAOc3Lg+Z0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FSpIUlJYmV/hRuY3CDrQ8AAxGX5k/uHsEuO+48DICc8uaUaJRXQYZl1wRbn38Ku8ROOvVnUAvv0XmbdHypBUQblUMetddyqDy7LB9pahgK2FhwzvFYJnrNMqM3DE3CJzcG9R43kMS48NrobDsgwDBNhOaektFk0HFKSb6Ci3SYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NGEZnmjX; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NGEZnmjX"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ca5d2474c7so221111095ad.2
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 18:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784683818; x=1785288618; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mLP8oC9He5bG0lE1LOVDS9P9kGEAQw/gp9CI2IaEXuE=;
        b=NGEZnmjXbpCYp2yhEPhgQda6pBn+J92+y9JOspCcYXhL7fHVzJhSDX6k+2rvY6ah3X
         SiGr+F+2B0xXrW+RaBgaNG27B1yzweN6uOeMOKLdJMUJ3/hQPv3C3kXAL7zsct6k64Uv
         tYtUY2CND9iXsu+2hrzk5+aQJarYqAKyvfREckjopsGFHYAFBzmY3YHGcLYzxiKqFluX
         OIkyeb2l2DOr/u4MIa6SvF+mf+O5HsopqriyLossM+ClMQ1NxeHr9YJCP8UC5FV1oAch
         DL2X7MtxyNlm0pAI32VebJ1nck1GHaim7sCKEeQQVeTtH/T5uQV9rKxft57056uxF4eP
         VOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784683818; x=1785288618;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mLP8oC9He5bG0lE1LOVDS9P9kGEAQw/gp9CI2IaEXuE=;
        b=jgHlAllmXRNYakP6L2If4qT2xMPQMESoP2MfEwRPfWst+09csaZcBW3UFu8y3C4zJx
         swW86R7Mhcfj4wZVPvcwuN0Vz7ok1YNfF5tyrY/aOKLcP36+ij3Sfc/9VrwiFQM6g0/T
         5OZ9/HjWe9yiC8qw2aWuOSjuChuwMzxE1I8VEluUnEnASGAE7enD8aRP+ew7/A1VH7CQ
         jivZroJzMXEq+x0Cdq01j5UXZ42S3hiaMGwn+rIPZaQU1hnldHa4ovk8Avh6iSUI1KxW
         qj3XoPC56eS+AzGNjTkXqfEyI5Yb8K03g74jnHRVhRccM06fg11tvdkMb/hpoQwpS895
         cNxg==
X-Forwarded-Encrypted: i=1; AHgh+RrVqgirFNw22oO+kn7WGonGqZXpHcyYe2FbbzlESbhLYt6kwQ9ZO9LNa8Q6jx0I7jBFidU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjK1/e4Cv4+Im87FOOJuN67+kDeAOKu3BKV7LF40drTiC1EggI
	Li0TPxbgFk9fvecV7SY4M113g4+7vGuYN4IwAuIo8HmIiNPP7UN3XPotISpGyX133sDS/VG29hM
	68o7BeA==
X-Received: from plbla4.prod.google.com ([2002:a17:902:fa04:b0:2cf:37e1:f2a3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f705:b0:2c8:1c05:16bb
 with SMTP id d9443c01a7336-2cf3494f91fmr222986455ad.24.1784683818304; Tue, 21
 Jul 2026 18:30:18 -0700 (PDT)
Date: Tue, 21 Jul 2026 18:30:17 -0700
In-Reply-To: <al-gx47Cc33uCJra@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714231015.3337831-1-seanjc@google.com> <20260714231015.3337831-5-seanjc@google.com>
 <CAEvNRgEuTG3k_iKFMLtqGXXQ5tW6X6+8BsCB=Z1WGgqOcPV5Vg@mail.gmail.com> <al-gx47Cc33uCJra@google.com>
Message-ID: <amAdKUo35OwcLxCy@google.com>
Subject: Re: [PATCH v5 4/7] KVM: guest_memfd: Fold __kvm_gmem_prepare_folio()
 into its sole caller
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <tabba@google.com>, Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="us-ascii"

+Mike

On Tue, Jul 21, 2026, Sean Christopherson wrote:
> On Tue, Jul 14, 2026, Ackerley Tng wrote:
> > Sean Christopherson <seanjc@google.com> writes:
> > 
> > >
> > > [...snip...]
> > >
> > > @@ -97,11 +85,15 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
> > >  	 * The order will be passed when creating the guest_memfd, and
> > >  	 * checked when creating memslots.
> > >  	 */
> > > -	WARN_ON(!IS_ALIGNED(slot->gmem.pgoff, folio_nr_pages(folio)));
> > > +	WARN_ON_ONCE(!IS_ALIGNED(slot->gmem.pgoff, folio_nr_pages(folio)));
> > > +	gfn = ALIGN_DOWN(gfn, folio_nr_pages(folio));
> > >  	index = kvm_gmem_get_index(slot, gfn);
> > > -	index = ALIGN_DOWN(index, folio_nr_pages(folio));
> > >
> > > -	return __kvm_gmem_prepare_folio(kvm, slot, index, folio);
> > > +	return kvm_arch_gmem_prepare(kvm, gfn, folio_file_pfn(folio, index),
> > 
> > Could this just be folio_pfn(folio) since this function is
> > kvm_gmem_prepare_folio() and guest_memfd will always try to prepare the
> > entire folio?
> 
> No?  Maybe?  For this patch, I'm just trying to shuffle code araound.  Even for
> this series, I'd prefer not to make any more semantic changes than are needed to
> get to a sane state, and to prepare for in-place conversion.  If there's a need
> and/or a good reason to use folio_pfn(), by all means, send a patch.

I take that back.  After far too much staring and digging into the history (and
future) of this code, I finally see what you were getting at.  Because KVM
"prepares" entire folios, grabbing a specific page in the folio is nonsensical,
just grab the base pfn and be done with it.

However, I'm not convinced to committing harder to per-folio "preparation" is the
way to go.  The pre-folio prepation was added when guest_memfd actually tracked
preparedness.  At the time, it made sense, because tracking per-folio meant we
didn't need to add a separate data structure to track that information, and doing
per-folio tracking only works if the entire folio is prepared (or not).

Now that we dropped that code in favor having SNP query the RMP, per-folio
preparation, i.e. per-folio conversions to private, doesn't make as much sense.
There is still technically an argument for per-folio conversion, *if* what I
described below is even allowed by SNP.

If SNP allows the RMP size to be greater than the NPT size, then per-folio
conversion would allow KVM to assign a hugepage in the RMP even if it can only
be mapped into the NPT with a smaller page, e.g. because of memslot alignment.
The documentation of that reasoning would be something like this:

	/* 
	 * If the memory is private from KVM's perspective, and hardware tracks
	 * VM-assigned private memory in a dedicated data structure, i.e. not
	 * in the stage-2 page tables, then call into arch code to assign the
	 * entire folio to the guest.  Assigning the entire folio, e.g. instead
	 * of only the memory being mapped into the guest, allows KVM to assign
	 * an entire hugepage of memory in the out-of-band structure even if
	 * KVM can only map a smaller page size into the MMU, e.g. because the
	 * gmem hugepage is spread across multiple memslots.
	 */
	if (kvm_gmem_is_private_mem(file_inode(file), index))
		r = kvm_gmem_make_private(kvm, slot, gfn, folio);

But it's not clear to me that SNP even supports mismatched page sizes, because
several of the flows in the APM explicitly state that triggers an #NPF, and this
comment in KVM's sev_handle_rmp_fault() also suggests that's not allow.

	 * 2) Guest access via NPT can trigger an #NPF if the NPT mapping is
	 *    smaller than what is indicated by the 2MB RMP entry for the PFN
	 *    that backs the GPA.

And even *if* that's allowed by SNP, I'm not at all convinced it's worth doing
in KVM, because it should be a rare situation.  E.g. maybe for memory at the top
of TOLUD that has holes for non-RAM crud or something?

So instead of using folio_pfn(), I'm leaning strongly towards entirely dropping
what is currently kvm_gmem_prepare_folio(), and instead converting exactly what
is being mapped into the guest.  Because I've messed up the gfn and index handling
twice now, I'm still struggling to wrap my head around the math, *and* I really
don't want to have two separate flows computing "how much memory can be assigned
and at what size" once hugepage support comes along.

I.e. do this:

	pgoff_t index = kvm_gmem_get_index(slot, gfn);
	struct folio *folio;
	int r = 0, __order;

	max_order = max_order ?: &__order;

	CLASS(gmem_get_file, file)(slot);
	if (!file)
		return -EFAULT;

	folio = __kvm_gmem_get_pfn(file, slot, index, pfn, max_order);
	if (IS_ERR(folio))
		return PTR_ERR(folio);

	if (!folio_test_uptodate(folio)) {
		clear_highpage(folio_page(folio, 0));
		folio_mark_uptodate(folio);
	}

	if (kvm_gmem_is_private_mem(file_inode(file), index))
		r = kvm_arch_gmem_make_private(kvm, gfn, *pfn, *max_order);


Am I missing something?  Anyone feel strongly about keeping per-folio converions
for when SNP supports hugepages?
