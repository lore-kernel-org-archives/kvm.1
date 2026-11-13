Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.6.4.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563379;
	b=LGFn534/+E8PjFCJpDtMm4hEbrTexOm3dAF4ocQpo/vOhn02OzL64GhNIomvDfTQtzUV
	 hIN8g1tbd0L+xvKAONbL3qp2uJJvc9xh2gv+mmjHi0mIx5b6kOKVSJaFMo0/COZWXBbgu
	 QU1ynInj8Uu5EME9lRhB85d5cL2TL+wA9AEydv2NeN3wFW6j2mjpTwok3W/UvatkekZ13
	 i/Rqpm6nPZ7QfS5zGqBMmImLz1wkOXz5qszh72/xYFbkcvTMXtG8PSP/0RJyrjf7Sh3Mk
	 rQpuljVx22o1Wke+pZsy9tXARijYquUboNR0HgP0raNTJrtQNoqifQGBo4fTy7f0CXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563379;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=ziqaSW7s/T3WAwT7Mz/j7jHhExcw1/jQm85lHkw0d7M=;
	b=dCxX1/cw56zKhMvaqMxz6hJmsqxOeve6ODQaytewTw9cSPvG21P3wMY9cDfsDPSqr0kV
	 WRZkJQPIJVPCCj6mPgabmyd+IcWxsXMIdjKxh6kvwoKyTgOD90OI0q4ourM5N/QdQmSNL
	 QBtkLU22w8CEZVyONtcPx4fQ9Pd0hJHzF+Ii62VxrCPV2kff0fVGC1CLCFWoP4tsSnLuk
	 AFyyT6kAOO6OfUNGcRePQE0OcWDETNd1b1wJB9uIqQphjlT7CtQnGzZ5JharTPuALdVEe
	 ZDu+D+xqAlknQT5Dq+0zJBmHILTs3TytU83xAavgClJkp1Oq1qcRy+KgVssn9aIv6IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mails.tsinghua.edu.cn;
	spf=pass smtp.mailfrom=mails.tsinghua.edu.cn;
	dkim=pass header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=gExOVnhY;
	arc=none smtp.remote-ip=101.6.4.71
Received: from tsinghua.edu.cn (smtp47.tsinghua.edu.cn [101.6.4.71])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C14E606A882
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 09:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C14E606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=gExOVnhY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=ziqaSW7s/T3WAwT7Mz/j7jHhExcw1/jQm8
	5lHkw0d7M=; b=gExOVnhYWhnOn8O18CWMUVe4eBs4bQ/JWwEUD6yXZE/8Y+7Ay2
	zFaTghoNSiPvvh86phviTG8Uyg/KHJ6s+9sd41F2UrPpViSaGSn8ViovZBKSt+cU
	EpwnAOlqlzGH7ziwztm886HtRGfLSPXe9XrlvOXQ44cLmb2UsRtDlxtw8=
Received: from ubuntu (unknown [101.5.154.165])
	by web1 (Coremail) with SMTP id yAQGZQA3qzvR3PZqgA5CAg--.9318S17;
	Fri, 13 Nov 2026 17:49:29 +0800 (CST)
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
Subject: [RFC PATCH 15/20] hw/arm/rk3588: wire up the SCMI server
Date: Fri, 13 Nov 2026 17:47:49 +0800
Message-ID: <54d84a2574f15f9c6157e6d281ad5216b509295c.1794555589.git.w-yf22@mails.tsinghua.edu.cn>
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
X-CM-TRANSID:yAQGZQA3qzvR3PZqgA5CAg--.9318S17
X-Coremail-Antispam: 1UD129KBjvJXoWxXF18ur4rWr4DXF4UCrW8tFb_yoW5ArW5pF
	48Zr45XrWkGay7AwsIvr1Sgr43Ja1kWryrt3yfZr9YyFy3tr1Yyr4j9w4YkayIqrZFqw1U
	ZrWqqF4YgF47XF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Instantiate the SCMI server in the RK3588 SoC and map its shared memory
