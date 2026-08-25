Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8382392C2A
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 22:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695293; cv=none; b=Mu5Xaw1Lxmz2ty1YI0qV/OKyIk9HEN8viiYsKpf8dtWzgvvDAvMp62R0eqVca4UYTFaUAnV01AHLPo/YWCIeMgNGOEcMO5VZn1ifWeLamwK1dYcBRC870CcnTvpJM45zR45A3RDLfwBywQrIlw7W/UxPwA5hjBbsgKy6swtrHDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695293; c=relaxed/simple;
	bh=zt5YJstHp74x3/+ySDJDcLq31oOIfbYF2LgaTU2NNw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fnaF0fv39+feQ+Q9gX8N+ctr4qidq4xJrrxIBjnbSvwbEUPy4uvGZlHgdPAcJB3Cb+8ZAW0OuNSzX1LWEF8iCNcyH2TVl57vMNOqVUpJS05WJ8cqCL6wQedMUS2cbetBJpDveBeVJQclL//jRjRR2i8PcxPElUAKOzz0Qk6zm0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N4sF0Cmo; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N4sF0Cmo"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ce7d2adef4so5000835ad.3
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 15:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787695291; x=1788300091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ObfQI3bNIqj2MRAC8NKs4uPdrExrM8ymvQUurU0xN6s=;
        b=N4sF0CmoqC6YjjnSfEq+4ISxlQiID0wNHCDH8eU49Xkpkn3UQuxjZJq1MXg9cpW/IK
         T5gN0hypXW9PvuQoIKKw2Y14cHZUVhfz2VDUf4SHJWdDufHC1WEIrsL8ORvwbmNlPZKd
         ED/1boRIdGzt8CT7WS6AnsZWHkUMeR5DlbVMdLyQSlIo7O6tOZMfQpfdinFEszkpOglF
         iUqhc7Xp4ZGWPjf7iaV+h5OPMz8oSATyGkQgMOr+8AmuQ+ONcm5g1KqSZp+1EE2FIpfn
         0SzUf2C3Fx+ewQcnaLGSJfDBx6TKg1HURvaV5J5hqRf3YUiaZLcXTiPEx+lFfPqiUQa8
         vvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787695291; x=1788300091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ObfQI3bNIqj2MRAC8NKs4uPdrExrM8ymvQUurU0xN6s=;
        b=SwldH9wv9aGOx0u3MRceVprbQIxTG8xZL+X4r6aPg8jkasPbb6KB7JgIGWOLRHFA7N
         CByOUzQWD2/UPHHddC/PiC5Re6pL7h3AuWP8xg8cXEhAg71RT128VF2w66Z9s/mWSkL2
         Ckw5u3fxhdmhjMcSqydqXGmFmeul6BB5mJNXC5V58EkRKCFKPqR13qYE+pJebt6VQLCq
         jotag45/aafuseyxikhTPZiE5jp665Xgiv8xxraf67Pf9oWmlY6O3OtssvZa8rhAdp7i
         4fchXzBtT3vkOQuSBMHH64kquK7hzqk4Cd95KmDI5CraRXKvLK4EFAsY5JjV1mwmwn2U
         Rs4Q==
X-Forwarded-Encrypted: i=1; AHgh+RqcjMrWhgkC+zs2CrvGpitROrhVtCZO5oCDb4dXBIxZqZVYADNS7LHd9i4S4BobpN2EV8s=@vger.kernel.org
X-Gm-Message-State: AFuF++nJ76TmfjPwFkvnV44NbbJUQDiGH8pcxT3oDU9HP5lMrB3TlOGp
	16hPxRMe5SW/a0OHquO9qBjtnEXaePFL010ovlhzBZaO+rSrGghJRyHNFpnDLQGn77I=
X-Gm-Gg: AR+sD10R7HNVGY6G9hp5twGWXGpz4MrCtk4A5w/Qu5MJZOQCtqpku0PamyJ73nsiAp9
	03EGltDc0saGIQWPjAt/zq2EflgUfG1e/KBxtBo6fh4LgdvuApObWZZgeMrLS8MSmrKloYEDF6z
	81tvpkXReCsNOxUg07SFucK4sJ46ewvhIPv9sxyHEtWVG+7b+vjayeO5q8TDR5fFT4L6IfNxxBM
	OqTuS8/9SDrOLeY4oJ1nXLoaLFH847R0PfXKtBqXprUTDVWZha04/Jza77wYUZrQVlvBpOtAdzH
	VvIQTa5jMamm2QHNRhl/8woTezELk/0/J+N0ErAIaY0PnUBOaeWY9Cc/XTBsnMFK3XI+iBebq4y
	GdxL6bhZj6hImIk/cJSwxfnxLZIE+s2xuVofrtxwUcmaqiRXfAdSq8qtyJdr6kCmPGXYBBJiWYk
	vQFw43jrCPRy4Hx/jbCvOubntuIHGPkdvlsXcLiZbEsIIRxNkynEbM1tHeDLrFgos9pGDJKfZSo
	Ga4Kb502PK5b/8wYJlziWLX5Q==
X-Received: by 2002:a17:90b:388e:b0:396:6344:3b63 with SMTP id 98e67ed59e1d1-3966d364af9mr4339106a91.2.1787695291228;
        Tue, 25 Aug 2026 15:01:31 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:a37a:292f:1363:c0af])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3965d119724sm3090120a91.2.2026.08.25.15.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 15:01:30 -0700 (PDT)
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
Subject: [RFC v3 12/24] target/arm/cpu: Set number of breakpoints and watchpoints in KVM
Date: Tue, 25 Aug 2026 16:00:49 -0600
Message-ID: <20260825220101.3443954-13-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
References: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
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
index ee26a74c8e80..bc21291eb3e5 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1157,6 +1157,10 @@ struct ArchCPU {
 
     /* Generic timer counter frequency, in Hz */
     uint64_t gt_cntfrq_hz;
+
+    /* Allows to override the default configuration */
+    uint8_t num_bps;
+    uint8_t num_wps;
 };
 
 typedef struct ARMCPUInfo {
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index b38a78aac3f0..72c0176420fa 100644
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
@@ -863,6 +943,7 @@ static void aarch64_host_initfn(Object *obj)
     kvm_arm_set_cpreg_mig_tolerances(cpu);
     kvm_arm_set_cpu_features_from_host(cpu);
     aarch64_add_sve_properties(obj);
+    aarch64_add_kvm_writable_properties(obj);
 #elif defined(CONFIG_HVF)
     hvf_arm_set_cpu_features_from_host(cpu);
 #elif defined(CONFIG_WHPX)
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index c02845486aa9..ff5034397746 100644
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

