Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792894782;
	b=eeSTSf6+KsHAItKeixHHCET6ThqTvbiJHSanF/MNsyDQ77AmET56PB0LYvROKV4YbImf
	 eOz+0NtGC77/AfEfTytUfjRBWztIU+8gZ/qqcokZpb1GvAGb0w9QkXdbYcrHEXYYewmZ0
	 nRpGY+L2hn0WcL/TA2DL+9uAqoeg5J/YqtJD0KXZ02ro+lqngs2O+Ig2mSu1/RMknrlrS
	 kyQTxjwaWrLAixb2Dzk/UgqArgOdjFLDfQq9YCklAwrsMWndaDhzpvvEsnSE8ylCkmPi6
	 Pig27MdMm5ZAnHUr9VHhTctPZbfTYAlEAWZHIoQhWGpWUWrMHnmUG+r2jIIbUTB0cJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792894782;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Pf8VQvmpPYI4IRQsuArgnHt9OyBUwXE7RVQYQl+rb14=;
	b=mcnYlh91sqGLIZ+GvDDXX58whcyWD5NnU7cZ40rw1EM0a6oWiUoXtT2GSEoEP4gKxVbl
	 mBXc6NiD+IMRULt0odFTg34UeG4XWUUmjIriei1RPaBTTt4h3EKtEvKnq11nIm74V2W4n
	 IYxCZl1e4GhKCZkp0kOnPn+I2t5ADAV+s3CFeDf9VLYhvZxoitpbZxR21W42TXDkznc3j
	 V4KyxkO4YsedeRSP2DeaNQek9OcIkHYTQguluOjOcn4uS1GD0hD+4A/qVSN05ZDBUrWZk
	 1gO4LJ6lSVkL5Hgz5CVZu0WoJOIFAGTZrTWw4H6qgAR1KMZjs9F2QfxqM4AIwtCQ9WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=DzCt+c1o;
	arc=none smtp.remote-ip=209.85.215.200
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84DB60A3804
	for <kvm@vger.kernel.org>; Sun, 25 Oct 2026 02:19:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B84DB60A3804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=DzCt+c1o
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cd0cf3b1c70so1175555a12.3
        for <kvm@vger.kernel.org>; Sat, 24 Oct 2026 19:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792894781; x=1793499581; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pf8VQvmpPYI4IRQsuArgnHt9OyBUwXE7RVQYQl+rb14=;
        b=DzCt+c1o4r4o94Vd1H9HvdKecddnVMIX2oipGBvXZZMwtxWA6ZBzyt8qlQpksDo8xN
         rx7auKrUITg1kse4N+7fFUkHpYaWGui7qrb3/0OA/7ppa5k/B6zlhYlVTLRd740Q9LBO
         juwjz196na20a7GwAxoAlQl7UcQCo/EwjKV9tNUXEhPNEmrVBM7aRRIeUxQsN4KmdTsd
         oe5hwCRK1t7lT1c3qSDzTFIxwZ+5qrx+4rMRRHZ2VySrc01MrkMeFKP0dbL0NZMdULtQ
         ZUj+r2K76pMWR8+ajvbCyfAHOnvSerZhf9yzMTPyQnaAaYkYCcAySWSkuxOK4Nac05bw
         1/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792894781; x=1793499581;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pf8VQvmpPYI4IRQsuArgnHt9OyBUwXE7RVQYQl+rb14=;
        b=O/otyDoMfo23fkYKfFDWIdGyWmWCkbiiTPuvMamJntqB5sOAebzPiNh6aZoG6oPlIU
         ZK/kybyVIIAPimWPxSQ++fMGYHcS66+8LIgcNiLDabEk2NtKxsbfkmWWMUtarVvwrN9b
         csCcnP7sr/N2zdbgn3FCmQOWHqsEnAVanAMI7MnitF6a0oIMnRbECIUHSVv1G6lIqyK2
         3akRvqhKB4st4HGGQ2H6xd4iDjbs5ltXcuik1B7822hhmGsal/8fTowvsubPr4Aitjo4
         I6LbDH1+qZEC9UEhZpD7a8uxjtm8h4sYULLMTaWJGNJ5NUCMWbOCxT5Y/if/5VCK6xbe
         xhlA==
X-Forwarded-Encrypted: i=1; AKwUvByeHB0dCeW3d40+z28QcJdlKKSX2atqQ29CJ4ZbOzF7Jtr99pHzo90W+itry7jQbyDAgKY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLGS/h7Rt4L2OiLBKhBNvm3BDbiPt6O4e2fGKEg+KLx8YYINOMO
	1ueepO0VLxgscUhJJodxs1B0IkRC7Ic6c+8KPRa0ix/fmV1ZdOL2Cw0wcOlpHYHJNjRk84IlF1d
	Kgyd1rUa5Fmj7IQ==
X-Received: from pgu31.prod.google.com ([2002:a63:145f:0:b0:cca:8b09:717])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:9182:b0:3e1:e53b:5005 with SMTP id adf61e73a8af0-3e7cd5402femr2824347637.65.1792894780872;
 Sat, 24 Oct 2026 19:19:40 -0700 (PDT)
