Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE252D8DA8
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 00:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789951737; cv=none; b=BFUJMWxFeVCika4CU7+l9oEnEaVCNCyBxKHqzfUDO54PMJOmMha8eYWwrS33+FWGj8CFTgQsRQ3OBvQvmMY3GqSc598edVoirjThMVYr+C9gLsvc0X+UKjV4SoPKkDOfoTK1YAksgqz5n0s38TpqkokW1J9eroLnL6siL6QCBrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789951737; c=relaxed/simple;
	bh=X89+9MCKR6N4rGgyZM3PSd3rBh+f/2+DypmElVBcadI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=frOu0LF7SlblOYGBC8+bMkDuMdUabVlZXEg1TALmRCPeNj36ds1bfeGsUW2mNmOYH2UWK0u0EIXdR9sg5mmhx6o76MdtrV1ZhTo71lfCGmb4LkFIe5Z9Mz0Z62N/tBqslv61TX0zMDpU+eh5Uq9/TTiO/LQQFJFF601wT25ozBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z0ZfCWyV; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z0ZfCWyV"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2dd1631d291so30552595ad.1
        for <kvm@vger.kernel.org>; Sun, 20 Sep 2026 17:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789951729; x=1790556529; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ah22k8fiMY4Ue4PB6FU/UzMwLJa6sW6U8ejSPLQHVqg=;
        b=Z0ZfCWyVOpkmSFBAz8qJfiH3xLdKV1Nt4aX2kngdDyRm56qS/70HolwdKZnT76q4sV
         Liuk+U1qztV/nlPkaGoydeEf+5vu4LCum2lsMdK+0PmYzQ0kL3oYRX1Mf8d+VS2bK5oI
         dYVdTYOWEwvmeEk/jFEpm24gsxgz+PsU+kdCpMkwjtLr60ICzLLIUvwsNKS/wU1SGb/o
         VUgzpEvhallJRzc8eO49CvERLeiRYrKiMVIruMhIKxNxRBCLLchzQkJ0cYLyz0oWLXji
         BxSgnF18MFYzz9hx1hH1ZYKoU18j8eHsmVA9l6tF+i4bZ03HHr9yPdCDge6q5CPmQHCI
         OikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789951729; x=1790556529;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ah22k8fiMY4Ue4PB6FU/UzMwLJa6sW6U8ejSPLQHVqg=;
        b=arLyuUMXEN5Ay++28haZyc+eqd6b8UDTyIVwt700tRBU9mQ8G8bKARjGcqjlR2lcor
         DKRuuWZFswz44PntI3DQu1H2mIZqSdbTHPCQWxsGRvb20EcxCg5QV0dRl8dqkzEw1QUa
         YcUYI9fNzqRScs9jCApVmGDljFQBBgo7UhdqQG++ixekSz525ep+KkUSNfRsf5twoNdu
         ruBFMFuk0pEwvJzOc1Uw9pc8iY6Mx5WVxy7khwUhqOlJIyjUxFAKKT63HdY1Ed7i9zkE
         c1qAH77t6z6UGxPnMTlcWGxtPIhqRvQKLcbzCwA5WB0vawXXeW91pa/f2eUCj7cLyMUu
         Ua9w==
X-Forwarded-Encrypted: i=1; AKwUvBxE07vVjbFPpGJh2ESPVH+9PGm/3cvcLPWoMiUjMQzydpQfDu060zZwUGSEFEK418GfXPA=@vger.kernel.org
X-Gm-Message-State: AFuF++nExZk+5auvvUH8dX3RewlH2SWyDzVFhImZJzXjL+wra0nSCaZ3
	hLZqQ1m/1U3J6wRtwj2ULGlvTBHWHPpvR+EkdtvhjbDboHY1JV0P9OHwiOJFmI9g9Jj8pCl2Jmr
	fMSvBiVWzAVS5nQ==
