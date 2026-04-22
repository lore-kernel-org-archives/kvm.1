Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8E23CE49F
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 10:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776852664; cv=none; b=mvdBNt3i9GHxaEhA9UzLeYTd5Phq1IVy2bae5jPLrxjuN8pWJ3LKmKyH3GmvdRgFWsX34UWgB3nU9BTmSgJ07WkvBxuiFhRcuvu20uIfl0NAOOX1ebABpuqfHPiiop3sMojtEPe92fqFkrcpjGYOZgrpjp27eXHbWqQkzB2dXEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776852664; c=relaxed/simple;
	bh=64pJ+ylAWbDMx/CsFRbY2DsMFV7ux9DLeHKsqq9XEFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q6U5CzuPgDTmUvlKzGtXsdwvxTn2FI1RU79e+sC99CnoW89kDpkLI2bIkQKKEASndDwk5F+Eps2F4idlYzX4ER9nNWwbHmKaBnFXpWNQg+U8Kp8L1/4Owot2+5L5awhUoIx+AXOVtv0ucBitqh419J8TQDNwNAMpjh8GG28ateM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wL0QznXV; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wL0QznXV"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so32668795e9.1
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 03:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776852658; x=1777457458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nsukKtrqlrIyVc1W2h4m0opSAHZeyebGQjoHRKe/ww=;
        b=wL0QznXVLbzjXK/UNIhnxXVLK9PUFSnsUNDK082WdyI9LLweMxUCV+rSIQW2DikzmS
         tIdpGJ/p94PMwjAn2qEduYd+6cwUBlA9XR8VBP7IcWfve0XTyJE2FOTwdWQBC63arL4X
         f2vsoSkETFxRghb4LhzZk45Y0zTI4TXCytpEvTLrSp1PNH6gKLRUuDAYDU4qe1hoYgw5
         XTMgQnqkus82rO2CSr/T3+kq2uBl1Qgn8QH36sT8YKtpDhVYVYro5KbJlqALfgs4JcKp
         tToGsMDvMrNtefbpDr6Q6+mo46oXlVK1TjDzTRl90YuyUI+4GPfzpw5N1vYdRXqtwPIq
         S9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776852658; x=1777457458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7nsukKtrqlrIyVc1W2h4m0opSAHZeyebGQjoHRKe/ww=;
        b=oJgw21SIP+oG3dtfChIXLmVGIEQDTW4lOcSlViEdMpqpd8R2mA3+aAiF2uPZVZR2ei
         jw3jgxpSFC5WcQAriNArUHB7k7HDW4+9/HrlSVmv2GjoEjCgFIxboiVuHombCNM9Y+Nd
         Uwt8qpFBmQ3XqpYhkFlvntah0hKSKCDEI1caZQBWA/rVolvH/QVlqWwZvH4zOfFDWtNR
         ud8npQ8RETuhS/mQmNnDY+bVoKfLyS3u4Cy08pS1CKXG+U+ofEMK5vxRUUXWINaYUZPj
         48A92la15enLOhIEZpeteECLdVDPiRAT6TNlFc09ves+RGjallPBEnniibUD4laUkAyG
         9Jjw==
X-Forwarded-Encrypted: i=1; AFNElJ9B1G4oJtqs7jQPeOdahwmmlxj0QMUj2ERybkw2LpJyosfVAX0WUtmr3rmpzkFuddU3aUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzSeY0buZGI3bP62gwSv/5o+gM2vOt15t2aqzFwKn07JuBVPya
	BHOV0PeJWDlOnAvCpMEZUgbrk5YiBCt1OTCloZe9RmCBsjV+kx+J9+jG427bwEhw7CM=
X-Gm-Gg: AeBDievYaz1lgKYzqHOK/eFQaaKQDsqTfS7FHrA2OrtecH5TyYErEHBZQs+wWvbG01r
	sT9ArWam+/VhwQpMw1u0MU93IV51uhoo4garBysAowCj2lsjMTmLuK63VaY+m2zNZTg5WBVtoH9
	Zh2glIpxsEbhPwhddsGFLHg/pZiSnBj0nf/sgVvkvacwZfWfqXe5xts7JA9scPIpjt2PfZfrvXj
	RJiyQb05sM2jAAQcgjjvaaJYdOedmqQw/dG56FzpzgqKUCVY8ndmI9/gcBrYmtJAKsmtdI2HSfs
	KxjAvlAl0LfGbGVqKxKtKijOxq81clgIorc+CX0P582euyht4onVvBJSonmr++vV83z00HY6WT4
	ZSl1Gb3L8IhI0JBxRtvSrTK9fr21R9/EtOhUsb+my8/52Yg/45Ni9yu6PyLijWO/3vwf1Tpfocz
	bMdiGTfn8F1TaPyFfcs32728DhtdomlfKizQ==
X-Received: by 2002:a05:600c:888b:b0:488:c40b:c8bf with SMTP id 5b1f17b1804b1-488fb73d234mr256866985e9.2.1776852657985;
        Wed, 22 Apr 2026 03:10:57 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb794e26sm184086025e9.6.2026.04.22.03.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 03:10:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 4F1F060EFD;
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
Subject: [PATCH v2 11/31] target/arm: migrate debug syndromes to registerfields
Date: Wed, 22 Apr 2026 11:10:22 +0100
Message-ID: <20260422101043.1234229-12-alex.bennee@linaro.org>
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

