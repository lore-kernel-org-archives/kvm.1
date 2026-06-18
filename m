Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1841C862D
	for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 15:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781796482; cv=none; b=BDqvK2QiaRJ0PweaugXjcrfU8xcYK/xL/xcBwaLN+pgBf1fGNZ511VW54BNcwcBlm8qjG4VFdLJGC9K1M0rd1mL9xm5UKwL3vkehQIwCe35gvKt5CmhYBZybs99zswXVF4pO3Css6DbNMIfFeyk/CwZ+nC4OJXQduXCHnkYVM98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781796482; c=relaxed/simple;
	bh=2Ecg+h1iz21ztMHnOv0ey6HODJyma8GvT60htgIyjgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jDr3jvt92nzmCR+5bf4WTRjXmarDrgz9T1EqAUZj9Z85cHM6T7wMY3hAtIWZQSy9FaDhm9aPB0bVWmBV21qj3QUAq7WvDV9wqzjkPunWvOMY4qQhxA998qDxQ5AC5vNGXFehXauZF3nzTAZWjOTkenEoBPW1m94XbShk7DzDO/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X0WbmTbt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=G28PnF2T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X0WbmTbt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="G28PnF2T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781796477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Al/2Huy857nzKx+kOQiPpGmVjKddm02yuuZ5DMsF1ng=;
	b=X0WbmTbtmlrIy+0Sly4CnzNPQUEalWZyepiOstK/43QdWo+DyXJrLED/vpNEgfhnbjwou1
	wq4Md+ZZzn4721LdfIhHeAFAbdU951Tv6cZnwbEAFmsvbV+Qvjnffs7Bw/nJI+EQY+UXCv
	u2/8Db5kEMszjbY03558YVlezWXz0rk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-mwAJS2c5Mg6CUTXSHvA1QQ-1; Thu, 18 Jun 2026 11:27:55 -0400
X-MC-Unique: mwAJS2c5Mg6CUTXSHvA1QQ-1
X-Mimecast-MFC-AGG-ID: mwAJS2c5Mg6CUTXSHvA1QQ_1781796474
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-462d8ccf553so792822f8f.1
        for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 08:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781796474; x=1782401274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Al/2Huy857nzKx+kOQiPpGmVjKddm02yuuZ5DMsF1ng=;
        b=G28PnF2TVupIY7cFeFThg2P6TqWfEf9vBgW0StKy2LuzRd7wdJgDvvsJ3/SsEnTBUx
         IZ/7to9ffedJ5va6G8mRLBOdH/oLFtwiE2c9OmqocIhpphNzuBNnF9hFzFAibeFbBIbR
         H0GOHTKvTru/UQj0Zns/MsNDx35Fj2UHSpSQ2eUpjc4bzA3ufsf/7xaERTGhyHNWNUtk
         Z1C0ApwxLjc7Z0k3dQLtO6ae2slwjEwrXLr6C+3AOUV2WEXBwzyGMifsZ/8RGSSLtJsx
         Kfm/snM0nZGYk69tAKTNiH4Wk+3rTD859kyae+dxc0zJpfKxjRvp6EsWQEyoMGO0HX40
         UWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781796474; x=1782401274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Al/2Huy857nzKx+kOQiPpGmVjKddm02yuuZ5DMsF1ng=;
        b=JGkjKQ5ElsF/mUskgq8ajO4DNx3dmc/sqRn67V3i7n5fs/RMX2p2ZM+PETQ6j3IcW8
         WDpAFeY/X3/qs3LwhOzI6LXng7cCZs+GpUULR7QarEtsaBKvgeFh3uX4FM0/y03xZcqV
         PQ7eFuizcT2gPRkKUOsl+kekfn9mrME5D0hD1loXs9eu7V2iC4RXtr6yMn0AhYZRPWyD
         CDgvd7Bvf81pDS+AVPkoxVWKo10HWVD/qQCsDuMSUeCwHlW7d5zG8Q+t4v1+yLFgtLek
         ZhV6B8jk9v4LTJGVhVY6eKJqrX0/2rrzgksvRgsC1O7+eMnYYAWYiO0Zpcf/ckCqCnK2
         +YHw==
X-Forwarded-Encrypted: i=1; AFNElJ8iAZ2Z7ybuZFj3i23jB5Ra14EK0hDMBsE+GI411pRjI4NeztbFbgzx94uDZiHQWToOAmw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq+r/qn55h86gA+1GFuyQfar1E88q6Vzx2tZsdEDDAskWn14Jl
	nIZ/aGoMxv4GMACTtn3SmnL9ZH/pyiny6nLfMvDpfjxVX4m2huze3/ZN5QpNw7EVBDzJ9dJoTtZ
	FFpgzhrD5J4uinghVc5IkpRig5UEt+q32/UIWvrGBxZHMDeCGDtGRkg==
X-Gm-Gg: AfdE7cmfwTw4RSowrXXlSInKYsgyCu6M/93LwNqpGhfzDlJyLWZmZsmMpwnM2Bd56gt
	57mOfa3EwvnDq6flh3D+3begqt8keFoMRF8U9t+EqeExky24vHIwM5SWlUqOOfE4+/xaY2Z/sox
	8kBTrPsMZ0rX6ip5vm7dOGWIv4A+0QC8/DPuCQIGT8yGgPHZ0gQgrAc0URozELt6A5kAs20tmqC
	6nJYGiGBgfp0Z0U4Zerj27JIO3rp435eHZgUAql8DBOFy8mds7lPBBk1LvuQwPrq9hO/vDDBqvn
	vqekbGi1slcTi9Wu6MA9QWw3ppYDApO5MUvFuI4jMgLHuupcOdB2WHLKu4DpwEzeEf8bCZ3KpFZ
	C4/5qC9K1rUi4XVCTGhMuK3CaO2Si/xh/64/0tKBKaxsXZYgHK+7jTDeYNehyG2d6TmCFGggk1q
	X2jb3B8ldVY6wgMvy6
X-Received: by 2002:adf:ebca:0:b0:45e:df46:ba30 with SMTP id ffacd0b85a97d-4624179babbmr12315241f8f.34.1781796473075;
        Thu, 18 Jun 2026 08:27:53 -0700 (PDT)
X-Received: by 2002:adf:ebca:0:b0:45e:df46:ba30 with SMTP id ffacd0b85a97d-4624179babbmr12315142f8f.34.1781796472050;
        Thu, 18 Jun 2026 08:27:52 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.156.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4619b9b7750sm36234813f8f.6.2026.06.18.08.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 08:27:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [GIT PULL] KVM changes for Linux 7.2
Date: Thu, 18 Jun 2026 17:27:46 +0200
Message-ID: <20260618152747.132796-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 9716c086c8e8b141d35aa61f2e96a2e83de212a7:

  Merge tag 'pm-7.1-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm (2026-06-10 11:53:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to ef057cbf825e03b63f6edf5980f96abf3c53089d:

  KVM: x86/mmu: Ensure hugepage is in by slot before checking max mapping level (2026-06-16 00:39:57 +0200)

There is a small conflict in arch/x86/include/asm/tdx.h, just
due to touching neighboring code.  Deleting inlines as in the
KVM version is good, but keep the tdx_sys_disable prototype that was
added nearby by the tip tree.

Paolo
----------------------------------------------------------------
Arm:

