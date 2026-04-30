Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43683B38B7
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 10:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777545895; cv=none; b=HYBh0c8CY9qBDXgUThM+TmK6D47Tx6bg8NH7q/phRPGZ3K04kfhnNmle5vxo/rYA0Mfy6LKWaNC4HaObnqMVBk4QPPHK5fH9vCqYnEBsfl6x8FPoSfW70hkhB1WfTNOrcx9+MyCs7u6QGU9hi3ksFUyx/y0PlS/nsbGuUM3aAaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777545895; c=relaxed/simple;
	bh=NyW3kmltoQcTnJAQqYhdbgrR2aKrsmVp0QpQcRUypsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DVaB+eFFf+kZk12k+4/a+0sinCQLO/vXszuswOkNOIG6g4RMDTBz60geqbVmkFIFHAD21SGqZtuDHVNOugMqV4JQqS+3eY/P/lX/94XoBDVTXB3VlYHYi4kPwYNVhlnnhsYHwSkjBSXxK7+4UVp/qpTTTK3AiVKkyJ4JUfLGSuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BN26Vvc1; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BN26Vvc1"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-44a044cb827so4430f8f.0
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 03:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777545882; x=1778150682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5z/E+NEUk6p/y4Qsh2ZiVobxIRwHiu1lhqMJeWdQLKM=;
        b=BN26Vvc1eLgC+UDowsefA0wmAhn7pjiYYyrrn+mAZiOB3/MGngcuyfmkSO45hFs1Ni
         L9HjiKLxa16W3U86vVMWxhQ15gJC79tcmFEh5IhLVzpi5T0StKmcE0zT/GTOjagGtPxM
         ks+x+P8g82EAKecj35gXBjhn/+XvYB6h53usmAwetV//rzjEM4LsLl41P62A1r8irK5G
         BoIPJJl9fyISPR2bogA9NW4k2EHTg6Fcj3L83diRnnLSR+h2KOeddfwYX57WyCHTTZG+
         TiqsZt190Za4ZJleWg6TmwmLkb0YNfm4QXk+ODzccvqZiUWUKh7NZB6J+d31E8iignJs
         XDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777545882; x=1778150682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5z/E+NEUk6p/y4Qsh2ZiVobxIRwHiu1lhqMJeWdQLKM=;
        b=KlXYI4OCadDi6Zy3SvF8Gj8De5KksOMnigj/Jew8DwTi6JcPu3IgNvamr+QTIoLBmh
         z6uokCGaDGiIgpUBpDOJnmEPaG/CAt3gTkY40k4wDSm/iAWamqhehjG+LvrBK7S69d1n
         fIEKVkI+ZE8cnvomThhmp7LriIne6F9oxR32obgMMuJFDqncgllO3kaJey8xGGEHGCqS
         rsdpKoFlMDBGV21DBENQUOj3mb2trfge3U2DTiuPkmiBSEF67+8uZRQBx9ShaQ50Xi4A
         IAbzxdbvqzjAP33HrFaLCD2Emw9xLZ/cbhDWVTKUPki/C7pXKDUYVhGgr2oI7hmtH1ux
         j5Cg==
X-Forwarded-Encrypted: i=1; AFNElJ9A69Fx0uAO2OnYp6S5nt1SnYz0i2Hlcs9CikXatHEZHBoHdH6A2+qOGBOyGbavDQS9eeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAS7dgJoTOF277FFLBZq77dRYjb/qYfRl0FnLAT6HoBbRgRh6N
	96fsSEkge78K5DpMjGgTc/KeG5psHG2y8EUwl5L6FGdzDPN9C4woyHwa4y0C/7MbJGc=
X-Gm-Gg: AeBDieu0kKcMjKndFL+YR7vpsD8haN1RmrFHlLZEADwZe8QzND+G717Tv+DyBkz7k0F
	6+z1ghNuYtIgShPVDi4e5PzT//oLFjonyFBXSABVMLAVI//VgfBnbpqbazzVKOPtZdaJ+VHhV4H
	Ma8bqS7767ol9vvld6AcDhRnkhaW/SrCfA88/dp/nIesppIobA4HimrE3RLLntjkCkJic6jcQzu
	vYH91eWWlf9QqYj6Fo5kRnqWu4RyQugpmPxh9TV7QW9kNYsFuPglBDSm6zycToYw/nFLqhK627O
	RvfH4l0Ft6km4R5EuSjYiNGHIruWMihSISYfZb4Mqim34RyyWLXkpk75mfxYmt4TkS7rc1+mUbz
	7cXtpxkUJkkznQUW+QO0KFfeuCZr+uQ+SCpdlVRlGw4veHVGBbdSnV2GKGYOGiiH8VQ/ejdfnIS
	WpDtc3NxSrElBNC/jCeCeIC0X5cZAweRjzfg==
X-Received: by 2002:a5d:5847:0:b0:43f:e791:a347 with SMTP id ffacd0b85a97d-4493e982935mr3711927f8f.26.1777545881915;
        Thu, 30 Apr 2026 03:44:41 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b7217afesm12338368f8f.23.2026.04.30.03.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 03:44:39 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 7D1855F954;
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
Subject: [PATCH v4 7/7] target/arm: implement WFET
Date: Thu, 30 Apr 2026 11:44:34 +0100
Message-ID: <20260430104434.1482407-8-alex.bennee@linaro.org>
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

Now we have the event stream and SEV/SEVL implemented we can finally
enable WFET for Aarch64.

To avoid issues with QEMU's incomplete ldst exclusive handling causing
potential deadlocks in common WFE enabled locking patterns we take
advantage of the architectures flexibility and treat being in the
exclusive region as a reason to exit.

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
---
 target/arm/tcg/helper-defs.h   |  1 +
 target/arm/tcg/op_helper.c     | 95 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c | 15 +++---
 3 files changed, 104 insertions(+), 7 deletions(-)

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
index 77ac6161e93..8421c548303 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -640,6 +640,101 @@ void HELPER(wfe)(CPUARMState *env, uint32_t insn_len)
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
+    if (env->event_register) {
+        env->event_register = false;
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
index a6f392a28f8..ead2a7ff81f 100644
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

