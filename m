Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2133421898
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079749; cv=none; b=g1/FYzs/Z6ZYrNfA1nHQBgrdhJHPYg8e3E+HsXmsD+gGAicUL8JOVbrt1j7aycoFIkPJjLMzvfedfq+vZDPoh7IOqGsi2JqkaqrqD4o6CEdY1wBewtZesFYzbti+ihuaNnC0GviAVJBZ8egwojrop1rhjMMQtS7AdClPW56X9BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079749; c=relaxed/simple;
	bh=ECKj85KBXweVrlxemVKDsoEUnlI209fGLg5cW8/Qrng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sdA7gFibc13h7blmpvXaZxQ4FbShZnpS3puO+9JtNw5H/Jk/aMt4fAJ3aD966tbZP7cK69bHZDSfJRVkgsT1q6ahrQFwLNqulMyGB9FsCw1xICI4kFRIYxzgJRSeK07y02wUfXs64RjG5LBJOJtrE6+WRSr8n3zpFKA5hEBaMdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HsDbBrYZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ae6NOcA+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HsDbBrYZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ae6NOcA+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780079743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0BolKR35Ek8zsZgxAkw2SQXeJKfRVoRKuOu5Xak9e4o=;
	b=HsDbBrYZf5qgj7UJy8IE6+My2IaDmcH9G0c5Bd0x3Azx9J7vGDtaTUkbFSSS7KvPXPAsmx
	WfOnbItWejEAlCtzJhkhIktsxmsj86BPYkuA+byGlQTkaprqg2vnruzDrIEItMBsgQtOze
	CVqGT/H/7CYznvyF3deZKOev+CSM760=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-4-AgeG-4MOGh5ad9fQzcXA-1; Fri, 29 May 2026 14:35:41 -0400
X-MC-Unique: 4-AgeG-4MOGh5ad9fQzcXA-1
X-Mimecast-MFC-AGG-ID: 4-AgeG-4MOGh5ad9fQzcXA_1780079741
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4909deb82d0so6961295e9.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780079740; x=1780684540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0BolKR35Ek8zsZgxAkw2SQXeJKfRVoRKuOu5Xak9e4o=;
        b=ae6NOcA+Pm4cci3NWRiQJzhxNaoDT1/ZsRYQgI2b8ZYxSNrrHdOGjJxD0OD0Itr7WA
         i1eKBjmiZxL1YekE4nQAnN0IoxafMb5cLzt6XDEDy4miBcRDIHcHrDSo1lQ1SLAdZrPn
         Xsz5bKJSSGZF4QrjUGqejRz3/tDURtbPsJCAYmACTvQOnpnsgFFI0/rb9Oc3/7a57Ikc
         gsZtWsNRiAkscJDW88Th30PAAbd9cwNSUrpedU7qWmEDRI6VyNzhZN97602Xq4XlMps6
         Mok8bwS6LSbGfa/N4i0jGHlBPRYu89alZgkesLidvm+Cp3ggx7+vRZmi0HnA8T8HqPsW
         3uRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079740; x=1780684540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BolKR35Ek8zsZgxAkw2SQXeJKfRVoRKuOu5Xak9e4o=;
        b=r8I8TL5HzWqryJptda3gIa/nGwOG+ChZzuZv5Ja2duQ2m89LICSy21IOkIBdmm/8z4
         w2/zL/OdcHEnyuWijr6OsZ3PVx+u2e/iAnSk5W+z6ge5GanIae8nShuttbJyrnnHi6T3
         paaM9Y5Z1RsgDy7/bSwx2+Xdd+yXsJszcxdxQZHPsf0JMfZD1zPCxG99EoE9yRLp8mWK
         urhN0Vp18RA0DHcSeGLXsjYqq3jpg4pyJDv9LoYsHnK1TTHqjx5mlXjmI3YTQaEfKkvr
         Y36awvyv2g3Y4hKznwA55HLtB7rlS5pw/EkBBkpwR2NPTYxyu0S8Vb0N+KFwSJLYqQ76
         CAkA==
X-Forwarded-Encrypted: i=1; AFNElJ+oj/T3cheir+v+A7NMTCBTxvvdLcwFgiUZg9YZvbRbm7gMAihGauh2P+bSyZma4MnQIjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnMEDsQNR78IPtkpRaGKDnbDDTar0Ra0O6cZ+GHEjktO5P2RnD
	NdP1clqW7/qIMhMFPgkiNIhjJMjUsKlqYUKimPKde15bxJVara0QnAUWm+xW5Um0KawW+wuWzMN
	C6WvfJci6HS9lRuSe9S/zEoZjgz5f3attBCYX5UY+xquCYPCummURQQ==
