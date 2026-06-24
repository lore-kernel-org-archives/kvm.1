Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238A5386562
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 20:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782331221; cv=none; b=qTLZ5QLUskyBolEPYjc+bRvz4Gq5Dj40NQXO4r2nAfWQmb1TfH337wD61aM/kwCk8OCrc8EYb9NLcnexoTKJkPDpS8NzT4fgmm8Cvf3Wuq0thBb4NY7UvdhdzSCklM4JohD+rPppTYiNE0/Sc7N7RjJcFejTsVbu39IUe3wP4Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782331221; c=relaxed/simple;
	bh=75C3sgCA7v3pgbCwYf2r8UQHxBvydqGOevcqcWMKU1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DcgDS2JRc4P54cZRi9yeplgIUQn+Gaxhpjo6z2AIZ+sb6YQ8eP+jHMonpqCulDGB2UcJDyki22RBsnXPJtCXFRIOHzUER1GQ4udeVr81if7BfMD1DEwFRCXDXQB2IY58H11o0RD/+6RaaB5iZh9WqzruFXbB7ouWYVYiOe6Z9P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Iu4lx57k; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Iu4lx57k"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OJmMBx1996108;
	Wed, 24 Jun 2026 20:00:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=tp4dRXM3N+W3L+j/k
	FbUayQVnIAbx21aJY4VWa75ZF8=; b=Iu4lx57kWAtjJcTWKNTJv5qDTk6F1rqKk
	qmVO3Vi0MguX3E0KBTSz/reS9xCDdL4lmhD+jHvZkIaPwWs5KvO4C0tiUIecpyne
	XBZg42LsB4AdjDGsbqHAgW6uRCBxuHK59ajNNaVevIUVJ+TRsjZ9k9T0XBTYjjJM
	3Yi47onDgUxk2YFP+phHFJPp73Z7O31ePyFvx4XGf0tz99CkgXsH9HiWkOWEVVa+
	dEAJQ8kyiTGRVddqhPeNGOfX68RACAp5VZwtA++FWNADqKEM2OJ4ozjzpMohSkev
	YHJuj0IKmIUQbRl120Qb51MA4k+VNicIGgZsGN8HEkpbRiAgq7giA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4p84r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 20:00:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65OJo0BF029539;
	Wed, 24 Jun 2026 19:59:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7dgaa2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 19:59:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65OJxubm42270980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 19:59:56 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2308320040;
	Wed, 24 Jun 2026 19:59:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33F402004D;
	Wed, 24 Jun 2026 19:59:47 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.39.20.104])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jun 2026 19:59:46 +0000 (GMT)
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
Subject: [PATCH v2 2/8] tests/qtest/pnv_spi: Test Power11 PNV_SPI
Date: Thu, 25 Jun 2026 01:29:18 +0530
Message-ID: <20260624195924.1422821-3-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624195924.1422821-1-adityag@linux.ibm.com>
References: <20260624195924.1422821-1-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3c3741 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=gL735G7rtJRJJwX7cZEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE2NiBTYWx0ZWRfX+ikg8SP6vMZS
 fF1YcYjuZzPm6rTuktOo1tBdlheZPp/Fve9tlsiZ8Qd2bDY+b51Mjp2ccMMCsrM5EFe/iempxmT
 XVGHN1CDcytAcKHDGqD9WIGQBo7Jy8B3wIWZEeRhg19YC697oSjOGnA5Wr0y4jqqH1P0LoSLUBj
 d62x6Q++5Fk1ouaFAqloea5GR/HiqdmIEvLqBU3gw94ij9iTVYdw+cxetbU5FOFHu79+M8Mfe2Q
 udRz5D4dNpvFxDKV1UFLGrDhQNMUbtxCD8EjY6cHEtH+kSdOtSs8X4QvJtao3tdlrlzBLBWawJc
 Ya/3qNUoL9Usib7lmvE6AiGgZFBu/3moOg8m0pbcnd63Sei+oEufIVM6lni6M59K6ghq1O0cLc0
 Y1mJ36EGtHj61xOZGRQpQPZxdXk0mQ==
X-Proofpoint-GUID: GtFDswCqYbLVY19alg42B8Lp3vDj5-cH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE2NiBTYWx0ZWRfXwiYCs2pbpJii
 VuQzTyPTq89U6tGF9atNAyPMGHOqXNtb+GAcFOCdixqYaFk2S/aB+LjIUKG4CsEYPtzm/ye7RcA
 9wrVl9YyFMzLrdFItBHAE1yTaJAz0i4=
X-Proofpoint-ORIG-GUID: NVOCfKR053570ktUQUhC7RLYxF1lZeru
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_04,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240166

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
 tests/qtest/pnv-spi-seeprom-test.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/pnv-spi-seeprom-test.c b/tests/qtest/pnv-spi-seeprom-test.c
index 44e0b92730b4..1a78e8d966a5 100644
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
@@ -100,9 +101,16 @@ static void test_spi_seeprom(const void *data)
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
+        g_autofree char *tname = g_strdup_printf("pnv-xscom/spi-seeprom/%s",
+                pnv_chips[i].cpu_model);
+        qtest_add_data_func(tname, &pnv_chips[i], test_spi_seeprom);
+    }
     return g_test_run();
 }
-- 
2.54.0

