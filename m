Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48513A381B
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 10:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777545884; cv=none; b=FVWziA0vw4AFW0QPs7h6j0aZP+hrAdesevZNCIIOds0a5amZIrZUVtkNTYRmj+Ifm3LPvQ6NGY+l8kq0cCgirOJzTXJ+GHsSYXwjUt/tpu+xksEywdhsyeCR0URGjuioSSWGzKv9gBnN0D6MBgHuEmO3mms5pwrNSeDRjyp774Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777545884; c=relaxed/simple;
	bh=fBCR8g8NTNYQsUJNJUGzVpjDN08B0C6vrO774/3UiIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rIWa0izZOpOIvmNe97zBnXhmbqGD7IwU5haDIEKclDk4T7h2zaa2gFgXXEDGIsRo7QTHUHA14pQPDypTDmqPPEiVX55erEZwtVaN02iY8jo350dhpGI1p1jJLgzht8sSX03g0x4yyJoUYeJI1zjZinlYoWHxhm/HGM21KyV4iHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ctlnHFXs; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ctlnHFXs"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so7582275e9.2
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 03:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777545881; x=1778150681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcPSBiwzrF8PlqagZ+bzBqOtmIa2hTG8ka0zp0wOeJQ=;
        b=ctlnHFXsgFRzivaXc0nI/4OrfpVfkARlrJT9wRsRu23+xSPS+bmlB2HzEFDWBe93/9
         4Wugq5t5g0/kchDsIXpFm5rLYWOKfTjnrBTrOQGAfAwE8JUlaw7vqDhm51hINCcz9cIf
         ytxfCNuZd8sO3epkG1+ZDn6S92B/TJ7yMLZymwNWL+ABQKHTxxbCH7IKcpEk0Wt+j/Dw
         l5AFsA5LzIK0yuHr6cssQmNy18CV1vXDZRGozuWFPr1XU7wJFqOiGvkCXHS/LEjC95O5
         2P/Zo5qProofHRBYGgPaDy3McBmQdf3rEgffeZRkWNyNwlV6KH4ZSpWP9khP3iVfUVhS
         rvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777545881; x=1778150681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IcPSBiwzrF8PlqagZ+bzBqOtmIa2hTG8ka0zp0wOeJQ=;
        b=MJUWhJRsJLShzttRPNeHWBzjIHS7A3Kfm3rAwunQGITCeHWOwmOUlaAGLRZCyp6Ptm
         yH2kttRcjeSxHEGFnjL0W+WSyG8X4VF7AzgeScRtg636RrOTde29G7kPruSCSmDwOIc+
         6kRj5gMGXDW79MI5ao4GKhXJ34hO7EmBIZ4MRl2R/USmr/ZWGkAl/O58fJXsnSQAr2xM
         yY1HdBCWukYbhrUaTtW1q+yqKqJggt3krL6WUg9VU/en/DKnVwZUWqPvKSdt4yyBU0pY
         QsBFHAxdEGtdt/mkov9qtlDNac4hn2NwgwgCprvaz5o1TTEiqghQekEWLXsu5cReLeXw
         62lA==
X-Forwarded-Encrypted: i=1; AFNElJ+8jNeQ0obU0YurPHsVyKY5DAhF4tAOu0490d6X+PPwUnzt6Ilq6WsT8pbuDEfV9cQHElo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmcXI6eq5itgSqPBqbZTpAD8hIFeJ8GqnQGmFjN/UnuwCy0UQI
	eHu8V4ZbimwRAu0DMwQ1P0Ld9EXZOgcmx4kqH1/YmCo0fPPl8brIv8rjhRRfPKyGzEc=
X-Gm-Gg: AeBDiev+piLTVlHBewiQZEcOgMUU+hu547321IY0Z7XY8O9aYmYHFb7p7eTwVdqWB6c
	szPQdA1eKGFYuYt2oa4xeeCJnGGdVZPKc0k+hZ4g2vgm5Jx+I9rZaPotKHO3Jq2h/aiOohlhf9n
	rLJZppbWUE7MNDuUMmbEcGHTg86g0Z1INPlKFHA/CjHiCdWtaDSQf+Zc+LpsAbl16KJY4Mb5Gna
	1cMTXeNqQxUgmv1EfqQMGohQC6af6aMRtfyoQXozma2+dmSeGr02nECmDBaOMv1j7Bgrbts+S78
	QIL9NmBM8+7qRFEbGV2YRRvLe/GitY161gjY5RUf7zMPwJKjTHJhCq1hsZkSfMHG+gbreQ/DUUt
	4B4GWxVTBlzlL/dTeAL1RzJ/6gR8RyQB6MKo2P0/FpGNA7EtjcGchiNA/wAcuWObnp29x2yXL6u
	nip1JfmmNykgXlOZUvJ7giJbJDKZ4autdC2g==
X-Received: by 2002:a05:600c:3e10:b0:488:bc6a:528d with SMTP id 5b1f17b1804b1-48a844721d9mr41943205e9.22.1777545880894;
        Thu, 30 Apr 2026 03:44:40 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c31c6ddsm39447895e9.27.2026.04.30.03.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 03:44:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 64EE35F944;
	Thu, 30 Apr 2026 11:44:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
	qemu-arm@nongnu.org,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	Alexander Graf <agraf@csgraf.de>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v4 6/7] target/arm: handle the WFE trap case
Date: Thu, 30 Apr 2026 11:44:33 +0100
Message-ID: <20260430104434.1482407-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260430104434.1482407-1-alex.bennee@linaro.org>
References: <20260430104434.1482407-1-alex.bennee@linaro.org>
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
index d0f45522b05..77ac6161e93 100644
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
@@ -592,12 +592,25 @@ void HELPER(wfe)(CPUARMState *env)
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
     /*
      * If the CPU has entered the exclusive region we could sleep
      * until the global monitor moves from Exclusive to Open Access.
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 8b97136e78b..a6f392a28f8 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10938,7 +10938,7 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
          */
         case DISAS_WFE:
             gen_a64_update_pc(dc, 4);
-            gen_helper_wfe(tcg_env);
+            gen_helper_wfe(tcg_env, tcg_constant_i32(4));
             tcg_gen_exit_tb(NULL, 0);
             break;
         case DISAS_WFI:
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 3ab49887ce6..686980b58e3 100644
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

