Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439903AD531
	for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 18:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776970179; cv=none; b=t9zs3bNcuh5JK9QjpE/Fi/d0yVrqRVVsiGW3iFhJyBwlyZsbFhcQy/FISLPGkkwjwJaO8sPdhz/Dr97dnobDY0wTpcz6h705YaJzN8hDAqrmz0BCsbZqujb535tuW0RDHlxNeNjOe+rkFjMRY41q6ATKxpv3kYDv6OEazzQEhug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776970179; c=relaxed/simple;
	bh=4qmAQ4e6ArlrbFMfv+F0Gr+8OMRSz5zI4QuRlTB2wQc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bNWbSonnwLV1oAMje8Mj5hOtswvP7X7hJlrNWLduWc6XshELLxdoeUpViz54GS6nV9fAUwNu4uAi2WfSp8D+yYrH0ZpKt8ovrMFEMRWWrcgC1i2thiQ6dsZyB1Cy8OeVqA4Zd35pZOCByvj5Cufy+X07xCG31DQdaKuG/mObQnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eaze9RHY; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eaze9RHY"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f6b0a7164so9608647b3a.0
        for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 11:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776970175; x=1777574975; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Thxq7Z2U7ipDk39lT4axS45cYUZ0X4lorQ8XdMbWBeo=;
        b=eaze9RHYOW9ROOt728SyE40gpEK9wb61C2Wm8jj1W0WrvL3oafiZKP6TTqDzNo01sB
         soa8dx/oQEq5qcDqLQtUeecA8Ft4bLQsPeiAGg568S/1flbx8horqhfFbI4+tZqi+FN+
         IXUwbvcm/dujEVcHda6cQAtYrSoLWQKVoCPD7heruFUEGQtlB6qP+9QLF9F8nMEv71lm
         OJvV+PhCi2BG2mMnQrPOBjsrB04s1Fp0q6huKswLuL5vm1Lm5e3JW4T09nutqhN4e0Yt
         hpXCGHGsKQNu83O1AOKYAw9WAeihsuuXUrO0wtcYCtmmo9N71WLle/9ToXegwk5F1h8g
         uUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776970175; x=1777574975;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Thxq7Z2U7ipDk39lT4axS45cYUZ0X4lorQ8XdMbWBeo=;
        b=S24MOCaZsb8PF2Uo09EZjBpbr4edvyq1eDocZgrX9yfGgfm4u8J+EhCYdfJui6qBqS
         faA3pJKbvFxEN0bnyMq3urQ5fpjxKa/GkrEScPeDnIe0+xiiStCur0UH/wlT3B/J2Kvj
         lGiAQ+3HFWiZSz43rOvh3CPYJKAvCvdqDBNrUuk4f74OZsulM6CG9b+6Mu7Wce96WtYV
         poF3Q0fiX0yd8KzT6lXyW+QKaTVJDN1J6wPqKjjQdqNLeuxzOx4Aye6A1oSqDR9ti4Ho
         p3mWyOkjqNQyF1rAzjQGzN6lO/lqt4rQb8K/4PH+y5ZBcAtkCqeRV3shKsO0kq2wuJ1i
         vcwQ==
X-Gm-Message-State: AOJu0YzCwVfS5UYlT0rxIWe8m6WwpmtnuGZ8seOIkX5PXUQTc7aZqd9V
	RAshxYxtCNSYtkcuAIRV396SFyY2YIAAk2yy6n1+f0culoH3vqGGL8V8tLUfGrp4Kt2DGFtuCr1
	dPgqzOw==
X-Received: from pfxx14.prod.google.com ([2002:a05:6a00:10e:b0:82f:a139:b084])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:6505:b0:82f:9de6:3b2a
 with SMTP id d2e1a72fcca58-82f9de63dadmr16454717b3a.8.1776970175213; Thu, 23
 Apr 2026 11:49:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 23 Apr 2026 11:49:32 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260423184932.547047-1-seanjc@google.com>
