Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514FF3D3CED
	for <kvm@vger.kernel.org>; Tue, 24 Mar 2026 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774367061; cv=none; b=DYJkuZ1a/FnOmzUlrc5sjplxrWgC7Fw7+zwMhvBvYOr37h7DG9urN94nSyMIiL/+AYM8+Kt4CH6NJMKWX9nYj3sdkRoht6+2De4NfEiEFpex8cXPrK1B0DiVLS4lKiOLcHChCUoyuac1+TWMkZkmrQ8pxq7C+x2c4TaXiaMvMAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774367061; c=relaxed/simple;
	bh=gvG1XcpG/glmsAiJrBhJcMuZwl6O4NZQ/EvHGVriQrQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lAMTfu7munBtqDPm33Y5msg6LPmlUl23CirFpEGRGRJ7kt7IRasjeuMpUyfL1fxGtU+G0uNKSYV/83SbU91hb4VH5L7z6a8/SKzfcjr4umj2YzAGdRLS8+WK7wcXKQlP/EXCEkfzAQrn2zju5drafW9YLeKOeDESYzMqvzTog58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bdSZ5hqq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bdSZ5hqq"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O8iEUc478394;
	Tue, 24 Mar 2026 15:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DOvoxt
	/dv8MUFgtQa8JC8Zxbpi/ZvyJVq94Iqcmyp7w=; b=bdSZ5hqqzjrs+NqA8QnFJM
	70WWgE9EAu9csdSp9lw67bHWwAB7Oecm7E+N403pa1DGjunJ9z9AcgO/a1YgYuI0
	FHbUoPR8Pxyg/r8PQwlgS9dFplenAVKjLUVdHNO3oC9bOM3bH0bxAR7zxGJ6JhR9
	GEn/5E/YqO0IgVraOZXY55vTigsDfhQqbDLCfLt0ASs1c/Tvj8CDjtgq8U/VkGJV
	IymxewDikjvN4+gUhIpUFhXXgtt95fdkQKIlaPicy8WJ7Gwc+IUDxlHPoMj/Dmzx
	SzX4vhmARg16ijk0apMMXmxkKjlEdz3sUmz4ZIh1Jw+u40xngORuCQ560pkWbk9g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kumkrr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 15:44:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62ODTgFp004407;
	Tue, 24 Mar 2026 15:44:12 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c22agr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 15:44:12 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OFi8uS48890202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 15:44:08 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B81202004E;
	Tue, 24 Mar 2026 15:44:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E241520043;
	Tue, 24 Mar 2026 15:44:07 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.21.79])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 15:44:07 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Tue, 24 Mar 2026 16:43:45 +0100
Subject: [PATCH v2 2/2] s390x/kvm: Add ASTFLE facility 2 for nested
 virtualization
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-astfleie2-v2-2-13008712da00@linux.ibm.com>
References: <20260324-astfleie2-v2-0-13008712da00@linux.ibm.com>
In-Reply-To: <20260324-astfleie2-v2-0-13008712da00@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>, kvm@vger.kernel.org,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5988;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=gvG1XcpG/glmsAiJrBhJcMuZwl6O4NZQ/EvHGVriQrQ=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDJmHNrraxL9zqCz3cLd/eXHR//XPORiaL/juPi+jqFy0m
 /1b6fJbHaUsDGJcDLJiiizV4tZ5VX2tS+cctLwGM4eVCWQIAxenAEykXIzhn/VJ65T1glsTKgTO
 rxWZcynmSUkn21+evX5bWhR+f9zpWs3wv7jju66eT56boI3PamshtadNSf4TVAP+rW9T5yg+v1+
 eDwA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HrTQ161wvs1NIvoCf9it2y1Il5DmYOCc
