Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D4737104F;
	Fri,  3 Jul 2026 07:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065188; cv=none; b=h8jQL0kBXnyIiOoengG1QeQAboHDudcwQu9pJNKZTDKVOzJ01g0uN2m1xullJ6Onggl9KNEvXLgP/fXn3o9erNv6ElvGmXJP/i7YguZ2nIV5D7qdRc4/q0x6IHsRuuvtdq6sjnEZNfkDal85YZKELoG8qC5C/eyR2IKo03/0QdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065188; c=relaxed/simple;
	bh=Dfcl+yv52aLoTwERo3qICPpjSgqeEb6KixrZ8SySuPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fdDZ3g0iacV2izekI6eYygR7aFabIEzPD3886dSPsGyUolaJBE8xm9Sp6zXBqLngQMlIeBN1Lhe2IZNJ6GhQrPMV+9Bxf3jo6lP3Vnf9qncVVvFYVqM2pOECMP4AfNAaDt8CxjEmJYsunNUcXiXWTJITSzUjapyOh3YtkSfvE8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AOv55r16; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AOv55r16"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6636IHOP1869522;
	Fri, 3 Jul 2026 07:53:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=MCzRqUhRE97FPY+sO
	h0aCuxqKLn/AcrgMaInY/UoL5g=; b=AOv55r16aVIxQYmg1Q15LnSiJ6pMV7QEh
	61kqHm2+T2Rp666jlbERGwlRkI2mCgv+FNcIXzBd+JnXgx1PCYyJJCC2G97A6ozW
	6tpbizAuvo6jmRsGOLH6abHYagCGwoLw/CAFAPgpYcpODjJwZMpWY2Aj7oAbyXKl
	MflHEU9AMEdicDpDjlMmJ+9nTrFUIq6SO05tLLruISF36G4JDQKWeDhMQsFJZsvD
	xYNCQmkyTp7cAUZoyJTQjy/HCTJddBqO/7D5dozJ4M/JWygTg+VAg99n2UhNLu6z
	unOOt5RvEblaHcbK9nKpa4ZMHF7jUoPywR6gzf27Jr9JC76EifPCw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n663yc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 07:53:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6637nZhq012877;
	Fri, 3 Jul 2026 07:52:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7wfw4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 07:52:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6637qtjh14156218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jul 2026 07:52:55 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DDB320043;
	Fri,  3 Jul 2026 07:52:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F397820040;
	Fri,  3 Jul 2026 07:52:52 +0000 (GMT)
Received: from ltcd48-lp3.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  3 Jul 2026 07:52:52 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: alex@shazbot.org, dmatlack@google.com, shuah@kernel.org
Cc: amastro@fb.com, rananta@google.com, nnmlinux@linux.ibm.com,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, vaibhav@linux.ibm.com,
        sbhat@linux.ibm.com, harshpb@linux.ibm.com
Subject: [RFC PATCH 3/6] selftests/vfio: add sPAPR TCE v2 DMA window helpers
Date: Thu,  2 Jul 2026 23:28:03 -0400
Message-ID: <20260703032806.40946-4-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260703032806.40946-1-nnmlinux@linux.ibm.com>
References: <20260703032806.40946-1-nnmlinux@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA3MyBTYWx0ZWRfX/BHpZZDIn3ma
 +WXg3oWf6erKxSXR4XWKFW/Rvt5ERcR/HFPXThp573DhFLR+Ja4s5pG5p1F9t3jUCh4JCAeuxlp
 5L+5n3Ioe8UKtplc+CxRU5ihdPRS9KzkuWaNVDW4tk/YIs3jrOurOWxQlifSi89UXpRonFXbtXz
 dH7roQjMdhC+PukWnaiaf6lznZzIzCQxseOpY9w13bjPXW4iP0s9W9y1ml9aStya434bXh75Dux
 UFIEjLAzCz9HExHPd60XUriIdoavnkHpWg0rGrMsznhafUy/RKHrkJlOQ/6dYNlGqlpHEmIGPT+
 psUhMreD6yfs01BBcF03EcDcWfJvGy2hCH0zI3psUgDoi8Sbkx+BOpOMAeuukkgUWcxXORSptVL
 z5eHJg6jJnhNbrHWvCfCN0p0tEzDd3chYArt2mlyckl4k6SkgUrcOjvpW81yj1pbzhob959ZFDn
 UjP1TXzv/ZFJoP2/VTw==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a476a5d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=4M81BfYZUa9gTJPbzz4A:9
