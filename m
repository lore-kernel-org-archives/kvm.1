Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F11D37BE7F
	for <kvm@vger.kernel.org>; Sun, 12 Apr 2026 13:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775999678; cv=pass; b=Vfjv69vIQONrZwIROa+fSmxukeYQptj2FkYwlm2SpLxQXbpsGi2kZOjGLd8n220Qi72MIDbR62m5XogcTTIxaQPSTi4XYev4cSL1uRmD7uA9wKiYHY63uLq62v0MEmuprR8Y1frowKENXrb2WJP2JfP1ocYnwFh366FwVqH6lH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775999678; c=relaxed/simple;
	bh=yzzJ6Ey6JvEn0ocYQoSPZOg8wKY9SYPLO/r5DHN41sE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=OBn++T2HxLr2BTaWf/arD+ZPBej4BnYd5fqV2KlEIEgFlBfTdKo2liy1pINat5LWWORkEjxfL3neO8ZDLA4QYy2qVxVG3+Tn2VApJMTZY1KHkYSK1mhdKAToY1EfFOeTPKZfKYTS32bJfqb3HBi08z9LNPbZQsCbzckSe3/xe3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=0EqaHXTt; arc=pass smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="0EqaHXTt"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-40946982a78so1155780fac.2
        for <kvm@vger.kernel.org>; Sun, 12 Apr 2026 06:14:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775999676; cv=none;
        d=google.com; s=arc-20240605;
        b=eC03oZgAQ2rOVOeZrx5iJTqvZYNUZMRwn1rwl0j9znh3SUWgEhF4S4TThWToJEpaQj
         ruqW70yBaf5b8cGU6crjIWGOC2GIj9d9c1f2c+fqXEVojYGJhbayCncivtZe6yrBNw9S
         GJSz/RU/3av/4E6pwt0SNtyJXji87LQS9dzh68pUxcRVehuSVG5QTSDPi/ryenWgcKj8
         uObqVMJIPSn4NOucgYqfBmTCusX8L84oMP8wsFzzaMmRn56su6ToqIWMFKdKZN8tase4
         BHyg9+tfGsWLhrwipiZjoQC/5hsuMwYbH2yxZqS9gieJ7vuNwh/V7t7qyPSbcngitokS
         Vc1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=LgG7BhXRqBuLwTWbbmg1Dm6H9zvWjwsilKkHM4001AA=;
        fh=r9mxo7yqS5dshWsBaTMj2HOkp6yWF1suCkdkY9rT9IE=;
        b=YAU8FHrd8AbVOv5Fwg1cZusToKyXn0wnQQcfKO/BTjrrFcPQiRgZlCI/+xnro51AEO
         mAt+g+EsIcDMSBtKW1RiSMK7/mUL6xLhoJeXF7VeysUwGhULwqO0i6vs2e/NnbfxTEWj
         o8Fn/sDhIDUpdbPzyuyzo+QXLH2M89iMcL/qIdZG5z+5lfRIx6d1DG4PMTTXiWSH2WqR
         hJtAWfjtp0JilykR4Q47ZFXlIpVQTZm9QHeKc3PtuYFao0QgWj4DBvMLQsjFEOAk8/xN
         Ne7JaEsb6nuzoY0hioiypRFGcgeL6/BlPRPHClZl+O2uAiN4DfknARHyYSGyuX7LKWp6
         xbkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1775999676; x=1776604476; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LgG7BhXRqBuLwTWbbmg1Dm6H9zvWjwsilKkHM4001AA=;
        b=0EqaHXTt+XE/8MOBCOimT75XPPO+b9RZVRbiMlO5eSewg1lhXc9wyOREgIdUZg/Bg9
         41qfPz2KxAV4enkgXZJF5vIaGFAwUTKWZzgSMxQGPW2dtZQgiHU2EYBFqZMymlcgigby
         hBhSn3ax4Sa/rGceZafR8m22g/aVOSkK1VYV5JEmBSsu667pxpe65a37Rzv4NdJpLTgr
         IqXC/qxyf859cRb69gUIVUC1n5dmZiHvxcosjhXCuE4H6GnlBNrTOpR4AygW5TgYyz7A
         2uYtT3K832wlX087SIjmap1R8d9/PSOdRR18F4uoUQhlcRBdj5/N3Dn+lF3oUlh4X8wr
         LzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775999676; x=1776604476;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LgG7BhXRqBuLwTWbbmg1Dm6H9zvWjwsilKkHM4001AA=;
        b=HxJ4CqFaQXXGfNcTWBaFdqAeY2glqQ6xCHPl5R9qY+uulPZu23jN40pYxxo+wzG0te
         AdCi+K7yR7l7x+PwgOmgB//ucRKSigr39BSB7vi149baePcs8CTiXINuRVfuxcPLvLO+
         bpQsEfi91sCoofVSurE8XxTHFGz5I2l+5044Yn26UvHDEUpL9WDeMUl4EFqu+kYAnin0
         zqPiHB2x1grcfY54WweADaQeBFaXRDUeEVf8DNBiJ1drC4IKI6NNANBMdEcdrPmtMkwe
         MaO90da/629xePnNDNCjLVP459J5VpyA8pRNng/QjIZNWo+hN8sWhwBAdaINhd97G8Ca
         DQtw==
