Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115BD35C69C
	for <kvm@vger.kernel.org>; Sat,  8 Aug 2026 02:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786156062; cv=none; b=cpDjh2A6V1e0w124Vqn5potOqfDKuBhW3pY+e/hn9N/f3Uj079wxT6cB7TdugeioOTEZK7JrSP680W6tkK58h8dBgKn8Qe4DTbgEG97iWQ3meCaWQamEE39sfGN7yFIRA4LAA5ZtsGYmmMwK8hWkQIx+a4eNWiGlyh+npzJRt1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786156062; c=relaxed/simple;
	bh=sj37TpSBepuXS8oCPokU5o/kFxC/gP5vh1hhQqrqdDk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FdoERDyFpjZvLdru3gCAgAhHIjqcE90/2LZfZ/fWaqrFbB0QXHMQhkHZ5FjpYqwEO41Rx2ZFxhwro1fbsyDgPYyPzl5elK6JkTI4yFts+ESNA6976JhSCUK+gVyzpO46i82/h3IdLt1ND2JUrcKdKalc24pz/1fb9whDLYmfvSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QQlpZ1d3; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QQlpZ1d3"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84a3514f912so275658b3a.3
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 19:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786156056; x=1786760856; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VWzLSWnPlQzLhEqTxEW0bxqlBm2vzE9LwGtuq5Ikhwg=;
        b=QQlpZ1d3t71BhKhoPfUIvtB/fMXqfxdGARcSJ/nVg9ujkXH1ig2AosGqqP4VVDh/uN
         i1/Hi3hA4iCGFB9/AdZBvVMAzwCRnlnvsmG5sT34gFuWfFGPxAH3liapUfHrazCgChBj
         X4mvwCrednYK3m+MP+hK2/JqJ+2tBr/CMPTv2P9hUq4esy9hPZJWgsOrvDdPXqjIR+V5
         l/YxPZz4fcdDAZ8xO0tDdDzJz5WRUW0GFWNI0wIqO+vlUEoUC1D1UIvJ9M5hD+rz32g9
         WLbNzl6h8U2VYR3uEnY2WpX1qTjtjVAukowWtrZWgGMIY4HsfWKuGbNF6F62tgySDZ9Q
         4eIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786156056; x=1786760856;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VWzLSWnPlQzLhEqTxEW0bxqlBm2vzE9LwGtuq5Ikhwg=;
        b=pUSwydtjJiMKROVIdtwj0AkptvUFY2Esj6MANZPTBsuavraAGK8WW+2aKskskw1KAo
         NjQDaPEQ4rS/x26R0zUePYsg3YMKqfUDp7aU4im+nFyfpfD844FkCHaHSvSh322dl7Ar
         K1VRVWo4riSxFgWWfFun+YgwbYtN7U92e4bXC1ptr5PD6CBZhJrdw7nQLi1zobJGVsHG
         sFMHGMJo/pT3Wpem9n7KuquKHDi1acXOVaYtkd8b+MKwKSsTKGN/CaLpQMYLkUKjOSxx
         iEShqkO76XjGuQSG4vq8NKOqYvnSpIQQKUgdjW1OggbCoz6lTyfAWNmNeHQmI0OTbMZy
         UFeQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr0r10GvZOI/XhwKzDhZ0U4apSsIPwY+JvxqTV/yqvdWReO3QTdk5lnVETCokJir62/pyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4RbdOwm0UFQ8KLT/FOQGiQqaDE7u/juGipX8zVnG+WCeTLm1x
	WZaD1vGB2OvNLhYteg3ji7lwt4wbedRxCl5q0XAUgmlNPZ3jblTwCymF53Q4aD/CjtU8wT8ziQR
	rcJH/dal50okM9w==
X-Received: from pfqf14.prod.google.com ([2002:aa7:9d8e:0:b0:84d:f9cf:1f3d])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:99b:b0:848:76c4:fba9 with SMTP id d2e1a72fcca58-84f2dff77c0mr29569680b3a.7.1786156055791;
 Fri, 07 Aug 2026 19:27:35 -0700 (PDT)
Date: Sat,  8 Aug 2026 02:27:19 +0000
In-Reply-To: <20260808022723.3893618-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260808022723.3893618-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260808022723.3893618-15-skhawaja@google.com>
Subject: [PATCH v4 14/18] iommufd: Implement ioctl to mark HWPT for preservation
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: YiFei Zhu <zhuyifei@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

From: YiFei Zhu <zhuyifei@google.com>

Userspace provides a token to mark the HWPT for preservation. Note that
this token is not the LUO token that is used to preserve the iommufd.
Once all the required HWPT are marked for preservation, the user can
preserve the iommufd into LUO. The iommufd will preserve the HWPTs that
are marked for preservation.

The marked HWPTs are tracked using a new XArray mark protected by a new
liveupdate mutex. This mutex will also be used during iommufd
preservation to protect against any race with the mark preserve ioctl.

