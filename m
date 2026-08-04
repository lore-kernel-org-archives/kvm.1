Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A9F42E8FB
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 20:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785876052; cv=none; b=QfLQykmhVwNXuGebVHeDZmC/9+pM5FKES+KGygoYvjQtNCRP2ZXiO1VqhosJ01f8I2UsFSHlNC5genzZTN+1/PiZEgyegrBu2ILugRWW7p5yGScB3jX+2w6Q/UHy+aT4mdkwlwgVAI9I3TByGlokuWST07+1jiH2TiDlc/jeHKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785876052; c=relaxed/simple;
	bh=cxsYu/SAZXKKH+qzPWN68EM5LaGATeu0vffi9KXr19s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=boGLd6nRLE1XkjcBI4rYdw/4rr8s5sNR/aOSv5lBm3Lb7HVnsj2JpI3ZLul/GEumfF6d3OrwLQERP8+tcuYQthJ5k88TZ+O5ZHJmh0V/fV9Jmi6EOBmnhMc3xl+LLdaPsz8GmwRtVSjBA6j/vb1XjYX6f1/1esoc7pYS1hd+EHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wBv080IC; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wBv080IC"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8484ba00601so295604b3a.1
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 13:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785876050; x=1786480850; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UeyWwtdawyJZ7yaU5xxuUItmJbT+/6l6O65XfniG79w=;
        b=wBv080ICfxkTdbI3I707uiT6rLVXYk76k15lBigKnvvNjHPrejijFWTG1BtsjPaJzW
         G5C5G6znF7GWOeiZsnICqHuJjTmAdkfTFiBZLsv9f3uaIRTvno/Xins0qf0kLBelg/4T
         nlXLyb9ySGJwQtDBpUyv3NiVWAM1wHDKqAhBZ5GP1XEzxMiRU1g95uEtmCpuWgEyJR7L
         c0iqYPVs7dK7dgiyljmPLnjWSb11WsEkQEzgBep+AdBSTBmczGgxDpu2xUWJKj+32/hb
         6oUCNotQCepojg6gllL+mdU6YSaMtHMLp0InU5aKYbuWLg1774O4Hyn9vW/Gydv5Y3/T
         QvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785876050; x=1786480850;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UeyWwtdawyJZ7yaU5xxuUItmJbT+/6l6O65XfniG79w=;
        b=duWzFz2xs8sKMv//qdAt4wtFnEzBMHRjhN8pmH55RXKBkSENe4f5NZNGVwoBw/b215
         ywgfQXPt0qpeRD91xvmB8ZcQexl97W0MX41l37D4MOHFw7GEDqNahyY+5KVtK0kckJZz
         jXVkamxxleNKAm9ByoCsTt4+ft7eFe0JRYqz6/r5g+mffh2JtHyHAdFmmeVO/dlqbP/k
         t+hJtmnhvyCA9ZfdKeoqwcZ/HIv6wh+9xhtfkdteJGki6M4LkFmLHIBe7yHaivdNX9Fa
         sXbASupi1Ty+H/bLvYwJAjeQ2pRD0iIsJWC+wVum72KGWQScVvqNdCbJG8KEZpBUxW/t
         yEOg==
X-Gm-Message-State: AOJu0YzPMOsCbVudspZVRPGOY34Y8ADICvYlclaYqiROOJxfnBocJkeB
	uXsYL0YT5Whn/6/ejTUJF7hIPnWP1E1e9HjldikVu2eXzxi2qDihRcxVWz8K6h6rF1jcmjpXJQy
	Dz/C19w==
X-Received: from pgvt1.prod.google.com ([2002:a65:64c1:0:b0:c9e:63b8:11b5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3cc6:b0:847:9267:2104
 with SMTP id d2e1a72fcca58-84f2e031753mr1347845b3a.12.1785876050393; Tue, 04
 Aug 2026 13:40:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  4 Aug 2026 13:40:46 -0700
In-Reply-To: <20260804204048.3401810-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804204048.3401810-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804204048.3401810-2-seanjc@google.com>
Subject: [PATCH v2 1/2] KVM: selftests: Test one random GP counter in PMU arch
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

