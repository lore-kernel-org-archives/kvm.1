Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427083191BB
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 00:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781225287; cv=none; b=LktcKD+LA8A+1y6nj/JV9eZEK9HYypQUm2LVRnXhuKRO1t+EmIvDBCe3RD9XxV3S0IE2oaTwXokRQC2gSG7Xs18Z3b1rEpkQe2c0bLBelE+YLC1Sf9ggesS32C3aPXOCsg+jGohgN7h/uZZdoiddtl/K//EzjtqUYHYvfP7jCa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781225287; c=relaxed/simple;
	bh=0UM/hrYV2ndB9arQ7qLqQesqEd5FCOaqbYNRlc4Qm7E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U/9orPnOEhkQKTvqIlqEhq0fCZ2ZiB2wKa/1bTg0yLbVZHv979z82SE+qVoR//lvUxJyPsxGnaLhCEBBLK+Hhl4Q/l7siQkIYhP6856mWaZvr0EN+ckYEROZbakiSjitZX3L1B+tyStRNCCHARnP4zj6rZIFusI33FdXVK2E/x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OMtcmCS8; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OMtcmCS8"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bf08c2a24bso3856845ad.2
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 17:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781225286; x=1781830086; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=cmldch0o2L0Btweda8M7jw709M8OKGUmWWEX4X6UIsc=;
        b=OMtcmCS8AfdOZkHUJUg4+wFIGFxQOoZmSkn+NYz/8z2pQIvLoxMNIkDDkENvBc9cmb
         Z7hO+PWvmYaWr/CMmicNkkXaZMC2os5Z9n0MyVCnVw5mItXJ6d/7MxFKT9QdH/u4NSR5
         wQJVl3eQE7GH0LjxDin4VpIwxTFbY72p4+VO1yYlez7gkMp8kL6XN4AjsuPscnFXdIWK
         4PJ/W+D5gedaMV+YFKtDCWPH/ITml4YQznayM/RFlA1XOCX4VUVhFp2H8/jaxKTpHZni
         BeWu1lCrmVVRC64ihNRZHjTmVkuXnVEnS6x5Kwaq4E0esjUaDNnhTiXkWeSldYlJG+4j
         AYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781225286; x=1781830086;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cmldch0o2L0Btweda8M7jw709M8OKGUmWWEX4X6UIsc=;
        b=OY019raa3EXRxVi06ZEgXBSuf6WFczwkUCmNYstrtKyGDZMnStaRHy1ZoULTuJHbKG
         wgTT4XfA28NpgDEjrJdQFHwGJ9U4D2iFua/OpEx2fg3vvaGlcUnpu+x6JDxn0//iBmOA
         hX6dtf2WSQ+mbs7KCn2UIJQAXr+7NAa0owR5eN/eQpP3OeBagIqiBdakRG1YWGD6c3YP
         0+PjrstbFOfiZUQe69meEI1tthXfsggy6jYH9hiFlllZquJOBis5To4oX7NE8PPyxw2c
         FQghQOa70eBX6NF3AsRZMBDefpVg9gK2ZzzhiomxwGOABzW6iT8/bN2eiw7Yk5ZtUWr7
         ZYrQ==
X-Gm-Message-State: AOJu0YzsXb6qn/OrOj4zoLx/zCfcvaid2MFPio+6+cZkpPXIV3RcLXBB
	jugsLBJG0Js+eFgBRX0lGMmzVsdZcUWy/tGUwxhf4E46DHGY4JLYUWNUscOx0wfjKb9R4KosWM0
	AW3BETA==
X-Received: from pgbl17.prod.google.com ([2002:a63:5711:0:b0:c85:b968:afa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:190:b0:2c2:9254:4c22
 with SMTP id d9443c01a7336-2c411c7aa58mr8192965ad.17.1781225285538; Thu, 11
 Jun 2026 17:48:05 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 11 Jun 2026 17:47:50 -0700
In-Reply-To: <20260612004755.349925-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612004755.349925-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612004755.349925-6-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: Selftests changes for 7.2
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Pretty much everything here is a one-off fix/cleanup of some kind.

The following changes since commit b7fbe9a1bf9ee6c967ef77d366ca58c35fcf1887:

  Merge branch 'kvm-apx-prepare' into HEAD (2026-05-13 12:38:31 -0400)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-selftests-7.2

for you to fetch changes up to 5bd0387e3b56f7e0a81386f6d0a5fa2c3a92ad5d:

  KVM: selftests: hyperv_features: test write of 1 to HV_X64_MSR_RESET (2026-05-26 12:30:50 -0700)

----------------------------------------------------------------
KVM selftests changes for 7.2

 - Randomize the dirty log test's delay when reaping the bitmap on the first
   pass, as always waiting only 1ms hid a KVM RISC-V bug as the test reaped the
   bitmap before KVM could build up enough state to hit the bug.

 - A pile of one-off fixes and cleanups.

----------------------------------------------------------------
Mayuresh Chitale (1):
      KVM: selftests: memslot_perf_test: make host wait timeout configurable

Piotr Zarycki (4):
      KVM: selftests: sync_regs_test: drop stale TODO comment
      KVM: selftests: Fix typo in comment in hyperv_features.c
      KVM: selftests: hyperv_tlb_flush: replace NOP loop with udelay()
      KVM: selftests: hyperv_features: test write of 1 to HV_X64_MSR_RESET

Sean Christopherson (3):
      KVM: selftests: Cast guest_memfd fd to a signed int when checking for >= 0
      KVM: selftests: Add and use kvm_free_fd() to harden against fd goofs
      KVM: selftests: Randomize dirty_log_test's delay before reaping the bitmap

Zongyao Chen (1):
      KVM: selftests: Fix vcpu_get_stats_fd() ioctl name

 tools/testing/selftests/kvm/dirty_log_test.c       | 26 +++++++++++++++++-----
 tools/testing/selftests/kvm/include/kvm_syscalls.h |  6 +++++
 tools/testing/selftests/kvm/include/kvm_util.h     |  2 +-
 tools/testing/selftests/kvm/lib/kvm_util.c         | 25 ++++++++++-----------
 tools/testing/selftests/kvm/memslot_perf_test.c    | 12 +++++++---
 tools/testing/selftests/kvm/x86/hyperv_features.c  | 21 ++++++++++-------
 tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c | 15 ++-----------
 tools/testing/selftests/kvm/x86/sync_regs_test.c   |  1 -
 8 files changed, 63 insertions(+), 45 deletions(-)