The HWPT token will be used during restore to identify this HWPT. The
restoration logic is not implemented and will be added later.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: YiFei Zhu <zhuyifei@google.com>
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 MAINTAINERS                             |  1 +
 drivers/iommu/iommufd/Makefile          |  2 +
 drivers/iommu/iommufd/iommufd_private.h | 17 ++++++
 drivers/iommu/iommufd/liveupdate.c      | 71 +++++++++++++++++++++++++
 drivers/iommu/iommufd/main.c            |  9 ++++
 include/uapi/linux/iommufd.h            | 26 +++++++++
 6 files changed, 126 insertions(+)
 create mode 100644 drivers/iommu/iommufd/liveupdate.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2ed856ab0501..985c4d53c2c2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13628,6 +13628,7 @@ M:	Samiullah Khawaja <skhawaja@google.com>
 R:	Pranjal Shrivastava <praan@google.com>
 L:	iommu@lists.linux.dev
 S:	Maintained
+F:	drivers/iommu/iommufd/liveupdate.c
 F:	drivers/iommu/liveupdate.c
 F:	include/linux/iommu-liveupdate.h
 F:	include/linux/kho/abi/iommu.h
diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index 71d692c9a8f4..d765fc10e3b2 100644
--- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -11,9 +11,11 @@ iommufd-y := \
 	viommu.o
 
 iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
+iommufd-$(CONFIG_IOMMU_LIVEUPDATE) += liveupdate.o
 
 obj-$(CONFIG_IOMMUFD) += iommufd.o
 obj-$(CONFIG_IOMMUFD_DRIVER) += iova_bitmap.o
 
 iommufd_driver-y := driver.o
 obj-$(CONFIG_IOMMUFD_DRIVER_CORE) += iommufd_driver.o
+
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 43fbc5bed8de..9b4b745acef1 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -44,6 +44,11 @@ struct iommufd_ctx {
 	struct file *file;
 	struct xarray objects;
 	struct xarray groups;
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+#define IOMMUFD_OBJ_LIVEUPDATE_MARK XA_MARK_1
+	/* @liveupdate_mutex: Protects the preservation of HWPTs. */
+	struct mutex liveupdate_mutex;
+#endif
 	wait_queue_head_t destroy_wait;
 	struct rw_semaphore ioas_creation_lock;
 	struct maple_tree mt_mmap;
@@ -373,6 +378,9 @@ struct iommufd_hwpt_paging {
 	bool auto_domain : 1;
 	bool enforce_cache_coherency : 1;
 	bool nest_parent : 1;
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	u64 liveupdate_token;
+#endif
 	/* Head at iommufd_ioas::hwpt_list */
 	struct list_head hwpt_item;
 	struct iommufd_sw_msi_maps present_sw_msi;
@@ -706,6 +714,15 @@ iommufd_get_vdevice(struct iommufd_ctx *ictx, u32 id)
 			    struct iommufd_vdevice, obj);
 }
 
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+int iommufd_hwpt_liveupdate_mark_preserve(struct iommufd_ucmd *ucmd);
+#else
+static inline int iommufd_hwpt_liveupdate_mark_preserve(struct iommufd_ucmd *ucmd)
+{
+	return -ENOTTY;
+}
+#endif
+
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
 void iommufd_selftest_destroy(struct iommufd_object *obj);
diff --git a/drivers/iommu/iommufd/liveupdate.c b/drivers/iommu/iommufd/liveupdate.c
new file mode 100644
index 000000000000..96f01ee5a1e8
--- /dev/null
+++ b/drivers/iommu/iommufd/liveupdate.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (C) 2026, Google LLC
+ * Author: Samiullah Khawaja <skhawaja@google.com>
+ */
+
+#define pr_fmt(fmt) "iommufd: " fmt
+
+#include <linux/file.h>
+#include <linux/iommufd.h>
+#include <linux/liveupdate.h>
+
+#include "iommufd_private.h"
+
+int iommufd_hwpt_liveupdate_mark_preserve(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_hwpt_liveupdate_mark_preserve *cmd = ucmd->cmd;
+	struct iommufd_hwpt_paging *hwpt_target;
+	struct iommufd_hwpt_paging *hwpt_paging;
+	struct iommufd_ctx *ictx = ucmd->ictx;
+	struct iommufd_object *obj;
+	unsigned long index;
+	bool marked = false;
+	int rc = 0;
+
+	hwpt_target = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
+	if (IS_ERR(hwpt_target))
+		return PTR_ERR(hwpt_target);
+
+	mutex_lock(&ictx->liveupdate_mutex);
+
+	xa_lock(&ictx->objects);
+
+	/* PRI use cases are not supported. */
+	if (hwpt_target->common.fault) {
+		rc = -EOPNOTSUPP;
+		goto out_unlock;
+	}
+
+	xa_for_each_marked(&ictx->objects, index, obj, IOMMUFD_OBJ_LIVEUPDATE_MARK) {
+		if (WARN_ON_ONCE(obj->type != IOMMUFD_OBJ_HWPT_PAGING))
+			continue;
+
+		hwpt_paging = to_hwpt_paging(container_of(obj, struct iommufd_hw_pagetable, obj));
+
+		if (hwpt_paging == hwpt_target)
+			marked = true;
+
+		if (hwpt_paging->liveupdate_token == cmd->hwpt_token) {
+			if (hwpt_paging == hwpt_target)
+				goto out_unlock;
+
+			rc = -EADDRINUSE;
+			goto out_unlock;
+		}
+	}
+
+	__xa_set_mark(&ictx->objects, hwpt_target->common.obj.id, IOMMUFD_OBJ_LIVEUPDATE_MARK);
+
+	if (marked)
+		pr_warn_ratelimited("Overwriting HWPT liveupdate token from: %llu to %llu\n",
+				    hwpt_target->liveupdate_token, cmd->hwpt_token);
+	hwpt_target->liveupdate_token = cmd->hwpt_token;
+
+out_unlock:
+	xa_unlock(&ictx->objects);
+	mutex_unlock(&ictx->liveupdate_mutex);
+	iommufd_put_object(ictx, &hwpt_target->common.obj);
+	return rc;
+}
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 8c6d43601afb..0114c1520db4 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -313,6 +313,9 @@ static int iommufd_fops_open(struct inode *inode, struct file *filp)
 	init_rwsem(&ictx->ioas_creation_lock);
 	xa_init_flags(&ictx->objects, XA_FLAGS_ALLOC1 | XA_FLAGS_ACCOUNT);
 	xa_init(&ictx->groups);
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	mutex_init(&ictx->liveupdate_mutex);
+#endif
 	ictx->file = filp;
 	mt_init_flags(&ictx->mt_mmap, MT_FLAGS_ALLOC_RANGE);
 	init_waitqueue_head(&ictx->destroy_wait);
