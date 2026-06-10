Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1512C029D
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 16:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781108313; cv=none; b=MaMIqzA0ZE4sgYQFamhOeUkUwWONy5GXdd+8he8AITbs6hp1+RVjJfh076S74FXndbfKTxLg68DS1MI97n+djDwEjhIkY6PDyW7U5xUT+ploXRqm3W94T8sZwBs9mwcD8Jus78lo5HjCPUs+GHJGQm87GdMF48rCLAVgW02KiS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781108313; c=relaxed/simple;
	bh=zwuJrx0/b8quvWFt76mawx4lCDVNZfzh2UA/HTCJb9c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MIoJVB399ZQbOLwCFt9RUdugJz+XzLv3SYoZnXYm6mPACOInShcc+L77oFac0tLeajYwgADuEeZjJ6Er5GFJxctcXoR8/7LjUS8STExwnFPP7rMBxUwvObU905ZilHftLOdPMnouNBObLk7zSr1K4Yz9xgsUpqI+K6jBP4liAeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nVAYsoZT; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nVAYsoZT"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c0c36f4b76so80144325ad.3
        for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 09:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781108311; x=1781713111; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tYkb0fEp3Wc9CbFkLlm6u5HgKSmOOMvt3al7TMw8h4Q=;
        b=nVAYsoZT+o7t1LQDaNFhAjITKmS7nYe3SafmZ18yJWh8Wnet10aWsuSJtiBnm9Ha1u
         b9khm+kiBJGHt1290gruBMScG5TAi0vLFady2G597z7RiE4iu0bp5kr3orJGO0vGfq1N
         vhJuVVZ1iWzvdUoLAN0XapWiMuESI7JVxwW7wUjChYX1MsxoXpJQ/xZ2FUtGCZ+SAOxl
         1wySuREx7D1Jd3v9LQAd+SXC2R+SwCaM9Y7UE5mgMWE6OI2WzJo/78d3YR/GM7rgBvpZ
         jpqF/vwBkq74ZAuyBJd7FqCNYwhRZS7JPNyFK91ZnTVlMSf7hm/0HvcSWKfYxItbj3Ar
         ZFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781108311; x=1781713111;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tYkb0fEp3Wc9CbFkLlm6u5HgKSmOOMvt3al7TMw8h4Q=;
        b=Y0sLsdmjzp9KYX7X+HHRZW7BaiiAx4x6NdWNNJyDG3KNJIYzEAXtWpDS1i9T7vhe/x
         /xbSoqcy7+Q3kjzvbsVO3qDbN/sNmGExTIo+LhJtHhnAEl4/Xz+69BnSeLtpXYk8WpQz
         jZ0a7/jvl1Ok3HlTlfkOfHhqDnJmWHwX+Ohukmnl06pzuLTnJkzn4Efs1zcF1DOL2I5y
         OJXxU/OAOdOITBZCZurp+EQ223CRB1yncZTPrZzp5z7KsGx2GJALmx3eDv+LZhlOtbZD
         59ZWSiDN4wOqxyBjYCBp9alCW7q0+yhwCqUo2doJHEnNZemXv7xGgD1WpCtjZFew8weu
         Pf1A==
X-Gm-Message-State: AOJu0YweGTzPxYplIdkMsqcbkda3uwMu1Jn5d9YeplF8O2g/VxqcNdlP
	1/455M1Qi4Bscrp4wMaVS5wAjheDM6Zv1YdLIeBpvuCw+Zjv5mth35ySYA5NT71oEsI4hBNZMbh
	/JteZog==
