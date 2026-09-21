Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228262D9792
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 00:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789951735; cv=none; b=KRMPYUv7bptvh/OZdcpn0jtYyb4QfEKjx9EZd97NMLVLFQfwF/6dF4El/m0iMm8X2/E8UA7BjkcFi57KLu4F0pKInGMb3p9VNHORvXcOzFwe25KNvANtlT+FwV4hHaKsfK+C1amhu82qPUsPWiaO4NuUOxa+tBIUoMg4nBi5E6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789951735; c=relaxed/simple;
	bh=KC381iw5UmgvllDgJ3YNjupbKUlYfiAYAjHYSVAumpI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UfWVJQrGz+9w/UWp3mgdFUJ8ShvaBp/GHvW2U3PVxGMOn0PgGr5lo1SWYnnJjfhYy9/c+zHA9yeBt7g/W3K5TUBBN8CuxvYc4NNP+EY5nEGkMMRwcqnfYKsZfM4/9EtZ41u/IB6sa80uGVN7Tp/tPV1da1HYvto4ThMIjJsFbWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KgVd6AcV; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KgVd6AcV"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc489e7a701so3739975a12.2
        for <kvm@vger.kernel.org>; Sun, 20 Sep 2026 17:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789951726; x=1790556526; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=blp+qm96mUk79bE4u/LdP52s0pcty0khhzeGk8qCR7I=;
        b=KgVd6AcV4vmL1EnwsWcdr9UKRnVQx//uiQDV+WAX4QLuBJyQTsBCHsHwDhyroHIp+F
         A3EeCmpkgD2aZmmjhDK3P1VESt3C7QzvYHBrC7gNe5+DQ8K6Wsxlc7mAghLSdDMc7RP+
         MWL/w7acWWmdkjI6GPw5KpASZMvHRXHW6d9ceQXQW6frBJPfU99bs6+em6z3M9KJAG3F
         V5NKO8MsWjXZMCHrSc3aaJUf6hfIkxr4/+QSdaImfNYzVn42JRYun0x6Cm90wEHQVSLi
         bijHBimetT4nlEgp3BwTRhHRhLp9BZMNe7lIfycYw2ghz5OynKyeAMeDZ/zZp573E5o9
         sVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789951726; x=1790556526;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=blp+qm96mUk79bE4u/LdP52s0pcty0khhzeGk8qCR7I=;
        b=iJ8KHIIhBfao3b45CAeSH8MyorWglBf0n73IfkSQtDZuh5Nl+9Mp5OI+awX/B2OovU
         W8TbXS7zO+jjbQyVHvmPSiFQOnHlF+jTgt9QZsAa+Sl7rSh2OMCaMwKoOHQaJbkk0uoO
         qLYDq3AqnKS6p8vLjdSRUaIetfPdQKxPGsa2uBfJl6uNrn+KCG5jLEbO+LOgFBVmvHnZ
         WSz3wu3fH0s5jOAxkspdHl2GC4ZdmvvtAnMwvQjXjDcr+DNWjcdoaLmHTFWyTf5bIQDA
         MmGjqkM6V091Br9HQht0lhzQB2DfUBimPuMTFxymPTcVrQUfqClLBn0wv6z4tu8avSyG
         u16Q==
X-Forwarded-Encrypted: i=1; AKwUvBw0jL579UFf/i5/Vq0lzIygusql3G8C0tZc/ou+/2OX3NKIzTw9+ejmfCYxfi1B20mTmOU=@vger.kernel.org
X-Gm-Message-State: AFuF++mKPGW1tdRV4sSX6flakDyLl6wjR/bBMXz4zBIzWVNKalutQ4Rd
	5s1uFzTC01O8ydxj1ihRbc3c7CugEQ7bjAeO4CPiyaoP4CtA3uyy26FUkUnztZYiyVlsbYRAbbC
	y/arX39UmDZdSaA==
