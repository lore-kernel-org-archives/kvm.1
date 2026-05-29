Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BD03F0A95
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780070127; cv=none; b=qE8/d824kOMOeijFHZA4J6X+pX3vP98hNXgGLW9EbZ3vFxcXEyZRyU+9AZxaL0HrQUsh5sTll+PoGOoGAs1XH29rOz+AxEbrhb4s+SJ2fFImk8RJTiVuAN6LSK9JsGlynU+J1ynYykNrszwElNnWr0g2ZPabj/JjaYD4U6HVX2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780070127; c=relaxed/simple;
	bh=MPekpOmVM9cy6pAQtPZmqQ+GI0F1bNOBDLZF9ynrjfQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nxfORqgZl9mGT40LhynX1q9HUt2ijgWOFPilgHIjX6r4sSGrpZcnbPlGnaAB4R3DRRG2CI9W3TxTDRkBeFgVEpwnTEUa/htrXKgqQ1jz+62eULhD2ZpGkCinsXfFdz/1kc5h2Yybk4ITnBig16w7NC1E0DGsZQc1qZlCMs6j7rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZMCY2JC7; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZMCY2JC7"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf11699875so19789665ad.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 08:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780070125; x=1780674925; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjHgfxwvXMtVPpXnGJo4Cf3+yZWR0DtQaShqMdAKP/s=;
        b=ZMCY2JC7WQBEDA7DfF8WN/yLX35ghqx/1NYrgydrF/EwKTKGYMgHwBE8jwr+9tkeL8
         /P1kbY0iuer5Wt0lgEk4DN3YdDNHg6yudV6GjKSBXEOFNsQIdd9rvpy79Xtin5NYox/B
         Y8t8ccm0S01HHNKP4FsmmP/1ZbnZ992z1C0hMWrUDCZOMlbhYpPrREbUbjz6CIh9S5s2
         4P2F3tiTUqfEC7SCHsm1TT+sJl3wz5I/MXnots2wwtIXZF66PJZ2eVD+Lg3LhmTNEziH
         EMz783WsAxUaybLiFc3YBd0fy7L76DMBTsq52iVmXpu8HuikFHi+PfpnB6nzGOwiP7O3
         MwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780070125; x=1780674925;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yjHgfxwvXMtVPpXnGJo4Cf3+yZWR0DtQaShqMdAKP/s=;
        b=XbkIUsJo+6ThFlKZfKooJE0UBqS/SKxg4TAPUbRLflxWesIZaRPefGnM0+MzR3dity
         ggjk6DSNdoBIludPb5HQ7XKl0F7YnLg7J8d8DqdJMRU8WQV4ygbjBd8TY3r9dED67NhV
         8NZjeRyPNRoI7yIYjlYTe1sbcPgDOpFwx+Ich0UNKlIZfoA9VI7yDjkzkR09ZvgaaSbC
         991zjpB/p7eVldCPpRK37LOhEE0NtWRY6R/LWGheY/aQ4lwGrcm9QCPVq1RdBZlVJPKC
         OGSFdxwTOpuh8rpSbbDEx3u74JTsaadRXVfcmDd4J/joI3zwnhrLoyGOAYfe2rYHtw0l
         xlEQ==
X-Gm-Message-State: AOJu0Yyird2TLDNsM8KpbyBcT6sa4TUqJQGO5XMrf6EcBwl6wOM1gmya
	YYLdYvchgXlI7utltMF5VjphSChPraEo4VXiMx6Lg98lNvZ+bjCdoUuz/DVA04hmysdKhsZpVsQ
	tsTv6VA==
X-Received: from plem12.prod.google.com ([2002:a17:902:e40c:b0:2bc:db94:6f34])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ecc5:b0:2bf:1aa9:6c8a
 with SMTP id d9443c01a7336-2bf204aa477mr37983225ad.12.1780070124770; Fri, 29
 May 2026 08:55:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 08:55:23 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529155523.729502-1-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: Fix for 7.1-rcN
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Except for the execinfo.h non-glibc selftest change, all of these are fixes for
bugs that were introduced in recent kernels (treating enabling x2AVIC by
default as the "introduction" of the TLB bug).

The following changes since commit 2d5d3fc593c9b7e41bee86175d7b9e11f470072e:

  KVM: VMX: introduce module parameter to disable CET (2026-05-13 15:38:22 +0200)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-fixes-7.1-rc6

for you to fetch changes up to a9e18aa3263f356edae305e29830e5fe63d8597a:

  KVM: SVM: Flush the current TLB when transitioning from xAVIC => x2AVIC (2026-05-21 14:24:57 -0700)

----------------------------------------------------------------
KVM x86 fixes for 7.1-rcN

 - Include the kernel's linux/mman.h in KVM selftests to ensure MADV_COLLAPSE
   is defined, as older libc versions may not provide it.

 - Include execinfo.h if and only if KVM selftests are building against glibc,
   and provide a test_dump_stack() for non-glibc builds.

 - Fudge around an RCU splat in the emegerncy reboot code that is technically
   a legitimate flaw, but in practice is a non-issue and fixing the flaw, e.g.
   by adding locking, would incur meaningful risk, i.e. do more harm than good.

 - Rate-limit global clock updates once again (but without delayed work), as
   KVM was subtly relying on the old rate-limiting for NPT correction to guard
   against "update storms" when running without a master clock on systems with
   overcommitted CPUs.

 - Fix a brown paper bag goof where KVM checked if ERAPS is "dirty" instead of
   marking it dirty when emulating INVPCID.

 - Flush the TLB when transitioning from xAVIC => x2AVIC to ensure the CPU TLB
   doesn't contain AVIC-tagged entries for the APIC base GPA.

----------------------------------------------------------------
Emily Ehlert (1):
      KVM: x86: Fix ERAPS RAP clear on INVPCID single-context invalidation

Hisam Mehboob (1):
      KVM: selftests: Guard execinfo.h inclusion for non-glibc builds

Lei Chen (1):
      KVM: x86: Rate-limit global clock updates on vCPU load

Mikhail Gavrilov (1):
      x86/virt: Silence RCU lockdep splat in emergency virt callback path

Sean Christopherson (2):
      KVM: selftests: Include sys/mman.h *and* linux/mman.h, via kvm_syscalls.h
      KVM: SVM: Flush the current TLB when transitioning from xAVIC => x2AVIC

 arch/x86/include/asm/kvm_host.h                    |  1 +
 arch/x86/kvm/svm/avic.c                            | 35 ++++++++++++++++++----
 arch/x86/kvm/x86.c                                 | 13 ++++++--
 arch/x86/virt/hw.c                                 | 15 +++++++++-
 .../selftests/kvm/access_tracking_perf_test.c      |  2 +-
 tools/testing/selftests/kvm/guest_memfd_test.c     |  2 +-
 tools/testing/selftests/kvm/include/kvm_syscalls.h | 10 +++++++
 tools/testing/selftests/kvm/include/test_util.h    |  2 +-
 tools/testing/selftests/kvm/lib/assert.c           |  8 ++++-
 tools/testing/selftests/kvm/lib/kvm_util.c         |  2 +-
 tools/testing/selftests/kvm/memslot_perf_test.c    |  2 +-
 .../selftests/kvm/s390/shared_zeropage_test.c      |  3 +-
 tools/testing/selftests/kvm/s390/tprot.c           |  2 +-
 .../testing/selftests/kvm/set_memory_region_test.c |  2 +-
 14 files changed, 79 insertions(+), 20 deletions(-)
