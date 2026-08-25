Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6533E47B
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 15:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787673167; cv=none; b=ZmVPnb7j0gIBtuPt5h+c++zRNNpjC7uiA2k6vaT/sLGa8bOLqwhASWX6AR61HNCA29J2YJnQMWNTvI44SKdo0rEDLeQfCO/nAoOmvCtjmh/znyZrDcXN6bQ8OYIH88diHoxHgntQaBR308DDtMDd4amVcpwnXMmdI3aYnL2n4dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787673167; c=relaxed/simple;
	bh=SsCD4Q4i4+1Pp8BnC4b9WzO2aTHFaurlaiZPv+rmTSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JoBxKVMgMjjYRCDFq3sR3oF+VtfQVRRFixbJOZpAwQ504ls5dPASfaNZjEyHtGE4B5miKEez7E8WfIWnT1ikUW954HYxcxzDcBLLpabFpyDuS+40K5lXAav4sL1k+2KNUL+ehvop7/YN/Y9dtA6065kr+nJM56AJpC1EiiioauQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GHvgarrl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GHvgarrl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787673162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g4NdSxJ3YIWlhRRSVq72UsGg3tf1Z8v37l6LEyKPQJI=;
	b=GHvgarrlGnMgu6Yz/htaV8Ho+Wky7gZfWcTHG4kdoAj2HAIiUwsikHM2AzZ4K9BIeYb/+E
	vrKjjg98I20Wn+GC9Q6PjENyKCFECMysrZZen2ompBR4UI2AP89gGFx4oMJMlHn6zVPBh8
	gUItR2ZgKU+es499d0FGkKpHERQKXxk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-iNTtdElHMuS2s9G8ZKHTFg-1; Tue,
 25 Aug 2026 11:52:39 -0400
X-MC-Unique: iNTtdElHMuS2s9G8ZKHTFg-1
X-Mimecast-MFC-AGG-ID: iNTtdElHMuS2s9G8ZKHTFg_1787673158
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE06B186A6EB;
	Tue, 25 Aug 2026 15:52:37 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4C9EE1800609;
	Tue, 25 Aug 2026 15:52:37 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [GIT PULL] KVM changes for Linux 7.3
Date: Tue, 25 Aug 2026 11:52:33 -0400
Message-ID: <20260825155236.46673-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Linus,

