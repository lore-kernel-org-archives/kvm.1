Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE1147A0BE
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 17:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781197931; cv=none; b=cUELJXIMPe3MJjTbkDv6UQ/XXvfqazEWP5uFAnN6G2xEW3eyc/KOeHqlxElxD5ujob861h4LaeOFCZQTi4ZBsOVBjodSyzXJ9nPn34hFootZxeghAay4v7Zk9KngvxOLT1ohS7f8oefx06fUmXb2cxX6CJ9GSQpixprZcs+yLp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781197931; c=relaxed/simple;
	bh=zCp/n6m+JRShvAS1UOjVo4sd9xkDrLGks43l0QNZjbk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=MjP40R03JRCz3rSb0NX8Vk+Rj7G2tirTz7pjHli8Z4gdHtlJEgT7qgdreIPWjWaTLpv6aaEtXxf6auwiVRjWH8T3XNNTtrGxsEoolL6yySlKM570C30aR79rcwyZcxRfoezcal0udCv2tFd9C+bzP3/8W/VdhYiBvE3sd9N9Zt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUVkAsee; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUVkAsee"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36bb3551f6eso171527a91.1
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 10:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781197929; x=1781802729; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QUhb0LXL29TRj1XmX4fg/eZOCymWXris1Gg/NE+c6fU=;
        b=XUVkAseeyeMJ9Xn1LKfd8JcSMVSILzgV9heRoa05prHkLpAFnAYYoZev9e63RwxxWf
         lTzaMiDkpXtbuJrnVdi/m5JcXLFXQZsyHsP9O8uYzt14Se/vYwWHPoBFOCxNLFABI7Rd
         SQ9pBlLJEAbqk09n5YaM5i/UX2GeRbM82vvIvpnl4zQkPPWiB1lXd7qQqLXQiCuF8XVa
         iEUA87gi0yHBhKyDIXyKG2YkAV6lHzpBqiMEbbovKlzmCFmctZHW1vKDswIAnSGU27Fc
         4geJK1zPiw4NEMdZQlRE7GPjLU6b5V29bCCRlKugFV4FHhIVtONy3agvRgLKnRUlx7SB
         yQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781197929; x=1781802729;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QUhb0LXL29TRj1XmX4fg/eZOCymWXris1Gg/NE+c6fU=;
        b=SPjrmRIOhwO8Luf5pBU/Fy4a9GQZ6bBv6dM4QIkdSd5OC3+i5+VliwDEvbE8dOyZkt
         EbPb59CRW0jU0oWCIUlwcV2Zoo8smUxUiNr4k7iulOJu/tCsmyVDFkDE3kUPf4MJxkgX
         AO9v/Uc+9nvzcgdOIktvPg2APEMqgzhKFDubPjRzgYlDaMBiGN9lAOgiBzgk49bgg4I3
         ObS0LiqxWSS/jM53SKeZCv3p47w0pCjlNXcHCZEcnDpSN02lFyJBikaH8BMAweJSvTr1
         oXqnPf6N/os4fnmHtH86vLzh0DV4Cc1dfq+484EV/ROe+IbTret3396Ev55AQsA3rW3B
         iHiA==
X-Gm-Message-State: AOJu0YxKHtqf9/smICPZ9hxlgt1LCfQG7OJKP2mpAPLHpjE3IPmDQ2yH
	Qy0Gb2AwyV6mGa00Ucuhn4YuqXrjoLPdv3Q2Rj1yMBBTCfsvDEArUHvU
