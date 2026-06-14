Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A17E18872A
	for <kvm@vger.kernel.org>; Sun, 14 Jun 2026 09:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781430607; cv=pass; b=kRzzOzfPz3B+K8a201QUpN5X1thD115TumCd3j6bhIYMaEBEwb6qYRPiun/bYSoFwb4XXDopvQGnOB33MR4rdiTMKK5ePjELW4RW9nqa6W7e1bsSmmoE09IvReFjhzbliJRiRz0oA08pJ8y6kHbM9R9VtwnQOF6qFgmqVLklhRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781430607; c=relaxed/simple;
	bh=W13pzyv4m2k6qmGKqmE4BP7wqCKNff48117yoajfiyI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=gza1jNTkZluKnfv1UtstWQ47SUtNSad35i3dFheZskRWhn700ebkGla1d2agyiYVUzaaamSbFwDaS+e//iz9hsMd3+KqV2MOUxIWQRqpef+vzou5xG5BBqjLoio72jLKy4SXpu4uvl/nHOynFJ68hM4LSNS1lYZgzw+LR9qezQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=Xtg00goa; arc=pass smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="Xtg00goa"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7e6e21c47e6so1221861a34.1
        for <kvm@vger.kernel.org>; Sun, 14 Jun 2026 02:50:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781430605; cv=none;
        d=google.com; s=arc-20240605;
        b=LILPuSjfxPPc16Vz1iMbHsVO2DWOJG58mQLFUPP6yfX/KSSEsTP2b00JUK0Wq0NPWO
         WDej4CT3WFUabdGCWS21tej63LKbNqsk0PvkAG0lMCpkmoL3/x/WwdUM4qHUWHn+cjn8
         VbI3XRDoZQXdDJ8PNUOkIgHxrogBOq5I3TyGUaLzQCKV7nmUfrSAn4OxHGcoO8M+SGqZ
         Cj4cvZbhNa5G7uUrORDS2Z4YGt3RDFgL9gL2xm2l+O4p8bPJD9ccQ8GYrJ4VXgPII5AE
         WBSCFZM4V8F0n0ZCrLAyhY73TIR5l0WuveNAdcfbbkGUAHuu9rHt9dIUHnoEh7Uz2Q60
         jnpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=VcEaPc+InRyngVPx1TmveUSubcUpXss3FM5/ylmJY7w=;
        fh=7WzP6+UC/jD2Z0oXgatuGEfBnk5P8NAs0yvFlanhOXk=;
        b=dMPvlu65m4IoRzH8/bycS9A12t6Ref3bGYRzSLwRv6u1Irnm17JMkRKuHpN3qJ/n6r
         EpSnihqj898dCJx6UHnnMJt/Oppl6UWFqLsSSGWjNzGIQXTi2kAYYo0/yyunu54IElW9
         3v6snVHJhFD9IGdA1IS0FaCd0rpEoo8EzSVGXhbjMBILpARMG9ofRMzpeVrS+XuznMoN
         vPEYwgE+k2fpQuNYN2asX/m4I5KCO0DjFzhfkBnwCt5eB2scRhQ/fdBmF5xjaMtHuNek
         IclKeIi/3cZpIsVdwWnoeSjjRd884xPq3WuJupfVggNZv9bJ4aW0z2pszTsMRACkcJLt
         qe2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1781430605; x=1782035405; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VcEaPc+InRyngVPx1TmveUSubcUpXss3FM5/ylmJY7w=;
        b=Xtg00goaM1x8JtlxnyFbSjZyfZGFV5zC4fGuFMNXieFJ896rgHOpfczW3u8JbUssBv
         /nnhsNAr5rX31Bgtye6dlRq/sOILYDfcFuUcvT496ZfP3vHRFCVmV7Dgze+hLwaqVBRB
         wqtGTWSx0CDpGoL3oz9QszNP2Ld9uSwz9kZm57VvuAkB7y8dmGOEWsPns1FyAcZ8ELCW
         igVxmP0OihKIFcCCEVOeXcF/cBbqGwtUDM/qMZYBrImkKavHtEWLClFHQvWaT/v+ac+B
         LiwW24YQ62Tnamu/RZtlRiVzMJHwEZdn8S9Z64BMYPLaFBptY9aPjtIHhMXGnR6kvSzl
         GnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781430605; x=1782035405;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VcEaPc+InRyngVPx1TmveUSubcUpXss3FM5/ylmJY7w=;
        b=c3520mEfSqdwXwl7H23hzrdudHXp1d5Beypy5a0QLx6EfRkkU5m33T+Vo3YkOgPqCY
         tRiMeQRRzMAvl/aVRnNMjH/S7Dd+gBKePEvcZi25gcgGLWY0e6WAD1bGDnK5yf10SKdo
         0baO09b1wxUBprWrzMkAFOB4fT/qlAcM7ZqYEhFqNbaVDtw3Tzv1fxFgOZbFb8XNeib+
         l+tKKDYMp25APy0AU0r8L4WtfolAvPBZDuSZxOhbcCsCpGA1OWAZIe0GhI6lCfE6JjoN
         C/90/5LGTewtOJ9ep4OFWnOPTbjbznCkOwmjITxtFVdxKr8wfpiYDefz3pQpLos0P5g8
         PeFw==
