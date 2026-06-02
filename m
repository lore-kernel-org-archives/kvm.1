Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF173D905C;
	Tue,  2 Jun 2026 10:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780397219; cv=none; b=oCgplQP8hTSB5wpglXnwDJqbFWQBbz9KmlBqbBJ0eFSewk2YmNm06gobw+iwLpXlF5ujBMNKks2BUI1MEvakptpYd9EPhHxFXWYaEDjIRW7RVacNSOjgHDpR3aktaE3C++B9H+fry42HzjOewyaAxwpXTk3xPjOazVb8aV8Rof0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780397219; c=relaxed/simple;
	bh=jQkq4FgBd7u+vksQWF3M4XMjZpGjjgOdbzFJyPfP4h8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTmwN1SjWV1fA9K1aq3T+qR+To/bOcB5T+jc4imTm3m629TagLfg3eF5DM5bulQmak4TcAmLDRqgaB7/NEnawXexCCkcufNDslrzUEfT6LEyD2W3ghwThofiXkj0nFWnjrAWqVXKmF4lwv2e3kfavH+pPIzvv5YBPC4Ha8U0KL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nwdEvE9S; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nwdEvE9S"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780397215; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=/s0JwaJLS0ug4dMnq5/oVetvw4KKwU6QXk7J9Nngu08=;
	b=nwdEvE9SLC/fhdEu7wyY3eXD/l4E3+qfMXrhDyiXkjNUte061UQLjim2SIacUZR5eioHcvJeYVJYPmvG8fopPlXNVqZG/AuLJdLubJRdZI2jPSY8d0ZdAOBY2VAATCenzcfd5h3ZIvkxQBPVQIxDkqD0xMNjWZZEw8LzjK9fZbU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X44E93R_1780397213;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X44E93R_1780397213 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Jun 2026 18:46:53 +0800
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
Subject: [PATCH v2 06/30] iommu/arm-smmu-v3: implement iova_to_phys_length
Date: Tue,  2 Jun 2026 18:46:13 +0800
Message-ID: <20260602104637.1219810-7-guanghuifeng@linux.alibaba.com>
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

Migrate ARM SMMUv3 to implement iova_to_phys_length, calling
ops->iova_to_phys_length on the io-pgtable layer.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e8d7dbe495f0..69fb7ce74681 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4069,14 +4069,18 @@ static void arm_smmu_iotlb_sync(struct iommu_domain *domain,
 }
 
 static phys_addr_t
-arm_smmu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
+arm_smmu_iova_to_phys_length(struct iommu_domain *domain, dma_addr_t iova,
+			     size_t *mapped_length)
 {
 	struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
 
+	if (mapped_length)
+		*mapped_length = 0;
+
 	if (!ops)
-		return 0;
+		return PHYS_ADDR_MAX;
 
-	return ops->iova_to_phys(ops, iova);
+	return ops->iova_to_phys_length(ops, iova, mapped_length);
 }
 
 static struct platform_driver arm_smmu_driver;
@@ -4396,7 +4400,7 @@ static const struct iommu_ops arm_smmu_ops = {
 		.unmap_pages		= arm_smmu_unmap_pages,
 		.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
 		.iotlb_sync		= arm_smmu_iotlb_sync,
-		.iova_to_phys		= arm_smmu_iova_to_phys,
+		.iova_to_phys_length	= arm_smmu_iova_to_phys_length,
 		.free			= arm_smmu_domain_free_paging,
 	}
 };
-- 
2.43.7