X-Gm-Gg: Acq92OHi7vL0izN2NXsdk5YBoEd48hhH3YB6KU6GbgvMKt5PNLas/S42qoXd6YMpmKN
	3eTMqa52m5Af01YzS6VUWjaCj5Qw0i4y/bkLU/ejRZrzOEjVSH7SaFqae+JEtse3gCID4PfKzyk
	4PQMu5jXKF9mBu3ldN1aTz6xVHhscawRFK+TAtT/OOnAF/o+hKEbv9BVRfEhiObRDXit3WigOik
	TxbJW7OXgJPoRxq+lb4qsgCTYGodoW5ifJnQvq5TYupX5Ic/M6+2eLLr+xTwNQ4yrvl/Pf4FFTq
	cMmLR6pkdwIIEJ/EvCMFZjY7o370Eu9ErZmeOJtJvJMxHOrnvvv26HPLy8k7u1Asegtm+BE9Je5
	Kh8ZDOs2GLvUI8dz6dVXaP6kbV82I4T/VLkulBtvDcELKsaJbDsZJ2KSWT3yb68u/7KHLMdU0+y
	hLKGtyzwEEml5Ou5cXu0+NkrBr/cRlyaKo7XcOTg==
X-Received: by 2002:a05:600c:c4a4:b0:490:6e12:a40f with SMTP id 5b1f17b1804b1-490a291cce1mr13460405e9.12.1780079740481;
        Fri, 29 May 2026 11:35:40 -0700 (PDT)
X-Received: by 2002:a05:600c:c4a4:b0:490:6e12:a40f with SMTP id 5b1f17b1804b1-490a291cce1mr13460005e9.12.1780079739993;
        Fri, 29 May 2026 11:35:39 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef358c07bsm5468963f8f.36.2026.05.29.11.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:35:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	seanjc@google.com,
	Marc Zyngier <maz@kernel.org>
