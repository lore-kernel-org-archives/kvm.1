Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808ED34CDD
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 21:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782853517; cv=none; b=OYUNCP7pEnbUITNj3SbMh5z+DusEaV/p2tRiYcej7zYMAjmC0fYLp8wtLHcgiCtnd/2UigeJEKMGFWW9mGfTp+0+h3/17J5QifsFNdZt7l3fr/+oP0zGXI9Bprps5Zpf/uqOPtdzj3/jhvgb1KyOOc8ozGf1saKq1WeCChH1Zik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782853517; c=relaxed/simple;
	bh=Qdvt7SZZGIhtc8OmNAzuTWZW0SUQc2s9FUmixWVY+Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O7SZivzg045hKm25EohC3l1oXLI3iAzpLlQyjf7fHX2ihq8jFRyxRshAEfRxdGl0VP/js4BcSPgtzq9rGrGmaKZQv1eZtAd9F+rquWOSrzrIe5pD2ijIc+d5Qp0mR5y0kHzXWUJ66HLdONYmh61o9V3P0fzPZGiytj+OJwOhq8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GzKDSK0E; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GzKDSK0E"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UJIjOX2900882;
	Tue, 30 Jun 2026 21:05:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NUfXJJ
	rhcp77r3wtcWlsIAwxt0V7S53j5Y9IhjeGqwg=; b=GzKDSK0Esch3uqMcf+YHoB
	kxy74HEhVwr2ggf3z7XOtDY7/datWMWIqAk1twDRB9O1A5wE+k2/IFHqruYVBKgW
	VyDrEsa+8dX1T6zUsLaYX+LVtZSAcTsF9S/TB53h99tD+Fa9NAApJjrXGd+Lbsxv
	iOKdC19oAz5Xc11njaYzzR04KNVl/7au9OKEqX4KgX48juvfPsdJiKgp4Y8UT4/W
	090frcIEZcqR6JWERHXQjLnGGpWEuuTiI6R3dE9QO3yDUSt5gUBzTsnrGNLfcMY3
	/Va/V+7A4Auvqg3cHhdrimN+7mPB1gk4hziu/yZT9YAk1zpyG+fdTz2iAt6wp+IA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n5s4gf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 21:05:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UL4jQY024575;
	Tue, 30 Jun 2026 21:05:02 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhyc0h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 21:05:01 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UL4wee50790670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 21:04:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38A9120043;
	Tue, 30 Jun 2026 21:04:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2313720040;
	Tue, 30 Jun 2026 21:04:50 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.39.22.35])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 21:04:49 +0000 (GMT)
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
Subject: [PATCH v4 6/8] ppc/pnv: Remove Power8E and Power8NVL pnv chips
Date: Wed,  1 Jul 2026 02:33:53 +0530
Message-ID: <20260630210355.789109-7-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630210355.789109-1-adityag@linux.ibm.com>
References: <20260630210355.789109-1-adityag@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIwMiBTYWx0ZWRfXzZ+njX2V3/wz
 TII6gZCUhaIMcd2Y+DnBpwwGSslSM/mzM8AmdEgcpfhgRJAuWzzl8Sro6cmV8RJQekr6Vzb5T23
 +rI5wNcryz2mgSvrrW2ck2dZfjiLSiS8l2cFmjwvXGnz6ldKEETZBfZstQ99ErCaSYA4de21NMP
 NeZPQp2lr8goJEC5Y1aTGfGIlp4tgi4yO6goWx8RuBJAx0eVS3PPc3x6EsxawOWiKNaGp4CZdna
 w6PVJPABHy7HTQM9WG/yOTgXEhoYmjw0r3HdWc2yZ3rVe3vGE4nJNot16OrrA/N79lf5zBV1bDM
 8eTb3dnepiBtXa0SwxxGi4ldW7+Efn6+NPhcZefZdRbur57DtwT1CQ6MyL5/6xpO/VttK2T4ZDO
 m3FF6Gcm1cwvwMJHQQunZXU0ZDHAb36PyPF/2f7yVPItKhv66evfLWonIJFgqVQ3f/5ZDnyh3w0
 MvTCgLfqvq9dW/8QHwA==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a442f7f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=EUspDBNiAAAA:8
 a=VnNF1IyMAAAA:8 a=VZAblS4EJK4kQvDgE7QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: tj0oCICz5nk8aO3LV6fuyFzUDj0E_qjM
X-Proofpoint-GUID: ZN6B9WN6rYGlF_Xb2eO59oMFZwfTjwTx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIwMiBTYWx0ZWRfXy3qMRVc7neB6
 L04IKtOCWHnAR8UA34JIet3oZ1pifHxZa8dAQwSQ4E8HsOns9Jrpw7HX8S8hZNR59eVPARAOLPH
 d52I5FFaD5kijcrnFMdVoYc+1rrP6p0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300202

Power8E and Power8NVL were deprecated since QEMU 10.1, with
commit 264a604e7163 ("target/ppc: Deprecate Power8E and Power8NVL")

