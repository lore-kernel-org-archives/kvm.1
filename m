Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79F427AC48
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 10:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782297056; cv=none; b=Hhxt+ZDEVThgg3H/62v+2UQqohBJfFAm7B7TOpyGoa01KkNGWV6bCa3WsB6Uv1oQX9GoVpdzb6kuJfhzk8ZLQNvzVYuT6wznfZYu8k75JJ00tRa7ExSzAMeWEFpMezxjKCmJt0yhew8KgvowRHrMdFmDlKSVIC4QBnCVPDP9Qck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782297056; c=relaxed/simple;
	bh=5UJs4TtAR1586OVR9lNFEyK1w/OgXJVKLYDjM1ySkns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z9AIRZwXS6pq6kif4K7q1ANNYgX3/2GHaAg0EzsMuKpT5LJPi8FgBkYheMtbGDi94p369pUzjXHshkFzmC2BQV1WrZW0kUHib6B+BMQpDsldn5R1hUNUxppgQBqL8s96p+Ez3uuzyWzgQk7GtNfTEacSe0Vowb3aKMPG1eVX1G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pGSLwDy1; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pGSLwDy1"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45fd461e4a5so732371f8f.0
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 03:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1782297053; x=1782901853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVIHfgvOBO+ct2EhyE9pq49O4xVF2moDOiCD7HY29ss=;
        b=pGSLwDy1fMvrV3w/6+tmmN9GgZ0zPbGhHSaxuRunD/TZ+0SyjN7n6+XEBaKsLg1KVx
         s7CQ6957KiRcxRO0bRBVs5ctk4jP6EdCN5KVliEL/j734tU8Gml5vD1cnbGAYsHjDytI
         HQrbgbaViBm4OSBd/m5x67bNYArVf+SsOMixRQJt4SJyMW7R0Xraeu98GamNpdHy5ZNt
         9tyaTVws7iMy8GyJMpBnBmx60/Rbz1V6c+tfMVqeErINOoQwv4hF6N5vMc96dRemxYf/
         EUK/POsGGcV2vSLVEcLSgdmZIMPjJzKjYeHYmCWeByUZIH5fcyx99zqq4D7VraBGj5tt
         7QWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782297053; x=1782901853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MVIHfgvOBO+ct2EhyE9pq49O4xVF2moDOiCD7HY29ss=;
        b=M5evZHMnKjLw3ErG4t2BQ6bBsnOGJTSRz4+EIilpqkuCUyMy0za3XuvhgMJRy4T1TV
         HwvIcOlmEZJXsqyMNiCfUIyJva9BKSwNBelPupV/14rJZPmP5BKF3AJLI33bRTTX53yi
         pfO2CHEGV4sBHdSyltKKWjcxoMrn/pgZLnBxo+RVEc890HllYhGc+hE+ycSRhhzHwyOR
         uV7EWgXNjOREdmVvfOMyiRMC29iT3qv3ZP/W+yYYJUI/aRqseYTAxzOhpx7jZYafXP0p
         xGFZ4HVqwEiMj+/BFEGn6VB9MkKGVhp9ljArMKjnA293NBYvMAcyaDeUnTr3S0DKEcgL
         Hmww==
X-Gm-Message-State: AOJu0YxZmQst+FwGCbF8tnRVhT9OHDlxS/dbYtKNQOdvP0awfBCGLA/R
	5bisYTXBc4NPpwsp2mpbGFxUtnstEn5VmM85oBG4MgHCC+SPe0LfX83FhfipTxImLZM=
X-Gm-Gg: AfdE7cnli9gqiL91lIAQpDZk+tDivxLXs9J2KYPasumBc8qFSyBxq2xsc0PV3Tp3/yC
	wsvnIZ7R9y+KHIsCUHusK86r0G1pQF6xUdM73FbmRUq6jamXYp42IvBmF4ai3r056KgOUypDAZf
	amYS3FTznVtQdXX7RkIvUWbtXGp50g0k2VR5qQutXTBNV3PGOYvR4Mo+C1jWA1w2odcY7634H71
	dws8ohIdnwXNJzVP8NHpq+ubNKACYat9rzrKxeksJTONGsbLGIUZHVNz8KHUfHuRZ7dO9gWL8TF
	3tNs22dAB0rkYknNzalRMCZitwzEXLO+JXI7M/KJ0TGjkL3ZrExXUasg5VX2S9ojEVlNXABMUU3
	SAtUfX6BOdCNwJDFD+WQDL5EB/rh9wF1dzCyDub2wUK+7OzqPG8vW8rd4fikQTU6W1rKROcv0jU
	51eF8WHeABWJtX
