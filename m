Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370D5314B6E
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 11:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782731114; cv=none; b=D0k9vyf5WEIpM63PlxS/J86dYN8yBsGxTfEyPkJ8vnvbaCHe1CCK5yNLxD/3JNg+jlim6vtz4TrVAYstZU7f02metU/p1iInXE9S1K9I0HxU56aowSD9GTYFv7Tp6wswKzJ23ScuwEZbU7zXAtGZ5d3WC4PCBwOYAn74yzQkLf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782731114; c=relaxed/simple;
	bh=mZTK1N1q0uYhXcl+hK5RmgehAE1C2QcB34omkQ94GrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q6btj7gM0sYkIKRbJ0z4qqHwEVcrKzXe/n+rM5Iez/3X087NHiRiym0vVk/+BkxdPWmrQJlka2bs79n/xTfoAjHniCbbs6ROJxXKRHs5OxXzgfc+IKzOHjgUaEuYkDqlCQLfLnZZiXx62dKFK8MMAd0OSNuxuA9ex3w288oEyxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZIg63Ptv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZIg63Ptv"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TAmV4g2921656;
	Mon, 29 Jun 2026 11:04:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=Scrq/63S7aRsfDjeHiOaXZiZ86NM
	68o8r5/1D5MALa8=; b=ZIg63PtvcK+d/yfH2NnCmW7zN69J2/zzjKFfUSjvvbVO
	yLCK84QthAf0wofNo6DY07m5R3DhoPPBqbsH05mvQe1Yezik0Ri2hCRjlYYP3Eb5
	5/OFHc2dEM1oGMKeWZLZvHlYRIdBgXWcutWYLio1lRT+I8I5iODoDuQlBIwBA1aP
	iWs3JJKl7KhKl0V9L2Q5L+acRGgxYq8GLCHuPNuoXKGYS1Bdx22idFT2OcSJ1kVM
	aiNalGYxQIg4i1jjeqgFsVn9qrgaiBdUbhjcRjud3YK61UcM0GG/IWAw+dB3goyn
	KD+rqsqRDOQQ09XdaXgCIQCP/w6irJMka5gLhA5HXg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26q9rqj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 11:04:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65TB4ffx022193;
	Mon, 29 Jun 2026 11:04:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2sujw2ju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 11:04:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65TB4mmX50397640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jun 2026 11:04:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB1C820043;
	Mon, 29 Jun 2026 11:04:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34B2C20040;
	Mon, 29 Jun 2026 11:04:44 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.bl1-in.ibm.com (unknown [9.123.10.203])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 29 Jun 2026 11:04:44 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
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
Subject: [PATCH v3 0/8] Testcase improvements and Power8E/NVL removal
Date: Mon, 29 Jun 2026 16:34:03 +0530
Message-ID: <20260629110411.3051274-1-adityag@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA4OCBTYWx0ZWRfXy5R67HyKVeAX
 ptIBBQHTnoBo/aalJ4x0YlMpTJzNe3Wxl6k9sWMDoGKTlnuZKzUFRhaWYMyJYjcChUZAZ8+PZuG
 ivqML0TlRPLmKSmWGXhnFdpAUJs/5rBMJOvqGDblDkTTji9z3v4BKpEnQSpyqm0PQi2NrJ9lcsx
 6Xo1hHJdjblczi46JxHx8vWpsdNnsWmg54q7JjSZp9tFzkuTJpp5kFRHr/+hDzG85OwA+F23A1e
 uWgtWgyap7O0QhdDtZLz16yUA2d1WhaZpxDYJCf9Dinxc2DwtTeQ8/MN0E6Q+oJHJKfxgBmMcdk
 H+CMYzY/0WY7QP64BR8m+qSrr6v0pO9YCxOBChWstwOXITWFshF29PRKtrpnoDid7qPChodfoZg
 70auIfXFrLcaKfr4WufhPR3ZmLUtVclZgJfZaKl82Me6OFxkwIMwNRGpDgd4Hh1EGR2CQmKUOWG
 JlNb86Iv8d/HSMZnEdQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA4OCBTYWx0ZWRfX6nPXRSMOkm02
 fSmrLwE9KeBzFfp/bLL11xs/A4rjWhfj4nPKh9u316g9v76AjN2SMSKsUv9haUOQBO24Gu64Ikg
 A20BXxk6vvDbNMW2REvnYCei/qhSUYo=
X-Proofpoint-GUID: OVYlOTQnNHP-rlXmFErOUoWT8NwiZOQj
X-Proofpoint-ORIG-GUID: yriYYOpkGHV1y52NaveYalug9vdJGuaF
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a425156 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=p0WdMEafAAAA:8 a=MdZrTe2ayghipT-8awEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290088

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

* Git tree for testing: https://gitlab.com/adi-g15-ibm/qemu/tree/feat_maintainer-v3
* Gitlab pipeline: https://gitlab.com/adi-g15-ibm/qemu/-/pipelines/2635562383
* Successful ppc64 functional tests, qtests, boot tests, builds at all commits

Changelog
=========
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
 tests/qtest/pnv-xive2-test.c           |  2 +-
 tests/qtest/pnv-xscom-test.c           | 22 ++----
 tests/qtest/pnv-xscom.h                | 41 +++++++----
 21 files changed, 162 insertions(+), 149 deletions(-)


base-commit: 20553466cc47af6a8c95f665b601fce3c852e503
-- 
2.54.0

