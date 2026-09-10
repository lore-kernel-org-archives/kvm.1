Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAD64BE439
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 16:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789057440; cv=none; b=Rd94/MrSy2orjPcXoDwopUCSXWTeNJ6HC/XBQ1aTKZdAWyJf8lMo6USxdTp4WhILIBW9WWTcZHHpxpAjfxok5S7YwvbB/WQG/8q0fgtbJRkXTEO1m69mRzI8b9LdUACRrqOE/AnwgDCv31vUkLtMYeMJv67cRYX3ub4EIQs2Ytc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789057440; c=relaxed/simple;
	bh=ax0I/rbLOr2yb8u0FdwqcUixbFuL4avlzV+xZRV0HlU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ClfJh/DbtIcsk7CC3hjptmlrqoEM76qIVeFcxbNtNSjq5cGKAi3SLF/hbP3YtQRAwliijV9QvzF/Cc2OZSpA0uDfr4yPXEgzpdWfewAJur51Xem9AxhEFNZwMWGtXpOaBZ47n4JuwZuXBGm26d1miHpkLSRQVFHJJTzavH2pOXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BCGHvPDE; arc=none smtp.client-ip=209.85.221.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BCGHvPDE"
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-472c330e555so3617267f8f.1
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 09:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789057435; x=1789662235; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N1aGCX9z0NgEJybPJEfd53e/DnJWPfQPBFps7LJSrpA=;
        b=BCGHvPDEwxThSXnTsJFlkyizcTHoajUUQNr9Z85rNAbm3rOMEHoUm8WNkf2AhNemLS
         4S2a7shnZhpGp00NDaWenLD5CwtZDu1fn3DR+w4U6oJku1NSAXhDVWOyPl2gkIRgWEeU
         sGDOzcJxb9GVpcM2hO/qW9/jx/zRgqvLAPQXkthKRUVbaHUBTLjYeAJswuKGgRSBcU98
         R8JljWApYYSfd6qaggN0zkphhxzHXI3MFzp0bh/eieegNlE+SA7kQtmYWX/cPchYqAW8
         q01QXkR2xuI5xqYkgis189/7SELXEamHpfAC1CMUQNTWcThO6kFIJ7/p6Sukww9qwmME
         gEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789057435; x=1789662235;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N1aGCX9z0NgEJybPJEfd53e/DnJWPfQPBFps7LJSrpA=;
        b=X4xwkdfJn+NTOhpggBq/lLK/NAH2fu04VZFDzqVPzYN4J3J2VO9liubWr3xD41CqJL
         clhUE5i0wqP5ZdsraZ/UKnu+C5F8jSy9JVjp+nJCps3afuYo1tNjcpliWSxh9sNSM5YG
         b371FC/AuLiy/1isH/kRhblrrtTVf+9TywrZcGAD83p0dNJhvArJGOiThUSbI04K6FiY
         kXIgad4N1SJEvH2HJxMeyG6k+0/muJYkKo834EFIdjUoCHANrqDSzDNvDo9XhJ1Z3gAL
         /8LNhcrc/U3VyR6UF3ymz8uyZdynqZ/pzITiOUgmC5YzX450/hmlWCCTZRRah+xoy208
         Y/gQ==
X-Forwarded-Encrypted: i=1; AKwUvBwEZAOkH/7S8STSsJbkMHLUfk/DbouZqdmmNSPA76J7+svtQxCZtBNzmodp88D+nJE4Jro=@vger.kernel.org
X-Gm-Message-State: AFuF++k5gVHWgt3UTCQ2NYo2VBjElMRckYSxZz0EpFSC1ra29ZdC5z3G
	59eRL8BN4BPp70K6koVJKM6waK4mPjGbjWIQwfLp1pPjcseflGCdKvP9fpQi+DniaJp5uxardV8
	4gA==
X-Received: from wmpj6.prod.google.com ([2002:a05:600c:4886:b0:49c:fc36:da7])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4e16:b0:49c:fc6c:bdfc
 with SMTP id 5b1f17b1804b1-49cfc6cc01bmr380585375e9.19.1789057434188; Thu, 10
 Sep 2026 09:23:54 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:21:33 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260910162343.4092060-1-elver@google.com>
Subject: [PATCH RFC 00/10] KVM: Enable Clang Context Analysis
From: Marco Elver <elver@google.com>
To: elver@google.com
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Enable compiler-based static context analysis [1] for x86 KVM, along with
prerequisite lock annotations in virt/kvm.

