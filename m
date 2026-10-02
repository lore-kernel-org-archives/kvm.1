Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E740C515992
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 20:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790972449; cv=none; b=Z2KDZ8cd6QrXuHSrMLDZiJJH9b/YFabzSJQAQ7as0EcfD5T7Sg5/tPye21PJSoGGodQ5fYlIvjo6f1qi4tBKI2wruLwisWv7LH6uXAhoPOJL+Pn97g0bpdJx27cx4z6dwXXRqfwdGzrS2mFGM83uimJziaqNypnjHMnGtpTeihg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790972449; c=relaxed/simple;
	bh=eT9aG0FLLG27WbQEMVKfpFwG/Uunk8fjSpR7XDFk7JY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EHGQT7UuTXYFPKD50zg4OofecQApfCxpCase1hTfkLVvPzzxhqNF4eBvZtHCCRx3EdtAgB5XjSptX3+6KM6MBbWDya226ZokZHH9/6MNtZ7CpNqXnG5Ku1haa0jkkb0vOSg/cA239R0NELKq0CP+HnFG+fLbjL8Ii9++N8G8QNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=szVeS/p1; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="szVeS/p1"
Received: by mail-pj2-f41.google.com with SMTP id d9443c01a7336-2e4ba830297so4383355ad.3
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 13:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790972447; x=1791577247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LNCa6Tzmomloqbl8eACtic31CzImXJnX4jil7uO03Ps=;
        b=szVeS/p1tYPN0eFZ0OP1eHwEqzIGP0Rb2snT/Xx1cgBHXTYhEwODtttQkcXjE3nIOn
         Hl/sTO86SuwbHxDba8ZhPX/sK5HSOjz6ekef7026ObyYynMlZgR/8YCPMvGa6D3enlcZ
         a+iqHXaaD5yePoGeq0Gyu8xqwhyIjzJtwHKJ4rGVwZDT8dK7yxtF8KIjuLg8hX/YfbCM
         nxnsSH1IEQJLEMft0nY3TI2kOR7F2Usmo1AfSo363/z5I62W25fGIjqYhs7nQVenk8v5
         QG2JhEaJ1ccQ5QyC3bvAISFuBvboqh9XC/zXJKkLRDs9bFqldrSripd7lou0+BQZIjpJ
         sC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790972447; x=1791577247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LNCa6Tzmomloqbl8eACtic31CzImXJnX4jil7uO03Ps=;
        b=xQJ4YNTqThHY2I8gw7NlfxbBNonXJwoSdQPVUgG1p36g7NOJ9NpBbwUmX7Gb2CrjB4
         XIgpijCIEmUxfdhCpf98mDCVm8yBWW9xKnRvUILCeCO6mqYF4GpOxHpsc0ZTEPMb3lj8
         UzhX2tWWLrCNyOspGiNzl3FCuIcCnT6Us3OjLnj3OD9qfuK32v5ef2voqemk/aSxrmQ5
         3dypFunswfxOOnxzNwGW2yzj6jw5KBd9QxTeLUEAd04QKQr5ULqskFIw4WmnY9M7ey6k
         tSThiG05KaG3Rw8qU7GYAazc1hH9jooYOCqUJqtMAvvFMjGKJiH3CXZwSMeWSL/KkzRX
         j8Wg==
X-Forwarded-Encrypted: i=1; AKwUvBxUaM3RiCBw2w2vSwFT0rjfKFOewiVys/EwMfadOyIMJaeagqYPlIdhjtpDxCDOK99JR8M=@vger.kernel.org
X-Gm-Message-State: AFq9FYLlj0GgP4y//9s6puZfUHDIM7hq5B1Ao9YksVhvSLl9wKlY5oa4
	+h2vGOBss2ES988HHRNmOkgHmxpTTmHNGAsdhL4bQ7137P/Fo/41MLfqTLRSonyN6Iw=
X-Gm-Gg: AYBFou1K+0wUcptlZJ1u9DpgjDqtaPPXqGSD3Tu44b3SE5gn93SBcNkmvmcis9VyV6v
	XKctoHYwG1NGI2P80fA/QBvEtiwjK6UdrJ59UCvAyfTIp0KDEm5ZO2e/pZMA5yceAlbCDicZck6
	D2Vn+uAQLlUmt8jtgJWCHu1K4oewlOz8r62x2x1i3gtRWneFtzytCFC3IA3nrgX1xlQBobKWS8Q
	+LzonZ000MH3ssUYT55ReebnotnINbBfjPRCvJ9/mf2vP91IeqR3B8vvXBlKJFn1G6mRr7il/ZY
	YliI1KOiVBeeMzFtBk/LY/Oh3xBVpznW7L3gN2VAU7d+HgA83rGHwCdpPE79n8Qfn57GP3wUkbo
	reFoLbnWcasFHH3dDarxPV9ZMMeqEnUUuw3X44vOmbY1CqA7ogl139XsMtEUMi/2ANZrgJApvNo
	YTjRq5nswILfYlMHwj7YmeYstrbZnFuZjVWhXBrIAzIF8N6NNjqCJy+U3QkZl3TLl7spAo4LuW6
	yZXAWg9CeM2rvE3272TXI8U
X-Received: by 2002:a17:902:d506:b0:2ca:e19c:97b with SMTP id d9443c01a7336-2e49a104519mr38481225ad.5.1790972447074;
        Fri, 02 Oct 2026 13:20:47 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:61ac:e744:6559:a357])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f6a99acsm12399415ad.34.2026.10.02.13.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 13:20:46 -0700 (PDT)
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
	enju.kohei@fujitsu.com,
	lorenzo.pieralisi@linaro.org,
	gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v5 10/22] target/arm/cpu: Set number of breakpoints and watchpoints in KVM
Date: Fri,  2 Oct 2026 14:20:14 -0600
Message-ID: <20261002202026.1204110-11-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
References: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
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
index 11877642414d..2e41c2be3b71 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1197,6 +1197,10 @@ struct ArchCPU {
 
     /* Generic timer counter frequency, in Hz */
     uint64_t gt_cntfrq_hz;
+
+    /* Allows to override the default configuration */
+    uint8_t num_bps;
+    uint8_t num_wps;
 };
 
 typedef struct ARMCPUInfo {
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index dcd0d698b300..483441dfabe3 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -674,6 +674,86 @@ void aarch64_add_pauth_properties(Object *obj)
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
@@ -815,6 +895,7 @@ void aarch64_host_initfn(Object *obj)
     kvm_arm_set_cpreg_mig_tolerances(cpu);
     kvm_arm_set_cpu_features_from_host(cpu);
     aarch64_add_sve_properties(obj);
+    aarch64_add_kvm_writable_properties(obj);
 #elif defined(CONFIG_HVF)
     hvf_arm_set_cpu_features_from_host(cpu);
 #elif defined(CONFIG_WHPX)
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 10d911a56b0b..1acf62545e7a 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -955,6 +955,56 @@ out:
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
@@ -1171,6 +1221,12 @@ void kvm_arm_reset_vcpu(ARMCPU *cpu)
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

