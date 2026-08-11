Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA973310645;
	Tue, 11 Aug 2026 01:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786413183; cv=none; b=gF4FqyQnfAX2i3eRVEUnB1dvVUlkRjaBSN1upFjODyUD5CVRCT1QTcc1MBhHx56OPsjBGMvx9HLQUP1jTOEUQaaSpHf1Cp1X0AWscb0aa43R3SR1wzmRYXb18+bbZRzcPTeol5N65xqjv6F9DZSeSf5If80F/sL8HpBTaRcrapU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786413183; c=relaxed/simple;
	bh=3HzGSloaHwdnzgYudZn5YoDKVMeGxd6aw19ukxs2pNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eAapbkAEL7TpDaXTv/Tmp5/Uchki77S9HIigDWxU4ecQZmxhs/meCwM0nMV9SZuNwKeL6ho+AgBQwxuZbKvOEAufInwRVJK5tYcWRBh/qM4l8/qus3pR5vhonp5mqyOFTqBb742THlX3xAyT3Z9HigrDUnREg8qDpsu4USKZw0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nXF7+ZyQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nXF7+ZyQ"
Received: from fedora (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7D8A020B710C;
	Mon, 10 Aug 2026 18:52:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7D8A020B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786413157;
	bh=9NkAdRTD+ZL7dlgrQYyb7R5hRKIetH0WGmfqdzWL6vQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nXF7+ZyQltMxmW0h93FtcC0N/DxiKr1l28/HPIuc7rVfO/l/TZQoD8aYvBc4qHwuC
	 RkB0mGQtnwxMtCHX2rEAdzKCgBwCOtufTlMVj4zJkBYjjGPKbL520rpslRgiaYeBSK
	 E7LmLhkKMOaXqb+Kx2esJgxAGmD2l2QjNLjQBSd8=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 2/8] security/vbs: introduce core VBS framework
Date: Mon, 10 Aug 2026 18:52:37 -0700
Message-ID: <20260811015243.188486-3-snambakam@linux.microsoft.com>
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

Add the transport-agnostic Virtualization-Based Security (VBS) core: a
small dispatch layer between the guest OS (plane-0) and a secure kernel
running in a higher-privileged plane-1.

Backends register a struct vbs_ops via vbs_register_backend(); the core
exposes vbs_available() and a generic vbs_vtl_call() that forwards to the
active backend.  No backend is registered yet.

Gated by CONFIG_VBS (off by default).
---
 include/linux/vbs.h   | 74 +++++++++++++++++++++++++++++++++++++++++++
 security/Kconfig      |  2 ++
 security/Makefile     |  1 +
 security/vbs/Kconfig  | 16 ++++++++++
 security/vbs/Makefile |  3 ++
 security/vbs/core.c   | 56 ++++++++++++++++++++++++++++++++
 6 files changed, 152 insertions(+)
 create mode 100644 include/linux/vbs.h
 create mode 100644 security/vbs/Kconfig
 create mode 100644 security/vbs/Makefile
 create mode 100644 security/vbs/core.c

diff --git a/include/linux/vbs.h b/include/linux/vbs.h
new file mode 100644
index 000000000000..a154396bf070
--- /dev/null
+++ b/include/linux/vbs.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * VBS — Virtualization-Based Security
+ *
+ * Transport-agnostic interface between the guest OS (plane-0) and a secure
+ * kernel running in a higher-privileged plane-1.  The guest kernel calls the
+ * vbs_*() functions; the active backend translates them into the appropriate
+ * transport (e.g. a KVM paravirt hypercall).
+ *
+ * This is the core framework only.  VBS is software-only: backends are
+ * software/hypervisor planes (KVM software planes now, Hyper-V VSM later).
+ * Backends register via vbs_register_backend().
+ */
+
+#ifndef _LINUX_VBS_H
+#define _LINUX_VBS_H
+
+#include <linux/types.h>
+#include <linux/errno.h>
+
+/* VTL-call request codes (plane-0 -> plane-1 direction). */
+enum vbs_call_id {
+	VBS_CALL_INIT		= 0x0001, /* plane-0 boot complete: load plane */
+	VBS_CALL_SHUTDOWN	= 0x0002, /* plane-0 shutting down: unload    */
+};
+
+/**
+ * struct vbs_ops - operations provided by a VBS backend
+ * @name:     backend name, e.g. "kvm-planes"
+ * @init:     load/connect the secure plane; called once after drivers init
+ * @shutdown: unload the secure plane; called on reboot/halt
+ * @vtl_call: send an arbitrary request to the secure kernel and wait for a
+ *            response.  Returns 0 on success, negative errno on failure.
+ *
+ * Callbacks run from process context with preemption enabled.
+ */
+struct vbs_ops {
+	const char *name;
+
+	int (*init)(void);
+	void (*shutdown)(void);
+
+	int (*vtl_call)(enum vbs_call_id id,
+			const void *arg, size_t arg_size,
+			void *resp, size_t resp_size);
+};
+
+#ifdef CONFIG_VBS
+
+/**
+ * vbs_register_backend() - register the platform-specific backend.
+ *
+ * Called once during boot by the platform detection code.  Only one backend
+ * can be active at a time.
+ */
+int vbs_register_backend(const struct vbs_ops *ops);
+
+/** vbs_available() - true if a backend is registered. */
+bool vbs_available(void);
+
+/** vbs_vtl_call() - dispatch a raw VTL call through the active backend. */
+int vbs_vtl_call(enum vbs_call_id id,
+		 const void *arg, size_t arg_size,
+		 void *resp, size_t resp_size);
+
+#else /* !CONFIG_VBS */
+
+static inline bool vbs_available(void) { return false; }
+static inline int vbs_vtl_call(enum vbs_call_id id,
+			       const void *arg, size_t arg_size,
+			       void *resp, size_t resp_size) { return -ENOSYS; }
+
+#endif /* CONFIG_VBS */
+#endif /* _LINUX_VBS_H */
diff --git a/security/Kconfig b/security/Kconfig
index f7bf6cdc6229..31ab9b0fa7d0 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -299,6 +299,8 @@ config SECURITY_COMMONCAP_KUNIT_TEST
 
 	  If unsure, say N.
 