Subject: [GIT PULL] KVM: Selftests type renames for 7.1
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Please pull an invasive set of "tree"-wide changes to switch selftests to the
kernel's preferred naming for common types and variables.  This has been in
-next all week, and I verified a variety of selftests generate identical code
before and after, so I'm reasonably confident I didn't break non-x86
architectures.

Speaking of non-x86, please also apply a patch to fix LoongArch selftests:

  https://lore.kernel.org/all/20260420192644.3892050-1-seanjc@google.com

which got broken by the RISC-V changes this cycle.

Thanks!


The following changes since commit 6b802031877a995456c528095c41d1948546bf45:

  Merge tag 'kvm-s390-next-7.1-1' of https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD (2026-04-13 19:01:15 +0200)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-selftests_kernel_types-7.1

for you to fetch changes up to dfd2a8b07c6cc94145e11d87d2f11137d6444854:

  KVM: selftests: Replace "paddr" with "gpa" throughout (2026-04-20 14:54:17 -0700)

----------------------------------------------------------------
KVM selftests type renames for 7.1

Renames types across all KVM selftests to more closely align with types used
in the kernel:

  vm_vaddr_t -> gva_t
  vm_paddr_t -> gpa_t

  uint64_t -> u64
  uint32_t -> u32
  uint16_t -> u16
  uint8_t  -> u8

  int64_t -> s64
  int32_t -> s32
  int16_t -> s16
  int8_t  -> s8

Using the kernel's preferred types eliminates a source of friction for many
contributors, as the majority of KVM selftests contributions come from kernel
developers.  The kernel names are also shorter, which allows for more concise
code, and in any many cases eliminates newlines thanks to shorter types and
parameter names.

Rename variables and parameters as well as types, e.g. gpa instead of paddr,
to again align with the kernel, and in a few cases to remove ambiguity, e.g.
where paddr is used to refer to a _host_ physical address.

----------------------------------------------------------------
David Matlack (10):
      KVM: selftests: Use gva_t instead of vm_vaddr_t
      KVM: selftests: Use gpa_t instead of vm_paddr_t
      KVM: selftests: Use gpa_t for GPAs in Hyper-V selftests
      KVM: selftests: Use u64 instead of uint64_t
      KVM: selftests: Use s64 instead of int64_t
      KVM: selftests: Use u32 instead of uint32_t
      KVM: selftests: Use s32 instead of int32_t
      KVM: selftests: Use u16 instead of uint16_t
      KVM: selftests: Use s16 instead of int16_t
      KVM: selftests: Use u8 instead of uint8_t

