Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.6.4.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563365;
	b=3dinatHhw5yC1EK3chuSnaaL1bP0ngCyDfN4yVBkDUvbzaEn48IgAqfQ9WvzypmU2u8R
	 sF1B7uFTwpCVV9VMLTXYuRAZo44RiTvFYv2XCbBQmvkd1vLflzZ9i+QsWa3YF3iwZnLFs
	 SSDUEEsytyAS5CEfUAhjAXfyDNzE0QiPmZbext1W0x5X3dLDHcbTMUKZvvqzmUG/OACri
	 dLlpX3zA44rXTeuTO89N2hTovpzvpge/VhOuyOAh9j8beNxbASTCwfNvrCiiyk6Lc9Q4j
	 N/n6tyFffR+DzLql3DCcvOdrvmrU+rB3KE8yUPEnYREqdwRJ+hY205YjOF63Ung6w6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563365;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=jvOOtSYHLoj+Aq2TJqlTxzDOyBjwyoP7joetNoPs07k=;
	b=CNXaqzu9l3Hq78GVbV0q1g8Q+HxGrpWA8rQieRFC8Ne4tu/ISto310b6GKCcmjUJYnuf
	 dx5yTmTOCqervVdaBlPLPVWKbjAUka2ihQ0DrdALeiewAKDfV5z+B0+7xbKUr8c5KAPBc
	 tf4SffpG/P4V2/OG7GWah4TPodx4R2EkcSxMRsxJVhDKTZYPhBUmn2W5eh9ufdkNZOiOp
	 5mFxVITwjsBYCNUqB1DSEMlQfl8k9MFeidstD4E5nLUXn6cQW3WZD4YW3VAdBoTKGHtTI
	 ukUR1xTlFmCdSUPF/pWt5TUtgjv02JSNtnbj0fiaIGL3LOH64YMvG9IuGzdGN8SORHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mails.tsinghua.edu.cn;
	spf=pass smtp.mailfrom=mails.tsinghua.edu.cn;
	dkim=pass header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=hIsZ387D;
	arc=none smtp.remote-ip=101.6.4.71
Received: from tsinghua.edu.cn (smtp47.tsinghua.edu.cn [101.6.4.71])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E7D606A321
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 09:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0E7D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=hIsZ387D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=jvOOtSYHLoj+Aq2TJqlTxzDOyBjwyoP7jo
	etNoPs07k=; b=hIsZ387DxFsSUwVQGzephQfkeRlvHZPOfW6VuPWjcS3m7o2Hpx
	JCr/aRVwT1kD9vOO0JfjtTeAOc+Vl0iB+tCE5KMdbGo6CgRldZLcq3YsOnvnuCAA
	P4Fi9BVUxC8eCZVCSs37CYfzpYPBePSSmujkSe5Imh/6vghGnn8PLe+2g=
Received: from ubuntu (unknown [101.5.154.165])
	by web1 (Coremail) with SMTP id yAQGZQA3qzvR3PZqgA5CAg--.9318S13;
	Fri, 13 Nov 2026 17:49:09 +0800 (CST)
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
Subject: [RFC PATCH 11/20] hw/misc: add the RK3588 clock and reset unit
Date: Fri, 13 Nov 2026 17:47:45 +0800
Message-ID: <cd79c5daed1c9aa3007cfafa0e6d7ee75a2d8784.1794555589.git.w-yf22@mails.tsinghua.edu.cn>
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
X-CM-TRANSID:yAQGZQA3qzvR3PZqgA5CAg--.9318S13
X-Coremail-Antispam: 1UD129KBjvAXoW3tw1DuF1DWFWDuF4xJF47Jwb_yoW8JFykZo
	Z2gF43Ww4rKr4fZryF9w1UZF1xCr4vyr1kWFnrCF13Ca43Aw45G34kA3yvq3WSyryUAF4k
	Xa9Yyw1fXay8A3y8n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
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

Add a model of the RK3588 CRU registers that U-Boot programs before it
configures the SPI flash controller clock. The model stores the PLL
parameters and clock selections. CON0/CON1 and clock selections use
Rockchip high-word write masks; fractional PLL CON2 stores a 16-bit K
value. Report PLL lock when powered up with valid M, P and S values.
Other CRU registers read as zero and log as unimplemented.

