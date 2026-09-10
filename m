Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0C5453A5E
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 15:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789054421; cv=none; b=eWWGHxYhTuY/UPfIKUujNoIdspXgmVYkNDtVlySCDFkh+neyfl4UjKjHjqsMqKFNzZbwDsnW4+bVxEj1rCcEWqw6hsmBViG2u9y3xEYjXrFgM9ai/YZTWj1+607M6cH5cA0FcN5TwtFrX+4rbOEL9+l9Lr6SMoOMYE8TnER35Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789054421; c=relaxed/simple;
	bh=hy0dd1q2f2E3BbEpu8udUZuLbqxgLB6KtGFTgEwJ6HU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qYzVZwB4LmhMf02PcweV+yVG55gosZecisIeSidRFNnyguzGAv/59IXas1VLiQEt5wzKnKmZ0yFyu3m6HmnB2pM4AJ1CsuVW/+nH4YbWVh853k4L8AF/yKqsRbWWSdBhIR4haj8bwk0kmXpuImhWnccgWl08e4Jkxp+Om9Ms9EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RQGaBlBv; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RQGaBlBv"
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-6b361b477f1so4481842eaf.2
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 08:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789054419; x=1789659219; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EP9J7JZjaPg+IADmoZM323AzSWYVeVHsxsO0Bf4H8W8=;
        b=RQGaBlBvDcT88PT2peu6McnjN2Ha15KWwVigTD0FMIUTodw88hkIMD8KRKfUnDMan2
         xtqY8WeGw7t69UuGzHmITBLqVLCIgdjTa4XTKgeyPgJoIw/8tDlBCWo2miVc33D9iH+f
         4TG6wrKZvfDzj7WgimQAJG3sTim5MmdIUP8ekPxki+/Sgfe8ePqiyIaa6x4lwkHIuLFf
         Uo8UZmcbHJpOlN5hLOKBHZxrBflRxwaznHJZuw2DML+gPZUGBji7GPFHz+rVymNsWWIj
         Qf7VmHI89ufJuQubNHsNMZ3l5Jsr+g7Q14hnngQ9O4SirUF56cM/PE50yGWLemmfEePk
         0zCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789054419; x=1789659219;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EP9J7JZjaPg+IADmoZM323AzSWYVeVHsxsO0Bf4H8W8=;
        b=MoqUDgD3OJQ+0PVjIBY+yW8SC/2tOdEeC/AHw0Jsi/Qwlyewk3LxlfP4mYhCfZZt75
         e6PoN8No2qJv6S9aVEQe/lmm/ZRLjt9qQNfLoJfFWwYhQfZz33+/+6tt8FH80P3C67vu
         NbRfVBq7d7CXbVMCJPzNfle0zAwKaCLzyaM9gDCBMM6DNuX15JNJIC3cinxHadejzy0t
         NANdjCWH8xU1qOh4oxJ47XnujaZJ4tSUBGce+PuU3AkyXKXVbc64NarWh2kYPlg5UE+3
         QVcI6hJAXjtn1CHafXyJ8EFgUJEd2xINwcXjfKapQTK0Iz+Tuq/nDlek0EfphqwCxKlJ
         4iUQ==
X-Gm-Message-State: AFuF++nFZfKb+FZg/W9Ymo5Ep7kMedoh0c/jGnYcP19OQpsAkofpVpQG
	MatgD6a3YPX9Rld1CBH0mcCpJMmy+v5Gto9j84sCRK7PE5LMH5o7jooUnjocIUlutNKj2NMSvrH
	WXgnkW10iVY91D2jZAFs5cEwE9/dx8f1vPu9pa+ndeqd9zDpjrcKnpjYEqTEJspo5tQ8SWJXUhX
	x8ATOryqIA20UKK/8KhsqDJzeG3qqe2P4dYbpbqGdzDpXwcDCFXeAaxw==
X-Received: from dyx21.prod.google.com ([2002:a05:693c:8215:b0:339:7600:c341])
 (user=aaronlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:151f:b0:6b3:bb82:2736 with SMTP id 006d021491bc7-6b6fcac57fbmr23137742eaf.17.1789054417971;
 Thu, 10 Sep 2026 08:33:37 -0700 (PDT)
Date: Thu, 10 Sep 2026 15:33:23 +0000
In-Reply-To: <20260910153326.3085937-1-aaronlewis@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260910153326.3085937-1-aaronlewis@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260910153326.3085937-2-aaronlewis@google.com>
Subject: [PATCH v3 1/4] vfio: selftests: Assert the region was unmapped in iommu_unmap()
From: Aaron Lewis <aaronlewis@google.com>
To: kvm@vger.kernel.org
Cc: alex@shazbot.org, dmatlack@google.com, jgg@nvidia.com, 
	Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Add an assertion in iommu_unmap() to verify that the region was fully
unmapped. Centralizing this check simplifies the selftests by removing
the need for individual tests to handle the verification themselves.

Suggested-by: David Matlack <dmatlack@google.com>
Reviewed-by: David Matlack <dmatlack@google.com>
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
2.55.0.1003.g10538fe699-goog

