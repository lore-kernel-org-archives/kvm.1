Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EFE4499A4
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 17:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785517585; cv=none; b=ZNPehlMraaG0BymC4fyRiYHWMpu7O89DiLVuX2aj6heFDudqeV+g7TGNJBpN+oO4JdWhrFl8lAo43aFPAuVbCedzNVpkstV8Z8tr6f1wKej6Eb7fItosFFqKpqWLFnFyCKkIs/Z3m9nrHLGR1aHrO4vrudONdpWxzcM4wm4Ig1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785517585; c=relaxed/simple;
	bh=nEjhnWX7wFIEXfQd0Z7Xme3WK41LDz7Nd3rZndNnYmc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rhMHFH6Y9V14hv7rLqgODK8Fj33D8t+lqFpmmO4DBZ2glW3DFY8AsnzHwk7ShFWW9H8Y4ZO6eclKP4BNBOLoVyjgewqiQYMW1mW/zAZgfUMwldGMA/yU+DAWvehdyJkKDnjue3xcLucRX2ZIlLoKuWDCyezxclnuWVeOG7NSbGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AbbydSr2; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AbbydSr2"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8488ac68185so3115489b3a.2
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 10:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785517583; x=1786122383; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q8RSdN/Kl64q03cYx/swNDtgv70+5W1HreJ2G2qg/Nc=;
        b=AbbydSr2Bxq5glaYui2iD6v1woGFR1WwCLZF1Tl61W67fG49WPg5su/mR/sOyygWJL
         g72Roqk5T+wdPV7/tfbWp+15sG7fZ5Jowo5UZSUYYACignAN7IeO0Cf45NRPNFEy1Xx4
         qDdRTReRaVoB/POrXY21BVq6bSOsXAMVXPXYNhrjLpExlpNlEN7opDBho63hHWQnLDVb
         b1v7mIY9zMfKU9mmYBUWy6o+AWqG8bBeSCpJeWW7dlt5IGCE7xYLaqt3NCo89C1hme0K
         k4xZc+aaVFnux7Qv8Co5j5onsSmo1xuhIJGTD8XP+DtWKRQs0MWju/Zkn7WVfTCXvWMr
         O0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785517583; x=1786122383;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Q8RSdN/Kl64q03cYx/swNDtgv70+5W1HreJ2G2qg/Nc=;
        b=L8PKx9tD3ndhzHoM8mp3DLEvfiE4koC5FjBxJbi5J7D8f7hTzNm1u3uVdeSDDjFtG3
         9saDXAIObeZxj+bcuJGcyocZeOqnkKd9Z7Rt+b+uzLvBzXLohUUA8YWkUy9jZQO4738q
         bApooDE67KDE4DmWbiek9KssHSRmFfvdp/SbLtXZ6Ov5eC6FBUZsmdWlHCaJqZo1nvtC
         uYjf1DiLMb0M9Bb2Ota/rEWIzpr5IR/0x3U/F/Xrz0KgYsanGpwRZBiqpw4HM6SyUtZj
         Rz7VEL/+JGCy2XlQtmu0ngx/vmAqu8nSCliIUDzDHxnefA0KNh0xdui16jEsfB1/QgH2
         slPQ==
X-Forwarded-Encrypted: i=1; AHgh+RqCmgxdpB1X2qUgNJchCAMcMVxmndsBVy+lDlQ2v4pmszpi9izFNSwnVk9JonanrgPesLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5h/XEyDfWG+MwX656i7Iww9au5KsjUVTpJpdZaF0LhlMMdIuZ
	8MzBevsWaej2VBioKCEpOsCvNSWbAAM4OcJ4EBhHYOrPwcint2SQcm/3dmrkZ0DW1RriqfFb0Zt
	G2+yQKw==
