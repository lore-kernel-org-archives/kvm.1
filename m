Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795670880;
	b=YJLOpOhfs8BfsqR7zIibGnDt4FoRXw296MJpkGTKtn2NGI+vsgrsguE+TvXORjLwZtuc
	 dQdE9uG/n2ZbAQS4tzeAEftacdOXpPYAdcaVi01jb7vutQCfTz4UZxX/XI8oLlw4pkFws
	 1U4AGSWIsPCd82YQ8rHisXIIpaY9+Pxb129m13/kKk5wtDqZlLgoBikYplPNl8UoBhvM3
	 SwmObruachwZP7DWOetcXErwVBU5Eu4AV7bZwNp9kIDixc11Tj6fgbao7DSwG78XSi3RO
	 kwoigG5uotWSe7RhAdljffsfPkbDaBjbzbTuZXgVsCxrqRRcdEn1OZEewKqvrkzTGZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795670880;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CgF2Rl6OlcCIxvB5hOpq+nzQLcAAoXIy0ayd2QHpKA8=;
	b=nGRcnW3dv5nnt+Ohiveb/StL9HJHJUrtNMb1JihuvYxVp2AaSk21hWxcSU50G9GhPjJq
	 FC0I9CEPEJDd3Voc9mkb2x0Cucp7Wd3W/pV9TCzIz/qTG6DuMku+Iecf5rJxyiqlX17tW
	 FGSNFKRDxRAVn2CgIx2vwd7dtbzN8mHB0YSfk783gx/rwPRzxTXNlivqZVh09EfE/fL1w
	 8aJvX14/oQPqLiBIopisDChOyZ4QHOumG0H/xJ6zdXDAxFIQL+gu4r8MuHb/n+Q4yG30g
	 zWB/Agj2fFpgm1iBWmy7YVjJPgXAKRIsp5BAl/GmLlOO5xpG2dop/OlYHjZF/vR8EgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=scUk0nCK;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10976606A31C
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 05:27:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10976606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=scUk0nCK
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bb6057b333so31027065e9.3
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 21:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795670878; x=1796275678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CgF2Rl6OlcCIxvB5hOpq+nzQLcAAoXIy0ayd2QHpKA8=;
        b=scUk0nCKxohq+9bqHsmgfYri1Ei7ZGguFVonXRv0+jEzUhqTGeWvf0GFne22yBrc5F
         Y3TaBaukKGAWGwR5xt4SUCgdCisepWJe5FJHW7IJv7fEX2O7pgoeNi/7+ydpIO9AbUM9
         2r6Qnkkt1WYzdu6nfIuDPZ8su2uC0832vCPyDznbzFsedGzdQ5mFb0q704zRD0eRaGu5
         54hfWphh/pmEkj0+UgE7mlRRXJNSGV4yS1ynXOfTxBu/4C6PSej1gxFnAvP3K1qY3ukc
         dEUKULs/iDuV2FzooXNFxSLOsXt7BMx00W6LyIfI16ZwHCUGB0uyUPqKAv/9wvlEm6rU
         auJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795670878; x=1796275678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CgF2Rl6OlcCIxvB5hOpq+nzQLcAAoXIy0ayd2QHpKA8=;
        b=f2KiqgE+0prnz1RZEO5bAB/ToFeJl6uw7zZhWUcFnU/Sl35zpMoWeDAf/CTM2v+HaS
         elC9p9ji+IG0/1ksVPTsoympt+cmMfH3d2ugF8FgkHzxN8kf5VCVReso5soo7UcGTCcx
         Gbz+94g3a6C88EK9rBsW3Bzh76gxbgHltt7uzCXJsqbYiBo+vPwlRZLpvrS1FKFvG9Re
         ICBn29hK0i3f4CNWFZmncAzDHFXXjclJSSIy+0j4ssrTD2nr9GmyhFOMy/JJMjLuIIQ3
         tIVUKtQFArrJcULuPgd40AFIoVIxcRlEZ1YKcmOZLIRTMb1O8FzHLB4MhPI5ZCW+eYKY
         haVQ==
