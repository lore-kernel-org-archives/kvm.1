Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283730;
	b=IpMSyWeF3CSYWtJLIBvtp+sZ1RFXnwebJnjvNmOl/M+SS/lQrvZSWfUHBI+cMT9zM+uJ
	 PP5MK/x78GTaAv0Ky7CWepXjAy63aHR/92Za7jtmz4elapqR2Vi3dvwgt8rFKWjr2sEnB
	 uMrAze6JeGLOWim+Q4j0YHQlQoke2uQbiW0cbgGQiN5Yb+Ey8GAlBqKV9pYjMojTxJYzS
	 2V6g3qaZyQR57dRAf2QUcIesqt2Rkk79UJRGB1FbXfoEn4oQZO6mZkShKQAqbx95eJ9Uc
	 rpKbZ/engkq5tGPjnM8vmhQi1VOD1e5rfxOAYwRSW8MHGctxDzx+VAs5T8Hvk4PFHPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=rN4oVufvi2nGwVnUu37zg0Qg8FnmGc5b0APYU80CoWI=;
	b=m/le/eD05k/+4Yis5zq+XmQ6wBaXozMYa3nf2qD7nujdwWhnLGB8Mi3Xc2qLzmx5Gf9x
	 yAqD42uPstnZ3jkrOiZ74bI57HIPkHknCqUcBiV2Y7oh+sYYR5oIHBfut5qSRorYE6zvy
	 qQpwdKJgVffkkqpI8F4HnTTU2YJLyceUCA+bKtxs9gBKK90VGYFb0epbZqQW2WUIuq4hA
	 mZUGaGhHuiFjghu5WdKbp33udx5DbP+RgYj5CLXUXmrs3frr13Uy3kLG/P4IrPOGUWAJz
	 wHe0HcjEMPnhINUMJK7N+u6w/rC1Smd3QhKDndqtfnpzmxy4JftqAjrjGSwinpmXlsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PV5k9cKX;
	arc=none smtp.remote-ip=209.85.215.198
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF151606B7E6
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 04:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF151606B7E6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PV5k9cKX
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cd6969473a4so938865a12.0
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 20:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794283729; x=1794888529; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rN4oVufvi2nGwVnUu37zg0Qg8FnmGc5b0APYU80CoWI=;
        b=PV5k9cKXuOg4dmytIddJMN6mDnF5HDSFfioGnTRlHsQ05BJd/jGdD36TZbCwTmSVd8
         TKjrpfQrlHNlHA3Zpab4xxtPLcV5xY2UndoBuGs7PG9/wLDB2Nz3z4uqP5CAskOJ56j+
         B7N8N557SboouNMexPyRTvJcFL2/X+eMYHqCGrMqAWOQasRQcD+8+QcgLl7slbcJGcb2
         wKwTjLEItehL94Cwe7U7aZJ4XLxZN7CEjDKKjfu95+ZBjBaZ/X2HoN9riL6l0w5Rrdhj
         9PedadOiqPHWU5RnMh6t5UtKlg5iNttVtC3J7iwlHcURvj+4GSENNgD2XO38S97dUU48
         H6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794283729; x=1794888529;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rN4oVufvi2nGwVnUu37zg0Qg8FnmGc5b0APYU80CoWI=;
        b=tyUN+gxEpx30lSb4Ke3oXYinjkkmYgpY5ApbYYp4N8SJhtSGFc5pHd7Yd1u3FvDFRg
         btCKi0J1D/uqndfvLkrkmN4Zs0bYmioKwJoQF5bk9bi/3a+3wsG+RxHCa2DCeR+WYbXb
         FYzF8D28O+zHklcFSDyURvYUIs1vo/IaXJVc7IdSF8c3EviEffFyQ23CMOTYgHdZ4Say
         dA7WZITKAAJJ4bYH3GiMy/SkmlPseLwHmFaDKxTG0lHwEzTgbva794ZZ3fdohL65OzZs
         d0nyc8thAD78SgWQmaAX3OIY3aZU33jPgpEF10oOCOkcXM1F/Ty4wjgc834tFJoPJEJM
         Jm6Q==