The following changes since commit db2ddb87143519e20a95aa36c60b36107b736a58:

  Linux 7.2-rc7 (2026-08-09 14:54:50 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to 76671054f9a1ff6abb976583cd8da37650acdc97:

  Merge tag 'kvmarm-7.3' of https://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD (2026-08-24 12:42:07 -0400)

There are quite a few conflicts with the arch pull requests, mostly due
to cleanups touching KVM from their side.  This is also why I sent
the pull request a bit later, to ensure that everything had reached
your tree.  So I get to do all the explaining, and give nicknames to
the conflicts.

arch/arm64/tools/cpucaps - the unlucky one:

* BBML2_NOABORT was renamed to BBML3 in the Arm pull request.  Of course,
  it was also out of alphabetical order and fell exactly where these
  commits add NV2P1/NV3.  Remove it as is already the case in your tree.

* More normally, "us" adding WORKAROUND_GICv3_BROKEN_SEIS where
  "they" added WORKAROUND_NVIDIA_OLYMPUS_1027

arch/riscv/kvm/vcpu_vector.c - the "falcon eye" conflict:

* easy but difficult to spot... the RISC-V pull request changed lowercase v
  to uppercase V:

-               if (riscv_isa_extension_available(isa, v))
+               if (riscv_isa_extension_available(isa, V))

  This one introduces riscv_v_flags_set(), so keep my version but with
  the uppercase V in the conditional.

arch/x86/kvm/{x86,msrs}.c - the huuuuge one:

* massive conflicting hunk due to moving code out of the file to regs.c
  and msrs.c.  Kill it from x86.c, and replace one occurrence of
  static_cpu_has with cpu_feature_enabled in msrs.c

include/uapi/linux/kvm.h - the ugly one:

* the easiest but also the ugliest, PPC KVM (which doesn't merge through
  me) added a new uapi and gave it id 250.  Arm's KVM_CAP_ARM_PMU_V3_STRICT
  thus needs to be bumped to 251.  PPC people should really give me their
  uAPI changes through a topic branch, even though it's a rare event.

The "git diff --cc" output is at the end of the message, it's tame
when you look at it but still this is a lot more conflicts than usual.

Thanks,

Paolo

----------------------------------------------------------------
Arm:

* Add support for 'slot' based PMU events, paired with new UAPI that
  compels the user to select a specific PMU implementation

* Lazy save/restore of vCPU state for pKVM, along with various fixes
  and cleanups to the management of vCPU state between the untrusted
  host and pKVM hypervisor

* Disable traps of EL1 registers for nested hypervisors when FEAT_NV2p1
  is present, guaranteeing that EL2-specific register bits are stateful
  in the EL1 counterpart

* Leverage FEAT_NV3 to avoid unnecessary ERET/TLBI traps when the scope
  of those instructions remains 'in host' (i.e. L1 kernel/userspace)

* Pile of fixes for the management of the VNCR pseudo-TLB, such as
  under-invalidations and races with concurrent TLBIs on other vCPUs

* Consolidate the non-protected and pKVM view of ICH_VTR_EL2 to a
  runtime-patched constant, allowing the same data to be shared with
  pKVM prior to dropping host privileges

* Considerable pile of LLM-assisted fixes around the shop but mostly in
  the VGIC, our in-kernel generator of bugs (and sometimes interrupts)

LoongArch:

* Advertise already-supported capabilities.

* Some bug fixes about timer and MMIO.

* Some hardening about interrupt injection.

* Replace kvm_err() with kvm_pr_unimpl().

* Add FPU/LSX/LASX test cases for selftests.

RISC-V:

* Svadu/Zicfiss/Zicfilp FWFT support for Guest

* Use try_cmpxchg for IMSIC MRIF RMW

* More arch-specific tracepoints in KVM RISC-V

* Eager page splitting when enabling dirty logging

* Optimize hfence request handling for SMP Guests

* Improve dirty log clearing by skipping zero bits in mask

* Guard HFENCE range loops against overflow

* CPU PM notifiers in KVM RISC-V for non-retentive idle states

* Fix kernel-mode vector context save/restore for Guest

s390:

* Fixes for vfio-ap

* Fixes for the gmap rework

* Fixes for vsie

* AI triggered fixes all over

* diag9c tracing

* code move preparation for the additional arm64 support

* enable CONTEXT_ANALYSIS

x86:

* Perform spring cleaning on x86.{c,h} and asm/kvm_host.h, by adding regs.c
  (the kvm_cache_regs.h => regs.h is already applied) and msrs.{c,h}, and moving
  relevant code out of x86.c.

* Split kvm_mmu in three parts, respectively to describe the format of page
  tables, walking the guest page tables and building the page tables.  Always
  use the same page table walker kvm->arch.gva_walk as the entry point to
  convert a guest's virtual address, where the previous code used two
  different kvm_mmu structs depending on whether the walk included nested
  EPT/NPT or not.  Make page fault vmexits reuse the permission checking
  machinery that is used for guest page faults.  This is both a cleanup
  and a baby step towards supporting XS/XU memory permissions.

* Document some of the "fun" gotchas with the APIC base when creating IRQCHIPs
  on x86.

* Remove a defunct masterclock update from kvm_xen_shared_info_init().  It
  could result in incorrect kvmclock due to triggering an unnecessary
  switch to/from masterclock mode.

* Skip Xen runstate time updates if time has effectively gone backwards, so
  that the guest doesn't report 100% steal time for a very, very long time.

* Drop KVM's runtime updates of the Xen PV timing CPUID leaf, as KVM was
  updating the wrong sub-leaf, and upstream KVM will soon provide all the
  information needed by userspace to populate the CPUID field itself.

* Fix a bug where KVM would walk a newly created rmap without holding the rmap
  lock (or mmu_lock) during aging.

* Fix a bug where aging TDP MMU SPTEs could clobber FROZEN SPTEs.

* Fix a variety of #DB priority bugs.

* Fix a class of races related to enabling Hyper-V emulation on a vCPU after
  the vCPU is visible to the rest of KVM.

* Use static calls for nested virtualization ops.

* Move more KVM-internal code out of x86's kvm_host.h.

* Enumerate support for a variety of Zhaoxin instructions that don't require
  explicit virtualization.

* Fix missing EFER validation bugs, including in the KVM_SET_SREGS* path.

* Harden kvm_vcpu_map() against double-mapping and thus leaking references.

* Misc fixes and cleanups, e.g. for largely benign syzkaller splats.

x86 (Intel):

* Zero a vCPU's entry in VMX's Posted Interrupt Descriptor table used for IPI
  virtualization when the vCPU is freed, to fix a use-after-free where hardware
  will write to a freed vCPU's PID.

* Service local TLB flushes on a failed nested VM-Enter to fix a bug where KVM
  could miss a TLB on a future, successful VM-Enter with the same L2 VPID.

* Cap the maximum value shoved into the VMX Preemption Timer to workaround an
  erratum that affects all existing Intel CPUs that support CPUID 0x15.

* Fix VPID virtualization bugs where KVM would fail to flush hardware TLBs.

* Harden the TDX "populate" ioctls against bad input, and to prepare
  for supporting in-place private<=>shared conversion.

x86 (AMD):

* Forcefully invalidate SNP VMSA pages if their backing guest_memfd page is
  zapped/invalidated, e.g. due to a PUNCH_HOLE in response to a Page-State
  Change request.

* Remove a dying VM from the GA Log notifier list before the VM is actually
  destroyed, to fix a potential use-after-free.

* While FOLL_WRITE was needed in the past to trigger CoW unsharing, nowadays
  FOLL_LONGTERM does that already even without FOLL_WRITE, and in fact,
  get_user_pages() actually disallows FOLL_WRITE together with FOLL_LONGTERM.
  So don't pass FOLL_WRITE when registering encrypted memory regions, i.e. when
  pinning SEV/SEV-ES guest memory, to fix a regression with file-backed memory
  introduced by KVM's (correct) usage of long-term pins.

  (This was reviewed by mm maintainers; for more information, see commit
  ee1a586dd1fa2f245b3b753a3e44d9263a49240b).

* Allocate full pages for SEV/SEV-ES {DE,EN}CRYPT ops on SNP-enabled hosts to
  fix a data corruption issue due to the PSP driver assigning to-be-written
  pages to firmware (as required by the SNP specs).

* Unconditionally intercept ICBEP so that KVM generates the correct guest RIP
  when handling an ICEBP-induced TASK_SWITCH #VMEXIT.

* Harden the SNP "populate" ioctls against bad input, and to prepare
  for supporting in-place private<=>shared conversion.

Generic:

* Remove kvm_debugfs_dir if kvm_init() fails after creating KVM's debugfs.

* Add a per-VM bitmap to track which vCPU IDs have been "claimed" but for
  which the vCPU isn't yet online, and use the bitmap to reject duplicate IDs
  before calling into arch code.  This allows arch code to consume vcpu_id
  without having to worry about cross-vCPU clobbering (at least s390 and x86
  have had related bugs).

* Rework the so called "prepare" and "invalidate" guest_memfd hooks to prepare
  for in-place private<=>shared conversion, and clean up a few warts along the
  way.

Selftests:

* Automatically allocate a full page for L2 guest stacks on x86 instead of
  requiring test-specific L1 guest code to carve out a portion of the L1
  stack for L2 usage, and to ensure the L2 stack also adheres to the x86-64
  calling convention ABI.

* Add a selftest to verify {Guest,Host}-Only behavior in x86's mediated PMU.

* Clean up nested SVM's handling of GPRs on L2<=>L1 transitions, reuse the
  functionality for nested VMX, and drop the ucall hack that was fudging
  around the lack of GPR switching on nVMX.

* Add a stress test to verify KVM doesn't clobber/drop #PF state, e.g. CR2,
  across save/restore, including when L2 is active.

* Add a test to verify KVM_CREATE_VM accepts exactly what is reported by
  KVM_CAP_VM_TYPES.

* Misc selftests fixes and cleanups

* Fix several issues with seeding the pRNG, and rework the pRNG APIs to that
  the pRNG can be sanely used in host code, not just guest code.

* Add an IRQ test to validate virtual IRQ deliverty for IRQs wired up via
  KVM_IRQFD + KVM_SET_GSI_ROUTING, with optional support for triggering IRQs
  via writes to an assigned VFIO device.

* Add syscall wrappers to assert success on a variety of pthreads and CPU
  affinity APIs.

* Set vCPU pthread affinity as early as possible to reduce contention issues
  that were surfaced by PREEMPT_LAZY, which result in runtimes of over a
  minute on large hosts, versus the expected ~5 seconds.

* Rework the PMU counters test to run each testcase using a single VM with
  many vCPUs for each sub-testcase, instead of using a unique VM for each
  sub-testcase.  This cuts the runtime by ~20x.

Miscellaneous:

* MAINTAINERS updates for vfio-ap, guest_memfd, kvm-x86.  Mostly representing
  the status quo more accurately, but also... welcome David Hildenbrand
  as guest_memfd reviewer!

----------------------------------------------------------------
Ackerley Tng (1):
      KVM: guest_memfd: Only "prepare" folios for private pages

Andy Chiu (3):
      riscv: vector: refactor riscv_v_start_kernel_context
      riscv: vector: allow non-preemptible kernel-mode vector with IRQs off
      RISC-V: KVM: fix vcpu vector context handling for kernel-mode vector

Anthony Krowiak (9):
      s390/vfio-ap: fix stale pqap_hook pointer on error in vfio_ap_mdev_set_kvm()
      s390/vfio-ap: Fix stale do_remove flag across iterations in vfio_ap_mdev_cfg_remove
      s390/vfio-ap: Fix dereference matrix_mdev->kvm without checking for NULL
      s390/vfio-ap: Fix missing lock required to access list of ap_matrix_mdev objects
      s390/vfio-ap: Fix required lock not held during update of ap_matrix_mdev object
      s390/vfio-ap: Fix control domain removal in vfio_ap_mdev_cfg_remove
      s390/vfio-ap: fix potential use of uninitialized apm_filtered bitmap
      s390/vfio-ap: Fix hot-unplug skipped when last AP adapter or domain removed
      s390/vfio-ap: Fix NULL deref in status_show() during queue probe

Bibo Mao (8):
      LoongArch: KVM: Set vcpu->cpu before IN_GUEST_MODE is set
      LoongArch: KVM: Set default MAILBOX access size with 8
      LoongArch: KVM: Return directly when IPI address is not aligned
      LoongArch: KVM: Fix uninitialized stack variable issue with dmsintc
      LoongArch: KVM: Use internal API to deliver interrupt in kernel mode
      LoongArch: KVM: Replace kvm_err() with kvm_pr_unimpl()
      KVM: LoongArch: selftests: Enable LSX/LASX by auto detection
      KVM: LoongArch: selftests: Add FPU/LSX/LASX test cases

Binbin Wu (1):
      KVM: x86: Fix emulated CPUID features being applied to wrong sub-leaf

Bingyu.Xian (2):
      RISC-V: KVM: Use unsigned int for vma_pageshift
      RISC-V: KVM: Widen G-stage fault address to gpa_t

Bradley Morgan (2):
      KVM: arm64: Skip cache maintenance for non-cacheable pKVM mappings
      KVM: arm64: Top up stage-2 memcache for dirty logging faults

Carlos López (3):
      KVM: x86: Treat any non-zero return from set_dr() as a faulting condition
      KVM: x86: Fix array_index_nospec() protection in kvm_vcpu_ioctl_x86_set_mce()
      KVM: x86: hyper-v: Clamp stimer deadline to avoid livelock

Christian Borntraeger (15):
      KVM: s390: move some facilities from FACILITIES_KVM_CPUMODEL to FACILITIES_KVM
      KVM: s390: Remove user triggerable WARN_ON
      KVM: s390: Zero initialize data structures for inject_pfault_token
      KVM: s390: Zero initialize irq in reinject_machine_check
      KVM: s390: Fix memory leak in guest debug handling
      KVM: s390: Fix old_data leak in guest debug error path
      KVM: s390: Take srcu when importing watchpoint data
      KVM: s390: Free guest debug data on vcpu destroy
      KVM: s390: Fix length check __import_wp_info()
      KVM: s390: Fix memory corruption by not reinjecting CK machine checks
      KVM: s390: keyop: use mmu_lock to read gmap->asce
      KVM: s390: vsie: zero stale crypto bits
      KVM: s390: pv: Fix rc/rrc offset for PVM_DUMP
      KVM: s390: Restore sigset on error path
      Merge remote-tracking branch 'kvms390/master' into 'kvms390/next'

Christoph Schlameuss (6):
      KVM: s390: Remove double 64bscao feature check
      KVM: s390: vsie: Remove duplicate assertion
      KVM: s390: vsie: Convert shift to phys_to_pfn()
      KVM: s390: vsie: Assert mcck_info offset in vsie_page
      KVM: s390: vsie: Assert crycb alignment in vsie_page
      KVM: s390: vsie: Create constant SCB_ALIGNMENT_SHIFT

Ciunas Bennett (2):
      KVM: s390: Refactor __diag_time_slice_end_directed for single exit point
      KVM: s390: Add tracepoint for DIAG 9c directed yield operations

Claudio Imbrenda (7):
      KVM: s390: Properly handle NULL pointer in dat_cond_set_storage_key()
      KVM: s390: Use srcu in kvm_arch_vcpu_unlocked_ioctl()
      KVM: s390: Fix get_all_floating_irqs()
      KVM: s390: Fix pgste_get_trylock_multiple()
      KVM: s390: Fix IRQ injection with SIGP Stop and Store Status
      KVM: s390: Fix kvm_s390_clear_pv_state()
      KVM: s390: Fix potential tiny kernel stack leak

Congkai Tan (3):
      KVM: arm64: Expose PMMIR_EL1.SLOTS under strict PMUv3 UAPI
      KVM: arm64: Advertise STALL_SLOT* in PMCEID1 under strict PMUv3 UAPI
      KVM: arm64: Add KVM_ARM_VCPU_PMU_V3_STRICT vCPU feature

David Matlack (11):
      KVM: selftests: Build and link selftests/vfio/lib into KVM selftests
      KVM: selftests: Add macros to read/write+sync to/from guest memory
      KVM: selftests: Add an irqfd send+receive (and later IRQ bypass) test
      KVM: selftests: Add helper to get host IRQ from device MSI-X for IRQ bypass test
      KVM: selftests: Add VFIO device support to eventfd IRQ test
      KVM: selftests: Verify interrupts are received when IRQ affinity changes in IRQ test
      KVM: selftests: Add option to set empty routing between IRQs in eventfd IRQ test
      KVM: selftests: Make number of IRQs configurable in IRQ test
      KVM: selftests: Verify vCPU migration during IRQ delivery in IRQ test
      KVM: selftests: Make number of vCPUs configurable in IRQ test
      KVM: selftests: Add xAPIC support in eventfd IRQ test

David Woodhouse (4):
      KVM: SVM: Always intercept ICEBP to workaround AMD ICEBP+TASK_SWITCH flaws
      KVM: x86/xen: Do not corrupt KVM clock in kvm_xen_shared_info_init()
      KVM: x86/xen: Prevent runstate times from becoming negative
      KVM: x86: Remove runtime Xen TSC frequency CPUID update

Dmytro Maluka (2):
      KVM: Check for duplicate vcpu_id as early as possible
      KVM: VMX: Fix stale PID-pointer table entry left after vCPU free

Ewan Hai-oc (5):
      KVM: x86: Expose Zhaoxin SM2 CPUID feature
      KVM: x86: Expose Zhaoxin CCS (SM3 + SM4) CPUID feature
      KVM: x86: Expose Zhaoxin RNG2 CPUID feature
      KVM: x86: Expose Zhaoxin PHE2 CPUID feature
      KVM: x86: Expose Zhaoxin RSA CPUID feature

Fuad Tabba (21):
      KVM: arm64: Drop the unused EL2-side is_created write
      KVM: arm64: Remove unreachable early checks in pkvm_init_host_vm()
      KVM: arm64: Drop redundant READ_ONCE() in pkvm_hyp_vm_is_created()
      KVM: arm64: Sync SCTLR_EL1 when injecting an exception into a pVM
      KVM: arm64: Flush external_mdscr_el1 to the pKVM hyp vCPU
      KVM: arm64: selftests: Add a userspace watchpoint test
      KVM: arm64: Extract MPIDR computation into a shared header
      KVM: arm64: Make vcpu_{read,write}_sys_reg available to HYP code
      KVM: arm64: Factor out reusable vCPU reset helpers
      KVM: arm64: Move PSCI helper functions to a shared header
      KVM: arm64: Implement lazy vCPU state sync for non-protected guests
      KVM: arm64: Top up the memcache for pKVM permission faults
      KVM: arm64: Skip pKVM stage-2 flush when FWB is enabled
      KVM: arm64: Don't WARN on pKVM stage-2 map failures
      KVM: arm64: Don't advertise eager page splitting under pKVM
      KVM: arm64: selftests: Add stage-2 block transition test
      KVM: arm64: vgic-its: Don't dereference a NULL collection on ITT save
      KVM: arm64: vgic: Don't leak the SPI array when init is retried
      KVM: arm64: vgic-its: Don't save collections the table cannot hold
      KVM: arm64: vgic-its: Point saved ITEs at the next valid entry
      KVM: arm64: vgic: Reset in_kernel on private IRQ allocation failure

Guidong Han (1):
      RISC-V: KVM: Fix PMU event info array size overflow

Hao Zhang (2):
      KVM: VMX: Use cached vcpu_vmx pointer in MSR and segment helpers
      KVM: selftests: Extend the invalid nVMX guest state test to cover RSM

Heiko Carstens (4):
      MAINTAINERS: Update s390 specific vfio sections
      s390/vfio_ccw: Add __must_hold() attribute to vfio_ccw_sch_quiesce()
      s390/cio: Enable CONTEXT_ANALYSIS
      s390/virtio: Enable CONTEXT_ANALYSIS

Hemanth Selam (1):
      KVM: selftests: Add a test for KVM_CREATE_VM VM type enforcement

Inochi Amaoto (11):
      RISC-V: KVM: Add support for Svadu FWFT features
      KVM: riscv: selftests: add Svadu FWFT extension to get-reg-list test
      RISC-V: KVM: Allow Zicfiss/Zicfilp extensions for Guest/VM
      RISC-V: KVM: Add ssp context save/restore
      RISC-V: KVM: Handle software-check exits for VCPU
      RISC-V: KVM: Add support for control-flow integrity FWFT features
      KVM: riscv: selftests: add Zicfiss/Zicfilp extension to get-reg-list test
      RISC-V: KVM: Add SBI extension validate callback
      RISC-V: KVM: Add SBI FWFT validation support
      RISC-V: KVM: Reset the SBI extension when disable it
      RISC-V: KVM: Mark the reset callback of FWFT extension always dirties CSR

Jim Mattson (2):
      KVM: selftests: Add svm_pmu_host_guest_test for Host-Only/Guest-Only bits
      KVM: VMX: Cap VMX preemption timer to work around Intel erratum

Joerg Roedel (1):
      KVM: SEV: Explicitly disallow NULL user address for SNP_LAUNCH_UPDATE

Josh Hilke (6):
      KVM: selftests: Rename guest_rng to kvm_rng
      KVM: selftests: Add helper to generate random u64 in range [min,max]
      KVM: selftests: Add a helper to set proc IRQ affinity for IRQ test
      KVM: selftests: Add kvm_gettid() wrapper and convert users
      KVM: selftests: Add kvm_sched_getaffinity() wrapper and convert users
      KVM: selftests: Add a utility to pin a task to a random CPU, given a CPU set

Kai Huang (1):
      KVM: x86: Use KVM_X86_OP() for the .pi_update_irte() hook

Kajetan Puchalski (1):
      KVM: arm64: vgic: Fix detection of MI on no pending LR

Karl Mehltretter (2):
      KVM: arm64: Preserve GPRs for AArch32 CP64 reads generating an UNDEF
      KVM: arm64: GICv2: Don't WARN on out-of-range GICV_DIR INTID

Like Xu (1):
      KVM: x86/pmu: Clean up vPMU comments and stray blank lines

Marc Zyngier (48):
      KVM: arm64: vgic-v3: Make vtr_to_* helpers use architectural field symbols
      KVM: arm64: Move GICv3 broken SEIS implementation detection to a CPU errrata
      KVM: arm64: Add a helper providing an inlined literal value for ICH_VTR_EL2
      KVM: arm64: Convert most ICH_VTR_EL2 accesses to inlined literal value
      KVM: arm64: vgic-v3: Simplify initial GICv3 configuration sampling
      KVM: arm64: vgic-v3: Kill kvm_vgic_global_state.ich_vtr_el2
      KVM: arm64: Add host and hypervisor vCPU lookup primitives
      KVM: arm64: Minimise EL2's exposure of host VGIC state during world switch
      KVM: arm64: Add primitives to flush/sync the VGIC state at EL2
      arm64: sysreg: Emit RESx/UNKN values for Mapping/Fields definitions
      arm64: Update ID_AA64MMFR4_EL1 description to 2026-03 JSON release
      KVM: arm64: Merge guest's HCRX_EL2 using NV_HCRX_GUEST_EXCLUDE
      KVM: arm64: Drop __HCRX_EL2_* masks
      KVM: arm64: Plumb HCRX_EL2.SRMASKEn in HCRX_EL2 sanitisation
      KVM: arm64: Classify CPTR_EL2 as a SR_LOC_SPECIAL register
      KVM: arm64: Don't evaluate HCR_EL2.NV nor HFGITR_EL2.ERET on ERET fast path
      arm64: Add ARM64_HAS_NV2P1 capability
      KVM: arm64: Relax CPTR_EL2 handling when FEAT_NV2p1 is present
      KVM: arm64: Relax CNTHCTL_EL2 handling when FEAT_NV2p1 is present
      KVM: arm64: Expose FEAT_NV2p1 to NV guests
      arm64: Add FEAT_NV2p1 detection
      arm64: sysreg: Add NVHCR_EL2 description as a mirror of HCR_EL2
      arm64: sysreg: Add HCRX_EL2 bits related to FEAT_NV3
      arm64: Add ARM64_HAS_NV3 capability
      KVM: arm64: Split NV-specific exit fixups from the non-NV handling
      KVM: arm64: Add NV3 control bits to HCRX_EL2 sanitisation
      KVM: arm64: Add kvm_has_nv{2,3}() predicates
      KVM: arm64: Make HCR_EL2 a non-VNCR register
      KVM: arm64: Add sanitisation for NVHCR_EL2
      KVM: arm64: Add NVHCR_EL2 handling to the sysreg array
      KVM: arm64: Add routing for NVHCR_EL2 trap
      KVM: arm64: Add NVHCR_EL2 context switching
      KVM: arm64: Engage NV3 ERET trap elision
      KVM: arm64: Engage NV3 TLBI trap elision
      KVM: arm64: Add FEAT_NV3 detection
      KVM: arm64: Expose FEAT_NV3 to guests
      KVM: arm64: selftest: Add NVHCR_EL2 to get-reg-list
      arm64: Add override for ID_AA64MMFR4_EL1.NV_frac
      KVM: arm64: Remove VM-wide VNCR mapping counter
      KVM: arm64: Handle negative S1 walk levels in VNCR TLB size evaluation
      KVM: arm64: Consider SCTLR_EL2.M when mapping the L1 VNCR page
      KVM: arm64: Correctly handle end of VA space TLBI invalidation
      KVM: arm64: Handle VNCR TLB invalidation race with vcpu_put() VNCR unmapping
      KVM: arm64: Sign-extend VA for range-based TLBI invalidation
      KVM: arm64: Make VNCR invalidation participate in MMU invalidation retry
      KVM: arm64: Add VNCR TLB tracking again
      KVM: arm64: Make timer_get_offset() work in all contexts
      KVM: arm64: Correctly cap TLBI Range to the architural limit

Mostafa Saleh (4):
      KVM: arm64: Avoid naming collision in tracing
      KVM: arm64: Optimize protected mode with FWB and DIC
      KVM: arm64: Fix timer offsets for non-protected VMs
      KVM: arm64: Fix hvhe and broken CNTVOFF_EL2

Oliver Upton (7):
      KVM: arm64: Ignore writes to PMCR_EL0.N when using strict UAPI
      Merge branch 'kvm-arm64/pmu-7.3' into next
      Merge branch 'kvm-arm64/pkvm-7.3' into next
      Merge branch 'kvm-arm64/feat-nv3' into next
      Merge branch 'kvm-arm64/vncr-fixes' into next
      Merge branch 'kvm-arm64/vtr-patch' into next
      Merge branch 'kvm-arm64/misc-7.3' into next

Pankaj Gupta (1):
      KVM: SEV: Drop FOLL_WRITE for encrypted region registration

Paolo Bonzini (37):
      KVM: move TSS constants from kvm_host.h to tss.h
      Merge branch 'kvm-spring-clean' into HEAD
      Merge tag 'kvm-x86-selftests_l2_stacks-7.3' of https://github.com/kvm-x86/linux into HEAD
      KVM: x86/hyperv: remove unnecessary mmu_is_nested() check
      KVM: x86/mmu: introduce struct kvm_pagewalk
      KVM: x86/mmu: move get_guest_pgd to struct kvm_pagewalk
      KVM: x86/mmu: move gva_to_gpa to struct kvm_pagewalk
      KVM: x86/mmu: move get_pdptr to struct kvm_pagewalk
      KVM: x86/mmu: move inject_page_fault to struct kvm_pagewalk
      KVM: x86/mmu: move CPU-related fields to struct kvm_pagewalk
      KVM: x86/mmu: change CPU-role accessor fields to take struct kvm_pagewalk
      KVM: x86/mmu: move remaining permission fields to struct kvm_pagewalk
      KVM: x86/mmu: pass struct kvm_pagewalk to kvm_mmu_invalidate_addr
      KVM: x86/mmu: change walk_mmu to struct kvm_pagewalk
      KVM: x86/mmu: change nested_mmu.w to ngva_walk
      KVM: x86/mmu: pull struct kvm_pagewalk out of struct kvm_mmu
      KVM: x86/mmu: unify root_gva_walk and ngva_walk
      KVM: x86/mmu: cleanup functions that initialize shadow MMU
      KVM: x86/mmu: pull page format to a new struct
      KVM: x86/mmu: merge struct rsvd_bits_validate into struct kvm_page_format
      KVM: x86/mmu: parameterize update_permission_bitmask()
      KVM: x86/mmu: use kvm_page_format to test SPTEs
      Merge branch 'kvm-chainsaw' into HEAD
      Merge tag 'kvm-riscv-7.3-1' of https://github.com/kvm-riscv/linux into HEAD
      Merge tag 'kvm-s390-next-7.3-1' of git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD
      Merge tag 'kvm-x86-maintainers-7.3' of https://github.com/kvm-x86/linux into HEAD
      Merge tag 'loongarch-kvm-7.3' of git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson into HEAD
      Merge tag 'kvm-x86-generic-7.3' of https://github.com/kvm-x86/linux into HEAD
      Merge tag 'kvm-x86-selftests-7.3' of https://github.com/kvm-x86/linux into HEAD
      Merge tag 'kvm-x86-selftests2-7.3' of https://github.com/kvm-x86/linux into HEAD
      Merge tag 'kvm-x86-coco-7.3' of https://github.com/kvm-x86/linux into HEAD
      Merge tag 'kvm-x86-clocks-7.3' of https://github.com/kvm-x86/linux into HEAD
      Merge tag 'kvm-x86-mmu-7.3' of https://github.com/kvm-x86/linux into HEAD
      Merge tag 'kvm-x86-vmx-7.3' of https://github.com/kvm-x86/linux into HEAD
      Merge tag 'kvm-x86-svm-7.3' of https://github.com/kvm-x86/linux into HEAD
      Merge tag 'kvm-x86-misc-7.3' of https://github.com/kvm-x86/linux into HEAD
      Merge tag 'kvmarm-7.3' of https://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD

Pengpeng Hou (4):
      RISC-V: KVM: Allow memslots ending at the GPA limit
      RISC-V: KVM: Reject overlapping AIA IMSIC address fields
      RISC-V: KVM: Guard HFENCE range loops against overflow
      RISC-V: KVM: Avoid one-word masks for SBI v0.1 all-harts

Phil Rosenthal (1):
      KVM: x86/mmu: Consume the locked rmap value in the lockless rmap walk

Qiang Ma (1):
      KVM: SVM: Remove redundant ret = 0 in svm_set_nested_state

Qihang (1):
      KVM: arm64: vgic-v3: take an LPI reference in vgic_v3_save_pending_tables

Sascha Bischoff (4):
      KVM: arm64: vgic: Free gic_kvm_info on initialization failure
      KVM: arm64: vgic: Prevent speculative SPI array underflow
      KVM: arm64: vgic: Reject out-of-range GICv5 PPI IDs
      KVM: arm64: Validate GICv5 timer PPIs before claiming ownership

Sean Christopherson (128):
      KVM: selftests: Add a helper to query enable_mediated_pmu module param
      KVM: x86: Extract REGS and SREGS runtime sync code to helpers
      KVM: x86: Move get_segment_base() to regs.h, as kvm_get_segment_base()
      KVM: x86: Rename __{g,s}et_sregs2() => kvm_vcpu_ioctl_x86_{g,s}et_sregs2()
      KVM: x86: Move the bulk of register specific code from x86.c to regs.c
      KVM: x86: Move local APIC specific helpers out of asm/kvm_host.h
      KVM: x86: Move kvm_caps and kvm_host_values to asm/kvm_host.h
      KVM: x86: Swap the include order between x86.h and mmu.h
      KVM: x86: Move tdp_enabled from kvm_host.h to mmu.h
      KVM: x86: Move eager_page_split to mmu.{c,h}
      KVM: x86/hyperv: Eliminate an unnecessary include of x86.h in hyperv.h
      KVM: x86: Move kvm_{load,put}_guest_fpu() to fpu.h
      KVM: x86: Extract get/set MSR (list) ioctl logic to helpers
      KVM: x86: Expose several TSC helpers via x86.h for use by MSR code
      KVM: x86: Move the bulk of MSR specific code from x86.c to msrs.{c,h}
      KVM: x86: Move register helper declarations from kvm_host.h => regs.h
      KVM: x86: Move kvm_{g,s}et_segment() to inline helpers in regs.h
      KVM: x86: Move MSR helper declarations from kvm_host.h => msrs.h
      KVM: x86: Move "struct kvm_x86_msr_filter" definition to msrs.c
      KVM: x86/pmu: Move "struct kvm_x86_pmu_event_filter" definition to pmu.c
      KVM: x86: Move MMU helper declarations from kvm_host.h => mmu.h
      KVM: x86: Move LLDT assembly wrappers into VMX
      KVM: x86: Move misc "VALID MASK" defines from kvm_host.h => x86.c
      KVM: x86: Move __kvm_irq_line_state() from kvm_host.h => ioapic.h
      KVM: x86: Move IRQ-related helper declarations from kvm_host.h => irq.h
      KVM: x86: Move kvm_pv_send_ipi() declaration from kvm_host.h => lapic.h
      KVM: x86: Don't treat interrupts as allowed just because a nested run is pending
      KVM: x86: Rework kvm_arch_interrupt_allowed() into kvm_is_interrupt_allowed()
      KVM: x86/mmu: Move kvm_arch_async_page_ready() below kvm_tdp_page_fault()
      KVM: x86/mmu: Move kvm_mmu_do_page_fault() from mmu_internal.h => mmu.c
      KVM: x86: Move a pile of stuff from kvm_host.h => x86.h
      KVM: selftests: Initialize the default/global pRNG during kvm_selftest_init()
      KVM: selftests: Seed libc's RNG before using it to generate a seed for KVM's pRNG
      KVM: selftests: Verify non-postable IRQ remapping in IRQ test
      KVM: nVMX: Decouple INVVPID operand checks from flushing of vpid02
      KVM: TDX: Return EINVAL, not EOPNOTSUPP, for NULL INIT_MEM_REGION source
      KVM: x86: Prioritize DR7.GD #DB over #GP due to illegal DR6/7 value
      KVM: x86: Manually check DR4/5 write values to fix SVM intercept priority
      KVM: x86: Prioritize #UD on MOV DR over #GP due to non-zero CPL
      KVM: VMX: Prioritize DR7.GD=1 #DB over CPL>0 #GP on Intel
      KVM: x86: Use kvm_dr{6,7}_valid() to check DR{4,5,6,7} write values in emulator
      KVM: x86: WARN if MOV DR emulation hits a "too late" #GP
      KVM: x86: Read CR4.DE in emulator if and only if accessing DR4 or DR5
      KVM: x86/hyperv: Get target FIFO in hv_tlb_flush_enqueue(), not caller
      KVM: x86/hyperv: Check for NULL vCPU Hyper-V object in kvm_hv_get_tlb_flush_fifo()
      KVM: x86/hyperv: Ensure vCPU's Hyper-V object is initialized on cross-vCPU accesses
      KVM: x86/xen: Always route non-singleshot-timer vCPU hypercalls to userspace
      KVM: x86/xen: Consolidate checks on Xen vCPU ID for singleshot timer hypercalls
      KVM: x86/xen: Punt singleshot timer hcalls to userspace if Xen vCPU ID isn't set
      KVM: Initialize a vCPU's index to '-1' while it's being created
      KVM: Move nVMX's lockdep logic for vcpu->mutex to a common helper
      KVM: x86: Treat a vCPU as unreachable if its index is invalid
      KVM: x86/hyperv: Assert vCPU's mutex is held in to_hv_vcpu()
      KVM: x86/hyperv: Use {READ,WRITE}_ONCE for cross-task synic->active accesses
      KVM: x86: Move the "APIC attention" macros from kvm_host.h => lapic.c
      KVM: x86/mmu: Annotate tdp_enabled as being read-mostly
      KVM: x86: Pluralize the macro guard name for msrs.h
      KVM: x86: Move CR and DR macro definitions from kvm_host.h => regs.h
      KVM: x86: Move KVM_GUESTDBG_VALID_MASK from kvm_host.h => x86.c
      KVM: x86: Add static asserts to document connection b/w TSS structs and macros
      KVM: x86: Move KVM's arbitrary task switch reason enums to x86.h
      KVM: x86: Move "struct kvm_apic_map" definition from kvm_host.h => lapic.h
      KVM: x86: Move "struct kvm_vcpu_hv" and all children from kvm_host.h => hyperv.h
      KVM: SVM: Make kvm_x86_ops.vcpu_precreate() hook fully AVIC specific
      KVM: SVM: Do all per-VM AVIC initialization during vCPU precreation phase
      KVM: SVM: Remove VM from the GA Log notifier list before VM destruction
      KVM: SEV: Track the GPA of the guest-controlled VMSA used for SNP guests
      KVM: SEV: Extract loading of guest-provided VMSA to a separate helper
      KVM: SEV: Mark vCPU RUNNABLE after AP_CREATE, even if VMSA is unusable
      KVM: SEV: Wire up kvm_x86_ops.gmem_xxx() if and only if CONFIG_KVM_AMD_SEV=y
      KVM: x86: Serialize writes to disabled_quirks using kvm->lock
      KVM: x86: Ensure runtime reads of disabled_quirks are resolved once
      KVM: x86/mmu: Fold kvm_mmu_zap_memslot() into kvm_arch_flush_shadow_memslot()
      KVM: x86/mmu: Split kvm_mmu_zap_all_fast() into "front" and "back" halves
      KVM: x86/mmu: Use split "zap all fast" helpers when invalidating memslot
      KVM: SEV: Forcefully invalidate SNP VMSA if its backing gmem page is zapped
      KVM: SEV: Mark vCPU has having guest-provided VMSA even if its invalid
      KVM: x86: Guard .gmem_prepare() declarations with HAVE_KVM_GMEM_PREPARE=y
      KVM: selftests: Drop superfluous use of pthread_attr_setaffinity_np()
      KVM: selftests: Randomize pCPU in steal time test
      KVM: x86: Reject nested CAP enablement if nested virtualization is disabled
      KVM: x86: Add static calls for nested virtualization ops
      KVM: x86: Move nested_ops out of kvm_x86_ops, to global kvm_nested_ops
      KVM: SEV: Allocate full pages for {DE,EN}CRYPT ops on SNP-enabled hosts
      KVM: guest_memfd: Pass the number of pages instead of the end pfn into .invalidate()
      KVM: guest_memfd: Rename invalidate() arch hook to reclaim() and isolate it
      KVM: x86: Rename kvm_x86_ops' gmem_invalidate() to gmem_make_shared()
      KVM: guest_memfd: Drop the redundant printk on arch gmem_prepare() failure
      KVM: guest_memfd: Add helpers to query SHARED vs. PRIVATE for a given page
      KVM: guest_memfd: Rename prepare() hook and Kconfig to make_private() / CONVERT
      KVM: guest_memfd: Explicitly pass number of pages to make_private() hook
      KVM: guest_memfd: Make private exactly what can be mapped on page fault
      KVM: x86: Don't WARN if IRQ disappears because it was cleared from the PIC
      KVM: x86: Don't WARN if IRQ disappears when Xen emulation is enabled.
      KVM: nVMX: Ensure KVM_REQ_GET_NESTED_STATE_PAGES is cleared on VM-Exit
      KVM: nSVM: Add CLASS()es for automagically handling local kvm_vcpu_map() usage
      KVM: nSVM: Use CLASS(kvm_vcpu_map_local) for SMM VMCB mappings
      KVM: nVMX: Use CLASS(kvm_vcpu_map_local_readonly) for MSR bitmap merging
      KVM: PPC: Use CLASS(kvm_vcpu_map_local) to patch dcbz
      KVM: Harden kvm_vcpu_map() against double-mapping and thus leaking references
      KVM: x86/mmu: Use CMPXCHG when clearing Accessed bit in TDP MMU
      KVM: x86/mmu: Use CMPXCHG when clearing Accessed bit in the shadow MMU
      KVM: selftests: Only link to VFIO library on x86
      KVM: VMX: Bury all of the VMX preemption timer code under CONFIG_X86_64=y
      KVM: selftests: Add a KVM syscall wrapper for sched_setaffinity()
      KVM: selftests: Set threads CPU affinity before doing work in hardware disable test
      KVM: selftests: Pre-set threads affinity in hardware disable test when possible
      KVM: selftests: Return the target CPU from pin_task_to_random_cpu()
      KVM: selftests: Extract picking of random CPU from cpu_set_t to separate API
      KVM: selftests: Affine threads to random CPUs in hardware disable test
      KVM: selftests: Drop unreachable, dead code from hardware disable test
      KVM: selftests: Add KVM syscall wrapper for pthread_create()
      KVM: selftests: Add KVM syscall wrappers for pthread_{cancel,join}()
      KVM: selftests: Add helper APIs to cancel+join pthreads
      KVM: selftests: Clean up global constants in hardware disable test
      KVM: selftests: Add KVM syscall wrappers for pthread_{g,s}etaffinity_np()
      KVM: x86: Extract VMX's unhandleable emulation check to common x86
      KVM: nVMX: Synthesize SHUTDOWN on RSM if L2 requires emulation
      KVM: x86: Rework kvm_x86_ops.vcpu_pre_run() into .vcpu_needs_initialization()
      KVM: selftests: Use port 0x80 in invalid nVMX guest state test
      KVM: selftests: Refactor invalid nVMX state test to prepare for RSM testcase
      MAINTAINERS: Add kvm-x86 tree to KVM x86 entries
      KVM: guest_memfd: Move gmem function declarations to dedicated guest_memfd.h
      MAINTAINERS: Add an entry for KVM's guest_memfd
      MAINTAINERS: Add David H. as a KVM guest_memfd reviewer
      MAINTAINERS: Add myself (Sean) as a reviewer in the main KVM entry
      KVM: selftests: Test one random GP counter in PMU arch events testcase
      KVM: selftests: Create one VM with many vCPUs for each major PMU counters test

Shivank Sharma (1):
      KVM: selftests: Fix typos in x86 and riscv tests

Steffen Eiden (10):
      KVM: s390: Extract gmap tracing to a separate header
      KVM: s390: Prepare include guards for a new location
      KVM: s390: Rename kvm-s390.{c,h} to s390.{c,h}
      KVM: s390: Move kvm_host definitions to kvm_host_s390
      KVM: s390: Move s390 kvm code into a subdirectory
      KVM: s390: Move PGM code definitions to asm/kvm_host.h
      KVM: s390: Prepare gmap for a second KVM implementation
      KVM: s390: gmap: Make storage keys optional
      KVM: s390: gmap: Make CMMA optional
      KVM: s390: gmap: Make prefix handling optional

Tao Cui (3):
      LoongArch: KVM: Advertise already-supported capabilities
      LoongArch: KVM: Reload one-shot TVAL on migration destination
      LoongArch: KVM: Prevent division by zero in periodic timer restore

Tim Wiederhake (3):
      KVM: x86: Replace delivery mode TODO with WARN_ON_ONCE
      KVM: x86: Document that KVM_CREATE_IRQCHIP must precede vCPU creation
      KVM: x86: Document APIC base address constraint for in-kernel irqchip

Vincent Donnefort (1):
      KVM: arm64: Drop %pB on nVHE panic when stage-2 is active

Wang Yan (1):
      KVM: selftests: Fix a spelling error in an xapic_ipi_test comment

Wang Yechao (8):
      RISC-V: KVM: Add the split page cache for ioctl context
      RISC-V: KVM: Split huge pages when dirty logging is enabled
      RISC-V: KVM: Remove redundant TLB flush operations
      RISC-V: KVM: Split huge pages during KVM_CLEAR_DIRTY_LOG
      RISC-V: KVM: Add the eager_page_split module parameter
      RISC-V: KVM: Separate req and fallback_req masks in make_xfence_request
      RISC-V: KVM: Introduce make_xfence_request_nodata for FENCE.I requests
      RISC-V: KVM: Improve dirty log clearing by skipping zero bits in mask

Will Deacon (1):
      KVM: arm64: Avoid mismatched accesses to 'struct kvm_nvhe_init_params'

Yicong Yang (1):
      RISC-V: KVM: Use try_cmpxchg for IMSIC MRIF RMW

Yong-Xuan Wang (2):
      KVM: RISC-V: Clear former VCPU cache on virtualization disable
      KVM: RISC-V: Add CPU PM notifier for non-retention idle states

Yosry Ahmed (26):
      KVM: selftests: Refactor allocating guest stack into a helper
      KVM: selftests: Allocate a dedicated guest page for x86 L2 guest stack
      KVM: selftests: Drop L1-provided stacks for L2 guests on x86
      KVM: nVMX: Always flush vpid02 on first use
      KVM: nVM: Ensure INVVPID is emulated on the correct physical CPU
      KVM: x86: Move enabling EFER.SVME and EFER.LMSLE to generic EFER setup
      KVM: x86: Disallow EFER.LME and EFER.LMA if long mode is not supported
      KVM: x86: Always initialize EFER reserved bits on vendor initialization
      KVM: x86: Reverse the polarity of efer_reserved_bits
      KVM: x86: Move supported EFER bits to kvm_caps
      KVM: x86: Check EFER validity on KVM_SET_SREGS*
      KVM: nVMX: Service local TLB flushes on failed nested VM-Enter
      KVM: selftests: Extend set_sregs test to cover EFER
      KVM: selftests: Use __stringify() instead of custom XSTR() macros
      KVM: selftests: Fix RAX and RFLAGS VMCB offsets when running L2
      KVM: selftests: Rework GPR registers switching for SVM (and fix offsets)
      KVM: selftests: Handle rflags save/restore for SVM in guest_regs
      KVM: selftests: Reuse GPR switching logic for nVMX
      KVM: selftests: Drop HORRIFIC_L2_UCALL_CLOBBER_HACK
      KVM: selftests: Add a blank line before logging assertion failures
      KVM: selftests: Expose PTE masks to guests as part of an MMU
      KVM: selftests: Do not intercept #PF by default in nVMX tests
      KVM: selftests: Add basic stress test for save+restore and #PF handling
      KVM: selftests: Trigger save+restore randomly in the #PF stress test
      KVM: selftests: Support running stress save+restore and #PF test in L2
      KVM: selftests: Trigger L2->L1 exits stress save+restore and #PF test

Yuhang.Chen (1):
      RISC-V: KVM: Add more arch-specific tracepoints

Yuhang.chen (1):
      RISC-V: KVM: Account VM-scoped allocations to the VM cgroup

Zeng Chi (1):
      LoongArch: KVM: Fix PC double advance in kernel MMIO read fast path

Zongmin Zhou (1):
      KVM: riscv: Fix infinite loop in NACL hfence entry allocation

leixiang (2):
      KVM: Remove kvm_debugfs_dir on kvm_init() error paths
      KVM: Remove kvm_debugfs_dir on kvm_init() error paths

 Documentation/admin-guide/kernel-parameters.txt    |    7 +-
 Documentation/virt/kvm/api.rst                     |   26 +-
 Documentation/virt/kvm/devices/vcpu.rst            |   11 +-
 MAINTAINERS                                        |   22 +-
 arch/arm64/include/asm/cpufeature.h                |    1 +
 arch/arm64/include/asm/kvm_arm.h                   |   27 +-
 arch/arm64/include/asm/kvm_asm.h                   |    4 +-
 arch/arm64/include/asm/kvm_emulate.h               |  107 +-
 arch/arm64/include/asm/kvm_host.h                  |   14 +-
 arch/arm64/include/asm/kvm_nested.h                |   20 +
 arch/arm64/include/asm/kvm_pkvm.h                  |    8 +-
 arch/arm64/include/asm/vncr_mapping.h              |    2 +-
 arch/arm64/include/uapi/asm/kvm.h                  |    1 +
 arch/arm64/kernel/asm-offsets.c                    |    1 -
 arch/arm64/kernel/cpu_errata.c                     |   17 +-
 arch/arm64/kernel/cpufeature.c                     |   18 +-
 arch/arm64/kernel/image-vars.h                     |    2 +
 arch/arm64/kernel/pi/idreg-override.c              |   10 +
 arch/arm64/kvm/arch_timer.c                        |   15 +-
 arch/arm64/kvm/arm.c                               |   26 +-
 arch/arm64/kvm/at.c                                |    2 -
 arch/arm64/kvm/config.c                            |   27 +-
 arch/arm64/kvm/emulate-nested.c                    |   18 +-
 arch/arm64/kvm/handle_exit.c                       |   40 +-
 arch/arm64/kvm/hyp/exception.c                     |   34 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h            |   42 +-
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h         |   11 +
 arch/arm64/kvm/hyp/include/nvhe/clock.h            |    8 +-
 arch/arm64/kvm/hyp/nvhe/clock.c                    |    4 +-
 arch/arm64/kvm/hyp/nvhe/hyp-init.S                 |   11 +-
 arch/arm64/kvm/hyp/nvhe/hyp-main.c                 |  271 +-
 arch/arm64/kvm/hyp/nvhe/mem_protect.c              |    7 +
 arch/arm64/kvm/hyp/nvhe/pkvm.c                     |   15 +-
 arch/arm64/kvm/hyp/nvhe/sys_regs.c                 |    5 +-
 arch/arm64/kvm/hyp/nvhe/timer-sr.c                 |   10 +-
 arch/arm64/kvm/hyp/nvhe/trace.c                    |    4 +-
 arch/arm64/kvm/hyp/vgic-v3-sr.c                    |   43 +-
 arch/arm64/kvm/hyp/vhe/switch.c                    |   62 +-
 arch/arm64/kvm/hyp/vhe/sysreg-sr.c                 |   21 +-
 arch/arm64/kvm/mmu.c                               |    9 +-
 arch/arm64/kvm/nested.c                            |  190 +-
 arch/arm64/kvm/pkvm.c                              |   34 +-
 arch/arm64/kvm/pmu-emul.c                          |   54 +-
 arch/arm64/kvm/psci.c                              |   30 +-
 arch/arm64/kvm/reset.c                             |   60 +-
 arch/arm64/kvm/sys_regs.c                          |  152 +-
 arch/arm64/kvm/sys_regs.h                          |   19 +
 arch/arm64/kvm/vgic-sys-reg-v3.c                   |    8 +-
 arch/arm64/kvm/vgic/vgic-init.c                    |    8 +-
 arch/arm64/kvm/vgic/vgic-its.c                     |   26 +-
 arch/arm64/kvm/vgic/vgic-v2.c                      |    3 +-
 arch/arm64/kvm/vgic/vgic-v3-nested.c               |    2 +-
 arch/arm64/kvm/vgic/vgic-v3.c                      |  105 +-
 arch/arm64/kvm/vgic/vgic-v5.c                      |    5 +-
 arch/arm64/kvm/vgic/vgic.c                         |    7 +-
 arch/arm64/kvm/vgic/vgic.h                         |   19 +-
 arch/arm64/tools/cpucaps                           |    3 +
 arch/arm64/tools/gen-sysreg.awk                    |    8 +-
 arch/arm64/tools/sysreg                            |   44 +-
 arch/loongarch/kvm/exit.c                          |   19 +-
 arch/loongarch/kvm/intc/dmsintc.c                  |   18 +-
 arch/loongarch/kvm/intc/eiointc.c                  |   32 +-
 arch/loongarch/kvm/intc/ipi.c                      |   77 +-
 arch/loongarch/kvm/intc/pch_pic.c                  |   12 +-
 arch/loongarch/kvm/timer.c                         |   14 +
 arch/loongarch/kvm/vcpu.c                          |    7 +-
 arch/loongarch/kvm/vm.c                            |    4 +
 arch/powerpc/kvm/book3s_pr.c                       |   11 +-
 arch/riscv/include/asm/csr.h                       |    1 +
 arch/riscv/include/asm/kvm_aia.h                   |    3 +
 arch/riscv/include/asm/kvm_gstage.h                |    9 +-
 arch/riscv/include/asm/kvm_host.h                  |   10 +
 arch/riscv/include/asm/kvm_vcpu_insn.h             |    4 +-
 arch/riscv/include/asm/kvm_vcpu_sbi.h              |    4 +
 arch/riscv/include/asm/kvm_vcpu_vector.h           |   24 +
 arch/riscv/include/asm/processor.h                 |    8 +
 arch/riscv/include/asm/simd.h                      |   16 +-
 arch/riscv/include/asm/vector.h                    |    5 +
 arch/riscv/include/uapi/asm/kvm.h                  |   13 +
 arch/riscv/kernel/kernel_mode_vector.c             |   88 +-
 arch/riscv/kvm/aia.c                               |   42 +
 arch/riscv/kvm/aia_aplic.c                         |    3 +-
 arch/riscv/kvm/aia_device.c                        |    6 +
 arch/riscv/kvm/aia_imsic.c                         |   18 +-
 arch/riscv/kvm/gstage.c                            |   82 +-
 arch/riscv/kvm/isa.c                               |    2 +
 arch/riscv/kvm/main.c                              |  114 +-
 arch/riscv/kvm/mmu.c                               |  108 +-
 arch/riscv/kvm/nacl.c                              |    2 +-
 arch/riscv/kvm/tlb.c                               |  117 +-
 arch/riscv/kvm/trace.h                             |   81 +-
 arch/riscv/kvm/vcpu.c                              |   34 +
 arch/riscv/kvm/vcpu_config.c                       |    2 +
 arch/riscv/kvm/vcpu_exit.c                         |   20 +-
 arch/riscv/kvm/vcpu_insn.c                         |   17 +-
 arch/riscv/kvm/vcpu_onereg.c                       |   68 +-
 arch/riscv/kvm/vcpu_pmu.c                          |   16 +-
 arch/riscv/kvm/vcpu_sbi.c                          |   30 +
 arch/riscv/kvm/vcpu_sbi_fwft.c                     |  207 +-
 arch/riscv/kvm/vcpu_sbi_v01.c                      |   52 +-
 arch/riscv/kvm/vcpu_vector.c                       |   26 +-
 arch/s390/include/asm/kvm_host.h                   |  723 +---
 arch/s390/include/asm/kvm_host_s390.h              |  729 ++++
 arch/s390/include/asm/kvm_host_s390_types.h        |  349 ++
 arch/s390/include/asm/kvm_host_types.h             |  347 +-
 arch/s390/include/asm/nmi.h                        |    3 +
 arch/s390/kernel/nmi.c                             |    5 +-
 arch/s390/kvm/Makefile                             |   11 +-
 arch/s390/kvm/gmap/Makefile                        |    5 +
 arch/s390/kvm/{ => gmap}/dat.c                     |   17 +-
 arch/s390/kvm/{ => gmap}/dat.h                     |   21 +-
 arch/s390/kvm/{ => gmap}/faultin.c                 |    3 +-
 arch/s390/kvm/{ => gmap}/faultin.h                 |    6 +-
 arch/s390/kvm/{ => gmap}/gmap.c                    |   19 +-
 arch/s390/kvm/{ => gmap}/gmap.h                    |   25 +-
 arch/s390/kvm/gmap/kvm_mmu.c                       |  133 +
 arch/s390/kvm/gmap/kvm_mmu.h                       |   18 +
 arch/s390/kvm/gmap/trace_gmap.h                    |   47 +
 arch/s390/kvm/s390/Makefile                        |   14 +
 arch/s390/kvm/{ => s390}/diag.c                    |   21 +-
 arch/s390/kvm/{ => s390}/gaccess.c                 |    2 +-
 arch/s390/kvm/{ => s390}/gaccess.h                 |    2 +-
 arch/s390/kvm/{ => s390}/guestdbg.c                |   11 +-
 arch/s390/kvm/{ => s390}/intercept.c               |    2 +-
 arch/s390/kvm/{ => s390}/interrupt.c               |  109 +-
 arch/s390/kvm/{ => s390}/pci.c                     |    2 +-
 arch/s390/kvm/{ => s390}/pci.h                     |    0
 arch/s390/kvm/{ => s390}/priv.c                    |    2 +-
 arch/s390/kvm/{ => s390}/pv.c                      |    6 +-
 arch/s390/kvm/{kvm-s390.c => s390/s390.c}          |  159 +-
 arch/s390/kvm/{kvm-s390.h => s390/s390.h}          |   10 +-
 arch/s390/kvm/{ => s390}/sigp.c                    |    2 +-
 arch/s390/kvm/{ => s390}/trace-s390.h              |    0
 arch/s390/kvm/{ => s390}/trace.h                   |   40 +-
 arch/s390/kvm/{ => s390}/vsie.c                    |   22 +-
 arch/s390/tools/gen_facilities.c                   |   14 +-
 arch/x86/include/asm/cpufeatures.h                 |   10 +
 arch/x86/include/asm/kvm-x86-nested-ops.h          |   36 +
 arch/x86/include/asm/kvm-x86-ops.h                 |   17 +-
 arch/x86/include/asm/kvm_host.h                    |  880 +----
 arch/x86/kvm/Kconfig                               |    3 +-
 arch/x86/kvm/Makefile                              |    4 +-
 arch/x86/kvm/cpuid.c                               |   39 +-
 arch/x86/kvm/emulate.c                             |   49 +-
 arch/x86/kvm/fpu.h                                 |   26 +
 arch/x86/kvm/hyperv.c                              |  102 +-
 arch/x86/kvm/hyperv.h                              |  120 +-
 arch/x86/kvm/ioapic.c                              |    1 +
 arch/x86/kvm/ioapic.h                              |   12 +
 arch/x86/kvm/irq.c                                 |    7 +
 arch/x86/kvm/irq.h                                 |   26 +
 arch/x86/kvm/lapic.c                               |   13 +-
 arch/x86/kvm/lapic.h                               |   41 +
 arch/x86/kvm/mmu.h                                 |  126 +-
 arch/x86/kvm/mmu/mmu.c                             |  675 ++--
 arch/x86/kvm/mmu/mmu_internal.h                    |   66 -
 arch/x86/kvm/mmu/paging_tmpl.h                     |   90 +-
 arch/x86/kvm/mmu/spte.c                            |    4 +-
 arch/x86/kvm/mmu/spte.h                            |   69 +-
 arch/x86/kvm/mmu/tdp_iter.h                        |    7 +
 arch/x86/kvm/mmu/tdp_mmu.c                         |   23 +-
 arch/x86/kvm/msrs.c                                | 2728 ++++++++++++++
 arch/x86/kvm/msrs.h                                |  155 +
 arch/x86/kvm/mtrr.c                                |    2 +-
 arch/x86/kvm/pmu.c                                 |   24 +-
 arch/x86/kvm/pmu.h                                 |    4 +-
 arch/x86/kvm/regs.c                                |  875 +++++
 arch/x86/kvm/regs.h                                |   98 +
 arch/x86/kvm/smm.c                                 |    4 +
 arch/x86/kvm/svm/avic.c                            |   96 +-
 arch/x86/kvm/svm/nested.c                          |   35 +-
 arch/x86/kvm/svm/sev.c                             |  242 +-
 arch/x86/kvm/svm/svm.c                             |  116 +-
 arch/x86/kvm/svm/svm.h                             |   24 +-
 arch/x86/kvm/tss.h                                 |   14 +
 arch/x86/kvm/vmx/main.c                            |   24 +-
 arch/x86/kvm/vmx/nested.c                          |  105 +-
 arch/x86/kvm/vmx/nested.h                          |    6 +-
 arch/x86/kvm/vmx/pmu_intel.c                       |    1 -
 arch/x86/kvm/vmx/tdx.c                             |   16 +-
 arch/x86/kvm/vmx/vmx.c                             |  219 +-
 arch/x86/kvm/vmx/x86_ops.h                         |    4 +-
 arch/x86/kvm/x86.c                                 | 3895 +-------------------
 arch/x86/kvm/x86.h                                 |  472 ++-
 arch/x86/kvm/xen.c                                 |   73 +-
 arch/x86/kvm/xen.h                                 |   13 -
 drivers/s390/crypto/vfio_ap_ops.c                  |  203 +-
 include/kvm/arm_arch_timer.h                       |   34 +-
 include/kvm/arm_pmu.h                              |    4 +
 include/kvm/arm_psci.h                             |   27 +
 include/kvm/arm_vgic.h                             |    4 +-
 include/linux/kvm_host.h                           |   38 +-
 include/uapi/linux/kvm.h                           |    1 +
 tools/testing/selftests/kvm/Makefile.kvm           |   19 +-
 tools/testing/selftests/kvm/arch_timer.c           |   20 +-
 .../selftests/kvm/arm64/arch_timer_edge_cases.c    |    2 +-
 .../testing/selftests/kvm/arm64/debug-exceptions.c |   41 +
 tools/testing/selftests/kvm/arm64/get-reg-list.c   |    3 +
 .../selftests/kvm/arm64/stage2_block_transitions.c |  226 ++
 tools/testing/selftests/kvm/arm64/vgic_irq.c       |   14 +-
 .../testing/selftests/kvm/arm64/vgic_lpi_stress.c  |    8 +-
 tools/testing/selftests/kvm/demand_paging_test.c   |    2 +-
 tools/testing/selftests/kvm/dirty_log_perf_test.c  |    4 +-
 tools/testing/selftests/kvm/dirty_log_test.c       |   15 +-
 .../testing/selftests/kvm/hardware_disable_test.c  |  109 +-
 tools/testing/selftests/kvm/include/kvm_syscalls.h |   55 +
 tools/testing/selftests/kvm/include/kvm_util.h     |   21 +
 .../selftests/kvm/include/loongarch/processor.h    |   18 +
 tools/testing/selftests/kvm/include/proc_util.h    |   11 +
 tools/testing/selftests/kvm/include/test_util.h    |   26 +-
 tools/testing/selftests/kvm/include/x86/evmcs.h    |   46 +-
 .../selftests/kvm/include/x86/kvm_util_arch.h      |    4 +-
 tools/testing/selftests/kvm/include/x86/pmu.h      |    6 +
 .../testing/selftests/kvm/include/x86/processor.h  |   64 +-
 tools/testing/selftests/kvm/include/x86/svm_util.h |    5 +-
 tools/testing/selftests/kvm/include/x86/vmx.h      |   73 +-
 tools/testing/selftests/kvm/irq_test.c             |  362 ++
 tools/testing/selftests/kvm/irqfd_test.c           |    4 +-
 tools/testing/selftests/kvm/kvm_page_table_test.c  |    6 +-
 tools/testing/selftests/kvm/lib/assert.c           |   10 +-
 tools/testing/selftests/kvm/lib/kvm_util.c         |   52 +-
 .../selftests/kvm/lib/loongarch/processor.c        |   11 +-
 tools/testing/selftests/kvm/lib/memstress.c        |   12 +-
 tools/testing/selftests/kvm/lib/proc_util.c        |   54 +
 tools/testing/selftests/kvm/lib/test_util.c        |   41 +-
 tools/testing/selftests/kvm/lib/userfaultfd_util.c |    7 +-
 tools/testing/selftests/kvm/lib/x86/memstress.c    |   19 +-
 tools/testing/selftests/kvm/lib/x86/processor.c    |   59 +-
 tools/testing/selftests/kvm/lib/x86/svm.c          |   68 +-
 tools/testing/selftests/kvm/lib/x86/ucall.c        |   32 +-
 tools/testing/selftests/kvm/lib/x86/vmx.c          |    8 +-
 tools/testing/selftests/kvm/loongarch/fpu_test.c   |  137 +
 tools/testing/selftests/kvm/memslot_perf_test.c    |    4 +-
 tools/testing/selftests/kvm/mmu_stress_test.c      |   19 +-
 .../testing/selftests/kvm/pre_fault_memory_test.c  |    4 +-
 tools/testing/selftests/kvm/riscv/get-reg-list.c   |   90 +
 tools/testing/selftests/kvm/riscv/sbi_pmu_test.c   |    4 +-
 tools/testing/selftests/kvm/rseq_test.c            |   16 +-
 tools/testing/selftests/kvm/s390/memop.c           |    4 +-
 .../testing/selftests/kvm/set_memory_region_test.c |    6 +-
 tools/testing/selftests/kvm/steal_time.c           |   39 +-
 tools/testing/selftests/kvm/vm_types_test.c        |   48 +
 tools/testing/selftests/kvm/x86/aperfmperf_test.c  |    9 +-
 .../selftests/kvm/x86/evmcs_smm_controls_test.c    |   10 +-
 .../testing/selftests/kvm/x86/fix_hypercall_test.c |    1 -
 tools/testing/selftests/kvm/x86/hyperv_clock.c     |    4 +-
 tools/testing/selftests/kvm/x86/hyperv_evmcs.c     |    8 +-
 tools/testing/selftests/kvm/x86/hyperv_ipi.c       |   32 +-
 tools/testing/selftests/kvm/x86/hyperv_svm_test.c  |    6 +-
 tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c |   30 +-
 tools/testing/selftests/kvm/x86/kvm_buslock_test.c |    9 +-
 .../selftests/kvm/x86/nested_close_kvm_test.c      |   12 +-
 .../selftests/kvm/x86/nested_dirty_log_test.c      |    8 +-
 .../selftests/kvm/x86/nested_emulation_test.c      |    4 +-
 .../selftests/kvm/x86/nested_exceptions_test.c     |    9 +-
 .../selftests/kvm/x86/nested_invalid_cr3_test.c    |   10 +-
 .../selftests/kvm/x86/nested_tdp_fault_test.c      |    9 +-
 .../selftests/kvm/x86/nested_tsc_adjust_test.c     |   10 +-
 .../selftests/kvm/x86/nested_tsc_scaling_test.c    |   10 +-
 .../selftests/kvm/x86/nested_vmsave_vmload_test.c  |    6 +-
 .../testing/selftests/kvm/x86/pmu_counters_test.c  |  231 +-
 .../selftests/kvm/x86/pmu_event_filter_test.c      |    4 +-
 .../kvm/x86/private_mem_conversions_test.c         |    4 +-
 .../selftests/kvm/x86/private_mem_kvm_exits_test.c |    7 +-
 .../selftests/kvm/x86/recalc_apic_map_test.c       |    5 +-
 .../kvm/x86/save_restore_pf_stress_test.c          |  288 ++
 tools/testing/selftests/kvm/x86/set_sregs_test.c   |   81 +-
 tools/testing/selftests/kvm/x86/sev_dbg_test.c     |    2 +-
 tools/testing/selftests/kvm/x86/sev_init2_tests.c  |    4 -
 .../testing/selftests/kvm/x86/sev_migrate_tests.c  |    4 +-
 tools/testing/selftests/kvm/x86/smm_test.c         |   13 +-
 tools/testing/selftests/kvm/x86/state_test.c       |   11 +-
 tools/testing/selftests/kvm/x86/svm_int_ctl_test.c |    5 +-
 .../selftests/kvm/x86/svm_lbr_nested_state.c       |    6 +-
 .../selftests/kvm/x86/svm_nested_clear_efer_svme.c |    7 +-
 .../selftests/kvm/x86/svm_nested_pat_test.c        |    8 +-
 .../selftests/kvm/x86/svm_nested_shutdown_test.c   |    5 +-
 .../kvm/x86/svm_nested_soft_inject_test.c          |    6 +-
 .../selftests/kvm/x86/svm_nested_vmcb12_gpa.c      |   13 +-
 .../selftests/kvm/x86/svm_pmu_host_guest_test.c    |  215 ++
 tools/testing/selftests/kvm/x86/svm_vmcall_test.c  |    5 +-
 tools/testing/selftests/kvm/x86/sync_regs_test.c   |    5 +-
 .../selftests/kvm/x86/triple_fault_event_test.c    |    9 +-
 tools/testing/selftests/kvm/x86/tsc_scaling_sync.c |    4 +-
 .../selftests/kvm/x86/vmx_apic_access_test.c       |    5 +-
 .../selftests/kvm/x86/vmx_apicv_updates_test.c     |    4 +-
 .../kvm/x86/vmx_invalid_nested_guest_state.c       |  130 +-
 .../selftests/kvm/x86/vmx_nested_la57_state_test.c |    5 +-
 .../selftests/kvm/x86/vmx_preemption_timer_test.c  |    5 +-
 tools/testing/selftests/kvm/x86/xapic_ipi_test.c   |   33 +-
 tools/testing/selftests/kvm/x86/xen_shinfo_test.c  |   10 +-
 virt/kvm/Kconfig                                   |    6 +-
 virt/kvm/guest_memfd.c                             |   73 +-
 virt/kvm/guest_memfd.h                             |   34 +
 virt/kvm/kvm_main.c                                |   22 +-
 virt/kvm/kvm_mm.h                                  |   27 -
 296 files changed, 12847 insertions(+), 8611 deletions(-)
 create mode 100644 arch/s390/include/asm/kvm_host_s390.h
 create mode 100644 arch/s390/include/asm/kvm_host_s390_types.h
 create mode 100644 arch/s390/kvm/gmap/Makefile
 rename arch/s390/kvm/{ => gmap}/dat.c (99%)
 rename arch/s390/kvm/{ => gmap}/dat.h (98%)
 rename arch/s390/kvm/{ => gmap}/faultin.c (98%)
 rename arch/s390/kvm/{ => gmap}/faultin.h (96%)
 rename arch/s390/kvm/{ => gmap}/gmap.c (99%)
 rename arch/s390/kvm/{ => gmap}/gmap.h (96%)
 create mode 100644 arch/s390/kvm/gmap/kvm_mmu.c
 create mode 100644 arch/s390/kvm/gmap/kvm_mmu.h
 create mode 100644 arch/s390/kvm/gmap/trace_gmap.h
 create mode 100644 arch/s390/kvm/s390/Makefile
 rename arch/s390/kvm/{ => s390}/diag.c (96%)
 rename arch/s390/kvm/{ => s390}/gaccess.c (99%)
 rename arch/s390/kvm/{ => s390}/gaccess.h (99%)
 rename arch/s390/kvm/{ => s390}/guestdbg.c (98%)
 rename arch/s390/kvm/{ => s390}/intercept.c (99%)
 rename arch/s390/kvm/{ => s390}/interrupt.c (98%)
 rename arch/s390/kvm/{ => s390}/pci.c (99%)
 rename arch/s390/kvm/{ => s390}/pci.h (100%)
 rename arch/s390/kvm/{ => s390}/priv.c (99%)
 rename arch/s390/kvm/{ => s390}/pv.c (99%)
 rename arch/s390/kvm/{kvm-s390.c => s390/s390.c} (97%)
 rename arch/s390/kvm/{kvm-s390.h => s390/s390.h} (98%)
 rename arch/s390/kvm/{ => s390}/sigp.c (99%)
 rename arch/s390/kvm/{ => s390}/trace-s390.h (100%)
 rename arch/s390/kvm/{ => s390}/trace.h (95%)
 rename arch/s390/kvm/{ => s390}/vsie.c (98%)
 create mode 100644 arch/x86/include/asm/kvm-x86-nested-ops.h
 create mode 100644 arch/x86/kvm/msrs.c
 create mode 100644 arch/x86/kvm/msrs.h
 create mode 100644 arch/x86/kvm/regs.c
 create mode 100644 tools/testing/selftests/kvm/arm64/stage2_block_transitions.c
 create mode 100644 tools/testing/selftests/kvm/include/proc_util.h
 create mode 100644 tools/testing/selftests/kvm/irq_test.c
 create mode 100644 tools/testing/selftests/kvm/lib/proc_util.c
 create mode 100644 tools/testing/selftests/kvm/loongarch/fpu_test.c
 create mode 100644 tools/testing/selftests/kvm/vm_types_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/svm_pmu_host_guest_test.c
 create mode 100644 virt/kvm/guest_memfd.h


diff --cc arch/arm64/tools/cpucaps
index 0ee42b0cc8d3,f88d7898489f..000000000000
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@@ -52,6 -51,9 +52,8 @@@ HAS_LS64_
  HAS_LSUI
  HAS_MOPS
  HAS_NESTED_VIRT
+ HAS_NV2P1
+ HAS_NV3
 -HAS_BBML2_NOABORT
  HAS_PAN
  HAS_PMUV3
  HAS_S1PIE
@@@ -121,7 -123,7 +123,8 @@@ WORKAROUND_CAVIUM_TX2_219_TV
  WORKAROUND_CLEAN_CACHE
  WORKAROUND_DEVICE_LOAD_ACQUIRE
  WORKAROUND_DISABLE_CNP
+ WORKAROUND_GICv3_BROKEN_SEIS
 +WORKAROUND_NVIDIA_OLYMPUS_1027
  WORKAROUND_PMUV3_IMPDEF_TRAPS
  WORKAROUND_QCOM_FALKOR_E1003
  WORKAROUND_QCOM_ORYON_CNTVOFF
diff --cc arch/riscv/kvm/vcpu_vector.c
index 3c3183b39ae2,bf5c94d8786b..000000000000
--- a/arch/riscv/kvm/vcpu_vector.c
+++ b/arch/riscv/kvm/vcpu_vector.c
@@@ -56,9 -56,8 +56,8 @@@ void kvm_riscv_vcpu_guest_vector_restor
  					 unsigned long *isa)
  {
  	if ((cntx->sstatus & SR_VS) != SR_VS_OFF) {
 -		if (riscv_isa_extension_available(isa, v))
 +		if (riscv_isa_extension_available(isa, V))
- 			__kvm_riscv_vector_restore(cntx);
- 		kvm_riscv_vcpu_vector_clean(cntx);
+ 			riscv_v_flags_set(riscv_v_flags() | RISCV_V_VCPU_NEED_RESTORE);
  	}
  }
  