X-Forwarded-Encrypted: i=1; AL+hErH03PsNZdHwInQ7BxD3/LqsRV+bz4e/seEMM9+m0BsrpKwnHbSUbrQa8T07ZaRB6d7cHkQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/8cT3tts1m1wz4FYaM2jLxS6EU16h4mt4fz72QaYWQF19W9D1y
	OlVfLi3lAm5sDv3xjexVbaSfj6Y0RERAci1ahP9HS/p6+S0VPI0Ph4QG
X-Gm-Gg: AZFdTZcgjq5NaaOSmSjjPLoI6GxcvF6JAtNE5TEfNzZOBLADUgorX5QRuRAfTSU3CIW
	cGDgBrl3D4ESJSrKjKIwcjdiFdTAeUjeUQfsAzfhtn1+BPVwW3hiFpXCnzH5JepR8Kp3QlOMJXK
	nQCtl3Gw5Svs0s9QBy3jRfAiAA15zoxoiEx7wl/tcXpr2ooIbaXnt9AgyjjOiw635ErgzI+Mf/E
	rMg75TqJBWEXgKtbXiBwgaM5GwzA1ijQbS/lvJpfBhDhmG7/cwmZajENHbV4APNlx+fhfUfOJ1W
	K8zATjiAdJh6kor68WBUQB6FtXz1tN/K39MxqbKUMzwcZNzpMQJ43h/kfvr4uvUii9yNVTgS9BK
	Ni7YltbmtydnGNNQCn4xEWW3BHXWhB0hyIX7H9+nKM0HjCUlvO9FR874PIqYHin3F1u572ldmMx
	LlFp44sc9ApV85563a7wvzqdp9YeYg1q6ONP1tT/CQ4RgEfsRXpU1f0QkAkcsZgm0u0hyFhronm
	QjMSYj/YHmj47WdTQdVvoRxxeVaTHjJdaLLdMQ+lFI55Gn+jktony6bA6LOkLdhxa3ERBj2Iu+Z
	NAF1lM2nSb3BT1HVwEB66YKjVtqtnHKMwNINbARZGkaPaFC4ht5cHXsA7su83n1wewOWTysch3K
	uvEMwzdvtQ22nccuePijmwYcm
X-Received: by 2002:a05:600c:a11:b0:4bb:69f2:87f7 with SMTP id 5b1f17b1804b1-4bb88812c92mr415783615e9.18.1795670877935;
        Wed, 25 Nov 2026 21:27:57 -0800 (PST)
Received: from PKL-HASEEBA-LT.. ([39.36.25.192])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b2437sm808310475e9.13.2026.11.25.21.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 21:27:57 -0800 (PST)
From: Haseeb Ashraf <haseebashraf091@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Cc: Haseeb Ashraf <haseeb.ashraf@siemens.com>,
	Eric Auger <eric.auger@redhat.com>,
	Khushit Shah <khushit.shah@nutanix.com>,
	Marc Zyngier <maz@kernel.org>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
	qemu-devel@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC PATCH v3 2/3] target/arm/kvm: Let SYSREG_ID_AA64MMFR1_EL1_VH select an nVHE EL2
Date: Thu, 26 Nov 2026 10:27:40 +0500
Message-ID: <20261126052741.90607-3-haseebashraf091@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126052741.90607-1-haseebashraf091@gmail.com>
References: <20261121204601.741616-1-haseebashraf091@gmail.com>
 <20261126052741.90607-1-haseebashraf091@gmail.com>
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
KVM_ARM_VCPU_HAS_EL2_E2H0 is requested at KVM_ARM_VCPU_INIT time. With
that feature FEAT_VHE is hidden: ID_AA64MMFR1_EL1.VH reads 0 and
HCR_EL2.E2H is RES0. Guest hypervisors which only support nVHE, such as
Xen, can only run in the latter mode.

