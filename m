Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7003E9F82
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 13:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862955; cv=none; b=WgGIXT21YbNCWU09gOISc36YS1bJAg5bvfO/IrFhN/K1FPkNzA6W0aqfV2USkNvxbENETGCTRXEt5cNhL7yRMPGk76xA5On0cc59fhpfSreq11Sm8iCbl/HjFwBSus2wr51lpVyYPZ6c433N6bX7evNof05lvtYyvy+eRoFzIpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862955; c=relaxed/simple;
	bh=CG7LetbMCT5Ot5AplrnGeAX1eG1r+jUaq4xjGKgQESQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZFKlLNUbuNB1PW1fuNN6CAvoW6L1x8V1/3Q/5MZ09nUnBQ32twc5Ko9+XKoPm4zr8GcJFVewAWLvhG6roV8ktbkgWzui054waFvAPnetFJyArtEBCmlzEMkn/m0eXviH9giujNNSpo/9tcS65AHISMlSFb9dVc7wDK0L4yJkzGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XAtSYC4Y; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XAtSYC4Y"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso56315815e9.1
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 06:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776862952; x=1777467752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ChBMLZB7W3RWggGvPxQhi9T29Aee3H3wmNETcHJ/8uM=;
        b=XAtSYC4YTMq8Iz2xIwE2a7Iq+eV0NYAoAvRvo1+enXbUOUXxPdR94DL/3cxmlOmcFi
         Rxb3JVOd73sdOeR5nKvv+f/LO9KhDU8Y5bhgtAB4obxDH77kDmCv6J4UXC7Xwzn9OLpD
         liMghhvZyg1WKjoUP769Tydu64c0nBLVksJlyKyCE2dw5HeWWpWRx1+nNAm3HdgpigY2
         BILVijWbz1FCt+R1tXC6X7BUwaD5htr3ROfz6hzsmnMLn/jC/dk5c8SEEqM6bxByYwVO
         F/cE7ggdmYVN5H6EXpAzNd7xsZpakYoVYE3eKbclPX59aOp9GgjltdZ/XvMoizDn3UW/
         kvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776862952; x=1777467752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ChBMLZB7W3RWggGvPxQhi9T29Aee3H3wmNETcHJ/8uM=;
        b=hgA3WIbD1F99AqCB0/D9HSDfhTgb0L37fLl0jId5Zrc70NhuPS6O9TWQRPSvXZc7Qu
         FfnVY6LEbldgeltRwBHuXGV5hSCkTLOr6TjCeWkb4iEOVRpiVQTuoG3ZI3KRtAzBOgrm
         kbVseHFfsPpCqd+N4SBiSZL4gjOEl6vR0zj3jK4y2RbqNQbjH7/V3DjKdC4SFcvYEVrZ
         Y3yiqEKOFe5UiyRaHgxohyGDl5u3NHjLalQcSrmm8olc0bhLeuQrq0la5SPY6nAho9xc
         8sWVY5bYAvO+KZuwwZ5ENCc1Ph+QF63xJmMT7vxAZM2ZEoeOVh948svzXuj7l7KPMPaR
         ln+w==
X-Forwarded-Encrypted: i=1; AFNElJ8YaE9XCUBmDC7ZL9SvYBf4tq/aGvuUtF0Ow9haRS0SBDPHt58le+NGMyAUIIdDn3JiVNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsioZU/tKqO+lVMG0DstPZkizBC5xlbEEim7z0fmAZ59xsIXVM
	d0IeHA5kHZkAp88YqZZGgsDv257XIOKUy8s5xgUfj7WOEnAYhsdt4Xvwa98nOSlE9js=
X-Gm-Gg: AeBDieuVcM7xABEbCY+DjABjMlbI7kXlHShG8rFyfiFfjDqQDEKSzSvnh1UWqc9goiP
	HgYs2L13WX88S+p/nV4N89wcKclBPVtoV+WCq+X3oe5x/apAuu6a0NNV8Z/Ogs89e+daPRMsi4a
	Am3uD3Ooi2/l7xU5S//UbwJMn90aSuT7nJYk8Q9nEHlkDnLGudb0WFTwuNVPYmJZj56uc/5irMt
	vFr8ex/a+/siNT7ZIMcg9ExpFRCf8tKVBC9V9KI7vCZwnDNskvex4hydkQo+zAKlBKAa99Il/so
	Wsu6hQlTLvCV95amrcn8C9jz3ysITTjRS6IAd7lDP+5xJaVvXvTcyfQxUid8or2d0ro1BrKcwD7
	hCkqyHrobPyn03VhUanOtaNGZYYCYT1y1tPFY8K1Qy6dEB23IvmrxemoXrCTgfS2hzh6CjNziEP
	UwGfehBQmjHMc+3tFfhvSu9WfibSLmRbqGjJEs7zkTBvz2
