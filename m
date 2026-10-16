Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BB53A6B77
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 04:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792125874; cv=none; b=DOsx0EK0W4yXoHqTZtnv8a/xabJJScPfm/juBY2vTXQ8PF4mZNbbSDR9A53u3UhAfT6ArOharRGly1DO9p6vbZd62hAiEk5H5CZwB3LUfTNZctmoDIOmcUcTEUi81XG/cGkhHSnlBWIku8D6BTeGBksHadnWxfW1ptNlJ5+xmz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792125874; c=relaxed/simple;
	bh=BI8LboydJDmCLOgFAWDKwKKmSthXHsSH6WEzLYZ2ou0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ri2Qn5ByUy/4e+2m4uWx0k+aRrvrQsbXXAtgGwb7BDmMcI5Xlw0EJrD7An9l1kjT4bEDDu0pXpoaZooOaTZnp4RN7deznQnQaZISwkOrVK5okZHX5lSbnWnrHIUpS/bHPToeEtmXVwP7z/O3LlXo5n43bB3xtpP2RQf440JSAYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lwM1/yQc; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lwM1/yQc"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ab27eb38d6so2522596a91.2
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 21:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792125865; x=1792730665; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0dsL2LXx3zlXkaINPvu2OhA7+saKQIia3nDteA/w9/A=;
        b=lwM1/yQcAsmWLes5Xgvbr+3IFUaCBFhao5bpv3W5SWhnd/Li2JMfYuPUXVD7JNdhT8
         ejUYYSVVZbBlYlUIQm4zSHzvrEXS4d0k+q+iiLHUtVZ9DtcmTqiJJBeFN3r+XDWhVyb4
         kmV4+Xc1h2U/k/M0VHUklj5Xj9vzlKmY2h6rN3WSn+q5YkyVefU/bkG83PTqC14jWK6J
         OJw5tWvR/DLWoo2De0YyZdTnme+VxTphZH5bhGd9dRFf5asb+7pCnro36czz3xOj4SDq
         blbT6dNsEM85yhfdEGPrCgGaHh2P3H7WsT2GvIBy37cdt0MBdt2v2jZ6eVZnzChgctkm
         zGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792125865; x=1792730665;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0dsL2LXx3zlXkaINPvu2OhA7+saKQIia3nDteA/w9/A=;
        b=TFasLZtYqTcNNZQ2GjU0L0KBjQ7NkKZhOAxBPnVAO6pl355FUpdx6HnwXYe6TmogtN
         MOc1CBNt64JJ3bxc7HdYdVXrQdVYFSQK5B2h2OzDVaH+vKb8juVoCRbhzwG+sXQ3M0D9
         zj6sfzIGH+bVzWu7Yu31Cq4tezipjAgNvHQHOYKX2RW1wl9TMOT8ln1QxqMT3t+6cQ6l
         bY2bgtR0fvZyRfLe3QrxRxNunpFxcWqExKoYY6IxjfPJ5HsjPP591NRFulst/WksJFeE
         qODnB6ipbQo9UJzYvVpQRoplkqOMSapyGdARboQdxRQwlcpjERbqu1HYFlJE2hagxPMD
         JZDw==
X-Gm-Message-State: AFq9FYJ2BaTMyvDj6XO623GrO471EFFcx2MbuiCJoZlvz84iR/5A6FJF
	uwsKj2oxIvPtuZi/VfT2asny2raJPuf8QtFifRrHtyY1czqBJCjKad+QQcuMhw5Q7ohi8tI7dBy
	bVBNt3w==