X-Proofpoint-ORIG-GUID: g5CTzH7Zj-0WxDaf9AtuAmkWgNwt6jKf
X-Proofpoint-GUID: qKhUeBDZvyGMf8Ago11ki9orex8kZXfB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA3MyBTYWx0ZWRfX19FOKKiZPXbq
 IdmagRst4QZFDnmjJJIpI5B8S6b02cBtX6GRTjvC51SX8103XQnzwWj2tB0W9Mhz+W/SxjbcFvA
 fVw6tFjjyJPPoSC3olT8DjmVYUIMOTQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030073

Add helper support for sPAPR TCE v2 DMA windows in the VFIO selftest
library.

Track the platform default DMA window separately from selftest-created
dynamic DMA windows. The default window is discovered with
VFIO_IOMMU_SPAPR_TCE_GET_INFO and is not removed during cleanup.

Add helpers to create and remove DDWs, return the active IOVA range, and
register/unregister memory around DMA map/unmap operations. Window
selection is done before IOVA allocation; the map path only validates,
registers memory, and calls VFIO_IOMMU_MAP_DMA.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 .../vfio/lib/include/libvfio/iommu.h          |  18 ++
 tools/testing/selftests/vfio/lib/iommu.c      | 273 +++++++++++++++++-
 tools/testing/selftests/vfio/lib/libvfio.c    |   2 -
 3 files changed, 288 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
index ba027a7270d0..c9b9ab929f1f 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
@@ -24,12 +24,26 @@ struct dma_region {
 	u64 size;
 };
 
+struct spapr_tce_window {
+	u64 start;
+	u64 size;
+	u32 page_shift;
+	bool valid;
+	bool dynamic;
+	bool remove_on_cleanup;
+};
+
 struct iommu {
 	const struct iommu_mode *mode;
 	int container_fd;
 	int iommufd;
 	u32 ioas_id;
 	struct list_head dma_regions;
+#ifdef __powerpc__
+	struct spapr_tce_window default_window;
+	struct spapr_tce_window ddw_window;
+	struct spapr_tce_window *active_window;
+#endif
 };
 
 struct iommu *iommu_init(const char *iommu_mode);
@@ -61,6 +75,10 @@ iova_t iommu_hva2iova(struct iommu *iommu, void *vaddr);
 
 struct iommu_iova_range *iommu_iova_ranges(struct iommu *iommu, u32 *nranges);
 
+int iommu_prepare_dma_window(struct iommu *iommu, u64 min_size,
+			     u64 page_size, bool force_dynamic);
+bool iommu_supports_unmap_all(struct iommu *iommu);
+
 #define MODE_VFIO_TYPE1_IOMMU "vfio_type1_iommu"
 #define MODE_VFIO_TYPE1V2_IOMMU "vfio_type1v2_iommu"
 #define MODE_IOMMUFD_COMPAT_TYPE1 "iommufd_compat_type1"
diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/selftests/vfio/lib/iommu.c
index e86457a715bf..19d19bb45a14 100644
--- a/tools/testing/selftests/vfio/lib/iommu.c
+++ b/tools/testing/selftests/vfio/lib/iommu.c
@@ -16,9 +16,11 @@
 #include <linux/types.h>
 #include <linux/vfio.h>
 #include <linux/iommufd.h>
+#include <linux/sizes.h>
 
 #include "../../../kselftest.h"
 #include <libvfio.h>
+#include <limits.h>
 
 const char *default_iommu_mode = MODE_IOMMUFD;
 
@@ -93,6 +95,233 @@ int __iommu_hva2iova(struct iommu *iommu, void *vaddr, iova_t *iova)
 	return -ENOENT;
 }
 
