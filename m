Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE3C2C11D7
	for <kvm@vger.kernel.org>; Sat,  2 May 2026 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777730488; cv=none; b=cHY+PRXKBEXMiN/HN+sgkNYQEpH8uw+fo88i4H383+rHNjlhLqvp5+KvLcpUbInMgsGzi/uASsqIbS/UTxfzjgc+SQhdBvGONCx1NWk/Fdq0AK9yI5zT7VU6XcUYZkhNp/d6rutVuIldfQqavhKQ4Mubp+C/atVCstZG+7YUSOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777730488; c=relaxed/simple;
	bh=ABatvYN7yJ6AUBuodfA48XLMwtIMJjeft35lXjQjO40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D1iiKRP7vCqYpTxBHhWxu+xph+9x3Va8KMlgqtc7RiG8wqJUyrIThdhIUht5PbWHt9PaFuq1OEhFoUkc3JRubOKgU/x0hR/+gaEvEhXzQ+DxIXNHH2bHhurt/k7wJ/DIjUoHkNUyaW9ZB6D6sM6uFLAdXqh973YMtTeW3DSV9Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KGYHCjPD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KGYHCjPD"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64244bFj1989518;
	Sat, 2 May 2026 14:01:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gCcboTpeVtTJuxyfS
	5ABxK8gnTqsgHQ1afQby0lyAJk=; b=KGYHCjPDaKyLi6G5MeZC0pSDz6d0V2LI4
	pGw0khgluk4HM8Ky1/TJ/QDjB7ckAZvSahYC8rhabuHKnupTcaPb0KjzZd3ctpQH
	mUIRhbN+f64+jOIFdmsKjDWlERN2rq1awy51zLKn/fOtSFKA3cjCCpWH1ljz0M4X
	fLabJb5qP0RFiOSZCpwPbeROe4uYuOYqH6GqxXSxDCNNlarDH5MjXOcFCug8Df0l
	V27a39sguyY8dn/TQtveHLl+93luZbsTDKWlWIV6TmHa5p1hPKarNeaqQ2ced/Jw
	YO99tjEsrnINSwUKOjyirJigWbEmjX5KCWPxYeUtkNwEqAq0dSzNA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x494uy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 May 2026 14:01:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 642DsdgK012945;
	Sat, 2 May 2026 14:01:16 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dw9fs9bfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 May 2026 14:01:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 642E1Cb453412218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 2 May 2026 14:01:12 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 873A020043;
	Sat,  2 May 2026 14:01:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9B2220040;
	Sat,  2 May 2026 14:01:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.223.28])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  2 May 2026 14:01:08 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] target/ppc/kvm: Use host compatibility mode for nested guests
Date: Sat,  2 May 2026 19:30:21 +0530
Message-ID: <20260502140021.69712-4-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260502140021.69712-1-amachhiw@linux.ibm.com>
References: <20260502140021.69712-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAyMDEzNiBTYWx0ZWRfX8O0l7cwMaTck
 QsarJf4BDaI0450pJIvo/LTifCxdkmOzzDaHVb8G1hl22r9IRmAea4DRW4Dzx0/OZ9xUblHLIP8
 Yhzqv1W+b5qRKEPWvRVbmB7jyHaYzDkzUPplqGcc8TmVaKqP0wWU4EG2jWM3oi4GrReKQ6oMi6c
 xrA2eJsh2ZfEP55pnmqezLMTJqKH7oB12Q5e5BOOkXaBZaQolw3S/UIbMdfe1J0VIRxT3inZL5F
 mr69nWqIOVklR+xi0yEQPhdPLAAJaiw47u9kBxknVI6Bl+JhMq21xa+nMo1O4FB3PhX3OBX8/ak
 W5rei7mwjdxFe5IHHGPpcyKNpH37yH1Bb+7soet53Q6wiLZrxIXCWDbB6FIVkUs0s8+RvS3LDU3
 iK4svRSF0AzZ4b+GSDfm6tkn6YeAZnKF1BDSi5OPkQKIFphUl6lGyPiZk+fMXQkK1dgMRnllwQ3
 0UoCpu+otw0qBmX++yA==
X-Proofpoint-ORIG-GUID: 1OQ5RcboF0w4nC9TKv9WsVdRDdAq9lJt
X-Proofpoint-GUID: TLeF8EwYmnUnkwkRhrIQX90mz4FA1Cd_
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69f603ad cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=n0kojfgqO0W5ScNLDTQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-02_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605020136

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
 target/ppc/kvm.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 25c28ad089c6..7a00092c4208 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2602,11 +2602,68 @@ bool kvmppc_supports_ail_3(void)
     return cap_ail_mode_3;
 }
 
+#if defined(TARGET_PPC64)
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
+#endif /* TARGET_PPC64 */
+
 PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
 {
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