X-Received: from pjbkk5.prod.google.com ([2002:a17:90b:4a05:b0:3ab:ef97:851c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:53c6:b0:3ab:e588:c275
 with SMTP id 98e67ed59e1d1-3abe588f863mr11870863a91.20.1792125864501; Thu, 15
 Oct 2026 21:44:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 15 Oct 2026 21:44:11 -0700
In-Reply-To: <20261016044415.958618-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261016044415.958618-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <20261016044415.958618-7-seanjc@google.com>
Subject: [GIT PULL] KVM: Selftests changes for 7.4
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Note, there are five actual KVM changes lurking in here.  They're all relatively
small/minor and were accompanied by large selftests cleanups, so I plopped them
into "selftests" to avoid having significant selftests changes in 4+ branches.

As mentioned in the PPC selftests pull request, the memory regions rework will
silently conflict with kvm/master:

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

The VMX APIs purge will also conflict with kvm/master, thanks to the newly
minted nested_x2apic_test.c.  The resolution is straightfoward, but tedious
and ugly:

 +static void l1_vmx_code(struct vmx_pages *vmx, struct hyperv_test_pages *hv_pages)
 +{
 +      u64 control;
 +
 +      if (hv_pages) {
 +              wrmsr(HV_X64_MSR_GUEST_OS_ID, HYPERV_LINUX_OS_ID);
 +              enable_vp_assist(hv_pages->vp_assist_gpa, hv_pages->vp_assist);
 +              evmcs_enable();
 +      }
 +
-       GUEST_ASSERT_EQ(prepare_for_vmx_operation(vmx), true);
++      prepare_for_vmx_operation(vmx);
 +
 +      if (hv_pages) {
-               GUEST_ASSERT(load_evmcs(hv_pages));
++              load_evmcs(hv_pages);
 +              current_evmcs->hv_enlightenments_control.msr_bitmap = 1;
 +      } else {
-               GUEST_ASSERT(load_vmcs(vmx));
++              load_vmcs(vmx);
 +      }
 +
 +      prepare_vmcs(vmx, NULL);
-       GUEST_ASSERT_EQ(vmwrite(GUEST_RIP, (unsigned long)l2_guest_code), 0);
++      vmwrite(GUEST_RIP, (unsigned long)l2_guest_code);
 +
-       control = vmreadz(PIN_BASED_VM_EXEC_CONTROL);
++      control = vmread(PIN_BASED_VM_EXEC_CONTROL);
 +      control |= PIN_BASED_EXT_INTR_MASK;
 +      vmwrite(PIN_BASED_VM_EXEC_CONTROL, control);
 +
-       control = vmreadz(CPU_BASED_VM_EXEC_CONTROL);
++      control = vmread(CPU_BASED_VM_EXEC_CONTROL);
 +      control |= CPU_BASED_USE_MSR_BITMAPS | CPU_BASED_TPR_SHADOW;
-       GUEST_ASSERT_EQ(vmwrite(CPU_BASED_VM_EXEC_CONTROL, control), 0);
++      vmwrite(CPU_BASED_VM_EXEC_CONTROL, control);
 +
-       control = vmreadz(SECONDARY_VM_EXEC_CONTROL);
++      control = vmread(SECONDARY_VM_EXEC_CONTROL);
 +      control |= SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
 +                 SECONDARY_EXEC_APIC_REGISTER_VIRT |
 +                 SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY;
 +      control &= (rdmsr(MSR_IA32_VMX_PROCBASED_CTLS2) >> 32);
-       GUEST_ASSERT_EQ(vmwrite(SECONDARY_VM_EXEC_CONTROL, control), 0);
++      vmwrite(SECONDARY_VM_EXEC_CONTROL, control);
 +
-       GUEST_ASSERT(!vmlaunch());
-       GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON), EXIT_REASON_CPUID);
-       GUEST_ASSERT_EQ(vmwrite(GUEST_RIP,
-                       vmreadz(GUEST_RIP) + vmreadz(VM_EXIT_INSTRUCTION_LEN)), 0);
++      vmlaunch();
++      GUEST_ASSERT_EQ(vmread(VM_EXIT_REASON), EXIT_REASON_CPUID);
++      vmwrite(GUEST_RIP, vmread(GUEST_RIP) + vmread(VM_EXIT_INSTRUCTION_LEN));
 +}
 +
 +static void l1_vmx_code_part2(void)
 +{
 +      u64 control;
 +
-       control = vmreadz(CPU_BASED_VM_EXEC_CONTROL);
++      control = vmread(CPU_BASED_VM_EXEC_CONTROL);
 +      control &= ~CPU_BASED_TPR_SHADOW;
-       GUEST_ASSERT_EQ(vmwrite(CPU_BASED_VM_EXEC_CONTROL, control), 0);
++      vmwrite(CPU_BASED_VM_EXEC_CONTROL, control);
 +
-       control = vmreadz(SECONDARY_VM_EXEC_CONTROL);
++      control = vmread(SECONDARY_VM_EXEC_CONTROL);
 +      control &= ~(SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
 +                      SECONDARY_EXEC_APIC_REGISTER_VIRT |
 +                      SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY);
-       GUEST_ASSERT_EQ(vmwrite(SECONDARY_VM_EXEC_CONTROL, control), 0);
++      vmwrite(SECONDARY_VM_EXEC_CONTROL, control);
 +
-       GUEST_ASSERT(!vmresume());
-       GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON), EXIT_REASON_CPUID);
-       GUEST_ASSERT_EQ(vmwrite(GUEST_RIP,
-                       vmreadz(GUEST_RIP) + vmreadz(VM_EXIT_INSTRUCTION_LEN)), 0);
++      vmresume();
++      GUEST_ASSERT_EQ(vmread(VM_EXIT_REASON), EXIT_REASON_CPUID);
++      vmwrite(GUEST_RIP, vmread(GUEST_RIP) + vmread(VM_EXIT_INSTRUCTION_LEN));
 +}

