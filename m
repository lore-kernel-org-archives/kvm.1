Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795409404;
	b=HdviG7FQZupUmQbmSdlx7mTR+qpjKntlCxipcfSq845VZ42o7dJBIfGL9X19yjetXNKs
	 muT5MgU4sQuCFEarhLmKYCzYZqQhmmw7sxt7UH4OxcesJisg9yQ+ypT0aVYm9h1h9LNR6
	 97P+TDX5Ts7S4hInFIiyUOcQLxzg4VyQoD/Owk1sr5YdiavAgC6CSH7QbdfTHRDMWaF0d
	 HmVHHUFafohR+JLhac5o4r5IMFTfiyGIEvcQFawcABQt8G/VpoBUl5ZBvpLb4Ut/qOH7e
	 cnc/fjg5YiEudJzzpL4nrrYMAnYpEC1vzF8B/d5EmIumbK7ZLuDTXI8M7+D7wpM8Xnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795409404;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=XrWN2KLbXY+MmIuqHS0oLS7GsgkDZp6/iC325lkJYKI=;
	b=jXUzMNTDvjjUzfv0CeAyjbi9VLgIl/zFOn/8cy2xqNm4sPaYf0cOtIENq/C4yAj6rdcM
	 dW1jNV42cC+ec8FbqfZVvE5NPyJjNBYmsE9X+Kd/APRnkqomXRAmrDVVgI2TnL9DF4mHz
	 rtn8JFk0U+0UAClYynluSHt+DKvvMQwDgw5+cxLq5LJx2+ULX9RfZDhRPk91wFPZtuYdk
	 AUfV6bIuwcrnxtix57GhGxioSbxzwWvv7Cobu2vx5c/q7EqLKm23RHnTHy9EeVLnWIZzO
	 T0pEWLKrBPhKQTngWKvkQ5r4O7HDRHk/Akka8iOx8yd6hmrO0A7l3x7BLO+9idKcwPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GJRkcPt3;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7382360A6F4A
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 04:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7382360A6F4A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GJRkcPt3
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b4232374d6so4011671a91.2
        for <kvm@vger.kernel.org>; Sun, 22 Nov 2026 20:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795409403; x=1796014203; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XrWN2KLbXY+MmIuqHS0oLS7GsgkDZp6/iC325lkJYKI=;
        b=GJRkcPt3Deptzco7g71TKNpPtLK2PtiqmYKwX5h0J9HsrqM7A/Acil12MHTs2e9D3N
         U4J1x+IGPCtSwFIjjdwc3yGuK7E3pIV8b4LRT6emODtT/MqYQcIQfjGx9xLIIit0NtyR
         4aL3TUL+FdBuJCyApNTVXxW7dExAJ5+OUi+l/TOkeS6qZGl8Bs5L2DXMs8YITUq2OwbQ
         q/WRztJVUzqlf9cvpWb6BoeorMUfaFO74iqsYDBh/m4/3tcMNoTyqIfEdk+u9OxNfcHn
         2S1ewi+jBNpFXGhbuC7YOYEHHXHHpaoE8buYU7xE4ZwRvMT9Oh+BAts59VKLcwp5RZvb
         ZTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795409403; x=1796014203;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XrWN2KLbXY+MmIuqHS0oLS7GsgkDZp6/iC325lkJYKI=;
        b=uwTVZWkY0ccci+Fvu83eP/8yKZKh1Oq8P158YLKQISEc5rEqax0qRRoXPWjK2Eynoj
         M+ljXQzPOCveqiX5abVN968v8Puj9WxFnKyzPNMU8kaDhHXj6pfuHV3J7as/1qAouZAe
         WCXpHvWB1LcTxSLZpctI+EfxpFuiZtRTVyOCyj6geJv+gX2ZRA1TUst5k3UbsCJGSkoQ
         98IRj88ZTPPwgiXdVclpANb1bPKhcvwlhYoumlKWU+HDk8LlsCcdvVlmnVn2Nd/X4+nP
         oDKrkUylaO5B8sWgw2Hk5NSB+II5+BRh5EFRi9gBG+4nXmulxsCUT+5Kq5gbIUbJRsXt
         XJ9w==
X-Forwarded-Encrypted: i=1; AL+hErFEB+v97P9lBl0nuLRLaHE1fb9st8/WMpgnqj2Q876GBud4aRs0HcXX/CYtQdc29s55Nyk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+JgBuMTPqshr6ERa6h3uXVSZh5JPehvqRHEeYEgM3d/zvOeAeV
	dJdG6z/7zLidgVHVVQsgcNHHij6sGQSP7Ckru1+cnKyUpaWZ5AkcqX0kMCcdd5r9XUTSGD6LILI
	hEUJmNzpowjWzMA==
