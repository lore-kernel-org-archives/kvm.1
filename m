Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com [209.85.167.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14973D16F6
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 19:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781292574; cv=none; b=l4uirr9xJwWPc8WLAOMMaOQqkXGui7w8ugAuD2zZE+oV5G7WFQ2bPvTyjBdf93KWCs0ICCULkpG9QhAMVG7W2OcO3SooIQi5tgEgyg9vV7SQfdR2qk9RoysYeFmSMAOYtbZdy3mu3FxwGQkY0vcCot7Ed5cp0eEHQ5MLmlKk1fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781292574; c=relaxed/simple;
	bh=TjYRd0nJW/jKNkkVM+Lek1arEtrbddhEOegCE5t4QhE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p67ijzaCFTe8V++A8xxbKk/iZKd1qhw4skbB/reLTDKDd+JhkFpCx8YnvS4jAzKVnSYYmL/SZCvdHHYcggjP3LnCVi4azNY86exeOQP56VYT2OXOc53+HpmD0gEo41w4zn5YQqUTOwkG1onn4egDNNKeKUeLx6GnzIW0rsDBJnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m7ppru7Z; arc=none smtp.client-ip=209.85.167.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m7ppru7Z"
Received: by mail-oi1-f201.google.com with SMTP id 5614622812f47-486055c1c6fso1104102b6e.1
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 12:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781292566; x=1781897366; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mefc4hk7l8V5q1+Ri7ebgTL5CsdX634wsG3um/9LWKo=;
        b=m7ppru7Zl3Qp242F/KSsbNc3LmbhrqzGkg0gUi9pl/7MS6jEKcLJ+W4ftQ80h4FvAz
         vmN3+sOgUIdxdrXutzrFLE+jTdcFyGLIMJQ+y049VZ+kYXrujDSXWavP+lCnJdyCNaHF
         EU5Dceadf1StqfR8uZNvIP1qwhZQKUyer3Ag3zNKyx6ITNubeFCOOZCYsy79MuA33VeV
         XId3ElqGboZdhW1A3Xd6fF80k/frqBr65lG4F75IKdM2zHg5efwIPA1BWTEbxYM9v3g0
         ZP5rGJjA5Yoy4k8+OLTWczfErCeITdMLZkvKG8HCCGX6XH4ydzsjqrlzhG/fW8bcDc/Z
         qZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781292566; x=1781897366;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mefc4hk7l8V5q1+Ri7ebgTL5CsdX634wsG3um/9LWKo=;
        b=B+Keg9i+dAP7vrw+BDmtH/XmicZebCpRfHpLO9CAnJYL7FFf0Uq6PvEd67Olq2Pa14
         Vy5uemXv+FmwsuVnidPMBT5/0fjzvFV75zswzrKu5KH25rkjNUqrBwK99kJZXtQVkyrI
         RSi4KsnKcsxvltmEZXCOmtwWa5mFo8XYUmG7xyWGHvcfxK5DLtW0DQ7K6OaFXerRBFlN
         z2lkv/zyIrBEg5g+TC2A3eutPDSBqNjhfbxy4lacDnT8SfyZqix23g3W4fZVbbGQbuMt
         ABvWDGlcGPjGW/FBgvzN1SROhDQMIqHQaEkZ3wZBaOr3EtB9mfQWgLQQ/rZuyGmhQhUU
         gbyw==
X-Gm-Message-State: AOJu0YwnYgHln3mrvWN4RfIHuWWIgh1QzJJFFM53gSUz/tAInjLueSkJ
	kN6DaOIG3qcLCIaq7qlq61DR8CvmEpFxtjgwZQH9qgAewkNk8JRxg2VHdWgnLXCcWcLHV4RXykD
	W5+1MmBZF6Gqj6LMySsJ0gr/CnAf9eZ/+snfg6+3fb9UDKU3JC1mnzSYcUpN6OLDG6oC6EneDdK
	sq6epivDDbZp7wMRv4YGCGTMIza36xi1tKnJNS7WMyvhrN+i4t2VplLOo1xvU=
X-Received: from iloo20-n1.prod.google.com ([2002:a05:6e02:6114:10b0:4fe:69b2:404b])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:3a15:b0:485:d6e7:9dbf with SMTP id 5614622812f47-4872f11d549mr2509778b6e.0.1781292566143;
 Fri, 12 Jun 2026 12:29:26 -0700 (PDT)
Date: Fri, 12 Jun 2026 19:29:05 +0000
In-Reply-To: <20260612192909.1153907-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612192909.1153907-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612192909.1153907-18-coltonlewis@google.com>
Subject: [PATCH 17/21] KVM: arm64: Detect overflows for the Partitioned PMU
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

When we re-enter the VM after handling a PMU interrupt, calculate
whether it was any of the guest counters that overflowed and inject an
interrupt into the guest if so.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/pmu-direct.c | 48 +++++++++++++++++++++++++++++++++++++
 arch/arm64/kvm/pmu-emul.c   |  4 ++--
 arch/arm64/kvm/pmu.c        |  6 ++++-
 include/kvm/arm_pmu.h       |  2 ++
 4 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
index 64f40cfb31012..0062d1d8e1999 100644
--- a/arch/arm64/kvm/pmu-direct.c
+++ b/arch/arm64/kvm/pmu-direct.c
@@ -426,4 +426,52 @@ void kvm_pmu_handle_guest_irq(struct arm_pmu *pmu, u64 pmovsr)
 		return;
 
 	__vcpu_rmw_sys_reg(vcpu, PMOVSSET_EL0, |=, govf);
+
+	if (kvm_pmu_part_overflow_status(vcpu)) {
+		kvm_make_request(KVM_REQ_IRQ_PENDING, vcpu);
+
+		if (!in_nmi())
+			kvm_vcpu_kick(vcpu);
+		else
+			irq_work_queue(&vcpu->arch.pmu.overflow_work);
+	}
+}
+
+/**
+ * kvm_pmu_part_overflow_status() - Determine if any guest counters have overflowed
+ * @vcpu: Pointer to struct kvm_vcpu
+ *
+ * Determine if any guest counters have overflowed and therefore an
+ * IRQ needs to be injected into the guest. If access is still free,
+ * then the guest hasn't accessed the PMU yet so we know the guest
+ * context is not loaded onto the pCPU and an overflow is impossible.
+ *
+ * Return: True if there was an overflow, false otherwise
+ */
+bool kvm_pmu_part_overflow_status(struct kvm_vcpu *vcpu)
+{
+	struct arm_pmu *pmu;
+	u64 mask, pmovs, pmint, pmcr;
+	bool overflow;
+
+	pmu = vcpu->kvm->arch.arm_pmu;
+	mask = kvm_pmu_guest_counter_mask(pmu);
+
+	if (vcpu->arch.pmu.access == VCPU_PMU_ACCESS_FREE) {
+		pmovs = __vcpu_sys_reg(vcpu, PMOVSSET_EL0);
+		pmint = __vcpu_sys_reg(vcpu, PMINTENSET_EL1);
+		pmcr = __vcpu_sys_reg(vcpu, PMCR_EL0);
+
+		if ((pmcr & ARMV8_PMU_PMCR_E) && (mask & pmovs & pmint))
+			kvm_pmu_set_guest_owned(vcpu);
+		else
+			return false;
+	}
+
+	pmovs = __vcpu_sys_reg(vcpu, PMOVSSET_EL0);
+	pmint = read_pmintenset();
+	pmcr = read_pmcr();
+	overflow = (pmcr & ARMV8_PMU_PMCR_E) && (mask & pmovs & pmint);
+
+	return overflow;
 }
diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index d1110febe7436..ebc68090bdb26 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -268,7 +268,7 @@ void kvm_pmu_reprogram_counter_mask(struct kvm_vcpu *vcpu, u64 val)
  * counter where the values of the global enable control, PMOVSSET_EL0[n], and
  * PMINTENSET_EL1[n] are all 1.
  */
-bool kvm_pmu_overflow_status(struct kvm_vcpu *vcpu)
+bool kvm_pmu_emul_overflow_status(struct kvm_vcpu *vcpu)
 {
 	u64 reg = __vcpu_sys_reg(vcpu, PMOVSSET_EL0);
 
@@ -405,7 +405,7 @@ static void kvm_pmu_perf_overflow(struct perf_event *perf_event,
 		kvm_pmu_counter_increment(vcpu, BIT(idx + 1),
 					  ARMV8_PMUV3_PERFCTR_CHAIN);
 
-	if (kvm_pmu_overflow_status(vcpu)) {
+	if (kvm_pmu_emul_overflow_status(vcpu)) {
 		kvm_make_request(KVM_REQ_IRQ_PENDING, vcpu);
 
 		if (!in_nmi())
diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
index 55cda8021400a..f5ee18b4dfae7 100644
--- a/arch/arm64/kvm/pmu.c
+++ b/arch/arm64/kvm/pmu.c
@@ -409,7 +409,11 @@ static void kvm_pmu_update_state(struct kvm_vcpu *vcpu)
 	struct kvm_pmu *pmu = &vcpu->arch.pmu;
 	bool overflow;
 
-	overflow = kvm_pmu_overflow_status(vcpu);
+	if (kvm_pmu_is_partitioned(vcpu->kvm))
+		overflow = kvm_pmu_part_overflow_status(vcpu);
+	else
+		overflow = kvm_pmu_emul_overflow_status(vcpu);
+
 	if (pmu->irq_level == overflow)
 		return;
 
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index 25163a689ae80..f72d080ee7ba2 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -93,6 +93,8 @@ bool kvm_set_pmuserenr(u64 val);
 void kvm_vcpu_pmu_restore_guest(struct kvm_vcpu *vcpu);
 void kvm_vcpu_pmu_restore_host(struct kvm_vcpu *vcpu);
 void kvm_vcpu_pmu_resync_el0(void);
+bool kvm_pmu_emul_overflow_status(struct kvm_vcpu *vcpu);
+bool kvm_pmu_part_overflow_status(struct kvm_vcpu *vcpu);
 
 #define kvm_vcpu_has_pmu(vcpu)					\
 	(vcpu_has_feature(vcpu, KVM_ARM_VCPU_PMU_V3))
-- 
2.54.0.1136.gdb2ca164c4-goog

