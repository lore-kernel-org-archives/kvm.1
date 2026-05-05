Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2AB3845B6
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 11:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777980019; cv=none; b=LGilzfhou2yVXSmJ7yk3T3d1zpjWns9buRdMCel9lw/BAcrufxYDv+w6z5XQyj8hoj1OH4clgtCLdMgfF9ZDoj7dzTYdt5rD+x26mQEvVDLfzTL7fpQAQAXbZhzHCvWDwIebP5MrkNXWOGvR83cNMhzrhIrjBzue/VWvm16DUG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777980019; c=relaxed/simple;
	bh=YWoNKk9wrbiaUxDvW/Txq7tiNqohKzQVXe6grYa/p/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q86IWbSG//86+UK0xUCUS8aQHDrZ4Im4koUiZsqBpxA6CNlCywm7VftuyOwjLhkZ3iXtvGbrHGxXaXc8l2yOFc7sSvgxcYnU34cg6oM+7uGueZSysDSo13Kq2sUTmi5bgezu9Awgo2qY+phYHpWixmxijAcUdoUbUKF2EJkSPAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nyE+5dms; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nyE+5dms"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso38525455e9.0
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 04:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777980016; x=1778584816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RsPS9jH4wqzZMo8K63vD2xS0qPk68eIqWMM62PQ4Kyc=;
        b=nyE+5dmsZjEBk0/zPDl309Vry82cghrqHWeQhEAU8Uw5/8091CA4e7ZSgLjcDc6CAe
         vaTvaG98Dy5aNN8wYmIwSnackgHfh6NrharIHi+ZlF/Tp69UnjOteGDRD5bSZGuiwGGn
         JrknjzAFxAsgHpnBDGTjxOK3VFMJMXQ5+gcb3ytGtikV3LbZRBwLImP3j0IfqYVU6Ggn
         3Y+3Btr1YQdFn2VOR5qR3MY/fT6oZSgw1jaXDXpTKavfoUGKEZcinC4uZyMBnParbl8q
         LBkSBI4+SNyRTod0sdJOTYMfA+BCLV6QPHJlyaEIJyZtgYWGlIoa5yRqEnhXk86Tx1W9
         c7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777980016; x=1778584816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RsPS9jH4wqzZMo8K63vD2xS0qPk68eIqWMM62PQ4Kyc=;
        b=NjkprQ+7QMbavYlL/ZXQrHfE/ArfGMdtqW7qCRxNr7CjawblBfxjFVcgTSHm4NBBoU
         aWomro2nsBGTXRbHdcHm8VRx+MQVQ2aoQzUKT1/hzV0I7cxdHW49JSxhxILDkUdheVsM
         ATMQ3ziFNwAJfn17w87SNCSlIiQNVIPSPh0qRgCpz5vaQBRr9joLXZBXXRnT44V7ce0A
         iYOQdipYK8abXcH8jN3sQYiDk/jP8bX3QEO9Pf4CEFV3jb+F9te8y+XOVT34U7P3y1q3
         DOIbNNEcvZqQg25o/Q+HV/gyTXJ0ZXVYkR+8gZT7ps55WWN8CNzVm+JSQH+lRZutWKxw
         RqVg==
X-Forwarded-Encrypted: i=1; AFNElJ8uoZD26dTXxBkUtQk5DOrBTGpbkGMNJdxQDKsbbS0sLMECvqOVIwthBf8E6iET7jFKGVg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi/SuTGIic9Uz/v1BtzKrldDzBC69QPHX4O6mxkjzmyQ+P5aBv
	jXt9hh/O5jjWGrsN899y6HPsh9Z8z4n1M7piL8CEcdw+V0t96Jyfyd9HN6D8y4KGhFk=
X-Gm-Gg: AeBDieu2m/gLgljnD3bWhPj/dvmijZfXKd6dx9xE5PuG3JF09ia2WdX4D8jh5RylX+7
	nF/9EJSjY3XDv+Bi5teGTGL8yUxWWa5bmdhzOFAirCggpExw1KEfJUj/1tlqD0WBDuXUpK0jCPz
	FRRNvOwaGtzuI4+EsF8It6FwrwEf6Tv79vdaUtVji/dRyqsByTchFDscXuR9GeE+ySeTmPVD53y
	+PcdzqVzqvDypmudujJD+UG5foaRf7SvA6WEejeYvbyJisgzpiJD2gh4dkIyp64l2Z+QZLfjvSS
	hDtJE105SMAmEI9WuKoeTHarrKWpdki6DK5yL1FMYl30pJJPswlfF8pcLYUdNdOfk6xzze3ZQ0J
	ZhB5QjMBHRHwm5B/S+JZWx0CmYF22t9/Adt4lNM+zcTYj/efefYkUJAMO3wq64KUbhqPXC61je/
	bLuxtpq20hLzUFZRnZaLxv14oOjtH/JD1RHA==
