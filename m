Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD71C3CD8BE
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 10:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776852655; cv=none; b=AKLOPAoeq9fXvD0VbUS18NZjsnjo7osu3iRUkqutmBFRzwucQQPu4L9EpWLZ/lmjEyG7K3hbXFcpVAvKP0lxwUwTvmOAM3Nq+EsqwfFj0mRiPNDJABfxeSAOi2DzAzF298Snw1pc8S0NhXkfgvF2/OTBZLXXtke2FCxTPSb37/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776852655; c=relaxed/simple;
	bh=Bme4SqmHD3uUqh79O1qpJHX8H3Zd/wSEVuQYFTr57WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HtfJ3VzsnLTD+xBLMeRDm/GlwNzfeC99nM106m9ZGeoqTLgaQtLpiWpRhSBlotquWgeg+ANJJg+wk2eMFTp60OP2dvAenqg4QJNZgS5bgT6zbS6mAcpmBq3xxUgIUe7y5pCyoD6Mrfb5jhBdj6cwBY6dJ2shlusT49Fid0w+ax8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yppWiDDN; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yppWiDDN"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488b0046078so47845115e9.1
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 03:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776852652; x=1777457452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMEvstJVHgigEudV5H559dC48ky9GaKFB5z4g04o+Y4=;
        b=yppWiDDNzTclxgLyXC/8705vQjtqbbNp9mcmSNgTIkNeac1wFwL3KRfWd8pdd80NfW
         XCPWsJR+TH7cN6iqfGE84VWsO0SuBmvGeT7vo5Wcrvd0OLPRVjyA637RMk9XKTQOsckq
         aT7MRLuTVmjAFjp/1+ueKlERSxKcghYMA2/EbKfh3TJbmiWqBXqHQLamfiHwIo2kuO3n
         7mU4VDIMawS/BpAdlhWGUYE0v/HsTYiNLC4DIzrGX3gDfMaG760X8cgf2sTJ6Sex/jpY
         BkTF4SaKIUQMx3m3nUfLHjrT5AkjiKgDGFuqxx+lrFEV8fWKmOriMDi5t2EEA+1Y1Xgo
         VT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776852652; x=1777457452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OMEvstJVHgigEudV5H559dC48ky9GaKFB5z4g04o+Y4=;
        b=bSna04pPSae09qmKwimvHTMmqxHwbay0vzSyoHA44Z9mcSwTCxJuNtCf046qYkKw8x
         gjYn077sHH145PY+gqu5Ku5O6nO0G9u052WWOzK5+UZAm6xNJbCXVrphbX9h57x6dLco
         jDxQvJ8VTaiV9D+GoCn2soGyqUnLhYySThYFV/PSr/n0n2AFpnrMHqcMyyqMM6qEoeZZ
         1EFxr1yahuwRFMQKTLxDIq5ro6dJCVLbOTpWHLwKFcboR8ZEkci+ZTGaRFgraXXbuf7U
         d/QNuPOMxJNL3Q9h0eKaba1CvaZ85DgaDYiENiYk/4JJpF8sLKOibYsMIWOClfFCI6JV
         y0FQ==
X-Forwarded-Encrypted: i=1; AFNElJ/PR0G7bSTjuSEgvWRxVsRQ7xIAJTsxKe6JLPGxtcB2iDxv/q4fMX5M4nDa0pwGstCYXZk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+MEyJbpjs9RDdy5Dk1T1HF1cfC44M/MmzpymGUjmfNMUB80kw
	/daiceDAAkv6vpqEtFds55cqpXc93oKHaRHcYBd+vwVxhJFAXp14t+EWc1W0yQTBK4KMasqKAmY
	e56aRzU0=
