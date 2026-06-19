Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC3D391851
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 13:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781874345; cv=none; b=u7puX9ftdMBWUISrCDNipFkicvwNlghjxou5d8R5NqwsWKHuxHotyjDDMUbd0SI6wDlc1Cki5VSyDnSZ1gn1Nrp2fdWgud6shGuhqNlxHETvlx4hddjqp9AKOV450lrnPbRvFd/ABtA9CQMOkzN2HFvXL5qAoRr+3Ck5hFltQ8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781874345; c=relaxed/simple;
	bh=5UJs4TtAR1586OVR9lNFEyK1w/OgXJVKLYDjM1ySkns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FsWFhQEPZI6wfNxyGS6uUTsFZ1qI2DVvTPI7afu83R5QM5b8Lw9l0W8MlEDikff+JzdnPoJlNj/GkkcPUlw+mIHT/Fvwjl913JiGs95CWBFpaRaIKVQM6XZm2La3q4iA1J14EcQHgwK0JabsYBK3ig5jiJtr8HpIQsQ735fJ5Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vbjgolNY; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vbjgolNY"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4624c1409c9so1628043f8f.3
        for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 06:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781874342; x=1782479142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVIHfgvOBO+ct2EhyE9pq49O4xVF2moDOiCD7HY29ss=;
        b=vbjgolNYn9bTM+0lP3/s89GLJhZlJuWwb/VobkVAguuzOLxJNirRMfFTaBurqRt/8Z
         tKKWmxMSI81vn+BL8tCIkOO7xVbAzHlf3Q+UkMTTvRxA5PpLkYDKIUD2QKXGIiBmD6Io
         +SF4xgxGDKI44mK93UDJyj6cr9+a5RMIfWcd1FGdo6tREUhmSBgxyTmHX4kXI250+0NS
         6hzy+4xmPu9bU94F7LBgty0Lf+T47PC+I4sPUtrVJTDJzWIreofFQLhX9A7nQWLBqI+V
         9yXYtiPTjDty7urW+cxOUaXm3HJbnw6865EvCMx0tW1J7k4condZkPHETkmbYN72Wslr
         dzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781874342; x=1782479142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MVIHfgvOBO+ct2EhyE9pq49O4xVF2moDOiCD7HY29ss=;
        b=Usx5N6g+kdtPF3Bls5EXEJkgAfeyd5Y4qbXTeJFtBdPjuXrxEqB9Jg8rjtyWr8eu1E
         Q4YV4tlWd6ydRaFn5ukCNja02ysEKMGRO3Vr5LiFcApVsMQJo/yh+SDWj4BDCBbk+EzA
         MfoR043fbam5HqVi0DJnFD0RN791X+WPeXzuxuA6MCQu0lQAe1/hAGKT228RXSOMlYJX
         Fwd5sNn2IU4Ahl2Gd1Pr42BUwDnnblOFdowYgu9Yd0XC8Lz076pqZIst8wWTjkGdMcTU
         rDQ/+ViXZEhWuJQJGvDR8Qhf3SoFfHbGikDR4DQBXWuBmKA7t11/LYl+Q54mHlzw1drD
         EwRA==
X-Forwarded-Encrypted: i=1; AFNElJ8AGjKnZX3b4iXqys7GbBFTqhymRxrl9CUoty2M/YxwzqQG0uandkjE0XK6ssULobBpnyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKbwNOzjCqXQlUK7kMXNiZeoau7SlyUEFoVz6RB9ExIOO8Hspp
	eDGqUk29GdV+mwdh72bmk3iRwIUFBsY1ONi1kjE2gScH8k3jv6tMU+hjF3SnJANaQvI=
X-Gm-Gg: AfdE7cmaW6qhsFBIKUftl6LMst83WDHeGiioUrx0Fy+0p2nPxAJ0V4me5ezF7VR0LbK
	r9E/e0KV131BWIOHFJebiFeRzIHsbaMCil6L6naEcB/ZlIffOiWRjT+5cpbhDWDFTJ2ybi7L5vj
	omILoQPYPRgO6oLBzgW/fek4PyFqtZX5igne+eH+LSiHmSnjJiPQsZ7zGyVdlxGXNFJYyNv6Qw8
	U5cgGHfnaK9pGVBW37bwRL9AXsny++r2L6XKxa4jxA5/hmKvpwHsoTo58+JKalthHTG6jlFbwZF
	FB8ZTO+4PG/e+ZwZgrlKw8H1i8hI6NQ9r4EXrEGB7RIEnX7w9aD++ara1PWIDKFrp2/MjqOt+CH
	haAGc8NzbmCdusfA5sCUOyNhLv63eaNQyaFTNfOU8pwSay92MZ5asG2ELz1UKcOn9Yhar6a6js1
	YTf5EWZrtqF7lS
X-Received: by 2002:a05:600c:c088:b0:492:32f3:a344 with SMTP id 5b1f17b1804b1-4923f594101mr61087015e9.31.1781874342110;
        Fri, 19 Jun 2026 06:05:42 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fcf74b4sm71469645e9.6.2026.06.19.06.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 06:05:40 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id BF5895FAF9;
	Fri, 19 Jun 2026 14:05:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Jamin Lin <jamin_lin@aspeedtech.com>,
	Steven Lee <steven_lee@aspeedtech.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Joel Stanley <joel@jms.id.au>,
	qemu-arm@nongnu.org,
	Troy Lee <leetroy@gmail.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	Kane Chen <kane_chen@aspeedtech.com>,
	Tyrone Ting <kfting@nuvoton.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	kvm@vger.kernel.org,
	Hao Wu <wuhaotsh@google.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v8 5/7] target/arm: implements SEV/SEVL for all modes
Date: Fri, 19 Jun 2026 14:05:34 +0100
Message-ID: <20260619130537.820184-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619130537.820184-1-alex.bennee@linaro.org>
References: <20260619130537.820184-1-alex.bennee@linaro.org>
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

