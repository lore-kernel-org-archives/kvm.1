Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792601119;
	b=KfNE79XZOKe98wFBwItjgmULFr0c/LbRCFpQVLEJNNUq4PC4UVIRTeAgUor6lmFxwXOh
	 oXRsn2cUiuDHe+feO9Nri0wlPRJPlQKY36e7hOWVAOTKaErrNlNsiebib7XUxS4rN58SH
	 7yKG3UTz081mlu+lscxWrSIShEZmByAYLQSGKXvnF2pDFeiXNnsl0YNUoaBCL+I2W8xui
	 tGrUh9SH6B2KwnXqhPln9intDs/o/+OGGSGgMRNApKdXEge53JIIyKaEuzKHzEGLS27Dt
	 fE/K+4RgIXNC12iK7osKF+lOUDps0Bk7V5S4AwWqJgL6+UNal+3llY+IRsn3l/NEULw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792601119;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Scanned-By;
	bh=TGuZryCkF3+ez+vvQI2YaLgsYdJpyTfjpicnCpSu6h8=;
	b=b8bBFuQAjrPre0Thoty5m9PZVNpixI6BHHU+jlizXxNLJpmi4ycOrrqsh9P6JiQ7dQeU
	 h49cEKWgxKZt6JYC0X7b1cg8DtqRH758DBPGf26EQRHKt2ndbPGe2eeKSfZme9PErBxhU
	 BWSL6taGQ/TsF9eesrYasrkYhXtzAwLu64R7mpDRvdoU5oCwR0ic3g4ZsAsY79j5Lhdvb
	 QngES7lRB4GELf5wdnA4RaCVbnEtUXD4aEZjDlxr2c0BUyeySQdtJaxN2CwRZKUW4IiQe
	 h8OSn8cUwGBQKYfaD2IhG8cXIto5wDBOU4N0/ysDX6dpEukq9NzlSYMRqUDSwNQP9aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U+2jkUS5;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43078606A31F
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 16:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43078606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U+2jkUS5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792601117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TGuZryCkF3+ez+vvQI2YaLgsYdJpyTfjpicnCpSu6h8=;
	b=U+2jkUS55GQ2TdOtyqQYRvqzrVR7HSGYT7484mesIbBQ9NAIzXixS2uj3Jr2z6H4Dn0Q3E
	AJstGJHmlGar4zPSfFzxcdWzAqEReaEtb9wdREg2PF5l5aiM23gyx+YFVIc65YyOULL+bO
	kUJP/EuKU5L0BqvwFZlL8iLo/qk9jHk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-j8jQ13XSM32mVpFlQo3ZUQ-1; Wed,
 21 Oct 2026 16:45:14 +0000
X-MC-Unique: j8jQ13XSM32mVpFlQo3ZUQ-1
X-Mimecast-MFC-AGG-ID: j8jQ13XSM32mVpFlQo3ZUQ_1792601113
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B61019560BE;
	Wed, 21 Oct 2026 16:45:13 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 992031956087;
	Wed, 21 Oct 2026 16:45:12 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [GIT PULL] KVM updates for Linux 7.4
Date: Wed, 21 Oct 2026 12:44:42 -0400
Message-ID: <20261021164511.125947-1-pbonzini@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Linus,

The following changes since commit 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907:

  Linux 7.3-rc7 (2026-10-11 20:04:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to 164405e8e9a0378c7e1aff2254625a6553a291f1:

  KVM: always make in-place conversion a compile-time constant when possible (2026-10-21 03:28:21 -0400)

There are some arm64 changes to support inclusion of arch/arm64/include
files from s390's arch/s390/kvm/arm64/ directory, which result in a
conflict with the arm64 tree.  For sysreg.h, the resolution at end of
message is a lot more wordy than the actual intervention required; the
actual conflict is just that Catalin's pull request removed the nearby
"#ifdef CONFIG_CPU_BIG_ENDIAN" block.

There is also a patch ("arm64: Use proper include variant") that is
included here as a build fix and is duplicate with the arm tree.

Thanks,

Paolo

----------------------------------------------------------------
ARM:

- pKVM state isolation: years after pKVM started being enabled upstream,
  we finally get the basics in the form of state isolation. The vcpu state
  is now off-limit for the host for protected VMs.

- pKVM also grows a hypervisor-private memory allocator, allowing it to
  deal with sub-page allocation, much like everywhere else.

- pKVM also lands a trace_printk() equivalent, which hopefully will make
  debugging a bit easier.

- First shot at annotating portions of the KVM/arm64 code to be extracted
  and built on s390. The real fun is yet to come.

- Allow pre-faulting of stage-2 canonical mappings from userspace, joining
  x86 and s390 in implementing this feature.

- Add a reverse mapping infrastructure for shadow stage-2, significantly
  improving performance when MMU notifiers kick in, and avoiding full unmap
  of all shadow tables for this VM.

- Next step of GICv5 enablement, adding support for the IRS block, and
  providing both SPI and LPI support.  This is the first point where
  KVM/arm64 can support an SMP GICv5 guest.

- As a preliminary to eventually enabling CCA, add a bunch of
  infrastructure to KVM/arm64, splitting some of the basic operations into
  individual backends (normal VM, normal pKVM VM, protected pKVM VM).  This
  allows CCA to later slot in without polluting the rest of KVM with its
  firmware-driven nonsense.

- Make ID registers immutable from the point where a vcpu is able to run,
  even if it fails to run. This prevents KVM from sampling untrusted values.

- Restore some type checking to the EL2 object. KVM/arm64 originally had
  some strong type checking between the kernel and the EL2 object, but
  lost it along the way when the private hypercall interface was (somewhat
  pointlessly) converted to SMCCC.  Type checking is back, syscall style,
  and with added sparse goodies.

- Expand the FFA support to FFA_NOTIFICATION_*, and add some sanitisation
  of the protocol that pKVM relays to the "trusted" runtime.

- Make GICv3 RD assignment more robust to userspace nonsense

- Convert the remaining MMU fault handler backends to kvm_s2_fault_vma_info
  and co., fixing a number of bugs in the process.

- Fix the SError/SEA selftests to be both more robust and less braindead.

- Fix a smattering of documentation bugs, some of them as a result of our
  AI friends spitting out credible assertions based on non-existing symbols.

- The usual collection of low impact bug fixes (SMCCC, timers, PMU).

Loongarch:

- Add separate vmid support.

- Simplify MSI interrupt injection.

- Add crash hypercall support.

- Allow to set pv_feature until vCPU run.

- Enable HW page table walk automatically in selftests.

s390:

- rework page allocation for secure guest variable storage

- Selftests and documentation improvements.

- Replace get_zeroed_page with kzalloc.

- Fix corner cases of floating interrupt injection.

- Initial arm64 on s390 support.

x86:

- Clean up the handling of vcpu->arch.xen.long_mode to be consistent and
  correctly handle 32-bit/64-bit alignment, and various other bug fixes have
  accumulated over the months since v1.

- Grab KVM's SRCU "lock" in kvm_zap_gfn_range() to fix a recurring bug where
  callers fail to do so.

- Fix a variety of issues in the pre-fault code that are mostly benign in the
  current code base, but will show up in big ways if/when the pre-faulting
  logic is used to implementing prefetch-on-fault for the TDP MMU.

- For PREEMPT_RT=y kernels, drop the rmaps' individual bit-spinlock and just
  walk the rmaps' with mmu_lock taken.  On the write side (which always uses
  mmu_lock), the bit-spinlock was assuming that preemption was disabled, but
  that is *not* true when rwlocks become sleepable.

- Prepare a memory_fault exit (paired with -EFAULT) when KVM hits an error
  PFN, e.g. so that userspace can resolve transient issues instead of killing
  the guest.  Convert a variety of WARN()+EFAULT paths into KVM_BUG_ON()+EIO
  so that KVM can hard commit to filling memory_fault on -EFAULTs that occur
  in the page fault path.

- Fix a NX hugepage un-accounting bug where KVM would always uncharge the
  shadow MMU, even when handling TDP MMU pages.

- Mask off the address space ID when checking for illegal usage of
  kvm_set_internal_memslot() to prevent false negatives on the sanity check.

- Explicitly zero reserved flags when delivering a SynIC message to avoid
  leaking a byte of stack information to the guest.

- Rework TDX's handling of the canonical MMU root level to not rely on
  userspace to fill CPUID correctly, as doing so lets userspace trivially
  trigger a KVM_BUG_ON().

- Reject KVM_SET_NESTED_STATE if userspace "restores" L1 with EFER.LMA=1 &&
  EFER.LME=0, which confuses KVM into trying to configure an 64-bit MMU
  without PAE.

- Ignore EFER.LMA (clear it from KVM's cached save state) if EFER.LME=0 when
  preparing L2 state, to fix another way to confuse KVM's MMU (and because
  real hardware also ignores EFER.LMA).

- Improve KVM's sanity checks for a misconfigured MMU to (hopefully) detect
  all of the ways KVM can botch EFER.LMA vs. CR4.PAE.

- Remove the "full" out-param from kvm_x86_ops.flush_tlb_gva() as the param
  is only used to avoid what effectively amounts to a single memory write.

- Fix a mostly-benign bug where KVM can write through a guest's read-only
  mapping due to not checking the error code when expediting emulated MMIO
  page faults.

- Honor the guest's view of the "EFER.LMSLE must be zero" defeature so that
  userspace can provide migration compatibility between Rome and Milan+.

- Pend a KVM_REQ_EVENT request when an exception is morphed into a nested
  VM-Exit, otherwise KVM can fail to actually deliver the nested VM-Exit,
  e.g. when injecting a page fault.

- Add support for PML on SVM.

- Add support for virtualizing Bus Lock Detect on SVM, and fix a number of
  DR6 bugs and warts along the way.

- Fix a variety of warts in KVM's handling of guest TSC, kvmclock, and
  timekeeping in general, as a (big) first step towards addressing several
  longstanding problems with the kvmclock implementation.  Most notably,
  fix a precision issue where get_kvmclock_ns() computed the clock from
  the *host* TSC without applying guest TSC scaling, causing systemic
  drift from the values the guest computes from its own TSC.

- Rip out KVM's shadow timekeeping structures, now that ktime snapshots
  are powerful enough to replace it.

- Misc fixes and cleanups.

x86 (AMD):

- Fix a benign-in-practice bug where KVM unintentionally sets a non-zero
  error code when delivering exceptions to SEV-ES+ guests.

- Force a new ASID in both VMCBs on pCPU migration to fix a bug where KVM
  can run a VMCB with a stale ASID due to the tracking being per-CPU, not
  per-VMCB.

- Return INVALID_INPUT to the guest instead of exiting to userspace with
  -EIO if KVM can't access "guest request" buffer, i.e. try to keep the
  guest alive if the guest or userspace goofs.

x86 (Intel):

- Enable Notify VM-Exits (now called Instruction Timeout in the SDM) and Bus
  Lock VM-Exits for TDX guests when they're enabled by userspace (KVM forgot
  to wire up the TDX Module knobs).