X-Received: from plg10.prod.google.com ([2002:a17:902:c24a:b0:2dd:2c40:5497])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:fc50:b0:2dd:c053:e0f6 with SMTP id d9443c01a7336-2ddc053e13emr81757465ad.37.1789951729140;
 Sun, 20 Sep 2026 17:48:49 -0700 (PDT)
Date: Mon, 21 Sep 2026 00:48:26 +0000
In-Reply-To: <20260921004834.2601285-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921004834.2601285-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921004834.2601285-11-skhawaja@google.com>
Subject: [PATCH v5 10/18] iommu/vt-d: Restore IOMMU state and reclaimed domain ids
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

During boot fetch the preserved state of IOMMU unit and if found then
restore the state.

- Reuse the root_table that was preserved in the previous kernel.
- Reclaim the domain ids of the preserved domains for each preserved
  devices so these are not acquired by another domain.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/intel/iommu.c      | 111 +++++++++++++++++++------------
 drivers/iommu/intel/iommu.h      |   7 ++
 drivers/iommu/intel/liveupdate.c |  79 ++++++++++++++++++++++
 3 files changed, 154 insertions(+), 43 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 474c926172c5..c5044e834337 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -987,28 +987,30 @@ static void iommu_disable_translation(struct intel_iommu *iommu)
 	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
 }
 
-static void disable_dmar_iommu(struct intel_iommu *iommu)
+static void release_dmar_iommu(struct intel_iommu *iommu)
 {
-	/*
-	 * All iommu domains must have been detached from the devices,
-	 * hence there should be no domain IDs in use.
-	 */
-	if (WARN_ON(!ida_is_empty(&iommu->domain_ida)))
-		return;
+	struct iommu_hw_ser *iommu_ser;
 
-	if (iommu->gcmd & DMA_GCMD_TE)
-		iommu_disable_translation(iommu);
-}
+	iommu_ser = iommu_get_preserved_data(iommu->reg_phys, IOMMU_INTEL);
+	if (!iommu_ser) {
+		/*
+		 * All iommu domains must have been detached from the devices,
+		 * hence there should be no domain IDs in use.
+		 */
+		WARN_ON(!ida_is_empty(&iommu->domain_ida));
+
+		if ((iommu->gcmd & DMA_GCMD_TE))
+			iommu_disable_translation(iommu);
+	}
 
