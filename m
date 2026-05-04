Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4316346E66
	for <kvm@vger.kernel.org>; Mon,  4 May 2026 21:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777929518; cv=none; b=CtXl2QT9XdKCp2L0ZTLvkYf4ZUWjda81L4l9rg+3TxKbuVYnWvbkxG7GFlA9Q0w4jGXuHI7ruZ8m5BYzuXFVa6h5ci75jntM0aroRpxIizBR+Q8lVkczZ18StPnnHPhO2A2exQhfyvrUuSLQdRM1+f7Yyx5luXlhQVN6kjiE4fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777929518; c=relaxed/simple;
	bh=Kt0JxjDXw64yyFAEbn3FTtOy6aQbbH4PD8HMmdQ27Kc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QYavhy0JJm0pvuMQkMuSf82aGLnf2VcUIQpmTEx+ZKIvEuxBvWwu9Eh0+uUjEP/L0haA3YD9C6fdCV+PBHb5WGyv4Zyw/UdGVGkeN9YX/bMWG7y1BUnXbZ5586N6U/kTQZPQf2yh2p17VJ7iJLpHkmR4lXKk6namCGpTlQZxQXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p4xX6ei5; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p4xX6ei5"
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-40eee5d10c5so8041118fac.0
        for <kvm@vger.kernel.org>; Mon, 04 May 2026 14:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777929515; x=1778534315; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zpZCDOiFD5ADpp1wKWAJRO360JAEeKFaw0Z2nRZPnRE=;
        b=p4xX6ei5l8uAMxPSGxOjcVpRrOulDCCu0/sba9LVEtJs42HHslX82BxkXY3MgAjXrV
         rOW6eDHeYvLxZqbY+zw1O0xTXY1PZknfqGy8qnPI+wK5vH/oCPUlQsAVeTonn0mr+Rqp
         BUSUqWBxEftQhcZ/MDcHG2EW9gSWLL7BYgi1/Tc/ygI9CoMSph1CJUYBnJ4Q7Ia6bBGl
         XDoIGBXDrJEvG9VuOy2AZxjsgvTJ42xTWNN3Wt2632trz2DVS2Irosw1SfInVqDY8K7f
         VrJAzBwravWDc9mjxJFiS7PRsuupcpnEtBj9UgNU7eesdLyKPajksW5yzz+w9duQaC60
         fRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777929515; x=1778534315;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zpZCDOiFD5ADpp1wKWAJRO360JAEeKFaw0Z2nRZPnRE=;
        b=eW0wQr0fRDzlWk8v/Ta6Ed4/JLNvQ92Fg29mrEAxZ/RqqZhnar93TjcxpacWzBqaVQ
         VT3IdHB8330cLiHqc9F40CZmTc7GO6m2ysjJQ4qLMbHFf0itNUG1op1l4Vv8AVMXxdeN
         DtD/rRgDDtUtedMoQx3o5pWXk0c2INb7sjWpjqh/RkoSfRtiN99+6mo7tL5s3jqj8OBb
         ZVa8i42h3GRpGWLWzkndWURSszsHXWMayge8jgIqwZqb2RKBPFXVLbt99eAvQBQZDDNK
         4NLQV0R1cdNdpDVgaD9vUWhJo9Mk9siIKRrtCEYf843yh2KpEiagmAlxamaXjMiNKMDp
         2QlQ==
X-Gm-Message-State: AOJu0YzAWqY4/nqzPSmPe8JUD2edwANn5MubYtnGZAM0V1NEN11kYfcf
	Zs3Vr9CxonPzu1bERb8drVxW8u2tO/W7fYdkzoGdQR5v5KtWb7oIMSSkrMJhM+qYyfmZ/p0avSI
	s02QV/JoQp7nSq7hFJLR/2c+SQG+GGFHvvzO1j5F0qhG8Al4VAa/HtiUuFI1or1E1/gztkjf46h
	/U9NWGHvcJZb+Y4mfZ7WCWVD4RoXoKCyF4kzhEvnSzuAIVSiIPaqaUm6ZtbzE=
X-Received: from ilqa6.prod.google.com ([2002:a05:6e02:1206:b0:4fa:1fcf:cad3])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:99b:b0:694:8bfa:7817 with SMTP id 006d021491bc7-69697db8330mr6011884eaf.53.1777929514318;
 Mon, 04 May 2026 14:18:34 -0700 (PDT)
Date: Mon,  4 May 2026 21:17:58 +0000
In-Reply-To: <20260504211813.1804997-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260504211813.1804997-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504211813.1804997-6-coltonlewis@google.com>
Subject: [PATCH v7 05/20] perf: arm_pmuv3: Check cntr_mask before using pmccntr
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
the guest and will ba absent from cntr_mask.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 drivers/perf/arm_pmuv3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 1cceb1f614515..7ff3139dda893 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -993,6 +993,9 @@ static bool armv8pmu_can_use_pmccntr(struct pmu_hw_events *cpuc,
 	if (evtype != ARMV8_PMUV3_PERFCTR_CPU_CYCLES)
 		return false;
 
+	if (!test_bit(ARMV8_PMU_CYCLE_IDX, cpu_pmu->cntr_mask))
+		return false;
+
 	/*
 	 * A CPU_CYCLES event with threshold counting cannot use PMCCNTR_EL0
 	 * since it lacks threshold support.
-- 
2.54.0.545.g6539524ca2-goog

