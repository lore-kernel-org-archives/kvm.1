Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B743B3E1718;
	Tue,  2 Jun 2026 10:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780397231; cv=none; b=f3b7ZY0xabrhHJ/OhBTv1yxPDpMeDLOvmbDgJIZACZJSI/5jEhU3cwoYZR0n15wxKMKgXnTYMra5bPJaO/MhJe6K50xlDiQQIu05X7xs87P2BN+rHYRb09B+6An6U4QAEcRRNhk8JH8xgcRgXzzJss3/eOqmIvQD9clTB0S0F4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780397231; c=relaxed/simple;
	bh=TD9rxeGZm0DOZNpwQ3c09uwLrXwwMws9hNV238491D8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ek3nGFgr3YD1xGOBgwh/IW4xw6mZY1k62ykEeoYzyBZhe8KMGyp2CJwrJxR2K3HdN8zuaop6SL85MWMlxupp8FbrFAp1d1dG2zDkGds6ZmQsH0byMsUeYk37IHzqjf81cbvMLbRKUFEmGYstP3w+DI+XDZCqFr0vBx+uJGIL0Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=R4sTV9Gy; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="R4sTV9Gy"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780397224; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=U2FkFXQRJe1ip/Bfwjl6wzc4k8wooDcGScTFrXf8jIU=;
	b=R4sTV9GyUbUBKBBHLtVN3dZK2qR/lN5NwgKGofU2SrOczhneET2K3VoD8AUVhnGLWiZOSeQZSXLPk5b6tYBrKcjyCThp/m7nhjVxbsI5+M0tV6UVE2IKnh6YxHX04YK3luY2eO7osNM5GB9RYB2r4eHECtLwOGnxUTtRoQB/NTI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X44E94h_1780397218;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X44E94h_1780397218 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Jun 2026 18:46:58 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: adrian.larumbe@collabora.com,
	airlied@gmail.com,
	alex@shazbot.org,
	baolu.lu@linux.intel.com,
	boris.brezillon@collabora.com,
	dri-devel@lists.freedesktop.org,
	dwmw2@infradead.org,
	iommu@lists.linux.dev,
	jgg@ziepe.ca,
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
Cc: alikernel-developer@linux.alibaba.com
Subject: [PATCH v2 11/30] iommu/mtk_iommu: implement iova_to_phys_length
Date: Tue,  2 Jun 2026 18:46:18 +0800
Message-ID: <20260602104637.1219810-12-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
References: <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate MediaTek IOMMU to implement iova_to_phys_length, passing through
mapped_length from io-pgtable.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/mtk_iommu.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 2be990c108de..58125f029214 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -858,13 +858,19 @@ static int mtk_iommu_sync_map(struct iommu_domain *domain, unsigned long iova,
 	return 0;
 }
 
-static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
-					  dma_addr_t iova)
+static phys_addr_t mtk_iommu_iova_to_phys_length(struct iommu_domain *domain,
+					  dma_addr_t iova, size_t *mapped_length)
 {
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
 	phys_addr_t pa;
 
-	pa = dom->iop->iova_to_phys(dom->iop, iova);
+	if (mapped_length)
+		*mapped_length = 0;
+
+	pa = dom->iop->iova_to_phys_length(dom->iop, iova, mapped_length);
+	if (pa == PHYS_ADDR_MAX)
+		return PHYS_ADDR_MAX;
+
 	if (IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT) &&
 	    dom->bank->parent_data->enable_4GB &&
 	    pa >= MTK_IOMMU_4GB_MODE_REMAP_BASE)
@@ -1070,7 +1076,7 @@ static const struct iommu_ops mtk_iommu_ops = {
 		.flush_iotlb_all = mtk_iommu_flush_iotlb_all,
 		.iotlb_sync	= mtk_iommu_iotlb_sync,
 		.iotlb_sync_map	= mtk_iommu_sync_map,
-		.iova_to_phys	= mtk_iommu_iova_to_phys,
+		.iova_to_phys_length = mtk_iommu_iova_to_phys_length,
 		.free		= mtk_iommu_domain_free,
 	}
 };
-- 
2.43.7