The following changes since commit d4b7fb647204f0c81dfeae2d1a708e4d858e0c94:

  Merge branch 'kvm-xen-longmode' into HEAD (2026-09-04 17:35:03 +0200)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-selftests-7.4

for you to fetch changes up to bef953c069806148ae2f10714b39a08726c9a076:

  KVM: selftests: Spell out UCALL in nested TSC scaling test's enums (2026-09-30 14:23:47 -0700)

----------------------------------------------------------------
KVM selftests changes and a few KVM x86 fixes for 7.4

 - Fix emulation of VMPTRST and VMPTRLD when eVMCS is in-use to match real
   Hyper-V's behavior.

 - Saturate L2's TSC frequency if stacking L1 and L2 scaling multipliers
   exceeds what hardware supports, as attempting to run L2 with an illegal
   multiplier will either cause VM-Entry to fail (VMX) or trigger a #GP when
   writing MSR_AMD64_TSC_RATIO (SVM).  The #GP is thankfully benign in the
   grand scheme as even "unsafe" WRMSRs have exception fixup.

 - Rework KVM selftest's handling of memory regions so that PPC can force its
   page table allocations to be naturally aligned.

 - Clean up selftest's VMX instruction helpers, and drop an absurd number of
   completely useless return values, e.g. functions that unconditionally
   return %true and then have every caller assert success.

 - Add selftests support for Zhaoxin CPUs.

 - Overhaul the TSC scaling test to add a regression test for the saturation
   behavior, and to increase its coverage in general.

 - Fix selftests usage various NUMA syscalls to account for an undocumented,
   but known since 2007, off-by-one kernel bug.  Add helpers to try and avoid
   re-introducing the same flaws in the future.

 - Automatically run xAPIC IPI migration test (between NUMA nodes) when
   possible, as the entire point of the test is verify KVM's handling of page
   migration of the APIC backing page.

 - Misc cleanups.

----------------------------------------------------------------
Amirmohammad Eftekhar (1):
      KVM: x86: Saturate L2's TSC frequency if it exceeds hardware supports

Chaithanya Lagisetty (3):
      KVM: selftests: Fix the never-true negative UFFD delay check
      KVM: selftests: Fix transposed calloc() arguments in the uffd helper
      KVM: selftests: Check calloc() return in vcpu_get_reg_list()

Frank Zhu (8):
      KVM: selftests: Add Zhaoxin CPU detection support
      KVM: selftests: Use host_cpu_is_intel_compatible for mediated PMU
      KVM: selftests: Add TDP detection for Zhaoxin CPUs
      KVM: selftests: Allow running invalid guest state test on Zhaoxin CPUs
      KVM: selftests: Add Zhaoxin CPU support in x86's "fix" hypercall test
      KVM: selftests: Extend Intel MSR_IA32_UCODE_REV quirk to Zhaoxin
      KVM: selftests: Add Zhaoxin CPU support to nested exceptions test
      KVM: selftests: Check for APIC access virtualization support in said test

Gokul K (6):
      KVM: selftests: Fix the bounds of the SEV debug dst buffer check
      KVM: selftests: Free the VM when the SEV smoke test's guest completes
      KVM: selftests: Free the VM when NX hugepage disabling is denied
      KVM: selftests: Delete the declaration of vcpu_set_cpuid_maxphyaddr()
      KVM: selftests: Move test_read() into elf.c and delete lib/io.c
      KVM: selftests: Delete the unused guest_snprintf()

Hisam Mehboob (1):
      KVM: selftests: Replace ulong with unsigned long

Nicholas Piggin (1):
      KVM: selftests: Use goto instead of do-while to retry finding unused physical pages

