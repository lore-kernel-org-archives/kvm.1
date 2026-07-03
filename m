Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949AF38D007
	for <kvm@vger.kernel.org>; Fri,  3 Jul 2026 09:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783069268; cv=none; b=C5I8d+1qAX8YxATibUY5UBJ++XmuwfOFGDY0Pe6TE2x+Y9meqpsU+BoF2fkmWMFUMdA9Zah71ehZS24ZePpJqHfNx2NubRliFcMyT6FypfoIwp+i2gTqpaWQBo+kvXvgO9UJ1UyFBiOuanBF313PyJIQBl8LdmRvz0dQqPIGbCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783069268; c=relaxed/simple;
	bh=m4MCnYyItP+UZImh4i8v5Xs50Hkr8RIoLVW6eArIJrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lbVnw72Heanwcdxxs5EodMw18JwDzlh6smY7SDS6ap0J6ru96i4dAgwc+YJixRlPyrexHOfsjF2d1BM9pz1rT4rirrAZcRgjhrBy/iHlQFzPykwFigmbSPEPfHZunqevmnNbPQoqeFjtd5LSG7spRLRNTccuRQx043TJt8jDuIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oTTaTlFl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oTTaTlFl"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6636JJ0Z1814484;
	Fri, 3 Jul 2026 09:00:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cRqLRB
	RvU+1JsIWZZOfFr97kcPnb64PP4uiZ/Exe8y8=; b=oTTaTlFlNyKsT7KA+LoNbZ
	48WoL8PdkIgO1Fa0gcUcvizwWjQ1JjdkRoFQL5Bx2aUvCIQ0fT4xc38zbcU0Tj0E
	2aqDyMIh921lyFjwIPnmUUwM1sSQGWcKi3bq5jMSuZHGclAcjmpPV7Bcfu5vFhyu
	l/UT5tgYTbteWu5fDIKRt/PQhjPuBBiq65yfPRv5wMb+IL8nmu+w1MJj3y1MF005
	3bCv9W3ulPVWJz3g1QaFNTFBNuUHwwdA9JeC0qoVebPbrb24eFjVq7l9tCj7hRL/
	XgihxkBHV6y+KdC5HXc+IB9N8nJO3Care752ln1rtMXRzX4YJVG5BLOCakHDhKDw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qadxb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 09:00:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6638niEm029611;
	Fri, 3 Jul 2026 09:00:53 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruqr8tt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 09:00:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66390n3O27656652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jul 2026 09:00:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9CD72004B;
	Fri,  3 Jul 2026 09:00:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2DCC20040;
	Fri,  3 Jul 2026 09:00:43 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.124.212.167])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  3 Jul 2026 09:00:43 +0000 (GMT)
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
Subject: [PATCH v4 RESEND 6/8] ppc/pnv: Remove Power8E and Power8NVL pnv chips
Date: Fri,  3 Jul 2026 14:29:53 +0530
Message-ID: <20260703085955.2318600-7-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260703085955.2318600-1-adityag@linux.ibm.com>
References: <20260703085955.2318600-1-adityag@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA4MyBTYWx0ZWRfXyxvidFxSMO34
 M6i9P+w13KY9fZGzJn5hOn49LxsteNqgT88T075I4t9X//ClbaVNSI1szT+4seZRz/EU3n+JINL
 RVBL/XvAfWDUJmCNQj5NH0rxI64d67Bf6IGZK+KaR6Bdx0soSeCkddSWNEs2IMkqx7d6++erZnh
 qAMYzv/V/fUbhv16IlHxf1bkT5AHGyQmjAYcPe8r28FtEAIS0XEq31xal/yY/4SPGiEpV9WDuXO
 QGuFySSEzOlSao1aXi/IPeFQZYMtDG85gUM3GOIVJFblYeYm5lpPXnLhFOBOV80OC+W2Zblumng
 MHGKZZgEbZaH7iEUhxyqhfqncFEGk2dhgTw4boc2K3nWd4wtacRdtFXeobV5hisWaoTF8+IR5bP
 nr03lj1vWtW1PoQaOQ+QtIsKAXW+JPvoK7G24ZQGC8ZVz34JitBbvr+5uuS98rV7HY5OfQnGf7i
 3TRPtjHhlkC5P2d/jLw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA4MyBTYWx0ZWRfX7h+ncHuv1g1t
 tkdDO+MD04OA2/1roPl8H7jNoyMp2zPz3Ev3au/gbtTd6m6UlLzxtbYaJ1dXxRB2qjJ2uIZtdYD
 gpJBZv5DrSbgSmWgO+/FCkQwIzQxPfE=
X-Proofpoint-GUID: 4uM2S71JMdU0dYUlKjYbTfr8-FKxIOh8
X-Proofpoint-ORIG-GUID: oh7BERG39UVyabnbgVNeiokcff-dV3TF
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a477a46 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=EUspDBNiAAAA:8
 a=VnNF1IyMAAAA:8 a=VZAblS4EJK4kQvDgE7QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030083

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
index afb6019b1098..c0cb45dbfbc4 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -869,16 +869,6 @@ static ISABus *pnv_chip_power8_isa_create(PnvChip *chip, Error **errp)
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
@@ -1646,7 +1636,6 @@ static void *pnv_chip_power11_intc_get(PnvChip *chip)
  *  EX14
  * <EX15 reserved>
  */
-#define POWER8E_CORE_MASK  (0x7070ull)
 #define POWER8_CORE_MASK   (0x7e7eull)
 
 /*
@@ -1827,30 +1816,6 @@ static uint32_t pnv_chip_power8_xscom_pcba(PnvChip *chip, uint64_t addr)
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
@@ -1875,30 +1840,6 @@ static void pnv_chip_power8_class_init(ObjectClass *klass, const void *data)
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
@@ -3785,9 +3726,6 @@ static const TypeInfo types[] = {
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
2.55.0

