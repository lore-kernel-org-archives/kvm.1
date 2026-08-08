Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE473659FB
	for <kvm@vger.kernel.org>; Sat,  8 Aug 2026 02:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786156062; cv=none; b=XSlD+uPhkEAAii7S/1aGkhxV864jsnEjazt8boGAhYwEh1EYedGaaQnTKOlYFujmpJcmOoQW4Yz1lHJWYUWme0CJqRm3AzQO1l/pw+zwe0HRFq7tvW/dlYfwiLd/QX4qA3thtWANDcB1sTZ54kaVzcDsIp08UaU2GBWKgB6Qgu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786156062; c=relaxed/simple;
	bh=vS7evCpWOGLxyc95HVtt5NSqoZtYOvad+pd1SvqYmLY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eUP2qGAPdw0lHgLxkgUnlUxQrvX8hyaN7QjGsNEMDC5PqDXRtq6oipIxEabU3IsEU3CKVu3A9e2YLre2IphkUnFEa4N3XZupmFIYkDY8t4aoAlQvPqdv+9j+X86RzRmYiPEJwPPzDf/ea6kzdMEbAAkVJWnvqfbpi9yw0MnjrvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UgO7NC7T; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UgO7NC7T"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84e024d2129so298627b3a.2
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 19:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786156058; x=1786760858; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7T9G9UohARPcWvtcfv1Wgbw4frkuuhXtKFNRLXq1rqY=;
        b=UgO7NC7TNcjli0hMRTWsyeVRSQtccRy2Aqfh1P5f5e1mo0aa/mwB5e0aIpkkwyZ5ll
         RljimnSgnJBzwfjshqxHGvOUJ4kKj4O5xf1zpcVBioeBj0QQsWyqJYvY9YPvKZqy2jFV
         3SfkIXd7vxQXZYL+I5GG9lFIu6G5OOlbJv0O4q0Dann54et4DnKWai/xcpt9BQaRXQho
         YLQGQolrwg3JTswmtX3IqrH6yXCwsFYuHhr0xhJtPMMwqGhjmPbtSCiW40yOX5sac6UP
         8Ytr0vMG5eaFqL4w8xyNOXuZEjwRUwiwldJQ3Tr7DwCTY59SHZYx9qN5mFS3O3mTMI0V
         hf2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786156058; x=1786760858;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7T9G9UohARPcWvtcfv1Wgbw4frkuuhXtKFNRLXq1rqY=;
        b=fs5gtt8NOfYlBPDU/mTT5oyFwE596m3Lj+zDMZdhq++VWWzIyzhsuTdyVUIMoolr6f
         Cp4Kelo/OsuNK+hwlGwrQXZN5d7d07TkiryvgLJwheXyvIcArzXsPYafsG9KAkjLOhMW
         jhPLIS76Gc8dZ5Q5BK98DW2p7cb0ur9Dqr2rfp93PIGam4LZDs7li2TQ0af+yBZ/Vs7+
         634LJjR1J7cZMIXokn7SCEP5QF8PqIro5563cU6En2wOlf1XJ86GgBg2+m60w6c7mnmT
         GQa7ga1MEbiv1bnAvI3T+esqGC3Vz3XR+D5ST2R7Hwrl7dRbIyVHH2GpZE0YgJ3/9AhO
         mn3Q==
X-Forwarded-Encrypted: i=1; AHgh+Rqse1K+13DGQLjYLRTYcoGf0S20ws8FOGFahsVUm/hTgdjuK5rgGp5EiYRgWZwDQqsNm+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwBTVuI3HUf5YlY7ly9LTCOje0QGsNdsa6tI7fETu5LbUduTUd
	93RXKCiU81UOeNzbehr9DcbcQUaGf1NEjEBY9LQ4afcllmeBUqyzTL3gFKx0sPN6LeFaT6jILaf
	6ujtWTqjc2eVv3g==
X-Received: from pfqy1.prod.google.com ([2002:aa7:9e01:0:b0:848:46e6:1aac])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4f8c:b0:848:5c00:fa91 with SMTP id d2e1a72fcca58-84f5e1347famr8649758b3a.38.1786156057420;
 Fri, 07 Aug 2026 19:27:37 -0700 (PDT)
