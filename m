Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA873C2D
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 00:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780100580; cv=none; b=d/MO6WHT2Cs2ITGUabGG/0Oalfi6PaQvmrEkmcrRuBjo0HM8mXJ5RooyjEjATDsuWyYrvCxetfvwYmsfRiXJgu/ES9k/JAREuHUVae7q8McWbweZqt09kvYv2LBQSRZ8LhlshG2jmvR6cJ5OVDZhgp0yGHipm2gdfwBNuCLSqHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780100580; c=relaxed/simple;
	bh=XDY/e6y/pqWNJvfEwKI1E9W2gkWol5Z1CfB+B7PBiXk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WXZYtETNdFc8vQ0AFTgAgelatfSX76WdQvZ1Gm1QpQKOKjtagOx/EwrHV2H8o/Kjg/9qPmUlzDzMk5eP/lga0wydYkMdMmN0OMNhtm4mFq9hLOJgaAHDg+eYGT/YZMJ0L22ayuVedGS9/MjaTQuIpcE1nsq1ux7bcfqGZhRi2N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nEqeYwFu; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nEqeYwFu"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36b9106b0fbso1669706a91.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 17:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780100577; x=1780705377; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AgTu89yTYwkieiKYURPcExxeCVTfHh00EXFY4PAaEro=;
        b=nEqeYwFus/OfbRDcJ9o2meu43a52ZZ8PPovOKGF4Chl4VolQLaexq1ayZvkl7w8vub
         Cj4nWFVDyTdH/9h1eAoMj4IICub+ZBbLwBlL7pPKX1Kir2x41ZG9OmLim5aI/PFWHU1+
         NoHJjEdzO3zmdfCDi0IcEGI0MwmJplOkiO1n+LoXS0aHt8JbUmzdYxho7D9N4ElcB4fK
         noQ1VryDkU3+DcNB2Ndh58axvM+mmMlRTF+NrMZChI3718W0WB7CYpiYRCkEdXxUNDfi
         5YsYukHxrnsTt1AZMn+Cqc1OSAgF2dLlAybXRRXlkucXAJnLh2a+htDsvTX6xw87CM4t
         5R4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780100577; x=1780705377;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AgTu89yTYwkieiKYURPcExxeCVTfHh00EXFY4PAaEro=;
        b=Dem1UTcHRlS7/0Aq+yEyleIMZYO3HLL3fIjatbEbPkRgcRA9hACCdfTv5LSYEUnFEj
         0n9cm48s60J6r6VD0YcOq/IfGSBs7MKCHfaU43VxZsQeaSQcOZp8iux0bXvPv/wmADWf
         Omc0L59vH9UkEcobzXjBLagDYXExWGmt8GU50iqmk+PlGHuHTrPUlQWboKm7mlR1n+kE
         7WtiXp0QCo5RTfkCT/wjmqvYNf31ZMxUAY2+PeAME+peuMM57dFI7ZAopiw8jk0n8OdA
         RbaTVze244f9WemE/mu+FA0ETn5RT7XNEdGNzuL36S7RbBHMYtX4QwFVqGP827CxQzNt
         rtWA==
X-Gm-Message-State: AOJu0YwBHf7Thp8sxZZqGSFLqhI1VdwiSACyN3zrqdKTp+k+hBjDG2/w
	IDIgavXCIZLFSHjDO17/Fo3adFesIx1vtMZ6rzouLJtpB0Qd9qGE21QQyohPs0XYlgv6/diIzGV
	t0x+jKA02
X-Received: from pjtl13.prod.google.com ([2002:a17:90a:c58d:b0:36a:b898:125a])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:33c5:b0:36b:97b4:df7
 with SMTP id 98e67ed59e1d1-36beb578668mr1262912a91.9.1780100576662; Fri, 29
 May 2026 17:22:56 -0700 (PDT)
Date: Sat, 30 May 2026 00:21:15 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260530002134.558837-1-jrhilke@google.com>
Subject: [PATCH v4 00/19] KVM: selftests: Link with VFIO selftests lib
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

This is v4 of a series which introduces tools/testing/selftests/kvm/irq_test.c
in KVM selftests. This test exercises the delivery of interrupts (both
emulated via eventfd and real from a VFIO device) to guest vCPUs. Beyond basic
injection, the series adds coverage for several complex scenarios, including:
- Dynamic updates to KVM's GSI routing table while interrupts are active.
- Waking up halted vCPUs via interrupts.
- Stressing interrupt delivery during random host IRQ affinity changes.
- Stressing interrupt delivery during random vCPU thread migration across
  physical CPUs.
- Testing non-postable interrupt remapping (using NMIs to force transitions).
- Supporting both xAPIC and x2APIC modes in the guest.

The series also links the VFIO selftests library into KVM selftests to enable
testing of VFIO-KVM interactions.

The test can optionally use a PCI device bound to vfio-pci to test physical
device interrupts. If using a device, it can be invoked by passing the BDF to
the VFIO selftests setup script, and then running the test with the device BDF
passed via the -d option:
$ ./tools/testing/selftests/vfio/scripts/setup.sh 0000:6a:01.0
$ tools/testing/selftests/kvm/irq_test -d 0000:6a:01.0