-static void free_dmar_iommu(struct intel_iommu *iommu)
-{
 	if (iommu->copied_tables) {
 		bitmap_free(iommu->copied_tables);
 		iommu->copied_tables = NULL;
 	}
 
-	/* free context mapping */
-	free_context_table(iommu);
+	/* free context mapping if there is no serialized state. */
+	if (!iommu_ser)
+		free_context_table(iommu);
 
 	if (ecap_prs(iommu->ecap))
 		intel_iommu_finish_prq(iommu);
@@ -1632,12 +1634,19 @@ static int copy_translation_tables(struct intel_iommu *iommu)
 
 static int __init init_dmars(void)
 {
+	struct iommu_hw_ser *iommu_ser;
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu;
 	int ret;
 
 	for_each_iommu(iommu, drhd) {
+		iommu_ser = iommu_get_preserved_data(iommu->reg_phys, IOMMU_INTEL);
 		if (drhd->ignored) {
+			if (WARN_ON(iommu_ser)) {
+				ret = -EINVAL;
+				goto free_iommu;
+			}
+
 			iommu_disable_translation(iommu);
 			continue;
 		}
@@ -1655,7 +1664,9 @@ static int __init init_dmars(void)
 		}
 
 		intel_iommu_init_qi(iommu);
-		init_translation_status(iommu);
+
+		if (!iommu_ser)
+			init_translation_status(iommu);
 
 		if (translation_pre_enabled(iommu) && !is_kdump_kernel()) {
 			iommu_disable_translation(iommu);
@@ -1664,14 +1675,18 @@ static int __init init_dmars(void)
 				iommu->name);
 		}
 
-		/*
-		 * TBD:
-		 * we could share the same root & context tables
-		 * among all IOMMU's. Need to Split it later.
-		 */
-		ret = iommu_alloc_root_entry(iommu);
-		if (ret)
-			goto free_iommu;
+		if (iommu_ser) {
+			intel_iommu_liveupdate_restore_root_table(iommu, iommu_ser);
+		} else {
+			/*
+			 * TBD:
+			 * we could share the same root & context tables
+			 * among all IOMMU's. Need to Split it later.
+			 */
+			ret = iommu_alloc_root_entry(iommu);
+			if (ret)
+				goto free_iommu;
+		}
 
 		if (translation_pre_enabled(iommu)) {
 			pr_info("Translation already enabled - trying to copy translation structures\n");
@@ -1707,7 +1722,10 @@ static int __init init_dmars(void)
 	 */
 	for_each_active_iommu(iommu, drhd) {
 		iommu_flush_write_buffer(iommu);
-		iommu_set_root_entry(iommu);
+
+		iommu_ser = iommu_get_preserved_data(iommu->reg_phys, IOMMU_INTEL);
+		if (!iommu_ser)
+			iommu_set_root_entry(iommu);
 	}
 
 	check_tylersburg_isoch();
@@ -1752,10 +1770,8 @@ static int __init init_dmars(void)
 	return 0;
 
 free_iommu:
-	for_each_active_iommu(iommu, drhd) {
-		disable_dmar_iommu(iommu);
-		free_dmar_iommu(iommu);
-	}
+	for_each_active_iommu(iommu, drhd)
+		release_dmar_iommu(iommu);
 
 	return ret;
 }
@@ -2136,17 +2152,28 @@ int dmar_parse_one_satc(struct acpi_dmar_header *hdr, void *arg)
 static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 {
 	struct intel_iommu *iommu = dmaru->iommu;
+	struct iommu_hw_ser *iommu_ser;
 	int ret;
 
+	/* Use IOMMU HW unit MMIO base to identify the preserved state. */
+	iommu_ser = iommu_get_preserved_data(iommu->reg_phys, IOMMU_INTEL);
+
 	/*
 	 * Disable translation if already enabled prior to OS handover.
 	 */
-	if (iommu->gcmd & DMA_GCMD_TE)
+	if (!iommu_ser && iommu->gcmd & DMA_GCMD_TE)
 		iommu_disable_translation(iommu);
 
-	ret = iommu_alloc_root_entry(iommu);
-	if (ret)
-		goto out;
+	if (iommu_ser) {
+		if (WARN_ON(dmaru->ignored))
+			return -EINVAL;
+
+		intel_iommu_liveupdate_restore_root_table(iommu, iommu_ser);
+	} else {
+		ret = iommu_alloc_root_entry(iommu);
+		if (ret)
+			goto out;
+	}
 
 	intel_svm_check(iommu);
 
@@ -2165,23 +2192,23 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 	if (ecap_prs(iommu->ecap)) {
 		ret = intel_iommu_enable_prq(iommu);
 		if (ret)
-			goto disable_iommu;
+			goto out;
 	}
 
 	ret = dmar_set_interrupt(iommu);
 	if (ret)
-		goto disable_iommu;
+		goto out;
+
+	if (!iommu_ser)
+		iommu_set_root_entry(iommu);
 
-	iommu_set_root_entry(iommu);
 	iommu_enable_translation(iommu);
 
 	iommu_disable_protect_mem_regions(iommu);
 	return 0;
 
-disable_iommu:
-	disable_dmar_iommu(iommu);
 out:
-	free_dmar_iommu(iommu);
+	release_dmar_iommu(iommu);
 	return ret;
 }
 
@@ -2195,12 +2222,10 @@ int dmar_iommu_hotplug(struct dmar_drhd_unit *dmaru, bool insert)
 	if (iommu == NULL)
 		return -EINVAL;
 
-	if (insert) {
+	if (insert)
 		ret = intel_iommu_add(dmaru);
-	} else {
-		disable_dmar_iommu(iommu);
-		free_dmar_iommu(iommu);
-	}
+	else
+		release_dmar_iommu(iommu);
 
 	return ret;
 }
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 4feb5bd76b18..3a2cb08c0ac1 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1308,10 +1308,17 @@ int intel_iommu_preserve(struct iommu_device *iommu,
 void intel_iommu_unpreserve(struct iommu_device *iommu,
 			    struct iommu_hw_ser *iommu_ser);
 void clear_unpreserved_context_entries(struct intel_iommu *iommu);
+void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
+					       struct iommu_hw_ser *iommu_ser);
 #else
 static inline void clear_unpreserved_context_entries(struct intel_iommu *iommu)
 {
 }