X-Received: by 2002:a05:6000:40e0:b0:461:d2ee:2fcc with SMTP id ffacd0b85a97d-46adb587753mr11075293f8f.43.1782297053119;
        Wed, 24 Jun 2026 03:30:53 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c22c680fasm5593358f8f.34.2026.06.24.03.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 03:30:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 374115FA5C;
	Wed, 24 Jun 2026 11:30:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	Troy Lee <leetroy@gmail.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Hao Wu <wuhaotsh@google.com>,
	Kane Chen <kane_chen@aspeedtech.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Steven Lee <steven_lee@aspeedtech.com>,
	Joel Stanley <joel@jms.id.au>,
	Jamin Lin <jamin_lin@aspeedtech.com>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Tyrone Ting <kfting@nuvoton.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	qemu-arm@nongnu.org,
	Alexander Graf <agraf@csgraf.de>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v9 5/7] target/arm: implements SEV/SEVL for all modes
Date: Wed, 24 Jun 2026 11:30:47 +0100
Message-ID: <20260624103049.884930-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260624103049.884930-1-alex.bennee@linaro.org>
References: <20260624103049.884930-1-alex.bennee@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Remove the restrictions that make this a M-profile only operation and
enable the instructions for all Arm profiles.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - restrict SEV to M profile plus
  - restrict SEVL to V8
v2
  - fix alignment in a32.decode
  - set bool directly, defend with QEMU_BUILD_BUG_ON
  - s/instructions/profiles/
  - share get_event_reg between translate/translate-a64
---
 target/arm/tcg/translate.h     | 18 ++++++++++++++++++
 target/arm/tcg/a32.decode      |  5 ++---
 target/arm/tcg/a64.decode      |  5 ++---
 target/arm/tcg/t16.decode      |  4 +---
 target/arm/tcg/t32.decode      |  4 +---
 target/arm/tcg/op_helper.c     |  4 +---
 target/arm/tcg/translate-a64.c | 17 +++++++++++++++++
 target/arm/tcg/translate.c     | 20 +++++++++++++++++---
 8 files changed, 59 insertions(+), 18 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 462d4c1c74f..83b413ee368 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -860,6 +860,24 @@ static inline void gen_restore_rmode(TCGv_i32 old, TCGv_ptr fpst)
     gen_helper_set_rmode(old, old, fpst);
 }
 
