Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5440B3D0929
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 12:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862375; cv=none; b=hEzzV+bSyyaQaUvwvO861ov61iFoRyQgP0uKRGYD9xV4Z9c8bOAqlnpY04Wtj5QkZFM0We+btwdQuBsPYWfZRG7teq7Zdfixb8IzBo+v/5SQ0qRt0e4TsQ9BXOnpUeijdUuaIRg+l+fbxsISPzR58sWYMvg52gfykKdofWrGeOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862375; c=relaxed/simple;
	bh=p9zh1aSSTJl7qcoNAxlI9Zgvn5vO3xLa8DoNJqH9INE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SWgfmZTsOE3GsZ9l87QZtbAaQAS9gR41bsyCtyTRUCb7ZFWEj+lA2LeItwbxsMJSzlZuPGblvkLvHCLCbuyI/UuGM9sI8GTUTYkkorhAVIehGLhsBhuA3y4FidkQ8UtK5fL1FgDngC3tPG3IpQySsf3viuH12WgefPTJ+xCFuxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MttD/aGL; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MttD/aGL"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43cfde3c3f3so5638589f8f.3
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 05:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776862373; x=1777467173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6n23oz7LRRQlFUUM3gTQS/rrKewMUhskSZOvSJMe4M=;
        b=MttD/aGLn0cuJxc0Djd5DU6jNkipci4HiQUrxr9+oO+dZBWrjPIodbDajhJcKBqGXc
         L4cHNH1XZYjGzaRMaITQbaB9gclwcmiieJHGlSH6GVeJS1xYS9Um7WdF76TuM4khoXqA
         pnjUSxkBIkf+EKqyjMMiHO8bJW7c1KpVtkvYWaMPCWY4C5vcYVuVyiBkUpLpa0WUDlr+
         yXYB04b6UFo/3R8M6RGIH/oMDwxmauxyzTnRBvyTcAllHKivTpqWA+YwKdfmJB6B4Ojo
         if8sJcniRvQTBMSSnd4p9J5YpaUwmkS8KQ76OtwbQ/BSgMSS64IrnKXzQW/eKyg0XZNb
         UsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776862373; x=1777467173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K6n23oz7LRRQlFUUM3gTQS/rrKewMUhskSZOvSJMe4M=;
        b=QIsIc4HGHfBhLQBy6wfN/gMpUZfXeWRpZcTaPda0hJa9rJ0TVsIwcXpSMn/glXRHcJ
         bwN7I+jRltCtV/W6ZIRAgB7meu5ymHA+/OBWXf57Vp7+8JQNO3yfR7tum2JPG8tfWj0M
         fHSZVFTrCLzkouKCOnRZNQ5g43RjtyOpP4sh24z9MMISaaM12M51hxzLbgxMoGrUzR+O
         brTYFE+TLK2R1ZtG/SLxeEbJp1NEqu5hmTpThcjUq1q8rUAD2X7K+asRXEYbUbP11fc3
         +igL6Je95G3a41TPQ0d5xYav3HN/CtwsmrC7uG+YMxZ7IW16U5x33ii4z4Q1c0DtjE3s
         czYA==
X-Forwarded-Encrypted: i=1; AFNElJ8aLCmE3dGH+oFu3U93pHY5Pmxd1pkL0QuTjsV4jakDKviSC532RIgaJfFNN3Qfb0PP9b8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+7YkX82Lqh3Wm2XSgizPPFm8xOLbIiToquHD9rJkglL63BXBS
	EZMhFSow9AmaoavIesff8xDyiUz63T7cbPNdauJTUpQM7DVpQUp4iu8f+1pHoXNW3o4=
X-Gm-Gg: AeBDietYxKExsVAgBryALZ29l7adhzVg3L9Sq8by/yllxeLUWD3NEU/74UCoeHgIFBK
	it4agCbTJ+uRdm4ufYxrW9qEmZAoivmQKLcwwOrzSjO2w0HjQykTcfHm/F4x8bCg9PfHhqpe/Ol
	pBUG54w5ro5e0YCWfumSWfTz907WVGwIcMRVEdK6HU9shPFf4XLztD+eH2D4qUTR/VfLoOEzCIN
	22kDDdxOPE2tdTQvCaZV5B4/u2qxeDsY6oeIYQMTlkvAyijskEAerFeBnuYIi+v9AbdL6MHtZyn
	dtGiAX2FBoSFvuaCVUh5+FekXHgCSGDGgXoUJdMEYUuTWcreyBpsJs1jJaJmhiQcHaZbtCHVUzy
	3UWGY3J8bVglMsoj/YgNyY8eBhivy0wFVU/wcLC2yWLKghZp/VMP+rYU8r6rQHrS92kYRE68NeK
	pch2NBrd5Qo6xM1TF6/0O8oJKm8qMJdEH3EQ==
X-Received: by 2002:a05:6000:200c:b0:43d:77f4:7145 with SMTP id ffacd0b85a97d-43fe3dd407dmr34461259f8f.19.1776862372594;
        Wed, 22 Apr 2026 05:52:52 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4c221cdsm46907702f8f.0.2026.04.22.05.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 05:52:51 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 330505FC04;
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
Subject: [PATCH v3 03/32] target/arm: migrate FP/SIMD trap syndromes to registerfields
Date: Wed, 22 Apr 2026 13:52:20 +0100
Message-ID: <20260422125250.1303100-4-alex.bennee@linaro.org>
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

The syn_simd_access trap was never used so remove it. We should only
see the COPROC encoding on v7 architectures.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - use !is16_bit directly
---
 target/arm/syndrome.h | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 29462aa103c..72051443d59 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -337,21 +337,26 @@ static inline uint32_t syn_cp15_rrt_trap(int cv, int cond, int opc1, int crm,
     return res;
 }
 
+/*
+ * ISS encoding for an exception from an access to a register of
+ * instruction resulting from the FPEN or TFP traps.
+ */
+FIELD(FP_ISS, COPROC, 0, 4) /* ARMv7 only */
+FIELD(FP_ISS, COND, 20, 4)
+FIELD(FP_ISS, CV, 24, 1)
+
 static inline uint32_t syn_fp_access_trap(int cv, int cond, bool is_16bit,
                                           int coproc)
 {
     /* AArch32 FP trap or any AArch64 FP/SIMD trap: TA == 0 */
-    return (EC_ADVSIMDFPACCESSTRAP << ARM_EL_EC_SHIFT)
-        | (is_16bit ? 0 : ARM_EL_IL)
-        | (cv << 24) | (cond << 20) | coproc;
-}
+    uint32_t res = syn_set_ec(0, EC_ADVSIMDFPACCESSTRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, !is_16bit);
 
-static inline uint32_t syn_simd_access_trap(int cv, int cond, bool is_16bit)
-{
-    /* AArch32 SIMD trap: TA == 1 coproc == 0 */
-    return (EC_ADVSIMDFPACCESSTRAP << ARM_EL_EC_SHIFT)
-        | (is_16bit ? 0 : ARM_EL_IL)
-        | (cv << 24) | (cond << 20) | (1 << 5);
+    res = FIELD_DP32(res, FP_ISS, CV, cv);
+    res = FIELD_DP32(res, FP_ISS, COND, cond);
+    res = FIELD_DP32(res, FP_ISS, COPROC, coproc);
+
+    return res;
 }
 
 static inline uint32_t syn_sve_access_trap(void)
-- 
2.47.3

