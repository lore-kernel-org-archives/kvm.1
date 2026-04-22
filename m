Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8FE3CEB91
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776852660; cv=none; b=To18q6SaXfKkIYSUHfp2oJecVy7WYS9R+1Wql9IPuhusrINdElxZ7ugke69UbK3+8ZWO8SaQmYUu1FK5mPqTDk1NI9RFqdIfQkiEeyWyjGVZjJOmAHUeVro1TnA7/mU4NkD5uT5eHuF2E/Bq3UxGSr65SBiQ/MfpyyqFIgkYRmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776852660; c=relaxed/simple;
	bh=r6G7A3H4PQ9qziC8KwDFiCMnFLOFgzctZsk6jMHAt+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZAa3+oSefuXuGn30JJXSiUUPwEKwfL6GQ5InccLV73AZcCDdGIZeCSp2305bHgYKwz87OZoJnH08WDE5zIJN9s3O5Ag2uyxBNxu+y55UEuNmuk0qvAnEXmUVFRUSx7htLLY7RQnNH34qiLuzplb7a6Cu+f5Yf5y9f3Je+LCKta0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p7bOq5ot; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p7bOq5ot"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso54077295e9.1
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 03:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776852657; x=1777457457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fpr3Ng7R6+bvHtx79oLF5EYo5OylKP6gzyU2DP/N60=;
        b=p7bOq5othQmTCnjfFSfCC6DQqO2EwX8QnOItGtqtoNs8wpLXoYCAnw5JbyzGI5CXJR
         2SyR66UsDQAka18QK72QFqE7y4DoRRy0ZXJA9rfwfuAQp1eNiHNvqLlBPTFJmVWnK6lU
         L9I+0MVQGlX8y0MbPQose2VeYpdp3Jd9iXjqXPmwZlFLT0u8EMk4hSs/puI2TrtwkF3p
         i7becmgK9F3BZYts1TQX3Gnd+6qBD7j2/Q1pPXoF/Ht0y5b4BaSKXAlHsME73Aym4zdX
         1Desmv+doqFxA/PpX9M4FkyvR5HW73UISt5JzoImuLxXUpRItW+azSboVfYMxOcmLO4b
         5B0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776852657; x=1777457457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9fpr3Ng7R6+bvHtx79oLF5EYo5OylKP6gzyU2DP/N60=;
        b=bxZlQsmQrvN505m7qq1mYvpmbYI8w0oR8JeGOADz3Sz2afiR9+b6XF0WX6JpjvAwyU
         mhiYHPzETiYNSAEHN+7NWjF6qYVtAyWfdyzEJcIWSU8H6sbcEQacjl/LhCaR+GeUvEa8
         htzceEyw09rQTtnDKWL0eM/1Z7IbJfMnXTzvVU1kK0ZJOpOkiss2o/TCE1Emlud8SbbV
         qAInJzAAMURap2Z6sjt0p6SAiv1VDlzD6EY9y8Is45ejB3faC8co0G/zigZXvUEkzni5
         bTXeoXCEKgP9+c/6sOsF1VPiKBFTRygHgKkcjEqFVFrhOB5I3aBRlFHxlOSW/JBqysSw
         Ub2w==
X-Forwarded-Encrypted: i=1; AFNElJ9nfZb8uuctCcRAOSL79tMSYt0oHJFt3+m/CbmGvawJO02VFAfUFsJYLKwe1GSnbbdNr4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/tNVqjYHLivmyJdROyFtWm29cm6daG/hXfozv35JOz/c5Sr26
	qOPcESEtHQNBU3/WCWvGca/4jn7k1FfZ2DuqNWQiF9ViEPt/DIzbALd4z6gb5LHEbDw=
X-Gm-Gg: AeBDievsmVwAPIx/IbBqEYVgFw2tUBuHkthaUDF8gd56g5ZYIwyWdAWf+QprQ1aHrEV
	jHQ3bbQk9K2WwZ98/eWyQgfzUSk7iYCqUHP1pLcgjOT8rrIpzixFx69x7f2zJJkgCLo9Q8VE/g7
	4vtCvLLnChLJaxlnAVeWkVphV4S7uMMTsy0e1oT9JZHPC2o3wx+z6dIw7q3WC0GKL6xE6pBMPdh
	ESZIsSUtHqeuYMlmq3oHEhijdXOP1+abSU+VpyeD9wJOM4gg01IJqjYMmppFWWmX7n8tSv80tjw
	V9JHdTYg/T53ZcFQxL21sSnb1tYmuZBDIEZ0bolhBXrFpZ6KKqmvmpQLDAlM8NXtmOh5/7O0mgK
	ZmQl/wuHfsGHTfYMPww3PcwtX5LmDD7Z6Jenqh2bNFG03sw+wO9HsHhFRtZ6d1iJvTMikoRduJo
	OzuATlKsqvu6JDAz/IQcplrlu5uekSC3GBwfgv31eOaRkz
X-Received: by 2002:a05:600c:6990:b0:48a:5970:1fe1 with SMTP id 5b1f17b1804b1-48a597021eamr47506875e9.4.1776852657303;
        Wed, 22 Apr 2026 03:10:57 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1393f5sm410402795e9.9.2026.04.22.03.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 03:10:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id B1380610BC;
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
Subject: [PATCH v2 16/31] target/arm: use syndrome helpers in arm_cpu_do_interrupt_aarch32_hyp
Date: Wed, 22 Apr 2026 11:10:27 +0100
Message-ID: <20260422101043.1234229-17-alex.bennee@linaro.org>
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

One more step towards dropping the old #defines.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - drop excess brackets
---
 target/arm/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7389f2988c4..40dd070d2c1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8898,9 +8898,9 @@ static void arm_cpu_do_interrupt_aarch32_hyp(CPUState *cs)
              */
             if (cs->exception_index == EXCP_PREFETCH_ABORT ||
                 (cs->exception_index == EXCP_DATA_ABORT &&
-                 !(env->exception.syndrome & ARM_EL_ISV)) ||
+                 !FIELD_EX32(env->exception.syndrome, SYNDROME, IL)) ||
                 syn_get_ec(env->exception.syndrome) == EC_UNCATEGORIZED) {
-                env->exception.syndrome &= ~ARM_EL_IL;
+                env->exception.syndrome = FIELD_DP32(env->exception.syndrome, SYNDROME, IL, 0);
             }
         }
         env->cp15.esr_el[2] = env->exception.syndrome;
-- 
2.47.3

