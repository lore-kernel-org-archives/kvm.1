Received: from mail-ot1-f73.google.com (mail-ot1-f73.google.com [209.85.210.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E88C3AE1AF
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 19:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781292562; cv=none; b=OIC39Iv5J2kkZxsqXW1g5haQg49nJ8tgpKMeQm/8cGnvMdGmJVYGtx9IgQcPiVM4Jb7Ieude5gxZbAHCC3tUljhFBoEmvnb6u4QJws8+XxvmoX0oxvlm2rQYPlAUhun36Zs6VZvBahV/Y7+Kj/BGER2Jixy0YJIQ3unL1RBRmQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781292562; c=relaxed/simple;
	bh=06yjw3p+ipuRaTZAWCI5G1pBBjTnmA793yGUK4DpqJU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jwtkLr6oyj66HNsri0mww7ki3ISPFyZttaLmYefQD+S/DmijM6zRVrXAFkzEI5VyqtbI08LLfN14Znj9NopQE7gYmHUZ6gH4E1FHJdKiBb5HW7gLIlShDCVP9/yMJKRrjbutFFFHe4wScLypjSLuRUJrIZJXRh1OrE7ndbgmQR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qt4zRkD3; arc=none smtp.client-ip=209.85.210.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qt4zRkD3"
Received: by mail-ot1-f73.google.com with SMTP id 46e09a7af769-7e6f01486a0so2427065a34.2
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 12:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781292555; x=1781897355; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2M2UIoQTEUhWBAO6CcMuiUQsYo7FQeN0Fuvmz5eDMgU=;
        b=qt4zRkD3P79O7CMpCSgk2omvpeByXpgYK9BDRDYhwAC8+FHRR8aGBq7LgT2OwxcuoU
         PwPKAiPPDUmcZyakBXMBHt5xbzkAyuwYYVR388mFOdByzJkudKL3psOSscsWulusiIOC
         Br8SXVene6LB43AzjyN7JDdft61KRpCxslVBWRa3ZsAduCrt3p4ztm3NNtAZZiu3ipQX
         3j+2fq85DkWaFF/y34kN5cpPYuATR3h8HakRWBcVgHlzN9iZDoCOspsFGGOjpslvcipm
         FgrQUGSgAcntqR6Txf4LGNcWg0mkC9dNcAHrz0JEh04lpgLotX6ynmO59E2pEn09Riwl
         B4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781292555; x=1781897355;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2M2UIoQTEUhWBAO6CcMuiUQsYo7FQeN0Fuvmz5eDMgU=;
        b=B2CJRWCFUmJVXcoW4KKkxYJrVGQfqXjgVR7Vxjx6WTgF3mDyRb9w0QcS96x4VmqN5+
         MXMmMNgO3O2W0TH9MjNDibupsTUy5CDJo61XIu97Rpb4JAQ5qx/oMReNugKxFY2ncbc/
         VMV+3+nzFpoMtSNF+hOAXOifVDrFuIgBIG90zyxJagC7nt88cMpMtAwpcnr4D7Q/ARsX
         K+dv9p6ViOEz4QpBGXZmNDUlXA6NRcv7Ywiy3HvC7gzHafUssmpT4+OlZ4Z1tYQWQYtU
         8D+Q0xdwEgSPUNCLTUME5FKmxTv5SFa6qc3CSwt/niLJqA4z7aEOWk/6mgBnoHFtj5SZ
         vcKQ==
X-Gm-Message-State: AOJu0Yz07Ye0qlt8wbnbUtssxSFxQAHVCNS0OQxut1bwAl4ypEVjje8H
	17E4/wQC8bomKLp30mcT2Jr8qssmv6ciR9Pg/Au36yOaY6tdzmeH/EY5IeCoo4iP9QCb8Z1EJ25
	uc2JTdrHpb7zKt5s/toay1AxngkfV8u7iUMzNwAvdVW/+tb3LALpdTRgQHCj696NT0jP/Kdaq1u
	FMIVxGdl7nJIczrHmRJuTxnkti+Xx+DwV6NWbGLChSGOXSkjtlrDX9dydo/y4=
X-Received: from ilbdw10-n1.prod.google.com ([2002:a05:6e02:410a:10b0:502:1132:3db9])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1920:b0:479:e7c7:dc76 with SMTP id 5614622812f47-4872f4bc1a3mr2488426b6e.26.1781292554890;
 Fri, 12 Jun 2026 12:29:14 -0700 (PDT)
Date: Fri, 12 Jun 2026 19:28:53 +0000
In-Reply-To: <20260612192909.1153907-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612192909.1153907-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612192909.1153907-6-coltonlewis@google.com>
Subject: [PATCH 05/21] perf: arm_pmuv3: Check cntr_mask before using pmccntr
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Alexandru Elisei <alexandru.elisei@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Mingwei Zhang <mizhang@google.com>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Shuah Khan <shuah@kernel.org>, Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, 
	James Clark <james.clark@linaro.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Check cntr_mask before using pmccntr to ensure it's available. With a
partitioned PMU, there may be instances where pmccntr is being used by
the guest and will be absent from cntr_mask.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 drivers/perf/arm_pmuv3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 1cceb1f614515..17bb1cfdc271c 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -1028,7 +1028,8 @@ static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
 
 	/* Always prefer to place a cycle counter into the cycle counter. */
 	if (armv8pmu_can_use_pmccntr(cpuc, event)) {
-		if (!test_and_set_bit(ARMV8_PMU_CYCLE_IDX, cpuc->used_mask))
+		if (test_bit(ARMV8_PMU_CYCLE_IDX, cpu_pmu->cntr_mask) &&
+		    !test_and_set_bit(ARMV8_PMU_CYCLE_IDX, cpuc->used_mask))
 			return ARMV8_PMU_CYCLE_IDX;
 		else if (armv8pmu_event_is_64bit(event) &&
 			   armv8pmu_event_want_user_access(event) &&
-- 
2.54.0.1136.gdb2ca164c4-goog

