Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4699736F915;
	Thu, 27 Aug 2026 04:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787805469; cv=none; b=h2egRBL2TraUok6ov4Gja1bl8ai6OBfF6rb1pBb3MzwUtdbF47Lflmu1QyZGTrMggTQl63wB7VFI7z5Lkp8AVMuYlVtaYTlrIvwYr8VNROoO9WqhEnBbqYJyeiR5/a3Y44mxID/OQg0wMIo+PMH2ZT4N0YaK+O6X577nLWbzGTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787805469; c=relaxed/simple;
	bh=NjWJ6dMRbw0kkXr/0njtHxbP59W1uKKAQPA07UgnXFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apMQ4yDCX6hlF67Tl+RCPrrl5B3r/DweXyrDManCnbWWkomS81FxB93LrnZJduWf5RzwY8U2RIX0c9xWDmDLtUoWAGVRmFheSq1op09cDLUJDbx9yut8SsXDOu6i+lTXhEvm/l/JDmPNtOTCvhbLinWxMqYHYS9rTfiHaXs3Kdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=hVl26mh0; arc=none smtp.client-ip=68.232.139.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="hVl26mh0"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1787805471; x=1819341471;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NjWJ6dMRbw0kkXr/0njtHxbP59W1uKKAQPA07UgnXFc=;
  b=hVl26mh0JI2tiYYbO6CBtgFQxui0sRV2DDEdlS9tr/+wGwbdc91yhDeT
   VlcbCI26jHnRluU7nGKVmiQtVlHzytTkg/BeOVYYkngNB8Dwxk5AI3bhT
   rB6iAjJPzBg40Zam1k3UhDEy+aNwdtcbG3nTHXwMCWzdTqHxNJwTXx+3b
   Q6EFX02SniopoANyI2M4cftO8m+PdgoQFvyW6huFSXwVR34LY2hk8RpRS
   h0bm3HaaFkEx9VDv7xM9gBj7bauDvHrWIEyZaubzrv20boRxfxVfm8wjH
   0Ha+QDtfiTchzaRPdVU91bwo6TcbekV/pdJCNlsiz1cC2FiwFLw94e0If
   g==;
X-CSE-ConnectionGUID: tFffSnMsQB20A7sM0J6Yfw==
X-CSE-MsgGUID: vUlnY/14Q+qeblTrSoOwpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="251007843"
X-IronPort-AV: E=Sophos;i="6.25,246,1779116400"; 
   d="scan'208";a="251007843"
