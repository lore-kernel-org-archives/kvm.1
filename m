Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B966E3CCFCF
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776852653; cv=none; b=scr6MdbSHYf969aU0D12tmrKrFWp5aUNiParMsuXgDE4Z9lKCsD+g5CE9/Q2voU2UV6wil/yYyy5XeIbZ6guJQUdQSiR0l3Rx6bDXjtYwEhrnwOdaE1x3SZ+KF27wPijNwjqFZAxYujYep1IVFFFZEZO0HmXvZt+B1JFCSge0nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776852653; c=relaxed/simple;
	bh=iYY9W6W5Jzvqbsher67n5RlqDjwiA367i0W/38iriHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aSdP9ZDmeUt3hfgija17m1Py2qbozonhHL4YFnWuwJuy3oH2alBXzrxZ4VISI4XiEC8S4edZptEwQyFPOOWPgbKfK30eg3Fzr+HwUqQmZoJChwdiW7KxiDWu6Bgxd0g8yrBGu8Ux3OJlHyL1OWWNldLPZw8hnIYBTj6eXQNrm64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NwrPCAPT; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NwrPCAPT"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so19851105e9.1
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 03:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776852650; x=1777457450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPvaC3auN+3Ca9Dko/At0hA0QqcpQF6nrnCTiO0WhDI=;
        b=NwrPCAPTycGYBNuvIZsOJN7TW6CkrXmLfgi3yO72KNNOuVMkKgJne6opTCOUb5f9r4
         tBylIxcuLJazqwFOjUyFCIMhhDXD/+NHD5gH1Ji3TpIJ+vUym2a09u/Lw77UrOThBJ8M
         nk8rVubkQuAUJfZhcE6Zv79B9DRgf9o3oOydyfhbDklf8X7ViH7bqU6zpOBJpkx9fx1X
         UJHvQLzNklzQnsiJM6jrDj+FsgCqlzg9z3trARtq6Uihh4A89x54Ln1q7Y2+ebWAeMoh
         muquP3w6Y8H7A3/nDUrSdaePeCQkWfFFA7HYiuJm+pvsvF2vsikXdgxQGxwRRKN+A4Lx
         sfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776852650; x=1777457450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VPvaC3auN+3Ca9Dko/At0hA0QqcpQF6nrnCTiO0WhDI=;
        b=Zgs5llYCQnWjI4R75s7ymnz0r2vUBxBQXU2TUOAiYUmDgjGMttu8s+F21XPQiSeU4F
         cAxVlPHaLF0ScvgCp34GmbUN5i/1IApECu7kf06CsEcGnIORoXWJES5jl+TdPzp4eWnR
         k9qZxHKxtvrl0WlruJf0ZvWK07bmSq/Fz68DKsQjWl0pU3SoE18bgyY169rwYrClQo4T
         D2KDeiFL56LnBPVEggt6kgz1SoJLNWeff8nVCxYGobhVGkPfpG7b10OUVrpFPjcbR0o0
         c8+Z5Th4kFRBs6ObdGfONxDJ2MZuwPs9KZe1ivtdfnCfZ7MhqW8Jxg9Mai62HiK8HkJW
         1VEw==
X-Forwarded-Encrypted: i=1; AFNElJ9BttmSogMN2aivpQiADaonf+5g1hN9cacz6O254D863x7lPDipx3OX14rbTYMgGy0IoWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkQuQjn/41mvy8VJgWdhtA0exqMFHC3/3pAb2Gmt5KnCqlM+c+
	t+FOFQb2Y9GhbPbOqWMLCY4X+towiMF44jP35wX1kMIPSEih4t1ih5q8FTdR1ch7QTA=
