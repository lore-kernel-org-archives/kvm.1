Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792894794;
	b=2pw3qqMflouY+2bzSpFOr0Q9rC559l5WDOMcqg4JZlNr0MTHKo2XPc7AMdEX8e/4vDwu
	 SgDA006UYY1MLsOYU2QvOQ4UALj2AQ3XuxIIbXaEp1guNWrCqN9KDyP/akyiOBLSskW1Q
	 I/OzR4ATsty7V8w0MiMFc4unc73SHlWtGN2hqBi1Z3WD8BwX0wPd6BER6klA32+MhqXxc
	 YGigeN7wSjaVo2f7MwZrtNOiYcDibt31dbEb5hMB/bCpAQe/qOZRF3z34wdih+DFuewnU
	 phqkxl44+6SJHnKF4Nb8XbpbZzyJVIdUHdgtO+s2wnGswvQPhWrzI1ze+wogEc3HgcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792894794;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=iAmL6dDCl6VCpbqXazWUpvxA8pF8WBHEUzN8tOpo6p0=;
	b=ZzGkHxBzl7gDcCN3JEroBZeG1aamk2IR1bpSID0MMJlhajHDGX/Rds9Pcz5PykK7Ovu2
	 OlOQCz/BviPiMG693o1ZzXxLhHWZns/rEk8mZTK/4gw1NxCP7YSVTsFVLU0awm3UOn8Fc
	 MN2IVGvU+DmFbzwJrdWbJaboVp+QqOxX3a7B/cnQN9SlNqtXBaJRN4NTDOsf9XdDm9c6b
	 lDb6YoiNnkiRjn7IY+8d3fJyJUNMq0nvMHElmJbcTrtqx69iwQbYzSF4IL6Cmmpt4HGYn
	 KqkApZcJoJur25YvdNFQoCBjuEURqU2uvXmr7Iw4ywDAsf2i2njHU8Njhubb8oi8S6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=mQTk80qZ;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD9860A381E
	for <kvm@vger.kernel.org>; Sun, 25 Oct 2026 02:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FD9860A381E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=mQTk80qZ
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e94f72fb9fso18293835ad.1
        for <kvm@vger.kernel.org>; Sat, 24 Oct 2026 19:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792894793; x=1793499593; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iAmL6dDCl6VCpbqXazWUpvxA8pF8WBHEUzN8tOpo6p0=;
        b=mQTk80qZaBm+ggx80wcBAKFzFVCC7rojO+o6FUSAafYBBHbsaVkeQgOgdpudnZwJB7
         g0knTI+jj0athZ9Um0oYISLL8IQPZO9HlJmbyY/GC3BEmniOBJpkbiLG7vvi9Z/LoR0U
         QntuI5kBMXcLYyQ9dKYrnWBXvrq/rZ/wnPcE8uV7KGAIvLv7W/abLnNKvlaWJEJecVVj
         n0RAUg4VQSm5jm/GXnXI2Eqv6WTuRYIMjYUO7iZNtU7pjOPHs0yBmxJAiTAySs2kqGRs
         IWoxTLOMHsK5Usk0OXWfGQAzdqvW1U1VznYxHKn19iCnr8EFE1hYetEKVV5Y7dO+yY6b
         t5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792894793; x=1793499593;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iAmL6dDCl6VCpbqXazWUpvxA8pF8WBHEUzN8tOpo6p0=;
        b=PRVBDKwNMZfD9nc+zbDb3nf3seAAqnOR0z3Kl7OOtfNb2MyNUciHUzziWNYYUBUQ6w
         S+keFu6Ac3/Yp9MNg9kOONvWt8pwiiteNn/Ae0OcgXQD5//xEbyo4PU8yklkfP3ExA5D
         xQQ8AVaFu/pB9H5u0wZZamp+yrATr2y0txPkII/Ulh2hnrp2QEx04Y79bTxLge8snjTe
         zxJA2p4GoesJN2IvkfLmxnLlTIDdqSQa2lzjFvn9e/xaVmlkqAXU+zfLmtsljZy7rsE/
         izpWQbVqhTCPtCqsLHKAhfp8vqwVle60iCn14I35z+JOFgOCFB/zM7ktvgZG3dBs0EyP
         +RWQ==
