Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA761AAE28
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781310036; cv=none; b=pXJucGt0CAouh4bmugBjdRNWKu0nlxXofQz0cmMIOv+P74P44eJD/dABW36RS2mhdGxrI7o6noh9AMA/YgJ7HYMcoNK/8R7ueWdy2Cbw/WkufllwqO3/5H4AXDFiyR2OmeCmFwtIJp8PNPoZVz+ntYCziRN/pEpqVihuqpfDDTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781310036; c=relaxed/simple;
	bh=fp00CPla8I1Pd4aUs418T7CXfCDqWFVQHxfoDTGI80w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AH/o6m8PTaE2E5jJOlfCKbjaIsYMqjlLCDJJEZF0K4Xt/MON7VnY8sQrlwYAwawOO9n1rSTOyNhga0VsI8srAvHXrPK90aKF0K0BV0khv8Cpred2TxHABJJxJkHTuxWzoUMPMUxJVPMS+bMiG04+R44Dzd4nXeqKvWIzXzOOXk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XyXhjd9i; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XyXhjd9i"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8423770d72dso1987812b3a.3
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781310034; x=1781914834; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WmyzcKWN5sYZUTeYCc9CQUvIpkkw/cT2wO4LeW7OYQY=;
        b=XyXhjd9iYlJRk3rCCFKz8QNDGnzlUN61XcAMsOvFsKuhmN71vknkBGaJL6XcYzBlmg
         8U8YSNRmLFhK+C1+AQITPoHE2igGp2vrlIXoU/hZ1rzC5HdPC2O1qDhyiNuD5N8ANQ49
         53APisk8mrG0n+SmQKiwcS53nTE9dvYG8RyR6G1Eg/TYKVG22cIbRx5fzfL5ZsiHyxO5
         rGxCffoWFh9GhIbCNZUYhc8uEWPcUXwOOPkIbQvvxKBuYGNDBP7sRVT0+b6BnyztFuOv
         4jIri+qtvAojA74Rp2dCY0W5aJrJi/YGHykXF+P4Wj7C4z8Xf5L8Cd9S5ZvmYRVVF44k
         A/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781310034; x=1781914834;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WmyzcKWN5sYZUTeYCc9CQUvIpkkw/cT2wO4LeW7OYQY=;
        b=ZNy0t5WXkAl8/vmhCFo1oXjHTagiR4QfkTYn315P4OuedgsjxZaKY9Hl2Xa5ErqlpC
         OwkupK+I3USryM3b817aHsMW71IaU21PJtlQKIbXYWwUeAkEGrFdf5FqnSaCSegSCO92
         xtKRYw2+FxVLqtvlutxKxgeKrgj69nnYJ5S5DmZqBQ2xyPwxFQ0a2dx+TCXn2qoMOltZ
         hq0QfTvkrDuIiDIb0WOlaSnbVWnYDOkhazwrKHRSm5nCOYSuAkWH8+yuZebo+YyyItnc
         QVH1yOnZ3H3kuwF9A+IPhikfT0xswWGGYqpwJCNSdbErdvFXdNM/zpz85ew38PW/xvS9
         KY3Q==
X-Forwarded-Encrypted: i=1; AFNElJ/OzwYAJgdRmiHJfs9vNjuzTtjT/1pJAtY3B5UxLiGTHSzD8iD/48AnjCSLJoCGPm8ugqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLSdwxMeVIJerYfyX+0Er3OQRF9Crb5724v9ycKTNBB3Hh3BlK
	junnpAxWn48+tja5gKps3Qj4P/CT0oByTOM4pOQAIeIGONKcP/rnO8O8DFSvuRUZC5DruI4f0Lt
	h/Xpwtg==
X-Received: from pfbk14.prod.google.com ([2002:a05:6a00:b00e:b0:82f:8cba:4285])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9503:b0:842:3a3b:d6e7
 with SMTP id d2e1a72fcca58-844e1a2c4e5mr2039973b3a.23.1781310033733; Fri, 12
 Jun 2026 17:20:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 17:20:11 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613002031.745413-1-seanjc@google.com>
Subject: [PATCH v7 00/20] KVM: selftests: Add eventfd+VFIO IRQ test
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

I originally wanted to get this into 7.2, but that's not going to happen.  But
I hope to get this applied early in the 7.3 cycle so that additional features
and whatnot can be developed on top without too much pain (hopefully).

Gory details in the patches, and in the v5 cover letter.

v7:
 - Seed kvm_rng during kvm_selftest_init(). [Sashiko]
 - Seed libc's RNG during kvm_selftest_init(), so that the seed (from random())
   that's printed and passed to kvm_rng isn't the same every time.
 - Init irq_cpu to -1 in all paths. [Sashiko]

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
 tools/testing/selftests/kvm/irq_test.c        | 350 ++++++++++++++++++
 tools/testing/selftests/kvm/lib/assert.c      |   8 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    |  53 ++-
 tools/testing/selftests/kvm/lib/memstress.c   |   8 +-
 tools/testing/selftests/kvm/lib/proc_util.c   |  54 +++
 tools/testing/selftests/kvm/lib/test_util.c   |  27 +-
 tools/testing/selftests/kvm/mmu_stress_test.c |  15 +-
 tools/testing/selftests/kvm/rseq_test.c       |   6 +-
 tools/testing/selftests/kvm/steal_time.c      |  22 +-
 .../testing/selftests/kvm/x86/sev_dbg_test.c  |   2 +-
 21 files changed, 548 insertions(+), 84 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/proc_util.h
 create mode 100644 tools/testing/selftests/kvm/irq_test.c
 create mode 100644 tools/testing/selftests/kvm/lib/proc_util.c


base-commit: c1f7303302927f9cbf4efedf70f0512cde168c65
-- 
2.54.0.1136.gdb2ca164c4-goog

