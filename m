Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF626296BCC
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 21:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782853475; cv=none; b=PcI9U5T3BeTgjpD+SFYfHg6OSlujJOYEAGDvHnEKOmokCz3bc7scxDoc4WXu4wyw0mdAvTy5ksIE5dpi09KVFy+7U4/Au+32TQ6GOcftPPm0ELKVzBkMAP4+E7N8W8Qn5nz1+YDQZfuOMG5DZefeyPZgMZxTiOdPjg3LfACjEdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782853475; c=relaxed/simple;
	bh=b3XSxV2jwXehZ/3Hg70S5UQzCjgRJ45+oux0dNyvwvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZB6y/ZeWvpaiXZ8JA6+6hy7+0VZYTlefV6XXqSfB7Xl8mS+CEj5RiclrlvX0AHJ6oEKppPlUcGrL2vMzSYljfYBj4VBAcb2vr3TNXYSFRXqlWfNHNJA8+gSOJNSc/I0RzUHXDKEfjcsbhpxraRxCDPmrMFmfIhPNgKaz+E7AF5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qPxOiR9E; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qPxOiR9E"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UJIAcL2899763;
	Tue, 30 Jun 2026 21:04:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=TXV6SZL99UW8BHh3jliadqNujBpe
	QDtqbWUauDE76/8=; b=qPxOiR9E2nCUbMfjqUuixnpAe8BvIxFzTdWaadLLx32V
	wa9Z0RYCGR2CNv0ZiwZan2PtvFWBTz3tQLsEyiGwojQaM0CVPIGx02E4yQaDqcpH
	JCWAtnRfPaN2zhrmyrc2cyD63NrPcAGzQdIHQEKoDXlxaTFHPqB/WYXKzX13Xv1W
	fzaCDZvWTMc9SDLhCs92EPT1Nv5QEX3l/srXNy8/Mk+hEaLMAjARFO/GCuU/uILW
	fFuBQI93RQ2sOc5ei0M1BlD6uML4yPZDmc8ByIsGuTbe4RavMGioNHAhLvFt3pPd
	pClG28Xk3nrU+yfV7PAmPILnbqpOPtEUIByGDINvwg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n5s4e2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 21:04:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UKnfiu013787;
	Tue, 30 Jun 2026 21:04:12 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhc6j6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 21:04:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UL48PZ17236348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 21:04:08 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E96DE20040;
	Tue, 30 Jun 2026 21:04:07 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE5DB20043;
	Tue, 30 Jun 2026 21:03:59 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.39.22.35])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 21:03:59 +0000 (GMT)
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
Subject: [PATCH v4 0/8] powerpc: Testcase improvements and Power8E/NVL removal
Date: Wed,  1 Jul 2026 02:33:47 +0530
Message-ID: <20260630210355.789109-1-adityag@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIwMiBTYWx0ZWRfX4dJrIzaDZrSg
 PJkMn+Ez3mnzU2ob6kpQn2DrIKuo+4K+mIbo8JN2lZcU6GYombqNv7NcMkQgnJ3qpT/5iVP3C0z
 agAZVnlUoTnM1XRSFX19PC6kOCXHYWPEYjKpIWLN0INHoQaV1wkQ+vFLLFFs5u1phCjbX0+Uxta
 PsNUW547b5yvMu32D12vBg5/umHDYVSLUKFm0FCQyFYo8MR6myfavtlpCVNfg5HPfut8UnjcwdE
 A679Tq7M3arUcmf4IIkuqOC4ivSxcaF1aFGK8UgNfvuBZZFyoG/gP2WJe7ntV6icl3jPpTrA45c
 t1nMAzWk4xK4XL6/8t1i1xDTZag4/pwCTQJ0eL8BTTno8veotWYNZ3eOcer2EI6SHP1Dvn9KroP
 CmgL8GNDNihnoEqWwYDqk4ba2eoiE03Evsn+NRcQuFyGi97+OFyY0pZBTWSfvmvGN3FIZM4SoNm
 hpyzTWcHPIIIpJTH1Kg==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a442f4d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=p0WdMEafAAAA:8 a=MdZrTe2ayghipT-8awEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: fB9pY4rVI4iJfY9fiAENOkdNQELW9YMZ
X-Proofpoint-GUID: LgXzGpRl8Jfthc9ktKe4D1ASAbN8wR1z
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIwMiBTYWx0ZWRfX0IpH/h95DU6E
 eX4C5h5nnC3jYE3D3AfW0jEC9QjqKmm/LfI1oPXsZ6TLxpwaUsswXL9iW14al7cR98X4g3yKfNQ
 xj0DEychrH+Tt6b8PmhKZSrmC2Y5xQg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300202

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

* Git tree for testing: https://gitlab.com/adi-g15-ibm/qemu/tree/feat_maintainer-v4
* Gitlab pipeline: https://gitlab.com/adi-g15-ibm/qemu/-/pipelines/2641510943
* Successful ppc64 functional tests, qtests, boot tests, builds at all commits

Changelog
=========
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


base-commit: 30e8a06b64aa58a3990ba39cb5d09531e7d265e0
-- 
2.54.0

