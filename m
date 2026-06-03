Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B573448BD54;
	Wed,  3 Jun 2026 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499955; cv=none; b=lhru5E66DUtbT4p5pEcUBDrR1+RNoNORs0HT6j+zIeB33ZYj9/q//TxLtaukC6Q95D6BedC1NiWOyjviU45/RtI1LawS4P9Dag5SE4AvjqUcNN6g/0fwd9gtjq3RNTkDjPLZwE/CKdwfx3ZkJXJFOZv30W+VuAKn0sh9tpnlqYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499955; c=relaxed/simple;
	bh=dOIhvIj09bSbAHxDeeWgK/ZzYKkMjOrx3T8+F4WlSsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOcA1S91FQ8cg+iQibWOhNaZMkFiA6k7hUuFE0s5votrqFM3WWuX//C8x00jAQwG/EdkmEOOK2t8taNxn0/h2hOy5aCZwghNYTdeCTuKLX90EuZfszaRtKHXD/KjEMjCzhPNrcp+eY3PQjIec1l9ZZdRm8ZfQBzOJVP2aTEmcdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tPNIvZoc; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tPNIvZoc"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780499942; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Zkn8atwigb0RDyBkQZl4U8k5iUnpgoKnP+BxdtigQbU=;
	b=tPNIvZocCmGgTPirhfZyAaDCqo65mWvGZoXWW5oZahDv8iDPKz+ERFwz0+dxtvzopOh7PzBCOqogc4RH3lo0bKyBMDlT24fqZOH+gBVM/BcycmsNSZCW83sXQGVvh28sro6TUrpIN7k36qQwmGFbS5pAEE9oUEr+CU3FVFXZm5s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X47fR6P_1780499940;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X47fR6P_1780499940 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Jun 2026 23:19:00 +0800
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
Subject: [PATCH v3 22/32] iommu/virtio: implement iova_to_phys_length
Date: Wed,  3 Jun 2026 23:17:54 +0800
Message-ID: <20260603151804.1963871-23-guanghuifeng@linux.alibaba.com>
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

Implement iova_to_phys_length for virtio IOMMU driver,
returning the actual PTE mapping size.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/virtio-iommu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 587fc13197f1..b92316257e42 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -912,10 +912,11 @@ static size_t viommu_unmap_pages(struct iommu_domain *domain, unsigned long iova
 	return ret ? 0 : unmapped;
 }
 
-static phys_addr_t viommu_iova_to_phys(struct iommu_domain *domain,
-				       dma_addr_t iova)
+static phys_addr_t viommu_iova_to_phys_length(struct iommu_domain *domain,
+					      dma_addr_t iova,
+					      size_t *mapped_length)
 {
-	u64 paddr = 0;
+	u64 paddr = PHYS_ADDR_MAX;
 	unsigned long flags;
 	struct viommu_mapping *mapping;
 	struct interval_tree_node *node;
@@ -926,6 +927,9 @@ static phys_addr_t viommu_iova_to_phys(struct iommu_domain *domain,
 	if (node) {
 		mapping = container_of(node, struct viommu_mapping, iova);
 		paddr = mapping->paddr + (iova - mapping->iova.start);
+		if (mapped_length)
+			*mapped_length = mapping->iova.last -
+					 mapping->iova.start + 1;
 	}
 	spin_unlock_irqrestore(&vdomain->mappings_lock, flags);
 
@@ -1102,7 +1106,7 @@ static const struct iommu_ops viommu_ops = {
 		.attach_dev		= viommu_attach_dev,
 		.map_pages		= viommu_map_pages,
 		.unmap_pages		= viommu_unmap_pages,
-		.iova_to_phys		= viommu_iova_to_phys,
+		.iova_to_phys_length	= viommu_iova_to_phys_length,
 		.flush_iotlb_all	= viommu_flush_iotlb_all,
 		.iotlb_sync		= viommu_iotlb_sync,
 		.iotlb_sync_map		= viommu_iotlb_sync_map,
-- 
2.43.7