Date: Sun, 25 Oct 2026 02:19:16 +0000
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
Message-ID: <20261025021930.674647-6-skhawaja@google.com>
Subject: [PATCH v6 05/18] iommu: Implement device and IOMMU HW preservation
From: Samiullah Khawaja <skhawaja@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Woodhouse <dwmw2@infradead.org>
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>, Ankit Soni <Ankit.Soni@amd.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
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
 drivers/iommu/iommu.c            |  72 +++++++++++-
 drivers/iommu/liveupdate.c       | 189 +++++++++++++++++++++++++++++++
 include/linux/iommu-liveupdate.h |  76 +++++++++++++
 include/linux/iommu.h            |  33 ++++++
 5 files changed, 371 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index 1f9f886b2c10..6b0ef210b32f 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -21,6 +21,8 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
 
 void dev_iommu_free(struct device *dev);
 
+bool iommu_group_is_singleton(struct iommu_group *group);
+
 const struct iommu_ops *iommu_ops_from_fwnode(const struct fwnode_handle *fwnode);
 
 static inline const struct iommu_ops *iommu_fwspec_ops(struct iommu_fwspec *fwspec)
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b486b8bbd1fc..a66363789ca9 100644
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
@@ -328,6 +329,47 @@ void iommu_device_unregister(struct iommu_device *iommu)
 }
 EXPORT_SYMBOL_GPL(iommu_device_unregister);
 
