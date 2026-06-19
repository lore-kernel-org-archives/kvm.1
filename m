Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57AE39099A
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 13:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781874343; cv=none; b=nj0yqV5kvSGCusTG9OEsTdv/33OGPvZLN5fFzcCjXuyWfRVKEcV5q2z8jtY3JJzmJwn1+NypXOAVqj1qDOZLB+GceOZVUYQlJaahku5ajrW/QMN3EWe4uk2Y2Y0xDEdRXrneWFNiovzt5FSwYusAaFFlqBVJFv/8ArXuqU/Uc+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781874343; c=relaxed/simple;
	bh=sAAAPauK3dvFEkGnoeg5l/27xpBnHHTLAFA25BAS8Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pvwIkCinzkvOxUMxxCHy7OjC0gzncEnJsraS31iQjOoZ8eis3rjWLDuOe08k/otbvV63/mn2ZMXSOlT7HNZ8c9dODTg/P0i2vtu1HOzNT3J9/CkeNXhJjpgQvSUE/nlzb6QqoV0N/O2ez/P8uyxwS7HBoscang2g7wOfDOSD6gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=li7m5qDE; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="li7m5qDE"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c0be5e548a4so44466566b.3
        for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 06:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781874340; x=1782479140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SE+r4wGFd7f55RWtkYqXbt9/MkUiYQSeM/Vm+Litt3k=;
        b=li7m5qDEk5JZrA9zdJK0Rkx2bBqaJWRcbL3er0h7G6a6fhBF0OQiJjpjITY7+bYGXe
         g5l0Yyt8sH4VjP29ONxzeedW/cae51CoaTGNu4Z4OXeSTI2ljfPF++mlNONeEJe3loeu
         KNfB+XdOt7zUFiTSVJ+6z0xniTTMfCNU59J8c8SpnYcCcHmERY5oSNXhAkKspANcBF1h
         nQbqtzhzb1eJtf7bySHGQYh0X795fIyrhE4k8NGz+2DYEJEhJXu14yv2tewvoovXbsQq
         bI/LivbJSqlJeOwO3dYMlrHEnVbNPhDHCVDVuCNl6tcbLYCuvohIFNuHtnrCwL+20t1M
         LjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781874340; x=1782479140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SE+r4wGFd7f55RWtkYqXbt9/MkUiYQSeM/Vm+Litt3k=;
        b=ZQLzlfnq5zPgS7GxCx26r/8mPObSsL/GY4d2/0LOZPZBXxmFjpORnsRs15BHNdoXgL
         Btqp1nuAXMt4NIC9WJUpTiDggWZNmSo2PM67lVNKG0K/pfdoD9HKvRUpr2IgNmEpm0IJ
         TLdjRKVSv2iRdk5Be9ckU5gC945OuQB9iWwZMt42Zr0AqUtkq7xDoEQtjZybx/MVKuD7
         XnxCMMSwGD3d5JRxTs+eKxP1YT/TSmnX50EZM3Ulnfg+Eh7eyw+F7ea7Wh7gM+di1wYy
         SOgYwURrIuMgPRKpGuXCxgE/6Dmg88d2eID0PhLIbGiXzSpa51uAUx5RNkCfN2k7D5FF
         PI7w==
X-Forwarded-Encrypted: i=1; AFNElJ8Zz1XTpn/oWYkSePuqPf5v1UUIBQZlWIiZ8loK0iGYmnKwYuGeq+8Idj5sIJIbhXCopWs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx3B9j8MxG+ajd5nG5WgtTSh/wbdlm0GYJKa/kWiX+trKdckGm
	sJGUVtWABTDeIsPP8AnXweOkkrTHkaPGCMCztvZKczLIguByRL09rOCzucqdxcGxZGY=
X-Gm-Gg: AfdE7cnW9wv16h3ofmdancXmi+HjfW6raM1gDt5zBWpALIt7WCQhdYwacasmw0uzZp7
	E8/NsZfGIMX7Fqhphk6PvwKfqWOU1hpgQvA/brFNY+hPbEddop6b7Jl2enR98w9wv4gJnaOB/+x
	E9fsNNJHKoNHxQGWbDO3Zj7kbTJiwn7hriVMMGlRDVgWtfglRXRXs7cwkp/fsdrC/k5Q/vJqiFF
	O0arx2wQ4+dU1NEre5FtdmWkR8TBEsnVJOY/izwOwZ1vRKL0sAKH+OCjmcDt6PmCLstR7BhxFBy
	DwpI/nKWVeNPyT1I3lo5qcPvZxcL13ix19mo8ABS8CPXS2IrR4LJI9Xx2m3S0LWx00dLXoDTUZJ
	mVDVR7yq7WibPj1uZF+9eu47mZKvvg2csYXH9VxNRTrgLIXIunvYSdAenMSWmp0W9Pw8dEPRQLy
	Jtuv2XmTd2ujpQOFS6RTHxv60=
X-Received: by 2002:a17:907:94c2:b0:c05:84b7:550d with SMTP id a640c23a62f3a-c097ceba8f0mr182145466b.43.1781874340116;
        Fri, 19 Jun 2026 06:05:40 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4650b67a253sm8064924f8f.23.2026.06.19.06.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 06:05:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id A1FC85F94E;
	Fri, 19 Jun 2026 14:05:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Jamin Lin <jamin_lin@aspeedtech.com>,
	Steven Lee <steven_lee@aspeedtech.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Joel Stanley <joel@jms.id.au>,
	qemu-arm@nongnu.org,
	Troy Lee <leetroy@gmail.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	Kane Chen <kane_chen@aspeedtech.com>,
	Tyrone Ting <kfting@nuvoton.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	kvm@vger.kernel.org,
	Hao Wu <wuhaotsh@google.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v8 4/7] target/arm: ensure we create the wxft_timer for all modes
Date: Fri, 19 Jun 2026 14:05:33 +0100
Message-ID: <20260619130537.820184-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619130537.820184-1-alex.bennee@linaro.org>
References: <20260619130537.820184-1-alex.bennee@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We don't want to just use it for timeouts as we will calculate which
will comes first. Remove the wxft feature test in favour of the
broader architecture checks.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v8
  - new commit
---
 target/arm/cpu.h | 2 +-
 target/arm/cpu.c | 9 ++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 31a5567c951..8aa7437a397 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -966,7 +966,7 @@ struct ArchCPU {
      * pmu_op_finish() - it does not need other handling during migration
      */
     QEMUTimer *pmu_timer;
-    /* Timer used for WFxT timeouts */
+    /* Timer used for WFxT timeouts OR event stream events */
     QEMUTimer *wfxt_timer;
 
     /* GPIO outputs for generic timer */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 597e0626e7f..61945b6e6cc 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2269,7 +2269,14 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
 #ifndef CONFIG_USER_ONLY
-    if (tcg_enabled() && cpu_isar_feature(aa64_wfxt, cpu)) {
+    /*
+     * We use the wfxt_timer for timeouts and event stream so we
+     * enable from V6K up. There is no event stream on M-profile.
+     */
+    if (tcg_enabled() &&
+        (arm_feature(env, ARM_FEATURE_V6K) ||
+         arm_feature(env, ARM_FEATURE_V7) ||
+         arm_feature(env, ARM_FEATURE_V8))) {
         cpu->wfxt_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                        arm_wfxt_timer_cb, cpu);
     }
-- 
2.47.3

