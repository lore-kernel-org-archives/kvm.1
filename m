Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61C63DC4CF
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 22:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783464219; cv=none; b=GTP6h1vqYmkCQeslYCCuziDQztCxITPpqLPlIgPvMpa7QPvZSF+nJyKNYPx7sev1CqGM2iuq14pTSZtDPS/kXQMCXAyC1ziHNmyyWXTQD+cmx2TwTzhUa8xcR+allLkJ1CnmWd7jlzYVtQYpEhn9ZyiyhAr2R3Ude8gfXqbjAbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783464219; c=relaxed/simple;
	bh=J29PjBooAE6i3TKxYUIon5bXgfs5jNkLN8ASTY9xUVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DAg1JwQpJK9VQzYLeaKpH1f9A/iQ3bfXjWa2cpmZix5ktdffjSU06uLDX4NWTjMkNsP265KkEpmtOh+Yc6FtCm5nKcEyzDkGdQ3Ex6uW65beMtDF1eXVlz4Bba/9QQ/YhzO67VRwVsTdFDpNrm3db41Zq4UJAVsS6Rg0wZcOP+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nbth7pJw; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nbth7pJw"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c7c61b5292so1886985ad.0
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 15:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783464217; x=1784069017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hpv+v9qVvBs+eVXA8WG5n3FRwshlRky5Pwtj146tV58=;
        b=nbth7pJwd7YoFPZDLQM6zIMR6UEh65V78um+jOWOPe/gi5N2N2sGN2Q8fNzqLls3wy
         H/RfVR/5dvkIVjdb8umuRo84CfctRgFHBYLwBtLgMrsfyHM6a6x2NMIFIi7nm8qRXLXp
         0DPOmbVSrwwp/yis5IZf7yKcF/S/pl3HDYpYMqQnBonMgzJlsEhD4hEZA1tgGzY1p6hL
         gewR229Al4l8ahkx3LqW3wuEwTr622k+pL66FKfkAfz56MatGrQmvlqOF1q4M9U6LzxY
         gzT2Ff3IAsvNI5kKUfLnt4z15Nh4LT48+NHtRPuBvjtODufZWmdKFre8TFY7nxGZkgjr
         Oe3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783464217; x=1784069017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hpv+v9qVvBs+eVXA8WG5n3FRwshlRky5Pwtj146tV58=;
        b=P1AAfHmSUXFXms9M2nFHaQbnqMlwZD4gI8h3BqkGwXMMCfJ0uGQM1+iT7rwLG7qC4L
         DBkp0ZlQjOILDDYNQB8sQvIJkMLu77ZP9OWO8xuvWfiL3yql8AxVZmHDIpWmK8UM7Tun
         lC40Ik4KHlmXMStl3YSL3A85A6Havt1AVILcYxqxIf4O2Z0Kj/RQEXXorVDn4kJLavMk
         Vgo3B1DjDkPfH8phlmZbMcmp/YrxZ3B76PLIAsAU+hmczZZzQ+ob3lKZM7/skYwE1Q9j
         xM8DdeNPLbE1W15lwPjtSTmr/8olewebHya7tB6t/pxtoomHGbmjRyk1YFM3b5lzOgaj
         tYzw==
X-Forwarded-Encrypted: i=1; AHgh+Rp9Pt+D+XvPH+IOL7MKS5pUnNegcVy8tQ6jmHaZABIbgmPxP/Pe5AAfg/nRF36T1Er7vpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR8ZXhRr2spP9SZouZRrxIDi7fGXsQxFtni1YKSa7FgPbOBY7Q
	pfXF6ZJq+XKr5ADY6iqPhk9PVcltZdArPAbKD/OQGq6eC4FNPhPjmka3bhVqBr5QJ5c=
X-Gm-Gg: AfdE7clm/0NGMjVBU/A020mcBDTyHqO9vuJGY0e8Apf3BHQ1vOl+CVvLD9tfGE3+ady
	UIJcS2y7lrOXcxhPkouOfdaGIjwCeRzJpM9CclhvRjPVNs48ub4g/Nlk0h+s/VDhFJDz7LlSBYP
	UfEIiDeohuAfajfFnabvDfRUUoytprIQMRnxoHsEOkmgMA8jGju3Uby2YAMUvFG4IukUmnAtaIs
	DoTdPIljHvF8EL212K/JKfKFYdm1bVpSHiz0Rmq7zYrI+syMBR97jCgqyWpFz2Zdzdr6J2DatYX
	TutA2SsHYm1+2NUQFGH9gxZvnoemwKuymro+2V5eJOXxPYp2vjGhPiKPPLI/AXb30rOw+8WBBgd
	Ml2j4ZhgoFUFESiq9U16bceRPUAKTPbryCNCYLwlr0tPzD9BvzRwDui5Iqmht5C6Pnyws+J9VrH
	w1kmFxv7F2y2Fa1K593SkEw/5abHeGq5qiZBgcsiM=
