Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580AF3B5304;
	Mon, 15 Jun 2026 19:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781552736; cv=none; b=BTqUc+wnynOQeIR50ieZFSoBsXiChtcGLiaEFzc/DN4+oLnAi6bLGwXnzB1nGEo+bBkTrwhXW3uRC6RHY8vzY/2FVapI7EdYCzqPI8BK14BVV07r0x2dHfATRrRegFCIRWaeXFOEugFwFILksYgMJkGP6HM2kk0qHFhApiAa4yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781552736; c=relaxed/simple;
	bh=HEg++TzfMjMemofpcCzWgWkEFGWIJF918pxQaZ2CCOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=iNc0VJp1MfbRe0WRXmic22ELx8/2wzo6uUHB+nvS2q6OQGVrTm9VIo/VYfJYifaGxi08QhZ9Ce8OA/nAYRG0M6FtB8x/strOAQHr+5O8EsipCB7L7mzB8hNwgu3Iir3VCmVwcd3D+S8pCwGrLYja/bqEkRlcfMzUXHkgwnzLDX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=wQWE1Plo; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="wQWE1Plo"
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FIwEJ72969350;
	Mon, 15 Jun 2026 12:45:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=hk1tBCKTJ2lTDmYI2/76DBXJBaXzVhcNj6XtcLeiwfw=; b=wQWE1Plo1fEQ
	0/7H5BxmQ83j3irrVAVJ7tdCIGgMdFiXBO3ZIFw45DyTB/AiAccQrr1T9WhYIftZ
	pfVGvUSx/8UAqtwapqZLm3zAiUtwvfZiqEoPQ8ZKt6Qij7RweNfy3M12R0DCiLYO
	qa8pYu5oHDeqENdneP3Ni17Jv4WuecyasjPIXHBvZ8GIm3GB3hLJRat0AQ9DlP7A
	cKM/F5qeXf3SP2z8qnqFLaQIVg/8cTwO3Nnxd3yzdXaAWl64WBUFeOKKwYsBv/Xk
	yuSiiLkUAx7oIX3HiKdsAPMibotVzawVZbnUnYXQBvY8XAa8H2JaN1FxbsciapcB
	kNyBUSDdHw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4es4a6ketk-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 15 Jun 2026 12:45:27 -0700 (PDT)
Received: from devgpu015.cco6.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Mon, 15 Jun 2026 19:45:24 +0000
From: Alex Mastro <amastro@fb.com>
Date: Mon, 15 Jun 2026 12:44:51 -0700
Subject: [PATCH v3 1/2] vfio: selftests: Add calloc_assert() helper
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260615-scratch-amastro-vfio-selftests-avoid-vlas-v3-1-b3798415c72a@fb.com>
References: <20260615-scratch-amastro-vfio-selftests-avoid-vlas-v3-0-b3798415c72a@fb.com>
In-Reply-To: <20260615-scratch-amastro-vfio-selftests-avoid-vlas-v3-0-b3798415c72a@fb.com>
To: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Raghavendra Rao Ananta <rananta@google.com>,
        Vipin Sharma <vipinsh@google.com>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
        "Alex
 Mastro" <amastro@fb.com>
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=V5dNF+ni c=1 sm=1 tr=0 ts=6a305657 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=03ozwUkBphtHgyqjj1sw:22 a=FOH2dFAWAAAA:8
 a=fm5SQLaTe4XshVrLqxcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfX8iZ7x243yQad
 blbhO4dBXyFUq5o9lBD4sI/7rS0jw6YEFSjSmB72rQlxlO+2o8DXnb2L/CP9HyKj/GOCO402MkM
 q5e6R5tmSXqvBFEVSrF7bNqJoIQkt/v/vvHRKP3oBivoX7lPuKYb8WC2J7ytwoL1h5uA3I0Ts5J
 1ejlcmqEQeOQpoWhZDL+feEHN4geB5y6HHF4wFcoSe9OK06xLkFQfvuYibJ0fzlSdWBcvLZiiHE
 Z2QSQns0o+439QntTjIUPYdCo8eYcMc2WMfZH020LXSoHwbfrLrroey4ynKf1PDDo/aMVpgzfut
 ScXOkkZnhSEsAvF/ui5139K0fgmy+33cqDcDvKoWNoOERXMxDUemQVeJYzu7NcnmFdb1RXkSZl1
 bI3ci0gngARjJPqCyew7lFNoUBc4A1pwwC69l2LLoPa+xBUMPzsT4qTnMTFCTw/G+aXYHqjIeln
 HkZpQzVbtoHDQLz8SBg==
