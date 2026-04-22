Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6669F3C343B
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 10:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776852650; cv=none; b=V2zcL80ZLZ9YfS9z6FDf7aE9s2MB2lsbiVD9/eYk9Bx1mLtp19foerPUdUQy6t8pIRu02Rt7m3pzA4xIwlyewfFYQn0acmGB5ZCAehM/BKtTw+v2L39SgU9hT3j5Y75ChJvtzvSRgJj5tvvUdKtMsLOAOALJC194stQfQ1LCETM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776852650; c=relaxed/simple;
	bh=bYemOgspePmeaqmUCYoPxDtN1q3xjpepu010l+autWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jhAznqzRjzCXPe6XZX71bPRuVh+RIxy6qguXEEk4AP6jzo0zofDmabxDlEzdk+UbA8peD8SHaQPiBj+LyHxA2RDgzfVOGnUUsjZ58+VE2Juenh90w5c0bLqhOgQd9fg+YWExhUtwc1W5yNLXbLmBmlkFV8B361iRAblvkALtEoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AKObR3A5; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AKObR3A5"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso31713845e9.2
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 03:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776852646; x=1777457446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFHYYol3fQLtpVQaYQnNjnL8iJcFReh9WH604Hh8s60=;
        b=AKObR3A5budeXM94vNhZrfW5XFeQu/AKWXVeBG+04ZuyPbwLuodoJhCf/hbvPY9vpt
         V5maJSxf1N7W/Bz06nCwZAICxVgvF6WHkaUCseop3cgklcKuNjYgIi5N9HNhNdBTPu79
         EdLLBXh8vZTPPyBSmngxbflNdwD5KB+HU9aBQ7A7EH73ybHU45lEn5TzyLRDnKXVTz9M
         knn7UDNPEtImjs8oMuq5X2xjD8OsUby6u/P5Jf9jEyAyMm7jxp6zkBRfZHIGZfho/6ql
         4Ph83gUdXg0adHKbmCGeC9Hvm0rhoOwWDqTB4apTriQHerG/PMzpv/Fn9tYMO6gFFQdG
         GmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776852646; x=1777457446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SFHYYol3fQLtpVQaYQnNjnL8iJcFReh9WH604Hh8s60=;
        b=qM6PPofAP5OUQjdXQamUxGHsnFhlSQG0FESmp9IzQ9oOPqRR8+OMpAlVbY2SdE7V2m
         opX9JqvLLEHeiEyWL2mFcsLs7CBubgG5IFle92a+AjEBOyVloytwVJh4Hx7yJAdko3on
         3+RQv4s5+R7TnmrynDN5/qdKrIQUbgTBrQExA3OgOYZ/WZcPMcwmijXmFyOhG5Yb863A
         000xgxUaQvokkB2C1rP53tkaQYaH90jcZlsxWxEdFccc4VsxNUCJ0HymB8kqPWLwyjbr
         Ez/t/OFrIlkOfb9C7vI6Og9ExOZaNga1sKOBfc7YlIuefAVnxGgh0R1sMqvJ6IYRCB8c
         +ozQ==
X-Forwarded-Encrypted: i=1; AFNElJ97mOqb9Fk6DImeqZ+0V5+yv8zYHdCmJzVjx4dDDJTuGHUDbIjFuGX8w7So4F0/GVzrlk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaL9nIxRBejQPhSvP7cY5uSsHalz0YsS/KOqNZE7lsilRRK87i
	OwDRHyVZ1JePXk8pwn3AutaGqE+QKr6r4z0tCXQexMj6yXR7JQf7EAamVbeLQ7N9Duc=
X-Gm-Gg: AeBDietEgePpRw33C8GeUuVswd+tfppelkvDbLcGZK+QefrBJj5g9LJwdN70Tu0EoPk
	PWA4NJvjNIOtQxm2xK9OFkFS0DokqLq32gPrNlkHXkiOoO5oDQT6eBBw7KNs+YXTKjpBHu2XmG2
	fEkeBovOjLSTHfO0fqIPF8vwsDQtRI0uqVgFf/bxxLaVkdYrrXHxIAS06udTDIKkJweUzBliBzG
	SSNIGw5SEke5L+yG8rHuI9MtQ7Eq7tSJr9DclAcb2nD5+krHXB8IKS4hgLlUvnAbcDmjUYTiQNH
	AaOdWTAk7F7AYLtTKADJ6731+30aFYOKIMeuhLCtNFnzunKseBMvS9EXDB2Uw0Y+jiKn7dhB+5P
	Ku+U3uBXx9MfHHrgQ1dzhbdNPefnz4nwx6tuSANBWHGE2FiK6LS4wkwkgMRcJdN9VomafYQIr0J
	rhbuKaQ8OMpoqVK0X6LF+eh8o0E7UJocKUgw==
X-Received: by 2002:a05:600c:a103:b0:48a:58e1:6d17 with SMTP id 5b1f17b1804b1-48a58e16ee0mr46804155e9.20.1776852645643;
        Wed, 22 Apr 2026 03:10:45 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1cfbf2sm452139945e9.15.2026.04.22.03.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 03:10:44 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 835395F941;
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
Subject: [PATCH v2 01/31] target/arm: migrate basic syndrome helpers to registerfields
Date: Wed, 22 Apr 2026 11:10:12 +0100
Message-ID: <20260422101043.1234229-2-alex.bennee@linaro.org>
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

