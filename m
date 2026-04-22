Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CD73EBF1E
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 12:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862387; cv=none; b=iliRp9AcNsKZhZ++KmoiVQUKUUpfmcwzyfUFxRgaQfWl0UWeUi/8ic7K6r3+igb85tnSqhAX2IhvOEoD9o/Fla6f8bmq2OMn4t5YzwcJaJLJBh9zgFJdiBKw3uChjTf/tB8Hnr+wGB0r+n8+Ash5A+qo/V7TmZ91LUNWbek9l9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862387; c=relaxed/simple;
	bh=bIQma1WvCJMqDqzr9stcDms+l7hcxxEEKQpzNt371Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=efW8+MNNvAH3z386g2p4npE7Fero1T/UGtE3P91EdE7v/oi1yJKecaLV+hVR3Bj9bouXFDe1PWWCuwKKKiOoSgZeFNLMOf9nf1QLezXvshMZVRZwqM2O06OyQjamEpHY/01J9WbHTfMyHAgSKNPDdxfbDlduuIOopNKqGkw0jWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j0wJwi/E; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j0wJwi/E"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d75312379so4039271f8f.1
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 05:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776862385; x=1777467185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBHHqWCNozXOcmQTxKAtN3Av+2DGbBLMiAYtHB54URk=;
        b=j0wJwi/E3QqFww468lQMOsKMdmm5+fTX6IlmC2Af3QL961CZOGsSvjiKzHG6fRG1DU
         eWAHF1BZYZLTWjuN5OnF9VIMU8k8XdfrDbJNfWMUtBLyq0Qq2KrmyjUroxdMQuU2yVvy
         wWaALhIxmAKykbFxI7Q+7tlTV6H1lLNbH/oNedhzqhh/XUeLWI/JJB4sm4iZhcSKu0kn
         LfxvelEmmf6732d81oTuBTq5x2L+f4HE9P0i9ynKnmiFp0YmS+mIOKO5IkoUxsbD8Jyr
         nen/DNZUiyIWyvUN8iE2ThbG4qsEPG72NKSm/N66FEMrPAf1uBEpZOy2r7nvqXavZ4Ny
         i2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776862385; x=1777467185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pBHHqWCNozXOcmQTxKAtN3Av+2DGbBLMiAYtHB54URk=;
        b=XMdhMX8DOI3ganAhA7Z53l7sTKEsme4kR6hc/syibg9yh7ETvHiEUM5TIg3Cj0OnCr
         s/oS713BJM5Woq3LhaF/OtVHQXcCsVR9ygWEN77pzLmbyep7nCMYZPXpqO4LYdwm6E+g
         s1ssFxyqY2NZ67X0vz34cO+fEUWkOed255bdeaDZq2MCraZLxErzq03IspGmVf90I/Gw
         N20RcAnlOahdNLnkglB8GU10JB11f6TuZwQtR+Ij/G6ykDeW0c+c5B54t4PrYi4CNPUm
         gb8gHZdDMwJ3DWmx+qKZDImYK86EnEyBeCglL/tV83j+cYEWwWPhmN/jgD8FBucR1zA0
         gulA==
X-Forwarded-Encrypted: i=1; AFNElJ9cEtsz5sjFd0bDoLYlcV8H1zkZ8wa4BGpmc+Kkfn85mc4QI4LFCHOooiONXHMDFCAmehY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMyLsQ/HNVvq0/T6l6i7N4Z9sf3hrcszIsGcrXc1GRg05+NAbf
	vV7qeRMpVbpyPWDf/n86ovLu0DKdP4m0hHPWNMAN+bhHsaisehexXa0h4rIG0/bLlWk=
