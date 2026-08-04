Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C99473C76
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 16:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862685; cv=none; b=JMTTsULj7ec5qEVGmacS7fsGr9fudlClcM7LkrG82r//UVGyFA4oVBDlM6RMCCxQCF/IEG4Gtx7LJluN+p/ideLB4W9QOCRnOnFzh8KL4M+xrra886Cq/npU24K8zndSKmSGb4GnAAuaZIkIu1ixAO36bg609A8Z4+sR9WGXHb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862685; c=relaxed/simple;
	bh=6li21QyU3wArl3V+Se5T/nBqfh7ZCtYq2V7QJWyM2nM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N8hfpGSTLe800Zw/KoAbc5sQwK1jHyQRVTJpFkulEVuPJ1UMkdrgYDN1sCups7yNVTr0elCdLDkgM2MakWnYkMk0tyUT99Wr2j7F5L+JhTbvWmtk7XSv5UAx6i+uiZwL+PH+ZRpCGPEwsAj/vp9i94kP5EgkCIz4shS4VqK5YNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pkV5fVWV; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pkV5fVWV"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8484ba00601so34434b3a.1
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 09:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785862675; x=1786467475; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=81ujjM9tAYTzf1uVVWJxqvr+iuiDfjCNyAT1Toqm0uE=;
        b=pkV5fVWVR5pCctrC0CrbeyMa5aAFsSBZJkmDtfOlhtkkEuHXlDvPPlcmWvVd/sa7aE
         6rqKCAQp6GnVLN62iRMYVf8huzZykoEGJDUkDua3ISIP3jXM1JzY3bjIkUvCK6esN6Hr
         eZaJklnjFkjEZlawCDh3SLxczC8LP8XApzapJaLDRsEMCG6MPlWEMrAOwFJ2vFFe+ei/
         E91OaO6XJ6yrPMSsnm0GRUuUhNdyMM4le+rZlFG3t39VN2aDeNdpPTF1krznEFmQz/AB
         PdtMVvK32r2dQZFh0kXi4pxLdVififx2cvaBeUKUpWH7o8YBTBPk/PTB1ZUGDdBfQxjF
         Nmsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785862675; x=1786467475;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=81ujjM9tAYTzf1uVVWJxqvr+iuiDfjCNyAT1Toqm0uE=;
        b=Bk/OXqFUHcPJ6cpQQbZ8tvyIt5qXyblQtQnLXYf6ieC5OaQbFgi6vI76JyiIEplnEd
         moSAVmvHCn8kdXm4Nkw4yIeFDQNBveJ9Y/gmSywM0CJWYRIZq6Vj74r5hgGkT2N15NbS
         i86bDmbYRrYdJogRxwzC0Dqb/MyqPb1p3G/aKfkACHqXv67mluPodt6NqufSmX5EgR3X
         D0JExDxsyF4XUMCfGQMVQdKPBbQlZpxc2TVYPtl5RVmxnqNnyOgONmkRcWPOZUiZP/L4
         dXGZB0n0wm6D0xuk49mTWn2a6kzA1O9HvkDlZAU5twS67lpNjiueNYOEuP4itnc6vB0b
         ixmw==
X-Gm-Message-State: AOJu0Yy9/jUiOWj99LZlytCQ+TbQBoEFZO0nkJvcWry6rsFWk/AxSVWl
	MoQSiA0q9mF8XoSJx0wAoPkAjv5mG25iOQNUU0mEwpYWvsSC3sSSHnQdK8fgyVJOIe1SfdUxZPt
	lBFSoqRE28IKl23my7FrLC5K6KtdgNxhJu9p5wbeCfmcuWYr76jhnIO+U1fhH56UFmhRUaQIaHu
	3uCqZuOdrw81CnVjJtE0kXKmCe7+ik8aEfDE7IyV0TFEYkSi8xRSBWEg==