- Move all common (between VMX and TDX) APIs/helpers to common.h/main.c, and
  change all namespace prefixes from "vmx" to "vt".

- Fix a thankfully benign bug (due to other areas of KVM being hardened) where
  userspace can bypass INIT_MEM_REGION's address wrap check by providing a
  nr_pages that will overflow a u64 when converted to bytes, and fix an also-
  benign off-by-one bug in the check (inclusive vs. exclusive).

- Set the vmcs.GUEST_ACTIVITY_STATE back to ACTIVE when userspace sets KVM's
  mp_state to anything other than HALTED, e.g. so that a vCPU doesn't get
  stuck in HLT if userspace emulates RESET.

guest_memfd:

- Take the invalidate lock when unbinding a dying file to fix a race with
  kvm_gmem_invalidate_end() that results in KVM leaving the MMU invalidation
  count elevated.  Not taking the lock in the first place was pure misguided
  paranoid.

- When binding a memslot, purge the bindings if storing the new memslot fails,
  as Xarray's "store range" API can subtly fail partway through.

- Establish memslot<=>guest_memfd bindings *after* the memslot is ready, as
  the memslot becomes reachable the instant the binding is installed.

- Don't grab a page refcount when reloading an SNP VMSA and stop returning a
  "struct page" from guest_memfd's PFN lookup altogether, to ensure that KVM
  doesn't hold any unnecessary refcounts (the lifetime of the page is ensured
  by MMU notifiers and similar hooks).  Preventing unnecessary refcounts
  greatly simplifies supporting in-place SHARED=>PRIVATE conversions.

- Add support for in-place PRIVATE<=>SHARED conversion, i.e. allow a single
  guest_memfd instance to be used for both PRIVATE and SHARED variations of
  CoCo guests' memory (though not at the same time).  This eliminates the need
  to double allocate guest memory for TDX and SNP, and is basically a hard
  requirement for pKVM, which relies on being able to preserve memory contents
  on conversions.

- Hack-a-fix a deadlock bug in ->error_remove_folio() by returning -EBUSY if
  the filemap invalidate lock is contended.  Punt on a proper fix for the
  moment, as a proper fix likely involves reworking truncate_error_folio().

- Add a pile of selftests for in-place conversions.

- Misc guest_memfd cleanups

Generic:

- Move some configuration items to preprocessor symbols, to help with
  arm-on-s390's need to compile the same code twice with different values.

- Allow KVM implementations to choose alternative device names, also for
  s390's support of ARM virtualmachines.

- Switch the KVM-VFIO interface and external consumers over to standard
  file-based reference counting, eliminating all external KVM symbol exports.

Selftests:

- Rework KVM selftest's handling of memory regions all so that PPC can force its
  page table allocations to be naturally aligned.

- PPC support.

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
Ackerley Tng (25):
      KVM: SEV: Treat unassigned RMP entry as benign race on PSMASH failure
      KVM: SEV: Check for invalidation before warning on unassigned RMP entry
      KVM: SEV: Drop page refcount early in VMSA reload
      KVM: Rename kvm_mem_is_private() to kvm_is_private_gfn()
      KVM: guest_memfd: Always fault from guest_memfd if in-place conversion is enabled
      KVM: guest_memfd: Pass mapping type filter to invalidation helper
      KVM: guest_memfd: Add base support for KVM_SET_MEMORY_ATTRIBUTES2
      KVM: guest_memfd: Ensure pages are not in use before conversion
      KVM: guest_memfd: Call arch make_shared callback for to-shared conversion
      KVM: guest_memfd: Return early if range already has requested attributes
      KVM: guest_memfd: Zero page while getting pfn
      KVM: TDX: Make source page optional for KVM_TDX_INIT_MEM_REGION
      KVM: selftests: Test basic single-page conversion flow
      KVM: selftests: Test conversion flow when INIT_SHARED
      KVM: selftests: Test conversion precision in guest_memfd
      KVM: selftests: Test conversion before allocation
      KVM: selftests: Convert with allocated folios in different layouts
      KVM: selftests: Test that truncation does not change shared/private status
      KVM: selftests: Add helpers to pin pages with CONFIG_GUP_TEST
      KVM: selftests: Test conversion with elevated page refcount
      KVM: selftests: Reset shared memory after hole-punching
      KVM: selftests: Provide function to look up guest_memfd details from gpa
      KVM: selftests: Make TEST_EXPECT_SIGBUS thread-safe
      KVM: selftests: Set up page size and alignment independently for guest_memfd
      KVM: selftests: Update private_mem_conversions_test for in-place conversions

Amirmohammad Eftekhar (1):
      KVM: x86: Saturate L2's TSC frequency if it exceeds hardware supports

Anish Moorthy (1):
      KVM: x86/mmu: Report a memory fault exit when the fault handler EFAULTs

Bibo Mao (8):
      LoongArch: KVM: Add vmid support for stage2 MMU
      LoongArch: KVM: Implement vmid updating logic
      LoongArch: KVM: Probe & enable separate vmid feature
      LoongArch: KVM: Remove parameter "level" when injecting MSI
      LoongArch: KVM: Remove duplicated checking with DMSI irq injection
      LoongArch: KVM: Add hypercall crash support
      LoongArch: KVM: Allow to set pv_feature until vCPU run
      KVM: LoongArch: selftests: Enable HW PTW by auto detection method

Carlos López (1):
      KVM: x86/mmu: Fix NX page unaccounting for TDP MMU pages

Chaithanya Lagisetty (5):
      KVM: selftests: Fix the never-true negative UFFD delay check
      KVM: selftests: Fix transposed calloc() arguments in the uffd helper
      KVM: selftests: Check calloc() return in vcpu_get_reg_list()
      x86/svm: Avoid sign extension of SVM_EVTINJ_VALID in 64-bit expressions
      LoongArch: KVM: Return the actual error code in kvm_ipi_create()

Chengfeng Ye (2):
      KVM: x86/xen: Mark poll_evtchn accesses with READ_ONCE()/WRITE_ONCE()
      KVM: x86: Take SRCU in kvm_zap_gfn_range()

Colton Lewis (2):
      KVM: arm64: Handle ID_AA64DFR0_EL1.PMUVer == NI in __kvm_pmu_event_mask()
      KVM: arm64: Check ID_AA64DFR0_EL1.PMUVer in pmu_visibility()

David Woodhouse (22):
      KVM: x86/xen: Rename 'longmode' to 'is_64bit' in hypercall handling
      KVM: x86/xen: Introduce kvm_xen_has_64bit_shinfo() macro
      KVM: x86/xen: Rename max_evtchn_port() to kvm_max_evtchn_port()
      KVM: x86/xen: Latch shinfo mode in kvm_xen_schedop_poll()
      KVM: x86/xen: Enforce 4-byte alignment of vcpu_info registration
      KVM: x86/xen: Use 32-bit locked bts for vcpu_info evtchn_pending_sel
      KVM: x86/xen: Take kvm->srcu in __kvm_xen_has_interrupt()
      KVM: pfncache: use a dedicated invalidation sequence for cache refresh
      KVM: x86: Improve accuracy of KVM clock when TSC scaling is in force
      KVM: x86: Explicitly disable TSC scaling without CONSTANT_TSC
      KVM: x86: Activate master clock immediately on vCPU creation
      KVM: x86: Compute kvmclock base without pvclock_gtod_data
      KVM: x86: Avoid NTP frequency skew for KVM clock on 32-bit host
      KVM: x86: Wrap all of __get_kvmclock_master_clock() with CONFIG_X86_64=y
      KVM: x86: Fall back to non-master-clock if clockread fails in get_kvmclock()
      KVM: x86: Fix KVM clock precision in get_kvmclock() with TSC scaling
      KVM: x86: Use get_kvmclock() in kvm_get_wall_clock_epoch()
      KVM: x86: Fix compute_guest_tsc() to handle negative time deltas
      KVM: x86: Upscale TSC to "now", not master clock when updating PV clocks
      KVM: x86: Simplify and comment kvm_get_time_scale()
      KVM: x86: Remove implicit rdtsc() from kvm_compute_l1_tsc_offset()
      KVM: x86: Use kernel timekeeping snapshots for getting kvmclock time since boot

Eric Farman (1):
      Documentation: Add missing KVM s390 crypto attributes

Frank Zhu (8):
      KVM: selftests: Add Zhaoxin CPU detection support
      KVM: selftests: Use host_cpu_is_intel_compatible for mediated PMU
      KVM: selftests: Add TDP detection for Zhaoxin CPUs
      KVM: selftests: Allow running invalid guest state test on Zhaoxin CPUs
      KVM: selftests: Add Zhaoxin CPU support in x86's "fix" hypercall test
      KVM: selftests: Extend Intel MSR_IA32_UCODE_REV quirk to Zhaoxin
      KVM: selftests: Add Zhaoxin CPU support to nested exceptions test
      KVM: selftests: Check for APIC access virtualization support in said test

Fuad Tabba (42):
      KVM: arm64: Fix the KVM_ARM_PREFERRED_TARGET documentation
      KVM: arm64: vgic-its: Reword the comment on a collection-less ITE
      tracing: Include linux/types.h in trace_remote_event.h
      KVM: arm64: nVHE: Share the stacktrace per-CPU declarations with EL2
      KVM: arm64: nVHE: Declare the hyp event IDs before defining them
      KVM: arm64: nVHE: Use NULL to reset the trace buffer backing pointer
      KVM: arm64: nVHE: Run the source checker under C=2
      arm64: pi: Run the source checker on the libfdt objects under C=2
      KVM: arm64: nVHE: Pass host VA arguments as pointers
      KVM: arm64: Move the host hypercall interface to its own header
      KVM: arm64: Type-check hypercall arguments at the caller
      KVM: arm64: nVHE: Check hypercall handlers against the declared ABI
      KVM: arm64: Tag host-VA hypercall parameters __kern
      KVM: arm64: Report SMCCC_VERSION and SMCCC_ARCH_FEATURES as implemented
      KVM: arm64: selftests: Check the mandatory SMCCC_ARCH_FEATURES queries
      KVM: guest_memfd: Fix the in-place conversion documentation
      KVM: arm64: selftests: Check ID regs are immutable after a failed run
      KVM: arm64: Use kvm_s2_fault_vma_info in gmem_abort()
      KVM: arm64: Sync HCR_EL2.VSE back to the host vCPU under pKVM
      KVM: arm64: Validate the host vCPU's VM before reading it under pKVM
      KVM: arm64: Pin the host vCPU before adjusting its PC under pKVM
      KVM: arm64: Disable steal time for protected VMs
      KVM: arm64: Skip fixed-feature state flush for protected vCPUs
      KVM: arm64: Add system register reset framework for protected VMs
      KVM: arm64: Implement HVC handling for protected guests at EL2
      KVM: arm64: Handle PSCI calls for protected VMs at EL2
      KVM: arm64: Restrict KVM_ARM_VCPU_INIT and PSCI version for protected VMs
      KVM: arm64: Prevent host PC adjustments for protected vCPUs
      KVM: arm64: Inject an UNDEF at EL2 for unhandled protected guest exits
      KVM: arm64: Add per-EC entry/exit state marshalling for protected guests
      KVM: arm64: Reject host access to protected VM private state
      KVM: arm64: Reject host power-on of a vCPU that EL2 holds powered off
      KVM: arm64: Advertise the capabilities that protected VMs support
      KVM: arm64: Document the protected VM userspace API
      KVM: Fix comments that refer to the non-existent VCPU_RUN ioctl
      KVM: arm64: Fix references to the non-existent VCPU_RUN ioctl
      KVM: PPC: Book3S HV: Fix comment naming a non-existent KVM_VCPU_RUN ioctl
      KVM: arm64: timers: Compute an offset-applied CVAL from the current count
      KVM: arm64: nv: Read a guest hypervisor's CNTV_CVAL_EL0 from memory on x1e
      KVM: arm64: selftests: Test a timer set past the counter's wrap
      KVM: arm64: Only emulate an SError's entry for vCPUs with NV
      KVM: arm64: selftests: Check the pending SError state in external_aborts