X-Received: by 2002:a05:600c:4714:b0:48a:5574:3a5d with SMTP id 5b1f17b1804b1-48a55743e96mr105271025e9.7.1776862951984;
        Wed, 22 Apr 2026 06:02:31 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a575ad67asm96183315e9.2.2026.04.22.06.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 06:02:30 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 753D3617C4;
	Wed, 22 Apr 2026 13:52:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
	Alexander Graf <agraf@csgraf.de>,
	Peter Maydell <peter.maydell@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	kvm@vger.kernel.org,
	qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 30/32] target/arm: enable event stream on WFE instructions
Date: Wed, 22 Apr 2026 13:52:47 +0100
Message-ID: <20260422125250.1303100-31-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422125250.1303100-1-alex.bennee@linaro.org>
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Two generic timers (K and H) are capable of generating timer event
stream events. Provide a helper to calculate when the nearest one will
happen.

Now we can calculate when the next event stream event is we can re-use
the wfxt_timer and configure it to fire as we enter a WFE that is
going to sleep. Reverse the M-profile logic so we can enter a sleep
state in both profiles.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - merged target/arm: add gt_calc_next_event_stream
  - update to use halt_reason
  - made arm_wfxt_timer_cb atomically consume halt_reason
---
 target/arm/cpu.c           |  13 ++++
 target/arm/tcg/op_helper.c | 129 +++++++++++++++++++++++++++++++------
 2 files changed, 122 insertions(+), 20 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 124be8c401e..7a6ad45ae08 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -799,10 +799,23 @@ bool arm_cpu_exec_halt(CPUState *cs)
 }
 #endif
 
