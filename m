Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF9B1CFBA
	for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 16:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776357936; cv=none; b=Lr35R47fuORsLFQne/SA7EGkTex4Y/io9E0anhyCbbj0EeHGvreIz5DLAQI8+95OQ9AIi/a6O4ULkV9Vvx3995yvMjigL45sy2sIesNNwwaXrM7lXFwHsgtPvFq2oma+7TBhFpFb/P8HjkL5upXThcZWLiZC4jEE7LBrA5rJU1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776357936; c=relaxed/simple;
	bh=ohIPOc37SyjZBAAf8O06w5Yu4DtGgBjFq0FbP7bN4AY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BjBF0RvLw6861rShRVmrVfrd22LxZKKMhMeClrddtT0/qWAU+J9A+E3ddOqnjswDZ1hyhXitOrH/3kbjdNut7Gqkud+N5YIFvXkmnBX9hMVfbXyRsxjQDHpR+8Owwkhise0Kb617wgPUIea3sNE3LUFw84gAdPgjxY6mzdXbM2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ui/HRCGe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ui/HRCGe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776357932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KRUDrG/nHWwQ+lDnLrVICoCLz2ixORDMS8e3QIDY9lk=;
	b=Ui/HRCGen3nsviQGg4xmk/vTmOWgz9G4Z5jER4fop90HuuCVxrSh2LMP39eS3dXEry7tdY
	eIPGJfWCHBY9pi2csuMIrZyg9xItKTmBSQfZbUdMadgxaGf6bsZBbIzVqHdYrtYRzKwOQx
	2FydtQhj2JouGMheErEhrr63Xde1/tY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-599-9CoVyDtqM7O418anTNJL5A-1; Thu,
 16 Apr 2026 12:45:28 -0400
X-MC-Unique: 9CoVyDtqM7O418anTNJL5A-1
X-Mimecast-MFC-AGG-ID: 9CoVyDtqM7O418anTNJL5A_1776357928
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E091918005AB;
	Thu, 16 Apr 2026 16:45:27 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3F82B195608E;
	Thu, 16 Apr 2026 16:45:27 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [GIT PULL] KVM changes for Linux 7.1
Date: Thu, 16 Apr 2026 12:45:25 -0400
Message-ID: <20260416164526.171467-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Linus,

The following changes since commit 028ef9c96e96197026887c0f092424679298aae8:

  Linux 7.0 (2026-04-12 13:48:06 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to 6b802031877a995456c528095c41d1948546bf45:

  Merge tag 'kvm-s390-next-7.1-1' of https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD (2026-04-13 19:01:15 +0200)

A lot of small things, with many bugfixes and cleanups.  Nothing that
stands out (other than the pKVM protected guests, which however are
very experimental), but altogether a diffstat that's very much
unbalanced towards new lines.

There is a semantic conflict with the tip tree; it's also flagged as a real
conflict by git but there is a twist - function get_tdx_sys_info_version
of arch/x86/virt/vmx/tdx/tdx_global_metadata.c (introduced by the tip
tree earlier in the merge window) must be declared __init.

Apart from this, there is a shared topic branch with the tracing tree
that you have already merged, so if you see some extra tracing changes
that's why!

Thanks,

Paolo

----------------------------------------------------------------
Arm:

- Add support for tracing in the standalone EL2 hypervisor code, which
  should help both debugging and performance analysis.  This uses the
  new infrastructure for 'remote' trace buffers that can be exposed
  by non-kernel entities such as firmware, and which came through the
  tracing tree.

- Add support for GICv5 Per Processor Interrupts (PPIs), as the starting
  point for supporting the new GIC architecture in KVM.

- Finally add support for pKVM protected guests, where pages are unmapped
  from the host as they are faulted into the guest and can be shared back
  from the guest using pKVM hypercalls.  Protected guests are created
  using a new machine type identifier.  As the elusive guestmem has not
  yet delivered on its promises, anonymous memory is also supported.

  This is only a first step towards full isolation from the host; for
  example, the CPU register state and DMA accesses are not yet isolated.
  Because this does not really yet bring fully what it promises, it is
  hidden behind CONFIG_ARM_PKVM_GUEST + 'kvm-arm.mode=protected', and
  also triggers TAINT_USER when a VM is created.  Caveat emptor.

- Rework the dreaded user_mem_abort() function to make it more
  maintainable, reducing the amount of state being exposed to the
  various helpers and rendering a substantial amount of state immutable.

- Expand the Stage-2 page table dumper to support NV shadow page tables
  on a per-VM basis.

- Tidy up the pKVM PSCI proxy code to be slightly less hard to follow.

- Fix both SPE and TRBE in non-VHE configurations so that they do not
  generate spurious, out of context table walks that ultimately lead
  to very bad HW lockups.

- A small set of patches fixing the Stage-2 MMU freeing in error cases.

- Tighten-up accepted SMC immediate value to be only #0 for host
  SMCCC calls.

- The usual cleanups and other selftest churn.

LoongArch:

- Use CSR_CRMD_PLV for kvm_arch_vcpu_in_kernel().

- Add DMSINTC irqchip in kernel support.

RISC-V:

- Fix steal time shared memory alignment checks

- Fix vector context allocation leak

- Fix array out-of-bounds in pmu_ctr_read() and pmu_fw_ctr_read_hi()

- Fix double-free of sdata in kvm_pmu_clear_snapshot_area()

- Fix integer overflow in kvm_pmu_validate_counter_mask()

- Fix shift-out-of-bounds in make_xfence_request()

- Fix lost write protection on huge pages during dirty logging

- Split huge pages during fault handling for dirty logging

- Skip CSR restore if VCPU is reloaded on the same core

- Implement kvm_arch_has_default_irqchip() for KVM selftests

- Factored-out ISA checks into separate sources

- Added hideleg to struct kvm_vcpu_config

- Factored-out VCPU config into separate sources

- Support configuration of per-VM HGATP mode from KVM user space

s390:

- Support for ESA (31-bit) guests inside nested hypervisors.

- Remove restriction on memslot alignment, which is not needed anymore with
  the new gmap code.

- Fix LPSW/E to update the bear (which of course is the breaking event
  address register).

x86:

- Shut up various UBSAN warnings on reading module parameter before they
  were initialized.

- Don't zero-allocate page tables that are used for splitting hugepages in
  the TDP MMU, as KVM is guaranteed to set all SPTEs in the page table and
  thus write all bytes.

- As an optimization, bail early when trying to unsync 4KiB mappings if the
  target gfn can just be mapped with a 2MiB hugepage.

x86 generic:

- Copy single-chunk MMIO write values into struct kvm_vcpu (more precisely
  struct kvm_mmio_fragment) to fix use-after-free stack bugs where KVM
  would dereference stack pointer after an exit to userspace.

- Clean up and comment the emulated MMIO code to try to make it easier to
  maintain (not necessarily "easy", but "easier").

- Move VMXON+VMXOFF and EFER.SVME toggling out of KVM (not *all* of VMX
  and SVM enabling) as it is needed for trusted I/O.

- Advertise support for AVX512 Bit Matrix Multiply (BMM) instructions

- Immediately fail the build if a required #define is missing in one of
  KVM's headers that is included multiple times.

- Reject SET_GUEST_DEBUG with -EBUSY if there's an already injected
  exception, mostly to prevent syzkaller from abusing the uAPI to
  trigger WARNs, but also because it can help prevent userspace from
  unintentionally crashing the VM.

- Exempt SMM from CPUID faulting on Intel, as per the spec.

- Misc hardening and cleanup changes.

x86 (AMD):

- Fix and optimize IRQ window inhibit handling for AVIC; make it per-vCPU
  so that KVM doesn't prematurely re-enable AVIC if multiple
  vCPUs have to-be-injected IRQs.

- Clean up and optimize the OSVW handling, avoiding a bug in which KVM would
  overwrite state when enabling virtualization on multiple CPUs in parallel.
  This should not be a problem because OSVW should usually be the same for
  all CPUs.

- Drop a WARN in KVM_MEMORY_ENCRYPT_REG_REGION where KVM complains about a
  "too large" size based purely on user input.

- Clean up and harden the pinning code for KVM_MEMORY_ENCRYPT_REG_REGION.

- Disallow synchronizing a VMSA of an already-launched/encrypted vCPU, as
  doing so for an SNP guest will crash the host due to an RMP violation
  page fault.

- Overhaul KVM's APIs for detecting SEV+ guests so that VM-scoped queries
  are required to hold kvm->lock, and enforce it by lockdep.  Fix various
  bugs where sev_guest() was not ensured to be stable for the whole
  duration of a function or ioctl.

- Convert a pile of kvm->lock SEV code to guard().

- Play nicer with userspace that does not enable KVM_CAP_EXCEPTION_PAYLOAD,
  for which KVM needs to set CR2 and DR6 as a response to ioctls such as
  KVM_GET_VCPU_EVENTS (even if the payload would end up in EXITINFO2
  rather than CR2, for example).  Only set CR2 and DR6 when consumption of
  the payload is imminent, but on the other hand force delivery of the
  payload in all paths where userspace retrieves CR2 or DR6.

- Use vcpu->arch.cr2 when updating vmcb12's CR2 on nested #VMEXIT instead
  of vmcb02->save.cr2.  The value is out of sync after a save/restore
  or after a #PF is injected into L2.

- Fix a class of nSVM bugs where some fields written by the CPU are not
  synchronized from vmcb02 to cached vmcb12 after VMRUN, and so are not
  up-to-date when saved by KVM_GET_NESTED_STATE.

- Fix a class of bugs where the ordering between KVM_SET_NESTED_STATE and
  KVM_SET_{S}REGS could cause vmcb02 to be incorrectly initialized after
  save+restore.

- Add a variety of missing nSVM consistency checks.

- Fix several bugs where KVM failed to correctly update VMCB fields on
  nested #VMEXIT.

- Fix several bugs where KVM failed to correctly synthesize #UD or #GP for
  SVM-related instructions.

- Add support for save+restore of virtualized LBRs (on SVM).

- Refactor various helpers and macros to improve clarity and (hopefully)
  make the code easier to maintain.

- Aggressively sanitize fields when copying from vmcb12, to guard against
  unintentionally allowing L1 to utilize yet-to-be-defined features.

- Fix several bugs where KVM botched rAX legality checks when emulating SVM
  instructions.  There are remaining issues in that KVM doesn't handle size
  prefix overrides for 64-bit guests.

- Fail emulation of VMRUN/VMLOAD/VMSAVE if mapping vmcb12 fails instead of
  somewhat arbitrarily synthesizing #GP (i.e. don't double down on AMD's
  architectural but sketchy behavior of generating #GP for "unsupported"
  addresses).

