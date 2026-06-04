Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D1B175A6E
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 02:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780538557; cv=none; b=KeYqRHqmTr1nfpk/r/SknDjGBgTAuMXCTgghqdKilorZoUSB/sHo+eJ/FO3njzmKMT5zIhaVX99uuitgd3Y5AbLj5qh/eaiq7JQt7LLwNDva+LBQpocWD6VY/Fc34bcieLB4U3YsNtVeOGnrF4TaOiF8hSx5ehZX7a0tzvyjWAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780538557; c=relaxed/simple;
	bh=VYlWDo8o4f8vZOJc91OjCuhi+ovI85j/XzW7oLd8DJ8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CtBMeFvuTSqyKAFKfsNQvp3qRtLMfwCmJ4HcTUxrXIEItrucZg7+j0pQtUw56XpLoLWernv9apWnpULMOgO3xF17hOk9FCr8Ub6U/86WOytqC7Xg5tbHk+ldkqwpxPrK6AC3mYM1efXmDhhmmS2QveqzeoPfmtu9bja4IWDaL68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ATM+8Ggq; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ATM+8Ggq"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c85a2c305d0so114427a12.1
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 19:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780538551; x=1781143351; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5RM9vk558S4zFDRS/ScU6KHIKNB4ppYtrx4Jjv5iCqA=;
        b=ATM+8GgqkJvLo9ZGFAudA72KycdBs4iMq9YbR5WA7R1gXeVRrX48F1G7W5YlrzmmWR
         /pBMFEc2FhNkfYXP4wVgCfwqeZxX6+1QnVWbrTVvYh/W71ORIzwRjldkHrAdnw5tAaiT
         RdH0FheIL7AF0FRHzYdPy/wQSVr+TB2te8Q/X3rSrejNwq/LNKB54eaJYNG0v0bTIQjw
         ti7Loq6DQWpmww1fWuADpvar6Ol9hsVR7xSkgP5y84MxAgaPbK7P68H0XIJAoJi17xhJ
         80irbBZzd4CU7Ygw6pHqqLbfgfEIQU9e1ZV/2bZ/X/JtA+K5CmWDWT4B1HFnWArRLsCF
         2fOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780538551; x=1781143351;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5RM9vk558S4zFDRS/ScU6KHIKNB4ppYtrx4Jjv5iCqA=;
        b=ly5xUn9zEyBstrwih26dtGjJLg4xTySSE0l6rGp3tROy3VrECeKoq1A8jHMkfbl3X+
         K4bYR/RRShfqGQfK7Rh62+jLtVS3UZzJQ03qWoOA7E9dXcRwM8Vpdc9PsHB5YP3fYI5H
         i7Axo80DBNS5hZfh3MI65cHmLZBZNfUZCUSjKmmLi5gId+PUcu1ZNfgOtnSHhOwB+oP3
         3uJoknK08jmxFVRUSjngKL3LM58yfOSDArBBMSAardeKem5OakwoAf8yzuYH79SXyQhi
         CywMi/VUwLEBRzn/KK0JAOGu4+1dmBE6o5uwEgSDo1F2noHLNnKKgYkTj9tigDllMDmh
         oXHA==
X-Gm-Message-State: AOJu0Yw4p5IQ8uyJamxXtnzNnnw0NP4uNRPSsbFg+M9z1PFQpBYn2HDE
	BHgwmBIjh0xgWa63MFo3f5SsdzoiVT4PD+ufWoZoMNzfAevcBFAgcfhgNxowPKof8yLG7IzPCW3
	vsaRGyKeJ
X-Received: from pllt11.prod.google.com ([2002:a17:902:dccb:b0:2bd:4a28:b705])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:37c4:b0:2b4:59bf:5728
 with SMTP id d9443c01a7336-2c1644ca7bfmr63287465ad.25.1780538550887; Wed, 03
 Jun 2026 19:02:30 -0700 (PDT)
Date: Thu,  4 Jun 2026 02:01:22 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604020143.748245-1-jrhilke@google.com>
Subject: [PATCH v5 00/21] KVM: selftests: Link with VFIO selftests lib and
 test device interrupts
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