Signed-off-by: Chao Liu <chao.liu@processmission.com>
Signed-off-by: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
---
 MAINTAINERS             |   1 +
 hw/arm/Kconfig          |   1 +
 hw/arm/rk3588.c         |  33 ++++--
 hw/misc/meson.build     |   2 +
 hw/misc/rockchip_cru.c  | 233 ++++++++++++++++++++++++++++++++++++++++
 include/hw/arm/rk3588.h |   1 +
 6 files changed, 261 insertions(+), 10 deletions(-)
 create mode 100644 hw/misc/rockchip_cru.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4fc6f8e59d..2905276c7e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1065,6 +1065,7 @@ M: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/rk3588.c
+F: hw/misc/rockchip_cru.c
 F: hw/timer/rockchip-hptimer.c
 F: include/hw/arm/rk3588.h
 F: include/hw/timer/rockchip-hptimer.h
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index b22d0ce4f6..902c4ba377 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -780,4 +780,5 @@ config RK3588
     select ARM_GIC
     select CPU_CLUSTER
     select DW8250
+    select REGISTER
     select UNIMP
diff --git a/hw/arm/rk3588.c b/hw/arm/rk3588.c
index 3dbd579806..6e7cafea1c 100644
--- a/hw/arm/rk3588.c
+++ b/hw/arm/rk3588.c
@@ -41,6 +41,7 @@
 enum {
     RK3588_DEV_GIC_DIST,
     RK3588_DEV_GIC_REDIST,
+    RK3588_DEV_CRU,
     RK3588_DEV_UART1,
     RK3588_DEV_UART2,
     RK3588_DEV_UART3,
@@ -56,6 +57,7 @@ enum {
 static const MemMapEntry rk3588_memmap[] = {
     [RK3588_DEV_GIC_DIST]   = { 0xfe600000, 0x00010000 },
     [RK3588_DEV_GIC_REDIST] = { 0xfe680000, 0x00100000 },
+    [RK3588_DEV_CRU]        = { 0xfd7c0000, 0x0005c000 },
     [RK3588_DEV_UART1]      = { 0xfeb40000, 0x00010000 },
     [RK3588_DEV_UART2]      = { 0xfeb50000, 0x00010000 },
     [RK3588_DEV_UART3]      = { 0xfeb60000, 0x00010000 },
@@ -89,12 +91,6 @@ static const UnimplementedDeviceConfig rk3588_unimpl_devices[] = {
     RK3588_UNIMPLEMENTED("vccio2-ioc", 0xfd5fb000, 4 * KiB),
     RK3588_UNIMPLEMENTED("vccio6-ioc", 0xfd5fc000, 4 * KiB),
     RK3588_UNIMPLEMENTED("emmc-ioc", 0xfd5fd000, 4 * KiB),
-    RK3588_UNIMPLEMENTED("cru-ns", 0xfd7c0000, 32 * KiB),
-    RK3588_UNIMPLEMENTED("php-ppll-cru", 0xfd7c8000, 32 * KiB),
-    RK3588_UNIMPLEMENTED("pmu1-cru", 0xfd7f0000, 64 * KiB),
-    RK3588_UNIMPLEMENTED("bigcore0-cru", 0xfd810000, 8 * KiB),
-    RK3588_UNIMPLEMENTED("bigcore1-cru", 0xfd812000, 8 * KiB),
-    RK3588_UNIMPLEMENTED("dsu-cru", 0xfd818000, 16 * KiB),
     RK3588_UNIMPLEMENTED("i2c0", 0xfd880000, 64 * KiB),
     RK3588_UNIMPLEMENTED("gpio0", 0xfd8a0000, 64 * KiB),
     RK3588_UNIMPLEMENTED("pwm0", 0xfd8b0000, 64 * KiB),
@@ -206,6 +202,21 @@ static bool rk3588_soc_create_gic(RK3588SoCState *s, Error **errp)
     return true;
 }
 
+static bool rk3588_soc_create_cru(RK3588SoCState *s, Error **errp)
+{
+    SysBusDevice *cru = SYS_BUS_DEVICE(s->cru);
+
+    if (!sysbus_realize(cru, errp)) {
+        return false;
+    }
+
+    memory_region_add_subregion(s->memory,
+        rk3588_memmap[RK3588_DEV_CRU].base,
+        sysbus_mmio_get_region(cru, 0));
+
+    return true;
+}
+
 static bool rk3588_soc_create_uart(RK3588SoCState *s, Error **errp)
 {
     for (unsigned int i = RK3588_FIRST_UART; i < RK3588_NUM_UARTS; i++) {
@@ -279,14 +290,12 @@ static void rk3588_soc_realize(DeviceState *dev, Error **errp)
     }
 
     if (!rk3588_soc_create_gic(s, errp) ||
+        !rk3588_soc_create_cru(s, errp) ||
+        !rk3588_soc_create_uart(s, errp) ||
         !rk3588_soc_create_hptimer(s, errp)) {
         return;
     }
 
-    if (!rk3588_soc_create_uart(s, errp)) {
-        return;
-    }
-
     create_unimplemented_devices(OBJECT(s), s->memory, rk3588_unimpl_devices);
 
     if (!memory_region_init_ram(&s->sram, OBJECT(s), "rk3588.sram",
@@ -329,6 +338,10 @@ static void rk3588_soc_instance_init(Object *obj)
                                   "chardev");
     }
 
+    s->cru = qdev_new("rockchip-cru");
+    object_property_add_child(obj, "cru", OBJECT(s->cru));
+    object_unref(OBJECT(s->cru));
+
     s->hptimer = qdev_new(TYPE_ROCKCHIP_HPTIMER);
     object_property_add_child(obj, "hptimer", OBJECT(s->hptimer));
     object_unref(OBJECT(s->hptimer));
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 7a071af82b..374af9331b 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -182,3 +182,5 @@ system_ss.add(when: 'CONFIG_AXIADO_CLK', if_true: files('axiado_clk.c'))
 
 # Qualcomm Hexagon DSP subsystems
 system_ss.add(when: 'CONFIG_QCOM_QDSP6SS_CLK', if_true: files('qcom-qdsp6ss-clk.c'))
+
+system_ss.add(when: 'CONFIG_RK3588', if_true: files('rockchip_cru.c'))
diff --git a/hw/misc/rockchip_cru.c b/hw/misc/rockchip_cru.c
new file mode 100644
index 0000000000..cd2115a514
--- /dev/null
+++ b/hw/misc/rockchip_cru.c
@@ -0,0 +1,233 @@
+/*
+ * Rockchip RK3588 clock registers
+ *
+ * Copyright (C) 2026 Process Mission
+ *
+ * Authors:
+ *    Chao Liu <chao.liu@processmission.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/core/register.h"
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_ROCKCHIP_CRU "rockchip-cru"
+OBJECT_DECLARE_SIMPLE_TYPE(RockchipCRUState, ROCKCHIP_CRU)
+
+#define ROCKCHIP_CRU_SIZE 0x5c000
+#define ROCKCHIP_CRU_NUM_PLL_REGS (5 * 3 + 5 * 4)
+#define ROCKCHIP_CRU_NUM_REGS (ROCKCHIP_CRU_NUM_PLL_REGS + 11)
+
+struct RockchipCRUState {
+    SysBusDevice parent_obj;
+    MemoryRegion iomem;
+    RegisterInfo regs_info[ROCKCHIP_CRU_NUM_REGS];
+    uint32_t regs[ROCKCHIP_CRU_NUM_REGS];
+};
+
+#define PLL_POWER_DOWN BIT(13)
+#define PLL_LOCKED BIT(15)
+
+static uint64_t rockchip_cru_masked_write(RegisterInfo *reg, uint64_t value)
+{
+    uint32_t old = *(uint32_t *)reg->data;
+    uint16_t mask = value >> 16;
+
+    return (old & ~mask) | (value & mask);
+}
+
+static RegisterInfo *rockchip_cru_register(RockchipCRUState *s, hwaddr offset)
+{
+    for (unsigned int i = 0; i < ARRAY_SIZE(s->regs_info); i++) {
+        if (s->regs_info[i].access->addr == offset) {
+            return &s->regs_info[i];
+        }
+    }
+    return NULL;
+}
+
+static uint64_t rockchip_cru_pll_lock(RegisterInfo *reg, uint64_t value)
+{
+    RockchipCRUState *s = ROCKCHIP_CRU(reg->opaque);
+    hwaddr base = reg->access->addr - 0x18;
+    uint32_t con0 = *(uint32_t *)rockchip_cru_register(s, base)->data;
+    uint32_t con1 = *(uint32_t *)rockchip_cru_register(s, base + 4)->data;
+    bool powered = !(con1 & PLL_POWER_DOWN);
+    bool configured = (con0 & 0x3ff) >= 64 &&
+                      (con1 & 0x3f) &&
+                      extract32(con1, 6, 3) <= 6;
+
+    /* PLL settling is synchronous after configuration and power-up. */
+    return powered && configured ? PLL_LOCKED : 0;
+}
+
+#define CRU_PLL_CON0(label, base) \
+    { .name = label "_CON0", .addr = base, \
+      .pre_write = rockchip_cru_masked_write }
+
+#define CRU_PLL_CON1(label, base) \
+    { .name = label "_CON1", .addr = base + 4, \
+      .pre_write = rockchip_cru_masked_write }
+
+#define CRU_PLL_CON2(label, base) \
+    { .name = label "_CON2", .addr = base + 8, .ro = 0xffff0000 }
+
+#define CRU_PLL_CON6(label, base) \
+    { .name = label "_CON6", .addr = base + 0x18, .ro = UINT32_MAX, \
+      .post_read = rockchip_cru_pll_lock }
+
+#define CRU_CLOCK(label, offset) \
+    { .name = label, .addr = offset, .pre_write = rockchip_cru_masked_write }
+
+static const RegisterAccessInfo rockchip_cru_pll_regs[] = {
+    CRU_PLL_CON0("B0PLL", 0x50000),
+    CRU_PLL_CON1("B0PLL", 0x50000),
+    CRU_PLL_CON6("B0PLL", 0x50000),
+    CRU_PLL_CON0("B1PLL", 0x52020),
+    CRU_PLL_CON1("B1PLL", 0x52020),
+    CRU_PLL_CON6("B1PLL", 0x52020),
+    CRU_PLL_CON0("LPLL", 0x58040),
+    CRU_PLL_CON1("LPLL", 0x58040),
+    CRU_PLL_CON6("LPLL", 0x58040),
+    CRU_PLL_CON0("V0PLL", 0x00160),
+    CRU_PLL_CON1("V0PLL", 0x00160),
+    CRU_PLL_CON2("V0PLL", 0x00160),
+    CRU_PLL_CON6("V0PLL", 0x00160),
+    CRU_PLL_CON0("AUPLL", 0x00180),
+    CRU_PLL_CON1("AUPLL", 0x00180),
+    CRU_PLL_CON2("AUPLL", 0x00180),
+    CRU_PLL_CON6("AUPLL", 0x00180),
+    CRU_PLL_CON0("CPLL", 0x001a0),
+    CRU_PLL_CON1("CPLL", 0x001a0),
+    CRU_PLL_CON2("CPLL", 0x001a0),
+    CRU_PLL_CON6("CPLL", 0x001a0),
+    CRU_PLL_CON0("GPLL", 0x001c0),
+    CRU_PLL_CON1("GPLL", 0x001c0),
+    CRU_PLL_CON2("GPLL", 0x001c0),
+    CRU_PLL_CON6("GPLL", 0x001c0),
+    CRU_PLL_CON0("NPLL", 0x001e0),
+    CRU_PLL_CON1("NPLL", 0x001e0),
+    CRU_PLL_CON6("NPLL", 0x001e0),
+    CRU_PLL_CON0("PPLL", 0x08200),
+    CRU_PLL_CON1("PPLL", 0x08200),
+    CRU_PLL_CON2("PPLL", 0x08200),
+    CRU_PLL_CON6("PPLL", 0x08200),
+    CRU_PLL_CON0("SPLL", 0x18220),
+    CRU_PLL_CON1("SPLL", 0x18220),
+    CRU_PLL_CON6("SPLL", 0x18220),
+};
+
+static const RegisterAccessInfo rockchip_cru_clock_regs[] = {
+    CRU_CLOCK("MODE_CON0", 0x00280),
+    CRU_CLOCK("SBUS_MODE_CON0", 0x18280),
+    CRU_CLOCK("CLKSEL_CON8", 0x00320),
+    CRU_CLOCK("CLKSEL_CON9", 0x00324),
+    CRU_CLOCK("CLKSEL_CON38", 0x00398),
+    CRU_CLOCK("CLKSEL_CON78", 0x00438),
+    CRU_CLOCK("CLKSEL_CON165", 0x00594),
+    CRU_CLOCK("CLKGATE_CON19", 0x0084c),
+    CRU_CLOCK("BIGCORE0_MODE_CON0", 0x50280),
+    CRU_CLOCK("BIGCORE1_MODE_CON0", 0x52280),
+    CRU_CLOCK("DSU_MODE_CON0", 0x58280),
+};
+
+G_STATIC_ASSERT(ARRAY_SIZE(rockchip_cru_pll_regs) +
+                ARRAY_SIZE(rockchip_cru_clock_regs) == ROCKCHIP_CRU_NUM_REGS);
+
+static uint64_t rockchip_cru_read(void *opaque, hwaddr offset, unsigned size)
+{
+    RockchipCRUState *s = opaque;
+    RegisterInfo *reg = rockchip_cru_register(s, offset);
+
+    if (reg) {
+        return register_read(reg, UINT32_MAX, TYPE_ROCKCHIP_CRU, false);
+    }
+    qemu_log_mask(LOG_UNIMP, "rockchip-cru: unimplemented read at 0x%"
+                  HWADDR_PRIx "\n", offset);
+    return 0;
+}
+
+static void rockchip_cru_write(void *opaque, hwaddr offset, uint64_t value,
+                               unsigned size)
+{
+    RockchipCRUState *s = opaque;
+    RegisterInfo *reg = rockchip_cru_register(s, offset);
+
+    if (reg) {
+        register_write(reg, value, UINT32_MAX, TYPE_ROCKCHIP_CRU, false);
+        return;
+    }
+    qemu_log_mask(LOG_UNIMP, "rockchip-cru: unimplemented write at 0x%"
+                  HWADDR_PRIx " = 0x%" PRIx64 "\n", offset, value);
+}
+
+static const MemoryRegionOps rockchip_cru_ops = {
+    .read = rockchip_cru_read,
+    .write = rockchip_cru_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+};
+
+static void rockchip_cru_reset(DeviceState *dev)
+{
+    RockchipCRUState *s = ROCKCHIP_CRU(dev);
+
+    for (unsigned int i = 0; i < ARRAY_SIZE(s->regs_info); i++) {
+        register_reset(&s->regs_info[i]);
+    }
+}
+
+static void rockchip_cru_init(Object *obj)
+{
+    RockchipCRUState *s = ROCKCHIP_CRU(obj);
+
+    /* Keep sparse CRU addresses in a compact RegisterInfo array. */
+    for (unsigned int i = 0; i < ARRAY_SIZE(s->regs_info); i++) {
+        const RegisterAccessInfo *access;
+        unsigned int pll_regs = ARRAY_SIZE(rockchip_cru_pll_regs);
+
+        if (i < pll_regs) {
+            access = &rockchip_cru_pll_regs[i];
+        } else {
+            access = &rockchip_cru_clock_regs[i - pll_regs];
+        }
+        s->regs_info[i] = (RegisterInfo) {
+            .data = &s->regs[i],
+            .data_size = sizeof(s->regs[i]),
+            .access = access,
+            .opaque = s,
+        };
+    }
+    memory_region_init_io(&s->iomem, obj, &rockchip_cru_ops, s,
+                          TYPE_ROCKCHIP_CRU, ROCKCHIP_CRU_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static void rockchip_cru_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    device_class_set_legacy_reset(dc, rockchip_cru_reset);
+}
+
+static const TypeInfo rockchip_cru_type_info = {
+    .name = TYPE_ROCKCHIP_CRU,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RockchipCRUState),
+    .instance_init = rockchip_cru_init,
+    .class_init = rockchip_cru_class_init,
+};
+
+static void rockchip_cru_register_types(void)
+{
+    type_register_static(&rockchip_cru_type_info);
+}
+
+type_init(rockchip_cru_register_types)
diff --git a/include/hw/arm/rk3588.h b/include/hw/arm/rk3588.h
index 61fa616795..18c66b6bae 100644
--- a/include/hw/arm/rk3588.h
+++ b/include/hw/arm/rk3588.h
@@ -52,6 +52,7 @@ struct RK3588SoCState {
     CPUClusterState cluster[RK3588_CLUSTER_COUNT];
     GICv3State gic;
     DW8250State uart[RK3588_NUM_UARTS];
+    DeviceState *cru;
     MemoryRegion *memory;
     MemoryRegion sram;
     DeviceState *hptimer;
-- 
2.53.0