Furkan Caliskan (1):
      KVM: x86/xen: Convert evtchn_ports from IDR to XArray

Gabriella Seifert (1):
      KVM: s390: selftests: Add IRQ injection selftests

Gokul K (6):
      KVM: selftests: Fix the bounds of the SEV debug dst buffer check
      KVM: selftests: Free the VM when the SEV smoke test's guest completes
      KVM: selftests: Free the VM when NX hugepage disabling is denied
      KVM: selftests: Delete the declaration of vcpu_set_cpuid_maxphyaddr()
      KVM: selftests: Move test_read() into elf.c and delete lib/io.c
      KVM: selftests: Delete the unused guest_snprintf()

Hao Xiang (1):
      KVM: x86: Rename CPUID feature bit AVX10_VNNI_INT to AVX10_V1_AUX

Hao Zhang (1):
      KVM: guest_memfd: Avoid deadlock in error_remove_folio()

Haotian Jiang (1):
      KVM: TDX: Reject INIT_MEM_REGION if number of bytes would overflow a u64

Heiko Carstens (1):
      s390/uv: Rework page allocation for guest variable storage area

Hemanth Selam (3):
      KVM: arm64: Fix typo "synchonized" in comment
      KVM: arm64: selftests: Fix typos in comments
      KVM: arm64: Fix typo in pauth.c comment

Hendrik Brueckner (1):
      s390/hwcaps: Report SAE support as hwcap

Hisam Mehboob (1):
      KVM: selftests: Replace ulong with unsigned long

Hyunwoo Kim (1):
      KVM: x86/xen: Latch shinfo mode in kvm_xen_set_evtchn_fast()

Jack Thomson (3):
      KVM: arm64: Pass walk flags to kvm_pgtable_get_leaf()
      KVM: selftests: Enable pre_fault_memory_test for arm64
      KVM: selftests: Add option for different backing in pre-fault tests

Jacky Li (1):
      KVM: SEV: Return INVALID_INPUT on SNP req/resp buffer access failure

Janosch Frank (2):
      KVM: s390: Improve floating IRQ injection behavior
      KVM: s390: Kick PV cpus at the right time for service irqs

Jim Mattson (4):
      KVM: x86: Advertise EFER_LMSLE_MBZ when KVM disallows EFER.LMSLE
      KVM: x86: Honor the guest's EFER_LMSLE_MBZ
      KVM: selftests: Rename svm_nested_clear_efer_svme to svm_nested_efer_test
      KVM: selftests: Add coverage for the EFER_LMSLE_MBZ defeature

Karl Mehltretter (9):
      KVM: arm64: Fix kvm_get_vtcr() kernel-doc
      Documentation: KVM: Fix the event_source sysfs path in the PMU attribute description
      Documentation: KVM: Fix the struct kvm_arm_device_addr name
      Documentation: KVM: SEV: Use the uapi structure names
      Documentation: KVM: x86: Use struct kvm_clock_pairing in hypercalls.rst
      KVM: arm64: vgic-v3: Undo assignment on iodev registration failure
      KVM: arm64: vgic-v3: Roll back assignments from the new region
      KVM: arm64: selftests: Pass guest code to vm_gic_create_with_vcpus()
      KVM: arm64: selftests: Test VGICv3 redistributor region retry

Keqiang Duan (1):
      KVM: x86: Clear hardware HLT state when userspace makes a vCPU not-halted

Kyle Zeng (1):
      KVM: x86: Restrict saved GPA writes to hardware write faults

Like Xu (3):
      KVM: arm64: selftests: Fix EINJ handling in sea_to_user
      KVM: arm64: selftests: Skip sea_to_user without 1GB hugepages
      KVM: arm64: selftests: Skip sea_to_user when EINJ places no poison

Lisa Wang (1):
      KVM: selftests: Support guest_memfd in-place conversion

Loc Nguyen (1):
      KVM: x86: Request event processing for exception VM-Exits

Lorenzo Stoakes (ARM) (11):
      KVM: Allow architectures to disallow pre-fault
      arm64: Add ESR fault helpers
      KVM: arm64: Use ESR helpers in guest abort handling
      KVM: arm64: Propagate and use esr in s2fd when handling guest aborts
      KVM: arm64: Propagate and use mmu in s2fd when handling guest aborts
      KVM: arm64: Propagate and use kvm_s2_fault_result on S2 fault
      KVM: arm64: Size the stage-2 memcache from the fault MMU
      KVM: arm64: Propagate EHWPOISON in kvm_s2_fault_pin_pfn()
      KVM: arm64: Implement KVM_PRE_FAULT_MEMORY
      Documentation: KVM: document arm64 KVM_PRE_FAULT_MEMORY
      KVM: selftests: Add nested pre-fault test for arm64

Luka Absandze (1):
      KVM: x86/pmu: Don't retry a counter whose config was rejected

Marc Zyngier (24):
      KVM: arm64: vgic-v5: Drop __iomem attribute from {vmd,vpet}_base
      KVM: arm64: vgic-v5: Correctly reset h_lpi_ist to NULL
      KVM: arm64: vgic-v5: Tidy-up programming of vpe descriptor address
      Merge branch kvm-arm64/ffa-7.4 into kvmarm-master/next
      Merge tag 'kvmarm-fixes-7.3-1' into kvm-arm64/s2-rmap
      KVM: arm64: nv: Drop kvm_s2_mmu pointer from kvm_guest_s2_mapping
      KVM: arm64: vgic-v5: Correctly handle host ISTE __le32 conversion
      KVM: arm64: Introduce per-EC entry handlers for pKVM
      KVM: arm64: Add {flush,sync}_hyp_timer_state() primitives
      Merge branch kvm-arm64/doc-7.4 into kvmarm-master/next
      Merge branch kvm-arm64/selftests-7.4 into kvmarm-master/next
      Merge branch kvm-arm64/hyp-type-checking-7.4 into kvmarm-master/next
      Merge branch kvm-arm64/gicv5-7.4 into kvmarm-master/next
      Merge branch kvm-arm64/s2-rmap into kvmarm-master/next
      Merge branch kvm-arm64/pre-faulting into kvmarm-master/next
      Merge branch kvm-arm64/misc-7.4 into kvmarm-master/next
      Merge branch kvm-arm64/immutable-idregs-7.4 into kvmarm-master/next
      Merge branch kvm-arm64/s390-7.4 into kvmarm-master/next
      Merge branch kvm-arm64/mmu-fixes-7.4 into kvmarm-master/next
      Merge branch kvm-arm64/pkvm-state-7.4 into kvmarm-master/next
      Merge branch kvm-arm64/pkvm-allocator-7.4 into kvmarm-master/next
      Merge branch kvm-arm64/pkvm-tracing-7.4 into kvmarm-master/next
      Merge branch kvm-arm64/rd-assignment-fixes into kvmarm-master/next
      Merge branch kvm-arm64/cca-7.4 into kvmarm-master/next

Mark Brown (2):
      KVM: arm64: Finalize guest-wide sysregs prior to per-vCPU sysregs
      KVM: arm64: Block ID register changes after we rely on the values

Michael Roth (1):
      KVM: SEV: Make 'uaddr' parameter optional for KVM_SEV_SNP_LAUNCH_UPDATE

Mike Rapoport (Microsoft) (4):
      KVM: s390: Replace get_zeroed_page() with kzalloc() for sie_page2 and CMMA
      KVM: s390: Replace get_zeroed_page() with kzalloc() for the GIB
      KVM: s390: Replace get_zeroed_page() with kzalloc() for the STSI buffer
      KVM: s390: Replace get_zeroed_page() with kzalloc() for the STHYI buffer

Mikhail Malyshev (1):
      KVM: x86/mmu: Convert can't-happen fault path EFAULTs to KVM_BUG_ON() + -EIO

Nicholas Piggin (2):
      KVM: selftests: Use goto instead of do-while to retry finding unused physical pages
      KVM: PPC: selftests: add support for powerpc

Nikolay Borisov (1):
      KVM: TDX: Remove always true ifdef

Nikunj A Dadhania (7):
      KVM: x86: Move PML page to common vcpu arch structure
      KVM: x86: Carve out PML flush routine
      KVM: VMX: Use cpu_dirty_log_size instead of enable_pml for PML checks
      KVM: x86: Carve out common dirty logging update
      x86/cpufeatures: Add Page modification logging
      KVM: SVM: Use BIT_ULL for 64-bit misc_ctl bit definitions
      KVM: SVM: Add Page modification logging support

Paolo Bonzini (20):
      Merge branch 'kvm-xen-longmode' into HEAD
      KVM: x86: remove "full" out-argument from flush_tlb_gva
      Merge tag 'kvm-s390-next-7.4-1' of git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD
      KVM: uapi: remove dead #defines
      Merge tag 'kvmarm-fixes-7.3-2' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD
      Merge tag 'kvmarm-7.4' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD
      Merge tag 'loongarch-kvm-7.4' of git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson into HEAD
      Merge tag 'kvm-x86-coco-7.4' of https://github.com/kvm-x86/linux into HEAD
      Merge tag 'kvm-x86-clocks-7.4' of https://github.com/kvm-x86/linux into HEAD
      Merge tag 'kvm-x86-misc-7.4' of https://github.com/kvm-x86/linux into HEAD
      Merge tag 'kvm-x86-mmu-7.4' of https://github.com/kvm-x86/linux into HEAD
      Merge tag 'kvm-x86-selftests-7.4' of https://github.com/kvm-x86/linux into HEAD
      Merge tag 'kvm-x86-ppc_selftests-7.4' of https://github.com/kvm-x86/linux into HEAD
      Merge tag 'kvm-x86-svm-7.4' of https://github.com/kvm-x86/linux into HEAD
      Merge tag 'kvm-x86-vmx-7.4' of https://github.com/kvm-x86/linux into HEAD
      Merge tag 'kvm-s390-next-7.4-2' of git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD
      selftests: kvm: remove useless comma operator
      KVM: split CONFIG_KVM_PRIVATE_MEMATTR_VM out of KVM_VM_MEMORY_ATTRIBUTES
      KVM: x86: leave the legacy private attribute in for TDX and SEV
      KVM: always make in-place conversion a compile-time constant when possible

