Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.6.4.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563336;
	b=tHxuQP6IKqEWzs1VJKUrxVgc1BTo9o0dTYxhIma8gCmwQjpruR34gMhmEJSxFdlL2uqj
	 So+SVrDBJjncwOURArqqnd6sqdA6br6xqRenEGLJPK7iQTn/WB4t3fv05wEK4qu7FypJc
	 x0s0HbitVlXXOcpck5Npi10ES/HDmpw63pvE/HG+Ze8nQb/b0+QHS2FpqfydzpZc/6hTp
	 iCeeGYgoRvAVA7fqDtavOVxke+ztuMzXDXJxIVcNchbmbJJs1tDUg/zZXXsjYI8Jx+bXt
	 yqyBnUu3S+WJfl7VHa5bro4BBtpHXX1O+syq4kQjwnOTTf2fpwAcxrD985+0YU+N7nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563336;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=WK5vWR9M/DL8AN0c7CHFLJPHnEHwD0zM15JKmbUn0kI=;
	b=iL905L6YV0ERxVtsIFP1NidA8aHiuDeKB3soZL3qmqRWp5XmyL2o+4oRp1hbEWnG8iAw
	 L6or5SbAfeWjTqiMO0Whucfg7SmztdYirbgxZu8+RNj+u4+SIAiQXWseV9PCYtXz9FBlr
	 XEV99ttZoyWHmRTVB91/s+4rk2Ckd15AE8xcpI6dTAs1Miw5n763hy+HrdG18R77zU082
	 toqD6+HyRp5Q35ioLgBqJcBE6kRD805PyA9ZL/0V5hwWyQXypiyOta8vvvkOe7vbtAZmh
	 3rL2hK9fDFiCuACRWZxA3TwVy06ImipNHtz5o1sJKM3yl6xlFWr2CNkd5rhGUfxe08g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mails.tsinghua.edu.cn;
	spf=pass smtp.mailfrom=mails.tsinghua.edu.cn;
	dkim=pass header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=hAq4WjgH;
	arc=none smtp.remote-ip=101.6.4.71
Received: from tsinghua.edu.cn (smtp47.tsinghua.edu.cn [101.6.4.71])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75EF606A334
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 09:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A75EF606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=hAq4WjgH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=WK5vWR9M/DL8AN0c7CHFLJPHnEHwD0zM15
	JKmbUn0kI=; b=hAq4WjgHd8AySbrxRyA2rI4N4kiMbit0U5tmiNMHwWYvnGGmdh
	wDbZih2Xkh7FhD/nR+JtQgvZcyo9KKfLxfGjpmEIoLk5StuG80L/skn3Wh+PucHl
	exjeBAS1LwciM75DfXV2pOcvpagde6ik+gu7KMxn9EIhq+3IJ+dXMXSfg=
Received: from ubuntu (unknown [101.5.154.165])
	by web1 (Coremail) with SMTP id yAQGZQA3qzvR3PZqgA5CAg--.9318S10;
	Fri, 13 Nov 2026 17:48:39 +0800 (CST)
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
Subject: [RFC PATCH 08/20] hw/arm/rk3588: add the unimplemented device map
Date: Fri, 13 Nov 2026 17:47:42 +0800
Message-ID: <c682af4b7bac34ca0a5f8d85b80adf07490827c0.1794555589.git.w-yf22@mails.tsinghua.edu.cn>
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
X-CM-TRANSID:yAQGZQA3qzvR3PZqgA5CAg--.9318S10
X-Coremail-Antispam: 1UD129KBjvJXoWxuw15urWrKw48uryrCFWruFg_yoW7Wr48pw
	1DG398JrZ5JanrCrWfAr17Ww45Aa1Iq34jgr1IkFyDXayYvr93Zr47Cr4vva4xWFZ2yr15
	Z392gws8GFs7GaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Add placeholder regions for the RK3588 peripheral windows that are not
modeled yet, so that guest accesses do not report errors while the
devices are being brought up.

