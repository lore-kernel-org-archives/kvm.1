Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795293976;
	b=GzDHiXLS+cNL+KHThlHQUKG0X4hlQ1+gzfbOPIfak8zl5uonWlaw9h6Be6FA65Iokinw
	 ixMjVHw8Xa1rIecC1Q+SeMdUgIula4q2gsjiicuaBojOqtAD5Iw07OHY9HkwNWAGEk3n9
	 DGI2iCQw63GD8TWg6sF9JkzmWFvfotIYJSeVSNV/w8jujOCUyqrWhOwvNcomQtNPLevc7
	 2ptN7FSfEWaz3xJWQ9LBVzCfQbNQMzxjGM0A3Yo3WdY1Pglerx5PPZqh+cx7Wlwnwywri
	 fkFxGgrG8roSei4wiC5flYtfWZya+mrmP8upYHvU/3PsNPImgoiw35y71s8Gl/76dfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795293976;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dR4oPwMzXZwkzKBHINmHc4eivvVzlJdhh6T4Ur7acMs=;
	b=fcy34fflcBTlbycy5d1bX8Mwwo9XYpcW2LoAIKrzCbuKE3FCABK+vcX90HjdbgREtzFe
	 4U4lxOUtFaqaWX/r94bqXWVzmMnFkC6Ts8FgH2yojX7nhyB3lt8o7SP+5E1Zrm4bqEb/T
	 WmlGmxot+yQ3C5TQcXouzQs6KKCztzS9/DeQ+HIzepLn87R3aWZOckYwi3xPrtZc2BHdh
	 LuxplTbgJNhsBJHeMhfLKocEEZ2ius7P9ekPaAaWddrwaZjdgxfqqMKvYcv4sCAoOcPkr
	 /39pcIlK//LqmLb4hAd8RIDcTH/H5XTmgmuCPlyjX9tVwMfkNufy6UKAr3yr1M3z4ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a8SgEOwj;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B2A606A320
	for <kvm@vger.kernel.org>; Sat, 21 Nov 2026 20:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63B2A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a8SgEOwj
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so15251665e9.3
        for <kvm@vger.kernel.org>; Sat, 21 Nov 2026 12:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795293975; x=1795898775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dR4oPwMzXZwkzKBHINmHc4eivvVzlJdhh6T4Ur7acMs=;
        b=a8SgEOwjuzFBX0s+z/nEHP0QBO3OR4JGOUscVQDIL3zKkdqvNqr9+TeMwoSRbXI4hf
         pkpHcTj35LDMIko1V5ClEEjqP2ukQ6GZpZ5MdckhTki3xkPGS6zaW3Ob8h7+cwOTwoCl
         HVf1NFAVEPt6OQzmkIGSQq5j12M8APa+0fFeCPAs/qAF2E4GCjepq5okG4Ee0QS616te
         910kxm9wr1EySRHR6KoN5Zw7lTqK8ovDE2FRAewW274yDKZYiDSTexccXiNvr6ve7Fa2
         mFxLqzJJfPdEf/ghNgZnIjmTtWXr+46Y66yn9cjw/saxPA06zbPEsFOPNJ4/BCrs8oMa
         LZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795293975; x=1795898775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dR4oPwMzXZwkzKBHINmHc4eivvVzlJdhh6T4Ur7acMs=;
        b=pn2mGC+RMkQ/jaZjA2C3x7UTOxEhOQ18Cy7+77Q/XkW/ZWajqN+4YOyBUR3q5udowe
         EAhrOTfT1W8XeRPB7dFwxroPRSNGITnid3xY6EF/U/R1fxHXD9R8352H7++esqpOZX72
         rW0jMCOOY7zXgJMYCbnkyOOs83ujOc5tZsmSg2a5aIZCQhBi0BZY/E/OGyUHoM1Ur69+
         nZzk+PInT948Hpqmaxo2X4giDEi8zWNylpFDaVd7m+BX40k+4F1bidg5eT1HN//9hHY/
         ykU6J70MXDUZp0zbeD90/Hul7lAGLKspisuO1DarIFuHREzHdP7+ZMB2UdfxWX8YtAoN
         u6Cg==
X-Forwarded-Encrypted: i=1; AL+hErFZU6DKHK0oJuhj38NbTms+dM30wHY757WweIp+A9f4+dIptQaiKpp0LPvEdNPi5tgmoNM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8bF7qWHZE06TSr0ZWE3u0SvL4ohzwutQ6BEQR0Rxy9DZq1R6tZ
	IFniY+9WCBHOMnnBDQIzUQ78KR851eR10eJFiprJmYckGa7sEqJzc0pb
