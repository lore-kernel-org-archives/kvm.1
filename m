Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B29146D556
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 17:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786036719; cv=none; b=kuPMlTAFfp/VNDV29NOI49viRqg02JwEGMR/MRvcDJhWFy07Gh1soUuL8geZvrwQKH0oJbDeEsdxvJziCfOa1JCrk1GLX9S4037R+CsN9ksHFW0UUU5If3DZR90YAJSreEjmPZ1GUX0X7177UrXiDKcOpj3tbYiEn/bPtDvW6Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786036719; c=relaxed/simple;
	bh=/osmdlOzOaPZjmz/eL73IZgcEBPxf62ZZzBFgEBZrPw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=KgErC+uuaaPJ6jxldoy8VxckSlLxK4ShzUdgle4kpNdGZU7FggElQnnOk80N9Aa89CC0E6sWSy92nRMnTssCC163JdJrqB9iQx5hp85P5PBRKCxrCcXh+31RvafRMSOQbdId551oeI9qwx4kt2ZvdV+HW4jLu0G8TyoMcg84vfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CCJ5f2Et; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CCJ5f2Et"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38ea32e57e2so4109137a91.1
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 10:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786036715; x=1786641515; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UhI24rX+Y5w7TUnQEOZYP3VlRg2+NeVZmSo9caXsF8c=;
        b=CCJ5f2EtWI3L0sWbuXS9/h1Mdsrcfpk9WsbGnJssnrFY3yADmF4/o38cDuqfTfTRWf
         fmEazsTS2tSgTLej4bw764RvtmJMoW8QezLvTDfuxACzyt6twk2Y5Kl4LdTIONEr6vZq
         9sb/wFaVPy2CmJBL1ISsQOw4QC2cgUhp15peLra6IBxEwecPAqBQV4d0Sh+znLcYZEiQ
         SPjgscaLBgR42I0lGi2YbC/aUVZYd7DjHwLACtq9x89ybDmiEa4q5AUyoC1JSTaQ46po
         t41kGVAbRWTYWY/B2h3zIn67hVLyzjeLqvzf5fAREYWTX5/lnxv+3CMDCtP3X8D4y/pT
         2GVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786036715; x=1786641515;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UhI24rX+Y5w7TUnQEOZYP3VlRg2+NeVZmSo9caXsF8c=;
        b=FW+F129AX8ENu1mSkKKMPUMaC3KPn8ImBfqYIK2hzMCidiH2cRk1UHeb4VV87cVOAz
         heby3DZ/lsBdSLs254oWx6hyy6jvTUpSZsoK/5VTp1irDucCwLrSg+2AuUGQmBAHyjBT
         P+28TI/9dbNogjjU/Bych0zt6BjnK3bCMDuzq9sw8AP6Ncw+1GjMiLYgP2+QqeAjSpKB
         0hFzBZTnb6FVhTkZF6rndz10X7bfGqmbVhdzY+K6rkF95nxVIBcC3t7WNJ8QZ6JqpjbB
         FA8/zz7P98ZcYJfc+aS8X3Ld0Rvnfs4VvkZcw+1RI79vQ7GTfVq11rsdjQI2zQgxLgnU
         Sxcw==
X-Forwarded-Encrypted: i=1; AHgh+RpAOtUzhdsrmeQedMTgwy4JPDDSS25Mz24lDn5zSkTNjMetL9mh90h83Elc4yPHzsFeBHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT2WfmoJNUzPAyS6+3Gca/GgCJWZ18JOtBYVSHtYyauGIbU8d+
	K/aEpgdsJq5muZyRkQcgTiJW/thlDJaW5B/a2sd26i9pZYNYz5YVyqzuzs+7NFSxfdiSRGjMqLb
	B38+r+g==
X-Received: from pjbgi21.prod.google.com ([2002:a17:90b:1115:b0:38e:620b:ba5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1843:b0:37f:bfa2:1887
 with SMTP id 98e67ed59e1d1-3903c53639amr17964821a91.8.1786036715207; Thu, 06
 Aug 2026 10:18:35 -0700 (PDT)
Date: Thu, 6 Aug 2026 10:18:34 -0700
In-Reply-To: <20260508231353.406465-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260508231353.406465-1-seanjc@google.com>
Message-ID: <anTB6ksbUs18FEf1@google.com>
Subject: Re: [PATCH v3 0/9] perf/x86: Don't write PEBS_ENABLED on KVM transitions
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>, 
	Stephane Eranian <eranian@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, May 08, 2026, Sean Christopherson wrote:
> Sean Christopherson (9):
>   perf/x86/intel: Ensure guest PEBS path doesn't set unwanted
>     PERF_GLOBAL_CTRL bits
>   perf/x86/intel: Don't write PEBS_ENABLED on host<=>guest xfers if CPU
>     has isolation
>   perf/x86/intel: Don't context switch DS_AREA (and PEBS config) if PEBS
>     is unused
>   perf/x86/intel: Make @data a mandatory param for
>     intel_guest_get_msrs()
>   perf/x86/intel: Invert names of intel_ctrl_{guest,host}_mask
>   perf/x86: KVM: Have perf define a dedicated struct for getting guest
>     PEBS data
>   perf/x86/intel: KVM: Handle cross-mapped PEBS PMCs entirely within KVM
>   KVM: VMX: Drop a redundant pmu->global_ctrl check when processing
>     pebs_enable
>   KVM: VMX: Only tell perf to enable PEBS counters for fully enabled
>     PMCs
> 
>  arch/x86/events/core.c            |  5 +-
>  arch/x86/events/intel/core.c      | 92 +++++++++++++++++++------------
>  arch/x86/events/intel/lbr.c       |  2 +-
>  arch/x86/events/perf_event.h      |  7 ++-
>  arch/x86/include/asm/kvm_host.h   |  9 ---
>  arch/x86/include/asm/perf_event.h | 11 +++-
>  arch/x86/kvm/vmx/pmu_intel.c      | 28 +++++++---
>  arch/x86/kvm/vmx/vmx.c            | 10 ++--
>  arch/x86/kvm/vmx/vmx.h            | 15 ++++-
>  9 files changed, 114 insertions(+), 65 deletions(-)

Ping.  This still applies on Linus' tree and against tip/master.
