Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE1C4963A9
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784042118; cv=none; b=OK7VKOzLWGSI+RLSrGe2/xU5fv13OZ7OX8lq3EAZctfpRTDcSyZbtMIIbQqyd/DplJuypT6qYGau5R/jiDskPBSpFLcFfC6+C/fjuGd8WyUg5Fguj6kVeKWJymOXkCHKtTEDlQZrvMX9gwJ4nr3/uNj8aaqyAJ2WR08/P1aTdeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784042118; c=relaxed/simple;
	bh=CA6HRFl1VzcHVdZ+8FD2TBs4Cp5+Gp7/yga7JFoATG0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G9lLf+JZ3y9B5UrAHrbxx4SQN6q4uY5qiwot/JXSD67Juuu3nxOG36cgOSQWtwmDbbmQYZ98b8c0zAW8Xh62CDPgbiku3qlFYhxhKCkhHQCxIjVXllSYGBMOGIfSVaHfTqsa1PZhIbHUL5qSxwQp3Gsu9VOBb7O84pctucomJ/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sLO1mFtg; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sLO1mFtg"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8894570b58so949012a12.3
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 08:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784042115; x=1784646915; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cbe+Pbv5TCQdXk1eG0Iq+EuxqrVwsKywg3T3pq48EEY=;
        b=sLO1mFtgn14IfUtBS7RJRq3tWuGYgZ4CzllUakdX+CWHHrVohLRBEGkrZPBSBYxo87
         KdUhXMAPkkA6i/ZP30DRZogbOCAMBz7myhftxnIOykgoKXVLZt4I70llwKxOa12VTCMb
         xswe6VUnF6+U4iJV2KjJiJEvBq0hkaZnKZIvJIqLV/YmDCdZRg6c45b7Vt90oDh4gWU8
         d2jLf+Vj7SwKk6v+Vo5gISqn4phaSKs7aCiHuE9whn9c4l3kVI13pNRf1X7M01F9M7kJ
         0SKhqeZfg8m/eXRlB5KBiY3GW8+cYcRYh4LgCeNQHJ8Id4wpxOXs1vYsbMmlmRIYT7Iw
         JgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784042115; x=1784646915;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cbe+Pbv5TCQdXk1eG0Iq+EuxqrVwsKywg3T3pq48EEY=;
        b=WNmySPpf1GclnAXQgN44uRbXHSARS1RRilKsmdMAZe+/tZLx8LJNczp56DQypU9eLo
         h5aKN/YwOfVqNidaVdYKol7jwEUFUME4/Lv8bIg39SF31HJLka2qTPnGYvGD+23nwMWy
         6T/8HhfhEIxUi+IJQAwCI2JJDocJWVT5CM8M0boT7M94+pB1S5Yaev6j69woPo7pUM1v
         RKfYWE9SLm8riFOHNEbIZaEWbOA1qq1MiYc4X6Cy77njvVy2rY6slFk4e4M//88iJq5L
         Jk4PTx63fhY12KeZQKzwOhLHhp/9azY1uiRtFQTm8rMF/kEhzChemGlgICdqTNvayN0n
         CDFg==
X-Forwarded-Encrypted: i=1; AHgh+Rr/mvy2uCPi8HqiMQR+wXbx4JeSdax96KmPu5Wpxu7wX7nk1c3AFLO90a9eN/pIhdFlL7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw12oe7gZRc3/k79aYX1Nay8zWbnL4Q69tonJSwXn8TnwIPOfvN
	Z0LLf8Lg6KhYZ2tzFftW8bf0oJkqmqS+OxxmEmXnW4NrC3BwisovpVYvcuUG8VTDm7qBWogx45R
	KEKYvL+QiAw==
X-Received: from pgj187.prod.google.com ([2002:a63:9c4:0:b0:c92:460e:4f54])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:728c:b0:39f:a8fb:3354
 with SMTP id adf61e73a8af0-3c1108b5a4bmr12826055637.17.1784042114667; Tue, 14
 Jul 2026 08:15:14 -0700 (PDT)
Date: Tue, 14 Jul 2026 08:14:50 -0700
In-Reply-To: <20260714151505.3466855-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714151505.3466855-1-vipinsh@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260714151505.3466855-6-vipinsh@google.com>
Subject: [PATCH v5 05/20] vfio/pci: Register a file handler with Live Update Orchestrator
From: Vipin Sharma <vipinsh@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rientjes@google.com, rodrigo.vivi@intel.com, 
	rppt@kernel.org, saeedm@nvidia.com, schnelle@linux.ibm.com, 
	skhan@linuxfoundation.org, skhawaja@google.com, vipinsh@google.com, 
	vivek.kasireddy@intel.com, witu@nvidia.com, yanjun.zhu@linux.dev, 
	yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"