+source "security/vbs/Kconfig"
+
 source "security/Kconfig.hardening"
 
 endmenu
diff --git a/security/Makefile b/security/Makefile
index 4601230ba442..80214c702ddc 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_CGROUPS)			+= device_cgroup.o
 obj-$(CONFIG_BPF_LSM)			+= bpf/
 obj-$(CONFIG_SECURITY_LANDLOCK)		+= landlock/
 obj-$(CONFIG_SECURITY_IPE)		+= ipe/
+obj-$(CONFIG_VBS)			+= vbs/
 
 # Object integrity file lists
 obj-$(CONFIG_INTEGRITY)			+= integrity/
diff --git a/security/vbs/Kconfig b/security/vbs/Kconfig
new file mode 100644
index 000000000000..0e482196c5b7
--- /dev/null
+++ b/security/vbs/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config VBS
+	bool "Virtualization-Based Security (VBS) support"
+	depends on X86_64
+	help
+	  Enable a transport-agnostic interface between the guest OS
+	  (plane-0) and a secure kernel running in a higher-privileged
+	  plane-1.
+
+	  The core VBS layer dispatches calls from kernel subsystems to a
+	  platform-specific backend.  VBS is software-only: backends are
+	  software/hypervisor planes (KVM software planes now, Hyper-V VSM
+	  later).  Hardware confidential-compute is out of scope.
+
+	  If unsure, say N.
diff --git a/security/vbs/Makefile b/security/vbs/Makefile
new file mode 100644
index 000000000000..952c2b855465
--- /dev/null
+++ b/security/vbs/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_VBS) += vbs.o
+vbs-y := core.o
diff --git a/security/vbs/core.c b/security/vbs/core.c
new file mode 100644
index 000000000000..407d49a91b8f
--- /dev/null
+++ b/security/vbs/core.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * VBS — Virtualization-Based Security core
+ *
+ * Dispatches calls from guest kernel subsystems to the active
+ * platform-specific backend.
+ */
+
+#include <linux/vbs.h>
+#include <linux/export.h>
+#include <linux/mutex.h>
+#include <linux/printk.h>
+
+static const struct vbs_ops *vbs_backend;
+static DEFINE_MUTEX(vbs_lock);
+
+int vbs_register_backend(const struct vbs_ops *ops)
+{
+	int ret = 0;
+
+	if (!ops || !ops->name)
+		return -EINVAL;
+
+	mutex_lock(&vbs_lock);
+	if (vbs_backend) {
+		pr_err("vbs: backend \"%s\" already registered, rejecting \"%s\"\n",
+		       vbs_backend->name, ops->name);
+		ret = -EBUSY;
+	} else {
+		vbs_backend = ops;
+		pr_info("vbs: registered backend \"%s\"\n", ops->name);
+	}
+	mutex_unlock(&vbs_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(vbs_register_backend);
+
+bool vbs_available(void)
+{
+	return READ_ONCE(vbs_backend) != NULL;
+}
+EXPORT_SYMBOL_GPL(vbs_available);
+
+int vbs_vtl_call(enum vbs_call_id id,
+		 const void *arg, size_t arg_size,
+		 void *resp, size_t resp_size)
+{
+	const struct vbs_ops *ops = READ_ONCE(vbs_backend);
+
+	if (!ops)
+		return -ENODEV;
+	if (!ops->vtl_call)
+		return -EOPNOTSUPP;
+	return ops->vtl_call(id, arg, arg_size, resp, resp_size);
+}
+EXPORT_SYMBOL_GPL(vbs_vtl_call);
-- 
2.55.0