X-Gm-Gg: AZFdTZcuiRDyeYEQTIJaRngQeCHEGRC6jGsL2j/nLaYiV3Q7evCTc00xDt+ntCir5Mi
	EqX9SnEoMBs/dtv5UhP6HKk82tcogaGh0OgMgjZMTrFFB/xyj0uh+QeU+eBkhYBKk2Ui+QJE9wa
	lck8uxBpVyARqaAOzR1qwBIA+BXTYdpQHTMYJZQ2Vmn4Hg7WpRxEQXAb+bGq8wYjEa5GiQFMrEV
	ROngXyJOmikmUMNgPzlkHpTZog8/yMlGexyFMJMNZ/M9YCk09+vkgFutkHBsEpY7qUqWRtYm9Um
	IIrjpx1uCsZ0fR+zfavr0FZGZxbOlHIHPdThVbH1M1OwLhh+oNSom27fl1YVOvQKsr/6oiBaaC/
	BXyrIbU5TNjK3+Lz+edrm08n2dmftf7oYpk4ofriq070Dfq/r+3kZjNMaUxbLv/LRZfT+e2cs0b
	JGWkbJwHxRsHCebqJa/s9MrDMkYQLMptw6IvAZHvHP9dniwSPJsovuKlr/I8o12Pv4koP5AQpvT
	/gDQS5En9eiVClaHdGWNaXjUIaIVyRz0Tw8oRh3dvfF+gAIy3TRpJptUaEjI1S0bownY2Xu9Rmr
	rV4PG0d4Yb7J2gJP6yzR7SbRt7K8tLYVaOJGOXmCzYacczwwgK1UJNbE5od3xESu0jH+LpdUPmO
	1OHIsMgle7Vhg7rMO2sBQMPg=
X-Received: by 2002:a05:600c:4515:b0:4bb:6f67:ca0b with SMTP id 5b1f17b1804b1-4bb888267f4mr158170395e9.29.1795293974532;
        Sat, 21 Nov 2026 12:46:14 -0800 (PST)
