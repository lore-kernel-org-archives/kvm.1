Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A55D3CE48D
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 10:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776852657; cv=none; b=MxTLVOWGb1PC+cxRx1xR7w+grAVTi3Rmkzjz0ZmGKpx5gMyZRFgAe/cFhR3CYudHj1qiC8zrBJffWj5/v+iHzfYCEyMtvSZAgS3kiuAy5q2KAiLsPpFScWdyISCeluGgdI1s1LqzKCNwuSMorDxTBWEGnM2Gd+GEw7xKCHHHHDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776852657; c=relaxed/simple;
	bh=cccoPHM6d5qV2Ni48oei9X1VKYcFgX+rd8Sz/6nSoWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DcJa9mKqnDFYkgB/TWJ8JE5b8lTArdodbndNefYeBzYUrpCvCjqwtS0s3gaQNZyCAjIxwjprNY7gU91W3MXMIfQtkqYpKFxHW28u/uIToe0F8SAO6QcmN5HTzm7Mu+khBNwIZjqtHtOzyif8FLY4oF/fsJhcvUP6sdTewldm7zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ki6DdxtH; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ki6DdxtH"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d7645adbdso2849308f8f.1
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 03:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776852654; x=1777457454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJ6frWkT466kUBA2I2u6c2X58fkiBAsV+LbvLNVH5Kk=;
        b=Ki6DdxtH6B49ksMunThedxsJh92Koasou9AQWk5Uy5eBRfchJSSH5rXBjdzlU07uj0
         lj0GnGoBAstkpyBRtVnTdc7EmuLgeVmW6/hOAzeY2gtqhfNfgXzJU8UyjMcUrVnwWdUe
         iRrRhhcc0ZPGAVHQzdctwfa5WvpsuwFYI8K3oO8uWctVYV7zsxFcaUflFGfHdvKSvtlR
         E1XFJn1UBtxfImUdA/Jiwd85QPoPeOmH7YTwFF2+Y1D413nKwRRCNyCf7UZNuLTIPiqw
         LW/2iVqhFsbF8ZID0O6OiMNKUJ1lefo9EBzmTPSm3YX4qbJAloO1wBExBBxws4/8lm2u
         Dc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776852654; x=1777457454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AJ6frWkT466kUBA2I2u6c2X58fkiBAsV+LbvLNVH5Kk=;
        b=dq3nE97CPa3mZmNVox9LAHwrX69KcAxV9Z6yGjOd6f1D8qD76L3NzVle5H7ZVRJAKX
         9VUzIyiiwAGsKRLWhOWu4bDq/1I9sEXdmRF8OLBB0CxIH+7XUiXQM/6FUBsq8dDV5LJm
         FV1uUenze6hQ/dXrNGeoY3TNaYz6zlh45l8i1dUAphOzDXHsf5p3v0b2WLEjOgSFkj6w
         XJ7/VTBcrPIeO6Kt1yAjuniA/g8HbAtkpu8T0OmNE1o0cSahTyzMjmOJV3kwJ8rNQOPW
         TcZLs685e12lKZW90mWnptFyA2Hi4UYQhoIO/Y8L160xSpami5ymKV+B8Hw3hKnLuCvV
         kTAQ==
X-Forwarded-Encrypted: i=1; AFNElJ/VaNWqnnrr1J0SyQCzua7jOrPIF9o3qe5QnRNoshnfBspiBDcooJQmj4Fo6R93PTlTGLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPJcPUAbNgL2a1bMvKSQr+KE5lCwS2T3sdJbqVjXg/d/4ck6y+
	AKGlGxft6FKMJNBq2i22Gcy9FVYg7cjClNu3SECT84R97y7+NyF5GX/kgGZEbelxrs8=
