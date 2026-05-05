Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574D2386C37
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 11:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777980022; cv=none; b=lITvmPxNP5gm/nWDVj5WYDJaMxZ17DeDSrUu3UFGZxaSGqpOojTqPN8yyYD3C8zhzqYsG0wLQh4sXngR1+OTUd7uNZSO483WwKYS18wO39pyAeyPF9F2hZV8ldyvOdiSlDdMrnMjxyiIyzkgFSNTWZPQuiEf6dDq4rOHjCN1xC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777980022; c=relaxed/simple;
	bh=55DI8FfKu6fpW4BL+PHePqbhu75roU1vIZwKGVfGCF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sVBfw6bBnVtNx49N5myfyqeN06boWquA8+FFpcz+VrbBvndAnzV0sj/HVQw1s3kYfjm0sCTWbROssvTKJn2FnyOBoejSrOg5TjpDzMoj7l1EMyO34sSGozD7IDHIEgdCs9e5BIHwjIKbRPju/EfZ9nMJSvPCHL3eMRkLnmxuhKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xgpJkjPm; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xgpJkjPm"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d7e23defbso2891193f8f.0
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 04:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777980019; x=1778584819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgMS5WqoQTNwMotfKg5CtyWMirTfACd/41i5C9cIqU0=;
        b=xgpJkjPmFGhVJn3QVhUrIrDVXhS9BpwJv7Tx/EncoY9o5IvMUyGa6xwCXnBdFVpUi0
         kIzjmb7mGvgC/TZMHbnVLCF8OLlp+L2dtrfzjGmKFRB1oRY1D23RiPDgt0uS68Zci4Q4
         jojRLCI9PdCV8GZd6eHEsTissefxxsXjNC0Fp5Bvu1C921BMVx9fZemIgASYrv54EOcP
         xNYMn1J0I7VKBeVOp2iGihlFz4h/k0nGGU+FkBkcZ+Mf5yGSOxU2MKY4CbVFDrU+A9m6
         UPpx1Ao1URq1YDDcq/hSm4Z4oqXEeWmR2rbZ8zKzYfasUV67enKii+Cp4WSrJN9/RVZ9
         bI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777980019; x=1778584819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HgMS5WqoQTNwMotfKg5CtyWMirTfACd/41i5C9cIqU0=;
        b=QWMG6r/YC9QmeNlnpB6G4d9TEF94Vv2PBJt3pzKqzp/1DK6Ybm8wIzzuGURplyFWzC
         SavsZEjtoowq+KAUeHplnDfNvfoP/Dliq9OgPXCNWD/c9xyY/lbq++bF5WCESMIEoKLK
         RCCkWR88yBkvIudihoDOyBip/uzsrWWq1V4Iblge5if2NdBAmIG23Lew7HQGZ8cvd1vc
         0Qag+QjexQy31h4uoWAwZoOGGTVvwRVHnSYz0hTzvpED9bI6dJ7huPaq0JYvE80j11Cs
         onkrna3OtorqqBVR294QWe49GA+DW8DRl0uIWf/3Z8Rg4vceQTzcaJpZMzLOBOWxA5NG
         1ANg==
X-Forwarded-Encrypted: i=1; AFNElJ+xxSm+VWv8F3fB9E0XNA37osobghEY2rgYSvlxCCLMxwCy2FEp5s/DUYIZWb0UvS6thkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKd/4DYvBY9PHvvZDStOBHiM6RsLwUu1HOq52NvNSscGpLHsqe
	nlxjOGVXcoWQSv1Kwd8SKjuoZRo3bqXZbQa2ST4Kfwk6ZL4p3SK/KVF/vIfBF9oIhkNRV2cPiyP
	N3PZ3oqw=
X-Gm-Gg: AeBDievpCzktkCz6TabxXVzvrkC5X21mHCoZaF+b3mlL4P6jAplIrs/0qPSXsyBi4eV
	6mdenPyPG9DBiJrpsozSfLorq+OnCFWzRphppJJfzI+aVHyMxO9DoU+O96jgSBbouev7v+aTF0x
	UsUXjaPQf1lBlaRNyrc5lCuah0lU6NaEskOtaSyyH1bJ0029lFki+DVAGCBVEvJnHtqnaQjbtDI
	RHQmD2roSQu1ts+6f7yyh12ZXQixTts+CKnCL9AY8+dtHQVgaNQozZeX7k3xQx/vA1O6hz1Ww1W
	GGlEAEK/xd69UDKyepmJ+osl0LzqBi07+Wqj/65hAzavnQmh3uMbvzv0lhrfXRTSI6nUVPQyzD4
	IDaGHhqkXJGABIDl+zi5GYj9xsR+2Mlt95OJMFVs5f4fx1Ug2igQ3WmthOmU2b6mn3D9rf4F5aP
	LiBBN3wOd1mAYEPTyq01R+oWxLjBg4MbsDVw==
X-Received: by 2002:a05:6000:61e:b0:43d:7b90:fa23 with SMTP id ffacd0b85a97d-44bb65df7c8mr22454198f8f.29.1777980018492;
        Tue, 05 May 2026 04:20:18 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45054b02c5asm3784684f8f.19.2026.05.05.04.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 04:20:15 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id AF1185FA53;
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
Subject: [PATCH v5 4/7] target/arm: implements SEV/SEVL for all modes
Date: Tue,  5 May 2026 12:20:10 +0100
Message-ID: <20260505112014.102993-5-alex.bennee@linaro.org>
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
index 77fdc5f3a17..340848793d4 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -854,6 +854,24 @@ static inline void gen_restore_rmode(TCGv_i32 old, TCGv_ptr fpst)
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
index 01b1b3e38be..dcb3099dd5c 100644
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
index 25f0a806512..07014717316 100644
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
index ce427c5a3ca..50d0184e84e 100644
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

