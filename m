Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B5A3B38A2
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 08:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043397; cv=none; b=J423dFjpMVpp4xgZythwlMCdGXDJ7mb1YtVmNxNKyZMofLwFw7m6+2kg21cYkjXVk4xa/EQxVksQYC5B5pSrFAz8igeAF8vUX8IgPG/0TlCDjiWPrcSNYn347V6mOrjiMUO4d9yP5XWfGnGDqt5lRj6/ITGJdDaPYJjr7WjLbw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043397; c=relaxed/simple;
	bh=27vIX+T16eCYMop7NvGUVs4MC1+HJ+e3lgOMMISKlfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dytu6GRmGtCt82PbOrv+AmmwVxPz50yis6ehoD5nRJGbtZPi15TR1OXhV4FPy+eRSegAmDuVnt+I8ld1xAvPpq4RC/TKF/mJg8qhiGM4wiJSgcfdZk6PUblPoBtwVsqm7caCXbBYSM49Db0fCkIDyBYzJJ6KRJIIEqjdEvNLN2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H6itEPH4; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H6itEPH4"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso118463335e9.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 01:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780043395; x=1780648195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icgEPrF2PyrBaUqEkggw3Y3TmAdUSPZeT980MGVssa8=;
        b=H6itEPH4lKA8II87serx4hcwY8C9YI3VLt8UNRwHn4Nc+WgnMgmGsAIlegeHbPDN3m
         05eA9cHWwNPAJOlEV3z5/lYweLFrh4uSvoql2TIQb8wY61YaHYf3lgov5gVTwQu8bMMi
         BkjS1SHMcO6rQAZ7NliaLEIq5EqmlTiEAtiwbjg6USweCRHhuM2+HkQ1kMS0GMtaIYFU
         6BVql+sVAXv5qTzeClnE6w/URxIcwp3jHqVRsMtXwpgJFCCCQ1oNwMgKRAq4hUUMMzkU
         x/INOGTHBE3KWRzt117LX+yNvJvELPQsSf9S1evNuZ2WseSGNpRX+0kEBWETsESH2mq0
         QCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780043395; x=1780648195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=icgEPrF2PyrBaUqEkggw3Y3TmAdUSPZeT980MGVssa8=;
        b=HyMI0EWhEofFv6sTZdsD47JpdNDimiEjb9EevO9CZnWOYGFFaC3CoYQpVo8o46KI+b
         w10PKUVkWC1s1uCVYrRW8iJ3GafQoPQUcu3yohoZ8iO0ZzCNcojqa3hs92gC5tkc4cSg
         ZDmZzHd5cK4l8yMvkpCjSle9Lge3JWWvWJ+vU8HfXTcHJCMPSVhCTuK0NcEdIU791sJr
         dFRsudRooUPHVMg+0MUYYtlyGb6QpHSfoAfCFKgbrU2KB3ANJsi7oVLvRZtitG5E8XXz
         TbqFTtYld0qFkqGshdq50yIeJI71TahMhlvxIi6SaC53oYyVZnBRXlkvdmWXHysahpS2
         X/dw==
X-Forwarded-Encrypted: i=1; AFNElJ9lmy9gI0QV9QpnfPNDw039UTdVmfNVDjAhtHUwWXbGmcaIklBE9Nexkyw8uYe8hYz2394=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhTRl8BPE7D6x8vD/re/RfxStM+/e23jNt6F0VrGuANZJd2Xrm
	mDRf5OCOG1TqUMRvrhGSEDEREauNXYZ1Tj4ApuB9YtFcWzw6+o6mI8vAyG9iPkPMt7A=
X-Gm-Gg: Acq92OFRSJ8ZdVlDYBaa2bK/PHwRrg3FeQ5z9abYK5knNATg0U31V1MZWFBS27qDoA/
	AJa5ul5VoOQrgd5pTi33swawdZ4EFarjV4jVdihU0HeO94ppVpKmPXyamZ7n6vMOTbwzsLfpPXs
	VWJIW0bYC4SaGpXPGo+EqEhf6za2tTG/gIDc50KAPmK6Xc+sYi0ZFf4VpQK647UMS5I7EDh//47
	LTgcXlLXAF3cQe+D5GLJ9BYIOhdILb4zn71nhVn5pAlG69PaMeGaUAqKHl3k4WVxm7C8ESmaxuy
	eSDfehw4hREK8E+sy+CtHevHPR0LNMFaZLYPfz4luCM5PxWTvT8Uyo15iUKXjmYF4LDfJbisgrw
	dcLin4XRqGGzHkvxAq0gGD6tdsRmUn2CUBv1HVC8sNVQyWONtcw2D2LQ0cBFXQ0b2DdQk/zXMBH
	gxSzTzI/SWPex2FzwPmPhqgolH3ijW9d7Ngg==
