Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3303CB2D8
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 10:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776852650; cv=none; b=tTE6dmN5xxX5nVfcA4Rohp5seL46iLSz8zualJngaN9mhRTv5o6EO9ZpyX6yqqLkVhmQyhbJLFF4/0VGLm7YRXzkV8EOmzNnuyNdZupiKqzAY/Yeq+ZUnY4UoM229ZqJq4BSR/VNs8+ValjkE+RYxg9iGtHrIsxjbnPT0puk9Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776852650; c=relaxed/simple;
	bh=h1dB7b759Z4K0BzkaR1zuapXhLfrGYjCvroE0dqAKfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QFQ09DUKkZqdBzLukSTJvgkrpk0UEu0ZvxmdBvPx2X3uR+KGCS2XSUBLOIHQUWVsxrUEXhbYMN81NZiRMscKU74wwAdY1N/aG2/eITuLnw8gaaStzGD5Uu+t79Ivki0Ea2dFveXWJpr8TMRSy7nofOofnKStBOc4xe0Vbfp2hvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LyDtQGeK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LyDtQGeK"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso41221435e9.0
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 03:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776852648; x=1777457448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRTiu65oEEP/NVXKQGmyzqv/GBntii32+7VLEeXU9Tc=;
        b=LyDtQGeKmVKG6KVFAJuf5NoQEKTosnWrD/YxJWA/sxPLgCik1iBH+Lm8A1ajm48puo
         cY2SpKso+ZUc7P22QYY7FR+an7K6vbhU7iXk+PO5rwCHWA42QVI4kmnSnhc31d20m0Ag
         SE1xhUtRnjmBS2TfXchluzQC32r5EoPjndyQbw7u+dBxz3AG1Nw8F6zVLjdb/R2u3vsT
         lDC9mybAHoobx4UISqOV2TwhX/rHj+5dPzRn2PqHZvAYpbs97cg3XZSc/+wQjj9Ph/+y
         lwdBUjTqUueaWwzE5IvJvuS76slEWdoycpLGp9HOWvZSKSIpx/h13nIpkr5qPqceaixQ
         63GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776852648; x=1777457448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XRTiu65oEEP/NVXKQGmyzqv/GBntii32+7VLEeXU9Tc=;
        b=jZaFWIq8lraBKM6hpMse/fCzYjRnZyXWfgFeOHrw5/XXqec5GNR+GIGL4/TF28UNn+
         Ag7kXZ1oNlrnyat/NqBZY89zMUCsHc2ifM20bJvAkhldR3NLKsx3nZ6TwK30zFbptZwN
         IpOHTbbzXrIdvKoq4m+oyawlxtRPBrQepaRTg6euDZvlaBj3xAipy76sk0QMKYcBQKKu
         fyZWI9cNNLZxM4tK3rOyyNNiYZAuVJfqxflRo256e0ZfJp6ZbO5zzRbkvJur4rQZ0M1e
         AosRdw900Zn/h8nuuu8xVHhOmO+3KQJ5trkqiL59OnF1fikpn6s8/7eLk+xIDwSw9PHw
         p3AA==
X-Forwarded-Encrypted: i=1; AFNElJ/YVUKh5l6EJOZzLgNy2CKNRddpPcA49gzoPToRc0+i5XyTmjQgvwQfj8Mc+8GQ4VuC2cU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1H7jdor3Fu5ZQyJocVtGS0MGm10q67IWxzXVlEp2Uelc7j4Ls
	86q2ZxiTKM1e7CPKu7+QGu3v9elS7nNV7+hWaeWwbiDiI6D1CF1q9eUE3kzqo87i7Do=
X-Gm-Gg: AeBDietwDaqEcSaSrbLklASh+zSw9XSuzhH63iUaGKeOWf+Mu5SZ4lXtykp/XRRgbco
	AcU+rFbRu0iMHKp4v2ae1fn7+fw9WaXTGMis2asf4o41fJEYAnFw/cxzy/VziiE6WuOlug08FR9
	33wT+gGNd6xW3XSeNj8linyH/1SY0Lwv1uuCGDcNomMDWjMF0tFlai5MJV8t1oFhw0k9RzZOcge
	OxoBORnqdjukBrTfc7kJsDnEy8TAwyYl5vZOJplvVJtATA2nYpm9brgks9U1AMXu5d4wwYsd7K1
	clQ2ILT/b7rTJZ48JA96IVfC2C11h1cbuUcIWgDxCJUB3mqQHEvIUiQBfEjn1Zq4w7UdN84r7Fo
	+33Me2pITcVoOdefn2vfaIOitJzczovWvS30i941IrCWAwV9nQwgFzS0hqcFeb8G25s9cPxTCdK
	+AzHBKjU3cue+Y3eRAOd7+aLilLgo6lXL8vw==
X-Received: by 2002:a05:600c:19d3:b0:489:1ae1:4eb9 with SMTP id 5b1f17b1804b1-4891ae14f23mr171514615e9.28.1776852648038;
        Wed, 22 Apr 2026 03:10:48 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e46898sm46509989f8f.27.2026.04.22.03.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 03:10:44 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id BC52060338;
	Wed, 22 Apr 2026 11:10:43 +0100 (BST)
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
Subject: [PATCH v2 04/31] target/arm: migrate eret trap syndromes to registerfields
Date: Wed, 22 Apr 2026 11:10:15 +0100
Message-ID: <20260422101043.1234229-5-alex.bennee@linaro.org>
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

