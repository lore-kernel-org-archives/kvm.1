Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182FE1A9FB7
	for <kvm@vger.kernel.org>; Sun, 15 Mar 2026 06:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773557840; cv=none; b=OGIW9w7O+FaPLaEABYiQ4p+t4ryGMBd7ciGejewf0vhl0FIdT4E+KfkIOYy5YuO2brHXI9mlSDGSN1LId2m4uRigQEmp0CMLXbItfHNOJ/xjf4L7MmJP1a+KP7Qqa7imkkTi2VPAcw2t91h4mrS0XGatk9Pm4VZKM/tDIaLcJGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773557840; c=relaxed/simple;
	bh=LpBSfwG0Xgbji94S2S4UQfYrTCdHbO/7WU61UAaEdCU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lwdEIocYTLgEeIV9xJLoRNlK4rZDFYD+HgLGJImauXzPDs2oAQ1yVxNW8zKzn5nbQgEtF9dBVECYR5v84mM5UXDSURRrckRaLs9TYlJps1HsAOkyBY05gTsgiM48dEbWDHK0WHG9Z4LcGtVHB6U/Ht6R4jQZbF0nVWWhRHH1b2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YKNn53OY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GYSBTs07; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YKNn53OY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GYSBTs07"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773557838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FBlSyS6aJz3YvYnr1MoFHAjY463sqbVKmOSW14QHd/0=;
	b=YKNn53OYYVU4Ay3IYnulvxmzIfwC1W8wUABRzE+AzarXufCZ4EPWjb0sTGw6pGZKi5gA/R
	AqgXayBvoCUqPYlxFLwojVEiNAbDDNKLbWHLuUqENoxC8JqDD81nEdbf8mHYrrfDGwQVcK
	Ku5/InC1qIX9OziKscIahosnpcaOYxU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-ASyYDKtZNGO4x_pQkO02cQ-1; Sun, 15 Mar 2026 02:57:16 -0400
X-MC-Unique: ASyYDKtZNGO4x_pQkO02cQ-1
X-Mimecast-MFC-AGG-ID: ASyYDKtZNGO4x_pQkO02cQ_1773557835
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48535f4d5e1so34527755e9.0
        for <kvm@vger.kernel.org>; Sat, 14 Mar 2026 23:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773557835; x=1774162635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FBlSyS6aJz3YvYnr1MoFHAjY463sqbVKmOSW14QHd/0=;
        b=GYSBTs07QED+oCn2Z1ztQ8hbnrYZbz/sm6UL1Ezp6ZaCSaHfHnDZG6WSKK1kox70Vz
         w//YEClOBTtC6zUBiTyOKyl8cmHeJmBOltwxKzWlggGdvi33cj3Fjpp12K6N4xupo9QR
         M6CacXAwJZiNxPre22kOI7rH1l/swQ2p4s1f82e308kMwQ9s7w+1aSy8MQgSGCfyMAnc
         eo1ZkuoTA8TZcyryAOkkokK3vx+uT7IqJ/88jD5Q4SKQ0VhVuBTqtoroymAsNDUnKS4K
         Pgj/IZ9wzOBiNdGsXRzlEidz2k9r3+k1Ik0yyJFl/eOf2N5XHuATsc5AM2rSeJBs3Q1q
         Eukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773557835; x=1774162635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBlSyS6aJz3YvYnr1MoFHAjY463sqbVKmOSW14QHd/0=;
        b=CePCaJkorxvhGbRt0Z4qFilB/ss5FrW4Lpzctd1SQAv5ESFzicqMnHeuhuGXXKkvQB
         mtQDYq2w50SMPL1YbpHGSvdDBlW9ssY//J0aMlymuoZaN3kkZNR1N1+gJIjmrxmYDFmX
         60YLGqkgNfxDTFILqAQ39wmORmhwqj9vYPygmaj7sxQ/GCBHjEberFEvmBsU0ZQ+rkTT
         DBfmYRc4iVUw0bvX+iE2zQ4ME9kXbeJaFyWXBUpeEVRYGUPcH8CJirhHuYDoosljjne6
         6Y0pSkIRg9VOsLY2PI5AKqtHydaNSCFDMjzpJMhCT+cM5FARDm0yiKjLPWVhzQ8CMBon
         NIJg==