During the initial annotation pass, context analysis uncovered a missing
SRCU read-side critical section in x86 PMU filter lookups; patch 1 fixes
this bug.

The remainder of the series is strictly non-functional: it establishes
basic function annotations, guarded_by annotations on core structs, and
straightforward refactorings in hva/gfn range walks and guest_memfd to
eliminate conditional locking patterns that cannot be tracked statically.

Annotating the MMU (mmu/mmu.c, mmu/tdp_mmu.c), i8259, and Xen requires
more invasive changes and is deferred to follow-ups.

[1] https://docs.kernel.org/next/dev-tools/context-analysis.html

Marco Elver (10):
  KVM: x86/pmu: Acquire SRCU in pmc_is_event_allowed() to protect filter
    lookup
  KVM: Allow reading memslots while holding slots_arch_lock
  KVM: guest_memfd: Avoid conditional mmu_lock acquisition
  KVM: Refactor kvm_handle_hva_range() to avoid conditional mmu_lock
  KVM: Refactor kvm_handle_gfn_range() to avoid conditional mmu_lock
  KVM: Add basic lock context annotations
  KVM: x86: Add basic lock context annotations
  KVM: Add guarded_by to members in struct kvm
  KVM: x86: Add guarded_by annotations for kvm_arch, kvm_hv, and ioapic
  KVM: x86: Enable CONTEXT_ANALYSIS with opt-outs

 arch/x86/include/asm/kvm_host.h          |  32 ++--
 arch/x86/kvm/Makefile                    |   8 +
 arch/x86/kvm/debugfs.c                   |   1 +
 arch/x86/kvm/hyperv.c                    |  21 +++
 arch/x86/kvm/hyperv.h                    |  16 +-
 arch/x86/kvm/ioapic.c                    |  28 ++-
 arch/x86/kvm/ioapic.h                    |  16 +-
 arch/x86/kvm/irq.c                       |   2 +
 arch/x86/kvm/lapic.c                     |   8 +-
 arch/x86/kvm/lapic.h                     |  15 +-
 arch/x86/kvm/mmu/page_track.c            |   1 +
 arch/x86/kvm/mmu/page_track.h            |   3 +-
 arch/x86/kvm/mmu/spte.h                  |   3 +-
 arch/x86/kvm/msrs.c                      |   5 +
 arch/x86/kvm/msrs.h                      |   3 +-
 arch/x86/kvm/pmu.c                       |   9 +-
 arch/x86/kvm/regs.h                      |  15 +-
 arch/x86/kvm/smm.c                       |   6 +
 arch/x86/kvm/smm.h                       |   2 +-
 arch/x86/kvm/svm/hyperv.c                |   2 +
 arch/x86/kvm/svm/hyperv.h                |   6 +-
 arch/x86/kvm/svm/nested.c                |  30 +++-
 arch/x86/kvm/svm/sev.c                   |  18 ++
 arch/x86/kvm/svm/svm.c                   |  32 ++++
 arch/x86/kvm/svm/svm.h                   |  28 ++-
 arch/x86/kvm/vmx/hyperv.h                |   6 +-
 arch/x86/kvm/vmx/main.c                  |   5 +
 arch/x86/kvm/vmx/nested.c                |  54 +++++-
 arch/x86/kvm/vmx/nested.h                |  19 +-
 arch/x86/kvm/vmx/sgx.c                   |   3 +
 arch/x86/kvm/vmx/sgx.h                   |   3 +-
 arch/x86/kvm/vmx/tdx.c                   |   9 +
 arch/x86/kvm/vmx/vmx.c                   |  11 ++
 arch/x86/kvm/vmx/x86_ops.h               |  24 ++-
 arch/x86/kvm/x86.c                       |  66 ++++++-
 arch/x86/kvm/x86.h                       |  37 ++--
 include/linux/kvm_host.h                 | 215 ++++++++++++++++-------
 scripts/context-analysis-suppression.txt |   1 +
 virt/kvm/dirty_ring.c                    |   2 +
 virt/kvm/eventfd.c                       |   9 +-
 virt/kvm/guest_memfd.c                   |  21 ++-
 virt/kvm/kvm_main.c                      | 183 +++++++++++++------
 virt/kvm/pfncache.c                      |   3 +
 43 files changed, 745 insertions(+), 236 deletions(-)

-- 
2.55.0.1003.g10538fe699-goog
