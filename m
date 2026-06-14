Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2C738757B
	for <kvm@vger.kernel.org>; Sun, 14 Jun 2026 23:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781480263; cv=none; b=I4uD+FmfMsgQicdzagXTBJG2fE8IppddOMuPdQV7ODYVCfzbsqkObOgVBDQAcXU9ZFymcMmV/6c6YesTMj7aBQ3nPCMBU+hxbGZdBm/kz30DucJeMDZtP9/AKjGUlimDDqqy8MMcgyBGPILY42BjRO8/uoJb+uGJXJm/InEWQHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781480263; c=relaxed/simple;
	bh=yuZbqjI8l+aIDaECRmggnb1pZHgehCm1ZiFYaYVlFxw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E/u2J619vMCO4fLC0FvoPpGb5kdU9tBIaLBjnb0vm7FMdYV0WgPVZ2dhDEjwz3OYv9Oj8eLhkqdywsyjLYZnYiGOvXDO7A/8oZHuVRxjZHA2m1giAPbfhPt+/fipnibTJtCzkP6LnaG23DMwD9Cwd6isRvZStyf8BT+EwAyiuoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PTzIQVK6; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PTzIQVK6"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8421f5d76aaso1916701b3a.2
        for <kvm@vger.kernel.org>; Sun, 14 Jun 2026 16:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781480259; x=1782085059; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oM23sBR0T1D9vt4uQz4oFKG1ja9fvW5zapYPGrIPVsw=;
        b=PTzIQVK646PjCwUpRjthI4wicKzLzfzgBQNVyso1PcmEL5GSkPqAd71x+YxRgRNVN0
         AuIKtYZyTQUPRe6XAU9eZ+Hgq64Xk9UDNoCDodRb3jjlti/lZRGvFEg2Uru9VOc4vCcF
         FYKNXcgArPb4Z062bMNM5DJuEiWXjyioIoVorigUo61tDj54U2P1FxqpO4UO39gDRY0O
         SGKHP1jPh5+rrCpA1LjS0UFm0HuoAM3W2i1rapBSO2I23iLfNvQ/2lc0wDcpIlo7mspH
         BRd1dYc+cXc14WhQsXDxRlWlkGDKh7zleFInTukhi2QJ1zWePcMlJcbZbgi0Ei/SWgjp
         o0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781480259; x=1782085059;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oM23sBR0T1D9vt4uQz4oFKG1ja9fvW5zapYPGrIPVsw=;
        b=l+XHDF7FHV+sdPYMEGmN7Z1HRnvP7Rix7Q5amSTTu/xx13xgOC8LqezgaHaAsOp6id
         pZAkD2diFJev7Vxz+kutdH3H6yPfgk5zZLU8buPsZEIARxjL01mB5+pZzsOqWqIEPMkN
         22d4bKop9m1InBFqzkOVoSAiVlnf8Wl9P1c7YDrMgXFrEdOQoVl2Zv056Yui0tdMSLaF
         LhzPsS5+ZPcRECUYRa8msDuRutNysmFB4NondX97NPtz5Gs9iHq/ORais9o9Xg1B5fVo
         KysLXl6q5F2F4Ei3gaLQMA1U0hB+VhBk74B6+M/81DVRSL9TNXiHpvf5Ruf0jrd3XzLw
         RuVw==
X-Forwarded-Encrypted: i=1; AFNElJ/7qExQrFwgJBFtbu9pHqrEFWJjC1GKVwk0flgb2zRZ5JwEBZkx9n+C/ZXNBnM9JOt06Qg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8wwJgrySIs8l3lhOmS2vL7HhQ91TPyQvXTTENZFV67dDF+H6v
	9ZDqKPVD4TuLL2JlXnDoGkOYskdx0xMI2o0tGQRdn5R2xwq4fDAbphznv0qD3kR1/JFYkj74MqE
	mz1nZp0XPSwT2ng==
X-Received: from pfx29.prod.google.com ([2002:a05:6a00:a45d:b0:842:6fe1:8625])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2d04:b0:842:5e68:a56b with SMTP id d2e1a72fcca58-844e1a3dec6mr8866798b3a.26.1781480259305;
 Sun, 14 Jun 2026 16:37:39 -0700 (PDT)
Date: Sun, 14 Jun 2026 23:37:22 +0000
In-Reply-To: <20260614233728.2212104-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260614233728.2212104-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260614233728.2212104-13-skhawaja@google.com>
Subject: [PATCH v3 12/18] iommu/vt-d: Handle reattach of the restored domain
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
 drivers/iommu/intel/iommu.c      |  46 ++++++++++---
 drivers/iommu/intel/iommu.h      |  17 +++++
 drivers/iommu/intel/liveupdate.c | 111 +++++++++++++++++++++++++++++++
 3 files changed, 163 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index cd40e274482b..91b67ccba011 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1311,10 +1311,16 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
+	struct iommu_device_ser *device_ser;
 	unsigned long flags;
 	int ret;
 
-	ret = domain_attach_iommu(domain, iommu);
+	device_ser = dev_iommu_restored_state(dev);
+	if (!device_ser)
+		ret = domain_attach_iommu(domain, iommu);
+	else
+		ret = intel_iommu_domain_reattach_iommu(domain,
+							iommu, device_ser);
 	if (ret)
 		return ret;
 
@@ -1327,16 +1333,20 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
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
+	} else if (!sm_supported(iommu)) {
+		iommu_enable_pci_ats(info);
+	}
 
 	if (ret)
 		goto out_block_translation;
