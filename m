Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3033EBF03
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 12:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862387; cv=none; b=GLYNcNOsB6ODlVMtLczdzdVsX09XDODiYPEKB/UZ0tlmuN4AIoQZW2XtBK8K5Pi+DiALft+TURXYx1xzlEicDxj6DgMOKmHOXP4PhVXlyTYg2COLXS0atqnkuhgYIA1V2lfDX7lIZFS8KVOgiKwEI7q7IDNloR47RTGYXwMX7iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862387; c=relaxed/simple;
	bh=r6G7A3H4PQ9qziC8KwDFiCMnFLOFgzctZsk6jMHAt+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mGenxqV6f06XDtVyA4JiUFE3ll3Ylz/69Qs9Es2+/Erte1+TAMOTlqvZFNFR9p5GMuRkPTkN8+KTIqc4t+R9hyjzjZXc0vxyxEZ2M+A77ZE6mrzKKatdpz8fZH0VN4cnETp6V8YvhxVNepjylnAhdZs81Gr3yOyvIh1PkzI/93E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uNyxnQV7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uNyxnQV7"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488ad135063so47385015e9.0
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 05:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776862384; x=1777467184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fpr3Ng7R6+bvHtx79oLF5EYo5OylKP6gzyU2DP/N60=;
        b=uNyxnQV7nFOy54KHlvya29kqTeFbDZxDMgvdjbIKP3zOwHSGMZc3NNpJ1UIe7CafqJ
         j9AFXNJ/Ml2GviuXqXExjIjfJo6EMCxlmSaY9ZL7IfDbDGqTc48VdnOfoDMkECxYNeBM
         YUc/p4osHDyhRwcLFf8T/YaeLXbsSpx7kjfUlZsH47Exs1YzekbolRvWHIf7cE4bmcpq
         bS67CG9HAg29lSo2g9ALgSbEPLxAOveWeDshhZjLZqdt8F9h32n2RDeTne6Znm2cHukP
         Drnt5eFL8ZErXAQOmc44Akh72o7bPn2YPVQ2ARUUz9Tm79yxJvtJcHJKcRCylRg3l08U
         jDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776862384; x=1777467184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9fpr3Ng7R6+bvHtx79oLF5EYo5OylKP6gzyU2DP/N60=;
        b=Y9YGKZR+iJtchUqlkM/bLi1KLRORYZdHLcfSepj2fSlXYqgnBsTbWmdDQ9CNL7z1cA
         qruFqKb3IJlh+2g25Rk576H+wQeJhbYu74a3Fq9LGBoMO/0aQVibHSH8VVqN8r2UOfTF
         06W7bbAmtJ1pcVT9yy++q6Vp9tm0iG4n7P3fBmO9TTZBGjn1sYQwIl8MEAkeSsaV9h61
         TsxE0eUtGgula8SzX42+8dFLJRO0W8UrM03mvY/Ugz+QRS3O6heYyqGxLeXqaz+1Yym1
         vUAJ4NHYF8qB4fUgXjvLfwVqUvB8ccVqnGiDfODCEBvzPKQFQ1q0V7IRpYBgAXeXsDw5
         ScRA==
X-Forwarded-Encrypted: i=1; AFNElJ9fhvZkAQrqhXd63l+yDefUeWMfXXJpgRKZlCG9XH6+6/Bz4fCmfo5/ZikkhowoHSG3qNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFbd0FcNUKk+FMEksdZmpdUTj1CKi3j37O2Tyob1Zp9YIwz/wE
	j+8IJWwLfYZRLmKxE3zrlKQsV0EhGRuEk15O07lRsfNqNc7N9sC4Ugfoov9B428NQrQ=
X-Gm-Gg: AeBDieudSEwM7lnoXzwTIwL1J89rrbqJcwnYuoG2vBUW8Q5Q6dbwkXpjBRT3k7v2Kwy
	ygCr8unWKNWd4EPaAwvF4FvZNNqiAS3NS960mZ4d4MEkMK4nIG8nhU3MnMbUcsfcBX8dF+TbLnO
	0fl9XyyaBaBsCC+RtSnFC0/2A+KP3CxFXEG8cZ0nkJIaK8yToQR8C8rJSws2XPQEsNltQ31K5ev
	qxcuhWZcCZECTyWo3przRKXLm/94Xe0iUpld4hsV7ZofqUy2KZdAw9xPjm4siws2WML7pwBWvED
	kVLpgInCy+YZTAfrMk47ILDu4bIIIsFgKBzRntBYUKPl+eL/bj57pcRO+LxHQYjlGIvt0zdUu2d
	wBm0HZG1X4HJL/Vm7cp61aWPw2w+HQPWIMR9TvgbF0k/iSn157V8zO5HeRxrSLCGPBCfdRpO8j1
	we0uIC/SbGKDxYXYfZlwx+H9EGgYnOgWR8tjgyuqaAfH1f
X-Received: by 2002:a05:600c:8b55:b0:48a:57e1:d8cc with SMTP id 5b1f17b1804b1-48a57e1d8d4mr85199615e9.9.1776862384161;
        Wed, 22 Apr 2026 05:53:04 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a5499b0edsm137343125e9.14.2026.04.22.05.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 05:53:02 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 3D0B3610BC;
	Wed, 22 Apr 2026 13:52:52 +0100 (BST)
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
Subject: [PATCH v3 16/32] target/arm: use syndrome helpers in arm_cpu_do_interrupt_aarch32_hyp
Date: Wed, 22 Apr 2026 13:52:33 +0100
Message-ID: <20260422125250.1303100-17-alex.bennee@linaro.org>
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

One more step towards dropping the old #defines.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - drop excess brackets
---
 target/arm/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7389f2988c4..40dd070d2c1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8898,9 +8898,9 @@ static void arm_cpu_do_interrupt_aarch32_hyp(CPUState *cs)
              */
             if (cs->exception_index == EXCP_PREFETCH_ABORT ||
                 (cs->exception_index == EXCP_DATA_ABORT &&
-                 !(env->exception.syndrome & ARM_EL_ISV)) ||
+                 !FIELD_EX32(env->exception.syndrome, SYNDROME, IL)) ||
                 syn_get_ec(env->exception.syndrome) == EC_UNCATEGORIZED) {
-                env->exception.syndrome &= ~ARM_EL_IL;
+                env->exception.syndrome = FIELD_DP32(env->exception.syndrome, SYNDROME, IL, 0);
             }
         }
         env->cp15.esr_el[2] = env->exception.syndrome;
-- 
2.47.3