Received: from gmgwnl01.global.fujitsu.com ([52.143.17.124])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 13:37:44 +0900
Received: from az2nlsmgm4.fujitsu.com (unknown [10.150.26.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id 466EF10000E2;
	Thu, 27 Aug 2026 04:37:40 +0000 (UTC)
Received: from az2uksmom4.o.css.fujitsu.com (unknown [10.151.22.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm4.fujitsu.com (Postfix) with ESMTPS id DD374103C33A;
	Thu, 27 Aug 2026 04:37:39 +0000 (UTC)
Received: from sm-arm-grace07 (unknown [10.124.178.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmom4.o.css.fujitsu.com (Postfix) with ESMTPS id 17B3F405EDE;
	Thu, 27 Aug 2026 04:37:20 +0000 (UTC)
Date: Thu, 27 Aug 2026 13:37:18 +0900
From: Itaru Kitayama <itaru.kitayama@fujitsu.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Tianrui Zhao <zhaotianrui@loongson.cn>,
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Atish Patra <atish.patra@linux.dev>,
	Alexandre Ghiti <alex@ghiti.fr>,
	David Hildenbrand <david@kernel.org>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	kvm@vger.kernel.org, loongarch@lists.linux.dev,
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
	Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH 13/20] KVM: selftests: Add TEST_EXTRA memory region type
 for "special" memslots
Message-ID: <ao--_gaqpfWir9v4@sm-arm-grace07>
References: <20260826230511.972824-1-seanjc@google.com>
 <20260826230511.972824-14-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826230511.972824-14-seanjc@google.com>

On Wed, Aug 26, 2026 at 04:05:04PM -0700, Sean Christopherson wrote:
> And another memory region type to deal with extra, one-off memory regions,
> and use the new type to manage x86's SMRAM memslot, as another step towards
> taking the region type instead of the raw memslot in the physical page
> allocator APIs.
> 
> Alternatively, SMRAM setup could simply use the quad-underscore API to
> continue passing in the memslot, but a surprising number of tests use an
> "extra" memslot for a variety of reasons.  I.e. allocating memory from one
> (and exactly one) extra memslot isn't all that rare, and so should be
> treated as normal behavior, not as something extraordinary, as
> quad-underscore functions typically suggest.
> 
> Opportunistically add comments to document the intended usage of the types,
> as the difference between DATA, TEST_DATA, and TEST_EXTRA in particular
> isn't exactly obvious.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  .../testing/selftests/kvm/include/kvm_util.h  | 37 ++++++++++++++++---
>  tools/testing/selftests/kvm/include/x86/smm.h |  2 +-
>  .../testing/selftests/kvm/lib/x86/processor.c |  7 ++--
>  3 files changed, 37 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index 14f87c8a00ec..f4f4f360a10b 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -82,11 +82,43 @@ struct userspace_mem_regions {
>  	DECLARE_HASHTABLE(slot_hash, 9);
>  };
>  
> +/*
> + * Memory region types are passed to various page allocators to communicate
> + * various properties and metadata related to the allocation.  Note, the
> + * descriptions below described the primary usage of each type.  Individual
> + * tests may allocate memory for other purposes.
> + *
> + * By default, all regions are mapped to memslot '0'.  Tests can override the
> + * memslot for any or all types, e.g. so that all test data is allocated from a
> + * curated memslot.
> + */

This is helpful as it wasn't so obvious to me. Thanks for adding the comments 
on the default behaviour.

Thanks,
Itaru.

>  enum kvm_mem_region_type {
> +	/*
> +	 * The CODE region is used by lib/elf when loading the test's code into
> +	 * guest memory.
> +	 */
>  	MEM_REGION_CODE,
> +	/*
> +	 * The DATA region is used to allocate core data structures, e.g. vCPU
> +	 * stacks, VM exception tables, x86's TSS, etc.
> +	 */
>  	MEM_REGION_DATA,
> +	/*
> +	 * The PT region, a.k.a. Page Table region, is used to allocate page
> +	 * table pages.
> +	 */
>  	MEM_REGION_PT,
> +	/*
> +	 * The TEST_DATA region is used for allocating test data that is either
> +	 * test specific, and/or isn't considered a "core" data structure.
> +	 */
>  	MEM_REGION_TEST_DATA,
> +	/*
> +	 * The TEST_EXTRA region is for special snowflakes, where a test wants
> +	 * to create and use a one-off memslot, without impacting "normal" test
> +	 * data allocations.
> +	 */
> +	MEM_REGION_TEST_EXTRA,
>  	NR_MEM_REGIONS,
>  };
>  
> @@ -129,11 +161,6 @@ struct kvm_vm {
>  
>  	struct kvm_binary_stats stats;
>  
> -	/*
> -	 * KVM region slots. These are the default memslots used by page
> -	 * allocators, e.g., lib/elf uses the memslots[MEM_REGION_CODE]
> -	 * memslot.
> -	 */
>  	u32 memslots[NR_MEM_REGIONS];
>  };
>  
> diff --git a/tools/testing/selftests/kvm/include/x86/smm.h b/tools/testing/selftests/kvm/include/x86/smm.h
> index 2d1afa09819b..15faaa060126 100644
> --- a/tools/testing/selftests/kvm/include/x86/smm.h
> +++ b/tools/testing/selftests/kvm/include/x86/smm.h
> @@ -8,7 +8,7 @@
>  #define SMRAM_MEMSLOT	((1 << 16) | 1)
>  #define SMRAM_PAGES	(SMRAM_SIZE / PAGE_SIZE)
>  
> -void setup_smram(struct kvm_vm *vm, struct kvm_vcpu *vcpu, u64 smram_gpa,
> +void setup_smram(struct kvm_vm *vm, struct kvm_vcpu *vcpu, gpa_t smram_gpa,
>  		 const void *smi_handler, size_t handler_size);
>  
>  void inject_smi(struct kvm_vcpu *vcpu);
> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
> index ea5fa59888af..b988eea373ad 100644
> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> @@ -1468,11 +1468,12 @@ bool kvm_arch_has_default_irqchip(void)
>  	return true;
>  }
>  
> -void setup_smram(struct kvm_vm *vm, struct kvm_vcpu *vcpu, u64 smram_gpa,
> +void setup_smram(struct kvm_vm *vm, struct kvm_vcpu *vcpu, gpa_t smram_gpa,
>  		 const void *smi_handler, size_t handler_size)
>  {
> -	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, smram_gpa,
> -				    SMRAM_MEMSLOT, SMRAM_PAGES, 0);
> +	vm_override_mem_region(vm, MEM_REGION_TEST_EXTRA, VM_MEM_SRC_ANONYMOUS,
> +			       smram_gpa, SMRAM_MEMSLOT, SMRAM_PAGES);
> +
>  	TEST_ASSERT(vm_phy_pages_alloc(vm, SMRAM_PAGES, smram_gpa,
>  				       SMRAM_MEMSLOT) == smram_gpa,
>  		    "Could not allocate guest physical addresses for SMRAM");
> -- 
> 2.55.0.887.g758fc8c411-goog
> 
