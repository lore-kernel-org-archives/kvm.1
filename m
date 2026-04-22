Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3121B3EAC8A
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 12:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862382; cv=none; b=Txj67/sJpBIxxA1ZU/7yejVqbgZiCCC16x3PGD6XAgOlV3flFo94EkkeiiXEkXlmOgNuOChKvAazdWz73gbqO/SmCyGwSa6xEvyifJe9uS80eUKeppHohGKh/fNm8GDWZZlzaFKxOP8SPETILP5nI8tenXhH3CtYW4iGfKeLjYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862382; c=relaxed/simple;
	bh=iYY9W6W5Jzvqbsher67n5RlqDjwiA367i0W/38iriHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RGUHoDkEtq4k1Gjq0+BK32n0TgZ/0WrCOgItk6RPzoWuRS8dYekPGRnf3QRFi79ULSotd8EbPKo6ZLM65Olu4FT3d3t9C3ivOvwOY1aw8fZr0/+5X8oBSp54hbArAQuquSYFlFXsXHSrr9dayEx5yDZcMe0xjB8hCrPH28B4EQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cDLW3bvF; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cDLW3bvF"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso31619065e9.2
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 05:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776862379; x=1777467179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPvaC3auN+3Ca9Dko/At0hA0QqcpQF6nrnCTiO0WhDI=;
        b=cDLW3bvFVRmIJVba3WfsIrYpj1XUGd4kbwyxZdYQmk9kDw6jbom3qtBZCpWIFeChOq
         Z0TO6CJUcr3K0nZhGEyz1pY6uqB6q/dc1ZaHE6jZMgDO2eq8KYy5V8d4M7vbR/xKNaVo
         1xtWFTKnX7LBMTlZeBg3HC4zWI2vbc0wpDZI9gekV8wx6VArxId9u8jSyRLkMA51+hGn
         0fs0A9arC7M0wFiXPhwEInxYMa1mVkWsMWfWeuGEjuKuRhsFeMwiHxFHxheIGSm6BIbn
         PfqwjPqoYJKY7ojgnRjyBOF1RUTVzO4EKpR9LpA/aGecFsemOB3eujpthLcqLe+Zv6O/
         fW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776862380; x=1777467180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VPvaC3auN+3Ca9Dko/At0hA0QqcpQF6nrnCTiO0WhDI=;
        b=aPFlzjdbyTvWBuCndoiNsOCAJGB7K3Dvw3ilObkJmn+Bw0OPZ1p2KvSMOn4pHIPGIf
         vArGjCjTTWXcog7KnI/mVVsQPpPmIhMBRZpL3aJqW794NAXGZA4r5iyJIB3JgCEkaNsV
         e2GWof77dhMSVGQ7aKRiborNszVAHkUfVOXZ7i2lWR3xngUPUC2x8h7kmbQEAFbN7Khp
         wb/cKJHXwELDMF8vHBMEjW/i0klg1NBPJxgs2K7FKe6EqR15AIJvCkyezYn6tFKOnJdg
         vaJm2GRE2b12GNLdhyWoX6EyVbQjLduk+EFBZg8jYpqq/VEUfI6gtTnmx4A6d+Yf5Ncr
         y5mw==
X-Forwarded-Encrypted: i=1; AFNElJ+y1kwc/b5LnCKMU7tKPVSW/UHXaPQuxojjmepSCt1cYQYHa4HsWwVd3hhbaZvS+wsbi+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw26tMvRZT/B0IprmVwiCi9061li9IszO2pDD8gb39uvPThRacn
	8qXfUIOZ1u0g42D49Ch8u4si/1JXhKEcfuNAVTl4htpFJ36MHwekmyzLKQObxSSyX3k=
X-Gm-Gg: AeBDievWgMCjqOmy0bkhBFubU87QJpWnG3YhdI4S3GXAiz9TcNeZiK2NkSHUdnLbiwj
	gxHOMita5C0oC+pLhge+cLuTcGmXMIh8vTW5o9/sQlaAWRktXDm5BEUJKTa3GcXOSYhPJLwwRa9
	vZ4wuguAVdrSRcsNBqFe09j+ISL90XArjwcem7yWR9I2VSUPpR8R56N/2ds0/hdQ93uA2G4ca9g
	MtjszduTxb/XINtOqiYT++fcgszDlYH4D8r5on7n/IuAW928WYM6nz3gTAtZtFZcg/xuahEqaCY
	mhFP6t5FiROYmgmv4GIzFcUsLIRo+Bpij/Fm9c9NSFui2GnY3wuJOslBZ/3TUwNdI2RYWInutgV
	i0gTJjHMaKAcm510XQ4T3JRAS0bx6tg23Z36TizaMaptAME2vbbNt5hZ18MQHACvgkJU4WRKomC
	679q2OjiVtO/EEcW5uT/HTFqiO1346iFsUeA==
X-Received: by 2002:a05:600c:450c:b0:487:55c:e0c1 with SMTP id 5b1f17b1804b1-488fb768816mr309582475e9.14.1776862378790;
        Wed, 22 Apr 2026 05:52:58 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a5aa3ae83sm83319095e9.12.2026.04.22.05.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 05:52:55 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id B7D6C60EE9;
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
Subject: [PATCH v3 10/32] target/arm: migrate fault syndromes to registerfields
Date: Wed, 22 Apr 2026 13:52:27 +0100
Message-ID: <20260422125250.1303100-11-alex.bennee@linaro.org>
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

