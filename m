Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201243B9DAD
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 09:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781082525; cv=none; b=KvJKsUHDi8Nv12TGBk46poJ6z0DEs+FGkmaMWHti8d9qRHiPT4NqbzOZmev+imbQPyDOzinFzBCcTD97nY/dmKthEbt6siXXJlwZgxHZS4r0dbsEG499xdSaqAe8Vje+CDdM5ke0d7hqr/nbkS+CjIVxzIagwDUcNqlBovOi1kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781082525; c=relaxed/simple;
	bh=QmQyLGOn37e92NwGJTsi8d7lJOeuYGrjPovWQ+0EkKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AD/xMwn72ZCIapyvWrYWRIHt7JV/F6ghtUf30sJlJ83BCdIwrhlv/j7hLGRN9KQiRp+BKqtql32lGjZaPNgDMNi52DKjlgd4mlAUxn2KI83YJuZ+X8Eo86VpR/fx++8XHFiv8X7wDyYLztlNBqkslGJLxtjeBipo3cCJvFmJYHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=egCEvB7+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="egCEvB7+"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A58QsP3475344;
	Wed, 10 Jun 2026 09:08:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=KI8J/kvZgcd9IVk11qYaApT/ziioMMz1qP0/hRi1I
	K8=; b=egCEvB7+ZaaIAqASxLFKYgyOLoCutExb9A1NgPoUzpHBq/f9ufBsj5lQ7
	wjXsA2MT1LRFFqTO2BO40la1WQZUYq2SE2oVEzrB1FcQh8s68Ao4hTnuqbJ0HU4r
	dlx6345jjSy9q3DbP3hqfhxul/26jy/Ne9qXhYnP/MtD01mnSI8RhmUD7zV0BaA0
	PgrScqUBj8pr8FlNPQ2oszBy9kEmFdxxagGZs7w2KPfHj9LeJELkIeSDNxEV4nFJ
	mfpT91P30wn7QRNx0J92K5i93CkL4w4cssuBDvymuTFQrCrtsgFzvCTJAzYXUUdY
	sEBGL5CfDATmNf9lZwehOWY31PIWw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yj05sc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 09:08:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65A94a1d009446;
	Wed, 10 Jun 2026 09:08:25 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvq64c3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 09:08:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65A98LOY25625036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 09:08:21 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 478F02004D;
	Wed, 10 Jun 2026 09:08:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E0012004B;
	Wed, 10 Jun 2026 09:08:16 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.39.29.92])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2026 09:08:15 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
        Laurent Vivier <lvivier@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
        kvm@vger.kernel.org, Misbah Anjum N <misanjum@linux.ibm.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH 0/4] Remove deprecated Power8E and 8NVL CPUs
Date: Wed, 10 Jun 2026 14:37:56 +0530
Message-ID: <20260610090800.3672832-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA4NiBTYWx0ZWRfX3F96cGIPeAnn
 S9wnVd8XQD3odJHkOG3DwhXGrENszx1NzYkfMNrWdgJ9/Y0sdDZyoWZOWHHE/TwGUBakEGBtsCf
 7WyYJcQwe5PyM1I0xUKUn83M9zN2u5HlIU8bpH/NqURJqjXsCv2Zm/jYgH72UnjQtgsbGbL/+4c
 ayi33h1cdctpIAvcoZHFcgl2bczF5juJ7UWSCJYWfxgvTdoOS7HGNrMS8f8eqyqLe9tdYIlsNM5
 rhQsq1k2IlNFIDprKgwlapRwToY8YDTV5Z9byJfLWAlzpO9kNokrw2Z6GMysZlw20OigmNW7RAx
 PQq41mOF6aSQikvIlTLhUftQJtxyXK3uGsSaqw0D5XZl7iu+tXSkIUKpI0bIgEyPneaZYPvVJe6
 vBaZ+CyPOcwme0VUJgfpt8BMtDH36xeBP0oL7uMIkauFmqPV2986serMAC2CwZkAamTT9AvlUoc
 doc0qgfxrg3csDdsNag==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a29298a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=ZVU-iFHBdA2WAzVyw6oA:9
X-Proofpoint-ORIG-GUID: 6PvToHLtHDcG3YRtqiRCWNl65v0sksfK
X-Proofpoint-GUID: mrjOKFOn9R0oyWy4GEiU7k2BOprC5KnC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100086

Overview
========

Power8E and Power8NVL were deprecated since QEMU 10.1, with
commit 264a604e7163 ("target/ppc: Deprecate Power8E and Power8NVL")

Hence, remove usage (chip and core types) of Power8E and 8NVL from PowerNV,
PSeries as well as testcases.

NOTE: PRE-REQUISITE: Requires following "Testcase improvements for PowerNV" to be
merged first:

  https://lore.kernel.org/qemu-devel/20260610090235.3665904-1-adityag@linux.ibm.com/T/#t

Aditya Gupta (4):
  ppc/pnv: Replace Power8E with Power11 for 'none' machine test
  ppc/pnv: Remove Power8E and Power8NVL pnv chips
  ppc/pnv: Remove Power8E and Power8NVL spapr cores
  ppc/pnv: Remove Power8E and Power8NVL CPUs

 docs/about/deprecated.rst       |  9 -----
 docs/system/ppc/powernv.rst     |  2 +-
 docs/system/ppc/pseries.rst     |  2 +-
 hw/ppc/pnv.c                    | 62 ---------------------------------
 hw/ppc/pnv_core.c               |  2 --
 hw/ppc/spapr_cpu_core.c         |  2 --
 include/hw/ppc/pnv.h            |  8 -----
 target/ppc/cpu-models.c         |  6 ----
 target/ppc/cpu-models.h         |  4 ---
 target/ppc/cpu_init.c           |  6 ----
 target/ppc/kvm.c                |  4 +--
 tests/qtest/machine-none-test.c |  2 +-
 tests/qtest/pnv-xscom.h         |  9 -----
 13 files changed, 4 insertions(+), 114 deletions(-)


base-commit: de5d8bfd6105d3dd3ae668df9762df244a6d1506
-- 
2.54.0