- Cache all used vmcb12 fields to further harden against TOCTOU bugs.

x86 (Intel):

- Drop obsolete branch hint prefixes from the VMX instruction macros.

- Use ASM_INPUT_RM() in __vmcs_writel() to coerce clang into using a
  register input when appropriate.

- Code cleanups.

guest_memfd:

- Don't mark guest_memfd folios as accessed, as guest_memfd doesn't support
  reclaim, the memory is unevictable, and there is no storage to write
  back to.

LoongArch selftests:

- Add KVM PMU test cases

s390 selftests:

- Enable more memory selftests.

x86 selftests:

- Add support for Hygon CPUs in KVM selftests.

- Fix a bug in the MSR test where it would get false failures on AMD/Hygon
  CPUs with exactly one of RDPID or RDTSCP.

- Add an MADV_COLLAPSE testcase for guest_memfd as a regression test for a
  bug where the kernel would attempt to collapse guest_memfd folios against
  KVM's will.

----------------------------------------------------------------
Ackerley Tng (3):
      KVM: guest_memfd: Don't set FGP_ACCESSED when getting folios
      KVM: selftests: Wrap madvise() to assert success
      KVM: selftests: Test MADV_COLLAPSE on guest_memfd

Anel Orazgaliyeva (1):
      KVM: X86: Fix array_index_nospec protection in __pv_send_ipi

Anup Patel (6):
      RISC-V: KVM: Introduce common kvm_riscv_isa_check_host()
      RISC-V: KVM: Factor-out ISA checks into separate sources
      RISC-V: KVM: Move timer state defines closer to struct in UAPI header
      RISC-V: KVM: Add hideleg to struct kvm_vcpu_config
      RISC-V: KVM: Factor-out VCPU config into separate sources
      RISC-V: KVM: Don't check hstateen0 when updating sstateen0 CSR

Arnd Bergmann (3):
      tracing: add more symbols to whitelist
      KVM: arm64: tracing: add ftrace dependency
      KVM: arm64: avoid unused-variable warning

Bibo Mao (4):
      LoongArch: KVM: Check kvm_request_pending() in kvm_late_check_requests()
      LoongArch: KVM: Move host CSR_EENTRY save and restore in context switch
      LoongArch: KVM: Move host CSR_GSTAT save and restore in context switch
      LoongArch: KVM: Make vcpu_is_preempted() as a macro rather than function

Carlos López (6):
      KVM: x86/pmu: annotate struct kvm_x86_pmu_event_filter with __counted_by()
      KVM: SEV: use mutex guard in snp_launch_update()
      KVM: SEV: use mutex guard in sev_mem_enc_ioctl()
      KVM: SEV: use mutex guard in sev_mem_enc_unregister_region()
      KVM: SEV: use mutex guard in snp_handle_guest_req()
      KVM: SVM: Move lock-protected allocation of SEV ASID into a separate helper

Chao Gao (1):
      x86/virt/tdx: KVM: Consolidate TDX CPU hotplug handling

Claudio Imbrenda (6):
      KVM: s390: Add some useful mask macros
      KVM: s390: Add alignment checks for hugepages
      KVM: s390: Allow 4k granularity for memslots
      KVM: selftests: Remove 1M alignment requirement for s390
      KVM: s390: selftests: enable some common memory-related tests
      KVM: s390: ucontrol: Fix memslot handling

Eric Farman (4):
      KVM: s390: only deliver service interrupt with payload
      KVM: s390: vsie: Allow non-zarch guests
      KVM: s390: vsie: Disable some bits when in ESA mode
      KVM: s390: vsie: Accommodate ESA prefix pages

Fangyu Yu (3):
      RISC-V: KVM: Support runtime configuration for per-VM's HGATP mode
      RISC-V: KVM: Cache gstage pgd_levels in struct kvm_gstage
      RISC-V: KVM: Reuse KVM_CAP_VM_GPA_BITS to select HGATP.MODE

Fuad Tabba (14):
      KVM: arm64: Extract VMA size resolution in user_mem_abort()
      KVM: arm64: Introduce struct kvm_s2_fault to user_mem_abort()
      KVM: arm64: Extract PFN resolution in user_mem_abort()
      KVM: arm64: Isolate mmap_read_lock inside new kvm_s2_fault_get_vma_info() helper
      KVM: arm64: Extract stage-2 permission logic in user_mem_abort()
      KVM: arm64: Extract page table mapping in user_mem_abort()
      KVM: arm64: Simplify nested VMA shift calculation
      KVM: arm64: Remove redundant state variables from struct kvm_s2_fault
      KVM: arm64: Simplify return logic in user_mem_abort()
      KVM: arm64: Initialize struct kvm_s2_fault completely at declaration
      KVM: arm64: Optimize early exit checks in kvm_s2_fault_pin_pfn()
      KVM: arm64: Hoist MTE validation check out of MMU lock path
      KVM: arm64: Clean up control flow in kvm_s2_fault_map()
      KVM: arm64: Expose self-hosted debug regs as RAZ/WI for protected guests

Gal Pressman (2):
      KVM: SVM: Fix UBSAN warning when reading avic parameter
      KVM: x86/mmu: Fix UBSAN warning when reading nx_huge_pages parameter

Hendrik Brueckner (1):
      KVM: s390: Add KVM capability for ESA mode guests

Janosch Frank (1):
      KVM: s390: Fix lpsw/e breaking event handling

