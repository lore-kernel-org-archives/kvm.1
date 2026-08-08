Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476E2345725
	for <kvm@vger.kernel.org>; Sat,  8 Aug 2026 02:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786156059; cv=none; b=Qr7QRhsD66vSqeRkUDXf/W0asSDN16CVAPvIb955agQm8Ag7sVNeEr2eyboFTbwLb5K4GYy8UK0aGFw76enwrXPWwpyyXlaA3/eEnBZkvhfRuRvk0K7vxiBuuji/XlrFcbxrJcleREjkmSm4HzIUP/rs2hy9nVy9zfejRWdqMhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786156059; c=relaxed/simple;
	bh=5qpVBacu4NBLAhc1pfVFf5yJFvTA4zolajEODz3I81o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Led7c0y1IGGNOhiWssxdsA5qU/62cLd+BzoXiHn1i6695I3hGjXkLj75DvoLDyPt1BMS85d3e+uOLhkSppFHIbd+fQ1pu4Rf4TGoFdAtUE37tGBw7pQ1AwdpgJCLBbq0cAuymX5r7ydij6o5RzUBfMBE5uazWkxRy9brxAwDnEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QG7KL5GK; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QG7KL5GK"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84e01a62d99so230547b3a.0
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 19:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786156054; x=1786760854; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h0I5m3kRcm6Zim8yk8tuyJQnlP/R/V9C8d9m0BO5rXQ=;
        b=QG7KL5GKdPkYpUqmOr6gG2hjcJhlfLsD0dNg+ciGLoY9VcEbtEzbhmNlp7xy4RMcJ0
         JR8WHK/Y7tno/hhrEaKy5uRssASfTU/utZU9sTn9VdyXOpCL5iX+G8P+A5HuRfV1EBjQ
         MCYSN4kMyovd00NkqEcyQObc8nxvxo4HDL5zA7WZ74lVvYKL3lkwgJo+TS3h8eL2ljOp
         VOoIRMM7dijYDvmX45C26Z7o6do+dVk70p/sU9idAzJM10Vs+FDkKDsG0SpoAgNbjl1C
         psqMBlsA5jJttlltk0/3z1kRFOqfUwMLj02eNlK9QUjqv0ln1ohPiQp8G4E++cPRJuCv
         Qs4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786156054; x=1786760854;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h0I5m3kRcm6Zim8yk8tuyJQnlP/R/V9C8d9m0BO5rXQ=;
        b=cORte/bGu9yaSouea3xKFwOo2EQ+RyY71MpJWaG7d9OwE1W/QGliwDSut8/4coJmsz
         weFovALJv9F3kvZG0dCXGlOeFuheU2s7A1yhJk5l4gQvYJYQNqyoUb4N7XTWPv+4ZKJs
         OasdoatqE0SsmJsod3jcm0HsntxLz8dR36jmbZjZp65HMap9EdBHypY+/t8IGY+ob8t9
         6OO9kobqZiaP97wCz+TJDbi8NyDnUpmVo2GPR8epNdnne2rJl3LzuFJmKPKhTk1W2fFa
         A+wLqRX4OQPhf2z0bR8IZgAVoxUPonnW9jHp3wtYYrFrwuQbrq+NgNj/NgLe4Mh6GtlK
         DqDg==
X-Forwarded-Encrypted: i=1; AHgh+RquCkPDdbYW8efdKxivSZRmkocov+Z2rL6CgxfKVchOfVoUv8PRoPXjpP6okTab3Qvhjzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUvfO/tnPFd95FKX/53RAww5iAHc7JeiTo3ebQAbxoTkE63Bwy
	i90kSHRH5wSrmmWAs4BCPY4tIkaDcmCIEYrqCjj4KZQqPniIEb4d1xnNa6IcIlCyIBp40ppJg1b
	mRYuqWq7kItBlNQ==
