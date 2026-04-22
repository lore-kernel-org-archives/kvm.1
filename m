Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7DA3CD8D5
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 10:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776852656; cv=none; b=XApdal6UPhNGklK+PKa2zBN0hQmYTmQItTa965881mVAnKEK/DKUW5o/WjS7R63hoaYbDWI33jzS64TXUCpqsMiOA29GJsrtPGzOqD1Blwyc/tzEL0fOSTnr2NGD56kXcW+O2DeLWUP5AtSyx3Ct2QWCoc4nk7suEjUa6zWKECs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776852656; c=relaxed/simple;
	bh=bpcuiiR+S/iCF5Z3N0TAugR+CkCiQU5TGYnRkrLJ6L8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QFxoGR1bK4exI/xvaUavX7k+WKjDqv5iWKa5MfTMY3tZ6XTcBiv7AMVw+VCuDD5nFnfpbTa6xHC+hrc1+vyB3XhuDJxDF9VsFmPE5pxN9nQ/DUStVuezuYMWSuMhsM8KIsVTwiRQwpb2ZQe1oV+cmdGJQpcAbvFLbDAI9es/Qrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VmMR25wK; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VmMR25wK"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43cfde3c3f3so5478965f8f.3
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 03:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776852654; x=1777457454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLD556mwBZN0FOjv6jT/HPan7Y0S6BW5g1K/GkaPB6k=;
        b=VmMR25wKPBhWPqesWDWKhOSVAx/Ve2FTqcMaBgOiLkO9faq91aw31gpjyp3bwyibZu
         FXHM1/bK/9cBJjOdjmMlgGgNsuadnvEXc+6X4csg53ekeKVlhedwYL5s0Ud3NYauPIQU
         tK5flIsDT+stFFwzUg6b1i8fDBMZ6a8JH9Rco+kgsBlMR45hJNLIz+AVXwdcT3mikufI
         YeI9pfLq9hANS/rac0ENiiSk5clJH2GomnBY+pg5zZ0hn6VAsxzYQkFLHO0jAr/Jn8Tu
         pyCqwI3NbCZ+bMogDwqaIj4y22maUPfy88HaxsdVSp/Yja8NcMVAMTixNNkjG1w0dI3n
         EZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776852654; x=1777457454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qLD556mwBZN0FOjv6jT/HPan7Y0S6BW5g1K/GkaPB6k=;
        b=Xpf7iPNPatdStWnT5jYSD9qNLsrp9u2wmStlXUKn74FxxXcObg2eC5ld8jEeSCvvCD
         BceKcN+lGQXUPUqMQVfsjXorL+/eBqIlaWp5zBsLA2cq8zef+k5EcPv4Ed75MS/Cx/fK
         /z9bMIciB/EDUJwPhkEr8WjqIbnBmwD8tdlRXx3HK1jf9kUhjn7iTfEa5T8rEqsNZkNd
         cNuHxCFfMBYVPXUsbCoyrqYpVyC/HoqL8md6hNrpDEpj2RXj2fWThqcd7PguHao/X5N7
         WoECb+YF3qd9nD/r9PeyUbOIO7sGT7bXPH2IHffotus+gx4M94jXe2eYOR0B8uOAvERo
         v67Q==
X-Forwarded-Encrypted: i=1; AFNElJ8MXZkwCXIJdgKTZgwjU1K/JfwVQdD32fZB+oTv5vc51qE2NXjnrK0xHww7lByfyKlKHtk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs4yEihKLQisP8l1ro7q8eJKLxZWQ2AJlMKIO+gp8pKiHleYD3
	BGz+1G8fgJSlIbB3mpOTaQ5/aAnQMpnLMwdVRLGwNY0EgjBh+UcpXXE8fz0A8SNshRk=
