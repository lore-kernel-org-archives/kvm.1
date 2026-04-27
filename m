Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C763E9588
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 17:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777312607; cv=none; b=oWcu3KmxSVHfmSGG4Jt37i1tZXQY2VRx04ukKPbLXdIY64IbTILCUU5Rz+mEM0goYHMTR1ESFwJ/5GVChks6FUk1aCyHhpEvOuxlK8BJ2hmOmajJ0YSdWQ2MQlPa+4mgXRO6iG/39XPs2XKxl6BcYm0S6v03O9SQRGV5yWUAD1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777312607; c=relaxed/simple;
	bh=ATCarjiEqzHx7LDveLm2yBVp2zFHpaNFt5llkjd3Ckg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qJUXwsU9qBMg/tXKXprXZhcmifjgnWhgwxPcQQJCpnpDB5n3kwokRGi+2RhFcNR2QN30dfK+DazUOFwaA3U5Chjub0VyyQ8wMPqLnAr1LInkCYYCtTX8jAM77fwMJnkAtlSAK1B4f5RwDO3uIl7GB7fxortUB+beRrJDdQ28gcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pSzpLXGR; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pSzpLXGR"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f504f6b75so5831330b3a.1
        for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 10:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777312604; x=1777917404; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i7gYeH/lHe4hDFDlIxOksTDFIFSqb1DPwjKnJo7j/DQ=;
        b=pSzpLXGR7jqWlKXk0RKNEKg9DrwBwV0nIozUcbtUXLcAIY6LEzMww5SBSdXRuhNdMq
         OUM5zFH85Grn8KjVgMrnqXMXLQAnz8j7pglvmsdz1trQytMywvElhBh088tiElSjw1F6
         nVVEMYZpkOOnXeIp26wSA7w5Axu6r4klJr531+++Zb7bYJ+yf/TyEYY2Bd3+jwBFlSYQ
         qK95GzoOnJR0q3JI7ZwrJq+I5Qo7/SmL/2oxpM1EDec5+8VCXgx7zHYNmEsyLZDSCtHj
         A+w48HpKODOhPrkYAaTxACpG4lccHMOsvIITTg9oWOVYywjHYDlIEMP/99Am+LG2n/s/
         A4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777312604; x=1777917404;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i7gYeH/lHe4hDFDlIxOksTDFIFSqb1DPwjKnJo7j/DQ=;
        b=OzhwXb8MOtNBKRtjaTNDqX68tymrzVpCkmKqvPZBzrVemXeBtl5V+299Fzgmaegorh
         uxQ1gN72n7he6nqezCKKZqCFPgUJcEeKqTOZapFMSldRND2xpgJZFrOaidfHmp531MTq
         MKlNFWxWLKGFXGOGTdH5Dh7DG8k+AAYsbGUkBNafiDHt+HrufXHq3hJSyaRVIJU7JAcu
         Du2GpkrZ7ApZRadqHpQl7X44Ia53W/4JlesspSeXt3H4Lo3leooiTo6rqZIVzU4Eg+EK
         qeoWGiGdbDCPNabEuX9ix2oqgbEwqL9O6vD9P+cbUH2IBw14Vcrro1DbVrhcF3lxYqSZ
         Qcgw==
X-Forwarded-Encrypted: i=1; AFNElJ+BD3NqKIkn3FMtEKdyvVSZq+gtsU0Lc2WNVp8Piv1B5Muu1OgzY+aSWTWxu+4g3GEc1Ik=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaWBz9FWTsJTezw6oqeQ3GSCtzNNUxelWMpfUZnOwdz0ek+1XM
	XP1QZzs8mPOIl8UuMPsQtEINZg9J2+u9fw3ois/Q2yLUSbxo204603MN+NRW3KJjZgcRRh7OZAb
	6o+wiKX0B21LnZA==
X-Received: from pfod24.prod.google.com ([2002:aa7:8698:0:b0:82f:b853:3ba7])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:12c1:b0:82f:44dc:f85c with SMTP id d2e1a72fcca58-834dc2c1cf1mr8043b3a.34.1777312603915;
 Mon, 27 Apr 2026 10:56:43 -0700 (PDT)