Subject: [GIT PULL] KVM changes for Linux 7.1-rc6
Date: Fri, 29 May 2026 20:35:38 +0200
Message-ID: <20260529183538.1104584-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit e7ae89a0c97ce2b68b0983cd01eda67cf373517d:

  Linux 7.1-rc5 (2026-05-24 13:48:06 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to 713074d53be5c8684cb31fa7a8f09ffb679338d9:

  Merge commit 'kvm-psc-for-7.1' into HEAD (2026-05-29 20:25:59 +0200)

Long weekend here, so I'm not sending it on Sunday...

Thanks,

Paolo
----------------------------------------------------------------
Arm:

- Restore CONFIG_PKVM_DISABLE_STAGE2_ON_PANIC to its former glory by
  making sure the config symbol is correctly spelled out in the code

- Don't reset the AArch32 view of the PMU counters to zero when the
  guest is writing to them

- Fix an assorted collection of memory leaks in the newly added tracing
  code

- Fix the capping of ZCR_EL2 which could be used in an unsanitised way
  by an L2 guest

x86:

- Include the kernel's linux/mman.h in KVM selftests to ensure MADV_COLLAPSE
  is defined, as older libc versions may not provide it.

- Include execinfo.h if and only if KVM selftests are building against glibc,
  and provide a test_dump_stack() for non-glibc builds.

- Silence an annoying RCU splat on (even non-KVM-related) panics.  The splat
  is technically legit, but in practice not an issue.  To have a race, you
  would need to unload the KVM modules at exactly the time a panic happens;
  and speaking of incredibly rare races, taking the locks risks introducing
  a deadlock if the module unload code took the lock on a CPU that has been
  halted.  Which seems possibly more likely than the RCU grace period issue,
  so just shut it up.  This code used to be in KVM but is now outside it;
  but the x86 maintainers haven't picked it up, so here we are.

- Rate-limit global clock updates once again (but without delayed work), as
  KVM was subtly relying on the old rate-limiting for NPT correction to guard
  against "update storms" when running without a master clock on systems with
  overcommitted CPUs.

- Fix a brown paper bag goof where KVM checked if ERAPS is "dirty" instead of
  marking it dirty when emulating INVPCID.

- Flush the TLB when transitioning from xAVIC => x2AVIC to ensure the CPU TLB
  doesn't contain AVIC-tagged entries for the APIC base GPA.

- The top 10 commits fix buffer overflow (and potential TOC/TOU) flaws in the
  page state change protocol for encrypted VMs.  AI models find it quite
  easily given it was reported three times, but aren't as good at writing
  a comprehensive fix.  There's more to clean up in the area, which will
  come in 7.2.

----------------------------------------------------------------
Emily Ehlert (1):
      KVM: x86: Fix ERAPS RAP clear on INVPCID single-context invalidation

Hisam Mehboob (1):
      KVM: selftests: Guard execinfo.h inclusion for non-glibc builds

Lei Chen (1):
      KVM: x86: Rate-limit global clock updates on vCPU load

Mark Brown (1):
      KVM: arm64: Correctly cap ZCR_EL2 provided by a guest hypervisor

Michael Roth (1):
      KVM: SEV: Require in-GHCB scratch area if GHCB v2+ is in use

Mikhail Gavrilov (1):
      x86/virt: Silence RCU lockdep splat in emergency virt callback path

Paolo Bonzini (3):
      Merge tag 'kvm-x86-fixes-7.1-rc6' of https://github.com/kvm-x86/linux into HEAD
      Merge tag 'kvmarm-fixes-7.1-4' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD
      Merge commit 'kvm-psc-for-7.1' into HEAD

Qiang Ma (1):
      KVM: arm64: PMU: Preserve AArch32 counter low bits

Sean Christopherson (11):
      KVM: selftests: Include sys/mman.h *and* linux/mman.h, via kvm_syscalls.h
      KVM: SVM: Flush the current TLB when transitioning from xAVIC => x2AVIC
      KVM: SEV: Ignore MMIO requests of length '0'
      KVM: SEV: Reject MMIO requests larger than 8 bytes with GHCB v2+
      KVM: SEV: Ignore Port I/O requests of length '0'
      KVM: SEV: Use the size of the PSC header as the minimum size for PSC requests
      KVM: SEV: Compute the correct max length of the in-GHCB scratch area
      KVM: SEV: WARN if KVM attempts to setup scratch area with min_len==0
      KVM: SEV: Don't explicitly pass PSC buffer to snp_begin_psc()
      KVM: SEV: Check PSC request indices against the actual size of the buffer
      KVM: SEV: Use READ_ONCE() when reading entries/indices from PSC buffer

Vincent Donnefort (4):
      KVM: arm64: Fix CONFIG_PKVM_DISABLE_STAGE2_ON_PANIC
      KVM: arm64: Fix meta-page unsharing in pKVM hyp tracing
      KVM: arm64: Fix rollback in hyp_trace_buffer_share_hyp()
      KVM: arm64: Fix memory leak in hyp_trace_unload()

 arch/arm64/include/asm/kvm_host.h                  |  2 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h            | 16 ++--
 arch/arm64/kvm/hyp/nvhe/host.S                     |  2 +-
 arch/arm64/kvm/hyp_trace.c                         |  9 ++-
 arch/arm64/kvm/nested.c                            |  5 ++
 arch/arm64/kvm/pmu-emul.c                          |  4 +-
 arch/arm64/kvm/sys_regs.c                          | 11 +--
 arch/x86/include/asm/kvm_host.h                    |  1 +
 arch/x86/kvm/svm/avic.c                            | 35 +++++++--
 arch/x86/kvm/svm/sev.c                             | 91 +++++++++++++++-------
 arch/x86/kvm/x86.c                                 | 13 +++-
 arch/x86/virt/hw.c                                 | 15 +++-
 .../selftests/kvm/access_tracking_perf_test.c      |  2 +-
 tools/testing/selftests/kvm/guest_memfd_test.c     |  2 +-
 tools/testing/selftests/kvm/include/kvm_syscalls.h | 10 +++
 tools/testing/selftests/kvm/include/test_util.h    |  2 +-
 tools/testing/selftests/kvm/lib/assert.c           |  8 +-
 tools/testing/selftests/kvm/lib/kvm_util.c         |  2 +-
 tools/testing/selftests/kvm/memslot_perf_test.c    |  2 +-
 .../selftests/kvm/s390/shared_zeropage_test.c      |  3 +-
 tools/testing/selftests/kvm/s390/tprot.c           |  2 +-
 .../testing/selftests/kvm/set_memory_region_test.c |  2 +-
 22 files changed, 172 insertions(+), 67 deletions(-)

