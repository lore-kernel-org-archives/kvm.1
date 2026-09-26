Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C366434DB41
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406263; cv=none; b=VdAxlaVLNYjVPB91daBrYDQM4GRDq15ZpXUCQmI7H5afXBioVFsEJZSVViZVZLcCH0PbmUHHwZE0PbevPtCjJ4TlKIGbxJFhekzifULDtJMqLIsDj1J3aiwY6szBR07aXmt+3vVBYtDOyVWkZh2EUN2Py3pxhKQhz9ThNX0CJ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406263; c=relaxed/simple;
	bh=jPNs0TN4ohkUOpZWk62aaKCTXKvZsEOOcdJnN23DIAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NtR5oTS2XkPuE2g6Bmekzo/Lfd9gEnZOSJYUbw8atZUfjdpwmwnSEUGgXVOBWa5Jy9Cfj5M9urCkirSI2cBolayw6bOrCoJjV4Pv6RJaU4PqQafKJSN6SixYApPVndSXeG+ZjehxuiGJ/nFTP2QojAq8mVWu0/2xmNI0HdDoJo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSTBrq8H; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSTBrq8H"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-341f6327b95so909790eec.0
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406261; x=1791011061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0u6v0Fz0eEopOq93fm9oJ1Po0gdhW3aHNUxjTbXaKJQ=;
        b=TSTBrq8HigR28s5v/uFWKQ5K0Jv9Vc/cs83LQpBuzttQx4s7wHH3j3fGNRQzw2r/6h
         i9sQTI4J6Iot850iYGrAaWBe1EYJ9euuE4y8LIB4RWv33rjTRGRQEw0/REbTb0JzKZey
         aFb557ATKNy9R2v4R6G94b2BTrcSA+WgB2PVOzprJ++LdFETGU2WMaX4844Yb9mawWQK
         qVYrlmBRAh+geeOqaXr5nPvtSJ4RKF015MyWRoDUQQmiy7Afsla4d0KZMbKTgSHeyFx+
         4DMbflJwkNe6Qh9BJsWVQsfCK3PEVQSzFm+/JRAChYRl3a+4jQtKjp7oN4aK06Ep/rPq
         G8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406261; x=1791011061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0u6v0Fz0eEopOq93fm9oJ1Po0gdhW3aHNUxjTbXaKJQ=;
        b=eLgob+AE8HMeVAq6LPl5+9KvCVISfjijDRoPxfBnssj4bY4495yUvlciuIVtSaE1P6
         Y9BZSVB+HjcZnA70/FniGdO85zC0OCW/qBWhrQCTupbmPzta26thi8LMZLfDVYW3favh
         1ArMPb2Wbe2JbHY6yHyea1wMqUWX5jd0Kg+0ue53V9lb/gjG0c+udzJEVEEM4rlI7SgM
         va5IkxtfSTZJZOMLYQ1dkDa/XlGoSkKWalhJ9nmXpw7KYKJQfEXBeDjacN6W3cwOyspA
         o5k7F0Do47P1lvcjLthjDDEgkGxhZx1Eecm6RugAEGUQtv+fbOyfuR1eUIhCb+chNqbT
         QxYg==
X-Forwarded-Encrypted: i=1; AKwUvBzrN96H/VwsEkEVF72DwQh3TT/CdZlLwjuWCDCuIkknnNLACWrsD+/aAeh+BxVJMr9y97w=@vger.kernel.org
X-Gm-Message-State: AFuF++lXVeWPqTP1dO6jxAzQVSKfR5mJADN3o3zT5ekYD7pN1x7pAHQm
	RnOCqBqcrQtGXQorgxPtrWzihuOYSzx3kcgp+sLSBLRO+ZHalTdBi9aq
