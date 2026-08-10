Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CBD3A1A54
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 22:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786402505; cv=none; b=nK4xPUKd+FwqnQLHBHO+aZwxphCnCyz+sMPzIfhAtSzSoUs4c7ItTM1dR8W2Pt0i+bJhWtlUh/7tjgEfdOh3Bfz8HIXFc5rVtLa8APh9lkNvZNFCPSYD/4rMKUL6uGnTfp4BaPMNMnF+iFhaiNtLBCzNUql8VvB+P4mvpvENXrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786402505; c=relaxed/simple;
	bh=UyzjMYugLeXCRTiphTD2D8j6nW8JZFiz/UgO9cW0TeQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=C3OD2LsPyaCN9B5D1bZLYe2XrYjuLKeq6NmEOlL7ZDxBuGfS/sZT2udQtYsXlYParl14cwOvK/Yn70+xLhuogH5lZt2uGwGwvGqVtzDE2TSaUBgH1aQvT/rnOINPv0smY9aB5UUi1f3gfARdUbVFOZF63/s1Sw3EpNsl+jtnixw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vmnAGzzW; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vmnAGzzW"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8484ba00601so3022459b3a.1
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 15:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786402503; x=1787007303; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gtRN2ZX2D3EX3PQYRghtvXXKZWu23JNO6Tdf9z8vOt8=;
        b=vmnAGzzWwx2eGmS2dTYyo68D0ohitatLv9APJcdxtciBmOfuL54PA8MiXsNqMuyC1g
         zjiiXstOFT+nRcNn05CAEVg6UlzqbNK+w9HDo1TUw014ftG1qzmiF1MUb42TjGnPB4E+
         +gw16JObUKts2LkdyoCzdgamPc/UUgyPCtemqfFePYKTcOpMZ3lvVZcfcOWZv3S9T0Nv
         /yVwTYnWgIsOF0Xx+HZfOcrUONtaeXedUvpXyOKoVvkiLb7RmEJSRaW0P/Zb5Bulww6E
         23v5C8EdxKw8k1XQ6psCqpRZurdRZKo3DbnpCmz4JoNtcnb7fA4y651Z/8CiK/FO2one
         ZimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786402503; x=1787007303;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gtRN2ZX2D3EX3PQYRghtvXXKZWu23JNO6Tdf9z8vOt8=;
        b=hpwrT0ds7MP//V7/ZXIvSBGQcxsW7oJjyJ+AjcceMEIajG7qnmwpcfdSrprcmhCMgL
         F1LDiexS6Fl2WDa3M5HujutGzO5ZDyR4RpRneNKtDcAw/aUFerCGWRC8M+Ritv88Rix9
         o+GHUOloY3fSZoEDXyngeMRlyh0yPDFVUe0reYEgLhnwbAlT+BCH7rZ+qlmTnlPMyah2
         ZAfcQ0zun7x5Sg2b9IeRNKJR8nV1FdYZDU+aDzGO9Y9yIK25UNtRa+n83S9xstFngXxX
         y3doPuKobFWm9pJpgU89r9g8lQTEUqkAtIEuss6Sg17Aitz8htRQYlUmCIZOf+AqcvyQ
         aqjg==
X-Gm-Message-State: AOJu0YyJswHIqz0zCa382fiHrkZJLJBLiIlp+L/7DmmfkqPyjRyojeEg
	yIPVduFfBnAZNC3JlaFpfr3nEL0K43lWRiJrC9kN6CpTfqORLmkjYWZhrnERICNuskoBkqHeJpu
	lrqs6mw==
X-Received: from pfh25.prod.google.com ([2002:a05:6a00:12d9:b0:845:c4b8:9730])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1c89:b0:845:2ff5:b66d
 with SMTP id d2e1a72fcca58-84f697338d0mr25674176b3a.35.1786402503184; Mon, 10
 Aug 2026 15:55:03 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 10 Aug 2026 15:54:38 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260810225500.869288-1-seanjc@google.com>
Subject: [PATCH v9 00/21] KVM: x86: Cleaning up the KVM clock mess, part 1
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Durrant <paul@xen.org>, David Woodhouse <dwmw@amazon.co.uk>, Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"

Part 1 of David's series to clean up the host-side mess of kvmclock.  The cut
point in this version is still quite arbitrary, but what's left for "part 2" 
fits nicely into 2-3 buckets:

  1: Masterclock overhaul
  2. New uAPI and tests

