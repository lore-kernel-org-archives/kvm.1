Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312FD3914E1;
	Wed, 13 May 2026 10:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778666948; cv=none; b=Ry+sxxwDGCBUMLJO0AiV23kT1Gx+9hTH3BKqKhHTS1iTTKsXCaYCVuMbtpT0yQtyJvhM31TbqLO5tW6iqCEeiZ4426TKmM/uUzxOCJblQow48dpR5DNeYWLFnMGNFynJfaQZdMVm18cWdJKUjwfOTotuw/hchjxSygmWO0Mhais=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778666948; c=relaxed/simple;
	bh=hoiPVbgXJJKMMufq/BBPcVTOGtHTK78y6E97QfH2KN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YU+0xKecyo12vwV5DG0pnPBAZKJ4yL8fQp7axnad0gGuryWbrvWLx97lcSZ3HvhLyGAbq5oeVlzW1QC2mGnBeK1a44eXzvI6JssG1knwA+lx35Adhqg0fkwV/w/okN035n35OBA+g89hnny+18ZvS/RWhO1IYgOTY9fQoRNfiro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oYJ0vw8J; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oYJ0vw8J"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D20Di93179810;
	Wed, 13 May 2026 10:08:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/9IiKZksxGmIbh6Xg
	yZTZodERudGux8RFDGSWVKLUgU=; b=oYJ0vw8JQ4HjwwLG9PgAmGD6BrmSzUd5l
	MVYLZDdXs7A69ApBr4HEbh4v2Q4sNgIuQ7Lic7mai3iQhrYm+ZTjWPEOMEvssyog
	JgCwHv4Nuc3vZMlRBQFoJ342DQdggIyA6bbIzUfQq+izhokI1vpW0QjCMa61Wb55
	6G9JCm34rs8pwVoSE3ebLfco2QGQtkxbgcdPyS9vD2SdraOHj5vz3s2/nctEH8Hq
	gFUbG8sQP0iEbzcSSji0xq2h/X/QBEgliAnVO0g1smYaI/mmHoBeI5dpbP+33X6j
	HH6ZpI46eGJ5gI0Cye9AusF/mqUDKuD0IjaoKi71M2eyPmWEl5jxA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6pua8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 10:08:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64D9sJXo019682;
	Wed, 13 May 2026 10:08:48 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgf9cn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 10:08:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64DA8jvI57016806
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 May 2026 10:08:45 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CB332005A;
	Wed, 13 May 2026 10:08:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 962162004F;
	Wed, 13 May 2026 10:08:43 +0000 (GMT)
Received: from mac.bl1-in.ibm.com (unknown [9.123.0.51])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 May 2026 10:08:43 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] KVM: PPC: Book3S HV: Add support for compat CPU capabilities for KVM on PowerNV
Date: Wed, 13 May 2026 15:37:53 +0530
Message-ID: <20260513100755.83215-5-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260513100755.83215-1-amachhiw@linux.ibm.com>
References: <20260513100755.83215-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Us1T8ewB c=1 sm=1 tr=0 ts=6a044db2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=LbGGMz8L2r-vpTRwWUsA:9
X-Proofpoint-GUID: t3sGPUW_HZjUI3MMceRlHMbGlDVN1Zh1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDEwNSBTYWx0ZWRfXz+3LoU3hVEmU
 MY/OzrmhZzmTRdOFw01JP0i1HVu+PxC4wqgjk4iRqwMVKhlac3Qj3B5bsipxRVyfYp5lx9E2tCo
 tjp8pxhevLR+8SlbPIN3V0pJfrcD3MzrlQjIMvQJRUHjPUzeR54LVB2lu75MW8Vv2iOBP+tkL1m
 XK92Y2rfkRCtTKEMnNTMq8Q1jtduHNwwGAIL7ZRRnzZjgpZxcRtW90Uz6yRfoKCiry+p3qHU0MW
 PKM7l7+qLf/xA4XA1fJtIyUvY+RHl4WBByBKuIxl1KWrwt8IdTxj1EXtl9w+yzsnJmII2hd/u9e
 fjfwcYUd80Bghf4u/OzKp4w7gQLGe/0NCX3dYdr6UGNFsf4XQmdkjslUFVRd9woP6kP96jtxZAw
 bM6ZXUw3pBuc6ViOXfYRzB7lhK94vvqcuh0FLbELKowcbOZ07t30xYKHBZMbBNzTVWhOiGCe//o
 uhM/SgLN6VcMz2lKK2w==
X-Proofpoint-ORIG-GUID: ZnjYOATTMb7OJJTQWTKWaU6X_W-Vy740
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130105

Currently, when booting a compatibility-mode KVM guest (L1) on a PowerNV
hypervisor (L0), the guest runs with the expected processor
compatibility level. However, when booting a nested KVM guest (L2)
inside the L1, QEMU derives the CPU model from the raw host PVR and
attempts to run the nested guest at that level, instead of honoring the
compatibility mode of the L1.

Extend host CPU compatibility capability reporting to support nested
virtualization on PowerNV systems (PAPR nested API v1).

For nested API v2 (PowerVM), compatibility capabilities are obtained
from the hypervisor via the H_GUEST_GET_CAPABILITIES hcall. This
information is not available on PowerNV systems.

For nested API v1, derive the compatibility capabilities from the L1
guest by reading the "cpu-version" property from the device tree, which
reflects the effective (logical) processor compatibility level. Map this
value to the corresponding compatibility capability bitmap.

Introduce a helper to translate CPU version values into compatibility
capability bits and integrate it into kvmppc_get_compat_cpu_caps().

This allows userspace to query host CPU compatibility modes on both
PowerVM and PowerNV platforms via the KVM_PPC_GET_COMPAT_CAPS ioctl.

Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 arch/powerpc/kvm/book3s_hv.c | 37 +++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 38de7040e2b7..18774c49af85 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -6522,15 +6522,50 @@ static bool kvmppc_hash_v3_possible(void)
 	return true;
 }
 
+static int kvmppc_map_compat_capabilities(const __be32 cpu_version,
+				      unsigned long *capabilities)
+{
+	switch (cpu_version) {
+	case PVR_ARCH_31_P11:
+		*capabilities |= H_GUEST_CAP_POWER11;
+		break;
+	case PVR_ARCH_31:
+		*capabilities |= H_GUEST_CAP_POWER10;
+		break;
+	case PVR_ARCH_300:
+		*capabilities |= H_GUEST_CAP_POWER9;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
 
 static int kvmppc_get_compat_cpu_caps(struct kvm_ppc_compat_caps *host_caps)
 {
+	struct device_node *np;
 	unsigned long capabilities = 0;
+	const __be32 *prop = NULL;
 	long rc = -EINVAL;
+	u32 cpu_version;
 
 	if (kvmhv_on_pseries()) {
-		if (kvmhv_is_nestedv2())
+		if (kvmhv_is_nestedv2()) {
 			rc = plpar_guest_get_capabilities(0, &capabilities);
+		} else {
+			for_each_node_by_type(np, "cpu") {
+				prop = of_get_property(np, "cpu-version", NULL);
+				if (prop) {
+					cpu_version = be32_to_cpup(prop);
+					break;
+				}
+			}
+			if (!prop)
+				return -EINVAL;
+			rc = kvmppc_map_compat_capabilities(cpu_version,
+								&capabilities);
+		}
 		host_caps->compat_capabilities = capabilities;
 	}
 
-- 
2.50.1 (Apple Git-155)

