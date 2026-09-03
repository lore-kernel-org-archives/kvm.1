Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CD850EC00
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 19:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788464226; cv=none; b=cq79KOe7eTx8qLnNmHCs3FI0uVStAMlDGogkxyP1wZ2yoQVcRi/8PmFeiuUaUbQQyUJAKIJkr0Oq8ca2/CrMz4u8jiyuo8ZACzif74ld+YZSL86E9Tal3hxIReCAXHLG+nLbgPPGufPN/cPmpIASOvEK327CHtbZC8TBFfvb97c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788464226; c=relaxed/simple;
	bh=nfAqIBpbHALpOgja1VKL1Lm8IsHvJkYBLUNkpYYavVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JGLS/uXhwJhu9AqQlxUlirJ+rsrWjB+fQ9/DtrMumYKEAFxKnCadT7Feiq30125D1xIP7kYlHmhWCoGtN0O7TvKQQvRn+6e9hwZPCCzPEaEchKAx91fbDSoBAFiRJCmAD7tdWvQfLS2raSEJFrcpOYeuIT0G5L7sPuzNc6IYZ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RLE4/nEq; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RLE4/nEq"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc328b43a56so309472a12.2
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 12:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788464196; x=1789068996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HmGpSn5np7qxh7tTF9vO+IGJge7cylIvjl4owtZOfJ8=;
        b=RLE4/nEq9BdoUIkJ0moy+ybiUEDMpcc7ziPZw1CndT/mmMtNODf1sTJ50fFC/tYlbQ
         49kIL06RpoqVNn/xSA1teJR99HYWWps5LXrfX5DAtop9cqD/elMbq8naZpdXJOXKBDgI
         pV5Q0eZYtmM7K+IV19wGxJr/KNfDxecUNBjW+qI9wjOwsGactpzruB7oMw/+0vvPf958
         zDIJA8J/iKcvUcsFnn3jUY3C4zAg/FtDMk4fn8w3i67KejPqcSkpjVdqoIhpVUA3o3oR
         /vES43HosVppO5WijYn6uAWC61XVQaM6tn3ad/ntSi/kP1F0QcygiKIujxUlc2vaPCHe
         obBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788464196; x=1789068996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HmGpSn5np7qxh7tTF9vO+IGJge7cylIvjl4owtZOfJ8=;
        b=Mlqrh37PrVcL+SZVCbb5ea2cA1aerJgfbOgyLKmKtWFGP/b3gq3ulI+/ILF7d48eMp
         rdpI4OsZtsrY4+W215jyxIwOS72T9CrcxuE7I0cpQCL8Mw8XJUvuKHHcHCuhoyAu84MO
         UZbj3jgAkenk7rvdZAQ0DlayQ1aRn3ItNAajMLg+Cl+ehXza/Uz3orMyXrSxmY3V8bgQ
         Zue/N81L2+qU/JN3i1Y2RnQvSHpCeWYRH8Qe5N2wCTd7W9z8+/VYK1IyqnblZmQO+0VS
         hXbqeWx5NyG2fym1mhSSTeyYWLIyK622oAaw1s1Yj2NKNKhnms80XAcczw7BrRoSC68f
         73xA==
X-Forwarded-Encrypted: i=1; AKwUvBwMNF/ZZNMFSzcQ4PybIdGO9xEhd6I59hqsS3nH8ZkAvlxoXNqkJYQpJMTQhLf71rQ5Ouw=@vger.kernel.org
X-Gm-Message-State: AFuF++nN8aA/Xmj/WP2FekMcNMXuoK0jWPpoaruTsI4w+otJzKxSgyCp
	i7DdIP9OG9pfvCksdfYvUIcXAsaSOUlx0W6LpmMbIHvgCihof50cmFBn+7tjVr8Zuoc=
X-Gm-Gg: AYBFou2Pw71wOryMSuLDI461FhYhH4QGGL7zBHtWcOwHl1+nRIOYD3rZ8w0aNz+ONTm
	i/cRoR9B9H5vKhbbUhTLd6EwX+orTfcrXfEJ3gnOoCKIHsm/FP1Eroe2CtiBgpexsIs5w+Rju5Q
	24Qb7Pth68imHm87Ssr6Yz32F8pS2X7XKc0Dt5SfE1pYkEEsJxzY/p/maJ2LP63VHQD0SK+Rn32
	ZDDKEcMjtG9t9M7ag8qPawxcie1a+KS2GH1qwwEfOXQUU92hx7t9kViLHV7qhTeyOHiZKC2mplV
	1bKGwALIDvSuqf+e6W/09807zC9mgv/9sSwHi5KACFobg1laibjmI1B5WQSLP9/PLOR31zs4jr2
	6ocau7zlg0j2eeoC5vuUleSGY4GVYUL9Ug9jYH44d6xVO98LnNiRpTM/14VTdw2e8XGZV3xlh1/
	urKNdTUojooAw2n1yuc56gZ4r6HV34wITR9/6zDCZ2fBTlMvtgTIAHCO6S3RIohxU9hQ4Kvv+Pq
	mjjj2NZp85EwBA=
X-Received: by 2002:a17:90a:ec8d:b0:38e:67e1:15b with SMTP id 98e67ed59e1d1-39b261002f5mr1254010a91.6.1788464195615;
        Thu, 03 Sep 2026 12:36:35 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:40c0:ec33:6266:c275])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e4fafsm6836951a91.1.2026.09.03.12.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:36:35 -0700 (PDT)
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
	lorenzo.pieralisi@linaro.org,
	gshan@redhat.com,
	enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org,
	mathieu.poirier@linaro.org
Subject: [RFC v4 12/24] target/arm/cpu: Set number of breakpoints and watchpoints in KVM
Date: Thu,  3 Sep 2026 13:35:59 -0600
Message-ID: <20260903193611.1058589-13-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
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
index 6bbc942f9a59..d256d66a3e1b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1173,6 +1173,10 @@ struct ArchCPU {
 
     /* Generic timer counter frequency, in Hz */
     uint64_t gt_cntfrq_hz;
+
+    /* Allows to override the default configuration */
+    uint8_t num_bps;
+    uint8_t num_wps;
 };
 
 typedef struct ARMCPUInfo {
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 4e8c47253086..18adb06d78ad 100644
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
@@ -807,6 +887,7 @@ void aarch64_host_initfn(Object *obj)
     kvm_arm_set_cpreg_mig_tolerances(cpu);
     kvm_arm_set_cpu_features_from_host(cpu);
     aarch64_add_sve_properties(obj);
+    aarch64_add_kvm_writable_properties(obj);
 #elif defined(CONFIG_HVF)
     hvf_arm_set_cpu_features_from_host(cpu);
 #elif defined(CONFIG_WHPX)
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index ca25b707a0a8..93686b038263 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -912,6 +912,56 @@ out:
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
@@ -1128,6 +1178,12 @@ void kvm_arm_reset_vcpu(ARMCPU *cpu)
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

