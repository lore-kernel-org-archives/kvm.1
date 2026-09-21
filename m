Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA4624293C
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 00:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789951727; cv=none; b=D66VG0goeMztKYEJiE0+nQpwmfxLjWgqoE6dzoTrQrTAnkzYEpcjSDHgI9guRLvkWq0zVA5UZNn07t//qZh6n/A0nZ4E4+20zpbagtVZFO2vEqT4ruWi4sUfW/vA3K9Y789rQpFT7L8B5UNXinesqYCqJn48ZIQ7YRfackbVo4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789951727; c=relaxed/simple;
	bh=cH4LgWtd8WAbba4aDJwQQHyfDWm4RDvnu4B8RSUj3tE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uTX9a0h+3pFZcC/M4xL005Ag8Yzsz6uZ3ZUx/kZRCoOcEQonq0a7fU7qFLs2lhoYTesmLDxkve1CiPucGlS1Z1xcWrefwIhS1k65Pap0fqVVHwaMrsH/NHEtc319gNFWQGb2JKq5w2GHlJoI5YTtzwe90jS5Yk+uDusNgXvZ2JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LkwyINz8; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LkwyINz8"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d94f086fedso36529675ad.1
        for <kvm@vger.kernel.org>; Sun, 20 Sep 2026 17:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789951723; x=1790556523; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pz0sP5OadudQTU/jOFxKypYztFVbcpWTHcp4vp3QfFc=;
        b=LkwyINz8zsoiC6aaUvYbiaFkiBmWiwFWRv3YCFu3+w8ZW4WHoXjgyglHsslaJbvYwl
         GUMiXayqXbqDc3pv08lga8wuQPuDpOkKnYPpZL3hAKxM377csVN92kiDP2vkw/GAcpFE
         FUQSXNDQaUApM/dyC103efA68CiLDljCyC+XoBD4VFh0KANy3FvxKKk+AQtVJ5mZUE08
         lloFLD4+I7zcSX7gLGvYH89TXc3EeYb+yQjckrNp0bCnI6jONsmqan1P8ew+G987Uy81
         p2ELWBMYDI4jW66trYDJRtzs8EEqc2BL+zLogghiJqX0piO2+v6luDyB6VH3DQw80VBN
         qHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789951723; x=1790556523;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pz0sP5OadudQTU/jOFxKypYztFVbcpWTHcp4vp3QfFc=;
        b=oSttLsB0m0P+6I4mrOCS/DHgXH+LVwYPMwqbJADBnscrdfO0/ctAsWcGGNyD14b5Pm
         zkK8/9hlM0Y4GSMilA1Nbzg2KEtvhIRICyC/iuYJCU1kmDGicJD9/sSuh9tM9sbfOezm
         VbrPHQ+Rsirwycyf7Kx5ZWeAvlEJBP98EWecSBJii1seXomQ0DI4VUcwIzSlnPh8cwEd
         buNMZzaIRtOyePKMN2otn3XTQxk0caEpDGwsKr8+OUUvN27YhEqhTdHkEX8e22PSKMTO
         YLI2gOHY1uyiSbYNhp9Lv+tm48hVdIFyHMXxXvXqZRpzqQSZQSUesUXRrG90GD1uV6Pf
         /X1g==
X-Forwarded-Encrypted: i=1; AKwUvBzNWzFSLP3JbcFxD6FZXTzaaofb8KVwuDW/oZ6B9ez/LMcBcwwlGAgs+xjfAR6hou4MG1A=@vger.kernel.org
X-Gm-Message-State: AFuF++nz2yqcvRn6WsZ8nRLwudixRRNlT0WYc4BEvHGPxB/Wg3poyYOc
	qw9sGNXsbQW+AvOq3p+xuiKBmfjAYB8O8T2TALwuApufaKYgGmztpjWeXpYoi1gYSfDkx+KUODG
	cte28sADl/bhKXA==
X-Received: from pli4.prod.google.com ([2002:a17:902:c104:b0:2df:3764:615])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:234d:b0:2da:e967:7953 with SMTP id d9443c01a7336-2ddb1b0d343mr144393205ad.12.1789951723018;
 Sun, 20 Sep 2026 17:48:43 -0700 (PDT)
