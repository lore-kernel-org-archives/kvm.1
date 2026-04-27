Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270483E8C7C
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 17:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777312618; cv=none; b=bGP4xn+V8zhhDHiPz3XB6kMr074Xsg4Yn1WPwBFAMTo36A+ojHTx3193Y6J5pZgp/lL/mQV0XMoLkYolGcHPtWOArd33gyzWs/F3kjAyf5CSogNolqz+BK3sV5Z6hd1a34Gv7zT2vvSuaauTNvRTkg+wuBfNnfC9vbvM4J4xp4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777312618; c=relaxed/simple;
	bh=TfaJaD2O54jI/sCs9xXBeqZy0ilWc5ViWCmmxcfTg2A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tQ3doo/atya0OwdrCS4bmlgUHf1i4JxwTlOVzqvPVPznjrurtAgMb8N7owAwSiB7eBQZZ1+j3wRtEdGEGIUpUo3FhjNS+RTeOMjzghCgChF2Ao8/oi4lspODcspLqYhFKAzt1bE0UEO1SrIsSKTLMS15x88xzzxdGbLMdrIDCZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t0QHZrNc; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t0QHZrNc"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82fbceb0181so6059136b3a.3
        for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 10:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777312612; x=1777917412; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7vr3WaPGcaGgG63OEMW1qTYPEZtnKlawonPVtgiIp3g=;
        b=t0QHZrNcwuBO7RfjnfTsy6A2HEOO3ey+Le6EmUfrhwvcwnNo5VCIkDyWQIwgVpBURb
         5ZhLky11JQpOd975ojuZuEpan+SQMAloHW3QTWuYtbB8RH4jgiIqnvbZmrxruj20s59L
         uMXOOJf33LzbsKAB6aZKEN/TSMijZ9+DfuPN6xyjDjtVZ1IpmlEo0UTIgTvx7bLZ39wz
         oCAQX6tlucVrmrP1QRVvMwUenGisFiw5LUZFJUuLiKhXbvyUha5nTZfn6fGCsA/ydEuK
         MTQ6OXnk5aC+TxbR3q4iYkZ8haiHRmabUMpd2kue3jyT6daZuPTmuypNFCBape4PDwxe
         02Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777312612; x=1777917412;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7vr3WaPGcaGgG63OEMW1qTYPEZtnKlawonPVtgiIp3g=;
        b=S3JuObw/gjXOtD00j3vYUlUWeohcn1FjcwDXL+IikszinjQObFjCNqqMt8aU/oR0bZ
         UedlF3Xae87ANwXTMOh+8lkgrkhVz4Mei8wfGgf8KCzZO1RFd9pzGYRk6XFSk7cQypH2
         Tf4GfapfTmcWa3edXF2BH8S6zubSEReaewJNUZgQj348ToWIKtbiu95IhKsLKn3DF/kA
         aF79kxXYk16ujVHLdOQwzJR+69Tefx/Ghsip8Y4Uhczmx5+DdifFWpTQPN/VOuQG4q6N
         PKfSw+gWTHprNsvXsD2UfTmOA2Bllzoa2gOmNtyxeCKk7udKh4ve60+mBkz62gYhS1ZF
         K4rQ==
X-Forwarded-Encrypted: i=1; AFNElJ/nz3vyROkjo7udd62z+LBk9ewuDar1QgcdpCDKIazUy3KtpoZDVaqdQ6Gz9+3v6Xe6eAA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4NGG2L36NgN2XqdAm57P/Ib6SDy6TzVlTVlu/ynQr8b76Nbyj
	9SE628iXlp4UKeknB5yg/x5Cy/oRbtcT82g7MFrqTYXycz+0wLAoxAp5iHO8Nc9z1vyhCDPyF4Y
	zMOi5hDX1jj6pOA==
X-Received: from pfbjs41.prod.google.com ([2002:a05:6a00:91a9:b0:82f:6c9a:6139])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:ccf:b0:82f:be7d:5fc0 with SMTP id d2e1a72fcca58-834dc2d805amr6083b3a.39.1777312612308;
 Mon, 27 Apr 2026 10:56:52 -0700 (PDT)
Date: Mon, 27 Apr 2026 17:56:27 +0000
In-Reply-To: <20260427175633.1978233-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260427175633.1978233-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260427175633.1978233-11-skhawaja@google.com>
Subject: [PATCH v2 10/16] iommu: Restore and reattach preserved domains to devices
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"

