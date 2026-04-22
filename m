Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485AB3CAE95
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 10:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776853055; cv=none; b=nG/sYA6fCQeU6kTI43jSkYZqltIrn0bAIsHI6QyeCPQPJn041lbanHyZfbI4twgQZnaGi4NgIWL09T3Idy9R027Uk4kXyDQyVk0007DMmrgYATQnKSoWoroG6W008ET1HDyMaX5/cR4D8P+UiljxkKnW4CW9dW9dgJOLXRtVH24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776853055; c=relaxed/simple;
	bh=CG7LetbMCT5Ot5AplrnGeAX1eG1r+jUaq4xjGKgQESQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DltFITs67EokmaT6kcglKCCnpWKS9rFNUBHKWErvr640kvVxIyuJfOKeaqkiNvr5FTnSczBRxlGljpA+Qh8WgDRtWGK9Me06Z0PszBhqnvy8unhCLBTmWOKrYSeHjtO+RQ1utl6mqT2o/IF5dZ4dIRiQNW4jUD2scRTsEcDu/CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pwbWEf1T; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pwbWEf1T"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d77f6092eso3605698f8f.2
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 03:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776853051; x=1777457851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ChBMLZB7W3RWggGvPxQhi9T29Aee3H3wmNETcHJ/8uM=;
        b=pwbWEf1T7q3aL7aaodr01Ssw/MVVwIpBv46kmpYI29c0nDtV5bGKS9XZDCvFo6B3By
         f7GpxrKGK6K+jNos2mVzLrC6sQcgwbhD43ZE0L92IE6h71Lke/gx5QeFixI7WxkcSZO8
         +Wl19goDpwKdU/6b3TAX9m03q+6lYc/f89vRLyyuG8m+n8/1BavLoXWpexFWtqJrJvBt
         ZVK6ineYx/VpKGmnLOSf3fIuXv1KwZcvP5xcRUzZQEE7Df0nTeYQKiUYBfZiQ40S59GI
         d6mV3P3t88i7XmrcikPkVjQpRHAjQC5XT6fDdvQ+niS07Gk+GdmGv17ijVVMXB4UBkuf
         KnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776853051; x=1777457851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ChBMLZB7W3RWggGvPxQhi9T29Aee3H3wmNETcHJ/8uM=;
        b=acWterd69qKjJ+9r6lwqWDuqA0Lmn6/blsmub4nC9bE9IlAfIsYltyYuefH5JyajLF
         QjutBZL7ufmQKmDRHrsMl9HbafQ2rNsbtnJ2yOhdKMqVfPS4hcdywXh6E1P59MhDq5zr
         NpuyLRVvPDErDLrOnkGYBMHVJJiJyRQ0giiBMMB0WTL6IPPHtflqvkNV3c+wIC1dAiBt
         2m0K1a+Klu+wtX1NYco05JEBArPwC48IzHhmOWYKDWvFERNkxI5l8e0LnvmM6VC+l4mt
         baoI2i1AdGAyu8USYFrQ7oQyCtNP37OmufZXhXw0LoGgGOxKivqmasYTeQNH8w7ThJDC
         zNVA==
X-Forwarded-Encrypted: i=1; AFNElJ/4J51+vatmlwTh9LKKlWPnpzA/5lq8CQkPjgic+zdAh8bXXS+6DygZpDEEajY9MWaxFu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhkSZUpl1EZI2jbmLY2nmsdr8iwPzyOQugodZHmFsGSz+DJ2QP
	CvnOp3xy0ZfiXz0vWwarInhFJs9l7aN1VUExPUEdU04ZPzBCaHXL2/f4PGfCmugM5fk=
X-Gm-Gg: AeBDiesGtI8P/6j0MUz2QNRmXP0bJeaqkuMCpc5AkosS0sIa0qD8OUzusw+3etoQe64
	GvNnHJveAISQaGfvvGTkpONXSCwsbySpPFfeZPUTyLy4LBuBZQ6Dey2jcumD13U1rYGNcJivdi+
	d+AP35RQE+I1RAJPddf5adnmgbs042OYNlZiatXHnF1Q6Z+Mxj8z02ye1rG3hK4ce56ydEUYE67
	ijUQHduiALexGVVoUVARfkdpb8JkOlo5PHa/rLJGq+4Reg0y4uu19qk0ckM6ykl+ntzUhX6iLGZ
	y/ieu70miWCLZBwRBuDD40m/ZA+BPB8GzUrQqKvT+pBd5HOAYaJmsdfp062KkZ+QLUmyW6FSqfI
	VEjDotTHVdZ6mAwYcASY/S4Qnv1ivNRdCa4eNNsv0W1iy7uuxQUCBpCClseVbQ0NrCf7EOdmS7R
	e33T7i6LSnRnR2atSPWGs1IOUkO/4zh+4UNA==
X-Received: by 2002:a05:6000:1a8e:b0:43d:3004:5fef with SMTP id ffacd0b85a97d-43fe3dbeaf2mr32935858f8f.7.1776853051221;
        Wed, 22 Apr 2026 03:17:31 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e46898sm46561003f8f.27.2026.04.22.03.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 03:17:28 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id E594E617C4;
	Wed, 22 Apr 2026 11:10:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
	qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	kvm@vger.kernel.org,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 30/31] target/arm: enable event stream on WFE instructions
Date: Wed, 22 Apr 2026 11:10:41 +0100
Message-ID: <20260422101043.1234229-31-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422101043.1234229-1-alex.bennee@linaro.org>
References: <20260422101043.1234229-1-alex.bennee@linaro.org>
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

