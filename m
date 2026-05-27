Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA274261B8D
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 01:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779846653; cv=none; b=ILuINS+Vi9EtHXEZ2Aa+IWa/fuCHbnS1RGvs5BejWW7vLMXOhIT8MNVmDTPB4K9fSiCz+9rpjNIY3n5twDvgNePq6ghwhsDFWpidXJU3tTFYJIwlwymzNaT8E2CpT963sHHGmNWvrPvnbzVQm4Knj9ANnyA0Dfp3UgBUHRwEIhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779846653; c=relaxed/simple;
	bh=ki/gxiZYZub9xazWB55VaDVU3bZ5cBZaL6cRuDPtHHI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=epedbSnlV6Pfrx2tY0brE0Z5o05SKAR9OLTj10K7iOFKeyuNv8FzjIwXTk485kfbaU3I1ZEbgXr7Dr+8wS41dV/97bYZ1ZmxBFwHZnePNIkK6rtQk6NMbbwXCKiuGqcCmTC7lwhdP1AJGEV0UVz9FKo7UOAxcxTAD+0l9aGhlpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mlYopmfO; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mlYopmfO"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ba718173d1so55294545ad.0
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 18:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779846651; x=1780451451; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Msrxdm0Rr8l3IMqE+WMM2XKwVpsHEdYxDxNioIAQtrw=;
        b=mlYopmfO6Z9sJf03T5GrffVkKIV3OCU2058MWwNtkJoBrfUklY+DblOd5jLE1pbW0a
         XqI7ir5ZNUdWA66eNsKhqNpN/gjg/clXyMArOwdnw7voO+UP5Szlc10sPbBDtIbenoZv
         ufkFWl1XehC/xPdICdo3CTjG5ozzdipX2hAMpLvVsbgUX09DZI/x1xSjd8Ai2EmtB1/Z
         7+lvTQDpGT7i47lO1rMnrqDvHG3h8ZUCe6BQPQrfYgBKLFHu8an6oE6Tm3j3JU7z8oO0
         2252Jlg1C+DgSYFfeHjGNp/hVLu/LzhwJwmJwQx4kVEW87d32p4rIyHxdZTIYXFdZl22
         d1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779846651; x=1780451451;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Msrxdm0Rr8l3IMqE+WMM2XKwVpsHEdYxDxNioIAQtrw=;
        b=cZL/ufjbwNDo0RKD0C8C5Vwr5sWUi864e3MYwglCWY2zswPFQV9T4cqyPJ2XiBmXAb
         p1C7fYS6fSz/9taET8lt6FtFYJHWQbeijrbsEMsBeVPjq30wOgbKpePpduizXYJK5drV
         W0F0IKTsztdGefIbZXJkYVyES4rC6To2a6Y4UUmNr+1GppG7KwYbSdPmDpfjxouf6RL0
         49gQO8FLO5leylDvRc6/ESQFYjROyDsFtT0kYTQOzWdR9IAr5o0rlqjrsDypJJSYsd3X
         U6AiMCN3EC7FOJbATedhUSbTIx4vu84lPlWcWHTDHPLe8/wXw1OS8sBMgFX2kqJvoFSs
         /sWA==
X-Forwarded-Encrypted: i=1; AFNElJ+Zn48oN6CJ0Ue0aHJ0BTdahmnKt2GIainW/V/nNyG6fJyubJ16oJtU7hEh2CdRXJKEdJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzYH3hdX6wa0X4fcndkQn7y9qLI+4xwLKq5m9yFbf+cFBjXTZX
	bX2KFKt7i6PnelnqWcvrY8hE4gfTNuBrFeh4XuINudKZdy3JmTeQeUW5JiiCeaLDlmtQHxHePsc
	M05Fmmg==
