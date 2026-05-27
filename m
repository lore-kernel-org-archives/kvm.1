Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F203FDBF1
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 11:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882210; cv=none; b=OZ3xc4JA50fLYFOyI8TohV/U3Hf0P91T5+GHof8PEhW+6dLMMujpTAyyjNJCoRXvt6nFZDO5MufGBwTrcSxwQ47iDrkfnjlzn6bJFqCm5IckvRMHf9Iw+XCSJHAlMfzw3rMOduHqyUt2VmQqMmoiYArJj+mE9r+Jc3sHioopYQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882210; c=relaxed/simple;
	bh=TgXemkgW2xjGqdL7efvn5GwakWCM6zwP9roL0UUY14Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QPeGYwVqC80PDawd+BHFtFQg7QXTuEjPRQ2C8ArQNdqfex57Hf+Z6v+b/CkiuNZsbsxNLmfv/f/9DuF3P5wpL1uST5ha2O+kYfobDy8m/Do3AWQqsvO4TiKZKfELOiOsTZsBez77RdIULBYX2cMQtxBE8lMCGszk9Sxi/d9PZdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g2uMIhA1; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g2uMIhA1"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so61189715e9.1
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 04:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779882203; x=1780487003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vr/dCWZqkxecamIVH5FjFCNfp5PazmhoCWjfR1OvVNg=;
        b=g2uMIhA1ojyOBSV3niIOaFrGfSs5+AeVZHpeUcJBjKhzhjnY35yz8nTSiNGmVanJk9
         nPH5SyRGqOc/QYfZX3m8d6SvIn/Lqaank1Nky3RbnGK3/gVy4OAcemlNlOUl1y6uOJeB
         Psea3KWgxcPKgnpbrqJWcNGLLGYH5AFr3T851jSLjBlU4z0yeR7Ue1uT1zmN7/sn9gxN
         YrhdfQH7+p5WZOJd2cGO2I3Jw5VgsT6RuDmaX9aVTWIYGr5bpCr62brZ1tQu6UE1iA9n
         ZLn48KxLsKqojlabnNDSCQp6AGGBpkIZzKvXDUl9fRWpUrEaQo7/LcqVl0q2P3rK++Tg
         6QUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779882203; x=1780487003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vr/dCWZqkxecamIVH5FjFCNfp5PazmhoCWjfR1OvVNg=;
        b=qp9uI3jR96Qv9E20iRCn6Rq827qDlWMOlAPn8J3Y3MDuNNHDU7dN3amjlf2ng6ZyOt
         P+0yyU55htnjefM7651rMEr135dS5kLAbtpErJFXy3wvEPx981NWV/GD0BnH5YFYV809
         PWEJdSpSbwhJPKNVOtIC4LcBIrs1+JM9anvYsDCgSEhZkmT5VUFFd41awPQm2fGBAmyX
         Ja+cniP36dFBxJfmobCnvh4PmIaisoQHHxGpLJXcZFBtWQUw0zURiV6iPPictYVysbIJ
         ZpIC3tPs3vS++85rnLtcsiSCcKFH2kvjRPlwjUl3dEHz/FJ/7o7qQXFBMPhw0GBTkN+L
         Ll0A==
X-Forwarded-Encrypted: i=1; AFNElJ8V7THvrPbPMLS6nTgO+8Bc3RnFDeAjcMN70vy12WcX+73stHK6iImTeh+IstKWTzgWczk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGVPGqP5a8kBzBv4dOofy/DDu9/sYVbsgOpZG9JpHj4qsMelKr
	vJBP5pLsQWO8EYVVQwguPXPRTMDoiuGaxlDBZb9ktcRm2z8+EWf9jSza9kLXQ7pJj68=
X-Gm-Gg: Acq92OFifBO/sEXHgFefY5G7OQnlId38lnk/jb6yzrNciezXTL/iTNvRyagT95KU/aR
	+uZUPeEoGP65aoWQGQn18isJie0/yoGsOpBISLGrWO/Ja5t2Mgy6zk4g6Bg0oqrpuw9aKoJ87tZ
	IyfFc+v9EQuFWfshqFC3OiLd/yYUvNdnksb0o+cy7BXzBqd5ZWBXNXJI2cEki/UwXsBCJZ/qznQ
	W5VYmwrD7L0zl/mNaMVCwW258MwKP3+rCeZ3SKy+N7VZPjz8enPb4yTWEJIPPDUJ8Txob/ivQj0
	0m28nfz+a6IUUj3rEBfmiHMRtRzUqEWrInnr4kzZKk3zxGmkgVYA43uw7ei96f4BjK74KQ6prmZ
	LQLrGkhS4Bh346i8jj2ZbrE2tNyEmPQPZDbD1jxs9dg3+QHIB9D6KN0uKAyMzcbyp+/QQYQY2b/
	J4KiC362L2Ru6L6K45WVsxhzwk6x3jBsNZLw==
X-Received: by 2002:a05:600c:6992:b0:490:5000:917 with SMTP id 5b1f17b1804b1-49050000ae6mr310718185e9.1.1779882203368;
        Wed, 27 May 2026 04:43:23 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454c600esm383473175e9.3.2026.05.27.04.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 04:43:21 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 24CF75FB96;
	Wed, 27 May 2026 12:43:21 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Alexander Graf <agraf@csgraf.de>,
	Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v6 3/8] target/arm: redefine event stream fields
Date: Wed, 27 May 2026 12:43:15 +0100
Message-ID: <20260527114320.1581552-4-alex.bennee@linaro.org>
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
index 7deaf1ab6de..0c22781919b 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -269,14 +269,17 @@ FIELD(VSTCR, SA, 30, 1)
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
@@ -286,7 +289,7 @@ FIELD(CNTHCTL, EL1TVT, 13, 1)
 FIELD(CNTHCTL, EL1TVCT, 14, 1)
 FIELD(CNTHCTL, EL1NVPCT, 15, 1)
 FIELD(CNTHCTL, EL1NVVCT, 16, 1)
-FIELD(CNTHCTL, EVNTIS, 17, 1)
+FIELD(CNTxCTL, EVNTIS, 17, 1)
 FIELD(CNTHCTL, CNTVMASK, 18, 1)
 FIELD(CNTHCTL, CNTPMASK, 19, 1)
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8240f1b3848..3b06bd80a01 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1766,9 +1766,9 @@ static void gt_cnthctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
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
@@ -1783,7 +1783,7 @@ static void gt_cnthctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
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

