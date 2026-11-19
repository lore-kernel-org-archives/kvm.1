Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114642;
	b=n7YbwyNuEQwhDclY8XCN/Ai77lkwcJShMW6WaTESGyjxCzLzfu24EhakAG9EYLV16sN5
	 ec7MwBCZPgSMukA2vFRxP6KBqJ2zxK89OGiOzJOEJnVyXI2TVMSwdQXL0FKwWA6Sqmnv+
	 GnytVuJ/vflTDIhYcjzFrcWNarGE10DHNkUwkQBHlU3Hfy6NB+bKQzxiIUri2xJpimUTb
	 ZvVCsfClB35r+KcfdSfCnEPediUkGMnaIq52ZM/+uES2sJ8FUQ/jvA4YeZ+Gca+8/7pz2
	 abUp+M/B1T86yftWYISJOOHYWStRBBm5MrlJi1kZ7CxZbKWsKRldwaQn/yXSXy6gLtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114642;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=SwfEFTwvAkrGo1uIFQIK6qC1G/PkQTUsdHH3b1a9bwk=;
	b=mZzz4BOLVoER6z6GfMMZA0MHHbbSMSqPsn22d62I7epsLOExmVr1qd7ZMl56HIeGcWTv
	 GVJhXFnAtqBVjDz4ZCjTQUHr3e+ClzKWzGYt07F6ZH9FtOTNGn++Q98rn+IXxd8hOdEno
	 WZa3sskbPFDXf7aYVDJz/AXXX1y0vs+QUep+04mXxObYhdSCWXYuGYwTpMiZvHcn3OOuZ
	 Ng4nsGBjzWChHCchizs3zJdsBSLtwUpMNvIvtukZQaTOg2ytojTXdMbfXko78uj7UKRFQ
	 x6/GWZI93X1+adDWiwPx0JFRqtt+2L/w9W/7EYHBDizyahLdBVDVXrVjY0Hrw1xq1ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=USdfg0Rj;
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30464606A324
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 18:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30464606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=USdfg0Rj
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1af203073e0so73129c88.1
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 10:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795114641; x=1795719441; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SwfEFTwvAkrGo1uIFQIK6qC1G/PkQTUsdHH3b1a9bwk=;
        b=USdfg0RjnhZ9KvGtsiUTAdyCoiVx+jLNXrmypqqY1p3NQVZqw5paIS1lOxj+46T/zN
         kgWNYtr1HahbajqkRgiq4ImQGjo5GnRsuJW4jRu3dVvOXFmQoA8yisD4AWRTI9xUyBV4
         YBD45zM8gstwNRwRQqKIrm158P5EXKumtxtnSoqrU/Cw1naovRhj7LD81Fvk4G0+aqpk
         kNd/+v4SbSpuuETLyCSxh76I+U++ZR90fGbwsJQdFw48AmRORhJ1/nPfmpYzDE5DeHLj
         ctJYzwgmda9YfrKPeoqA6KU1LOVsamkmTtEcGkE8mOI4NMcRC6ff4p7cqCxJqhMSTXye
         FaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795114641; x=1795719441;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SwfEFTwvAkrGo1uIFQIK6qC1G/PkQTUsdHH3b1a9bwk=;
        b=ebOCycgVo4P1uH/7HEbwvKyzPSjpGQ6g1+IS1ysU6CaTwSAUU8g/0cyy0V73STb92T
         s1Sz65De9uDnmQDcxlQamIdI+XyufNyIAe52nEPMTqaOO/qOhlb6R7zd0Bjf/clCj1/x
         j+HRLwQ6YUQqrcl5HyIdg530tA1Jz6bK2xn+eLm4yAuen6BEgxUlxLIxCERAC+Zj3IaX
         WL1swFBKZUGgu8s5uRM4TDBsiFaz4d3SLeM0c6YorKZ2yl1dwtS6DJlseGW8cwBmhtrH
         OkqyEiYewDXTry2PszV6IYEPXEbjyDnL3mgH0X1blzh0GeB9fcUu8EZe4fV2/3NzkxpC
         1gzA==
