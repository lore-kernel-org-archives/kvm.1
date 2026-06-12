Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08E632938D
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 00:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781225291; cv=none; b=W1ptoW0obudXd9ctWPb6qWjbu6WuUChWIDIhtCCGfq7HugR0lL7+zBZYGaezTx1m9JsKvchMaMrKgkvOKowUDiwUrfAKVOs8LEC2LGiM3QrVOiyVdS4usOzBhWK5ZZbOvYs+zKj5/wsLlQfEfehxhhQ24lezlP461G4+tivNfCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781225291; c=relaxed/simple;
	bh=lzKVL3C/IdykepahMcx6SWPEAAR0LtMZrFKRQ5SqxIg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Uk7TePBv9hZ/Bxq+sIsYCGWmapoQqUPdauF34+mwQFv+RttLV+hwmzO/IaGV5Z8r8JAbacGXqB1dx3IhB9fEXF+QOap9FfDC475LDNVA3b8QMHWOyf/s83Y8Y2I2DOqyaA/h7i0chpHyQ/dlvnC79arc5S4/EHklZHu11NZUZLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L8vVLVBU; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L8vVLVBU"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c2d0a8b5beso4192935ad.1
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 17:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781225289; x=1781830089; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=+pNbkchcW0bPBP6fJXRyNGsSd2+rKwDNWwnKfbFHoNs=;
        b=L8vVLVBU48HP0D40PCGGnjVV+dZM81E1v+nXA1m4cU3ecpmdBgq/EW/P5VSLHpvDzm
         qlZAgYIZA5IBRrLxlwws+I3eJ/96ugA7zBwAxDn07RXZPdnC6VnPUNOsDEH2MVIy9eHb
         h1eVA1iYpSDB8zUrBCDu9JpaNgKMZF8zDnVGrCyGXS+lilYBVudG0koyz0NQOFEczUCR
         K8chlMW88xziEK0OoUmzIpD8zKp99TVesKZ5tpyYDb6BqvMm2M7v4eqO628BKdIK09VL
         ZJG7EinKT8Y3Bk4ZiXCJKYy+2FgBqIwuK5VeBmveF9hdi1ImRwDkmjO9QScwMvytixZP
         5Zqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781225289; x=1781830089;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+pNbkchcW0bPBP6fJXRyNGsSd2+rKwDNWwnKfbFHoNs=;
        b=sTjVU18v/R16tJmXb7cJVyEOvGacaLm60CEnP1D1KCIcVGRd0uTuzwMMTZH/yK703l
         iP1kqgwOinNfkQRjAz/DEEmMFn6VHw1KHkM9VxmUCj/rpzTG2JLQrks/Lj9XW+iwfaqB
         eN/s7SsmPGfsDioMgr/NpIVs2u5rHLEBNT1oFb1WyoccrETAUTOdhKG3Bay20svEikwD
         1c70MUX7sihqcRh3rE7PcykDOxOM/0zlBsBCTRpmlwKXUhvnjHSzxbNCcqJUpK2rKn9g
         ZIGuQ0TrLCcyd59QuGeDE9yL9Pj7/PUuaqLZT3oR9b/lKxNwgBF0FMZCVKCm0D+dg4aX
         6c7g==
X-Gm-Message-State: AOJu0Ywm6TZv/0Cf83Jh16QOE+JS3wa/xAK3DR+qCHvmTtDWnpqRr9WK
	OKNWRujt3yNKcxQrBAXC1NsfJK7/Wd46dKf88YVjfX6usXSYhvKE7d/qI6G3CKL/nRQmBqRu9EU
	JwNhNLg==
X-Received: from plko4.prod.google.com ([2002:a17:902:6b04:b0:2bf:1a98:5111])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e807:b0:2b2:ec46:dfed
 with SMTP id d9443c01a7336-2c4126540abmr7464685ad.31.1781225289085; Thu, 11
 Jun 2026 17:48:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 11 Jun 2026 17:47:52 -0700
In-Reply-To: <20260612004755.349925-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612004755.349925-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612004755.349925-8-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: SVM changes for 7.2
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Nested SVM is again the main theme this cycle.  I think this is the last of the
changes? Barring one-offs that will inevitably meander in.

Note, there's no new capability or anything to enumerate support for Host-Only
and Guest-Only PMC support, which is sketchy, but I think is fine?  Because
AFAICT, there's no way for hardware to communicate support, i.e. software just
has to assume it's there.

The following changes since commit b7fbe9a1bf9ee6c967ef77d366ca58c35fcf1887:

  Merge branch 'kvm-apx-prepare' into HEAD (2026-05-13 12:38:31 -0400)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-svm-7.2

