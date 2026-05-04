Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269E437FF6D
	for <kvm@vger.kernel.org>; Mon,  4 May 2026 22:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777934552; cv=none; b=LoalnKj4syluF+ZicrSUuqpQti9sn5xhiCXgZ8h4go1g/zqs4vPNSRS5BKdKRZGXqjNDni84jsS7qUHTfPIeRGhrSs2isM5FHymn+cX2Mn+DBbzyrMi5l+opd7l09JcWWTSnNE1TYaHlEGy+P7WIaxlQgxBivOZjAbWqnPwD8rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777934552; c=relaxed/simple;
	bh=a6LAKe8ovUnasAZFDeUefPCWvqT60LXkBEdqdXAd5Mc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cPbOGAemU2Ns/T37EGl33qH8JMo9tGZm6zahNEmIjdNI6pBDQXfU2tCf7cXHB6NZzByVIsIBvDidyYbEjze1MIH6G6LqeAJ/J8yUr7tZwpFbyeEayKnVduL+/vZeJ/ukjD7zspRRgX00no4rOWpKDaVnBTIkxv4YX6usVO+mLLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ryZOcgIt; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ryZOcgIt"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-835444b6ce1so1102339b3a.1
        for <kvm@vger.kernel.org>; Mon, 04 May 2026 15:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777934549; x=1778539349; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GreUyu/PwGDkwAAEFHxYx5rSO95cp1lrcmL4UWkbrcg=;
        b=ryZOcgItCTMmspuCz7IdlBgmKbqunTzqWlbsTKriNiDv2O7aXSE2bEAanMEPuG2u1i
         uov6MU8yULjzlO2skfe2SuzpfWoTkwgQxMx5pJ1c+Hlkga7ARcYf+JYbwCcCNO3mk46W
         X9Vh6QOrvCZtLRCgvdCNQN7ji4llNJfAqqSy84VdLeGQ70C6ibuGbYRpMyT+Y7+oA8wf
         vih07ciic+le39yPFpdASzpS6BcFXvsXzGLP3aOH81WcJIM4/f0COqdI6by74RLDe1Zw
         QpfrhBBCzPDPhCBwTqDv4KGroQs2uSPrXdbsnHhj8+1VB9i2/6xPAWQ8aSS50QqsKyZY
         NvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777934549; x=1778539349;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GreUyu/PwGDkwAAEFHxYx5rSO95cp1lrcmL4UWkbrcg=;
        b=iq1xIngyVenPS+ykDtWs6cDg0JpTxr/8pKnDjVL0Y/FWFb0x5weXWBr0a2EeXX8IVi
         jVMd59BQdL5vl9aFcalnImADrd1lebt8uu8gEit+bZdqS53Efu6TEmIU1BJu8yt2Sonz
         UshT0qjf4AU6LB/0XqkX7kmzYOMECbCpcdDuCCCwr2dTEvuS7yDt502TvuEbtcxhbs05
         ixjV72+M57JeRoHK6mb3fukkaw7HAaOdadFqzKpGlHK+2ggeKxzzAfZ+bzvSUZK8IRWf
         Nw1s4F3A+HLMPRBb5eYjPMeMo4U3arSyKOij9Ri8mg9MMVFDoo3bzr62wU2VB+mk7M1g
         orBw==
X-Forwarded-Encrypted: i=1; AFNElJ/k5QXBNV8isz6d8ILNn+DEuGPT4IcDGKrskbwxRRU3cKE/B0Snc4C5z1sRlkO8E1PUa9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbnu3r6QF7ntPgakjVS+Uozv0TxBN+rT8c8Rku/5XpRvQtLIj/
	u0OSXczVuB3kVg2z5zxnhzbNtNioSD++wNv9Jdp9vKBS77N6HS8BHLvjOYBgdX59PCad8VcYgcA
	SL9cEsLitYQLXdT0w14cAoQ==
