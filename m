Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155F635838E
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 13:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862953; cv=none; b=a6LzoCbmQxSHrP1I+Gy+vcSwOaIQVcDwfU2uAufVpclbW1bh5s3019n3fgEIVobWfJijagPvvGUxYsxarTXdnO1WH/MiSV+GcyK8xLpbNYt+9tgM72aB+gssJ9FXcbb8uwIP5Ct8NF7pJwb2B/VEVXj1tOgwY+Z9i9b6+ZqFS5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862953; c=relaxed/simple;
	bh=piPF6Nc23auS+g4lYiJQkYf5/GW0MfL9OBLDKeqR99w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZlQ77hOtDjP2cy9ecIDFWZXbgGG6ZTSa4bPjLjmD+G1RuRDaaCZvsuLBMT7u++QMuGaQn5dqlsnbfxqxqMv2PzuFEKJShHp5/azSR0CKAuMStn5SFSgi/5MLtLehsf/galFITb7qpv6pAqru6x4IzssFxZ4jmXLpBhIahMOfOqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gRzZssP+; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gRzZssP+"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so71682065e9.2
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 06:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776862950; x=1777467750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9WNiVc32x9uwc9Kvl3F3IabOVkUVJfyhaJuWqhRbgs=;
        b=gRzZssP+cmA8JFlBu332WEkRn99vux3rT75ZGkujmr4qNrRdJiOEKz904xE012wMGW
         q7AD5hPZ5Xw90rG7nHRu650o+aY84vDJmU+cJq/dfquplI8Q18cpS/sWUiznrgisM5OD
         hBoNUSdf3ubx/acAsJM3FlAKOfVMmWmCBNIFlQOqVMxELA7Oz8S8z9vvApzPnU/NX3pH
         hopyyk0mmQc+PeOB8uVIeLNvsdcU4TjrJEK7VZSxRGpu4AH4M2vLEUfO3gQyoWRZgyHU
         sqdL1bEo9sgQQvn+4YEZ/a8pqeJYiqpilhGEScs2u7kz53VQeM0uXpkVpC/FpZvk+EvQ
         vQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776862950; x=1777467750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V9WNiVc32x9uwc9Kvl3F3IabOVkUVJfyhaJuWqhRbgs=;
        b=b9hLJXGxjnXRCA9Nm63OLywzWMqzsF06kv+6Aswsn8NWqCrZxptyU0YdNOkbmpAUJl
         +JPqVIJokwN9oAHYDtLNfMwiQs1Yq8YlvojuT2iU2mwZqsjpljgil4lnl/dWCJCFQhrH
         1/eMZcJakjzr2GXMLvhDTo8dYh1GIQEQUMoXewt3sPQSJhQpdakBw3kU+A6uv+JmhrEz
         6k8TQ5u1g86tLnLzgOfm3xOgkhwJzysq4DeOpL1S4gafh7QOfrm5uugBBW1SIY+/suKS
         +c/sUCSGnSUc8f8pZKBns0Esat4qCLREl5HgBo9Flr8/IpD8Iu369kiyZynbHquMfSNJ
         JE1Q==
X-Forwarded-Encrypted: i=1; AFNElJ/Nb0fx2pFT0TInXt5DYf35iFrjmpSP780zVhlJzY/AsuVFYj6sStjC3vT6PZW8X0C2CaM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1NWyzxPgIeXEA4Nt1nkMQ8VxqtAPQOh8tyllQ4XBIb+EHvnYX
	q5gbuoDPrzfqKFCkhPpOf23XH/2gHOitDn74JTyEDP3hxy8l+XWMICtBYjrMyE9fwp4=
X-Gm-Gg: AeBDiet0C10arcT2/yP4aHqbjdBx+hacrjBrEwKDbrkfJJztxCyWY528njPyJj8++iw
	dlYCGAatQX3ur6mV8eGgn1L/n57DIaI+Ggofcuy6R6AUp8AH6jM2NCuVV9IKzczseSx8Ni0z9h2
	BW5BKoO3v5ttkp4WREphs8KG4UC8zQ8cVdsnKFgKi/+a53YFu5GbX0ILiXmoWJ27rWsrejChBFT
	oVl/s75cidiSS4koStKTcQ2Noo2WyLIUV6zwcDfdqVfT/EXt8/fI6AdL7+IiRQKpdbzU93iK6gb
	BzbnxiW21aCdgmmKWpH2AX7tDRu/zqU57XuSdpquZ+v9z5h2HXJF6MGoHJlRlt3w97XWDZJ6f+n
	qQ5BoF+QbEF4gw9LgX/Qf8ZT/oKrE+YtFmU0tyQBpQEbBl/XKGtN+ee6jY0jnu1Jxs/R19+eFq0
	5tR6W4qRvfM8+hfd0M2DZjtzTVJe7eER19MziF5XGaQsh8
