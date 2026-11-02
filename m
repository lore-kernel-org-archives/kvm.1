Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633844;
	b=b5Kcm3/E1WVpPRT6JSk0aETa/1N7aPp/uOb9uCTKWyJqs38brXStntTdj8sIb9zUfFd2
	 vYqI3Yc/vR07kvl8s995wPktvRVynWlWdXyEahISjBe06o9ddchK2SBkm/RXGhoE6lMAp
	 yejzR2zLh9aYTmxM97oZ6pfLkY0jEQlYlcpxtkSNb5UUdP40f+vKSz1ZS40v40L5rYEE1
	 86tq6JA67Ai8FD+dNM3/S26SkvygsjnoORG86oan/k8xFLbe6VRcSipHfQmlfKHzIHw0j
	 XfhlgsED094WcDKKh2X1XflPjXqABGLRWQf7n1Q4JI4RiLQkMXkxXie3qGXnbWYH8dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=9juNA68D1pfuFQpRVNDQa7dR4Pnf/xhC+K8NWgBMU/E=;
	b=QpUfOZx7srmBTmfhlyWadyLfSxohT+E05P7CGOWdKeRGpch+iLWkuBCwjlw7j0svefRg
	 2Egj8poV/5g9TLj7JSqX4RTd5njKLGhWaj97ev8gKKUQ0nE3mty0B/Ut5D0+bPi4NAtuO
	 IaxNMvqpso2tAMz9/CSBji7VuDCWEkGSZ4hGe2+1shNcMYE2ZKxI2SHM3HJ9s/1b/3kCb
	 OSKZsVp9l9WJMSQscBIlRuDJx8oJ8UKHfwfF0iUxDCw5eG8PmVzYjSgl7wYEy7t1/z/Ao
	 OZEnvPLA/VkNSa3r1S89QUvM5Cs/6D4Mq+nmmfXbWxU+g8Pj+BRV/SUZxMDNMrBLUTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="ne/GrZZB";
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3377960A6C36
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 15:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3377960A6C36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ne/GrZZB
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e93e2f72bfso53694535ad.3
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 07:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633844; x=1794238644; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9juNA68D1pfuFQpRVNDQa7dR4Pnf/xhC+K8NWgBMU/E=;
        b=ne/GrZZBB6RQdxM5E5YlzCX2uHuyM90n+ZGH0IzIs+RtSEMzmn90zvFc5wu6L4ndX2
         UUhYANfqHwY9O0/LpiVnAW59obokAICWZsCfC5WHHR1HIaMtz+dRALHpK3ADpuJceALG
         fsaZ//B9E3RtbSa8iPpz62QhQ6adoNp+TPCcOkXQEIyVAiQSoyYihqWGqsvnqLJZBIJV
         Afm6D4Y3dlUWSNqWt5G6WkVgUP7C//FKusN0Z4aTz7GP8GqhyUvlw+Oc/IUJ7byuVaCm
         41fz1DQe/LHfkRbcy2VviRmHuZ9rbBx7MM6z2thnxzPs3vs3PljyXpUddS/NNIQh9Wm+
         +tsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633844; x=1794238644;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9juNA68D1pfuFQpRVNDQa7dR4Pnf/xhC+K8NWgBMU/E=;
        b=pkCcEcRqDL3SWyCq6nu2XY0EINoNJlmX0/6/xmty4setcKJOQHN6lNCiMX99a18Pjp
         jhKv0Rrf+RaxU8t1FXXtexQ2vNzSurulDez05fuUDMSTe+DgZcGy/7f4QtgbXi7a1Gn1
         5Nin7MswhzQwd5fXXRVB2yvcGHjbneAwl30SuSVJ59qUEdY3He9Xh11tdBRU0giX+vJu
         t3xhSRrYafzJt4grD1dHRO4pRW1R/JZzozTWeU3jQ8YR/gofym9gphb+KmgJzVNBHd+y
         Sr/VSsXueEdpjdB4OZFqYVrxBcbABsWi8wyC7hwT6BIGQxnXgNSi6msfcZWOHVBz5l8h
         G0wA==
