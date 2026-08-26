Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689C547DF94
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 19:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773498; cv=none; b=pnPUG3vJ/mXqxQGUIaYSPmYCj1sooJwwy4XxbQ+6JNI0WMnmm5HmHJjLpYJqzhnIR4qq6CO1itt4+NdplKFDj1KuV2OTCcABU/8gRNvOfsZfqzYrdu8tXArHjibcsV8D+aOwmDBVoc4Kvp00q8xExqFf37bQjww3nVrxOQbFc2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773498; c=relaxed/simple;
	bh=4uZPzlY33aYdoyT/xRZbAIP4+YBkQh6pbbwV+qhDm9o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LoCsh7ZmJYsCJ1Tqw9PlRf/TST6SouwgefomVl7Q4Sf06627gfs5VgghJQOyIzAZUUyJG/PdSWmwMZBLPn79lm8HiXtEPoHszND40eIgsZkgM518ivlu8NtVlfhiLVWzhZmOJd7VNpV/ahlG+uErBwQ5JgJDoG0WoEnLbitkYC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F9fJ2oxk; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F9fJ2oxk"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cbb467e56aaso1035408a12.1
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 12:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787773482; x=1788378282; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kAAUyb+BT/S16pFGAm4l7OAoO0iSt3CMmhZez+eRZtg=;
        b=F9fJ2oxkdgl0eiteWV1ixsN6qOcIqGb+oWpZJNjNftBAzzqQi69cUHU8A49W9Ogpv3
         tbiiWzGxOdt0zEfK+Ipt3yU+B8To3hbf0LItcX2uXJj63vWpmU7VYGRolp5RYXSTCkBO
         vasf/F2NhQC+8YzisXODKc+uepKhB77wunWsAZtWGVHdssAR4JZdlU1+4BPWA7wsXtf/
         fKd3a+8xXFme6yWfvA8e3BXO0klMEmAAFeFv0djfazS6KwrAYF+DF0YX0L1bfUh1cFYB
         lZ/Mbe1ha9vEkOn8Grha7uMsL799mlM/WLXgEXzT1s+KNqCEYHNZmeaGUCGXF5syWoIv
         lY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787773482; x=1788378282;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kAAUyb+BT/S16pFGAm4l7OAoO0iSt3CMmhZez+eRZtg=;
        b=YdcbctL6bhlzVbc1FhYu0us62vC3mMhjPEwdg/I6aCgNeq11zwuD9mB1kYy8RPjLQ4
         y87hwg9PFIg6Ha1xrBYAe9yyuo8eb863B9UiOPNlHaVz4EsT2X0V6wMb0ri7ijDf0gbC
         wtWnWXY6C2dAHiAiHvpFzKP4zcXG1Ma69UAdQIsUU+Ax1Yq5MuTGCDBOHjUNNz1pB3BG
         +o7Kt/WYyKwdPGRMAZoqJ9m+793vjctBGtkPVPMXrUCp448HVW+KliRTUcuP2KxUisT0
         MhWTULpIshcYT1PFZLurvh34PiyZSNQyRElUQ9yRsQcR1dcxtfGUiAGc/XrPdxJF/B5Z
         s/bg==
X-Forwarded-Encrypted: i=1; AHgh+RoFyaHTN8hpMKpFsciPuidU3fyz5TcMUTYKrtMQIiFt5ncRRxscDzhRETFGHyYWIhYC/8A=@vger.kernel.org
X-Gm-Message-State: AFuF++k6PmLAGnxxiYpY0DY9VmIJbuJWm/ctVqAf6nL4fV4X2RxBQz7x
	oIqieEsLHqzmMAPfvx7Qur27f9uAo/5RBgG+AhvBwL/rUVW8hXPklMdP/6e0vky/47vCh6Yo7go
	U3/bbOg==
X-Received: from pgak6.prod.google.com ([2002:a05:6a02:6746:b0:cbe:9e80:c394])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3216:b0:3c0:b943:f984
 with SMTP id adf61e73a8af0-3cf76286193mr19120390637.3.1787773481481; Wed, 26
 Aug 2026 12:44:41 -0700 (PDT)
Date: Wed, 26 Aug 2026 12:44:40 -0700
In-Reply-To: <20260826-gmem-inplace-conversion-v11-15-0a15d8a799aa@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com> <20260826-gmem-inplace-conversion-v11-15-0a15d8a799aa@google.com>
Message-ID: <ao9CKMXAX-hScRSa@google.com>
Subject: Re: [PATCH v11 15/46] KVM: guest_memfd: Call arch make_shared
 callback for to-shared conversion
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
	suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Fuad Tabba <fuad.tabba@linux.dev>, Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 26, 2026, Ackerley Tng wrote:
> Omit support for calling the arch hook to make private, since SNP, the only
> implementer of the arch make-private hook today, would actually prefer
> making private only just before faulting memory into the NPTs.
> 
> Calling the make-private arch hook would require iterating both bindings
> and the filemap to find the intersection of bindings and allocated
> folios.

