Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19023BB9FA
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 03:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783481799; cv=none; b=Eg3PzwhnJd3/nWDTFJKzlaiTKn7/qR/v82mLlCfSSLNoBOJT6DE4GOuXA9FR3+4L8VFrND/JpLqXgz4VwOcxW1n1glp9XVDMZZDo3R0tSplkEjdoVht95JRqFrdYYvdN4U3dY/TdwjY2I18sbHXuQH9W7Qg5ESyPUavfmNhpZJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783481799; c=relaxed/simple;
	bh=VXLfHyJoNIAn0EsJoF8wUoDz0DWD+fShqEOYQdFMdVI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uo3/Fw/9i2OqVe4igRVlxw+az/rDR71f3YIqh9G+vOcTAlB0R80SJ+Y21ZVlWsm59kEEKj3s1K9Xlxe0rxvELEfkDFfomfGbrMQcG9ZzNf6i250w0auk9GC+7XZ/XQTKzr1T6OthSgMLtgaE6ogBLDlyh1X/F9OA9c4FSw1zpEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=stGHTy7F; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="stGHTy7F"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c9aaa90a791so114661a12.3
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 20:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783481796; x=1784086596; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vjX6FO2qO71qG5oypVgq6TFAZybUUZeVcCZBZbkx40Q=;
        b=stGHTy7FXRpI+1a27xbokK8o1QfxRjE4jjATOyewQiDRkDxb2DyJlZWL+cwkhng2fC
         oLSrRRgnZqt4esy+WHD8vv2OO+sqTIMAGK1/4ToxgyxbhC2yMqHgpeQbIp9f4nqW3ipz
         HHMtj6qBcgin54SjQBpxy+QmjZMJLJASQCNGAKTWtZv7vTH78khKU8OnuR01KtL7fqU+
         Vk9Jb7o2CJNU8EMvJjAuBv/QuMudmZ6CSSuSnF1aoWuQo4TzD4TLlm2ZP8A0j1eyiwLV
         8kJWXB9tGUsSWap3Viu3VlF7czNmUWZILlXMK4Qi0f9FzHHfr6d0Oi92//RjxDIF05C1
         ZoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783481796; x=1784086596;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vjX6FO2qO71qG5oypVgq6TFAZybUUZeVcCZBZbkx40Q=;
        b=SS7Qmt8o94UizfjxO9QSkq7ywEM1mu4sTFJXE/jb0/ScRDpHWz+yaTfQgPTM6ykE0P
         U9w+FpcCPGbGYT2z+qJzBRUQK30cqyjyB4y5B16+as3U9Nb/BqLMsxZxDG8AHIIoWJ8l
         14JhPy74OVbZIqOKifChXTsQJh71h3d6abjolNXUFSrOkRgZ+F2gQgI+MPmWZKp8oQth
         dOhj/2EIuVsIPPX6k0Uj6wxeqRrLuFFtjg9k4mkCaNSWjIVkTHIwx67qQcer67r9DXYX
         s8jYeRZ/eGAUrdbVsFVPaHW9T9Y1sBrVY2wfK7COJ0DBZ8TgLWp8ig0du33A+rbhypSQ
         8o5w==
X-Forwarded-Encrypted: i=1; AHgh+RqunMFdQzEBSkPxnIDXoOgRE1RPJglqt4g7IJr/fO/pu98e6W81RPYTyYvJy5bPKcpQvJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu2anHCh/BcK0ifdc0OwCMPKIJ33Q7MrOWMWCWzuiKXhGIhN+X
	4b+rOnhQXnBf6VvFiY8yPkycDOU3rJ9lknW10/CWWNKB6TxBNhOLH9lr