X-Gm-Gg: AeBDiev34j+x3FyoP+7/xQtxg7ZyOTXct3/RJ6N+CfdgPa65jv1y18H5FzGWSRZoVkN
	2lm37EGG7V4i+5FEoodtjfh+06GAQ3ZBdFQ74d0r6RBE0J2QJXb7GM33g/VG+dgmPCxiCSUBcPK
	qQJh7XS8BxguXpHb+kuxPjBx2nfx+d4Z1eZBc3tfpl7bFS+JFDJcGhpLvbW7c3bYWl1RAwM8eRG
	4luRxkJ3M7V/0BplM6ZQZJoGZ7Sed3fFn3h6Q+W3O+Os5KfCBwi94bze9sviTt9w23vho/tECpE
	XdWp+dO0iUc7VVWX4LQSpCL+fB4ZQaJJA8DFdYWhx+OmshpDLD9rN4+crfmR1sFHw5+DAv/gWoz
	LxinJPm1h1Qz48IUzrqaoal28b+YFDDhv3Qmxi32wJjLYKDxXTJj1OJq3h4n/XWq0lBMiHdnXSS
	/GvKYJ363ViwyufLFSUZjUZQ3ma9g4Ho2PEA==
X-Received: by 2002:a05:600c:2256:b0:489:1927:5c0 with SMTP id 5b1f17b1804b1-48919270787mr135668195e9.0.1776852650190;
        Wed, 22 Apr 2026 03:10:50 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4daf2sm43294514f8f.33.2026.04.22.03.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 03:10:48 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 3B95360EE9;
	Wed, 22 Apr 2026 11:10:44 +0100 (BST)
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
Subject: [PATCH v2 10/31] target/arm: migrate fault syndromes to registerfields
Date: Wed, 22 Apr 2026 11:10:21 +0100
Message-ID: <20260422101043.1234229-11-alex.bennee@linaro.org>
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

Migrate syn_insn_abort and syn_data_abort_* to the registerfields API.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - use !is_16bit directly
---
 target/arm/syndrome.h | 87 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 74 insertions(+), 13 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index bc65106c61a..2031b3704fb 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -494,20 +494,64 @@ static inline uint32_t syn_gpc(int s2ptw, int ind, int gpcsc, int vncr,
     return res;
 }
 
+/*
+ * ISS encoding for an exception from an Instruction Abort
+ *
+ * (aka instruction abort)
+ */
+FIELD(IABORT_ISS, IFSC, 0, 6)
+FIELD(IABORT_ISS, S1PTW, 7, 1)
+FIELD(IABORT_ISS, EA, 9, 1)
+FIELD(IABORT_ISS, FnV, 10, 1) /* FAR not Valid */
+FIELD(IABORT_ISS, SET, 11, 2)
+FIELD(IABORT_ISS, PFV, 14, 1)
+FIELD(IABORT_ISS, TopLevel, 21, 1) /* FEAT_THE */
+
 static inline uint32_t syn_insn_abort(int same_el, int ea, int s1ptw, int fsc)
 {
-    return (EC_INSNABORT << ARM_EL_EC_SHIFT) | (same_el << ARM_EL_EC_SHIFT)
-        | ARM_EL_IL | (ea << 9) | (s1ptw << 7) | fsc;
+    uint32_t res = syn_set_ec(0, EC_INSNABORT + same_el);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, IABORT_ISS, EA, ea);
+    res = FIELD_DP32(res, IABORT_ISS, S1PTW, s1ptw);
+    res = FIELD_DP32(res, IABORT_ISS, IFSC, fsc);
+
+    return res;
 }
 