X-Forwarded-Encrypted: i=1; AJvYcCVEwCDT03a43FWh4pnm2n32lXOS9YGldH+DAJIlvLK3tGSxiDl7ix8bz6u4rqKPPWhaIgo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2411j/8hnXH+tSBi77WT1Q18kwqRMe9bUalcSZR9BpDNk3brq
	R9zsxipNQE9e8PzrYZ9axSf2JHl8/NLm/gDQI7h/XEanXuCuYDwJgY9V2pOJU+MHTAMUwvjKbKA
	ePZjHl6Fh3rsYOK9TLOGEs1JCbP6oV1+CchKzMm/uDKBd/skkNTpVIV7ysPkILg==
X-Gm-Gg: ATEYQzy3+03Wx7v750vBJeqPGj+4r+iDkpeIeIAsU8EUF5RWs4/usmmUz2RJr3aR9QG
	hyrd/Biz2qTFY55C+esTTdzkdIINvJ7SmZz5wOYvvYJ7o8/1Loxyt/Ffac9buiAmDiAyzyRp/+1
	RTgHom+yYhYj3d2DFcYpzyWE78EutOZSjHIlabD5H9OJ+6hjabhY4oM9kJUi09GLZusrlshWZ7O
	0S9iNC4l0I2lP1QKUHsijYj1Pw3X3dE6C/mg1a97MDldOO6dEoo2iz3qAO0wcCvOofwduNQAkvl
	6rnZ8H0o1/gVBBkoaydbrMH/hFuwoEy6p8Oih+7+z7zLYOvG1rlUGbRwZnzApvkKAsDvV5+I/By
	ZjtnhAkMJJG52vKB9nuilhf/8Y1Rx4AGvmXE1WXA7UAU8prEmBrqBcwztlTTt8fKZ9vH2I7v/T0
	GUGYHh3bCgxiYhMMQfLTYiHPyP+Ss=
X-Received: by 2002:a05:600c:1388:b0:485:3ee1:eba5 with SMTP id 5b1f17b1804b1-4855670297amr146277755e9.27.1773557834564;
        Sat, 14 Mar 2026 23:57:14 -0700 (PDT)
X-Received: by 2002:a05:600c:1388:b0:485:3ee1:eba5 with SMTP id 5b1f17b1804b1-4855670297amr146277535e9.27.1773557834051;
        Sat, 14 Mar 2026 23:57:14 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48556426be9sm66127875e9.9.2026.03.14.23.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 23:57:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [GIT PULL] KVM fixes for Linux 7.0-rc4
Date: Sun, 15 Mar 2026 07:57:10 +0100
Message-ID: <20260315065711.249669-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 11439c4635edd669ae435eec308f4ab8a0804808:

  Linux 7.0-rc2 (2026-03-01 15:39:31 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to d2ea4ff1ce50787a98a3900b3fb1636f3620b7cf:

  KVM: selftests: Verify SEV+ guests can read and write EFER, CR0, CR4, and CR8 (2026-03-12 17:31:53 +0100)

Quite a large pull request, partly due to skipping last week
and therefore having material from ~all submaintainers in this
one.  About a fourth of it is a new selftest, and a couple more
changes are large in number of files touched (fixing a
-Wflex-array-member-not-at-end compiler warning) or lines changed
(reformatting of a table in the API documentation, thanks rST).

But who am I kidding---it's a lot of commits and there are a lot
of bugs being fixed here, some of them on the nastier side like
the RISC-V ones.

Thanks,

Paolo

----------------------------------------------------------------
ARM:

- Correctly handle deeactivation of interrupts that were activated from
  LRs.  Since EOIcount only denotes deactivation of interrupts that
  are not present in an LR, start EOIcount deactivation walk *after*
  the last irq that made it into an LR.

- Avoid calling into the stubs to probe for ICH_VTR_EL2.TDS when
  pKVM is already enabled -- not only thhis isn't possible (pKVM
  will reject the call), but it is also useless: this can only
  happen for a CPU that has already booted once, and the capability
  will not change.

