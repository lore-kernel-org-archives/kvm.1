Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.6.4.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563377;
	b=oTW1eBjOfFXdg9rAHdngU218HW7XDdXqD9bsOpEiaerOHgujDmqq4tYMjqFr64yYnYLw
	 iD78+UilBGmkMseKRlZjx2viwPFl1aKsuYz+74PvstPNBvRbZv3KOlXsiWej3DYENd2Pg
	 B8IU/Xcg5SQ2PAum0aJjgvekkemxQZnxdmUXzDgWL4+uSf/DFY8juhplhQ13E7j6STnP/
	 YTimHsXmfJDW8S1TZGj6fN2oBXMMz0shCHjDulYShRLOOXrewkO2SvkgknLBXVIN6nUWP
	 kmBne9cC8TvGzE0z6pxp0iO8srSiFOrgj0Iu3qDUa5cn5dSKSJsFoJ4ez/rQGchm4Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563377;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=ZhJqZ4Iz1JybuOyLa3+Tf7ZbuQ75IVhz6am+cHq5Pwk=;
	b=4DMVbi/AFvv2zvbEGFqfz+6gu1mzYOpI6L3VVAdAGDlLdRlp920YuFF592R81Yz/dwE/
	 /5mDt4ASG7taOTmU7QLe6gynD1bpauV6/kzVhsobyjGNbWdMuOBGXI/ii3kPUKFfEZpSO
	 h0JvdX2tw6R5+rsTvVr4LTQg79MGSRpecl0/6DP7JQePUenTr99w3SMsi4BRGItnxjGr/
	 VMxLrrjYtYhLm/qT8atGmYfssrjGsaz+d89vGVI/jnZBIQYF/eTk/9P0FLkQ2sSKAPOpR
	 GVab/q7jEu4iRSzBFMymW4NB48xoeMpNhzZpdBQuF/o1i/fPfpQruuRz8slB2cPrkQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mails.tsinghua.edu.cn;
	spf=pass smtp.mailfrom=mails.tsinghua.edu.cn;
	dkim=pass header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=g4qysHZf;
	arc=none smtp.remote-ip=101.6.4.71
Received: from tsinghua.edu.cn (smtp47.tsinghua.edu.cn [101.6.4.71])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EF5606A321
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 09:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3EF5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=g4qysHZf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=ZhJqZ4Iz1JybuOyLa3+Tf7ZbuQ75IVhz6a
	m+cHq5Pwk=; b=g4qysHZfXc6ZmGUkPA3EZd/9k7g/WcpnJPj2R0Txzr/8eA9mRj
	Q3k0QBjqUQzp0PjVJC02NgJ80YV7aCM1asWodNI8fWFh6fLTVpegfAUPU1Z35/2y
	bh4iUXU+xpvHQiOsdpdJjjHB4Rn8izn3ZUAqqNvdCtXawBaXf12VDZcxQ=
Received: from ubuntu (unknown [101.5.154.165])
	by web1 (Coremail) with SMTP id yAQGZQA3qzvR3PZqgA5CAg--.9318S16;
	Fri, 13 Nov 2026 17:49:24 +0800 (CST)
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
Subject: [RFC PATCH 14/20] hw/misc: add RK3588 SCMI server
Date: Fri, 13 Nov 2026 17:47:48 +0800
Message-ID: <d6ac376874ebd963542d26e74ff6540e8d054100.1794555589.git.w-yf22@mails.tsinghua.edu.cn>
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
X-CM-TRANSID:yAQGZQA3qzvR3PZqgA5CAg--.9318S16
X-Coremail-Antispam: 1UD129KBjvAXoW3uw18JrWUKrW8Cw47Kw45ZFb_yoW8Cw4rAo
	WUGr95tr4Fgr4rAFn5uw1UJ3y0vryjkay2yws0qrs093ZrX3s5G3ZrJa95J34fGrW8ZryU
	Wry0q3s7t392kryxn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
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

