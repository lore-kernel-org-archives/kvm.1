Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795255007;
	b=ePolNL1F4bNcZd79zMRwRYeun2dmNSuEk6p5uPXfMldtTaugYXq9ZCS9XdyLoTzt6Tnt
	 d9Oi9zDtuBfIQkGDwBqx50EqzgQXTG6340vIWXYjPTEayTba8spQxDnGYR4ddzu20L2r+
	 jVr2WEPi9pU/BNhNNyey5HAU5NKoA5k/mCWS6OsEPHDjvEJOCSxJXoZnDfK6REPTl2Ky2
	 7uofauy/8g4TcaIeXblDsdxAP2qhZT90I1hvAaHrtOxnVJ0rvzRf9AKhoEk6OgaKhLj/T
	 36OWhOx9/jLAJXRaEF/NyiaPamyXEbJE+11OOqOCau+iOnmekjHGdEVRcMXD3QYpadQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795255007;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KpSc8oFSWfDhChfwfvA3T6eA6YVTi/ttjYcDRRXG5D0=;
	b=HMFTs+b0aHMJbWCZ/h4EGfRnHVfYVOdw41bSROTUbHCVvRhnIeZul7bAmQsXXzZjrUWo
	 JFrtRdmYLZTaWf5dUcn0Go98XUwMc3hgbtaibSXI2Gnqhyyqs9+8ZKRkwov0S5qMSMjjf
	 Slr1iOhqtuI0W5hSWXIj90eveqAwaDIZk58FCP1Sdf1fQkiEMqEqknV1Ht6t6oiKblOKB
	 A5jR2RWcCTFzqBfIYo0Z7tpwHbBonlVOfkiW5dCgRChI1YpXglo19H5aEgXCyfZSXyA1Q
	 tTHgLN+ex0ThliOMYTLxEfHigC6J+HCLMvXrF9bzSijXcQGoExIEofo932jjxKP02GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AShSjSyp;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781EE606A320
	for <kvm@vger.kernel.org>; Sat, 21 Nov 2026 09:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 781EE606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AShSjSyp
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-49a92144733so860808f8f.0
        for <kvm@vger.kernel.org>; Sat, 21 Nov 2026 01:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795255006; x=1795859806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KpSc8oFSWfDhChfwfvA3T6eA6YVTi/ttjYcDRRXG5D0=;
        b=AShSjSyp0cNmOLB5C1dYjBMeAx2VjDsxprKIZIQbkDCfUjiVci9OZG/wvLf1D1laft
         P+w91GW9CmwpEGMPfXzEEPDgsJwhs6uIrxJUjQQXkrhaPjTk5sB1OYzH3sKUwSLMjA9Q
         Kv2yGFaUDm2r7BaUqBVYa+RzTT8kDv+IhZBLQ4z1UbDDJjdrxPLJvkYl9gZnMx8Q6lq+
         pPyWB6/UsWuQLz0LfFSVLRWwEJ0QIN4/b/bBgGuPtAQHcKHR4o861vQjcNt8QcGo00Yq
         tffcC2bXa3yPUy/DXxOziUl0uElI0cPIyp/mDBfmQ5kHvGoDg/MdfaL5K2Sm5FjU3+y8
         4GYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795255006; x=1795859806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KpSc8oFSWfDhChfwfvA3T6eA6YVTi/ttjYcDRRXG5D0=;
        b=wnOScUDpTtTB3Z/KADLLgsMtaQR86xB3IV/jZ2jv/lTL1yggmHmjiKtWS5RmnHFd1S
         sp3Ly5WmEy6r1Nu4q+kG2ur32gX5okYliPb8/WGr4huyCChv0c/7pnFWT3Pfq66BUKxh
         DsopdFGB5+eAg5/IIk1PG3XK/o6XACIJMeoexDeQhzuDLuVNR2sctjAkq+lPr8SwCp3q
         FOkLW5nDYo5HXTk6+msvi0Gf+2zHPWV96IXPuw1KB4opzr58Alz/PyWvIZ5CQn4JvcPH
         MC8RFvPk6huf1TSQgMyd/tzmqWQcq/Oz7+CtbIpwhRnllY4Ks11btywotBr5z3p/3CCm
         qsFQ==
X-Forwarded-Encrypted: i=1; AL+hErEu+4EBOFDNK4YxT7MwZ+/m0OSl57aBGQSTLGmW/P9YzNXz0WTbRBy7t+TGmwFXDdkwavg=@vger.kernel.org
X-Gm-Message-State: APuU4Z95M73+fMqjEXJHZzVd0ee8+3sjxFYY5h1JwONdRMTFj1ebjKm3
	e1rMV2LdNJRRzeD6st25A4DKyLRPw3/T9/VhBBe73yq7qqYVqVZtCLUE
