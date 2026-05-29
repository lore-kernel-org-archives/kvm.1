Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEB03B3894
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 08:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043396; cv=none; b=faccE3JhUK2pUbodO5R6LFIncIEAw9Wkre2BJwHOhprMoDfCbzt02CvlXNQP0D/yBkzdZ6A5MPLhVeFRvDtIjS2fBDu7dCdAQDaAX4FneLWaxCyoypQD9Qf/Pa6v7uHWbSuEYyS4E95fmd+2plsX4IdZycEU4CS0pMbcqqJRZ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043396; c=relaxed/simple;
	bh=lVL1F9hx4apqKk/DqO+AKMbOuaqLn5wvfXzXjJrIUWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fNYV/SJlG1pl+xhJ25B/FP1BDZ31hXmSoqOyLTxcQ5lJjal4N8lZ4pw8ircH8Kj2LmzR+59MfuCk3vfLy82syiCqZdKPWwrA5rH8DVMzTJJgsL81uubqochUv17uPJxMEm1EXfgXBOYVTLZTPMZiBWBOY8vlwOpHR1C79xS5ai0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vTMGFFQP; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vTMGFFQP"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4903997fcb5so79191005e9.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 01:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780043394; x=1780648194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dt2pVSNtYi5awIMi0tBurROv0xQ5d0//K+fOntt40rM=;
        b=vTMGFFQPxMXfcAq39nFUBBDLOEEwnlfDapX++GqCqu+YzvUZxbfnkb8y9VeDdU1Rzo
         r7zzmGw074ilQ50kjw/8LVyqkD+z8fZ64dla/ZU9N9lzYqShZcIa0PIsh29BpledSksJ
         SGbiUw5TxoEaFb3C3UXW4DU2Mkz2egqEh2Jgbrcz8O5FNiHULRzm7chh8+SskwpSKG8J
         uyEV2OfSdQEhCYNmSkjeSZz2H/zFB0dVgIA9/9We5a/xGttN/7v0wv8qDTBgwZESWSgD
         b9gdGZysOSoN7FEKoBMG9F7d9lQPuwTQ0zDrSDvUdWQOuDXGDtgRgIEXq71SXS7er/N3
         srgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780043394; x=1780648194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dt2pVSNtYi5awIMi0tBurROv0xQ5d0//K+fOntt40rM=;
        b=iee9BAVLNYBhHUk0M0DNNsRQCWXESip05b7lmqa4pvApZF5UbRZ6dC1O5vQltCUGTk
         5T9sSk4yfy++i2SdETvhQmaEuKjMMv2YnRaG3Tuv52z1yOaIl+SMqzhWSQKSKa/Q60Sh
         TNdi2W+0rNuQ25mZ0s2hkg9BJKYSUfARfzGtx62qmlsf3J6NFsv5AHWbC/4zZdieIVYm
         WFBR8qz9Jh1Av6PYXXShK18FobBHq/1+bj7stHqUod8I9LgnARhyugefVnKwvt+awtqT
         44yBDfND6I+EjN+wCU9rg5GnKSEn5wVvFZnmzemIEy171oP526yeHK6eMKB+YvFhu3Ug
         DNxg==
X-Forwarded-Encrypted: i=1; AFNElJ8ycAvsqx1FLuFGhcYKlZys6FxAtczcHQvZD4IiziZuJzKfgNYr5UvMjtSWULaQH/oVxg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsrcEu4RHZIyRhTVEYMXvM6G6hRKQftA9JfaWJei4PcHTsal55
	Io6z9jwbs4aVWOpogFO/SmH0ZecLL2aee065shGhCOIisGc0UvsjVHfouMbTKQUrRFHIYPjmROL
	jOw/a
X-Gm-Gg: Acq92OG/156fNiBCdEc4A+L/YPs7C8x8xFFBNxK/QQ9r7URi5QV/0VgGfUpvd48qCbB
	c3PS0iAQYVNhWMFJFd2Vqwj9L+xhf++N4Kl4jynd3pI532R1q9++bI7Y1eEn3sr5rAKvIJrJ9un
	TePT7H3bCVKv9G9whVcPyC9J8zHCkuTAG32o2obCNU9qSqEYzv8BvATeheS7IdNquu5VatkDY0N
	HudMODDyRei/9uGPjFpksPPw+STtcrLFYrZbTt8VmuhQLOzycUFq5D50fAeh91R1IEqJRXitXTW
	chgrV1kmZq2K1NQv7WH/EmHPd8Z3F6sqGoRRW7iSWFPQNJGPMrn5YGTblvBpQxXMPiEzBy3qatT
	joKdtrsD7L1dBOPuUb7Oc5CRYfpQj3Msg1MhDbS1N125pJqPcjdw2u3cHRc9Ykxzbc3kQK/EI1A
	82OqfUNEWYF2iUqDIhI1YQl8/qlsZhFADCVA==
X-Received: by 2002:a05:600c:4504:b0:490:51e2:d992 with SMTP id 5b1f17b1804b1-4909c0b3349mr32182745e9.13.1780043393357;
        Fri, 29 May 2026 01:29:53 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34a0374sm1669634f8f.2.2026.05.29.01.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 01:29:51 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id A9E146036E;
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
Subject: [PATCH v7 5/8] target/arm: implements SEV/SEVL for all modes
Date: Fri, 29 May 2026 09:29:44 +0100
Message-ID: <20260529082948.363931-6-alex.bennee@linaro.org>
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

Remove the restrictions that make this a M-profile only operation and
enable the instructions for all Arm profiles.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
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
 target/arm/tcg/translate.c     | 13 ++++++++-----
 8 files changed, 50 insertions(+), 20 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index d4bcc5bad4c..b71b1d5be66 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -856,6 +856,24 @@ static inline void gen_restore_rmode(TCGv_i32 old, TCGv_ptr fpst)
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
index 02c7264cb99..7ea52ac23b9 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -237,9 +237,8 @@ ERETA           1101011 0100 11111 00001 m:1 11111 11111 &reta  # ERETAA, ERETAB
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
index 504526153a6..2b1fb1e059d 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -476,9 +476,7 @@ void HELPER(sev)(CPUARMState *env)
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
index c20269b1501..4b978c8b958 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2033,6 +2033,23 @@ static bool trans_WFI(DisasContext *s, arg_WFI *a)
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
index c744b163453..e1e5539f571 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -3246,17 +3246,20 @@ static bool trans_YIELD(DisasContext *s, arg_YIELD *a)
 static bool trans_SEV(DisasContext *s, arg_SEV *a)
 {
     /*
-     * Currently SEV is a NOP for non-M-profile and in user-mode emulation.
-     * For system-mode M-profile, it sets the event register.
+     * SEV is a NOP for user-mode emulation.
      */
 #ifndef CONFIG_USER_ONLY
-    if (arm_dc_feature(s, ARM_FEATURE_M)) {
-        gen_helper_sev(tcg_env);
-    }
+    gen_helper_sev(tcg_env);
 #endif
     return true;
 }
 
+static bool trans_SEVL(DisasContext *s, arg_SEV *a)
+{
+    gen_event_reg();
+    return true;
+}
+
 static bool trans_WFE(DisasContext *s, arg_WFE *a)
 {
     /*
-- 
2.47.3

