Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD1437C91A;
	Wed, 17 Jun 2026 18:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781722706; cv=none; b=g5UF9iC/3Fi9zphKzMSE0G8g6d/iY22U9Cxz6DhaLu8VlBn9fe0dQIWMf0xOxxGPAoLIL5cdZqA0ni5xY5+eWsQeT/kr/629sH6PLRJ9dcLkp59k6laNIPmwaLVU1wGZfE6KDHYH6xLnKW8nOlL5uW7nOYcNLTly5nVmkaZBVms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781722706; c=relaxed/simple;
	bh=ndCadHNM1CKc8fk4uO0QhhQaWycKReFYcQQ/9fApchE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=JRoWMpQsXziOl/qqVcnU6tqGwBwG7IcaSIZa516zjvHTXFBgkdS1RRRX5fmrWf5BnlKdnWtl2H+GxeByLlPBb8GQLCPsSkcINkJ5L3gLe6U4qabVihiMs96fA6JY0L2+WhwpeMilwOvymB57kgkOz4OfkWPpt28XhxgTK/OgG5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=QlKNQShV; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="QlKNQShV"
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HHeAGK447451;
	Wed, 17 Jun 2026 11:58:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=SEK9G1Z4p6sUMETNX6idOSviZe3J/t4OUo0nCL9RHok=; b=QlKNQShVFZOt
	LL6bm4MSZA7m/PRYCP4l5eWjRj9dt6HpUDPgzURuiqSg6YApxmErvYFfuS8Pbsat
	HWr9Fpsg73PPe2/MAR2CyUIzfaB1vxepa9vK3kPVLeaGVqjRlC+/r02AfdwDa2fJ
	FnUo4suEBsyujzPWW9p+2oHj1HR7yy/dDioQ7kyN6tZhErMhF33jO0bjNnwQr3WS
	qxMR8tZ+f3Ozx+iAGYiUGTgYCYPXDYCWHgUx37KL+57dDgLHB1zvKpbgHCOA325J
	O/s4DEp54161M7ZkjhdY2yQwkb2QtF2QpzWzfZACgo1iVS0KoTouXoHNR2vYF3EO
	p6NLpT/tRw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eueg9xqrx-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 17 Jun 2026 11:58:15 -0700 (PDT)
Received: from devgpu015.cco6.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Wed, 17 Jun 2026 18:58:13 +0000
From: Alex Mastro <amastro@fb.com>
Date: Wed, 17 Jun 2026 11:58:00 -0700
Subject: [PATCH v4 1/2] vfio: selftests: Add allocation assert helpers
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260617-scratch-amastro-vfio-selftests-avoid-vlas-v4-1-b9f52f1e2c5a@fb.com>
References: <20260617-scratch-amastro-vfio-selftests-avoid-vlas-v4-0-b9f52f1e2c5a@fb.com>
In-Reply-To: <20260617-scratch-amastro-vfio-selftests-avoid-vlas-v4-0-b9f52f1e2c5a@fb.com>
To: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Raghavendra Rao Ananta <rananta@google.com>,
        Vipin Sharma <vipinsh@google.com>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
        "Alex
 Mastro" <amastro@fb.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: kMyEpeOqHrYTmLet_WqPZ3l5lCRu0lDh
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE4MyBTYWx0ZWRfX0eQ7EXHFGNhs
 hVyziVwQA0L0xM4L4J4BdsWwpDvyAMXQaGIET4uBLYibbeQFfclRupyE4vUofRU8XOivS5xMH1c
 +gzR3L4QH1wG6+az94P+3Lrwnw/kNIY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE4MyBTYWx0ZWRfXx1kqxcFRaqAE
 SqBA41nlxCH89Iu3E5r9hXU8d6TgJPyHKFW9bf4u6/DLpRyNuDWhsHOQL37DF6fyeImNXbkHCTK
 Zf1CdHlEWAFyluMCaUDA6EwfAY+qE+ZNL5hRZDOf5fwHLpXIouKu7lxWKHVNvil1KJ6wxl9Wvt5
 YVxrWBrwvBTIbNq0bFbF+bHEzRPp9240xXG7p7RkpF74LnyITtbIlk8Y3vrWHlV2d5S2J9CKX9P
 n0GXr73UxelUnrNY3alXXHY2nXQzcBDoGV8w6nPrvK0Ke5UnSD/sCVnKL/vJT+G9ZF6AQvuylrO
 8YrPVVLZ4fWqscu49n1rAlQy09B7yN19A0rkxIJE9gasQYcs7rF6Hvz/BzlhzmjMvcvQ5g/84om
 CM/+X/mbWCZA1VuZAu1xyIjA3aNQWU1OUK9BAoVj5RE+cVdy9u3ohFQnjvZmyiyJTMgxPZhWn4M
 IzYySfpaT/QiE61hPdA==
