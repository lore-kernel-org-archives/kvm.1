Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29F733B6D9
	for <kvm@vger.kernel.org>; Fri,  8 May 2026 08:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778228078; cv=none; b=XIQy936sI4qpd0CFQSlgSUBG9Q4D64kYYTs3vwEezQ7p+2WyYBwHcglGR+fMlYIvoAuYRPaFVNo9C9YMVae6ZrRB/w/AdDOAPWLvs1T27pLxqWlnelhbA3DvB8jdohbkX4RIXbRLYWxPJA8/m9ecyRncTrUhQ21Op80CnLSuLBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778228078; c=relaxed/simple;
	bh=YDGIrXgKsO3Ei1HKlLtyoOZqzbyT3fE4FDW0LZy7ryI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NBG9LSTtbPDvor40rMCaqM+C2DngHWHeh98jxV3GpttmHuPH7rpL+XY5IST4DBedLGcwO26lCKycOlN5pAy8UzbU8WqpAQhGeXeKDAmz7u6kpjyYEA4L1s/jYYtbHVqv1KGGPk+OjNQJ5CVtpXeAVdE5mi7lmevqoSL3ONGV3vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NQ22gfZb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NQ22gfZb"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647LKxnV2062528;
	Fri, 8 May 2026 08:14:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Z3s9YJUZkkFMwMz3xZUeXBjH3vF93sl7MG2xzNIRg
	FQ=; b=NQ22gfZbo+UxAeH/LvjdCf23+3J+w6xY6ViAKOrIPprWHe83EXqI4CrwS
	IBD3PzdwJmJuU5VGrRGHudJH4rOn5st9QFmftPbmy7m9RmNydF9wbOwTw2Cp2OjQ
	1de20sLpRS7THMLqT336moP8fi+MLofRrv2cUJQt/trre43nGCyTm6umwzqg9Y8/
	Byj4fU0shtidrz4GVL2wMF7Tzi1hD0bpSlKC5AQWzzrvhb7ntVtLD5spAYbQ4H3c
	BOi2RP+ltPvfIid6CILG0dBcnEvdp/tvwYWLAZNSo4+QQKIxwpZi10e/utDR5kks
	k3MpGZQ1B0iWrHzYdOvMcUNA8PesQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w6sfpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 08:14:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64889mof032650;
	Fri, 8 May 2026 08:14:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwwtgq637-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 08:14:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6488ERQa54919582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 May 2026 08:14:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6572201A6;
	Fri,  8 May 2026 08:14:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09AAF201A4;
	Fri,  8 May 2026 08:14:26 +0000 (GMT)
Received: from mac.bl1-in.ibm.com (unknown [9.123.0.51])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 May 2026 08:14:25 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>,
        Amit Machhiwal <amachhiw@linux.ibm.com>,
        Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
        kvm@vger.kernel.org
Subject: [PATCH v2] target/ppc/kvm: Fix const violation when trimming CPU alias suffix
Date: Fri,  8 May 2026 13:44:16 +0530
Message-ID: <20260508081416.1014-1-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69fd9b68 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=AeOTFisfVSLvIChBu_YA:9
X-Proofpoint-ORIG-GUID: WaN1AC-txv3OxNEf3wjo66vUuO9DbVsf
X-Proofpoint-GUID: keBsE2Z7nBSFIVOlkCYr7Ezz-iXBpZYs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDA4MSBTYWx0ZWRfX25FqieNcQr7U
 nFzebQthH1e0+fhjg/oRlVTnf+vbVVCc54Q6OU2eHAFrWHGGZkO9vp3WSXWN/q2yiNhwccvNdO1
 C0pZXest/AXFYpOy0hqWm25LVwrKUGpI3nPNXD/YMMR5dnv77RtCWvcHIyc3X7Ir5KqrQoJYRfq
 cL2X8KCwBREX1oO5WS/iECv49VtkGPtsKpZiUZtovyCoRtx3wfiyVvjMKCTKANUpTy7kJwVqiM/
 QQhfEvo1//hhrGuImhCfSJzqf7/3uCrHcd0FDU+lVFTzM347F8ooMFUuafAl53VgZBwzIPaeof3
 LytYSRCl53s/kZmOcfdgkO8vHfI5A9ud3LM9ZY2uHn7xJ2srRO/LtbdWpoASjyao67ZT5DrvB4V
 FV+v6RWfefWJP0Wh3F0xIwJigL2nazFVjScJcQNRMEkkXi8CNtv0tpJkn4PonF7kCoZ8cGWonbb
 HNSgheyUeClEzkC13Kg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080081

GCC 16 tightens diagnostics around const correctness and now correctly
rejects attempts to modify strings referenced through const-qualified
pointers. In kvm_ppc_register_host_cpu_type(), ppc_cpu_aliases[i].model
is declared as const char *, but the code was using strstr() on it and
then modifying the returned pointer in place to strip
POWERPC_CPU_TYPE_SUFFIX.

This results in a write through a pointer derived from const data,
triggering a build failure with GCC 16:

  error: assignment discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
        suffix = strstr(ppc_cpu_aliases[i].model, POWERPC_CPU_TYPE_SUFFIX);
               ^

Fix this by duplicating the model string into a mutable buffer using
g_strdup(), trimming the suffix on that temporary buffer, and only then
storing it in the alias table.

This preserves the existing behavior while avoiding modification of
const data and ensures compatibility with newer compilers.

No functional change intended.

Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
Changes in v2:
  * trim the duplicated buffer before assigning it to ppc_cpu_aliases[i].model
---

 target/ppc/kvm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 25c28ad089c6..c2843b1421cb 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2654,13 +2654,14 @@ static int kvm_ppc_register_host_cpu_type(void)
     dc = DEVICE_CLASS(ppc_cpu_get_family_class(pvr_pcc));
     for (i = 0; ppc_cpu_aliases[i].alias != NULL; i++) {
         if (g_ascii_strcasecmp(ppc_cpu_aliases[i].alias, dc->desc) == 0) {
-            char *suffix;
+            char *model, *suffix;
 
-            ppc_cpu_aliases[i].model = g_strdup(object_class_get_name(oc));
-            suffix = strstr(ppc_cpu_aliases[i].model, POWERPC_CPU_TYPE_SUFFIX);
+            model = g_strdup(object_class_get_name(oc));
+            suffix = strstr(model, POWERPC_CPU_TYPE_SUFFIX);
             if (suffix) {
                 *suffix = 0;
             }
+            ppc_cpu_aliases[i].model = model;
             break;
         }
     }

base-commit: ee7eb612be8f8886d48c1d0c1f1c65e495138f83
-- 
2.50.1 (Apple Git-155)