X-Gm-Gg: AfdE7ckc+MzluPzBJYeWZqMT6N5F1+mF7R/XIh1R6Uns3BnFXu7qdyUrrYWN9AMYU5Q
	56vYt11Dw7hQA6GC1oxB9w05aa+k/pym9qOCHGf2Uf7hTYuwlgG6r3ONp8/V6kkzwi41Y7lXWg6
	PBVgRra95lAWUakikuvr23BN0z331133gjwkhLliTsOlbrKB9exP79azI4RI0WBlSe/2RuDpYU8
	4bppR1y6AR6BCE8HRVO6es7eotoiViMMmtvywmIHlTw+gbE0w2+0xrXEyvOhRAe+UKDxXglB8ua
	aZR6VkYQcOe8FoE/N2LDL7GmTj7pX3MTENHcu1CT7whbVIPe9NWRQjoyJZaer/L1Y3aGjE4U4UM
	UdLuSXQlmvBY+Nr0i/CW81FNKbtU9nirf4u3u9MSrkWOld+EC2tZxOoi7ZY7uhBfwHTLMy73r1y
	JF7kouuCSJhUDjOf5qwxzU7IAH3UrQHYfnzAk/I04=
X-Received: by 2002:a05:6a20:da1b:b0:398:c0ba:9ceb with SMTP id adf61e73a8af0-3c0bce1bfa3mr587516637.12.1783481796219;
        Tue, 07 Jul 2026 20:36:36 -0700 (PDT)
Received: from [10.0.0.65] ([2601:647:6700:64d0::94ac])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174accae5sm21092850eec.29.2026.07.07.20.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 20:36:35 -0700 (PDT)
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
Date: Tue, 07 Jul 2026 20:34:33 -0700
Subject: [PATCH v3 10/17] KVM: device: Add test device
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-riscv_insn_table-v3-10-3f8e5f75ba97@gmail.com>
References: <20260707-riscv_insn_table-v3-0-3f8e5f75ba97@gmail.com>
In-Reply-To: <20260707-riscv_insn_table-v3-0-3f8e5f75ba97@gmail.com>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Nam Cao <namcao@linutronix.de>, Alexandre Ghiti <alex@ghiti.fr>, 
 Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
 Conor Dooley <conor@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <radim.krcmar@oss.qualcomm.com>, 
 Jesse Taube <jtaubepe@redhat.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <thecharlesjenkins@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783481777; l=7230;
 i=thecharlesjenkins@gmail.com; s=20260605; h=from:subject:message-id;
 bh=VXLfHyJoNIAn0EsJoF8wUoDz0DWD+fShqEOYQdFMdVI=;
 b=HiyjHCmOOFuKhTpnHcr0UOv2JRep5AtpgV7suEoPPIgEC7r0SF4CptZEPmIjdYOqx6KSnhFpd
 ymlCIrEJ9SSBqIwj99bmiCcu2a4pyKJ9GcZVl9t12uB5OkNXFUeMRY9
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=ajnnRQ98PIdwKp4HeMkq9U32okYbnh6Zb4G3o5XXvkg=

