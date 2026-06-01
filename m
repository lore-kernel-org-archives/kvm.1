Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E832D364EA5
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 19:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780340871; cv=none; b=RZ4n83COTLGXNIMOZquLSON3uEPENoCDik3ktVBjvgf9qEXtSjZIexr25YDVuJTUSjCPAWowKVCogtmog6PgGzA5kZ5HP96YEa6XpN07QTvugPuZcpWygFhurhSTH0efq6lnlrMnR7JGDWPHZ/Ma1+u7Sl1JUjobKsR2eIbGdks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780340871; c=relaxed/simple;
	bh=Kelxc5oYGGF7Vhx4zYusKsP/GB4VVycmuA5b5+8D3Wg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jTgvtquPFnPzcFd/WvjbrgoZIKVkk+NZMvBRH8OAWqzyCydJ+T7pcBCy0oS3I7gZW4MJNjAImUT1/oNL/pTC+Kn78W6u+/Q+aWZIBZSEg0v3Mud4cHlU66y1X5xGygFm+Ru1A5onfZuFT0MNXHVvNItnoIlccKQ1CAaHqHCknss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MqgQzG1f; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MqgQzG1f"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36d99333358so1590446a91.3
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 12:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780340868; x=1780945668; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f9b3YM661qDhfKWEa4RmgtMK/vAOZvsXbfWzmrgUEpA=;
        b=MqgQzG1fQqW46ttMXZTxcbiM5uEpXhpRal42XPk3o4ZZICTVTYPTN3+JqO0K8Soxwv
         /8vbkAp/jl2gF2rBHAs+m3V2Ck+Oh/gUSe0NwEVSdjU+NVkm675QlTUcF1O51MRXuPRE
         Krt+xUOGjZodTFHa3xuFbGUj8TudB0WPtLbdt9hTD4ZlfsTfCWZHNU4koJ3lSoOYdaMc
         iSxie7FcDYXmlXFGFGxdK95vaCjZLESKN/4iCq9fVxC2iFuJ0p3UGrXbT4JbXsjk9fuh
         Eh0RnJGtog9X3cdO02GkPK8UATZATxCKnMZhFQVyEPN0NpEG4VqVNkSG2+tMB38wYJET
         23yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780340868; x=1780945668;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f9b3YM661qDhfKWEa4RmgtMK/vAOZvsXbfWzmrgUEpA=;
        b=FXcaOXRDjFdln9LRXHTpvDOokvLDIFHqV1TdpU7oAngH9QfYPTED1Wsq5tUOypacNZ
         TdUXrQoi5pRsG78+U4RhjrcqGXOWgNrppq1oAsRhahU4jDSohJIxB3JQ/PvF8/yPMFhi
         jfOpo8z/KPhbJdnEbdopvpcnew+OeJpWVWiLN//IrEVGkRQYij2PXSmNPt22oP7TLbNW
         5vXDO/CD3u9icidDpSLh+syevPvv7mbDNC9XcRCDQE712t4eIH7dxb91DTbeNfJ/3Rc7
         C+zdYbWI8SQVzdfJWfj7xJlKsSsKVaQrTXVAk/XAr0ABrfSmLtaykcWKxZzsYIomEybd
         dgYw==
X-Forwarded-Encrypted: i=1; AFNElJ86/GQb3knaYoIazA/tsgHgH6nuEfo39R/VGiATyYqhUK95ftmGJZ87jB6FQ36l6BgTefI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyapkxiwDE7LRNsSngCluqd2UOEuk9nKZlTYcWv3JpKL6rgY1/a
	RAEL3QPCR838dELQta48hmx9Akzx4uwF7YZWvG1+L/ZCkcSgyFtsNXHCqs+8eOojfB2EbG+mmPZ
	ygkIMNQ==
X-Received: from pjyt18.prod.google.com ([2002:a17:90a:e512:b0:36a:8554:a396])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:270d:b0:368:3d3e:efa6
 with SMTP id 98e67ed59e1d1-36c502165c6mr12161413a91.20.1780340868025; Mon, 01
 Jun 2026 12:07:48 -0700 (PDT)
Date: Mon, 1 Jun 2026 12:07:47 -0700
In-Reply-To: <20260530002134.558837-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260530002134.558837-1-jrhilke@google.com>
Message-ID: <ah3Yg8SJZrpdQ8e1@google.com>
Subject: Re: [PATCH v4 00/19] KVM: selftests: Link with VFIO selftests lib
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="us-ascii"

