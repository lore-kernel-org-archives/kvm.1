Received: from mail-oi1-f202.google.com (mail-oi1-f202.google.com [209.85.167.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF493CD8BB
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 19:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781292573; cv=none; b=IA6V5rc3Gd+oYQzjuF9tLcbIjbkf7wxdRB2axNwZGJT/JmCal0Vqy9cKHLFmvmLMPAkccb9FHi4w2KbbAk7/oi994WSTZWM7WxFX6wmi06SgjqLuMcrQCe3aKRy9K5Rgjfsgh6P77yjf6QKj4irayoE3YasE32VsaexFUJYYYU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781292573; c=relaxed/simple;
	bh=zr3w7K53w0L/DQ3i6wl/ImOA8tm3WN8USWt9IWrAR68=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VilC2GutNeW38sRSxRpjnaV3C6RlIHz1TBPaRsL72RXP3a+3EB1NmEALl4tputGULAQExgk7cOA8q/dWpRBiI/DnswveTVeT+qSv+WJHCV4bT/i6MVa0vK3u2mvfBrX9kAcmpKbDaczLmD5xBNplsL8QYkKIGszjGg7/ena2vI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M1p0u8HP; arc=none smtp.client-ip=209.85.167.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M1p0u8HP"
Received: by mail-oi1-f202.google.com with SMTP id 5614622812f47-48687df43c4so2054431b6e.0
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 12:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781292566; x=1781897366; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ffaCtse8d32sUz83GD9kE1zbC59Hof3u/dSFHSfc7mE=;
        b=M1p0u8HPlzdPe/xdhn8h75toZavf6ju5YQ80vMmJ3yVu1KMOfhYVRX6BQTmx7mnm5J
         H+MQJpnXo1JismidB1f4MWvch9yGjZGipWeIRJLIpESPsMFmcho3VngBUzqMscV3nE81
         0QBU1EndXyTCZ9UAD7vVZ910wvzQnhJ0PNVW5fLCtGqP1ieSv8PZ3BwCFaM5D/sgHbda
         C4YIl+QSeqjjmDyzXfVHTCIsmFMggd1dAI0Xg0P1gDGeT2xuhtKUcwyBej+elYR7Iyzb
         7Z6GZEiysmP0yXSussnmokezQ40+AkWeN+6rqcm9RtXrz8fTrsypVse2rjiYHREQB1/Q
         VXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781292566; x=1781897366;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ffaCtse8d32sUz83GD9kE1zbC59Hof3u/dSFHSfc7mE=;
        b=XzDmxgrfAsj4+3MlBW/d6jUGEuCS6jTabAI63qt2oOc9oY/QyQ93n1ZI3vRJoy7Ovf
         Gj2Ap1sRMUhEyT58DnJMRAbVsBE+Y3b/rxAgTnynHEIXhVcKzCu4asNo9G6+/C0UWMVj
         PVUcOYaR2n5kBag2+zK19l8g3bPG1ot71ofcQdbFS92vtIECJM4btszeYW4VcmGytcio
         FPYlUDrUHY+HINMPG6hjao+B7liLatQmpVWYZnfoDIhj5UgoggEd41At3oBNqFNQqtRd
         qxwvkl9x5SdfvH26Fdm6h1VcXAoGshWAkTb4A9wfAKOSgrzXjkbh7waDlz0EmkyEvFi3
         fX+g==
X-Gm-Message-State: AOJu0Yy6yzZc81AJXiHlv8aUOcQqtbgHVvWvoZVVD21soDYGnIMe2Buz
	p9l4Sbc3e89k0rXbAcypDblPyX9GyQ1SimaO8DvXFgFY7L+cd0njo6VT+NfvBQ7w+5dgTn3TKKQ
	XwnHdCwCcgj9TXyvkzpcBNq7zw4QonhUrvWLvEEw/9LBT7olUVwX22ZGs/4+I7S/c9djWbaRI97
	RwYRTzMh7RYedQj0ixnlabhzpzS0evVbfJjfu04nG2ZhIAjevYz3xZUWe3k4k=
X-Received: from ilbcl18.prod.google.com ([2002:a05:6e02:3792:b0:4fa:269e:802])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1b2a:b0:486:79ad:970e with SMTP id 5614622812f47-4872f389689mr2647217b6e.13.1781292565256;
 Fri, 12 Jun 2026 12:29:25 -0700 (PDT)
Date: Fri, 12 Jun 2026 19:29:04 +0000
In-Reply-To: <20260612192909.1153907-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612192909.1153907-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612192909.1153907-17-coltonlewis@google.com>
Subject: [PATCH 16/21] perf: arm_pmuv3: Handle IRQs for Partitioned PMU guest counters
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

Because ARM hardware is not yet capable of direct PPI injection into
guests, guest counters will still trigger interrupts that need to be
handled by the host PMU interrupt handler. Clear the overflow flags in
hardware to handle the interrupt as normal, but update the virtual overflow register for later injecting the interrupt into the guest.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm/include/asm/arm_pmuv3.h   |  6 ++++++
 arch/arm64/include/asm/arm_pmuv3.h |  5 +++++
 arch/arm64/kvm/pmu-direct.c        | 22 ++++++++++++++++++++++
 drivers/perf/arm_pmuv3.c           | 24 +++++++++++++++++-------
 include/kvm/arm_pmu.h              |  3 +++
 5 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/arm_pmuv3.h
index f6031bd522718..896fc5d6add0c 100644
--- a/arch/arm/include/asm/arm_pmuv3.h
+++ b/arch/arm/include/asm/arm_pmuv3.h
@@ -180,6 +180,11 @@ static inline void write_pmintenset(u32 val)
 	write_sysreg(val, PMINTENSET);
 }
 
+static inline u32 read_pmintenset(void)
+{
+	return read_sysreg(PMINTENSET);
+}
+
 static inline void write_pmintenclr(u32 val)
 {
 	write_sysreg(val, PMINTENCLR);
@@ -239,6 +244,7 @@ static inline u64 kvm_pmu_host_counter_mask(struct arm_pmu *pmu)
 {
 	return ~0;
 }
+static inline void kvm_pmu_handle_guest_irq(struct arm_pmu *pmu, u64 pmovsr) {}
 
 /* PMU Version in DFR Register */
 #define ARMV8_PMU_DFR_VER_NI        0
diff --git a/arch/arm64/include/asm/arm_pmuv3.h b/arch/arm64/include/asm/arm_pmuv3.h
index 27c4d6d47da31..69ff4d014bf39 100644
--- a/arch/arm64/include/asm/arm_pmuv3.h
+++ b/arch/arm64/include/asm/arm_pmuv3.h
@@ -110,6 +110,11 @@ static inline void write_pmintenset(u64 val)
 	write_sysreg(val, pmintenset_el1);
 }
 
+static inline u64 read_pmintenset(void)
+{
+	return read_sysreg(pmintenset_el1);
+}
+
 static inline void write_pmintenclr(u64 val)
 {
 	write_sysreg(val, pmintenclr_el1);
diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
index bb1f3dca03869..64f40cfb31012 100644
--- a/arch/arm64/kvm/pmu-direct.c
+++ b/arch/arm64/kvm/pmu-direct.c
@@ -405,3 +405,25 @@ void kvm_pmu_set_guest_owned(struct kvm_vcpu *vcpu)
 		kvm_arm_setup_mdcr_el2(vcpu);
 	}
 }
