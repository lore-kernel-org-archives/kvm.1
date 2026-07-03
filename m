Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BBA33F8C4;
	Fri,  3 Jul 2026 07:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065180; cv=none; b=qY+WBzmqzDVo1hbOZOVQtKbmcxzXwa5Jlg9I8sGOIfjpidouBkXO3q/2NehKjRQKSxA7GQ0E1xRHAdVw823shlKckXVfHeV2uDP2t4yJlzPR6D94tPp5btD82t+Er1898H0uk/1neggswTnLtASLkZaS3x/COrDWVOq9IIvwJaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065180; c=relaxed/simple;
	bh=AwvBI9/izBIUMiYKb/BS+FVRJrEcDVFarBFdazMfVcg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LcofGhrpnA4o077R72IdfgHDUl3m6SJ3gd3vsQfFa9G1Z9uO2DipxpwIFpusDcO+QLtOoB1rq+VZdHBFsD620jQGIK+rYFGQaZSJ/eCu2VxYtSkJ8uT83Q+j+xXtPhQSw77Yuc4D68cBt14FHCP4KCWKrwd0nF4VCCTGlvjwUiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Vv+/+sFX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Vv+/+sFX"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6636IHIb1813621;
	Fri, 3 Jul 2026 07:52:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Kf5cjipweBzt+OwkzYCwSzxpMOmYQC+R/7gb0cFhw
	J8=; b=Vv+/+sFX7rIn+OzrG24fUte/JDaNOStXn5mMsAEgFZLdbll0OSsJyeu8Q
	fwS3zcxWC63jnTKrLbjYWXOnSxtte3uJ5vwVpmAHzMPvkaTUNunf3hbjbsKQgsnL
	qVvBSmMajDj3tfAmvuhEmmgYgWTImkRZX79vkt7FwvFE5C6fEycJ2E9ljsXGlPcT
	TeAhsc2Kl66b7oF8WttoCH+QccU80QtrOTc/kj6zPCT40krSfI/R2uDl/v/jlvV4
	lCNrZMDLzf83llXqioC3KTcyl2SV/CQ+SwwQQ/AsAVE0/lgnaAVYlJUjmiIHvLQ+
	l+dCWoTuiYfffKeFpzNlbzyFi78Xg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rfdg9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 07:52:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6637nd4x005249;
	Fri, 3 Jul 2026 07:52:45 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2sukfth0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 07:52:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6637qff425821596
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jul 2026 07:52:41 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E19D2004B;
	Fri,  3 Jul 2026 07:52:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D25F920040;
	Fri,  3 Jul 2026 07:52:38 +0000 (GMT)
Received: from ltcd48-lp3.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  3 Jul 2026 07:52:38 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: alex@shazbot.org, dmatlack@google.com, shuah@kernel.org
Cc: amastro@fb.com, rananta@google.com, nnmlinux@linux.ibm.com,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, vaibhav@linux.ibm.com,
        sbhat@linux.ibm.com, harshpb@linux.ibm.com
Subject: [RFC PATCH 0/6] selftests/vfio: Add sPAPR TCE v2 coverage
Date: Thu,  2 Jul 2026 23:28:00 -0400
Message-ID: <20260703032806.40946-1-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a476a4e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=gHnokRWe7DPx7BULwhYA:9
X-Proofpoint-ORIG-GUID: Utb6hGfTRETvkvzp1hmbEALAx48JtUJN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA3MyBTYWx0ZWRfX4b56E9SIivnB
 YVKiPkI8Dic3j3isxb+oMJ/eLR54wH6GZLv/AzbfYwrnxkejCcfMxncxqFbE5vXLyIkzmqYwG6v
 zBTWgrrKdeM5q+xwZv7SRZYD6OxlM2IYKCTbnWcu5Cu+vvwgU8cI8otnkPe1TFvnucQhmqeuxHt
 ijPSa7aeWru94W58VvbJcshSm8Pl6KAUNHwLJ9/8UCzuXFA3SMt0ahW+ohl0V8u1zVhasaoJq22
 Z2xiLcotrShHXwPxM99SG5CjIjrYvZ0UyekK3PyUD9X6IeCz4MLqzCDGsx2/XW93Ggfq0sqH9qq
 PtXPavD4ORNHyKJZXJdJ0MEjQYLINzUflPlrcsNtn4SPqkEcCK/uklZOL1r8WM/+R2BBZR+C1Pv
 lBVa+69sbOetlgULEkFMU6rCQykzZLPx9/ARb7b+FTKEOg4qjUHto2TWM8Z+g6LReyZK2VvxUA1
 o3TpfEbaXVcJiK7V3NQ==
