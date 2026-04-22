Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B0D3DBD66
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 12:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862376; cv=none; b=A1lMgKW1dQCP6ztSx4jgAHjO4XmBRABohMsbc1RUQ2wky6BL4warTf0rH4vnaUAZxIhxQmlWWAFxeD0b6nt4GKr0NdKPzwl4DtXWvkl6rf/q5bbfjz7nVtRo9VIPHcKXKcP6WuMQNHQJW4w7PvC4a0kVgpVhCJJ3dgYxdjhnMLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862376; c=relaxed/simple;
	bh=bYemOgspePmeaqmUCYoPxDtN1q3xjpepu010l+autWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SUIwh3qD4CpXPg2riRBDkqZ57jjlPB5DRZ1duEChvIUbGkdnvV1rQGO4YmUX+GElSY8Pq6losoCsZ+C9c8UqDiPrlp0PhizOV1QduuYc4+jW9fktFp3z48GfrqGk4R/y1o8/t33xw0tOwc1FvUhS6PYWkyV72Xdf/VCOGog+N0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yEg9RZEl; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yEg9RZEl"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso74083145e9.3
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 05:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776862374; x=1777467174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFHYYol3fQLtpVQaYQnNjnL8iJcFReh9WH604Hh8s60=;
        b=yEg9RZEllEYMPuu7k/rjPCm1kMDoWnetovKJqUcGE9bQxm13pRD77NdOHLe8JauJcB
         2z5ru8q4z1WsOFvLC+NpnNe9ehhgzI/pQwuNUGcYoUHGI6bTHQIybfb5MrK/1YWSbFpb
         cHq+Wmhp73nzG8d5l+ec9o0RZCkVxwuGLnCWD2opbGFhGq4oUwMsiw6vbJ00xtXT0j5r
         OLtHf2ZAmhm6LtbDfDni1ojGI7pxusVqjbPZQOkyq0D6V/beJ0WIhJi3SzqShCM3YHMA
         OZhcAPE8CKpZnGfvPdoqSdolYV0V4ydF53IISssk3w5kyRAQwER1JmdX5zX1xruOD0kC
         3lbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776862374; x=1777467174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SFHYYol3fQLtpVQaYQnNjnL8iJcFReh9WH604Hh8s60=;
        b=g+QWbZSlU1n0Z+vAHGLUS0JMt3bZY5fd9nKIkus1HsdjPWwpyb+EQ9xZCFq7V8LIfz
         wUH3CXZSYFFNoX4of0LZW1w8OK70gIfIndwc8usGx308MUY5QU6ZoL5v5js6I4i9XPZq
         dqiwVKFvAiAPIipSrqWMArmjywzrQm5fGdcSzmLPR96t93NXWwOWNtkvcvsuZwPRi+2w
         YVqCSmpP9AKXTyFu8ZJftjl05VCsNhrVoaG9/qXPMQEUisDFXkCnha3UQAbqnJ4m1m90
         Czy0+qUXQQ7Fssa2O5X2VsjR+wv3PNerbTawgnLUgFZqmtOpHjeuSn/Lo06rDycOGQeE
         pehQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Zjffh75xT7FsfSLZRWyaYzHjZTej+iP7sYr13Isf3qJpeTluVqy82p43UfzPi+Ry4uzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYOrmhLwWV0rWtaHqlE2IoJw50a5AgEu5WN0RGw1nKpwOgiEXv
	o3W04QnPqw1nI7gW/ozOWpw58ptORmz5oaTDojgrGh/xTfftv5l9b/dWZNinUopJpa8=
X-Gm-Gg: AeBDieu4z0n6w+DtNT9Uy1SxFrbGVVbFBdTyixKBDX6/xetEK0XWObq8ICasZGlutAC
	Qdp6hJAbbUoHlCggZGDdX44BODOqW1odM+SnNelQc95mF2X8p5cZZLEtDauxFDnm61nUZkb8ab5
	gp/AmuApmOtOcRo05gCFt9kuRd51KXVSlWK0c6MqcrPhLMXXZmJs4iHNZX0gyi8oh5W2rQCqt14
	pQ0LQ299iP5qZOJI7nUxrGV/s4xxGw4C2doMcZLMGDhkAUaNHwbyg0AkMX7E/dXXtqdTopkmQEQ
	wplgXw9ChZCtq9Q3NFDdv3KGeIOnBf0aY/kq0R7sQhlrqTI0PyJhkxrIZdewgAQdNSH7NwaymiP
	7oHYXnx+sQd6f29vw+fqw5w4S76/5VfrmPinkSd2SssGv5f75m6rd2hS+THGN2ihbxJsnv/pR7a
	cKoOFiZ4bsbBmhVP3KW2DKBVFSM74rAUHNPQ==
