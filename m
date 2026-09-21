Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECC55172D2
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 19:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018072; cv=none; b=VDDtSWkpt9iGEFQMRAKuRD/fFcKWF9ED9BvRmVyUKfZddkI3jrr30u1tqFVO6HhLAgD9kDoCzYl3G+k2jfiSeyh2FPIH7ZsDlVzX8wZfpIxlrjXERvPlvGE3Axy7/L+7xu6FY2IU+vGHhSblny3g9pNEbSHXddf1z9PqHsrhklw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018072; c=relaxed/simple;
	bh=1riINGkb8L/lMBS1UBqJLhb7YTi+JdgCbq8563Ste2w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gmqd12YONLtr6Q74osnJw1qx4gPbMy1PtwY2VlSTuWoCnb/BFZbWmB7cpjwmNsr5HU+unmYwmMl09tQWP3HljXFgGMJ7bfvN6tCsAg3MPQlWFOxQu9XNJL8UaF72TOb03VBwRrO6CcAFKUxvALHqMsJShQl2KcQEg/fPSlEI6sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CVZFDDm/; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CVZFDDm/"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-395543dc382so4220593a91.0
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 12:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790018070; x=1790622870; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QmFxhUAgOU4dzSpCpiNYSlNdPENSvbq1kjEA7GNm5hU=;
        b=CVZFDDm/p7orySAXLJonXfGYp+EfygPB0lWlmElihaVKC3KuZGaS594QGT2sYaj6xu
         ZBdF3AXLyiNgWu0SHHMlODlcHgRdl9eBXWA3d2QWP2z4UObWUQ/G+Gt+vcHspsqzvKT5
         7W6azSRRdzuCAEM3bKFygWE901LlomdqjttOLn9bUOahCOHK0xx5/VEh16O7KqYfiXDa
         7cqu3ksfsF7GEtx5K6YpyG67Bh3ZDhjpqSSQDR95lvrUU/5n0lUcS1vOaeP2XB7LgHhD
         Cld6Ue4Ey8fi8NGgirD6N6+m/NuwxaD/X0kmH+kKK5cIt7Uo/LHw7/dCkkKSEpBDearo
         KmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790018070; x=1790622870;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QmFxhUAgOU4dzSpCpiNYSlNdPENSvbq1kjEA7GNm5hU=;
        b=Sm6ruuUroxO8KXIhI6XAq+GIJSyFpxiLnbqe9gnvV7BCBWdD8GzyJ9mfoyVh9lm/dW
         OiJRFgr5OaqT0E/QxEbq5V9ULnWaWKLvpjzfhVBomEXwHqN11yH1KZ2IU77jAGhztZjg
         Q2gO9IgeA5aRzg/udoJRSZDjjv6tZfb2vH+YpidNIjKHSBIXvnX+nVF5+PVimFO7vOao
         QcgRyS0FluRzwMAopFYygk//jydSdXS3IAJvYwDVxzz9EGGp6ZsIYw1WRVtZ4OXCWfvx
         1VK2C+r5qu5Puq9CO6qWe1hwNsaZwt8HmPlgjSVJNTb8cKA6nM/fBmjxZ211L4MqNwIU
         5EBw==
X-Forwarded-Encrypted: i=1; AKwUvByZZF/wMnvGvLb5FjhRyGHMjXTXYltC6AUP8kxDjh3NEk0HY3XluE2zJ/HrXzFyGKoXnUQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nAMk8bi3P1OQt2pRyX2ClK7xJUft3OpTyt00ntnknQUVLd7uXa
	DyXlMWg5fkOjjAVC1p7qhjBmXyI1Z2TxhO3NVCR49q9uoYLadS9TJS9apyToxk0de18lNwfOTbS
	lXCcKiw==
X-Received: from pjbmp14.prod.google.com ([2002:a17:90b:190e:b0:3a0:6737:b83])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:55d0:b0:39e:6a81:c921
 with SMTP id 98e67ed59e1d1-39e6a81c9bbmr13344548a91.20.1790018069667; Mon, 21
 Sep 2026 12:14:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 12:14:16 -0700
In-Reply-To: <20260921191418.950933-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921191418.950933-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921191418.950933-9-seanjc@google.com>
Subject: [PATCH v4 08/10] KVM: VMX: Drop a redundant pmu->global_ctrl check
 when processing pebs_enable
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

Drop a redundant check that a PMC is globally enabled when looking for
PEBS counters that are cross-mapped between the guest and the host.  The
for-loop explicitly iterates over pmu->global_ctrl, and since PEBS requires
PMU v2+, kvm_pmu_has_perf_global_ctrl() must be true, and thus
pmc_is_globally_enabled() is simply checking that the bit is set in
pmu->global_ctrl.

No functional change intended.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/pmu_intel.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index a21e146ad4f2..040b8e80cf86 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -763,8 +763,7 @@ u64 intel_pmu_get_cross_mapped_mask(struct kvm_pmu *pmu)
 	host_cross_mapped_mask = 0;
 
 	kvm_for_each_pmc(pmu, pmc, bit, (unsigned long *)&pmu->global_ctrl) {
-		if (!pmc_is_locally_enabled(pmc) ||
-		    !pmc_is_globally_enabled(pmc) || !pmc->perf_event)
+		if (!pmc_is_locally_enabled(pmc) || !pmc->perf_event)
 			continue;
 
 		/*
-- 
2.55.0.1082.g2b9226bbc0-goog