X-Gm-Message-State: APuU4Z+mh7X2ON3I1uXnc9KYQOiv6IHBP4VLEkBE36hpPoIDrtOdT671
	C8/k6WbTeMhcid4XHZoXc7+sghwei+VYxIAgWauVD0qFRAakNRin5NnBOc779qNO0WirSLtSdeb
	PrVqqs13qnen3sBSwAg4r2tJeQcpetqHS65Y2TpBqOiCK2E9TizCap8CCaDdDKkabqryxuwe7bX
	ofp+d5P0/YVT2jd3S6sph3x+CGVw1m+R5Bg6fGss9qnVM4tMu5bOHrFA==
X-Received: from dlcio7.prod.google.com ([2002:a05:7023:c007:b0:1b5:9e8:8738])
 (user=aaronlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:2608:b0:15b:afce:62c2 with SMTP id a92af1059eb24-1b55691337bmr405059c88.41.1795114640730;
 Thu, 19 Nov 2026 10:57:20 -0800 (PST)
Date: Thu, 19 Nov 2026 18:56:58 +0000
In-Reply-To: <20261119185659.889654-1-aaronlewis@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119185659.889654-1-aaronlewis@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261119185659.889654-3-aaronlewis@google.com>
Subject: [PATCH 2/3] vfio/type1: Track GUP vs PFNMAP in DMA map/unmap
From: Aaron Lewis <aaronlewis@google.com>
To: kvm@vger.kernel.org
Cc: alex@shazbot.org, dmatlack@google.com, jgg@nvidia.com, 
	Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Both vfio_pin_pages_remote() and vfio_unpin_pages_remote() use
PageReserved() as a heuristic to infer whether a page was PFNMAP'd or
GUP-pinned in vaddr_get_pfns(). That heuristic breaks down when the same
reserved struct pages can appear on both paths:

- DevDax pages mapped from /dev/dax* are reserved and GUP-pinned.
- Those same pages mapped from /dev/mem (PFNMAP) are also reserved,
  but they are *not* GUP-pinned.

Because of this, when unpinning the DMA region, vfio_unpin_pages_remote()
doesn't know whether those reserved pages were GUP-pinned and skips
unpinning them altogether, *leaking page pins and refcounts*.

Fix this by replacing has_rsvd and has_non_rsvd in struct vfio_dma with
has_pfnmap and has_gup_pinned, tracking which path vaddr_get_pfns()
actually used, and clearing them when a DMA range is unpinned. Since
PFNMAP pages bypass struct vfio_batch, this also fixes locked_vm
accounting and batch error-unwind unpinning for reserved GUP-pinned
pages.

This isn't an exhaustive fix because mixed mappings are still allowed.
For example, if a single DMA region contains both GUP-pinned and
PFNMAP pages, vfio_unpin_pages_remote() can't tell them apart. Handle
this by preserving the existing put_pfn() fallback, and add
a comment explaining the situation.

Lastly, clear the new flags once a vfio_dma is fully unpinned. A vfio_dma
can outlive its pins and be pinned again later, after
vfio_iommu_unmap_unpin_reaccount() or a failed vfio_iommu_replay(), by
which time the user may have remapped the range. A stale has_rsvd only
selected the slower unpin path, but a stale has_pfnmap would send a
mapping that is now entirely GUP-pinned down the wrong unpin path.

Fixes: 3565fce3a659 ("mm, x86: get_user_pages() for dax mappings")
Signed-off-by: Aaron Lewis <aaronlewis@google.com>
---
 drivers/vfio/vfio_iommu_type1.c | 103 ++++++++++++++++++--------------
 1 file changed, 58 insertions(+), 45 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 7bad0508dd21..ee40ba942fd5 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -93,8 +93,8 @@ struct vfio_dma {
 	bool			iommu_mapped;
 	bool			lock_cap;	/* capable(CAP_IPC_LOCK) */
 	bool			vaddr_invalid;
-	bool			has_rsvd;	/* has 1 or more rsvd pfns */
-	bool			has_non_rsvd;	/* has 1 or more !rsvd pfns */
+	bool			has_pfnmap;	/* has 1 or more pfnmap pfns */
+	bool			has_gup_pinned;	/* has 1 or more GUP-pinned pfns */
 	struct task_struct	*task;
 	struct rb_root		pfn_list;	/* Ex-user pinned pfn list */
 	unsigned long		*bitmap;
@@ -416,6 +416,13 @@ static struct vfio_pfn *vfio_iova_get_vfio_pfn(struct vfio_dma *dma,
 	return vpfn;
 }
 
+static inline void put_gup_pfns(unsigned long start_pfn, unsigned long npage,
+				int prot)
+{
+	unpin_user_page_range_dirty_lock(pfn_to_page(start_pfn), npage,
+					 prot & IOMMU_WRITE);
+}
+
 static int vfio_iova_put_vfio_pfn(struct vfio_dma *dma, struct vfio_pfn *vpfn)
 {
 	int ret = 0;
@@ -523,12 +530,11 @@ static void vfio_batch_init_single(struct vfio_batch *batch)
 
 static void vfio_batch_unpin(struct vfio_batch *batch, struct vfio_dma *dma)
 {
-	while (batch->size) {
-		unsigned long pfn = page_to_pfn(batch->pages[batch->offset]);
-
-		put_pfn(pfn, dma->prot);
-		batch->offset++;
-		batch->size--;
+	if (batch->size) {
+		unpin_user_pages_dirty_lock(&batch->pages[batch->offset],
+					    batch->size,
+					    dma->prot & IOMMU_WRITE);
+		batch->size = 0;
 	}
 }
 
@@ -673,6 +679,15 @@ static long vpfn_pages(struct vfio_dma *dma,
 	return ret;
 }
 
+/*
+ * After a successful vaddr_get_pfns(), GUP populates batch->pages while
+ * VM_PFNMAP leaves the batch empty.
+ */
+static bool vfio_batch_is_pfnmap(const struct vfio_batch *batch)
+{
+	return batch->size == 0;
+}
+
 /*
  * Attempt to pin pages.  We really don't want to track all the pfns and
  * the iommu can only map chunks of consecutive pfns anyway, so get the
@@ -685,7 +700,7 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
 	unsigned long pfn;
 	struct mm_struct *mm = current->mm;
 	long ret, pinned = 0, lock_acct = 0;
-	bool rsvd;
+	bool pfnmap = false;
 	dma_addr_t iova = vaddr - dma->vaddr + dma->iova;
 
 	/* This code path is only user initiated */
@@ -696,7 +711,6 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
 		/* Leftover pages in batch from an earlier call. */
 		*pfn_base = page_to_pfn(batch->pages[batch->offset]);
 		pfn = *pfn_base;
-		rsvd = is_invalid_reserved_pfn(*pfn_base);
 	} else {
 		*pfn_base = 0;
 	}
@@ -721,12 +735,18 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
 
 			if (!*pfn_base) {
 				*pfn_base = pfn;
-				rsvd = is_invalid_reserved_pfn(*pfn_base);
+				pfnmap = vfio_batch_is_pfnmap(batch);
+			} else if (pfnmap != vfio_batch_is_pfnmap(batch)) {
+				/*
+				 * Handle PFNMAP and GUP pages separately; any
+				 * GUP pages remain in batch for the next call.
+				 */
+				goto out;
 			}
 
 			/* Handle pfnmap */
-			if (!batch->size) {
-				if (pfn != *pfn_base + pinned || !rsvd)
+			if (pfnmap) {
+				if (pfn != *pfn_base + pinned)
 					goto out;
 
 				pinned += ret;
@@ -742,32 +762,20 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
 		 * due to the fact that vaddr_get_pfns() needs to provide the
 		 * initial pfn for pfnmaps.  Therefore to reduce redundancy,
 		 * the next pfn is fetched at the end of the loop.
-		 * A PageReserved() page could still qualify as page backed
-		 * and rsvd here, and therefore continues to use the batch.
 		 */
 		while (true) {
-			long nr_pages, acct_pages = 0;
+			long nr_pages, acct_pages;
 
-			if (pfn != *pfn_base + pinned ||
-			    rsvd != is_invalid_reserved_pfn(pfn))
+			if (pfn != *pfn_base + pinned)
 				goto out;
 
-			/*
-			 * Using GUP with the FOLL_LONGTERM in
-			 * vaddr_get_pfns() will not return invalid
-			 * or reserved pages.
-			 */
 			nr_pages = num_pages_contiguous(
 					&batch->pages[batch->offset],
 					batch->size);
-			if (!rsvd) {
-				acct_pages = nr_pages;
-				acct_pages -= vpfn_pages(dma, iova, nr_pages);
-			}
+			acct_pages = nr_pages - vpfn_pages(dma, iova, nr_pages);
 
 			/*
-			 * Reserved pages aren't counted against the user,
-			 * externally pinned pages are already counted against
+			 * Externally pinned pages are already counted against
 			 * the user.
 			 */
 			if (acct_pages) {
@@ -796,29 +804,21 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
 	}
 
 out:
-	dma->has_rsvd |= rsvd;
-	dma->has_non_rsvd |= !rsvd;
 	ret = vfio_lock_acct(dma, lock_acct, false);
 
 unpin_out:
 	if (ret < 0) {
-		if (pinned && !rsvd) {
-			for (pfn = *pfn_base ; pinned ; pfn++, pinned--)
-				put_pfn(pfn, dma->prot);
-		}
+		if (pinned && !pfnmap)
+			put_gup_pfns(*pfn_base, pinned, dma->prot);
 		vfio_batch_unpin(batch, dma);
 
 		return ret;
 	}
 
-	return pinned;
-}
+	dma->has_pfnmap |= pfnmap;
+	dma->has_gup_pinned |= !pfnmap;
 
-static inline void put_valid_unreserved_pfns(unsigned long start_pfn,
-		unsigned long npage, int prot)
-{
-	unpin_user_page_range_dirty_lock(pfn_to_page(start_pfn), npage,
-					 prot & IOMMU_WRITE);
+	return pinned;
 }
 
 static long vfio_unpin_pages_remote(struct vfio_dma *dma, dma_addr_t iova,
@@ -827,16 +827,23 @@ static long vfio_unpin_pages_remote(struct vfio_dma *dma, dma_addr_t iova,
 {
 	long unlocked = 0, locked = vpfn_pages(dma, iova, npage);
 
-	if (dma->has_rsvd) {
-		if (dma->has_non_rsvd) {
+	if (dma->has_pfnmap) {
+		if (dma->has_gup_pinned) {
 			unsigned long i;
 
+			/*
+			 * Because there is no way to tell if this DMA region
+			 * was PFNMAP or GUP-pinned, fall back to the
+			 * heuristic in put_pfn() of skipping invalid and
+			 * reserved pfns, which fails to unpin reserved pages
+			 * that were GUP-pinned.
+			 */
 			for (i = 0; i < npage; i++)
 				if (put_pfn(pfn++, dma->prot))
 					unlocked++;
 		}
 	} else {
-		put_valid_unreserved_pfns(pfn, npage, dma->prot);
+		put_gup_pfns(pfn, npage, dma->prot);
 		unlocked = npage;
 	}
 	if (do_accounting)
@@ -1232,6 +1239,9 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
 					    &iotlb_gather);
 	}
 
+	dma->has_pfnmap = false;
+	dma->has_gup_pinned = false;
+
 	if (do_accounting) {
 		vfio_lock_acct(dma, -unlocked, true);
 		return 0;
@@ -1947,6 +1957,9 @@ static int vfio_iommu_replay(struct vfio_iommu *iommu,
 			vfio_unpin_pages_remote(dma, iova, phys >> PAGE_SHIFT,
 						size >> PAGE_SHIFT, true);
 		}
+
+		dma->has_pfnmap = false;
+		dma->has_gup_pinned = false;
 	}
 
 	vfio_batch_fini(&batch);
-- 
2.56.1.708.g77570a6a1d-goog

