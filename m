Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC584963A2
	for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 23:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790377213; cv=none; b=pYlVwxN46y+iC7bVGzDZYagvDCCGS/AYT2XUcbTI08bAMdxKGjb7hl2mE6OAAHYYfNJ9DgnRI2NzjJJoCy2I2692DN06XXWmHhlHFcSWml71pfE2t3lwWrNtFgey9v5Ay00ryenE7McHZGCk75MM6pIo32UKIROfSvcNChbQ6cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790377213; c=relaxed/simple;
	bh=KLYnAr2ZjoTNfUfOdzt5B2wfJoSC1Ce2lv77K86DbRE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UEhffyMxxlKTddJDuvjswhwh3SiqF3zvesULRdbDIWewcuarzfPksUUl6zN/+LxffTo7YoQOOE9tmjJlWQplJX7VCm1VN5kp9h84aXpfWTub7qyBXafhgJOVLzLVPgjT6mlv73DW37btjYaCRyt8TxU5hNDdyzCQGRx8LLbMzSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lD24qLrL; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lD24qLrL"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2db3b126c9fso12594025ad.0
        for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 16:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790377211; x=1790982011; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=K4ExrwxCN1Rhw9vEP5GSHpMASb+C+XiRmH5TqttK57E=;
        b=lD24qLrL9+52Ld29vbB53ofNDJObCfySSXmJrotDSNb/eA+GxRO2IEU4qHpT1S7eeG
         bVL5SIpbyPQpCubXqFpmjxeZiVgNBOYKBaSAs4mVqHJCs74943WrEe7Ja6lG/o1Y/Z4g
         kcPfJpZD7r0j4BeMM+4AL9PUNOO5OwGMywWuoQq+S0OGNB84d9lt0BqVFT9yTX5BkHT3
         ivI9A1JGnBMXcmx8ZovyvVl55k8cPklejt6NWN8u0faamzY0ciFXa5BS0tt5Vfk1ETKx
         5buvNVNj2FBf2pnA7/Yde7C4ULsZQ/9PWVfQ0q3mi8Qe2Ak3YRs3ZkSyTQgd90E+skX7
         n4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790377211; x=1790982011;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K4ExrwxCN1Rhw9vEP5GSHpMASb+C+XiRmH5TqttK57E=;
        b=wmFkYD+cewAWVmYPhpVp77oSsG5Vnt+HjH/rh0dxehl6RJkJ9p4wfnSDuBD7GLN0xN
         sJoQetQpgiTolLumQnrpxV/Un97rihAcPMPEMnvjTlUy4zLT2dEQPGzD3foGK9UWy+GK
         m4sV3xoim49Y6AL2b44qycXwWgWbGBKUMHOWOyGyI2z5QUcv1jzkM/rOERD5eP+ULd7p
         xNpqsbCl+li+fVcFcgs+mVwS21C2Cn+265nIjC5z6vUIvmyEUWRpwfUkmxGhAcQbxr+X
         LfKvj2HdEWgFADGTMKqm4t3aBq51BXyYTjcUelV8p337KdcndKqibt25zJfdP/D1jVnX
         rztw==
X-Gm-Message-State: AFuF++nSlmE782WCqsj4M/AG0cmzx7GcU5t0u8ALR1CC2fIkFOeq7BGX
	xZwKucJBCaWStcnJITTrw93yERpQZs7tYw52/uPF3wkbJe9YEVvJgK3Bd35ZISdMz2Aq4ePtsLL
	c/dYY8Q==