X-Gm-Gg: AYBFou0F+aX68KUzCK2DqtGoVujEX0v7IlLdkB78yW21147z3zY5DcFqY50uI7IRtcB
	y6HPnAW4XC/cgynMjs85swLEeWZHYM5KweZVrD6gBCU66C8jPCpeexiIuhEy+8s22hl3p2v+0kw
	EA03gMcqve7lqnbwFyGZeNGkV7tGLdUnanu0+RUkUdFk9z8OJjjkGcNPPZ9cmZ020hL+wl2Fqj3
	W+tKNF/JlXCgnzLSFrj0EsMATm1Z7THCU6pVywxA/zEdIA5CR6cKR42GR86zqNKpMA7NhrD9WZu
	/jcQsLdPICNrDwnwGub42tYZJEHnJ5ZhP94mkTxGAfcGV06dj8ELSHcITcbupQj2GxwVfi+ucLH
	wXqsNXduaOtQ/AJ7Ay2Xml3uGVpeHFvPsAilACtJXgeD+pkpgoIFB+vLtC404PKBVN4Nwu+9YRA
	zVVn6XktZFS/L3v7iEN3PmNsnQX9nAuSOb/tc/Fc8vMLkCuvUYmy8KKEZaOcRd6rikTPrulEOOh
	rwv5gCOvQwHRPBR4YuvFB4WAOECIHU=
X-Received: by 2002:a05:7301:310:b0:341:bd7e:da35 with SMTP id 5a478bee46e88-342702bf0e8mr2173019eec.11.1790406260542;
        Sat, 26 Sep 2026 00:04:20 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:04:19 -0700 (PDT)
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
Subject: [PATCH v4 50/55] hw/arm: expand leftover 32-bit DEFINE_MACHINE to TypeInfo
Date: Sat, 26 Sep 2026 15:00:49 +0800
Message-ID: <20260926070057.1234-51-luoyonggang@gmail.com>
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

Replace remaining 32-bit DEFINE_MACHINE and DEFINE_MACHINE_EXTENDED
call sites with TypeInfo. Rename *_machine_init to
*_machine_class_init and set is_available to target_is_base_arm.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/arm/bananapi_m2u.c      | 22 +++++++++++++++++++---
 hw/arm/cubieboard.c        | 23 +++++++++++++++++++----
 hw/arm/digic_boards.c      | 19 +++++++++++++++++--
 hw/arm/imx25_pdk.c         | 19 +++++++++++++++++--
 hw/arm/integratorcp.c      | 23 +++++++++++++++++++----
 hw/arm/kzm.c               | 19 +++++++++++++++++--
 hw/arm/max78000fthr.c      | 19 +++++++++++++++++--
 hw/arm/mcimx6ul-evk.c      | 19 +++++++++++++++++--
 hw/arm/mcimx7d-sabre.c     | 23 +++++++++++++++++++----
 hw/arm/msf2-som.c          | 19 +++++++++++++++++--
 hw/arm/netduino2.c         | 19 +++++++++++++++++--
 hw/arm/netduinoplus2.c     | 19 +++++++++++++++++--
 hw/arm/olimex-stm32-h405.c | 19 +++++++++++++++++--
 hw/arm/orangepi.c          | 23 +++++++++++++++++++----
 hw/arm/stm32vldiscovery.c  | 19 +++++++++++++++++--
 15 files changed, 265 insertions(+), 39 deletions(-)

diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
index ccf60ba2955..a1d9105ce0d 100644
--- a/hw/arm/bananapi_m2u.c
+++ b/hw/arm/bananapi_m2u.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qemu/units.h"
 #include "system/address-spaces.h"
 #include "qapi/error.h"
@@ -133,8 +134,10 @@ static void bpim2u_init(MachineState *machine)
     arm_load_kernel(&r40->cpus[0], machine, &bpms->bootinfo);
 }
 
-static void bpim2u_machine_init(MachineClass *mc)
+static void bpim2u_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-a7"),
         NULL
@@ -152,5 +155,18 @@ static void bpim2u_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE_EXTENDED("bpim2u", MACHINE, Bpim2uMachineState,
-                        bpim2u_machine_init, false, false, NULL)
+static const TypeInfo bpim2u_machine_class_init_typeinfo = {
+    .name          = TYPE_BPIM2U_MACHINE,
+    .parent        = TYPE_MACHINE,
+    .class_init    = bpim2u_machine_class_init,
+    .instance_size = sizeof(Bpim2uMachineState),
+    .abstract      = false,
+    .is_available  = target_is_base_arm,
+};
+
+static void bpim2u_machine_class_init_register_types(void)
+{
+    type_register_static(&bpim2u_machine_class_init_typeinfo);
+}
+
+type_init(bpim2u_machine_class_init_register_types)
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index e4fef9cd76b..6e14d0e3351 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -16,6 +16,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/core/boards.h"
@@ -113,8 +114,10 @@ static void cubieboard_init(MachineState *machine)
     arm_load_kernel(&a10->cpu, machine, &cbs->bootinfo);
 }
 
