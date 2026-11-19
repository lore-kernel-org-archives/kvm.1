Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114368;
	b=K2a8+j9nua5FfgO/8Yb/mFiThQ7lpXIDa2ZFBzLVf5I22EAVVoc4ittIM2WyKojF4/pO
	 Ahqluz+j1mNnUAK1G8NjLspRpVc3vjad4CkQHdP5hXy39LFIfIrtPu5BOD/i0PuroQCYF
	 LYa6l6aB/ZIlOn9Oma/Rz9biNDD9Ks1r7azfSi9y51UN8WuWfTNq2xWBX/ut0YP7zXnrQ
	 CvHV4uPOcV/jbwxwTksuVRh7fwnQNT2bPahKk9ALmryWpNNYU7P+fVcwIoq5eQZopptBC
	 6vaO+FoIgZ6Qor9+W8PKLTVBzvcmNWCWzI/WnYBSA4Umzuz31xGCDCxgchsm5NcI3fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114368;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=6SUYGTh6KQ+CEW5/gGpwzlpf1PM6Ff3twZ/q0wEHr9g=;
	b=crBl8nh0KD2JGeTRd+EpxFrNWq/qYdHo1izc/Xl/ZQHiByIFsGG8x7zuDi0TSz6kYiSu
	 5+m/29Kv341Gn5gChkh5vIeGEMyA1T5fsqeVB0LxDC/7amx05tEyryOsRwOfsPvNiy594
	 auxZTxyszkewf4DeyWNAY0UyL7qkiCtO7VcYeFpNUeqFck4RG2U0NiQDF6D7Deca5MXD7
	 h/hP+Ws+4lIjfwAwkq6/tO4JVfEKtUUM3kczypNOB+e/E4gi95b57M1dPCzAWoGy+zJOB
	 FdCTs9VmIBSf4uimnAJSHRsmfMoW4V1UM5zZyO/fP1v8rAeh//W5AgFfNXt+0QWH5nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JZ0E4kzE;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9836072337
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 18:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B9836072337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JZ0E4kzE
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4ab4f652f9bso145818b6e.0
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 10:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795114365; x=1795719165; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6SUYGTh6KQ+CEW5/gGpwzlpf1PM6Ff3twZ/q0wEHr9g=;
        b=JZ0E4kzEN1kKYeX3RLiGdoWwgdhmU1vs+ZB/HsWVn3zlD2Iu+Q9lhqsp0qN2tGPnRl
         BC8PoIUew2JnvXHX5myFBaJuKTCte+Dl7TS7UC+EkBblArlo26LTBY1gtdpjlcQx1mQJ
         YjNWYDZPiD/S0yfhTyc4po5UBASi2gVkpC6pqKS801SknUZUg2hZjxDD9vTrb4faHp1p
         9vzcYadF28O97qN7zXqzl0u9UvT3gluCBNX+r2umX2P5kTCuAIVyFEr74JWYf9/nQcVw
         r2/1mzz//qN9YtNFfqwzpZ6HRuUIaLC5STHcVwla79qJacdCStty82tNODmTNEAkRVDK
         KfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795114365; x=1795719165;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6SUYGTh6KQ+CEW5/gGpwzlpf1PM6Ff3twZ/q0wEHr9g=;
        b=ohq15a2UX/6EWw/xONA/19AZW3vyaQROqQ+j04dTfIYSyEWXnSWpTD9Q3mx+zw/7Sr
         REKCIDT9YQXouzu0t5GBOY+2mPWmAEHx9HiY3H5ScW4keaY8atLTxEQedgjY6Aqrk8IM
         Qh7BtgHfWgoHSg3sTCtcI60rL0KcPzhaf33fK+RFA7OULULhDq0ROdQ5kRkXJ6qmWXzq
         TYVB0v4Oufo+e1AQh6uZqpNZ5kVkEZElwfHloz0mPz2If6fgGoMido880O6EEPg0OR7f
         77u2o6g1K3QlRsTypaRLnxu9KILxw5czKdJEtExzwnUdxgnyePO/euuVs2Y8Wnq/j0gX
         rwOA==
