Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114646;
	b=v8qR5s55T3v8JtQ6A+Hm2xWwhuw5hkL+9dWimrl+EAejWhIbu9Iez2pYkZoBiid0nkod
	 odtWMTAilbTdyByTs7YnfTbT3WjC1VPiW7xPJcHJ8sWpIw/FWsGPo2fqGVFI3Ou78E9f1
	 09Yov72JkKvepl2KRgZod9DVanVx4iQgQg+qXRZobO1TbQY/1NATZxE/MLETd+CdWPe0R
	 FlcJQoEierd12l0H86JAqNxA35qbqGWt/SIgeEY6TryaoU+FfU70pc4oQyosLauES4xk7
	 be6KfMpIflAKmXKzrmIyFNF5P7pnlFo5nqDoWlzhupnSHS9JIztTtsHUgzNLm92A8cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114646;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=4fSH6nFt1ylg4ZgX5UgR/mWodCmv4OdEwxIuaClQQ7Y=;
	b=Pb+lPZMi3YzBct9PMj4X0pPnW4pWjIyZlsRBkohA/AZ+KoFzzwQuY5QUP0V9shHNRuvW
	 lU9QMjuu65342m+GGnGfDn7aLQBIuzgL6i58hVAKduvOesXlRLCr5iPdXfkN7oLW1UlWa
	 Pz/50hFnQiAdA/1+CjqmLNfQ9m1dTfpYiZAerUuzSAKSW2gLvHfUOD0PDXh0ESSNhJEC7
	 VX7dVypAxMHjYR5HgPxhHZxVnjgUNcPAfjheB9k37A9aEZzZIfAypEfvw2sy4EpcpcJTI
	 RULgDyzloaXrr8Zbh6CwexaUxZ3zV3HVQ96TJBFAlSScQ1N0pW60tUVh6pnPBnh2E3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BnzKZTP9;
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95B2606A32A
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 18:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A95B2606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BnzKZTP9
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1b25d977b91so90725c88.1
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 10:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795114645; x=1795719445; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4fSH6nFt1ylg4ZgX5UgR/mWodCmv4OdEwxIuaClQQ7Y=;
        b=BnzKZTP95RjLteFVMpVko/9FRsRq7TOOVyI57115A7tWE/MNdSXZwdsVTV7BcnTWhl
         /DroAACyDlip9LgbmdDq3NH+q1mo/vH01UVtGissOddDIgxmbKvX5EHLNcqMfHE4xXkS
         W+c9yGNR5H1LA5kNjDmLg77r/l2nSRLo/5xDLYYmW3FfgqtivfecZ/cKfNxtUTIHGJsm
         MDV2g9MFaisB8v2pLsJi3zY2u+uE/rtZfADhLG+9rgZRLRmHB8CTaQpMT6NPz8M+qRGi
         wNJmWzGMop5Bd6+gfvDIvMGWtc28MMWsK2ZaOA9m6UCpHc/Pw8fO6J+6XBqUdxvrpiUv
         cGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795114645; x=1795719445;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4fSH6nFt1ylg4ZgX5UgR/mWodCmv4OdEwxIuaClQQ7Y=;
        b=qTvzecY3m7ysxvf793wvn0RMd75+nR5RmPo78YG4GVBOsQMSS2FxC7D0i49QARmTKu
         WQWMT/2f0tTXkMXEJwRpHJl4zC217BkFtunSBtwDZarp5TORscsy30sT5QTX00eAqsEj
         Xm1O3ZT3glmNDikxcI5UIVP0sflyQwk+W+8w6tQWjaTXScJllAibis2F3WDECQsYdHf4
         WDgoEHW4Xab6X6qN/uocI3IbogohuGvwbuZ/JZdQ6UJ2ql9Vvj7fYGidWI0S/g6JwBBy
         lvqVEg56PoGrTiQyOhtkOnhZ5FVXPVFR2yO0to/Yz/Sz2Rq1d01QUcBPM+tdvTTQ637H
         sh2w==
X-Gm-Message-State: APuU4Z/2UpgyIhoocRl5+js/lIRFAINjM2yBgxggR9xBf7gTi7QpA8jS
	Dhl0jWRerXv6uneN5+pnU4IKizn4YuTLzi3htF8N6J1sJovn/FtZbI4pFrfmNIbZogJmtSG6inP
	Y5o/mg3Uz8u84XHFUjw/CVNlQ4ErueorJ/oXtXo3OtlMOFSDGW2H/FdNGP4mEoZvKZzaqhGPf+L
	N0aMSb1naCsm4Rbbck9Hn8IuFnF4WREMth+kLCz5Hd3dLRetl5bQMtTA==
