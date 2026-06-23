Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F64E3845DA
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 14:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782224458; cv=none; b=eS+9+xcPuGVwWfT/WJ1suoXRZ0fMvzZaU2Ny4ItEckM4yqz8pV1R7fL+pwgGltzlh0zPXvy/koRC/di2MVuqxOOOYkAqMxcftmr5Eyby5azqHhl7gf1Khi9TU1YDNwfqXhvTEoBdAjzTcIfs1umvAQhrBDplbCE63H8DoZw6I4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782224458; c=relaxed/simple;
	bh=2ngHyNMZSF+EPxojg9T+fuYi4X3vCaQGkyV63Cb7grg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tdg1NW9DRtizxXsffkiYjlzY4xo1Iz6EuPTRLOZUxwSzQOdx3kSJw0CjuuSfwQkuImk3dRgpvyqm8bCR6uw6pcTvKXXZa6dQ3JSVqXzowCFeKGVqtwik+dRWuqzBEh2KHBT6NopvDx44ejSxVrKS+POdAMxJWUrWG76wG5a9Hmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F/JBn7Qm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F/JBn7Qm"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBmjZG1858057;
	Tue, 23 Jun 2026 14:20:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=C/QfobibTW3jIj5jj
	FYZJiyUT/1iZtaGWWnjfexrfHU=; b=F/JBn7QmTNDcvJiGz4zqZHN8w+ehriK/S
	LRNbgaQ46MTh4iKyneOBUnxetIzJAprGUEGDdx661MS6XRXEHYWkhrUo27iEpNj6
	o0xtbrzd7C3V+l31W37m+2DRw+H4ufba9FpW0Q0mzkmKfRfVfpgiEiLdjFBT4DGr
	RZMYhjAd7uG0rUSortM8V7I5L05wsYofieEAWuMvTequ+5pY4P6vNm2DmHQDUyb5
	JN4QsjjM5JXXqsKJm1gzHR38A4sTp1kNRzTbBuol/W4VOYPXTj7q8cznf+gYBSrD
	mFEPVYHcuCIbVhESvY7eDDrQeKaYCKOPr1lKCuQRXFOTPrndObOCA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9hq7du-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 14:20:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NEJh2G012169;
	Tue, 23 Jun 2026 14:20:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7dg3eep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 14:20:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NEKdbo7209422
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 14:20:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A438520040;
	Tue, 23 Jun 2026 14:20:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3A9820043;
	Tue, 23 Jun 2026 14:20:29 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.39.19.165])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 14:20:29 +0000 (GMT)
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
Subject: [PATCH 3/8] tests/qtest: Add Power11 chip & machine to qtests
Date: Tue, 23 Jun 2026 19:49:28 +0530
Message-ID: <20260623141933.577981-4-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623141933.577981-1-adityag@linux.ibm.com>
References: <20260623141933.577981-1-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: tG03p0-EItNL3vUeyFo-id5ANs8bDdWF
X-Proofpoint-GUID: hlNwijY9htPFCrB8B9vT4vkMWc-Epb9N
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a3a963c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=boE9e45KQAEBoQM2mt4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDExNyBTYWx0ZWRfXzOeDUqa6krRl
 JGEQcxp+NtrMSjW5vNYEpcUO5gm2WcSk1a54yHadPVOR4aI/cbZoCiSqTTFcOqPQ8RCz+ojrzbj
 wz1PRF2HjHAOYk6WQ3+ymnUqSmI7b/9UsrjqL2sWyEc1bA0iy/fW8uEmb4KwDtrI/nqCfPeae8i
 RYMd/Hj2rnKnH8NFEgptDsUCmZ7fXzkoVLqtMxPi74N19d9qZ/S1pdNB+yGxV+MV6VM2mCTqIGC
 2liis76kmbqi5tg9H9lFQilyU5tmJizpScdcnCgEL+Xalqw7eexYVd/jssCyrDO2AmocsO4Pm9V
 qlUTYxx5n1MtJSQ/omQs7SS3Sv7KZcr3ElGl1KmkYcLg5cUGG24Gjikz/2XD2LnNvw5U8J5Iql7
 +X4uj/OLng8NxRAuP9LIdWyk2nMCIQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDExNyBTYWx0ZWRfXzJ+WQJCiLa5m
 0QSmUlFSFfATw/FCwgH2nm6mbeQc+cppREfaA0yssSL3XxKtEz3vJbyyTPiwnwteok3YVpmmDEB
 rP1Lh31ka3W/NTG49i+KAxApCSZPtQY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0
 phishscore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230117