X-Forwarded-Encrypted: i=1; AL+hErG9lioH/qzwrcOVOThtoEr1wYzVbxsn8ZqzPzOBuGaoxU1B/BsrIKaR+YlVRi/HUCcsP2U=@vger.kernel.org
X-Gm-Message-State: APuU4Z/h+v5xBInM0R3ef+GaAtlxY6T52llI4RTRMcBcs7zOahMO9gNh
	kF3RP7Z8qI/9RJ4JrlVJQWYZCZYtU8JcdWoKV8dPilnRJaPI8O86angpTjtDpseyjFwlCQoRiWr
	svkxSbfQmlS0n/g==
X-Received: from pjboe18.prod.google.com ([2002:a17:90b:3952:b0:3b0:a2c4:246b])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1f90:b0:3a8:f70f:2437 with SMTP id 98e67ed59e1d1-3b166d1deddmr1478231a91.50.1794283728975;
 Mon, 09 Nov 2026 20:08:48 -0800 (PST)
Date: Tue, 10 Nov 2026 04:08:22 +0000
In-Reply-To: <20261110040828.1774343-1-skhawaja@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110040828.1774343-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110040828.1774343-17-skhawaja@google.com>
Subject: [PATCH v7 16/18] iommufd: Add APIs to preserve/unpreserve a vfio cdev
From: Samiullah Khawaja <skhawaja@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Woodhouse <dwmw2@infradead.org>
Cc: Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vipin Sharma <vipinsh@google.com>, Ankit Soni <Ankit.Soni@amd.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Content-Type: text/plain; charset="UTF-8"

Add APIs that can be used to preserve and unpreserve a vfio cdev. Use
the APIs exported by the IOMMU core to preserve/unpreserve device.

The LUO token of the preserved iommufd is fetched and returned back to
the caller as that can be used during restore to get the restored
iommufd.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/iommufd/device.c          | 153 ++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |   3 +
 include/linux/iommufd.h                 |  33 +++++
 3 files changed, 189 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 1b0bdf57ac8a..1e42e85af819 100644
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
@@ -869,6 +874,10 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 	int rc;
 
 	mutex_lock(&igroup->lock);
+	if (iommufd_device_is_preserved(idev)) {
+		rc = -EBUSY;
+		goto err_unlock;
+	}
 
 	attach = xa_load(&igroup->pasid_attach, pasid);
 	if (!attach) {
@@ -1749,3 +1758,147 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
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
+	if (xa_find_after(&igroup->pasid_attach, &start, UINT_MAX, XA_PRESENT))
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
+	if (iommufd_device_is_noiommu(idev))
+		return -EOPNOTSUPP;
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
+	if (!hwpt_is_paging(hwpt)) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	hwpt_paging = to_hwpt_paging(hwpt);
+	ret = liveupdate_get_token_outgoing(s, idev->ictx->file, iommufd_tokenp);
+	if (ret)
+		goto out;
+
+	if (!hwpt_paging->liveupdate_preserved) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = iommu_preserve_device(hwpt_paging->common.domain,
+				    idev->dev,
+				    *iommufd_tokenp);
+
+	if (!ret)
+		idev->liveupdate_preserved = true;
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
+	if (WARN(!hwpt_is_paging(hwpt), "Attached HWPT is not a paging HWPT"))
+		goto out;
+
+	hwpt_paging = to_hwpt_paging(hwpt);
+	if (!hwpt_paging->liveupdate_preserved) {
+		WARN(1, "Attached domain is not preserved");
+		goto out;
+	}
+
+	iommu_unpreserve_device(idev->dev);
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
index 69d902b69b82..df231d1e7d09 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -524,6 +524,9 @@ struct iommufd_device {
 	bool enforce_cache_coherency;
 	struct iommufd_vdevice *vdev;
 	bool destroying;
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	bool liveupdate_preserved;
+#endif
 };
 
 static inline struct iommufd_device *
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 3087f5b2def8..f673a07cbc32 100644
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
@@ -215,6 +216,15 @@ int iommufd_access_rw(struct iommufd_access *access, unsigned long iova,
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
@@ -399,4 +409,27 @@ static inline void iommufd_viommu_destroy_mmap(struct iommufd_viommu *viommu,
 {
 	_iommufd_destroy_mmap(viommu->ictx, &viommu->obj, offset);
 }
+
+#if !IS_ENABLED(CONFIG_IOMMU_LIVEUPDATE) || !IS_ENABLED(CONFIG_IOMMUFD)
+/*
+ * vfio-pci live update works without IOMMU state preservation, so the device
+ * is still preserved, just without its IOMMU state.
+ */
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
2.56.0.506.g506a7eabc5-goog

