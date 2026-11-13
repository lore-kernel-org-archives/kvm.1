Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.6.4.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563357;
	b=c7HEvVP7DS+8a2Gem9QWZzRNyYbkAe2e5BkzM3Zy/NeNwEfe0njZH13hCMemZ8pGKfsf
	 ayrmMOfOVX0pHUd7t8/j4Dnw65k2lI0H8QjWWlsd97Mswiq1R4t3EYb/wrnVW/8zeVEpd
	 shplRMscK/2yMEp75zcaE3fdlm/Z7jDp1BnWWsIp/zU1Jv+XWcsukUlzyLv9zgOL896dN
	 45Us3N6j/fHZR5WGjhg9MBlohb5hKt99wf0Uj0qFk0MTO6gFkkdXa7mSJTVV7gudKIXR3
	 ex7jDBnjoVVmSIonPk96ktca3g3s2yeQ+ZdgKmrQXUkQrI2ZYvA9Pf4bSRs4qOxIs6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563357;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=2SWNT7v3tEDFZOqDDAN47C5J5oQna6laFegoAVnZBPg=;
	b=vfrTy/iS8ruuWR2MXNQq8NRnh9hlxYTVucfJTYrmMuhbkFLE3W7+xAjos3q2FaKUoWBq
	 ywBNh7Drsu0Br8/W3ibxH8K2iBoEFUdnCMNvqk1bTp1eN7a0l+N78NrtD0YzpLqKoNOVm
	 36Rqaz9hkYIn4Bb6eBfi+s3VEEXG6NwR+Tl5sg7GDNNQxTL93lIK24zb02EUFgxET4Psm
	 UDcfHNxqUZFwnwnA/D4IN8YQBm0dBrcHQJ/2wsbgjt85/8U2yhXEN6wml84OjcXRzpl6l
	 gbRlcoarUS9iC/vt2RANmkbVdHCJYYLTH3RaJhYGhTkgnSM5aLaw3plJNxn3sKZwR1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mails.tsinghua.edu.cn;
	spf=pass smtp.mailfrom=mails.tsinghua.edu.cn;
	dkim=pass header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=mF4qN7YV;
	arc=none smtp.remote-ip=101.6.4.70
Received: from tsinghua.edu.cn (smtp46.tsinghua.edu.cn [101.6.4.70])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C830606A335
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 09:49:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C830606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=mF4qN7YV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=2SWNT7v3tEDFZOqDDAN47C5J5oQna6laFe
	goAVnZBPg=; b=mF4qN7YVywICM28lQ+AvQlSL0BPEEYs1/3m0bn7byAH7k/3kh/
	wj/kVRKjc+ImHJzp4J6qkfLg7ppnp2cl+CvB/FjjrNkbtl5t/7dkgWYvqTinEEA7
	TSw0IrkLuGoI7CzPT3Yx+dZ+qlddRRVqmvK33MTWFAfrYqcWVn5fAMwi8=
Received: from ubuntu (unknown [101.5.154.165])
	by web1 (Coremail) with SMTP id yAQGZQA3qzvR3PZqgA5CAg--.9318S12;
	Fri, 13 Nov 2026 17:48:53 +0800 (CST)
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
Subject: [RFC PATCH 10/20] hw/arm/rk3588: add the UARTs
Date: Fri, 13 Nov 2026 17:47:44 +0800
Message-ID: <05644155c3c21bcd3e95fff245ca52de8bfe1c50.1794555589.git.w-yf22@mails.tsinghua.edu.cn>
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
X-CM-TRANSID:yAQGZQA3qzvR3PZqgA5CAg--.9318S12
X-Coremail-Antispam: 1UD129KBjvJXoWxtFy7ur15tFyfZFy5tr4ktFb_yoWxGw47pr
	1DCrZ8GrWkGa13A3ySyr43KF43Jan2k34j9a4fKryDJayYqr1ktr12vFWjyFWxWrW7tr45
	JrZFqr4Yqa1UWaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Instantiate DW8250 UARTs for UART1 through UART9. They start at
0xfeb40000 with a 64 KiB stride, use GIC SPIs 332 through 340 and run
from a 24 MHz reference clock. UART0 in the PMU power domain remains an
unimplemented device.

Expose each UART's chardev property on the SoC so that boards can
connect their serial ports.

