Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959703321DC
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 20:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782331266; cv=none; b=Ks9BPOYimMt5GcZZnQTsCn6kbGh7EYaoTzP9swzRcvI6fuZCh6POxJ3HeUK+KMxE/Kj+U7a+iaJKNtQ/Sx8qBhOpVePEumevj9IdMFO8RjFxJxVVGtiY5UTdPcSgiXk+CrhJic9ceYDpwbDgV39fLFxB0BW6aE1i8UNyCjr0XkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782331266; c=relaxed/simple;
	bh=thNmWEnJvE6WE1mjApPXm4Eihn29oZNgzf0awpQZUsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MUmdl6iDj+Di+wkhNfC2hZJ6nK7cin3TR0nxX67/i+RYGzHv4PIFPmX82ZsRUjq0cZYu/23iWXUT0jOrXUaIcAYSs3qeCmg3o4TAZVRbj1OmmHr/HTLxqxIg7abbYy2TwExjoFbXh3qkFaYumzjtdM4EbUmL3jJwJImSA/bcY04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LzJb+G1b; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LzJb+G1b"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OJmfVi1948456;
	Wed, 24 Jun 2026 20:00:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=96MOyo
	9zEnlFPx3INOzeHJ3PsYrZFIH26tLkR5dbsRw=; b=LzJb+G1bRSgQ+KIIIhPV0u
	IPisTRRP/Y6pOl4Mjc9HcnAvxXmVImNYg46Tda//Rr72/JsHdX0NVNZMnomnNwBa
	0e5wI2/eGYiMifJqOvdYCMevWEP7SaCbZLHM0PJDZwx4K9ykQPvUjz5AgKNwsXMX
	AahEpcTIzof3yIxagYP8CK7io1VwHHpUuS+nUvhqG9wqDjK5f92zlQ/ySFFl98rS
	Chy3tbVWT+V7XdIJe3tZjrHvS2ZoYKlAFDX+ypwdZ7yIRiHtAzxu9MTGZck//Af5
	/gkRhDn/qI3Px1fVZdm5/AKUkMoBRNuq7lC12/wuUX+hcuS9yQtpjEYhFpe8H0tQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9hxagx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 20:00:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65OJnxu9015156;
	Wed, 24 Jun 2026 20:00:39 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qjr9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 20:00:38 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65OK0ZdA48628158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 20:00:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5800D20040;
	Wed, 24 Jun 2026 20:00:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9846E20043;
	Wed, 24 Jun 2026 20:00:25 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.39.20.104])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jun 2026 20:00:24 +0000 (GMT)
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
Subject: [PATCH v2 6/8] ppc/pnv: Remove Power8E and Power8NVL pnv chips
Date: Thu, 25 Jun 2026 01:29:22 +0530
Message-ID: <20260624195924.1422821-7-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624195924.1422821-1-adityag@linux.ibm.com>
References: <20260624195924.1422821-1-adityag@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: uqTc-MBH9iVdHBd49E9H8Xxu73D1ghfe
X-Proofpoint-GUID: ZDZgnZokdvB_zWgVjNyyjaPt0ra_J_iM
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a3c3768 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=EUspDBNiAAAA:8
 a=VnNF1IyMAAAA:8 a=VZAblS4EJK4kQvDgE7QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE2NiBTYWx0ZWRfX9HC8LuN9rSSG
 /t4l57sg0KNPXd3u1pgVSncEqK94UQYILWAVmT1RVJPbav/D4kLEkn5phXyujY8/O8OFaek1Qrz
 +hZ7wGhcgK8ujpQ2OA2L6mUH+S4tOxEiFDmPbZi9juWc+8jLDYx5LGOvp2/+aO3GdiSYGWoNdif
 HOn+bHOKVpMvwdYzKmyPPuHdBJB+DqqUrF1riNBTm6RMRx/HvcsUXac2/AnTveZkJMrZdnDJLcJ
 sbcv75pT3nRaiV6H9bfpnY9egg1xcntn6PL62M+AsQOMHR0fPosNcK/iYV17P3OqLC7GBqT3o/w
 sktBcXfGU8OJ6q/i00yl330zDhNdnCcWCe/QYOvRRsyX3EAcyrj3MgA5KJSOhqd2AZF2lY87gvK
 KYR5Q5rdryHlioiuqe9jPA2lT0oS2a1Woq+LD2TXTf9eiZRQnr9KO0kQH32QIkq/06tyePq2Etl
 rqF7vM9B8g8WSFLafLA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE2NiBTYWx0ZWRfX7a98RjqtAVJC
 WJjAnmRDmFtSjkd+eouPuI9FOC5l1tlM60i02PDXoOluvoZzUKl3sWo76ZQWXzofAQ0wBt52VGk
 06PRixNswRGchrp5qio6LltBv+D4/Ts=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_04,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240166

Power8E and Power8NVL were deprecated since QEMU 10.1, with
commit 264a604e7163 ("target/ppc: Deprecate Power8E and Power8NVL")

Accordingly, remove usage of 8E and 8NVL chips from powernv, as it's old
and unmaintained now.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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
index 8f05f59a1436..f184118ae5a6 100644
--- a/tests/qtest/pnv-xscom.h
+++ b/tests/qtest/pnv-xscom.h
@@ -15,9 +15,7 @@
 #define SMT                     4 /* some tests will break if less than 4 */
 
 typedef enum PnvChipType {
-    PNV_CHIP_POWER8E,     /* AKA Murano (default) */
     PNV_CHIP_POWER8,      /* AKA Venice */
-    PNV_CHIP_POWER8NVL,   /* AKA Naples */
     PNV_CHIP_POWER9,      /* AKA Nimbus */
     PNV_CHIP_POWER10,
     PNV_CHIP_POWER11,
@@ -40,13 +38,6 @@ static const PnvChip pnv_chips[] = {
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

