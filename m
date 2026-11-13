Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.6.4.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563372;
	b=FICibHdixMMBhJvASMtfwy7Wbjn9v7HQp5+A7EdCHxr1EQSUnpx7Opiq/UaTDEnjVoCz
	 dOcfJK1CCBdHSa9SCf3KJIvtNkvQnbWgNOgKD6zwgGl9+4+oCiLx3/lf8r6ZBaNGp3y5Z
	 ZwDwm4AV19K6kmBovrXIz37J7ZejF+aw/V1ICaQPj2HqWHZ1DJ/d5rnON7bveNShy5m12
	 TmWgt4oif/z67UwiT4+mzRvC8McNbZ7lGf685Mtfm1TzxFC18rior8OdgATGMJjLq6c5x
	 SeawpMWtxY+GtjQtl4IplkuDDcQodiZbqh6lh/oSYTrpKNfdHsiQmrD7l9CLTrVyQtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563372;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=0slYynxcqkcuOoir1dAuL9+HYncu4X2CDrICwebLZnw=;
	b=w2UPMKCemJgoFc07WGVd498M/S9kA7xKLzitAmn3No/rZUx3MAZsyKaZWGXSEJlbxbgt
	 /2gIK3a4MmfvtpV7fIGrHrCclKqo+Zllw8XRnFuxkg94S+N9kVx5atqEZIjNKN1MjMC/S
	 qmnmGvGXdKgIrkLWbZHmkAsoQfcRZt6MBzkbfj6BNrIjZnWVtd6fh8rqTe4YOZkIr8AWA
	 Z3kSVMI6kWewNDE7f7QcbPwSjJj6iCacdQS4htFNt/aJtvnJQKfTXYfKi0LQe5lA/WuC/
	 cA//iZ82iqCWLw2ugwms9LojEKnx225oayG4dUzqhwZXmxJJqBiWRagDYEHDq/tV9pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mails.tsinghua.edu.cn;
	spf=pass smtp.mailfrom=mails.tsinghua.edu.cn;
	dkim=pass header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=TaG96q4B;
	arc=none smtp.remote-ip=101.6.4.71
Received: from tsinghua.edu.cn (smtp47.tsinghua.edu.cn [101.6.4.71])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37869606A321
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 09:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37869606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=TaG96q4B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=0slYynxcqkcuOoir1dAuL9+HYncu4X2CDr
	ICwebLZnw=; b=TaG96q4BemqPy11REescMHoRe9X1ZWTXrtxx3pvUdPg2dk1UR7
	zkHzarSaJO0FnzfUTvnoFj78vwCk79LfCD0t950TtCrTpNT/vZh5ZiHo5+1QApQc
	ZSxyqdZIXcGBqRNBfWGVsGAtSa5UhU9XEcNVLFrHWogCYC+kOZxihadv0=
Received: from ubuntu (unknown [101.5.154.165])
	by web1 (Coremail) with SMTP id yAQGZQA3qzvR3PZqgA5CAg--.9318S15;
	Fri, 13 Nov 2026 17:49:22 +0800 (CST)
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
Subject: [RFC PATCH 13/20] hw/ssi: add the Rockchip SPI flash controller
Date: Fri, 13 Nov 2026 17:47:47 +0800
Message-ID: <160fbdb55551ee295ca8acd80a53876210756475.1794555589.git.w-yf22@mails.tsinghua.edu.cn>
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
X-CM-TRANSID:yAQGZQA3qzvR3PZqgA5CAg--.9318S15
X-Coremail-Antispam: 1UD129KBjvAXoW3ZrWftr13trWkKF1fCw43trb_yoW8ArW3Xo
	WqgF45Xry8Kw4xAry0v3yI9r4xWwnrKr4kCa18uF4jva18ArnrXan8C3yY9a1rAr15tF9x
	JF4vy393Ja4kZryxn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOZ7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
	Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
	84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJV
	WxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE
	3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2
	IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I64
	8v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK
	6r4fMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUjCJmU
	UUUUU==
X-CM-SenderInfo: fzn1wj2s6ptxtovo32xlqjx3vdohv3gofq/

