Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FC23F0761
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 11:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882211; cv=none; b=NnhfQiK6cUZyyhT5KPrbyrcWoU7oGOLGN9swQ9FHit/3+AwknLqvJjpMOGKJHp69hkFopYa8DBnGX9Q63wMbSTdJpF0TrAYsme7V+gxzjmLVjQz5I6qTIPQw47XpvmvPaJrg7bEZFOg+5b6ypDVeysmmaaKPXf0bbD0bLqsp1GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882211; c=relaxed/simple;
	bh=m8aOjJrBLfQgdUUE8zyZXG7yCIhh0bB0NzkRC9CoCNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=spZp6FUJI46VfwMGkoFSOUk1i2VBTFd6e17CMM21E9GPEl9GP8rsASMPTTbY5f/kkJaJs4ClWhEAzZWkPKavOkZxJSmKJu8ALEGUlcAL7PvcyznsKFZZrZ9oWPETsSmIpoSIzL1DGoIe16dZj8iDpB5ChcdTF9C0gq6MARoWxGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dpc84+Ef; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dpc84+Ef"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso80055245e9.2
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 04:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779882206; x=1780487006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nGT9Jp4pthasA5g2F4sYzBBA0JTzuDlDIySeJkpXWw=;
        b=dpc84+EfBb6hwjFC4FQ0g4DZhde204fs0ShtzJDn4haYv/f7kUj1wyMrf5OLfQzdz5
         vkeS73QOJFXyq/KtPLndssCnenWZ5p9N//TCCgClGKB39ObpoDu7Dbt7BT8VXeSXLUM0
         H32CjHzhSjmAlkzpG4QgkZvm0heh05+4e5IQib0jodt8gxn/sshFAsMZxcAIO+7+BeVT
         fy9EHkiYT3v8qygGsjcWllIGuFI5MULGj+YSaXf/ZgadJfnP1VVpjFNbW5Xlb2AahZdH
         soa3vAy69X+/2I9t/v1YU3F1x5MUKIhWziHZu2CV9I/0piscaqTZ+ZbYE1fmYqABvkTt
         syTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779882206; x=1780487006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0nGT9Jp4pthasA5g2F4sYzBBA0JTzuDlDIySeJkpXWw=;
        b=I5O5cYb/qLRenwuH5BIUi+vFsDRoont0OZ3xnlpxTAUOIAVhbCXQ2lcdzKfcYWYnlU
         l3TEXYDYKNg1WSy90ac3wfKH1GO85dGeYZP8QkQEVgBdd9qCqtBbkRdfyrVNfe6MJZ+2
         5fbAzygbunzlwNRL04Tgx0Bm2ns02mCyxRkQ9qUbApUT8q4a9ClGw9aUNNiEL4dWB75A
         MB5s5g9fJ0BoJVaCLJTACu/skoYeavrOdT2OJ1mBaBIL/KVnGgz14izd3EHCsw63RHDD
         6bKkwkDnV8prW1DJrQ0dBebj4Z33l9Sd0dNOdq/dVJLmqSGnU70cE/byc5QwFReXMN7y
         lRbw==
X-Forwarded-Encrypted: i=1; AFNElJ/iCxcmyVefivtfUdR40gSfQMF+HuXzClIgItfDyfSBsYOUFWpFUlQkboJv/8CU4JNerII=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR8LWu74qZoXTo/BZHwW4yO0G+NTj1V3SCTa+tXlgI/LQZnMiX
	L7dfjLew6zdBOupK2BNgxXZx9UhDrPeQyMMA9XJEG7iJr9hMawZW7KOF+TZiRSZkcDY=
X-Gm-Gg: Acq92OFZlLCS1iujA1ucrsTFKAFQD1piORMnqCJBzvwgQcQhJAgwl71KD+krxeINk5+
	wa1uW+RUrvy1A5JggQ15A7w0kV+YQRCqeQlyxKnd3Sd9pVqgA8tFn64Og0sF8UhZb9LtuVI4GYp
	x4amRAo08/QZoOq0ZkgpkOz8Kl5vVyx35NAThaA2wD9zUbNlAekNHLKLwE1WwGEbgUkVArQuBCU
	pqm45BsinC0kcDEqdds0EJcO/TMxl+t+Gofa5K+TWfD6Cmvhab62nwy393vuMImRCa1B2qmdj83
	BqS3a73NeEHdm1ymX3FvMcPWVIOfbZEwRHbPWWEW+DOojVIHaIBQefDcTlo/6JKGhD+tfTbY777
	YKhsPjGlayNd4rWe43kTOeUqef6w6cIl/jshbiE3EJ1tgps76i7gNfbLHUgP/uSGP9AgUKBVD/1
	dNJScrSqCRppJ55EebFjHFI2E=
X-Received: by 2002:a05:600c:45d2:b0:490:6237:521d with SMTP id 5b1f17b1804b1-490623753admr219397755e9.13.1779882205893;
        Wed, 27 May 2026 04:43:25 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49045620c05sm389935035e9.14.2026.05.27.04.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 04:43:24 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 8D7045FFEF;
	Wed, 27 May 2026 12:43:21 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Alexander Graf <agraf@csgraf.de>,
	Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v6 7/8] target/arm: handle the WFE trap case
Date: Wed, 27 May 2026 12:43:19 +0100
Message-ID: <20260527114320.1581552-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260527114320.1581552-1-alex.bennee@linaro.org>
References: <20260527114320.1581552-1-alex.bennee@linaro.org>
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
index ee584e9a793..92db4e69b64 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10935,7 +10935,7 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
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