X-Proofpoint-ORIG-GUID: HrTQ161wvs1NIvoCf9it2y1Il5DmYOCc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDExOSBTYWx0ZWRfXwacVdL3oAH0x
 dI+sz4ownQdJWWM4ScqmJXdRmerbSrg8tOVk8N1OGPs1577LWGgMxqIa7Drw1rcYqfa9zM1OfAF
 Ug3q6sr+kvsUjwHaWtMooyIJJ4mBdzKxEvIErrxioHCBNRxpeCj0r0xTcbih3CK1VPWBgS3Wefz
 UqSzXlBbEKURxzz7k8DaJP36Ud9Sf8pi7C8G2EfwbJkLf8dVvSKY2JVeIjayvbDfhId84IYeUEn
 VagZTT5Z1YG1y9L53qkJjznFRLCFeDlgbkvKr1QQ5MvmyuIL99hOl5mVNS6GmEyMBEqYOXUFCCh
 QU4B8qN21Y3BGiV5ePnwwJwaHlL7iFQrUzOzKzL6ArwVk1WIVx9mjC0qSqdgcETQ5ao0s1KSQag
 J0BwhGXCqdzoX/nsmDf3RDLaPxDqp3dqAAmNSgrQIi55SACCRjsSWeTtPhnJoenTlw/ruFLAOzR
 rRnjubFc7onkbmiLe3w==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c2b14d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=c4FJ2arq-s_u2TxWmaEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240119

Allow propagation of the ASTFLEIE2 feature bit.

