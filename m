Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D5030C14A
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 00:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789951740; cv=none; b=o3L0tsuJQFO+SZKNlBDrl15FSNz+Qvg1jEAY0caje7k2hEW3YMQ61eSjCPB+DZk/S94rT3E7jqjZhwlmX8P73DCrfQuWyQMDgFg50yNw9Czk4HRDx+p1RkWo0fiMeycz4EGG38g8j/998Z2G/Us6AbOZp0lCcww0x/p0S44Wp0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789951740; c=relaxed/simple;
	bh=g8GBgYiSWVkD7I1S+JEkWqmDKKAYErKNj/fk09dMpuk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VmGx2FA4pZVorzdzLlsxU9lywtUvBi0wZcgxNAQkbzgOazknQHpDgXC0ewKYmklffB5vAw74bAoEoSVqXjFjEP1ORrxluM/hzD/5xqVMeE1dyHg6jtm/cLNlzhTJ2ZwrukBhtZBCcuuQpeP6VoV7A6ewb1B69JOEnWsMVHjVwGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TSvzMSvy; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TSvzMSvy"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8710450f731so2529795b3a.0
        for <kvm@vger.kernel.org>; Sun, 20 Sep 2026 17:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789951734; x=1790556534; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QozPFrINpXQ5Eg89NebStO9QklWGOH83J1QrPXjzAKc=;
        b=TSvzMSvykjp7KIc4V6Y9j5VAyA5dquJjubYPRmvvdpuwZaWm5lnGE7W7KiLlWemKEk
         rkRukxVOXV2W2QsVgeu0zIMmkiBnbAtqK+XB8ftIRV+ZA4Pd2cCbInNclwkXpWLzMFCZ
         3ImyOpPCBysFAJjv9fPruZMSOfqkXB0EBvi78f8FhoGCa9NzzWZC+oulvrRteUnFA5ja
         kK/wYG0Ew1fxxmF76qEey0Z6IexX0BM6ZCtBmxKjkoIVKUTyFFTIEvSQPMdEaG+aQ3Le
         91JssYLkN8YfaEWCy9GWr/e+P3krpmFR7mFxz+67hW3MoexfE5k9EmeRWd68RgF8RZNO
         VB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789951734; x=1790556534;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QozPFrINpXQ5Eg89NebStO9QklWGOH83J1QrPXjzAKc=;
        b=VzBzwhVMFjO3k7XxSpPFh5dgN5C9BTmYQ+w/inO/QmY2vU+M2HABFTRU3SblwE3hzD
         L6VbujSCh9cVAdx0b/fpMofx4KTzVvMpNh9+zM0I8/ZkYV44xGGvm1ispemZN4nyKouy
         MgPHnEL/FZYGI6S3pma3gsSQymFJax1uBIHyaSjTsS3KiN7w21VPO28iEwxUpuKdGH30
         5h41M7wfferxuzniWEDacJoAw31buicNY5pJl9krMtG328ETRlNwoS8JefJkql61aL+/
         h3v6V47gLOOH2U3OEfzcU6eFeZRQkcZJz7NEa1kQUR6GM0pWGUDP6HhHEAOWRHchs37c
         mU+A==
X-Forwarded-Encrypted: i=1; AKwUvBzbXz4egBfXpbyVASS7XXXNbAwNeHzSSMMl3pG8rqOBzp7LT3VH93VfyZfM5qhOm5fBdtk=@vger.kernel.org
X-Gm-Message-State: AFuF++k1oy1ZSC5zBhdMXFCgwd1yyxeBdDw0ojIOnVEMlXshwtl1yn4d
	BNg8NOwY2WHwBtiuYVa2vzBbLYJ7s51kcjVDqMwoD53fRwMD6yZDE1oLR7yQD8VQrzOuoVf8dBp
	5no/F0wyTTcBpHA==
X-Received: from pgvm9.prod.google.com ([2002:a65:62c9:0:b0:cc5:284c:de35])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:2586:b0:3dd:85aa:452a with SMTP id adf61e73a8af0-3dd8c53aa87mr15058447637.37.1789951734021;
 Sun, 20 Sep 2026 17:48:54 -0700 (PDT)
