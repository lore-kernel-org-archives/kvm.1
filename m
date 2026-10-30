Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793384762;
	b=rwKVv0VIVTF6br+uDJ6XHNsgu1AV6Lix3EnTqj7zO5Esnv6haaK+0VfaMIDHrAs5TeWb
	 239fkCWrtFrFy/0AQPqXQc/j3vYFjx0Tn5L94x7kEbk6l2WjA7tV+dXCT41WxWL84DY89
	 mqgJLJd3p0SqlnO609dg8z7RiPa1w3lfl8uAh6RGscAVUeKvwmImzNQxALGqjKch6WNaE
	 1vOizhmPxJ4TuxO57KanmxdHx2jv/kLBZzbtKixeBhcCP/pb5z/tcZS3O3QKp/MBYwIFB
	 0xVCGXSFLxPW6F+23FctkMdWFsvIHLUM6Or8GafQeHUWJWHhxmzg7D/+ZHSrGPQTVoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793384762;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding:X-Scanned-By;
	bh=jNyQUjUQJUIyMMQ0wfpgXGfUPfMmddjjb+UShX+g7BI=;
	b=QOQSp6XldlDO/hDSzDzDoX2L6WRXEHwUCwKjGSmFLA/HbR6bTRTZyfCST+4DlYdzvqmT
	 rcbcAGbiPzZfGdfF1ih/v1rEkaCti27tlskzXQdhivE1liKz4/yNOO3CDWRVtk45pwfAo
	 K30wj7fzVJUPxLhCvqA/kT3CZHbX3iNDw9cBtdBTWQIaqKB8NUMj1YC5cEqUZG5XR82AA
	 880yLeqmnn+FhbwLyZakLVxS2E4u3BwxHLKv1XkvjhPNofX1o2Qrq6tC669zO6WmLa4MY
	 L0DY4VJcIcx+uNRQqYFnwmTPU9xwVvq9h4sQL+fRCXnAsaB7BOC41IUmBbxByt/JVdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B9GcWgMT;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B35606A323
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 18:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87B35606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B9GcWgMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793384760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jNyQUjUQJUIyMMQ0wfpgXGfUPfMmddjjb+UShX+g7BI=;
	b=B9GcWgMT22c8ybthv+9if571mK0mtJPomXwwjwJ7Iyw/Wn7Moxwcn0y/HJ0JV08tC/wwjM
	39RJF+EpQ56T/0A+LekiKJML5oZP7WAl4R/CjTGP6JmRa1L6wEF1xnUPLkWr0V0DCvpJfn
	jblPYXmPiWN6AL7hXK1Ap2vm3UhDzQ8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-85Lc-lXeMXGCnQI4NdiFNA-1; Fri,
 30 Oct 2026 14:25:56 -0400
X-MC-Unique: 85Lc-lXeMXGCnQI4NdiFNA-1
X-Mimecast-MFC-AGG-ID: 85Lc-lXeMXGCnQI4NdiFNA_1793384755
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE4091955F30;
	Fri, 30 Oct 2026 18:25:54 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D25D31800347;
	Fri, 30 Oct 2026 18:25:53 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [GIT PULL] Second batch of KVM changes for Linux 7.4 merge window
Date: Fri, 30 Oct 2026 19:25:52 +0100
Message-ID: <20261030182552.1269009-1-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Linus,

