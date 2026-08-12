Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A676403AE2
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 21:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786570339; cv=none; b=O+wbpsPUjG+QCmH9/K9cbt4SwQf0iOVemwyg44V8zMSHqgZaz2d6hvShBvMu7rHn+qqTgzcp1OnFl5eF2RXi1KK2dHrVhUMdvBc480xP13paSaksShBoXfK1wSy8U/0KYJZqs02S9kxYKE7W7eMz7fTJwMQiQ6dpXqLfYItOsTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786570339; c=relaxed/simple;
	bh=3Ip9ivfB84IbhPVjJ8wUqFD3NlwcdYrxNpWxSYUA0B4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KnqbxL3zvQdvlDBK/FP179TxgD1Kgg6Z5qfZeArtRwuHAP7vKWmIaIDafL3YFgt5OXsDTkNSUhzasICmevAj4SBGwDn4fgbiBXgN6RZqwBvLsPTkoIT7yFv3mW1MBD69mWCOPLP4gjpYtnlT+afKcqI0qv2Ow0GZjsOjBo82+wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MEpUPjDO; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MEpUPjDO"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e2f61c09dso1961596a91.2
        for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 14:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786570337; x=1787175137; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=A7x1/e7C1Fz6TW7BsHQaURtvu/WGeTBmHdFINQWOUnQ=;
        b=MEpUPjDOAV770bVTwH7mrPK/S/J/7lD4S0ZW/yxhIUnaXVDpcF8ELAXGZsQFgDGNH/
         i9MVaO3B54GJujMWacY5RZRIDYZS5+2rnT0/klrmWveM2RoQuY99w+sW8ZRYiAbuatJZ
         r4M46IB8mOfb78ZaZDMaa0RIgGBptp3teB+pAwtBiQMeDuKWJBStS8Qjg7dAhr2b6s9s
         tZflTcp9DtqqyEOjx9pT8IJ7mofscOcGiM5xFkiNyOJmyBhlgtOibJBpFbM+QU9P99vg
         16YX5HRBsp/tCx+J8pHm/NqBn2+LGxu8RrEaz3WPhJNBp9dAzVp4BOTSpMcgzobGp7IZ
         cIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786570337; x=1787175137;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A7x1/e7C1Fz6TW7BsHQaURtvu/WGeTBmHdFINQWOUnQ=;
        b=RgJS1EZpC75JOqS5BYDIQMyirXEPIikfXwDv6nMpBhnkAg54b7NLukz5KU6FQVKaoN
         XQfglbv5KOjdoTv8AywGbJDB/mXWSTfcw7MFND3jkxIeON08xDcbil82HPmrpoWZ1CQ8
         QQ8YEggaUVah0FtoX39+oHdKC261pJYDh0zzTpySVPZJZlo/oswIdksuIreK9BrsZj5w
         rNEYYcRHauc6l2IeDenEWJKE0D8EgICsZ37+NuJHh4BbFzgBHpHOCDi5NoXePrdeazcj
         nyDZlfRWIhSgNIYWIuaLB985GtJ4JTpoD7zBp7T5b2Iit/cfSnL+G4KTUpPCsmPvn0kr
         yyRA==
X-Gm-Message-State: AOJu0YzrC8LZ90J8ndrCswBStSgDNtXdUeP1o0WMV558D6uktFbzs92P
	HV3dzBOUmu7BqNjVw+sQCsUiGvPXQ+m5UIlOu62dtcyBkTn6UcwHHXKlyQgUaHjjzrm8Q2+5fd9
	XZOuqLw==
X-Received: from pjbmr22.prod.google.com ([2002:a17:90b:2396:b0:381:1d7f:b8db])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d83:b0:392:b509:b1a5
 with SMTP id 98e67ed59e1d1-3931e2519b5mr1412907a91.14.1786570337053; Wed, 12
 Aug 2026 14:32:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 12 Aug 2026 14:32:03 -0700
In-Reply-To: <20260812213206.1564354-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812213206.1564354-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812213206.1564354-9-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: KVM: Selftests change for 7.3, part 2
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Selftests, part 2.  This was originally just the irq_test from David and Josh,
but I piled on fixes for hardware_disable_test and pmu_counters_test that rely
on the pRNG changes/enhancements.

There have been a few hiccups with linking to the VFIO selfest library, but I
think they're all sorted out.  I.e. this should Just Work on your end.

