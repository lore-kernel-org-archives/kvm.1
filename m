Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7527748097B
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 22:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783464222; cv=none; b=rSymqRmbNq0nIvvi7K3gXRODRineI7/Cve0o9aGOtrsftyIJVc0trUifSHoc5gVqIppIizJ9yyn5vyIspRYxghMI3WLUobVsPXrg31Y2/UR/8BRzeR+3qlRBEzin0f58abDzy0O3lDY4CjyoZlm07mcCumpst+L4qyNlyXANi2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783464222; c=relaxed/simple;
	bh=l33hEDbGH+ROjM3utjOkl+bMEFa4XoIj4eZ9Al4PSS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vk84TGbXb8Jzc8NLghOiGDSitxDLBFVPm171bkO2Lg+YOHhW7gg+469T0e5onfSXUbtPntTH+7NtjsOP2IsflSjOed3c4rOWG/oml0KJwJV0LW1LOWPx2EtpBRbt9fPvHPF35I5T913nuGAsc6KLSnLpFA5Pas/YhfNtp45QnvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qk4icF6R; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qk4icF6R"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cc97653887so885445ad.1
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 15:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783464220; x=1784069020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIviMsn5Rq1UtJcdpFZj4ZD1p4JzYpgAt1W5TU8JGlc=;
        b=Qk4icF6R7aodcYL1UCXVZ3ve0zNGWfO5MftnBB/bhmIHHOksfIIXduuEg+iOL/KYLX
         Xk7pmPnvTvjfkdswDgUCacxyFVIsTPUxmxaJfe9HcgE52y3gAjLJqzfiN5Is2JVnZdZL
         oVvOQewrpHchiYJWolsfBCUiEp3duOUea6SozNb4LvSkDDRFy+ZfSakp+2YhpNwnecNF
         XvHhyZ3X4WCr2cMNs8k7/r5MonvO1Mp+1kcxfQAghDz0Kr0lLXt8crGEsFbxqBP6RrtC
         BoKm6HVZBkSZ2vjof8FK4+AIxslT4qtR5hKbUq1PsBWciG38Un9pmJTnheyqQ0GiYeIY
         ZSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783464220; x=1784069020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oIviMsn5Rq1UtJcdpFZj4ZD1p4JzYpgAt1W5TU8JGlc=;
        b=Y3XAZfhodfNlKx6Q9aMG78HX+XyJ6yFJizz6jh/qwdcXaOBpwwnupVLFmk2CAGEYnU
         hvzPJPinsVZhZVv89SeoEPMr8whmL384f3mB+SjkiXrwrWr0tBF6pkBANjxrPWGC5xw5
         +MibMpAV/1oyDEOzKdotxmbOcaG4NBJQoXqLM4Y8GoazZ1/50n4O2s8Clw7tlEthKRKj
         W0qwMu0eGrrRmAnewe7p2jRRXKkJsA0vQnKdNbHPHU5HYosSUqviKnFd8xTL/8LJ6XQC
         XJSYuJye038kf3tk8VyeI1arXADyqWrfugLZYcTF9byfvU3GAdt5gRYQRaNvneMLQYj9
         1l2w==
X-Forwarded-Encrypted: i=1; AHgh+Rrdk8lCUb67OLgtQRvzVifYxUMXcaC6q10uhGpsClV+lHnOLR1wnGrYXohk6aaM4oo3PEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjmxcBGpe2m+853ge1W8b6KOMsumAu99H72RhebW92vIwaKRW1
	IeF6bJZp1/bA+xyOaVvmuFH/m+uJsrhiptowgS+Fytlfy/YAZ1dHilZIUFhkpbKs5dc=
X-Gm-Gg: AfdE7cmX1Opn03E+PdHu51C+wcLhYVWFsRRs+m3BARU3AxuehzSYPuSdbBYHLkWUYwZ
	j4clPALTyv06z+UofEXPgyNzFnya2TLvgmnyW3oYVR7myC3DptBddut5pduUhAcyV/kPFFPm89N
	c95WG5snoZ96MIhyqUKT4hoFwfnGxDmVYO7Cu+U407B3nk4mQCPPBOd6Zofc4mguZLG6T4c5dD1
	1LPlR/DW1KWHF1NNIfasZ/2Z3pDfk2P4LhRTiqUSiUeHmdkBiR/1tBTVfaRP9rXlPIvlnSXcTK6
	T/rNC5embWyLdfiCLJXxTK1miyzdAp/0UrJ1XUSQYXjUe62ID07ZbsC784cD3mu88tsVTCOfU5b
	6lks9W6h058sWNT4A+ks6SBlj7T0sf/8b8ne9hJ+BVNSNlW0J2MACYhsyDWl98jcP/Y0unmJreo
	OI77L3jgBOZWhOYf7lsxiqnoWmglkXRbA2+I5MqoY=
X-Received: by 2002:a17:903:285:b0:2ca:f16c:87b3 with SMTP id d9443c01a7336-2ccbe62863cmr63699725ad.19.1783464219016;
        Tue, 07 Jul 2026 15:43:39 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:46c8:dda7:40fa:8958])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bbaesm18183805ad.57.2026.07.07.15.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:43:38 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com,
	kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com,
	peter.maydell@linaro.org,
	mst@redhat.com,
	cohuck@redhat.com,
	pbonzini@redhat.com,
	eblake@redhat.com,
	armbru@redhat.com,
	jpb@kernel.org,
	lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v1 14/25] target/arm/cpu: Set number of PMU counters in KVM
