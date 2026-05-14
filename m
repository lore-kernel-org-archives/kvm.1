Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739FD3939AE
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 21:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778792709; cv=none; b=kaWS1mP7SJYeeAJoz4l40o5bZRFloZuK8S8jSMXlxFgfRJlB+0vc3vX7E3M7PGljRS2gjft/pBBEWO4yDxCj654ANIwnMrFzi/DCaotCMk4ey1dJjf7Mc0/EsMlxnsDEY+NegOyJ0mkixdMoTvrwCmMI2SmILJrtdXH7TbWN35Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778792709; c=relaxed/simple;
	bh=EkJrMVM4C5NDtn989HSXLbfudhv9P5xgOzpU9LAk858=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=i+Phiugq9wMTtUBDNT1rnyTRg06h6zhlbohulAIiO5Udi/sPQo5bMrxkiUSKtz81TU7uo1n5CggEE0JQJ1sUu8X80iiw5hzqv4gKSlk/EwSZiaAX+3+/gaJHKaV+M0fMX1TRACeB0q0Y0dfJJFtj6ofiCtt1R/LcnASAlctiPiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YjYXJtG6; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YjYXJtG6"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c828659ecd4so2977540a12.0
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778792703; x=1779397503; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e65qMpURTIdyADOt8aDhoKIC0tvo+oNi92UOq2sRobs=;
        b=YjYXJtG64vfNPqYu6zoCR+JKb+sx7ljt4R1uD0dHbJAZTOtmRJxBdBSotbPUyKc4La
         tgD350/w9uTTh3DngXWWZIHDAtB6WiuB4WwA6RYuCl5L+7xlYT+lDXm9yorioKzfbXqX
         /AhQCF6YCVzjmW5NOjaCHWwVbKNt9rRUd83xVOEGoYpYKmhR5/NH0E1O8v3iuMcw0dxE
         81zY7JnwxT8uykljP4nZ4vCcIVX6W+89B7TQdJnn0ZCRp6VwkZpWg6nCR4xg0lf8v81k
         3ZxI4iU7ZYtE5eSpbo9ICFGtYD9feO7O9xXWkY4C5f/4OuZi/FInLy8vya+tnZKBsoEa
         ynyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778792703; x=1779397503;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e65qMpURTIdyADOt8aDhoKIC0tvo+oNi92UOq2sRobs=;
        b=p4tC0E1PDrqPs9addCdbuQjD9bseRUcuaUwFbJYqoJQ95eBJEIxnroMoJ2Ui80vZD3
         8zAiKxUPri6x4jDkvBt4zXG5gsm/lIZEEnptIvN52s8wsqhVOGg00f+S5A32vXimrY/K
         O26LRmwufOSdlm6Nq206lkaBk2R6gZOraUBesImQIcRRhQyeTEsHMnDS6fitgBP9Naec
         FQpXq1JD8H6fQBKLcqHkPbXgwwU/O2l1fRjp6owE2kGN5QLvmGOBS1O7NNURUfgGSDTG
         /WtGQrNUfLy298kA7WLOy0F83eMULce4+3B8tN1dJUYhdeF/IBH8ne1vsagyz7YhW0tV
         FLeQ==
X-Gm-Message-State: AOJu0Yw2jFOdGK3HikyXrEIiF99o/JlPD7Gzuu304PTQzWf4oEmJUTnf
	F5W9QRm2xHkPRb/WCZbhPp/lDcuntkQVZ8QLb6l2ESW8S4QRcE3Z7KmHcrTqBia9dMel6KC2SRx
	HaLU77A==
X-Received: from pfbkq4.prod.google.com ([2002:a05:6a00:4b04:b0:839:4a33:c35d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3490:b0:82c:6b23:6d10
 with SMTP id d2e1a72fcca58-83f33c539a4mr1103587b3a.3.1778792702500; Thu, 14
 May 2026 14:05:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 14:04:40 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514210500.1626871-1-seanjc@google.com>
Subject: [kvm-unit-tests PATCH v3 00/20] x86: Better backtraces for leaf functions
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	Mathias Krause <minipli@grsecurity.net>, Andrew Jones <andrew.jones@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Finally re-posting Mathias' work to provide better backtraces on x86, which
was blocked by a fatal bug in the nVMX SIPI test that was exposed by the
stack frame side effects.  This has been sitting on my local system(s) for
something like 5 months, and I all but forgot I hadn't posted it.

Most of this series is cleaning up the nVMX and nSVM to play nice with
multi-CPU tests.  Then to fix the race in the problematic SIPI, abuse the
VM-Entry MSR load list to atomically detect VM-Enter (I'm still proud of
that hack).

For gory details:

https://lore.kernel.org/all/3bac29b9-4c49-4e5d-997e-9e4019a2fceb@grsecurity.net

Mathias Krause (3):
  x86/vmx: Initialize test stage in SIPI test *before* launching AP
    thread
  x86: Better backtraces for leaf functions
  x86: Prevent realmode test code instrumentation with nop-mcount

Sean Christopherson (17):
  x86/vmx: Drop unused SYSENTER "support" in nested VMX infrastructure
  x86/vmx: Drop unused guest_regs "support" in nested VMX infrastructure
  x86/svm: Sort (and swap) GPRs by their index, not alphabetically
  x86: Dedup guest/host context switch of registers across SVM and VMX
  x86/virt: Use macro shenanigans to get reg offsets when swapping
    guest/host regs
  x86/virt: Track "guest regs" using per-CPU variable
  x86/svm: Don't VMLOAD/VMSAVE "guest" state around VMRUN
  x86/vmx: Use separate VMCSes for BSP vs. AP in INIT test
  x86/vmx: Swap GPRs after checking "launched" status
  x86/vmx: Track VMCS "launched" state per-CPU
  x86/vmx: Track "is this CPU in guest mode" per-CPU
  x86/vmx: Communicate hypercalls via RAX, not a global field
  x86/kvmclock: Replace spaces with tabs
  x86/kvmclock: Skip kvmclock test when not running on KVM with
    CLOCKSOURCE2
  x86/vmx: Tag "struct vmx_msr_entry" as needing to be 16-byte aligned
  x86/smp: Align the stack to a 16-byte boundary when invoking SMP
    function calls
  x86/vmx: Write to KVM's WALL_CLOCK MSR via VM-Entry load list sync in
    SIPI test

 lib/x86/processor.h |  15 +++
 lib/x86/smp.c       |  21 ++++-
 lib/x86/smp.h       |  32 +++++++
 lib/x86/virt.h      |  61 ++++++++++++
 x86/Makefile.common |  14 +++
 x86/kvmclock.c      |  42 ++++-----
 x86/kvmclock.h      |   2 +
 x86/kvmclock_test.c | 225 +++++++++++++++++++++++---------------------
 x86/realmode.c      |   3 +
 x86/svm.c           |  19 ++--
 x86/svm.h           |  61 ++----------
 x86/svm_tests.c     |   5 +-
 x86/vmx.c           | 121 +++++++++++-------------
 x86/vmx.h           |  72 +-------------
 x86/vmx_tests.c     | 134 ++++++++++++++++----------
 15 files changed, 443 insertions(+), 384 deletions(-)
 create mode 100644 lib/x86/virt.h


base-commit: 4d60e2429d63dc0c24990114a8afc89e86c187cc
-- 
2.54.0.563.g4f69b47b94-goog

