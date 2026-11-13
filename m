Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.6.4.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563325;
	b=OTbb67Kdy/A2IfsBrY/N23g1yT7P01OnIn3KyuAj6CwPTQg7v6yrJpZNLReN+6HafstI
	 5AkcdU/E7g/k/xB3VeQjVzq/I546rIb6oaVbI+xu9oOxpMrYb+fo9NiDpvO93S+L03NNt
	 6gbqPDLJzpz3oVttTgRBlUqxRNUXni8yW7jhX6eVDncH01McAkPirQaHq85iP9amg9HpT
	 W8NNjWVDhfVjpaBxTC6W5ZXj7xVIywmS2bP2IGeLBzShmcfZTSHAJpU0mAtGvAgQ6kn3U
	 4YvDan2R26UAYM5nb9BqS7J7w3/0uV2TIVHjCmiJ3uYE7VqUVeJxNfzOzwbLEDdrq/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563325;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=5rYCSc9BZBxLWSnCH8ttIEa3yunZtJv3aza5AxwoCss=;
	b=uYf/Gequkb9GVB6wppzh9iBsebUTDFVQUaw4z9OJDsHWxaYQy5DRUNh4+wdQYi4wS1pD
	 LFzRVUKbaVYEplV4da12f1rYjHHA7huhKgxClKczHGBqEfgbxBjKqQx0/eSr7pUzPexD/
	 oa7HU/BQbVRvu5RJW3aUm76WteAecqG4BLkS71FXzzW96/5iyUlsWDs4vTxu+fg/DaQCy
	 BoqHFsfs4t/LSzawQmrFlNhsFw2B/YT8Qx1ZAR6cKgG8oD5pzP6I/GBNV5mZXpx4bHs6i
	 EkNp9dqzT0oTZDzJxqE+5iLTjCyjC8Q77vi1mzMJaZBRaxl2q65gsADZn3C5AZaRmlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mails.tsinghua.edu.cn;
	spf=pass smtp.mailfrom=mails.tsinghua.edu.cn;
	dkim=pass header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=ellOUG33;
	arc=none smtp.remote-ip=101.6.4.70
Received: from tsinghua.edu.cn (smtp46.tsinghua.edu.cn [101.6.4.70])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54031606A339
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 09:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54031606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=ellOUG33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=5rYCSc9BZBxLWSnCH8ttIEa3yunZtJv3az
	a5AxwoCss=; b=ellOUG33Q2PBYwCa74WTsqEANw0ZqR/mE5nCss6gOrEW1CRhz3
	LiEoJEv0SE63WHnWNT9pPl8QDvax8m5PanE++2dQ44Ni5bPByJ65OgYRz//zS2Pt
	+zYf6x06XSxqq+QIUrELfZ72CWwTWE3Cv83R5p0BUA9QM4bHtGx6TKr7M=
Received: from ubuntu (unknown [101.5.154.165])
	by web1 (Coremail) with SMTP id yAQGZQA3qzvR3PZqgA5CAg--.9318S8;
	Fri, 13 Nov 2026 17:48:33 +0800 (CST)
From: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
To: qemu-devel@nongnu.org
Cc: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org,
	kvm@vger.kernel.org,
	Peter Maydell <peter.maydell@linaro.org>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	Kevin Wolf <kwolf@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	bin.meng@processmission.com,
	tangtao1634@phytium.com.cn,
	Chao Liu <chao.liu@processmission.com>
Subject: [RFC PATCH 06/20] hw/arm: add the Rockchip RK3588 SoC
Date: Fri, 13 Nov 2026 17:47:40 +0800
Message-ID: <b6d3b81d652d579ca552c7a6787192185cf6d3de.1794555589.git.w-yf22@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794555588.git.w-yf22@mails.tsinghua.edu.cn>
References: <cover.1794555588.git.w-yf22@mails.tsinghua.edu.cn>
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
X-CM-TRANSID:yAQGZQA3qzvR3PZqgA5CAg--.9318S8
X-Coremail-Antispam: 1UD129KBjvJXoW3JFWrJw1kJF4rJF4kGF18Grg_yoW3XFW8pF
	1DCr98GFWDKFW3A3ySqr4SqF1rJan2grWjqay7ur9ayay3tw1jyr12vF43Ca47WrsrCr15
	G39Iqw4Ygrs5XF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHa14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
	AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
	IFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_
	GFWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUeVbkUU
	UUU
X-CM-SenderInfo: fzn1wj2s6ptxtovo32xlqjx3vdohv3gofq/

From: Chao Liu <chao.liu@processmission.com>

Add the RK3588 SoC container with four Cortex-A55 and four Cortex-A76
CPUs, the system memory link and on-chip SRAM.

