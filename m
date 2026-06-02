Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3604B3A9619
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 06:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780382963; cv=none; b=T/edV5cA9aRSFLhrCefioy7d7/0QQQm8tmkeyQkNig3HT+1WBa4BnABVZ7i8VV9HXMHf7C+S6V9vU2SPIDcbrlnLrke/jf3ebxGoO0ThvuXxYFmGRZgBrFyq3YrNwY7FPTTBq+aXOUH5u9BwAcADITfeUjDOi8WPqQsfj4/rGIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780382963; c=relaxed/simple;
	bh=G4JjTUzfx87pjS2/uI4VEsD2q9GEnLQEsrS6f3/ytoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UyyAFU4TJFTgvuiVzTsgMuqZY+jWHM/klCA/enbYreONv5uyPlFriikeT4RKAGs6+Xst82117Oi7+Ci0FPraUh6TfNWiPBeyB2xxghmhszb/jV79lCZe3vJ0v95o5pioqvuDiEsEXa17JeJWR7oY/XL/SGRMQBMegPb55KKDgVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V98UNv9P; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V98UNv9P"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6524VIaZ1656097;
	Tue, 2 Jun 2026 06:49:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fskGfYvdHHBHlvlh7
	9uJ/v9H5SZIDccKuqHjlNZNp70=; b=V98UNv9PTTYbb/NHlrL88SfRAHKI7doFx
	x6ufNaZir4yBoomh4SM0uX9sXsXCBY/I1Dc1OwvlLzU4H1Rl/8KklU53DBGdhnHd
	ucdMqBtvhVmdgf0dbQ0Wjek36HYjm5IJF1xmxMaIR69iQlvx8UyXIltg26QJgPfk
	9/MCUnEXuvIOrq3q/q356Q68KCH8h3iiK4rivm37rLFPzb5IQUUqKyJ/1H/9hbDF
	//hykjbAxh0V5hsoaRwpS3JKuwfIKc6QLlysAU1P4fPDFUUYWFa2HjBeT3gX8uNq
	ZwLX/ICaHFd+4sjHlQUKcIqn02o78cSzVhN6bMaG45U9Xz6cDIYpA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd44naa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 06:49:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6526dAJl017444;
	Tue, 2 Jun 2026 06:49:04 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcwy9ncv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 06:49:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6526n0tx62849424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 06:49:00 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6163A20043;
	Tue,  2 Jun 2026 06:49:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23AFC20040;
	Tue,  2 Jun 2026 06:48:58 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.bl1-in.ibm.com (unknown [9.123.8.229])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2026 06:48:57 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: thuth@redhat.com
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, lvivier@redhat.com,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        andrew.jones@linux.dev, sbhat@linux.ibm.com,
        Chinmay Rath <rathc@linux.ibm.com>
Subject: [kvm-unit-tests RFC PATCH 4/6] powerpc: gitlab CI update
Date: Tue,  2 Jun 2026 12:18:04 +0530
Message-ID: <20260602064806.3101025-5-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602064806.3101025-1-rathc@linux.ibm.com>
References: <20260602064806.3101025-1-rathc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA1OSBTYWx0ZWRfXyvNLhXe10v+z
 p5AQPJrgfxStsaeAJH2C+U3wA8lNoEEPgR5K5Kk4N6iW06MouqLatiWgrnG8HPFd43aBRAbDJ+C
 XONV1Sdl1jQQ0+s8+1vLXdKej2BP5ceO7XKejV0pKe6wDHqx0T1nM4ccwPfnIQ/tsWh/t6TZWie
 Iev0ayfXNYKod8uozDG4Dyp+6a0iz/qvI2fjMFV9mwr6I6vMo00NUYdHWdDBx73qXEtnQz0lTh6
 3kedhRaB8gmYs7is21iCtx5gGQdi0nJy+6oLFI6cCKg1vpQg5y/7o9N4BrC1nPsh3g6m/bkW06J
 pusTwIW+sUhyyMGB2SzXporVKUru6zKiS4kFZONaYAWt6Rvx3bMcrdgziCUiWJnZOQ8Zuxed0fF
 1GsTdMHDmOWrRbcVrTcqqrh10M+7fiPECped/LwsEVaYkPqbI5Juf6Kk6iW3jG2QlvNwqCXAexE
 j+yG6+8uOqcxQbkEa4w==
X-Proofpoint-GUID: ZA6erR1nfiK6HVvMhHWrjcaFrE3UGiCL
X-Proofpoint-ORIG-GUID: oJinXVwj8O36dUOJ6bx9SNpDx1zbk9Fm
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a1e7ce1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=13LVzRVf84mWsCqzsKkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020059

From: Nicholas Piggin <npiggin@gmail.com>

Change to using a gitlab-ci test group instead of specifying all
tests in .gitlab-ci.yml, and adds a few additional tests (smp, atomics)
that are known to work in CI.

To control overhead, ppc64be is used to test 64k page size, ppc64le is
used to test 4k page size.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 .gitlab-ci.yml        | 53 ++++++++-----------------------------------
 powerpc/unittests.cfg | 36 ++++++++++++++++++++++-------
 2 files changed, 37 insertions(+), 52 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index daccdfef..8608219d 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -187,32 +187,15 @@ build-arm:
 build-ppc64be:
  extends: .outoftree_template
  script:
- - dnf install -y qemu-system-ppc gcc-powerpc64-linux-gnu nmap-ncat
+ - dnf install -y qemu-system-ppc gcc-powerpc64-linux-gnu
  - mkdir build
  - cd build
- - ../configure --arch=ppc64 --endian=big --cross-prefix=powerpc64-linux-gnu-
+ - ../configure --arch=ppc64 --endian=big --page-size=64k --cross-prefix=powerpc64-linux-gnu-
  - make -j2