"This is a bit of an odd merge window on the KVM/arm64 front. There is
absolutely no new feature in the pull request. It is purely fixes,
because it is simply becoming too hard to review new stuff when so
many AI-fuelled fixes hit the list".

- Significant cleanup of the vgic-v5 PPI support which was merged in
  7.1. This makes the code more maintainable, and squashes a couple
  of bugs in the meantime.

- Set of fixes for the handling of the MMU in an NV context,
  particularly VNCR-triggered faults. S1POE support is fixed
  as well.

- Large set of pKVM fixes, mostly addressing recurring issues
  around hypervisor tracking of donated pages in obscure cases
  where the donation could fail and leave things in a bizarre
  state.

- Fixes for the so-called "lazy vgic init", which resulted in
  sleeping operations in non-preemptible sections. This turned
  out to be far more invasive than initially expected...

- Reduce the overhead of L1/L2 context switch by not touching
  the FP registers.

- Fix the way non-implemented page sizes are dealt with when
  a guest insist on using them for S2 translation.

- The usual set of low-impact fixes and cleanups all over the map.

Loongarch:

- On a request for lazy FPU load, load all FPU state that the VM
  supports instead of enabling only the part (FPU, LSX or LASX)
  that caused the FPU load request.

- Some enhancements about interrupt injection.

- Some bug fixes and other small changes.

RISC-V:

- Batch G-stage TLB flushes for GPA range based page table updates

- Convert HGEI line management to fully per-HART

- Fix missing CSR dirty marking when FWFT state updated via ONE_REG

- Fix stale FWFT feature exposure to Guest/VM

- Speed up dirty logging write faults using MMU rwlock and atomic
  PTE updates using cmpxchg() for permission-only changes

- Use flexible array for APLIC IRQ state

- Use kvm_slot_dirty_track_enabled() for logging enable check on
  a memslot

- Avoid skipping valid pages in kvm_riscv_gstage_wp_range()

- Avoid skipping valid pages in kvm_riscv_gstage_unmap_range()

- Use endian-specific __lelong for NACL shared memory

S390:

- KVM_PRE_FAULT_MEMORY support

- Support for 2G hugepages

- Support for the ASTFLEIE 2 facility

- Support for fast inject using kvm_arch_set_irq_inatomic

- Fix potential leak of uninitialized bytes

- A few more misc gmap fixes.

x86:

- Generic support for the more granular permissions allowed by EPT,
  namely "read" (which was previously usurping the U bit) and
  separate execution bits for kernel and userspace.

- Do not assume that all page tables start with U=1/W=1/NX=0 at the
  root, as AMD GMET needs to have U=0 at the root.

- Introduce common assembly macros for use within Intel and AMD
  vendor-specific vmentry code.  This touches the SPEC_CTRL handling,
  which is now entirely done in assembly for Intel (by reusing the
  AMD code that already existed), and register save/restore which
  uses some macro magic to compute the offsets in the struct.  Both
  of these are preparatory changes for upcoming APX support.

- Clean up KVM's register tracking and storage, primarily to prepare for
  APX support, which expands the maximum number of GPRs from 16 to 32.

- Keep a single copy of the PDPTRs rather than two, since architecturally
  there is just one.

- Handle EXIT_FASTPATH_EXIT_USERSPACE in vendor code to ensure vendor code
  gets a chance to handle things like reaping the PML buffer.

- Update KVM's view of PV async enabling if and only if the MSR write fully
  succeeds.

- Fix a variety of issues where the emulator doesn't honor guest-debug state,
  and clean up related code along the way.

- Synthesize EPT Violation and #NPF "error code" bits when injecting faults
  into L1 that didn't originate in hardware (in which case the VMCS/VMCB
  doesn't hold relevant information).

- Add support for virtualizing (well, emulating) AMD's flavor of CPL>0 CPUID
  faulting.

- Clean up the GPR APIs so that KVM's use of "raw" is consistent, and fix a
  variety of minor bugs along the way.

- Fix an OOB memory access due to not checking the VP ID when handling a
  Hyper-V PV TLB flush for L2.

- Fix a bug in the mediated PMU's handling of fixed counters that allowed the
  guest to bypass the PMU event filter.

- Allow userspace to return EAGAIN when handling SNP and TDX hypercalls, so
  the KVM can forward a "retry" status code to the guest, and reserve all
  unused error codes for future usage.

- Overhaul the TDP MMU => S-EPT code to move as much S-EPT specific logic as
  possible into the TDX code, and to funnel (almost) all S-EPT updates into
  a single chokepoint.  The motivation is largely to prepare for upcoming
  Dynamic PAMT support, but the cleanups are nice to have on their own.

- Plug a hole in shadow page table handling, where KVM fails to recursively
  zap nested EPT/NPT shadow page tables when the nested hypervisor tears
  down its own EPT/NPT page tables from the bottom up

x86 (Intel):

- Support for nested MBEC (Mode-Based Execute Control), see above in the
  generic section; also run with MBEC enabled even for non-nested mode.

- Use the kernel's "enum pg_level" in the TDX APIs instead of the TDX-Module's
  level definitions (which are 0-based).

- Rework the TDX memory APIs to not require/assume that guest memory is
  backed by "struct page" (in prepartion for guest_memfd hugepage support).

- Fix a largely benign bug where KVM TDX would incorrectly state it could
  emulate several x2APIC MSRs.

- Use the "safe" WRMSR API when proxying LBR MSR writes as the to-be-written
  value is guest controlled and completely unvalidated.

x86 (AMD):

- Support for nested GMET (Guest Mode Execution Trap), see above in the
  generic section; also run with GMET enabled even for non-nested mode.

- Fixes and minor cleanups to GHCB handling, on top of the earlier work
  already merged into 7.1-rc.

- Ensure KVM's copy of CR0 and CR3 are up-to-date prior to invoking
  fastpath handlers.

- Add support for virtualizing gPAT (KVM previously just used L1's PAT when
  running L2).

- Fix goofs where KVM mishandles side effects (e.g. single-step and PMC
  updates) when emulating VMRUN.

- Fix a variety of bugs in AVIC's handling of x2APIC MSR interception, most
  notably where KVM didn't disable interception of IRR, ISR, and TMR regs.

- Add support for virtualizing Host-Only/Guest-Only bits in the mediated PMU.

- Don't advertise support for unusable VM types, and account for VM types
  that are disabled by firmware, e.g. to mitigate security vulnerabilities.

- Rewrite the SEV {en,de}crypt debug ioctls as they were riddle with bugs and
  unnecessarily complicated, and add comprehensive tests.

- Clean up and deduplicate the SEV page pinning code.

- Fix minor goofs related to writing back CPUID information after firmware
  rejects a CPUID page for an SNP vCPU.

Generic:

- Rename invalidate_begin() to invalidate_start() throughout KVM to follow
  the kernel's nomenclature, e.g. for mmu_notifiers.

- Use guard() to cleanup up various KVM+VFIO flows.

- Minor cleanups.

guest_memfd:

- Return -EEXIST instead of -EINVAL if userspace attempts to bind a gmem
  range to multiple memslots, and fix the test that was supposed to ensure
  KVM returns -EEXIST.

- Treat memslot binding offsets and sizes as unsigned values to fix a bug
  where KVM interprets a large "offset + size" as a negative value and allows
  a nonsensical offset.

- Use the inode number instead of the page offset for the NUMA interleaving
  index to fix a bug where the effective index would jump by two for
  consecutive pages (the caller also adds in the page offset).

Selftests:

