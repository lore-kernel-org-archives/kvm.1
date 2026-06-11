Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A926546AF37
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 17:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200451; cv=none; b=n1n/nMhIM0HUhPd5DTG4MZFtzVLDvVsE/WsChhxLiuMlFZmYx/irMHmIW1lnfTNdUjOjLzc8C0QbtzOjNTQcWW1ObNSmAHrZkrZidX8KUOQMtTyxUZJ2v3731cnIM3w2wLmm+oRbn/46V5/8p650J6Fc6JPA4iNN4Mgwj2Qs4Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200451; c=relaxed/simple;
	bh=4I3RlfeP6L08CW0cOUJGg7KvetkeymNc2m1lGzuq7hU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JyLX5tXAcNUFyl7ToghQSL95kzgM1fWxU6nSDGucI9mfBhaFfaOkSr6Pz45cfJvSitY0itwHvM/257ZnTLkYLpotNjkR1sQuuFWhoFSSGhQXdaHIBG64k8h7IqWfuNr7430+dV0IjjGH8FZ8PqLg6BkwiR7EaRCiqhz66bIv2qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wmwuJN6k; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wmwuJN6k"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c2b64850easo1940985ad.1
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 10:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781200449; x=1781805249; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IOJyOW3TzN5ixErWyO0JSYunyAbYlgebTlL8SlVIneA=;
        b=wmwuJN6kJlOHik63TApJCwQqUDqP2yZ6HzWoZqLrfdJZt4lTCF/8nNogh7Kzf7C+Dd
         R7BQKgtbjq2qXTQeDygIbeBCj1XKNOj982otxPO0u0P4U3lZBYifePTJT/1mBLpUFTOk
         DEBzPBkntGd0UcbjO/J5fgvLZcZXJL5FYXm83B/VjY4ZlRaCpRBWzqm2iKN3SkJ5vulk
         sBHw/XvITpXV2WwtHztPngMpiz+4MC7E6Hcyv3IDP8Ld/nJDLn8ngnn8gOAobkDAqDwn
         ZdbWcbThsq/nHAfxCR/gANPneFl90kQKy5Al6ghbbYw0j8jkhWQGmpXLTLO3Fu4+KUjq
         JMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781200449; x=1781805249;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IOJyOW3TzN5ixErWyO0JSYunyAbYlgebTlL8SlVIneA=;
        b=Qxia3cZrqGWQTi6JcuyMeyQ/ZsnbguY6nKmoMJmCYKzxGO2M2zLbijBSEL7V/gGRd9
         yAbT3/SYC4pCeCoGbw7HGoIf26P2ssNsBiblddWvLMrwEevIdVIt5xOHdHZspj1lYqDl
         xkJ2oYGz+OSOmkk1CcRDe715w0KPCkgQFhN++6Lh2jZOpZI/n5f5SeqXWxdvmTBcOSfk
         6aG1fhUbRzitfOELeKHKu+2Q2j50/8FH2Mjz13XGgBAdj2/QM/A6qtV2JNmwko3rymgH
         52AJFrvV20di7TZ1OGqnDaRIGwmqDQ9u45bwQsK7VuHnNw+bIjU0T/72rwGPTyvz/v4o
         EsJg==
X-Gm-Message-State: AOJu0YyBNZ2F1YPrteFU8F2/MqdOaEmiZMyiglRKvvPSA0ejQo5GYuYQ
	k5GRmbg3CHy/amikIxlrbyobkSooEu63yBxyL+hPhW2WZGVCO301tfZeJ2wn3XJTbQ4am9dNZmR
	c7yI9ZA==
X-Received: from plog3.prod.google.com ([2002:a17:902:8683:b0:2bc:ae34:223a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a88:b0:2bf:21e6:baee
 with SMTP id d9443c01a7336-2c2f470dc43mr48152335ad.28.1781200448836; Thu, 11
 Jun 2026 10:54:08 -0700 (PDT)
Date: Thu, 11 Jun 2026 10:54:08 -0700
In-Reply-To: <ldcldopw.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1781093720.git.ritesh.list@gmail.com> <df86b5ccdbdafc3509d9538bd5e6796737bab2db.1781093720.git.ritesh.list@gmail.com>
 <aimOVomL2RzYt2J4@google.com> <ldcldopw.ritesh.list@gmail.com>
Message-ID: <air2QB-HUzxpCm_M@google.com>
Subject: Re: [PATCH v3 RESEND 02/10] KVM: selftests: Add aligned guest
 physical page allocator
From: Sean Christopherson <seanjc@google.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Christophe Leroy <chleroy@kernel.org>, Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	Ackerley Tng <ackerleytng@google.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 11, 2026, Ritesh Harjani wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > On Wed, Jun 10, 2026, Ritesh Harjani (IBM) wrote:
> >> From: Nicholas Piggin <npiggin@gmail.com>
> >> 
> >> powerpc will require this to allocate MMU tables in guest memory that
> >> are larger than guest base page size.
> >> 
> >> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >> [Rebased to latest mainline tree]
> >> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> >> ---
> >>  .../testing/selftests/kvm/include/kvm_util.h  | 20 +++++++++--
> >>  tools/testing/selftests/kvm/lib/kvm_util.c    | 33 +++++++++----------
> >>  2 files changed, 33 insertions(+), 20 deletions(-)
> >> 
> >> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> >> index 3666a8530f31..c515c918c2c9 100644
> >> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> >> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> >> @@ -991,8 +991,8 @@ void kvm_gsi_routing_write(struct kvm_vm *vm, struct kvm_irq_routing *routing);
> >>  const char *exit_reason_str(unsigned int exit_reason);
> >>  
> >>  gpa_t vm_phy_page_alloc(struct kvm_vm *vm, gpa_t min_gpa, u32 memslot);
> >> -gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num, gpa_t min_gpa,
> >> -			   u32 memslot, bool protected);
> >> +gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num, size_t align,
> >> +			   gpa_t min_gpa, u32 memslot, bool protected);
> >>  gpa_t vm_alloc_page_table(struct kvm_vm *vm);
> >>  
> >>  static inline gpa_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
> >> @@ -1003,10 +1003,24 @@ static inline gpa_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
> >>  	 * protected memory, as the majority of memory for such VMs is
> >>  	 * protected, i.e. using shared memory is effectively opt-in.
> >>  	 */
> >> -	return __vm_phy_pages_alloc(vm, num, min_gpa, memslot,
> >> +	return __vm_phy_pages_alloc(vm, num, 1, min_gpa, memslot,
> >>  				    vm_arch_has_protected_memory(vm));
> >>  }
> >>  
> >> +static inline gpa_t vm_phy_pages_alloc_align(struct kvm_vm *vm, size_t num,
> >> +					     size_t align, gpa_t min_gpa,
> >> +					     u32 memslot)
> >
> > Given that the PPC usage is all for naturally aligned allocations, I think it
> > makes sense for that to be the API, i.e. have "bool naturally_aligned" instead
> > of an arbitrary alignment.
> >
> 
> I would still prefer passing an explicit align value to the allocator,
> because IMHO that's a useful allocator interface to have.