- - ACCEL=tcg ./run_tests.sh
-      atomics
-      emulator
-      interrupts
-      mmu
-      rtas-get-time-of-day
-      rtas-get-time-of-day-base
-      rtas-set-time-of-day
-      selftest-migration
-      selftest-migration-skip
-      selftest-setup
-      sieve
-      smp
-      smp-smt
-      spapr_hcall
-      spapr_vpa
-      sprs
-      timebase
-      timebase-icount
-      | tee results.txt
- - if grep -q FAIL results.txt ; then exit 1 ; fi
+ - ACCEL=tcg MAX_SMP=8 ./run_tests.sh -g gitlab-ci
+   | tee results.txt
+ - grep -q PASS results.txt && ! grep -q FAIL results.txt
+
 
 build-ppc64le:
  extends: .intree_template
@@ -220,27 +203,9 @@ build-ppc64le:
  - dnf install -y qemu-system-ppc gcc-powerpc64-linux-gnu nmap-ncat
  - ./configure --arch=ppc64 --endian=little --cross-prefix=powerpc64-linux-gnu-
  - make -j2
- - ACCEL=tcg ./run_tests.sh
-      atomics
-      emulator
-      interrupts
-      mmu
-      rtas-get-time-of-day
-      rtas-get-time-of-day-base
-      rtas-set-time-of-day
-      selftest-migration
-      selftest-migration-skip
-      selftest-setup
-      sieve
-      smp
-      smp-smt
-      spapr_hcall
-      spapr_vpa
-      sprs
-      timebase
-      timebase-icount
-      | tee results.txt
- - if grep -q FAIL results.txt ; then exit 1 ; fi
+ - ACCEL=tcg MAX_SMP=8 ./run_tests.sh -g gitlab-ci
+   | tee results.txt
+ - grep -q PASS results.txt && ! grep -q FAIL results.txt
 
 build-riscv32:
  extends: .outoftree_template
diff --git a/powerpc/unittests.cfg b/powerpc/unittests.cfg
index 60c73086..168af206 100644
--- a/powerpc/unittests.cfg
+++ b/powerpc/unittests.cfg
@@ -17,17 +17,25 @@ file = selftest.elf
 smp = 2
 test_args = 'setup smp=2 mem=1024'
 qemu_params = -m 1g
-groups = selftest
+groups = selftest gitlab-ci
 
 [selftest-migration]
 file = selftest-migration.elf
 machine = pseries
 groups = selftest migration
 
+# make a kvm-only version for CI for now
+# TCG accel support with Qemu and distro release used in gitlab CI needs to checked.
+[selftest-migration-ci]
+file = selftest-migration.elf
+machine = pseries
+groups = nodefault selftest migration gitlab-ci
+accel = kvm
+
 [selftest-migration-skip]
 file = selftest-migration.elf
 machine = pseries
-groups = selftest migration
+groups = selftest migration gitlab-ci
 test_args = "skip"
 
 [migration-memory]
@@ -38,17 +46,19 @@ groups = migration
 [spapr_hcall]
 file = spapr_hcall.elf
 machine = pseries
+groups = gitlab-ci
 
 [spapr_vpa]
 file = spapr_vpa.elf
 machine = pseries
+groups = gitlab-ci
 
 [rtas-get-time-of-day]
 file = rtas.elf
 machine = pseries
 timeout = 5
 test_args = "get-time-of-day date=$(date +%s)"
-groups = rtas
+groups = rtas gitlab-ci
 
 [rtas-get-time-of-day-base]
 file = rtas.elf
@@ -56,35 +66,41 @@ machine = pseries
 timeout = 5
 test_args = "get-time-of-day date=$(date --date="2006-06-17 UTC" +%s)"
 qemu_params = -rtc base="2006-06-17"
-groups = rtas
+groups = rtas gitlab-ci
 
 [rtas-set-time-of-day]
 file = rtas.elf
 machine = pseries
 test_args = "set-time-of-day"
 timeout = 5
-groups = rtas
+groups = rtas gitlab-ci
 
 [emulator]
 file = emulator.elf
+groups = gitlab-ci
 
 [interrupts]
 file = interrupts.elf
+groups = gitlab-ci
 
 [mmu]
 file = mmu.elf
 smp = 2
+groups = gitlab-ci
 
 [pmu]
 file = pmu.elf
+groups = gitlab-ci
 
 [smp]
 file = smp.elf
 smp = 2
+groups = gitlab-ci
 
 [smp-smt]
 file = smp.elf
 smp = 8,threads=4
+groups = gitlab-ci
 
 # mttcg is the default most places, so add a thread=single test
 [smp-thread-single]
@@ -94,21 +110,23 @@ accel = tcg,thread=single
 
 [atomics]
 file = atomics.elf
-smp = 2
+groups = gitlab-ci
 
 [atomics-migration]
 file = atomics.elf
 machine = pseries
 test_args = "migration -m"
-groups = migration
+groups = migration gitlab-ci
 
 [timebase]
 file = timebase.elf
+groups = gitlab-ci
 
 [timebase-icount]
 file = timebase.elf
 accel = tcg
 qemu_params = -icount shift=5
+groups = gitlab-ci
 
 [h_cede_tm]
 file = tm.elf
@@ -121,12 +139,14 @@ groups = h_cede_tm
 
 [sprs]
 file = sprs.elf
+groups = gitlab-ci
 
 [sprs-migration]
 file = sprs.elf
 machine = pseries
 test_args = '-w'
-groups = migration
+groups = migration gitlab-ci
 
 [sieve]
 file = sieve.elf
+groups = gitlab-ci
-- 
2.53.0