X-Received: from plcx2.prod.google.com ([2002:a17:903:c2:b0:2c1:13e7:a57d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1aef:b0:2c2:7e17:39f6
 with SMTP id d9443c01a7336-2c27e173ecfmr158975595ad.36.1781108310808; Wed, 10
 Jun 2026 09:18:30 -0700 (PDT)
Date: Wed, 10 Jun 2026 09:18:30 -0700
In-Reply-To: <df86b5ccdbdafc3509d9538bd5e6796737bab2db.1781093720.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1781093720.git.ritesh.list@gmail.com> <df86b5ccdbdafc3509d9538bd5e6796737bab2db.1781093720.git.ritesh.list@gmail.com>
Message-ID: <aimOVomL2RzYt2J4@google.com>
Subject: Re: [PATCH v3 RESEND 02/10] KVM: selftests: Add aligned guest
 physical page allocator
From: Sean Christopherson <seanjc@google.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Christophe Leroy <chleroy@kernel.org>, Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	Ackerley Tng <ackerleytng@google.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 10, 2026, Ritesh Harjani (IBM) wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
> 
> powerpc will require this to allocate MMU tables in guest memory that
> are larger than guest base page size.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> [Rebased to latest mainline tree]
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  .../testing/selftests/kvm/include/kvm_util.h  | 20 +++++++++--
>  tools/testing/selftests/kvm/lib/kvm_util.c    | 33 +++++++++----------
>  2 files changed, 33 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index 3666a8530f31..c515c918c2c9 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -991,8 +991,8 @@ void kvm_gsi_routing_write(struct kvm_vm *vm, struct kvm_irq_routing *routing);
>  const char *exit_reason_str(unsigned int exit_reason);
>  
>  gpa_t vm_phy_page_alloc(struct kvm_vm *vm, gpa_t min_gpa, u32 memslot);
> -gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num, gpa_t min_gpa,
> -			   u32 memslot, bool protected);
> +gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num, size_t align,
> +			   gpa_t min_gpa, u32 memslot, bool protected);
>  gpa_t vm_alloc_page_table(struct kvm_vm *vm);
>  
>  static inline gpa_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
> @@ -1003,10 +1003,24 @@ static inline gpa_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
>  	 * protected memory, as the majority of memory for such VMs is
>  	 * protected, i.e. using shared memory is effectively opt-in.
>  	 */
> -	return __vm_phy_pages_alloc(vm, num, min_gpa, memslot,
> +	return __vm_phy_pages_alloc(vm, num, 1, min_gpa, memslot,
>  				    vm_arch_has_protected_memory(vm));
>  }
>  
> +static inline gpa_t vm_phy_pages_alloc_align(struct kvm_vm *vm, size_t num,
> +					     size_t align, gpa_t min_gpa,
> +					     u32 memslot)

Given that the PPC usage is all for naturally aligned allocations, I think it
makes sense for that to be the API, i.e. have "bool naturally_aligned" instead
of an arbitrary alignment.

> +{
> +	/*
> +	 * By default, allocate memory as protected for VMs that support
> +	 * protected memory, as the majority of memory for such VMs is
> +	 * protected, i.e. using shared memory is effectively opt-in.
> +	 */

Duplicating this big comment is very ugly.  In general, these APIs could use
some love.  E.g. taking in @memslot is essentially a historical wart that isn't
necessary except for literally just memslot_perf_test.c, which allocates memory
in a huge number of memslots.

If we rework the APIs to take the memory region type instead of the memslot, then
we can kill many birds with one stone.  It takes quite a bit of cleanup to throw
that one stone, but I think the end result can be quite nice.

Compile tested only at this point, but I now have a series of ~17 patches to yield:

  __weak bool kvm_arch_needs_naturally_aligned_page_tables(void)
  {
	return false;
  }

  gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages,
			   enum kvm_mem_region_type type, bool protected)
  {
	struct userspace_mem_region *region = vm_get_mem_region(vm, type);
	bool naturally_aligned = false;
	gpa_t min_gpa;

	TEST_ASSERT(region, "No region for type '%u', memslot '%u'",
		    type, vm->memslots[type]);

	switch (type) {
	case MEM_REGION_CODE:
	case MEM_REGION_DATA:
	case MEM_REGION_TEST_DATA:
		/*
		 * If the region is backed by the default memslot (id=0), use
		 * selftests' hardcoded minimum PFN, otherwise use the base of
		 * the custom memory slot that backs the region.
		 */
		if (!vm->memslots[type])
			min_gpa = KVM_UTIL_MIN_PFN * vm->page_size;
		else
			min_gpa = region->region.guest_phys_addr;
		break;
	case MEM_REGION_PT:
		min_gpa = KVM_GUEST_PAGE_TABLE_MIN_PADDR;
		naturally_aligned = kvm_arch_needs_naturally_aligned_page_tables();
		break;
	case MEM_REGION_TEST_EXTRA:
		min_gpa = region->region.guest_phys_addr;
		break;
	default:
		TEST_FAIL("Invalid memory region type '%u'", type);
		break;
	}

	return ____vm_phy_pages_alloc(vm, nr_pages, min_gpa, vm->memslots[type],
				      protected, naturally_aligned);
  }

