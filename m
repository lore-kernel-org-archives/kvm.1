Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114344;
	b=OYzQO5f5xxot5626NLlyWMPP21RuIXKnJ89GOb03VxtEU/f36pV21Jzu3v1oQ6HRlwt8
	 OAZ1mEcVDj7qUvvKPpi1gFNuF0wF32+LIP37Q2dAv4M1ADINC3wg/ikEx2RKNM1zXUrFe
	 F5gMexI5ZB8J4P56eadWKFru+qs+54M2hpOF3HSpWmNQZHq4i68zy9vkXTEGiiMBjpUWe
	 gCwiwY2wHY0R27uPoCt+YrwdCIWqYyi/hZ44XjXDaZYQOYGqI+I/BCwfVo108/m+EJEqa
	 14Bses5E1kIlfpJ2+OvKtlN4V6crbbirHSVk4QpHwTilLgp8W5iqfONRAL9/SLgMkzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114344;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=SaW1KGsH36nTnT+j010zVHsDHg18D3SnYS8dyPmcydo=;
	b=OIPV+arhfhLDzuzfitGNnTFvME77YtYVpSoh7LU76CfzLOdd0/C0N60/y4j7E/mdTxU4
	 YKrM10foqIEEXHOF8dvjRujnY5KQ9SYfBKactkQHJtNEf/vMjlJIJgEcywoo4DJ5xN6WT
	 FgiTNbnRFCJsWALypLqaYuqwK8amvNAdMnK6vntRVF3Hbd9LHMwiLIZ5ZOYa+Ww85AuEn
	 C6gr+bLKjsvylMjTucfd0wLGkNqC+M0LukrS/8Nud5mSRyLFkiQBiExXOEY72ur6mFBu4
	 FA5+dmrNzKq7VvFLps2fjqYAi5TzwmUibPURXlGjJd4E3thMcbojKunR/wR2vwLAuqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LkLXyRE6;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5C660A5BC4
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 18:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC5C660A5BC4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LkLXyRE6
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-54dbbf252cdso199372b6e.2
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 10:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795114343; x=1795719143; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SaW1KGsH36nTnT+j010zVHsDHg18D3SnYS8dyPmcydo=;
        b=LkLXyRE6/S/94yHQSJScxxD8CqYjvtOxDJHdga05lbR4Vl2KtD16X65wd7i7VA4OXK
         rfpS0TT37QHUUtE5C/tu6qeK2yFBIydBUftNGD/V2JfXJPH6DJ3zvKzLRKJNlouTnvvP
         Zr8VDnxYalpwHvxcVm40kDXfHOxi7vaeLm0fXUxTrn2ClO6beL3dvZEz2m6jC7cWF2Hj
         ogVAkhTE1/XmESM+6WW7ePmccHAPThzXZdgtlg5wfky3owxKvJKH8yyVnim3ecV3cvsX
         lM3Y+xOrsvxDCCc4Xc86eRTWS5GI6WoFuav+sT+cdkhOdP6sBN8Ot/TCLYo4ZZQ0DSaF
         YtQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795114343; x=1795719143;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SaW1KGsH36nTnT+j010zVHsDHg18D3SnYS8dyPmcydo=;
        b=WiekM10CrVg7G0hVaXhhJlGaS0OJ6vZxN1rBgpHsKsfIkBJD9DrOG+0xGSNYXptzld
         K6+73bL2g4hAhWiQAUQagPeE7frelj21fVBx6Z3bUGvfLwBXjdZBlMl9Yby6p8XTrsEx
         kiNKa81oWr1SlC7HDvLV+IIHnBiHdSEmT/HN4dbyh3+b4/1dOfsZwEHRVZDgKAu43xD5
         m7WkJCOs7w9YZzyDBzBu9R4R1RR0/rhbbAPX+PfrCX6RoXQQ9W3+pVAUsRcv3vDUhOL3
         AJZFqMZZuaECtBUT3DqdpguSV0cLF52tlg+0ZNShRlJzNLoKbBcZAUU2E6fy+YZthV0p
         MrLA==
X-Forwarded-Encrypted: i=1; AL+hErF32xfYs0UrEZMMCxsjw/Bwlb3GDMGeV8F8QIVwJ/zkxmr18vMJFaMBN5OmKEkIZCK0Flk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9nC7jU8AyI62aZ/YC4sE2sW82M3enzYbXLXlVKak7CUQmXIyyD
	vyGnJ4O7tb5+VrZLlX5WdhKC85s8PZ40zKIPaVpbxs5lrKzI3D/2xcxOiWg1aTxxMAbzQeOKJ5m
	yU+d0CdB1dymXKkHZsnHWFyt0SQ==