X-Received: from pgjp8.prod.google.com ([2002:a63:e648:0:b0:c82:7805:9e3d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f06:b0:2bd:c925:3a16
 with SMTP id d9443c01a7336-2beb039078amr250570575ad.2.1779846650895; Tue, 26
 May 2026 18:50:50 -0700 (PDT)
Date: Tue, 26 May 2026 18:50:50 -0700
In-Reply-To: <20260421231557.1254270-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260421231557.1254270-1-jrhilke@google.com>
Message-ID: <ahZN-sGaveY2_JDY@google.com>
Subject: Re: [PATCH v3 00/16] KVM: selftests: Link with VFIO selftests lib and
 test device interrupts
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 21, 2026, Josh Hilke wrote:
> v3:
> - Split monolithic test patch into smaller, logical patches (Sean).

Needs to go farther.  E.g. "KVM: selftests: Verify vCPU migration during IRQ delivery"
should be ~4 patches:

 1. Add gettid() wrapper (because what you proposed doesn't compile for me).
 2. Add sched_getaffinity() wrapper *AND* convert existing users.
 3. Add pin_task_to_random_cpu()
 4. Implement IRQ bypass vCPU migration

Maybe combine #3 and #4?  Adding helpers/APIs without users isn't ideal, but
pin_task_to_random_cpu() is interesting enough that I think it's worth isolating
in this case.

> David Matlack (13):
>   KVM: selftests: Build and link sefltests/vfio/lib into KVM selftests
>   KVM: selftests: Add /proc/interrupts parsing helpers
>   KVM: selftests: Add guest read/write macros
>   KVM: selftests: Add IRQ injection test
>   KVM: selftests: Verify device IRQs are routed to vCPUs
>   KVM: selftests: Verify IRQ affinity changes
>   KVM: selftests: Verify IRQs wake up halted vCPUs
>   KVM: selftests: Verify dynamic IRQ routing updates
>   KVM: selftests: Configure number of IRQs
>   KVM: selftests: Verify non-postable IRQ remapping
>   KVM: selftests: Verify vCPU migration during IRQ delivery
>   KVM: selftests: Configure number of vCPUs
>   KVM: selftests: Add xAPIC support

All of these shortlogs need more context.  E.g. "Add xAPIC support" suggests the
patch adds xAPIC support to _all_ of selftests.  We generally discourage trying
to set the scope to a specific test, because it inevitably falls apart, but it's
easy enough to "manually" call out the relevant test.

  KVM: selftests: Add xAPIC support to the IRQ bypass test

> Josh Hilke (3):
>   KVM: selftests: Rename guest_rng to kvm_rng
>   KVM: selftests: Add helper to generate random u64 in range [min,max]
>   KVM: selftests: Print vCPU affinity on timeout
> 
>  tools/testing/selftests/kvm/Makefile.kvm      |   7 +-
>  .../selftests/kvm/dirty_log_perf_test.c       |   4 +-
>  tools/testing/selftests/kvm/dirty_log_test.c  |   8 +-
>  .../selftests/kvm/include/kvm_syscalls.h      |   6 +
>  .../testing/selftests/kvm/include/kvm_util.h  |  13 +
>  .../testing/selftests/kvm/include/proc_util.h |  28 ++
>  .../testing/selftests/kvm/include/test_util.h |  26 +-
>  .../selftests/kvm/include/x86/kvm_util_arch.h |   4 +-
>  tools/testing/selftests/kvm/irq_test.c        | 367 ++++++++++++++++++
>  tools/testing/selftests/kvm/lib/kvm_util.c    |  88 ++++-
>  tools/testing/selftests/kvm/lib/memstress.c   |   8 +-
>  tools/testing/selftests/kvm/lib/proc_util.c   |  62 +++
>  tools/testing/selftests/kvm/lib/test_util.c   |  22 +-
>  tools/testing/selftests/kvm/mmu_stress_test.c |   9 +-
>  tools/testing/selftests/kvm/steal_time.c      |  21 +-
>  15 files changed, 615 insertions(+), 58 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/include/proc_util.h
>  create mode 100644 tools/testing/selftests/kvm/irq_test.c
>  create mode 100644 tools/testing/selftests/kvm/lib/proc_util.c
> 
> -- 
> 2.54.0.rc2.533.g4f5dca5207-goog
> 
