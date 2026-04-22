Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401FB3EAC8B
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 12:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862382; cv=none; b=CB3bv6whSsEuB+FrU4STqoxDhbgFULVe6pZ48ch1ua8t6FhnjwipMTWcDpBNbmfNryBrWm4Xlc4yOZlvXivKSUQ7esKgTs677VANxVAPu0I9Xijr/R1WCrJwLkxVvSDqLMxFlzMYGKe9ZyCXhsD7PRJhqID+rQYUc2c5qtMCbNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862382; c=relaxed/simple;
	bh=I74ngpgJdGFCGwvTHiD1IdLZCW7KJU87muANcBYteRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iz12NTcU9bKsZOahpapqcql3M4d4xnhkVMkCtvGSD2Sn4qyEzbxMEdm7Ru3F+JJzUO205mhKP+iSvTH3XuhkcAxJifyzBehGPQPmQxNM0rOS/B2d08H8T92B014PLmbPMKvUf0FzPD7Ms3HcxbPTmaBCCQ19UMMnXChntwQVC+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q+VVci8P; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q+VVci8P"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso60859155e9.2
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 05:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776862380; x=1777467180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAtQqYAVHVvhu80r9xI/PSbLS4M6sLMvc1JPbP3qMzs=;
        b=q+VVci8PU1nHgJkQzPhIOZ6t/61AKWvrYUt8J6YHXVJN92Z2NiXwmDv32DpWOm3X2X
         mZq+div8EqzKkqSwL5wBgbbT/Ea5RiOuqT9XVBPn3S9VJZ47hNyKqKPIOfbqlWiO9OKe
         3+e/s2Ut9rmkEq/uhD5+Ss7NY76hQUr2edxPKEkbzXYQvmyAp+Jr6YdfPAJSPvnSO7s0
         4NiFGA0/AabwLm1HXv6nW7ViLJH0cslbyStN/AzBFeXHtoTxxDyHCpQpDvqxNK1AaALb
         5Qk1sY7E6o/T5pskQAHOOD3y0gm6embk1fhVh1oQo40ktTV3spqrrbT3uv8DPUNmz3sY
         tuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776862380; x=1777467180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EAtQqYAVHVvhu80r9xI/PSbLS4M6sLMvc1JPbP3qMzs=;
        b=fm8AQjmLUgQsyB1wC7+uyY26Iz1R+Lg4mA97XV64IbqSBnBdMZNhEt5GuPx3NzX6nC
         sQpzxY27+d5saPblXiJLXCXY0sHtRDqVwe/pmg9bjC4I5LJgdtkTjddNkVOcs8rdztnK
         lCsTzQVOicC8oFZ7R4XMNJq+l1iuJ8NnNyY99uFnZWcMEV0tNTzhsLDsxvM1thpsZvbP
         ZIzG6U3RmBZUD5leUuZSypAYCzzAVYG1YOlxKs9G5aS5jVd3rN6wVMGC3UTAwMcQ+K23
         A6l5zgQcHfZIS0jdaMba3cnyf+btH2ZhkTp+3cKYXbvWgP/EDrNrfCSUd5Vj8tUMUwEM
         TZ+g==
X-Forwarded-Encrypted: i=1; AFNElJ9BbqMLyC/7UAIkEmb6Vhhzjv3J3CXvA5y7XGCRJCZpyabOqHgZ9jGz9vZ/hyj6ujvcqNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCmPQGWVUUM7nMhjzcTZ/DRjG1pp1NOsGiAfrX0U3C7ViKrMOI
	XkMCZBQpH3MduNpFGQd+XoZsBGiHs9F5Hdseczw9A8IKOE3VlIE+1xqZ86cIHheHyVE=
X-Gm-Gg: AeBDieu9DbT+vHNMtNniGUGJKrYo+cN1lIe5C9IZbHZ9m4glA4jyLGrMwK5mG+S+8Hr
	aveXQCTJXmp24qq07LSCBn0fH7RwpVazFnnF5emQ+jxIF7SH5+Zx6lmJHgoAHSvvvznHSD42I0F
	NNGZ0LT6FXihAFNX/EDCo5wxt5TNE+lcq8o2i/NSfaLplIXBocP3phr3RFQvhYqR1fBmWgFzeTd
	uRKbfDHY7y/22N4IOZyWkiGkMai6EPLHCvwczr2vOLsKBzsGrRzK/qbRcV8q+jaMOCUSFF6gkyR
	2HFAbIpevOKHDGg+p5vSdbFZp1geDaY0ChLvKck78QmNoAE708KZjBqeWpLmqouADs14dcUYbiN
	ADK+3Gu99pQuJ70a2UiJwvvud+IE4CcxTpHg/DXka3hW7RBR3C5stEpe3Ng3Os/GUY1iuFTcOuk
	AMBXN8CEGASOGors2mAMj83Bo3NKOoVABIcQ==
X-Received: by 2002:a05:600c:19c8:b0:48a:554d:b9a2 with SMTP id 5b1f17b1804b1-48a554dba51mr117525785e9.6.1776862379611;
        Wed, 22 Apr 2026 05:52:59 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a5aa3ae83sm83315365e9.12.2026.04.22.05.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 05:52:55 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 7F987608C6;
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
Subject: [PATCH v3 07/32] target/arm: migrate BTI trap syndromes to registerfields
Date: Wed, 22 Apr 2026 13:52:24 +0100
Message-ID: <20260422125250.1303100-8-alex.bennee@linaro.org>
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
 target/arm/syndrome.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index fd8639d4f07..52a6745cb23 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -426,9 +426,18 @@ static inline uint32_t syn_pactrap(void)
     return res;
 }
 
+/*
+ * ISS encoding for an exception from a Branch Target Identification
+ * instruction.
+ */
+FIELD(BTI_ISS, BTYPE, 0, 2)
+
 static inline uint32_t syn_btitrap(int btype)
 {
-    return (EC_BTITRAP << ARM_EL_EC_SHIFT) | ARM_EL_IL | btype;
+    uint32_t res = syn_set_ec(0, EC_BTITRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+    res = FIELD_DP32(res, BTI_ISS, BTYPE, btype);
+    return res;
 }
 
 static inline uint32_t syn_bxjtrap(int cv, int cond, int rm)
-- 
2.47.3