- Fix a couple of low-severity bugs in our S2 fault handling path,
  affecting the recently introduced LS64 handling and the even more
  esoteric handling of hwpoison in a nested context

- Address yet another syzkaller finding in the vgic initialisation,
  where we would end-up destroying an uninitialised vgic with nasty
  consequences

- Address an annoying case of pKVM failing to boot when some of the
  memblock regions that the host is faulting in are not page-aligned

- Inject some sanity in the NV stage-2 walker by checking the limits
  against the advertised PA size, and correctly report the resulting
  faults

PPC:

- Fix a PPC e500 build error due to a long-standing wart that was exposed by
  the recent conversion to kmalloc_obj(); rip out all the ugliness that
  led to the wart.

RISC-V:

- Prevent speculative out-of-bounds access using array_index_nospec()
  in APLIC interrupt handling, ONE_REG regiser access, AIA CSR access,
  float register access, and PMU counter access

- Fix potential use-after-free issues in kvm_riscv_gstage_get_leaf(),
  kvm_riscv_aia_aplic_has_attr(), and kvm_riscv_aia_imsic_has_attr()

- Fix potential null pointer dereference in kvm_riscv_vcpu_aia_rmw_topei()

- Fix off-by-one array access in SBI PMU

- Skip THP support check during dirty logging

- Fix error code returned for Smstateen and Ssaia ONE_REG interface

- Check host Ssaia extension when creating AIA irqchip

x86:

- Fix cases where CPUID mitigation features were incorrectly marked as
  available whenever the kernel used scattered feature words for them.

- Validate _all_ GVAs, rather than just the first GVA, when processing
  a range of GVAs for Hyper-V's TLB flush hypercalls.

- Fix a brown paper bug in add_atomic_switch_msr().

- Use hlist_for_each_entry_srcu() when traversing mask_notifier_list,
  to fix a lockdep warning; KVM doesn't hold RCU, just irq_srcu.

- Ensure AVIC VMCB fields are initialized if the VM has an in-kernel local
  APIC (and AVIC is enabled at the module level).

- Update CR8 write interception when AVIC is (de)activated, to fix a bug
  where the guest can run in perpetuity with the CR8 intercept enabled.

- Add a quirk to skip the consistency check on FREEZE_IN_SMM, i.e. to allow
  L1 hypervisors to set FREEZE_IN_SMM.  This reverts (by default) an
  unintentional tightening of userspace ABI in 6.17, and provides some
  amount of backwards compatibility with hypervisors who want to freeze
  PMCs on VM-Entry.

- Validate the VMCS/VMCB on return to a nested guest from SMM, because
  either userspace or the guest could stash invalid values in memory
  and trigger the processor's consistency checks.

Generic:

- Remove a subtle pseudo-overlay of kvm_stats_desc, which, aside from being
  unnecessary and confusing, triggered compiler warnings due to
  -Wflex-array-member-not-at-end.

- Document that vcpu->mutex is take outside of kvm->slots_lock and
  kvm->slots_arch_lock, which is intentional and desirable despite being
  rather unintuitive.

Selftests:

- Increase the maximum number of NUMA nodes in the guest_memfd selftest to
  64 (from 8).

----------------------------------------------------------------
Anup Patel (3):
      RISC-V: KVM: Fix error code returned for Smstateen ONE_REG
      RISC-V: KVM: Fix error code returned for Ssaia ONE_REG
      RISC-V: KVM: Check host Ssaia extension when creating AIA irqchip

Carlos López (1):
      KVM: x86: synthesize CPUID bits only if CPU capability is set

Fuad Tabba (2):
      KVM: arm64: Fix page leak in user_mem_abort() on atomic fault
      KVM: arm64: Fix vma_shift staleness on nested hwpoison path

