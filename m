Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425064;
	b=PtJ11extlK9VpTbYTaIsZrIDYtia1eHq8cm/ZNOcVFlGQXOF0zk4x7Hoqap3fvqKRD24
	 bruJI/P3fK9eHDj/27b//sPGkjClKHuiOCGnI+THszYW5++QUSkfC73DECTPsoyC+bHyV
	 1kCH8+r9mPm/zwtF9C85TkeUAGQM45UHWXBJor4AZl1qUOydmENRUI8Qb7sqPkpXBrZfq
	 yxqA50OMQggVjyRBVYK+LZGP91hAqwWU9RD9RGV84oYrldn5yj5TRsuEr6FzTuz4754cx
	 rSypxXpwH8JACPD9q1GM/Rqlb4aRuf1j0x+l8rsa6S/74+ZSTLVB2CU0igcNxez171A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425064;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=GZrkVSPnOLbwhYzrPljddPiSGOm8sAR0nI/sR9X9KfM=;
	b=EJFX9BDqpT/hJ/0yQOjft/ecgnBakuewynUwIrM3KbjKtOYxfK1W+WQau49019qsDMdj
	 u7UvzyOHw62MJRXGitf8TCsU/N3pU2/BQqW31AzHghgQffaG5IlV0Bbs7lCs1HVO6L8ks
	 kqhpik/00NYhI4x6fvnXr3io3urYgy7TIK9f9Gjk4A23Ba3K4D0wdXO7ZxLRDWv5q2Rf/
	 wCLh3b65h4DUcykKkJoeEsBmczdoRx5rZZTDFsQkR1tIijfnjWg85GwbV/lyGITFdTpCv
	 VvdtBSjm38K9/16yhk3qVCx7sHumprgwBiCO16A8Rw1hqnKLO3ZDjBXGHXhzaG+dVtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=C8mJidRl;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C9C606B5E2
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 19:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66C9C606B5E2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=C8mJidRl
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4c467e19391so5248705b6e.3
        for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 11:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794425062; x=1795029862; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GZrkVSPnOLbwhYzrPljddPiSGOm8sAR0nI/sR9X9KfM=;
        b=C8mJidRloxlSfZbT6vz1c4ZNIn+miuKpjO2mPIxJ1PT/KnTuIZ3U1UGeEJKxQl3bI0
         EYvIa2/QIpzwaxDrjivW3Y73fFtq6G/Ska0GFJhtdxumBfEPZd3qejbghifrtttYw90x
         rf47GmsJUp7ipGL8m72MwqJMJpHvg5RRshIDEpbZm6nttL9298GyyRtlK2XUEDzueh6C
         //8cVyO1I6cqy0k+v2dqglVMOUdferTx8y0HlXQzJfwcs+tf/QI7NpPoeH3Fm63HlHSe
         lA4lKR+ySUQSFGM15MKxl6yKTjwAk+FRtubeC/4iTVxNKZSGc3H7e9C52oxp102WBmUb
         PkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794425062; x=1795029862;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GZrkVSPnOLbwhYzrPljddPiSGOm8sAR0nI/sR9X9KfM=;
        b=vWQazuq+q/Y8OzxZDKm2HLa2cVxRt8iHjKn1+ENzIlWIkPk4vIb2jPBZLI6xRuJFFS
         CYueg4oPUlJe3A9fNMfZCbxaVgreK0n6u+ZpAXd0QKPFWYFcRmCcOLH4o+Js3lf0a1Sr
         v80GxBvDmFKeS7thOs58q9eW6rf0zIJOrEoJ7qHGca/bulQl/bmRHfD/zMrMIbscLEeg
         rcwXJP/7I1iLW0bbZxpXKyoLLxHp0OPDfH+kXHctU9ArsvsY7sjVpP0GFPB39upI4fub
         xc87IzqCYzvnmqceB2JHS6d/fQdWVnF2jOtpoiYHWCLB+pkCk1Xgomjtk5tTzCAaeAez
         9IdA==
X-Forwarded-Encrypted: i=1; AL+hErEzkqzf96JJpsTSt1gzx4kn02FarSklgovaW2oQ1AhPTZy6t/Xvwy9R76SqS05wcxAMyiM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9u2wgBHNZHJsrDmwdU+juMpOWNjUIQojtRsHKKtM+rvwApfK9Y
	ThmImNoeNeDJ18qY7U3Difuop7wjPozDCtFiIDrmPl40Li14f8iOFRyhWlX9A9+F+TECPBZs5tX
	SUfwXxeQpPxOyBQ==