Signed-off-by: Chao Liu <chao.liu@processmission.com>
Signed-off-by: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
---
 hw/arm/Kconfig  |  1 +
 hw/arm/rk3588.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 79b66de041..55fdc78364 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -778,3 +778,4 @@ config AXIADO_EVK
 config RK3588
     bool
     select CPU_CLUSTER
+    select UNIMP
diff --git a/hw/arm/rk3588.c b/hw/arm/rk3588.c
index 8255aee7fc..ecaaa09721 100644
--- a/hw/arm/rk3588.c
+++ b/hw/arm/rk3588.c
@@ -18,6 +18,7 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/core/sysbus.h"
 #include "hw/cpu/cluster.h"
+#include "hw/misc/unimp.h"
 #include "hw/timer/rockchip-hptimer.h"
 #include "migration/vmstate.h"
 
@@ -26,6 +27,71 @@
 
 #define RK3588_CNTFRQ                24000000
 
+#define RK3588_UNIMPLEMENTED(name, base, size) \
+    { "unimpl-" name, "rk3588." name, base, size, -1000 }
+
+/* Peripheral windows from RK3588 TRM v1.0, Table 1-1. */
+static const UnimplementedDeviceConfig rk3588_unimpl_devices[] = {
+    RK3588_UNIMPLEMENTED("firewall-ddr", 0xfe030000, 32 * KiB),
+    RK3588_UNIMPLEMENTED("firewall-sysmem", 0xfe038000, 32 * KiB),
+    RK3588_UNIMPLEMENTED("usb3-2", 0xfcd00000, 4 * MiB),
+    RK3588_UNIMPLEMENTED("pmu0-grf", 0xfd588000, 8 * KiB),
+    RK3588_UNIMPLEMENTED("pmu1-grf", 0xfd58a000, 8 * KiB),
+    RK3588_UNIMPLEMENTED("sys-grf", 0xfd58c000, 16 * KiB),
+    RK3588_UNIMPLEMENTED("usb2phy1-grf", 0xfd5d4000, 16 * KiB),
+    RK3588_UNIMPLEMENTED("usb2phy2-grf", 0xfd5d8000, 16 * KiB),
+    RK3588_UNIMPLEMENTED("usb2phy3-grf", 0xfd5dc000, 16 * KiB),
+    RK3588_UNIMPLEMENTED("pmu1-ioc", 0xfd5f0000, 16 * KiB),
+    RK3588_UNIMPLEMENTED("pmu2-ioc", 0xfd5f4000, 16 * KiB),
+    RK3588_UNIMPLEMENTED("bus-ioc", 0xfd5f8000, 4 * KiB),
+    RK3588_UNIMPLEMENTED("vccio1-4-ioc", 0xfd5f9000, 4 * KiB),
+    RK3588_UNIMPLEMENTED("vccio3-5-ioc", 0xfd5fa000, 4 * KiB),
+    RK3588_UNIMPLEMENTED("vccio2-ioc", 0xfd5fb000, 4 * KiB),
+    RK3588_UNIMPLEMENTED("vccio6-ioc", 0xfd5fc000, 4 * KiB),
+    RK3588_UNIMPLEMENTED("emmc-ioc", 0xfd5fd000, 4 * KiB),
+    RK3588_UNIMPLEMENTED("cru-ns", 0xfd7c0000, 32 * KiB),
+    RK3588_UNIMPLEMENTED("php-ppll-cru", 0xfd7c8000, 32 * KiB),
+    RK3588_UNIMPLEMENTED("pmu1-cru", 0xfd7f0000, 64 * KiB),
+    RK3588_UNIMPLEMENTED("bigcore0-cru", 0xfd810000, 8 * KiB),
+    RK3588_UNIMPLEMENTED("bigcore1-cru", 0xfd812000, 8 * KiB),
+    RK3588_UNIMPLEMENTED("dsu-cru", 0xfd818000, 16 * KiB),
+    RK3588_UNIMPLEMENTED("i2c0", 0xfd880000, 64 * KiB),
+    RK3588_UNIMPLEMENTED("gpio0", 0xfd8a0000, 64 * KiB),
+    RK3588_UNIMPLEMENTED("pwm0", 0xfd8b0000, 64 * KiB),
+    RK3588_UNIMPLEMENTED("fspi", 0xfe2b0000, 64 * KiB),
+    RK3588_UNIMPLEMENTED("sdmmc", 0xfe2c0000, 64 * KiB),
+    RK3588_UNIMPLEMENTED("sdio", 0xfe2d0000, 64 * KiB),
+    RK3588_UNIMPLEMENTED("emmc", 0xfe2e0000, 64 * KiB),
+    RK3588_UNIMPLEMENTED("trng-ns", 0xfe378000, 32 * KiB),
+    RK3588_UNIMPLEMENTED("gic600", 0xfe600000, 4 * MiB),
+    RK3588_UNIMPLEMENTED("dmac0", 0xfea10000, 64 * KiB),
+    RK3588_UNIMPLEMENTED("dmac1", 0xfea30000, 64 * KiB),
+    RK3588_UNIMPLEMENTED("i2c4", 0xfeac0000, 64 * KiB),
+    RK3588_UNIMPLEMENTED("timer-ns0", 0xfeae0000, 32 * KiB),
+    RK3588_UNIMPLEMENTED("wdt-ns", 0xfeaf0000, 64 * KiB),
+    RK3588_UNIMPLEMENTED("spi2", 0xfeb20000, 64 * KiB),
+    RK3588_UNIMPLEMENTED("uart1", 0xfeb40000, 64 * KiB),
+    RK3588_UNIMPLEMENTED("uart2", 0xfeb50000, 64 * KiB),
+    RK3588_UNIMPLEMENTED("uart3", 0xfeb60000, 64 * KiB),
+    RK3588_UNIMPLEMENTED("uart4", 0xfeb70000, 64 * KiB),
+    RK3588_UNIMPLEMENTED("uart5", 0xfeb80000, 64 * KiB),
+    RK3588_UNIMPLEMENTED("uart6", 0xfeb90000, 64 * KiB),
+    RK3588_UNIMPLEMENTED("uart7", 0xfeba0000, 64 * KiB),
+    RK3588_UNIMPLEMENTED("uart8", 0xfebb0000, 64 * KiB),
+    RK3588_UNIMPLEMENTED("uart9", 0xfebc0000, 64 * KiB),
+    RK3588_UNIMPLEMENTED("gpio1", 0xfec20000, 64 * KiB),
+    RK3588_UNIMPLEMENTED("gpio2", 0xfec30000, 64 * KiB),
+    RK3588_UNIMPLEMENTED("gpio3", 0xfec40000, 64 * KiB),
+    RK3588_UNIMPLEMENTED("gpio4", 0xfec50000, 64 * KiB),
+    RK3588_UNIMPLEMENTED("i2c6", 0xfec80000, 64 * KiB),
+    RK3588_UNIMPLEMENTED("i2c7", 0xfec90000, 64 * KiB),
+    RK3588_UNIMPLEMENTED("otp-ns", 0xfecc0000, 64 * KiB),
+    RK3588_UNIMPLEMENTED("dmac2", 0xfed10000, 64 * KiB),
+    { }
+};
+
+#undef RK3588_UNIMPLEMENTED
+
 /* The RK3588 CPU map has one A55 quad cluster and two A76 dual clusters. */
 static const struct {
     unsigned int num_cpus;
@@ -101,6 +167,8 @@ static void rk3588_soc_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    create_unimplemented_devices(OBJECT(s), s->memory, rk3588_unimpl_devices);
+
     if (!memory_region_init_ram(&s->sram, OBJECT(s), "rk3588.sram",
                                 MiB, errp)) {
         return;
-- 
2.53.0

