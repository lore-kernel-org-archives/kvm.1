Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B21C37F740
	for <kvm@vger.kernel.org>; Sun, 14 Jun 2026 23:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781480255; cv=none; b=OSXlaLzojlmhaebmvfzz+ksZnKNJ2xdxVwhtWi1DgUmSDBE07weofQO5ZxeWsvIETExRsu8fgNRmXOrgJZ2ilr9IeQCFS0DjNd6VdtB/6dPRfX5rwrZIdSjsQeSc1AEoa+wNJmO2EwxpgI5h0kFpiHUpn4iO9C7fJH0fPL5oWig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781480255; c=relaxed/simple;
	bh=BpIhhfiTa1L80GZH2bbx6Z3ywDgPnkrHyacewiQZgVw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UD5axwX6n6+y7JU/Bi9I7aEBsOLJbOyvf36CGRDa5TmkpFlbZbqjGNCFXAJu3AI7YQCwOC0K3OZppuEqKfVCbbc71ZBYT6GE7HKD89ONDI/laB9aX0aaJis5sZD+aOVRgivr99+4pBzTea40BoqD6CUJLW/Mh+uqOF9hwYBTKAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uIMr+GYQ; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uIMr+GYQ"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8423efdbe6fso1704508b3a.0
        for <kvm@vger.kernel.org>; Sun, 14 Jun 2026 16:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781480253; x=1782085053; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K8RM2NmSnQNy/HhJEfxjb9CSOs49mgs2nXIoEoPVy4A=;
        b=uIMr+GYQEWREMJa3tI6CgjCT1I+vaXnpcbBYnLy0CGkNgDs7i0vY9CtmxrUzuINuuw
         ohsLscw1FdBnT4B+8YWM7/e+0gG8Ki1YAFqMpLWudQM7h9ANJ3hS1ag+h2Wf6NJwyZbc
         JGdSdysCJUoIz2tbosEHdcV4pj1yAlR6l4uTtfa4MAVjGzqrmHfZYgUEX3O4Io3oBp31
         BG/kHT0MjKX14DUCJ1HG/BOmnMsjlUiUDQI+A1eQI3pVbkEsrI1V6DHJl8IVznpyVR4/
         p9IFPpOqnc2HsbyPDqVVQCcYU+bXXiK7aXiV1d86hJcMJ9tUNpnhFqev7m1EKhwl8aKv
         MwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781480253; x=1782085053;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K8RM2NmSnQNy/HhJEfxjb9CSOs49mgs2nXIoEoPVy4A=;
        b=qU1rc9FP4+ZudMuylF2A8yhqr22XNRXr4aQl1lb6UjyQ6K+cK1CTBIFYE4DaYaKcdo
         O+L2fos9bjee9fYA83jwi2wNNSMIZPLfYtHEvfxUnNmm+TirR3ZNmNm/sTLxAL4D/uVH
         fM5k+4wueAI5pbgGdT+cEQkCCrsPbnLOqSiCBk1jF/CsOMQDMQpP4iBJPr9kjA2quFDw
         Rgx/sWciDnWiyQ8RhAf3m+NdMKfXaedm7nwXJOpfvGDGMAh5SAOJtdeGp+wtvw8WVBMc
         vu917BpNxhUCKEld/Igyj5HR8+2C7oZM+Nlk91691qSV90QQoytj02431wsZ6nP4Wq7C
         sLvQ==
X-Forwarded-Encrypted: i=1; AFNElJ907yOyiXiN7vQ4hfXxzQcGH4XBmjCq+Ky8vuJpufsdu1EisNCUrdbbLh3Grvez5wWzEic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+0oeNf16xgPKoj4pbVknFyVN/iarAGQS71Vrdh0pcW+0jTNY0
	oiIlwYEZppIfCVrlMyzjo8YApmspxdjw17y19eftCQ8xDjCmCBnJtYF6y62qfxAbc8E/+q/PPmh
	axoHL95SLU/qQwg==
X-Received: from pfez11.prod.google.com ([2002:aa7:888b:0:b0:844:e56c:ba8c])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1988:b0:842:650c:153e with SMTP id d2e1a72fcca58-8434ceddc3dmr12585535b3a.20.1781480252591;
 Sun, 14 Jun 2026 16:37:32 -0700 (PDT)
Date: Sun, 14 Jun 2026 23:37:14 +0000
In-Reply-To: <20260614233728.2212104-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260614233728.2212104-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260614233728.2212104-5-skhawaja@google.com>
Subject: [PATCH v3 04/18] iommupt: Implement preserve/unpreserve/restore callbacks
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

Add iommupt ops for presevation, unpresevation and restoration of iommu
page tables for liveupdate. Use the existing page walker to preserve the
ioptdesc of the top_table and the lower tables.

Preserve top_level, VASZ and FEAT Sign Extended to restore the domain in
the next kernel. On restore, the domain has only the preserved features
enabled and all the other features are zeroed. This is ok since the
restored domain is made immutable and can only be freed. A kunit test is
added to verify that the IOMMU domain free can be done with trimmed
features.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/generic_pt/iommu_pt.h       | 122 ++++++++++++++++++++++
 drivers/iommu/generic_pt/kunit_iommu_pt.h |  28 +++++
 include/linux/generic_pt/iommu.h          |  30 ++++++
 3 files changed, 180 insertions(+)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index 19b6daf88f2a..7759bbf12d10 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -16,6 +16,7 @@
 #include "../iommu-pages.h"
 #include <linux/cleanup.h>
 #include <linux/dma-mapping.h>
