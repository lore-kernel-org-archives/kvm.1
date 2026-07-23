Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6D9476CE2
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 15:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784820059; cv=none; b=hIJ4/4thbyTbsL+9B9HnB7H3NxFSh+YvUXKWCMEtS9ru/OdpEvsljNYEoza8w0yL4NsoujqotCsCcOT9ysR1n7fyxHCXOwyBbMWXB73EGbjnklCjjsTtGj8sEDMdWSXAhsL2fLGEvYcybJpLa/WdreNmOWMX2FT615RLhIUysuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784820059; c=relaxed/simple;
	bh=zn/gEMJJ1XMBLv9DV6RgUFJFogpvhK95ma5l8xlhpQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WddcNgVX50xNEy4Bkkr4TcHYK7wyBLYCo2bHncp8G5aJEUDfFjXZC/eeymDtm8xUwGzrt22UQ7Q8GHCtRxcbCbLISI8EFR4+wMEcyCML8qWSRUn8tgWexobGdlu+1ioUwTdXNmjvlqnXU9UnPTfNFTNzLne8K+YYJpzflJG23eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HlZjdPuv; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlZjdPuv"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c166f1bbeaeso135290566b.0
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 08:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784820050; x=1785424850; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TMp8M4J+xWVDBcklJvtTyv42HtG/Fh5aORRxNq6D7qM=;
        b=HlZjdPuv5HoIcnqsUu+9OBP+bSptMg9pG+KEd6GLvzg1RX9aHvXFQndunidCcTad/E
         P3wG1oa5f/9rjDrcE/8EObMwO2yu2xtyUg2UOkR3u/vlTYPfxInZubqge71/ik1NuruJ
         aum3WQUhz+/XP8bN5qlLpRR4nCyjZotyaBDYFwVbbKnbUSTuZgkt+cMEJB8/U874jKXN
         o/1UsdO7KFj+QwN33eo1sQlrOCISJaP/PyBwJqRWbHsv29UqYa4Y5RNWxHP0JDIq63Aa
         Iew6ZLSBtqnd6BrBOLcuEdN79Jj/bADnl6Wwmeaa/qoGnSbs0kh66itxvOOP65lEantC
         hPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784820050; x=1785424850;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TMp8M4J+xWVDBcklJvtTyv42HtG/Fh5aORRxNq6D7qM=;
        b=PcPGhHd5yuCQjw9slLOPEL7496nMcw9blcqkXZ5z9iWmlyA3Z2zXoFgisDtkbC3qP2
         S6JQE84O75Dn3TphZXYQoNiNyB6ZWKTXfPm5s5gkvszaAB3AjJV4gqav4FlNYuRbOEbm
         vYdfFy2ARD8kSaJvS1ntJBbGbnOjAZ9CJOhmwqJUUMWLJnjNtBcdzhxOTISaPvi0ecj0
         tbaWxfwI5ho+cfBfwLKTIghvJj+94siLgRv6W1Y5kq7bHTEfcMiSdmBYQoWyzHBhX+wQ
         VdD10sTV+BQUpap6OOXtwUYkkXC3XILXVoGpR2EEizs+m3dDYgt/HoySZxBNI/CS2p1P
         g3Kg==
X-Gm-Message-State: AOJu0Yzd/K+9w/63oZ1VpTgm+FXLKcZRFnYdDrUkPJ6k9ADNxFk3yzFh
	mIkkiVeSOvD3IJwyEKqCNb+dyc6zF3Qim3egG4eyeM5D0Xc68V7zTlaDtQL7Uug2
X-Gm-Gg: AR+sD10mfsooBK56b8tOXNY9J4J1aHAkmunlRjsbMyckwEyUaMhi4Cegt/8S42ehLVe
	8YHE5Wx/1qtOrMJqbxYYb3bIqfeE41FfBcjqU/rW6JA3yI8YIVT0yvDM9Iet8ztIIGgXEdPhfK1
	sZziDw2HPN2PunGseUG8rw7/KBXTFl0avBUJj7u1ImSLjMpeLk6eXakvxBQ2jykLSW/KutGm1HJ
	h0KooOXjNd/bOqvDoIOsOJPf7IRXhMZ3Ymn8Acd5BhzeEQ6IFsertsmBBNCVYHkW1wXaCac8u2v
	GkVzYHlFTuVlvzcwNetKG8GnjMuVEsBaLltQ5xKlqc0imQI/kzAL1Kup0m2HI0N9S8DU3E4G7k2
	QdTqzFn3nZ98fPTQfYBgux1b4+la7/8klGigZ1ZUXUUMb2Ykiin8kr5+hDUCDHOMsxJSF0VZrig
	==
X-Received: by 2002:a17:907:7b97:b0:c12:713b:e199 with SMTP id a640c23a62f3a-c1c50c27ddcmr193498566b.25.1784820049631;
        Thu, 23 Jul 2026 08:20:49 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c492f451bsm166730666b.50.2026.07.23.08.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 08:20:49 -0700 (PDT)
From: Samuel Crossley <samuelcrossley@gmail.com>
Date: Thu, 23 Jul 2026 08:20:00 -0700
Subject: [PATCH] vfio/type1: conditional rescheduling while unpinning
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-vfio-v1-1-3b59579916c6@gmail.com>
X-B4-Tracking: v=1; b=H4sIAB8xYmoC/yXMQQ5AMBBG4atM/rUmVFLSq4gF7ZSxQFpEIu4uW
 L7F9y4kjsIJli5EPiTJMsNSkRHc2M0DK/GwBJ1rk1e6VEeQRXl2vjZ9KF0wyAhr5CDnt2nav9P
 eT+y21+K+H6qbyRFoAAAA
