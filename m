Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3822238F226
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 11:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777980023; cv=none; b=GnuGwZLUNq2f7w38rql4er7p2qWeXIpaXTc2p74/vFiI1yTBxZ8aocekjEO7jLqnGAarpLWE7YJXeheIO6k+JNYfWFK4y603u5yTidUJggrG7yimzhD43KGkxV4jFud5EZkWnFIy6DS7g/HMGhbGlh0bOwU53/KtoCb4kJgaW90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777980023; c=relaxed/simple;
	bh=dwXf3550zFctiw3z2pBvd5ovmBmpqy0wi7MJPLzquLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UhurPeMDZjqCN8ahv8zR0FpVLB9CjhylZrjHRS0P1lEVgTx4ZgSXL/hmgc6Htv8LTCCsBUMsRW+ETdZMmohLsMksE1xVB0/gEviT25Dr5f81kyx2zIvlqXcfrFEQe4p2NEd3YacUJbbGZwWBbLG2pjJD2JyAcfGfpJie5y/HjVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WBZxPGNE; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WBZxPGNE"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so81301855e9.2
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 04:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777980020; x=1778584820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5Q27noSD3y22Kc8Ha+0FZ/4vnnp/JBZF+sT15OWbOg=;
        b=WBZxPGNEGIdFPmVQ6vpfAS9p9JsrmrT/CE6TOuFnlZBglrRoTH6TetzlYefIduB7IL
         /J5EfYkwxZVybWVqNxjnHVJzrDoo1mUtWGRquvRnt3B3sYZdwGEOXLikkKM2+fSuCmyJ
         5603MOP2ZEbHRLRopA0yB23UjccgoyeLjOZ050i2X9vHOMKZ7FsMI8NxvKasYpJT/xN8
         eBcZvaEUVWLU1mkCR6n90yUoZxwqjRpTi4wyfd730ruiS9UX5G+SFYhHLD9FZegXliaZ
         W1yxTStYnTv/3hHxwhib0lZ6cOzhauKER19kGylNsFOn0epAw6AOGNOBbOceJSsWlugz
         Iiew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777980020; x=1778584820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U5Q27noSD3y22Kc8Ha+0FZ/4vnnp/JBZF+sT15OWbOg=;
        b=NObv01Mao2NciHquFMLt5arpoQSsKv/8F1aat5GcGNuWKAxaKPJMv8Gne7rIaMnDpA
         fEpoM9yQBWGLt/RN35YE2MuohAVSLgcEEYVckhEil6Lwsxl09v57I0AO45TT7OhUODYI
         7dLD2absIBRmU3/JxtEKVQDh6q642+xVDy8q+Js7J7cZhbvwu4Z0q0TGqkJPD0dlrpRj
         ImgMqXAiivtSIFr0/o+EToS+JdS3SKn2JugnBOjd2aGUFROz/OtyERoEgocHDTFRYoHe
         oPSEjwovxIgTKvc7tsA3sa5BfP+wkMA9gqaUc9AgGxw83gGzpIWeWfq6y1WyKgOYB+hq
         s3ow==
X-Forwarded-Encrypted: i=1; AFNElJ8jQtKbs6vwohgdjEytzHnttfVECc95AxtlPqafEXjK2fXt0gLbw6TZHHqoDJ+BNZ/9TYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHNNzH3jP1VyxOzOKtgPD5phrDCHWzQdaNzUHEQaap3YadZIKi
	dSwTq5oupn4jXSIOrGmxnA+mbmOp3OHldm2dBp+B++bvGMMV0Nlh4Y9Q3vY1sDY9Qsc=
X-Gm-Gg: AeBDievI0slcWggDLHIRTXaD59Pn9MJhlkoU4ng4cVBmwiYwOUbKomo3B5tAF3nD9al
	OMFxnqd0MN83ZquhEyT6ru+BSi7Dlq+Rm/LmJObb23Kd+xv5ABxOesEcUTi8iky/AGr5BPMRFZ3
	95GBjxzHBxYk1OrtiGyafKtodst8yd3h7vO8yE0EXlp5mPLmGA01neHqUsUR4rSBkXSIq/Lu89s
	MTLPg9j8woB8AhD8jUmAGnB70xbVMmLFC7pMBLYTSGm6AfME2SHsyGVMcTPMZpfKsN+m9SDVGPt
	7fkZbdrvmo0ERyz3ZV47FL6nM6cKeYETWpL26LHMPoDkQHD8ydmiOO9hYsXGBqsJWXtcKf2xF63
	Au1pgHspPE/mnhFdEvD0oAkhT/zkwQ6FSvaIsU8jkfpj7AoxXj2Lni/9yiJn7hJbMO72LtEi4YY
	7vOwDN6ws/2CQx44CouNkMosN68TqO7OrMkQ==