Date: Mon, 27 Apr 2026 17:56:22 +0000
In-Reply-To: <20260427175633.1978233-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260427175633.1978233-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260427175633.1978233-6-skhawaja@google.com>
Subject: [PATCH v2 05/16] iommu/pages: Add APIs to preserve/unpreserve/restore
 iommu pages
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

IOMMU pages are allocated/freed using APIs using struct ioptdesc. For
the proper preservation and restoration of ioptdesc add helper
functions.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/iommu-pages.c | 108 ++++++++++++++++++++++++++++++++++--
 drivers/iommu/iommu-pages.h |  30 ++++++++++
 2 files changed, 134 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu-pages.c b/drivers/iommu/iommu-pages.c
index 3bab175d8557..b1ffeb930e6d 100644
--- a/drivers/iommu/iommu-pages.c
+++ b/drivers/iommu/iommu-pages.c
@@ -6,6 +6,7 @@
 #include "iommu-pages.h"
 #include <linux/dma-mapping.h>
 #include <linux/gfp.h>
+#include <linux/kexec_handover.h>
 #include <linux/mm.h>
 
 #define IOPTDESC_MATCH(pg_elm, elm)                    \
@@ -28,6 +29,13 @@ static inline size_t ioptdesc_mem_size(struct ioptdesc *desc)
 	return 1UL << (folio_order(ioptdesc_folio(desc)) + PAGE_SHIFT);
 }
 
+static inline void iommu_folio_update_stats(struct folio *folio,
+					    unsigned long nr_pages)
+{
+	mod_node_page_state(folio_pgdat(folio), NR_IOMMU_PAGES, nr_pages);
+	lruvec_stat_mod_folio(folio, NR_SECONDARY_PAGETABLE, nr_pages);
+}
+
 /**
  * iommu_alloc_pages_node_sz - Allocate a zeroed page of a given size from
  *                             specific NUMA node
@@ -80,8 +88,7 @@ void *iommu_alloc_pages_node_sz(int nid, gfp_t gfp, size_t size)
 	 * rather large, i.e. multiple gigabytes in size.
 	 */
 	pgcnt = 1UL << order;
-	mod_node_page_state(folio_pgdat(folio), NR_IOMMU_PAGES, pgcnt);
-	lruvec_stat_mod_folio(folio, NR_SECONDARY_PAGETABLE, pgcnt);
+	iommu_folio_update_stats(folio, pgcnt);
 
 	return folio_address(folio);
 }
@@ -95,8 +102,7 @@ static void __iommu_free_desc(struct ioptdesc *iopt)
 	if (IOMMU_PAGES_USE_DMA_API)
 		WARN_ON_ONCE(iopt->incoherent);
 
-	mod_node_page_state(folio_pgdat(folio), NR_IOMMU_PAGES, -pgcnt);
-	lruvec_stat_mod_folio(folio, NR_SECONDARY_PAGETABLE, -pgcnt);
+	iommu_folio_update_stats(folio, -pgcnt);
 	folio_put(folio);
 }
 
@@ -131,6 +137,100 @@ void iommu_put_pages_list(struct iommu_pages_list *list)
 }
 EXPORT_SYMBOL_GPL(iommu_put_pages_list);
 
