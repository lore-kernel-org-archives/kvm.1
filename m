Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC1238E8DC
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 17:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785864881; cv=none; b=CBfI/M3F0q9XDO9niBjm8s0eqGecHU3bt/5akfqckqf70/F7+BVMk1AZFMNeI+S6V/dtoIsqaSfOwAX8TaftIjqi/tlEQylBITHMXRIBl7pfu0CGJ9USK5/jschwbfz7zR+9jsqDgfKxIEpb6spUvswZ1VOu91a9QzYh2SyH/RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785864881; c=relaxed/simple;
	bh=cxsYu/SAZXKKH+qzPWN68EM5LaGATeu0vffi9KXr19s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tp9N2zBzNfVyylrN+Prx5AmCcdzXQaQgK9wlxmaeSc8s3NRZ2jGEC+E6/2xcjidiMxtBxIkWHIa0l3qZGrpdSYsAWYtvMITqE+xucqfpYS9Pw8Fkg5EEvAaH1h6QbIPydKQa1YwJdaB8VTExTft7rMOGWkP4iRfyz6e3D2z+3Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EW8OktRW; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EW8OktRW"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-ca860baea9fso40263a12.2
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 10:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785864880; x=1786469680; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UeyWwtdawyJZ7yaU5xxuUItmJbT+/6l6O65XfniG79w=;
        b=EW8OktRWc50uMj7y46lz26AsbdMSgNTjZ3c0FG+jNy3Fbn/S4ZBRVuNH+RxXYe2oJk
         Y+4jdE/XJEwu+SOr7WscN9pPIBJ1BWmerJy9w2lWIGxfjnfzqGc6n9FyaLmrwaaV4P00
         tlA5hYhTIcJnSGe8MPgBmjp1dZ2Gqaz3Nh6IxSRO5W7YEUpnjjDBK4r7Af6o1PkQSp30
         nGmibbbVx3V5qnf33Jy9r1O65UpibN5GRl5Q2pc3pvl2aUdYjzRn8gugwI8mbj1n9JmF
         2jgOQmkuLc+egHEiMT2m6rXkBDSrYDPR3g7iMdJgeaQFxBLg/G8jQWar4bILfdG3n1og
         4Q6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785864880; x=1786469680;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UeyWwtdawyJZ7yaU5xxuUItmJbT+/6l6O65XfniG79w=;
        b=gN62ULqK6Rl6PPaJQahbjnbnt6dVPBWQOicq4/DxsxKLw5fBASMt2cH/593jWHQ651
         4JJ2gFy46TRX4C3FTe9BFDujIOiHl1hxitpf1WEDOVX3pGFkHE2QIc4534lWFwoM89/m
         Ia/1p4WneL46HIUkyjKaamj/vmppVihu1EvadFYpW2h5dFq8K7b6gMdmkSMc8uLHU44z
         SmQidsfkEr0PClcKTf7Fpc32lwP5PgSJMWnSR1FoOpKyhSUqH86kATO67jFivxyHyjGn
         lzvAzVIFEHULo2mJy8RMdFqiPgqszmEO67bF0wcBqDcTXVoVOuG4NhLjAqHUP8coJaLj
         mwNg==
X-Gm-Message-State: AOJu0Yx5D8mXNS4wdSPg/wUI2XWo9PXZQ0oZhXKgJJcn5upXbtInqjzU
	P151xGYGlLp5KfADVUdYrb1b1WB7OQWRS9B24Ea2e3QDTLxP5OX7Xdd9wA1vBLrJVOje/opJGvm
	F6rYxhg==
