Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127FE39A075
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 10:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777545884; cv=none; b=nPbDbcp0IC4m+7GWD3vKx9WQsSVzir4AJHPVox7NBtToJ64FhWsV1kcm/V+fY5usQib2+cpQUHYwvgRlU1BkRRxarbh4JPtmaNgILhysfeWiW3GlDGFR6fxrfO+3xNqnCLYfXr60w6RqdpvEsufdBFYwCd2Hy+SKZ0bXTOVDjow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777545884; c=relaxed/simple;
	bh=nYy5kwEhyKPWjrFeDRHHCu/R7Iz2Pa2lJc4YKp52Als=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E+VrlNPcSw4oAe4cfWXBYn87cE0ef+rHNhO/vbp67h44Bdc/myRpKPPDD7R2Kpf0UGSGmBORAd2qO3lS5MEmr8bks6Z+AvWa8Nl/bfr6epll0nPR1kirLkrbaTqx0p/+7RrUbEeBBCVPtoMTHGtBHEJPD12N3hMtEXg8V4c1Fu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vCepevGz; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vCepevGz"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so7582155e9.2
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 03:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777545880; x=1778150680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsEsn1YZYtVVUa13L2AGk1G4k+OQISTqb0SX28KGc3A=;
        b=vCepevGzlZhoral2+hAvLDFRDzMBIThbtGk1/hd8WVg3z0Oa94/9HXYhuv4MAAfqjP
         LHUyMS5VdoqF2LnO56hhNFnVQ1okZtMJg0geH8oMQWUSo3qCHcKRfODLcyMGNpfvfmQE
         bIO4HZE6fHpnP3DFS9MuxPxwsouAb7JCIkHOPy+8eP2QuMyDguPugeauXvfHbvyXEWz0
         kTaUEGdeZvt4Vg2EdB0XPZdWPtrSGI9Q4sJ4chIFbCJOECxFxAdnzSfA9sz2IT27TxjI
         ORmHhF6jFtVQsdbWa7DkppqqtVcpNh3+20mNg+T8s+wKI1O13UQFgnKa2Zo472naUVjQ
         7ljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777545880; x=1778150680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MsEsn1YZYtVVUa13L2AGk1G4k+OQISTqb0SX28KGc3A=;
        b=j1t/UEdTbmt2XiNZvAVk8Fs/wjF5GKainO8B67SXlKIftZn2+C1Ng0xJdPxYS6oRdv
         deWk98iJy44+oGRyMeoAil+bwWAEKdRauawLom38Dm85esgLObBTkLu9u31hwDlLaN+U
         H5RvoDZ+KRWHycx5laosHtC0UusoSdt2H8djPU/HN0DnEEY6EAQgUmUlDQ6WaNSIy/XN
         +nLAt6jp9uriyMsos8qM1iW5ECrMevKj3cTMNbYLAxm0GJd9lJIrmsinGI/Q4TJzTwLU
         lsbzAVoeR1du8GMFzCqIiaxEmhn7Udg04hpm8na0yW2AiLA9J376zvfHivqnaZW4sdRt
         JZ6A==
X-Forwarded-Encrypted: i=1; AFNElJ+L8w55G1b7ReyvWSxaNZEutRX/ydfvYzHSd3Eh80SQKZtCR/7PFdrAAWx/Wq1DcFpC5KY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNchCOqDiaFXYUWv8hR1crqxYsOfY2qlPmDJ2szpZhiFOmVYpP
	Dt02G6ub+HPeQbURql+mAKwEJk+MPVObHoM8R7UiF8GzmVs7dvnlCgzKwcbso0ao19A=
X-Gm-Gg: AeBDies1jNjiKS4zoqS49P0p5Y11VoZLpFyZL4mPrRQhxpI53J4ZASA0zVphHedaFKT
	im2qwJQIgQjpsdKSpkw79PRIEbbrXNOdLfvU05ujpmrn7bqEtnLuGUtfP76QL1f6nafAYzBJZn1
	zQQAD5FatnssKLieVNE4BWnpK7E9FdaUxkXDGkQ0yLeL7ou+jLtsgtbklvbEa2RTSXy73ZFBe0Z
	orhVhQ8w9L9ju4CDTfa6Ws0j2B8hTc3LoEihsr74xk3OkQMxlY7ZuazUxysTK6y3hDu3rw+zQjA
	6/GGtFm+GFiqXIEGn/k6EOn9uH5B6CArJdbJckK/ERIXPrvlI5BLBO9yeAsXvgdqUINBXPKy+Rr
	AE7sRLGPFLxkoQAIovKQLWEa3fEaGZ5VHibddNlhjFXYb3dv8K4CQvIPMhLJg7CVlwm9n2wKc00
	SsuQNrW32/qcZ8A+UEXramYC+ZNqMOnn7gGA==
X-Received: by 2002:a05:600c:a00c:b0:48a:56d5:16f2 with SMTP id 5b1f17b1804b1-48a8415bbc1mr42026335e9.7.1777545880246;
        Thu, 30 Apr 2026 03:44:40 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c2fb999sm57694655e9.6.2026.04.30.03.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 03:44:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 494B35F941;
	Thu, 30 Apr 2026 11:44:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
	qemu-arm@nongnu.org,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	Alexander Graf <agraf@csgraf.de>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v4 5/7] target/arm: enable event stream on WFE instructions
Date: Thu, 30 Apr 2026 11:44:32 +0100
Message-ID: <20260430104434.1482407-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260430104434.1482407-1-alex.bennee@linaro.org>
References: <20260430104434.1482407-1-alex.bennee@linaro.org>
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
---
 target/arm/cpu.c               |  13 +++
 target/arm/tcg/op_helper.c     | 143 ++++++++++++++++++++++++++++-----
 target/arm/tcg/translate-a64.c |  10 +--
 target/arm/tcg/translate.c     |  16 +---
 4 files changed, 140 insertions(+), 42 deletions(-)

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
index 2b1fb1e059d..d0f45522b05 100644
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
@@ -495,32 +586,44 @@ void HELPER(wfe)(CPUARMState *env)
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
+    }
+
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