X-Gm-Gg: Acq92OEPC+UVW56Cz/p1ZimveiMzHixhVxZBHqYiW4/yd2wHOcLoJLrSSsSMTApMSdQ
	fxblrm8/1BgyZ9CRdDsjirNeqZFeYY6lhZVYhVqO/6G7BxsW9wY3bVT6DIUVUAoWHp8OF3W/5yh
	NPYbpuaBSVG3uCXs0XcmIAqrvA0JHT5nB0Wtek0KwlnYbyrQFO7Xd537cOUECWbZG7usZyj8n/P
	fv5FqNhvOhkZObIkilPHKtdfu7q916EC8v9hbUSPTEkmSruGn2zHQoIzJXe0LGwUA2Lm0GDqAWf
	3GwQZzkCyaHfNPnHs1pQ6mckhNLF4kP/8VYAl+WkbpWjxmLoR73PFTg/ym2IBIwShrVjqwAc3qU
	CpxYE3PjMpmPuqKuHIeS/iQQiTql1jynIcpRNddYJ74YtYNquyM2w2xggaWgo1Md6H+QGw7ImN0
	1CY+fTpeaPBy0OPrDjiW8Sxxlax6r50BUIwSIL
X-Received: by 2002:a17:90a:e185:b0:36a:f612:e6a3 with SMTP id 98e67ed59e1d1-377a8bd3113mr4246286a91.17.1781197928626;
        Thu, 11 Jun 2026 10:12:08 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3775549af60sm3035656a91.12.2026.06.11.10.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 10:12:07 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Ackerley Tng <ackerleytng@google.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 RESEND 02/10] KVM: selftests: Add aligned guest physical page allocator
In-Reply-To: <aimOVomL2RzYt2J4@google.com>
Date: Thu, 11 Jun 2026 22:00:19 +0530
Message-ID: <ldcldopw.ritesh.list@gmail.com>
References: <cover.1781093720.git.ritesh.list@gmail.com> <df86b5ccdbdafc3509d9538bd5e6796737bab2db.1781093720.git.ritesh.list@gmail.com> <aimOVomL2RzYt2J4@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Sean Christopherson <seanjc@google.com> writes:

> On Wed, Jun 10, 2026, Ritesh Harjani (IBM) wrote:
>> From: Nicholas Piggin <npiggin@gmail.com>
>> 
>> powerpc will require this to allocate MMU tables in guest memory that
>> are larger than guest base page size.
>> 
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> [Rebased to latest mainline tree]
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>  .../testing/selftests/kvm/include/kvm_util.h  | 20 +++++++++--
>>  tools/testing/selftests/kvm/lib/kvm_util.c    | 33 +++++++++----------
>>  2 files changed, 33 insertions(+), 20 deletions(-)
>> 
>> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
>> index 3666a8530f31..c515c918c2c9 100644
>> --- a/tools/testing/selftests/kvm/include/kvm_util.h
>> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
>> @@ -991,8 +991,8 @@ void kvm_gsi_routing_write(struct kvm_vm *vm, struct kvm_irq_routing *routing);
>>  const char *exit_reason_str(unsigned int exit_reason);
>>  
>>  gpa_t vm_phy_page_alloc(struct kvm_vm *vm, gpa_t min_gpa, u32 memslot);
>> -gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num, gpa_t min_gpa,
>> -			   u32 memslot, bool protected);
>> +gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num, size_t align,
>> +			   gpa_t min_gpa, u32 memslot, bool protected);
>>  gpa_t vm_alloc_page_table(struct kvm_vm *vm);
>>  
>>  static inline gpa_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
>> @@ -1003,10 +1003,24 @@ static inline gpa_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
>>  	 * protected memory, as the majority of memory for such VMs is
>>  	 * protected, i.e. using shared memory is effectively opt-in.
>>  	 */
>> -	return __vm_phy_pages_alloc(vm, num, min_gpa, memslot,
>> +	return __vm_phy_pages_alloc(vm, num, 1, min_gpa, memslot,
>>  				    vm_arch_has_protected_memory(vm));
>>  }
>>  
>> +static inline gpa_t vm_phy_pages_alloc_align(struct kvm_vm *vm, size_t num,
>> +					     size_t align, gpa_t min_gpa,
>> +					     u32 memslot)
>
> Given that the PPC usage is all for naturally aligned allocations, I think it
> makes sense for that to be the API, i.e. have "bool naturally_aligned" instead
> of an arbitrary alignment.
>