X-Received: from pjbnd6.prod.google.com ([2002:a17:90b:4cc6:b0:3b4:50ed:c55e])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3b84:b0:3b0:9a2e:b491 with SMTP id 98e67ed59e1d1-3b41c97c897mr10158123a91.66.1795409402607;
 Sun, 22 Nov 2026 20:50:02 -0800 (PST)
Date: Mon, 23 Nov 2026 04:49:44 +0000
In-Reply-To: <20261123044949.3610702-1-skhawaja@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261123044949.3610702-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261123044949.3610702-14-skhawaja@google.com>
Subject: [PATCH v8 13/18] iommu: Restore and reattach preserved domains to devices
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

During default domain setup, restore the preserved domains by restoring
the page tables using restore() iommupt op. Associated the restored
domain with the iommu group of the preserved device, and reattach the
domain to the device.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/iommu.c            | 164 ++++++++++++++++++++++++++++---
 drivers/iommu/liveupdate.c       | 106 ++++++++++++++++++++
 include/linux/iommu-liveupdate.h |  13 +++
 3 files changed, 268 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f8837ab1b526..c60af471ec32 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -163,6 +163,8 @@ static void __iommu_group_set_domain_nofail(struct iommu_group *group,
 		group, new_domain, IOMMU_SET_DOMAIN_MUST_SUCCEED));
 }
 
+static int __iommu_group_alloc_blocking_domain(struct iommu_group *group);
+
 static int iommu_setup_default_domain(struct iommu_group *group,
 				      int target_type);
 static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
