Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9643D1CD4
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862385; cv=none; b=HHvja1qxqnkId1TKQY4HpgWdyh3GlElOPAnZeMfAksy1oF0K1TSQXvyA8arqKLP2sePeedCY23+SuJDHpe0lLXeZC6HdUvLXI1oExD9Oyadd0qulHGBQ/L0wHGWPadphJdr01XYP2dicRkJKR614k7upsRucOjOf17fSMYbG5MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862385; c=relaxed/simple;
	bh=byRYj04QGQApI15tiXf86LyMpnp6+y8t6n3SfKUJfXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FF2jCtXMwNDabMWc5Tvt0pF6Ahk2+4OBKpdCCLQioPMdOIe4Ku/Goi6cufHNTpVTCufpC4hYJ7r87I+yqWVQzvkorOyFnYNHugSyRUfwY72CgcWRf8emjjHCKWlxMfIZHLlo0ACwSdHCk/3DgR0NMUBm+56XkOPsBLHssCh8X7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xNX4o2J4; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xNX4o2J4"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso33603105e9.2
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 05:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776862382; x=1777467182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/O57BXYHK8ET+Z6BA/YHEqhtOr337eupd637bkTh7l0=;
        b=xNX4o2J4RCzBWXe+sz+Rty9cFl/H8UJ7SUHLnwOgo0ThL1DWFYbysl3907fJ5ckvQ/
         5zAJl+Fd2TSjqw82pK0XebJYuEEXH5HpyYN8smg+GkuruUdbeNzs7292GPI01YNq92fN
         A25/wCp5lwqp+GzmLyPbfUafZdyV0CTOQULXpIQ3NGbqLf9A0htJZt/dVvA4yhR6QDUb
         VapqdDB6f33JBsw8movX8YNQxbLuAqYgFylZjepBIYpPSD6wveMtZoSuHfBYRpafirGh
         QSd2fNZytO+DqjntaZvgS64i1opQWgzkxXe0nMapLA8ooxoI7vTwHqq0cw4I2iUtATIR
         K89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776862382; x=1777467182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/O57BXYHK8ET+Z6BA/YHEqhtOr337eupd637bkTh7l0=;
        b=IWGhzGpOlZHMzDpCw2BAWjtS8//vJKvgEVA8kL4MBSUfsflT4LjMYi9ucfNHeyeEoE
         D809X91XrLhHwQhq28OywD8WAuR+2C/FFzFhIg7+KNi3bgU82jgA9TRd5Gxf7F9TYclJ
         zZ0Q7uiR8x8nGBDR/Lye6MZWBPfp9wmZQJ5RDA77qpiZgeKtN49/KdGNZbSmySv38oqD
         n6jndSm5gaTXlyNGREM9OF7w4G8/jDgQ8eS/MkfOY1hx0qteu/reT2q/1QSGBiN5jx0x
         NoUkmlY0hgRzgecqMxsmjlQcXZWB+UHhqVX/2b/brZJaB+fVASxjkf2yNC8+DcG53H3C
         P3fA==
X-Forwarded-Encrypted: i=1; AFNElJ/wIdNT9O2iheehD8G7ZEV4Q0l58bg76/OQRwH9bDmTG5H3OGiqz7CwhEXAWeF2TDg/udc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfCxlVxvxmPYdWKHTktwwptdRwFZ7AgwZmQExDf/PxLZ6qgyIV
	usuRsFOEmtuHLrxi53fbSlgBrVSkg8hHKpRTdYFICY/WYMMoqvofA8H5hV4mzthrvB0=
X-Gm-Gg: AeBDiesv8V+pfjG/XNn95EFzj4TobHleIXlBtw7Cy65DO8ZSoYTzrIRlVP02ZfAqSDL
	Q895L77Sbqc48R2oTbdWtpxG3vnB9MK80CmU47/OjgHykGz598bEq3rRjVdyhUe/XVsS6LVRq9v
	Bvr5m6rT/hYJ/Gw67/dQIAGeD6GeDVS9maYcw+CJQY1xnIdEsLToHeUoFLUn0Ha7tr4Ig/fWMtF
	6tx8frEtVazFb1Fgn6kHW1azf3HxIrIQ8KZwCmhi6Aieuv1BoB4yb3ToHtdQ7ioFdn4eoQnIi/y
	u8Bo7OaMeJO8oWGMEvvmxY4Cg1wU4jrKIg0HwxSVR35vHNnY/dn/K79B2te3IGCm6EuLmbuBbTz
	2hAH5rMv7fw02LUZICoP5p+O/S1Dxz2pDHFUIg1kHT/CY19B49/6JUHETw4mb+EkNNWdsF7tFd7
	muKSOrCVWXoRIxbe1+ks/xhFYh5e9OhWoFOA==
X-Received: by 2002:a05:600c:3b04:b0:48a:5574:3a57 with SMTP id 5b1f17b1804b1-48a55743eb7mr94839625e9.29.1776862381644;
        Wed, 22 Apr 2026 05:53:01 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb75c695sm134492015e9.14.2026.04.22.05.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 05:52:55 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 6C5CD60469;
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
Subject: [PATCH v3 06/32] target/arm: migrate PAC trap syndromes to registerfields
Date: Wed, 22 Apr 2026 13:52:23 +0100
Message-ID: <20260422125250.1303100-7-alex.bennee@linaro.org>
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

