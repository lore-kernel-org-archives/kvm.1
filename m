Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D2D3DBD66
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 12:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862379; cv=none; b=KDEEj4/fjBtIby1a/ejrnkxLfiH6ZysJbt/GhEgjhhnoVAg+dGTWgA4N8n4lWWBWUKYz8/kgWALYAaQ//vN51TU2O7/LZp6m/QJTpB1H6LkCRraYaO8KTe2D2bPmzZYMjcLAe73D7sUNl1x5g1tduT8Z2nX9P2+I5VmDct2LaSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862379; c=relaxed/simple;
	bh=cZIp9nxerNU8oAlNtGhJ7PtRCs2wETNV24N1qiRPFIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NQp9krj49R2KdzfRnQydBRuT+F99xKmmhSUy4UgXjibA+oH/5EBIRvHzK3TeEeNUyq8/5am0LISnT+85IebcqaAEnd8yTe6JvbHNuZk4zc4N7UsxMIPPoqJSCWwW/g6or+NiOJ9WQqDvNjWyAMEEa8RPXI+rwMXAVNOX22DEoeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZcpPs0fg; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZcpPs0fg"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so67789815e9.2
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 05:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776862377; x=1777467177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8D+Vwc6j20F82XkTXJvqmESw0OfURlyV19jvdfWNbI=;
        b=ZcpPs0fgp5vHrMJ9KTit902/gmTAP6dv1h1pa/jjcllD8EYhuj5S0U1xrqCgcIEKQ3
         SH055g6L0tQFs8564ppGYXXYEu5o4ZnBmdJvVrs2sWY+aHIQVoKRl0D4ST5Apiu3puK9
         gJp3yYRBHGBekZQs1tHABghAqb1s3AZpb+lw+ASAzQYLHkMy6qHd8wJrd+Q3HdmK+GOk
         1PxvfkTBbU1g77Ojn1wui74PVkamm2cchOhsSzIBhcuri+gUmUEHlPb9/25d0RLoiwEf
         pzb73UFzKBSaXhEUlLvfNKJNvvx67YTSjCrlD9MnGArEZKicSWmCD1nO444jN57aApHq
         tbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776862377; x=1777467177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e8D+Vwc6j20F82XkTXJvqmESw0OfURlyV19jvdfWNbI=;
        b=Fx/yCYfcGU6LupFJOHc6V3cusE95WenhKbuwNHL2pz8MXz53Kz44XqAkJmBqfDhXF+
         4tzGlptytC80+hXOFvXlh2xPK7L1dfxpRfTA8llrKA8XbxY25eAaR1kX1sia+eHxJVEM
         3dDP0xKAwYa1nAWlNr37+dqYcnc1WmFYMq325w2jM9ngISCTypuNh2tz7G4N+cjHUK0T
         1PUx9OntiB0EvHV9c2DJtRyIBVWYS2quIs+0W7r1o3xcIz4HufBhSM4ZLiM2WDOdmvFw
         1SpuMiL3C9+s7mvD5QUkxv5e6M9X+0DvKmYZG7k0qOxgJH0nuWZgNdZFF+Iu2bH8X4zH
         H9TQ==
X-Forwarded-Encrypted: i=1; AFNElJ+os+CowY4KCEJlTyqnHQDDRUsgZ1qG7cCsccf3oK2tSQXnchvaTV74mIesy/+yiSva8gU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiUNYQPlY7jaFJZDAbrZceZ0ZaMOzE77zeoCvNRFJOz7G96NWX
	kNrirRIlg49cOLpK5k99gPgOtz3iZGTlAVYAV68lRcAS5ozCh6wSL/ZeqlU3/NmFfzw=
X-Gm-Gg: AeBDiesc0tJwauVu0e+C86f52htwmpEo1UHE7thfK9zBYTqUfs4V3H/1sdnHbqVEaqo
	w7uRvjgxL4sZsaLEqtSEyWYLP/7nHuBfPe4kX9XUkZXkYRwzK2ZfXYWbU8MSRyFCd2ZsKcINRH1
	VEXMq4E8bI1Ir+2WpZsLJ9OCFysXFz1NELkTu2u2U/rVjrReRNjZ7JoPnqeV7u/0EJvBgiYWQi0
	RwSR+w6Oe8Oz4AZHKH7fWMRNKahql9LQdg8hJP3eWlNC9HQpaE0ExdTxiJa+Y3p4mbic6NiKfyI
	6ZQdype7eWGUu85Lt8b6LDq3BsTwf6DLWXhfcPC8+pcQHkh7ErWaFJD8xQFlwmZD1Kn2tLscoHb
	Ud5R4r3XkNUrDrOgQEoE/CHVq4kUfOjUBYrVrI1S1BPPEhDN6HDhqOtXFA90S8nFeIuYYszz7BI
	klN9E0hcvg3T1NANjofBsCTQFcYXx68GThSw==
X-Received: by 2002:a05:600c:899:b0:489:1a63:509c with SMTP id 5b1f17b1804b1-4891a635125mr125689055e9.0.1776862376580;
        Wed, 22 Apr 2026 05:52:56 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc17f642sm409465435e9.5.2026.04.22.05.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 05:52:55 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 91B0160E72;
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
Subject: [PATCH v3 08/32] target/arm: migrate BXJ trap syndromes to registerfields
Date: Wed, 22 Apr 2026 13:52:25 +0100
Message-ID: <20260422125250.1303100-9-alex.bennee@linaro.org>
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

This is an Armv7 specific syndrome for chips with Jazelle
functionality.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/syndrome.h | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 52a6745cb23..6fcf0ac7572 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -440,10 +440,26 @@ static inline uint32_t syn_btitrap(int btype)
     return res;
 }
 
+/*
+ * ISS encoding for trapped BXJ execution
+ *
+ * This is an Armv7 encoding.
+ */
+FIELD(BXJ_ISS, RM, 0, 4)
+/* bits 4:19 are Reserved, UNK/SBZP */
+FIELD(BXJ_ISS, COND, 20, 4)
+FIELD(BXJ_ISS, CV, 24, 1)
+
 static inline uint32_t syn_bxjtrap(int cv, int cond, int rm)
 {
-    return (EC_BXJTRAP << ARM_EL_EC_SHIFT) | ARM_EL_IL |
-        (cv << 24) | (cond << 20) | rm;
+    uint32_t res = syn_set_ec(0, EC_BXJTRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, BXJ_ISS, CV, cv);
+    res = FIELD_DP32(res, BXJ_ISS, COND, cond);
+    res = FIELD_DP32(res, BXJ_ISS, RM, rm);
+
+    return res;
 }
 
 static inline uint32_t syn_gpc(int s2ptw, int ind, int gpcsc, int vncr,
-- 
2.47.3