X-Forwarded-Encrypted: i=1; AL+hErFvHwc3cuoXJk43XOcwigkxau7bMZjHSaCBUvv0sjfvkzRQeM8A6pTmnmZ2HqsD2Kxyu/s=@vger.kernel.org
X-Gm-Message-State: APuU4Z+QqoUV/s2dgmXxKrYym2rWmP3F908tSY12iQM7oF/8x/DMlSmR
	laRC8YxlfAdm0IEarMoie21C7L8X5PuDOgJIWyDzQ4lqGNab+4cQmg/PwdIGoCEuuV0MzbqDqIR
	6AJxC8/AbqUd4nG1un9pzdSnTKg==
X-Received: from iohf23-n2.prod.google.com ([2002:a05:6602:a5d7:20b0:9c4:c2b7:385f])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:17a1:b0:4c3:7073:8c4d with SMTP id 5614622812f47-57a0a211c58mr1003347b6e.20.1795114365076;
 Thu, 19 Nov 2026 10:52:45 -0800 (PST)
Date: Thu, 19 Nov 2026 18:52:12 +0000
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
Message-ID: <20261119185215.632334-31-coltonlewis@google.com>
Subject: [PATCH v10 30/33] KVM: arm64: Support zero event counters on
 Partitioned PMU without HPMN0
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

Programming MDCR_EL2.HPMN to 0 is CONSTRAINED UNPREDICTABLE on CPUs that
do not implement FEAT_HPMN0, preventing userspace from configuring a
cycle-counter-only Partitioned PMU guest (nr_pmu_counters == 0) on those
platforms if HPMN is set directly from nr_pmu_counters.

Support nr_pmu_counters == 0 without FEAT_HPMN0 whenever the PMU has at
least two general-purpose counters by setting physical MDCR_EL2.HPMN = 1
(via kvm_arm_pmu_part_hpmn()), reserving and quiescing physical counter 0
alongside PMCCNTR_EL0 on vCPU load so host perf uses counters 1..N-1,
keeping MDCR_EL2.TPMCR set so trapped PMCR_EL0 reads report N == 0, and
enabling fine-grained traps on PMEVCNTRn_EL0, PMCNTEN, PMINTEN, and
PMSWINC_EL0 so counter 0 remains completely hidden from the guest while
PMCCNTR_EL0 accesses stay untrapped on FEAT_FGT hosts.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/config.c     | 16 ++++++++++----
 arch/arm64/kvm/debug.c      | 12 ++++++-----
 arch/arm64/kvm/pmu-direct.c | 42 ++++++++++++++++++++++++++++++-------
 arch/arm64/kvm/pmu.c        | 15 +++++++++++--
 include/kvm/arm_pmu.h       |  6 ++++++
 5 files changed, 73 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/kvm/config.c b/arch/arm64/kvm/config.c
index 0ec74e45fdbf6..bbe940f6266aa 100644
--- a/arch/arm64/kvm/config.c
+++ b/arch/arm64/kvm/config.c
@@ -1791,6 +1791,8 @@ static void __compute_hdfgrtr(struct kvm_vcpu *vcpu)
 	__compute_fgt(vcpu, HDFGRTR_EL2);
 
 	if (kvm_pmu_is_partitioned(vcpu->kvm)) {
+		unsigned int n = vcpu->kvm->arch.nr_pmu_counters;
+		bool hide_gp0 = kvm_arm_pmu_part_hpmn(n) != n;
 		u64 set = HDFGRTR_EL2_PMOVS |
 			  HDFGRTR_EL2_PMCCFILTR_EL0 |
 			  HDFGRTR_EL2_PMEVTYPERn_EL0 |
@@ -1801,10 +1803,12 @@ static void __compute_hdfgrtr(struct kvm_vcpu *vcpu)
 		    (__vcpu_sys_reg(vcpu, MDCR_EL2) & MDCR_EL2_TPM))
 			set |= HDFGRTR_EL2_PMUSERENR_EL0;
 