Signed-off-by: Chao Liu <chao.liu@processmission.com>
Signed-off-by: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
---
 hw/arm/Kconfig          |  1 +
 hw/arm/rk3588.c         | 69 +++++++++++++++++++++++++++++++++++------
 include/hw/arm/rk3588.h |  5 +++
 3 files changed, 66 insertions(+), 9 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 73e1154040..b22d0ce4f6 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -779,4 +779,5 @@ config RK3588
     bool
     select ARM_GIC
     select CPU_CLUSTER
+    select DW8250
     select UNIMP
diff --git a/hw/arm/rk3588.c b/hw/arm/rk3588.c
index 3682cf275b..3dbd579806 100644
--- a/hw/arm/rk3588.c
+++ b/hw/arm/rk3588.c
@@ -32,15 +32,39 @@
 
 #define RK3588_GIC_NUM_IRQS          512
 
+/* UART1-UART9 are modeled; UART0 in the PMU power domain is unimplemented. */
+#define RK3588_FIRST_UART            (1)
+#define RK3588_UART1_SPI             332
+#define RK3588_UART_CLOCK            24000000
+#define RK3588_UART_BAUD_BASE        (RK3588_UART_CLOCK / 16)
+
 enum {
     RK3588_DEV_GIC_DIST,
     RK3588_DEV_GIC_REDIST,
+    RK3588_DEV_UART1,
+    RK3588_DEV_UART2,
+    RK3588_DEV_UART3,
+    RK3588_DEV_UART4,
+    RK3588_DEV_UART5,
+    RK3588_DEV_UART6,
+    RK3588_DEV_UART7,
+    RK3588_DEV_UART8,
+    RK3588_DEV_UART9,
 };
 
 /* Memory map of the modeled peripherals. */
 static const MemMapEntry rk3588_memmap[] = {
     [RK3588_DEV_GIC_DIST]   = { 0xfe600000, 0x00010000 },
     [RK3588_DEV_GIC_REDIST] = { 0xfe680000, 0x00100000 },
+    [RK3588_DEV_UART1]      = { 0xfeb40000, 0x00010000 },
+    [RK3588_DEV_UART2]      = { 0xfeb50000, 0x00010000 },
+    [RK3588_DEV_UART3]      = { 0xfeb60000, 0x00010000 },
+    [RK3588_DEV_UART4]      = { 0xfeb70000, 0x00010000 },
+    [RK3588_DEV_UART5]      = { 0xfeb80000, 0x00010000 },
+    [RK3588_DEV_UART6]      = { 0xfeb90000, 0x00010000 },
+    [RK3588_DEV_UART7]      = { 0xfeba0000, 0x00010000 },
+    [RK3588_DEV_UART8]      = { 0xfebb0000, 0x00010000 },
+    [RK3588_DEV_UART9]      = { 0xfebc0000, 0x00010000 },
 };
 
 #define RK3588_UNIMPLEMENTED(name, base, size) \
@@ -85,15 +109,6 @@ static const UnimplementedDeviceConfig rk3588_unimpl_devices[] = {
     RK3588_UNIMPLEMENTED("timer-ns0", 0xfeae0000, 32 * KiB),
     RK3588_UNIMPLEMENTED("wdt-ns", 0xfeaf0000, 64 * KiB),
     RK3588_UNIMPLEMENTED("spi2", 0xfeb20000, 64 * KiB),
-    RK3588_UNIMPLEMENTED("uart1", 0xfeb40000, 64 * KiB),
-    RK3588_UNIMPLEMENTED("uart2", 0xfeb50000, 64 * KiB),
-    RK3588_UNIMPLEMENTED("uart3", 0xfeb60000, 64 * KiB),
-    RK3588_UNIMPLEMENTED("uart4", 0xfeb70000, 64 * KiB),
-    RK3588_UNIMPLEMENTED("uart5", 0xfeb80000, 64 * KiB),
-    RK3588_UNIMPLEMENTED("uart6", 0xfeb90000, 64 * KiB),
-    RK3588_UNIMPLEMENTED("uart7", 0xfeba0000, 64 * KiB),
-    RK3588_UNIMPLEMENTED("uart8", 0xfebb0000, 64 * KiB),
-    RK3588_UNIMPLEMENTED("uart9", 0xfebc0000, 64 * KiB),
     RK3588_UNIMPLEMENTED("gpio1", 0xfec20000, 64 * KiB),
     RK3588_UNIMPLEMENTED("gpio2", 0xfec30000, 64 * KiB),
     RK3588_UNIMPLEMENTED("gpio3", 0xfec40000, 64 * KiB),
@@ -191,6 +206,28 @@ static bool rk3588_soc_create_gic(RK3588SoCState *s, Error **errp)
     return true;
 }
 
