Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792894788;
	b=yyY5XScFI/bOhRNl5CtSq1rpM7mZy5LssOrGvhlozpn1D5FW/5vW9l/7qXeR8fEHMoxB
	 Ymw78XAHZLCnNaoNi/+Vj4mGWG/CT9u1QfY7+M9u2gltGseHPWpNWCbFrpaMsjaLc5jGR
	 +sdtDXSg8yxT6J+wDqqZymzhahh4T7ZCR/V7kPVvSx0IxyYEKvaHRwGcz9Ci7kDt0iZsL
	 zLbBchg8uVROLRdiAglOZG4DpEarkCfpOf2nvIDIYxuzlhmMe3CJats9cWRLvhAByYkOK
	 Kno6F5m6/h4ZOLF4zJvN8LSXU7WTdwJbaH8f75oQO6dZG+UVsNfgFtTyVRsEQXGUVXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792894788;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=KGhIRmOt/7bUgfrph7ctaagKlDay/18DRVB5PVXETrk=;
	b=Q+HMuurZLXniloVDF9907Jzs3dre3wZxwkorZeTjfPoNv4DXO+JW3FRZx/U1uwOH4Sqe
	 TMXLA8Bj8zpF4Q2IuNAqmsqPSCjE+Kg05i3/Wf5KIV/7v2OJijrXYhw+Sack7lLwWwvMH
	 RmBWLD+6WNEPNyL+xQ+rJ7jL3epnAm0r8yhY4XoAJKwTZYMxw21azEFqZ7AyhM/ntbpVv
	 pPxaTMKwzXPC4bbIerabfJKFoLicUA5DSLsS1MZBMm9OxcgVLnhFcH2xFozI3Y6lUtLy3
	 p196rzcUzIV2olZjFmFxI+7ZLb7IJQV5OQ/5FcuhpLalLQHWWSACDlxNp2qtW3Z8zMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="ZZ8xI/5O";
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8535D606A985
	for <kvm@vger.kernel.org>; Sun, 25 Oct 2026 02:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8535D606A985
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ZZ8xI/5O
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e8e16d22d8so33775575ad.1
        for <kvm@vger.kernel.org>; Sat, 24 Oct 2026 19:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792894788; x=1793499588; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KGhIRmOt/7bUgfrph7ctaagKlDay/18DRVB5PVXETrk=;
        b=ZZ8xI/5O5u7rYk71mZIhCWu5HmCH99ZVheNrfAXC0zvJ5mLc9PcWujBwtvZuH21gPs
         tDVgFD29u4yWvz3bmxztGp7z76o4Gg/Wj+bhR6sRInGZzMfxD2U/JirqJz3LmIffxS5n
         zWDRzYKU0pc51BKlxyVOcnB9Pb2ZCPTy8moD5dbe4YBukkw6ls8GvWPNSBARyv5vPZdL
         4BwREmOz4vCDYWYb9DZWJzk1BNFVzAPBf4cxibVIk2H1k0gDdmEK8W02S3Cqzi/KSInj
         GTle2SMlDSgPIwe61akjpedW2AL3tv5SS76oLxXnKK+ZVBjhIYEGKNdXbUYIyZlmlef2
         GHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792894788; x=1793499588;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KGhIRmOt/7bUgfrph7ctaagKlDay/18DRVB5PVXETrk=;
        b=INFcyuPRKaSVX5Ree+LlDvnyEOnMaEsyTZEs+/3MX7fAb6Ft1Wc4DhDpV0afInUgpF
         lo+D3zw6mRhhxiRSrNs4hWYnvStjY9+yVICRJGSTvvI7tjjAUo7rPg1eoT3Uqb2CuA52
         sJ1U6BD3is99ZRc4Q6Z+e8Ne7Fvd+O6ChSWhBUnzmJLzeoVnSCZYazqnLKKYYgBpbq9m
         R5n5RR12tFLgkNfu9nInNFSvfislWrspIC/IAR1pxi1Xjc5IcxV3XFS2jK5kvvhwscdw
         XZCR/PuPw5yYqQaincV8zM5fPLSfOcU3dSp5j1RhFiZn7HxbWhjF42yFt6JrjhlRrfa8
         qIaQ==
