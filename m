Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A239470E8F
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 17:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786554575; cv=none; b=e7UB7Ms5iLaqcUJucq4e+irsj5OMfaqqSPEndAfupcSChXxfrtXhN1uG/wDYhESPrjOucY3dTvldnPQhHGETakhl25dr6Njf/EreGCchW6z24bWp1+6ff1uHebuPHWEJUQMf7i6zGD+68o210MDkWfTQL81CMe42cpqfEhffdZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786554575; c=relaxed/simple;
	bh=AnzHJMkzwTwCgl+DKe+I1O1CcnqPHEdrlRSPc7SvIwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iPyyjqyKT+RUZ3BEf/xRWeN1BJ3N3Usb1YRk9X1VcQGpxUX4DP62NocZts5nmZgEF+rlArNCdzv1Tgu23nIwgxxy9r8UeWXjd18lR8sINVzz3VIt+on4yijw8Yj59nIoS9uUWRm6fm5rG8FeBUqqEEOd60HhfxVjxpiQXANovyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pZPthJsT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pZPthJsT"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CH1gc14120485;
	Wed, 12 Aug 2026 17:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/T0WS4SIkRcrSpUP3
	8rfnpqeUflQc+kavwNr8Od2Nz0=; b=pZPthJsTxBsHvjvlLdEwhla1ZjYw+WQcc
	BfPXOKTn/BdpkK7mh1ixZkLk8Gx6vkm4QtN/YFeHckJgXWNy86pr5yfP9X9/64m7
	H2uvpWGPIcjbLr6dYXIohMBCK8K/88VSn01Oja7cU4lh9IFswK2HAN8AkzlG0t1v
	bAxd1nc6q2Laf223qG8qCwH6efvJmPvadTiNbR75NiOxfI0j1/u3gEctWKG1DOZM
	05Rn4NYAsQTJfSzLY+A6suQlP6+qWARtqd2tqPVUhpZVvrJYZC5SHOfVNDaA8vG1
	l2UJucgMYTFKrgGsHLzjsJ6Vxfwdbyq5LKuKQncU91uY9cDvtbExA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnwau7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 17:09:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CGuiXW021425;
	Wed, 12 Aug 2026 17:09:27 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5w7737-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 17:09:26 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CH9M7L39780808
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 17:09:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA3D22004B;
	Wed, 12 Aug 2026 17:09:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C71AC20043;
	Wed, 12 Aug 2026 17:09:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.26.117])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 17:09:19 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        BALATON Zoltan <balaton@eik.bme.hu>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        qemu-devel@nongnu.org, Gautam Menghani <gautam@linux.ibm.com>
Subject: [PATCH v6 3/3] target/ppc/kvm: Use host compatibility mode for nested guests
Date: Wed, 12 Aug 2026 22:38:54 +0530
Message-ID: <20260812170854.58709-4-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260812170854.58709-1-amachhiw@linux.ibm.com>
References: <20260812170854.58709-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7ca8c7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=Me7h5qUP0d1xqhSAURgA:9
X-Proofpoint-GUID: POFFskJEaacGD-eMMRNz_daIFFDQU6lS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfX3xWsDl1nBKkO
 Jk4eT2mcHqrxW1rI89QcBmxYpl6h98fjI5MsuG7LExf6LrvM2k3OubRzeFtGlLrSmycgjcf7OV+
 gWjjk/6RCCsIiLlWhgTEXI2EgL3Q+X0esmFwKr0CF2jO3MVAqVKI8CaXuiF/IiIGJGbhVtYEJTd
 mcMFPUooYBTy+x1IRGYPhNunzYflxHNu6EXjJKZMSeU9J7hVVIpIFzQa/Fj0DQuAa1mcHhpxY9d
 zu5vEdTukDloFZpDj8iAin5jeYwRXL+BECmZhAoI6Tk24c0aTKO3KLlfG92mfgEB6EROQa5N0O0
 8yGnQKRiS5rLmYLb0RdK/WyeI1X8Ex7lvcjFF0hBAEVmSuuNyyRbTNm0yTNzzE2rp0ivLIqJNjw
 Dvuiv4ut9WZVjI1cC31wg55As/fYnCz+pDckqxxyLHomGf3zyEH+DaMLY0P2qEiLalz7nj3GuQT
 wLxw2ui3Y9hVRp/pK7w==
X-Proofpoint-ORIG-GUID: 7rrctBy4iANJzvQ_y_zWgh8zsvcpYO83
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfX2cC9uLqWgZKp
 suKLq+2e7O3nu7iM5airvENgl7bBbDYVIvVroTa3R39eyzhv6AVnC3o82mqYYdcH8G+yyfSLoqm
 SngjPvPQ3JfVygh1xDYXImpZQ1jErh4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120138

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
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
Changes in this version:
- Drop redundant #ifndef CONFIG_KVM / #error guard; kvm.c is only
  compiled when CONFIG_KVM is set (enforced by meson.build), so the
  check can never fire [BALATON]

 target/ppc/kvm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index d4c5601a00c4..8e89a6c665c8 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2682,6 +2682,15 @@ PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
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