Accordingly, remove usage of 8E and 8NVL chips from powernv, as it's old
and unmaintained now.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Misbah Anjum N <misanjum@linux.ibm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 docs/system/ppc/powernv.rst |  2 +-
 hw/ppc/pnv.c                | 62 -------------------------------------
 hw/ppc/pnv_core.c           |  2 --
 include/hw/ppc/pnv.h        |  8 -----
 tests/qtest/pnv-xscom.h     |  9 ------
 5 files changed, 1 insertion(+), 82 deletions(-)

diff --git a/docs/system/ppc/powernv.rst b/docs/system/ppc/powernv.rst
index 5154794cc8cd..1de696b588a8 100644
--- a/docs/system/ppc/powernv.rst
+++ b/docs/system/ppc/powernv.rst
@@ -15,7 +15,7 @@ beyond the scope of what QEMU addresses today.
 Supported devices
 -----------------
 
- * Multi processor support for POWER8, POWER8NVL, POWER9, Power10 and Power11.
+ * Multi processor support for POWER8, POWER9, Power10 and Power11.
  * XSCOM, serial communication sideband bus to configure chiplets.
  * Simple LPC Controller.
  * Processor Service Interface (PSI) Controller.
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 62812f22f8cd..b669df9f175f 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -865,16 +865,6 @@ static ISABus *pnv_chip_power8_isa_create(PnvChip *chip, Error **errp)
     return pnv_lpc_isa_create(&chip8->lpc, true, errp);
 }
 
-static ISABus *pnv_chip_power8nvl_isa_create(PnvChip *chip, Error **errp)
-{
-    Pnv8Chip *chip8 = PNV8_CHIP(chip);
-    qemu_irq irq = qdev_get_gpio_in(DEVICE(&chip8->psi), PSIHB_IRQ_LPC_I2C);
-
-    qdev_connect_gpio_out_named(DEVICE(&chip8->lpc), "LPCHC", 0, irq);
-
-    return pnv_lpc_isa_create(&chip8->lpc, false, errp);
-}
-
 static ISABus *pnv_chip_power9_isa_create(PnvChip *chip, Error **errp)
 {
     Pnv9Chip *chip9 = PNV9_CHIP(chip);
@@ -1642,7 +1632,6 @@ static void *pnv_chip_power11_intc_get(PnvChip *chip)
  *  EX14
  * <EX15 reserved>
  */
-#define POWER8E_CORE_MASK  (0x7070ull)
 #define POWER8_CORE_MASK   (0x7e7eull)
 
 /*
@@ -1823,30 +1812,6 @@ static uint32_t pnv_chip_power8_xscom_pcba(PnvChip *chip, uint64_t addr)
     return ((addr >> 4) & ~0xfull) | ((addr >> 3) & 0xf);
 }
 
-static void pnv_chip_power8e_class_init(ObjectClass *klass, const void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    PnvChipClass *k = PNV_CHIP_CLASS(klass);
-
-    k->chip_cfam_id = 0x221ef04980000000ull;  /* P8 Murano DD2.1 */
-    k->cores_mask = POWER8E_CORE_MASK;
-    k->num_phbs = 3;
-    k->get_pir_tir = pnv_get_pir_tir_p8;
-    k->intc_create = pnv_chip_power8_intc_create;
-    k->intc_reset = pnv_chip_power8_intc_reset;
-    k->intc_destroy = pnv_chip_power8_intc_destroy;
-    k->intc_print_info = pnv_chip_power8_intc_print_info;
-    k->isa_create = pnv_chip_power8_isa_create;
-    k->dt_populate = pnv_chip_power8_dt_populate;
-    k->pic_print_info = pnv_chip_power8_pic_print_info;
-    k->xscom_core_base = pnv_chip_power8_xscom_core_base;
-    k->xscom_pcba = pnv_chip_power8_xscom_pcba;
-    dc->desc = "PowerNV Chip POWER8E";
-
-    device_class_set_parent_realize(dc, pnv_chip_power8_realize,
-                                    &k->parent_realize);
-}
-
 static void pnv_chip_power8_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -1871,30 +1836,6 @@ static void pnv_chip_power8_class_init(ObjectClass *klass, const void *data)
                                     &k->parent_realize);
 }
 
