Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE573CCFAB
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 10:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776852654; cv=none; b=MOzBq7rg+7ff5I5LwWeYwWWrrgJsQAuosGJNVr8RfX6mT7gdxvDTMSfakGXcQ1wBp6AI7gc3V0GFfyVOyiWuf7cGg2to7tLGS9onW7BC4A5GuxuoT6zhDm0TgKYib4RmtdSn1B2EjALofdLoIspqljFQ6fAp7sWw7U8RjAsQ6/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776852654; c=relaxed/simple;
	bh=cZIp9nxerNU8oAlNtGhJ7PtRCs2wETNV24N1qiRPFIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RhHyaAtdcVYgg72nTXieYbC8kz9Cz1aH32O3j1esfK7s3WX5hZnN2HVGoPrOKX9nrcxaWU4ZijlpSrDiCJlyDw5Qk4jeq+iiioIgpYeL2aq568iKq+FBO3TXAC1WFekdbm82vc8wuV282a3N83QBPP93KoItpVJULY9wZKBW4O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W7u702pz; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W7u702pz"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso20230045e9.3
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 03:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776852651; x=1777457451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8D+Vwc6j20F82XkTXJvqmESw0OfURlyV19jvdfWNbI=;
        b=W7u702pz1gd9J68l+CXOdh4Phe3fuVkMs4GU3e8jScDeMTMYTI3njOadz1evfRfu/q
         LXU/LS0L2S8clOqNOshIEpK0VkVNErHxQJ+s7bXzY+/GpchsqsFKJwe2gRQpeV+tFyl6
         02MT+T4aybGbI0uKpHbXCu16djSHaZR4nGnXYBDQOeLaygVq8f+7PyARWEvcWU3X/4i9
         VHAaipx1tfksDhfUXz6W+qAWF8CHnQeXxGPEdwK8scYggipmscfhpd0Np8Fo1HCHtJNj
         IWce8hmjOaNdkSnBTuqlCkU/WbeAS7FF0sf2XE1wzEoqtCc89r/4NxgXBTZsmL4G8VCS
         1hww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776852651; x=1777457451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e8D+Vwc6j20F82XkTXJvqmESw0OfURlyV19jvdfWNbI=;
        b=LJN8PfuuWVO/+3WRqSMyB43lbeRw0WVWoqSfxPI37xKwfmsxx9vWvgGwyqcRLIds6p
         9alyS3v46iCjI2sMiF+V2WLtrRaodyq/f3/eYpZ/AK5p0PDct7esXKHk7VN1IaPdpkaU
         tot/nIEgtrhGBqyBjsa+5rt/mfA3y4SvIzizCBlS7NVijydwnlFG9368p8BU1X/pedyE
         Ft7mDQ+oVjm3domxWjbGOOp2RIyskkyQXJ+uCzF/7drd1quJGL3ZtZ/JbLliGWQkS3+h
         ssIezu3gkMgHcThhtww8RG2pAo2wyKR8XTT/cUZXqh5gwIa3NlfSYszI7/JNwYQFSL7g
         kPkg==
X-Forwarded-Encrypted: i=1; AFNElJ9cE4e6mHEKbtR4YCUXXM5K2LxuJyq5J1rmzhkRvSO80AcFV9GkmLC6Yl045WnZvGtvGu4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt4nztEGPIsjOv1y0D3ZDz6IqPMLCf1XqCTUvZTvcgFxv1SAyX
	PTPFeI6Yi7LSrNAQ13o+pVuIDgVmK/1DAiy9fcyrwUbGql86KH2fOGjwh7hfTG80tvY=
X-Gm-Gg: AeBDietJN9w5iIZiXOm4g1J4QOrpM5tRUn0lwJoH3McuLswq+ZxYM1Lvj2yORhsm0cz
	6Ja+zTaUNxTyNbgUsnBj7S+Gwi3d5Vs+5MeQt/Z467iUxLRA8A/jDjZ+bjvdKDCjiysGC3XbYi8
	i7si8W5HgSjFf/ziJdfAnu+gDon4mH4tituWJf/uiJtcPOVjUNk1IR0tjEBcECTg6tz7btoyoQ8
	7DBgq9GHPtaOOeS69zz/v3Wt+EAojZ9IVSMVkYKsSNAAc9ls0Lehhw8v+smSpH8wQAba3jecCrG
	Z5yTRGkQJTv1Ti9kEVOVxoCnBLlH90dzm+soVG3slOTP8Nb23P1HrozzYW9GUWeHL5Mh0rP5U0z
	y304/GNLpKkwyGk3T/swePZwrnSc3XZktGyu4Y6Chhxb/5lmuBWcqWeB+bOrWWoHDkdu4s814l1
	HrqlefiDeUeJYN6jgsSYsY6+XYXhP94YGxAg==
X-Received: by 2002:a05:600c:4e4f:b0:488:ab37:b442 with SMTP id 5b1f17b1804b1-488fb793c6bmr321958055e9.28.1776852651521;
        Wed, 22 Apr 2026 03:10:51 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a55dc9f58sm265433565e9.6.2026.04.22.03.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 03:10:48 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 148DB60E72;
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
Subject: [PATCH v2 08/31] target/arm: migrate BXJ trap syndromes to registerfields
Date: Wed, 22 Apr 2026 11:10:19 +0100
Message-ID: <20260422101043.1234229-9-alex.bennee@linaro.org>
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

This is an Armv7 specific syndrome for chips with Jazelle
functionality.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/syndrome.h | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 52a6745cb23..6fcf0ac7572 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -440,10 +440,26 @@ static inline uint32_t syn_btitrap(int btype)
     return res;
 }
 
+/*
+ * ISS encoding for trapped BXJ execution
+ *
+ * This is an Armv7 encoding.
+ */
+FIELD(BXJ_ISS, RM, 0, 4)
+/* bits 4:19 are Reserved, UNK/SBZP */
+FIELD(BXJ_ISS, COND, 20, 4)
+FIELD(BXJ_ISS, CV, 24, 1)
+
 static inline uint32_t syn_bxjtrap(int cv, int cond, int rm)
 {
-    return (EC_BXJTRAP << ARM_EL_EC_SHIFT) | ARM_EL_IL |
-        (cv << 24) | (cond << 20) | rm;
+    uint32_t res = syn_set_ec(0, EC_BXJTRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, BXJ_ISS, CV, cv);
+    res = FIELD_DP32(res, BXJ_ISS, COND, cond);
+    res = FIELD_DP32(res, BXJ_ISS, RM, rm);
+
+    return res;
 }
 
 static inline uint32_t syn_gpc(int s2ptw, int ind, int gpcsc, int vncr,
-- 
2.47.3