Received: from PKL-HASEEBA-LT.. ([39.36.59.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b39b6sm180652385e9.12.2026.11.21.12.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 12:46:14 -0800 (PST)
From: Haseeb Ashraf <haseebashraf091@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Cc: Haseeb Ashraf <haseeb.ashraf@siemens.com>,
	Eric Auger <eric.auger@redhat.com>,
	Marc Zyngier <maz@kernel.org>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
	qemu-devel@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC PATCH v2 2/3] target/arm/kvm: Let SYSREG_ID_AA64MMFR1_EL1_VH select an nVHE EL2
Date: Sun, 22 Nov 2026 01:46:00 +0500
Message-ID: <20261121204601.741616-3-haseebashraf091@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121204601.741616-1-haseebashraf091@gmail.com>
References: <20261121095636.289814-1-haseebashraf091@gmail.com>
 <20261121204601.741616-1-haseebashraf091@gmail.com>
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

From: Haseeb Ashraf <haseeb.ashraf@siemens.com>

KVM runs a nested guest with a VHE-only EL2 (HCR_EL2.E2H RES1) unless
KVM_ARM_VCPU_HAS_EL2_E2H0 is requested at KVM_ARM_VCPU_INIT time.  With
that feature FEAT_VHE is hidden: ID_AA64MMFR1_EL1.VH reads 0 and
HCR_EL2.E2H is RES0.  Guest hypervisors which only support nVHE, such as
Xen, can only run in the latter mode.

Do not add a dedicated machine or CPU option for it.  Derive the vCPU
init feature from the ID register field selected by the user instead:
SYSREG_ID_AA64MMFR1_EL1_VH=0 requests KVM_ARM_VCPU_HAS_EL2_E2H0.

KVM does not let userspace write ID_AA64MMFR1_EL1.VH, so the generic
"writable fields only" rule would not create the property.  Expose it
explicitly when the host supports KVM_CAP_ARM_EL2_E2H0.  As KVM already
reports the requested value after vCPU init, applying the property does
not need a KVM_SET_ONE_REG for this field, and the query-cpu-model-expansion
dry run on the scratch vCPU skips it.  Setting VH=0 without
virtualization=on is rejected.

Only ID_AA64MMFR1_EL1.VH is updated in QEMU's copy of the ID registers.
Other fields which KVM derives from E2H0 (e.g. ID_AA64MMFR4_EL1) are
not refreshed.

Suggested-by: Marc Zyngier <maz@kernel.org>
Suggested-by: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Signed-off-by: Haseeb Ashraf <haseeb.ashraf@siemens.com>
---

v2:
 - Use Eric Auger's SYSREG framework instead of a dedicated vhe
   machine/CPU property.
 - Expose the init-driven VH field only when KVM supports E2H0.
 - Add the virtualization=on consistency check and document VH=0.
 docs/system/arm/cpu-features.rst | 22 ++++++++++++++
 target/arm/cpu-idregs.h          | 31 +++++++++++++++++++
 target/arm/cpu64.c               | 51 +++++++++++++++++++++++++-------
 target/arm/kvm.c                 | 24 +++++++++++++--
 4 files changed, 114 insertions(+), 14 deletions(-)

diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
index 13454783cf..cde26c04b9 100644
--- a/docs/system/arm/cpu-features.rst
+++ b/docs/system/arm/cpu-features.rst
@@ -579,6 +579,28 @@ either not writable with the specific host kernel, unknown to this QEMU
 build, or intentionally not exposed because it overlaps a legacy composite
 option.
 
+Selecting an nVHE-only EL2
+--------------------------
+
+With ``-machine virt,virtualization=on``, KVM presents a VHE-only EL2 to
+the guest (``HCR_EL2.E2H`` is RES1) by default.  A guest hypervisor which
+only supports nVHE, such as a type-1 hypervisor like Xen, needs VHE to be
+hidden.  This is done by setting ``ID_AA64MMFR1_EL1.VH`` to 0::
+
+  $ qemu-system-aarch64 -M virt,virtualization=on -accel kvm \
+        -cpu host,SYSREG_ID_AA64MMFR1_EL1_VH=0
+
+QEMU then requests ``KVM_ARM_VCPU_HAS_EL2_E2H0`` when initializing the
+vCPUs, so that ``HCR_EL2.E2H`` is RES0 for the guest.  Leaving the
+property unset, or setting it to 1, keeps the default VHE-only EL2.
+Setting it to 0 requires ``virtualization=on``.
+
+KVM does not allow userspace to write ``ID_AA64MMFR1_EL1.VH`` directly, so
+this is an exception to the rule that only writable fields get a
+property: the ``SYSREG_ID_AA64MMFR1_EL1_VH`` property is exposed when the
+host kernel supports ``KVM_CAP_ARM_EL2_E2H0``.  Without this support the
+property does not exist.
+
 A note on compatibility
 -----------------------
 
diff --git a/target/arm/cpu-idregs.h b/target/arm/cpu-idregs.h
index 465ec83c97..76d7b94858 100644
--- a/target/arm/cpu-idregs.h
+++ b/target/arm/cpu-idregs.h
@@ -73,4 +73,35 @@ int arm_cpu_apply_sysreg_props(ARMCPU *cpu, ARMSysregPropApplyFn accel_apply_fn,
 bool arm_cpu_validate_sysreg_prop(ARMCPU *cpu, ARM64SysRegField *field,
                                   uint64_t value, Error **errp);
 
+/**
+ * arm_cpu_sysreg_prop_get:
+ *
+ * Look up the value the user set through a SYSREG_<IDREG>_<FIELD>
+ * property, before it is applied to the vcpu.  Accelerators use it to
+ * derive vcpu init settings from the requested ID register values.
+ *
+ * @cpu: vcpu the property belongs to
+ * @reg_idx: ID register index (<REG>_EL1_IDX)
+ * @shift: lowest bit of the field
+ * @value: set to the requested field value when the property was set
+ *
+ * returns true if the property was set by the user
+ */
+bool arm_cpu_sysreg_prop_get(ARMCPU *cpu, int reg_idx, int shift,
+                             uint64_t *value);
+
+/**
+ * arm_cpu_sysreg_field_init_driven:
+ *
+ * Some fields cannot be written with the accelerator once the vcpu exists
+ * but are selected through a vcpu init feature instead (for instance
+ * ID_AA64MMFR1_EL1.VH with KVM_ARM_VCPU_HAS_EL2_E2H0).  Their SYSREG
+ * property is exposed even if the field is not writable.
+ *
+ * @field: ID register field
+ *
+ * returns true if @field is selected at vcpu init time on this host
+ */
+bool arm_cpu_sysreg_field_init_driven(ARM64SysRegField *field);
+
 #endif
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index c08eba7010..1fc3a4bb7c 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -835,6 +835,21 @@ static ARM64SysRegField *arm_sysreg_get_field(ARM64SysReg *reg, int bit)
     return NULL;
 }
 
+bool arm_cpu_sysreg_prop_get(ARMCPU *cpu, int reg_idx, int shift,
+                             uint64_t *value)
+{
+    gpointer value_ptr;
+    uint64_t key = IDREG_FIELD_KEY(reg_idx, shift);
+
+    if (!g_hash_table_lookup_extended(cpu->sysreg_props,
+                                      GUINT_TO_POINTER(key), NULL,
+                                      &value_ptr)) {
+        return false;
+    }
+    *value = GPOINTER_TO_UINT(value_ptr);
+    return true;
+}
+
 /**
  * arm_cpu_validate_sysreg_prop:
  *
@@ -879,6 +894,13 @@ bool arm_cpu_validate_sysreg_prop(ARMCPU *cpu, ARM64SysRegField *field,
             error_setg(errp, "%s is non null whereas pmu is unset", propname);
             return false;
         }
+    /* nVHE-only EL2, selected at vcpu init time */
+    } else if (!strcmp(propname, "SYSREG_ID_AA64MMFR1_EL1_VH")) {
+        if (value == 0 && !cpu->has_el2) {
+            error_setg(errp, "%s=0 requires -machine virtualization=on",
+                       propname);
+            return false;
+        }
     /* aarch64=off */
     } else if (!arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         if ((!strcmp(propname, "SYSREG_ID_AA64PFR0_EL1_EL0") ||
@@ -988,17 +1010,9 @@ static void get_sysreg_prop(Object *obj, Visitor *v,
     int index = field->index;
     int lower = field->shift;
     int length = field->length;
-    gpointer value_ptr;
     uint64_t value;
-    uint64_t key = IDREG_FIELD_KEY(index, lower);
-    gboolean exists;
-
-    exists = g_hash_table_lookup_extended(cpu->sysreg_props,
-                                          GUINT_TO_POINTER(key), NULL,
-                                          &value_ptr);
-    if (exists) {
-        value = GPOINTER_TO_UINT(value_ptr);
-    } else {
+
+    if (!arm_cpu_sysreg_prop_get(cpu, index, lower, &value)) {
         uint64_t mask = MAKE_64BIT_MASK(lower, length);
         uint64_t *idregs = cpu->isar.idregs;
 
@@ -1028,6 +1042,20 @@ static const char * const aarch64_sysreg_prop_skip_list[] = {
     "SYSREG_ID_AA64ISAR2_EL1_GPA3",
 };
 
+/*
+ * Fields which KVM does not let userspace write with KVM_SET_ONE_REG,
+ * but which QEMU can still select through a vcpu init feature, see
+ * kvm_arm_vcpu_prepare_init_features().  ID_AA64MMFR1_EL1.VH is hidden
+ * by KVM_ARM_VCPU_HAS_EL2_E2H0, which requests an nVHE-only EL2.
+ */
+bool arm_cpu_sysreg_field_init_driven(ARM64SysRegField *field)
+{
+    /* Compare the field first: this runs for every ID register field */
+    return field->index == ID_AA64MMFR1_EL1_IDX &&
+           field->shift == R_ID_AA64MMFR1_VH_SHIFT &&
+           kvm_enabled() && kvm_arm_el2_e2h0_supported();
+}
+
 static bool aarch64_sysreg_prop_skipped(const char *prop_name)
 {
     for (int i = 0; i < ARRAY_SIZE(aarch64_sysreg_prop_skip_list); i++) {
@@ -1084,7 +1112,8 @@ aarch64_add_one_idreg_properties(Object *obj, ARM64SysReg *reg,
         }
         map = map & ~field_mask;
 
-        if (writable_only && !field_writable_mask) {
+        if (writable_only && !field_writable_mask &&
+            !arm_cpu_sysreg_field_init_driven(field)) {
             continue;
         }
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 8ef5597c68..bb4ca7e8d1 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1324,9 +1324,15 @@ bool kvm_idreg_write_scratch_vcpu(ARMCPU *cpu, int cpufd,
         return false;
     }
 
-    ret = kvm_arm_override_idreg_field(cpufd, field, newfv, errp);
-    if (ret) {
-        return false;
+    /*
+     * Init-driven fields (e.g. VH) are selected through a vcpu init
+     * feature, which the scratch vcpu may not have: do not write them.
+     */
+    if (!arm_cpu_sysreg_field_init_driven(field)) {
+        ret = kvm_arm_override_idreg_field(cpufd, field, newfv, errp);
+        if (ret) {
+            return false;
+        }
     }
 
     cpu->isar.idregs[field->index] =
@@ -2239,7 +2245,19 @@ static void kvm_arm_vcpu_prepare_init_features(ARMCPU *cpu)
                                       1 << KVM_ARM_VCPU_PTRAUTH_GENERIC);
     }
     if (cpu->has_el2 && kvm_arm_el2_supported()) {
+        uint64_t vh;
+
         cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_HAS_EL2;
+        /*
+         * KVM exposes a VHE-only EL2 by default.  An nVHE-only EL2 can
+         * only be selected at vcpu init time, so derive it from the
+         * requested ID_AA64MMFR1_EL1.VH value.
+         */
+        if (arm_cpu_sysreg_prop_get(cpu, ID_AA64MMFR1_EL1_IDX,
+                                    R_ID_AA64MMFR1_VH_SHIFT, &vh) &&
+            vh == 0) {
+            cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_HAS_EL2_E2H0;
+        }
     }
 }
 
-- 
2.34.1

