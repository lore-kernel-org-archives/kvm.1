Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E9E385D6B
	for <kvm@vger.kernel.org>; Sun, 14 Jun 2026 23:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781480261; cv=none; b=Piatn/W5WDHJ7TQ6HIYLWS624Wf6rQPTn5LnY+RQO94rIgsFfKDeMM0drTkZsfXwBL09ZzVhhxy9KVDzmhIkzaoIBmyrbvZgCLZKJUuQy/KB2V6uJNm8f6nFkXatGpGV0ThMrQhIZ1cOq5tu3B43T2o98NhbMHJ1EnS6dh/a6Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781480261; c=relaxed/simple;
	bh=gJcCWuSa2tPgXxQm52WqQaf0NsMtzV5lBuq1/jQnXAU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=prxySfv40xo+W2PBmDV7SmhdxY7PSGVXG433ML9Su7gibtdGliN12FZ6HxUcRBBjuIiavYX5KW7fXEwig5GrEr1pbJcKwyVhqR8q3CG5OSr2H28aqX9v9EJN++4JEwDGG4ckxpTm+4b+Kogd3raMGHn8eY/20HOR1Al3Mj32Rp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EzQjJi9S; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EzQjJi9S"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf004bf8beso34762995ad.3
        for <kvm@vger.kernel.org>; Sun, 14 Jun 2026 16:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781480259; x=1782085059; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rTbSdIBLoQ3ymz5Oo8C6SttlitRISpaU0y1we7JmTLI=;
        b=EzQjJi9SJkbfjW20Pi81Ug+Uia/oJZ3NkOdU2+8wB/UOvk5vwXlZPkl89KNDr64GWq
         VdOu7o7U//A8ukklZbJoZlIG9sl+rk0iu2OCFNhvRgOFK/tR4VnC9PgyxIkWW1eROM5D
         mboN5ZOFXfIYfeLvAqChUJVMhA18/H3B75r+MtJ5jRhNfcafvb1qeyt8NgjCS6uh7D0p
         0/KdinZyOsm9Wm7/OCUmYfcKfCtqPMhAW20+5bueJghVI4LfP5nGiruE9bUC6dzRIiro
         efk30xDg03HX5mqG0k2quTPTb07n+GtGxdCqGUjZUb0ueVUPSgf/UVyfHnl7SDOt6uy+
         0CHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781480259; x=1782085059;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rTbSdIBLoQ3ymz5Oo8C6SttlitRISpaU0y1we7JmTLI=;
        b=FEB+a1Iv2HgpBUvsz1NBztM5ChlVFL1Kb3QfEt+Y0npIxsdhZMyxY8goTTyr04Psjz
         xJE7J2jt88e0pBz4y4Hq/tZORblQiYUQ19thmnT5FVMEfP+lVOMZ5b6yMaFJcsjHOjj4
         uvV/K2UaCrDo+lR9KrOzCClrordh+jTRjlfow7+zIP8tlUQFOc4jzOiqG19L6R3DQ/rM
         4LCKV0qH7B6k/dmZ6/93WfFWWzd4Gn5rG5etqdu8PCGIOgvJKMRH+ta67OiCh/PM8iEv
         sNrpsF46vLbYuAIGxa+i9p0EfU5FQTvNZZLiAnnWP51jrv+J2u9f0ZXY9jJbuclDCTFZ
         7VZw==
X-Forwarded-Encrypted: i=1; AFNElJ8a0aZHl5G3sdNb3M8Q61/kE0LxcOAv7+iyTIhQF35Do/oSk7jEFxFVLJMKCgVLPJfThB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YynHjVzhi39pZdsf7CFx8uEgHviMuCx7IXfxaWmKcDo43jraYAP
	ttxGUTlNwu24t9FJWatsMarJNBBipJPl3JUg54csAWvKGywOSgfYHEhYpszdwaTc82WNj2+hzOE
	+vMTqkbtLBA+xTg==
X-Received: from plblv16.prod.google.com ([2002:a17:903:2a90:b0:2c0:bd65:1a98])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ebc3:b0:2c2:27be:39a8 with SMTP id d9443c01a7336-2c66428edefmr91597125ad.31.1781480258491;
 Sun, 14 Jun 2026 16:37:38 -0700 (PDT)