-		if (kvm_pmu_hyp_counter_mask(vcpu))
+		if (kvm_pmu_hyp_counter_mask(vcpu) || hide_gp0)
 			set |= HDFGRTR_EL2_PMCNTEN;
-		if (kvm_pmu_part_ovf32_mask(vcpu))
+		if (kvm_pmu_part_ovf32_mask(vcpu) || hide_gp0)
 			set |= HDFGRTR_EL2_PMEVCNTRn_EL0;
+		if (hide_gp0)
+			set |= HDFGRTR_EL2_PMINTEN;
 
 		*vcpu_fgt(vcpu, HDFGRTR_EL2) |= set & ~hdfgrtr_masks.res0;
 	}
@@ -1818,6 +1822,8 @@ static void __compute_hdfgwtr(struct kvm_vcpu *vcpu)
 		*vcpu_fgt(vcpu, HDFGWTR_EL2) |= HDFGWTR_EL2_MDSCR_EL1;
 
 	if (kvm_pmu_is_partitioned(vcpu->kvm)) {
+		unsigned int n = vcpu->kvm->arch.nr_pmu_counters;
+		bool hide_gp0 = kvm_arm_pmu_part_hpmn(n) != n;
 		u64 set = HDFGWTR_EL2_PMOVS |
 			  HDFGWTR_EL2_PMCCFILTR_EL0 |
 			  HDFGWTR_EL2_PMEVTYPERn_EL0;
@@ -1825,10 +1831,12 @@ static void __compute_hdfgwtr(struct kvm_vcpu *vcpu)
 		if (is_hyp_ctxt(vcpu))
 			set |= HDFGWTR_EL2_PMUSERENR_EL0;
 
-		if (kvm_pmu_hyp_counter_mask(vcpu))
+		if (kvm_pmu_hyp_counter_mask(vcpu) || hide_gp0)
 			set |= HDFGWTR_EL2_PMCNTEN | HDFGWTR_EL2_PMSWINC_EL0;
-		if (kvm_pmu_part_ovf32_mask(vcpu))
+		if (kvm_pmu_part_ovf32_mask(vcpu) || hide_gp0)
 			set |= HDFGWTR_EL2_PMEVCNTRn_EL0;
+		if (hide_gp0)
+			set |= HDFGWTR_EL2_PMINTEN;
 
 		*vcpu_fgt(vcpu, HDFGWTR_EL2) |= set & ~hdfgwtr_masks.res0;
 	}
diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index b89f46cb59955..73d157f5b8f6f 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -58,11 +58,11 @@ void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu)
 	if (kvm_pmu_is_partitioned(vcpu->kvm) && vcpu->arch.pmu.loaded_on_cpu) {
 		u8 nr_host_cntr = *host_data_ptr(nr_event_counters);
 		u8 nr_guest_cntr = vcpu->kvm->arch.nr_pmu_counters;
+		u8 guest_hpmn = kvm_arm_pmu_part_hpmn(nr_guest_cntr);
 
 		if (cpumask_test_cpu(smp_processor_id(),
 				     vcpu->kvm->arch.supported_cpus) &&
-		    nr_guest_cntr < nr_host_cntr &&
-		    (cpus_have_final_cap(ARM64_HAS_HPMN0) || nr_guest_cntr > 0)) {
+		    guest_hpmn < nr_host_cntr) {
 			u64 hpmn = FIELD_GET(MDCR_EL2_HPMN, read_sysreg(mdcr_el2));
 			bool hpme;
 
@@ -81,14 +81,16 @@ void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu)
 			 * Take out the coarse grain traps if we are using
 			 * fine grain traps and enforce counter access with
 			 * HPMN. Keep TPMCR when L1 sub-partitions its counters
-			 * so PMCR_EL0 reads and writes trap for multiplexing.
+			 * or when guest_hpmn > nr_guest_cntr (!FEAT_HPMN0 with
+			 * 0 event counters) so PMCR_EL0 accesses trap.
 			 */
 			mdcr &= ~MDCR_EL2_HPMN;
-			mdcr |= FIELD_PREP(MDCR_EL2_HPMN, nr_guest_cntr);
+			mdcr |= FIELD_PREP(MDCR_EL2_HPMN, guest_hpmn);
 
 			if (cpus_have_final_cap(ARM64_HAS_FGT)) {
 				mdcr &= ~MDCR_EL2_TPM;
-				if (!kvm_pmu_hyp_counter_mask(vcpu))
+				if (!kvm_pmu_hyp_counter_mask(vcpu) &&
+				    guest_hpmn == nr_guest_cntr)
 					mdcr &= ~MDCR_EL2_TPMCR;
 			}
 		}
diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
index 6382233e54c71..7b8f0a69641bc 100644
--- a/arch/arm64/kvm/pmu-direct.c
+++ b/arch/arm64/kvm/pmu-direct.c
@@ -89,6 +89,22 @@ static u64 kvm_vcpu_pmu_guest_counter_mask(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static u64 kvm_vcpu_pmu_reserved_counter_mask(struct kvm_vcpu *vcpu)
+{
+	if (vcpu && kvm_pmu_is_partitioned(vcpu->kvm)) {
+		u64 mask = ARMV8_PMU_CNT_MASK_C;
+		unsigned int hpmn =
+			kvm_arm_pmu_part_hpmn(vcpu->kvm->arch.nr_pmu_counters);
+
+		if (hpmn > 0)
+			mask |= GENMASK_ULL(hpmn - 1, 0);
+
+		return mask;
+	}
+
+	return 0;
+}
+
 static void kvm_pmu_set_guest_owned(struct kvm_vcpu *vcpu);
 
 /**
@@ -372,8 +388,12 @@ static u64 kvm_pmu_direct_pmcr_read(struct kvm_vcpu *vcpu)
 	if (!kvm_has_feat(vcpu->kvm, ID_AA64DFR0_EL1, PMUVer, V3P5))
 		pmcr &= ~ARMV8_PMU_PMCR_LP;
 
-	if (vcpu_has_nv(vcpu) && !vcpu_is_el2(vcpu))
-		n = FIELD_GET(MDCR_EL2_HPMN, __vcpu_sys_reg(vcpu, MDCR_EL2));
+	if (vcpu_has_nv(vcpu) && !vcpu_is_el2(vcpu)) {
+		u64 hpmn = FIELD_GET(MDCR_EL2_HPMN, __vcpu_sys_reg(vcpu, MDCR_EL2));
+
+		if (hpmn < n)
+			n = hpmn;
+	}
 
 	return u64_replace_bits(pmcr, n, ARMV8_PMU_PMCR_N);
 }
@@ -686,6 +706,7 @@ static void kvm_pmu_apply_event_filter(struct kvm_vcpu *vcpu)
 static void __kvm_pmu_load(struct kvm_vcpu *vcpu, bool reserve_counters)
 {
 	struct arm_pmu *pmu = vcpu->kvm->arch.arm_pmu;
+	unsigned long reserved_counters;
 	unsigned long guest_counters;
 	unsigned long flags;
 	unsigned long daif;
@@ -710,20 +731,27 @@ static void __kvm_pmu_load(struct kvm_vcpu *vcpu, bool reserve_counters)
 		return;
 	}
 
+	reserved_counters = kvm_vcpu_pmu_reserved_counter_mask(vcpu);
 	guest_counters = kvm_vcpu_pmu_guest_counter_mask(vcpu);
 	if (reserve_counters)
-		kvm_pmu_set_guest_counters(pmu, guest_counters);
+		kvm_pmu_set_guest_counters(pmu, reserved_counters);
 
 	daif = local_daif_save();
 
 	/*
 	 * Ensure guest counters, interrupts, and overflow flags are quiesced
 	 * in hardware before lowering MDCR_EL2.HPMN and marking the partition
-	 * live on this CPU.
+	 * live on this CPU. If counter 0 is reserved solely to satisfy HPMN=1
+	 * without FEAT_HPMN0, scrub and filter it so it cannot count or leak.
 	 */
-	write_sysreg(guest_counters, pmcntenclr_el0);
-	write_sysreg(guest_counters, pmintenclr_el1);
-	write_sysreg(guest_counters, pmovsclr_el0);
+	write_sysreg(reserved_counters, pmcntenclr_el0);
+	write_sysreg(reserved_counters, pmintenclr_el1);
+	write_sysreg(reserved_counters, pmovsclr_el0);
+	if (reserved_counters & ~guest_counters) {
+		write_pmevcntrn(0, 0);
+		write_pmevtypern(0, ARMV8_PMU_EXCLUDE_EL0 |
+				    ARMV8_PMU_EXCLUDE_EL1);
+	}
 	isb();
 
 	vcpu->arch.pmu.loaded_on_cpu = true;
diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
index 9d4ad4b7bd8d5..02a1968bd6cb1 100644
--- a/arch/arm64/kvm/pmu.c
+++ b/arch/arm64/kvm/pmu.c
@@ -914,6 +914,13 @@ u64 kvm_pmu_accessible_counter_mask(struct kvm_vcpu *vcpu)
 	return mask & ~kvm_pmu_hyp_counter_mask(vcpu);
 }
 
