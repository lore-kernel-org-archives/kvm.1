Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAB93E9F76
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 12:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862378; cv=none; b=f74qE+T43iVoK6t6ySpj7zP+l7M+ZQOD/QzMTnxsF4nyLlS8FuWV0y9tnOrd5AtU7bgOK6C3O13bnJtY5ZIyz+51gMC2Gtj26q5xRI1IdKj6bSKtW5bG16Vl7miC5Evw9zIqCYzLwa37wpsJzRcvK4TodVcURvl+XWAWLtwjmGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862378; c=relaxed/simple;
	bh=OyxLZURO8GiEXAXtXsejyj3V0BeHM0o9NxVbdJpXKhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AljM2sV/yEEqpliHhDCIEYNDr21HHyhXR0FJDqW0EYj4d14NLRXHTfGtLRkVgIuuaKAyWtpJiGl7z1QlvhQs2uBkiHszWij9TTi2/6ibrzCMCAEyKKSD4kwENnBjFBsy7oYZtWbrz1H+so2VyhgEuG0zHC739XJT3vMPZqdRGEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c5MYi19M; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c5MYi19M"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso20342305e9.3
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 05:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776862375; x=1777467175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHkkfCdnBgFoOnCKUMnFf3OjHIWwkdSWF2yGrdtfKkY=;
        b=c5MYi19MOzupfBM+uhIekJ/+DYXiUP12hBEVWjlJ3+KAKTZ82LOufoAapAiRwNfHVw
         +J7y16fHXW/4DEWk4woLB6pQG1wor/pA6lB8E9oP/NaiyMLQOmxOxYU+9ACOLBjULv1h
         mxRjCRgCq4t1kpYtiWd0nTrxGFpVcjbvjQJU7LMg6M/eF6NgfENV2C28pp6ZyV8legAf
         qOSogiUApyEl2uTaRvTZTNvA5OeSDyAM0bEqehwb6HFUOOJ3CuLkzSzkOmMO/j1ABcSi
         bbiC3wA3E8l0SpZstPeDrZBYHderIGbaKpR4xY8bbMzGtSbMh/cALy+AvQai8BU0vGky
         pW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776862375; x=1777467175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FHkkfCdnBgFoOnCKUMnFf3OjHIWwkdSWF2yGrdtfKkY=;
        b=aR1tZi/YNtagrhHu1iuMbvP9CugnZoIyOSuWOSB3cVttqRC5T6Z2JXqxysXIRsrqSK
         nWYPqSHnh5JsOUjjdCQISegi8tTYBlUP4BD1Z4WbaoyoGgsyjJfRc5zQDAh19vs5QIkm
         3SED6E9ZJSzWRe50owYaDLXLS/mJSe2GKwywqRGRT+QsYuvsISqeoJvxJCVMiSzZlTg7
         q5tqAG6Ko0Ue+OsF+14Q0GmyBNsDLFRAySHLQp213EyVEo0HfgtABMTcGYpzzR6ZcgVv
         jPgE5JGVcBCkccWXj1SW0A5lXdecsmMDRxQUcKYS0p93PNORCtouGn7LnS0l76ifTdLU
         NMyQ==
X-Forwarded-Encrypted: i=1; AFNElJ+xuNpy8yb2fSCJLYq1aX8o82N1i44TQSoJw/a3piewnYp5MM4Xmlux8SZeBWGDuVKnIPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfu06ZXekFkJT/l+BLpO24KcsacZq+FamPohpec2wJk//nVcg0
	85devdn46pCZpbeDEGIFYAHxtMEkxofMl7m0TZMMvRjasH+xCWkrHmPAEPuKEIuS9OQ=
X-Gm-Gg: AeBDiesEY9NRraHUoEqPE9ok3e4giIqNn2s1k9q53oNVB3CC+iBstOMge84dPJtXMn3
	6ZGOYvpxmdatMi8Fe+ayt7qvPCWnx+yEUST8i4a6U1fTI1YV4gK06BNeNnHQFBSPobxMzL+hthR
	uWrb3CUPWxSNIhrNvvomeLyfqPeyLDqu3c2o8SwfFeh+xgM86wBVcaXHoJD8/fFGZiey9ytKesz
	0hps0GhhQNcFYGkevdcCGsdANBejvq7uxGCw9kTRwewHZ8kPdOcrmcHC7x3kUDkO8RYO+sk/njy
	IswK/Rka2hRLLOQ1hC4LrNGW0UgFw2uVjiFIt6ryauw1/vJ/PARsuOthyiUnFAKcteliEeipjLE
	7Qt5IU/geiv8LrKyLi9avk5PMgs38yWsiXAZLfmNrpI73+Vkz0a6xizGSYBXwb47WL70D8Wy6M2
	jklJy6ETw3rCLC2I4VwD2Zw4AGcClgemeg1Q==
X-Received: by 2002:a05:600c:8284:b0:489:1f3e:5f69 with SMTP id 5b1f17b1804b1-4891f3e629bmr167354805e9.18.1776862374998;
        Wed, 22 Apr 2026 05:52:54 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7a0c13sm141522075e9.21.2026.04.22.05.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 05:52:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 209F25F943;
	Wed, 22 Apr 2026 13:52:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
	Alexander Graf <agraf@csgraf.de>,
	Peter Maydell <peter.maydell@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	kvm@vger.kernel.org,
	qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 02/32] target/arm: migrate system/cp trap syndromes to registerfields
Date: Wed, 22 Apr 2026 13:52:19 +0100
Message-ID: <20260422125250.1303100-3-alex.bennee@linaro.org>
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