Date: Sat,  8 Aug 2026 02:27:21 +0000
In-Reply-To: <20260808022723.3893618-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260808022723.3893618-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260808022723.3893618-17-skhawaja@google.com>
Subject: [PATCH v4 16/18] iommufd: Add APIs to preserve/unpreserve a vfio cdev
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Add APIs that can be used to preserve and unpreserve a vfio cdev. Use
the APIs exported by the IOMMU core to preserve/unpreserve device.

The LUO token of the preserved iommufd is fetched and returned back to
the caller as that can be used during restore to get the restored
iommufd. Handle to the preserved state of the device is also returned to
reassociate with the restored state after live update kexec.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/iommufd/device.c          | 144 ++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |   6 +
 include/linux/iommufd.h                 |  31 +++++
 3 files changed, 181 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 170a7005f0bc..b3bf2cba1103 100644
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
@@ -610,6 +611,10 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	int rc;
 
 	mutex_lock(&igroup->lock);
+	if (iommufd_device_is_preserved(idev)) {
+		rc = -EBUSY;
+		goto err_unlock;
+	}
 
 	attach = xa_cmpxchg(&igroup->pasid_attach, pasid, NULL,
 			    XA_ZERO_ENTRY, GFP_KERNEL);
@@ -1665,3 +1670,142 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
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
+ * @preserved_state: Pointer to store preserved hardware state
+ *
+ * Return: 0 on success, or negative error code.
+ */
+int iommufd_device_preserve(struct liveupdate_session *s,
+			    struct iommufd_device *idev,
+			    u64 *iommufd_tokenp,
+			    u64 *preserved_state)
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
+				    preserved_state);
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
+	return idev && idev->liveupdate_preserved;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_device_is_preserved, "IOMMUFD");
+#endif
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 3b37c13fb118..ea5e727cdc72 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -486,6 +486,9 @@ struct iommufd_group {
 	struct xarray pasid_attach;
 	struct iommufd_sw_msi_maps required_sw_msi;
 	phys_addr_t sw_msi_start;
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	int nr_liveupdate_preserved;
+#endif
 };
 
 /*
@@ -503,6 +506,9 @@ struct iommufd_device {
 	bool enforce_cache_coherency;
 	struct iommufd_vdevice *vdev;
 	bool destroying;
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	bool liveupdate_preserved;
+#endif
 };
 
 static inline struct iommufd_device *
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 6e7efe83bc5d..2fa95894b900 100644
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
@@ -213,6 +214,16 @@ int iommufd_access_rw(struct iommufd_access *access, unsigned long iova,
 int iommufd_vfio_compat_ioas_get_id(struct iommufd_ctx *ictx, u32 *out_ioas_id);
 int iommufd_vfio_compat_ioas_create(struct iommufd_ctx *ictx);
 int iommufd_vfio_compat_set_no_iommu(struct iommufd_ctx *ictx);
+
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+int iommufd_device_preserve(struct liveupdate_session *s,
+			    struct iommufd_device *idev,
+			    u64 *iommufd_tokenp,
+			    u64 *preserved_state);
+void iommufd_device_unpreserve(struct liveupdate_session *s,
+			       struct iommufd_device *idev);
+bool iommufd_device_is_preserved(struct iommufd_device *idev);
+#endif
 #else /* !CONFIG_IOMMUFD */
 static inline struct iommufd_ctx *iommufd_ctx_from_file(struct file *file)
 {
@@ -397,4 +408,24 @@ static inline void iommufd_viommu_destroy_mmap(struct iommufd_viommu *viommu,
 {
 	_iommufd_destroy_mmap(viommu->ictx, &viommu->obj, offset);
 }
+
+#if !IS_ENABLED(CONFIG_IOMMU_LIVEUPDATE) || !IS_ENABLED(CONFIG_IOMMUFD)
+static inline int iommufd_device_preserve(struct liveupdate_session *s,
+					  struct iommufd_device *idev,
+					  u64 *iommufd_tokenp,
+					  u64 *preserved_state)
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
2.55.0.679.g6767b8d81c-goog