X-Received: from pgdf8.prod.google.com ([2002:a05:6a02:5148:b0:cc4:c085:96d1])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:ce43:b0:3b4:7e2d:a3c2 with SMTP id adf61e73a8af0-3dd8c44e218mr14476854637.18.1789951726141;
 Sun, 20 Sep 2026 17:48:46 -0700 (PDT)
Date: Mon, 21 Sep 2026 00:48:22 +0000
In-Reply-To: <20260921004834.2601285-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921004834.2601285-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921004834.2601285-7-skhawaja@google.com>
Subject: [PATCH v5 06/18] iommu: Implement device and IOMMU HW preservation
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

Add IOMMU ops to preserve/unpreserve the device state handled by the
IOMMU driver. This is IOMMU specific state of the device that needs to
be preserved for liveupdate. These ops can be implemented by the IOMMU
drivers that support preservation of devices that have their IOMMU
domains preserved. During device preservation the state of the
associated IOMMU is also preserved as dependency.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/iommu-priv.h       |   2 +
 drivers/iommu/iommu.c            |  62 ++++++++-
 drivers/iommu/liveupdate.c       | 212 +++++++++++++++++++++++++++++++
 include/linux/iommu-liveupdate.h |  56 ++++++++
 include/linux/iommu.h            |  42 ++++++
 5 files changed, 373 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index aaffad5854fc..62612b1fc890 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -21,6 +21,8 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
 
 void dev_iommu_free(struct device *dev);
 
+bool iommu_group_is_singleton(struct iommu_group *group);
+
 const struct iommu_ops *iommu_ops_from_fwnode(const struct fwnode_handle *fwnode);
 
 static inline const struct iommu_ops *iommu_fwspec_ops(struct iommu_fwspec *fwspec)
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index cd1bca7ede9a..9c1ad8de3ad7 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -18,6 +18,7 @@
 #include <linux/errno.h>
 #include <linux/host1x_context_bus.h>
 #include <linux/iommu.h>
+#include <linux/iommu-liveupdate.h>
 #include <linux/iommufd.h>
 #include <linux/idr.h>
 #include <linux/err.h>
@@ -328,6 +329,37 @@ void iommu_device_unregister(struct iommu_device *iommu)
 }
 EXPORT_SYMBOL_GPL(iommu_device_unregister);
 