Jiakai Xu (8):
      RISC-V: KVM: Validate SBI STA shmem alignment in kvm_sbi_ext_sta_set_reg()
      KVM: selftests: Refactor UAPI tests into dedicated function
      RISC-V: KVM: selftests: Add RISC-V SBI STA shmem alignment tests
      RISC-V: KVM: Fix array out-of-bounds in pmu_ctr_read() and pmu_fw_ctr_read_hi()
      RISC-V: KVM: selftests: Fix firmware counter read in sbi_pmu_test
      RISC-V: KVM: Fix double-free of sdata in kvm_pmu_clear_snapshot_area()
      RISC-V: KVM: Fix integer overflow in kvm_pmu_validate_counter_mask()
      RISC-V: KVM: Fix shift-out-of-bounds in make_xfence_request()

Jim Mattson (2):
      KVM: x86: Ignore cpuid faulting in SMM
      KVM: x86: SVM: Remove vmcb_is_dirty()

Jinyu Tang (1):
      KVM: riscv: Skip CSR restore if VCPU is reloaded on the same core

Kevin Cheng (4):
      KVM: SVM: Inject #UD for INVLPGA if EFER.SVME=0
      KVM: nSVM: Raise #UD if unhandled VMMCALL isn't intercepted by L1
      KVM: SVM: Move STGI and CLGI intercept handling
      KVM: SVM: Recalc instructions intercepts when EFER.SVME is toggled

Lai Jiangshan (1):
      KVM: x86/mmu: KVM: x86/mmu: Skip unsync when large pages are allowed

Li RongQing (3):
      KVM: Mark halt poll and other module parameters with appropriate memory attributes
      KVM: SVM: Mark module parameters as __ro_after_init for security and performance
      KVM: SVM: Mark module parameters as __ro_after_init for security and performance

Marc Zyngier (49):
      tracing: Restore accidentally removed SPDX tag
      KVM: arm64: pkvm: Move error handling to the end of kvm_hyp_cpu_entry
      KVM: arm64: pkvm: Simplify BTI handling on CPU boot
      KVM: arm64: pkvm: Turn __kvm_hyp_init_cpu into an inner label
      KVM: arm64: pkvm: Use direct function pointers for cpu_{on,resume}
      KVM: arm64: Remove extra ISBs when using msr_hcr_el2
      KVM: arm64: Kill fault->ipa
      KVM: arm64: Make fault_ipa immutable
      KVM: arm64: Move fault context to const structure
      KVM: arm64: Replace fault_is_perm with a helper
      KVM: arm64: Constrain fault_granule to kvm_s2_fault_map()
      KVM: arm64: Kill write_fault from kvm_s2_fault
      KVM: arm64: Kill exec_fault from kvm_s2_fault
      KVM: arm64: Kill topup_memcache from kvm_s2_fault
      KVM: arm64: Move VMA-related information to kvm_s2_fault_vma_info
      KVM: arm64: Kill logging_active from kvm_s2_fault
      KVM: arm64: Restrict the scope of the 'writable' attribute
      KVM: arm64: Move kvm_s2_fault.{pfn,page} to kvm_s2_vma_info
      KVM: arm64: Replace force_pte with a max_map_size attribute
      KVM: arm64: Move device mapping management into kvm_s2_fault_pin_pfn()
      KVM: arm64: Directly expose mapping prot and kill kvm_s2_fault
      KVM: arm64: Simplify integration of adjust_nested_*_perms()
      KVM: arm64: Convert gmem_abort() to struct kvm_s2_fault_desc
      KVM: arm64: vgic: Don't reset cpuif/redist addresses at finalize time
      KVM: arm64: Don't skip per-vcpu NV initialisation
      arm64: Fix field references for ICH_PPI_DVIR[01]_EL2
      KVM: arm64: Fix writeable mask for ID_AA64PFR2_EL1
      KVM: arm64: Account for RESx bits in __compute_fgt()
      KVM: arm64: vgic-v5: Hold config_lock while finalizing GICv5 PPIs
      KVM: arm64: vgic-v5: Transfer edge pending state to ICH_PPI_PENDRx_EL2
      KVM: arm64: vgic-v5: Cast vgic_apr to u32 to avoid undefined behaviours
      KVM: arm64: vgic-v5: Make the effective priority mask a strict limit
      KVM: arm64: vgic-v5: Correctly set dist->ready once initialised
      KVM: arm64: Kill arch_timer_context::direct field
      KVM: arm64: Remove evaluation of timer state in kvm_cpu_has_pending_timer()
      KVM: arm64: Move GICv5 timer PPI validation into timer_irqs_are_valid()
      KVM: arm64: Correctly plumb ID_AA64PFR2_EL1 into pkvm idreg handling
      KVM: arm64: Don't advertises GICv3 in ID_PFR1_EL1 if AArch32 isn't supported
      KVM: arm64: set_id_regs: Allow GICv3 support to be set at runtime
      KVM: arm64: Advertise ID_AA64PFR2_EL1.GCIE
      Merge branch kvm-arm64/hyp-tracing into kvmarm-master/next
      Merge branch kvm-arm64/vgic-v5-ppi into kvmarm-master/next
      Merge branch kvm-arm64/nv-s2-debugfs into kvmarm-master/next
      Merge branch kvm-arm64/pkvm-psci into kvmarm-master/next
      Merge branch kvm-arm64/user_mem_abort-rework into kvmarm-master/next
      Merge branch kvm-arm64/spe-trbe-nvhe into kvmarm-master/next
      Merge branch kvm-arm64/pkvm-protected-guest into kvmarm-master/next
      Merge branch kvm-arm64/vgic-fixes-7.1 into kvmarm-master/next
      Merge branch kvm-arm64/misc-7.1 into kvmarm-master/next

Mayuresh Chitale (1):
      KVM: riscv: selftests: Implement kvm_arch_has_default_irqchip

Nathan Chancellor (1):
      tracing: Adjust cmd_check_undefined to show unexpected undefined symbols

Nikunj A Dadhania (1):
      KVM: x86: Advertise AVX512 Bit Matrix Multiply (BMM) to userspace

Osama Abdelkader (2):
      RISC-V: KVM: fix PMU snapshot_set_shmem on 32-bit hosts
      riscv: kvm: fix vector context allocation leak

Paolo Bonzini (14):
      Merge tag 'kvm-riscv-7.1-1' of https://github.com/kvm-riscv/linux into HEAD
      Merge tag 'loongarch-kvm-7.1' of git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson into HEAD
      Merge tag 'kvmarm-7.1' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD
      Merge tag 'kvm-x86-gmem-7.1' of https://github.com/kvm-x86/linux into HEAD
      Merge tag 'kvm-x86-misc-7.1' of https://github.com/kvm-x86/linux into HEAD
      Merge tag 'kvm-x86-selftests-7.1' of https://github.com/kvm-x86/linux into HEAD
      Merge tag 'kvm-x86-mmio-7.1' of https://github.com/kvm-x86/linux into HEAD
      Merge tag 'kvm-x86-vmx-7.1' of https://github.com/kvm-x86/linux into HEAD
      Merge tag 'kvm-x86-mmu-7.1' of https://github.com/kvm-x86/linux into HEAD
      Merge tag 'kvm-x86-nested-7.1' of https://github.com/kvm-x86/linux into HEAD
      Merge tag 'kvm-x86-vmxon-7.1' of https://github.com/kvm-x86/linux into HEAD
      Merge tag 'kvm-x86-svm-7.1' of https://github.com/kvm-x86/linux into HEAD
      KVM: x86: use inlines instead of macros for is_sev_*guest
      Merge tag 'kvm-s390-next-7.1-1' of https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD

Quentin Perret (1):
      KVM: arm64: Inject SIGSEGV on illegal accesses