Date: Sun, 14 Jun 2026 23:37:21 +0000
In-Reply-To: <20260614233728.2212104-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260614233728.2212104-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260614233728.2212104-12-skhawaja@google.com>
Subject: [PATCH v3 11/18] iommu: Restore and reattach preserved domains to devices
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
 drivers/iommu/iommu.c            | 65 ++++++++++++++++++++-
 drivers/iommu/liveupdate.c       | 97 ++++++++++++++++++++++++++++++++
 include/linux/iommu-liveupdate.h | 50 ++++++++++++++++
 3 files changed, 210 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 41effee10e33..c8b09b650d24 100644
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
@@ -505,6 +506,14 @@ static int iommu_init_device(struct device *dev)
 		goto err_free;
 	}
 
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	dev->iommu->device_ser = iommu_get_device_preserved_data(dev);
+	if (IS_ERR(dev->iommu->device_ser)) {
+		ret = PTR_ERR(dev->iommu->device_ser);
+		goto err_module_put;
+	}
+#endif
+
 	iommu_dev = ops->probe_device(dev);
 	if (IS_ERR(iommu_dev)) {
 		ret = PTR_ERR(iommu_dev);
@@ -2169,6 +2178,13 @@ static int __iommu_attach_device(struct iommu_domain *domain,
 	ret = domain->ops->attach_dev(domain, dev, old);
 	if (ret)
 		return ret;
+
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	/* The associated state can be unset once restored. */
+	if (dev_iommu_restored_state(dev))
+		WRITE_ONCE(dev->iommu->device_ser, NULL);
+#endif
+
 	dev->iommu->attach_deferred = 0;
 	trace_attach_device_to_domain(dev);
 	return 0;
@@ -3124,6 +3140,47 @@ int iommu_fwspec_add_ids(struct device *dev, const u32 *ids, int num_ids)
 }
 EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
 
+static inline void *__iommu_group_restored_state(struct iommu_group *group)
+{
+	struct device *dev;
+
+	dev = iommu_group_first_dev(group);
+	if (!dev_is_pci(dev))
+		return NULL;
+
+	return dev_iommu_restored_state(dev);
+}
+
+static struct iommu_domain *__iommu_group_restore_domain(struct iommu_group *group)
+{
+	struct iommu_device_ser *device_ser;
+	struct iommu_domain *domain;
+	struct device *dev;
+	void *owner;
+
+	lockdep_assert_held(&group->mutex);
+	dev = iommu_group_first_dev(group);
+	if (!dev_is_pci(dev))
+		return NULL;
+
+	device_ser = dev_iommu_restored_state(dev);
+	if (!device_ser)
+		return NULL;
+
+	domain = iommu_restore_domain(dev, device_ser, &owner);
+	if (WARN_ON(IS_ERR(domain)))
+		return NULL;
+
+	/*
+	 * Ownership of groups with preserved devices is set during boot. These
+	 * will be reclaimed later by the entity (iommufd) that preserved them.
+	 */
+	WARN_ON(group->owner);
+	group->owner = owner;
+	group->owner_cnt = 1;
+	return domain;
+}
+
 /**
  * iommu_setup_default_domain - Set the default_domain for the group
  * @group: Group to change
@@ -3138,8 +3195,8 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 				      int target_type)
 {
 	struct iommu_domain *old_dom = group->default_domain;
+	struct iommu_domain *dom, *restored_domain;
 	struct group_device *gdev;
-	struct iommu_domain *dom;
 	bool direct_failed;
 	int req_type;
 	int ret;
@@ -3183,6 +3240,10 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 	/* We must set default_domain early for __iommu_device_set_domain */
 	group->default_domain = dom;
 	if (!group->domain) {
+		if (__iommu_group_restored_state(group))
+			restored_domain = __iommu_group_restore_domain(group);
+		else
+			restored_domain = dom;
 		/*
 		 * Drivers are not allowed to fail the first domain attach.
 		 * The only way to recover from this is to fail attaching the
@@ -3190,7 +3251,7 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 		 * in group->default_domain so it is freed after.
 		 */
 		ret = __iommu_group_set_domain_internal(
-			group, dom, IOMMU_SET_DOMAIN_MUST_SUCCEED);
+			group, restored_domain, IOMMU_SET_DOMAIN_MUST_SUCCEED);
 		if (WARN_ON(ret))
 			goto out_free_old;
 	} else {
diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
index 90750e78cd2a..732c19e69e69 100644
--- a/drivers/iommu/liveupdate.c
+++ b/drivers/iommu/liveupdate.c
@@ -257,6 +257,47 @@ int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn,
 }
 EXPORT_SYMBOL(iommu_for_each_preserved_device);
 
