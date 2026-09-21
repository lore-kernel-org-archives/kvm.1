Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78547511E6E
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 19:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018062; cv=none; b=mXC1UtTivueY88tSgf7PCpgOfrnzmZWh8M1mDATXm8vr7AhbXA/FYHxvBTF4OhJR1h2ab/G9j0qmZ6JuopfriP5MNt28qqGW5+kw3OXDRVt8RGtypzaa+7iiLTXrZOQeZEtMvO/pbxXtnzPaLAjBQxtujyzLHKIR09pKc+2FbFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018062; c=relaxed/simple;
	bh=JW0YYFQE890DJQB8oPq2vjyvyL+zfa0BcpboMaOJw+4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Tikq402lGFzvvuPgRr2kNUsBMPW0MLixYFlqTIk1XvNRKY7FTxNEjL0tBKJfeIJ92pK0G/iQKmSz0jz+ltVMqPoymjr2n8TueA55a1BPwlbEok9NJe13N9FTgW7NvXbLF8l1A/FmT+IqlcTcjziXkFTc4prEV/TgxqH4gms1rYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dYU0LNLx; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dYU0LNLx"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8710450f731so3289186b3a.0
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 12:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790018060; x=1790622860; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pkZ5AtpgCiUILERO4j3rx1qGtjIN9Gb1Wx6aPlS30B8=;
        b=dYU0LNLxxFwjrzObYs1JBnz5e22XwmUcr9eioM3Dn/MKHOi89FFS++i1eBoFsk+y0o
         SiSWWqHOokRhBJqXXAqta5ozSO5vQ2pVYpJgKVqNbPtLJd0Rsmy23uSsSfCI5SiOG8Vq
         jUXhF5oOewNm/3IY24gvwvPGpy6J5b17L76XK4/aDkAUWONXWko96wuTath7gw208FiH
         DqOpKM1MWJNhGiXbnQP4zo0bZJiBJa2uaqCL3FQsZSh5bMLtLH12rv5l3dRufa71IdZy
         KfMJp1eY9m7CZEehszzgCX4BvBfPaToMHDgRF0XAOqgHavzxFBXdeifVKXHmMqQCBiaY
         MZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790018060; x=1790622860;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pkZ5AtpgCiUILERO4j3rx1qGtjIN9Gb1Wx6aPlS30B8=;
        b=PEClMzEYdhRdNg5VxYLriE0E0yoi7jtKF4EAnhHCkMfVjoU/qFxW8LKbfu4C68b2DW
         f5N5RxrIzUhUnYrwwfK44U0OWyAHIt28GmsoqRCc/KIJ7e+//8mmwBV2u0kIvSY0UZ+/
         39D7BVCrjfQpoawCh2ruhYdtpaR3MLpH8jFoqD+BU50Oj4a1yu7f7enQy28HkcP4xtJP
         a0j34kd0oVM3a+X2rf8JuycaG5pKKdF36E8HmQGkKVqqT1EdYOSie+eGGqIZidEIL4wd
         JAZ0s1zA8KTSQp66rW1HOgukub43eR2GoQ6qE93n+/lY6jE1DUzH6YQ+CUleIWlag8dR
         QTCA==
X-Forwarded-Encrypted: i=1; AKwUvBxBZd2EThdhJEL+SJRiHAOo4BlvWT3H1qABRlB/MU/ymk7NuO3sOOmJWdYOZaZH5J3dCag=@vger.kernel.org
X-Gm-Message-State: AFuF++lOVd2PDbwUxKZN+7Y3xhHaegxUxOhM2qML6N8m2224RKAkL49h
	Z+YE62quJpClMq91pykOYpOtgfpiJUWXRH4AYCPYqDj3eZxAZ0jlU/lzdYhxSCRYBMW9RX1VSek
	Sv1iQsg==
X-Received: from pfjc30.prod.google.com ([2002:a05:6a00:9e:b0:874:d75f:2b89])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1f06:b0:857:727c:a1f1
 with SMTP id d2e1a72fcca58-874dddfa3acmr14699783b3a.19.1790018059590; Mon, 21
 Sep 2026 12:14:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 12:14:08 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921191418.950933-1-seanjc@google.com>
Subject: [PATCH v4 00/10] perf/x86: Don't write PEBS_ENABLED on KVM transitions
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Jim Mattson <jmattson@google.com>, 
	Mingwei Zhang <mizhang@google.com>, Stephane Eranian <eranian@google.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Rework the handling of PEBS_ENABLED (and related PEBS MSRs) to *never* touch