X-Gm-Gg: AeBDievhYq3m2xdEDBIsTPxCoI2IiCDfejrwXwTRSvL9od5EeRHl8CNas4c0/f3bvuX
	K/v+4C0Y9zT6378SCWxTPf+JDtUTSlRz8Jle6JgAXsHTO1CMlwjbJHTS4SBIByP65cwuYGIwGl2
	oYcIfcRRSIzeP7W/M+Bh+PQ7TP47zqui8Qi2SGGXk9p/AORaakTd8AXoVM3OoiHkeVUNN995Lbl
	PN8n1qpaAcNGxx9iY8piZ+zoYTkl9SeF6zvKfpW3I+yD1Kv7KrXK7BnO/dQF9PcX+6/4sUqV17c
	iyCff1OkQBCjzBp1a1Ey1jpLXMHc0XxcYAbmQHsBTaZnJTu2bwjSVPZpgsQAzYRW9HZR6rFJXa5
	n66BHeET5tdd6mM5lb1Cu0IdO/82hzzd6T54SvEZxSXRjgABBBhLGQCe7N8qHRA9Zx0td3b8Lrw
	uROV9U07iCu/NaC//E9kXIdyn/Rw+1rECY0w==
X-Received: by 2002:a05:6000:186c:b0:43e:a703:3665 with SMTP id ffacd0b85a97d-43fe3e0c6femr33085614f8f.25.1776852653594;
        Wed, 22 Apr 2026 03:10:53 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1405sm44247250f8f.4.2026.04.22.03.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 03:10:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 7475C60F3D;
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
Subject: [PATCH v2 13/31] target/arm: migrate gcs syndromes to registerfields
Date: Wed, 22 Apr 2026 11:10:24 +0100
Message-ID: <20260422101043.1234229-14-alex.bennee@linaro.org>
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

Tweak arg names to make it clear raddr is the data address register
number.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - rename ra->raddr to document things.
---
 target/arm/syndrome.h | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 65d0de63a83..7ff8c30e2bb 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -690,21 +690,48 @@ static inline uint32_t syn_pcalignment(void)
     return res;
 }
 
+/*
+ * ISS encoding for a GCS exception
+ *
+ * Field validity depends on EXTYPE
+ */
+FIELD(GCS_ISS, IT, 0, 5)
+FIELD(GCS_ISS, RN, 5, 5) /* only for non EXLOCK exceptions */
+FIELD(GCS_ISS, RADDR, 10, 5) /* only for GCSSTR/GCSSTTR traps */
+FIELD(GCS_ISS, EXTYPE, 20, 4)
+
 static inline uint32_t syn_gcs_data_check(GCSInstructionType it, int rn)
 {
-    return ((EC_GCS << ARM_EL_EC_SHIFT) | ARM_EL_IL |
-            (GCS_ET_DataCheck << 20) | (rn << 5) | it);
+    uint32_t res = syn_set_ec(0, EC_GCS);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, GCS_ISS, EXTYPE, GCS_ET_DataCheck);
+    res = FIELD_DP32(res, GCS_ISS, RN, rn);
+    res = FIELD_DP32(res, GCS_ISS, IT, it);
+
+    return res;
 }
 
 static inline uint32_t syn_gcs_exlock(void)
 {
-    return (EC_GCS << ARM_EL_EC_SHIFT) | ARM_EL_IL | (GCS_ET_EXLOCK << 20);
+    uint32_t res = syn_set_ec(0, EC_GCS);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, GCS_ISS, EXTYPE, GCS_ET_EXLOCK);
+
+    return res;
 }
 
-static inline uint32_t syn_gcs_gcsstr(int ra, int rn)
+static inline uint32_t syn_gcs_gcsstr(int raddr, int rn)
 {
-    return ((EC_GCS << ARM_EL_EC_SHIFT) | ARM_EL_IL |
-            (GCS_ET_GCSSTR_GCSSTTR << 20) | (ra << 10) | (rn << 5));
+    uint32_t res = syn_set_ec(0, EC_GCS);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, GCS_ISS, EXTYPE, GCS_ET_GCSSTR_GCSSTTR);
+    res = FIELD_DP32(res, GCS_ISS, RADDR, raddr);
+    res = FIELD_DP32(res, GCS_ISS, RN, rn);
+
+    return res;
 }
 
 static inline uint32_t syn_serror(uint32_t extra)
-- 
2.47.3