X-Received: by 2002:a05:600c:644:b0:485:9a50:3370 with SMTP id 5b1f17b1804b1-4909c07b4c7mr20113755e9.8.1780043394760;
        Fri, 29 May 2026 01:29:54 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c0498e0sm12827755e9.0.2026.05.29.01.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 01:29:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id E1C3160E17;
	Fri, 29 May 2026 09:29:48 +0100 (BST)
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
Subject: [PATCH v7 7/8] target/arm: handle the WFE trap case
Date: Fri, 29 May 2026 09:29:46 +0100
Message-ID: <20260529082948.363931-8-alex.bennee@linaro.org>
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

Now WFE can actually suspend on A-profile we also need to handle when
its trapped. To do this we need to pass the instruction size so we can
deal with the is_16bit syndrome encoding.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v6
  - defer calculating target_el until after the early return
---
 target/arm/tcg/helper-defs.h   |  2 +-
 target/arm/tcg/op_helper.c     | 16 +++++++++++++++-
 target/arm/tcg/translate-a64.c |  2 +-
 target/arm/tcg/translate.c     |  2 +-
 4 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/helper-defs.h b/target/arm/tcg/helper-defs.h
index a05f2258f29..ebdf09be38a 100644
--- a/target/arm/tcg/helper-defs.h
+++ b/target/arm/tcg/helper-defs.h
@@ -54,7 +54,7 @@ DEF_HELPER_2(exception_swstep, noreturn, env, i32)
 DEF_HELPER_2(exception_pc_alignment, noreturn, env, vaddr)
 DEF_HELPER_1(setend, void, env)
 DEF_HELPER_2(wfi, void, env, i32)
-DEF_HELPER_1(wfe, void, env)
+DEF_HELPER_2(wfe, void, env, i32)
 DEF_HELPER_2(wfit, void, env, i32)
 DEF_HELPER_1(yield, void, env)
 DEF_HELPER_1(pre_hvc, void, env)
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index b803c9bf162..060b155d559 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -574,7 +574,7 @@ static int64_t gt_calc_next_event_stream(CPUARMState *env)
 }
 #endif
 
-void HELPER(wfe)(CPUARMState *env)
+void HELPER(wfe)(CPUARMState *env, uint32_t insn_len)
 {
 #ifdef CONFIG_USER_ONLY
     /*
@@ -592,11 +592,25 @@ void HELPER(wfe)(CPUARMState *env)
      */
     CPUState *cs = env_cpu(env);
     ARMCPU *cpu = env_archcpu(env);
+    uint32_t excp;
+    int target_el;
 
     if (qatomic_xchg(&env->event_register, false)) {
         return;
     }
 
+    /* We might sleep, so now we check to see if we should trap */
+    target_el = check_wfx_trap(env, true, &excp);
+    if (target_el) {
+        if (env->aarch64) {
+            env->pc -= insn_len;
+        } else {
+            env->regs[15] -= insn_len;
+        }
+        raise_exception(env, excp, syn_wfx(1, 0xe, 0, false, WFE, insn_len == 2),
+                        target_el);
+    }
+
     /*
      * If the CPU has entered the exclusive region we could sleep
      * until the global monitor moves from Exclusive to Open Access.
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index ec03eaa3bbd..a4603e1a5c7 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10961,7 +10961,7 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
          */
         case DISAS_WFE:
             gen_a64_update_pc(dc, 4);
-            gen_helper_wfe(tcg_env);
+            gen_helper_wfe(tcg_env, tcg_constant_i32(4));
             tcg_gen_exit_tb(NULL, 0);
             break;
         case DISAS_WFI:
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index c10cc382d15..1f554f6c271 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6836,7 +6836,7 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
             tcg_gen_exit_tb(NULL, 0);
             break;
         case DISAS_WFE:
-            gen_helper_wfe(tcg_env);
+            gen_helper_wfe(tcg_env, tcg_constant_i32(curr_insn_len(dc)));
             /*
              * The helper can return if the event register is set, so we
              * must go back to the main loop to check for events.
-- 
2.47.3