X-Proofpoint-ORIG-GUID: hb6SPZPMndKCo0kdl8LTaCmru6NiWMob
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfXw1FAo0Ka8lZV
 tEjNxrniswfDsj5Tfajf/69HFKbNE+veQqmTtfWC36fL9BC3Lji9QsBYRkjlBo49a+VAeY9bzFA
 905zr3k3USBgyDZBHH1pjAKvnyoiSzI=
X-Proofpoint-GUID: hb6SPZPMndKCo0kdl8LTaCmru6NiWMob
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01

Add a calloc_assert() helper alongside the existing ioctl_assert() and
snprintf_assert() helpers.

Use it for VFIO selftest allocations that immediately assert a
non-NULL result.

Assisted-by: Codex:gpt-5.5-high
Signed-off-by: Alex Mastro <amastro@fb.com>
---
 tools/testing/selftests/vfio/lib/include/libvfio/assert.h    | 10 ++++++++++
 tools/testing/selftests/vfio/lib/iommu.c                     | 12 ++++--------
 tools/testing/selftests/vfio/lib/iova_allocator.c            |  4 +---
 tools/testing/selftests/vfio/lib/sysfs.c                     |  3 +--
 tools/testing/selftests/vfio/lib/vfio_pci_device.c           |  6 ++----
 .../testing/selftests/vfio/vfio_pci_device_init_perf_test.c  |  4 ++--
 6 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/assert.h b/tools/testing/selftests/vfio/lib/include/libvfio/assert.h
index 77b68c7129a6..f0490a403826 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/assert.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/assert.h
@@ -3,6 +3,7 @@
 #define SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_ASSERT_H
 
 #include <stdio.h>
+#include <stdlib.h>
 #include <string.h>
 #include <sys/ioctl.h>
 
@@ -45,6 +46,15 @@
 	VFIO_LOG_AND_EXIT(_fmt, ##__VA_ARGS__);			\
 } while (0)
 
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
index 035dac069d60..31aba9fda8e5 100644
--- a/tools/testing/selftests/vfio/lib/iommu.c
+++ b/tools/testing/selftests/vfio/lib/iommu.c
@@ -286,8 +286,7 @@ static struct vfio_iommu_type1_info *vfio_iommu_get_info(int container_fd)
 {
 	struct vfio_iommu_type1_info *info;
 
-	info = malloc(sizeof(*info));
-	VFIO_ASSERT_NOT_NULL(info);
+	info = calloc_assert(1, sizeof(*info));
 
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
index 8c1cc86b70cd..2e7d54e1b4c6 100644
--- a/tools/testing/selftests/vfio/lib/iova_allocator.c
+++ b/tools/testing/selftests/vfio/lib/iova_allocator.c
@@ -29,8 +29,7 @@ struct iova_allocator *iova_allocator_init(struct iommu *iommu)
 	ranges = iommu_iova_ranges(iommu, &nranges);
 	VFIO_ASSERT_NOT_NULL(ranges);
 
-	allocator = malloc(sizeof(*allocator));
-	VFIO_ASSERT_NOT_NULL(allocator);
+	allocator = calloc_assert(1, sizeof(*allocator));
 
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

