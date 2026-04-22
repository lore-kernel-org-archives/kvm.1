Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846253CD8AE
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 10:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776853059; cv=none; b=MPQ1H3nSCk6K1lAmKR2Ke+ERyQ8QX67+o6mWgdZVXjh+9K7WYNhLYF85Z2yoEih5nn8cAUANg/KZkxxGj4vnGnJeUxc1kGJS3/d/dvC/fW8oJIcMSkV0tdZRJ7bJbM2q8p2m5StKMJQZGqHHyfpeVlq6Wz0L0wgpnG3rfUcg19Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776853059; c=relaxed/simple;
	bh=at7f5AKTH91oYlNvw3aVXQ96KLv8B399FbxI2NTz3tY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R3tgQsJ2KskCkkfxBX/TzCc7bkfllLBQ7dbMYbIqvErgTtxwWwMxy7X6GhP2XhzECWqM1fkJZGRPFJJAvXU4q1sJov2sLLgOlsLaeIQZT2IVicasF/4vKPc0+3tRq8CUT97h4qFWGNgUgKRqY0WjTGQzXajmBkk28RRBJrf/Dx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E9037WL/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E9037WL/"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4891cd41959so33540925e9.3
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 03:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776853054; x=1777457854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yq/bGIVh38nrtfwG2BReGAMOSU3dNrWCtccK7bpObt0=;
        b=E9037WL/w4YEGOCiQNNKYcTQJg3jSbJG027Ze1xIQOTVk54VtttMwURGjSIVNWVSbv
         HttEmsQQfsZcMZQG6a6dEAVKYbVSPG1hRA0cGCf29au/rD+Rjkq2y4fPnsKiFkpoA7mo
         qmASbGkFjQEBLEuGWvw9ZrGdPkTCuvZlb9ikuBZAvJG5Nh1Ol9Wjlrb6I+UOGsfY2bYi
         8F5NUhdjs/cjRoHD1JGBHjG6jo1gqgBc0ZPnDqL2XqCnl78VnS+zEkcHfIqTQLcKnPuK
         5WG4miXBsyh4tlCUEFfHPhEM7y43iY8Ha06nXSgMIpDCzo0Lta9tQc6te9sIRnrb+Z2I
         C/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776853054; x=1777457854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yq/bGIVh38nrtfwG2BReGAMOSU3dNrWCtccK7bpObt0=;
        b=fueJ3pn8uz0Xcs0fG+HlVJZy+mVGzU5mIKBecoq3ihBAjDVsrNV4RhQiUo18nJRqCQ
         hBXe2ixQewgQYQYifBvOSUTVMLrOzDs4217BVhiWHk/Cjx31rKlct1HDFypzq+ZbWaha
         bst7G2L+l8/eqCLJ4HQn0WYPjw00UebcFdSdkMl614dI5/Np2MhnxZal0wpNTPJueKTe
         Ba9YKq31hEmD1GFYueNDU0//fGomChcEuvQLZULbtleOhjPDgc6pUEGmp8GsPTEEnUHX
         LiP0fNUZwhixlOYnUUa/RsLtg+PvPtFdUJ31sd1hmT0dmy1G7vVnED/aUqlTGGiuXlcN
         8fjw==
X-Forwarded-Encrypted: i=1; AFNElJ8o1N3b77C4c08yZgaAWdKJnfphMy67uMIoSXgPQSrQ/gnLfQuTAuvwUA0m7iaIFef8bQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxon4Y6us1zN0f4essng7BiY+fFgT0Fqkev/cv2r5G80LaLHZDN
	YzGts0WU4o81Kx7QTGMZ+A+hOD/aN+u4pzjj3a10Id+/t6CZnGcVutbajnNMaYcK4JT+pr5CPeH
	edkLlJmM=
X-Gm-Gg: AeBDietnbf+sWWnp9TEyk1Xg/fUbjmZVRrPwaVZ7dbU8l0ub+1l0cL8iX8dkwpGDNz3
	9xmvJe5FVLLCZgwrIgD3TGdEkJQzTMPmg3SVwWLEwEA6w47ePXhRlZxsoSJUvi5wx3jj3UsRj/e
	2JsHJsbteWOkdJwuBSL7+clOauhV7HcjtMR56JCY6yUGeK+4uRD64E+9hcardGnqK0pgd4OaWex
	xlVZ22rw54WYTlRpvvUCAgFHjl948xgbOKA17OhPzcfZ1q3bgUNgHHNHt2IBQBQ/oDt+DtLG6bw
	1Qt4KqveEirggaJQz5DkUKMahI4LKmc7asrkS+4rislc8yV9pJZ6ZzTP+7uMzWVWxq9jM7XlFmJ
	4EGrN39isl1xiVyOYXld05CYXPztQzFSlF09o+Ee9qJLr6SQBGxsM6d0rBxFx3JrwC99iR6ZEWs
	jIvrkhrNLQcaScaH0CppW0emA4P+4boyoltA==
X-Received: by 2002:a05:600c:c0d5:b0:488:c683:be89 with SMTP id 5b1f17b1804b1-488fb74dffemr240575745e9.9.1776853053932;
        Wed, 22 Apr 2026 03:17:33 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a55dc9f58sm266237205e9.6.2026.04.22.03.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 03:17:33 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id E967F611CD;
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
Subject: [PATCH v2 19/31] target/arm: make hvf use syndrome helpers for decode
Date: Wed, 22 Apr 2026 11:10:30 +0100
Message-ID: <20260422101043.1234229-20-alex.bennee@linaro.org>
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

Rather than open coding a bunch of shifts and masks we can use the
syndrome definitions.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/hvf/hvf.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 5fc8f6bbbd9..1c1c31f0b15 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2123,14 +2123,14 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
         break;
     }
     case EC_DATAABORT: {
-        bool isv = syndrome & ARM_EL_ISV;
-        bool iswrite = (syndrome >> 6) & 1;
-        bool s1ptw = (syndrome >> 7) & 1;
-        bool sse = (syndrome >> 21) & 1;
-        uint32_t sas = (syndrome >> 22) & 3;
+        bool isv = FIELD_EX32(syndrome, DABORT_ISS, ISV);
+        bool iswrite = FIELD_EX32(syndrome, DABORT_ISS, WNR);
+        bool s1ptw = FIELD_EX32(syndrome, DABORT_ISS, S1PTW);
+        bool sse = FIELD_EX32(syndrome, DABORT_ISS, SSE);
+        uint32_t sas = FIELD_EX32(syndrome, DABORT_ISS, SAS);
         uint32_t len = 1 << sas;
-        uint32_t srt = (syndrome >> 16) & 0x1f;
-        uint32_t cm = (syndrome >> 8) & 0x1;
+        uint32_t srt = FIELD_EX32(syndrome, DABORT_ISS, SRT);
+        uint32_t cm = FIELD_EX32(syndrome, DABORT_ISS, CM);
         uint64_t val = 0;
         uint64_t ipa = excp->physical_address;
         AddressSpace *as = cpu_get_address_space(cpu, ARMASIdx_NS);
-- 
2.47.3

