Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E562E762C
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 06:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790403375; cv=none; b=jzmHxs9p7Sk1wQs4rEDCHYU3aqTALo3U1HVQgXZupJ3aENvsjI1+tRfAVOWqz34ERaKnNhaMLJQxmanS1eUznhiXzIFGRwaAEaojtLqF0Fz068MfQCUy7lYTDOwnMMoane7d8SN1V7vijvrNOCxo4cG2DNRWKhuuX8HMNLD6YOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790403375; c=relaxed/simple;
	bh=GGkVni7RCwX5g87Z5KDjuJ94eKLTDaV6IC8n/M8yEW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VC6sYB0EYvmZ5GGQn0uemAzXQMMpEsgp60FYJsnNXoo8CQGwFaQeevNsLI1D76w/GhfPwk8VPh78fyMyAPGhhjxvtIkoWBroyUG5LDww4dVQkr5bFeSUHsZtlpMLuiCBnS11xyqmcPVVQ2UF5L33ygLD6TeVMT960zXobvInci4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S9jbCjsz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JgVbUuHQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S9jbCjsz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JgVbUuHQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790403371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=my1WoGbjs4+PwtHjFF35v+bu7/CvxCy/eNbIFEbJUgU=;
	b=S9jbCjsztmnUjz+lP1dlm460igc48HOqTwC67uJqXZz2ZlGppoX3b/kcUIfJA6vvcfAJii
	O63buAEHeEOCxIhE3/JVt7xT1SV1BgKDseZiLu5BpzOfUwjE0YpqO92czl0+WPaHPP+yhe
	qKVz6dnQ3N5X/pbC02/RnJlwljQ79EA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-eW5HvFQsNHWf94iEDFYVDg-1; Sat, 26 Sep 2026 02:16:10 -0400
X-MC-Unique: eW5HvFQsNHWf94iEDFYVDg-1
X-Mimecast-MFC-AGG-ID: eW5HvFQsNHWf94iEDFYVDg_1790403369
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4887b0303b0so851212f8f.3
        for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 23:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790403369; x=1791008169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=my1WoGbjs4+PwtHjFF35v+bu7/CvxCy/eNbIFEbJUgU=;
        b=JgVbUuHQ9AXOZ5zHZZ2VMnmRFAbbfYo+HZgrrltYG90M1USYoJWfeFmAJpSEQ+Zusw
         YelizeKpjS8THydOun9mt6ua89iYkbKr1rAKA++Za46mW3swzaSQqEwLrtXGyCi/6W0o
         ZxWieXdWt5zHYP6A4Hm7cwT3tL5OwTKgDUYjYGHESM3dAYyKA7MR8bZbhk7CWamW6pL0
         Zj4sqgVzwxEWATk6WTb/zsiYwAK1B+I+kaCieKRbHw4eT+d08ORr+Q6osl8RB1pIBcT9
         +ihr56Dsas3tz830vWYGY7aUBB/UeBjisQCJNU4cpJYjfgycUu4G+azP8/CH/Otn9d3y
         YtrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790403369; x=1791008169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=my1WoGbjs4+PwtHjFF35v+bu7/CvxCy/eNbIFEbJUgU=;
        b=mi285VdO0M5uLhdwNIFcTHvdvjjW9r+DY1eUpcolJag6NViXE3I9CyEgxzekR0dSIQ
         4HEGCT7GlR2gxB5pCEl1VeGagae4vY6Fxbi1NkyQHr8xikuZrN/eKNgCjotmNWeevf8y
         lRHNnTsSqPGf4prNTsFjmNEEoFMLfvGffCf/vYEiwCAqz+6XKNdDeEULoaEJTqdTAqDA
         39HKH7iQCawnLBaxnmYwkNYYNahn7C6DC3/OvlHpL2gVCwPjdm4b7g6tCjx/GUbBBdMh
         RZ3SYU4s1SPEnkUzaFwUuCrcHOqL0IZ6eP0rbSpjTykcZCItCu+TbCKJ0DFHAqhGuI57
         LFJA==
