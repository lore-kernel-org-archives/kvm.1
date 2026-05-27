Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628763FBB6A
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 11:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882215; cv=none; b=OYxrTsmA3tt9icxkUWBXCyL+2lj4fodcl2JP63EqF/DHE7x27rJbruci9PwKc3l/FTU46tQXh+g67uBho9kqPIqE0B9oRp82SxMSs9k9ejjWqcSe2lBjSJoy0nWaGoHdxTUD8Y3hpBxYEUM8LYmb/OVYrzUuCxedE98/Wyn9xpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882215; c=relaxed/simple;
	bh=cQzycNrN2XRHUwQq0xpGWNIs5scg8/aRxFbkjC5+S60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uVnEOvXIww/S4iAMO1TyMzimEzV/xQdNyB2u217k/6B8tqFHKAioyjXTxqX1VL6xzLTcFxdrqba11c5kilk/qTqMz1+aX25fJy42e/Cig+87L2oDqC8rk0/9C8hnlqMDMGKb5HNyN/nhazjHYbgD7tlTMUKhMHxSLP4MuKboEYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A0mLqXXw; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A0mLqXXw"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4891b0786beso77782025e9.1
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 04:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779882206; x=1780487006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBl31Y76dj9Fn6xR53TQmxaU3MhNp2vGodHlX1p76nM=;
        b=A0mLqXXwFr2hva7PcoTg8o0u2rAGhWzt7A6Hu1DnR7k32tGh7xkTrB2ShHaGxW7A3z
         aIK5e/2mxqNQoHg+ra3f4uIY+Sj5g6XqMw3iHm4xByL2+1g9c3STXIUI4mpoWPYhBs49
         AQwOkiBZbPxT7dFv2dSsMoxafzNfxc7lAr5/NoIsPj/1WTDjpGSWP5OMYclWH2mEOKuK
         bz6lm7XI7M8onDyr2QfK6Hd3pMgvEbXHEwjcnJdPNweJwfN8elX8EIXruk7U0YWF2qbu
         EkaIJDXUyDY/ehaOp0wF17dpoYsg4TGZeFs88TgKtUNbU3jK8ww4BcrrOo4ZKZrDrKfI
         DgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779882206; x=1780487006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FBl31Y76dj9Fn6xR53TQmxaU3MhNp2vGodHlX1p76nM=;
        b=s+6I33FXl8MwppgTF8zei0CwaKLf/qHPvMRR5FnHcJwTKkGfsLtTlbCDeWroxuaL11
         WUFUbGMskH+PKoBrD07v6E/AJeXbPKDBlAQDn7vMf+oYItb2QhNgdhV0/F4HvQI72Fr1
         I8Cm59FZOJbB2gs+LXNF71p1KZsa0q9OA7K71YL8WN/TNOupdNF8NmYODThzs1BZ8Up5
         u2/8PIkWBR5RMi5gRJSPS6SVkwlho8xzicFXtghB7kxx6/BrfCNZhcWVZKAe+6yzbfMK
         NrNgjcYaoorpnV+ttnKaCodWld0QuCuzytbc1OcrndSdpxcsaUx1FeZJ7eMLxg4bBCCF
         1jxA==
X-Forwarded-Encrypted: i=1; AFNElJ+oPrN1LXnB6kvm0zZqyfz8giYUN3WCqSmWleKVs1dk6i1lrzYBUSngKeEPuMeZ9qbbkmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvSf+EOtnpVFVHrdUldFv2QuiOPt0vtOKGjkZL4N1KNXbD260R
	+nmymBiR1hJDROxs6gwnzilCvZnGKiGZDzXS5v9wIuyto2JlDkFFc2BSMms5Z2tMQ1M=
X-Gm-Gg: Acq92OGTTlP16PpNJ1bxAImMJlbTxwSzCzTnrDKVDRC1pT/lb0twR4x5UubXgOiH581
	8ocX03u15etbkQu7dh7RfmLdv7Kssvg3C+HCpwLWXRpxjsNY142tAmSqCzV939GL+3iHwwRoPn2
	77BetZ8Ljrtq94ptXh43QjdeEsHMv31ETncD8KaltSX1GlOaKEdCcEW9q36euID61PTsGB1Ur5L
	tD1LhaYlDs5es4Cb5vH4GmfSNh0ABowXAFVCc1iGi4Yg8Rf9Q8w0ViAz/MKkqEZFak0y9btKIUk
	cgNvm6ukqtXsac6F/6G2GOVk2RB6o1qtIF07uF+dUeAzrd0NerCiWfPHA2Yp9Bhq5uLj1/qzx5U
	yvlwIbHrEDjis+78Kh8SZc+Fe/tsKaX5qFSy6gYYcfHs9E6VZOivJ6bWaYo0wNY4Gt3xApZT54p
	G7gbJ5u7z42wXKuAw+IwX+6DcV4kgeia5mlQ==
X-Received: by 2002:a05:600c:8b08:b0:490:601f:d785 with SMTP id 5b1f17b1804b1-490601fd90amr251387705e9.2.1779882206437;
        Wed, 27 May 2026 04:43:26 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb557679sm9411055f8f.10.2026.05.27.04.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 04:43:24 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 572CF5FD5B;
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
Subject: [PATCH v6 5/8] target/arm: implements SEV/SEVL for all modes
Date: Wed, 27 May 2026 12:43:17 +0100
Message-ID: <20260527114320.1581552-6-alex.bennee@linaro.org>
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
index d057241e9df..88c5832fcbe 100644
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

