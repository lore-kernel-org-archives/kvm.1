Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.6.4.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563384;
	b=Yjhak3CiHar4+6p4bmC00ZgHQDQNUm12JlmhV3T1k3HhCVD5gCv4vBKyyasgDJ5g1TOJ
	 m1cumRk5R3f3LspBsaz4gOHMS29LCfSW6jssVGPibArAH+cbHCOgMYOaFi6LLmBkXrRh6
	 fItpgrqTVYUvIgpMds732dgUWZzr1ywXm71VYP23e5jUYLfCj2xWgOPiJYtPnat3+ETrM
	 PsfNvgc3e5g0wACtgFFQsCb6koccyvIJH2RuLuK7Cjiie7ui1BncnJ3PKOm8+Z0svuVE+
	 lUtIl8mxHOH3GOrdfVfRPIay9VTVyu3wTTUL8zQdR/RmHARn/JcHoPwJYAAmEfk6CBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563384;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=TFBK+ruV+8TwHllPZXoQ269vGYbSb8v7MRchb9beKss=;
	b=ybpcGPf9RJJC+CQMOEQa8HRwM0kwFvgU62+YinoWTANMZZPV8sg0lIT+6ns1gXxaa3G8
	 62eGToIi6q6ubYzaWyslgg6VpxFLZ49XXjPDRJZkk2dios3oHT92SekBqmMvhqgcZHaj3
	 JkKUETSO4QkvXFHpDxxTcA1X4BdVaMMWHwCI5OJWPzUSXvKtnmft8DF3e/6/RjFlqV1pd
	 fhnJMHvtRJlqJsZSg/6/w5t0m1I/fI/L7mBH9tvtyUPBLyDeI73+EXaWW0l4zO+xNnJ6k
	 w3ddve5eaRC31YDwZYbkdSgBHd6iri6aGfqukAPO1svTO0LPCeYkHyEnb7MQ9WQiLig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mails.tsinghua.edu.cn;
	spf=pass smtp.mailfrom=mails.tsinghua.edu.cn;
	dkim=pass header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=bS6YQ+CX;
	arc=none smtp.remote-ip=101.6.4.70
Received: from tsinghua.edu.cn (smtp46.tsinghua.edu.cn [101.6.4.70])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852F0606A88C
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 09:49:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 852F0606A88C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=bS6YQ+CX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=TFBK+ruV+8TwHllPZXoQ269vGYbSb8v7MR
	chb9beKss=; b=bS6YQ+CXU9bmBRkSEGBwMrLIe1ET1IRUfg4zy3V2JP3k5emiFL
	XTHdR73HnKVbAUKJa5z4grg4SKx5Z2X5H9vxOr5os+2S5I+zpzNNoOOuRaSsZ8dM
	PNgf4k5f9IPEtrSsmkwCBVev5yjKCXhTh2LSECVrDRlnVcUmkWYC5mMEQ=
Received: from ubuntu (unknown [101.5.154.165])
	by web1 (Coremail) with SMTP id yAQGZQA3qzvR3PZqgA5CAg--.9318S19;
	Fri, 13 Nov 2026 17:49:34 +0800 (CST)
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
Subject: [RFC PATCH 17/20] hw/arm/rock-5b: connect the XTX XT25F128 SPI NOR flash
Date: Fri, 13 Nov 2026 17:47:51 +0800
Message-ID: <4451c95e39bfe37a0587b11019798464d7215006.1794555589.git.w-yf22@mails.tsinghua.edu.cn>
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
X-CM-TRANSID:yAQGZQA3qzvR3PZqgA5CAg--.9318S19
X-Coremail-Antispam: 1UD129KBjvJXoWxur1fuF1UAr15Jw1rWrWxZwb_yoW5XFy8pF
	10kFZ8CrZ3G3WagrWayF4Sgw15Ww4vv3WUAr1fu3sYvFy7tFWDWrWxKw15CFyUWrZYy3yj
	9r9xXF1rtF45ur7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Connect an XT25F128 to chip select 0 of the ROCK 5B SFC. An optional
if=mtd,index=0 drive provides the flash contents and must be exactly
16 MiB; without a drive the flash starts erased.

Signed-off-by: Chao Liu <chao.liu@processmission.com>
Signed-off-by: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
---
 hw/arm/Kconfig   |  1 +
 hw/arm/rock-5b.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 40f7de823c..01ae699fee 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -789,3 +789,4 @@ config ROCK5B
     default y
     depends on TCG && AARCH64
     select RK3588
+    select SSI_M25P80
diff --git a/hw/arm/rock-5b.c b/hw/arm/rock-5b.c
index 7906d53175..abc898c50c 100644
--- a/hw/arm/rock-5b.c
+++ b/hw/arm/rock-5b.c
@@ -17,8 +17,12 @@
 #include "hw/arm/boot.h"
 #include "hw/arm/rk3588.h"
 #include "hw/core/boards.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-properties-system.h"
+#include "hw/ssi/ssi.h"
 #include "system/address-spaces.h"
+#include "system/block-backend.h"
+#include "system/blockdev.h"
 #include "system/device_tree.h"
 #include "system/kvm.h"
 #include "system/qtest.h"
@@ -37,6 +41,7 @@ static const MemMapEntry rock5b_memmap[] = {
     [ROCK5B_HIGH_RAM] = { 0x100000000, 0x310000000 },
 };
 
+#define ROCK5B_FLASH_SIZE (16 * MiB)
 /* Match the low-memory reservation made by Rockchip U-Boot for BL31. */
 #define ROCK5B_FIRMWARE_RESERVED_SIZE (2 * MiB)
 /* UART2 drives the board's debug header. */
@@ -70,6 +75,28 @@ static void rock5b_connect_serial(Rock5BMachineState *s)
     }
 }
 
+static void rock5b_create_flash(Rock5BMachineState *s)
+{
+    DriveInfo *di = drive_get(IF_MTD, 0, 0);
+    DeviceState *flash = qdev_new("xt25f128");
+
+    object_property_add_child(OBJECT(s), "spi-nor", OBJECT(flash));
+    if (di) {
+        BlockBackend *blk = blk_by_legacy_dinfo(di);
+        int64_t length = blk_getlength(blk);
+
+        if (length != ROCK5B_FLASH_SIZE) {
+            error_report("rock-5b: SPI NOR image must be exactly 16 MiB");
+            exit(EXIT_FAILURE);
+        }
+        qdev_prop_set_drive_err(flash, "drive", blk, &error_fatal);
+    }
+    qdev_realize_and_unref(flash, qdev_get_child_bus(s->soc.sfc, "spi"),
+                           &error_fatal);
+    qdev_connect_gpio_out_named(s->soc.sfc, "cs", 0,
+                                qdev_get_gpio_in_named(flash, SSI_GPIO_CS, 0));
+}
+
 /*
  * arm_load_dtb() replaces the memory nodes with a single node for low RAM;
  * add the RAM above the peripheral hole.
@@ -168,6 +195,8 @@ static void rock5b_init(MachineState *ms)
                                     &s->high_ram);
     }
 
+    rock5b_create_flash(s);
+
     rock5b_direct_boot(s);
 }
 
-- 
2.53.0