- Randomize the dirty log test's delay when reaping the bitmap on the first
  pass, as always waiting only 1ms hid a KVM RISC-V bug as the test reaped the
  bitmap before KVM could build up enough state to hit the bug.

- A pile of one-off fixes and cleanups.

----------------------------------------------------------------
Ackerley Tng (2):
      KVM: SEV: Unmap local kmaps in LIFO order, per highmem requirements
      KVM: SEV: Mark source page dirty when writing back CPUID data on failure

Ashutosh Desai (1):
      KVM: SVM: Fix page overflow in sev_dbg_crypt() for ENCRYPT path

Bibo Mao (12):
      LoongArch: KVM: Add separate KVM_REQ_LBT_LOAD bit
      LoongArch: KVM: Enable FPU with max supported FPU type
      LoongArch: KVM: Remove some middle FPU states
      LoongArch: KVM: Remove KVM_LARCH_LSX and KVM_LARCH_LASX
      LoongArch: KVM: Fix FPU register width with user access API
      LoongArch: KVM: Use existing macro about interrupt bit mask
      LoongArch: KVM: Check irq validity in kvm_vcpu_ioctl_interrupt()
      LoongArch: KVM: Check msgint feature in interrupt post
      LoongArch: KVM: Inject interrupts with batch method
      LoongArch: KVM: Add valid bit check when set CSR.ESTAT register
      LoongArch: KVM: Deliver interrupt after IN_GUEST_MODE is set
      LoongArch: KVM: Remove timer interrupt injection when SW timer expired

Carlos López (6):
      KVM: VFIO: clean up control flow in kvm_vfio_file_add()
      KVM: VFIO: use mutex guard in kvm_vfio_file_set_spapr_tce()
      KVM: VFIO: deduplicate file release logic
      KVM: VFIO: update coherency only if file was deleted
      KVM: x86: Take PIC lock on KVM_GET_IRQCHIP path
      Documentation: KVM: Synchronize x86 VM types

Chang S. Bae (3):
      KVM: VMX: Macrofy GPR swapping in __vmx_vcpu_run()
      KVM: SVM: Macrofy GPR swapping in __svm_vcpu_run()
      KVM: SEV: Macrofy GPR swapping in __svm_sev_es_vcpu_run()

Christian Borntraeger (1):
      KVM: s390: Initialize KVM_S390_GET_CMMA_BITS memory

Claudio Imbrenda (14):
      KVM: s390: Track page size in struct guest_fault
      KVM: s390: Implement KVM_PRE_FAULT_MEMORY
      KVM: s390: Update KVM_PRE_FAULT_MEMORY API documentation
      KVM: selftests: Fix pre_fault_memory_test to run on s390
      KVM: selftests: Enable pre_fault_memory_test for s390
      KVM: s390: Add module parameter to fence 2G hugepages
      KVM: s390: Add capability to support 2G hugepages
      KVM: s390: Allow for 2G hugepages
      KVM: s390: Document the KVM_CAP_S390_HPAGE_2G capability
      KVM: s390: Silence potential warnings in _gmap_crstep_xchg_atomic()
      KVM: s390: Fix unlikely race in try_get_locked_pte()
      KVM: s390: vsie: Fix allocation of struct vsie_rmap
      KVM: s390: vsie: Add missing radix_tree_preload() in _gaccess_shadow_fault()
      KVM: s390: vsie: Use mmu cache to allocate rmap

Douglas Freimuth (3):
      KVM: s390: Add map/unmap ioctl and clean mappings post-guest
      KVM: s390: Enable adapter_indicators_set to use mapped pages
      KVM: s390: Introducing kvm_arch_set_irq_inatomic fast inject

Ethan Yang (1):
      KVM: x86: Don't leave APF half-enabled on bad APF data GPA

Fuad Tabba (5):
      KVM: arm64: Guard against NULL vcpu on VHE hyp panic path
      KVM: arm64: Fix __deactivate_fgt macro parameter typo
      KVM: arm64: Seed pkvm_ownership_selftest vcpu memcache
      KVM: arm64: Pre-check vcpu memcache for host->guest share
      KVM: arm64: Pre-check vcpu memcache for host->guest donate

Guo Ren (Alibaba DAMO Academy) (2):
      irqchip/riscv-imsic: Add nr_guest_files in per-HART local config
      RISC-V: KVM: AIA: Make HGEI number management fully per-CPU

Hou Wenlong (7):
      KVM: x86: Capture "struct x86_exception" in inject_emulated_exception()
      KVM: x86: Set guest DR6 by kvm_queue_exception_p() in instruction emulation
      KVM: x86: Honor KVM_GUESTDBG_USE_HW_BP when emulating MOV DR (in emulator)
      KVM: x86: Honor KVM_GUESTDBG_USE_HW_BP when checking for code breakpoints in emulation
      KVM: x86: Move KVM_GUESTDBG_SINGLESTEP handling into kvm_inject_emulated_db()
      KVM: selftests: Verify guest debug DR7.GD checking during instruction emulation
      KVM: selftests: Verify VMX's GUEST_PENDING_DBG_EXCEPTIONS.BS Consistency Check

Hyunwoo Kim (3):
      KVM: arm64: Clear __hyp_running_vcpu when flushing the pKVM hyp vCPU
      KVM: arm64: Bound used_lrs when flushing the pKVM hyp vCPU
      KVM: x86: hyper-v: Bound the bank index when querying sparse banks

Inochi Amaoto (1):
      RISC-V: KVM: Enhance the logging check for mmu mapping

Jackie Liu (1):
      KVM: arm64: vgic-its: Make ABI commit helpers return void

Jiakai Xu (2):
      RISC-V: KVM: Document a TOCTOU race in SBI system suspend handler
      RISC-V: KVM: Fix NULL pointer dereference in AIA IMSIC functions

Jim Mattson (13):
      KVM: x86: Define KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT
      KVM: x86: nSVM: Clear VMCB_NPT clean bit when updating hPAT from guest mode
      KVM: x86: nSVM: Cache and validate vmcb12 g_pat
      KVM: x86: nSVM: Set vmcb02.g_pat correctly for nested NPT
      KVM: x86: nSVM: Redirect IA32_PAT accesses to either hPAT or gPAT
      KVM: x86: nSVM: Save gPAT to vmcb12.g_pat on VMEXIT
      KVM: Documentation: document KVM_{GET,SET}_NESTED_STATE for SVM
      KVM: x86: nSVM: Save/restore gPAT with KVM_{GET,SET}_NESTED_STATE
      KVM: x86: Prioritize CPUID faulting over CPUID VM-exits in nested VMX
      KVM: x86: Remove supports_cpuid_fault() helper
      KVM: x86: Virtualize AMD CPUID faulting
      KVM: selftests: Update hwcr_msr_test for CPUID faulting bit
      KVM: x86/pmu: Allow Host-Only/Guest-Only bits with nSVM and mediated PMU

Jinyu Tang (8):
      RISC-V: KVM: Batch stage-2 TLB flushes
      KVM: riscv: Rely on common MMU notifier locking
      KVM: riscv: Use an rwlock for mmu_lock
      KVM: riscv: Add a G-stage PTE cmpxchg helper
      KVM: riscv: Update G-stage PTE permissions atomically
      KVM: riscv: Fast-path dirty logging write faults
      KVM: riscv: Check hugetlb block mappings against memslot bounds
      KVM: selftests: Add a hugetlb memslot alignment test mode

