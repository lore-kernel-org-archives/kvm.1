Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5BA3E9F96
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 12:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862380; cv=none; b=rl70ZfDp8LneB671WHYOxqm8dsrPV9+RbAf6qG4PN//QzCOoYP710vf6A58DUPkVUhQ2yVQgg5s+7qY0uvKFX0iC9qI9VUB2ud46ogUNgfMpsQAYWZ/UED3AgBfMsllB4gbp5Z+uiVzMJguW1jIqGJCaXuEROtJ3QkwJ9vs5+vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862380; c=relaxed/simple;
	bh=Bme4SqmHD3uUqh79O1qpJHX8H3Zd/wSEVuQYFTr57WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p6bu/7AnWtGUYBQ8AHFG2WwlH2IPznHqgePb0rMNmAHVvug5ulo1BXnHzK6nGnHjAlsBxVFpBMGNH5ZEB9TKBL9MTejvBED8frjec5SnQUjwr5Xu9pcWrtGRiCQPeny/Cw1P+FUe7vma3ocqCkIvvfp7uFwN3xLoIWQ4m66vxkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sCTfgzHZ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sCTfgzHZ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso60858685e9.2
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 05:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776862377; x=1777467177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMEvstJVHgigEudV5H559dC48ky9GaKFB5z4g04o+Y4=;
        b=sCTfgzHZS5qZ81I3ktcRgkmNkaVnqKXGvzJkT7MJ4PsnrbczDekB3ZQApmJ01WRQ8P
         OrzEjcCwW+Q9sHwZnPNgupfKsSOaE4Yc8WdehDBBfABaD1M1SaB6C0o92Dtl4YmSqn8B
         b7f1DmOVYb0aTSv4Aeg+Sku69+E1+sirCypZq6uMCIo8cHT88gGzInCOShg3PkeyYB2S
         L+Gi0JMkgUCAnpf7rV9aKFNr9k9flouk3HS1KEZUxAI5JpLGaGwkJCyAdOJrJxisGZR1
         o/W0sJIANzn7WFWYr5EJ4hMHehzE52au1cflO5CY/7ghB1BR2C4M82Lmkk4Q5byU5UyQ
         lX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776862377; x=1777467177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OMEvstJVHgigEudV5H559dC48ky9GaKFB5z4g04o+Y4=;
        b=KCOfGu2W8XG1nEs3QpunCB1kxW5msiqj1Tj1Y4g6fWx64JAMS19CP6aY9n7dLEE0M1
         GFFQtabSgnhOCP4shz3xWnuTy7SiXUBulHTYCPSV77JRr349vqY1/Bbgb07DnPszzYZq
         JX3jPwGGhqzfVu5+zjAFmuU4ospvUOgk6TIReoEke6LknbwrNe6b1DNI+GPzihqeZg0F
         ZB413106aL5Y/4LbY/UVmMoDE1j25VwTYSyT/h7oJHLFzPB7HYA24Xl5Y34c2DmJBLnG
         WNuPyhIbEh/RCCwIWcIfcvTJrzg9Fu5T01uRghDW1iIGGM+XhFX5KlKbP48YLOBCexUj
         sI2A==
X-Forwarded-Encrypted: i=1; AFNElJ97jKD9baooGEv99YeR0aMAz8voLZxrtAZsByn8lbC69HRtBmOczaCP91kNaeMagnWZ+g8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNejGUvguILuw9i5Y8DjhREqAHrVLA1lBU3AdAC5C1V3aT2ooA
	LkinELVxvPvVHVc6IxYSG/lfH1YuOADZAnZ0P03WeJnKu1Z85Tx7Q5bu0UyeTM2JAfs40vtTrvC
	ksQr+X1Q=