+#ifdef __powerpc__
+static bool iommu_is_spapr_tce_v2(struct iommu *iommu)
+{
+	return !!(iommu->mode->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU);
+}
+
+static u32 page_size_to_shift(u64 page_size)
+{
+	return __builtin_ctzll(page_size);
+}
+
+static int spapr_tce_read_default_window(struct iommu *iommu)
+{
+	struct vfio_iommu_spapr_tce_info info = {
+		.argsz = sizeof(info),
+	};
+
+	if (iommu->default_window.valid)
+		return 0;
+
+	if (ioctl(iommu->container_fd, VFIO_IOMMU_SPAPR_TCE_GET_INFO, &info))
+		return -errno;
+
+	iommu->default_window.start = info.dma32_window_start;
+	iommu->default_window.size = info.dma32_window_size;
+	iommu->default_window.page_shift = page_size_to_shift(getpagesize());
+	iommu->default_window.valid = true;
+	iommu->default_window.dynamic = false;
+	iommu->default_window.remove_on_cleanup = false;
+
+	return 0;
+}
+
+static int spapr_tce_create_ddw(struct iommu *iommu, u64 min_size, u32 page_shift)
+{
+	struct vfio_iommu_spapr_tce_create create = {
+		.argsz = sizeof(create),
+		.page_shift = page_shift,
+		.levels = 1,
+		.window_size = min_size,
+	};
+
+	if (ioctl(iommu->container_fd, VFIO_IOMMU_SPAPR_TCE_CREATE, &create))
+		return -errno;
+
+	iommu->ddw_window.start = create.start_addr;
+	iommu->ddw_window.size = create.window_size;
+	iommu->ddw_window.page_shift = page_shift;
+	iommu->ddw_window.valid = true;
+	iommu->ddw_window.dynamic = true;
+	iommu->ddw_window.remove_on_cleanup = true;
+
+	return 0;
+}
+
+static int spapr_tce_remove_window(struct iommu *iommu, struct spapr_tce_window *window)
+{
+	struct vfio_iommu_spapr_tce_remove remove = {
+		.argsz = sizeof(remove),
+		.start_addr = window->start,
+	};
+
+	if (!window->valid || !window->remove_on_cleanup)
+		return 0;
+
+	if (ioctl(iommu->container_fd, VFIO_IOMMU_SPAPR_TCE_REMOVE, &remove))
+		return -errno;
+
+	window->valid = false;
+	return 0;
+}
+
+static bool spapr_tce_window_satisfies(struct spapr_tce_window *window,
+				       u64 min_size, u32 page_shift,
+				       bool require_dynamic)
+{
+	if (!window || !window->valid)
+		return false;
+
+	if (require_dynamic && !window->dynamic)
+		return false;
+
+	if (window->size < min_size)
+		return false;
+
+	if (window->page_shift != page_shift)
+		return false;
+
+	return true;
+}
+
+static struct iommu_iova_range *spapr_tce_iova_ranges(struct iommu *iommu, u32 *nranges)
+{
+	struct iommu_iova_range *ranges;
+	int ret;
+
+	if (!iommu->active_window) {
+		ret = iommu_prepare_dma_window(iommu, SZ_1G, getpagesize(), false);
+		if (ret)
+			return NULL;
+	}
+
+	ranges = calloc(1, sizeof(*ranges));
+	VFIO_ASSERT_NOT_NULL(ranges);
+
+	ranges[0].start = iommu->active_window->start;
+	ranges[0].last = iommu->active_window->start + iommu->active_window->size - 1;
+
+	*nranges = 1;
+	return ranges;
+}
+
+static bool spapr_tce_iova_inside_window(struct iommu *iommu, struct dma_region *region)
+{
+	struct spapr_tce_window *window = iommu->active_window;
+
+	if (!window || !window->valid)
+		return false;
+
+	if (region->iova < window->start)
+		return false;
+
+	if (region->iova + region->size > window->start + window->size)
+		return false;
+
+	return true;
+}
+
+static int spapr_register_memory(struct iommu *iommu, struct dma_region *region)
+{
+	struct vfio_iommu_spapr_register_memory args = {
+		.argsz = sizeof(args),
+		.vaddr = (u64)region->vaddr,
+		.size = region->size,
+	};
+
+	if (ioctl(iommu->container_fd, VFIO_IOMMU_SPAPR_REGISTER_MEMORY, &args))
+		return -errno;
+
+	return 0;
+}
+
+static int spapr_unregister_memory(struct iommu *iommu, struct dma_region *region)
+{
+	struct vfio_iommu_spapr_register_memory args = {
+		.argsz = sizeof(args),
+		.vaddr = (u64)region->vaddr,
+		.size = region->size,
+	};
+
+	if (ioctl(iommu->container_fd, VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY, &args))
+		return -errno;
+
+	return 0;
+}
+
+int iommu_prepare_dma_window(struct iommu *iommu, u64 min_size,
+			     u64 page_size, bool force_dynamic)
+{
+	u32 page_shift;
+	int ret;
+
+	if (!iommu_is_spapr_tce_v2(iommu))
+		return 0;
+
+	if (!page_size)
+		page_size = getpagesize();
+
+	page_shift = page_size_to_shift(page_size);
+
+	ret = spapr_tce_read_default_window(iommu);
+	if (ret)
+		return ret;
+
+	/*
+	 * Normal mapping path:
+	 * use default window when it satisfies the request.
+	 */
+	if (!force_dynamic &&
+	    spapr_tce_window_satisfies(&iommu->default_window,
+				       min_size, page_shift, false)) {
+		iommu->active_window = &iommu->default_window;
+		return 0;
+	}
+
+	/*
+	 * Dynamic path:
+	 * use existing DDW if it already satisfies the request.
+	 */
+	if (spapr_tce_window_satisfies(&iommu->ddw_window,
+				       min_size, page_shift, true)) {
+		iommu->active_window = &iommu->ddw_window;
+		return 0;
+	}
+
+	/*
+	 * Neither default nor DDW is sufficient.
+	 * Remove only the selftest-created DDW, then create a new DDW.
+	 */
+	ret = spapr_tce_remove_window(iommu, &iommu->ddw_window);
+	if (ret)
+		return ret;
+
+	ret = spapr_tce_create_ddw(iommu, min_size, page_shift);
+	if (ret)
+		return ret;
+
+	iommu->active_window = &iommu->ddw_window;
+	return 0;
+}
+#else
+int iommu_prepare_dma_window(struct iommu *iommu, u64 min_size,
+			     u64 page_size, bool force_dynamic)
+{
+	return 0;
+}
+#endif
+
+bool iommu_supports_unmap_all(struct iommu *iommu)
+{
+#ifdef __powerpc__
+	if (iommu_is_spapr_tce_v2(iommu))
+		return false;
+#endif
+	return true;
+}
+
 iova_t iommu_hva2iova(struct iommu *iommu, void *vaddr)
 {
 	iova_t iova;
@@ -113,9 +342,27 @@ static int vfio_iommu_map(struct iommu *iommu, struct dma_region *region)
 		.iova = region->iova,
 		.size = region->size,
 	};
