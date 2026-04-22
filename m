Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E624A23
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 10:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776852649; cv=none; b=GhpoHLfMJ6ScnapFhiP7ikf+zq4SVkC8AkGKUfEzqkkOwlQA4pitx2GGBHSRXpcWP3i6DoMx9DbeVMKZSDTwJqEVOWgVGOrm+ZFd1UEHzv+/hN0ZCbniwKyAFu51NprBSRRk0+IWZX9eQDbkZTGJHpFCVFee8a82CwygmLyIXSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776852649; c=relaxed/simple;
	bh=OyxLZURO8GiEXAXtXsejyj3V0BeHM0o9NxVbdJpXKhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i4wzrCd+TlgrAmkkfvAhZ3d+ZqROMeU7vikXeaRcVJlcQtzjvkVXCNMwh757/D9wBJ6sV34/nkS5j5hA5NyMT94I1MQ10Lq2kUAa22yOaWjtAyxU4mwVypmzYtyRyz/a8+cSc6KeG1kfJI3NKxI1ZkBqwEdD9td9c+zEJ5EfxYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rrQp9+/H; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rrQp9+/H"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso43028165e9.1
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 03:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776852646; x=1777457446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHkkfCdnBgFoOnCKUMnFf3OjHIWwkdSWF2yGrdtfKkY=;
        b=rrQp9+/HCHG0j9BpKdpqEqiUbCVA3MHkVQOnaLAQfKaLvQTjeMRRDpXGXhXSws+vnr
         votGTnTP1Y3K9StNDvQPaWYxohXwidWSPPg7S3o1Bn/hX6FevDh99riSGUmgCZ7sewTL
         PavesfdmsZ+vV9a//t16cK7SzIqql6VwlVfrdvgveDPz5hgVF/on7gut9hL3dRcMHVTX
         RZYUGaKGtdzkrBp0nFF2m1bHiEOUqczkb6ecQTIB5uuxoKGcX+YFfvNl0wl89VAYv7rW
         q3x5ALhkVqsvfXVhp/6UmLnKTfrffdw1ZILSIV1CMw5oM5kXrEJkKJ/bbfVeIIPloWXC
         A7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776852646; x=1777457446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FHkkfCdnBgFoOnCKUMnFf3OjHIWwkdSWF2yGrdtfKkY=;
        b=YcuYypAfTe5x8UOio+gYEoDDTvfgrgO2Jxb/QfoJBrO3kfIKmCoi43MoVEE6ueOH2K
         BFS/ozIYGcSM0dm93h/MuF6vaOxiTBJB2pVKantEc7G1nbbvqr4u19ng6hMyHX2JaOb8
         FFgwwcn036KHqvtw4ku2vabtYpdwloZ0kugFzyHC5vQkjI89DAYv6IRh/06f6CjZf7I6
         A5547F7E1xSdlSgSB4uWpYE86ZuTDcgKzHrobuYC2i3N7YtmZCy2lh0RLPvobLq9dKI/
         gA91Y1I4J9dEe5RwFYZoQ4ppNl13kXW0geM/qagGijSfnxVdmCv4iP085208XTIP+xYQ
         /r1A==
X-Forwarded-Encrypted: i=1; AFNElJ9FRF0AZNQ1e4sx49MozkCgU93b7mXlogKzazFTfzRmAFKFUUI/DjEvhPV8agziZ8eakxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9j4ShollysaVmtgMwv4mjRXjWODuwHA1UR6P51OtrewsKBz9k
	JktgXS630CoWneDKEp5UMhECH4BBg0rXHib/r43moarovhtcdBaJx/2+g+PoUHofH6U=
