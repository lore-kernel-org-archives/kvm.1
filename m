Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561B3149C6F
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 21:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782509738; cv=none; b=I+c3Gp2wPTOzmgNWRspc8cFOoFkrteFjowrFvHw1eqLydHtAiHsracGDfl2PmhSfD26jvRGQ2rK+UeYVO2tN/6/rk1nz6EuypRSJ0COhQ0wSF3FA7AC5h6S1WyMivPLPf+KflGJGBJ9Kc35gcTPHWPR6ZYP/9BiC1uL8Aoh567M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782509738; c=relaxed/simple;
	bh=xmC6Zm25Sem/RMdLgn3hnz62Ng5WXHrROj5q5PWdiz4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=O8kdI89ouYjpnzb0bHJAjxwZkQeE5DXmLXzNaPN8GUZEGOHYL5w4wY/E15agJysggfT+NRc0O5EvGBbz+Wb4VSfMDOu+NSmGmfv3HhuGBhMA8uBKYhwMO0pwNcjvPIxBixTeYDeh33E4OkUqv8rI6tGx+yMNFNpU9SbMw6+E/90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SQTVee8V; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SQTVee8V"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8a247a74b7so805030a12.2
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 14:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782509737; x=1783114537; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LeJPhSF7XykTcqCWYKGnt+fCegC9QerUoXnnQkQeerA=;
        b=SQTVee8VvuPFUBk96y4U9XIEwLA/X1IC6MB45blYyQvNaKSL/Sjope9/Nr6miBJwT9
         FwnNMYN+VNoCwFHohKcxtsstSRu3L5sC6s6ftbHnrFXgXI1r0lpzo98W/aHdabk3WMuV
         XdSh/FhOS9HFm5ylNG+zmY/05x7d7NZ/wft4k/6oBAZ6KGF3hZvYxK537KoRnL45XcXk
         9zUZEpQB3dOydUn8EUAklKF/2+LeL9y2VokrZN+s7pqnGqwhm7M/0sVu8b2sm+jCDetA
         5Isi1F8+PqXKaw0Kjgycv8FeNRzcH/5a04tuMvI/1uP7fTBnwTeuLEZV6PfIVpIr1aYY
         C6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782509737; x=1783114537;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LeJPhSF7XykTcqCWYKGnt+fCegC9QerUoXnnQkQeerA=;
        b=O4Jks6u5YCc3+QCnWG9/jdt5XQ7h5XcEX2dFOms/IkNfUYSziOQaIRX4bXMymBJssQ
         LG9FkTLeZkK6fkly4tzau4JWQZuZFAoERLpI4+oIcgp6wRxwpJkssMzX8QYZ5Fa4X+5m
         QUN7fOSXmbrP6M+0L/cIenOe1Kl7pSRBQZTq9DF46JnMbZTrxTyFS6uG3020u1qQHRrk
         eU3NXklWQitk4QUrkhDCXrVj57bkGMsSsBU+nuS0L3WDwVD7m4ncQ8chURauWifsrrzq
         MWd4EzVlTCkMfeftKJdNd7zlZNT3j+OthUrI7iAewVh6/lyH/Yyc5hGkh11hHPurKIml
         rp6A==
X-Forwarded-Encrypted: i=1; AFNElJ/elxhAlBL2p4tBso+3Xu+X6MGZ69Xwxlvlg8u9Y13flPpNDkUAA9FX5afUqUxZLzZE7xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzevLHSEE4V80G7pvsvFZ6/Uils0/sF42DAbxsXZJRT/VB6XDrR
	8OJyeBe6sWcXaIpFLHsHZ6HG59f5A570uil2OZMEZq+nK7vwmWqMer21eg7sg9mz651uyZ9DXq8
	qY6UugQ==