X-Received: from pfnw22.prod.google.com ([2002:aa7:8596:0:b0:848:2cfd:8fa1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:856:b0:845:c8f9:6ce0
 with SMTP id d2e1a72fcca58-84ee485a40bmr400854b3a.21.1785517582786; Fri, 31
 Jul 2026 10:06:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jul 2026 10:06:07 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731170619.2620845-1-seanjc@google.com>
Subject: [PATCH v2 00/12] KVM: selftests: Add more syscall wrappers, fix hardware_disable_test
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Sean Christopherson <seanjc@google.com>
Cc: Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Buried in the middle of this is a fix for the hardware_disable_test where
it can end up with a runtime of multiple minutes when running a preemptible
kernels on a large NUMA system.  Turns out my analysis/guess in v1 was wrong;
the problem isn't direct CPU contention, it's that letting the workers do any
amount of "real" work on any CPUs leads to pthread_create() slowdowns from
the perspective of the caller.

The vast, vast majority of the changes are adding kvm_xxx() syscall wrappers
so that tests don't need to manually assert that a syscall succeeds (the
hardware disable test had some ugly equivalents).

As with v1, I'm planning on taking this through kvm-x86.

v2:
 - pause() the child after creating workers so as not to busy loop, and to
   maintain equivalent functionality. [Sashiko]
 - Don't bother pinning the parent of immediate child, and instead focus on
   affining workers to their CPUs asap.

v1: https://lore.kernel.org/all/20260730191908.2084803-1-seanjc@google.com

Sean Christopherson (12):
  KVM: selftests: Add a KVM syscall wrapper for sched_setaffinity()
  KVM: selftests: Set threads CPU affinity before doing work in hardware
    disable test
  KVM: selftests: Pre-set threads affinity in hardware disable test when
    possible
  KVM: selftests: Return the target CPU from pin_task_to_random_cpu()
  KVM: selftests: Extract picking of random CPU from cpu_set_t to
    separate API
  KVM: selftests: Affine threads to random CPUs in hardware disable test
  KVM: selftests: Drop unreachable, dead code from hardware disable test
  KVM: selftests: Add KVM syscall wrapper for pthread_create()
  KVM: selftests: Add KVM syscall wrappers for pthread_{cancel,join}()
  KVM: selftests: Add helper APIs to cancel+join pthreads
  KVM: selftests: Add KVM syscall wrappers for
    pthread_{g,s}etaffinity_np()
  KVM: selftests: Clean up global constants in hardware disable test

 tools/testing/selftests/kvm/arch_timer.c      |  18 +--
 tools/testing/selftests/kvm/arm64/vgic_irq.c  |  14 +--
 .../selftests/kvm/arm64/vgic_lpi_stress.c     |   8 +-
 tools/testing/selftests/kvm/dirty_log_test.c  |   4 +-
 .../selftests/kvm/hardware_disable_test.c     | 103 ++++++++----------
 .../selftests/kvm/include/kvm_syscalls.h      |  48 ++++++++
 .../testing/selftests/kvm/include/kvm_util.h  |  11 +-
 tools/testing/selftests/kvm/irq_test.c        |   4 +-
 tools/testing/selftests/kvm/irqfd_test.c      |   4 +-
 .../selftests/kvm/kvm_page_table_test.c       |   6 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    |  10 +-
 tools/testing/selftests/kvm/lib/memstress.c   |   4 +-
 .../selftests/kvm/lib/userfaultfd_util.c      |   7 +-
 .../testing/selftests/kvm/memslot_perf_test.c |   4 +-
 tools/testing/selftests/kvm/mmu_stress_test.c |   4 +-
 .../selftests/kvm/pre_fault_memory_test.c     |   4 +-
 tools/testing/selftests/kvm/rseq_test.c       |  12 +-
 tools/testing/selftests/kvm/s390/memop.c      |   4 +-
 .../selftests/kvm/set_memory_region_test.c    |   6 +-
 tools/testing/selftests/kvm/steal_time.c      |   6 +-
 tools/testing/selftests/kvm/x86/hyperv_ipi.c  |  32 +-----
 .../selftests/kvm/x86/hyperv_tlb_flush.c      |  30 +----
 .../kvm/x86/private_mem_conversions_test.c    |   4 +-
 .../kvm/x86/private_mem_kvm_exits_test.c      |   7 +-
 .../selftests/kvm/x86/recalc_apic_map_test.c  |   5 +-
 .../selftests/kvm/x86/sev_migrate_tests.c     |   4 +-
 .../selftests/kvm/x86/sync_regs_test.c        |   5 +-
 .../selftests/kvm/x86/tsc_scaling_sync.c      |   4 +-
 .../selftests/kvm/x86/xapic_ipi_test.c        |  31 +-----
 .../selftests/kvm/x86/xen_shinfo_test.c       |  10 +-
 30 files changed, 183 insertions(+), 230 deletions(-)


base-commit: 3c7d7f908d574277a845423ec32250a8d8df44c8
-- 
2.55.0.508.g3f0d502094-goog