Sascha Bischoff (41):
      KVM: arm64: vgic-v3: Drop userspace write sanitization for ID_AA64PFR0.GIC on GICv5
      KVM: arm64: vgic: Rework vgic_is_v3() and add vgic_host_has_gicvX()
      KVM: arm64: Return early from kvm_finalize_sys_regs() if guest has run
      KVM: arm64: vgic: Split out mapping IRQs and setting irq_ops
      arm64/sysreg: Add remaining GICv5 ICC_ & ICH_ sysregs for KVM support
      arm64/sysreg: Add GICR CDNMIA encoding
      KVM: arm64: gic-v5: Add ARM_VGIC_V5 device to KVM headers
      KVM: arm64: gic: Introduce interrupt type helpers
      KVM: arm64: gic-v5: Add Arm copyright header
      KVM: arm64: gic-v5: Detect implemented PPIs on boot
      KVM: arm64: gic-v5: Sanitize ID_AA64PFR2_EL1.GCIE
      KVM: arm64: gic-v5: Support GICv5 FGTs & FGUs
      KVM: arm64: gic-v5: Add emulation for ICC_IAFFIDR_EL1 accesses
      KVM: arm64: gic-v5: Trap and emulate ICC_IDR0_EL1 accesses
      KVM: arm64: gic-v5: Add vgic-v5 save/restore hyp interface
      KVM: arm64: gic-v5: Implement GICv5 load/put and save/restore
      KVM: arm64: gic-v5: Finalize GICv5 PPIs and generate mask
      KVM: arm64: gic: Introduce queue_irq_unlock to irq_ops
      KVM: arm64: gic-v5: Implement PPI interrupt injection
      KVM: arm64: gic-v5: Init Private IRQs (PPIs) for GICv5
      KVM: arm64: gic-v5: Clear TWI if single task running
      KVM: arm64: gic-v5: Check for pending PPIs
      KVM: arm64: gic-v5: Trap and mask guest ICC_PPI_ENABLERx_EL1 writes
      KVM: arm64: Introduce set_direct_injection irq_op
      KVM: arm64: gic-v5: Implement direct injection of PPIs
      KVM: arm64: gic-v5: Support GICv5 interrupts with KVM_IRQ_LINE
      KVM: arm64: gic-v5: Create and initialise vgic_v5
      KVM: arm64: gic-v5: Initialise ID and priority bits when resetting vcpu
      irqchip/gic-v5: Introduce minimal irq_set_type() for PPIs
      KVM: arm64: gic-v5: Enlighten arch timer for GICv5
      KVM: arm64: gic-v5: Mandate architected PPI for PMU emulation on GICv5
      KVM: arm64: gic: Hide GICv5 for protected guests
      KVM: arm64: gic-v5: Hide FEAT_GCIE from NV GICv5 guests
      KVM: arm64: gic-v5: Introduce kvm_arm_vgic_v5_ops and register them
      KVM: arm64: gic-v5: Set ICH_VCTLR_EL2.En on boot
      KVM: arm64: gic-v5: Probe for GICv5 device
      Documentation: KVM: Introduce documentation for VGICv5
      KVM: arm64: gic-v5: Communicate userspace-driveable PPIs via a UAPI
      KVM: arm64: selftests: Introduce a minimal GICv5 PPI selftest
      KVM: arm64: selftests: Add no-vgic-v5 selftest
      KVM: arm64: vgic-v5: Fold PPI state for all exposed PPIs

Sean Christopherson (75):
      KVM: x86: Defer non-architectural deliver of exception payload to userspace read
      KVM: selftests: Fix reserved value WRMSR testcase for multi-feature MSRs
      KVM: SVM: Fix clearing IRQ window inhibit with nested guests
      KVM: SVM: Fix IRQ window inhibit handling across multiple vCPUs
      KVM: SVM: Optimize IRQ window inhibit handling
      KVM: Isolate apicv_update_lock and apicv_nr_irq_window_req in a cacheline
      KVM: x86: Use scratch field in MMIO fragment to hold small write values
      KVM: x86: Open code handling of completed MMIO reads in emulator_read_write()
      KVM: x86: Trace unsatisfied MMIO reads on a per-page basis
      KVM: x86: Use local MMIO fragment variable to clean up emulator_read_write()
      KVM: x86: Open code read vs. write userspace MMIO exits in emulator_read_write()
      KVM: x86: Move MMIO write tracing into vcpu_mmio_write()
      KVM: x86: Harden SEV-ES MMIO against on-stack use-after-free
      KVM: x86: Dedup kvm_sev_es_mmio_{read,write}()
      KVM: x86: Consolidate SEV-ES MMIO emulation into a single public API
      KVM: x86: Bury emulator read/write ops in emulator_{read,write}_emulated()
      KVM: x86: Fold emulator_write_phys() into write_emulate()
      KVM: x86: Rename .read_write_emulate() to .read_write_guest()
      KVM: x86: Don't panic the kernel if completing userspace I/O / MMIO goes sideways
      KVM: x86: Add helpers to prepare kvm_run for userspace MMIO exit
      KVM: x86/mmu: Don't zero-allocate page table used for splitting a hugepage
      KVM: SVM: Serialize updates to global OS-Visible Workarounds variables
      KVM: SVM: Skip OSVW MSR reads if KVM is treating all errata as present
      KVM: SVM: Extract OS-visible workarounds setup to helper function
      KVM: SVM: Skip OSVW variable updates if current CPU's errata are a subset
      KVM: SVM: Skip OSVW MSR reads if current CPU doesn't support the feature
      KVM: x86: Move kvm_rebooting to x86
      KVM: VMX: Move architectural "vmcs" and "vmcs_hdr" structures to public vmx.h
      KVM: x86: Move "kvm_rebooting" to kernel as "virt_rebooting"
      KVM: VMX: Unconditionally allocate root VMCSes during boot CPU bringup
      x86/virt: Force-clear X86_FEATURE_VMX if configuring root VMCS fails
      KVM: VMX: Move core VMXON enablement to kernel
      KVM: SVM: Move core EFER.SVME enablement to kernel
      KVM: x86: Move bulk of emergency virtualizaton logic to virt subsystem
      x86/virt: Add refcounting of VMX/SVM usage to support multiple in-kernel users
      x86/virt/tdx: Drop the outdated requirement that TDX be enabled in IRQ context
      KVM: x86/tdx: Do VMXON and TDX-Module initialization during subsys init
      x86/virt/tdx: Tag a pile of functions as __init, and globals as __ro_after_init
      x86/virt/tdx: Use ida_is_empty() to detect if any TDs may be running
      KVM: Bury kvm_{en,dis}able_virtualization() in kvm_main.c once more
      KVM: TDX: Fold tdx_bringup() into tdx_hardware_setup()
      KVM: nSVM: Delay setting soft IRQ RIP tracking fields until vCPU run
      KVM: SVM: Explicitly mark vmcb01 dirty after modifying VMCB intercepts
      KVM: nSVM: Always intercept VMMCALL when L2 is active
      KVM: SVM: Separate recalc_intercepts() into nested vs. non-nested parts
      KVM: nSVM: Directly (re)calc vmcb02 intercepts from nested_vmcb02_prepare_control()
      KVM: nSVM: Use intuitive local variables in nested_vmcb02_recalc_intercepts()
      KVM: nSVM: Move vmcb_ctrl_area_cached.bus_lock_rip to svm_nested_state
      KVM: nSVM: Capture svm->nested.ctl as vmcb12_ctrl when preparing vmcb02
      KVM: SVM: Rename vmcb->nested_ctl to vmcb->misc_ctl
      KVM: x86: Immediately fail the build when possible if required #define is missing
      KVM: SVM: Add a helper to get LBR field pointer to dedup MSR accesses
      KVM: x86: Suppress WARNs on nested_run_pending after userspace exit
      KVM: SEV: Drop WARN on large size for KVM_MEMORY_ENCRYPT_REG_REGION
      KVM: SEV: Drop useless sanity checks in sev_mem_enc_register_region()
      KVM: SEV: Disallow pinning more pages than exist in the system
      KVM: SEV: Use PFN_DOWN() to simplify "number of pages" math when pinning memory
      KVM: SEV: Use kvzalloc_objs() when pinning userpages
      KVM: selftests: Remove duplicate LAUNCH_UPDATE_VMSA call in SEV-ES migrate test
      KVM: SEV: Reject attempts to sync VMSA of an already-launched/encrypted vCPU
      KVM: SEV: Protect *all* of sev_mem_enc_register_region() with kvm->lock
      KVM: SEV: Disallow LAUNCH_FINISH if vCPUs are actively being created
      KVM: SEV: Lock all vCPUs when synchronzing VMSAs for SNP launch finish
      KVM: SEV: Lock all vCPUs for the duration of SEV-ES VMSA synchronization
      KVM: SEV: Provide vCPU-scoped accessors for detecting SEV+ guests
      KVM: SEV: Add quad-underscore version of VM-scoped APIs to detect SEV+ guests
      KVM: SEV: Document the SEV-ES check when querying SMM support as "safe"
      KVM: SEV: Move standard VM-scoped helpers to detect SEV+ guests to sev.c
      KVM: SEV: Move SEV-specific VM initialization to sev.c
      KVM: SEV: WARN on unhandled VM type when initializing VM
      KVM: SEV: Hide "struct kvm_sev_info" behind CONFIG_KVM_AMD_SEV=y
      KVM: SEV: Document that checking for SEV+ guests when reclaiming memory is "safe"
      KVM: SEV: Assert that kvm->lock is held when querying SEV+ support
      KVM: SEV: Goto an existing error label if charging misc_cg for an ASID fails
      x86/virt: Treat SVM as unsupported when running as an SEV+ guest