X-Received: from pfbhm13.prod.google.com ([2002:a05:6a00:670d:b0:82f:7bc:70a9])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4c96:b0:82c:ded1:261f with SMTP id d2e1a72fcca58-8352d22c289mr10958941b3a.27.1777934549232;
 Mon, 04 May 2026 15:42:29 -0700 (PDT)
Date: Mon,  4 May 2026 22:42:07 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504224213.1049426-1-jthoughton@google.com>
Subject: [PATCH 0/5] KVM: Fix race conditions in kvm_arch_flush_shadow_all()
From: James Houghton <jthoughton@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Sean Christopherson <seanjc@google.com>, Gavin Shan <gshan@redhat.com>, 
	Shaoqin Huang <shahuang@redhat.com>, Ricardo Koller <ricarkol@google.com>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, James Hogan <jhogan@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi Paolo,

syzbot running on Google production kernels ran into a double-free on
KVM/arm64 in kvm_mmu_free_memory_cache(). It turns out that loongarch
and mips also have a similar problem.

kvm_arch_flush_shadow_all() can be called on the same memslot
concurrently, leading to double-freeing in arm64 and mips. loongarch
is also affected: it can at least underflow some counters; I'm not sure
what else can break.

To get into this scenario, we need to have a process (P1) share an open
VM with another process (P2). If P1 closes its VM to leave P2 holding
the last reference, then there is a race between P1 exiting (exit_mm)
and P2 dropping its last reference to the VM.

exit_mm() and kvm_vm_release() both call kvm_mmu_notifier_release() on
the same KVM, and the only locks held are the KVM srcu lock and the MMU
notifier srcu lock.

Please see the arm64 patch for another description of the same race with
more context on the ensuing double-free in KVM/arm64.

The first three patches fix each broken architecture; each of those
patches have stable CCed with what I think are the appropriate Fixes.

After patching the locking for the broken architectures, it seems better
simply to have KVM take the MMU lock exclusively before calling
kvm_arch_flush_shadow_all() so that architectures don't need to worry
about it. Feel free to drop that patch, the fourth one, if you disagree
with it.

The fifth patch provides a repro (with a crude kernel patch to reliably
demonstrate the double-free). Please do not merge this.

The arm64 patch has been tested with the repro. The loongarch and mips
patches have been compile-tested only.

kvm_arch_guest_memory_reclaimed() is only implemented by one
architecture: x86. Its implementation does not need the KVM MMU lock to
be held.

This series is based on 7.1-rc2.

James Houghton (5):
  KVM: arm64: Grab KVM MMU write lock in kvm_arch_flush_shadow_all()
  KVM: loongarch: Grab MMU lock in kvm_arch_flush_shadow_all()
  KVM: mips: Grab MMU lock in kvm_arch_flush_shadow_all()
  KVM: Hold MMU lock exclusively when calling
    kvm_arch_flush_shadow_all()
  DO NOT MERGE: KVM: selftests: Reproducer for arm64 double-free

 arch/arm64/include/asm/kvm_host.h             |   1 +
 arch/arm64/include/asm/kvm_mmu.h              |   1 +
 arch/arm64/kvm/mmu.c                          |  39 +++++-
 arch/arm64/kvm/nested.c                       |   4 +-
 arch/loongarch/kvm/mmu.c                      |   2 +
 arch/mips/kvm/mips.c                          |   2 +
 arch/mips/kvm/mmu.c                           |   2 +
 arch/riscv/kvm/mmu.c                          |   4 +-
 arch/riscv/kvm/vm.c                           |   2 +
 arch/x86/kvm/mmu/mmu.c                        |   4 +-
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../testing/selftests/kvm/transfer_fd_test.c  | 129 ++++++++++++++++++
 virt/kvm/kvm_main.c                           |   3 +
 13 files changed, 184 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/transfer_fd_test.c

base-commit: 6d35786de28116ecf78797a62b84e6bf3c45aa5a
-- 
2.54.0.545.g6539524ca2-goog

