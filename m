Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADA9384CEF
	for <kvm@vger.kernel.org>; Sun, 14 Jun 2026 23:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781480260; cv=none; b=q4MghA3UmX0c4awo8Ry+k32QOV4/7MYcZaD6NoT5Omb5rfFlT3qt4s22XJqUCWkKhmJomCiteDoxwvmePgduoIqKzhApoxJoNlebkKpUJOd7J/kziQGvt1kJXmBv1g+X8ObhKSW5TUYsroIOhHOI/XyrHMD8zWXRXpUouayjjXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781480260; c=relaxed/simple;
	bh=aMbX06rlhG+1QmYo3WKCF7oefb/cuV0I4cRUBRNE13s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pfiIqB0wu+0ZqaA6Ka5ZDGQdycNa06XLVefVWIhW76V7Lqv4cWGzTL0uW9HCyMoYb/FJnAkOneiodTjl6o1X3s7knYHMnlAXYutGKK8qn4XJzmS9eR0C1zGZot1bYen4tVmJNhDi6uvvq+D4WKScuduiN+F6aHYAHxFdKdNaHk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j/Taxs/3; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j/Taxs/3"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d99629fd6so4377831a91.1
        for <kvm@vger.kernel.org>; Sun, 14 Jun 2026 16:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781480258; x=1782085058; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GmdCulMV2zbK5YeSCz8cw2yfsZr81jNCbe9dmwHORos=;
        b=j/Taxs/3eIGrqxQfioHxPNVIGAEJnx1oJdfoM5vAGXkOL/1Ye38C9mqIz8FnLANIfB
         E3ZzQe63ke9g/QBeslKzvpMJfex/2PbNRTXxo6fxvEeP9AEgmJH2vrpJHww5JnAEbRIJ
         OpnkD1DQ3k9KJ2dxMJ/kP27MFm1WxdY7O9f/5bPs/+t8RMnG6BnNF2+BGECzA9qYyltI
         hjU27RL2w4hPnyjwZhXGseW6U4C2ejY547v+MR2+9tCHnptDVJlD6WVUYcO9+fIFzPWX
         T3t+HtkjN8pMIcti/D3sTin88Oz8W+AvQ5fpmG+R6OiwgU7LTOC6vfuiAm1nRCKFUH35
         nhTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781480258; x=1782085058;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GmdCulMV2zbK5YeSCz8cw2yfsZr81jNCbe9dmwHORos=;
        b=XVMCULtfDaXtFDEIGF94ao6DGBuu2UoEsVYWUiSzUK7/S2ontQb0SA+YG9tfJp7IAw
         311lTyy5J/iXMKxMUQeyAfNMTy5x/80O4UdOCV5hNG7pLe6DzFIM1g1s0PBgWSNfOy9u
         CwvYEAWjMV9LsqRjdY5gaPcPz0iS92m07jQaW7n/OD9b34HL8iPXNNRg/gxfkZWXrMK8
         mb0cQEdlIHCuqcCaYT2FgEg0BJpGgE+jlxpsrrGfM5MwKtgee23iqNKSRPOxuszlqqCJ
         ypN0iOK3v9ypNtezA0YNG6VYzycSJ+Q4mz0t/1CuwGxJGHVk4kHOk4PWUFsuOiX6HJPH
         v8Kw==
X-Forwarded-Encrypted: i=1; AFNElJ/hLkayYvm3/BQw8BkMn7+gWFawTfPUiqCnTJczqvOKUvwMDBRI256A1WbPBWMtkwc3QJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz75z9Ynu4pLpX0YD2UCEam4wKdlvnMSm60sp1TGu48MhYUcx8w
	nnK+nzMwhR1A00bIKiQKUTao72AwwgwOWZhccfUOcr5ix1zF+uvYynvyXZTNuQfzW053bSXnC3x
	II5zF93paHDDU0w==
X-Received: from plbjc5.prod.google.com ([2002:a17:903:25c5:b0:2b4:62bc:c2a9])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:41ce:b0:2bd:eeb6:ff28 with SMTP id d9443c01a7336-2c4109ed35dmr125651205ad.12.1781480257639;
 Sun, 14 Jun 2026 16:37:37 -0700 (PDT)
Date: Sun, 14 Jun 2026 23:37:20 +0000
In-Reply-To: <20260614233728.2212104-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260614233728.2212104-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260614233728.2212104-11-skhawaja@google.com>
Subject: [PATCH v3 10/18] iommu/vt-d: Restore IOMMU state and reclaimed domain ids
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
 drivers/iommu/intel/iommu.c      | 87 +++++++++++++++++++++++---------
 drivers/iommu/intel/iommu.h      |  7 +++
 drivers/iommu/intel/liveupdate.c | 60 ++++++++++++++++++++++
 3 files changed, 130 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 26258861e3bf..cd40e274482b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -990,15 +990,16 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
 		iommu_disable_translation(iommu);
 }
 
-static void free_dmar_iommu(struct intel_iommu *iommu)
+static void free_dmar_iommu(struct intel_iommu *iommu, struct iommu_hw_ser *iommu_ser)
 {
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
@@ -1609,6 +1610,7 @@ static int copy_translation_tables(struct intel_iommu *iommu)
 
 static int __init init_dmars(void)
 {
+	struct iommu_hw_ser *iommu_ser = NULL;
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu;
 	int ret;
@@ -1631,8 +1633,16 @@ static int __init init_dmars(void)
 						   intel_pasid_max_id);
 		}
 