Sean Christopherson (9):
      KVM: selftests: Drop "vaddr_" from APIs that allocate memory for a given VM
      KVM: selftests: Rename vm_vaddr_unused_gap() => vm_unused_gva_gap()
      KVM: selftests: Rename vm_vaddr_populate_bitmap() => vm_populate_gva_bitmap()
      KVM: selftests: Rename translate_to_host_paddr() => translate_hva_to_hpa()
      KVM: selftests: Clarify that arm64's inject_uer() takes a host PA, not a guest PA
      KVM: selftests: Replace "vaddr" with "gva" throughout
      KVM: selftests: Replace "u64 gpa" with "gpa_t" throughout
      KVM: selftests: Replace "u64 nested_paddr" with "gpa_t l2_gpa"
      KVM: selftests: Replace "paddr" with "gpa" throughout

 .../selftests/kvm/access_tracking_perf_test.c      |  44 +--
 tools/testing/selftests/kvm/arch_timer.c           |   6 +-
 .../testing/selftests/kvm/arm64/aarch32_id_regs.c  |  14 +-
 tools/testing/selftests/kvm/arm64/arch_timer.c     |   8 +-
 .../selftests/kvm/arm64/arch_timer_edge_cases.c    | 161 +++++----
 .../testing/selftests/kvm/arm64/debug-exceptions.c |  72 ++---
 tools/testing/selftests/kvm/arm64/hypercalls.c     |  24 +-
 tools/testing/selftests/kvm/arm64/idreg-idst.c     |   4 +-
 tools/testing/selftests/kvm/arm64/no-vgic.c        |   8 +-
 .../testing/selftests/kvm/arm64/page_fault_test.c  |  82 ++---
 tools/testing/selftests/kvm/arm64/psci_test.c      |  26 +-
 tools/testing/selftests/kvm/arm64/sea_to_user.c    |  41 ++-
 tools/testing/selftests/kvm/arm64/set_id_regs.c    |  70 ++--
 tools/testing/selftests/kvm/arm64/smccc_filter.c   |  10 +-
 tools/testing/selftests/kvm/arm64/vgic_init.c      |  56 ++--
 tools/testing/selftests/kvm/arm64/vgic_irq.c       | 137 ++++----
 .../testing/selftests/kvm/arm64/vgic_lpi_stress.c  |  20 +-
 tools/testing/selftests/kvm/arm64/vgic_v5.c        |  10 +-
 .../selftests/kvm/arm64/vpmu_counter_access.c      |  56 ++--
 tools/testing/selftests/kvm/coalesced_io_test.c    |  38 +--
 tools/testing/selftests/kvm/demand_paging_test.c   |  10 +-
 tools/testing/selftests/kvm/dirty_log_perf_test.c  |  14 +-
 tools/testing/selftests/kvm/dirty_log_test.c       |  82 ++---
 tools/testing/selftests/kvm/get-reg-list.c         |   2 +-
 tools/testing/selftests/kvm/guest_memfd_test.c     |  18 +-
 tools/testing/selftests/kvm/guest_print_test.c     |  22 +-
 .../testing/selftests/kvm/hardware_disable_test.c  |   6 +-
 .../selftests/kvm/include/arm64/arch_timer.h       |  30 +-
 tools/testing/selftests/kvm/include/arm64/delay.h  |   4 +-
 tools/testing/selftests/kvm/include/arm64/gic.h    |   8 +-
 .../selftests/kvm/include/arm64/gic_v3_its.h       |   7 +-
 .../selftests/kvm/include/arm64/processor.h        |  22 +-
 tools/testing/selftests/kvm/include/arm64/ucall.h  |   4 +-
 tools/testing/selftests/kvm/include/arm64/vgic.h   |  22 +-
 tools/testing/selftests/kvm/include/kvm_util.h     | 344 ++++++++++----------
 .../testing/selftests/kvm/include/kvm_util_types.h |   8 +-
 .../selftests/kvm/include/loongarch/arch_timer.h   |   4 +-
 .../selftests/kvm/include/loongarch/ucall.h        |   4 +-
 tools/testing/selftests/kvm/include/memstress.h    |  30 +-
 .../selftests/kvm/include/riscv/arch_timer.h       |  22 +-
 .../selftests/kvm/include/riscv/processor.h        |   9 +-
 tools/testing/selftests/kvm/include/riscv/ucall.h  |   4 +-
 .../kvm/include/s390/diag318_test_handler.h        |   2 +-
 .../testing/selftests/kvm/include/s390/facility.h  |   4 +-
 tools/testing/selftests/kvm/include/s390/ucall.h   |   4 +-
 tools/testing/selftests/kvm/include/sparsebit.h    |   6 +-
 tools/testing/selftests/kvm/include/test_util.h    |  40 +--
 tools/testing/selftests/kvm/include/timer_test.h   |  18 +-
 tools/testing/selftests/kvm/include/ucall_common.h |  22 +-
 .../selftests/kvm/include/userfaultfd_util.h       |   6 +-
 tools/testing/selftests/kvm/include/x86/apic.h     |  22 +-
 tools/testing/selftests/kvm/include/x86/evmcs.h    |  22 +-
 tools/testing/selftests/kvm/include/x86/hyperv.h   |  28 +-
 .../selftests/kvm/include/x86/kvm_util_arch.h      |  36 +--
 tools/testing/selftests/kvm/include/x86/pmu.h      |   9 +-
 .../testing/selftests/kvm/include/x86/processor.h  | 292 +++++++++--------
 tools/testing/selftests/kvm/include/x86/sev.h      |  20 +-
 tools/testing/selftests/kvm/include/x86/smm.h      |   3 +-
 tools/testing/selftests/kvm/include/x86/svm_util.h |  12 +-
 tools/testing/selftests/kvm/include/x86/ucall.h    |   2 +-
 tools/testing/selftests/kvm/include/x86/vmx.h      |  70 ++--
 tools/testing/selftests/kvm/kvm_page_table_test.c  |  54 ++--
 tools/testing/selftests/kvm/lib/arm64/gic.c        |   6 +-
 .../testing/selftests/kvm/lib/arm64/gic_private.h  |  26 +-
 tools/testing/selftests/kvm/lib/arm64/gic_v3.c     |  90 +++---
 tools/testing/selftests/kvm/lib/arm64/gic_v3_its.c |  11 +-
 tools/testing/selftests/kvm/lib/arm64/processor.c  | 163 +++++-----
 tools/testing/selftests/kvm/lib/arm64/ucall.c      |  12 +-
 tools/testing/selftests/kvm/lib/arm64/vgic.c       |  40 +--
 tools/testing/selftests/kvm/lib/elf.c              |  17 +-
 tools/testing/selftests/kvm/lib/guest_modes.c      |   2 +-
 tools/testing/selftests/kvm/lib/guest_sprintf.c    |  18 +-
 tools/testing/selftests/kvm/lib/kvm_util.c         | 359 +++++++++------------
 .../selftests/kvm/lib/loongarch/processor.c        | 110 +++----
 tools/testing/selftests/kvm/lib/loongarch/ucall.c  |  12 +-
 tools/testing/selftests/kvm/lib/memstress.c        |  38 +--
 tools/testing/selftests/kvm/lib/riscv/processor.c  |  91 +++---
 .../selftests/kvm/lib/s390/diag318_test_handler.c  |  12 +-
 tools/testing/selftests/kvm/lib/s390/facility.c    |   2 +-
 tools/testing/selftests/kvm/lib/s390/processor.c   |  65 ++--
 tools/testing/selftests/kvm/lib/sparsebit.c        |  18 +-
 tools/testing/selftests/kvm/lib/test_util.c        |  30 +-
 tools/testing/selftests/kvm/lib/ucall_common.c     |  34 +-
 tools/testing/selftests/kvm/lib/userfaultfd_util.c |  14 +-
 tools/testing/selftests/kvm/lib/x86/apic.c         |   2 +-
 tools/testing/selftests/kvm/lib/x86/hyperv.c       |  14 +-
 tools/testing/selftests/kvm/lib/x86/memstress.c    |  14 +-
 tools/testing/selftests/kvm/lib/x86/pmu.c          |   8 +-
 tools/testing/selftests/kvm/lib/x86/processor.c    | 292 ++++++++---------
 tools/testing/selftests/kvm/lib/x86/sev.c          |  20 +-
 tools/testing/selftests/kvm/lib/x86/svm.c          |  16 +-
 tools/testing/selftests/kvm/lib/x86/ucall.c        |   4 +-
 tools/testing/selftests/kvm/lib/x86/vmx.c          |  44 +--
 tools/testing/selftests/kvm/loongarch/arch_timer.c |  28 +-
 tools/testing/selftests/kvm/loongarch/pmu_test.c   |  10 +-
 .../kvm/memslot_modification_stress_test.c         |  10 +-
 tools/testing/selftests/kvm/memslot_perf_test.c    | 164 +++++-----
 tools/testing/selftests/kvm/mmu_stress_test.c      |  28 +-
 .../testing/selftests/kvm/pre_fault_memory_test.c  |  12 +-
 tools/testing/selftests/kvm/riscv/arch_timer.c     |   8 +-
 tools/testing/selftests/kvm/riscv/ebreak_test.c    |   6 +-
 tools/testing/selftests/kvm/riscv/get-reg-list.c   |   4 +-
 tools/testing/selftests/kvm/riscv/sbi_pmu_test.c   |   8 +-
 tools/testing/selftests/kvm/s390/debug_test.c      |   8 +-
 tools/testing/selftests/kvm/s390/irq_routing.c     |   2 +-
 tools/testing/selftests/kvm/s390/memop.c           |  94 +++---
 tools/testing/selftests/kvm/s390/resets.c          |   6 +-
 .../selftests/kvm/s390/shared_zeropage_test.c      |   2 +-
 tools/testing/selftests/kvm/s390/tprot.c           |  24 +-
 tools/testing/selftests/kvm/s390/ucontrol_test.c   |   8 +-
 .../testing/selftests/kvm/set_memory_region_test.c |  40 +--
 tools/testing/selftests/kvm/steal_time.c           |  74 ++---
 .../selftests/kvm/system_counter_offset_test.c     |  12 +-
 tools/testing/selftests/kvm/x86/amx_test.c         |  14 +-
 tools/testing/selftests/kvm/x86/aperfmperf_test.c  |  16 +-
 .../selftests/kvm/x86/apic_bus_clock_test.c        |  24 +-
 tools/testing/selftests/kvm/x86/cpuid_test.c       |   6 +-
 tools/testing/selftests/kvm/x86/debug_regs.c       |   4 +-
 .../kvm/x86/dirty_log_page_splitting_test.c        |  16 +-
 .../selftests/kvm/x86/evmcs_smm_controls_test.c    |   6 +-
 tools/testing/selftests/kvm/x86/fastops_test.c     |  52 +--
 .../testing/selftests/kvm/x86/feature_msrs_test.c  |  12 +-
 .../testing/selftests/kvm/x86/fix_hypercall_test.c |  20 +-
 tools/testing/selftests/kvm/x86/flds_emulation.h   |   6 +-
 tools/testing/selftests/kvm/x86/hwcr_msr_test.c    |  10 +-
 tools/testing/selftests/kvm/x86/hyperv_clock.c     |   6 +-
 tools/testing/selftests/kvm/x86/hyperv_evmcs.c     |  10 +-
 .../selftests/kvm/x86/hyperv_extended_hypercalls.c |  20 +-
 tools/testing/selftests/kvm/x86/hyperv_features.c  |  26 +-
 tools/testing/selftests/kvm/x86/hyperv_ipi.c       |  12 +-
 tools/testing/selftests/kvm/x86/hyperv_svm_test.c  |  10 +-
 tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c |  36 +--
 tools/testing/selftests/kvm/x86/kvm_buslock_test.c |   2 +-
 tools/testing/selftests/kvm/x86/kvm_clock_test.c   |  14 +-
 tools/testing/selftests/kvm/x86/kvm_pv_test.c      |  10 +-
 .../testing/selftests/kvm/x86/monitor_mwait_test.c |   2 +-
 .../selftests/kvm/x86/nested_close_kvm_test.c      |   2 +-
 .../selftests/kvm/x86/nested_dirty_log_test.c      |  10 +-
 .../selftests/kvm/x86/nested_emulation_test.c      |  20 +-
 .../selftests/kvm/x86/nested_exceptions_test.c     |   6 +-
 .../selftests/kvm/x86/nested_invalid_cr3_test.c    |   2 +-
 .../selftests/kvm/x86/nested_set_state_test.c      |   4 +-
 .../selftests/kvm/x86/nested_tsc_adjust_test.c     |  12 +-
 .../selftests/kvm/x86/nested_tsc_scaling_test.c    |  24 +-
 .../selftests/kvm/x86/nested_vmsave_vmload_test.c  |   2 +-
 .../testing/selftests/kvm/x86/nx_huge_pages_test.c |  18 +-
 .../testing/selftests/kvm/x86/platform_info_test.c |   6 +-
 .../testing/selftests/kvm/x86/pmu_counters_test.c  | 109 ++++---
 .../selftests/kvm/x86/pmu_event_filter_test.c      | 102 +++---
 .../kvm/x86/private_mem_conversions_test.c         |  78 ++---
 .../selftests/kvm/x86/private_mem_kvm_exits_test.c |  14 +-
 tools/testing/selftests/kvm/x86/set_boot_cpu_id.c  |   6 +-
 tools/testing/selftests/kvm/x86/set_sregs_test.c   |   6 +-
 tools/testing/selftests/kvm/x86/sev_init2_tests.c  |   6 +-
 tools/testing/selftests/kvm/x86/sev_smoke_test.c   |  22 +-
 .../kvm/x86/smaller_maxphyaddr_emulation_test.c    |   8 +-
 tools/testing/selftests/kvm/x86/smm_test.c         |   8 +-
 tools/testing/selftests/kvm/x86/state_test.c       |  14 +-
 tools/testing/selftests/kvm/x86/svm_int_ctl_test.c |   2 +-
 .../selftests/kvm/x86/svm_lbr_nested_state.c       |   2 +-
 .../selftests/kvm/x86/svm_nested_clear_efer_svme.c |   2 +-
 .../selftests/kvm/x86/svm_nested_shutdown_test.c   |   2 +-
 .../kvm/x86/svm_nested_soft_inject_test.c          |  10 +-
 .../selftests/kvm/x86/svm_nested_vmcb12_gpa.c      |  14 +-
 tools/testing/selftests/kvm/x86/svm_vmcall_test.c  |   2 +-
 tools/testing/selftests/kvm/x86/sync_regs_test.c   |   2 +-
 .../selftests/kvm/x86/triple_fault_event_test.c    |   4 +-
 tools/testing/selftests/kvm/x86/tsc_msrs_test.c    |   2 +-
 tools/testing/selftests/kvm/x86/tsc_scaling_sync.c |   4 +-
 .../selftests/kvm/x86/ucna_injection_test.c        |  45 +--
 .../testing/selftests/kvm/x86/userspace_io_test.c  |   4 +-
 .../selftests/kvm/x86/userspace_msr_exit_test.c    |  58 ++--
 .../selftests/kvm/x86/vmx_apic_access_test.c       |   4 +-
 .../selftests/kvm/x86/vmx_apicv_updates_test.c     |   4 +-
 .../kvm/x86/vmx_invalid_nested_guest_state.c       |   2 +-
 tools/testing/selftests/kvm/x86/vmx_msrs_test.c    |  22 +-
 .../selftests/kvm/x86/vmx_nested_la57_state_test.c |   4 +-
 .../testing/selftests/kvm/x86/vmx_pmu_caps_test.c  |  12 +-
 .../selftests/kvm/x86/vmx_preemption_timer_test.c  |   2 +-
 tools/testing/selftests/kvm/x86/xapic_ipi_test.c   |  64 ++--
 tools/testing/selftests/kvm/x86/xapic_state_test.c |  20 +-
 tools/testing/selftests/kvm/x86/xapic_tpr_test.c   |  24 +-
 tools/testing/selftests/kvm/x86/xcr0_cpuid_test.c  |   8 +-
 tools/testing/selftests/kvm/x86/xen_shinfo_test.c  |  22 +-
 tools/testing/selftests/kvm/x86/xss_msr_test.c     |   2 +-
 185 files changed, 2706 insertions(+), 2817 deletions(-)
