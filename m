Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C495B3CCFAC
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 10:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776853056; cv=none; b=uU8TNv6+Qc6kv3WYe0ucvfw0285fASQgiHP5x02jpcNrF26FD8ulcwK27lJNVDgSla0nZTRIBXs7ThDP/Gb5i7ypae1nRapzcSaqctAqXbbkp7/y/3XnO26JvV6WMI20mxD2jLRwTbOec/7wS7M+plr9gP8+Yg8UfUnxL/jgV7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776853056; c=relaxed/simple;
	bh=mTHqKZdyVGIZLMhFJ87JytFjQaPWNezBghnsDlTRqW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QC3x8/HwixhaY9QIYJ48UpZzTadsUaJ47NivAtByvUU6ta7fRuhu1wIoCzQfwoEnCS5qHv3hAJjXqQkBxilWOoaz2PLaQY9VUhKPP5KovgL4GkC8IEY5B8UdKcKMzLDGH40NDMrr3xhb+LLzopuUxUavIyqEiehGvJQkw0srep0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bVLRTQDA; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bVLRTQDA"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4411e1eba51so1933084f8f.3
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 03:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776853053; x=1777457853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1esNeOF5ufpO0cAxHdsE5rjzSjC5Q+4Ajm02teJ1954=;
        b=bVLRTQDA9vwmuWulzM02geBABSfkwx7nfeepqnQSxC+tPgoGhn1aJOal72+c+mwzcE
         lujIvzHits00nHP5RPBf4bQLUhi3tgUGub5094mf8da0MJK17qi3dxLFWCShvMqeAxzx
         KuGImWpAebVh4J2MvSpJX9kNKlhwCXIWg6cspRjjLPAxMARB7WtvL0vdtN2I0fIntpE3
         otbIfs8EK+n2I0qyrw5WhzM/KP6kuQpxh9cutmWlay8drN+VF3CNLK93DkujEnynSFRT
         pi1bCHmuag0yt3JSMUol9TUs1M+e2XusSJnt2ze02xodbrNwNBY2QLUsSNXQ9p+uOp6l
         zMRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776853053; x=1777457853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1esNeOF5ufpO0cAxHdsE5rjzSjC5Q+4Ajm02teJ1954=;
        b=gtrKjsHs7yf2U1Em7e98/oNLp+fcucrWGcO01jpXo051Xft1PriCdWR1T1xmiGoQPI
         vzQFRb+9LO6KLcMl6vAL+8h1/oS2V+Os+d8H3NIQJZnUHgD5VgGEgMXmdvyh+u63fhUa
         TD2h4+7LQ/rzgOE35mKj/hegaP5ufcpeqfeyclZa07jMLwbGrk/xKWMPy9W4NymwVRga
         mDH9XPVMcVzpWwjV9ttfrtIHUV8/X9U6DfhptGyqal+oNJbs62pDmq9J8rBx/2eDfI+3
         O4U+EJE1LEK6/wNBKHs3nuCKKGWIkZ058Y2uLAU06ZLhcDVOda6w62efjMhqqAO2x0PA
         d22Q==
X-Forwarded-Encrypted: i=1; AFNElJ+QabhM8rClXeBVr2mvKSHg3OwIDCvTaPNUW8goTHcDhDSKSoVsfw8yc3Q/+kNy59f1gYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHlD1nkh2+mE5WYD/LYmhQHIVSSYGcBPciWNhQ6dP7FBSgPM2R
	yNlaPIbMaBwSc1cpzEw2p23YSMDmva1pXs7ziVgAk9NWnvwUcMpjaTF2LTkR2Yvk//k=
X-Gm-Gg: AeBDiev0YiOLSPPzvGaRI5rPrHKWyOtnlTSZw+OoCUzC8vFwM4x1LWaGg5x77AilKEt
	jayx302uR51HF1XqsWCpjJhtrdiriQfNms8xgKDvrEUjOGjitBEFVwmuugTQyuK2aJxzJBMi7Vh
	Ia+OBvin0lIWG0CcpDYaXry234af2+sdleFLKW2Nfa0HgEmSzrnZ6CNkMsvMCAf1MbniukCO3Jv
	dMz8oBvVioCFwMRwO36ZaJRfe274ICSkpSEANTNi8EQ7rG1bd0VVC2S0Dc0IO3IbShBJJJfxz1R
	L75qWhE7EBZ5ZAhzZaGPsqefWJNxCKEKIK8mBABnO9/LcggjHmmtvYg2O6uzxjzc80/8poHzKOi
	QKBbsH8jZbID4f2+icHulPiDiz5ZOEJskpy3/xlpshYto5oo9Wg/oNLWplpuNZqXYkTPdRAz7sa
	DwE7FA59zgKzmjyqz/5WbWCPDvSIfGf32Lsw==
X-Received: by 2002:a5d:5f43:0:b0:43c:fde6:212d with SMTP id ffacd0b85a97d-43fe3e13d46mr34364660f8f.33.1776853053246;
        Wed, 22 Apr 2026 03:17:33 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d5b1sm48556243f8f.30.2026.04.22.03.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 03:17:28 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id D6D1F611AD;
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
Subject: [PATCH v2 18/31] target/arm: make whpx use syndrome helpers for decode
Date: Wed, 22 Apr 2026 11:10:29 +0100
Message-ID: <20260422101043.1234229-19-alex.bennee@linaro.org>
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

Rather than open coding a bunch of shifts and masks we can use the
syndrome definitions. While we are at it assert it really is a
EC_DATAABORT.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/whpx/whpx-all.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index bbf0f6be961..4cfc7f99698 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -356,15 +356,16 @@ static int whpx_handle_mmio(CPUState *cpu, WHV_MEMORY_ACCESS_CONTEXT *ctx)
 {
     uint64_t syndrome = ctx->Syndrome;
 
-    bool isv = syndrome & ARM_EL_ISV;
-    bool iswrite = (syndrome >> 6) & 1;
-    bool sse = (syndrome >> 21) & 1;
-    uint32_t sas = (syndrome >> 22) & 3;
+    bool isv = FIELD_EX32(syndrome, DABORT_ISS, ISV);
+    bool iswrite = FIELD_EX32(syndrome, DABORT_ISS, WNR);
+    bool sse = FIELD_EX32(syndrome, DABORT_ISS, SSE);
+    uint32_t sas = FIELD_EX32(syndrome, DABORT_ISS, SAS);
     uint32_t len = 1 << sas;
-    uint32_t srt = (syndrome >> 16) & 0x1f;
-    uint32_t cm = (syndrome >> 8) & 0x1;
+    uint32_t srt = FIELD_EX32(syndrome, DABORT_ISS, SRT);
+    uint32_t cm = FIELD_EX32(syndrome, DABORT_ISS, CM);
     uint64_t val = 0;
 
+    assert(syn_get_ec(syndrome) == EC_DATAABORT);
     assert(!cm);
     assert(isv);
 
-- 
2.47.3

