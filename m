Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9643655C9
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 11:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782731113; cv=none; b=HNC1AH2XmfjZnnQ3va0VSug+PYTyd9gIdSFyimyZu+3w2UWEB/iE2C+G6eJd/3oi9P+NMj/a91p2/xwPMwWZTy2h2slQsdLQ9f4y1UDCdN0ESQFKSL2ny/WRjonGchf67SgO+7/v0srmLuE9S60Md0qNYc15t7GrQihXVWtu19Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782731113; c=relaxed/simple;
	bh=75C3sgCA7v3pgbCwYf2r8UQHxBvydqGOevcqcWMKU1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHEpKk6Ghw3v6FKQk06z9vycf28QIVAQQlhbBu4vsCt3op2z9yt+5K+SE3t3MIZxooKabO6xzluEcsx9zS28TVqo4URc1UpKYdBElKympt+InBBUrGKx/FAOHObngelOeZJIVlXAuLs/ONbKX8fozZBi1KytRE6+JtAvyOqPZi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qSqcDcLF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qSqcDcLF"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TAmeLN2879868;
	Mon, 29 Jun 2026 11:05:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=tp4dRXM3N+W3L+j/k
	FbUayQVnIAbx21aJY4VWa75ZF8=; b=qSqcDcLFGSTMRD+kdg3v/1Uy2f9u6s6l8
	z7XaHYFWHVFpodUrJ6/ajb05ebpC9RARIZQs4E1NlttAvgaHWJ5cczYdN4lynZu7
	H0FGsa4WWYfejMKJcTGTE2VJaK2vfol3UTh3TuTHiI6nPe1lfgvw7GUgmQu8arev
	9albPvcqqIIYU3Fn9OB+1xWViI5W3JDjYENND7W+f73s+Pd80PmjC/k6Owdgz62+
	iPNKeJK1jcZjFXS7/R0tgKh8B/MMKUo68/udXfqjsWkGzc+W+e6tLrSls6DhUlIQ
	Dl6/JqCGkQALzyY0w/O0fDbWOvotpuF5sOoDT1Jv4VuCJiDdsV7YQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mjgqrp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 11:05:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65TB4m67027591;
	Mon, 29 Jun 2026 11:05:01 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhy4tmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 11:05:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65TB4vWg26018228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jun 2026 11:04:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF0642004B;
	Mon, 29 Jun 2026 11:04:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E37C20043;
	Mon, 29 Jun 2026 11:04:53 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.bl1-in.ibm.com (unknown [9.123.10.203])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 29 Jun 2026 11:04:53 +0000 (GMT)
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
Subject: [PATCH v3 2/8] tests/qtest/pnv_spi: Test Power11 PNV_SPI
Date: Mon, 29 Jun 2026 16:34:05 +0530
Message-ID: <20260629110411.3051274-3-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629110411.3051274-1-adityag@linux.ibm.com>
References: <20260629110411.3051274-1-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA4OCBTYWx0ZWRfX7343KjOKOeFt
 WkiBdP2nWteUmQxqR/kR173TVYVT5lbx0Re4aISbYB9AP2ATv8oinM2G3yUeXgIE6nWN/MBU8BT
 mlr927X4SNViCJpshIj3Vs3bF/xPYi9st6ITAeIw+e0LHcsngQysJrSuf/0flwGM0YjeB//9iO3
 73su4YRO+EyyYGCBG7rYIRBm8KJm234+PxG95QVgpfaOzuoRYrvGOAm+A24po3CIEPHC9FYXCBJ
 0lB3cO0tjD+6Nvmm+BzJo68y2vwWPNrQDoVqPCNFYI++hhjd9+Xt9rWixJLhYvnrYp2u5z+7rjC
 6VQ+SHnk7uZtco6VzwCOdvfeavB3JsJUGA/NCzzpx5Lrdr0T3+FXYD9KlE+uBfbnDKG3MjrA+aC
 wUegCPUw8NNNxHlnAY7jQp4ZTYYkYOjOCG7+Xr/WRfAnXsIEFvOGGOe/oBgWuuodPOcHpXG3ubF
 OFDrSIZgcIw76auvAug==
X-Proofpoint-GUID: l5clmwfBe9zmY8UKF2z7vX3l3C84ONWs
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a42515e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=gL735G7rtJRJJwX7cZEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA4OCBTYWx0ZWRfX8DE5ElTSUPrs
 NDhOxYrQWIVxMe5n18qayvKikU8sWR6q1xDmMhxWSn3UQXujBjlB3ZlYlmBavAygPNjffIT8d7H
 hKDZm8D9az1Bh/BSOcmH9sgXYnGIaJk=
X-Proofpoint-ORIG-GUID: wnuy_Tz4H9yr8ydcstET34XSw9Bc7sb5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290088

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

