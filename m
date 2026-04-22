Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5719C3D8103
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 12:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862378; cv=none; b=DNIV+SznKvEavmCvMdbmijB8/Lc2CwfkAK1D+n7ywNSxCx7mvT40+2ziewIQ1YYf2ZKiNDKug9ttmAXhvwlq3DZpJiXEayAOdGHArLC4QYAUSICLNi/K4gTmvKxEswKFAF+kSAfjbA5GP4/jkJPO6612CFXrHve2dnkrX1J4Aqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862378; c=relaxed/simple;
	bh=h1dB7b759Z4K0BzkaR1zuapXhLfrGYjCvroE0dqAKfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S2RIcOATngr8HhrVo4gLo8JBSg/kxh5m2pWIS5iXlOoXr0zgpNKaZKyNtvr7GjecL1FPfTW9hcn6gnFC3W9euQ4cDTFEHOiK/UPHyW7p7paIlZ99ixtPc+3P++ezescbHAy7VhJptgywRHQTDyhc8I8aDqjOXttrE331NiOg//g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vupEVV7a; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vupEVV7a"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43cfbd17589so4297072f8f.0
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 05:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776862376; x=1777467176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRTiu65oEEP/NVXKQGmyzqv/GBntii32+7VLEeXU9Tc=;
        b=vupEVV7aeEP9cvoPUq8AreMdZcoxIXGswI4vidUTp8Zl8VEUg+6cwAHFTMhkzJWu5A
         xaPxOAySr7BlxfCHRgTYm+YT13NPfZWcnwqm3bRVTK9ruxN+8OYXZ6+LtngQ+JDoAZv1
         cTyruAirofnMEgRuaE8gBL1MibnXiz8v83qwwJK2vAd31+QjJWrHuB5Q/7Tp7l4/vRUy
         SyZhCG/JA3Xa+ccr+Zk+pEwgavm1aWaYMxzxk9Z0MHeuSBJdEUFL+mFMiYFCJ+lzjzml
         CN6fK2JTzQGcgdga1rumIBC3OKi8TpQelJrL6k0EJ0a0OvCA+yLjetxBcCvYWqPBhOFj
         MPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776862376; x=1777467176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XRTiu65oEEP/NVXKQGmyzqv/GBntii32+7VLEeXU9Tc=;
        b=PV27hJapeYw/8JeMz60IUyxLy9Kkngt3u17N4ZeEFEzQew3Jor69nUxjGN+OEzBBsj
         hxhYbSLey/GCB3hLmdRYw2rqi8Dm694lnhnwN96GABTkOzBzI6kU6R0OQRIQZDNyomkP
         +/cXhDaiIIG+tFGn9wt7YS98OwbEPbxyY6mxkQHtAHozvzVznWzFWBy4dAgEFzAXbZpX
         JLV9Am5C+hfTAjEq9IDV13RVrQi/s0Q7f6w4JA2amhCZsTHJib0RzYAAdCFnzXbOMpBi
         v3r7jNAsmZatjOuiE0/ctnCZEkyZJfQDDVeK5875aKRA5dYvcZFlb4WpfqTlLBilcSFK
         nEGw==
X-Forwarded-Encrypted: i=1; AFNElJ+658gVgcYRiXIKsKI2job3ujHlzco8vQF5EaAowHXViqdFjGP3iLgtveI8jzooulAyGsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgpu0tLpwJ+g7fs76MF5IjPrGAdGaIswO2tnNZC52xoA0vCZJL
	9YGYZcauYQKiIJfPQUx6rSG4AmObB++qasxnrvUkTBGDenLlITbcjXkEhwU9Ia3uF2Q=
X-Gm-Gg: AeBDietAD3pO8YcTSQeOdwoR6CguK4uVXbf0sUVIs0ikVHUbzHz3zwhzWXi0rQZ1Whs
	HaofZeGh8tOQzL6bAIzCQEEvl1ttrIgcuwmRZKHIQvaZrZBqwAx0gox/srjqKDa0qcyWyi4J7Fk
	IBgaDtnV0WzX4+1J/BAYcw/Nz46qyyf+0HdH9lAjREpXpd+tjQsWpBWZSZnFfZFLpIb3DL5OEnf
	ZDrKEou8+gyNDLFD/jhb5HuS18yua/kZk07Df8v+hidn3penjG60mJWD/5eoyzzLqu73Ze1V5/C
	2Ef0gaPnXaquRGfWYwRT6rqyEN5I6VA4TaxxX1jnStzLPkceSi5uOWW6vP5UGYhDePK8KgwEYaz
	1s/bAZFgaa47IJY+mEeUSlEo3Qj4jmMmi3d/dRyPKuSr2smnlQ/I/VqVxhCd6eXne+bcn0ksOmt
	U87nLh0CMp+YRsPhvTPrBGTrufSdYGx+xvUQ==
X-Received: by 2002:a05:6000:2207:b0:43d:6a02:b7ad with SMTP id ffacd0b85a97d-43fe3da668bmr32520165f8f.4.1776862375765;
        Wed, 22 Apr 2026 05:52:55 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1365sm48295853f8f.7.2026.04.22.05.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 05:52:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 46D9A60338;
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
Subject: [PATCH v3 04/32] target/arm: migrate eret trap syndromes to registerfields
Date: Wed, 22 Apr 2026 13:52:21 +0100
Message-ID: <20260422125250.1303100-5-alex.bennee@linaro.org>
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

For simplicity keep the OP as a two bit field rather than the two
interlinked fields in the docs (ERET/ERETA).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/syndrome.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 72051443d59..63c8e66ea91 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -367,12 +367,21 @@ static inline uint32_t syn_sve_access_trap(void)
 }
 
 /*
+ * ISS encoding for an exception from an ERET, ERETAA or ERETAB
+ * instructions.
+ *
  * eret_op is bits [1:0] of the ERET instruction, so:
  * 0 for ERET, 2 for ERETAA, 3 for ERETAB.
  */
+FIELD(ERET_ISS, OP, 0, 2)
+
 static inline uint32_t syn_erettrap(int eret_op)
 {
-    return (EC_ERETTRAP << ARM_EL_EC_SHIFT) | ARM_EL_IL | eret_op;
+    uint32_t res = syn_set_ec(0, EC_ERETTRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+    res = FIELD_DP32(res, ERET_ISS, OP, eret_op);
+
+    return res;
 }
 
 static inline uint32_t syn_smetrap(SMEExceptionType etype, bool is_16bit)
-- 
2.47.3