Ravi Bangoria (1):
      KVM: SVM: Add support for virtualizating Bus Lock Detect

Ritesh Harjani (IBM) (7):
      KVM: selftests: Don't limit LE dirty-bitmap bitops to s390x
      KVM: selftests: Move memslot_perf_test off the 256M ELF load address
      KVM: selftests: Skip the max vCPU ID test when KVM_CAP_PPC_SMT is set
      KVM: selftests: Add helper for checking if running on powerpc pseries LPAR
      KVM: selftests: Skip kvm_create_max_vcpus on powerpc pseries LPAR
      KVM: selftests: Enable access tracking perf test for PPC (with LPAR clause)
      KVM: selftests: Enable hardware disable test PPC (without pSeries LPAR)

Sascha Bischoff (48):
      irqchip/gic-v5: Allow KVM setup without a maintenance IRQ
      irqchip/gic-v5: Provide OF IRS config frame attrs to KVM
      irqchip/gic-v5: Set up gic_kvm_info on ACPI hosts
      KVM: arm64: gic-v5: Define remaining IRS MMIO registers
      arm64/sysreg: Add GICv5 GIC VDPEND encoding
      KVM: arm64: gic-v5: Cache host IRS ID registers
      KVM: arm64: gic-v5: Add VPE doorbell domain
      KVM: arm64: gic-v5: Create and manage VM and VPE tables
      KVM: arm64: gic-v5: Introduce guest IST alloc and management
      KVM: arm64: gic-v5: Implement VMT/vIST IRS MMIO Ops
      KVM: arm64: vgic: Enforce model-specific vCPU limits
      KVM: arm64: gic-v5: Implement VPE IRS MMIO Ops
      KVM: arm64: gic-v5: Set up VMTEs and VPE doorbells
      KVM: arm64: gic-v5: Add resident/non-resident hyp calls
      KVM: arm64: gic-v5: Request doorbells when VPEs enter WFI
      KVM: arm64: gic-v5: Introduce struct vgic_v5_irs and IRS base address
      KVM: arm64: gic-v5: Add IRS IODEV support to MMIO handlers
      KVM: arm64: gic-v5: Add KVM_VGIC_V5_ADDR_TYPE_IRS to UAPI
      KVM: arm64: gic-v5: Add GICv5 IRS IODEV and MMIO emulation
      KVM: arm64: gic-v5: Initialise per-VM IRS state
      KVM: arm64: gic-v5: Register the IRS IODEV
      KVM: arm64: gic-v5: Set IRICHPPIDIS based on IRS enable state
      KVM: arm64: selftests: Update vGICv5 selftest to set IRS address
      KVM: arm64: gic-v5: Add GIC VDPEND hyp call
      KVM: arm64: gic: Introduce set_pending_state() to irq_ops
      KVM: arm64: gic-v5: Support SPI injection
      Documentation: KVM: Extend VGICv5 device attribute docs
      KVM: arm64: gic-v5: Add GICv5 SPI injection to irqfd
      KVM: arm64: gic-v5: Mask per-vCPU PPI state in vgic_v5_finalize_ppi_state()
      KVM: arm64: gic-v5: Add GICv5 EL1 sysreg userspace accessors
      KVM: arm64: gic-v5: Handle userspace accesses to IRS MMIO region
      KVM: arm64: gic-v5: Add CoreSight MMIO regs to IRS
      KVM: arm64: gic-v5: Add VGICv5 IST save/restore UAPI
      KVM: arm64: gic-v5: Implement save/restore mechanisms for ISTs
      Documentation: KVM: Document KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS for VGICv5
      Documentation: KVM: Add KVM_DEV_ARM_VGIC_GRP_IRS_REGS to VGICv5 docs
      Documentation: KVM: Add docs for KVM_DEV_ARM_VGIC_GRP_IST
      Documentation: KVM: Add the VGICv5 IRS save/restore sequences
      KVM: selftests: Add VGICv5 IRS address attribute tests
      KVM: selftests: Add VGICv5 NR_IRQS attribute tests
      KVM: selftests: Add VGICv5 IRS_REGS attribute tests
      KVM: selftests: Add VGICv5 IST attribute tests
      KVM: selftests: Add VGICv5 USERSPACE_PPIS tests
      KVM: selftests: Add VGICv5 CPU sysreg attribute tests
      KVM: selftests: Add VGICv5 SPI injection tests
      KVM: selftests: Add VGICv5 LPI delivery tests
      KVM: selftests: Add VGICv5 IST save/restore coverage
      KVM: selftests: Add VGICv5 sparse vCPU IDs test

Sean Christopherson (133):
      KVM: x86/xen: Use 32-bit atomics if vCPU's evtchn_pending_sel isn't aligned
      KVM: x86/xen: Use atomic*() APIs instead of open coded equivalents
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
      KVM: x86: Update "last guest TSC" snapshot prior to enabling IRQs/preemption
      KVM: x86: Drop unnecessary CPU pinning when computing/getting kvmclock
      KVM: x86: Move "no master clock" fallback from __get_kvmclock() to get_kvmclock()
      KVM: x86: Disable preemption, not IRQs, when getting TSC+freq pair
      KVM: x86: Make master clock logic in guest PV clock updates 64-bit only
      KVM: x86: Use kernel timekeeping snapshot for monotonic clock
      KVM: x86: Use kernel timekeeping snapshot to get walltime+TSC
      KVM: x86/mmu: Reload MMU on *every* page pre-fault attempt/iteration
      KVM: x86/mmu: Harden "map private PFN" against unexpected root invalidation
      KVM: x86/mmu: Top-up memory caches when retrying "map private PFN"
      KVM: x86/mmu: Add sanity check to detect stale page faults in "map private PFN"
      KVM: x86/mmu: Always guard rmaps with mmu_lock on PREEMPT_RT=y kernels
      KVM: x86/mmu: Bug the VM if KVM attempts to unsync an upper-level shadow page
      KVM: x86: Zero reserved synic flags when delivering message to avoid stack leak
      KVM: x86: Track kvm_vcpu_arch.pending_ioapic_eoi as a u8 to drop dead BUG_ON()
      KVM: x86/mmu: Use KVM's max TDP level to determine need for 32-bit TDP root
      KVM: VMX: Explicitly track TDX VMs' root level instead of guessing it from CPUID
      KVM: VMX: Drop TDX_SHARED_BIT_PWL_{4,5} and dedup related code
      KVM: nSVM: Reject KVM_SET_NESTED_STATE if L1 has EFER.LMA=1 && EFER.LME=0
      KVM: nSVM: Ignore EFER.LMA if EFER.LME=0 when preparing L2 state
      KVM: x86/mmu: Bug the VM if KVM attempts to walk more levels than the MMU has
      KVM: x86/mmu: Bug the VM if KVM calcs a CPU role with EFER.LMA=1 && CR4.PAE=0
      KVM: x86/mmu: Convert MMU walker's bounds check from BUG_ON() to KVM_BUG_ON()
      KVM: VMX: Formally define KVM's "0xdead" exit reason used for failed VM-Enter
      KVM: VMX: Disallow using to_vmx() in common VT code
      KVM: VMX: Move the shared "IRQs off" exit handler(s) to common code
      KVM: VMX: Move the shared NMI handler/trampoline to common code
      KVM: VMX: Rename posted interrupt prefixes from "vmx" to "vt"
      KVM: VMX: Rename EPT violation handler prefix from "vmx" to "vt"
      KVM: VMX: Use dummy pseudo-overlay struct for to_vt() and vt_to_vcpu()
      KVM: VMX: Move common VT getters/converters to common.h
      KVM: VMX: Rename common exit info getters prefixes from "vmx" to "vt"
      KVM: VMX: Move bus lock handler from main.c => common.h
      KVM: TDX: Fix a benign off-by-one bug on the end GPA for INIT_MEM_REGION
      KVM: guest_memfd: Elaborate on how release() vs. get_pfn() is safe against UAF
      KVM: guest_memfd: Gracefully handle xarray errors when binding a memslot
      KVM: Use goto to handle errors during memslot preparation
      KVM: Only bind memslot to guest_memfd instance for CREATE operations
      KVM: guest_memfd: Split bind() into prepare()+commit() phases
      KVM: guest_memfd: Establish memslot<=>guest_memfd bindings *after* memslot is ready
      KVM: guest_memfd: Drop superfluous WRITE_ONCE() when binding a memslot
      KVM: SEV: Drop page refcount early during RMP fault handling
      KVM: guest_memfd: Stop returning struct page from PFN lookup
      KVM: guest_memfd: Optimize away conversion overheads via dead-code elimination
      KVM: guest_memfd: Use kvm_mem_is_private() when populating guest_memfd memory
      KVM: guest_memfd: Introduce per-gmem attributes, use to guard user mappings
      KVM: Rename KVM_GENERIC_MEMORY_ATTRIBUTES to KVM_VM_MEMORY_ATTRIBUTES
      KVM: Enumerate support for PRIVATE memory iff kvm_arch_has_private_mem is defined
      KVM: Rename memory attribute APIs to prepare for in-place gmem conversion
      KVM: Provide generic interface for checking memory private/shared status
      KVM: guest_memfd: Stub in ability to enable in-place shared<=>private conversion
      KVM: Consolidate private memory and guest_memfd ifdeffery in kvm_host.h
      KVM: guest_memfd: Invalidate both SHARED and PRIVATE mappings for in-place conversions
      KVM: Move KVM_VM_MEMORY_ATTRIBUTES config definition to x86
      KVM: Let userspace disable per-VM mem attributes, enable per-gmem attributes
      KVM: guest_memfd: Enable INIT_SHARED on guest_memfd for x86 Coco VMs
      KVM: selftests: Create gmem fd before "regular" fd when adding memslot
      KVM: selftests: Rename guest_memfd{,_offset} to gmem_{fd,offset}
      KVM: selftests: Add support for mmap() on guest_memfd in core library
      KVM: selftests: Add selftests global for guest memory attributes capability
      KVM: selftests: Add helpers for calling ioctls on guest_memfd
      KVM: selftests: Test that shared/private status is consistent across processes
      KVM: selftests: Provide common function to set memory attributes
      KVM: selftests: Update private memory exits test to work with per-gmem attributes
      KVM: VMX: Pass @vcpu, not @vmx to init_vmcs()
      KVM: x86: Preserve DR6.BLD (Bus Lock Detect) when delivering #DB payload
      KVM: x86: Rename kvm_dr6_fixed() => kvm_get_dr6_fixed_1()
      KVM: Return an "unsigned long", not "u64" for the fixed-1 DR6 bits
      KVM: x86: Force fixed-1 bits in DR6 after synchronizing with hardware
      KVM: x86: Set guest's fixed-1 DR6 bits when delivering #DB payload
      KVM: x86: Kill off DR6_FIXED_1 to prevent future misuse
      KVM: SVM: Add helper to query if LBR virtualization needs to be enabled
      KVM: nSVM: Open code check on LBR virtualization being enabled in vmcb12
      KVM: selftests: Add module param API to check if nested virtualization is enabled
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

