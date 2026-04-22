Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F273CCFBA
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776852652; cv=none; b=cHjopxXc2h0Cp2ybURxng5RYBa9OiVhFauDXHGhN9P8YVAiVBYLmblWbmfFYteiCnCIeEX2FMBxIC5Soc/Z4m/hj21IG6u0M2ckj9MHUhr6OV0hSLXQuSAmB/NgHMGhij2dPIxUhf7zxb8lHzWuE2NZqfLIbtW4oNLZjvp2A5sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776852652; c=relaxed/simple;
	bh=Oa1/TK5EJ72eVFCDyAhGMHj2lLuVlBIFPfZf0dIV7mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CMo8AmmyScUpwiQPPpwDZW7KYpcLWSlgi1nGVDoIcUUg8icw/dq2R55Wh84j2ghBmJLTdwXN1JC62SF6zLp5lqz4/URIk5s5XSg9J1TtOq44RUfCWuCAUB4UavbQ1pkBNOR6wwEljjs4af5kFFScV6ebioVriGB0c6HfF/P3ryc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y2l2NBvl; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y2l2NBvl"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso19117135e9.3
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 03:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776852650; x=1777457450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUXCf79/aCPWP+oojaJHciitYmV1hJJUoyGLuPcbhOc=;
        b=y2l2NBvlH9UUeer1W+8wDdxVtzIwFW7ldOPWEd8BXiE5lc/HRn0FnwqNtN6Y07mDE/
         PW/1z4EZksIFRgR3EI9aJEe/Ld9P2r6FiIbxUKYTTXQxn37FXc/igY9mJn6rJUSarCEl
         iUYv7SaRrMeq/kEMyYcbufoLte1Ya7hmOCm9TNFOKlqooJXgYwLTEuGaWxj2KoxpkAsR
         /HNuLM3RA24g102K1AHq3jDhqkq4NanBJxxrHX64b6cnOMzG26fLLB0atpLyB8/Rbz0N
         qNt+D1oFSeiXHO8V84fyoC4IZCD5mdgtvHH+FH2m0Fj+z/KBdZMKGpFestPFsfWuWEKT
         ov6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776852650; x=1777457450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rUXCf79/aCPWP+oojaJHciitYmV1hJJUoyGLuPcbhOc=;
        b=P6uJ4I+kM3D/p5SU2yx0vTrKStSm0HDfTKPJXMGWFjJUaGfOxZX3A4YPK1Z4BfxU9x
         QvXKKu9t32R/1f4yg+cMLOxJCxAKHudCWG53ntq82SPJ05vod3gwNIbvWGHBADKmPhM7
         XiJA9ye19GT0Kofr+Iw8NmWUKDYosZOGuB4wVFcJSzdGta9tiPQk0Q8olEM+INNG/9j5
         BIIyYm0Sw0eTfoHvI4HJmGjAnxuZTvuOHFdbsYjdhi//aWlFNwvGh8NrK9TN2jGFBDi+
         7AbjCfeRinic1Sjy2pwj6BPquLiYa15b/OXP7eTXziRbaECi3LrjNVdGsT5rN3B0HbjU
         HgOQ==
X-Forwarded-Encrypted: i=1; AFNElJ+l8Eg0JKHxau1ArVZrZcAd8wbgXMIgtVO0SKxqe5vXfTPEz0U8P04YOfTN1GT2PfNFUsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDdqwLJZq6cU88Kiv6uB8tDOKOJPotzbBt+9I87AA2/UvJzWbj
	gGHm5rjeobpLoa9Log3cVLfKy6e06iIsh24HDfVkw1QBtTrMCX240WdQqiV6DkRRci0=
X-Gm-Gg: AeBDieuQ7oU5getHg9vrjgJZsvBBsUfCVvJB8adSyCdK5HrrSlEatnPjmRYQdMxowhw
	ZAOFrblxlhlbmed7iELFwvbGO4F9uV0iUXQudQzjqmexKWPSYAAhICTh6tYQx7Ef07hNRrk/12B
	Yx2ZpfBu4tAMU1DwDDJcv8ECzn8uGIKyJdFfURVU2PauKJFF4kmlGD4/rPi0bwZ4MI20VB1lJze
	dAMfF/FtrIepVRoFN8jtYU2wi+D9n3mY+nob83LM8gstpBrmhnLMHOG0qHQdGZXpPeYm3UBmOKD
	SBo5RK1g/008wQFA/9cPpOb7R22krcwW81GUjqZiPUJ+auRI9nmCNUndkT9F0M6bUPvRPcBYl3+
	xwf64BfXchtleksMeZ2ecBejHBXkGIBVcWeCfz9Xv87oFykLQe9p8pkOUUobzgKwJoHKeh4xDZa
	MUWTI7N0cntGBiAnqVgqM6JmBpsS/+fIHTzQ==
X-Received: by 2002:a05:600c:a303:b0:48a:5576:a28a with SMTP id 5b1f17b1804b1-48a5576a618mr79079685e9.0.1776852649757;
        Wed, 22 Apr 2026 03:10:49 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc17f642sm399924805e9.5.2026.04.22.03.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 03:10:48 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id CF21960342;
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
Subject: [PATCH v2 05/31] target/arm: migrate SME trap syndromes to registerfields
Date: Wed, 22 Apr 2026 11:10:16 +0100
Message-ID: <20260422101043.1234229-6-alex.bennee@linaro.org>
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - use !is_16bit directly
---
 target/arm/syndrome.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 63c8e66ea91..61053475984 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -384,10 +384,18 @@ static inline uint32_t syn_erettrap(int eret_op)
     return res;
 }
 
+/*
+ * ISS encoding for an exception due to SME functionality
+ */
+FIELD(SME_ISS, SMTC, 0, 2)
+
 static inline uint32_t syn_smetrap(SMEExceptionType etype, bool is_16bit)
 {
-    return (EC_SMETRAP << ARM_EL_EC_SHIFT)
-        | (is_16bit ? 0 : ARM_EL_IL) | etype;
+    uint32_t res = syn_set_ec(0, EC_SMETRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, !is_16bit);
+    res = FIELD_DP32(res, SME_ISS, SMTC, etype);
+
+    return res;
 }
 
 static inline uint32_t syn_pacfail(bool data, int keynumber)
-- 
2.47.3

