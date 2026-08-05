Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBCB459ADD;
	Wed,  5 Aug 2026 11:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927850; cv=none; b=VbopevkULLBPuh5N3PIOHM94kHZz4Ejc3HH/unBcmYofuqZO+GvWmQnJOM29a39dQNnlQqOwKInvgwa5gbdja2+HD7zrRHDpjAudlAeHOlO4xNctMU+3ptZyp0JH0Nu4x4/+ngXkB3taq1kz8RpgVfzoxdH5b8dkYBjMzOZxe9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927850; c=relaxed/simple;
	bh=ZWZtr/YxItABnDHd3G+/oX76N8nDR9WlNY/bBv8eJ4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KsUxCZaB4pAJ5OcXLralcXmIp2Ziepg6BNw+ftjPtwv62XIDrzGu09r5oFjdz5rGv48fCATl/7SufHqfnUd2HVcVwpOdPrYp114Yj0oMuDdL7NL8jfvF+PYrGwc9b37dYJy0WcsJHhJlulWRzYmNz0etZNihoUbPblC143DgNWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ddNAv6EP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ddNAv6EP"
Received: from fedora.hsd1.wa.comcast.net (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0B87220B716D;
	Wed,  5 Aug 2026 04:03:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0B87220B716D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785927828;
	bh=2o5bvQY6ffcuSOPfk6NCrggFxJBplKNTmYmcX0G06So=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ddNAv6EPbbXoWPkhl/gcJwz/AywpxwuTGtNIpjZkuwUPY6iz2ImKfH9VChoMWy/NN
	 uIMebT6WVmSKBlgwLw/+7a6/Ng3Ka97NvJihnCGHaHEkRuOPE4NZYy6BP5FEWERItS
	 5zI973udU9G7HORd/0jCgpMImwiTV5AsV4bC2dpY=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 31/42] security/vbs: pin the VTL call hypercall to CPU0
Date: Wed,  5 Aug 2026 04:03:13 -0700
Message-ID: <20260805110324.25067-32-snambakam@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805110324.25067-1-snambakam@linux.microsoft.com>
References: <20260805110324.25067-1-snambakam@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

KVM switches planes per logical CPU, and the secure plane is a single
in-guest kernel that boots only on CPU0's sibling (common->vcpus[1] of
CPU0). A VTL call issued from any other CPU would switch that CPU's
non-existent secure sibling and fail. Drive the hypercall through
work_on_cpu(0, ...) so the calling area build and the plane switch
always land on CPU0 regardless of the caller's CPU. The request/response
marshalling moves into a kvm_vtl_call_ctx run on CPU0; the validation
(calling-area present, arg size) stays on the caller.

Signed-off-by: Sriram Nambakam <snambakam@linux.microsoft.com>
---
 security/vbs/kvm_planes.c | 67 ++++++++++++++++++++++++++++-----------
 1 file changed, 48 insertions(+), 19 deletions(-)

diff --git a/security/vbs/kvm_planes.c b/security/vbs/kvm_planes.c
index 061163a4d303..c41ea7fdb472 100644
--- a/security/vbs/kvm_planes.c
+++ b/security/vbs/kvm_planes.c
@@ -25,6 +25,7 @@
 #include <linux/kvm_para.h>
 #include <linux/module.h>
 #include <linux/string.h>
+#include <linux/workqueue.h>
 #include <linux/elf.h>
 #include <asm/sections.h>
 #include <asm/kvm_para.h>
@@ -59,28 +60,34 @@ static void *kvm_ca_page;	/* single calling-area page		*/
 
 /* ── low-level VTL call ───────────────────────────────────────────────── */
 
-static int kvm_planes_vtl_call(enum vbs_call_id id,
-			       const void *arg, size_t arg_size,
-			       void *resp, size_t resp_size)
+struct kvm_vtl_call_ctx {
+	enum vbs_call_id id;
+	const void	*arg;
+	size_t		arg_size;
+	void		*resp;
+	size_t		resp_size;
+};
+
+/*
+ * Issue the VTL call hypercall.  MUST run on the BSP (CPU0): KVM switches
+ * planes per logical CPU (the secure sibling is common->vcpus[1] of the
+ * *calling* CPU), and the secure plane is a single in-guest kernel that
+ * boots only on CPU0's sibling.  Driven via work_on_cpu() so the hypercall
+ * always lands on CPU0 regardless of the caller's CPU.
+ */
+static long kvm_planes_vtl_call_on_cpu(void *data)
 {
-	struct vbs_kvm_ca *ca;
+	struct kvm_vtl_call_ctx *ctx = data;
+	struct vbs_kvm_ca *ca = kvm_ca_page;
 	long hc_ret;
 
-	if (!kvm_ca_page)
-		return -ENOMEM;
-
-	if (arg_size > VBS_CA_BUF_SIZE)
-		return -E2BIG;
-
-	ca = kvm_ca_page;
-
 	/* Build request */
-	ca->call_id  = id;
-	ca->arg_size = arg_size;
+	ca->call_id  = ctx->id;
+	ca->arg_size = ctx->arg_size;
 	ca->status   = 0;
 	ca->resp_size = 0;
-	if (arg_size && arg)
-		memcpy(ca->buffer, arg, arg_size);
+	if (ctx->arg_size && ctx->arg)
+		memcpy(ca->buffer, ctx->arg, ctx->arg_size);
 	ca->call_pending = 1;
 
 	/* Issue hypercall: pass physical address of the calling area */
@@ -97,14 +104,36 @@ static int kvm_planes_vtl_call(enum vbs_call_id id,
 		return ca->status;
 
 	/* Read response from the same buffer */
-	if (resp && resp_size && ca->resp_size) {
-		size_t copy = min_t(size_t, resp_size, ca->resp_size);
+	if (ctx->resp && ctx->resp_size && ca->resp_size) {
+		size_t copy = min_t(size_t, ctx->resp_size, ca->resp_size);
 
-		memcpy(resp, ca->buffer, copy);
+		memcpy(ctx->resp, ca->buffer, copy);
 	}
 	return 0;
 }
 
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
+	/* Pin the plane switch to CPU0's secure sibling (the only booted one). */
+	return work_on_cpu(0, kvm_planes_vtl_call_on_cpu, &ctx);
+}
+
 /* ── memory protection ────────────────────────────────────────────────── */
 
 struct vbs_protect_args {
-- 
2.55.0

