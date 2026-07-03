Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DB338888E
	for <kvm@vger.kernel.org>; Fri,  3 Jul 2026 09:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783069233; cv=none; b=nmm9s+oz16hr+IbXLax+rgDcuVaEFheESHEDTdJ/CH6vXpoz7pUlScDV7xumaxenNuqr030uhEE36DhTozN6q7HTMyHN8l2sexydZLWQC7ExiBPi8i+RmJg0gIDEYhQG386Llk7gWvX58HA2CjBCaIhA9Znb6I6B4NGTaw40QbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783069233; c=relaxed/simple;
	bh=MJsCIZWnUtIy09XC0KgJHchUCdrpvNs1hfTBFaVzt4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C1pqzuPP1tJirNGHy0ezooW+2yKAahscIZ+POk+DVkaw9vDrUnF7OftAbGvPRSyvYAFp1I1NOEzwWJ2P1H/OZDToYM7y2UsRAiyncBiiPYs6YTXnBtjxIoI0Ysrgrr2oAM2vQkLGm6j3x5GEIQ4QcWSps13oI3b4pNJyXuR+QHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qn4E+nag; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qn4E+nag"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6636ISRQ1761150;
	Fri, 3 Jul 2026 09:00:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=uMCbhtvci3QH9o/ymDSFhhHBmcQF
	1YKHKKH4JDEQ/50=; b=qn4E+nagpX3H27AtZejYNIMyRbFjWde2eMyD09nXY/fu
	kfEJEecnn2t47YXmV4Tble8/VM6UGqBZILn1s4AZmJLutj5xChC2VAhtl8q2v3HU
	sZMgiymZdadzpqx7DA7fnTPf0iugr4mri/ujXa4F7n76u7slEFzlNRGsMF4tDLro
	76jaGieemk7d9wsZPqdmwtRrDGnRKXlbc5St2Eh9mS3JdVoWWxmlNWBhL0PTTMQe
	NcgDifF7A/+rym4Wa4zTMAuVnowRLIiZjzV/vErkRkC1pt9H4xRzySuqIcdksHGS
	i4uZu0S3ZkkfJBTCZA4svhv3qJt6OCQ/9SNsIpsavw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mk5w0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 09:00:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6638nelw003261;
	Fri, 3 Jul 2026 09:00:10 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2sukg1hd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 09:00:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 663905cV42008836
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jul 2026 09:00:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C225020043;
	Fri,  3 Jul 2026 09:00:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAF962004B;
	Fri,  3 Jul 2026 08:59:58 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.124.212.167])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  3 Jul 2026 08:59:58 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
        Laurent Vivier <lvivier@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
        Misbah Anjum N <misanjum@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        kvm@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>,
        Chinmay Rath <rathc@linux.ibm.com>,
        BALATON Zoltan <balaton@eik.bme.hu>,
        Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Subject: [PATCH v4 RESEND 0/8] powerpc: Testcase improvements and Power8E/NVL removal
Date: Fri,  3 Jul 2026 14:29:47 +0530
Message-ID: <20260703085955.2318600-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA4MyBTYWx0ZWRfXwDw+fLccSAVC
 YOHXf1Mub2iPo9fvIBCs5s+dP6Tk9MUDRWlEXtpArZ7jIYRtZqQv+XKHpJUP43ZAsUJfAdV5cVB
 /N8xG5d0aL5e+LqI7h3NC1lH1q4nvZXytEpsruQ/n/1+47i8z/Z5Euvb6ckurqjHr7I2vlws2uR
 Fg4qvdcCkrK5U1BMhqb5ClIAR44unMaZ3PZN+W6N2+Bmy4weHJfZET00qjkeMhS2VhtBjbQzIjO
 nfqnlPViCOMOaM2nTPkuZwmO9JLkqBj+JhTFmSZdxlEy+9KHrCSQrAMmmF6f3vQsMj36CE0psYU
 y5EAUSg4x03x/twYDLpYmpLjpQdYY+HjSsFtxVRzuUwGovIWpDhu4RcuHOKCNXpAZIizB0EW6HM
 24sShQR5Leb7WF+mhYLq101cEQz0i1W8FQgPM/z6F8HjL7YY6or8cJmNoy83KMMeO9WmM4Dpydm
 XMtvLJP9YXwifu43AOg==
X-Proofpoint-GUID: SWVTBenURAVv_jwPHWyu4K-v10z7-v5j
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a477a1b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=p0WdMEafAAAA:8 a=MdZrTe2ayghipT-8awEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA4MyBTYWx0ZWRfX6mHoBgIhzt6h
 O1ztCKyYwHwg40/UR5k1een7fk64JUbZi9cOIk947cPAyrsOSPepi+8K8TKTJaX8bhlZjyRmoBo
 WKxnHVpA1Oh2R5BfguD267faozdW8Ko=