Jiun Jeong (1):
      call_once:: Fix typo in comment for call_once()

Jon Kohler (5):
      KVM: TDX/VMX: rework EPT_VIOLATION_EXEC_FOR_RING3_LIN into PROT_MASK
      KVM: x86/mmu: remove SPTE_PERM_MASK
      KVM: x86/mmu: free up bit 10 of PTEs in preparation for MBEC
      KVM: nVMX: advertise MBEC to nested guests
      KVM: nVMX: allow MBEC with EVMCS

Kai Huang (1):
      KVM: x86: Use <linux/lockdep.h> for lockdep header inclusion

Kevin Cheng (4):
      KVM: x86: Widen x86_exception's error_code to 64 bits
      KVM: SVM: Fix nested NPF injection of PFERR_GUEST_{PAGE,FINAL}_MASK bits
      KVM: VMX: Synthesize nested EPT violation GVA_IS_VALID/GVA_TRANSLATED bits
      KVM: selftests: Add nested page fault injection test

Krzysztof Kozlowski (1):
      MAINTAINERS: KVM: Include maintainer profile

Li RongQing (3):
      KVM: x86: Fix wrong return value type in guest_cpuid_has()
      KVM: x86: Use fls() instead of ffs() for rmaps histogram bucketing
      KVM: x86: ioapic: Use old_dest_mode consistently in ioapic_write_indirect()

Marc Zyngier (29):
      KVM: arm64: nv: Track L2 to L1 exception emulation
      KVM: arm64: nv: Don't save/restore FP register during a nested ERET or exception
      KVM: arm64: timer: Repaint kvm_timer_{should,irq_can}_fire() to kvm_timer_{pending,enabled}()
      KVM: arm64: Simplify userspace notification of interrupt state
      KVM: arm64: timer: Kill the per-timer irq level cache
      KVM: arm64: pmu: Kill the PMU interrupt level cache
      KVM: arm64: vgic-v2: Force vgic init on injection outside the run loop
      KVM: arm64: vgic-v2: Don't init the vgic on in-kernel interrupt injection
      KVM: arm64: vgic-v5: Add for_each_visible_v5_ppi() iterator
      KVM: arm64: vgic-v5: Move PPI caps into kvm_vgic_global_state
      KVM: arm64: vgic-v5: Remove use of __assign_bit() with a constant
      KVM: arm64: vgic-v5: Drop pointless ARM64_HAS_GICV5_CPUIF check
      KVM: arm64: vgic: Constify struct irq_ops usage
      KVM: arm64: vgic: Consolidate vgic_allocate_private_irqs_locked()
      KVM: arm64: vgic-v5: Drop defensive checks from vgic_v5_ppi_queue_irq_unlock()
      KVM: arm64: vgic: Rationalise per-CPU irq accessor
      KVM: arm64: vgic-v5: Limit support to 64 PPIs
      KVM: arm64: Key CPTR_EL2.E0POE propagation on FEAT_S1POE
      KVM: arm64: Wire AT S1E1A in the system instruction handling table
      arm64: cpufeature: Expose ID_AA64ISAR2_EL1.ATS1A to KVM
      KVM: arm64: nv: Avoid dereferencing NULL VNCR pseudo-TLB
      KVM: arm64: nv: Hold kvm->mmu_lock while initialising vcpu->arch.vncr_tlb
      Merge branch kvm-arm64/no-lazy-vgic-init into kvmarm-master/next
      Merge branch kvm-arm64/nv-fp-elision into kvmarm-master/next
      Merge branch kvm-arm64/nv-granule-sizes into kvmarm-master/next
      Merge branch kvm-arm64/pkvm-fixes-7.2 into kvmarm-master/next
      Merge branch kvm-arm64/vgic-v5-PPI-fixes into kvmarm-master/next
      Merge branch kvm-arm64/misc-7.2 into kvmarm-master/next
      Merge branch kvm-arm64/nv-mmu-7.2 into kvmarm-master/next

Maxim Levitsky (1):
      KVM: selftests: access_tracking_perf_test: bump number of NUMA nodes to 32

Mayuresh Chitale (2):
      KVM: selftests: memslot_perf_test: make host wait timeout configurable
      RISC-V: KVM: Fix ebreak self test failure

Michael S. Tsirkin (1):
      KVM: guest_memfd: fix NUMA interleave index double-counting

Nina Schoetterl-Glausch (4):
      KVM: s390: Minor refactor of base/ext facility lists
      s390/sclp: Detect ASTFLEIE 2 facility
      KVM: s390: vsie: Refactor handle_stfle
      KVM: s390: vsie: Implement ASTFLEIE facility 2

Oliver Upton (5):
      KVM: arm64: Don't leak PFN when kvm_translate_vncr() races MMU notifier
      KVM: arm64: nv: Fully update VNCR fixmap state in kvm_translate_vncr()
      KVM: arm64: nv: Inject SEA TTW when desc update can't write to GPA
      KVM: arm64: Restart instruction upon race in __kvm_at_s12()
      KVM: arm64: nv: Restart stage-1 walk if stage-2 desc update fails

Paolo Bonzini (57):
      KVM: VMX: remove regs argument of __vmx_vcpu_run
      KVM: VMX: more cleanups to __vmx_vcpu_run
      KVM: SVM: prepare for making SPEC_CTRL switch common with VMX
      KVM: SVM: pass struct vcpu_svm to msr_write_intercepted
      KVM: SVM: adopt the same VMX_RUN_* flags as VMX
      KVM: SVM: extract RESTORE_*_SPEC_CTRL_BODY out of svm/vmenter.S
      KVM: VMX: switch to RESTORE_GUEST_SPEC_CTRL_BODY
      KVM: VMX: replace vmx_spec_ctrl_restore_host with RESTORE_HOST_SPEC_CTRL_BODY
      KVM: x86/mmu: shuffle high bits of SPTEs in preparation for MBEC
      KVM: x86/mmu: remove SPTE_EPT_*
      KVM: x86/mmu: merge make_spte_{non,}executable
      KVM: x86/mmu: rename and clarify BYTE_MASK
      KVM: x86/mmu: separate more EPT/non-EPT permission_fault()
      KVM: x86/mmu: introduce ACC_READ_MASK
      KVM: x86/mmu: pass PFERR_GUEST_PAGE/FINAL_MASK to kvm_translate_gpa
      KVM: x86/mmu: pass pte_access for final nGPA->GPA walk
      KVM: x86: make translate_nested_gpa vendor-specific
      KVM: x86/mmu: split XS/XU bits for EPT
      KVM: x86/mmu: move cr4_smep to base role
      KVM: VMX: enable use of MBEC
      KVM: nVMX: pass advanced EPT violation vmexit info to guest
      KVM: nVMX: pass PFERR_USER_MASK to MMU on EPT violations
      KVM: x86/mmu: add support for MBEC to EPT page table walks
      KVM: x86/mmu: propagate access mask from root pages down
      KVM: x86/mmu: introduce cpu_role bit for availability of PFEC.I/D
      KVM: SVM: add GMET bit definitions
      KVM: x86/mmu: hard code more bits in kvm_init_shadow_npt_mmu
      KVM: x86/mmu: add support for GMET to NPT page table walks
      KVM: SVM: enable GMET and set it in MMU role
      KVM: SVM: work around errata 1218
      KVM: nSVM: enable GMET for guests
      Merge branch 'kvm-mbec' into HEAD
      Merge branch 'kvm-vmenter' into HEAD
      Merge branch 'kvm-apx-prepare' into HEAD
      Merge commit 'kvm-vmenter-load-store-regs' into HEAD
      Merge branch 'kvm-ghcb-for-7.2' into HEAD
      Merge tag 'kvm-s390-master-7.1-4' of https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD
      Merge tag 'kvm-x86-generic-7.2' of https://github.com/kvm-x86/linux into HEAD
      Merge tag 'kvm-x86-gmem-7.2' of https://github.com/kvm-x86/linux into HEAD
      Merge tag 'kvm-x86-misc-7.2' of https://github.com/kvm-x86/linux into HEAD
      Merge tag 'kvm-x86-mmu-7.2' of https://github.com/kvm-x86/linux into HEAD
      Merge tag 'kvm-x86-selftests-7.2' of https://github.com/kvm-x86/linux into HEAD
      Merge tag 'kvm-x86-sev-7.2' of https://github.com/kvm-x86/linux into HEAD
      Merge tag 'kvm-x86-vfio-7.2' of https://github.com/kvm-x86/linux into HEAD
      Merge tag 'kvm-x86-vmx-7.2' of https://github.com/kvm-x86/linux into HEAD
      Merge tag 'kvm-x86-svm-7.2' of https://github.com/kvm-x86/linux into HEAD
      KVM: x86: remove nested_mmu from mmu_is_nested()
      KVM: nVMX: remove unnecessary code in prepare_vmcs02_rare
      KVM: nSVM: invalidate cached PDPTRs across nested NPT transitions
      KVM: x86: check that kvm_handle_invpcid is only invoked with shadow paging
      KVM: x86/mmu: move pdptrs out of the MMU
      Merge branch 'kvm-single-pdptrs' into HEAD
      Merge tag 'kvmarm-7.2' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD
      Merge tag 'kvm-s390-next-7.2-1' of https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD
      Merge tag 'loongarch-kvm-7.2' of git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson into HEAD
      Merge tag 'kvm-riscv-7.2-1' of https://github.com/kvm-riscv/linux into HEAD
      KVM: x86: Fix shadow paging use-after-free due to unexpected role

