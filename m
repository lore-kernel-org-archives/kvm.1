Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755074DEC13
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 20:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790799523; cv=none; b=fyRNlJYw4eoMiSR4d69j5/3UUQMbwEmJC0xBWyNZwOB8ezAQou20okpnX3zrzrmUiMxo7VhDFgFtLsiEo6u9Qid7J9GkoLIQKe3Q3PXlE0Hb+WVgYjJH5GLIlSEgB1xDwwqbhgpIKDhHsyFmnsmuso5pUHxCaSQnSj6monn0Cpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790799523; c=relaxed/simple;
	bh=98J3iTOOkroP2AjERxRwTN81+QC5MV6UO6aLYjEbneA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u67xCRgEwaVpkqDcsJTc2dp4hND7SUsdbDYSYFqV9iO++p9AERfaVpW29v8IRBs8KEBos4XTFJgXKzXT1Q/Z45FZgivEiD9w0TT/V90POIQmlMWp6o+dgM1QeEeiJMPn66+58rji77Mgls9+5CdXSFbB8i+LZDW9LqOli07MbWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FqZ51BXy; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FqZ51BXy"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2df8484f12cso55778505ad.3
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 13:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790799521; x=1791404321; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g5RnSeKm7NovotukVZeykuhmaB+r506gw2FYRO6ls7g=;
        b=FqZ51BXy8V/tnU9QOOyRvJqFuBFCvv75znByRzGRlsKvXNFphUkYVEkmovtZKBqwi/
         I4QqPcLj7l0AVGTCuU8c4SC+LtyJ7TPESsEZoqViaCPvbQaeCMp8fMFl7e/AtBiKPlSt
         LMUbFrJ4TWsLxJq0S++f0OnX+ZEBiwJ/ZCMPw7lpNb+zrtnVLIjVemZre+sFyWy0ikr6
         c3x6pZmEc2ses3ZnULsLBA/fkCTITt75nKyGLM/3c+mRfeouuktGEEVkT8+fCttZjmz0
         JUt0RcZ4bj3NAvuzSygRAhkbZn2LAblHHA/R/yofFb02woau4o3CGzTra2MjqOCs/mQX
         emWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790799521; x=1791404321;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g5RnSeKm7NovotukVZeykuhmaB+r506gw2FYRO6ls7g=;
        b=dVZSYjuQ//+M7EjCjgKOKdUCc/BLE1IIAlAOq+ittkda51pjfn93yAnsbnK2Kl945m
         CdrsnW2QTQwXfRwGw8aPHqAKmk503SzMN9S962aiYT5gSNKJ7SZ7F2KxYFIDCjI5YP1T
         1WEgzb7aDwWifiZWVpjIzijPv47Ahuf0KCgAKFGaDsUrezDyxkT60S3ZBn82pb7bs03V
         ZbtvDUgTJtdb8S3a71jW5N3T5zZKgRt64Rx8RQJQ+LSmWW9Mo3smIIAR/DO8SO1RasRr
         1vW2baPg3LEbhZrYudEEVcW+CqNd1tvsYIwy7tIesmlM1h4Rp7Zdr6eGSDg8uIUNn3S+
         qqPg==
X-Gm-Message-State: AFq9FYJhJ7MHCTpL23fX+dHI0LXuTFo0K7JSnqHOUtY3yfo5/6TFHBTY
	p7YII26Rl2Z1Vaw+Ac1U3azbU9JYquyer6Ky1zbyTeLudj8SacGA8RaEILqZEDxDPhVRqUY1/lp
	IXXpxqg==
