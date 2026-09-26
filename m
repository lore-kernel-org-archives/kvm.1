Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4D7547063
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406258; cv=none; b=jTwXsSYbsvJvPu/ufcZrjWqEde8HWsZQhvKH4kPgL3OoNPPt/XDM75Hwfvu0Xc2OSoJr3J90LOrpxaq9c1ggYk800Ud4LKUUhMKV8nZuUMTT8IpVoEA0cM1WV8DQVNUUZ0TFx9bGgGi2fkAIm+XPoLFjFbIR+AQDQidWGZwFQzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406258; c=relaxed/simple;
	bh=ljuLOey/aL1GY0zzrdefG5m2HHQhGNvjCfDP+9IiuOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fWUSZKk3/y1ZfxkMTtm2p5I4OrqEekISn8DuTQhtTuyId/rwrYADiGwZdaLo/OY4ZdKuPLLJV2s4lf8E5WQrmQN5rzw8fanaXUc5ijCQINJVX2zWjyZJWRt4cyAmm+lsMJt6IIFACqpJUMXAKpD0vQGVhzpkd9HE4fkNonlF8Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUzsFRsX; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUzsFRsX"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-328664ef791so902783eec.3
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406257; x=1791011057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0cvIXglGfRA1jXahprL6v2Lr8S2XJ1LC0LkB99mN9UQ=;
        b=RUzsFRsXRIbwWrqZhijVGIs6QrgTDnyZR4P64JZ22fBPdVCRjcs70ljJKev/k9K/08
         UmFlpnCTN6lWiGg01n5s+GmIXXKGQGXQ6vR8UuqF98kN7PFDw22WcrxQvmrp+OjfU/ln
         ir5N7HTYuTRzULQYSWXYfHvVQe26Xt3k1exymylKzW/wcz9iUwjApxMLvm9Vfld3wNld
         3iQNTTqbHgHrkxHzUB/p/24hID0wvy6fHV40y+RgQi2FrSi8LJVTG2P55jUxrkW8O1xq
         q2yewUMPBfG4RN3N54nRmePCX2hkqnYPlVYEMYEsTVlmX6qdGLrLdepiOtibNeIDGXgp
         quyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406257; x=1791011057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0cvIXglGfRA1jXahprL6v2Lr8S2XJ1LC0LkB99mN9UQ=;
        b=hczE6TwuZgcNIeMr9npqhzeuVwBCRgHsfy/r+U2GVyY5okjWcPmW9Dz8/fSoHjn/eA
         IlUfEu9kShGq+DiMi423xhjeZjYyv7sV/nCtY9185AmWnXVsGYocAUEDVEFGVRNKBEWd
         i9ohLAX7EwYvbGjn9TaWDNN2bHcByBm4tAxpA9Un86fYFghpYvj/iWqj6graLfJZ+8TP
         BMoDbxA1c0Z1wITlbCFE2jJ5FPSko74uHE3YeK4Y7tp0BHU4KI+JvmBX+NagEfop9fWc
         r5ts+Y1ARYEE1Rsy8ECbi5Ber74TQ0KJ+Q7nD3KyRuEoOJRMDsS5ThaEjJg54b6ISMS6
         YqZA==
X-Forwarded-Encrypted: i=1; AKwUvByJse7W5dzQbNyRceLUA9E4BTKwlgYUw1pJ5CqaJCc7gEF7JQSGOlJv5fmtUNJ/DZF1ZjI=@vger.kernel.org
X-Gm-Message-State: AFuF++m3LZlBudvwxlWsWMCPQI7lW6AMyfB9neWrsz8cCBzcANsDddin
	6p5X8YkuWrbXLGZGgj1FvAd+wFKIhHa9ftMNRDUgwL2fy9CiWvpSSHk9