Jiakai Xu (4):
      RISC-V: KVM: Fix use-after-free in kvm_riscv_gstage_get_leaf()
      RISC-V: KVM: Fix null pointer dereference in kvm_riscv_vcpu_aia_rmw_topei()
      RISC-V: KVM: Fix use-after-free in kvm_riscv_aia_aplic_has_attr()
      RISC-V: KVM: Fix potential UAF in kvm_riscv_aia_imsic_has_attr()

Jim Mattson (1):
      KVM: x86: Introduce KVM_X86_QUIRK_VMCS12_ALLOW_FREEZE_IN_SMM

Kai Huang (1):
      KVM: selftests: Increase 'maxnode' for guest_memfd tests

Li RongQing (1):
      KVM: x86: Fix SRCU list traversal in kvm_fire_mask_notifiers()

Lukas Gerlach (5):
      KVM: riscv: Fix Spectre-v1 in APLIC interrupt handling
      KVM: riscv: Fix Spectre-v1 in ONE_REG register access
      KVM: riscv: Fix Spectre-v1 in AIA CSR access
      KVM: riscv: Fix Spectre-v1 in floating-point register access
      KVM: riscv: Fix Spectre-v1 in PMU counter access

Manuel Andreas (1):
      KVM: x86: hyper-v: Validate all GVAs during PV TLB flush

Marc Zyngier (4):
      KVM: arm64: Eagerly init vgic dist/redist on vgic creation
      KVM: arm64: pkvm: Fallback to level-3 mapping on host stage-2 fault
      KVM: arm64: vgic: Pick EOIcount deactivations from AP-list tail
      KVM: arm64: pkvm: Don't reprobe for ICH_VTR_EL2.TDS on CPU hotplug

Namhyung Kim (1):
      KVM: VMX: Fix a wrong MSR update in add_atomic_switch_msr()

Paolo Bonzini (10):
      Merge tag 'kvmarm-fixes-7.0-2' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD
      Merge tag 'kvm-riscv-fixes-7.0-1' of https://github.com/kvm-riscv/linux into HEAD
      Merge tag 'kvm-x86-generic-7.0-rc3' of https://github.com/kvm-x86/linux into HEAD
      Merge tag 'kvmarm-fixes-7.0-3' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD
      KVM: VMX: check validity of VMCS controls when returning from SMM
      KVM: SVM: check validity of VMCB controls when returning from SMM
      selftests: kvm: extract common functionality out of smm_test.c
      selftests: kvm: add a test that VMX validates controls on RSM
      KVM: x86: clarify leave_smm() return value
      Documentation: kvm: fix formatting of the quirks table

Radim Krčmář (1):
      RISC-V: KVM: fix off-by-one array access in SBI PMU

Sean Christopherson (7):
      KVM: Remove subtle "struct kvm_stats_desc" pseudo-overlay
      Documentation: KVM: Formalizing taking vcpu->mutex *outside* of kvm->slots_lock
      KVM: PPC: e500: Fix build error due to using kmalloc_obj() with wrong type
      KVM: PPC: e500: Rip out "struct tlbe_ref"
      KVM: SVM: Initialize AVIC VMCB fields if AVIC is enabled with in-kernel APIC
      KVM: SVM: Set/clear CR8 write interception when AVIC is (de)activated
      KVM: selftests: Verify SEV+ guests can read and write EFER, CR0, CR4, and CR8

Wang Yechao (1):
      RISC-V: KVM: Skip THP support check during dirty logging

