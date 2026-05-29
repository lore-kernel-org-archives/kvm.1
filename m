Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4CD3AB5DA
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 08:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043396; cv=none; b=MIf4zdg2MeZTyPNIeM0ILUjofUAVgwJgPoSjyjR4f0+4sw2dR4r8Y8VEYtD6ggSjpYEslY9NU4ayWFnDD+ZJ7OO0OrxYLpQiXxyDv0Ve5FTBkiXrNwfB0FqMJbtpII68l4EV9GjRJwOPshJknCGJu802612hdZvgUrWpUjpsbH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043396; c=relaxed/simple;
	bh=kr8V45dU/wbaYhuVzZJln4x5vTBbfXPqlixEGne7iqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i6w2y+459kBpDvQ3tAs/nfRiSOGA7ch7uud8LzgGhIJZAZ5HVsOogDOlBNy5Bmjq0Ns+2bR86L1X8tww+UqycgxqOBQ0ZRaZIu+ns4HH2R/zhRI6oORZPXZrmz+zR/ho3SdR60LbAbQD38egWXvajH/unmcWYfFf4/cyz8DO5mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gx8UlJa6; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gx8UlJa6"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4904127c32cso46406915e9.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 01:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780043393; x=1780648193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xM5kxa8UaLwO/IVN2pUPHL7tGeiJncGgEWLu3xGeqnI=;
        b=Gx8UlJa6E0zZU6waX524mbqJr527f2qrcYwnS53UwQteNkA9eHOFEfWPIwb51vvTWU
         TQ2V17NHzkIIpY4iadR591rAd86l4aXsvUho5Aze2RigaZbSiaQcneboY2RHLv1KAU6/
         b8X5xC2fvfPEFF6nso7sC6veGjgOJ49G9KEgIxrvH73Y3heSGP2KABvAhtsR0kJefFRl
         fb7bbQyrQ855BDYnq1kF2WvkE9znm1gv/nQdMryvfXjOjyxMjPBZ/pm2giMjFDWdljsP
         Qyhk6Hnnz6aEvL0wy0UFjblCpouYAkNidl4ZsuCrG70jlBmBrSclRAe70UJt3scRlrQW
         /SWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780043393; x=1780648193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xM5kxa8UaLwO/IVN2pUPHL7tGeiJncGgEWLu3xGeqnI=;
        b=KwmZLuOr0murKi47KElD3q1jH5lI+UGH413egCSOe9Et6VM69T/lm9yOBcRCpMgbxz
         S1062ONRq2fTQuCk9PSdKMaG5QZcyuWN6ZwlljYDjLKompmmyc484mdi7bhexbIW5m3X
         1IiHJspWQICs045HIsHN99JAsT7uQoXFMPHrJChlGLtlZkZgKrTummTvitL/q0nzCc63
         OnREnfCObFzerWfoF78sBexLPdwoiTL7N34RujfPjfAlAyG//HWp7MlcBo3VdtDSQT7o
         DHhwClQqm+6zhUKpI5xpEXpZQ7Z1DpxPf7tGeXBN2NO605DuXyuGmrxHHnrBqqaxvqEK
         CyoA==
X-Forwarded-Encrypted: i=1; AFNElJ/vso1FGwZvoG2ChEHp1jttTLF4SgwUP/f1LyVg5itDWK8xmsbwGDF708bX//AdV4z5D2I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4BTTQRdXWgXha5OLov1mNSEj8dShDCRDxBkDM5sGnNlx9wscd
	x+imdSxExEPE4QjyZD6WLnIc/N+T7l+AEqA4Hzupgjdy9eLGAaKXS8VuyfQvac1SiR4=
X-Gm-Gg: Acq92OHB8jOZvxxTs5ihUdM1RjcA3vrDaaTGAOkHUdGtfMPYxYdTbLVkxhy1Oh2sn9M
	cVYrC9QR6c5XlQg2KEkhdKo/uVXSdF6S9QYlyyju1PQXrRYmxR/2BRSxSKJMJ8EcnW8cogYiMSd
	5A55NVoFnkvZxRi+B6Itj6DVOVigrkZf+pvbJCjxp/Zge5zxWJBxHW/txecdL0vBp8w24glDdIk
	9ZQlZh8AhSZXkEEIMAEFiGzltl3GskXhXYIv29zewHkouMdr1eo2bDHKPkMBo/gB6S36mswnD1V
	CnFZTZL45X73sWq0Hs93D6lExVBpBRYwUbclc49HkkKRINDOGnpNK/sOQP506HeEuo9L3F/s6sj
	Fvvb6y9dcDSfp+tDv4j/woBZWX1JBEFWm3CGbrQ6kdqvzxTiw1N3hAmzZloXKebeqVNYxyhSheX
	HMvV8o2L4x44BaGRoYfm82bPUyW4aSy2xVcRz+RhI9uxuM
X-Received: by 2002:a05:600c:c8f:b0:490:9d1b:f05c with SMTP id 5b1f17b1804b1-4909d1bf0demr29165975e9.33.1780043392462;
        Fri, 29 May 2026 01:29:52 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d6f35f8sm20354765e9.13.2026.05.29.01.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 01:29:51 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id C660F604BD;
	Fri, 29 May 2026 09:29:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Alexander Graf <agraf@csgraf.de>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Peter Maydell <peter.maydell@linaro.org>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 6/8] target/arm: enable event stream on WFE instructions
Date: Fri, 29 May 2026 09:29:45 +0100
Message-ID: <20260529082948.363931-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529082948.363931-1-alex.bennee@linaro.org>
References: <20260529082948.363931-1-alex.bennee@linaro.org>
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
v6
  - use atomic_xchg to consume event_register
  - remove extraneous target_el calculation
---
 target/arm/cpu.c               |  13 +++
 target/arm/tcg/op_helper.c     | 142 ++++++++++++++++++++++++++++-----
 target/arm/tcg/translate-a64.c |  10 +--
 target/arm/tcg/translate.c     |  16 +---
 4 files changed, 139 insertions(+), 42 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 8771b695d9d..d01b4cee5f0 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -879,10 +879,23 @@ bool arm_cpu_exec_halt(CPUState *cs)
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
index 2b1fb1e059d..b803c9bf162 100644
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
@@ -495,32 +586,43 @@ void HELPER(wfe)(CPUARMState *env)
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
 
-        if (env->event_register) {
-            env->event_register = false;
-            return;
-        }
+    if (qatomic_xchg(&env->event_register, false)) {
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
+    if (cpu->wfxt_timer) {
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
index 4b978c8b958..ec03eaa3bbd 100644
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
index e1e5539f571..c10cc382d15 100644
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