X-Forwarded-Encrypted: i=1; AFNElJ9MjRzAQz+026uKvVogWxYNLoH0w22zRkJIpn6C5/+u8D9xNORXVNH0kq3aPn+hwlqWps8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfJeLCYJXZ9NsXH2AjuTk/uAyjGduJzWoaQfKUiYN+LpuwWUiW
	Mb5Aff0JtXsh1ySlenQ9WHyIbtugOjULXAxNA/ClBV7yVUj9VlM6pE00xh6KMdPttOaa6f6UyOB
	9DCK5N9PmNgnNayGppVgoHLiHnznwXqnKuFUley3qxjLSvViwRuYbEC4=
X-Gm-Gg: Acq92OH0Hfa0QC7p/AwNkNl597Qnf7Z6VqDdB+3f1r5N2XCMkvgs5QYyhcqCZLN7AMt
	tA/Fdx53uPZn7BuSCLwzziBycwjgW3xVDKxiYNaYtnKgwQanykwjUfCBanAVOTtkDuCvw3UeFa3
	9KFXM888VxjXjjeesm1T7JEIZjFRLsP37TOH2627IFWbj6RRIuDNyRg3mU6u/LzkFKtkOb5C08Q
	14tl8M43Vx6QKCkMsMOT2yyp3i5GWSA6JXWZvMLsH9zrfDeXNS3fZ/+ZlDi1K7XsiQi0UXQyzWb
	6kRfokuy74S5g4ylRTfr8X+4IRu82AoBrQlcSUKNasfmzVm3P6oF/qUdvdKcWiSaA7zdgshvydT
	6k7s+tgOh4j2+glvNGhZDfpP4
X-Received: by 2002:a05:6808:f8b:b0:47b:c703:4239 with SMTP id
 5614622812f47-48741bd0be7mr4157764b6e.37.1781430605198; Sun, 14 Jun 2026
 02:50:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Anup Patel <anup@brainfault.org>
Date: Sun, 14 Jun 2026 15:19:53 +0530
X-Gm-Features: AVVi8CfHnWnteBOIh40QsRCyc8p5St1as7WBgGCWiIu98anP84j67OfEd2A8iWA
Message-ID: <CAAhSdy0WTa-jDxg0cQxwqfGM+Det+WxM-ELV3F2ktrcbw8g7Bw@mail.gmail.com>
Subject: [GIT PULL] KVM/riscv changes for 7.2
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, 
	Andrew Jones <andrew.jones@oss.qualcomm.com>, Atish Patra <atish.patra@linux.dev>, 
	"KVM RISC-V (KVM/riscv)" <kvm-riscv@lists.infradead.org>, KVM General <kvm@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"

Hi Paolo,

We have the following KVM RISC-V changes for 7.2:
1) Batch G-stage TLB flushes for GPA range based page table updates
2) Convert HGEI line management to fully per-HART
3) Speed up dirty logging write faults using MMU rwlock and atomic
    PTE updates for permission-only changes
4) Use flexible array for APLIC IRQ state
5) FWFT fixes for missing CSR dirty marking and stale feature
    exposure to Guest/VM
6) Fix logging enable check on a memslot by using
    kvm_slot_dirty_track_enabled()
7) Fixes to avoid skipping valid pages in kvm_riscv_gstage_wp_range()
    and kvm_riscv_gstage_unmap_range()

Please pull.

Regards,
Anup