X-Gm-Gg: AeBDieuEyKLI6YqMujCOA82I8+4u8W+yjGviou8UgsJ2gadLBo3MoI/vqqgQPQEbpHn
	/6DS3369zPUyMPwxocPZ7T0Vuha+xKm0Zi+65sL0h2wnAUOyV98IZBqmZK5nX8lDjp4TtseO7O0
	vz556h0EOvMKmRvnHyx/b65/I0lNezjwOecZzsCwDqeUkfMfa/MSIObJfMDoHbpW0jaU8OV5lts
	UgJVTXpFPTIo826XUtpq9kI+RBDFvJd+I6MUwsXU5Ylcy9hFTvR+G+U9OBEGg/35k6qLOUn5X++
	lJvHfthQ3dInDFGtaLrr9M3LHNgbSlCY8WRys5xjDfvyroTZ8NHowNDmjkP/ZWly+2EITcZHtt2
	gTrtZgORlH5IdBU80uuViPhDZxPetJn27mFmCTngeQoOMkHdmE2P6PZuDslHsLZHJ/I/wTX9O6X
	k7HdOC86wtocaaYTsj4msXQ8M6cg9YZgoNuQ==
X-Received: by 2002:a05:6000:1a8c:b0:43e:b0f8:66f1 with SMTP id ffacd0b85a97d-43fe3e0b86emr33151843f8f.43.1776852654367;
        Wed, 22 Apr 2026 03:10:54 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4eec9sm42224451f8f.34.2026.04.22.03.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 03:10:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 880F161028;
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
Subject: [PATCH v2 14/31] target/arm: migrate memory op syndromes to registerfields
Date: Wed, 22 Apr 2026 11:10:25 +0100
Message-ID: <20260422101043.1234229-15-alex.bennee@linaro.org>
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/syndrome.h | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 7ff8c30e2bb..841fd3292b8 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -742,14 +742,39 @@ static inline uint32_t syn_serror(uint32_t extra)
     return res;
 }
 
+/*
+ * ISS encoding for an exception from the Memory Copy and Memory Set
+ * instructions.
+ */
+FIELD(MOP_ISS, SIZEREG, 0, 5)
+FIELD(MOP_ISS, SRCREG, 5, 5)
+FIELD(MOP_ISS, DESTREG, 10, 5)
+FIELD(MOP_ISS, FORMATOPT, 16, 2)
+FIELD(MOP_ISS, OPT_A, 16, 1)
+FIELD(MOP_ISS, WRONG_OPT, 17, 1)
+FIELD(MOP_ISS, EPILOGUE, 18, 1)
+FIELD(MOP_ISS, OPTIONS, 19, 4)
+FIELD(MOP_ISS, IS_SETG, 23, 1)
+FIELD(MOP_ISS, MEMINST, 24, 1)
+
 static inline uint32_t syn_mop(bool is_set, bool is_setg, int options,
                                bool epilogue, bool wrong_option, bool option_a,
                                int destreg, int srcreg, int sizereg)
 {
-    return (EC_MOP << ARM_EL_EC_SHIFT) | ARM_EL_IL |
-        (is_set << 24) | (is_setg << 23) | (options << 19) |
-        (epilogue << 18) | (wrong_option << 17) | (option_a << 16) |
-        (destreg << 10) | (srcreg << 5) | sizereg;
+    uint32_t res = syn_set_ec(0, EC_MOP);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, MOP_ISS, MEMINST, is_set);
+    res = FIELD_DP32(res, MOP_ISS, IS_SETG, is_setg);
+    res = FIELD_DP32(res, MOP_ISS, OPTIONS, options);
+    res = FIELD_DP32(res, MOP_ISS, EPILOGUE, epilogue);
+    res = FIELD_DP32(res, MOP_ISS, WRONG_OPT, wrong_option);
+    res = FIELD_DP32(res, MOP_ISS, OPT_A, option_a);
+    res = FIELD_DP32(res, MOP_ISS, DESTREG, destreg);
+    res = FIELD_DP32(res, MOP_ISS, SRCREG, srcreg);
+    res = FIELD_DP32(res, MOP_ISS, SIZEREG, sizereg);
+
+    return res;
 }
 
 
-- 
2.47.3

