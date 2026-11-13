Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.6.4.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563369;
	b=p5469W8/4f5iFO8mmZOQLrZlQ1AzqyalIyuzPCwRjPOoJNLeiXybGp6WO4kNxJgzd1wD
	 yic/BSopCFpy0Mq8SH7zssX8/uEaGPQh8Ddj37EPeW/0jFgPrzP8h9UkZGJhXj/QQm/Gm
	 2kZUrR7YeM6BWXwzGzhwJhrlMft7zVwZx52vIFqtCkplLXHDSAN+AXLjXxGbkDWMjR31l
	 4iXCBSgTth+SssPotU7EIH4Pmv6fIctHVdNEu2SR6+7GFZP2UBy5gnTm/NbbhVDMLVEpS
	 9rIRlaQlCl61MsOLc7YCLPGEhitPPUBzHA7L8gvbk9Ks7dlwOGk1NuuqDaZf4ytq06A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563369;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=z0wAaN14MrdTcq4vNRXtU+J3HaGg6LIxXoL1VlhxKq4=;
	b=AwRYLtO3VkyHZmU7oZgijB0MWVCAhITrxMeskyye97wl02ugA+04N0qxC0MmX3LPl88k
	 1NOI1fWXiyo4yEyOPNOa6fMK59+YP75hJyqPNhpifexmTiTpdCumnzfiYaHNRWPo8Nbtf
	 VAenhObyyBnQdOWCjc7cYfkwv8dAmAYSIEtogIATAbr7hdR+LXw8lAMyoTSIxAkO5kUob
	 HjQRTCkSZVsk3Y7KxsxOgi3iPJzQ6isKLOMJQNHirQFcH9BbYKDHlDVWcDQqUqoplvx+P
	 A1GPdaoPDY0X4oUjmAuyZ6nNeMJ6G2HJ8luaCG21hyZ2eQz7Jt6vaa90Jg4gq8sdrVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mails.tsinghua.edu.cn;
	spf=pass smtp.mailfrom=mails.tsinghua.edu.cn;
	dkim=pass header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=jOLiYxfu;
	arc=none smtp.remote-ip=101.6.4.70
Received: from tsinghua.edu.cn (smtp46.tsinghua.edu.cn [101.6.4.70])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9D1606A321
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 09:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F9D1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=jOLiYxfu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=z0wAaN14MrdTcq4vNRXtU+J3HaGg6LIxXo
	L1VlhxKq4=; b=jOLiYxfu1OrcLdkdrgm9GUEGNeARzLp460MevVgWWJjyOoU1F5
	r7+CPb53wTCV8gaZRBQ3ryQG5LZDu7kHo+iO72F5mrcYmgy+Ye9htMmzxLL7eYA2
	gEJ/9uQSwj2hefpFnARBasuXckFGSQ/yL7Yi8/WyTcbNKlw2ubxeW8uuQ=
Received: from ubuntu (unknown [101.5.154.165])
	by web1 (Coremail) with SMTP id yAQGZQA3qzvR3PZqgA5CAg--.9318S14;
	Fri, 13 Nov 2026 17:49:20 +0800 (CST)
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
Subject: [RFC PATCH 12/20] hw/misc: add the RK3588 OTP controller
Date: Fri, 13 Nov 2026 17:47:46 +0800
Message-ID: <8215913c80e82187d194efc1f22e43528e0c4be6.1794555589.git.w-yf22@mails.tsinghua.edu.cn>
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
X-CM-TRANSID:yAQGZQA3qzvR3PZqgA5CAg--.9318S14
X-Coremail-Antispam: 1UD129KBjvJXoWxtFyDAFWDZFykXFykuFyUJrb_yoWfCw15pr
	n5Cry5GrWkGF47ZrZ3tFnxtF45Jan7Ww1jv3yfAFyayFW7tFy5KF4qgayYyFZ7XrW8ur18
	u39Fg3yYqr47Xw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Add a model of the RK3588 OTP automatic read interface that U-Boot uses
