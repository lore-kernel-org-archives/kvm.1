Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.6.4.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563326;
	b=wxZHlEajnHgKnTUT6ll4gNK6oODSkWtVuuJKBTMKOVvkjOkQ0lszbALAIzY7U0brdElZ
	 mKFzKdxWI+GcwW8/9+rj/IV5ufBgkXE73STuvWTbrhKhInTb/E/ycJINZ/nFn3Z9Oowi6
	 CWPXR6Y38BTlq9RiTQgr5REHVmf2LHJyooJySXIQ30aAb0sp0PRmirqoYBDPmi0EMlX94
	 umw9bUl7Vn4q0pB2tI2XEr/b6imeawsfJd4r4dAzuzzEyjT3t721AGhrYC82pA9g/QN/2
	 qTIqOGqBqccMGVD6F3aHUeL0ZaUSgXfycVl29ZjD+xevWsn6yfHMbHn3aAiHWstB27w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563326;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=iHEXveoXlZNOIJB/lih70MMBsZV1xP0a51vwPMDfNI0=;
	b=ksklgIuGly8aTXi6MN7gDtgmk0/lx9K4Gi4Bfx3hnLnqq2TifUouSsndAmp/o69PWnHZ
	 Ksk0W38/4ax2tL4YQPtkUVI7D6+uZo0r4R1c1Fep8zsuEoqi1cxud9rqdX9liG1bIQ/GR
	 3hS06+Qi1jHSNAcbxYnWgc5fnSyiLtiGy/IetSSzcRyLWXhxjmCQEkNpqNm2mHO//C42t
	 WSqPxiqhPe7swkw+OrHTAe8PWZd5OQrKBpQgYDNqd+2x+rtSzp94rU5OxfAFRTdsQMl+0
	 RsaZjMnNhhgurPBSkE4nMs0sFvIuG9vc3buZRmpWlooyEW+gVxIaHHWo9bCq45RUiuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mails.tsinghua.edu.cn;
	spf=pass smtp.mailfrom=mails.tsinghua.edu.cn;
	dkim=pass header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=hjlWd4vy;
	arc=none smtp.remote-ip=101.6.4.71
Received: from tsinghua.edu.cn (smtp47.tsinghua.edu.cn [101.6.4.71])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1F3606A8B4
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 09:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B1F3606A8B4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=hjlWd4vy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=iHEXveoXlZNOIJB/lih70MMBsZV1xP0a51
	vwPMDfNI0=; b=hjlWd4vyt13HiSdknOMCti9Qc2QLS5m0avEa5WcgeEvdvpWXc0
	VpPJtu3+lMmrKGqaF2j1F8sGiFqso8A0e4zILyLfgXbYba6qJ7ICJeHDzSXX5TNJ
	HueKMIWWJKYKuOZksvmwqmqc786kAseDjaQpJP6eFLAd4xj6o3gxXJ6RQ=
Received: from ubuntu (unknown [101.5.154.165])
	by web1 (Coremail) with SMTP id yAQGZQA3qzvR3PZqgA5CAg--.9318S6;
	Fri, 13 Nov 2026 17:48:30 +0800 (CST)
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
Subject: [RFC PATCH 04/20] target/arm: allow machines to handle SMC calls
Date: Fri, 13 Nov 2026 17:47:38 +0800
Message-ID: <d72cbcb46dab52d6a919d1212221b4202db2f4c3.1794555589.git.w-yf22@mails.tsinghua.edu.cn>
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
X-CM-TRANSID:yAQGZQA3qzvR3PZqgA5CAg--.9318S6
X-Coremail-Antispam: 1UD129KBjvJXoWxtF4fWw4kKF48Gr17JrWUurg_yoW7tw1fpF
	Z8Cr98ur4kKa4av34fCF17tF43Ca1kWrW0y39FgrWFyw17ZryFkr1Dta43KFW5Gr4UuF15
	ZF4Fvr4F93W5X37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUeVbkUU
	UUU
X-CM-SenderInfo: fzn1wj2s6ptxtovo32xlqjx3vdohv3gofq/

From: Chao Liu <chao.liu@processmission.com>

Some machines model firmware services which use vendor SMC function IDs
while QEMU provides PSCI through the same SMC conduit.  There is
currently no way for such a machine to take over a call before the PSCI
path handles it.

Add a small registry for SMC function ID handlers.  Machines can
register a handler which inspects the call and returns whether it was
handled, without changing the behavior of existing callers.

Signed-off-by: Chao Liu <chao.liu@processmission.com>
Signed-off-by: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
---
 MAINTAINERS              |  1 +
 include/hw/arm/arm-smc.h | 31 ++++++++++++++++
 target/arm/helper.c      | 80 ++++++++++++++++++++++++++++++++++++++++
 target/arm/internals.h   |  3 ++
 4 files changed, 115 insertions(+)
 create mode 100644 include/hw/arm/arm-smc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index fa0c6d0c9b..db1a62a0cb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -222,6 +222,7 @@ F: tests/tcg/arm/
 F: tests/tcg/aarch64/
 F: tests/qtest/arm-cpu-features.c
 F: hw/arm/
+F: include/hw/arm/arm-smc.h
 F: hw/cpu/a*mpcore.c
 F: include/hw/cpu/a*mpcore.h
 F: docs/system/target-arm.rst
