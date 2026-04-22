Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BDF2D780A;
	Wed, 22 Apr 2026 20:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776889187; cv=none; b=V1kM9upCAildb5Kv5zrWqnvHbZ0t8aKY7IUjviPyECiKxID61D9Q5WxlAHOyGQv849KyB8ZerGSedS1iqf539XdtaXYbNOxwF8B0zCna8B6XgfRfBU9TxPC2q4GTF+4z67xDoyc9ghyywTZAgMDihb6G1fTfcDJYm4S+5hP72ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776889187; c=relaxed/simple;
	bh=VmymqZSlNHKqJ1j2tud/g10QS0Cg2TvqmT88ttFNvUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1F52IBtQe2sr/hA9/ycrCKIfHPOMNO9q7ZRsBVdDOh8Z4FyAbHwbotxRoPQtw4dLqCJb1twjXC+lgxXTBAp5dI/2OORL0XscsfzvNbO0jw/HKodpmo1SHliQLosnw52Xpx6V0EydiKGpBlhVjed5U2DV4fYcXBHvnJaFoF+Lr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwcCsK0j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwcCsK0j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B332BC19425;
	Wed, 22 Apr 2026 20:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776889187;
	bh=VmymqZSlNHKqJ1j2tud/g10QS0Cg2TvqmT88ttFNvUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TwcCsK0jWEpERnj6fn77/McX7WjmOg8rcZliPqj306Z+swnRvkbX8wyIMOHJlq/SG
	 0reOKFo/vD8Ccmj/bWliseYUJstGJa1ng3gjEIH0yUVFO26W6VmlNISyw2E5RXz7Nh
	 cIx2zcHcFpWxZF5QzsGko1v5v+GoI0xFR7fBHEaa/cEmkE1TZTbOuInv0jmKXsZdaR
	 fSCCbTSCB3bKNVpjavSt4HnOVFF175w0m+szXZvmnmnZwMCUbvfG5UxBVMwoRgkpE/
	 6KoWtnhwhDfMJKFHryHD6Do7phu3cojzVNe38LSCldbtRJnqWSGOl5JMjhdKYJPYT6
	 FAHIXp52VEz+g==
Date: Wed, 22 Apr 2026 20:19:45 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Peter Fang <peter.fang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] KVM: Take gpa_t in kvm_vcpu_map[_readonly]()
Message-ID: <aekrJrSRoclZoBo9@google.com>
References: <20260408001137.3290444-1-peter.fang@intel.com>
 <20260408001137.3290444-4-peter.fang@intel.com>
 <aegDJssx-ZvbfggI@google.com>
 <aegF59gToidudIUC@google.com>
 <aegIPGYPH-nxGsua@google.com>
 <CAO9r8zOsHdsMuyjWr3XafjNnMKDci1OOdw8eJHrH-O+jrDH10Q@mail.gmail.com>
 <aegV3ELp20DlC5Ge@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aegV3ELp20DlC5Ge@google.com>

> > > To elaborate a bit, I'm all for adding WARNs in flows where something bad is all
> > > but guaranteed to happen if an assumption is violated, or in APIs where there's
> > > a history of goofs and/or subtlety in how the API behaves.
> > >
> > > What I'm against is adding WARNs because someone could write bad code in the
> > > future, or because KVM doesn't do XYZ at this time.  Such WARNs usualy just add
> > > noise, and can even be actively harmful.  E.g. in this case, ignoring the PID
> > > usage, a reader might look at the WARN and think it's _wrong_ to map a page in
> > > order to access a subset of the page, which is just not true.
> > 
> > Yeah I agree with most/all of your objections to my suggestions, it's
> > usually that I don't have enough context to understand how the WARN
> > could be harmful (like here), or am just being too paranoid or
> > defending against bad code as you mentioned. I was mentioning your
> > objections semi-sarcastically and intentionally bringing up the WARN
> > in case it's actually useful.
> > 
> > Taking a step back, what I really want to clarify and/or detect misuse
> > of, is that kvm_vcpu_map() will map exactly one page, the one that the
> > GPA lies in. For example, there's nothing protecting against the PID
> > address being the last byte of the page, 
> 
> Well, technically there is:
> 
> 	    CC(!kvm_vcpu_is_legal_aligned_gpa(vcpu, vmcs12->posted_intr_desc_addr, 64))))
> 		return -EINVAL;
> 
> But I'm pretty sure what you're saying is that "nothing in the common helper code
> protects against a stupid caller".

Yes. Now I am actually glad I brought up the WARN and you elaborated
your thoughts, because it made me think and spell out my actual concern
(that my brain translated into just WARN initiailly): we need bounds
checking.

> 
> > in which case accessing all of it would be wrong as it spans the mapped page
> > boundary. This is difficult to hit if you are passing in a GFN, as it's more
> > obvious that KVM is mapping one physical page.
> 
> Eh, that just leads to a different class of bugs (and possible even *worse* bugs).
> E.g. caller passes in a GFN, accesses the kernel mapping beyond the page, and
> reads/write arbitrary kernel memory (pfn_valid() case using the direct map), or
> hits a !PRESENT #PF (remap case).
> 
> > Perhaps we just need to rename the functions (e.g.
> > kvm_vcpu_map_page()), or more intrusively pass in a size and do bounds
> > checking.
> 
> Definitely the latter.  Or both I guess, but probably just the latter.

I think both. I think renaming to kvm_vcpu_map_page() (and similar for
others) would further clarify things, especially with the introduction
of kvm_vcpu_map_ptr() below.