RK3588 firmware exposes SCMI through the SMC transport.  Add a minimal
server implementing the Base and Clock protocols and the shared memory
area described by the upstream RK3588 device tree, so a guest can
exercise the standard arm,scmi-smc path without running a complete
BL31 image.

Provide the CPUL, DSU, CPUB01 and CPUB23 clocks using the nominal
PVTPLL rates accepted by TF-A v2.12. Clock rates and enable state are
maintained independently of the CRU registers.

Signed-off-by: Chao Liu <chao.liu@processmission.com>
Signed-off-by: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
---
 MAINTAINERS                    |   2 +
 hw/misc/meson.build            |   1 +
 hw/misc/rk3588-scmci.c         | 589 +++++++++++++++++++++++++++++++++
 include/hw/misc/rk3588-scmci.h |  25 ++
 4 files changed, 617 insertions(+)
 create mode 100644 hw/misc/rk3588-scmci.c
 create mode 100644 include/hw/misc/rk3588-scmci.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 7fd434ade2..c3d3388975 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1067,9 +1067,11 @@ S: Maintained
 F: hw/arm/rk3588.c
 F: hw/misc/rockchip_cru.c
 F: hw/misc/rockchip_otp.c
+F: hw/misc/rk3588-scmci.c
 F: hw/ssi/rockchip_sfc.c
 F: hw/timer/rockchip-hptimer.c
 F: include/hw/arm/rk3588.h
+F: include/hw/misc/rk3588-scmci.h
 F: include/hw/timer/rockchip-hptimer.h
 
 SABRELITE / i.MX6
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 51c09b056e..8f13f5da77 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -16,6 +16,7 @@ system_ss.add(when: 'CONFIG_PL310', if_true: files('arm_l2x0.c'))
 system_ss.add(when: 'CONFIG_INTEGRATOR_DEBUG', if_true: files('arm_integrator_debug.c'))
 system_ss.add(when: 'CONFIG_A9SCU', if_true: files('a9scu.c'))
 system_ss.add(when: 'CONFIG_ARM11SCU', if_true: files('arm11scu.c'))
+system_ss.add(when: 'CONFIG_RK3588', if_true: files('rk3588-scmci.c'))
 
 system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_ras.c'))
 
