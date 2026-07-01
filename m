Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E2D3A4F50
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 08:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782894281; cv=none; b=tC66azgf85M3PGHWzblGaS5EuPgkhCdQwG51NMEsEF3aoUT/b9+O1v++YrpPEyYwzXo2/DjnxkpTMMFbgolwNBlBvc6uDxJLNyb2kDau6qMd2gF/Q67J7gdCvJQjT6AxEiPNT11iQxMSypeXmf/2RPo6ouPl4F1T1eU+AwTpGXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782894281; c=relaxed/simple;
	bh=5TxBaUflgz5eQVK869IdrRT8vAYXJTbqjpiDWLh0tLY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sB8miHXUudAFkBc4FLnrRvonHyA0CQdfvUmSDPvJkOYNYIYdzP/IFw3tLbejFE9sNh6ku0DQUbhvFvMZaDbNVyt6ORPeWXaLzpRTzkDiQRC5nxwmWG4Do6piU+33dlcNrjbMFaceMGFAlHKJ2IZv9G6tpoclr2obAw8/ZObtSU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jhIc89Hi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jhIc89Hi"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6618IEEX356559;
	Wed, 1 Jul 2026 08:24:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Bbsppc
	mqLRNPoG0lCmOTk1sTE819Y+Maaf5A/EqIDpI=; b=jhIc89Hi2fhMtAKwvpq5Z/
	we6JmMnryOM2TcfkpXl3qp7re3l0FWm4rMhITll/MOBegO2xWyl/SnyER09b3K1Y
	9PIH6EhCmE+ARhi+WoIe0XkvHrKGG6w+5zj5E6GATPuQymmch2pgwDQOL8FhugZq
	anZgKTlpNSiGwmh112ERi6d+p+VdP1B3SM0Sb5nDFRslH0uUjXXGC64WdpeNUAcO
	8LoTAJzgAoNaYabB1MrhaY9Z8Iphu4rFdYzGA9DUKhqddc0gNVWypip9EPNyQj6t
	jhiPDGBEexDFWV8D+W6COhUGsXtSiaDFBv+Jfp4Isifwdkd0MDDRjQxSimC7ycRA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pe3egx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 08:24:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6618K4I8011940;
	Wed, 1 Jul 2026 08:24:27 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7w6fxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 08:24:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6618OMeU43057438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 08:24:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBCE920043;
	Wed,  1 Jul 2026 08:24:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5A7D2004B;
	Wed,  1 Jul 2026 08:24:22 +0000 (GMT)
Received: from [9.224.78.25] (unknown [9.224.78.25])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 08:24:22 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Wed, 01 Jul 2026 10:23:53 +0200
Subject: [PATCH v3 2/2] s390x/kvm: Add ASTFLE facility 2 for nested
 virtualization
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-astfleie2-v3-2-f692dc7f4f24@linux.ibm.com>
References: <20260701-astfleie2-v3-0-f692dc7f4f24@linux.ibm.com>
In-Reply-To: <20260701-astfleie2-v3-0-f692dc7f4f24@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        David Hildenbrand <david@kernel.org>,
        Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
        qemu-devel@nongnu.org, Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5540;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=5TxBaUflgz5eQVK869IdrRT8vAYXJTbqjpiDWLh0tLY=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFku57bu/Ge2S7Rj1yLvsH8Zipn+GbXL9qzmlu9bsea61
 OzdHwLudZSyMIhxMciKKbJUi1vnVfW1Lp1z0PIazBxWJpAhDFycAjARDjdGhtNRO6P2hHUJBa8t
 137p8f7iioWbulsWXl17/Gn97+T0NRsYGY5EPZgTnrHm89QVBbOZJ6TeuBIe+Pj5y99Oz+4fWsr
 YaM0HAA==
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: G-MeYObjR48Q6w2wTf1V-PnwDxhcHb1T
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA4NCBTYWx0ZWRfX1gUx/HfPamvU
 YhZmAR7lW/i2sGpC7dHB89Qk6JvBQWZlt+enMRQtAi2Gubx84OttPkRi7TdCAWCOOXH3yl9W3d0
 0N9vCWCEGDVT5F8G4ChXwIWLw66XhwM=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a44cebc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=c4FJ2arq-s_u2TxWmaEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA4NCBTYWx0ZWRfX9NoCC7iVlB2L
 hqwxlDTcAfgKjbtftG0dX5rlWM1RNNjjRahhvzxi6WEqrecCbwI12wNAUNfGDFxk6FFi0RCqH6D
 ogMhKNtz8nL72Y9z2GBJCqbxdECTKz6Wlz6hE1EaFN3FF+vz1zlfly3bMC4tKT0rxIEIp1mG9vE
 okpFjj46BSOo4qDO792Ed+YGPQIJyDQvulDwDiznJM97/AS14nW6mglKWRehV/LbDxjtxDJeukI
 898q3CYwd0XgawkORm+AHwHiqSX8zYlSzhXCUIxUZvFWWMaDNqc7EOpsDblFK6JY2wFeltkpr2h
 xy54h66n12P75a8F4AR2U7SZZCucGJqG3wA790NVhLJZdBRbi8BCr76W/ddxZuI+C9MCaU7khp1
 oRPlXACFg9+dVCOX0zrda8BvtVCretUESpwUz5iWxyGnqos4b/HFzHeUpwHyJoidNJ7H6rePvSf
 RU1LMEayxug+ftalWVg==
X-Proofpoint-ORIG-GUID: G-MeYObjR48Q6w2wTf1V-PnwDxhcHb1T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010084

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
index b9c3983df195..2d2cde7803ff 100644
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
index ddc61f1c2148..e1f9b0f6bc10 100644
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
index 4b5be6798ef5..896914888aa9 100644
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
index 5635839d0329..52a82da751ec 100644
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
index c017bffcdc4d..a822f0f2fe99 100644
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
index 0b88868289bf..2dd9aac8078c 100644
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
index 8218e6470ec9..a309dc2c09ab 100644
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
index fdef8f9e8acc..9af2a397f5a2 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -2288,6 +2288,7 @@ static int kvm_to_feat[][2] = {
     { KVM_S390_VM_CPU_FEAT_PFMFI, S390_FEAT_SIE_PFMFI},
     { KVM_S390_VM_CPU_FEAT_SIGPIF, S390_FEAT_SIE_SIGPIF},
     { KVM_S390_VM_CPU_FEAT_KSS, S390_FEAT_SIE_KSS},
+    { KVM_S390_VM_CPU_FEAT_ASTFLEIE2, S390_FEAT_SIE_ASTFLEIE2 },
 };
 
 static int query_cpu_feat(S390FeatBitmap features)

-- 
2.54.0

