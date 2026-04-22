Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B72F3E9F9A
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862963; cv=none; b=OegaXm62AlY3+IcG0lbg24P9Y2O8oA/S3WM+gz5+5KesdLiEy61Umjo7qVMutIGXV5VxrsM6lDAcrwBDiolYlJf2AVALJ6hqWzh1btSSEUNcalKLcerK/L0Rxc24sS92T7teGIX/kLs9wA/8s2ShmQ4bhU6V84jL971udau/1lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862963; c=relaxed/simple;
	bh=1sjwDQnfwtBfBFHBgFAZiMEp5XdtibhfxLrN3nLOtuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z5T5gs+/Zn8lr147OlzXlvfC0uFmwJS4Xwyd2Jtlbd2agaeGU+UJP1elt34DtfAy7i4EzzmLrEiI5WSeRl+LQNOWlF/PQlp+uu9bYDx5sODvFDUHAOstZZ+EnG1owGL+kVtR7j4ckRIaJ8+jRv0wq3570P0HeOaU/HuH3J/sN2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ne2sXCz7; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ne2sXCz7"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso71547525e9.3
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 06:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776862960; x=1777467760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=reUwRDuVhNbhnF2K13EHapoGcij9kmY6U8ucQNXXySM=;
        b=ne2sXCz740WBW9TiR2Pn8eciPRjcbg180vcbPHYHjzPdvgDhNNO20f8gu8FMHw4ICv
         zwhsDHvMJegrwxjn9EFT0zdvoDHWGeNpBnI9gPkahAmudUpK+vMvCynqjgju+C9AvT9I
         QJACIXoqhzdwZqVK0nZxewh7YhXHRg+jVE0S0qIuxeah0medmm1LzHNMUg8CD9/dwJhc
         2PzXA71fjCG0mwx+PEBj/CMc050fEp6mfN2enoUUuPCgKWPfDS6R6k5rmIg9JgQIuMt+
         Fxt57B13a5BVCV4+/cc6Kq+BYNhBILCSftFsH3WLb/oOmFm/68Wz+vAenuNosi341K7A
         U+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776862960; x=1777467760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=reUwRDuVhNbhnF2K13EHapoGcij9kmY6U8ucQNXXySM=;
        b=qwLeTKwa1d6t0CTbZLix0ES2Djhi0P96VzIoSRd6KtzbskPO7+ryn/btwLjqA019yU
         DikVgaVrmksv2xOCRVn0/w6DMIqTx39dBTOQ/ry3vfJ+FOQ/hm2TeCJaenvcT3VOn6Rh
         Z5VuCTz+XlpQuT6esplPk2m4AyKtPGssdDD57BI2LLDE9qgi8Drq8k7Pw217yCpO9eRL
         gIcKRJJMRWaOfZRXrJIjDcN1rK385Nt37GD1a+ntOpxEOMgIcpx/8jOjLxVcM0j6RZ+9
         TGX57Gk8o/YURAw9YHrKgEQnMAl9RDWwCVt7yg3YezYvq28hFOG/EhJPrLyp0jClNoqM
         UwKA==
X-Forwarded-Encrypted: i=1; AFNElJ/ygD7QjA44jNZ2Pf9WcaXTRknSCQX4Tx5fRewRxqZmBXzmKXj8N/FAYH79Tg4Fn7rSEXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK452GA0DYjZvRTQpeefqDoWrDs7F6glObwe2Qa8wQElgnP6id
	r+PQcOhLIrqhwCzYeulRC/cRVybyugif0Xa8X5+8ncKuL12nWsqkGqdkliiPtY69TsU=
X-Gm-Gg: AeBDietzBqH7MI1tGmDeQfWRmuNak05sPqGAwTtQhBaecGqxbT2HqA29wv2O1OPptAo
	EO/sVcquS2WAm8wS+smD6drGCRq4LENYuU4IdOpZDx42vt0xv7nQ+mqUGESPkqG7uhGIXTz3kAG
	pZInOafEDBFbUXxlViX93mGIrseQFFZ4zPwSQXn8/3eLZ6BOPrYTFBX5pqVFBR/YD9/KzbSemo3
	iOMr2o7gyGJnM+TF0+CSmqKtn/l04LwYGRqeHwu8v/3wrVw/JHkAaVh2ynVhWUuvx5fpszpt510
	An9U2ezswDtpSMpUvuoZTqKID4XyeaIrw1pvgyCLfrqn8D+XApv8GAx3PuY7yAzdxVUBhffq1/R
	LYxzmiWYSib/NO56Aoj4f7XZwsCNa4rNj4w3sO0DAwiRlfpPY0hNDs0sDzwccTYIRzRuhGUdunn
	iKCK7VKNsUz3M7S2EklC8C31txdWSFdxvrGA==
X-Received: by 2002:a05:600c:8908:b0:48a:58e1:6d02 with SMTP id 5b1f17b1804b1-48a58e16eb2mr53254275e9.19.1776862958236;
        Wed, 22 Apr 2026 06:02:38 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a55dc9f58sm287208155e9.6.2026.04.22.06.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 06:02:36 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id C9F185FC04;
	Wed, 22 Apr 2026 13:52:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
	Alexander Graf <agraf@csgraf.de>,
	Peter Maydell <peter.maydell@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	kvm@vger.kernel.org,
	qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 23/32] target/arm: report register in WFIT syndromes