X-Forwarded-Encrypted: i=1; AKwUvBwLXMtGKMsWqS9P40Iznr9QPvR+lYn+HZlGYyS1s0YToBFy7xh6HBuUf7+eWGerBTeIm4k=@vger.kernel.org
X-Gm-Message-State: APuU4Z+9PoBGIq+jBWef2dHT9sJ1T5AqQ8V9YeMABKiCjiPcoGLhAllv
	EaKNxU0amQ8amUFQwqws5kKIKRvAEsK1d8ATQUh6dRyao1ysc2qh1rYVUCGBIURHvyR2ixN9ggU
	nYR/vSNi4jw==
X-Received: from plkz4.prod.google.com ([2002:a17:902:7084:b0:2eb:4f47:5748])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f642:b0:2e9:5772:9ab2
 with SMTP id d9443c01a7336-2eb364ec93fmr97906535ad.41.1793633843417; Mon, 02
 Nov 2026 07:37:23 -0800 (PST)
Date: Mon,  2 Nov 2026 07:36:51 -0800
In-Reply-To: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261102153656.1431701-23-vipinsh@google.com>
Subject: [PATCH v6 22/27] vfio: selftests: Add helpers for Live Update DMA
 memory and sysfs state
From: Vipin Sharma <vipinsh@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rdunlap@infradead.org, rientjes@google.com, 
	rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com, 
	schnelle@linux.ibm.com, skhan@linuxfoundation.org, skhawaja@google.com, 
	vipinsh@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"

Add shared libvfio helpers used by the Live Update kexec selftest:

 - vfio_thp_memfd_alloc() and vfio_memfd_mmap_aligned() to allocate a
   shmem memfd, map it at a 2MB-aligned virtual address, and back it
   with 2MB THP folios via MADV_HUGEPAGE, write-fault population, and
   MADV_COLLAPSE.
 - __sysfs_iommu_group_get(), a variant of sysfs_iommu_group_get() that
   returns an error instead of asserting when the device has no IOMMU
   group.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 .../selftests/vfio/lib/include/libvfio.h      |  3 ++
 .../vfio/lib/include/libvfio/sysfs.h          |  1 +
 tools/testing/selftests/vfio/lib/libvfio.c    | 54 +++++++++++++++++++
 tools/testing/selftests/vfio/lib/sysfs.c      | 22 ++++++--
 4 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio.h b/tools/testing/selftests/vfio/lib/include/libvfio.h
index 07862b470777..1c245962525b 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio.h
@@ -33,4 +33,7 @@ char **vfio_selftests_get_bdfs(int *argc, char *argv[], int *nr_bdfs);
  */
 void *mmap_reserve(size_t size, size_t align, size_t offset);
 
+int vfio_thp_memfd_alloc(size_t size, void **vaddr_out);
+void *vfio_memfd_mmap_aligned(int fd, size_t size, size_t align);
+
 #endif /* SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_H */
diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/sysfs.h b/tools/testing/selftests/vfio/lib/include/libvfio/sysfs.h
index c9ab1ea8f5a9..b9d6f6f69f88 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/sysfs.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/sysfs.h
@@ -6,6 +6,7 @@ int sysfs_sriov_totalvfs_get(const char *bdf);
 int sysfs_sriov_numvfs_get(const char *bdf);
 void sysfs_sriov_numvfs_set(const char *bdf, int numvfs);
 char *sysfs_sriov_vf_bdf_get(const char *pf_bdf, int i);
+int __sysfs_iommu_group_get(const char *bdf, int *group);
 int sysfs_iommu_group_get(const char *bdf);
 char *sysfs_driver_get(const char *bdf);
 
diff --git a/tools/testing/selftests/vfio/lib/libvfio.c b/tools/testing/selftests/vfio/lib/libvfio.c
index 3a3d1ed635c1..00369fe7d074 100644
--- a/tools/testing/selftests/vfio/lib/libvfio.c
+++ b/tools/testing/selftests/vfio/lib/libvfio.c
@@ -1,14 +1,23 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
 #include <sys/mman.h>
 
 #include <linux/align.h>
