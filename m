Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2971D31E851
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 07:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188020; cv=none; b=s1lZZ9IW3c+DXMIkjbBsj+xLPQvzdDNKgWFaS6m4GKrrKCeGg1PpHaOBup2TXXD4jmtwWfwG2paoQiO+CPwYcYKwB7l90MzrrnmL/Esiejf3D1Ie07miNNXLpP2jQ5JSLr9FLeokt6bOmOZNRYb6BOXDGGIz17k+AgBn2ejPKjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188020; c=relaxed/simple;
	bh=2+5Uzjn9YlVD9poLWCJQ/E6ehSOi0WUUjK73kBRF+54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nIx/9lO4Bw8h2OqmBcW2uqbd1XkW6cs/He193rTODLoVp1YeHTjHiqQdU/1eHudntgTSTnfc3eudAhPUXimLqYRQ2edOkwsjjXiossdF4sgik8hmO/uCdpMwwe/X6hsyvdpX9iQA4QuF9g4WbibnxiLGgcSxgGGw8dqhyT8Wzfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ETRlBxH0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vpd9yXSj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ETRlBxH0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vpd9yXSj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784188018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uYw9j1fO42gb66b9gpIRvTZmYbg8IcVeOQ7OFLlMih4=;
	b=ETRlBxH0DeCaGFCrqKD7IWj7eZ4cwtSAIxfFXJ5acZ+H8SZZkLQqrIRhIzfHSNmD2UtiP0
	SZ9jrqDlTTcoWDt5PMF3iVmEDItj0WscGWDRhuP2sgAMcYdkYkbnEjYvT0KNMY+Flwllgo
	HkvNUBen+hvXK4wSrXWfSIbkkBiUyAM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-spgaJZ93P3G3Q9YOflFAvQ-1; Thu, 16 Jul 2026 03:46:56 -0400
X-MC-Unique: spgaJZ93P3G3Q9YOflFAvQ-1
X-Mimecast-MFC-AGG-ID: spgaJZ93P3G3Q9YOflFAvQ_1784188015
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47eaa4006a1so153729f8f.0
        for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 00:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784188015; x=1784792815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uYw9j1fO42gb66b9gpIRvTZmYbg8IcVeOQ7OFLlMih4=;
        b=Vpd9yXSjS9LFQN+KONfnUxfFM9U3ezhJ7pcH+zm6RitqfGl6RyTeUwbBcbKIAJgowt
         N9UTPA2Rhm1z3foadp773xvOMhcUhFlvqM/NbxbXFOHWszvaOh4Vbq2xxwCg7Q4Cf2jf
         HCykNmnYHwsgJ3BKkpt/amATPb3qoibhdv/CT+ZpgAobcmoXban9nhO2VyYItdYaV1kE
         N3wI20VEp4BTT9ltX37q4NCGnM6vKda/kJ0EIsNQuOL9sV/Zhzd2xNEvVlRJFFNTewH/
         OLeLq7z0b6nmjIeShwUVAoOhOAbNBfN50+gwB6/qltaph8NXWFDGwxcPvi8bt71mY+Iz
         sxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784188015; x=1784792815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uYw9j1fO42gb66b9gpIRvTZmYbg8IcVeOQ7OFLlMih4=;
        b=IitqCOlHoyNN9Pv8KlwZXhnduFLPgzYg3jTSXSrrnLOZh70OJw9wV7r040uIGomo0i
         Fydxw+LqnF2ZM3HPq6FLXZzWUMiJzZIhzrIFKvfIZ7fGo50BM815LYbNr7aAJHNMM74l
         jO/5esw19/i1SMNwar8k8TnT5jD3CA3Y3pickkaJdVgY2talpdlO9FttFrpCFkHRD+Tm
         +zvDLU1yFdpTSVurOLg4bkSk8tQuBHGp6GCRHgi2AfE1inH7fp1dyzEE0T3DQLS8Sb9e
         sjOyWNFzMJYsT+c6yk8SpjIsxIwWHKad0JuJTzidbdikATUdw/KAYHRDxEVTKytDbll0
         p77Q==