Date: Tue,  7 Jul 2026 16:42:55 -0600
Message-ID: <20260707224306.1202330-15-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Add a "num-pmu-counters" CPU parameter to configure the number of
counters that KVM presents to the guest. This is needed for Realm VMs,
whose parameters include the number of PMU counters and influence the
Realm Initial Measurement.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/arm-qmp-cmds.c |  2 +-
 target/arm/cpu.h          |  3 +++
 target/arm/cpu64.c        | 41 +++++++++++++++++++++++++++++++++++++++
 target/arm/kvm.c          | 34 ++++++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index 9ed65eb090d7..9350dc30d12f 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -76,7 +76,7 @@ static const char *cpu_model_advertised_features[] = {
     "sve1408", "sve1536", "sve1664", "sve1792", "sve1920", "sve2048",
     "kvm-no-adjvtime", "kvm-steal-time",
     "pauth", "pauth-impdef", "pauth-qarma3", "pauth-qarma5",
-    "num-breakpoints", "num-watchpoints",
+    "num-breakpoints", "num-watchpoints", "num-pmu-counters",
     NULL
 };
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d6f64daec2a3..50d482b09b0d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1178,6 +1178,7 @@ struct ArchCPU {
     /* Allows to override the default configuration */
     uint8_t num_bps;
     uint8_t num_wps;
+    int8_t num_pmu_ctrs;
 };
 
 typedef struct ARMCPUInfo {
@@ -2134,6 +2135,8 @@ FIELD(MFAR, FPA, 12, 40)
 FIELD(MFAR, NSE, 62, 1)
 FIELD(MFAR, NS, 63, 1)
 
+FIELD(PMCR, N, 11, 5)
+
 QEMU_BUILD_BUG_ON(ARRAY_SIZE(((ARMCPU *)0)->ccsidr) <= R_V7M_CSSELR_INDEX_MASK);
 
 /* If adding a feature bit which corresponds to a Linux ELF
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 3f12009befa8..00b3511dcbc3 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -737,12 +737,53 @@ static void arm_cpu_set_num_bps(Object *obj, Visitor *v, const char *name,
     cpu->num_bps = val;
 }
 
+static void arm_cpu_get_num_pmu_ctrs(Object *obj, Visitor *v, const char *name,
+                                     void *opaque, Error **errp)
+{
+    uint8_t val;
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    if (cpu->num_pmu_ctrs == -1) {
+        val = FIELD_EX64(cpu->isar.reset_pmcr_el0, PMCR, N);
+    } else {
+        val = cpu->num_pmu_ctrs;
+    }
+
+    visit_type_uint8(v, name, &val, errp);
+}
+
+static void arm_cpu_set_num_pmu_ctrs(Object *obj, Visitor *v, const char *name,
+                                     void *opaque, Error **errp)
+{
+    uint8_t val;
+    ARMCPU *cpu = ARM_CPU(obj);
+    uint8_t max_ctrs = FIELD_EX64(cpu->isar.reset_pmcr_el0, PMCR, N);
+
+    if (!visit_type_uint8(v, name, &val, errp)) {
+        return;
+    }
+
+    if (val > max_ctrs) {
+        error_setg(errp, "invalid number of PMU counters");
+        return;
+    }
+
+    cpu->num_pmu_ctrs = val;
+}
+
 static void aarch64_add_kvm_writable_properties(Object *obj)
 {
+    ARMCPU *cpu = ARM_CPU(obj);
+
     object_property_add(obj, "num-breakpoints", "uint8", arm_cpu_get_num_bps,
                         arm_cpu_set_num_bps, NULL, NULL);
     object_property_add(obj, "num-watchpoints", "uint8", arm_cpu_get_num_wps,
                         arm_cpu_set_num_wps, NULL, NULL);
+
+    cpu->num_pmu_ctrs = -1;
+    object_property_add(obj, "num-pmu-counters", "uint8",
+                        arm_cpu_get_num_pmu_ctrs, arm_cpu_set_num_pmu_ctrs,
+                        NULL, NULL);
 }
 #endif /* CONFIG_KVM */
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index e4b4d5450c70..3d5e16a21cf5 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -949,9 +949,43 @@ static void kvm_arm_configure_aa64dfr0(ARMCPU *cpu)
     }
 }
 
+#define KVM_REG_ARM_PMCR_EL0            ARM64_SYS_REG(3, 3, 9, 12, 0)
+
+static void kvm_arm_configure_pmcr(ARMCPU *cpu)
+{
+    int ret;
+    uint64_t val, newval;
+    CPUState *cs = CPU(cpu);
+
+    if (cpu->num_pmu_ctrs == -1) {
+        return;
+    }
+
+    newval = FIELD_DP64(cpu->isar.reset_pmcr_el0, PMCR, N, cpu->num_pmu_ctrs);
+    ret = kvm_set_one_reg(cs, KVM_REG_ARM_PMCR_EL0, &newval);
+    if (ret) {
+        error_report("Failed to set KVM_REG_ARM_PMCR_EL0");
+        return;
+    }
+
+    /*
+     * Check if the write succeeded, since older versions of KVM ignore it.
+     */
+    ret = kvm_get_one_reg(cs, KVM_REG_ARM_PMCR_EL0, &val);
+    if (ret) {
+        error_report("Failed to get KVM_REG_ARM_PMCR_EL0");
+        return;
+    }
+
+    if (val != newval) {
+        error_report("Failed to update KVM_REG_ARM_PMCR_EL0");
+    }
+}
+
 static void kvm_arm_configure_vcpu_regs(ARMCPU *cpu)
 {
     kvm_arm_configure_aa64dfr0(cpu);
+    kvm_arm_configure_pmcr(cpu);
 }
 
 /**
-- 
2.43.0

