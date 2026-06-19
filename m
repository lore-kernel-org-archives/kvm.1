Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8B6391E58
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 13:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781874347; cv=none; b=o6hkkWGbZgEx4WnSND0DVZaVW+n05IVsV9038yYduqvL+RtFxLyM+O+PfGj0BWC26zMX/HzI01d5S5L0xgP0GES81z5v9MdRJf+1sxs2b8MNV5JQqO8srfLY46QcM+zLkpp1mQ3RxK/Hu1iSbSa800OD1lXT4hqUFtSXauzsYEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781874347; c=relaxed/simple;
	bh=r3VdeyUh401u99EIC8KKJWObnuEf3do7HDt/uRfsZC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BA+I4Yg2EiUELGui0CIbL4lQLKLMbCXjhxpYqERH13VkPQSP2wAwWVbnGEmMDu+vZjHnb4v52T2xarle7SU8uqqHdnucbeJnn/sdjD4qcHmWBPmmNQNm1OaELWxTBDimSvbXVaX+3fx43ODnDS0cEswD+p0VJ8eBZTiFZ3KYehw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wxbl1DRe; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wxbl1DRe"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490b64c8311so19584115e9.3
        for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 06:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781874343; x=1782479143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFfQOO9l3CQg1O1c/LoTPy22fPXz/bgLx/p6YDwqS88=;
        b=Wxbl1DReh/QTjBxoEaqVAxPjBLIMdi2DOu6AWwbnm8TJEgOH9qC5ynU7q+CZTYcyoc
         xAyaz8zd/vHEeBtHFK4k0wsC0RvjQX2CNHDEQtt2hOoxW/JPQiHibz0XDbCsQrcinfGx
         Q+geQEzUwXDa6aywOUWbO3UTK1D982cz1uRY+zLLki1Q81AxLsgzKjsSpNfgAzMB+76R
         nbwASi/jKUUuiWjiJJ1pcc65PRfRSU8yY1g5yzC6+WuiSDuOajCkjFqqTrtyQE9uRnTS
         hVR9AqWKfnrrchH7IMfpseWHf3NWukQkkdBGU8FzFyLS2THXGQoCEP7w0tBaNBmFuZXW
         7Nbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781874343; x=1782479143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BFfQOO9l3CQg1O1c/LoTPy22fPXz/bgLx/p6YDwqS88=;
        b=YBSfVS3ArLT/7tDYkhzP5HwZIq7Rl7MibDPMofOyS645QMnvIFM6rrJyJGjZJ1Zp5+
         2TiwYwufaL/yeSpnatYWBr8EEN5lXeP9iTs3HQ7jo768SQ41FzwJUjK0OcCi9ivHzQBL
         HLfDxSPBJ3UIdq/AlZmiLuzxqASXhe0h2HGFrcL+2L8BzkBnfMLs9oRieQ+L2+LQTGN2
         WpCFjIDNRxW5O3VYqFaxfNm7GoMIWHn5OxVUcBGpb0U2DOLBTi44qzh6fZomgtoaPzAI
         woXazG/3QdZu/8fXHkZ7OyKYjbecWHfs6vwyl1l/HcGKynTyqg6eCxetvhRUND32w1TB
         CyBA==
X-Forwarded-Encrypted: i=1; AFNElJ/AeH3z4VtSv5d2YclXJQyWQidbefFwLV0BmIJmUS6HbKQgpCb/KbVnmmaGrJmuouKOIYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxCH9cKhr7Fs65JL56b6KkMHH1bSnLDLz/96+orNw6WmnWgA5v
	TdNkk6bubHkN1FjmCl8khLu6ZG6YZMwPmkAzFV8AeM3NDHTCjiF9sci7v6rK3no91Js=
X-Gm-Gg: AfdE7cmL9NpRvL3NHAWwKd2rgJXWtzswt9YUskOE05lc+vQU0eLejaJjEH+U7PlG+21
	arw9K4CgxBi+ovQp4gbFA0RNm7ae2whBTQaEESDPVhYADsantzLI9rNjnal87OUqthjsrsL3yaz
	vRF7fca31UusIpMrQNcTokHGn/ZAHEnK3gN1MPEdJcJOw8S44rLzT31KAGWzP/oC19F3Rc/NI9p
	uSKsapmngSklsoLRMU0OOq024hPXlhiwQDRUexLTYnyuXIUr2BKs8UgU3UXKzxZuiLJsFgLJ/56
	fWQXuRzZHqULXaA2GeudFQXGj4ndspciNqE1bK9wWFZkmUpeiPpQo0YmXxV0a8hWnWNF8N1/jX0
	Hk0bOK6+6IslD8FHH/m4jIqk77o/3Hz/0ng3JMrSagIWgJ1WGEnNVIaB2brE7UxFEdwbITHBzQF
	vtK0W79iuij1JT
X-Received: by 2002:a05:600c:4e05:b0:490:9782:3eb8 with SMTP id 5b1f17b1804b1-49240e6c534mr57298685e9.25.1781874342580;
        Fri, 19 Jun 2026 06:05:42 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fc47720sm108355655e9.0.2026.06.19.06.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 06:05:40 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 02D7960223;
	Fri, 19 Jun 2026 14:05:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Jamin Lin <jamin_lin@aspeedtech.com>,
	Steven Lee <steven_lee@aspeedtech.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Joel Stanley <joel@jms.id.au>,
	qemu-arm@nongnu.org,
	Troy Lee <leetroy@gmail.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	Kane Chen <kane_chen@aspeedtech.com>,
	Tyrone Ting <kfting@nuvoton.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	kvm@vger.kernel.org,
	Hao Wu <wuhaotsh@google.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v8 7/7] target/arm: implement WFET
Date: Fri, 19 Jun 2026 14:05:36 +0100
Message-ID: <20260619130537.820184-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619130537.820184-1-alex.bennee@linaro.org>
References: <20260619130537.820184-1-alex.bennee@linaro.org>
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

