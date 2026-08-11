Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9634E39099C;
	Tue, 11 Aug 2026 01:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786413185; cv=none; b=mT1y5xDx2cPEJxl5kU9q8sQ6lwkYep/3BUsTt4DNpJN6pIORT/JiFB9/zlCoEvLrBXsTf9fmYAcVhagwpq6ASCXQdDXD00LxlSfMuDHFnGFDYdOu/Ee8IWq/ZINlOpb1Tp8AkLkmKtT9i5ANtB3JYGVHFa6G23O0MER03Ivq1sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786413185; c=relaxed/simple;
	bh=PYYhG6O67cZx5HWElLWmRoe/kV+A1dDZB69Ko8VDD5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oHLTttsQ5ShW7/9QrmFIPijP+PaAJbPrsRcX5yaTliEFzCF6F5emHixJO06D7gDflhs/+T0Wq5393ZBJL9N4okAB3TyxMtcpgrNKdZoQfvwYTzHylbJgHGoHBOGwqamJAZDuyS4l5ptFclzz48ZbwWCca8mVoDmmjdTZJxUv324=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Po8uoG/X; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Po8uoG/X"
Received: from fedora (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id CF0B320B7167;
	Mon, 10 Aug 2026 18:52:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CF0B320B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786413158;
	bh=gCrdw1OtMtYEvetubz01UCuisBvUuvkH+1QHdHeTasU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Po8uoG/XE56sy0794KZMPXdih7tk1/FXCVjB7lFGtXMEabeLta22pdFvwRXqX80W6
	 z+LgYKjyL2Uz0noqjkSrM6n1typrBYtCN6+736IZnJm8+m/aZ4olmZz9TZn0CKFSg2
	 6Sa08H7YVY5cuQBvnDDSaWzykHsRE6gdr6Vm0kT8=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 4/8] security/vbs: add KVM software planes backend
Date: Mon, 10 Aug 2026 18:52:39 -0700
Message-ID: <20260811015243.188486-5-snambakam@linux.microsoft.com>
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

Add the KVM software-planes VBS backend.  It uses a synchronous
shared-memory calling area and the KVM_HC_VBS_VTL_CALL paravirt hypercall
(handled by the host) to reach plane-1.

Only the plane lifecycle is implemented: init() allocates the calling
area and issues VBS_CALL_INIT to load (connect to) the secure plane;
shutdown() issues VBS_CALL_SHUTDOWN to unload it.  The BSP-pinned
work_on_cpu() ensures the plane switch always lands on CPU0.

Gated by CONFIG_VBS_KVM_PLANES.
---
 security/vbs/Kconfig      |  15 ++++
 security/vbs/Makefile     |   2 +
 security/vbs/kvm_planes.c | 177 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 194 insertions(+)
 create mode 100644 security/vbs/kvm_planes.c

diff --git a/security/vbs/Kconfig b/security/vbs/Kconfig
index 0e482196c5b7..e21f4f30b6cf 100644
--- a/security/vbs/Kconfig
+++ b/security/vbs/Kconfig
@@ -14,3 +14,18 @@ config VBS
 	  later).  Hardware confidential-compute is out of scope.
 
 	  If unsure, say N.
+
+config VBS_KVM_PLANES
+	bool "VBS backend: KVM software planes"
+	depends on VBS && KVM_GUEST
+	help
+	  VBS backend that uses a KVM paravirt hypercall to communicate
+	  between plane-0 (the normal guest kernel) and plane-1 (a secure
+	  kernel running in a separate KVM VM plane managed by QEMU).
+
+	  This minimal backend supports loading (connecting to) and
+	  unloading the secure plane via a shared-memory calling area.
+
+	  Select this if you are running under KVM with VM planes support.
+
+	  If unsure, say N.
diff --git a/security/vbs/Makefile b/security/vbs/Makefile
index 0fcbb6640ec1..3a161e7cc279 100644
--- a/security/vbs/Makefile
+++ b/security/vbs/Makefile
@@ -3,3 +3,5 @@ obj-$(CONFIG_VBS) += vbs.o
 # probe.o links before core.o so the backend is registered (vbs_probe_init)
 # early in the rootfs_initcall level.
 vbs-y := probe.o core.o
