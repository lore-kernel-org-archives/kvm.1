Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AF7538D88
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 16:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789057459; cv=none; b=L+LWufD0d6Ck8QXNfIP2IniH2S+NJ1105R1rwImH7IK2U5QRII6zSVqzUMAs9Pte3vJjBwkH9hjbRGx95AGIZCInhE/qK2NG1jYXgs/Htl2WPQbxnX4FFKvpMaOYvpVI2rzf5b2dIBKdAy+erreZ2zsr0hAEnvG6RW5MPJsmyjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789057459; c=relaxed/simple;
	bh=oZlJXyr/vznH7W8+YLWx04wb1lKdYU17YCzYXBRfBHU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JjFoSK8eMA3bwDYJ1gHp9G06bxkK8MZZm8QdbxnzNoMG4JJN9ZUkixGjHs5wRnsdqcXlvhjtBcrIp9TMctp7QAqfeD5gaWcr0TLAV1drCl5Jgzs+p+Uiwf1KiC/ewNIQAETJ4TFV/XfYWgoFTyP0HonsF7Hb/MknkKI29n2aoYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EvuZ4NQE; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EvuZ4NQE"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38ecc48b3c2so11801043a91.1
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 09:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789057456; x=1789662256; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0rpxpcs9OXB4KnER7qZ3x6F/Alg7K5WCZ24dhH70660=;
        b=EvuZ4NQE78GhaIwmz2dLudIxdaKEwWcO5nX8Edvblh5oQ4EKtXUp6Fk8bcXwqvXVci
         weqq7LH7s5SEd5iFPb+ag1/PcIk6xIRStk1QFwci+D+Sp+0b4jzKXB2r3PVL+tGHXJ+C
         DCfKwUxZdc6UToT80ajy0+ettyuzjFIneHMvHSxahLOLF3K3FzdM2lji8U5EVtBPH2dC
         lbFIfClgwfQbhk1B4AYRvAdrC5jLSExJwg+2wgapPJN+Fcq9CgPlsbA9zy7yLCx1KRAK
         oK8duYrN4LmSikBWzkh0KxwaxwpBqgVnPITvOTaiMGzoBBN99SJU6f5+yFibevTp/C/7
         q/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789057456; x=1789662256;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0rpxpcs9OXB4KnER7qZ3x6F/Alg7K5WCZ24dhH70660=;
        b=tV1RtIDjY9GCQVRvX+m33gJpPjOMbDiOGgtFsLqi1x1GYo3/6yxkZP5yCSCF9VHo/9
         PFjQXK5G90G5utydmbPa/gIWh1YJrsIQru76eHd52T02jB4ptJ5s3pSl74I06pGfG3jM
         PcB/i5GybLnB152cx1IC96mHqpmxqXQXAer8upH3sYw6zVJCuWQRreQP23Xmtq9QOhBQ
         zL3Q48D4o8reSX+o+w5l+miqUv8IKkJDibB9P20a1sp4GkX/3E+hSdxd0xXUaPexsKDV
         kBm7UPYAmdNxH5hK2DScQp/MGXg9XkiNF98Hfv2b4PZSI1ILde0kAfCgPBMPoi/B6xev
         l9/A==
X-Forwarded-Encrypted: i=1; AKwUvBzX7JqsgqlIqMCVV6KGApeWzKgp4rGObPggsc44Lov8eJpqhNbNf5FHU+HQ5KZbwqz6wkE=@vger.kernel.org
X-Gm-Message-State: AFuF++ns9sGegOrfLd59u9eL2j/rGhbZ29oaxzyehtO5Zlc0JlC2yRyJ
	n1DNZJX6JZjvrhf+z6mBXtTwqBkesgU0/KwrJYf0tiFfOZG/E35iuQrOoAb4g1Y+J10GO030j9I
	SAqfS5g==
