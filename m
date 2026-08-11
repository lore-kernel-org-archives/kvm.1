Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147A53921D6;
	Tue, 11 Aug 2026 01:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786413185; cv=none; b=RGOrgkF97+eGXcmmlebp8BKhbXnDMC/4MmnMJUYCQxOlDEHGM/EDtggphMbuQMgUOuYyU2NY8u+U7N0OS32cImBnOIbXDt+d5rgAUhFWw9XpG6YRGldykiYw+nGJ0AOrUjI84N8FYnLVofNp0FmAmBsy7rmMrsG2rLfx1TC5+bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786413185; c=relaxed/simple;
	bh=3IAelxGwB9DPSAJL7/G76sGbJjTkykEJaZ67McK3h4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G4UmAIYuPc78cItKIYNBFcdTdbWJaEx5O6vwLYIYFWgME7dd/cCTmtSo5ARKmS8+v9Fdgh5rm1F3Ad50rNl+JLHexH9O+KYhVORPRnwYvEu8AS1tR8Mz8Tab2fX7lm2x6mglkSSAy2ygNZ+YEnOY8QJZPSi1ZesqpFs8ivwAT0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HBU9hAQE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HBU9hAQE"
Received: from fedora (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id D490220B7168;
	Mon, 10 Aug 2026 18:52:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D490220B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786413159;
	bh=iJvMXxgvjmbLh1wHtZxpYG68qJFVjlcVsr0dm5cygfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HBU9hAQESeezbGP5swV3Z8I2FAlw9LGq824dQdTdizIIvP9XNYmRQg3FrVlWM3MMv
	 KCz8k8aXbinQs2t4YtJsANlJOMoI58IO3nt2FzSJ1VYsUp7L3xDsqkD6N4jux3P+Wp
	 dcaTE5Tpdljt60PUYac0FywoJljvMjQYZ/oMSJCY=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 5/8] security/vbs: enable the backend after driver init
Date: Mon, 10 Aug 2026 18:52:40 -0700
Message-ID: <20260811015243.188486-6-snambakam@linux.microsoft.com>
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

Activate a registered VBS backend from a late_initcall, once plane-0 is
otherwise up.  Enabling is opt-in and requires two conditions:

  1. the operator passes enable-kvm-planes=1 on the kernel command line, and
  2. the boot image advertises a provisioned secure plane via
     /etc/Kconfig.kvm-planes containing CONFIG_VM_PLANES=y.

When both hold, call the backend's init() to load the secure plane and
register a reboot notifier that invokes shutdown() to unload it.
---
 security/vbs/core.c | 114 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/security/vbs/core.c b/security/vbs/core.c
index 407d49a91b8f..c006b6d53a14 100644
--- a/security/vbs/core.c
+++ b/security/vbs/core.c
@@ -8,8 +8,15 @@
 
 #include <linux/vbs.h>
 #include <linux/export.h>
+#include <linux/init.h>
+#include <linux/kernel_read_file.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/printk.h>
+#include <linux/reboot.h>
+#include <linux/sizes.h>
+#include <linux/string.h>
+#include <linux/vmalloc.h>
 
 static const struct vbs_ops *vbs_backend;
 static DEFINE_MUTEX(vbs_lock);
@@ -54,3 +61,110 @@ int vbs_vtl_call(enum vbs_call_id id,
 	return ops->vtl_call(id, arg, arg_size, resp, resp_size);
 }
 EXPORT_SYMBOL_GPL(vbs_vtl_call);
+
+/* ── enable after driver init ────────────────────────────────── */
+
+/*
+ * A registered backend is only activated when two conditions hold:
+ *   1. the operator opts in on the kernel command line (enable-kvm-planes=1),
+ *      and
+ *   2. the boot image advertises a provisioned secure plane via a plane
+ *      configuration file that enables the expected option.
+ */
+#define VBS_KCONFIG_PATH	"/etc/Kconfig.kvm-planes"
+#define VBS_KCONFIG_TOKEN	"CONFIG_VM_PLANES=y"
+
+static bool vbs_enable_requested;
+
+static int __init vbs_parse_enable_kvm_planes(char *str)
+{
+	bool val;
+
+	/* Bare "enable-kvm-planes" (no value) means enabled. */
+	if (!str || !*str)
+		vbs_enable_requested = true;
+	else if (!kstrtobool(str, &val))
+		vbs_enable_requested = val;
+	return 0;
+}
+early_param("enable-kvm-planes", vbs_parse_enable_kvm_planes);
+
+static int vbs_reboot_notify(struct notifier_block *nb, unsigned long action,
+			     void *data)
+{
+	const struct vbs_ops *ops = READ_ONCE(vbs_backend);
+
+	if (ops && ops->shutdown)
+		ops->shutdown();
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block vbs_reboot_nb = {
+	.notifier_call = vbs_reboot_notify,
+};
+
+/* Return true if VBS_KCONFIG_PATH exists and enables the plane config. */
+static bool __init vbs_plane_config_present(void)
+{
+	void *buf = NULL;
+	size_t sz = 0;
+	bool ok = false;
+	int ret;
+
+	ret = kernel_read_file_from_path(VBS_KCONFIG_PATH, 0, &buf, SZ_1M, &sz,
+					 READING_UNKNOWN);
+	if (ret < 0) {
+		pr_info("vbs: %s unavailable (%d); backend left idle\n",
+			VBS_KCONFIG_PATH, ret);
+		return false;
+	}
+
+	if (buf && sz)
+		ok = strnstr(buf, VBS_KCONFIG_TOKEN, sz) != NULL;
+	vfree(buf);
+
+	if (!ok)
+		pr_info("vbs: %s present but %s not set; backend left idle\n",
+			VBS_KCONFIG_PATH, VBS_KCONFIG_TOKEN);
+	return ok;
+}
+
+/*
+ * Enable the registered backend after device drivers have initialised.
+ * Runs at late_initcall so the plane is loaded only once the plane-0 kernel
+ * is otherwise up, the operator requested it (enable-kvm-planes=1), and the
+ * boot image advertises a plane config.
+ */
+static int __init vbs_enable(void)
+{
+	const struct vbs_ops *ops = READ_ONCE(vbs_backend);
+	int ret;
+
+	if (!ops) {
+		pr_debug("vbs: no backend registered; nothing to enable\n");
+		return 0;
+	}
+
+	if (!vbs_enable_requested) {
+		pr_info("vbs: enable-kvm-planes not set; backend \"%s\" left idle\n",
+			ops->name);
+		return 0;
+	}
+
+	if (!vbs_plane_config_present())
+		return 0;
+
+	if (ops->init) {
+		ret = ops->init();
+		if (ret) {
+			pr_warn("vbs: backend \"%s\" init failed (%d)\n",
+				ops->name, ret);
+			return 0;
+		}
+	}
+
+	register_reboot_notifier(&vbs_reboot_nb);
+	pr_info("vbs: enabled backend \"%s\"\n", ops->name);
+	return 0;
+}
+late_initcall(vbs_enable);
-- 
2.55.0

