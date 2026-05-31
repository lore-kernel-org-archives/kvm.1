Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EC92C11EE;
	Sun, 31 May 2026 09:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780220219; cv=none; b=KOgSA7ThKW8WNgmuk7xIS9+jnsY/OzZqm+/lHJFhpzCuZM0odC/I/Arl0lN8LFkJsl0FAEyPnJrGSPRWX3Aum8YhhP6L0A4Ca0arzJIe30JueSq6IcnLvZG1/xK+l4x0ViHQu48bfsRt0mexkp2XNYShm5CSAWX7nuJ7/9W317M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780220219; c=relaxed/simple;
	bh=MWe9/oEgZRQ7xd0rGrh+IR3Ep50p/ztOH/UAyNpyqq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PphzIZdjyNURUQUCY7XoOt194e2fWvzF6PRdljgJkz3yBwO24u6q3l/097gI3pQJq1ZOA9RjdbzeSDpjJa/sPzhTanRsPY+tOOXrHKMt+DgAKXDEF94G89kKoadYMcGXnUuQLuVN1ZMPF5LoVxWO7wsox2rSf1PN7NtTbGu0J4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oqyvyY6M; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oqyvyY6M"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780220209; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=BqI3wj50bY1yFeJVxmRBlmJ+T2V4ZAm9w/2StB4gVpI=;
	b=oqyvyY6M5uvxKe31topHX+dZz1vhgOhSYxSg+cmFTFJxOeoYg5GR0YoItqlFJG9xdGbq7K6QcuBAXdDYgn2dVrXu1Dsnf0tSwe3mROZmLv8B2I5aiAVJX8V2vX7DnPiEezCl/5u8FNG9XdhEopkTPFtUbFivyiwd1uQ3CCJZ6k8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=27;SR=0;TI=SMTPD_---0X3tRVoG_1780220206;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X3tRVoG_1780220206 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 31 May 2026 17:36:47 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: boris.brezillon@collabora.com,
	robh@kernel.org,
	steven.price@arm.com,
	adrian.larumbe@collabora.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	liviu.dudau@arm.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	alex@shazbot.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com,
	suravee.suthikulpanit@amd.com,
	dwmw2@infradead.org
Cc: xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com,
	shiyu.zsq@linux.alibaba.com,
	wei.guo.simon@linux.alibaba.com
Subject: [PATCH 1/9] iommu: introduce iova_to_phys_length in iommu_domain_ops
Date: Sun, 31 May 2026 17:36:29 +0800
Message-ID: <20260531093637.3893199-2-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
References: <20260529115116.GR2487554@ziepe.ca>
 <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add iova_to_phys_length callback to struct iommu_domain_ops alongside
the existing iova_to_phys. The new callback returns both the physical
address and the PTE mapping page size in a single page table walk.

Add iommu_iova_to_phys_length() core function that:
- Checks ops->iova_to_phys_length first (preferred path)
- Falls back to ops->iova_to_phys for unmigrated drivers

This enables callers like VFIO to efficiently traverse IOVA space
by actual mapping granularity instead of fixed PAGE_SIZE steps.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Acked-by: Shiqiang Zhang <shiyu.zsq@linux.alibaba.com>
Acked-by: Simon Guo <wei.guo.simon@linux.alibaba.com>
---
 drivers/iommu/iommu.c | 34 ++++++++++++++++++++++++++++++++--
 include/linux/iommu.h |  9 +++++++++
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d1a9e713d3a0..43323229a1df 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2545,15 +2545,45 @@ void iommu_detach_group(struct iommu_domain *domain, struct iommu_group *group)
 }
 EXPORT_SYMBOL_GPL(iommu_detach_group);
 
-phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
+/**
+ * iommu_iova_to_phys_length - Translate IOVA and return mapping page size
+ * @domain: IOMMU domain to query
+ * @iova: IO virtual address to translate
+ * @mapped_length: Output parameter for the PTE page size (e.g. 4KB/2MB/1GB)
+ *
+ * Like iommu_iova_to_phys() but additionally returns the page size of the
+ * PTE mapping at @iova through @mapped_length.
+ *
+ * Return: The physical address for the given IOVA, or 0 if no translation.
+ */
+phys_addr_t iommu_iova_to_phys_length(struct iommu_domain *domain,
+				       dma_addr_t iova,
+				       size_t *mapped_length)
 {
+	if (mapped_length)
+		*mapped_length = 0;
+
 	if (domain->type == IOMMU_DOMAIN_IDENTITY)
 		return iova;
 
 	if (domain->type == IOMMU_DOMAIN_BLOCKED)
 		return 0;
 
-	return domain->ops->iova_to_phys(domain, iova);
+	if (domain->ops->iova_to_phys_length)
+		return domain->ops->iova_to_phys_length(domain, iova,
+							mapped_length);
+
+	/* Fallback to legacy iova_to_phys without length info */
+	if (domain->ops->iova_to_phys)
+		return domain->ops->iova_to_phys(domain, iova);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iommu_iova_to_phys_length);
+
+phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
+{
+	return iommu_iova_to_phys_length(domain, iova, NULL);
 }
 EXPORT_SYMBOL_GPL(iommu_iova_to_phys);
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e587d4ac4d33..19da84c2922c 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -747,6 +747,9 @@ struct iommu_ops {
  *                         invalidation requests. The driver data structure
  *                         must be defined in include/uapi/linux/iommufd.h
  * @iova_to_phys: translate iova to physical address
+ * @iova_to_phys_length: translate iova to physical address and additionally
+ *                       return the page size of the PTE mapping at @iova
+ *                       through @mapped_length.
  * @enforce_cache_coherency: Prevent any kind of DMA from bypassing IOMMU_CACHE,
  *                           including no-snoop TLPs on PCIe or other platform
  *                           specific mechanisms.
@@ -776,6 +779,9 @@ struct iommu_domain_ops {
 
 	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain,
 				    dma_addr_t iova);
+	phys_addr_t (*iova_to_phys_length)(struct iommu_domain *domain,
+					    dma_addr_t iova,
+					    size_t *mapped_length);
 
 	bool (*enforce_cache_coherency)(struct iommu_domain *domain);
 	int (*set_pgtable_quirks)(struct iommu_domain *domain,
@@ -930,6 +936,9 @@ extern ssize_t iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 			    struct scatterlist *sg, unsigned int nents,
 			    int prot, gfp_t gfp);
 extern phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova);
+extern phys_addr_t iommu_iova_to_phys_length(struct iommu_domain *domain,
+					      dma_addr_t iova,
+					      size_t *mapped_length);
 extern void iommu_set_fault_handler(struct iommu_domain *domain,
 			iommu_fault_handler_t handler, void *token);
 
-- 
2.43.7

