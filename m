Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D350536D9F6
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 08:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043394; cv=none; b=jE2tqJjlgblPDlNghOEvD1ZjDfhu9Jc40G/7xuYDFLBJJMnQvj5McVUOJpgbxMHBdSZa/J4P1r751zlHDXPA53wTSnSX+DY8G3CJ03bJLnds6f0Pi004IP0oAphgZfOPSn+QM5RNI0TB6ScPicm/p0FBxWSPjXWPqG6NI1WHnxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043394; c=relaxed/simple;
	bh=Ya+lFuxcwHbr/YnRgEBt1LhbJ73T+oEVWBxYvX8iQXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q4jB0EUKaTCF2g3UrFx/Bt3VAtZF2Ojs974JrbCelCNTfgPAZqspVIQskn2BaGZPaS2ZA3LCNaP3jBkxiwVEJK6Gd1u5YdcRA72jET2KCOw/MM6r0wPOfeR24kPfX761gOJKa1U4qNW4ysHOs5UCff+1Q10NhyxrwkUIBmZ1MAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c30awKLK; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c30awKLK"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4904c1ce4c1so77500815e9.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 01:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780043391; x=1780648191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=az9S1vGVboCrXLR85YpBzY90OGFAcAq/GvXnwLVzHvg=;
        b=c30awKLKEjcQxslUWPodC8sNpd58HcIYVyhPwRmLXgG7AFMXldX2MYRqIzvsRo6WFG
         e/LIutScv1UurvLOdOLIzQjnDREWS3CHw4/ycoDn84NG4yk3q56A4pMY/monDBiO6++p
         WneXWR7znJs85XdqycQYTqkH9dareyhOGHWGgjpmXH0m0Crb1DFjiZoy4Ux/vNiuSUBm
         EbAhrglRKn7xzoDP7jEQeLKypTLYn5AU1cXxVb7u+d1STsXjOJ8oZv4kFPu2Onq6zXVf
         uK6jx+W8NmUjY8Hr86JZwiucX+0LcDqsW/7BFMCx2RqvoPS9K5yOIS0zXPvdJKrTb3Wp
         seOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780043391; x=1780648191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=az9S1vGVboCrXLR85YpBzY90OGFAcAq/GvXnwLVzHvg=;
        b=Se9Uwh6mUTSnwyqyTe/ZwZB9nNpaZjGa1qUZECJ/CH2yOfUTTtTu8Xwe45+/UyN17I
         2tbbHliMZcA7Nl10suc3Yeey54bEtXcWQDOh0FiOIW8dyaB6MUaeg3ar+S87iB+M8/vW
         uNOb5Cwzl0PzEKaLyIyT/uqqVpt7nqD1taF32LXPpSOAwm+4CP99AmThfMP9gKpTgOFF
         D2Ghrh3eNGCsSAHahHnEwVThjKdiK61zFNrMerDTq21//MRW5/SniChnuclByOHNeMhu
         7xTE545+qUwwS7MuFlDVZhCtY0rlaRS7Gdr3Ra6GclH5bOgHYI8P3Q714J4j6jZpHL5s
         +wNg==
X-Forwarded-Encrypted: i=1; AFNElJ+utbqpml1G2A/YnNtRLnSqQQHTMNR0QsypZzkmoYz7gxJuD2zeV0ATUl87+IvTfQrjfYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5RjuaWORfJTD17KZt6rkxeHJjeiP/RazUGiupW8cz6cL9GjZT
	cXceVbQZJGi2cu0cCeCJ7qiFs6lkDhSyyTLblR/DFmyLWtiPFouNlLjDOnQaUs9RHOg=
X-Gm-Gg: Acq92OFjPgJ28AX1oJWt2T+fMsrUXPJM2V3OyXnkjYkxG+4dCb35IseLuQiw1OvS25G
	T9uTL5j+pVb6bsDIHKbM35ChF6uS5BX2WLv6b+pIyPQpzB8il1Foel7xgpLOsT2mts0uePVI8X2
	gZfPgkQOyKNB6lBUClOQli818aPAYAwwCPWP7nayDviL2sJ5QBcyW1J1YffqQpyfmwUkPrmfVFJ
	B6ECoxHDNuSIo5KPo5Ro1HxPw6RDI0cUKvxf65T8jlxXG1eCVQk3H70qI5IMH3JO0+HVDJxFWzE
	VD3/hKmgVvnkcmzd1TC6uSStrJ5uT+mZxAYKM8OhhuEoA5S7MBUxQ00yAEYUkUR+mKk7IGX49vs
	Mepf7Ny1Q9aO2xy/YprJrwBE5NUlrZjiygKJ2UvYuZp3bT5IZ94PXrkbvQgzYpC4BokXRqh88vf
	RpZyhXNeJzgC19xxDOt16ghEQQOWZYPF9axg==
X-Received: by 2002:a7b:cc1a:0:b0:490:845c:a1ea with SMTP id 5b1f17b1804b1-4909c0b0c32mr25010795e9.21.1780043391324;
        Fri, 29 May 2026 01:29:51 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d6a0e42sm23561455e9.8.2026.05.29.01.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 01:29:49 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 71AFC602E1;
	Fri, 29 May 2026 09:29:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Alexander Graf <agraf@csgraf.de>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Peter Maydell <peter.maydell@linaro.org>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 3/8] target/arm: redefine event stream fields
Date: Fri, 29 May 2026 09:29:42 +0100
Message-ID: <20260529082948.363931-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529082948.363931-1-alex.bennee@linaro.org>
References: <20260529082948.363931-1-alex.bennee@linaro.org>
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
index fb9df50da29..93f5bd0e830 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -272,14 +272,17 @@ FIELD(VSTCR, SA, 30, 1)
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
@@ -289,7 +292,7 @@ FIELD(CNTHCTL, EL1TVT, 13, 1)
 FIELD(CNTHCTL, EL1TVCT, 14, 1)
 FIELD(CNTHCTL, EL1NVPCT, 15, 1)
 FIELD(CNTHCTL, EL1NVVCT, 16, 1)
-FIELD(CNTHCTL, EVNTIS, 17, 1)
+FIELD(CNTxCTL, EVNTIS, 17, 1)
 FIELD(CNTHCTL, CNTVMASK, 18, 1)
 FIELD(CNTHCTL, CNTPMASK, 19, 1)
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 34487eeaa36..bed58e65b4d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1769,9 +1769,9 @@ static void gt_cnthctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
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
@@ -1786,7 +1786,7 @@ static void gt_cnthctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
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