X-Received: by 2002:a05:600c:45d5:b0:485:4388:3492 with SMTP id 5b1f17b1804b1-48a98638a3dmr217298555e9.11.1777980019369;
        Tue, 05 May 2026 04:20:19 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a82301b7bsm466225935e9.11.2026.05.05.04.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 04:20:18 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id C876E5FA6F;
	Tue, 05 May 2026 12:20:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	kvm@vger.kernel.org,
	Alexander Graf <agraf@csgraf.de>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v5 5/7] target/arm: enable event stream on WFE instructions
Date: Tue,  5 May 2026 12:20:11 +0100
Message-ID: <20260505112014.102993-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260505112014.102993-1-alex.bennee@linaro.org>
References: <20260505112014.102993-1-alex.bennee@linaro.org>
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

To avoid issues with QEMU's incomplete ldst exclusive handling causing
potential deadlocks in common WFE enabled locking patterns we take
advantage of the architectures flexibility and treat being in the
exclusive region as a reason to exit.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - merged target/arm: add gt_calc_next_event_stream
  - update to use halt_reason
  - made arm_wfxt_timer_cb atomically consume halt_reason
v4
  - skip sleep if in the exclusive region
  - update commit message
  - remove the CF_PARALLEL guards so we work in smp
v5
  - use env_archcpu for ARMCPU rather then expensive QOM cast
  - rely on cpu->wfxt_timer to guard event stream leg
---
 target/arm/cpu.c               |  13 +++
 target/arm/tcg/op_helper.c     | 145 ++++++++++++++++++++++++++++-----
 target/arm/tcg/translate-a64.c |  10 +--
 target/arm/tcg/translate.c     |  16 +---
 4 files changed, 142 insertions(+), 42 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index fb79981338c..a23b7e87495 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -875,10 +875,23 @@ bool arm_cpu_exec_halt(CPUState *cs)
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
index 2b1fb1e059d..8284dacbdf6 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -483,6 +483,97 @@ void HELPER(sev)(CPUARMState *env)
     }
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
@@ -495,32 +586,46 @@ void HELPER(wfe)(CPUARMState *env)
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
+    ARMCPU *cpu = env_archcpu(env);
+    uint32_t excp;
+    int target_el = check_wfx_trap(env, true, &excp);
 
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
+    /*
+     * If the CPU has entered the exclusive region we could sleep
+     * until the global monitor moves from Exclusive to Open Access.
+     * However it would be expensive for QEMU to fully model the
+     * global monitor and not doing so would potentially trigger
+     * deadlocks in WFE enabled locking code. However as WFE is a hint
+     * instruction the architecture allows for the PE to leave
+     * low-power state for any reason. QEMU chooses to treat being in
+     * an exclusive region as such and return directly.
+     */
+    if (env->exclusive_addr != -1) {
+        return;
     }
+
+    /* For A-profile we also can be woken by the event stream */
+    if (cpu->wfxt_timer) {
+        int64_t next_event = gt_calc_next_event_stream(env);
+        if (next_event > 0) {
+            timer_mod(cpu->wfxt_timer, next_event);
+        }
+    }
+
+    env->halt_reason = HALT_WFE;
+    cs->exception_index = EXCP_HLT;
+    cs->halted = 1;
+    cpu_loop_exit(cs);
 #endif
 }
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 07014717316..8b97136e78b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2052,15 +2052,7 @@ static bool trans_SEVL(DisasContext *s, arg_SEV *a)
 
 static bool trans_WFE(DisasContext *s, arg_WFI *a)
 {
-    /*
-     * When running in MTTCG we don't generate jumps to the yield and
-     * WFE helpers as it won't affect the scheduling of other vCPUs.
-     * If we wanted to more completely model WFE/SEV so we don't busy
-     * spin unnecessarily we would need to do something more involved.
-     */
-    if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
-        s->base.is_jmp = DISAS_WFE;
-    }
+    s->base.is_jmp = DISAS_WFE;
     return true;
 }
 
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 50d0184e84e..3ab49887ce6 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -3262,19 +3262,9 @@ static bool trans_SEVL(DisasContext *s, arg_SEV *a)
 
 static bool trans_WFE(DisasContext *s, arg_WFE *a)
 {
-    /*
-     * When running single-threaded TCG code, use the helper to ensure that
-     * the next round-robin scheduled vCPU gets a crack.
-     *
-     * For Cortex-M, we implement the architectural WFE behavior (sleeping
-     * until an event occurs or the Event Register is set).
-     * For other profiles, we currently treat this as a NOP or yield,
-     * to preserve existing performance characteristics.
-     */
-    if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
-        gen_update_pc(s, curr_insn_len(s));
-        s->base.is_jmp = DISAS_WFE;
-    }
+    /* For WFE, halt the vCPU until an event. */
+    gen_update_pc(s, curr_insn_len(s));
+    s->base.is_jmp = DISAS_WFE;
     return true;
 }
 
-- 
2.47.3