X-Received: by 2002:a05:600c:8710:b0:489:1cd2:610a with SMTP id 5b1f17b1804b1-48a9887194dmr215435815e9.9.1777980016036;
        Tue, 05 May 2026 04:20:16 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48d17ff628esm39906375e9.1.2026.05.05.04.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 04:20:15 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 7F83E5F94B;
	Tue, 05 May 2026 12:20:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	kvm@vger.kernel.org,
	Alexander Graf <agraf@csgraf.de>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 2/7] target/arm: redefine event stream fields
Date: Tue,  5 May 2026 12:20:08 +0100
Message-ID: <20260505112014.102993-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260505112014.102993-1-alex.bennee@linaro.org>
References: <20260505112014.102993-1-alex.bennee@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The event stream control bits are the same for both CNTHCTL and
CNTKCTL so rather than duplicating the definitions rename them to be
useful in both cases.

We will need these in a later commit when we start implementing event
streams.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/internals.h | 11 +++++++----
 target/arm/helper.c    |  8 ++++----
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 4a1ea5465d7..24423a200ff 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -269,14 +269,17 @@ FIELD(VSTCR, SA, 30, 1)
  * have different bit definitions, and EL1PCTEN might be
  * bit 0 or bit 10. We use _E2H1 and _E2H0 suffixes to
  * disambiguate if necessary.
+ *
+ * The event stream bits (EVN*) are in the same position for
+ * CNTKCTL_EL1/CTNKCTL.
  */
 FIELD(CNTHCTL, EL0PCTEN_E2H1, 0, 1)
 FIELD(CNTHCTL, EL0VCTEN_E2H1, 1, 1)
 FIELD(CNTHCTL, EL1PCTEN_E2H0, 0, 1)
 FIELD(CNTHCTL, EL1PCEN_E2H0, 1, 1)
-FIELD(CNTHCTL, EVNTEN, 2, 1)
-FIELD(CNTHCTL, EVNTDIR, 3, 1)
-FIELD(CNTHCTL, EVNTI, 4, 4)
+FIELD(CNTxCTL, EVNTEN, 2, 1)
+FIELD(CNTxCTL, EVNTDIR, 3, 1)
+FIELD(CNTxCTL, EVNTI, 4, 4)
 FIELD(CNTHCTL, EL0VTEN, 8, 1)
 FIELD(CNTHCTL, EL0PTEN, 9, 1)
 FIELD(CNTHCTL, EL1PCTEN_E2H1, 10, 1)
@@ -286,7 +289,7 @@ FIELD(CNTHCTL, EL1TVT, 13, 1)
 FIELD(CNTHCTL, EL1TVCT, 14, 1)
 FIELD(CNTHCTL, EL1NVPCT, 15, 1)
 FIELD(CNTHCTL, EL1NVVCT, 16, 1)
-FIELD(CNTHCTL, EVNTIS, 17, 1)
+FIELD(CNTxCTL, EVNTIS, 17, 1)
 FIELD(CNTHCTL, CNTVMASK, 18, 1)
 FIELD(CNTHCTL, CNTPMASK, 19, 1)
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7e7677a584d..dfdb77a9fe2 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1746,9 +1746,9 @@ static void gt_cnthctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
     uint32_t valid_mask =
         R_CNTHCTL_EL0PCTEN_E2H1_MASK |
         R_CNTHCTL_EL0VCTEN_E2H1_MASK |
-        R_CNTHCTL_EVNTEN_MASK |
-        R_CNTHCTL_EVNTDIR_MASK |
-        R_CNTHCTL_EVNTI_MASK |
+        R_CNTxCTL_EVNTEN_MASK |
+        R_CNTxCTL_EVNTDIR_MASK |
+        R_CNTxCTL_EVNTI_MASK |
         R_CNTHCTL_EL0VTEN_MASK |
         R_CNTHCTL_EL0PTEN_MASK |
         R_CNTHCTL_EL1PCTEN_E2H1_MASK |
@@ -1763,7 +1763,7 @@ static void gt_cnthctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
             R_CNTHCTL_EL1TVCT_MASK |
             R_CNTHCTL_EL1NVPCT_MASK |
             R_CNTHCTL_EL1NVVCT_MASK |
-            R_CNTHCTL_EVNTIS_MASK;
+            R_CNTxCTL_EVNTIS_MASK;
     }
     if (cpu_isar_feature(aa64_ecv, cpu)) {
         valid_mask |= R_CNTHCTL_ECV_MASK;
-- 
2.47.3