X-Forwarded-Encrypted: i=1; AKwUvBzQI+ED3dM53s2icficFFncwP+J/UdIeJlrElazsnNUlAfFEQYmmuSXN6EDyks9kUsNFxw=@vger.kernel.org
X-Gm-Message-State: AFq9FYL/2L6mJKsKUX+Z/YNJ2ncJnV01FauVTHPYt8qwsagtSBwjKUTq
	JDAPEo0M1fHnVMC1NiV/5x1d7GR8GSC/7vD8GLL9/IFeIFLv6ggWH+q2xYqG2XvrUtHMfroP/zV
	0Mjj4loeqSHBPQw==
X-Received: from pllw1.prod.google.com ([2002:a17:902:7b81:b0:2e9:6468:1ffe])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d2c4:b0:2e2:d77b:e586 with SMTP id d9443c01a7336-2ea9c91f46fmr26922485ad.60.1792894787634;
 Sat, 24 Oct 2026 19:19:47 -0700 (PDT)
Date: Sun, 25 Oct 2026 02:19:21 +0000
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
Message-ID: <20261025021930.674647-11-skhawaja@google.com>
Subject: [PATCH v6 10/18] iommu/vt-d: Restore IOMMU state and reclaimed domain ids
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

During boot fetch the preserved state of IOMMU unit and if found then
restore the state.

