Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5C93AA1B0
	for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 21:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776720023; cv=none; b=ML4z3jTd6HwOg46x3tZMnhmfoZe1m0MV54HD+bYhk+hWSuy27cYVafY38oL3Y/Z0AZdGzZTm+FeENIV9X6pHer8TPSUzevXOoEKurXYCO5T4MXAr6n444CvJh/XhNR+MloSHIl/b42aeYVsffjNEeQUPsZchT6ETPM9V3qGpQvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776720023; c=relaxed/simple;
	bh=aKTu2zQ9sqbrN3KSs4RghOXHomLpVFQ64vPLJKshjg4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=koIHD15h//g8RYuL2wJIH+gYj7waA6lWg5qeIZfCSyKMgxQZO3KcVMPh/jOMk202+Hz+wka07ZOvS1pZUef8qzPSSCYn05Us+1Fl/guoLs1Hc0Ix7jte6k155yAO64X6tT54zsiWBVb0SAFIZlE0q44PdXNEJGqyK4H/qWM7rEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vxS5UCFR; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vxS5UCFR"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c79798cd9b9so903936a12.2
        for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 14:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776720020; x=1777324820; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=wb4qOZehlu9qqoPxcG4skBDjLAAYxFlHWRfg5heAd7Y=;
        b=vxS5UCFR0/x8xr1DNfN9IgFjAOncHYb2CJt2UKHPm7Pcu5SLqOb0ymn4/YfLGtk0j5
         fBLaGLicEe/1nAQFh7mVQNPzSv0A8IXWrTMCmIZMv/7yE/ms7H1si++8EH6Ao9gUji6i
         A+t6fJKW6UJpFUlhex/4Poe8vsVJAMiJkAK7j+cUO5OvmTrHzHcunfVee2A9cijkgmMk
         AeYpYcyYOISexi/zX6b1It4PuUkVFf4I31y6CRphRMoLmY1QD2xbI+GxkSShRSq3gkT/
         qykVPUT+w9DSpPmZNpdXnxLY56c9o5rxksSLGgxs9G0xFDY0/3YGA+OdjqO6ozxSjt6q
         +eNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776720020; x=1777324820;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wb4qOZehlu9qqoPxcG4skBDjLAAYxFlHWRfg5heAd7Y=;
        b=ocVYFuRklHJ9An26cuPsppLuHjv0c41tKcECDsJFsGk3o0Ds35ujbuc2+zuDceW+5O
         A9Bfe9tmY7adOLtHrofVnw7qTiFa+xaBaYkPlwnj76rflra9CyzZ1vas3se1UvbIuw9D
         0SArc9JWxoUfbWxoK1g5EW1Lfe62Q4qJ/Xmn9/HfHP2K8U+iYBgtYQ1dCB+pDggCbz1c
         iaprAoL3QzWqUJuGQBqjHBaceCEIsgLX2Ry9UQltI3lPpFoa62s10/IfjVXVtf4332NS
         uaYc6l+4p8D75+YjFXgm9L6UuU8pnwv1UxOo7Cvup9GngR+HDhm02NWa01lgeCxIh/jF
         gPCA==
X-Gm-Message-State: AOJu0YzlprT7aFWZzXiIsABuL18VL5RBxPh41kEcB4oJeGq4RMrJteNA
	yozAN27MEqbOM2cPyKvdN75Mo6PSwpgCwOSF/3D9Hm5wRSUi4ZocKXsH6+oA+XvQNF/kptOgGKQ
	AAWW+Nw==
