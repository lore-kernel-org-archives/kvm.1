Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCDB379C53
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 10:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783507939; cv=none; b=XKTD6xSbgm3DD3WxQ9mgfsrCmaNbPu59umWxtpwlMwsGp+kActYJwpGV86qeL769wteXiAJbwUUH/zuD2lPnAG2emCGnPJrpojSmwVNIyex9HLONrt0W60kCX495o7EgY6e2TYphcYe0BkdoPM55bj78Xl4yzgTfZdXTGLlTxJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783507939; c=relaxed/simple;
	bh=8m+uUVqbaEcZ5J36oTYzz+6kHyI1r78GS4D7CCJmoNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JydS60JzJPh6Pvg1w4KuEwJ0QBLyuGiFzSDe/H33C8j8xWdPJuIJo3OuL3jE0j2wjqhuI2eh/G0qjb5Awty4ZhYcoGXYh+NgoeXB6cu1OFiHp+lZnktHVkUXsZeZN9y2VXTgz5SDOkmBl/tIx3YjtVbmjzDBeRYYqgcviBuIuDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KJIqgkZY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KJIqgkZY"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6688J7si1831797;
	Wed, 8 Jul 2026 10:52:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nomQMmJIA5GimD4K9
	IPQTUvBW2Pv5d5DPAjBHj+vIK8=; b=KJIqgkZY8wujVtBwbSb5htQAVEnRB7JhO
	urNyKCep0g/IAlzAXBj573tMpjNYUs8ubC2MUUQlLPmqe5K2WyZEgSEZrGZYLCW0
	fvhueKBYK5jmI85v5KZDBiJ5TqFcfr3W6yx492wOGq9NHlA5/fhtSwH5oMqeDFYa
	KjoGvLzTMwLTY0T/33jLqz5+G/B6aDLJ68aKOIUIn5vcQVdtivnMK1vw1lDIpn2X
	pKVbPxekzsHvcBjWd6mrPsP23YjwKlKBsXyOAwGETPzZ/oAOuLAelW+GmjsGSjCx
	yiWfyU72xktJotMd6bPnW2AoQXWys/luF9GmKY/MdGFAD9O4rLztQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stsvc4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 10:52:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 668AYdhg008818;
	Wed, 8 Jul 2026 10:52:03 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgq7v4y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 10:52:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 668Apxer51904928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jul 2026 10:51:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5535620043;
	Wed,  8 Jul 2026 10:51:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F29D62004B;
	Wed,  8 Jul 2026 10:51:55 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown [9.39.26.49])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jul 2026 10:51:55 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: thuth@redhat.com
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, lvivier@redhat.com,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        andrew.jones@linux.dev, sbhat@linux.ibm.com,
        Chinmay Rath <rathc@linux.ibm.com>
Subject: [kvm-unit-tests PATCH 4/6] powerpc: gitlab CI update
Date: Wed,  8 Jul 2026 16:21:20 +0530
Message-ID: <20260708105122.1177210-5-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708105122.1177210-1-rathc@linux.ibm.com>
References: <20260708105122.1177210-1-rathc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 7uoKHsDaL54lf1ZReKpPztxXnJhn_iyc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDEwNSBTYWx0ZWRfX7eWwbNjAyBD4
 r5B7zzTC56dGF27NPVNTxU3bt2Cxw/kK6QUBneKD1vWjcCLLCoiC42nlGyTdqkdcpjHX7oTJNPx
 QR4+GkPXqvKmYuTHD96GTJc8ye/VmMU=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4e2bd4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=eeYWF6t0w1cpnsO5Rs4A:9
X-Proofpoint-GUID: ehiTM5H6fPK9rs4GBXkW6r8TecLXrQ4c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDEwNSBTYWx0ZWRfX8It013a+R47s
 QIFT7irXXhc9NeG3YAucwHFjVJBZFEofTTp2cHKrkCxFB8fahH18gcQYwVNjLjoDKiNfMXGVgVu
 1n6r2D8sTFJtUlLjz+Np70CL9TTuuHfCBx+NlrBq+bNNNTE0sXPzeOAGP0gn0syHvfVAK5jCZrP
 5p5TnmAZfMAS9k1YTW26zZryoZWgskxVxlf0FzN7OxO2tx0JTGH9ILY/nJxoH1hOBt9Q74G4NOF
 oD7gKxEkSBf80EbMtzvv6b0a7yzCWAY2w8urBfy8YAWuS432yZvQH3j5pNOmae6mzKmMx2WC5a3
 4dRftLDm8zfNygc/IUaHPklmriscIDez8QV5oOIe6ipm4GhaNReGzNiPmdrFJJKB8r3Hh8s0W/G
 950id7YGqNjD5n4digALf+KCg78F7vNv+jQ8VbNhnADTLv8X6jeJuUNtg0dpxl5toybvaTPCWYf
 ZCv8rkHu4oKJoLrpgaA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080105