Previously the machines/chips tested by qtest was till Power10, update
the tests to also test PowerNV11 and Power11 PNV Chip

Since if-else-if ladder was common pattern to get machine type,
implement pnv_get_machine_type so new processor cases can be implemented
in one location in pnv_get_machine_type

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 tests/qtest/pnv-host-i2c-test.c    |  7 +++----
 tests/qtest/pnv-spi-seeprom-test.c |  2 +-
 tests/qtest/pnv-xive2-test.c       |  2 +-
 tests/qtest/pnv-xscom-test.c       | 19 ++++-------------
 tests/qtest/pnv-xscom.h            | 33 +++++++++++++++++++++++++++---
 5 files changed, 39 insertions(+), 24 deletions(-)

diff --git a/tests/qtest/pnv-host-i2c-test.c b/tests/qtest/pnv-host-i2c-test.c
index 51e613ebdcb2..d3f9c49d8271 100644
--- a/tests/qtest/pnv-host-i2c-test.c
+++ b/tests/qtest/pnv-host-i2c-test.c
@@ -402,15 +402,14 @@ static void reset_all(QTestState *qts, const PnvChip *chip)
 static void test_host_i2c(const void *data)
 {
     const PnvChip *chip = data;
+    const char *machine = pnv_get_machine_type(chip->chip_type);
     QTestState *qts;
-    const char *machine = "powernv8";
     PnvI2cCtlr ctlr;
     PnvI2cDev pca9552;
     PnvI2cDev pca9554;
 
-    if (chip->chip_type == PNV_CHIP_POWER9) {
-        machine = "powernv9";
-    } else if (chip->chip_type == PNV_CHIP_POWER10) {
+    /* i2c is initialised for rainier in case of P10 */
+    if (chip->chip_type == PNV_CHIP_POWER10) {
         machine = "powernv10-rainier";
     }
 
diff --git a/tests/qtest/pnv-spi-seeprom-test.c b/tests/qtest/pnv-spi-seeprom-test.c
index 721129cd39ab..5141df2dae01 100644
--- a/tests/qtest/pnv-spi-seeprom-test.c
+++ b/tests/qtest/pnv-spi-seeprom-test.c
@@ -77,7 +77,7 @@ static void test_spi_seeprom(const void *data)
     const PnvChip *chip = data;
     QTestState *qts = NULL;
     g_autofree char *tmp_path = NULL;
-    const char *machine = "powernv10";
+    const char *machine = pnv_get_machine_type(chip->chip_type);
     int ret;
     int fd;
 
diff --git a/tests/qtest/pnv-xive2-test.c b/tests/qtest/pnv-xive2-test.c
index 5313d4ef18b7..80de9d09ed09 100644
--- a/tests/qtest/pnv-xive2-test.c
+++ b/tests/qtest/pnv-xive2-test.c
@@ -548,7 +548,7 @@ static void test_xive(void)
 {
     QTestState *qts;
 
-    qts = qtest_initf("-M powernv10 -smp %d,cores=1,threads=%d -nographic "
+    qts = qtest_initf("-M powernv11 -smp %d,cores=1,threads=%d -nographic "
                       "-nodefaults -serial mon:stdio -S "
                       "-d guest_errors -trace '*xive*'",
                       SMT, SMT);
diff --git a/tests/qtest/pnv-xscom-test.c b/tests/qtest/pnv-xscom-test.c
index c814c0f4f5b1..6e52d71f4aaa 100644
--- a/tests/qtest/pnv-xscom-test.c
+++ b/tests/qtest/pnv-xscom-test.c
@@ -28,15 +28,9 @@ static void test_xscom_cfam_id(QTestState *qts, const PnvChip *chip)
 static void test_cfam_id(const void *data)
 {
     const PnvChip *chip = data;
-    const char *machine = "powernv8";
+    const char *machine = pnv_get_machine_type(chip->chip_type);
     QTestState *qts;
 
-    if (chip->chip_type == PNV_CHIP_POWER9) {
-        machine = "powernv9";
-    } else if (chip->chip_type == PNV_CHIP_POWER10) {
-        machine = "powernv10";
-    }
-
     qts = qtest_initf("-M %s -accel tcg -cpu %s",
                       machine, chip->cpu_model);
     test_xscom_cfam_id(qts, chip);
@@ -57,7 +51,8 @@ static void test_cfam_id(const void *data)
 
 static void test_xscom_core(QTestState *qts, const PnvChip *chip)
 {
-    if (chip->chip_type == PNV_CHIP_POWER10) {
+    if ((chip->chip_type == PNV_CHIP_POWER10) ||
+        (chip->chip_type == PNV_CHIP_POWER11)) {
         uint32_t first_core_thread_state =
                  PNV_XSCOM_P10_EC_BASE(chip->first_core) + 0x412;
         uint64_t thread_state;
@@ -84,14 +79,8 @@ static void test_xscom_core(QTestState *qts, const PnvChip *chip)
 static void test_core(const void *data)
 {
     const PnvChip *chip = data;
+    const char *machine = pnv_get_machine_type(chip->chip_type);
     QTestState *qts;
-    const char *machine = "powernv8";
-
-    if (chip->chip_type == PNV_CHIP_POWER9) {
-        machine = "powernv9";
-    } else if (chip->chip_type == PNV_CHIP_POWER10) {
-        machine = "powernv10";
-    }
 
     qts = qtest_initf("-M %s -accel tcg -cpu %s",
                       machine, chip->cpu_model);
diff --git a/tests/qtest/pnv-xscom.h b/tests/qtest/pnv-xscom.h
index 5aa1701ea768..8f05f59a1436 100644
--- a/tests/qtest/pnv-xscom.h
+++ b/tests/qtest/pnv-xscom.h
@@ -9,6 +9,9 @@
 #ifndef PNV_XSCOM_H
 #define PNV_XSCOM_H
 
+#include <stdint.h>
+#include <assert.h>
+
 #define SMT                     4 /* some tests will break if less than 4 */
 
 typedef enum PnvChipType {
@@ -17,6 +20,7 @@ typedef enum PnvChipType {
     PNV_CHIP_POWER8NVL,   /* AKA Naples */
     PNV_CHIP_POWER9,      /* AKA Nimbus */
     PNV_CHIP_POWER10,
+    PNV_CHIP_POWER11,
 } PnvChipType;
 
 typedef struct PnvChip {
@@ -60,15 +64,23 @@ static const PnvChip pnv_chips[] = {
         .first_core = 0x0,
         .num_i2c    = 4,
     },
+    {
+        .chip_type  = PNV_CHIP_POWER11,
+        .cpu_model  = "Power11",
+        .xscom_base = 0x000603fc00000000ull,
+        .cfam_id    = 0x220da04980000000ull,
+        .first_core = 0x0,
+        .num_i2c    = 0,
+    },
 };
 
 static inline uint64_t pnv_xscom_addr(const PnvChip *chip, uint32_t pcba)
 {
     uint64_t addr = chip->xscom_base;
 
-    if (chip->chip_type == PNV_CHIP_POWER10) {
-        addr |= ((uint64_t) pcba << 3);
-    } else if (chip->chip_type == PNV_CHIP_POWER9) {
+    if ((chip->chip_type == PNV_CHIP_POWER11) ||
+        (chip->chip_type == PNV_CHIP_POWER10) ||
+        (chip->chip_type == PNV_CHIP_POWER9)) {
         addr |= ((uint64_t) pcba << 3);
     } else {
         addr |= (((uint64_t) pcba << 4) & ~0xffull) |
@@ -77,4 +89,19 @@ static inline uint64_t pnv_xscom_addr(const PnvChip *chip, uint32_t pcba)
     return addr;
 }
 
+static const char *pnv_get_machine_type(enum PnvChipType chip_type)
+{
+    if (chip_type == PNV_CHIP_POWER8) {
+        return "powernv8";
+    } else if (chip_type == PNV_CHIP_POWER9) {
+        return "powernv9";
+    } else if (chip_type == PNV_CHIP_POWER10) {
+        return "powernv10";
+    } else if (chip_type == PNV_CHIP_POWER11) {
+        return "powernv11";
+    } else {
+        g_assert_not_reached();
+    }
+}
+
 #endif /* PNV_XSCOM_H */
-- 
2.54.0