X-Received: from pfbfc25.prod.google.com ([2002:a05:6a00:2e19:b0:82f:98cb:c2a9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:14c2:b0:82f:44dc:f85c
 with SMTP id d2e1a72fcca58-82f8c8d6ac2mr15859883b3a.34.1776720019124; Mon, 20
 Apr 2026 14:20:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 20 Apr 2026 14:19:52 -0700
In-Reply-To: <20260420212004.3938325-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260420212004.3938325-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
Message-ID: <20260420212004.3938325-8-seanjc@google.com>
Subject: [PATCH v3 07/19] KVM: selftests: Use s32 instead of int32_t
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, loongarch@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Use s32 instead of int32_t to make the KVM selftests code more concise
and more similar to the kernel (since selftests are primarily developed
by kernel developers).

This commit was generated with the following command:

  git ls-files tools/testing/selftests/kvm | xargs sed -i 's/int32_t/s32/g'

Then by manually adjusting whitespace to make checkpatch.pl happy.

No functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../kvm/arm64/arch_timer_edge_cases.c         | 24 +++++++++----------
 .../selftests/kvm/include/arm64/arch_timer.h  |  4 ++--
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c b/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c
index f8b183f13864..f7625eb711d6 100644
--- a/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c
+++ b/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c
@@ -25,8 +25,8 @@
 /* Depends on counter width. */
 static u64 CVAL_MAX;
 /* tval is a signed 32-bit int. */
-static const int32_t TVAL_MAX = INT32_MAX;
-static const int32_t TVAL_MIN = INT32_MIN;
+static const s32 TVAL_MAX = INT32_MAX;
+static const s32 TVAL_MIN = INT32_MIN;
 
 /* After how much time we say there is no IRQ. */
 static const u32 TIMEOUT_NO_IRQ_US = 50000;
@@ -355,7 +355,7 @@ static void test_timer_cval(enum arch_timer timer, u64 cval,
 	test_timer_xval(timer, cval, TIMER_CVAL, wm, reset_state, reset_cnt);
 }
 
-static void test_timer_tval(enum arch_timer timer, int32_t tval,
+static void test_timer_tval(enum arch_timer timer, s32 tval,
 			    irq_wait_method_t wm, bool reset_state,
 			    u64 reset_cnt)
 {
@@ -385,10 +385,10 @@ static void test_cval_no_irq(enum arch_timer timer, u64 cval,
 	test_xval_check_no_irq(timer, cval, usec, TIMER_CVAL, wm);
 }
 
-static void test_tval_no_irq(enum arch_timer timer, int32_t tval, u64 usec,
+static void test_tval_no_irq(enum arch_timer timer, s32 tval, u64 usec,
 			     sleep_method_t wm)
 {
-	/* tval will be cast to an int32_t in test_xval_check_no_irq */
+	/* tval will be cast to an s32 in test_xval_check_no_irq */
 	test_xval_check_no_irq(timer, (u64)tval, usec, TIMER_TVAL, wm);
 }
 
@@ -463,7 +463,7 @@ static void test_timers_fired_multiple_times(enum arch_timer timer)
  * timeout for the wait: we use the wfi instruction.
  */
 static void test_reprogramming_timer(enum arch_timer timer, irq_wait_method_t wm,
-				     int32_t delta_1_ms, int32_t delta_2_ms)
+				     s32 delta_1_ms, s32 delta_2_ms)
 {
 	local_irq_disable();
 	reset_timer_state(timer, DEF_CNT);
@@ -504,7 +504,7 @@ static void test_reprogram_timers(enum arch_timer timer)
 
 static void test_basic_functionality(enum arch_timer timer)
 {
-	int32_t tval = (int32_t) msec_to_cycles(test_args.wait_ms);
+	s32 tval = (s32)msec_to_cycles(test_args.wait_ms);
 	u64 cval = DEF_CNT + msec_to_cycles(test_args.wait_ms);
 	int i;
 
@@ -685,7 +685,7 @@ static void test_set_cnt_after_xval_no_irq(enum arch_timer timer,
 }
 
 static void test_set_cnt_after_tval(enum arch_timer timer, u64 cnt_1,
-				    int32_t tval, u64 cnt_2,
+				    s32 tval, u64 cnt_2,
 				    irq_wait_method_t wm)
 {
 	test_set_cnt_after_xval(timer, cnt_1, tval, cnt_2, wm, TIMER_TVAL);
@@ -699,7 +699,7 @@ static void test_set_cnt_after_cval(enum arch_timer timer, u64 cnt_1,
 }
 
 static void test_set_cnt_after_tval_no_irq(enum arch_timer timer,
-					   u64 cnt_1, int32_t tval,
+					   u64 cnt_1, s32 tval,
 					   u64 cnt_2, sleep_method_t wm)
 {
 	test_set_cnt_after_xval_no_irq(timer, cnt_1, tval, cnt_2, wm,
@@ -718,7 +718,7 @@ static void test_set_cnt_after_cval_no_irq(enum arch_timer timer,
 static void test_move_counters_ahead_of_timers(enum arch_timer timer)
 {
 	int i;
-	int32_t tval;
+	s32 tval;
 
 	for (i = 0; i < ARRAY_SIZE(irq_wait_method); i++) {
 		irq_wait_method_t wm = irq_wait_method[i];
@@ -753,7 +753,7 @@ static void test_move_counters_behind_timers(enum arch_timer timer)
 
 static void test_timers_in_the_past(enum arch_timer timer)
 {
-	int32_t tval = -1 * (int32_t) msec_to_cycles(test_args.wait_ms);
+	s32 tval = -1 * (s32)msec_to_cycles(test_args.wait_ms);
 	u64 cval;
 	int i;
 
@@ -789,7 +789,7 @@ static void test_timers_in_the_past(enum arch_timer timer)
 
 static void test_long_timer_delays(enum arch_timer timer)
 {
-	int32_t tval = (int32_t) msec_to_cycles(test_args.long_wait_ms);
+	s32 tval = (s32)msec_to_cycles(test_args.long_wait_ms);
 	u64 cval = DEF_CNT + msec_to_cycles(test_args.long_wait_ms);
 	int i;
 
diff --git a/tools/testing/selftests/kvm/include/arm64/arch_timer.h b/tools/testing/selftests/kvm/include/arm64/arch_timer.h
index 4fe0e0d07584..a5836d4ab7ee 100644
--- a/tools/testing/selftests/kvm/include/arm64/arch_timer.h
+++ b/tools/testing/selftests/kvm/include/arm64/arch_timer.h
@@ -79,7 +79,7 @@ static inline u64 timer_get_cval(enum arch_timer timer)
 	return 0;
 }
 
-static inline void timer_set_tval(enum arch_timer timer, int32_t tval)
+static inline void timer_set_tval(enum arch_timer timer, s32 tval)
 {
 	switch (timer) {
 	case VIRTUAL:
@@ -95,7 +95,7 @@ static inline void timer_set_tval(enum arch_timer timer, int32_t tval)
 	isb();
 }
 
-static inline int32_t timer_get_tval(enum arch_timer timer)
+static inline s32 timer_get_tval(enum arch_timer timer)
 {
 	isb();
 	switch (timer) {
-- 
2.54.0.rc1.555.g9c883467ad-goog