X-Received: from plaw11.prod.google.com ([2002:a17:902:c78b:b0:2df:a6e9:13f6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1447:b0:2dd:c053:ec73
 with SMTP id d9443c01a7336-2df7e11ad13mr52399645ad.38.1790377210371; Fri, 25
 Sep 2026 16:00:10 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 25 Sep 2026 16:00:03 -0700
In-Reply-To: <20260925230003.2362261-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260925230003.2362261-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260925230003.2362261-5-seanjc@google.com>
Subject: [kvm-unit-tests PATCH 4/4] x86/debug: Add actual test coverage for
 Bus Lock Detect #DBs
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Extend the debug test to verify that bus locks to atomic accesses that
split cache lines actually trigger Bus Lock Detect #DBs, while still
allowing the access to go through.  Note, as already commented in the
test, Bus Lock Detect only applies to CPL>0.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 x86/debug.c | 48 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/x86/debug.c b/x86/debug.c
index 5427797f..d359a281 100644
--- a/x86/debug.c
+++ b/x86/debug.c
@@ -429,30 +429,60 @@ static noinline uint64_t bus_lock(uint64_t magic)
 	return READ_ONCE(*(uint64_t *)val);
 }
 
-static void bus_lock_test(void)
+static void bus_lock_test(u64 debugctl)
 {
 	const uint64_t magic = 0xdeadbeefdeadbeefull;
-	bool bus_lock_db = false;
 	uint64_t val;
+	bool ign;
+
+	if (debugctl & DEBUGCTLMSR_BUS_LOCK_DETECT)
+		report_fail("DEBUGCTL.BUS_LOCK_DETECT should be '0' at RESET");
 
 	/*
 	 * Generate a bus lock (via a locked access that splits cache lines)
 	 * in CPL0 and again in CPL3 (Bus Lock Detect only affects CPL3), and
 	 * verify that no #AC or #DB is generated (the relevant features are
-	 * not enabled).
+	 * not yet enabled).
 	 */
 	val = bus_lock(magic);
 	report(!got_ac && !n && val == magic,
 	       "CPL0 Split Lock #AC = %u (#DB = %u), val = %lx (wanted %lx)",
 	       got_ac, n, val, magic);
 
-	val = run_in_user((usermode_func)bus_lock, DB_VECTOR, magic, 0, 0, 0, &bus_lock_db);
-	report(!bus_lock_db && val == magic,
-	       "CPL3 Bus Lock #DB = %u, val = %lx (wanted %lx)",
-	       bus_lock_db, val, magic);
+	val = run_in_user((usermode_func)bus_lock, GP_VECTOR, magic, 0, 0, 0, &ign);
+	report(!got_ac && !n && val == magic,
+	       "CPL3 Bus Lock #AC = %u, #DB = %u, val = %lx (wanted %lx)",
+	       got_ac, n, val, magic);
 
-	n = 0;
 	got_ac = false;
+
+	if (!this_cpu_has(X86_FEATURE_BUS_LOCK_DETECT))
+		return;
+
+	wrmsr(MSR_IA32_DEBUGCTLMSR, debugctl | DEBUGCTLMSR_BUS_LOCK_DETECT);
+
+	val = bus_lock(magic);
+	report(!got_ac && !n && val == magic,
+		"CPL0 Split Lock shouldn't trigger Bus Lock Detect: #DB = %u, #AC = %u, val = %lx (wanted %lx)",
+		n, got_ac, val, magic);
+
+	val = run_in_user((usermode_func)bus_lock, GP_VECTOR, magic, 0, 0, 0, &ign);
+	report(n == 1 && !(dr6[0] & DR6_BUS_LOCK) && val == magic && !got_ac,
+		"CPL3 Bus Lock Detect #DB (nr #DBs = %u, DR6 = %lx, #AC = %u, val = %lx (wanted %lx))",
+		n, dr6[0], got_ac, val, magic);
+
+	n = 0;
+	write_dr7(DR7_FIXED_1 | DR7_GD);
+	write_dr7(DR7_FIXED_1);
+
+	/* Verify DR6.BLD is preserved on an unrelated #DB. */
+	report(n == 1 && !(dr6[0] & DR6_BUS_LOCK) && (dr6[0] & DR6_BD),
+		"DR6.BLD preserved on General Detect #DB (nr #DBs = %u, DR6 = %lx)",
+		n, dr6[0]);
+
+	n = 0;
+	write_dr6(dr6_control_value);
+	wrmsr(MSR_IA32_DEBUGCTLMSR, debugctl);
 }
 
 static void run_tests(unsigned long __dr6_control_value)
@@ -473,7 +503,7 @@ static void run_tests(unsigned long __dr6_control_value)
 	if (!this_cpu_has(X86_FEATURE_BUS_LOCK_DETECT))
 		dr6_base_value |= DR6_BUS_LOCK;
 
-	bus_lock_test();
+	bus_lock_test(debugctl);
 
 	/*
 	 * Enable Bus Lock Detect to workaround an AMD ucode bug where DR6.BLD
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

