Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D662DA759
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 00:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789951737; cv=none; b=Ie8dA7SCPbtNU5MBNin+n65whMarpLO3fFQJtmJucbnAzpZuBaxbsbHZD8UwA2R+6LqGXP9Wdudx0B2L0cBmBmSw/6PRFc5CcUhQqdA62g+CtJuPqMdBdAKcHZ1Jrpsx06w0UPleHLb1m9BFKcdnP93Zn3a8SMt/Go+ux5AZPCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789951737; c=relaxed/simple;
	bh=avPZ16PAm2KRLLs3zFSBl7jOowUvnuNq+fuMqUotd3A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TNOyGmxDXSlUKNY6ExkYDpuT9xX258ocwmXV6clu/3g2eloYkEuTx1992i/d4MSW3Y0OJDH06hfxtuMd128WiqwUCEe8Uo9kjuAjBr7MfrkQAROqZHicb0YBdyl37v3+LuMf1+oMp0Ja3VW8vDEc/ts76Wk+3VnaSW/O0TG46k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BRfbpAcZ; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BRfbpAcZ"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8623e5d4279so4359052b3a.1
        for <kvm@vger.kernel.org>; Sun, 20 Sep 2026 17:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789951733; x=1790556533; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/sjf1DDcqeGOiFnNg/3dW38k0O9F/mHXt9LSFR/mRoI=;
        b=BRfbpAcZmOmJDGP4osSCg3PLLoHDJDWTaenp35KhmHipsl2mvDqOW0HJNs/Mz3dnm8
         OuTGTXf7g0RDlyfXBs4N0Ojr8OQ5z4LQvslxytFh+xppBK75Hv2VdGPLY35vlU6HBHZJ
         ghCm3nYmcbctH6qIbfW413jxO9y1e1TtlNssbcpBXYrnLCPYOYmuK4DVLZoOMbmXmrRZ
         gZK4rwZbbbb3oI/Kl5nCLbIToLF6PBen8ll7VNflqmu0ASesIf6gEd26jbIyUrF1jPs2
         xAyY+UNCQUM/RTXWMQimMTY4D/AwWHKdD7rID4c9C06Fj68Xvsze9Q5amlR/kMpMjQoM
         z2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789951733; x=1790556533;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/sjf1DDcqeGOiFnNg/3dW38k0O9F/mHXt9LSFR/mRoI=;
        b=pICCN1shDW+/KYpxBrjLDFsNu9fz168Vd4gOUcdjw8Cs9Oc+9sgVcb47Hh3xdvNPNH
         pFgGIol0N3/V1JUul79mu7yxmjUKLRwlj9y1kpMPINTP07SXPdT6DRuAxX/UwrjIvZy3
         hei+XLz08J0k0pscsw6QbywbfcNfZPQCymotKNIn/XYZZKHZ1N/OwjpE4lVykYb8kcBI
         x8ZttzCW7PB11L4sgBlHo7NCZnxOqw3tY+Sif8kTdie9xov97TqWhUDlaQfHk/OHScaZ
         2wipsti53UH/naYXyuBuXEwpZQz/RtJeQ2LYUWop/1R7bEOIVRjvdDHO0fzLIREczZ5g
         jyMQ==
X-Forwarded-Encrypted: i=1; AKwUvBxL8Rer3WXbhM5/mjOqPG7+lj3Pv4tIwh6kAL6TBUyqscuJgCN1g3/kDTwW/HCQzndzS2E=@vger.kernel.org
X-Gm-Message-State: AFuF++kdssF75TaI7qYnZ6ie4CSHaqm7U3EDmIF4u5hrrkfHfv8XA+N1
	2TLcGrwjeJGSeqEkJYLstR6guc4e+tsTr4RDMpO4iyK5VcVC9/FDoQlvMvLiNwqBHwcowdxjlUT
	6s1mu+QwAz5T5Jw==
X-Received: from pgtk20.prod.google.com ([2002:a65:68d4:0:b0:cc5:1024:105e])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1804:b0:852:131f:b9d2 with SMTP id d2e1a72fcca58-874db8eab76mr12887659b3a.2.1789951732364;
 Sun, 20 Sep 2026 17:48:52 -0700 (PDT)