This is v5 of a series which introduces tools/testing/selftests/kvm/irq_test.c
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

v4 -> v5
- Rename get_proc_vfio_irq_number() to vfio_msix_to_host_irq()
- Rename open_proc_irq_affinity() and write_proc_irq_affinity() to include "_smp_affinity_list"
- Print /proc/irq/<irq>/smp_affinity and effective_affinity on timeout failures
- Convert IRQ type from 'int' to 'unsigned int' across helpers and the test
- Fix compiler warnings for uninitialized variables in irq_test.c
- Remove rate-limiting on affinity changes

v4: https://lore.kernel.org/kvm/20260530002134.558837-1-jrhilke@google.com/

David Matlack (13):
  KVM: selftests: Build and link selftests/vfio/lib into KVM selftests
  KVM: selftests: Add guest read/write macros
  KVM: selftests: Add IRQ injection test
  KVM: selftests: Add helper to get host IRQ from device MSIX for IRQ
    bypass test
  KVM: selftests: Verify IRQ bypass works in IRQ test
  KVM: selftests: Verify interrupts are received when IRQ affinity
    changes in IRQ test
  KVM: selftests: Verify IRQs wake up halted vCPUs in IRQ test
  KVM: selftests: Verify interrupts are received after modifying IRQ
    routes in IRQ test
  KVM: selftests: Make number of IRQs configurable in IRQ test
  KVM: selftests: Verify non-postable IRQ remapping in IRQ test
  KVM: selftests: Verify vCPU migration during IRQ delivery in IRQ test
  KVM: selftests: Make number of vCPUs configurable in IRQ test
  KVM: selftests: Add xAPIC support in IRQ test

Josh Hilke (8):
  KVM: selftests: Rename guest_rng to kvm_rng
  KVM: selftests: Add helper to generate random u64 in range [min,max]
  KVM: selftests: Add helpers to write proc IRQ affinity for IRQ test
  KVM: selftests: Add helpers to print proc IRQ affinity for IRQ test
  KVM: selftests: Add kvm_gettid() wrapper and convert users
  KVM: selftests: Add kvm_sched_getaffinity() wrapper and convert users
  KVM: selftests: Add pin_task_to_random_cpu() helper function for IRQ
    test
  KVM: selftests: Print vCPU affinity on timeout during IRQ test

 tools/testing/selftests/kvm/Makefile.kvm      |   8 +-
 tools/testing/selftests/kvm/arch_timer.c      |   2 +-
 .../kvm/arm64/arch_timer_edge_cases.c         |   2 +-
 .../selftests/kvm/demand_paging_test.c        |   2 +-
 .../selftests/kvm/dirty_log_perf_test.c       |   4 +-
 tools/testing/selftests/kvm/dirty_log_test.c  |  11 +-
 .../selftests/kvm/include/kvm_syscalls.h      |   7 +
 .../testing/selftests/kvm/include/kvm_util.h  |  13 +
 .../testing/selftests/kvm/include/proc_util.h |  15 +
 .../testing/selftests/kvm/include/test_util.h |  25 +-
 .../selftests/kvm/include/x86/kvm_util_arch.h |   4 +-
 tools/testing/selftests/kvm/irq_test.c        | 380 ++++++++++++++++++
 tools/testing/selftests/kvm/lib/assert.c      |   8 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    |  95 ++++-
 tools/testing/selftests/kvm/lib/memstress.c   |   8 +-
 tools/testing/selftests/kvm/lib/proc_util.c   |  90 +++++
 tools/testing/selftests/kvm/lib/test_util.c   |  27 +-
 tools/testing/selftests/kvm/mmu_stress_test.c |  15 +-
 tools/testing/selftests/kvm/rseq_test.c       |   6 +-
 tools/testing/selftests/kvm/steal_time.c      |  22 +-
 20 files changed, 662 insertions(+), 82 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/proc_util.h
 create mode 100644 tools/testing/selftests/kvm/irq_test.c
 create mode 100644 tools/testing/selftests/kvm/lib/proc_util.c

-- 
2.54.0.1032.g2f8565e1d1-goog

