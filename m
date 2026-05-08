Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A202B3B2FEA
	for <kvm@vger.kernel.org>; Fri,  8 May 2026 23:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778282041; cv=none; b=M4LdZQ3OAC/c5jX5sUNBy78bfmK/cIrkvJblrTszRp65MwOC+0/TEd4LfqxcUojmRY94vxAcxyPYjn5GjOfxuQICYgSBppmH0fzSYX626LMaaRrP3QRhbzFUqa8O9Cy92rtVNxQJrIhdQ/twCBozPjsAcFl07uEDxrlRj4EgWxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778282041; c=relaxed/simple;
	bh=Cs8x6xkY1ZiIqH1MFpLULYp8Rr4Fz288wc2+f1BQbdM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OIUS+KvL/f/ppnV9kefvL7OcAKW485yMW2NZz2sJOcQ7Hx8w9NqtuTsuQ8uaNX4AXWUfRUNBIcvUXuuFNEpBMCoixRGFAxn7npWxsrgLZ19ssBCWidsUHnfOOU1/5/QdJ7sKuTmWljTGUjll4vwABeQ2OEDpv70U91GO5MMXoD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hjkp0TZ0; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hjkp0TZ0"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8271fb4407so220822a12.2
        for <kvm@vger.kernel.org>; Fri, 08 May 2026 16:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778282039; x=1778886839; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=4v9hsAEokHAnzUckzAwcqgBfPt3hYzElKEYLdatb1h4=;
        b=hjkp0TZ0I4XPp44zECGIxveGN0+23QkyFIZvoZawuGh8hxRy4sAPjF9D4jwuT/vcdW
         5bS0hr0qki+7LjXj9duiPKIr8i5pvY/HIFDipYqQ0vCNAvnADLhu6kzPWJsJ0bWXCr3W
         kAM27OkUd7edk8LAkya4iEu+y8LKVtfi4PeoRnxUZF/I/gg/D+EmAKCFLxFbK8VNGHJc
         PXjTsZYAhnStd6wj32I1Vk78V/m9RBmIey3dSU9I6nXA4i5nJ+52vv+8EXwmbK2QWjuI
         ok9X/jjC5ZhH+6F5r1DVHjnYyyYKXULNHH+KqFURd7LXMLaBtPM4KZSHvhMhrA9wztUK
         N1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778282039; x=1778886839;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4v9hsAEokHAnzUckzAwcqgBfPt3hYzElKEYLdatb1h4=;
        b=ICsMZ8fsnAS8M83yO/AKa5fd06vP+uZiBR+M0q7KarGf9V+G/cGCx5uzKj3oEE8sJ2
         9wffctEQiw00jS7IUWOBQez1r6UzYRtdoUGI/CHFG7IpODjcqixdlS2XMXUldsZPWH+3
         6E3P7hiTC96bgpjkmb19eI7Ja2aOcP2HYcpTdGcscqbQoYs7j1fUfHWKmccx6i1/s3tg
         GqNcVDXajXxvkE1QiykURBP+3G0cOcHQ+daD0JhL2MXj+WQw4IUHVZHNxzmkCz+iXwId
         A4yR9Vf9zsYNUudLBUURMCpka952Y6GqjeUdOX6EEK7tjIMjMJU70tPir6Pecap9N7sy
         PpnA==
X-Forwarded-Encrypted: i=1; AFNElJ9mVNCqmMCXovp8QtaAtzn77HBXWkzcFG4pJiUqr/XUwPSLYXB/aumbRqeQ88RPUPU2Rjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCs/MdYYE294hO4TVnu2d+L/072w8MSvLAeBv6wLj/vgOF8T2q
	lL4AtrTQRuysA58h79cGFV7VZycnk0Rk3/uAv4TeUu+tH87iOryqqG3rt1xoXeVZ7C8BGNiP7+t
	LVkiZMw==
X-Received: from pgbfq18.prod.google.com ([2002:a05:6a02:2992:b0:c7b:acc3:8dec])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:94c7:b0:398:a060:a967
 with SMTP id adf61e73a8af0-3aad426e435mr199226637.11.1778282038735; Fri, 08
 May 2026 16:13:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  8 May 2026 16:13:47 -0700
In-Reply-To: <20260508231353.406465-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260508231353.406465-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260508231353.406465-4-seanjc@google.com>
Subject: [PATCH v3 3/9] perf/x86/intel: Don't context switch DS_AREA (and PEBS
 config) if PEBS is unused
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
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/intel/core.c | 39 +++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 13cd12d3eeee..0e9ac2e9b5e7 100644
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
 	 * Restrict guest PEBS events to counters that (a) perf supports, (b)
 	 * the guest wants to use for PEBS, (c) are not excluded from counting
@@ -5080,6 +5071,26 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
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
2.54.0.563.g4f69b47b94-goog

