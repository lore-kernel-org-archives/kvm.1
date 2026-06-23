Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942C23845C4
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 14:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782224431; cv=none; b=DQQ7vfTjaIBFULnq8g1xwVQBYwN3/OVmRDoViNp5XrndnDKdUu0BmS1y1TkL2xDf70G9f29NHVi6V3Zn/9U168yni2clGj0++HNaSiSYOgOlLAFmuoG1m9x/f1qD+f/7XsYj1ZP9iwDHk2T8Ty8akqHp3RxrGnUKn3aVUYNJZz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782224431; c=relaxed/simple;
	bh=4t5JTI2MaSN7S+O2myJbDi35bV7PdthmBBhKOr7HxHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kgx8GsOAF6P+3Bl/MDyyCvNSHhi4uU9MJDzd92UlIuIsBAvVZKQxaicZXa4mh9739IVwMvH+K0mpObVF4nQMNG/6ww0omGgjOetL+UQcs1kYy3ajDEdVLvmVtu7R9UsnAvR2puIbNEEifKqRy0NHa0p2hxT4QSoPYYnFDp0DlhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fhrpMuJM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fhrpMuJM"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBmX5d1826580;
	Tue, 23 Jun 2026 14:20:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=CUAoJ8p0ugdmCmHB7df02uX+rXFD
	iGUd6/dwrT4NUmg=; b=fhrpMuJM7hvVYjNyASkTCVg7/ilykEUnESFIz5C1J4r8
	BD4aAK8uGDYe0R0ZerNlogwy4WpDHt9OnOmutrXTOZNa0tWePAaRD+feyLeoU0d9
	wKm2i9QJTGDlU5O1mzziXnk7KWeFRAzK8fRrpZ+6nZg70eCH/sb/yb9KM/TYVdWB
	nNPaA1OQHx3OW3hq6m4Lbs+3ZGKUurlkWy+fMhNHYGboRWYS2+GSXst/UUOKkkSk
	RhP6dBxUM+P8ttIG0apVGzpBcMJ4frsXByUrp8hVc4b3p6NXWONtxTFuy0ZhLmtT
	VhBeT+HS+LraFDbcwW4V5wycdMXzsrgMmVIUdNlwig==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjgspu95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 14:20:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NEJc27005016;
	Tue, 23 Jun 2026 14:20:13 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vykbc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 14:20:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NEK9gV42664406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 14:20:09 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48B3E2004D;
	Tue, 23 Jun 2026 14:20:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F36B2004B;
	Tue, 23 Jun 2026 14:20:00 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.39.19.165])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 14:20:00 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
        Laurent Vivier <lvivier@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
        Misbah Anjum N <misanjum@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        kvm@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>,
        Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH 0/8] Testcase improvements and Power8E/NVL removal
Date: Tue, 23 Jun 2026 19:49:25 +0530
Message-ID: <20260623141933.577981-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDExNyBTYWx0ZWRfX4CipXPYSioVU
 yZfYA7UBBGStnI+XXX+c9+yhIEd2mtk+iSa1/hKsEH21eqyLy/YoiIy7LiuEJQlhyD9MJeuqKFJ
 3LT2gNbdUD9LBLLvATmUUpCGSKcVH1amYs3e5hiSXP5DOEfxMlvIXbMzCTfH0Gu/o7H1Hja0BSx
 UdHvtHAyHFNZenowdVLIdiU03RQ0jsIhXjDRp4HJUE8mu3ncAhfC5o6IwqrovB/Z8mEFGHtn7ZL
 F5pmOsOfKBjssXFyvhQih3L5uYw1ueKVC0y9JQN22LN/jq7SbARdvRSbGNYRVcsBOlBik2LYYc+
 vHRoMt/XlJA1DHFPDkQmtRlJ6Z+wkwCb7e4R828ldHAdG9MjqTJBIj/GONj3zC7zTDHhcWsaal4
 2FGzVJQkUSS0M+Sd96QXlu02CKqhcA==
X-Proofpoint-GUID: iZhE164iKCMnI6fZcBcPREXCNwa5CCdY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDExNyBTYWx0ZWRfX42Ripx+neLN+
 I2o+i7MJKvlXwXKUsgTQWsBKal9ZDGWZ+/pUZMKYylc2dYA1phiDAsnY1oxDU2J8bDeRJtyHnaw
 eGTrnSr1xSHX/nJdKRLbVNIiuNPcTlw=
X-Authority-Analysis: v=2.4 cv=I/lVgtgg c=1 sm=1 tr=0 ts=6a3a961e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=p0WdMEafAAAA:8 a=xPYodxo2Y1BMSrPa6RgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: IuzRtZfE9ioQHp0MR-LzwGG5j6q6p47v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606230117

Overview
========

This patch series merges two patch series sent earlier:
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

* Git tree for testing: https://gitlab.com/adi-g15-ibm/qemu/tree/feat_maintainer_refresh
* Gitlab pipeline: https://gitlab.com/adi-g15-ibm/qemu/-/pipelines/2622995621
* Successful ppc64 functional tests, qtests, boot tests, builds at all commits

Changelog
=========
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

 MAINTAINERS                            |  3 +-
 docs/about/deprecated.rst              |  9 ---
 docs/about/removed-features.rst        |  8 +++
 docs/system/ppc/powernv.rst            |  2 +-
 docs/system/ppc/pseries.rst            |  2 +-
 hw/ppc/pnv.c                           | 62 -------------------
 hw/ppc/pnv_core.c                      |  2 -
 hw/ppc/spapr_cpu_core.c                |  2 -
 include/hw/ppc/pnv.h                   |  8 ---
 target/ppc/cpu-models.c                |  6 --
 target/ppc/cpu-models.h                |  4 --
 target/ppc/cpu_init.c                  |  6 --
 target/ppc/kvm.c                       |  4 +-
 tests/functional/ppc64/test_fadump.py  |  2 +-
 tests/functional/ppc64/test_powernv.py | 86 ++++++++++++++++++++++++++
 tests/qtest/machine-none-test.c        |  2 +-
 tests/qtest/pnv-host-i2c-test.c        |  7 +--
 tests/qtest/pnv-spi-seeprom-test.c     | 21 +++++--
 tests/qtest/pnv-xive2-test.c           |  2 +-
 tests/qtest/pnv-xscom-test.c           | 19 ++----
 tests/qtest/pnv-xscom.h                | 42 +++++++++----
 21 files changed, 154 insertions(+), 145 deletions(-)


base-commit: b83371668192a705b878e909c5ae9c1233cbd5fb
-- 
2.54.0

