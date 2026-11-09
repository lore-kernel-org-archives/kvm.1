Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263496;
	b=AXN1rB31GdkEd6DmnIKstf72XdKtHuZvaehDXShcoCEDm0VJNC0IGH40IZTdE/aqLEmi
	 e6ukkL48CLg95Qxc/FJiqmYSNCmeIVeKp5UGRlpL8MG8w8SfFbBeCL6YW504voU+TUdlQ
	 mWMdC3z6zcKI0E1llSUC2fYLCs7bWR+s9RNUY/pbEdxgj7LRuW/Auce3hRkOEpFpNMsLE
	 OZGPD41jOtVZ8RUxgtLmyigHO3EuWzVpvVNynsBh7bQfjJ/2H+OAVbq7LW1YlBheZXX5Q
	 BB4p8/mxhIvGJL2h05L4wbA46/ZlQyHx/uKP6dKhlKachnmf8DtI56akH9GymIvN7Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263496;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CyA3SEtVAYsvKr4mkOVI+9l6CkCv7zCE6lbG/JjjfMo=;
	b=KxbPCsGL5ng5VUAP82MTbzMABS5/jzLZh33taGc9Z+57ZLNLqUR8ZfVJVceyp8kI6gDK
	 KJwmnPek4pL42IxQDXWoTaGdz3D6E5Cg1wg9rCG7sXBg87DWtMTdzvhMsLIOJivcRqm4C
	 6tJKD66mH83bnK3C/BzwDGthr1mQktz/v5z0aDmfMB7PP6X8ryoql/zgOdK8qUKeD4UZC
	 5IK4gQ3WSX86xQRNcvtph1NdZsJU2zlfDkMDtTzrDPBSssWMWpb8hYgOtSLbMqjB0qHCX
	 EGP3Lc2F65KV/MggmZDnYbkJtxIgBGRvel191yWgaOTQ672oMKMebVSMHfbk9WSifXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Xy+casMD;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF98606A332
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 22:31:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DF98606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Xy+casMD
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8a9f9473029so1101598b3a.2
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 14:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794263495; x=1794868295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CyA3SEtVAYsvKr4mkOVI+9l6CkCv7zCE6lbG/JjjfMo=;
        b=Xy+casMDursBqHAPjkZLmI55VF82U0EN9Rp81Ep33B0mrCTmx53MGTWwrACx/ToO+a
         /bn3Xi0yNHOi2r/ko/ggcCkyj8qDYaUDEYC+fYkuH4YRyAGetaaH9ADmL9k4uLLrTJlG
         Ib1k+/CzftmhyC3XSXTGm1Q/+y50DnihopeaNejuZmWdz3Se6JUi5EjaEReqmaV+i8d6
         fwxCf2Ij1PmdJI1IFdblGyEQ6CuNozC4Wc0k7cq7ELJKhbooe0IQu2jQcL5iWDk4eWy7
         bQ6Ebp7DFVxfTLcY26AFB7iu3JQRfwMn9aRgWJUuD6L+uKJmoZYJE6y+5//DQ/0HQpWH
         NMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794263495; x=1794868295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CyA3SEtVAYsvKr4mkOVI+9l6CkCv7zCE6lbG/JjjfMo=;
        b=Jb21Mxh7YocnZoknpsCf30AevVWroRKullJbVgqK6bqLMRdp9mMaWtOUDI4zEq00q5
         sofWKvgY+bEf9YlNq2pzRENOJmTWifiIT7MNZS5a01kwyRQpUWGpa9KkMCP7D8VnqcFm
         eiEIdLlItokQmzt4iPmxHrkXt7GVLo/wuZkpARJ5AfS/KvqEH5BCAgo3SmqpguQzyNjg
         yz8guVXokgKC1pRnqvONa9YgAnpy5nLVpyzqOMPiRk7yimgtHThcX/IYbwnu6J3pColo
         xspIxwZxVODxSNwZusKgBrdkRa1wyVd+qC1I0h46W8b813QmYL3qoDUWi+3qSZGJIXk6
         dbIA==
X-Forwarded-Encrypted: i=1; AL+hErHA4gtOewDhgh7hhl31ssyomj+bo/e8ch4z/rBkQ8kytw5jhAS+wtrQnFnWQnstQHONMyU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+D7wo7CoKAHZWGBaaxBikMMwE6sj5Hl3uLeGrNXBCo5zBrs3ud
	UCmyEVWsduSz/1A7uQypq9Lc5LrfXTNEZoJv9mskag7o6xjGeAwF954SOkHqXKhPxyA=
X-Gm-Gg: AYBFou1iRxbkoEZVMGj13Qu76+zjRKTu1xdCxelpsLkYpfmfARqyy9s77HEsB7OUv/h
	CCefpMMRK+jMG/3DLMlPEO0TcmUNgZkCMwI/2NYbsYQp41eiRVNeiZyG02hype/ydHMpmOlzaCg
	+nJaC0HZloBTBI2rNlcw1qJ6SQxdnCmF0zcArgUbqtGQa2SEVHp8RAgx9Yqrf5Ta2eRXqtLXerM
	VWT8yzoinnZm2qkzZYK9FBTGI6Z+IGVdUtpnjgssv6at2R3g9DS10YXiyQJFxVYFP0cHXZjInax
	+hnWcfhVo3L/IY/lhb3c0j2BysQq3CGpXTHY19GXmSFtTCaODCWxtR/Wx+Ag4g/VjjFXhuM9o8r
	vRBj/o9YI3ylFyLxTYyoTokDi4aClKC7Au7BQv1zM9EzMLjxlrxEjj9tKTDsh6NVJmEgo3WfogK
	YeX8GUJAxkHGvwbLLsj7Dt6m+8YU7+LBlVoRZDDJEiXeYcHEsVeBU9vnF7tSZDWL8Sd3REJ3CiV
	BF+ImfFyOzKMsPzHfaQQkAKt1N82bVbST49ndq4JIQ3kTqzgX1To0DYcjIGl6AJPmEKqOHMpSCy
	LrjVbV6JmroXt79JyzjdYvyUIgEt5tfp8qTO0+VkkYzS8jYihg8k8uh19iNJyJb/BSow1UlaKl8
	=