Restore the preserved domains by restoring the page tables using restore
IOMMU domain op. Reattach the preserved domain to the device during
default domain setup. While attaching, reuse the domain ID that was used
in the previous kernel. The context entry setup is not needed as that is
preserved during liveupdate.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/intel/iommu.c      | 49 ++++++++++++++------
 drivers/iommu/intel/iommu.h      |  3 +-
 drivers/iommu/intel/nested.c     |  2 +-
 drivers/iommu/iommu.c            | 61 ++++++++++++++++++++++++-
 drivers/iommu/liveupdate.c       | 78 ++++++++++++++++++++++++++++++++
 include/linux/iommu-liveupdate.h | 50 ++++++++++++++++++++
 6 files changed, 224 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4118a0861f38..b90757164cd8 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1031,7 +1031,8 @@ static bool first_level_by_default(struct intel_iommu *iommu)
 	return true;
 }
 
-int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
+int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu,
+			int restore_did)
 {
 	struct iommu_domain_info *info, *curr;
 	int num, ret = -ENOSPC;
@@ -1051,8 +1052,11 @@ int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
 		return 0;
 	}
 
-	num = ida_alloc_range(&iommu->domain_ida, IDA_START_DID,
-			      cap_ndoms(iommu->cap) - 1, GFP_KERNEL);
+	if (restore_did >= IDA_START_DID)
+		num = restore_did;
+	else
+		num = ida_alloc_range(&iommu->domain_ida, IDA_START_DID,
+				      cap_ndoms(iommu->cap) - 1, GFP_KERNEL);
 	if (num < 0) {
 		pr_err("%s: No free domain ids\n", iommu->name);
 		goto err_unlock;
@@ -1320,10 +1324,14 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
+	struct device_ser *device_ser = NULL;
 	unsigned long flags;
 	int ret;
 
-	ret = domain_attach_iommu(domain, iommu);
+	device_ser = dev_iommu_restored_state(dev);
+
+	ret = domain_attach_iommu(domain, iommu,
+				  dev_iommu_restore_did(dev, &domain->domain));
 	if (ret)
 		return ret;
 
@@ -1336,16 +1344,18 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 	if (dev_is_real_dma_subdevice(dev))
 		return 0;
 
-	if (!sm_supported(iommu))
-		ret = domain_context_mapping(domain, dev);
-	else if (intel_domain_is_fs_paging(domain))
-		ret = domain_setup_first_level(iommu, domain, dev,
-					       IOMMU_NO_PASID, NULL);
-	else if (intel_domain_is_ss_paging(domain))
-		ret = domain_setup_second_level(iommu, domain, dev,
-						IOMMU_NO_PASID, NULL);
-	else if (WARN_ON(true))
-		ret = -EINVAL;
+	if (!device_ser) {
+		if (!sm_supported(iommu))
+			ret = domain_context_mapping(domain, dev);
+		else if (intel_domain_is_fs_paging(domain))
+			ret = domain_setup_first_level(iommu, domain, dev,
+						       IOMMU_NO_PASID, NULL);
+		else if (intel_domain_is_ss_paging(domain))
+			ret = domain_setup_second_level(iommu, domain, dev,
+							IOMMU_NO_PASID, NULL);
+		else if (WARN_ON(true))
+			ret = -EINVAL;
+	}
 
 	if (ret)
 		goto out_block_translation;
@@ -3170,6 +3180,15 @@ int paging_domain_compatible(struct iommu_domain *domain, struct device *dev)
 	struct intel_iommu *iommu = info->iommu;
 	int ret = -EINVAL;
 
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	/*
+	 * Restored IOMMU domains are already attached to the device and can
+	 * only be freed. So no need to check the compatibility.
+	 */
+	if (iommu_domain_restored_state(domain))
+		return 0;
+#endif
+
 	if (intel_domain_is_fs_paging(dmar_domain))
 		ret = paging_domain_compatible_first_stage(dmar_domain, iommu);
 	else if (intel_domain_is_ss_paging(dmar_domain))
@@ -3647,7 +3666,7 @@ domain_add_dev_pasid(struct iommu_domain *domain,
 	if (!dev_pasid)
 		return ERR_PTR(-ENOMEM);
 
-	ret = domain_attach_iommu(dmar_domain, iommu);
+	ret = domain_attach_iommu(dmar_domain, iommu, -1);
 	if (ret)
 		goto out_free;
 
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index b0ec0b471a43..8e37acf7de12 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1182,7 +1182,8 @@ void __iommu_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
  */
 #define QI_OPT_WAIT_DRAIN		BIT(0)
 
-int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu);
+int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu,
+			int restore_did);
 void domain_detach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu);
 void device_block_translation(struct device *dev);
 int paging_domain_compatible(struct iommu_domain *domain, struct device *dev);
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index 2b979bec56ce..6e13f697b463 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -40,7 +40,7 @@ static int intel_nested_attach_dev(struct iommu_domain *domain,
 		return ret;
 	}
 
