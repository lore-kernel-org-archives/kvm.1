Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744DA2C15AC
	for <kvm@vger.kernel.org>; Sat,  8 Aug 2026 02:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786156057; cv=none; b=WZQ9vDlr3/iCs6Yjj2hPyA+1Z3/PvA1XWlMWv6APApcqxpgVCvLVmp4vVs8xjboXQ4+jI8/kovSfewWMsL5g2cKBEbM3yWk9eTqAnXah37qp8fpCA4KmF+Rw+65OZWDbSxDi05UNg8oa2m/SncdV5+H81/iiiH5tU5jISuXDLB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786156057; c=relaxed/simple;
	bh=ip71MmLOoBOIbbqtRadQTPrywwbZPjG68OQ4Npd+kyQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GkD5UV1cLyupDcx9WJ/DFQb5O2HpNVdK/o32fk7CXAvkVjS010FRdxD2yNaIuAwFIpaJr82rC9C9aUgG4z1maNDMw89NJL1lbbrRhnMnQGszeUZNbjvJcD6UU182P5ntQKV5G3dGdSDiXqkTFunzKYzdqfrghfVw6v2HQv4AW2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JN+76Ixo; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JN+76Ixo"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d001671a54so4864885ad.2
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 19:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786156054; x=1786760854; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U9aq/ndCl42b8D0YlVMARkvClEBGDZHcUWfZhtKAtSY=;
        b=JN+76Ixom3cld7Dpk8TXK86v/piGYmfxtC7SaCNVdTLyMxetM/ZtRDTU1juTvH+AEP
         gQthtU9dCaS1b64CBSLktYEZ9mXKCpt8ANnrpa+o2AJjaTd7kkOkOo6azS7juJS/u81Z
         5RvUfns+ZeemisB9L/6w5lpWrf8Ux2jJ+QklwqymR7QweoBXMUzPrzBgiQPKrJtUixzW
         rLeRVZGwVbh1DXryuuJXh6sjeHeULvU4QHd2D6MLl4uBwyLEhPYAcv19uT53LY/EtucY
         jegAcH1qQLdzH2ym0zXf2hPRzhFDv/D7jLBzjyxmqrII9GPzB0GPEOiX8NcBJpEdQpxF
         pw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786156054; x=1786760854;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U9aq/ndCl42b8D0YlVMARkvClEBGDZHcUWfZhtKAtSY=;
        b=E6XbtyNlVSFhFOdW1Qi/gfRY7EoQLrShaIE/sNYG/lwJhEIjP4/IN+lnb1VJd4i74r
         Uw6GeMv8S1j7QbiZ8xRKIr6l5YXq4uxx8ICi9qwrnBMJcADIbXtkDVHX8AUEYbyi6/F1
         gWQ74MFcQB4GQf8g7yIDjVRhe/N3g4PNiA17O9IcunsZZMIGf01YSZt0fsWUr2GzF3Ep
         rV0Es8qIyNRrQTdklGFn6/saHYgk0R2bRoILSDSCd7U/92CYUGPANmd8zutPnw3JJtI9
         4jU9S8y04Rbin2rPAQmTTmrrej1EeEWaROZ0SCHbgMHlG6TuIUvgJXiwcDA4Ju0Yh5OF
         d9Zw==
X-Forwarded-Encrypted: i=1; AHgh+Rq2EFMaQGLBUgxjWXYYpXjanHJpHcemggQAjm/j6dG3ztTKgm2fRuDGqEkwrBx6SdJ7Ms0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLuvzRBVu4OQNrIzeM4HYD8JF0BMokEuP+y9/OaZRgfeRXEJ62
	Jvozo5c0uM+XShVuSDwGgiXI2iddSwmR43JHzs4XOv/m4AfpzMcYtaDf/aaVQeSeIIbtrF92PWA
	ae577ykFqaZgW0Q==
X-Received: from plsk9.prod.google.com ([2002:a17:902:ba89:b0:2bc:ac01:8af8])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e5c6:b0:2ca:17e2:2acc with SMTP id d9443c01a7336-2d0ca9444damr299013585ad.21.1786156053316;
 Fri, 07 Aug 2026 19:27:33 -0700 (PDT)