X-Received: from iobp24-n1.prod.google.com ([2002:a05:6602:8698:10b0:9c7:6b53:4f8e])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:3088:b0:567:c44d:c1fa with SMTP id 5614622812f47-57a0a60d7f3mr1028055b6e.16.1795114342513;
 Thu, 19 Nov 2026 10:52:22 -0800 (PST)
Date: Thu, 19 Nov 2026 18:51:49 +0000
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
Message-ID: <20261119185215.632334-8-coltonlewis@google.com>
Subject: [PATCH v10 07/33] perf: arm_pmuv3: Move counter allocation mask to
 per-CPU struct pmu_hw_events
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

In preparation for dynamic per-CPU PMU counter reservations when running
KVM guests with a partitioned PMU, move the counter allocation mask from
the global struct arm_pmu to per-CPU struct pmu_hw_events.

Initialize cpuc->cntr_mask from the static cpu_pmu->cntr_mask during PMU
probe and CPU hotplug startup, and update event counter allocation
helpers (armv8pmu_get_single_idx(), armv8pmu_get_chain_idx(), and
armv8pmu_get_event_idx()) to query the per-CPU mask.

Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 drivers/perf/arm_pmu.c       |  9 +++++++--
 drivers/perf/arm_pmuv3.c     | 28 +++++++++++++++++-----------
 include/linux/perf/arm_pmu.h |  1 +
 3 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 1150695653892..b1851d1c594b1 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -408,9 +408,11 @@ validate_group(struct perf_event *event)
 
 	/*
 	 * Initialise the fake PMU. We only need to populate the
-	 * used_mask for the purposes of validation.
+	 * used_mask and cntr_mask for the purposes of validation.
 	 */
 	memset(&fake_pmu.used_mask, 0, sizeof(fake_pmu.used_mask));
+	bitmap_copy(fake_pmu.cntr_mask, to_arm_pmu(event->pmu)->cntr_mask,
+		    ARMPMU_MAX_HWEVENTS);
 
 	if (!validate_event(event->pmu, &fake_pmu, leader))
 		return -EINVAL;