From: Chao Liu <chao.liu@processmission.com>

Add a model of the Rockchip SPI flash controller. The ROCK 5B boots
U-Boot proper from the SPI NOR through this controller, so it is needed
for firmware booting.

The model implements command, address and dummy phases, PIO and DMA
data transfers, completion and error interrupts, interrupt masking and
clearing, and controller reset.

Signed-off-by: Chao Liu <chao.liu@processmission.com>
Signed-off-by: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
---
 MAINTAINERS             |   1 +
 hw/arm/Kconfig          |   1 +
 hw/arm/rk3588.c         |  29 ++-
 hw/ssi/Kconfig          |   5 +
 hw/ssi/meson.build      |   1 +
 hw/ssi/rockchip_sfc.c   | 439 ++++++++++++++++++++++++++++++++++++++++
 include/hw/arm/rk3588.h |   1 +
 7 files changed, 475 insertions(+), 2 deletions(-)
 create mode 100644 hw/ssi/rockchip_sfc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5a4ec869ea..7fd434ade2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1067,6 +1067,7 @@ S: Maintained
 F: hw/arm/rk3588.c
 F: hw/misc/rockchip_cru.c
 F: hw/misc/rockchip_otp.c
+F: hw/ssi/rockchip_sfc.c
 F: hw/timer/rockchip-hptimer.c
 F: include/hw/arm/rk3588.h
 F: include/hw/timer/rockchip-hptimer.h
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 902c4ba377..eaa55eae29 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -781,4 +781,5 @@ config RK3588
     select CPU_CLUSTER
     select DW8250
     select REGISTER
+    select ROCKCHIP_SFC
     select UNIMP
diff --git a/hw/arm/rk3588.c b/hw/arm/rk3588.c
index acd9149933..2319c54c76 100644
--- a/hw/arm/rk3588.c
+++ b/hw/arm/rk3588.c
@@ -29,7 +29,7 @@
 #define RK3588_MPIDR_AFF0_PER_AFF1   (1)
 
 #define RK3588_CNTFRQ                24000000
-
+#define RK3588_SFC_SPI               206
 #define RK3588_GIC_NUM_IRQS          512
 
 /* UART1-UART9 are modeled; UART0 in the PMU power domain is unimplemented. */
