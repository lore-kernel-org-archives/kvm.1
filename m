Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF933E95AE
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862385; cv=none; b=X2YZ6h0o6y3mKAunYjsN8wO9tBJTF+f6UdXbjv+Xh+XSPAgvPNH2w9YcrhvVRIJjciwA/X1gHsLAJrClAoadCrbkZNCsSIici5EV7BgAbX4H61iDCwOCOiI2J4HbNd4s2jDDB2Kb8dfuzCT9DUoI4RwLg4fWB8eSq9pasLw/BRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862385; c=relaxed/simple;
	bh=64pJ+ylAWbDMx/CsFRbY2DsMFV7ux9DLeHKsqq9XEFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XLmcXTL/M55XFC6w3hiIDjxPE/TW/nEAjkkI/wnioqMz5Zv57kcSZoqk9sNPkRzbi9VHQxlGumhz1O5MQhlX5fVkcPh49B67ir2Haz2kCSR9Ebdp9wIGyov7fWtAZOVsszPM2JIEeH00Fg2D3W0KVH0+Yp2k1umygyJvYkTs7m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S229LWTG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S229LWTG"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so33552175e9.1
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 05:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776862382; x=1777467182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nsukKtrqlrIyVc1W2h4m0opSAHZeyebGQjoHRKe/ww=;
        b=S229LWTGHdN0rPCAbdvFPSi0eewVAuEcMvlT3A99Pu+W2ijadk7+B68bXzzZuaITAK
         L08qej7JeKGvzKvh0SQ3FiuQ2S2n2ydia7AlDemZRgFje1yNWABCsJPg3FkLSdmYf7f7
         2A22g+lBJUHkmOvJ/v4SJ2/E5XtjV96hWmGOjGsyB0/CS5XifOyimOcSLshq9+gxVrDy
         i+l7CGPkgcApQ5U8CsGzIhc3wQza6vVY0RVJ/vB3PZG3fbLsREgu0s29PQSB998nCYEB
         JOsaOeOVO9fUhV09Hwr3xa5W4nN4seAz0arlEM6AHrLzkITyxRNewfXHW+6HylQF95SW
         hH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776862382; x=1777467182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7nsukKtrqlrIyVc1W2h4m0opSAHZeyebGQjoHRKe/ww=;
        b=WCcGH/GvDXwf9LYm7S1eHk5yuSP3/6sp//IfXheCaB6k4m35/zkpVT0KvLxvx3n4ya
         yphcrtAQd1KOPYNDIMusDsZ/zqJfiZ2Iy790amvFaBZ8VB6X3gr//DIpnLBLPINKRv8+
         cRK33mhp+2KwRDvNVL6e8IuJoBNdpIQ+dh3svM4oj9vOQx/sJlrw/PlEVxJ/kCLbTQVA
         nMEgKO11sB31Bp5fJ3MYJtKH24Y/xXckCncq/DclEw9FGlnOuGHiJJnwY3taUqXxL9m8
         Iy40WP4RmIQVBJKPKxTCqNwzKJgvi74Kxj4iPjNQHBXgnzcOepkUEC5HAw86S+aXl2ME
         4PDQ==
X-Forwarded-Encrypted: i=1; AFNElJ8RViuSwduZxQnwrxhf6LhZKygQefMaPWLeRHe0dXtixoenMA3XX/0HovidigV/Dw9UMXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6GropjNO8MKJ/vkTiMBdcu5shsYKf2/vCQSZEYgo2CZwIuP1W
	oYQRXEi63N6tPSc3mqtoQV4IHhZfhIvWD3A0PNdMqAaZtawGMZDJwLdf84I/iAqsn10=
X-Gm-Gg: AeBDievCMt5ojDEYwfNJx8UeXpfh89dLTs+7uqrWHBgO6nKk49+yXIbTZuGjsVJhdAu
	nhAmGyNBX/27fFzJ8ePNb/655hN3btEoYHinDZL0He4fupHGaOzWdpaY2+YFHLCTYcftZz+R2K2
	6B8jrmN+MzhoJ69dXXRWuL1Efq1ndUOnk01RoIQi/nG58hqSdH9urR5hgBWIRfmbK8Tb3aXaW8Q
	1bKpf/w3hdHgKerCLGdQPpRa+eBQBKb/zEzYh5AvJu0ZjtHcfO2XWcwmxP7sh19mHt88Xw5gGmD
	AEIbgZPTJpPRWaQe1oFXe6gokpRSKtZaiBZEnHdTuVqXPcqd6OPypm4jK1wUBDXtb1jYzI0nw6B
	d/7RauGjZg1uI+Xi8+EJxt9AM26ltlx/F3tQueWcXR/p+iz5KtRou7z5rDlge++IQE6WSlYdCHy
	JEfbVaeIJRJjzDORFyYH4ekEA9iZEz7PcnZA==