Sebastian Ene (1):
      KVM: arm64: Prevent the host from using an smc with imm16 != 0

Song Gao (5):
      LoongArch: KVM: Add DMSINTC device support
      LoongArch: KVM: Add DMSINTC inject msi to vCPU
      KVM: LoongArch: selftests: Add cpucfg read/write helpers
      KVM: LoongArch: selftests: Add basic PMU event counting test
      KVM: LoongArch: selftests: Add PMU overflow interrupt test

Tao Cui (1):
      LoongArch: KVM: Use CSR_CRMD_PLV in kvm_arch_vcpu_in_kernel()

Uros Bizjak (3):
      KVM: x86: Zero-initialize temporary fxregs_state buffers in FXSAVE emulation
      KVM: VMX: Drop obsolete branch hint prefixes from inline asm
      KVM: VMX: Use ASM_INPUT_RM in __vmcs_writel

Vincent Donnefort (17):
      KVM: arm64: Add PKVM_DISABLE_STAGE2_ON_PANIC
      KVM: arm64: Add clock support to nVHE/pKVM hyp
      KVM: arm64: Initialise hyp_nr_cpus for nVHE hyp
      KVM: arm64: Support unaligned fixmap in the pKVM hyp
      KVM: arm64: Add tracing capability for the nVHE/pKVM hyp
      KVM: arm64: Add trace remote for the nVHE/pKVM hyp
      KVM: arm64: Sync boot clock with the nVHE/pKVM hyp
      KVM: arm64: Add trace reset to the nVHE/pKVM hyp
      KVM: arm64: Add event support to the nVHE/pKVM hyp and trace remote
      KVM: arm64: Add hyp_enter/hyp_exit events to nVHE/pKVM hyp
      KVM: arm64: Add selftest event support to nVHE/pKVM hyp
      tracing: selftests: Add hypervisor trace remote tests
      KVM: arm64: Fix out-of-tree build for nVHE/pKVM tracing
      tracing: Update undefined symbols allow list for simple_ring_buffer
      tracing: Generate undef symbols allowlist for simple_ring_buffer
      tracing: Non-consuming read for trace remotes with an offline CPU
      tracing: selftests: Extend hotplug testing for trace remotes

Wang Yechao (2):
      RISC-V: KVM: Fix lost write protection on huge pages during dirty logging
      RISC-V: KVM: Split huge pages during fault handling for dirty logging

Wei-Lin Chang (2):
      KVM: arm64: ptdump: Make KVM ptdump code s2 mmu aware
      KVM: arm64: nv: Expose shadow page tables in debugfs

Will Deacon (44):
      KVM: arm64: Disable TRBE Trace Buffer Unit when running in guest context
      KVM: arm64: Disable SPE Profiling Buffer when running in guest context
      KVM: arm64: Don't pass host_debug_state to BRBE world-switch routines
      KVM: arm64: Remove unused PKVM_ID_FFA definition
      KVM: arm64: Don't leak stage-2 page-table if VM fails to init under pKVM
      KVM: arm64: Move handle check into pkvm_pgtable_stage2_destroy_range()
      KVM: arm64: Rename __pkvm_pgtable_stage2_unmap()
      KVM: arm64: Don't advertise unsupported features for protected guests
      KVM: arm64: Remove is_protected_kvm_enabled() checks from hypercalls
      KVM: arm64: Ignore MMU notifier callbacks for protected VMs
      KVM: arm64: Prevent unsupported memslot operations on protected VMs
      KVM: arm64: Ignore -EAGAIN when mapping in pages for the pKVM host
      KVM: arm64: Split teardown hypercall into two phases
      KVM: arm64: Introduce __pkvm_host_donate_guest()
      KVM: arm64: Hook up donation hypercall to pkvm_pgtable_stage2_map()
      KVM: arm64: Handle aborts from protected VMs
      KVM: arm64: Introduce __pkvm_reclaim_dying_guest_page()
      KVM: arm64: Hook up reclaim hypercall to pkvm_pgtable_stage2_destroy()
      KVM: arm64: Factor out pKVM host exception injection logic
      KVM: arm64: Support translation faults in inject_host_exception()
      KVM: arm64: Avoid pointless annotation when mapping host-owned pages
      KVM: arm64: Generalise kvm_pgtable_stage2_set_owner()
      KVM: arm64: Introduce host_stage2_set_owner_metadata_locked()
      KVM: arm64: Change 'pkvm_handle_t' to u16
      KVM: arm64: Annotate guest donations with handle and gfn in host stage-2
      KVM: arm64: Introduce hypercall to force reclaim of a protected page
      KVM: arm64: Reclaim faulting page from pKVM in spurious fault handler
      KVM: arm64: Return -EFAULT from VCPU_RUN on access to a poisoned pte
      KVM: arm64: Add hvc handler at EL2 for hypercalls from protected VMs
      KVM: arm64: Implement the MEM_SHARE hypercall for protected VMs
      KVM: arm64: Implement the MEM_UNSHARE hypercall for protected VMs
      KVM: arm64: Allow userspace to create protected VMs when pKVM is enabled
      KVM: arm64: Add some initial documentation for pKVM
      KVM: arm64: Extend pKVM page ownership selftests to cover guest donation
      KVM: arm64: Register 'selftest_vm' in the VM table
      KVM: arm64: Extend pKVM page ownership selftests to cover forced reclaim
      KVM: arm64: Extend pKVM page ownership selftests to cover guest hvcs
      KVM: arm64: Rename PKVM_PAGE_STATE_MASK
      drivers/virt: pkvm: Add Kconfig dependency on DMA_RESTRICTED_POOL
      KVM: arm64: Prevent teardown finalisation of referenced 'hyp_vm'
      KVM: arm64: Allow get_pkvm_hyp_vm() to take a reference to a dying VM
      KVM: arm64: Don't hold 'vm_table_lock' across guest page reclaim
      KVM: arm64: Don't leave mmu->pgt dangling on kvm_init_stage2_mmu() error
      KVM: arm64: Destroy stage-2 page-table in kvm_arch_destroy_vm()

Xin Li (1):
      KVM: VMX: Remove unnecessary parentheses