Signed-off-by: Chao Liu <chao.liu@processmission.com>
Signed-off-by: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
---
 MAINTAINERS             |   8 +++
 hw/arm/Kconfig          |   4 ++
 hw/arm/meson.build      |   2 +
 hw/arm/rk3588.c         | 149 ++++++++++++++++++++++++++++++++++++++++
 include/hw/arm/rk3588.h |  51 ++++++++++++++
 5 files changed, 214 insertions(+)
 create mode 100644 hw/arm/rk3588.c
 create mode 100644 include/hw/arm/rk3588.h

diff --git a/MAINTAINERS b/MAINTAINERS
index db1a62a0cb..e7caabd565 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1059,6 +1059,14 @@ F: include/hw/intc/realview_gic.h
 F: docs/system/arm/realview.rst
 F: tests/functional/arm/test_realview.py
 
+Rockchip RK3588
+M: Chao Liu <chao.liu@processmission.com>
+M: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: hw/arm/rk3588.c
+F: include/hw/arm/rk3588.h
+
 SABRELITE / i.MX6
 M: Peter Maydell <peter.maydell@linaro.org>
 R: Jean-Christophe Dubois <jcd@tribudubois.net>
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index e9f796f718..79b66de041 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -774,3 +774,7 @@ config AXIADO_EVK
     default y
     depends on TCG && ARM
     select AXIADO_SOC
