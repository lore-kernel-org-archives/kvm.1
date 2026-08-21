Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE3A377023;
	Fri, 21 Aug 2026 22:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787351462; cv=none; b=jYkP3x2/YrZ6ujc4GPKlREc8eBDQtMcqHCGRiVZ02ocGRASgrNf+SzBGBVr+LBhohpAtOQN/Dx/XVQOU/wauj0gQ3C2/yjJKqj6Dk96hwP/0LdrL0e9zTEebjbZyDK/w73+MfD8jZFTdkub34ubUYbjpg0cnyXpXKTdWd4ErHsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787351462; c=relaxed/simple;
	bh=qoV8JelrcrhQSafwCgpk6TmotTeaLggHi0qKa12KdTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ctvBcVW4+oFLoBrW05QZNKJ6WLibQP8mOWLyZTZyC9oCKCBAsC56PzajeynI3LHOAQLhRKoFNgowIdPiCNV2BfGOC5C3MxHE0oI2WJKhROmKr03qOt6qvE0gNsvydh86rzqGQRuBxLAOiGJEisj6dGqUNFcFad1EmVYqlWOs9+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eaggf1/J; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eaggf1/J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787351457; x=1818887457;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qoV8JelrcrhQSafwCgpk6TmotTeaLggHi0qKa12KdTY=;
  b=eaggf1/JEvd5C2BdgGW7No1pVfuW9TOsyM1Wo7NdgiKMvsBIdOkN46LX
   NdC/LjNP0bSn/aWAmAMd4DlQdOCGoAy5fORX2Gltb1xPXEOxrs75zi7Kb
   byu7VsQqiuUVFTA3Tnnf+HCr7pozdqvJrOX6ZgMCrayA+dRRSlxTjXlxR
   4BAv5mRRJmh2BXzq30KRQLeqJ4H0gX+UoCCqL94dfKkFKkVJD5Ewh8sUd
   9a7YJ6dzVF1jjdPrZ+Sg4dCf7mMFl4sHnAHrZXKgk2Bp81yqU9nuiNO9Z
   CZUhmCdzCl+xcVqn2GzX4bogH6wVMU75vkG8Nf9uphSv3QBdIDulq7PYz
   Q==;
X-CSE-ConnectionGUID: 6MD/X2SVSKK5y5IgkisMhA==
X-CSE-MsgGUID: VPLVM2rlR6Op4yslZaTVKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="88032605"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="88032605"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:30:48 -0700
X-CSE-ConnectionGUID: jJsIaT8+RHawiFftuG4CBQ==
X-CSE-MsgGUID: A5JPNWIOTauG/Zet8FEd8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="271679760"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:30:47 -0700
From: Zide Chen <zide.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>,
	Jim Mattson <jmattson@google.com>,
	Stephane Eranian <eranian@google.com>,
	linux-kernel@vger.kernel.org,
	Mingwei Zhang <mizhang@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Das Sandipan <Sandipan.Das@amd.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 09/23] perf: Skip exclude_guest events on PMU partitioned counters
Date: Fri, 21 Aug 2026 15:19:48 -0700
Message-ID: <20260821222002.54907-10-zide.chen@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821222002.54907-1-zide.chen@intel.com>
References: <20260821222002.54907-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Without PMU partitioning, a PMU with PERF_PMU_CAP_MEDIATED_VPMU blocks
host event scheduling while the guest PMU context is loaded.

When PMU partitioning is enabled, host-owned counters remain available.
Skip exclude_guest events, but continue to allow other events to be
scheduled on the remaining host-owned counters.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Co-developed-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 kernel/events/core.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 9ce27cd83e04..23375f8d2261 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4105,6 +4105,32 @@ struct merge_sched_data {
 	enum event_type_t event_type;
 };
 
+static bool
+perf_mediated_pmu_skip_event(struct perf_event *event, enum event_type_t event_type)
+{
+	if (event->pmu_ctx->pmu->capabilities & PERF_PMU_CAP_PMU_PARTITION) {
+		/*
+		 * EVENT_GUEST && !guest_ctx_loaded: perf_load_guest_context()
+		 * reschedules !exclude_guest events.
+		 *
+		 * !EVENT_GUEST && guest_ctx_loaded: Guest context loaded.
+		 */
+		if (event->attr.exclude_guest &&
+		    !!(event_type & EVENT_GUEST) != is_guest_mediated_pmu_loaded())
+			return true;
+	} else {
+		/*
+		 * Don't schedule in any host events because no counters
+		 * are available.
+		 */
+		if (!(event_type & EVENT_GUEST) &&
+		    is_guest_mediated_pmu_loaded())
+			return true;
+	}
+
+	return false;
+}
+
 static int merge_sched_in(struct perf_event *event, void *data)
 {
 	struct perf_event_context *ctx = event->ctx;
@@ -4116,13 +4142,8 @@ static int merge_sched_in(struct perf_event *event, void *data)
 	if (!event_filter_match(event))
 		return 0;
 
-	/*
-	 * Don't schedule in any host events from PMU with
-	 * PERF_PMU_CAP_MEDIATED_VPMU, while a guest is running.
-	 */
-	if (is_guest_mediated_pmu_loaded() &&
-	    event->pmu_ctx->pmu->capabilities & PERF_PMU_CAP_MEDIATED_VPMU &&
-	    !(msd->event_type & EVENT_GUEST))
+	if ((event->pmu_ctx->pmu->capabilities & PERF_PMU_CAP_MEDIATED_VPMU) &&
+	    perf_mediated_pmu_skip_event(event, msd->event_type))
 		return 0;
 
 	if (group_can_go_on(event, msd->can_add_hw)) {
-- 
2.55.0