Create a KVM test device to help verify mmio reads and write emulation.
This is a simple device that will store the data in a buffer on writes
and echo back that stored data on a read.

Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
---
 include/uapi/linux/kvm.h |   2 +
 lib/Kconfig.debug        |   6 +++
 virt/kvm/Kconfig.debug   |  16 ++++++++
 virt/kvm/Makefile.kvm    |   1 +
 virt/kvm/kvm_main.c      |   8 ++++
 virt/kvm/mmio_test.c     | 104 +++++++++++++++++++++++++++++++++++++++++++++++
 virt/kvm/mmio_test.h     |  18 ++++++++
 7 files changed, 155 insertions(+)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 6c8afa2047bf..abbbf74627a2 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1235,6 +1235,8 @@ enum kvm_device_type {
 #define KVM_DEV_TYPE_LOONGARCH_DMSINTC	KVM_DEV_TYPE_LOONGARCH_DMSINTC
 	KVM_DEV_TYPE_ARM_VGIC_V5,
 #define KVM_DEV_TYPE_ARM_VGIC_V5	KVM_DEV_TYPE_ARM_VGIC_V5
+	KVM_DEV_TYPE_TEST,
+#define KVM_DEV_TYPE_TEST		KVM_DEV_TYPE_TEST
 
 	KVM_DEV_TYPE_MAX,
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 8ff5adcfe1e0..0d235bdc94ec 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -754,6 +754,12 @@ source "net/Kconfig.debug"
 
 endmenu # "Networking Debugging"
 
+menu "KVM Debugging"
+
+source "virt/kvm/Kconfig.debug"
+
+endmenu # "KVM Debugging"
+
 menu "Memory Debugging"
 
 source "mm/Kconfig.debug"
diff --git a/virt/kvm/Kconfig.debug b/virt/kvm/Kconfig.debug
new file mode 100644
index 000000000000..d9dd326374e0
--- /dev/null
+++ b/virt/kvm/Kconfig.debug
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config KVM_MMIO_TEST
+       bool "Enable kvm mmio testing"
+       depends on KVM
+       depends on KVM_MMIO
+       default n
+       help
+         Enable testing for kvm mmio. This is a test-only mmio device that
+         stores writes in a buffer and returns the buffered data on a read.
+
+         This is useful for testing the kvm mmio emulation code. Enabling
+         this does not run any tests, just builds in the support for the test
+         device into the kernel.
+
+         If unsure, say N.
diff --git a/virt/kvm/Makefile.kvm b/virt/kvm/Makefile.kvm
index d047d4cf58c9..bd4da8c23923 100644
--- a/virt/kvm/Makefile.kvm
+++ b/virt/kvm/Makefile.kvm
@@ -8,6 +8,7 @@ KVM ?= ../../../virt/kvm
 kvm-y := $(KVM)/kvm_main.o $(KVM)/eventfd.o $(KVM)/binary_stats.o
 kvm-$(CONFIG_KVM_VFIO) += $(KVM)/vfio.o
 kvm-$(CONFIG_KVM_MMIO) += $(KVM)/coalesced_mmio.o
+kvm-$(CONFIG_KVM_MMIO_TEST) += $(KVM)/mmio_test.o
 kvm-$(CONFIG_KVM_ASYNC_PF) += $(KVM)/async_pf.o
 kvm-$(CONFIG_HAVE_KVM_IRQ_ROUTING) += $(KVM)/irqchip.o
 kvm-$(CONFIG_HAVE_KVM_DIRTY_RING) += $(KVM)/dirty_ring.o
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 881f92d7a469..42d17dcaf9c9 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -58,6 +58,7 @@
 #include "async_pf.h"
 #include "kvm_mm.h"
 #include "vfio.h"
+#include "mmio_test.h"
 
 #include <trace/events/ipi.h>
 
@@ -6532,6 +6533,10 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 	if (WARN_ON_ONCE(r))
 		goto err_vfio;
 
+	r = kvm_mmio_test_ops_init();
+	if (WARN_ON_ONCE(r))
+		goto err_mmio_test;
+
 	r = kvm_gmem_init(module);
 	if (r)
 		goto err_gmem;
@@ -6557,6 +6562,8 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 err_virt:
 	kvm_gmem_exit();
 err_gmem:
+	kvm_mmio_test_ops_exit();
+err_mmio_test:
 	kvm_vfio_ops_exit();
 err_vfio:
 	kvm_async_pf_deinit();
@@ -6589,6 +6596,7 @@ void kvm_exit(void)
 		free_cpumask_var(per_cpu(cpu_kick_mask, cpu));
 	kmem_cache_destroy(kvm_vcpu_cache);
 	kvm_gmem_exit();
+	kvm_mmio_test_ops_exit();
 	kvm_vfio_ops_exit();
 	kvm_async_pf_deinit();
 	kvm_irqfd_exit();
diff --git a/virt/kvm/mmio_test.c b/virt/kvm/mmio_test.c
new file mode 100644
index 000000000000..bd5f21a43ba8
--- /dev/null
+++ b/virt/kvm/mmio_test.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * mmio_test.c - Kernel module side for testing the KVM riscv mmio functionality.
+ */
+
+#include <linux/kvm_host.h>
+
+#include <kvm/iodev.h>
+#include "mmio_test.h"
+
+struct mmio_test {
+	struct kvm *kvm;
+	struct kvm_io_device dev;
+	unsigned long start;
+	unsigned long size;
+	char cache[16];
+};
+
+static struct mmio_test *kvm_to_mmio_test_dev(const struct kvm_io_device *dev)
+{
+	return container_of(dev, struct mmio_test, dev);
+}
+
+static int mmio_read(struct kvm_vcpu *vcpu, struct kvm_io_device *dev,
+		     gpa_t addr, int len, void *val)
+{
+	struct mmio_test *mmio_test = kvm_to_mmio_test_dev(dev);
+
+	if ((addr - mmio_test->start + len) >= mmio_test->size)
+		return -1;
+
+	/* Write back cached value */
+	memcpy(val, &mmio_test->cache[(addr - mmio_test->start)], len);
+	return 0;
+}
+
+static int mmio_write(struct kvm_vcpu *vcpu, struct kvm_io_device *dev,
+		      gpa_t addr, int len, const void *val)
+{
+	struct mmio_test *mmio_test = kvm_to_mmio_test_dev(dev);
+
+	if ((addr - mmio_test->start + len) >= mmio_test->size)
+		return -1;
+
+	/* Cache value */
+	memcpy(&mmio_test->cache[(addr - mmio_test->start)], val, len);
+	return 0;
+}
+
+static const struct kvm_io_device_ops mmio_ops = {
+	.read = mmio_read,
+	.write = mmio_write,
+};
+
+static int mmio_test_create(struct kvm_device *dev, u32 type)
+{
+	struct mmio_test *mmio_test;
+
+	mmio_test = kzalloc_obj(struct mmio_test, GFP_KERNEL);
+	if (!mmio_test)
+		return -ENOMEM;
+
+	mmio_test->start = 0x20000000;
+	mmio_test->size = 16;
+
+	dev->private = mmio_test;
+
+	kvm_iodevice_init(&mmio_test->dev, &mmio_ops);
+	mutex_lock(&kvm->slots_lock);
+	ret = kvm_io_bus_register_dev(dev->kvm, KVM_MMIO_BUS, mmio_test->start,
+				mmio_test->size, &mmio_test->dev);
+	mutex_unlock(&kvm->slots_lock);
+
+	if (ret < 0)
+		kfree(mmio_test);
+
+	return ret;
+}
+
+static void mmio_test_destroy(struct kvm_device *dev)
+{
+	struct mmio_test *mmio_test = kvm_to_mmio_test_dev(dev);
+
+	kvm_io_bus_unregister_dev(dev->kvm, KVM_MMIO_BUS, &mmio_test->dev);
+	kfree(dev->private);
+	kfree(dev);
+}
+
+struct kvm_device_ops kvm_riscv_mmio_test_device_ops = {
+	.name = "kvm-riscv-mmio_test",
+	.create = mmio_test_create,
+	.destroy = mmio_test_destroy,
+};
+
+int kvm_mmio_test_ops_init(void)
+{
+	return kvm_register_device_ops(&kvm_riscv_mmio_test_device_ops,
+					KVM_DEV_TYPE_TEST);
+}
+
+void kvm_mmio_test_ops_exit(void)
+{
+	kvm_unregister_device_ops(KVM_DEV_TYPE_TEST);
+}
diff --git a/virt/kvm/mmio_test.h b/virt/kvm/mmio_test.h
new file mode 100644
index 000000000000..49a6e900eec9
--- /dev/null
+++ b/virt/kvm/mmio_test.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __KVM_MMIO_TEST_H
+#define __KVM_MMIO_TEST_H
+
+#ifdef CONFIG_KVM_MMIO_TEST
+int kvm_mmio_test_ops_init(void);
+void kvm_mmio_test_ops_exit(void);
+#else
+static inline int kvm_mmio_test_ops_init(void)
+{
+	return 0;
+}
+static inline void kvm_mmio_test_ops_exit(void)
+{
+}
+#endif
+
+#endif

-- 
2.54.0

