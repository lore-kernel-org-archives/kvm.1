Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1488516152
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 19:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018072; cv=none; b=Tg9zTry6k2/oivlRBQsMqe/YiK9vYF21QAtFEMd6oO1bI5zAep7K1iW0jLSUjNGtAEStQwsEs2c/0HaHmdEwGm9BEDOhO7KYDccWL1jGM94BrzB5BGvTxORu6PL1+ds8Y2zfYYFbTpifUxsbpyuQw6B/2r/ZtLDo/bFKUtJ6TD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018072; c=relaxed/simple;
	bh=VCDhMVMQYurefRNErLkUn/I6Kx9qbfhpA6PbNEO7NMs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AxBFyG4ELfhMAUg0oE9tiUfB9H7ee7SvV7lvW47QVp8LWisf1Gg/N0qUzi1tH6uwbjv3X1QgI6w+SuS/jGBD/6wRBOl8nE8hfKQaV0YD4mMkC6gV3AHhKetOAlr4jhJlkaoFpsiHCCOEJYsvynxpbz2ObpzHhm/xrs31Rj5XuA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=imvI13nJ; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="imvI13nJ"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-86b3c58d686so6878964b3a.3
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 12:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790018069; x=1790622869; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Kexp849iBom5QwUGTOu0hBPnyy7JYZUPl7yuJIwcYg0=;
        b=imvI13nJQ0ZAsKjMnVtEwvC8wqWVcLJ9zRnDjZsbfEIiQtD3Lm3oNGYkTeE1omPmH2
         p66ceftILZhTMhvm8BQKda8Tg68nSFiH12hPyEsXuUh0tmTfmoxYQRSiZnu5/Ceo3Zxd
         0B0wncWY7lB4o2+dgzJVWz2gTGhAVilkSNTUzLI9CuDTMEHl5QEJRGORfYIzC38gx9/z
         oOF4JA0C2lUDLGjtn6KZIStE08OY/TptwiJRA7cKNNDEGldbDHnd84sCRmNRffowqgx0
         ExuaCEgCnpv1xZQYMgsZIUigQGIrLFuHMOSof1b+6H8rkdbVNQNvgIHoscYzQZFP0tVL
         67jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790018069; x=1790622869;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Kexp849iBom5QwUGTOu0hBPnyy7JYZUPl7yuJIwcYg0=;
        b=Gibgtr8s+q+4Bxwz/yl4c57hvCJDJcgVPc9U1yB+de33Jq/JYfDK4IAjIs3tWVc/7R
         9bttulmEb2PRF/32KG0UCeAwLjaFCLt1hm/TjsUg7ompOdYoSnPB716tEW1WKtYRz1wc
         YLHS1VuvkKqjOrg42NAc94jaYVPLSwArqi8Pxl9QSHu0mtlgFFZb205LM1UaSqGtsxcv
         2UdTGAGOI7Mp3Cewimcn2D8EdnZyzrsKuqLdkOusaVtwAaTcau6558Y6rCICIqakjePt
         gKgRidlYFGFlJ/JNJigJRYVehEyjrDlUDRKHAv174W1r1GYuZmZcLGGr8QWrf95hI3xt
         1TBQ==
X-Forwarded-Encrypted: i=1; AKwUvBwfVgV2Cb3Y3e9j+7JAT5dv9qmL/6mSjgHyU+WeKL63UZGWzo+4vewe+2HnaftyPgp+oNo=@vger.kernel.org
X-Gm-Message-State: AFuF++kyt3uMmOtCaM5qKGUBmx+cSAMumTyhMz9ifAozlUeSGj8K2Ko9
	fDTBX53cwPRz5etYJkfvMQdMKSO52/9pguRz0ua1f8e4lLcDsWQFHJWYGjLGXDo2G+03KXJ7gz0
	i2yVTJg==
X-Received: from pfbdl4.prod.google.com ([2002:a05:6a00:4904:b0:879:54ac:7ac0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:44cc:b0:874:708d:b63d
 with SMTP id d2e1a72fcca58-874defffedemr18366624b3a.30.1790018068609; Mon, 21
 Sep 2026 12:14:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 12:14:15 -0700
In-Reply-To: <20260921191418.950933-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921191418.950933-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921191418.950933-8-seanjc@google.com>
Subject: [PATCH v4 07/10] perf/x86/intel: KVM: Handle cross-mapped PEBS PMCs
 entirely within KVM
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

Now that perf operates on a KVM-provided snapshot of PMU state, handled
cross-mapped PEBS counters entirely in KVM by clearing unusable counters
from the to-be-enabled mask instead of foisting the work on perf.

No functional change intended.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/intel/core.c      |  8 --------
 arch/x86/include/asm/perf_event.h |  1 -
 arch/x86/kvm/vmx/vmx.c            | 10 ++++++++--
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 66cacfeb47d3..d9315bb2f221 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5379,14 +5379,6 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr,
 			  ~cpuc->intel_ctrl_exclude_guest_mask &
 			  cpuc->intel_ctrl_exclude_host_mask;
 
-	/*
-	 * Disable counters where the guest PMC is different than the host PMC
-	 * being used on behalf of the guest, as the PEBS record includes
-	 * PERF_GLOBAL_STATUS, i.e. the guest will see overflow status for the
-	 * wrong counter(s).
-	 */
-	guest_pebs_mask &= ~guest_pebs->cross_mapped_mask;
-
 	/*
 	 * FIXME: Allow guest and host usage of PEBS events to co-exist instead
 	 *        of disabling guest PEBS entirely if the host is using PEBS.
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 27f9c5bee7b0..5c92d43bbef8 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -823,7 +823,6 @@ struct x86_guest_pebs {
 	u64	enable;
 	u64	ds_area;
 	u64	data_cfg;
-	u64	cross_mapped_mask;
 };
 #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_INTEL)
 extern struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b097db296792..8f7d0620f44c 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7369,8 +7369,14 @@ static void atomic_switch_perf_msrs(struct vcpu_vmx *vmx)
 		.data_cfg = pmu->pebs_data_cfg,
 	};
 
-	if (pmu->pebs_enable & pmu->global_ctrl)
-		guest_pebs.cross_mapped_mask = intel_pmu_get_cross_mapped_mask(pmu);
+	/*
+	 * Disable counters where the guest PMC is different than the host PMC
+	 * being used on behalf of the guest, as the PEBS record includes
+	 * PERF_GLOBAL_STATUS, i.e. the guest will see overflow status for the
+	 * wrong counter(s).
+	 */
+	if (guest_pebs.enable & pmu->global_ctrl)
+		guest_pebs.enable &= ~intel_pmu_get_cross_mapped_mask(pmu);
 
 	/* Note, nr_msrs may be garbage if perf_guest_get_msrs() returns NULL. */
 	msrs = perf_guest_get_msrs(&nr_msrs, &guest_pebs);
-- 
2.55.0.1082.g2b9226bbc0-goog

