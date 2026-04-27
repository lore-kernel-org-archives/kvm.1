Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EBC3E95AE
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777312618; cv=none; b=h1FOEOhk5KG8L9fmyAE3epcQIEvpA7ywNtO6Q3voJAvuOXcTE3ta5iWVu5KOXANDwWkmdDD91+P5HML6mgK5wB1YA80seiMalPFJsyIKDuDO8+bVE2vUmA9TE+z1a2bxlbxQFkmTTSMWG5azLf54PN8yBnxp/RtREjhav8AKsn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777312618; c=relaxed/simple;
	bh=SstJek6gNaIsfe25jxdqZf1VIgqsfYyneGJLdEpk+lQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xypf0X4Mz+XpCz/uma/nEBxiZ4OVl9RwnZMz2QG4qIK0mIcjbtzDA02vNK/bQDtgAxFgJarkjBIc2t2sHt3dxdHQor4UMPCrFhEoRDi/r5uX8RfrdBNFB4MdD6lSXRX9UfR9PlfYnzbVSmgyCvHTZfD1KdWbVdd+uwJtYTp4VXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SIIK98Z7; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SIIK98Z7"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c76cb2dce57so6438501a12.1
        for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 10:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777312616; x=1777917416; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LFojZ6tjl5frS0yAQ84iItGSem/qDqDAxgZ4VJwC2H8=;
        b=SIIK98Z7fwlFVliTRuqOqQvSFiR1krDXN+ScDTW0lg/qShAUT7XoUDD1D5uEwrE5Uz
         zaHWKobkJb9LeQmsgrH8QFHhjs74sSJ6FzchthM1zWQoEejbW/q8cH6GZbsAjWfjRpu6
         PzMJ46chklq5cLAjq2R5WaVJ1UTBbfZQEGz9v7rZDu3vzUdQuGjp9izidLiIQfotE07C
         m732siGzxk09voNF2RPu83oxDYSpAfdLdFt4MWXD9DP0udiv79S3/pjYmR509v9AoHjY
         xvQax+LJ1sP2YT9Y9zW+xSJHbGsmwoxOg6+8tcNtOkam25slwprSmXC0bndvgErd/tp7
         slOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777312616; x=1777917416;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LFojZ6tjl5frS0yAQ84iItGSem/qDqDAxgZ4VJwC2H8=;
        b=KbRzogHyPpYNlpLxk72FrgA7WyC5lDpD/J3EX36iCX22GLoRM7CoaWrDWViGWXzDA2
         Nn0stKaS+Gwsja2CnZgsXiOb0dOzglXp4gpUx8UjoevI/oYF39BisxbZoaepO0vPAwWx
         P58W8ub+Nd47RAI5aABBfKyBUp4PepvQDHljUp/ZyRkjv5+jI6m2Ml0jV0liEA0JNPui
         H0wf8cCebLVkqJHWJ5/l0vp03SkwdqRvuGiEbOCy+jnDp/KAaRHsWB65EaLD0ANw7sQJ
         EIbN6QETnLGsse2jrZISM/DHappE7LPDf3Wl8VrJxsP9L5NsSPdNcTeiCL6Wk4+k4WP+
         djaA==
X-Forwarded-Encrypted: i=1; AFNElJ8edfiqG6CUSsaXhLC6ONCIz68yhJAHjerlC4Mt/7bzymjy/Hfm2lX5gNdLymrgyjv0QHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxje71HVjfHvGxDwyZqr1Jf9EaPsVBT+jKgZobDprU9x7UUP2dY
	rUVj4MlwlDs4mWr4tqx0qev1yE+e7z+ONzdeBZlCcSwg6S+RxbShY/o55innTJNUTPffozvLvu2
	GXfj8Igam1IsQSg==
X-Received: from pgct5.prod.google.com ([2002:a05:6a02:5285:b0:c79:7975:38ca])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7291:b0:3a2:ebfc:6bf5 with SMTP id adf61e73a8af0-3a398f45353mr378820637.52.1777312615640;
 Mon, 27 Apr 2026 10:56:55 -0700 (PDT)