X-Gm-Gg: AZFdTZfub8l6tH410/a5F17kbthoXbI0s/j7LoBjY9KEtv7hIUkOElcr9kfkfS5FhLF
	33SKc8z8nCfTENWt2ymB57ds4hXZneCYXkZk2bzzDp+g4GuTyGxKha7Niva4HGvLzLwUGPtvrQ0
	mUN8c/vQ3C8kxV42Kqkso92gmQyTwhCIQa+yd6HEndJarONKmabiYvyzk+2tB8m5p3VV5A9vSeg
	BWTrKQLiwsxxbbRM6IeliKjg+4jbSYSRCCmWQ2ndrJPNkCmuRI0MeFlymNC9fxDduF/9VFeqWhG
	6+RNbLr/jQJXmTDw9thBCo428c2jYXxY3MJlkXpxl48OQPEenQMiTYOzm4DidBdS2I/XLD/hd3C
	08Cg81Rd3ydkdQ4OmgBEFbjrA5VXvezFxtxmL4gcRr3BvzWbQzDNfC3H2UCcBMoZwzbzY92WYwK
	d3/CBANGvAIbmxGr5wi1d9Ij6itLsg7AhhQxvAMnw+blVkkfYKO4owPdAPc7xEGW1DSNmkHNu00
	gpKYluLOb6Eld8h3kM454kIooh5x0QwfvIhxD0B4izFSGvyUvY7t5W7lD8RsPX6k4SB9ZHOqqrj
	1ITjDf+LofgtmAj7H0qV1PIMUOfITw0cnEtAkQvfDlWXorNpGME7JKwacpzgKQtVnpvHM/8DaE4
	E01Z3eqDExExR2oJE515oWHcbZ32ra6BXpwHD0fP41xJEEg==
X-Received: by 2002:a05:6000:470b:b0:4a6:ac28:eb57 with SMTP id ffacd0b85a97d-4abb3678d7cmr12718027f8f.17.1795255005571;
        Sat, 21 Nov 2026 01:56:45 -0800 (PST)
Received: from PKL-HASEEBA-LT.. ([39.36.59.78])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2e6dsm10741748f8f.6.2026.11.21.01.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 01:56:45 -0800 (PST)
From: Haseeb Ashraf <haseebashraf091@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Cc: Haseeb Ashraf <haseeb.ashraf@siemens.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Volodymyr Babchuk <volodymyr.babchuk@epam.com>,
	qemu-devel@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH 1/1] hw/arm/virt: add vhe option for nested virtualization
Date: Sat, 21 Nov 2026 14:56:36 +0500
Message-ID: <20261121095636.289814-2-haseebashraf091@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121095636.289814-1-haseebashraf091@gmail.com>
References: <20261121095636.289814-1-haseebashraf091@gmail.com>
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

Add a vhe machine property for the virt board. When virtualization=on,
VHE remains enabled by default, but vhe=off allows nVHE/type-1 guest
hypervisors to run without VHE.

Propagate the setting to the ARM CPU, limit TCG to nVHE mode, and request
the KVM_ARM_VCPU_HAS_EL2_E2H0 vCPU initialization flag when VHE is
disabled. Reject vhe=off when the selected accelerator cannot provide
the requested behavior. The option has no effect unless
virtualization=on is also set.

Document the option, and make the nested virtualization functional test
pass a vhe setting matching the kernel mode.

Tested nested virtualization with KVM on arm64 hosts using L0 kernel
versions 6.18.29 and 7.2.11. A Linux 6.12.67 guest initialized KVM in
nVHE mode with vhe=off and VHE mode with vhe=on. QNX Hypervisor 8.0.5
detected EL1 host hypervisor support with vhe=off and EL2 host
hypervisor support with vhe=on. Xen booted dom0 to the login prompt with
vhe=off, but did not boot with vhe=on.

Tested with TCG on an AmpereOne A192-32X host. QNX Hypervisor 8.0.5
boots with both vhe settings, and Xen boots its dom0 with vhe=off.

Suggested-by: Volodymyr Babchuk <volodymyr.babchuk@epam.com>
Signed-off-by: Haseeb Ashraf <haseeb.ashraf@siemens.com>
---
 docs/system/arm/virt.rst             | 10 ++++++++
 hw/arm/virt.c                        | 37 ++++++++++++++++++++++++++++
 include/hw/arm/virt.h                |  1 +
 target/arm/cpu.c                     | 15 +++++++++++
 target/arm/cpu.h                     |  2 ++
 target/arm/kvm-stub.c                |  5 ++++
 target/arm/kvm.c                     |  8 ++++++
 target/arm/kvm_arm.h                 | 12 +++++++++
 tests/functional/aarch64/test_kvm.py | 10 +++++---
 9 files changed, 97 insertions(+), 3 deletions(-)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index 5f6dd17978..31f0878788 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -116,6 +116,16 @@ virtualization
   Set ``on``/``off`` to enable/disable emulating a guest CPU which implements the
   Arm Virtualization Extensions. The default is ``off``.
 