+		iommu_ser = iommu_get_preserved_data(iommu->reg_phys, IOMMU_INTEL);
+		if (iommu_ser && IS_ERR(iommu_ser)) {
+			ret = PTR_ERR(iommu_ser);
+			goto free_iommu;
+		}
+
 		intel_iommu_init_qi(iommu);
-		init_translation_status(iommu);
+
+		if (!iommu_ser)
+			init_translation_status(iommu);
 
 		if (translation_pre_enabled(iommu) && !is_kdump_kernel()) {
 			iommu_disable_translation(iommu);
@@ -1641,14 +1651,18 @@ static int __init init_dmars(void)
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
@@ -1684,7 +1698,10 @@ static int __init init_dmars(void)
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
@@ -1730,8 +1747,11 @@ static int __init init_dmars(void)
 
 free_iommu:
 	for_each_active_iommu(iommu, drhd) {
-		disable_dmar_iommu(iommu);
-		free_dmar_iommu(iommu);
+		iommu_ser = iommu_get_preserved_data(iommu->reg_phys, IOMMU_INTEL);
+		if (!iommu_ser)
+			disable_dmar_iommu(iommu);
+
+		free_dmar_iommu(iommu, iommu_ser);
 	}
 
 	return ret;
@@ -2105,17 +2125,29 @@ int dmar_parse_one_satc(struct acpi_dmar_header *hdr, void *arg)
 static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 {
 	struct intel_iommu *iommu = dmaru->iommu;
+	struct iommu_hw_ser *iommu_ser = NULL;
 	int ret;
 
+	/* Use IOMMU HW unit MMIO base to identify the preserved state. */
+	iommu_ser = iommu_get_preserved_data(iommu->reg_phys, IOMMU_INTEL);
+	if (iommu_ser && IS_ERR(iommu_ser)) {
+		ret = PTR_ERR(iommu_ser);
+		goto out;
+	}
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
+		intel_iommu_liveupdate_restore_root_table(iommu, iommu_ser);
+	} else {
+		ret = iommu_alloc_root_entry(iommu);
+		if (ret)
+			goto out;
+	}
 
 	intel_svm_check(iommu);
 
@@ -2141,16 +2173,19 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 	if (ret)
 		goto disable_iommu;
 
-	iommu_set_root_entry(iommu);
+	if (!iommu_ser)
+		iommu_set_root_entry(iommu);
+
 	iommu_enable_translation(iommu);
 
 	iommu_disable_protect_mem_regions(iommu);
 	return 0;
 
 disable_iommu:
-	disable_dmar_iommu(iommu);
+	if (!iommu_ser)
+		disable_dmar_iommu(iommu);
 out:
-	free_dmar_iommu(iommu);
+	free_dmar_iommu(iommu, iommu_ser);
 	return ret;
 }
 
@@ -2158,6 +2193,7 @@ int dmar_iommu_hotplug(struct dmar_drhd_unit *dmaru, bool insert)
 {
 	int ret = 0;
 	struct intel_iommu *iommu = dmaru->iommu;
+	struct iommu_hw_ser *iommu_ser;
 
 	if (!intel_iommu_enabled)
 		return 0;
@@ -2167,8 +2203,11 @@ int dmar_iommu_hotplug(struct dmar_drhd_unit *dmaru, bool insert)
 	if (insert) {
 		ret = intel_iommu_add(dmaru);
 	} else {
-		disable_dmar_iommu(iommu);
-		free_dmar_iommu(iommu);
+		iommu_ser = iommu_get_preserved_data(iommu->reg_phys, IOMMU_INTEL);
+		if (!iommu_ser)
+			disable_dmar_iommu(iommu);
+
+		free_dmar_iommu(iommu, iommu_ser);
 	}
 
 	return ret;
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 561cc4d14912..a2c2cb86a7fc 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1295,6 +1295,8 @@ int intel_iommu_preserve(struct iommu_device *iommu,
 void intel_iommu_unpreserve(struct iommu_device *iommu,
 			    struct iommu_hw_ser *iommu_ser);
 void clear_unpreserved_context_entries(struct intel_iommu *iommu);
+void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
+					       struct iommu_hw_ser *iommu_ser);
 #else
 static inline int intel_iommu_preserve_device(struct device *dev,
 					      struct iommu_device_ser *device_ser)
@@ -1316,6 +1318,11 @@ static inline void intel_iommu_unpreserve(struct iommu_device *iommu,
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
index aac7aa89a182..1a1868e6cc59 100644
--- a/drivers/iommu/intel/liveupdate.c
+++ b/drivers/iommu/intel/liveupdate.c
@@ -194,6 +194,66 @@ static int preserve_iommu_context_tables(struct device_domain_info *info)
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
+
+	if (WARN_ON(!ser->domain_iommu_ser.iommu_phys))
+		return -ENOENT;
+
+	iommu_hw_ser = phys_to_virt(ser->domain_iommu_ser.iommu_phys);
+	if (iommu_hw_ser->type != IOMMU_INTEL)
+		return 0;
+
+	/* Only allocate domain ID from associated IOMMU HW unit */
+	if (iommu_hw_ser->intel.phys_addr != iommu->reg_phys)
+		return 0;
+
+	/*
+	 * This can fail as multiple preserved devices can share the same domain
+	 * ID. Since this is done during DMAR init so these failures can be
+	 * ignored.
+	 */
+	ida_alloc_range(&iommu->domain_ida, id, id, GFP_ATOMIC);
+	return 0;
+}
+
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
+	iommu_for_each_preserved_device(_restore_used_domain_ids, iommu);
+}
+
 int intel_iommu_preserve_device(struct device *dev,
 				struct iommu_device_ser *device_ser)
 {
-- 
2.54.0.1136.gdb2ca164c4-goog

