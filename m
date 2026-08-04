Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3D143C05D
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 21:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785877252; cv=none; b=BzvdoMnorRHwksWJpiqQd0ELRZXRyIy62ZGnpFjZ8bAkd0j3GeBNj7Bon1tcudgPMINtBWtvuDbis8OuedJBR/O1CGBXtyHEecbQJITdHHPU2GKtfBYj2RkR4mO9sXBzh6kkWHh0/CgBRyEl8Ki+Gppkh1Gw/AAoFp06lWBgGac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785877252; c=relaxed/simple;
	bh=cxsYu/SAZXKKH+qzPWN68EM5LaGATeu0vffi9KXr19s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PVaFbB83BbecV6zPUL0afLHjiMuU4WXzctxYFVgDcGSFHJXYz2YQgjYAlSBFxd0FOjPhPvKgL455embi2yvl4jLqfSKlNqm+YUnm4i7jRBJCCYDxEtgE74Xo4ID5QV+i4emdkc9aPJRJNvDL2EMTOUn5WmccvwXtPDyi/SivHhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IYUweXdH; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IYUweXdH"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8485b7e18b4so361182b3a.1
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 14:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785877250; x=1786482050; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UeyWwtdawyJZ7yaU5xxuUItmJbT+/6l6O65XfniG79w=;
        b=IYUweXdHYWSPRtxGr6juyRxIGuRlR49fgbWbYEwBPGxmUmcqBaxHJ77v9m/j8eFEr2
         pQDlBF/PKa0nu/0KOJT4ySqrgPiDh4L+fBQ3RHEbIYa0msUoUCNhUMq5SzIu+t9ddLCH
         2EgYZkTbdmDSvgK22X/AVRppTU1b6gQv45uJ8pxke0CAVwrohY+tZ2R0L0am6owB8v7D
         2uXEN5Lq9jPyxz2sSc/bwEb2hVyhP6ksDMv7QPlWJ6y0HBKKjJKJhi7rUoGt7AOmdBEz
         ppEgE+xfxwbho722dD9n2f60JfG1q/NOM3IAgXW8/pxaGu1/pRnJaQ+y9hDrUpfFDERU
         i2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785877250; x=1786482050;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UeyWwtdawyJZ7yaU5xxuUItmJbT+/6l6O65XfniG79w=;
        b=kqVzc8sKRRSVj+NssUMiY2o0bnLEpo818Ayw9p3YMQwCRDQHll7VRDJ1VNObinbFJZ
         BvWr7wOiZHywjpE6L233nj8MEknjfONV42+lSG/LmVyn/M1LE8oFgSGzYdf02NCD8ZGF
         r333i0fSUCLXNx6qtOt2XDfCG9brcmsnD426WloVhvsovPp02d9z7DbhYEbO9xfFC7lf
         U7Xs4TbRy+oAo4E0EDCoeV+13WWYgOkG5qbBNNyXcGL3IO1TS3A406qrD46uAa6p1aM3
         BTOAi38IH12MqDErvI65xqRPtjpZkl3YmdTcymStThV6OnYHaAHKXCFViVTlsw38Tg71
         D8cA==
X-Gm-Message-State: AOJu0Yxb0/vs+m5mgFahhZkk0QPodIDB0+ZRP+Vsn39a8tr5pV4XnAx/
	hRTEKQffJdu3YiXQS+xi/E4NtnLWLOIf1oC7zBCDiYAa/PuGn3L3qtCBW/0pK9v5/eu10LEXyYe
	vqvLPyQ==
X-Received: from pfx48.prod.google.com ([2002:a05:6a00:a470:b0:848:81e8:f2d9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3d54:b0:847:8b1d:230d
 with SMTP id d2e1a72fcca58-84f2e014151mr1449461b3a.3.1785877250032; Tue, 04
 Aug 2026 14:00:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  4 Aug 2026 14:00:45 -0700
In-Reply-To: <20260804210046.3413149-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804210046.3413149-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804210046.3413149-2-seanjc@google.com>
Subject: [PATCH v3 1/2] KVM: selftests: Test one random GP counter in PMU arch
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