+#include <linux/mman.h>
+#include <linux/sizes.h>
 
 #include "../../../kselftest.h"
 #include <libvfio.h>
 
+#ifndef MADV_COLLAPSE
+#define MADV_COLLAPSE 25
+#endif
+
 static bool is_bdf(const char *str)
 {
 	unsigned int s, b, d, f;
@@ -101,3 +110,48 @@ void *mmap_reserve(size_t size, size_t align, size_t offset)
 
 	return map_align;
 }
+
+void *vfio_memfd_mmap_aligned(int fd, size_t size, size_t align)
+{
+	void *vaddr;
+
+	vaddr = mmap_reserve(size, align, 0);
+	vaddr = mmap(vaddr, size, PROT_READ | PROT_WRITE,
+		     MAP_SHARED | MAP_FIXED, fd, 0);
+	VFIO_ASSERT_NE(vaddr, MAP_FAILED);
+
+	return vaddr;
+}
+
+int vfio_thp_memfd_alloc(size_t size, void **vaddr_out)
+{
+	void *vaddr;
+	int fd;
+
+	VFIO_ASSERT_TRUE(IS_ALIGNED(size, SZ_2M));
+
+	fd = memfd_create("vfio-lu-dma", 0);
+	VFIO_ASSERT_GE(fd, 0);
+
+	VFIO_ASSERT_EQ(ftruncate(fd, size), 0);
+
+	vaddr = vfio_memfd_mmap_aligned(fd, size, SZ_2M);
+
+	if (madvise(vaddr, size, MADV_HUGEPAGE))
+		ksft_exit_skip("madvise(MADV_HUGEPAGE) failed: %s\n",
+			       strerror(errno));
+
+	/*
+	 * Write-fault the mapping rather than using fallocate() so that shmem
+	 * allocates PMD-sized THP folios when shmem_enabled is always,
+	 * within_size, or advise, then collapse in case shmem_enabled is never.
+	 */
+	memset(vaddr, 0, size);
+
+	if (madvise(vaddr, size, MADV_COLLAPSE))
+		ksft_exit_skip("madvise(MADV_COLLAPSE) failed: %s\n",
+			       strerror(errno));
+
+	*vaddr_out = vaddr;
+	return fd;
+}
diff --git a/tools/testing/selftests/vfio/lib/sysfs.c b/tools/testing/selftests/vfio/lib/sysfs.c
index 98a46a2543cd..219db6aaa101 100644
--- a/tools/testing/selftests/vfio/lib/sysfs.c
+++ b/tools/testing/selftests/vfio/lib/sysfs.c
@@ -115,14 +115,30 @@ char *sysfs_sriov_vf_bdf_get(const char *pf_bdf, int i)
 	return out_vf_bdf;
 }
 
-int sysfs_iommu_group_get(const char *bdf)
+int __sysfs_iommu_group_get(const char *bdf, int *group)
 {
+	char rl_path[PATH_MAX];
 	char path[PATH_MAX];
-	int group;
+	char *end;
+	int ret;
 
 	snprintf_assert(path, PATH_MAX, "/sys/bus/pci/devices/%s/iommu_group", bdf);
-	readlink_base(path, "%d", &group);
+	ret = readlink_safe(path, rl_path);
+	if (ret == -1)
+		return -errno;
+
+	errno = 0;
+	*group = strtol(basename(rl_path), &end, 10);
+	VFIO_ASSERT_EQ(errno, 0);
+	VFIO_ASSERT_EQ(*end, '\0');
+	return 0;
+}
+
+int sysfs_iommu_group_get(const char *bdf)
+{
+	int group;
 
+	VFIO_ASSERT_EQ(__sysfs_iommu_group_get(bdf, &group), 0);
 	return group;
 }
 
-- 
2.56.0.317.g454f8302e1-goog

