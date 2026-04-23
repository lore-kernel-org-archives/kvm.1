Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AAF36D9E8
	for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 15:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776956634; cv=none; b=NtNEZ0QKyKxNDL8pLksLR11GLTU9ZsktlyA64THDEIofcyT+tiDQ+zq+2SQveKThe2SsC2FriepbqcXGWJd2lBhPfr8R+YAwY7nCrR/Ux8eUzrqibLO5N4N0hPkkpKRCmfGVoFX7boc6WYjQvNkoy+gO6qxbqQAyYLmTZpQ8/HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776956634; c=relaxed/simple;
	bh=CkcrXIw1Eem4o4QbNMX/btWn5w25geAaYmxE9sQm1Qg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aHPmAk+3Bl1XPyFGgTWgJ+vHg/TVU7p8pSCY6kpOTqdYrEM6solYTkPIGf1EzOXnqLB6TxIA6e6pwmFUIMuvB5zNPm90NqbLz8Xep4tNvv7IBOnf4gqKP2OZC2ZhqC0r1ncJgF41dtxzWp5VIjgIg1KhJZTVDQe0Vu2U2Nqc7aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e+pkJGdb; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e+pkJGdb"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-354c44bf176so8111551a91.0
        for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 08:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776956632; x=1777561432; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=i2vqUKmveKZlZolMhgpBRxhYsBG7B/PvclnkTlsDmdw=;
        b=e+pkJGdbBvESWNOjbM5epX5AI2LVvr5FMFChbVXdBftiZuNdT8Oh77p0eSUUzzbL7Z
         3p+id4Wxp8rytzilBtTW0yFTIwoGoj5zQ4qNmRG4TUwV1zUi+expCe9ul4pzA8bHv5ZX
         WEFTIB4S3gUMcpgtRRA0oX1+VUoX2lW39+0TyX0+35/Ib8bnxBGRJYjzgEnjXyI9pZOV
         5PY2L85cBYL6HzUp+XmOmU4fScwaOOrgWrCcFtQ7kU1mGpId1g+wuj8RqWIP4N6S41KZ
         tsDwd6O2TAOp/XkoHKia8lPHRyHXYQWtauhTQKQagpShNhESFE2w8lBK4HvV+gXF8CLt
         mz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776956632; x=1777561432;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i2vqUKmveKZlZolMhgpBRxhYsBG7B/PvclnkTlsDmdw=;
        b=NCgcWOwvR5ETQ5YqR17QskVMo3hoqE9TqLJcjy5pJL0uZDcQawi9GaSXSxbYjhjj90
         vfnjUkwQcc4XyziHaPBL/en0y1XCnbRp+1g3w5pft0hZgevc7YNlJZSd9dw6/Q27oVmV
         MVI8iYVHLhwMChF1/mEQExJ8aTePDbm4LPMjO2GIOOy/bIgl8aAcJdsQekDhU98v2QVd
         jWOR8Ht9WDpx0Qpxc0xOG67D/CXFkqwbc+cTz7VfDX4v91uVBW7g5jePuf8wu1oh3F+v
         pPHKy+jBYZyQe+HmWdVIxfVRNg41h2ocQyg0GY5ULoiI+EzSnlXaiSKdd+E/KZEqhKNa
         oRqw==
X-Forwarded-Encrypted: i=1; AFNElJ9wjc3P3I05mkifVl+SvR4/lTefDw02YlNu6BGtUjhRM43hsVwB6oa7FsM1M4gAOqxDhYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr+vsDF8wSwvA0qFTFXFF9H16Ti189jv++UhMIddEL3GsOlJFN
	6ELE3WAq3/ZR+KOxDoXEWJ5RYYxpyxDrpdjX1h/2oMFMl3LVK2j5FcXX0qgsMLNLgFVB/s7iiIT
	ixsKghA==