X-Gm-Gg: AeBDieth7KHS1AGea1tnVWdU8vdAQCS4cMVj+cjBOgKNARx6Gew4dVCcKz1ALtzINop
	or5z6IK6AyUT8SMlgGapr169oMeo2VsKEp2ukTmiIicRVKhU00QJ6i3aRXelX08vD3tKQkNlAY8
	LPAPIkqGJ8FUwxC/WC3EAvTWT090Qh+jpGYJEUowMPV7E9SsxKxQrasOZAsdEgI4bTikuE2NS3M
	M32TEemEEMYQKz9ajbskRFhhIIXw7FqS34r61D170hoWUSTPOE/wmdGj85CVYGxUYcUw6uHcEG1
	xbnLlvBNqnua2Z0BbbH+2zu/zkxB+eZ+7FqvZy9muerOdAIVIfPknMHemUpXIWFSBeUNsNyu9Ek
	0HSXyUUfXSAXSVxdRpsATs5g/X5xZsGmYnTnAxa92pf5KYNCB5f7bjUOrPBdlo8HfJ/NgRrTmt6
	59a7b4g917/PCdFFMUpy2oM2+NOypdK013xw==
X-Received: by 2002:a5d:64c9:0:b0:43d:2d34:8963 with SMTP id ffacd0b85a97d-43fe407ae53mr37079461f8f.17.1776862384713;
        Wed, 22 Apr 2026 05:53:04 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e59f97sm50548635f8f.37.2026.04.22.05.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 05:53:02 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 2A69F61063;
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
Subject: [PATCH v3 15/32] target/arm: migrate check_hcr_el2_trap to use syndrome helper
Date: Wed, 22 Apr 2026 13:52:32 +0100
Message-ID: <20260422125250.1303100-16-alex.bennee@linaro.org>
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

It shares the same COPROC_ISS encoding as the other CP traps although
not all the fields are used.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/syndrome.h       | 16 ++++++++++++++++
 target/arm/tcg/vfp_helper.c |  5 +----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 841fd3292b8..53137394e28 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -251,6 +251,22 @@ FIELD(COPROC_ISS, OP2, 17, 3)
 FIELD(COPROC_ISS, COND, 20, 4)
 FIELD(COPROC_ISS, CV, 24, 1)
 
+static inline uint32_t syn_cp10_rt_trap(int cv, int cond, int opc1,
+                                        int crn, int rt, int isread)
+{
+    uint32_t res = syn_set_ec(0, EC_FPIDTRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, COPROC_ISS, CV, cv);
+    res = FIELD_DP32(res, COPROC_ISS, COND, cond);
+    res = FIELD_DP32(res, COPROC_ISS, OP1, opc1);
+    res = FIELD_DP32(res, COPROC_ISS, CRN, crn);
+    res = FIELD_DP32(res, COPROC_ISS, RT, rt);
+    res = FIELD_DP32(res, COPROC_ISS, ISREAD, isread);
+
+    return res;
+}
+
 static inline uint32_t syn_cp14_rt_trap(int cv, int cond, int opc1, int opc2,
                                         int crn, int crm, int rt, int isread,
                                         bool is_16bit)
diff --git a/target/arm/tcg/vfp_helper.c b/target/arm/tcg/vfp_helper.c
index 45f2eb0930f..e692bc568bd 100644
--- a/target/arm/tcg/vfp_helper.c
+++ b/target/arm/tcg/vfp_helper.c
@@ -1359,10 +1359,7 @@ void HELPER(check_hcr_el2_trap)(CPUARMState *env, uint32_t rt, uint32_t reg)
         g_assert_not_reached();
     }
 
-    syndrome = ((EC_FPIDTRAP << ARM_EL_EC_SHIFT)
-                | ARM_EL_IL
-                | (1 << 24) | (0xe << 20) | (7 << 14)
-                | (reg << 10) | (rt << 5) | 1);
+    syndrome = syn_cp10_rt_trap(1, 0xe, 7, reg, rt, 1);
 
     raise_exception(env, EXCP_HYP_TRAP, syndrome, 2);
 }
-- 
2.47.3