Do not add a dedicated machine or CPU option for it.  Derive the vCPU
init feature from the ID register field selected by the user instead:
SYSREG_ID_AA64MMFR1_EL1_VH=0 requests KVM_ARM_VCPU_HAS_EL2_E2H0.

KVM does not let userspace write ID_AA64MMFR1_EL1.VH, so the generic
"writable fields only" rule would not create the property. Expose it
explicitly when the host supports KVM_CAP_ARM_EL2_E2H0. Apply this
init-driven property before creating the scratch vCPU and use it when
initializing real vCPUs. Setting VH=0 without virtualization=on is
rejected.

KVM derives other ID register fields from the selected init mode. Re-read
ID_AA64MMFR1_EL1 and ID_AA64MMFR4_EL1 after vCPU initialization so QEMU's
cached CPU model and query-cpu-model-expansion agree with the values the
guest sees.

Suggested-by: Marc Zyngier <maz@kernel.org>
Suggested-by: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Signed-off-by: Haseeb Ashraf <haseeb.ashraf@siemens.com>
---

v3:
 - Apply init-driven properties before creating the scratch vCPU.
 - Refresh MMFR1 and MMFR4 from KVM after vCPU initialization.
 docs/system/arm/cpu-features.rst | 22 ++++++++++++
 target/arm/arm-qmp-cmds.c        | 38 +++++++++++++++++++++
 target/arm/cpu-idregs.h          | 31 +++++++++++++++++
 target/arm/cpu64.c               | 51 ++++++++++++++++++++++------
 target/arm/kvm-stub.c            |  5 +++
 target/arm/kvm.c                 | 58 ++++++++++++++++++++++++++++++--
 target/arm/kvm_arm.h             |  8 +++++
 7 files changed, 199 insertions(+), 14 deletions(-)

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
+hidden. This is done by setting ``ID_AA64MMFR1_EL1.VH`` to 0::
+
+  $ qemu-system-aarch64 -M virt,virtualization=on -accel kvm \
+        -cpu host,SYSREG_ID_AA64MMFR1_EL1_VH=0
+
+QEMU then requests ``KVM_ARM_VCPU_HAS_EL2_E2H0`` when initializing the
+vCPUs, so that ``HCR_EL2.E2H`` is RES0 for the guest. Leaving the
+property unset, or setting it to 1, keeps the default VHE-only EL2.
+Setting it to 0 requires ``virtualization=on``.
+
+KVM does not allow userspace to write ``ID_AA64MMFR1_EL1.VH`` directly, so
+this is an exception to the rule that only writable fields get a
+property: the ``SYSREG_ID_AA64MMFR1_EL1_VH`` property is exposed when the
+host kernel supports ``KVM_CAP_ARM_EL2_E2H0``. Without this support the
+property does not exist.
+
 A note on compatibility
 -----------------------
 
diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index 9a0258a3d6..b8e6c212a8 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -98,6 +98,7 @@ qmp_query_arm_cpu_model_expansion(CpuModelExpansionType type,
     Visitor *visitor = NULL;
     Error *err = NULL;
     bool scratch_created = false;
+    bool e2h0_requested = false;
     const char *name;
     int fdarray[3];
     int fd = -1;
@@ -173,6 +174,38 @@ qmp_query_arm_cpu_model_expansion(CpuModelExpansionType type,
             goto bail_out;
         }
 
+        /*
+         * Init-driven SYSREG properties must be visible while the scratch
+         * vCPU is initialized, not only when the remaining properties are
+         * applied below.
+         */
+        for (const QDictEntry *entry = qdict_first(qdict_in);
+                 entry != NULL; entry = qdict_next(qdict_in, entry)) {
+            const char *key = qdict_entry_key(entry);
+            QObject *val_obj = qdict_entry_value(entry);
+            Visitor *v;
+            uint64_t value;
+
+            if (!strcmp(key, "SYSREG_ID_AA64MMFR1_EL1_VH")) {
+                v = qobject_input_visitor_new(val_obj);
+                if (!visit_type_uint64(v, key, &value, errp)) {
+                    visit_free(v);
+                    goto bail_out;
+                }
+                visit_free(v);
+                e2h0_requested = value == 0;
+            } else {
+                continue;
+            }
+
+            v = qobject_input_visitor_new(val_obj);
+            if (!object_property_set(obj, key, v, errp)) {
+                visit_free(v);
+                goto bail_out;
+            }
+            visit_free(v);
+        }
+
         /**
          * Test SYSREG option settings
          * In full mode, build a scratch vcpu that reflects composite legacy
@@ -237,6 +270,11 @@ qmp_query_arm_cpu_model_expansion(CpuModelExpansionType type,
             visit_free(v);
         }
 
+        if (scratch_created && e2h0_requested &&
+            kvm_arm_refresh_e2h0_idregs(ARM_CPU(obj), fd, errp)) {
+            goto bail_out;
+        }
+
         visit_check_struct(visitor, &err);
         if (err) {
             goto bail_out;
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
 
diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index 88e35909c4..75e82887d6 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -47,6 +47,11 @@ bool kvm_arm_el2_e2h0_supported(void)
     return false;
 }
 
+int kvm_arm_refresh_e2h0_idregs(ARMCPU *cpu, int fd, Error **errp)
+{
+    return 0;
+}
+
 /*
  * These functions should never actually be called without KVM support.
  */
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 8ef5597c68..2a72f52c44 100644
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
@@ -2183,6 +2189,30 @@ bool kvm_arm_el2_e2h0_supported(void)
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_EL2_E2H0);
 }
 
+int kvm_arm_refresh_e2h0_idregs(ARMCPU *cpu, int fd, Error **errp)
+{
+    static const ARMIDRegisterIdx indices[] = {
+        ID_AA64MMFR1_EL1_IDX,
+        ID_AA64MMFR4_EL1_IDX,
+    };
+
+    for (int i = 0; i < ARRAY_SIZE(indices); i++) {
+        ARMIDRegisterIdx index = indices[i];
+        int ret;
+
+        ret = read_sys_reg64(fd, &cpu->isar.idregs[index],
+                             idregs_sysreg_to_kvm_reg(
+                                 id_register_sysreg[index]));
+        if (ret) {
+            error_setg(errp, "failed to refresh %s after vCPU init",
+                       arm64_id_regs[index].name);
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
 bool kvm_arm_mte_supported(void)
 {
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_MTE);
@@ -2239,7 +2269,19 @@ static void kvm_arm_vcpu_prepare_init_features(ARMCPU *cpu)
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
 
@@ -2286,6 +2328,16 @@ int kvm_arch_init_vcpu(CPUState *cs, Error **errp)
         return ret;
     }
 
+    uint64_t vh;
+    if (arm_cpu_sysreg_prop_get(cpu, ID_AA64MMFR1_EL1_IDX,
+                                R_ID_AA64MMFR1_VH_SHIFT, &vh) &&
+        vh == 0) {
+        ret = kvm_arm_refresh_e2h0_idregs(cpu, CPU(cpu)->kvm_fd, errp);
+        if (ret) {
+            return ret;
+        }
+    }
+
     if (cpu_isar_feature(aa64_sve, cpu)) {
         ret = kvm_arm_sve_set_vls(cpu);
         if (ret) {
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 0916a5fdb4..670b410a1a 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -208,6 +208,8 @@ bool kvm_arm_el2_supported(void);
  * KVM_ARM_VCPU_HAS_EL2_E2H0, and false otherwise.
  */
 bool kvm_arm_el2_e2h0_supported(void);
+
+int kvm_arm_refresh_e2h0_idregs(ARMCPU *cpu, int fd, Error **errp);
 #else
 
 static inline bool kvm_arm_aarch32_supported(void)
@@ -229,6 +231,12 @@ static inline bool kvm_arm_el2_e2h0_supported(void)
 {
     return false;
 }
+
+static inline int kvm_arm_refresh_e2h0_idregs(ARMCPU *cpu, int fd,
+                                              Error **errp)
+{
+    return 0;
+}
 #endif
 
 /**
-- 
2.34.1