X-Proofpoint-GUID: 13nlmIytZvLGCNIOzwvM03cvUlTQaRvO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA3MyBTYWx0ZWRfX+/1fySgYHR4K
 ag92oxktN6S6Io9RT5UfNDznm0LqgIDWC5uen5F3okWT/1/RSJ35tuOS6UXs53+XzKXVKOBOlVt
 J9uSMNmF9V2VVIja6bgir2PSFrNwkmE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030073

This RFC adds PowerPC sPAPR TCE v2 support to VFIO selftests.

The series adds a selftest IOMMU mode for the legacy VFIO container
backend, adds helpers for default and dynamic DMA windows, and exercises
the sPAPR DDW path through the DMA mapping tests.

sPAPR TCE v2 remains a legacy VFIO container backend. This series does
not add iommufd or VFIO cdev support for sPAPR.

The main points are
1. add VFIO_SELFTESTS_IOMMU_MODE for selecting a backend
2. add vfio_spapr_tce_v2_iommu as the PowerPC VFIO backend
3. preserve the platform default DMA window
4. create and tear down only selftest-created DDWs
5. prepare the DMA window before IOVA allocation
6. exercise DDW creation for hugepage DMA mappings
7. accept sPAPR-specific errno for invalid DMA ranges

Example:

VFIO_SELFTESTS_IOMMU_MODE=vfio_spapr_tce_v2_iommu
./vfio_dma_mapping_test <BDF>

Observed coverage includes anonymous mappings through the default window
and 2MB hugetlb mappings through a DDW. 1GB hugetlb mappings may skip when
the platform rejects the requested DDW characteristics.

Feedback is requested from the VFIO and PowerPC communities on:
1. whether the sPAPR TCE v2 helpers should remain in the common VFIO
selftest library or move into a sPAPR-specific test helper?
2. whether DDW setup through hugepage mappings is the right initial
coverage?
3. whether the sPAPR-specific overflow errno expectation should be
accepted, skipped, or hidden behind a backend helper?
4. whether PowerPC should generate only the sPAPR TCE v2 fixture variants,
or keep the generic IOMMU-mode matrix and skip unsupported modes.

TODO: vfio_spapr_tce_v1_iommu yet to be covered.

Narayana Murty N (6):
  selftests/vfio: allow selecting IOMMU backend from environment
  selftests/vfio: add sPAPR TCE v2 IOMMU mode
  selftests/vfio: add sPAPR TCE v2 DMA window helpers
  selftests/vfio: Exercise sPAPR DDW path for hugepage DMA mappings
  selftests/vfio: Accept sPAPR errno for DMA range overflow
  selftests/vfio: Enable VFIO selftests on ppc64 and ppc64le

 .../selftests/vfio/lib/include/libvfio.h      |   9 +
 .../vfio/lib/include/libvfio/iommu.h          |  26 ++
 tools/testing/selftests/vfio/lib/iommu.c      | 280 +++++++++++++++++-
 tools/testing/selftests/vfio/lib/libvfio.c    |  37 +++
 .../selftests/vfio/vfio_dma_mapping_test.c    |  30 ++
 .../selftests/vfio/vfio_pci_device_test.c     |   4 +-
 tools/testing/selftests/vfio/Makefile         |   2 +-
 7 files changed, 382 insertions(+), 6 deletions(-)

-- 
2.51.1