Yosry Ahmed (53):
      KVM: nSVM: Use vcpu->arch.cr2 when updating vmcb12 on nested #VMEXIT
      KVM: nSVM: Mark all of vmcb02 dirty when restoring nested state
      KVM: x86: Check for injected exceptions before queuing a debug exception
      KVM: nSVM: Ensure AVIC is inhibited when restoring a vCPU to guest mode
      KVM: nSVM: Sync NextRIP to cached vmcb12 after VMRUN of L2
      KVM: nSVM: Sync interrupt shadow to cached vmcb12 after VMRUN of L2
      KVM: selftests: Extend state_test to check vGIF
      KVM: selftests: Extend state_test to check next_rip
      KVM: x86: Drop redundant call to kvm_deliver_exception_payload()
      KVM: nSVM: Always use NextRIP as vmcb02's NextRIP after first L2 VMRUN
      KVM: nSVM: Delay stuffing L2's current RIP into NextRIP until vCPU run
      KVM: nSVM: Avoid clearing VMCB_LBR in vmcb12
      KVM: SVM: Switch svm_copy_lbrs() to a macro
      KVM: SVM: Add missing save/restore handling of LBR MSRs
      KVM: selftests: Add a test for LBR save/restore (ft. nested)
      KVM: nSVM: Always inject a #GP if mapping VMCB12 fails on nested VMRUN
      KVM: nSVM: Refactor checking LBRV enablement in vmcb12 into a helper
      KVM: nSVM: Refactor writing vmcb12 on nested #VMEXIT as a helper
      KVM: nSVM: Triple fault if mapping VMCB12 fails on nested #VMEXIT
      KVM: nSVM: Triple fault if restore host CR3 fails on nested #VMEXIT
      KVM: nSVM: Clear GIF on nested #VMEXIT(INVALID)
      KVM: nSVM: Clear EVENTINJ fields in vmcb12 on nested #VMEXIT
      KVM: nSVM: Clear tracking of L1->L2 NMI and soft IRQ on nested #VMEXIT
      KVM: nSVM: Drop nested_vmcb_check_{save/control}() wrappers
      KVM: nSVM: Drop the non-architectural consistency check for NP_ENABLE
      KVM: nSVM: Add missing consistency check for nCR3 validity
      KVM: nSVM: Add missing consistency check for EFER, CR0, CR4, and CS
      KVM: nSVM: Add missing consistency check for EVENTINJ
      KVM: nSVM: WARN and abort vmcb02 intercepts recalc if vmcb02 isn't active
      KVM: nSVM: Use vmcb12_is_intercept() in nested_sync_control_from_vmcb02()
      KVM: SVM: Rename vmcb->virt_ext to vmcb->misc_ctl2
      KVM: nSVM: Cache all used fields from VMCB12
      KVM: nSVM: Restrict mapping vmcb12 on nested VMRUN
      KVM: nSVM: Use PAGE_MASK to drop lower bits of bitmap GPAs from vmcb12
      KVM: nSVM: Sanitize TLB_CONTROL field when copying from vmcb12
      KVM: nSVM: Sanitize INT/EVENTINJ fields when copying from vmcb12
      KVM: nSVM: Only copy SVM_MISC_ENABLE_NP from VMCB01's misc_ctl
      KVM: selftest: Add a selftest for VMRUN/#VMEXIT with unmappable vmcb12
      KVM: SVM: Triple fault L1 on unintercepted EFER.SVME clear by L2
      KVM: selftests: Add a test for L2 clearing EFER.SVME without intercept
      KVM: x86: Move some EFER bits enablement to common code
      KVM: x86: Use kvm_cpu_cap_has() for EFER bits enablement checks
      KVM: nSVM: Simplify error handling of nested_svm_copy_vmcb12_to_cache()
      KVM: x86: Move nested_run_pending to kvm_vcpu_arch
      KVM: SVM: Properly check RAX in the emulator for SVM instructions
      KVM: SVM: Refactor SVM instruction handling on #GP intercept
      KVM: SVM: Properly check RAX on #GP intercept of SVM instructions
      KVM: SVM: Move RAX legality check to SVM insn interception handlers
      KVM: SVM: Check EFER.SVME and CPL on #GP intercept of SVM instructions
      KVM: SVM: Treat mapping failures equally in VMLOAD/VMSAVE emulation
      KVM: nSVM: Fail emulation of VMRUN/VMLOAD/VMSAVE if mapping vmcb12 fails
      KVM: selftests: Rework svm_nested_invalid_vmcb12_gpa
      KVM: selftests: Drop 'invalid' from svm_nested_invalid_vmcb12_gpa's name

Yufeng Wang (1):
      riscv: kvm: add null pointer check for vector datap

Zenghui Yu (Huawei) (2):
      KVM: arm64: ptdump: Initialize parser_state before pgtable walk
      KVM: arm64: selftests: Avoid testing the IMPDEF behavior

Zhiquan Li (3):
      KVM: selftests: Add CPU vendor detection for Hygon
      KVM: selftests: Add a flag to identify AMD compatible test cases
      KVM: selftests: Allow the PMU event filter test for Hygon

