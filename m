Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2633FBEBB
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 11:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882214; cv=none; b=osa2ErN8KF90yWpguafaIocQCN2HlNId4YDV8M7hI/3Y8r5kTv1B7s+lOm0f1pfor+UhP0insTYp7G3egJZSN7W+dJb4wTnxS6HCsNn8H137MD3BYMeQxn94OxlR0DXyr5X51/MEeVbk1mGArOu45IuV15GYxLKTjYqQwCO27nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882214; c=relaxed/simple;
	bh=NZ/f3WFCI3Q63AWt7vR1M2GXZ0X5ADrqbNUY++g8vFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PIKAChHv/Zz5p76Ltqekak/Nyp+YBilnmJLwlIcKSjgFWjRdbAU3AnG5gd1+BD2XXY6dkh0d5TolvHvbdW7XIosKlut7xVeapbAumT4o7gBkNOKfGAu/IgM4cEj8a2BuWENZNDs7emD3QDMThIhKzznT40tTzNMWbY3YzeR+UpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tVLcd3+U; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tVLcd3+U"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49042aeeb75so67614925e9.1
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 04:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779882207; x=1780487007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35klr9KydrIrWjxQJ+LzEO3Q866fe5zrRjk/XLnaeTY=;
        b=tVLcd3+UFAjrDKhTrSLm7KY/uI60D2+ptc3a/u0jrFdW1dqYmE10550E5U4IXDdvOL
         giO8RaF6Z1Fx4Cuujas90y1PEMIbTi+L0qgSRTHIBTFmcxpggsWRsC73GIiG0JZJHDEn
         aL2CoZR1+KDAACQnivMgy/+KvbYn8n8mL1iPtsQuhNg346+ud9nZ5vmOhA45fbFBmogh
         tPSgLUQnMkyRPXb+nXz5og4PEfK1osGvzs20ZNUGXXBwu/wdPu958jv6ebLAxDevkKkF
         sfxAN1PaKm4gttghucYxMvLsGex0USvd0Q1q8gns2FM2I9SAH41VlBeCK1O0DLS+QUUQ
         xZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779882207; x=1780487007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=35klr9KydrIrWjxQJ+LzEO3Q866fe5zrRjk/XLnaeTY=;
        b=fE7lPirWMgpmZnIU0FIWUsouKFeT4nx7ZYLu27DP5ob9dXcFIJd88127P0ltHlK496
         U0YXdkMJ1KxnzbQbDbOKvO0pUpdp/zQAkSEX7Zz/oiCiIhTssCGOS9eVC7IKnUqPBNR4
         KHzEsfsp/2PkcNO1qPPIz/aIBUaxV7/f+hL40Ww1zSZNm8mvCUrb4RVZ+142LV0fO/3z
         xl/ZviYvfgKuxJXkWZlvz5lAvSpK2N6U2iMw1X7yv0IK4muePvDjY9Yes9m1c0VtZKJW
         aqrnUvSeXJIlt2mjOg4fvSWaqIa0nYZIZL2gwPMW77oN5YbOLVdm+ysytRswjrg0EYoE
         B+bQ==
X-Forwarded-Encrypted: i=1; AFNElJ+9DAVj2Hr7fe5KST3o2ocfxW6380rwFN5oe9NF3smRxpZQs+sGgt78cAa7sxlEj+w94Y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFT3GK2dgdBh4Znml+xK9WJhX1zfmGoFml/M+dwDaEJdF3OC2/
	w21nVQ3oAJQWl7UWsqglRa+Tgd4D2DIJ+8S2NQfwsSnQjyRcJF5PyBIHemGR1FuJ4hg=
X-Gm-Gg: Acq92OH9Hy7EMtMAmr3CMrNbrpIkA7NMcTCgFD7ctsvNts+BPItS3oLNoggxVx+seEZ
	JvfyhiTUi821Xu+lWA9aOH2Hl6u2NoZYoRlPtDCMwvzMF+uPBHLwo2x79Yh7yeKgxcOaX1JPQPU
	2EzRzt8Y7WEiID/qS76aksW8jpfcz3KunL3J0fAj3M1gvvWPbKlUqYQekubo4xONqZsZfLZ0w0T
	gh4DTrg5bbIWaoFvbJqXjOw5xBTEzLlSgV2Pw8I4q1tkXaXAMOF6fIMlhAMFGurVDzpn4vg8r3f
	hAV5/vlPeGq0Kg8kFs8N02kGFUQBPEg3wP1IdGloDFAJcmoX1LgEzab7UoJk0ZF40RX8sU/G3o6
	sYNd1JNaQS4JBxyceLoW2ylweuVWDwrWk1K9HW8zcvEhpu2wehcixkmFbfktOk3MM2HOcMys/Ip
	iJcuKbBvoc4Dg20u79xhDf09Mb4K8rFEK7CA==
X-Received: by 2002:a05:600c:83c8:b0:490:601f:d783 with SMTP id 5b1f17b1804b1-490601fd8f3mr242474495e9.4.1779882206843;
        Wed, 27 May 2026 04:43:26 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb54a432sm7752119f8f.3.2026.05.27.04.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 04:43:24 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id A68436000E;
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
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v6 8/8] target/arm: implement WFET
Date: Wed, 27 May 2026 12:43:20 +0100
Message-ID: <20260527114320.1581552-9-alex.bennee@linaro.org>
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

Now we have the event stream and SEV/SEVL implemented we can finally
enable WFET for Aarch64.