Date: Mon, 21 Sep 2026 00:48:32 +0000
In-Reply-To: <20260921004834.2601285-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921004834.2601285-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921004834.2601285-17-skhawaja@google.com>
Subject: [PATCH v5 16/18] iommufd: Add APIs to preserve/unpreserve a vfio cdev
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Add APIs that can be used to preserve and unpreserve a vfio cdev. Use
the APIs exported by the IOMMU core to preserve/unpreserve device.

The LUO token of the preserved iommufd is fetched and returned back to
the caller as that can be used during restore to get the restored
iommufd.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/iommufd/device.c          | 142 ++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |   6 +
 include/linux/iommufd.h                 |  29 +++++
 3 files changed, 177 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 5c4b06eda546..d4974238ba9a 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
  */
 #include <linux/iommu.h>
+#include <linux/iommu-liveupdate.h>
 #include <linux/iommufd.h>
 #include <linux/pci-ats.h>
 #include <linux/slab.h>
@@ -686,6 +687,10 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	int rc;
 
 	mutex_lock(&igroup->lock);
+	if (iommufd_device_is_preserved(idev)) {
+		rc = -EBUSY;
+		goto err_unlock;
+	}
 
 	attach = xa_cmpxchg(&igroup->pasid_attach, pasid, NULL,
 			    XA_ZERO_ENTRY, GFP_KERNEL);
@@ -1747,3 +1752,140 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(ucmd->ictx, &idev->obj);
 	return rc;
 }
