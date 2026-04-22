Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E573E9F97
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 13:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862961; cv=none; b=S52LhkABUuPI8GekEhUJKs2s9TqRJ2pWIvnGBJdp6hy2FSMUby11JxVAuG/u57p7A8b5J7VMIrGFsu0eyMlKWym2juqJJHDinbrPkk76OgKUNiQDjSyr+BRvhJVlcYXEUNtc/7/sI4I1C+32DqFee4K5ZnzM2Dg+spl/p/z1yIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862961; c=relaxed/simple;
	bh=z6UfyEo+mQarxZszF+atKofRa+fZQe3HH+lZ16B5Hb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UyA2gNSCa8fYKafSThxK63/UTNcSqaGet6vtF+oggq5/NDqerblv0i+WBk4K7yzx86VxOlfU2kxYTRJ6gA5SDxKqFKhIfBqCcT7zGQqZFnJHbFEaALjbKZBhTy/A5BwChet8iAmQXSCJoVoroiwcbzbJ+Yb0BSq6DTMFNRhcyZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AQfDJgw9; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AQfDJgw9"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-488b150559bso43064385e9.1
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 06:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776862958; x=1777467758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCL3cJadHa1d1ZmZ7wv954PwO2cS/d7rv5lfGjMfQE4=;
        b=AQfDJgw9Kbbb5rMz5sJ1XaUOX5/M4TceQ6OO5Fc4qhljZpTKjOzcDz5datNr+RPQLf
         3npc8Iw18w72cVfFid+XbUOqQaKvjMoSJ1GgZpT9s2mSZiqaY/w9/fVsBcol6izXjmaE
         kdgK90m1iLPyIn75bIXiOnwA99X9RuLYasCnXWpQHkvGA8r2scnC1Z3ZrsMVRVF4Hk/f
         0iVkV6KPuttedzADtjINL9QE7Q9cS4s8M/tFvgzBCKl+fuCj5YKoGhlVy4ekuaHCbmIW
         O5vKLMYBNz8sR6WUtqOJwciX3dYOVwBdsPdQDI+OamAA+epjaIEKv3E7VOTb3m4yfbQA
         gyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776862958; x=1777467758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QCL3cJadHa1d1ZmZ7wv954PwO2cS/d7rv5lfGjMfQE4=;
        b=eQBaK9I+BpqWaHVYy9VL6lJgTBNq+H2RrEvYuUuIzAZ68M3EBN6Kie4pnpK1y/n6EQ
         rZp7P6Sic+J6XTNj5CE8xbRos7SNAumTr7CfNm3p/YZF76ueEpzDQdB1H+gH4haBOOOf
         Dt2ao1MP4tOuAh7Rx9fRov2qd2rXtIWow1PmzKigbYB5+G+tioJmDqh6du5s9Wh/0OfB
         FGOGqbOVHFJzszH78E0SgC4u+i0+HZIS05HvGY+l1gTjGNmJhNonpLdUWMJuM+/PP9JH
         5rkJ0JULkV/Tn2tHxOMyHwVSAKIHPvwPOMVlyxlpJd03oOrl+JRTJAG2MHjL6ub6k9mq
         r8KA==
X-Forwarded-Encrypted: i=1; AFNElJ/OE5VIZuQiX5TrV6SqHPKPQ4cbzyJAyN8mvCbMxNqcpV6UGfJF736vwymTESv/pn8jkuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF+DPpqmVT++o13oIxTcxUUUe1JViRhntF4DFFOpQoenS6Tj1t
	aazy+612slhSuaSIg86G1qruk99pxeMULdUzVvW7xvlS782YpR/DrIjI6s5EX9as86M=
X-Gm-Gg: AeBDiesVYQKhANHiwbRVIKqAdCUnO5lgHij956eDFwCoxZ4LcetIrSjqZ4aVMO+0iMN
	iiI6P+OAC+AwuSFjGvk3ItUTZfOfybgnvpGKYWhoa/ppwzuRlFIhC32C+LnuMiffuE1vhq1+hva
	JDZTsmLDKWMiE5GmOKjF1XYe3nvcBhWpmISG5uEfXr2B6X6kHMsRI6CaFY213nIq9ZgvN/GBZLg
	cBv9v9W8POO9ltj8/MNSmLiQqsH3qK9pXD+KNt1yePSJcqWDBNMnFfUObcNzrp9FE4eX8zUf32B
	jZKIbylZ3LLrvWGV1My2k/vKAQEzrnyhHO6Mhjf6XSNxbDoNKmtkORD+rr6Fw9aSSXe69PWbPsm
	f+YNY5liBXr6/ryQgRUnz4+BjHUi27Te9zaj/9UZvbDEzwoF30ExPQzZ9Oml7h+J1u1X9EvCR3Y
	7PyQUMaCHV621CZkxkG6y6XSP3pLR30deUaA==
X-Received: by 2002:a05:600c:8183:b0:488:b187:d898 with SMTP id 5b1f17b1804b1-488fb771445mr269452895e9.14.1776862957733;
        Wed, 22 Apr 2026 06:02:37 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ffc5e3f4sm230898655e9.2.2026.04.22.06.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 06:02:36 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id A142B61853;
	Wed, 22 Apr 2026 13:52:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
	Alexander Graf <agraf@csgraf.de>,
	Peter Maydell <peter.maydell@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	kvm@vger.kernel.org,
	qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 32/32] target/arm: implement WFET
Date: Wed, 22 Apr 2026 13:52:49 +0100
Message-ID: <20260422125250.1303100-33-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422125250.1303100-1-alex.bennee@linaro.org>
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
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
v3
  - fix check_wfx_trap(s/false/true/) as it is a WFE
---
 target/arm/tcg/helper-defs.h   |  1 +
 target/arm/tcg/op_helper.c     | 80 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c | 15 ++++---
 3 files changed, 89 insertions(+), 7 deletions(-)

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
index fe34c94e890..112e0c2eb1a 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -620,6 +620,86 @@ void HELPER(wfe)(CPUARMState *env, uint32_t insn_len)
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
+    int target_el = check_wfx_trap(env, true, &excp);
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
index 83b2a6e848f..c8c8a27956b 100644
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

