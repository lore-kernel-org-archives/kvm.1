Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.6.4.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563385;
	b=maEjAhtT2PmiMYCPkmClCMRBLyOl4ptoYpG9Pj3UbPRBUeZcpPtBKDt7HWXlxaKGDBrG
	 uvobtC3sbi3MfQ09WH0Infm2Qt33RKBWeCOZjU1jjhcIIX1RLdYsyIQrCvxVIOqb3dXoh
	 C/CoQg6dAC7MWzwyFpVO4gdhGP9derJ1OtVhilAenFmsJOUWXziVuoT2KASF5ZASFWhlf
	 DTZH4JemA8LaUFVr6pjUcl3xJD4DJzB0rHFRp0Z/PyIlIkuPW3FqhbprXO6ocF8+B4k0i
	 gFP68kS/m12CnnV6U2Pw/BVdjrXyS2cLbAuRgUEN9eYcmAsf43lmMHkyT8CleNltztA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563385;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=K2iFNuflE9lh3ECoYs1e06mchhIrRlnlB7/abMWYdVk=;
	b=oDJMZE9HwAprXr/tTqdRodYpRFTv+OvQw66/uzzLFTppHeJN7P114BZjvtCbvKsxL3a1
	 yv8t25Alhc7TRqf1kTBUpRMb3+QvjVAt9yEeCSoLuPmX4oZy2841ANZ+9J58sbp1XmfMG
	 fqNSGax4Qe3AawsI5cYvLEE/Cc7psdkPVivSnULsha6EWP6LYCpzZGjeD37cCr8IAPRta
	 C1hviPYi3be5swBIyjsXtuSI6W61eQmaX+1I1gQQP/NaVMqknvGsL3uiIsvMUE0vox+aN
	 dnj/Pjm+yljv/NjltDPstLgbrPEZdut1j8jjRuSmJm0ymGSlHCJEDbdo9G/DK/pIM0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mails.tsinghua.edu.cn;
	spf=pass smtp.mailfrom=mails.tsinghua.edu.cn;
	dkim=pass header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=oiyd5pM4;
	arc=none smtp.remote-ip=101.6.4.71
Received: from tsinghua.edu.cn (smtp47.tsinghua.edu.cn [101.6.4.71])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF1D606A88D
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 09:49:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AF1D606A88D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=oiyd5pM4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=K2iFNuflE9lh3ECoYs1e06mchhIrRlnlB7
	/abMWYdVk=; b=oiyd5pM48fsYH10SMt857RroqrQjbDOQPE6MLs/RYGdfHHkzYN
	fnU3Qw6ObPDkpRwwZk2BY5w/xeQ9LE/mukJPz/bf7vLWQdVonb0ctDWf19QIc2Gv
	RrxvUXSokJKOZKyXZQY0R89QA+a4ArFrY1HOMQv+v2YLiLX51ZqSv5Bw8=
Received: from ubuntu (unknown [101.5.154.165])
	by web1 (Coremail) with SMTP id yAQGZQA3qzvR3PZqgA5CAg--.9318S20;
	Fri, 13 Nov 2026 17:49:37 +0800 (CST)
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
Subject: [RFC PATCH 18/20] hw/arm/rock-5b: add firmware booting
Date: Fri, 13 Nov 2026 17:47:52 +0800
Message-ID: <a06832670c1efef012ec5a8f02cfa0d06faf15f8.1794555589.git.w-yf22@mails.tsinghua.edu.cn>
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
X-CM-TRANSID:yAQGZQA3qzvR3PZqgA5CAg--.9318S20
X-Coremail-Antispam: 1UD129KBjvJXoW3JryUJrWftw18XF1rur4fGrg_yoW7CF1DpF
	1DArs0krWfGFyagrW3AF42gw13Xw4vvay5Wr93G3sYyF17tr9rWr48K3s5uay7Wr4vvw45
	Gr9xJrnYvFs8XrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUeVbkUU
	UUU
X-CM-SenderInfo: fzn1wj2s6ptxtovo32xlqjx3vdohv3gofq/

From: Chao Liu <chao.liu@processmission.com>

Load a raw U-Boot SPL image supplied with -bios at address zero and
start it in non-secure EL2. SPL loads U-Boot proper from SPI NOR, and
QEMU provides PSCI and SCMI services through SMC calls.

Restore the SPI boot-source value in SRAM and the HPTIMER enable state
on reset before entering SPL.

Signed-off-by: Chao Liu <chao.liu@processmission.com>
Signed-off-by: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
---
 hw/arm/rock-5b.c | 98 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 83 insertions(+), 15 deletions(-)

diff --git a/hw/arm/rock-5b.c b/hw/arm/rock-5b.c
index abc898c50c..c097e17c5c 100644
--- a/hw/arm/rock-5b.c
+++ b/hw/arm/rock-5b.c
@@ -10,6 +10,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/datadir.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qemu/units.h"
@@ -17,15 +18,18 @@
 #include "hw/arm/boot.h"
 #include "hw/arm/rk3588.h"
 #include "hw/core/boards.h"
+#include "hw/core/loader.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-properties-system.h"
 #include "hw/ssi/ssi.h"
+#include "hw/timer/rockchip-hptimer.h"
 #include "system/address-spaces.h"
 #include "system/block-backend.h"
 #include "system/blockdev.h"
 #include "system/device_tree.h"
 #include "system/kvm.h"
 #include "system/qtest.h"
+#include "system/reset.h"
 #include "system/system.h"
 
 #define TYPE_ROCK5B_MACHINE MACHINE_TYPE_NAME("rock-5b")
