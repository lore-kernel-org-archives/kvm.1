Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2643EB81B
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 12:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862385; cv=none; b=kt6iUeETTDHdiSapcRQx1Xyx7GQ0Mgyf8umc6sxq26dJwIB+W3h6hPZu0Svpcr8T/OUwlWJTbHDqttJqTUF+fEhwOobhWhFyPKVcR4B+YYrvPLgbHbvTS9S2g/L4QH/0B87iA0kkpQL+vzzwxxsZYNgb9vGPXcnIMbYGIt5mqUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862385; c=relaxed/simple;
	bh=cccoPHM6d5qV2Ni48oei9X1VKYcFgX+rd8Sz/6nSoWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KORozQx3ecbBCVZHAdFw+KT/ozOjArjPAAUEMBhhGysSHFs5HcwBmmWourEpefwE0IVj7Qhb3XFnU+tOdN+qGmhZ2t4EPJYkRszfvAiQpSpNQuLt44XX3p0d1gHuAN9rDbTDyPTrsQnLcJgQIHddygdkqQKncfKnS6QyT3ym5G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L72UJDwP; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L72UJDwP"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43fe62837baso3302268f8f.3
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 05:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776862383; x=1777467183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJ6frWkT466kUBA2I2u6c2X58fkiBAsV+LbvLNVH5Kk=;
        b=L72UJDwPf2uUOeFhfAaruz3BbapRzncd0lWB3KOmXSVUlDUep75OqRnEuOVa8DiwAE
         R9w7eqZU8jzFCiv+bTpiV1v76FSrioqCnEzYGHDzGuJxXGxf6dWMfFQQSD/M1wy+z95V
         1jhjtXyROocihk2qQ1zABw0iLR4LfNSWWCUWiIL3GmR3seJ4U/CowTNy5ji04TGyvDpn
         kSTTnFZFDqhH7rOTDg6wEpiDKo6Q7BeOiulNusuRJYEpeG6okApPB7hj1iuuJ+u2c6nq
         HjtwK50Ok/icgvEK+508IaapKP/ocBy2qdx1RPEZU1SIUeDdoF2eE3sZs1lX8xMDllJt
         7ICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776862383; x=1777467183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AJ6frWkT466kUBA2I2u6c2X58fkiBAsV+LbvLNVH5Kk=;
        b=Jf9T2ZMCShyXqz3vZaRGMDMw6d7q2SbvDqm1sV15Nuhg2+8ycO8L8CgHIZx5gcQyXI
         Ae1U56p4uqLxHu/kqOS2NwyoVY5r/VYQvvxGiQBmYolDnvM7k0qfVCplcs6VVDb7Q9Jy
         5K0SDjZ97gdrSmvmEF+1eWLFaVn6H8rC3tv3l4b3N3PVR4/p6XSmq+FiMXonRBhKEZRg
         bD/iQTqUbQKptUMaCz3WmfS419bojdCeAwTd/iFOIr3ARSWaDhxOadgtM7FEY4UtcSQX
         tsuba73oC2HojfnkHS4JHvh4LX5IW25OyQSMJIKfLC55O+7Dsjj3iLHidBi0wwu+ICjl
         ol1g==
X-Forwarded-Encrypted: i=1; AFNElJ8WZd2peD/YvLhWn9MC0HyZJpp1Xclfwwiwij6JkCXCslhf/rOe4xRHXsc264hZIrNK0fY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Cu5sFrMUJAX6czzT3i4NJ0wUTGFehuBbhUx+YYPB3DHQxsTR
	JYzcLKynzZRM7IMChAwCv9rHB0knNWn2H6vHlojPd98hRKClvDvydo7ibz999x6hqmzIqxEBwsW
	IBzcR8rQ=