Why would KVM need to iterate over the bindings?  Only the RMP needs to be updated,
whether or not the RMP is currently reachable is irrelevant, no?

Subsequent calls to kvm_arch_gmem_make_private() from kvm_gmem_get_pfn() would be
superfluous, but that's already possible, e.g. if an NPT mappings is removed for
whatever reason.

> On top of that, SNP would need to figure out whether to actually
> make private based on whether the memory is about to be faulted, or
> whether it is a conversion.

This is a non-issue, no?  As above, sev_gmem_make_private() already bails early
if the page is already assigned in the RMP.

I don't care terribly about how SNP handles this, but I do want accurate reasoning
and justification so that if/when we revisit any of this in the future, we can make
informed decisions.  Because unless I'm missing something, this is an optimization
choice (eager vs. lazy to-private conversions), not a complexity tradeoff, and it's
not clear to me how we decided the lazy approach would provide better performance.

> Calling the make-shared arch hook and not the make-private arch hook does
> leak SNP-specific details into guest_memfd (as in, why only make-shared
> during conversions but not make-private?), but the additional complexity is
> not worth taking on until guest_memfd has a user actually requiring an arch
> make-private call.

...

> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
> +static void kvm_gmem_make_shared(struct inode *inode, pgoff_t start, pgoff_t end)
> +{
> +	struct folio_batch fbatch;
> +	pgoff_t next = start;
> +	int i;
> +
> +	folio_batch_init(&fbatch);
> +	while (filemap_get_folios(inode->i_mapping, &next, end - 1, &fbatch)) {
> +		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
> +			struct folio *folio = fbatch.folios[i];
> +			pgoff_t start_index, end_index;
> +			kvm_pfn_t start_pfn;
> +			kvm_pfn_t nr_pages;
> +
> +			start_index = max(start, folio->index);
> +			end_index = min(end, folio_next_index(folio));
> +			/*
> +			 * end_index is either in folio or points to
> +			 * the first page of the next folio. Hence,
> +			 * all pages in range [start_index, end_index)
> +			 * are contiguous.
> +			 */
> +			start_pfn = folio_file_pfn(folio, start_index);
> +			nr_pages = end_index - start_index;
> +
> +			kvm_arch_gmem_make_shared(start_pfn, nr_pages);
> +		}
> +
> +		folio_batch_release(&fbatch);
> +		cond_resched();
> +	}
> +}
> +#else
> +static void kvm_gmem_make_shared(struct inode *inode, pgoff_t start, pgoff_t end) {}
> +#endif
> +
>  static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
>  				     size_t nr_pages, uint64_t attrs,
>  				     pgoff_t *err_index)
> @@ -624,7 +661,12 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
>  
>  	filter = to_private ? KVM_FILTER_SHARED : KVM_FILTER_PRIVATE;
>  	kvm_gmem_invalidate_start(inode, start, end, filter);
> +
> +	if (!to_private && kvm_arch_has_gmem_convert())
> +		kvm_gmem_make_shared(inode, start, end);
> +
>  	mas_store_prealloc(&mas, xa_mk_value(attrs));
> +
>  	kvm_gmem_invalidate_end(inode, start, end);

The real reason I responded...

Thinking about the Secure AVIC mess made me realize zapping NPTs for SNP VMs isn't
strictly necessary in this path.  The PFN isn't changing, just the attributes, and
that's (obviously) tracked in the RMP.  KVM doesn't need to zap SPTEs to induce a
fault, because the mismatched C-bit vs. RMP status will cause an #NPF(RMP), and
AFAICT kvm_mmu_page_fault() will do the right thing.  A misbehaving guest could
continue to access the shared data (assuming we stick with lazy conversions), but
that should be fine?  E.g. it's not really any different than implicit conversions.

In other words, couldn't we do this (as an on-top optimization)?  The only wrinkle
I can think of is that it could delay reconstituion of a hugepage, especially if
we opted for eager conversion (because the guest wouldn't hit #NPFs to trigger the
hugepage promotion).

diff --git arch/x86/kvm/mmu/mmu.c arch/x86/kvm/mmu/mmu.c
index 62f751952ad8..61f3e270ab61 100644
--- arch/x86/kvm/mmu/mmu.c
+++ arch/x86/kvm/mmu/mmu.c
@@ -1670,6 +1670,7 @@ static bool __kvm_rmap_zap_gfn_range(struct kvm *kvm,
 
 bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
 {
+       unsigned long shared_private =  KVM_FILTER_SHARED | KVM_FILTER_PRIVATE;
        bool flush = false;
 
        /*
@@ -1683,6 +1684,10 @@ bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
        lockdep_assert_once(kvm->mmu_invalidate_in_progress ||
                            lockdep_is_held(&kvm->slots_lock));
 
+       if (gmem_in_place_conversion && !kvm_has_mirrored_tdp(kvm) &&
+           ((range->attr_filter & shared_private) != shared_private))
+               return false;
+
        if (kvm_memslots_have_rmaps(kvm))
                flush = __kvm_rmap_zap_gfn_range(kvm, range->slot,
                                                 range->start, range->end,