Peter Fang (1):
      KVM: Fix kvm_vcpu_map[_readonly]() function prototypes

Piotr Zarycki (4):
      KVM: selftests: sync_regs_test: drop stale TODO comment
      KVM: selftests: Fix typo in comment in hyperv_features.c
      KVM: selftests: hyperv_tlb_flush: replace NOP loop with udelay()
      KVM: selftests: hyperv_features: test write of 1 to HV_X64_MSR_RESET

Qiang Ma (3):
      RISC-V: KVM: Fix timer state restore
      LoongArch: KVM: Check the return values for put_user()
      LoongArch: KVM: Return full old CSR value from kvm_emu_xchg_csr()

Rick Edgecombe (5):
      KVM: TDX: Fix x2APIC MSR handling in tdx_has_emulated_msr()
      KVM: TDX: Move KVM_BUG_ON()s in __tdp_mmu_set_spte_atomic() to TDX code
      KVM: TDX: Move lockdep assert in __tdp_mmu_set_spte_atomic() to TDX code
      KVM: x86/tdp_mmu: Morph !is_frozen_spte() check into a KVM_MMU_WARN_ON()
      KVM: x86/mmu: Drop KVM_BUG_ON() on shared lock to zap child external PTEs

Rosen Penev (1):
      RISC-V: KVM: Use flexible array for APLIC IRQ state

Sagi Shahar (1):
      KVM: SEV: Restrict userspace return codes for KVM_HC_MAP_GPA_RANGE

Sascha Bischoff (9):
      KVM: arm64: vgic-v5: Add missing trap handing for NV triage
      KVM: arm64: vgic-v5: Atomically assign bits to PPI DVI bitmap
      KVM: arm64: selftests: Add missing GIC CDEN to no-vgic-v5 selftest
      KVM: arm64: selftests: Cleanup unused vars in GICv5 PPI selftest
      KVM: arm64: selftests: Improve error handling for GICv5 PPI selftest
      Documentation: KVM: Fix typos in VGICv5 documentation
      Documentation: KVM: Clarify that PMU_V3_IRQ IntID requirements for GICv5
      irqchip/gic-v5: Immediately exec priority drop following activate
      KVM: arm64: Fix arch timer interrupts for GICv3-on-GICv5 guests

Sean Chang (1):
      riscv: kvm: Use endian-specific __lelong for NACL shared memory