Sean Christopherson (57):
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
      KVM: selftests: Don't clobber RFLAGS in happy path of __KVM_ASM_SAFE()
      KVM: selftests: Assert success in vmptrst(), kill off vmptrstz()
      KVM: selftests: Always assert that vmxon() and prepare_for_vmx_operation() succeed
      KVM: selftests: Always assert that vmclear() succeeds
      KVM: selftests: Always assert that vmptrld() succeeds
      KVM: selftests: Drop useless return code from load_vmcs()
      KVM: selftests: Add macros to handle simple VMX instructions
      KVM: selftests: Drop dead return code from evmcs_vmptrld() and load_evmcs()
      KVM: selftests: Dedup assembly code for VMLAUNCH and VMRESUME
      KVM: selftests: Assert success in vmlaunch() and vmresume()
      KVM: selftests: Add __vmwrite() and use it when initializing optional fields.
      KVM: selftests: Always assert that vmwrite() succeeds
      KVM: selftests: Always assert that vmreadz() succeeds
      KVM: selftests: Account for kernel's off-by-one bug in NUMA node syscalls
      KVM: selftests: Compute node masks on-demand in xAPIC IPI test
      KVM: selftests: Add common helper to get mask+number of usable memory NUMA nodes
      KVM: selftests: Automatically run xAPIC IPI migration test when possible
      KVM: selftests: Skip xAPIC IPI migration test when forced but unsupported
      KVM: SVM: Fallback to the default TSC ratio if KVM tries to use a bad multiplier
      KVM: x86: Allow userspace to set KVM's max supported guest TSC frequency
      KVM: selftests: Use KVM's pRNG to randomize L1's TSC ratio in TSC scaling test
      KVM: selftests: Drop redundant VMWRITE of TSC_MULTIPLIER_HIGH
      KVM: selftests: Drop unnecessary use of PRIu64 in nested TSC scaling test
      KVM: selftests: Randomize L2's scale factor in nested TSC scaling test
      KVM: selftests: Rename TSC freq checkers in nested TSC scaling test
      KVM: selftests: Extract guts of nested TSC scaling test to helper function
      KVM: selftests: Track L2 multiplier, not scale-up factor, in nested TSC test
      KVM: selftests: Print out the failing L{0,1,2} level in nested TSC scaling test
      KVM: selftests: Allow +/- 1 tolerance if expected TSC frequency is <100
      KVM: selftests: Use KVM's reported TSC KHz as L0's frequency (sanity checked)
      KVM: selftests: Explicitly pass TSC frequencies to guts of TSC scaling test
      KVM: selftests: Sanity check KVM's default TSC freq in nested TSC scaling test
      KVM: selftests: Test L1 "up" and L2 "down" in nested TSC scaling test
      KVM: selftests: Verify that KVM saturates L2 TSC freq on {under,over}flow
      KVM: selftests: Test non-zero TSC offset on SVM in nested TSC scaling test
      KVM: selftests: Randomize L2's TSC offset in the nested TSC scaling test
      KVM: selftests: Use GUEST_SYNC2() in nested TSC scaling test
      KVM: selftests: Spell out UCALL in nested TSC scaling test's enums

Shivank Garg (2):
      KVM: selftests: Fix maxnode argument to migrate_pages() in xapic_ipi_test
      KVM: selftests: use BITS_PER_TYPE() for NUMA masks