- Reuse the root_table that was preserved in the previous kernel.
- Reclaim the domain ids of the preserved domains for each preserved
  devices so these are not acquired by another domain.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/intel/iommu.c      |  71 ++++++++++++------
 drivers/iommu/intel/iommu.h      |  14 ++++
 drivers/iommu/intel/liveupdate.c | 121 +++++++++++++++++++++++++++++++
 3 files changed, 185 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 35ec2ae0c8d5..991ad9b2456e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -987,6 +987,8 @@ static void iommu_disable_translation(struct intel_iommu *iommu)
 
 static void release_dmar_iommu(struct intel_iommu *iommu)
 {
+	intel_iommu_handle_drhd_restore_failure(iommu);
+
 	/*
 	 * All iommu domains must have been detached from the devices,
 	 * hence there should be no domain IDs in use.
@@ -1452,7 +1454,7 @@ static void intel_iommu_init_qi(struct intel_iommu *iommu)
  * Returns 0 when the ID is reserved, was already reserved, or cannot be
  * re-assigned, and a negative errno for a genuine allocation failure.
  */
-static int reserve_domain_id(struct intel_iommu *iommu, int did)
+int reserve_domain_id(struct intel_iommu *iommu, int did)
 {
 	int ret;
 
@@ -1743,12 +1745,16 @@ static int copy_translation_tables(struct intel_iommu *iommu)
 
 static int __init init_dmars(void)
 {
+	struct iommu_hw_ser *iommu_ser;
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu;
 	int ret;
 
 	for_each_iommu(iommu, drhd) {
+		iommu_ser = iommu_get_preserved_data(iommu->reg_phys,
+						     IOMMU_SER_TYPE_INTEL);
 		if (drhd->ignored) {
+			intel_iommu_handle_drhd_restore_failure(iommu);
 			iommu_disable_translation(iommu);
 			continue;
 		}
@@ -1766,7 +1772,9 @@ static int __init init_dmars(void)
 		}
 
 		intel_iommu_init_qi(iommu);
-		init_translation_status(iommu);
+
+		if (!iommu_ser)
+			init_translation_status(iommu);
 
 		if (translation_pre_enabled(iommu) && !is_kdump_kernel()) {
 			iommu_disable_translation(iommu);
@@ -1775,14 +1783,18 @@ static int __init init_dmars(void)
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
@@ -1818,7 +1830,11 @@ static int __init init_dmars(void)
 	 */
 	for_each_active_iommu(iommu, drhd) {
 		iommu_flush_write_buffer(iommu);
-		iommu_set_root_entry(iommu);
+
+		iommu_ser = iommu_get_preserved_data(iommu->reg_phys,
+						     IOMMU_SER_TYPE_INTEL);
+		if (!iommu_ser)
+			iommu_set_root_entry(iommu);
 	}
 
 	check_tylersburg_isoch();
@@ -2245,17 +2261,28 @@ int dmar_parse_one_satc(struct acpi_dmar_header *hdr, void *arg)
 static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 {
 	struct intel_iommu *iommu = dmaru->iommu;
+	struct iommu_hw_ser *iommu_ser;
 	int ret;
 
-	/*
-	 * Disable translation if already enabled prior to OS handover.
-	 */
-	if (iommu->gcmd & DMA_GCMD_TE)
-		iommu_disable_translation(iommu);
+	/* Use IOMMU HW unit MMIO base to identify the preserved state. */
+	iommu_ser = iommu_get_preserved_data(iommu->reg_phys,
+					     IOMMU_SER_TYPE_INTEL);
+	if (iommu_ser) {
+		if (dmaru->ignored)
+			intel_iommu_handle_drhd_restore_failure(iommu);
 
-	ret = iommu_alloc_root_entry(iommu);
-	if (ret)
-		goto out;
+		intel_iommu_liveupdate_restore_root_table(iommu, iommu_ser);
+	} else {
+		/*
+		 * Disable translation if already enabled prior to OS handover.
+		 */
+		if (iommu->gcmd & DMA_GCMD_TE)
+			iommu_disable_translation(iommu);
+
+		ret = iommu_alloc_root_entry(iommu);
+		if (ret)
+			goto out;
+	}
 
 	intel_svm_check(iommu);
 
@@ -2281,7 +2308,8 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 	if (ret)
 		goto out;
 
-	iommu_set_root_entry(iommu);
+	if (!iommu_ser)
+		iommu_set_root_entry(iommu);
 	iommu_enable_translation(iommu);
 
 	iommu_disable_protect_mem_regions(iommu);
@@ -2797,7 +2825,8 @@ int __init intel_iommu_init(void)
 		 * to avoid unnecessary lock order splat.
 		 */
 		up_read(&dmar_global_lock);
-		iommu_device_register(&iommu->iommu, &intel_iommu_ops, NULL);
+		if (iommu_device_register(&iommu->iommu, &intel_iommu_ops, NULL))
+			intel_iommu_handle_drhd_restore_failure(iommu);
 		down_read(&dmar_global_lock);
 
 		iommu_pmu_register(iommu);
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 16ab103d308a..260c7a5b1240 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1307,6 +1307,8 @@ static inline int iopf_for_domain_replace(struct iommu_domain *new,
 	return 0;
 }
 
+int reserve_domain_id(struct intel_iommu *iommu, int did);
+
 #ifdef CONFIG_IOMMU_LIVEUPDATE
 int intel_iommu_preserve_device(struct device *dev,
 				struct iommu_device_ser *device_ser);
@@ -1317,10 +1319,22 @@ int intel_iommu_preserve(struct iommu_device *iommu,
 void intel_iommu_unpreserve(struct iommu_device *iommu,
 			    struct iommu_hw_ser *iommu_ser);
 void clear_unpreserved_context_entries(struct intel_iommu *iommu);
+void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
+					       struct iommu_hw_ser *iommu_ser);
+void intel_iommu_handle_drhd_restore_failure(struct intel_iommu *iommu);
 #else
 static inline void clear_unpreserved_context_entries(struct intel_iommu *iommu)
 {
 }
+
+static inline void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
+							     struct iommu_hw_ser *iommu_ser)
+{
+}
+
+static inline void intel_iommu_handle_drhd_restore_failure(struct intel_iommu *iommu)
+{
+}
 #endif
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
index f92cb774cc99..cf98b95bf8d2 100644
--- a/drivers/iommu/intel/liveupdate.c
+++ b/drivers/iommu/intel/liveupdate.c
@@ -272,6 +272,127 @@ static int preserve_iommu_context_tables(struct device_domain_info *info)
 	return 0;
 }
 
+static int restore_context_table(struct intel_iommu *iommu,
+				 struct iommu_hw_ser *ser,
+				 u8 bus, u8 devfn, u64 root_val)
+{
+	bool present = root_val & 1;
+
+	/*
+	 * The root entries of unpreserved context tables are cleared during
+	 * shutdown, so the preserved bitmap must match the present bits.
+	 */
+	if (is_context_table_preserved(iommu, ser, bus, devfn) != present)
+		return -EINVAL;
+
+	if (present)
+		iommu_restore_pages(root_val & VTD_PAGE_MASK);
+
+	return 0;
+}
+
+static int restore_iommu_context(struct intel_iommu *iommu,
+				 struct iommu_hw_ser *ser)
+{
+	struct root_entry *root;
+	int ret;
+	int i;
+
+	for (i = 0; i < ROOT_ENTRY_NR; i++) {
+		root = &iommu->root_entry[i];
+
+		ret = restore_context_table(iommu, ser, i, 0, root->lo);
+		if (ret)
+			return ret;
+
+		if (!sm_supported(iommu))
+			continue;
+
+		ret = restore_context_table(iommu, ser, i, 0x80, root->hi);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int _restore_used_domain_ids(struct iommu_device_ser *ser, void *arg)
+{
+	int id = ser->attachment.attachment_id;
+	struct iommu_hw_ser *iommu_hw_ser;
+	struct intel_iommu *iommu = arg;
+
+	if (WARN_ON(!ser->iommu_phys))
+		return 0;
+
+	iommu_hw_ser = phys_to_virt(ser->iommu_phys);
+	if (iommu_hw_ser->type != IOMMU_SER_TYPE_INTEL)
+		return 0;
+
+	/* Only allocate domain ID from associated IOMMU HW unit */
+	if (iommu_hw_ser->intel.phys_addr != iommu->reg_phys)
+		return 0;
+
+	return reserve_domain_id(iommu, id);
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
+ *
+ * The preserved devices keep doing DMA through the preserved translation
+ * tables, so a failure to restore them is fatal.
+ */
+void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
+					       struct iommu_hw_ser *iommu_ser)
+{
+	int ret;
+
+	/*
+	 * The kernel command line might have changed across kexec, e.g.
+	 * intel_iommu=sm_off, so make sure the preserved tables are in the
+	 * format this kernel is going to use.
+	 */
+	if (iommu_ser->intel.sm_enabled != sm_supported(iommu))
+		panic("%s: preserved scalable mode %u does not match current %u\n",
+		      iommu->name, iommu_ser->intel.sm_enabled,
+		      sm_supported(iommu));
+
+	iommu_restore_pages(iommu_ser->intel.root_table);
+	iommu->root_entry = __va(iommu_ser->intel.root_table);
+
+	ret = restore_iommu_context(iommu, iommu_ser);
+	if (ret)
+		panic("%s: failed to restore preserved context tables\n",
+		      iommu->name);
+
+	ret = iommu_for_each_preserved_device(_restore_used_domain_ids, iommu);
+	if (ret)
+		panic("%s: failed to reclaim preserved domain IDs: %d\n",
+		      iommu->name, ret);
+}
+
+/**
+ * intel_iommu_handle_drhd_restore_failure() - Handle DRHD restore failure
+ * @iommu: Target IOMMU
+ */
+void intel_iommu_handle_drhd_restore_failure(struct intel_iommu *iommu)
+{
+	/*
+	 * The preserved devices keep doing DMA through the preserved
+	 * translation tables, so a failure to restore and register the IOMMU
+	 * is fatal.
+	 */
+	if (iommu_get_preserved_data(iommu->reg_phys, IOMMU_SER_TYPE_INTEL))
+		panic("%s: failed to restore IOMMU with preserved state\n",
+		      iommu->name);
+}
+
 /**
  * intel_iommu_preserve_device() - Intel IOMMU callback to preserve device state
  * @dev: Target device
-- 
2.56.0.257.gf7497c7d27-goog