> 
> Commit 025dde582bbf ("KVM: Harden guest memory APIs against out-of-bounds accesses")
> added that type of hardening for the "slow" APIs, exactly because of the type of
> OOB bug you're describing: commit f559b2e9c5c5 ("KVM: nSVM: Ignore nCR3[4:0] when
> loading PDPTEs from memory").
> 
> Actually, that's actually useful feedback for patch 3.  __kvm_vcpu_map() should
> do the GPA=>GFN conversion, not its caller.

Yes.

> 
> Anyways, back to the hardening.  We can do it with minimal additional churn.  After
> patch 3 (passing a @gpa to __kvm_vcpu_map(), not a @gfn), do the below over a few
> patches (completely untested).  This way the common case of mapping and accessing
> an entire page Just Works, and flows like the PI descriptor handling don't have to
> many provide the length (which also can be error prone).

Yeah probably this (maybe not in the same order):
- Convert map->pfn to map->hpa.
- Pass size to __kvm_vcpu_map() and do bounds checking.
- Rename kvm_vcpu_map() and __kvm_vpcu_map() to kvm_vcpu_map_page() and
  __kvm_vcpu_map_page().
- Introduce kvm_vcpu_map_ptr() wrapper and simplify the nested PID call
  site.

Generally looks good with a small nit/question below. Peter, would you
be interested in extending the series to do this? If not, I can send a
follow up on top of your series when it's hashed out.

[..]
> @@ -1893,22 +1894,31 @@ static inline hpa_t pfn_to_hpa(kvm_pfn_t pfn)
>  	return (hpa_t)pfn << PAGE_SHIFT;
>  }
>  
> -int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *map,
> -		   bool writable);
> +int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gpa_t gpa, gpa_t len,
> +		   struct kvm_host_map *map, bool writable);
>  void kvm_vcpu_unmap(struct kvm_vcpu *vcpu, struct kvm_host_map *map);
>  
>  static inline int kvm_vcpu_map(struct kvm_vcpu *vcpu, gpa_t gpa,
>  			       struct kvm_host_map *map)
>  {
> -	return __kvm_vcpu_map(vcpu, gpa_to_gfn(gpa), map, true);
> +	return __kvm_vcpu_map(vcpu, gpa, PAGE_SIZE, map, true);
>  }
>  
>  static inline int kvm_vcpu_map_readonly(struct kvm_vcpu *vcpu, gpa_t gpa,
>  					struct kvm_host_map *map)
>  {
> -	return __kvm_vcpu_map(vcpu, gpa_to_gfn(gpa), map, false);
> +	return __kvm_vcpu_map(vcpu, gpa, PAGE_SIZE, map, false);
>  }
>  
> +#define kvm_vcpu_map_ptr(__vcpu, __gpa, __ptr, __map)				\
> +({										\
> +	int r;									\
> +										\
> +	r = __kvm_vcpu_map(__vcpu, __gpa, sizeof(*(__ptr)), __map, true);	\
> +	__ptr = !r ? (__map)->hva : NULL;					\
> +	r;									\
> +})
> +
>  static inline void kvm_vcpu_map_mark_dirty(struct kvm_vcpu *vcpu,
>  					   struct kvm_host_map *map)
>  {
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 9093251beb39..e8d2e98b0068 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -3114,9 +3114,10 @@ struct page *__gfn_to_page(struct kvm *kvm, gfn_t gfn, bool write)
>  }
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(__gfn_to_page);
>  
> -int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *map,
> -		   bool writable)
> +int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gpa_t gpa, gpa_t len,
> +		   struct kvm_host_map *map, bool writable)
>  {
> +	gfn_t gfn = gpa_to_gfn(gpa);
>  	struct kvm_follow_pfn kfp = {
>  		.slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn),
>  		.gfn = gfn,
> @@ -3124,6 +3125,10 @@ int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *map,
>  		.refcounted_page = &map->pinned_page,
>  		.pin = true,
>  	};
> +	kvm_pfn_t pfn;
> +
> +	if (WARN_ON_ONCE(offset_in_page(gpa) + len > PAGE_SIZE))
> +		return -EINVAL;

Maybe do the bounds checking after initializing 'map', then
kvm_vcpu_map_ptr() wouldn't need to explicitly set the pointer to NULL
on failure? There is already possibility of failure after initialization
anyway.

>  
>  	map->pinned_page = NULL;
>  	map->page = NULL;
> @@ -3131,20 +3136,25 @@ int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *map,
>  	map->gfn = gfn;
>  	map->writable = writable;
>  
> -	map->pfn = kvm_follow_pfn(&kfp);
> -	if (is_error_noslot_pfn(map->pfn))
> +	pfn = kvm_follow_pfn(&kfp);
> +	if (is_error_noslot_pfn(pfn))
>  		return -EINVAL;
>  
> -	if (pfn_valid(map->pfn)) {
> -		map->page = pfn_to_page(map->pfn);
> +	map->hpa = pfn_to_hpa(pfn);
> +	if (pfn_valid(pfn)) {
> +		map->page = pfn_to_page(pfn);
>  		map->hva = kmap(map->page);
>  #ifdef CONFIG_HAS_IOMEM
>  	} else {
> -		map->hva = memremap(pfn_to_hpa(map->pfn), PAGE_SIZE, MEMREMAP_WB);
> +		map->hva = memremap(map->hpa, PAGE_SIZE, MEMREMAP_WB);
> +		if (!map->hva)
> +			return -EFAULT;
>  #endif
>  	}
>  
> -	return map->hva ? 0 : -EFAULT;
> +	map->hpa += offset_in_page(gpa);
> +	map->hva += offset_in_page(gpa);
> +	return 0;
>  }
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(__kvm_vcpu_map);
[..]