Vitaly Kuznetsov (4):
      KVM: nVMX: Make VMPTRLD result in #UD when eVMCS is used
      KVM: nVMX: Make VMPTRST return eVMCS GPA when it is used
      KVM: selftests: Adapt to the updated VMPTRST behavior when eVMCS is used
      KVM: selftests: Check VMPTRLD with active eVMCS

 arch/x86/kvm/svm/svm.c                             |   9 +
 arch/x86/kvm/vmx/nested.c                          |  24 +-
 arch/x86/kvm/x86.c                                 |  62 +++++-
 tools/testing/selftests/kvm/Makefile.kvm           |   1 -
 tools/testing/selftests/kvm/arm64/hypercalls.c     |   2 +-
 .../testing/selftests/kvm/arm64/page_fault_test.c  |  18 +-
 .../testing/selftests/kvm/arm64/vgic_lpi_stress.c  |  21 +-
 tools/testing/selftests/kvm/demand_paging_test.c   |   3 +-
 tools/testing/selftests/kvm/guest_memfd_test.c     |   2 +-
 tools/testing/selftests/kvm/include/kvm_util.h     | 106 +++++++--
 tools/testing/selftests/kvm/include/numaif.h       |  43 ++++
 tools/testing/selftests/kvm/include/test_util.h    |   5 -
 tools/testing/selftests/kvm/include/x86/evmcs.h    |  78 +------
 .../testing/selftests/kvm/include/x86/processor.h  |  13 +-
 tools/testing/selftests/kvm/include/x86/smm.h      |   2 +-
 tools/testing/selftests/kvm/include/x86/vmx.h      | 178 ++++++---------
 tools/testing/selftests/kvm/lib/arm64/processor.c  |   4 +-
 tools/testing/selftests/kvm/lib/elf.c              |  48 +++-
 tools/testing/selftests/kvm/lib/guest_sprintf.c    |  12 -
 tools/testing/selftests/kvm/lib/io.c               | 157 -------------
 tools/testing/selftests/kvm/lib/kvm_util.c         | 128 ++++++-----
 .../selftests/kvm/lib/loongarch/processor.c        |   5 +-
 tools/testing/selftests/kvm/lib/riscv/processor.c  |   4 +-
 tools/testing/selftests/kvm/lib/s390/processor.c   |   7 +-
 tools/testing/selftests/kvm/lib/userfaultfd_util.c |   6 +-
 tools/testing/selftests/kvm/lib/x86/memstress.c    |   8 +-
 tools/testing/selftests/kvm/lib/x86/processor.c    |  23 +-
 tools/testing/selftests/kvm/lib/x86/vmx.c          | 159 +++++++++-----
 tools/testing/selftests/kvm/memslot_perf_test.c    |   5 +-
 tools/testing/selftests/kvm/s390/cmma_test.c       |  19 +-
 tools/testing/selftests/kvm/s390/irq_routing.c     |   2 +-
 .../testing/selftests/kvm/set_memory_region_test.c |   8 +-
 tools/testing/selftests/kvm/steal_time.c           |  20 +-
 tools/testing/selftests/kvm/x86/amx_test.c         |   2 +-
 tools/testing/selftests/kvm/x86/aperfmperf_test.c  |  10 +-
 tools/testing/selftests/kvm/x86/cpuid_test.c       |   2 +-
 .../selftests/kvm/x86/evmcs_smm_controls_test.c    |   6 +-
 .../testing/selftests/kvm/x86/feature_msrs_test.c  |   2 +-
 .../testing/selftests/kvm/x86/fix_hypercall_test.c |   2 +-
 tools/testing/selftests/kvm/x86/hyperv_clock.c     |   2 +-
 tools/testing/selftests/kvm/x86/hyperv_evmcs.c     |  87 +++++---
 tools/testing/selftests/kvm/x86/hyperv_svm_test.c  |   2 +-
 tools/testing/selftests/kvm/x86/kvm_buslock_test.c |   8 +-
 .../selftests/kvm/x86/nested_close_kvm_test.c      |   6 +-
 .../selftests/kvm/x86/nested_dirty_log_test.c      |   8 +-
 .../selftests/kvm/x86/nested_emulation_test.c      |  23 +-
 .../selftests/kvm/x86/nested_exceptions_test.c     |  33 +--
 .../selftests/kvm/x86/nested_invalid_cr3_test.c    |  14 +-
 .../selftests/kvm/x86/nested_tdp_fault_test.c      |  16 +-
 .../selftests/kvm/x86/nested_tsc_adjust_test.c     |  10 +-
 .../selftests/kvm/x86/nested_tsc_scaling_test.c    | 244 +++++++++++++--------
 .../testing/selftests/kvm/x86/nx_huge_pages_test.c |   3 +-
 .../kvm/x86/save_restore_pf_stress_test.c          |  14 +-
 tools/testing/selftests/kvm/x86/set_boot_cpu_id.c  |   2 +-
 tools/testing/selftests/kvm/x86/sev_dbg_test.c     |   6 +-
 tools/testing/selftests/kvm/x86/sev_smoke_test.c   |   3 +-
 .../kvm/x86/smaller_maxphyaddr_emulation_test.c    |   9 +-
 tools/testing/selftests/kvm/x86/smm_test.c         |   4 +-
 tools/testing/selftests/kvm/x86/state_test.c       |  74 +++----
 .../selftests/kvm/x86/triple_fault_event_test.c    |   8 +-
 tools/testing/selftests/kvm/x86/tsc_msrs_test.c    |   2 +-
 .../selftests/kvm/x86/vmx_apic_access_test.c       |  22 +-
 .../selftests/kvm/x86/vmx_apicv_updates_test.c     |  16 +-
 .../x86/vmx_exception_with_invalid_guest_state.c   |   2 +-
 .../kvm/x86/vmx_invalid_nested_guest_state.c       |  12 +-
 .../selftests/kvm/x86/vmx_nested_la57_state_test.c |  12 +-
 .../selftests/kvm/x86/vmx_preemption_timer_test.c  |  28 ++-
 tools/testing/selftests/kvm/x86/xapic_ipi_test.c   |  78 +++----
 68 files changed, 1024 insertions(+), 930 deletions(-)
 delete mode 100644 tools/testing/selftests/kvm/lib/io.c
