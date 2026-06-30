Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6983C2D73BD
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 21:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782853492; cv=none; b=SGiKEmVqZpe80JfYBVfNaF9sk9F97WFycpIe+Q+jqrz/L5pgdc/BBDX3IbvbFGND5K72DPHC+WxSBEA8Q/H3FKlITeBgucwQCaX3cBORpDoPCoi4vLpXFHruYBZDRxBggLD0cv96mCI/Lw+jcHba0/Srgq/WLOfrWYSXOseRyVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782853492; c=relaxed/simple;
	bh=c2xAGwrlU445hrUd6YsTvqBtl3z2jl/OvHtyGJHitpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G3s0ml9KgDL0REZi0NbmOTBK/Bk84lpTsiHo0wKFW52nH4hsh7EX8PuuD6vltv1MiT9L0C/eS6dOLd4y6YklIZJZ3g7FnuoG08CVQ4QvS/tk8TZHD88B9VYDxzjaA+WfoTc55XNFrqu3OnYHireTdfYM/AQtetZMWD61dLjA/VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TMrd1+dn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TMrd1+dn"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UJITPB2957295;
	Tue, 30 Jun 2026 21:04:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5QhUbq6tP4S25bYFd
	HvOZYDOy58gq/DsCABVD9A5miM=; b=TMrd1+dngbRC7n4WA9/CP6T6bSVAu+Jo7
	FAm3BpaqmTAyDZYgGFMWlUBJnUdU3r7gq4SaEEu/ZMb1iH3yYgbDVogm0bEj/JJN
	3CAHp7Ne4VN5HhcfESYMtUAuJ6ZkCe5EeIE1jDmiNwhIQ+6M8X9jzl0fmN+YTO2y
	OtgEQIEsDMWeqZmdTVJ3oEDA9IveQ6qpih+nCBOd9HLY2KnKYWlZxkoOeD/3YZBP
	85ynLGAuHktYx5vTy17ePvIan/ldwzVrGXcnPRtyDyYFtGUUYmuD1CmvvHzawM0j
	Ddtsiukw7UFRUFHFZp4/N91ma3GmXCc/iXldxoshh/TF9sHIMgWVQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pe159d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 21:04:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UL4bQU020335;
	Tue, 30 Jun 2026 21:04:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2suk48st-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 21:04:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UL4Xo961735264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 21:04:33 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D2A620043;
	Tue, 30 Jun 2026 21:04:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 131C420040;
	Tue, 30 Jun 2026 21:04:26 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.39.22.35])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 21:04:25 +0000 (GMT)
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
Subject: [PATCH v4 3/8] tests/qtest: Add Power11 chip & machine to qtests
Date: Wed,  1 Jul 2026 02:33:50 +0530
Message-ID: <20260630210355.789109-4-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630210355.789109-1-adityag@linux.ibm.com>
References: <20260630210355.789109-1-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: gE4YDoxymu3KoQOF3tYN2CP_uSy2WYqG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIwMiBTYWx0ZWRfX0LaaUIMev6W9
 cLEnYqQ0THlE7l0+hXN/VsUzPPCdlyDvor1LLqlXNS/iiORCBDOtGuHfbeub1AJBdwKxcl+TNUH
 8P12r4fYJwV/Ghv/iUYuipFyjdF+haU=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a442f67 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=jlYlrgOtAAFGYfj3CJAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIwMiBTYWx0ZWRfX60Z0xgRYcb8h
 l+NYwNnsNbzt/D+zVhOt2J3w6YtgAGAY8z3OktmHF8trzk+bm416gn1BD+PQjK7e3FSrit5ublJ
 h1N3yV2wekAJTjIY6GW4dyca3lu9jVjyCgcw6E2PzJwvue+xwat8dhscTT5CrhBHbJ6sN/xHiru
 YN9oKB5yEtC/KeEGOF8jEgWaW6HL+tE/QZbbsM/gmJmZj9MILX5sMjgI7gj71lLVkVNFANX9QNK
 EladjF99BgyuQOGcJvfqI2yG+E9FuHs7Ap47+RbsDL4F7sHzArMZ0l7j0QGNYW2NkUtpvipTRJW
 BcPovs3jdeAPlXu6EYTTDZqj3J1cZq81+xx5CK0s6i2G1PLUiHNsT2O4LX2VZ/t1X8yDrhCce2Q
 4bGuPheUYvD/ekqe0Ufm+kfe/jJ2S5/QjC4VJwM9Jhzw8io9GVjsQzxywmPankmQsZdTaef2MJc
 2ZZCNC71yt3auCXLlgg==
X-Proofpoint-ORIG-GUID: EQvAnXnH-ID0W8gdoJcj3haio6e6Etsi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300202

Previously the machines/chips tested by qtest was till Power10, update
the tests to also test PowerNV11 and Power11 PNV Chip

Since if-else-if ladder was common pattern to get machine type,
implement pnv_get_machine_type so new processor cases can be implemented
in one location in pnv_get_machine_type

While at it, also add g_autofree to allocation by g_strdup_printf in
modified tests

Tested-by: Misbah Anjum N <misanjum@linux.ibm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 tests/qtest/pnv-host-i2c-test.c    | 10 ++++------
 tests/qtest/pnv-spi-seeprom-test.c |  2 +-
 tests/qtest/pnv-xive2-test.c       | 21 +++++++++++++++++----
 tests/qtest/pnv-xscom-test.c       | 22 +++++-----------------
 tests/qtest/pnv-xscom.h            | 29 ++++++++++++++++++++++++++---
 5 files changed, 53 insertions(+), 31 deletions(-)