X-Gm-Gg: AeBDietAdjF6lfLP6vMITPUYFGn8IW4N4maU76ho8ct0hNBAynbClcsh6Ud3EyaDeWX
	UP3h0sZW2PxsZwOBjDgnazyN2ZUfQO7x1a/e+Y1g9g+yZPvXUzR05iL9h7QPC+/XuQszZI6LPBc
	75qKUJBtL2QbRpYM+ZU06hf1JFw/1WPw0eYne9GtiW4ggxevET8LpL/RcfWnWXW1mu9R2R2PWVG
	tLWsc4ZRLTB37Q3yVq/RHn33HGj9PjzfDESI2hlBsSxCbeg7EUp5+kka6MHxm8zokI7cZEi/2Id
	L5X3X6jSzN57slHtcpj+cD2888pSH7p0SWPMujzexYK9iBrEZVQU0f6OeIOrjtHA7SPL01wNMIA
	3UdQBxxV0wG9H4vrbdoraAb+EGxyv7qiFBEvWR6rCxGFpB2q8RmBp7bf9yoH/pJ6wNHbodfxzep
	1inZMse9CQmwqV5odZpt54NHPiblPv5qDbPw==
X-Received: by 2002:a05:600c:4e8f:b0:48a:56cd:5266 with SMTP id 5b1f17b1804b1-48a56cd549bmr77005405e9.4.1776852646131;
        Wed, 22 Apr 2026 03:10:46 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-489fec8f7cbsm172089085e9.11.2026.04.22.03.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 03:10:44 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 965785F943;
	Wed, 22 Apr 2026 11:10:43 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
	qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	kvm@vger.kernel.org,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 02/31] target/arm: migrate system/cp trap syndromes to registerfields
