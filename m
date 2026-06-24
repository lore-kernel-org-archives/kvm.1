Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A095695
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 10:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782297056; cv=none; b=YmdjnPlosgmWtnonfEqlifpiRJjFCQ6gPqM2ydFp8tDghwtQKdckBt2Evuw4OaMrUOqL9O5nCgu9/ml4DoBKN9LCJTXCrCGhQ31C541rO7a5clmNCC6jYfsOqXukpklkM5sM6fzgaXSpf/yDEi32Jk91gY+Rs6qWGMzzfXuh9Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782297056; c=relaxed/simple;
	bh=ylk1fCs1vCvu2L68g/BWVBLxUnapwzSIJHwWP9bfCjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJikaQjHP3dhZpqOoRP2AWJM2D3ppqeKwOhp2fvXsy13L4iqXt4xbUaf5wJ1XelZRQ+Ogutq+x8c3y/aJIvUKoYzTMmFKkDoOo22RdpotFYVf7khatYG3d0Gh5GxmRrx7oystDRq/SzsTzTr+H40KRo61GT5vWhN1EUfs0JPDDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hEQtHngB; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hEQtHngB"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-491609cdd8fso5395795e9.2
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 03:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1782297053; x=1782901853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjZZZ37o2qWFDzuAadl19N3XteHI/O+LzeoigkNZWL0=;
        b=hEQtHngBzRRYnAn7KDLRaznzRPmEXHuyQ8upS8ytn6+9XD2XXDGrRO0xeRNl5kMsC4
         50YIJOU6+ty92q6rH6wAOgigyObI6Tq13mlhApHqGffQ0BUVH3jot8GUOsnb7Y+OgUpX
         sewdkC4vEV8ckUIGXMIjitk1GTdZQkIqNYbFyay3IAA70/Y6XlSjtIBaU1RccPohs6P0
         PyP2Ka3+73eFkgd632k9Wwt80ithVRXyzu06ddzFJioUq3Obe/85ih9vduGNlJD2LhMj
         YE7ZjM6w00VrovxPeS+tIgLypKT2uIKtplSVsbCOc6Oq3T1TDgYhuE2Fo/LT1bTDYyYF
         iiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782297053; x=1782901853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jjZZZ37o2qWFDzuAadl19N3XteHI/O+LzeoigkNZWL0=;
        b=qMTvEb5ub0/Ws4OiggBvNtDkJJ3vLdLzJLBSnS8hd4YBNjoUGHOEbQKs3nJtmpAq5v
         7tNmOt9TZKSL+mu68MoEM6ZciTQX9zTZPEQpQgCCvFRPtVNCYTkUCjT60Cu3cUA4Euff
         dz6hIYfkAiXCBv8K6hd66LRdqEsEOZglaCik1WrxQEWPuRCCUpcsI+Eiggz4HjjoNw6f
         r9g4exs9Ql7E7AzKvwdh09gPuvWSP/KxHPPyWA03y3ykBHPiAkt9a/ofpgQDOcCu3ZHI
         l71Mt0GBL9/txanYWdBaOgynIRwfw5xIaMYZGLWeR3/dCNCeIPPVuL19K/ohhc9ogZbe
         dXJg==
X-Gm-Message-State: AOJu0YxnSJoKUVJNf/xRJcjh6rGdePh+Gk3tSNmEoAAMlC76qsAQguqd
	auT/Ix1VSyRjbR2u6Y2uBLTm0xh9HRm8nIqIJ5r8TMo6pirtUZFOLr1ODR/rGxlT5KQ=
X-Gm-Gg: AfdE7cmAgK8kYEibsbZPvmBXI6no5iRhCdMlj7y+peJP+2k79/1am7Cv856BKUNjH/H
	Go77nV5yQDiGFz6VrHPmpE+QX8dnHa9PeKUNuLujG8KAkZC/yKAkdMJiDNhWp+zKE8yNU7ZzuqP
	Aq+UCJnykCbx8rd6Ky/LHdni+RlzOJ7rh7LfZGacIa6d4+MBKq1hl2Ac5AwHRnaqOk+pP4zz5SY
	XOKQV1iNEB2bfZUtEnxCBEawBjEg8e7BVfxDl+O08Qzh2HlCsz5w/gzSvOUyWrMKkW60ofkxKy6
	onyiJMThu02oV6y3MgQlrMxy/OoQpiwddad+e9nMJfF2Fwxt324knqqnS0NJCVtiuL0i9UcA+rJ
	sneX6/VQh38R1J8TC5nlOCdJ7ZbCYhF8ezsgzg3T1aHl86e90J+9DvZndASBPGyRds1F4oFXSxR
	MFUWNTifx1G8TUXx9gu1XnPNw=
X-Received: by 2002:a05:600c:138e:b0:48f:d612:3c59 with SMTP id 5b1f17b1804b1-492608473c9mr39793925e9.9.1782297052531;
        Wed, 24 Jun 2026 03:30:52 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492494496d8sm360072245e9.9.2026.06.24.03.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 03:30:51 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 189955F9D4;
	Wed, 24 Jun 2026 11:30:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	Troy Lee <leetroy@gmail.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Hao Wu <wuhaotsh@google.com>,
	Kane Chen <kane_chen@aspeedtech.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Steven Lee <steven_lee@aspeedtech.com>,
	Joel Stanley <joel@jms.id.au>,
	Jamin Lin <jamin_lin@aspeedtech.com>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Tyrone Ting <kfting@nuvoton.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	qemu-arm@nongnu.org,
	Alexander Graf <agraf@csgraf.de>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v9 4/7] target/arm: ensure we create the wxft_timer for all modes
Date: Wed, 24 Jun 2026 11:30:46 +0100
Message-ID: <20260624103049.884930-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260624103049.884930-1-alex.bennee@linaro.org>
References: <20260624103049.884930-1-alex.bennee@linaro.org>
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
v9
  - we only need to check ARM_FEATURE_V6K as V7 and V8 imply it thanks
  to arm_cpu_propagate_feature_implications
v8
  - new commit
---
 target/arm/cpu.h | 2 +-
 target/arm/cpu.c | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

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
index 597e0626e7f..4b49f8c43ec 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2269,7 +2269,11 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
 #ifndef CONFIG_USER_ONLY
-    if (tcg_enabled() && cpu_isar_feature(aa64_wfxt, cpu)) {
+    /*
+     * We use the wfxt_timer for timeouts and event stream so we
+     * enable from V6K up. There is no event stream on M-profile.
+     */
+    if (tcg_enabled() && arm_feature(env, ARM_FEATURE_V6K)) {
         cpu->wfxt_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                        arm_wfxt_timer_cb, cpu);
     }
-- 
2.47.3