X-Received: from pjye16.prod.google.com ([2002:a17:90a:ee10:b0:39b:9a0e:78cd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d644:b0:398:9c00:29ec
 with SMTP id 98e67ed59e1d1-39b26245cfcmr66792937a91.20.1789057455320; Thu, 10
 Sep 2026 09:24:15 -0700 (PDT)
Date: Thu, 10 Sep 2026 09:24:14 -0700
In-Reply-To: <5x0d1hj1.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902164123.2546762-1-seanjc@google.com> <20260902164123.2546762-13-seanjc@google.com>
 <5x0d1hj1.ritesh.list@gmail.com>
Message-ID: <aqLZrk6m3NgugzBU@google.com>
Subject: Re: [PATCH v2 12/20] KVM: selftests: Add APIs to override memory
 region types with custom memslots
From: Sean Christopherson <seanjc@google.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Fuad Tabba <fuad.tabba@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>, 
	David Hildenbrand <david@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Itaru Kitayama <itaru.kitayama@fujitsu.com>, 
	Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 10, 2026, Ritesh Harjani wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > Add and use APIs to override memory region types instead of open coding the
> > logic in tests, partly to dedup test code, but mostly to add some amount of
> > protection against conflicting overrides.  This will allow converting more
> > tests to override memory regions without taking on too much risk of bugs in
> > the long term, e.g. due to silently overriding a region multiple times.
> >
> > Deliberately "unroll" the loops in __vm_create() and the CMMA test's
> > create_main_memslot() to avoid filling all memslots in anticipation of
> > adding an "extra" memslot that is for test use and *only* test use, i.e.
> > shouldn't be configured by core library code.
> >
> > Converting tests to overriding memory regions will allow taking the region
> > type instead of the raw memslot in the physical page allocator APIs.
> >
> 
> May I suggest few changes in the naming of these APIs:
> 
> static inline void vm_override_mem_region(struct kvm_vm *vm,
> 					      enum kvm_mem_region_type type,
> 					      u32 slot)
> {
> 	TEST_ASSERT(vm->memslots[type] == KVM_INVALID_MEMSLOT,
> 		    "Memory region type '%u' was already overridden with slot=%u",
> 		    type, vm->memslots[type]);
> 
> 	vm->memslots[type] = slot;
> }
> 
> static inline void vm_override_add_mem_region_flags(struct kvm_vm *vm,
> 					    enum kvm_mem_region_type type,
> 					    enum vm_mem_backing_src_type src_type,
> 					    gpa_t gpa, u32 slot, u64 npages,
> 					    u32 flags)
> {
> 	vm_override_mem_region(vm, type, slot);
> 	vm_userspace_mem_region_add(vm, src_type, gpa, slot, npages, flags);
> }
> 
> static inline void vm_override_add_mem_region(struct kvm_vm *vm,
> 					  enum kvm_mem_region_type type,
> 					  enum vm_mem_backing_src_type src_type,
> 					  gpa_t gpa, u32 slot, u64 npages)
> {
> 	vm_override_add_mem_region_flags(vm, type, src_type, gpa, slot, npages, 0);
> }
> 
> Those "_add_" and "_flags" in the function names easily gives away
> the difference in the APIs, rather than differentiating via "__".

I am strongly against postfixes like "_flags".  We do use postfixes for the VM
creation APIs, e.g. vm_create_barebones(), vm_create_with_vcpus(), etc., but only
because there are so many possible combinations that differentiating through
underscores is completely infeasible (unless we forced callers to regurgitate
huge amounts of boilerplace and/or had an absurd number of params), and because
the collection of APIs is tree-like, as opposed to a single linear chain of APIs.

For this, there is a much more finite set of possibilities, and the set of APIs
is a direct liner chain (no underscores => __ => ____).

I agree that not capturing that {,__}vm_override_mem_region() adds a userspace
memory region isn't ideal, but due to the term "memory region" already being
somewhat overloaded, I don't want to have "add" in the name as I think that will
make it harder to differentiate between the "enum kvm_mem_region_type" APIs and
the "userspace memory region" APIs.

And IMO it's totally fine for a function name to express what the API does at a
higher level, without capturing the exact operations in explicit detail.  E.g.
__vm_create() (and even ____vm_create()) obviously does a lot more than literally
KVM_VM_CREATE.