-static void cubieboard_machine_init(MachineClass *mc)
+static void cubieboard_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-a8"),
         NULL
@@ -132,6 +135,18 @@ static void cubieboard_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE_EXTENDED("cubieboard", MACHINE, CubieboardMachineState,
-                        cubieboard_machine_init, false, false,
-                        NULL)
+static const TypeInfo cubieboard_machine_class_init_typeinfo = {
+    .name          = TYPE_CUBIEBOARD_MACHINE,
+    .parent        = TYPE_MACHINE,
+    .class_init    = cubieboard_machine_class_init,
+    .instance_size = sizeof(CubieboardMachineState),
+    .abstract      = false,
+    .is_available  = target_is_base_arm,
+};
+
+static void cubieboard_machine_class_init_register_types(void)
+{
+    type_register_static(&cubieboard_machine_class_init_typeinfo);
+}
+
+type_init(cubieboard_machine_class_init_register_types)
diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index 90c19106ad0..e92d3177039 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -24,6 +24,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qemu/datadir.h"
 #include "hw/core/boards.h"
@@ -136,8 +137,10 @@ static void canon_a1100_init(MachineState *machine)
     digic4_board_init(machine, &digic4_board_canon_a1100);
 }
 
-static void canon_a1100_machine_init(MachineClass *mc)
+static void canon_a1100_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "Canon PowerShot A1100 IS (ARM946)";
     mc->init = &canon_a1100_init;
     mc->ignore_memory_transaction_failures = true;
@@ -145,4 +148,16 @@ static void canon_a1100_machine_init(MachineClass *mc)
     mc->default_ram_id = "ram";
 }
 
-DEFINE_MACHINE("canon-a1100", canon_a1100_machine_init)
+static const TypeInfo canon_a1100_machine_class_init_typeinfo = {
+    .name = MACHINE_TYPE_NAME("canon-a1100"),
+    .parent = TYPE_MACHINE,
+    .class_init = canon_a1100_machine_class_init,
+    .is_available = target_is_base_arm,
+};
+
+static void canon_a1100_machine_class_init_register_types(void)
+{
+    type_register_static(&canon_a1100_machine_class_init_typeinfo);
+}
+
+type_init(canon_a1100_machine_class_init_register_types)
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index 243c30a67e7..c0c473e7103 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -24,6 +24,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/arm/fsl-imx25.h"
@@ -140,8 +141,10 @@ static void imx25_pdk_init(MachineState *machine)
     }
 }
 
-static void imx25_pdk_machine_init(MachineClass *mc)
+static void imx25_pdk_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "ARM i.MX25 PDK board (ARM926)";
     mc->init = imx25_pdk_init;
     mc->ignore_memory_transaction_failures = true;
@@ -149,4 +152,16 @@ static void imx25_pdk_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE("imx25-pdk", imx25_pdk_machine_init)
+static const TypeInfo imx25_pdk_machine_class_init_typeinfo = {
+    .name = MACHINE_TYPE_NAME("imx25-pdk"),
+    .parent = TYPE_MACHINE,
+    .class_init = imx25_pdk_machine_class_init,
+    .is_available = target_is_base_arm,
+};
+
+static void imx25_pdk_machine_class_init_register_types(void)
+{
+    type_register_static(&imx25_pdk_machine_class_init_typeinfo);
+}
+
+type_init(imx25_pdk_machine_class_init_register_types)
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index b766edeeee1..94ab08591ce 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -8,6 +8,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
@@ -691,8 +692,10 @@ static void integratorcp_init(MachineState *machine)
     arm_load_kernel(cpu, machine, &icms->bootinfo);
 }
 
-static void integratorcp_machine_init(MachineClass *mc)
+static void integratorcp_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "ARM Integrator/CP (ARM926EJ-S)";
     mc->init = integratorcp_init;
     mc->ignore_memory_transaction_failures = true;
@@ -703,9 +706,21 @@ static void integratorcp_machine_init(MachineClass *mc)
     machine_add_audiodev_property(mc);
 }
 