If the host does have the ASTFLE Interpretive Execution Facility 2 the
guest can enable the ASTFLE format 2 for its guests.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
---
 hw/s390x/sclp.c                     | 2 ++
 include/hw/s390x/sclp.h             | 4 +++-
 target/s390x/cpu_features.c         | 3 +++
 target/s390x/cpu_features.h         | 1 +
 target/s390x/cpu_features_def.h.inc | 3 +++
 target/s390x/cpu_models.c           | 2 ++
 target/s390x/gen-features.c         | 1 +
 target/s390x/kvm/kvm.c              | 1 +
 8 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index b9c3983df195c4130ad91e06d05c43afc6f5d9d2..2d2cde7803ff45f531047944a15308d4077eda3a 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -146,6 +146,8 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
     if (s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB)) {
         s390_get_feat_block(S390_FEAT_TYPE_SCLP_FAC134,
                             &read_info->fac134);
+        s390_get_feat_block(S390_FEAT_TYPE_SCLP_FAC139,
+                            &read_info->fac139);
     }
 
     read_info->facilities = cpu_to_be64(SCLP_HAS_CPU_INFO |
diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
index ddc61f1c21480824971888207c4ffbfb381b464b..e1f9b0f6bc10d4b2157da2e5fc8f85f8f755efb3 100644
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -136,7 +136,9 @@ typedef struct ReadInfo {
     uint32_t hmfai;
     uint8_t  _reserved7[134 - 128];     /* 128-133 */
     uint8_t  fac134;
-    uint8_t  _reserved8[144 - 135];     /* 135-143 */
+    uint8_t  _reserved8[139 - 135];     /* 135-138 */
+    uint8_t  fac139;
+    uint8_t  _reserved9[144 - 140];     /* 140-143 */
     struct CPUEntry entries[];
     /*
      * When the Extended-Length SCCB (ELS) feature is enabled the
diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 4b5be6798ef5460c71aa0f2567ebeb0aeb9551da..896914888aa98938f4e1984cec599c5f823b0d9a 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -148,6 +148,9 @@ void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
     case S390_FEAT_TYPE_SCLP_FAC134:
         clear_be_bit(s390_feat_def(S390_FEAT_DIAG_318)->bit, data);
         break;
+    case S390_FEAT_TYPE_SCLP_FAC139:
+        clear_be_bit(s390_feat_def(S390_FEAT_SIE_ASTFLEIE2)->bit, data);
+        break;
     default:
         return;
     }
diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
index 5635839d032900089515a440bedb0aca6139a41a..52a82da751ec5ac10fc738121ea28a095c08e8c4 100644
--- a/target/s390x/cpu_features.h
+++ b/target/s390x/cpu_features.h
@@ -24,6 +24,7 @@ typedef enum {
     S390_FEAT_TYPE_SCLP_CONF_CHAR,
     S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT,
     S390_FEAT_TYPE_SCLP_FAC134,
+    S390_FEAT_TYPE_SCLP_FAC139,
     S390_FEAT_TYPE_SCLP_CPU,
     S390_FEAT_TYPE_MISC,
     S390_FEAT_TYPE_PLO,
diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
index c017bffcdc4d6fb14855ceaf1e47a2c58865befd..a822f0f2fe99239fe8051f54db49773d73d20996 100644
--- a/target/s390x/cpu_features_def.h.inc
+++ b/target/s390x/cpu_features_def.h.inc
@@ -139,6 +139,9 @@ DEF_FEAT(SIE_IBS, "ibs", SCLP_CONF_CHAR_EXT, 10, "SIE: Interlock-and-broadcast-s
 /* Features exposed via SCLP SCCB Facilities byte 134 (bit numbers relative to byte-134) */
 DEF_FEAT(DIAG_318, "diag318", SCLP_FAC134, 0, "Control program name and version codes")
 
+/* Features exposed via SCLP SCCB Facilities byte 139 (bit numbers relative to byte-139) */
+DEF_FEAT(SIE_ASTFLEIE2, "astfleie2", SCLP_FAC139, 1, "SIE: ASTFLE interpretation execution facility 2")
+
 /* Features exposed via SCLP CPU info. */
 DEF_FEAT(SIE_F2, "sief2", SCLP_CPU, 4, "SIE: interception format 2 (Virtual SIE)")
 DEF_FEAT(SIE_SKEY, "skey", SCLP_CPU, 5, "SIE: Storage-key facility")
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 954a7a99a9e9b79dfb48639993055a10f8f281d8..128f6643ea235a4ab43834b7044929de885a7fab 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -263,6 +263,7 @@ bool s390_has_feat(S390Feat feat)
         case S390_FEAT_SIE_PFMFI:
         case S390_FEAT_SIE_IBS:
         case S390_FEAT_CONFIGURATION_TOPOLOGY:
+        case S390_FEAT_SIE_ASTFLEIE2:
             return false;
             break;
         default:
@@ -553,6 +554,7 @@ static void check_consistency(const S390CPUModel *model)
         { S390_FEAT_PLO_QSTG, S390_FEAT_PLO_EXT },
         { S390_FEAT_PLO_QSTX, S390_FEAT_PLO_EXT },
         { S390_FEAT_PLO_QSTO, S390_FEAT_PLO_EXT },
+        { S390_FEAT_SIE_ASTFLEIE2, S390_FEAT_STFLE },
     };
     int i;
 
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 8218e6470ec9c8c5eaa3eb7c56f04ee44e8b7ea0..a309dc2c09ab0abc7cbea32d207ce3e1c2fa195e 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -720,6 +720,7 @@ static uint16_t full_GEN16_GA1[] = {
     S390_FEAT_PAIE,
     S390_FEAT_UV_FEAT_AP,
     S390_FEAT_UV_FEAT_AP_INTR,
+    S390_FEAT_SIE_ASTFLEIE2,
 };
 
 static uint16_t full_GEN17_GA1[] = {
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 54d28e37d4dda8e341675e6bbaf5cc74ca80f45f..a4733365db3702ea17719a68cefd6fd85d2c8633 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -2305,6 +2305,7 @@ static int kvm_to_feat[][2] = {
     { KVM_S390_VM_CPU_FEAT_PFMFI, S390_FEAT_SIE_PFMFI},
     { KVM_S390_VM_CPU_FEAT_SIGPIF, S390_FEAT_SIE_SIGPIF},
     { KVM_S390_VM_CPU_FEAT_KSS, S390_FEAT_SIE_KSS},
+    { KVM_S390_VM_CPU_FEAT_ASTFLEIE2, S390_FEAT_SIE_ASTFLEIE2 },
 };
 
 static int query_cpu_feat(S390FeatBitmap features)

-- 
2.53.0

