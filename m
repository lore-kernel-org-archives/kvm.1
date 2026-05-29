Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0F73AD50B
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 08:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043397; cv=none; b=j7jNYgv1YaBZaSdrWIwp7QttNY+mRsc4yJGKL7EBlasIm7RvFnJzgBRkWlRZFeB3eRauuHkc6J2K5ut60ichE/48gsOqevacPmvzH+Nvjl0oAt3mHh3Hgl/039AkCxM7rGmihh7fSFYIbvxKvVxY5cs2FDx3idCXeFzxMCvYO/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043397; c=relaxed/simple;
	bh=kJ45rYKxaNJlm+1DLzdKlY0xk15roM9BU3wCXlD0Iuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dU7ud84nC1f39CspIVVufEAx5cWZCa+1unygndI/yi25dKR6QVvJNMWKIa9o12N8xxhMlafysd2iI/h5DdbN1K6WL16vQPuJs/oqYnnYPfqXxNlzgdQ1nHZdasZJiYM+18m3sqQrkbpPpoBSOBMVzzC4i4SWzPlfgn0EWM1Df20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b2IOePUO; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b2IOePUO"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4904c1ce4c1so77501215e9.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 01:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780043394; x=1780648194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7tgFV7aLv3VEy/7Ybky9gI0Jx+ddlu649tCYp82H6wk=;
        b=b2IOePUOdNR4jzWT3KLuH6xDL5UY8YJS3H4Gti5KKz0N3m9UruFdXqnL107+ju7KAS
         NyB65+Ed6nyhVXtXl1nt+aRk2I3y6D9r8a/oxsPZhgpHiwDfJ9EYrg/HHouePGTpkAnF
         el+9ovLel6qGpCOlMdk29O2z8mNwMXQku/ZOvAQjchLJQfJqokZBHx6GpS2L8poqkR9F
         Q8szCuOu49A/6bzM9LHMaD2B5TFh7Bq06zzMfSMSd9y8wnDW35J2GXpQijw4PmpAhvvo
         UaVrzGjF9o8p+f2bGqdBa8yw1wxTOJJP5CVGaCb3UL0Wl+hOpJCmXPkWpGluoikp8Q9w
         QPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780043394; x=1780648194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7tgFV7aLv3VEy/7Ybky9gI0Jx+ddlu649tCYp82H6wk=;
        b=oKCbuQRSeR8UUzeuy2F+1magvDqZIbc+NV1NhxHlXdduEIVmoVK67TDhQW68omip3i
         Y3Z1HGrEzW1V9BEOA9NpAbgA4TsDcU9dkPwlRp5guWuF02aqgsZWl0NPuoa5Mltt2VuH
         BgHljt6eLgX4jUXcmC/9bDoUsf7uB7gFhQZP9jKStpxzPY/krSytxCVMKYxcekHGvg42
         QaTMxLn/sC+v4PbiIx5ZAlypmDX4qZGv02QUxorH0Jvo03lNDYE4m09pyJB6a8cf9wU7
         nXtij50SS3E4EXF0xDwbYkhye5OLVD9UQ5j4RZBNomqTScLFksR7U18D2sjM0mP7CpdZ
         ZH0Q==
X-Forwarded-Encrypted: i=1; AFNElJ8mSZAKgBUrMHgqlhTMw4NKnlbsU/rQLuWH0ccltzB/cONS5KVGd1/flr4PTqiydQdhciA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3lo9o2UiidweNFvwDOTvYmd66wBR1ldi1usC5+OeQ4OlkmIYe
	ICzRs1YuolQqcBdJ8VNs74CuFnM67Dxcz1aMMeKfust+i7cSf8pLbJjkm6zaIjcIrfo=
X-Gm-Gg: Acq92OFRSNsL4mXqiVgca3DwIfEWQfCqAd/r6jCiO30Q6nJteHKggCZCqhqnWqU9kGL
	ZIP7p9xszVPJgkPvZ/dn8bkXdFGP7Xe7JD3A8nqY3pyVR2Y6lrgN9b5WfExWnxLvytJ7Sf/vWwh
	BX0MLjHsCV4yp7P8DmSLhZF8mzw77m1G4wqG668nGtnRc1eKjItz7qF86cS8b/eY3RswGVwizb3
	xYHM2s8B7YzOTKml2Yhj3qIy9YMYbTQcUeNU89uiVWO3IyJ4QnfJA5zS9LAs8x3/yMftuMU5JCe
	WM8kAF+KPpgpg8jMH0QcBhStEdcxH1LtccXJuXcAuI696IFsYIKESWL6RvnYp0dTyX6hX+9y/Ga
	IE1p2/KKyshfHwSwUzrulBTBevBWqkmYUy21XGrptPPE8dl0EbrpzDYna2ARulDZ9N/vtrhPw3O
	OZBLZu2ndcmkTdC7lfRv5/aYc6AjRPYqpdCNKmqkU/Wxa2
X-Received: by 2002:a05:600c:48aa:b0:490:81cb:d7a with SMTP id 5b1f17b1804b1-4909c0c6b91mr19613565e9.29.1780043393788;
        Fri, 29 May 2026 01:29:53 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d68980csm31925225e9.1.2026.05.29.01.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 01:29:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 091C460E34;
	Fri, 29 May 2026 09:29:49 +0100 (BST)
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
Subject: [PATCH v7 8/8] target/arm: implement WFET
Date: Fri, 29 May 2026 09:29:47 +0100
Message-ID: <20260529082948.363931-9-alex.bennee@linaro.org>
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
index a4603e1a5c7..fb9a212df4b 100644
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