+static int _iommu_for_each_dev_cb(struct device *dev, void *data)
+{
+	struct iommu_dev_iter *iter = data;
+
+	if (dev->iommu && dev->iommu->iommu_dev == iter->iommu)
+		return iter->fn(dev, iter->iommu, iter->arg);
+
+	return 0;
+}
+
+/**
+ * iommu_for_each_dev() - Iterate over all devices attached to an IOMMU
+ * @iter: Device iterator context
+ *
+ * Return: 0 on success, or negative error code.
+ */
+int iommu_for_each_dev(struct iommu_dev_iter *iter)
+{
+	int ret;
+
+	for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++) {
+		ret = bus_for_each_dev(iommu_buses[i], NULL, iter,
+				       _iommu_for_each_dev_cb);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iommu_for_each_dev);
+
 #if IS_ENABLED(CONFIG_IOMMUFD_TEST)
 void iommu_device_unregister_bus(struct iommu_device *iommu,
 				 const struct bus_type *bus,
@@ -626,8 +658,8 @@ DEFINE_MUTEX(iommu_probe_device_lock);
 
 static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
 {
+	struct group_device *gdev, *gdev2;
 	struct iommu_group *group;
-	struct group_device *gdev;
 	int ret;
 
 	/*
@@ -661,6 +693,13 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 		goto err_put_group;
 	}
 
+	for_each_group_device(group, gdev2) {
+		if (dev_iommu_preserved_state(gdev2->dev)) {
+			ret = -EBUSY;
+			goto err_free_gdev;
+		}
+	}
+
 	/*
 	 * The gdev must be in the list before calling
 	 * iommu_setup_default_domain()
@@ -697,6 +736,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 
 err_remove_gdev:
 	list_del(&gdev->list);
+err_free_gdev:
 	__iommu_group_free_device(group, gdev);
 err_put_group:
 	iommu_deinit_device(dev);
@@ -3543,6 +3583,26 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
 }
 EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
 
+/**
+ * iommu_group_is_singleton() - Query if group contains exactly one device
+ * @group: The group.
+ *
+ * Return: true if group contains exactly 1 device, false otherwise.
+ */
+bool iommu_group_is_singleton(struct iommu_group *group)
+{
+	bool ret;
+
+	if (!group)
+		return false;
+
+	mutex_lock(&group->mutex);
+	ret = (list_count_nodes(&group->devices) == 1);
+	mutex_unlock(&group->mutex);
+
+	return ret;
+}
+
 static void iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 				   struct iommu_domain *domain)
 {
diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
index be542efbb023..5f92a023ea65 100644
--- a/drivers/iommu/liveupdate.c
+++ b/drivers/iommu/liveupdate.c
@@ -42,6 +42,9 @@
 #include <linux/iommu.h>
 #include <linux/kexec_handover.h>
 #include <linux/liveupdate.h>
+#include <linux/pci.h>
+
+#include "iommu-priv.h"
 
 #define iommu_max_objs_per_page(_array) \
 	((PAGE_SIZE - sizeof(struct iommu_array_hdr_ser)) / sizeof((_array)->objects[0]))
@@ -379,3 +382,212 @@ void iommu_unpreserve_domain(struct iommu_domain *domain)
 	liveupdate_flb_put_outgoing(&iommu_flb);
 }
 EXPORT_SYMBOL_GPL(iommu_unpreserve_domain);
+
+static struct iommu_hw_ser *alloc_iommu_hw_ser(struct iommu_flb_obj *flb)
+{
+	int idx;
+
+	idx = alloc_object_ser((void **)&flb->curr_iommu_array,
+			       iommu_max_objs_per_page(flb->curr_iommu_array));
+	if (idx < 0)
+		return ERR_PTR(idx);
+
+	flb->curr_iommu_array->objects[idx].hdr.ref_count = 1;
+	return &flb->curr_iommu_array->objects[idx];
+}
+
+static int iommu_preserve_locked(struct iommu_device *iommu,
+				 struct iommu_flb_obj *flb_obj)
+{
+	struct iommu_hw_ser *iommu_hw_ser;
+	int ret;
+
+	if (!iommu->ops->preserve || !iommu->ops->unpreserve)
+		return -EOPNOTSUPP;
+
+	lockdep_assert_held(&flb_obj->lock);
+	if (iommu->outgoing_preserved_state) {
+		iommu->outgoing_preserved_state->hdr.ref_count++;
+		return 0;
+	}
+
+	iommu_hw_ser = alloc_iommu_hw_ser(flb_obj);
+	if (IS_ERR(iommu_hw_ser))
+		return PTR_ERR(iommu_hw_ser);
+
+	ret = iommu->ops->preserve(iommu, iommu_hw_ser);
+	if (ret) {
+		iommu_hw_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
+		return ret;
+	}
+
+	iommu->outgoing_preserved_state = iommu_hw_ser;
+	return ret;
+}
+
+static void iommu_unpreserve_locked(struct iommu_device *iommu,
+				    struct iommu_flb_obj *flb_obj)
+{
+	struct iommu_hw_ser *iommu_hw_ser = iommu->outgoing_preserved_state;
+
+	lockdep_assert_held(&flb_obj->lock);
+	if (WARN_ON(!iommu_hw_ser))
+		return;
+
+	if (WARN_ON_ONCE(!iommu->ops->preserve ||
+			 !iommu->ops->unpreserve))
+		return;
+
+	iommu_hw_ser->hdr.ref_count--;
+	if (iommu_hw_ser->hdr.ref_count)
+		return;
+
+	iommu->outgoing_preserved_state = NULL;
+	iommu->ops->unpreserve(iommu, iommu_hw_ser);
+	iommu_hw_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
+}
+
+static struct iommu_device_ser *alloc_iommu_device_ser(struct iommu_flb_obj *flb)
+{
+	int idx;
+
+	idx = alloc_object_ser((void **)&flb->curr_device_array,
+			       iommu_max_objs_per_page(flb->curr_device_array));
+	if (idx < 0)
+		return ERR_PTR(idx);
+
+	flb->curr_device_array->objects[idx].hdr.ref_count = 1;
+	return &flb->curr_device_array->objects[idx];
+}
+
+/**
+ * iommu_preserve_device() - Preserve device state across live update
+ * @domain: Associated IOMMU domain
+ * @dev: Device to preserve
+ * @dma_owner_token: Token to identify DMA owner of this device
+ *
+ * Return: 0 on success, or negative error code.
+ */
+int iommu_preserve_device(struct iommu_domain *domain,
+			  struct device *dev, u64 dma_owner_token)
+{
+	struct iommu_device_ser *device_ser;
+	struct iommu_flb_obj *flb_obj;
+	struct dev_iommu *iommu;
+	struct pci_dev *pdev;
+	int ret;
+
+	if (!dev_is_pci(dev))
+		return -EOPNOTSUPP;
+
+	if (!iommu_group_dma_owner_claimed(dev->iommu_group))
+		return -EINVAL;
+
+	pdev = to_pci_dev(dev);
+	iommu = dev->iommu;
+	if (!iommu->iommu_dev->ops->preserve_device ||
+	    !iommu->iommu_dev->ops->unpreserve_device ||
+	    !iommu->iommu_dev->ops->preserve ||
+	    !iommu->iommu_dev->ops->unpreserve)
+		return -EOPNOTSUPP;
+
+	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
+	if (ret)
+		return ret;
+
+	mutex_lock(&flb_obj->lock);
+	if (!domain->preserved_state) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	if (dev_iommu_preserved_state(dev)) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	device_ser = alloc_iommu_device_ser(flb_obj);
+	if (IS_ERR(device_ser)) {
+		ret = PTR_ERR(device_ser);
+		goto out_unlock;
+	}
+
+	ret = iommu_preserve_locked(iommu->iommu_dev, flb_obj);
+	if (ret) {
+		device_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
+		goto out_unlock;
+	}
+
+	device_ser->domain_iommu_ser.domain_phys = virt_to_phys(domain->preserved_state);
+	device_ser->domain_iommu_ser.iommu_phys = virt_to_phys(iommu->iommu_dev->outgoing_preserved_state);
+	device_ser->devid = pci_dev_id(pdev);
+	device_ser->pci_domain_nr = pci_domain_nr(pdev->bus);
+	device_ser->dma_owner_token = dma_owner_token;
+
+	ret = iommu->iommu_dev->ops->preserve_device(dev, device_ser);
+	if (!ret) {
+		WRITE_ONCE(dev->iommu->device_ser, device_ser);
+
+		/* Validate that no sibling device was added concurrently */
+		if (!iommu_group_is_singleton(dev->iommu_group)) {
+			iommu->iommu_dev->ops->unpreserve_device(dev, device_ser);
+			WRITE_ONCE(dev->iommu->device_ser, NULL);
+			ret = -EOPNOTSUPP;
+		}
+	}
+
+	if (ret) {
+		device_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
+		iommu_unpreserve_locked(iommu->iommu_dev, flb_obj);
+		goto out_unlock;
+	}
+
+out_unlock:
+	mutex_unlock(&flb_obj->lock);
+	liveupdate_flb_put_outgoing(&iommu_flb);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_preserve_device);
+
+/**
+ * iommu_unpreserve_device() - Unpreserve device state
+ * @domain: Associated IOMMU domain
+ * @dev: Device to unpreserve
+ */
+void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev)
+{
+	struct iommu_device_ser *iommu_device_ser;
+	struct iommu_flb_obj *flb_obj;
+	struct dev_iommu *iommu;
+	int ret;
+
+	if (!dev_is_pci(dev))
+		return;
+
+	if (!iommu_group_dma_owner_claimed(dev->iommu_group))
+		return;
+
+	iommu = dev->iommu;
+	if (WARN_ON(!iommu->iommu_dev->ops->unpreserve_device ||
+		    !iommu->iommu_dev->ops->unpreserve))
+		return;
+
+	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
+	if (WARN_ON(ret))
+		return;
+
+	mutex_lock(&flb_obj->lock);
+	iommu_device_ser = dev_iommu_preserved_state(dev);
+	if (WARN_ON(!iommu_device_ser))
+		goto out_unlock;
+
+	iommu_device_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
+	iommu->iommu_dev->ops->unpreserve_device(dev, iommu_device_ser);
+	WRITE_ONCE(dev->iommu->device_ser, NULL);
+
+	iommu_unpreserve_locked(iommu->iommu_dev, flb_obj);
+out_unlock:
+	mutex_unlock(&flb_obj->lock);
+	liveupdate_flb_put_outgoing(&iommu_flb);
+}
+EXPORT_SYMBOL_GPL(iommu_unpreserve_device);
diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
index caa9778eee2d..536bea09d064 100644
--- a/include/linux/iommu-liveupdate.h
+++ b/include/linux/iommu-liveupdate.h
@@ -8,6 +8,7 @@
 #ifndef _LINUX_IOMMU_LIVEUPDATE_H
 #define _LINUX_IOMMU_LIVEUPDATE_H
 