X-Received: from dlbsw11.prod.google.com ([2002:a05:7022:3a8b:b0:19a:1425:bb9c])
 (user=aaronlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:2088:10b0:1b3:a22c:7f68 with SMTP id a92af1059eb24-1b5568d349fmr499819c88.29.1795114644360;
 Thu, 19 Nov 2026 10:57:24 -0800 (PST)
Date: Thu, 19 Nov 2026 18:56:59 +0000
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
Message-ID: <20261119185659.889654-4-aaronlewis@google.com>
Subject: [PATCH 3/3] vfio/type1: Track GUP vs PFNMAP in external page pinning
From: Aaron Lewis <aaronlewis@google.com>
To: kvm@vger.kernel.org
Cc: alex@shazbot.org, dmatlack@google.com, jgg@nvidia.com, 
	Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Like the DMA map/unmap path, external page pinning for emulated IOMMU
drivers (vfio_iommu_type1_pin_pages()) uses the same heuristic
(is_invalid_reserved_pfn()) to infer if a struct vfio_pfn was PFNMAP'd
or GUP-pinned in vaddr_get_pfns().

That heuristic falls apart for reserved GUP-pinned mappings such as
device-dax. They are treated as PFNMAP, so they are never unpinned,
which leaks page pins and refcounts. They are also left out of locked_vm
accounting.

Record in struct vfio_pfn whether vaddr_get_pfns() used the PFNMAP path,
and use that (vpfn->pfnmap) across all external pinning, unpinning, and
locked_vm accounting paths instead of inferring it.

As with the DMA map/unmap path, GUP-pinned reserved pages are now
charged against RLIMIT_MEMLOCK. When no IOMMU-backed domain is present,
vfio_pin_pages() on such memory can now fail with -ENOMEM where it
previously bypassed the limit.

Opportunistically, drop the forward declaration of put_pfn(), which is
no longer needed.

Fixes: a54eb55045ae ("vfio iommu type1: Add support for mediated devices")
Signed-off-by: Aaron Lewis <aaronlewis@google.com>
---
 drivers/vfio/vfio_iommu_type1.c | 39 ++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index ee40ba942fd5..b9c67ac0b16e 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -130,6 +130,7 @@ struct vfio_pfn {
 	dma_addr_t		iova;		/* Device address */
 	unsigned long		pfn;		/* Host pfn */
 	unsigned int		ref_count;
+	bool			pfnmap;
 };
 
 struct vfio_regions {
@@ -152,8 +153,6 @@ struct vfio_regions {
 #define DIRTY_BITMAP_PAGES_MAX	 ((u64)INT_MAX)
 #define DIRTY_BITMAP_SIZE_MAX	 DIRTY_BITMAP_BYTES(DIRTY_BITMAP_PAGES_MAX)
 
-static int put_pfn(unsigned long pfn, int prot);
-
 static struct vfio_iommu_group*
 vfio_iommu_find_iommu_group(struct vfio_iommu *iommu,
 			    struct iommu_group *iommu_group);
@@ -384,7 +383,7 @@ static void vfio_unlink_pfn(struct vfio_dma *dma, struct vfio_pfn *old)
 }
 
 static int vfio_add_to_pfn_list(struct vfio_dma *dma, dma_addr_t iova,
-				unsigned long pfn)
+				unsigned long pfn, bool pfnmap)
 {
 	struct vfio_pfn *vpfn;
 
@@ -395,6 +394,7 @@ static int vfio_add_to_pfn_list(struct vfio_dma *dma, dma_addr_t iova,
 	vpfn->iova = iova;
 	vpfn->pfn = pfn;
 	vpfn->ref_count = 1;
+	vpfn->pfnmap = pfnmap;
 	vfio_link_pfn(dma, vpfn);
 	return 0;
 }
@@ -429,7 +429,10 @@ static int vfio_iova_put_vfio_pfn(struct vfio_dma *dma, struct vfio_pfn *vpfn)
 
 	vpfn->ref_count--;
 	if (!vpfn->ref_count) {
-		ret = put_pfn(vpfn->pfn, dma->prot);
+		if (!vpfn->pfnmap) {
+			put_gup_pfns(vpfn->pfn, 1, dma->prot);
+			ret = 1;
+		}
 		vfio_remove_from_pfn_list(dma, vpfn);
 	}
 	return ret;
@@ -655,7 +658,7 @@ static long vpfn_pages(struct vfio_dma *dma,
 	if (likely(!top))
 		return 0;
 
-	if (!is_invalid_reserved_pfn(top->pfn))
+	if (!top->pfnmap)
 		ret++;
 
 	prev = next = &top->node;
@@ -664,7 +667,7 @@ static long vpfn_pages(struct vfio_dma *dma,
 		vpfn = rb_entry(prev, struct vfio_pfn, node);
 		if (vpfn->iova < iova_start)
 			break;
-		if (!is_invalid_reserved_pfn(vpfn->pfn))
+		if (!vpfn->pfnmap)
 			ret++;
 	}
 
@@ -672,7 +675,7 @@ static long vpfn_pages(struct vfio_dma *dma,
 		vpfn = rb_entry(next, struct vfio_pfn, node);
 		if (vpfn->iova >= iova_end)
 			break;
-		if (!is_invalid_reserved_pfn(vpfn->pfn))
+		if (!vpfn->pfnmap)
 			ret++;
 	}
 
@@ -853,7 +856,8 @@ static long vfio_unpin_pages_remote(struct vfio_dma *dma, dma_addr_t iova,
 }
 
 static int vfio_pin_page_external(struct vfio_dma *dma, unsigned long vaddr,
-				  unsigned long *pfn_base, bool do_accounting)
+				  unsigned long *pfn_base, bool do_accounting,
+				  bool *pfnmap)
 {
 	struct vfio_batch batch;
 	struct mm_struct *mm;
@@ -869,12 +873,13 @@ static int vfio_pin_page_external(struct vfio_dma *dma, unsigned long vaddr,
 	if (ret != 1)
 		goto out;
 
+	*pfnmap = vfio_batch_is_pfnmap(&batch);
 	ret = 0;
 
-	if (do_accounting && !is_invalid_reserved_pfn(*pfn_base)) {
+	if (do_accounting && !*pfnmap) {
 		ret = vfio_lock_acct(dma, 1, false);
 		if (ret) {
-			put_pfn(*pfn_base, dma->prot);
+			put_gup_pfns(*pfn_base, 1, dma->prot);
 			if (ret == -ENOMEM)
 				pr_warn("%s: Task %s (%d) RLIMIT_MEMLOCK "
 					"(%ld) exceeded\n", __func__,
@@ -957,6 +962,7 @@ static int vfio_iommu_type1_pin_pages(void *iommu_data,
 		unsigned long phys_pfn;
 		dma_addr_t iova;
 		struct vfio_pfn *vpfn;
+		bool pfnmap;
 
 		iova = user_iova + PAGE_SIZE * i;
 		dma = vfio_find_dma(iommu, iova, PAGE_SIZE);
@@ -978,7 +984,7 @@ static int vfio_iommu_type1_pin_pages(void *iommu_data,
 
 		remote_vaddr = dma->vaddr + (iova - dma->iova);
 		ret = vfio_pin_page_external(dma, remote_vaddr, &phys_pfn,
-					     do_accounting);
+					     do_accounting, &pfnmap);
 		if (ret)
 			goto pin_unwind;
 
@@ -987,10 +993,13 @@ static int vfio_iommu_type1_pin_pages(void *iommu_data,
 			goto pin_unwind;
 		}
 
-		ret = vfio_add_to_pfn_list(dma, iova, phys_pfn);
+		ret = vfio_add_to_pfn_list(dma, iova, phys_pfn, pfnmap);
 		if (ret) {
-			if (put_pfn(phys_pfn, dma->prot) && do_accounting)
-				vfio_lock_acct(dma, -1, true);
+			if (!pfnmap) {
+				put_gup_pfns(phys_pfn, 1, dma->prot);
+				if (do_accounting)
+					vfio_lock_acct(dma, -1, true);
+			}
 			goto pin_unwind;
 		}
 
@@ -2471,7 +2480,7 @@ static void vfio_iommu_unmap_unpin_reaccount(struct vfio_iommu *iommu)
 			struct vfio_pfn *vpfn = rb_entry(p, struct vfio_pfn,
 							 node);
 
-			if (!is_invalid_reserved_pfn(vpfn->pfn))
+			if (!vpfn->pfnmap)
 				locked++;
 		}
 		vfio_lock_acct(dma, locked - unlocked, true);
-- 
2.56.1.708.g77570a6a1d-goog

