Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2887826A1CF
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 05:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773378531; cv=none; b=l6549iLIuDl6TSVrPf1H182oZSkqCRVVlG4yH3fJEFpCB8kN3kC14Cacd/+mG0tmQWa/dMh4HamxlAoCuvUguvg1AXnoMzyfAToSJBweO/v/UVMWHehTcRKDb2TrsQPtdJ7VE35TDkd4sOCenMuTMsZOeVu05RLQLHn+yh4CBxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773378531; c=relaxed/simple;
	bh=vaKELfWZC5xhesUw1UiGjOM9BWBKGCwoJffEqSQINVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WW/T2lMsGIos468/Fvd9JvT5jB+w/K+EUduvxX5z601IXrP5iv02EK85bDbYsWIyUeg76Zavb2kXOB12FlBg2v7iGsW5ou9SghuFqtqWmM6VIlkp/aFV6GsRGxREq/BEWHX+OxemKkil3CADOHNx6223ZYcsWcojc+i2aUaDL3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUgf5VhB; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUgf5VhB"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c73e9e4cdf7so126737a12.2
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 22:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773378529; x=1773983329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uzQ3COQsCj6zOmna9aJpJTAQZrhsSwqcOS9nnDAte7Q=;
        b=FUgf5VhBNIvvoESt1PFrNQYa7koeXoPWm+b6rnNStZ7V7DNc8WPTgTdXHdAEvWsPcd
         O8TCcHRQ9WU4KtwlZQwOtn2RXWc3u93RoSywMznCdx3bcfcjLE9sdlaJiHRGQOBePIqx
         Zuyq33+7ONd2sSSCBQMaozgVOxvP13owH2wPyt7aLrzlBNfh44hYCttsR29SxonKHgB+
         TLoEKrkU71ryhydc4i2INVfgUuyRykyc2IkF6M07hl3FiSzDuY0+Jw1DPPtjQjmX53U7
         rCamOg8tF+CCMtxK5rA8/r37QhFW3yYPFj6dPYbFA56QbydJnjWlr+ujNGtFNDNlBjQG
         sGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773378529; x=1773983329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzQ3COQsCj6zOmna9aJpJTAQZrhsSwqcOS9nnDAte7Q=;
        b=WSn6NFeQYCRDAfX13TCGL3pxDa+SU5sqaVHngBV8d+KmzIczyBTuDuE0U+u7uhBPaC
         qi7ol+uZF1mzHqd6/FtjoEiimEPgsRLmYaZpjCWs/bKWeMmYiSnc9vzaPWzzcp+XGdXm
         BQCig89gNos74OlC3tpZeaUNpfnS9afDmL/fUHnYzl6FisGX4a+lhAHaQB/3Ws2oNPA7
         cOl41M3sqSv2e87nVzzCL097t454y/Ll1o/+qnRDYXhcFRLlVDVAmbzm5Z1yjt2ZayP+
         11SIUARpe8rXKTX4IHMGoDQ4RaFFVDrMm0u+a2LB6uAumkrRtCZo9RPIXc2ZfJsOIhGt
         KRZg==
X-Forwarded-Encrypted: i=1; AJvYcCXwt5kWcxO3+LaTcjwvxHdFFeZp2zDA9HmNuL1itAeclYRZMTr3Mo95x4SZYNR0zjY6XEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXMWcHp3K15TSDUgQBQHQFVukNnHgAmDoNUK9OPsSNtnvqspcw
	14UPnROJlO+xu2MjjaeijDOrOjhACBKq76iSzP5xn1H42JhEtTZ48sFW
X-Gm-Gg: ATEYQzwA5eXhjFGZhqATFaKjpb4RMzTItYsYN1oeGWklUzG4/DUFV9jaqAJAGj/T3Go
	Pnzrv5rLikxPEHEBROvBwai2B/Alpm8oZ3BXO+0aH6BrgSpOz6uh+SS7dtdalAgv4mxEJR+OmzL
	JCjEarbt9ZbmVhsq9Yx5qXEySMyrFuBHED3+4f9R7mpGtdD7TqkzEOFV3hX4Qgdf6eXIswi+sLW
	a1zUXriZgmHJlDJ4L4+Yu1Sl0Dkld2XkshOweH3mb7w6Nxgt1DbIHdGC4IA9WpuxgUjBcSSpFyR
	WQigIe8EflM6SBaGnuh6hBJe6xmO5kHesX3z7TYdVkZlRHkZxYUxB3116XsFqVM9pr4x+h93NHX
	uxfo622VwAeSiHcd0LFOW+W27rV/DEF5pbux4Z17ujRgk14y3Kg5QhU6HvRvovqKwbUxUPctrdB
	hVkbDxRHCTVMk+1lhEHhPFaM/u/8+0KQzcAFto/+L8UYPgOnjg4c3WlGRtFTzdoVDdjZAf
X-Received: by 2002:a05:6a21:6190:b0:395:7fb:9362 with SMTP id adf61e73a8af0-398eca9d72dmr1654010637.19.1773378529484;
        Thu, 12 Mar 2026 22:08:49 -0700 (PDT)
Received: from lima-default (103.95.112.190.qld.leaptel.network. [103.95.112.190])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73eb97a1d7sm676221a12.6.2026.03.12.22.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 22:08:48 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Andrew Jones <andrew.jones@linux.dev>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	opensbi@lists.infradead.org
Subject: [kvm-unit-tests PATCH 1/2] riscv: sbi: dbtr: fix enable trigger return code check
Date: Fri, 13 Mar 2026 15:08:30 +1000
Message-ID: <20260313050831.4016944-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enabling triggers that are not mapped to a HW debug trigger
should return SBI_ERR_INVALID_PARAM.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 riscv/sbi-dbtr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/riscv/sbi-dbtr.c b/riscv/sbi-dbtr.c
index 129f79b8..489242b0 100644
--- a/riscv/sbi-dbtr.c
+++ b/riscv/sbi-dbtr.c
@@ -744,7 +744,7 @@ static void dbtr_test_uninstall_enable(struct sbi_dbtr_shmem_entry *shmem, enum
 	dbtr_uninstall_trigger();
 
 	ret = sbi_debug_enable_triggers(0, 1);
-	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_enable_triggers");
+	sbiret_report_error(&ret, SBI_ERR_INVALID_PARAM, "sbi_debug_enable_triggers");
 
 	install_exception_handler(EXC_BREAKPOINT, dbtr_exception_handler);
 
-- 
2.51.0