X-Received: from plbd9.prod.google.com ([2002:a17:902:f149:b0:2e1:3498:c5bc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19cc:b0:2dd:c053:82f1
 with SMTP id d9443c01a7336-2e2e4b6d013mr22071315ad.40.1790799521505; Wed, 30
 Sep 2026 13:18:41 -0700 (PDT)
Date: Wed, 30 Sep 2026 13:18:40 -0700
In-Reply-To: <3bfbf15c22652ba00cf4a16fe9e0a3bfe7071f97.1784096302.git.sandipan.das@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <3bfbf15c22652ba00cf4a16fe9e0a3bfe7071f97.1784096302.git.sandipan.das@amd.com>
Message-ID: <ar1uoI5Zy7sAQs22@google.com>
Subject: Re: [kvm-unit-tests PATCH] x86/pmu: Relax precise count check for
 emulated instructions on AMD
From: Sean Christopherson <seanjc@google.com>
To: Sandipan Das <sandipan.das@amd.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, "Nikunj A . Dadhania" <nikunj@amd.com>, 
	Manali Shukla <manali.shukla@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 15, 2026, Sandipan Das wrote:
> check_emulated_instr() expects the retired instruction and branch
> counts to match the expected values exactly when a global control MSR
> is available. This does not hold on AMD processors because VMRUN is
> counted as a retired instruction and branch in guest context. The exact
> comparison therefore fails, with the surplus varying with how many
> asynchronous #VMEXITs occur while the measured code runs.
> 
> Hence, gate the precise comparison on pmu.is_intel and fall back to the
> lower-bound check, mirroring how adjust_events_range() already handles
> the same VMRUN behaviour.
> 
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> ---
>  x86/pmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/x86/pmu.c b/x86/pmu.c
> index b262ea59..2b8d1b5b 100644
> --- a/x86/pmu.c
> +++ b/x86/pmu.c
> @@ -786,12 +786,12 @@ static void check_emulated_instr(void)
>  
>  	// Check that the end count - start count is at least the expected
>  	// number of instructions and branches.
> -	if (has_perf_global_ctrl && !pmu.errata.instructions_retired_overcount)
> +	if (pmu.is_intel && has_perf_global_ctrl && !pmu.errata.instructions_retired_overcount)
>  		report(instr_cnt.count - instr_start == KVM_FEP_INSNS, "instruction count");
>  	else
>  		report(instr_cnt.count - instr_start >= KVM_FEP_INSNS, "instruction count");
>  
> -	if (has_perf_global_ctrl && !pmu.errata.branches_retired_overcount)
> +	if (pmu.is_intel && has_perf_global_ctrl && !pmu.errata.branches_retired_overcount)
>  		report(brnch_cnt.count - brnch_start == KVM_FEP_BRANCHES, "branch count");
>  	else
>  		report(brnch_cnt.count - brnch_start >= KVM_FEP_BRANCHES, "branch count");

I'd rather treat the AMD behavior as errata, e.g. so that we don't play whack-a-mole
with thing like measure_for_overflow().  Even with the below, I still see random
one-off failures in the overflow test (I've been ignoring AMD PMU failures for a
very long time).  I haven't debugged why, but AFAICT this is still a strict
improvement:

From: Sean Christopherson <seanjc@google.com>
Date: Wed, 30 Sep 2026 13:15:18 -0700
Subject: [PATCH] x86/pmu: Treat all AMD CPUs as having instruction/branch
 overcount errata

Apply the instructions and branches overcount errata to all AMD CPUs, which
count VMRUN as a retired branch instruction in guest context.  I.e. any
asynchronous #VMEXITs during any measurement will result in an overcount.

Reported-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 lib/x86/pmu.c | 7 +++++++
 x86/pmu.c     | 7 +------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/lib/x86/pmu.c b/lib/x86/pmu.c
index 67f3b23e..3231ce2d 100644
--- a/lib/x86/pmu.c
+++ b/lib/x86/pmu.c
@@ -72,6 +72,13 @@ void pmu_init(void)
 			pmu.msr_global_status_clr = MSR_CORE_PERF_GLOBAL_OVF_CTRL;
 		}
 	} else {
+		/*
+		 * All AMD CPUs overcount instructions and branches retired, as
+		 * they count VMRUN as a branch instruction in guest context.
+		 */
+		pmu.errata.instructions_retired_overcount = true;
+		pmu.errata.branches_retired_overcount = true;
+
 		if (this_cpu_has(X86_FEATURE_PERFCTR_CORE)) {
 			/* Performance Monitoring Version 2 Supported */
 			if (this_cpu_has(X86_FEATURE_AMD_PMU_V2)) {
diff --git a/x86/pmu.c b/x86/pmu.c
index b262ea59..35f8a818 100644
--- a/x86/pmu.c
+++ b/x86/pmu.c
@@ -222,13 +222,8 @@ static void adjust_events_range(struct pmu_event *gp_events,
 	 * If HW supports GLOBAL_CTRL MSR, enabling and disabling PMCs are
 	 * moved in __precise_loop(). Thus, instructions and branches events
 	 * can be verified against a precise count instead of a rough range.
-	 *
-	 * Skip the precise checks on AMD, as AMD CPUs count VMRUN as a branch
-	 * instruction in guest context, which* leads to intermittent failures
-	 * as the counts will vary depending on how many asynchronous VM-Exits
-	 * occur while running the measured code, e.g. if the host takes IRQs.
 	 */
-	if (pmu.is_intel && this_cpu_has_perf_global_ctrl()) {
+	if (this_cpu_has_perf_global_ctrl()) {
 		if (!pmu.errata.instructions_retired_overcount) {
 			gp_events[instruction_idx].min = LOOP_INSNS;
 			gp_events[instruction_idx].max = LOOP_INSNS;

base-commit: eae36be65d135b609f22ca72c6ad836f5c2e2699
-- 
