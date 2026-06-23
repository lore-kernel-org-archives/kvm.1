Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0838A384CC6
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782224492; cv=none; b=ubsTfvyX/Rp5A6zQ+/8o7HwazNe5uPAoKfkZNLK/5EfZuK1flhlQ8YVYo+mI68n+Q2ecRBues62yaZJUwSD52jrfTyjUhzImAhXSkBA9NQ8APCi9vcLx8qyGwgtOCSxlyxPcgdGG3ltWsnzMfuvpexh2gFb8L2MTQwP73FInq88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782224492; c=relaxed/simple;
	bh=thNmWEnJvE6WE1mjApPXm4Eihn29oZNgzf0awpQZUsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tvkQYEMEmFHQ+dEU/QZexxUWnrwhZC1p6PXXwk7l2qxv19+f6h/PEFDdWZ7dRkmWj7lLjSiG00VMGS2rDVYUJywCJHUobuZhqn2YvvCG3u+lW648Q1mnVlQdMIIra5rbviKZfv932PCNU7L64J4BiZ2/gmIyCWQZjh8Q22bPHdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EWlRU4bH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EWlRU4bH"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBmVaA1914696;
	Tue, 23 Jun 2026 14:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=96MOyo
	9zEnlFPx3INOzeHJ3PsYrZFIH26tLkR5dbsRw=; b=EWlRU4bHRHHSgkrYXpdPDW
	kVXYgzoCPc1s7M4Rie7cOnJAA3XWbdCbP9qfN8HZkJj4ll2uHUb/B3Hm2sSf4RUI
	4D6pDTUxSnXBGvFAIOPk/X+YbkSib1LBBvN7LqVCdevAPf4TKWxKNW0TUdGSRaTM
	VfK82fHJiA+wt3KWS5KyNYrlSJRiffLUJK/iKThjzmQfufu0lv305VuUxJTSJ+Cl
	0jTmkN12Hj9RH5BjzYGtbZscYHJRO7VFhpDEDBfWlXoLCYiwW2mbkO8upF0BBba0
	zW2kf1v/5qXGblLliejsAvEdytoZJFTOY/mtY1JmkEwGRJgZDp4PS6p6SKp7PGDQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4f0br-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 14:21:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NEJnsS017000;
	Tue, 23 Jun 2026 14:21:13 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex66k3nje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 14:21:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NEL9qI28049744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 14:21:09 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBAB62004B;
	Tue, 23 Jun 2026 14:21:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22EB320040;
	Tue, 23 Jun 2026 14:21:00 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.39.19.165])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 14:20:59 +0000 (GMT)
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
Subject: [PATCH 6/8] ppc/pnv: Remove Power8E and Power8NVL pnv chips
Date: Tue, 23 Jun 2026 19:49:31 +0530
Message-ID: <20260623141933.577981-7-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623141933.577981-1-adityag@linux.ibm.com>
References: <20260623141933.577981-1-adityag@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDExNyBTYWx0ZWRfX0CTqQVZXd4ms
 Lls5NEOaXfHCPtoFXI4oJhstPmf0UOMaIea1nrdU0UXa/2yXfoYKRnCTqWr11S16b3dpeDVxOkr
 OHmwM8slRFM+jmE+9ctIJtlnXBpInYc=
X-Proofpoint-ORIG-GUID: QvayJPyRZArMUL8O5D8_mHc-6aPe0DfR
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3a965b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=EUspDBNiAAAA:8
 a=VnNF1IyMAAAA:8 a=VZAblS4EJK4kQvDgE7QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDExNyBTYWx0ZWRfX/HBNFKUC51O+
 uoi24ZdmSOmG9VAIPXIJ8QTzXw/ynwASVyZHLAglWN4uIahFj/WqklljVboMksNenBhTnXx/ryy
 GJhbwvxZZVTrHWOgV2GsWeA/UghpKETCym7i9AWyVIvRUEJv4+F14yuMX9NraNsxIwdVj6/ttiO
 6cUQmF2Ojf+DeQnzSx0SRT3T04FSMAnoa1V1lCZOjA9DlqGJNYx/Ocuahlur01kCzSVYaec9d6U
 grQ/c5XzA/dM6b6HQxQW5c1ZuxVQJJfu8R4XREIDdFXKXRSlvwe9RlrnqzOGGKt8qzwYj3hiTmy
 KvfrfYARgkxjtX8WckPbp+CdtlEqf6DR57Kx1VPKA7Iwcj5HKYeGTatzH/v+L6YujMQzzW/Qe4f
 5EEp3V0Gx2yUFEI72cprUhUlzPFvHNQb26Ik+miq/iIWiIHO5N9kJDRSicARMwsmM3g7C2YHKgw
 A2XSACF8a3zsMe+pGWQ==
X-Proofpoint-GUID: htw4gd88S2S9Y9yPYA391_XJftSEFF8s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230117

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