+/*
+ * ISS encoding for an exception from a Data Abort
+ */
+FIELD(DABORT_ISS, DFSC, 0, 6)
+FIELD(DABORT_ISS, WNR, 6, 1)
+FIELD(DABORT_ISS, S1PTW, 7, 1)
+FIELD(DABORT_ISS, CM, 8, 1)
+FIELD(DABORT_ISS, EA, 9, 1)
+FIELD(DABORT_ISS, FnV, 10, 1)
+FIELD(DABORT_ISS, LST, 11, 2)
+FIELD(DABORT_ISS, VNCR, 13, 1)
+FIELD(DABORT_ISS, AR, 14, 1)
+FIELD(DABORT_ISS, SF, 15, 1)
+FIELD(DABORT_ISS, SRT, 16, 5)
+FIELD(DABORT_ISS, SSE, 21, 1)
+FIELD(DABORT_ISS, SAS, 22, 2)
+FIELD(DABORT_ISS, ISV, 24, 1)
+
 static inline uint32_t syn_data_abort_no_iss(int same_el, int fnv,
                                              int ea, int cm, int s1ptw,
                                              int wnr, int fsc)
 {
-    return (EC_DATAABORT << ARM_EL_EC_SHIFT) | (same_el << ARM_EL_EC_SHIFT)
-           | ARM_EL_IL
-           | (fnv << 10) | (ea << 9) | (cm << 8) | (s1ptw << 7)
-           | (wnr << 6) | fsc;
+    uint32_t res = syn_set_ec(0, EC_DATAABORT + same_el);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, DABORT_ISS, FnV, fnv);
+    res = FIELD_DP32(res, DABORT_ISS, EA, ea);
+    res = FIELD_DP32(res, DABORT_ISS, CM, cm);
+    res = FIELD_DP32(res, DABORT_ISS, S1PTW, s1ptw);
+    res = FIELD_DP32(res, DABORT_ISS, WNR, wnr);
+    res = FIELD_DP32(res, DABORT_ISS, DFSC, fsc);
+
+    return res;
 }
 
 static inline uint32_t syn_data_abort_with_iss(int same_el,
@@ -517,11 +561,22 @@ static inline uint32_t syn_data_abort_with_iss(int same_el,
                                                int wnr, int fsc,
                                                bool is_16bit)
 {
-    return (EC_DATAABORT << ARM_EL_EC_SHIFT) | (same_el << ARM_EL_EC_SHIFT)
-           | (is_16bit ? 0 : ARM_EL_IL)
-           | ARM_EL_ISV | (sas << 22) | (sse << 21) | (srt << 16)
-           | (sf << 15) | (ar << 14)
-           | (ea << 9) | (cm << 8) | (s1ptw << 7) | (wnr << 6) | fsc;
+    uint32_t res = syn_set_ec(0, EC_DATAABORT + same_el);
+    res = FIELD_DP32(res, SYNDROME, IL, !is_16bit);
+
+    res = FIELD_DP32(res, DABORT_ISS, ISV, 1);
+    res = FIELD_DP32(res, DABORT_ISS, SAS, sas);
+    res = FIELD_DP32(res, DABORT_ISS, SSE, sse);
+    res = FIELD_DP32(res, DABORT_ISS, SRT, srt);
+    res = FIELD_DP32(res, DABORT_ISS, SF, sf);
+    res = FIELD_DP32(res, DABORT_ISS, AR, ar);
+    res = FIELD_DP32(res, DABORT_ISS, EA, ea);
+    res = FIELD_DP32(res, DABORT_ISS, CM, cm);
+    res = FIELD_DP32(res, DABORT_ISS, S1PTW, s1ptw);
+    res = FIELD_DP32(res, DABORT_ISS, WNR, wnr);
+    res = FIELD_DP32(res, DABORT_ISS, DFSC, fsc);
+
+    return res;
 }
 
 /*
@@ -530,8 +585,14 @@ static inline uint32_t syn_data_abort_with_iss(int same_el,
  */
 static inline uint32_t syn_data_abort_vncr(int ea, int wnr, int fsc)
 {
-    return (EC_DATAABORT << ARM_EL_EC_SHIFT) | (1 << ARM_EL_EC_SHIFT)
-        | ARM_EL_IL | ARM_EL_VNCR | (wnr << 6) | fsc;
+    uint32_t res = syn_set_ec(0, EC_DATAABORT_SAME_EL);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, DABORT_ISS, VNCR, 1);
+    res = FIELD_DP32(res, DABORT_ISS, WNR, wnr);
+    res = FIELD_DP32(res, DABORT_ISS, DFSC, fsc);
+
+    return res;
 }
 
 static inline uint32_t syn_swstep(int same_el, int isv, int ex)
-- 
2.47.3