To avoid issues with QEMU's incomplete ldst exclusive handling causing
potential deadlocks in common WFE enabled locking patterns we take
advantage of the architectures flexibility and treat being in the
exclusive region as a reason to exit.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - fix exception syndrome by using enum value
  - use env->halt_reason
v3
  - fix check_wfx_trap(s/false/true/) as it is a WFE
v4
  - defer expensive calculations until needed
  - treat cs->exclusive_addr as a IMPDEF WFE exit
  - update commit message
v5
  - use atomic_xchg to consume event_register
---
 target/arm/tcg/helper-defs.h   |  1 +
 target/arm/tcg/op_helper.c     | 94 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c | 15 +++---
 3 files changed, 103 insertions(+), 7 deletions(-)

diff --git a/target/arm/tcg/helper-defs.h b/target/arm/tcg/helper-defs.h
index ebdf09be38a..5e4d828dd55 100644
--- a/target/arm/tcg/helper-defs.h
+++ b/target/arm/tcg/helper-defs.h
@@ -56,6 +56,7 @@ DEF_HELPER_1(setend, void, env)
 DEF_HELPER_2(wfi, void, env, i32)
 DEF_HELPER_2(wfe, void, env, i32)
 DEF_HELPER_2(wfit, void, env, i32)
+DEF_HELPER_2(wfet, void, env, i32)
 DEF_HELPER_1(yield, void, env)
 DEF_HELPER_1(pre_hvc, void, env)
 DEF_HELPER_2(pre_smc, void, env, i32)
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 060b155d559..b64b80fa653 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -640,6 +640,100 @@ void HELPER(wfe)(CPUARMState *env, uint32_t insn_len)
 #endif
 }
 
+void HELPER(wfet)(CPUARMState *env, uint32_t rd)
+{
+#ifdef CONFIG_USER_ONLY
+    /*
+     * As for WFIT make it NOP here, because trying to raise EXCP_HLT
+     * would trigger an abort.
+     */
+    return;
+#else
+    CPUState *cs = env_cpu(env);
+    uint32_t excp;
+    int target_el;
+    ARMCPU *cpu;
+    uint64_t cntval, timeout, offset, cntvct, nexttick;
+    int64_t next_event;
+
+    /*
+     * As for WFE if the event register is already set we can consume
+     * the event and return immediately.
+     */
+    if (qatomic_xchg(&env->event_register, false)) {
+        return;
+    }
+
+    /*
+     * Don't bother to go into our "low power state" if
+     * we would just wake up immediately.
+     *
+     * We want the value that we would get if we read CNTVCT_EL0 from
+     * the current exception level, so the direct_access offset, not
+     * the indirect_access one. Compare the pseudocode LocalTimeoutEvent(),
+     * which calls VirtualCounterTimer().
+     */
+    cntval = gt_get_countervalue(env);
+    offset = gt_direct_access_timer_offset(env, GTIMER_VIRT);
+    cntvct = cntval - offset;
+    timeout = env->xregs[rd];
+    if (cpu_has_work(cs) || cntvct >= timeout) {
+        return;
+    }
+
+    /* We might sleep, so now we check to see if we should trap */
+    target_el = check_wfx_trap(env, true, &excp);
+    if (target_el) {
+        env->pc -= 4;
+        raise_exception(env, excp, syn_wfx(1, 0xe, rd, true, WFET, false), target_el);
+    }
+
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
+    /*
+     * Finally work out if the timeout or event stream will kick in
+     * earlier.
+     *
+     * The WFET should time out when CNTVCT_EL0 >= the specified value.
+     */
+    cpu = env_archcpu(env);
+    if (uadd64_overflow(timeout, offset, &nexttick)) {
+        nexttick = UINT64_MAX;
+    }
+    if (nexttick > INT64_MAX / gt_cntfrq_period_ns(cpu)) {
+        nexttick = INT64_MAX;
+    }
+
+    next_event = gt_calc_next_event_stream(env);
+    if (next_event > 0 && next_event < nexttick) {
+        timer_mod(cpu->wfxt_timer, next_event);
+    } else {
+        if (nexttick == INT64_MAX) {
+            timer_mod_ns(cpu->wfxt_timer, INT64_MAX);
+        } else {
+            timer_mod(cpu->wfxt_timer, nexttick);
+        }
+    }
+
+    env->halt_reason = HALT_WFE;
+    cs->exception_index = EXCP_HLT;
+    cs->halted = 1;
+    cpu_loop_exit(cs);
+#endif
+}
+
 void HELPER(yield)(CPUARMState *env)
 {
     CPUState *cs = env_cpu(env);
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 92db4e69b64..d170cf22b0b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2086,14 +2086,15 @@ static bool trans_WFET(DisasContext *s, arg_WFET *a)
         return false;
     }
 
-    /*
-     * We rely here on our WFE implementation being a NOP, so we
-     * don't need to do anything different to handle the WFET timeout
-     * from what trans_WFE does.
-     */
-    if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
-        s->base.is_jmp = DISAS_WFE;
+    if (s->ss_active) {
+        /* Act like a NOP under architectural singlestep */
+        return true;
     }
+
+    gen_a64_update_pc(s, 4);
+    gen_helper_wfet(tcg_env, tcg_constant_i32(a->rd));
+    /* Go back to the main loop to check for interrupts */
+    s->base.is_jmp = DISAS_EXIT;
     return true;
 }
 
-- 
2.47.3

