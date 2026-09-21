Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A546518133
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 19:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018075; cv=none; b=VXJZMjGtPIeO7fRhnE9BvTP6NJ3zwOD0X0/4nXSTseCMoVv1do8qz6QCtHfX65E8/1F5wYCIEwGMpuGYFt0+JzDmSmCFahfo4EMXP9/TR1T5vqTZPygipXxyLyoguHB4g3mZ+WhVtP+XOUwx9rOpbsjsLhIRb2M5r7Cqj/50g0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018075; c=relaxed/simple;
	bh=O7cl1f+Ku4ElVI+j9QzehZwaOw2RzUkvNTSUsc1KYbg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KSiNQ3EPCzb7y3eCYxK/besaDTi6UCT7aApgChB9squtN2GIIjyoqRB0cDamd7pa8jZLjvoX4UYz2hfovihvu2M98gXuQSSi5kIEDGN6KEy8Ff8BoZEKzKWfHoQtv3f8WON2ioVUbT22YqzWRT4FIyUUVY4yk2btAz2YXdGN6NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PZ6cGLIG; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PZ6cGLIG"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39de1f85cb2so4124249a91.0
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 12:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790018072; x=1790622872; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ASz4Q0ucM2e9v/JxsDfEs/Vr8jUfdWFu4QQmoSAdRYc=;
        b=PZ6cGLIGuVvxXa1ARyc/vwXvNwlnRNXrREQwzmJxgzWecsX2qDYMYjdrPE+8UD0NcG
         yUV8dUjg0Zucs+i3pRDFjPvDQKskh4t9h6PJZD4jmvemNOA06FJ/amW59RrXjIKxj7w3
         wyxpK1Kxj5ai998/QH3T81Tu336KfExrl47YHJy+B+MvircdUCp56sea54zez+bPIu/Y
         jNMxbe3gGNmO0QnJaO5iX38emTUsuWkb+mB+thge79kEc1ySB008T5ws1Rs19ZJB/EDT
         96miQZR3YgzkSWjaBttT4sj4h3dF0pKan6zkZUtDVYcE0BbOwhCE8m+FuSjicecIFHjY
         ta7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790018072; x=1790622872;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ASz4Q0ucM2e9v/JxsDfEs/Vr8jUfdWFu4QQmoSAdRYc=;
        b=npuc0xsRIe1pIsyhBKAKrDLM7Q8AijzV3b5nGXBQW7lx/w6f2SAFhReVB3YVYAL5Si
         yo/+7UUmh4cY4JomzMy3EUaZ7riZAcT4IQpjvj00tp6vUsLOkqusZcwjRbl7O3UbT1bD
         d/Tbz8cEitztC6rgeGl1NPpUEq66+mEIG7MvczrfvOE3FkTWSi3WJ7gDPGjuFSWDpQXj
         ePxLRQ1PXA8eggiuTJEm3ZszafXBmjYaLiiYkWB7jih8xm++5A6HdazPkU3DJCl9l58b
         19DyWLfBn6LNCCcz77WB+sr02nATYdZZW9WXy8LVXNQO1+4Aib0gC6uz3yLNFiNDj7LH
         ukjQ==
X-Forwarded-Encrypted: i=1; AKwUvBwFCvxZLw+ZJYjrWoioSgnLlXq6j7GQ1eH9QYyR0MxsSDTU24U6S4NM+U3uZkmTyoiT/QI=@vger.kernel.org
X-Gm-Message-State: AFuF++lBL5PrGVThzNFP/rYj8cQ3tez4gxoAJuE083iTm8GnB+5W3ZEd
	KboAQGU/ZzjPMxuFwQXKNYa6aAvqzGcw2zIUF28NzsrhBy4xY7ztSllqtnWmy+hwBj1Gk/JOBf2
	HZqYkVg==
X-Received: from pjbml8.prod.google.com ([2002:a17:90b:3608:b0:3a0:40b2:70ad])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d648:b0:39e:6c6a:4b6e
 with SMTP id 98e67ed59e1d1-39e6c6a549dmr10605450a91.56.1790018071987; Mon, 21
 Sep 2026 12:14:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 12:14:18 -0700
In-Reply-To: <20260921191418.950933-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921191418.950933-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921191418.950933-11-seanjc@google.com>
Subject: [PATCH v4 10/10] perf/x86/intel: Check only PMC bits in PEBS_ENABLED
 when detecting host PEBS usage
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

When checking to see if guest PEBS usage should be disabled due to host
PEBS usage, filter out non-counter bits in PEBS_ENABLE to avoid getting
false positives in the unlikely scenario that "Enable Precise Store" is
enabled without PEBS actually being active for any PMCs.

Note, the other "hidden" usage of pebs_mask is already explicitly masked
with intel_ctrl:

  .guest = intel_ctrl & ~cpuc->intel_ctrl_exclude_guest_mask & ~pebs_mask,

I.e. removing the non-counter bits from pebs_mask doesn't change the value
that is loaded into arr[global_ctrl].guest.

Fixes: 854250329c02 ("KVM: x86/pmu: Disable guest PEBS temporarily in two rare situations")
Suggested-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260508234018.F06AEC2BCB0@smtp.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/intel/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index d9315bb2f221..1ff0586c7b71 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5323,7 +5323,7 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr,
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct perf_guest_switch_msr *arr = cpuc->guest_switch_msrs;
 	u64 intel_ctrl = hybrid(cpuc->pmu, intel_ctrl);
-	u64 pebs_mask = cpuc->pebs_enabled & x86_pmu.pebs_capable;
+	u64 pebs_mask = intel_ctrl & cpuc->pebs_enabled & x86_pmu.pebs_capable;
 	u64 guest_pebs_mask;
 	int global_ctrl;
 
@@ -5375,7 +5375,7 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr,
 	 * the guest wants to use for PEBS, (c) are not excluded from counting
 	 * in the guest, and (d) _are_ excluded from counting in the host.
 	 */
-	guest_pebs_mask = pebs_mask & intel_ctrl & guest_pebs->enable &
+	guest_pebs_mask = pebs_mask & guest_pebs->enable &
 			  ~cpuc->intel_ctrl_exclude_guest_mask &
 			  cpuc->intel_ctrl_exclude_host_mask;
 
-- 
2.55.0.1082.g2b9226bbc0-goog