X-Gm-Gg: AYBFou02vbghTj6je1VqtWEhsnMAGqbhrh4RG6KPo+nTA2VafoO483BMCLUYfmwfYAo
	Qxs/Ag8FZa33N+auj5GhZiZyMSs5GnpjOHrfCKEi39XYYz80eAc89aqwbl44HkEvxstn8gL61IS
	A/dhX/2dZUAYdVVQBBdQUuc35Fqxrp916gcGNRpmkHLSDUFq7u7JD54IuvW6VDazArT3MMbEAO2
	LDEQGB0T+DldN99+vJIDMF4eGwtqUDOLdYjonmt64LHC7cMUQVRUElkoz94+4vFWtFOHpl0YbIu
	/6zOWUfNzY8dUiAcOt84dK7CB6gPq1oZWQtBpWSy3MLPChiRMrtIvneQIO4Itxf01Jpc1uUF7lF
	yf2szEaFHz7k5PqjGpHkeK56pQu37E6FitZAzRPD7GOQe8cVIIhHUBgLc+K2Cpr8EI1GlWkb4Wm
	ZGWoULa2gmpi0WQjONwi1NN3/fNKfIyGCygONJLFjp1JURsZ9Lz9O7IMYkGJCvXA9dN3WrYuCCB
	KtK09Cy/NUOCzvAPbK57ulSwhA8roo=
X-Received: by 2002:a05:7300:8a24:b0:33c:c0e:76ec with SMTP id 5a478bee46e88-342742360a7mr2334739eec.35.1790406256679;
        Sat, 26 Sep 2026 00:04:16 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:04:15 -0700 (PDT)
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
Subject: [PATCH v4 49/55] hw/microblaze: expand petalogix-ml605 and xlnx-zynqmp-pmu to TypeInfo
Date: Sat, 26 Sep 2026 15:00:48 +0800
Message-ID: <20260926070057.1234-50-luoyonggang@gmail.com>
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

Replace DEFINE_MACHINE with TypeInfo. Rename *_machine_init to
*_machine_class_init and set is_available to target_is_microblaze.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/microblaze/petalogix_ml605_mmu.c | 19 +++++++++++++++++--
 hw/microblaze/xlnx-zynqmp-pmu.c     | 19 +++++++++++++++++--
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index 8f9f54ff1e2..508a8005a63 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -26,6 +26,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "target/microblaze/cpu.h"
@@ -214,10 +215,24 @@ petalogix_ml605_init(MachineState *machine)
 
 }
 
-static void petalogix_ml605_machine_init(MachineClass *mc)
+static void petalogix_ml605_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "PetaLogix linux refdesign for xilinx ml605 (little endian)";
     mc->init = petalogix_ml605_init;
 }
 
-DEFINE_MACHINE("petalogix-ml605", petalogix_ml605_machine_init)
+static const TypeInfo petalogix_ml605_machine_class_init_typeinfo = {
+    .name = MACHINE_TYPE_NAME("petalogix-ml605"),
+    .parent = TYPE_MACHINE,
+    .class_init = petalogix_ml605_machine_class_init,
+    .is_available = target_is_microblaze,
+};
+
+static void petalogix_ml605_machine_class_init_register_types(void)
+{
+    type_register_static(&petalogix_ml605_machine_class_init_typeinfo);
+}
+
+type_init(petalogix_ml605_machine_class_init_register_types)
diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index 00154236bf8..79b70eb5ad7 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -16,6 +16,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "system/address-spaces.h"
 #include "hw/core/boards.h"
@@ -179,10 +180,24 @@ static void xlnx_zynqmp_pmu_init(MachineState *machine)
                            NULL);
 }
 
-static void xlnx_zynqmp_pmu_machine_init(MachineClass *mc)
+static void xlnx_zynqmp_pmu_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "Xilinx ZynqMP PMU machine (little endian)";
     mc->init = xlnx_zynqmp_pmu_init;
 }
 
-DEFINE_MACHINE("xlnx-zynqmp-pmu", xlnx_zynqmp_pmu_machine_init)
+static const TypeInfo xlnx_zynqmp_pmu_machine_class_init_typeinfo = {
+    .name = MACHINE_TYPE_NAME("xlnx-zynqmp-pmu"),
+    .parent = TYPE_MACHINE,
+    .class_init = xlnx_zynqmp_pmu_machine_class_init,
+    .is_available = target_is_microblaze,
+};
+
+static void xlnx_zynqmp_pmu_machine_class_init_register_types(void)
+{
+    type_register_static(&xlnx_zynqmp_pmu_machine_class_init_typeinfo);
+}
+
+type_init(xlnx_zynqmp_pmu_machine_class_init_register_types)
-- 
2.52.0.windows.1