with convenience wrappers:

  static inline gpa_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages,
				       enum kvm_mem_region_type type)
  {
	/*
	 * By default, allocate memory as protected for VMs that support
	 * protected memory, as the majority of memory for such VMs is
	 * protected, i.e. using shared memory is effectively opt-in.
	 */
	return __vm_phy_pages_alloc(vm, nr_pages, type,
				    vm_arch_has_protected_memory(vm));
  }

  static inline gpa_t vm_phy_page_alloc(struct kvm_vm *vm,
				      enum kvm_mem_region_type type)
  {
	return vm_phy_pages_alloc(vm, 1, type);
  }

  static inline gpa_t vm_alloc_page_table_pages(struct kvm_vm *vm, size_t nr_pages)
  {
	return vm_phy_page_alloc(vm, MEM_REGION_PT);
  }

  static inline gpa_t vm_alloc_page_table(struct kvm_vm *vm)
  {
	return vm_alloc_page_table_pages(vm, 1);
  }

That way we don't need to add yet another rarely used param to the APIs, and
PPC just needs to define kvm_arch_needs_naturally_aligned_page_tables().  The
bonus is that @min_gpa goes away too.

It'll probably take me a few days/weeks, but I'll try get a series posted before
the 7.2 merge window closes, so that you can build on top to get the PPC selftests
support landed in 7.3.

> @@ -2039,23 +2039,22 @@ gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
>  	TEST_ASSERT(!protected || region->protected_phy_pages,
>  		    "Region doesn't support protected memory");
>  
> -	base = pg = min_gpa >> vm->page_shift;
> -	do {
> -		for (; pg < base + num; ++pg) {
> -			if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
> -				base = pg = sparsebit_next_set(region->unused_phy_pages, pg);
> -				break;
> +	base = min_gpa >> vm->page_shift;
> +again:
> +	base = (base + align - 1) & ~(align - 1);
> +	for (pg = base; pg < base + num; ++pg) {
> +		if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
> +			base = sparsebit_next_set(region->unused_phy_pages, pg);
> +			if (!base) {
> +				fprintf(stderr, "No guest physical page available, "
> +					"min_gpa: 0x%lx page_size: 0x%x memslot: %u\n",
> +					min_gpa, vm->page_size, memslot);
> +				fputs("---- vm dump ----\n", stderr);
> +				vm_dump(stderr, vm, 2);
> +				abort();
>  			}
> +			goto again;
>  		}
> -	} while (pg && pg != base + num);
> -
> -	if (pg == 0) {
> -		fprintf(stderr, "No guest physical page available, "
> -			"min_gpa: 0x%lx page_size: 0x%x memslot: %u\n",
> -			min_gpa, vm->page_size, memslot);
> -		fputs("---- vm dump ----\n", stderr);
> -		vm_dump(stderr, vm, 2);
> -		abort();
>  	}

This is unnecessary churn.  I'm not saying the current code is pretty or anything,
but unless I'm missing something, this can simply be:

@@ -2025,7 +2027,7 @@ gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages, gpa_t min_gpa,
        TEST_ASSERT(!protected || region->protected_phy_pages,
                    "Region doesn't support protected memory");
 
-       base = pg = min_gpa >> vm->page_shift;
+       base = pg = ALIGN(min_gpa >> vm->page_shift, alignment);
        do {
                for (; pg < base + nr_pages; ++pg) {
                        if (!sparsebit_is_set(region->unused_phy_pages, pg)) {

>  
>  	for (pg = base; pg < base + num; ++pg) {
> -- 
> 2.50.1 (Apple Git-155)
> 
