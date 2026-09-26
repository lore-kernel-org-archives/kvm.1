Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC7E362154
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406130; cv=none; b=nCs5KBJWqePsD9TX/pFDzeiVvalVZI8eOXIO9OBmQWt2k6tpD/LGXCRPIId0nw5eyZBOyKsJDMXhgiRzHz8v8DL5/ZQzOqPXCd5HAvxDpZThNwyL8sDty+mDwmJzvnrMzD8gD61MtIuMWwhs3tqj4Nlgdhb+DNODoYbp7+1Swgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406130; c=relaxed/simple;
	bh=egl+yJd2vVo3F2hqjGhI+W9Lhwm+PcqaY/vgy9W0e5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i4Drz8X9JHoI5iITqDzA5Izoo/0dx4uMpCczAz8WTa9vkJm6LRcCM6RROvLTY904dHT3vynrzZeBS6CWQMB1EVVzcIa9o5PcZyHPYp0VkKf5lCBAdkZA/cntx77gw0+XVNSSUTxHcB4usqS6Lzk1mnDIlx4v56LESjO8+bmG6wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXhApl2D; arc=none smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXhApl2D"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd025d07so1318481c88.2
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406128; x=1791010928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bnB/iWAyXAxW1TeHJut1enjEPN/SkInFqx09vCaNhBQ=;
        b=gXhApl2DJ/BG8/BP7799IEIbgX3kut7xL0PkWI3H1oa/st5uc7c0mpEixHH+eX3ELt
         svHfyfei7CsTPoGHxiCWsKVyKwte5j3IxR0Dyshz61JgSdSCPGboLZia4qghMR9/LxYM
         wL5m9BFBdQmGyFIUZs3hOpannr0MfhMMOm/wauQEBXKubou9c4vIu6BTnNMqfIpaEaB8
         W1S15MnSddCWz+7rfRkS5GwOlkiW1foCoDUoCrUNdokuCDCEUWGEjmQR6HG80iWbs7JQ
         MwgXdh5dbrN6ZE1+L5YgkGCsojO1szBt6oYpT0Xw3Y015TFm7cdbcqsyuYPYKn2LmevR
         CO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406128; x=1791010928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bnB/iWAyXAxW1TeHJut1enjEPN/SkInFqx09vCaNhBQ=;
        b=ne38qsQ0WTcFoNjz1Yidn2fBkGbgoRI+qh9gkMDLixblx+m07S81Fps9v9C/NKDSVa
         1Qv/4f0kk5f20BWKeERNrg9BEu7Oi0SMrGKDQ6s6qQj7fytlfrz+8L4OG+fy987Dv/LA
         2XW/iMQwr7CkIl/xjJZDebRxhtO9sFlMQXvXO3//GI3imV5/i9gz8WEYjM/MtFHsVtyp
         XEzwSU5lfoqPJ7Q/uMyjVRfMiZJE1mMujQG/PzBlRd96EuFUEL9s4XthqlWE/RpqObnU
         ewbmPxVGtIORXO+9lnee8OqTfMPZPQBYrDV4LrbN1MDDpTOXIVKnA2d+fylWSo6B+eqP
         IZgg==
X-Forwarded-Encrypted: i=1; AKwUvBzMSGMJcneoJ9oLd/U6S/EOB/2joHXdc5oMwBaIKDNjt39ZkUIVvyOIi8JryGbKeupcTN4=@vger.kernel.org
X-Gm-Message-State: AFuF++nVX9GnOGN4lx8/E2YQcYgrvVhO+LDBQuUPGhz+CKKCEatuA+pN
	TeN4JYuthibVKKqxZ2RsnPcXijrwEUeWsFL+/4ssAZWj7+2Rz8Kfzc29
X-Gm-Gg: AYBFou0PxKmMmFk2NVuy6xHoHAsoxmH+1IJxqGBNcKnlX+czs3Y6RrkeCp95hZARqJu
	he91/Dc+8tAKUwOfz7WOSn1gcwLrhelGBcuk65a9bY+OwdI9reM+4p/pr09yrNfQWI5EkswIUxZ
	xPSomiMDxu0A8ZrowzhNu2qpdJLjSkQAHovszyUc+4NMxegs7C0f/9vSj9Lx8YVE/1mhCH/4bhN
	iZ5NXx9pFa2gkHZLnDrqHDtDgcriWVFf3zQIGe3ntj8oO7608xgN062Dql4QUPu+yVRZxxPs+DE
	3TBdP6R+hA8qS0YXCJct9K1oAjpdBRcS+DMwVIcyIeeR3p8uRI5TYR5rCyVsLuWjEve3ahhqg4Y
	WWhEAlKMm07F3Z5Z5s9MtIRCWWhf+0qGqbIyj0XKqqysuYaOhX9hdKFOv5zkRr/hlP/06sYlZRv
	U8jcvAJ//y/xhfh2AQlWJMYIKE4Xtj43YqIyc2mnSe046g7Er0WZWsWz6oZlUQd+FWZNX/Dlo81
	AokjLxOOGFYVX67Zo/HUcYyIofLY8w=
X-Received: by 2002:a05:701b:2059:20b0:143:7001:7643 with SMTP id a92af1059eb24-146d096d4bamr2224508c88.46.1790406128075;
        Sat, 26 Sep 2026 00:02:08 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:02:07 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Fabiano Rosas <farosas@suse.de>,
	Laurent Vivier <lvivier@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v4 16/55] target/arm: gate -cpu host with TypeIsAvailable
Date: Sat, 26 Sep 2026 15:00:15 +0800
Message-ID: <20260926070057.1234-17-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926070057.1234-1-luoyonggang@gmail.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Register the host ARMCPU type for every target and hide it with
is_available. aarch64_host_initfn picks kvm, hvf, whpx, or nitro
from TargetKconfig instead of CONFIG_* ifdefs.