+unsigned int kvm_arm_pmu_part_hpmn(unsigned int n)
+{
+	if (!n && !cpus_have_final_cap(ARM64_HAS_HPMN0))
+		return 1;
+	return n;
+}
+
 /**
  * kvm_vcpu_read_pmcr - Read PMCR_EL0 register for the vCPU
  * @vcpu: The vcpu pointer
@@ -923,8 +930,12 @@ u64 kvm_vcpu_read_pmcr(struct kvm_vcpu *vcpu)
 	u64 pmcr = __vcpu_sys_reg(vcpu, PMCR_EL0);
 	u64 n = vcpu->kvm->arch.nr_pmu_counters;
 
-	if (vcpu_has_nv(vcpu) && !vcpu_is_el2(vcpu))
-		n = FIELD_GET(MDCR_EL2_HPMN, __vcpu_sys_reg(vcpu, MDCR_EL2));
+	if (vcpu_has_nv(vcpu) && !vcpu_is_el2(vcpu)) {
+		u64 hpmn = FIELD_GET(MDCR_EL2_HPMN, __vcpu_sys_reg(vcpu, MDCR_EL2));
+
+		if (hpmn < n)
+			n = hpmn;
+	}
 
 	return u64_replace_bits(pmcr, n, ARMV8_PMU_PMCR_N);
 }
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index 0fe4f593d3f9a..bebf981855040 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -137,6 +137,7 @@ u8 kvm_arm_pmu_get_pmuver_limit(void);
 u64 kvm_pmu_evtyper_mask(struct kvm *kvm);
 int kvm_arm_set_default_pmu(struct kvm *kvm);
 u8 kvm_arm_pmu_get_max_counters(struct kvm *kvm);
+unsigned int kvm_arm_pmu_part_hpmn(unsigned int n);
 
 u64 kvm_vcpu_read_pmcr(struct kvm_vcpu *vcpu);
 bool kvm_pmu_counter_is_hyp(struct kvm_vcpu *vcpu, unsigned int idx);
@@ -277,6 +278,11 @@ static inline u8 kvm_arm_pmu_get_max_counters(struct kvm *kvm)
 	return 0;
 }
 
+static inline unsigned int kvm_arm_pmu_part_hpmn(unsigned int n)
+{
+	return n;
+}
+
 static inline u64 kvm_vcpu_read_pmcr(struct kvm_vcpu *vcpu)
 {
 	return 0;
-- 
2.56.1.708.g77570a6a1d-goog

