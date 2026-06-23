Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A368363C64
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 14:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782224447; cv=none; b=J/B0uPsNZpil7rgmFIPiM2oHLnyfrd1+LGgR+k/Wa25/1JKW+jj+38Sim0qitF5IYMwiRaT5odC1QDx96u9AdcK6cLIXKEwNEu8L3/k7pYWAw86Zwe5zylcjxRlgy9GC5YFVC70P4hpoKiZlXTb2m6tkyMNTVFc80ucIwGy8X/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782224447; c=relaxed/simple;
	bh=Q/DMzTF7FAoRa0U8AJZzSReqK72JeavtJgitjqU/y9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UqPjkZ/y8sif+ow9PAGi4hz6Iu8ZtLarjMtBWEJ/a+w/Op69kr6AyO8jwYmJMp/uha9XxgeC8IZfx5ubg0HX84Kw0km50u5pyPqzkiL2/q5k7ldMnwxXOHglcb9Qq3v4GgKJuBzNLX8Cvm2VhSTrnoeu38OYKmgL3aF6SXjIVv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Hsxx+CX7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Hsxx+CX7"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBmjbr1858065;
	Tue, 23 Jun 2026 14:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Oo1DI1cigjYHEXJlO
	Cc4hvYNnEir0As+KBxL/muY1u8=; b=Hsxx+CX7KgDIETK0jLs1m4+EYyA4nRo/G
	94d0v+jT+lopFjYc37Drg9bttlAXUfKtUS2gwXIfIYWB0gOA2N0jSDOCbYpgrpp0
	hrCki0Zw/7tbx6eghUBuFvzxrQj22cU/P53rI5vOwotEAKzbBqzDMswA/eilObKG
	7TlT+CBezHBvQImnFFtfeeiGgR/sITtBaEG9FUd8eX8Jdtg+pCjl4RP4zb4+1lQQ
	Qs+3T5DDYsrwatKTk+iNrjWw7TvqCKg5nqMu03pEEu1PNyCv6EHgPGkh3fAlNa9f
	0zv62WQsVHtXri0tpWLSg0DAQZTlgM8NFN9vQFKPCae4LmeXGpg6w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9hq7cp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 14:20:33 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NEJcmt016927;
	Tue, 23 Jun 2026 14:20:33 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex66k3ne8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 14:20:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NEKTbF13893930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 14:20:29 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33AD420043;
	Tue, 23 Jun 2026 14:20:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30DD92004B;
	Tue, 23 Jun 2026 14:20:20 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.39.19.165])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 14:20:19 +0000 (GMT)
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
Subject: [PATCH 2/8] tests/qtest/pnv_spi: Test Power11 PNV_SPI
Date: Tue, 23 Jun 2026 19:49:27 +0530
Message-ID: <20260623141933.577981-3-adityag@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: zY29oYf-Mng2kbSTbR7dt-ryP2AHWUcg
X-Proofpoint-GUID: NcIYaBKxD9xmGeuaoVZd2LyEUwyfAL0Y
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a3a9632 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=gL735G7rtJRJJwX7cZEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDExNyBTYWx0ZWRfX/1wvyjBxzrrL
 nm+i+w+8UHiUgK+trOC+UXpJbv/8qBT29vuxn1IGoSB5aOC2F/sKFeQOQkZikDywLJJM5/BBLPz
 JCGTNI91hZGjci6wfX2yF+fh6zmf+fLoC+ZdvrwtaawXXyWrQuoVXl6KNO2/tF2XnYMHbdMZn4y
 HqQjBWKWQ5j8pEX70AgnmX3z2hs7fuTJe7UmN2zTLbZ48LeXQ3Je9vea7VJI8dbJe8Zc7VC4RrT
 uAsQqBbCoXiOyzbZvxyKdDLEOez3ByQj0IkZDsdSoIQGDlGfr17IZO0o+1662ZGStXjMzrVxuj8
 0FZVve1ag/dFBDM5Dp8OgetlZNYQHw6BD3ML09DFUvpmSsjyJsCeFKBvmwI+etXbpqvSXG64l/x
 lAxk3uLicfasBXPVxrRfMWKgN9PgIK9UAMQOpmNsBvw1u6GGcfK5C2yGGkj1g0ntnPSLcot8NsE
 +NdaPs2f8q5J3IgqDHA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDExNyBTYWx0ZWRfX0oLe7glAZPJO
 gOpzNFVNFbFfw7iqL0hCMue0EvvGP4tB/D8/cKXvY2NTofdBKEgGYkS5kiz1tDEYrxCvLYCja58
 bTalRIFBMe5GJibdkySFSdk/n/lrJ90=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230117

Currently pnv-spi-seeprom-test was hardcoded to test the 4th chip in
pnv_chips (power10 as of now).

This requires ensuring to update the index when removing/adding entries
in pnv_chips, such as when Power8E or Power11 gets removed/added in
future commits.

Iterate over all the chips instead, similar to other tests in
pnv-xscom-test.c and pnv-host-i2c-test.c, but skip older chips, since
TYPE_PNV_SPI only exists from Power10 onwards, hence skip older machines

Tests all the pnv_chips similar to other qtests

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 tests/qtest/pnv-spi-seeprom-test.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/pnv-spi-seeprom-test.c b/tests/qtest/pnv-spi-seeprom-test.c
index 44e0b92730b4..721129cd39ab 100644
--- a/tests/qtest/pnv-spi-seeprom-test.c
+++ b/tests/qtest/pnv-spi-seeprom-test.c
@@ -77,6 +77,7 @@ static void test_spi_seeprom(const void *data)
     const PnvChip *chip = data;
     QTestState *qts = NULL;
     g_autofree char *tmp_path = NULL;
+    const char *machine = "powernv10";
     int ret;
     int fd;
 
@@ -87,11 +88,11 @@ static void test_spi_seeprom(const void *data)
     g_assert(ret == 0);
     close(fd);
 
-    qts = qtest_initf("-machine powernv10 -smp 2,cores=2,"
+    qts = qtest_initf("-machine %s -smp 2,cores=2,"
                       "threads=1 -accel tcg,thread=single -nographic "
                       "-blockdev node-name=pib_spic2,driver=file,"
                       "filename=%s -device 25csm04,bus=chip0.spi.2,cs=0,"
-                      "drive=pib_spic2", tmp_path);
+                      "drive=pib_spic2", machine, tmp_path);
     spi_seeprom_transaction(qts, chip);
     qtest_quit(qts);
     unlink(tmp_path);
@@ -100,9 +101,17 @@ static void test_spi_seeprom(const void *data)
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
-    char *tname = g_strdup_printf("pnv-xscom/spi-seeprom/%s",
-            pnv_chips[3].cpu_model);
-    qtest_add_data_func(tname, &pnv_chips[3], test_spi_seeprom);
-    g_free(tname);
+
+    for (int i = 0; i < ARRAY_SIZE(pnv_chips); i++) {
+        /* TYPE_PNV_SPI is not instantiated for older Power8/9 machines */
+        if (pnv_chips[i].chip_type < PNV_CHIP_POWER10) {
+            continue;
+        }
+
+        char *tname = g_strdup_printf("pnv-xscom/spi-seeprom/%s",
+                pnv_chips[i].cpu_model);
+        qtest_add_data_func(tname, &pnv_chips[i], test_spi_seeprom);
+        g_free(tname);
+    }
     return g_test_run();
 }
-- 
2.54.0