+static inline bool match_device_ser(struct iommu_device_ser *match,
+				    struct pci_dev *pdev)
+{
+	return match->devid == pci_dev_id(pdev) && match->pci_domain_nr == pci_domain_nr(pdev->bus);
+}
+
+struct iommu_device_ser *iommu_get_device_preserved_data(struct device *dev)
+{
+	struct iommu_device_ser *device_ser = NULL;
+	struct iommu_device_array_ser *array;
+	struct iommu_flb_obj *flb_obj;
+	int ret, idx;
+
+	if (!dev_is_pci(dev))
+		return NULL;
+
+	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)&flb_obj);
+	if (ret == -ENODATA || ret == -ENOENT)
+		return NULL;
+
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (!flb_obj->ser->device_array_phys)
+		return NULL;
+
+	array = phys_to_virt(flb_obj->ser->device_array_phys);
+	iommu_liveupdate_for_each_obj(array, device_ser, idx) {
+		if (match_device_ser(device_ser, to_pci_dev(dev))) {
+			device_ser->hdr.flags |= IOMMU_SER_FLAG_INCOMING;
+			goto out;
+		}
+	}
+
+	device_ser = NULL;
+out:
+	liveupdate_flb_put_incoming(&iommu_flb);
+	return device_ser;
+}
+EXPORT_SYMBOL(iommu_get_device_preserved_data);
+
 struct iommu_hw_ser *iommu_get_preserved_data(u64 token, enum iommu_type_ser type)
 {
 	struct iommu_hw_ser *iommu_ser = NULL;
@@ -561,3 +602,59 @@ void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev)
 	iommu_unpreserve_locked(iommu->iommu_dev, flb_obj);
 }
 EXPORT_SYMBOL_GPL(iommu_unpreserve_device);
+
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
+	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)&flb_obj);
+	if (ret)
+		return ERR_PTR(ret);
+
+	guard(mutex)(&flb_obj->lock);
+
+	/* Preserved device should have a preserved domain */
+	if (!ser->domain_iommu_ser.domain_phys)
+		return ERR_PTR(-EINVAL);
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
+	liveupdate_flb_put_incoming(&iommu_flb);
+	return domain;
+}
diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
index 5ad006892cbd..84522f180254 100644
--- a/include/linux/iommu-liveupdate.h
+++ b/include/linux/iommu-liveupdate.h
@@ -30,6 +30,20 @@ static inline void *dev_iommu_preserved_state(struct device *dev)
 	return NULL;
 }
 
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
 static inline void *iommu_domain_restored_state(struct iommu_domain *domain)
 {
 	struct iommu_domain_ser *ser;
@@ -41,8 +55,22 @@ static inline void *iommu_domain_restored_state(struct iommu_domain *domain)
 	return NULL;
 }
 
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
+struct iommu_device_ser *iommu_get_device_preserved_data(struct device *dev);
 struct iommu_hw_ser *iommu_get_preserved_data(u64 token, enum iommu_type_ser type);
 int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser);
 void iommu_unpreserve_domain(struct iommu_domain *domain);
@@ -60,16 +88,38 @@ static inline void *dev_iommu_preserved_state(struct device *dev)
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
 
+static inline struct iommu_device_ser *iommu_get_device_preserved_data(struct device *dev)
+{
+	return NULL;
+}
+
 static inline struct iommu_hw_ser *iommu_get_preserved_data(u64 token, enum iommu_type_ser type)
 {
 	return NULL;
-- 
2.54.0.1136.gdb2ca164c4-goog