X-Forwarded-Encrypted: i=1; AKwUvBzzTo7FN4ivkaSnAExkVfFkvorNJMEPnl3FQim6+8/Bk+/spwniVXb4u1ce0YZeA3FykBc=@vger.kernel.org
X-Gm-Message-State: AFuF++m3E4LEWSGjgb12AsXpbENPP/EOGCedS7RXxL4JsetU8MNm7k2L
	Nlv2NJKA2uadfmyZ129XkQaYgvR6vbXXkptq1Mb7bw5/Nnk6aMHfbtoHrKCpcuYSgGvzqCJEyRT
	jV8iVPpc2OU6hm0OWtMFvNPiCPAQrUOub5EDduil5Ove7uKOiy7zB4w+mE+LYmA==
X-Gm-Gg: AYBFou25lfF9NEkr655Kf3hsrdiRcpielGZBK9+23uQnG14EYq5m01RlxznRKk8Ild+
	0fhnHUMTJ3Q6C2X2TeW/9AZOG6FNDaBbTc6jqbbRwRQQ1We1ZGc6wpJ2AdDGl9M5rYweEL65cWp
	Mv2XTvIB6g5mMprhHnRrL817zRy/tNqme9JCuRPoqvpAjBasex34bC9iR6yVVAGzHzSUZhHE7Bd
	zx7m8hW9Iy/PdMVV8VTNsI5rTIfgdW3rBPth1QfrIQWz3wt+wreqjPEHfV1HHzivhRU9SxIBkTl
	vHapv2GQ9q+xsKhGBMGWwnqIZepZl6PM4jFgEozMJaO0+AXMw53qjbWS+HQbm8ulNKnOXfqilnj
	gXDYBtMQQOUFVbvltGidbVJ+p9ShWQ4VrsyjMA15unZI+b4CYE/Y4JLnDh2jQx3aXUssHuLqHeX
	jHWSXG
X-Received: by 2002:a5d:6f1c:0:b0:488:8987:662e with SMTP id ffacd0b85a97d-48889876a9dmr579032f8f.48.1790403368715;
        Fri, 25 Sep 2026 23:16:08 -0700 (PDT)
X-Received: by 2002:a5d:6f1c:0:b0:488:8987:662e with SMTP id ffacd0b85a97d-48889876a9dmr579001f8f.48.1790403368265;
        Fri, 25 Sep 2026 23:16:08 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a2acb4dsm11861735f8f.0.2026.09.25.23.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 23:16:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [GIT PULL] KVM changes for 7.3-rc5