As mentioned elsewhere, my plan is to throw this into an unstable topic branch
asap so it can be used as a base for part 2, but will target 7.4, not 7.3.  I
won't publish it to kvm-x86/next until 7.3-rc1, to avoid polluting linux-next,
and I'll rebase the whole thing on one of 7.3-rc1, 7.3-rc2, or an updated
kvm/next.

v9:
 - Pull in "Compute kvmclock base without pvclock_gtod_data" before "Avoid NTP
   frequency skew for KVM clock on 32-bit host" to avoid having to provide what
   is effectively an open-coded version of ktime_mono_to_any() to avoid data
   races. [Sashiko].
 - Pull in use of kernel timekeeping snapshots, split in three patches purely
   to aid review and bisection.
 - Check and clear KVM_REQ_MASTERCLOCK_UPDATE in kvm_arch_vcpu_postcreate().
   [me, Sashiko]
 - Add the missing return value in "Move "no master clock" fallback from...".
   [Sashiko]

v8:
 - Obviously cut partway through the full series.
 - Update commit references for 633d7652f80f ("KVM: x86/xen: Do not corrupt
   KVM clock in kvm_xen_shared_info_init()").
 - Chunk the "Restructure ..." patches into individual logical changes
   ("Restructure kvm_guest_time_update() for TSC upscaling" in particular was
   quite gnarly).
 - Ensure the TSC+freq pair during guest time updates happens on a single
   CPU. [Sashiko]
 - Keep __get_kvmclock() as a masterclock-specific helper to avoid deep
   indentation and gotos.
 - Do waaaaay too much spelunking to try piece together the history of some
   of the many warts.
 - Ensure preemption is disabled in get_kvmclock() when getting the TSC freq.

v7: https://lore.kernel.org/all/20260728144954.355376-1-dwmw2@infradead.org

David Woodhouse (14):
  KVM: x86: Improve accuracy of KVM clock when TSC scaling is in force
  KVM: x86: Explicitly disable TSC scaling without CONSTANT_TSC
  KVM: x86: Activate master clock immediately on vCPU creation
  KVM: x86: Compute kvmclock base without pvclock_gtod_data
  KVM: x86: Avoid NTP frequency skew for KVM clock on 32-bit host
  KVM: x86: Wrap all of __get_kvmclock_master_clock() with
    CONFIG_X86_64=y
  KVM: x86: Fall back to non-master-clock if clockread fails in
    get_kvmclock()
  KVM: x86: Fix KVM clock precision in get_kvmclock() with TSC scaling
  KVM: x86: Use get_kvmclock() in kvm_get_wall_clock_epoch()
  KVM: x86: Fix compute_guest_tsc() to handle negative time deltas
  KVM: x86: Upscale TSC to "now", not master clock when updating PV
    clocks
  KVM: x86: Simplify and comment kvm_get_time_scale()
  KVM: x86: Remove implicit rdtsc() from kvm_compute_l1_tsc_offset()
  KVM: x86: Use kernel timekeeping snapshots for getting kvmclock time
    since boot

Sean Christopherson (7):
  KVM: x86: Update "last guest TSC" snapshot prior to enabling
    IRQs/preemption
  KVM: x86: Drop unnecessary CPU pinning when computing/getting kvmclock
  KVM: x86: Move "no master clock" fallback from __get_kvmclock() to
    get_kvmclock()
  KVM: x86: Disable preemption, not IRQs, when getting TSC+freq pair
  KVM: x86: Make master clock logic in guest PV clock updates 64-bit
    only
  KVM: x86: Use kernel timekeeping snapshot for monotonic clock
  KVM: x86: Use kernel timekeeping snapshot to get walltime+TSC

 arch/x86/include/asm/kvm_host.h |   6 +-
 arch/x86/kvm/cpuid.c            |   1 +
 arch/x86/kvm/msrs.c             |   3 +-
 arch/x86/kvm/svm/svm.c          |   3 +-
 arch/x86/kvm/vmx/vmx.c          |  10 +
 arch/x86/kvm/x86.c              | 491 +++++++++++++++-----------------
 arch/x86/kvm/x86.h              |   3 +-
 7 files changed, 245 insertions(+), 272 deletions(-)


base-commit: 1b731e5ded480bd1e5546aed35584238661ce72e
-- 
2.55.0.679.g6767b8d81c-goog

