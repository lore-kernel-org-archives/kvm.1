Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6A63CEB81
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776852659; cv=none; b=Hjcq44M5dECGAy3jXtZo0ovecMJKEMktnU7uIcjtHoPGeapom0M98ykEnGJt1402LzoQqEoWz+5xjWc3/Ybbe3BLyNb0+cnya++4c3iBJ3Ln+WkKhHSFtRl/fe99m8UU0mOziWG/GC1GUKSdCMTV4ic6it/KOViGBsMILdxAnHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776852659; c=relaxed/simple;
	bh=MVRJ11iQlKTt9wTFYKhVcZXh3f8OHh+FpmXp5qiYkuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A00uGOi+yh7M0nnxmob188Cb7Ig0yBuwLur4GYUv0DQk18C01X6Eko037STsZvdpb69kbLzDqNlIiKt3ytycu8v9sbJhf6eGQX1PaUxdZYH56NnjBitFJPvT75gap8I/CdTglBgeVku6Vp+vRhxan635ThKc2JVzybUI2bUfQ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n5F6FG26; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n5F6FG26"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso69718845e9.3
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 03:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776852656; x=1777457456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLzSB9spY+gJhXJ81HA2xrXzxJ07lupyVRDFchBeQ6c=;
        b=n5F6FG26gxS4+vv6Sg1MPIQPGZw/qoGzBjWZDESTWOeNk1ABFxM1+DpVpzryuS3r8T
         fm48N4QsWNu+elfbFu6WwI99PgNt9ghadRQpkvwWoWZocKW+GES6rUlfQaLzLoBEUeft
         e7zlAdQxkIxC/JdpK78UDoSfC7A+KS9afyDk0AQHxQOmWTQ5uk2+aiOgCw0+/TS45wcP
         6YNQCRJI7EYbedLfb1LEqsLn5nDyc750i+JjcON7+oBd8BoRgEGGVdBtFKdWCc9gK6Jp
         d1mJKkJUIp0fGKWL1nD8JnwBMiirqndgXHvgqlZRT6Cb6xNJPkfeVw1DMix9CeroMpZY
         HIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776852656; x=1777457456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SLzSB9spY+gJhXJ81HA2xrXzxJ07lupyVRDFchBeQ6c=;
        b=GNU5aVfT3co0M+JyWvjgu2/Ze1ajEvp2CxFugY5jVpA/xuUshYAQX9woQEBNJtTDHa
         kPpSz2bYrSvenh4iGYNbtSZ8Itbkluw8JbqiUL/EjnC/H+7vB0u0BbPUrQ4uEmaz0AXj
         +/ZVIi5fgxWdbjye/29Z/ohoCrjKIdvxgexyFAOhPPPPf7ve7Na7UytNSpDQeKleeZoc
         LL+q6bbVggJvtcOuW4zOpC1I60byyQmtr+/H2q0tQyByRNL8YZ5J9z+CNF3HS5sP9vuW
         X4EfyG803lu4gaMFUsoCUgS10h/NW0aVoEBIc7ctEGTlNgD1fIQ4WUxO9wBavhQI2vNN
         2S2g==
X-Forwarded-Encrypted: i=1; AFNElJ/lac9nt86kGLY/EAxphPecu3/Z19T7SyR8oyvxQIPSqM5S+k/tPmIxDK/aDSVox80pWWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLm+SXv5UjMUI5SSnHtCEgIjk8aX2EpDvyganNlqQWLYiJFA2e
	SRUmeHPj7YdQJPLLQKTTYMGaaVGKEbFkWDPI8zR0kx4emgPStpsatcQ116vQdXqeSO8=
X-Gm-Gg: AeBDievSZx5ykb+VuscHwzV5pd+ADiqxdP6uOjYxPkIZuggFmswbRrLwiOpPp4WisJ9
	TfyQ10VcQ/oJkl8uQgCDGj2JO+7Rs6bOKvpZfu1aDSLM1IHJiJfQZ7OLdW2QhApgZs+9f4QGBqc
	xzXGe+WW0MPMdL4xaheNq6pzZUDxLUy7Ul9dqlQWkkQApWCyaSmDK7GK9xxJcfh/R68lyRcGCG1
	5LvjqDfJRtZTDqvloV85mgcBeKSXIx9u3WbvRpRCKngQNWGZ/Uocy48XAlae10OJ7oSCMcSrwGi
	6MIoIq0aQX5OYly+8oiwCqN1jh7h/5cvSo/FxtpOj4TTT/jBJmjtV8OZcEclYTGB+1R/miTzife
	IOAMsu2ykQAm8HKyafXDXibqwdoGkwSeVr7qRCj/HgU30ih9y9rV4rkqVxbFno4AmwVfWBMfEQu
	LuTkw6BV37Q9lb9Ak/LRQwGCuI2St0J332NA==
X-Received: by 2002:a05:600c:1993:b0:489:e696:836f with SMTP id 5b1f17b1804b1-489e69686a7mr153151745e9.10.1776852656556;
        Wed, 22 Apr 2026 03:10:56 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a5c24d82asm10781745e9.7.2026.04.22.03.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 03:10:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id C499F611A5;
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
Subject: [PATCH v2 17/31] target/arm: use syndrome helpers to set SAME_EL EC bit
Date: Wed, 22 Apr 2026 11:10:28 +0100
Message-ID: <20260422101043.1234229-18-alex.bennee@linaro.org>
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

This removes the last use of ARM_EL_EC_SHIFT.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - drop ARM_EL_EC_SHIFT at this point
---
 target/arm/syndrome.h  | 1 -
 target/arm/tcg/debug.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 53137394e28..d4dfab8cd15 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -107,7 +107,6 @@ typedef enum {
 } GCSInstructionType;
 
 #define ARM_EL_EC_LENGTH 6
-#define ARM_EL_EC_SHIFT 26
 #define ARM_EL_IL_SHIFT 25
 #define ARM_EL_ISV_SHIFT 24
 #define ARM_EL_IL (1 << ARM_EL_IL_SHIFT)
diff --git a/target/arm/tcg/debug.c b/target/arm/tcg/debug.c
index 5214e3c08a8..07a52643e71 100644
--- a/target/arm/tcg/debug.c
+++ b/target/arm/tcg/debug.c
@@ -56,7 +56,7 @@ raise_exception_debug(CPUARMState *env, uint32_t excp, uint32_t syndrome)
      * Similarly for watchpoint and breakpoint matches.
      */
     assert(debug_el >= cur_el);
-    syndrome |= (debug_el == cur_el) << ARM_EL_EC_SHIFT;
+    syndrome |= (debug_el == cur_el) << R_SYNDROME_EC_SHIFT;
     raise_exception(env, excp, syndrome, debug_el);
 }
 
-- 
2.47.3