Sebastian Ene (7):
      KVM: arm64: Forward FFA_NOTIFICATION_BITMAP calls to Trustzone
      KVM: arm64: Support FFA_NOTIFICATION_BIND in host handler
      KVM: arm64: Support FFA_NOTIFICATION_UNBIND in host handler
      KVM: arm64: Support FFA_NOTIFICATION_SET in host handler
      KVM: arm64: Support FFA_NOTIFICATION_GET in host handler
      KVM: arm64: Support FFA_NOTIFICATION_INFO_GET in host handler
      KVM: arm64: Enforce strict SBZ checks in the FF-A proxy

Shivank Garg (3):
      KVM: selftests: Fix maxnode argument to migrate_pages() in xapic_ipi_test
      KVM: selftests: use BITS_PER_TYPE() for NUMA masks
      KVM: guest_memfd: take the invalidate lock when unbinding a dying file

Shivansh Dhiman (3):
      KVM: nSVM: Disable LBRV in nested control cache when unsupported
      KVM: nSVM: Don't assume all active-low bits DR6 are fixed-1
      KVM: SVM: Add a vCPU-aware helper to get supported DEBUGCTL bits

Steffen Eiden (30):
      arm64: ptrace: Use constants for compat register numbers
      arm64: sysreg: Convert SPSR_ELx to automatic register generation
      KVM: arm64: Access elements of vcpu_gp_regs individually
      KVM: arm64: Use accessor functions for core regs
      arm64: Prepare sharing arm64 headers with s390
      arm64: Share arm64 headers with s390
      KVM: arm64: Share arm64 code with s390
      KVM: Introduce file_to_kvm_<arch>() infrastructure
      KVM: Add file back-pointer to struct kvm
      KVM: x86: Use file_to_kvm_x86() in SEV
      KVM/vfio: Use file-based reference counting for KVM
      KVM: Restrict kvm_get_kvm/kvm_put_kvm export to internal KVM modules
      KVM: Remove unused file_is_kvm
      KVM: Make device name configurable
      KVM: Move architecture capability Kconfigs to header defines
      KVM: Replace CONFIG_KVM_MMIO with __KVM_NO_MMIO
      s390/Kconfig: remove PCI dependency from HAS_IOMEM
      KVM: s390: Use dedicated function for migration mode
      s390/tools: Use arm64 headers
      KVM: s390: Use arm64 code
      s390: Introduce Start Arm Execution instruction
      KVM: s390: arm64: Introduce host definitions
      KVM: s390: Add basic arm64 kvm module
      KVM: s390: arm64: Implement required functions
      KVM: s390: arm64: Implement vm/vcpu create destroy
      KVM: s390: arm64: Implement vCPU IOCTLs
      KVM: s390: arm64: Implement basic page fault handler
      KVM: s390: arm64: Integrate arm on s390
      MAINTAINERS: Add entry for ARM on s390 KVM
      arm64: Use proper include variant

Steven Price (1):
      KVM: arm64: Avoid including linux/kvm_host.h in kvm_pgtable.h

Suzuki K Poulose (12):
      KVM: arm64: protected VM: Handle user writes to CNTVCT_EL0/CNTPCT_EL0
      KVM: arm64: Include kvm_emulate.h in kvm/arm_psci.h
      KVM: arm64: Track the type of VM in kvm_arch
      KVM: arm64: Don't call vcpu_set_pauth_traps for pKVM host
      KVM: arm64: Refactor the vcpu_load to allow for VM specific callbacks
      KVM: arm64: Add vcpu load/put call backs for flavors
      KVM: arm64: Consolidate stage2 unmap range into kvm_stage2_unmap_range
      KVM: arm64: Add VM specific callback for S2 MMU operations
      KVM: arm64: Use a local kvm pointer in kvm_handle_guest_abort()
      KVM: arm64: Abstract out memory abort handling
      KVM: arm64: Mandate VGIC v3 for pKVM VMs and Realms
      KVM: arm64: Prevent unsupported vcpu features for VM types

Tharit Tangkijwanichakul (3):
      KVM: x86: Reject reserved CR8 bits in KVM_SET_SREGS
      KVM: selftests: Add CR8 reserved-bit checks to set_sregs_test
      KVM: arm64: selftests: Fix VM leak in early return

Vincent Donnefort (30):
      KVM: arm64: Disable stage-2 ptdump of pKVM
      KVM: arm64: Remove PAGE_SIZE alignment for hyp event ELF sections
      KVM: arm64: Fix MMFR0 TGRAN advertisement for pVMs
      KVM: arm64: Pass kvm_s2_fault_desc to fault_supports_stage2_huge_mapping()
      KVM: arm64: Use kvm_s2_fault_vma_info in pkvm_mem_abort()
      KVM: arm64: Add pkvm_private_va_range_pa
      KVM: arm64: Add pkvm_remove_mappings
      KVM: arm64: Add pkvm_map_private_va_range
      KVM: arm64: Add a heap allocator for the pKVM hyp
      KVM: arm64: Allow kvm_hyp_memcache usage outside of stage-2
      KVM: arm64: Add pkvm_hyp_req infrastructure
      KVM: arm64: Add PKVM_HYP_REQ_HYP_ALLOC request
      KVM: arm64: Add reclaim interface for the pKVM heap alloc
      KVM: arm64: Add selftests for the pKVM heap allocator
      KVM: arm64: Add a shrinker for pKVM
      KVM: arm64: Filter out non-kernel addresses in kern_hyp_va
      KVM: arm64: Move hyp_vm refcount into the structure
      KVM: arm64: Alloc pkvm_hyp_vm using pKVM heap allocator
      KVM: arm64: Alloc pkvm_hyp_vcpu using pKVM heap allocator
      KVM: arm64: Rename vCPU pkvm_memcache to stage2_mc
      KVM: arm64: Reject hyp trace descriptors with fewer CPUs than hyp_nr_cpus
      KVM: arm64: Reject hyp trace descriptors with fewer than 3 pages
      KVM: arm64: Alloc simple_buffer_page using pKVM hyp allocator
      KVM: arm64: Allow early calls to pKVM host_share/unshare_hyp
      KVM: arm64: Move kvm_define_hypevents.h to arch/arm64/kvm/
      tracing/remotes: Add REMOTE_EVENT_CUSTOM_PRINTK() helper
      KVM: arm64: Add hyp_printk event to nVHE/pKVM hyp
      KVM: arm64: pkvm: Drop keneldoc markers for the allocator structs
      KVM: arm64: Prevent 64-bit overflow when computing hyp clock rate
      KVM: arm64: Fix bpages backing allocation size in hyp_trace

Vitaly Kuznetsov (4):
      KVM: nVMX: Make VMPTRLD result in #UD when eVMCS is used
      KVM: nVMX: Make VMPTRST return eVMCS GPA when it is used
      KVM: selftests: Adapt to the updated VMPTRST behavior when eVMCS is used
      KVM: selftests: Check VMPTRLD with active eVMCS

Wei-Lin Chang (8):
      KVM: arm64: Use a variable for the canonical IPA in kvm_s2_fault_map()
      KVM: arm64: nv: Introduce guest stage-2 tracking structures
      KVM: arm64: nv: Track guest stage-2 mapping removal
      KVM: arm64: nv: Track guest stage-2 mapping creation
      KVM: arm64: nv: Avoid full shadow stage-2 unmap
      KVM: arm64: Refactor kvm_unmap_gfn_range() with common variables
      KVM: arm64: ptdump: Check the page tables aren't freed when accessing
      KVM: arm64: ptdump: Fix shadow ptdump sleep-in-atomic-context problem

Xiaoyao Li (9):
      KVM: TDX: Enable Notify VM exit
      KVM: TDX: Check if there is valid exit infos based on vp_enter_ret
      KVM: TDX: Set bits 31:16 to 0 and use UNDEFINED when synthesizing exit reason
      KVM: TDX: Don't assume exit_reason[31:16] is all-0 in tdx_to_vmx_exit_reason()
      KVM: TDX: Stuff exit_reason with UNDEFINED on wait_for_sept_zap return
      KVM: VMX: Preserve negative return value in vmx_handle_exit() with bus lock detected
      KVM: VMX: Make handle_bus_lock_vmexit() a shared helper
      KVM: TDX: Enable Bus Lock VM exit
      KVM: VMX: Consolidate the exit handler for VMX and TDX

Yosry Ahmed (1):
      KVM: SVM: Trigger new ASID allocation in both VMCBs on pCPU switch

