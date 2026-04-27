Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7336D3E7173
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 17:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777312608; cv=none; b=PtXFwvnEJrTBNuNGgZqwlM6N3b/gYych+CtUq2HFRNRNboUBFIFcBXXghrEeoAMqOmRDyQaqAnGEv2UssQnLibxShyDnjL69pnNeAVd578Qu5H01EDUJJv8eWAvBmFNIMgr9GCU0eNg/TvX+O847LW+VLqkjQ/WBbw3rBArZOog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777312608; c=relaxed/simple;
	bh=B237X4ceXx2uWX7z1Abu92DZoAQa1zwNFSeuDNq/90k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hDuRtlpEO164P44yMC50n3OmUe7DrT5z3Li5iKTt0Kt3y/tPelGWCsG4UnjXCKnbVqnxDsbDbQprPt1XS5BzdvOyE/F187KpusdK7EZ2+Qdd6kAExrHIB3/3Mz2PzelfQmr8zK4jnzmd7g/WCT+MmZGLCCG5tvgjLibvapRHwYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ivvZ/7bg; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ivvZ/7bg"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f6b0a7164so13876212b3a.0
        for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 10:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777312606; x=1777917406; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=50UziSPRuCs10QZUQrlvS9tTBGHTIFtncRl3OEvLxc8=;
        b=ivvZ/7bg1lPL4wMG2zBsSFfA5caZP19oWfvQf+GNZ/ZBbfLImfa7QI9LJnvn+N8IXH
         KkO+JQGN4GRqk+N4SD1vgQVrL245+eWgzUos2ucn+VVFvHisFLHOnkG5uV1lyWL/fJ9i
         YS5yj2dbjwrCoy+Q74uqmH+1mXeiVfPgeWiI/q2kBavDKHoQjuqc7A2mErXyE2p9hIUm
         +lREP5xGexGc8Z/8/BuPILPmJy2UMnRzvtmZWg34ZmXqC2eP3Zv1fCCfwLNlU3IHwSzV
         lanzlVAKAuxFdpgiJc/CHiDTUqHj8/3dGcfRmUGx5TNJ6S9GROjfu02KryOeMXIKRE+v
         p07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777312606; x=1777917406;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=50UziSPRuCs10QZUQrlvS9tTBGHTIFtncRl3OEvLxc8=;
        b=BownZ2ZHeNbmlojaogPHugaKsdqXQ4HEuH9oGH4NZn3uFGltHjQsNSwRh6FbssXD10
         +6te/SqeZxvxncQu/ejSLsk2L7QBZKCX7CTnexCthZYn98KualLZn/K0JRWFhOJNhclq
         6/AXYM+4fpmsulK60m0/04U1gPscazra4X33YhLdlc3y76MX9Vo1WqXx6eDhZ1eMqjBW
         9da0ADLyT0+wapRgmudAwF+2TV/eX2XS6G2aZ3Jd+W+Oop0K+1NtRSGIbHhpm0wBj7pm
         WaMh8DkpCSxczHnVoXaqtrXrexddybEHa0qKcyZUVKia24jBweqZnKft8JI/stOIHaun
         rr3g==
X-Forwarded-Encrypted: i=1; AFNElJ8NgUT3oMsPEhHyMKUHvl3XvRgnjqD3SGpbg/mqv3SZpo5RViAAM2sMgcAuPW2blm0KuxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzAYJDzNjanhHPzkIJKqiJr3kxFiBBgEf/nOy582jMqLNzbTxG
	5M3+GH7WUlNrroKc32WsGOnHLxx2DpKJfLrGZj/06qkjM5gJU4UK8npmz1xDlBM8meWR2whbIrq
	lBKII+Pt3Mdf8Rg==
X-Received: from pfbhg9.prod.google.com ([2002:a05:6a00:8609:b0:82f:45dd:8c90])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:88c8:0:b0:82c:9223:cc95 with SMTP id d2e1a72fcca58-834dc1809d9mr43552b3a.1.1777312605633;
 Mon, 27 Apr 2026 10:56:45 -0700 (PDT)
Date: Mon, 27 Apr 2026 17:56:23 +0000
In-Reply-To: <20260427175633.1978233-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260427175633.1978233-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260427175633.1978233-7-skhawaja@google.com>
Subject: [PATCH v2 06/16] iommupt: Implement preserve/unpreserve/restore callbacks
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

Implement the iommu domain ops for presevation, unpresevation and
restoration of iommu domains for liveupdate. Use the existing page
walker to preserve the ioptdesc of the top_table and the lower tables.

