Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777D34AC14D
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 16:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788367287; cv=none; b=gtPE78FuHJMJl965jbwDxx/M/ThEodlKamH7QDESwIhalvMIZAsByvjOXFo/5ch1Qp3+hny2jN+HvNipQryPUT4XxIMZTHK/imJ8I5OVcgvLB5WmMRv7oaRCPTLDSW6kZM/13s6YhZ34lw0n7zcdfsMsV4obrKMkEkUOwtfltD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788367287; c=relaxed/simple;
	bh=zsFbTSNS49K5fTTJHxNrCzc+5y/Ob23CZWVIBOZR8bM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=D45Mh10zFfBWSc0tJUxpNxOnzWZ77NrMXxw+Q8ARnU0i+OzaF1w4HMrKdbNxz92DiPW8s2hNKzr/pfUX7HG7dkdw1ipf5WQO2qxLWubRnBuQ/mwoQk4vYMMMtJ+8pCG7K1yGyDhOn7WjNflr+OG3oiYwPo0YLYw+Pt4ozIYTeEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ggzqIERf; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ggzqIERf"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38f5ac7416eso1801282a91.3
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 09:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788367285; x=1788972085; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=frOgBPC40pi3x0hlZEdVguNDXI4epigXANzoQJEvIq8=;
        b=ggzqIERfnYqfyjD2bm7L5TbCW6KCFqJus+e/puWiC5uApz1fMJ/I3KTADeAweOgaSd
         wpp6W2deaMzxC+aRKPvRMLA2kyP+KTkkMj9QSnM4+RT2Z6Ym51ZygLCife1CLkEi7DS7
         WmX7YFk6EV77Ko3NeATTpI9oaz19i+EzF7RZJeKg5Dp6yXG0XVRmcqSk7XWWkX26KLHo
         r4/Qce2NBjkjTIqw0BhE4yaIgKx2dFtyIn1cQxdiiP2UCs8YfTy0qk8kQ5WqdRrMFug1
         JKf9cpAtPYALd8/EdhipStUi2zgsP59QE0FUfA5WZNarUJF3GYBEi3ocAGEHd14NKRWR
         7dFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788367285; x=1788972085;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=frOgBPC40pi3x0hlZEdVguNDXI4epigXANzoQJEvIq8=;
        b=qEIlMVESRTztujFEnAgMQprNach4i9UVDQPP3UhV/AqpRN9NWATb3e4qP/Ww9HXMYc
         9nu+lUXAUWIAhWB4ry3+QA3PyuJRvmhApt2ftBPXYzQ7sVpHzAwCc/pUWNgspuS4Wuhe
         KQo48UOMvrgRZpQlTIsyxFoeoyrg0PWOLnpXq185nEQcb0S7+QY19BEJq2JyLy50NmBa
         1AswPJnTIzAjtpjfDG+hok1xv7F4B/VcSkD6O93pddRJBiRJ/rJBh02LXgjvRbKnCw4M
         MzkefrrcUXZd90MydBygpS/ssOFJw2bXv63mYkpS+1pZxl6f0hgcoKB2RTc4box3WE2i
         ycqg==
X-Forwarded-Encrypted: i=1; AKwUvBwHZoucrVzfJ9j/QV7TY8XkG3eByRP0s8VfeMTvsOChM6yMC2p8wINlBtLerWSgfE0c67o=@vger.kernel.org
X-Gm-Message-State: AFuF++n55bLYiuULfoZCG6PNl+g5ezy9N+ItVNzZ4qRxUEXPI8piaAOJ
	faAFbf5PwDMmcofnwRCSZIzYdn7FcNvIOeAUcjnFJKRrHeSDM0T3+ik1Nmwdaz8lrdKVNARGq4B
	06X3pvg==
