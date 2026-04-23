Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1062B3630AE
	for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776956628; cv=none; b=anW0m+V5DGUUFsB776LETXYuKh/2eo1hE0TS19YO4ZQxruHqYIkzBe3M3okTUde/DI4ZHQKeuaGWqCZLWHfuZTg9xOrH1bPHQ8aeiP0z96afgCpADhlMBczQ7AWz5Sy8gkLNpFlwnHhr6QrwGBPEoXII4NvxPVEKau/MSNPDr54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776956628; c=relaxed/simple;
	bh=tqL2wS9SOcoEBt8mWJ2tMzb5vBN/09iIE7AsrQkocpg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kjMVx3/qlMh/OwDmPr9rKZqwINN54TGhgHgTZHpm0R8Cpy7xcVJ1kgptQ9S7IJohDW2TZEtXh9K0YXE1B02Fpbir1xkc6j0b5dZ/Lo8Bb5+Kj5t27GJbCqsJXWTipCEOhFi4hb7PhthdRbeWHQ6IJYuLUV/5niLvut7+ielSsQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tk5KFQLD; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tk5KFQLD"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c76cb2dce57so4112410a12.1
        for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 08:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776956625; x=1777561425; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=7CGRZKt5ZrmE9CmVLVQUqmlUNHSwTAQ9ApcqVFaaEIw=;
        b=Tk5KFQLDyizl0//jrKENXq2be85Iubw4I3aa6A+nbDEcspamFsr/HDSHZ76QCU5waV
         1BlVoX6KsL++Nlu+fh2MkMOn/EyMNR3HulskT3jssG8z+dWD9M9T618wSsoY6fkc9AdC
         Zt4XffcB9sSb/wb4JWJ0GE8Dkt+D/FRwdc5arsde8m3tyFcrCxk99syBFbunzy0/3DsP
         nqRTAzhfbu20Y3n8P4dVqjMVVtmftR8AVOnaPSdSZ9hsXHoyl4uibghI6Ky+LJMKj3eg
         QYhlenGyAXAPv5q5UN08zKLodnJeaVriQfMx1zf7RqryQGGbu8cuwryx24X8Pk1JEXqj
         JGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776956625; x=1777561425;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7CGRZKt5ZrmE9CmVLVQUqmlUNHSwTAQ9ApcqVFaaEIw=;
        b=EJXWpwu27P+ZPMNxKCr1iIX0Kk2lI5ffFq3VlIrV6j61NxHhvqmzEln2IYXE/kqwfn
         XtwTusTcETBpfg5sq04jjrCEFGmi/Jz+tY/VMZeAC/WdxfnZtIlTQRE9lJSfXmYycpql
         GjKcDEaJcTNNR7X2+tlPFkVppswDuq4sGSZc83naT/XGIpjC4WIDBztWyIXyTkZ2+K7u
         w9tm8H4iCNnf/DijkEj5Ph49xhDZKp09+TaLqaFtTW0z+ru9wJIBZ6boZtKwlpk1uwUO
         +NpuTGM5o8nMbWSnoJ1NDzvUR02CHClLnyePidIsQHefzYV83hlMmri9k7alkI1O0f0u
         x24g==
X-Forwarded-Encrypted: i=1; AFNElJ+iVuATUHorf8TvjTFkOeGPPxnB9zBcrKcKFQ5eC5mSPqWLa4R2tnLwR5ow4+uu5FIj2oI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDLa+ZiWbX5+rXyWTtd15hRgx84ygPztyZKR7Zpd1fP7Z+x7VD
	5gCgLE6Io+x3JaLMWwK6aZz3OjSV5bMwYwDFYRq2ETJ8iRIo44J28qVCAjXPXl81rwl5k1H7X5H
	8EpTxyw==
