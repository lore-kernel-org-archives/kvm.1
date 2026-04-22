Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B3A3CCFA5
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 10:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776852653; cv=none; b=dhnz4BxW7vOwtKIrhBdisBz6+i8HUDQStfllDs3xRzfiSprodd2ROMTOdG++/sw317tCBMyaoj9ZHq45bmsrsvUSDlrydR32aKmQUDoGG3otA08S+rsBpMo1hc2wuzw8QzLHCARW07iGnfp/y9DLmgSJ8tYhaFinqjIejQMNFD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776852653; c=relaxed/simple;
	bh=byRYj04QGQApI15tiXf86LyMpnp6+y8t6n3SfKUJfXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cr5zC+InmqW3oJf39VNLvQP7SRjsJtLNREDcsQfnBNvKlLyxeWU2CKLdaHeQ6gVgeienWwrIzsha2uu0QZ22YlbFnrDJJb8Pmnn777o86321Un4jOv6+O6Xs/pRgMXEqTOHUGmAAjEllX1wluShXyKDJn5M6Gjh04p9xWh8uvs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aEmqNWpx; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aEmqNWpx"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488ba840146so48442135e9.1
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 03:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776852649; x=1777457449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/O57BXYHK8ET+Z6BA/YHEqhtOr337eupd637bkTh7l0=;
        b=aEmqNWpxDOmQO+zmmX/Piav2fBtVStxg+aQg65ZpB/frJuV6k2KAtmwDo9pHc9adlq
         sPdwqEgjrDIwdl5cLZLZQ3TPUAWOpBEZjOcM2AllS5I7Ko2j7A9xA9M/LTMrqXgvLgc/
         OdZBMJtvKPvNS5VcusvLFmK9Podn4YsqxiUZStyAmONGtoXxpDz24HQ0Ruf2py/MbOv0
         fNxI/nuVBuqa/mRyIOql+Vx/H2ggqESSSX/XUd9HwuYkXiYIZOm4OG/lqAlh0rVhGBs6
         Verea+fnana0jdsyE85wSzMnvAUEX+cu+bkGSmtkTNLjuDMYjJKyiREDs7tn7MiF76Dk
         1bpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776852649; x=1777457449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/O57BXYHK8ET+Z6BA/YHEqhtOr337eupd637bkTh7l0=;
        b=EELqsKeI+Z7rA4RB8K4QX/prnX7gOG2ZPSGpufjpuGJO01ZyUZXnLkmtMdxE5Qolpk
         yMPxxm9lc65v8evzjZEUk+R6pYImIygVFUQ7ggjexvW6sPeaG96Aks6o0bYlKnNQ8VtJ
         1LsMLpHulXwzcL6w2+NWcBcLouf2lNkWfXq484SbQ/C0/VcZAKgcp/PYy3rxW4KTuZln
         qOy4eteySj0SeftVNEHLCxjzSKHwNQyP+C04jPg+oNvD6G08/nvbxegiHVd5Tn9CZOtA
         KkPMSsB1GagCUzYFOOfZMSF2UYUBfoEB4dSa8zuQNZz2tykvY7DlI+jfdRcM+WODzLy1
         heng==
X-Forwarded-Encrypted: i=1; AFNElJ9YzmRwAO3Lyq6FCRZRN+Z1o+U91vfoiIPKiH3Mba46/qTk6kWTB6RE5SrBFN4+vEySiMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyndXMg2xNmNZ3Z3oBFpPxWjpCq+tPnB41f8/nQXpx1re0v2xF1
	fVUaY84mmC0FPNnuVXtV1RAu8TwI7k+CGci6z6M90k9cgcPZnQSQfBZJRP41P8xKlL48czsxmHu
	PBotsH8w=
X-Gm-Gg: AeBDievBn4camkHWc3w6Ryf1oLAeoyAnuAEClK5fD+Zh4/XiZxIjRxC106ROSlwOez7
	sLrmfXWKq1OfeIKYYSTwvVNdXE/EhFJUx0CPE9SdElCr1//9Bo0dQLENLAGVapHxXY7xSmtW0zb
	b56VQyoXgm7jtwN2gqfpoSxVBRe3e0kK8qbNLVvxtltIPjkIpEmzKHcR1n798Qxv2CpV5V5zxyu
	CqCqbe27H6/ScFMHDQQq6yDD6Ml+pvpK0NAIfGNzy7XJxHIG6NiEV6b/l/TcuUeLuGyJ2k5xnBO
	LHwbpJIdgjog4IDiavcwaac+Pkd2IEZiO1MprA+CEo/R0EFFH4K47qveGO/bbxHT1fv/KM6gO/t
	UscXsupggWf4j384S60HE66iLZDSGBUbrU38oDtTEMus+rGeL25dIBFyDfWjOzune1BeC3Gm+q0
	BeauU0766T/4Lv9jmZ5v8nq/7Kjlm0STWZWQ==
X-Received: by 2002:a05:600c:6289:b0:488:f941:aab2 with SMTP id 5b1f17b1804b1-488fb78a561mr299841095e9.30.1776852649323;
        Wed, 22 Apr 2026 03:10:49 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1393f5sm410399245e9.9.2026.04.22.03.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 03:10:48 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id E2F5F60469;
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
Subject: [PATCH v2 06/31] target/arm: migrate PAC trap syndromes to registerfields
Date: Wed, 22 Apr 2026 11:10:17 +0100
Message-ID: <20260422101043.1234229-7-alex.bennee@linaro.org>
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

syn_pactrap is fairly simple as the ISS is all RES0.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/syndrome.h | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 61053475984..fd8639d4f07 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -398,15 +398,32 @@ static inline uint32_t syn_smetrap(SMEExceptionType etype, bool is_16bit)
     return res;
 }
 
+/*
+ * ISS encoding for a PAC Fail exceptions
+ */
+FIELD(PACFAIL_ISS, BnA, 0, 1) /* B key or A key */
+FIELD(PACFAIL_ISS, DnI, 1, 1) /* Data or Instruction */
+
 static inline uint32_t syn_pacfail(bool data, int keynumber)
 {
-    int error_code = (data << 1) | keynumber;
-    return (EC_PACFAIL << ARM_EL_EC_SHIFT) | ARM_EL_IL | error_code;
+    uint32_t res = syn_set_ec(0, EC_PACFAIL);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, PACFAIL_ISS, DnI, data);
+    res = FIELD_DP32(res, PACFAIL_ISS, BnA, keynumber);
+
+    return res;
 }
 
+/*
+ * ISS encoding for an exception from a trapped Pointer
+ * Authentication instruction is RES0
+ */
 static inline uint32_t syn_pactrap(void)
 {
-    return (EC_PACTRAP << ARM_EL_EC_SHIFT) | ARM_EL_IL;
+    uint32_t res = syn_set_ec(0, EC_PACTRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+    return res;
 }
 
 static inline uint32_t syn_btitrap(int btype)
-- 
2.47.3