This test only supports x86. Testing physical device interrupts (-d argument)
requires a device with a supported VFIO selftest driver. Currently supported
devices include:
- Intel DSA (Data Streaming Accelerator), 8086:0b25
- Intel IOAT (I/O Acceleration Technology), 8086:2021

The test can be run with following command-line arguments allow for broad
coverage of the interrupt delivery path:
-a: Random IRQ Affinity. Randomly affinitizes the device IRQ to different host
    CPUs to verify stable delivery during interrupt steering changes.
-b: Block vCPUs. Causes vCPUs to HLT instead of spinning, verifying that
    Posted-interrupt wakeup (PIW) correctly kicks blocked vCPUs.
-c: Clear GSI Routes. Periodically destroys/recreates KVM's GSI routing table to
    verify handling of dynamic IRQ updates.
-d: Device MSI Triggers. Uses the physical device to trigger MSIs instead of
    eventfd emulation (requires a supported device driver).
-i: IRQ Count. Sets the number of interrupts to generate (default 1000).
-m: vCPU Migration. Migrates vCPUs to random physical CPUs to verify that
    posted interrupts follow the vCPU across host cores.
-n: NMI Delivery. Routes interrupts as NMIs into the guest to verify the
    VFIO-NMI delivery path.
-v: vCPU Count. Distributes interrupts across multiple vCPUs via round-robin
    routing.
-x: xAPIC Mode. Forces legacy xAPIC mode to verify compatibility.

---
Changelog

v3 -> v4
- Add context to short logs specifying if the change relates
  specifically to the IRQ test (Sean)
- Format code correctly (Sean)
- Fix compilation errors for gettid() wrapper (Sean)
- Add macros for GUEST_RECEIVED_NMI and GUEST_RECEIVED_IRQ (Sean)
- Split helper functions into separate patches (Sean)

David Matlack (12):
  KVM: selftests: Build and link selftests/vfio/lib into KVM selftests
  KVM: selftests: Add /proc/interrupts parsing helpers for IRQ test
  KVM: selftests: Add guest read/write macros
  KVM: selftests: Add IRQ injection test
  KVM: selftests: Verify IRQ bypass works in IRQ test
  KVM: selftests: Verify interrupts are received when IRQ affinity
    changes in IRQ test
  KVM: selftests: Verify IRQs wake up halted vCPUs in IRQ test
  KVM: selftests: Verify interrupts are received after modifying IRQ
    routes in IRQ test
  KVM: selftests: Make number of IRQs configurable in IRQ test
  KVM: selftests: Verify non-postable IRQ remapping in IRQ test
  KVM: selftests: Make number of vCPUs configurable in IRQ test
  KVM: selftests: Add xAPIC support in IRQ test

Josh Hilke (7):
  KVM: selftests: Rename guest_rng to kvm_rng
  KVM: selftests: Add helper to generate random u64 in range [min,max]
  KVM: selftests: Add kvm_gettid() wrapper and convert users
  KVM: selftests: Add kvm_sched_getaffinity() wrapper and convert users
  KVM: selftests: Add pin_task_to_random_cpu() helper function
  KVM: selftests: Verify vCPU migration during IRQ delivery in IRQ test
  KVM: selftests: Print vCPU affinity on timeout during IRQ test

 tools/testing/selftests/kvm/Makefile.kvm      |   8 +-
 tools/testing/selftests/kvm/arch_timer.c      |   2 +-
 .../kvm/arm64/arch_timer_edge_cases.c         |   2 +-
 .../selftests/kvm/demand_paging_test.c        |   2 +-
 .../selftests/kvm/dirty_log_perf_test.c       |   4 +-
 tools/testing/selftests/kvm/dirty_log_test.c  |   8 +-
 .../selftests/kvm/include/kvm_syscalls.h      |   6 +
 .../testing/selftests/kvm/include/kvm_util.h  |  13 +
 .../testing/selftests/kvm/include/proc_util.h |  28 ++
 .../testing/selftests/kvm/include/test_util.h |  25 +-
 .../selftests/kvm/include/x86/kvm_util_arch.h |   4 +-
 tools/testing/selftests/kvm/irq_test.c        | 370 ++++++++++++++++++
 tools/testing/selftests/kvm/lib/assert.c      |   8 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    |  95 ++++-
 tools/testing/selftests/kvm/lib/memstress.c   |   8 +-
 tools/testing/selftests/kvm/lib/proc_util.c   |  62 +++
 tools/testing/selftests/kvm/lib/test_util.c   |  27 +-
 tools/testing/selftests/kvm/mmu_stress_test.c |  15 +-
 tools/testing/selftests/kvm/rseq_test.c       |   6 +-
 tools/testing/selftests/kvm/steal_time.c      |  22 +-
 20 files changed, 635 insertions(+), 80 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/proc_util.h
 create mode 100644 tools/testing/selftests/kvm/irq_test.c
 create mode 100644 tools/testing/selftests/kvm/lib/proc_util.c

-- 
2.54.0.929.g9b7fa37559-goog