+
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+static bool _iommufd_device_has_pasid_attachments(struct iommufd_device *idev)
+{
+	struct iommufd_group *igroup = idev->igroup;
+	unsigned long start = IOMMU_NO_PASID;
+
+	if (xa_find_after(&igroup->pasid_attach,
+			  &start, UINT_MAX, XA_PRESENT))
+		return true;
+
+	return false;
+}
+
+/**
+ * iommufd_device_preserve() - Preserve an iommufd device across live update
+ * @s: Live update session
+ * @idev: Target iommufd device
+ * @iommufd_tokenp: Pointer to store outgoing iommufd token
+ *
+ * Return: 0 on success, or negative error code.
+ */
+int iommufd_device_preserve(struct liveupdate_session *s,
+			    struct iommufd_device *idev,
+			    u64 *iommufd_tokenp)
+{
+	struct iommufd_hwpt_paging *hwpt_paging;
+	struct iommufd_hw_pagetable *hwpt;
+	struct iommufd_attach *attach;
+	struct iommufd_group *igroup;
+	int ret;
+
+	if (!idev)
+		return -EINVAL;
+
+	igroup = idev->igroup;
+	mutex_lock(&igroup->lock);
+	if (idev->liveupdate_preserved) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	if (_iommufd_device_has_pasid_attachments(idev)) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	attach = xa_load(&igroup->pasid_attach, IOMMU_NO_PASID);
+	if (!attach) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	if (!xa_load(&attach->device_array, idev->obj.id)) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	hwpt = attach->hwpt;
+	hwpt_paging = find_hwpt_paging(hwpt);
+	if (!hwpt_paging || !hwpt_paging->liveupdate_preserved) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = liveupdate_get_token_outgoing(s, idev->ictx->file, iommufd_tokenp);
+	if (ret)
+		goto out;
+
+	ret = iommu_preserve_device(hwpt_paging->common.domain,
+				    idev->dev,
+				    *iommufd_tokenp);
+
+	if (!ret) {
+		igroup->nr_liveupdate_preserved++;
+		idev->liveupdate_preserved = true;
+	}
+out:
+	mutex_unlock(&igroup->lock);
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_device_preserve, "IOMMUFD");
+
+/**
+ * iommufd_device_unpreserve() - Unpreserve an iommufd device
+ * @s: Live update session
+ * @idev: Target iommufd device
+ */
+void iommufd_device_unpreserve(struct liveupdate_session *s,
+			       struct iommufd_device *idev)
+{
+	struct iommufd_hwpt_paging *hwpt_paging;
+	struct iommufd_hw_pagetable *hwpt;
+	struct iommufd_attach *attach;
+	struct iommufd_group *igroup;
+
+	if (!idev)
+		return;
+
+	igroup = idev->igroup;
+	mutex_lock(&igroup->lock);
+	if (!idev->liveupdate_preserved)
+		goto out;
+
+	attach = xa_load(&igroup->pasid_attach, IOMMU_NO_PASID);
+	if (!attach) {
+		WARN(1, "IOMMU_NO_PASID attachment not found");
+		goto out;
+	}
+
+	hwpt = attach->hwpt;
+	hwpt_paging = find_hwpt_paging(hwpt);
+	if (!hwpt_paging || !hwpt_paging->liveupdate_preserved) {
+		WARN(1, "Attached domain is not preserved");
+		goto out;
+	}
+
+	iommu_unpreserve_device(hwpt_paging->common.domain, idev->dev);
+	igroup->nr_liveupdate_preserved--;
+	idev->liveupdate_preserved = false;
+out:
+	mutex_unlock(&igroup->lock);
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_device_unpreserve, "IOMMUFD");
+
+/**
+ * iommufd_device_is_preserved() - Check if an iommufd device is preserved
+ * @idev: Target iommufd device
+ *
+ * Return: true if preserved, false otherwise.
+ */
+bool iommufd_device_is_preserved(struct iommufd_device *idev)
+{
+	return idev && idev->igroup && idev->igroup->nr_liveupdate_preserved;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_device_is_preserved, "IOMMUFD");
+#endif
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index a4ddc29ec5ae..131544626bf2 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -507,6 +507,9 @@ struct iommufd_group {
 	struct xarray pasid_attach;
 	struct iommufd_sw_msi_maps required_sw_msi;
 	phys_addr_t sw_msi_start;
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	int nr_liveupdate_preserved;
+#endif
 };
 
 /*
@@ -524,6 +527,9 @@ struct iommufd_device {
 	bool enforce_cache_coherency;
 	struct iommufd_vdevice *vdev;
 	bool destroying;
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	bool liveupdate_preserved;
+#endif
 };
 
 static inline struct iommufd_device *
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 6e7efe83bc5d..80382aceca18 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -9,6 +9,7 @@
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/iommu.h>
+#include <linux/liveupdate.h>
 #include <linux/refcount.h>
 #include <linux/types.h>
 #include <linux/xarray.h>
@@ -213,6 +214,15 @@ int iommufd_access_rw(struct iommufd_access *access, unsigned long iova,
 int iommufd_vfio_compat_ioas_get_id(struct iommufd_ctx *ictx, u32 *out_ioas_id);
 int iommufd_vfio_compat_ioas_create(struct iommufd_ctx *ictx);
 int iommufd_vfio_compat_set_no_iommu(struct iommufd_ctx *ictx);
+
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+int iommufd_device_preserve(struct liveupdate_session *s,
+			    struct iommufd_device *idev,
+			    u64 *iommufd_tokenp);
+void iommufd_device_unpreserve(struct liveupdate_session *s,
+			       struct iommufd_device *idev);
+bool iommufd_device_is_preserved(struct iommufd_device *idev);
+#endif
 #else /* !CONFIG_IOMMUFD */
 static inline struct iommufd_ctx *iommufd_ctx_from_file(struct file *file)
 {
@@ -397,4 +407,23 @@ static inline void iommufd_viommu_destroy_mmap(struct iommufd_viommu *viommu,
 {
 	_iommufd_destroy_mmap(viommu->ictx, &viommu->obj, offset);
 }
+
+#if !IS_ENABLED(CONFIG_IOMMU_LIVEUPDATE) || !IS_ENABLED(CONFIG_IOMMUFD)
+static inline int iommufd_device_preserve(struct liveupdate_session *s,
+					  struct iommufd_device *idev,
+					  u64 *iommufd_tokenp)
+{
+	return 0;
+}
+
+static inline void iommufd_device_unpreserve(struct liveupdate_session *s,
+					     struct iommufd_device *idev)
+{
+}
+
+static inline bool iommufd_device_is_preserved(struct iommufd_device *idev)
+{
+	return false;
+}
+#endif
 #endif
-- 
2.55.0.1082.g2b9226bbc0-goog