X-Received: from pjbbh12.prod.google.com ([2002:a17:90b:48c:b0:381:171e:961c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d4f:b0:37f:e1b6:4c7d
 with SMTP id 98e67ed59e1d1-39aedf1aec2mr9689222a91.6.1788367284482; Wed, 02
 Sep 2026 09:41:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  2 Sep 2026 09:41:03 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260902164123.2546762-1-seanjc@google.com>
Subject: [PATCH v2 00/20] KVM: selftests: PPC pre-enabling
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Atish Patra <atish.patra@linux.dev>, 
	Alexandre Ghiti <alex@ghiti.fr>, David Hildenbrand <david@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Itaru Kitayama <itaru.kitayama@fujitsu.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Ritesh Harjani <ritesh.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"

This is a big pile of cleanups and refactoring to prepare for PPC support in
KVM selftests.  PPC has paging modes that require multi-page page tables, and
those page tables need to be naturally aligned.  The original proposal was to
plumb in an @align param to the page allocators[*], but I didn't love the idea
of adding another rarely used param to the allocators.

v2:
 - Collect tags. [Itaru, Bibo]
 - Use 0x180000 as the min GPA for page table pages on LoongArch, instead of
   changing every other arch to use 0x200000. [Sashiko, Bibo]
 - Opportunistically move the vGIC LPI stress test's global "gpa_base" variable
   into setup_memslot(). [Sashiko]

v1: https://lore.kernel.org/all/20260826230511.972824-1-seanjc@google.com

[*] https://lore.kernel.org/all/df86b5ccdbdafc3509d9538bd5e6796737bab2db.1781093720.git.ritesh.list@gmail.com

Nicholas Piggin (1):
  KVM: selftests: Use goto instead of do-while to retry finding unused
    physical pages

Sean Christopherson (19):
  KVM: selftests: Use MEM_REGION_PT memslot instead of '0' for s390
    regions/segments
  KVM: selftests: Use the common minimum GPA for page tables on
    LoongArch
  KVM: selftests: Use vm_alloc_page_table() to allocate LoongArch page
    tables
  KVM: selftests: Rename "num" param to "nr_pages" for physical page
    allocators
  KVM: selftests: Extend page allocator to support naturally aligned
    allocations
  KVM: selftests: Make the single-page allocator APIs static inline
  KVM: selftests: Use the innermost page allocator API in the memslot
    perf test
  KVM: selftests: Use the innermost page allocator API in s390's IRQ
    routing test
  KVM: selftests: Add a wrapper API to allocate multiple page table
    pages
  KVM: selftests: Initialize vm->memslots[] with invalid memslots during
    creation
  KVM: selftests: Add APIs to override memory region types with custom
    memslots
  KVM: selftests: Add TEST_EXTRA memory region type for "special"
    memslots
  KVM: selftests: Use TEST_EXTRA region in arm64's vGIC LPI stress test
  KVM: selftests: Use TEST_EXTRA region in x86's smaller MAXPHYADDR test
  KVM: selftests: Use TEST_EXTRA region in set memory region test
  KVM: selftests: Take the memory region type, not memslot, in page
    allocators
  KVM: selftests: Use TEST_ASSERT(), not assert(), in
    vm_get_mem_region()
  KVM: selftests: Automatically pick min_gpa for allocations based on
    region type
  KVM: selftests: Add arch hook to force page tables to be naturally
    aligned

 .../selftests/kvm/arm64/page_fault_test.c     |  18 ++-
 .../selftests/kvm/arm64/vgic_lpi_stress.c     |  21 ++-
 .../testing/selftests/kvm/include/kvm_util.h  | 106 +++++++++++++--
 tools/testing/selftests/kvm/include/x86/smm.h |   2 +-
 .../selftests/kvm/lib/arm64/processor.c       |   4 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    | 127 +++++++++++-------
 .../selftests/kvm/lib/loongarch/processor.c   |   5 +-
 .../selftests/kvm/lib/riscv/processor.c       |   4 +-
 .../selftests/kvm/lib/s390/processor.c        |   7 +-
 .../testing/selftests/kvm/lib/x86/processor.c |  15 ++-
 .../testing/selftests/kvm/memslot_perf_test.c |   3 +-
 tools/testing/selftests/kvm/s390/cmma_test.c  |  19 +--
 .../testing/selftests/kvm/s390/irq_routing.c  |   2 +-
 .../selftests/kvm/set_memory_region_test.c    |   8 +-
 .../x86/smaller_maxphyaddr_emulation_test.c   |   9 +-
 15 files changed, 221 insertions(+), 129 deletions(-)


base-commit: 76671054f9a1ff6abb976583cd8da37650acdc97
-- 
2.55.0.966.g6673acef38-goog