Sean Christopherson (78):
      KVM: x86: Add dedicated storage for guest RIP
      KVM: x86: Drop the "EX" part of "EXREG" to avoid collision with APX
      KVM: nVMX: Do a bitwise-AND of regs_avail when switching active VMCS
      KVM: x86: Add wrapper APIs to reset dirty/available register masks
      KVM: x86: Track available/dirty register masks as "unsigned long" values
      KVM: x86: Use a proper bitmap for tracking available/dirty registers
      KVM: x86: Ensure vendor's exit handler runs before fastpath userspace exits
      KVM: SVM: Refresh vcpu->arch.cr{0,3} prior to invoking fastpath handler
      KVM: SEV: Set supported SEV+ VM types during sev_hardware_setup()
      KVM: SEV: Consolidate logic for printing state of SEV{,-ES,-SNP} enabling
      KVM: SEV: Don't advertise support for unusable VM types
      KVM: x86: Drop superfluous caching of KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT
      KVM: x86: Drop superfluous caching of KVM_ASYNC_PF_SEND_ALWAYS
      x86/tdx: Use pg_level in TDX APIs, not the TDX-Module's 0-based level
      KVM: x86/mmu: Update iter->old_spte if cmpxchg64 on mirror SPTE "fails"
      KVM: TDX: Account all non-transient page allocations for per-TD structures
      KVM: x86: Make "external SPTE" ops that can fail RET0 static calls
      KVM: selftests: Add a test to verify SEV {en,de}crypt debug ioctls
      KVM: SEV: Explicitly validate the dst buffer for debug operations
      KVM: SEV: Add helper function to pin/unpin a single page
      KVM: SEV: Rewrite logic to {de,en}crypt memory for debug
      KVM: SEV: Allocate only as many bytes as needed for temp crypt buffers
      KVM: VMX: Refresh GUEST_PENDING_DBG_EXCEPTIONS.BS on all injected #DBs
      KVM: x86: Drop kvm_vcpu_do_singlestep() now that it's been gutted
      KVM: selftests: Add all (known) EFLAGS bit definitions
      KVM: x86: Remove unused X86EMUL_MODE_HOST define
      KVM: x86: Add dedicated API for getting mask of accelerated x2APIC MSRs
      KVM: SVM: Disable x2AVIC RDMSR interception for MSRs KVM actually supports
      KVM: SVM: Only disable x2AVIC WRMSR interception for MSRs that are accelerated
      KVM: SEV: Pin source page for write when adding CPUID data for SNP guest
      KVM: selftests: Remove unnecessary "%s" formatting of a constant string
      KVM: selftests: Cast guest_memfd fd to a signed int when checking for >= 0
      KVM: selftests: Add and use kvm_free_fd() to harden against fd goofs
      KVM: selftests: Randomize dirty_log_test's delay before reaping the bitmap
      x86/tdx: Use PFN directly for mapping guest private memory
      x86/tdx: Use PFN directly for unmapping guest private memory
      KVM: x86: Tell ->inject_page_fault() whether or a fault came from hardware
      KVM: x86: Consolidate CPUID fault handling for emulator and interception logic
      KVM: TDX: Drop kvm_x86_ops.link_external_spt()
      KVM: TDX: Wrap mapping of leaf and non-leaf S-EPT entries into helpers
      KVM: x86/mmu: Fold set_external_spte_present() into its sole caller
      KVM: x86/mmu: Plumb param "old_spte" into kvm_x86_ops.set_external_spte()
      KVM: x86/mmu: Plumb "sp" _pointer_ into the TDP MMU's handle_changed_spte()
      KVM: x86/tdp_mmu: Centrally propagate to-present/atomic zap updates to external PTEs
      KVM: TDX: Hoist tdx_sept_remove_private_spte() above set_private_spte()
      KVM: TDX: Drop kvm_x86_ops.remove_external_spte()
      KVM: x86: Move error handling inside free_external_spt()
      KVM: TDX: Move external page table freeing to TDX code
      KVM: SVM: Truncate INVLPGA address in compatibility mode
      KVM: x86/xen: Bug the VM if 32-bit KVM observes a 64-bit mode hypercall
      KVM: x86/xen: Don't truncate RAX when handling hypercall from protected guest
      KVM: VMX: Read 32-bit GPR values for ENCLS instructions outside of 64-bit mode
      KVM: x86: Trace hypercall register *after* truncating values for 32-bit
      KVM: x86: Rename kvm_cache_regs.h => regs.h
      KVM: x86: Move inlined GPR, CR, and DR helpers from x86.h to regs.h
      KVM: x86: Add mode-aware versions of kvm_<reg>_{read,write}() helpers
      KVM: x86: Drop non-raw kvm_<reg>_write() helpers
      KVM: nSVM: Use kvm_rax_read() now that it's mode-aware
      Revert "KVM: VMX: Read 32-bit GPR values for ENCLS instructions outside of 64-bit mode"
      KVM: x86: Harden is_64_bit_hypercall() against bugs on 32-bit kernels
      KVM: x86: Move update_cr8_intercept() to lapic.c
      KVM: x86: Move async #PF helpers to x86.h (as inlines)
      KVM: x86: Drop defunct vcpu_tsc_khz() declaration
      KVM: x86: Remove defunct kvm_load_segment_descriptor() declaration.
      KVM: guest_memfd: Treat memslot binding offset+size as unsigned values
      KVM: selftests: Expand the guest_memfd test macros to allow passing the VM
      KVM: selftests: Add guest_memfd regression test signed offset+size bug
      KVM: SEV: Don't terminate SNP VMs on #VMGEXIT without a registered GHCB
      KVM: SEV: Move GHCB "usage" check out of sev_es_validate_vmgexit()
      KVM: SEV: Return INVALID_EVENT for SNP-only #VMGEXIT from non-SNP guest
      KVM: SEV: Return INVALID_INPUT, not MISSING_INPUT, for bad GUEST_REQUEST input(s)
      KVM: SEV: Handle unknown #VMGEXIT reasons in sev_handle_vmgexit()
      KVM: SEV: Turn sev_es_validate_vmgexit() into a dedicated predicate
      KVM: SEV: Remove sometimes-used function-scoped "ret" from #VMGEXIT handler
      KVM: x86/pmu: Use hardware value when reprogramming for FIXED_CTR_CTRL changes
      KVM: selftests: Add regression test for mediated PMU fixed counter filter bug
      KVM: x86/mmu: Recursively zap orphaned nested TDP shadow pages on emulated writes
      KVM: x86/mmu: Ensure hugepage is in by slot before checking max mapping level

Takahiro Itazuri (1):
      KVM: Rename invalidate_begin to invalidate_start for consistency

Tycho Andersen (4):
      crypto/ccp: hoist kernel part of SNP_PLATFORM_STATUS
      crypto/ccp: export firmware supported vm types
      KVM: SEV: Don't advertise VM types that are disabled by firmware
      KVM: selftests: Teach sev_*_test about revoking VM types

Vincent Donnefort (4):
      KVM: arm64: Reset page order in pKVM hyp_pool
      KVM: arm64: Fix __pkvm_init_vm error path
      KVM: arm64: Add fail-safe for refcounted pages in __pkvm_hyp_donate_host
      KVM: arm64: Set a Linux errno on SMCCC error in kvm_call_hyp_nvhe()

Vishal Annapurve (2):
      KVM: x86: Treat KVM's virtual PMU as disabled for TDX VMs
      KVM: TDX: Allow userspace to return errors to guest for MAPGPA

Wei-Lin Chang (5):
      KVM: arm64: nv: Rename vtcr_to_walk_info() to setup_s2_walk()
      KVM: arm64: Factor out TG0/1 decoding of VTCR and TCR
      KVM: arm64: nv: Use literal granule size in TLBI range calculation
      KVM: arm64: Fallback to a supported value for unsupported guest TGx
      KVM: arm64: Fix block mapping validity check in stage-1 walker

Will Deacon (1):
      KVM: arm64: Don't populate TPIDR_EL2 in finalise_el2()

Wu Fei (2):
      RISC-V: KVM: Fix skip of valid pages in kvm_riscv_gstage_wp_range
      RISC-V: KVM: Fix skip of valid pages in kvm_riscv_gstage_unmap_range

Xuanqing Shi (1):
      KVM: VMX: Handle bad values on proxied writes to LBR MSRs

Yan Zhao (3):
      x86/tdx: Drop exported function tdx_quirk_reset_page()
      x86/virt/tdx: Move mk_keyed_paddr() to tdx.c due to no external users
      KVM: TDX: Rename tdx_sept_remove_private_spte() to show it's for leaf SPTEs

Yanfei Xu (1):
      LoongArch: KVM: Validate irqchip index in irqfd routing

Yong-Xuan Wang (5):
      KVM: RISC-V: SBI FWFT: Mark vCPU CSRs dirty after setting feature value
      KVM: RISC-V: SBI FWFT: Add optional init() callback for hardware probing
      KVM: RISC-V: SBI FWFT: Fix stale feature exposure after runtime extension changes
      KVM: riscv: selftests: Refactor ISA and SBI extension sublist macros
      KVM: riscv: selftests: Split SBI FWFT into separate feature-specific sublists

Yosry Ahmed (13):
      KVM: nSVM: Stop leaking single-stepping on VMRUN into L2
      KVM: nSVM: Bail early out of VMRUN emulation if advancing RIP fails
      KVM: nSVM: Unify RIP and PMU handling calls when emulating VMRUN
      KVM: nSVM: Move VMRUN instruction retirement after entering guest mode
      KVM: x86: Move enable_pmu/enable_mediated_pmu to pmu.h and pmu.c
      KVM: x86/pmu: Rename reprogram_counters() to clarify usage
      KVM: x86/pmu: Do a single atomic OR when reprogramming counters
      KVM: x86/pmu: Check mediated PMU counter enablement before event filters
      KVM: x86/pmu: Add support for KVM_X86_PMU_OP_OPTIONAL_RET0
      KVM: x86/pmu: Disable counters based on Host-Only/Guest-Only bits in SVM
      KVM: x86/pmu: Track mediated PMU counters with mode-specific enables
      KVM: x86/pmu: Reprogram Host/Guest-Only counters on nested transitions
      KVM: selftests: Add a test for gPAT handling in L2

