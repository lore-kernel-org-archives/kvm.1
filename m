Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E363FC5B2
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 11:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882208; cv=none; b=V4rlxCSM51cV1vA/esiPlpgm+txEavL5yfWxK3xS41nnY3BnJUtHHTajuuF9sONkk0cr88vJjS3SwiyGWQa+M3KynWFjkEGxj1zhnGDSRFo44BaHV8dT3mMJKzarvBl+mMSfxa1K7KlTbgj1GUA6KCeoTfq046wD8zJ5fWnFvB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882208; c=relaxed/simple;
	bh=PRPy8vZH+yq7oMndI9b0tLLdIMBpZsdpRhRj9L5P8Gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yo/Wwz+wGxor0XCzvCN+wlzr3C9m3iUFr/vO1G2kd/Kv+mJUjUUX5e1QodOmdt5ORw9RSdTGOCyt5WfMTAPu6GYBslQ3m7bAAEmy7wgHbsHyP0xNY8FMZ41Ae0cFe5wMc62jJjpOtWQg0T/o+th5ANmD9dhNBvBVLNS5ipuGab4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ntyWcJ13; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ntyWcJ13"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45edc09f51bso377641f8f.0
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 04:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779882203; x=1780487003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7GYxN2UVnGng7v1vHA64tX2rIv4kqC27OcexOk0+YM=;
        b=ntyWcJ13e24bAfGvFnH3aH7Ko9038vcPdr9whR+MNIfR4nPxlEmmJb+HifDFTSd0/Z
         udxQ57qC0Pvd+tlKQ+bUnRsSmPoDpbWU2O8SKkWoQwsGojzFJwOkBvnW/OcGJQDV+tHc
         GLDSjzYtEApoVX4mBiOy/H84nBpmLfjSBoRnZ7kDGsGdh9K1L/H7dSqrQyYQfj4k7kSE
         2TagjfvC653E5mZcCbV6mEz+CC+0se5ViFrIVrbMgKyRILl2vU14gJmR0XSVfwRzeIaV
         O9PuAWxQV96+wib/+RijaoMWPeHSZXvW91ZJLahi4RfyJwxcvXLWvB1XfJqIbZwj2Yqf
         uwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779882203; x=1780487003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+7GYxN2UVnGng7v1vHA64tX2rIv4kqC27OcexOk0+YM=;
        b=tI7QdOFr5cKHpEtpfr4e63ljQUKezb0C0rcqZiU4TP2+G93kFTahHKypopggp3/aVI
         5IfNMbZ6hzywhfp/BYWY4x/7RTLKw2MN7/Yj/9kKQfEfs3Hfs6dqQMQXpojleuHE/61C
         4+cmc8oLs82noxCs4kX9qNcpnAmxC7bQ83hd9wNuOLRVPk6D3s6TSwzqjlIIpao3AkxY
         qEa5wXoIH/CjZuyiR1zQtuyWQGso3g7iB+SBjE0zmVrpAYkYdKc6KeUtyqWOjmAY/35i
         FRl3UpxPZzqPJN30wnKD1KjrFPiE4iMvfmZdSIqg1GXeLCmF/vzyYSuRVUQ8YzGnlEjB
         Bfag==
X-Forwarded-Encrypted: i=1; AFNElJ8l87p5JJyV7Elb2bNc/q1wLhSSSoEvU8JCAcdugAfKuNHs4lfbAK1+/+XuBqrz9CTPdHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzemgEX5bCEIKxhTsbSiz2bpjr7JOBvGq5RPRf/bPpsDn8M6ujC
	iMFXEdNQDLJRh4cUWbyE1/HOW9wjFSb8efN8rI6LJb/3IIVsDUD8CiXvUUwHcZJ47gY=
X-Gm-Gg: Acq92OGELjTJq4NI/fRX1T3xlk0fBx68qagCEcoSRY0Q4OKYPV6HXJeBctoM6hWEOFb
	ZWcvYK6DU3MBLKDtyUxuUk6zBGdqkmjyGq3u0WFj9NwUfoy/iGQZsmzVsxioCvh74enBcYuyJtB
	SkOZBFO34k0siTJK8YHhaCuY49tsmbBCcJ10iK7XzFUzYyQUKULydBKp6LdjkZt2hEXHHLR4d/+
	V+yaqCd1Hhj1upFx8T6oUa36BhdhEz0taEtzVOwhGbnu8nGDWUuImYQCUkruX2jiZ7hA7Ir58hh
	MT9j8esx32bBoEOcQMjKEpk3L2M/tQHHmNDsVZWYTcFf5GDP3FSO5OPnUM3L8tLPto5EorA91B1
	hccY7rR0tGEeibWfbdxz8oFScWZXf1BjTh0G+o0K0eANBrTUcDlLNHrSgLgiye115g6VyECENMC
	CtNRaYCoYLFAZ12PPU7s58kNCtiEbikFD6EA==
X-Received: by 2002:a05:6000:26c1:b0:44f:d9f8:c0e7 with SMTP id ffacd0b85a97d-45eb36731f6mr39921252f8f.5.1779882202929;
        Wed, 27 May 2026 04:43:22 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5c47a2sm5341167f8f.37.2026.05.27.04.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 04:43:21 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id E2E5F5F92B;
	Wed, 27 May 2026 12:43:20 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Alexander Graf <agraf@csgraf.de>,
	Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v6 1/8] target/arm: fix WFET typo in syndrome
Date: Wed, 27 May 2026 12:43:13 +0100
Message-ID: <20260527114320.1581552-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260527114320.1581552-1-alex.bennee@linaro.org>
References: <20260527114320.1581552-1-alex.bennee@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A stray x slipped in and we didn't notice!

Fixes: 4575da5ecb7 (target/arm: report register in WFIT syndromes)
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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

