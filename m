Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792894778;
	b=i9vxbpv6x8NfTEX4oC89FKEcW1HWS8pFde9btwL9fC0UsUezBNCcQOKoZR6x1YSC/3D+
	 hXjMuC8pCowWaba/elP6oMekY3VDXB2dWrC57YRcTqG3x+8DWIY8OadejUtxK5AJ3498F
	 ah/GvqvvpqT5XwKUdlP4v6YDiNs5FpPjzWRW+uxMtyB/12VQI9IMPna9sadocu0ooIJzj
	 HsvVtpB2pKnk+/vQhi1pgCYExjSP8NFf90B/VxlYr6S5/dIuS734rRX5LFum3YRE3ei05
	 JhKZFeu34nLvtXjlSJAnSFU1XFTV9+bOfhbNMHr06q7vKZkLy1OSviEod/HESqMLBxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792894778;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=8I5U/zrWvi98+E5X3Jiy/fKB93Ihk6xZZby71WhXaRA=;
	b=4QaBZY1AbvwRWRXYBDnsUuG5J5Qh6ELmXMgimhvzDGUrgqMTKnFST+/ZW1i/5Ujst7cy
	 bkqPQaJpv0aQuwRfp1jcgqOGfGu6OWUm9FYn6GAFV51soEN7byzW+2KH7R9RW418hjs/H
	 /UYI8tc2r09JmWcjjKldQxjbUo0nCqAWb9Eo33ZlKz7vprrFX5+7jyXIzagzoWkOLY398
	 I2VHGUnwnzN180092UPaW3D4yyl/5otslypj4PogkmuBfnIye0qpvtCvVfsgif9ZkOd45
	 7sFjfa4B0nHPqkJbJTzUI+g8bIhBIvx+IOk5kFynd3kqzVhH1ZI0VVCps8lXq/leEKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=DD+V0oOe;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1B460A2633
	for <kvm@vger.kernel.org>; Sun, 25 Oct 2026 02:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD1B460A2633
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=DD+V0oOe
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2df8484f12cso18094185ad.3
        for <kvm@vger.kernel.org>; Sat, 24 Oct 2026 19:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792894777; x=1793499577; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8I5U/zrWvi98+E5X3Jiy/fKB93Ihk6xZZby71WhXaRA=;
        b=DD+V0oOewUQ3CWxfV9DzjC2DkN6QELa+VbeaR7rRfqE7fs7egA0yxqDe25Wep0XPiX
         qkGFgrMKbLuCHmpr6V6hm2wGTTs5oMiPHkgTAw1WwKhGX30m4a8nUlxQ4kO+1+tUZ26j
         gobUtJn4AzWpLryLxkt2RY9xbfwph1wHOS2dKHKdM63tx5zkZOwXSiil8JmZpDBp80eH
         ySEX3q1z4fQ7e2zJxTI95m/l39txeZkVpmlonctVMtB78roNFWmW8UENh7lZQ1Y3NxnQ
         czkn3xcDaDdoVQsgMJ3+c4WWUbBkIl7k9nqqVy0rT39RhqhlBabaR5vYMqWPKxMznuCy
         hV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792894777; x=1793499577;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8I5U/zrWvi98+E5X3Jiy/fKB93Ihk6xZZby71WhXaRA=;
        b=ZynW/VbBytgPDFNOjGc21K6XZ2sqSG26o1HZKtvYTgebKI/V6gqBl3lRPBl6urzCEY
         PNji9Ms0tWTSOk2B164tWLyztIKnLBaBy3sU8mchSrY+4c64tphHnVDInF+iskyNHM0a
         P0VRW0pkR308V/9cAdKGJP7GgdwVfxZwXi6T5fOY27j4zr6zsxRVc5V2ReG5Hcem+IPr
         +hFj4i8X9COXYVQpbcHK/djwBEgMZbQVONnxkdHWmtCyPxsmEnMWsF8XSMjBQIHVLfNa
         sN7O6DxGHh4AhzctCdLu33Xu0ZGayVuM1TVTuTC4jcyEs/haaNQE1AjH2Q2zDzUp6i1H
         B2kA==
X-Forwarded-Encrypted: i=1; AKwUvByxDfdO8tQYYAywyJmLXxtnog15TWV7wwhkK5xo6eMsrCTftxNWioJRBZ0xYfQH5PDMwFI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJYcB4xjYuDO+dYU8Pf4rp81FGBnJoWE5yFcZ2s3d/5m186dsm6
	bKQlkZ8l3Lj2Lj2TPcS5/Sq1EQWEHi0mvdbJ44WPTZef8J+BFdYce8cmt6SrkeQEnearyFSTX9N
	IXZPiHosoIOfZQA==
X-Received: from plhv13.prod.google.com ([2002:a17:903:238d:b0:2e5:6ae7:d701])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e947:b0:2e9:4f21:91ef with SMTP id d9443c01a7336-2ea9c876333mr23662555ad.36.1792894776898;
 Sat, 24 Oct 2026 19:19:36 -0700 (PDT)
Date: Sun, 25 Oct 2026 02:19:13 +0000
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
Message-ID: <20261025021930.674647-3-skhawaja@google.com>
Subject: [PATCH v6 02/18] iommu/pages: Add APIs to preserve/unpreserve/restore
 iommu pages
From: Samiullah Khawaja <skhawaja@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Woodhouse <dwmw2@infradead.org>
Cc: Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vipin Sharma <vipinsh@google.com>, Ankit Soni <Ankit.Soni@amd.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Content-Type: text/plain; charset="UTF-8"

IOMMU pages are allocated/freed using APIs using struct ioptdesc. For
the proper preservation and restoration of ioptdesc add helper
functions.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/iommu-pages.c | 109 ++++++++++++++++++++++++++++++++++--
 drivers/iommu/iommu-pages.h |  30 ++++++++++
 2 files changed, 135 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu-pages.c b/drivers/iommu/iommu-pages.c
index 3bab175d8557..0aa18c771baa 100644
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
 
@@ -131,6 +137,101 @@ void iommu_put_pages_list(struct iommu_pages_list *list)
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
+	if (!folio)
+		panic("Failed to restore preserved IOMMU page %llx\n", phys);
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
2.56.0.257.gf7497c7d27-goog

