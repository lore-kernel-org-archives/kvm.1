Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.6.4.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563326;
	b=VzSH2kQCLJaM6Lwu9uxYWgTd4uLrk2b2F3Sx5PGHxSJZjQiq1BJuF168XDry3NRvzqFH
	 3XMO7XVV5RxFEPAquwsNVdJCmnucnCsHbBR+SAOgrgtOfXX4uFRCrJTf081XZ4jq67w74
	 fWJuYd7oL7zFktk6yz+cBhX7nuGFkyJia3FKyk3KHONzLHC6YeIkD25RRO1jCXl5RR/ym
	 nFcjNLZK5R8qFsA41llMJOr6lgvzWBW/JWvujIY9TQajZcSGPEnYxbti6rsQ9UPNZQAPw
	 W+Q8+nX2/5+YHHJEfy2P5p5MwZFhzJwIlCFwdaBsuW1972bqK1UkBw+HMbKQbfGJq5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563326;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=FX2MJCLnUv9GM0RivA6XTdIe0tDKaFmHc/KohwmXJso=;
	b=SLIJtAz3hSCdc2SFMPMSH/O4SmQi+PaScmES5haY8aEBArFrk+IW1OyOEtDT8vpjVGwH
	 0RQPORBLwC2jKWC48UCE3qbgq5+rEZVv0u2LpNQIcL6eocJ4QTTORcqVigxuEEWGNe805
	 KtZAn+kbfBSY2f5erIT/UUzT6TcYTw4NLhwG8SbCjkKCkFTqz7MZR9ViIjwFyiG2NXqkd
	 M6VQGjv9ND23TaGK/ntC5aktPVOEo7QWQrIZ/1zoCPsXp0eFYuOeKfYi3zDE0ocPSXJrr
	 +ujULGFLfSY5E8PPqP46oS96zPUUeWKhmysXkgiJqHYLtyzRhmUxqqVEXyKcjlbg0iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mails.tsinghua.edu.cn;
	spf=pass smtp.mailfrom=mails.tsinghua.edu.cn;
	dkim=pass header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=HHKO4goe;
	arc=none smtp.remote-ip=101.6.4.71
Received: from tsinghua.edu.cn (smtp47.tsinghua.edu.cn [101.6.4.71])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B086606A8B7
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 09:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B086606A8B7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=HHKO4goe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=FX2MJCLnUv9GM0RivA6XTdIe0tDKaFmHc/
	KohwmXJso=; b=HHKO4goe2Kr0rrVbXJQnZCz7SHP5QoTHghY1jfTc5oCYTFgYZT
	FKkxOz9n2f+iti9odHgRtPnVycm9WBBbB59sSgrLjuYl9DcaL3ItRRG8ve/tGgNX
	V65BZppF8btvkWLRCe/eIrZlUiMEjfO2QbsxEFVYlPWFx8tcUizKaw5x4=
Received: from ubuntu (unknown [101.5.154.165])
	by web1 (Coremail) with SMTP id yAQGZQA3qzvR3PZqgA5CAg--.9318S9;
	Fri, 13 Nov 2026 17:48:38 +0800 (CST)
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
Subject: [RFC PATCH 07/20] hw/timer: add Rockchip HPTIMER boot control
Date: Fri, 13 Nov 2026 17:47:41 +0800
Message-ID: <1d01bb375e62f978da2cb0fd4c9d775154f2202e.1794555589.git.w-yf22@mails.tsinghua.edu.cn>
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
X-CM-TRANSID:yAQGZQA3qzvR3PZqgA5CAg--.9318S9
X-Coremail-Antispam: 1UD129KBjvJXoWxtFyxXFWDZFWUGr17Zry7ZFb_yoW3try5p3
	Z5Cry3GrWkGF47X39xXFnxJF4ftw4kJr12yayfXF9ayFy7tw15Ga1vg3yUGFZ7Xry7Zr1f
	C397ta43Gr43Xr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Implement the HPTIMER control register enable bit used during firmware
boot and connect the device to the RK3588 SoC. Reset the enable state in
the device; the board supplies the firmware handoff state.

Signed-off-by: Chao Liu <chao.liu@processmission.com>
Signed-off-by: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
---
 MAINTAINERS                         |   2 +
 hw/arm/rk3588.c                     |  23 ++++++
 hw/timer/meson.build                |   1 +
 hw/timer/rockchip-hptimer.c         | 115 ++++++++++++++++++++++++++++
 include/hw/arm/rk3588.h             |   2 +
 include/hw/timer/rockchip-hptimer.h |  20 +++++
 6 files changed, 163 insertions(+)
 create mode 100644 hw/timer/rockchip-hptimer.c
 create mode 100644 include/hw/timer/rockchip-hptimer.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e7caabd565..4fc6f8e59d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1065,7 +1065,9 @@ M: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/rk3588.c
