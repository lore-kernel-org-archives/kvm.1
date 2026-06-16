Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4BD3B995B
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 11:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781610007; cv=none; b=LewPUP6b/SJ3g0Bo8Id3qO2BVlBfiz9RbY45t6Y+epn368FEYtMvN2y7HhZW2UYDxwbQRCASbg4hCaOv7sOIvtCgQApYpMgvAKTDGg/BBRdP31RWVY5DY/j8VGiqGqxOwyxZAobPDQfrr3z5FYgdNZREDWMOq8+zaURaY0JB+X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781610007; c=relaxed/simple;
	bh=r7h/s55AiRewJ1aotA0jq1kbAKTT3G0DEmxLJbkdXjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E52ra6dRLMR+rzaXlY1tlb9hqncSh+EHpxryYLYTOIyA4RlzY7DPK+gs7ZmYkBkl02yzQvJ+qALxfaSey3FU/kQbr12zQ9GzaDqHZo3SXRYv3Y+/qbfymQYguBCwHBJ+RbJmNAeGxFDI+Hh866bcRBxtXNA5DSb+q9TFNNf0Z3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m/9g+F+U; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m/9g+F+U"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GAIlnl1397005;
	Tue, 16 Jun 2026 11:40:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZUdoNLwSVIuk62bXZ
	67XSBlvUH9tV9NzX1E3a3D6kDo=; b=m/9g+F+U5LGJXaZZci28qRWtQD3IGz6WO
	15dd4pzeI5YetVoU3t/CVIFR4mFR+QgPIEqHaOQTvGAGum1fYBMRWYPv4+XK6Ij2
	LQvxhzIL+SBdcCH3OD2OtejR9fxqedwjl29ZvIeH53r//p/o83phfndDE24FYOq1
	paVNisTsGw3tXmjBAqU0TpSCTmrFuNnYiH3J0W9tvM1L/LMjI/LGoWvaB7meJMZU
	a9VPC2cwnvVrlR4KhxUmh+/oQL7xDjk/lnkfTrZBgxAcvrj7j/syAotkAeiH7Lqm
	ZUnGCwur0FSkkcxZfIXGuRzzXp8NlJctXn3fabrfitbb+YfbxHrZw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1h85e6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 11:40:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65GBYv07012469;
	Tue, 16 Jun 2026 11:39:59 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4esk1h31am-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 11:39:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65GBdt4046072210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 11:39:55 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E8AE20049;
	Tue, 16 Jun 2026 11:39:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F128620040;
	Tue, 16 Jun 2026 11:39:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.31.150])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Jun 2026 11:39:52 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        qemu-devel@nongnu.org
Subject: [PATCH v3 3/3] target/ppc/kvm: Use host compatibility mode for nested guests
Date: Tue, 16 Jun 2026 17:09:15 +0530
Message-ID: <20260616113915.25589-4-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260616113915.25589-1-amachhiw@linux.ibm.com>
References: <20260616113915.25589-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDExNSBTYWx0ZWRfX5AJZgDlW48eY
 RXV+hq++EU1Qw/8HZFms6QNEAJu4ZVi8soScqyGFvGhTrU1gtk2LClhGGaqNUAikk+ofMNz27TQ
 3XanGriwIrf4TuW5oyb6bUMJg0R/sFk=
X-Proofpoint-ORIG-GUID: G23fYg7wKZOHpK5IDZoMuACrq-uvsgDo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDExNSBTYWx0ZWRfX/SCd7w/bnVPN
 xiRM6XT5jUzI/ndb3QsQAH/hVUZ80vBdv/gzpAVV6wIMQX/RsLiFpkG0wCfsfo8HuxYhQJBlE4Y
 KtoHJ/iFBZqu5m1UFOH+vztbpYGcMIKmpzML3dx0y65JYrsIWlkWwc7g+UU/Tu/PPoigMdNu+XO
 TS7Hgly7URU9gu68JM2jb5Fj+D5vhaYN+Cl89SBvO+nmMdo12fxTa9qDCVsYi9PF8FTpu1EkMzX
 eF2t5o7ZwrSMpAG/a7NmR+3zHBebcf3luObG6djdm++j0buzipIbb0yq9XH6foO6AJSTnxRbaJy
 VHR7sTG8IV1++ORns/DkYyN3jvPH1W/8tqKYJZ2YaW1yyji3BBcE/sHo+/7snvG/+3TQDQ3H8jg
 YOtY6oGw0/+7Y6EvYn1/evizTa2MYjHFD0WT1ouFEhcuwpTh9sjiPtLI8nUalVnbshkOfSYZ1/0
 +nzkpcQw1PTOxwZTNJA==
X-Authority-Analysis: v=2.4 cv=U9uiy+ru c=1 sm=1 tr=0 ts=6a313610 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=Xl1zm9qRz71utLZm77MA:9
X-Proofpoint-GUID: 2QafHAVmJQlNCaIeKdNalOVcBlhnziDQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160115

On POWER systems, the host CPU may run in a compatibility mode (e.g.,
a Power11 processor operating in Power10 compatibility mode). When
running nested KVM guests, QEMU currently derives the host CPU type
using mfpvr(), which reflects the physical processor version. This can
result in a mismatch between the CPU model used by QEMU and the
compatibility mode enforced by the host, leading to guest boot failures
such as "KVM-NESTEDv2: couldn't set guest wide elements".

Update kvm_ppc_get_host_cpu_class() to check if the host is running in
a compatibility mode using kvm_ppc_host_compat_pvr(). When available,
use the compatibility PVR instead of the raw hardware PVR when selecting
the CPU model. This ensures that QEMU selects a CPU model consistent
with the host compatibility mode, allowing nested guests to boot
correctly.

Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 target/ppc/kvm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 9e5006e0c2cd..a72f237f0c8a 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2672,6 +2672,15 @@ PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
     uint32_t host_pvr = mfpvr();
     PowerPCCPUClass *pvr_pcc;
 
+#if defined(TARGET_PPC64)
+    uint32_t compat_host_pvr;
+
+    compat_host_pvr = kvm_ppc_host_compat_pvr();
+    if (compat_host_pvr) {
+        host_pvr = compat_host_pvr;
+    }
+#endif /* TARGET_PPC64 */
+
     pvr_pcc = ppc_cpu_class_by_pvr(host_pvr);
     if (pvr_pcc == NULL) {
         pvr_pcc = ppc_cpu_class_by_pvr_mask(host_pvr);
-- 
2.50.1 (Apple Git-155)

