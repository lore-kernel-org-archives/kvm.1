Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004003BBA0D
	for <kvm@vger.kernel.org>; Fri,  8 May 2026 23:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778282045; cv=none; b=i8bfTD4aHVap7amUM/FKKBSHumgjGMcHzOupi3vJtvRuUhvDMehC0tcUcD0PrrTM7NU9OEdjOQRUKikQfV49XDQor6WrVGbRgDoo2ofsp0e+5P21rJNlpurwCopkOh+cR8owPj5S9NudGiWOSQnIn84AECoOxQMmuWQA74QA6iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778282045; c=relaxed/simple;
	bh=otxpZlAkHL5y/QJE3G7rXySXlAmg9ZfAXrLlLt/iukw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eXX7RJ7OUC1xbBmE+AwPpluwlkikgiMtOK3VQiFQilRXp0GabGOR/0EY97b8TFabA6Duz1cPcvshcQUsbx0J3n2dp8ABo1y6bH2EBakaZS8fVXypeZQY39qHGwldMxXy1trPUxa0k5Zx28CVj8aAHexNxnZgx2JWDHbtZZzhUkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aHSEJIo8; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aHSEJIo8"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b9a6d84522so46650555ad.2
        for <kvm@vger.kernel.org>; Fri, 08 May 2026 16:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778282043; x=1778886843; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=3hn/vCE+SheJ11Toa1ORgidQGCGEmHGjeA0kV3k6HSI=;
        b=aHSEJIo8yiUuaIJPqXXdH5YPIOyhvJxNQ4wU6b8VYp+d56noOimiqNwf/4knnhrt3H
         lxeXwaIe0uu1RwYW9agkuyCeSyjDxw1vGvvz+ql/TeM/TPfOkxG1E05+5mOWVmcJLWUp
         QdmqGW21M04iJf/U/NKP930Ri8p+ROpOlhKEq3Inq+SdlhifImO+p++NdOOc1EowHqSE
         DRJL3qXfZl7xPXXVVpwl/tUrqLbUGmXN221REiomrbICJDUeKeyhOr5d5GOcTYVgRvHZ
         cCLqMCWalLqdhV6K2nMlGMeaceZ1lZW7rKEuYxCkfuOsN51Ler3W6cuhDsOihyTy/Zex
         wXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778282043; x=1778886843;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3hn/vCE+SheJ11Toa1ORgidQGCGEmHGjeA0kV3k6HSI=;
        b=VguarZ6mH9UsKj+ljXTah/BEo1G43TUVCuj7JR8FK5MYulgepmOx2lNrl4c6/alLa4
         DyH98Iksi9krwXHXAO119dvZN7cdh9tBXsaiiWnLToLwxaRTLpiq7LHsvRaIHOJByScr
         BDFVE58DAKJBMm72FOlPGJk72OF9LN9R62C56uoopAyrS7Wf1zM/hNZ8EZrtDg38Dqqt
         V0ZSLGVn+lraP/X3EX6CnG7dUhAknT2MgH5Qii5WtO5iiaHKkJDUml44BJdaYBZhNGjc
         NiuTf1y0aVUFw8TgK+rd7XZumMPLl0IrHdPGD+rgDXfD81K1jfVr3pMDtBqOTnxFMcSW
         Yx1w==
X-Forwarded-Encrypted: i=1; AFNElJ91tuBU0fGw/oeED09c5P/ACMFrqcFcfYBzJ0T9QNA7z6LV+dlFD3GHiA2a1h9fz4U24X8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw78rZAzIJ70hUqLSVfd63tMZ7+XdKgaTQzvgu4dq0dIDAH/aPe
	YUi1Tu3fOSp1mA20FbLHhdZNUBKcBWjOQVV6r8Gu3JThYHOrkQ/mdUYxBeiGcRmQ1Fuc6L0HSlx
	9lxfYlA==
X-Received: from plot2.prod.google.com ([2002:a17:902:8c82:b0:2b2:50b1:327c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c410:b0:2ba:839e:15dc
 with SMTP id d9443c01a7336-2bc7a9b46a8mr2444545ad.17.1778282043244; Fri, 08
 May 2026 16:14:03 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  8 May 2026 16:13:51 -0700
In-Reply-To: <20260508231353.406465-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260508231353.406465-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260508231353.406465-8-seanjc@google.com>
Subject: [PATCH v3 7/9] perf/x86/intel: KVM: Handle cross-mapped PEBS PMCs
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
	Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>, 
	Stephane Eranian <eranian@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Now that perf operates on a KVM-provided snapshot of PMU state, handled
cross-mapped PEBS counters entirely in KVM by clearing unusable counters
from the to-be-enabled mask instead of foisting the work on perf.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/intel/core.c      |  8 --------
 arch/x86/include/asm/perf_event.h |  1 -
 arch/x86/kvm/vmx/vmx.c            | 10 ++++++++--
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index e9acfc3f3a82..8f6be0cc4c4b 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5053,14 +5053,6 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr,
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
index bc7e48f6f4a8..19f874a79ab0 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -790,7 +790,6 @@ struct x86_guest_pebs {
 	u64	enable;
 	u64	ds_area;
 	u64	data_cfg;
-	u64	cross_mapped_mask;
 };
 #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_INTEL)
 extern struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 9f0a028cf10b..fbe3ce5f5a51 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7319,8 +7319,14 @@ static void atomic_switch_perf_msrs(struct vcpu_vmx *vmx)
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
2.54.0.563.g4f69b47b94-goog