+F: hw/timer/rockchip-hptimer.c
 F: include/hw/arm/rk3588.h
+F: include/hw/timer/rockchip-hptimer.h
 
 SABRELITE / i.MX6
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/hw/arm/rk3588.c b/hw/arm/rk3588.c
index 1e6f44433c..8255aee7fc 100644
--- a/hw/arm/rk3588.c
+++ b/hw/arm/rk3588.c
@@ -18,6 +18,7 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/core/sysbus.h"
 #include "hw/cpu/cluster.h"
+#include "hw/timer/rockchip-hptimer.h"
 #include "migration/vmstate.h"
 
 /* MPIDR Aff0 values per Aff1: 1 (one CPU per RK3588 cluster). */
@@ -46,6 +47,20 @@ static const struct {
 
 G_STATIC_ASSERT(ARRAY_SIZE(rk3588_cpu_clusters) == RK3588_CLUSTER_COUNT);
 
+static bool rk3588_soc_create_hptimer(RK3588SoCState *s, Error **errp)
+{
+    SysBusDevice *hptimer = SYS_BUS_DEVICE(s->hptimer);
+
+    if (!sysbus_realize(hptimer, errp)) {
+        return false;
+    }
+
+    memory_region_add_subregion(s->memory, RK3588_HPTIMER_BASE,
+                                sysbus_mmio_get_region(hptimer, 0));
+
+    return true;
+}
+
 static void rk3588_soc_realize(DeviceState *dev, Error **errp)
 {
     RK3588SoCState *s = RK3588_SOC(dev);
@@ -82,6 +97,10 @@ static void rk3588_soc_realize(DeviceState *dev, Error **errp)
         }
     }
 
+    if (!rk3588_soc_create_hptimer(s, errp)) {
+        return;
+    }
+
     if (!memory_region_init_ram(&s->sram, OBJECT(s), "rk3588.sram",
                                 MiB, errp)) {
         return;
@@ -110,6 +129,10 @@ static void rk3588_soc_instance_init(Object *obj)
             n++;
         }
     }
