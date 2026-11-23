Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429877;
	b=d53X6YFaUPFlC12kH5vsR2MpcENy4r813yyAlS7GWvyKjYaqh1VUrITmDybtzRnO57UM
	 kjkIftGGXSYCZwEGXRiwIPUYIyDlVMVkDre+RsjWOfaPGMxO1ZiwDSW3XjAu+u9Qc+CFF
	 0kwi3fhu+mVsXmO7agan9JvONIrebUMmBI15Ta6rUzvRrDh+UimwtDfNP0I3mUF2MLM0y
	 AsYTpm81aX2B8ysH80IDDq5B7U/WtTuPF55XnFJckY4xHtySa7KvC4mJAPXi3oXdTrXS/
	 S+8+y5ags/lGv92IyUKJS0n4KlMCP389t97exe2dHHmq8DS7uCpNClGS3KscOEG80lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429877;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding:X-Scanned-By;
	bh=TTkvJEI+C73Xd3uSkJaqYlIYGEL2lZPWu+krU37aZ0s=;
	b=sUynt6B5V2EmfAYP/prrXEB6sEkom0KGfWjxMQeg6TSEhi1cYu6d+ekBmjnc5j38BrsH
	 +H7DM3tcX6XRRqR5zNxJ/IIAUSEEBR5GBETQhufeISzUNlri2j+tZdkA2H8geu10dLpFv
	 OCXAruS3fUWl7LB1+rP20aRQglO0rwI5onbFn6n6UOrO6bykBRGVlliEJFUmzjOOWwpl5
	 a+YjWCVnLre/+1ukOie0n+GK/INSsLSgzyxRwkwY4HlU32EC+HfOzJg+vzPaKI0Rc0ES5
	 0zQ1VZ4o6DTC4FmQDwQgKEM7Z+rAd9SCRhf3ta12JOpOUS0ybbibyBwx6270wRvsc+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hytTyQ3f;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3334A606A31E
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 10:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3334A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hytTyQ3f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795429875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TTkvJEI+C73Xd3uSkJaqYlIYGEL2lZPWu+krU37aZ0s=;
	b=hytTyQ3fyfGtA4xvuTtCutjDe1cMkchFkjfoIC+b4bMGWoORhLRPxFXQq3r9f+kXZ/lM49
	4J5z/xlmNm2zd0EgnCQEYauIORQtYkAPjdfH0A9FHm24O5+B0pz2qmqSeDazRijTHFoP6U
	QnDMcOx2+eZV0g93+krwlh7hlgYtqrw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-TBFLegvYNhS8N4X6pNkV0g-1; Mon,
 23 Nov 2026 10:31:10 +0000
X-MC-Unique: TBFLegvYNhS8N4X6pNkV0g-1
X-Mimecast-MFC-AGG-ID: TBFLegvYNhS8N4X6pNkV0g_1795429869
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 779C41954228;
	Mon, 23 Nov 2026 10:31:09 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 691121956087;
	Mon, 23 Nov 2026 10:31:08 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [GIT PULL] KVM fixes for Linux 7.4-rc5
Date: Mon, 23 Nov 2026 11:31:06 +0100
Message-ID: <20261123103106.953938-1-pbonzini@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Linus,

