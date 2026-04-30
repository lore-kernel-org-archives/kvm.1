Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D258621A92F
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 06:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777529656; cv=none; b=L1GZQBGqUv6Z7Kq41oMPqoVwTbRnE+tWG7q/33FHhEKJrY/Ja0xAZE5TQ8D/675OWEloLX+UJ3Z80rY6dZdt/l46x9PayKbI6YAkQmpWwFJ7JGWbt7I4sKdpIJjPE6Hi9HVES97mFM+Yj7qpqxwUdjWc6ymKngCusP0UwjGT6M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777529656; c=relaxed/simple;
	bh=PwYZzC12fGRCdmfY7hc5aOdzbkChWVjYbgCGYGB4Il4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cHsuwwzUrCwpLC5Adr7kZWdt8ZBnbighNSplmKCdKC2MVZxUvxvOzDcMeuMm2mIO8ykddjhsYB1P6PlUHmD50lU+I0nnq22F+lbJK9t/jAYgtfUlNLxhpzmZ+NYX5yY3xkIda4CYCpfkbzujhHFq/j7DvuC48rsZ32JFOgkPYas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K6MGg4aU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K6MGg4aU"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TLdf9P3991826;
	Thu, 30 Apr 2026 06:14:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pwvZmbPinPYK/5tr/
	2XxXcOE/ztPQAaOmkWyg9wPbVs=; b=K6MGg4aUQLqHZcocgX5eeIgL8e1UJnAmP
	VhLlOJdbTbHGAEAyVp0P0brjwROZw4+Giz8Zjveu4msnySf7/LnK/5bpOch3fNzT
	Xo5/1V6WirKem/alabR+Ez6RoiHOy9YHXuT5Tk4X3MH+azpc7MwIExyJVhfKQmvX
	Ik4XNpAOC+wMm7cq2N+y/w8BdYkwODCLVdFyvzLXiQm5lKFSdBDvxreeoiwrLaAu
	oJjQ9z1rpQuj239FZ8OjPA5b2E7lMeXqZ51T0BZ6+0V0SLVP3rCOVD/meJSeq5Fz
	500LADSdJxvM1sEErpHazb+UVuEUjmZQwsdauWTE/l6rbMgapbo+g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn44xa4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 06:14:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63U6CXZ4012526;
	Thu, 30 Apr 2026 06:14:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsamyhegr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 06:14:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63U6E2ru38076916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Apr 2026 06:14:02 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DCB220040;
	Thu, 30 Apr 2026 06:14:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B0092004B;
	Thu, 30 Apr 2026 06:13:59 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.18.70])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Apr 2026 06:13:58 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        qemu-devel@nongnu.org
Subject: [PATCH 2/2] target/ppc/kvm: Use host compatibility mode for nested guests
Date: Thu, 30 Apr 2026 11:43:33 +0530
Message-ID: <20260430061333.37905-3-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260430061333.37905-1-amachhiw@linux.ibm.com>
References: <20260430061333.37905-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 37BV_D4pjXUlBrr9ACtUqSoOhBmvl7xK
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=69f2f32f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=n0kojfgqO0W5ScNLDTQA:9
X-Proofpoint-GUID: KD8zVK0cpXIPWATTqo3jZEvkAG5AhY6F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA1NSBTYWx0ZWRfX3+IK9R9bvGx5
 uj2BbKjZaE5F+yB3rBVD1fAWgJx8gwNbvYEJia02F1/utDin8YkizWL2p1MhaCVy9udvRWukhz0
 r9lSQlsuV4UsXSakK0zLErSDCn58n5CgReVvgaRFi7UqUVyDcwZ0MN5INLHBFrdjawKJ19T8R1P
 HdPeqcJKfj0bmFvJOjcUoZzhiljHlXq65Ohf8MQXCGJ/q3PhxhV13JnBmGyLIWY4xabzzMZ9dBF
 7yfqZo7K//QlfcukUM1JOoRHexM7a1dozIGvTbBmjJIMgRbEy45EU3bue2PkuXMv3b79ZMp5zt8
 nhlcCMSioe20othfZslK51T8dXJowgXD4Te/KLh8iPe2IeI0wA0tBcIGR13nE6H0RaWzQjPfQWd
 Xzz6VYzzwcS6pe24mF/CpG0XylHWh7T8spgpsfZ3gsgTc5YJKZf0oVEyl2dHCbW0+6L1QhWkl4X
 n9GlxNdZKQnlhaBG8mw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300055