The following changes since commit 164405e8e9a0378c7e1aff2254625a6553a291f1:

  KVM: always make in-place conversion a compile-time constant when possible (2026-10-21 03:28:21 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to 1689c80fca308978ea1c9f03d15a500f4e44e2e1:

  Merge tag 'kvmarm-fixes-7.4-1' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD (2026-10-28 19:01:07 +0100)

----------------------------------------------------------------
Arm:

- Fix a couple of embarrassing merge mistakes in kvmarm-7.4

- Cleanup the HCR_EL2 bit fields to exclusively use the generated
  definitions, fixings a nasty regression introduced in 6.16, where
  barriers were not upgraded from NSH to ISH anymore

- Fix publication of state when a vcpu is forced out of the guest

- Let vcpu pausing nest correctly

- Sanitise ID_AA64MMFR3_EL1.S1P[IO]E to follow the rules of the architecture

- Don't warn on SMCCC filter reserved range allocation failure

- Prevent GICv5 and TLBI hypercalls to be used from the host when pKVM
  is active

- Enforce that only GICv3 guests are supported for pKVM

- Don't try to access GICv5 EL2 sysregs from EL1

- Compute architectrally correct values for ID_AA64MMFR3_EL1.S1P[IO]E
  by checking the feature dependencies

- Require matching VGIC and ITS model

- Cleanup TRACE_REMOTE dependencies

- Fix random comments

Arm selftests:

- selftests: Skip unwritable ID fields in the failed-run test

- Move pkvm_selftests() after all CPUs have initialized EL2

RISC-V:

- Allow Zicclsm, Ziccamoa, Ziccif, Za64rs for KVM guest

- Implement KVM_PRE_FAULT_MEMORY ioctl()

- Replace imsic switch-case macros with range checks

RISC-V fixes:

- Avoid redundant interrupt check for pending timers

- Reject vCPU creation after AIA initialization

- Fix build with vector support disabled

- Fix IPI delivery for out-of-order vcpu_id

- Use a raw lock for IMSIC wakeup state

- Reject vCPU creation after AIA initialization

RISC-V selftests:

- Lazy V-extension enablement for KVM selftests

- Show sepc/scause/stval CSRs in KVM selftests vcpu dump

----------------------------------------------------------------
Andrew Jones (2):
      RISC-V: KVM: Reject vCPU creation after AIA initialization
      RISC-V: KVM: Use a raw lock for IMSIC wakeup state

Fuad Tabba (10):
      KVM: arm64: vgic-its: Don't map an LPI from more than one event
      KVM: arm64: vgic-its: Remove the pending state of a discarded LPI
      KVM: arm64: Don't WARN on SMCCC filter reserved range allocation failure
      KVM: arm64: Reject the GICv5 CPU interface hypercalls under pKVM
      KVM: arm64: Return on kvm_gmem_get_pfn() failure in gmem_abort()
      KVM: arm64: Reject the stage-2 flush hypercalls under pKVM
      KVM: arm64: Validate the host-provided vgic model in pKVM
      KVM: arm64: vgic: Do not access the GICv5 CPU interface from EL1
      KVM: arm64: Fix stale VGICv3 comments in the nVHE world switch
      KVM: arm64: Set HCR_EL2.BSU to Inner Shareable for guests

Heinrich Schuchardt (2):
      RISC-V: KVM: Allow Zicclsm, Ziccamoa, Ziccif, Za64rs in guest
      KVM: riscv: selftest: add Zicclsm, Ziccamoa, Ziccif, Za64rs

Jinyu Tang (4):
      KVM: riscv: Avoid redundant interrupt check for pending timers
      KVM: riscv: Implement KVM_PRE_FAULT_MEMORY
      KVM: selftests: Add RISC-V Sv57 page table indexing
      KVM: selftests: Enable pre_fault_memory_test for RISC-V

Marc Zyngier (12):
      KVM: arm64: nv: Move L2->L1 switch on interrupt early
      KVM: arm64: Move OUTSIDE_GUEST_MODE publication past context being saved
      KVM: arm64: Move IN_GUEST_MODE ahead of state being loaded
      KVM: arm64: Turn vcpu->arch.pause into a counter
      KVM: arm64: vgic: Stop the target vcpu when disabling LPIs
      KVM: arm64: vgic-its: Stop the VM when handling MOVALL
      KVM: arm64: Convert HCR_xyz to HCR_EL2_xyz
      KVM: arm64: Get rid of compatibility HCR_EL2 aliases
      KVM: arm64: Sanitise ID_AA64MMFR3_EL1.S1P[IO]E
      Merge branch kvm-arm64/hcr-cleanup into kvmarm-master/fixes
      Merge branch kvm-arm64/cross-vcpu-sync into kvmarm-master/fixes
      Merge branch kvm-arm64/misc-fixes-7.4-1 into kvmarm-master/fixes

Matthias Goergens (1):
      MAINTAINERS: name the kvm-riscv/linux riscv_kvm_next branch

Oliver Upton (1):
      KVM: arm64: Add helpers to halt a vCPU

Paolo Bonzini (2):
      Merge tag 'kvm-riscv-7.4-1' of https://github.com/kvm-riscv/linux into HEAD
      Merge tag 'kvmarm-fixes-7.4-1' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD

Sascha Bischoff (3):
      KVM: arm64: gic-v5: Drop unused addr variable
      KVM: arm64: vgic: Require matching VGIC and ITS models
      KVM: selftests: Reject GICv3 ITS with a GICv5 VGIC

Sasha Levin (2):
      KVM: arm64: Take a protected vCPU's TWI and TWE only at vCPU load
      KVM: arm64: selftests: Skip unwritable ID fields in the failed-run test

Stefan Butz (1):
      RISC-V: KVM: Don't write MMIO load result to x0

Vincent Donnefort (2):
      KVM: arm64: Move pkvm_selftests() after all CPUs have initialized EL2
      tracing/remotes: Fix TRACE_REMOTE build when TRACING=n

Xiaofeng Yuan (2):
      RISC-V: KVM: Fix IPI delivery for out-of-order vcpu_id
      RISC-V: KVM: Replace imsic switch-case macros with range checks

Yong-Xuan Wang (1):
      KVM: riscv: selftests: Dump sepc/scause/stval on vcpu_arch_dump()

Zhanpeng Zhang (1):
      RISC-V: KVM: Fix build with vector support disabled

jinrui (1):
      KVM: selftests: riscv: Add lazy V extension enablement for guests

 MAINTAINERS                                        |   2 +-
 arch/arm64/include/asm/el2_setup.h                 |   4 +-
 arch/arm64/include/asm/hardirq.h                   |   6 +-
 arch/arm64/include/asm/kvm_arm.h                   |  79 +----------
 arch/arm64/include/asm/kvm_asm.h                   |  22 +--
 arch/arm64/include/asm/kvm_emulate.h               |  18 +--
 arch/arm64/include/asm/kvm_host.h                  |  10 +-
 arch/arm64/include/asm/kvm_mte.h                   |   4 +-
 arch/arm64/include/asm/kvm_pkvm.h                  |   1 -
 arch/arm64/include/asm/kvm_ptrauth.h               |   4 +-
 arch/arm64/kernel/head.S                           |   4 +-
 arch/arm64/kvm/Kconfig                             |   2 +-
 arch/arm64/kvm/arm.c                               | 100 ++++++++------
 arch/arm64/kvm/at.c                                |  18 +--
 arch/arm64/kvm/config.c                            |  78 +++++++++++
 arch/arm64/kvm/emulate-nested.c                    | 116 ++++++++--------
 arch/arm64/kvm/guest.c                             |   2 +-
 arch/arm64/kvm/handle_exit.c                       |   2 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h            |  14 +-
 arch/arm64/kvm/hyp/include/nvhe/pkvm.h             |  13 +-
 arch/arm64/kvm/hyp/nvhe/host.S                     |   2 +-
 arch/arm64/kvm/hyp/nvhe/hyp-init.S                 |   2 +-
 arch/arm64/kvm/hyp/nvhe/hyp-main.c                 |  15 ++-
 arch/arm64/kvm/hyp/nvhe/mem_protect.c              |   6 +-
 arch/arm64/kvm/hyp/nvhe/pkvm.c                     |  41 +++---
 arch/arm64/kvm/hyp/nvhe/switch.c                   |   4 +-
 arch/arm64/kvm/hyp/vgic-v3-sr.c                    |   4 +-
 arch/arm64/kvm/hyp/vhe/switch.c                    |  12 +-
 arch/arm64/kvm/hyp/vhe/tlb.c                       |   2 +-
 arch/arm64/kvm/hypercalls.c                        |   4 +-
 arch/arm64/kvm/inject_fault.c                      |   6 +-
 arch/arm64/kvm/mmu.c                               |   9 +-
 arch/arm64/kvm/nested.c                            |  16 ++-
 arch/arm64/kvm/pkvm.c                              |   4 +-
 arch/arm64/kvm/sys_regs.c                          |  26 ++--
 arch/arm64/kvm/vgic/vgic-init.c                    |  17 +++
 arch/arm64/kvm/vgic/vgic-irs-v5.c                  |   3 +-
 arch/arm64/kvm/vgic/vgic-its.c                     |  85 ++++++++++--
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                 |  15 ++-
 arch/arm64/kvm/vgic/vgic-v3-nested.c               |   4 +-
 arch/arm64/kvm/vgic/vgic.c                         |  15 +--
 arch/riscv/include/asm/kvm_vcpu_vector.h           |   6 +-
 arch/riscv/include/uapi/asm/kvm.h                  |   4 +
 arch/riscv/kvm/Kconfig                             |   1 +
 arch/riscv/kvm/aia_imsic.c                         | 149 +++++----------------
 arch/riscv/kvm/gstage.c                            |   6 +-
 arch/riscv/kvm/isa.c                               |   8 ++
 arch/riscv/kvm/mmu.c                               |  47 +++++++
 arch/riscv/kvm/vcpu.c                              |   3 +
 arch/riscv/kvm/vcpu_insn.c                         |   2 +-
 arch/riscv/kvm/vcpu_sbi_replace.c                  |  12 +-
 arch/riscv/kvm/vcpu_timer.c                        |   6 +-
 arch/riscv/kvm/vm.c                                |   1 +
 include/kvm/arm_vgic.h                             |   6 +-
 kernel/trace/Kconfig                               |   1 +
 tools/testing/selftests/kvm/Makefile.kvm           |   1 +
 tools/testing/selftests/kvm/arm64/set_id_regs.c    |  13 +-
 tools/testing/selftests/kvm/arm64/vgic_v5.c        |  32 +++++
 .../selftests/kvm/include/riscv/processor.h        |  19 +++
 tools/testing/selftests/kvm/lib/riscv/processor.c  | 109 +++++++++++++--
 tools/testing/selftests/kvm/riscv/get-reg-list.c   |  16 +++
 61 files changed, 768 insertions(+), 465 deletions(-)

