Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8F2370D56
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427770; cv=none; b=p6Ykf3t88zk6fAUi9ZOW3tTKHYBbE7SbD48DE+NWDQWXoCI4gF6UwP80K0rLK4Y2iIfr4RWDLIB1P+cCyaTzQxVRABrgTPThWXlFEuz0+hqw83Z8cHGjRlbCK9HZiCiEGvr//hgBhk1R9JzghVghZe0kBn1zmxdeE74qxyZOQtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427770; c=relaxed/simple;
	bh=VVIxL7WFu3ypeDcFW8G04axJPx8+slvj9MDcWub/Xh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MWuObhAFjQ8dYJ9LKKk+LwGenubvAFWjZoT/hcnaVyg2VzXUTkmLrHFc+sLQ/9T3ZAfUj+oMcUzfr7EC82LKJwhzFE4lwKzeqO1QNNFOOf5BLNmfqETDJTYObSOLQbr0/E3sGUqWCdoSu/qKawmkd9Za9w0WhUHUvbNaTsdRDfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GL8aQgeX; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GL8aQgeX"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4843e397f74so1114439f8f.1
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 02:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788427767; x=1789032567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yvH8fI4JTMlFPTDgmBGA+15V9z5f5he1swOyshmSQfA=;
        b=GL8aQgeX8wUT3VtGgLJPz699W83TioUIb47/qsqP6Z092u7gvN2rs3FIkadCPp52Uu
         Hu6Cmu4CxfBZOMwGWEkrzHNT04GSmqmvEEdY4K3vfsLvqEF0ntKkxsiDWTEWrQ4N0c72
         2zbxxLU/WY1KmZ3I6TKuQ6nS2LaTB7sHJe6gHzihjTt0bkoTp4MlkGEtU4CLJ/4uuxqG
         bDptW6Fxz3dvhims0Idlh29UNfmz7NtJWWHbC6wX2f072+tF2CVQnjc0O1TvCit+HEYy
         ki8rjkCKSpVArXGvGjhE1MBEEC/p1clAa3/Athtd/k1HoWiwFP6885jRQ+rare0KRcLc
         yAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788427767; x=1789032567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yvH8fI4JTMlFPTDgmBGA+15V9z5f5he1swOyshmSQfA=;
        b=cbsnCh3K3Wyj850CuGcOt6Wct3riymbdtv3251j6qL35fWTR9eqYfd0J1uMvNNQkxI
         qcOug/DkCsjr7jvwd65i55amxl/p15UcRSp+ohS2oDO/e1CbVeXBQGonUKfKtF+WH3oq
         j0ECXewyyeq02tTIpBLqNJMrxAfLlXKsoxnSqxMtNnzLUGCPXmvYWMAAtsmyheVG73it
         QQJUN2S40SCHyZ/bhT8DAmoInMcbU5hMhfqzp7KOxA6XrkTpZB+lBy8NENG3FC1GDHU0
         fmxO/Ktr523Mg8KGPBZbW8BlAeU0BJU5lZi0GCyqPifgI/Q89F4V9BSXrrLJJuiSn6ma
         Ro/g==
X-Gm-Message-State: AFuF++mYz1q2+WFEk5jCAgrPKijedG4sxdVgUjNGacJ5WqhoVCPAlSdy
	yyAkCdfXZoM0jW2Fd0DpqcQ2DbzM8vLwKSRG0eWF7dgB5BzaKTh32n3BBiliHA==
X-Gm-Gg: AYBFou01Q+a82Vlr0jen0vfYwvDl8R2j9C2MqapPzTSFvo/OMfR7SI6zuPTKDYO4hRQ
	89IviOsEnE0Pg0sfaxpi6ww/t2tTjTjtGbBTMkOgyTC1IVafX7Sl7dkoMzjRnYh8SlDFEhhyjFP
	LgnHo7YF0LCWQ0n0IaxxNKBx1v7e/l0F7Iu7Aw37bNeoe5df2LC03EF109IdUAbBU1I0tOk1Y5G
	qffR2Uuedg6L0v4hF6pcs3BedziCYjBQ0Bq1uvqMLMqNid8htO1pIag38J8/SCxOyiLnXRGvOl2
	r4yEiXq0X/6J6h92O7NQXLeotW4xqs1RZ5riK2Pej4GmMVZLNGoW4LVF+rk7W2mC2YzO2GJNtWa
	bEYuqrhwXKM/trEnHUAoXNs+j3r+VNZqcM6agAoNj83R8OXBl3CqqkVQTBl3xs6GBT6TiiuYvc2
	znQ1goaO/J4GTpQlsk8IUtOk06OEbaX46RlJAGdouH3oqmeGw+cCkTdNMTzIWU76+CJEI=
X-Received: by 2002:a05:6000:655:b0:485:8226:c691 with SMTP id ffacd0b85a97d-4858226c9camr2968663f8f.16.1788427766634;
        Thu, 03 Sep 2026 02:29:26 -0700 (PDT)
Received: from SurHub.localdomain ([196.188.114.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448eeae34sm13398522f8f.32.2026.09.03.02.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 02:29:26 -0700 (PDT)
From: Abdifatah Suruur <suruurism@gmail.com>
To: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Alex Williamson <alex@shazbot.org>
Subject: [PATCH] vfio/fsl-mc: keep logical vm_pgoff in MMIO region mmap
Date: Thu,  3 Sep 2026 12:29:22 +0300
Message-ID: <20260903092922.470-1-suruurism@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vfio_fsl_mc_mmap_mmio() overwrites vma->vm_pgoff with the physical
frame number of the MMIO region and passes it to remap_pfn_range().
The VMA is inserted into the device file's mapping->i_mmap interval
tree keyed by vm_pgoff, which VFIO expects to be the logical file
offset: the core links every device mmap to the device inode's
i_mapping precisely so that unmap_mapping_range() can revoke all
mappings associated with a device (see vfio_device_cdev_open()).

With a raw PFN in vm_pgoff the interval tree entry lands in the wrong
coordinate space and unmap_mapping_range() cannot find the VMA,
leaving stale MMIO mappings behind any revocation attempt.  Keep
vm_pgoff in the logical VFIO offset space, as vfio-pci does, and pass
the physical PFN to remap_pfn_range() explicitly.

Fixes: 67247289688d4 ("vfio/fsl-mc: Allow userspace to MMAP fsl-mc device MMIO regions")
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>

---
--- a/drivers/vfio/fsl-mc/vfio_fsl_mc.c
+++ b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
@@ -369,8 +369,7 @@
 	if (!region_cacheable)
 		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);

-	vma->vm_pgoff = (region.addr >> PAGE_SHIFT) + pgoff;
-
-	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
+	return remap_pfn_range(vma, vma->vm_start,
+			       (region.addr >> PAGE_SHIFT) + pgoff,
 			       size, vma->vm_page_prot);
 }