X-Forwarded-Encrypted: i=1; AJvYcCUaD3UDXw9EbQuG2PXM38uhLIEWoNN7Ad+CP1Ku84XnzfAFmWla67PL8vZnTBbhIPNLH4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzayK8w7Tm/+ptXVztqJXElFfADX8PhBKOyeM58hkexXND5gAHW
	k6gW4J0+8orr8Dqd8r2y8o3M1ezJ3VLaNw7MFklx6cyF7OfoOaU45TCfxxol4G9kA3IRLUPORg7
	Bq7L39kjGiTeIafKYOTzTYZUPXbvLL6yfoSG6aH/vvg==
X-Gm-Gg: AeBDieuQdrVRMYa1q6OxqF4vL+JuNUOcLp21uc2VnCrZ3eqswPrwvoFD/oOp5xyd3Iv
	y1QMPRJacNeYuev2CVxktKsofoRBSEjtUm/CBAUoLB6M/BxnjD4I6fJrTSeMBhYzj7STl+6JlY1
	p8bFLV6NNjnn79aucSVzen8zfVPFIEq50uAjvn1A26vYTtqO5JAvTtGw8f/Xz7Mc0QWUNjjy0QW
	8ETnw/VUkj/eBI2fi3jkQ1mtfhiLMBqwqWOth1NvMCG3sxa+Vg+oCEpkwB0YBXELFlDaG4xOIMJ
	l1Dvbd4BgQzfvACPciaU0f/IIITnIW3rSE2LY0UvLA8OS+qaOa9PxND+ls7ddUXc95U669aADJ4
	/046OvmfVY3dSrsBDjsV+OM6csfA=
X-Received: by 2002:a05:6820:4b92:b0:680:51ef:f9d1 with SMTP id
 006d021491bc7-68be652db01mr5240094eaf.21.1775999675969; Sun, 12 Apr 2026
 06:14:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Anup Patel <anup@brainfault.org>
Date: Sun, 12 Apr 2026 18:44:24 +0530
X-Gm-Features: AQROBzCUdDrPQORt6CjxveecMBhX-5A0Za-u8m_gR4edHpfzdPcYpLOQDe-EeWI
Message-ID: <CAAhSdy0sU997x67zZe00ZVPVrOT-=X8zOUk3OxWXeDcn-rHeXA@mail.gmail.com>
Subject: [GIT PULL] KVM/riscv changes for 7.1
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, 
	Andrew Jones <andrew.jones@oss.qualcomm.com>, Atish Patra <atish.patra@linux.dev>, 
	"open list:KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv)" <kvm-riscv@lists.infradead.org>, KVM General <kvm@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"

Hi Paolo,

We have the following KVM RISC-V changes for 7.1:
1) Fixes for issues in steal time accounting, vector and
    PMU which were discovered by KVM API fuzzing
2) Split huge pages during fault handling for dirty logging
    so that write permission is restored for smaller pages
3) Improve kvm_arch_vcpu_load() performance by skipping
    CSR restore if VCPU is reloaded on the same core
4) Implement kvm_arch_has_default_irqchip() for KVM selftests
5) Support configuration of per-VM HGATP mode from KVM
    user space
6) Some more preparatory changes for nested virtualization
    such as:
    6.1) Factored-out ISA checks into separate sources
    6.2) Added hideleg to struct kvm_vcpu_config
    6.3) Factored-out VCPU config into separate sources

Please pull.

Regards,
Anup

The following changes since commit c369299895a591d96745d6492d4888259b004a9e:

  Linux 7.0-rc5 (2026-03-22 14:42:17 -0700)

are available in the Git repository at:

  https://github.com/kvm-riscv/linux.git tags/kvm-riscv-7.1-1

for you to fetch changes up to ddbf9c76c4020bf63a0799b00faad40caa3de6c2:

  RISC-V: KVM: Fix shift-out-of-bounds in make_xfence_request()
(2026-04-06 09:43:02 +0530)

----------------------------------------------------------------
KVM/riscv changes for 7.1

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

