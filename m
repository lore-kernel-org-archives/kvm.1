Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848AD3ACEFE
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 08:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043392; cv=none; b=ITESCXg1YLqkereM/cjLs1HFHmfwtKRN0r5pWOMD7x7gH3wycGMR/YL46I/KePHrFtx07BGgvW5ujINFn16lWOwaAAXP6WoJ/Bee8gaJ6b4oytAQKK9Lopfik/V/KPIFYzafvWJjfL+NBGFVsT1j0N+E/vfNpB/Jwq55VEn2cWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043392; c=relaxed/simple;
	bh=iL7OXich64mCmH03B4eH61kC7h+p/BbFxbbao6K+HMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b4rp0+Pu+4bg6BmyZR7P90/5VO18i4bXzYhHeDPrq6O2cpst7Hav24Fg+vagXxa3Pf3RpN126UC8I1/5SojSabxGynRFqEfnpOeY+LB5gtWrYPGM1MiLU7NnE3OUMSkBIsjeuYNua0S7QM2q+CjPZQyOLN29ftnPTqi+cs6ZHpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W6H4MgbN; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W6H4MgbN"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45e8a834cc2so8379461f8f.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 01:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780043390; x=1780648190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+G/zHWkR0QCdbSyAQf68yG2AhF714TiDMy1VuhRq9nA=;
        b=W6H4MgbNJ5TRSDvlLpEdgsKl1lrKzKNu2QzCugkiH/PtUNyD+WAsEYOWN+zpNY7ZCh
         0a5w965Z0WeCeI584qiy0x2k4BEwpodgBHaARbOnUeDdkmueTFTQ8Jf6tuP8Ap7lhWFX
         /bLM3e2zobC5r+0D5/3A5PeHJZfISxNJ4EizfsN2kxQFO00dQNHCUuyDfOUwt+2yJe/n
         se7g/gWMzrvCWuNDFETq9R3wY1Y7g5Za3iYrSrlKo5j5vMawpg9sYpjn7XgQLiY8hKyX
         6cxK41plJm/AnPwedSzgIboUyqmIkVjM9p0ckxuDJ4q06gSUtkfarViuhhJhrYFfl3Ue
         VROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780043390; x=1780648190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+G/zHWkR0QCdbSyAQf68yG2AhF714TiDMy1VuhRq9nA=;
        b=R/JCEf6EcMoJKYUpYoRnvs+Uy7DNTho73Y1Qe+UNqUzhXmfzdjNjJlwsdJNU3nkbnj
         9X4zwp+J07V3P/rp670ntv4wTGxxYUGsVHPMZMX1OTjdpAKx6tnYrmY0Gr3euVAyDm/C
         GFQSm8psWqvYUywQxlcsK5fDuwPNvxrBk5mgszRX1olkyBZO239dJsqiIgQOPQkSKNO1
         WdBS+w2aKxEQMZz9jDL9inFM7OkQCz06NXlbXLz8J4UR284jXUYm9cCmNUdonQ4rr3/Y
         2UgMHVoCBSY0lpL2A6llWR/kODtEB4lZ1/BpBgcPPFqOHGflSBYVY0+D1oAbqWIjnpEA
         nNLw==
X-Forwarded-Encrypted: i=1; AFNElJ/U776EaPh7+cw3h2k2eZL/Aqh9YTUDp5Aw51hrZuUIqPX6ASujWvj70E1XwgC47yHpe9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO0EvmeNqImrmoQjpPvse07VV93xt/a5P3TzyI8UdQ2BkPlkws
	8HmBtWbD2y9k+gHkBi5wdK2LF2bDaJtwqPr6d68u8e64b2u6+Il4J/UEpArYRbRSsE4=
X-Gm-Gg: Acq92OEOPF3C1SWQomC0dGimOK5MPQOrdB4HKVXo1LP57ql6iCNgAcdoN0v1kXf0tWe
	/MY3Zlobs92AUUd4viTgyBdsSnNGUIcUVNDzFrqiEiJMwyL32K7C6jld3ou/H6T1yIksY3x0T3t
	PkDlZ6aDPb1XAzwiVirB6sznu6j6hTzGwW1lBEJPLb3vWTHBVCARpD+PlMyzx7Vy8cU1XSIVJgd
	AKuWOafskzJA3hHHBsrqFQV7gmKQdeIsdwDO9Gy5ghfPfXkLjVWpxf9fuVEpOwg/chWB7GjNYoj
	Gkuem5a046kwJ9J++Mn7UPiB7gXD1L+um3Rpow9wMtGvSmuNL6nqJvfqo1r5eCOmopBBWlFq1ee
	RAu4obxB7S9t0sKHPcZMyyOZ+mqBIPkhkA3fH3w04s3SHBZrMDf1hLeHiWEmimALzyE5D11f2IN
	EO4oRpiW0qwT+EgEvFD1AYksRkvQ/ZM77jd9SqsfRcfwjG
X-Received: by 2002:adf:e612:0:b0:45e:edcc:f6dc with SMTP id ffacd0b85a97d-45ef14053e3mr2409052f8f.6.1780043389791;
        Fri, 29 May 2026 01:29:49 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34a0403sm1967087f8f.6.2026.05.29.01.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 01:29:49 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 386435FA5C;
	Fri, 29 May 2026 09:29:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Alexander Graf <agraf@csgraf.de>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Peter Maydell <peter.maydell@linaro.org>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 1/8] target/arm: fix WFET typo in syndrome
Date: Fri, 29 May 2026 09:29:40 +0100
Message-ID: <20260529082948.363931-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529082948.363931-1-alex.bennee@linaro.org>
References: <20260529082948.363931-1-alex.bennee@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A stray x slipped in and we didn't notice! Fortunately we haven't
implemented WFET yet so nothing is affected. But we are about to so
lets fix it.

Fixes: 4575da5ecb7 (target/arm: report register in WFIT syndromes)
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v7
  - mention how we got away with it
---
 target/arm/syndrome.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 4d1f1c529e2..0eb54c15ce7 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -674,7 +674,7 @@ typedef enum {
     WFI = 0b00,
     WFE = 0b01,
     WFIT = 0b10,
-    WFET = 0xb11
+    WFET = 0b11
 } wfx_ti;
 
 static inline uint32_t syn_wfx(int cv, int cond, int rn, bool rv, wfx_ti ti, bool is_16bit)
-- 
2.47.3

