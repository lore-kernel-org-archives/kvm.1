Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE9E3ECBD5
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 12:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862390; cv=none; b=dZxgZvjBolNV6+DADRUiPKqEvdGOL0KUz1oBjehIQiZmDPEbLcKKt7lPUQdSjX9JX18k2AanrhK2RMwOQZAtv2a82jqIvicRoFYfolEMBNuISsyjzSUXV77ElSNaeXO/XrF6sCu82lhkA7+tfh78Y31tbfAQBOIVXPFSB5MsSqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862390; c=relaxed/simple;
	bh=Fv4Ik+Y5aQtSFsn41jxemXsEFcuE/eLMC8vSPPuMzzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tdbm1udR/dWo3sfv3YVEnzuAbUl1NJ6P3FeIy4t4KZot+iIEDRyva2ZAjkymXNquGqtdBFrTBTzg5OIcS2hx4Sn1mlBYI11P9C1bklrvVq/QNw3SAH0U2ZDCynS89fivjG4FVE3GoUjXLVKOKEeCW+WBeEoYhW/8A3jQxV1BIrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DqRd2+r1; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DqRd2+r1"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso74087395e9.3
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 05:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776862387; x=1777467187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kLDDoOYtEyqQijc0QmTmJ1dX5SOzFgUIzyhmwCFraY=;
        b=DqRd2+r1gDhfZxA678JPa8nlLxItU1gQkVz86baM2c3gRP/7L43PO7spEvhYYaE73c
         CPAyc7KKbLSVzjvUC8wvl7xyp5HDg0rJcNoTIz1v8emjsVrxxv5QJL9vac6dsZt20qtt
         8UTHSOhwXZJNRCjr0n2wGecdIQeBMMcPxkfITjWCJFA0zlhlL6nsizO8jVpc/sdvOIDO
         okJsbJRnZcswJ5OH69K0gWudHykK+d4YCBpaasKKDHe8crRKHn+Lv/b3k4RmCMyIek+y
         Y0T2GSgoZj8vWVW9z9+T50ylw7Ki8zmbLYIUHmwQu+FXaZZxd6BQCjQyuj13thWYAzid
         jV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776862387; x=1777467187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7kLDDoOYtEyqQijc0QmTmJ1dX5SOzFgUIzyhmwCFraY=;
        b=O7EbFR3/2zJgf1FOzMpeQ0AsmiwtwJ4Yoa/OFxUATRzERLYMPESm7Uc5TLfnKmtPUf
         OVYYW/yakm1VVbVImM+IUlOfXBO0yzjTE1B0rQBJjtKGOqfhOGWznZDqt/+Gk3ode9mx
         V6YbwRfu52iGiGAtuYKCd2Yd8mG2agmylnZEREsbQtRMc9KGO/fKuwkEUwb/ti7H77Vn
         UZo06D8Mq5Ujz1ERnOG5d9hugsKdHC5K0zm5+yDIci3Zw9K+TxsO0DvR4JiBN33O/iQa
         K7v3Dt0llvFKETTgjTSMdJI9k1peffLpn34lG7d4BPQFM6W7xSEB4potwtLpQptZsAcn
         DSAw==
X-Forwarded-Encrypted: i=1; AFNElJ/FCaiBv4mOXrZO7OWOTWymJVMgESO07FgFo1qcAX5XkdJxlapB2SrZCzk/dQUiSg5YnQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy14p2no09pRnX6OGx6pgDEx+5r/925zK8LC1ucB44jJQziIVcT
	hnnWAKEMUWsWeMjRJdcR4IY9zH/a6d+70ysMEYuraqrwuUI/ejZewuPkoW6p0U9PRIE=
X-Gm-Gg: AeBDiesNexrw9aL7/DUT827vB85yeJb13uORct+NnN0HJ+NvH4Q6W1CAZgejK+OPjIX
	4vXEyLtLvoX69LGGL3psaxO24NodG9OI9kmGeyXKkHyyGCuGyqVlEcMcbYDbOKeiGFB9Dm829pN
	gfXmDPI9IoMsTaAeyz36CKAa1T5asYa4P+0Z6HqNzVWyFYtUi/7fjb6eBSqp8N7wWVJq8ifQYbt
	afqT0M+eoofxzM9nqt3aHPqtNvOq/WEvfzGXSX0js1AHIaT90Dau4vFE6gODjSn+ZAN8HkAPvUP
	1gv15GypcUWbxCtOPgClzpBC+W9Z9dZdSG0PI6vjxdbdgWVPw97AIhfJM+p6nm5ZeYj4eZGTGKD
	jaM4/11wPeBMvIedVJ1k0pWS3yZ8BDRos6ExWPxoagefvA/bl2q1mRGz7aNG3us+CPbcIMwVHFs
	RWFhikxieSeV/nir9EBQmHIwvkcJGDOh6tyA==
X-Received: by 2002:a05:600c:c4a1:b0:488:c014:34da with SMTP id 5b1f17b1804b1-488fb77ed1bmr305546735e9.26.1776862387494;
        Wed, 22 Apr 2026 05:53:07 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb79ecb9sm186670245e9.8.2026.04.22.05.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 05:53:02 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 8C3B0617D8;
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
Subject: [PATCH v3 31/32] target/arm: handle the WFE trap case
Date: Wed, 22 Apr 2026 13:52:48 +0100
Message-ID: <20260422125250.1303100-32-alex.bennee@linaro.org>
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

Now WFE can actually suspend on A-profile we also need to handle when
its trapped. To do this we need to pass the instruction size so we can
deal with the is_16bit syndrome encoding.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/tcg/helper-defs.h   |  2 +-
 target/arm/tcg/op_helper.c     | 15 ++++++++++++++-
 target/arm/tcg/translate-a64.c |  2 +-
 target/arm/tcg/translate.c     |  2 +-
 4 files changed, 17 insertions(+), 4 deletions(-)

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
index 030209360e8..fe34c94e890 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -568,7 +568,7 @@ static int64_t gt_calc_next_event_stream(CPUARMState *env)
 }
 #endif
 
-void HELPER(wfe)(CPUARMState *env)
+void HELPER(wfe)(CPUARMState *env, uint32_t insn_len)
 {
 #ifdef CONFIG_USER_ONLY
     /*
@@ -586,12 +586,25 @@ void HELPER(wfe)(CPUARMState *env)
      */
     CPUState *cs = env_cpu(env);
     ARMCPU *cpu = ARM_CPU(cs);
+    uint32_t excp;
+    int target_el = check_wfx_trap(env, true, &excp);
 
     if (env->event_register) {
         env->event_register = false;
         return;
     }
 
+    /* We might sleep, so now we check to see if we should trap */
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
     /* For A-profile we also can be woken by the event stream */
     if (arm_feature(env, ARM_FEATURE_AARCH64) && cpu->wfxt_timer) {
         int64_t next_event = gt_calc_next_event_stream(env);
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index a1b0cc9508e..83b2a6e848f 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10956,7 +10956,7 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
             break;
         case DISAS_WFE:
             gen_a64_update_pc(dc, 4);
-            gen_helper_wfe(tcg_env);
+            gen_helper_wfe(tcg_env, tcg_constant_i32(4));
             tcg_gen_exit_tb(NULL, 0);
             break;
         case DISAS_YIELD:
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 18d64620e40..c30ea2261da 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6845,7 +6845,7 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
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