The following changes since commit aebb7274476403040d582c61478df8f4a7bf9cd3:

  Linux 7.4-rc3 (2026-11-15 14:30:11 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to bd1be6e0267d7a52425bd515c53e9a49bd4e2a12:

  Merge tag 'kvm-riscv-fixes-7.4-1' of https://github.com/kvm-riscv/linux into HEAD (2026-11-20 17:55:01 +0100)

This bundles several submaintainer pull requests due to KVM Forum.
It's huge, even when accounting for selftests and doc changes. :/

Paolo
----------------------------------------------------------------
A large set of fixes, mostly for Arm but almost all architectures
are represented.

Arm MMU fixes:

- Correctly sanitise the TCR_EL2 register.

- Stop advertising LPA2 to NV guest when it isn't supported.

- Correctly convert EH2==0's view of TCR_EL2 into the E2H==1 format.

- Make sure an EL2 mapping is immediately visible to the hypervisor
  code, as we don't necessarily require ETS.

- Address a horrible situation where a guest can livelock when
  trying to solve a permission fault whilst the underlying S2 PTs
  have AF=0.

- Correctly wipe MTE tags for large mappings instead of just the
  head page, providing a convenient helper for this.

- Fix dirty logging detection in ring-only mode.

- Use ATS1A whenever FEAT_S1PIE is present.

- Fix arbitrary truncation to 32bit when dealing with pool size.

- Correctly order page pin refconting.

- Prevent a HYP block mapping from being replaced with a table.

- Fix NV Range invalidation by extending the boundaries to the
  next block mapping.

- Make sure the correct hw_mmu gets picked on the first run,
  should userspace restore a nested context between init and
  the first vcpu_load().

- Reject TLBI IPAS2E1 that fall outside of the S2 range.

Arm system register fixes:

- Correctly forward POE/PIE/TVAL EL2 register traps.

- Add a sanity check for missing trap forwarding.

- Correctly hide generic PAuth for pKVM protected guests when
  the feature PAuth has been exluced from the feature set.

- Make sure that HCR_EL2.NV1 is always RES0.

Arm VGIC fixes:

- Fix a bunch of low-impact issues with GICv4, avoiding leaks on
  unlikely failure paths.

- Use a separate lockdep class for vPE doorbells, and guarantee that
  they are never threaded.

- Avoid spurious allocation of VPEs when userspace decided not to
  expose nASSGIcap.

- Fix spurious preservation of the pending state after DISCARD
  and CLEAR ITS commands.

- Make sure GITS_CTLR.Enabled is updated under the its_lock.

- Serialise vgic CTRL_INIT against vCPU creation.

- Make the forwarding of LPIs tobust against LPIs being disabled
  on the target redistributor.

Arm pKVM fixes:

- Fix the reset of GICv3 LRs for pKVM, de-uglifying the PM paths
  whilst at it.

- Fix PMU handling for both protected and non-protected guests,
  fixing the synchronisation of kvm_host_data in the process.

- Correctly invalidate TLBs and I-cache when multiplexing multiple
  vcpus of the same VM on a single physical CPU

Arm feature visibility fixes:

- Correctly handle ACCDATA_EL1 being exposed to guests, plugging a
  potential communication channel between guests.

Other Arm fixes:

- Flag Apple M3, M4 and M6 CPUs as having a broken vgic and
  a wonky PMUv3 emulation.

- Correctly handle 64bit offsets into an MMIO region from
  userspace.

- Ensure that a vcpu is loaded when injecting an event.

- Correctly clear the vcpu feature set on init failure.

- Clear PSTATE.TCO on exit from the guest when MTE is enabled
  for the kernel.

- Let the L0 hypervisor always deal with FEAT_MOPS A/B nonsense when
  taking such exception, instead of potentially forwarding it.

- Add a "maintainer profile" for KVM/arm64.

- Add testing for the MOVI and MOVALL commands.

PPC:

- Implement kvm_arch_flush_shadow_all() and kvm_arch_flush_shadow_memslot()
  for PPC.  They're not meant to be optional!

RISC-V:

- Validate AIA MMIO address ranges before AIA is initialized

- Disallow GPA-width changes after AIA is initialized.

- Fix double free of the split page cache.

- Do not touch the envcfg CSRs on the SiFive P550, as it is based
  on the 1.11 privileged architecture spec.

- Set Accessed bit in dirty-log write fault fast-path.

- Validate PMU counter info using available counters.

- Fix G-stage page table memory leak on VM destroy.

s390:

- Additional memory management related fixes

- Improve robustness of the Arm code extraction script

- Fixes for the Arm layer

- Fix ESSA instruction handling in migration mode

- Fix crypto instruction no-hook handling

- Fix selftest for uvdevice

x86:

- Do not confuse the GPA of a guest paging structure with the GPA of the
  access, if a nested page fault occurs while the CPU is walking the
  guests's page tables.

- Do not attempt emulation if a nested page fault occurs on encrypted
  guest paging structures.

- Mitigate a class of (x86) bugs where KVM can read/write guest (userspace)
  memory using the wrong mm, i.e. using the wrong user page tables.

- Don't force a full nested VMX VM-Exit when destroying a vCPU, as processing
  the MSR load/store lists and writing back the shadow vmcs12 is wildly wrong
  when VM is dying.

- Clear only the VMCB save area on an intercepted SHUTDOWN on SVM, partly to
  avoid unnecessary churn, but mostly to prevent KVM from clobbering the PML
  index.

- Update the tracked pCPU on task migration for both vmcb01 and vmcb02 to fix
  an edge case where KVM can use a stale ASID across pCPUs.

- Clear nVMX's smm.guest_mode when freeing nested state, and if a RSM to L2
  ultimately fails (and queues a TRIPLE_FAULT to L1).

Generic:

- Rework the single-vCPU kick logic to fix a bug where KVM would fail to wait
  for a target vCPU to respond if another, non-waiting kick is in flight.

Selftests:

- Provide empty installation rules for architectures that aren't supported by
  KVM selftests to fix build issues in CI environments.

- Fix KVM selftests' rules for generating arm64's sysreg headers so that the
  headers are properly (re)generated on incremental builds.

----------------------------------------------------------------
Amirmohammad Eftekhar (1):
      KVM: nVMX: Clear nested.smm.guest_mode on a failed RSM-to-L2

Andreas Grapentin (3):
      KVM: s390: arm64: Declare enum vcpu_sysreg
      KVM: s390: arm64: Fix kvm_arm64 module naming consistency
      KVM: s390: arm64: Tolerate unused functions in extracted source

Ard Biesheuvel (1):
      KVM: arm64: Don't livelock when AT can't resolve a fault IPA

Claudio Imbrenda (5):
      KVM: s390: Fix UCONTROL inconsistencies
      KVM: s390: Move some skey functions to headers
      KVM: s390: Fix idte_crste() clobber and table type
      KVM: s390: Improve unmapping of large ranges
      KVM: s390: vsie: Fix pinning using the wrong flag

Colton Lewis (3):
      irqchip/gic-v4: Use a separate lockdep class for vPE doorbell IRQs
      KVM: arm64: Force HCR_EL2.NV1 to RES0 unconditionally
      KVM: arm64: selftests: Verify HCR_EL2.NV1 is RES0 when E2H0 is NI_NV1

Dan Carpenter (9):
      KVM: arm64: nv: Invalidate whole L1 blocks on TLBI RIPAS2E1
      KVM: arm64: vgic: Don't truncate offsets in vgic_find_mmio_region()
      KVM: arm64: nv: Initialize hw_mmu to NULL for nested vCPUs
      KVM: arm64: nv: Forward PIR_EL2, PIRE0_EL2 and POR_EL2 traps
      KVM: arm64: nv: Forward CNTP_TVAL_EL02 and CNTV_TVAL_EL02 traps
      KVM: arm64: nv: Report EL2 registers with no trap forwarding
      KVM: arm64: Load the vcpu in KVM_SET_VCPU_EVENTS
      KVM: arm64: nv: Fix NULL dereference in kvm_pmu_nested_transition()
      KVM: arm64: nv: Ignore TLBI IPAS2E1 above the IPA limit

Davidlohr Bueso (1):
      RISC-V: KVM: Do not touch the envcfg CSRs on the SiFive P550

Fuad Tabba (27):
      irqchip/gic-v4: Clear the domain and fwnode pointers after freeing them
      irqchip/gic-v4: Unwind what its_alloc_vcpu_irqs() allocated on failure
      KVM: arm64: vgic: Tear down what vgic_init() created when it fails
      KVM: arm64: vgic-v4: Restore nr_vpes before freeing the vPE resources
      KVM: arm64: vgic-its: Clear an unqueued LPI before dropping its lock
      KVM: arm64: vgic-its: Remove the pending state of a cleared LPI
      KVM: arm64: vgic-its: Update GITS_CTLR.Enabled under its_lock
      KVM: arm64: vgic-v4: Don't allocate vPEs for a GICv2 VM
      KVM: arm64: vgic-v4: Don't allocate vPEs when userspace clears nASSGIcap
      KVM: arm64: vgic: Don't forward LPIs to a redistributor with LPIs disabled
      KVM: arm64: vgic-v3: Don't drop a pending LPI mapped with LPIs disabled
      KVM: arm64: selftests: Add MOVI and MOVALL commands to the ITS library
      KVM: arm64: selftests: Build a VM per test in vgic_lpi_stress
      KVM: arm64: selftests: Test MOVI and MOVALL on a pending LPI
      KVM: arm64: Disable host PMU counters for protected guests
      KVM: arm64: Ensure TLBs and I-cache are private to each vCPU in pKVM
      arm64: Add override for ID_AA64ISAR1_EL1.LS64
      KVM: arm64: Enable ST64BV0 for guests with FEAT_LS64_ACCDATA
      KVM: arm64: selftests: Add ACCDATA_EL1 to get-reg-list
      KVM: arm64: Clear the VM's feature bitmap when kvm_setup_vcpu() fails
      KVM: arm64: Clear the default PMU when kvm_setup_vcpu() fails
      KVM: arm64: Clear the whole hugetlb folio when sanitising MTE tags
      KVM: arm64: Clear the whole hugetlb folio when storing MTE tags
      KVM: arm64: Sanitise MTE tags when a permission fault installs a mapping
      arm64: mte: Add mte_clear_folio_tags()
      KVM: selftests: Fix arm64 sysreg header dependencies
      KVM: arm64: Hide generic ptrauth from protected VMs without ptrauth

Gautam Gala (2):
      KVM: s390: fix ESSA addressing exception injection in migration mode
      KVM: s390: pqap: fix AP status written to wrong half of GR1

Josef Bacik (1):
      KVM: nVMX: Clear nested.smm.guest_mode when freeing nested state

Li Jinyue (1):
      RISC-V: KVM: Fix double free of the split page cache

Marc Zyngier (14):
      Merge branch kvm-arm64/vgic-fixes-7.4-1 into kvmarm-master/fixes
      KVM: arm64: Reset TCR_EL2 according to guest's E2H mode
      KVM: arm64: Add ACCDATA_EL1 to the sysreg array
      KVM: arm64: Add context-switch of ACCDATA_EL1
      arm64: Add return value to mte_disable_tco_entry()
      KVM: arm64: Reenable MTE tag checking on exit from guest when running VHE
      KVM: arm64: Don't let a guest overwrite HCRX_EL2.MCE2
      Merge branch kvm-arm64/mmu-fixes-7.4-1 into kvmarm-master/fixes
      Merge branch kvm-arm64/pkvm-fixes-7.4-1 into kvmarm-master/fixes
      Merge branch kvm-arm64/ls64-accdata into kvmarm-master/fixes
      Merge branch kvm-arm64/misc-7.4-1 into kvmarm-master/fixes
      Merge branch kvm-arm64/misc-7.4-2 into kvmarm-master/fixes
      Merge branch kvm-arm64/sysreg-fixes-7.4-2 into kvmarm-master/fixes
      Merge branch kvm-arm64/mmu-fixes-7.4-2 into kvmarm-master/fixes

Matthias Goergens (1):
      Documentation/process: Add a maintainer entry profile for KVM/arm64

Michael Reeves (1):
      arm64: Apply existing Apple Silicon CPU workarounds to newer CPUs

Mostafa Saleh (1):
      KVM: arm64: Use consistent type for pool size

Myria Sarvay (1):
      arm64: Add CPU part numbers for newer Apple Silicon CPUs

Oliver Upton (2):
      KVM: arm64: nv: Correctly compute the effective TCR_EL1 for nVHE TCR_EL2
      KVM: arm64: Pass the PMU events to the hyp vCPU of non-protected guests

Paolo Bonzini (9):
      Merge tag 'kvm-s390-master-7.4-1' of git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD
      Merge tag 'kvm-s390-master-7.4-2' of git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD
      Merge tag 'kvmarm-fixes-7.4-2' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD
      Merge tag 'kvm-x86-fixes-7.4-rc4' of https://github.com/kvm-x86/linux into HEAD
      KVM: PPC: remove unnecessary #ifdef
      KVM: PPC: implement .flush_memslot for BookE and Book3S-PR
      KVM: SEV: never emulate after #NPF on paging structures
      Merge tag 'kvmarm-fixes-7.4-3' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD
      Merge tag 'kvm-riscv-fixes-7.4-1' of https://github.com/kvm-riscv/linux into HEAD

Pengpeng Hou (2):
      RISC-V: KVM: Validate AIA MMIO address ranges
      RISC-V: KVM: Disallow GPA-width changes after AIA init

Qingwei Hu (1):
      RISC-V: KVM: Validate PMU counter info using available counters

Sascha Bischoff (1):
      KVM: arm64: vgic: Serialise CTRL_INIT against vCPU creation

Sasha Levin (3):
      selftests: drivers/s390x: Select uvdevice tests using the target architecture
      KVM: selftests: Provide empty installation rules on unsupported ARCHs
      KVM: x86: Don't save the GPA of a fault on the guest's page tables

Sean Christopherson (10):
      KVM: Reject user accesses to guest memory if current->mm != kvm->mm
      KVM: nVMX: Don't force a full nested VM-Exit when destroying a vCPU
      KVM: PPC: Flush/zap all memslots on kvm_arch_flush_shadow_all()
      KVM: s390: Drop unused and unreachable kvm_arch_vcpu_should_kick()
      KVM: Add a @force param to __kvm_vcpu_kick() for PPC backwards compatibility
      KVM: PPC: Explicitly force IPIs when directly kicking vCPUs
      KVM: MIPS: Rework kvm_arch_vcpu_should_kick() to use standard implementation
      KVM: Move kvm_arch_vcpu_should_kick() to common code as kvm_vcpu_should_kick()
      KVM: Plumb the full request into __kvm_vcpu_kick()
      KVM: Drop kvm_vcpu_should_kick() and use kvm_request_needs_ipi()

SeungJu Cheon (1):
      KVM: riscv: Set Accessed bit in dirty-log write fault fast path

Shivansh Dhiman (1):
      KVM: SVM: Clear VMCB save area instead of entire VMCB on shutdown intercept

Steffen Eiden (1):
      KVM: s390: arm64: Turn vcpu->arch.pause into a counter

Vincent Donnefort (4):
      KVM: arm64: Make __vgic_v3_init_lrs HVC always available
      KVM: arm64: pkvm: Fix missing reset of GICv3 LRs
      KVM: arm64: pkvm: Reset GICv3 LRs in the hypervisor
      KVM: arm64: Synchronise kvm_host_data before host deprivileging

Wei-Lin Chang (5):
      KVM: arm64: nv: Don't advertise FEAT_LPA2 for guest stage-1
      arm64: sysreg: Add TCR_EL2 to sysreg infrastructure
      KVM: arm64: Convert TCR_EL2 to config-driven sanitisation
      KVM: arm64: Fix dirty logging detection in ring-only mode
      KVM: arm64: Remove stale remark on canonical IPA alignment

Will Deacon (1):
      KVM: arm64: Use S1E1A when Stage-1 PIE is supported

Xuheng Li (3):
      KVM: arm64: Add an ISB after mapping a hyp fixmap slot
      KVM: arm64: Don't replace a valid hyp block mapping with a table
      KVM: arm64: Order a later pinner's accesses after the hyp mapping

Yangyu Chen (1):
      RISC-V: KVM: Fix G-stage page table memory leak on VM destroy

Yosry Ahmed (1):
      KVM: SVM: Update tracked pCPU on pCPU switch

 Documentation/admin-guide/kernel-parameters.txt    |   3 +
 Documentation/process/maintainer-kvm-arm64.rst     | 181 +++++++++++++++
 MAINTAINERS                                        |   2 +
 arch/arm64/include/asm/cpufeature.h                |   5 +
 arch/arm64/include/asm/cputype.h                   |  28 +++
 arch/arm64/include/asm/kvm_arm.h                   |  13 --
 arch/arm64/include/asm/kvm_asm.h                   |   2 +-
 arch/arm64/include/asm/kvm_emulate.h               |   3 +
 arch/arm64/include/asm/kvm_host.h                  |   7 +-
 arch/arm64/include/asm/kvm_nested.h                |  38 ++-
 arch/arm64/include/asm/kvm_pgtable.h               |   2 +-
 arch/arm64/include/asm/mte.h                       |  14 +-
 arch/arm64/include/asm/sysreg.h                    |   1 -
 arch/arm64/include/asm/virt.h                      |   2 +-
 arch/arm64/kernel/cpu_errata.c                     |  12 +
 arch/arm64/kernel/cpufeature.c                     |  19 ++
 arch/arm64/kernel/mte.c                            |  15 +-
 arch/arm64/kernel/pi/idreg-override.c              |   2 +
 arch/arm64/kvm/arm.c                               |  73 +++---
 arch/arm64/kvm/config.c                            | 119 +++++++++-
 arch/arm64/kvm/emulate-nested.c                    |  10 +-
 arch/arm64/kvm/guest.c                             |  11 +-
 arch/arm64/kvm/hyp/include/hyp/fault.h             |   5 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h            |  24 +-
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h         |  23 ++
 arch/arm64/kvm/hyp/include/nvhe/early_alloc.h      |   2 +-
 arch/arm64/kvm/hyp/include/nvhe/gfp.h              |   4 +-
 arch/arm64/kvm/hyp/nvhe/early_alloc.c              |   2 +-
 arch/arm64/kvm/hyp/nvhe/hyp-main.c                 |  16 +-
 arch/arm64/kvm/hyp/nvhe/mem_protect.c              |   8 +
 arch/arm64/kvm/hyp/nvhe/mm.c                       |   1 +
 arch/arm64/kvm/hyp/nvhe/page_alloc.c               |   6 +-
 arch/arm64/kvm/hyp/nvhe/pkvm.c                     |  22 +-
 arch/arm64/kvm/hyp/nvhe/psci-relay.c               |   4 +
 arch/arm64/kvm/hyp/nvhe/switch.c                   |  24 ++
 arch/arm64/kvm/hyp/nvhe/sys_regs.c                 |   4 +-
 arch/arm64/kvm/hyp/pgtable.c                       |  10 +-
 arch/arm64/kvm/hyp/vhe/switch.c                    |   7 +
 arch/arm64/kvm/mmu.c                               |  21 +-
 arch/arm64/kvm/nested.c                            |  23 ++
 arch/arm64/kvm/pkvm.c                              |   6 +
 arch/arm64/kvm/pmu-emul.c                          |   3 +
 arch/arm64/kvm/sys_regs.c                          |  61 ++++-
 arch/arm64/kvm/vgic/vgic-init.c                    |  21 +-
 arch/arm64/kvm/vgic/vgic-its.c                     |  68 +++---
 arch/arm64/kvm/vgic/vgic-kvm-device.c              |   2 +
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                 |  40 ++--
 arch/arm64/kvm/vgic/vgic-mmio.c                    |   4 +-
 arch/arm64/kvm/vgic/vgic-mmio.h                    |   2 +-
 arch/arm64/kvm/vgic/vgic-v3.c                      |   3 +-
 arch/arm64/kvm/vgic/vgic-v4.c                      |   5 +-
 arch/arm64/kvm/vgic/vgic.c                         |  12 +-
 arch/arm64/kvm/vgic/vgic.h                         |   1 +
 arch/arm64/tools/cpucaps                           |   1 +
 arch/arm64/tools/sysreg                            | 125 ++++++++++
 arch/loongarch/kvm/vcpu.c                          |   5 -
 arch/mips/kvm/mips.c                               |   5 -
 arch/powerpc/include/asm/kvm_host.h                |   1 -
 arch/powerpc/include/asm/kvm_ppc.h                 |  13 +-
 arch/powerpc/kvm/book3s.c                          |   4 +-
 arch/powerpc/kvm/book3s_pr.c                       |  10 +-
 arch/powerpc/kvm/booke.c                           |  16 +-
 arch/powerpc/kvm/e500_emulate.c                    |   2 +-
 arch/powerpc/kvm/powerpc.c                         |  18 +-
 arch/riscv/include/asm/kvm_gstage.h                |   2 +
 arch/riscv/include/asm/kvm_host.h                  |   1 +
 arch/riscv/kvm/aia_device.c                        |  49 +++-
 arch/riscv/kvm/gstage.c                            |  22 ++
 arch/riscv/kvm/main.c                              |   9 +
 arch/riscv/kvm/mmu.c                               |  12 +-
 arch/riscv/kvm/vcpu.c                              |  11 +-
 arch/riscv/kvm/vcpu_config.c                       |  16 +-
 arch/riscv/kvm/vcpu_pmu.c                          |   2 +-
 arch/riscv/kvm/vcpu_sbi_fwft.c                     |  20 +-
 arch/riscv/kvm/vm.c                                |   5 +-
 arch/s390/include/asm/kvm_host_arm64.h             |   8 +-
 arch/s390/kvm/arm64/Makefile                       |  12 +-
 arch/s390/kvm/arm64/copy-arm64c.awk                |  10 +-
 arch/s390/kvm/gmap/dat.c                           |  31 +--
 arch/s390/kvm/gmap/dat.h                           |  54 ++++-
 arch/s390/kvm/gmap/gmap.c                          | 190 +++++++++++----
 arch/s390/kvm/s390/priv.c                          |   8 +-
 arch/s390/kvm/s390/s390.c                          |   7 -
 arch/s390/kvm/s390/vsie.c                          | 133 ++++-------
 arch/x86/kvm/mmu/mmu.c                             |   2 +
 arch/x86/kvm/svm/svm.c                             |  73 ++++--
 arch/x86/kvm/vmx/nested.c                          |  10 +-
 arch/x86/kvm/vmx/sgx.c                             |   2 +-
 arch/x86/kvm/vmx/vmx.c                             |  15 +-
 arch/x86/kvm/x86.c                                 |  15 +-
 arch/x86/kvm/x86.h                                 |   4 +
 drivers/irqchip/irq-gic-v4.c                       |  39 +++-
 include/linux/kvm_host.h                           |  32 ++-
 .../selftests/drivers/s390x/uvdevice/Makefile      |  19 +-
 tools/testing/selftests/kvm/Makefile               |   4 +-
 tools/testing/selftests/kvm/Makefile.kvm           |  16 +-
 tools/testing/selftests/kvm/arm64/get-reg-list.c   |   2 +
 tools/testing/selftests/kvm/arm64/hello_el2.c      |  15 ++
 .../testing/selftests/kvm/arm64/vgic_lpi_stress.c  | 258 +++++++++++++++++++--
 .../selftests/kvm/include/arm64/gic_v3_its.h       |   2 +
 tools/testing/selftests/kvm/lib/arm64/gic_v3_its.c |  28 +++
 virt/kvm/kvm_main.c                                |  52 +++--
 102 files changed, 1857 insertions(+), 529 deletions(-)
 create mode 100644 Documentation/process/maintainer-kvm-arm64.rst

