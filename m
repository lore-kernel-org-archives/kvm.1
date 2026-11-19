Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114343;
	b=SCBu7CxMMrbK9a26dJLkV7dSu6qA03FQl3COo7lxFDGAW8tCR+5ZLmu8QwgxaQKAV9ZS
	 ZBJkfKraY4QB3m+FeS/AQsaFxkaw9apxRID9YL+sPjAtgPQTS/+iB++np7Ho0NPf73yrD
	 FKCu+62zRVlV1qfpMA167rp/KCIYthX4ZkVYM75DBOgl4KzokWNflDvls826uBxzSk26E
	 YeRUoW1hyJ19GUH/+YRG90oMrVo2fnYyoJS0Lxw/+mhGR4xZNXySdckEAOrlBVyQVZWiK
	 DU0krbGnXqmmo33S3kQ3QG0XWd5WUAmyfZIkeOQ95B/x1IuS93i0r1fKc249c55wCZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114343;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=B71Ljk+UIM1gXp9I8DKkVnuHdcZAuyllvZTiO1ZgbS8=;
	b=xmhY7o1OdkPcZcGPemWnFCQ5QiJUqyV+I6hMFiG1Cle/V/vKGXpGSSpe/Z12ssnnyrFR
	 7u4KnXhk1qD3KQ1BngQDtBWfHJEY5j4UglMgSuhFF7VStn8O6l3v/wHlmAhHa1yBdaQhG
	 aw2PUKreZVPsQYfVR4CiuggDbFl0f7W+yZaXdLNxQwIdZSJQieQqNFD3OVoUxGRR8xj7j
	 18lKvR4lxb6cI3FTziL7B9109rfAEd3oLYmcW9gAbZ/Flbt1ehh6h9NzUCoDVJTSNtUUj
	 lsZistwfI+N8iEVmb0oPVQ5jyrrpJ2qZSC8taeSXIR/govsfFQQsC8ujXWpg2EJP35g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JDc5VL2p;
	arc=none smtp.remote-ip=209.85.210.72
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BB260A5BC6
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 18:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2BB260A5BC6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JDc5VL2p
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-8628955a085so130570a34.3
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 10:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795114342; x=1795719142; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B71Ljk+UIM1gXp9I8DKkVnuHdcZAuyllvZTiO1ZgbS8=;
        b=JDc5VL2p9dsiAaKT2+JRAfSnNDFqtxp7x+w85hCdhzC6Hj8ZGvpn2caPMkdVbuSRZe
         l9siPmf2jIiOVZee2G2K27qslsLC9fR92GXZ3Hbr+Z1s2yVH6JineUhaGOaf21kvbFeQ
         dCp31mY4/VG4eCWITkOV5Savzdw7dwucfGYxnB8Y2zv0EuqpzZNtR90Pt77nn1YTZBY0
         6JEjBKMIMOrSY9dGJHCx5zKDaWPOKEMZNDJZk8fKfVsL7PXHT5uOyYaQGAi9B5hwjTEx
         53sVe4Nlw8dV9RSs+R6AuEKvcLU4rA6vi+FgU0Riu1YUutTLnI9FALYnYx9p1rm/3j8p
         xM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795114342; x=1795719142;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B71Ljk+UIM1gXp9I8DKkVnuHdcZAuyllvZTiO1ZgbS8=;
        b=hPhLhpqC8xpAyixbwRn+NgL0MT20pPHJ7FMI9TaiRMI21Kc9sTZYlCht026rWRkD78
         P7HeQ39RowdlVEHYWRbTmdeXinwxM960GIvcXj1z/mDjlhIge5jrEwRBfdOVxs/LEo3H
         41/6sGtbX2GZB8f9NqK8fWaEOs6M8twbIi4OOlryN9hE/lY7tA1beaVvVYPf1/S1BzZb
         cAJxvZWLTn+7t2U9pD5IpIyU42yUs6fvObL/fBPwTqQJisAQiHzqxq0kASTQ/vx2dBLE
         nE970uzDn6iaHbaBRLcxlrqkLOu1hx0k3wVFniGQWQRLCTbg3djtsbwX98YHF10MeVfq
         9XLQ==
X-Forwarded-Encrypted: i=1; AL+hErEhckRVaOiQaryy2UhyB6KVj1lkSJMiuZcasT91+iUU2LRvswQfwdDWwXraiHRIxzuhDyY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/REOZVQZdLX/nMmvzw6hzw1rSd4Hc+wYKx/iEYXodM80lhqNti
	uh2O6dyP2exmEqoI4WPNkedMG/x8jcy9fAt3gmxSst+g1ZpU0UCo/ZarHqCoVOlaSL+i/5WCBHf
	w6GIZ3X5xfPto/9LcagjXiSF89A==
X-Received: from ilpp13.prod.google.com ([2002:a92:d28d:0:b0:53b:ef4a:649b])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1b87:b0:576:217a:6740 with SMTP id 5614622812f47-57a0a60d756mr914272b6e.22.1795114341585;
 Thu, 19 Nov 2026 10:52:21 -0800 (PST)