+struct iommu_dev_iter {
+	struct iommu_device *iommu;
+	iommu_dev_iter_fn fn;
+};
+
+static int _iommu_for_each_dev_cb(struct device *dev, void *data)
+{
+	struct iommu_dev_iter *iter = data;
+
+	if (dev->iommu && dev->iommu->iommu_dev == iter->iommu)
+		return iter->fn(dev, iter->iommu);
+
+	return 0;
+}
+
+/**
+ * iommu_for_each_dev() - Iterate over all devices attached to an IOMMU
+ * @iommu: IOMMU instance
+ * @fn: Callback to call for each device attached to @iommu
+ *
+ * Return: 0 on success, or negative error code.
+ */
+int iommu_for_each_dev(struct iommu_device *iommu, iommu_dev_iter_fn fn)
+{
+	struct iommu_dev_iter iter = {
+		.iommu = iommu,
+		.fn = fn,
+	};
+	int ret;
+
+	for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++) {
+		ret = bus_for_each_dev(iommu_buses[i], NULL, &iter,
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
@@ -626,8 +668,8 @@ DEFINE_MUTEX(iommu_probe_device_lock);
 
 static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
 {
+	struct group_device *gdev, *gdev2;
 	struct iommu_group *group;
-	struct group_device *gdev;
 	int ret;
 
 	/*
@@ -661,6 +703,13 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 		goto err_put_group;
 	}
 
+	for_each_group_device(group, gdev2) {
+		if (dev_iommu_has_preserved_state(gdev2->dev)) {
+			ret = -EBUSY;
+			goto err_free_gdev;
+		}
+	}
+
 	/*
 	 * The gdev must be in the list before calling
 	 * iommu_setup_default_domain()
@@ -697,6 +746,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 
 err_remove_gdev:
 	list_del(&gdev->list);
+err_free_gdev:
 	__iommu_group_free_device(group, gdev);
 err_put_group:
 	iommu_deinit_device(dev);
@@ -3543,6 +3593,26 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
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
index b7eda5615189..d1d11b28ae79 100644
--- a/drivers/iommu/liveupdate.c
+++ b/drivers/iommu/liveupdate.c
@@ -43,6 +43,9 @@
 #include <linux/kexec_handover.h>
 #include <linux/kho_block.h>
 #include <linux/liveupdate.h>
+#include <linux/pci.h>
+
+#include "iommu-priv.h"
 
 /**
  * struct iommu_ser_set - Set of serialized objects of one type
@@ -358,3 +361,189 @@ void iommu_unpreserve_domain(struct iommu_domain *domain)
 	liveupdate_flb_put_outgoing(&iommu_flb);
 }
 EXPORT_SYMBOL_GPL(iommu_unpreserve_domain);
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
+	if (iommu->iommu_ser) {
+		iommu->iommu_ser->hdr.ref_count++;
+		return 0;
+	}
+
+	iommu_hw_ser = iommu_ser_set_alloc(&flb_obj->iommu_set);
+	if (IS_ERR(iommu_hw_ser))
+		return PTR_ERR(iommu_hw_ser);
+
+	ret = iommu->ops->preserve(iommu, iommu_hw_ser);
+	if (ret) {
+		iommu_hw_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
+		return ret;
+	}
+
+	iommu->iommu_ser = iommu_hw_ser;
+	return ret;
+}
+
+static void iommu_unpreserve_locked(struct iommu_device *iommu,
+				    struct iommu_flb_obj *flb_obj)
+{
+	struct iommu_hw_ser *iommu_hw_ser = iommu->iommu_ser;
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
+	iommu->iommu_ser = NULL;
+	iommu->ops->unpreserve(iommu, iommu_hw_ser);
+	iommu_hw_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
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
+	if (!iommu_group_is_singleton(dev->iommu_group))
+		return -EOPNOTSUPP;
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
+	if (!domain->domain_ser) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	if (dev_iommu_preserved_state(dev)) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	device_ser = iommu_ser_set_alloc(&flb_obj->device_set);
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
+	device_ser->attachment.domain_phys = virt_to_phys(domain->domain_ser);
+	device_ser->iommu_phys = virt_to_phys(iommu->iommu_dev->iommu_ser);
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
index caa9778eee2d..cdf8a82b7f1d 100644
--- a/include/linux/iommu-liveupdate.h
+++ b/include/linux/iommu-liveupdate.h
@@ -8,6 +8,7 @@
 #ifndef _LINUX_IOMMU_LIVEUPDATE_H
 #define _LINUX_IOMMU_LIVEUPDATE_H
 
+#include <linux/device.h>
 #include <linux/iommu.h>
 #include <linux/liveupdate.h>
 #include <linux/kho/abi/iommu.h>
@@ -15,8 +16,58 @@
 #ifdef CONFIG_IOMMU_LIVEUPDATE
 int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler);
 void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler);
+
+/**
+ * dev_iommu_has_preserved_state() - Check if a device has live update state
+ * @dev: Target device
+ *
+ * Unlike dev_iommu_preserved_state() and dev_iommu_restored_state(), this does
+ * not dereference the serialized state, so it is safe to call without holding
+ * a reference on the live update FLB.
+ *
+ * Return: true if @dev has preserved (outgoing) or restored (incoming) state.
+ */
+static inline bool dev_iommu_has_preserved_state(struct device *dev)
+{
+	return dev->iommu && READ_ONCE(dev->iommu->device_ser);
+}
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
+	return iommu->iommu_ser;
+}
 #else
 static inline int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler)
 {
@@ -27,6 +78,16 @@ static inline void iommu_liveupdate_unregister_flb(struct liveupdate_file_handle
 {
 }
 
+static inline bool dev_iommu_has_preserved_state(struct device *dev)
+{
+	return false;
+}
+
+static inline void *dev_iommu_preserved_state(struct device *dev)
+{
+	return NULL;
+}
+
 static inline int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser)
 {
 	return -EOPNOTSUPP;
@@ -35,5 +96,20 @@ static inline int iommu_preserve_domain(struct iommu_domain *domain, struct iomm
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
index 71e73c5181b5..35d028fe7126 100644
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
@@ -827,6 +838,7 @@ struct iommu_domain_ops {
  * @singleton_group: Used internally for drivers that have only one group
  * @max_pasids: number of supported PASIDs
  * @ready: set once iommu_device_register() has completed successfully
+ * @iommu_ser: preserved iommu state of outgoing kernel for liveupdate.
  */
 struct iommu_device {
 	struct list_head list;
@@ -836,6 +848,10 @@ struct iommu_device {
 	struct iommu_group *singleton_group;
 	u32 max_pasids;
 	bool ready;
+
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	struct iommu_hw_ser *iommu_ser;
+#endif
 };
 
 /**
@@ -875,6 +891,8 @@ struct iommu_fault_param {
  * @pci_32bit_workaround: Limit DMA allocations to 32-bit IOVAs
  * @require_direct: device requires IOMMU_RESV_DIRECT regions
  * @shadow_on_flush: IOTLB flushes are used to sync shadow tables
+ * @device_ser: preserved (outgoing) or restored (incoming) liveupdate state
+ *		of this device
  *
  * TODO: migrate other per device data pointers under iommu_dev_data, e.g.
  *	struct iommu_group	*iommu_group;
@@ -890,6 +908,9 @@ struct dev_iommu {
 	u32				pci_32bit_workaround:1;
 	u32				require_direct:1;
 	u32				shadow_on_flush:1;
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	struct iommu_device_ser		*device_ser;
+#endif
 };
 
 int iommu_device_register(struct iommu_device *iommu,
@@ -1204,6 +1225,18 @@ static inline void *dev_iommu_priv_get(struct device *dev)
 
 void dev_iommu_priv_set(struct device *dev, void *priv);
 
+/**
+ * typedef iommu_dev_iter_fn - Callback for iterating IOMMU attached devices
+ * @dev: Attached device
+ * @iommu: IOMMU instance
+ *
+ * Return: 0 on success, or negative error code.
+ */
+typedef int (*iommu_dev_iter_fn)(struct device *dev,
+				 struct iommu_device *iommu);
+
+int iommu_for_each_dev(struct iommu_device *iommu, iommu_dev_iter_fn fn);
+
 extern struct mutex iommu_probe_device_lock;
 int iommu_probe_device(struct device *dev);
 
-- 
2.56.0.257.gf7497c7d27-goog