I would still prefer passing an explicit align value to the allocator,
because IMHO that's a useful allocator interface to have.

However, if we do want to go down this road than I don't have any strong
objection either, since as you mentioned powerpc mostly just needs
natual alignment for it's page table region. So alignment can be
extracted from the region type as you described below, so no need to
pass it all the time.

>> +{
>> +	/*
>> +	 * By default, allocate memory as protected for VMs that support
>> +	 * protected memory, as the majority of memory for such VMs is
>> +	 * protected, i.e. using shared memory is effectively opt-in.
>> +	 */
>
> Duplicating this big comment is very ugly.

yes, my bad. I should have removed one copy of the comment.

> In general, these APIs could use
> some love.  E.g. taking in @memslot is essentially a historical wart that isn't
> necessary except for literally just memslot_perf_test.c, which allocates memory
> in a huge number of memslots.
>
> If we rework the APIs to take the memory region type instead of the memslot, then
> we can kill many birds with one stone.  It takes quite a bit of cleanup to throw
> that one stone, but I think the end result can be quite nice.
>
> Compile tested only at this point, but I now have a series of ~17 patches to yield:
>
>   __weak bool kvm_arch_needs_naturally_aligned_page_tables(void)
>   {
> 	return false;
>   }
>
>   gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages,
> 			   enum kvm_mem_region_type type, bool protected)
>   {
> 	struct userspace_mem_region *region = vm_get_mem_region(vm, type);
> 	bool naturally_aligned = false;
> 	gpa_t min_gpa;
>
> 	TEST_ASSERT(region, "No region for type '%u', memslot '%u'",
> 		    type, vm->memslots[type]);
>
> 	switch (type) {
> 	case MEM_REGION_CODE:
> 	case MEM_REGION_DATA:
> 	case MEM_REGION_TEST_DATA:
> 		/*
> 		 * If the region is backed by the default memslot (id=0), use
> 		 * selftests' hardcoded minimum PFN, otherwise use the base of
> 		 * the custom memory slot that backs the region.
> 		 */
> 		if (!vm->memslots[type])
> 			min_gpa = KVM_UTIL_MIN_PFN * vm->page_size;
> 		else
> 			min_gpa = region->region.guest_phys_addr;
> 		break;
> 	case MEM_REGION_PT:
> 		min_gpa = KVM_GUEST_PAGE_TABLE_MIN_PADDR;
> 		naturally_aligned = kvm_arch_needs_naturally_aligned_page_tables();
> 		break;
> 	case MEM_REGION_TEST_EXTRA:
> 		min_gpa = region->region.guest_phys_addr;
> 		break;
> 	default:
> 		TEST_FAIL("Invalid memory region type '%u'", type);
> 		break;
> 	}
>
> 	return ____vm_phy_pages_alloc(vm, nr_pages, min_gpa, vm->memslots[type],
> 				      protected, naturally_aligned);
>   }
>
> with convenience wrappers:
>
>   static inline gpa_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages,
> 				       enum kvm_mem_region_type type)
>   {
> 	/*
> 	 * By default, allocate memory as protected for VMs that support
> 	 * protected memory, as the majority of memory for such VMs is
> 	 * protected, i.e. using shared memory is effectively opt-in.
> 	 */
> 	return __vm_phy_pages_alloc(vm, nr_pages, type,
> 				    vm_arch_has_protected_memory(vm));
>   }
>
>   static inline gpa_t vm_phy_page_alloc(struct kvm_vm *vm,
> 				      enum kvm_mem_region_type type)
>   {
> 	return vm_phy_pages_alloc(vm, 1, type);
>   }
>
>   static inline gpa_t vm_alloc_page_table_pages(struct kvm_vm *vm, size_t nr_pages)
>   {
> 	return vm_phy_page_alloc(vm, MEM_REGION_PT);
>   }
>
>   static inline gpa_t vm_alloc_page_table(struct kvm_vm *vm)
>   {
> 	return vm_alloc_page_table_pages(vm, 1);
>   }
>
> That way we don't need to add yet another rarely used param to the APIs, and
> PPC just needs to define
> kvm_arch_needs_naturally_aligned_page_tables().

