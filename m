Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D30E37A486;
	Fri, 21 Aug 2026 22:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787351457; cv=none; b=FP5xvGUz3V5lx14yZxrN6lsEEdq+jYzzksGrgzR0ISFF1wNFXpa2AISRH597Z1KUkwvWQbxuwFsTx1ejHYtVsnrQQYPvUTnzOsXqVTg7Ks/l5BoeKaqFqOdR6eiMtrYi14100feNn/AevHeZeN5KxR/R+0bQPxY41ZfrIov0ofY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787351457; c=relaxed/simple;
	bh=x7s4S6tXE724ocZxCyEPKCeATM1VJ5QifoY0CB1Tqsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4lckb7Rmz+9k0r3cT5gGXubbbLT4y8OYLqN6m4lF4U80z+5bRQCe3fIGWyG63bd3YPJ92hyBKs+vdwj1h3DxQMJfPslIqnkcbdMw23gpCPf1X0Trd5f+lx72nOK4XWjYl+oqvDYUTa0Cu6bVWowZLXkAOXARTxdZfamszSzaBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DQLRCmfN; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DQLRCmfN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787351452; x=1818887452;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x7s4S6tXE724ocZxCyEPKCeATM1VJ5QifoY0CB1Tqsk=;
  b=DQLRCmfNNO3HhCTLQubuRnsPcKLOI6beiE+5j0z8F55Ri22LgLuMJikk
   PnU6T5e9v9Uh4CtCXuNSSVAXo1YNzQ/pv/l2WxJIAzDfrlsx3VsI/IyPn
   ZquPTjh9xVRFgHu8P45NtANrJUFI6yTDyHcI6yKMrKUz9VIzNjGxy6MHL
   PEUmBhH99ZVkAKLvATF+NEcBL4JdnQ+QCEHqfXbfUdInFkhQbXnW9EwYl
   36h0xOWz5HUmuTLtTyWq7jEZy2LEGJ8GpRPGTu/U/lB4IKiMRLDw1Tvuz
   DfTW3VgoxBV5iNqpkgEm7aIu7+6JYUftqdK6Ep5NIzpvjb8H3OarvVblg
   w==;
X-CSE-ConnectionGUID: AQg41XL9SOaYtSPWg1dSGQ==
X-CSE-MsgGUID: eB4j0GX/SwqvmAETNrhBNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="88032594"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="88032594"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:30:47 -0700
X-CSE-ConnectionGUID: mO9kYJSyR4GEaMBQAraqyQ==
X-CSE-MsgGUID: Eg/uz8p9S8aSlw4c1DpABQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="271679752"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:30:46 -0700
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
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH 07/23] perf/x86: Apply PMU partition mask on static constraints
Date: Fri, 21 Aug 2026 15:19:46 -0700
Message-ID: <20260821222002.54907-8-zide.chen@intel.com>
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

Static, counter-specific constraints used for attr.precise_ip == 3, or
other special cases bypass intel_get_event_constraints(), which is
where partition_mask is applied via dyn_constraint().

As a result, such a host !exclude_guest event can still be scheduled
onto a counter that partition_mask reserves for the guest, causing
host and guest to share the same hardware counter.

Some of these static constraint paths, e.g. glp or cmt, are currently
only reachable on platforms that don't support PerfMon masking. Still,
apply part_constraint() to all of them uniformly, so future platforms
that combine PerfMon masking with these constraint paths are not
silently exposed to this bug.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/events/intel/core.c | 39 +++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 7951accfcf2c..0f76e56fd2db 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4459,6 +4459,9 @@ dyn_constraint(struct cpu_hw_events *cpuc, struct event_constraint *c, int idx)
  * Mask out guest-owned counters from a constraint when PMU partition has been
  * entered, so !exclude_guest host events are not scheduled onto them while
  * the CPU is in non-root mode.
+ *
+ * This is also used by PMU-specific get_event_constraints() wrappers
+ * that hard-code a static, counter-specific constraint.
  */
 static struct event_constraint *
 part_constraint(struct cpu_hw_events *cpuc, int idx,
@@ -5568,7 +5571,7 @@ hsw_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 	/* Handle special quirk on in_tx_checkpointed only in counter 2 */
 	if (event->hw.config & HSW_IN_TX_CHECKPOINTED) {
 		if (c->idxmsk64 & (1U << 2))
-			return &counter2_constraint;
+			return part_constraint(cpuc, idx, event, &counter2_constraint);
 		return &emptyconstraint;
 	}
 
@@ -5585,7 +5588,7 @@ icl_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 	 */
 	if ((event->attr.precise_ip == 3) &&
 	    constraint_match(&fixed0_constraint, event->hw.config))
-		return &fixed0_constraint;
+		return part_constraint(cpuc, idx, event, &fixed0_constraint);
 
 	return hsw_get_event_constraints(cpuc, idx, event);
 }
@@ -5607,7 +5610,7 @@ glc_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 	if ((event->attr.precise_ip == 3) &&
 	    !constraint_match(&fixed0_constraint, event->hw.config)) {
 		if (c->idxmsk64 & BIT_ULL(0))
-			return &counter0_constraint;
+			return part_constraint(cpuc, idx, event, &counter0_constraint);
 
 		return &emptyconstraint;
 	}
@@ -5623,7 +5626,7 @@ glp_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 
 	/* :ppp means to do reduced skid PEBS which is PMC0 only. */
 	if (event->attr.precise_ip == 3)
-		return &counter0_constraint;
+		return part_constraint(cpuc, idx, event, &counter0_constraint);
 
 	c = intel_get_event_constraints(cpuc, idx, event);
 
@@ -5645,9 +5648,9 @@ tnt_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 	if (event->attr.precise_ip == 3) {
 		/* Force instruction:ppp on PMC0 and Fixed counter 0 */
 		if (constraint_match(&fixed0_constraint, event->hw.config))
-			return &fixed0_counter0_constraint;
+			return part_constraint(cpuc, idx, event, &fixed0_counter0_constraint);
 
-		return &counter0_constraint;
+		return part_constraint(cpuc, idx, event, &counter0_constraint);
 	}
 
 	return c;
@@ -5705,22 +5708,30 @@ cmt_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 	if (event->attr.precise_ip == 3) {
 		/* Force instruction:ppp on PMC0, 1 and Fixed counter 0 */
 		if (constraint_match(&fixed0_constraint, event->hw.config)) {
+			c = &fixed0_counter0_1_constraint;
+
 			/* The fixed counter 0 doesn't support LBR event logging. */
 			if (branch_sample_counters(event))
-				return &counter0_1_constraint;
-			else
-				return &fixed0_counter0_1_constraint;
+				c = &counter0_1_constraint;
+
+			return part_constraint(cpuc, idx, event, c);
 		}
 
 		switch (c->idxmsk64 & 0x3ull) {
 		case 0x1:
-			return &counter0_constraint;
+			c = &counter0_constraint;
+			break;
 		case 0x2:
-			return &counter1_constraint;
+			c = &counter1_constraint;
+			break;
 		case 0x3:
-			return &counter0_1_constraint;
+			c = &counter0_1_constraint;
+			break;
+		default:
+			c = &emptyconstraint;
+			break;
 		}
-		return &emptyconstraint;
+		return part_constraint(cpuc, idx, event, c);
 	}
 
 	return c;
@@ -5744,7 +5755,7 @@ rwc_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 		 */
 		if (event->attr.precise_ip == 3)
 			return &emptyconstraint;
-		return &counters_1_7_constraint;
+		return part_constraint(cpuc, idx, event, &counters_1_7_constraint);
 	}
 
 	return c;
-- 
2.55.0