for you to fetch changes up to adeb462cecae964ae4525512e31d54e545539476:

  KVM: selftests: Add a test for gPAT handling in L2 (2026-06-03 05:42:35 -0700)

----------------------------------------------------------------
KVM SVN changes for 7.2

 - Add support for virtualizing gPAT (KVM previously just used L1's PAT when
   running L2).

 - Fix goofs where KVM mishandles side effects (e.g. single-step and PMC
   updates) when emulating VMRUN.

 - Fix a variety of bugs in AVIC's handling of x2APIC MSR interception, most
   notably where KVM didn't disable interception of IRR, ISR, and TMR regs.

 - Add support for virtualizing Host-Only/Guest-Only bits in the mediated PMU.

----------------------------------------------------------------
Jim Mattson (9):
      KVM: x86: Define KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT
      KVM: x86: nSVM: Clear VMCB_NPT clean bit when updating hPAT from guest mode
      KVM: x86: nSVM: Cache and validate vmcb12 g_pat
      KVM: x86: nSVM: Set vmcb02.g_pat correctly for nested NPT
      KVM: x86: nSVM: Redirect IA32_PAT accesses to either hPAT or gPAT
      KVM: x86: nSVM: Save gPAT to vmcb12.g_pat on VMEXIT
      KVM: Documentation: document KVM_{GET,SET}_NESTED_STATE for SVM
      KVM: x86: nSVM: Save/restore gPAT with KVM_{GET,SET}_NESTED_STATE
      KVM: x86/pmu: Allow Host-Only/Guest-Only bits with nSVM and mediated PMU

Sean Christopherson (3):
      KVM: x86: Add dedicated API for getting mask of accelerated x2APIC MSRs
      KVM: SVM: Disable x2AVIC RDMSR interception for MSRs KVM actually supports
      KVM: SVM: Only disable x2AVIC WRMSR interception for MSRs that are accelerated

Yosry Ahmed (13):
      KVM: nSVM: Stop leaking single-stepping on VMRUN into L2
      KVM: nSVM: Bail early out of VMRUN emulation if advancing RIP fails
      KVM: nSVM: Unify RIP and PMU handling calls when emulating VMRUN
      KVM: nSVM: Move VMRUN instruction retirement after entering guest mode
      KVM: x86: Move enable_pmu/enable_mediated_pmu to pmu.h and pmu.c
      KVM: x86/pmu: Rename reprogram_counters() to clarify usage
      KVM: x86/pmu: Do a single atomic OR when reprogramming counters
      KVM: x86/pmu: Check mediated PMU counter enablement before event filters
      KVM: x86/pmu: Add support for KVM_X86_PMU_OP_OPTIONAL_RET0
      KVM: x86/pmu: Disable counters based on Host-Only/Guest-Only bits in SVM
      KVM: x86/pmu: Track mediated PMU counters with mode-specific enables
      KVM: x86/pmu: Reprogram Host/Guest-Only counters on nested transitions
      KVM: selftests: Add a test for gPAT handling in L2

 Documentation/virt/kvm/api.rst                     |  26 +++
 arch/x86/include/asm/kvm-x86-pmu-ops.h             |   5 +-
 arch/x86/include/asm/kvm_host.h                    |   6 +-
 arch/x86/include/asm/perf_event.h                  |   2 +
 arch/x86/include/uapi/asm/kvm.h                    |   2 +
 arch/x86/kvm/lapic.c                               |  21 ++-
 arch/x86/kvm/lapic.h                               |   2 +-
 arch/x86/kvm/pmu.c                                 |  21 ++-
 arch/x86/kvm/pmu.h                                 |  44 ++++-
 arch/x86/kvm/svm/avic.c                            |  47 ++---
 arch/x86/kvm/svm/nested.c                          | 107 ++++++++---
 arch/x86/kvm/svm/pmu.c                             |  42 +++++
 arch/x86/kvm/svm/svm.c                             |  40 ++++-
 arch/x86/kvm/svm/svm.h                             |  44 ++++-
 arch/x86/kvm/vmx/pmu_intel.c                       |   2 +-
 arch/x86/kvm/vmx/vmx.c                             |   3 +-
 arch/x86/kvm/x86.c                                 |   9 -
 arch/x86/kvm/x86.h                                 |   3 -
 tools/testing/selftests/kvm/Makefile.kvm           |   1 +
 .../selftests/kvm/x86/svm_nested_pat_test.c        | 196 +++++++++++++++++++++
 20 files changed, 525 insertions(+), 98 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/svm_nested_pat_test.c
