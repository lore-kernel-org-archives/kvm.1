Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B9235DA61
	for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776956625; cv=none; b=RmU+pDyKsgtWYaTUWJJxo2oTS8KfFkLkcKQrjE/m+aJGP6qDm74aZTvdqeoPpMR8M1iGAlohEuUo2BI0Tu3OMBRFdVqc7MegH4inFg34y3GgymPQKOVd5V3PaRlE0GrgZpVHdNcRmDWDn49wOgXltQ/QMzokhUk0bAf8OFeP2+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776956625; c=relaxed/simple;
	bh=QuHONC0oCTMsOm/45B+kCQ5TmC0Dwx9mfLRuWxNqb64=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=vAmF3GnnbI1KNo5vRdNNgxkKfL1VH2XuSHgnSpouvzfEvCyhUn6vHAihiQqGdLSeiD83raBWDAk3xBtVEqKwhzJ5OaHtYn0pqGOStfFVg7StBShbs4h2dmdcCrotN1xU2WjDWIBVa81FseUuvvhPcwAd/VK6gw3fpikwYZfZMWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QuodZLV+; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QuodZLV+"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b242b9359aso67455395ad.0
        for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 08:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776956623; x=1777561423; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aVNdbZY6gPHblksJdv4qLfol36lefvazlc9OiWddT8c=;
        b=QuodZLV+CPUC8Uh7N91ANW2JZu6m91qiCEeK1kcgSsZrRRhvQiZVIBspjiTr875s3G
         5p/C/EsRwisDN8pQxDJuhJUfQI12N1tQaqhEeT1kA3ZUKiL14mYUIodTLOsPgPDTt8uO
         9KQb+OLg/gbiVbur5JhLlcdw1/pdfP/e3+lPlr0r4zno6YPPOIe4thM5jORI0j+XHXtK
         2RUAooxBoR7d99gady8B0mQa1n3UfmbN3MpPFjj5RX2L5LunyRVsF/E0KhlPDmqyiWNu
         xzqN7e0hRFE2rciKLjpvP7jCmF39XDssphU6YVq59b7fHLADU1/Zxz7N6uR69yJgvT1u
         Y/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776956623; x=1777561423;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aVNdbZY6gPHblksJdv4qLfol36lefvazlc9OiWddT8c=;
        b=n5y/he/8ay86oRpNzEgizmNr4Fde5dJwb7LC0kUznOm8VMJr7s7h1vUpqC8LxtgrGc
         0gQ9lZHuYzE0NbKbVjhXH57Qcn1ehX1kv9hIct2nJVh61lVzB5RvurlfDfrAQeaf5oUo
         t8IWUnt/WZE2ehzYBD6qDBL3xqE/Q3ZMnT5+4TRYck8/Wc/QLFw4uZCYSOfR3ACiG1XG
         Vre0Sz8lXu2XD6lkg8FPIYQ5Ds/zgJ33RHW+rkS1sU1vnStQJBEQObNr4ulI6oQmAY0H
         U1p6a14vbN25T11ACH1w8KFdnFBGSEcZmX1yZn1dsSUyWDp3CZpBDvc5emIBQciWIned
         jpiA==
X-Forwarded-Encrypted: i=1; AFNElJ9CxG26KjE04RG4aAF5Rbi264m+c6tcxg7zSMOxCtwdnhx19x9ZkB5HPPBVnKmVV7wDBYY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1ln1GrpzXJ5Tv3n3kwKxlvNtAr9DjsN5oW4nxstjyG0vpY/la
	ndnj34F+yqc686yvEfDvV9mkdEYqV61PxA1U888eOioUUV4gJSgIXy4NsVPKBP55fXnFqQSPdlq
	z9GuHJQ==
X-Received: from plbjw13.prod.google.com ([2002:a17:903:278d:b0:2ae:c50f:f4ec])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3b88:b0:2b2:ec31:25be
 with SMTP id d9443c01a7336-2b5f9f35acamr269259895ad.24.1776956623001; Thu, 23
 Apr 2026 08:03:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 23 Apr 2026 08:03:36 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260423150340.463896-1-seanjc@google.com>
