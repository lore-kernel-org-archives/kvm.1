Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792894785;
	b=lZvqElfdAJGf3I+0NP79LZZXBAHEkXDjzuo74CrIgK4ShwGqfbK5tZOzB5y6sMi9tpXI
	 yDKdE4/qP+44JEfifx3224evsghCsoZhchj8OVy2G1KxSkvfg6AafBXpsI8PY2Lqm+J/f
	 57HQK2CFHInYNgIw1VHpeRd9odkpIYsDdV2eRJsyDRoXy5fz0CT6lcF3UrCUud1vAewIj
	 AEfghVGdglxRiSmtAWjU/8949Vbc9EE5Zw/0UpEimPvMxyfv+WxYetZ1YPamMZCWmHmUl
	 eAXLQ23eIiUM04ToEnyeDemC01K0NL5STxswS2R0+Trd1I2mwJ/Pvx641bQCUxwNZ/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792894785;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=zmn2qFrznCocuz8YObSy+9ENkeuL7HIkttyD64ro7B0=;
	b=ZS5t5dipjLRDaJRD6vOJh+OY86RXR3MR53IPDQR7MmZQ0T5tq1xr5xIxrxFZd3donbkZ
	 lOA9q7GrdmjNXYtu09G/dAZBFYT1ic2SXE3aYqAsB8pGCbV8Nq+WGuLI2dhIZnR0KdYzx
	 1Ab6uvpsAFuseJggUpEWQ9mxp14Ue785IDwo9UOF1Ky7Jshuq+3tnu6ObRz0RM7TBpy/x
	 tUP7wMN7pC1/AFRdErtJimBOYdP8O9hth4+rwSpCVwqk7+gkh4+PXxhMel+45b/HcV9C+
	 bvm3+FFEDQVgKYd6Rmd6kSUEdCWzRQJHSzmH48o3kbjduvV5z1IS7Pi3QP+ouThP4qQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=B3sddiTq;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4956760A6F61
	for <kvm@vger.kernel.org>; Sun, 25 Oct 2026 02:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4956760A6F61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=B3sddiTq
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e9821ca96fso22986425ad.0
        for <kvm@vger.kernel.org>; Sat, 24 Oct 2026 19:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792894784; x=1793499584; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zmn2qFrznCocuz8YObSy+9ENkeuL7HIkttyD64ro7B0=;
        b=B3sddiTqzQd64LVsABh8kHkMOvuneItV9GFNootyJO4H5NFpJYsvSRiC60xxcW1nNq
         7CSAV1BA7917nahx14uMY+lE2VWKAELsU9MIaKzK0ikYZw4fC6tB94p4GUWUDyhq3sxU
         dD9Ar8VG2iOfuHwvBttNGWzvrxCLgZuy5gxAGDlIAZC0vodftRHZi9jagMf88b0qg0iE
         80voV1U9UNSu0QGd4Bc5VmJRfw7dXf29uGaL0tREWIrP8/4g5+wf8rA9KtkOs8lEHKHY
         ryUYiyTTTKgNUhu6L/T0V4beGrPotVJawLsN3ygrJ9yJV3E1cLkBMcCFU0j7TPVqpIEB
         0kvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792894784; x=1793499584;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zmn2qFrznCocuz8YObSy+9ENkeuL7HIkttyD64ro7B0=;
        b=PENraXi2W1ij029eBAjEG30EzNv43pQlL78xKefzqVb5sFPFOA7kkt8+YsVwqf3yYW
         PU+ALLsYyWLNvie6lz65sw9UgZf56HcXZ6U1fHE1Srz1dGa/7WROfF6WdUZ3fviYR99j
         WWavUBie3oDFlzxqqOZYz++xQVTqiHFAu3IwGD5Lhh/sOjxYUjX/CQQ66TgEFelyS6Ff
         UZ2/nAKWYOFeeAZAgEwM+GZHkjh+lUducJ+KXAlAVJ2XqLHPnOOBvtan0uKFyCd1ZQVc
         05Au1uZHttQ66k56ZKdvc0oK+tfKK8ROSnyl8JL78rLSYmXfFFht8nYZuHI9pIddNls/
         xI4Q==