+
+config RK3588
+    bool
+    select CPU_CLUSTER
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index f3c1b0e00f..70c835814f 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -120,4 +120,6 @@ arm_common_ss.add(when: ['CONFIG_AXIADO_EVK', 'TARGET_AARCH64'], if_true: files(
 
 arm_common_ss.add(files('boot.c'))
 
+arm_common_ss.add(when: 'CONFIG_RK3588', if_true: files('rk3588.c'))
+
 hw_common_arch += {'arm': arm_common_ss}
diff --git a/hw/arm/rk3588.c b/hw/arm/rk3588.c
new file mode 100644
index 0000000000..1e6f44433c
--- /dev/null
+++ b/hw/arm/rk3588.c
@@ -0,0 +1,149 @@
+/*
+ * Rockchip RK3588 SoC
+ *
+ * Copyright (C) 2026 Process Mission
+ *
+ * Authors:
+ *    Chao Liu <chao.liu@processmission.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+#include "qemu/units.h"
+#include "qapi/error.h"
+#include "hw/arm/rk3588.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/sysbus.h"
+#include "hw/cpu/cluster.h"
+#include "migration/vmstate.h"
+
+/* MPIDR Aff0 values per Aff1: 1 (one CPU per RK3588 cluster). */
+#define RK3588_MPIDR_AFF0_PER_AFF1   (1)
+
+#define RK3588_CNTFRQ                24000000
+
+/* The RK3588 CPU map has one A55 quad cluster and two A76 dual clusters. */
+static const struct {
+    unsigned int num_cpus;
+    const char *cpu_type;
+} rk3588_cpu_clusters[] = {
+    [RK3588_CLUSTER_A55] = {
+        .num_cpus = RK3588_A55_CPUS,
+        .cpu_type = ARM_CPU_TYPE_NAME("cortex-a55"),
+    },
+    [RK3588_CLUSTER_A76_0] = {
+        .num_cpus = RK3588_A76_CPUS_PER_CLUSTER,
+        .cpu_type = ARM_CPU_TYPE_NAME("cortex-a76"),
+    },
+    [RK3588_CLUSTER_A76_1] = {
+        .num_cpus = RK3588_A76_CPUS_PER_CLUSTER,
+        .cpu_type = ARM_CPU_TYPE_NAME("cortex-a76"),
+    },
+};
+
+G_STATIC_ASSERT(ARRAY_SIZE(rk3588_cpu_clusters) == RK3588_CLUSTER_COUNT);
+
+static void rk3588_soc_realize(DeviceState *dev, Error **errp)
+{
+    RK3588SoCState *s = RK3588_SOC(dev);
+
+    if (!s->memory) {
+        error_setg(errp, "rk3588: memory link is required");
+        return;
+    }
+
+    for (unsigned int c = 0; c < RK3588_CLUSTER_COUNT; c++) {
+        if (!qdev_realize(DEVICE(&s->cluster[c]), NULL, errp)) {
+            return;
+        }
+    }
+
+    for (unsigned int n = 0; n < RK3588_NUM_CPUS; n++) {
+        ARMCPU *cpu = &s->cpu[n];
+        uint64_t mpidr = arm_build_mp_affinity(n, RK3588_MPIDR_AFF0_PER_AFF1);
+
+        CPU(cpu)->cpu_index = n;
+        object_property_set_int(OBJECT(cpu), "mp-affinity", mpidr,
+                                &error_abort);
+        object_property_set_int(OBJECT(cpu), "cntfrq", RK3588_CNTFRQ,
+                                &error_abort);
+        object_property_set_link(OBJECT(cpu), "memory",
+                                 OBJECT(s->memory), &error_abort);
+        if (n > 0) {
+            object_property_set_bool(OBJECT(cpu), "start-powered-off", true,
+                                     &error_abort);
+        }
+
+        if (!qdev_realize(DEVICE(cpu), NULL, errp)) {
+            return;
+        }
+    }
+
+    if (!memory_region_init_ram(&s->sram, OBJECT(s), "rk3588.sram",
+                                MiB, errp)) {
+        return;
+    }
+    memory_region_add_subregion(s->memory, RK3588_SRAM_BASE, &s->sram);
+}
+
+static void rk3588_soc_instance_init(Object *obj)
+{
+    RK3588SoCState *s = RK3588_SOC(obj);
+    unsigned int n = 0;
+
+    for (unsigned int c = 0; c < RK3588_CLUSTER_COUNT; c++) {
+        g_autofree char *cluster_name = g_strdup_printf("cluster%u", c);
+
+        object_initialize_child(obj, cluster_name, &s->cluster[c],
+                                TYPE_CPU_CLUSTER);
+        qdev_prop_set_uint32(DEVICE(&s->cluster[c]), "cluster-id", c);
+
+        for (unsigned int i = 0; i < rk3588_cpu_clusters[c].num_cpus; i++) {
+            g_autofree char *name = g_strdup_printf("cpu%u", n);
+
+            object_initialize_child(OBJECT(&s->cluster[c]), name,
+                                    &s->cpu[n],
+                                    rk3588_cpu_clusters[c].cpu_type);
+            n++;
+        }
+    }
+}
+
+static const Property rk3588_soc_properties[] = {
+    DEFINE_PROP_LINK("memory", RK3588SoCState, memory, TYPE_MEMORY_REGION,
+                     MemoryRegion *),
+};
+
+static const VMStateDescription vmstate_rk3588_soc = {
+    .name = TYPE_RK3588_SOC,
+    .unmigratable = true,
+};
+
+static void rk3588_soc_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = rk3588_soc_realize;
+    dc->desc = "Rockchip RK3588";
+    dc->vmsd = &vmstate_rk3588_soc;
+    dc->user_creatable = false;
+    device_class_set_props(dc, rk3588_soc_properties);
+}
+
+static const TypeInfo rk3588_soc_typeinfo = {
+    .name = TYPE_RK3588_SOC,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(RK3588SoCState),
+    .class_init = rk3588_soc_class_init,
+    .instance_init = rk3588_soc_instance_init,
+};
+
+static void rk3588_soc_register_types(void)
+{
+    type_register_static(&rk3588_soc_typeinfo);
+}
+
+type_init(rk3588_soc_register_types)
diff --git a/include/hw/arm/rk3588.h b/include/hw/arm/rk3588.h
new file mode 100644
index 0000000000..450af3d282
--- /dev/null
+++ b/include/hw/arm/rk3588.h
@@ -0,0 +1,51 @@
+/*
+ * Rockchip RK3588 SoC
+ *
+ * Copyright (C) 2026 Process Mission
+ *
+ * Authors:
+ *    Chao Liu <chao.liu@processmission.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef HW_ARM_RK3588_H
+#define HW_ARM_RK3588_H
+
+#include "qom/object.h"
+#include "target/arm/cpu.h"
+#include "hw/core/qdev.h"
+#include "hw/cpu/cluster.h"
+#include "system/memory.h"
+
+#define TYPE_RK3588_SOC "rockchip.rk3588.soc"
+OBJECT_DECLARE_SIMPLE_TYPE(RK3588SoCState, RK3588_SOC)
+
+#define RK3588_A55_CPUS              (4)
+#define RK3588_A76_CPUS_PER_CLUSTER  (2)
+
+typedef enum RK3588CpuClusterId {
+    RK3588_CLUSTER_A55,
+    RK3588_CLUSTER_A76_0,
+    RK3588_CLUSTER_A76_1,
+    RK3588_CLUSTER_COUNT,
+} RK3588CpuClusterId;
+
+#define RK3588_NUM_CPUS (RK3588_A55_CPUS + \
+    RK3588_A76_CPUS_PER_CLUSTER * (RK3588_CLUSTER_COUNT - 1))
+
+#define RK3588_SRAM_BASE             0xff000000
+
+struct RK3588SoCState {
+    /*< private >*/
+    DeviceState parent_obj;
+
+    /*< public >*/
+    ARMCPU cpu[RK3588_NUM_CPUS];
+    CPUClusterState cluster[RK3588_CLUSTER_COUNT];
+    MemoryRegion *memory;
+    MemoryRegion sram;
+};
+
+#endif /* HW_ARM_RK3588_H */
-- 
2.53.0