+	int ret;
 
-	if (ioctl(iommu->container_fd, VFIO_IOMMU_MAP_DMA, &args))
+#ifdef __powerpc__
+	if (iommu_is_spapr_tce_v2(iommu)) {
+		if (!spapr_tce_iova_inside_window(iommu, region))
+			return -EINVAL;
+
+		ret = spapr_register_memory(iommu, region);
+		if (ret)
+			return ret;
+	}
+#endif
+
+	ret = ioctl(iommu->container_fd, VFIO_IOMMU_MAP_DMA, &args);
+	if (ret) {
+#ifdef __powerpc__
+		if (iommu_is_spapr_tce_v2(iommu))
+			spapr_unregister_memory(iommu, region);
+#endif
 		return -errno;
+	}
 
 	return 0;
 }
@@ -177,8 +424,18 @@ static int __vfio_iommu_unmap(int fd, u64 iova, u64 size, u32 flags, u64 *unmapp
 static int vfio_iommu_unmap(struct iommu *iommu, struct dma_region *region,
 			    u64 *unmapped)
 {
-	return __vfio_iommu_unmap(iommu->container_fd, region->iova,
-				  region->size, 0, unmapped);
+	int ret;
+
+	ret = __vfio_iommu_unmap(iommu->container_fd, region->iova,
+				 region->size, 0, unmapped);
+	if (ret)
+		return ret;
+#ifdef __powerpc__
+	if (iommu_is_spapr_tce_v2(iommu))
+		ret = spapr_unregister_memory(iommu, region);
+#endif
+
+	return ret;
 }
 
 static int __iommufd_unmap(int fd, u64 iova, u64 length, u32 ioas_id, u64 *unmapped)
@@ -324,6 +581,11 @@ static struct iommu_iova_range *vfio_iommu_iova_ranges(struct iommu *iommu,
 	struct vfio_info_cap_header *hdr;
 	struct iommu_iova_range *ranges = NULL;
 
+#ifdef __powerpc__
+	if (iommu_is_spapr_tce_v2(iommu))
+		return spapr_tce_iova_ranges(iommu, nranges);
+#endif
+
 	info = vfio_iommu_get_info(iommu->container_fd);
 	hdr = vfio_iommu_info_cap_hdr(info, VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE);
 	VFIO_ASSERT_NOT_NULL(hdr);
@@ -462,6 +724,11 @@ struct iommu *iommu_init(const char *iommu_mode)
 
 void iommu_cleanup(struct iommu *iommu)
 {
+#ifdef __powerpc__
+	if (iommu_is_spapr_tce_v2(iommu))
+		spapr_tce_remove_window(iommu, &iommu->ddw_window);
+#endif
+
 	if (iommu->iommufd)
 		VFIO_ASSERT_EQ(close(iommu->iommufd), 0);
 	else
diff --git a/tools/testing/selftests/vfio/lib/libvfio.c b/tools/testing/selftests/vfio/lib/libvfio.c
index 617c8dc7288c..12f731963b05 100644
--- a/tools/testing/selftests/vfio/lib/libvfio.c
+++ b/tools/testing/selftests/vfio/lib/libvfio.c
@@ -138,5 +138,3 @@ const char *vfio_selftests_get_iommu_mode(void)
 	return get_iommu_mode_env();
 }
 
-	return map_align;
-}
-- 
2.51.1