+/*
+ * Unlike almost everything else that messes with the halt_reason and
+ * event_register details the timer callbacks are not in the vCPU
+ * context.
+ *
+ * To prevent races we atomically consume a HALT_WFE and set the event
+ * register. Either way we trigger the an exit event.
+ */
 static void arm_wfxt_timer_cb(void *opaque)
 {
     ARMCPU *cpu = opaque;
     CPUState *cs = CPU(cpu);
+    CPUARMState *env = &cpu->env;
+
+    if (qatomic_cmpxchg(&env->halt_reason, HALT_WFE, NOT_HALTED)) {
+        qatomic_set(&env->event_register, true);
+    }
 
     /*
      * We expect the CPU to be halted; this will cause arm_cpu_is_work()
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 6a2be85fcaa..030209360e8 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -477,6 +477,97 @@ void HELPER(sev)(CPUARMState *env)
     arm_broadcast_event();
 }
 
+#ifndef CONFIG_USER_ONLY
+/*
+ * Event Stream events don't do anything apart from wake up sleeping
+ * cores. These helpers calculate the next event stream event time so
+ * the WFE helper can decide when its next wake up tick will be.
+ */
+static int64_t gt_recalc_one_evt(CPUARMState *env, uint32_t control, uint64_t offset)
+{
+    ARMCPU *cpu = env_archcpu(env);
+    bool evnten = FIELD_EX32(control, CNTxCTL, EVNTEN);
+
+    if (evnten) {
+        int evnti = FIELD_EX32(control, CNTxCTL, EVNTI);
+        bool evntis = FIELD_EX32(control, CNTxCTL, EVNTIS);
+        bool evntdir = FIELD_EX32(control, CNTxCTL, EVNTDIR);
+        /*
+         * To figure out when the next event timer should fire we need
+         * to calculate which bit of the counter we want to flip and
+         * which transition counts.
+         *
+         * So we calculate 1 << bit - current lower bits and then add
+         * 1 << bit if the bit needs to flip twice to meet evntdir
+         */
+        int bit = evntis ? evnti + 8 : evnti;
+        uint64_t count = gt_get_countervalue(env) - offset;
+        uint64_t target_bit = BIT_ULL(bit);
+        uint64_t lower_bits = MAKE_64BIT_MASK(0, bit - 1);
+        uint64_t next_tick = target_bit - (count & lower_bits);
+        uint64_t abstick;
+
+        /* do we need to bit flip twice? */
+        if (((count & target_bit) != 0) ^ evntdir) {
+            next_tick += target_bit;
+        }
+
+        /*
+         * Note that the desired next expiry time might be beyond the
+         * signed-64-bit range of a QEMUTimer -- in this case we just
+         * set the timer for as far in the future as possible. When the
+         * timer expires we will reset the timer for any remaining period.
+         */
+        if (uadd64_overflow(next_tick, offset, &abstick)) {
+            abstick = UINT64_MAX;
+        }
+        if (abstick > INT64_MAX / gt_cntfrq_period_ns(cpu)) {
+            return INT64_MAX;
+        } else {
+            return abstick;
+        }
+    }
+
+    return -1;
+}
+
+/*
+ * Calculate the next event stream time and return it. Returns -1 if
+ * no event streams are enabled. It is up to the WFE helpers to decide
+ * on the next time.
+ */
+static int64_t gt_calc_next_event_stream(CPUARMState *env)
+{
+    ARMCPU *cpu = env_archcpu(env);
+    uint64_t hcr = arm_hcr_el2_eff(env);
+    int64_t next_time = -1;
+    uint64_t offset;
+
+    /* Unless we are missing EL2 this can generate events */
+    if (arm_feature(env, ARM_FEATURE_EL2)) {
+        offset = gt_direct_access_timer_offset(env, GTIMER_PHYS);
+        next_time = gt_recalc_one_evt(env, env->cp15.cnthctl_el2, offset);
+    }
+
+    /* Event stream events from virtual counter enabled? */
+    if (!cpu_isar_feature(aa64_vh, cpu) ||
+        !((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE))) {
+        int64_t next_virt_time;
+        offset = gt_direct_access_timer_offset(env, GTIMER_VIRT);
+        next_virt_time = gt_recalc_one_evt(env, env->cp15.c14_cntkctl, offset);
+
+        /* is this earlier than the next physical event? */
+        if (next_virt_time > 0) {
+            if (next_time < 0 || next_virt_time < next_time) {
+                next_time = next_virt_time;
+            }
+        }
+    }
+
+    return next_time;
+}
+#endif
+
 void HELPER(wfe)(CPUARMState *env)
 {
 #ifdef CONFIG_USER_ONLY
@@ -489,32 +580,30 @@ void HELPER(wfe)(CPUARMState *env)
 #else
     /*
      * WFE (Wait For Event) is a hint instruction.
-     * For Cortex-M (M-profile), we implement the strict architectural behavior:
+     *
      * 1. Check the Event Register (set by SEV or SEVONPEND).
      * 2. If set, clear it and continue (consume the event).
      */
-    if (arm_feature(env, ARM_FEATURE_M)) {
-        CPUState *cs = env_cpu(env);
+    CPUState *cs = env_cpu(env);
+    ARMCPU *cpu = ARM_CPU(cs);
 
-        if (env->event_register) {
-            env->event_register = false;
-            return;
-        }
+    if (env->event_register) {
+        env->event_register = false;
+        return;
+    }
 
-        env->halt_reason = HALT_WFE;
-        cs->exception_index = EXCP_HLT;
-        cs->halted = 1;
-        cpu_loop_exit(cs);
-    } else {
-        /*
-         * For A-profile and others, we rely on the existing "yield" behavior.
-         * Don't actually halt the CPU, just yield back to top
-         * level loop. This is not going into a "low power state"
-         * (ie halting until some event occurs), so we never take
-         * a configurable trap to a different exception level
-         */
-        HELPER(yield)(env);
+    /* For A-profile we also can be woken by the event stream */
+    if (arm_feature(env, ARM_FEATURE_AARCH64) && cpu->wfxt_timer) {
+        int64_t next_event = gt_calc_next_event_stream(env);
+        if (next_event > 0) {
+            timer_mod(cpu->wfxt_timer, next_event);
+        }
     }
+
+    env->halt_reason = HALT_WFE;
+    cs->exception_index = EXCP_HLT;
+    cs->halted = 1;
+    cpu_loop_exit(cs);
 #endif
 }
 
-- 
2.47.3