diff --git a/tests/qtest/pnv-host-i2c-test.c b/tests/qtest/pnv-host-i2c-test.c
index 51e613ebdcb2..5fd54f9de771 100644
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
 
@@ -473,10 +472,9 @@ static void add_test(const char *name, void (*test)(const void *data))
     int i;
 
     for (i = 0; i < ARRAY_SIZE(pnv_chips); i++) {
-        char *tname = g_strdup_printf("pnv-xscom/%s/%s", name,
+        g_autofree char *tname = g_strdup_printf("pnv-xscom/%s/%s", name,
                                       pnv_chips[i].cpu_model);
         qtest_add_data_func(tname, &pnv_chips[i], test);
-        g_free(tname);
     }
 }
 
diff --git a/tests/qtest/pnv-spi-seeprom-test.c b/tests/qtest/pnv-spi-seeprom-test.c
index 1a78e8d966a5..8bb30eb649aa 100644
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
index 5313d4ef18b7..9f67a0066864 100644
--- a/tests/qtest/pnv-xive2-test.c
+++ b/tests/qtest/pnv-xive2-test.c
@@ -14,6 +14,7 @@
 #include "libqtest.h"
 
 #include "pnv-xive2-common.h"
+#include "pnv-xscom.h"
 #include "hw/intc/pnv_xive2_regs.h"
 #include "hw/ppc/xive_regs.h"
 #include "hw/ppc/xive2_regs.h"
@@ -544,14 +545,16 @@ static void test_hw_group_irq_backlog(QTestState *qts)
     g_assert_cmphex(lsmfb, ==, 0xFF);
 }
 
-static void test_xive(void)
+static void test_xive(const void *data)
 {
+    const PnvChip *chip = data;
+    const char *machine = pnv_get_machine_type(chip->chip_type);
     QTestState *qts;
 
-    qts = qtest_initf("-M powernv10 -smp %d,cores=1,threads=%d -nographic "
+    qts = qtest_initf("-M %s -smp %d,cores=1,threads=%d -nographic "
                       "-nodefaults -serial mon:stdio -S "
                       "-d guest_errors -trace '*xive*'",
-                      SMT, SMT);
+                      machine, SMT, SMT);
     init_xive(qts);
 
     test_hw_irq(qts);
@@ -580,6 +583,16 @@ static void test_xive(void)
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
-    qtest_add_func("xive2", test_xive);
+
+    for (int i = 0; i < ARRAY_SIZE(pnv_chips); i++) {
+        /* xive2 exists from Power10 onwards */
+        if (pnv_chips[i].chip_type < PNV_CHIP_POWER10) {
+            continue;
+        }
+
+        g_autofree char *tname = g_strdup_printf("pnv-xive2/%s",
+                pnv_chips[i].cpu_model);
+        qtest_add_data_func(tname, &pnv_chips[i], test_xive);
+    }
     return g_test_run();
 }
diff --git a/tests/qtest/pnv-xscom-test.c b/tests/qtest/pnv-xscom-test.c
index c814c0f4f5b1..94b50c071c02 100644
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
@@ -104,10 +93,9 @@ static void add_test(const char *name, void (*test)(const void *data))
     int i;
 
     for (i = 0; i < ARRAY_SIZE(pnv_chips); i++) {
-        char *tname = g_strdup_printf("pnv-xscom/%s/%s", name,
+        g_autofree char *tname = g_strdup_printf("pnv-xscom/%s/%s", name,
                                       pnv_chips[i].cpu_model);
         qtest_add_data_func(tname, &pnv_chips[i], test);
-        g_free(tname);
     }
 }
 
diff --git a/tests/qtest/pnv-xscom.h b/tests/qtest/pnv-xscom.h
index 5aa1701ea768..8e882dac9d36 100644
--- a/tests/qtest/pnv-xscom.h
+++ b/tests/qtest/pnv-xscom.h
@@ -17,6 +17,7 @@ typedef enum PnvChipType {
     PNV_CHIP_POWER8NVL,   /* AKA Naples */
     PNV_CHIP_POWER9,      /* AKA Nimbus */
     PNV_CHIP_POWER10,
+    PNV_CHIP_POWER11,
 } PnvChipType;
 
 typedef struct PnvChip {
@@ -60,15 +61,23 @@ static const PnvChip pnv_chips[] = {
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
@@ -77,4 +86,18 @@ static inline uint64_t pnv_xscom_addr(const PnvChip *chip, uint32_t pcba)
     return addr;
 }
 
+static const char *pnv_get_machine_type(enum PnvChipType chip_type)
+{
+    static const char *const machine_types[] = {
+         [PNV_CHIP_POWER8]  = "powernv8",
+         [PNV_CHIP_POWER9]  = "powernv9",
+         [PNV_CHIP_POWER10] = "powernv10",
+         [PNV_CHIP_POWER11] = "powernv11",
+     };
+
+    g_assert(chip_type <= PNV_CHIP_POWER11);
+
+    return machine_types[chip_type];
+}
+
 #endif /* PNV_XSCOM_H */
-- 
2.54.0