Register a live update file handler for vfio-pci device files. Add stub
implementations of all required callbacks so that registration does not
fail (i.e. to avoid breaking git-bisect). Register it with both live
update framework and PCI subsystem.

This file handler will be extended in subsequent commits to enable a
device bound to vfio-pci to run without interruption while the host is
going through a kexec Live Update.

Put this support behind a new Kconfig VFIO_PCI_LIVEUPDATE that is marked
experimental and default-disabled until more of the device preservation
support has landed in the kernel.

Co-developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 MAINTAINERS                            |  1 +
 drivers/vfio/pci/Kconfig               | 12 ++++
 drivers/vfio/pci/Makefile              |  1 +
 drivers/vfio/pci/vfio_pci.c            | 11 +++-
 drivers/vfio/pci/vfio_pci_liveupdate.c | 80 ++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_priv.h       | 14 +++++
 include/linux/kho/abi/vfio_pci.h       | 28 +++++++++
 7 files changed, 146 insertions(+), 1 deletion(-)
 create mode 100644 drivers/vfio/pci/vfio_pci_liveupdate.c
 create mode 100644 include/linux/kho/abi/vfio_pci.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 347c435ca404..77a35742de0a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28329,6 +28329,7 @@ F:	Documentation/ABI/testing/debugfs-vfio
 F:	Documentation/ABI/testing/sysfs-devices-vfio-dev
 F:	Documentation/driver-api/vfio.rst
 F:	drivers/vfio/
+F:	include/linux/kho/abi/vfio_pci.h
 F:	include/linux/vfio.h
 F:	include/linux/vfio_pci_core.h
 F:	include/uapi/linux/vfio.h
diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
index 296bf01e185e..c12d614fc6c4 100644
--- a/drivers/vfio/pci/Kconfig
+++ b/drivers/vfio/pci/Kconfig
@@ -42,6 +42,18 @@ config VFIO_PCI_IGD
 	  and LPC bridge config space.
 
 	  To enable Intel IGD assignment through vfio-pci, say Y.
+
+config VFIO_PCI_LIVEUPDATE
+	bool "VFIO PCI support for Live Update (EXPERIMENTAL)"
+	depends on PCI_LIVEUPDATE
+	help
+	  Support for preserving devices bound to vfio-pci across a Live
+	  Update. This option should only be enabled by developers working on
+	  implementing this support. Once enough support has landed in the
+	  kernel, this option will no longer be marked EXPERIMENTAL.
+
+	  If you don't know what to do here, say N.
+
 endif
 
 config VFIO_PCI_ZDEV_KVM
diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
index 6138f1bf241d..bf296ab1c967 100644
--- a/drivers/vfio/pci/Makefile
+++ b/drivers/vfio/pci/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_VFIO_PCI_CORE) += vfio-pci-core.o
 
 vfio-pci-y := vfio_pci.o
 vfio-pci-$(CONFIG_VFIO_PCI_IGD) += vfio_pci_igd.o
+vfio-pci-$(CONFIG_VFIO_PCI_LIVEUPDATE) += vfio_pci_liveupdate.o
 obj-$(CONFIG_VFIO_PCI) += vfio-pci.o
 
 obj-$(CONFIG_MLX5_VFIO_PCI)           += mlx5/
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 1fb4b276afe7..439d14d79d8f 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -264,10 +264,14 @@ static int __init vfio_pci_init(void)
 
 	vfio_pci_core_set_params(nointxmask, is_disable_vga, disable_idle_d3);
 
+	ret = vfio_pci_liveupdate_init();
+	if (ret)
+		return ret;
+
 	/* Register and scan for devices */
 	ret = pci_register_driver(&vfio_pci_driver);
 	if (ret)
-		return ret;
+		goto err_liveupdate_cleanup;
 
 	vfio_pci_fill_ids();
 
@@ -275,12 +279,17 @@ static int __init vfio_pci_init(void)
 		pr_warn("device denylist disabled.\n");
 
 	return 0;
+
+err_liveupdate_cleanup:
+	vfio_pci_liveupdate_cleanup();
+	return ret;
 }
 module_init(vfio_pci_init);
 
 static void __exit vfio_pci_cleanup(void)
 {
 	pci_unregister_driver(&vfio_pci_driver);
+	vfio_pci_liveupdate_cleanup();
 }
 module_exit(vfio_pci_cleanup);
 
diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
new file mode 100644
index 000000000000..803528c9f1b2
--- /dev/null
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2026, Google LLC.
+ * Vipin Sharma <vipinsh@google.com>
+ * David Matlack <dmatlack@google.com>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/errno.h>
+#include <linux/kho/abi/vfio_pci.h>
+#include <linux/liveupdate.h>
+#include <linux/module.h>
+
+#include "vfio_pci_priv.h"
+
+static bool vfio_pci_liveupdate_can_preserve(struct liveupdate_file_handler *handler,
+					     struct file *file)
+{
+	return false;
+}
+
+static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
+{
+	return -EOPNOTSUPP;
+}
+
+static void vfio_pci_liveupdate_unpreserve(struct liveupdate_file_op_args *args)
+{
+}
+
+static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *args)
+{
+	return -EOPNOTSUPP;
+}
+
+static void vfio_pci_liveupdate_finish(struct liveupdate_file_op_args *args)
+{
+}
+
+static const struct liveupdate_file_ops vfio_pci_liveupdate_file_ops = {
+	.can_preserve = vfio_pci_liveupdate_can_preserve,
+	.preserve = vfio_pci_liveupdate_preserve,
+	.unpreserve = vfio_pci_liveupdate_unpreserve,
+	.retrieve = vfio_pci_liveupdate_retrieve,
+	.finish = vfio_pci_liveupdate_finish,
+	.owner = THIS_MODULE,
+};
+
+static struct liveupdate_file_handler vfio_pci_liveupdate_fh = {
+	.ops = &vfio_pci_liveupdate_file_ops,
+	.compatible = VFIO_PCI_LUO_FH_COMPATIBLE,
+};
+
+int __init vfio_pci_liveupdate_init(void)
+{
+	int ret;
+
+	ret = liveupdate_register_file_handler(&vfio_pci_liveupdate_fh);
+	if (ret)
+		goto err_return;
+
+	ret = pci_liveupdate_register_flb(&vfio_pci_liveupdate_fh);
+	if (ret)
+		goto err_unregister;
+
+	return 0;
+
+err_unregister:
+	liveupdate_unregister_file_handler(&vfio_pci_liveupdate_fh);
+err_return:
+	return (ret == -EOPNOTSUPP) ? 0 : ret;
+}
+
+void vfio_pci_liveupdate_cleanup(void)
+{
+	pci_liveupdate_unregister_flb(&vfio_pci_liveupdate_fh);
+	liveupdate_unregister_file_handler(&vfio_pci_liveupdate_fh);
+}
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 85bc1666cb0e..5d2ad128523d 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -142,4 +142,18 @@ static inline void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev,
 }
 #endif
 
+#ifdef CONFIG_VFIO_PCI_LIVEUPDATE
+int __init vfio_pci_liveupdate_init(void);
+void vfio_pci_liveupdate_cleanup(void);
+#else
+static inline int vfio_pci_liveupdate_init(void)
+{
+	return 0;
+}
+
+static inline void vfio_pci_liveupdate_cleanup(void)
+{
+}
+#endif /* CONFIG_VFIO_PCI_LIVEUPDATE */
+
 #endif
diff --git a/include/linux/kho/abi/vfio_pci.h b/include/linux/kho/abi/vfio_pci.h
new file mode 100644
index 000000000000..67e8199eec59
--- /dev/null
+++ b/include/linux/kho/abi/vfio_pci.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (c) 2026, Google LLC.
+ * Vipin Sharma <vipinsh@google.com>
+ * David Matlack <dmatlack@google.com>
+ */
+
+#ifndef _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H
+#define _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H
+
+/**
+ * DOC: VFIO PCI Live Update ABI
+ *
+ * VFIO uses the ABI defined below for preserving device files across a kexec
+ * reboot using LUO.
+ *
+ * Device metadata is serialized into memory which is then handed to the next
+ * kernel via KHO.
+ *
+ * This interface is a contract. Any modification to any of the serialization
+ * structs defined here constitutes a breaking change. Such changes require
+ * incrementing the version number in the VFIO_PCI_LUO_FH_COMPATIBLE string.
+ */
+
+#define VFIO_PCI_LUO_FH_COMPATIBLE "vfio-pci-v1"
+
+#endif /* _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H */
-- 
2.55.0.795.g602f6c329a-goog