X-Received: from pfbll5.prod.google.com ([2002:a05:6a00:7285:b0:82f:9be8:3f2c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:88ca:0:b0:82c:d9d0:f482
 with SMTP id d2e1a72fcca58-82f8c976ff1mr29068441b3a.46.1776956625063; Thu, 23
 Apr 2026 08:03:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 23 Apr 2026 08:03:37 -0700
In-Reply-To: <20260423150340.463896-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423150340.463896-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260423150340.463896-2-seanjc@google.com>
Subject: [PATCH v2 1/4] perf/x86/intel: Don't write PEBS_ENABLED on
 host<=>guest xfers if CPU has isolation
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
*never* insert an entry for PEBS_ENABLED if the CPU properly isolates PEBS
events, in which case disabling counters via PERF_GLOBAL_CTRL is sufficient
to prevent unwanted PEBS events in the guest (or host).  Because perf loads
PEBS_ENABLE with the unfiltered cpu_hw_events.pebs_enabled, i.e. with both
host and guest masks, there is no need to load different values for the
guest versus host, perf+KVM can and should simply control which counters
are enabled/disabled via PERF_GLOBAL_CTRL.

Avoiding touching PEBS_ENABLED fixes a theorized bug where PEBS_ENABLED can
end up with "stuck" bits if a PEBS event is throttled better generating the
list and actually entering the guest (Intel CPUs can't arbtitrarily block
NMIs). And stating the obvious, leaving PEBS_ENABLED as-is avoids three MSR
writes on every VMX transition: one each on entry/exit, and one more
explicit WRMSR to zero PEBS_ENABLED before VM-Entry (KVM assumes the only
reason PEBS_ENABLED is in the load list is if the CPU lacks isolation and
thus needs a quiescent period).

Fixes: c59a1f106f5c ("KVM: x86/pmu: Add IA32_PEBS_ENABLE MSR emulation for extended PEBS")
Cc: Jim Mattson <jmattson@google.com>
Cc: Mingwei Zhang <mizhang@google.com>
Cc: Stephane Eranian <eranian@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/intel/core.c | 42 ++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 793335c3ce78..002d809f82ef 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4999,12 +4999,15 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 	struct kvm_pmu *kvm_pmu = (struct kvm_pmu *)data;
 	u64 intel_ctrl = hybrid(cpuc->pmu, intel_ctrl);
 	u64 pebs_mask = cpuc->pebs_enabled & x86_pmu.pebs_capable;
-	int global_ctrl, pebs_enable;
+	u64 guest_pebs_mask = pebs_mask & ~cpuc->intel_ctrl_host_mask;
+	int global_ctrl;
 
 	/*
 	 * In addition to obeying exclude_guest/exclude_host, remove bits being
 	 * used for PEBS when running a guest, because PEBS writes to virtual
-	 * addresses (not physical addresses).
+	 * addresses (not physical addresses).  If the guest wants to utilize
+	 * PEBS, and PEBS can safely enabled in the guest, bits for the guest's
+	 * PEBS-enabled counters will be OR'd back in as appropriate.
 	 */
 	*nr = 0;
 	global_ctrl = (*nr)++;
@@ -5051,24 +5054,25 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 		};
 	}
 
-	pebs_enable = (*nr)++;
-	arr[pebs_enable] = (struct perf_guest_switch_msr){
-		.msr = MSR_IA32_PEBS_ENABLE,
-		.host = cpuc->pebs_enabled & ~cpuc->intel_ctrl_guest_mask,
-		.guest = pebs_mask & ~cpuc->intel_ctrl_host_mask & kvm_pmu->pebs_enable,
-	};
-
-	if (arr[pebs_enable].host) {
-		/* Disable guest PEBS if host PEBS is enabled. */
-		arr[pebs_enable].guest = 0;
-	} else {
-		/* Disable guest PEBS thoroughly for cross-mapped PEBS counters. */
-		arr[pebs_enable].guest &= ~kvm_pmu->host_cross_mapped_mask;
-		arr[global_ctrl].guest &= ~kvm_pmu->host_cross_mapped_mask;
-		/* Set hw GLOBAL_CTRL bits for PEBS counter when it runs for guest */
-		arr[global_ctrl].guest |= arr[pebs_enable].guest;
-	}
+	/*
+	 * Disable counters where the guest PMC is different than the host PMC
+	 * being used on behalf of the guest, as the PEBS record includes
+	 * PERF_GLOBAL_STATUS, i.e. the guest will see overflow status for the
+	 * wrong counter(s).  Similarly, disallow PEBS in the guest if the host
+	 * is using PEBS, to avoid bleeding host state into PEBS records.
+	 */
+	guest_pebs_mask &= kvm_pmu->pebs_enable & ~kvm_pmu->host_cross_mapped_mask;
+	if (pebs_mask & ~cpuc->intel_ctrl_guest_mask)
+		guest_pebs_mask = 0;
 
+	/*
+	 * Do NOT mess with PEBS_ENABLED.  As above, disabling counters via
+	 * PERF_GLOBAL_CTRL is sufficient, and loading a stale PEBS_ENABLED,
+	 * e.g. on VM-Exit, can put the system in a bad state.  Simply enable
+	 * counters in PERF_GLOBAL_CTRL, as perf load PEBS_ENABLED with the
+	 * full value, i.e. perf *also* relies on PERF_GLOBAL_CTRL.
+	 */
+	arr[global_ctrl].guest |= guest_pebs_mask;
 	return arr;
 }
 
-- 
2.54.0.545.g6539524ca2-goog