The following changes since commit e7ae89a0c97ce2b68b0983cd01eda67cf373517d:

  Linux 7.1-rc5 (2026-05-24 13:48:06 -0700)

are available in the Git repository at:

  https://github.com/kvm-riscv/linux.git tags/kvm-riscv-7.2-1

for you to fetch changes up to 52738352a6f29279e15285fcb7b50241ef867e27:

  riscv: kvm: Use endian-specific __lelong for NACL shared memory
(2026-06-14 11:09:41 +0530)

----------------------------------------------------------------
KVM/riscv changes for 7.2

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

----------------------------------------------------------------
Guo Ren (Alibaba DAMO Academy) (2):
      irqchip/riscv-imsic: Add nr_guest_files in per-HART local config
      RISC-V: KVM: AIA: Make HGEI number management fully per-CPU

Inochi Amaoto (1):
      RISC-V: KVM: Enhance the logging check for mmu mapping

Jiakai Xu (2):
      RISC-V: KVM: Document a TOCTOU race in SBI system suspend handler
      RISC-V: KVM: Fix NULL pointer dereference in AIA IMSIC functions

Jinyu Tang (8):
      RISC-V: KVM: Batch stage-2 TLB flushes
      KVM: riscv: Rely on common MMU notifier locking
      KVM: riscv: Use an rwlock for mmu_lock
      KVM: riscv: Add a G-stage PTE cmpxchg helper
      KVM: riscv: Update G-stage PTE permissions atomically
      KVM: riscv: Fast-path dirty logging write faults
      KVM: riscv: Check hugetlb block mappings against memslot bounds
      KVM: selftests: Add a hugetlb memslot alignment test mode

Mayuresh Chitale (1):
      RISC-V: KVM: Fix ebreak self test failure

Qiang Ma (1):
      RISC-V: KVM: Fix timer state restore

Rosen Penev (1):
      RISC-V: KVM: Use flexible array for APLIC IRQ state

Sean Chang (1):
      riscv: kvm: Use endian-specific __lelong for NACL shared memory

Wu Fei (2):
      RISC-V: KVM: Fix skip of valid pages in kvm_riscv_gstage_wp_range
      RISC-V: KVM: Fix skip of valid pages in kvm_riscv_gstage_unmap_range

Yong-Xuan Wang (5):
      KVM: RISC-V: SBI FWFT: Mark vCPU CSRs dirty after setting feature value
      KVM: RISC-V: SBI FWFT: Add optional init() callback for hardware probing
      KVM: RISC-V: SBI FWFT: Fix stale feature exposure after runtime
extension changes
      KVM: riscv: selftests: Refactor ISA and SBI extension sublist macros
      KVM: riscv: selftests: Split SBI FWFT into separate
feature-specific sublists

 arch/riscv/include/asm/kvm_aia.h                  |   2 +-
 arch/riscv/include/asm/kvm_gstage.h               |  10 +-
 arch/riscv/include/asm/kvm_host.h                 |   2 +
 arch/riscv/include/asm/kvm_nacl.h                 |  14 +-
 arch/riscv/include/asm/uaccess.h                  |   2 +-
 arch/riscv/kvm/aia.c                              |  88 +++++----
 arch/riscv/kvm/aia_aplic.c                        |  15 +-
 arch/riscv/kvm/aia_device.c                       |   4 +-
 arch/riscv/kvm/aia_imsic.c                        |   9 +
 arch/riscv/kvm/gstage.c                           | 100 ++++++----
 arch/riscv/kvm/main.c                             |   8 +-
 arch/riscv/kvm/mmu.c                              | 211 ++++++++++++++++++----
 arch/riscv/kvm/nacl.c                             |   2 +-
 arch/riscv/kvm/vcpu.c                             |   1 +
 arch/riscv/kvm/vcpu_sbi_fwft.c                    |  44 ++++-
 arch/riscv/kvm/vcpu_sbi_system.c                  |  14 ++
 arch/riscv/kvm/vcpu_timer.c                       |   2 +-
 drivers/irqchip/irq-riscv-imsic-state.c           |   9 +-
 include/linux/irqchip/riscv-imsic.h               |   5 +-
 tools/testing/selftests/kvm/kvm_page_table_test.c |  28 ++-
 tools/testing/selftests/kvm/riscv/get-reg-list.c  | 138 ++++++++------
 21 files changed, 499 insertions(+), 209 deletions(-)