@@ -3145,6 +3155,19 @@ int paging_domain_compatible(struct iommu_domain *domain, struct device *dev)
 	struct intel_iommu *iommu = info->iommu;
 	int ret = -EINVAL;
 
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	/*
+	 * Restored IOMMU domains are already attached to the device and can
+	 * only be freed. So no need to check the compatibility.
+	 */
+	if (iommu_domain_restored_state(domain)) {
+		if (!dev_iommu_restored_state(dev))
+			return -EINVAL;
+
+		return 0;
+	}
+#endif
+
 	if (intel_domain_is_fs_paging(dmar_domain))
 		ret = paging_domain_compatible_first_stage(dmar_domain, iommu);
 	else if (intel_domain_is_ss_paging(dmar_domain))
@@ -3969,6 +3992,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.page_response		= intel_iommu_page_response,
 #ifdef CONFIG_IOMMU_LIVEUPDATE
 	.preserve_device	= intel_iommu_preserve_device,
+	.unpreserve_device	= intel_iommu_unpreserve_device,
 	.preserve		= intel_iommu_preserve,
 	.unpreserve		= intel_iommu_unpreserve,
 #endif
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index a2c2cb86a7fc..be56bb73710e 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1290,6 +1290,8 @@ static inline int iopf_for_domain_replace(struct iommu_domain *new,
 #ifdef CONFIG_IOMMU_LIVEUPDATE
 int intel_iommu_preserve_device(struct device *dev,
 				struct iommu_device_ser *device_ser);
+void intel_iommu_unpreserve_device(struct device *dev,
+				   struct iommu_device_ser *device_ser);
 int intel_iommu_preserve(struct iommu_device *iommu,
 			 struct iommu_hw_ser *iommu_ser);
 void intel_iommu_unpreserve(struct iommu_device *iommu,
@@ -1297,6 +1299,9 @@ void intel_iommu_unpreserve(struct iommu_device *iommu,
 void clear_unpreserved_context_entries(struct intel_iommu *iommu);
 void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
 					       struct iommu_hw_ser *iommu_ser);
+int intel_iommu_domain_reattach_iommu(struct dmar_domain *domain,
+				      struct intel_iommu *iommu,
+				      struct iommu_device_ser *device_ser);
 #else
 static inline int intel_iommu_preserve_device(struct device *dev,
 					      struct iommu_device_ser *device_ser)
@@ -1304,6 +1309,11 @@ static inline int intel_iommu_preserve_device(struct device *dev,
 	return -EOPNOTSUPP;
 }
 
+static inline void intel_iommu_unpreserve_device(struct device *dev,
+						 struct iommu_device_ser *device_ser)
+{
+}
+
 static inline int intel_iommu_preserve(struct iommu_device *iommu,
 				       struct iommu_hw_ser *iommu_ser)
 {
@@ -1323,6 +1333,13 @@ static inline void intel_iommu_liveupdate_restore_root_table(struct intel_iommu
 							     struct iommu_hw_ser *iommu_ser)
 {
 }
+
+static inline int intel_iommu_domain_reattach_iommu(struct dmar_domain *domain,
+						    struct intel_iommu *iommu,
+						    struct iommu_device_ser *device_ser)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
index 1a1868e6cc59..61d864a2e27c 100644
--- a/drivers/iommu/intel/liveupdate.c
+++ b/drivers/iommu/intel/liveupdate.c
@@ -254,6 +254,117 @@ void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
 	iommu_for_each_preserved_device(_restore_used_domain_ids, iommu);
 }
 
+int intel_iommu_domain_reattach_iommu(struct dmar_domain *domain,
+				      struct intel_iommu *iommu,
+				      struct iommu_device_ser *device_ser)
+{
+	struct iommu_domain_info *info, *curr;
+	int ret = -ENOSPC;
+	int restored_did;
+
+	if (domain->domain.type == IOMMU_DOMAIN_SVA)
+		return 0;
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
+enum pasid_lu_op {
+	PASID_LU_OP_PRESERVE = 1,
+	PASID_LU_OP_UNPRESERVE,
+	PASID_LU_OP_RESTORE,
+	PASID_LU_OP_FREE,
+};
+
+static int pasid_lu_do_op(void *table, enum pasid_lu_op op)
+{
+	int ret = 0;
+
+	switch (op) {
+	case PASID_LU_OP_PRESERVE:
+		ret = iommu_preserve_pages(table);
+		break;
+	case PASID_LU_OP_UNPRESERVE:
+		iommu_unpreserve_pages(table);
+		break;
+	case PASID_LU_OP_RESTORE:
+		iommu_restore_pages(virt_to_phys(table));
+		break;
+	case PASID_LU_OP_FREE:
+		iommu_free_pages(table);
+		break;
+	}
+
+	return ret;
+}
+
+static int pasid_lu_handle_pd(struct pasid_dir_entry *dir,
+			      u32 max_pasid, enum pasid_lu_op op)
+{
+	int max_pde = max_pasid >> PASID_PDE_SHIFT;
+	struct pasid_entry *table;
+	int i, ret;
+
+	for (i = 0; i < max_pde; i++) {
+		table = get_pasid_table_from_pde(&dir[i]);
+		if (!table)
+			continue;
+
+		ret = pasid_lu_do_op(table, op);
+		if (ret)
+			goto err;
+	}
+
+	ret = pasid_lu_do_op(dir, op);
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	if (op != PASID_LU_OP_PRESERVE)
+		return ret;
+
+	for (; i >= 0; i--) {
+		table = get_pasid_table_from_pde(&dir[i]);
+		if (!table)
+			continue;
+
+		pasid_lu_do_op(table, PASID_LU_OP_UNPRESERVE);
+	}
+
+	return ret;
+}
+
 int intel_iommu_preserve_device(struct device *dev,
 				struct iommu_device_ser *device_ser)
 {
-- 
2.54.0.1136.gdb2ca164c4-goog