@@ -513,6 +515,10 @@ static int iommu_init_device(struct device *dev)
 		goto err_free;
 	}
 
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	iommu_init_device_restored_data(dev);
+#endif
+
 	iommu_dev = ops->probe_device(dev);
 	if (IS_ERR(iommu_dev)) {
 		ret = PTR_ERR(iommu_dev);
@@ -577,7 +583,8 @@ static void iommu_deinit_device(struct device *dev)
 	 * Regardless, if a delayed attach never occurred, then the release
 	 * should still avoid touching any hardware configuration either.
 	 */
-	if (!dev->iommu->attach_deferred && ops->release_domain) {
+	if (!dev->iommu->attach_deferred && ops->release_domain &&
+	    !dev_iommu_restored_state(dev)) {
 		struct iommu_domain *release_domain = ops->release_domain;
 
 		/*
@@ -635,11 +642,39 @@ static bool iommu_group_liveupdate_reserved(struct iommu_group *group)
 	lockdep_assert_held(&group->mutex);
 	return group->liveupdate_reserved;
 }
+
+static int __iommu_group_reserve_liveupdate(struct iommu_group *group)
+{
+	lockdep_assert_held(&group->mutex);
+	if (group->liveupdate_reserved)
+		return -EBUSY;
+
+	if (!list_is_singular(&group->devices))
+		return -EOPNOTSUPP;
+
+	group->liveupdate_reserved = true;
+	return 0;
+}
+
+static void __iommu_group_unreserve_liveupdate(struct iommu_group *group)
+{
+	lockdep_assert_held(&group->mutex);
+	group->liveupdate_reserved = false;
+}
 #else
 static inline bool iommu_group_liveupdate_reserved(struct iommu_group *group)
 {
 	return false;
 }
+
+static inline int __iommu_group_reserve_liveupdate(struct iommu_group *group)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void __iommu_group_unreserve_liveupdate(struct iommu_group *group)
+{
+}
 #endif
 
 static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
@@ -748,6 +783,29 @@ int iommu_probe_device(struct device *dev)
 	return 0;
 }
 
+static void __iommu_group_remove_restored_device(struct iommu_group *group,
+						 struct device *dev)
+{
+	struct iommu_device_ser *device_ser;
+
+	lockdep_assert_held(&group->mutex);
+	device_ser = dev_iommu_restored_state(dev);
+	if (!device_ser)
+		return;
+
+	__iommu_group_unreserve_liveupdate(group);
+
+	if (!group->owner_cnt || group->owner != device_ser)
+		return;
+
+	if (group->owner_cnt > 1) {
+		group->owner_cnt--;
+	} else {
+		group->owner_cnt = 0;
+		group->owner = NULL;
+	}
+}
+
 static void __iommu_group_free_device(struct iommu_group *group,
 				      struct group_device *grp_dev)
 {
@@ -759,13 +817,16 @@ static void __iommu_group_free_device(struct iommu_group *group,
 	trace_remove_device_from_group(group->id, dev);
 
 	/*
-	 * If the group has become empty then ownership must have been
-	 * released, and the current domain must be set back to NULL or
-	 * the default domain.
+	 * If the group has become empty then ownership must have been released,
+	 * and the current domain must be set back to NULL or the default
+	 * domain. A restored domain remains attached to the restored device on
+	 * removal.
 	 */
 	if (list_empty(&group->devices))
 		WARN_ON(group->owner_cnt ||
-			group->domain != group->default_domain);
+			(group->domain &&
+			 group->domain != group->default_domain &&
+			 !iommu_domain_restored_state(group->domain)));
 
 	kfree(grp_dev->name);
 	kfree(grp_dev);
@@ -778,6 +839,7 @@ static void __iommu_group_remove_device(struct device *dev)
 	struct group_device *device;
 
 	mutex_lock(&group->mutex);
+	__iommu_group_remove_restored_device(group, dev);
 	for_each_group_device(group, device) {
 		if (device->dev != dev)
 			continue;
@@ -3161,6 +3223,66 @@ int iommu_fwspec_add_ids(struct device *dev, const u32 *ids, int num_ids)
 }
 EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
 
+static struct device *__iommu_group_restored_device(struct iommu_group *group)
+{
+	struct group_device *gdev;
+
+	for_each_group_device(group, gdev) {
+		if (dev_is_pci(gdev->dev) && dev_iommu_restored_state(gdev->dev))
+			return gdev->dev;
+	}
+
+	return NULL;
+}
+
+static int __iommu_device_restore_domain(struct device *dev)
+{
+	struct iommu_group *group = dev->iommu_group;
+	struct iommu_device_ser *device_ser;
+	struct iommu_domain *domain;
+	int ret;
+
+	lockdep_assert_held(&group->mutex);
+	if (group->domain)
+		return -EBUSY;
+
+	device_ser = dev_iommu_restored_state(dev);
+	if (!device_ser)
+		return -ENOENT;
+
+	/*
+	 * Ownership of groups with preserved devices is set during boot. These
+	 * will be reclaimed later by the entity (iommufd) that preserved them.
+	 * Claim ownership first so that even if the reservation or the domain
+	 * restoration fails, no driver can bind to the device using
+	 * default_domain.
+	 */
+	WARN_ON(group->owner);
+	group->owner = device_ser;
+	group->owner_cnt = 1;
+
+	/* A restored device must be the only device in its group */
+	ret = __iommu_group_reserve_liveupdate(group);
+	if (ret)
+		return ret;
+
+	ret = __iommu_group_alloc_blocking_domain(group);
+	if (ret)
+		return ret;
+
+	/*
+	 * If attaching the restored domain fails below, the domain is not
+	 * leaked; it remains cached in domain_ser->restored_domain and will be
+	 * reused if the device is rescanned.
+	 */
+	domain = iommu_restore_domain(dev, device_ser);
+	if (IS_ERR(domain))
+		return PTR_ERR(domain);
+
+	/* The restored domain is attached with the restored device. */
+	return __iommu_group_set_domain(group, domain);
+}
+
 /**
  * iommu_setup_default_domain - Set the default_domain for the group
  * @group: Group to change
@@ -3177,9 +3299,10 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 	struct iommu_domain *old_dom = group->default_domain;
 	struct group_device *gdev;
 	struct iommu_domain *dom;
+	struct device *dev;
 	bool direct_failed;
 	int req_type;
-	int ret;
+	int ret = 0;
 
 	lockdep_assert_held(&group->mutex);
 
@@ -3219,6 +3342,18 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 
 	/* We must set default_domain early for __iommu_device_set_domain */
 	group->default_domain = dom;
+
+	/*
+	 * Preserved devices need to be attached to the restored domain. If the
+	 * restore fails, the group stays owned, so the default_domain is never
+	 * attached or used.
+	 */
+	dev = __iommu_group_restored_device(group);
+	if (dev) {
+		WARN_ON(__iommu_device_restore_domain(dev));
+		goto out_free_old;
+	}
+
 	if (!group->domain) {
 		/*
 		 * Drivers are not allowed to fail the first domain attach.
@@ -3582,14 +3717,7 @@ EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
 int iommu_group_reserve_liveupdate(struct iommu_group *group)
 {
 	guard(mutex)(&group->mutex);
-	if (group->liveupdate_reserved)
-		return -EBUSY;
-
-	if (!list_is_singular(&group->devices))
-		return -EOPNOTSUPP;
-
-	group->liveupdate_reserved = true;
-	return 0;
+	return __iommu_group_reserve_liveupdate(group);
 }
 
 /**
@@ -3599,7 +3727,7 @@ int iommu_group_reserve_liveupdate(struct iommu_group *group)
 void iommu_group_unreserve_liveupdate(struct iommu_group *group)
 {
 	guard(mutex)(&group->mutex);
-	group->liveupdate_reserved = false;
+	__iommu_group_unreserve_liveupdate(group);
 }
 #endif
 
@@ -4102,6 +4230,9 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 	if (!pci_ats_supported(pdev) || !dev_has_iommu(&pdev->dev))
 		return 0;
 
+	if (dev_iommu_restored_state(&pdev->dev))
+		return 0;
+
 	guard(mutex)(&group->mutex);
 
 	gdev = __dev_to_gdev(&pdev->dev);
@@ -4213,6 +4344,9 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 	if (!pci_ats_supported(pdev) || !dev_has_iommu(&pdev->dev))
 		return;
 
+	if (dev_iommu_restored_state(&pdev->dev))
+		return;
+
 	guard(mutex)(&group->mutex);
 
 	gdev = __dev_to_gdev(&pdev->dev);
diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
index 2c5da375f07f..6516152a1d3c 100644
--- a/drivers/iommu/liveupdate.c
+++ b/drivers/iommu/liveupdate.c
@@ -631,3 +631,109 @@ void iommu_unpreserve_device(struct device *dev)
 		iommu_group_unreserve_liveupdate(dev->iommu_group);
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
+ * iommu_init_device_restored_data() - Initialize restored state for device
+ * @dev: Target device
+ *
+ * Looks up incoming Live Update state for @dev and attaches it to the device if
+ * found.
+ */
+void iommu_init_device_restored_data(struct device *dev)
+{
+	struct iommu_device_ser *device_ser;
+	struct iommu_flb_obj *flb_obj;
+	struct kho_block_set_it it;
+	int ret;
+
+	if (!dev_is_pci(dev))
+		return;
+
+	ret = iommu_liveupdate_flb_get_incoming(&flb_obj);
+	if (ret)
+		return;
+
+	mutex_lock(&flb_obj->lock);
+	iommu_ser_set_for_each(&flb_obj->device_set, it, device_ser) {
+		if (match_device_ser(device_ser, to_pci_dev(dev))) {
+			device_ser->hdr.flags |= IOMMU_SER_FLAG_INCOMING;
+			WRITE_ONCE(dev->iommu->device_ser, device_ser);
+			break;
+		}
+	}
+
+	mutex_unlock(&flb_obj->lock);
+	liveupdate_flb_put_incoming(&iommu_flb);
+}
+EXPORT_SYMBOL_GPL(iommu_init_device_restored_data);
+
+/**
+ * iommu_restore_domain() - Restore a preserved domain for a device
+ * @dev: Target device
+ * @ser: Serialized device state
+ *
+ * Restores or reuses a restored preserved domain for @dev from serialized state
+ * @ser.
+ *
+ * Return: Restored iommu_domain pointer, or ERR_PTR.
+ */
+struct iommu_domain *iommu_restore_domain(struct device *dev,
+					  struct iommu_device_ser *ser)
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
+	if (!ser->attachment.domain_phys) {
+		domain = ERR_PTR(-EINVAL);
+		goto out;
+	}
+
+	domain_ser = phys_to_virt(ser->attachment.domain_phys);
+	if (domain_ser->restored_domain) {
+		domain = domain_ser->restored_domain;
+		goto out;
+	}
+
+	domain_ser->hdr.flags |= IOMMU_SER_FLAG_INCOMING;
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
+	domain->domain_ser = domain_ser;
+	domain_ser->restored_domain = domain;
+
+out:
+	mutex_unlock(&flb_obj->lock);
+	liveupdate_flb_put_incoming(&iommu_flb);
+	return domain;
+}
diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
index fb1e8efac8ec..04dfee566b67 100644
--- a/include/linux/iommu-liveupdate.h
+++ b/include/linux/iommu-liveupdate.h
@@ -99,8 +99,11 @@ static inline void *dev_iommu_restored_state(struct device *dev)
 	return NULL;
 }
 
+struct iommu_domain *iommu_restore_domain(struct device *dev,
+					  struct iommu_device_ser *ser);
 int iommu_for_each_restored_device(iommu_restored_device_iter_fn fn,
 				   void *arg);
+void iommu_init_device_restored_data(struct device *dev);
 struct iommu_hw_ser *iommu_get_restored_state(u64 token, enum iommu_type_ser type);
 int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser);
 void iommu_unpreserve_domain(struct iommu_domain *domain);
@@ -148,11 +151,21 @@ static inline void *iommu_domain_restored_state(struct iommu_domain *domain)
 	return NULL;
 }
 
+static inline struct iommu_domain *iommu_restore_domain(struct device *dev,
+							struct iommu_device_ser *ser)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 static inline int iommu_for_each_restored_device(iommu_restored_device_iter_fn fn, void *arg)
 {
 	return -EOPNOTSUPP;
 }
 
+static inline void iommu_init_device_restored_data(struct device *dev)
+{
+}
+
 static inline struct iommu_hw_ser *iommu_get_restored_state(u64 token, enum iommu_type_ser type)
 {
 	return NULL;
-- 
2.56.1.809.ga0b61035b5-goog

