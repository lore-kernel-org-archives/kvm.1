Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375FF28488F
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 10:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782297056; cv=none; b=GLanLmmQCWmkVfuijcJ9V+cLxW6CMYZDjQE928yvSw8Yqyk1jBvOnIYgYpYL6MLP24cbuU5sPritr3tQBfytyUYcVH362V0Otjw9rK/prlKydcRxEum4YtN1AoOfO7tRmS2PDdEGXSRcPvUsb1dwNUEktEHYwx95s5/vFk0fXuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782297056; c=relaxed/simple;
	bh=r3VdeyUh401u99EIC8KKJWObnuEf3do7HDt/uRfsZC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nI+B8xEfgBD1CXRDNu5cX/SUihtNVebqaqGMPOlaZ9TxPeJfU4iLiV1AqHhFHkeNMCH4Jj+tnYCTrU0MhxYYeNiMoR+4DOizGjsqFsQi35MJYWzoN7nB+tnH8VXtk9kfdqPRQSV0VJ5R+dqr3HvCtwLHGM8m/lhBWD7JPtgP2KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nu5Z4a7i; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nu5Z4a7i"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so8802205e9.1
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 03:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1782297054; x=1782901854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFfQOO9l3CQg1O1c/LoTPy22fPXz/bgLx/p6YDwqS88=;
        b=Nu5Z4a7ilMJPDqrSeuUS2L5Q6EWRzpS9xBI9mJQa9cBMyCA6PZtkVqMp0fDoSWzCo5
         izFpRchbSn1VDGGmJUg9dPUNeewsEHZgTwN8UhejT1C9eK2KX68YhJLu41EawJaJ2hxc
         C6IfnpFnsVrmDVbauVyc/OETpAYVkBHLSs8Yaqot1uTUVGx7DniMQbY4JVPFkD1zDNpN
         c16OwUaxsmh3LUNx+VigQ48qcPt49+ZXvRzxIMwfRjhWKidd3j5XbqZ095o2KsbHVfqY
         MwVe5PY8mRvuHx5azYz628Gh0Du4+Dpx/jCqLgSNwEmoWNidNQLr/12Jccg2oLOojSVv
         Nuiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782297054; x=1782901854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BFfQOO9l3CQg1O1c/LoTPy22fPXz/bgLx/p6YDwqS88=;
        b=KfCYaiTDZKvwBxc7SaXUXAul0n5YIi+ScNjd8ji1VLPpfRvLs0UUj31Eo5+pvFclwn
         sytfkR5GL+4fiWSt15c4pi/9rdjlU+7QOcJXAg/DgvHmvlOrQPF+gJAi8pnB7847Pk7z
         /tRy6wdQoHirZ86+UuhARZ1xfjpUzaPgpRa65Iy8SUCjwAfN8f9kKv6GdZ5XnA2j5o0U
         ftgpXQnD3oaUApqzUMvYO8cWqyuMNtaSqe/zVsipgo8OR/aM2+NgqVKG4uzRUoG03u2s
         4uowXmkGAF0hwwa1rF7uxhPIZBiGq1DCNzZF1YFdXoAh0EsUXAYE3C9rp08CtuPYAI4r
         yd/w==
X-Gm-Message-State: AOJu0YyNqXk63Gib/aSrlZW1rAv5Z06VQWD6UzVTaXfgY60Mb769876Q
	jF5SHc+RIH4zrG+9H3Ptoe9LWuXRYGF60QRon0za0Vc0lUGDUq/ZLpdD7XiFu5IA2DM=
X-Gm-Gg: AfdE7clJasmUAyS/2/nUBB0h3jec136pHfejoe3Zh77a7YAZ35vv7sM1PAPFzuZb16W
	VVWtymnl9YyZVCXIzLFEnP0DvIgGqt0UYC2jNq2VLoOxba0U+LfFH9z2havpp79CKk6d1eMVCFa
	Ln/scLDKWZ0svU2YKzMVpqUo3mITi1Z2LT52PHu5ltDhBelN0WEmhk6e2yUatoG/EZUvZ5iUNmj
	qoYn2YI8qLWz0TA5pQbTiDgr4LY7vLLT0AaegCuRNGO7vhIiPEBzH6p0WDUMbegw6UHAT3DQwoa
	si+2ZY/HwR69KC7XVLHqsId1SEC9s0pc8TsO7/luQmkn8NOyoXebdwTAvYgv2SDyNyjK6uwU/Bf
	EKx7iX7Ugno2CStOo8PHJvxvlFN2tC0kClfSAbhbDBGLbKB9Czh1cbZ4HDU1JDCNBCNdCyuLNv5
	GwDi7nU/LW3Cn2
X-Received: by 2002:a05:600c:6308:b0:492:4c60:bfb8 with SMTP id 5b1f17b1804b1-49260878547mr32494045e9.28.1782297053658;
        Wed, 24 Jun 2026 03:30:53 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49249207dabsm662422765e9.0.2026.06.24.03.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 03:30:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 719305FC69;
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
Subject: [PATCH v9 7/7] target/arm: implement WFET
Date: Wed, 24 Jun 2026 11:30:49 +0100
Message-ID: <20260624103049.884930-8-alex.bennee@linaro.org>
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
index 99ebd754942..0077aeb4e22 100644
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
index 3321e29898d..c4433be2ed0 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -641,6 +641,100 @@ void HELPER(wfe)(CPUARMState *env, uint32_t insn_len)
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
index b45aac6d269..4a24e0a7fa0 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2195,14 +2195,15 @@ static bool trans_WFET(DisasContext *s, arg_WFET *a)
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

