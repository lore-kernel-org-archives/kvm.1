Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7818648BD4A;
	Wed,  3 Jun 2026 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499955; cv=none; b=L81VxwY/3tu8Msuo6J8a5u9O12zIts3VmgWzhx37D1j5XSSX/1TO1FkWoW9OrnHt3LcUg0OjowuKvKEsUlzVRLktUvjcGeupEEPShrey7VRmw1xaFuI5FjDKM5UEPwlVpinY/uK+jfG+1YhbiOACT42LFoB+B20rFanlBcUQzq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499955; c=relaxed/simple;
	bh=lI3x7qiBpStf7+riMLkavf19/hS8Q6Sn6QyC7laDlJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pWTOqRbZlxrpKuCQbS8qqFvY/3rGJr9ZWAkoL+34WazndFn5Uspg7pg9aVHyTlfejoi/t3kMXI+XOSJWKewPbrfbnJYcDGoK9WOHyR3c/WEB0GTvCphpP86pSGl5LM9qTvaSwtWu+wj0NnoSYdTveJffqnlAvC11hg40qyMor2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dmooYd3I; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dmooYd3I"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780499948; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=FtoAZ4ObIrgN8RB/Z4MrgWEyJCArPPBpz4yofnEwwtU=;
	b=dmooYd3IjVvfRFdzF9y7M6tE2IJIvIn5qZ8dqr2paB1d9/qTBBEsVk5hFyqZVHeo2yTmyMt+DJCHatfouNy/Y3p67MXNITNs6WMWeINy2onH7B+M0HMfFlzEb2LglYhqzkYS99Z1Kn/nK2CbRnUiJfaZgYCqEMsMg+As53AaiIY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X47fR7M_1780499944;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X47fR7M_1780499944 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Jun 2026 23:19:04 +0800
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
Subject: [PATCH v3 26/32] drm/panfrost: switch to iova_to_phys_length
Date: Wed,  3 Jun 2026 23:17:58 +0800
Message-ID: <20260603151804.1963871-27-guanghuifeng@linux.alibaba.com>
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

Migrate panfrost_mmu to use ops->iova_to_phys_length(ops, iova, NULL)
instead of the deprecated ops->iova_to_phys.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 4a3162c3b659..aa0bc82deaf6 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -514,7 +514,7 @@ void panfrost_mmu_unmap(struct panfrost_gem_mapping *mapping)
 
 		if (bo->is_heap)
 			pgcount = 1;
-		if (!bo->is_heap || ops->iova_to_phys(ops, iova)) {
+		if (!bo->is_heap || ops->iova_to_phys_length(ops, iova, NULL) != PHYS_ADDR_MAX) {
 			unmapped_page = ops->unmap_pages(ops, iova, pgsize, pgcount, NULL);
 			WARN_ON(unmapped_page != pgsize * pgcount);
 		}
-- 
2.43.7

