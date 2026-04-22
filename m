Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082DE35DA48
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 10:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776853048; cv=none; b=Ht5RKvp16lyWSLtc84AFr/g6ce5f+n+WbT1kr0JGxUGLQRkJDpYoZvlMx70pY8J8bo7Qx6BKFeHVb28uU5k5pSX0cwsKzN9qQrHZkyGA/ONSGfi43+bP7Q0Rk1dAo22Gr8iEAtBD2KaCXNtmFRb2ehcVaY1Yp7JruqZCJvAb9og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776853048; c=relaxed/simple;
	bh=sg+Bk90ONtYVCmmjDVsk77X0uslVn1mfFw1/KUWYGbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FnR3K/v4AOb6L+fICI9zOeJKTXfSwftQP84ZqBavpi6BcQO58Ib89uJnJSQ2RBLZAdR2yAiGcoZ3kjCIDBDC5G9ZAa308Yc/tyzgTTpghj+4ujIJwKeo7IFRYC9EvzgJYcHFT5IUqPrWSOtxnkW3w7mWp1Ihk9xM2+GdJQaCXDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=onLQEfQa; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="onLQEfQa"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso27659525e9.1
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 03:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776853045; x=1777457845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9TGxTsXQ4q7KQiokEaw8AGBMMJRUq1ldJ+z5GAXPms=;
        b=onLQEfQapR7In1QcPrWyyV956VncQnPHPsffHOSVPoWnXVfHUoed7KJx4EoCY6yU3U
         6JfEruWG7rv0NZg2LCRGEndeiwJaY3lofCqlXYvrTq5+b/HqluRLKsadjq3sBxJkBNoK
         TXGPQg+9yzUg84085swkx/4kPrin8fyRH6INY1nnZJCcb897RmgIWzj9Cn011vyAeJYS
         FaKXnhkcblnbo1quRbgb05KmwktNc7WLEpYeJA0VtX562wQlYj4CpRuDxYffGDZFadqB
         GxdXrtr/87Ihqs7UErxCv2cnddrNmkQjYmZCj6dIuCRQ9vrgbbWhS+UfMj0VA9sTIEca
         CugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776853045; x=1777457845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v9TGxTsXQ4q7KQiokEaw8AGBMMJRUq1ldJ+z5GAXPms=;
        b=Wtqw5j6a5ikICtyD0VR+jjKPrNLUfkE43Fmqm4X3ET8ZdWwKJUfutgMZttx6rzuFOA
         yaz36mvAvgaDynYaGSPlErc8MaN/lozpauvg5isqWNSJL4i8skyCFCpY+HQHMhMW22HU
         8Jae2nx1AqAUmrKjRiD9mqT3nfJFn+7Z0smToE1ZcQFasJ7Lsos7eHXXiNeWfjZ4DyTd
         35skKomaSfs3I6QD6AtWqtHAqc+M9HgmD2qz8FnvE3bfEKnZOt912j+3XobR9cZRd9IY
         ajuktb5iApIxNI9G1HDQlpDonhhPiirMZQZOCFNv7tq9c613UQ8IrQVB005tA5GCZUzI
         aDsQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ZKiZeInIL4OzVAuK5RqnMS40W/+YazAvlJG5N64E/vw8yh5x8UtStejmN9vxvdGaGlQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwDiMJ1pTKNYrOQM86EgNn8wb2VqbqIUSki0Ll0851pyGBdSgD
	Bq9Cwa/6GwcJs3IY8RKeBF6FCnLz7stQBuRmCN6K+OSmq0Kbxqr5JiWvtddyS82GHjI=