As mentioned in the cover letter, this will conflict with part 1.  Part 2 just
adds syscall wrappers, i.e. keep the functional test changes from part 1, but
use the newfangled wrappers from part 2.

diff --cc tools/testing/selftests/kvm/steal_time.c
index 92e7ffcd68b7,83a1e3aa15cf..6e9cc0e34ec0
--- tools/testing/selftests/kvm/steal_time.c
+++ tools/testing/selftests/kvm/steal_time.c
@@@ -553,11 -553,7 +548,11 @@@ int main(int ac, char **av
  
                /* Steal time from the VCPU. The steal time thread has the same CPU affinity as the VCPUs. */
                run_delay = get_run_delay();
-               pthread_create(&thread, NULL, do_steal_time, NULL);
-               pthread_getaffinity_np(thread, sizeof(cpuset), &cpuset);
 -              kvm_pthread_create(&thread, &attr, do_steal_time, NULL);
++              kvm_pthread_create(&thread, NULL, do_steal_time, NULL);
++              kvm_pthread_getaffinity_np(thread, sizeof(cpuset), &cpuset);
 +              TEST_ASSERT(CPU_COUNT(&cpuset) == 1 && CPU_ISSET(cpu, &cpuset),
 +                          "Worker failed to inherit parent's CPU affinity");
 +
                do
                        sched_yield();
                while (get_run_delay() - run_delay < MIN_RUN_DELAY_NS);

The following changes since commit 8cdeaa50eae8dad34885515f62559ee83e7e8dda:

  Linux 7.2-rc2 (2026-07-05 14:44:06 -1000)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-selftests2-7.3

for you to fetch changes up to 4fe8b4e1545a0179ceebe098cce0dcfe9134a6cd:

  KVM: selftests: Create one VM with many vCPUs for each major PMU counters test (2026-08-10 08:04:13 -0700)

----------------------------------------------------------------
KVM selftests changes for 7.3, part 2

 - Fix several issues with seeding KVM's pRNG, and rework the pRNG APIs to that
   the pRNG can be sanely used in host code, not just guest code.

 - Add an IRQ test to validate virtual IRQ deliverty for IRQs wired up via
   KVM_IRQFD + KVM_SET_GSI_ROUTING, with optional support for triggering IRQs
   via writes to an assigned VFIO device.

 - Add syscall wrappers to assert success on a variety of pthreads and CPU
   affinity APIs.

 - Set vCPU pthread affinity as early as possible to reduce contention issues
   that were surfaced by PREEMPT_LAZY, which result in runtimes of over a
   minute on large hosts, versus the expected ~5 seconds.

 - Rework the PMU counters test to run each testcase using a single VM with
   many vCPUs for each sub-testcase, instead of using a unique VM for each
   sub-testcase.  This cuts the runtime by ~20x.

----------------------------------------------------------------
David Matlack (11):
      KVM: selftests: Build and link selftests/vfio/lib into KVM selftests
      KVM: selftests: Add macros to read/write+sync to/from guest memory
      KVM: selftests: Add an irqfd send+receive (and later IRQ bypass) test
      KVM: selftests: Add helper to get host IRQ from device MSI-X for IRQ bypass test
      KVM: selftests: Add VFIO device support to eventfd IRQ test
      KVM: selftests: Verify interrupts are received when IRQ affinity changes in IRQ test
      KVM: selftests: Add option to set empty routing between IRQs in eventfd IRQ test
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
      KVM: selftests: Add a utility to pin a task to a random CPU, given a CPU set

Sean Christopherson (18):
      KVM: selftests: Initialize the default/global pRNG during kvm_selftest_init()
      KVM: selftests: Seed libc's RNG before using it to generate a seed for KVM's pRNG
      KVM: selftests: Verify non-postable IRQ remapping in IRQ test
      KVM: selftests: Only link to VFIO library on x86
      KVM: selftests: Add a KVM syscall wrapper for sched_setaffinity()
      KVM: selftests: Set threads CPU affinity before doing work in hardware disable test
      KVM: selftests: Pre-set threads affinity in hardware disable test when possible
      KVM: selftests: Return the target CPU from pin_task_to_random_cpu()
      KVM: selftests: Extract picking of random CPU from cpu_set_t to separate API
      KVM: selftests: Affine threads to random CPUs in hardware disable test
      KVM: selftests: Drop unreachable, dead code from hardware disable test
      KVM: selftests: Add KVM syscall wrapper for pthread_create()
      KVM: selftests: Add KVM syscall wrappers for pthread_{cancel,join}()
      KVM: selftests: Add helper APIs to cancel+join pthreads
      KVM: selftests: Clean up global constants in hardware disable test
      KVM: selftests: Add KVM syscall wrappers for pthread_{g,s}etaffinity_np()
      KVM: selftests: Test one random GP counter in PMU arch events testcase
      KVM: selftests: Create one VM with many vCPUs for each major PMU counters test

 tools/testing/selftests/kvm/Makefile.kvm                       |  12 +++-
 tools/testing/selftests/kvm/arch_timer.c                       |  20 ++----
 tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c      |   2 +-
 tools/testing/selftests/kvm/arm64/vgic_irq.c                   |  14 ++--
 tools/testing/selftests/kvm/arm64/vgic_lpi_stress.c            |   8 +--
 tools/testing/selftests/kvm/demand_paging_test.c               |   2 +-
 tools/testing/selftests/kvm/dirty_log_perf_test.c              |   4 +-
 tools/testing/selftests/kvm/dirty_log_test.c                   |  15 ++---
 tools/testing/selftests/kvm/hardware_disable_test.c            | 109 ++++++++++++++-----------------
 tools/testing/selftests/kvm/include/kvm_syscalls.h             |  55 ++++++++++++++++
 tools/testing/selftests/kvm/include/kvm_util.h                 |  21 ++++++
 tools/testing/selftests/kvm/include/proc_util.h                |  11 ++++
 tools/testing/selftests/kvm/include/test_util.h                |  25 +++----
 tools/testing/selftests/kvm/include/x86/kvm_util_arch.h        |   4 +-
 tools/testing/selftests/kvm/irq_test.c                         | 362 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/kvm/irqfd_test.c                       |   4 +-
 tools/testing/selftests/kvm/kvm_page_table_test.c              |   6 +-
 tools/testing/selftests/kvm/lib/assert.c                       |   8 +--
 tools/testing/selftests/kvm/lib/kvm_util.c                     |  52 +++++++++++----
 tools/testing/selftests/kvm/lib/memstress.c                    |  12 ++--
 tools/testing/selftests/kvm/lib/proc_util.c                    |  54 ++++++++++++++++
 tools/testing/selftests/kvm/lib/test_util.c                    |  41 ++++++++++--
 tools/testing/selftests/kvm/lib/userfaultfd_util.c             |   7 +-
 tools/testing/selftests/kvm/memslot_perf_test.c                |   4 +-
 tools/testing/selftests/kvm/mmu_stress_test.c                  |  19 ++----
 tools/testing/selftests/kvm/pre_fault_memory_test.c            |   4 +-
 tools/testing/selftests/kvm/rseq_test.c                        |  16 ++---
 tools/testing/selftests/kvm/s390/memop.c                       |   4 +-
 tools/testing/selftests/kvm/set_memory_region_test.c           |   6 +-
 tools/testing/selftests/kvm/steal_time.c                       |  26 +++-----
 tools/testing/selftests/kvm/x86/hyperv_ipi.c                   |  32 ++-------
 tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c             |  30 ++-------
 tools/testing/selftests/kvm/x86/pmu_counters_test.c            | 227 ++++++++++++++++++++++++++++++++++++----------------------------
 tools/testing/selftests/kvm/x86/private_mem_conversions_test.c |   4 +-
 tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c   |   7 +-
 tools/testing/selftests/kvm/x86/recalc_apic_map_test.c         |   5 +-
 tools/testing/selftests/kvm/x86/sev_dbg_test.c                 |   2 +-
 tools/testing/selftests/kvm/x86/sev_migrate_tests.c            |   4 +-
 tools/testing/selftests/kvm/x86/sync_regs_test.c               |   5 +-
 tools/testing/selftests/kvm/x86/tsc_scaling_sync.c             |   4 +-
 tools/testing/selftests/kvm/x86/xapic_ipi_test.c               |  31 ++-------
 tools/testing/selftests/kvm/x86/xen_shinfo_test.c              |  10 +--
 42 files changed, 883 insertions(+), 405 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/proc_util.h
 create mode 100644 tools/testing/selftests/kvm/irq_test.c
 create mode 100644 tools/testing/selftests/kvm/lib/proc_util.c