Date: Mon, 27 Apr 2026 17:56:29 +0000
In-Reply-To: <20260427175633.1978233-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260427175633.1978233-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260427175633.1978233-13-skhawaja@google.com>
Subject: [PATCH v2 12/16] iommufd: Implement ioctl to mark HWPT for preservation
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: YiFei Zhu <zhuyifei@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
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

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 MAINTAINERS                             |  1 +
 drivers/iommu/iommufd/Makefile          |  1 +
 drivers/iommu/iommufd/iommufd_private.h | 18 +++++++++
 drivers/iommu/iommufd/liveupdate.c      | 52 +++++++++++++++++++++++++
 drivers/iommu/iommufd/main.c            |  9 +++++
 include/uapi/linux/iommufd.h            | 26 +++++++++++++
 6 files changed, 107 insertions(+)
 create mode 100644 drivers/iommu/iommufd/liveupdate.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 9f5c02c6c8c1..bf6a2ad61989 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13496,6 +13496,7 @@ R:	Pranjal Shrivastava <praan@google.com>
 L:	iommu@lists.linux.dev
 S:	Maintained
 F:	drivers/iommu/intel/liveupdate.c
+F:	drivers/iommu/iommufd/liveupdate.c
 F:	drivers/iommu/liveupdate.c
 F:	include/linux/iommu-liveupdate.h
 F:	include/linux/kho/abi/iommu.h
diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index 71d692c9a8f4..c3bf0b6452d3 100644
--- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -17,3 +17,4 @@ obj-$(CONFIG_IOMMUFD_DRIVER) += iova_bitmap.o
 
 iommufd_driver-y := driver.o
 obj-$(CONFIG_IOMMUFD_DRIVER_CORE) += iommufd_driver.o
+obj-$(CONFIG_IOMMU_LIVEUPDATE) += liveupdate.o
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 6ac1965199e9..111f4d42e210 100644
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
@@ -373,6 +378,10 @@ struct iommufd_hwpt_paging {
 	bool auto_domain : 1;
 	bool enforce_cache_coherency : 1;
 	bool nest_parent : 1;
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	bool liveupdate_preserve : 1;
+	u64 liveupdate_token;
+#endif
 	/* Head at iommufd_ioas::hwpt_list */
 	struct list_head hwpt_item;
 	struct iommufd_sw_msi_maps present_sw_msi;
@@ -706,6 +715,15 @@ iommufd_get_vdevice(struct iommufd_ctx *ictx, u32 id)
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
index 000000000000..2d3abfa9e9f8
--- /dev/null
+++ b/drivers/iommu/iommufd/liveupdate.c
@@ -0,0 +1,52 @@
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
+	int rc = 0;
+
+	hwpt_target = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
+	if (IS_ERR(hwpt_target))
+		return PTR_ERR(hwpt_target);
+
+	mutex_lock(&ictx->liveupdate_mutex);
+
+	xa_lock(&ictx->objects);
+	xa_for_each_marked(&ictx->objects, index, obj, IOMMUFD_OBJ_LIVEUPDATE_MARK) {
+		if (WARN_ON_ONCE(obj->type != IOMMUFD_OBJ_HWPT_PAGING))
+			continue;
+
+		hwpt_paging = to_hwpt_paging(container_of(obj, struct iommufd_hw_pagetable, obj));
+		if (hwpt_paging->liveupdate_token == cmd->hwpt_token) {
+			rc = -EADDRINUSE;
+			goto out_unlock;
+		}
+	}
+
+	__xa_set_mark(&ictx->objects, hwpt_target->common.obj.id, IOMMUFD_OBJ_LIVEUPDATE_MARK);
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
index e998dfbd6960..d96a74b43c9d 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -57,6 +57,7 @@ enum {
 	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
 	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
 	IOMMUFD_CMD_HW_QUEUE_ALLOC = 0x94,
+	IOMMUFD_CMD_HWPT_LU_MARK_PRESERVE = 0x95,
 };
 
 /**
@@ -1347,4 +1348,29 @@ struct iommu_hw_queue_alloc {
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
+	__u64 hwpt_token;
+};
+#define IOMMU_HWPT_LIVEUPDATE_MARK_PRESERVE _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_LU_MARK_PRESERVE)
+
 #endif
-- 
2.54.0.545.g6539524ca2-goog