Date: Mon, 21 Sep 2026 00:48:30 +0000
In-Reply-To: <20260921004834.2601285-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921004834.2601285-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921004834.2601285-15-skhawaja@google.com>
Subject: [PATCH v5 14/18] iommufd: Implement ioctl to mark HWPT for preservation
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: YiFei Zhu <zhuyifei@google.com>, Pranjal Shrivastava <praan@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vipin Sharma <vipinsh@google.com>
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
 drivers/iommu/iommufd/Makefile          |  1 +
 drivers/iommu/iommufd/iommufd_private.h | 17 ++++++
 drivers/iommu/iommufd/liveupdate.c      | 71 +++++++++++++++++++++++++
 drivers/iommu/iommufd/main.c            |  9 ++++
 include/uapi/linux/iommufd.h            | 27 ++++++++++
 6 files changed, 126 insertions(+)
 create mode 100644 drivers/iommu/iommufd/liveupdate.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ae6df95dc398..d4848ec3a9d6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13728,6 +13728,7 @@ M:	Samiullah Khawaja <skhawaja@google.com>
 R:	Pranjal Shrivastava <praan@google.com>
 L:	iommu@lists.linux.dev
 S:	Maintained
+F:	drivers/iommu/iommufd/liveupdate.c
 F:	drivers/iommu/liveupdate.c
 F:	include/linux/iommu-liveupdate.h
 F:	include/linux/kho/abi/iommu.h
diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index 67207914bb6e..cfd5b4b14ccb 100644
--- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -12,6 +12,7 @@ iommufd-y := \
 
 iommufd-$(CONFIG_IOMMUFD_NOIOMMU) += hwpt_noiommu.o
 iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
+iommufd-$(CONFIG_IOMMU_LIVEUPDATE) += liveupdate.o
 
 obj-$(CONFIG_IOMMUFD) += iommufd.o
 obj-$(CONFIG_IOMMUFD_DRIVER) += iova_bitmap.o
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index eb2e85b27e42..a33b32708afa 100644
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
@@ -392,6 +397,9 @@ struct iommufd_hwpt_paging {
 	bool auto_domain : 1;
 	bool enforce_cache_coherency : 1;
 	bool nest_parent : 1;
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	u64 liveupdate_token;
+#endif
 	/* Head at iommufd_ioas::hwpt_list */
 	struct list_head hwpt_item;
 	struct iommufd_sw_msi_maps present_sw_msi;
@@ -729,6 +737,15 @@ void iommufd_vdevice_abort(struct iommufd_object *obj);
 int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_hw_queue_destroy(struct iommufd_object *obj);
 
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
index 9a921b153162..fe8610fd58e3 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -333,6 +333,9 @@ static int iommufd_fops_open(struct inode *inode, struct file *filp)
 	init_rwsem(&ictx->ioas_creation_lock);
 	xa_init_flags(&ictx->objects, XA_FLAGS_ALLOC1 | XA_FLAGS_ACCOUNT);
 	xa_init(&ictx->groups);
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	mutex_init(&ictx->liveupdate_mutex);
+#endif
 	ictx->file = filp;
 	mt_init_flags(&ictx->mt_mmap, MT_FLAGS_ALLOC_RANGE);
 	init_waitqueue_head(&ictx->destroy_wait);
@@ -395,6 +398,9 @@ static int iommufd_fops_release(struct inode *inode, struct file *filp)
 	 * iommufd_object_tombstone_user()
 	 */
 	xa_destroy(&ictx->objects);
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	mutex_destroy(&ictx->liveupdate_mutex);
+#endif
 
 	WARN_ON(!xa_empty(&ictx->groups));
 
@@ -440,6 +446,7 @@ union ucmd_buffer {
 	struct iommu_hwpt_alloc hwpt;
 	struct iommu_hwpt_get_dirty_bitmap get_dirty_bitmap;
 	struct iommu_hwpt_invalidate cache;
+	struct iommu_hwpt_liveupdate_mark_preserve mark_preserve;
 	struct iommu_hwpt_set_dirty_tracking set_dirty_tracking;
 	struct iommu_ioas_alloc alloc;
 	struct iommu_ioas_allow_iovas allow_iovas;
@@ -516,6 +523,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 __reserved),
 	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
 		 struct iommu_viommu_alloc, out_viommu_id),
+	IOCTL_OP(IOMMU_HWPT_LIVEUPDATE_MARK_PRESERVE, iommufd_hwpt_liveupdate_mark_preserve,
+		 struct iommu_hwpt_liveupdate_mark_preserve, hwpt_token),
 #ifdef CONFIG_IOMMUFD_TEST
 	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
 #endif
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 206fa667c782..34637712c873 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -58,6 +58,7 @@ enum {
 	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
 	IOMMUFD_CMD_HW_QUEUE_ALLOC = 0x94,
 	IOMMUFD_CMD_IOAS_NOIOMMU_GET_PA = 0x95,
+	IOMMUFD_CMD_HWPT_LIVEUPDATE_MARK_PRESERVE = 0x96,
 };
 
 /**
@@ -1390,4 +1391,30 @@ struct iommu_hw_queue_alloc {
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
+#define IOMMU_HWPT_LIVEUPDATE_MARK_PRESERVE \
+	_IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_LIVEUPDATE_MARK_PRESERVE)
+
 #endif
-- 
2.55.0.1082.g2b9226bbc0-goog

