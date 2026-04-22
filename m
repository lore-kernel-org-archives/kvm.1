Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435653C7E18
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 10:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776852650; cv=none; b=Z3Qv6riP1M/8GZx9Ic3R1weIzVwGGSvE3p086TigqswuKP2EjEbLwd39IYIuOFLjh5tqWyMeJdURUCrSVG6S6OMbBfWQDTNf9PG+f80YtKhDDKamsIQOX+R/Va3GtD/HkhFHnYByd4cRcpudvnT8TC56GSErr4USmIrBTJmQ7PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776852650; c=relaxed/simple;
	bh=p9zh1aSSTJl7qcoNAxlI9Zgvn5vO3xLa8DoNJqH9INE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fWyaX1/4iupDaUq259QJcUAI60UZM5Qg4xiAqbIrI++WXcv52ffZKLj0sUpShzP7JEA4NHNzSXiLphwt6l50o9RJaMcZRCt5/XL5XBFOxaedifT3wvJUnGplqnseylstwGTPZX9UHhqPMf9wEReGQv9lViwPG1lkcXiyF1z/pPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NyYxth4Y; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NyYxth4Y"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so4849048f8f.2
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 03:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776852648; x=1777457448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6n23oz7LRRQlFUUM3gTQS/rrKewMUhskSZOvSJMe4M=;
        b=NyYxth4YKfM5qHHG89bJUqNX5SdzaO/NU4k9Ps8ciQwZ1EJvbOh14Xd7enYirbp0/e
         xBlWoOaZ22Q9Csu7VHW9BbD1EzROOZGSBX19ISclucFNPwBuX9YuH3RF2f+MhUrtVbw9
         D/t4sic79lCi9gsAMqwN7S2reDUMH2/MgaixxDYT2tj45Np3B6XyMaTjrHnnXC2gLJOe
         46i7Sis59gF8SBZ8+DIudJnrHYUURZu8WuAh7HABFO5kz7Qx5GITkZ9bW9Tl2fKCIfhy
         uAaSTknhM/8eEsHwDhUonCWkx34LUVRoDSZW2xxHWRwuCwhGsOYV7BT/du/tVhuIJJYe
         7BXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776852648; x=1777457448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K6n23oz7LRRQlFUUM3gTQS/rrKewMUhskSZOvSJMe4M=;
        b=OSZHNp7Mo0QD+1Cl4Z3ohQgXtUvL9Vi7bYq2HfOqgv3VPSFsBVWJUsJjDqwF4HoAzH
         Ilj2j40D6wRC8OipnjaDRNztj7ra3Ix8anPu916lEbeWnfPEeofwyxghmOoCBD6P1mkd
         ZTr/ZGVOlLqlIXhHfZh4Vib/JjZfhjYjF0JgnXVsylVsgXEt8E4fKsjFZoHaieVCtjmV
         uqLcnBKPsHzDK6Smdc9Uuf+YB7mwNe9zOnM7q8lienMUEHvFqq4mlQIT4T6kty8FASfQ
         44OcalNfNx/ePTvo9osGQv5pV9YRd4AOjJIm9fneyM/Q25toTkhc3Dj3Y+HhF5A1xiJQ
         9Osw==
X-Forwarded-Encrypted: i=1; AFNElJ+FL9c+JNtkO4W2sKfebUUWgclUtS0XgGjKhbZP7tVV/AzGZg/WSrByTwcF5Gaa4CsWHeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG5mzhFicHFhemib36SaW2xN9UNuuS7pSY82b9vtWvkv+Uagkr
	y1BvHu6Rn2qkehjY+97pP5/+UxRs+GztL2IT2j64Th324DVcucOtBGsOXfaphpBAiCY=
X-Gm-Gg: AeBDiesjgf3CUFayN7v49hbXgJoxyG9WH4Qfaha5zlB5yS6DNvDjeg6J4qM+35zXn8T
	hv3uccz41wQYGog4a+29bh1aqGv4LIrZ1QJI614nEaAYb+Kb1NlJ7JuBpJE1RK15ioMkVJmofl4
	pfmicbJPyksA4hDEuC5HduD6NMMrS8n7KA/+npdBcdONs73m9nYSWZRjdXm3iLF7QpOVSv+dBkr
	SVCvoek6Ousq5SzCtJPTI31IDdAyGYvyMnjsVKbHMyvOv3uSU72ikPlOKB07XzE1sKolHBrF5Hv
	yfFajmeNud3B5rL896Ry1M8y9SEjS7r/yol9QxWMlrJcw9Adu02lPoi06kJqxCuAZ+IZRllsfsn
	tj+PwYg08piMGiqFXcwVDzyYhp1lCt4i27+EF0x903ydCziB8vKaru/8UrDv/noS8oG+K+LzDkn
	pniQvbrcXD39Y2hmN6GmWs8USkZpxOJQ/b4Q==
X-Received: by 2002:a05:6000:26ca:b0:43d:7883:87b9 with SMTP id ffacd0b85a97d-43fe3dc7b56mr33421360f8f.16.1776852647586;
        Wed, 22 Apr 2026 03:10:47 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a341sm48291163f8f.24.2026.04.22.03.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 03:10:44 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id A99A55FC04;
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
Subject: [PATCH v2 03/31] target/arm: migrate FP/SIMD trap syndromes to registerfields
Date: Wed, 22 Apr 2026 11:10:14 +0100
Message-ID: <20260422101043.1234229-4-alex.bennee@linaro.org>
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