Date: Wed, 22 Apr 2026 13:52:40 +0100
Message-ID: <20260422125250.1303100-24-alex.bennee@linaro.org>
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

Pass the register number (rd) to the wfit helper and report it in the
syndrome ISS.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - drop stale TODO
  - fixup stale commit comment (WFIT fix already merged)
  - make rv a bool
  - make ti a enum type
---
 target/arm/syndrome.h          | 11 ++++++++++-
 target/arm/tcg/helper-defs.h   |  2 +-
 target/arm/tcg/op_helper.c     |  7 ++++---
 target/arm/tcg/translate-a64.c |  2 +-
 4 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 04a71eebcb5..4d1f1c529e2 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -670,7 +670,14 @@ FIELD(WFX_ISS, RN, 5, 5)
 FIELD(WFX_ISS, COND, 20, 4)
 FIELD(WFX_ISS, CV, 24, 1)
 
-static inline uint32_t syn_wfx(int cv, int cond, int ti, bool is_16bit)
+typedef enum {
+    WFI = 0b00,
+    WFE = 0b01,
+    WFIT = 0b10,
+    WFET = 0xb11
+} wfx_ti;
+
+static inline uint32_t syn_wfx(int cv, int cond, int rn, bool rv, wfx_ti ti, bool is_16bit)
 {
     uint32_t res = syn_set_ec(0, EC_WFX_TRAP);
     res = FIELD_DP32(res, SYNDROME, IL, !is_16bit);
@@ -678,6 +685,8 @@ static inline uint32_t syn_wfx(int cv, int cond, int ti, bool is_16bit)
     res = FIELD_DP32(res, WFX_ISS, CV, cv);
     res = FIELD_DP32(res, WFX_ISS, COND, cond);
     res = FIELD_DP32(res, WFX_ISS, TI, ti);
+    res = FIELD_DP32(res, WFX_ISS, RN, rn);
+    res = FIELD_DP32(res, WFX_ISS, RV, rv);
 
     return res;
 }
diff --git a/target/arm/tcg/helper-defs.h b/target/arm/tcg/helper-defs.h
index 5a10a9fba3b..a05f2258f29 100644
--- a/target/arm/tcg/helper-defs.h
+++ b/target/arm/tcg/helper-defs.h
@@ -55,7 +55,7 @@ DEF_HELPER_2(exception_pc_alignment, noreturn, env, vaddr)
 DEF_HELPER_1(setend, void, env)
 DEF_HELPER_2(wfi, void, env, i32)
 DEF_HELPER_1(wfe, void, env)
-DEF_HELPER_2(wfit, void, env, i64)
+DEF_HELPER_2(wfit, void, env, i32)
 DEF_HELPER_1(yield, void, env)
 DEF_HELPER_1(pre_hvc, void, env)
 DEF_HELPER_2(pre_smc, void, env, i32)
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index aa14f15eb62..652611b4313 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -399,7 +399,7 @@ void HELPER(wfi)(CPUARMState *env, uint32_t insn_len)
             env->regs[15] -= insn_len;
         }
 
-        raise_exception(env, excp, syn_wfx(1, 0xe, 0, insn_len == 2),
+        raise_exception(env, excp, syn_wfx(1, 0xe, 0, false, WFI, insn_len == 2),
                         target_el);
     }
 
@@ -409,7 +409,7 @@ void HELPER(wfi)(CPUARMState *env, uint32_t insn_len)
 #endif
 }
 
-void HELPER(wfit)(CPUARMState *env, uint64_t timeout)
+void HELPER(wfit)(CPUARMState *env, uint32_t rd)
 {
 #ifdef CONFIG_USER_ONLY
     /*
@@ -428,6 +428,7 @@ void HELPER(wfit)(CPUARMState *env, uint64_t timeout)
     int target_el = check_wfx_trap(env, false, &excp);
     /* The WFIT should time out when CNTVCT_EL0 >= the specified value. */
     uint64_t cntval = gt_get_countervalue(env);
+    uint64_t timeout = env->xregs[rd];
     /*
      * We want the value that we would get if we read CNTVCT_EL0 from
      * the current exception level, so the direct_access offset, not
@@ -448,7 +449,7 @@ void HELPER(wfit)(CPUARMState *env, uint64_t timeout)
 
     if (target_el) {
         env->pc -= 4;
-        raise_exception(env, excp, syn_wfx(1, 0xe, 2, false), target_el);
+        raise_exception(env, excp, syn_wfx(1, 0xe, rd, true, WFIT, false), target_el);
     }
 
     if (uadd64_overflow(timeout, offset, &nexttick)) {
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 5d261a5e32b..073454b9195 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2064,7 +2064,7 @@ static bool trans_WFIT(DisasContext *s, arg_WFIT *a)
     }
 
     gen_a64_update_pc(s, 4);
-    gen_helper_wfit(tcg_env, cpu_reg(s, a->rd));
+    gen_helper_wfit(tcg_env, tcg_constant_i32(a->rd));
     /* Go back to the main loop to check for interrupts */
     s->base.is_jmp = DISAS_EXIT;
     return true;
-- 
2.47.3