Zeng Chi (1):
      KVM: Mask off the address space ID in kvm_set_internal_memslot() check

 Documentation/admin-guide/kernel-parameters.txt    |   26 +
 Documentation/virt/kvm/api.rst                     |  208 ++-
 Documentation/virt/kvm/arm/fw-pseudo-registers.rst |    2 +
 Documentation/virt/kvm/arm/pkvm.rst                |  164 +-
 Documentation/virt/kvm/devices/arm-vgic-v5.rst     |  271 ++-
 Documentation/virt/kvm/devices/vcpu.rst            |    5 +-
 Documentation/virt/kvm/devices/vm.rst              |   18 +
 .../virt/kvm/x86/amd-memory-encryption.rst         |   22 +-
 Documentation/virt/kvm/x86/hypercalls.rst          |    2 +-
 Documentation/virt/kvm/x86/intel-tdx.rst           |    4 +
 MAINTAINERS                                        |   19 +
 arch/arm64/Makefile                                |    3 +
 arch/arm64/include/asm/brk-imm.h                   |    1 +
 arch/arm64/include/asm/esr.h                       |   34 +-
 arch/arm64/include/asm/kvm_arm.h                   |    6 +-
 arch/arm64/include/asm/kvm_asm.h                   |   11 +-
 arch/arm64/include/asm/kvm_emulate.h               |  124 +-
 arch/arm64/include/asm/kvm_hcall.h                 |  258 +++
 arch/arm64/include/asm/kvm_host.h                  |  301 ++--
 arch/arm64/include/asm/kvm_hyp.h                   |    7 +
 arch/arm64/include/asm/kvm_hypevents.h             |   14 +
 arch/arm64/include/asm/kvm_hyptrace.h              |    9 +
 arch/arm64/include/asm/kvm_mmu.h                   |   19 +-
 arch/arm64/include/asm/kvm_nested.h                |    7 +
 arch/arm64/include/asm/kvm_pgtable.h               |   17 +-
 arch/arm64/include/asm/kvm_pkvm.h                  |  152 +-
 arch/arm64/include/asm/ptrace.h                    |   64 +-
 arch/arm64/include/asm/stacktrace/nvhe.h           |   10 +-
 arch/arm64/include/asm/sysreg.h                    |   35 +-
 arch/arm64/include/uapi/asm/kvm.h                  |   15 +
 arch/arm64/kernel/image-vars.h                     |    1 +
 arch/arm64/kernel/pi/Makefile                      |    1 +
 arch/arm64/kernel/vmlinux.lds.S                    |   10 +-
 arch/arm64/kvm/Kconfig                             |    5 +-
 arch/arm64/kvm/Makefile                            |    3 +-
 arch/arm64/kvm/arch_timer.c                        |   39 +-
 arch/arm64/kvm/arm.c                               |  359 +++-
 .../define_hypevents.h}                            |    0
 arch/arm64/kvm/guest.c                             |   33 +-
 arch/arm64/kvm/hyp/entry.S                         |    2 +-
 arch/arm64/kvm/hyp/exception.c                     |   30 +-
 arch/arm64/kvm/hyp/hyp-constants.c                 |    2 -
 arch/arm64/kvm/hyp/include/hyp/adjust_pc.h         |   52 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h            |    4 +-
 arch/arm64/kvm/hyp/include/nvhe/alloc.h            |   28 +
 arch/arm64/kvm/hyp/include/nvhe/define_events.h    |    2 -
 arch/arm64/kvm/hyp/include/nvhe/mm.h               |    3 +
 arch/arm64/kvm/hyp/include/nvhe/pkvm.h             |   40 +-
 arch/arm64/kvm/hyp/include/nvhe/spinlock.h         |    4 +
 arch/arm64/kvm/hyp/include/nvhe/trace.h            |   71 +-
 arch/arm64/kvm/hyp/nvhe/Makefile                   |    3 +-
 arch/arm64/kvm/hyp/nvhe/alloc.c                    | 1212 +++++++++++++
 arch/arm64/kvm/hyp/nvhe/events.c                   |    8 +
 arch/arm64/kvm/hyp/nvhe/ffa.c                      |  220 ++-
 arch/arm64/kvm/hyp/nvhe/hyp-main.c                 | 1173 +++++++++---
 arch/arm64/kvm/hyp/nvhe/hyp.lds.S                  |    1 -
 arch/arm64/kvm/hyp/nvhe/mem_protect.c              |   20 +-
 arch/arm64/kvm/hyp/nvhe/mm.c                       |   79 +-
 arch/arm64/kvm/hyp/nvhe/pkvm.c                     |  507 +++++-
 arch/arm64/kvm/hyp/nvhe/setup.c                    |    6 +
 arch/arm64/kvm/hyp/nvhe/stacktrace.c               |    3 +-
 arch/arm64/kvm/hyp/nvhe/switch.c                   |   29 +-
 arch/arm64/kvm/hyp/nvhe/sys_regs.c                 |   63 +
 arch/arm64/kvm/hyp/nvhe/trace.c                    |   76 +-
 arch/arm64/kvm/hyp/pgtable.c                       |    6 +-
 arch/arm64/kvm/hyp/vgic-v5-sr.c                    |   45 +
 arch/arm64/kvm/hyp/vhe/switch.c                    |   21 +-
 arch/arm64/kvm/hyp_trace.c                         |   90 +-
 arch/arm64/kvm/hypercalls.c                        |   11 +
 arch/arm64/kvm/inject_fault.c                      |   10 +-
 arch/arm64/kvm/mmio.c                              |    3 +
 arch/arm64/kvm/mmu.c                               |  783 ++++++--
 arch/arm64/kvm/nested.c                            |  155 +-
 arch/arm64/kvm/pauth.c                             |    2 +-
 arch/arm64/kvm/pkvm.c                              |  226 ++-
 arch/arm64/kvm/pmu-emul.c                          |    5 +-
 arch/arm64/kvm/psci.c                              |   11 +-
 arch/arm64/kvm/ptdump.c                            |   79 +-
 arch/arm64/kvm/pvtime.c                            |   10 +-
 arch/arm64/kvm/stacktrace.c                        |    3 -
 arch/arm64/kvm/sys_regs.c                          |   69 +-
 arch/arm64/kvm/sys_regs.h                          |    2 +-
 arch/arm64/kvm/trace_pkvm.h                        |   45 +
 arch/arm64/kvm/vgic-sys-reg-v5.c                   |  519 ++++++
 arch/arm64/kvm/vgic/vgic-init.c                    |  162 +-
 arch/arm64/kvm/vgic/vgic-irqfd.c                   |   18 +-
 arch/arm64/kvm/vgic/vgic-irs-v5.c                  | 1217 +++++++++++++
 arch/arm64/kvm/vgic/vgic-its.c                     |    6 +-
 arch/arm64/kvm/vgic/vgic-kvm-device.c              |  272 ++-
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                 |   33 +-
 arch/arm64/kvm/vgic/vgic-mmio.c                    |    6 +
 arch/arm64/kvm/vgic/vgic-mmio.h                    |    2 +
 arch/arm64/kvm/vgic/vgic-v5-tables.c               | 1872 ++++++++++++++++++++
 arch/arm64/kvm/vgic/vgic-v5-tables.h               |  140 ++
 arch/arm64/kvm/vgic/vgic-v5.c                      | 1152 +++++++++++-
 arch/arm64/kvm/vgic/vgic.c                         |   39 +-
 arch/arm64/kvm/vgic/vgic.h                         |   21 +
 arch/arm64/tools/sysreg                            |   51 +
 arch/loongarch/include/asm/kvm_dmsintc.h           |    3 +-
 arch/loongarch/include/asm/kvm_host.h              |   17 +-
 arch/loongarch/include/asm/kvm_para.h              |    3 +
 arch/loongarch/include/asm/kvm_pch_pic.h           |    2 +-
 arch/loongarch/include/asm/loongarch.h             |    5 +
 arch/loongarch/include/uapi/asm/kvm.h              |    1 +
 arch/loongarch/include/uapi/asm/kvm_para.h         |    1 +
 arch/loongarch/kernel/asm-offsets.c                |    1 +
 arch/loongarch/kernel/cpu-probe.c                  |    4 +
 arch/loongarch/kvm/Kconfig                         |    3 -
 arch/loongarch/kvm/exit.c                          |   11 +
 arch/loongarch/kvm/intc/dmsintc.c                  |   38 +-
 arch/loongarch/kvm/intc/ipi.c                      |    7 +-
 arch/loongarch/kvm/intc/pch_pic.c                  |    6 +-
 arch/loongarch/kvm/irqfd.c                         |    4 +-
 arch/loongarch/kvm/main.c                          |   71 +-
 arch/loongarch/kvm/mmu.c                           |   25 +-
 arch/loongarch/kvm/switch.S                        |    5 +-
 arch/loongarch/kvm/tlb.c                           |   23 +-
 arch/loongarch/kvm/vcpu.c                          |   15 +-
 arch/loongarch/kvm/vm.c                            |    2 +
 arch/mips/include/asm/kvm_host.h                   |    1 +
 arch/mips/kvm/Kconfig                              |    2 -
 arch/powerpc/include/asm/kvm_host.h                |    7 +
 arch/powerpc/kvm/Kconfig                           |    5 -
 arch/powerpc/kvm/book3s_hv.c                       |    2 +-
 arch/riscv/include/asm/kvm_host.h                  |    2 +
 arch/riscv/kvm/Kconfig                             |    3 -
 arch/s390/Kconfig                                  |    5 +-
 arch/s390/include/arm64/kvm_emulate.h              |  130 ++
 arch/s390/include/arm64/kvm_nested.h               |   11 +
 arch/s390/include/arm64/ptrace.h                   |   11 +
 arch/s390/include/arm64/sysreg.h                   |   13 +
 arch/s390/include/asm/asm-prototypes.h             |    1 +
 arch/s390/include/asm/elf.h                        |    2 +
 arch/s390/include/asm/io.h                         |   12 +-
 arch/s390/include/asm/kvm.h                        |    6 +
 arch/s390/include/asm/kvm_host.h                   |    4 +
 arch/s390/include/asm/kvm_host_arm64.h             |  209 +++
 arch/s390/include/asm/kvm_host_arm64_types.h       |  124 ++
 arch/s390/include/asm/kvm_host_s390.h              |    9 +-
 arch/s390/include/asm/kvm_host_types.h             |    4 +
 arch/s390/include/asm/sae.h                        |   49 +
 arch/s390/include/asm/sclp.h                       |    5 +-
 arch/s390/include/asm/stacktrace.h                 |    5 +
 arch/s390/include/uapi/Kbuild                      |    6 +
 arch/s390/kernel/asm-offsets.c                     |    1 +
 arch/s390/kernel/entry.S                           |   22 +
 arch/s390/kernel/processor.c                       |    3 +
 arch/s390/kernel/uv.c                              |   41 +-
 arch/s390/kvm/Kconfig                              |   23 +-
 arch/s390/kvm/Makefile                             |    1 +
 arch/s390/kvm/arm64/.gitignore                     |    2 +
 arch/s390/kvm/arm64/Makefile                       |  110 ++
 arch/s390/kvm/arm64/Makefile.gen                   |   28 +
 arch/s390/kvm/arm64/arm.c                          |  754 ++++++++
 arch/s390/kvm/arm64/arm.h                          |   58 +
 arch/s390/kvm/arm64/copy-arm64c.awk                |   82 +
 arch/s390/kvm/arm64/guest.c                        |  135 ++
 arch/s390/kvm/arm64/handle_exit.c                  |  161 ++
 arch/s390/kvm/arm64/handle_exit.h                  |    9 +
 arch/s390/kvm/arm64/inject_fault.c                 |   21 +
 arch/s390/kvm/arm64/mmio.c                         |   15 +
 arch/s390/kvm/arm64/mmu.c                          |  210 +++
 arch/s390/kvm/arm64/reset.c                        |   71 +
 arch/s390/kvm/arm64/trace.h                        |  101 ++
 arch/s390/kvm/gmap/faultin.c                       |    5 +
 arch/s390/kvm/gmap/gmap.c                          |    4 +
 arch/s390/kvm/gmap/kvm_mmu.c                       |    6 +-
 arch/s390/kvm/gmap/trace_gmap.h                    |   17 +-
 arch/s390/kvm/s390/Makefile                        |    2 +-
 arch/s390/kvm/s390/intercept.c                     |   32 +-
 arch/s390/kvm/s390/interrupt.c                     |  130 +-
 arch/s390/kvm/s390/pci.c                           |    9 +-
 arch/s390/kvm/s390/priv.c                          |   19 +-
 arch/s390/kvm/s390/s390.c                          |   23 +-
 arch/s390/kvm/s390/s390.h                          |    1 +
 arch/s390/tools/Makefile                           |    6 +-
 arch/s390/tools/Makefile.arm64h                    |   55 +
 arch/s390/tools/copy-arm64h-full.awk               |   50 +
 arch/s390/tools/copy-arm64h.awk                    |   83 +
 arch/s390/tools/opcodes.txt                        |    3 +
 arch/x86/include/asm/cpufeatures.h                 |    1 +
 arch/x86/include/asm/kvm-x86-ops.h                 |    3 +-
 arch/x86/include/asm/kvm_host.h                    |   40 +-
 arch/x86/include/asm/kvm_page_track.h              |   10 +-
 arch/x86/include/asm/svm.h                         |   18 +-
 arch/x86/include/asm/vmx.h                         |    8 +
 arch/x86/include/uapi/asm/kvm.h                    |    2 -
 arch/x86/include/uapi/asm/svm.h                    |    2 +
 arch/x86/kernel/cpu/scattered.c                    |    1 +
 arch/x86/kvm/Kconfig                               |   21 +-
 arch/x86/kvm/Makefile                              |    4 +-
 arch/x86/kvm/cpuid.c                               |   37 +-
 arch/x86/kvm/cpuid.h                               |    1 -
 arch/x86/kvm/hyperv.c                              |    9 +-
 arch/x86/kvm/kvm_emulate.h                         |    4 +-
 arch/x86/kvm/lapic.c                               |    4 +-
 arch/x86/kvm/lapic.h                               |    2 +-
 arch/x86/kvm/mmu/mmu.c                             |  194 +-
 arch/x86/kvm/mmu/page_track.c                      |   22 +-
 arch/x86/kvm/mmu/paging_tmpl.h                     |   21 +-
 arch/x86/kvm/msrs.c                                |   15 +-
 arch/x86/kvm/pmu.c                                 |   14 +-
 arch/x86/kvm/regs.c                                |   16 +-
 arch/x86/kvm/regs.h                                |   11 +-
 arch/x86/kvm/reverse_cpuid.h                       |    2 +-
 arch/x86/kvm/svm/nested.c                          |   47 +-
 arch/x86/kvm/svm/sev.c                             |  118 +-
 arch/x86/kvm/svm/svm.c                             |  193 +-
 arch/x86/kvm/svm/svm.h                             |   13 +-
 arch/x86/kvm/vmx/common.h                          |   90 +-
 arch/x86/kvm/vmx/main.c                            |  153 +-
 arch/x86/kvm/vmx/nested.c                          |   60 +-
 arch/x86/kvm/vmx/posted_intr.c                     |   24 +-
 arch/x86/kvm/vmx/posted_intr.h                     |    8 +-
 arch/x86/kvm/vmx/tdx.c                             |  143 +-
 arch/x86/kvm/vmx/vmx.c                             |  309 +---
 arch/x86/kvm/vmx/vmx.h                             |   46 +-
 arch/x86/kvm/vmx/x86_ops.h                         |    6 +-
 arch/x86/kvm/x86.c                                 |  703 ++++----
 arch/x86/kvm/x86.h                                 |   13 +-
 arch/x86/kvm/xen.c                                 |  212 ++-
 arch/x86/kvm/xen.h                                 |    5 +
 drivers/irqchip/irq-gic-v5-irs.c                   |   19 +-
 drivers/irqchip/irq-gic-v5.c                       |  111 +-
 drivers/s390/char/sclp_early.c                     |    1 +
 drivers/s390/crypto/vfio_ap_ops.c                  |   20 +-
 drivers/vfio/device_cdev.c                         |    2 +-
 drivers/vfio/group.c                               |   13 +-
 drivers/vfio/vfio.h                                |   14 +-
 drivers/vfio/vfio_main.c                           |   57 +-
 include/kvm/arm_arch_timer.h                       |   15 +
 include/kvm/arm_psci.h                             |    2 +
 include/kvm/arm_vgic.h                             |  213 ++-
 include/linux/irqchip/arm-gic-v5.h                 |  254 ++-
 include/linux/irqchip/arm-vgic-info.h              |    5 +
 include/linux/kvm_host.h                           |  136 +-
 include/linux/trace_remote_event.h                 |    2 +
 include/linux/vfio.h                               |    5 +-
 include/trace/define_remote_events.h               |   19 +-
 include/trace/events/kvm.h                         |   14 +-
 include/uapi/linux/kvm.h                           |   16 +
 tools/arch/arm64/include/uapi/asm/kvm.h            |   15 +
 tools/arch/x86/include/uapi/asm/kvm.h              |    2 -
 tools/testing/selftests/kvm/Makefile               |    2 +-
 tools/testing/selftests/kvm/Makefile.kvm           |   16 +-
 .../selftests/kvm/access_tracking_perf_test.c      |   10 +
 .../selftests/kvm/arm64/arch_timer_edge_cases.c    |   25 +
 .../testing/selftests/kvm/arm64/debug-exceptions.c |    2 +-
 .../testing/selftests/kvm/arm64/external_aborts.c  |   23 +-
 tools/testing/selftests/kvm/arm64/hypercalls.c     |   33 +-
 .../selftests/kvm/arm64/nv_pre_fault_memory_test.c |  158 ++
 .../testing/selftests/kvm/arm64/page_fault_test.c  |   18 +-
 tools/testing/selftests/kvm/arm64/sea_to_user.c    |   75 +-
 tools/testing/selftests/kvm/arm64/set_id_regs.c    |  106 +-
 tools/testing/selftests/kvm/arm64/vgic_init.c      |  116 +-
 tools/testing/selftests/kvm/arm64/vgic_its_save.c  |    8 +-
 .../testing/selftests/kvm/arm64/vgic_lpi_stress.c  |   21 +-
 tools/testing/selftests/kvm/arm64/vgic_v5.c        | 1849 ++++++++++++++++++-
 tools/testing/selftests/kvm/demand_paging_test.c   |    3 +-
 tools/testing/selftests/kvm/dirty_log_test.c       |   12 +-
 tools/testing/selftests/kvm/guest_memfd_test.c     |    2 +-
 .../testing/selftests/kvm/hardware_disable_test.c  |    3 +
 tools/testing/selftests/kvm/include/arm64/gic_v5.h |  105 ++
 tools/testing/selftests/kvm/include/kvm_util.h     |  271 ++-
 .../selftests/kvm/include/loongarch/processor.h    |    3 +
 tools/testing/selftests/kvm/include/numaif.h       |   43 +
 .../testing/selftests/kvm/include/powerpc/hcall.h  |   17 +
 .../selftests/kvm/include/powerpc/kvm_util_arch.h  |   22 +
 .../selftests/kvm/include/powerpc/ppc_asm.h        |   32 +
 .../selftests/kvm/include/powerpc/processor.h      |   39 +
 .../testing/selftests/kvm/include/powerpc/ucall.h  |   21 +
 tools/testing/selftests/kvm/include/test_util.h    |   38 +-
 tools/testing/selftests/kvm/include/x86/evmcs.h    |   78 +-
 .../testing/selftests/kvm/include/x86/processor.h  |   27 +-
 tools/testing/selftests/kvm/include/x86/smm.h      |    2 +-
 tools/testing/selftests/kvm/include/x86/vmx.h      |  186 +-
 tools/testing/selftests/kvm/kvm_create_max_vcpus.c |   14 +-
 tools/testing/selftests/kvm/lib/arm64/processor.c  |    4 +-
 tools/testing/selftests/kvm/lib/elf.c              |   48 +-
 tools/testing/selftests/kvm/lib/guest_modes.c      |   20 +-
 tools/testing/selftests/kvm/lib/guest_sprintf.c    |   12 -
 tools/testing/selftests/kvm/lib/io.c               |  157 --
 tools/testing/selftests/kvm/lib/kvm_util.c         |  373 ++--
 .../selftests/kvm/lib/loongarch/processor.c        |   21 +-
 tools/testing/selftests/kvm/lib/powerpc/handlers.S |   93 +
 tools/testing/selftests/kvm/lib/powerpc/hcall.c    |   45 +
 .../testing/selftests/kvm/lib/powerpc/processor.c  |  512 ++++++
 tools/testing/selftests/kvm/lib/powerpc/ucall.c    |   22 +
 tools/testing/selftests/kvm/lib/riscv/processor.c  |    4 +-
 tools/testing/selftests/kvm/lib/s390/processor.c   |    7 +-
 tools/testing/selftests/kvm/lib/test_util.c        |   22 +-
 tools/testing/selftests/kvm/lib/userfaultfd_util.c |    6 +-
 tools/testing/selftests/kvm/lib/x86/memstress.c    |    8 +-
 tools/testing/selftests/kvm/lib/x86/processor.c    |   23 +-
 tools/testing/selftests/kvm/lib/x86/vmx.c          |  159 +-
 tools/testing/selftests/kvm/memslot_perf_test.c    |    7 +-
 .../testing/selftests/kvm/pre_fault_memory_test.c  |  150 +-
 tools/testing/selftests/kvm/s390/cmma_test.c       |   19 +-
 tools/testing/selftests/kvm/s390/irq_injection.c   |   74 +
 tools/testing/selftests/kvm/s390/irq_routing.c     |    2 +-
 .../testing/selftests/kvm/set_memory_region_test.c |    8 +-
 tools/testing/selftests/kvm/steal_time.c           |   20 +-
 tools/testing/selftests/kvm/x86/amx_test.c         |    2 +-
 tools/testing/selftests/kvm/x86/aperfmperf_test.c  |   10 +-
 tools/testing/selftests/kvm/x86/cpuid_test.c       |    2 +-
 .../selftests/kvm/x86/evmcs_smm_controls_test.c    |    6 +-
 .../testing/selftests/kvm/x86/feature_msrs_test.c  |    2 +-
 .../testing/selftests/kvm/x86/fix_hypercall_test.c |    2 +-
 .../kvm/x86/guest_memfd_conversions_test.c         |  512 ++++++
 tools/testing/selftests/kvm/x86/hyperv_clock.c     |    2 +-
 tools/testing/selftests/kvm/x86/hyperv_evmcs.c     |   87 +-
 tools/testing/selftests/kvm/x86/hyperv_svm_test.c  |    2 +-
 tools/testing/selftests/kvm/x86/kvm_buslock_test.c |    8 +-
 .../selftests/kvm/x86/nested_close_kvm_test.c      |    6 +-
 .../selftests/kvm/x86/nested_dirty_log_test.c      |    8 +-
 .../selftests/kvm/x86/nested_emulation_test.c      |   23 +-
 .../selftests/kvm/x86/nested_exceptions_test.c     |   33 +-
 .../selftests/kvm/x86/nested_invalid_cr3_test.c    |   14 +-
 .../selftests/kvm/x86/nested_tdp_fault_test.c      |   16 +-
 .../selftests/kvm/x86/nested_tsc_adjust_test.c     |   10 +-
 .../selftests/kvm/x86/nested_tsc_scaling_test.c    |  244 ++-
 .../testing/selftests/kvm/x86/nested_x2apic_test.c |   40 +-
 .../testing/selftests/kvm/x86/nx_huge_pages_test.c |    3 +-
 .../kvm/x86/private_mem_conversions_test.c         |   66 +-
 .../selftests/kvm/x86/private_mem_kvm_exits_test.c |   36 +-
 .../kvm/x86/save_restore_pf_stress_test.c          |   14 +-
 tools/testing/selftests/kvm/x86/set_boot_cpu_id.c  |    2 +-
 tools/testing/selftests/kvm/x86/set_sregs_test.c   |   11 +
 tools/testing/selftests/kvm/x86/sev_dbg_test.c     |    6 +-
 tools/testing/selftests/kvm/x86/sev_smoke_test.c   |    3 +-
 .../kvm/x86/smaller_maxphyaddr_emulation_test.c    |    9 +-
 tools/testing/selftests/kvm/x86/smm_test.c         |    4 +-
 tools/testing/selftests/kvm/x86/state_test.c       |   74 +-
 .../selftests/kvm/x86/svm_nested_clear_efer_svme.c |   50 -
 .../selftests/kvm/x86/svm_nested_efer_test.c       |  266 +++
 .../selftests/kvm/x86/triple_fault_event_test.c    |    8 +-
 tools/testing/selftests/kvm/x86/tsc_msrs_test.c    |    2 +-
 .../selftests/kvm/x86/vmx_apic_access_test.c       |   22 +-
 .../selftests/kvm/x86/vmx_apicv_updates_test.c     |   16 +-
 .../x86/vmx_exception_with_invalid_guest_state.c   |    2 +-
 .../kvm/x86/vmx_invalid_nested_guest_state.c       |   12 +-
 .../selftests/kvm/x86/vmx_nested_la57_state_test.c |   12 +-
 .../selftests/kvm/x86/vmx_preemption_timer_test.c  |   28 +-
 tools/testing/selftests/kvm/x86/xapic_ipi_test.c   |   78 +-
 virt/kvm/Kconfig                                   |   24 +-
 virt/kvm/Makefile.kvm                              |    9 +-
 virt/kvm/async_pf.c                                |    5 +-
 virt/kvm/coalesced_mmio.c                          |    4 +
 virt/kvm/coalesced_mmio.h                          |    2 +-
 virt/kvm/eventfd.c                                 |    3 +-
 virt/kvm/guest_memfd.c                             |  649 +++++--
 virt/kvm/guest_memfd.h                             |   19 +-
 virt/kvm/kvm_main.c                                |  247 ++-
 virt/kvm/pfncache.c                                |   18 +-
 virt/kvm/vfio.c                                    |   13 +-
 355 files changed, 23657 insertions(+), 3996 deletions(-)
 create mode 100644 arch/arm64/include/asm/kvm_hcall.h
 rename arch/arm64/{include/asm/kvm_define_hypevents.h => kvm/define_hypevents.h} (100%)
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/alloc.h
 create mode 100644 arch/arm64/kvm/hyp/nvhe/alloc.c
 create mode 100644 arch/arm64/kvm/trace_pkvm.h
 create mode 100644 arch/arm64/kvm/vgic-sys-reg-v5.c
 create mode 100644 arch/arm64/kvm/vgic/vgic-irs-v5.c
 create mode 100644 arch/arm64/kvm/vgic/vgic-v5-tables.c
 create mode 100644 arch/arm64/kvm/vgic/vgic-v5-tables.h
 create mode 100644 arch/s390/include/arm64/kvm_emulate.h
 create mode 100644 arch/s390/include/arm64/kvm_nested.h
 create mode 100644 arch/s390/include/arm64/ptrace.h
 create mode 100644 arch/s390/include/arm64/sysreg.h
 create mode 100644 arch/s390/include/asm/kvm.h
 create mode 100644 arch/s390/include/asm/kvm_host_arm64.h
 create mode 100644 arch/s390/include/asm/kvm_host_arm64_types.h
 create mode 100644 arch/s390/include/asm/sae.h
 create mode 100644 arch/s390/include/uapi/Kbuild
 create mode 100644 arch/s390/kvm/arm64/.gitignore
 create mode 100644 arch/s390/kvm/arm64/Makefile
 create mode 100644 arch/s390/kvm/arm64/Makefile.gen
 create mode 100644 arch/s390/kvm/arm64/arm.c
 create mode 100644 arch/s390/kvm/arm64/arm.h
 create mode 100644 arch/s390/kvm/arm64/copy-arm64c.awk
 create mode 100644 arch/s390/kvm/arm64/guest.c
 create mode 100644 arch/s390/kvm/arm64/handle_exit.c
 create mode 100644 arch/s390/kvm/arm64/handle_exit.h
 create mode 100644 arch/s390/kvm/arm64/inject_fault.c
 create mode 100644 arch/s390/kvm/arm64/mmio.c
 create mode 100644 arch/s390/kvm/arm64/mmu.c
 create mode 100644 arch/s390/kvm/arm64/reset.c
 create mode 100644 arch/s390/kvm/arm64/trace.h
 create mode 100644 arch/s390/tools/Makefile.arm64h
 create mode 100644 arch/s390/tools/copy-arm64h-full.awk
 create mode 100644 arch/s390/tools/copy-arm64h.awk
 create mode 100644 tools/testing/selftests/kvm/arm64/nv_pre_fault_memory_test.c
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/hcall.h
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/kvm_util_arch.h
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/ppc_asm.h
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/processor.h
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/ucall.h
 delete mode 100644 tools/testing/selftests/kvm/lib/io.c
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/handlers.S
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/hcall.c
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/processor.c
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/ucall.c
 create mode 100644 tools/testing/selftests/kvm/s390/irq_injection.c
 create mode 100644 tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
 delete mode 100644 tools/testing/selftests/kvm/x86/svm_nested_clear_efer_svme.c
 create mode 100644 tools/testing/selftests/kvm/x86/svm_nested_efer_test.c