@@ -717,6 +719,7 @@ bool arm_pmu_irq_is_nmi(void)
 static int arm_perf_starting_cpu(unsigned int cpu, struct hlist_node *node)
 {
 	struct arm_pmu *pmu = hlist_entry_safe(node, struct arm_pmu, node);
+	struct pmu_hw_events *cpuc = per_cpu_ptr(pmu->hw_events, cpu);
 	int irq;
 
 	if (!cpumask_test_cpu(cpu, &pmu->supported_cpus))
@@ -724,6 +727,8 @@ static int arm_perf_starting_cpu(unsigned int cpu, struct hlist_node *node)
 	if (pmu->reset)
 		pmu->reset(pmu);
 
+	bitmap_copy(cpuc->cntr_mask, pmu->cntr_mask, ARMPMU_MAX_HWEVENTS);
+
 	irq = armpmu_get_cpu_irq(pmu, cpu);
 	if (irq)
 		per_cpu(cpu_irq_ops, cpu)->enable_pmuirq(irq);
@@ -753,7 +758,7 @@ static void cpu_pm_pmu_setup(struct arm_pmu *armpmu, unsigned long cmd)
 	struct perf_event *event;
 	int idx;
 
-	for_each_set_bit(idx, armpmu->cntr_mask, ARMPMU_MAX_HWEVENTS) {
+	for_each_set_bit(idx, hw_events->cntr_mask, ARMPMU_MAX_HWEVENTS) {
 		event = hw_events->events[idx];
 		if (!event)
 			continue;
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 4a6c1f3bcea1f..973d4abcb3a6e 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -813,7 +813,7 @@ static void armv8pmu_enable_user_access(struct arm_pmu *cpu_pmu)
 		write_pmuacr(mask);
 	} else {
 		/* Clear any unused counters to avoid leaking their contents */
-		for_each_andnot_bit(i, cpu_pmu->cntr_mask, cpuc->used_mask,
+		for_each_andnot_bit(i, cpuc->cntr_mask, cpuc->used_mask,
 				    ARMPMU_MAX_HWEVENTS) {
 			if (i == ARMV8_PMU_CYCLE_IDX)
 				write_pmccntr(0);
@@ -917,7 +917,7 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 	 * to prevent skews in group events.
 	 */
 	armv8pmu_stop(cpu_pmu);
-	for_each_set_bit(idx, cpu_pmu->cntr_mask, ARMPMU_MAX_HWEVENTS) {
+	for_each_set_bit(idx, cpuc->cntr_mask, ARMPMU_MAX_HWEVENTS) {
 		struct perf_event *event = cpuc->events[idx];
 		struct hw_perf_event *hwc;
 
@@ -953,20 +953,18 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 	return IRQ_HANDLED;
 }
 
-static int armv8pmu_get_single_idx(struct pmu_hw_events *cpuc,
-				    struct arm_pmu *cpu_pmu)
+static int armv8pmu_get_single_idx(struct pmu_hw_events *cpuc)
 {
 	int idx;
 
-	for_each_set_bit(idx, cpu_pmu->cntr_mask, ARMV8_PMU_MAX_GENERAL_COUNTERS) {
+	for_each_set_bit(idx, cpuc->cntr_mask, ARMV8_PMU_MAX_GENERAL_COUNTERS) {
 		if (!test_and_set_bit(idx, cpuc->used_mask))
 			return idx;
 	}
 	return -EAGAIN;
 }
 
-static int armv8pmu_get_chain_idx(struct pmu_hw_events *cpuc,
-				   struct arm_pmu *cpu_pmu)
+static int armv8pmu_get_chain_idx(struct pmu_hw_events *cpuc)
 {
 	int idx;
 
@@ -974,7 +972,7 @@ static int armv8pmu_get_chain_idx(struct pmu_hw_events *cpuc,
 	 * Chaining requires two consecutive event counters, where
 	 * the lower idx must be even.
 	 */
-	for_each_set_bit(idx, cpu_pmu->cntr_mask, ARMV8_PMU_MAX_GENERAL_COUNTERS) {
+	for_each_set_bit(idx, cpuc->cntr_mask, ARMV8_PMU_MAX_GENERAL_COUNTERS) {
 		if (!(idx & 0x1))
 			continue;
 		if (!test_and_set_bit(idx, cpuc->used_mask)) {
@@ -1042,7 +1040,7 @@ static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	 */
 	if ((evtype == ARMV8_PMUV3_PERFCTR_INST_RETIRED) &&
 	    !armv8pmu_event_get_threshold(&event->attr) &&
-	    test_bit(ARMV8_PMU_INSTR_IDX, cpu_pmu->cntr_mask) &&
+	    test_bit(ARMV8_PMU_INSTR_IDX, cpuc->cntr_mask) &&
 	    !armv8pmu_event_want_user_access(event)) {
 		if (!test_and_set_bit(ARMV8_PMU_INSTR_IDX, cpuc->used_mask))
 			return ARMV8_PMU_INSTR_IDX;
@@ -1052,9 +1050,9 @@ static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	 * Otherwise use events counters
 	 */
 	if (armv8pmu_event_is_chained(event))
-		return	armv8pmu_get_chain_idx(cpuc, cpu_pmu);
+		return armv8pmu_get_chain_idx(cpuc);
 	else
-		return armv8pmu_get_single_idx(cpuc, cpu_pmu);
+		return armv8pmu_get_single_idx(cpuc);
 }
 
 static void armv8pmu_clear_event_idx(struct pmu_hw_events *cpuc,
@@ -1426,6 +1424,7 @@ static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
 		.present = false,
 	};
 	int ret;
+	int cpu;
 
 	ret = smp_call_function_any(&cpu_pmu->supported_cpus,
 				    __armv8pmu_probe_pmu,
@@ -1441,6 +1440,13 @@ static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
 		if (ret)
 			return ret;
 	}
+
+	for_each_possible_cpu(cpu) {
+		struct pmu_hw_events *cpuc = per_cpu_ptr(cpu_pmu->hw_events, cpu);
+
+		bitmap_copy(cpuc->cntr_mask, cpu_pmu->cntr_mask, ARMPMU_MAX_HWEVENTS);
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 02d2c7f45b527..be1e345e99a77 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -62,6 +62,7 @@ struct pmu_hw_events {
 	 * an event. A 0 means that the counter can be used.
 	 */
 	DECLARE_BITMAP(used_mask, ARMPMU_MAX_HWEVENTS);
+	DECLARE_BITMAP(cntr_mask, ARMPMU_MAX_HWEVENTS);
 
 	/*
 	 * When using percpu IRQs, we need a percpu dev_id. Place it here as we
-- 
2.56.1.708.g77570a6a1d-goog

