Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283724;
	b=KdCXbPq7hkEiAZc9j4ASJgJaKvzfEjCoCP6Ouiwb7TnA8rNnOhUfYS0Bagzs2fRab1Gi
	 qdiy2eC//OhAJJMSnfpSu8qjsY9+XUjdmTlPZtkpLnNs9ybisHReSw6rWreKozN0OEED/
	 RV8pO/VJ/Dsugupbedjt9diFfbf0xOJ8gij6QJR1Sfzny9tn9En9HH4NSOF2MQfV5h0XT
	 PGJcjKqtrAO5uPptI5KqGmYhrg1uZWBiY5w0g4OB21yE0vIvckgzWZx6DdtrthdXy7n/u
	 z8nfU9rN10ulPuwuVHLFV6B0hevyoa4i8zxQ+H7edqh9EdxWFryDAOOYz2tw17eejpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283724;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=nI2Rle82Cu32iBDQQwdsnuZ3D0SzI6v5r4jQwcZSosk=;
	b=bVOusI7NzdDRhq9NLTsK833Idln0CK5izv9Uj00KcOd+JWB+t6jIqAfv9NlqVzg58uGa
	 2lHj34TchHJNXMyr4jLpG8rkb3Ve9i4VZGfRFIYiVqz6qd1cYamMs5gNFZ3ALfzubhA8N
	 UyC4fcv8fRt636opqZRkqgd7TS0G/NQvNPoEXaX0HAdBHg4WyS1vbmtbgQTqgHje0uxZd
	 lEYYmFc0JDYZOLPQzw1oAcTxZ0mnkzdNldsfbouh8jZTfqF53lgiRE75DtqrsCVp7cbat
	 pHmpm8nNczYzjWUY/mSggUyGAodvYYQuC56T5+Bz/m0OPpy7AZsup6IpWFRotCNe8kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EAizA7Y+;
	arc=none smtp.remote-ip=209.85.210.70
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E395606CF01
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 04:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E395606CF01
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EAizA7Y+
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-84fe2593525so2238458a34.3
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 20:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794283723; x=1794888523; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nI2Rle82Cu32iBDQQwdsnuZ3D0SzI6v5r4jQwcZSosk=;
        b=EAizA7Y+h2ddEhBEDXbZVjATF3DCqIgI0G2DbcotiwexTsdQaS9ABNyt7VzwCqRvGX
         6UiAuNo0C69RXaS+9IrHye0GoaG9BJcwWu+iV42VjCtI2QDHAeJw129PrSSTuLDzlgr7
         0k141w4eVGjq7lVBiufV68oPkF+2SfOKy9y3NVnR5tcKJx2PDAYPCa7dck96TCWPqz63
         TfHVi5fY39vxnUuw2FKZakMJ/Hgz8BlA91XoilDaP6ixL7inWhZva1wO29vX3MkB+5FD
         V3hx6vKzMeh0wdcOC/shqyckPjesaZi32o3gklvSMC0GM2WGutUbHtWW7bVmwOXja/J+
         ++7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794283723; x=1794888523;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nI2Rle82Cu32iBDQQwdsnuZ3D0SzI6v5r4jQwcZSosk=;
        b=oMtsji/GJ0vF1MEwnnbwTF4IFroulLyYlNP6X1gxiuMeHlUcg8Lsv5p+uQduS0o10N
         Z3AwTpOcKvw/FD1au6jDH+CM7XQXJD+snYI58SMGaPJdtmRaT3kszG4Xk3NpKCe4sFFQ
         D+HXy+eoENe+LXuBqKF7vc6Hw4rhwv+jG3di5B2ujRJ6sCeHeH+DX325A48KU9/F0mho
         WBoIG0nOrFwYYB0HcReezylJI8ArEZRKOP8LsAcITWICKOPW5oJ3wiDy49wDJkb1Rwdo
         lsvfRk4s/7USeEf9u5uBslCvQvaNpLWVqbMr5lzMa5McTlicTws9wGMr3AT1mG4U07Ss
         CdFA==
X-Forwarded-Encrypted: i=1; AL+hErHMSONg9KH58iUUkA71yoE0HbNYRkJ+CN6xEjEkJoPT5OD5cqcnjBCu123ieG/V4niOOGI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9oOz9LfQXNdWBvGVi3fJNSC+mh6qBPXGq2TYTX80j03h4W8zFJ
	fWRha1tWo0R4XWbQY+ZV/cth8oYAqLYek0mWt66I88w3tpusYVuIL2w+T+zZ0+3bMsX9/r5LCKn
	eQ56HJ2kDjMRGAg==
X-Received: from iox14.prod.google.com ([2002:a05:6602:490e:b0:9c4:b9d9:b8b3])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:f0b:b0:4e7:8f9b:1185 with SMTP id 5614622812f47-5683c9e18cbmr1454073b6e.3.1794283722934;
 Mon, 09 Nov 2026 20:08:42 -0800 (PST)
Date: Tue, 10 Nov 2026 04:08:16 +0000
In-Reply-To: <20261110040828.1774343-1-skhawaja@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110040828.1774343-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110040828.1774343-11-skhawaja@google.com>
Subject: [PATCH v7 10/18] iommu/vt-d: Restore IOMMU state and reclaimed domain ids
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
 drivers/iommu/intel/iommu.c      |  57 ++++++++++---
 drivers/iommu/intel/iommu.h      |  14 ++++
 drivers/iommu/intel/liveupdate.c | 139 +++++++++++++++++++++++++++++++
 3 files changed, 197 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 6c86c155d12b..a83971368bef 100644
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
@@ -2797,7 +2822,8 @@ int __init intel_iommu_init(void)
 		 * to avoid unnecessary lock order splat.
 		 */
 		up_read(&dmar_global_lock);
-		iommu_device_register(&iommu->iommu, &intel_iommu_ops, NULL);
+		if (iommu_device_register(&iommu->iommu, &intel_iommu_ops, NULL))
+			intel_iommu_handle_drhd_restore_failure(iommu);
 		down_read(&dmar_global_lock);
 
 		iommu_pmu_register(iommu);
@@ -2808,7 +2834,12 @@ int __init intel_iommu_init(void)
 
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
2.56.0.506.g506a7eabc5-goog