X-Received: by 2002:a05:600c:a107:b0:489:d1c:d468 with SMTP id 5b1f17b1804b1-4890d1cdaedmr163029735e9.31.1776862373605;
        Wed, 22 Apr 2026 05:52:53 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4ffa8sm46533031f8f.35.2026.04.22.05.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 05:52:51 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 0D4535F941;
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
Subject: [PATCH v3 01/32] target/arm: migrate basic syndrome helpers to registerfields
Date: Wed, 22 Apr 2026 13:52:18 +0100
Message-ID: <20260422125250.1303100-2-alex.bennee@linaro.org>
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

We have a registerfields interface which we can use for defining
fields alongside helpers to access them. Define the basic syndrome
layout and convert the helpers that take the imm16 data directly.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/syndrome.h | 75 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 57 insertions(+), 18 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index bff61f052cc..517fb2368bc 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -25,7 +25,7 @@
 #ifndef TARGET_ARM_SYNDROME_H
 #define TARGET_ARM_SYNDROME_H
 
-#include "qemu/bitops.h"
+#include "hw/core/registerfields.h"
 
 /* Valid Syndrome Register EC field values */
 enum arm_exception_class {
@@ -76,6 +76,11 @@ enum arm_exception_class {
     EC_AA64_BKPT              = 0x3c,
 };
 
+/* Generic syndrome encoding layout for HSR and lower 32 bits of ESR_EL2 */
+FIELD(SYNDROME, EC, 26, 6)
+FIELD(SYNDROME, IL, 25, 1)
+FIELD(SYNDROME, ISS, 0, 25)
+
 typedef enum {
     SME_ET_AccessTrap,
     SME_ET_Streaming,
@@ -113,12 +118,12 @@ typedef enum {
 
 static inline uint32_t syn_get_ec(uint32_t syn)
 {
-    return syn >> ARM_EL_EC_SHIFT;
+    return FIELD_EX32(syn, SYNDROME, EC);
 }
 
 static inline uint32_t syn_set_ec(uint32_t syn, uint32_t ec)
 {
-    return deposit32(syn, ARM_EL_EC_SHIFT, ARM_EL_EC_LENGTH, ec);
+    return FIELD_DP32(syn, SYNDROME, EC, ec);
 }
 
 /*
@@ -133,49 +138,74 @@ static inline uint32_t syn_set_ec(uint32_t syn, uint32_t ec)
  */
 static inline uint32_t syn_uncategorized(void)
 {
-    return (EC_UNCATEGORIZED << ARM_EL_EC_SHIFT) | ARM_EL_IL;
+    uint32_t res = syn_set_ec(0, EC_UNCATEGORIZED);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+    return res;
 }
 
+FIELD(ISS_IMM16, IMM16, 0, 16)
+
 static inline uint32_t syn_aa64_svc(uint32_t imm16)
 {
-    return (EC_AA64_SVC << ARM_EL_EC_SHIFT) | ARM_EL_IL | (imm16 & 0xffff);
+    uint32_t res = syn_set_ec(0, EC_AA64_SVC);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+    res = FIELD_DP32(res, ISS_IMM16, IMM16, imm16);
+    return res;
 }
 
 static inline uint32_t syn_aa64_hvc(uint32_t imm16)
 {
-    return (EC_AA64_HVC << ARM_EL_EC_SHIFT) | ARM_EL_IL | (imm16 & 0xffff);
+    uint32_t res = syn_set_ec(0, EC_AA64_HVC);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+    res = FIELD_DP32(res, ISS_IMM16, IMM16, imm16);
+    return res;
 }
 
 static inline uint32_t syn_aa64_smc(uint32_t imm16)
 {
-    return (EC_AA64_SMC << ARM_EL_EC_SHIFT) | ARM_EL_IL | (imm16 & 0xffff);
+    uint32_t res = syn_set_ec(0, EC_AA64_SMC);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+    res = FIELD_DP32(res, ISS_IMM16, IMM16, imm16);
+    return res;
 }
 
 static inline uint32_t syn_aa32_svc(uint32_t imm16, bool is_16bit)
 {
-    return (EC_AA32_SVC << ARM_EL_EC_SHIFT) | (imm16 & 0xffff)
-        | (is_16bit ? 0 : ARM_EL_IL);
+    uint32_t res = syn_set_ec(0, EC_AA32_SVC);
+    res = FIELD_DP32(res, SYNDROME, IL, is_16bit ? 0 : 1);
+    res = FIELD_DP32(res, ISS_IMM16, IMM16, imm16);
+    return res;
 }
 
 static inline uint32_t syn_aa32_hvc(uint32_t imm16)
 {
-    return (EC_AA32_HVC << ARM_EL_EC_SHIFT) | ARM_EL_IL | (imm16 & 0xffff);
+    uint32_t res = syn_set_ec(0, EC_AA32_HVC);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+    res = FIELD_DP32(res, ISS_IMM16, IMM16, imm16);
+    return res;
 }
 
 static inline uint32_t syn_aa32_smc(void)
 {
-    return (EC_AA32_SMC << ARM_EL_EC_SHIFT) | ARM_EL_IL;
+    uint32_t res = syn_set_ec(0, EC_AA32_SMC);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+    return res;
 }
 
 static inline uint32_t syn_aa64_bkpt(uint32_t imm16)
 {
-    return (EC_AA64_BKPT << ARM_EL_EC_SHIFT) | ARM_EL_IL | (imm16 & 0xffff);
+    uint32_t res = syn_set_ec(0, EC_AA64_BKPT);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+    res = FIELD_DP32(res, ISS_IMM16, IMM16, imm16);
+    return res;
 }
 
 static inline uint32_t syn_aa32_bkpt(uint32_t imm16, bool is_16bit)
 {
-    return (EC_AA32_BKPT << ARM_EL_EC_SHIFT) | (imm16 & 0xffff)
-        | (is_16bit ? 0 : ARM_EL_IL);
+    uint32_t res = syn_set_ec(0, EC_AA32_BKPT);
+    res = FIELD_DP32(res, SYNDROME, IL, is_16bit ? 0 : 1);
+    res = FIELD_DP32(res, ISS_IMM16, IMM16, imm16);
+    return res;
 }
 
 static inline uint32_t syn_aa64_sysregtrap(int op0, int op1, int op2,
@@ -246,7 +276,9 @@ static inline uint32_t syn_simd_access_trap(int cv, int cond, bool is_16bit)
 
 static inline uint32_t syn_sve_access_trap(void)
 {
-    return (EC_SVEACCESSTRAP << ARM_EL_EC_SHIFT) | ARM_EL_IL;
+    uint32_t res = syn_set_ec(0, EC_SVEACCESSTRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+    return res;
 }
 
 /*
@@ -361,12 +393,16 @@ static inline uint32_t syn_wfx(int cv, int cond, int ti, bool is_16bit)
 
 static inline uint32_t syn_illegalstate(void)
 {
-    return (EC_ILLEGALSTATE << ARM_EL_EC_SHIFT) | ARM_EL_IL;
+    uint32_t res = syn_set_ec(0, EC_ILLEGALSTATE);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+    return res;
 }
 
 static inline uint32_t syn_pcalignment(void)
 {
-    return (EC_PCALIGNMENT << ARM_EL_EC_SHIFT) | ARM_EL_IL;
+    uint32_t res = syn_set_ec(0, EC_PCALIGNMENT);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+    return res;
 }
 
 static inline uint32_t syn_gcs_data_check(GCSInstructionType it, int rn)
@@ -388,7 +424,10 @@ static inline uint32_t syn_gcs_gcsstr(int ra, int rn)
 
 static inline uint32_t syn_serror(uint32_t extra)
 {
-    return (EC_SERROR << ARM_EL_EC_SHIFT) | ARM_EL_IL | extra;
+    uint32_t res = syn_set_ec(0, EC_SERROR);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+    res = FIELD_DP32(res, SYNDROME, ISS, extra);
+    return res;
 }
 
 static inline uint32_t syn_mop(bool is_set, bool is_setg, int options,
-- 
2.47.3

