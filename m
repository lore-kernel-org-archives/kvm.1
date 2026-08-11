Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E79D383990;
	Tue, 11 Aug 2026 01:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786413183; cv=none; b=iaSf3HNFO6GqGGAJ1CLj7YPK77Cd+xY8NPPs3uNzr5A3gwsYLurHrWuWUiR2Kx9fKU7Vc3ykSZMshVNvmRch3VrAD5PwJPWHpk1ET7es0mJlOsapxJ5PSEyfG1dB3CGhNqMF2+9gm/kA9rnZQF6/e91XWN0/ssBDxZV+CipIj24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786413183; c=relaxed/simple;
	bh=0l9DIclTDpXjx3i1cFtpMSQFaXHSkKJlPuMUCa1YKdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SrcHS9rWbieKgkZYNHjqo58D9QmGM/qeF8xA0njZHJ5g6beITJY4tcpBy1BOVydojl4MP/7Y/LgN6HIDhATqIQYhoLqM4YuFSX98A8OLF3ul+m2NCpgZWcyCAVCWgOZArqOFvWZO64mF4VO3l0MyKJZZDbTSKLEcyc8NEhaSElw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=K8ExAJ9U; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="K8ExAJ9U"
Received: from fedora (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4F8BC20B7128;
	Mon, 10 Aug 2026 18:52:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4F8BC20B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786413158;
	bh=Zgh5bRf8sGih4Q3VLyYalBD7y3hgzGAu3FT1cCAe5KM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K8ExAJ9UjnFqM2lA9OAa5e6/rj2Bk3keq1jcArtvwc9HueoS2fV3sBB2aNvbbj6vJ
	 n9mKi6BVxJK1LWCCi70BUKIjtuKJme1vtrsCWWffGx4+x9WJsF3bSK77nEXEhQo2TO
	 SUUJL8Z2NCvFQlR6LH2Vkuy8CoInRNmIibAgLdEY=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 3/8] security/vbs: add platform probe and backend registration
Date: Mon, 10 Aug 2026 18:52:38 -0700
Message-ID: <20260811015243.188486-4-snambakam@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811015243.188486-1-snambakam@linux.microsoft.com>
References: <20260811015243.188486-1-snambakam@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a single rootfs_initcall that walks a probe table and registers the
first backend whose detect() succeeds.  The table currently holds only the
KVM software-planes entry; when that backend is not configured a local stub
keeps the probe self-contained and buildable.

Registration only records the backend at this stage.
---
 security/vbs/Makefile   |  4 ++-
 security/vbs/internal.h | 20 ++++++++++++++
 security/vbs/probe.c    | 61 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+), 1 deletion(-)
 create mode 100644 security/vbs/internal.h
 create mode 100644 security/vbs/probe.c

diff --git a/security/vbs/Makefile b/security/vbs/Makefile
index 952c2b855465..0fcbb6640ec1 100644
--- a/security/vbs/Makefile
+++ b/security/vbs/Makefile
@@ -1,3 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_VBS) += vbs.o
-vbs-y := core.o
+# probe.o links before core.o so the backend is registered (vbs_probe_init)
+# early in the rootfs_initcall level.
+vbs-y := probe.o core.o
diff --git a/security/vbs/internal.h b/security/vbs/internal.h
new file mode 100644
index 000000000000..2f444781b390
--- /dev/null
+++ b/security/vbs/internal.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * VBS internal header — shared between probe.c and backend implementations.
+ */
+#ifndef _SECURITY_VBS_INTERNAL_H
+#define _SECURITY_VBS_INTERNAL_H
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/printk.h>
+#include <linux/vbs.h>
+
+/* Each backend exports a detect + get_ops pair for the centralized probe. */
+
+#ifdef CONFIG_VBS_KVM_PLANES
+bool __init vbs_kvm_planes_detect(void);
+const struct vbs_ops *vbs_kvm_planes_get_ops(void);
+#endif
+
+#endif /* _SECURITY_VBS_INTERNAL_H */
diff --git a/security/vbs/probe.c b/security/vbs/probe.c
new file mode 100644
index 000000000000..ccaaba93b18b
--- /dev/null
+++ b/security/vbs/probe.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * VBS platform detection and backend selection
+ *
+ * A single boot-time initcall probes the platform and registers the
+ * appropriate VBS backend.  Only one backend can be active; the first
+ * successful probe wins.  VBS is software-only: the only backend today is
+ * KVM software planes; other software backends (e.g. Hyper-V VSM) may be
+ * added later.
+ */
+
+#include "internal.h"
+
+/* Stub for the backend when it is not configured in. */
+#ifndef CONFIG_VBS_KVM_PLANES
+static inline bool vbs_kvm_planes_detect(void) { return false; }
+static inline const struct vbs_ops *vbs_kvm_planes_get_ops(void) { return NULL; }
+#endif
+
+struct vbs_probe_entry {
+	const char *name;
+	bool (*detect)(void);
+	const struct vbs_ops *(*get_ops)(void);
+};
+
+static const struct vbs_probe_entry vbs_probe_table[] __initconst = {
+	{ "KVM planes", vbs_kvm_planes_detect, vbs_kvm_planes_get_ops },
+};
+
+static int __init vbs_probe_init(void)
+{
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(vbs_probe_table); i++) {
+		const struct vbs_probe_entry *e = &vbs_probe_table[i];
+
+		if (!e->detect())
+			continue;
+
+		pr_info("vbs: detected %s platform\n", e->name);
+
+		ret = vbs_register_backend(e->get_ops());
+		if (ret) {
+			pr_err("vbs: failed to register %s backend (%d)\n",
+			       e->name, ret);
+			return ret;
+		}
+		return 0;
+	}
+
+	pr_debug("vbs: no supported platform detected\n");
+	return 0;
+}
+
+/*
+ * Run at rootfs_initcall level: platform detection is complete and the VM
+ * planes have been set up (init/ links before security/), but subsystems
+ * that consume VBS have not yet started.  Registration only records the
+ * backend; the plane is loaded later, after device drivers initialise.
+ */
+rootfs_initcall(vbs_probe_init);
-- 
2.55.0