X-Received: from dlbpv2.prod.google.com ([2002:a05:7023:902:b0:13c:eacb:77ba])
 (user=aaronlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:138e:b0:3c3:8d4c:6679 with SMTP id adf61e73a8af0-3cb85e6afddmr257106637.20.1785862674516;
 Tue, 04 Aug 2026 09:57:54 -0700 (PDT)
Date: Tue,  4 Aug 2026 16:57:45 +0000
In-Reply-To: <20260804165748.1060476-1-aaronlewis@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804165748.1060476-1-aaronlewis@google.com>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260804165748.1060476-2-aaronlewis@google.com>
Subject: [PATCH v2 1/4] vfio: selftests: Assert the region was unmapped in iommu_unmap()
From: Aaron Lewis <aaronlewis@google.com>
To: kvm@vger.kernel.org
Cc: alex@shazbot.org, dmatlack@google.com, jgg@nvidia.com, 
	Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Add an assertion in iommu_unmap() to verify that the region was fully
unmapped. Centralizing this check simplifies the selftests by removing
the need for individual tests to handle the verification themselves.

Suggested-by: David Matlack <dmatlack@google.com>
Signed-off-by: Aaron Lewis <aaronlewis@google.com>
---
 .../selftests/vfio/lib/include/libvfio/iommu.h        |  5 ++++-
 tools/testing/selftests/vfio/vfio_dma_mapping_test.c  | 11 ++---------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
index e9a3386a4719..5c77875240f4 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
@@ -46,7 +46,10 @@ int __iommu_unmap(struct iommu *iommu, struct dma_region *region, u64 *unmapped)
 
 static inline void iommu_unmap(struct iommu *iommu, struct dma_region *region)
 {
-	VFIO_ASSERT_EQ(__iommu_unmap(iommu, region, NULL), 0);
+	u64 unmapped;
+
+	VFIO_ASSERT_EQ(__iommu_unmap(iommu, region, &unmapped), 0);
+	VFIO_ASSERT_EQ(unmapped, region->size);
 }
 
 int __iommu_unmap_all(struct iommu *iommu, u64 *unmapped);
diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
index 7d0de8c79de1..1b90441644a2 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
@@ -138,7 +138,6 @@ TEST_F(vfio_dma_mapping_test, dma_map_unmap)
 	struct dma_region region;
 	struct iommu_mapping mapping;
 	u64 mapping_size = size;
-	u64 unmapped;
 	int rc;
 
 	region.vaddr = mmap(NULL, size, PROT_READ | PROT_WRITE, flags, -1, 0);
@@ -190,9 +189,7 @@ TEST_F(vfio_dma_mapping_test, dma_map_unmap)
 	}
 
 unmap:
-	rc = __iommu_unmap(self->iommu, &region, &unmapped);
-	ASSERT_EQ(rc, 0);
-	ASSERT_EQ(unmapped, region.size);
+	iommu_unmap(self->iommu, &region);
 	printf("Unmapped IOVA 0x%lx\n", region.iova);
 	ASSERT_NE(0, __to_iova(self->device, region.vaddr, NULL));
 	ASSERT_NE(0, iommu_mapping_get(device_bdf, region.iova, &mapping));
@@ -260,15 +257,11 @@ FIXTURE_TEARDOWN(vfio_dma_map_limit_test)
 TEST_F(vfio_dma_map_limit_test, unmap_range)
 {
 	struct dma_region *region = &self->region;
-	u64 unmapped;
-	int rc;
 
 	iommu_map(self->iommu, region);
 	ASSERT_EQ(region->iova, to_iova(self->device, region->vaddr));
 
-	rc = __iommu_unmap(self->iommu, region, &unmapped);
-	ASSERT_EQ(rc, 0);
-	ASSERT_EQ(unmapped, region->size);
+	iommu_unmap(self->iommu, region);
 }
 
 TEST_F(vfio_dma_map_limit_test, unmap_all)
-- 
2.55.0.654.g21b8a5bc05-goog