From: Nicholas Piggin <npiggin@gmail.com>

Adds a few additional tests that are known to work in CI.

To control overhead, ppc64be is used to test 64k page size, ppc64le is
used to test 4k page size.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 .gitlab-ci.yml        | 19 ++++++++++++++-----
 powerpc/unittests.cfg |  9 ++++++++-
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index ab1be5f4..b28d1eb5 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -190,18 +190,21 @@ build-ppc64be:
  - dnf install -y qemu-system-ppc gcc-powerpc64-linux-gnu nmap-ncat
  - mkdir build
  - cd build
- - ../configure --arch=ppc64 --endian=big --cross-prefix=powerpc64-linux-gnu-
+ - ../configure --arch=ppc64 --endian=big --page-size=64k --cross-prefix=powerpc64-linux-gnu-
  - make -j2
- - ACCEL=tcg ./run_tests.sh
+ - ACCEL=tcg MAX_SMP=8 ./run_tests.sh
       atomics
+      atomics-migration
       emulator
       interrupts
       mmu
+      pmu
       rtas-get-time-of-day
       rtas-get-time-of-day-base
       rtas-set-time-of-day
       selftest-migration
       selftest-migration-skip
+      selftest-migration-ci
       selftest-setup
       sieve
       smp
@@ -209,10 +212,12 @@ build-ppc64be:
       spapr_hcall
       spapr_vpa
       sprs
+      sprs-migration
       timebase
       timebase-icount
       | tee results.txt
- - if grep -q FAIL results.txt ; then exit 1 ; fi
+ - grep -q PASS results.txt && ! grep -q FAIL results.txt
+
 
 build-ppc64le:
  extends: .intree_template
@@ -220,16 +225,19 @@ build-ppc64le:
  - dnf install -y qemu-system-ppc gcc-powerpc64-linux-gnu nmap-ncat
  - ./configure --arch=ppc64 --endian=little --cross-prefix=powerpc64-linux-gnu-
  - make -j2
- - ACCEL=tcg ./run_tests.sh
+ - ACCEL=tcg MAX_SMP=8 ./run_tests.sh
       atomics
+      atomics-migration
       emulator
       interrupts
       mmu
+      pmu
       rtas-get-time-of-day
       rtas-get-time-of-day-base
       rtas-set-time-of-day
       selftest-migration
       selftest-migration-skip
+      selftest-migration-ci
       selftest-setup
       sieve
       smp
@@ -237,10 +245,11 @@ build-ppc64le:
       spapr_hcall
       spapr_vpa
       sprs
+      sprs-migration
       timebase
       timebase-icount
       | tee results.txt
- - if grep -q FAIL results.txt ; then exit 1 ; fi
+ - grep -q PASS results.txt && ! grep -q FAIL results.txt
 
 build-riscv32:
  extends: .outoftree_template
diff --git a/powerpc/unittests.cfg b/powerpc/unittests.cfg
index 60c73086..62630ead 100644
--- a/powerpc/unittests.cfg
+++ b/powerpc/unittests.cfg
@@ -24,6 +24,14 @@ file = selftest-migration.elf
 machine = pseries
 groups = selftest migration
 
+# make a kvm-only version for CI for now
+# TCG accel support with Qemu and distro release used in gitlab CI needs to checked.
+[selftest-migration-ci]
+file = selftest-migration.elf
+machine = pseries
+groups = nodefault selftest migration
+accel = kvm
+
 [selftest-migration-skip]
 file = selftest-migration.elf
 machine = pseries
@@ -94,7 +102,6 @@ accel = tcg,thread=single
 
 [atomics]
 file = atomics.elf
-smp = 2
 
 [atomics-migration]
 file = atomics.elf
-- 
2.53.0

