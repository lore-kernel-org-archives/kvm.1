Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795409403;
	b=HB6xGpTbhd3Nq4jAGXxrJF+56OOJXEsTVqt9kRXO8YJIIg9F10VBJ7myVBcbTlpPIB4W
	 MgHQYYgH32hYyOKe1sNxmmZsuyob7MqOzXIDIRewGziLMc4noJaM73YiDZIg71rwqSYj1
	 sf84JiZ+p2K34tdwgEQ2zqKWkwZdOdcwjL5DGrmDrj4QeTha9ACRwGlgy9jyY1GDGK2Wn
	 RdHdylnyKK0iJ6FMZnLpRK872QHezTk7tv1kmyAEWIQ3RMVC7X3cWb2nomZK62wcbcUN/
	 6ni2nRt7MuX/i1Yg91erksun4pSwruD5fmDz3jzRpaFKTDE3GqSVmwBJZXIXu25Q2Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795409403;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=C6VhN1OLbYZiYkuKR1be5UI619T8M9/2DAi+ji2/Sdk=;
	b=yCK8VJ4oy8qx7rOBw+L4FQcv+YCWcMjO4STm0flLHSNsLR2GwTeQjj0FF+6gRPsnXfVf
	 lITQnFF+VsK0tAkN00ze4V+vG/HIFONsH8tmFI2qODIxBCI3EtnJrWz98fFe/n09PvXIB
	 s5Mf/GiwBj8ZBTUASx4eAxJ/QNwAsxBVCG3Yzv1C/P0DB7G8rsXq5Kde/ck3qS1XhgoLs
	 RQfbAEy5E8ZytlW59jq6biCV/tmKwziol5AKgWB3w0p4O1CA7cdLLLQz1CMr51HzvtqWb
	 z2kwIFm1EpSYJk2ppJpoij1hVDDYONlYlZysaVjysWejrpK/gmvl4rQTGz1b8XT4qMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jVn4QtZA;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E5460A5BC5
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 04:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8E5460A5BC5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jVn4QtZA
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2edd25534afso23934305ad.2
        for <kvm@vger.kernel.org>; Sun, 22 Nov 2026 20:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795409401; x=1796014201; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C6VhN1OLbYZiYkuKR1be5UI619T8M9/2DAi+ji2/Sdk=;
        b=jVn4QtZAdnhkTVnCzTtesM1MTFPr+iSvbl+GrnTa+FZivZz/hXULzVvZEDvoVW7Kxv
         f+U+dAF4UrnCEbUjYUdblGg0yp/dQY3KG7k/mcdIDPg4YhKgucycdvlxCBiStpooiKRb
         OMvHvlEgsIakO2dIaGFY8BSZiAq+z2VEJoO7qs6AmPGMStN04rU4ELx3U2GEbnWhYIAT
         lZYgvr7DgmCmmfqN/Fq3B2qlRibNP7rD095LihjP3e5FtoSU0c6EpeTAMC740/LNI3ll
         TOv5EAs8BwZNTqMCZzS/alG7QpAlL/1ZiSqFlnZA5tgrMflsMB6jy0y9IXh8aVZys/QX
         irEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795409401; x=1796014201;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C6VhN1OLbYZiYkuKR1be5UI619T8M9/2DAi+ji2/Sdk=;
        b=HH3nyIijTuRPgWVEDNenhXGAXkzr87iqsILPLrQ8KnnEn1FT8+nPW7icm9hN9ik1wC
         nwW4f1fUITlR5BkawzNic23KnTEjUC66KZGILIFA8lJizxtpb/9C59qPn5OPc2hYIpvG
         P1rx0SbAOgCzSGVhk/v1mUZSK9wf6EcEZ2hUtjskHvNi1+ZjjDdUD6oiapB3B2Fiyrib
         zHEgn8nee5PjxDYnFE7eZEaRoQDzKjyGa8NLoML23LhZSC5JQET2zalL9I+/R8zsLFNa
         1qPEv7D5uzGDIWVdiJBIr94W0puO2Gpz1of1OFSgNPhgaZPF/bt1Au+TWeAb+1seiDM6
         ZIbg==
X-Forwarded-Encrypted: i=1; AL+hErGxfNsATa+UcHVNuLpyCiPt9Gr3kAbAxW8BBPYUS7h15BFH/eOjCRgTGd+7AupAApu9/pk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ZrVXOJ9+MZgkMe+jwPE0HxK8CHk2kRiPUQ44/o7T11y8NQiwo
	lbUHu0CZSxv8tY0yr296/ulGyyTgYrOTRJ9izi+iVS8tmSBSzcxwTLpQgM6TNPUx5etJQgGIxiC
	0C5RrwSNbFZduaw==
X-Received: from plkv7.prod.google.com ([2002:a17:903:1a27:b0:2ed:dddd:986])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f602:b0:2df:90d4:7847 with SMTP id d9443c01a7336-2f03f1bf176mr98306635ad.35.1795409400915;
 Sun, 22 Nov 2026 20:50:00 -0800 (PST)
Date: Mon, 23 Nov 2026 04:49:42 +0000
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
Message-ID: <20261123044949.3610702-12-skhawaja@google.com>
Subject: [PATCH v8 11/18] iommu/vt-d: Restore IOMMU state and reclaimed domain ids
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
 drivers/iommu/intel/iommu.c      |  86 ++++++++++++++++---
 drivers/iommu/intel/iommu.h      |  14 ++++
 drivers/iommu/intel/liveupdate.c | 139 +++++++++++++++++++++++++++++++
 3 files changed, 226 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 6c86c155d12b..691bfe34e575 100644
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
+		iommu_ser = iommu_get_restored_state(iommu->reg_phys,
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
+		iommu_ser = iommu_get_restored_state(iommu->reg_phys,
+						     IOMMU_SER_TYPE_INTEL);
+		if (!iommu_ser)
+			iommu_set_root_entry(iommu);
 	}
 
 	check_tylersburg_isoch();
