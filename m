Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACBB515896
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 19:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018069; cv=none; b=GsUwzrGlI/pB5USgskeOGUgO7Ko3eh0qWQx4wI4x7abYhmfNNeXgOpMvy1NXz+/fY13yO+byXsNk+yKvYMvT3AfsBkVM0KbW9IFJWraXwmEDPOXvzJAc0NdPv3a88LPYMVTRH76rx9YAXwE/FdKZF8TeKePCNZBRtn9FkOTVe8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018069; c=relaxed/simple;
	bh=ncoF0AVlXK+3iude8CPxQjaZi5GdYEtcRxqS+Pzv5U8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a7a38oVYYF4AykWpTBqfTT98EBBSNj61uP0ZFuPUynzoinxlDeYa0Ivc38monO4/bUXLrjEnDnERwevOqpdFFVkAqjMvKiNYr6sfK/Zi+4IoZ8ZIT9a5ikB4dJB1hdb0xvc7S/oWz0n96USUJrraBkTmrtvd3VdK3EFMPOSYNII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aSTH0m41; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aSTH0m41"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8645a62066dso5276705b3a.0
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 12:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790018066; x=1790622866; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7RbJsXVhnh/ZoIjL3bVMfLEoE54gbAhQWsF1SSmQUH0=;
        b=aSTH0m41K99/i0hCc+SMNHc7g/xH2jwyeoJAtFPKVvpT4wKpOBz3SDRzl5JYS303SV
         0+ok6drbBBrLjKjpu9p/Fq8SpHhW1oJVUDoQJZzMAayQEYIusBhpr0ObeMa2m0L0z6Gp
         ghS+KEi8KDjRPPneKcBrnrRe+Ep/RfHePI3lPrrY4Nu034OGh155K1zmetCL3YHmoRzK
         LLrQnB+fA+/sogFVzF1P+wewOQkfuAd3PPzG8eQwvnhW6TkMIsiTgqphogCnCVqBGetB
         yolx3xUAWa5MPGTBcRTcV/8ODnHVW4xnqbN29MInGUfM+GFArJmBWYOIAdFiXVAe0nH5
         VZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790018066; x=1790622866;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7RbJsXVhnh/ZoIjL3bVMfLEoE54gbAhQWsF1SSmQUH0=;
        b=ImjtH+s9T9J/mkle2vbOyCtKl7lIpv/60BTSv0NwaOFjtdPHQTUX1kyrhVpCxA9izh
         m+1Fhf+CZCP0JNoZjiuzVAofx2H7y3+qFw2AuDD+Lr3dLDiS5/1YSIUOZyxvtXpPXf3P
         zZ3AqERqvkL54w20rMoUcmXJYJn0XSKNxEtq/pOEZx5dQkEaZDBsM271eFDl+/LEmM/u
         Hn9SAYjq4i6eGKbD6V5WSWq3fpS74f1Yye80IaOJMN94MCPkdEjhBQ8A6BMrFOMjeJgM
         GGNuj+JZuLbBA1k+1k1o88goWEnjqNajKI1QTR00Vfic7GxsL5fVZxMT8HxZ6rH24A86
         fbeQ==
X-Forwarded-Encrypted: i=1; AKwUvBxDGDGUbHAHoS+BBFcpd8EHtUuun4r6wW3bUsEdze3sBXh7zLc0rb3Qb8L5KUJfKLXlzc0=@vger.kernel.org
X-Gm-Message-State: AFuF++knLHdE9ubY2RaTFBSpCJvVDUBGHQjv6FqqUBpgKaOjYLrSJ6Wq
	j93PLJf958wxfwr0ujnHlmvsBnWGW+Hdm9z3C7KWsGW67x8rV9X6XJmpx79wg1gg7XWWhN3+3bi
	VRRbCIg==
X-Received: from pgdj29.prod.google.com ([2002:a05:6a02:521d:b0:cc4:b575:5b04])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ad08:b0:874:705d:f652
 with SMTP id d2e1a72fcca58-874dea02e76mr15115482b3a.32.1790018066169; Mon, 21
 Sep 2026 12:14:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 12:14:13 -0700
In-Reply-To: <20260921191418.950933-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921191418.950933-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921191418.950933-6-seanjc@google.com>
Subject: [PATCH v4 05/10] perf/x86/intel: Invert names of intel_ctrl_{guest,host}_mask
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

Rename intel_ctrl_{guest,host}_mask to intel_ctrl_exclude_{host,guest}_mask
to more accurately capture what they actually track.  Specifically, an
event that is excluded from the guest is NOT guaranteed to count in the
host, and vice versa, as it legal (albeit bizarre) to configure an event to
exclude both the host and the guest, i.e. to not count at all.

Subjectively (though anyone who disagrees is wrong), aligning with
perf_event_attr.exclude_{guest,host} also makes all related code much
easier to follow.

No functional change intended.

