Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C349339EF30
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 10:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777545881; cv=none; b=Ybr3VWQzsl00gn7xTXQm0xKxCu41d+W1MlJePYDHH8RjjESY1xnA7yNaLIH0XJu/lycwwRnd/XFCoef8TEgu6nhmFziAhHETFs5KvjIqYf/CbzsvP1H9nUiyu00Jrp2Q3VtE61jFdugXY7ncCrlUrJItcwry9gtQz7dHBU7elSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777545881; c=relaxed/simple;
	bh=YWoNKk9wrbiaUxDvW/Txq7tiNqohKzQVXe6grYa/p/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NxujM4zAUpXrLbEEnUlydXk2UWJTmZrLCejneZSrYvpnbEp84dIhQF0wAxYgtO218oZUg7sjLOQzpzSMMKTFHZGzfcM1/0yEKDUG97GNpqhRMhPc+brcjArXC2MPuPgWjn/5wycRhny9GZxBfJYQkHfHzKO6GGtsjW2Okq7i6lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a8NKd5D4; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a8NKd5D4"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso9400385e9.1
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 03:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777545878; x=1778150678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RsPS9jH4wqzZMo8K63vD2xS0qPk68eIqWMM62PQ4Kyc=;
        b=a8NKd5D4k0ZESKf3We+bKXVMfkchVUjGOPLmP9+rowXre++Tf2znHN7QPBHVzQ4suu
         D2kBiaGwZGw3t8KDPqZV9WtzaCBuz58+49MnsWj79LPNgLc8+giQktjB052cSeU1A+YX
         KElIFEvIXQjUSoTxYJhuucoM6r8l+bWjtCGbVHd+RbDdZxEJ2Ok0ivCnXnQiR2WqwVya
         4rLJYDoZeBZmNsKEcAS9JrEZtqXTeTuRQWQXMLnXHG5OVc9TJONqAseKLmn5yszZk389
         T42bepRuRiH1EaW5+2QOzn67ZqXomd05evoBDWSqzyO8/kzQuzupJ2AwKrd2OpyKKR4A
         dAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777545878; x=1778150678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RsPS9jH4wqzZMo8K63vD2xS0qPk68eIqWMM62PQ4Kyc=;
        b=ka8l2Atvl3PIriRWawQs83H/G6UXOILpChO3qjCQr1h3zFaF7pdYzdOn4fthBGAiB8
         xjO9FbSgNObnfcsIVCcJKGWIRLbR+xw84bgk1XSzf+fSWr0YrW95zghrPeTQa5Abj5TU
         27fMJj+xP3i0Tw5jqd2D1ys1duqrCbkRcwYa/By7ub/nwdqs0ezG8qJpp4Rj9JRU46uN
         5c+YqBaqbL9Ybwpi9g36Li9Oa3IRNEBh6pWOOIre2vZyiImChs5VbFbFHrtTDt+rnhGc
         PRgocUBgfbrjAjCkyh+bfNYxH3L3MT2TuRCp2ZAmnXaw65yShkhKPVsMUSWjddogw/f5
         mNEw==
X-Forwarded-Encrypted: i=1; AFNElJ+G27DozwGRUzOQ6Z8Dw8nb2Oyot25dBwA+EhYMrzkzHWER7nkljbxAMh/CF/fb4p5AG0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgkYCCD61K+Xj85dUwOZ1DmNYv0XW4dEiXQO4BeyShNUk5aFNY
	5fekIaYwrz3pSCMyHI9y9Mo5y9tzvkmUIRI6uTtul91ZMGpkFDvRRT65BL3EoOlKrWY=
X-Gm-Gg: AeBDietQNJzcTfmN+AGRC63Zd4kImJG14R7rfhKrCyVIzPShIQfpHeidnFyT8hJwX4e
	iVnoidLNntKbtEF0uJfBQXAemySoGh9L2vu4yqD4wYGJUr3Mq/LZPnHLfBU2ofifJ8TMaEiYBgc
	gVjQSNwDgZcVjpSdY48Bw69d/Qau4WuUT1iIJkANM+c4d0n964US2gLol0ysDjnLKXdZ2iEDO7+
	qz7K/VG1dodnLZstxvUPJHUdE8oVXq6R8DAN0CwPCHLT0xve8WFEEer3zfgIh69wZ5r0K9dl0V6
	rd52i9hBbM3PNTr1ciUS5k+bkcE1nEHwVts2aoHzQP7LGr0IsfvU4ETUsCFZIGlgEb/mE4jg2qn
	aQoBOFbKnP6Lh1lptAkJw1yIk6TA0KCrUy8NvyCwzJ+9KHYHSnhdbyen1hPrEvTz0/ZAjPva8Sd
	xiE/LGHTX3PbM55EW2iQ/O6csk8BPCO1L+/Q==
X-Received: by 2002:a05:600c:45d4:b0:488:90ac:8f71 with SMTP id 5b1f17b1804b1-48a83d66cd4mr33804835e9.5.1777545878132;
        Thu, 30 Apr 2026 03:44:38 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7b912869sm40905485e9.6.2026.04.30.03.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 03:44:35 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id F21705F932;
	Thu, 30 Apr 2026 11:44:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
	qemu-arm@nongnu.org,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	Alexander Graf <agraf@csgraf.de>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 2/7] target/arm: redefine event stream fields
Date: Thu, 30 Apr 2026 11:44:29 +0100
Message-ID: <20260430104434.1482407-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260430104434.1482407-1-alex.bennee@linaro.org>
References: <20260430104434.1482407-1-alex.bennee@linaro.org>
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
index 4a1ea5465d7..24423a200ff 100644
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
index 7e7677a584d..dfdb77a9fe2 100644
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