diff --cc arch/arm64/include/asm/ptrace.h
index bd291bd6cfac,4d88ed5cc425..000000000000
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@@ -66,6 -68,14 +68,8 @@@
  #define PSR_AA32_IT_MASK	0x0600fc00	/* If-Then execution state mask */
  #define PSR_AA32_GE_MASK	0x000f0000
  
+ #endif /* ARM64_S390_COMMON == 1 */
+ 
 -#ifdef CONFIG_CPU_BIG_ENDIAN
 -#define PSR_AA32_ENDSTATE	PSR_AA32_E_BIT
 -#else
 -#define PSR_AA32_ENDSTATE	0
 -#endif
 -
  /* AArch32 CPSR bits, as seen in AArch32 */
  #define COMPAT_PSR_DIT_BIT	0x00200000
  
diff --cc arch/arm64/include/asm/sysreg.h
index cec36606f6a4,aa65603455a2..000000000000
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@@ -826,27 -838,43 +829,30 @@@
  #define SCTLR_ELx_A	 (BIT(1))
  #define SCTLR_ELx_M	 (BIT(0))
  
+ #endif /* ARM64_S390_COMMON == 1 */
+ 
 -#ifdef CONFIG_CPU_BIG_ENDIAN
 -#define ENDIAN_SET_EL2		SCTLR_ELx_EE
 -#else
 -#define ENDIAN_SET_EL2		0
 -#endif
 -
  #define INIT_SCTLR_EL2_MMU_ON						\
  	(SCTLR_ELx_M  | SCTLR_ELx_C | SCTLR_ELx_SA | SCTLR_ELx_I |	\
 -	 SCTLR_ELx_IESB | SCTLR_ELx_WXN | ENDIAN_SET_EL2 |		\
 -	 SCTLR_ELx_ITFSB | SCTLR_ELx_EIS | SCTLR_ELx_EOS | SCTLR_EL2_RES1)
 +	 SCTLR_ELx_IESB | SCTLR_ELx_WXN | SCTLR_ELx_ITFSB |		\
 +	 SCTLR_ELx_EIS | SCTLR_ELx_EOS | SCTLR_EL2_RES1)
  
 -#define INIT_SCTLR_EL2_MMU_OFF \
 -	(SCTLR_EL2_RES1 | ENDIAN_SET_EL2)
 +#define INIT_SCTLR_EL2_MMU_OFF	(SCTLR_EL2_RES1)
  
  /* SCTLR_EL1 specific flags. */
 -#ifdef CONFIG_CPU_BIG_ENDIAN
 -#define ENDIAN_SET_EL1		(SCTLR_EL1_E0E | SCTLR_ELx_EE)
 -#else
 -#define ENDIAN_SET_EL1		0
 -#endif
 -
  #define INIT_SCTLR_EL1_MMU_OFF \
 -	(ENDIAN_SET_EL1 | SCTLR_EL1_LSMAOE | SCTLR_EL1_nTLSMD | \
 -	 SCTLR_EL1_EIS  | SCTLR_EL1_TSCXT  | SCTLR_EL1_EOS)
 +	(SCTLR_EL1_LSMAOE | SCTLR_EL1_nTLSMD | SCTLR_EL1_EIS  |		\
 +	 SCTLR_EL1_TSCXT  | SCTLR_EL1_EOS)
  
  #define INIT_SCTLR_EL1_MMU_ON \
 -	(SCTLR_ELx_M      | SCTLR_ELx_C      | SCTLR_ELx_SA    | \
 -	 SCTLR_EL1_SA0    | SCTLR_EL1_SED    | SCTLR_ELx_I     | \
 -	 SCTLR_EL1_DZE    | SCTLR_EL1_UCT    | SCTLR_EL1_nTWE  | \
 -	 SCTLR_ELx_IESB   | SCTLR_EL1_SPAN   | SCTLR_ELx_ITFSB | \
 -	 ENDIAN_SET_EL1   | SCTLR_EL1_UCI    | SCTLR_EL1_EPAN  | \
 -	 SCTLR_EL1_LSMAOE | SCTLR_EL1_nTLSMD | SCTLR_EL1_EIS   | \
 -	 SCTLR_EL1_TSCXT  | SCTLR_EL1_EOS)
 +	(SCTLR_ELx_M      | SCTLR_ELx_C      | SCTLR_ELx_SA     | \
 +	 SCTLR_EL1_SA0    | SCTLR_EL1_SED    | SCTLR_ELx_I      | \
 +	 SCTLR_EL1_DZE    | SCTLR_EL1_UCT    | SCTLR_EL1_nTWE   | \
 +	 SCTLR_ELx_IESB   | SCTLR_EL1_SPAN   | SCTLR_ELx_ITFSB  | \
 +	 SCTLR_EL1_UCI    | SCTLR_EL1_EPAN   | SCTLR_EL1_LSMAOE | \
 +	 SCTLR_EL1_nTLSMD | SCTLR_EL1_EIS    | SCTLR_EL1_TSCXT  | \
 +	 SCTLR_EL1_EOS)
  
+ #if ARM64_S390_COMMON == 1
  /* MAIR_ELx memory attributes (used by Linux) */
  #define MAIR_ATTR_DEVICE_nGnRnE		UL(0x00)
  #define MAIR_ATTR_DEVICE_nGnRE		UL(0x04)

