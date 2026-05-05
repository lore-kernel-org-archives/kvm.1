Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7F9387369
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 11:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777980023; cv=none; b=YMHCIZ/b8p5q6eWHdeXlDkL2M75RubGzJTf9hchz5X/Vj+q1Nm5oYEbqrpyECZSC0UvR9KxP1NaMaXO+H8OicjNTBRM/DVI4wcVqDfqWehD/n2+oh/QMrv8lQe3UPq62ABEFAwVxr4IhWT7+QqOqzix1FdZ2Z+S8QaNLPGzpDbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777980023; c=relaxed/simple;
	bh=vCsUCgDAWEy36yVUIh9I7UhPoE5ssEYq36IpmMUUfv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=htSc4pNf4Ctsgbx+yXNVm3XJeSmSNTRtc1X+fwZvmMb2GX3SOxPb6sTb5LKdqOogAxHgFM7m8QJnqTcIZzT101icQnnO2G8ln0MxN4FGv8FJEJV6kN15UqXzxJw9ztnJe0igieKp3kIjpt+IIiGt9kQYwJo7yWMRxy+ki6dCcIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l1zRtNti; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l1zRtNti"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso54217855e9.3
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 04:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777980020; x=1778584820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtXqU1v3S6F08KlnlXStnvY5Za2Hngy695ogoXb86Wc=;
        b=l1zRtNti8+XeT78Wb8xotkRSybEf9ygMkESzTB3GiAK0PxlbScrSxKL1JDtJoWoMMb
         jj10xGo8ZYoDCgGpbbWBfBOjCfB1YI7+kkNv75Vrp7YHjMkor82JGtxwzcdKkrOOODto
         IldQ4kXzuA7/vuh5/nAiOjRAk9x7kQF+o8969TQQLhJhUmnJ9N9h1Ev5nbvdkSxv8SBx
         BXT9J+HLWx7vnLAVFWH9eXzQHhAA/3rAru9Df8Zz9tDqBOwYMgMy3tvvgn+qLxyH4GpL
         XQrHqUUNVMV7hJsvPLdDSHs9Nz7KNW3oo/27XqoZESclotO1/l6b0IuRQnPeqqkgK0Do
         lkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777980020; x=1778584820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qtXqU1v3S6F08KlnlXStnvY5Za2Hngy695ogoXb86Wc=;
        b=bD7RNG1PwhxS36CRmhrSvlCYwsISWgD723/enJAhkgGDYWCckhkDFjMEdLJIHhNs51
         bs3REdErRtBlYpKLS6RFM/AkmV1gcLy4aBdogWJGPC7tHfWiK+W6ruxyCTMWiRvgPquw
         eG3qqCehzocsGdqF2faUlRw5xygjnYC7kb5kQfmlo27O1JCp6IblYvlwayd6twqH5P3x
         ijbhuaIf3prfsAhulI3IXi3wr+hMBprTwh+pqq0ouYiogyCMIOG2xE1CeYRziIiR1q6x
         zUW/6Bk/aBKZ5vgnaYzinBNJJiSwA75UX5sJuJlVYiORLz4KHOs9dtdiPkVlVGmzTWLO
         FPrQ==
X-Forwarded-Encrypted: i=1; AFNElJ+/OpweyiPzgo/NZbfxEfqsbQn5LtheohvFI1WeXnrvS+rL6UQZzyBydGBrFhAhEoLICyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrxn0f8zC5aC9na649Zwdqpqv3YLxRsbJsN7NpW9EqBLu9xmXM
	a1Bi1AMlZ1dbAL94yx6N8+1PU2LTzQMZGIGzkeZT+Wroas6mgffX/rpmQY0T0AnbQAY=
X-Gm-Gg: AeBDiesUgiSiTt4dhvKCj96XKOw3e1GWXbaAcuTIBg5WJUn0CJfc1MwQpj5CpFQczRD
	pVgrUpdYRzSDkQ5+Gxi81cn7UTooqFLo8YIPJ/RYrXfgRwcQkEUdmBLY0oAjsIKZDDgawJlfnFd
	LXR1bJ7J3hXQZGTRGO9qAQUvc9Rjrzr1YeV//0ij21ODEAWihVgfsa0ngy2LgORCpPYywLKEEaN
	n/IRLa1TxstkucU5IC7DXGyIzVdGtNwr/CoskKIg7wCe0QMrY9lOs3dSSmEjbPQ2uFdh+Qe38Y+
	g+oz8wT1mPNVaj2CwLeHBYT7XZJ0hU4ZcxYksjHRA+ldkoNktOp3WdH3q5i3XRfPCbsfT0WjQCO
	gQ7zA+0aDCzt3GjvlhxeS1F9pE+MH3Xl+zEJULCKjVtad7sc8TBFccpaObphbeBpIKK8bmTUhLP
	svs7bdPy4c7yrl+VQOOMxeWI3PwmxpUWkkkg==
X-Received: by 2002:a05:600c:c089:b0:48a:7965:b943 with SMTP id 5b1f17b1804b1-48a98676d56mr196011525e9.29.1777980020274;
        Tue, 05 May 2026 04:20:20 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48d17ff35eesm15818675e9.14.2026.05.05.04.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 04:20:18 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id E06465FAF9;
	Tue, 05 May 2026 12:20:14 +0100 (BST)
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
Subject: [PATCH v5 6/7] target/arm: handle the WFE trap case
Date: Tue,  5 May 2026 12:20:12 +0100
Message-ID: <20260505112014.102993-7-alex.bennee@linaro.org>
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

Now WFE can actually suspend on A-profile we also need to handle when
its trapped. To do this we need to pass the instruction size so we can
deal with the is_16bit syndrome encoding.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/tcg/helper-defs.h   |  2 +-
 target/arm/tcg/op_helper.c     | 13 ++++++++++++-
 target/arm/tcg/translate-a64.c |  2 +-
 target/arm/tcg/translate.c     |  2 +-
 4 files changed, 15 insertions(+), 4 deletions(-)

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
index 8284dacbdf6..1349bcc7929 100644
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
@@ -600,6 +600,17 @@ void HELPER(wfe)(CPUARMState *env)
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