xuanqingshi (1):
      KVM: x86: Add LAPIC guard in kvm_apic_write_nodecode()


 Documentation/admin-guide/kernel-parameters.txt    |   4 +-
 Documentation/arch/x86/tdx.rst                     |  36 +-
 Documentation/virt/kvm/api.rst                     |  14 +-
 Documentation/virt/kvm/arm/index.rst               |   1 +
 Documentation/virt/kvm/arm/pkvm.rst                | 106 ++++
 Documentation/virt/kvm/devices/arm-vgic-v5.rst     |  50 ++
 Documentation/virt/kvm/devices/index.rst           |   1 +
 Documentation/virt/kvm/devices/vcpu.rst            |   5 +-
 arch/arm64/include/asm/el2_setup.h                 |   4 +-
 arch/arm64/include/asm/kvm_asm.h                   |  44 +-
 arch/arm64/include/asm/kvm_define_hypevents.h      |  16 +
 arch/arm64/include/asm/kvm_host.h                  |  50 +-
 arch/arm64/include/asm/kvm_hyp.h                   |  14 +-
 arch/arm64/include/asm/kvm_hypevents.h             |  60 ++
 arch/arm64/include/asm/kvm_hyptrace.h              |  26 +
 arch/arm64/include/asm/kvm_mmu.h                   |   4 +
 arch/arm64/include/asm/kvm_pgtable.h               |  45 +-
 arch/arm64/include/asm/kvm_pkvm.h                  |   4 +-
 arch/arm64/include/asm/sysreg.h                    |  13 +-
 arch/arm64/include/asm/virt.h                      |   9 +
 arch/arm64/include/asm/vncr_mapping.h              |   3 +
 arch/arm64/include/uapi/asm/kvm.h                  |   1 +
 arch/arm64/kernel/cpufeature.c                     |   1 +
 arch/arm64/kernel/hyp-stub.S                       |   1 -
 arch/arm64/kernel/image-vars.h                     |   4 +
 arch/arm64/kernel/vmlinux.lds.S                    |  18 +
 arch/arm64/kvm/Kconfig                             |  68 ++-
 arch/arm64/kvm/Makefile                            |   2 +
 arch/arm64/kvm/arch_timer.c                        | 102 +++-
 arch/arm64/kvm/arm.c                               |  69 ++-
 arch/arm64/kvm/config.c                            | 127 +++-
 arch/arm64/kvm/emulate-nested.c                    |  68 +++
 arch/arm64/kvm/handle_exit.c                       |   2 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h            |  27 +
 arch/arm64/kvm/hyp/include/nvhe/arm-smccc.h        |  23 +
 arch/arm64/kvm/hyp/include/nvhe/clock.h            |  16 +
 arch/arm64/kvm/hyp/include/nvhe/define_events.h    |  14 +
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h      |  12 +-
 arch/arm64/kvm/hyp/include/nvhe/memory.h           |  12 +-
 arch/arm64/kvm/hyp/include/nvhe/pkvm.h             |   7 +-
 arch/arm64/kvm/hyp/include/nvhe/trace.h            |  70 +++
 arch/arm64/kvm/hyp/include/nvhe/trap_handler.h     |   2 +
 arch/arm64/kvm/hyp/nvhe/Makefile                   |   8 +-
 arch/arm64/kvm/hyp/nvhe/clock.c                    |  65 ++
 arch/arm64/kvm/hyp/nvhe/debug-sr.c                 | 116 +++-
 arch/arm64/kvm/hyp/nvhe/events.c                   |  25 +
 arch/arm64/kvm/hyp/nvhe/ffa.c                      |  28 +-
 arch/arm64/kvm/hyp/nvhe/host.S                     |  13 +-
 arch/arm64/kvm/hyp/nvhe/hyp-init.S                 |  41 +-
 arch/arm64/kvm/hyp/nvhe/hyp-main.c                 | 294 ++++++---
 arch/arm64/kvm/hyp/nvhe/hyp.lds.S                  |   6 +
 arch/arm64/kvm/hyp/nvhe/mem_protect.c              | 587 ++++++++++++++++--
 arch/arm64/kvm/hyp/nvhe/mm.c                       |   4 +-
 arch/arm64/kvm/hyp/nvhe/pkvm.c                     | 239 +++++++-
 arch/arm64/kvm/hyp/nvhe/psci-relay.c               |  45 +-
 arch/arm64/kvm/hyp/nvhe/setup.c                    |   4 +-
 arch/arm64/kvm/hyp/nvhe/stacktrace.c               |   6 +-
 arch/arm64/kvm/hyp/nvhe/switch.c                   |  23 +-
 arch/arm64/kvm/hyp/nvhe/sys_regs.c                 |  18 +-
 arch/arm64/kvm/hyp/nvhe/trace.c                    | 306 ++++++++++
 arch/arm64/kvm/hyp/pgtable.c                       |  33 +-
 arch/arm64/kvm/hyp/vgic-v5-sr.c                    | 166 ++++++
 arch/arm64/kvm/hyp/vhe/Makefile                    |   2 +-
 arch/arm64/kvm/hyp_trace.c                         | 442 ++++++++++++++
 arch/arm64/kvm/hyp_trace.h                         |  11 +
 arch/arm64/kvm/mmu.c                               | 624 ++++++++++++-------
 arch/arm64/kvm/nested.c                            |  11 +-
 arch/arm64/kvm/pkvm.c                              | 157 ++++-
 arch/arm64/kvm/pmu-emul.c                          |  20 +-
 arch/arm64/kvm/ptdump.c                            |  79 ++-
 arch/arm64/kvm/stacktrace.c                        |   8 +-
 arch/arm64/kvm/sys_regs.c                          | 200 ++++++-
 arch/arm64/kvm/vgic/vgic-init.c                    | 230 +++++--
 arch/arm64/kvm/vgic/vgic-kvm-device.c              | 107 +++-
 arch/arm64/kvm/vgic/vgic-mmio.c                    |  40 +-
 arch/arm64/kvm/vgic/vgic-v3.c                      |   2 +-
 arch/arm64/kvm/vgic/vgic-v5.c                      | 499 +++++++++++++++-
 arch/arm64/kvm/vgic/vgic.c                         | 173 ++++--
 arch/arm64/kvm/vgic/vgic.h                         |  53 +-
 arch/arm64/mm/fault.c                              |  33 +-
 arch/arm64/tools/sysreg                            | 480 +++++++++++++++
 arch/loongarch/include/asm/kvm_dmsintc.h           |  27 +
 arch/loongarch/include/asm/kvm_host.h              |   3 +
 arch/loongarch/include/asm/kvm_pch_pic.h           |   3 +-
 arch/loongarch/include/asm/qspinlock.h             |  26 +-
 arch/loongarch/include/uapi/asm/kvm.h              |   4 +
 arch/loongarch/kernel/paravirt.c                   |  16 +-
 arch/loongarch/kvm/Makefile                        |   1 +
 arch/loongarch/kvm/intc/dmsintc.c                  | 182 ++++++
 arch/loongarch/kvm/intc/pch_pic.c                  |  15 +-
 arch/loongarch/kvm/interrupt.c                     |   2 +
 arch/loongarch/kvm/irqfd.c                         |  10 +-
 arch/loongarch/kvm/main.c                          |  14 +-
 arch/loongarch/kvm/vcpu.c                          |  29 +-
 arch/riscv/include/asm/kvm_gstage.h                |  51 +-
 arch/riscv/include/asm/kvm_host.h                  |  23 +-
 arch/riscv/include/asm/kvm_isa.h                   |  20 +
 arch/riscv/include/asm/kvm_vcpu_config.h           |  25 +
 arch/riscv/include/uapi/asm/kvm.h                  |   8 +-
 arch/riscv/kvm/Makefile                            |   2 +
 arch/riscv/kvm/aia_device.c                        |   4 +-
 arch/riscv/kvm/gstage.c                            | 198 ++++--
 arch/riscv/kvm/isa.c                               | 253 ++++++++
 arch/riscv/kvm/main.c                              |  16 +-
 arch/riscv/kvm/mmu.c                               |  70 +--
 arch/riscv/kvm/tlb.c                               |   3 +-
 arch/riscv/kvm/vcpu.c                              | 111 ++--
 arch/riscv/kvm/vcpu_config.c                       | 103 ++++
 arch/riscv/kvm/vcpu_fp.c                           |   9 +-
 arch/riscv/kvm/vcpu_onereg.c                       | 284 +--------
 arch/riscv/kvm/vcpu_pmu.c                          |  33 +-
 arch/riscv/kvm/vcpu_sbi_sta.c                      |  16 +-
 arch/riscv/kvm/vcpu_timer.c                        |   3 +-
 arch/riscv/kvm/vcpu_vector.c                       |  11 +-
 arch/riscv/kvm/vm.c                                |  49 +-
 arch/riscv/kvm/vmid.c                              |   3 +-
 arch/s390/include/asm/kvm_host.h                   |   1 +
 arch/s390/include/asm/kvm_host_types.h             |   3 +-
 arch/s390/kvm/dat.h                                |   5 +
 arch/s390/kvm/faultin.c                            |   2 +-
 arch/s390/kvm/gaccess.c                            |   2 +-
 arch/s390/kvm/gmap.c                               |  32 +-
 arch/s390/kvm/gmap.h                               |   3 +-
 arch/s390/kvm/interrupt.c                          |   3 +
 arch/s390/kvm/kvm-s390.c                           |  28 +-
 arch/s390/kvm/kvm-s390.h                           |   5 +-
 arch/s390/kvm/priv.c                               |   8 +-
 arch/s390/kvm/vsie.c                               |  29 +-
 arch/x86/events/intel/pt.c                         |   1 -
 arch/x86/include/asm/cpufeatures.h                 |   1 +
 arch/x86/include/asm/kvm-x86-ops.h                 |  10 +-
 arch/x86/include/asm/kvm-x86-pmu-ops.h             |   8 +-
 arch/x86/include/asm/kvm_host.h                    |  52 +-
 arch/x86/include/asm/reboot.h                      |  11 -
 arch/x86/include/asm/svm.h                         |  20 +-
 arch/x86/include/asm/tdx.h                         |   4 -
 arch/x86/include/asm/virt.h                        |  26 +
 arch/x86/include/asm/vmx.h                         |  11 +
 arch/x86/kernel/cpu/common.c                       |   2 +
 arch/x86/kernel/crash.c                            |   3 +-
 arch/x86/kernel/reboot.c                           |  63 +-
 arch/x86/kernel/smp.c                              |   5 +-
 arch/x86/kvm/cpuid.c                               |   6 +-
 arch/x86/kvm/emulate.c                             |  26 +-
 arch/x86/kvm/hyperv.h                              |   8 -
 arch/x86/kvm/kvm_emulate.h                         |   2 +
 arch/x86/kvm/lapic.c                               |  13 +-
 arch/x86/kvm/mmu/mmu.c                             |  14 +
 arch/x86/kvm/mmu/tdp_mmu.c                         |   2 +-
 arch/x86/kvm/pmu.c                                 |   2 +-
 arch/x86/kvm/svm/avic.c                            |  19 +-
 arch/x86/kvm/svm/hyperv.h                          |   9 +-
 arch/x86/kvm/svm/nested.c                          | 623 +++++++++++--------
 arch/x86/kvm/svm/sev.c                             | 402 +++++++------
 arch/x86/kvm/svm/svm.c                             | 664 ++++++++++++---------
 arch/x86/kvm/svm/svm.h                             | 128 +++-
 arch/x86/kvm/svm/vmenter.S                         |  10 +-
 arch/x86/kvm/vmx/capabilities.h                    |   2 +-
 arch/x86/kvm/vmx/main.c                            |  21 +-
 arch/x86/kvm/vmx/nested.c                          |  50 +-
 arch/x86/kvm/vmx/tdx.c                             | 224 +------
 arch/x86/kvm/vmx/tdx.h                             |   8 +-
 arch/x86/kvm/vmx/vmcs.h                            |  11 -
 arch/x86/kvm/vmx/vmcs_shadow_fields.h              |   5 +-
 arch/x86/kvm/vmx/vmenter.S                         |   2 +-
 arch/x86/kvm/vmx/vmx.c                             | 158 +----
 arch/x86/kvm/vmx/vmx.h                             |   3 -
 arch/x86/kvm/vmx/vmx_ops.h                         |   5 +-
 arch/x86/kvm/x86.c                                 | 473 +++++++++------
 arch/x86/kvm/x86.h                                 |  42 +-
 arch/x86/virt/Makefile                             |   2 +
 arch/x86/virt/hw.c                                 | 360 +++++++++++
 arch/x86/virt/vmx/tdx/tdx.c                        | 326 +++++-----
 arch/x86/virt/vmx/tdx/tdx.h                        |   8 -
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c        |  12 +-
 drivers/irqchip/irq-gic-v5.c                       |  18 +
 drivers/virt/coco/pkvm-guest/Kconfig               |   2 +-
 include/kvm/arm_arch_timer.h                       |   8 +-
 include/kvm/arm_pmu.h                              |   5 +-
 include/kvm/arm_vgic.h                             | 191 +++++-
 include/linux/irqchip/arm-gic-v5.h                 |  27 +
 include/linux/kvm_host.h                           |  27 +-
 include/uapi/linux/kvm.h                           |  10 +
 kernel/trace/Makefile                              |  49 +-
 kernel/trace/trace_remote.c                        |  22 +-
 tools/arch/arm64/include/uapi/asm/kvm.h            |   1 +
 tools/include/uapi/linux/kvm.h                     |   2 +
 .../selftests/ftrace/test.d/remotes/functions      |  19 +-
 .../selftests/ftrace/test.d/remotes/hotplug.tc     |  88 +++
 .../test.d/remotes/hypervisor/buffer_size.tc       |  11 +
 .../ftrace/test.d/remotes/hypervisor/hotplug.tc    |  11 +
 .../ftrace/test.d/remotes/hypervisor/reset.tc      |  11 +
 .../ftrace/test.d/remotes/hypervisor/trace.tc      |  11 +
 .../ftrace/test.d/remotes/hypervisor/trace_pipe.tc |  11 +
 .../ftrace/test.d/remotes/hypervisor/unloading.tc  |  11 +
 .../selftests/ftrace/test.d/remotes/trace.tc       |  27 +-
 .../selftests/ftrace/test.d/remotes/trace_pipe.tc  |  25 -
 tools/testing/selftests/kvm/Makefile.kvm           |  18 +-
 tools/testing/selftests/kvm/arm64/at.c             |  14 +-
 tools/testing/selftests/kvm/arm64/no-vgic-v3.c     | 177 ------
 tools/testing/selftests/kvm/arm64/no-vgic.c        | 297 +++++++++
 tools/testing/selftests/kvm/arm64/set_id_regs.c    |  52 +-
 tools/testing/selftests/kvm/arm64/vgic_v5.c        | 228 +++++++
 tools/testing/selftests/kvm/dirty_log_test.c       |   3 -
 tools/testing/selftests/kvm/guest_memfd_test.c     |  70 ++-
 tools/testing/selftests/kvm/include/arm64/gic_v5.h | 150 +++++
 tools/testing/selftests/kvm/include/kvm_syscalls.h |   1 +
 tools/testing/selftests/kvm/include/kvm_util.h     |   4 -
 .../testing/selftests/kvm/include/kvm_util_types.h |   2 +
 .../testing/selftests/kvm/include/loongarch/pmu.h  |  66 ++
 .../selftests/kvm/include/loongarch/processor.h    |  15 +
 tools/testing/selftests/kvm/include/riscv/sbi.h    |  37 ++
 .../testing/selftests/kvm/include/x86/processor.h  |  12 +
 tools/testing/selftests/kvm/include/x86/svm.h      |  14 +-
 tools/testing/selftests/kvm/kvm_page_table_test.c  |   3 -
 tools/testing/selftests/kvm/lib/kvm_util.c         |   9 +-
 .../selftests/kvm/lib/loongarch/processor.c        |  15 +-
 tools/testing/selftests/kvm/lib/memstress.c        |   4 -
 tools/testing/selftests/kvm/lib/riscv/processor.c  |   5 +
 tools/testing/selftests/kvm/lib/x86/processor.c    |  15 +-
 tools/testing/selftests/kvm/lib/x86/svm.c          |   2 +-
 tools/testing/selftests/kvm/loongarch/pmu_test.c   | 205 +++++++
 .../testing/selftests/kvm/pre_fault_memory_test.c  |   4 -
 tools/testing/selftests/kvm/riscv/sbi_pmu_test.c   |  20 +-
 .../testing/selftests/kvm/set_memory_region_test.c |   9 +-
 tools/testing/selftests/kvm/steal_time.c           |  98 ++-
 .../testing/selftests/kvm/x86/fix_hypercall_test.c |   2 +-
 tools/testing/selftests/kvm/x86/msrs_test.c        |   4 +-
 .../selftests/kvm/x86/nested_vmsave_vmload_test.c  |  16 +-
 .../selftests/kvm/x86/pmu_event_filter_test.c      |   3 +-
 .../testing/selftests/kvm/x86/sev_migrate_tests.c  |   2 -
 tools/testing/selftests/kvm/x86/state_test.c       |  35 ++
 .../selftests/kvm/x86/svm_lbr_nested_state.c       | 145 +++++
 .../selftests/kvm/x86/svm_nested_clear_efer_svme.c |  55 ++
 .../selftests/kvm/x86/svm_nested_vmcb12_gpa.c      | 176 ++++++
 tools/testing/selftests/kvm/x86/xapic_state_test.c |   2 +-
 virt/kvm/guest_memfd.c                             |   5 +-
 virt/kvm/kvm_main.c                                |  43 +-
 238 files changed, 11148 insertions(+), 3434 deletions(-)
 create mode 100644 Documentation/virt/kvm/arm/pkvm.rst
 create mode 100644 Documentation/virt/kvm/devices/arm-vgic-v5.rst
 create mode 100644 arch/arm64/include/asm/kvm_define_hypevents.h
 create mode 100644 arch/arm64/include/asm/kvm_hypevents.h
 create mode 100644 arch/arm64/include/asm/kvm_hyptrace.h
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/arm-smccc.h
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/clock.h
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/define_events.h
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/trace.h
 create mode 100644 arch/arm64/kvm/hyp/nvhe/clock.c
 create mode 100644 arch/arm64/kvm/hyp/nvhe/events.c
 create mode 100644 arch/arm64/kvm/hyp/nvhe/trace.c
 create mode 100644 arch/arm64/kvm/hyp/vgic-v5-sr.c
 create mode 100644 arch/arm64/kvm/hyp_trace.c
 create mode 100644 arch/arm64/kvm/hyp_trace.h
 create mode 100644 arch/loongarch/include/asm/kvm_dmsintc.h
 create mode 100644 arch/loongarch/kvm/intc/dmsintc.c
 create mode 100644 arch/riscv/include/asm/kvm_isa.h
 create mode 100644 arch/riscv/include/asm/kvm_vcpu_config.h
 create mode 100644 arch/riscv/kvm/isa.c
 create mode 100644 arch/riscv/kvm/vcpu_config.c
 create mode 100644 arch/x86/include/asm/virt.h
 create mode 100644 arch/x86/virt/hw.c
 create mode 100644 include/linux/ring_buffer_types.h
 create mode 100644 tools/testing/selftests/ftrace/test.d/remotes/functions
 create mode 100644 tools/testing/selftests/ftrace/test.d/remotes/hotplug.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/remotes/hypervisor/buffer_size.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/remotes/hypervisor/hotplug.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/remotes/hypervisor/reset.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/remotes/hypervisor/trace.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/remotes/hypervisor/trace_pipe.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/remotes/hypervisor/unloading.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/remotes/reset.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/remotes/trace.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/remotes/trace_pipe.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/remotes/unloading.tc
 delete mode 100644 tools/testing/selftests/kvm/arm64/no-vgic-v3.c
 create mode 100644 tools/testing/selftests/kvm/arm64/no-vgic.c
 create mode 100644 tools/testing/selftests/kvm/arm64/vgic_v5.c
 create mode 100644 tools/testing/selftests/kvm/include/arm64/gic_v5.h
 create mode 100644 tools/testing/selftests/kvm/include/loongarch/pmu.h
 create mode 100644 tools/testing/selftests/kvm/loongarch/pmu_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/svm_lbr_nested_state.c
 create mode 100644 tools/testing/selftests/kvm/x86/svm_nested_clear_efer_svme.c
 create mode 100644 tools/testing/selftests/kvm/x86/svm_nested_vmcb12_gpa.c

