Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E1E372071;
	Fri,  3 Jul 2026 07:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065189; cv=none; b=IxTX5heClE/3yLkpRUys5h+zvmVKfhNcldwLZCNcbjpfhDMMcc0DjPn4dSG96G3gE/2hteSPvczz1+UdLAytDGcZ1VSvd34HfrmJeGTcjZuPiD2gW/z2UVuiM+dA6zjMJ+ecIOxNGFThj2IgHLLCW9T1ec2gKoQeBBdh8poXnIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065189; c=relaxed/simple;
	bh=Xde9GsFfZ013GmS5PopLHZlTObuLZSeaMJHg8FDp2Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZ6XUE6BpTcN/P0f/i9/jZi8ySHPIdjZ5fZ9WhT5SRh3kIS+k15rTYzos6NU0DrrYJsPsqrXVR/XieTTuvjBMccTCEp0g0Ymi+bmgTCJRzr5K6N1IAH31q8vVezF1Lq/D95vCqe9NwuSUXwjZyvevWZB/8BfvjZyVGPTvakvJBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TZq1AG/4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TZq1AG/4"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6636IOVE1930789;
	Fri, 3 Jul 2026 07:53:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7Pu5OhSEquSgInD7w
	5ZNZ6Val/7whXyk0Py0ueq2x2c=; b=TZq1AG/44yA4DtzK/MmJikTSLsZZv0CnJ
	eYffuwzoNiPR++d3FzVfutstvrjngmxRFIAtUxPz16s+TONs58hrxR+3gUsexGS4
	V/PbWfd39e0ESCZcjTHZ7NEKoZk/WQ0IYYU5AKhtV4gbAsX5D5tje7PoHoYn3voL
	9J2sp4N8svMtTdy3YEemWko+/f1fh3q1VqE4CSUBtMQQPfF+6I77v2PhDkQJvn56
	QF6AKjkB8Q+n6mG4yMepqm8e6/MLntZlumCNBFXnPH/ABWOCTBpwMQxs3AbrKh9C
	NJcPWSQoXgwxx4d7qB4C4Gvx/vibUBjiOALXZPgknGNgZ5wnqAIyQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pee5cg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 07:53:02 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6637Ygdn015778;
	Fri, 3 Jul 2026 07:53:01 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruqr1k2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 07:53:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6637qwBf43516408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jul 2026 07:52:58 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 184652004B;
	Fri,  3 Jul 2026 07:52:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF6E720043;
	Fri,  3 Jul 2026 07:52:55 +0000 (GMT)
Received: from ltcd48-lp3.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  3 Jul 2026 07:52:55 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: alex@shazbot.org, dmatlack@google.com, shuah@kernel.org
Cc: amastro@fb.com, rananta@google.com, nnmlinux@linux.ibm.com,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, vaibhav@linux.ibm.com,
        sbhat@linux.ibm.com, harshpb@linux.ibm.com
Subject: [RFC PATCH 4/6] selftests/vfio: Exercise sPAPR DDW path for hugepage DMA mappings
Date: Thu,  2 Jul 2026 23:28:04 -0400
Message-ID: <20260703032806.40946-5-nnmlinux@linux.ibm.com>
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
X-Proofpoint-GUID: z58L6XmDvbOJpy9P2SjleV_W5a6t12JW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA3MyBTYWx0ZWRfXwXaQqlKIp/s8
 uY58/KDaLC6+G0dSAkwtOdTY42Toun5BYmMlkonjoufDksNy2bLX8t/qaqjVD8NVqBV3fYHcMZq
 l15q4jmC2zasGoL7ytUUWJjfr3SaFCE=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a476a5f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=2G2nDU4NYoFZ38ClX_0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA3MyBTYWx0ZWRfXzcz8s52W/90j
 Ca0TEX/qfgV9mjpdRZl1uD1aaBuCQ5p0TSaUi8pX2pDgMMLRm3KOXE6aZaBdlc/hBrtFXixunWh
 1mwluG2z5J7JTbkCFfipKik+GF4ZjC4USqR51BjED9D3jGaTNzB2EOpa8RVvddk+UaIL3u9mWIA
 A/AYD77R0Uld98q3uQtBjy7HgBdwk91UGUApqpTp7ilrBZCQ7w8il84UeVpacglmOB6+tD+2Vmb
 QaD+iw7sf9lL9/eO4LiSLL+b2lzc/DMegWGmnJ5YN5mSKGOdsfW3q9Rp1G69gLiMktuhFlt74CH
 F6WseEHpkkt2pbHM+U6sqlUD0NKkRrn9OeFkoPnES5V7HT+yhMt56HvQYbMHx9NJA4DwBC8/YHX
 BB1+oPGD4U60h3i81X4rkegHTePg7Z7969C7CgeLqCI2ZqKSrt/DC24xODz2t1cYS6OAyKh4JTZ
 V6FawJ4WhMo90lBlr7A==