Date: Sat,  8 Aug 2026 02:27:16 +0000
In-Reply-To: <20260808022723.3893618-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260808022723.3893618-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260808022723.3893618-12-skhawaja@google.com>
Subject: [PATCH v4 11/18] iommu: Restore and reattach preserved domains to devices
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

During default domain setup, restore the preserved domains by restoring
the page tables using restore() iommupt op. Associated the restored
domain with the iommu group of the preserved device, and reattach the
domain to the device.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/iommu.c            |  76 ++++++++++++++++++
 drivers/iommu/liveupdate.c       | 130 +++++++++++++++++++++++++++++++
 include/linux/iommu-liveupdate.h |  69 ++++++++++++++++
 3 files changed, 275 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index e00934af45d4..bed6050f8a80 100644
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
@@ -157,6 +158,7 @@ static void __iommu_group_set_domain_nofail(struct iommu_group *group,
 	WARN_ON(__iommu_group_set_domain_internal(
 		group, new_domain, IOMMU_SET_DOMAIN_MUST_SUCCEED));
 }
+static int __iommu_group_alloc_blocking_domain(struct iommu_group *group);
 
 static int iommu_setup_default_domain(struct iommu_group *group,
 				      int target_type);
@@ -539,6 +541,10 @@ static int iommu_init_device(struct device *dev)
 		goto err_free;
 	}
 
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	iommu_init_device_preserved_data(dev);
+#endif
+
 	iommu_dev = ops->probe_device(dev);
 	if (IS_ERR(iommu_dev)) {
 		ret = PTR_ERR(iommu_dev);
@@ -810,6 +816,9 @@ static void iommu_release_device(struct device *dev)
 {
 	struct iommu_group *group = dev->iommu_group;
 
+	if (dev_iommu_restored_state(dev))
+		iommu_release_restored_device(dev);
+
 	if (group)
 		__iommu_group_remove_device(dev);
 
@@ -2202,6 +2211,7 @@ static int __iommu_attach_device(struct iommu_domain *domain,
 	ret = domain->ops->attach_dev(domain, dev, old);
 	if (ret)
 		return ret;
+
 	dev->iommu->attach_deferred = 0;
 	trace_attach_device_to_domain(dev);
 	return 0;
@@ -3166,6 +3176,62 @@ int iommu_fwspec_add_ids(struct device *dev, const u32 *ids, int num_ids)
 }
 EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
 
+static struct device *__iommu_group_restored_device(struct iommu_group *group)
+{
+	struct group_device *gdev;
+
+	lockdep_assert_held(&group->mutex);
+	for_each_group_device(group, gdev) {
+		if (!dev_is_pci(gdev->dev))
+			continue;
+
+		if (dev_iommu_restored_state(gdev->dev))
+			return gdev->dev;
+	}
+
+	return NULL;
+}
+
+static int __iommu_group_restore_domain(struct iommu_group *group)
+{
+	struct iommu_device_ser *device_ser;
+	struct iommu_domain *domain;
+	struct device *dev;
+	void *owner;
+	int ret;
+
+	lockdep_assert_held(&group->mutex);
+	if (group->domain)
+		return -EBUSY;
+
+	dev = __iommu_group_restored_device(group);
+	device_ser = dev_iommu_restored_state(dev);
+	if (!device_ser)
+		return -ENOENT;
+
+	ret = __iommu_group_alloc_blocking_domain(group);
+	if (ret)
+		return ret;
+
+	domain = iommu_restore_domain(dev, device_ser, &owner);
+	if (WARN_ON(IS_ERR(domain)))
+		return PTR_ERR(domain);
+
+	/* The restored domain is attached with the restored device. */
+	ret = __iommu_group_set_domain(group, domain);
+	if (ret)
+		return ret;
+
+	/*
+	 * Ownership of groups with preserved devices is set during boot. These
+	 * will be reclaimed later by the entity (iommufd) that preserved them.
+	 */
+	WARN_ON(group->owner);
+	group->owner = owner;
+	group->owner_cnt = 1;
+	return ret;
+}
+
 /**
  * iommu_setup_default_domain - Set the default_domain for the group
  * @group: Group to change
@@ -3224,6 +3290,16 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 
 	/* We must set default_domain early for __iommu_device_set_domain */
 	group->default_domain = dom;
+
+	/* Preserved devices need to be attached to the restore domain */
+	if (__iommu_group_restored_device(group)) {
+		ret = __iommu_group_restore_domain(group);
+		if (ret)
+			goto err_restore_def_domain;
+
+		goto out_free_old;
+	}
+
 	if (!group->domain) {
 		/*
 		 * Drivers are not allowed to fail the first domain attach.
diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
index 20acf123b47a..04c0212cd81b 100644
--- a/drivers/iommu/liveupdate.c
+++ b/drivers/iommu/liveupdate.c
@@ -708,3 +708,133 @@ void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev)
 	liveupdate_flb_put_outgoing(&iommu_flb);
 }
 EXPORT_SYMBOL_GPL(iommu_unpreserve_device);
+
+static inline bool match_device_ser(struct iommu_device_ser *match,
+				    struct pci_dev *pdev)
+{
+	return match->devid == pci_dev_id(pdev) && match->pci_domain_nr == pci_domain_nr(pdev->bus);
+}
+
+/**
+ * iommu_init_device_preserved_data() - Initialize preserved state for device
+ * @dev: Target device
+ *
+ * Looks up incoming Live Update state for @dev and attaches it to the device if
+ * found.
+ */
+void iommu_init_device_preserved_data(struct device *dev)
+{
+	struct iommu_device_ser *device_ser = NULL;
+	struct iommu_device_array_ser *array;
+	struct iommu_flb_obj *flb_obj;
+	int ret, idx;
+
+	if (!dev_is_pci(dev))
+		return;
+
+	ret = iommu_liveupdate_flb_get_incoming(&flb_obj);
+	if (ret)
+		return;
+
+	mutex_lock(&flb_obj->lock);
+	array = phys_to_virt(flb_obj->ser->device_array_phys);
+	iommu_liveupdate_for_each_arr(array) {
+		iommu_liveupdate_for_each_obj(array, device_ser, idx) {
+			if (match_device_ser(device_ser, to_pci_dev(dev))) {
+				device_ser->hdr.flags |= IOMMU_SER_FLAG_INCOMING;
+				goto out;
+			}
+		}
+	}
+
+	device_ser = NULL;
+out:
+	WRITE_ONCE(dev->iommu->device_ser, device_ser);
+	mutex_unlock(&flb_obj->lock);
+	liveupdate_flb_put_incoming(&iommu_flb);
+}
+EXPORT_SYMBOL(iommu_init_device_preserved_data);
+
+/**
+ * iommu_release_restored_device() - Release a restored device
+ * @dev: Target device
+ */
+void iommu_release_restored_device(struct device *dev)
+{
+	/*
+	 * We do not support releasing the restored devices that are not
+	 * reclaimed by the device drivers as they can fallback to the default
+	 * domain.
+	 */
+	BUG_ON(dev_iommu_restored_state(dev));
+}
+
+/**
+ * iommu_restore_domain() - Restore a preserved domain for a device
+ * @dev: Target device
+ * @ser: Serialized device state
+ * @owner: Pointer to store group owner handle
+ *
+ * Restores or reuses a restored preserved domain for @dev from serialized state
+ * @ser.
+ *
+ * Return: Restored iommu_domain pointer, or ERR_PTR.
+ */
+struct iommu_domain *iommu_restore_domain(struct device *dev,
+					  struct iommu_device_ser *ser,
+					  void **owner)
+{
+	struct iommu_domain_ser *domain_ser;
+	struct iommu_flb_obj *flb_obj;
+	struct iommu_domain *domain;
+	struct pt_iommu *pt;
+	int ret;
+
+	ret = iommu_liveupdate_flb_get_incoming(&flb_obj);
+	if (ret)
+		return ERR_PTR(ret);
+
+	mutex_lock(&flb_obj->lock);
+
+	/* Preserved device should have a preserved domain */
+	if (!ser->domain_iommu_ser.domain_phys) {
+		domain = ERR_PTR(-EINVAL);
+		goto out;
+	}
+
+	domain_ser = phys_to_virt(ser->domain_iommu_ser.domain_phys);
+	if (domain_ser->restored_domain) {
+		*owner = ser;
+		domain = domain_ser->restored_domain;
+		goto out;
+	}
+
+	domain_ser->hdr.flags |=  IOMMU_SER_FLAG_INCOMING;
+	domain = iommu_paging_domain_alloc(dev);
+	if (IS_ERR(domain))
+		goto out;
+
+	pt = iommupt_from_domain(domain);
+	if (!pt) {
+		iommu_domain_free(domain);
+		domain = ERR_PTR(-EOPNOTSUPP);
+		goto out;
+	}
+
+	ret = pt->ops->restore(pt, domain_ser);
+	if (ret) {
+		iommu_domain_free(domain);
+		domain = ERR_PTR(ret);
+		goto out;
+	}
+
+	/* The device is owned by the preserved state. */
+	*owner = ser;
+	domain->preserved_state = domain_ser;
+	domain_ser->restored_domain = domain;
+
+out:
+	mutex_unlock(&flb_obj->lock);
+	liveupdate_flb_put_incoming(&iommu_flb);
+	return domain;
+}
diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
index 891a77e86c88..02cc59d9156c 100644
--- a/include/linux/iommu-liveupdate.h
+++ b/include/linux/iommu-liveupdate.h
@@ -64,14 +64,58 @@ static inline void *iommu_domain_restored_state(struct iommu_domain *domain)
 	return NULL;
 }
 
+/**
+ * dev_iommu_restored_state() - Get restored state of a device
+ * @dev: Target device
+ *
+ * Return: Restored state pointer or NULL.
+ */
+static inline void *dev_iommu_restored_state(struct device *dev)
+{
+	struct iommu_device_ser *ser;
+
+	if (!dev->iommu)
+		return NULL;
+
+	ser = READ_ONCE(dev->iommu->device_ser);
+	if (ser && (ser->hdr.flags & IOMMU_SER_FLAG_INCOMING))
+		return ser;
+
+	return NULL;
+}
+
+/**
+ * dev_iommu_restore_did() - Get restored domain ID for a device
+ * @dev: Target device
+ * @domain: Target domain
+ *
+ * Fetches the domain ID preserved for @dev and @domain across Live Update.
+ *
+ * Return: Domain ID or -1 on error.
+ */
+static inline int dev_iommu_restore_did(struct device *dev, struct iommu_domain *domain)
+{
+	struct iommu_device_ser *ser = dev_iommu_restored_state(dev);
+
+	if (ser && iommu_domain_restored_state(domain))
+		return ser->domain_iommu_ser.attachment_id;
+
+	return -1;
+}
+
+struct iommu_domain *iommu_restore_domain(struct device *dev,
+					  struct iommu_device_ser *ser,
+					  void **owner);
 int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn,
 				    void *arg);
+void iommu_init_device_preserved_data(struct device *dev);
 struct iommu_hw_ser *iommu_get_preserved_data(u64 token, enum iommu_type_ser type);
 int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser);
 void iommu_unpreserve_domain(struct iommu_domain *domain);
 int iommu_preserve_device(struct iommu_domain *domain,
 			  struct device *dev, u64 *preserved_state);
 void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev);
