Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC8C51474F
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 19:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018067; cv=none; b=h75p4J5OtIIadAQCmovX5HXQTtNR/p5RLTr67FRXLcpCZcezo3ivO7u0AZwZqAv/zUuceoRp5iMm/MVIrq8vt9+iJqMMFlmnzRedFv1kiS9knMsOQn7R8N3Q7R5M53yGK4d76l6MWxFfIGkCcdVAcvLQEYks58rAkFxotpdBogU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018067; c=relaxed/simple;
	bh=hU/XPiRf5TR8e6mSa8j7gps2i6m8O9JzB2visVEuryM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HjhQhmgvrcOU2IQLIzjCnVS7Rj8WjHrkh4QMWAdiOvLeyOs3vPOEHA4LxrPn/4bD6G0FpgpUMG1FOb9K++0fLWyZ/axGNhV62LT8QPsgbFZzZMT28RDJCQmUPOwQ0aw3Jx2WvzVX37auNSmzqDOTYcijwcrl0jzBi30Xs8oD/jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tMJSo0/0; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tMJSo0/0"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ce7dff6253so1894505ad.1
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 12:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790018064; x=1790622864; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MkQGxc0VixaN79XNFVHmkgaPjE4FLOsATYzndUXUH5M=;
        b=tMJSo0/0UIiVVtnxani6Vjz+GEXS0HZfj87cK2KsxPwrUduhNahpSgc4SiWfVrIo6x
         MxpMDAoCm4XBwJaqD1gIqXhqRrG5AVbSZGoTrHpnyQAQb83qigl3lWnN/ged0kpDMaKk
         LnkRldJF9oCbo07HUGiFp8KvaoXblXDfHgfhff0/j24wZQDwbnKeZMxFwJPQC8t2ffvS
         2G8The1Xo6gJieK040EDC39IteNSyWTZll/SoWPDiANWO+hMNPfk2e8ZHlZIuwMyEt0V
         2KLbLMZkqBMJOOudpdpzHLggTkNi3uIGC/cJfNIIXsE5dvDEBFRba+p/ms7abvRTD1Ry
         7TAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790018064; x=1790622864;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MkQGxc0VixaN79XNFVHmkgaPjE4FLOsATYzndUXUH5M=;
        b=oTb043hioXyUzJ32ixju3JKVnO6pvkwZOUULlVzubn0WwSiTznPyUZxrKm6muj0Zw9
         2ceBH0YKh4GPu/StuAheJaD75Vw8b51Fxne6uOssfEUB/O05LADenbAMYA6UQfFhJ8Uv
         ySiicIcdzYoIsqJsktedXYHZMg3yi2x0sBfYXIP6+i5iV1SfQTvgXQHSXmgLlrvuG7Z4
         gfLAUyMJ9uPQSr0EFGXkXa7rcPM8se5SCUDONlAWadKCfsxTzC2GzEmRr1cShNA3Gmnc
         KRluZ5PnoGJUJsU5psqoFi2MoG/g26Em+UMwDFcu5OLnIlsFaGCjOjoYWx/1gvz4Q2r0
         wfMA==
X-Forwarded-Encrypted: i=1; AKwUvBxvIOFrXv4ioaFyGSz9mgfy/Ru5/YNCzr5L3DRD7NyxzOBGT4x03TbvsVxBcmawHHsCU1E=@vger.kernel.org
X-Gm-Message-State: AFuF++mw+I8w2hgam9Z9GH3vcm3HM3JIw3n+wDq6fyNh4sxPtyfZmXlG
	aCzQR4WQ5KieEdqOYQbW/X72DyGOvmI+iy14CgoZaQh1mMlMptT81urPox/J0tXFd0AC0k72qH1
	xt/woew==
X-Received: from pjbbd16.prod.google.com ([2002:a17:90b:b90:b0:3a0:5e07:c6cb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:57c8:b0:39e:6c68:fd8e
 with SMTP id 98e67ed59e1d1-3a066b6c58bmr365265a91.35.1790018063773; Mon, 21
 Sep 2026 12:14:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 12:14:11 -0700
In-Reply-To: <20260921191418.950933-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921191418.950933-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921191418.950933-4-seanjc@google.com>
Subject: [PATCH v4 03/10] perf/x86/intel: Don't context switch DS_AREA (and
 PEBS config) if PEBS is unused
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
index 3f8d4d037b4e..4905296d99a4 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5363,23 +5363,14 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
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
@@ -5406,6 +5397,26 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
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
2.55.0.1082.g2b9226bbc0-goog