X-Gm-Gg: AeBDiet7sgHXGU2UFIFzImK3EzxJnmXTovT80d519gWdRRhoEGtSuDeYTROx80nIqUZ
	ddI7gPj+uVuNT40TkTEXwfF/Djw1bD2nMXrkW3Ix4ScZBsTEC3cj4d2Kv4H5oYtznQvhfQdJSZH
	g594j6M7Wcm7Zimd/9ElZG53yacK9ddjrYezqhtOWoUGIn7XiixpEyax5JPzrvysezEmmSoHA+7
	1ohzYvPhKINq7TjqISEkRmL/cQE+1Q7qNgurBIKNgzV8Pogyib5kMSGw7EYhwmM3R3w8VyN1g2U
	73nAOMC+fJzBp+OoJNTHsz5zwpCS84CZ7Q7fS2U7zpVKAI9rz+K0cHU8Tqlbe0g/IMxMpQ0VXE4
	usdueerKeUtihDcOWqsWnlYF3ZAUS0pFtqF8rtVIhCvvHoGHvdKpwPFjeW3cGHUc6YWNEhc/XGh
	hTI7HG5NdyvHDBUID7hDMYneHV10okU17mYg==
X-Received: by 2002:a05:600c:4e4c:b0:48a:58ae:9938 with SMTP id 5b1f17b1804b1-48a58ae9f69mr79775915e9.19.1776862377319;
        Wed, 22 Apr 2026 05:52:57 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc17f642sm409465985e9.5.2026.04.22.05.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 05:52:55 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id A537460ED5;
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
Subject: [PATCH v3 09/32] target/arm: migrate Granule Protection traps to registerfields
Date: Wed, 22 Apr 2026 13:52:26 +0100
Message-ID: <20260422125250.1303100-10-alex.bennee@linaro.org>
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/syndrome.h | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 6fcf0ac7572..bc65106c61a 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -462,12 +462,36 @@ static inline uint32_t syn_bxjtrap(int cv, int cond, int rm)
     return res;
 }
 
+/*
+ * ISS encoding for a Granule Protection Check exception
+ *
+ * These are only reported to EL3
+ */
+FIELD(GPC_ISS, xFSC, 0, 6)
+FIELD(GPC_ISS, WnR, 6, 1) /* Write not Read */
+FIELD(GPC_ISS, S1PTW, 7, 1)
+FIELD(GPC_ISS, CM, 8, 1)
+FIELD(GPC_ISS, VNCR, 13, 1)
+FIELD(GPC_ISS, GPCSC, 14, 6)
+FIELD(GPC_ISS, InD, 20, 1) /* Instruction not Data access */
+FIELD(GPC_ISS, S2PTW, 21, 1)
+
 static inline uint32_t syn_gpc(int s2ptw, int ind, int gpcsc, int vncr,
                                int cm, int s1ptw, int wnr, int fsc)
 {
-    return (EC_GPC << ARM_EL_EC_SHIFT) | ARM_EL_IL | (s2ptw << 21)
-        | (ind << 20) | (gpcsc << 14) | (vncr << 13) | (cm << 8)
-        | (s1ptw << 7) | (wnr << 6) | fsc;
+    uint32_t res = syn_set_ec(0, EC_GPC);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, GPC_ISS, S2PTW, s2ptw);
+    res = FIELD_DP32(res, GPC_ISS, InD, ind);
+    res = FIELD_DP32(res, GPC_ISS, GPCSC, gpcsc);
+    res = FIELD_DP32(res, GPC_ISS, VNCR, vncr);
+    res = FIELD_DP32(res, GPC_ISS, CM, cm);
+    res = FIELD_DP32(res, GPC_ISS, S1PTW, s1ptw);
+    res = FIELD_DP32(res, GPC_ISS, WnR, wnr);
+    res = FIELD_DP32(res, GPC_ISS, xFSC, fsc);
+
+    return res;
 }
 
 static inline uint32_t syn_insn_abort(int same_el, int ea, int s1ptw, int fsc)
-- 
2.47.3