X-Received: from ilbec1.prod.google.com ([2002:a05:6e02:4701:b0:527:120b:a51d])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:191f:b0:53f:3c0e:c74b with SMTP id 5614622812f47-56b93447ed4mr3152606b6e.9.1794425061950;
 Wed, 11 Nov 2026 11:24:21 -0800 (PST)
Date: Wed, 11 Nov 2026 19:24:09 +0000
In-Reply-To: <20261111192411.4133780-1-dmatlack@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261111192411.4133780-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261111192411.4133780-6-dmatlack@google.com>
Subject: [RFC PATCH 5/7] vfio: selftests: Add iommu_map_file() helper
From: David Matlack <dmatlack@google.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org
Cc: Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, David Matlack <dmatlack@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, Matt Evans <mattev@meta.com>, 
	Matt Evans <matt@ozlabs.org>, Mina Almasry <almasrymina@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Add iommu_map_file() and __iommu_map_file() to map a file descriptor
(such as a memfd or VFIO PCI dma-buf) into an iommufd IOAS via
IOMMU_IOAS_MAP_FILE. Also skip regions without a host virtual address in
__iommu_hva2iova(), since file-backed DMA mappings do not require one.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../vfio/lib/include/libvfio/iommu.h          |  9 ++++++
 tools/testing/selftests/vfio/lib/iommu.c      | 29 +++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
index e9a3386a4719..2b39c49e66da 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
@@ -42,6 +42,15 @@ static inline void iommu_map(struct iommu *iommu, struct dma_region *region)
 	VFIO_ASSERT_EQ(__iommu_map(iommu, region), 0);
 }
 
+int __iommu_map_file(struct iommu *iommu, int fd, u64 file_offset,
+		     struct dma_region *region);
+
+static inline void iommu_map_file(struct iommu *iommu, int fd, u64 file_offset,
+				  struct dma_region *region)
+{
+	VFIO_ASSERT_EQ(__iommu_map_file(iommu, fd, file_offset, region), 0);
+}
+
 int __iommu_unmap(struct iommu *iommu, struct dma_region *region, u64 *unmapped);
 
 static inline void iommu_unmap(struct iommu *iommu, struct dma_region *region)
diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/selftests/vfio/lib/iommu.c
index b6f3c5c84e01..ba602685f892 100644
--- a/tools/testing/selftests/vfio/lib/iommu.c
+++ b/tools/testing/selftests/vfio/lib/iommu.c
@@ -71,6 +71,9 @@ int __iommu_hva2iova(struct iommu *iommu, void *vaddr, iova_t *iova)
 	struct dma_region *region;
 
 	list_for_each_entry(region, &iommu->dma_regions, link) {
+		if (!region->vaddr)
+			continue;
+
 		if (vaddr < region->vaddr)
 			continue;
 
@@ -149,6 +152,32 @@ int __iommu_map(struct iommu *iommu, struct dma_region *region)
 	return 0;
 }
 
+int __iommu_map_file(struct iommu *iommu, int fd, u64 file_offset,
+		     struct dma_region *region)
+{
+	struct iommu_ioas_map_file args = {
+		.size = sizeof(args),
+		.flags = IOMMU_IOAS_MAP_READABLE |
+			 IOMMU_IOAS_MAP_WRITEABLE |
+			 IOMMU_IOAS_MAP_FIXED_IOVA,
+		.ioas_id = iommu->ioas_id,
+		.fd = fd,
+		.start = file_offset,
+		.length = region->size,
+		.iova = region->iova,
+	};
+
+	if (!iommu->iommufd)
+		return -EOPNOTSUPP;
+
+	if (ioctl(iommu->iommufd, IOMMU_IOAS_MAP_FILE, &args))
+		return -errno;
+
+	list_add(&region->link, &iommu->dma_regions);
+
+	return 0;
+}
+
 static int __vfio_iommu_unmap(int fd, u64 iova, u64 size, u32 flags, u64 *unmapped)
 {
 	struct vfio_iommu_type1_dma_unmap args = {
-- 
2.56.0.567.gdb80ae8cd5-goog

