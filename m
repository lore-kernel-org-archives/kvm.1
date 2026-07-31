Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61F335C6B0
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 19:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785527779; cv=none; b=G74ofJW40Zqg88wQCvT0ztS5Cw4T0CYkGVMmWlMAfHQD3uhcI5K4xdk6rcprEq1YPn7G6e/MHsTB0LFg8tCGWzAFuHkozqSmhRNc/KS5vzKyz/bXztk5xMqSAJpb70H6jl8pu9sBVGj90QgGBgpHQypIFJpsZ84ROlseyIZAwjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785527779; c=relaxed/simple;
	bh=3fYMoDOUaPLH6H3jOqppLqZSunZ2qguFE3mngU72OtU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KOBRL9IqnNJj8jXyiE6Fb2QvxqXHqjBx/XO2DKFr6Iduz4i0d9u79F4V5VrGc5k6HJ4zOEok9Fm8n1botV5TuGnR/jxeF5PHSZLnlTY0TXy9e1BVwAoHh19Cyn2VoklZfV+FCpyPhGiyYGyXxpz8c1JMQuacfg73HFil9GsnCXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m8xs03vI; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m8xs03vI"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8486c3411c8so1813413b3a.2
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 12:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785527776; x=1786132576; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gd1m/0mWimKO7o4EYRsTYXZShyBAIYbMepMSGbfxdyY=;
        b=m8xs03vI0/z9rgUsSMqoh9WNy+284IuveqeVWgydFjcUhS+edEViyZLVk5JYOMcAal
         5TSMlumnYEDkDdAD9DdluJnD5iqgtftwYGJFptRy3NsKHffqe7xNW59nVdKRDmMre42V
         xrABQ9Ky2HwBJ5Oey7ZN3MFDQmt2uU1oc1EXIidTVEjXUXPi2AuTOVCFq3mWF8RfY+xA
         AAssrOG0Gvb8WJ3lgaN/izU4164xzGgqXZ28G+/Pl+Ig/bTfHurPHgJx8EcSbp0f0o8P
         pIRzqLL+IEMqJgNmYae9anMUz8wP6txJCAJbnyxQKm/weV1YbIsQZK3C/3PQf21U5J+k
         AXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785527776; x=1786132576;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Gd1m/0mWimKO7o4EYRsTYXZShyBAIYbMepMSGbfxdyY=;
        b=QE84FbUwocYzYlOMofNpcJQD/hTFufcnF7MHSfgLftDoyOwVAMUopQEp8xLyU9bplG
         ZJEPJKJg/uyCXelLqAaTGx6QrMp88EWFjRI/QahNOGbw4DQHtwcJ18IREnlmlwCbLy7T
         v1fr0cqpiFDOscw7jA3SpFfz9Ni2Te62aIZ/ijoDu4rfEDe1FSfknkEXy9wb1+ft+vBl
         j1BefT5gM4wpeNHXlxCxrEEIkNeub5WQoZaNQqq0pUu4iOtWUjfVgJQOETes6H5esC2l
         llMg4OqSBEsEphbf42ZDOWUIow/5iSxKsxubHw6aekZ1eIhZpg9CPp3qBDcoZrgs1BsF
         V/uw==
X-Forwarded-Encrypted: i=1; AHgh+Rob3nRY/ElBMybFBrGmb73B0nlNZ5tTnHCm0551yFz4Ip/gWKNU8J3DJ8y2HooHJ0nB0EM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWB79zpVevb4MLkep4WjHqd9nm7o9GBhIV9TFftD1Yg719nGet
	p3gB9FincQUD7yoD5mLYx/H1EFVeztMN6JAUdL4nCEOYWePTzOAr/ctoZKlzgOwHQlUH9WswRzN
	cfLkRAQ==
X-Received: from pfble14.prod.google.com ([2002:a05:6a00:4fce:b0:84e:530a:923a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4fca:b0:84c:4bf4:10c3
 with SMTP id d2e1a72fcca58-84ee490ac3bmr716956b3a.38.1785527775964; Fri, 31
 Jul 2026 12:56:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jul 2026 12:56:00 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731195612.2697986-1-seanjc@google.com>
Subject: [PATCH v3 00/12] KVM: selftests: Add more syscall wrappers, fix hardware_disable_test
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

Third time's a charm.  Sorry for the spam.

Buried in the middle of this is a fix for the hardware_disable_test where
it can end up with a runtime of multiple minutes when running a preemptible
kernels on a large NUMA system.  Turns out my analysis/guess in v1 was wrong;
the problem isn't direct CPU contention, it's that letting the workers do any
amount of "real" work on any CPUs leads to pthread_create() slowdowns from
the perspective of the caller.

The vast, vast majority of the changes are adding kvm_xxx() syscall wrappers
so that tests don't need to manually assert that a syscall succeeds (the
hardware disable test had some ugly equivalents).

v3:
 - Key off _GNU_SOURCE, not __USE_GNU. [Sashiko]
 - Clear consumed CPUs from the allowed set. [Sashiko]
 - Assert that settings affinity attributes succeeds. [Sasiko]

v2:
 - https://lore.kernel.org/all/20260731170619.2620845-1-seanjc%40google.com
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
 .../selftests/kvm/hardware_disable_test.c     | 109 ++++++++----------
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
 tools/testing/selftests/kvm/x86/hyperv_ipi.c  |  32 +----
 .../selftests/kvm/x86/hyperv_tlb_flush.c      |  30 +----
 .../kvm/x86/private_mem_conversions_test.c    |   4 +-
 .../kvm/x86/private_mem_kvm_exits_test.c      |   7 +-
 .../selftests/kvm/x86/recalc_apic_map_test.c  |   5 +-
 .../selftests/kvm/x86/sev_migrate_tests.c     |   4 +-
 .../selftests/kvm/x86/sync_regs_test.c        |   5 +-
 .../selftests/kvm/x86/tsc_scaling_sync.c      |   4 +-
 .../selftests/kvm/x86/xapic_ipi_test.c        |  31 +----
 .../selftests/kvm/x86/xen_shinfo_test.c       |  10 +-
 30 files changed, 187 insertions(+), 232 deletions(-)


base-commit: 3c7d7f908d574277a845423ec32250a8d8df44c8
-- 
2.55.0.508.g3f0d502094-goog

