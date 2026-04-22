Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BE23EAC86
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 12:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862382; cv=none; b=OxcT58Wd1lrdoJLuZOrSAXHDEczzNjRgf6VmJWGIt8Z6DsLh+2TFj4lT/+YQiPvC0LM8saTJtjvPPIJwWEBxVdr8xMkS3qkVLqJjumJfH6yaqrfTALZ5crDqZPQzDB4no3IPBHbAlpIFhGnwKGkZDVAoYmbeTCTFdymtqQsPA1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862382; c=relaxed/simple;
	bh=0Ykhl9IF8fNR/4GTFmuwJ/ajcVHu9zeqWMWjbn0CNxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DcDZn+BwnmebFSQD7C/5YeD6VMYiBTlpgKYPBbQQcmtwGvIe8qzTOFeb2KyfybHuP+GnC33+w9KL4SEVuTSAXMvUJUOHU70h5PG0fTAdxuYes7tPF23Z5Gg1pvBXrUQtUN8ZzHtTstURx5Wxxii+m2l+1pjG3D4caKY3d/ha9kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hlRlHC/y; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hlRlHC/y"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4891f625344so37527775e9.0
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 05:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776862379; x=1777467179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oy8aVZbZZZe1U+CUvOIDDEpwm1FnWydA8CkWhWsEzmU=;
        b=hlRlHC/ywzgvRLHzKAF8VnquxvPwEN9K/iI5bdzLA6YJdNgc42tpS5K5EuwDA4nrlk
         4xyA/z6aWdWvf6fygoZngzFPPEEVHkEkToShAW4hD+zrH7pvuWZAs7oDkpf9rJt2mq+n
         NT7OV6oZBsXUMtK/RX+mrtb7ApMM87Z+PmZ7vED/UPIqbS5BaEqBFb7Fg8awC8OeJKNX
         0kbUZ4jNVqGfK523HULFBkYl8/TKkj9QLL6vW79yqdGq8fxtw7281EZ6aeGLsDfVVIGJ
         z/bOWPWkrVv8vMAsu8jcGrVVBtazwJR4/MjVq5jhKWu8KeqQ2Hy8a10wzVQIS+xw37xp
         nWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776862379; x=1777467179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Oy8aVZbZZZe1U+CUvOIDDEpwm1FnWydA8CkWhWsEzmU=;
        b=AmTtXyN5MlPjhEQB0OMJ1NyEqIyyZ27PkFQXZPtTxnmIXdVlvfJDpwfJREPOVmA+am
         jNzIPdTm2RdZcJk3C/LX/Rs8bS/kXQ9tBqAxc8gMS3WNB0XQnjIxwAm/apJZioipcXf3
         IEbgED1AEVphN7Zrm5Psed81Ck48+tZu1xL+zPja/ZFTJem/Bm99z8LmyYkf+4j3dpB3
         dmNPbH7gtWJnYT/cYzfQKcivOL/t8lBCa4uOmO7gE2zqHoxwMMsPslNYVLoX/DrOk94h
         hAZs6oEEy/uUQk56oTwpdu/nuTMRhy4StlAKH9t3ONl7VUParjYYatDOJrdGJg8ZD+Qx
         o8vA==
X-Forwarded-Encrypted: i=1; AFNElJ9sNrOPKShC/IaG6wvUWVt6MiyfqjkCUcnxXg7GvWdgIAjX6KUqM24T41ItPE71AdseoOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwcvuChWDGHs+mP1BK9NIU1k3e7mD4oPlr5P/wdqT+uQVIzAoy
	1wrQrRG9rUrICDtxdCCMkmeulG50ieCpePvv70MOWA2eFb1x4FHHTMS93bKDTJr+ngQ=
X-Gm-Gg: AeBDievgtxUeWmj+r5ZhWGm6G2AmrL9l0TQxiyh8qMmieTV7XpJfrSoFese+Zkmk7wr
	/Msru5gsSfwgCk1MuS1m/yHAxn5rQhtq13tIrVoCjCBo2dTtYVDe0HqLErI6Dijb8Okd0pktVr2
	pF88UflvfkyAAxCiPPKzqmnG77u08KbHgyKSZiI4GxEDKTUYBo9LQ4PLloBwf6u7tZvnw7NTbtc
	+gps6fiAo0/Et5zkvsa+HiTuFPPhY5RKNe9yNed57WIoEF/0ltwUbrVpG/wTiVIVp2u8Nv0Ww9Y
	L+5olb6NflffDkG/0ejVmEDEE1CVd+bf9PtncetdpNj+PA4MzSoEezBdaaY29R0pRemITl6EnB1
	FNH6ePBn/dlPy/nDGFmjYHPCQDH9OIEKbuU48s6OSpej8vXVX4x+/CooHmp8uBLRSu4AQP7bZ9E
	kFDA2UP65kAO4PQKW5hFnSaXgsdhCFJWd9hg==
X-Received: by 2002:a05:600c:2288:b0:47d:52ef:c572 with SMTP id 5b1f17b1804b1-488fb881ee2mr212647635e9.1.1776862379208;
        Wed, 22 Apr 2026 05:52:59 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4412150a071sm10434897f8f.21.2026.04.22.05.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 05:52:55 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id E154060F2B;
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
Subject: [PATCH v3 12/32] target/arm: migrate wfx syndromes to registerfields
Date: Wed, 22 Apr 2026 13:52:29 +0100
Message-ID: <20260422125250.1303100-13-alex.bennee@linaro.org>
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

