Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DD148124F;
	Wed,  3 Jun 2026 15:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499941; cv=none; b=Zps1TAZGcsDrs+XKCvNOTwmVxtKlMvOqruCxITlnrctxEPnoxoOdhvCYOabyqFT1PmXUdEMATPSajunDE8L3xSnFLCEj4vfvWyEAc94e6pHxIH5FLtRoPeZUNSnX7NJDdSH++8nt8WME2t+p9xEeT3H/q6Myl6l+99e6n6ORj7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499941; c=relaxed/simple;
	bh=JfxFXwpeEGb9FMwpKPiIAIWIxGYUvx2yf/Ck3Mt8RuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ca7/AvE514eybG4yuwjKFwedoGwL/yY8jH615UcpceJz2v4kYlT0Pw6SMHZ4+Sy4RsRlUS2mirsXlHS2Ns5d5ef++Dm31YDVhGqb4D8xegosSAmoTKzpPaa+i8LHHe7AiyTwwvjdd+qRywMPyXFWq+kfMSm9mn4zcRclAh73IGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PN4Dt1uD; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PN4Dt1uD"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780499932; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=D6ghu2heF624JtfaTXizY9L77UrgY/rsaZWlsUjxjMw=;
	b=PN4Dt1uD9RG1cUF6juvFmtKuLblvlDdt2gE2pArk31El6diSin5HfZDGplMe1hg/lCagA0f2BEB8pdlvgDvtbZ1wE+tEAGE/Bk4aLzbmO/HjvlGkEYr30jKhU/vcLoqDwMm9lRAw6U59MiG6P/T9o7dfh+6Ux/npAEL+zSEKyP8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X47fR3B_1780499929;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X47fR3B_1780499929 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Jun 2026 23:18:49 +0800
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
Subject: [PATCH v3 11/32] iommu/mtk_iommu: implement iova_to_phys_length
Date: Wed,  3 Jun 2026 23:17:43 +0800
Message-ID: <20260603151804.1963871-12-guanghuifeng@linux.alibaba.com>
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

Migrate MediaTek IOMMU to implement iova_to_phys_length, passing through
mapped_length from io-pgtable.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/mtk_iommu.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 2be990c108de..6ca31f8d4d96 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -858,13 +858,16 @@ static int mtk_iommu_sync_map(struct iommu_domain *domain, unsigned long iova,
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
+	pa = dom->iop->iova_to_phys_length(dom->iop, iova, mapped_length);
+	if (pa == PHYS_ADDR_MAX)
+		return PHYS_ADDR_MAX;
+
 	if (IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT) &&
 	    dom->bank->parent_data->enable_4GB &&
 	    pa >= MTK_IOMMU_4GB_MODE_REMAP_BASE)
@@ -1070,7 +1073,7 @@ static const struct iommu_ops mtk_iommu_ops = {
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