Suggested-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/intel/core.c | 22 +++++++++++-----------
 arch/x86/events/intel/lbr.c  |  2 +-
 arch/x86/events/perf_event.h |  4 ++--
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 0db55d90c3ca..859aba923a6a 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2787,7 +2787,7 @@ static void __intel_pmu_enable_all(int added, bool pmi)
 	}
 
 	wrmsrq(MSR_CORE_PERF_GLOBAL_CTRL,
-	       intel_ctrl & ~cpuc->intel_ctrl_guest_mask);
+	       intel_ctrl & ~cpuc->intel_ctrl_exclude_host_mask);
 
 	if (test_bit(INTEL_PMC_IDX_FIXED_BTS, cpuc->active_mask)) {
 		struct perf_event *event =
@@ -2985,9 +2985,9 @@ static inline void intel_set_masks(struct perf_event *event, int idx)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
 	if (event->attr.exclude_host)
-		__set_bit(idx, (unsigned long *)&cpuc->intel_ctrl_guest_mask);
+		__set_bit(idx, (unsigned long *)&cpuc->intel_ctrl_exclude_host_mask);
 	if (event->attr.exclude_guest)
-		__set_bit(idx, (unsigned long *)&cpuc->intel_ctrl_host_mask);
+		__set_bit(idx, (unsigned long *)&cpuc->intel_ctrl_exclude_guest_mask);
 	if (event_is_checkpointed(event))
 		__set_bit(idx, (unsigned long *)&cpuc->intel_cp_status);
 }
@@ -2996,8 +2996,8 @@ static inline void intel_clear_masks(struct perf_event *event, int idx)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
-	__clear_bit(idx, (unsigned long *)&cpuc->intel_ctrl_guest_mask);
-	__clear_bit(idx, (unsigned long *)&cpuc->intel_ctrl_host_mask);
+	__clear_bit(idx, (unsigned long *)&cpuc->intel_ctrl_exclude_host_mask);
+	__clear_bit(idx, (unsigned long *)&cpuc->intel_ctrl_exclude_guest_mask);
 	__clear_bit(idx, (unsigned long *)&cpuc->intel_cp_status);
 }
 
@@ -3779,7 +3779,7 @@ static int x86_pmu_handle_guest_pebs(struct pt_regs *regs,
 				     struct perf_sample_data *data)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	u64 guest_pebs_idxs = cpuc->pebs_enabled & ~cpuc->intel_ctrl_host_mask;
+	u64 guest_pebs_idxs = cpuc->pebs_enabled & ~cpuc->intel_ctrl_exclude_guest_mask;
 	struct perf_event *event = NULL;
 	int bit;
 
@@ -5339,8 +5339,8 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 	global_ctrl = (*nr)++;
 	arr[global_ctrl] = (struct perf_guest_switch_msr){
 		.msr = MSR_CORE_PERF_GLOBAL_CTRL,
-		.host = intel_ctrl & ~cpuc->intel_ctrl_guest_mask,
-		.guest = intel_ctrl & ~cpuc->intel_ctrl_host_mask & ~pebs_mask,
+		.host = intel_ctrl & ~cpuc->intel_ctrl_exclude_host_mask,
+		.guest = intel_ctrl & ~cpuc->intel_ctrl_exclude_guest_mask & ~pebs_mask,
 	};
 
 	if (!x86_pmu.ds_pebs)
@@ -5377,8 +5377,8 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 	 * in the guest, and (d) _are_ excluded from counting in the host.
 	 */
 	guest_pebs_mask = pebs_mask & intel_ctrl & kvm_pmu->pebs_enable &
-			  ~cpuc->intel_ctrl_host_mask &
-			  cpuc->intel_ctrl_guest_mask;
+			  ~cpuc->intel_ctrl_exclude_guest_mask &
+			  cpuc->intel_ctrl_exclude_host_mask;
 
 	/*
 	 * Disable counters where the guest PMC is different than the host PMC
@@ -5394,7 +5394,7 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 	 *        What exactly goes wrong if guest and host are using PEBS is
 	 *        unknown.
 	 */
-	if (pebs_mask & ~cpuc->intel_ctrl_guest_mask)
+	if (pebs_mask & ~cpuc->intel_ctrl_exclude_host_mask)
 		guest_pebs_mask = 0;
 
 	/*
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index cbe5c762008d..710292cf3f9b 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -714,7 +714,7 @@ static inline bool vlbr_exclude_host(void)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
 	return test_bit(INTEL_PMC_IDX_FIXED_VLBR,
-		(unsigned long *)&cpuc->intel_ctrl_guest_mask);
+		(unsigned long *)&cpuc->intel_ctrl_exclude_host_mask);
 }
 
 void intel_pmu_lbr_enable_all(bool pmi)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 0bc2fe486070..87733dd52846 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -540,8 +540,8 @@ struct cpu_hw_events {
 	/*
 	 * Intel host/guest exclude bits
 	 */
-	u64				intel_ctrl_guest_mask;
-	u64				intel_ctrl_host_mask;
+	u64				intel_ctrl_exclude_host_mask;
+	u64				intel_ctrl_exclude_guest_mask;
 	struct perf_guest_switch_msr	guest_switch_msrs[X86_PMC_IDX_MAX];
 
 	/*
-- 
2.55.0.1082.g2b9226bbc0-goog