@@ -375,6 +378,9 @@ static int iommufd_fops_release(struct inode *inode, struct file *filp)
 	 * iommufd_object_tombstone_user()
 	 */
 	xa_destroy(&ictx->objects);
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	mutex_destroy(&ictx->liveupdate_mutex);
+#endif
 
 	WARN_ON(!xa_empty(&ictx->groups));
 
@@ -420,6 +426,7 @@ union ucmd_buffer {
 	struct iommu_hwpt_alloc hwpt;
 	struct iommu_hwpt_get_dirty_bitmap get_dirty_bitmap;
 	struct iommu_hwpt_invalidate cache;
+	struct iommu_hwpt_liveupdate_mark_preserve mark_preserve;
 	struct iommu_hwpt_set_dirty_tracking set_dirty_tracking;
 	struct iommu_ioas_alloc alloc;
 	struct iommu_ioas_allow_iovas allow_iovas;
@@ -493,6 +500,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 __reserved),
 	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
 		 struct iommu_viommu_alloc, out_viommu_id),
+	IOCTL_OP(IOMMU_HWPT_LIVEUPDATE_MARK_PRESERVE, iommufd_hwpt_liveupdate_mark_preserve,
+		 struct iommu_hwpt_liveupdate_mark_preserve, hwpt_token),
 #ifdef CONFIG_IOMMUFD_TEST
 	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
 #endif
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 0425d452d41e..7468bc5f8ae4 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -57,6 +57,7 @@ enum {
 	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
 	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
 	IOMMUFD_CMD_HW_QUEUE_ALLOC = 0x94,
+	IOMMUFD_CMD_HWPT_LU_MARK_PRESERVE = 0x95,
 };
 
 /**
@@ -1351,4 +1352,29 @@ struct iommu_hw_queue_alloc {
 	__aligned_u64 length;
 };
 #define IOMMU_HW_QUEUE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HW_QUEUE_ALLOC)
+
+/**
+ * struct iommu_hwpt_liveupdate_mark_preserve - ioctl(IOMMU_HWPT_LIVEUPDATE_MARK_PRESERVE)
+ * @size: sizeof(struct iommu_hwpt_liveupdate_mark_preserve)
+ * @hwpt_id: Iommufd object ID of the target HWPT
+ * @hwpt_token: Token to identify this hwpt upon restore
+ *
+ * The target HWPT will be preserved during iommufd preservation.
+ * Only file-based memory mappings (e.g. memfd) are supported for HWPTs marked
+ * for preservation. Mapping anonymous memory into a preserved HWPT will result
+ * in a failure during the preservation phase.
+ *
+ * The hwpt_token is provided by userspace. If userspace enters a token
+ * already in use within this iommufd, -EADDRINUSE is returned from this ioctl.
+ *
+ * Note: There is no 'unmark' operation, so any HWPTs pooled in userspace that
+ * are marked for preservation must be destroyed after use.
+ */
+struct iommu_hwpt_liveupdate_mark_preserve {
+	__u32 size;
+	__u32 hwpt_id;
+	__aligned_u64 hwpt_token;
+};
+#define IOMMU_HWPT_LIVEUPDATE_MARK_PRESERVE _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_LU_MARK_PRESERVE)
+
 #endif
-- 
2.55.0.679.g6767b8d81c-goog