@@ -41,6 +45,10 @@ static const MemMapEntry rock5b_memmap[] = {
     [ROCK5B_HIGH_RAM] = { 0x100000000, 0x310000000 },
 };
 
+#define ROCK5B_SPL_ADDR   0x00000000
+#define ROCK5B_SPL_SIZE   (4 * MiB)
+#define ROCK5B_BOOTSOURCE_ADDR (RK3588_SRAM_BASE + 0x10)
+#define ROCK5B_BOOTSOURCE_ID  3 /* BROM_BOOTSOURCE_FSPI_M0 */
 #define ROCK5B_FLASH_SIZE (16 * MiB)
 /* Match the low-memory reservation made by Rockchip U-Boot for BL31. */
 #define ROCK5B_FIRMWARE_RESERVED_SIZE (2 * MiB)
@@ -58,6 +66,29 @@ struct Rock5BMachineState {
     struct arm_boot_info binfo;
 };
 
+static void rock5b_reset(void *opaque)
+{
+    Rock5BMachineState *s = opaque;
+
+    /* Restore the firmware handoff state before entering SPL at EL2. */
+    address_space_stl_le(&address_space_memory, ROCK5B_BOOTSOURCE_ADDR,
+                         ROCK5B_BOOTSOURCE_ID, MEMTXATTRS_UNSPECIFIED, NULL);
+    address_space_stl_le(&address_space_memory,
+                         RK3588_HPTIMER_BASE + ROCKCHIP_HPTIMER_CTRL,
+                         ROCKCHIP_HPTIMER_ENABLE, MEMTXATTRS_UNSPECIFIED, NULL);
+
+    for (unsigned int i = 0; i < RK3588_NUM_CPUS; i++) {
+        ARMCPU *cpu = &s->soc.cpu[i];
+
+        cpu_reset(CPU(cpu));
+        arm_emulate_firmware_reset(CPU(cpu), 2);
+        arm_rebuild_hflags(&cpu->env);
+        if (i == 0) {
+            cpu_set_pc(CPU(cpu), ROCK5B_SPL_ADDR);
+        }
+    }
+}
+
 /*
  * The first -serial option drives the debug console; further options
  * connect to the remaining UARTs in index order.
@@ -128,6 +159,35 @@ static void rock5b_modify_dtb(const struct arm_boot_info *binfo, void *fdt)
     }
 }
 
+static void rock5b_firmware_boot(Rock5BMachineState *s)
+{
+    MachineState *ms = MACHINE(s);
+
+    for (unsigned int i = 0; i < RK3588_NUM_CPUS; i++) {
+        object_property_set_int(OBJECT(&s->soc.cpu[i]), "psci-conduit",
+                                QEMU_PSCI_CONDUIT_SMC, &error_abort);
+    }
+
+    if (ms->firmware) {
+        g_autofree char *filename = qemu_find_file(QEMU_FILE_TYPE_BIOS,
+                                                  ms->firmware);
+        ssize_t size;
+
+        if (!filename) {
+            error_report("rock-5b: cannot find SPL '%s'", ms->firmware);
+            exit(EXIT_FAILURE);
+        }
+        size = load_image_targphys(filename, ROCK5B_SPL_ADDR,
+                                   ROCK5B_SPL_SIZE, &error_fatal);
+        if (size <= 0) {
+            error_report("rock-5b: SPL image is empty");
+            exit(EXIT_FAILURE);
+        }
+    }
+    /* Restore the firmware handoff state after device reset. */
+    qemu_register_reset(rock5b_reset, s);
+}
+
 /*
  * arm_load_kernel() enters Linux at EL2, keeps the SMC PSCI conduit and
  * registers the CPU reset handlers.
@@ -157,20 +217,6 @@ static void rock5b_init(MachineState *ms)
         exit(EXIT_FAILURE);
     }
 
-    if (ms->firmware) {
-        error_report("rock-5b: -bios is not supported");
-        exit(EXIT_FAILURE);
-    }
-    if (ms->kernel_filename) {
-        if (!ms->dtb) {
-            error_report("rock-5b: direct Linux boot requires -dtb");
-            exit(EXIT_FAILURE);
-        }
-    } else if (!qtest_enabled()) {
-        error_report("rock-5b: supply a Linux kernel with -kernel");
-        exit(EXIT_FAILURE);
-    }
-
     /* Initialize the SoC object. */
     object_initialize_child(OBJECT(s), "soc", &s->soc, TYPE_RK3588_SOC);
     object_property_set_link(OBJECT(&s->soc), "memory",
@@ -197,7 +243,29 @@ static void rock5b_init(MachineState *ms)
 
     rock5b_create_flash(s);
 
-    rock5b_direct_boot(s);
+    if (ms->kernel_filename) {
+        if (ms->firmware) {
+            error_report("rock-5b: -bios and -kernel cannot be combined");
+            exit(EXIT_FAILURE);
+        }
+        if (!ms->dtb) {
+            error_report("rock-5b: direct Linux boot requires -dtb");
+            exit(EXIT_FAILURE);
+        }
+        rock5b_direct_boot(s);
+    } else {
+        if (!ms->firmware && !qtest_enabled()) {
+            error_report("rock-5b: supply a U-Boot SPL image with -bios "
+                         "or a Linux kernel with -kernel");
+            exit(EXIT_FAILURE);
+        }
+        if (ms->dtb) {
+            error_report("rock-5b: -dtb requires -kernel; U-Boot proper "
+                         "passes the device tree from the FIT");
+            exit(EXIT_FAILURE);
+        }
+        rock5b_firmware_boot(s);
+    }
 }
 
 static void rock5b_class_init(ObjectClass *oc, const void *data)
-- 
2.53.0

