Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71490331EBF
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 14:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781275467; cv=none; b=dbzs5q7BjlWWmtcqdP25MUHCukm3wPKLDhzh3waVAWz6gRQ7ECwAIjle3NklWY5aiV+2x7sjx299Lr8Scl4Dcus0Y3XXFv1jcBMP18bpzlAUqU429CvR5yHlYY/nXJ35aTsoKx90gcX8l6ESqxGEBRIdB3m00iJB36Q7xHV6eeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781275467; c=relaxed/simple;
	bh=8xQFOW87PPfIKh9pXDO1PhGcSGszaXpRVhY1KZyzeS8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=ocoEy73uLyY7vEDu5p3AlISn16r5N+DRT5DkWQNFm9LDKuuJOgWGgRUMqdXNrkCP2QEwaREF/fhSLZMOnx9hLDzOW83ch9zPm5ayUml2pf2eS5nUU9N/opS23kO54dnB+yvqg2C5vKQ9YbuASIm4cpsw/rqqRtMeow2osQiEd5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oKXVqFSD; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oKXVqFSD"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c0c1e0b0faso6940105ad.0
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 07:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781275465; x=1781880265; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JTJ6LQiVaizRbhp8ioa0/mpPc2OvfEQezfKHZpIfGYU=;
        b=oKXVqFSDLX4FLiNugW3NGVFIFgJEBmfO21e0SZ9ZCBhe2TQ36KhTOcOymi45zBBU5i
         lrIW5GKlkbH2WM1EdsGvDT2HPNwL7AI1k1cRGppmUAhk7O7g22W0ylAWYDpIjY9oyfKu
         /pOYCiFX0BEwas/PLlTESqtSmO9V5CR+8Um+mrEh9qXmokQyUl0uP8EhCUX6dDQLkDex
         7AQWNEoQnKJ1YnQ5XvDEnKfaPvhaDHgaWjE4ZokuzYhc76i6bPhv/2ihM3mbTsiygxbK
         2aZ3juhe9u2GQigfMvh4PlyENRcMjohugqW+y5WjustIUx/lkFdy6+r8er4PYBh7zakY
         awgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781275465; x=1781880265;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JTJ6LQiVaizRbhp8ioa0/mpPc2OvfEQezfKHZpIfGYU=;
        b=aXZkyP2VtiLSQrs66BJi64pRRicbbGNi/LpSgwsHr2XlfTKV2jBfZToOZTgwUc7Qow
         7yLBlx+Tom0yQ3diIZDhrBuTpJTgCeMH1bT9pnpIJYX9BucjoY6NtAOfSzfFpNBez6Gx
         F9fI/RZKZdgdzeRLNPjHNlrlm/PT1oBeI9Saa8d0OFj8Liwl9NAAn/pXgy6UuTtpfq68
         VrC66qXsjFyMDRPbETCnds5IIDPL3el054az5nRG5AAnEvDDE1lUOwml/UYc0Mm1rUjI
         rKakN3+xAXle9YP0lY2qafWtk/h+vYudAS5ZqR87Iw7VgrRM4E0GIvfh+61bVGw2bMOS
         Rl2g==
X-Gm-Message-State: AOJu0Yx9/J/noobMaR5BU5NuEkcuBDnPvbEVm3N33sSaTKErvDVtT2Sw
	sbEXesDNUB0BiwRjkBoM/u1R/GofQ/gSd0vAgZkGmsugiFcbw/mtJtZz
X-Gm-Gg: Acq92OGDH3NvxE2JhoaPTVQEh6tQyNsLYm59rJSEeTW3u5T8TU/48+m/Ty2qnorFBbW
	5nc5wUOfPQWwsN8RM9BT1d0YIAKhU6MbYuEG86mw7in1ODvWPfnjpyRmfPEpi9Io1np0Z6ebRb4
	n0uM0oaJhI45B5Gcs/8oR/tpFEdm1Q0E+U2uLe/VvUj0kUw6JqpadaKh2iqjIdBlguYhH7pPeW/
	5oSWKUAfn/ojLSlKRhobTAGweW8cETD7zwD/ooF9dUsOZ17u0yAavMY6gQ2IfhmJY2PKiubqCo8
	SpDxYkcByGCYCniW/eBdHuNy3yHbK8lg38oqsKil7PxPwrO5A0ecFiTg7edcjzMik/Ql2LbWS7b
	+u6/KqEwk2LT8Dv2F1ram+MsZ5MPZGdZ423ShJ37Xj7EvRdlpjOpOt8GErCgMxkHXFy7orDoGs7
	06TIRHbQm+hlRal2KnmER+lgrmwQ==