Why?  What are the use cases?  I can't think of anything that requires multi-page
allocations to have specific alignment, all of the cases I can think of require
natural alignment.

For sub-page allocations, supporting semi-arbitrary alignments makes sense, but
I'm not convinced we should try and support that for page-granularity allocations.

> However, if we do want to go down this road than I don't have any strong
> objection either, since as you mentioned powerpc mostly just needs
> natual alignment for it's page table region. So alignment can be
> extracted from the region type as you described below, so no need to
> pass it all the time.

..

> > The bonus is that @min_gpa goes away too.
> 
> powerpc needs min_gpa for it's exception handling pages. see.
> 
> 	excp_paddr = vm_phy_pages_alloc(vm, excp_pages, 0,
> 					vm->memslots[MEM_REGION_DATA]);
> 
> 	TEST_ASSERT(excp_paddr == 0,
> 		    "Interrupt vectors not allocated at gPA address 0: (0x%lx)",
> 		    excp_paddr);
> 
> So, will arch still have an access to the API for passing min_gpa = 0
> for cases like above?

Yep, ____vm_phy_pages_alloc() will be globally visible, and I think is quite
appropriate in this case since it's more than just specifying a minimum GPA,
it's really specifying an _exact_ GPA for the allocation.

gpa_t ____vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages, gpa_t min_gpa,
			     u32 memslot, bool protected, bool naturally_aligned)

> > It'll probably take me a few days/weeks, but I'll try get a series posted before
> > the 7.2 merge window closes, so that you can build on top to get the PPC selftests
> > support landed in 7.3.
> >
> 
> Thanks Sean for your help! Yes, landing kvm selftests for powerpc will
> be definitely helpful to verify against any kvm regressions.
> 
> BTW, I was thinking whether landing powerpc first will be easier for you
> to consider all the API requirements from all users / usecases?  But
> either way is fine please. I can work on top of your changes too and if
> something is missing for powerpc, we can add / modify on top, once your
> series is finished.

One idea would be for me to include the PPC support in the series; it's "just"
a patch or two on top, albeit one pretty big patch.

> >> @@ -2039,23 +2039,22 @@ gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
> >>  	TEST_ASSERT(!protected || region->protected_phy_pages,
> >>  		    "Region doesn't support protected memory");
> >>  
> >> -	base = pg = min_gpa >> vm->page_shift;
> >> -	do {
> >> -		for (; pg < base + num; ++pg) {
> >> -			if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
> >> -				base = pg = sparsebit_next_set(region->unused_phy_pages, pg);
> >> -				break;
> >> +	base = min_gpa >> vm->page_shift;
> >> +again:
> >> +	base = (base + align - 1) & ~(align - 1);
> >> +	for (pg = base; pg < base + num; ++pg) {
> >> +		if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
> >> +			base = sparsebit_next_set(region->unused_phy_pages, pg);
> >> +			if (!base) {
> >> +				fprintf(stderr, "No guest physical page available, "
> >> +					"min_gpa: 0x%lx page_size: 0x%x memslot: %u\n",
> >> +					min_gpa, vm->page_size, memslot);
> >> +				fputs("---- vm dump ----\n", stderr);
> >> +				vm_dump(stderr, vm, 2);
> >> +				abort();
> >>  			}
> >> +			goto again;
> >>  		}
> >> -	} while (pg && pg != base + num);
> >> -
> >> -	if (pg == 0) {
> >> -		fprintf(stderr, "No guest physical page available, "
> >> -			"min_gpa: 0x%lx page_size: 0x%x memslot: %u\n",
> >> -			min_gpa, vm->page_size, memslot);
> >> -		fputs("---- vm dump ----\n", stderr);
> >> -		vm_dump(stderr, vm, 2);
> >> -		abort();
> >>  	}
> >
> > This is unnecessary churn.  I'm not saying the current code is pretty or anything,
> > but unless I'm missing something, this can simply be:
> 
> Not really, we need the base to be aligned everytime, that's why the
> goto again loop aligns the base in the new code.

Ooh, right, pg needs to be advanced by the aligned number of pages.  Ugh, the
whole do-while part is bizarre, and AFAICT only "works" by dumb luck. 

> Plus I feel the above refactoring also simplifies the special handling of pg
> == 0 case, which earlier was being handled separately after the loop ends.

Yeah, I fiddled with a few other options, but I think I like your approach the
most.