X-Gm-Gg: AeBDieuHSbF1clgLYM6gNJcAPdVMG37sMcdb8Ret/codd6LyJFHYeL3WAY+7u6iEzvD
	A2qMx7ncNrSFKqlc77KB+05iM4CWGQ49GM2XCnRP7ncC1M+BEP10ggg5+DTBq/XvqBqyIQKgxZQ
	pmXETUm6oJEKqAC1+mcSjmNokgzbRo9UwDUXrNwH5Jmlf4A6J23n6twkPwDE6ZWvGeGZzOypIo0
	XWikN3310E8dP+kgTMHmqSG4Zc3UPmKPpG1GXP/qgyFvAwIOyDix5FFd+mpqj7/EQbwseXX02rj
	REbIl6UO6/sq+dqGa1kNL6VHXjf3yP50XYjXCS/FIiNkkINt5/wop1qFJ4bVQJ8IOCnxZS/Mkzy
	HFVPXrkowWI3nCGjX8yTVb3afRQ9GnUE1dGbSqZsbgHnuzt+lW0iy6aZ5MGyT3nUjw3232Hyekr
	IRS0b+sqwJvgDgjF0iMUfWbVeegyp2OYIiKA==
X-Received: by 2002:a05:600c:a31a:b0:488:b239:77ec with SMTP id 5b1f17b1804b1-488fb778db4mr234699655e9.17.1776853045332;
        Wed, 22 Apr 2026 03:17:25 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a55dc9f58sm266229045e9.6.2026.04.22.03.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 03:17:24 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 06F3C617D8;
	Wed, 22 Apr 2026 11:10:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
	qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	kvm@vger.kernel.org,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 31/31] target/arm: implement WFET
Date: Wed, 22 Apr 2026 11:10:42 +0100
Message-ID: <20260422101043.1234229-32-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422101043.1234229-1-alex.bennee@linaro.org>
References: <20260422101043.1234229-1-alex.bennee@linaro.org>
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - fix exception syndrome by using enum value
  - use env->halt_reason
---
 target/arm/tcg/helper-defs.h   |  1 +
 target/arm/tcg/op_helper.c     | 80 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c | 15 ++++---
 3 files changed, 89 insertions(+), 7 deletions(-)

diff --git a/target/arm/tcg/helper-defs.h b/target/arm/tcg/helper-defs.h
index a05f2258f29..31ffcbc6448 100644
--- a/target/arm/tcg/helper-defs.h
+++ b/target/arm/tcg/helper-defs.h
@@ -56,6 +56,7 @@ DEF_HELPER_1(setend, void, env)
 DEF_HELPER_2(wfi, void, env, i32)
 DEF_HELPER_1(wfe, void, env)
 DEF_HELPER_2(wfit, void, env, i32)
+DEF_HELPER_2(wfet, void, env, i32)
 DEF_HELPER_1(yield, void, env)
 DEF_HELPER_1(pre_hvc, void, env)
 DEF_HELPER_2(pre_smc, void, env, i32)
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 030209360e8..0c7f069a369 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -607,6 +607,86 @@ void HELPER(wfe)(CPUARMState *env)
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
+    ARMCPU *cpu = env_archcpu(env);
+    CPUState *cs = env_cpu(env);
+    uint32_t excp;
+    int target_el = check_wfx_trap(env, false, &excp);
+    /* The WFET should time out when CNTVCT_EL0 >= the specified value. */
+    uint64_t cntval = gt_get_countervalue(env);
+    uint64_t timeout = env->xregs[rd];
+    /*
+     * We want the value that we would get if we read CNTVCT_EL0 from
+     * the current exception level, so the direct_access offset, not
+     * the indirect_access one. Compare the pseudocode LocalTimeoutEvent(),
+     * which calls VirtualCounterTimer().
+     */
+    uint64_t offset = gt_direct_access_timer_offset(env, GTIMER_VIRT);
+    uint64_t cntvct = cntval - offset;
+    uint64_t nexttick;
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
+
+    if (cpu_has_work(cs) || cntvct >= timeout) {
+        /*
+         * Don't bother to go into our "low power state" if
+         * we would just wake up immediately.
+         */
+        return;
+    }
+
+    /* We might sleep, so now we check to see if we should trap */
+    if (target_el) {
+        env->pc -= 4;
+        raise_exception(env, excp, syn_wfx(1, 0xe, rd, true, WFET, false), target_el);
+    }
+
+    /*
+     * Finally work out if the timeout or event stream will kick in
+     * earlier.
+     */
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
index a1b0cc9508e..19e00573979 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2093,14 +2093,15 @@ static bool trans_WFET(DisasContext *s, arg_WFET *a)
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