X-Received: by 2002:a17:903:2352:b0:2c2:27be:39a3 with SMTP id d9443c01a7336-2c41300f817mr36848625ad.29.1781275464660;
        Fri, 12 Jun 2026 07:44:24 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c432c8becesm23773525ad.56.2026.06.12.07.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 07:44:23 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Ackerley Tng <ackerleytng@google.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 RESEND 02/10] KVM: selftests: Add aligned guest physical page allocator
In-Reply-To: <air2QB-HUzxpCm_M@google.com>
Date: Fri, 12 Jun 2026 20:06:23 +0530
Message-ID: <h5n7esgo.ritesh.list@gmail.com>
References: <cover.1781093720.git.ritesh.list@gmail.com> <df86b5ccdbdafc3509d9538bd5e6796737bab2db.1781093720.git.ritesh.list@gmail.com> <aimOVomL2RzYt2J4@google.com> <ldcldopw.ritesh.list@gmail.com> <air2QB-HUzxpCm_M@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Sean Christopherson <seanjc@google.com> writes:

> On Thu, Jun 11, 2026, Ritesh Harjani wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>> 
>> > On Wed, Jun 10, 2026, Ritesh Harjani (IBM) wrote:
>> >> From: Nicholas Piggin <npiggin@gmail.com>
>> >> 
>> >> powerpc will require this to allocate MMU tables in guest memory that
>> >> are larger than guest base page size.
>> >> 
>> >> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> >> [Rebased to latest mainline tree]
>> >> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> >> ---
>> >>  .../testing/selftests/kvm/include/kvm_util.h  | 20 +++++++++--
>> >>  tools/testing/selftests/kvm/lib/kvm_util.c    | 33 +++++++++----------
>> >>  2 files changed, 33 insertions(+), 20 deletions(-)
>> >> 
>> >> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
>> >> index 3666a8530f31..c515c918c2c9 100644
>> >> --- a/tools/testing/selftests/kvm/include/kvm_util.h
>> >> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
>> >> @@ -991,8 +991,8 @@ void kvm_gsi_routing_write(struct kvm_vm *vm, struct kvm_irq_routing *routing);
>> >>  const char *exit_reason_str(unsigned int exit_reason);
>> >>  
>> >>  gpa_t vm_phy_page_alloc(struct kvm_vm *vm, gpa_t min_gpa, u32 memslot);
>> >> -gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num, gpa_t min_gpa,
>> >> -			   u32 memslot, bool protected);
>> >> +gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num, size_t align,
>> >> +			   gpa_t min_gpa, u32 memslot, bool protected);
>> >>  gpa_t vm_alloc_page_table(struct kvm_vm *vm);
>> >>  
>> >>  static inline gpa_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
>> >> @@ -1003,10 +1003,24 @@ static inline gpa_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
>> >>  	 * protected memory, as the majority of memory for such VMs is
>> >>  	 * protected, i.e. using shared memory is effectively opt-in.
>> >>  	 */
>> >> -	return __vm_phy_pages_alloc(vm, num, min_gpa, memslot,
>> >> +	return __vm_phy_pages_alloc(vm, num, 1, min_gpa, memslot,
>> >>  				    vm_arch_has_protected_memory(vm));
>> >>  }
>> >>  
>> >> +static inline gpa_t vm_phy_pages_alloc_align(struct kvm_vm *vm, size_t num,
>> >> +					     size_t align, gpa_t min_gpa,
>> >> +					     u32 memslot)
>> >
>> > Given that the PPC usage is all for naturally aligned allocations, I think it
>> > makes sense for that to be the API, i.e. have "bool naturally_aligned" instead
>> > of an arbitrary alignment.
>> >
>> 
>> I would still prefer passing an explicit align value to the allocator,
>> because IMHO that's a useful allocator interface to have.
>
> Why?  What are the use cases?  I can't think of anything that requires multi-page
> allocations to have specific alignment, all of the cases I can think of require
> natural alignment.
>

I agree, that's what I mentioned too, so far all cases we care about,
they require natual alignment. So it should be fine.