Subject: [PATCH v2 0/4] perf/x86: Don't write PEBS_ENABLED on KVM transitions
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	Mingwei Zhang <mizhang@google.com>, Stephane Eranian <eranian@google.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Rework the handling of PEBS_ENABLED (and related PEBS MSRs) to *never* touch
PEBS_ENABLED if the CPU provides PEBS isolation, in which case disabling
counters via PERF_GLOBAL_CTRL is sufficient to prevent generation of unwanted
PEBS records.  For vCPUs without PEBS enabled, this saves upwards of 7 MSR
writes on each roundtrip between the guest and host (KVM performs an immediate
WRMSR to zero out PEBS_ENABLED if it's in the load list).  For vCPUS with PEBS,
this saves 3 MSR writes per roundtrip.

However, performance isn't the underlying motiviation.  We (more accurately,
Jim, Mingwei, and Stephane) have been chasing issues where PEBS_ENABLED bits
can get "stuck" in a '1' state when running KVM guests while profiling the host
with PEBS events.  The working theory is that perf throttles PEBS events in
NMI context, and thus clears bits in cpuc->pebs_enabled and PEBS_ENABLED, after
generating the list of PMU MSRs to context switch but before VM-Entry.  And so
when the host's PEBS_ENABLED is loaded on VM-Exit, the CPU ends up with a
stale PEBS_ENABLED that doesn't get reset until something triggers an explicit
reload in perf.

Testing this against our "PEBS_ENABLED is stuck" reproducer is (still) a work
in-progress (largely because the "reproducer" is currently "throw the kernel in
a big test pool"), i.e. I don't know if this actually resolves the problems we
are seeing.  But even if it doesn't fully resolve our woes, it seems like a
no-brainer improvement, and if we're missing something with respect to "stuck"
PEBS_ENABLED, it'd be nice to get feedback/input asap.

Note, if the throttling theory is correct (which is looking unlikely at the
moment), then there are likely more fixes that need to be done, e.g. for CPUs
without isolation, and/or if PERF_GLOBAL_CTRL can be modified from NMI context
too.

Patch 4 is a clean up that I posted as a standalone patch almost a year ago.
I included it here because it's very related, and because I needed to refresh
it anyways.

v2:
 - "Load" the host value for the guest when an MSR should remain unchanged,
    instead of omitting the MSR from the list entirely, as KVM may need to
    _remove_ the MSR from the list. [Sashiko, Jim]
 - Collect Jim's reviews. [Jim]
 - Call out that the bug being fixed is theoretical at this point.
 - Dropping PEBS_ENABLED from the lists save three MSR writes, not two, as
   KVM performs an explicit WRMSR prior to VM-Entry to guarantee PEBS is
   quiesced.

v1: https://lore.kernel.org/all/20260414191425.2697918-1-seanjc@google.com

Sean Christopherson (4):
  perf/x86/intel: Don't write PEBS_ENABLED on host<=>guest xfers if CPU
    has isolation
  perf/x86/intel: Don't context switch DS_AREA (and PEBS config) if PEBS
    is unused
  perf/x86/intel: Make @data a mandatory param for
    intel_guest_get_msrs()
  perf/x86: KVM: Have perf define a dedicated struct for getting guest
    PEBS data

 arch/x86/events/core.c            |  5 ++-
 arch/x86/events/intel/core.c      | 69 +++++++++++++++++++------------
 arch/x86/events/perf_event.h      |  3 +-
 arch/x86/include/asm/kvm_host.h   |  9 ----
 arch/x86/include/asm/perf_event.h | 12 +++++-
 arch/x86/kvm/vmx/pmu_intel.c      | 20 +++++++--
 arch/x86/kvm/vmx/vmx.c            | 11 +++--
 arch/x86/kvm/vmx/vmx.h            |  2 +-
 8 files changed, 82 insertions(+), 49 deletions(-)


base-commit: 6b802031877a995456c528095c41d1948546bf45
-- 
2.54.0.545.g6539524ca2-goog