X-Proofpoint-ORIG-GUID: QnKD0MYaUfdibC5RfWE_6y4L2epGOYmz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030083

Overview
========

This patch series merged two patch series sent earlier:
	"Testcase improvements for PowerNV"
	"Remove deprecated Power8E and 8NVL CPUs"
since the Power8E removal series depended on the former due to pnv-spi test

Broadly contains 3 changes:
1. Testcase improvements:
    Add a testcase to detect regression in remote interrupts when XIVE changes,
    since such regression had occurred during Power11 XIVE changes:
    https://lore.kernel.org/qemu-devel/baf6c854-832b-4a2e-922f-d34e6dadf821@redhat.com/

    Also add Power11 chip and testcase in qtests, and fadump functional test

2. Power8E/Power8NVL removal
    Power8E and Power8NVL were deprecated since QEMU 10.1, with
    commit 264a604e7163 ("target/ppc: Deprecate Power8E and Power8NVL")
    
    Hence, remove usage (chip and core types) of Power8E and 8NVL from PowerNV,
    PSeries as well as testcases.

3. Maintainer changes
    Add myself as maintainer for PowerNV machine

Testing
=======

* Git tree for testing: https://gitlab.com/adi-g15-ibm/qemu/tree/feat_maintainer-v4-resend
* Gitlab pipeline: https://gitlab.com/adi-g15-ibm/qemu/-/pipelines/2649114622
* Successful ppc64 functional tests, qtests, boot tests, builds at all commits

Changelog
=========
v4-resend:
+ rebase on harsh's PR, https://gitlab.com/harshpb/qemu.git, tags/pull-ppc-for-11.1-misc-20260703
+ no changes to patches, merge conflicts fixed in #1 and #7

v4:
+ #1: added cores=1, as suggested by cedric, no functional change
+ #3: remove unneeded headers, as suggested by cedric
+ #3: keep power10 xive2 test, as suggested by nikhil

v3:
+ #3: use machine_type array in pnv_xscom_addr, as suggested by shivang, harsh and balaton 

v2:
+ #1: put e1000e on socket 1, and disable it's cpu, as suggested by cedric
+ #1: pull out command fail checks into a helper, as suggested by shivang
+ #2: use g_autofree, suggested by cedric
+ #3: use g_autofree in tests updated
+ #8: remove G:, as suggested by daniel
+ rebased to upstream

from previous split series:
+ #1: added checks to see if network is up and interrupts happened, based on shivang's review
+ #3: replaced common if-else-if check for machine type with pnv_get_machine_type
+ #7: added doc in removed-features, as suggested by cedric
+ #6,7: added rb from philippe
+ #8: new patch, maintainer change

Aditya Gupta (8):
  tests/functional: Add remote interrupts test for PowerNV
  tests/qtest/pnv_spi: Test Power11 PNV_SPI
  tests/qtest: Add Power11 chip & machine to qtests
  tests/functional: Use default powernv machine instead of power10
  ppc/pnv: Replace Power8E with Power11 for 'none' machine test
  ppc/pnv: Remove Power8E and Power8NVL pnv chips
  ppc/pnv: Remove Power8E and Power8NVL CPUs
  MAINTAINERS: Add self as maintainer for PowerNV

 MAINTAINERS                            |  2 +-
 docs/about/deprecated.rst              |  9 ---
 docs/about/removed-features.rst        |  8 +++
 docs/system/ppc/powernv.rst            |  2 +-
 docs/system/ppc/pseries.rst            |  2 +-
 hw/ppc/pnv.c                           | 62 -----------------
 hw/ppc/pnv_core.c                      |  2 -
 hw/ppc/spapr_cpu_core.c                |  2 -
 include/hw/ppc/pnv.h                   |  8 ---
 target/ppc/cpu-models.c                |  6 --
 target/ppc/cpu-models.h                |  4 --
 target/ppc/cpu_init.c                  |  6 --
 target/ppc/kvm.c                       |  4 +-
 tests/functional/ppc64/test_fadump.py  |  2 +-
 tests/functional/ppc64/test_powernv.py | 95 ++++++++++++++++++++++++++
 tests/qtest/machine-none-test.c        |  2 +-
 tests/qtest/pnv-host-i2c-test.c        | 10 ++-
 tests/qtest/pnv-spi-seeprom-test.c     | 20 ++++--
 tests/qtest/pnv-xive2-test.c           | 21 ++++--
 tests/qtest/pnv-xscom-test.c           | 22 ++----
 tests/qtest/pnv-xscom.h                | 38 +++++++----
 21 files changed, 175 insertions(+), 152 deletions(-)


base-commit: f9d05801eb4acd6402d73cb25d498a2419920cf9
-- 
2.55.0