diff --git a/include/hw/arm/arm-smc.h b/include/hw/arm/arm-smc.h
new file mode 100644
index 0000000000..e27d64218f
--- /dev/null
+++ b/include/hw/arm/arm-smc.h
@@ -0,0 +1,31 @@
+/*
+ * ARM SMC call dispatch
+ *
+ * Board and SoC models can register handlers for vendor or firmware
+ * SMC calling convention function IDs. Under TCG, dispatch follows the
+ * architectural trap checks and precedes exception delivery and QEMU's
+ * PSCI emulation, so firmware services can share the SMC conduit with PSCI.
+ *
+ * Copyright (C) 2026 Process Mission
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_ARM_ARM_SMC_H
+#define HW_ARM_ARM_SMC_H
+
+typedef bool (*ARMSCMCHandler)(const uint64_t args[8], uint64_t *ret,
+                              void *opaque);
+
+/*
+ * Register a handler for one SMCCC function ID.  The handler returns
+ * true when it has handled the call and set *ret. args contains the
+ * caller's x0-x7 or zero-extended r0-r7; the ARM dispatcher writes *ret
+ * to x0/r0 and preserves the other registers. Returns 0 on success and
+ * a negative value if the function ID is already registered.
+ */
+int arm_register_smc_handler(uint64_t func_id, ARMSCMCHandler handler,
+                             void *opaque);
+void arm_unregister_smc_handler(uint64_t func_id, ARMSCMCHandler handler);
+
+#endif /* HW_ARM_ARM_SMC_H */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index f413b15eb7..61645fefa6 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -36,6 +36,7 @@
 #include "cpregs.h"
 #include "target/arm/gtimer.h"
 #include "qemu/plugin.h"
+#include "hw/arm/arm-smc.h"
 
 static void switch_mode(CPUARMState *env, int mode);
 #ifndef CONFIG_USER_ONLY
@@ -9815,6 +9816,78 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
                   new_el, env->pc, pstate_read(env));
 }
 
+typedef struct ARMSCMCHandlerEntry {
+    uint64_t func_id;
+    ARMSCMCHandler handler;
+    void *opaque;
+    QTAILQ_ENTRY(ARMSCMCHandlerEntry) node;
+} ARMSCMCHandlerEntry;
+
+static QTAILQ_HEAD(, ARMSCMCHandlerEntry) arm_smc_handlers =
+    QTAILQ_HEAD_INITIALIZER(arm_smc_handlers);
+
+int arm_register_smc_handler(uint64_t func_id, ARMSCMCHandler handler,
+                             void *opaque)
+{
+    ARMSCMCHandlerEntry *entry;
+
+    QTAILQ_FOREACH(entry, &arm_smc_handlers, node) {
+        if (entry->func_id == func_id) {
+            return -1;
+        }
+    }
+
+    entry = g_new0(ARMSCMCHandlerEntry, 1);
+    entry->func_id = func_id;
+    entry->handler = handler;
+    entry->opaque = opaque;
+    QTAILQ_INSERT_TAIL(&arm_smc_handlers, entry, node);
+
+    return 0;
+}
+
+void arm_unregister_smc_handler(uint64_t func_id, ARMSCMCHandler handler)
+{
+    ARMSCMCHandlerEntry *entry, *next;
+
+    QTAILQ_FOREACH_SAFE(entry, &arm_smc_handlers, node, next) {
+        if (entry->func_id == func_id && entry->handler == handler) {
+            QTAILQ_REMOVE(&arm_smc_handlers, entry, node);
+            g_free(entry);
+            return;
+        }
+    }
+}
+
+bool arm_smc_handle_call(ARMCPU *cpu)
+{
+    CPUARMState *env = &cpu->env;
+    uint64_t func_id = is_a64(env) ? env->xregs[0] : env->regs[0];
+    ARMSCMCHandlerEntry *entry;
+
+    QTAILQ_FOREACH(entry, &arm_smc_handlers, node) {
+        uint64_t args[8], ret;
+
+        if (entry->func_id != func_id) {
+            continue;
+        }
+        for (size_t i = 0; i < ARRAY_SIZE(args); i++) {
+            args[i] = is_a64(env) ? env->xregs[i] : env->regs[i];
+        }
+        if (!entry->handler(args, &ret, entry->opaque)) {
+            return false;
+        }
+        if (is_a64(env)) {
+            env->xregs[0] = ret;
+        } else {
+            env->regs[0] = ret;
+        }
+        return true;
+    }
+
+    return false;
+}
+
 /*
  * Do semihosting call and set the appropriate return value. All the
  * permission and validity checks have been done at translate time.
@@ -9873,6 +9946,13 @@ void arm_cpu_do_interrupt(CPUState *cs)
                       env->exception.syndrome);
     }
 
+    if (tcg_enabled() && cs->exception_index == EXCP_SMC &&
+        arm_smc_handle_call(cpu)) {
+        qemu_log_mask(CPU_LOG_INT, "...handled as SMC handler call\n");
+        qemu_plugin_vcpu_hostcall_cb(cs, last_pc);
+        return;
+    }
+
     if (tcg_enabled() && arm_is_psci_call(cpu, cs->exception_index)) {
         arm_handle_psci_call(cpu);
         qemu_log_mask(CPU_LOG_INT, "...handled as PSCI call\n");
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 033d6d66da..4c6825b201 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -717,6 +717,9 @@ bool arm_is_psci_call(ARMCPU *cpu, int excp_type);
 /* Actually handle a PSCI call */
 void arm_handle_psci_call(ARMCPU *cpu);
 
+/* Dispatch a registered SMC handler call, if any. */
+bool arm_smc_handle_call(ARMCPU *cpu);
+
 /**
  * arm_clear_exclusive: clear the exclusive monitor
  * @env: CPU env
-- 
2.53.0