X-Forwarded-Encrypted: i=1; AHgh+RqUIPxBXAWkptrYvrY/K37oglPUmOldGtzchLCfxyIWBseaf35yv4ihRQp1VKJeGo0QFbw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzut6rd9M+OZj4/Yl8U5t+LCgMumEHBRXr9/9ESHSH/WZ/Mc36M
	dCK++VW8kbgtEmVuomnZfTg7MT/ki/rGc7BTGhZKihcSifJk/CRKl9OU8lmkoHrI0aqLG5r/G1o
	+WwXr+IOA/gaEy89hq550IEcaWW60TNiNVt8ghXSwLAL0euVZRolT9Q==
X-Gm-Gg: AfdE7ck1QBKJWTdA4mvdY+rXTIAFbi6rhvRl9SPRW/1a6hyd7U9OKnAQSYFJX73zjIt
	PNXTSvIFhgmG2cvvNhwOgaUB49zi0XXWejRvb2098b8f9Ac06iKMyVb3Jmkl5G791kLH2UkFvCD
	HAQzomp+0af3Y4wAVK3eS00vV0doHGaNTkAGA90DoHdtvkZYj+iXZpoY5vSW+6RhN0UPHYSfRDo
	TmIJFPweLJHod5ns34k6DY+QSiHTLqtzISwAVUNCqPXncpT+PCBVuPURhcLqKJEIresyPMvhXO6
	KZk50a8OMB6s30EVbtmdbtPvxbeELQMKf9YXsGuKwUtDh6cdWuB53ImyOc6iIwVZ4yyPzc+S3HO
	/P4/lOwAiC00SMhCl6RWdi3LTn+BL33faiC8TOfB+KrkjybMZCLKH0jD6yCDLhbJP6XnWPQcrp2
	Rl1Ts=
X-Received: by 2002:a05:6000:41f0:b0:460:d18:865c with SMTP id ffacd0b85a97d-47f5a4182c4mr1607695f8f.1.1784188015098;
        Thu, 16 Jul 2026 00:46:55 -0700 (PDT)
X-Received: by 2002:a05:6000:41f0:b0:460:d18:865c with SMTP id ffacd0b85a97d-47f5a4182c4mr1607666f8f.1.1784188014580;
        Thu, 16 Jul 2026 00:46:54 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.47.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f47688f29sm20172834f8f.21.2026.07.16.00.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 00:46:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [GIT PULL] KVM fixes for Linux 7.2-rc4