+#include <linux/iommu-liveupdate.h>
 
 enum {
 	SW_BIT_CACHE_FLUSH_DONE = 0,
@@ -961,6 +962,118 @@ static int NS(map_range)(struct pt_iommu *iommu_table, dma_addr_t iova,
 	return ret;
 }
 
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+static void NS(unpreserve)(struct pt_iommu *iommu_table, struct iommu_domain_ser *ser)
+{
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct pt_range range = pt_all_range(common);
+	struct pt_iommu_collect_args collect = {
+		.free_list = IOMMU_PAGES_LIST_INIT(collect.free_list),
+	};
+
+	iommu_pages_list_add(&collect.free_list, range.top_table);
+	pt_walk_range(&range, __collect_tables, &collect);
+
+	iommu_unpreserve_pages_list(&collect.free_list);
+}
+
+static int NS(preserve)(struct pt_iommu *iommu_table, struct iommu_domain_ser *ser)
+{
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
+	ret = iommu_preserve_pages_list(&collect.free_list);
+	if (ret)
+		return ret;
+
+	ser->top_table_phys = virt_to_phys(range.top_table);
+	ser->top_level = range.top_level;
+
+	/*
+	 * VASZ and SIGN_EXTEND will be needed in next kernel for collector page
+	 * table walk to restore and free pages.
+	 *
+	 * Use the max_vasz_lg2 from range, as that is the current one if
+	 * DYNAMIC_TOP is supported.
+	 */
+	ser->vasz = range.max_vasz_lg2;
+	ser->sign_extend = pt_feature(common, PT_FEAT_SIGN_EXTEND);
+
+	return 0;
+}
+
+static int __restore_tables(struct pt_range *range, void *arg,
+			    unsigned int level, struct pt_table_p *table)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	int ret;
+
+	for_each_pt_level_entry(&pts) {
+		if (pts.type == PT_ENTRY_TABLE) {
+			iommu_restore_pages(virt_to_phys(pts.table_lower));
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
+static int NS(restore)(struct pt_iommu *iommu_table, struct iommu_domain_ser *ser)
+{
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct pt_range range;
+
+	common->max_vasz_lg2 = ser->vasz;
+
+	/*
+	 * Restored page tables are strictly transient and only permitted to be
+	 * destroyed via deinit() op. Because we only preserve user-assigned
+	 * devices utilizing pass-through frameworks (VFIO / IOMMUFD), any
+	 * concurrent or subsequent map/unmap operations on a restored domain
+	 * are explicitly blocked at the subsystem boundary (e.g., via IOAS
+	 * immutability).
+	 */
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
+	iommu_restore_pages(ser->top_table_phys);
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
+#endif
+
 struct pt_unmap_args {
 	struct iommu_pages_list free_list;
 	pt_vaddr_t unmapped;
@@ -1136,6 +1249,15 @@ static const struct pt_iommu_ops NS(ops) = {
 #endif
 	.get_info = NS(get_info),
 	.deinit = NS(deinit),
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	.preserve = NS(preserve),
+	.unpreserve = NS(unpreserve),
+	.restore = NS(restore),
+#endif
+};
+
+static const struct pt_iommu_ops NS(ops_immutable) = {
+	.deinit = NS(deinit),
 };
 
 static int pt_init_common(struct pt_common *common)
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
index dd0edd02a48a..faa41d8032fe 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -13,6 +13,7 @@ struct iommu_iotlb_gather;
 struct pt_iommu_ops;
 struct pt_iommu_driver_ops;
 struct iommu_dirty_bitmap;
+struct iommu_domain_ser;
 
 /**
  * DOC: IOMMU Radix Page Table
@@ -166,6 +167,35 @@ struct pt_iommu_ops {
 	 * table from all HW access and all caches.
 	 */
 	void (*deinit)(struct pt_iommu *iommu_table);
+
+	/**
+	 * @preserve: Preserve the iommu page table for liveupdate
+	 * @iommu_table: Table to preserve
+	 * @ser: Serialization struct to fill with preserved state
+	 *
+	 * Preserve iommu page table and the relevant state for liveupdate. The
+	 * caller must make sure that the page table is not updated during and
+	 * after preservation.
+	 */
+	int (*preserve)(struct pt_iommu *iommu_table, struct iommu_domain_ser *ser);
+
+	/**
+	 * @unpreserve: Unpreserve the iommu page table
+	 * @iommu_table: Table to unpreserve
+	 * @ser: Serialization struct that contains preserved state
+	 */
+	void (*unpreserve)(struct pt_iommu *iommu_table, struct iommu_domain_ser *ser);
+
+	/**
+	 * @restore: Restore the iommu page table after liveupdate
+	 * @iommu_table: Table to restore the state into
+	 * @ser: Serialization struct that contains preserved state
+	 *
+	 * The iommu_table is back filled with the restored state that was
+	 * preserved in the serialization struct.
+	 */
+	int (*restore)(struct pt_iommu *iommu_table, struct iommu_domain_ser *ser);
+
 };
 
 /**
-- 
2.54.0.1136.gdb2ca164c4-goog