X-Change-ID: 20260723-vfio-decd86bf3cf6
To: Alex Williamson <alex@shazbot.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Samuel Crossley <samuelcrossley@gmail.com>, 
 Sam Crossley <samuelcrossley@gmail.com>
X-Mailer: b4 0.16-dev

Tearing down a large device-passthrough DMA mapping can unpin tens to
hundreds of millions of pages in a single VFIO_IOMMU_UNMAP_DMA.
vfio_unpin_pages_remote() walks the whole contiguous range in one
uninterrupted pass with no reschedule point:

  - has_rsvd (reserved / device-memory mappings, e.g. GPU HBM/BAR mapped
    for peer DMA): a per-page put_pfn() loop, each doing a
    pfn_valid()/is_invalid_reserved_pfn() section lookup;
  - otherwise: the batched unpin_user_page_range_dirty_lock() folio walk.

The existing cond_resched() calls in the unmap path only run between
regions/chunks, so they cannot break up one giant call.

Observed on a GPU-passthrough host: unmapping a 128 GiB device-memory
region (~33.6M reserved 4K pages, has_rsvd) held a CPU 22s in the per-page
loop and tripped the soft-lockup watchdog, panicking the host:

  watchdog: BUG: soft lockup - CPU#74 stuck for 22s! [qemu-system-x86]
   put_pfn / is_invalid_reserved_pfn / pfn_valid
   vfio_unpin_pages_remote / vfio_sync_unpin / vfio_unmap_unpin
   vfio_remove_dma / vfio_iommu_type1_ioctl (VFIO_IOMMU_UNMAP_DMA)

The v6.18 batching series (d10872050ffe, d14de5b92578) optimized only the
non-reserved folio path, so it does not help this has_rsvd loop. Bound the
work per iteration and cond_resched() between chunks, mirroring the
pin-side fix in commit b1779e4f209c ("vfio/type1: conditional
rescheduling while pinning").

cond_resched() is safe on this path: the only lock held across
vfio_unpin_pages_remote() is iommu->lock, a mutex, so sleeping is allowed,
and it is taken in vfio_dma_do_unmap() and held continuously through
vfio_remove_dma() without being dropped on this path. No spinlock,
preempt-disabled, IRQ-disabled or RCU read-side section is held anywhere in
the type1 unmap path. The loop's callees (put_pfn(),
unpin_user_page_range_dirty_lock()) drop any transient folio reference and
folio lock before returning, so only the mutex is held at the reschedule
point. The path is already demonstrably sleepable: the same unmap chain
already calls cond_resched() at the region/chunk level, and the
non-reserved dirty path already takes folio_lock().

Signed-off-by: Samuel Crossley <samuelcrossley@gmail.com>
---
Signed-off-by: Sam Crossley <samuelcrossley@gmail.com>
---
 drivers/vfio/vfio_iommu_type1.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index c8151ba54de3..ce7f6051f799 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -814,22 +814,42 @@ static inline void put_valid_unreserved_pfns(unsigned long start_pfn,
 					 prot & IOMMU_WRITE);
 }
 
+/* Pages to unpin per cond_resched() when tearing down a large mapping. */
+#define VFIO_UNPIN_RESCHED_PAGES	(16UL * 1024)	/* 64MB @ 4K pages */
+
 static long vfio_unpin_pages_remote(struct vfio_dma *dma, dma_addr_t iova,
 				    unsigned long pfn, unsigned long npage,
 				    bool do_accounting)
 {
 	long unlocked = 0, locked = vpfn_pages(dma, iova, npage);
+	unsigned long remaining = npage;
 
-	if (dma->has_rsvd) {
-		unsigned long i;
+	/*
+	 * A single unmap of a very large device-passthrough mapping can unpin
+	 * hundreds of millions of pages here.  Bound the work per iteration and
+	 * cond_resched() so one VFIO_IOMMU_UNMAP_DMA cannot hold a CPU past the
+	 * soft-lockup watchdog.  Mirrors the pin-side reschedule in commit
+	 * edeca59cb88d2 ("vfio/type1: conditional rescheduling while pinning").
+	 */
+	while (remaining) {
+		unsigned long batch = min(remaining, VFIO_UNPIN_RESCHED_PAGES);
 
-		for (i = 0; i < npage; i++)
-			if (put_pfn(pfn++, dma->prot))
-				unlocked++;
-	} else {
-		put_valid_unreserved_pfns(pfn, npage, dma->prot);
-		unlocked = npage;
+		if (dma->has_rsvd) {
+			unsigned long i;
+
+			for (i = 0; i < batch; i++)
+				if (put_pfn(pfn++, dma->prot))
+					unlocked++;
+		} else {
+			put_valid_unreserved_pfns(pfn, batch, dma->prot);
+			unlocked += batch;
+			pfn += batch;
+		}
+
+		remaining -= batch;
+		cond_resched();
 	}
+
 	if (do_accounting)
 		vfio_lock_acct(dma, locked - unlocked, true);
 

---
base-commit: dc77acfeb979dded39b247b60fef0399536bfa77
change-id: 20260723-vfio-decd86bf3cf6

Best regards,
--  
Sam Crossley <samuelcrossley@gmail.com>