Date: Sat, 26 Sep 2026 08:16:06 +0200
Message-ID: <20260926061606.715681-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit fd73f4a6659897191fa0d40695fe370925dd3780:

  Linux 7.3-rc3 (2026-09-13 14:38:02 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to c2f24f140c2ee6c00775c2a93c6ac931acec2b60:

  Merge tag 'kvm-x86-fixes-7.3-rc5' of https://github.com/kvm-x86/linux into HEAD (2026-09-26 00:40:07 -0400)

A very large number of fixes.  In terms of lines of code what dominates is
a selftest and a couple pKVM files (arch/arm64/kvm/hyp/nvhe), but there's
a lot of stuff that accumulated since rc1.  I'll send more next week.

Paolo
----------------------------------------------------------------
Arm:

- Invalidate the ITS translation cache when the guest changes the
  base address of the ITS tables (Fuad Tabba)

- Skip saving ITS devices with device IDs that are out-of-bounds
  rather than failing the entire ITS save ioctl (Fuad Tabba)

- Close race between VM teardown and invalidations of nested MMUs
  when handling MMU operations that are allowed to block
  (Lorenzo Stoakes)

- Various fixes for the handling of the host's untrusted SVE
  configuration in pKVM (Fuad Tabba)

- Make sure that empty SMCCC ranges based at 0 are rejected by the
  kvm_smccc_set_filter() (Karl Mehltretter)

- Revoke the host mapping for pKVM's private stack pages, along
  with a new sanity check that all mappings in the hyp's private
  VA range have been correctly marked as hyp-owned (Fuad Tabba)

- Lifetime fixes for the array of shadow stage-2 MMUs, ensuring that
  concurrent vCPU initialization cannot relocate in-use MMUs. Defer
  the freeing of shadow stage-2 MMUs to the point that no other users
  (e.g. MMU notifier) could reference them (Marc Zyngier)

- Drop useless WARN when rejecting an unsupported ioctl for pKVM
  (Fuad Tabba)

- Fix the steal_time selftest to install correctly-sized mappings for
  non-4K hosts (Sebastian Ott)

- Correct mapping of fine-grained trap for GCSPOPX instruction
  (Mark Brown)

- Fix KVM_BUG_ON() due to missing handling of DBGBXVR<n> from 32-bit
  guests (Karl Mehltretter)

RISC-V:

- Synchronize hrtimer during VCPU teardown.

- Fix the conversion between vsip and hvip values.

- Serialize IMSIC attributes with vCPU migration.

- Release unused page after MMU invalidation.

- Propagate interrupted G-stage faults to KVM user-space as EINTR.

- Fix nested acceleration hfence entry update order.

- Fix sdata leak and stale snapshot_addr in snapshot_set_shmem.

- Preserve firmware counter value across PMU counter stop/start.

- Report PMU snapshot write failure to the guest.

- Fix perf-backed counter accounting across PMU stop and read.

- Correctly propagate error of a hart status SBI call.

s390:

- Ensure that accesses through kvm_arch_set_irq_inatomic mark as dirty
  the pages that contain indicator and summary bits.

- Fix compile warning for kvm_s390_update_cmma_dirty().

- Fix incorrect propagation of ENOENT from _gaccess_shadow_fault() to
  userspace.

- Move s390_kvm_mmu_commit_memory_region() into
  s390_kvm_mmu_prepare_memory_region() so that it can fail instead of WARN.

- Add missing srcu in kvm_s390_set_irq_state().

- Fix potential races in storage functions.

- Fix race in _destroy_pages_crste().

- Fix issues in the handling of KVM interrupt and page resources, when a
  queue that is assigned to a mediated device (mdev) is removed from the
  host's AP configuration.

- Fix loop condition in uv_find_secrets.

- Prevent potential out-of-bounds read.

x86:

- Fix a brown paper bag bug where KVM would incorrectly treat Intel PMU MSRs
  as valid on AMD.

- Fix a regression in the hardware disable selftest where it checked the wrong
  macro when detecting glibc support (breaks at least musl).

- Never clear KVM_REQ_VM_DEAD so that dead VMs stay dead, which is especially
  important for KVM_BUG_ON() flows, which often guard more dangerous bugs.

- Re-pend GET_NESTED_STATE_PAGES if getting the pages fails, to fix a bug
  where KVM would let userspace run a broken setup with stale vmcs12 pages.

- Fix a class of bugs where KVM would fail to fill kvm_run exit fields if
  getting nested pages failed.

- Treat reserved entries in the memory attributes xarray as "no attributes",
  to fix false positives when checking for mixed attributes.

- Fix memcg accounting for the memory attributes xarray (the xarray library
  subtly requires the xarray to be configured for accounting upfront; the gfp
  flags taken at runtime are used only rarely).

- Don't pre-reserve xarray entries when storing empty attributes, as storing
  NULL must not require memory allocation (KVM and other subsystems heavily
  rely on this behavior).

- Fix a memory leak and a cache maintenance issue related to doing intra-host
  migration on an SEV guest.

----------------------------------------------------------------
Anthony Krowiak (1):
      s390/vfio-ap: fix KVM GISC and page leak when queue removed from host config

Claudio Imbrenda (8):
      KVM: s390: Fix dirty marking in adapter_indicators_set*()
      KVM: s390: Fix compile warning for kvm_s390_update_cmma_dirty()
      KVM: s390: Fix _gaccess_shadow_fault()
      KVM: s390: Refactor dat_set_slot()
      KVM: s390: Move all code into s390_kvm_mmu_prepare_memory_region()
      KVM: s390: Add missing srcu in kvm_s390_set_irq_state()
      KVM: s390: Fix potential races in dat skey functions
      KVM: s390: Fix race in _destroy_pages_crste()

David Ballesteros (1):
      KVM: Ensure memory attributes xarray nodes are accounted to the caller's memcg

Fuad Tabba (13):
      KVM: arm64: vgic-its: Free the caches when GITS_BASER changes
      Revert "KVM: arm64: vgic-its: Don't save collections the table cannot hold"
      KVM: arm64: vgic-its: Skip unreachable devices instead of failing the save
      KVM: arm64: selftests: Add ITS table save tests
      KVM: arm64: Validate the SVE vector length in pkvm_vcpu_init_sve()
      KVM: arm64: Do not clear VM-wide SVE feature on vCPU init failure
      KVM: arm64: Key unpin_host_sve_state() on the state it unpins
      KVM: arm64: Derive GUEST_HAS_SVE from the SVE feature bit at EL2
      KVM: arm64: Transfer the hyp stack pages out of the host stage-2
      KVM: arm64: Match hyp text by physical address in fix_host_ownership()
      KVM: arm64: Move the private VA allocation cursor to __io_map_next
      KVM: arm64: Check every private mapping is hyp-owned at pKVM init
      KVM: arm64: Don't WARN on an unknown VM ioctl in protected mode

Jim Mattson (1):
      KVM: x86/pmu: Move Intel PMU global MSRs to intel_is_valid_msr()

Karl Mehltretter (3):
      KVM: arm64: Return -EINVAL for an empty SMCCC filter range at base 0
      KVM: arm64: selftests: Test empty SMCCC filter range at base 0
      KVM: arm64: Fix AArch32 DBGBXVR<n> handling

Lorenzo Stoakes (ARM) (2):
      KVM: arm64: Fix spurious warning for benign stage 2 teardown race
      KVM: arm64: nv: Fix null ptr deref on nested wp/unmap, teardown race

Marc Zyngier (2):
      KVM: arm64: nv: Fix life cycle of the nested_mmus array
      KVM: arm64: nv: Delay freeing of shadow S2 structures until VM destruction

Mark Brown (1):
      KVM: arm64: Fix FGT mapping for HFGITR_EL2.nGCSEPP

Myeonghun Pak (1):
      RISC-V: KVM: Synchronize hrtimer callback during teardown

Paolo Bonzini (4):
      Merge tag 'kvm-s390-master-7.3-1' of https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD
      Merge tag 'kvmarm-fixes-7.3-1' of https://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD
      Merge tag 'kvm-riscv-fixes-7.3-1' of https://github.com/kvm-riscv/linux into HEAD
      Merge tag 'kvm-x86-fixes-7.3-rc5' of https://github.com/kvm-x86/linux into HEAD

Sean Christopherson (6):
      KVM: selftests: Use __GLIBC__, not _GNU_SOURCE, to detect actual glibc
      KVM: Never clear KVM_REQ_VM_DEAD from a vCPU's requests
      KVM: x86: Re-pend GET_NESTED_STATE_PAGES if getting said pages fails
      KVM: x86: Fill kvm_run exit fields in common get_nested_state_pages() error paths
      KVM: SEV: Free have_run_cpus during VM destruction even if VM is no longer SEV
      KVM: SEV: Do cache maintenance on the source VM during intra-host migration

Sebastian Ott (1):
      KVM: selftests: fix steal_time for arm64 with host page size > 4K

SeungJu Cheon (3):
      RISC-V: KVM: Preserve firmware counter value across stop/start
      RISC-V: KVM: Report snapshot write failure to the guest
      RISC-V: KVM: Fix perf-backed counter accounting across stop and read

Steffen Eiden (2):
      s390/uv: Fix loop condition in uv_find_secrets
      s390/uv: Prevent potential out-of-bounds read

Tan Chi (1):
      RISC-V: KVM: Fix HSM hart status error propagation

Xie Bo (3):
      RISC-V: KVM: Serialize IMSIC attributes with vCPU migration
      RISC-V: KVM: Release unused page after MMU invalidation
      RISC-V: KVM: Propagate interrupted G-stage faults

Yicong Yang (1):
      RISC-V: KVM: Fix the conversion between vsip and hvip

Zeng Chi (2):
      KVM: Don't treat reserved xarray entries as having memory attributes
      KVM: Don't pre-reserve xarray entries when storing empty/NULL attributes

Zongmin Zhou (2):
      KVM: riscv: Fix NACL hfence entry update order
      RISC-V: KVM: Fix sdata leak and stale snapshot_addr in snapshot_set_shmem

 arch/arm64/include/asm/kvm_host.h                  |   2 +-
 arch/arm64/include/asm/kvm_nested.h                |   3 +-
 arch/arm64/include/asm/kvm_pkvm.h                  |   3 +-
 arch/arm64/kvm/arm.c                               |  10 +-
 arch/arm64/kvm/emulate-nested.c                    |   2 +-
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h      |   2 +
 arch/arm64/kvm/hyp/include/nvhe/mm.h               |   1 +
 arch/arm64/kvm/hyp/nvhe/mem_protect.c              |  20 +
 arch/arm64/kvm/hyp/nvhe/mm.c                       |  79 +++-
 arch/arm64/kvm/hyp/nvhe/pkvm.c                     |  29 +-
 arch/arm64/kvm/hyp/nvhe/setup.c                    |  16 +-
 arch/arm64/kvm/hypercalls.c                        |   3 +-
 arch/arm64/kvm/mmu.c                               |  15 +-
 arch/arm64/kvm/nested.c                            | 115 +++---
 arch/arm64/kvm/sys_regs.c                          |   1 +
 arch/arm64/kvm/vgic/vgic-its.c                     |  46 ++-
 arch/riscv/include/asm/csr.h                       |  20 +-
 arch/riscv/kvm/aia_imsic.c                         |  11 +-
 arch/riscv/kvm/mmu.c                               |  10 +-
 arch/riscv/kvm/nacl.c                              |  20 +-
 arch/riscv/kvm/vcpu.c                              |   3 +-
 arch/riscv/kvm/vcpu_exit.c                         |   2 +-
 arch/riscv/kvm/vcpu_onereg.c                       |   8 +-
 arch/riscv/kvm/vcpu_pmu.c                          |  41 +-
 arch/riscv/kvm/vcpu_sbi_hsm.c                      |   4 +-
 arch/riscv/kvm/vcpu_timer.c                        |   5 +-
 arch/s390/kernel/uv.c                              |   8 +-
 arch/s390/kvm/gmap/dat.c                           |  65 +--
 arch/s390/kvm/gmap/dat.h                           |  10 +-
 arch/s390/kvm/gmap/gmap.c                          |   6 +-
 arch/s390/kvm/gmap/kvm_mmu.c                       |  91 ++---
 arch/s390/kvm/gmap/kvm_mmu.h                       |   4 -
 arch/s390/kvm/s390/gaccess.c                       |  13 +
 arch/s390/kvm/s390/interrupt.c                     |  81 ++--
 arch/s390/kvm/s390/s390.c                          |   3 +-
 arch/s390/kvm/s390/s390.h                          |   2 +-
 arch/x86/kvm/mmu/mmu.c                             |   2 +-
 arch/x86/kvm/pmu.c                                 |   8 -
 arch/x86/kvm/svm/nested.c                          |   7 +-
 arch/x86/kvm/svm/sev.c                             |  18 +-
 arch/x86/kvm/vmx/nested.c                          |  15 +-
 arch/x86/kvm/vmx/pmu_intel.c                       |   3 +
 arch/x86/kvm/vmx/tdx.c                             |   2 +-
 arch/x86/kvm/x86.c                                 |   6 +-
 drivers/s390/crypto/vfio_ap_ops.c                  |  18 +-
 include/linux/kvm_host.h                           |   9 +-
 tools/arch/riscv/include/asm/csr.h                 |  20 +-
 tools/testing/selftests/kvm/Makefile.kvm           |   1 +
 tools/testing/selftests/kvm/arm64/smccc_filter.c   |   4 +
 tools/testing/selftests/kvm/arm64/vgic_its_save.c  | 441 +++++++++++++++++++++
 .../testing/selftests/kvm/hardware_disable_test.c  |   6 +-
 tools/testing/selftests/kvm/steal_time.c           |  30 +-
 virt/kvm/kvm_main.c                                |  35 +-
 53 files changed, 1032 insertions(+), 347 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/arm64/vgic_its_save.c