X-Received: from pfam7.prod.google.com ([2002:aa7:8a07:0:b0:847:926b:dc15])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:6c82:b0:847:5ec6:3afe with SMTP id d2e1a72fcca58-84f2e0588demr32993883b3a.31.1786156054111;
 Fri, 07 Aug 2026 19:27:34 -0700 (PDT)
Date: Sat,  8 Aug 2026 02:27:17 +0000
In-Reply-To: <20260808022723.3893618-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260808022723.3893618-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260808022723.3893618-13-skhawaja@google.com>
Subject: [PATCH v4 12/18] iommu/vt-d: Handle reattach of the restored domain
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

Reattach the restored domain to the preserved device using restored
domain ID. While reattaching do not setup the context and PASID entries
as those are preserved during liveupdate.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/intel/iommu.c      |   9 ++-
 drivers/iommu/intel/iommu.h      |  10 +++
 drivers/iommu/intel/liveupdate.c | 120 +++++++++++++++++++++++++++++++
 3 files changed, 136 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 42d3ff6db281..5370214629f4 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -864,7 +864,7 @@ static bool dev_needs_extra_dtlb_flush(struct pci_dev *pdev)
 	return true;
 }
 
-static void iommu_enable_pci_ats(struct device_domain_info *info)
+void intel_iommu_enable_pci_ats(struct device_domain_info *info)
 {
 	struct pci_dev *pdev;
 
@@ -1225,7 +1225,7 @@ domain_context_mapping(struct dmar_domain *domain, struct device *dev)
 	if (ret)
 		return ret;
 
-	iommu_enable_pci_ats(info);
+	intel_iommu_enable_pci_ats(info);
 
 	return 0;
 }
@@ -3164,6 +3164,9 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 {
 	int ret;
 
+	if (dev_iommu_restored_state(dev))
+		return intel_iommu_restore_device(domain, dev);
+
 	device_block_translation(dev);
 
 	ret = paging_domain_compatible(domain, dev);
@@ -3376,7 +3379,7 @@ static void intel_iommu_probe_finalize(struct device *dev)
 		info->pasid_enabled = 1;
 
 	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
-		iommu_enable_pci_ats(info);
+		intel_iommu_enable_pci_ats(info);
 		/* Assign a DEVTLB cache tag to the default domain. */
 		if (info->ats_enabled && info->domain) {
 			u16 did = domain_id_iommu(info->domain, iommu);
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index b33a12528066..1ef3b9309d44 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1187,6 +1187,8 @@ void domain_detach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu);
 void device_block_translation(struct device *dev);
 int paging_domain_compatible(struct iommu_domain *domain, struct device *dev);
 
+void intel_iommu_enable_pci_ats(struct device_domain_info *info);
+
 struct dev_pasid_info *
 domain_add_dev_pasid(struct iommu_domain *domain,
 		     struct device *dev, ioasid_t pasid);
@@ -1309,6 +1311,8 @@ void intel_iommu_unpreserve(struct iommu_device *iommu,
 void clear_unpreserved_context_entries(struct intel_iommu *iommu);
 void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
 					       struct iommu_hw_ser *iommu_ser);
+int intel_iommu_restore_device(struct iommu_domain *domain,
+			       struct device *dev);
 #else
 static inline int intel_iommu_preserve_device(struct device *dev,
 					      struct iommu_device_ser *device_ser)
@@ -1340,6 +1344,12 @@ static inline void intel_iommu_liveupdate_restore_root_table(struct intel_iommu
 							     struct iommu_hw_ser *iommu_ser)
 {
 }
+
+static inline int intel_iommu_restore_device(struct iommu_domain *domain,
+					     struct device *dev)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
index 480eab2d966b..05dea3893399 100644
--- a/drivers/iommu/intel/liveupdate.c
+++ b/drivers/iommu/intel/liveupdate.c
@@ -12,6 +12,7 @@
 #include <linux/iommu-liveupdate.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/pci-ats.h>
 
 #include "iommu.h"
 #include "../iommu-pages.h"
@@ -342,6 +343,125 @@ void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
 	BUG_ON(iommu_for_each_preserved_device(_restore_used_domain_ids, iommu));
 }
 