X-Received: by 2002:aa7:9315:0:b0:8b5:9654:d331 with SMTP id d2e1a72fcca58-8ba7fab49a4mr1110386b3a.0.1794263494909;
        Mon, 09 Nov 2026 14:31:34 -0800 (PST)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:54d7:1b5:4356:16fb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa506bca4sm165830b3a.0.2026.11.09.14.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 14:31:34 -0800 (PST)
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
	gshan@redhat.com,
	michael.roth@amd.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v6 11/23] target/arm/cpu: Set number of breakpoints and watchpoints in KVM
Date: Mon,  9 Nov 2026 16:30:58 -0600
Message-ID: <20261109223110.1619504-12-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
References: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
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
 target/arm/cpu64.c        | 94 +++++++++++++++++++++++++++++++++++++++
 target/arm/kvm.c          | 49 ++++++++++++++++++++
 4 files changed, 148 insertions(+)

diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index 9d3a3d9aa472..1c2f31db0d30 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -77,6 +77,7 @@ static const char *cpu_model_advertised_features[] = {
     "sve1408", "sve1536", "sve1664", "sve1792", "sve1920", "sve2048",
     "kvm-no-adjvtime", "kvm-steal-time",
     "pauth", "pauth-impdef", "pauth-qarma3", "pauth-qarma5",
+    "num-breakpoints", "num-watchpoints",
     NULL
 };
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b2f393f50184..dfabcfc5eda1 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1203,6 +1203,10 @@ struct ArchCPU {
 
     /* Generic timer counter frequency, in Hz */
     uint64_t gt_cntfrq_hz;
+
+    /* Override the default configuration, only for RME vCPUs */
+    uint8_t num_bps;
+    uint8_t num_wps;
 };
 
 typedef struct ARMCPUInfo {
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 0e5956e5fe6b..a34de3d2947c 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -33,6 +33,7 @@
 #include "system/tcg.h"
 #include "kvm_arm.h"
 #include "hvf_arm.h"
+#include "hw/core/boards.h"
 #include "whpx_arm.h"
 #include "qapi/visitor.h"
 #include "hw/core/qdev-properties.h"
@@ -680,6 +681,98 @@ void aarch64_add_pauth_properties(Object *obj)
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
+    if (!MACHINE(qdev_get_machine())->cgs) {
+        error_setg(errp, "num-watchpoints option is only valid with "
+                   "condifential-guest-support");
+        return;
+    }
+
+    if (val < 2 || val > max_wps) {
+        error_setg(errp, "invalid number of watchpoints");
+        return;
+   }
+
+   cpu->num_wps = val;
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
+    if (!MACHINE(qdev_get_machine())->cgs) {
+        error_setg(errp, "num-breakpoints option is only valid with "
+                   "condifential-guest-support");
+        return;
+    }
+
+    if (val < 2 || val > max_bps) {
+        error_setg(errp, "invalid number of breakpoints");
+        return;
+    }
+
+    cpu->num_bps = val;
+}
+
+static void aarch64_add_kvm_writable_properties(Object *obj)
+{
+    object_property_add(obj, "num-breakpoints", "uint8", &uint8_type_info,
+                        arm_cpu_get_num_bps, arm_cpu_set_num_bps, NULL, NULL);
+    object_property_add(obj, "num-watchpoints", "uint8", &uint8_type_info,
+                        arm_cpu_get_num_wps, arm_cpu_set_num_wps, NULL, NULL);
+}
+#endif /* CONFIG_KVM */
+
 void aarch64_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp)
 {
     uint64_t t;
@@ -829,6 +922,7 @@ void aarch64_host_initfn(Object *obj)
     kvm_arm_set_cpreg_mig_tolerances(cpu);
     kvm_arm_set_cpu_features_from_host(cpu);
     aarch64_add_sve_properties(obj);
+    aarch64_add_kvm_writable_properties(obj);
 #elif defined(CONFIG_HVF)
     hvf_arm_set_cpu_features_from_host(cpu);
 #elif defined(CONFIG_WHPX)
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 80296e0a867c..c8a821d7fab6 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -985,6 +985,51 @@ out:
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
+    if (ret || val != newval) {
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
@@ -1201,6 +1246,10 @@ void kvm_arm_reset_vcpu(ARMCPU *cpu)
         fprintf(stderr, "kvm_arm_vcpu_init failed: %s\n", strerror(-ret));
         abort();
     }
+
+    /* Update KVM state before it's loaded to CPUState */
+    kvm_arm_configure_vcpu_regs(cpu);
+
     if (!write_kvmstate_to_list(cpu)) {
         fprintf(stderr, "write_kvmstate_to_list failed\n");
         abort();
-- 
2.53.0