X-Received: by 2002:a17:903:110f:b0:2ca:6d87:cda0 with SMTP id d9443c01a7336-2ccea2a5ddemr100945ad.6.1783464217123;
        Tue, 07 Jul 2026 15:43:37 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:46c8:dda7:40fa:8958])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bbaesm18183805ad.57.2026.07.07.15.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:43:36 -0700 (PDT)
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
Subject: [RFC v1 13/25] target/arm/cpu: Set number of breakpoints and watchpoints in KVM
Date: Tue,  7 Jul 2026 16:42:54 -0600
Message-ID: <20260707224306.1202330-14-mathieu.poirier@linaro.org>
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

Add "num-breakpoints" and "num-watchpoints" CPU parameters to configure
the debug features that KVM presents to the guest. The KVM vCPU
configuration is modified by calling SET_ONE_REG on the ID register.

This is needed for Realm VMs, whose parameters include breakpoints and
watchpoints, and influence the Realm Initial Measurement.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/arm-qmp-cmds.c |  1 +
 target/arm/cpu.h          |  4 ++
 target/arm/cpu64.c        | 81 +++++++++++++++++++++++++++++++++++++++
 target/arm/kvm.c          | 56 +++++++++++++++++++++++++++
 4 files changed, 142 insertions(+)

diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index 83ec95c290f6..9ed65eb090d7 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -76,6 +76,7 @@ static const char *cpu_model_advertised_features[] = {
     "sve1408", "sve1536", "sve1664", "sve1792", "sve1920", "sve2048",
     "kvm-no-adjvtime", "kvm-steal-time",
     "pauth", "pauth-impdef", "pauth-qarma3", "pauth-qarma5",
+    "num-breakpoints", "num-watchpoints",
     NULL
 };
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c7927036360c..d6f64daec2a3 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1174,6 +1174,10 @@ struct ArchCPU {
 
     /* Generic timer counter frequency, in Hz */
     uint64_t gt_cntfrq_hz;
+
+    /* Allows to override the default configuration */
+    uint8_t num_bps;
+    uint8_t num_wps;
 };
 
 typedef struct ARMCPUInfo {
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 28167355773b..3f12009befa8 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -666,6 +666,86 @@ void aarch64_add_pauth_properties(Object *obj)
     }
 }
 
+#if defined(CONFIG_KVM)
+static void arm_cpu_get_num_wps(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    uint8_t val;
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    val = cpu->num_wps;
+    if (val == 0) {
+        val = FIELD_EX64(cpu->isar.idregs[ID_AA64DFR0_EL1_IDX],
+                         ID_AA64DFR0, WRPS) + 1;
+    }
+
+    visit_type_uint8(v, name, &val, errp);
+}
+
+static void arm_cpu_set_num_wps(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    uint8_t val;
+    ARMCPU *cpu = ARM_CPU(obj);
+    uint8_t max_wps = FIELD_EX64(cpu->isar.idregs[ID_AA64DFR0_EL1_IDX],
+                                 ID_AA64DFR0, WRPS) + 1;
+
+    if (!visit_type_uint8(v, name, &val, errp)) {
+        return;
+    }
+
+    if (val < 2 || val > max_wps) {
+        error_setg(errp, "invalid number of watchpoints");
+        return;
+   }
+
+    cpu->num_wps = val;
+}
+
+static void arm_cpu_get_num_bps(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    uint8_t val;
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    val = cpu->num_bps;
+    if (val == 0) {
+        val = FIELD_EX64(cpu->isar.idregs[ID_AA64DFR0_EL1_IDX],
+                         ID_AA64DFR0, BRPS) + 1;
+    }
+
+    visit_type_uint8(v, name, &val, errp);
+}
+
+static void arm_cpu_set_num_bps(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    uint8_t val;
+    ARMCPU *cpu = ARM_CPU(obj);
+    uint8_t max_bps = FIELD_EX64(cpu->isar.idregs[ID_AA64DFR0_EL1_IDX],
+                                 ID_AA64DFR0, BRPS) + 1;
+
+    if (!visit_type_uint8(v, name, &val, errp)) {
+        return;
+    }
+
+    if (val < 2 || val > max_bps) {
+        error_setg(errp, "invalid number of breakpoints");
+       return;
+    }
+
+    cpu->num_bps = val;
+}
+
+static void aarch64_add_kvm_writable_properties(Object *obj)
+{
+    object_property_add(obj, "num-breakpoints", "uint8", arm_cpu_get_num_bps,
+                        arm_cpu_set_num_bps, NULL, NULL);
+    object_property_add(obj, "num-watchpoints", "uint8", arm_cpu_get_num_wps,
+                        arm_cpu_set_num_wps, NULL, NULL);
+}
+#endif /* CONFIG_KVM */
+
 void aarch64_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp)
 {
     uint64_t t;
@@ -806,6 +886,7 @@ void aarch64_host_initfn(Object *obj)
     kvm_arm_set_cpreg_mig_tolerances(cpu);
     kvm_arm_set_cpu_features_from_host(cpu);
     aarch64_add_sve_properties(obj);
+    aarch64_add_kvm_writable_properties(obj);
 #elif defined(CONFIG_HVF)
     hvf_arm_set_cpu_features_from_host(cpu);
 #elif defined(CONFIG_WHPX)
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index c69b5310c184..e4b4d5450c70 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -904,6 +904,56 @@ out:
     return ret;
 }
 