+#include <linux/device.h>
 #include <linux/iommu.h>
 #include <linux/liveupdate.h>
 #include <linux/kho/abi/iommu.h>
@@ -15,8 +16,43 @@
 #ifdef CONFIG_IOMMU_LIVEUPDATE
 int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler);
 void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler);
+
+/**
+ * dev_iommu_preserved_state() - Get preserved state of a device
+ * @dev: Target device
+ *
+ * Return: Pointer to preserved device state, or NULL if not preserved.
+ */
+static inline void *dev_iommu_preserved_state(struct device *dev)
+{
+	struct iommu_device_ser *ser;
+
+	if (!dev->iommu)
+		return NULL;
+
+	ser = READ_ONCE(dev->iommu->device_ser);
+	if (ser && !(ser->hdr.flags & IOMMU_SER_FLAG_INCOMING))
+		return ser;
+
+	return NULL;
+}
+
 int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser);
 void iommu_unpreserve_domain(struct iommu_domain *domain);
+int iommu_preserve_device(struct iommu_domain *domain,
+			  struct device *dev, u64 dma_owner_token);
+void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev);
+
+/**
+ * iommu_preserved_state() - Get preserved state of an IOMMU instance
+ * @iommu: IOMMU hardware instance
+ *
+ * Return: Pointer to preserved state, or NULL if not preserved.
+ */
+static inline void *iommu_preserved_state(struct iommu_device *iommu)
+{
+	return iommu->outgoing_preserved_state;
+}
 #else
 static inline int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler)
 {
@@ -27,6 +63,11 @@ static inline void iommu_liveupdate_unregister_flb(struct liveupdate_file_handle
 {
 }
 
+static inline void *dev_iommu_preserved_state(struct device *dev)
+{
+	return NULL;
+}
+
 static inline int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser)
 {
 	return -EOPNOTSUPP;
@@ -35,5 +76,20 @@ static inline int iommu_preserve_domain(struct iommu_domain *domain, struct iomm
 static inline void iommu_unpreserve_domain(struct iommu_domain *domain)
 {
 }
+
+static inline int iommu_preserve_device(struct iommu_domain *domain,
+					struct device *dev, u64 dma_owner_token)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev)
+{
+}
+
+static inline void *iommu_preserved_state(struct iommu_device *iommu)
+{
+	return NULL;
+}
 #endif
 #endif /* _LINUX_IOMMU_LIVEUPDATE_H */
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 26de40d5a98e..920abd777879 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -684,6 +684,10 @@ __iommu_copy_struct_to_user(const struct iommu_user_data *dst_data,
  *               resources shared/passed to user space IOMMU instance. Associate
  *               it with a nesting @parent_domain. It is required for driver to
  *               set @viommu->ops pointing to its own viommu_ops
+ * @preserve_device: Preserve state of a device for liveupdate.
+ * @unpreserve_device: Unpreserve state that was preserved earlier.
+ * @preserve: Preserve state of iommu translation hardware for liveupdate.
+ * @unpreserve: Unpreserve state of iommu that was preserved earlier.
  * @owner: Driver module providing these ops
  * @identity_domain: An always available, always attachable identity
  *                   translation.
@@ -740,6 +744,13 @@ struct iommu_ops {
 			   struct iommu_domain *parent_domain,
 			   const struct iommu_user_data *user_data);
 
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	int (*preserve_device)(struct device *dev, struct iommu_device_ser *device_ser);
+	void (*unpreserve_device)(struct device *dev, struct iommu_device_ser *device_ser);
+	int (*preserve)(struct iommu_device *iommu, struct iommu_hw_ser *iommu_ser);
+	void (*unpreserve)(struct iommu_device *iommu, struct iommu_hw_ser *iommu_ser);
+#endif
+
 	const struct iommu_domain_ops *default_domain_ops;
 	struct module *owner;
 	struct iommu_domain *identity_domain;
@@ -827,6 +838,8 @@ struct iommu_domain_ops {
  * @singleton_group: Used internally for drivers that have only one group
  * @max_pasids: number of supported PASIDs
  * @ready: set once iommu_device_register() has completed successfully
+ * @outgoing_preserved_state: preserved iommu state of outgoing kernel for
+ * liveupdate.
  */
 struct iommu_device {
 	struct list_head list;
@@ -836,6 +849,10 @@ struct iommu_device {
 	struct iommu_group *singleton_group;
 	u32 max_pasids;
 	bool ready;
+
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	struct iommu_hw_ser *outgoing_preserved_state;
+#endif
 };
 
 /**
@@ -890,6 +907,9 @@ struct dev_iommu {
 	u32				pci_32bit_workaround:1;
 	u32				require_direct:1;
 	u32				shadow_on_flush:1;
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	struct iommu_device_ser		*device_ser;
+#endif
 };
 
 int iommu_device_register(struct iommu_device *iommu,
@@ -1206,6 +1226,28 @@ static inline void *dev_iommu_priv_get(struct device *dev)
 
 void dev_iommu_priv_set(struct device *dev, void *priv);
 
+/**
+ * typedef iommu_dev_iter_fn - Callback for iterating IOMMU attached devices
+ * @dev: Attached device
+ * @iommu: IOMMU instance
+ * @arg: Private argument passed to iterator
+ *
+ * Return: 0 on success, or negative error code.
+ */
+typedef int (*iommu_dev_iter_fn)(struct device *dev,
+				 struct iommu_device *iommu, void *arg);
+
+/**
+ * struct iommu_dev_iter - Iterator for devices attached to an IOMMU
+ */
+struct iommu_dev_iter {
+	struct iommu_device *iommu;
+	iommu_dev_iter_fn fn;
+	void *arg;
+};
+
+int iommu_for_each_dev(struct iommu_dev_iter *iter);
+
 extern struct mutex iommu_probe_device_lock;
 int iommu_probe_device(struct device *dev);
 
-- 
2.55.0.1082.g2b9226bbc0-goog