> For sub-page allocations, supporting semi-arbitrary alignments makes sense, but
> I'm not convinced we should try and support that for page-granularity allocations.
>
>> However, if we do want to go down this road than I don't have any strong
>> objection either, since as you mentioned powerpc mostly just needs
>> natual alignment for it's page table region. So alignment can be
>> extracted from the region type as you described below, so no need to
>> pass it all the time.
>
> ..
>
>> > The bonus is that @min_gpa goes away too.
>> 
>> powerpc needs min_gpa for it's exception handling pages. see.
>> 
>> 	excp_paddr = vm_phy_pages_alloc(vm, excp_pages, 0,
>> 					vm->memslots[MEM_REGION_DATA]);
>> 
>> 	TEST_ASSERT(excp_paddr == 0,
>> 		    "Interrupt vectors not allocated at gPA address 0: (0x%lx)",
>> 		    excp_paddr);
>> 
>> So, will arch still have an access to the API for passing min_gpa = 0
>> for cases like above?
>
> Yep, ____vm_phy_pages_alloc() will be globally visible, and I think is quite
> appropriate in this case since it's more than just specifying a minimum GPA,
> it's really specifying an _exact_ GPA for the allocation.
>
> gpa_t ____vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages, gpa_t min_gpa,
> 			     u32 memslot, bool protected, bool naturally_aligned)
>

Right, Thanks!

>> > It'll probably take me a few days/weeks, but I'll try get a series posted before
>> > the 7.2 merge window closes, so that you can build on top to get the PPC selftests
>> > support landed in 7.3.
>> >
>> 
>> Thanks Sean for your help! Yes, landing kvm selftests for powerpc will
>> be definitely helpful to verify against any kvm regressions.
>> 
>> BTW, I was thinking whether landing powerpc first will be easier for you
>> to consider all the API requirements from all users / usecases?  But
>> either way is fine please. I can work on top of your changes too and if
>> something is missing for powerpc, we can add / modify on top, once your
>> series is finished.
>
> One idea would be for me to include the PPC support in the series; it's "just"
> a patch or two on top, albeit one pretty big patch.
>


That should be ok Sean. I can rebase my changes on top of yours once
your series is ready then. I will be on travel next week (OSS Mumbai)
and I don't want to stop your patch series due to my late replies for
any of the powerpc part.

So once your series is ready - I can rebase this series on top of it and
it can go as we discussed it earlier - so that we can try and land these
for 7.3, if possible.

Thanks again for your help :)

>> >> @@ -2039,23 +2039,22 @@ gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
>> >>  	TEST_ASSERT(!protected || region->protected_phy_pages,
>> >>  		    "Region doesn't support protected memory");
>> >>  
>> >> -	base = pg = min_gpa >> vm->page_shift;
>> >> -	do {
>> >> -		for (; pg < base + num; ++pg) {
>> >> -			if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
>> >> -				base = pg = sparsebit_next_set(region->unused_phy_pages, pg);
>> >> -				break;
>> >> +	base = min_gpa >> vm->page_shift;
>> >> +again:
>> >> +	base = (base + align - 1) & ~(align - 1);
>> >> +	for (pg = base; pg < base + num; ++pg) {
>> >> +		if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
>> >> +			base = sparsebit_next_set(region->unused_phy_pages, pg);
>> >> +			if (!base) {
>> >> +				fprintf(stderr, "No guest physical page available, "
>> >> +					"min_gpa: 0x%lx page_size: 0x%x memslot: %u\n",
>> >> +					min_gpa, vm->page_size, memslot);
>> >> +				fputs("---- vm dump ----\n", stderr);
>> >> +				vm_dump(stderr, vm, 2);
>> >> +				abort();
>> >>  			}
>> >> +			goto again;
>> >>  		}
>> >> -	} while (pg && pg != base + num);
>> >> -
>> >> -	if (pg == 0) {
>> >> -		fprintf(stderr, "No guest physical page available, "
>> >> -			"min_gpa: 0x%lx page_size: 0x%x memslot: %u\n",
>> >> -			min_gpa, vm->page_size, memslot);
>> >> -		fputs("---- vm dump ----\n", stderr);
>> >> -		vm_dump(stderr, vm, 2);
>> >> -		abort();
>> >>  	}
>> >
>> > This is unnecessary churn.  I'm not saying the current code is pretty or anything,
>> > but unless I'm missing something, this can simply be:
>> 
>> Not really, we need the base to be aligned everytime, that's why the
>> goto again loop aligns the base in the new code.
>
> Ooh, right, pg needs to be advanced by the aligned number of pages.  Ugh, the
> whole do-while part is bizarre, and AFAICT only "works" by dumb luck. 
>
>> Plus I feel the above refactoring also simplifies the special handling of pg
>> == 0 case, which earlier was being handled separately after the loop ends.
>
> Yeah, I fiddled with a few other options, but I think I like your approach the
> most.

Sure then, Thanks!


-ritesh

