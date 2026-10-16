Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE07138C2A7
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 04:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792125868; cv=none; b=RW1f0dKIjd/nJH12Tb910qL9zLzeloIUIkTHynFW8nxQZ4GQGtiA+Jix2/JizuEOXiKGDD8XB6JJ6rGoip+2Dcvg5QKSwtgmMIlcl91YeII0Ol11gkyFeKF920Z4fgT1XGm0iQZE3znfqJHgBEcs62J6MuDMXytZPw9c/nhKhqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792125868; c=relaxed/simple;
	bh=AYl29IyzDFGsW4Te6bGo3a4kTSV9f6xaOb4sFf2k6bU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DYsjY34dzE3jbvqZulqLNQi7D70dE+O8QPF7BtJzztntCQIxr1rPq3WiD4IZ97fwMGt0hkj425SK+E252+NYYbz/JvLo1jO+tn1F0Gkw7Nj7pdb2oJaBamHwwVvtHrPuRAb7xIpBAPLM//f1VLmaH7tblKygBTnvN1R931mmlxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZoSTpg/7; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZoSTpg/7"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e93e2f72bfso38135035ad.3
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 21:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792125864; x=1792730664; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=56vaPXdds2F34Emh82hQX7OE/j80SqxhIBSL1vxCjk4=;
        b=ZoSTpg/7DCDeSvoObPMCSwu9u/+G4VXLcTDbmfYiZI8WYbCS6vMO4aSUPWBrRRv5wV
         djedtxW2mJIPIYMYyz2U4RsA1z4tZjHIc2yd1jAR/5KIBjp0Qsg3Q0m6fgieAx1vg5IB
         ctr6izBW71tz3jDfnHCAqkGYkFXDr5/oOPibrRR3NW5QLvsli6CJ6R71CpNtzBpvA36e
         Vd7GzO5GWx1KESsopEwcSNtR4DRHi5LTBZ0s5jxS/K7cMYpQa6lBQFxYutrCdj/bnQaN
         9KpD/6Jvz9uO+QsWn7RMkqXNYdmRS5wHCfb1n94C+1RZborUDKv8HaMWJ1YhIkrHR4W+
         6QOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792125864; x=1792730664;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=56vaPXdds2F34Emh82hQX7OE/j80SqxhIBSL1vxCjk4=;
        b=R9qlvYABSsklT5kByjQ988yYf/uNIqcY0VxL7ghmmUgw1htdipq/XWiX9gnZ77rxkn
         rw/4hInkJ3zLiBbDdFZWha8Pvdps8DBSZMdOv0AMGruPIDcwNkQMu0fjg51qR2xNz/Ak
         mfMPxAHl8Bsl3g1atrMqXj1LxfYkuYzCcmITbjsEkelaIvUGCmTeGZ8UdVBdpp3pJNLx
         4Mz7evT2vYRDa566efH/UyONyfm+3vqpDyJjN1r2otyMODR5hH/HF8iBOcYl/Al9aPmQ
         A3Zwh/WImEyY365ekcB7laWLKbM29AQ9+r6a4hLiLBOOyaYxW7oQATwWU/wMeZ2SOawn
         Yz4A==
X-Gm-Message-State: AFq9FYLz5O2+2WpnZ0kRp0Dkac4uWrUoumB1+6ec8I01LPA0Z6HgGAhd
	YMvBkwZyi9iISBYSsp3Cq5/mefZEWfroNuzjiLmCcwskgDW/KCmzsHDi/Sn+OONa3cxkJ8oKxNM
	P3JXe0w==
