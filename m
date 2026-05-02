Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D051A9F83
	for <kvm@vger.kernel.org>; Sat,  2 May 2026 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777730484; cv=none; b=mu/tKRcjcGy4E+YnoimNYV8j1WeFoOjyGb4K0qYn8sn7mbvnYkVNh92oxqfDCwQDDTpe22aIEI/Xxic6OXHLyoA3HBBAYK6hiT/kjWtqZhnHysTcUDFSmkR8ZHZ/qVLmXmuuvH1RjGXi6SKEKbH7IMeFcPFrsDM7/Cbc33iGkro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777730484; c=relaxed/simple;
	bh=VnJ2HQkm11FhVzgOIwwPOqEdzazHnDSUyHFap6d8AhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twzt3GwqUWzibMSA8RpN3RT/YpNj9vzUHw53evJJ7gNGZlRohzZbu/wjWLDXPtBSJgSsYFR0CXrCEJKyOjElKYBxAvI98V/6rt9hlx/Q8s99/0OxX6yyKagXWCVtatNjmQZuCLBVFQoTW2jjJEOWI0lB9+Io4wi63SQhT9zE+/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ISx8V8jw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ISx8V8jw"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 642Di3W63887449;
	Sat, 2 May 2026 14:01:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rOIu87FgwaCWUbRmw
	1EvAvFLxCHYHpiTW7ufaEC6/kw=; b=ISx8V8jwqtOQS3lG49hlcsf014fxwcM5d
	3aCl/4eRengaaqP5Wote9rGExu4gnbt5tihAiSVq02f92H809dvH5GG/uZRWnNB0
	+0jo8/JvIDlyYD6iv1zYKUpnXieTAMx0J1mfqRhVnrb2mM83ujfWe12AqHYtNCwN
	CJuh2v/XBZ5Op1iLYVsDuagjbAMZjRnW5lwpisWuc6xdq/fOcE5Myq+XK5WKl9k7
	92ffc5YCBmLeMIPtszXOlcSVliyxCh6IdbaRw7UTnH/gj9l9bX9WFIiuWjhkjdD1
	/B9scgN3zPt4jsn3SOySmI4bnCCQP0sCQyrEKmq3YZZYVxn+Tq8vw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9xx9335-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 May 2026 14:01:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 642DsUjm028219;
	Sat, 2 May 2026 14:01:07 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dw9jy9asp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 May 2026 14:01:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 642E138s50200952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 2 May 2026 14:01:03 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A82FB20043;
	Sat,  2 May 2026 14:01:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0763F20040;
	Sat,  2 May 2026 14:01:00 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.223.28])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  2 May 2026 14:00:59 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] [DO_NOT_MERGE] linux-headers: Add uapi header changes
Date: Sat,  2 May 2026 19:30:20 +0530
Message-ID: <20260502140021.69712-3-amachhiw@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAyMDEzNiBTYWx0ZWRfX2tt3AADlODFp
 cfIDmzjpVmQSQPa+D9yS/XZ7wihAmZXlqVPgGK9OqHtucAofNhmjxT876QibzERN0/gIqdKzK3i
 xjwtajsVkN50bVgmDqXbbgvIkpkp2dLiXcxMBYDRrmn+z4SV9Jae2CG3FdC0XDluGMWaJ7fjdnS
 HdmEePFzO3E+jt4DX0sj5yRewK4P3ZuKe7obJa9PGYCd4QyeltI7dUh1KDCQTzmPI4cPXl2rMMV
 u8vAMRiqHz2GPx/YLgkwDZxL+ubDLFnHxKDuhSdDkyMCeT5XAcWRj+u8yacN2pu/o++EDIOmm/4
 QCd5vYqq6QsKOY/cmG2HJ1YjKZjhTUyRzJm/UPNdUJcsDHGO6ZNm+N5GSTmpwlOIJFzzJMVU9UZ
 gQfZj6M3u7gwPwOBHbgtpYTNvCc8xu9aI16T5JpIf31ldCc+u8IlqJ6azkaUU+RwWXcpU9Fxolp
 DPKl24u4nh+L2S8adHA==
X-Proofpoint-ORIG-GUID: gS_rdAeb1ha3SGIxcGd-Aseb8JP3SkPD
X-Proofpoint-GUID: 2N91-7y7aD6cbiNXukQXT06igeG6jui1
X-Authority-Analysis: v=2.4 cv=ctWrVV4i c=1 sm=1 tr=0 ts=69f603a4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=lArzyTj6eNMAAlWrubwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-02_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605020136

This is a temporary patch intended for review and testing purposes only.
It defines the new ioctls introduced for checking the compatibility
modes. The actual header changes are to be done once the kernel changes
[1] are merged.

[1] https://lore.kernel.org/all/20260430054906.94431-1-amachhiw@linux.ibm.com/

Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 linux-headers/asm-powerpc/kvm.h | 7 +++++++
 linux-headers/linux/kvm.h       | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/linux-headers/asm-powerpc/kvm.h b/linux-headers/asm-powerpc/kvm.h
index 077c5437f521..df91b1f40c5b 100644
--- a/linux-headers/asm-powerpc/kvm.h
+++ b/linux-headers/asm-powerpc/kvm.h
@@ -437,6 +437,13 @@ struct kvm_ppc_cpu_char {
 	__u64	behaviour_mask;		/* valid bits in behaviour */
 };
 
+/* For KVM_PPC_GET_COMPAT_CAPS */
+struct kvm_ppc_compat_caps {
+       __u32   flags;
+       __u64   compat_capabilities;    /* Capabilities supported by the host */
+};
+
+
 /*
  * Values for character and character_mask.
  * These are identical to the values used by H_GET_CPU_CHARACTERISTICS.
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index a4ab42dcba97..b0c0014a0a0a 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -966,6 +966,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_GUEST_MEMFD_FLAGS 244
 #define KVM_CAP_ARM_SEA_TO_USER 245
 #define KVM_CAP_S390_USER_OPEREXEC 246
+#define KVM_CAP_PPC_COMPAT_CAPS 249
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1295,6 +1296,8 @@ struct kvm_vfio_spapr_tce {
 /* Available with KVM_CAP_COUNTER_OFFSET */
 #define KVM_ARM_SET_COUNTER_OFFSET _IOW(KVMIO,  0xb5, struct kvm_arm_counter_offset)
 #define KVM_ARM_GET_REG_WRITABLE_MASKS _IOR(KVMIO,  0xb6, struct reg_mask_range)
+/* Available with KVM_CAP_PPC_COMPAT_CAPS */
+#define KVM_PPC_GET_COMPAT_CAPS          _IOR(KVMIO,  0xe4, struct kvm_ppc_compat_caps)
 
 /* ioctl for vm fd */
 #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct kvm_create_device)
-- 
2.50.1 (Apple Git-155)

