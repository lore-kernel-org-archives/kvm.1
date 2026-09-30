Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BA02D3A75
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 21:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790802126; cv=none; b=t2QdoU421qJE1iLSK7JimrnnRsnkk027MP0PsLBekHawIBNyyWZ+rvLgp/gMUFjHkvpd0GNAaL6q7uNDCzr+1gKGp0koO5cewj2pgWXe84iP/ItkeJiM7h87Us7s8lLMdHfnFkEk1EPXwVlmjXTgw4Cyaq7dbteMvIPpBwgaqf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790802126; c=relaxed/simple;
	bh=5tDNiHQlIXO0VTaAZuhrbF+7Wk94q0+Ax3q1B06/5T4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DbaF0P5KL+hWMJITd5/8MW092281K37A+z7u21Yh5EEex0aYjIZ2CHTWwkoHApu8acQm/ri4zNgbR5adEkM1EH9p/n+JMYVlnbFu8OFoYGU1KOe1cngDlxxJdV8eeewbhkSOnPP8u2rlBAh3gS4G3j9WBpmXaPTHnSciHG8i0yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CJ7RcmMz; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CJ7RcmMz"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-882776aae15so3189723b3a.2
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 14:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790802124; x=1791406924; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P58W6iAq7OkV6MfhJh5TA/2PljEfSOOqSyRa/aiE9e0=;
        b=CJ7RcmMz/69XiQ84SIkCrlQ/Yy98ioKXhGErTzzgzfD1SPY9pV1S5m9JFfPBO7KqTX
         fdJqpsbkuIDSTdP7XFncK2IWnTvZJRIm5RSKYo26UxHWz4ZYnGh18wP5pv5opfX7H74s
         oq+0k9onNdADwLOOLPVTb2oWvizyjDbJcizWlA9baSrhsI3UrU3NTo92F88zR5LNAVtf
         xc+zHAMra2WRXq4VzlAwKthSw7PALK9Ie6L0eanpo+uK1oPWB7Zz3wyQWMck/u4lZ2Au
         jkMYmzZqBXHBd69SHmUVqtC/2gSCugr86Z6dBXTuet+QGtT+lI0F8+nDNDRZ64Vf5iec
         W2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790802124; x=1791406924;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=P58W6iAq7OkV6MfhJh5TA/2PljEfSOOqSyRa/aiE9e0=;
        b=qujcs0rwNjX4ezgSdYdVxM2SMxtEjZdJz5/VbgQRNOrYj1/gEdEO0tG+D360BhSbco
         UWR7+FwO/pQ3A6kXGRRA0m35osBdeVwCEMbjlUxzXswa+NFzs1nQ5Gd5kqe5c+hnJRI7
         RFTgyGcI492/gG1ETKYxObSLH5pqppOEMadzXiMK1y2PLWQASHo1TuApwqJzJAsNBm8J
         eJAnTnmN7GoCySjy8dguIfWbXdRStK/Tl0rKZQ383No0TCH6ivVG5GNx1mzJhFKdW4SS
         9TO65jMbS1ytA/L/tPY6LGxbLECcXhQiVFVAckdkF61KDJEbcGR0knzn2AelrLDI6fsv
         PCaw==
X-Gm-Message-State: AFuF++mLX4120ufhKhuaI1OcXvztA3v2weXo4n0iKisD5p10NLags0X3
	mxLV/yNlbbwXo649SnQaTwwZiEzLTHkvra6jdLS/tThxfePjFyuo6dxu9vS2lIHZitsY3GFij4b
	PXg3YCg==
X-Received: from pgbcq1.prod.google.com ([2002:a05:6a02:4081:b0:cc7:aca2:c288])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9218:b0:3de:5ce4:9e55
 with SMTP id adf61e73a8af0-3de9e8e0dc0mr2821748637.59.1790802122870; Wed, 30
 Sep 2026 14:02:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 30 Sep 2026 14:02:01 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930210201.3482775-1-seanjc@google.com>
Subject: [kvm-unit-tests PATCH] x86/pmu: Treat all AMD CPUs as having
 instruction/branch overcount errata
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Sandipan Das <sandipan.das@amd.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

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

base-commit: 5a221342a025948fa7d84f0c404748f6ba57f3ad
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