On POWER systems, the host CPU may run in a compatibility mode (e.g.,
a Power11 processor operating in Power10 compatibility mode). In such
cases, the effective CPU level exposed to guests differs from the
physical processor generation.

When running nested KVM guests, QEMU currently derives the host CPU type
using mfpvr(), which reflects the physical processor version. This can
result in a mismatch between the CPU model used by QEMU and the
compatibility mode enforced by the host, leading to guest boot failures.

In particular, booting a nested guest on a Power11 LPAR configured in
Power10 compatibility mode fails with errors such as:

  KVM-NESTEDv2: couldn't set guest wide elements

This occurs because QEMU selects a CPU model based on the physical
processor version, while the host operates in a lower compatibility
mode. As a result, KVM rejects the requested compatibility level during
guest initialization.

Add support for querying host compatibility capabilities via the
KVM_PPC_GET_COMPAT_CAPS ioctl and derive the effective PVR based on the
compatibility mode reported by KVM. When available, use this
compatibility PVR instead of the raw hardware PVR when selecting
the CPU model.

If the capability is not supported or the query fails, fall back to the
existing behavior.

This ensures that QEMU selects a CPU model consistent with the host
compatibility mode, allowing nested guests to boot correctly.

Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 target/ppc/kvm.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 25c28ad089c6..d384161f780b 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2602,11 +2602,63 @@ bool kvmppc_supports_ail_3(void)
     return cap_ail_mode_3;
 }
 
+static target_ulong kvmppc_get_compat_caps(void)
+{
+    struct kvm_ppc_compat_caps host_compat;
+    target_ulong host_caps;
+    int ret;
+
+    if (!kvm_check_extension(kvm_state, KVM_CAP_PPC_COMPAT_CAPS)) {
+        return 0;
+    }
+
+    ret = kvm_vm_ioctl(kvm_state, KVM_PPC_GET_COMPAT_CAPS, &host_compat);
+    if (ret < 0) {
+        fprintf(stderr, "KVM: failed to get host capabilities\n");
+        return 0;
+    }
+
+    host_caps = host_compat.compat_capabilities;
+    return host_caps;
+}
+
+static uint32_t kvm_ppc_host_compat_pvr(void)
+{
+    uint32_t compat_host_pvr = 0;
+    int cap_idx = 0;
+    target_ulong host_caps = kvmppc_get_compat_caps();
+
+    if (host_caps) {
+        cap_idx = 63 - __builtin_ctzll(host_caps);
+        switch (cap_idx) {
+        case H_GUEST_CAP_P9_MODE_BMAP:
+            compat_host_pvr = CPU_POWERPC_POWER9_DD22;
+            break;
+        case H_GUEST_CAP_P10_MODE_BMAP:
+            compat_host_pvr = CPU_POWERPC_POWER10_DD20;
+            break;
+        case H_GUEST_CAP_P11_MODE_BMAP:
+            compat_host_pvr = CPU_POWERPC_POWER11_DD20;
+            break;
+        default:
+            break;
+        }
+    }
+
+    return compat_host_pvr;
+}
+
 PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
 {
     uint32_t host_pvr = mfpvr();
+    uint32_t compat_host_pvr;
     PowerPCCPUClass *pvr_pcc;
 
+    compat_host_pvr = kvm_ppc_host_compat_pvr();
+    if (compat_host_pvr) {
+        host_pvr = compat_host_pvr;
+    }
+
     pvr_pcc = ppc_cpu_class_by_pvr(host_pvr);
     if (pvr_pcc == NULL) {
         pvr_pcc = ppc_cpu_class_by_pvr_mask(host_pvr);
-- 
2.50.1 (Apple Git-155)

