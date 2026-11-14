Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662528;
	b=04VNo6YGMC6YQf60b1WkxedQdw/c0g9JQTQnW3uX2l40cSwD1wN/KKvv8jsbSR6CgUPy
	 rTQGZlme2IpW89D88VtGYuU5Wrvyy6DqCKsNiZ2DIE97N/OGZ6vOYmqxVY9ZkJ+9Hzg+T
	 EDM5wa7N4ZfrjBLHCPz4Wks7fjtZFOVSGx1Vc8vSRZNRZ0uc0V33pLKoissLbPM4YNHWZ
	 GiQHvgVraL4tmRz/D1RsbsVpfnEnaq+IYZYFma13n0096KtvFIpo3eBdHDnzEHzjO+HUG
	 dQQkpfLO5aRFjEsqvJmn++924LlxtVZXWUm9PbU/ePNX2O+c4DnrkmCOaZnA795ZUmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662528;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=O0ccMkvoZZaYPwYYobh3IeUd6I/0CUeR6qmS0V2yisc=;
	b=gr5c3BHla/eSenORiQ9SfuWNDv8U3+/oEdXQam+bY0wLD6mcF6iomNyxR8wC2cilAnQN
	 duisTle0CziNvl0OQGwQeXy/N3SiYULUVm+50lFuJHB+i5CJSWiJHReBV0LdJB124T3oc
	 yVwIeQaBBkvJ5NK6Nbxv59cxSaybtgLEBV39/08mMLuVdszSajaM1Fj/qufX8752xInek
	 xie+ihXSw2pVqXOm8yAY56Dm0gPhPMYOuvNWCeQ2k2+FY+YHaPVir8TP/MMC4l/6Lclhz
	 /crnGfIJnBWawiS2kKSRtq+ezCiEeCGqKjMj8aYbxm1XvKQBqxpgKRTSLumBKYD0jMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HdEexbPT;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D94606A337
	for <kvm@vger.kernel.org>; Sat, 14 Nov 2026 13:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4D94606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HdEexbPT
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36fa5673fccso4712807eec.1
        for <kvm@vger.kernel.org>; Sat, 14 Nov 2026 05:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794662527; x=1795267327; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O0ccMkvoZZaYPwYYobh3IeUd6I/0CUeR6qmS0V2yisc=;
        b=HdEexbPTXyj+YG0r1HKj0EyS1q4bdmH1i/SFjzpl1pLVgHVzQzVNieSX5QrkQN8aDS
         n/UNam5jc9JASMT1QiCnBBot4pASzXO/TMYtu9MAIW1lMiMdfOtBxpXzqaq+4fsqmKHt
         TfNqIDD15BChsgpWDMtJ6U90Gk06DFtbXHm2kHeS5Yw0dWg585TepiRFfDpGe3Fl3WHY
         HeRO1MihAPFkTMwT+oIskpeyV5por+VlvGwAmzOAMmqgbOMVpsZXPg9nBvVPfOcFDiuC
         plPVrbxCfbsQdJyYP37XbWD4BxWlfDlt6naSGxcZ/rgxi3/iLdZB1kTqy8qHBcDNFId+
         Bt5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794662527; x=1795267327;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O0ccMkvoZZaYPwYYobh3IeUd6I/0CUeR6qmS0V2yisc=;
        b=ZTAWgNht1jjBUvmsEHEWf2HEz6XmRm+Z0o4B8alxsRJUKCzxA+mGQ5EbYTA7/+c87l
         zBPSPi0uIem1/6oTGT5klwKsF/VYSWvOggy5tqPJmXZzk3XvlN31/BRXlGbDHNVlCYS5
         KLlXMPd8J/c5DOBEuTGfFzvrgNXOl/VOEGCHcaJqVNR1wHUPkKN+j4yCYAKxTF4v/2H6
         V2tiFjS0iwvFX4TTFOecxprgbmQLFeEZ9SefPecJT6zLA8jzA9lGkLRDev15WrJfFd8w
         DCilrCAE1zmQGowjVfxKDJ4I+zYxXyrIS1LKpzIT+YwOxRw2mfW54ZeHNQSN5TSQqd1i
         dczw==
X-Gm-Message-State: APuU4Z9JU3QLm0986MIzudA9tPTDlv8XpljXsNRenAMj6Cbg8sZvUlre
	Fd+xLgpzZqQu1iumzSXIX5G3SyOFfIEQAICcPpYjXliDabU5DhMWsdpEGmc5dMP0D5VBekgLGL2
	ivG4teoIu4BfYSVhkKhErFZtxCnwsrBx0VAoJVs0a1KlY5UpnPmLrV5cHFhx0ndzHBrZSVfH/qP
	SY14nc7jlSNxeWZ4QR3MdxIP8DCxjAzzOtb87VCpPjYObTwOIfElGt0A==
X-Received: from dycmq9.prod.google.com ([2002:a05:7301:789:b0:369:de3f:acf3])
 (user=aaronlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:e9cd:10b0:379:7251:9a1b with SMTP id 5a478bee46e88-3797251ad11mr6273729eec.21.1794662526751;
 Sat, 14 Nov 2026 05:22:06 -0800 (PST)
Date: Sat, 14 Nov 2026 13:21:56 +0000
In-Reply-To: <20261114132200.113697-1-aaronlewis@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261114132200.113697-1-aaronlewis@google.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261114132200.113697-2-aaronlewis@google.com>
Subject: [PATCH v4 1/5] vfio: selftests: Assert the region was unmapped in iommu_unmap()
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
2.56.0.611.g1030f0b940-goog

