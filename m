Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7C029ACCD
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 10:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782297057; cv=none; b=cE39FLvewm+Q5Sr7WhjnU5CpPU9+TptDEwLDehcy1e8UGitHWFvc+MFqqXyjTPDKGieuGd2c24BiTnYVzy9MRfF7PqSdtmWMn45FNlJTe3KuccjQSvw3+5M88Tm1xcmHcjQumKY3fNXcyr6PNgeejWh15XKguWe7jXekBo9ti/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782297057; c=relaxed/simple;
	bh=gormbLFiAgG//iH8wnFaowcv20l00UKi4ThiJVOnF2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nF5LZ31dCfnl4TNPdwMZ2UpoxLz9P9cEJhnhW2J5kaiBJHTrA4K0gdtdr52tv71HlIQO2V8+JlrV9qTMSGvbfn77HuGZLeFO+b6bB/9hdBIZQMfdl5Yn9fpSHRm0mnJq2NLOWHs5ciSjdfhlROqTgAAgSyd/K86qHpGJVW6sDe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W/MmUY8O; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W/MmUY8O"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-463b2f6fc9dso991200f8f.2
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 03:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1782297054; x=1782901854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDry7jb2dPo9olFf9Nnv4hC92PCKHG9roJXwQDrkWTo=;
        b=W/MmUY8OYdEyu3fMfef3MxfoNE7f0tjYlnLoVm2Xxjbt5pKg+bl9ZSZ4q6dLrkfHr3
         UdqbgwW9rAOo5TGOiTdUUUkMRhOL0oGovzF1WsJv5rpEeGHedvBwaCe7yABsgS6cJQGG
         zR+Qi/6Zytcr/PZ6GhdSirIolRGcvH9UHO3XYnvHfuVgPKEYShxOoLYpGwf11G7CZM36
         O8v0KBqncbE6twL1mhqqFwIyOexUoDMILvtd2rSq8bO+L0clLb8ENoE6rhttqSoFWiV5
         mVnraJInvRGKZDWuoufAd6mVutmpHkbE6ZhA/ewNa+AT9ZvNn2sDWXkXhBQ9qJhRDxRT
         Zliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782297054; x=1782901854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vDry7jb2dPo9olFf9Nnv4hC92PCKHG9roJXwQDrkWTo=;
        b=cH3cgQgTzUrvbC42r0il/2gRWkMB0e88ITsjHe8Q1P+4Aut/j5kihil4zqWqZ9Z5GD
         HXCHCuSYJZbwfDpLA3G9xJYuyZcILLjMfaJUfWTit2xrudu+Su3tCFILO43ona2qOVuU
         3sp4ar4kAmZNAR7hcrHNchDe34aYyo1j25oRYkljMRB+teValuc3MQEDgk3Ny7OUrusQ
         Y6uwaLRkRqQ3+j8DrOjpKd90veYUqXz/BmxnR5vfy3+j7rJyK9kVuXpttxK07hlxSi+c
         SJ5WS5cbGlbth2Sl/lX+IOefsU1XZorw//47SYk1h2b1svAeBysRW3+Llp2MwcKDI7py
         258Q==
X-Gm-Message-State: AOJu0Yx+9lEHS97kXDscOWekSaxPlUNhiwp9tZ94dmNciwjIxSjhu8nV
	MCKCd6owUySegPDVP7YxhblSBTGXCp/bOfBHFIk8F7r5hP4+EHMp5Dxk0rtxTojBY28=
X-Gm-Gg: AfdE7cnsfVN+1IoSaINj/AQsJuyw6aoo4zoGUQko3OJ4EuSDXW0tu9Syhskx85lwzqK
	iQggJZZcHh25LlkQLwZnBIACgHk/7CsHrDXtCBIvoDDTMveh+/vgxuWJA9/40BZC8ZsvBhreYVQ
	OoLO3UTTaWiwjxUbQIdH1fWO5q0V9ZR8XpoS0tPfY4+9X1U0M1bcgLwnI6fnCgDOgCcnzkqK1RO
	yWxkDAfUEpKTdqZAqfE8IsmFnZyNFRxKYUcwxC1+Hdyb9IwXirsD4TonYgsrpF+tez+KTUINcll
	mC1q2flCL6E2CE7PYSujW/UcL9+lL1hLak+8eKoFvWqxk4lyxlmJLnJt8P5m6Vb+IecvzRCPtGp
	AKMier5NvgO0FubgSEw7tAiiQF44uNSLTALAZ5Fnij0QI75s9yY+YYahHCUsplEC7/AO/bU+yy2
	4vIeSE+gSpUqwB
X-Received: by 2002:a05:6000:22c5:b0:460:71e6:e11 with SMTP id ffacd0b85a97d-46c0b3e3bb3mr4577108f8f.24.1782297054018;
        Wed, 24 Jun 2026 03:30:54 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1eef84d7sm6047588f8f.16.2026.06.24.03.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 03:30:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 56C8E5FA60;
	Wed, 24 Jun 2026 11:30:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	Troy Lee <leetroy@gmail.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Hao Wu <wuhaotsh@google.com>,
	Kane Chen <kane_chen@aspeedtech.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Steven Lee <steven_lee@aspeedtech.com>,
	Joel Stanley <joel@jms.id.au>,
	Jamin Lin <jamin_lin@aspeedtech.com>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Tyrone Ting <kfting@nuvoton.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	qemu-arm@nongnu.org,
	Alexander Graf <agraf@csgraf.de>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v9 6/7] target/arm: enable WFE sleeping for A-profile
