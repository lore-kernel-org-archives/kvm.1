Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549F73FD152
	for <kvm@vger.kernel.org>; Wed, 29 Apr 2026 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777469923; cv=none; b=kBga0b66DrsZu2eRxPwjsZpN3SHOy5r+aSoO46MMcJWvtkQwfkbWz2K8zma6a6h22J177bjC1wynvIZm7KJGLD3AZHes79UNQpq6qjwFO1hepRgZ4xeMzZUMpiag71cYgkh2av5XvfaQCQdu9XsnoiG/EgkgoGlEmgPqCW+YAQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777469923; c=relaxed/simple;
	bh=blQ9F4rQP+jVmSQ0Vt+gvwc1DXSuWVDKgWgQnrOG/as=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r8bMK1rhrBm/UrMjxsXvAF6GLp2R+kIBLgNEmPcV4eKLIWeMXPNu/qPXfF2lWzPwK5hgcgAWWdZeOOhsUex5p9dKGhb6eg9WyP8IbT/oLM4T8JbvKe95yz1d4Qw8nsxR9Q8aPE9NgkY8cRi8umRcbmKK3X8XGryj6xL+5HKLUQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gARnhJ/H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gARnhJ/H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777469920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=db2zB6S+nqFAd+djwoHnoYIu4xpMCVcLUQy7XtEigT4=;
	b=gARnhJ/HsPBdXS9Bd/7d2lHHHNOPw+ctmKPsYoxLNgyO6bwCHfghKqdvG80tj+V0cifpdQ
	d0VPAwERDi2ynH3MO6JcFnTbuIc3hOLVk5bbqZGEjH3nmNcC8Vj1jPMYUL/lHrCeeV/5mf
	uht91DkGHWo3EGPSQSn4I6Uq/vTgf9U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-QSVz5YhBOg2vdOad27Mf-A-1; Wed,
 29 Apr 2026 09:38:38 -0400
X-MC-Unique: QSVz5YhBOg2vdOad27Mf-A-1
X-Mimecast-MFC-AGG-ID: QSVz5YhBOg2vdOad27Mf-A_1777469914
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9218718004AD;
	Wed, 29 Apr 2026 13:38:34 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 122E4180045E;
	Wed, 29 Apr 2026 13:38:33 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [GIT PULL] KVM fixes and selftest big rename for Linux 7.1-rc2
Date: Wed, 29 Apr 2026 09:38:33 -0400
Message-ID: <20260429133833.16993-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Linus,

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to 39f1c201b93f4ff71631bac72cff6eb155f976a4:

  Merge tag 'kvm-x86-selftests_kernel_types-7.1' of https://github.com/kvm-x86/linux into HEAD (2026-04-27 04:24:41 -0400)

On top of a lot of Arm fixes, this includes a massive rename of
types and variables in tools/testing/selftests/kvm - these were
unnecessarily different from what the kernel uses, so they're
being made consistent.

If you prefer to have that in 7.2 only, just ask and I'll respin.
I've placed it last so I don't even need to rebase, just create
another tag.

Thanks,

Paolo

----------------------------------------------------------------
Arm:

* Allow tracing for non-pKVM, which was accidentally disabled when
  the series was merged

* Rationalise the way the pKVM hypercall ranges are defined by using
  the same mechanism as already used for the vcpu_sysreg enum

* Enforce that SMCCC function numbers relayed by the pKVM proxy are
  actually compliant with the specification

* Fix a couple of feature to idreg mappings which resulted in the
  wrong sanitisation being applied

* Fix the GICD_IIDR revision number field that could never been
  written correctly by userspace

* Make kvm_vcpu_initialized() correctly use its parameter instead
  of relying on the surrounding context

* Enforce correct ordering in __pkvm_init_vcpu(), plugging a
  potential pin leak at the same time

* Move __pkvm_init_finalise() to a less dangerous spot, avoiding
  future problems

* Restore functional userspace irqchip support after a four year
  breakage (last functional kernel was 5.18...).

* Spelling fixes

Selftests:

* Rename types across all KVM selftests to more closely align with types used
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

* Fix Loongarch compilation.

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

David Woodhouse (1):
      KVM: arm64: vgic: Fix IIDR revision field extracted from wrong value