+
+static inline void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
+							     struct iommu_hw_ser *iommu_ser)
+{
+}
 #endif
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
index 501dc0e9cc0a..c9e553379683 100644
--- a/drivers/iommu/intel/liveupdate.c
+++ b/drivers/iommu/intel/liveupdate.c
@@ -272,6 +272,85 @@ static int preserve_iommu_context_tables(struct device_domain_info *info)
 	return 0;
 }
 
+static void restore_iommu_context(struct intel_iommu *iommu)
+{
+	struct context_entry *context;
+	int i;
+
+	for (i = 0; i < ROOT_ENTRY_NR; i++) {
+		context = iommu_context_addr(iommu, i, 0, 0);
+		if (context)
+			iommu_restore_pages(virt_to_phys(context));
+
+		if (!sm_supported(iommu))
+			continue;
+
+		context = iommu_context_addr(iommu, i, 0x80, 0);
+		if (context)
+			iommu_restore_pages(virt_to_phys(context));
+	}
+}
+
+static int _restore_used_domain_ids(struct iommu_device_ser *ser, void *arg)
+{
+	int id = ser->domain_iommu_ser.attachment_id;
+	struct iommu_hw_ser *iommu_hw_ser;
+	struct intel_iommu *iommu = arg;
+	int ret;
+
+	if (WARN_ON(!ser->domain_iommu_ser.iommu_phys))
+		return 0;
+
+	iommu_hw_ser = phys_to_virt(ser->domain_iommu_ser.iommu_phys);
+	if (iommu_hw_ser->type != IOMMU_INTEL)
+		return 0;
+
+	/* Only allocate domain ID from associated IOMMU HW unit */
+	if (iommu_hw_ser->intel.phys_addr != iommu->reg_phys)
+		return 0;
+
+	guard(mutex)(&iommu->did_lock);
+
+	/*
+	 * The domain IDs are reclaimed while the IOMMU HW unit is being
+	 * restored and not registered with the IOMMU core. So if the ID already
+	 * exists, it is safe to assume that a preserved device sharing the same
+	 * domain ID reclaimed it.
+	 */
+	if (ida_exists(&iommu->domain_ida, id))
+		return 0;
+
+	ret = ida_alloc_range(&iommu->domain_ida, id, id, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+/**
+ * intel_iommu_liveupdate_restore_root_table() - Restore root table and reclaim domain IDs
+ * @iommu: Target IOMMU
+ * @iommu_ser: Serialized IOMMU hardware state from previous kernel
+ *
+ * Restores the preserved root table and context tables for the IOMMU hardware
+ * instance across Live Update, and reclaims all domain IDs previously allocated
+ * to preserved devices so they are not reused.
+ */
+void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
+					       struct iommu_hw_ser *iommu_ser)
+{
+	if (!iommu_ser->intel.restored)
+		iommu_restore_pages(iommu_ser->intel.root_table);
+
+	iommu->root_entry = __va(iommu_ser->intel.root_table);
+
+	if (!iommu_ser->intel.restored)
+		restore_iommu_context(iommu);
+
+	iommu_ser->intel.restored = 1;
+	BUG_ON(iommu_for_each_preserved_device(_restore_used_domain_ids, iommu));
+}
+
 /**
  * intel_iommu_preserve_device() - Intel IOMMU callback to preserve device state
  * @dev: Target device
-- 
2.55.0.1082.g2b9226bbc0-goog