-DEFINE_MACHINE_EXTENDED("integratorcp", MACHINE, IntegratorcpMachineState,
-                        integratorcp_machine_init, false, false,
-                        NULL)
+static const TypeInfo integratorcp_machine_class_init_typeinfo = {
+    .name          = TYPE_INTEGRATORCP_MACHINE,
+    .parent        = TYPE_MACHINE,
+    .class_init    = integratorcp_machine_class_init,
+    .instance_size = sizeof(IntegratorcpMachineState),
+    .abstract      = false,
+    .is_available  = target_is_base_arm,
+};
+
+static void integratorcp_machine_class_init_register_types(void)
+{
+    type_register_static(&integratorcp_machine_class_init_typeinfo);
+}
+
+type_init(integratorcp_machine_class_init_register_types)
 
 static const Property core_properties[] = {
     DEFINE_PROP_UINT32("memsz", IntegratorCMState, memsz, 0),
diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index 387bf54ced1..aaff504564f 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -14,6 +14,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx31.h"
 #include "hw/arm/boot.h"
@@ -129,12 +130,26 @@ static void kzm_init(MachineState *machine)
     }
 }
 
-static void kzm_machine_init(MachineClass *mc)
+static void kzm_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "ARM KZM Emulation Baseboard (ARM1136)";
     mc->init = kzm_init;
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_id = "kzm.ram";
 }
 
-DEFINE_MACHINE("kzm", kzm_machine_init)
+static const TypeInfo kzm_machine_class_init_typeinfo = {
+    .name = MACHINE_TYPE_NAME("kzm"),
+    .parent = TYPE_MACHINE,
+    .class_init = kzm_machine_class_init,
+    .is_available = target_is_base_arm,
+};
+
+static void kzm_machine_class_init_register_types(void)
+{
+    type_register_static(&kzm_machine_class_init_typeinfo);
+}
+
+type_init(kzm_machine_class_init_register_types)
diff --git a/hw/arm/max78000fthr.c b/hw/arm/max78000fthr.c
index ed50bb91979..dce29ccb6a1 100644
--- a/hw/arm/max78000fthr.c
+++ b/hw/arm/max78000fthr.c
@@ -7,6 +7,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "hw/core/boards.h"
 #include "hw/core/qdev-properties.h"
@@ -35,8 +36,10 @@ static void max78000_init(MachineState *machine)
                        0x00000000, FLASH_SIZE);
 }
 
-static void max78000_machine_init(MachineClass *mc)
+static void max78000_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-m4"),
         NULL
@@ -47,4 +50,16 @@ static void max78000_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
 }
 
-DEFINE_MACHINE("max78000fthr", max78000_machine_init)
+static const TypeInfo max78000_machine_class_init_typeinfo = {
+    .name = MACHINE_TYPE_NAME("max78000fthr"),
+    .parent = TYPE_MACHINE,
+    .class_init = max78000_machine_class_init,
+    .is_available = target_is_base_arm,
+};
+
+static void max78000_machine_class_init_register_types(void)
+{
+    type_register_static(&max78000_machine_class_init_typeinfo);
+}
+
+type_init(max78000_machine_class_init_register_types)
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 40071d2c7b9..30de24727ad 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx6ul.h"
 #include "hw/arm/boot.h"
@@ -68,8 +69,10 @@ static void mcimx6ul_evk_init(MachineState *machine)
     }
 }
 
-static void mcimx6ul_evk_machine_init(MachineClass *mc)
+static void mcimx6ul_evk_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "Freescale i.MX6UL Evaluation Kit (Cortex-A7)";
     mc->init = mcimx6ul_evk_init;
     mc->max_cpus = FSL_IMX6UL_NUM_CPUS;
@@ -77,4 +80,16 @@ static void mcimx6ul_evk_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE("mcimx6ul-evk", mcimx6ul_evk_machine_init)
+static const TypeInfo mcimx6ul_evk_machine_class_init_typeinfo = {
+    .name = MACHINE_TYPE_NAME("mcimx6ul-evk"),
+    .parent = TYPE_MACHINE,
+    .class_init = mcimx6ul_evk_machine_class_init,
+    .is_available = target_is_base_arm,
+};
+
+static void mcimx6ul_evk_machine_class_init_register_types(void)
+{
+    type_register_static(&mcimx6ul_evk_machine_class_init_typeinfo);
+}
+
+type_init(mcimx6ul_evk_machine_class_init_register_types)
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index 65fdb19c06f..14e6de8662a 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -13,6 +13,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx7.h"
 #include "hw/arm/boot.h"
@@ -76,8 +77,10 @@ static void mcimx7d_sabre_init(MachineState *machine)
     }
 }
 