X-Received: from pgnp16.prod.google.com ([2002:a63:7f50:0:b0:c79:66d7:2ed5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7285:b0:39b:e321:67ea
 with SMTP id adf61e73a8af0-3a08d8fba25mr30645370637.45.1776956627069; Thu, 23
 Apr 2026 08:03:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 23 Apr 2026 08:03:38 -0700
In-Reply-To: <20260423150340.463896-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423150340.463896-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260423150340.463896-3-seanjc@google.com>
Subject: [PATCH v2 2/4] perf/x86/intel: Don't context switch DS_AREA (and PEBS
 config) if PEBS is unused
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

When filling the list of MSRs to be loaded by KVM on VM-Enter and VM-Exit,
load the guest values for DS_AREA and (conditionally) MSR_PEBS_DATA_CFG if
and only if PEBS will be active in the guest, i.e. only if a PEBS record
may be generated while running the guest.  As shown by the !pebs_ept path,
it's perfectly safe to run with the host's DS_AREA, so long as PEBS-enabled
counters are disabled via PERF_GLOBAL_CTRL.

Omitting DS_AREA and MSR_PEBS_DATA_CFG when PEBS is unused saves two MSR
writes per MSR on each VMX transition, i.e. eliminates two/four pointless
MSR writes on each VMX roundtrip when PEBS isn't being used by the guest.

Fixes: c59a1f106f5c ("KVM: x86/pmu: Add IA32_PEBS_ENABLE MSR emulation for extended PEBS")
Cc: Jim Mattson <jmattson@google.com>
Cc: Mingwei Zhang <mizhang@google.com>
Cc: Stephane Eranian <eranian@google.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/intel/core.c | 39 +++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 002d809f82ef..407fd392fd46 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5037,23 +5037,14 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 		return arr;
 	}
 
+	/*
+	 * If the guest won't use PEBS or the CPU doesn't support PEBS in the
+	 * guest, then there's nothing more to do as disabling PMCs via
+	 * PERF_GLOBAL_CTRL is sufficient on CPUs with guest/host isolation.
+	 */
 	if (!kvm_pmu || !x86_pmu.pebs_ept)
 		return arr;
 
-	arr[(*nr)++] = (struct perf_guest_switch_msr){
-		.msr = MSR_IA32_DS_AREA,
-		.host = (unsigned long)cpuc->ds,
-		.guest = kvm_pmu->ds_area,
-	};
-
-	if (x86_pmu.intel_cap.pebs_baseline) {
-		arr[(*nr)++] = (struct perf_guest_switch_msr){
-			.msr = MSR_PEBS_DATA_CFG,
-			.host = cpuc->active_pebs_data_cfg,
-			.guest = kvm_pmu->pebs_data_cfg,
-		};
-	}
-
 	/*
 	 * Disable counters where the guest PMC is different than the host PMC
 	 * being used on behalf of the guest, as the PEBS record includes
@@ -5065,6 +5056,26 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 	if (pebs_mask & ~cpuc->intel_ctrl_guest_mask)
 		guest_pebs_mask = 0;
 
+	/*
+	 * Context switch DS_AREA and PEBS_DATA_CFG if and only if PEBS will be
+	 * active in the guest; if no records will be generated while the guest
+	 * is running, then simply keep the host values resident in hardware.
+	 */
+	arr[(*nr)++] = (struct perf_guest_switch_msr){
+		.msr = MSR_IA32_DS_AREA,
+		.host = (unsigned long)cpuc->ds,
+		.guest = guest_pebs_mask ? kvm_pmu->ds_area : (unsigned long)cpuc->ds,
+	};
+
+	if (x86_pmu.intel_cap.pebs_baseline) {
+		arr[(*nr)++] = (struct perf_guest_switch_msr){
+			.msr = MSR_PEBS_DATA_CFG,
+			.host = cpuc->active_pebs_data_cfg,
+			.guest = guest_pebs_mask ? kvm_pmu->pebs_data_cfg :
+						   cpuc->active_pebs_data_cfg,
+		};
+	}
+
 	/*
 	 * Do NOT mess with PEBS_ENABLED.  As above, disabling counters via
 	 * PERF_GLOBAL_CTRL is sufficient, and loading a stale PEBS_ENABLED,
-- 
2.54.0.545.g6539524ca2-goog