PEBS_ENABLED if the CPU provides PEBS isolation, in which case disabling
counters via PERF_GLOBAL_CTRL is sufficient to prevent generation of unwanted
PEBS records.  For vCPUs without PEBS enabled, this saves upwards of 7 MSR
writes on each roundtrip between the guest and host (KVM performs an immediate
WRMSR to zero out PEBS_ENABLED if it's in the load list).  For vCPUS with PEBS,
this saves 3 MSR writes per roundtrip.

E.g. without PEBS activity in the host, for a guest with a vPMU, this reduces
the roundtrip time for a fastpath exit from ~1120 => ~860 cycles on EMR.  With
host PEBS active, the reduction is ~1450 => ~900 cycles.

However, performance isn't the underlying motiviation (well, at least, it
didn't start that way).  Jim, Mingwei, and Stephane have been chasing issues
where PEBS_ENABLED bits can get "stuck" in a '1' state when running KVM guests
while profiling the host with PEBS events.  The working theory is that perf
throttles PEBS events in NMI context, and thus clears bits in cpuc->pebs_enabled
and PEBS_ENABLED, after generating the list of PMU MSRs to context switch but
before VM-Entry.  And so when the host's PEBS_ENABLED is loaded on VM-Exit, the
CPU ends up with a stale PEBS_ENABLED that doesn't get reset until something
triggers an explicit reload in perf.

Note, as Peter pointed out, more than likely KVM needs to zero PERF_GLOBAL_CTRL
before invoking perf_guest_get_msrs(), as that's the only way to guarantee
stable output.  I deliberately didn't include that here, as I want to keep this
series focused on PEBS.  I also wanted to let Jim and company bottom out on
their investigation (still ongoing) before pursuing fixes that we'll probably
want to send to stable@.

v4:
 - Collect reviews. [Dapeng, Jim]
 - Clarify that patch 1 is a fix, albeit for something that can't happen in the
   current code base (I missed that intel_ctrl contains only a mask of PMCs,
   whereas PEBS_ENABLE has additional "modifier" bits). [Sashiko]
 - Tack on a patch to filter out non-counter PEBS_ENABLE bits when checking to
   see if the host is actually using PEBS. [Sashiko, Dapeng]

v3:
 - https://lore.kernel.org/all/20260508231353.406465-1-seanjc@google.com
 - Ensure guest PEBS_ENABLE is a subset of intel_ctrl. [Jim]
 - Rename intel_ctrl_{guest,host}_mask to be less confusing. [Jim]
 - Do even more cleanup of the cross-mapped handling, and specifically avoid
   overhead when PEBS isn't in use. [Sashiko]
 - Leave behind a FIXME regarding the "disable guest PEBS if host is using
   PEBS" code.  I still don't know for sure why that restriction is in place,
   and I'm too scared too change it. :-)

v2:
 - https://lore.kernel.org/all/20260423150340.463896-1-seanjc@google.com
 - "Load" the host value for the guest when an MSR should remain unchanged,
    instead of omitting the MSR from the list entirely, as KVM may need to
    _remove_ the MSR from the list. [Sashiko, Jim]
 - Collect Jim's reviews. [Jim]
 - Call out that the bug being fixed is theoretical at this point.
 - Dropping PEBS_ENABLED from the lists save three MSR writes, not two, as
   KVM performs an explicit WRMSR prior to VM-Entry to guarantee PEBS is
   quiesced.

v1: https://lore.kernel.org/all/20260414191425.2697918-1-seanjc@google.com

Sean Christopherson (10):
  perf/x86/intel: Ensure guest PEBS path doesn't set unwanted
    PERF_GLOBAL_CTRL bits
  perf/x86/intel: Don't write PEBS_ENABLED on host<=>guest xfers if CPU
    has isolation
  perf/x86/intel: Don't context switch DS_AREA (and PEBS config) if PEBS
    is unused
  perf/x86/intel: Make @data a mandatory param for
    intel_guest_get_msrs()
  perf/x86/intel: Invert names of intel_ctrl_{guest,host}_mask
  perf/x86: KVM: Have perf define a dedicated struct for getting guest
    PEBS data
  perf/x86/intel: KVM: Handle cross-mapped PEBS PMCs entirely within KVM
  KVM: VMX: Drop a redundant pmu->global_ctrl check when processing
    pebs_enable
  KVM: VMX: Only tell perf to enable PEBS counters for fully enabled
    PMCs
  perf/x86/intel: Check only PMC bits in PEBS_ENABLED when detecting
    host PEBS usage

 arch/x86/events/core.c            |  5 +-
 arch/x86/events/intel/core.c      | 94 +++++++++++++++++++------------
 arch/x86/events/intel/lbr.c       |  2 +-
 arch/x86/events/perf_event.h      |  7 ++-
 arch/x86/include/asm/kvm_host.h   |  9 ---
 arch/x86/include/asm/perf_event.h | 11 +++-
 arch/x86/kvm/vmx/pmu_intel.c      | 28 ++++++---
 arch/x86/kvm/vmx/vmx.c            | 10 ++--
 arch/x86/kvm/vmx/vmx.h            | 15 ++++-
 9 files changed, 115 insertions(+), 66 deletions(-)


base-commit: 6457dc9f2174508a4cc339923a2f18f4d59d17a8
-- 
2.55.0.1082.g2b9226bbc0-goog