at the address reserved by the RK3588 device tree.  The shared memory
is overlaid on RAM so the guest can use it while the rest of the low
memory map is unchanged.

Signed-off-by: Chao Liu <chao.liu@processmission.com>
Signed-off-by: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
---
 hw/arm/rk3588.c         | 22 ++++++++++++++++++++++
 include/hw/arm/rk3588.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/hw/arm/rk3588.c b/hw/arm/rk3588.c
index 2319c54c76..f4ebb59d36 100644
--- a/hw/arm/rk3588.c
+++ b/hw/arm/rk3588.c
@@ -19,6 +19,7 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/core/sysbus.h"
 #include "hw/cpu/cluster.h"
+#include "hw/misc/rk3588-scmci.h"
 #include "hw/misc/unimp.h"
 #include "hw/timer/rockchip-hptimer.h"
 #include "migration/vmstate.h"
@@ -29,6 +30,7 @@
 #define RK3588_MPIDR_AFF0_PER_AFF1   (1)
 
 #define RK3588_CNTFRQ                24000000
+#define RK3588_SCMI_SHMEM_BASE       0x0010f000
 #define RK3588_SFC_SPI               206
 #define RK3588_GIC_NUM_IRQS          512
 
@@ -253,6 +255,21 @@ static bool rk3588_soc_create_sfc(RK3588SoCState *s, Error **errp)
     return true;
 }
 
+static bool rk3588_soc_create_scmi(RK3588SoCState *s, Error **errp)
+{
+    SysBusDevice *scmi = SYS_BUS_DEVICE(s->scmi);
+
+    if (!sysbus_realize(scmi, errp)) {
+        return false;
+    }
+
+    memory_region_add_subregion_overlap(s->memory,
+        RK3588_SCMI_SHMEM_BASE,
+        sysbus_mmio_get_region(scmi, 0), 1);
+
+    return true;
+}
+
 static bool rk3588_soc_create_uart(RK3588SoCState *s, Error **errp)
 {
     for (unsigned int i = RK3588_FIRST_UART; i < RK3588_NUM_UARTS; i++) {
@@ -329,6 +346,7 @@ static void rk3588_soc_realize(DeviceState *dev, Error **errp)
         !rk3588_soc_create_cru(s, errp) ||
         !rk3588_soc_create_otp(s, errp) ||
         !rk3588_soc_create_sfc(s, errp) ||
+        !rk3588_soc_create_scmi(s, errp) ||
         !rk3588_soc_create_uart(s, errp) ||
         !rk3588_soc_create_hptimer(s, errp)) {
         return;
@@ -388,6 +406,10 @@ static void rk3588_soc_instance_init(Object *obj)
     object_property_add_child(obj, "sfc", OBJECT(s->sfc));
     object_unref(OBJECT(s->sfc));
 
+    s->scmi = qdev_new(TYPE_RK3588_SCMCI);
+    object_property_add_child(obj, "scmi", OBJECT(s->scmi));
+    object_unref(OBJECT(s->scmi));
+
     s->hptimer = qdev_new(TYPE_ROCKCHIP_HPTIMER);
     object_property_add_child(obj, "hptimer", OBJECT(s->hptimer));
     object_unref(OBJECT(s->hptimer));
diff --git a/include/hw/arm/rk3588.h b/include/hw/arm/rk3588.h
index 1304c11598..f85242f464 100644
--- a/include/hw/arm/rk3588.h
+++ b/include/hw/arm/rk3588.h
@@ -55,6 +55,7 @@ struct RK3588SoCState {
     DeviceState *cru;
     DeviceState *otp;
     DeviceState *sfc;
+    DeviceState *scmi;
     MemoryRegion *memory;
     MemoryRegion sram;
     DeviceState *hptimer;
-- 
2.53.0