+
+    s->hptimer = qdev_new(TYPE_ROCKCHIP_HPTIMER);
+    object_property_add_child(obj, "hptimer", OBJECT(s->hptimer));
+    object_unref(OBJECT(s->hptimer));
 }
 
 static const Property rk3588_soc_properties[] = {
diff --git a/hw/timer/meson.build b/hw/timer/meson.build
index e2bcdbdf65..5375f26b47 100644
--- a/hw/timer/meson.build
+++ b/hw/timer/meson.build
@@ -23,6 +23,7 @@ system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_timer.c'))
 system_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_timer.c'))
 system_ss.add(when: 'CONFIG_PXA2XX_TIMER', if_true: files('pxa2xx_timer.c'))
 system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_systmr.c'))
+system_ss.add(when: 'CONFIG_RK3588', if_true: files('rockchip-hptimer.c'))
 system_ss.add(when: 'CONFIG_SH_TIMER', if_true: files('sh_timer.c'))
 system_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_timer.c'))
 system_ss.add(when: 'CONFIG_SSE_COUNTER', if_true: files('sse-counter.c'))
diff --git a/hw/timer/rockchip-hptimer.c b/hw/timer/rockchip-hptimer.c
new file mode 100644
index 0000000000..200894036c
--- /dev/null
+++ b/hw/timer/rockchip-hptimer.c
@@ -0,0 +1,115 @@
+/*
+ * Rockchip RK3588 HPTIMER boot control register
+ *
+ * Copyright (C) 2026 Process Mission
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/units.h"
+#include "hw/core/resettable.h"
+#include "hw/core/sysbus.h"
+#include "hw/timer/rockchip-hptimer.h"
+#include "migration/vmstate.h"
+
+/* Model the enable state used at firmware handoff; the CPU provides timing. */
+struct RockchipHPTimerState {
+    SysBusDevice parent_obj;
+    MemoryRegion iomem;
+    uint32_t ctrl;
+};
+
+static uint64_t rockchip_hptimer_read(void *opaque, hwaddr offset,
+                                     unsigned size)
+{
+    RockchipHPTimerState *s = ROCKCHIP_HPTIMER(opaque);
+
+    switch (offset) {
+    case ROCKCHIP_HPTIMER_CTRL:
+        return s->ctrl;
+    default:
+        qemu_log_mask(LOG_UNIMP, "rockchip-hptimer: unimplemented read at "
+                      "0x%" HWADDR_PRIx "\n", offset);
+        return 0;
+    }
+}
+
+static void rockchip_hptimer_write(void *opaque, hwaddr offset,
+                                  uint64_t value, unsigned size)
+{
+    RockchipHPTimerState *s = ROCKCHIP_HPTIMER(opaque);
+
+    switch (offset) {
+    case ROCKCHIP_HPTIMER_CTRL:
+        s->ctrl = value & ROCKCHIP_HPTIMER_ENABLE;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "rockchip-hptimer: unimplemented write at "
+                      "0x%" HWADDR_PRIx "\n", offset);
+        break;
+    }
+}
+
+static const MemoryRegionOps rockchip_hptimer_ops = {
+    .read = rockchip_hptimer_read,
+    .write = rockchip_hptimer_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void rockchip_hptimer_reset_enter(Object *obj, ResetType type)
+{
+    RockchipHPTimerState *s = ROCKCHIP_HPTIMER(obj);
+
+    s->ctrl = 0;
+}
+
+static void rockchip_hptimer_init(Object *obj)
+{
+    RockchipHPTimerState *s = ROCKCHIP_HPTIMER(obj);
+
+    memory_region_init_io(&s->iomem, obj, &rockchip_hptimer_ops, s,
+                          TYPE_ROCKCHIP_HPTIMER, 16 * KiB);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static const VMStateDescription vmstate_rockchip_hptimer = {
+    .name = TYPE_ROCKCHIP_HPTIMER,
+    .unmigratable = true,
+};
+
+static void rockchip_hptimer_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
+
+    rc->phases.enter = rockchip_hptimer_reset_enter;
+    dc->desc = "Rockchip RK3588 HPTIMER boot control";
+    dc->vmsd = &vmstate_rockchip_hptimer;
+    dc->user_creatable = false;
+}
+
+static const TypeInfo rockchip_hptimer_typeinfo = {
+    .name = TYPE_ROCKCHIP_HPTIMER,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RockchipHPTimerState),
+    .instance_init = rockchip_hptimer_init,
+    .class_init = rockchip_hptimer_class_init,
+};
+
+static void rockchip_hptimer_register_types(void)
+{
+    type_register_static(&rockchip_hptimer_typeinfo);
+}
+
+type_init(rockchip_hptimer_register_types)
diff --git a/include/hw/arm/rk3588.h b/include/hw/arm/rk3588.h
index 450af3d282..8539d2e64d 100644
--- a/include/hw/arm/rk3588.h
+++ b/include/hw/arm/rk3588.h
@@ -36,6 +36,7 @@ typedef enum RK3588CpuClusterId {
     RK3588_A76_CPUS_PER_CLUSTER * (RK3588_CLUSTER_COUNT - 1))
 
 #define RK3588_SRAM_BASE             0xff000000
+#define RK3588_HPTIMER_BASE          0xfd8c8000
 
 struct RK3588SoCState {
     /*< private >*/
@@ -46,6 +47,7 @@ struct RK3588SoCState {
     CPUClusterState cluster[RK3588_CLUSTER_COUNT];
     MemoryRegion *memory;
     MemoryRegion sram;
+    DeviceState *hptimer;
 };
 
 #endif /* HW_ARM_RK3588_H */
diff --git a/include/hw/timer/rockchip-hptimer.h b/include/hw/timer/rockchip-hptimer.h
new file mode 100644
index 0000000000..2e9f5fd819
--- /dev/null
+++ b/include/hw/timer/rockchip-hptimer.h
@@ -0,0 +1,20 @@
+/*
+ * Rockchip RK3588 HPTIMER
+ *
+ * Copyright (C) 2026 Process Mission
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_TIMER_ROCKCHIP_HPTIMER_H
+#define HW_TIMER_ROCKCHIP_HPTIMER_H
+
+#include "qom/object.h"
+
+#define TYPE_ROCKCHIP_HPTIMER "rockchip-hptimer"
+OBJECT_DECLARE_SIMPLE_TYPE(RockchipHPTimerState, ROCKCHIP_HPTIMER)
+
+#define ROCKCHIP_HPTIMER_CTRL   0x04
+#define ROCKCHIP_HPTIMER_ENABLE (1U << 0)
+
+#endif /* HW_TIMER_ROCKCHIP_HPTIMER_H */
-- 
2.53.0

