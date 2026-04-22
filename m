Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F803CE49F
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 10:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776852658; cv=none; b=oWqZTZsxsDSiYYxuBHBxrDNVnSndG3ahw+XXsxjWWr0AHHbaWM+Bgnvr9D3RTh4uULu/4s03A3+aO8Ax9sFaSQXUVyNNvTRnJVgTS/qwl05kALwVtFYUdZC9Qh6Dj7phbjUmDdDykEBYiJJ53Ql0w/meosfsMtI7NfwaNJ68Tkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776852658; c=relaxed/simple;
	bh=0Ykhl9IF8fNR/4GTFmuwJ/ajcVHu9zeqWMWjbn0CNxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gum1D5nZBOkHTPzgmyq5HXojXlK1odarntcLVtLkbtk2f8NPG1k66smqFoQziRf4O07SCEVDc8BUnhyaqO73RHR2BhndAw5YRGWx/zxvaYSqUpwJ0pSNdEw5oRXHfslFix2E+dC5AU6hwnGaC8rHi+eHT0C9glr05Y2iXTs1fCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q1za52F9; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q1za52F9"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488b0046078so47845535e9.1
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 03:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776852655; x=1777457455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oy8aVZbZZZe1U+CUvOIDDEpwm1FnWydA8CkWhWsEzmU=;
        b=q1za52F9BgCIitJyA/GG4zJucUTMGSe645Cz9CIT9W9ga4OKPfDzPnxB9TEALiphr7
         2pwHOEH7k9VOHUakKZo3e4bJCcpyRyGRPOgkc9TLDjc3p7HfgAkuaUXvec2c7P8wWtKl
         LgSK3saE+s7uIwVfXexYhwWO2cJy2tsCyxvvY+tPaQ1bhnhSZYn9YPIViGliHx0NKvCZ
         U0eddhY+jvug0JZrYF9X/23m8ir0IM6OyVdcQQo49SOe9KgOpDCuRK6EsgMPiken5BEp
         EVVaDbMHr8XUg28CvxKqHTDFDVng5nsshnHFTBGcYaoCAh1+ZhZvkah64qgcRfTnPIXr
         MpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776852655; x=1777457455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Oy8aVZbZZZe1U+CUvOIDDEpwm1FnWydA8CkWhWsEzmU=;
        b=sGmrDY1lg51X1j8fzwga4Y8B3n4gZ/E2ivF54SIhnMTT2ljQl3McT3uqJwVXV4sslq
         4NxUUZIzsqnV6YQH1F9Jdvf9v2TjTE5pqZzXYuRy7VBuKwyWJO6T86z3bxcpJs4iPpEM
         Evzatnr7VS2fIwIIlV3rmghgr+BdRILNVeJkg1NPqKeBmV3T7H6C3n5txHYIGv5AqemV
         HMP7NTbZruFO4DPTTwghCBq5uvRADVm8kIpSDL/3tPXWseiEkzOJNcQA0yRHyIZbAJg3
         Cg/w4lv92mxMOfV+80emj1xxBCiS9jSQH2tKe5UKjkC2us+3gUGnwEI7fQV9Y3jlPzj1
         Haog==
X-Forwarded-Encrypted: i=1; AFNElJ94eQ+1N5rWpH3kwflaksF8JJM6YfMoJHKLAtkCCojZ5f48ks3tPLUGaFS0an2QsqpJHy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHbPztpCTuIvV9/jhC4rxLnil5UgVSDYuIYCHIgJSKHuqGBgL4
	gminUVpGDF9luLlr6mnQd05705ap0vF6QpgkuY05a8DNf2YB4Y+wRSqWgMSp9m2d+uY=
X-Gm-Gg: AeBDietdGuYuoCL82Wz+y8mLe2zlq/NVzjxJ1EMtEs7t4Efis6in3DkE149R5JPL/x6
	gJPdphTp0VpQSuxnvafomGVClVzUk0mIWYzpoPdDSIyEl5qNzuCqnG3vPzM6OR4fJoxKiyc05dv
	0PUjnmDxpHYnn/Q6Xh2inZL8Ycl2hIQlwCbkSZ7sxdvi+G08SNw3RpXwlM/DCJeL/aJuXHeIKts
	X3p2288cpze75zjFscg7zkcDqmZuczrYlA6v5t8ImJAOu260nYUm4QA2HdG4KFUS0cqj1cGH4pz
	MLn3vFdAdagEp7UTXLXMb9AR3U4WAgUOs/NgCqRC9lblM00Q4tpgMDC+hNtzxAwv5AWnC/YQhjH
	yYCxit2y6y7XsZv7w3v8gQn7ZUOWGglg55+lGg2THp6BGKulu+2y/xZmJPnuE97zwJPxQpHWaXR
	xxUIh/P3HghTtUvdpQjvLMy3gAoY/gJ3QA2w==
X-Received: by 2002:a05:600c:4e4c:b0:48a:58ae:9938 with SMTP id 5b1f17b1804b1-48a58ae9f69mr70183535e9.19.1776852655127;
        Wed, 22 Apr 2026 03:10:55 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891bb3d121sm372711075e9.14.2026.04.22.03.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 03:10:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 61DED60F2B;
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
Subject: [PATCH v2 12/31] target/arm: migrate wfx syndromes to registerfields
Date: Wed, 22 Apr 2026 11:10:23 +0100
Message-ID: <20260422101043.1234229-13-alex.bennee@linaro.org>
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

This will help later when we expand the fields we report.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - use !is_16bit directly
---
 target/arm/syndrome.h | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 2ad6b97aea5..65d0de63a83 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -655,11 +655,25 @@ static inline uint32_t syn_breakpoint(int same_el)
     return res;
 }
 
+/*
+ * ISS encoding for an exception from a WF* instruction
+ */
+FIELD(WFX_ISS, TI, 0, 2)
+FIELD(WFX_ISS, RV, 2, 1)
+FIELD(WFX_ISS, RN, 5, 5)
+FIELD(WFX_ISS, COND, 20, 4)
+FIELD(WFX_ISS, CV, 24, 1)
+
 static inline uint32_t syn_wfx(int cv, int cond, int ti, bool is_16bit)
 {
-    return (EC_WFX_TRAP << ARM_EL_EC_SHIFT) |
-           (is_16bit ? 0 : (1 << ARM_EL_IL_SHIFT)) |
-           (cv << 24) | (cond << 20) | ti;
+    uint32_t res = syn_set_ec(0, EC_WFX_TRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, !is_16bit);
+
+    res = FIELD_DP32(res, WFX_ISS, CV, cv);
+    res = FIELD_DP32(res, WFX_ISS, COND, cond);
+    res = FIELD_DP32(res, WFX_ISS, TI, ti);
+
+    return res;
 }
 
 static inline uint32_t syn_illegalstate(void)
-- 
2.47.3