-static void mcimx7d_sabre_machine_init(MachineClass *mc)
+static void mcimx7d_sabre_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "Freescale i.MX7 DUAL SABRE (Cortex-A7)";
     mc->init = mcimx7d_sabre_init;
     mc->max_cpus = FSL_IMX7_NUM_CPUS;
@@ -85,6 +88,18 @@ static void mcimx7d_sabre_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE_EXTENDED("mcimx7d-sabre", MACHINE, Mcimx7dSabreMachineState,
-                        mcimx7d_sabre_machine_init, false, false,
-                        NULL)
+static const TypeInfo mcimx7d_sabre_machine_class_init_typeinfo = {
+    .name          = TYPE_MCIMX7D_SABRE_MACHINE,
+    .parent        = TYPE_MACHINE,
+    .class_init    = mcimx7d_sabre_machine_class_init,
+    .instance_size = sizeof(Mcimx7dSabreMachineState),
+    .abstract      = false,
+    .is_available  = target_is_base_arm,
+};
+
+static void mcimx7d_sabre_machine_class_init_register_types(void)
+{
+    type_register_static(&mcimx7d_sabre_machine_class_init_typeinfo);
+}
+
+type_init(mcimx7d_sabre_machine_class_init_register_types)
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index 1372d7f628a..5dc30b54d7d 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -26,6 +26,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
@@ -96,8 +97,10 @@ static void emcraft_sf2_s2s010_init(MachineState *machine)
                        0, soc->envm_size);
 }
 
-static void emcraft_sf2_machine_init(MachineClass *mc)
+static void emcraft_sf2_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-m3"),
         NULL
@@ -108,4 +111,16 @@ static void emcraft_sf2_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
 }
 
-DEFINE_MACHINE("emcraft-sf2", emcraft_sf2_machine_init)
+static const TypeInfo emcraft_sf2_machine_class_init_typeinfo = {
+    .name = MACHINE_TYPE_NAME("emcraft-sf2"),
+    .parent = TYPE_MACHINE,
+    .class_init = emcraft_sf2_machine_class_init,
+    .is_available = target_is_base_arm,
+};
+
+static void emcraft_sf2_machine_class_init_register_types(void)
+{
+    type_register_static(&emcraft_sf2_machine_class_init_typeinfo);
+}
+
+type_init(emcraft_sf2_machine_class_init_register_types)
diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index 0db8798b4bd..5cb7d05877f 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "hw/core/boards.h"
 #include "hw/core/qdev-properties.h"
@@ -52,8 +53,10 @@ static void netduino2_init(MachineState *machine)
                        0, FLASH_SIZE);
 }
 
-static void netduino2_machine_init(MachineClass *mc)
+static void netduino2_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-m3"),
         NULL
@@ -65,4 +68,16 @@ static void netduino2_machine_init(MachineClass *mc)
     mc->ignore_memory_transaction_failures = true;
 }
 
-DEFINE_MACHINE("netduino2", netduino2_machine_init)
+static const TypeInfo netduino2_machine_class_init_typeinfo = {
+    .name = MACHINE_TYPE_NAME("netduino2"),
+    .parent = TYPE_MACHINE,
+    .class_init = netduino2_machine_class_init,
+    .is_available = target_is_base_arm,
+};
+
+static void netduino2_machine_class_init_register_types(void)
+{
+    type_register_static(&netduino2_machine_class_init_typeinfo);
+}
+
+type_init(netduino2_machine_class_init_register_types)
diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
index 5ac0eb81637..7a750988f17 100644
--- a/hw/arm/netduinoplus2.c
+++ b/hw/arm/netduinoplus2.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "hw/core/boards.h"
 #include "hw/core/qdev-properties.h"
@@ -53,8 +54,10 @@ static void netduinoplus2_init(MachineState *machine)
                        0, FLASH_SIZE);
 }
 
-static void netduinoplus2_machine_init(MachineClass *mc)
+static void netduinoplus2_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-m4"),
         NULL
@@ -65,4 +68,16 @@ static void netduinoplus2_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
 }
 