-	ret = domain_attach_iommu(dmar_domain, iommu);
+	ret = domain_attach_iommu(dmar_domain, iommu, -1);
 	if (ret) {
 		dev_err_ratelimited(dev, "Failed to attach domain to iommu\n");
 		return ret;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0561990f46e3..e888700da53d 100644
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
@@ -505,6 +506,10 @@ static int iommu_init_device(struct device *dev)
 		goto err_free;
 	}
 
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	dev->iommu->device_ser = iommu_get_device_preserved_data(dev);
+#endif
+
 	iommu_dev = ops->probe_device(dev);
 	if (IS_ERR(iommu_dev)) {
 		ret = PTR_ERR(iommu_dev);
@@ -2204,6 +2209,13 @@ static int __iommu_attach_device(struct iommu_domain *domain,
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
@@ -3159,6 +3171,47 @@ int iommu_fwspec_add_ids(struct device *dev, const u32 *ids, int num_ids)
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
@@ -3173,8 +3226,8 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 				      int target_type)
 {
 	struct iommu_domain *old_dom = group->default_domain;
+	struct iommu_domain *dom, *restored_domain;
 	struct group_device *gdev;
-	struct iommu_domain *dom;
 	bool direct_failed;
 	int req_type;
 	int ret;
@@ -3218,6 +3271,10 @@ static int iommu_setup_default_domain(struct iommu_group *group,
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
@@ -3225,7 +3282,7 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 		 * in group->default_domain so it is freed after.
 		 */
 		ret = __iommu_group_set_domain_internal(
-			group, dom, IOMMU_SET_DOMAIN_MUST_SUCCEED);
+			group, restored_domain, IOMMU_SET_DOMAIN_MUST_SUCCEED);
 		if (WARN_ON(ret))
 			goto out_free_old;
 	} else {
diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
index 60ee29b0c6bd..0888871784ea 100644
--- a/drivers/iommu/liveupdate.c
+++ b/drivers/iommu/liveupdate.c
@@ -234,6 +234,41 @@ int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn,
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
+	if (ret)
+		return NULL;
+
+	array = phys_to_virt(flb_obj->ser->device_array_phys);
+	iommu_liveupdate_for_each_obj(array, device_ser, idx) {
+		if (match_device_ser(device_ser, to_pci_dev(dev))) {
+			device_ser->hdr.incoming = true;
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
@@ -512,3 +547,46 @@ void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev)
 
 	iommu_unpreserve_locked(iommu->iommu_dev, flb_obj);
 }
+
+struct iommu_domain *iommu_restore_domain(struct device *dev,
+					  struct iommu_device_ser *ser,
+					  void **owner)
+{
+	struct iommu_domain_ser *domain_ser;
+	struct iommu_flb_obj *flb_obj;
+	struct iommu_domain *domain;
+	int ret;
+
+	domain_ser = phys_to_virt(ser->domain_iommu_ser.domain_phys);
+
+	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)&flb_obj);
+	if (ret)
+		return ERR_PTR(ret);
+
+	guard(mutex)(&flb_obj->lock);
+	if (domain_ser->restored_domain) {
+		domain = domain_ser->restored_domain;
+		goto out;
+	}
+
+	domain_ser->hdr.incoming =  true;
+	domain = iommu_paging_domain_alloc(dev);
+	if (IS_ERR(domain))
+		goto out;
+
+	ret = domain->ops->restore(domain, domain_ser);
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
index 0baf6bc2d93f..75d27256c883 100644
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
+	ser = dev->iommu->device_ser;
+	if (ser && ser->hdr.incoming)
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
 int iommu_domain_preserve(struct iommu_domain *domain, struct iommu_domain_ser **ser);
 void iommu_domain_unpreserve(struct iommu_domain *domain);
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
2.54.0.545.g6539524ca2-goog