Zeng Chi (1):
      LoongArch: KVM: Add missing slots_lock for device register/unregister

Zenghui Yu (Huawei) (1):
      KVM: arm64: Remove @arch from __load_stage2()

Zongyao Chen (3):
      KVM: selftests: Fix vcpu_get_stats_fd() ioctl name
      KVM: guest_memfd: Return -EEXIST for overlapping bindings
      KVM: selftests: Test guest_memfd binding overlap without GPA overlap

tabba@google.com (4):
      KVM: arm64: Flush HCR_EL2.VSE to deliver SErrors to pKVM guests
      KVM: arm64: Free hyp-share tracking node when share hypercall fails
      KVM: arm64: Avoid host/hyp share desync on unshare hypercall failure
      KVM: arm64: Roll back partial shares on kvm_share_hyp() failure

 Documentation/virt/kvm/api.rst                     |  51 +-
 Documentation/virt/kvm/devices/arm-vgic-v5.rst     |   6 +-
 Documentation/virt/kvm/devices/vcpu.rst            |   7 +-
 Documentation/virt/kvm/x86/mmu.rst                 |  10 +-
 MAINTAINERS                                        |   1 +
 arch/arm64/include/asm/kvm_host.h                  |   8 +-
 arch/arm64/include/asm/kvm_hyp.h                   |   1 +
 arch/arm64/include/asm/kvm_mmu.h                   |   3 +-
 arch/arm64/kernel/cpufeature.c                     |   1 +
 arch/arm64/kernel/hyp-stub.S                       |   4 +-
 arch/arm64/kvm/arch_timer.c                        | 137 ++--
 arch/arm64/kvm/arm.c                               |  41 +-
 arch/arm64/kvm/at.c                                | 146 +++-
 arch/arm64/kvm/emulate-nested.c                    |  12 +
 arch/arm64/kvm/fpsimd.c                            |  26 +
 arch/arm64/kvm/hyp/include/hyp/switch.h            |   2 +-
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h      |   3 +-
 arch/arm64/kvm/hyp/nvhe/hyp-main.c                 |  21 +-
 arch/arm64/kvm/hyp/nvhe/mem_protect.c              |  37 +-
 arch/arm64/kvm/hyp/nvhe/page_alloc.c               |  21 +-
 arch/arm64/kvm/hyp/nvhe/pkvm.c                     |   4 +-
 arch/arm64/kvm/hyp/nvhe/switch.c                   |   2 +-
 arch/arm64/kvm/hyp/nvhe/tlb.c                      |   4 +-
 arch/arm64/kvm/hyp/vgic-v5-sr.c                    |  78 +-
 arch/arm64/kvm/hyp/vhe/switch.c                    |   2 +-
 arch/arm64/kvm/hyp/vhe/tlb.c                       |   4 +-
 arch/arm64/kvm/mmu.c                               |  39 +-
 arch/arm64/kvm/nested.c                            | 236 +++---
 arch/arm64/kvm/pmu-emul.c                          |  31 +-
 arch/arm64/kvm/sys_regs.c                          |  20 +-
 arch/arm64/kvm/vgic/vgic-init.c                    |  45 +-
 arch/arm64/kvm/vgic/vgic-irqfd.c                   |   6 +
 arch/arm64/kvm/vgic/vgic-its.c                     |  21 +-
 arch/arm64/kvm/vgic/vgic-kvm-device.c              |   9 +-
 arch/arm64/kvm/vgic/vgic-v5.c                      |  51 +-
 arch/arm64/kvm/vgic/vgic.c                         |  33 +-
 arch/arm64/kvm/vgic/vgic.h                         |   3 +
 arch/loongarch/include/asm/kvm_host.h              |  14 +-
 arch/loongarch/include/asm/kvm_vcpu.h              |  43 +-
 arch/loongarch/kvm/exit.c                          |  22 +-
 arch/loongarch/kvm/intc/eiointc.c                  |   6 +
 arch/loongarch/kvm/intc/ipi.c                      |   2 +
 arch/loongarch/kvm/intc/pch_pic.c                  |   2 +
 arch/loongarch/kvm/interrupt.c                     |  98 +--
 arch/loongarch/kvm/irqfd.c                         |   3 +-
 arch/loongarch/kvm/timer.c                         |   3 +-
 arch/loongarch/kvm/vcpu.c                          | 118 ++-
 arch/riscv/include/asm/kvm_aia.h                   |   2 +-
 arch/riscv/include/asm/kvm_gstage.h                |  10 +-
 arch/riscv/include/asm/kvm_host.h                  |   2 +
 arch/riscv/include/asm/kvm_nacl.h                  |  14 +-
 arch/riscv/include/asm/uaccess.h                   |   2 +-
 arch/riscv/kvm/aia.c                               |  88 ++-
 arch/riscv/kvm/aia_aplic.c                         |  15 +-
 arch/riscv/kvm/aia_device.c                        |   4 +-
 arch/riscv/kvm/aia_imsic.c                         |   9 +
 arch/riscv/kvm/gstage.c                            |  98 ++-
 arch/riscv/kvm/main.c                              |   8 +-
 arch/riscv/kvm/mmu.c                               | 211 ++++--
 arch/riscv/kvm/nacl.c                              |   2 +-
 arch/riscv/kvm/vcpu.c                              |   1 +
 arch/riscv/kvm/vcpu_sbi_fwft.c                     |  44 +-
 arch/riscv/kvm/vcpu_sbi_system.c                   |  14 +
 arch/riscv/kvm/vcpu_timer.c                        |   2 +-
 arch/s390/include/asm/kvm_host.h                   |  23 +-
 arch/s390/include/asm/sclp.h                       |   1 +
 arch/s390/include/uapi/asm/kvm.h                   |   1 +
 arch/s390/kvm/Kconfig                              |   1 +
 arch/s390/kvm/dat.c                                |   2 +-
 arch/s390/kvm/dat.h                                |   1 +
 arch/s390/kvm/gaccess.c                            |  73 +-
 arch/s390/kvm/gmap.c                               |  33 +-
 arch/s390/kvm/gmap.h                               |  14 +-
 arch/s390/kvm/intercept.c                          |   5 +-
 arch/s390/kvm/interrupt.c                          | 563 ++++++++++++---
 arch/s390/kvm/kvm-s390.c                           | 161 ++++-
 arch/s390/kvm/kvm-s390.h                           |   5 +-
 arch/s390/kvm/pv.c                                 |   5 +-
 arch/s390/kvm/vsie.c                               |  85 ++-
 arch/s390/mm/gmap_helpers.c                        |   6 +-
 arch/x86/include/asm/cpufeatures.h                 |   1 +
 arch/x86/include/asm/kvm-x86-ops.h                 |   5 +-
 arch/x86/include/asm/kvm-x86-pmu-ops.h             |   5 +-
 arch/x86/include/asm/kvm_host.h                    | 147 ++--
 arch/x86/include/asm/kvm_vcpu_regs.h               | 109 ++-
 arch/x86/include/asm/msr-index.h                   |   1 +
 arch/x86/include/asm/perf_event.h                  |   2 +
 arch/x86/include/asm/svm.h                         |   1 +
 arch/x86/include/asm/tdx.h                         |  34 +-
 arch/x86/include/asm/vmx.h                         |  14 +-
 arch/x86/include/uapi/asm/kvm.h                    |   2 +
 arch/x86/kvm/cpuid.c                               |  21 +-
 arch/x86/kvm/cpuid.h                               |  20 +-
 arch/x86/kvm/debugfs.c                             |   2 +-
 arch/x86/kvm/emulate.c                             |  22 +-
 arch/x86/kvm/hyperv.c                              |  30 +-
 arch/x86/kvm/hyperv.h                              |   4 +-
 arch/x86/kvm/ioapic.c                              |   2 +-
 arch/x86/kvm/irq.c                                 |   4 +
 arch/x86/kvm/kvm-asm-offsets.c                     |   1 +
 arch/x86/kvm/kvm_cache_regs.h                      | 249 -------
 arch/x86/kvm/kvm_emulate.h                         |  17 +-
 arch/x86/kvm/lapic.c                               |  49 +-
 arch/x86/kvm/lapic.h                               |   3 +-
 arch/x86/kvm/mmu.h                                 |  32 +-
 arch/x86/kvm/mmu/mmu.c                             | 216 ++++--
 arch/x86/kvm/mmu/mmutrace.h                        |  19 +-
 arch/x86/kvm/mmu/paging_tmpl.h                     | 107 ++-
 arch/x86/kvm/mmu/spte.c                            |  92 ++-
 arch/x86/kvm/mmu/spte.h                            |  70 +-
 arch/x86/kvm/mmu/tdp_mmu.c                         | 281 +++-----
 arch/x86/kvm/pmu.c                                 |  21 +-
 arch/x86/kvm/pmu.h                                 |  44 +-
 arch/x86/kvm/regs.h                                | 423 +++++++++++
 arch/x86/kvm/smm.c                                 |   2 +-
 arch/x86/kvm/svm/avic.c                            |  47 +-
 arch/x86/kvm/svm/nested.c                          | 218 ++++--
 arch/x86/kvm/svm/pmu.c                             |  42 ++
 arch/x86/kvm/svm/sev.c                             | 796 ++++++++++-----------
 arch/x86/kvm/svm/svm.c                             | 140 +++-
 arch/x86/kvm/svm/svm.h                             |  53 +-
 arch/x86/kvm/svm/vmenter.S                         | 210 ++----
 arch/x86/kvm/vmenter.h                             | 111 +++
 arch/x86/kvm/vmx/capabilities.h                    |  12 +-
 arch/x86/kvm/vmx/common.h                          |  26 +-
 arch/x86/kvm/vmx/hyperv_evmcs.h                    |   1 +
 arch/x86/kvm/vmx/main.c                            |   9 +
 arch/x86/kvm/vmx/nested.c                          |  98 ++-
 arch/x86/kvm/vmx/nested.h                          |   2 +-
 arch/x86/kvm/vmx/pmu_intel.c                       |  18 +-
 arch/x86/kvm/vmx/run_flags.h                       |   9 -
 arch/x86/kvm/vmx/sgx.c                             |   6 +-
 arch/x86/kvm/vmx/tdx.c                             | 338 +++++----
 arch/x86/kvm/vmx/vmenter.S                         | 181 ++---
 arch/x86/kvm/vmx/vmx.c                             | 176 +++--
 arch/x86/kvm/vmx/vmx.h                             |  34 +-
 arch/x86/kvm/vmx/x86_ops.h                         |   6 +
 arch/x86/kvm/x86.c                                 | 434 +++++------
 arch/x86/kvm/x86.h                                 | 139 +---
 arch/x86/kvm/xen.c                                 |  39 +-
 arch/x86/virt/vmx/tdx/tdx.c                        |  64 +-
 drivers/crypto/ccp/sev-dev.c                       | 101 ++-
 drivers/irqchip/irq-gic-v5.c                       |  13 +-
 drivers/irqchip/irq-riscv-imsic-state.c            |   9 +-
 drivers/s390/char/sclp_early.c                     |   4 +-
 include/kvm/arm_arch_timer.h                       |   7 +-
 include/kvm/arm_pmu.h                              |   5 +-
 include/kvm/arm_vgic.h                             |  19 +-
 include/linux/call_once.h                          |   2 +-
 include/linux/irqchip/riscv-imsic.h                |   5 +-
 include/linux/kvm_host.h                           |  22 +-
 include/linux/psp-sev.h                            |  37 +
 include/uapi/linux/kvm.h                           |   1 +
 tools/testing/selftests/kvm/Makefile.kvm           |   4 +
 tools/testing/selftests/kvm/arm64/no-vgic.c        |   1 +
 tools/testing/selftests/kvm/arm64/vgic_v5.c        |  10 +-
 tools/testing/selftests/kvm/dirty_log_test.c       |  26 +-
 tools/testing/selftests/kvm/guest_memfd_test.c     |  24 +-
 tools/testing/selftests/kvm/include/kvm_syscalls.h |   6 +
 tools/testing/selftests/kvm/include/kvm_util.h     |   2 +-
 tools/testing/selftests/kvm/include/lru_gen_util.h |   2 +-
 .../testing/selftests/kvm/include/x86/processor.h  |  29 +-
 tools/testing/selftests/kvm/include/x86/sev.h      |  24 +
 tools/testing/selftests/kvm/kvm_page_table_test.c  |  28 +-
 tools/testing/selftests/kvm/lib/kvm_util.c         |  25 +-
 tools/testing/selftests/kvm/lib/x86/processor.c    |   2 +-
 tools/testing/selftests/kvm/lib/x86/vmx.c          |   2 +-
 tools/testing/selftests/kvm/memslot_perf_test.c    |  12 +-
 .../testing/selftests/kvm/pre_fault_memory_test.c  |   7 +-
 tools/testing/selftests/kvm/riscv/get-reg-list.c   | 136 ++--
 .../testing/selftests/kvm/set_memory_region_test.c |  31 +-
 tools/testing/selftests/kvm/x86/debug_regs.c       |  88 ++-
 tools/testing/selftests/kvm/x86/hwcr_msr_test.c    |   9 +-
 tools/testing/selftests/kvm/x86/hyperv_features.c  |  21 +-
 tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c |  15 +-
 .../selftests/kvm/x86/nested_tdp_fault_test.c      | 313 ++++++++
 .../selftests/kvm/x86/pmu_event_filter_test.c      |   6 +
 tools/testing/selftests/kvm/x86/sev_dbg_test.c     | 118 +++
 tools/testing/selftests/kvm/x86/sev_init2_tests.c  |  14 +-
 .../testing/selftests/kvm/x86/sev_migrate_tests.c  |   2 +-
 tools/testing/selftests/kvm/x86/sev_smoke_test.c   |   4 +-
 .../selftests/kvm/x86/svm_nested_pat_test.c        | 196 +++++
 tools/testing/selftests/kvm/x86/sync_regs_test.c   |   1 -
 virt/kvm/guest_memfd.c                             |  36 +-
 virt/kvm/kvm_main.c                                |   6 +-
 virt/kvm/kvm_mm.h                                  |   7 +-
 virt/kvm/vfio.c                                    |  98 +--
 187 files changed, 6174 insertions(+), 3559 deletions(-)
 delete mode 100644 arch/x86/kvm/kvm_cache_regs.h
 create mode 100644 arch/x86/kvm/regs.h
 create mode 100644 arch/x86/kvm/vmenter.h
 delete mode 100644 arch/x86/kvm/vmx/run_flags.h
 create mode 100644 tools/testing/selftests/kvm/x86/nested_tdp_fault_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/sev_dbg_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/svm_nested_pat_test.c