-static void pnv_chip_power8nvl_class_init(ObjectClass *klass, const void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    PnvChipClass *k = PNV_CHIP_CLASS(klass);
-
-    k->chip_cfam_id = 0x120d304980000000ull;  /* P8 Naples DD1.0 */
-    k->cores_mask = POWER8_CORE_MASK;
-    k->num_phbs = 4;
-    k->get_pir_tir = pnv_get_pir_tir_p8;
-    k->intc_create = pnv_chip_power8_intc_create;
-    k->intc_reset = pnv_chip_power8_intc_reset;
-    k->intc_destroy = pnv_chip_power8_intc_destroy;
-    k->intc_print_info = pnv_chip_power8_intc_print_info;
-    k->isa_create = pnv_chip_power8nvl_isa_create;
-    k->dt_populate = pnv_chip_power8_dt_populate;
-    k->pic_print_info = pnv_chip_power8_pic_print_info;
-    k->xscom_core_base = pnv_chip_power8_xscom_core_base;
-    k->xscom_pcba = pnv_chip_power8_xscom_pcba;
-    dc->desc = "PowerNV Chip POWER8NVL";
-
-    device_class_set_parent_realize(dc, pnv_chip_power8_realize,
-                                    &k->parent_realize);
-}
-
 static void pnv_chip_power9_instance_init(Object *obj)
 {
     PnvChip *chip = PNV_CHIP(obj);
@@ -3781,9 +3722,6 @@ static const TypeInfo types[] = {
         .instance_size = sizeof(Pnv8Chip),
     },
     DEFINE_PNV8_CHIP_TYPE(TYPE_PNV_CHIP_POWER8, pnv_chip_power8_class_init),
-    DEFINE_PNV8_CHIP_TYPE(TYPE_PNV_CHIP_POWER8E, pnv_chip_power8e_class_init),
-    DEFINE_PNV8_CHIP_TYPE(TYPE_PNV_CHIP_POWER8NVL,
-                          pnv_chip_power8nvl_class_init),
 };
 
 DEFINE_TYPES(types)
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 8939515c2c34..61dc8211e32f 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -515,9 +515,7 @@ static const TypeInfo pnv_core_infos[] = {
         .class_init = pnv_core_class_init,
         .abstract       = true,
     },
-    DEFINE_PNV_CORE_TYPE(power8, "power8e_v2.1"),
     DEFINE_PNV_CORE_TYPE(power8, "power8_v2.0"),
-    DEFINE_PNV_CORE_TYPE(power8, "power8nvl_v1.0"),
     DEFINE_PNV_CORE_TYPE(power9, "power9_v2.2"),
     DEFINE_PNV_CORE_TYPE(power10, "power10_v2.0"),
     DEFINE_PNV_CORE_TYPE(power11, "power11_v2.0"),
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index f8234fb3cd31..60e902d9c5bb 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -39,18 +39,10 @@ typedef struct Pnv10Chip Pnv11Chip;
 #define PNV_CHIP_TYPE_SUFFIX "-" TYPE_PNV_CHIP
 #define PNV_CHIP_TYPE_NAME(cpu_model) cpu_model PNV_CHIP_TYPE_SUFFIX
 
-#define TYPE_PNV_CHIP_POWER8E PNV_CHIP_TYPE_NAME("power8e_v2.1")
-DECLARE_INSTANCE_CHECKER(PnvChip, PNV_CHIP_POWER8E,
-                         TYPE_PNV_CHIP_POWER8E)
-
 #define TYPE_PNV_CHIP_POWER8 PNV_CHIP_TYPE_NAME("power8_v2.0")
 DECLARE_INSTANCE_CHECKER(PnvChip, PNV_CHIP_POWER8,
                          TYPE_PNV_CHIP_POWER8)
 
-#define TYPE_PNV_CHIP_POWER8NVL PNV_CHIP_TYPE_NAME("power8nvl_v1.0")
-DECLARE_INSTANCE_CHECKER(PnvChip, PNV_CHIP_POWER8NVL,
-                         TYPE_PNV_CHIP_POWER8NVL)
-
 #define TYPE_PNV_CHIP_POWER9 PNV_CHIP_TYPE_NAME("power9_v2.2")
 DECLARE_INSTANCE_CHECKER(PnvChip, PNV_CHIP_POWER9,
                          TYPE_PNV_CHIP_POWER9)
diff --git a/tests/qtest/pnv-xscom.h b/tests/qtest/pnv-xscom.h
index 8e882dac9d36..c4c42c694644 100644
--- a/tests/qtest/pnv-xscom.h
+++ b/tests/qtest/pnv-xscom.h
@@ -12,9 +12,7 @@
 #define SMT                     4 /* some tests will break if less than 4 */
 
 typedef enum PnvChipType {
-    PNV_CHIP_POWER8E,     /* AKA Murano (default) */
     PNV_CHIP_POWER8,      /* AKA Venice */
-    PNV_CHIP_POWER8NVL,   /* AKA Naples */
     PNV_CHIP_POWER9,      /* AKA Nimbus */
     PNV_CHIP_POWER10,
     PNV_CHIP_POWER11,
@@ -37,13 +35,6 @@ static const PnvChip pnv_chips[] = {
         .cfam_id    = 0x220ea04980000000ull,
         .first_core = 0x1,
         .num_i2c    = 0,
-    }, {
-        .chip_type  = PNV_CHIP_POWER8NVL,
-        .cpu_model  = "POWER8NVL",
-        .xscom_base = 0x0003fc0000000000ull,
-        .cfam_id    = 0x120d304980000000ull,
-        .first_core = 0x1,
-        .num_i2c    = 0,
     },
     {
         .chip_type  = PNV_CHIP_POWER9,
-- 
2.54.0