Date: Wed, 22 Apr 2026 11:10:13 +0100
Message-ID: <20260422101043.1234229-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422101043.1234229-1-alex.bennee@linaro.org>
References: <20260422101043.1234229-1-alex.bennee@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Migrate syn_aa64_sysregtrap and co-processor register trap syndromes
to the registerfields API. The co-processor syndromes are split
between single and duel register moves.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - use !is_16bit directly
---
 target/arm/syndrome.h | 124 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 102 insertions(+), 22 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 517fb2368bc..29462aa103c 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -78,7 +78,7 @@ enum arm_exception_class {
 
 /* Generic syndrome encoding layout for HSR and lower 32 bits of ESR_EL2 */
 FIELD(SYNDROME, EC, 26, 6)
-FIELD(SYNDROME, IL, 25, 1)
+FIELD(SYNDROME, IL, 25, 1) /* IL=1 for 32 bit instructions */
 FIELD(SYNDROME, ISS, 0, 25)
 
 typedef enum {
@@ -172,7 +172,7 @@ static inline uint32_t syn_aa64_smc(uint32_t imm16)
 static inline uint32_t syn_aa32_svc(uint32_t imm16, bool is_16bit)
 {
     uint32_t res = syn_set_ec(0, EC_AA32_SVC);
-    res = FIELD_DP32(res, SYNDROME, IL, is_16bit ? 0 : 1);
+    res = FIELD_DP32(res, SYNDROME, IL, !is_16bit);
     res = FIELD_DP32(res, ISS_IMM16, IMM16, imm16);
     return res;
 }
@@ -203,58 +203,138 @@ static inline uint32_t syn_aa64_bkpt(uint32_t imm16)
 static inline uint32_t syn_aa32_bkpt(uint32_t imm16, bool is_16bit)
 {
     uint32_t res = syn_set_ec(0, EC_AA32_BKPT);
-    res = FIELD_DP32(res, SYNDROME, IL, is_16bit ? 0 : 1);
+    res = FIELD_DP32(res, SYNDROME, IL, !is_16bit);
     res = FIELD_DP32(res, ISS_IMM16, IMM16, imm16);
     return res;
 }
 
+/*
+ * ISS encoding for an exception from MSR, MRS, or System instruction
+ * in AArch64 state.
+ */
+FIELD(SYSREG_ISS, ISREAD, 0, 1) /* Direction, 1 is read */
+FIELD(SYSREG_ISS, CRM, 1, 4)
+FIELD(SYSREG_ISS, RT, 5, 5)
+FIELD(SYSREG_ISS, CRN, 10, 4)
+FIELD(SYSREG_ISS, OP1, 14, 3)
+FIELD(SYSREG_ISS, OP2, 17, 3)
+FIELD(SYSREG_ISS, OP0, 20, 2)
+
 static inline uint32_t syn_aa64_sysregtrap(int op0, int op1, int op2,
                                            int crn, int crm, int rt,
                                            int isread)
 {
-    return (EC_SYSTEMREGISTERTRAP << ARM_EL_EC_SHIFT) | ARM_EL_IL
-        | (op0 << 20) | (op2 << 17) | (op1 << 14) | (crn << 10) | (rt << 5)
-        | (crm << 1) | isread;
+    uint32_t res = syn_set_ec(0, EC_SYSTEMREGISTERTRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, SYSREG_ISS, OP0, op0);
+    res = FIELD_DP32(res, SYSREG_ISS, OP2, op2);
+    res = FIELD_DP32(res, SYSREG_ISS, OP1, op1);
+    res = FIELD_DP32(res, SYSREG_ISS, CRN, crn);
+    res = FIELD_DP32(res, SYSREG_ISS, RT, rt);
+    res = FIELD_DP32(res, SYSREG_ISS, CRM, crm);
+    res = FIELD_DP32(res, SYSREG_ISS, ISREAD, isread);
+
+    return res;
 }
 
+/*
+ * ISS encoding for an exception from an MCR or MRC access
+ * (move to/from co-processor)
+ */
+FIELD(COPROC_ISS, ISREAD, 0, 1)
+FIELD(COPROC_ISS, CRM, 1, 4)
+FIELD(COPROC_ISS, RT, 5, 5)
+FIELD(COPROC_ISS, CRN, 10, 4)
+FIELD(COPROC_ISS, OP1, 14, 3)
+FIELD(COPROC_ISS, OP2, 17, 3)
+FIELD(COPROC_ISS, COND, 20, 4)
+FIELD(COPROC_ISS, CV, 24, 1)
+
 static inline uint32_t syn_cp14_rt_trap(int cv, int cond, int opc1, int opc2,
                                         int crn, int crm, int rt, int isread,
                                         bool is_16bit)
 {
-    return (EC_CP14RTTRAP << ARM_EL_EC_SHIFT)
-        | (is_16bit ? 0 : ARM_EL_IL)
-        | (cv << 24) | (cond << 20) | (opc2 << 17) | (opc1 << 14)
-        | (crn << 10) | (rt << 5) | (crm << 1) | isread;
+    uint32_t res = syn_set_ec(0, EC_CP14RTTRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, !is_16bit);
+
+    res = FIELD_DP32(res, COPROC_ISS, CV, cv);
+    res = FIELD_DP32(res, COPROC_ISS, COND, cond);
+    res = FIELD_DP32(res, COPROC_ISS, OP2, opc2);
+    res = FIELD_DP32(res, COPROC_ISS, OP1, opc1);
+    res = FIELD_DP32(res, COPROC_ISS, CRN, crn);
+    res = FIELD_DP32(res, COPROC_ISS, RT, rt);
+    res = FIELD_DP32(res, COPROC_ISS, CRM, crm);
+    res = FIELD_DP32(res, COPROC_ISS, ISREAD, isread);
+
+    return res;
 }
 
 static inline uint32_t syn_cp15_rt_trap(int cv, int cond, int opc1, int opc2,
                                         int crn, int crm, int rt, int isread,
                                         bool is_16bit)
 {
-    return (EC_CP15RTTRAP << ARM_EL_EC_SHIFT)
-        | (is_16bit ? 0 : ARM_EL_IL)
-        | (cv << 24) | (cond << 20) | (opc2 << 17) | (opc1 << 14)
-        | (crn << 10) | (rt << 5) | (crm << 1) | isread;
+    uint32_t res = syn_set_ec(0, EC_CP15RTTRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, !is_16bit);
+
+    res = FIELD_DP32(res, COPROC_ISS, CV, cv);
+    res = FIELD_DP32(res, COPROC_ISS, COND, cond);
+    res = FIELD_DP32(res, COPROC_ISS, OP2, opc2);
+    res = FIELD_DP32(res, COPROC_ISS, OP1, opc1);
+    res = FIELD_DP32(res, COPROC_ISS, CRN, crn);
+    res = FIELD_DP32(res, COPROC_ISS, RT, rt);
+    res = FIELD_DP32(res, COPROC_ISS, CRM, crm);
+    res = FIELD_DP32(res, COPROC_ISS, ISREAD, isread);
+
+    return res;
 }
 
+/*
+ * ISS encoding for an exception from an MCRR or MRRC access
+ * (move to/from co-processor with 2 regs)
+ */
+FIELD(COPROC_R2_ISS, ISREAD, 0, 1)
+FIELD(COPROC_R2_ISS, CRM, 1, 4)
+FIELD(COPROC_R2_ISS, RT, 5, 5)
+FIELD(COPROC_R2_ISS, RT2, 10, 5)
+FIELD(COPROC_R2_ISS, OP1, 16, 4)
+FIELD(COPROC_R2_ISS, COND, 20, 4)
+FIELD(COPROC_R2_ISS, CV, 24, 1)
+
 static inline uint32_t syn_cp14_rrt_trap(int cv, int cond, int opc1, int crm,
                                          int rt, int rt2, int isread,
                                          bool is_16bit)
 {
-    return (EC_CP14RRTTRAP << ARM_EL_EC_SHIFT)
-        | (is_16bit ? 0 : ARM_EL_IL)
-        | (cv << 24) | (cond << 20) | (opc1 << 16)
-        | (rt2 << 10) | (rt << 5) | (crm << 1) | isread;
+    uint32_t res = syn_set_ec(0, EC_CP14RRTTRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, !is_16bit);
+
+    res = FIELD_DP32(res, COPROC_R2_ISS, CV, cv);
+    res = FIELD_DP32(res, COPROC_R2_ISS, COND, cond);
+    res = FIELD_DP32(res, COPROC_R2_ISS, OP1, opc1);
+    res = FIELD_DP32(res, COPROC_R2_ISS, RT2, rt2);
+    res = FIELD_DP32(res, COPROC_R2_ISS, RT, rt);
+    res = FIELD_DP32(res, COPROC_R2_ISS, CRM, crm);
+    res = FIELD_DP32(res, COPROC_R2_ISS, ISREAD, isread);
+
+    return res;
 }
 
 static inline uint32_t syn_cp15_rrt_trap(int cv, int cond, int opc1, int crm,
                                          int rt, int rt2, int isread,
                                          bool is_16bit)
 {
-    return (EC_CP15RRTTRAP << ARM_EL_EC_SHIFT)
-        | (is_16bit ? 0 : ARM_EL_IL)
-        | (cv << 24) | (cond << 20) | (opc1 << 16)
-        | (rt2 << 10) | (rt << 5) | (crm << 1) | isread;
+    uint32_t res = syn_set_ec(0, EC_CP15RRTTRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, !is_16bit);
+
+    res = FIELD_DP32(res, COPROC_R2_ISS, CV, cv);
+    res = FIELD_DP32(res, COPROC_R2_ISS, COND, cond);
+    res = FIELD_DP32(res, COPROC_R2_ISS, OP1, opc1);
+    res = FIELD_DP32(res, COPROC_R2_ISS, RT2, rt2);
+    res = FIELD_DP32(res, COPROC_R2_ISS, RT, rt);
+    res = FIELD_DP32(res, COPROC_R2_ISS, CRM, crm);
+    res = FIELD_DP32(res, COPROC_R2_ISS, ISREAD, isread);
+
+    return res;
 }
 
 static inline uint32_t syn_fp_access_trap(int cv, int cond, bool is_16bit,
-- 
2.47.3