+vhe
+  Set ``on``/``off`` to allow/disallow a guest hypervisor to use the Arm
+  Virtualization Host Extensions (``FEAT_VHE``) when ``virtualization`` is
+  ``on``. The default is ``on``, which places no restriction on the selected
+  CPU model (it does not add VHE to a CPU model which lacks it). ``off``
+  exposes EL2 in nVHE mode for a type-1 guest hypervisor: with TCG this hides
+  ``FEAT_VHE``, with KVM it requires host ``E2H0`` support, and it is not
+  supported with HVF. This option has no effect when ``virtualization`` is
+  ``off``.
+
 mte
   Set ``on``/``off`` to enable/disable emulating a guest CPU which implements the
   Arm Memory Tagging Extensions. The default is ``off``.
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0b11f7e328..1a987faa19 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3025,6 +3025,12 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
+    if (vms->virt && !vms->vhe && hvf_enabled()) {
+        error_report("mach-virt: %s does not support disabling VHE",
+                     current_accel_name());
+        exit(1);
+    }
+
     if (vms->mte && hvf_enabled()) {
         error_report("mach-virt: %s does not support providing "
                      "MTE to the guest CPU",
@@ -3069,6 +3075,10 @@ static void machvirt_init(MachineState *machine)
             object_property_set_bool(cpuobj, "has_el2", false, NULL);
         }
 
+        if (vms->virt && object_property_find(cpuobj, "has_vhe")) {
+            object_property_set_bool(cpuobj, "has_vhe", vms->vhe, NULL);
+        }
+
         if (vmc->no_kvm_steal_time &&
             object_property_find(cpuobj, "kvm-steal-time")) {
             object_property_set_bool(cpuobj, "kvm-steal-time", false, NULL);
@@ -3308,6 +3318,20 @@ static void virt_set_virt(Object *obj, bool value, Error **errp)
     hvf_nested_virt_enable(value);
 }
 
+static bool virt_get_vhe(Object *obj, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    return vms->vhe;
+}
+
+static void virt_set_vhe(Object *obj, bool value, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    vms->vhe = value;
+}
+
 static bool virt_get_highmem(Object *obj, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
@@ -4235,6 +4259,13 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
                                           "guest CPU which implements the ARM "
                                           "Virtualization Extensions");
 
+    object_class_property_add_bool(oc, "vhe", virt_get_vhe,
+                                   virt_set_vhe);
+    object_class_property_set_description(oc, "vhe",
+                                          "Set on/off to enable/disable the ARM "
+                                          "Virtualization Host Extensions (applicable "
+                                          "only when virtualization=on)");
+
     object_class_property_add_bool(oc, "highmem", virt_get_highmem,
                                    virt_set_highmem);
     object_class_property_set_description(oc, "highmem",
@@ -4375,6 +4406,12 @@ static void virt_instance_init(Object *obj)
     /* EL2 is also disabled by default, for similar reasons */
     vms->virt = false;
 
+    /*
+     * VHE is unrestricted by default when virtualization=on is set.
+     * With vhe=off, EL2 is limited to nVHE mode.
+     */
+    vms->vhe = true;
+
     /* High memory is enabled by default */
     vms->highmem = true;
     vms->highmem_compact = !vmc->no_highmem_compact;
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 22e66d1a11..bd0065efb1 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -174,6 +174,7 @@ struct VirtMachineState {
     bool highmem_redists;
     bool tcg_its;
     bool virt;
+    bool vhe;
     bool ras;
     bool mte;
     bool dtb_randomness;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index dde03ffdd6..4d272b5388 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1326,6 +1326,9 @@ static const Property arm_cpu_reset_hivecs_property =
 static const Property arm_cpu_has_el2_property =
             DEFINE_PROP_BOOL("has_el2", ARMCPU, has_el2, true);
 
+static const Property arm_cpu_has_vhe_property =
+            DEFINE_PROP_BOOL("has_vhe", ARMCPU, has_vhe, true);
+
 static const Property arm_cpu_has_el3_property =
             DEFINE_PROP_BOOL("has_el3", ARMCPU, has_el3, true);
 
@@ -1622,6 +1625,7 @@ static void arm_cpu_post_init(Object *obj)
 
     if (arm_feature(&cpu->env, ARM_FEATURE_EL2)) {
         qdev_property_add_static(DEVICE(obj), &arm_cpu_has_el2_property);
+        qdev_property_add_static(DEVICE(obj), &arm_cpu_has_vhe_property);
     }
 #endif
 
@@ -1872,6 +1876,13 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (cpu->has_el2 && !cpu->has_vhe && kvm_enabled() &&
+        !kvm_arm_el2_e2h0_supported()) {
+        error_setg(errp, "KVM does not support disabling VHE (E2H0 "
+                   "unavailable)");
+        return;
+    }
+
 #ifndef CONFIG_USER_ONLY
     /* The NVIC and M-profile CPU are two halves of a single piece of
      * hardware; trying to use one without the other is a command line
@@ -2246,6 +2257,10 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         unset_feature(env, ARM_FEATURE_EL2);
     }
 
+    if (cpu->has_el2 && !cpu->has_vhe && tcg_enabled()) {
+        FIELD_DP64_IDREG(isar, ID_AA64MMFR1, VH, 0);
+    }
+
     if (!cpu->has_pmu) {
         unset_feature(env, ARM_FEATURE_PMU);
     }
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b2f393f501..2f94fdae7b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1022,6 +1022,8 @@ struct ArchCPU {
     bool has_el2;
     /* CPU has security extension */
     bool has_el3;
+    /* CPU has virtualization host extensions */
+    bool has_vhe;
     /* CPU has PMU (Performance Monitor Unit) */
     bool has_pmu;
     /* CPU has VFP */
diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index 88cbe8d85c..6eb9e1366a 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -42,6 +42,11 @@ bool kvm_arm_el2_supported(void)
     return false;
 }
 
+bool kvm_arm_el2_e2h0_supported(void)
+{
+    return false;
+}
+
 /*
  * These functions should never actually be called without KVM support.
  */
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index df86ad387c..6b95ed1da8 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2003,6 +2003,11 @@ bool kvm_arm_el2_supported(void)
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_EL2);
 }
 