On Sat, May 30, 2026, Josh Hilke wrote:
> David Matlack (12):
>   KVM: selftests: Build and link selftests/vfio/lib into KVM selftests
>   KVM: selftests: Add /proc/interrupts parsing helpers for IRQ test
>   KVM: selftests: Add guest read/write macros
>   KVM: selftests: Add IRQ injection test
>   KVM: selftests: Verify IRQ bypass works in IRQ test
>   KVM: selftests: Verify interrupts are received when IRQ affinity
>     changes in IRQ test
>   KVM: selftests: Verify IRQs wake up halted vCPUs in IRQ test
>   KVM: selftests: Verify interrupts are received after modifying IRQ
>     routes in IRQ test
>   KVM: selftests: Make number of IRQs configurable in IRQ test
>   KVM: selftests: Verify non-postable IRQ remapping in IRQ test
>   KVM: selftests: Make number of vCPUs configurable in IRQ test
>   KVM: selftests: Add xAPIC support in IRQ test
> 
> Josh Hilke (7):
>   KVM: selftests: Rename guest_rng to kvm_rng
>   KVM: selftests: Add helper to generate random u64 in range [min,max]
>   KVM: selftests: Add kvm_gettid() wrapper and convert users
>   KVM: selftests: Add kvm_sched_getaffinity() wrapper and convert users
>   KVM: selftests: Add pin_task_to_random_cpu() helper function
>   KVM: selftests: Verify vCPU migration during IRQ delivery in IRQ test
>   KVM: selftests: Print vCPU affinity on timeout during IRQ test
> 
>  tools/testing/selftests/kvm/Makefile.kvm      |   8 +-
>  tools/testing/selftests/kvm/arch_timer.c      |   2 +-
>  .../kvm/arm64/arch_timer_edge_cases.c         |   2 +-
>  .../selftests/kvm/demand_paging_test.c        |   2 +-
>  .../selftests/kvm/dirty_log_perf_test.c       |   4 +-
>  tools/testing/selftests/kvm/dirty_log_test.c  |   8 +-
>  .../selftests/kvm/include/kvm_syscalls.h      |   6 +
>  .../testing/selftests/kvm/include/kvm_util.h  |  13 +
>  .../testing/selftests/kvm/include/proc_util.h |  28 ++
>  .../testing/selftests/kvm/include/test_util.h |  25 +-
>  .../selftests/kvm/include/x86/kvm_util_arch.h |   4 +-
>  tools/testing/selftests/kvm/irq_test.c        | 370 ++++++++++++++++++
>  tools/testing/selftests/kvm/lib/assert.c      |   8 +-
>  tools/testing/selftests/kvm/lib/kvm_util.c    |  95 ++++-
>  tools/testing/selftests/kvm/lib/memstress.c   |   8 +-
>  tools/testing/selftests/kvm/lib/proc_util.c   |  62 +++
>  tools/testing/selftests/kvm/lib/test_util.c   |  27 +-
>  tools/testing/selftests/kvm/mmu_stress_test.c |  15 +-
>  tools/testing/selftests/kvm/rseq_test.c       |   6 +-
>  tools/testing/selftests/kvm/steal_time.c      |  22 +-
>  20 files changed, 635 insertions(+), 80 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/include/proc_util.h
>  create mode 100644 tools/testing/selftests/kvm/irq_test.c
>  create mode 100644 tools/testing/selftests/kvm/lib/proc_util.c
> 
> -- 

Please read through Documentation/process/maintainer-kvm-x86.rst.  This isn't
strictly scoped to KVM x86, but at the same time it's pretty obvious who is going
to be applying this series.

Specifically:

  Git Base
  ~~~~~~~~
  If you are using git version 2.9.0 or later (Googlers, this is all of you!),
  use ``git format-patch`` with the ``--base`` flag to automatically include the
  base tree information in the generated patches.
  
  Note, ``--base=auto`` works as expected if and only if a branch's upstream is
  set to the base topic branch, e.g. it will do the wrong thing if your upstream
  is set to your personal repository for backup purposes.  An alternative "auto"
  solution is to derive the names of your development branches based on their
  KVM x86 topic, and feed that into ``--base``.  E.g. ``x86/pmu/my_branch_name``,
  and then write a small wrapper to extract ``pmu`` from the current branch name
  to yield ``--base=x/pmu``, where ``x`` is whatever name your repository uses to
  track the KVM x86 remote.

and to a lesser extent:

  Base Tree/Branch
  ~~~~~~~~~~~~~~~~
  Fixes that target the current release, a.k.a. mainline, should be based on
  ``git://git.kernel.org/pub/scm/virt/kvm/kvm.git master``.  Note, fixes do not
  automatically warrant inclusion in the current release.  There is no singular
  rule, but typically only fixes for bugs that are urgent, critical, and/or were
  introduced in the current release should target the current release.
  
  Everything else should be based on ``kvm-x86/next``, i.e. there is no need to
  select a specific topic branch as the base.  If there are conflicts and/or
  dependencies across topic branches, it is the maintainer's job to sort them
  out.
  
  The only exception to using ``kvm-x86/next`` as the base is if a patch/series
  is a multi-arch series, i.e. has non-trivial modifications to common KVM code
  and/or has more than superficial changes to other architectures' code.  Multi-
  arch patch/series should instead be based on a common, stable point in KVM's
  history, e.g. the release candidate upon which ``kvm-x86 next`` is based.  If
  you're unsure whether a patch/series is truly multi-arch, err on the side of
  caution and treat it as multi-arch, i.e. use a common base.

Through random guessing, I discovered that this appears to be based on 7.0. 
(a) I shouldn't have to guess.  (b) that's simply too old of a base, e.g. this
doesn't even apply clean only 7.1-rc1.

While there's room for interpretation in the "Base Tree/Branch" section, IMO
using any base older than 7.1-rc2 is blatantly wrong.  Any of 7.1-rc2+, kvm/next,
or kvm-x86/next would be acceptable (though fairly literal reading of the docs
would say "don't use kvm-x86/next").

> 2.54.0.929.g9b7fa37559-goog
> 