X-Received: by 2002:a05:600c:8483:b0:488:7ff6:1f75 with SMTP id 5b1f17b1804b1-488fb782d91mr334374605e9.21.1776862950380;
        Wed, 22 Apr 2026 06:02:30 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb74c7a2sm140308125e9.1.2026.04.22.06.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 06:02:25 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 0269E6153F;
	Wed, 22 Apr 2026 13:52:53 +0100 (BST)
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
Subject: [PATCH v3 25/32] target/arm: redefine event stream fields
Date: Wed, 22 Apr 2026 13:52:42 +0100
Message-ID: <20260422125250.1303100-26-alex.bennee@linaro.org>
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

The event stream control bits are the same for both CNTHCTL and
CNTKCTL so rather than duplicating the definitions rename them to be
useful in both cases.

We will need these in a later commit when we start implementing event
streams.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/internals.h | 11 +++++++----
 target/arm/helper.c    |  8 ++++----
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 85980f0e69a..dc593f1fec8 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -263,14 +263,17 @@ FIELD(VSTCR, SA, 30, 1)
  * have different bit definitions, and EL1PCTEN might be
  * bit 0 or bit 10. We use _E2H1 and _E2H0 suffixes to
  * disambiguate if necessary.
+ *
+ * The event stream bits (EVN*) are in the same position for
+ * CNTKCTL_EL1/CTNKCTL.
  */
 FIELD(CNTHCTL, EL0PCTEN_E2H1, 0, 1)
 FIELD(CNTHCTL, EL0VCTEN_E2H1, 1, 1)
 FIELD(CNTHCTL, EL1PCTEN_E2H0, 0, 1)
 FIELD(CNTHCTL, EL1PCEN_E2H0, 1, 1)
-FIELD(CNTHCTL, EVNTEN, 2, 1)
-FIELD(CNTHCTL, EVNTDIR, 3, 1)
-FIELD(CNTHCTL, EVNTI, 4, 4)
+FIELD(CNTxCTL, EVNTEN, 2, 1)
+FIELD(CNTxCTL, EVNTDIR, 3, 1)
+FIELD(CNTxCTL, EVNTI, 4, 4)
 FIELD(CNTHCTL, EL0VTEN, 8, 1)
 FIELD(CNTHCTL, EL0PTEN, 9, 1)
 FIELD(CNTHCTL, EL1PCTEN_E2H1, 10, 1)
@@ -280,7 +283,7 @@ FIELD(CNTHCTL, EL1TVT, 13, 1)
 FIELD(CNTHCTL, EL1TVCT, 14, 1)
 FIELD(CNTHCTL, EL1NVPCT, 15, 1)
 FIELD(CNTHCTL, EL1NVVCT, 16, 1)
-FIELD(CNTHCTL, EVNTIS, 17, 1)
+FIELD(CNTxCTL, EVNTIS, 17, 1)
 FIELD(CNTHCTL, CNTVMASK, 18, 1)
 FIELD(CNTHCTL, CNTPMASK, 19, 1)
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 40dd070d2c1..81a07ca42d0 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1746,9 +1746,9 @@ static void gt_cnthctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
     uint32_t valid_mask =
         R_CNTHCTL_EL0PCTEN_E2H1_MASK |
         R_CNTHCTL_EL0VCTEN_E2H1_MASK |
-        R_CNTHCTL_EVNTEN_MASK |
-        R_CNTHCTL_EVNTDIR_MASK |
-        R_CNTHCTL_EVNTI_MASK |
+        R_CNTxCTL_EVNTEN_MASK |
+        R_CNTxCTL_EVNTDIR_MASK |
+        R_CNTxCTL_EVNTI_MASK |
         R_CNTHCTL_EL0VTEN_MASK |
         R_CNTHCTL_EL0PTEN_MASK |
         R_CNTHCTL_EL1PCTEN_E2H1_MASK |
@@ -1763,7 +1763,7 @@ static void gt_cnthctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
             R_CNTHCTL_EL1TVCT_MASK |
             R_CNTHCTL_EL1NVPCT_MASK |
             R_CNTHCTL_EL1NVVCT_MASK |
-            R_CNTHCTL_EVNTIS_MASK;
+            R_CNTxCTL_EVNTIS_MASK;
     }
     if (cpu_isar_feature(aa64_ecv, cpu)) {
         valid_mask |= R_CNTHCTL_ECV_MASK;
-- 
2.47.3