+bool kvm_arm_el2_e2h0_supported(void)
+{
+    return kvm_check_extension(kvm_state, KVM_CAP_ARM_EL2_E2H0);
+}
+
 bool kvm_arm_mte_supported(void)
 {
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_MTE);
@@ -2060,6 +2065,9 @@ static void kvm_arm_vcpu_prepare_init_features(ARMCPU *cpu)
     }
     if (cpu->has_el2 && kvm_arm_el2_supported()) {
         cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_HAS_EL2;
+        if (!cpu->has_vhe) {
+            cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_HAS_EL2_E2H0;
+        }
     }
 }
 
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 9c7e7f654a..24828e9c07 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -182,6 +182,13 @@ bool kvm_arm_mte_supported(void);
  * Returns true if KVM can enable EL2 and false otherwise.
  */
 bool kvm_arm_el2_supported(void);
+
+/**
+ * kvm_arm_el2_e2h0_supported:
+ *
+ * Returns true if KVM supports limiting EL2 to E2H=0, and false otherwise.
+ */
+bool kvm_arm_el2_e2h0_supported(void);
 #else
 
 static inline bool kvm_arm_aarch32_supported(void)
@@ -198,6 +205,11 @@ static inline bool kvm_arm_el2_supported(void)
 {
     return false;
 }
+
+static inline bool kvm_arm_el2_e2h0_supported(void)
+{
+    return false;
+}
 #endif
 
 /**
diff --git a/tests/functional/aarch64/test_kvm.py b/tests/functional/aarch64/test_kvm.py
index c977e8c6d2..502060a109 100755
--- a/tests/functional/aarch64/test_kvm.py
+++ b/tests/functional/aarch64/test_kvm.py
@@ -40,7 +40,9 @@ def _launch_guest(self, kvm_mode="nvhe"):
                                f"console=ttyAMA0 kvm-arm.mode={kvm_mode}")
 
         self.vm.add_args("-cpu", "max")
-        self.vm.add_args("-machine", "virt,gic-version=3,virtualization=on",
+        vhe = "on" if kvm_mode == "vhe" else "off"
+        self.vm.add_args("-machine",
+                         f"virt,gic-version=3,virtualization=on,vhe={vhe}",
                          '-kernel', kernel_path,
                          '-append', kernel_command_line)
         self.vm.add_args("-smp", "2", "-m", "320")
@@ -48,8 +50,10 @@ def _launch_guest(self, kvm_mode="nvhe"):
         try:
             self.vm.launch()
         except VMLaunchFailure as excp:
-            if "does not support providing Virtualization" in excp.output:
-                self.skipTest("accelerator has no virtualization support")
+            if ("does not support providing Virtualization" in excp.output or
+                    "does not support disabling VHE" in excp.output):
+                self.skipTest("accelerator lacks the required virtualization "
+                              "support")
             else:
                 self.log.info("unhandled launch failure: %s", excp.output)
                 raise excp
-- 
2.34.1