X-Authority-Analysis: v=2.4 cv=Zord7d7G c=1 sm=1 tr=0 ts=6a32ee48 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=jCddH8ec0KUNCymVuxII:22 a=FOH2dFAWAAAA:8
 a=vfVwCqD-e9ToaxWBWr0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: kMyEpeOqHrYTmLet_WqPZ3l5lCRu0lDh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01

Add {malloc,calloc}_assert() helpers alongside the existing *_assert()
helpers.

Use them for VFIO selftest allocations that immediately assert a
non-NULL result.

Assisted-by: Codex:gpt-5.5-high
Signed-off-by: Alex Mastro <amastro@fb.com>
---
 .../selftests/vfio/lib/include/libvfio/assert.h        | 18 ++++++++++++++++++
 tools/testing/selftests/vfio/lib/iommu.c               | 12 ++++--------
 tools/testing/selftests/vfio/lib/iova_allocator.c      |  4 +---
 tools/testing/selftests/vfio/lib/sysfs.c               |  3 +--
 tools/testing/selftests/vfio/lib/vfio_pci_device.c     |  6 ++----
 .../selftests/vfio/vfio_pci_device_init_perf_test.c    |  4 ++--
 6 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/assert.h b/tools/testing/selftests/vfio/lib/include/libvfio/assert.h
index 77b68c7129a6..9fff88f6e4e1 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/assert.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/assert.h
@@ -3,6 +3,7 @@
 #define SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_ASSERT_H
 
 #include <stdio.h>
+#include <stdlib.h>
 #include <string.h>
 #include <sys/ioctl.h>
 
@@ -45,6 +46,23 @@
 	VFIO_LOG_AND_EXIT(_fmt, ##__VA_ARGS__);			\
 } while (0)
 
+#define malloc_assert(_size) ({					\
+	size_t __size = (_size);				\
+	void *__ptr = malloc(__size);				\
+	VFIO_ASSERT_NOT_NULL(__ptr, "malloc(%zu) failed",	\
+			     __size);				\
+	__ptr;							\
+})
+
+#define calloc_assert(_nmemb, _size) ({				\
+	size_t __nmemb = (_nmemb);				\
+	size_t __size = (_size);				\
+	void *__ptr = calloc(__nmemb, __size);			\
+	VFIO_ASSERT_NOT_NULL(__ptr, "calloc(%zu, %zu) failed",	\
+			     __nmemb, __size);			\
+	__ptr;							\
+})
+
 #define ioctl_assert(_fd, _op, _arg) do {						       \
 	void *__arg = (_arg);								       \
 	int __ret = ioctl((_fd), (_op), (__arg));					       \
diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/selftests/vfio/lib/iommu.c
index 035dac069d60..b6f3c5c84e01 100644
--- a/tools/testing/selftests/vfio/lib/iommu.c
+++ b/tools/testing/selftests/vfio/lib/iommu.c
@@ -286,8 +286,7 @@ static struct vfio_iommu_type1_info *vfio_iommu_get_info(int container_fd)
 {
 	struct vfio_iommu_type1_info *info;
 
-	info = malloc(sizeof(*info));
-	VFIO_ASSERT_NOT_NULL(info);
+	info = malloc_assert(sizeof(*info));
 
 	*info = (struct vfio_iommu_type1_info) {
 		.argsz = sizeof(*info),
@@ -324,8 +323,7 @@ static struct iommu_iova_range *vfio_iommu_iova_ranges(struct iommu *iommu,
 	cap_range = container_of(hdr, struct vfio_iommu_type1_info_cap_iova_range, header);
 	VFIO_ASSERT_GT(cap_range->nr_iovas, 0);
 
-	ranges = calloc(cap_range->nr_iovas, sizeof(*ranges));
-	VFIO_ASSERT_NOT_NULL(ranges);
+	ranges = calloc_assert(cap_range->nr_iovas, sizeof(*ranges));
 
 	for (u32 i = 0; i < cap_range->nr_iovas; i++) {
 		ranges[i] = (struct iommu_iova_range){
@@ -357,8 +355,7 @@ static struct iommu_iova_range *iommufd_iova_ranges(struct iommu *iommu,
 	VFIO_ASSERT_EQ(errno, EMSGSIZE);
 	VFIO_ASSERT_GT(query.num_iovas, 0);
 
-	ranges = calloc(query.num_iovas, sizeof(*ranges));
-	VFIO_ASSERT_NOT_NULL(ranges);
+	ranges = calloc_assert(query.num_iovas, sizeof(*ranges));
 
 	query.allowed_iovas = (uintptr_t)ranges;
 
@@ -424,8 +421,7 @@ struct iommu *iommu_init(const char *iommu_mode)
 	struct iommu *iommu;
 	int version;
 
-	iommu = calloc(1, sizeof(*iommu));
-	VFIO_ASSERT_NOT_NULL(iommu);
+	iommu = calloc_assert(1, sizeof(*iommu));
 
 	INIT_LIST_HEAD(&iommu->dma_regions);
 
diff --git a/tools/testing/selftests/vfio/lib/iova_allocator.c b/tools/testing/selftests/vfio/lib/iova_allocator.c
index 8c1cc86b70cd..4a660f636f49 100644
--- a/tools/testing/selftests/vfio/lib/iova_allocator.c
+++ b/tools/testing/selftests/vfio/lib/iova_allocator.c
@@ -29,8 +29,7 @@ struct iova_allocator *iova_allocator_init(struct iommu *iommu)
 	ranges = iommu_iova_ranges(iommu, &nranges);
 	VFIO_ASSERT_NOT_NULL(ranges);
 
-	allocator = malloc(sizeof(*allocator));
-	VFIO_ASSERT_NOT_NULL(allocator);
+	allocator = malloc_assert(sizeof(*allocator));
 
 	*allocator = (struct iova_allocator){
 		.ranges = ranges,
@@ -90,4 +89,3 @@ iova_t iova_allocator_alloc(struct iova_allocator *allocator, size_t size)
 		allocator->range_offset = 0;
 	}
 }
-
diff --git a/tools/testing/selftests/vfio/lib/sysfs.c b/tools/testing/selftests/vfio/lib/sysfs.c
index 11415448b2e2..98a46a2543cd 100644
--- a/tools/testing/selftests/vfio/lib/sysfs.c
+++ b/tools/testing/selftests/vfio/lib/sysfs.c
@@ -107,8 +107,7 @@ char *sysfs_sriov_vf_bdf_get(const char *pf_bdf, int i)
 	char *out_vf_bdf;
 
 	/* Fit "0000:00:00.0" */
-	out_vf_bdf = calloc(16, sizeof(char));
-	VFIO_ASSERT_NOT_NULL(out_vf_bdf);
+	out_vf_bdf = calloc_assert(16, sizeof(char));
 
 	snprintf_assert(path, PATH_MAX, "/sys/bus/pci/devices/%s/virtfn%d", pf_bdf, i);
 	readlink_base(path, "%s", out_vf_bdf);
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 94dc5fcecbeb..eb40f7159bae 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -343,8 +343,7 @@ const char *vfio_pci_get_cdev_path(const char *bdf)
 	char *cdev_path;
 	DIR *dir;
 
-	cdev_path = calloc(PATH_MAX, 1);
-	VFIO_ASSERT_NOT_NULL(cdev_path);
+	cdev_path = calloc_assert(PATH_MAX, 1);
 
 	snprintf_assert(dir_path, sizeof(dir_path), "/sys/bus/pci/devices/%s/vfio-dev/", bdf);
 
@@ -425,8 +424,7 @@ struct vfio_pci_device *vfio_pci_device_alloc(const char *bdf, struct iommu *iom
 {
 	struct vfio_pci_device *device;
 
-	device = calloc(1, sizeof(*device));
-	VFIO_ASSERT_NOT_NULL(device);
+	device = calloc_assert(1, sizeof(*device));
 
 	VFIO_ASSERT_NOT_NULL(iommu);
 	device->iommu = iommu;
diff --git a/tools/testing/selftests/vfio/vfio_pci_device_init_perf_test.c b/tools/testing/selftests/vfio/vfio_pci_device_init_perf_test.c
index 33b0c31fe2ed..e1a54e153cd3 100644
--- a/tools/testing/selftests/vfio/vfio_pci_device_init_perf_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_device_init_perf_test.c
@@ -45,8 +45,8 @@ FIXTURE_SETUP(vfio_pci_device_init_perf_test)
 	int i;
 
 	self->iommu = iommu_init(variant->iommu_mode);
-	self->threads = calloc(nr_devices, sizeof(self->threads[0]));
-	self->thread_args = calloc(nr_devices, sizeof(self->thread_args[0]));
+	self->threads = calloc_assert(nr_devices, sizeof(self->threads[0]));
+	self->thread_args = calloc_assert(nr_devices, sizeof(self->thread_args[0]));
 
 	pthread_barrier_init(&self->barrier, NULL, nr_devices);
 

-- 
2.53.0-Meta