Fuad Tabba (5):
      KVM: arm64: Fix FEAT_Debugv8p9 to check DebugVer, not PMUVer
      KVM: arm64: Fix typo in feature check comments
      KVM: arm64: Fix FEAT_SPE_FnE to use PMSIDR_EL1.FnE, not PMSVer
      KVM: arm64: Fix kvm_vcpu_initialized() macro parameter
      KVM: arm64: Fix pin leak and publication ordering in __pkvm_init_vcpu()

Marc Zyngier (2):
      KVM: arm64: pkvm: Adopt MARKER() to define host hypercall ranges
      KVM: arm64: Wake-up from WFI when iqrchip is in userspace

Paolo Bonzini (2):
      Merge tag 'kvmarm-fixes-7.1-1' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD
      Merge tag 'kvm-x86-selftests_kernel_types-7.1' of https://github.com/kvm-x86/linux into HEAD

Quentin Perret (1):
      KVM: arm64: Fix initialisation order in __pkvm_init_finalise()

Sean Christopherson (10):
      KVM: selftests: Drop "vaddr_" from APIs that allocate memory for a given VM
      KVM: selftests: Rename vm_vaddr_unused_gap() => vm_unused_gva_gap()
      KVM: selftests: Rename vm_vaddr_populate_bitmap() => vm_populate_gva_bitmap()
      KVM: selftests: Rename translate_to_host_paddr() => translate_hva_to_hpa()
      KVM: selftests: Clarify that arm64's inject_uer() takes a host PA, not a guest PA
      KVM: selftests: Replace "vaddr" with "gva" throughout
      KVM: selftests: Replace "u64 gpa" with "gpa_t" throughout
      KVM: selftests: Replace "u64 nested_paddr" with "gpa_t l2_gpa"
      KVM: selftests: Replace "paddr" with "gpa" throughout
      KVM: selftests: Add check_steal_time_uapi() implementation for LoongArch

Sebastian Ene (1):
      KVM: arm64: Reject non compliant SMCCC function calls in pKVM