-DEFINE_MACHINE("netduinoplus2", netduinoplus2_machine_init)
+static const TypeInfo netduinoplus2_machine_class_init_typeinfo = {
+    .name = MACHINE_TYPE_NAME("netduinoplus2"),
+    .parent = TYPE_MACHINE,
+    .class_init = netduinoplus2_machine_class_init,
+    .is_available = target_is_base_arm,
+};
+
+static void netduinoplus2_machine_class_init_register_types(void)
+{
+    type_register_static(&netduinoplus2_machine_class_init_typeinfo);
+}
+
+type_init(netduinoplus2_machine_class_init_register_types)
diff --git a/hw/arm/olimex-stm32-h405.c b/hw/arm/olimex-stm32-h405.c
index de9ac4978ce..4e93a245998 100644
--- a/hw/arm/olimex-stm32-h405.c
+++ b/hw/arm/olimex-stm32-h405.c
@@ -24,6 +24,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "hw/core/boards.h"
 #include "hw/core/qdev-properties.h"
@@ -56,8 +57,10 @@ static void olimex_stm32_h405_init(MachineState *machine)
                        0, FLASH_SIZE);
 }
 
-static void olimex_stm32_h405_machine_init(MachineClass *mc)
+static void olimex_stm32_h405_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-m4"),
         NULL
@@ -71,4 +74,16 @@ static void olimex_stm32_h405_machine_init(MachineClass *mc)
     mc->default_ram_size = 0;
 }
 
-DEFINE_MACHINE("olimex-stm32-h405", olimex_stm32_h405_machine_init)
+static const TypeInfo olimex_stm32_h405_machine_class_init_typeinfo = {
+    .name = MACHINE_TYPE_NAME("olimex-stm32-h405"),
+    .parent = TYPE_MACHINE,
+    .class_init = olimex_stm32_h405_machine_class_init,
+    .is_available = target_is_base_arm,
+};
+
+static void olimex_stm32_h405_machine_class_init_register_types(void)
+{
+    type_register_static(&olimex_stm32_h405_machine_class_init_typeinfo);
+}
+
+type_init(olimex_stm32_h405_machine_class_init_register_types)
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index 18ed174032b..c6b0906c980 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qemu/units.h"
 #include "system/address-spaces.h"
 #include "qapi/error.h"
@@ -111,8 +112,10 @@ static void orangepi_init(MachineState *machine)
     arm_load_kernel(&h3->cpus[0], machine, &opms->bootinfo);
 }
 
-static void orangepi_machine_init(MachineClass *mc)
+static void orangepi_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-a7"),
         NULL
@@ -132,6 +135,18 @@ static void orangepi_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE_EXTENDED("orangepi-pc", MACHINE, OrangePiMachineState,
-                        orangepi_machine_init, false, false,
-                        NULL)
+static const TypeInfo orangepi_machine_class_init_typeinfo = {
+    .name          = TYPE_ORANGEPI_MACHINE,
+    .parent        = TYPE_MACHINE,
+    .class_init    = orangepi_machine_class_init,
+    .instance_size = sizeof(OrangePiMachineState),
+    .abstract      = false,
+    .is_available  = target_is_base_arm,
+};
+
+static void orangepi_machine_class_init_register_types(void)
+{
+    type_register_static(&orangepi_machine_class_init_typeinfo);
+}
+
+type_init(orangepi_machine_class_init_register_types)
diff --git a/hw/arm/stm32vldiscovery.c b/hw/arm/stm32vldiscovery.c
index d899a134b38..3b439c80a67 100644
--- a/hw/arm/stm32vldiscovery.c
+++ b/hw/arm/stm32vldiscovery.c
@@ -24,6 +24,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "hw/core/boards.h"
 #include "hw/core/qdev-properties.h"
@@ -56,8 +57,10 @@ static void stm32vldiscovery_init(MachineState *machine)
                        0, FLASH_SIZE);
 }
 
-static void stm32vldiscovery_machine_init(MachineClass *mc)
+static void stm32vldiscovery_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-m3"),
         NULL
@@ -68,4 +71,16 @@ static void stm32vldiscovery_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
 }
 
-DEFINE_MACHINE("stm32vldiscovery", stm32vldiscovery_machine_init)
+static const TypeInfo stm32vldiscovery_machine_class_init_typeinfo = {
+    .name = MACHINE_TYPE_NAME("stm32vldiscovery"),
+    .parent = TYPE_MACHINE,
+    .class_init = stm32vldiscovery_machine_class_init,
+    .is_available = target_is_base_arm,
+};
+
+static void stm32vldiscovery_machine_class_init_register_types(void)
+{
+    type_register_static(&stm32vldiscovery_machine_class_init_typeinfo);
+}
+
+type_init(stm32vldiscovery_machine_class_init_register_types)
-- 
2.52.0.windows.1