diff --git a/hw/misc/rk3588-scmci.c b/hw/misc/rk3588-scmci.c
new file mode 100644
index 0000000000..956919e823
--- /dev/null
+++ b/hw/misc/rk3588-scmci.c
@@ -0,0 +1,589 @@
+/*
+ * Rockchip RK3588 SCMI server
+ *
+ * The RK3588 firmware exposes SCMI through the SMC transport rather
+ * than through a mailbox.  This model provides the shared memory area
+ * and a minimal server implementing the Base and Clock protocols. Clock rates
+ * and enable state are maintained independently of CRU registers. It is
+ * intended to let a guest exercise the standard arm,scmi-smc path without
+ * running a complete BL31 image.
+ *
+ * Copyright (C) 2026 Process Mission
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/bswap.h"
+#include "hw/arm/arm-smc.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/resettable.h"
+#include "hw/core/sysbus.h"
+#include "hw/misc/rk3588-scmci.h"
+#include "system/memory.h"
+
+#define RK3588_SCMI_SHORT_NAME_SIZE     16
+#define RK3588_SCMI_MAX_STR_SIZE        64
+
+/*
+ * Use the U-Boot v2025.01 SPL boot rate, with DSU using its default
+ * LPLL source and divide-by-one setting.
+ */
+#define RK3588_SCMI_BOOT_RATE           816000000ULL
+
+#define RK3588_SCMI_CPUL                0
+#define RK3588_SCMI_DSU                 1
+#define RK3588_SCMI_CPUB01              2
+#define RK3588_SCMI_CPUB23              3
+
+/*
+ * TF-A v2.12 PVTPLL nominal rates, sorted ascending for enumeration and
+ * selection. These differ from the firmware's advertised rate lists.
+ */
+static const uint64_t rk3588_cpul_rates[] = {
+    408000000, 600000000, 816000000, 1008000000, 1200000000,
+    1416000000, 1608000000, 1704000000, 1800000000,
+};
+
+static const uint64_t rk3588_cpub_rates[] = {
+    408000000, 600000000, 816000000, 1008000000, 1200000000,
+    1416000000, 1608000000, 1800000000, 2016000000, 2112000000,
+    2208000000, 2256000000, 2304000000, 2352000000, 2400000000,
+};
+
+static const struct {
+    const char *name;
+    const uint64_t *rates;
+    size_t num_rates;
+} rk3588_scmi_clocks[] = {
+    [RK3588_SCMI_CPUL] = {
+        "scmi_clk_cpul", rk3588_cpul_rates, ARRAY_SIZE(rk3588_cpul_rates),
+    },
+    [RK3588_SCMI_DSU] = {
+        "scmi_clk_dsu", rk3588_cpul_rates, ARRAY_SIZE(rk3588_cpul_rates),
+    },
+    [RK3588_SCMI_CPUB01] = {
+        "scmi_clk_cpub01", rk3588_cpub_rates, ARRAY_SIZE(rk3588_cpub_rates),
+    },
+    [RK3588_SCMI_CPUB23] = {
+        "scmi_clk_cpub23", rk3588_cpub_rates, ARRAY_SIZE(rk3588_cpub_rates),
+    },
+};
+
+/* SCMI shared memory layout, see Linux struct scmi_shared_mem. */
+#define SCMI_SHMEM_RESERVED             0x00
+#define SCMI_SHMEM_CHANNEL_STATUS       0x04
+#define SCMI_SHMEM_RESERVED1            0x08
+#define SCMI_SHMEM_FLAGS                0x10
+#define SCMI_SHMEM_LENGTH               0x14
+#define SCMI_SHMEM_MSG_HEADER           0x18
+#define SCMI_SHMEM_MSG_PAYLOAD          0x1c
+
+/* Space for response data after the 32-bit SCMI status code. */
+#define RK3588_SCMI_RESP_MAX \
+    (RK3588_SCMI_SHMEM_SIZE - SCMI_SHMEM_MSG_PAYLOAD - sizeof(uint32_t))
+
+#define SCMI_SHMEM_CHANNEL_FREE         BIT(0)
+#define SCMI_SHMEM_CHANNEL_ERROR        BIT(1)
+
+#define SCMI_MSG_ID(hdr)                ((hdr) & 0xff)
+#define SCMI_MSG_PROTOCOL(hdr)          (((hdr) >> 10) & 0xff)
+
+#define SCMI_PROTOCOL_BASE              0x10
+#define SCMI_PROTOCOL_CLOCK             0x14
+
+#define SCMI_SUCCESS                    0
+#define SCMI_ERR_SUPPORT                (-1)
+#define SCMI_ERR_PARAMS                 (-2)
+#define SCMI_ERR_NOT_FOUND              (-4)
+#define SCMI_ERR_OUT_OF_RANGE           (-5)
+#define SCMI_ERR_PROTOCOL               (-10)
+
+#define SCMI_BASE_PROTOCOL_VERSION      0x00020001
+#define SCMI_CLOCK_PROTOCOL_VERSION     0x00020000
+
+#define SCMI_CLOCK_EXTENDED_NAMES        BIT(29)
+#define SCMI_CLOCK_ENABLED               BIT(0)
+
+#define SCMI_CLOCK_SET_ASYNC            BIT(0)
+#define SCMI_CLOCK_SET_IGNORE_RESP      BIT(1)
+#define SCMI_CLOCK_SET_ROUND_UP         BIT(2)
+#define SCMI_CLOCK_SET_ROUND_AUTO       BIT(3)
+
+/* Each rate list is preceded by a 32-bit count/flags field. */
+G_STATIC_ASSERT(sizeof(rk3588_cpul_rates) + sizeof(uint32_t) <=
+                RK3588_SCMI_RESP_MAX);
+G_STATIC_ASSERT(sizeof(rk3588_cpub_rates) + sizeof(uint32_t) <=
+                RK3588_SCMI_RESP_MAX);
+
+struct RK3588SCMIState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion shmem;
+    uint8_t *shmem_ptr;
+    uint64_t clock_rate[ARRAY_SIZE(rk3588_scmi_clocks)];
+    uint32_t clock_config[ARRAY_SIZE(rk3588_scmi_clocks)];
+    bool smc_registered;
+};
+
+static uint32_t rk3588_scmi_rd32(RK3588SCMIState *s, hwaddr offset)
+{
+    return ldl_le_p(s->shmem_ptr + offset);
+}
+
+static void rk3588_scmi_wr32(RK3588SCMIState *s, hwaddr offset, uint32_t value)
+{
+    stl_le_p(s->shmem_ptr + offset, value);
+}
+
+static void rk3588_scmi_put_name(uint8_t *dst, const char *name)
+{
+    size_t len = strlen(name);
+
+    memset(dst, 0, RK3588_SCMI_SHORT_NAME_SIZE);
+    memcpy(dst, name, MIN(len, RK3588_SCMI_SHORT_NAME_SIZE));
+}
+
+static int32_t rk3588_scmi_base_protocol(RK3588SCMIState *s, uint8_t msg_id,
+                                         const uint8_t *req, size_t req_len,
+                                         uint8_t *resp, size_t *resp_len)
+{
+    uint32_t value;
+
+    switch (msg_id) {
+    case 0x0: /* PROTOCOL_VERSION */
+        stl_le_p(resp, SCMI_BASE_PROTOCOL_VERSION);
+        *resp_len = 4;
+        return SCMI_SUCCESS;
+
+    case 0x1: /* PROTOCOL_ATTRIBUTES */
+        resp[0] = 1; /* one implemented protocol: Clock */
+        resp[1] = 1; /* one agent */
+        resp[2] = 0;
+        resp[3] = 0;
+        *resp_len = 4;
+        return SCMI_SUCCESS;
+
+    case 0x2: /* PROTOCOL_MESSAGE_ATTRIBUTES */
+        if (req_len < 4) {
+            return SCMI_ERR_PROTOCOL;
+        }
+        value = ldl_le_p(req);
+        if (value > 0x7) {
+            return SCMI_ERR_NOT_FOUND;
+        }
+        stl_le_p(resp, 0);
+        *resp_len = 4;
+        return SCMI_SUCCESS;
+
+    case 0x3: /* BASE_DISCOVER_VENDOR */
+    case 0x4: /* BASE_DISCOVER_SUB_VENDOR */
+        rk3588_scmi_put_name(resp, "QEMU");
+        *resp_len = RK3588_SCMI_SHORT_NAME_SIZE;
+        return SCMI_SUCCESS;
+
+    case 0x5: /* BASE_DISCOVER_IMPLEMENT_VERSION */
+        stl_le_p(resp, 1);
+        *resp_len = 4;
+        return SCMI_SUCCESS;
+
+    case 0x6: /* BASE_DISCOVER_LIST_PROTOCOLS */
+        if (req_len < 4) {
+            return SCMI_ERR_PROTOCOL;
+        }
+        value = ldl_le_p(req);
+        if (value == 0) {
+            stl_le_p(resp, 1);
+            resp[4] = SCMI_PROTOCOL_CLOCK;
+            resp[5] = 0;
+            resp[6] = 0;
+            resp[7] = 0;
+            *resp_len = 8;
+        } else {
+            stl_le_p(resp, 0);
+            *resp_len = 4;
+        }
+        return SCMI_SUCCESS;
+
+    case 0x7: /* BASE_DISCOVER_AGENT */
+        if (req_len < 4) {
+            return SCMI_ERR_PROTOCOL;
+        }
+        value = ldl_le_p(req);
+        if (value == UINT32_MAX) {
+            value = 1; /* The single agent using this channel. */
+        }
+        if (value > 1) {
+            return SCMI_ERR_NOT_FOUND;
+        }
+        stl_le_p(resp, value);
+        rk3588_scmi_put_name(resp + 4, value ? "QEMU" : "platform");
+        *resp_len = 4 + RK3588_SCMI_SHORT_NAME_SIZE;
+        return SCMI_SUCCESS;
+
+    default:
+        return SCMI_ERR_SUPPORT;
+    }
+}
+
+/*
+ * Caller validates id. ROUND_AUTO takes precedence; ties select the lower rate.
+ */
+static int32_t rk3588_scmi_select_rate(uint32_t id, uint32_t flags,
+                                       uint64_t requested, uint64_t *selected)
+{
+    const uint64_t *rates = rk3588_scmi_clocks[id].rates;
+    size_t count = rk3588_scmi_clocks[id].num_rates;
+    size_t i;
+
+    for (i = 0; i < count && rates[i] < requested; i++) {
+        /* Find the first rate at least as high as requested. */
+    }
+    if (i < count && rates[i] == requested) {
+        *selected = rates[i];
+    } else if (flags & SCMI_CLOCK_SET_ROUND_AUTO) {
+        if (i == 0) {
+            *selected = rates[0];
+        } else if (i == count ||
+                   requested - rates[i - 1] <= rates[i] - requested) {
+            *selected = rates[i - 1];
+        } else {
+            *selected = rates[i];
+        }
+    } else if (flags & SCMI_CLOCK_SET_ROUND_UP) {
+        if (i == count) {
+            return SCMI_ERR_OUT_OF_RANGE;
+        }
+        *selected = rates[i];
+    } else {
+        if (i == 0) {
+            return SCMI_ERR_OUT_OF_RANGE;
+        }
+        *selected = rates[i - 1];
+    }
+    return SCMI_SUCCESS;
+}
+
+static int32_t rk3588_scmi_clock_protocol(RK3588SCMIState *s, uint8_t msg_id,
+                                          const uint8_t *req, size_t req_len,
+                                          uint8_t *resp, size_t *resp_len)
+{
+    uint32_t id;
+
+    switch (msg_id) {
+    case 0x0: /* PROTOCOL_VERSION */
+        stl_le_p(resp, SCMI_CLOCK_PROTOCOL_VERSION);
+        *resp_len = 4;
+        return SCMI_SUCCESS;
+
+    case 0x1: /* PROTOCOL_ATTRIBUTES */
+        stw_le_p(resp, ARRAY_SIZE(rk3588_scmi_clocks));
+        resp[2] = 0;
+        resp[3] = 0;
+        *resp_len = 4;
+        return SCMI_SUCCESS;
+
+    case 0x2: /* PROTOCOL_MESSAGE_ATTRIBUTES */
+        if (req_len < 4) {
+            return SCMI_ERR_PROTOCOL;
+        }
+        id = ldl_le_p(req);
+        if (id > 0x8 && id != 0xb) {
+            return SCMI_ERR_NOT_FOUND;
+        }
+        stl_le_p(resp, 0);
+        *resp_len = 4;
+        return SCMI_SUCCESS;
+
+    case 0x3: /* CLOCK_ATTRIBUTES */
+        if (req_len < 4) {
+            return SCMI_ERR_PROTOCOL;
+        }
+        id = ldl_le_p(req);
+        if (id >= ARRAY_SIZE(rk3588_scmi_clocks)) {
+            return SCMI_ERR_NOT_FOUND;
+        }
+        stl_le_p(resp, SCMI_CLOCK_EXTENDED_NAMES |
+                       (s->clock_config[id] & SCMI_CLOCK_ENABLED));
+        rk3588_scmi_put_name(resp + 4, rk3588_scmi_clocks[id].name);
+        stl_le_p(resp + 4 + RK3588_SCMI_SHORT_NAME_SIZE, 0);
+        *resp_len = 4 + RK3588_SCMI_SHORT_NAME_SIZE + 4;
+        return SCMI_SUCCESS;
+
+    case 0x4: { /* CLOCK_DESCRIBE_RATES */
+        uint32_t rate_index;
+        size_t count;
+
+        if (req_len < 8) {
+            return SCMI_ERR_PROTOCOL;
+        }
+        id = ldl_le_p(req);
+        rate_index = ldl_le_p(req + 4);
+        if (id >= ARRAY_SIZE(rk3588_scmi_clocks)) {
+            return SCMI_ERR_NOT_FOUND;
+        }
+        count = rk3588_scmi_clocks[id].num_rates;
+        if (rate_index >= count) {
+            return SCMI_ERR_OUT_OF_RANGE;
+        }
+        count -= rate_index;
+        stl_le_p(resp, count);
+        for (size_t i = 0; i < count; i++) {
+            stq_le_p(resp + 4 + i * 8,
+                     rk3588_scmi_clocks[id].rates[rate_index + i]);
+        }
+        *resp_len = 4 + count * 8;
+        return SCMI_SUCCESS;
+    }
+
+    case 0x5: { /* CLOCK_RATE_SET */
+        uint32_t flags;
+        uint64_t rate;
+        int32_t status;
+
+        if (req_len < 16) {
+            return SCMI_ERR_PROTOCOL;
+        }
+        flags = ldl_le_p(req);
+        id = ldl_le_p(req + 4);
+        if (id >= ARRAY_SIZE(rk3588_scmi_clocks)) {
+            return SCMI_ERR_NOT_FOUND;
+        }
+        if (flags & ~(SCMI_CLOCK_SET_ASYNC | SCMI_CLOCK_SET_IGNORE_RESP |
+                      SCMI_CLOCK_SET_ROUND_UP | SCMI_CLOCK_SET_ROUND_AUTO)) {
+            return SCMI_ERR_PARAMS;
+        }
+        if (flags & SCMI_CLOCK_SET_ASYNC) {
+            return SCMI_ERR_SUPPORT;
+        }
+        rate = ldq_le_p(req + 8);
+        status = rk3588_scmi_select_rate(id, flags, rate, &rate);
+        if (status != SCMI_SUCCESS) {
+            return status;
+        }
+        s->clock_rate[id] = rate;
+        if (id == RK3588_SCMI_CPUL) {
+            /* TF-A v2.12 also sets DSU to the requested CPUL rate. */
+            s->clock_rate[RK3588_SCMI_DSU] = rate;
+        }
+        *resp_len = 0;
+        return SCMI_SUCCESS;
+    }
+
+    case 0x6: /* CLOCK_RATE_GET */
+        if (req_len < 4) {
+            return SCMI_ERR_PROTOCOL;
+        }
+        id = ldl_le_p(req);
+        if (id >= ARRAY_SIZE(rk3588_scmi_clocks)) {
+            return SCMI_ERR_NOT_FOUND;
+        }
+        stq_le_p(resp, s->clock_rate[id]);
+        *resp_len = 8;
+        return SCMI_SUCCESS;
+
+    case 0x7: { /* CLOCK_CONFIG_SET */
+        uint32_t attributes;
+
+        if (req_len < 8) {
+            return SCMI_ERR_PROTOCOL;
+        }
+        id = ldl_le_p(req);
+        if (id >= ARRAY_SIZE(rk3588_scmi_clocks)) {
+            return SCMI_ERR_NOT_FOUND;
+        }
+        attributes = ldl_le_p(req + 4);
+        if (attributes & ~SCMI_CLOCK_ENABLED) {
+            return SCMI_ERR_PARAMS;
+        }
+        s->clock_config[id] = attributes;
+        *resp_len = 0;
+        return SCMI_SUCCESS;
+    }
+
+    case 0x8: /* CLOCK_NAME_GET */
+        if (req_len < 4) {
+            return SCMI_ERR_PROTOCOL;
+        }
+        id = ldl_le_p(req);
+        if (id >= ARRAY_SIZE(rk3588_scmi_clocks)) {
+            return SCMI_ERR_NOT_FOUND;
+        }
+        memset(resp, 0, 4 + RK3588_SCMI_MAX_STR_SIZE);
+        memcpy(resp + 4, rk3588_scmi_clocks[id].name,
+               strlen(rk3588_scmi_clocks[id].name));
+        *resp_len = 4 + RK3588_SCMI_MAX_STR_SIZE;
+        return SCMI_SUCCESS;
+
+    case 0xb: { /* CLOCK_CONFIG_GET */
+        uint32_t flags;
+
+        if (req_len < 8) {
+            return SCMI_ERR_PROTOCOL;
+        }
+        id = ldl_le_p(req);
+        if (id >= ARRAY_SIZE(rk3588_scmi_clocks)) {
+            return SCMI_ERR_NOT_FOUND;
+        }
+        flags = ldl_le_p(req + 4);
+        if (flags & ~0xffU) {
+            return SCMI_ERR_PARAMS;
+        }
+        if (flags) { /* OEM configuration type */
+            return SCMI_ERR_SUPPORT;
+        }
+        stl_le_p(resp, 0);
+        stl_le_p(resp + 4, s->clock_config[id]);
+        stl_le_p(resp + 8, 0);
+        *resp_len = 12;
+        return SCMI_SUCCESS;
+    }
+
+    default:
+        return SCMI_ERR_SUPPORT;
+    }
+}
+
+static void rk3588_scmi_process(RK3588SCMIState *s)
+{
+    uint32_t channel_status = rk3588_scmi_rd32(s, SCMI_SHMEM_CHANNEL_STATUS);
+    uint32_t length = rk3588_scmi_rd32(s, SCMI_SHMEM_LENGTH);
+    uint32_t header = rk3588_scmi_rd32(s, SCMI_SHMEM_MSG_HEADER);
+    uint32_t protocol = SCMI_MSG_PROTOCOL(header);
+    uint32_t msg_id = SCMI_MSG_ID(header);
+    const uint8_t *req = s->shmem_ptr + SCMI_SHMEM_MSG_PAYLOAD;
+    uint8_t resp[RK3588_SCMI_RESP_MAX];
+    size_t req_len;
+    size_t resp_len = 0;
+    int32_t status;
+
+    memset(resp, 0, sizeof(resp));
+
+    if (channel_status & SCMI_SHMEM_CHANNEL_ERROR) {
+        return;
+    }
+
+    if (length < 4 ||
+        length - 4 > RK3588_SCMI_SHMEM_SIZE - SCMI_SHMEM_MSG_PAYLOAD) {
+        status = SCMI_ERR_PROTOCOL;
+        resp_len = 0;
+    } else {
+        req_len = length - 4;
+
+        switch (protocol) {
+        case SCMI_PROTOCOL_BASE:
+            status = rk3588_scmi_base_protocol(s, msg_id, req, req_len,
+                                               resp, &resp_len);
+            break;
+        case SCMI_PROTOCOL_CLOCK:
+            status = rk3588_scmi_clock_protocol(s, msg_id, req, req_len,
+                                                resp, &resp_len);
+            break;
+        default:
+            status = SCMI_ERR_SUPPORT;
+            resp_len = 0;
+            break;
+        }
+    }
+
+    if (resp_len > RK3588_SCMI_RESP_MAX) {
+        status = SCMI_ERR_PROTOCOL;
+        resp_len = 0;
+    }
+
+    rk3588_scmi_wr32(s, SCMI_SHMEM_MSG_HEADER, header);
+    rk3588_scmi_wr32(s, SCMI_SHMEM_LENGTH, 8 + resp_len);
+    rk3588_scmi_wr32(s, SCMI_SHMEM_MSG_PAYLOAD, (uint32_t)status);
+    if (resp_len) {
+        memcpy(s->shmem_ptr + SCMI_SHMEM_MSG_PAYLOAD + 4, resp, resp_len);
+    }
+    rk3588_scmi_wr32(s, SCMI_SHMEM_CHANNEL_STATUS,
+                     SCMI_SHMEM_CHANNEL_FREE |
+                     (status == SCMI_ERR_PROTOCOL ?
+                      SCMI_SHMEM_CHANNEL_ERROR : 0));
+}
+
+static bool rk3588_scmi_smc_handler(const uint64_t args[8], uint64_t *ret,
+                                  void *opaque)
+{
+    RK3588SCMIState *s = RK3588_SCMCI(opaque);
+
+    rk3588_scmi_process(s);
+    *ret = 0;
+    return true;
+}
+
+static void rk3588_scmi_reset_hold(Object *obj, ResetType type)
+{
+    RK3588SCMIState *s = RK3588_SCMCI(obj);
+
+    memset(s->shmem_ptr, 0, RK3588_SCMI_SHMEM_SIZE);
+    rk3588_scmi_wr32(s, SCMI_SHMEM_CHANNEL_STATUS, SCMI_SHMEM_CHANNEL_FREE);
+    for (size_t i = 0; i < ARRAY_SIZE(rk3588_scmi_clocks); i++) {
+        s->clock_rate[i] = RK3588_SCMI_BOOT_RATE;
+        s->clock_config[i] = 0;
+    }
+}
+
+static void rk3588_scmi_realize(DeviceState *dev, Error **errp)
+{
+    RK3588SCMIState *s = RK3588_SCMCI(dev);
+
+    if (arm_register_smc_handler(RK3588_SCMI_SMC_ID, rk3588_scmi_smc_handler,
+                                 s) < 0) {
+        error_setg(errp, "rk3588-scmci: SMC function is already registered");
+        return;
+    }
+    s->smc_registered = true;
+}
+
+static void rk3588_scmi_unrealize(DeviceState *dev)
+{
+    RK3588SCMIState *s = RK3588_SCMCI(dev);
+
+    if (s->smc_registered) {
+        arm_unregister_smc_handler(RK3588_SCMI_SMC_ID,
+                                   rk3588_scmi_smc_handler);
+        s->smc_registered = false;
+    }
+}
+
+static void rk3588_scmi_instance_init(Object *obj)
+{
+    RK3588SCMIState *s = RK3588_SCMCI(obj);
+
+    memory_region_init_ram(&s->shmem, obj, TYPE_RK3588_SCMCI,
+                           RK3588_SCMI_SHMEM_SIZE, &error_fatal);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->shmem);
+    s->shmem_ptr = memory_region_get_ram_ptr(&s->shmem);
+}
+
+static void rk3588_scmi_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
+
+    rc->phases.hold = rk3588_scmi_reset_hold;
+    dc->realize = rk3588_scmi_realize;
+    dc->unrealize = rk3588_scmi_unrealize;
+    dc->desc = "Rockchip RK3588 SCMI server";
+    dc->user_creatable = false;
+}
+
+static const TypeInfo rk3588_scmi_typeinfo = {
+    .name = TYPE_RK3588_SCMCI,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RK3588SCMIState),
+    .instance_init = rk3588_scmi_instance_init,
+    .class_init = rk3588_scmi_class_init,
+};
+
+static void rk3588_scmi_register_types(void)
+{
+    type_register_static(&rk3588_scmi_typeinfo);
+}
+
+type_init(rk3588_scmi_register_types)
diff --git a/include/hw/misc/rk3588-scmci.h b/include/hw/misc/rk3588-scmci.h
new file mode 100644
index 0000000000..4a00f621d4
--- /dev/null
+++ b/include/hw/misc/rk3588-scmci.h
@@ -0,0 +1,25 @@
+/*
+ * Rockchip RK3588 SCMI server
+ *
+ * This device implements the SCMI shared memory and a minimal SCMI
+ * server for the RK3588 SMC transport.  The guest uses the standard
+ * "arm,scmi-smc" binding, with the SMC function ID and shared memory
+ * address documented by the upstream RK3588 device tree.
+ *
+ * Copyright (C) 2026 Process Mission
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RK3588_SCMCI_H
+#define HW_MISC_RK3588_SCMCI_H
+
+#include "qom/object.h"
+
+#define TYPE_RK3588_SCMCI "rk3588-scmci"
+OBJECT_DECLARE_SIMPLE_TYPE(RK3588SCMIState, RK3588_SCMCI)
+
+#define RK3588_SCMI_SMC_ID      0x82000010
+#define RK3588_SCMI_SHMEM_SIZE  0x100
+
+#endif /* HW_MISC_RK3588_SCMCI_H */
-- 
2.53.0