Date: Mon, 21 Sep 2026 00:48:19 +0000
In-Reply-To: <20260921004834.2601285-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921004834.2601285-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921004834.2601285-4-skhawaja@google.com>
Subject: [PATCH v5 03/18] iommu/pages: Add APIs to preserve/unpreserve/restore
 iommu pages
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

IOMMU pages are allocated/freed using APIs using struct ioptdesc. For
the proper preservation and restoration of ioptdesc add helper
functions.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/iommu-pages.c | 108 ++++++++++++++++++++++++++++++++++--
 drivers/iommu/iommu-pages.h |  30 ++++++++++
 2 files changed, 134 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu-pages.c b/drivers/iommu/iommu-pages.c
index 3bab175d8557..96cc935fb4e1 100644
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
+ * iommu_unpreserve_pages - Unpreserve pages that were preserved in KHO
+ * @virt: Virtual address of page to be unpreserved
+ */
+void iommu_unpreserve_pages(void *virt)
+{
+	kho_unpreserve_folio(ioptdesc_folio(virt_to_ioptdesc(virt)));
+}
+EXPORT_SYMBOL_GPL(iommu_unpreserve_pages);
+
+/**
+ * iommu_preserve_pages - Preserve pages using KHO
+ * @virt: Virtual address of page to preserve
+ *
+ * Returns 0 on success, negative error on failure
+ */
+int iommu_preserve_pages(void *virt)
+{
+	return kho_preserve_folio(ioptdesc_folio(virt_to_ioptdesc(virt)));
+}
+EXPORT_SYMBOL_GPL(iommu_preserve_pages);
+
+/**
+ * iommu_unpreserve_pages_list - Unpreserve a list of KHO preserved pages
+ * @list: List of pages to unpreserve
+ */
+void iommu_unpreserve_pages_list(struct iommu_pages_list *list)
+{
+	struct ioptdesc *iopt;
+
+	list_for_each_entry(iopt, &list->pages, iopt_freelist_elm)
+		kho_unpreserve_folio(ioptdesc_folio(iopt));
+}
+EXPORT_SYMBOL_GPL(iommu_unpreserve_pages_list);
+
+/**
+ * iommu_restore_pages - Restore pages that were preserved in KHO
+ * @phys: Physical address of page to restore
+ */
+void iommu_restore_pages(u64 phys)
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
+EXPORT_SYMBOL_GPL(iommu_restore_pages);
+
+/**
+ * iommu_preserve_pages_list - Preserve list of pages using KHO
+ * @list: List of pages to preserve
+ *
+ * Returns 0 on success, negative error on failure
+ */
+int iommu_preserve_pages_list(struct iommu_pages_list *list)
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
+EXPORT_SYMBOL_GPL(iommu_preserve_pages_list);
+#endif
+
 /**
  * iommu_pages_start_incoherent - Setup the page for cache incoherent operation
  * @virt: The page to setup
diff --git a/drivers/iommu/iommu-pages.h b/drivers/iommu/iommu-pages.h
index e9e605b5fa3a..3c409ec3d170 100644
--- a/drivers/iommu/iommu-pages.h
+++ b/drivers/iommu/iommu-pages.h
@@ -53,6 +53,36 @@ void *iommu_alloc_pages_node_sz(int nid, gfp_t gfp, size_t size);
 void iommu_free_pages(void *virt);
 void iommu_put_pages_list(struct iommu_pages_list *list);
 
+#if IS_ENABLED(CONFIG_IOMMU_LIVEUPDATE)
+int iommu_preserve_pages(void *virt);
+void iommu_unpreserve_pages(void *virt);
+int iommu_preserve_pages_list(struct iommu_pages_list *list);
+void iommu_unpreserve_pages_list(struct iommu_pages_list *list);
+void iommu_restore_pages(u64 phys);
+#else
+static inline int iommu_preserve_pages(void *virt)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void iommu_unpreserve_pages(void *virt)
+{
+}
+
+static inline int iommu_preserve_pages_list(struct iommu_pages_list *list)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void iommu_unpreserve_pages_list(struct iommu_pages_list *list)
+{
+}
+
+static inline void iommu_restore_pages(u64 phys)
+{
+}
+#endif
+
 /**
  * iommu_pages_list_add - add the page to a iommu_pages_list
  * @list: List to add the page to
-- 
2.55.0.1082.g2b9226bbc0-goog