+void iommu_release_restored_device(struct device *dev);
 
 /**
  * iommu_preserved_state() - Get preserved state of an IOMMU instance
@@ -98,16 +142,37 @@ static inline void *dev_iommu_preserved_state(struct device *dev)
 	return NULL;
 }
 
+static inline void *dev_iommu_restored_state(struct device *dev)
+{
+	return NULL;
+}
+
+static inline int dev_iommu_restore_did(struct device *dev, struct iommu_domain *domain)
+{
+	return -1;
+}
+
 static inline void *iommu_domain_restored_state(struct iommu_domain *domain)
 {
 	return NULL;
 }
 
+static inline struct iommu_domain *iommu_restore_domain(struct device *dev,
+							struct iommu_device_ser *ser,
+							void **owner)
+{
+	return NULL;
+}
+
 static inline int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn, void *arg)
 {
 	return -EOPNOTSUPP;
 }
 
+static inline void iommu_init_device_preserved_data(struct device *dev)
+{
+}
+
 static inline struct iommu_hw_ser *iommu_get_preserved_data(u64 token, enum iommu_type_ser type)
 {
 	return NULL;
@@ -132,6 +197,10 @@ static inline void iommu_unpreserve_device(struct iommu_domain *domain, struct d
 {
 }
 
+static inline void iommu_release_restored_device(struct device *dev)
+{
+}
+
 static inline void *iommu_preserved_state(struct iommu_device *iommu)
 {
 	return NULL;
-- 
2.55.0.679.g6767b8d81c-goog