Preserve top_level, VASZ and FEAT Sign Extended to restore the domain in
the next kernel. On restore the domain has only the preserved features
enabled and all the other features are zeroed. This is ok since the
restored domain is made immutable and can only be freed. A kunit test is
added to verify that the IOMMU domain free can be done with trimmed
features.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/generic_pt/iommu_pt.h       | 131 ++++++++++++++++++++++
 drivers/iommu/generic_pt/kunit_iommu_pt.h |  28 +++++
 include/linux/generic_pt/iommu.h          |  19 +++-
 3 files changed, 177 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index 19b6daf88f2a..7bca827e3a55 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -961,6 +961,133 @@ static int NS(map_range)(struct pt_iommu *iommu_table, dma_addr_t iova,
 	return ret;
 }
 
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+/**
+ * unpreserve() - Unpreserve page tables and other state of a domain.
+ * @domain: Domain to unpreserve
+ */
+void DOMAIN_NS(unpreserve)(struct iommu_domain *domain, struct iommu_domain_ser *ser)
+{
+	struct pt_iommu *iommu_table =
+		container_of(domain, struct pt_iommu, domain);
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct pt_range range = pt_all_range(common);
+	struct pt_iommu_collect_args collect = {
+		.free_list = IOMMU_PAGES_LIST_INIT(collect.free_list),
+	};
+
+	iommu_pages_list_add(&collect.free_list, range.top_table);
+	pt_walk_range(&range, __collect_tables, &collect);
+
+	iommu_unpreserve_pages(&collect.free_list);
+}
+EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(unpreserve), "GENERIC_PT_IOMMU");
+
+/**
+ * preserve() - Preserve page tables and other state of a domain.
+ * @domain: Domain to preserve
+ *
+ * Returns: -ERRNO on failure, 0 on success.
+ */
+int DOMAIN_NS(preserve)(struct iommu_domain *domain, struct iommu_domain_ser *ser)
+{
+	struct pt_iommu *iommu_table =
+		container_of(domain, struct pt_iommu, domain);
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct pt_range range = pt_all_range(common);
+	struct pt_iommu_collect_args collect = {
+		.free_list = IOMMU_PAGES_LIST_INIT(collect.free_list),
+	};
+	int ret;
+
+	iommu_pages_list_add(&collect.free_list, range.top_table);
+	pt_walk_range(&range, __collect_tables, &collect);
+
+	ret = iommu_preserve_pages(&collect.free_list);
+	if (ret)
+		return ret;
+
+	ser->top_table_phys = virt_to_phys(range.top_table);
+	ser->top_level = range.top_level;
+
+	/*
+	 * VASZ and SIGN_EXTEND will be needed in next kernel for collector page
+	 * table walk to restore and free pages.
+	 */
+	ser->vasz = common->max_vasz_lg2;
+	ser->sign_extend = pt_feature(common, PT_FEAT_SIGN_EXTEND);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(preserve), "GENERIC_PT_IOMMU");
+
+static int __restore_tables(struct pt_range *range, void *arg,
+			    unsigned int level, struct pt_table_p *table)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	int ret;
+
+	for_each_pt_level_entry(&pts) {
+		if (pts.type == PT_ENTRY_TABLE) {
+			iommu_restore_page(virt_to_phys(pts.table_lower));
+
+			/*
+			 * pt_descend can only fail if pts.table_lower is not
+			 * init. So the if statement below is dead code.
+			 */
+			ret = pt_descend(&pts, arg, __restore_tables);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static const struct pt_iommu_ops NS(ops_immutable);
+
+/**
+ * restore() - Restore page tables and other state of a domain.
+ * @domain: Domain to preserve
+ *
+ * Returns: -ERRNO on failure, 0 on success.
+ */
+int DOMAIN_NS(restore)(struct iommu_domain *domain, struct iommu_domain_ser *ser)
+{
+	struct pt_iommu *iommu_table =
+		container_of(domain, struct pt_iommu, domain);
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct pt_range range;
+
+	common->max_vasz_lg2 = ser->vasz;
+
+	/* Make this domain immutable.*/
+	iommu_table->ops = &NS(ops_immutable);
+
+	/*
+	 * It is safe to override this here since this domain is immutable and
+	 * can only be freed.
+	 */
+	common->features = 0;
+	if (ser->sign_extend)
+		common->features |= BIT(PT_FEAT_SIGN_EXTEND);
+
+	range = pt_all_range(common);
+	iommu_restore_page(ser->top_table_phys);
+
+	/* Free new table */
+	iommu_free_pages(range.top_table);
+
+	/* Set the restored top table */
+	pt_top_set(common, phys_to_virt(ser->top_table_phys), ser->top_level);
+
+	/* Restore all pages*/
+	range = pt_all_range(common);
+	return pt_walk_range(&range, __restore_tables, NULL);
+}
+EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(restore), "GENERIC_PT_IOMMU");
+#endif
+
 struct pt_unmap_args {
 	struct iommu_pages_list free_list;
 	pt_vaddr_t unmapped;
@@ -1138,6 +1265,10 @@ static const struct pt_iommu_ops NS(ops) = {
 	.deinit = NS(deinit),
 };
 
+static const struct pt_iommu_ops NS(ops_immutable) = {
+	.deinit = NS(deinit),
+};
+
 static int pt_init_common(struct pt_common *common)
 {
 	struct pt_range top_range = pt_top_range(common);
diff --git a/drivers/iommu/generic_pt/kunit_iommu_pt.h b/drivers/iommu/generic_pt/kunit_iommu_pt.h
index e8a63c8ea850..af1918d693ed 100644
--- a/drivers/iommu/generic_pt/kunit_iommu_pt.h
+++ b/drivers/iommu/generic_pt/kunit_iommu_pt.h
@@ -426,6 +426,33 @@ static void test_mixed(struct kunit *test)
 	check_iova(test, start, oa, len);
 }
 
+static void test_restore_free(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	struct pt_range top_range = pt_top_range(priv->common);
+	u64 start = 0x3fe400ULL << 12;
+	u64 end = 0x4c0600ULL << 12;
+	pt_vaddr_t len = end - start;
+
+	if (top_range.last_va <= start || sizeof(unsigned long) == 4)
+		kunit_skip(test, "range is too small");
+	if ((priv->safe_pgsize_bitmap & GENMASK(30, 21)) != (BIT(30) | BIT(21)))
+		kunit_skip(test, "incompatible psize");
+
+	/* Map a large mixed range to populate multiple levels of page tables */
+	do_map(test, start, start, len);
+
+	/*
+	 * Simulate a restored state by clearing all features except
+	 * SIGN_EXTEND. This verifies that the generic page table free walker
+	 * can correctly tear down a populated domain when other features are
+	 * zeroed.
+	 */
+	priv->common->features &= BIT(PT_FEAT_SIGN_EXTEND);
+
+	/* The domain will be freed when the test exits. */
+}
+
 static struct kunit_case iommu_test_cases[] = {
 	KUNIT_CASE_FMT(test_increase_level),
 	KUNIT_CASE_FMT(test_map_simple),
@@ -434,6 +461,7 @@ static struct kunit_case iommu_test_cases[] = {
 	KUNIT_CASE_FMT(test_random_map),
 	KUNIT_CASE_FMT(test_pgsize_boundary),
 	KUNIT_CASE_FMT(test_mixed),
+	KUNIT_CASE_FMT(test_restore_free),
 	{},
 };
 
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index dd0edd02a48a..649b3b9eb1a0 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -13,6 +13,7 @@ struct iommu_iotlb_gather;
 struct pt_iommu_ops;
 struct pt_iommu_driver_ops;
 struct iommu_dirty_bitmap;
+struct iommu_domain_ser;
 
 /**
  * DOC: IOMMU Radix Page Table
@@ -251,6 +252,12 @@ struct pt_iommu_cfg {
 #define IOMMU_PROTOTYPES(fmt)                                                  \
 	phys_addr_t pt_iommu_##fmt##_iova_to_phys(struct iommu_domain *domain, \
 						  dma_addr_t iova);            \
+	int pt_iommu_##fmt##_preserve(struct iommu_domain *domain,             \
+				      struct iommu_domain_ser *ser);           \
+	void pt_iommu_##fmt##_unpreserve(struct iommu_domain *domain,          \
+					 struct iommu_domain_ser *ser);        \
+	int pt_iommu_##fmt##_restore(struct iommu_domain *domain,              \
+				     struct iommu_domain_ser *ser);            \
 	int pt_iommu_##fmt##_read_and_clear_dirty(                             \
 		struct iommu_domain *domain, unsigned long iova, size_t size,  \
 		unsigned long flags, struct iommu_dirty_bitmap *dirty);        \
@@ -266,12 +273,22 @@ struct pt_iommu_cfg {
 	};                              \
 	IOMMU_PROTOTYPES(fmt)
 
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+#define IOMMU_PT_LIVEUPDATE_OPS(fmt)			\
+	, .preserve = &pt_iommu_##fmt##_preserve,	\
+	.unpreserve = &pt_iommu_##fmt##_unpreserve,	\
+	.restore = &pt_iommu_##fmt##_restore
+#else
+#define IOMMU_PT_LIVEUPDATE_OPS(fmt)
+#endif
+
 /*
  * A driver uses IOMMU_PT_DOMAIN_OPS to populate the iommu_domain_ops for the
  * iommu_pt
  */
 #define IOMMU_PT_DOMAIN_OPS(fmt)                        \
-	.iova_to_phys = &pt_iommu_##fmt##_iova_to_phys
+	.iova_to_phys = &pt_iommu_##fmt##_iova_to_phys	\
+	IOMMU_PT_LIVEUPDATE_OPS(fmt)
 #define IOMMU_PT_DIRTY_OPS(fmt) \
 	.read_and_clear_dirty = &pt_iommu_##fmt##_read_and_clear_dirty
 
-- 
2.54.0.545.g6539524ca2-goog