X-Gm-Gg: AeBDietNsrnHNIqeY8Ee6s6Ydto5tpzVC0Y5jDuDEgI0E0PDxuD2vzycQeduSQPsHlb
	UzwIdbEile3lo/GLkY1X3y+TplEO4hTuQhomJX4SZceSOkXnuFVzVBUvlXw/Qbou2xg5Mn8Jp83
	7zWWiz+Fp06sPdSPWcVHKS+r39jlSFe3TR1mduOYHHsVrXGCCRwMUxG/Wyv1L/0mFO4XQHZdopR
	gUXvrlkItEnOGXxUwdOOgHfunaQpYzRmk7xLhCAvnX5Bc6Z8wf1Ze82CKSvNmCIEsBTfyU5Ul7K
	saocwmZWZ5qPPMs50iGsH7yY/J5slFRaRHaNicFkXk8AMAzZRDQNtwkWkbAvPnKxG8zVI3TEMpp
	8GXsSG0bdvOHQTc0l/0O5h66100Wgi1k7qJajM2K3KbA63VolP6k8etDFz9UFUe+LdggZ3nY5jR
	CO+T+ojZUMK7zcQonNa+fUvABWKq+NuF3VkeByuMJm5UaE
X-Received: by 2002:a05:600c:c106:b0:489:1ba8:5be9 with SMTP id 5b1f17b1804b1-4891ba85d07mr128773375e9.29.1776852652050;
        Wed, 22 Apr 2026 03:10:52 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb77b001sm203412585e9.3.2026.04.22.03.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 03:10:48 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 2899B60ED5;
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
Subject: [PATCH v2 09/31] target/arm: migrate Granule Protection traps to registerfields
Date: Wed, 22 Apr 2026 11:10:20 +0100
Message-ID: <20260422101043.1234229-10-alex.bennee@linaro.org>
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/syndrome.h | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 6fcf0ac7572..bc65106c61a 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -462,12 +462,36 @@ static inline uint32_t syn_bxjtrap(int cv, int cond, int rm)
     return res;
 }
 
+/*
+ * ISS encoding for a Granule Protection Check exception
+ *
+ * These are only reported to EL3
+ */
+FIELD(GPC_ISS, xFSC, 0, 6)
+FIELD(GPC_ISS, WnR, 6, 1) /* Write not Read */
+FIELD(GPC_ISS, S1PTW, 7, 1)
+FIELD(GPC_ISS, CM, 8, 1)
+FIELD(GPC_ISS, VNCR, 13, 1)
+FIELD(GPC_ISS, GPCSC, 14, 6)
+FIELD(GPC_ISS, InD, 20, 1) /* Instruction not Data access */
+FIELD(GPC_ISS, S2PTW, 21, 1)
+
 static inline uint32_t syn_gpc(int s2ptw, int ind, int gpcsc, int vncr,
                                int cm, int s1ptw, int wnr, int fsc)
 {
-    return (EC_GPC << ARM_EL_EC_SHIFT) | ARM_EL_IL | (s2ptw << 21)
-        | (ind << 20) | (gpcsc << 14) | (vncr << 13) | (cm << 8)
-        | (s1ptw << 7) | (wnr << 6) | fsc;
+    uint32_t res = syn_set_ec(0, EC_GPC);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, GPC_ISS, S2PTW, s2ptw);
+    res = FIELD_DP32(res, GPC_ISS, InD, ind);
+    res = FIELD_DP32(res, GPC_ISS, GPCSC, gpcsc);
+    res = FIELD_DP32(res, GPC_ISS, VNCR, vncr);
+    res = FIELD_DP32(res, GPC_ISS, CM, cm);
+    res = FIELD_DP32(res, GPC_ISS, S1PTW, s1ptw);
+    res = FIELD_DP32(res, GPC_ISS, WnR, wnr);
+    res = FIELD_DP32(res, GPC_ISS, xFSC, fsc);
+
+    return res;
 }
 
 static inline uint32_t syn_insn_abort(int same_el, int ea, int s1ptw, int fsc)
-- 
2.47.3