X-Forwarded-Encrypted: i=1; AKwUvBzTwsBGv7xIVW5cztqI7i5IlT9JNOp/JoGwUaxDsko4WqbiBIFFFIj2T0kGoi4squML9fo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIuyIGb3tpF2ccd/AgKWTuhHjeo05MRPsVzNTVigAdaULNi8Wim
	AvgbiQABaZPEul0cl+L0t1mhN9s6SWGhB/1qybgn7uAz/szoDe/lT+103VXsv/niHCuHwmIT8Q9
	JJPWKfArJLXen7A==
X-Received: from pgbj3-n2.prod.google.com ([2002:a05:6a02:61c3:20b0:cd6:db2:b293])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3dd0:b0:3ac:9c37:942e with SMTP id 98e67ed59e1d1-3adead50095mr3154325a91.49.1792894783505;
 Sat, 24 Oct 2026 19:19:43 -0700 (PDT)
Date: Sun, 25 Oct 2026 02:19:18 +0000
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
Message-ID: <20261025021930.674647-8-skhawaja@google.com>
Subject: [PATCH v6 07/18] iommu/vt-d: Clear unpreserved context entries during shutdown
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

During normal shutdown the iommu translation is disabled. Since the root
table is preserved during live update, it needs to be cleaned up and the
context entries of the unpreserved devices and root entries for the
unpreserved context tables need to be cleared.

This is required because during kexec reboot and shutdown the devices do
not go through the release flow, so there might be stale entries in the
root table and context tables. Also note that new unpreserved context
tables for unpreserved devices might have been added after preservation,
so the root table entries for unpreserved context tables also need to
removed.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/intel/iommu.c      |  15 +++-
 drivers/iommu/intel/iommu.h      |   5 ++
 drivers/iommu/intel/liveupdate.c | 134 +++++++++++++++++++++++++++++++
 3 files changed, 152 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 14bd1ca4fbd5..23a1da351ddf 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1967,6 +1967,14 @@ static int iommu_suspend(void *data)
 
 	iommu_flush_all();
 
+	/*
+	 * Note that IOMMU suspend doesn't affect live update. The state
+	 * preserved during live update is not released and remains valid during
+	 * suspend and reused during IOMMU resume.
+	 *
+	 * Also note deployment of suspend/resume and live updated use case
+	 * should be mostly mutually exclusive.
+	 */
 	for_each_active_iommu(iommu, drhd) {
 		iommu_disable_translation(iommu);
 
@@ -2512,8 +2520,11 @@ void intel_iommu_shutdown(void)
 		/* Disable PMRs explicitly here. */
 		iommu_disable_protect_mem_regions(iommu);
 
-		/* Make sure the IOMMUs are switched off */
-		iommu_disable_translation(iommu);
+		/* Make sure the IOMMUs are switched off if not preserved. */
+		if (iommu_preserved_state(&iommu->iommu))
+			clear_unpreserved_context_entries(iommu);
+		else
+			iommu_disable_translation(iommu);
 	}
 }
 
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index a6c0ed55db30..16ab103d308a 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1316,6 +1316,11 @@ int intel_iommu_preserve(struct iommu_device *iommu,
 			 struct iommu_hw_ser *iommu_ser);
 void intel_iommu_unpreserve(struct iommu_device *iommu,
 			    struct iommu_hw_ser *iommu_ser);
+void clear_unpreserved_context_entries(struct intel_iommu *iommu);
+#else
+static inline void clear_unpreserved_context_entries(struct intel_iommu *iommu)
+{
+}
 #endif
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
index 0047f9d92cbc..f92cb774cc99 100644
--- a/drivers/iommu/intel/liveupdate.c
+++ b/drivers/iommu/intel/liveupdate.c
@@ -82,6 +82,140 @@ static int preserve_context_table(struct intel_iommu *iommu,
 	return 0;
 }
 