+#define KVM_REG_ARM_ID_AA64DFR0_EL1     ARM64_SYS_REG(3, 0, 0, 5, 0)
+
+static void kvm_arm_configure_aa64dfr0(ARMCPU *cpu)
+{
+    int ret;
+    uint64_t val, newval;
+    CPUState *cs = CPU(cpu);
+
+    if (!cpu->num_bps && !cpu->num_wps) {
+        return;
+    }
+
+    newval = cpu->isar.idregs[ID_AA64DFR0_EL1_IDX];
+    if (cpu->num_bps) {
+        uint64_t ctx_cmps = FIELD_EX64(newval, ID_AA64DFR0, CTX_CMPS);
+
+        /* CTX_CMPs is never greater than BRPs */
+        ctx_cmps = MIN(ctx_cmps, cpu->num_bps - 1);
+        newval = FIELD_DP64(newval, ID_AA64DFR0, BRPS, cpu->num_bps - 1);
+        newval = FIELD_DP64(newval, ID_AA64DFR0, CTX_CMPS, ctx_cmps);
+    }
+    if (cpu->num_wps) {
+        newval = FIELD_DP64(newval, ID_AA64DFR0, WRPS, cpu->num_wps - 1);
+    }
+    ret = kvm_set_one_reg(cs, KVM_REG_ARM_ID_AA64DFR0_EL1, &newval);
+    if (ret) {
+        error_report("Failed to set KVM_REG_ARM_ID_AA64DFR0_EL1");
+        return;
+    }
+
+    /*
+     * Check if the write succeeded. KVM does offer the writable mask for this
+     * register, but this way we also check if the value we wrote was sane.
+     */
+    ret = kvm_get_one_reg(cs, KVM_REG_ARM_ID_AA64DFR0_EL1, &val);
+    if (ret) {
+        error_report("Failed to get KVM_REG_ARM_ID_AA64DFR0_EL1");
+        return;
+    }
+
+    if (val != newval) {
+        error_report("Failed to update KVM_REG_ARM_ID_AA64DFR0_EL1");
+    }
+}
+
+static void kvm_arm_configure_vcpu_regs(ARMCPU *cpu)
+{
+    kvm_arm_configure_aa64dfr0(cpu);
+}
+
 /**
  * kvm_arm_cpreg_level:
  * @regidx: KVM register index
@@ -1120,6 +1170,12 @@ void kvm_arm_reset_vcpu(ARMCPU *cpu)
         fprintf(stderr, "kvm_arm_vcpu_init failed: %s\n", strerror(-ret));
         abort();
     }
+
+    /*
+     * Before loading the KVM values into CPUState, update the KVM configuration
+     */
+    kvm_arm_configure_vcpu_regs(cpu);
+
     if (!write_kvmstate_to_list(cpu)) {
         fprintf(stderr, "write_kvmstate_to_list failed\n");
         abort();
-- 
2.43.0

