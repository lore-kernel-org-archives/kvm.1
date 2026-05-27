Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631963FD94F
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 11:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882213; cv=none; b=TtzHDHy5Cl/B1nzdNUiG+uM4dGri/yipGfzFpIlrwgEaDPZ1trFvgF2Y0RJkyq7CX5rRGq6456i+vWdXv4Shtz6fmatnn/gm6j7tF8/k4sz+XDhZ/XXZBfJI72MDQ11jswM/uE5VixmgI6wOTuQFcAgXkHsH8pRrzhPYmsiZgjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882213; c=relaxed/simple;
	bh=TCxUL/ZQuT9K02wpETJKHHjlrcPPINyEMZgSLog8E38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EoZhA+eTgbSUxusf4vfdyGH+xdM8puB0VvsdtnshmXMUSw1ZwpBAE+44k40+jNAIfTmI3uvm7Qs1iXy7fxBNvbj9aQh3LXg3vgNyIygu6U26oCgbMQ0SEoMPgMAcGyIBf8MMTU0nxTssBcB98zQKQc4AMJPXKCVuv6EWRGl53Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vwc5Paer; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vwc5Paer"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490686877a1so22223255e9.0
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 04:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779882206; x=1780487006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b83Ewop06ud+aRvyIeWlXePLR1iRPsH+uS2u5AxXgk0=;
        b=vwc5PaerallLJAD94RU6zqURJ4GiUtbPVsY9JYA8kbtyAmt6t2EfsANb0h/yLGy2XL
         y4bJuGjDaXTBJj0jwCFUZ1SPG7M4j4Ri76zBie65IimI1oRv6/JhJawqTlSlWcynY4lF
         GAwL27GAQgzDsDtMcdO8slyqNEnpQHudHKoRLyW0XjVbNX3PGVhz87o//zXvhUAuESyy
         IqJ1cX0xYV3CnRkoqPwRWgPBe5jiHCxmurcujXttyQDrEHdgEYgZ2/s+5Tal8xQMksNW
         xmS6goYUlPK2AAfVYXGtJropNVmHIGmCP5ItPTcm5dXqKPH+atDtBmEmviMMS4n/FzXN
         8GiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779882206; x=1780487006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b83Ewop06ud+aRvyIeWlXePLR1iRPsH+uS2u5AxXgk0=;
        b=mIrHVC6TkOYU9L4S6QNTjchUqeJ/L0dS9913duKDdXWbrpnEIdrCtNvJOHWoZmJ5Xy
         /1u4Uu26Y/UxjCs9vpdtiEiKiseM8SsxKlxwfep7l4H1PakZHrkiJyKKhUGP9WGV7n2B
         OF7gh39w1f4H/4Y2++ejCyWnTRPqTh7OM1QQft72vUxRmqFBpyJ+dBJeyYTiJ7i0Ur3H
         hEknmi2hGG9DNvA9KLlSh3l2atPZNgzwkg4Br3AOwoHrFzSed4rQATtNEQcXhewHNChL
         h7bscBjGUqLPZn+d8Sgksa9x6djTgYIrLPFTRzpaQZ1Gk1tKL0QEIXakYlNTPmk+Rxuh
         3jtw==
X-Forwarded-Encrypted: i=1; AFNElJ89QKEmLGX6xvVe5Ah5unRc0oyOK40r4zKPSPeqwZpuzRy7qEm2OdkUV8YWpeCdXcSFemc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOCgYRWlr6cyidJA+qrbrz2CkUUv+OzeBmmVA8Nfq/LOoyX4eE
	NLdx3ipZUiBLZVqPo8L8Z+PJ+TIqldm0axtCWom7eytQA4IzgTYRae2D0Mi08Rr+qAw=
X-Gm-Gg: Acq92OF4em1QT/RcoU0eHZ4jnMKtFtEuW+L8gOgDtkeOIHIa8oehuGq2h0tRciF5YV5
	uxaMGIlFHEAPYbO2/0RowvLs6335+5xT22AeKs3NCjYyIUYaUvh4xIUcuqKRqzrvGqv36dt0vvU
	rovkl0YDrrXZxr8hoD/nAJ1oh5hzQcR4Eh8UhWx5CLbdejLkqvQ3nKtFLOKBWgbdp2T1SU4JCla
	mOwSG5ltm+z3flf5uropX36YjeO6OvTWz77U0Ec6xclpJa3Y5Ayi2S/ULmKxfV5qMl+jhSFYrsj
	I4EXPtNWomYPhNu95gwnjWmuGGb5yppPyZHQJFk11Nx79D/ldguZ3NNqAXdA/PTBsAUXJiioErD
	qMBtkQJt649c4gdpm6CClfc2qFGP+/E3K9NMidloLjItm86Fv/D5OP4qUTUvDPxIpEZoNpO4VaF
	Abzz23FO0AXZJsFHZp4Bbw5RM=
X-Received: by 2002:a05:600c:2a8b:b0:489:1abb:5559 with SMTP id 5b1f17b1804b1-4904226d9camr205536055e9.5.1779882205519;
        Wed, 27 May 2026 04:43:25 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490809a0e7csm14743915e9.22.2026.05.27.04.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 04:43:24 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 721015FF90;
	Wed, 27 May 2026 12:43:21 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Alexander Graf <agraf@csgraf.de>,
	Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v6 6/8] target/arm: enable event stream on WFE instructions
Date: Wed, 27 May 2026 12:43:18 +0100
Message-ID: <20260527114320.1581552-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260527114320.1581552-1-alex.bennee@linaro.org>
References: <20260527114320.1581552-1-alex.bennee@linaro.org>
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
index 8bed5214eed..39fe9ee0701 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -876,10 +876,23 @@ bool arm_cpu_exec_halt(CPUState *cs)
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
index 88c5832fcbe..ee584e9a793 100644
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