X-Received: from pgll186.prod.google.com ([2002:a63:25c3:0:b0:c93:a359:cea6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d1d:b0:398:c0ba:9ceb
 with SMTP id adf61e73a8af0-3bd4ad233bcmr8360983637.12.1782509736302; Fri, 26
 Jun 2026 14:35:36 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Jun 2026 14:35:13 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260626213534.3866178-1-seanjc@google.com>
Subject: [PATCH v8 00/20] KVM: selftests: Add eventfd+VFIO IRQ test
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Sean Christopherson <seanjc@google.com>
Cc: Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>, 
	Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

David and Josh's series to add a selftest for verifying interrupt delivery
via eventfd (via KVM_IRQFD), and also from a real device, wired up via VFIO.

Gory details in the patches, and in the v5 cover letter.

v8:
 - Explicitly include <time.h>. [Sashiko]
 - Use iova_allocator instea of hardcoding the IOVA. [Sashiko, David]
 - Add a comment explaining why DMA needs to be allocated. [David]
 - Probe /dev/vfio/vfio, not /dev/vfio. [Sashiko, David]

v7:
 - https://lore.kernel.org/all/20260613002031.745413-1-seanjc@google.com
 - Seed kvm_rng during kvm_selftest_init(). [Sashiko]
 - Seed libc's RNG during kvm_selftest_init(), so that the seed (from random())
   that's printed and passed to kvm_rng isn't the same every time.
 - Init irq_cpu to -1 in all paths. [Sashiko]
 - Require the driver to provide .send_msi(). [David]

v6:
 - Massage most changelogs.
 - Fix SoB ordering issues.
 - Clean up KVM_SET_GSI_ROUTING helper.
 - Remove misleading "IRQ injection" and "emulated eventfd" terminology.
 - Add GUEST_RECEIVED_INTERRUPT() to simplifiy the core loop.
 - Use cpu_relax() in tight loops while waiting for interrupts.
 - Print as much information as possible in the actual assert, instead of
   printing to stdout separately.
 - Make a best guess as to the right VFIO vs. IOMMUFD mode instead of
   assuming IOMMUFD, and give the user the option to overide said guess.
 - Simplify open_proc_irq_smp_affinity_list() +
   write_proc_irq_smp_affinity_list() into proc_irq_set_smp_affinity().
 - Drop print_proc_irq_file() and kvm_print_vcpu_affinity() (for now) to avoid
   potential issues on systems with high CPU counts.
 - Drop the blocking/HLT testing as it was at best broken.
 - Use -e for "empty", not -c for "clear", when completely tearing down GSI
   routing, because routing can be "cleared" without completely emptying the
   routing information.
 - Use the main task's CPU affinity as the available_cpus set.
 - Allow overcommiting vCPUs:pCPUs.
 - Set the target vCPU's affinity instead of batching when vCPU0 is targeted.
 - Add support for 256+ vCPUs with x2APIC.
 - Restrict xAPIC mode to 255 vCPUs.
 - Restrict the test to KVM selftest's max supported vCPUs.

v5:
 - https://lore.kernel.org/all/20260604020143.748245-1-jrhilke@google.com
 - Rename get_proc_vfio_irq_number() to vfio_msix_to_host_irq()
 - Rename open_proc_irq_affinity() and write_proc_irq_affinity() to include "_smp_affinity_list"
 - Print /proc/irq/<irq>/smp_affinity and effective_affinity on timeout failures
 - Convert IRQ type from 'int' to 'unsigned int' across helpers and the test
 - Fix compiler warnings for uninitialized variables in irq_test.c
 - Remove rate-limiting on affinity changes

v4: https://lore.kernel.org/kvm/20260530002134.558837-1-jrhilke@google.com

David Matlack (11):
  KVM: selftests: Build and link selftests/vfio/lib into KVM selftests
  KVM: selftests: Add macros to read/write+sync to/from guest memory
  KVM: selftests: Add an irqfd send+receive (and later IRQ bypass) test
  KVM: selftests: Add helper to get host IRQ from device MSI-X for IRQ
    bypass test
  KVM: selftests: Add VFIO device support to eventfd IRQ test
  KVM: selftests: Verify interrupts are received when IRQ affinity
    changes in IRQ test
  KVM: selftests: Add option to set empty routing between IRQs in
    eventfd IRQ test
  KVM: selftests: Make number of IRQs configurable in IRQ test
  KVM: selftests: Verify vCPU migration during IRQ delivery in IRQ test
  KVM: selftests: Make number of vCPUs configurable in IRQ test
  KVM: selftests: Add xAPIC support in eventfd IRQ test

Josh Hilke (6):
  KVM: selftests: Rename guest_rng to kvm_rng
  KVM: selftests: Add helper to generate random u64 in range [min,max]
  KVM: selftests: Add a helper to set proc IRQ affinity for IRQ test
  KVM: selftests: Add kvm_gettid() wrapper and convert users
  KVM: selftests: Add kvm_sched_getaffinity() wrapper and convert users
  KVM: selftests: Add a utility to pin a task to a random CPU, given a
    CPU set

Sean Christopherson (3):
  KVM: selftests: Initialize the default/global pRNG during
    kvm_selftest_init()
  KVM: selftests: Seed libc's RNG before using it to generate a seed for
    KVM's pRNG
  KVM: selftests: Verify non-postable IRQ remapping in IRQ test

 tools/testing/selftests/kvm/Makefile.kvm      |   7 +-
 tools/testing/selftests/kvm/arch_timer.c      |   2 +-
 .../kvm/arm64/arch_timer_edge_cases.c         |   2 +-
 .../selftests/kvm/demand_paging_test.c        |   2 +-
 .../selftests/kvm/dirty_log_perf_test.c       |   4 +-
 tools/testing/selftests/kvm/dirty_log_test.c  |  11 +-
 .../selftests/kvm/include/kvm_syscalls.h      |   7 +
 .../testing/selftests/kvm/include/kvm_util.h  |  12 +
 .../testing/selftests/kvm/include/proc_util.h |  11 +
 .../testing/selftests/kvm/include/test_util.h |  25 +-
 .../selftests/kvm/include/x86/kvm_util_arch.h |   4 +-
 tools/testing/selftests/kvm/irq_test.c        | 362 ++++++++++++++++++
 tools/testing/selftests/kvm/lib/assert.c      |   8 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    |  54 ++-
 tools/testing/selftests/kvm/lib/memstress.c   |   8 +-
 tools/testing/selftests/kvm/lib/proc_util.c   |  54 +++
 tools/testing/selftests/kvm/lib/test_util.c   |  27 +-
 tools/testing/selftests/kvm/mmu_stress_test.c |  15 +-
 tools/testing/selftests/kvm/rseq_test.c       |   6 +-
 tools/testing/selftests/kvm/steal_time.c      |  22 +-
 .../testing/selftests/kvm/x86/sev_dbg_test.c  |   2 +-
 21 files changed, 561 insertions(+), 84 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/proc_util.h
 create mode 100644 tools/testing/selftests/kvm/irq_test.c
 create mode 100644 tools/testing/selftests/kvm/lib/proc_util.c


base-commit: a204badd8432f93b7e862e7dac6db0fe3d65f370
-- 
2.55.0.rc0.799.gd6f94ed593-goog