X-Forwarded-Encrypted: i=1; AKwUvBzecLzadJt1cu5I1S0e3Q+QlOefDF9rPjeqWrl6LnIyI0VglVzr2vzbuyR1Sm6isYjmTbA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIj7lTmV67YxkFa+77E1nCpsrpP9cuBnAb1kKM0f1WbRqUFrd7v
	yLZ5k1X15mGTYORLF+GFFMtH5vPBolPP7KzE2rjMI38WDVbXBvZPL8Cgq62EnOSQpB3x5roc4kT
	UOeJt2Bljzv+HWQ==
X-Received: from pggs7.prod.google.com ([2002:a63:dc07:0:b0:cd8:bfaf:1ea3])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1a30:b0:2e5:467a:7a6b with SMTP id d9443c01a7336-2ea9c69aa27mr28295695ad.10.1792894792865;
 Sat, 24 Oct 2026 19:19:52 -0700 (PDT)
Date: Sun, 25 Oct 2026 02:19:25 +0000
In-Reply-To: <20261025021930.674647-1-skhawaja@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261025021930.674647-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261025021930.674647-15-skhawaja@google.com>
Subject: [PATCH v6 14/18] iommufd: Implement ioctl to mark HWPT for preservation
From: Samiullah Khawaja <skhawaja@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Woodhouse <dwmw2@infradead.org>
Cc: YiFei Zhu <zhuyifei@google.com>, Pranjal Shrivastava <praan@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vipin Sharma <vipinsh@google.com>, Ankit Soni <Ankit.Soni@amd.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
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
 drivers/iommu/iommufd/liveupdate.c      | 72 +++++++++++++++++++++++++
 drivers/iommu/iommufd/main.c            |  9 ++++
 include/uapi/linux/iommufd.h            | 27 ++++++++++
 6 files changed, 127 insertions(+)
 create mode 100644 drivers/iommu/iommufd/liveupdate.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 15e1da41b0cc..78af4e3dc106 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13738,6 +13738,7 @@ M:	Samiullah Khawaja <skhawaja@google.com>
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
index 000000000000..5fb491ff3a3d
--- /dev/null
+++ b/drivers/iommu/iommufd/liveupdate.c
@@ -0,0 +1,72 @@
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
+	struct iommufd_ctx *ictx = ucmd->ictx;
+	struct iommufd_hwpt_paging *hwpt;
+	struct iommufd_object *obj;
+	unsigned long index;
+	bool marked = false;
+	int rc = 0;
+
+	hwpt = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
+	if (IS_ERR(hwpt))
+		return PTR_ERR(hwpt);
+
+	mutex_lock(&ictx->liveupdate_mutex);
+
+	xa_lock(&ictx->objects);
+
+	/* PRI use cases are not supported. */
+	if (hwpt->common.fault) {
+		rc = -EOPNOTSUPP;
+		goto out_unlock;
+	}
+
+	xa_for_each_marked(&ictx->objects, index, obj, IOMMUFD_OBJ_LIVEUPDATE_MARK) {
+		struct iommufd_hwpt_paging *hwpt_marked;
+
+		if (WARN_ON_ONCE(obj->type != IOMMUFD_OBJ_HWPT_PAGING))
+			continue;
+
+		hwpt_marked = to_hwpt_paging(container_of(obj, struct iommufd_hw_pagetable, obj));
+
+		if (hwpt_marked == hwpt)
+			marked = true;
+
+		if (hwpt_marked->liveupdate_token == cmd->hwpt_token) {
+			if (hwpt_marked == hwpt)
+				goto out_unlock;
+
+			rc = -EADDRINUSE;
+			goto out_unlock;
+		}
+	}
+
+	__xa_set_mark(&ictx->objects, hwpt->common.obj.id, IOMMUFD_OBJ_LIVEUPDATE_MARK);
+
+	if (marked)
+		pr_warn_ratelimited("Overwriting HWPT liveupdate token from: %llu to %llu\n",
+				    hwpt->liveupdate_token, cmd->hwpt_token);
+	hwpt->liveupdate_token = cmd->hwpt_token;
+
+out_unlock:
+	xa_unlock(&ictx->objects);
+	mutex_unlock(&ictx->liveupdate_mutex);
+	iommufd_put_object(ictx, &hwpt->common.obj);
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
index 206fa667c782..93372689afec 100644
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
+ * @hwpt_id: HW pagetable ID to preserve for liveupdate
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
2.56.0.257.gf7497c7d27-goog