X-Received: from pgbbw28.prod.google.com ([2002:a05:6a02:49c:b0:c8b:2b50:846b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:734b:b0:3b2:8685:1473
 with SMTP id adf61e73a8af0-3cb85dcb2efmr452352637.7.1785864879494; Tue, 04
 Aug 2026 10:34:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  4 Aug 2026 10:34:36 -0700
In-Reply-To: <20260804173437.3339269-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804173437.3339269-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804173437.3339269-2-seanjc@google.com>
Subject: [PATCH 1/2] KVM: selftests: Test one random GP counter in PMU arch
 events testcase
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

To significantly reduce the PMU counter test's runtime, without sacrificing
test coverage in the aggregate, test a random GP counter in the arch events
testcase instead of testing every possible GP counter.  Testing every PMC
in every run of the test significantly increases the runtime of the test,
without providing an equivalent increase in validation coverage, as the
odds of a KVM having a bug that only affected a subset of counters and only
when testing all other counters are extremely low.

Opportunistically clean up kvm_random_u64_in_range() to eliminate
unnecessary newlines.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/include/test_util.h |  4 ++--
 tools/testing/selftests/kvm/lib/test_util.c   | 22 +++++++++++++++----
 .../selftests/kvm/x86/pmu_counters_test.c     | 18 +++++++--------
 3 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index e8356ee54d7b..a6a3e1657895 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -135,8 +135,8 @@ static inline u64 kvm_random_u64(struct kvm_random_state *state)
 	return ((u64)kvm_random_u32(state) << 32) | kvm_random_u32(state);
 }
 
-u64 kvm_random_u64_in_range(struct kvm_random_state *state, u64 min,
-			    u64 max);
+u32 kvm_random_u32_in_range(struct kvm_random_state *state, u32 min, u32 max);
+u64 kvm_random_u64_in_range(struct kvm_random_state *state, u64 min, u64 max);
 
 enum vm_mem_backing_src_type {
 	VM_MEM_SRC_ANONYMOUS,
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index 6b00ab11f3c0..4dff72f6bd34 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -43,12 +43,26 @@ u32 kvm_random_u32(struct kvm_random_state *state)
 	return state->seed;
 }
 
+/* Returns a random u32 in the inclusive range [min, max] */
+u32 kvm_random_u32_in_range(struct kvm_random_state *state, u32 min, u32 max)
+{
+	u32 value, range;
+
+	TEST_ASSERT(min <= max, "PEBKAC, min = 0x%x, max = 0x%x", min, max);
+
+	value = kvm_random_u32(state);
+
+	range = max - min;
+	if (range == UINT_MAX)
+		return value;
+
+	return min + (value % (range + 1));
+}
+
 /* Returns a random u64 in the inclusive range [min, max] */
-u64 kvm_random_u64_in_range(struct kvm_random_state *state, u64 min,
-			    u64 max)
+u64 kvm_random_u64_in_range(struct kvm_random_state *state, u64 min, u64 max)
 {
-	u64 value;
-	u64 range;
+	u64 value, range;
 
 	TEST_ASSERT(min <= max, "PEBKAC, min = 0x%lx, max = 0x%lx", min, max);
 
diff --git a/tools/testing/selftests/kvm/x86/pmu_counters_test.c b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
index dc6afac3aa91..8abf17cc9469 100644
--- a/tools/testing/selftests/kvm/x86/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
@@ -273,6 +273,7 @@ static void guest_test_arch_event(u8 idx)
 	struct kvm_x86_pmu_feature gp_event, fixed_event;
 	u32 base_pmc_msr;
 	unsigned int i;
+	u64 eventsel;
 
 	/* The host side shouldn't invoke this without a guest PMU. */
 	GUEST_ASSERT(pmu_version);
@@ -287,19 +288,16 @@ static void guest_test_arch_event(u8 idx)
 	GUEST_ASSERT_EQ(idx, gp_event.f.bit);
 
 	GUEST_ASSERT(nr_gp_counters);
+	i = kvm_random_u32_in_range(&kvm_rng, 0, nr_gp_counters - 1);
 
-	for (i = 0; i < nr_gp_counters; i++) {
-		u64 eventsel = ARCH_PERFMON_EVENTSEL_OS |
-				    ARCH_PERFMON_EVENTSEL_ENABLE |
-				    intel_pmu_arch_events[idx];
+	eventsel = ARCH_PERFMON_EVENTSEL_OS | ARCH_PERFMON_EVENTSEL_ENABLE |
+		   intel_pmu_arch_events[idx];
 
-		wrmsr(MSR_P6_EVNTSEL0 + i, 0);
-		if (guest_has_perf_global_ctrl)
-			wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, BIT_ULL(i));
+	wrmsr(MSR_P6_EVNTSEL0 + i, 0);
+	if (guest_has_perf_global_ctrl)
+		wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, BIT_ULL(i));
 
-		__guest_test_arch_event(idx, i, base_pmc_msr + i,
-					MSR_P6_EVNTSEL0 + i, eventsel);
-	}
+	__guest_test_arch_event(idx, i, base_pmc_msr + i, MSR_P6_EVNTSEL0 + i, eventsel);
 
 	if (!guest_has_perf_global_ctrl)
 		return;
-- 
2.55.0.571.g244d577d93-goog