yup, looks good.

> The bonus is that @min_gpa goes away too.

powerpc needs min_gpa for it's exception handling pages. see.

	excp_paddr = vm_phy_pages_alloc(vm, excp_pages, 0,
					vm->memslots[MEM_REGION_DATA]);

	TEST_ASSERT(excp_paddr == 0,
		    "Interrupt vectors not allocated at gPA address 0: (0x%lx)",
		    excp_paddr);

So, will arch still have an access to the API for passing min_gpa = 0
for cases like above?

>
> It'll probably take me a few days/weeks, but I'll try get a series posted before
> the 7.2 merge window closes, so that you can build on top to get the PPC selftests
> support landed in 7.3.
>

Thanks Sean for your help! Yes, landing kvm selftests for powerpc will
be definitely helpful to verify against any kvm regressions.

BTW, I was thinking whether landing powerpc first will be easier for you
to consider all the API requirements from all users / usecases?  But
either way is fine please. I can work on top of your changes too and if
something is missing for powerpc, we can add / modify on top, once your
series is finished.


>> @@ -2039,23 +2039,22 @@ gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
>>  	TEST_ASSERT(!protected || region->protected_phy_pages,
>>  		    "Region doesn't support protected memory");
>>  
>> -	base = pg = min_gpa >> vm->page_shift;
>> -	do {
>> -		for (; pg < base + num; ++pg) {
>> -			if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
>> -				base = pg = sparsebit_next_set(region->unused_phy_pages, pg);
>> -				break;
>> +	base = min_gpa >> vm->page_shift;
>> +again:
>> +	base = (base + align - 1) & ~(align - 1);
>> +	for (pg = base; pg < base + num; ++pg) {
>> +		if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
>> +			base = sparsebit_next_set(region->unused_phy_pages, pg);
>> +			if (!base) {
>> +				fprintf(stderr, "No guest physical page available, "
>> +					"min_gpa: 0x%lx page_size: 0x%x memslot: %u\n",
>> +					min_gpa, vm->page_size, memslot);
>> +				fputs("---- vm dump ----\n", stderr);
>> +				vm_dump(stderr, vm, 2);
>> +				abort();
>>  			}
>> +			goto again;
>>  		}
>> -	} while (pg && pg != base + num);
>> -
>> -	if (pg == 0) {
>> -		fprintf(stderr, "No guest physical page available, "
>> -			"min_gpa: 0x%lx page_size: 0x%x memslot: %u\n",
>> -			min_gpa, vm->page_size, memslot);
>> -		fputs("---- vm dump ----\n", stderr);
>> -		vm_dump(stderr, vm, 2);
>> -		abort();
>>  	}
>
> This is unnecessary churn.  I'm not saying the current code is pretty or anything,
> but unless I'm missing something, this can simply be:
>

Not really, we need the base to be aligned everytime, that's why the
goto again loop aligns the base in the new code. Plus I feel the above
refactoring also simplifies the special handling of pg == 0 case, which
earlier was being handled separately after the loop ends.

> @@ -2025,7 +2027,7 @@ gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages, gpa_t min_gpa,
>         TEST_ASSERT(!protected || region->protected_phy_pages,
>                     "Region doesn't support protected memory");
>  
> -       base = pg = min_gpa >> vm->page_shift;
> +       base = pg = ALIGN(min_gpa >> vm->page_shift, alignment);
>         do {
>                 for (; pg < base + nr_pages; ++pg) {
>                         if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
>
>>  
>>  	for (pg = base; pg < base + num; ++pg) {
>> -- 
>> 2.50.1 (Apple Git-155)
>> 

Thanks once again for your help with this!

-ritesh
