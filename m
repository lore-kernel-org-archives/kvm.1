Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840873CE48C
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 10:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776852659; cv=none; b=KJgYQVKX6cjKT9B0+X+XTbjbGViNO4dDjAVcBmWzd09TocR4XQRN6VBDCTJttarpPciGReVRAAl9bC79NRc/L9QuIpXEH67GsNXjTaLuIilLEHibRrYFb3iMWL8eEPMcS8GXMA9WVJlySBQ6/xnUvhl4s1XRrQMwpXWQb/y8K0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776852659; c=relaxed/simple;
	bh=bIQma1WvCJMqDqzr9stcDms+l7hcxxEEKQpzNt371Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rI8sv2Lqbt76t1vFIyPBn6Vr2z5TvHaFlZSjfgfR7a14eiIwnW06oio0CxgCUQ9HYCFo5yY6e53tUAjyDdzsabeaviWUiwcSdjfJwUURIu2OnP/NibMRAQlQa0cDJeMzMDaGaJgC3pIGn88PhUkgCDG/KpNuk0os0hHXZyeDmCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x35gxj00; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x35gxj00"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso20230465e9.3
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 03:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776852656; x=1777457456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBHHqWCNozXOcmQTxKAtN3Av+2DGbBLMiAYtHB54URk=;
        b=x35gxj00rcEVdoJWfcf/zFIuiBHAXIafDXKmp6c6aPccKvBaytdv2ofTWgTpAkEWgu
         pLYL/OZDPLb9ggZnIQdQqQuM7sp/7Lk9ZTEtMe0x9Sarr4yz0wE8i8fd8cXczGS1LhQu
         s54H4BrZz9n7hChUPhmqByw5tnKinhYTKSgsN3l/xm9X3rPOKE43PBdwSZG8xQPWU64f
         1BOpQsm7xZq0DLP70XfBel6f7a5In4PLafqj7t+JAxL6aT9qgrYLhXzpJ0FLbV7BOthf
         HL+8iEn1VBZiFd0Npg0a7S8zpkxSV7m5EGMHX7GQ9tl0kvMuPXKJ8zWeR1BnRGuPg5/b
         DeAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776852656; x=1777457456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pBHHqWCNozXOcmQTxKAtN3Av+2DGbBLMiAYtHB54URk=;
        b=OtoEPBN3wj1DY2PBPoiF7mg+0+V929NyyxdBy/fmzead+CyHCACpGHbENjsXLrrXd4
         n41V2BwhHZvZj+okhJ7g0qJmRIEDkFJmrpVaAqCBsIi7maBb57U6RZG3AxGP8Zzb9ItL
         ZGiituGvlTgQ/1OxR47hHWWIC3ssGCF6THGlE7WSkcRChfi7bLu/PS/vR20NxJaNsO/G
         9ceaBdDkizrq6wClqo+8RvLEMF2V7HUN85zdIHVwBxw9jEi5h/bmHQDxpY+J1+H7/pWC
         eCglUUxjtKb0p7eac15yLx/KZ29ozV1qTF5mANuOo8hMwdcMXjY5p7H80af71HFrL0I9
         n52w==
X-Forwarded-Encrypted: i=1; AFNElJ95N9h/gq4gIQxu6yEc3JZgT3csbzsnoYdVdMqOa96AnD1/V03LNYZ/dj7fT6D51/96cfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPL1rIeQ6hdAaOapq/Qq7WN2AeHe4N7V8khAQ7/BYxj9m8uU6y
	VJkN1bX3ddZaXQOnDVnWojQ8XaA2wv/2N2d4axJ4ntMGqZN8rUrfsF5l+ydlnIuCE9Q=