Zenghui Yu (Huawei) (4):
      KVM: arm64: nv: Check S2 limits based on implemented PA size
      KVM: arm64: nv: Report addrsz fault at level 0 with a bad VTTBR.BADDR
      KVM: arm64: nv: Inject a SEA if failed to read the descriptor
      KVM: arm64: Remove the redundant ISB in __kvm_at_s1e2()

 Documentation/virt/kvm/api.rst                     | 206 +++++++++++----------
 Documentation/virt/kvm/locking.rst                 |   2 +
 arch/arm64/include/asm/kvm_host.h                  |   3 +
 arch/arm64/kernel/cpufeature.c                     |   9 +
 arch/arm64/kvm/at.c                                |   2 -
 arch/arm64/kvm/guest.c                             |   4 +-
 arch/arm64/kvm/hyp/nvhe/mem_protect.c              |   2 +-
 arch/arm64/kvm/mmu.c                               |  14 +-
 arch/arm64/kvm/nested.c                            |  27 +--
 arch/arm64/kvm/vgic/vgic-init.c                    |  34 ++--
 arch/arm64/kvm/vgic/vgic-v2.c                      |   4 +-
 arch/arm64/kvm/vgic/vgic-v3.c                      |  12 +-
 arch/arm64/kvm/vgic/vgic.c                         |   6 +
 arch/loongarch/kvm/vcpu.c                          |   2 +-
 arch/loongarch/kvm/vm.c                            |   2 +-
 arch/mips/kvm/mips.c                               |   4 +-
 arch/powerpc/kvm/book3s.c                          |   4 +-
 arch/powerpc/kvm/booke.c                           |   4 +-
 arch/powerpc/kvm/e500.h                            |   6 +-
 arch/powerpc/kvm/e500_mmu.c                        |   4 +-
 arch/powerpc/kvm/e500_mmu_host.c                   |  91 +++++----
 arch/riscv/kvm/aia.c                               |  15 +-
 arch/riscv/kvm/aia_aplic.c                         |  23 +--
 arch/riscv/kvm/aia_device.c                        |  18 +-
 arch/riscv/kvm/aia_imsic.c                         |   4 +
 arch/riscv/kvm/mmu.c                               |   6 +-
 arch/riscv/kvm/vcpu.c                              |   2 +-
 arch/riscv/kvm/vcpu_fp.c                           |  17 +-
 arch/riscv/kvm/vcpu_onereg.c                       |  54 ++++--
 arch/riscv/kvm/vcpu_pmu.c                          |  16 +-
 arch/riscv/kvm/vm.c                                |   2 +-
 arch/s390/kvm/kvm-s390.c                           |   4 +-
 arch/x86/include/asm/kvm_host.h                    |   3 +-
 arch/x86/include/uapi/asm/kvm.h                    |   1 +
 arch/x86/kvm/cpuid.c                               |   5 +-
 arch/x86/kvm/hyperv.c                              |   9 +-
 arch/x86/kvm/ioapic.c                              |   3 +-
 arch/x86/kvm/svm/avic.c                            |   9 +-
 arch/x86/kvm/svm/nested.c                          |  12 +-
 arch/x86/kvm/svm/svm.c                             |  17 +-
 arch/x86/kvm/svm/svm.h                             |   1 +
 arch/x86/kvm/vmx/nested.c                          |  61 ++++--
 arch/x86/kvm/vmx/nested.h                          |   1 +
 arch/x86/kvm/vmx/vmx.c                             |  10 +-
 arch/x86/kvm/x86.c                                 |   4 +-
 include/linux/kvm_host.h                           |  83 ++++-----
 include/uapi/linux/kvm.h                           |   8 +
 tools/testing/selftests/kvm/Makefile.kvm           |   1 +
 tools/testing/selftests/kvm/guest_memfd_test.c     |   2 +-
 .../testing/selftests/kvm/include/x86/processor.h  |  23 +++
 tools/testing/selftests/kvm/include/x86/smm.h      |  17 ++
 tools/testing/selftests/kvm/lib/x86/processor.c    |  26 +++
 .../selftests/kvm/x86/evmcs_smm_controls_test.c    | 150 +++++++++++++++
 tools/testing/selftests/kvm/x86/sev_smoke_test.c   |  30 +++
 tools/testing/selftests/kvm/x86/smm_test.c         |  27 +--
 virt/kvm/binary_stats.c                            |   2 +-
 virt/kvm/kvm_main.c                                |  20 +-
 57 files changed, 749 insertions(+), 379 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/x86/smm.h
 create mode 100644 tools/testing/selftests/kvm/x86/evmcs_smm_controls_test.c

