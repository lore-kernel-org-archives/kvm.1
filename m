Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CC13CAE83
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 10:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776853054; cv=none; b=sW+1fT3l8aGey/N1C98tISRZk7Ynl77o25QbiWDHucCMZTEL/LH4ueZ2KeX5PYVnoSYA3clQvAmLui3+Q1V6eH/BHZLifadlXI+h73NevKp/39+QY+OOse1GcMBWEXuuglYsT+7BIIeprQ/nWpg9FYHCZ7kIVDLaY/km96yUOTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776853054; c=relaxed/simple;
	bh=1sjwDQnfwtBfBFHBgFAZiMEp5XdtibhfxLrN3nLOtuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mmvlibenWiz6p1Zk0RxOeY8T62s04/O6raowGrbz76y1Cl1kuiJHdoCi9anPpqJl9aJuVedQmsoL1p9S8kGeGO8crIsn4fJQTby3j837SKBMGoQ7iE6/nYi41kZMrmFIcGw+hUzyExRycKrGQEYo1NPMKRTIHzpxFdSr45vAPy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D6F9g/4M; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D6F9g/4M"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-43d73422431so4490729f8f.2
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 03:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776853049; x=1777457849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=reUwRDuVhNbhnF2K13EHapoGcij9kmY6U8ucQNXXySM=;
        b=D6F9g/4MPKNS8wwsmraS7hEOz1cnvrTuRetTA7WpbWHaBMjCI6RZfmgBwwhXj5q3QO
         ni4gBPCl1I9vTTN/H3lx5n0eqSJFJmE7wWiVqk8lfNIwObFEwiABEtTZfjyKz8M9Z0hD
         UaReLkPoajJWYT8zht7D5dv8Ri3iNbydpQ/5PFNLh6G4t6bry0VH4SlpgDQrg3BEtlpl
         qkg21uob/KGzBgg1jhPDwLGEgvc/9M0fAAwqXcukev+BniCJM76ubyFkv02gb+skboJm
         QPVkH0mY1lLN09FIITkxd7/7uzwHr7SSeJOMIzNU+6xx02FzgB/ZNMuXHBX3PdoLOZUe
         IYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776853049; x=1777457849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=reUwRDuVhNbhnF2K13EHapoGcij9kmY6U8ucQNXXySM=;
        b=Xa2MmQ+rJmjvZxrIcBMcRxb6pRpti7fohKqKAG7CRmZYiD44eY+3rZ1+2oJJZY3xRq
         Y+SXxWOoKQKTWNcfel/Ncw+duFkQ3s66dVhnkr/T21wpjNxKtuWY23yQdJYuZxF3nK2m
         lr8Kd5Wu++W3Y4DeuiYycD4usInbQTqEjLv7pB1H3O6qGrc8rMDWJvgfCiVibEWptApe
         jwH9SBagyI6rQGLowdiMMY86m4k721K1yu5Z9Yn6BbAri2mbSXn47/3qhDjnUQmU2ta9
         Xk6Eum63TcOGv8dfBN2Mve0Taj4SVJwyvyuiQDySEqhqUozeSh2sxI3BHT0d3ltcbg/e
         wJpg==
X-Forwarded-Encrypted: i=1; AFNElJ9wRAmeO7x3yL0pFp0jjgjNm349rHOjp68F+JyBe1/g0L4YLVkKP46+KRS/4iUkD/YYf7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3BQ6W0dRA5Az4PJnGYuM7gpWxDEGAjG0c9IvnELRMzGiVY8Q4
	OzPwYJE0cWPNkwcXiOidqGoPAdtrFY5aghlRJOkigyENwoCHskCguf7cUQ+5rzL/FqM=
X-Gm-Gg: AeBDiesIteCXxP/LsVTmmeQusgnrHVbFK8NQfgQFAklSyYd0QDJY0kVWmDq7SibaXXf
	HnW2jc7lO3sjNPBOTjB0GfavholI9kT+LK7UPtDWm1//q7NDW+o9ZrPAgvoTxp6Fcg/UPYwIq4X
	D4MQoj/HmJZEi0AMY95aefaSvvQzlCz97v/TParkTcGHOhmmVrybAh9juZZRRGBXqzUhEbUcdwo
	E7sRjxalp4P2UszYY6Pfw0177+FqzeABJS07iSmXlfVxwg5ElzfwRyH7MbYFaX4YvzN+SHcvmTR
	sr7R7qkkWd6x8/lcSxKHf0hIH6st6p0Vkdnw7P+N5XMMGIAClE0jNTo46Ky1ncPd3Vd4A7GnZPJ
	Gy/KXRKufoPO+HR2pKev0rnPKfvxc2DNni1EXP3HQhmSc+RQ0zlijdicTGZ47jolIbv0/c/h/H1
	djGNlJoc3frDE37B3oQrqJPhjetknVqFzIkyShC/6sdV26
X-Received: by 2002:a05:6000:2211:b0:43f:e938:1e67 with SMTP id ffacd0b85a97d-43fe9381e75mr30962580f8f.38.1776853048906;
        Wed, 22 Apr 2026 03:17:28 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d112sm49087054f8f.29.2026.04.22.03.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 03:17:28 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 45F47614FF;
	Wed, 22 Apr 2026 11:10:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
	qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	kvm@vger.kernel.org,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 23/31] target/arm: report register in WFIT syndromes
Date: Wed, 22 Apr 2026 11:10:34 +0100
Message-ID: <20260422101043.1234229-24-alex.bennee@linaro.org>
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

