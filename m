Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F6248165B;
	Wed,  3 Jun 2026 15:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499958; cv=none; b=WS/XstrsulpimnEqMej3lgLztydP49CycuH3S6pa/xY1vySF59XaOsm/RS+/phnIHONidfHqpF76APy2qvuUiT3GlOyO6fJKrhcRGdcXm715wCN+Vkc/X2TbEwEcZ9oyXLeV9qL8Ywgi+IhCwT3qA1X6TG2/kGoQkNOItSv/Mhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499958; c=relaxed/simple;
	bh=Eo1T/DdjxK6cr5MBTlk9PUo4KuWE5dzwz16HwzPcZxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S0Oq4TV6Fmh3EBpREGTBrDD0l2hvoTSvt/G+OWg9n1NHppIqSDTj8nHe1pl5Xhno12qCuI9Uej1P4k3ZGfPvwZ8gxBJFwUkNLfu6fhK8RXiXTvmzP52f5aeHPv+uXV346XS/JiUXTFRRyuHl3CKR7L25xsupCWXIpGTye/RrJZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Kylg2zX+; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Kylg2zX+"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780499952; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=HHcwXEJnumwKc2zUUog9MdRhUiRkhNb+QkY/zlqMCrg=;
	b=Kylg2zX+Q49jP7AVIavr2zArzMKJeZ6w2MxZQxExmleun9424V1tEaAyZ16207yIMPfH9mAnyujALDfw4eISSiysZe2Fhv/KGvHv2dGmm8O1QHScUcUpQ8H+CXG+0OhxaLbeXVOo78VlMWEwTKh2HOPjAd91ulwsbFSIZteqr0w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X47fR8Q_1780499948;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X47fR8Q_1780499948 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Jun 2026 23:19:08 +0800
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
Subject: [PATCH v3 30/32] iommu/io-pgtable-arm-v7s: remove deprecated iova_to_phys wrapper
Date: Wed,  3 Jun 2026 23:18:02 +0800
Message-ID: <20260603151804.1963871-31-guanghuifeng@linux.alibaba.com>
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

Remove the iova_to_phys wrapper function and .iova_to_phys assignment
from ARM v7s io-pgtable, as all callers now use iova_to_phys_length.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 62198e31a393..da065747e37c 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -641,18 +641,6 @@ static size_t arm_v7s_unmap_pages(struct io_pgtable_ops *ops, unsigned long iova
 	return unmapped;
 }
 
-static phys_addr_t arm_v7s_iova_to_phys_length(struct io_pgtable_ops *ops,
-						unsigned long iova,
-						size_t *mapped_length);
-
-static phys_addr_t arm_v7s_iova_to_phys(struct io_pgtable_ops *ops,
-					unsigned long iova)
-{
-	phys_addr_t phys = arm_v7s_iova_to_phys_length(ops, iova, NULL);
-
-	return (phys == PHYS_ADDR_MAX) ? 0 : phys;
-}
-
 static phys_addr_t arm_v7s_iova_to_phys_length(struct io_pgtable_ops *ops,
 						unsigned long iova,
 						size_t *mapped_length)
@@ -730,7 +718,6 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
 	data->iop.ops = (struct io_pgtable_ops) {
 		.map_pages	= arm_v7s_map_pages,
 		.unmap_pages	= arm_v7s_unmap_pages,
-		.iova_to_phys	= arm_v7s_iova_to_phys,
 		.iova_to_phys_length	= arm_v7s_iova_to_phys_length,
 	};
 
-- 
2.43.7