X-Proofpoint-ORIG-GUID: HakpZ2oA9MDErS4byJQajTnBj6M6BNPD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030073

Prepare the DMA window before IOVA allocation in the DMA mapping tests.

Anonymous mappings use the default sPAPR DMA window. HugeTLB mappings force
a DDW with the requested page size, allowing the test to exercise DDW
creation, mapping, unmapping, and cleanup.

Skip gracefully when hugepage allocation fails or when the platform does
not support the requested DDW characteristics. Also skip unmap-all when
the backend cannot pair it with the sPAPR memory unregister flow.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 .../selftests/vfio/vfio_dma_mapping_test.c    | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
index 7d0de8c79de1..4411fdbd56da 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <stdio.h>
+#include <string.h>
 #include <sys/mman.h>
 #include <unistd.h>
 
@@ -119,8 +120,19 @@ FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(anonymous_hugetlb_1gb, SZ_1G, MAP_HUGETLB |
 
 FIXTURE_SETUP(vfio_dma_mapping_test)
 {
+	const u64 page_size = variant->size ?: getpagesize();
+	const bool force_dynamic = !!variant->size;
+	int ret;
+
 	self->iommu = iommu_init(variant->iommu_mode);
 	self->device = vfio_pci_device_init(device_bdf, self->iommu);
+
+	ret = iommu_prepare_dma_window(self->iommu, page_size, page_size,
+				       force_dynamic);
+	if (ret)
+		SKIP(return, "DMA window unavailable: %s (%d)\n",
+		     strerror(-ret), -ret);
+
 	self->iova_allocator = iova_allocator_init(self->iommu);
 }
 
@@ -227,6 +239,7 @@ FIXTURE_SETUP(vfio_dma_map_limit_test)
 	u64 region_size = getpagesize();
 	iova_t last_iova;
 	u32 nranges;
+	int ret;
 
 	/*
 	 * Over-allocate mmap by double the size to provide enough backing vaddr
@@ -236,6 +249,13 @@ FIXTURE_SETUP(vfio_dma_map_limit_test)
 
 	self->iommu = iommu_init(variant->iommu_mode);
 	self->device = vfio_pci_device_init(device_bdf, self->iommu);
+
+	ret = iommu_prepare_dma_window(self->iommu, region_size, region_size,
+				       false);
+	if (ret)
+		SKIP(return, "DMA window unavailable: %s (%d)\n",
+		     strerror(-ret), -ret);
+
 	region->vaddr = mmap(NULL, self->mmap_size, PROT_READ | PROT_WRITE,
 			     MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
 	ASSERT_NE(region->vaddr, MAP_FAILED);
@@ -277,6 +297,8 @@ TEST_F(vfio_dma_map_limit_test, unmap_all)
 	u64 unmapped;
 	int rc;
 
+	if (!iommu_supports_unmap_all(self->iommu))
+		SKIP(return, "IOMMU backend does not support unmap-all\n");
 	iommu_map(self->iommu, region);
 	ASSERT_EQ(region->iova, to_iova(self->device, region->vaddr));
 
-- 
2.51.1