----------------------------------------------------------------
Anup Patel (6):
      RISC-V: KVM: Introduce common kvm_riscv_isa_check_host()
      RISC-V: KVM: Factor-out ISA checks into separate sources
      RISC-V: KVM: Move timer state defines closer to struct in UAPI header
      RISC-V: KVM: Add hideleg to struct kvm_vcpu_config
      RISC-V: KVM: Factor-out VCPU config into separate sources
      RISC-V: KVM: Don't check hstateen0 when updating sstateen0 CSR

Fangyu Yu (3):
      RISC-V: KVM: Support runtime configuration for per-VM's HGATP mode
      RISC-V: KVM: Cache gstage pgd_levels in struct kvm_gstage
      RISC-V: KVM: Reuse KVM_CAP_VM_GPA_BITS to select HGATP.MODE

Jiakai Xu (8):
      RISC-V: KVM: Validate SBI STA shmem alignment in kvm_sbi_ext_sta_set_reg()
      KVM: selftests: Refactor UAPI tests into dedicated function
      RISC-V: KVM: selftests: Add RISC-V SBI STA shmem alignment tests
      RISC-V: KVM: Fix array out-of-bounds in pmu_ctr_read() and
pmu_fw_ctr_read_hi()
      RISC-V: KVM: selftests: Fix firmware counter read in sbi_pmu_test
      RISC-V: KVM: Fix double-free of sdata in kvm_pmu_clear_snapshot_area()
      RISC-V: KVM: Fix integer overflow in kvm_pmu_validate_counter_mask()
      RISC-V: KVM: Fix shift-out-of-bounds in make_xfence_request()

Jinyu Tang (1):
      KVM: riscv: Skip CSR restore if VCPU is reloaded on the same core

Mayuresh Chitale (1):
      KVM: riscv: selftests: Implement kvm_arch_has_default_irqchip

Osama Abdelkader (2):
      RISC-V: KVM: fix PMU snapshot_set_shmem on 32-bit hosts
      riscv: kvm: fix vector context allocation leak

Wang Yechao (2):
      RISC-V: KVM: Fix lost write protection on huge pages during dirty logging
      RISC-V: KVM: Split huge pages during fault handling for dirty logging

Yufeng Wang (1):
      riscv: kvm: add null pointer check for vector datap

 arch/riscv/include/asm/kvm_gstage.h                |  51 +++-
 arch/riscv/include/asm/kvm_host.h                  |  23 +-
 arch/riscv/include/asm/kvm_isa.h                   |  20 ++
 arch/riscv/include/asm/kvm_vcpu_config.h           |  25 ++
 arch/riscv/include/uapi/asm/kvm.h                  |   8 +-
 arch/riscv/kvm/Makefile                            |   2 +
 arch/riscv/kvm/aia_device.c                        |   4 +-
 arch/riscv/kvm/gstage.c                            | 198 +++++++++++---
 arch/riscv/kvm/isa.c                               | 253 ++++++++++++++++++
 arch/riscv/kvm/main.c                              |  16 +-
 arch/riscv/kvm/mmu.c                               |  70 ++---
 arch/riscv/kvm/tlb.c                               |   3 +-
 arch/riscv/kvm/vcpu.c                              | 111 +++-----
 arch/riscv/kvm/vcpu_config.c                       | 103 ++++++++
 arch/riscv/kvm/vcpu_fp.c                           |   9 +-
 arch/riscv/kvm/vcpu_onereg.c                       | 284 ++-------------------
 arch/riscv/kvm/vcpu_pmu.c                          |  33 ++-
 arch/riscv/kvm/vcpu_sbi_sta.c                      |  16 +-
 arch/riscv/kvm/vcpu_timer.c                        |   3 +-
 arch/riscv/kvm/vcpu_vector.c                       |  11 +-
 arch/riscv/kvm/vm.c                                |  49 +++-
 arch/riscv/kvm/vmid.c                              |   3 +-
 .../testing/selftests/kvm/include/kvm_util_types.h |   2 +
 tools/testing/selftests/kvm/include/riscv/sbi.h    |  37 +++
 tools/testing/selftests/kvm/lib/riscv/processor.c  |   5 +
 tools/testing/selftests/kvm/riscv/sbi_pmu_test.c   |  20 +-
 tools/testing/selftests/kvm/steal_time.c           |  98 +++++--
 27 files changed, 956 insertions(+), 501 deletions(-)
 create mode 100644 arch/riscv/include/asm/kvm_isa.h
 create mode 100644 arch/riscv/include/asm/kvm_vcpu_config.h
 create mode 100644 arch/riscv/kvm/isa.c
 create mode 100644 arch/riscv/kvm/vcpu_config.c
