Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EF548B38D;
	Wed,  3 Jun 2026 15:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499954; cv=none; b=ATARsYTBwApjn3ssbmia6GLMtqSYb7PNAi82dzWGQLOD1vE9548tJSP9paks0p0mXTbOULO3qi7bdM8a3d6uE6BPYqBrPBFB4sBv080f8zkUu8OZH9ID7Cih/qFXvEANhVv+DxmMJz/4W/0hadvxqJk/Zhbl8Gx82s+C4YP4cLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499954; c=relaxed/simple;
	bh=oD1Wr05YIdEtoMugk3QiKxFriD3/ExsFEsiqdk+wNY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oq5OUu19yVBWSLWtxseV9ETSxKpCL3epwJRpB5USWdcGckaUhNs5Nrb5ooo1KTVsQyzeoNW+/+TddRdDsvgm15WNHb5uf6TlsQWGdDcgTOyVDcJlspottGFV0UYJBnZ4PDj6vKBKcx5cIhDubKGwysfH8MVZKCaAuZjXE85wNv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nuodHs74; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nuodHs74"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780499939; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=B2CWGyb/jy+luBGe9CF0J2PFthBHN8proHGbNilHQH0=;
	b=nuodHs74VmMSmlyJUELmAW1VRHGpAm0xsbdIw+ql14KfAuX1t4/mhGfDz9MtZxZqsxroQYBuSjzIU4R0qrLGR3OUz37RMYJqgsMa85x0MNMDX29orf8SbDBu3IMXnps75RrmkXC6Bwgu9Un/9kpg3Nmsw2L7yHf4l4pwzS3ZMY4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X47fR4e_1780499934;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X47fR4e_1780499934 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Jun 2026 23:18:54 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: jgg@ziepe.ca
Cc: adrian.larumbe@collabora.com,
	airlied@gmail.com,
	alex@shazbot.org,
	alikernel-developer@linux.alibaba.com,
	baolu.lu@linux.intel.com,
	boris.brezillon@collabora.com,
	dri-devel@lists.freedesktop.org,
	dwmw2@infradead.org,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	kevin.tian@intel.com,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	liviu.dudau@arm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	oliver.yang@linux.alibaba.com,
	robh@kernel.org,
	robin.murphy@arm.com,
	shiyu.zsq@linux.alibaba.com,
	steven.price@arm.com,
	suravee.suthikulpanit@amd.com,
	tzimmermann@suse.de,
	wei.guo.simon@linux.alibaba.com,
	will@kernel.org,
	xlpang@linux.alibaba.com
Subject: [PATCH v3 16/32] iommu/omap: implement iova_to_phys_length
Date: Wed,  3 Jun 2026 23:17:48 +0800
Message-ID: <20260603151804.1963871-17-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260603151804.1963871-1-guanghuifeng@linux.alibaba.com>
References: <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
 <20260603151804.1963871-1-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement iova_to_phys_length for OMAP IOMMU driver,
returning the actual PTE mapping size.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/omap-iommu.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 8231d7d6bb6a..f4a416326f7c 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1592,15 +1592,16 @@ static void omap_iommu_domain_free(struct iommu_domain *domain)
 	kfree(omap_domain);
 }
 
-static phys_addr_t omap_iommu_iova_to_phys(struct iommu_domain *domain,
-					   dma_addr_t da)
+static phys_addr_t omap_iommu_iova_to_phys_length(struct iommu_domain *domain,
+						  dma_addr_t da,
+						  size_t *mapped_length)
 {
 	struct omap_iommu_domain *omap_domain = to_omap_domain(domain);
 	struct omap_iommu_device *iommu = omap_domain->iommus;
 	struct omap_iommu *oiommu = iommu->iommu_dev;
 	struct device *dev = oiommu->dev;
 	u32 *pgd, *pte;
-	phys_addr_t ret = 0;
+	phys_addr_t ret = PHYS_ADDR_MAX;
 
 	/*
 	 * all the iommus within the domain will have identical programming,
@@ -1609,19 +1610,27 @@ static phys_addr_t omap_iommu_iova_to_phys(struct iommu_domain *domain,
 	iopgtable_lookup_entry(oiommu, da, &pgd, &pte);
 
 	if (pte) {
-		if (iopte_is_small(*pte))
+		if (iopte_is_small(*pte)) {
 			ret = omap_iommu_translate(*pte, da, IOPTE_MASK);
-		else if (iopte_is_large(*pte))
+			if (mapped_length)
+				*mapped_length = IOPTE_SIZE;
+		} else if (iopte_is_large(*pte)) {
 			ret = omap_iommu_translate(*pte, da, IOLARGE_MASK);
-		else
+			if (mapped_length)
+				*mapped_length = IOLARGE_SIZE;
+		} else
 			dev_err(dev, "bogus pte 0x%x, da 0x%llx", *pte,
 				(unsigned long long)da);
 	} else {
-		if (iopgd_is_section(*pgd))
+		if (iopgd_is_section(*pgd)) {
 			ret = omap_iommu_translate(*pgd, da, IOSECTION_MASK);
-		else if (iopgd_is_super(*pgd))
+			if (mapped_length)
+				*mapped_length = IOSECTION_SIZE;
+		} else if (iopgd_is_super(*pgd)) {
 			ret = omap_iommu_translate(*pgd, da, IOSUPER_MASK);
-		else
+			if (mapped_length)
+				*mapped_length = IOSUPER_SIZE;
+		} else
 			dev_err(dev, "bogus pgd 0x%x, da 0x%llx", *pgd,
 				(unsigned long long)da);
 	}
@@ -1723,7 +1732,7 @@ static const struct iommu_ops omap_iommu_ops = {
 		.attach_dev	= omap_iommu_attach_dev,
 		.map_pages	= omap_iommu_map,
 		.unmap_pages	= omap_iommu_unmap,
-		.iova_to_phys	= omap_iommu_iova_to_phys,
+		.iova_to_phys_length	= omap_iommu_iova_to_phys_length,
 		.free		= omap_iommu_domain_free,
 	}
 };
-- 
2.43.7