+
+/**
+ * kvm_pmu_handle_guest_irq() - Record IRQs in guest counters
+ * @pmu: PMU to check for overflows
+ * @pmovsr: Overflow flags reported by driver
+ *
+ * Set overflow flags in guest-reserved counters in the VCPU register
+ * for the guest to clear later.
+ */
+void kvm_pmu_handle_guest_irq(struct arm_pmu *pmu, u64 pmovsr)
+{
+	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
+	u64 mask = kvm_pmu_guest_counter_mask(pmu);
+	u64 govf = pmovsr & mask;
+
+	write_pmovsclr(govf);
+
+	if (!vcpu)
+		return;
+
+	__vcpu_rmw_sys_reg(vcpu, PMOVSSET_EL0, |=, govf);
+}
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index c187397134990..6ab15a5209608 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -774,16 +774,15 @@ static void armv8pmu_disable_event_irq(struct perf_event *event)
 	armv8pmu_disable_intens(BIT(event->hw.idx));
 }
 
-static u64 armv8pmu_getreset_flags(void)
+static u64 armv8pmu_getovf_flags(void)
 {
 	u64 value;
 
 	/* Read */
 	value = read_pmovsclr();
 
-	/* Write to clear flags */
-	value &= ARMV8_PMU_CNT_MASK_ALL;
-	write_pmovsclr(value);
+	/* Only report interrupt enabled counters. */
+	value &= read_pmintenset();
 
 	return value;
 }
@@ -897,16 +896,17 @@ static void read_branch_records(struct pmu_hw_events *cpuc,
 
 static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 {
-	u64 pmovsr;
 	struct perf_sample_data data;
 	struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
 	struct pt_regs *regs;
+	u64 host_set = kvm_pmu_host_counter_mask(cpu_pmu);
+	u64 pmovsr;
 	int idx;
 
 	/*
-	 * Get and reset the IRQ flags
+	 * Get the IRQ flags
 	 */
-	pmovsr = armv8pmu_getreset_flags();
+	pmovsr = armv8pmu_getovf_flags();
 
 	/*
 	 * Did an overflow occur?
@@ -914,6 +914,12 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 	if (!armv8pmu_has_overflowed(pmovsr))
 		return IRQ_NONE;
 
+	/*
+	 * Guest flag reset is handled the kvm hook at the bottom of
+	 * this function.
+	 */
+	write_pmovsclr(pmovsr & host_set);
+
 	/*
 	 * Handle the counter(s) overflow(s)
 	 */
@@ -955,6 +961,10 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 		 */
 		perf_event_overflow(event, &data, regs);
 	}
+
+	if (pmu_is_partitioned(cpu_pmu))
+		kvm_pmu_handle_guest_irq(cpu_pmu, pmovsr);
+
 	armv8pmu_start(cpu_pmu);
 
 	return IRQ_HANDLED;
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index b77ddb94dc99b..25163a689ae80 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -106,6 +106,7 @@ u64 kvm_pmu_guest_counter_mask(struct arm_pmu *pmu);
 void kvm_pmu_load(struct kvm_vcpu *vcpu);
 void kvm_pmu_put(struct kvm_vcpu *vcpu);
 void kvm_pmu_set_guest_owned(struct kvm_vcpu *vcpu);
+void kvm_pmu_handle_guest_irq(struct arm_pmu *pmu, u64 pmovsr);
 
 #define kvm_pmu_get_access(vcpu)	((vcpu)->arch.pmu.access)
 
@@ -274,6 +275,8 @@ static inline u64 kvm_pmu_guest_counter_mask(void *kvm)
 	return 0;
 }
 
+static inline void kvm_pmu_handle_guest_irq(struct arm_pmu *pmu, u64 pmovsr) {}
+
 #endif
 
 #endif
-- 
2.54.0.1136.gdb2ca164c4-goog