diff --cc arch/x86/kvm/x86.c
index 69469bbdc84a,4b3681796c75..000000000000
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
diff --cc include/uapi/linux/kvm.h
index 70e36e6a0ad4,9fc8dfdfd65f..000000000000
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@@ -997,7 -997,7 +997,8 @@@ struct kvm_enable_cap 
  #define KVM_CAP_S390_KEYOP 247
  #define KVM_CAP_S390_VSIE_ESAMODE 248
  #define KVM_CAP_S390_HPAGE_2G 249
 -#define KVM_CAP_ARM_PMU_V3_STRICT 250
 +#define KVM_CAP_PPC_COMPAT_CAPS 250
++#define KVM_CAP_ARM_PMU_V3_STRICT 251
  
  struct kvm_irq_routing_irqchip {
  	__u32 irqchip;
diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index 66fa7140d65d..82e781c45dca 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -640,7 +640,7 @@ static int set_efer(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	if ((efer ^ old_efer) & KVM_MMU_EFER_ROLE_BITS)
 		kvm_mmu_reset_context(vcpu);
 
-	if (!static_cpu_has(X86_FEATURE_XSAVES) &&
+	if (!cpu_feature_enabled(X86_FEATURE_XSAVES) &&
 	    (efer & EFER_SVME))
 		kvm_hv_xsaves_xsavec_maybe_warn(vcpu);
 

