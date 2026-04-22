Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841D33CD8D4
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 10:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776852656; cv=none; b=UswYWVhzH27iz5rM55viVYqZuRBGtC+++gxNWco1JKl5ZaS+TNXuRj9FBmt4bFTjeqtI7gphG4HqQ7288W5nVJEpekDgfnUnH/Z/z+dBG3WPy3x8kNNk0LDRduHUgldSQjR+KHg9Au1kdoOf1T6FHJI1lLh99N/V3vKIw7Ps/ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776852656; c=relaxed/simple;
	bh=I74ngpgJdGFCGwvTHiD1IdLZCW7KJU87muANcBYteRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oD8W/IIuDKsq+ZioT+0UVnVDVlhIlnpbnTuwaQrL2qL0yeO6YNXlIfjOA0v/pXyZRMKlv3SSGmDsEMcwfKQSNkcHZV1FkzVbQzITF7sVk0TCfQ0l52hIigmuFao70qLCj6VQk9+DKPqoegGWsfskOuKIjOmtu6a2w6FykjuG3EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KEi0l+vN; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KEi0l+vN"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488ad135063so45768825e9.0
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 03:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776852653; x=1777457453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAtQqYAVHVvhu80r9xI/PSbLS4M6sLMvc1JPbP3qMzs=;
        b=KEi0l+vNQJwQVpv9nK0x6uc05hGV9jpD8VsMZBQEuZJuieKDKkEbr6JJWEs3eHWius
         X/FUWnfzmfOazojtc75GuNZRb2Axp/S7Qz6zqOvflUxFAfTTCKXhO0rZ5Cy7MET25sop
         1GxcmTt/trabLQuuKLwdwJ7m8YsuHaUVuEYfS3WXph7fuaQy5PEXvNPSujYZz00laGbf
         PvTifxOLyzb3PiNerxY4D40/B2ghBwLKu7oZG0BS1IaVGyQzGu3gCON/7dyCArO2Akfi
         1HbJhog+k8oKtanX9vU1JNI65r4cchlnDN06qsj3ipD/kAxAhMw0ri9iS3LtllASY7pL
         amZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776852653; x=1777457453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EAtQqYAVHVvhu80r9xI/PSbLS4M6sLMvc1JPbP3qMzs=;
        b=aOOgwfrA38KWlfY6wXe/Sw9xOVI0J7VRI8pS5L5jJy5rafu8XMbwMCAg+X7oJTzmNN
         G89K29lojPitB4ST2OrQg7/L+K34HFkRoiRezD1MBj3sqcbhLO/Itgd/T6YCalpMkQEL
         EU2zzSrBncGAZS9XIfnbonFxB8WzlnFdpnASIWQ1O4xPawHwdWuM3GANAV3HOtIoDDWB
         9+UQ5xojQzInPN1MvWzv15YtzOcrC4pDzNNWgHaSfwOmzKCzg/qOMv4BVosyotuMw2Ff
         I3wWLSxv+qDVA6xdiuXCQvUdj8CEFnaMr2aDl0Dv3k5imMgQvg63yQQd0TDIVzR2fZoF
         ThoQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Zq2BNqR3gh/0bRzWBvx9Cp9r3wMG8CADS6uc0xiHG6haQultOY6itKparqkpF9ljmmWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyuP/Mxh5WnFJgu5g48T17zkM/1UP/uY6YemS93QeIgOf/j8Fn
	g393bLdB/P/lhHXfGHXIbKAqA2Q6L3DVBCioJnnWW8OvQjqtLzQX9JUWO1XHhcnuRyk=
X-Gm-Gg: AeBDieue/nOK9dIaH3m2YvzDW0GAgLE+NtMucGEXNbWc7xXW9461/wA8KLwjjJZBET8
	MBXZPvGV0oml0VWNN6ceVUxyqizvVNhGBgDYXb5pMgWlvMGm6RAVSz9iTlQ8TiiRY8VHeZLHKIL
	FR4Gq/HKes7XFmMIpjWsZkAczWMI0uGtBybVqubJSjbBtHiD5D5P0FUFzv+JuEeUDSjwwmOgxiO
	ih517Nh/F8CDLyVSannX7OZQKvHTvRRDC5gPlVUPQ/In7wrIgQUNiQKvgvx12xR9pfLJXKEZ/kC
	w5f8J1fqioAuRmYmI5CyFMTvSgrlWOKKEeS5DAXChgevh2CXsoru3oQ8VONwhrMqD17f+kvhtTn
	clnLZMuOsKpTH6QwzExOHT7kwOF5m7Vw7M/fJLrbTnZD9/K0YZtzBYEXKUJX+Kpe4ECD7eFwKAm
	2nTTXVUGzZiOhit6JPpxMJenqIyzIaDlmlEosIbV+UbDVG
X-Received: by 2002:a05:600c:8909:b0:489:1b10:d896 with SMTP id 5b1f17b1804b1-4891b10dd45mr174107775e9.0.1776852652830;
        Wed, 22 Apr 2026 03:10:52 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ffc558f2sm296321775e9.1.2026.04.22.03.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 03:10:48 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 0180F608C6;
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
Subject: [PATCH v2 07/31] target/arm: migrate BTI trap syndromes to registerfields
Date: Wed, 22 Apr 2026 11:10:18 +0100
Message-ID: <20260422101043.1234229-8-alex.bennee@linaro.org>
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
 target/arm/syndrome.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index fd8639d4f07..52a6745cb23 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -426,9 +426,18 @@ static inline uint32_t syn_pactrap(void)
     return res;
 }
 
+/*
+ * ISS encoding for an exception from a Branch Target Identification
+ * instruction.
+ */
+FIELD(BTI_ISS, BTYPE, 0, 2)
+
 static inline uint32_t syn_btitrap(int btype)
 {
-    return (EC_BTITRAP << ARM_EL_EC_SHIFT) | ARM_EL_IL | btype;
+    uint32_t res = syn_set_ec(0, EC_BTITRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+    res = FIELD_DP32(res, BTI_ISS, BTYPE, btype);
+    return res;
 }
 
 static inline uint32_t syn_bxjtrap(int cv, int cond, int rm)
-- 
2.47.3