Date: Wed, 24 Jun 2026 11:30:48 +0100
Message-ID: <20260624103049.884930-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260624103049.884930-1-alex.bennee@linaro.org>
References: <20260624103049.884930-1-alex.bennee@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

To enable full architectural behaviour for A-profile we need to do a
number of things:

  - add support for the event stream to wake things up
  - add support for potential trap on sleep
  - handle the global monitor's interactions with WFE
  - remove the M-profile specific gates

Event stream
------------

Two generic timers (K and H) are capable of generating timer event
stream events. Provide a helper to calculate when the nearest one will
happen.

Now we can calculate when the next event stream event is we can re-use
the wfxt_timer and configure it to fire as we enter a WFE that is
going to sleep. Reverse the M-profile logic so we can enter a sleep
state in both profiles.

We also take care to use atomics for accessing env->event_register as
we now have potential access outside the vCPU context.

Traps
-----

A-profile can trap WFE's *if* the instruction would otherwise sleep.
To do this we need to pass the instruction size so we can deal with
the is_16bit syndrome encoding.

Global Monitor
--------------

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
  - defer calculating target_el until after the early return
v7
  - merged with trap patch
  - rewrite commit message
---
 target/arm/tcg/helper-defs.h   |   2 +-
 target/arm/cpu.c               |  13 +++
 target/arm/tcg/op_helper.c     | 156 ++++++++++++++++++++++++++++-----
 target/arm/tcg/translate-a64.c |  12 +--
 target/arm/tcg/translate.c     |  18 +---
 5 files changed, 156 insertions(+), 45 deletions(-)

diff --git a/target/arm/tcg/helper-defs.h b/target/arm/tcg/helper-defs.h
index 8ec6c163195..99ebd754942 100644
--- a/target/arm/tcg/helper-defs.h
+++ b/target/arm/tcg/helper-defs.h
@@ -54,7 +54,7 @@ DEF_HELPER_2(exception_swstep, noreturn, env, i32)
 DEF_HELPER_2(exception_pc_alignment, noreturn, env, vaddr)
 DEF_HELPER_1(setend, void, env)
 DEF_HELPER_2(wfi, void, env, i32)
-DEF_HELPER_1(wfe, void, env)
+DEF_HELPER_2(wfe, void, env, i32)
 DEF_HELPER_2(wfit, void, env, i32)
 DEF_HELPER_1(yield, void, env)
 DEF_HELPER_1(pre_hvc, void, env)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 4b49f8c43ec..b3de399f40c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -883,10 +883,23 @@ bool arm_cpu_exec_halt(CPUState *cs)
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
index d15062e155f..3321e29898d 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -484,7 +484,98 @@ void HELPER(sev)(CPUARMState *env)
     }
 }
 
-void HELPER(wfe)(CPUARMState *env)
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
+void HELPER(wfe)(CPUARMState *env, uint32_t insn_len)
 {
 #ifdef CONFIG_USER_ONLY
     /*
@@ -496,32 +587,57 @@ void HELPER(wfe)(CPUARMState *env)
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
+    int target_el;
 
-        if (env->event_register) {
-            env->event_register = false;
-            return;
+    if (qatomic_xchg(&env->event_register, false)) {
+        return;
+    }
+
+    /* We might sleep, so now we check to see if we should trap */
+    target_el = check_wfx_trap(env, true, &excp);
+    if (target_el) {
+        if (env->aarch64) {
+            env->pc -= insn_len;
+        } else {
+            env->regs[15] -= insn_len;
         }
+        raise_exception(env, excp, syn_wfx(1, 0xe, 0, false, WFE, insn_len == 2),
+                        target_el);
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
index df5bac22acd..b45aac6d269 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2161,15 +2161,7 @@ static bool trans_SEVL(DisasContext *s, arg_SEV *a)
 
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
 
@@ -11232,7 +11224,7 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
          */
         case DISAS_WFE:
             gen_a64_update_pc(dc, 4);
-            gen_helper_wfe(tcg_env);
+            gen_helper_wfe(tcg_env, tcg_constant_i32(4));
             tcg_gen_exit_tb(NULL, 0);
             break;
         case DISAS_WFI:
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 9079458a297..a1fc0506188 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -3273,19 +3273,9 @@ static bool trans_SEVL(DisasContext *s, arg_SEV *a)
 
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
 
@@ -6857,7 +6847,7 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
             tcg_gen_exit_tb(NULL, 0);
             break;
         case DISAS_WFE:
-            gen_helper_wfe(tcg_env);
+            gen_helper_wfe(tcg_env, tcg_constant_i32(curr_insn_len(dc)));
             /*
              * The helper can return if the event register is set, so we
              * must go back to the main loop to check for events.
-- 
2.47.3