X-Received: from pjbcz4.prod.google.com ([2002:a17:90a:d444:b0:3ac:989f:b65f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:388d:b0:3ac:9669:846d
 with SMTP id 98e67ed59e1d1-3ac96698778mr4977624a91.51.1792125862892; Thu, 15
 Oct 2026 21:44:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 15 Oct 2026 21:44:10 -0700
In-Reply-To: <20261016044415.958618-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261016044415.958618-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <20261016044415.958618-6-seanjc@google.com>
Subject: [GIT PULL] KVM: selftests: Add PPC support
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Add PPC selftests support.  I grabbed the patches because it seemed easier
overall than coordinating a stable tag with maintainers that don't usually
send you pull requests.  The expectation going forward is that PPC selftests
changes will be routed through the KVM tree[1], since KVM selftests tend to
have a lot more cross-arch interactions/collisions than KVM proper

The memory regions rework will also show up in the "selftests" pull request
(I don't know why I didn't throw those changes in a dedicated branch), and
they have a silent conflict with kvm/master[2] due to the new vgic_its_save
arm64 test that came in through a 7.3 fixes pull request.  This is roughly
the resolution we've been using in next.

 +static void setup_memslot(size_t sz)
 +{
 +      size_t pages = sz / vm->page_size;
 +
 +      gpa_base = ((vm_compute_max_gfn(vm) + 1) * vm->page_size) - sz;
-       vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, gpa_base,
-                                   TEST_MEMSLOT_INDEX, pages, 0);
++      vm_override_mem_region(vm, MEM_REGION_TEST_EXTRA, VM_MEM_SRC_ANONYMOUS,
++                             gpa_base, TEST_MEMSLOT_INDEX, pages);
 +}
 +
 +static gpa_t alloc_64k(size_t nr)
 +{
 +      size_t pages_per_64k = vm_calc_num_guest_pages(vm->mode, SZ_64K);
-       gpa_t gpa = vm_phy_pages_alloc(vm, nr * pages_per_64k, gpa_base,
-                                      TEST_MEMSLOT_INDEX);
++      gpa_t gpa = vm_phy_pages_alloc(vm, nr * pages_per_64k,
++                                     MEM_REGION_TEST_EXTRA);
 +
 +      TEST_ASSERT(IS_ALIGNED(gpa, SZ_64K),
 +                  "Allocation at 0x%lx is not 64K aligned, GITS_BASER cannot address it",
 +                  gpa);
 +      return gpa;
 +}

[1] https://lore.kernel.org/all/ld8fjt6w.ritesh.list@gmail.com
[2] https://lore.kernel.org/all/aqqap3DngKznNrSA@sirena.org.uk

The following changes since commit d4b7fb647204f0c81dfeae2d1a708e4d858e0c94:

  Merge branch 'kvm-xen-longmode' into HEAD (2026-09-04 17:35:03 +0200)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-ppc_selftests-7.4

for you to fetch changes up to 23140d6e54ac31e2f4ef3bcd7fb586a14360be34:

  KVM: selftests: Enable hardware disable test PPC (without pSeries LPAR) (2026-10-13 12:07:29 -0700)

----------------------------------------------------------------
KVM PPC selftests support for 7.4

Rework KVM selftest's handling of memory regions all so that PPC can force its
page table allocations to be naturally aligned, and then add initial selftests
support for PPC.

----------------------------------------------------------------
Hisam Mehboob (1):
      KVM: selftests: Replace ulong with unsigned long

Nicholas Piggin (2):
      KVM: selftests: Use goto instead of do-while to retry finding unused physical pages
      KVM: PPC: selftests: add support for powerpc

Ritesh Harjani (IBM) (7):
      KVM: selftests: Don't limit LE dirty-bitmap bitops to s390x
      KVM: selftests: Move memslot_perf_test off the 256M ELF load address
      KVM: selftests: Skip the max vCPU ID test when KVM_CAP_PPC_SMT is set
      KVM: selftests: Add helper for checking if running on powerpc pseries LPAR
      KVM: selftests: Skip kvm_create_max_vcpus on powerpc pseries LPAR
      KVM: selftests: Enable access tracking perf test for PPC (with LPAR clause)
      KVM: selftests: Enable hardware disable test PPC (without pSeries LPAR)

Sean Christopherson (19):
      KVM: selftests: Use MEM_REGION_PT memslot instead of '0' for s390 regions/segments
      KVM: selftests: Use the common minimum GPA for page tables on LoongArch
      KVM: selftests: Use vm_alloc_page_table() to allocate LoongArch page tables
      KVM: selftests: Rename "num" param to "nr_pages" for physical page allocators
      KVM: selftests: Extend page allocator to support naturally aligned allocations
      KVM: selftests: Make the single-page allocator APIs static inline
      KVM: selftests: Use the innermost page allocator API in the memslot perf test
      KVM: selftests: Use the innermost page allocator API in s390's IRQ routing test
      KVM: selftests: Add a wrapper API to allocate multiple page table pages
      KVM: selftests: Initialize vm->memslots[] with invalid memslots during creation
      KVM: selftests: Add APIs to override memory region types with custom memslots
      KVM: selftests: Add TEST_EXTRA memory region type for "special" memslots
      KVM: selftests: Use TEST_EXTRA region in arm64's vGIC LPI stress test
      KVM: selftests: Use TEST_EXTRA region in x86's smaller MAXPHYADDR test
      KVM: selftests: Use TEST_EXTRA region in set memory region test
      KVM: selftests: Take the memory region type, not memslot, in page allocators
      KVM: selftests: Use TEST_ASSERT(), not assert(), in vm_get_mem_region()
      KVM: selftests: Automatically pick min_gpa for allocations based on region type
      KVM: selftests: Add arch hook to force page tables to be naturally aligned

 MAINTAINERS                                        |   2 +
 tools/testing/selftests/kvm/Makefile               |   2 +-
 tools/testing/selftests/kvm/Makefile.kvm           |   9 +
 .../selftests/kvm/access_tracking_perf_test.c      |  10 +
 tools/testing/selftests/kvm/arm64/hypercalls.c     |   2 +-
 .../testing/selftests/kvm/arm64/page_fault_test.c  |  18 +-
 .../testing/selftests/kvm/arm64/vgic_lpi_stress.c  |  21 +-
 tools/testing/selftests/kvm/dirty_log_test.c       |  12 +-
 .../testing/selftests/kvm/hardware_disable_test.c  |   3 +
 tools/testing/selftests/kvm/include/kvm_util.h     | 132 +++++-
 .../testing/selftests/kvm/include/powerpc/hcall.h  |  17 +
 .../selftests/kvm/include/powerpc/kvm_util_arch.h  |  22 +
 .../selftests/kvm/include/powerpc/ppc_asm.h        |  32 ++
 .../selftests/kvm/include/powerpc/processor.h      |  39 ++
 .../testing/selftests/kvm/include/powerpc/ucall.h  |  21 +
 tools/testing/selftests/kvm/include/x86/smm.h      |   2 +-
 tools/testing/selftests/kvm/kvm_create_max_vcpus.c |  14 +-
 tools/testing/selftests/kvm/lib/arm64/processor.c  |   4 +-
 tools/testing/selftests/kvm/lib/guest_modes.c      |  20 +-
 tools/testing/selftests/kvm/lib/kvm_util.c         | 135 ++++--
 .../selftests/kvm/lib/loongarch/processor.c        |   5 +-
 tools/testing/selftests/kvm/lib/powerpc/handlers.S |  93 ++++
 tools/testing/selftests/kvm/lib/powerpc/hcall.c    |  45 ++
 .../testing/selftests/kvm/lib/powerpc/processor.c  | 512 +++++++++++++++++++++
 tools/testing/selftests/kvm/lib/powerpc/ucall.c    |  22 +
 tools/testing/selftests/kvm/lib/riscv/processor.c  |   4 +-
 tools/testing/selftests/kvm/lib/s390/processor.c   |   7 +-
 tools/testing/selftests/kvm/lib/x86/processor.c    |  15 +-
 tools/testing/selftests/kvm/memslot_perf_test.c    |   7 +-
 tools/testing/selftests/kvm/s390/cmma_test.c       |  19 +-
 tools/testing/selftests/kvm/s390/irq_routing.c     |   2 +-
 .../testing/selftests/kvm/set_memory_region_test.c |   8 +-
 tools/testing/selftests/kvm/steal_time.c           |  20 +-
 tools/testing/selftests/kvm/x86/amx_test.c         |   2 +-
 tools/testing/selftests/kvm/x86/cpuid_test.c       |   2 +-
 tools/testing/selftests/kvm/x86/hyperv_clock.c     |   2 +-
 tools/testing/selftests/kvm/x86/hyperv_evmcs.c     |   4 +-
 tools/testing/selftests/kvm/x86/hyperv_svm_test.c  |   2 +-
 tools/testing/selftests/kvm/x86/set_boot_cpu_id.c  |   2 +-
 .../kvm/x86/smaller_maxphyaddr_emulation_test.c    |   9 +-
 tools/testing/selftests/kvm/x86/state_test.c       |   4 +-
 tools/testing/selftests/kvm/x86/tsc_msrs_test.c    |   2 +-
 .../selftests/kvm/x86/vmx_nested_la57_state_test.c |   2 +-
 .../selftests/kvm/x86/vmx_preemption_timer_test.c  |   4 +-
 44 files changed, 1144 insertions(+), 167 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/hcall.h
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/kvm_util_arch.h
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/ppc_asm.h
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/processor.h
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/ucall.h
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/handlers.S
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/hcall.c
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/processor.c
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/ucall.c