+static bool rk3588_soc_create_uart(RK3588SoCState *s, Error **errp)
+{
+    for (unsigned int i = RK3588_FIRST_UART; i < RK3588_NUM_UARTS; i++) {
+        SysBusDevice *uart = SYS_BUS_DEVICE(&s->uart[i]);
+        unsigned int n = i - RK3588_FIRST_UART;
+
+        qdev_prop_set_uint32(DEVICE(uart), "baudbase", RK3588_UART_BAUD_BASE);
+        if (!sysbus_realize(uart, errp)) {
+            return false;
+        }
+
+        memory_region_add_subregion(s->memory,
+            rk3588_memmap[RK3588_DEV_UART1 + n].base,
+            sysbus_mmio_get_region(uart, 0));
+        sysbus_connect_irq(uart, 0,
+                           qdev_get_gpio_in(DEVICE(&s->gic),
+                                            RK3588_UART1_SPI + n));
+    }
+
+    return true;
+}
+
 static bool rk3588_soc_create_hptimer(RK3588SoCState *s, Error **errp)
 {
     SysBusDevice *hptimer = SYS_BUS_DEVICE(s->hptimer);
@@ -245,6 +282,11 @@ static void rk3588_soc_realize(DeviceState *dev, Error **errp)
         !rk3588_soc_create_hptimer(s, errp)) {
         return;
     }
+
+    if (!rk3588_soc_create_uart(s, errp)) {
+        return;
+    }
+
     create_unimplemented_devices(OBJECT(s), s->memory, rk3588_unimpl_devices);
 
     if (!memory_region_init_ram(&s->sram, OBJECT(s), "rk3588.sram",
@@ -278,6 +320,15 @@ static void rk3588_soc_instance_init(Object *obj)
 
     object_initialize_child(obj, "gic", &s->gic, TYPE_ARM_GICV3);
 
+    for (unsigned int i = RK3588_FIRST_UART; i < RK3588_NUM_UARTS; i++) {
+        g_autofree char *name = g_strdup_printf("uart%u", i);
+        g_autofree char *alias = g_strdup_printf("uart%u-chardev", i);
+
+        object_initialize_child(obj, name, &s->uart[i], TYPE_DW8250);
+        object_property_add_alias(obj, alias, OBJECT(&s->uart[i]),
+                                  "chardev");
+    }
+
     s->hptimer = qdev_new(TYPE_ROCKCHIP_HPTIMER);
     object_property_add_child(obj, "hptimer", OBJECT(s->hptimer));
     object_unref(OBJECT(s->hptimer));
diff --git a/include/hw/arm/rk3588.h b/include/hw/arm/rk3588.h
index fcb9ef5964..61fa616795 100644
--- a/include/hw/arm/rk3588.h
+++ b/include/hw/arm/rk3588.h
@@ -15,6 +15,7 @@
 
 #include "qom/object.h"
 #include "target/arm/cpu.h"
+#include "hw/char/dw8250.h"
 #include "hw/core/qdev.h"
 #include "hw/cpu/cluster.h"
 #include "hw/intc/arm_gicv3.h"
@@ -36,6 +37,9 @@ typedef enum RK3588CpuClusterId {
 #define RK3588_NUM_CPUS (RK3588_A55_CPUS + \
     RK3588_A76_CPUS_PER_CLUSTER * (RK3588_CLUSTER_COUNT - 1))
 
+/* UART1-UART9 are modeled; UART0 in the PMU power domain is unimplemented. */
+#define RK3588_NUM_UARTS             (10)
+
 #define RK3588_SRAM_BASE             0xff000000
 #define RK3588_HPTIMER_BASE          0xfd8c8000
 
@@ -47,6 +51,7 @@ struct RK3588SoCState {
     ARMCPU cpu[RK3588_NUM_CPUS];
     CPUClusterState cluster[RK3588_CLUSTER_COUNT];
     GICv3State gic;
+    DW8250State uart[RK3588_NUM_UARTS];
     MemoryRegion *memory;
     MemoryRegion sram;
     DeviceState *hptimer;
-- 
2.53.0