X-Gm-Gg: AeBDievOQmplEwmlGAugoOi1NHQtYqq6pWFkugof5iW4iRbqXCxHu1m2zr9fjQX6dPD
	h6Fcawep3dIvWW6HOnCl3nAB2jGDEcnZRSOf1BROOnmVjveAuX4vKPr3DtslnFPhYHNvClwtyO6
	JF12xArYsbTC0YLfduuRMMpZA1ijfUHML/3MnTvCBY9NZFIPmBFN1BSmphQo48ildZn1F21RoSA
	4Oy0r9Hu+v/B+MvBw/XneqLIEzXXNpp7mH1wctRvTuEI9cSOiApB6JHhWEr23gmqXzRdj/llf5C
	IzfuD00qNrCeLleRAScy1JyYBWB4DzCeW/ZgyxrA5OnjyNaNjOejzPCtR3yxvHl2899bjKsxuSa
	ySlJKZvdbE3JP7JUb8y7sigEx2cVG5j0tBd/g/+Xwzw8AVuOnux+yZ8hTuhzhYII6UuafqVB8Fa
	YGUvtIig6T6TSzE/f0Mi1CtCiwyDqA7FKbuw==
X-Received: by 2002:a05:600c:45d3:b0:48a:5821:5ffc with SMTP id 5b1f17b1804b1-48a58216a4bmr72951945e9.2.1776852655809;
        Wed, 22 Apr 2026 03:10:55 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc2cacsm44153425f8f.13.2026.04.22.03.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 03:10:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 9E97E61063;
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
Subject: [PATCH v2 15/31] target/arm: migrate check_hcr_el2_trap to use syndrome helper
Date: Wed, 22 Apr 2026 11:10:26 +0100
Message-ID: <20260422101043.1234229-16-alex.bennee@linaro.org>
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

It shares the same COPROC_ISS encoding as the other CP traps although
not all the fields are used.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/syndrome.h       | 16 ++++++++++++++++
 target/arm/tcg/vfp_helper.c |  5 +----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 841fd3292b8..53137394e28 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -251,6 +251,22 @@ FIELD(COPROC_ISS, OP2, 17, 3)
 FIELD(COPROC_ISS, COND, 20, 4)
 FIELD(COPROC_ISS, CV, 24, 1)
 
+static inline uint32_t syn_cp10_rt_trap(int cv, int cond, int opc1,
+                                        int crn, int rt, int isread)
+{
+    uint32_t res = syn_set_ec(0, EC_FPIDTRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, COPROC_ISS, CV, cv);
+    res = FIELD_DP32(res, COPROC_ISS, COND, cond);
+    res = FIELD_DP32(res, COPROC_ISS, OP1, opc1);
+    res = FIELD_DP32(res, COPROC_ISS, CRN, crn);
+    res = FIELD_DP32(res, COPROC_ISS, RT, rt);
+    res = FIELD_DP32(res, COPROC_ISS, ISREAD, isread);
+
+    return res;
+}
+
 static inline uint32_t syn_cp14_rt_trap(int cv, int cond, int opc1, int opc2,
                                         int crn, int crm, int rt, int isread,
                                         bool is_16bit)
diff --git a/target/arm/tcg/vfp_helper.c b/target/arm/tcg/vfp_helper.c
index 45f2eb0930f..e692bc568bd 100644
--- a/target/arm/tcg/vfp_helper.c
+++ b/target/arm/tcg/vfp_helper.c
@@ -1359,10 +1359,7 @@ void HELPER(check_hcr_el2_trap)(CPUARMState *env, uint32_t rt, uint32_t reg)
         g_assert_not_reached();
     }
 
-    syndrome = ((EC_FPIDTRAP << ARM_EL_EC_SHIFT)
-                | ARM_EL_IL
-                | (1 << 24) | (0xe << 20) | (7 << 14)
-                | (reg << 10) | (rt << 5) | 1);
+    syndrome = syn_cp10_rt_trap(1, 0xe, 7, reg, rt, 1);
 
     raise_exception(env, EXCP_HYP_TRAP, syndrome, 2);
 }
-- 
2.47.3

