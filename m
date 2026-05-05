Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DA9388E49
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 11:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777980023; cv=none; b=MZ/nPcxxrYajLGwHed2KYEWAJa3xaxz0kWjcdQDprwjlPBcyNEz+++DDTNBulnhLuu8zC2v1GLpopjTpzpmGkYYw8Eek+iS3i2ds/9fGq+xBDDtauv+NI37Zw0rHfg4tLyqq/y6tw5Z8P/jWrt4GG5TEAVkC8pzQ7vVtygZJ1/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777980023; c=relaxed/simple;
	bh=3rUPrgZ+hFhbAQjO/2GrGvM+ZdRbrUnej36VHtI4bgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gAoANcgf9jd/4KPZzJIsUgMd1+LCooPbWehOz0ZyWpkvOexX73cldn9DI8z0yhTEw/E9DGfOiX4tZTFbqGZ8jJ6seqTmx4wrVjqZA6KIJqxWvqI0pdLIQft3qtDaTV/mTGZ8VrnLzelQy0zojJlS9/miROe6Mlfg5ICPG3XaKzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tpLl4NDR; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tpLl4NDR"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so81301945e9.2
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 04:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777980020; x=1778584820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6sMi0kUGzt6eghb/XXUV9xCjggNDxEZ3+ioLqRmvCVE=;
        b=tpLl4NDR62WP29Dbi3V0WoFB8YHW3NK20y5QyP/APJOhVzZO+2zGYqOQoKvwVzn08h
         Naa+Rshtn9UeFHGiAzm5Xoa9HbkQxPbQT6OAJl4V9qMPfWR6GUJyrxNWRcxDr3mNljap
         qNC5YEfEPWGvC2iV/PluR6uL/vpnq9XgEq2qGXkL16bGxAB7tKTCzqckp3Tr3C30MsIF
         tm2I/LDNutz6Ar5TQBGAYS0Jexa7+lxJPctOSivKd2tUhEhi/4JxKfqPMADMzaTFHfCw
         o0q63pgPOf9aOSOyIepMO+U1P31I/Pr/cNA+hs9DHkYwt/k4h2bZi3hmKuQaqQzxiwMu
         M7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777980020; x=1778584820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6sMi0kUGzt6eghb/XXUV9xCjggNDxEZ3+ioLqRmvCVE=;
        b=GCPgfDcUuihMhOZmtSfjg2eFG45iEz3xHZbNPOFZ33d9aF7e332VaR66ZiY96jMhDf
         BoojVfxGKvI7/3MEjuYp9mYfzbJaurxTlOWcxDqRV9hOYnvOMieav7U+szNNGOU2G2eg
         lm18/tq27G/9ex8HjKtPZLJ5+/he2YsU1wizy8Uz2qkPMjC/f0XBqL6sjGQEBXHH1PKV
         xjLdXdiO1o6cGUMzr+yT7x1ZqJND1A9VqywyS/NAP48KC2Ofmtfw4qrvpnF3+C61SOOe
         QAvM6yv/iAM9P6e8ejsePvdClz7aUdPyv6n6WMvkCs4DAVHuOx0rN54Dgd03Z9BV32o3
         hQUg==
X-Forwarded-Encrypted: i=1; AFNElJ/Z09Y2EY17aBTL59CaFrY+vbk9PX2QrdjUxIDYKg3o5NuJWIUQth6aSZ2G7L4xh+6WzRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLo2Vyoj7bToKS0yWLKur48tzTMbtnCzDSCSVrFeEu695cL3R1
	FHgQi+qoO7Jwfx4wd1B3DGXw/f2/fDS5ZgPylycQrMNYerH3Bb+wQzmWno9J9tG1FTQ=
X-Gm-Gg: AeBDieu/gjigAFbrUWvw1MkaKHgz66QLsfVnEeJy2EsspxlWM7mIf2wFBEbfLiohfSj
	YDDmDK5RkCjBnOXHOol3IxS05RW+B1DJ8pnQLj31AhsnDELLuNgnBugW4y6JLvv/SrsBawvusPt
	1mHaIUwfYsFj/6CxH5TdqevT9XN7rD6EZIE+sJ6M5vWCBUBLwxNW24ujxz3saO8Sa//i9ZKprXp
	x++CIqNPTfti1JwaNOpBF1BfoKJVQku+ANuS7TaaKAk/0yb7CAwnYSEhi+wcONwoFkI3n2cgppd
	bfziAPJfdPM+o9B49nY1CMODeuNeImFgbUmwyrB4ZqB0lHdSUZXc4Ps7SpebPyKSGX9S4BdrkVT
	+/LGtwvRQ9iAh9hYuAnwCnth4p008xF8nnMF3wUW6cmJfXNhXi4bpiJNOYLIuz9b/PmuqgAAb8q
	Kb90X+lq6cF8wDxMwzBSfgDTjSw3hHUKhU3Q==
X-Received: by 2002:a05:600c:4ed2:b0:488:a882:c7 with SMTP id 5b1f17b1804b1-48a98671da2mr235172445e9.25.1777980019858;
        Tue, 05 May 2026 04:20:19 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb6fffcsm365107245e9.4.2026.05.05.04.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 04:20:18 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 03C035FB54;
	Tue, 05 May 2026 12:20:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	kvm@vger.kernel.org,
	Alexander Graf <agraf@csgraf.de>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 7/7] target/arm: implement WFET
Date: Tue,  5 May 2026 12:20:13 +0100
Message-ID: <20260505112014.102993-8-alex.bennee@linaro.org>
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
index 1349bcc7929..d8d7557b880 100644
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