+static void clear_unpreserved_context_root_entries(struct intel_iommu *iommu,
+						   struct iommu_hw_ser *ser)
+{
+	struct root_entry *root;
+	int i;
+
+	/*
+	 * Individual invalidations for each context table removal are not
+	 * needed as we issue global invalidations later.
+	 */
+	for (i = 0; i < ROOT_ENTRY_NR; i++) {
+		root = &iommu->root_entry[i];
+
+		if (!is_context_table_preserved(iommu, ser, i, 0) && (root->lo & 1)) {
+			root->lo = 0;
+			__iommu_flush_cache(iommu,
+					    &root->lo,
+					    sizeof(root->lo));
+		}
+
+		if (!sm_supported(iommu))
+			continue;
+
+		if (!is_context_table_preserved(iommu, ser, i, 0x80) && (root->hi & 1)) {
+			root->hi = 0;
+			__iommu_flush_cache(iommu,
+					    &root->hi,
+					    sizeof(root->hi));
+		}
+	}
+}
+
+static void clear_unpreserved_context(struct device_domain_info *info, u8 bus, u8 devfn)
+{
+	struct context_entry *context;
+
+	/*
+	 * This cleanup is done during shutdown, so it should be fine to only
+	 * clear the entries here and issue one global invalidation later to
+	 * invalidate all cleared entries.
+	 *
+	 * Note that the device IOTLB invalidation for unpreserved devices is
+	 * skipped this way. This matches the normal kexec reboot, where the
+	 * IOMMU translation is disabled without invalidating the device IOTLBs,
+	 * and the unpreserved devices go through the same flow in the next
+	 * kernel as they do after a normal kexec reboot. Issuing device IOTLB
+	 * invalidations this late during shutdown could also cause invalidation
+	 * timeouts, as drivers might have moved devices to a low power state,
+	 * and would add to the shutdown time.
+	 *
+	 * The iommu lock is not needed as the context tables are never removed
+	 * and the new ones are not added during shutdown.
+	 */
+	context = iommu_context_addr(info->iommu, bus, devfn, 0);
+	if (context) {
+		/*
+		 * Individual invalidations are not needed as we issue global
+		 * invalidations later once all the cleanups are done.
+		 */
+		context_clear_present(context);
+		__iommu_flush_cache(info->iommu, context, sizeof(*context));
+		context_clear_entry(context);
+		__iommu_flush_cache(info->iommu, context, sizeof(*context));
+	}
+}
+
+static int clear_unpreserved_alias_cb(struct pci_dev *pdev, u16 alias, void *data)
+{
+	struct device_domain_info *info = data;
+
+	clear_unpreserved_context(info, PCI_BUS_NUM(alias), alias & 0xff);
+	return 0;
+}
+
+static int clear_unpreserve_context_entry_fn(struct device *dev,
+					     struct iommu_device *iommu_dev)
+{
+	struct device_domain_info *info;
+
+	info = dev_iommu_priv_get(dev);
+	if (!info)
+		return 0;
+
+	if (dev_iommu_preserved_state(dev))
+		return 0;
+
+	if (dev_is_pci(dev))
+		pci_for_each_dma_alias(to_pci_dev(dev),
+				       clear_unpreserved_alias_cb, info);
+	else
+		clear_unpreserved_context(info, info->bus, info->devfn);
+
+	return 0;
+}
+
+/**
+ * clear_unpreserved_context_entries() - Clear context entries for unpreserved devices
+ * @iommu: Target IOMMU
+ *
+ * Clear the context entries of unpreserved devices during shutdown before kexec.
+ */
+void clear_unpreserved_context_entries(struct intel_iommu *iommu)
+{
+	/*
+	 * Clear context entries for unpreserved devices because during kexec
+	 * reboot and shutdown the devices do not go through the release flow,
+	 * so there might be stale entries in the root table and context tables.
+	 *
+	 * Note that the error can be ignored as the iterator function does not
+	 * fail.
+	 */
+	iommu_for_each_dev(&iommu->iommu, clear_unpreserve_context_entry_fn);
+
+	/*
+	 * New unpreserved context tables for unpreserved devices might have
+	 * been added after preservation, so the root table entries for
+	 * unpreserved context tables need to be removed.
+	 */
+	clear_unpreserved_context_root_entries(iommu,
+					       iommu_preserved_state(&iommu->iommu));
+
+	/*
+	 * Some devices might not have teardown/detached properly depending on
+	 * whether a proper device remove is done before kexec is triggered.
+	 * Also unpreserved context tables and entries are removed during
+	 * shutdown. So issue global invalidations to remove references to
+	 * unpreserved tables and entries.
+	 */
+	iommu->flush.flush_context(iommu, 0, 0, 0, DMA_CCMD_GLOBAL_INVL);
+	if (sm_supported(iommu))
+		qi_flush_pasid_cache(iommu, 0, QI_PC_GLOBAL, 0);
+	iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
+}
+
 static void unpreserve_iommu_context_tables(struct intel_iommu *iommu,
 					    struct iommu_hw_ser *ser)
 {
-- 
2.56.0.257.gf7497c7d27-goog