Date: Thu, 16 Jul 2026 09:46:52 +0200
Message-ID: <20260716074652.756719-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit a13c140cc289c0b7b3770bce5b3ad42ab35074aa:

  Linux 7.2-rc3 (2026-07-12 14:16:39 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to 25f744ffa0c8e799e06250ce2e618367b166b0d4:

  KVM: SVM: Bump asid_generation on CPU online to avoid ASID collision after hotplug (2026-07-16 08:55:03 +0200)

A larger pull request with everything that accumulated while I was
away from git.

Paolo

----------------------------------------------------------------
Arm:

- Fix an accounting buglet when reclaiming pages from a protected guest

- Fix a bunch of architectural compliance issues when injecting a
  synthesised exception, most of which were missing the PSTATE.IL bit
  indicating a 32bit-wide instruction

- Another set of fixes addressing issues with translation of VNCR_EL2,
  including corner cases where the guest point that register at a RO
  page...

- Don't warn when trapping accesses to ZCR_EL2 from an L2 guest, as
  that's not unexpected at all

- Address a bunch of races with LPI migration vs LPIs being disabled

- Fix a total howler of a bug combining FEAT_MOPS and NV, resulting in
  exception returning in the wrong place...

- Move locking for kvm_io_bus_get_dev() into the caller, ensuring
  race-free checks that the returned object is of the correct type

- Fix initialisation of the page-table walk level when relaxing
  permissions

- Correctly update the XN attribute when relaxing permissions

- Fix the sign extension of loads from emulated MMIO regions

- Assorted collection of fixes for pKVM's FFA proxy, together with a
  couple of FFA driver adjustments

- Coerce Fuad Tabba into a reviewer role, and may his Inbox catch fire!

s390:

- more gmap KVM memory management fixes

- PCI passthru fixes

x86:

- Fix a bug where KVM will trigger a UAF if updating IOMMU IRTEs fails when
  registering an IRQ-bypass producer.

- Ignore pending PV EOI instead of BUG()ing the host if the feature was
  disabled by the guest.

- Fix nVMX bugs where KVM would run L1 with an L1-controlled CR3 after a
  failed "late" consistency check when KVM is NOT using EPT.

- Disallow intra-host migration/mirroring of SNP VMs as KVM doesn't yet
  support moving/mirroring SNP state.

- Fix a TOCTOU bug in KVM's handling of the "trusted" CPUID for TDX guests.

- Fix a NULL pointer deref in trace_kvm_inj_exception() where a change to the
  core infrastructure missed KVM's unique (ab)use of __print_symbolic().

- Put vmcs12 pages if nested VM-Enter fails due to invalid guest state

- Fix TLB conflicts between two VMs if one of them VM is run on a CPU before
  and after it is hotplugged.

----------------------------------------------------------------
Atish Patra (2):
      KVM: SEV: Do not allow intra-host migration/mirroring of SNP VMs
      KVM: selftests: Verify SNP VMs are rejected from migration and mirroring

Binbin Wu (1):
      KVM: TDX: Reject concurrent change to CPUID entry count

Bradley Morgan (1):
      KVM: arm64: account pKVM reclaim against the VM mm

Claudio Imbrenda (3):
      KVM: s390: vsie: Avoid potential deadlock with real spaces
      KVM: s390: Fix dat_crste_walk_range() early return
      KVM: s390: Improve kvm_s390_vm_stop_migration()

Daniel Paziyski (1):
      KVM: x86: Fix null pointer deref due to dummy array in trace_kvm_inj_exception()

Fuad Tabba (13):
      KVM: arm64: nv: Write ESR_EL2 for injected nested SError exceptions
      KVM: arm64: Sync SPSR_EL1 when injecting an exception into a pVM
      KVM: arm64: nv: Fix PSTATE construction on illegal exception return
      KVM: arm64: Add Fuad Tabba as a reviewer
      KVM: arm64: Set ESR_ELx.IL for injected undefined exceptions at EL2
      KVM: arm64: Unconditionally set IL for injected undefined exceptions
      KVM: arm64: Unconditionally set IL for injected abort exceptions
      KVM: arm64: Set IL for injected FPAC exceptions during ERET emulation
      KVM: arm64: Set IL for emulated SError injection
      KVM: arm64: Set IL for nested SError injection
      KVM: arm64: Set IL in fake ESR for pKVM memory sharing exit
      KVM: arm64: Fix sign-extension of MMIO loads
      KVM: arm64: selftests: Add MMIO sign-extending load test

Haoxiang Li (1):
      KVM: s390: pci: Fix GISC refcount leak on AIF enable failure

Hyunwoo Kim (1):
      KVM: arm64: vgic: Check the interrupt is still ours before migrating it

Marc Zyngier (3):
      KVM: arm64: vgic: Handle race between interrupt affinity change and LPI disabling
      KVM: Move kvm_io_bus_get_dev() locking responsibilities to callers
      KVM: arm64: Fix propagation of TLBI level in kvm_pgtable_stage2_relax_perms()

Matthew Rosato (1):
      KVM: s390: pci: Fix handling of AIF enable without AISB

Mostafa Saleh (3):
      KVM: arm64: Fix bounds checking in do_ffa_mem_reclaim()
      KVM: arm64: Ensure FFA ranges are page aligned
      firmware: arm_ffa: Fix out-of-bound writes in ffa_setup_and_transmit()

Nikunj A Dadhania (1):
      KVM: SVM: Bump asid_generation on CPU online to avoid ASID collision after hotplug

Oliver Upton (8):
      KVM: arm64: nv: Drop bogus WARN for write to ZCR_EL2
      KVM: arm64: nv: Respect read-only PFN when mapping L1 VNCR
      KVM: arm64: nv: Inject SEA if kvm_translate_vncr() can't resolve PFN
      KVM: arm64: nv: Re-translate VNCR before injecting abort
      KVM: arm64: nv: Inject SEA if guest VNCR isn't normal memory
      KVM: arm64: nv: Mark VM as bugged for unexpected VNCR abort
      KVM: arm64: Ensure level is always initialized when relaxing perms
      KVM: arm64: Only update XN attr when requested during S2 relaxation

Paolo Bonzini (4):
      Merge tag 'kvmarm-fixes-7.2-1' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD
      Merge tag 'kvmarm-fixes-7.2-2' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD
      Merge tag 'kvm-x86-fixes-7.2-rc4' of https://github.com/kvm-x86/linux into HEAD
      Merge tag 'kvm-s390-master-7.2-1' of git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD

Sean Christopherson (4):
      KVM: x86: Ignore pending PV EOI if the vCPU has since disabled PV EOIs
      KVM: nVMX: Move vTPR vs. TPR Threshold consistency check into "normal" checks
      KVM: nVMX: Don't use vmcs01.GUEST_CR3 to snapshot L1's CR3 when EPT is disabled
      KVM: nVMX: Put vmcs12 pages if nested VM-Enter fails due to invalid guest state

Sebastian Ene (3):
      KVM: arm64: Validate the offset to the mem access descriptor
      KVM: arm64: Zero out the stack initialized data in the FFA handler
      firmware: arm_ffa: Fix Endpoint Memory Access Descriptor offset calculation

Weiming Shi (1):
      KVM: arm64: nv: Fix SPSR_EL2 restore in kvm_hyp_handle_mops()

leixiang (1):
      KVM: x86: Nullify irqfd->producer if updating IRTE for bypass fails

 MAINTAINERS                                        |   1 +
 arch/arm64/include/asm/kvm_nested.h                |   8 +
 arch/arm64/kvm/at.c                                |   8 -
 arch/arm64/kvm/emulate-nested.c                    |  41 +++-
 arch/arm64/kvm/hyp/include/hyp/switch.h            |  11 +-
 arch/arm64/kvm/hyp/nvhe/ffa.c                      |  44 ++--
 arch/arm64/kvm/hyp/nvhe/pkvm.c                     |   3 +-
 arch/arm64/kvm/hyp/nvhe/sys_regs.c                 |   3 +-
 arch/arm64/kvm/hyp/pgtable.c                       |  15 +-
 arch/arm64/kvm/inject_fault.c                      |  18 +-
 arch/arm64/kvm/mmio.c                              |   7 +-
 arch/arm64/kvm/nested.c                            | 164 ++++++-------
 arch/arm64/kvm/pkvm.c                              |   2 +-
 arch/arm64/kvm/vgic/vgic-its.c                     |   2 +
 arch/arm64/kvm/vgic/vgic.c                         |  20 +-
 arch/s390/kvm/dat.c                                |   2 +
 arch/s390/kvm/gmap.c                               |   7 +-
 arch/s390/kvm/kvm-s390.c                           |   6 +-
 arch/s390/kvm/pci.c                                |  12 +-
 arch/x86/kvm/irq.c                                 |   4 +-
 arch/x86/kvm/lapic.c                               |   8 +-
 arch/x86/kvm/svm/sev.c                             |   6 +-
 arch/x86/kvm/svm/svm.c                             |   7 +-
 arch/x86/kvm/trace.h                               |   2 +-
 arch/x86/kvm/vmx/nested.c                          |  89 ++++---
 arch/x86/kvm/vmx/tdx.c                             |   6 +-
 arch/x86/kvm/vmx/vmx.h                             |   7 +
 drivers/firmware/arm_ffa/driver.c                  |  25 +-
 include/linux/arm_ffa.h                            |   9 +-
 tools/testing/selftests/kvm/Makefile.kvm           |   1 +
 tools/testing/selftests/kvm/arm64/mmio_sign_ext.c  | 255 +++++++++++++++++++++
 .../testing/selftests/kvm/x86/sev_migrate_tests.c  |  47 ++++
 virt/kvm/kvm_main.c                                |  16 +-
 33 files changed, 621 insertions(+), 235 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/arm64/mmio_sign_ext.c