+
+obj-$(CONFIG_VBS_KVM_PLANES)	+= kvm_planes.o
diff --git a/security/vbs/kvm_planes.c b/security/vbs/kvm_planes.c
new file mode 100644
index 000000000000..af9118c6e74f
--- /dev/null
+++ b/security/vbs/kvm_planes.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * VBS backend — KVM software planes
+ *
+ * Uses a KVM paravirt hypercall to communicate between plane-0 (the normal
+ * guest kernel) and plane-1 (a secure kernel running in a separate KVM plane
+ * managed by QEMU).
+ *
+ * Transport: kvm_hypercall1(KVM_HC_VBS_VTL_CALL, gpa) -> KVM_EXIT_HYPERCALL.
+ *
+ * The shared-memory VTL-call protocol is synchronous:
+ *   1. Plane-0 fills the request buffer in the shared calling area.
+ *   2. Plane-0 issues the hypercall carrying the physical address of the area.
+ *   3. Plane-1 processes the request and writes a response.
+ *   4. Plane-0 reads the response from the same page.
+ *
+ * This minimal backend implements only the plane lifecycle: init() loads
+ * (connects to) the secure plane, shutdown() unloads it.
+ */
+
+#include "internal.h"
+
+#include <linux/mm.h>
+#include <linux/gfp.h>
+#include <linux/io.h>
+#include <linux/string.h>
+#include <linux/workqueue.h>
+#include <linux/kvm_para.h>
+#include <asm/kvm_para.h>
+
+/* ── shared-memory calling area ────────────────────────────────────────── */
+
+/*
+ * Single shared page used for both request and response data.  The protocol
+ * is synchronous, so no concurrent access is possible.
+ *
+ * Layout (within one 4 KiB page):
+ *   [ call_pending | call_id | status | arg_size | resp_size | buffer ]
+ */
+struct vbs_kvm_ca {
+	__u8	call_pending;	/* 1 while call is in flight            */
+	__u8	rsvd[3];
+	__u32	call_id;	/* enum vbs_call_id (set by caller)     */
+	__s32	status;		/* return code (set by responder)       */
+	__u32	arg_size;	/* request payload size                 */
+	__u32	resp_size;	/* response payload size                */
+	__u8	buffer[];	/* request data in, response data out   */
+} __packed;
+
+#define VBS_CA_BUF_SIZE (PAGE_SIZE - sizeof(struct vbs_kvm_ca))
+
+static void *kvm_ca_page;	/* single calling-area page             */
+
+/* ── low-level VTL call ────────────────────────────────────────────────── */
+
+struct kvm_vtl_call_ctx {
+	enum vbs_call_id id;
+	const void	*arg;
+	size_t		arg_size;
+	void		*resp;
+	size_t		resp_size;
+};
+
+/*
+ * Issue the VTL-call hypercall.  MUST run on the BSP (CPU0): KVM switches
+ * planes per logical CPU and the secure plane boots only on CPU0's sibling.
+ * Driven via work_on_cpu() so the hypercall always lands on CPU0.
+ */
+static long kvm_planes_vtl_call_on_cpu(void *data)
+{
+	struct kvm_vtl_call_ctx *ctx = data;
+	struct vbs_kvm_ca *ca = kvm_ca_page;
+	long hc_ret;
+
+	ca->call_id   = ctx->id;
+	ca->arg_size  = ctx->arg_size;
+	ca->status    = 0;
+	ca->resp_size = 0;
+	if (ctx->arg_size && ctx->arg)
+		memcpy(ca->buffer, ctx->arg, ctx->arg_size);
+	ca->call_pending = 1;
+
+	hc_ret = kvm_hypercall1(KVM_HC_VBS_VTL_CALL, virt_to_phys(kvm_ca_page));
+	ca->call_pending = 0;
+
+	if (hc_ret) {
+		pr_err_ratelimited("vbs-kvm: hypercall failed (%ld)\n", hc_ret);
+		return -EIO;
+	}
+
+	if (ca->status)
+		return ca->status;
+
+	if (ctx->resp && ctx->resp_size && ca->resp_size) {
+		size_t copy = min_t(size_t, ctx->resp_size, ca->resp_size);
+
+		memcpy(ctx->resp, ca->buffer, copy);
+	}
+	return 0;
+}
+
+static int kvm_planes_vtl_call(enum vbs_call_id id,
+			       const void *arg, size_t arg_size,
+			       void *resp, size_t resp_size)
+{
+	struct kvm_vtl_call_ctx ctx = {
+		.id        = id,
+		.arg       = arg,
+		.arg_size  = arg_size,
+		.resp      = resp,
+		.resp_size = resp_size,
+	};
+
+	if (!kvm_ca_page)
+		return -ENOMEM;
+
+	if (arg_size > VBS_CA_BUF_SIZE)
+		return -E2BIG;
+
+	/* Pin the plane switch to CPU0's secure sibling. */
+	return work_on_cpu(0, kvm_planes_vtl_call_on_cpu, &ctx);
+}
+
+/* ── lifecycle: load / unload the secure plane ─────────────────────────── */
+
+static int kvm_planes_init(void)
+{
+	int ret;
+
+	kvm_ca_page = (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
+	if (!kvm_ca_page)
+		return -ENOMEM;
+
+	ret = kvm_planes_vtl_call(VBS_CALL_INIT, NULL, 0, NULL, 0);
+	if (ret) {
+		pr_err("vbs-kvm: plane-1 INIT call failed (%d)\n", ret);
+		free_page((unsigned long)kvm_ca_page);
+		kvm_ca_page = NULL;
+		return ret;
+	}
+
+	pr_info("vbs-kvm: connected to plane-1 secure kernel\n");
+	return 0;
+}
+
+static void kvm_planes_shutdown(void)
+{
+	if (!kvm_ca_page)
+		return;
+
+	kvm_planes_vtl_call(VBS_CALL_SHUTDOWN, NULL, 0, NULL, 0);
+	free_page((unsigned long)kvm_ca_page);
+	kvm_ca_page = NULL;
+}
+
+/* ── ops table & registration ──────────────────────────────────────────── */
+
+static const struct vbs_ops kvm_planes_ops = {
+	.name     = "kvm-planes",
+	.init     = kvm_planes_init,
+	.shutdown = kvm_planes_shutdown,
+	.vtl_call = kvm_planes_vtl_call,
+};
+
+bool __init vbs_kvm_planes_detect(void)
+{
+	if (!kvm_para_available()) {
+		pr_debug("vbs-kvm: KVM paravirt not available\n");
+		return false;
+	}
+	return true;
+}
+
+const struct vbs_ops *vbs_kvm_planes_get_ops(void)
+{
+	return &kvm_planes_ops;
+}
-- 
2.55.0