Date: Thu, 19 Nov 2026 18:51:48 +0000
In-Reply-To: <20261119185215.632334-1-coltonlewis@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119185215.632334-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261119185215.632334-7-coltonlewis@google.com>
Subject: [PATCH v10 06/33] perf: arm_pmuv3: Generalize counter bitmasks
From: Colton Lewis <coltonlewis@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, Jonathan Corbet <corbet@lwn.net>, 
	Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, James Clark <james.clark@linaro.org>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Mingwei Zhang <mizhang@google.com>, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The OVSR bitmasks are valid for enable and interrupt registers as well as
overflow registers. Generalize the names.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 drivers/perf/arm_pmuv3.c       |  4 ++--
 include/linux/perf/arm_pmuv3.h | 14 +++++++-------
 tools/include/perf/arm_pmuv3.h | 12 +++++++-----
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index fbd631ec71a65..4a6c1f3bcea1f 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -535,7 +535,7 @@ static void armv8pmu_pmcr_write(u64 val)
 
 static int armv8pmu_has_overflowed(u64 pmovsr)
 {
-	return !!(pmovsr & ARMV8_PMU_OVERFLOWED_MASK);
+	return !!(pmovsr & ARMV8_PMU_CNT_MASK_ALL);
 }
 
 static int armv8pmu_counter_has_overflowed(u64 pmnc, int idx)
@@ -771,7 +771,7 @@ static u64 armv8pmu_getreset_flags(void)
 	value = read_pmovsclr();
 
 	/* Write to clear flags */
-	value &= ARMV8_PMU_OVERFLOWED_MASK;
+	value &= ARMV8_PMU_CNT_MASK_ALL;
 	write_pmovsclr(value);
 
 	return value;
diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv3.h
index d698efba28a27..fd2a34b4a64d1 100644
--- a/include/linux/perf/arm_pmuv3.h
+++ b/include/linux/perf/arm_pmuv3.h
@@ -224,14 +224,14 @@
 				 ARMV8_PMU_PMCR_LC | ARMV8_PMU_PMCR_LP)
 
 /*
- * PMOVSR: counters overflow flag status reg
+ * Counter bitmask layouts for overflow, enable, and interrupts
  */
-#define ARMV8_PMU_OVSR_P		GENMASK(30, 0)
-#define ARMV8_PMU_OVSR_C		BIT(31)
-#define ARMV8_PMU_OVSR_F		BIT_ULL(32) /* arm64 only */
-/* Mask for writable bits is both P and C fields */
-#define ARMV8_PMU_OVERFLOWED_MASK	(ARMV8_PMU_OVSR_P | ARMV8_PMU_OVSR_C | \
-					ARMV8_PMU_OVSR_F)
+#define ARMV8_PMU_CNT_MASK_P		GENMASK(30, 0)
+#define ARMV8_PMU_CNT_MASK_C		BIT(31)
+#define ARMV8_PMU_CNT_MASK_F		BIT_ULL(32) /* arm64 only */
+#define ARMV8_PMU_CNT_MASK_ALL		(ARMV8_PMU_CNT_MASK_P | \
+					 ARMV8_PMU_CNT_MASK_C | \
+					 ARMV8_PMU_CNT_MASK_F)
 
 /*
  * PMXEVTYPER: Event selection reg
diff --git a/tools/include/perf/arm_pmuv3.h b/tools/include/perf/arm_pmuv3.h
index 1e397d55384ed..d045b0f3b93fe 100644
--- a/tools/include/perf/arm_pmuv3.h
+++ b/tools/include/perf/arm_pmuv3.h
@@ -226,12 +226,14 @@
 				 ARMV8_PMU_PMCR_LC | ARMV8_PMU_PMCR_LP)
 
 /*
- * PMOVSR: counters overflow flag status reg
+ * Counter bitmask layouts for overflow, enable, and interrupts
  */
-#define ARMV8_PMU_OVSR_P		GENMASK(30, 0)
-#define ARMV8_PMU_OVSR_C		BIT(31)
-/* Mask for writable bits is both P and C fields */
-#define ARMV8_PMU_OVERFLOWED_MASK	(ARMV8_PMU_OVSR_P | ARMV8_PMU_OVSR_C)
+#define ARMV8_PMU_CNT_MASK_P		GENMASK(30, 0)
+#define ARMV8_PMU_CNT_MASK_C		BIT(31)
+#define ARMV8_PMU_CNT_MASK_F		BIT_ULL(32) /* arm64 only */
+#define ARMV8_PMU_CNT_MASK_ALL		(ARMV8_PMU_CNT_MASK_P | \
+					 ARMV8_PMU_CNT_MASK_C | \
+					 ARMV8_PMU_CNT_MASK_F)
 
 /*
  * PMXEVTYPER: Event selection reg
-- 
2.56.1.708.g77570a6a1d-goog