+/*
+ * Event Register signalling.
+ *
+ * A bunch of activities trigger events, we just need to latch on to
+ * true. The event eventually gets consumed by WFE/WFET.
+ *
+ * user-mode treats these as NOPs.
+ */
+
+static inline void gen_event_reg(void)
+{
+#ifndef CONFIG_USER_ONLY
+    TCGv_i32 set_event = tcg_constant_i32(1);
+    QEMU_BUILD_BUG_ON(sizeof_field(CPUARMState, event_register) != 1);
+    tcg_gen_st8_i32(set_event, tcg_env, offsetof(CPUARMState, event_register));
+#endif
+}
+
 /*
  * Helpers for implementing sets of trans_* functions.
  * Defer the implementation of NAME to FUNC, with optional extra arguments.
diff --git a/target/arm/tcg/a32.decode b/target/arm/tcg/a32.decode
index f2ca4809495..547aa2b1490 100644
--- a/target/arm/tcg/a32.decode
+++ b/target/arm/tcg/a32.decode
@@ -192,9 +192,8 @@ SMULTT           .... 0001 0110 .... 0000 .... 1110 ....      @rd0mn
       WFE        ---- 0011 0010 0000 1111 ---- 0000 0010
       WFI        ---- 0011 0010 0000 1111 ---- 0000 0011
 
-      # TODO: Implement SEV, SEVL; may help SMP performance.
-      # SEV      ---- 0011 0010 0000 1111 ---- 0000 0100
-      # SEVL     ---- 0011 0010 0000 1111 ---- 0000 0101
+      SEV        ---- 0011 0010 0000 1111 ---- 0000 0100
+      SEVL       ---- 0011 0010 0000 1111 ---- 0000 0101
 
       ESB        ---- 0011 0010 0000 1111 ---- 0001 0000
     ]
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 28cd1faf61a..81070dac0a6 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -250,9 +250,8 @@ ERETA           1101011 0100 11111 00001 m:1 11111 11111 &reta  # ERETAA, ERETAB
     YIELD       1101 0101 0000 0011 0010 0000 001 11111
     WFE         1101 0101 0000 0011 0010 0000 010 11111
     WFI         1101 0101 0000 0011 0010 0000 011 11111
-    # We implement WFE to never block, so our SEV/SEVL are NOPs
-    # SEV       1101 0101 0000 0011 0010 0000 100 11111
-    # SEVL      1101 0101 0000 0011 0010 0000 101 11111
+    SEV         1101 0101 0000 0011 0010 0000 100 11111
+    SEVL        1101 0101 0000 0011 0010 0000 101 11111
     # Our DGL is a NOP because we don't merge memory accesses anyway.
     # DGL       1101 0101 0000 0011 0010 0000 110 11111
     XPACLRI     1101 0101 0000 0011 0010 0000 111 11111
diff --git a/target/arm/tcg/t16.decode b/target/arm/tcg/t16.decode
index 778fbf16275..9a8f89538ac 100644
--- a/target/arm/tcg/t16.decode
+++ b/target/arm/tcg/t16.decode
@@ -228,10 +228,8 @@ REVSH           1011 1010 11 ... ...            @rdm
     WFE         1011 1111 0010 0000
     WFI         1011 1111 0011 0000
 
-    # M-profile SEV is implemented.
-    # TODO: Implement SEV for other profiles, and SEVL for all profiles; may help SMP performance.
     SEV         1011 1111 0100 0000
-    # SEVL      1011 1111 0101 0000
+    SEVL        1011 1111 0101 0000
 
     # The canonical nop has the second nibble as 0000, but the whole of the
     # rest of the space is a reserved hint, behaves as nop.
diff --git a/target/arm/tcg/t32.decode b/target/arm/tcg/t32.decode
index 49b8d0037ec..8ae277fe112 100644
--- a/target/arm/tcg/t32.decode
+++ b/target/arm/tcg/t32.decode
@@ -369,10 +369,8 @@ CLZ              1111 1010 1011 ---- 1111 .... 1000 ....      @rdm
         WFE      1111 0011 1010 1111 1000 0000 0000 0010
         WFI      1111 0011 1010 1111 1000 0000 0000 0011
 
-        # M-profile SEV is implemented.
-        # TODO: Implement SEV for other profiles, and SEVL for all profiles; may help SMP performance.
         SEV      1111 0011 1010 1111 1000 0000 0000 0100
-        # SEVL   1111 0011 1010 1111 1000 0000 0000 0101
+        SEVL     1111 0011 1010 1111 1000 0000 0000 0101
 
         ESB      1111 0011 1010 1111 1000 0000 0001 0000
       ]
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 9f9ea39be5a..d15062e155f 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -477,9 +477,7 @@ void HELPER(sev)(CPUARMState *env)
     CPUState *cs = env_cpu(env);
     CPU_FOREACH(cs) {
         ARMCPU *target_cpu = ARM_CPU(cs);
-        if (arm_feature(&target_cpu->env, ARM_FEATURE_M)) {
-            target_cpu->env.event_register = true;
-        }
+        target_cpu->env.event_register = true;
         if (!qemu_cpu_is_self(cs)) {
             qemu_cpu_kick(cs);
         }
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 227719ef25b..df5bac22acd 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2142,6 +2142,23 @@ static bool trans_WFI(DisasContext *s, arg_WFI *a)
     return true;
 }
 
+static bool trans_SEV(DisasContext *s, arg_SEV *a)
+{
+    /*
+     * SEV is a NOP for user-mode emulation.
+     */
+#ifndef CONFIG_USER_ONLY
+    gen_helper_sev(tcg_env);
+#endif
+    return true;
+}
+
+static bool trans_SEVL(DisasContext *s, arg_SEV *a)
+{
+    gen_event_reg();
+    return true;
+}
+
 static bool trans_WFE(DisasContext *s, arg_WFI *a)
 {
     /*
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index c744b163453..9079458a297 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -3246,17 +3246,31 @@ static bool trans_YIELD(DisasContext *s, arg_YIELD *a)
 static bool trans_SEV(DisasContext *s, arg_SEV *a)
 {
     /*
-     * Currently SEV is a NOP for non-M-profile and in user-mode emulation.
-     * For system-mode M-profile, it sets the event register.
+     * SEV is a NOP for user-mode emulation. For v6T2 and earlier
+     * non-M-profile cores this encoding is a NOP hint.
      */
 #ifndef CONFIG_USER_ONLY
-    if (arm_dc_feature(s, ARM_FEATURE_M)) {
+    if (arm_dc_feature(s, ARM_FEATURE_M) ||
+        arm_dc_feature(s, ARM_FEATURE_V7)) {
         gen_helper_sev(tcg_env);
     }
 #endif
     return true;
 }
 
+static bool trans_SEVL(DisasContext *s, arg_SEV *a)
+{
+    /*
+     * SEVL only exists for v8A; for M-profile and v7A and earlier
+     * this encoding is an unallocated must-NOP hint.
+     */
+    if (!arm_dc_feature(s, ARM_FEATURE_M) &&
+        arm_dc_feature(s, ARM_FEATURE_V8)) {
+        gen_event_reg();
+    }
+    return true;
+}
+
 static bool trans_WFE(DisasContext *s, arg_WFE *a)
 {
     /*
-- 
2.47.3