+static void domain_detach_reattached_iommu(struct dmar_domain *domain,
+					   struct intel_iommu *iommu)
+{
+	struct iommu_domain_info *info;
+
+	guard(mutex)(&iommu->did_lock);
+	info = xa_load(&domain->iommu_array, iommu->seq_id);
+	if (--info->refcnt == 0) {
+		xa_erase(&domain->iommu_array, iommu->seq_id);
+		kfree(info);
+	}
+}
+
+static int domain_reattach_iommu(struct dmar_domain *domain,
+				 struct intel_iommu *iommu,
+				 struct iommu_device_ser *device_ser)
+{
+	struct iommu_domain_info *info, *curr;
+	int restored_did;
+	int ret;
+
+	if (!iommu_domain_restored_state(&domain->domain))
+		return -EINVAL;
+
+	restored_did = device_ser->domain_iommu_ser.attachment_id;
+	if (!ida_exists(&iommu->domain_ida, restored_did))
+		return -EINVAL;
+
+	info = kzalloc_obj(*info);
+	if (!info)
+		return -ENOMEM;
+
+	guard(mutex)(&iommu->did_lock);
+	curr = xa_load(&domain->iommu_array, iommu->seq_id);
+	if (curr) {
+		curr->refcnt++;
+		kfree(info);
+		return 0;
+	}
+
+	info->refcnt	= 1;
+	info->did	= restored_did;
+	info->iommu	= iommu;
+	curr = xa_cmpxchg(&domain->iommu_array, iommu->seq_id,
+			  NULL, info, GFP_KERNEL);
+	if (curr) {
+		ret = xa_err(curr) ? : -EBUSY;
+		goto err_unlock;
+	}
+
+	return 0;
+
+err_unlock:
+	kfree(info);
+	return ret;
+}
+
+/**
+ * intel_iommu_restore_device() - Restore device domain attachment after live update
+ * @domain: Restored domain
+ * @dev: Restored device
+ *
+ * Return: 0 on success, or negative error code.
+ */
+int intel_iommu_restore_device(struct iommu_domain *domain,
+			       struct device *dev)
+{
+	struct iommu_device_ser *device_ser = dev_iommu_restored_state(dev);
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct intel_iommu *iommu = info->iommu;
+	unsigned long flags;
+	int ret;
+
+	if (!device_ser)
+		return -EINVAL;
+
+	if (dev_is_real_dma_subdevice(dev))
+		return -EOPNOTSUPP;
+
+	ret = domain_reattach_iommu(dmar_domain, iommu, device_ser);
+	if (ret)
+		return ret;
+
+	info->domain = dmar_domain;
+	info->domain_attached = true;
+	spin_lock_irqsave(&dmar_domain->lock, flags);
+	list_add(&info->link, &dmar_domain->devices);
+	spin_unlock_irqrestore(&dmar_domain->lock, flags);
+
+	if (!sm_supported(iommu))
+		intel_iommu_enable_pci_ats(info);
+
+	ret = cache_tag_assign_domain(dmar_domain, dev, IOMMU_NO_PASID);
+	if (ret)
+		goto err;
+
+	ret = iopf_for_domain_set(domain, dev);
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	/*
+	 * Detach the restored domain from device and iommu on failure, but keep
+	 * the hardware state intact.
+	 */
+	info->domain_attached = false;
+	cache_tag_unassign_domain(info->domain, dev, IOMMU_NO_PASID);
+	spin_lock_irqsave(&info->domain->lock, flags);
+	list_del(&info->link);
+	spin_unlock_irqrestore(&info->domain->lock, flags);
+
+	domain_detach_reattached_iommu(info->domain, iommu);
+	info->domain = NULL;
+	return ret;
+}
+
 /**
  * intel_iommu_preserve_device() - Intel IOMMU callback to preserve device state
  * @dev: Target device
-- 
2.55.0.679.g6767b8d81c-goog

