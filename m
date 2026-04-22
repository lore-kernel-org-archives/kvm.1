Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A843E9F93
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 13:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862952; cv=none; b=rbSxisNDo7hDfETbzwgZNCNkHwys1Yh19L9mXEDOUgtDmsdCEx/N0XpAGqrqd0VWJZIOlpEMUkugAXD0bD96cZINlOb22S+jaHM9s0Z5XVOGKccIeFUsS+z9u9Y0rO1t3qM9N6UbqPnJMAV35P56OKb8UL8dQW++dgq+5Yw3WMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862952; c=relaxed/simple;
	bh=2ZIUo7pKmeIq6DvZMFmzxD0DJ07tGzQq0hxh2isMgWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rjc0w7IKdKc0jUVb60tYR8ht31rm3pHQy9aE2YYOc6ifgcH2eUjeCjZpzb1cILEWfawokFCCL/FchPxrqSxhRwDm+GpL0XaRpgMzonaxkkBlviX3AsxoCRO3vTE7CWKN60HdQXsSoGMx6rURgvOS1CRXOLxr04s+8mJ+310sKlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j6O6JQHP; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j6O6JQHP"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso57782495e9.1
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 06:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776862949; x=1777467749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9iI3ryke1e2JIQkehVmmVgECgG7zvzI0XvyUC6unRY=;
        b=j6O6JQHP9AjnyoGJbf2nx8sPxngU9SaW7v2qbs8ghECs9Tlys/qrMDPO29SEzIKI9k
         J4SXT3hh+OnHJhkhsc/rV57cWk0ExYz6xCFrABLrYUSlYQLmZ2SKvpPBOKctqlX6tX0G
         qtWrPDXPum8O3cKqK7R5xZCPXphzJk6jTjzqOFUsPppy//k8vkoKA/IGYuywxhns9iFJ
         UL7257Hht5p4VGAvDt/OH12gIScWHChwRQ9asJkYGVmc+ZWlvApAYLD6OCeopzcyiA8s
         0PVOflsQa8h8KmZLzxfJA+aFYZdnNaziNUffwrir+mu9DDDtAe3JV+qbZXwz9cSx+fqe
         CLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776862949; x=1777467749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N9iI3ryke1e2JIQkehVmmVgECgG7zvzI0XvyUC6unRY=;
        b=oT05kKJNPQlHv0jCsqa28juY6LOlkCMByNOcpEyxqRYHMAq9Cqvft/ogodClV8YqCw
         wDXeVwaFjd5z8DkVAMxryLVV+F0NJMKBplxcpgzt9utZxh2ZqOZBOFzldlHMxtVNuMMx
         RdjBgfeZRgrEsZJQ5RSt0ejM+CxVTTILEGjS4aOVipEqPm8tvGy2IspMNdREyt96kNp/
         eUcpF2rAezt+ESjUDTcSmTfLLekC7jZlwZv8MM152YF2Q9WCFRF2wz0jcEl41okDi3iK
         M4X0IAlgLxlz6wOlzbQyiXlIifa3ygTz4hcnLgeyEPsBIZG0+TiB3A8DoOj+mgh0El1Z
         UsYA==
X-Forwarded-Encrypted: i=1; AFNElJ8kpWOJ58SONuxnLQ0AqUglq0vPrWPw0TV/6OnWQ9A6Dfyu0e/TLNu/HRyl5My7VdOJPUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWN4L5kJnCZEJXczvhzo6SQf8v4OKL56Y6epL2Qj18BJry/8ut
	lG3IMpPMOZ8C3AwYoYSpFIL+A/r/3BN/DkuP0cGkJ1/fD+3Zaisl/cdJDajYjUaiy0M=
X-Gm-Gg: AeBDies8q4XtBDRH58Lo1suQ+wHl4z/0aSug1wJ6god8i9vo34Axrp9kmMETpxp0orP
	WPiXwHnldbqOEwPmaxcFV9lb5gtwZW79nroTYGf3TYqYVREiv7z8iJhD7d8YQKroGZkMC1E9wdD
	hC/K/+ZnT0pDYdH7nuhALima5cHCg6/jtwSEHRMdUS04UgW1FBNLG8iDevGh65N18PByzIlz88v
	teT8UFlr67ZFTcqcTXNmLdexmHLDZe3Bh4suSNrTTLJFWQsYx5lTYPAzLP3RY1wqhBVQMpIvaep
	wHheiO3pKDqsnWasmYCaLhpDvri/yvjuvFto5XRAGEh/mMR4PVXVIkykwEv1mZEkzk/7PCETTWp
	fARdGZenpik5jHVdWSjSombuL8J4GcvBHScaACQOxRB9ZLskz0bBrsjxhff3OkUFzEisjD2JzeC
	p9a+q0sywtGv29wPHD6pSsjR12ahAYyv8j5Y82BTGQ8ja1
X-Received: by 2002:a05:600c:19d3:b0:48a:55ec:c007 with SMTP id 5b1f17b1804b1-48a55ecc113mr88376885e9.15.1776862948514;
        Wed, 22 Apr 2026 06:02:28 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-489393ddd69sm63804685e9.10.2026.04.22.06.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 06:02:25 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 31F055F93F;
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
Subject: [PATCH v3 27/32] target/arm: implements SEV/SEVL for all modes
Date: Wed, 22 Apr 2026 13:52:44 +0100
Message-ID: <20260422125250.1303100-28-alex.bennee@linaro.org>
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

Remove the restrictions that make this a M-profile only operation and
enable the instructions for all Arm profiles.

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
index 3e3094a463e..9bf2701a56b 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -864,6 +864,24 @@ static inline void gen_restore_rmode(TCGv_i32 old, TCGv_ptr fpst)
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
index 46c745077d5..655e3f96e78 100644
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
index d79c8ab431b..f30df5dbfed 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2032,6 +2032,23 @@ static bool trans_WFI(DisasContext *s, arg_WFI *a)
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
index f9d1b8897d2..59925151fc3 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -3244,17 +3244,20 @@ static bool trans_YIELD(DisasContext *s, arg_YIELD *a)
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