for CPU identity and device-tree initialization. The OTP array starts
unprogrammed: a read command fills up to four data registers with zero
words and sets a write-one-to-clear completion status bit. Commands
outside the 1024-word array are rejected as guest errors.

Signed-off-by: Chao Liu <chao.liu@processmission.com>
Signed-off-by: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
---
 MAINTAINERS             |   1 +
 hw/arm/rk3588.c         |  23 ++++++-
 hw/misc/meson.build     |   4 +-
 hw/misc/rockchip_otp.c  | 146 ++++++++++++++++++++++++++++++++++++++++
 include/hw/arm/rk3588.h |   1 +
 5 files changed, 173 insertions(+), 2 deletions(-)
 create mode 100644 hw/misc/rockchip_otp.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2905276c7e..5a4ec869ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1066,6 +1066,7 @@ L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/rk3588.c
 F: hw/misc/rockchip_cru.c
+F: hw/misc/rockchip_otp.c
 F: hw/timer/rockchip-hptimer.c
 F: include/hw/arm/rk3588.h
 F: include/hw/timer/rockchip-hptimer.h
diff --git a/hw/arm/rk3588.c b/hw/arm/rk3588.c
index 6e7cafea1c..acd9149933 100644
--- a/hw/arm/rk3588.c
+++ b/hw/arm/rk3588.c
@@ -42,6 +42,7 @@ enum {
     RK3588_DEV_GIC_DIST,
     RK3588_DEV_GIC_REDIST,
     RK3588_DEV_CRU,
+    RK3588_DEV_OTP,
     RK3588_DEV_UART1,
     RK3588_DEV_UART2,
     RK3588_DEV_UART3,
@@ -58,6 +59,7 @@ static const MemMapEntry rk3588_memmap[] = {
     [RK3588_DEV_GIC_DIST]   = { 0xfe600000, 0x00010000 },
     [RK3588_DEV_GIC_REDIST] = { 0xfe680000, 0x00100000 },
     [RK3588_DEV_CRU]        = { 0xfd7c0000, 0x0005c000 },
+    [RK3588_DEV_OTP]        = { 0xfecc0000, 0x00000400 },
     [RK3588_DEV_UART1]      = { 0xfeb40000, 0x00010000 },
     [RK3588_DEV_UART2]      = { 0xfeb50000, 0x00010000 },
     [RK3588_DEV_UART3]      = { 0xfeb60000, 0x00010000 },
@@ -111,7 +113,6 @@ static const UnimplementedDeviceConfig rk3588_unimpl_devices[] = {
     RK3588_UNIMPLEMENTED("gpio4", 0xfec50000, 64 * KiB),
     RK3588_UNIMPLEMENTED("i2c6", 0xfec80000, 64 * KiB),
     RK3588_UNIMPLEMENTED("i2c7", 0xfec90000, 64 * KiB),
-    RK3588_UNIMPLEMENTED("otp-ns", 0xfecc0000, 64 * KiB),
     RK3588_UNIMPLEMENTED("dmac2", 0xfed10000, 64 * KiB),
     { }
 };
@@ -217,6 +218,21 @@ static bool rk3588_soc_create_cru(RK3588SoCState *s, Error **errp)
     return true;
 }
 
+static bool rk3588_soc_create_otp(RK3588SoCState *s, Error **errp)
+{
+    SysBusDevice *otp = SYS_BUS_DEVICE(s->otp);
+
+    if (!sysbus_realize(otp, errp)) {
+        return false;
+    }
+
+    memory_region_add_subregion(s->memory,
+        rk3588_memmap[RK3588_DEV_OTP].base,
+        sysbus_mmio_get_region(otp, 0));
+
+    return true;
+}
+
 static bool rk3588_soc_create_uart(RK3588SoCState *s, Error **errp)
 {
     for (unsigned int i = RK3588_FIRST_UART; i < RK3588_NUM_UARTS; i++) {
@@ -291,6 +307,7 @@ static void rk3588_soc_realize(DeviceState *dev, Error **errp)
 
     if (!rk3588_soc_create_gic(s, errp) ||
         !rk3588_soc_create_cru(s, errp) ||
+        !rk3588_soc_create_otp(s, errp) ||
         !rk3588_soc_create_uart(s, errp) ||
         !rk3588_soc_create_hptimer(s, errp)) {
         return;
@@ -342,6 +359,10 @@ static void rk3588_soc_instance_init(Object *obj)
     object_property_add_child(obj, "cru", OBJECT(s->cru));
     object_unref(OBJECT(s->cru));
 
+    s->otp = qdev_new("rockchip-otp");
+    object_property_add_child(obj, "otp", OBJECT(s->otp));
+    object_unref(OBJECT(s->otp));
+
     s->hptimer = qdev_new(TYPE_ROCKCHIP_HPTIMER);
     object_property_add_child(obj, "hptimer", OBJECT(s->hptimer));
     object_unref(OBJECT(s->hptimer));
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 374af9331b..51c09b056e 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -183,4 +183,6 @@ system_ss.add(when: 'CONFIG_AXIADO_CLK', if_true: files('axiado_clk.c'))
 # Qualcomm Hexagon DSP subsystems
 system_ss.add(when: 'CONFIG_QCOM_QDSP6SS_CLK', if_true: files('qcom-qdsp6ss-clk.c'))
 
-system_ss.add(when: 'CONFIG_RK3588', if_true: files('rockchip_cru.c'))
+system_ss.add(when: 'CONFIG_RK3588', if_true: files(
+  'rockchip_cru.c',
+  'rockchip_otp.c'))
diff --git a/hw/misc/rockchip_otp.c b/hw/misc/rockchip_otp.c
new file mode 100644
index 0000000000..81e402fdcc
--- /dev/null
+++ b/hw/misc/rockchip_otp.c
@@ -0,0 +1,146 @@
+/*
+ * Rockchip OTP
+ *
+ * Copyright (C) 2026 Process Mission
+ *
+ * Authors:
+ *    Chao Liu <chao.liu@processmission.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * The automatic read interface exposes a bank of unprogrammed OTP words.
+ * Each read command fills the data registers and sets the read-done status;
+ * the status is cleared by a write-one-to-clear acknowledgement.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "qemu/module.h"
+#include "qemu/log.h"
+#include "hw/core/register.h"
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_ROCKCHIP_OTP "rockchip-otp"
+OBJECT_DECLARE_SIMPLE_TYPE(RockchipOTPState, ROCKCHIP_OTP)
+
+/* Size of the OTP window in the RK3588 address map. */
+#define ROCKCHIP_OTP_SIZE 0x400
+/* Highest byte address described by rockchip_otp_regs_info[]. */
+#define ROCKCHIP_OTP_MAX_REG 0x84
+#define ROCKCHIP_OTP_NUM_REGS \
+    ((ROCKCHIP_OTP_MAX_REG / sizeof(uint32_t)) + 1)
+/* Number of 32-bit words in the OTP array. */
+#define ROCKCHIP_OTP_NUM_WORDS 1024
+
+struct RockchipOTPState {
+    SysBusDevice parent_obj;
+
+    RegisterInfo regs_info[ROCKCHIP_OTP_NUM_REGS];
+    uint32_t regs[ROCKCHIP_OTP_NUM_REGS];
+};
+
+REG32(AUTO_CTRL, 0x04)
+REG32(AUTO_EN, 0x08)
+REG32(DOUT0, 0x20)
+REG32(DOUT1, 0x24)
+REG32(DOUT2, 0x28)
+REG32(DOUT3, 0x2c)
+REG32(INT_STATUS, 0x84)
+
+/* INT_STATUS: a read has finished. */
+#define ROCKCHIP_OTP_INT_STATUS_READ_DONE BIT(1)
+
+static void rockchip_otp_auto_read(RegisterInfo *reg, uint64_t value)
+{
+    RockchipOTPState *s = ROCKCHIP_OTP(reg->opaque);
+
+    if (value & 1) {
+        uint32_t control = s->regs[R_AUTO_CTRL];
+        unsigned int address = control >> 16;
+        unsigned int count = (control >> 8) & 0xff;
+
+        s->regs[R_AUTO_EN] = 0;
+        if (count == 0 || count > 4 ||
+            address + count > ROCKCHIP_OTP_NUM_WORDS) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "rockchip-otp: invalid read command\n");
+            return;
+        }
+        /* Unprogrammed fuse words read as zero. */
+        for (unsigned int i = 0; i < count; i++) {
+            s->regs[R_DOUT0 + i] = 0;
+        }
+        s->regs[R_INT_STATUS] |= ROCKCHIP_OTP_INT_STATUS_READ_DONE;
+    }
+}
+
+static const RegisterAccessInfo rockchip_otp_regs_info[] = {
+    { .name = "AUTO_CTRL", .addr = A_AUTO_CTRL },
+    { .name = "AUTO_EN", .addr = A_AUTO_EN,
+      .ro = ~1U, .post_write = rockchip_otp_auto_read },
+    { .name = "DOUT0", .addr = A_DOUT0, .ro = UINT32_MAX },
+    { .name = "DOUT1", .addr = A_DOUT1, .ro = UINT32_MAX },
+    { .name = "DOUT2", .addr = A_DOUT2, .ro = UINT32_MAX },
+    { .name = "DOUT3", .addr = A_DOUT3, .ro = UINT32_MAX },
+    { .name = "INT_STATUS", .addr = A_INT_STATUS,
+      .ro = ~ROCKCHIP_OTP_INT_STATUS_READ_DONE,
+      .w1c = ROCKCHIP_OTP_INT_STATUS_READ_DONE },
+};
+
+static const MemoryRegionOps rockchip_otp_ops = {
+    .read = register_read_memory,
+    .write = register_write_memory,
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
+static void rockchip_otp_reset(DeviceState *dev)
+{
+    RockchipOTPState *s = ROCKCHIP_OTP(dev);
+
+    for (int i = 0; i < ARRAY_SIZE(s->regs_info); i++) {
+        register_reset(&s->regs_info[i]);
+    }
+}
+
+static void rockchip_otp_init(Object *obj)
+{
+    RockchipOTPState *s = ROCKCHIP_OTP(obj);
+    RegisterInfoArray *reg_array;
+
+    reg_array = register_init_block32(
+        DEVICE(obj), rockchip_otp_regs_info, ARRAY_SIZE(rockchip_otp_regs_info),
+        s->regs_info, s->regs, &rockchip_otp_ops, false, ROCKCHIP_OTP_SIZE);
+
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &reg_array->mem);
+}
+
+static void rockchip_otp_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    device_class_set_legacy_reset(dc, rockchip_otp_reset);
+}
+
+static const TypeInfo rockchip_otp_type_info = {
+    .name = TYPE_ROCKCHIP_OTP,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RockchipOTPState),
+    .instance_init = rockchip_otp_init,
+    .class_init = rockchip_otp_class_init,
+};
+
+static void rockchip_otp_register_types(void)
+{
+    type_register_static(&rockchip_otp_type_info);
+}
+
+type_init(rockchip_otp_register_types)
diff --git a/include/hw/arm/rk3588.h b/include/hw/arm/rk3588.h
index 18c66b6bae..1f854043de 100644
--- a/include/hw/arm/rk3588.h
+++ b/include/hw/arm/rk3588.h
@@ -53,6 +53,7 @@ struct RK3588SoCState {
     GICv3State gic;
     DW8250State uart[RK3588_NUM_UARTS];
     DeviceState *cru;
+    DeviceState *otp;
     MemoryRegion *memory;
     MemoryRegion sram;
     DeviceState *hptimer;
-- 
2.53.0