- Add ARMCPUInfo.is_available and pass it from arm_cpu_register
- target_has_arm_host_cpu covers kvm, hvf, whpx, and nitro
- Add hvf and whpx set_cpu_features_from_host stubs

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/arm/cpu.c            |  1 +
 target/arm/cpu.h            |  1 +
 target/arm/cpu64.c          | 43 +++++++++++++++++++++----------------
 target/arm/hvf/hvf-stub.c   | 14 ++++++++++++
 target/arm/hvf/meson.build  |  1 +
 target/arm/whpx/whpx-stub.c |  5 +++++
 6 files changed, 47 insertions(+), 18 deletions(-)
 create mode 100644 target/arm/hvf/hvf-stub.c

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index c138c4c0587..9b498632c86 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2685,6 +2685,7 @@ void arm_cpu_register(const ARMCPUInfo *info)
         .instance_init = arm_cpu_instance_init,
         .class_init = info->class_init ?: cpu_register_class_init,
         .class_data = info,
+        .is_available = info->is_available,
     };
 
     type_info.name = g_strdup_printf("%s-" TYPE_ARM_CPU, info->name);
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e3f931dba26..87de7e9ff09 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1177,6 +1177,7 @@ typedef struct ARMCPUInfo {
     const char *deprecation_note;
     void (*initfn)(Object *obj);
     void (*class_init)(ObjectClass *oc, const void *data);
+    TypeIsAvailable *is_available;
 } ARMCPUInfo;
 
 /**
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 03f3d55f6ba..168639ac2f4 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -20,6 +20,8 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/target-info.h"
+#include "qemu/target-kconfig-has.h"
 #include "cpu.h"
 #include "cpregs.h"
 #include "qemu/module.h"
@@ -757,37 +759,42 @@ static void aarch64_a53_initfn(Object *obj)
 void aarch64_host_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+    const TargetInfo *ti = target_info();
 
-#if defined(CONFIG_NITRO)
-    if (nitro_enabled()) {
+    if (target_has_kconfig_nitro(ti) && nitro_enabled()) {
         /* The nitro accel uses -cpu host, but does not actually consume it */
         return;
     }
-#endif
 
-#if defined(CONFIG_KVM)
-    kvm_arm_set_cpreg_mig_tolerances(cpu);
-    kvm_arm_set_cpu_features_from_host(cpu);
-    aarch64_add_sve_properties(obj);
-#elif defined(CONFIG_HVF)
-    hvf_arm_set_cpu_features_from_host(cpu);
-#elif defined(CONFIG_WHPX)
-    whpx_arm_set_cpu_features_from_host(cpu);
-#else
-    cpu->host_cpu_probe_failed = true;
-#endif
+    if (target_has_kconfig_kvm(ti)) {
+        kvm_arm_set_cpreg_mig_tolerances(cpu);
+        kvm_arm_set_cpu_features_from_host(cpu);
+        aarch64_add_sve_properties(obj);
+    } else if (target_has_kconfig_hvf(ti)) {
+        hvf_arm_set_cpu_features_from_host(cpu);
+    } else if (target_has_kconfig_whpx(ti)) {
+        whpx_arm_set_cpu_features_from_host(cpu);
+    } else {
+        cpu->host_cpu_probe_failed = true;
+    }
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         aarch64_add_pauth_properties(obj);
     }
 }
 
+static bool target_has_arm_host_cpu(const TargetInfo *ti)
+{
+    return target_has_kconfig_kvm(ti)
+        || target_has_kconfig_hvf(ti)
+        || target_has_kconfig_whpx(ti)
+        || target_has_kconfig_nitro(ti);
+}
+
 static const ARMCPUInfo aarch64_cpus[] = {
     { .name = "cortex-a57",         .initfn = aarch64_a57_initfn },
     { .name = "cortex-a53",         .initfn = aarch64_a53_initfn },
-#if defined(CONFIG_KVM) || defined(CONFIG_HVF) || defined(CONFIG_WHPX) || \
-    defined(CONFIG_NITRO)
-    { .name = "host",               .initfn = aarch64_host_initfn },
-#endif
+    { .name = "host",               .initfn = aarch64_host_initfn,
+      .is_available = target_has_arm_host_cpu },
 };
 
 static void aarch64_cpu_register_types(void)
diff --git a/target/arm/hvf/hvf-stub.c b/target/arm/hvf/hvf-stub.c
new file mode 100644
index 00000000000..3c8148316c9
--- /dev/null
+++ b/target/arm/hvf/hvf-stub.c
@@ -0,0 +1,14 @@
+/*
+ * QEMU HVF ARM specific function stubs
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hvf_arm.h"
+
+void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
diff --git a/target/arm/hvf/meson.build b/target/arm/hvf/meson.build
index afc509a470e..055fab56fb6 100644
--- a/target/arm/hvf/meson.build
+++ b/target/arm/hvf/meson.build
@@ -1,3 +1,4 @@
 arm_system_ss.add(when: [hvf, 'CONFIG_HVF'], if_true: files(
   'hvf.c',
 ))
+arm_stubs_ss.add(files('hvf-stub.c'))
diff --git a/target/arm/whpx/whpx-stub.c b/target/arm/whpx/whpx-stub.c
index 32e434a5f6a..3d1cbb33a28 100644
--- a/target/arm/whpx/whpx-stub.c
+++ b/target/arm/whpx/whpx-stub.c
@@ -13,3 +13,8 @@ uint32_t whpx_arm_get_ipa_bit_size(void)
 {
     g_assert_not_reached();
 }
+
+void whpx_arm_set_cpu_features_from_host(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
-- 
2.52.0.windows.1