Vincent Donnefort (1):
      KVM: arm64: Re-allow hyp tracing HVCs for [nh]VHE

 arch/arm64/include/asm/kvm_asm.h                   |  28 +-
 arch/arm64/include/asm/kvm_host.h                  |   5 +-
 arch/arm64/kvm/arm.c                               |   4 +
 arch/arm64/kvm/config.c                            |  23 +-
 arch/arm64/kvm/hyp/nvhe/hyp-main.c                 |  30 +-
 arch/arm64/kvm/hyp/nvhe/pkvm.c                     |  38 ++-
 arch/arm64/kvm/hyp/nvhe/setup.c                    |   8 +-
 arch/arm64/kvm/vgic/vgic-mmio-v2.c                 |   2 +-
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                 |   2 +-
 .../selftests/kvm/access_tracking_perf_test.c      |  44 +--
 tools/testing/selftests/kvm/arch_timer.c           |   6 +-
 .../testing/selftests/kvm/arm64/aarch32_id_regs.c  |  14 +-
 tools/testing/selftests/kvm/arm64/arch_timer.c     |   8 +-
 .../selftests/kvm/arm64/arch_timer_edge_cases.c    | 161 +++++----
 .../testing/selftests/kvm/arm64/debug-exceptions.c |  72 ++--
 tools/testing/selftests/kvm/arm64/hypercalls.c     |  24 +-
 tools/testing/selftests/kvm/arm64/idreg-idst.c     |   4 +-
 tools/testing/selftests/kvm/arm64/no-vgic.c        |   8 +-
 .../testing/selftests/kvm/arm64/page_fault_test.c  |  82 ++---
 tools/testing/selftests/kvm/arm64/psci_test.c      |  26 +-
 tools/testing/selftests/kvm/arm64/sea_to_user.c    |  41 ++-
 tools/testing/selftests/kvm/arm64/set_id_regs.c    |  70 ++--
 tools/testing/selftests/kvm/arm64/smccc_filter.c   |  10 +-
 tools/testing/selftests/kvm/arm64/vgic_init.c      |  56 +--
 tools/testing/selftests/kvm/arm64/vgic_irq.c       | 137 ++++----
 .../testing/selftests/kvm/arm64/vgic_lpi_stress.c  |  20 +-
 tools/testing/selftests/kvm/arm64/vgic_v5.c        |  10 +-
 .../selftests/kvm/arm64/vpmu_counter_access.c      |  56 +--
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
 tools/testing/selftests/kvm/include/kvm_util.h     | 344 +++++++++----------
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
 .../selftests/kvm/include/x86/kvm_util_arch.h      |  36 +-
 tools/testing/selftests/kvm/include/x86/pmu.h      |   9 +-
 .../testing/selftests/kvm/include/x86/processor.h  | 292 ++++++++--------
 tools/testing/selftests/kvm/include/x86/sev.h      |  20 +-
 tools/testing/selftests/kvm/include/x86/smm.h      |   3 +-
 tools/testing/selftests/kvm/include/x86/svm_util.h |  12 +-
 tools/testing/selftests/kvm/include/x86/ucall.h    |   2 +-
 tools/testing/selftests/kvm/include/x86/vmx.h      |  70 ++--
 tools/testing/selftests/kvm/kvm_page_table_test.c  |  54 +--
 tools/testing/selftests/kvm/lib/arm64/gic.c        |   6 +-
 .../testing/selftests/kvm/lib/arm64/gic_private.h  |  26 +-
 tools/testing/selftests/kvm/lib/arm64/gic_v3.c     |  90 ++---
 tools/testing/selftests/kvm/lib/arm64/gic_v3_its.c |  11 +-
 tools/testing/selftests/kvm/lib/arm64/processor.c  | 163 +++++----
 tools/testing/selftests/kvm/lib/arm64/ucall.c      |  12 +-
 tools/testing/selftests/kvm/lib/arm64/vgic.c       |  40 +--
 tools/testing/selftests/kvm/lib/elf.c              |  17 +-
 tools/testing/selftests/kvm/lib/guest_modes.c      |   2 +-
 tools/testing/selftests/kvm/lib/guest_sprintf.c    |  18 +-
 tools/testing/selftests/kvm/lib/kvm_util.c         | 377 +++++++++------------
 .../selftests/kvm/lib/loongarch/processor.c        | 110 +++---
 tools/testing/selftests/kvm/lib/loongarch/ucall.c  |  12 +-
 tools/testing/selftests/kvm/lib/memstress.c        |  38 +--
 tools/testing/selftests/kvm/lib/riscv/processor.c  |  91 +++--
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
 tools/testing/selftests/kvm/lib/x86/processor.c    | 292 ++++++++--------
 tools/testing/selftests/kvm/lib/x86/sev.c          |  20 +-
 tools/testing/selftests/kvm/lib/x86/svm.c          |  16 +-
 tools/testing/selftests/kvm/lib/x86/ucall.c        |   4 +-
 tools/testing/selftests/kvm/lib/x86/vmx.c          |  44 +--
 tools/testing/selftests/kvm/loongarch/arch_timer.c |  28 +-
 tools/testing/selftests/kvm/loongarch/pmu_test.c   |  10 +-
 .../kvm/memslot_modification_stress_test.c         |  10 +-
 tools/testing/selftests/kvm/memslot_perf_test.c    | 164 ++++-----
 tools/testing/selftests/kvm/mmu_stress_test.c      |  28 +-
 .../testing/selftests/kvm/pre_fault_memory_test.c  |  12 +-
 tools/testing/selftests/kvm/riscv/arch_timer.c     |   8 +-
 tools/testing/selftests/kvm/riscv/ebreak_test.c    |   6 +-
 tools/testing/selftests/kvm/riscv/get-reg-list.c   |   4 +-
 tools/testing/selftests/kvm/riscv/sbi_pmu_test.c   |   8 +-
 tools/testing/selftests/kvm/s390/debug_test.c      |   8 +-
 tools/testing/selftests/kvm/s390/irq_routing.c     |   2 +-
 tools/testing/selftests/kvm/s390/memop.c           |  94 ++---
 tools/testing/selftests/kvm/s390/resets.c          |   6 +-
 .../selftests/kvm/s390/shared_zeropage_test.c      |   2 +-
 tools/testing/selftests/kvm/s390/tprot.c           |  24 +-
 tools/testing/selftests/kvm/s390/ucontrol_test.c   |   8 +-
 .../testing/selftests/kvm/set_memory_region_test.c |  40 +--
 tools/testing/selftests/kvm/steal_time.c           |  79 +++--
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
 tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c |  36 +-
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
 .../testing/selftests/kvm/x86/pmu_counters_test.c  | 109 +++---
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
 194 files changed, 2807 insertions(+), 2879 deletions(-)