+#if IS_ENABLED(CONFIG_IOMMU_LIVEUPDATE)
+/**
+ * iommu_unpreserve_page - Unpreserve a page that was preserved in KHO
+ * @virt: Virtual address of a page
+ */
+void iommu_unpreserve_page(void *virt)
+{
+	kho_unpreserve_folio(ioptdesc_folio(virt_to_ioptdesc(virt)));
+}
+EXPORT_SYMBOL_GPL(iommu_unpreserve_page);
+
+/**
+ * iommu_preserve_page - Preserve a page during kexec handover
+ * @virt: Virtual address of the page to preserve
+ *
+ * Returns 0 on success, negative error on failure
+ */
+int iommu_preserve_page(void *virt)
+{
+	return kho_preserve_folio(ioptdesc_folio(virt_to_ioptdesc(virt)));
+}
+EXPORT_SYMBOL_GPL(iommu_preserve_page);
+
+/**
+ * iommu_unpreserve_pages - Unpreserve pages that were preserved in KHO
+ * @list: List of pages to unpreserve
+ */
+void iommu_unpreserve_pages(struct iommu_pages_list *list)
+{
+	struct ioptdesc *iopt;
+
+	list_for_each_entry(iopt, &list->pages, iopt_freelist_elm)
+		kho_unpreserve_folio(ioptdesc_folio(iopt));
+}
+EXPORT_SYMBOL_GPL(iommu_unpreserve_pages);
+
+/**
+ * iommu_restore_page - Restore a page that was preserved in KHO
+ * @phys: Physical address of a page
+ */
+void iommu_restore_page(u64 phys)
+{
+	struct ioptdesc *iopt;
+	struct folio *folio;
+	unsigned long pgcnt;
+	unsigned int order;
+
+	folio = kho_restore_folio(phys);
+	BUG_ON(!folio);
+
+	iopt = folio_ioptdesc(folio);
+
+	/*
+	 * For the restored pages incoherent is set to false as these are not
+	 * mapped using the DMA_API. The remapping of these pages using DMA_API
+	 * is not needed as these are not going to be written to by the new
+	 * kernel.
+	 */
+	iopt->incoherent = false;
+
+	order = folio_order(folio);
+	pgcnt = 1UL << order;
+	iommu_folio_update_stats(folio, pgcnt);
+}
+EXPORT_SYMBOL_GPL(iommu_restore_page);
+
+/**
+ * iommu_preserve_pages - Preserve pages during kexec handover
+ * @list: List of pages to preserve
+ *
+ * Returns 0 on success, negative error on failure
+ */
+int iommu_preserve_pages(struct iommu_pages_list *list)
+{
+	struct ioptdesc *iopt;
+	int ret;
+
+	list_for_each_entry(iopt, &list->pages, iopt_freelist_elm) {
+		ret = kho_preserve_folio(ioptdesc_folio(iopt));
+		if (ret)
+			goto err;
+	}
+
+	return 0;
+
+err:
+	list_for_each_entry_continue_reverse(iopt, &list->pages, iopt_freelist_elm)
+		kho_unpreserve_folio(ioptdesc_folio(iopt));
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_preserve_pages);
+#endif
+
 /**
  * iommu_pages_start_incoherent - Setup the page for cache incoherent operation
  * @virt: The page to setup
diff --git a/drivers/iommu/iommu-pages.h b/drivers/iommu/iommu-pages.h
index ae9da4f571f6..7b9b6bb504b2 100644
--- a/drivers/iommu/iommu-pages.h
+++ b/drivers/iommu/iommu-pages.h
@@ -53,6 +53,36 @@ void *iommu_alloc_pages_node_sz(int nid, gfp_t gfp, size_t size);
 void iommu_free_pages(void *virt);
 void iommu_put_pages_list(struct iommu_pages_list *list);
 
+#if IS_ENABLED(CONFIG_IOMMU_LIVEUPDATE)
+int iommu_preserve_page(void *virt);
+void iommu_unpreserve_page(void *virt);
+int iommu_preserve_pages(struct iommu_pages_list *list);
+void iommu_unpreserve_pages(struct iommu_pages_list *list);
+void iommu_restore_page(u64 phys);
+#else
+static inline int iommu_preserve_page(void *virt)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void iommu_unpreserve_page(void *virt)
+{
+}
+
+static inline int iommu_preserve_pages(struct iommu_pages_list *list)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void iommu_unpreserve_pages(struct iommu_pages_list *list, int count)
+{
+}
+
+static inline void iommu_restore_page(u64 phys)
+{
+}
+#endif
+
 /**
  * iommu_pages_list_add - add the page to a iommu_pages_list
  * @list: List to add the page to
-- 
2.54.0.545.g6539524ca2-goog