X-Gm-Gg: AeBDietU0BOHvKA9UjB+ngGZbpi1cFjHDv7CecggizOFUTTYsJZfUBoJ/jMggl6OPII
	qU4dPM3Mee5t1Fx9MfB61GqRQf654AbjGeKSfqwksnQn9gTS8nzxP6eUEVrbA3mHzwsTlIo4mmA
	zLgzFle/TBpg3+08dhpQH8r3uZvonXHmgVqQx7DN2kkg4FvyJ/RgoOdeCAwkzcni1igXSQtEm02
	G1s6Kp4SY6Is4lVFY3f8P0ehpvtxTPY+jm2QVSJ58kjZciLFK4wMW2uVTDWdBGcJGwPyVVVuLWZ
	Mn7SmJOrw3OUzfASEH79D8BpUHvWU7YtoS2ZZrPDwcFi1It6jqmjVaFawGwMwaXKrc4rc2E4Slv
	MkUKxClXqgv/Unxg7yXEb1ncAdrS3dMDPkIpk74XifmI9yIN5DS+ttKbJFrXU2ufRCy+ACU6EnR
	dYPwxMGQn6ACsbqxTnikByBcxx3+B4+4Aoyg==
X-Received: by 2002:a05:6000:184d:b0:43c:ef4f:79e4 with SMTP id ffacd0b85a97d-43fe3dfd36fmr33892324f8f.37.1776862382774;
        Wed, 22 Apr 2026 05:53:02 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e59f97sm50548552f8f.37.2026.04.22.05.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 05:53:02 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 15B9961028;
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
Subject: [PATCH v3 14/32] target/arm: migrate memory op syndromes to registerfields
Date: Wed, 22 Apr 2026 13:52:31 +0100
Message-ID: <20260422125250.1303100-15-alex.bennee@linaro.org>
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/syndrome.h | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 7ff8c30e2bb..841fd3292b8 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -742,14 +742,39 @@ static inline uint32_t syn_serror(uint32_t extra)
     return res;
 }
 
+/*
+ * ISS encoding for an exception from the Memory Copy and Memory Set
+ * instructions.
+ */
+FIELD(MOP_ISS, SIZEREG, 0, 5)
+FIELD(MOP_ISS, SRCREG, 5, 5)
+FIELD(MOP_ISS, DESTREG, 10, 5)
+FIELD(MOP_ISS, FORMATOPT, 16, 2)
+FIELD(MOP_ISS, OPT_A, 16, 1)
+FIELD(MOP_ISS, WRONG_OPT, 17, 1)
+FIELD(MOP_ISS, EPILOGUE, 18, 1)
+FIELD(MOP_ISS, OPTIONS, 19, 4)
+FIELD(MOP_ISS, IS_SETG, 23, 1)
+FIELD(MOP_ISS, MEMINST, 24, 1)
+
 static inline uint32_t syn_mop(bool is_set, bool is_setg, int options,
                                bool epilogue, bool wrong_option, bool option_a,
                                int destreg, int srcreg, int sizereg)
 {
-    return (EC_MOP << ARM_EL_EC_SHIFT) | ARM_EL_IL |
-        (is_set << 24) | (is_setg << 23) | (options << 19) |
-        (epilogue << 18) | (wrong_option << 17) | (option_a << 16) |
-        (destreg << 10) | (srcreg << 5) | sizereg;
+    uint32_t res = syn_set_ec(0, EC_MOP);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, MOP_ISS, MEMINST, is_set);
+    res = FIELD_DP32(res, MOP_ISS, IS_SETG, is_setg);
+    res = FIELD_DP32(res, MOP_ISS, OPTIONS, options);
+    res = FIELD_DP32(res, MOP_ISS, EPILOGUE, epilogue);
+    res = FIELD_DP32(res, MOP_ISS, WRONG_OPT, wrong_option);
+    res = FIELD_DP32(res, MOP_ISS, OPT_A, option_a);
+    res = FIELD_DP32(res, MOP_ISS, DESTREG, destreg);
+    res = FIELD_DP32(res, MOP_ISS, SRCREG, srcreg);
+    res = FIELD_DP32(res, MOP_ISS, SIZEREG, sizereg);
+
+    return res;
 }
 
 
-- 
2.47.3