X-Received: by 2002:a05:600c:a105:b0:486:fb69:4960 with SMTP id 5b1f17b1804b1-488fb7786e4mr229329295e9.19.1776862382062;
        Wed, 22 Apr 2026 05:53:02 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0f82bbsm753005695e9.3.2026.04.22.05.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 05:52:55 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id CAF0560EFD;
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
Subject: [PATCH v3 11/32] target/arm: migrate debug syndromes to registerfields
Date: Wed, 22 Apr 2026 13:52:28 +0100
Message-ID: <20260422125250.1303100-12-alex.bennee@linaro.org>
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

Migrate syn_swstep, syn_watchpoint and syn_breakpoint to the
registerfields API.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/syndrome.h | 54 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 2031b3704fb..2ad6b97aea5 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -595,22 +595,64 @@ static inline uint32_t syn_data_abort_vncr(int ea, int wnr, int fsc)
     return res;
 }
 
+/*
+ * ISS encoding for an exception from a Software Step exception.
+ */
+FIELD(SOFTSTEP_ISS, IFSC, 0, 6)
+FIELD(SOFTSTEP_ISS, EX, 6, 1)
+FIELD(SOFTSTEP_ISS, ISV, 24, 1)
+
 static inline uint32_t syn_swstep(int same_el, int isv, int ex)
 {
-    return (EC_SOFTWARESTEP << ARM_EL_EC_SHIFT) | (same_el << ARM_EL_EC_SHIFT)
-        | ARM_EL_IL | (isv << 24) | (ex << 6) | 0x22;
+    uint32_t res = syn_set_ec(0, EC_SOFTWARESTEP + same_el);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, SOFTSTEP_ISS, ISV, isv);
+    res = FIELD_DP32(res, SOFTSTEP_ISS, EX, ex);
+    res = FIELD_DP32(res, SOFTSTEP_ISS, IFSC, 0x22);
+
+    return res;
 }
 
+/*
+ * ISS encoding for an exception from a Watchpoint exception
+ */
+FIELD(WATCHPOINT_ISS, DFSC, 0, 6)
+FIELD(WATCHPOINT_ISS, WNR, 6, 1)
+FIELD(WATCHPOINT_ISS, CM, 8, 1)
+FIELD(WATCHPOINT_ISS, FnV, 10, 1)
+FIELD(WATCHPOINT_ISS, VNCR, 13, 1) /* FEAT_NV2 */
+FIELD(WATCHPOINT_ISS, FnP, 15, 1)
+FIELD(WATCHPOINT_ISS, WPF, 16, 1)
+/* bellow mandatory from FEAT_Debugv8p9 */
+FIELD(WATCHPOINT_ISS, WPTV, 17, 1) /* FEAT_Debugv8p2 - WPT valid */
+FIELD(WATCHPOINT_ISS, WPT, 18, 6) /* FEAT_Debugv8p2 - missing WP number */
+
 static inline uint32_t syn_watchpoint(int same_el, int cm, int wnr)
 {
-    return (EC_WATCHPOINT << ARM_EL_EC_SHIFT) | (same_el << ARM_EL_EC_SHIFT)
-        | ARM_EL_IL | (cm << 8) | (wnr << 6) | 0x22;
+    uint32_t res = syn_set_ec(0, EC_WATCHPOINT + same_el);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, WATCHPOINT_ISS, CM, cm);
+    res = FIELD_DP32(res, WATCHPOINT_ISS, WNR, wnr);
+    res = FIELD_DP32(res, WATCHPOINT_ISS, DFSC, 0x22);
+
+    return res;
 }
 
+/*
+ * ISS encoding for an exception from a Breakpoint or a Vector Catch
+ * debug exception.
+ */
+FIELD(BREAKPOINT_ISS, IFSC, 0, 6)
+
 static inline uint32_t syn_breakpoint(int same_el)
 {
-    return (EC_BREAKPOINT << ARM_EL_EC_SHIFT) | (same_el << ARM_EL_EC_SHIFT)
-        | ARM_EL_IL | 0x22;
+    uint32_t res = syn_set_ec(0, EC_BREAKPOINT + same_el);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+    res = FIELD_DP32(res, BREAKPOINT_ISS, IFSC, 0x22);
+
+    return res;
 }
 
 static inline uint32_t syn_wfx(int cv, int cond, int ti, bool is_16bit)
-- 
2.47.3