@@ -2247,6 +2263,15 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 	struct intel_iommu *iommu = dmaru->iommu;
 	int ret;
 
+	/*
+	 * Hot-add of an IOMMU with preserved state is not supported. A
+	 * preserved IOMMU is restored during boot, so it should never get
+	 * here.
+	 */
+	if (WARN_ON(iommu_get_restored_state(iommu->reg_phys,
+					     IOMMU_SER_TYPE_INTEL)))
+		return -EBUSY;
+
 	/*
 	 * Disable translation if already enabled prior to OS handover.
 	 */
@@ -2689,6 +2714,33 @@ static __init void tboot_force_iommu(void)
 	no_iommu = 0;
 }
 
+/*
+ * Devices preserved across a live update keep doing DMA through the preserved
+ * translation tables, so the IOMMUs can't be turned off. Force them on if the
+ * previous kernel preserved any IOMMU state.
+ */
+static void __init liveupdate_force_iommu(void)
+{
+	struct dmar_drhd_unit *drhd;
+
+	if (dmar_policy_on())
+		return;
+
+	for_each_drhd_unit(drhd) {
+		if (!iommu_get_restored_state(drhd->reg_base_addr,
+					      IOMMU_SER_TYPE_INTEL))
+			continue;
+
+		pr_warn("Forcing Intel-IOMMU to enabled for live update\n");
+
+		/* No concurrent access to dmar_policy at this point. */
+		dmar_policy = DMAR_FORCE_ON;
+		no_iommu = 0;
+		pci_request_acs();
+		return;
+	}
+}
+
 int __init intel_iommu_init(void)
 {
 	int ret = -ENODEV;
@@ -2716,6 +2768,8 @@ int __init intel_iommu_init(void)
 		goto out_free_dmar;
 	}
 
+	liveupdate_force_iommu();
+
 	up_write(&dmar_global_lock);
 
 	/*
@@ -2797,7 +2851,8 @@ int __init intel_iommu_init(void)
 		 * to avoid unnecessary lock order splat.
 		 */
 		up_read(&dmar_global_lock);
-		iommu_device_register(&iommu->iommu, &intel_iommu_ops, NULL);
+		if (iommu_device_register(&iommu->iommu, &intel_iommu_ops, NULL))
+			intel_iommu_handle_drhd_restore_failure(iommu);
 		down_read(&dmar_global_lock);
 
 		iommu_pmu_register(iommu);
@@ -2808,7 +2863,12 @@ int __init intel_iommu_init(void)
 
 	/* Finally, we enable the DMA remapping hardware. */
 	for_each_iommu(iommu, drhd) {
-		if (!drhd->ignored && !translation_pre_enabled(iommu))
+		/*
+		 * The translation of a restored IOMMU was never disabled, so
+		 * don't touch its GCMD register.
+		 */
+		if (!drhd->ignored && !translation_pre_enabled(iommu) &&
+		    !iommu_get_restored_state(iommu->reg_phys, IOMMU_SER_TYPE_INTEL))
 			iommu_enable_translation(iommu);
 
 		iommu_disable_protect_mem_regions(iommu);
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 92697346c44b..633747672c22 100644
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
 void intel_iommu_shutdown_preserved(struct dmar_drhd_unit *drhd);
+void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
+					       struct iommu_hw_ser *iommu_ser);
+void intel_iommu_handle_drhd_restore_failure(struct intel_iommu *iommu);
 #else
 static inline void intel_iommu_shutdown_preserved(struct dmar_drhd_unit *drhd)
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
index c0c121bc3ea5..d43947879e78 100644
--- a/drivers/iommu/intel/liveupdate.c
+++ b/drivers/iommu/intel/liveupdate.c
@@ -304,6 +304,145 @@ static int preserve_iommu_context_tables(struct device_domain_info *info)
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
+	/* An out of range domain ID means the preserved state is corrupt. */
+	if (id < 0 || id >= iommu->max_domain_id)
+		return -EINVAL;
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
+	u64 rtaddr;
+	u32 gsts;
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
+	/*
+	 * The preserved devices are still translated by the hardware, so it
+	 * must be using the preserved root table.
+	 */
+	gsts = readl(iommu->reg + DMAR_GSTS_REG);
+	rtaddr = readq(iommu->reg + DMAR_RTADDR_REG);
+	if (!(gsts & DMA_GSTS_TES) ||
+	    (rtaddr & VTD_PAGE_MASK) != iommu_ser->intel.root_table ||
+	    !!(rtaddr & DMA_RTADDR_SMT) != !!iommu_ser->intel.sm_enabled)
+		panic("%s: hardware state does not match preserved state (GSTS 0x%x, RTADDR 0x%llx)\n",
+		      iommu->name, gsts, rtaddr);
+
+	iommu_restore_pages(iommu_ser->intel.root_table);
+	iommu->root_entry = phys_to_virt(iommu_ser->intel.root_table);
+
+	ret = restore_iommu_context(iommu, iommu_ser);
+	if (ret)
+		panic("%s: failed to restore preserved context tables\n",
+		      iommu->name);
+
+	ret = iommu_for_each_restored_device(_restore_used_domain_ids, iommu);
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
+	if (iommu_get_restored_state(iommu->reg_phys, IOMMU_SER_TYPE_INTEL))
+		panic("%s: failed to restore IOMMU with preserved state\n",
+		      iommu->name);
+}
+
 /**
  * intel_iommu_preserve_device() - Intel IOMMU callback to preserve device state
  * @dev: Target device
-- 
2.56.1.809.ga0b61035b5-goog

