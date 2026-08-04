Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFD43E5A38
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 18:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785868204; cv=none; b=vEAXTd4t1mTEXHLc1rZY3C0dkp2GenPFfJdlo/EhqkPItmOdzamN9vf27Wyq+JYriUPEZWec1uknIwLN5PCzi3800IJeM+6LnaIWO59a12UWTR6FfbhzbYhW9ZLQ3WjSBQqMHnwPrIptoNz/5PBdweXsoTMGkdzoqMaNFu6tAiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785868204; c=relaxed/simple;
	bh=WMCauTPi9b8YzmvpE6svE6kN/5szyxscqukRXG03FD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SSlT9J3HG/7Ft/uwZdn6oZmw3t0V0MYpdZziZgBbPx8mhDZ5H9LPVgQ2WVHkb6nYQrLJse96wEx6J+0Ha9ZsTJJKkW9ZgUnj0ew3MO7EeM7Z5S7r5dJmdcbHVl8KP87qN3XzqM9AhCKjVCkditbiJypWWywK1IHKanPk+f4JxEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pPmPMgLO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pPmPMgLO"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674Fm7X91193111;
	Tue, 4 Aug 2026 18:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7EYGMmd7kqUAEEq9m
	hYmfBLDxz7ll8IbeSAUpIJFvyk=; b=pPmPMgLOTp8HePbcS0kB57+7WjzcklN/Z
	hi/UFj9I48X6vAGc518QB/RfdAsvrR4tLqwfs883c10+dt0oEkhcJmqhfM4NpDut
	FidmbgJx7bkp9l6M3N9i0DYH81jMpPWxngTIjuk5SF/DhcZMKw/SSmppngLysgsI
	N3Fe8OMxBm8ZkNA0JSPOtzJDHhvLp+6kLrSpNn3NC9FhsK8Nff27bNZ4eVcjIBoh
	V1vxHC2ADr/xwNjjMqv9Rm0k8vcZ+yjzdFpmGMdmBwpgUfxTNyCPISOpmhehNd+a
	ZBTYCa6oiaH7UkwACSDlqJM99wmne2ZhAX9E45nKEkaPvAcbr6oxg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hq75p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 18:29:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674IQOwI025207;
	Tue, 4 Aug 2026 18:29:53 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugw3b2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 18:29:53 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674ITnQL31916356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 18:29:49 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38D032004B;
	Tue,  4 Aug 2026 18:29:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8513620043;
	Tue,  4 Aug 2026 18:29:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.28.45])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 18:29:46 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        qemu-devel@nongnu.org, Gautam Menghani <gautam@linux.ibm.com>
Subject: [PATCH v5 3/3] target/ppc/kvm: Use host compatibility mode for nested guests
Date: Tue,  4 Aug 2026 23:59:14 +0530
Message-ID: <20260804182914.83091-4-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260804182914.83091-1-amachhiw@linux.ibm.com>
References: <20260804182914.83091-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE0OCBTYWx0ZWRfX2ScZHXhVWXc5
 +ALiFxk4iLmoogDqKWzIm+9RPN9Ic+o71p5EgvtJLwQawbBQ89uYCIgs8FKs8o5tmrIAnyN1UHQ
 Q381LZxyaQEkDsJ03NSYWEeABrtb56o=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a722fa2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=NAVjuql5Xawbq67qXdQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE0OCBTYWx0ZWRfX0KR+z6rI+01u
 U+se/0WNA1gltH347NGxQleXYQYR44YUH++ck4Li5yjnn5FhbdIobvCxrEjG5DgWOdJrTNBm/o6
 sUO8r7mVm/wfj73SUpZxidEdz7Tndmta7PBKXLQdBC3hGOSxK2cIV4CoDkEOjCjYztP7IALzZ0h
 5n7hbip0HE1TbG3lOSZ7HAJ9ykWTnuHh3mR22uDwfo8qMO//NEId2jZf+0EFNI/x6+HS7RjLmU3
 v0B2i/iBSnZSU8xmn6oakJFUq2/wSEBdb1LoC5QJt83nK3Zg3jkq5C3aikk2NNR3CsIoibAammJ
 BQ/+RgB9aPmecYJAR+AlqdwZzbIx0Po1aDis/cYm8aOKK3kdTianS1g/nbepG8YcTSG+Y3VgpSG
 xd9D3cFXrn73slat/RPYjvv5dZGK4yA1Td/YaRs7ymy+ZBxtGhzwnEn3b6nihvOcmloEY+6TVu6
 m83K21IegXky4uSqLVw==
X-Proofpoint-ORIG-GUID: FvG5BO6OQH1aXPddXezUvY0mC7OfENBt
X-Proofpoint-GUID: UYnpPv7MwYERSKvNnWujV9Tam59bsni1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040148

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

The guard uses #if defined(TARGET_PPC64) to prevent build breakage on
ppc32 targets where the POWER9/10/11 PVR constants are not defined.

Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
No changes in this version.

 target/ppc/kvm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index d4c5601a00c4..aa8269186a1a 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2682,6 +2682,18 @@ PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
     uint32_t host_pvr = mfpvr();
     PowerPCCPUClass *pvr_pcc;
 
+#if defined(TARGET_PPC64)
+#ifndef CONFIG_KVM
+#error "CONFIG_KVM is not enabled"
+#endif
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