@@ -43,6 +43,7 @@ enum {
     RK3588_DEV_GIC_REDIST,
     RK3588_DEV_CRU,
     RK3588_DEV_OTP,
+    RK3588_DEV_SFC,
     RK3588_DEV_UART1,
     RK3588_DEV_UART2,
     RK3588_DEV_UART3,
@@ -60,6 +61,7 @@ static const MemMapEntry rk3588_memmap[] = {
     [RK3588_DEV_GIC_REDIST] = { 0xfe680000, 0x00100000 },
     [RK3588_DEV_CRU]        = { 0xfd7c0000, 0x0005c000 },
     [RK3588_DEV_OTP]        = { 0xfecc0000, 0x00000400 },
+    [RK3588_DEV_SFC]        = { 0xfe2b0000, 0x00004000 },
     [RK3588_DEV_UART1]      = { 0xfeb40000, 0x00010000 },
     [RK3588_DEV_UART2]      = { 0xfeb50000, 0x00010000 },
     [RK3588_DEV_UART3]      = { 0xfeb60000, 0x00010000 },
@@ -96,7 +98,6 @@ static const UnimplementedDeviceConfig rk3588_unimpl_devices[] = {
     RK3588_UNIMPLEMENTED("i2c0", 0xfd880000, 64 * KiB),
     RK3588_UNIMPLEMENTED("gpio0", 0xfd8a0000, 64 * KiB),
     RK3588_UNIMPLEMENTED("pwm0", 0xfd8b0000, 64 * KiB),
-    RK3588_UNIMPLEMENTED("fspi", 0xfe2b0000, 64 * KiB),
     RK3588_UNIMPLEMENTED("sdmmc", 0xfe2c0000, 64 * KiB),
     RK3588_UNIMPLEMENTED("sdio", 0xfe2d0000, 64 * KiB),
     RK3588_UNIMPLEMENTED("emmc", 0xfe2e0000, 64 * KiB),
@@ -233,6 +234,25 @@ static bool rk3588_soc_create_otp(RK3588SoCState *s, Error **errp)
     return true;
 }
 
+static bool rk3588_soc_create_sfc(RK3588SoCState *s, Error **errp)
+{
+    SysBusDevice *sfc = SYS_BUS_DEVICE(s->sfc);
+
+    object_property_set_link(OBJECT(s->sfc), "dma-memory",
+                             OBJECT(s->memory), &error_abort);
+    if (!sysbus_realize(sfc, errp)) {
+        return false;
+    }
+
+    memory_region_add_subregion(s->memory,
+        rk3588_memmap[RK3588_DEV_SFC].base,
+        sysbus_mmio_get_region(sfc, 0));
+    sysbus_connect_irq(sfc, 0,
+                       qdev_get_gpio_in(DEVICE(&s->gic), RK3588_SFC_SPI));
+
+    return true;
+}
+
 static bool rk3588_soc_create_uart(RK3588SoCState *s, Error **errp)
 {
     for (unsigned int i = RK3588_FIRST_UART; i < RK3588_NUM_UARTS; i++) {
@@ -308,6 +328,7 @@ static void rk3588_soc_realize(DeviceState *dev, Error **errp)
     if (!rk3588_soc_create_gic(s, errp) ||
         !rk3588_soc_create_cru(s, errp) ||
         !rk3588_soc_create_otp(s, errp) ||
+        !rk3588_soc_create_sfc(s, errp) ||
         !rk3588_soc_create_uart(s, errp) ||
         !rk3588_soc_create_hptimer(s, errp)) {
         return;
@@ -363,6 +384,10 @@ static void rk3588_soc_instance_init(Object *obj)
     object_property_add_child(obj, "otp", OBJECT(s->otp));
     object_unref(OBJECT(s->otp));
 
+    s->sfc = qdev_new("rockchip-sfc");
+    object_property_add_child(obj, "sfc", OBJECT(s->sfc));
+    object_unref(OBJECT(s->sfc));
+
     s->hptimer = qdev_new(TYPE_ROCKCHIP_HPTIMER);
     object_property_add_child(obj, "hptimer", OBJECT(s->hptimer));
     object_unref(OBJECT(s->hptimer));
diff --git a/hw/ssi/Kconfig b/hw/ssi/Kconfig
index d477d20e9b..5735b422c9 100644
--- a/hw/ssi/Kconfig
+++ b/hw/ssi/Kconfig
@@ -36,3 +36,8 @@ config ALLWINNER_A10_SPI
 config IMX_SPI
     bool
     select SSI
+
+config ROCKCHIP_SFC
+    bool
+    select REGISTER
+    select SSI
diff --git a/hw/ssi/meson.build b/hw/ssi/meson.build
index f334e48e2f..701ae09ed2 100644
--- a/hw/ssi/meson.build
+++ b/hw/ssi/meson.build
@@ -13,3 +13,4 @@ system_ss.add(when: 'CONFIG_IMX_SPI', if_true: files('imx_spi.c'))
 system_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_spi_host.c'))
 system_ss.add(when: 'CONFIG_BCM2835_SPI', if_true: files('bcm2835_spi.c'))
 system_ss.add(when: 'CONFIG_PNV_SPI', if_true: files('pnv_spi.c'))
+system_ss.add(when: 'CONFIG_ROCKCHIP_SFC', if_true: files('rockchip_sfc.c'))
diff --git a/hw/ssi/rockchip_sfc.c b/hw/ssi/rockchip_sfc.c
new file mode 100644
index 0000000000..7960655e83
--- /dev/null
+++ b/hw/ssi/rockchip_sfc.c
@@ -0,0 +1,439 @@
+/*
+ * Rockchip Serial Flash Controller
+ *
+ * Copyright (c) 2026 Process Mission
+ *
+ * Authors:
+ *    Chao Liu <chao.liu@processmission.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "qemu/module.h"
+#include "qemu/units.h"
+#include "qapi/error.h"
+#include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/register.h"
+#include "hw/core/sysbus.h"
+#include "hw/ssi/ssi.h"
+#include "qom/object.h"
+
+#define TYPE_ROCKCHIP_SFC "rockchip-sfc"
+OBJECT_DECLARE_SIMPLE_TYPE(RockchipSFCState, ROCKCHIP_SFC)
+
+#define ROCKCHIP_SFC_MMIO_SIZE 0x4000
+#define ROCKCHIP_SFC_NUM_CS 2
+#define ROCKCHIP_SFC_NUM_REGS (0x10c / sizeof(uint32_t))
+
+struct RockchipSFCState {
+    SysBusDevice parent_obj;
+
+    RegisterInfo regs_info[ROCKCHIP_SFC_NUM_REGS];
+    uint32_t regs[ROCKCHIP_SFC_NUM_REGS];
+    MemoryRegion *dma_memory;
+    AddressSpace dma_as;
+    SSIBus *spi;
+    qemu_irq irq;
+    qemu_irq cs_lines[ROCKCHIP_SFC_NUM_CS];
+
+    uint32_t remaining;
+    uint8_t address_bytes;
+    uint8_t dummy_bytes;
+    uint8_t cs;
+    bool write;
+    bool pending;
+    bool started;
+    bool resetting;
+};
+
+REG32(CTRL, 0x000)
+REG32(IMR, 0x004)
+REG32(ICLR, 0x008)
+REG32(FTLR, 0x00c)
+REG32(RCVR, 0x010)
+REG32(AX, 0x014)
+REG32(ABIT, 0x018)
+REG32(ISR, 0x01c)
+REG32(FSR, 0x020)
+REG32(SR, 0x024)
+REG32(RISR, 0x028)
+REG32(VER, 0x02c)
+REG32(DLL_CTRL0, 0x03c)
+REG32(DMA_TRIGGER, 0x080)
+REG32(DMA_ADDR, 0x084)
+REG32(LEN_CTRL, 0x088)
+REG32(LEN_EXT, 0x08c)
+REG32(CMD, 0x100)
+REG32(ADDR, 0x104)
+REG32(DATA, 0x108)
+
+#define SFC_INT_FINISH   BIT(4)
+#define SFC_INT_BUS_ERR  BIT(5)
+#define SFC_INT_NSPI_ERR BIT(6)
+#define SFC_INT_DMA      BIT(7)
+#define SFC_MAX_LENGTH  (32 * MiB)
+#define SFC_LEN_CTRL_TRB_SEL BIT(0)
+
+static void rockchip_sfc_update_irq(RockchipSFCState *s)
+{
+    qemu_set_irq(s->irq, (s->regs[R_RISR] & ~s->regs[R_IMR]) != 0);
+}
+
+static void rockchip_sfc_end(RockchipSFCState *s)
+{
+    if (s->started) {
+        qemu_irq_raise(s->cs_lines[s->cs]);
+    }
+    s->pending = false;
+    s->started = false;
+    s->remaining = 0;
+}
+
+static void rockchip_sfc_complete(RockchipSFCState *s, uint32_t status)
+{
+    rockchip_sfc_end(s);
+    s->regs[R_RISR] |= status;
+    rockchip_sfc_update_irq(s);
+}
+
+static void rockchip_sfc_begin(RockchipSFCState *s)
+{
+    if (!s->pending || s->started) {
+        return;
+    }
+
+    qemu_irq_lower(s->cs_lines[s->cs]);
+    s->started = true;
+    ssi_transfer(s->spi, s->regs[R_CMD] & 0xff);
+    for (int i = s->address_bytes - 1; i >= 0; i--) {
+        ssi_transfer(s->spi, (s->regs[R_ADDR] >> (8 * i)) & 0xff);
+    }
+    for (unsigned int i = 0; i < s->dummy_bytes; i++) {
+        ssi_transfer(s->spi, 0);
+    }
+    if (!s->remaining) {
+        rockchip_sfc_complete(s, SFC_INT_FINISH);
+    }
+}
+
+static void rockchip_sfc_command(RockchipSFCState *s, uint32_t value)
+{
+    unsigned int address_mode = (value >> 14) & 3;
+    unsigned int dummy_cycles = (value >> 8) & 0xf;
+    unsigned int address_width = 1 << ((s->regs[R_CTRL] >> 10) & 3);
+    uint32_t len;
+
+    if (s->regs[R_LEN_CTRL] & SFC_LEN_CTRL_TRB_SEL) {
+        len = s->regs[R_LEN_EXT];
+    } else {
+        /* Normal mode: transfer bytes are in CMD[29:16]. */
+        len = (value >> 16) & 0x3fff;
+    }
+
+    rockchip_sfc_end(s);
+    s->cs = value >> 30;
+    if (s->cs >= ROCKCHIP_SFC_NUM_CS || len > SFC_MAX_LENGTH) {
+        rockchip_sfc_complete(s, SFC_INT_NSPI_ERR);
+        return;
+    }
+
+    switch (address_mode) {
+    case 1:
+        s->address_bytes = 3;
+        break;
+    case 2:
+        s->address_bytes = 4;
+        break;
+    case 3:
+        if ((s->regs[R_ABIT] & 7) != 7) {
+            rockchip_sfc_complete(s, SFC_INT_NSPI_ERR);
+            return;
+        }
+        s->address_bytes = ((s->regs[R_ABIT] & 31) + 1) / 8;
+        break;
+    default:
+        s->address_bytes = 0;
+        break;
+    }
+    s->dummy_bytes = DIV_ROUND_UP(dummy_cycles * address_width, 8);
+    s->write = (value >> 12) & 1;
+    s->remaining = len;
+    s->pending = true;
+    if (!s->address_bytes) {
+        rockchip_sfc_begin(s);
+    }
+}
+
+static uint32_t rockchip_sfc_read_data(RockchipSFCState *s)
+{
+    uint32_t value = 0;
+    unsigned int count;
+
+    if (!s->started || s->write) {
+        return 0;
+    }
+    count = MIN(4, s->remaining);
+    for (unsigned int i = 0; i < count; i++) {
+        value |= (uint32_t)ssi_transfer(s->spi, 0) << (i * 8);
+    }
+    s->remaining -= count;
+    if (!s->remaining) {
+        rockchip_sfc_complete(s, SFC_INT_FINISH);
+    }
+    return value;
+}
+
+static void rockchip_sfc_write_data(RockchipSFCState *s, uint32_t value)
+{
+    unsigned int count;
+
+    if (!s->started || !s->write) {
+        return;
+    }
+    count = MIN(4, s->remaining);
+    for (unsigned int i = 0; i < count; i++) {
+        ssi_transfer(s->spi, (value >> (i * 8)) & 0xff);
+    }
+    s->remaining -= count;
+    if (!s->remaining) {
+        rockchip_sfc_complete(s, SFC_INT_FINISH);
+    }
+}
+
+static void rockchip_sfc_dma(RockchipSFCState *s)
+{
+    uint8_t buffer[256];
+    hwaddr addr = s->regs[R_DMA_ADDR];
+    MemTxAttrs attrs = { .memory = true };
+
+    if (!s->started) {
+        rockchip_sfc_complete(s, SFC_INT_BUS_ERR);
+        return;
+    }
+
+    while (s->remaining) {
+        unsigned int count = MIN(sizeof(buffer), s->remaining);
+        MemTxResult result;
+
+        if (s->write) {
+            result = address_space_read(&s->dma_as, addr, attrs,
+                                        buffer, count);
+            if (result == MEMTX_OK) {
+                for (unsigned int i = 0; i < count; i++) {
+                    ssi_transfer(s->spi, buffer[i]);
+                }
+            }
+        } else {
+            for (unsigned int i = 0; i < count; i++) {
+                buffer[i] = ssi_transfer(s->spi, 0);
+            }
+            result = address_space_write(&s->dma_as, addr, attrs,
+                                         buffer, count);
+        }
+        if (result != MEMTX_OK) {
+            rockchip_sfc_complete(s, SFC_INT_BUS_ERR);
+            return;
+        }
+        s->remaining -= count;
+        addr += count;
+    }
+    rockchip_sfc_complete(s, SFC_INT_DMA | SFC_INT_FINISH);
+}
+
+static void rockchip_sfc_reset(DeviceState *dev)
+{
+    RockchipSFCState *s = ROCKCHIP_SFC(dev);
+
+    rockchip_sfc_end(s);
+    for (unsigned int i = 0; i < ROCKCHIP_SFC_NUM_CS; i++) {
+        qemu_irq_raise(s->cs_lines[i]);
+    }
+    s->resetting = true;
+    for (unsigned int i = 0; i < ARRAY_SIZE(s->regs_info); i++) {
+        register_reset(&s->regs_info[i]);
+    }
+    s->resetting = false;
+    s->cs = 0;
+    s->address_bytes = 0;
+    s->dummy_bytes = 0;
+    s->write = false;
+    rockchip_sfc_update_irq(s);
+}
+
+static uint64_t rockchip_sfc_status_read(RegisterInfo *reg, uint64_t value)
+{
+    RockchipSFCState *s = ROCKCHIP_SFC(reg->opaque);
+
+    switch (reg->access->addr) {
+    case A_ISR:
+        return s->regs[R_RISR] & ~s->regs[R_IMR];
+    case A_FSR:
+        if (s->started && !s->write && s->remaining) {
+            return (31 << 8) | BIT(1) |
+                   (MIN(DIV_ROUND_UP(s->remaining, 4), 31) << 16);
+        }
+        return (31 << 8) | BIT(1) | BIT(2);
+    case A_SR:
+        return s->pending ? 1 : 0;
+    case A_DATA:
+        return rockchip_sfc_read_data(s);
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void rockchip_sfc_register_write(RegisterInfo *reg, uint64_t value)
+{
+    RockchipSFCState *s = ROCKCHIP_SFC(reg->opaque);
+
+    if (s->resetting) {
+        return;
+    }
+
+    switch (reg->access->addr) {
+    case A_IMR:
+        rockchip_sfc_update_irq(s);
+        break;
+    case A_ICLR:
+        s->regs[R_RISR] &= ~value;
+        s->regs[R_ICLR] = 0;
+        rockchip_sfc_update_irq(s);
+        break;
+    case A_RCVR:
+        if (value & 1) {
+            rockchip_sfc_end(s);
+            s->regs[R_RISR] = 0;
+            rockchip_sfc_update_irq(s);
+        }
+        s->regs[R_RCVR] = 0;
+        break;
+    case A_DMA_TRIGGER:
+        if (value & 1) {
+            rockchip_sfc_dma(s);
+        }
+        s->regs[R_DMA_TRIGGER] = 0;
+        break;
+    case A_CMD:
+        rockchip_sfc_command(s, value);
+        break;
+    case A_ADDR:
+        rockchip_sfc_begin(s);
+        break;
+    case A_DATA:
+        rockchip_sfc_write_data(s, value);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static const RegisterAccessInfo rockchip_sfc_regs[] = {
+    { .name = "CTRL", .addr = A_CTRL },
+    { .name = "IMR", .addr = A_IMR, .reset = UINT32_MAX,
+      .post_write = rockchip_sfc_register_write },
+    { .name = "ICLR", .addr = A_ICLR,
+      .post_write = rockchip_sfc_register_write },
+    { .name = "FTLR", .addr = A_FTLR },
+    { .name = "RCVR", .addr = A_RCVR,
+      .post_write = rockchip_sfc_register_write },
+    { .name = "AX", .addr = A_AX },
+    { .name = "ABIT", .addr = A_ABIT },
+    { .name = "ISR", .addr = A_ISR, .ro = UINT32_MAX,
+      .post_read = rockchip_sfc_status_read },
+    { .name = "FSR", .addr = A_FSR, .ro = UINT32_MAX,
+      .post_read = rockchip_sfc_status_read },
+    { .name = "SR", .addr = A_SR, .ro = UINT32_MAX,
+      .post_read = rockchip_sfc_status_read },
+    { .name = "RISR", .addr = A_RISR, .ro = UINT32_MAX },
+    { .name = "VER", .addr = A_VER, .ro = UINT32_MAX, .reset = 4 },
+    { .name = "DLL_CTRL0", .addr = A_DLL_CTRL0 },
+    { .name = "DMA_TRIGGER", .addr = A_DMA_TRIGGER,
+      .post_write = rockchip_sfc_register_write },
+    { .name = "DMA_ADDR", .addr = A_DMA_ADDR },
+    { .name = "LEN_CTRL", .addr = A_LEN_CTRL },
+    { .name = "LEN_EXT", .addr = A_LEN_EXT },
+    { .name = "CMD", .addr = A_CMD,
+      .post_write = rockchip_sfc_register_write },
+    { .name = "ADDR", .addr = A_ADDR,
+      .post_write = rockchip_sfc_register_write },
+    { .name = "DATA", .addr = A_DATA,
+      .post_read = rockchip_sfc_status_read,
+      .post_write = rockchip_sfc_register_write },
+};
+
+static const MemoryRegionOps rockchip_sfc_ops = {
+    .read = register_read_memory,
+    .write = register_write_memory,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+};
+
+static void rockchip_sfc_realize(DeviceState *dev, Error **errp)
+{
+    RockchipSFCState *s = ROCKCHIP_SFC(dev);
+
+    if (!s->dma_memory) {
+        error_setg(errp, "rockchip-sfc: dma-memory link is required");
+        return;
+    }
+    address_space_init(&s->dma_as, s->dma_memory, TYPE_ROCKCHIP_SFC);
+}
+
+static void rockchip_sfc_unrealize(DeviceState *dev)
+{
+    RockchipSFCState *s = ROCKCHIP_SFC(dev);
+
+    address_space_destroy(&s->dma_as);
+}
+
+static void rockchip_sfc_init(Object *obj)
+{
+    RockchipSFCState *s = ROCKCHIP_SFC(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    RegisterInfoArray *reg_array;
+
+    s->spi = ssi_create_bus(DEVICE(obj), "spi");
+    qdev_init_gpio_out_named(DEVICE(obj), s->cs_lines, "cs",
+                             ROCKCHIP_SFC_NUM_CS);
+    sysbus_init_irq(sbd, &s->irq);
+    reg_array = register_init_block32(DEVICE(obj), rockchip_sfc_regs,
+                                     ARRAY_SIZE(rockchip_sfc_regs),
+                                     s->regs_info, s->regs, &rockchip_sfc_ops,
+                                     false, ROCKCHIP_SFC_MMIO_SIZE);
+    sysbus_init_mmio(sbd, &reg_array->mem);
+}
+
+static const Property rockchip_sfc_properties[] = {
+    DEFINE_PROP_LINK("dma-memory", RockchipSFCState, dma_memory,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
+};
+
+static void rockchip_sfc_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = rockchip_sfc_realize;
+    dc->unrealize = rockchip_sfc_unrealize;
+    device_class_set_props(dc, rockchip_sfc_properties);
+    device_class_set_legacy_reset(dc, rockchip_sfc_reset);
+}
+
+static const TypeInfo rockchip_sfc_info = {
+    .name = TYPE_ROCKCHIP_SFC,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RockchipSFCState),
+    .instance_init = rockchip_sfc_init,
+    .class_init = rockchip_sfc_class_init,
+};
+
+static void rockchip_sfc_register_types(void)
+{
+    type_register_static(&rockchip_sfc_info);
+}
+
+type_init(rockchip_sfc_register_types)
diff --git a/include/hw/arm/rk3588.h b/include/hw/arm/rk3588.h
index 1f854043de..1304c11598 100644
--- a/include/hw/arm/rk3588.h
+++ b/include/hw/arm/rk3588.h
@@ -54,6 +54,7 @@ struct RK3588SoCState {
     DW8250State uart[RK3588_NUM_UARTS];
     DeviceState *cru;
     DeviceState *otp;
+    DeviceState *sfc;
     MemoryRegion *memory;
     MemoryRegion sram;
     DeviceState *hptimer;
-- 
2.53.0

